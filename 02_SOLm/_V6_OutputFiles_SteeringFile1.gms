PUTCLOSE con,"_V6_OutputFiles_SteeringFile1";

$ontext;
GENERAL DESCRIPTION

*the following code produces the following gdx-files:

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

DETAILED TABLE OF CONTENTS
- 1) Output files
$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Output files

execute_unload 'GeneralModelSets'
InputsCropsGrass
InputsAnimals
InputsFishSeafood
InputsForest
InputsOther
OutputsCropsGrass
YieldsCropsGrass
OutputsAnimals
YieldsAnimals
OutputsFishSeafood
OutputsForest
OutputsOther
OtherCharCropsGrass
OtherCharCropsGrass_PerHaBased
OtherCharCropsGrass_PerTonYieldBased
OtherCharAnimals
OtherCharAnimals_PerHeadBased
OtherCharFishSeafood
OtherCharForest
OtherCharOther
AnimalTypeInHerd
AnimalTypeInHerd_NoAggregates
CattleTypeInHerd
DairyCattleTypeInHerd
BeefCattleTypeInHerd
PigTypeInHerd
ProducingAnimals
SuckledAnimals
AnimalTypeInHerd_2
MatchSucklingSuckledAnimals

ProductionSystems
ProdSyst_OrgConAll
ProdSyst_OrgCon
ProdSyst_NoAggregates
ProductionSystems_UsingMinNFert
ProductionSystems_UsingMinPFert
ProductionConditions
Contents
ContentsPerFreshMatterNutrients
ContentsPerFreshMatterFood
ContentsPerFreshMatterFeed
CommodOtherChar
UtilSharesNOTFeed
ManureOtherChar
CropResContents
CropResOtherChar
CropResManagement
CropResManagement_NotSystemShares
CropResManSystem
CropResManSystemCropland
CropResManSystemGrassland
CropResManSystem_WithVolatInApplication
CropResManSystemCropland_ForOECDNBalance
ManureContents
ManureManagement
ManureManSystem
ManureManSystemCropland
ManureManSystemGrassland
ManureManSystem_NoAverageNoTotal
FertApplicCharact

Regions
Regions_2
Countries

FAO_Africa
FAO_Eastern_Africa
FAO_Middle_Africa
FAO_Northern_Africa
FAO_Southern_Africa
FAO_Western_Africa
FAO_Americas
FAO_Northern_America
FAO_Central_America
FAO_Caribbean
FAO_South_America
FAO_Asia
FAO_Central_Asia
FAO_Eastern_Asia
FAO_Southern_Asia
FAO_SouthEastern_Asia
FAO_Western_Asia
FAO_Europe
FAO_Eastern_Europe
FAO_Northern_Europe
FAO_Southern_Europe
FAO_Western_Europe
FAO_Oceania
FAO_Australia_NewZealand
FAO_Melanesia
FAO_Micronesia
FAO_Polynesia
FAO_EuropeanUnion
SubSaharanAfrica
Match_GeographicAggregates_SingleCountries

FOFA2050_Rest_of_EAP
FOFA2050_Rest_of_HIC
FOFA2050_Rest_of_LAC
FOFA2050_Rest_of_MNA
FOFA2050_Rest_of_SAS
FOFA2050_Rest_of_SSA
FOFA2050_Rest_of_EU
FOFA2050_Rest_of_ECA
Regions_Switzerland
Regions_Austria
Regions_Austria_Tal
Regions_Austria_Huegel
Regions_Austria_Berg

*needed for UNISECO SESSIT tool
*put as comment if UNISECO-files are not run, as it causes an error otherwise
*NonEU_RestOfTheWorld

Activities
Activities_2
Livestock
Livestock_NoAggregates
Ruminants
Poultry
MonogastricsNonPoultry
FishAndSeafood
NonRuminants
Livestock_NoCoupledOutputs
Livestock_CoupledMeatMilk
Livestock_CoupledMeatEggs
Livestock_NonRuminantsWithHerdStructure
Crops
Cereals
Fruits
Treenuts
Pulses
Legumes_NFixing
Crops_NoNFixingLegumes
OilCrops
StarchyRoots
SugarCrops
Vegetables
StimulantsSpices
FibresRubber
Fallows
EnergyCrops
OtherCereals
CitrusFruits
Spices
OtherVegetables
OtherOilcrops
FibresNotCotton
ForageCrops
OtherFodderCrops
CoreFoodCrops
CoreFoodCrops_NoCereals
GrassActivities
CoreGrassActivities
CoreGrassActivitiesNoTEMPGrass
TempAndPermMeadAndPastures
TempMeadAndPastures
CropsAndCoreGrassActivities
CropsAndTempGrassActivities
SingleCropGrassAndLivestockActivities
FOFA2050_SweetPotato_And_Yams
FOFA2050_Rapeseed_And_Mustardseed
FOFA2050_OtherCrops
FOFA2050_OtherFibreCrops
FOFA2050_OtherFruits
FOFA2050_OtherOilseeds
FOFA2050_OtherRootsAndTubers
FOFA2050_OtherVegetables
FOFA2050_CitrusFruits
FOFA2050_DriedPulses
FOFA2050_OtherCereals
OtherCrops

