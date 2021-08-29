PUTCLOSE con,"_V6_ReadOutputFilesFromSteeringFile1a";

$ontext;
GENERAL DESCRIPTION

*this code reads the following gdx-files with the sets, par's, var's as indicated in the code:

'GeneralModelSets_MR'
'GeneralModelParameters_Inputs_MR'
'GeneralModelParameters_Outputs_MR'
'GeneralModelParameters_OtherChar_MR'
'GeneralModelParameters_Various_MR'
'GeneralModelParameters_Auxiliary_MR'
'GeneralModelVariables_ActivityQuantities_MR'
'GeneralModelVariables_Inputs_MR'
'GeneralModelVariables_Outputs_MR'
'GeneralModelVariables_OtherChar_MR'
'GeneralModelVariables_Various_MR'
'GeneralModelVariables_Trade_MR'
'GeneralModelVariables_CommodityTree_MR'
'GeneralModelVariables_Auxiliary_MR'
'AuxiliaryParametersAndVariables_ForIntermediateUse_MR'


DETAILED TABLE OF CONTENTS
- 1) Read the output files from Steering file 1a
$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Read the output files from Steering file 1a
$ontext;
This file is already filed in

$GDXIN  GeneralModelSets_MR_OutSteer1a.gdx
$load InputsCropsGrass
$load InputsAnimals
$load InputsFishSeafood
$load InputsForest
$load InputsOther
$load OutputsCropsGrass
$load YieldsCropsGrass
$load OutputsAnimals
$load YieldsAnimals
$load OutputsFishSeafood
$load OutputsForest
$load OutputsOther
$load OtherCharCropsGrass
$load OtherCharCropsGrass_PerHaBased
$load OtherCharCropsGrass_PerTonYieldBased
$load OtherCharAnimals
$load OtherCharAnimals_PerHeadBased
$load OtherCharFishSeafood
$load OtherCharForest
$load OtherCharOther
$load AnimalTypeInHerd
$load AnimalTypeInHerd_NoAggregates
$load CattleTypeInHerd
$load DairyCattleTypeInHerd
$load BeefCattleTypeInHerd
$load PigTypeInHerd
$load ProducingAnimals
$load SuckledAnimals
*$load AnimalTypeInHerd_2
*define later via alias
$load MatchSucklingSuckledAnimals

$load ProductionSystems
$load ProdSyst_OrgConAll
$load ProdSyst_OrgCon
$load ProdSyst_NoAggregates
$load ProductionSystems_UsingMinNFert
$load ProductionSystems_UsingMinPFert
$load ProductionConditions
$load Contents
$load ContentsPerFreshMatterNutrients
$load ContentsPerFreshMatterFood
$load ContentsPerFreshMatterFeed
$load CommodOtherChar
$load UtilSharesNOTFeed
$load ManureOtherChar
$load CropResContents
$load CropResOtherChar
$load CropResManagement
$load CropResManagement_NotSystemShares
$load CropResManSystem
$load CropResManSystemCropland
$load CropResManSystemGrassland
$load CropResManSystem_WithVolatInApplication
$load CropResManSystemCropland_ForOECDNBalance
$load ManureContents
$load ManureManagement
$load ManureManSystem
$load ManureManSystemCropland
$load ManureManSystemGrassland
$load ManureManSystem_NoAverageNoTotal
$load FertApplicCharact

$load Regions
*$load Regions_2
*define later via alias
$load Countries

$load FAO_Africa
$load FAO_Eastern_Africa
$load FAO_Middle_Africa
$load FAO_Northern_Africa
$load FAO_Southern_Africa
$load FAO_Western_Africa
$load FAO_Americas
$load FAO_Northern_America
$load FAO_Central_America
$load FAO_Caribbean
$load FAO_South_America
$load FAO_Asia
$load FAO_Central_Asia
$load FAO_Eastern_Asia
$load FAO_Southern_Asia
$load FAO_SouthEastern_Asia
$load FAO_Western_Asia
$load FAO_Europe
$load FAO_Eastern_Europe
$load FAO_Northern_Europe
$load FAO_Southern_Europe
$load FAO_Western_Europe
$load FAO_Oceania
$load FAO_Australia_NewZealand
$load FAO_Melanesia
$load FAO_Micronesia
$load FAO_Polynesia
$load FAO_EuropeanUnion
$load SubSaharanAfrica
$load Match_GeographicAggregates_SingleCountries

