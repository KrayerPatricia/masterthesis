PUTCLOSE con,"_V6_ReadData_VariousSources_FertilizerApplicationData";

$ontext;
GENERAL DESCRIPTION
This file reads and/or assigns the values for various parameters needed for fertilizer application nutrient losses and emissions calculations (i.e. to derive emissions, nutrients available, etc.)


DETAILED TABLE OF CONTENTS
- 1) Fertilizer application emissions from IPCC 2006
        1.1) direct emissions from fertilizer application
        1.2) indirect N2O emissions from fertilizer application: volatilisation and leaching
- 2) Assign values to core model parameters and variables
         2.1) Link some sets as needed
         2.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Fertilizer application emissions from IPCC 2006

*Now derive the emissions:
*Fertilizer application emissions
*IPCC 2006, Vol4, chapter 11:

*ATTENTION!!! skipping specific emissions from managed organic soils for now - to be improved later

*1.1) direct emissions from fertilizer application
*equation 11.1:
*N2O_N_direct = N2O_N_direct(N inputs on cropland) + N2O_N_direct(N in manure on pastures/rangeland/paddocks),
*N2O_N_direct(N inputs on cropland) = N(synth fert)*EF(synth fert) + N(org fert)*EF(org Fert) + N(crop residues)*EF(Crop residues)
*IPCC does not differentiate between these three fertilizer types, but it differentiates between rice and other crops)
*compost is currently subsumed under reisdues - via their management as compost
*crop residues covers above/below ground CR (including N fixed in N-fixing crops that are mulched, etc.)
*Manure is differentiated between Cattle, Chicken, Pigs CCP and Sheep, others, SO
*but for now, we just take one manure category and apply the CCP factor for SO as well for N2O_N_PerKgN
*Values: Table 11.1:


Set N_FromFertilizerType
/
N_FromMineralFert
N_FromResiduesAsFert
N_FromManureAsFert
/;

*unit: t N / t N
Parameter N2O_N_PerKgNFertilizerAppliedCropland_IPCC2006(FAOSTAT_CountriesAndRegions,N_FromFertilizerType);
Parameter N2O_N_PerKgNFertilizerAppliedLeftOnGrassland_IPCC2006(FAOSTAT_CountriesAndRegions,AnimalCategoriesInHerd_VariousSources,N_FromFertilizerType);

N2O_N_PerKgNFertilizerAppliedCropland_IPCC2006("World","N_FromMineralFert") = 0.01;
N2O_N_PerKgNFertilizerAppliedCropland_IPCC2006("World","N_FromResiduesAsFert") = 0.01;
N2O_N_PerKgNFertilizerAppliedCropland_IPCC2006("World","N_FromManureAsFert") = 0.01;

N2O_N_PerKgNFertilizerAppliedLeftOnGrassland_IPCC2006("World",AnimalCategoriesInHerd_IPCC2006,"N_FromManureAsFert") = 0.01;
*values for manure from cattle, chickens and pigs are higher:
N2O_N_PerKgNFertilizerAppliedLeftOnGrassland_IPCC2006("World","Dairy Cow IPCC2006","N_FromManureAsFert") = 0.02;
N2O_N_PerKgNFertilizerAppliedLeftOnGrassland_IPCC2006("World","Average Other Cattle IPCC2006","N_FromManureAsFert") = 0.02;
N2O_N_PerKgNFertilizerAppliedLeftOnGrassland_IPCC2006("World","Average Buffaloes IPCC2006","N_FromManureAsFert") = 0.02;
N2O_N_PerKgNFertilizerAppliedLeftOnGrassland_IPCC2006("World","Average Pig IPCC2006","N_FromManureAsFert") = 0.02;
N2O_N_PerKgNFertilizerAppliedLeftOnGrassland_IPCC2006("World","Average Chicken IPCC2006","N_FromManureAsFert") = 0.02;

*values for rice are different:
*Flooded rice is 0.003, default flooding period: 180 days, thus take the average, if not knowing better when it is fertilized;
*                but given the growth period is mainly when flooded, we assume 2/3 of fertilizer being applied then; thus not a factor of 1:1 but 2:1 for flooded EF).
*thus, for Rice, the value is:
*but we cannot assign this here as we do not have the crop dimension, thus do it further down.
*N2O_N_PerKgNFertilizerAppliedCropland_IPCC2006("World",N_FromFertilizerType) = (2*0.003 + 0.01)/3;