Commodities
Commodities_2
ForageCommodities
Grasscommodities
ConcentrateCommodities
Commodities_SingleCommodities
Commodities_FeedGroups
Commodities_FeedGroups_DetailedFeedingRations
Commodities_FeedGroups_DetailedFeedingRations_NoTot
Commodities_Feed
Commodities_Feed_Grass
Commodities_Feed_NoForageNoGrass
Commodities_Feed_ForageCrops
Commodities_Feed_Cereals
Commodities_Feed_OilCropsAndCakes
Commodities_Feed_Pulses
Commodities_Feed_Roots
Commodities_Feed_Sugar
Commodities_Feed_OthersPlants
Commodities_Feed_OthersAnimals
Commodities_Feed_Residues
CommoditiesDAQ_TradeFromToWorld
CommoditiesDAQ_TradeFromToWorldPrimary
SET_Cereals_CommodityGroup
SET_FodderCrops_CommodityGroup
SET_Fruits_CommodityGroup
SET_Nuts_CommodityGroup
SET_Oilcrops_CommodityGroup
SET_OtherCrops_CommodityGroup
SET_Pulses_CommodityGroup
SET_RootsAndTubers_CommodityGroup
SET_Sugarcrops_CommodityGroup
SET_Vegetables_CommodityGroup
SET_Milk_CommodityGroup
SET_Meat_CommodityGroup
SET_Eggs_CommodityGroup
SET_FishSeafood_CommodityGroup
CommoditiesDAQ_TradeFromToWorldPrimaryCrops
COmmodities_EquivalentToNonGrassFedAnimalActivityOutput
CommoditiesDAQ_TradeFromToWorldPrimaryAnimals
CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed
CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NonGrassFed
CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_FishSeafood
CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary
CommoditiesDAQ_TradeFTWorldDirDerivedFromPrimary_Animals
CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed
CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed
CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts
CommoditiesDAQ_TradeFromToWorld_FishSeafood
MatchCommAct_CommoditiesDAQ_TradeFromToWorld_Crops
MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsPrimary
MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsDerived
MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_CropsDerived
MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_AnimalsDerived
MatchPrimDerivedCommodities_DAQ_TradeFTW_AnimalsDer_GrassFed
MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts
MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsPrimary
MatchCommAct_CommoditiesDAQ_TradeFTW_AnimalsPrimaryGrassFed
MatchCommAct_CommoditiesDAQ_TradeFTW_AnimPrimaryNonGrassFed
MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsDerived
MatchCommodTradeFromToWorld_CommodTradeBetweenCountries

*the following sets are also needed to read in data
Years
BasisyearsOLD
Basisyears
BasisyearsSeed
Temperatures
Temperatures0to100Celsius
TemperaturesBelow10
TemperaturesAbove28
GreenhouseGases

MineralFertilizerType
MineralFertilizerProdTech
MinFertChar
PopulationGroups
Humans_InputsOutputsOtherCharacteristics
FeedingRationOtherChar
MatchFaostatLiveAnimalItems_Activities
Match_ActivityOutputsToCommodities_Crops
Match_ActivityOutputsToCommodities_Animals
Match_FeedCommoditiesToFeedCommodGroups
Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc
Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio

ConversionLevel
EnergyType
EnergySource
EnergyChar

Scenarios
FOFA2050_Scenarios
BioeSR15_Scenarios

MatchCommAct_AggregateCommodities_Crops
MatchCommAct_AggregateActivities_Crops
MatchCommAct_WellDefinedCoProducts_Crops
MatchCommAct_ComplexCases_Crops
MatchCommAct_ComplexAnimalCommodities
MatchCommAct_CommodEquivalentAct_Crops
MatchCommAct_CommodEquivalentAct_Animals
MatchCommAct_CommodAndProductsEquivalentAct_Crops

SubsetCommod_MatchWithAct_AggregateCommodities
SubsetCommod_MatchWithAct_AggregateActivities
SubsetCommod_MatchWithAct_WellDefinedCoProducts
SubsetCommod_MatchWithAct_ComplexCases
SubsetCommod_MatchWithAct_ComplexAnimalCommodities
SubsetCommod_MatchWithAct_CommodEquivalentAct
SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct

SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Main
SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Co
SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level2_Main
SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level2_Co
MatchMainWithCoProd_WellDefinedCoProducts_Level1
MatchMainWithCoProd_WellDefinedCoProducts_Level2
MatchMainWithCoPr_WellDefCoProd_Level1And2_TwoByprod
Match_ShellsEtc_Activities

*needed for UNISECO SESSIT tool
*put as comment if UNISECO-files are not run, as it causes an error otherwise
*Match_Countries_NUTS2

NUTS2_Regions
;

execute_unload 'GeneralModelParameters_Inputs'
*1.1) Activities: input param
ActCropsGrass_Inputs
ActAnimalsAPU_Inputs
ActAnimalsHead_Inputs
ActFishSeafood_Inputs
ActForest_Inputs
ActOthers_Inputs
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-ActAnimalsHead_Inputs
         "Drinking water (m3)"     Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                 CattleTypeInHerd
                                                 PigTypeInherd
                                                 "AllAndAverageTypes"        "AllProdSyst"        "AllProdCond"      WITH CATTLE AND PIGS!!
         "Total GWP from CED (tCO2e)"
         "Total CED (MJ)"          Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                 CattleTypeInHerd
                                                 PigTypeInherd
                                                 "AllAndAverageTypes"        "AllProdSyst"
                                                                              "Convent"
                                                                              "Organic"           "AllProdCond"      WITH CATTLE AND PIGS!!
-ActCropsGrass_Inputs
         "N deposition (tN)"       Crops / temp/perm grass                   "AllProdSyst"        "AllProdCond"
         "Seeds (t)"               Crops (partly only)                       "AllProdSyst"        "AllProdCond"
         "Total GWP from CED (tCO2e)"
         "Total CED (MJ)           Crops / Core grass activities             "AllProdSyst"
                                       (No MISCANTHUS)                       "Convent"
                                                                             "Organic"            +AllProdCond"
-ActForest_Inputs
         "N deposition (tN)"       "Forest"                                    "AllProdSyst"        "AllProdCond"

$offtext;