$load FOFA2050_Rest_of_EAP
$load FOFA2050_Rest_of_HIC
$load FOFA2050_Rest_of_LAC
$load FOFA2050_Rest_of_MNA
$load FOFA2050_Rest_of_SAS
$load FOFA2050_Rest_of_SSA
$load FOFA2050_Rest_of_EU
$load FOFA2050_Rest_of_ECA

$load Regions_Switzerland
$load Regions_Austria
$load Regions_Austria_Tal
$load Regions_Austria_Huegel
$load Regions_Austria_Berg

*needed for UNISECO SESSIT tool
*put as comment if UNISECO-files are not run, as it may cause an error otherwise
*$load NonEU_RestOfTheWorld

$load Activities
*$load Activities_2
*define later via alias
$load Livestock
$load Livestock_NoAggregates
$load Ruminants
$load Poultry
$load MonogastricsNonPoultry
$load FishAndSeafood
$load NonRuminants
$load Livestock_NoCoupledOutputs
$load Livestock_CoupledMeatMilk
$load Livestock_CoupledMeatEggs
$load Livestock_NonRuminantsWithHerdStructure
$load Crops
$load Cereals
$load Fruits
$load Treenuts
$load Pulses
$load Legumes_NFixing
$load Crops_NoNFixingLegumes
$load OilCrops
$load StarchyRoots
$load SugarCrops
$load Vegetables
$load StimulantsSpices
$load FibresRubber
$load Fallows
$load EnergyCrops
$load ForageCrops
$load OtherCereals
$load CitrusFruits
$load Spices
$load OtherVegetables
$load OtherOilcrops
$load FibresNotCotton
$load OtherFodderCrops
$load CoreFoodCrops
$load CoreFoodCrops_NoCereals
$load GrassActivities
$load CoreGrassActivities
$load CoreGrassActivitiesNoTEMPGrass
$load TempAndPermMeadAndPastures
$load TempMeadAndPastures
$load CropsAndCoreGrassActivities
$load CropsAndTempGrassActivities
$load SingleCropGrassAndLivestockActivities
$load FOFA2050_SweetPotato_And_Yams
$load FOFA2050_Rapeseed_And_Mustardseed
$load FOFA2050_OtherCrops
$load FOFA2050_OtherFibreCrops
$load FOFA2050_OtherFruits
$load FOFA2050_OtherOilseeds
$load FOFA2050_OtherRootsAndTubers
$load FOFA2050_OtherVegetables
$load FOFA2050_CitrusFruits
$load FOFA2050_DriedPulses
$load FOFA2050_OtherCereals
$load OtherCrops

$load Commodities
*$load Commodities_2
*define later via alias
$load ForageCommodities
$load Grasscommodities
$load ConcentrateCommodities
$load Commodities_SingleCommodities
$load Commodities_FeedGroups
$load Commodities_FeedGroups_DetailedFeedingRations
$load Commodities_FeedGroups_DetailedFeedingRations_NoTot
$load Commodities_Feed
$load Commodities_Feed_Grass
$load Commodities_Feed_NoForageNoGrass
$load Commodities_Feed_ForageCrops
$load Commodities_Feed_Cereals
$load Commodities_Feed_OilCropsAndCakes
$load Commodities_Feed_Pulses
$load Commodities_Feed_Roots
$load Commodities_Feed_Sugar
$load Commodities_Feed_OthersPlants
$load Commodities_Feed_OthersAnimals
$load Commodities_Feed_Residues
$load CommoditiesDAQ_TradeFromToWorld
$load SET_Cereals_CommodityGroup
$load SET_FodderCrops_CommodityGroup
$load SET_Fruits_CommodityGroup
$load SET_Nuts_CommodityGroup
$load SET_Oilcrops_CommodityGroup
$load SET_OtherCrops_CommodityGroup
$load SET_Pulses_CommodityGroup
$load SET_RootsAndTubers_CommodityGroup
$load SET_Sugarcrops_CommodityGroup
$load SET_Vegetables_CommodityGroup
$load SET_Milk_CommodityGroup
$load SET_Meat_CommodityGroup
$load SET_Eggs_CommodityGroup
$load SET_FishSeafood_CommodityGroup
$load CommoditiesDAQ_TradeFromToWorldPrimary
$load CommoditiesDAQ_TradeFromToWorldPrimaryCrops
$load Commodities_EquivalentToNonGrassFedAnimalActivityOutput
$load CommoditiesDAQ_TradeFromToWorldPrimaryAnimals
$load CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed
$load CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NonGrassFed
$load CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_FishSeafood
$load CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary
$load CommoditiesDAQ_TradeFTWorldDirDerivedFromPrimary_Animals
$load CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed
$load CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed
$load CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts
$load CommoditiesDAQ_TradeFromToWorld_FishSeafood
$load MatchCommAct_CommoditiesDAQ_TradeFromToWorld_Crops
$load MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsPrimary
$load MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsDerived
$load MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_CropsDerived
$load MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_AnimalsDerived
$load MatchPrimDerivedCommodities_DAQ_TradeFTW_AnimalsDer_GrassFed
$load MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts
$load MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsPrimary
$load MatchCommAct_CommoditiesDAQ_TradeFTW_AnimalsPrimaryGrassFed
$load MatchCommAct_CommoditiesDAQ_TradeFTW_AnimPrimaryNonGrassFed
$load MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsDerived
$load MatchCommodTradeFromToWorld_CommodTradeBetweenCountries

