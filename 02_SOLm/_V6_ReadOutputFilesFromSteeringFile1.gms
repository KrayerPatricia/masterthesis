PUTCLOSE con,"_V6_ReadOutputFilesFromSteeringFile1";

$ontext;
GENERAL DESCRIPTION

*this code reads the following gdx-files with the sets, par's, var's as indicated in the code:
*the model run entities (_MR) are read later only, after their definition

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


'FOFA2050_BioeSR15_Etc_Data_InModelRunEntities.gdx' is read later only, after having introduced the "..._MR" parameters and variables, i.e. in module "_V6_VariablesAndParameters_ModelRun_ForSteeringFile2", section 5.0


DETAILED TABLE OF CONTENTS
- 1) Read the output files from Steering file 1
$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Read the output files from Steering file 1

$GDXIN  GeneralModelSets.gdx
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

$GDXIN  GeneralModelSets.gdx

*now do the aliases that have not yet been able to do:
alias(Activities,Activities_2)
alias(Regions,Regions_2)
alias(Commodities,Commodities_2)



$GDXIN GeneralModelParameters_Inputs.gdx
*1.1) Activities: input param
$load ActCropsGrass_Inputs
$load ActAnimalsAPU_Inputs
$load ActAnimalsHead_Inputs
$load ActFishSeafood_Inputs
$load ActForest_Inputs
$load ActOthers_Inputs
$GDXIN GeneralModelParameters_Inputs.gdx

$GDXIN GeneralModelParameters_Outputs.gdx
*1.2) Activities: output para
$load ActCropsGrass_Outputs
$load ActAnimalsAPU_Outputs
$load ActAnimalsHead_Outputs
$load ActFishSeafood_Outputs
$load ActForest_Outputs
$load ActOthers_Outputs
$GDXIN GeneralModelParameters_Outputs.gdx

$GDXIN GeneralModelParameters_OtherChar.gdx
*1.3) Activities: other chara
$load ActCropsGrass_OtherChar
$load ActAnimalsAPU_OtherChar
$load ActAnimalsHead_OtherChar
$load ActFishSeafood_OtherChar
$load ActForest_OtherChar
$load ActOthers_OtherChar
$GDXIN GeneralModelParameters_OtherChar.gdx

$GDXIN GeneralModelParameters_Various.gdx
*1.4) Commodities: nutrient c
$load Commod_Contents
$load Commod_OtherChar

*1.5) Commodity tree paramete
$load Commod_ProductionShare
$load Commod_ExtractionRate
$load Commod_SingleInAggregateCommodShares

*1.6) Crop residues: nutrient
$load CropResidues_Contents
$load CropResidues_OtherChar
$load CropResidues_Management

*1.7) Feeding rations
$load FeedingRations_Contents
$load FeedingRations_OtherChar
$load FeedingRationsHeads_Contents
$load FeedingRationsHeads_OtherChar
$load FeedingRationsAPU_Contents

*1.8) Manure: nutrient conten
$load Manure_Contents
$load Manure_OtherChar
$load Manure_Management

*1.9) Fertilizer application:
$load ManureApplication
$load CropResAndBiomassApplication
$load MinFertApplication

*extraction rates:
$load ExtractionRate_CommodityTree
$GDXIN GeneralModelParameters_Various.gdx


$GDXIN GeneralModelParameters_Auxiliary.gdx
$load HumanCharacteristics
$load SeedContents
$load MineralFertilizerCharacteristics
$load GWP_GTP_SOLm
$GDXIN GeneralModelParameters_Auxiliary.gdx


$GDXIN GeneralModelVariables_ActivityQuantities.gdx
*2.1) Amount of activity units
$load VActCropsGrass_QuantityActUnits
$load VActAnimalsAPU_QuantityActUnits
$load VActAnimalsHead_QuantityActUnits
$load VActFishSeafood_QuantityActUnits
$load VActForest_QuantityActUnits
$load VActOthers_QuantityActUnits
$GDXIN GeneralModelVariables_ActivityQuantities.gdx

