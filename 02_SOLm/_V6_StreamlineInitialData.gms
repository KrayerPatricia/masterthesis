PUTCLOSE con,"_V6_StreamlineInitialData";

$ontext;
GENERAL DESCRIPTION

This file streamlines the initial data as produced by the SteeringFile1 and then collected in the following gdx-files:
'GeneralModelSets'
'GeneralModelParameters_Inputs'
'GeneralModelParameters_Outputs'
'GeneralModelParameters_OtherChar'
'GeneralModelParameters_Various'
'GeneralModelParameters_Auxiliary'
'GeneralModelVariables_ActivityQuantities'
'GeneralModelVariables_Inputs'
'GeneralModelVariables_Outputs'
'GeneralModelVariables_OtherChar'
'GeneralModelVariables_Various'
'GeneralModelVariables_Trade'
'GeneralModelVariables_CommodityTree'
'GeneralModelVariables_Auxiliary'
'FOFA2050_BioeSR15_Etc_Data_InModelRunEntities'

Going through these files,
         - several useless, unimportant or confusing assignments have been identified - these are dropped and partly replaced further down in this code file,
         - and several missing assignments have been identified and have been added

This file is then run before the gdx-files are read out for further use in SteeringFile2

In a later version of SOLm, one could incorporate all this directly in the preceding code files or change those such as to avoid the missing/useless assignments corrected here.

DETAILED TABLE OF CONTENTS
- 1) Streamline the data
         1.1)'GeneralModelSets'
         1.2)'GeneralModelParameters_Inputs'
         1.3)'GeneralModelParameters_Outputs'
         1.4)'GeneralModelParameters_OtherChar'
         1.5)'GeneralModelParameters_Various'
         1.6)'GeneralModelParameters_Auxiliary'
         1.7)'GeneralModelVariables_ActivityQuantities'
         1.8)'GeneralModelVariables_Inputs'
         1.9)'GeneralModelVariables_Outputs'
         1.10)'GeneralModelVariables_OtherChar'
         1.11)'GeneralModelVariables_Various'
         1.12)'GeneralModelVariables_Trade'
         1.13)'GeneralModelVariables_CommodityTree'
         1.14)'GeneralModelVariables_Auxiliary'
         1.15)'FOFA2050_BioeSR15_Etc_Data_InModelRunEntities'
$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Streamline the data:

*1.1)'GeneralModelSets'
*         Nothing to delete or add
*1.2)'GeneralModelParameters_Inputs'
*         Nothing to delete or add
*1.3)'GeneralModelParameters_Outputs'
*no yields for wool reported - thus derive from production and number of producing animals (these are available):
ActAnimalsHead_Outputs(Regions,Activities,"Wool producing","Wool (t)",ProductionSystems,ProductionConditions)
                 $VActAnimalsHead_QuantityActUnits.l(Regions,Activities,"Wool producing",ProductionSystems,ProductionConditions)
         = VActAnimalsHead_Outputs.l(Regions,Activities,"Wool producing","Wool (t)",ProductionSystems,ProductionConditions)
                 /VActAnimalsHead_QuantityActUnits.l(Regions,Activities,"Wool producing",ProductionSystems,ProductionConditions);

*1.4)'GeneralModelParameters_OtherChar'
ActAnimalsHead_OtherChar(Regions,Activities,"Honey Producing",OtherCharAnimals,ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,Activities,"Wax Producing",OtherCharAnimals,ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,Activities,"Offals Producing",OtherCharAnimals,ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,Activities,"Chickens Broilers IPCC2006",OtherCharAnimals,ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,Activities,"Hens >= 1y old IPCC2006",OtherCharAnimals,ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,Activities,"Other Chicken >= 1y old IPCC2006",OtherCharAnimals,ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,Activities,"Pullet - Chicken < 1y old IPCC2006",OtherCharAnimals,ProductionSystems,ProductionConditions) = 0;

ActAnimalsHead_OtherChar(Regions,"Cattle and buffaloes",AnimalTypeInHerd,"Digestibility of feed (%)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Poultry birds",AnimalTypeInHerd,"Digestibility of feed (%)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Sheep and goats",AnimalTypeInHerd,"Digestibility of feed (%)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Beef cattle",AnimalTypeInHerd,"Digestibility of feed (%)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Dairy cattle",AnimalTypeInHerd,"Digestibility of feed (%)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Chicken Layers",AnimalTypeInHerd,"Digestibility of feed (%)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Chicken Broilers",AnimalTypeInHerd,"Digestibility of feed (%)",ProductionSystems,ProductionConditions) = 0;