*the following sets are also needed to read in data
$load Years
$load BasisyearsOLD
$load Basisyears
$load BasisyearsSeed
$load Temperatures
$load Temperatures0to100Celsius
$load TemperaturesBelow10
$load TemperaturesAbove28
$load GreenhouseGases

$load MineralFertilizerType
$load MineralFertilizerProdTech
$load MinFertChar
$load PopulationGroups
$load Humans_InputsOutputsOtherCharacteristics
$load FeedingRationOtherChar
*this file is not needed here and cannot be defined, due to the FAOSTAT-Set used in its definition, thus drop
*$load MatchFaostatLiveAnimalItems_Activities
$load Match_ActivityOutputsToCommodities_Crops
$load Match_ActivityOutputsToCommodities_Animals
$load Match_FeedCommoditiesToFeedCommodGroups
$load Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc
$load Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio

$load ConversionLevel
$load EnergyType
$load EnergySource
$load EnergyChar

$load Scenarios
$load FOFA2050_Scenarios
$load BioeSR15_Scenarios

$load MatchCommAct_AggregateCommodities_Crops
$load MatchCommAct_AggregateActivities_Crops
$load MatchCommAct_WellDefinedCoProducts_Crops
$load MatchCommAct_ComplexCases_Crops
$load MatchCommAct_ComplexAnimalCommodities
$load MatchCommAct_CommodEquivalentAct_Crops
$load MatchCommAct_CommodEquivalentAct_Animals
$load MatchCommAct_CommodAndProductsEquivalentAct_Crops

$load SubsetCommod_MatchWithAct_AggregateCommodities
$load SubsetCommod_MatchWithAct_AggregateActivities
$load SubsetCommod_MatchWithAct_WellDefinedCoProducts
$load SubsetCommod_MatchWithAct_ComplexCases
$load SubsetCommod_MatchWithAct_ComplexAnimalCommodities
$load SubsetCommod_MatchWithAct_CommodEquivalentAct
$load SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct

$load SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Main
$load SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Co
$load SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level2_Main
$load SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level2_Co
$load MatchMainWithCoProd_WellDefinedCoProducts_Level1
$load MatchMainWithCoProd_WellDefinedCoProducts_Level2
$load MatchMainWithCoPr_WellDefCoProd_Level1And2_TwoByprod
$load Match_ShellsEtc_Activities

*needed for UNISECO SESSIT tool
*put as comment if UNISECO-files are not run, as it may cause an error otherwise
*$load Match_Countries_NUTS2
*$load NUTS2_Regions

$GDXIN  GeneralModelSets_MR_OutSteer1a.gdx

$offtext;

*now do the aliases that have not yet been able to do:
alias(Activities,Activities_2)
alias(Regions,Regions_2)
alias(Commodities,Commodities_2)








$GDXIN GeneralModelParameters_Inputs_MR_OutSteer1a.gdx
*1.1) Activities: input param
$load ActCropsGrass_Inputs_MR
$load ActAnimalsAPU_Inputs_MR
$load ActAnimalsHead_Inputs_MR
$load ActFishSeafood_Inputs_MR
$load ActForest_Inputs_MR
$load ActOthers_Inputs_MR
$GDXIN GeneralModelParameters_Inputs_MR_OutSteer1a.gdx