execute_unload 'GeneralModelParameters_Outputs'
*1.2) Activities: output para
ActCropsGrass_Outputs
ActAnimalsAPU_Outputs
ActAnimalsHead_Outputs
ActFishSeafood_Outputs
ActForest_Outputs
ActOthers_Outputs
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-ActAnimalsAPU_Outputs
         "Honey (t)"               "Beehives       "Honey Producing"           "AllProdSyst"        "AllProdCond"
         "Wax (t)"                 "Beehives       "Wax Producing"             "AllProdSyst"        "AllProdCond"
-ActAnimalsHead_Outputs
                                 Livestock (NO dairy/beef cattle; layer/broiler chickens)
         "Milk (t"                                 "Milk Producing"            "AllProdSyst"        "AllProdCond"
         "Meat (t)"                                "Meat Producing"            "AllProdSyst"        "AllProdCond"
         "Eggs (t)"                                "Eggs Producing"            "AllProdSyst"        "AllProdCond"
         "HidesSkins (t)"                          "HidesSkins Producing"      "AllProdSyst"        "AllProdCond"
-ActCropsGrass_Outputs
         "MainOutput1 (t)"          Crops/ miscanth / temp/perm grass          "AllProdSyst"        "AllProdCond"
         "MainOutput1 (tDM)"        "Miscanthus" / temp/perm grass             "AllProdSyst"        "AllProdCond"
         "CH4 flooded rice (tCH4)"  "Rice, paddy"                              "AllProdSyst"        "AllProdCond"



$offtext;

execute_unload 'GeneralModelParameters_OtherChar'
*1.3) Activities: other chara
ActCropsGrass_OtherChar
ActAnimalsAPU_OtherChar
ActAnimalsHead_OtherChar
ActFishSeafood_OtherChar
ActForest_OtherChar
ActOthers_OtherChar
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-ActAnimalsHead_OtherChar
         "Organic yield gap (ratio org/conv yield"
                                 Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                 "Milk Producing"            "AllProdSyst        "AllProdCond"
                                                 "Meat Producing"            "AllProdSyst        "AllProdCond"
                                                 "Eggs Producing"            "AllProdSyst        "AllProdCond"
                                                 "HidesSkins Producing"      "AllProdSyst        "AllProdCond"
                                                 "Wool Producing"            "AllProdSyst        "AllProdCond"
         "Grass in feed DM (share)"
         "Forage crops in feed DM (share)"
         "Concentrates in feed DM (share)"
         "Residues in feed DM (share)"
         "UE_per_GE (share)"
         "Animal specific FeedGE cont (MJ/t)"
                                 Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                 "AllAndAverageTypes"        "AllProdSyst"        "AllProdCond"
         "Digestibility of feed (%)"
                                 Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                 CattleTypeInHerd
                                                 PigTypeInherd
                                                 "AllAndAverageTypes"        "AllProdSyst"        "AllProdCond"      WITH CATTLE AND PIGS!!
         "Liveweight (t)"
                                 "Cattle"          CattleTypeInHerd
                                 "Pigs"            PigTypeInherd
                                 Livestock (NO dairy/beef cattle; layer/broiler chickens) - NO CATTLE NO PIGS!!
                                                 "AllAndAverageTypes"        "AllProdSyst"        "AllProdCond"
         "FeedME_Req_Total (MJ)"
         "FeedXP_Req_Total (t)"
         "FeedGE_Req_Total (MJ)"
                                 "Cattle"          CattleTypeInHerd
                                 "Pigs"            PigTypeInherd
                                 Livestock (NO dairy/beef cattle; layer/broiler chickens) - NO CATTLE NO PIGS!!
                                                 "AllAndAverageTypes"        "AllProdSyst"        "AllProdCond"

         "FeedME_Req_MilkProd (MJ)"
         "FeedME_Req_Maintenance (MJ)"
         "FeedME_Req_Walking (MJ)"
         "FeedME_Req_Pregnancy (MJ)"
         "DailyWalkingDistance (km)"
         "Summergrazing (days)"
         "ME to produce 1kg milk (MJ/kg milk)"
         "ME maintenance per weight per day (MJ/kg liveweight/day)"
         "ME maintenance basis per day (MJ/day)"
         "ME walking per km (MJ/km)"
         "ME pregnancy per weight per day (MJ/kg liveweight/day)"
         "ME pregnancy basis per day (MJ/day)"
                                 "Cattle"
                                                 "Producing_Dairy_Cattle"  "AllProdSyst"        "AllProdCond"

         "XPperME_InFeedReq (gXP/MJ)"
                                 "Cattle"          CattleTypeInHerd        "AllProdSyst"        "AllProdCond"
                                 "Pigs"            PigTypeInherd           "AllProdSyst"        "AllProdCond"

         "Share organic in total animals (share heads)"
         "Share animal type in total living animals"
                                 Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                 "Living"                 "AllProdSyst"        "AllProdCond"      WITH CATTLE AND PIGS!!
                                                 CattleTypeInHerd         "AllProdSyst"        "AllProdCond"
                                                 PigTypeInherd            "AllProdSyst"        "AllProdCond"
                                                 "Milk Producing"         "AllProdSyst"        "AllProdCond"
                                                 "Meat Producing"         "AllProdSyst"        "AllProdCond"
                                                 "Eggs Producing"         "AllProdSyst"        "AllProdCond"
                                                 "HidesSkins Producing    "AllProdSyst"        "AllProdCond"
                                                 "Wool Producing"         "AllProdSyst"        "AllProdCond"


         "N in manure per ton liveweight (tN/t lw/y)"
         "P in manure per ton liveweight (tP2O5/t lw/y)"
                                 "Cattle"          CattleTypeInHerd
                                 "Pigs"            PigTypeInherd
                                 Livestock (NO dairy/beef cattle; layer/broiler chickens) - NO CATTLE NO PIGS!!
                                                 "AllAndAverageTypes"        "AllProdSyst"        "AllProdCond"