ActAnimalsHead_OtherChar(Regions,"Cattle and buffaloes",AnimalTypeInHerd,"UE_per_GE (share)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Poultry birds",AnimalTypeInHerd,"UE_per_GE (share)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Sheep and goats",AnimalTypeInHerd,"UE_per_GE (share)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Beef cattle",AnimalTypeInHerd,"UE_per_GE (share)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Dairy cattle",AnimalTypeInHerd,"UE_per_GE (share)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Chicken Layers",AnimalTypeInHerd,"UE_per_GE (share)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Chicken Broilers",AnimalTypeInHerd,"UE_per_GE (share)",ProductionSystems,ProductionConditions) = 0;

ActAnimalsHead_OtherChar(Regions,"Cattle and buffaloes",AnimalTypeInHerd,"Animal specific FeedGE cont (MJ/t)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Poultry birds",AnimalTypeInHerd,"Animal specific FeedGE cont (MJ/t)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Sheep and goats",AnimalTypeInHerd,"Animal specific FeedGE cont (MJ/t)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Beef cattle",AnimalTypeInHerd,"Animal specific FeedGE cont (MJ/t)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Dairy cattle",AnimalTypeInHerd,"Animal specific FeedGE cont (MJ/t)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Chicken Layers",AnimalTypeInHerd,"Animal specific FeedGE cont (MJ/t)",ProductionSystems,ProductionConditions) = 0;
ActAnimalsHead_OtherChar(Regions,"Chicken Broilers",AnimalTypeInHerd,"Animal specific FeedGE cont (MJ/t)",ProductionSystems,ProductionConditions) = 0;

ActAnimalsHead_OtherChar(Regions,"Pigs","AllAndAverageTypes","N in manure per ton liveweight (tN/t lw/y)",ProductionSystems,ProductionConditions) = 0;


*the following is missing - the data for the other crops is however also just a place holder - thus assign the same value here:
ActCropsGrass_OtherChar(Countries,"Miscanthus","Share organic in total area (share ha)","AllProdSyst","AllProdCond") = 0.01;

*delete the grass class values, as these are not activities but only used for reading grassland yield data from Erb et al. 2007
ActCropsGrass_OtherChar(Countries,"Miscanthus","Organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond") = 0.9;

ActCropsGrass_OtherChar(Countries,"Grassclass1","Organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass2","Organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass3","Organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass4","Organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond") = 0;

ActCropsGrass_OtherChar(Countries,"Grassclass1","Deforestation (ha)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass2","Deforestation (ha)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass3","Deforestation (ha)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass4","Deforestation (ha)","AllProdSyst","AllProdCond") = 0;

ActCropsGrass_OtherChar(Countries,"Grassclass1","CultOrgSoils (ha)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass2","CultOrgSoils (ha)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass3","CultOrgSoils (ha)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass4","CultOrgSoils (ha)","AllProdSyst","AllProdCond") = 0;