$GDXIN GeneralModelParameters_Outputs_MR_OutSteer1a.gdx
*1.2) Activities: output para
$load ActCropsGrass_Outputs_MR
$load ActAnimalsAPU_Outputs_MR
$load ActAnimalsHead_Outputs_MR
$load ActFishSeafood_Outputs_MR
$load ActForest_Outputs_MR
$load ActOthers_Outputs_MR
$GDXIN GeneralModelParameters_Outputs_MR_OutSteer1a.gdx

$GDXIN GeneralModelParameters_OtherChar_MR_OutSteer1a.gdx
*1.3) Activities: other chara
$load ActCropsGrass_OtherChar_MR
$load ActAnimalsAPU_OtherChar_MR
$load ActAnimalsHead_OtherChar_MR
$load ActFishSeafood_OtherChar_MR
$load ActForest_OtherChar_MR
$load ActOthers_OtherChar_MR
$GDXIN GeneralModelParameters_OtherChar_MR_OutSteer1a.gdx

$GDXIN GeneralModelParameters_Various_MR_OutSteer1a.gdx
*1.4) Commodities: nutrient c
$load Commod_Contents_MR
$load Commod_OtherChar_MR

*1.5) Commodity tree paramete
$load Commod_ProductionShare_MR
$load Commod_ExtractionRate_MR
$load Commod_SingleInAggregateCommodShares_MR

*1.6) Crop residues: nutrient
$load CropResidues_Contents_MR
$load CropResidues_OtherChar_MR
$load CropResidues_Management_MR

*1.7) Feeding rations
$load FeedingRations_Contents_MR
$load FeedingRations_OtherChar_MR
$load FeedingRationsHeads_Contents_MR
$load FeedingRationsHeads_OtherChar_MR
$load FeedingRationsAPU_Contents_MR

*1.8) Manure: nutrient conten
$load Manure_Contents_MR
$load Manure_OtherChar_MR
$load Manure_Management_MR

*1.9) Fertilizer application:
$load ManureApplication_MR
$load CropResAndBiomassApplication_MR
$load MinFertApplication_MR

*extraction rates:
$load ExtractionRate_CommodityTree_MR
$GDXIN GeneralModelParameters_Various_MR_OutSteer1a.gdx


$GDXIN GeneralModelParameters_Auxiliary_MR_OutSteer1a.gdx
$load HumanCharacteristics_MR
$load SeedContents_MR
$load MineralFertilizerCharacteristics_MR
$load GWP_GTP_SOLm_MR
$GDXIN GeneralModelParameters_Auxiliary_MR_OutSteer1a.gdx


$GDXIN GeneralModelVariables_ActivityQuantities_MR_OutSteer1a.gdx
*2.1) Amount of activity units
$load VActCropsGrass_QuantityActUnits_MR
$load VActAnimalsAPU_QuantityActUnits_MR
$load VActAnimalsHead_QuantityActUnits_MR
$load VActFishSeafood_QuantityActUnits_MR
$load VActForest_QuantityActUnits_MR
$load VActOthers_QuantityActUnits_MR
$GDXIN GeneralModelVariables_ActivityQuantities_MR_OutSteer1a.gdx

$GDXIN GeneralModelVariables_Inputs_MR_OutSteer1a.gdx
*2.2) Inputs to activities
$load VActCropsGrass_Inputs_MR
$load VActAnimalsAPU_Inputs_MR
$load VActAnimalsHead_Inputs_MR
$load VActFishSeafood_Inputs_MR
$load VActForest_Inputs_MR
$load VActOthers_Inputs_MR
$GDXIN GeneralModelVariables_Inputs_MR_OutSteer1a.gdx

$GDXIN GeneralModelVariables_Outputs_MR_OutSteer1a.gdx
*2.3) Outputs from activities
$load VActCropsGrass_Outputs_MR
$load VActAnimalsAPU_Outputs_MR
$load VActAnimalsHead_Outputs_MR
$load VActFishSeafood_Outputs_MR
$load VActForest_Outputs_MR
$load VActOthers_Outputs_MR
$GDXIN GeneralModelVariables_Outputs_MR_OutSteer1a.gdx