-ActCropsGrass_OtherChar
         "Share organic in total area (share ha)"
         "Organic yield gap (ratio org/conv yield)"
         "N fixation per ton MainOutput1 (tN)"
         "Deforestation (ha)"
         "CultOrgSoils (ha)"
         "CultOrgSoils GHG emissions (tCO2e)"
         "CultOrgSoils C emissions (tCO2e)"
         "CultOrgSoils N2O emissions (tCO2e)"
                                 All crops (incl. miscanth.) and grass           "AllProdSyst"        "AllProdCond"
         "Soil water erosion (t soil lost)"
         "Aggreg. Pest. use level (index)"
                                 Crops (incl. miscanth.) / temp/perm grass       "AllProdSyst"        "AllProdCond"
$offtext;


execute_unload 'GeneralModelParameters_Various'
*1.4) Commodities: nutrient contents
Commod_Contents
Commod_OtherChar

*1.5) Commodity tree paramete
Commod_ProductionShare
Commod_ExtractionRate
Commod_SingleInAggregateCommodShares

*1.6) Crop residues: nutrient
CropResidues_Contents
CropResidues_OtherChar
CropResidues_Management

*1.7) Feeding rations
FeedingRations_Contents
FeedingRations_OtherChar
FeedingRationsHeads_Contents
FeedingRationsHeads_OtherChar
FeedingRationsAPU_Contents

*1.8) Manure: nutrient conten
Manure_Contents
Manure_OtherChar
Manure_Management

*1.9) Fertilizer application:
ManureApplication
CropResAndBiomassApplication
MinFertApplication

*extraction rates:
ExtractionRate_CommodityTree
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-Commod_Contents
         "Calories (kcal)"
         "Protein (t)"
         "N (t)"
         "P2O5 (t)"
         "FeedME (MJ)"
         "FeedGE (MJ)"
         "FeedXP (t)"
         "DM (t)"
         "FeedME in DM (MJ)"
         "FeedGE in DM (MJ)"
         "FeedXP in DM (t)"
                                   All/most/many commodities (plant, animal)   "AllProdSyst"        "AllProdCond"
         "N in DM (t)"             "Miscanthus"                                "AllProdSyst"        "AllProdCond"
         "Milk solid contents (t)" "Milk, whole"                               "AllProdSyst"        "AllProdCond"

-Commod_OtherChar
         "Producer price ($)"      Many commodities (plant, animal; NO grass, miscanthus)
                                                                             "AllProdSyst"        "AllProdCond"
         "Util feed (share)"
         "Util food (share)"
         "Util seed (share)"
         "Util processing (share)"
         "Util waste (share)"
         "Util other (share)"
                                 All/most/many commodities (plant, animal); incl. grass, miscanthus
                                                                             "AllProdSyst"        "AllProdCond"
-CropResAndBiomassApplication
         "N2O-N per kg fertilizer N applied (tN/tN)"
         "Volatized N as percentage of fertilizer N applied (%)"
         "Leached N as percentage of fertilizer N applied (%)"
         "N2O-N per kg N volatized from fert applic (share)"
         "N2O-N per kg N leached from fert applic (share)"
         "NH3-N as percentage of fertilizer N applied (%)"
                                 ALL crop grass activities; incl. ALL grass types; miscanthus
                                                        "All Residues"         "AllProdSyst"        "AllProdCond"

-CropResidues_Contents
         "N (t) - before management"
         "P2O5 (t) - before management"
         "DM (t) - before management"
                                 Crops / temp/perm grass / miscanth
                                                        "Average residues (t)" "AllProdSyst"        "AllProdCond"

-CropResidues_Management
         "Quantity share in CropResMan system"
                                 Crops / temp/perm grass / miscanth
                                                        "Average residues (t)" CropResManSystems    "AllProdSyst/Con/org        "AllProdCond"
         "Crop res man CH4 (tCH4)"
         "Crop res man N2O (tN2O)"
                                 Crops (NO grass/miscanthus - as their systems come without losses; grass e.g. the N2O is from residues as fertilizers applied, not from residue management "left on the field")
                                                        "Average residues (t)" CropResManSystems    "AllProdSyst"               "AllProdCond"
         "Crop res man N loss (tN)"
         "Crop res man share P lost (tP2O5/tP2O5 in crop res)"
         "Crop res man P loss (tP2O5)"
                                 Crops / miscanth (NO grass - as their systems come without losses; grass e.g. the N2O is from residues as fertilizers applied, not from residue management "left on the field")
         "Crop res N for areas (tN)"
         "Crop res P for areas (tP2O5)"
                                 Crops / temp/perm grass / miscanth
                                                        "Average residues (t)" CropResManSystems    "AllProdSyst"               "AllProdCond"

-CropResidues_OtherChar
         "Residue share t DM / t DM MainOutput1 (share)"
                                 Crops / temp/perm grass / miscanth
                                                        "Average residues (t)" "AllProdSyst"        "AllProdCond"

-ExtractionRate_CommodityTree
                                 Crops / temp/perm grass (partly all grass) / miscanth

-FeedingRations_OtherChar
         "Quantity share in DM (share)"
                 "AggregateFeedConcentrates_Commodity"
                 "AggregateFeedForageCrops_Commodity"
                 "AggregateFeedGrass_Commodity"
                 "AggregateFeedResidues_Commodity"
                                 Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                 CattleTypeInHerd
                                                 PigTypeInherd
                                                 "AllAndAverageTypes"        "AllProdSyst"        "AllProdCond"      WITH CATTLE AND PIGS!!
-FeedingRationsHeads_OtherChar
         "Percentage GE in feed converted to enteric CH4"
                 "AggregateFeedConcentrates_Commodity"
                 "AggregateFeedForageCrops_Commodity"
                 "AggregateFeedGrass_Commodity"
                 "AggregateFeedResidues_Commodity"
                                 Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                 CattleTypeInHerd
                                                 PigTypeInherd
                                                 "AllAndAverageTypes"        "AllProdSyst"        "AllProdCond"      WITH CATTLE AND PIGS!!