*1.2) indirect N2O emissions from fertilizer application: volatilisation and leaching
*eq. 11.9: N2O_N_indirect = N(synth fert)*Fraction that volatilises *EF_Volat + N(org fert + Manure on pastures)*Fraction that volatilises*EF_Volat
*eq. 11.10: N2O_N_indirect = N(all fert)*Fraction that leaches *EF_Leach
*values: table 11.3

*fraction that volatilises is:
*unit: percentage
Parameter Volatilisation_of_N_FromFertApplic_PercentageFromN_IPCC2006(FAOSTAT_CountriesAndRegions,N_FromFertilizerType);
*fraction that leaches is:
*unit: percentage
Parameter Leaching_of_N_FromFertApplic_PercentageFromN_IPCC2006(FAOSTAT_CountriesAndRegions,N_FromFertilizerType);

Volatilisation_of_N_FromFertApplic_PercentageFromN_IPCC2006("World","N_FromMineralFert") = 10;
Volatilisation_of_N_FromFertApplic_PercentageFromN_IPCC2006("World","N_FromResiduesAsFert") = 20;
Volatilisation_of_N_FromFertApplic_PercentageFromN_IPCC2006("World","N_FromManureAsFert") = 20;

Leaching_of_N_FromFertApplic_PercentageFromN_IPCC2006("World",N_FromFertilizerType) = 30;

*the emission factors are the following:
*unit: shares emitted, i.e. percentages/100 (i.e. 0.01 is 1%)
Parameter N2O_N_PerKgNVolatised_IPCC2006(FAOSTAT_CountriesAndRegions,N_FromFertilizerType);
Parameter N2O_N_PerKgNLeached_IPCC2006(FAOSTAT_CountriesAndRegions,N_FromFertilizerType);

N2O_N_PerKgNVolatised_IPCC2006("World",N_FromFertilizerType) = 0.01;
N2O_N_PerKgNLeached_IPCC2006("World",N_FromFertilizerType) = 0.0075;


$ontext;
after this, we have
Parameter N2O_N_PerKgNFertilizerAppliedCropland_IPCC2006(FAOSTAT_CountriesAndRegions,N_FromFertilizerType);
Parameter N2O_N_PerKgNFertilizerAppliedLeftOnGrassland_IPCC2006(FAOSTAT_CountriesAndRegions,AnimalCategoriesInHerd_IPCC2006,N_FromFertilizerType);
Parameter Volatilisation_of_N_FromFertApplic_PercentageFromN_IPCC2006(FAOSTAT_CountriesAndRegions,N_FromFertilizerType);
Parameter Leaching_of_N_FromFertApplic_PercentageFromN_IPCC2006(FAOSTAT_CountriesAndRegions,N_FromFertilizerType);
Parameter N2O_N_PerKgNVolatised_IPCC2006(FAOSTAT_CountriesAndRegions,N_FromFertilizerType);
Parameter N2O_N_PerKgNLeached_IPCC2006(FAOSTAT_CountriesAndRegions,N_FromFertilizerType);
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Assign values to core model parameters and variables
*2.1) Link some sets as needed

*no new set needed

*2.2) Link to the core model parameters