$GDXIN GeneralModelVariables_OtherChar_MR_OutSteer1a.gdx
*2.4) Other characteristics of a
$load VActCropsGrass_OtherChar_MR
$load VActAnimalsAPU_OtherChar_MR
$load VActAnimalsHead_OtherChar_MR
$load VActFishSeafood_OtherChar_MR
$load VActForest_OtherChar_MR
$load VActOthers_OtherChar_MR
$GDXIN GeneralModelVariables_OtherChar_MR_OutSteer1a.gdx

$GDXIN GeneralModelVariables_Various_MR_OutSteer1a.gdx
*2.5) Commodity quantities, nutr
$load VCommod_Quantity_MR
$load VCommod_Contents_MR
$load VCommod_OtherChar_MR

*2.6) Commodity untilizationa
$load VCommod_Production_MR
$load VCommod_StockChanges_MR
$load VCommod_Food_MR
$load VCommod_Feed_MR
$load VCommod_Seed_MR
$load VCommod_Processing_MR
$load VCommod_Waste_MR
$load VCommod_Other_MR

$load VCommod_Food_Contents_MR
$load VCommod_Feed_Contents_MR
$load VCommod_Waste_Contents_MR
$load VCommod_Food_OtherChar_MR
$load VCommod_Feed_OtherChar_MR
$load VCommod_Waste_OtherChar_MR

*2.7) Crop residue quantities, n
$load VCropResidues_Quantity_MR
$load VCropResidues_Contents_MR
$load VCropResidues_OtherChar_MR
$load VCropResidues_Management_MR

*2.8) Feeding rations quantities
$load VFeedingRations_Quantity_MR
$load VFeedingRations_Contents_MR
$load VFeedingRations_OtherChar_MR

*2.9) Manure quantities, nutrien
$load VManure_Quantity_MR
$load VManure_Contents_MR
$load VManure_OtherChar_MR
$load VManure_Management_MR

*2.10) Fertilizer application: n
$load VManureApplication_MR
$load VCropResAndBiomassApplication_MR
$load VMinFertApplication_MR
$GDXIN GeneralModelVariables_Various_MR_OutSteer1a.gdx

$GDXIN GeneralModelVariables_Trade_MR_OutSteer1a.gdx
*2.11) Import and export quantit
$load VImportQuantity_MR
$load VExportQuantity_MR
$load VImportLivingAnimalsHead_MR
$load VExportLivingAnimalsHead_MR
*for trade in beehives and other
$load VImportLivingAnimalsAPU_MR
$load VExportLivingAnimalsAPU_MR

$load VImportQuantity_Feed_MR
$load VExportQuantity_Feed_MR
$GDXIN GeneralModelVariables_Trade_MR_OutSteer1a.gdx


*2.12) Commodities expressed in primary product equivalents
$GDXIN GeneralModelVariables_CommodityTree_MR_OutSteer1a.gdx
$load VPrimProd_Commod_Quantity_MR
$load VPrimProd_Commod_Production_MR
$load VPrimProd_Commod_StockChanges_MR
$load VPrimProd_Commod_Food_MR
$load VPrimProd_Commod_Feed_MR
$load VPrimProd_Commod_Seed_MR
$load VPrimProd_Commod_Processing_MR
$load VPrimProd_Commod_Waste_MR
$load VPrimProd_Commod_Other_MR
$load VPrimProd_ImportQuantity_MR
$load VPrimProd_ExportQuantity_MR
$load VPrimProd_Commod_Quantity_CropActivities_MR
$load VPrimProd_Commod_Quantity_AnimalActivities_MR
$GDXIN GeneralModelVariables_CommodityTree_MR_OutSteer1a.gdx


$GDXIN GeneralModelVariables_Auxiliary_MR_OutSteer1a.gdx
$load VMineralFertilizerQuantity_MR
$load VPopulationNumbers_MR
$load VEnergyProduction_MR
$GDXIN GeneralModelVariables_Auxiliary_MR_OutSteer1a.gdx