-Manure_Management
         "Bo: max. CH4 prod. cap. (m3CH4/kgVS)"
                                "Cattle"         CattleTypeInHerd
                                "Pigs"           PigTypeInherd
                                Livestock (NO dairy/beef cattle; layer/broiler chickens) - NO CATTLE NO PIGS!!
                                                 "AllAndAverageTypes"        "AllManManSystems"    "AllAndAverageTemp"     "AllProdSyst"    "AllProdCond"
         "Quantity share in ManureMan system"
         "Quantity share in ManureMan syst - N-based"
         "Manure man N volat (% of N in manure)"
         "Manure man N leach (% of N in manure)"
         "Manure man NH3-N (% of N in manure)"
                                "Cattle"         CattleTypeInHerd
                                "Pigs"           PigTypeInherd
                                Livestock (NO dairy/beef cattle; layer/broiler chickens) - NO CATTLE NO PIGS!!
                                                 "AllAndAverageTypes"        ManureManSystem       "AllAndAverageTemp"     "AllProdSyst"    "AllProdCond"
         "MCF: CH4 conversion factor (%)"
         "Manure man N2O dir (tN2O-N/tN)"
         "Manure man N2O-N from N volat (tN/tN volat)"
         "Manure man N2O-N from N leach (tN/tN leach)"
         "Manure man P loss as % of P in manure (%)"
                                Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                 CattleTypeInHerd
                                                 PigTypeInherd
                                                 "AllAndAverageTypes"        ManureManSystem       "AllAndAverageTemp"     "AllProdSyst"    "AllProdCond"      WITH CATTLE AND PIGS!!

-Manure_OtherChar
         "Ash content in feed DM (share)"
                                Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                 CattleTypeInHerd
                                                 PigTypeInherd
                                                 "AllAndAverageTypes"        ManureManSystem       "AllAndAverageTemp"     "AllProdSyst"    "AllProdCond"      WITH CATTLE AND PIGS!!

-MinFertApplication
         "N2O-N per kg fertilizer N applied (tN/tN)"
         "Volatized N as percentage of fertilizer N applied (%)"
         "Leached N as percentage of fertilizer N applied (%)"
         "N2O-N per kg N volatized from fert applic (share)"
         "N2O-N per kg N leached from fert applic (share)"
         "NH3-N as percentage of fertilizer N applied (%)"
                                 ALL crop grass activities; incl. ALL grass types; miscanthus
                                                        "Mineral N fert (N)"         "AllProdSyst"        "AllProdCond"

-ManureApplication
         "N2O-N per kg fertilizer N applied (tN/tN)"
         "Volatized N as percentage of fertilizer N applied (%)"
         "Leached N as percentage of fertilizer N applied (%)"
         "N2O-N per kg N volatized from fert applic (share)"
         "N2O-N per kg N leached from fert applic (share)"
         "NH3-N as percentage of fertilizer N applied (%)"
                                 ALL crop grass activities; incl. ALL grass types; miscanthus
                                                        Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                                 "AllAndAverageTypes"         "AllProdSyst"        "AllProdCond"

   XXXX ALTERNATIVE XXXX
         ABOVE: besides the first entry, the values are NOT DIFFERENT for different animals - thus may simplify by not having separate but only "All Animals" there.
                 Then we have the ALTERNATIVE: it would be as follows:
         "N2O-N per kg fertilizer N applied (tN/tN)"
                                 ALL crop grass activities; incl. ALL grass types; miscanthus
                                                        Livestock (NO dairy/beef cattle; layer/broiler chickens)
                                                                 "AllAndAverageTypes"         "AllProdSyst"        "AllProdCond"
         "Volatized N as percentage of fertilizer N applied (%)"
         "Leached N as percentage of fertilizer N applied (%)"
         "N2O-N per kg N volatized from fert applic (share)"
         "N2O-N per kg N leached from fert applic (share)"
         "NH3-N as percentage of fertilizer N applied (%)"
                                 ALL crop grass activities; incl. ALL grass types; miscanthus
                                                        "All Animals"
                                                                 "AllAndAverageTypes"         "AllProdSyst"        "AllProdCond"

$offtext;


execute_unload 'GeneralModelParameters_Auxiliary'
HumanCharacteristics
SeedContents
MineralFertilizerCharacteristics
GWP_GTP_SOLm
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-HumanCharacteristics
         "kcal/cap/day (ADER) SOFI2012"
         "g protein/cap/day SOFI2012"
         "g fat/cap/day SOFI2012"
         "kcal/cap/day (ADER) Walpole2012"
         "g protein/cap/day Walpole2012"
         "g fat/cap/day Walpole2012"
                 "PopulationAll"           "AllCommodities"

-SeedContents
         "N (t)"
         "P2O5 (t)"
         "DM (t)"
                 Crops (most but not all, e.g. no miscanth.)      "AllProdSyst"        "AllProdCond"

-MineralFertilizerCharacteristics
         "t CO2e/tN production"
                 "mineral N fert (N)"
                 "mineral P fert (P2O5)"
                         "AllMinFertProdTech"        "AllProdSyst"

-GWP_GTP_SOLm               **BIG EXCEPTION!! THIS IS NOT ON COUNTRY LEVEL - just global values
         Values for CO2, CHç, N2O
$offtext;

execute_unload 'GeneralModelVariables_ActivityQuantities'
*2.1) Amount of activity units
VActCropsGrass_QuantityActUnits
VActAnimalsAPU_QuantityActUnits
VActAnimalsHead_QuantityActUnits
VActFishSeafood_QuantityActUnits
VActForest_QuantityActUnits
VActOthers_QuantityActUnits
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-VActAnimalsAPU_QuantityActUnits
         "Beehives"        "AllAndAverageTypes"   "AllProdSyst"    "AllProdCond"