ActCropsGrass_OtherChar(Countries,"Grassclass1","CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass2","CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass3","CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass4","CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;

ActCropsGrass_OtherChar(Countries,"Grassclass1","CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass2","CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass3","CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass4","CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;

ActCropsGrass_OtherChar(Countries,"Grassclass1","CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass2","CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass3","CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar(Countries,"Grassclass4","CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;

*for the following, assume the same as for sugar cane:
ActCropsGrass_OtherChar(Countries,"Miscanthus","Soil water erosion (t soil lost)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Countries,"Sugar cane","Soil water erosion (t soil lost)","AllProdSyst","AllProdCond");
ActCropsGrass_OtherChar(Countries,"Miscanthus","Aggreg. Pest. use level (index)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Countries,"Sugar cane","Aggreg. Pest. use level (index)","AllProdSyst","AllProdCond");

*1.5)'GeneralModelParameters_Various'
*add P2O5 contents for Miscanthus, based on Jones and Walsh: Miscanthus: For energy and fibre, P contents is about 10% of N contents, i.e. 0.04% in DM; DM contents is about 50%, thus P is about 0.02%
*P2O5 is 2.29157*P, i.e. 0.02%*2.29157, i.e. 0.0002*2.29157:
Commod_Contents(Countries,"Miscanthus","P2O5 (t)","AllProdSyst","AllProdCond") = 0.0002*2.29157;

Commod_OtherChar(Countries,"Miscanthus","Util other (share)","AllProdSyst","AllProdCond") = 1;
Commod_OtherChar(Countries,"Temporary meadows and pastures","Util feed (share)","AllProdSyst","AllProdCond") = 1;
Commod_OtherChar(Countries,"Permanent meadows and pastures","Util feed (share)","AllProdSyst","AllProdCond") = 1;

*yet missing for the different grass activities, thus assign as follows:
CropResAndBiomassApplication(Countries,Activities,"All Residues","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
                 $(CropResAndBiomassApplication(Countries,Activities,"All Residues","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
                         AND (NOT CropResAndBiomassApplication(Countries,Activities,"All Residues","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")))
         = 0.01;

*assign crop res contents for miscanthus - where missing:
CropResidues_Contents(Countries,"Miscanthus","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Miscanthus","N (t)","AllProdSyst","AllProdCond");
CropResidues_Contents(Countries,"Miscanthus","Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Miscanthus","P2O5 (t)","AllProdSyst","AllProdCond");
CropResidues_Contents(Countries,"Miscanthus","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond")
                 $(NOT CropResidues_Contents(Countries,"Miscanthus","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Miscanthus","DM (t)","AllProdSyst","AllProdCond");

CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Quantity share in CropResMan system","All bioenergy","AllProdSyst","AllProdCond")
                 $(NOT CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Quantity share in CropResMan system","All bioenergy","AllProdSyst","AllProdCond"))
         = 1;
CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Quantity share in CropResMan system","All bioenergy","Convent","AllProdCond")
         = CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Quantity share in CropResMan system","All bioenergy","AllProdSyst","AllProdCond");
CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Quantity share in CropResMan system","All bioenergy","Organic","AllProdCond")
         = CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Quantity share in CropResMan system","All bioenergy","AllProdSyst","AllProdCond");

*from the SR15 data, we have the N for areas for miscanthus, but not N loss - thus derive as the difference between N contents before management and N for areas
CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Crop res man N loss (tN)","All bioenergy","AllProdSyst","AllProdCond")
         = CropResidues_Contents(Countries,"Miscanthus","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")
                 - CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Crop res N for areas (tN)","All bioenergy","AllProdSyst","AllProdCond");

*to assume something for P loss from miscanthus, do as follows:
CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Crop res man share P lost (tP2O5/tP2O5 in crop res)","All bioenergy","AllProdSyst","AllProdCond")
         = 0.9;
CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Crop res man P loss (tP2O5)","All bioenergy","AllProdSyst","AllProdCond")
         = CropResidues_Contents(Countries,"Miscanthus","Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond")
                 *CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Crop res man share P lost (tP2O5/tP2O5 in crop res)","All bioenergy","AllProdSyst","AllProdCond");
CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Crop res P for areas (tP2O5)","All bioenergy","AllProdSyst","AllProdCond")
         = CropResidues_Contents(Countries,"Miscanthus","Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond")
                 -CropResidues_Management(Countries,"Miscanthus","Average residues (t)","Crop res man P loss (tP2O5)","All bioenergy","AllProdSyst","AllProdCond");

*assign residue share 1: this then needs to be taken into account to NOT DOUBLE COUNT BIOMASS - as here, we need 100% of output is residues going to bioenergy
*        but this cannot be formalised as a share as it would be a share of infinity of zero main output.....
*        so we should CONSISTENTLY capture bioenergy via MainOutput utilisation as bioenergy with ZERO residues rather!!!
*TO BE DONE LATER!!!
CropResidues_OtherChar(Countries,"Miscanthus","Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond")
                 $(NOT CropResidues_OtherChar(Countries,"Miscanthus","Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond"))
         = 1;

ExtractionRate_CommodityTree(Countries,"Temporary meadows and pastures") = 1;
ExtractionRate_CommodityTree(Countries,"Permanent meadows and pastures") = 1;
ExtractionRate_CommodityTree(Countries,"Miscanthus") = 1;


Manure_Management(Regions,"Poultry birds",AnimalTypeInHerd   ,"MCF: CH4 conversion factor (%)"             ,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions) = 0;
Manure_Management(Regions,"Beef cattle",AnimalTypeInHerd     ,"Manure man N2O dir (tN2O-N/tN)"             ,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions) = 0;
Manure_Management(Regions,"Dairy cattle",AnimalTypeInHerd    ,"Manure man N2O-N from N volat (tN/tN volat)",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions) = 0;
Manure_Management(Regions,"Chicken Layers",AnimalTypeInHerd  ,"Manure man N2O-N from N leach (tN/tN leach)",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions) = 0;
Manure_Management(Regions,"Chicken Broilers",AnimalTypeInHerd,"Manure man P loss as % of P in manure (%)"  ,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions) = 0;

Manure_OtherChar(Regions,"Cattle and buffaloes",AnimalTypeInHerd,"Ash content in feed DM (share)",ProductionSystems,ProductionConditions) = 0;
Manure_OtherChar(Regions,"Poultry birds"       ,AnimalTypeInHerd,"Ash content in feed DM (share)",ProductionSystems,ProductionConditions) = 0;
Manure_OtherChar(Regions,"Sheep and goats"     ,AnimalTypeInHerd,"Ash content in feed DM (share)",ProductionSystems,ProductionConditions) = 0;
Manure_OtherChar(Regions,"Beef cattle"         ,AnimalTypeInHerd,"Ash content in feed DM (share)",ProductionSystems,ProductionConditions) = 0;
Manure_OtherChar(Regions,"Dairy cattle"        ,AnimalTypeInHerd,"Ash content in feed DM (share)",ProductionSystems,ProductionConditions) = 0;
Manure_OtherChar(Regions,"Chicken Layers"      ,AnimalTypeInHerd,"Ash content in feed DM (share)",ProductionSystems,ProductionConditions) = 0;
Manure_OtherChar(Regions,"Chicken Broilers"    ,AnimalTypeInHerd,"Ash content in feed DM (share)",ProductionSystems,ProductionConditions) = 0;

MinFertApplication(Countries,"Temporary meadows and pastures"                      ,"Mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond") = 0.01;
MinFertApplication(Countries,"Permanent meadows and pastures"                      ,"Mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond") = 0.01;
MinFertApplication(Countries,"alpine pastures"                                     ,"Mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond") = 0.01;
MinFertApplication(Countries,"Perm. meadows & pastures - Cultivated"               ,"Mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond") = 0.01;
MinFertApplication(Countries,"Perm. meadows & pastures - Nat. growing"             ,"Mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond") = 0.01;
MinFertApplication(Countries,"Perm. meadows & pastures Cult. non-irrig"            ,"Mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond") = 0.01;
MinFertApplication(Countries,"Perm. meadows and pastures - Cult. & actually irrig" ,"Mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond") = 0.01;
MinFertApplication(Countries,"Temp. meadows & pastures non-irrig."                 ,"Mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond") = 0.01;
MinFertApplication(Countries,"Temp. meadows and pastures actually irrigated"       ,"Mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond") = 0.01;

ManureApplication(Regions,"Grassclass1",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;
ManureApplication(Regions,"Grassclass2",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;
ManureApplication(Regions,"Grassclass3",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;
ManureApplication(Regions,"Grassclass4",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;

ManureApplication(Regions,Activities,"Beehives"            ,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;
ManureApplication(Regions,Activities,"Cattle and buffaloes",AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;
ManureApplication(Regions,Activities,"Poultry birds"       ,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;
ManureApplication(Regions,Activities,"Sheep and goats"     ,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;
ManureApplication(Regions,Activities,"Beef cattle"         ,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;
ManureApplication(Regions,Activities,"Dairy cattle"        ,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;
ManureApplication(Regions,Activities,"Chicken Layers"      ,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;
ManureApplication(Regions,Activities,"Chicken Broilers"    ,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) = 0;


*XXXX ALTERNATIVE XXXX
*ManureApplication: besides the first entry, the values are NOT DIFFERENT for different animals - thus simplify by not having separate but only "All Animals" there.
*                 Then we have the ALTERNATIVE: it is as follows - and reduces entries from 5'000'000 to :
ManureApplication(Regions,Activities,"All Animals","AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = ManureApplication(Regions,Activities,"Cattle","AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond");
ManureApplication(Regions,Activities,"All Animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)"  ,"AllProdSyst","AllProdCond")
         = ManureApplication(Regions,Activities,"Cattle","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)"  ,"AllProdSyst","AllProdCond");
ManureApplication(Regions,Activities,"All Animals","AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)"    ,"AllProdSyst","AllProdCond")
         = ManureApplication(Regions,Activities,"Cattle","AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)"    ,"AllProdSyst","AllProdCond");
ManureApplication(Regions,Activities,"All Animals","AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)"      ,"AllProdSyst","AllProdCond")
         = ManureApplication(Regions,Activities,"Cattle","AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)"      ,"AllProdSyst","AllProdCond");
ManureApplication(Regions,Activities,"All Animals","AllAndAverageTypes","NH3-N as percentage of fertilizer N applied (%)"      ,"AllProdSyst","AllProdCond")
         = ManureApplication(Regions,Activities,"Cattle","AllAndAverageTypes","NH3-N as percentage of fertilizer N applied (%)"      ,"AllProdSyst","AllProdCond");

ManureApplication(Regions,Activities,Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond") = 0;
ManureApplication(Regions,Activities,Livestock,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)"  ,"AllProdSyst","AllProdCond") = 0;
ManureApplication(Regions,Activities,Livestock,"AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)"    ,"AllProdSyst","AllProdCond") = 0;
ManureApplication(Regions,Activities,Livestock,"AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)"      ,"AllProdSyst","AllProdCond") = 0;
ManureApplication(Regions,Activities,Livestock,"AllAndAverageTypes","NH3-N as percentage of fertilizer N applied (%)"      ,"AllProdSyst","AllProdCond") = 0;

*1.6)'GeneralModelParameters_Auxiliary'
*         Nothing to delete or add

*1.7)'GeneralModelVariables_ActivityQuantities'
*there is a number of grassland area data that may disrupt results, thus drop them:


VActCropsGrass_QuantityActUnits.l(Regions,"Perm. meadows & pastures - Cultivated",ProductionSystems,ProductionConditions) = 0;
VActCropsGrass_QuantityActUnits.l(Regions,"Perm. meadows & pastures - Nat. growing",ProductionSystems,ProductionConditions) = 0;
VActCropsGrass_QuantityActUnits.l(Regions,"Perm. meadows & pastures Cult. non-irrig",ProductionSystems,ProductionConditions) = 0;
VActCropsGrass_QuantityActUnits.l(Regions,"Perm. meadows and pastures - Cult. & actually irrig",ProductionSystems,ProductionConditions) = 0;
VActCropsGrass_QuantityActUnits.l(Regions,"Temp. meadows & pastures non-irrig.",ProductionSystems,ProductionConditions) = 0;
VActCropsGrass_QuantityActUnits.l(Regions,"Temp. meadows and pastures actually irrigated",ProductionSystems,ProductionConditions) = 0;




*1.8)'GeneralModelVariables_Inputs'
*         Nothing to delete or add

*1.9)'GeneralModelVariables_Outputs'
*the following has almost no data - thus drop
VActAnimalsHead_Outputs.l(Regions,Activities,AnimalTypeInHerd,"Offals (t)",ProductionSystems,ProductionConditions) = 0;

VActCropsGrass_Outputs.l(Countries,"Miscanthus","MainOutput1 (t)",ProductionSystems,ProductionConditions)
         = VActCropsGrass_QuantityActUnits.l(Countries,"Miscanthus",ProductionSystems,ProductionConditions)
                 *ActCropsGrass_Outputs(Countries,"Miscanthus","MainOutput1 (t)",ProductionSystems,ProductionConditions);

*1.10)'GeneralModelVariables_OtherChar'
*         Nothing to delete or add

*1.11)'GeneralModelVariables_Various'
VCommod_Other.l(Countries,"Miscanthus",ProductionSystems,ProductionConditions)
         = VActCropsGrass_Outputs.l(Countries,"Miscanthus","MainOutput1 (t)",ProductionSystems,ProductionConditions);

VCommod_Production.l(Countries,"Miscanthus",ProductionSystems,ProductionConditions)
         = VActCropsGrass_Outputs.l(Countries,"Miscanthus","MainOutput1 (t)",ProductionSystems,ProductionConditions);

*Again, derive DAQ total by the sum of the parts:
VCommod_Quantity.l(Countries,"Miscanthus",ProductionSystems,ProductionConditions)
         = VCommod_Feed.l(Countries,"Miscanthus",ProductionSystems,ProductionConditions)
                 + VCommod_Seed.l(Countries,"Miscanthus",ProductionSystems,ProductionConditions)
                 + VCommod_Food.l(Countries,"Miscanthus",ProductionSystems,ProductionConditions)
                 + VCommod_Waste.l(Countries,"Miscanthus",ProductionSystems,ProductionConditions)
                 + VCommod_Processing.l(Countries,"Miscanthus",ProductionSystems,ProductionConditions)
                 + VCommod_Other.l(Countries,"Miscanthus",ProductionSystems,ProductionConditions);

*1.12)'GeneralModelVariables_Trade'
*         Nothing to delete or add

*1.13)'GeneralModelVariables_CommodityTree'
*         Nothing to delete or add

*1.14)'GeneralModelVariables_Auxiliary'
*         Nothing to delete or add

*1.15)'FOFA2050_BioeSR15_Etc_Data_InModelRunEntities'
*drop regional yield data for bioenergy scenarios:
ActCropsGrass_Outputs_MR(BioeSR15_Region,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"BioeSR15_P4_2010") = 0;
ActCropsGrass_Outputs_MR(BioeSR15_Region,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050") = 0;
ActCropsGrass_Outputs_MR(BioeSR15_Region,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"BioeSR15_P4_2100") = 0;

*drop regional AUX_FeedSupply data for bioenergy scenarios:
AUX_FeedSupplyFactor_BioeSR15_MR(BioeSR15_Region,"BioeSR15_P4_2010") = 0;
AUX_FeedSupplyFactor_BioeSR15_MR(BioeSR15_Region,"BioeSR15_P4_2050") = 0;
AUX_FeedSupplyFactor_BioeSR15_MR(BioeSR15_Region,"BioeSR15_P4_2100") = 0;

*and also for crops grass inputs:
VActCropsGrass_Inputs_MR.l(BioeSR15_Region,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"BioeSR15_P4_2010") = 0;
VActCropsGrass_Inputs_MR.l(BioeSR15_Region,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050") = 0;
VActCropsGrass_Inputs_MR.l(BioeSR15_Region,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"BioeSR15_P4_2100") = 0;

*and also for crops grass outputs:
VActCropsGrass_Outputs_MR.l(BioeSR15_Region,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"BioeSR15_P4_2010") = 0;
VActCropsGrass_Outputs_MR.l(BioeSR15_Region,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050") = 0;
VActCropsGrass_Outputs_MR.l(BioeSR15_Region,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"BioeSR15_P4_2100") = 0;

*and also for crops grass areas:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops",ProductionSystems,ProductionConditions,"FOFA_BAU_2050") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2100") = 0;
*in particular for the sum "All crops"
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops",ProductionSystems,ProductionConditions,"FOFA_BAU_2050") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2100") = 0;

*AllProdSyst is not available for all activities, thus add:
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Rainfed",ProductionConditions,"FOFA_BAU_2050")
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Irrigated",ProductionConditions,"FOFA_BAU_2050");

*and also for forest areas:
VActForest_QuantityActUnits_MR.l(BioeSR15_Region,Activities,ProductionSystems,ProductionConditions,"BioeSR15_P4_2010") = 0;
VActForest_QuantityActUnits_MR.l(BioeSR15_Region,Activities,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050") = 0;
VActForest_QuantityActUnits_MR.l(BioeSR15_Region,Activities,ProductionSystems,ProductionConditions,"BioeSR15_P4_2100") = 0;

*delete region values also for energy quantities:
VEnergyProduction_MR.l(BioeSR15_Region,"Secondary energy",EnergyType,"Miscanthus",EnergyChar,"BioeSR15_P4_2010") = 0;
VEnergyProduction_MR.l(BioeSR15_Region,"Secondary energy",EnergyType,"Miscanthus",EnergyChar,"BioeSR15_P4_2050") = 0;
VEnergyProduction_MR.l(BioeSR15_Region,"Secondary energy",EnergyType,"Miscanthus",EnergyChar,"BioeSR15_P4_2100") = 0;
VEnergyProduction_MR.l(BioeSR15_Region,"Secondary energy",EnergyType,"Forest and crop residues",EnergyChar,"BioeSR15_P4_2010") = 0;
VEnergyProduction_MR.l(BioeSR15_Region,"Secondary energy",EnergyType,"Forest and crop residues",EnergyChar,"BioeSR15_P4_2050") = 0;
VEnergyProduction_MR.l(BioeSR15_Region,"Secondary energy",EnergyType,"Forest and crop residues",EnergyChar,"BioeSR15_P4_2100") = 0;


VPopulationNumbers_MR.l(BioeSR15_Region,PopulationGroups,"BioeSR15_P4_2010") = 0;
VPopulationNumbers_MR.l(BioeSR15_Region,PopulationGroups,"BioeSR15_P4_2050") = 0;
VPopulationNumbers_MR.l(BioeSR15_Region,PopulationGroups,"BioeSR15_P4_2100") = 0;




