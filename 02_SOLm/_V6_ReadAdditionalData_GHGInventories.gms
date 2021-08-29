PUTCLOSE con,"_V6_ReadAdditionalData_GHGInventories";

*GENERAL DESCRIPTION
*This file contains the code to read more detailed data for the GHG inventories of various countries


*DETAILED TABLE OF CONTENTS
$ontext;
- 1) GHG inventory of Austria
         1.1) Read new data
- 2) GHG inventory of Switzerland
         2.1) Read new data
- 3) GHG inventory of Germany
         3.1) Read new data
- 4) GHG inventory of Spain
         4.1) Read new data

$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) GHG inventory of Austria
*1.1) Read new data

Parameter AnimalNumbers_Austria(Livestock,AnimalTypeInHerd,ProductionConditions,Years);
Parameter EntericFermentation_MCF_Austria(Activities,AnimalTypeInHerd,Commodities);
Parameter MilkYields_Austria(Activities,AnimalTypeInHerd,Years);
Parameter GE_requirements_Austria(Livestock,AnimalTypeInHerd);
Parameter FeedingRations_Austria(Regions,Activities,AnimalTypeInHerd,Commodities);
Parameter Liveweight_Austria(Activities,AnimalTypeInHerd);
Parameter ManMan_QuantityShares_Austria(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem);
Parameter ManMan_MCF_Austria(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem);
Parameter N_Excretion_Austria(Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions);
Parameter ResidueShares_Austria(Activities);

$ifthen %IncludeExcel_ATData% == "YES"
$call GDXXRW GHGInventoryData_Austria.xlsx  o=GHGInventory_Austria.gdx  index=index!a1
$endif;

$GDXIN GHGInventory_Austria.gdx
$load AnimalNumbers_Austria
$load EntericFermentation_MCF_Austria
$load MilkYields_Austria
$load GE_requirements_Austria
$load FeedingRations_Austria
$load Liveweight_Austria

$load ManMan_QuantityShares_Austria
$load ManMan_MCF_Austria

$load N_Excretion_Austria

$load ResidueShares_Austria

$GDXIN GHGInventory_Austria.gdx

*no new numbers filed in for "producing animals", thus assure to not loose this default information from FAOSTAT:
Set NonProducingAnimals(AnimalTypeInHerd);
NonProducingAnimals(AnimalTypeInHerd) = AnimalTypeInHerd(AnimalTypeInHerd) - ProducingAnimals(AnimalTypeInHerd);

*partly the AnimalTypeInherd "AllAndAverageTypes" is filed in - but always equal to "Living" - and SOLm needs the latter only, thus delete the former:
AnimalNumbers_Austria(Livestock,"AllAndAverageTypes",ProductionConditions,Years) = 0;
*no new numbers filed in for "producing animals", thus assure to not loose this default information from FAOSTAT:
*thus use data for Set NonProducingAnimals(AnimalTypeInHerd) only;
*furthermore, new data only to be used for: cattle, pigs, goats, horses, sheep, game; for explanations, see the excel-file just filed in. Thus use the following set:
Set AnimalsForGHGInventAT_Numbers(Livestock)
/
cattle, chickens, goats, horses, pigs, sheep, game, turkeys, "Geese and guinea fowls", ducks
/;

VActAnimalsHead_QuantityActUnits.l("Austria",AnimalsForGHGInventAT_Numbers,NonProducingAnimals,"AllProdSyst",ProductionConditions)
         = AnimalNumbers_Austria(AnimalsForGHGInventAT_Numbers,NonProducingAnimals,ProductionConditions,"2011");


FeedingRationsHeads_OtherChar("Austria",Activities,AnimalTypeInHerd,Commodities,"Percentage GE in feed converted to enteric CH4","AllProdSyst", "AllProdCond")
         = EntericFermentation_MCF_Austria(Activities,AnimalTypeInHerd,Commodities);
*Asign to single commodities for the calculations with detailed feeding rations:
FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,Commodities_Feed_Grass,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,Commodities_Feed_Cereals,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,Commodities_Feed_OilCropsAndCakes,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,Commodities_Feed_Pulses,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,Commodities_Feed_Roots,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,Commodities_Feed_Sugar,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,Commodities_Feed_OthersPlants,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,Commodities_Feed_OthersAnimals,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Austria",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");


ActAnimalsHead_Outputs("Austria","Cattle",AnimalTypeInHerd,"Milk (t)","AllProdSyst","AllProdCond")
         = MilkYields_Austria("Cattle",AnimalTypeInHerd,"2011");

ActAnimalsHead_OtherChar("Austria",Livestock,AnimalTypeInHerd,"FeedGE_req_Total (MJ)","AllProdSyst","AllProdCond")
         = GE_requirements_Austria(Livestock,AnimalTypeInHerd);

FeedingRations_OtherChar("Austria",Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond")
         = FeedingRations_Austria("Austria",Activities,AnimalTypeInHerd,Commodities);

ActAnimalsHead_OtherChar("Austria",Activities,AnimalTypeInHerd,"Liveweight (t)","AllProdSyst","AllProdCond")
         = Liveweight_Austria(Activities,AnimalTypeInHerd);

*to be sure to not have any old numbers in the model, first set all to zero:
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
          = 0;
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
         = ManMan_QuantityShares_Austria("Austria",Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem);

*similar fro N-based shares:
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
          = 0;
*and assign N-based shares identical to VS-quantity shares - the AT-inventory does not differentiate this
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
         = Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions);