-VActAnimalsHead_QuantityActUnits
         Livestock (NO dairy/beef cattle; layer/broiler chickens)
                          CattleTypeInHerd
                          PigTypeInherd
                          "Living"                 "AllProdSyst"        "AllProdCond"      WITH CATTLE AND PIGS!!
                          "Milk Producing"         "AllProdSyst"        "AllProdCond"
                          "Meat Producing"         "AllProdSyst"        "AllProdCond"
                          "Eggs Producing"         "AllProdSyst"        "AllProdCond"
                          "HidesSkins Producing    "AllProdSyst"        "AllProdCond"
                          "Wool Producing"         "AllProdSyst"        "AllProdCond"

-VActCropsGrass_QuantityActUnits
         ALL crop grass activities; incl. ALL grass types; miscanthus
                          "AllProdSyst"        "AllProdCond"

-VActForest_QuantityActUnits
         "Forest"
         "Planted forest"
         "Primary forest"   (The previous two categories are SUB-CATEGORIES of the first "Forest" - but NOT EXHAUSTING it)
                          "AllProdSyst"        "AllProdCond"

$offtext;


execute_unload 'GeneralModelVariables_Inputs'
*2.2) Inputs to activities
VActCropsGrass_Inputs
VActAnimalsAPU_Inputs
VActAnimalsHead_Inputs
VActFishSeafood_Inputs
VActForest_Inputs
VActOthers_Inputs
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-VActCropsGrass_Inputs
         "Seeds (t)"               Crops (partly only)                       "AllProdSyst"        "AllProdCond"
$offtext;

execute_unload 'GeneralModelVariables_Outputs'
*2.3) Outputs from activities
VActCropsGrass_Outputs
VActAnimalsAPU_Outputs
VActAnimalsHead_Outputs
VActFishSeafood_Outputs
VActForest_Outputs
VActOthers_Outputs
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-VActAnimalsAPU_Outputs
         "Honey (t)"               "Beehives       "Honey Producing"           "AllProdSyst"        "AllProdCond"
         "Wax (t)"                 "Beehives       "Wax Producing"             "AllProdSyst"        "AllProdCond"

-VActAnimalsHead_Outputs
                                 Livestock (NO dairy/beef cattle; layer/broiler chickens)
         "Milk (t"                                 "Milk Producing"            "AllProdSyst"        "AllProdCond"
         "Meat (t)"                                "Meat Producing"            "AllProdSyst"        "AllProdCond"
         "Eggs (t)"                                "Eggs Producing"            "AllProdSyst"        "AllProdCond"
         "HidesSkins (t)"                          "HidesSkins Producing"      "AllProdSyst"        "AllProdCond"
         "Wool (t)"                                "Wool Producing"            "AllProdSyst"        "AllProdCond"

-VActCropsGrass_Outputs
         "MainOutput1 (t)"       Crops / miscanth / temp/perm grass            "AllProdSyst"        "AllProdCond"
$offtext;

execute_unload 'GeneralModelVariables_OtherChar'
*2.4) Other characteristics of a
VActCropsGrass_OtherChar
VActAnimalsAPU_OtherChar
VActAnimalsHead_OtherChar
VActFishSeafood_OtherChar
VActForest_OtherChar
VActOthers_OtherChar
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):

NOT YET ANY DATA IN THIS FILE!!!

$offtext;

execute_unload 'GeneralModelVariables_Various'
*2.5) Commodity quantities, nutr
VCommod_Quantity
VCommod_Contents
VCommod_OtherChar

*2.6) Commodity untilizationa
VCommod_Production
VCommod_StockChanges
VCommod_Food
VCommod_Feed
VCommod_Seed
VCommod_Processing
VCommod_Waste
VCommod_Other

VCommod_Food_Contents
VCommod_Feed_Contents
VCommod_Waste_Contents
VCommod_Food_OtherChar
VCommod_Feed_OtherChar
VCommod_Waste_OtherChar

*2.7) Crop residue quantities, n
VCropResidues_Quantity
VCropResidues_Contents
VCropResidues_OtherChar
VCropResidues_Management

*2.8) Feeding rations quantities
VFeedingRations_Quantity
VFeedingRations_Contents
VFeedingRations_OtherChar

*2.9) Manure quantities, nutrien
VManure_Quantity
VManure_Contents
VManure_OtherChar
VManure_Management

*2.10) Fertilizer application: n
VManureApplication
VCropResAndBiomassApplication
VMinFertApplication
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-VCommod_Feed
         Quantities fresh matter used for FEED:
                  Crop, livestock and grass commodities; incl. temp/perm grass
                                  "AllProdSyst"        "AllProdCond"
-VCommod_Food
         Quantities fresh matter used for FOOD:
                  Crop and livestock commodities:
                                  "AllProdSyst"        "AllProdCond"
-VCommod_Other
         Quantities fresh matter used for OTHER uses (e.g. bioenergy):
                  Crop, livestock commodities; incl. Miscanthus; would also be applicable to temp/perm grass - but currently not; all this is used for feed
                                  "AllProdSyst"        "AllProdCond"
-VCommod_Processing
         Quantities fresh matter used for PROCESSING:
                  Crop, livestock commodities; would also be applicable to miscanthus and temp/perm grass - but currently not; all this is used for other uses (energy) and feed
                                  "AllProdSyst"        "AllProdCond"
-VCommod_Production
         Quantities fresh matter stemming from DOMESTIC PRODUCTION:
                  Crop, livestock commodities; incl. Miscanthus and temp/perm grass
                                  "AllProdSyst"        "AllProdCond"