$GDXIN GeneralModelVariables_Inputs.gdx
*2.2) Inputs to activities
$load VActCropsGrass_Inputs
$load VActAnimalsAPU_Inputs
$load VActAnimalsHead_Inputs
$load VActFishSeafood_Inputs
$load VActForest_Inputs
$load VActOthers_Inputs
$GDXIN GeneralModelVariables_Inputs.gdx

$GDXIN GeneralModelVariables_Outputs.gdx
*2.3) Outputs from activities
$load VActCropsGrass_Outputs
$load VActAnimalsAPU_Outputs
$load VActAnimalsHead_Outputs
$load VActFishSeafood_Outputs
$load VActForest_Outputs
$load VActOthers_Outputs
$GDXIN GeneralModelVariables_Outputs.gdx

$GDXIN GeneralModelVariables_OtherChar.gdx
*2.4) Other characteristics of a
$load VActCropsGrass_OtherChar
$load VActAnimalsAPU_OtherChar
$load VActAnimalsHead_OtherChar
$load VActFishSeafood_OtherChar
$load VActForest_OtherChar
$load VActOthers_OtherChar
$GDXIN GeneralModelVariables_OtherChar.gdx

$GDXIN GeneralModelVariables_Various.gdx
*2.5) Commodity quantities, nutr
$load VCommod_Quantity
$load VCommod_Contents
$load VCommod_OtherChar

*2.6) Commodity untilizationa
$load VCommod_Production
$load VCommod_StockChanges
$load VCommod_Food
$load VCommod_Feed
$load VCommod_Seed
$load VCommod_Processing
$load VCommod_Waste
$load VCommod_Other

$load VCommod_Food_Contents
$load VCommod_Feed_Contents
$load VCommod_Waste_Contents
$load VCommod_Food_OtherChar
$load VCommod_Feed_OtherChar
$load VCommod_Waste_OtherChar

*2.7) Crop residue quantities, n
$load VCropResidues_Quantity
$load VCropResidues_Contents
$load VCropResidues_OtherChar
$load VCropResidues_Management

*2.8) Feeding rations quantities
$load VFeedingRations_Quantity
$load VFeedingRations_Contents
$load VFeedingRations_OtherChar

*2.9) Manure quantities, nutrien
$load VManure_Quantity
$load VManure_Contents
$load VManure_OtherChar
$load VManure_Management

*2.10) Fertilizer application: n
$load VManureApplication
$load VCropResAndBiomassApplication
$load VMinFertApplication
$GDXIN GeneralModelVariables_Various.gdx

$GDXIN GeneralModelVariables_Trade.gdx
*2.11) Import and export quantit
$load VImportQuantity
$load VExportQuantity
$load VImportLivingAnimalsHead
$load VExportLivingAnimalsHead
*for trade in beehives and other
$load VImportLivingAnimalsAPU
$load VExportLivingAnimalsAPU

$load VImportQuantity_Feed
$load VExportQuantity_Feed
$GDXIN GeneralModelVariables_Trade.gdx


*2.12) Commodities expressed in primary product equivalents
$GDXIN GeneralModelVariables_CommodityTree.gdx
$load VPrimProd_Commod_Quantity
$load VPrimProd_Commod_Production
$load VPrimProd_Commod_StockChanges
$load VPrimProd_Commod_Food
$load VPrimProd_Commod_Feed
$load VPrimProd_Commod_Seed
$load VPrimProd_Commod_Processing
$load VPrimProd_Commod_Waste
$load VPrimProd_Commod_Other
$load VPrimProd_ImportQuantity
$load VPrimProd_ExportQuantity
$load VPrimProd_Commod_Quantity_CropActivities
$load VPrimProd_Commod_Quantity_AnimalActivities
$GDXIN GeneralModelVariables_CommodityTree.gdx


$GDXIN GeneralModelVariables_Auxiliary.gdx
$load VMineralFertilizerQuantity
$load VPopulationNumbers
$load VEnergyProduction
$GDXIN GeneralModelVariables_Auxiliary.gdx