Manure_Management("Austria",Activities,AnimalTypeInHerd,"MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
         = 0;
Manure_Management("Austria",Activities,AnimalTypeInHerd,"MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
         = ManMan_MCF_Austria("Austria",Activities,AnimalTypeInHerd,"AllAndAverageTemp",ProductionSystems,ProductionConditions,ManureManSystem);


*we need a new subset to avoid loosing default data:
Set ActivitiesForNewCropResShareData(Activities)
/
Barley
Maize
Oats
Rye
Triticale
Spelt
Millet
"Beans, dry"
"Peas, dry"
"Vegetables, leguminous nes"
Lupins
"Beets for fodder"
"Sugar Beet"
"Maize, green"
"Vegetables, fresh nes"
Rapeseed
"Maize For Forage+Silage"
"Sunflower seed"
"Tobacco, unmanufactured"
"Temporary meadows and pastures"
"Permanent meadows and pastures"
/;
CropResidues_OtherChar("Austria",ActivitiesForNewCropResShareData,"Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond")
         = ResidueShares_Austria(ActivitiesForNewCropResShareData);


*for Austria, we add the ManManSyst "Deep bedding < 1 month" and "Deep bedding > 1 month"; they are available as set elements, but they are not used in the default data.
*these are the following parameters, some are already available:
$ontext;
"MCF: CH4 conversion factor (%)"                         available
"Bo: max. CH4 prod. cap. (m3CH4/kgVS)"                   available
"Manure man N volat (% of N in manure)"                  available
"Manure man N leach (% of N in manure)"                  available
"Manure man N2O dir (tN2O-N/tN)"                         new values from the inventory: 0.01 (table 189)
"Manure man N2O-N from N volat (tN/tN volat)"            new values: default IPCC 2006: 0.01
"Manure man N2O-N from N leach (tN/tN leach)"            new values: default IPCC 2006: 0.0075
"Manure man P loss as % of P in manure (%)"              new values: default as all other systems: 0.1
$offtext;

*thus assign all ManManParameters to them here, conditional on Manure Quantities managed in these systems being reported:
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.01;
*for poultry, the value 0.001 is retained (IPCC 2006, table 10-21)
Manure_Management("Austria",Poultry,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Poultry,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.001;
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Manure man N2O-N from N volat (tN/tN volat)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.01;
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Manure man N2O-N from N leach (tN/tN leach)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.0075;
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Manure man P loss as % of P in manure (%)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.1;

Manure_Management("Austria",Activities,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.01;
*for poultry, the value 0.001 is retained (IPCC 2006, table 10-21)
Manure_Management("Austria",Poultry,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Poultry,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.001;
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Manure man N2O-N from N volat (tN/tN volat)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.01;
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Manure man N2O-N from N leach (tN/tN leach)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.0075;
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Manure man P loss as % of P in manure (%)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.1;


Manure_Management("Austria",Activities,AnimalTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management("Austria",Activities,AnimalTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)","Solid storage","AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management("Austria",Activities,AnimalTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)","Solid storage","AllAndAverageTemp","AllProdSyst","AllProdCond");


*Just a remark: the AT inventory accounts calculates direct N losses from pastures, etc. under Manure Management, not under manure application to soils, as the IPCC does;
*but then REPORTS them under soil application, cf. AT GHG-Inventory 2019, p358, section 5.4.2.1.3


*For yard, we have used Drylots, the EF for those is low, in the inventory, see page 335, assume a simplified overall value of 0,0039 (cf. Table 190, mainly cattle, less pigs in this system)).
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Drylot","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Drylot","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.0039;



*For Austria, game is similar to sheep rather than horses (cf. Inventory, p316 oben)
*thus adjust characteristics to equal those of sheep
ActAnimalsHead_OtherChar("Austria","Game","AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar("Austria","Sheep","AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond");

ActAnimalsHead_Inputs("Austria","Game","AllAndAverageTypes","Drinking water (m3)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_Inputs("Austria","Sheep","AllAndAverageTypes","Drinking water (m3)","AllProdSyst","AllProdCond");


*Ash contents from GHG inventory, some averaged values from cattle types:
Manure_OtherChar("Austria","Cattle",CattleTypeInHerd,"Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.115;

*Digestability were different for some animals as well, thus adjust:
*for non dairy cattle, assuming some average of 74% (Table 184)
ActAnimalsHead_OtherChar("Austria","Cattle",CattleTypeInHerd,"Digestibility of Feed (%)","AllProdSyst","AllProdCond") = 74;
*for dairy: assume 70%
ActAnimalsHead_OtherChar("Austria","Cattle","Producing_Dairy_Cattle","Digestibility of Feed (%)","AllProdSyst","AllProdCond") = 70;

*N excretion in manure:
ActAnimalsHead_Outputs("Austria",Activities,AnimalTypeInHerd,"N in manure (tN)","AllProdSyst","AllProdCond")
         = N_Excretion_Austria(Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond");


*indirect N2O emissions from manure management, according to the AT GHG inventory 2019, page 335ff
*Volatilisation: on average, about 16% of N is lost due to volatilization (Table 191), thus assign:
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 16;
*the share lost as N2O are then default values from IPCC as already in SOLm.


*Leaching from Manure Management is assumed to be zero (p336)
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;


*min N fert quantities, take from GHG Inventory 2019, table 195:
VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")
         = 103690;
*min P fert quantities, take from Eurostat:
*2.29157 is the conversion from P to P2O5, 4500 t from Eurostat is in P
VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")
         = 13548*2.29157;

*emissions from cultivated organic soils are adapted according to the GHG inventory 2019, p 362:
*only grassland is on organic soils, thus set zero for cropland:
ActCropsGrass_OtherChar("Austria",Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Austria",Crops,"CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Austria",Crops,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Austria",Crops,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;

ActCropsGrass_OtherChar("Austria",CoreGrassActivities,"CultOrgSoils (ha)","AllProdSyst","AllProdCond") = 0;
VActCropsGrass_QuantityActUnits.l("Austria","Grass","AllProdSyst","AllProdCond")
         = sum(TempAndPermMeadAndPastures,VActCropsGrass_QuantityActUnits.l("Austria",TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond"));
ActCropsGrass_OtherChar("Austria",TempAndPermMeadAndPastures,"CultOrgSoils (ha)","AllProdSyst","AllProdCond")
                 $VActCropsGrass_QuantityActUnits.l("Austria","Grass","AllProdSyst","AllProdCond")
         = 12954
                 /VActCropsGrass_QuantityActUnits.l("Austria","Grass","AllProdSyst","AllProdCond");
*ActCropsGrass_OtherChar("Austria",CoreGrassActivities,"CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
*ActCropsGrass_OtherChar("Austria",CoreGrassActivities,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Austria",CoreGrassActivities,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Austria",TempAndPermMeadAndPastures,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 0.0082*44/28*298
                 *ActCropsGrass_OtherChar("Austria",TempAndPermMeadAndPastures,"CultOrgSoils (ha)","AllProdSyst","AllProdCond");

*the following is taken from AT inventory 2019, table 212:
ManureApplication("Austria",Crops,Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 16;
ManureApplication("Austria",TempAndPermMeadAndPastures,Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 16;
MinFertApplication("Austria",Crops,"mineral N fert (N)","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 6;
MinFertApplication("Austria",TempAndPermMeadAndPastures,"mineral N fert (N)","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 6;
CropResAndBiomassApplication("Austria",Crops,"All Residues","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 16;
CropResAndBiomassApplication("Austria",TempAndPermMeadAndPastures,"All Residues","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 16;

*the following is taken from AT inventory 2019, p366 FRAC_Leach:
ManureApplication("Austria",Crops,Livestock,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 15.15;
ManureApplication("Austria",TempAndPermMeadAndPastures,Livestock,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 15.15;
MinFertApplication("Austria",Crops,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 15.15;
MinFertApplication("Austria",TempAndPermMeadAndPastures,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 15.15;
CropResAndBiomassApplication("Austria",Crops,"All Residues","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 15.15;
CropResAndBiomassApplication("Austria",TempAndPermMeadAndPastures,"All Residues","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 15.15;


*no open burning in AT:
CropResidues_Management("Austria",Activities,"Average Residues (t)","Quantity share in CropResMan system","Left on croplands",ProductionSystems,"AllProdCond")
         = CropResidues_Management("Austria",Activities,"Average Residues (t)","Quantity share in CropResMan system","Left on croplands",ProductionSystems,"AllProdCond")
                 +CropResidues_Management("Austria",Activities,"Average Residues (t)","Quantity share in CropResMan system","Open burning",ProductionSystems,"AllProdCond");
CropResidues_Management("Austria",Activities,"Average Residues (t)","Quantity share in CropResMan system","Open burning",ProductionSystems,"AllProdCond") = 0;
*but adjust biogas and composting upwards:
*GHG inventory AT 2019, (table 202, table 209)
*compost reported in the inventory       1409   tN
*biogas digester                         8719   tN
*crop res as fert (SOLm):                 50650        tN
*thus, the share of compost and biogas in total residues is:
*share reported in the inventory:                 0,20
*thus assign quantity shares of about 3% to compost, 17% to biogas, rest to left on croplands (only for crops, keep grass as it is).
CropResidues_Management("Austria",Crops,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,"AllProdCond") = 0;
CropResidues_Management("Austria",Crops,"Average Residues (t)","Quantity share in CropResMan system","Biogas","AllProdSyst","AllProdCond") = 0.17;
CropResidues_Management("Austria",Crops,"Average Residues (t)","Quantity share in CropResMan system","Composting","AllProdSyst","AllProdCond") = 0.03;
CropResidues_Management("Austria",Crops,"Average Residues (t)","Quantity share in CropResMan system","Left on croplands","AllProdSyst","AllProdCond") = 0.8;
CropResidues_Management("Austria",Crops,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,"Convent","AllProdCond")
                 $(NOT CropResidues_Management("Austria",Crops,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,"Convent","AllProdCond"))
         = CropResidues_Management("Austria",Crops,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,"AllProdSyst","AllProdCond");
CropResidues_Management("Austria",Crops,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond")
                 $(NOT CropResidues_Management("Austria",Crops,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond"))
         = CropResidues_Management("Austria",Crops,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,"AllProdSyst","AllProdCond");


*Improve values for N-deposition in AT: do not use default from SOLm, but the following, from
*Statistik Austria 2010, Regionale Nährstoffbilanzen in Österreich für NUTS 3-Gebiete, p27:
ActCropsGrass_Inputs("Austria",Crops,"N deposition (tN)","AllProdSyst","AllProdCond") = 0.015;
ActForest_Inputs("Austria","Forest","N deposition (tN)","AllProdSyst","AllProdCond") = 0.015;
ActCropsGrass_Inputs("Austria","Temporary meadows and pastures","N deposition (tN)","AllProdSyst","AllProdCond") = 0.015;
ActCropsGrass_Inputs("Austria","Permanent meadows and pastures","N deposition (tN)","AllProdSyst","AllProdCond") = 0.015;




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) GHG inventory of Switzerland
*2.1) Read new data

Parameter AnimalNumbers_Switzerland(Livestock,AnimalTypeInHerd,ProductionConditions,Years);
Parameter EntericFermentation_MCF_Switzerland(Activities,AnimalTypeInHerd,Commodities);
Parameter MilkYields_Switzerland(Activities,AnimalTypeInHerd,Years);
Parameter GE_requirements_Switzerland(Livestock,AnimalTypeInHerd);
Parameter FeedingRations_Switzerland(Regions,Activities,AnimalTypeInHerd,Commodities);
Parameter Liveweight_Switzerland(Activities,AnimalTypeInHerd);
Parameter ManMan_QuantityShares_Switzerland(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,Years,ManureManSystem) VS-based quantity shares for Switzerland;
Parameter ManMan_QuantitySharesN_Switzerland(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,Years,ManureManSystem) N-based quantity shares for Switzerland - different than VS-based;
Parameter ManMan_MCF_Switzerland(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem);
Parameter Digestibility_Switzerland(Activities,AnimalTypeInHerd);
Parameter N_Excretion_Switzerland(Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions);
Parameter ResidueShares_Switzerland(Activities);


$ifthen %IncludeExcel_CHData% == "YES"
$call GDXXRW GHGInventoryData_Switzerland.xlsx  o=GHGInventory_Switzerland.gdx  index=index!a1
$endif;

$GDXIN GHGInventory_Switzerland.gdx
$load AnimalNumbers_Switzerland
$load EntericFermentation_MCF_Switzerland
$load MilkYields_Switzerland
$load GE_requirements_Switzerland
$load FeedingRations_Switzerland
$load Liveweight_Switzerland

$load ManMan_QuantityShares_Switzerland
$load ManMan_QuantitySharesN_Switzerland
$load ManMan_MCF_Switzerland
$load Digestibility_Switzerland

$load N_Excretion_Switzerland

$load ResidueShares_Switzerland

$GDXIN GHGInventory_Switzerland.gdx

*no new numbers filed in for "producing animals", thus assure to not loose this default information from FAOSTAT:
*thus use data for Set NonProducingAnimals(AnimalTypeInHerd) only;
*furthermore, new data only to be used for: cattle, pigs, goats, horses, sheep, game; for explanations, see the excel-file just filed in. Thus use the following set:
Set AnimalsForGHGInventCH_Numbers(Livestock)
/
cattle, pigs, goats, horses, sheep, game
/;

*partly the AnimalTypeInherd "AllAndAverageTypes" is filed in - but always equal to "Living" - and SOLm needs the latter only, thus delete the former:
AnimalNumbers_Switzerland(Livestock,"AllAndAverageTypes",ProductionConditions,Years) = 0;

VActAnimalsHead_QuantityActUnits.l("Switzerland",AnimalsForGHGInventCH_Numbers,NonProducingAnimals,"AllProdSyst",ProductionConditions)
         = AnimalNumbers_Switzerland(AnimalsForGHGInventCH_Numbers,NonProducingAnimals,ProductionConditions,"2011");
*use 2017-data for the zhaw no-imported-feed scenario: zhaw_NoFeedImports
*search label: switch on for Scenario "zhaw_NoFeedImports"
*         = AnimalNumbers_Switzerland(AnimalsForGHGInventCH_Numbers,NonProducingAnimals,ProductionConditions,"2017");
*data for poultry are about 14-19% higher as reported in the Inventory from 2020 (p586) in comparison to the numbers from the inventory 2019 (p571) - for all years since 2010 at least, where we checked.
*thus multiply chicken numbers by 1.16 to correct for this, but retain the FAO numbers for the other poultry types (as e.g. for turkey, there is no change in numbers).

*for the zhaw no-imported-feed scenario: zhaw_NoFeedImports, the following is NOT needed:
*search label: switch on for Scenario "zhaw_NoFeedImports"
VActAnimalsHead_QuantityActUnits.l("Switzerland","Chickens",NonProducingAnimals,"AllProdSyst",ProductionConditions)
         = VActAnimalsHead_QuantityActUnits.l("Switzerland","Chickens",NonProducingAnimals,"AllProdSyst",ProductionConditions)*1.16;

FeedingRationsHeads_OtherChar("Switzerland",Activities,AnimalTypeInHerd,Commodities,"Percentage GE in feed converted to enteric CH4","AllProdSyst", "AllProdCond")
         = EntericFermentation_MCF_Switzerland(Activities,AnimalTypeInHerd,Commodities);
*Asign to single commodities for the calculations with detailed feeding rations:
FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,Commodities_Feed_Grass,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,Commodities_Feed_Cereals,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,Commodities_Feed_OilCropsAndCakes,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,Commodities_Feed_Pulses,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,Commodities_Feed_Roots,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,Commodities_Feed_Sugar,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,Commodities_Feed_OthersPlants,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,Commodities_Feed_OthersAnimals,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");

ActAnimalsHead_Outputs("Switzerland","Cattle",AnimalTypeInHerd,"Milk (t)","AllProdSyst","AllProdCond")
         = MilkYields_Switzerland("Cattle",AnimalTypeInHerd,"2011");
*use 2017-data for the zhaw no-imported-feed scenario: zhaw_NoFeedImports
*search label: switch on for Scenario "zhaw_NoFeedImports"
*         = MilkYields_Switzerland("Cattle",AnimalTypeInHerd,"2017");

ActAnimalsHead_OtherChar("Switzerland",Livestock,AnimalTypeInHerd,"FeedGE_req_Total (MJ)","AllProdSyst","AllProdCond")
         = GE_requirements_Switzerland(Livestock,AnimalTypeInHerd);

FeedingRations_OtherChar("Switzerland",Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond")
         = FeedingRations_Switzerland("Switzerland",Activities,AnimalTypeInHerd,Commodities);

ActAnimalsHead_OtherChar("Switzerland",Activities,AnimalTypeInHerd,"Liveweight (t)","AllProdSyst","AllProdCond")
         = Liveweight_Switzerland(Activities,AnimalTypeInHerd);

*to be sure to not have any old numbers in the model, first set all to zero:
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
          = 0;
*we have data for 2010 and 2015, so do an average, weighted 80% 2010, 20% 2015
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
         = 0.8*ManMan_QuantityShares_Switzerland("Switzerland",Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,"2010",ManureManSystem)
                 + 0.2*ManMan_QuantityShares_Switzerland("Switzerland",Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,"2015",ManureManSystem);
*similarly for N-based shares:
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
          = 0;
*we have data for 2010 and 2015, so do an average, weighted 80% 2010, 20% 2015
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
         = 0.8*ManMan_QuantitySharesN_Switzerland("Switzerland",Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,"2010",ManureManSystem)
                 + 0.2*ManMan_QuantitySharesN_Switzerland("Switzerland",Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,"2015",ManureManSystem);


Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
         = 0;
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
         = ManMan_MCF_Switzerland("Switzerland",Activities,AnimalTypeInHerd,"AllAndAverageTemp",ProductionSystems,ProductionConditions,ManureManSystem);

ActAnimalsHead_OtherChar("Switzerland",Activities,AnimalTypeInHerd,"Digestibility of Feed (%)","AllProdSyst","AllProdCond")
         = Digestibility_Switzerland(Activities,AnimalTypeInHerd);

CropResidues_OtherChar("Switzerland",ActivitiesForNewCropResShareData,"Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond")
         = ResidueShares_Switzerland(ActivitiesForNewCropResShareData);


*for CH4 from ManMan: value for Bo for game is the same as for sheep (CH GHG inventory 2019, 294):
Manure_Management("Switzerland","Game","AllAndAverageTypes","Bo: max. CH4 prod. cap. (m3CH4/kgVS)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
         = Manure_Management("Switzerland","Sheep","AllAndAverageTypes","Bo: max. CH4 prod. cap. (m3CH4/kgVS)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions);


*Ash contents from GHG inventory is different than the IPCC default for producing dairy cattle, thus adjust:
Manure_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.09;

*EF for direct N2O from ManMan is as the default - besides liquid/slurry, where they work with one factor for both with/without crust, thus assume the same for these two systems:
*HOWEVER - for CH, we have anyway used only one of those two as a placeholder for both, namely Liquid/Slurry without natural crust cover, thus use only this one heee as well:
*Table 5-15, p299, GHG Inventory CH, 2019
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Liquid/Slurry without natural crust cover","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Liquid/Slurry without natural crust cover","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.002;

*and as for Austria, for Switzerland we add the ManManSyst "Deep bedding < 1 month" and "Deep bedding > 1 month"; they are available as set elements, but they are not used in the default data.
*these are the following parameters, some are already available:
$ontext;
"MCF: CH4 conversion factor (%)"                         available
"Bo: max. CH4 prod. cap. (m3CH4/kgVS)"                   available
"Manure man N volat (% of N in manure)"                  available
"Manure man N leach (% of N in manure)"                  available
"Manure man N2O dir (tN2O-N/tN)"                         new values from the inventory: 0.01 (table 189)
"Manure man N2O-N from N volat (tN/tN volat)"            new values: default IPCC 2006: 0.01
"Manure man N2O-N from N leach (tN/tN leach)"            new values: default IPCC 2006: 0.0075
"Manure man P loss as % of P in manure (%)"              new values: default as all other systems: 0.1
$offtext;

*volat / leach as % of N in manure is addressed further down, under "indirect emissions":

*thus assign all ManManParameters to them here, conditional on Manure Quantities managed in these systems being reported:
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.01;
*for poultry, the value 0.001 is retained (IPCC 2006, table 10-21)
Manure_Management("Switzerland",Poultry,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Poultry,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.001;
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man N2O-N from N volat (tN/tN volat)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.01;
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man N2O-N from N leach (tN/tN leach)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.0075;
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man P loss as % of P in manure (%)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.1;

Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.01;
*for poultry, the value 0.001 is retained (IPCC 2006, table 10-21)
Manure_Management("Switzerland",Poultry,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Poultry,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.001;
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man N2O-N from N volat (tN/tN volat)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.01;
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man N2O-N from N leach (tN/tN leach)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.0075;
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man P loss as % of P in manure (%)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.1;

Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)","Solid storage","AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)","Solid storage","AllAndAverageTemp","AllProdSyst","AllProdCond");

*N excretion in manure:
ActAnimalsHead_Outputs("Switzerland",Activities,AnimalTypeInHerd,"N in manure (tN)","AllProdSyst","AllProdCond")
         = N_Excretion_Switzerland(Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond");


*indirect N2O emissions from manure management, according to the CH GHG inventory 2019, page 302ff
*Volatilisation: on average, about 17.5% of N is lost due to volatilization, thus assign:
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 17.5;
*the share lost as N2O from N volatized are then as follows (p 302; table 5-15):
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man N2O-N from N volat (tN/tN volat)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.0256;

*Leaching from Manure Management is assumed to be zero (p290)
Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Switzerland",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;

*min N fert quantities, take from GHG Inventory 2019, table 5-22 (year 2011):
VMineralFertilizerQuantity.l("Switzerland","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")
         = 46730;

*emissions from cultivated organic soils are adapted according to the GHG inventory 2019, p 362 and tables CRF Table4.B and Table4.C: (areas refer to the year 2017)
*this is done as follows: Set total organic areas in relation to total areas - thus we have an organic soil area share
*then we have emissions per ha organic soil, this is then multiplied wiht the organic area share to get average emissions per any hectare:
*only grassland is on organic soils, thus set zero for cropland (which is not true, cf. vegetable production in the Seeland):
ActCropsGrass_OtherChar("Switzerland",Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Switzerland",Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond")
*         =10.53/395.62;
         =10.53/303.075;
*use the second assignment above, as the area 395'000 ha reported in the inventory also covers Kunstwiesen, which are not included in the cropland area of about 300'000 ha which we have.
*they are included in the total grassland area - but here (395 AND 1392, see below, Kunstwiesen seem to be included twice, as cropland plus grassland in total is about 1600'000 ha, not 1790'000 ha).
*cf. excel-file "SOLm-ConsistencyChecks", sheet "Areas_CH".

*ActCropsGrass_OtherChar("Switzerland",Crops,"CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
*ActCropsGrass_OtherChar("Switzerland",Crops,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Switzerland",Crops,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 0.008*44/28*298
                 *ActCropsGrass_OtherChar("Switzerland",Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond");

ActCropsGrass_OtherChar("Switzerland",CoreGrassActivities,"CultOrgSoils (ha)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Switzerland",TempAndPermMeadAndPastures,"CultOrgSoils (ha)","AllProdSyst","AllProdCond")
*         = 6.92/1392.49;
         = 6.92/1235.00;
*above, also use the area as reported for 2011, cf. excel-file "SOLm-ConsistencyChecks", sheet "Areas_CH"
*ActCropsGrass_OtherChar("Switzerland",CoreGrassActivities,"CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
*ActCropsGrass_OtherChar("Switzerland",CoreGrassActivities,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Switzerland",CoreGrassActivities,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Switzerland",TempAndPermMeadAndPastures,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 0.008*44/28*298
                 *ActCropsGrass_OtherChar("Switzerland",TempAndPermMeadAndPastures,"CultOrgSoils (ha)","AllProdSyst","AllProdCond");

*C emissions from organic soils:
ActCropsGrass_OtherChar("Switzerland",Crops,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 9.51*44/12
                 *ActCropsGrass_OtherChar("Switzerland",Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond");
ActCropsGrass_OtherChar("Switzerland",TempAndPermMeadAndPastures,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 9.06*44/12
                 *ActCropsGrass_OtherChar("Switzerland",TempAndPermMeadAndPastures,"CultOrgSoils (ha)","AllProdSyst","AllProdCond");


*the following is taken from CH inventory 2019, table 5-21:
ManureApplication("Switzerland",CoreGrassActivitiesNoTEMPGrass,Livestock,"AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = 0.0189;
*temporary meadows and pastures: same as for crops:
ManureApplication("Switzerland",TempAndPermMeadAndPastures,Livestock,"AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = 0.01;
MinFertApplication("Switzerland",Crops,"mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = 0.0098;
MinFertApplication("Switzerland",TempAndPermMeadAndPastures,"mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)","AllProdSyst","AllProdCond")
         = 0.0098;


*the following is taken from CH inventory 2019, p317, section 5.5.2.3.1:
*MUCH bigger than the IPCC-default - how this may be explained? cf. also for manure management, where these default emission factors are also much lower than in the inventory (cf. inventory 5.3.2.5.4)
ManureApplication("Switzerland",Crops,Livestock,"AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)","AllProdSyst","AllProdCond")
         = 0.0256;
ManureApplication("Switzerland",TempAndPermMeadAndPastures,Livestock,"AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)","AllProdSyst","AllProdCond")
         = 0.0256;
MinFertApplication("Switzerland",Crops,"mineral N fert (N)","N2O-N per kg N volatized from fert applic (share)","AllProdSyst","AllProdCond")
         = 0.0256;
MinFertApplication("Switzerland",TempAndPermMeadAndPastures,"mineral N fert (N)","N2O-N per kg N volatized from fert applic (share)","AllProdSyst","AllProdCond")
         = 0.0256;
CropResAndBiomassApplication("Switzerland",Crops,"All Residues","N2O-N per kg N volatized from fert applic (share)","AllProdSyst","AllProdCond")
         = 0.0256;
CropResAndBiomassApplication("Switzerland",TempAndPermMeadAndPastures,"All Residues","N2O-N per kg N volatized from fert applic (share)","AllProdSyst","AllProdCond")
         = 0.0256;

*the following is taken from CH GHG Inventory 2019, p318 ff, table 5-23
*for all factors: add the NOx to the NH3 factors that are presented separately in the invenotry (but all in percentagees N of total N applied)
*the following: take 2011 value on a lienar decline from 1990 24.2 to 2017 20.3:
ManureApplication("Switzerland",Crops,Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 20.99 + 0.55;
*for temporary grassland: use the cropland value, as this is not grazed:
ManureApplication("Switzerland","Temporary meadows and pastures",Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 20.99 + 0.55;
*the following: mean of the reported range:
ManureApplication("Switzerland","Permanent meadows and pastures",Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 4.85 + 0.55;
*the following: derived from shares of urea and ther min fert and corresponding volatilization: p315 ff
*(0,028*40200+0,13*6500)/(40200+6500) = 0,042197002
MinFertApplication("Switzerland",Crops,"mineral N fert (N)","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 4.2197002;
MinFertApplication("Switzerland",TempAndPermMeadAndPastures,"mineral N fert (N)","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 4.2197002;

*crop res: Invent CH 2019, p318:
CropResAndBiomassApplication("Switzerland",Crops,"All Residues","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 6 + 0.55;
CropResAndBiomassApplication("Switzerland",TempAndPermMeadAndPastures,"All Residues","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 6 + 0.55;

*CH GHG Inventory 2019, value for 2010, p322
ManureApplication("Switzerland",Crops,Livestock,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 17.8;
ManureApplication("Switzerland",TempAndPermMeadAndPastures,Livestock,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 17.8;
MinFertApplication("Switzerland",Crops,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 17.8;
MinFertApplication("Switzerland",TempAndPermMeadAndPastures,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 17.8;
CropResAndBiomassApplication("Switzerland",Crops,"All Residues","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 17.8;
CropResAndBiomassApplication("Switzerland",TempAndPermMeadAndPastures,"All Residues","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 17.8;

*Switzerland has partially quite different residue N contents data than the IPCC 2006 guidelines which are SOLm default, thus replace as follows:
*Swiss GHG inventory, version from April 2019, Table A-25 in the appendix
*there, the residue N contents is in kg N/kg DM, therefore to be multiplied with the residue DM contents, see also below (also taken from the Swiss inventory, same source as N contents)
*thus, the multiplication determining the value is always: "N cont in residue DM" * "residue DM contents"

CropResidues_Contents("Switzerland","Wheat","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")     = 0.0037*0.85;
CropResidues_Contents("Switzerland","Barley","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.0051*0.85;
CropResidues_Contents("Switzerland","Maize","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")     = 0.0086*0.85;
CropResidues_Contents("Switzerland","Oats","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")      = 0.0049*0.85;
CropResidues_Contents("Switzerland","Rye","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")       = 0.0036*0.85;
CropResidues_Contents("Switzerland","Triticale","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond") = 0.0039*0.85;
CropResidues_Contents("Switzerland","Millet","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.0196*0.85;

CropResidues_Contents("Switzerland",Pulses,"Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")= 0.0328*0.16;
CropResidues_Contents("Switzerland","Beans, dry","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")= 0.0353*0.85;
*"peas, dry" is not reported, but use the same as for "beans, dry"
CropResidues_Contents("Switzerland","Peas, dry","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")= 0.0353*0.85;
CropResidues_Contents("Switzerland","Soybeans","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")  = 0.0412*0.85;
*CropResidues_Contents("Switzerland",SOLmOld_ForReadingDataLeguminousVegetables,"Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.0412*0.85;
CropResidues_Contents("Switzerland","Lupins","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.0127*0.13;

CropResidues_Contents("Switzerland",StarchyRoots,"Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.0233*0.15;
CropResidues_Contents("Switzerland","Potatoes","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")  = 0.0127*0.13;
CropResidues_Contents("Switzerland","Sugar beet","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")= 0.022*0.15;

CropResidues_Contents("Switzerland",Fruits,"Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.004*0.17;
*do berries separately to category berries
CropResidues_Contents("Switzerland","Strawberries","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.006*0.2;
CropResidues_Contents("Switzerland","Raspberries","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.006*0.2;
CropResidues_Contents("Switzerland","Currants","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.006*0.2;
CropResidues_Contents("Switzerland","Blueberries","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.006*0.2;
CropResidues_Contents("Switzerland",Vegetables,"Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")  = 0.023*0.13;
CropResidues_Contents("Switzerland","Maize, green","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.019*0.32;
CropResidues_Contents("Switzerland","Rapeseed","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")        = 0.0071*0.85;
CropResidues_Contents("Switzerland","Sunflower seed","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")  = 0.015*0.6;
*tobacco, no residue DM cont - use same as non leguminous vegetables
CropResidues_Contents("Switzerland","Tobacco, unmanufactured","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")        = 0.0221*0.13;
CropResidues_Contents("Switzerland","Grapes","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")          = 0.006*0.2;

*we use "Pumpkins, squash and gourds" for "oil squash"
CropResidues_Contents("Switzerland","Pumpkins, squash and gourds","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.023*0.13;
*we use "Flax fibre and tow" for "oil flax"
CropResidues_Contents("Switzerland","Flax fibre and tow","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")  = 0.0071*0.85;
*we use "Hempseed" for "oil hemp"
CropResidues_Contents("Switzerland","Hempseed","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")        = 0.0106*0.85;
*residue N content missing, use the same as for "oil flax"
CropResidues_Contents("Switzerland","Hops","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")            = 0.0106*1.0;
*we use Stimulants_Spices for "medicinal plants and herbs"
*residue DM content missing, use the same as for "tobacco, unmanufactures" (green plant matter, not drying before harvest)),
*but adjust upwards, as the plants my are rather dryer:
CropResidues_Contents("Switzerland",StimulantsSpices,"Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.033*0.2;

*ASSIGN values for grass LATER
*VariousSources_GrassResidue_NContents(FAOSTAT_Countries,NON_FAOSTAT_GrassActivities,"Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.0091*0.32;

CropResidues_Contents("Switzerland","Beets for fodder","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.0233*0.15;
CropResidues_Contents("Switzerland","Maize for Forage+Silage","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")    = 0.0118*0.32;

*no open burning in CH:
CropResidues_Management("Switzerland",Activities,"Average Residues (t)","Quantity share in CropResMan system","Left on croplands",ProductionSystems,"AllProdCond")
         = CropResidues_Management("Switzerland",Activities,"Average Residues (t)","Quantity share in CropResMan system","Left on croplands",ProductionSystems,"AllProdCond")
                 +CropResidues_Management("Switzerland",Activities,"Average Residues (t)","Quantity share in CropResMan system","Open burning",ProductionSystems,"AllProdCond");
CropResidues_Management("Switzerland",Activities,"Average Residues (t)","Quantity share in CropResMan system","Open burning",ProductionSystems,"AllProdCond") = 0;
*but adjust biogas and composting upwards:
*GHG inventory CH 2019
*Commercial fertilizers are 52451 tN (table 5-24) and
*mineral fertilizers are 46739 tN (table 5-22)
*Thus, the organic commercial fertilizers compost and biogas slurry are together        5712        tN
*Crop residues accoding to SOLm are (crops)         12781        tN
*Thus, a share of        0,45        is accounted for by those; assume compost to biogas 1:3,
*thus assign quantity shares of about 0.11 to compost, 0.33 to biogas, rest to left on croplands (only for crops, keep grass as it is).
CropResidues_Management("Switzerland",Crops,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,"AllProdCond") = 0;
CropResidues_Management("Switzerland",Crops,"Average Residues (t)","Quantity share in CropResMan system","Biogas","AllProdSyst","AllProdCond") = 0.11;
CropResidues_Management("Switzerland",Crops,"Average Residues (t)","Quantity share in CropResMan system","Composting","AllProdSyst","AllProdCond") = 0.33;
CropResidues_Management("Switzerland",Crops,"Average Residues (t)","Quantity share in CropResMan system","Left on croplands","AllProdSyst","AllProdCond") = 0.56;


*Improve values for N-deposition in CH: do not use default from SOLm, but the following, from
*Augustin and Achermann 2012, Schweiz Z Forstwes 163 (2012) 9: 323–330, Fig 5 (values from 2007); use somewhat higher values to meet the balance values from the OECD N balance for deposition
ActCropsGrass_Inputs("Switzerland",Crops,"N deposition (tN)","AllProdSyst","AllProdCond") = 0.017;
ActForest_Inputs("Switzerland","Forest","N deposition (tN)","AllProdSyst","AllProdCond") = 0.017;
ActCropsGrass_Inputs("Switzerland","Temporary meadows and pastures","N deposition (tN)","AllProdSyst","AllProdCond") = 0.017;
ActCropsGrass_Inputs("Switzerland","Permanent meadows and pastures","N deposition (tN)","AllProdSyst","AllProdCond") = 0.017;


*N-fixation in CH overall is way too low if compared to the 34 kTN commonly reported; legume areas and their fixation seem ok, so no change there; but grassland fixation seems to low:
*we have an average yield of about 4tDM/ha (i.e. 16.6 t/ha in fresh matter) and fixation of 0.015tN/ha; according to GRUD 2017 (Grundlagen für die Düngung landwirtschaftlicher Kulturen in der Schweiz (GRUD), Kapitel 9: Düngung von Grasland),
*        for 13tDM/ha, 15% legume shares, one could expect about 0,078tN/ha fixation.
*having about a third of this yield, we thus correct the fixation from 0.015tN/ha to 0.025tN/ha.
*STRANGE WITH THIS: the old values work perfectly for AUSTRIA!!
ActCropsGrass_OtherChar("Switzerland",CoreGrassActivities,"N fixation per ton MainOutput1 (tN)","AllProdSyst","AllProdCond") = 0.025/16.6;



*To get the OECD-N-Balance of Switzerland right, we need to reduce grassland yields by about 20% (the calculations from the OECD-site have been corrected in december and result in considerably higher N-balances (due to lower outputs) than before, i.e. by about 25%;
*this seems mainly due to lower N from pastures, so try to correct for that:
*this is currently used in the zhaw scenarios
*thus, switch on for those only - till you have checked and corrected this more thoroughly!!
*TO DO: CHECK OECD N-balance for CH - changes in data for the results from may 2020 vs those from January 2021 (cf. above): try to get the details on Grassland N
*search label: switch on for Scenario "zhaw_NoFeedImports"

*ActCropsGrass_Outputs("Switzerland",GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond")
*         = ActCropsGrass_Outputs("Switzerland",GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond")
*                 *0.8;
*ActCropsGrass_Outputs("Switzerland",GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
*         = ActCropsGrass_Outputs("Switzerland",GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
*                 *0.8;





****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) GHG inventory of Germany
*3.1) Read new data

*Parameter AnimalNumbers_Switzerland(Livestock,AnimalTypeInHerd,ProductionConditions,Years);
Parameter EntericFermentation_MCF_Germany(Activities,AnimalTypeInHerd,Commodities);
Parameter MilkYields_Germany(Activities,AnimalTypeInHerd,Years);
*Parameter GE_requirements_Germany(Livestock,AnimalTypeInHerd); not needed currently - directly defined in the code below
*Parameter FeedingRations_Switzerland(Regions,Activities,AnimalTypeInHerd,Commodities);
*Parameter Liveweight_Germany(Activities,AnimalTypeInHerd); not needed currently - directly defined in the code below
Parameter ManMan_QuantityShares_Germany(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem) VS-based quantity shares for Germany;
*Parameter ManMan_QuantitySharesN_Switzerland(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,Years,ManureManSystem) N-based quantity shares for Switzerland - different than VS-based;
Parameter ManMan_MCF_Germany(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem);
*Parameter Digestibility_Germany(Activities,AnimalTypeInHerd); not needed currently - directly defined in the code below
*Parameter N_Excretion_Germany(Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions); not needed currently - directly defined in the code below
*Parameter ResidueShares_Switzerland(Activities);


$ifthen %IncludeExcel_GermanyData% == "YES"
$call GDXXRW GHGInventoryData_Germany.xlsx  o=GHGInventory_Germany.gdx  index=index!a1
$endif;

$GDXIN GHGInventory_Germany.gdx
*$load AnimalNumbers_Switzerland
$load EntericFermentation_MCF_Germany
$load MilkYields_Germany
*$load GE_requirements_Germany not needed currently - directly defined in the code below
*$load FeedingRations_Switzerland
*$load Liveweight_Germany   not needed currently - directly defined in the code below

$load ManMan_QuantityShares_Germany
*$load ManMan_QuantitySharesN_Switzerland
$load ManMan_MCF_Germany
*$load Digestibility_Germany  not needed currently - directly defined in the code below

*$load N_Excretion_Germany not needed currently - directly defined in the code below

*$load ResidueShares_Switzerland

$GDXIN GHGInventory_Germany.gdx


*min N fert quantities, take from GHG Inventory 2020, table 273 (year 2011):
VMineralFertilizerQuantity.l("Germany","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")
         = 1786500;

ActAnimalsHead_OtherChar("Germany","Cattle","Producing_dairy_Cattle","Liveweight (t)","AllProdSyst","AllProdCond") = 0.645;
ActAnimalsHead_OtherChar("Germany","Chickens","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond") = 0.00174;
ActAnimalsHead_OtherChar("Germany","Goats","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond") = 0.04;
ActAnimalsHead_OtherChar("Germany","Horses","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond") = 0.49;
ActAnimalsHead_OtherChar("Germany","Sheep","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond") = 0.05;

ActAnimalsHead_Outputs("Germany","Cattle",AnimalTypeInHerd,"Milk (t)","AllProdSyst","AllProdCond")
         = MilkYields_Germany("Cattle",AnimalTypeInHerd,"2011");

*digestibility - we have values of 70 for cattle and pigs, so we add the differentiation provided by the inventory 2020, table 243, some gross average over 2009-2013:
ActAnimalsHead_OtherChar("Germany","Cattle",CattleTypeInHerd,"Digestibility of Feed (%)","AllProdSyst","AllProdCond") = 73.4;
ActAnimalsHead_OtherChar("Germany","Cattle","Producing_dairy_Cattle","Digestibility of Feed (%)","AllProdSyst","AllProdCond") = 74.6;
ActAnimalsHead_OtherChar("Germany","Pigs",PigTypeInHerd,"Digestibility of Feed (%)","AllProdSyst","AllProdCond") = 84.8;


*Ash contents from GHG inventory (table 244) is different than the IPCC default for producing dairy cattle, other cattle, swine (for those numbers are given, not for the rest), thus adjust (gross average 2009-2013):
Manure_OtherChar("Germany","Cattle",CattleTypeInHerd,"Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.095;
Manure_OtherChar("Germany","Cattle","Producing_Dairy_Cattle","Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.087;
Manure_OtherChar("Germany","Pigs",PigTypeInHerd,"Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.056;

*N excretion - we have better numbers from the GHG inventory 2020, table 246, for the following animals (using gross averages over 2009-2013); for the rest we keep the default:
ActAnimalsHead_Outputs("Germany","Cattle","Producing_Dairy_Cattle","N in manure (tN)","AllProdSyst","AllProdCond") = 0.1173;
ActAnimalsHead_Outputs("Germany","Sheep","AllAndAverageTypes","N in manure (tN)","AllProdSyst","AllProdCond") = 0.0078;
*assume goats to be identical to sheep, scaled by the liveweights:
ActAnimalsHead_Outputs("Germany","Goats","AllAndAverageTypes","N in manure (tN)","AllProdSyst","AllProdCond") = 0.0078/0.05*0.04;
ActAnimalsHead_Outputs("Germany","Horses","AllAndAverageTypes","N in manure (tN)","AllProdSyst","AllProdCond") = 0.0488;
ActAnimalsHead_Outputs("Germany","Chickens","AllAndAverageTypes","N in manure (tN)","AllProdSyst","AllProdCond") = 0.00072;

*to be sure to not have any old numbers in the model, first set all to zero:
Manure_Management("Germany",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
          = 0;
Manure_Management("Germany",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
         = ManMan_QuantityShares_Germany("Germany",Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem);

*for CH4 from ManMan: value for Bo are adjusted according to tables 256/257 in GHG inventory 2020 (chicken: value for 2009-2013, rough average), only for those, where not the default values are used:
Manure_Management("Germany","Cattle",AnimalTypeInHerd,"Bo: max. CH4 prod. cap. (m3CH4/kgVS)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
                 $Manure_Management("Germany","Cattle",AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
         = 0.23;
Manure_Management("Germany","Pigs",AnimalTypeInHerd,"Bo: max. CH4 prod. cap. (m3CH4/kgVS)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
                 $Manure_Management("Germany","Pigs",AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
         = 0.3;
Manure_Management("Germany","Chickens",AnimalTypeInHerd,"Bo: max. CH4 prod. cap. (m3CH4/kgVS)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
                 $Manure_Management("Germany","Chickens",AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
         = 0.37;

*read manure man MCF for a subset of animals only and retain the default values for the others:
Set AnimalsForGHGInventGermany_ManManMCF(Livestock)
/
cattle, pigs, Chickens
/;
Manure_Management("Germany",AnimalsForGHGInventGermany_ManManMCF,AnimalTypeInHerd,"MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
         = 0;
Manure_Management("Germany",AnimalsForGHGInventGermany_ManManMCF,AnimalTypeInHerd,"MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions)
         = ManMan_MCF_Germany("Germany",AnimalsForGHGInventGermany_ManManMCF,AnimalTypeInHerd,"AllAndAverageTemp",ProductionSystems,ProductionConditions,ManureManSystem);

*forage crop areas seem way too high for 2011 / Baseline 2009-2013, thus adapt as follows, inspired from the areas provided by BioBam/UNISECO from Eurostat (Scenario FOFA_2012)
*        and from basic data on Germany as e.g. in Table 280 in the GHG inventory 2020: grass-clover, grass forage, etc. should amount to about 675'000, pasture to about 4'800'000 (assuming linear decline from 1990 to 2018):
*        thus, the cropland and permanet grassland area seems ok for 2011, but the forages are adapted as follows:
$ontext;
                                               FOFA_BAU_2012    (this is dependent on the ORIGINAL DEFAULT data, as it allocates the forage aeas of BioBam relatively to these original numbers, but that is ok
                                                                 we change the baseline so that it fits, baseline FOFA_BAU_2012 will then also be adapted)
Alfalfa For Forage+Silag        AllProdCond        5826
Clover For Forage+Silage        AllProdCond        32403
Beets For Fodder                AllProdCond        508

Temporary meadows and pastures  AllProdCond        375443
Permanent meadows and pastures  AllProdCond        6676632

Other grasses, for forage       AllProdCond        321771
Rye grass, for forage           AllProdCond        667562
$offtext;

VActCropsGrass_QuantityActUnits.l("Germany","Alfalfa For Forage+Silag","AllProdSyst","AllProdCond") = 5826;
VActCropsGrass_QuantityActUnits.l("Germany","Clover For Forage+Silage","AllProdSyst","AllProdCond") = 32403;
VActCropsGrass_QuantityActUnits.l("Germany","Beets For Fodder","AllProdSyst","AllProdCond") = 508;
VActCropsGrass_QuantityActUnits.l("Germany","Temporary meadows and pastures","AllProdSyst","AllProdCond") = 375443;
*thus, 262'000 are allocated to the following (to get these roughly 675'000 for forages - WITHOUT forage maize - as the latter seems ok.
VActCropsGrass_QuantityActUnits.l("Germany","Other grasses, for forage","AllProdSyst","AllProdCond") = 92000;
VActCropsGrass_QuantityActUnits.l("Germany","Rye grass, for forage","AllProdSyst","AllProdCond") = 170000;

*after this, we have a total of cropland = 11319411 ha and grassland = 5033643 ha.
*according to CRF Table 4.B and 4.C, cropland should be 12929770 ha, grassland 6798090, thus adjust all areas accordingly by scaling with these total values:
VActCropsGrass_QuantityActUnits.l("Germany",Crops,"AllProdSyst","AllProdCond")
         = VActCropsGrass_QuantityActUnits.l("Germany",Crops,"AllProdSyst","AllProdCond")*12929770/11319411;
VActCropsGrass_QuantityActUnits.l("Germany",TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond")
         = VActCropsGrass_QuantityActUnits.l("Germany",TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond")*6798090/5033643;

FeedingRationsHeads_OtherChar("Germany",Activities,AnimalTypeInHerd,Commodities,"Percentage GE in feed converted to enteric CH4","AllProdSyst", "AllProdCond")
         = EntericFermentation_MCF_Germany(Activities,AnimalTypeInHerd,Commodities);
*Asign to single commodities for the calculations with detailed feeding rations:
FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,Commodities_Feed_Grass,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,Commodities_Feed_Cereals,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,Commodities_Feed_OilCropsAndCakes,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,Commodities_Feed_Pulses,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,Commodities_Feed_Roots,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,Commodities_Feed_Sugar,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,Commodities_Feed_OthersPlants,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,Commodities_Feed_OthersAnimals,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar("Germany",Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");


*emissions from cultivated organic soils are adapted according to the GHG inventory 2020, p 510 ff
*this is done as follows: Set total organic areas in relation to total areas - thus we have an organic soil area share
*then we have emissions per ha organic soil, this is then multiplied wiht the organic area share to get average emissions per any hectare:
*this is done separately for croplands and grasslands
*areas for this are taken from the CRF Tables 4.B and 4.C
ActCropsGrass_OtherChar("Germany",Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Germany",Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond")
         = 347.11/12929.71;
ActCropsGrass_OtherChar("Germany",TempAndPermMeadAndPastures,"CultOrgSoils (ha)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Germany",TempAndPermMeadAndPastures,"CultOrgSoils (ha)","AllProdSyst","AllProdCond")
         = 983.92/6798.09;
*then the emissions (GHG inventory 2020, p 510):
ActCropsGrass_OtherChar("Germany",Crops,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Germany",Crops,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 0.0107*44/28*298
                 *ActCropsGrass_OtherChar("Germany",Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond");
ActCropsGrass_OtherChar("Germany",TempAndPermMeadAndPastures,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_OtherChar("Germany",TempAndPermMeadAndPastures,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 0.0023*44/28*298
                 *ActCropsGrass_OtherChar("Germany",TempAndPermMeadAndPastures,"CultOrgSoils (ha)","AllProdSyst","AllProdCond");

*C emissions from organic soils (EF taken from CRF Tables 4.B and 4.C):
ActCropsGrass_OtherChar("Germany",Crops,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 8.1*44/12
                 *ActCropsGrass_OtherChar("Germany",Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond");
ActCropsGrass_OtherChar("Germany",TempAndPermMeadAndPastures,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 6.74*44/12
                 *ActCropsGrass_OtherChar("Germany",TempAndPermMeadAndPastures,"CultOrgSoils (ha)","AllProdSyst","AllProdCond");

*indirect N2O emissions from volatilization and leaching/runoff, cf. inventory 2020, p 510/511:
*the following is taken from German GHG Inventory 2020, CRF Table 3.D, lines 31 ff
ManureApplication("Germany",Crops,Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 17;
*for temporary and permanent grassland: same value
ManureApplication("Germany",TempAndPermMeadAndPastures,Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 17;
MinFertApplication("Germany",Crops,"mineral N fert (N)","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 6;
MinFertApplication("Germany",TempAndPermMeadAndPastures,"mineral N fert (N)","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 6;

ManureApplication("Germany",Crops,Livestock,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 30;
ManureApplication("Germany",TempAndPermMeadAndPastures,Livestock,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 30;
MinFertApplication("Germany",Crops,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 30;
MinFertApplication("Germany",TempAndPermMeadAndPastures,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 30;
CropResAndBiomassApplication("Germany",Crops,"All Residues","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 30;
CropResAndBiomassApplication("Germany",TempAndPermMeadAndPastures,"All Residues","Leached N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = 30;


*Leaching from Manure Management is assumed to be zero (p490)
Manure_Management("Germany",Activities,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                  $Manure_Management("Germany",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;



$exit;








****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) GHG inventory of Spain
*4.1) Read new data

*Parameter AnimalNumbers_Switzerland(Livestock,AnimalTypeInHerd,ProductionConditions,Years);
Parameter EntericFermentation_MCF_Germany(Activities,AnimalTypeInHerd,Commodities);
Parameter MilkYields_Germany(Activities,AnimalTypeInHerd,Years);
*Parameter GE_requirements_Germany(Livestock,AnimalTypeInHerd); not needed currently - directly defined in the code below
*Parameter FeedingRations_Switzerland(Regions,Activities,AnimalTypeInHerd,Commodities);
*Parameter Liveweight_Germany(Activities,AnimalTypeInHerd); not needed currently - directly defined in the code below
Parameter ManMan_QuantityShares_Germany(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem) VS-based quantity shares for Germany;
*Parameter ManMan_QuantitySharesN_Switzerland(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,Years,ManureManSystem) N-based quantity shares for Switzerland - different than VS-based;
Parameter ManMan_MCF_Germany(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem);
*Parameter Digestibility_Germany(Activities,AnimalTypeInHerd); not needed currently - directly defined in the code below
*Parameter N_Excretion_Germany(Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions); not needed currently - directly defined in the code below
*Parameter ResidueShares_Switzerland(Activities);


$ifthen %IncludeExcel_GermanyData% == "YES"
$call GDXXRW GHGInventoryData_Spain.xlsx  o=GHGInventory_Spain.gdx  index=index!a1
$endif;

$GDXIN GHGInventory_Spain.gdx
*$load AnimalNumbers_Switzerland
$load EntericFermentation_MCF_Germany
$load MilkYields_Germany
*$load GE_requirements_Germany not needed currently - directly defined in the code below
*$load FeedingRations_Switzerland
*$load Liveweight_Germany   not needed currently - directly defined in the code below

$load ManMan_QuantityShares_Germany
*$load ManMan_QuantitySharesN_Switzerland
$load ManMan_MCF_Germany
*$load Digestibility_Germany  not needed currently - directly defined in the code below

*$load N_Excretion_Germany not needed currently - directly defined in the code below

*$load ResidueShares_Switzerland

$GDXIN GHGInventory_Germany.gdx