$GDXIN AuxiliaryParametersAndVariables_ForIntermediateUse_MR_OutSteer1a.gdx
$load AUX_Inverse_VActCropsGrass_QuantityActUnits_MR
$load AUX_Inverse_VActCropsGrass_Outputs_MR
$load AUX_Inverse_VActAnimalsHead_Outputs_MR
$load AUX_VCommod_Production_MR
$load AUX_VImportQuantity_MR
$load AUX_VExportQuantity_MR
$load AUX_Inverse_VCommod_Quantity_MR
$load AUX_Inverse_VExportQuantity_MR
$load AUX_Inverse_VExportQuantity_NotFromCountry_MR
$load AUX_BaselineProdLargerThanExports_MR
$load AUX_ProdPlusImport_VCommod_Production_MR
$GDXIN AuxiliaryParametersAndVariables_ForIntermediateUse_MR_OutSteer1a.gdx











$exit;

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Doe sthe above read in the stuff below??


execute_unload 'GeneralModelSets_MR'
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
OtherCharAnimals
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

NonEU_RestOfTheWorld

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
*this file is not needed here and cannot be defined or loaded, due to the FAOSTAT-Set used in its definition, thus drop
*MatchFaostatLiveAnimalItems_Activities
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

Activities_MR
Crops_MR
CoreGrassActivities_MR
CropsAndCoreGrassActivities_MR
CropsAndTempGrassActivities_MR
CoreGrassActivitiesNoTEMPGrass_MR
Regions_MR
Commodities_MR
ConcentrateCommodities_MR
ForageCommodities_MR
GrassCommodities_MR
Livestock_MR
AnimalTypeInHerd_MR
;


execute_unload 'GeneralModelParameters_Inputs_MR'
*1.1) Activities: input param
ActCropsGrass_Inputs_MR
ActAnimalsAPU_Inputs_MR
ActAnimalsHead_Inputs_MR
ActFishSeafood_Inputs_MR
ActForest_Inputs_MR
ActOthers_Inputs_MR
;

execute_unload 'GeneralModelParameters_Outputs_MR'
*1.2) Activities: output para
ActCropsGrass_Outputs_MR
ActAnimalsAPU_Outputs_MR
ActAnimalsHead_Outputs_MR
ActFishSeafood_Outputs_MR
ActForest_Outputs_MR
ActOthers_Outputs_MR
;

execute_unload 'GeneralModelParameters_OtherChar_MR'
*1.3) Activities: other chara
ActCropsGrass_OtherChar_MR
ActAnimalsAPU_OtherChar_MR
ActAnimalsHead_OtherChar_MR
ActFishSeafood_OtherChar_MR
ActForest_OtherChar_MR
ActOthers_OtherChar_MR
;

execute_unload 'GeneralModelParameters_Various_MR'
*1.4) Commodities: nutrient contents
Commod_Contents_MR
Commod_OtherChar_MR

*1.5) Commodity tree paramete
Commod_ProductionShare_MR
Commod_ExtractionRate_MR
Commod_SingleInAggregateCommodShares_MR

*1.6) Crop residues: nutrient
CropResidues_Contents_MR
CropResidues_OtherChar_MR
CropResidues_Management_MR

*1.7) Feeding rations
FeedingRations_Contents_MR
FeedingRations_OtherChar_MR
FeedingRationsHeads_Contents_MR
FeedingRationsHeads_OtherChar_MR
FeedingRationsAPU_Contents_MR

*1.8) Manure: nutrient conten
Manure_Contents_MR
Manure_OtherChar_MR
Manure_Management_MR

*1.9) Fertilizer application:
ManureApplication_MR
CropResAndBiomassApplication_MR
MinFertApplication_MR

*extraction rates:
ExtractionRate_CommodityTree_MR

*trade scale factors:
ImportScaleFactor_MR
ExportScaleFactor_MR
;


execute_unload 'GeneralModelParameters_Auxiliary_MR'
HumanCharacteristics_MR
SeedContents_MR
MineralFertilizerCharacteristics_MR
GWP_GTP_SOLm_MR
;

execute_unload 'GeneralModelVariables_ActivityQuantities_MR'
*2.1) Amount of activity units
VActCropsGrass_QuantityActUnits_MR
VActAnimalsAPU_QuantityActUnits_MR
VActAnimalsHead_QuantityActUnits_MR
VActFishSeafood_QuantityActUnits_MR
VActForest_QuantityActUnits_MR
VActOthers_QuantityActUnits_MR
;