-VCommod_Quantity
         Domestically available QUANTITIES fresh matter (sum of all utilizations, resp. prod + imp - exp):
                  Crop, livestock commodities; incl. Miscanthus; temp/perm grass
                                  "AllProdSyst"        "AllProdCond"
-VCommod_Seed
         Quantities fresh matter used for SEED:
                  Crop and livestock commodities:
                                  "AllProdSyst"        "AllProdCond"
-VCommod_StockChanges
         Quantities fresh matter stemming from STOCK CHANGES (can also be negative):
                  Crop and livestock commodities:
                                  "AllProdSyst"        "AllProdCond"
-VCommod_Waste
         Quantities fresh matter lost as WASTE:
                  Crop and livestock commodities:
                                  "AllProdSyst"        "AllProdCond"

$offtext;

execute_unload 'GeneralModelVariables_Trade'
*2.11) Import and export quantit
VImportQuantity
VExportQuantity
VImportLivingAnimalsHead
VExportLivingAnimalsHead
*for trade in beehives and other
VImportLivingAnimalsAPU
VExportLivingAnimalsAPU

VImportQuantity_Feed
VExportQuantity_Feed
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-VExportLivingAnimalsAPU
         "Beehives"
                 exported to "WORLD"
                                         "AllProdSyst"        "AllProdCond"
-VExportLivingAnimalsHead
         All Livestock
                 exported to "WORLD"
                         "Living"        "AllProdSyst"        "AllProdCond"
-VImportLivingAnimalsAPU
         "Beehives"
                 imported from "WORLD"
                                         "AllProdSyst"        "AllProdCond"
-VImportLivingAnimalsHead
         All Livestock
                 imported from "WORLD"
                         "Living"        "AllProdSyst"        "AllProdCond"
-VImportQuantity
         Crop and livestock commodities:
                 imported from Countries AND "WORLD"
                                         "AllProdSyst"        "AllProdCond"
-VExportQuantity
         Crop and livestock commodities:
                 exported to Countries AND "WORLD"
                                         "AllProdSyst"        "AllProdCond"
-VImportQuantity_Feed
         10 crop commodities
                 imported from World to Switzerland
                                         "AllProdSyst"        "AllProdCond"
-VExportQuantity_Feed
         No data

$offtext;

*2.12) Commodities expressed in primary product equivalents
execute_unload 'GeneralModelVariables_CommodityTree'
VPrimProd_Commod_Quantity
VPrimProd_Commod_Production
VPrimProd_Commod_StockChanges
VPrimProd_Commod_Food
VPrimProd_Commod_Feed
VPrimProd_Commod_Seed
VPrimProd_Commod_Processing
VPrimProd_Commod_Waste
VPrimProd_Commod_Other
VPrimProd_ImportQuantity
VPrimProd_ExportQuantity
VPrimProd_Commod_Quantity_CropActivities
VPrimProd_Commod_Quantity_AnimalActivities
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-VPrimProd_Commod_Quantity
         Crop and livestock commodities (prim prod equivalents)
                                         "AllProdSyst"        "AllProdCond"
-VPrimProd_Commod_Quantity_CropActivities
         Crop commodities (prim prod equivalents)
                 Linked to ACTIVITIES   incl AGGREGATE CROP ACTIVITIES  (such as "All Cereals")
                                         "MainOutput1 (t)"
                                                 "AllProdSyst"        "AllProdCond"
-VPrimProd_Commod_Quantity_AnimalActivities
         Livestock commodities (prim prod equivalents)
                 Linked to ACTIVITIES   incl AGGREGATE ANIMAL ACTIVITIES  (such as "All Animals")
                                        "Meat (t)"
                                        "Milk (t)"
                                        "Eggs (t)"
                                        "Honey (t)"
                                        "Wool (t)"
                                                 "AllProdSyst"        "AllProdCond"
$offtext;

execute_unload 'GeneralModelVariables_Auxiliary'
VMineralFertilizerQuantity
VPopulationNumbers
VEnergyProduction
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):
-VMineralFertilizerQuantity
         "Mineral N fert (N)"
         "Mineral P fert (P2O5)"
         "Mineral K fert (K2O)"
                 "AllMinFertProdTech"  "AllProdSyst"
                              also for some WORLD REGIONS
-VPopulationNumbers
         "PopulationAll"
         "Male"
         "Female"

$offtext;


*store the FOFA2050 and BioeSR15 and other scenario data (e.g. from UNISECO BioBam)
*this is contained in _MR entities, thus store them:
execute_unload 'FOFA2050_BioeSR15_Etc_Data_InModelRunEntities'
ActCropsGrass_Outputs_MR
ActCropsGrass_OtherChar_MR
ActAnimalsHead_Outputs_MR
ActAnimalsHead_Inputs_MR
ActAnimalsHead_OtherChar_MR
VActCropsGrass_QuantityActUnits_MR
VActCropsGrass_Outputs_MR
VActCropsGrass_Inputs_MR
VActAnimalsHead_QuantityActUnits_MR
VActForest_QuantityActUnits_MR
VPopulationNumbers_MR
HumanCharacteristics_MR
VEnergyProduction_MR
VCropResidues_Quantity_MR
CropResidues_Management_MR
ActForest_OtherChar_MR
Commod_OtherChar_MR
FeedingRationsHeads_OtherChar_MR

AUX_FeedSupplyFactor_BioeSR15_MR
;
$ontext;
from this, you get the following - always on COUNTRY LEVEL (stuff not mentioned is not available!):

*AND - for doing this data, all "Baseline" values that are already available have been assigned - below, THOSE are NOT displayed to be available!!