MinFertApplication(Countries,Crops,"mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = N2O_N_PerKgNFertilizerAppliedCropland_IPCC2006("World","N_FromMineralFert");
ManureApplication(Countries,Crops,Livestock,"AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = N2O_N_PerKgNFertilizerAppliedCropland_IPCC2006("World","N_FromManureAsFert");
CropResAndBiomassApplication(Countries,Crops,"All Residues","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = N2O_N_PerKgNFertilizerAppliedCropland_IPCC2006("World","N_FromResiduesAsFert");

*for grass, values from manure are somewhat differentiated, assign them directly:
ManureApplication(Countries,CoreGrassActivities,Livestock,"AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = 0.01;
*do not differentiate types in herd:
*ManureApplication(Countries,GrassActivities,"Cattle",CattleTypeInHerd,"N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
ManureApplication(Countries,CoreGrassActivities,"Cattle","AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = 0.02;
*do not differentiate types in herd:
*ManureApplication(Countries,GrassActivities,"Pigs",PigTypeInHerd,"N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
ManureApplication(Countries,CoreGrassActivities,"Pigs","AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = 0.02;

ManureApplication(Countries,CoreGrassActivities,"Chickens","AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = 0.02;
ManureApplication(Countries,CoreGrassActivities,"Buffaloes","AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = 0.02;


MinFertApplication(Countries,CropsAndCoreGrassActivities,"mineral N fert (N)","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = Volatilisation_of_N_FromFertApplic_PercentageFromN_IPCC2006("World","N_FromMineralFert");
MinFertApplication(Countries,CropsAndCoreGrassActivities,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = Leaching_of_N_FromFertApplic_PercentageFromN_IPCC2006("World","N_FromMineralFert");
MinFertApplication(Countries,CropsAndCoreGrassActivities,"mineral N fert (N)","N2O-N per kg N volatized from fert applic (share)","AllProdSyst","AllProdCond")
         = N2O_N_PerKgNVolatised_IPCC2006("World","N_FromMineralFert");
MinFertApplication(Countries,CropsAndCoreGrassActivities,"mineral N fert (N)","N2O-N per kg N leached from fert applic (share)","AllProdSyst","AllProdCond")
         = N2O_N_PerKgNLeached_IPCC2006("World","N_FromMineralFert");


ManureApplication(Countries,CropsAndCoreGrassActivities,Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = Volatilisation_of_N_FromFertApplic_PercentageFromN_IPCC2006("World","N_FromManureAsFert");
ManureApplication(Countries,CropsAndCoreGrassActivities,Livestock,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = Leaching_of_N_FromFertApplic_PercentageFromN_IPCC2006("World","N_FromManureAsFert");
ManureApplication(Countries,CropsAndCoreGrassActivities,Livestock,"AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)","AllProdSyst","AllProdCond")
         = N2O_N_PerKgNVolatised_IPCC2006("World","N_FromManureAsFert");
ManureApplication(Countries,CropsAndCoreGrassActivities,Livestock,"AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)","AllProdSyst","AllProdCond")
         = N2O_N_PerKgNLeached_IPCC2006("World","N_FromManureAsFert");


CropResAndBiomassApplication(Countries,CropsAndCoreGrassActivities,"All Residues","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = Volatilisation_of_N_FromFertApplic_PercentageFromN_IPCC2006("World","N_FromResiduesAsFert");
CropResAndBiomassApplication(Countries,CropsAndCoreGrassActivities,"All Residues","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = Leaching_of_N_FromFertApplic_PercentageFromN_IPCC2006("World","N_FromResiduesAsFert");
CropResAndBiomassApplication(Countries,CropsAndCoreGrassActivities,"All Residues","N2O-N per kg N volatized from fert applic (share)","AllProdSyst","AllProdCond")
         = N2O_N_PerKgNVolatised_IPCC2006("World","N_FromResiduesAsFert");
CropResAndBiomassApplication(Countries,CropsAndCoreGrassActivities,"All Residues","N2O-N per kg N leached from fert applic (share)","AllProdSyst","AllProdCond")
         = N2O_N_PerKgNLeached_IPCC2006("World","N_FromResiduesAsFert");


*and do rice separately, cf above, for rice:
*N2O_N_PerKgNFertilizerAppliedCropland_IPCC2006("World",N_FromFertilizerType) = (2*0.003 + 0.01)/3;
MinFertApplication(Countries,"Rice, paddy","mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = (2*0.003 + 0.01)/3;
ManureApplication(Countries,"Rice, paddy",Livestock,"AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = (2*0.003 + 0.01)/3;
CropResAndBiomassApplication(Countries,"Rice, paddy","All Residues","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = (2*0.003 + 0.01)/3;



$ontext;
After this we have the following in SOLm-entities:

ManureApplication(Countries,Activities,Livestock,"AllAndAverageTypes",FertApplicCharact,"AllProdSyst","AllProdCond")
CropResAndBiomassApplication(Countries,Activities,"All Residues",FertApplicCharact,"AllProdSyst","AllProdCond")
MinFertApplication(Countries,Activities,"mineral N fert (N)",FertApplicCharact,"AllProdSyst","AllProdCond")

Livestock is a dimension as the SOURCE of manure

Activities           is              all crops and core grass activities
FertApplicCharact    is              "N2O-N per kg fertilizer N applied (tN/tN)"
                                     "Volatized N as percentage of fertilizer N applied (%)"
                                     "Leached N as percentage of fertilizer N applied (%)"
                                     "N2O-N per kg N volatized from fert applic (share)"
                                     "N2O-N per kg N leached from fert applic (share)"
$offtext;