execute_unload 'GeneralModelVariables_Inputs_MR'
*2.2) Inputs to activities
VActCropsGrass_Inputs_MR
VActAnimalsAPU_Inputs_MR
VActAnimalsHead_Inputs_MR
VActFishSeafood_Inputs_MR
VActForest_Inputs_MR
VActOthers_Inputs_MR
;


execute_unload 'GeneralModelVariables_Outputs_MR'
*2.3) Outputs from activities
VActCropsGrass_Outputs_MR
VActAnimalsAPU_Outputs_MR
VActAnimalsHead_Outputs_MR
VActFishSeafood_Outputs_MR
VActForest_Outputs_MR
VActOthers_Outputs_MR
;


execute_unload 'GeneralModelVariables_OtherChar_MR'
*2.4) Other characteristics of a
VActCropsGrass_OtherChar_MR
VActAnimalsAPU_OtherChar_MR
VActAnimalsHead_OtherChar_MR
VActFishSeafood_OtherChar_MR
VActForest_OtherChar_MR
VActOthers_OtherChar_MR
;


execute_unload 'GeneralModelVariables_Various_MR'
*2.5) Commodity quantities, nutr
VCommod_Quantity_MR
VCommod_Contents_MR
VCommod_OtherChar_MR

*2.6) Commodity untilizationa
VCommod_Production_MR
VCommod_StockChanges_MR
VCommod_Food_MR
VCommod_Feed_MR
VCommod_Seed_MR
VCommod_Processing_MR
VCommod_Waste_MR
VCommod_Other_MR

VCommod_Food_Contents_MR
VCommod_Feed_Contents_MR
VCommod_Waste_Contents_MR
VCommod_Food_OtherChar_MR
VCommod_Feed_OtherChar_MR
VCommod_Waste_OtherChar_MR

*2.7) Crop residue quantities, n
VCropResidues_Quantity_MR
VCropResidues_Contents_MR
VCropResidues_OtherChar_MR
VCropResidues_Management_MR

*2.8) Feeding rations quantities
VFeedingRations_Quantity_MR
VFeedingRations_Contents_MR
VFeedingRations_OtherChar_MR

*2.9) Manure quantities, nutrien
VManure_Quantity_MR
VManure_Contents_MR
VManure_OtherChar_MR
VManure_Management_MR

*2.10) Fertilizer application: n
VManureApplication_MR
VCropResAndBiomassApplication_MR
VMinFertApplication_MR
;


execute_unload 'GeneralModelVariables_Trade_MR'
*2.11) Import and export quantit
VImportQuantity_MR
VExportQuantity_MR
VImportLivingAnimalsHead_MR
VExportLivingAnimalsHead_MR
*for trade in beehives and other
VImportLivingAnimalsAPU_MR
VExportLivingAnimalsAPU_MR

VImportQuantity_Feed_MR
VExportQuantity_Feed_MR
;


*2.12) Commodities expressed in primary product equivalents
execute_unload 'GeneralModelVariables_CommodityTree_MR'
VPrimProd_Commod_Quantity_MR
VPrimProd_Commod_Production_MR
VPrimProd_Commod_StockChanges_MR
VPrimProd_Commod_Food_MR
VPrimProd_Commod_Feed_MR
VPrimProd_Commod_Seed_MR
VPrimProd_Commod_Processing_MR
VPrimProd_Commod_Waste_MR
VPrimProd_Commod_Other_MR
VPrimProd_ImportQuantity_MR
VPrimProd_ExportQuantity_MR
VPrimProd_Commod_Quantity_CropActivities_MR
VPrimProd_Commod_Quantity_AnimalActivities_MR
;


execute_unload 'GeneralModelVariables_Auxiliary_MR'
VMineralFertilizerQuantity_MR
VPopulationNumbers_MR
VEnergyProduction_MR
;


execute_unload 'AuxiliaryParametersAndVariables_ForIntermediateUse_MR'
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR
AUX_Inverse_VActCropsGrass_Outputs_MR
AUX_Inverse_VActAnimalsHead_Outputs_MR
AUX_VCommod_Production_MR
AUX_VImportQuantity_MR
AUX_VExportQuantity_MR
AUX_Inverse_VCommod_Quantity_MR
AUX_Inverse_VExportQuantity_MR
AUX_Inverse_VExportQuantity_NotFromCountry_MR
AUX_BaselineProdLargerThanExports_MR
AUX_ProdPlusImport_VCommod_Production_MR
;