-ActAnimalsHead_Outputs_MR
         FOFA_BAU_2050
                 Buffaloes, Cattle, Chickens, Goats, Pigs, Sheep
                         "Milk (t)"      "Milk Producing"            "AllProdSyst"
                                                                     "Convent"
                                                                     "Organic"        "AllProdCond"
                         "Meat (t)"      "Meat Producing"            "AllProdSyst"
                                                                     "Convent"
                                                                     "Organic"        "AllProdCond"
                         "Eggs (t)"     "Egg Producing"              "AllProdSyst"
                                                                     "Convent"
                                                                     "Organic"        "AllProdCond"
-ActCropsGrass_OtherChar_MR
         FOFA_BAU_2050
                 Crops (no perm/temp grass/no miscanthus; not all crops)
                          "Cropping intensity (ratio)"               "Irrigated"
                                                                     "Rainfed"        "AllProdCond"
-ActCropsGrass_Outputs_MR
         FOFA_BAU_2050
                 Crops (no perm/temp grass/no miscanthus; not all crops)
                          "MainOutput1 (t)"                          "Irrigated"
                                                                     "Rainfed"
                                                                     "AllProdSyst"
                                                                     "Convent"
                                                                     "Organic"        "AllProdCond"

         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100
                 "Miscanthus"
                          "MainOutput1 (t)"
                          "MainOutput1 (t DM)"                       "AllProdSyst"
                                                                     "Convent"
                                                                     "Organic"        "AllProdCond"
                 "All Cereals"
                 "All Sugar Crops"
                 "All Oilcrops"
                          "MainOutput1 (t DM)"                       "AllProdSyst"
                                                                     "Convent"
                                                                     "Organic"        "AllProdCond"
-ActForest_OtherChar_MR
         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100
                 "Forest"
                          "Forest res bioe N for areas (tN/t DM res)"
                                                                     "AllProdSyst"    "AllProdCond"

-AUX_FeedSupplyFactor_BioeSR15_MR         auxiliary parameter capturing the total feed demand in the BioeSR15 scenario P4
         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100

-CropResidues_Management_MR
         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100
                 "Miscanthus"
                         "Average Residues (t)"
                                  "Quantity share in CropResMan system"     "Crop res N for areas (tN)"
                         "Average Residues (t DM)"
                                  "Crop res N for areas (tN/t DM res)"
                 "All crops"
                         "Average Residues (t DM)"
                                  "Crop res N for areas (tN/t DM res)"
                                                         "All bioenergy" (crop res man system)
                                                                     "AllProdSyst"
                                                                     "Convent"
                                                                     "Organic"        "AllProdCond"
-HumanCharacteristics_MR
         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100
                  "PopulationAll"
                          "kcal/cap/day (BioeSR15 req)"
                                 "All Commodities"
                                 "All crop based Commodities"
                                 "All animal based Commodities"
                 NO COUNTRIES, ONLY Regions:
                                         World
                                         R5ASIA
                                         R5LAM
                                         R5MAF
                                         R5OECD90+EU
                                         R5REF
-VActAnimalsHead_QuantityActUnits_MR
         FOFA_BAU_2050
                 "Buffaloes"
                 "Cattle"
                 "Chickens"
                 "Goats"
                 "Pigs"
                 "Sheep"
                 "All animals"  (in LIVESTOCK UNITS - NOT HEADS)
                                   "Living"                 "AllProdSyst"        "AllProdCond"
-VActCropsGrass_Inputs_MR
         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100
                 "Miscanthus"
                 "All crops and grass"
                         "N from all fertilizers (tN)"
                                                            "AllProdSyst"        "AllProdCond"
-VActCropsGrass_Outputs_MR
         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100
                 "Miscanthus"
                         "MainOutput1 (t DM)"
                                                            "AllProdSyst"        "AllProdCond"
-VActCropsGrass_QuantityActUnits_MR
         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100
                  All crop grass activities; incl. perm/temp mead. and past; miscanthus;
                          "AllProdSyst"        "AllProdCond"
         FOFA_BAU_2050
                  All crop activities; NO perm/temp mead. and past; NO miscanthus!!!
                          "Irrigated"
                          "Rainfed"
                          "AllProdSyst"        "AllProdCond"

-VActForest_QuantityActUnits_MR
         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100
                 "Forest"
                 "Forestry"
                 "Natural forest"   (TO BE CLARIFIED: relation of these categories!!??)
                                  "AllProdSyst"        "AllProdCond"

-VCropResidues_Quantity_MR
         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100
                 "Miscanthus"
                      "Average Residues (t)"
                          "AllProdSyst"        "AllProdCond"
-VEnergyProduction_MR
         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100
                 "Miscanthus"
                 "Forest and crop residues"
                          "Primary Energy"       "AllEnTypes"    "Production (EJ)"
      NO COUNTRIES, ONLY Regions:        World
                                         AFR
                                         CHN
                                         EUR
                                         IND
                                         JPN
                                         LAM
                                         MEA
                                         OAS
                                         ROW
                                         RUS
                                         USA
                          "Secondary Energy"       "AllEnTypes"    "N from Bioe residues (tN)"
                                                                   "Bioe conversion Biomass input (tDM)"             (FOR secondary energy: we have country values)
                 "AllEnSources"
                 "Biomass"
                          "Primary Energy"       "AllEnTypes"    "Production (EJ)"
                          "Secondary Energy"     "Electricity"
                                                 "Gases"
                                                 "Hydrogen"
                                                 "Liquids"       "Production (EJ)"
                 "EtOH residues"
                          "Secondary Energy"     "Electricity"   "Production (EJ)"
                 "Biomass"
                          "Secondary Energy"     "Liquids"       "N from Bioe residues (tN)"
      NO COUNTRIES, ONLY Regions:        World
                                         R5ASIA
                                         R5LAM
                                         R5MAF
                                         R5OECD90+EU
                                         R5REF
-VPopulationNumbers_MR
         FOFA_BAU_2050
         BioeSR15_P4_2010
         BioeSR15_P4_2050
         BioeSR15_P4_2100
                 "PopulationAll"





$offtext;




