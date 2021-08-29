PUTCLOSE con,"_V6_Sets_GeneralModelSets";

$ontext;
GENERAL DESCRIPTION
This file declares all the sets needed in the model BESIDES the sets needed for filing in the data

DETAILED TABLE OF CONTENTS
- 1) Inputs
- 2) Outputs
- 3) Other Characteristics of activities
- 4) AnimalTypeInHerd
- 5) ProductionSystems
- 6) ProductionConditions
- 7) Commodities: nutrient contents and Other Characteristics
- 8) Crop residues: nutrient contents, Other Characteristics and management
- 9) Manure: nutrient contents, Other Characteristics and management
- 10) Fertilizer application characteristics

- 11) Regions
- 12) Activities, sub-activities, aggregate activities
- 13) Commodities

- 14) Some auxiliary sets
         14.1) Years
         14.2) Temperatures
         14.3) Greenhouse gases
           the sets 14.1-14.3 are also needed to read in data, not only in the model runs
         14.4) Sets related to mineral fertilizers
         14.5) Sets related to population and human nutrition
         14.6) Sets related to feeding rations
         14.7) Some auxiliary matching sets for reading data (to be defined here and not further up, as they refer to the set Activities and Commodities)
         14.8) Sets related to energy production


the following sets are declared below:
Set InputsCropsGrass       "Captures the different inputs to the crop and grass activities, i.e. all mass and nutrient flows that are used by the activity; examples are seeds, fertilizer, land, etc. "
Set InputsAnimals          "Captures the different inputs to the animal activities, i.e. all mass and nutrient flows that are used by the activity; examples are feed, drinking water, etc. "
Set InputsFishSeafood      "Captures the different inputs to the fish and seafood activities, i.e. all mass and nutrient flows that are used by the activity; examples are feed, mangrove area, etc. "
Set InputsForest           "Captures the different inputs to the forest activities, i.e. all mass and nutrient flows that are used by the activity; examples are energy for logging, etc. "
Set InputsOther            "Captures the different inputs to the other activities, i.e. all mass and nutrient flows that are used by the activity;"
Set OutputsCropsGrass      "Captures the different outputs from the crop and grass activities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. MainOutput1 from Wheat (i.e. grains), Straw, Roots, etc., but also emissions, losses, etc."
         Set YieldsCropsGrass(OutputsCropsGrass)       "Captures the yields from the crop and grass activities - unit: biomass per ha"
Set OutputsAnimals         "Captures the different outputs from the animal activities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. meat, milk, manure, etc., but also emissions, losses, etc."
         Set YieldsAnimals(OutputsAnimals)          "Captures the different yields from the animal activities - units: biomass per head or APU"
Set OutputsFishSeafood     "Captures the different outputs from the fish and seafood activities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. Meat, but also emissions, losses, etc."
Set OutputsForest          "Captures the different outputs from the forest activities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. wood, etc., but also emissions, losses, etc."
Set OutputsOther           "Captures the different outputs from the other activities, i.e. all mass and nutrient flows that result from an activity;"
Set OtherCharCropsGrass    "Characteristics of the crop or grass activity being undertaken that cannot be captured well by mass/nutrient flows; this can be the biodiversity loss or deforestation, but also monetary flows, etc."
         set OtherCharCropsGrass_PerHaBased(OtherCharCropsGrass)
         set OtherCharCropsGrass_PerTonYieldBased(OtherCharCropsGrass)
Set OtherCharAnimals       "Characteristics of the animal activity being undertaken that cannot be captured well by mass/nutrient flows; this can be animal welfare aspects, but also monetary flows, etc."
         Set OtherCharAnimals_PerHeadBased(OtherCharAnimals)
Set OtherCharFishSeafood   "Characteristics of the fish and seafood activity being undertaken that cannot be captured well by mass/nutrient flows; this can be seabed destruction, but also monetary flows, etc."
Set OtherCharForest        "Characteristics of the forest activity being undertaken that cannot be captured well by mass/nutrient flows; this can be biodiversity loss, but also monetary flows, etc."
Set OtherCharOther         "Characteristics of the other activity being undertaken that cannot be captured well by mass/nutrient flows;"
Set AnimalTypeInHerd       "captures the different types of animals that are needed to build a full animal production unit, or a herd structure (i.e. with a dairy cow, there are several calves of different age, sires, etc.)
         Set AnimalTypeInHerd_NoAggregates(AnimalTypeInHerd) "Subset of AnimalTypeInherd used to sum up to get the total amount of living animals - avoiding double counting by excluding AllAndAverageTypes, etc. - thus only relevant for animals with herd structure"
         Set CattleTypeInHerd(AnimalTypeInHerd)
         Set DairyCattleTypeInHerd(AnimalTypeInHerd)
         Set BeefCattleTypeInHerd(AnimalTypeInHerd)
         Set PigTypeInHerd(AnimalTypeInHerd)
         Set ProducingAnimals(AnimalTypeInHerd) "Subset of AnimalTypeInHerd containing producing animals only"
         Set SuckledAnimals(AnimalTypeInHerd) "Subset of AnimalTypeInHerd that is suckled"
         alias(AnimalTypeInHerd,AnimalTypeInHerd_2);
         Set MatchSucklingSuckledAnimals(AnimalTypeInHerdAnimalTypeInHerd_2) "Matching suckling and suckled AnimalTypeInHerd"

Set ProductionSystems      "Captures the different systems of production, such as organic or conventional, reinfed or irrigated, etc. and also animal production systems"
         set ProdSyst_OrgConAll(ProductionSystems)
         set ProdSyst_OrgCon(ProductionSystems)
         Set ProdSyst_NoAggregates(ProductionSystems)
         Set ProductionSystems_UsingMinNFert(ProductionSystems) Production systems that use mineral N fertilizers - to correctly adjust min fert use in the scenarios
         Set ProductionSystems_UsingMinPFert(ProductionSystems) Production systems that use mineral P fertilizers - to correctly adjust min fert use in the scenarios
Set ProductionConditions   "Captures the production conditions from soil types and soil characteristics, climatic conditions, etc."
Set Contents               "Captures nutrient contents of commodities"
         Set ContentsPerFreshMatterNutrients(Contents)  "Captures non-food and non-feed nutrient contents of commodities (and also seeds) - only the per fresh matter values"
         Set ContentsPerFreshMatterFood(Contents)       "Captures food nutrient contents of commodities (and also seeds) - only the per fresh matter values"
         Set ContentsPerFreshMatterFeed(Contents)       "Captures feed nutrient contents of commodities (and also seeds) - only the per fresh matter values"
Set CommodOtherChar        "Captures other characteristics of commodities"
         Set UtilSharesNOTFeed
Set CropResContents        "Captures nutrient contents of crop residues"
Set CropResOtherChar       "Captures other characteristics of crop residues"
Set CropResManagement      "Various parameters related to crop residue management - e.g. emissions, N losses, etc."
         Set CropResManagement_NotSystemShares(CropResManagement) "Same as Set CropResManagement but without 'Quantity share in CropResMan system' "
Set CropResManSystem       "Crop residue management systems"
         Set CropResManSystemCropland(CropResManSystem) "all crop residue management systems from which crop residues can then be used on croplands (or grasslands as well) as it is centrally collected, or on croplands, as it is left there"
         Set CropResManSystemGrassland(CropResManSystem) "all crop residue management systems from which crop residues can then be used on grasslands"
         Set CropResManSystem_WithVolatInApplication(CropResManSystem) "all crop res man systems that show wolatilization in application (e.g. compost, biogas slurry,...)"
         Set CropResManSystemCropland_ForOECDNBalance(CropResManSystem) "all crop residue management systems from which crop residues can then be used on croplands (or grasslands as well) as it is centrally collected, - those are covered in the OECD N balance for crop residue inputs - it does NOT INCLUDE those LEFT on cropland"
Set ManureContents         "Captures nutrient contents of manure"
Set ManureOtherChar        "Captures other characteristics of manure"
Set ManureManagement       "Various parameters related to manure management - e.g. emissions, N losses, etc., UNITS - per t manure TS DM, if not indicated otherwise"
Set ManureManSystem        "Manure management systems"
         Set ManureManSystemCropland(ManureManSystem) "all manure management systems from which manure can then be used on croplands (or grasslands as well) as it is centrally collected"
         Set ManureManSystemGrassland(ManureManSystem) "all manure management systems from which manure can be used on grasslands only as it is left there"
         Set ManureManSystem_NoAverageNoTotal(ManureManSystem) "all manure management systems WITHOUT the average and total ones"
Set FertApplicCharact      "Contains various characteristics of fertilizer application, such as N lost per ton N applied, etc."

Set Regions                "Set containing all regions, countries, subregions (e.g. NUTS2 in the EU), etc. used in the model"
         alias(Regions,Regions_2)
         Set Countries(Regions) "Sub-set containing all countries (thus excludes more aggregate regions and sub-country level regions)"
         Set FAO_Africa(Regions);
         Set FAO_Eastern_Africa(Regions);
         Set FAO_Middle_Africa(Regions);
         Set FAO_Northern_Africa(Regions);
         Set FAO_Southern_Africa(Regions);
         Set FAO_Western_Africa(Regions);
         Set FAO_Americas(Regions);
         Set FAO_Northern_America(Regions);
         Set FAO_Central_America(Regions);
         Set FAO_Caribbean(Regions);
         Set FAO_South_America(Regions);
         Set FAO_Asia(Regions);
         Set FAO_Central_Asia(Regions);
         Set FAO_Eastern_Asia(Regions);
         Set FAO_Southern_Asia(Regions);
         Set FAO_SouthEastern_Asia(Regions);
         Set FAO_Western_Asia(Regions);
         Set FAO_Europe(Regions);
         Set FAO_Eastern_Europe(Regions);
         Set FAO_Northern_Europe(Regions);
         Set FAO_Southern_Europe(Regions);
         Set FAO_Western_Europe(Regions);
         Set FAO_Oceania(Regions);
         Set FAO_Australia_NewZealand(Regions);
         Set FAO_Melanesia(Regions);
         Set FAO_Micronesia(Regions);
         Set FAO_Polynesia(Regions);
         Set FAO_EuropeanUnion(Regions);
         Set SubSaharanAfrica(Regions);
         Set FOFA2050_Rest_of_EAP(Regions)
         Set FOFA2050_Rest_of_HIC(Regions)
         Set FOFA2050_Rest_of_LAC(Regions)
         Set FOFA2050_Rest_of_MNA(Regions)
         Set FOFA2050_Rest_of_SAS(Regions)
         Set FOFA2050_Rest_of_SSA(Regions)
         Set FOFA2050_Rest_of_EU(Regions)
         Set FOFA2050_Rest_of_ECA(Regions)

         Set Regions_Switzerland(Regions)
         Set Regions_Austria(Regions)
         Set Regions_Austria_Tal(Regions)
         Set Regions_Austria_Huegel(Regions)
         Set Regions_Austria_Berg(Regions)

Set Activities             "Set containing all activities used in the model - inclusive aggregates and sub-activities"
         alias(Activities,Activities_2)
         set Livestock(Activities) "Subset containing all livestock activities"
         set Livestock_NoAggregates(Activities) "Subset containing all livestock activities - and no aggregates such as "sheep and goats""
         Set Ruminants(Activities) "Subset containing all ruminant activities"
         Set Poultry(Activities)
         Set MonogastricsNonPoultry(Activities)
         Set FishAndSeafood(Activities)
         Set NonRuminants(Activities)
         Set Livestock_NoCoupledOutputs(Activities)
         Set Livestock_CoupledMeatMilk(Activities)
         Set Livestock_CoupledMeatEggs(Activities)
         Set Livestock_NonRuminantsWithHerdStructure(Activities)
         set Crops(Activities) "Subset containing all crop activities"
         Set Cereals(Activities) "Subset containing all cereal activities"
         Set Fruits(Activities)
         Set Treenuts(Activities)
         Set Pulses(Activities)
         Set Legumes_NFixing(Activities)
         Set Crops_NoNFixingLegumes(Activities);
         Set OilCrops(Activities)
         Set StarchyRoots(Activities)
         Set SugarCrops(Activities)
         Set Vegetables(Activities)
         Set StimulantsSpices(Activities)
         Set FibresRubber(Activities)
         Set OtherCereals(Activities)
         Set CitrusFruits(Activities)
         Set Spices(Activities)
         Set OtherVegetables(Activities)  Subset of all vegetables BESIDES Tomatoes
         Set OtherOilcrops(Activities)
         Set FibresNotCotton(Activities)
         Set Fallows(Activities)
         Set EnergyCrops(Activities)
         Set ForageCrops(Activities) "Subset containing all forage crops"
         Set OtherFodderCrops(Activities) "Subset containing other fodder crops"
         Set CoreFoodCrops(Activities) "subset containing core food crops (also excluding sugar crops)"
         Set CoreFoodCrops_NoCereals(Activities) "subset containing core food crops without cereals (also excluding sugar crops)"
         Set GrassActivities(Activities) "Subset containing all grass activities"
         Set CoreGrassActivities(Activities) "Subset containing the key grass activities - no auxiliary ones for filing in data, etc."
         Set CoreGrassActivitiesNoTEMPGrass(Activities) "Subset containing the key PERMANENT grass activities - no auxiliary ones for filing in data, etc."
         Set TempMeadAndPastures(Activities) "Subset containing temporary meadows and pastures"
         Set TempAndPermMeadAndPastures(Activities) "Subset containing temporary and permanent meadows and pastures - thus covering all grasslands based on two categories from FAOSTAT"
         Set CropsAndCoreGrassActivities(Activities) "Subset of all agricultural area based activities, i.e. containing all Crops and GrassActivities";
         Set CropsAndTempGrassActivities(Activities) "Subset of all crop plus temporary grass activities";
         Set SingleCropGrassAndLivestockActivities(Activities) Subset of single activities without aggregates - both crops and livestock;

         Set FOFA2050_SweetPotato_And_Yams(Activities)
         Set FOFA2050_Rapeseed_And_Mustardseed(Activities)
         Set FOFA2050_OtherCrops(Activities)
         Set FOFA2050_OtherFibreCrops(Activities)
         Set FOFA2050_OtherFruits(Activities)
         Set FOFA2050_OtherOilseeds(Activities)
         Set FOFA2050_OtherRootsAndTubers(Activities)
         Set FOFA2050_OtherVegetables(Activities)
         Set FOFA2050_CitrusFruits(Activities)
         Set FOFA2050_DriedPulses(Activities)
         Set FOFA2050_OtherCereals(Activities)

         Set OtherCrops(Activities)

Set Commodities            "Set containing all commodities used in the model - inclusive aggregates and sub-commodities"
         alias(Commodities,Commodities_2)
         Set ForageCommodities(Commodities) "Subset containing all forage commodities"
         Set Grasscommodities(Commodities) "Subset containing all grass commodities"
         Set ConcentrateCommodities(Commodities) "Subset containing all concentrate commodities"
         Set Commodities_SingleCommodities(Commodities) "Subset containing single commodities only - no additional aggregates; but some commodities may be listed twice, e.g. Pork and Pigmeat, etc., some may be aggregates from the original data (e.g. vegetables) - but usually only one of them then has an entry, I think."
         Set Commodities_FeedGroups(Commodities) "Subset containing the aggregate feed groups (such as grass, concentrate, forage,…)"
         Set Commodities_FeedGroups_DetailedFeedingRations(Commodities) "Subset containing the aggregate feed groups (such as grass, concentrate, forage,…) as used for the DETAILED feeding rations calculations"
         Set Commodities_FeedGroups_DetailedFeedingRations_NoTot(Commodities) "Subset containing the aggregate feed groups (such as grass, concentrate, forage,…) as used for the DETAILED feeding rations calculations - without groups referring to totals over different feed groups"
         Set Commodities_Feed(Commodities) "Set of the commodities that are used as feed"
         Set Commodities_Feed_Grass(Commodities) "Set of the GRASS commodities that are used as feed"
         Set Commodities_Feed_NoForageNoGrass(Commodities) "Set of the commodities that are used as feed WITHOUT forage and grass"
         Set Commodities_Feed_ForageCrops(Commodities) "Set of the FORAGE CROP commodities that are used as feed"
         Set Commodities_Feed_Cereals(Commodities) "Set of the CEREAL commodities that are used as feed"
         Set Commodities_Feed_OilCropsAndCakes(Commodities) "Set of the OIL CROP commodities that are used as feed"
         Set Commodities_Feed_Pulses(Commodities) "Set of the PULSES commodities that are used as feed"
         Set Commodities_Feed_Roots(Commodities) "Set of the ROOT commodities that are used as feed"
         Set Commodities_Feed_Sugar(Commodities) "Set of the SUGAR commodities that are used as feed"
         Set Commodities_Feed_OthersPlants(Commodities) "Set of the OTHER PLANT commodities that are used as feed"
         Set Commodities_Feed_OthersAnimals(Commodities) "Set of the OTHER ANIMAL commodities that are used as feed"
         Set Commodities_Feed_Residues(Commodities) "Set of the RESIDUE commodities that are used as feed"
         Set CommoditiesDAQ_TradeFromToWorld(Commodities) "Commodity set used for the basic trade calculations as it includes indentical elements for all the DAQ categories and export/import - however ex and imp are to and from WORLD only"
         set SET_Cereals_CommodityGroup(Commodities)
         set SET_FodderCrops_CommodityGroup(Commodities)
         set SET_Fruits_CommodityGroup(Commodities)
         set SET_Nuts_CommodityGroup(Commodities)
         set SET_Oilcrops_CommodityGroup(Commodities)
         set SET_OtherCrops_CommodityGroup(Commodities)
         set SET_Pulses_CommodityGroup(Commodities)
         set SET_RootsAndTubers_CommodityGroup(Commodities)
         set SET_Sugarcrops_CommodityGroup(Commodities)
         set SET_Vegetables_CommodityGroup(Commodities)
         set SET_Milk_CommodityGroup(Commodities)
         set SET_Meat_CommodityGroup(Commodities)
         set SET_Eggs_CommodityGroup(Commodities)
         set SET_FishSeafood_CommodityGroup(Commodities)
         Set CommoditiesDAQ_TradeFromToWorldPrimary(Commodities) "Commodity set - only PRIMARY commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
         Set CommoditiesDAQ_TradeFromToWorldPrimaryCrops(Commodities) "Commodity set - only PRIMARY CROP commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
         Set Commodities_EquivalentToNonGrassFedAnimalActivityOutput(Commodities) Commodities that are equivalent to the output of animal activities from animals WITHOUT grass in their feeding ration
         Set CommoditiesDAQ_TradeFromToWorldPrimaryAnimals(Commodities) "Commodity set - only PRIMARY ANIMAL commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
         Set CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed(Commodities) "Commodity set - only PRIMARY grass-fed ANIMAL commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
         Set CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NonGrassFed(Commodities) "Commodity set - only PRIMARY non-grass-fed ANIMAL commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
         Set CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_FishSeafood(Commodities) "Commodity set - only PRIMARY non-grass-fed FISH/SEAFOOD commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
         Set CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary(Commodities) Derived commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
         Set CommoditiesDAQ_TradeFTWorldDirDerivedFromPrimary_Animals(Commodities) Derived ANIMAL commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
         Set CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed(Commodities) Derived grass-fed ANIMAL commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
         Set CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed(Commodities) Derived non-grass-fed ANIMAL commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
         Set CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts(Commodities) "crop commodities that are pooled from primary commodities plus derived products"
         Set CommoditiesDAQ_TradeFromToWorld_FishSeafood(Commodities) "Commodity set - fish and seafood commodities - explanation cf. excel-file NutritiveFactors_CommoditySetCorrespondences"
         Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_Crops(Commodities,Activities,OutputsCropsGrass) "Matching set to match the crop commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsPrimary(Commodities,Activities,OutputsCropsGrass) "Matching set to match the crop commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsDerived(Commodities,Activities,OutputsCropsGrass) "Matching set to match the crop commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_CropsDerived(Commodities,Commodities_2)  "Matching the derived commodities that are derived from primary commodities as captured in the previous set - DAQ and trade calculations for them are different than for the other derived commodities)
         Set MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_AnimalsDerived(Commodities,Commodities_2)  "Matching the derived ANIMAL commodities that are derived from primary commodities as captured in the previous set - DAQ and trade calculations for them are different than for the other derived commodities)"
         Set MatchPrimDerivedCommodities_DAQ_TradeFTW_AnimalsDer_GrassFed(Commodities,Commodities_2)  "Matching the derived grass-fed ANIMAL commodities that are derived from primary commodities as captured in the previous set - DAQ and trade calculations for them are different than for the other derived commodities)"
         Set MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(Commodities,Activities,OutputsCropsGrass) "Matching set to match the crop commodities that are pooled from primary commodities plus derived products with the underlying activity"
         Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsPrimary(Commodities,Activities,OutputsAnimals) "Matching set to match the animals commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchCommAct_CommoditiesDAQ_TradeFTW_AnimalsPrimaryGrassFed(Commodities,Activities,OutputsAnimals) "Matching set to match the grass-fed animals commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchCommAct_CommoditiesDAQ_TradeFTW_AnimPrimaryNonGrassFed(Commodities,Activities,OutputsAnimals) "Matching set to match the NON-grass-fed animals commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsDerived(Commodities,Activities,OutputsAnimals) "Matching set to match the animals commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,Commodities_2) "Matching set between the commodities where data on trade for a country from/to World is available, and where data on trade for a country from/to all other countries is available"

*the following sets are also needed to read in data
Set Years "Set that contains all the different years used in the model"
Set BasisyearsOLD(Years) /2005*2009/;
Set Basisyears(Years) /2009*2013/;
Set BasisyearsSeed(Years) /2008*2012/;
Set Temperatures "Set of temperature values in degree Celsius - to be used for manure management emissions calculations, for example, etc."
Set Temperatures0to100Celsius(Temperatures) "generally used temperatures - range of 0 to 100 degree Celsius"
Set TemperaturesBelow10(Temperatures)
Set TemperaturesAbove28(Temperatures)
Set GreenhouseGases "relevant greenhouse gases for agriculture, used to define the GWP and GTP, etc. in a flexible way as a parameter"

Set MineralFertilizerType "Types of mineral fertilizers"
Set MineralFertilizerProdTech "Mineral fertilizer production technologies"
Set MinFertChar "Mineral fertilizer characteristics"
Set PopulationGroups "population groups  - all, male, female, children"
Set Humans_InputsOutputsOtherCharacteristics "inputs to, outputs from and other characteristics of humans"
set FeedingRationOtherChar "Characteristics of feeding rations that is not captured in the set contents or so - e.g. quantity share in DM for all commodities, etc."
Set MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Activities)
Set Match_ActivityOutputsToCommodities_Crops(Activities,OutputsCropsGrass,Commodities) "Set to link the main outputs from the crop activities to commodities, that can then be further worked with on commodity level"
Set Match_ActivityOutputsToCommodities_Animals(Activities,OutputsAnimals,Commodities) "Set to link the main outputs from the animal activities to commodities, that can then be further worked with on commodity level"
Set Match_FeedCommoditiesToFeedCommodGroups(Commodities,Commodities_2) "Matches the commodities used as feed to the four main feed groups (Conc, Forage, Grass, Residues)"
Set Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities,Commodities_2) "Matches the commodities used as feed to the main feed groups, separating main and byprod for concentrates (ConcMainProd, ConcByProd, Forage, Grass, Residues)"
Set Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities,Commodities_2) "Matches the commodities used as feed to the main feed groups, using the groups used for the detailed feeding rations calculations"

Set ConversionLevel Primary or secondary energy
Set EnergyType Type of energy (electricity heat etc.)
Set EnergySource Energy source (biomass fossil etc.)
Set EnergyChar   Characteristics of the energy production (quantity or emissions etc.)

$offtext;



$ontext;
matching needed: activity.main outputs and corresponding commodities.

May do some specific paraleters/sets such as detailed feeding ratiion - which is noly used intermediate, also micro nutr supply feed - e.g. for Ollies model...

THEN check whether it runs
Then link read data to these common par, var, sets

then start doing model code.


Still to be done in FAOSTAT_CropProduction: look for STBD!!!!!


FILE XXXXXXXXXXX Go on 15)
$offtext;

*MODEL CODE

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Inputs

Set InputsCropsGrass    "Captures the different inputs to the crop and grass activities, i.e. all mass and nutrient flows that are used by the activity; examples are seeds, fertilizer, land, etc. "
/
"Seeds (t)"
"N inputs from seeds (tN)"
"P inputs from seeds (tP2O5)"
"Irrigation water (m3)"
"Irrigation water (m3) - water stress adjusted"

"Green Water Footprint (m3)"
"Blue Water Footprint (m3)"
"Grey Water Footprint (m3)"

"N fixation (tN)"
"N deposition (tN)"

*biomass covers crop residues and other biomass such as food waste, etc.
"N from CropRes/biomass as fert (tN)"
"N from mineral fert (tN)"
"N from manure as fert (tN)"
"N from all fertilizers (tN)"

"P from CropRes/biomass as fert (tP2O5)"
"P from mineral fert (tP2O5)"
"P from manure as fert (tP2O5)"
"P from all fertilizers (tP2O5)"

"Labour use - total (h)"
"Labour use - management (h)"
"Labour use - harvest (h)"
"Labour use - other (h)"

*new elements for aggregations:
"N inputs - crops (tN)"

"Total CED (MJ)"
"Total GWP from CED (tCO2e)"

*elements used for the correction of yields for changes of N inputs:
"N_max - tot input"
"N_max - in output"
"Total N input"
/;

Set InputsAnimals    "Captures the different inputs to the animal activities, i.e. all mass and nutrient flows that are used by the activity; examples are feed, drinking water, etc. "
/
"Drinking water (m3)"

"Feed (t DM)"
"Feed Grass (t DM)"
"Feed Forage (t DM)"
"Feed Conc (t DM)"
"Feed Residues (t DM)"
"Feed Byprod (t DM)"
"Feed Waste (t DM)"

"Feed GE (MJ)"
"Feed Grass GE (MJ)"
"Feed Forage GE (MJ)"
"Feed Conc GE (MJ)"
"Feed Residues GE (MJ)"
"Feed Byprod GE (MJ)"
"Feed Waste GE (MJ)"

"Feed ME (MJ)"
"Feed Grass ME (MJ)"
"Feed Forage ME (MJ)"
"Feed Conc ME (MJ)"
"Feed Residues ME (MJ)"
"Feed Byprod ME (MJ)"
"Feed Waste ME (MJ)"

"Feed XP (t)"
"Feed Grass XP (t)"
"Feed Forage XP (t)"
"Feed Conc XP (t)"
"Feed Residues XP (t)"
"Feed Byprod XP (t)"
"Feed Waste XP (t)"

"Total CED (MJ)"
"Total GWP from CED (tCO2e)"

"Labour use - total (h)"
"Labour use - stable/animals (h)"
"Labour use - management (h)"
"Labour use - other (h)"
/;

Set InputsFishSeafood    "Captures the different inputs to the fish and seafood activities, i.e. all mass and nutrient flows that are used by the activity; examples are feed, mangrove area, etc. "
/
"Feed (t DM)"
"Feed Conc (t DM)"
"Feed Byprod (t DM)"
"Feed Waste (t DM)"

"Feed GE (MJ)"
"Feed Conc GE (MJ)"
"Feed Byprod GE (MJ)"
"Feed Waste GE (MJ)"

"Feed ME (MJ)"
"Feed Conc ME (MJ)"
"Feed Byprod ME (MJ)"
"Feed Waste ME (MJ)"

"Feed XP (t)"
"Feed Conc XP (t)"
"Feed Byprod XP (t)"
"Feed Waste XP (t)"
/;

Set InputsForest    "Captures the different inputs to the forest activities, i.e. all mass and nutrient flows that are used by the activity; examples are energy for logging, etc. "
/
"N fixation (tN)"
"N deposition (tN)"

"N from CropRes/biomass as fert (tN)"
"N from mineral fert (tN)"

"P from CropRes/biomass as fert (tP2O5)"
"P from mineral fert (tP2O5)"
/;

Set InputsOther    "Captures the different inputs to the other activities, i.e. all mass and nutrient flows that are used by the activity;"
/
"Feed (t DM)"
"Feed GE (MJ)"
/;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Outputs

Set OutputsCropsGrass   "Captures the different outputs from the crop and grassactivities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. MainOutput1 from Wheat (i.e. grains), Straw, Roots, etc., but also emissions, losses, etc."
*MainOutput2 becomes relevant e.g. for mixed cropping, e.g with millet and pigeon peas: millet is MainOutput1, pigeon peas are MainOutput2
/
"MainOutput1 (t)"
"MainOutput2 (t)"
"MainOutput3 (t)"
*MainOutput2 e.g. cashew apple for cashew nuts (which are MainOutput1), or cassava leaves for cassava; or for mixed crops, e.g. Pulses-millet: one is MainOutput1, the other 2, etc.
"MainOutput1 (t DM)"
"MainOutput2 (t DM)"
"MainOutput3 (t DM)"

"Roots (t)"
"Stems (t)"
"Straw (t)"
"Leaves (t)"
"Other Residues (t)"
"Average Residues (t)"
"Roots (t DM)"
"Stems (t DM)"
"Straw (t DM)"
"Leaves (t DM)"
"Other Residues (t DM)"
"Average Residues (t DM)"

"CH4 flooded rice (tCH4)"
"CH4 flooded rice (tCO2e)"

"Direct N2O from mineral fert N applic (tN2O)"
"Direct N2O from CropRes/biomass as fert N applic (tN2O)"
"Direct N2O from manure as fert N applic (tN2O)"

"Direct N2O from mineral fert N applic (tCO2e)"
"Direct N2O from CropRes/biomass as fert N applic (tCO2e)"
"Direct N2O from manure as fert N applic (tCO2e)"

"Direct N loss from mineral fert N applic (tN)"
"Direct N loss from CropRes/biomass as fert N applic (tN)"
"Direct N loss from manure as fert N applic (tN)"

"N2O volat from mineral fert N applic (tN2O)"
"N2O volat from CropRes/biomass as fert N applic (tN2O)"
"N2O volat from manure as fert N applic (tN2O)"

"N2O volat from mineral fert N applic (tCO2e)"
"N2O volat from CropRes/biomass as fert N applic (tCO2e)"
"N2O volat from manure as fert N applic (tCO2e)"

"NH3 from mineral fert N applic (tNH3)"
"NH3 from CropRes/biomass as fert N applic (tNH3)"
"NH3 from manure as fert N applic (tNH3)"

"N2O leach from mineral fert N applic (tN2O)"
"N2O leach from CropRes/biomass as fert N applic (tN2O)"
"N2O leach from manure as fert N applic (tN2O)"

"N2O leach from mineral fert N applic (tCO2e)"
"N2O leach from CropRes/biomass as fert N applic (tCO2e)"
"N2O leach from manure as fert N applic (tCO2e)"

"N volat from mineral fert N applic (tN)"
"N volat from CropRes/biomass as fert N applic (tN)"
"N volat from manure as fert N applic (tN)"

"N leach from mineral fert N applic (tN)"
"N leach from CropRes/biomass as fert N applic (tN)"
"N leach from manure as fert N applic (tN)"

"NH3 from soils (tNH3)"

"NOx from fert applic (tNOx)"

*DROP THE FOLLOWING, not needed, are they?
*"DeforestEmissions (tCO2e)"
*"CultOrgSoilsEmiss (tCO2e)"
*"CultOrgSoilsEmiss - only C (tCO2e)"
*"CultOrgSoilsEmiss - only N2O (tCO2e)"

*new elements for aggregations:
"N outputs - crops (tN)"

*elements used for the correction of yields for changes of N inputs:
"N in biomass (output + residues) (tN)"
"MainOutput1 (t) - N-corrected"

*further elements
"N outputs WITHOUT residues - crops (tN)"
"P outputs WITHOUT residues - crops (tP2O5)"
"N in outputs - for fert. before management (tN)"
"P in outputs - for fert. before management (tP2O5)"
/;

Set YieldsCropsGrass(OutputsCropsGrass)   "Captures the yields from the crop and grassactivities - unit: biomass per ha"
*MainOutput2 becomes relevant e.g. for mixed cropping, e.g with millet and pigeon peas: millet is MainOutput1, pigeon peas are MainOutput2
/
"MainOutput1 (t)"
"MainOutput2 (t)"
"MainOutput3 (t)"
*MainOutput2 e.g. cashew apple for cashew nuts (which are MainOutput1), or cassava leaves for cassava; or for mixed crops, e.g. Pulses-millet: one is MainOutput1, the other 2, etc.
"MainOutput1 (t DM)"
"MainOutput2 (t DM)"
"MainOutput3 (t DM)"

"Roots (t)"
"Stems (t)"
"Straw (t)"
"Leaves (t)"
"Other Residues (t)"
"Average Residues (t)"
"Roots (t DM)"
"Stems (t DM)"
"Straw (t DM)"
"Leaves (t DM)"
"Other Residues (t DM)"
"Average Residues (t DM)"
/;

Set OutputsAnimals   "Captures the different outputs from the animal activities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. meat, milk, manure, etc., but also emissions, losses, etc."
/
"Meat (t)"
"Milk (t)"
"Eggs (t)"
"Honey (t)"
"Wool (t)"
"Offals (t)"
"Blood (t)"
"Bones (t)"
"HidesSkins (t)"
"Fat (t)"
"Wax (t)"

"Meat (t DM)"
"Milk (t DM)"
"Eggs (t DM)"
"Honey (t DM)"
"Wool (t DM)"
"Offals (t DM)"
"Blood (t DM)"
"Bones (t DM)"
"HidesSkins (t DM)"
"Fat (t DM)"
"Wax (t DM)"

"All food output (t)"
"All food output (t DM)"

"Enteric ferment (t CH4)"
"Enteric ferment (t CO2e)"

"N in manure (tN)"
"P in manure (tP2O5)"
"VS DM in manure (tVS)"
"TS DM in manure (tTS)"

"N in manure - grazing systems (tN)"
"N in manure - non grazing systems (tN)"

"Manure man CH4 (tCH4)"
"Manure man CH4 (tCO2e)"
"Manure man N2O dir (tN2O)"
"Manure man N2O dir (tCO2e)"
"Manure man N in N2O dir (tN)"
"Manure man N2O volat (tN2O)"
"Manure man N2O volat (tCO2e)"
"Manure man N volat (tN)"
"Manure man N2O leach (tN2O)"
"Manure man N2O leach (tCO2e)"
"Manure man N leach (tN)"
"Housing NH3 from manure (tN)"
"Housing NH3 from manure (tNH3)"
"Manure man N2O total (tN2O)"
"Manure man N2O total (tCO2e)"
"Manure man N total loss (tN)"
"Manure man+housing N total loss (tN)"
"Manure man P total loss (tP2O5)"
"Manure man GHG total (tCO2e)"

"Manure man NH3 (tNH3)"

"Manure N for crop areas (tN)"
"Manure N for grass areas (tN)"

"Manure P for crop areas (tP2O5)"
"Manure P for grass areas (tP2O5)"

"Grazing N2O dir (tN2O)"
"Grazing N2O dir (tCO2e)"
"Grazing N in N2O dir (tN)"
"Grazing N2O volat (tN2O)"
"Grazing N2O volat (tCO2e)"
"Grazing N volat (tN)"
"Grazing NH3 (tNH3)"
"Grazing N2O leach (tN2O)"
"Grazing N2O leach (tCO2e)"
"Grazing N leach (tN)"
"Grazing-Housing NH3 from manure (tNH3)"
"Grazing-Housing NH3 from manure (tN)"
"NH3 from animals, - grazing + housing (tNH3)"
"Grazing N2O total (tCO2e)"
"Grazing N total loss (tN)"
"Grazing+Grazing-housing N total loss (tN)"
/;

Set YieldsAnimals(OutputsAnimals)   "Captures the different yields from the animal activities - units: biomass per head or APU"
/
"Meat (t)"
"Milk (t)"
"Eggs (t)"
"Honey (t)"
"Wool (t)"
"Offals (t)"
"Blood (t)"
"Bones (t)"
"HidesSkins (t)"
"Fat (t)"
"Wax (t)"

"Meat (t DM)"
"Milk (t DM)"
"Eggs (t DM)"
"Honey (t DM)"
"Wool (t DM)"
"Offals (t DM)"
"Blood (t DM)"
"Bones (t DM)"
"HidesSkins (t DM)"
"Fat (t DM)"
"Wax (t DM)"

"All food output (t)"
"All food output (t DM)"
/;

Set OutputsFishSeafood   "Captures the different outputs from the fish and seafood activities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. Meat, but also emissions, losses, etc."
/
"Wildcatch Meat (t)"
*aquaculture may also be measured on a per ha basis for some species - but then this is coded as area input per ton production
"Aquacult Meat (t)"
"Bycatch (t)"

"Wildcatch Meat (t DM)"
"Aquacult Meat (t DM)"
"Bycatch (t DM)"
/;

Set OutputsForest   "Captures the different outputs from the forest activities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. wood, etc., but also emissions, losses, etc."
/
"Wood (t)"
"Wood (t DM)"
"Forestry byproducts (t)"
"Forestry byproducts (t DM)"
"Forestry residues (t)"
"Forestry residues (t DM)"
/;

Set OutputsOther   "Captures the different outputs from the other activities, i.e. all mass and nutrient flows that result from an activity;"
/
"Silk (t)"
"Silk (tDM)"
/;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Other Characteristics of activities

Set OtherCharCropsGrass "Characteristics of the crop or grass activity being undertaken that cannot be captured well by mass/nutrient flows; this can be the biodiversity loss or deforestation, but also monetary flows, etc."
/
"Irrigated area (ha)"
"Rainfed area (ha)"
"Share irrigated in total area (share ha)"
"Share rainfed in total area (share ha)"
"Cropping intensity (ratio)"
"Organic area (ha)"
"Convent area (ha)"
"Share organic in total area (share ha)"
"Organic yield gap (ratio org/conv yield)"
"Share legumes in cropland (share ha)"

"Legumes in grasslands (ha)"
"Legumes croplands (ha)"

*the following are per ton yield:
"Land use per Mainoutput1 (ha)"
"DM in MainOutput1 (tDM)"
"N in MainOutput1 (tN)"
"P in MainOutput1 (tP2O5)"
"K in MainOutput1 (tK2O)"
"N in MainOutput2 (tN)"
"P in MainOutput2 (tP2O5)"
"K in MainOutput2 (tK2O)"
"N in MainOutput3 (tN)"
"P in MainOutput3 (tP2O5)"
"K in MainOutput3 (tK2O)"

"N fixation per ton MainOutput1 (tN)"
"N in residues - per ton MainOutput1 (tN)"
"P in residues - per ton MainOutput1 (tP2O5)"
"K in residues - per ton MainOutput1 (tK2O)"

"N req - per ton yield based (tN)"
"P req - per ton yield based (tP2O5)"
"K req - per ton yield based (tK2O)"

"Share N req per crop in N req of all crops"
"Share P req per crop in P req of all crops"
"Share K req per crop in K req of all crops"

"Share N req per crop or grass in N req of all crops and grass"
"Share P req per crop or grass in P req of all crops and grass"
"Share K req per crop or grass in K req of all crops and grass"

"Share N req per crop/grass in N req of all crops+TEMP grass"
"Share P req per crop/grass in P req of all crops+TEMP grass"
"Share K req per crop/grass in K req of all crops+TEMP grass"

"Share N req per grass type in N req of all grass"
"Share P req per grass type in P req of all grass"

"Share N req grass in N req of all grass WITHOUT temp grass"
"Share P req grass in P req of all grass WITHOUT temp grass"
"Share K req grass in K req of all grass WITHOUT temp grass"

"Share N req crop in N req of all crops - All PS w Min N"
"Share N req crop/gr in N req all cr+TEMP gr - All PS w Min N"

"Share P req crop in P req of all crops - All PS w Min P"
"Share P req crop/gr in P req all cr+TEMP gr - All PS w Min P"

"Deforestation (ha)"
"Deforest GHG emissions (tCO2e)"

"CultOrgSoils (ha)"
"CultOrgSoils GHG emissions (tCO2e)"
"CultOrgSoils C emissions (tCO2e)"
"CultOrgSoils N2O emissions (tCO2e)"

"LandDegradation (index)"
"Soil water erosion (t soil lost)"
"Soil wind erosion (t soil lost)"
"Aggreg. Pest. use level (index)"
"Pesticides intensity (index)"
"Pesticides legislation (index)"
"Pesticides use (index)"

"C sequestered in woody biomass (tC)"
"C sequestered in soils (tC)"

*new elements for aggregations:
"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)"
"Total GHG em. - crops, no defor/orgSoils (tCO2e)"
"N balance - plot level based (tN)"
"NH3 from areas (tNH3)"

"Share single crop in crop group"

"Area occupied physically (ha)"

"IrrigW per t MOutput1 (m3) - total demand"
"IrrigW per t MOutput1 (m3) - min. demand given irrig. area %"
"IrrigW per t MOutput1 (m3) - exp. demand: mean of real,total"
*"Share irrigated in total area (share ha)"
"Water stress index (ratio): lack of water for donwstream use"
"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc."
"RED: exp. IrrigW per t MOutput1 (m3), account. water scarc."
"RED: min. IrrigW per t MOutput1 (m3), account. water scarc."

"Green Water Footprint per t MainOutput1 (m3)"
"Blue Water Footprint per t MainOutput1 (m3)"
"Grey Water Footprint per t MainOutput1 (m3)"

/;

*for deriving totals, define subsets of pre ha and per ton yield characteristics separately:
set OtherCharCropsGrass_PerHaBased(OtherCharCropsGrass)
/
"Legumes in grasslands (ha)"
"Legumes croplands (ha)"

"Deforestation (ha)"
"Deforest GHG emissions (tCO2e)"

"CultOrgSoils (ha)"
"CultOrgSoils GHG emissions (tCO2e)"
"CultOrgSoils C emissions (tCO2e)"
"CultOrgSoils N2O emissions (tCO2e)"

"LandDegradation (index)"
"Soil water erosion (t soil lost)"
"Soil wind erosion (t soil lost)"
"Aggreg. Pest. use level (index)"
"Pesticides intensity (index)"
"Pesticides legislation (index)"
"Pesticides use (index)"

"C sequestered in woody biomass (tC)"
"C sequestered in soils (tC)"

"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)"
"Total GHG em. - crops, no defor/orgSoils (tCO2e)"
"N balance - plot level based (tN)"
"NH3 from areas (tNH3)"

"Area occupied physically (ha)"
/;

set OtherCharCropsGrass_PerTonYieldBased(OtherCharCropsGrass)
/
"Land use per Mainoutput1 (ha)"
"DM in MainOutput1 (tDM)"
"N in MainOutput1 (tN)"
"P in MainOutput1 (tP2O5)"
"K in MainOutput1 (tK2O)"
"N in MainOutput2 (tN)"
"P in MainOutput2 (tP2O5)"
"K in MainOutput2 (tK2O)"
"N in MainOutput3 (tN)"
"P in MainOutput3 (tP2O5)"
"K in MainOutput3 (tK2O)"

"N fixation per ton MainOutput1 (tN)"
"N in residues - per ton MainOutput1 (tN)"
"P in residues - per ton MainOutput1 (tP2O5)"
"K in residues - per ton MainOutput1 (tK2O)"

"N req - per ton yield based (tN)"
"P req - per ton yield based (tP2O5)"
"K req - per ton yield based (tK2O)"

$ontext;
not to be included here - this is only used to derive totals, and this is already done with the repsective parameters on a per ha basis
"IrrigW per t MOutput1 (m3) - total demand"
"IrrigW per t MOutput1 (m3) - min. demand given irrig. area %"
"IrrigW per t MOutput1 (m3) - exp. demand: mean of real,total"
"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc."
"RED: exp. IrrigW per t MOutput1 (m3), account. water scarc."
"RED: min. IrrigW per t MOutput1 (m3), account. water scarc."

"Green Water Footprint per t MainOutput1 (m3)"
"Blue Water Footprint per t MainOutput1 (m3)"
"Grey Water Footprint per t MainOutput1 (m3)"
$offtext;

/;




Set OtherCharAnimals "Characteristics of the animal activity being undertaken that cannot be captured well by mass/nutrient flows; this can be animal welfare aspects, but also monetary flows, etc."
/
"Liveweight (t)"

"Grass in Feed DM (share)"
"Forage crops in Feed DM (share)"
"Concentrates in Feed DM (share)"
"Residues in Feed DM (share)"
"Byproducs in Feed DM (share)"
"Waste in Feed DM (share)"
"Cereals in Feed DM (share)"

"Total FeedGE in DM cont. (MJ/t)"
"Total FeedME in DM cont. (MJ/t)"
"Total FeedXP in DM cont. (t/t)"

"Total FeedGE in FM cont. (MJ/t)"
"Total FeedME in FM cont. (MJ/t)"
"Total FeedXP in FM cont. (t/t)"

"Digestibility of Feed (%)"

*feed REQUIREMENTS (NOT what is actually fed!)
"FeedME_Req_Total (MJ)"
"FeedXP_Req_Total (t)"
"FeedGE_Req_Total (MJ)"

"FeedGE_Req_Total from Conc (MJ)"
"FeedGE_Req_Total from Forage (MJ)"
"FeedGE_Req_Total from Grass (MJ)"
"FeedGE_Req_Total from Residues (MJ)"

"FeedXP_Req_Total from Conc (t)"
"FeedXP_Req_Total from Forage (t)"
"FeedXP_Req_Total from Grass (t)"
"FeedXP_Req_Total from Residues (t)"

"FeedDM_Req_Total from Conc (t DM)"
"FeedDM_Req_Total from Forage (t DM)"
"FeedDM_Req_Total from Grass (t DM)"
"FeedDM_Req_Total from Residues (t DM)"
"FeedDM_Req_Total (t DM)",

"Share in FeedGE_Req_Total"
"Share in FeedGE_Req_Total from Conc"
"Share in FeedGE_Req_Total from Forage"
"Share in FeedGE_Req_Total from Grass"
"Share in FeedGE_Req_Total from Residues"

"FeedME_Req_MilkProd (MJ)"
"FeedME_Req_Maintenance (MJ)"
"FeedME_Req_Walking (MJ)"
"FeedME_Req_Pregnancy (MJ)"

"FeedXP_Req_MilkProd (t)"
"FeedXP_Req_Maintenance (t)"
"FeedXP_Req_Walking (t)"
"FeedXP_Req_Pregnancy (t)"

*several dairy feed req parameters:
"DailyWalkingDistance (km)"
"Summergrazing (days)"
"ME to produce 1kg milk (MJ/kg milk)"
"ME maintenance per weight per day (MJ/kg liveweight/day)"
"ME maintenance basis per day (MJ/day)"
"ME walking per km (MJ/km)"
"ME pregnancy per weight per day (MJ/kg liveweight/day)"
"ME pregnancy basis per day (MJ/day)"

"XPperME_InFeedReq (gXP/MJ)"
"UE_per_GE (share)"
"Animal specific FeedGE cont (MJ/t)"

"organic animal number (heads)"
"convent animal number (heads)"
"share organic in total animals (share heads)"
"organic yield gap (ratio org/conv yield)"

"Share FeedGE req per animal act in FeedGE req of all animals"
"Share FeedME req per animal act in FeedME req of all animals"
"Share FeedXP req per animal act in FeedXP req of all animals"

"Share animal type in total living animals"

"share_AnimalInDairyHerdType In TotalLivingDairyAnimals"
"share_ProducingAnimalInDairyHerdType In TotalLivingDairyAnimals"
"share_AnimalInBeefHerdType In TotalLivingBeefAnimals"
"share_ProducingAnimalInBeefHerdType In TotalLivingBeefAnimals"
"share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals"
"Scale factor meat producing cattle"
"share meat to milk producing animals"
"share meat to egg producing animals"
"share meat to milk producing animals (dairy herd)"

"Relation protein contents - Eggs/Meat"
"Relation calorie contents - Eggs/Meat"
"Relation producer price - Eggs/Meat"
"Relation protein contents - Milk/Meat"
"Relation calorie contents - Milk/Meat"
"Relation producer price - Milk/Meat"

"Composite mass-based alloc factor - eggs/meat"
"Composite protein-based alloc factor - eggs/meat"
"Composite calorie-based alloc factor - eggs/meat"
"Composite price-based alloc factor - eggs/meat"
"Composite mass-based alloc factor - milk/meat"
"Composite protein-based alloc factor - milk/meat"
"Composite calorie-based alloc factor - milk/meat"
"Composite price-based alloc factor - milk/meat"

"N in manure per ton liveweight (tN/t lw/y)"
"P in manure per ton liveweight (tP2O5/t lw/y)"

"Share suckled to suckling"

*new elements for aggregations:
"Total N-losses from animals, - manure management (tN)"
"Total N-losses from animals, - man man + housing (tN)"
"Total N-losses from animals, - grazing (tN)"
"Total N-losses from animals, - grazing + housing (tN)"

"Manure Man GHG emissions - animals (tCO2e)"
"Total GHG emissions - animals (tCO2e)"
"NH3 from animals, - manure management (tNH3)"
"NH3 from animals, - grazing + housing (tNH3)"

"Animal welfare: antibiotics use index"
"Animal welfare: heat stress index 2020"
"Animal welfare: heat stress index 2030"
"Animal welfare: heat stress index 2050"
"Animal welfare: transport volume index"
"Animal welfare: production intensity index - ruminants"
"Animal welfare: production intensity index - monogastric meat"
"Animal welfare: production intensity index - eggs"

"Share animal number - per NUTS2 in region"
/;

Set OtherCharAnimals_PerHeadBased(OtherCharAnimals)
/
"FeedME_Req_Total (MJ)"
"FeedXP_Req_Total (t)"
"FeedGE_Req_Total (MJ)"

"FeedGE_Req_Total from Conc (MJ)"
"FeedGE_Req_Total from Forage (MJ)"
"FeedGE_Req_Total from Grass (MJ)"
"FeedGE_Req_Total from Residues (MJ)"

"FeedXP_Req_Total from Conc (t)"
"FeedXP_Req_Total from Forage (t)"
"FeedXP_Req_Total from Grass (t)"
"FeedXP_Req_Total from Residues (t)"

"FeedDM_Req_Total from Conc (t DM)"
"FeedDM_Req_Total from Forage (t DM)"
"FeedDM_Req_Total from Grass (t DM)"
"FeedDM_Req_Total from Residues (t DM)"
"FeedDM_Req_Total (t DM)"

"Total N-losses from animals, - manure management (tN)"
"Total N-losses from animals, - man man + housing (tN)"
"Total N-losses from animals, - grazing (tN)"
"Total N-losses from animals, - grazing + housing (tN)"

"Manure Man GHG emissions - animals (tCO2e)"
"Total GHG emissions - animals (tCO2e)"
"NH3 from animals, - manure management (tNH3)"
"NH3 from animals, - grazing + housing (tNH3)"

"Animal welfare: antibiotics use index"
"Animal welfare: heat stress index 2020"
"Animal welfare: heat stress index 2030"
"Animal welfare: heat stress index 2050"
"Animal welfare: transport volume index"
"Animal welfare: production intensity index - ruminants"
"Animal welfare: production intensity index - monogastric meat"
"Animal welfare: production intensity index - eggs"
/;

Set OtherCharFishSeafood "Characteristics of the fish and seafood activity being undertaken that cannot be captured well by mass/nutrient flows; this can be seabed destruction, but also monetary flows, etc."
/
"Seabed destruction (index)"
/;

Set OtherCharForest "Characteristics of the forest activity being undertaken that cannot be captured well by mass/nutrient flows; this can be biodiversity loss, but also monetary flows, etc."
/
"Forest res bioe N for areas (tN/t DM res)"
"Forest res bioe N for areas (tN)"
"Aggregate biodiversity value (index)"
/;

Set OtherCharOther "Characteristics of the other activity being undertaken that cannot be captured well by mass/nutrient flows;"
/
"capital investment needs (1000 $)"
/;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) AnimalTypeInHerd

Set AnimalTypeInHerd "captures the different types of animals that are needed to build a full animal production unit, or a herd structure (i.e. with a dairy cow, there are several calves of different age, sires, etc.)"
/
AllAndAverageTypes

"Producing"
"Meat Producing"
"Milk Producing"
"Egg Producing"
"HidesSkins Producing"
"Honey Producing"
"Wax Producing"
"Offals Producing"
"Wool Producing"

Living

*IPCC 2006 herd structure, as used in Vol4, chapter 10, tables in the appendix
"Dairy Cow IPCC2006"
"Mature females IPCC2006"
"Mature males IPCC2006"
"Mature females - Grazing IPCC2006"
"Mature males - Grazing IPCC2006"
"Mature females - Farming IPCC2006"
"Mature males - Farming IPCC2006"
"Draft bullocks IPCC2006"
"Bulls - Grazing IPCC2006"
"Calves on milk IPCC2006"
"Calves on forage IPCC2006"
"Growing heifers/steers IPCC2006"
"Replacement/growing IPCC2006"
"Feedlot cattle IPCC2006"
"Young IPCC2006"

*the following captures all "non-dairy cow"-cattle and other ruminants and pigs, used in IPCC 2006, vol 4, ch 10, table 10.19
"Other Cattle IPCC2006"
"Buffaloes IPCC2006"
"Market Swine IPCC2006"
"Breeding Swine IPCC2006"
"Sheep IPCC2006"
"Goat IPCC2006"
"Camel IPCC2006"
"Horse IPCC2006"
"Mule IPCC2006"
"Ass IPCC2006"

*the following captures the average pig used in IPCC 2006, vol 4, ch 10, table 10.19
"Pig IPCC2006"

*the following captures the different poultry and chickens used in IPCC 2006, vol 4, ch 10, table 10.19 (and maybe others)
"Chickens Layer (dry) IPCC2006"
"Chickens Layer (wet) IPCC2006"
"Chicken Layers  IPCC2006"
"Chickens Broilers IPCC2006"
"Turkey IPCC2006"
"Duck IPCC2006"
"Average Chicken IPCC2006"
"Hens >= 1y old IPCC2006"
"Other Chicken >= 1y old IPCC2006"
"Pullet - Chicken < 1y old IPCC2006"
*the following caputres additional animals used in IPCC 2006, vol 4, ch 10, Table 10.19
"Mink and Polecat IPCC2006"
"Rabbits IPCC2006"
"Fox and Racoon IPCC2006"

*used for digestibility of feed - check the original values for this and whether these categories are really needed
"Poultry confined IPCC2006"
"Poultry free-range IPCC2006"
"Pigs confined IPCC2006"
"Pigs free-range IPCC2006"

*Cattle: General structure used as default herd structure as calculated in SOLm V2 and used till V6
Producing_Dairy_Cattle
Dsires

DFemaleCalves1
DFemaleCalves2
DFemaleCalves3

DMaleCalves1
DMaleCalves2

Bcows
Bsires

BFemaleCalves1
BFemaleCalves2

BMaleCalves1
BMaleCalves2

*Pigs: General structure used as default herd structure as calculated in SOLm V2 and used till V6
Sows
Sucklers
Weaners
Fatteners
Boars
Rep_Sows
Rep_Boars
/;

Set AnimalTypeInHerd_NoAggregates(AnimalTypeInHerd) "Subset of AnimalTypeInherd used to sum up to get the total amount of living animals - avoiding double counting by excluding AllAndAverageTypes, etc. - thus only relevant for animals with herd structure"
/
Producing_Dairy_Cattle
Dsires
DFemaleCalves1
DFemaleCalves2
DFemaleCalves3
DMaleCalves1
DMaleCalves2
Bcows
Bsires
BFemaleCalves1
BFemaleCalves2
BMaleCalves1
BMaleCalves2

Sows
Sucklers
Weaners
Fatteners
Boars
Rep_Sows
Rep_Boars
/;

Set CattleTypeInHerd(AnimalTypeInHerd)
/
Producing_Dairy_Cattle
Dsires
DFemaleCalves1
DFemaleCalves2
DFemaleCalves3
DMaleCalves1
DMaleCalves2
Bcows
Bsires
BFemaleCalves1
BFemaleCalves2
BMaleCalves1
BMaleCalves2
/;

Set DairyCattleTypeInHerd(AnimalTypeInHerd)
/
Producing_Dairy_Cattle
Dsires
DFemaleCalves1
DFemaleCalves2
DFemaleCalves3
DMaleCalves1
DMaleCalves2
/;

Set BeefCattleTypeInHerd(AnimalTypeInHerd)
/
Bcows
Bsires
BFemaleCalves1
BFemaleCalves2
BMaleCalves1
BMaleCalves2
/;

Set PigTypeInHerd(AnimalTypeInHerd)
/
Sows
Sucklers
Weaners
Fatteners
Boars
Rep_Sows
Rep_Boars
/;

Set ProducingAnimals(AnimalTypeInHerd) "Subset of AnimalTypeInHerd containing producing animals only"
/
"Producing"
"Meat Producing"
"Milk Producing"
"Egg Producing"
"HidesSkins Producing"
"Honey Producing"
"Wax Producing"
"Offals Producing"
"Wool Producing"
/;

Set SuckledAnimals(AnimalTypeInHerd) "Subset of AnimalTypeInHerd that is suckled"
/
Sucklers
/;

alias(AnimalTypeInHerd,AnimalTypeInHerd_2);
Set MatchSucklingSuckledAnimals(AnimalTypeInHerd,AnimalTypeInHerd_2) "Matching suckling and suckled AnimalTypeInHerd"
/
Sows.Sucklers
/;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) ProductionSystems

Set ProductionSystems            "Captures the different systems of production, such as organic or conventional, reinfed or irrigated, etc. and also animal production systems"
/
AllProdSyst
"AllProdSyst that use min N fert"
"AllProdSyst that use min P fert"
Convent
Organic
Irrigated
Rainfed/;

set ProdSyst_OrgConAll(ProductionSystems)
/
AllProdSyst
Convent
Organic
/;


Set ProductionSystems_UsingMinNFert(ProductionSystems) Production systems that use mineral N fertilizers - to correctly adjust min fert use in the scenarios
/
AllProdSyst
Convent
Irrigated
Rainfed/
;

Set ProductionSystems_UsingMinPFert(ProductionSystems) Production systems that use mineral P fertilizers - to correctly adjust min fert use in the scenarios
/
AllProdSyst
Convent
Organic
Irrigated
Rainfed/
;

set ProdSyst_OrgCon(ProductionSystems)
/
Convent
Organic
/;

Set ProdSyst_NoAggregates(ProductionSystems)
/
Convent
Organic
Irrigated
Rainfed/;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) ProductionConditions

Set ProductionConditions         "Captures the production conditions from soil types and soil characteristics, climatic conditions, etc."
/
AllProdCond
/;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*7) Commodities: nutrient contents and other characteristics

Set Contents     "Captures nutrient contents of commodities (and also seeds)"
/
"Calories (kcal)"
"Protein (t)"
"Fat (t)"
"N (t)"
"P2O5 (t)"
"K2O (t)"
"N in DM (t)"
"P2O5 in DM (t)"
"FeedME (MJ)"
"FeedGE (MJ)"
"FeedXP (t)"
"DM (t)"
"FeedME in DM (MJ)"
"FeedGE in DM (MJ)"
"FeedXP in DM (t)"

"FeedGE (MJ) - left after feeding ruminants"

"FeedQuant (t) - left after feeding ruminants"
"FeedQuant DM (t) - left after feeding ruminants"
"FeedGE (MJ - undersupply to ruminants"
"FeedXP (t) - undersupply to ruminants"

"Milk solid contents (t)"

"Calories - domestic prod. (kcal)"
"Protein - domestic prod. (t)"

"N for org. fert (tN)"
/;

Set ContentsPerFreshMatterNutrients(Contents)  "Captures non-food and non-feed nutrient contents of commodities (and also seeds) - only the per fresh matter values"
/
"N (t)"
"P2O5 (t)"
"K2O (t)"
"DM (t)"
"Milk solid contents (t)"
/;

Set ContentsPerFreshMatterFood(Contents)       "Captures food nutrient contents of commodities (and also seeds) - only the per fresh matter values"
/
"Calories (kcal)"
"Protein (t)"
"Fat (t)"
/;
Set ContentsPerFreshMatterFeed(Contents)       "Captures feed nutrient contents of commodities (and also seeds) - only the per fresh matter values"
/
"FeedME (MJ)"
"FeedGE (MJ)"
"FeedXP (t)"
/;



Set CommodOtherChar     "Captures other characteristics of commodities"
/
"Consumer price ($)"
"Producer price ($)"
"Util feed (share)"
"Util food (share)"
"Util seed (share)"
"Util processing (share)"
"Util waste (share)"
"Util other (share)"

*in some cases, specific use for organic fertilizer or energy is needed:
"Util organic fert (share)"
"Util bioenergy (share)"

"Feed GE supply/demand ratio Total"
"Feed GE supply/demand ratio Conc"
"Feed GE supply/demand ratio Forage"
"Feed GE supply/demand ratio Grass"
"Feed GE supply/demand ratio Residues"

"Feed GE supply/demand ratio Conc - left after feeding ruminants"
"Feed DM supply/demand ratio"
"Feed DM supply/demand ratio - left after feeding ruminants"

"DM share in relevant feed group"

"Global Export/Import ratio"
"Global Exp/Imp corr factor - no exp-scaling for some regions"

"Calories per capita (kcal/cap/day)"
"Protein per capita (g/cap/day)"

*the following is needed for calibration of trade flows in FOFA_BAU_2050
"kcal_FOFA_2050 / kcal_calc_2050"
"Cal pc - FOFA original (kcal/cap/day)"
"Prot_FOFA_2050 / Prot_calc_2050"
"Prot pc - FOFA original (g/cap/day)"

"shells etc. for bioenergy (t)"
/;

Set UtilSharesNOTFeed(CommodOtherChar)     "all utilizsation shares BESIDES feed"
/
*"Util feed (share)"
"Util food (share)"
"Util seed (share)"
"Util processing (share)"
"Util waste (share)"
"Util other (share)"
/;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*8) Crop residues: nutrient contents, Other Characteristics and management

*for now, this can also contain other biomass e.g. from waste that is composted (alone or togther with residues, etc.) - thus, crop res man system "biogas" can also be fed with food waste and the parameters then relate to this as well

Set CropResContents     "Captures nutrient contents of crop residues"
/
"N (t) - before management"
"P2O5 (t) - before management"
"K2O (t) - before management"
"DM (t) - before management"
/;

Set CropResOtherChar     "Captures other characteristics of crop residues"
/
"Residue share t DM / t DM MainOutput1"
/;

Set CropResManagement "Various parameters related to crop residue management - e.g. emissions, N losses, etc. - values per ton residue or, for the variables: total values"
/
"Quantity share in CropResMan system"
"Crop res man CH4 (tCH4)"
"Crop res man N2O (tN2O)"
"Crop res man N - before management (tN)"
"Crop res man P - before management (tP2O5)"
"Crop res man N loss (tN)"
"Crop res N for areas (tN)"
"Crop res N for areas (tN/t DM res)"
"Crop res man share P lost (tP2O5/tP2O5 in crop res)"
"Crop res man P loss (tP2O5)"
"Crop res P for areas (tP2O5)"
"Crop res N for areas (tN) - for OECD N-balance"
"Crop res P for areas (tP2O5) - for OECD P-balance"

"Main output N as fert. for areas (tN)"
"Main output N as fert. loss (tN)"
"Main output N as fert. N2O (tN2O)"
/;
Set CropResManagement_NotSystemShares(CropResManagement) "Same as Set CropResManagement but without 'Quantity share in CropResMan system' "
/
"Crop res man CH4 (tCH4)"
"Crop res man N2O (tN2O)"
"Crop res man N - before management (tN)"
"Crop res man P - before management (tP2O5)"
"Crop res man N loss (tN)"
"Crop res N for areas (tN)"
"Crop res N for areas (tN/t DM res)"
"Crop res man share P lost (tP2O5/tP2O5 in crop res)"
"Crop res man P loss (tP2O5)"
"Crop res P for areas (tP2O5)"

"Main output N as fert. for areas (tN)"
"Main output N as fert. loss (tN)"
"Main output N as fert. N2O (tN2O)"
/;

Set CropResManSystem "Crop residue management systems"
/
"AllAndAverageCropResManSystem"
"AllCropResManSystems_WithVolatInApplication"
"Left on croplands"
"Open burning"
"Composting"
"Feed"
"Livestock bedding"
"Biogas"
"All bioenergy"
"Cooking"
"Dumped"
"Left on grasslands"
/;

Set CropResManSystemCropland(CropResManSystem) "all crop residue management systems from which crop residues can then be used on croplands (or grasslands as well) as it is centrally collected, or on croplands, as it is left there"
/
Composting
"Left on croplands"
Biogas
"All bioenergy"
"Open burning"
Cooking
Feed
Dumped
"Livestock bedding"
/;

Set CropResManSystemGrassland(CropResManSystem) "all crop residue management systems from which crop residues can then be used on grasslands"
/
"Left on grasslands"
/;

Set CropResManSystem_WithVolatInApplication(CropResManSystem) "all crop res man systems that show wolatilization in application (e.g. compost, biogas slurry,...)"
/
"Composting"
"Biogas"
"All bioenergy"
/;

*for the OECD-balance, there is a small part covering inputs from residues; this seems to be those residues that are returned to the field, i.e. NOT those LEFT ON THE FIELD, bu tonly Compost and biogas (currently) - thus do the sum without this.
Set CropResManSystemCropland_ForOECDNBalance(CropResManSystem) "all crop residue management systems from which crop residues can then be used on croplands (or grasslands as well) as it is centrally collected, - those are covered in the OECD N balance for crop residue inputs - it does NOT INCLUDE those LEFT on cropland"
/
Composting
Biogas
/;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*9) Manure: nutrient contents, Other Characteristics and management

Set ManureContents     "Captures nutrient contents of manure"
/
"N in VS DM (tN/t VS DM)"
"N in TS DM (tN/t TS DM)"
"P in VS DM (tP2O5/t VS DM)"
"P in TS DM (tP2O5/t TS DM)"
/;

Set ManureOtherChar     "Captures other characteristics of manure"
/
"Ash content in feed DM (share)"
/;

Set ManureManagement "Various parameters related to manure management - e.g. emissions, N losses, etc.; UNITS - per t manure TS DM, if not indicated otherwise)"
/
"Quantity share in ManureMan system"
"Quantity share in ManureMan syst - N-based"
"MCF: CH4 conversion factor (%)"
"Bo: max. CH4 prod. cap. (m3CH4/kgVS)"
"Manure man N volat (% of N in manure)"
"Manure man N leach (% of N in manure)"
"Manure man N2O dir (tN2O-N/tN)"
"Manure man N2O-N from N volat (tN/tN volat)"
"Manure man N2O-N from N leach (tN/tN leach)"
"Manure man P loss as % of P in manure (%)"

"Manure man NH3-N (% of N in manure)"

"Manure man N in N2O dir (tN)"
"Manure man N2O dir (tCO2e)"
"Manure man N volat (tN)"
"Manure man N2O volat (tN2O)"
"Manure man N2O volat (tCO2e)"
"Manure man N leach (tN)"
"Manure man N2O leach (tN2O)"
"Manure man N2O leach (tCO2e)"

"Housing NH3 from manure (tNH3-N/tN)"
"Housing N in NH3 from manure (tN)"

"Manure man NH3 (tNH3)"

"Manure man N2O total (tCO2e)"
"Manure man N total loss (tN)"
"Manure man+housing N total loss (tN)"
"Manure man P total loss (tP2O5)"

"Manure man N loss (tN)"
"Manure N for areas (tN)"
"Manure N for crop areas (tN)"
"Manure N for grass areas (tN)"
*"Manure man share P lost (tP2O5/tP2O5 in crop res)"
"Manure man P loss (tP2O5)"
"Manure P for areas (tP2O5)"
"Manure P for crop areas (tP2O5)"
"Manure P for grass areas (tP2O5)"

"Manure man CH4 (tCH4)"
"Manure man CH4 (tCO2e)"
/;

Set ManureManSystem "Manure management systems"
/
AllManManSystems
AverageManManSystems
ManManSystems_OutputUsableForCroplands
ManManSystems_OnGrasslands

*the following are the systems used in the IPCC 2006 guidelines for GHG inventories
"Uncovered anaerobic Lagoon"
"Liquid/Slurry with natural crust cover"
"Liquid/Slurry without natural crust cover"
"Solid Storage"
"Drylot"
"Pasture/Range/Paddock"
"Daily Spread"
"Anaerobic digester"
"Burned for Fuel"
*deep bedding is often cattle/swine deep bedding - but sometimes also for other animals, thus we drop cattle/swine
"Deep bedding < 1 month"
"Deep bedding > 1 month"
*the following two are introduced for N2O emissions, Table 10.21
"Deep bedding - no mixing"
"Deep bedding - active mixing"
"Pit below animal confinenemts < 1 month"
"Pit below animal confinenemts > 1 month"
"Manure composting - in vessel"
"Manure composting - static pile"
"Manure composting - intensive windrow"
"Manure composting - passive windrow"
"Poultry manure with litter"
"Poultry manure without litter"
"Aerobic treatment"
*the following two are introduced for N2O emissions, Table 10.21
"Aerobic treatment - natural aeration"
"Aerobic treatment - forced aeration"
"Other"
/;

Set ManureManSystemCropland(ManureManSystem) "all manure management systems from which manure can then be used on croplands (or grasslands as well) as it is centrally collected"
/
"Uncovered anaerobic Lagoon"
"Liquid/Slurry with natural crust cover"
"Liquid/Slurry without natural crust cover"
"Solid Storage"
"Drylot"
"Daily Spread"
*manure passed through an anarobic digester end up on cropland as well
"Anaerobic digester"
*deep bedding is often cattle/swine deep bedding - but sometimes also for other animals, thus we drop cattle/swine
"Deep bedding < 1 month"
"Deep bedding > 1 month"
*the following two are introduced for N2O emissions, Table 10.21
"Deep bedding - no mixing"
"Deep bedding - active mixing"
"Pit below animal confinenemts < 1 month"
"Pit below animal confinenemts > 1 month"
"Manure composting - in vessel"
"Manure composting - static pile"
"Manure composting - intensive windrow"
"Manure composting - passive windrow"
"Poultry manure with litter"
"Poultry manure without litter"
"Aerobic treatment"
*the following two are introduced for N2O emissions, Table 10.21
"Aerobic treatment - natural aeration"
"Aerobic treatment - forced aeration"
"Other"
/;
Set ManureManSystemGrassland(ManureManSystem) "all manure management systems from which manure can be used on grasslands only as it is left there"
/
"Pasture/Range/Paddock"
/;
Set ManureManSystem_NoAverageNoTotal(ManureManSystem) "all manure management systems WITHOUT the average and total ones"
/
*the following are the systems used in the IPCC 2006 guidelines for GHG inventories
"Uncovered anaerobic Lagoon"
"Liquid/Slurry with natural crust cover"
"Liquid/Slurry without natural crust cover"
"Solid Storage"
"Drylot"
"Pasture/Range/Paddock"
"Daily Spread"
"Anaerobic digester"
"Burned for Fuel"
*deep bedding is often cattle/swine deep bedding - but sometimes also for other animals, thus we drop cattle/swine
"Deep bedding < 1 month"
"Deep bedding > 1 month"
*the following two are introduced for N2O emissions, Table 10.21
"Deep bedding - no mixing"
"Deep bedding - active mixing"
"Pit below animal confinenemts < 1 month"
"Pit below animal confinenemts > 1 month"
"Manure composting - in vessel"
"Manure composting - static pile"
"Manure composting - intensive windrow"
"Manure composting - passive windrow"
"Poultry manure with litter"
"Poultry manure without litter"
"Aerobic treatment"
*the following two are introduced for N2O emissions, Table 10.21
"Aerobic treatment - natural aeration"
"Aerobic treatment - forced aeration"
"Other"
/;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*10) Fertilizer application characteristics
Set FertApplicCharact "Contains various characteristics of fertilizer application, such as N lost per ton N applied, etc."
/
"N2O-N per kg fertilizer N applied (tN/tN)"
"Volatized N as percentage of fertilizer N applied (%)"
"Leached N as percentage of fertilizer N applied (%)"
"N2O-N per kg N volatized from fert applic (share)"
"N2O-N per kg N leached from fert applic (share)"

"NH3-N as percentage of fertilizer N applied (%)"
"total N lost: dir+leach+volat (share)"
/;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*11) Regions
Set Regions    "Set containing all regions, countries, subregions (e.g. NUTS2 in the EU), etc. used in the model"
/
*the following equals the set FAOSTAT_CountriesAndRegions
"Afghanistan"
"Africa"
"Albania"
"Algeria"
"American Samoa"
"Americas"
"Angola"
"Antigua and Barbuda"
"Argentina"
"Armenia"
*start: 1992
"Aruba"
"Asia"
"Australia"
"Australia & New Zealand"
"Austria"
"Azerbaijan"
*start: 1992
"Bahamas"
"Bahrain"
"Bangladesh"
"Barbados"
"Belarus"
*start: 1992
"Belgium"
*start: 2000
"Belgium-Luxembourg"
*end: 1999
"Belize"
"Benin"
"Bermuda"
"Bhutan"
"Bolivia (Plurinational State of)"
"Bosnia and Herzegovina"
*start: 1992
"Botswana"
"Brazil"
"British Virgin Islands"
"Brunei Darussalam"
"Bulgaria"
"Burkina Faso"
"Burundi"
"Cabo Verde"
"Cambodia"
"Cameroon"
"Canada"
"Caribbean"
"Cayman Islands"
"Central African Republic"
"Central America"
"Central Asia"
"Chad"
"Chile"
"China"
"China, Hong Kong SAR"
"China, Macao SAR"
"China, mainland"
"China, Taiwan Province of"
"Colombia"
"Comoros"
"Congo"
"Cook Islands"
"Costa Rica"
"Côte d'Ivoire"
"Croatia"
*start: 1992
"Cuba"
"Cyprus"
"Czechia"
*start: 1993
"Czechoslovakia"
*start: 1992
"Democratic People's Republic of Korea"
"Democratic Republic of the Congo"
"Denmark"
"Djibouti"
"Dominica"
"Dominican Republic"
"Eastern Africa"
"Eastern Asia"
"Eastern Europe"
"Ecuador"
"Egypt"
"El Salvador"
"Equatorial Guinea"
"Eritrea"
*start: 1993
"Estonia"
*start: 1992
"Ethiopia"
*start: 1993
"Ethiopia PDR"
*end: 1992
"Europe"
"European Union"
"Falkland Islands (Malvinas)"
"Faroe Islands"
"Fiji"
"Finland"
"France"
"French Polynesia"
"Gabon"
"Gambia"
"Georgia"
*start 1992
"Germany"
"Ghana"
"Greece"
"Grenada"
"Guam"
"Guatemala"
"Guinea"
"Guinea-Bissau"
"Guyana"
"Haiti"
"Honduras"
"Hungary"
"Iceland"
"India"
"Indonesia"
"Iran (Islamic Republic of)"
"Iraq"
"Ireland"
"Israel"
"Italy"
"Jamaica"
"Japan"
"Jordan"
"Kazakhstan"
*start: 1992
"Kenya"
"Kiribati"
"Kuwait"
"Kyrgyzstan"
*start: 1992
"Land Locked Developing Countries"
"Lao People's Democratic Republic"
"Latvia"
*start: 1992
"Least Developed Countries"
"Lebanon"
"Lesotho"
"Liberia"
"Libya"
"Lithuania"
*start: 1992
"Low Income Food Deficit Countries"
"Luxembourg"
*start: 2000
"Madagascar"
"Malawi"
"Malaysia"
"Maldives"
"Mali"
"Malta"
*we added "Marshall Isalnds" albeit it is not in the list downloaded from FAOSTAT - but it is in the data
"Marshall Islands"
"Mauritania"
"Mauritius"
"Melanesia"
"Mexico"
"Micronesia"
"Middle Africa"
"Mongolia"
"Montenegro"
*start: 2006
"Morocco"
"Mozambique"
"Myanmar"
"Namibia"
"Nauru"
"Nepal"
"Net Food Importing Developing Countries"
"Netherlands"
"Netherlands Antilles (former)"
*start: 2010
"New Caledonia"
"New Zealand"
"Nicaragua"
"Niger"
"Nigeria"
"Niue"
"Norfolk Island"
"Northern Africa"
"Northern America"
"Northern Europe"
"Norway"
"Occupied Palestinian Territory"
"Oceania"
"Oman"
"Pacific Islands Trust Territory"
*start: 1990
"Pakistan"
"Panama"
"Papua New Guinea"
"Paraguay"
"Peru"
"Philippines"
"Poland"
"Polynesia"
"Portugal"
"Qatar"
"Republic of Korea"
"Republic of Moldova"
*start: 1992
"Romania"
"Russian Federation"
*start: 1992
"Rwanda"
"Saint Kitts and Nevis"
"Saint Lucia"
"Saint Pierre and Miquelon"
"Saint Vincent and the Grenadines"
"Samoa"
"Sao Tome and Principe"
"Saudi Arabia"
"Senegal"
"Serbia"
*start 2006
"Serbia and Montenegro"
*start: 1992; end: 2005
"Seychelles"
"Sierra Leone"
"Singapore"
"Slovakia"
*start: 1993
"Slovenia"
*start: 1992
"Small Island Developing States"
"Solomon Islands"
"Somalia"
"South Africa"
"South America"
"South Sudan"
*start: 2012
"South-Eastern Asia"
"Southern Africa"
"Southern Asia"
"Southern Europe"
"Spain"
"Sri Lanka"
"Sudan"
*start: 2012
*"Sudan (former)"
*end: 2011 - drop everywhere, as we have a baseline from 2008-2012 and then we double count Sudan - as any new baseline will be more recent, this is no problem, as we then anyway would not have Sudan (former) anymore
"Suriname"
"Swaziland"
"Sweden"
"Switzerland"
"Syrian Arab Republic"
"Tajikistan"
*start: 1992
"Thailand"
"The former Yugoslav Republic of Macedonia"
*start: 1992
"Timor-Leste"
"Togo"
"Tonga"
"Trinidad and Tobago"
"Tunisia"
"Turkey"
"Turkmenistan"
*start: 1992
"Tuvalu"
"Uganda"
"Ukraine"
*startt: 1992
"United Arab Emirates"
"United Kingdom"
"United Republic of Tanzania"
"United States of America"
"Uruguay"
"USSR"
*end: 1991
"Uzbekistan"
*start: 1992
"Vanuatu"
"Venezuela (Bolivarian Republic of)"
"Viet Nam"
"Western Africa"
"Western Asia"
"Western Europe"
"World"
"Yemen"
"Yugoslav SFR"
*end: 1991
"Zambia"
"Zimbabwe"
*till here it equals the set FAOSTAT_CountriesAndRegions
*the following is a categorisation currently not used officially in FAOSTAT - but we need it for certain assignments and thus introduce it to this set
"Developed Countries"
"Developing Countries"
"Indian Subcontinent"

*additional countries needed to file in BioeSR15 data:
"French Guiana"
"Guadeloupe"
"Martinique"
"Mayotte"
*"Micronesia"
"Puerto Rico"
"Reunion"
"Taiwan"
"United States Virgin Islands"
"Western Sahara"

*additional
"Saint Helena"
Montserrat
"Subsaharan Africa"

*additional regions and countries needed to file in FOFA2050 data:
"FOFA2050 Rest of EAP"
"FOFA2050 Rest of HIC"
"FOFA2050 Rest of LAC"
"FOFA2050 Rest of MNA"
"FOFA2050 Rest of SAS"
"FOFA2050 Rest of SSA"
"FOFA2050 Rest of EU"
"FOFA2050 Rest of ECA"

*additional regions to file in BioeSR15 data:
R5ASIA
R5LAM
R5MAF
"R5OECD90+EU"
R5REF
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
CPA
FSU
NAM
PAO
PAS
SAS

*additional regions to capture subregions for CH and AT to file in more detailed data for CH and AT:
Switzerland_Tal
Switzerland_Huegel
Switzerland_Berg

Austria_Hochalpen
Austria_Voralpen
Austria_Alpenostrand
Austria_WaldMuehlViertel
Austria_KaerntnerBecken
Austria_Alpenvorland
Austria_SuedoestlFlachHuegelland
Austria_NordoestlFlachHuegelland

*used for some adjustment of trade flows in the commodity quantity etc. calculations
"Regions - with exp scaling"
"Regions - no exp scaling"

"European Union plus CH"

/;

*we need this twice for the trade statistics:
alias(Regions,Regions_2)

Set Countries(Regions) "Sub-set containing all countries (thus excludes more aggregate regions and sub-country level regions)"
*as contained in the file FAOSTAT_CountryAndRegionsDefinition_11_12_2017.csv
*the entries with code below 1000
/
"Afghanistan"
"Albania"
"Algeria"
"American Samoa"
"Angola"
"Antigua and Barbuda"
"Argentina"
"Armenia"
*start: 1992
"Aruba"
"Australia"
"Austria"
"Azerbaijan"
*start: 1992
"Bahamas"
"Bahrain"
"Bangladesh"
"Barbados"
"Belarus"
*start: 1992
"Belgium"
*start: 2000
"Belgium-Luxembourg"
*end: 1999
"Belize"
"Benin"
"Bermuda"
"Bhutan"
"Bolivia (Plurinational State of)"
"Bosnia and Herzegovina"
*start: 1992
"Botswana"
"Brazil"
"British Virgin Islands"
"Brunei Darussalam"
"Bulgaria"
"Burkina Faso"
"Burundi"
"Cabo Verde"
"Cambodia"
"Cameroon"
"Canada"
"Cayman Islands"
"Central African Republic"
"Chad"
"Chile"
"China"
*"China, Hong Kong SAR"
*"China, Macao SAR"
*"China, mainland"
*"China, Taiwan Province of"
"Colombia"
"Comoros"
"Congo"
"Cook Islands"
"Costa Rica"
"Côte d'Ivoire"
"Croatia"
*start: 1992
"Cuba"
"Cyprus"
"Czechia"
*start: 1993
"Czechoslovakia"
*end: 1992
"Democratic People's Republic of Korea"
"Democratic Republic of the Congo"
"Denmark"
"Djibouti"
"Dominica"
"Dominican Republic"
"Ecuador"
"Egypt"
"El Salvador"
"Equatorial Guinea"
"Eritrea"
*start: 1993
"Estonia"
*start: 1992
"Ethiopia"
*start: 1993
"Ethiopia PDR"
*end: 1992
"Falkland Islands (Malvinas)"
"Faroe Islands"
"Fiji"
"Finland"
"France"
"French Polynesia"
"Gabon"
"Gambia"
"Georgia"
*start 1992
"Germany"
"Ghana"
"Greece"
"Grenada"
"Guam"
"Guatemala"
"Guinea"
"Guinea-Bissau"
"Guyana"
"Haiti"
"Honduras"
"Hungary"
"Iceland"
"India"
"Indonesia"
"Iran (Islamic Republic of)"
"Iraq"
"Ireland"
"Israel"
"Italy"
"Jamaica"
"Japan"
"Jordan"
"Kazakhstan"
*start: 1992
"Kenya"
"Kiribati"
"Kuwait"
"Kyrgyzstan"
*start: 1992
"Lao People's Democratic Republic"
"Latvia"
*start: 1992
"Lebanon"
"Lesotho"
"Liberia"
"Libya"
"Lithuania"
*start: 1992
"Luxembourg"
*start: 2000
"Madagascar"
"Malawi"
"Malaysia"
"Maldives"
"Mali"
"Malta"
"Marshall Islands"
"Mauritania"
"Mauritius"
"Mexico"
"Mongolia"
"Montenegro"
*start: 2006
"Morocco"
"Mozambique"
"Myanmar"
"Namibia"
"Nauru"
"Nepal"
"Netherlands"
"Netherlands Antilles (former)"
*start: 2010
"New Caledonia"
"New Zealand"
"Nicaragua"
"Niger"
"Nigeria"
"Niue"
"Norfolk Island"
"Norway"
"Occupied Palestinian Territory"
"Oman"
"Pacific Islands Trust Territory"
*start: 1990
"Pakistan"
"Panama"
"Papua New Guinea"
"Paraguay"
"Peru"
"Philippines"
"Poland"
"Portugal"
"Qatar"
"Republic of Korea"
"Republic of Moldova"
*start: 1992
"Romania"
"Russian Federation"
*start: 1992
"Rwanda"
"Saint Kitts and Nevis"
"Saint Lucia"
"Saint Pierre and Miquelon"
"Saint Vincent and the Grenadines"
"Samoa"
"Sao Tome and Principe"
"Saudi Arabia"
"Senegal"
"Serbia"
*start 2006
"Serbia and Montenegro"
*start: 1992; end: 2005
"Seychelles"
"Sierra Leone"
"Singapore"
"Slovakia"
*start: 1993
"Slovenia"
*start: 1992
"Solomon Islands"
"Somalia"
"South Africa"
"South Sudan"
*start: 2012
"Spain"
"Sri Lanka"
"Sudan"
*start: 2012
*"Sudan (former)"
*end: 2011 - drop everywhere, as we have a baseline from 2008-2012 and then we double count Sudan - as any new baseline will be more recent, this is no problem, as we then anyway would not have Sudan (former) anymore
"Suriname"
"Swaziland"
"Sweden"
"Switzerland"
"Syrian Arab Republic"
"Tajikistan"
*start: 1992
"Thailand"
"The former Yugoslav Republic of Macedonia"
*start: 1992
"Timor-Leste"
"Togo"
"Tonga"
"Trinidad and Tobago"
"Tunisia"
"Turkey"
"Turkmenistan"
*start: 1992
"Tuvalu"
"Uganda"
"Ukraine"
*start: 1992
"United Arab Emirates"
"United Kingdom"
"United Republic of Tanzania"
"United States of America"
"Uruguay"
"USSR"
*end: 1991
"Uzbekistan"
*start: 1992
"Vanuatu"
"Venezuela (Bolivarian Republic of)"
"Viet Nam"
"Yemen"
"Yugoslav SFR"
*end: 1991
"Zambia"
"Zimbabwe"

*additional regions needed to file in BioeSR15 data:
"French Guiana"
"Guadeloupe"
"Martinique"
"Mayotte"
"Micronesia"
"Puerto Rico"
"Reunion"
"Taiwan"
"United States Virgin Islands"
"Western Sahara"

*additional needed
"Saint Helena"
Montserrat
/;

*world regions used by FAO, etc.
*those are defined in a separate excel-file, filed in here:
*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewGeographicGroups% == "YES"
$call GDXXRW GeographicGroups_2_12_2019.xlsx  o=GeographicGroups_2_12_2019.gdx  index=index!a1:e30
$endif;

Set FAO_Africa(Regions);
Set FAO_Eastern_Africa(Regions);
Set FAO_Middle_Africa(Regions);
Set FAO_Northern_Africa(Regions);
Set FAO_Southern_Africa(Regions);
Set FAO_Western_Africa(Regions);
Set FAO_Americas(Regions);
Set FAO_Northern_America(Regions);
Set FAO_Central_America(Regions);
Set FAO_Caribbean(Regions);
Set FAO_South_America(Regions);
Set FAO_Asia(Regions);
Set FAO_Central_Asia(Regions);
Set FAO_Eastern_Asia(Regions);
Set FAO_Southern_Asia(Regions);
Set FAO_SouthEastern_Asia(Regions);
Set FAO_Western_Asia(Regions);
Set FAO_Europe(Regions);
Set FAO_Eastern_Europe(Regions);
Set FAO_Northern_Europe(Regions);
Set FAO_Southern_Europe(Regions);
Set FAO_Western_Europe(Regions);
Set FAO_Oceania(Regions);
Set FAO_Australia_NewZealand(Regions);
Set FAO_Melanesia(Regions);
Set FAO_Micronesia(Regions);
Set FAO_Polynesia(Regions);
Set FAO_EuropeanUnion(Regions);
Set SubSaharanAfrica(Regions);


$gdxin GeographicGroups_2_12_2019.gdx
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
$gdxin

Set Match_GeographicAggregates_SingleCountries(Regions,Regions_2)
/
"Africa"         .#FAO_Africa
"Eastern Africa" .#FAO_Eastern_Africa
"Middle Africa"  .#FAO_Middle_Africa
"Northern Africa".#FAO_Northern_Africa
"Southern Africa".#FAO_Southern_Africa
"Western Africa".#FAO_Western_Africa

"Americas"        .#FAO_Americas
"Northern America".#FAO_Northern_America
"Central America" .#FAO_Central_America
"Caribbean"       .#FAO_Caribbean
"South America"   .#FAO_South_America
"Asia"              .#FAO_Asia
"Central Asia"      .#FAO_Central_Asia
"Eastern Asia"      .#FAO_Eastern_Asia
"South-Eastern Asia".#FAO_Southern_Asia
"Southern Asia"     .#FAO_SouthEastern_Asia
"Western Asia"      .#FAO_Western_Asia
"Europe"         .#FAO_Europe
"Eastern Europe" .#FAO_Eastern_Europe
"Northern Europe".#FAO_Northern_Europe
"Southern Europe".#FAO_Southern_Europe
"Western Europe".#FAO_Western_Europe
"Oceania".#FAO_Oceania
"Australia & New Zealand".#FAO_Australia_NewZealand
"Melanesia".#FAO_Melanesia
"Micronesia".#FAO_Micronesia
"Polynesia".#FAO_Polynesia
"European Union".#FAO_EuropeanUnion
"Subsaharan Africa".#SubSaharanAfrica

*"Switzerland".#Regions_Switzerland
*"Austria".#Regions_Austria

"World".#Countries
/;


*some regions needed to file in FOFA2050 data
*we did not add a number of smallest countries that would also be part of these subregions - they are listed but starred out
Set FOFA2050_Rest_of_EAP(Regions)
/
Fiji
Kiribati
"Marshall Islands"
Micronesia
Nauru
"Papua New Guinea"
Samoa
"Solomon Islands"
Timor-Leste
Tonga
Tuvalu
Vanuatu

/;
Set FOFA2050_Rest_of_HIC(Regions)
/
*Andorra
"Antigua and Barbuda"
Aruba
Bahamas
Bahrain
Barbados
Bermuda
"British Virgin Islands"
"Brunei Darussalam"
"Cayman Islands"
*"Channel Islands"
*"Curaçao"
"Faroe Islands"
"French Polynesia"
*Gibraltar
*Greenland
Guam
*Hong Kong SAR, China
Iceland
*"Isle of Man"
Kuwait
*Liechtenstein
*Macao SAR, China
*Monaco
"New Caledonia"
*"Northern Mariana Islands"
Oman
*Palau
"Puerto Rico"
Qatar
*"San Marino"
Seychelles
Singapore
*Sint Maarten (Dutch part)
"Saint Kitts and Nevis"
*St. Martin (French part)
Switzerland
*"Taiwan, China"
*Turks and Caicos Islands
"United Arab Emirates"
"United States Virgin Islands"
/;
Set FOFA2050_Rest_of_LAC(Regions)
/
Belize
Dominica
Grenada
"Saint Lucia"
"Saint Vincent and the Grenadines"

/;
Set FOFA2050_Rest_of_MNA(Regions)
/
Djibouti
"Syrian Arab Republic"
*"West Bank and Gaza"

/;
Set FOFA2050_Rest_of_SAS(Regions)
/
Burundi
"Cabo Verde"
Comoros
"Democratic Republic of the Congo"
"Equatorial Guinea"
Eritrea
Guinea-Bissau
"Sao Tome and Principe"
Somalia
"South Sudan"
Sudan
/;
Set FOFA2050_Rest_of_SSA(Regions)
/
Bhutan
Maldives
/;
Set FOFA2050_Rest_of_EU(Regions)
/
Cyprus
Lithuania
Luxembourg
Malta
Slovenia
/;
Set FOFA2050_Rest_of_ECA(Regions)
/
*"Kosovo"
"Montenegro"
*"North Macedonia"
/;


Set Regions_Switzerland(Regions)
/
Switzerland_Tal
Switzerland_Huegel
Switzerland_Berg
/;
Set Regions_Austria(Regions)
/
Austria_Hochalpen
Austria_Voralpen
Austria_Alpenostrand
Austria_WaldMuehlViertel
Austria_KaerntnerBecken
Austria_Alpenvorland
Austria_SuedoestlFlachHuegelland
Austria_NordoestlFlachHuegelland
/;

Set Regions_Austria_Berg(Regions)
/
Austria_Hochalpen
Austria_Voralpen
Austria_Alpenostrand
/;
Set Regions_Austria_Huegel(Regions)
/
Austria_WaldMuehlViertel
/;
Set Regions_Austria_Tal(Regions)
/
Austria_KaerntnerBecken
Austria_Alpenvorland
Austria_SuedoestlFlachHuegelland
Austria_NordoestlFlachHuegelland
/;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*12) Activities, sub-activities, aggregate activities
Set Activities     "Set containing all activities used in the model - inclusive aggregates and sub-activities"
/
*the following equals FAOSTAT_CropProductionItems
"Agave fibres nes"
"Almonds, with shell"
"Anise, badian, fennel, coriander"
"Apples"
"Apricots"
"Areca nuts"
"Artichokes"
"Asparagus"
"Avocados"
"Bambara beans"
"Bananas"
"Barley"
"Bastfibres, other"
"Beans, dry"
"Beans, green"
"Berries nes"
"Blueberries"
"Brazil nuts, with shell"
"Broad beans, horse beans, dry"
"Buckwheat"
"Cabbages and other brassicas"
"Canary seed"
"Carobs"
"Carrots and turnips"
"Cashew nuts, with shell"
"Cashewapple"
"Cassava"
"Cassava leaves"
"Castor oil seed"
"Cauliflowers and broccoli"
"Cereals (Rice Milled Eqv)"
"Cereals, nes"
"Cereals,Total"
"Cherries"
"Cherries, sour"
"Chestnut"
"Chick peas"
"Chicory roots"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cinnamon (canella)"
"Citrus Fruit,Total"
"Cloves"
"Coarse Grain, Total"
"Cocoa, beans"
"Coconuts"
"Coffee, green"
"Coir"
"Cotton lint"
"Cottonseed"
"Cow peas, dry"
"Cranberries"
"Cucumbers and gherkins"
"Currants"
"Dates"
"Eggplants (aubergines)"
"Fibre crops nes"
"Fibre Crops Primary"
"Figs"
"Flax fibre and tow"
"Fonio"
"Fruit excl Melons,Total"
"Fruit, citrus nes"
"Fruit, fresh nes"
"Fruit, pome nes"
"Fruit, stone nes"
"Fruit, tropical fresh nes"
"Garlic"
"Ginger"
"Gooseberries"
"Grain, mixed"
"Grapefruit (inc. pomelos)"
"Grapes"
"Groundnuts, with shell"
"Gums, natural"
"Hazelnuts, with shell"
"Hemp tow waste"
"Hempseed"
"Hops"
"Jojoba seed"
"Jute"
"Jute & Jute-like Fibres"
"Kapok fibre"
"Kapok fruit"
"Kapokseed in shell"
"Karite nuts (sheanuts)"
"Kiwi fruit"
"Kola nuts"
"Leeks, other alliaceous vegetables"
"Lemons and limes"
"Lentils"
"Lettuce and chicory"
"Linseed"
"Lupins"
"Maize"
"Maize, green"
"Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"
"Maté"
*     in the data downloaded from FAOSTAT, it is written "MatÃ©"
"Melons, other (inc.cantaloupes)"
"Melonseed"
"Millet"
"Mushrooms and truffles"
"Mustard seed"
"Nutmeg, mace and cardamoms"
"Nuts, nes"
"Oats"
"Oil, palm"
"Oil, palm fruit"
"Oilcakes Equivalent"
"Oilcrops Primary"
"Oilseeds nes"
"Okra"
"Olives"
"Onions, dry"
"Onions, shallots, green"
"Oranges"
"Palm kernels"
"Papayas"
"Peaches and nectarines"
"Pears"
"Peas, dry"
"Peas, green"
"Pepper (piper spp.)"
"Peppermint"
"Persimmons"
"Pigeon peas"
"Pineapples"
"Pistachios"
"Plantains and others"
"Plums and sloes"
"Poppy seed"
"Potatoes"
"Pulses, nes"
"Pulses,Total"
"Pumpkins, squash and gourds"
"Pyrethrum, dried"
"Quinces"
"Quinoa"
"Ramie"
"Rapeseed"
"Raspberries"
"Rice, paddy"
"Roots and tubers, nes"
"Roots and Tubers,Total"
"Rubber, natural"
"Rye"
"Safflower seed"
"Seed cotton"
"Sesame seed"
"Sisal"
"Sorghum"
"Soybeans"
"Spices, nes"
"Spinach"
"Strawberries"
"String beans"
"Sugar beet"
"Sugar cane"
"Sugar crops, nes"
"Sunflower seed"
"Sweet potatoes"
"Tallowtree seed"
"Tangerines, mandarins, clementines, satsumas"
"Taro (cocoyam)"
"Tea"
"Tobacco, unmanufactured"
"Tomatoes"
"Treenuts,Total"
"Triticale"
"Tung nuts"
"Vanilla"
"Vegetables Primary"
"Vegetables&Melons, Total"
"Vegetables, fresh nes"
"Vegetables, leguminous nes"
"Vetches"
"Walnuts, with shell"
"Watermelons"
"Wheat"
"Yams"
"Yautia (cocoyam)"
*till here it equals FAOSTAT_CropProductionItems

*the following equals FAOSTAT_LiveAnimalsItems
"Animals live nes"
"Asses"
"Beehives"
"Buffaloes"
"Camelids, other"
"Camels"
"Cattle"
"Cattle and Buffaloes"
"Chickens"
"Ducks"
"Geese and guinea fowls"
"Goats"
"Horses"
"Mules"
"Pigeons, other birds"
"Pigs"
"Poultry Birds"
"Rabbits and hares"
"Rodents, other"
"Sheep"
"Sheep and Goats"
"Turkeys"
*till here it equals FAOSTAT_LiveAnimalsItems

*and add Game to have it:
"Game"

*the following equals NON_FAOSTAT_CropProductionItems
$ontext;
In FAOSTAT, but currently not available:
635         "Straw husks"
636         "Forage and silage, maize"
637         "Forage and silage, sorghum"
638         "Forage and silage, rye grass"
639         "Forage and silage, grasses nes"
640         "Forage and silage, clover"
641         "Forage and silage, alfalfa"
642         "Forage and silage, green oilseeds"
643         "Forage and silage, legumes"
644         "Cabbage for fodder"
645         "Mixed Grasses and Legumes"
646         "Turnips for fodder"
647         "Beets for fodder"
648         "Carrots for fodder"
649         "Swedes for fodder"
651         "Forage products"
652         "Feed, vegetable products nes"
653         "Food wastes"
654         "Dregs from brewing, distillation"
655         "Vegetables and roots fodder"
$offtext;

"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Forage Products Nes"

*other fodder crops
"Beets For Fodder"
"Swedes For Fodder"
"Turnips For Fodder"
"Vegetables+Roots,Fodder"

*additionally added from FAOSTAT ForageCrop data, items that do not fit to one from the above:
"Cabbage, for forage"
"Carrots, for forage"
"Other grasses, for forage"
"Other oilseeds, for forage"
"Rye grass, for forage"
"Sorghum, for forage"

Fallows

"Grass"

"Temporary meadows and pastures"
"Permanent meadows and pastures"

"temporary grasslands"
"permanent grasslands"
"alpine pastures"

"Pure legume sward"
Grassclass1
Grassclass2
Grassclass3
Grassclass4
*till here it equals NON_FAOSTAT_CropProductionItems

*some activities from FAOSTAT land use:
"Fallow land (temporary)"
"Forest"
"Planted forest"
"Primary forest"
"Perm. meadows & pastures - Cultivated"
"Perm. meadows & pastures - Nat. growing"
"Perm. meadows & pastures Cult. non-irrig"
"Perm. meadows and pastures - Cult. & actually irrig"
*"Permanent meadows and pastures"
"Temp. meadows & pastures non-irrig."
"Temp. meadows and pastures actually irrigated"
*"Temporary meadows and pastures"

*the following are new livestock activities needed for the code:
*this allows to differentiate animal production systems - can be differentiated further according to intensities, feed type, etc.
"Beef cattle"
"Dairy cattle"
"Chicken Layers"
"Chicken Broilers"

"Aquatic Animals, Others"
"Aquatic Plants"
"Aquatic Products, Other"
"Cephalopods"
"Crustaceans"
"Demersal Fish"
"Pelagic Fish"
"Molluscs"
"Spermaceti"

*the following categories are also used, so we add them here:
"All Ruminants"
"All NonRuminants"
"All Poultry"

"All animals"
"All crops"

*the following are added to allow for complete matching between commodities and activities:
"All Cereals"
"Other Cereals"
"All other citrus"
*This is 2614."Citrus, Other": "Default composition: 512 Fruit, citrus nes, 513 Juice, citrus, single strength, 514 Juice, citrus, concentrated"
"All Fruits"
"All other hard fibres"
*this is based on the commodity 2667."Hard Fibres, Other"; "Default composition: 800 Agave fibres nes, 813 Coir, 821 Fibre crops nes"
"All Sugar Crops"
*this is introduced to match "Molasses" with some activities;
*thereby, 165."Molasses" is defined as follows: "A by-product of the extraction or refining of beet or cane sugar or of the production of fructose from maize. Used for feed, food, industrial alcohol, alcoholic beverages and ethanol."
"All Nuts"
"All Oilcrops"
"All other oilcrops"
*this is intoduced to match "Oilcrops Oil, Other" with some activities; the specification for this is as follows:
*2586."Oilcrops Oil, Other"
*        "Default composition: 264 Butter of karite nuts, 266 Oil, castor beans, 276 Oil, tung nuts, 278 Oil, jojoba, 281 Oil, safflower, 297 Oil, poppy,
*        306 Vegetable tallow, 307 Oil, stillingia, 313 Oil, kapok, 334 Oil, linseed, 337 Oil, hempseed, 340 Oil, vegetable origin nes, 664 Cocoa, butter, 1241 Margarine, liquid, 1242 Margarine, short,
*        1273 Castor oil, hydrogenated (opal wax), 1274 Oil, boiled etc, 1275 Oil, hydrogenated"
*and it is also used to match "Oilcrops, Other" with some activities; the specification for this is as follows:
*2570."Oilcrops, Other"
*        "Default composition: 263 Karite nuts (sheanuts), 265 Castor oil seed, 275 Tung nuts, 277 Jojoba seed, 280 Safflower seed, 296 Poppy seed, 299 Melonseed, 305 Tallowtree seed,
*        310 Kapok fruit, 311 Kapokseed in shell, 312 Kapokseed shelled, 333 Linseed, 336 Hempseed, 339 Oilseeds nes, 343 Flour, oilseeds"
"All crops producing oilseed cake"
*this is intoduced to match "Oilseed Cakes, Other" with some activities; the specification for this is as follows:
*2598."Oilseed Cakes, Other"
*        "Default composition: 37 Cake, rice bran, 61 Cake, maize, 282 Cake, safflower, 298 Cake, poppy seed, 314 Cake, kapok, 335 Cake, linseed, 338 Cake, hempseed, 341 Cake, oilseeds nes"
"All roots and tubers"
"All other roots"
*this is introduced to match 2534."Roots, Other" with some activities; the specification is:
*        "Default composition: 135 Yautia (cocoyam), 136 Taro (cocoyam), 149 Roots and tubers, nes, 150 Flour, roots and tubers nes, 151 Roots and tubers dried"
"All other soft fibres"
*this is based on 2664."Soft-Fibres, Other": "Default composition: 771 Flax fibre raw, 773 Flax fibre and tow, 774 Flax tow waste, 777 Hemp tow waste, 778 Kapok fibre, 788 Ramie"
"All spices"
"All other spices"
*this is based on 2645."Spices, Other": "Default composition: 692 Vanilla, 693 Cinnamon (canella), 702 Nutmeg, mace and cardamoms, 711 Anise, badian, fennel, coriander, 720 Ginger, 723 Spices, nes"
"All starchy roots"
"All Vegetables"
"All other vegetables"
*this is defined as follows: 2605."Vegetables, Other"
*        "Default composition: 358 Cabbages and other brassicas, 366 Artichokes, 367 Asparagus, 372 Lettuce and chicory, 373 Spinach, 378 Cassava leaves,
*        393 Cauliflowers and broccoli, 394 Pumpkins, squash and gourds, 397 Cucumbers and gherkins, 399 Eggplants (aubergines), 401 Chillies and peppers, green,
*        402 Onions, shallots, green, 406 Garlic, 407 Leeks, other alliaceous vegetables, 414 Beans, green, 417 Peas, green, 420 Vegetables, leguminous nes, 423 String beans,
*        426 Carrots and turnips, 430 Okra, 446 Maize, green, 447 Sweet corn frozen, 448 Sweet corn prep or preserved, 449 Mushrooms and truffles, 450 Mushrooms, dried,
*        451 Mushrooms, canned, 459 Chicory roots, 461 Carobs, 463 Vegetables, fresh nes, 464 Vegetables, dried nes, 465 Vegetables, canned nes, 466 Juice, vegetables nes,
*        469 Vegetables, dehydrated, 471 Vegetables in vinegar, 472 Vegetables, preserved nes, 473 Vegetables, frozen, 474 Vegetables, temporarily preserved, 475 Vegetables, preserved, frozen,
*        476 Vegetables, homogenized preparations, 567 Watermelons, 568 Melons, other (inc.cantaloupes), 658 Coffee, substitutes containing coffee"
"All sugar sources"
*This is used to match 2827."Sugar, Raw Equivalent" with some activities
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes,
*        162 Sugar Raw Centrifugal, 163 Sugar non-centrifugal, 166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose"
*This is used to match 2543."Sweeteners, Other" with some activities
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes, 165 Molasses,
*        166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose, 175 Isoglucose, 633 Beverages, non alcoholic"
"Fruit vegetables"
"All other sugar sources"
"Citrus Fruits"
"All Activities"

"All Forage Crops"

"All Legumes (Nfixing)"
"All Crops without Legumes (Nfixing)"

"All Fish and Seafood"
*this is to match 2855."Fish Meal" with activities:
*        "Default composition: 1511 Freshwater Meal Fr Offal, 1524 Demersal Meal from Offal, 1537 Pelagic Meal from Offal, 1550 Marn Meal Of, 1559 Crustaceans Meal F Offal,
*        1567 Molluscs Meal from Offal, 1576 Cephalopods Meal F Offal, 1581 Aquatic Mammals Meals, 1584 Aqua Mammal Meal F Offal, 1591 Aq A Meal Of"
"All Fish and Marine Mamm"
*this ist to match 2781."Fish, Body Oil" and 2782."Fish, Liver Oil" with activities
*        "Default composition: 1510 Frwt Lvr Oil, 1523 Demersal Liver Oils, 1536 Pelg Lvr Oil, 1549 Marine nes Liver Oils"
"Freshwater Fish"
"All other marine fish"
*this is to match 2764."Marine Fish, Other" with activities:
*        "Default composition: 1540 Marine nes F, 1541 Marin Fz Whl, 1542 Marin Fillet, 1543 Marin Fz Flt, 1544 Marin Cured, 1545 Marin Canned, 1546 Marin Pr nes, 1547 Marin Meals"
"Aquatic Animals"
"All other Animals"
*this is needed to match 2735."Meat, Other" with activities
*        "Default composition: 1089 Meat, bird nes, 1097 Meat, horse, 1108 Meat, ass, 1111 Meat, mule, 1127 Meat, camel, 1141 Meat, rabbit, 1151 Meat, other rodents,
*        1158 Meat, other camelids, 1163 Meat, game, 1164 Meat, dried nes, 1166 Meat, nes, 1172 Meat, nes, preparations, 1176 Snails, not sea"

*silk is not yet covered consistently, hus delete here
*"Silkworms"

"Alfalfa"
"Bananas and plantains"
"Rape and Mustard seed"

"Ducks and Geese"
*This is needed to match 1060."Fat, liver prepared (foie gras)" with activities:
*        "Fatty livers of ducks and geese when cooked, prepared or preserved(e.g. patâ€š)."
"Maple"

"Broad Beans, Green"

*the following is needed for assigning FOFA2050 to SOLm
"FOFA2050 sweet potato and yams"

"FOFA2050 other crops"
"FOFA2050 other fibre crops"
"FOFA2050 other fruits"
"FOFA2050 other oilseeds"
"FOFA2050 other roots and tubers"
"FOFA2050 other vegetables"
"FOFA2050 other cereals"

"BioBam UNISECO OtherCrops"

*the following is needed for BioeSR15
Miscanthus
"All non-energy crops"
"Forestry"
"Natural Forest"
"All crops and grass"

*needed for the derivation of animal number:
"AnimalsWithoutGrassInFeedingRation"

*and some activity groups needed for the fertilizer application calculations
"All Crops PLUS temp grass"
"All Grass WITHOUT temp grass"

*additional activities for NFP69
'Salt'
'Water'
'Spelt'
'Leafy vegetables'
'Branch vegetables'
'Root vegetables'

"Fruits - Excluding Wine"
"Nuts and products"
"Oilcrops Oil, Other"


*for the more detailed CH and AT data:
"Other annual crops"
"Other permanent crops"

"All energy crops"
"All other fodder crops"
"Temp. and perm. meadows and pastures"
"Core grass activities"
"All crops and grass - NO temp grass"

*needed for adjusting the number of beehives in the scenarios:
"PollinatedCrops"

*needed to include agroforestry practices:
"agrof. trees: feed"
"non-food agrof. trees"
"All agrof. trees"
"Agricultural Trees"
"Crops without agricultural Trees"
"All Legumes (Nfixing) - incl. SetAside (no temp. grass)"

*needed to deal with areas that become free in a sceario and are then allocated anew:
"Alternative use"
"Alternative use - Cropland"
"Alternative use - Conservation"
"Core food crops"
"Core food crops - no cereals"

"All Crops used in crop rot_NonV - w/o areas not used"

*further aggregates:
"Cropland: temporary (incl. temp. grassland) (ha)"
"Cropland: temporary (without temp. grassland) (ha)"
"Cropland: permanent (ha)"
/;


*for some code, we also need this set twice, thus assign via alias:
alias(Activities,Activities_2);

*a set for all livestock activities:
set Livestock(Activities) "Subset containing all livestock activities"
/
*the following equals FAOSTAT_LiveAnimalsItems
"Animals live nes"
"Asses"
"Beehives"
"Buffaloes"
"Camelids, other"
"Camels"
"Cattle"
"Cattle and Buffaloes"
"Chickens"
"Ducks"
"Geese and guinea fowls"
"Goats"
"Horses"
"Mules"
"Pigeons, other birds"
"Pigs"
"Poultry Birds"
"Rabbits and hares"
"Rodents, other"
"Sheep"
"Sheep and Goats"
"Turkeys"
*till here it equals FAOSTAT_LiveAnimalsItems

Game

"Beef cattle"
"Dairy cattle"
"Chicken Layers"
"Chicken Broilers"
/;

set Livestock_NoAggregates(Activities) "Subset containing all livestock activities - and no aggregates such as 'sheep and goats'"
/
*the following equals FAOSTAT_LiveAnimalsItems
"Animals live nes"
"Asses"
"Beehives"
"Buffaloes"
"Camelids, other"
"Camels"
"Cattle"
*"Cattle and Buffaloes"
"Chickens"
"Ducks"
"Geese and guinea fowls"
"Goats"
"Horses"
"Mules"
"Pigeons, other birds"
"Pigs"
*"Poultry Birds"
"Rabbits and hares"
"Rodents, other"
"Sheep"
*"Sheep and Goats"
"Turkeys"
*till here it equals FAOSTAT_LiveAnimalsItems

Game

*"Beef cattle"
*"Dairy cattle"
*"Chicken Layers"
*"Chicken Broilers"
/;

Set Ruminants(Activities) "Subset containing all ruminant activities"
/
Goats
Cattle
Buffaloes
Sheep
Game
Horses
Camels
Asses
Mules
"Camelids, other"
*"Beef cattle"
*"Dairy cattle"
/;

Set Poultry(Activities)
/
"Chickens"
"Ducks"
"Geese and guinea fowls"
"Pigeons, other birds"
"Poultry Birds"
"Turkeys"
*"Chicken Layers"
*"Chicken Broilers"
/;

Set MonogastricsNonPoultry(Activities)
/
"Animals live nes"
"Pigs"
"Rabbits and hares"
"Rodents, other"
/;
Set FishAndSeafood(Activities)
/
"Aquatic Animals, Others"
"Aquatic Plants"
"Aquatic Products, Other"
"Cephalopods"
"Crustaceans"
"Demersal Fish"
"Pelagic Fish"
"Molluscs"
"Spermaceti"
/;

Set NonRuminants(Activities)
/
"Animals live nes"
"Chickens"
"Ducks"
"Geese and guinea fowls"
"Pigeons, other birds"
"Pigs"
"Poultry Birds"
"Rabbits and hares"
"Rodents, other"
"Turkeys"
/;

*the following three sets are needed for the allocation of coupled products
Set Livestock_NoCoupledOutputs(Activities)
/
"Pigeons, other birds"
"Asses"
"Camels"
"Camelids, other"
"Ducks"
"Geese and guinea fowls"
"Horses"
"Mules"
"Pigs"
"Rabbits and hares"
"Rodents, other"
"Turkeys"
/;

Set Livestock_CoupledMeatMilk(Activities)
/
Buffaloes
*camel milk is not important, thus do not yet address, capture under meat only
*Camels
*cattle needs to be treated separately for allocation, cf. _V6_DerivePerPrimaryProductImpacts.gms
*Cattle
Goats
Sheep
/;

Set Livestock_CoupledMeatEggs(Activities)
/
Chickens
/;

Set Livestock_NonRuminantsWithHerdStructure(Activities)
/
Pigs
/;


*a set for all crops:
set Crops(Activities) "Subset containing all crop activities"
/
*for model run, we drop all that seem to be totals, to avoid double counting, i.e. we drop Set FAOSTAT_CropProductionItemGroups
*the following equals FAOSTAT_CropProductionItems
"Agave fibres nes"
"Almonds, with shell"
"Anise, badian, fennel, coriander"
"Apples"
"Apricots"
"Areca nuts"
"Artichokes"
"Asparagus"
"Avocados"
"Bambara beans"
"Bananas"
"Barley"
"Bastfibres, other"
"Beans, dry"
"Beans, green"
"Berries nes"
"Blueberries"
"Brazil nuts, with shell"
"Broad beans, horse beans, dry"
"Buckwheat"
"Cabbages and other brassicas"
"Canary seed"
"Carobs"
"Carrots and turnips"
"Cashew nuts, with shell"
"Cashewapple"
"Cassava"
"Cassava leaves"
"Castor oil seed"
"Cauliflowers and broccoli"
*"Cereals (Rice Milled Eqv)"
"Cereals, nes"
*"Cereals,Total"
"Cherries"
"Cherries, sour"
"Chestnut"
"Chick peas"
"Chicory roots"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cinnamon (canella)"
*"Citrus Fruit,Total"
"Cloves"
*"Coarse Grain, Total"
"Cocoa, beans"
"Coconuts"
"Coffee, green"
"Coir"
"Cotton lint"
"Cottonseed"
"Cow peas, dry"
"Cranberries"
"Cucumbers and gherkins"
"Currants"
"Dates"
"Eggplants (aubergines)"
"Fibre crops nes"
*"Fibre Crops Primary"
"Figs"
"Flax fibre and tow"
"Fonio"
*"Fruit excl Melons,Total"
"Fruit, citrus nes"
"Fruit, fresh nes"
"Fruit, pome nes"
"Fruit, stone nes"
"Fruit, tropical fresh nes"
"Garlic"
"Ginger"
"Gooseberries"
"Grain, mixed"
"Grapefruit (inc. pomelos)"
"Grapes"
"Groundnuts, with shell"
"Gums, natural"
"Hazelnuts, with shell"
"Hemp tow waste"
"Hempseed"
"Hops"
"Jojoba seed"
"Jute"
*"Jute & Jute-like Fibres"
"Kapok fibre"
"Kapok fruit"
"Kapokseed in shell"
"Karite nuts (sheanuts)"
"Kiwi fruit"
"Kola nuts"
"Leeks, other alliaceous vegetables"
"Lemons and limes"
"Lentils"
"Lettuce and chicory"
"Linseed"
"Lupins"
"Maize"
"Maize, green"
"Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"
"Maté"
*     in the data downloaded from FAOSTAT, it is written "MatÃ©"
"Melons, other (inc.cantaloupes)"
"Melonseed"
"Millet"
"Mushrooms and truffles"
"Mustard seed"
"Nutmeg, mace and cardamoms"
"Nuts, nes"
"Oats"
"Oil, palm"
"Oil, palm fruit"
*"Oilcakes Equivalent"
*"Oilcrops Primary"
"Oilseeds nes"
"Okra"
"Olives"
"Onions, dry"
"Onions, shallots, green"
"Oranges"
"Palm kernels"
"Papayas"
"Peaches and nectarines"
"Pears"
"Peas, dry"
"Peas, green"
"Pepper (piper spp.)"
"Peppermint"
"Persimmons"
"Pigeon peas"
"Pineapples"
"Pistachios"
"Plantains and others"
"Plums and sloes"
"Poppy seed"
"Potatoes"
"Pulses, nes"
*"Pulses,Total"
"Pumpkins, squash and gourds"
"Pyrethrum, dried"
"Quinces"
"Quinoa"
"Ramie"
"Rapeseed"
"Raspberries"
"Rice, paddy"
"Roots and tubers, nes"
*"Roots and Tubers,Total"
"Rubber, natural"
"Rye"
"Safflower seed"
"Seed cotton"
"Sesame seed"
"Sisal"
"Sorghum"
"Soybeans"
"Spices, nes"
"Spinach"
"Strawberries"
"String beans"
"Sugar beet"
"Sugar cane"
"Sugar crops, nes"
"Sunflower seed"
"Sweet potatoes"
"Tallowtree seed"
"Tangerines, mandarins, clementines, satsumas"
"Taro (cocoyam)"
"Tea"
"Tobacco, unmanufactured"
"Tomatoes"
*"Treenuts,Total"
"Triticale"
"Tung nuts"
"Vanilla"
*"Vegetables Primary"
*"Vegetables&Melons, Total"
"Vegetables, fresh nes"
"Vegetables, leguminous nes"
"Vetches"
"Walnuts, with shell"
"Watermelons"
"Wheat"
"Yams"
"Yautia (cocoyam)"
*till here it equals FAOSTAT_CropProductionItems

*include forage and fodder in crops:
"Maize For Forage+Silage"
"Clover For Forage+Silage"
"Alfalfa For Forage+Silag"
"Leguminous Nes,For+Sil"
"Forage Products Nes"
"Beets For Fodder"
*'Vetches'

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
"Cabbage, for forage"
"Carrots, for forage"
"Other grasses, for forage"
"Other oilseeds, for forage"
"Rye grass, for forage"
"Sorghum, for forage"

*we have the following two as forages as they are forage in Aggregate_ForageCrops
*"Alfalfa Meal And Pellets"
*"Beets For Fodder"
"Swedes For Fodder"
"Turnips For Fodder"
"Vegetables+Roots,Fodder"

Fallows

Miscanthus

"Pure legume sward"

"Other annual crops"
"Other permanent crops"
"Spelt"
/;

Set Cereals(Activities)
/Barley
Buckwheat
"Canary seed"
"Cereals, nes"
Fonio
Maize
Millet
*"Mixed grain"
Oats
Quinoa
"Rice, paddy"
Rye
Sorghum
Triticale
Wheat
*Popcorn
*"Cereals, most"
*"Maize For Forage+Silage" is under forage crops

"Spelt"
/;

Set OtherCereals(Activities)
*        "Default composition: 68 Popcorn, 89 Buckwheat, 90 Flour, buckwheat, 91 Bran, buckwheat, 92 Quinoa, 94 Fonio, 95 Flour, fonio, 96 Bran, fonio, 97 Triticale, 98 Flour, triticale, 99 Bran, triticale, 101 Canary seed, 103 Grain, mixed,
*        104 Flour, mixed grain, 105 Bran, mixed grains, 108 Cereals, nes, 111 Flour, cereals, 112 Bran, cereals nes, 113 Cereal preparations, nes"
/
Buckwheat
"Canary seed"
"Cereals, nes"
Fonio
*"Mixed grain"
Quinoa
Triticale
/;

Set Fruits(Activities)
/Strawberries
"Berries Nes"
Blueberries
Cranberries
Currants
Gooseberries
Raspberries
"Fruit, citrus nes"
"Lemons and limes"
Oranges
"Tangerines, mandarins, clementines, satsumas"
Grapes
"Fruit, Fresh Nes"
"Fruit, pome nes"
Pears
Quinces
Apricots
Cherries
"Peaches and nectarines"
"Plums and sloes"
"Cherries, Sour"
"Fruit, stone nes"
Apples
Avocados
Bananas
Carobs
Cashewapple
Dates
Figs
"Fruit, tropical fresh nes"
"Grapefruit (inc. pomelos)"
"Kiwi fruit"
"Mangoes, mangosteens, guavas"
Papayas
Persimmons
Pineapples
"Plantains and others"
/;

Set CitrusFruits(Activities)
/
"Fruit, citrus nes"
"Lemons and limes"
Oranges
"Tangerines, mandarins, clementines, satsumas"
"Grapefruit (inc. pomelos)"
/;

Set Treenuts(Activities)
/"Almonds, with shell"
"Areca nuts"
"Brazil nuts, with shell"
"Cashew nuts, with shell"
Chestnut
"Hazelnuts, with shell"
"Nuts, nes"
Pistachios
"Tung Nuts"
"Walnuts, with shell"
/;

Set Pulses(Activities)
*ATTENTION:
*        soybeans, "Groundnuts, with shell"      are counted under oil crops
/
"Bambara beans"
"Beans, dry"
"Broad beans, horse beans, dry"
"Chick peas"
"Cow peas, dry"
Lentils
Lupins
"Peas, dry"
"Pigeon peas"
"Pulses, nes"
/;

Set Legumes_NFixing(Activities)
/
Soybeans
"Groundnuts, with shell"
"Bambara beans"
"Beans, dry"
"Broad beans, horse beans, dry"
"Chick peas"
"Cow peas, dry"
Lentils
Lupins
"Peas, dry"
"Pigeon peas"
"Pulses, nes"
/;

Set Crops_NoNFixingLegumes(Activities);
Crops_NoNFixingLegumes(Activities) = Crops(Activities) - Legumes_NFixing(Activities);

Set OilCrops(Activities)
/Soybeans
"Groundnuts, with shell"
"Castor oil seed"
Hempseed
Linseed
"Mustard seed"
"Oilseeds Nes"
"Poppy seed"
Rapeseed
"Safflower seed"
"Sesame seed"
"Sunflower seed"
Melonseed
Coconuts
"Karite Nuts (Sheanuts)"
"Kola nuts"
"Oil, palm fruit"
Olives
"Jojoba seed"
"Tallowtree seed"
"Kapok Fruit"
/;
Set OtherOilcrops(Activities)
*the specification for this is as follows:
*2570."Oilcrops, Other"
*        "Default composition: 263 Karite nuts (sheanuts), 265 Castor oil seed, 275 Tung nuts, 277 Jojoba seed, 280 Safflower seed, 296 Poppy seed, 299 Melonseed, 305 Tallowtree seed,
*        310 Kapok fruit, 311 Kapokseed in shell, 312 Kapokseed shelled, 333 Linseed, 336 Hempseed, 339 Oilseeds nes, 343 Flour, oilseeds"
/
"Castor oil seed"
Hempseed
Linseed
"Oilseeds Nes"
"Poppy seed"
"Safflower seed"
Melonseed
"Karite Nuts (Sheanuts)"
"Jojoba seed"
"Tallowtree seed"
"Kapok Fruit"
/;

Set StarchyRoots(Activities)
/Cassava
Potatoes
"Roots and Tubers, nes"
"Sweet potatoes"
"Taro (cocoyam)"
Yams
"Yautia (cocoyam)"
*ATTENTION, the following are counted under fodder crops:
*        "Turnips For Fodder"
*        "Beets For Fodder"
*        "Swedes For Fodder"
*        "Vegetables+Roots,Fodder"
/;

Set SugarCrops(Activities)
/
Maple
"Sugar cane"
"Sugar crops, nes"
"Sugar beet"
/;

Set Vegetables(Activities)
/Artichokes
Asparagus
"Beans, green"
"Cabbages and other brassicas"
"Carrots and turnips"
"Cauliflowers and broccoli"
"Chicory roots"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cucumbers and gherkins"
"Eggplants (aubergines)"
Garlic
"Leeks, other alliaceous vegetables"
"Vegetables, leguminous nes"
"Lettuce and chicory"
"Maize, green"
"Mushrooms and truffles"
Okra
"Onions, shallots, green"
"Onions, dry"
"Peas, green"
"Pumpkins, squash and gourds"
Spinach
"String beans"
Tomatoes
"Vegetables, fresh nes"
"Melons, other (inc.cantaloupes)"
Watermelons
/;
Set OtherVegetables(Activities)  Subset of all vegetables BESIDES Tomatoes
*this is defined as follows: 2605."Vegetables, Other"
*        "Default composition: 358 Cabbages and other brassicas, 366 Artichokes, 367 Asparagus, 372 Lettuce and chicory, 373 Spinach, 378 Cassava leaves,
*        393 Cauliflowers and broccoli, 394 Pumpkins, squash and gourds, 397 Cucumbers and gherkins, 399 Eggplants (aubergines), 401 Chillies and peppers, green,
*        402 Onions, shallots, green, 406 Garlic, 407 Leeks, other alliaceous vegetables, 414 Beans, green, 417 Peas, green, 420 Vegetables, leguminous nes, 423 String beans,
*        426 Carrots and turnips, 430 Okra, 446 Maize, green, 447 Sweet corn frozen, 448 Sweet corn prep or preserved, 449 Mushrooms and truffles, 450 Mushrooms, dried,
*        451 Mushrooms, canned, 459 Chicory roots, 461 Carobs, 463 Vegetables, fresh nes, 464 Vegetables, dried nes, 465 Vegetables, canned nes, 466 Juice, vegetables nes,
*        469 Vegetables, dehydrated, 471 Vegetables in vinegar, 472 Vegetables, preserved nes, 473 Vegetables, frozen, 474 Vegetables, temporarily preserved, 475 Vegetables, preserved, frozen,
*        476 Vegetables, homogenized preparations, 567 Watermelons, 568 Melons, other (inc.cantaloupes), 658 Coffee, substitutes containing coffee"
/
Artichokes
Asparagus
"Beans, green"
"Cabbages and other brassicas"
"Carrots and turnips"
"Cauliflowers and broccoli"
"Chicory roots"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cucumbers and gherkins"
"Eggplants (aubergines)"
Garlic
"Leeks, other alliaceous vegetables"
"Vegetables, leguminous nes"
"Lettuce and chicory"
"Maize, green"
"Mushrooms and truffles"
Okra
"Onions, shallots, green"
"Onions, dry"
"Peas, green"
"Pumpkins, squash and gourds"
Spinach
"String beans"
Tomatoes
"Vegetables, fresh nes"
"Melons, other (inc.cantaloupes)"
Watermelons
/;

Set StimulantsSpices(Activities)
/"Coffee, green"
"Cocoa, beans"
Tea
"Maté"
Hops
"Pepper (Piper spp.)"
Vanilla
"Cinnamon (canella)"
Cloves
"Nutmeg, mace and cardamoms"
"Anise, badian, fennel, coriander"
Ginger
"Spices, nes"
Peppermint
"Pyrethrum, Dried"
"Tobacco, unmanufactured"
/;

Set Spices(Activities)
/"Pepper (Piper spp.)"
Vanilla
"Cinnamon (canella)"
Cloves
"Nutmeg, mace and cardamoms"
"Anise, badian, fennel, coriander"
Ginger
"Spices, nes"
/;

Set FibresRubber(Activities)
/"Flax fibre and tow"
"Hemp Tow Waste"
Jute
"Bastfibres, other"
Ramie
Sisal
"Agave Fibres Nes"
"Manila Fibre (Abaca)"
Coir
"Fibre Crops Nes"
"Rubber, natural "
"Gums, Natural"
"Seed cotton"
/;

Set FibresNotCotton(Activities)
/"Flax fibre and tow"
"Hemp Tow Waste"
Jute
"Bastfibres, other"
Ramie
Sisal
"Agave Fibres Nes"
"Manila Fibre (Abaca)"
Coir
"Fibre Crops Nes"
/;

Set ForageCrops(Activities) "Subset containing all forage crops"
*forage crops: those crops that are harvested and then fully fed or used for silage, thus not leading to residues (besides roots); therefore, beets for fodder, etc. are not inlcuded,
*but are listed separately under other fodder crops.
/"Maize For Forage+Silage"
"Clover For Forage+Silage"
"Alfalfa For Forage+Silag"
"Leguminous Nes,For+Sil"
"Forage Products Nes"
"Beets For Fodder"
'Vetches'

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
"Cabbage, for forage"
"Carrots, for forage"
"Other grasses, for forage"
"Other oilseeds, for forage"
"Rye grass, for forage"
"Sorghum, for forage"
/;

Set OtherFodderCrops(Activities) "Subset containing other fodder crops"
/
*we have the following two as forages as they are forage in Aggregate_ForageCrops
*"Alfalfa Meal And Pellets"
*"Beets For Fodder"
"Swedes For Fodder"
"Turnips For Fodder"
"Vegetables+Roots,Fodder"
/;

Set CoreFoodCrops(Activities) "subset containing core food crops (also excluding sugar crops)";
CoreFoodCrops(Activities)
         = Cereals(Activities)
           + Fruits(Activities)
           + Treenuts(Activities)
           + Pulses(Activities)
           + OilCrops(Activities)
           + StarchyRoots(Activities)
           + Vegetables(Activities);

Set CoreFoodCrops_NoCereals(Activities) "subset containing core food crops without cereals(also excluding sugar crops)";
CoreFoodCrops_NoCereals(Activities)
         = Fruits(Activities)
           + Treenuts(Activities)
           + Pulses(Activities)
           + OilCrops(Activities)
           + StarchyRoots(Activities)
           + Vegetables(Activities);

Set GrassActivities(Activities) "Subset containing all grass activities"
/
"Grass"

"Temporary meadows and pastures"
"Permanent meadows and pastures"

"temporary grasslands"
"permanent grasslands"
"alpine pastures"

"Pure legume sward"
Grassclass1
Grassclass2
Grassclass3
Grassclass4

"Perm. meadows & pastures - Cultivated"
"Perm. meadows & pastures - Nat. growing"
"Perm. meadows & pastures Cult. non-irrig"
"Perm. meadows and pastures - Cult. & actually irrig"
*"Permanent meadows and pastures"
"Temp. meadows & pastures non-irrig."
"Temp. meadows and pastures actually irrigated"
*"Temporary meadows and pastures"
/;

Set CoreGrassActivities(Activities) "Subset containing the key grass activities - no auxiliary ones for filing in data, etc."
*and no double counting - hence delete the latter ones below
/
"Temporary meadows and pastures"
"Permanent meadows and pastures"
"alpine pastures"

*"Perm. meadows & pastures - Cultivated"
*"Perm. meadows & pastures - Nat. growing"
*"Perm. meadows & pastures Cult. non-irrig"
*"Perm. meadows and pastures - Cult. & actually irrig"
*"Temp. meadows & pastures non-irrig."
*"Temp. meadows and pastures actually irrigated"
/;

Set CoreGrassActivitiesNoTEMPGrass(Activities) "Subset containing the key PERMANENT grass activities - no auxiliary ones for filing in data, etc."
/
"Permanent meadows and pastures"
"alpine pastures"

*"Perm. meadows & pastures - Cultivated"
*"Perm. meadows & pastures - Nat. growing"
*"Perm. meadows & pastures Cult. non-irrig"
*"Perm. meadows and pastures - Cult. & actually irrig"
/;

Set TempAndPermMeadAndPastures(Activities) "Subset containing temporary and permanent meadows and pastures - thus covering all grasslands based on two categories from FAOSTAT"
/
"Temporary meadows and pastures"
"Permanent meadows and pastures"
/;

Set TempMeadAndPastures(Activities) "Subset containing temporary meadows and pastures"
/
"Temporary meadows and pastures"
/;

Set EnergyCrops(Activities)
/
Miscanthus
/;

Set Fallows(Activities)
/
Fallows
/;

Set CropsAndCoreGrassActivities(Activities) "Subset of all agricultural area based activities, i.e. containing all Crops and GrassActivities";
CropsAndCoreGrassActivities(Activities) = Crops(Activities) + CoreGrassActivities(Activities);

Set CropsAndTempGrassActivities(Activities) "Subset of all crop plus temporary grass activities";
CropsAndTempGrassActivities(Activities) = Crops(Activities) + TempMeadAndPastures(Activities);

Set SingleCropGrassandLivestockActivities(Activities) Subset of single activities without aggregates - crops grass and livestock;
SingleCropGrassAndLivestockActivities(Activities) = Crops(Activities) + TempAndPermMeadAndPastures(Activities) + Livestock(Activities);


*some subgroups of activities needed to file in FOFA2050 data
Set FOFA2050_SweetPotato_And_Yams(Activities)
/
Potatoes
Yams
/;
Set FOFA2050_Rapeseed_And_Mustardseed(Activities)
/
Rapeseed
"Mustard seed"
/;
Set FOFA2050_OtherCrops(Activities)
/
"Almonds, with shell"
"Anise, badian, fennel, coriander"
"Areca nuts"
"Brazil nuts, with shell"
Carobs
"Cashew nuts, with shell"
Chestnut
"Cinnamon (canella)"
Cloves
Ginger
"Gums, natural"
"Hazelnuts, with shell"
Hops
"Kapok fruit"
"Kapokseed in shell"
"Karite nuts (sheanuts)"
"Kola nuts"
Lupins
"Maté"
"Nutmeg, mace and cardamoms"
"Nuts, nes"
Peppermint
Pistachios
"Pyrethrum, dried"
Ramie
"Spices, nes"
"Sugar crops, nes"
"Tung nuts"
Vanilla
Vetches
"Walnuts, with shell"
/;
Set FOFA2050_OtherFibreCrops(Activities)
/
"Agave fibres nes"
"Bastfibres, other"
"Fibre crops nes"
"Flax fibre and tow"
"Hemp tow waste"
"Jute"
"Kapok fibre"
"Manila fibre (abaca)"
"Sisal"

/;
Set FOFA2050_OtherFruits(Activities)
/
Apples
Apricots
Avocados
"Berries nes"
Blueberries
Cherries
"Cherries, sour"
Cranberries
Currants
Dates
Figs
"Fruit, fresh nes"
"Fruit, pome nes"
"Fruit, stone nes"
"Fruit, tropical fresh nes"
Gooseberries
Grapes
"Kiwi fruit"
"Mangoes, mangosteens, guavas"
"Melons, other (inc.cantaloupes)"
Papayas
"Peaches and nectarines"
Pears
Persimmons
Pineapples
"Plums and sloes"
Quinces
Raspberries
Strawberries
Watermelons
/;
Set FOFA2050_OtherOilseeds(Activities)
/
"Canary seed"
"Castor oil seed"
"Hempseed"
"Jojoba seed"
"Linseed"
"Oilseeds nes"
"Poppy seed"
"Safflower seed"
"Tallowtree seed"
/;
Set FOFA2050_OtherRootsAndTubers(Activities)
/
"Roots and tubers, nes"
"Taro (cocoyam)"
"Yautia (cocoyam)"
/;
Set FOFA2050_OtherVegetables(Activities)
/
Artichokes
Asparagus
"Beans, green"
"Cabbages and other brassicas"
"Carrots and turnips"
"Cauliflowers and broccoli"
"Chicory roots"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cucumbers and gherkins"
"Eggplants (aubergines)"
Garlic
"Leeks, other alliaceous vegetables"
"Lettuce and chicory"
"Mushrooms and truffles"
Okra
"Onions, dry"
"Onions, shallots, green"
"Peas, green"
"Pepper (piper spp.)"
"Pumpkins, squash and gourds"
Spinach
"String beans"
Tomatoes
"Vegetables, fresh nes"
"Vegetables, leguminous nes"
/;
Set FOFA2050_CitrusFruits(Activities)
/
"Fruit, citrus nes"
"Grapefruit (inc. pomelos)"
"Lemons and limes"
"Oranges"
"Tangerines, mandarins, clementines, satsumas"
/;
Set FOFA2050_DriedPulses(Activities)
/
"Bambara beans"
"Beans, dry"
"Broad beans, horse beans, dry"
"Chick peas"
"Cow peas, dry"
"Lentils"
"Peas, dry"
"Pigeon peas"
"Pulses, nes"
/;
Set FOFA2050_OtherCereals(Activities)
/
Buckwheat
"Cereals, nes"
Fonio
"Grain, mixed"
Oats
Quinoa
Rye
Triticale
/;

Set OtherCrops(Activities)
/
"Other annual crops"
"Other permanent crops"
/;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*13) Cmmodities
Set Commodities    "Set containing all commodities used in the model - inclusive aggregates and sub-commodities"
/
*the following equals FAOSTAT_CropCommodityBalancesItems
"Abaca"
"Alcohol, Non-Food"
"Alcoholic Beverages"
"Apples and products"
"Bananas"
"Barley and products"
"Beans"
"Beer"
"Beverages, Alcoholic"
"Beverages, Fermented"
"Brans"
"Cassava and products"
"Cereals - Excluding Beer"
"Cereals, Other"
"Citrus, Other"
"Cloves"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Coffee and products"
"Copra Cake"
"Cotton lint"
"Cottonseed"
"Cottonseed Cake"
"Cottonseed Oil"
"Dates"
"Fruits - Excluding Wine"
"Fruits, Other"
"Grand Total"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Groundnut Cake"
"Groundnut Oil"
"Groundnuts (in Shell Eq)"
"Groundnuts (Shelled Eq)"
"Hard Fibres, Other"
"Infant food"
"Jute"
"Jute-Like Fibres"
"Lemons, Limes and products"
"Maize and products"
"Maize Germ Oil"
"Millet and products"
"Miscellaneous"
"Molasses"
"Molasses (sugar cane)"
"Molasses (sugar beet)"
"Nuts and products"
"Oats"
"Oilcrops"
"Oilcrops Oil, Other"
"Oilcrops, Other"
"Oilseed Cakes, Other"
"Olive Oil"
"Olives (including preserved)"
"Onions"
"Oranges, Mandarines"
"Palm kernels"
"Palm Oil"
"Palmkernel Cake"
"Palmkernel Oil"
"Peas"
"Pepper"
"Pimento"
"Pineapples and products"
"Plantains"
"Potatoes and products"
"Pulses"
"Pulses, Other and products"
"Rape and Mustard Cake"
"Rape and Mustard Oil"
"Rape and Mustardseed"
"Rice (Milled Equivalent)"
"Rice (Paddy Equivalent)"
"Ricebran Oil"
"Roots & Tuber Dry Equiv"
"Roots, Other"
"Rubber"
"Rye and products"
"Sesame seed"
"Sesameseed Cake"
"Sesameseed Oil"
"Sisal"
"Soft-Fibres, Other"
"Sorghum and products"
"Soyabean Cake"
"Soyabean Oil"
"Soyabeans"
"Spices"
"Spices, Other"
"Starchy Roots"
"Stimulants"
"Sugar & Sweeteners"
"Sugar (Raw Equivalent)"
"Sugar beet"
"Sugar cane"
"Sugar Crops"
"Sugar non-centrifugal"
"Sugar, Raw Equivalent"
"Sugar, Refined Equiv"
"Sugar, Refined Equiv (sugar cane)"
"Sugar, Refined Equiv (sugar beet)"
"Sunflower seed"
"Sunflowerseed Cake"
"Sunflowerseed Oil"
"Sweet potatoes"
"Sweeteners, Other"
"Tea (including mate)"
"Tobacco"
"Tobacco & Rubber"
"Tomatoes and products"
"Treenuts"
"Vegetable Oils"
"Vegetables"
"Vegetables, Other"
"Vegetal Products"
"Wheat and products"
"Wine"
"Yams"
*till here it equals FAOSTAT_CropCommodityBalancesItems

*the following equals FAOSTAT_LivestockFishCommodityBalancesItems
"Animal fats"
"Animal Products"
"Aquatic Animals, Others"
"Aquatic Plants"
"Aquatic Products, Other"
"Bovine Meat"
"Butter, Ghee"
"Cephalopods"
"Cheese"
"Cream"
"Crustaceans"
"Demersal Fish"
"Eggs"
"Fats, Animals, Raw"
"Fish Meal"
"Fish, Body Oil"
"Fish, Liver Oil"
"Fish, Seafood"
"Freshwater Fish"
*"Grand Total"
"Hides and skins"
"Honey"
"Marine Fish, Other"
"Meat"
"Meat Meal"
"Meat, Aquatic Mammals"
"Meat, Other"
"Milk - Excluding Butter"
"Milk, Skimmed"
"Milk, Whole"
"Molluscs, Other"
"Mutton & Goat Meat"
"Offals"
"Offals, Edible"
"Pelagic Fish"
"Pigmeat"
"Poultry Meat"
"Silk"
"Whey"
"Wool (Clean Eq.)"
*till here it equals FAOSTAT_LivestockFishCommodityBalancesItems

*the following equals NON_FAOSTAT_CropProductionItems
$ontext;
In FAOSTAT, but currently not available:
635         "Straw husks"
636         "Forage and silage, maize"
637         "Forage and silage, sorghum"
638         "Forage and silage, rye grass"
639         "Forage and silage, grasses nes"
640         "Forage and silage, clover"
641         "Forage and silage, alfalfa"
642         "Forage and silage, green oilseeds"
643         "Forage and silage, legumes"
644         "Cabbage for fodder"
645         "Mixed Grasses and Legumes"
646         "Turnips for fodder"
647         "Beets for fodder"
648         "Carrots for fodder"
649         "Swedes for fodder"
651         "Forage products"
652         "Feed, vegetable products nes"
653         "Food wastes"
654         "Dregs from brewing, distillation"
655         "Vegetables and roots fodder"
$offtext;

"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Forage Products Nes"

*other fodder crops
"Beets For Fodder"
"Swedes For Fodder"
"Turnips For Fodder"
"Vegetables+Roots,Fodder"

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
"Cabbage, for forage"
"Carrots, for forage"
"Other grasses, for forage"
"Other oilseeds, for forage"
"Rye grass, for forage"
"Sorghum, for forage"

Fallows

"Grass"

"Temporary meadows and pastures"
"Permanent meadows and pastures"

"temporary grasslands"
"permanent grasslands"
"alpine pastures"

*"Pure legume sward"
*Grassclass1
*Grassclass2
*Grassclass3
*Grassclass4
*till here it equals NON_FAOSTAT_CropProductionItems

*the following equals FAOSTAT_TradeCropsAndLivestProdItems_NODoubles
"Agricult.Products,Total"
"Alfalfa meal and pellets"
"Almonds shelled"
*"Animal fats"
"Animal Oil+Fat+Grs"
"Animal Vegetable Oil"
"Anise, badian, fennel, coriander"
"Apples"
"Apricots"
"Apricots, dry"
"Artichokes"
"Asparagus"
"Avocados"
"Bacon and ham"
"Bambara beans"
*"Bananas"
"Bananas and plantains"
"Barley"
"Barley, pearled"
"Beans, dry"
"Beans, green"
*"Beer"
"Beer of barley"
"Beer of sorghum"
"Beeswax"
"Beet pulp"
"Beverages"
"Beverages, distilled alcoholic"
"Beverages, fermented rice"
"Beverages, non alcoholic"
"Beverages+Tobacco"
"Blueberries"
*"Bovine Meat"
"Bran, buckwheat"
"Bran, fonio"
"Bran, maize"
"Bran, millet"
"Bran, sorghum"
"Bran, wheat"
"Brazil nuts, shelled"
"Bread"
"Broad beans, horse beans, dry"
"Buckwheat"
"Bulgur"
"Butter"
"Butter of karite nuts"
"Butter, cow milk"
"Buttermilk, curdled, acidified milk"
"Cabbages and other brassicas"
"Cake, copra"
"Cake, cottonseed"
"Cake, groundnuts"
"Cake, hempseed"
"Cake, kapok"
"Cake, linseed"
"Cake, maize"
"Cake, mustard"
"Cake, palm kernel"
"Cake, rapeseed"
"Cake, rice bran"
"Cake, safflower"
"Cake, sesame seed"
"Cake, soybeans"
"Cake, sunflower"
"Canary seed"
"Cane tops"
"Canned Meat nes"
"Carrots and turnips"
"Cashew nuts, shelled"
"Cashew nuts, with shell"
"Cashewapple"
"Cassava"
"Cassava dried"
"Cassava Equivalent"
"Cauliflowers and broccoli"
"Cereal preparations, nes"
"Cereals"
"Cereals and Preparations"
"Cereals, breakfast"
"Cheese and Curd"
"Cheese, processed"
"Cheese, sheep milk"
"Cheese, whole cow milk"
"Cherries"
"Cherries, sour"
"Chestnut"
"Chick peas"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Chocolate products nes"
"Cider etc"
"Cigarettes"
"Cigars, cheroots"
"Cinnamon (canella)"
*"Cloves"
"Cocoa, beans"
"Cocoa, butter"
"Cocoa, paste"
"Cocoa, powder & cake"
"Coconuts"
"Coconuts, desiccated"
"Cocoons, unreelable & waste"
"Coffee Green+Roast"
"Coffee, extracts"
"Coffee, green"
"Coffee, husks and skins"
"Coffee, roasted"
"Coffee, substitutes containing coffee"
"Coffee+Tea+Cocoa+Sp"
"Copra"
*"Cotton lint"
"Cotton linter"
"Cotton waste"
"Cotton, carded, combed"
*"Cottonseed"
"Cranberries"
"Cream fresh"
"Crude materials"
"Crude Materials -Ex2"
"Crude Materials nes"
"Cucumbers and gherkins"
"Currants"
"Dairy Products+Eggs"
*"Dates"
"Dregs from brewing, distillation"
"Eggplants (aubergines)"
"Eggs in The Shell"
"Eggs Liquid,Dried"
"Eggs, dried"
"Eggs, hen, in shell"
"Eggs, liquid"
"Eggs, other bird, in shell"
"Fat, camels"
"Fat, cattle"
"Fat, liver prepared (foie gras)"
"Fat, nes, prepared"
"Fat, pigs"
"Fatty acids"
"Fatty substance residues"
"Feed and meal, gluten"
"Feed minerals"
"Feed supplements"
"Feed, compound, nes"
"Feed, pulp of fruit"
"Feed, vegetable products nes"
"Figs"
"Figs dried"
"Fixed Vegetable Oils"
"Flax Fib+Tow+W"
"Flax fibre and tow"
"Flax fibre raw"
"Flax tow waste"
"Flour, cereals"
"Flour, fonio"
"Flour, maize"
"Flour, mixed grain"
"Flour, mustard"
"Flour, potatoes"
"Flour, pulses"
"Flour, roots and tubers nes"
"Flour, wheat"
"Fodder & Feeding stuff"
"Fonio"
"Food and Animals"
"Food Excl Fish"
"Food prep nes"
"Food preparations, flour, malt extract"
"Food wastes"
"Forage and silage, clover"
"Forage and silage, grasses nes"
"Forage and silage, legumes"
"Forage products"
"Fructose and syrup, other"
"Fruit, cooked, homogenized preparations"
"Fruit, dried nes"
"Fruit, fresh nes"
"Fruit, prepared nes"
"Fruit, tropical fresh nes"
"Garlic"
"Germ, maize"
"Ghee, of buffalo milk"
"Ginger"
"Glucose and dextrose"
"Gooseberries"
"Grain, mixed"
"Grapefruit (inc. pomelos)"
"Grapes"
"Grease incl. lanolin wool"
"Groundnuts Total Shelled"
"Groundnuts, shelled"
"Hair, fine"
"Hair, goat, coarse"
"Hay (clover, lucerne,etc)"
"Hay (unspecified)"
"Hazelnuts, shelled"
"Hides and skins nes, fresh"
"Hides, buffalo, dry salted"
"Hides, buffalo, fresh"
"Hides, buffalo, wet salted"
"Hides, camel, nes"
"Hides, camel, wet salted"
"Hides, cattle, fresh"
"Hides, cattle, wet salted"
"Hides, horse, dry salted"
"Hides, nes"
"Honey, natural"
"Hops"
"Ice cream and edible ice"
*"Infant food"
"Juice, citrus, concentrated"
"Juice, citrus, single strength"
"Juice, fruit nes"
"Juice, grape"
"Juice, grapefruit"
"Juice, grapefruit, concentrated"
"Juice, lemon, concentrated"
"Juice, orange, concentrated"
"Juice, orange, single strength"
"Juice, pineapple"
"Juice, pineapple, concentrated"
"Juice, plum, concentrated"
"Juice, plum, single strength"
"Juice, tomato"
*"Jute"
"Jute+Bast Fibres"
"Kapok fibre"
"Kapokseed in shell"
"Kapokseed shelled"
"Kiwi fruit"
"Kola nuts"
"Lactose"
"Lard"
"Leeks, other alliaceous vegetables"
"Lemons and limes"
"Lentils"
"Lettuce and chicory"
"Linseed"
"Macaroni"
"Maize"
"Maize, green"
"Malt"
"Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"
"Maple sugar and syrups"
"Margarine, liquid"
"Margarine, short"
"Maté"
"Meal, meat"
"Meat and Meat Preparations"
"Meat Bovine Fresh"
"Meat Fresh+Ch+Frozen"
"Meat of Swine"
"Meat Poultry Fresh"
"Meat Prepared Pres"
"Meat Sheep Fresh"
"Meat, ass"
"Meat, beef and veal sausages"
"Meat, beef, preparations"
"Meat, cattle"
"Meat, cattle, boneless (beef & veal)"
"Meat, chicken"
"Meat, chicken, canned"
"Meat, dried nes"
"Meat, duck"
"Meat, game"
"Meat, goat"
"Meat, goose and guinea fowl"
"Meat, horse"
"Meat, nes"
"Meat, pig"
"Meat, pig sausages"
"Meat, pig, preparations"
"Meat, pork"
"Meat, rabbit"
"Meat, sheep"
"Meat, turkey"
"Melons, other (inc.cantaloupes)"
"Milk Condensed + Evaporated"
"Milk Condensed+Dry+Fresh"
"Milk Dry"
"Milk Equivalent"
"Milk Fresh"
"Milk, products of natural constituents nes"
"Milk, reconstituted"
"Milk, skimmed cow"
"Milk, skimmed dried"
"Milk, whole condensed"
"Milk, whole dried"
"Milk, whole evaporated"
"Milk, whole fresh cow"
"Milk, whole fresh sheep"
"Millet"
"Miscellaneous Food"
"Mixes and doughs"
*"Molasses"
"Mushrooms and truffles"
"Mushrooms, canned"
"Mustard seed"
"Natural Rubber"
"Nutmeg, mace and cardamoms"
"Nuts, nes"
"Nuts, prepared (exc. groundnuts)"
*"Oats"
"Oats rolled"
"Offals Edibl Fresh"
"Offals, edible, cattle"
"Offals, edible, goats"
"Offals, liver chicken"
"Offals, liver duck"
"Offals, liver geese"
"Offals, other camelids"
"Offals, pigs, edible"
"Offals, sheep,edible"
"Oil, boiled etc"
"Oil, castor beans"
"Oil, citronella"
"Oil, coconut (copra)"
"Oil, cottonseed"
"Oil, essential nes"
"Oil, groundnut"
"Oil, kapok"
"Oil, linseed"
"Oil, maize"
"Oil, olive residues"
"Oil, olive, virgin"
"Oil, palm"
"Oil, palm kernel"
"Oil, poppy"
"Oil, rapeseed"
"Oil, rice bran"
"Oil, safflower"
"Oil, sesame"
"Oil, soybean"
"Oil, sunflower"
"Oil, vegetable origin nes"
"Oils, fats of animal nes"
"Oilseed Cake Meal"
"Oilseed Cake nes"
"Oilseeds"
"Oilseeds nes"
"Olive Oil,Total"
"Olives"
"Olives preserved"
*"Onions"
"Onions, dry"
"Onions, shallots, green"
"Oranges"
"Oranges+Tang+Clem"
"Oth Citrus Frt"
"Other Meat"
"Ovine Meat"
"Papayas"
"Pastry"
"Peaches and nectarines"
"Peanut butter"
"Pears"
"Peas, dry"
"Peas, green"
"Pepper (piper spp.)"
"Peppermint"
"Persimmons"
"Pet food"
*"Pigmeat"
"Pineapples"
"Pineapples canned"
"Pistachios"
"Plantains and others"
"Plums and sloes"
"Plums dried (prunes)"
"Popcorn"
"Poppy seed"
"Potato offals"
"Potatoes"
"Potatoes, frozen"
*"Poultry Meat"
*"Pulses"
"Pumpkins, squash and gourds"
"Pyrethrum, dried"
"Pyrethrum, extraction"
"Quinces"
"Raisins"
"Rape+Mustard Oils"
"Rape+Mustard Seed"
"Rapeseed"
"Rice"
"Rice - total  (Rice milled equivalent)"
*the next one has a different "-" - hence both are needed, to be simplified, but the original data has this problem....
"Rice – total  (Rice milled equivalent)"


"Roots and tubers, nes"
"Rubber natural dry"
"Rubber, natural"
"Rye"
*"Sesame seed"
*"Silk"
"Silk raw"
"Silk-worm cocoons, reelable"
"Skins, calve, wet salted"
"Skins, goat, fresh"
"Skins, goat, wet salted"
"Skins, sheep, dry salted"
"Skins, sheep, fresh"
"Skins, sheep, wet salted"
"Skins, sheep, with wool"
"Sorghum"
"Soya curd"
"Soya paste"
"Soya sauce"
"Soybeans"
"Spices, nes"
"Spinach"
"Starch, cassava"
"Straw husks"
"Strawberries"
"Sugar and Honey"
*"Sugar beet"
"Sugar confectionery"
"Sugar crops, nes"
"Sugar flavoured"
*"Sugar non-centrifugal"
"Sugar Raw Centrifugal"
"Sugar refined"
"Sugar, nes"
"Sugar,Total (Raw Equiv.)"
*"Sunflower seed"
"Sweet corn frozen"
"Sweet corn prep or preserved"
*"Sweet potatoes"
"Tallow"
"Tangerines, mandarins, clementines, satsumas"
"Tea"
"Tea, mate extracts"
"Textile Fibres"
*"Tobacco"
"Tobacco products nes"
"Tobacco, unmanufactured"
"Tomatoes"
"Tomatoes, paste"
"Tomatoes, peeled"
"Total Meat"
"Total Merchandise Trade"
"Triticale"
*"Turnips for fodder"
"Vanilla"
"Vegetable tallow"
"Vegetables in vinegar"
"Vegetables, canned nes"
"Vegetables, dehydrated"
"Vegetables, dried nes"
"Vegetables, fresh nes"
"Vegetables, fresh or dried products nes"
"Vegetables, frozen"
"Vegetables, homogenized preparations"
"Vegetables, preserved nes"
"Vegetables, preserved, frozen"
"Vegetables, temporarily preserved"
"Vermouths & similar"
"Vetches"
"Vitamins"
"Wafers"
"Walnuts, shelled"
"Walnuts, with shell"
"Watermelons"
"Waters,ice etc"
"Waxes vegetable"
"Wheat"
"Wheat+Flour,Wheat Equivalent"
"Whey, condensed"
"Whey, dry"
"Whey, Pres+Concen"
*"Wine"
"Wine+Vermouth+Sim."
"Wool, degreased"
"Wool, greasy"
"Wool, hair waste"
"Yoghurt, concentrated or not"
*till here it equals FAOSTAT_TradeCropsAndLivestProdItems_NODoubles

*the following equals EighteenItemsInDetTradeItems_NotInTradeProdItems
"Animals live nes"
"Animals, live, non-food"
"Asses"
"Beehives"
"Buffaloes"
"Camelids, other"
"Camels"
"Cattle"
"Chickens"
"Ducks"
"Goats"
"Horses"
"Mules"
"Pigs"
"Rabbits and hares"
"Rodents, other"
"Sheep"
"Turkeys"
*till here it equals EighteenItemsInDetTradeItems_NotInTradeProdItems

*the following equals ReducedSetElements_FAOSTAT_WOSYItems
*"Manila fibre (abaca)"
"Agave Fibres Nes"
"Alcohol Non Food Purpose"
*"Alfalfa For Forage+Silag"
*"Alfalfa Meal And Pellets"
"Almonds"
*"Almonds Shelled"
*"Oils, fats of animal nes"
*"Anise, badian, fennel, coriander"
*"Apples"
"Applejuice Single Streng"
"Applejuice Concentrated"
*"Apricots"
*"Apricots, dry"
"Arabic Gum"
"Areca Nuts (Betel)"
*"Artichokes"
*"Asparagus"
*"Asses"
*"Avocados"
*"Bacon and ham"
"Bagasse"
*"Bambara Beans"
*"Bananas"
*"Barley"
"Barley Flour And Grits"
*"Barley, Pearled"
*"Beans, Dry"
*"Beans, Green"
*"Meat, cattle"
*"Meat, cattle, boneless (beef & veal)"
"Beef Canned"
"Beef Dried Salt Smoked"
*"Meat, beef, preparations"
*"Meat, beef and veal sausages"
*"Beehives"
*"Beer Of Barley"
"Beer Of Maize"
"Beer Of Millet"
*"Beer Of Sorghum"
*"Beeswax"
*"Beet Pulp"
"Beet Sugar"
"Beet Tops"
*"Beets For Fodder"
"Berries Nes"
*"Beverages, distilled alcoholic"
*"Beverages, non alcoholic"
"Biological Ass Meat"
"Biological Buffalo Meat"
"Biological Camel Meat"
"Biological Cattle Meat"
"Biological Chicken Meat"
"Biological Duck Meat"
"Biological Geese Meat"
"Biological Goat Meat"
"Biological Horse Meat"
"Biological Mule Meat"
"Biological Other Camel"
"Biological Other Poultry"
"Biological Pig Meat"
"Biological Rodents"
"Biological Sheep Meat"
"Biological Turkey Meat"
"Blood Meal"
*"Blueberries"
"Bran, Barley"
*"Bran, Buckwheat"
"Bran, Cereals"
*"Bran, Fonio"
*"Bran, Maize"
*"Bran, Millet"
"Bran, Mixed Grain"
"Bran, Oats"
"Bran, Pulses"
"Bran, Rice"
"Bran, Rye"
*"Bran, Sorghum"
"Bran, Triticale"
*"Bran, Wheat"
"Brazil Nuts"
*"Brazil nuts, Shelled"
*"Bread"
"Breakfast Cereals"
*"Broad beans, horse beans, dry"
"Broad Beans, Green"
*"Buckwheat"
"Buffalo Meat"
"Buffalo Milk"
*"Bulgur"
"Butter Of Buffalo Milk"
*"Butter, Cow Milk"
"Butter Of Goat Milk"
*"Butter Of Karite Nuts"
"Butter+Ghee (Sheep Milk)"
*"Buttermilk, curdled, acidified milk"
"Dry Buttermilk"
*"Cabbages and other brassicas"
*"Cake, copra"
*"Cake, Cottonseed"
*"Cake, Groundnuts"
*"Cake, Hempseed"
*"Cake, Kapok"
*"Cake, Linseed"
*"Cake, Maize"
*"Cake, Mustard"
"Cake, Palm Kernels"
"Cake Of Poppy Seed"
*"Cake, Rapeseed"
*"Cake, Rice Bran"
*"Cake, Safflower"
*"Cake, Sesame Seed"
*"Cake, Soybeans"
*"Cake, Sunflower"
"Cakes, Oilseeds Nes"
"Camel Hides, Fresh"
"Camel Milk"
*"Camels"
*"Canary Seed"
"Cane Sugar"
*"Cane Tops"
"Carobs"
*"Carrots and turnips"
"Casein"
*"Cashew Nuts, with shell"
*"Cashew Nuts, Shelled"
*"Cashewapple"
*"Cassava"
*"Cassava Dried"
"Cassava Leaves"
*"Starch, cassava"
"Cassava Tapioca"
"Castor Beans"
*"Cattle"
"Cattle Butcher Fat"
*"Hides, cattle, fresh"
*"Cauliflowers and broccoli"
"Cereals Nes"
*"Cereal preparations, nes"
"Cereals, most"
"Cheese Of Buffalo Milk"
"Cheese Of Goat Milk"
*"Cheese, Sheep Milk"
"Cheese (Skim Cow Milk)"
*"Cheese, Whole Cow Milk"
*"Cherries"
*"Chestnut"
*"Meat, chicken"
*"Meat, chicken, canned"
*"Chickens"
*"Chick Peas"
"Chicory Roots"
*"Chillies and peppers, green"
*"Chocolate Products Nes"
*"Cigarettes"
*"Cigars, Cheroots"
*"Cinnamon (Canella)"
"Citrus Fruit Nes"
*"Juice, citrus, single strength"
*"Juice, citrus, concentrated"
"Citrus, all"
*"Forage and silage, clover"
*"Cloves"
*"Hair, goat, coarse"
*"Cocoa, Beans"
*"Cocoa, Butter"
"Cocoa Husks+Shell"
*"Cocoa, Paste"
*"Cocoa, powder & cake"
*"Coconuts"
*"Coconuts, Desiccated"
*"Silk-worm cocoons, reelable"
*"Cocoons, unreelable & waste"
*"Coffee, Extracts"
*"Coffee, Green"
*"Coffee, Husks And Skins"
*"Coffee, Roasted"
*"Coffee, substitutes containing coffee"
"Coir"
"Compound Feed, Cattle"
"Compound Feed, Pigs"
"Compound Feed, Poultry"
*"Feed, compound, nes"
*"Copra"
*"Cotton, carded, combed"
*"Cotton Lint"
*"Cotton Linter"
*"Cotton Waste"
*"Cottonseed"
*"Milk, whole fresh cow"
"Cow Peas, Dry"
*"Cranberries"
*"Cream fresh"
*"Crude materials"
*"Cucumbers And Gherkins"
*"Currants"
*"Dates"
"Degras"
*"Dregs from brewing, distillation"
*"Meat, duck"
*"Ducks"
*"Eggplants (aubergines)"
*"Eggs, dried"
*"Eggs, other bird, in shell"
*"Eggs, Liquid"
"Empty fruit shells"
*"Oil, essential nes"
*"Tea, mate extracts"
*"Fat, liver prepared (foie gras)"
"Fat, Buffalo"
*"Fat, Camels"
*"Fat, Cattle"
"Fat, Goats"
"Fat, Other Camelids"
*"Fat, Pigs"
"Fat, Poultry"
"Fat, Poultry Rendered"
"Fat Of Sheep"
*"Fat, nes, prepared"
*"Fatty Acids"
"Feed Additives"
*"Feed Minerals"
*"Feed Supplements"
*"Cider etc"
"Fibre Crops Nes"
*"Figs"
*"Figs dried"
"Fine Goat Hair"
*"Fish Meal"
*"Flax Fibre And Tow"
*"Flax Fibre Raw"
*"Flax Tow Waste"
"Flour, Buckwheat"
"Flour, Cassava"
*"Flour, Cereals"
*"Flour, Fonio"
"Flour, Fruit"
*"Flour, Maize"
"Flour, Millet"
*"Flour, Mixed Grain"
*"Flour, Mustard"
*"Flour, Potatoes"
*"Flour, Pulses"
*"Flour, roots and tubers nes"
"Flour, Rye"
"Flour, Sorghum"
"Flour, Triticale"
*"Flour, Wheat"
"Flour/Meal Of Oilseeds"
*"Fonio"
*"Food prep nes"
*"Food preparations, flour, malt extract"
*"Food Wastes"
"Food Wastes Prep Feed"
*"Forage Products"
*"Fruit, cooked, homogenized preparations"
*"Fruit, Dried Nes"
*"Fruit, Fresh Nes"
*"Juice, fruit nes"
*"Fruit, Prepared Nes"
*"Feed, pulp of fruit"
*"Fruit, tropical fresh nes"
"Fruit Tropical Dried Nes"
"Fruit,Nut,Peel,Sugar Prs"
"Fruits, all"
"Fruits, most"
"Fur skin animal"
"Fur Skins"
"Game"
*"Meat, game"
*"Garlic"
"Geese"
*we added the following as in the WOSY data, it is "Geese and guinea fowls" and not "Geese" only"
"Geese and guinea fowls"
*"Germ, Maize"
"Germ, Wheat"
*"Ghee, of buffalo milk"
"Ghee, of cow milk"
*"Ginger"
*"Glucose And Dextrose"
*"Feed and meal, gluten"
*"Meat, goat"
"Goat Milk"
*"Goats"
*"Skins, goat, fresh"
*"Meat, goose and guinea fowl"
*"Gooseberries"
*"Juice, grape"
*"Grapefruit (inc. pomelos)"
*"Juice, grapefruit"
*"Juice, grapefruit, concentrated"
*"Grapes"
*"Forage and silage, grasses nes"
*"Grease incl. lanolin wool"
*"Maize, green"
"Groundnuts In Shell"
"Prepared Groundnuts"
*"Groundnuts, Shelled"
"Hair Carded Or Combed"
"Hair Coarse Nes"
*"Hair, Fine"
"Hair Of Horses"
*"Hay (clover, lucerne,etc)"
*"Hay (Unspecified)"
"Hay Non-Leguminous"
"Hazelnuts (Filberts)"
*"Hazelnuts, Shelled"
"Hemp Fibre And Tow"
"Hempseed"
*"Eggs, hen, in shell"
"Hide Dry-Salted"
*"Hides, nes"
"Hide Wet-Salted"
*"Hides, buffalo, dry salted"
"Hides, camel, dry salted"
"Hides, cattle, dry salted"
*"Hides, horse, dry salted"
"Hides Nes Cattle"
"Hides Of Asses Fresh"
"Hides Of Mules Fresh"
*"Hides, camel, nes"
"Hides Unspecified Horses"
*"Hides, buffalo, wet salted"
*"Hides, camel, wet salted"
*"Hides, cattle, wet salted"
"Hides, horse, wet salted"
*"Hides and skins nes, fresh"
"Homogenized Meat Prep."
*"Vegetables, homogenized preparations"
*"Honey, natural"
*"Hops"
"Horse Hides, Fresh"
*"Meat, horse"
*"Horses"
*"Ice Cream And Edible Ice"
"Indigenous Ass Meat"
"Indigenous Buffalo Meat"
"Indigenous Camel Meat"
"Indigenous Cattle Meat"
"Indigenous Chicken Meat"
"Indigenous Duck Meat"
"Indigenous Geese Meat"
"Indigenous Goat Meat"
"Indigenous Horse Meat"
"Indigenous Mule Meat"
"Indigenous Other Camel"
"Indigenous Other Poultry"
"Indigenous Pigmeat"
"Indigenous Rodents"
"Indigenous Sheep Meat"
"Indigenous Turkey Meat"
*"Infant Food"
"Isoglucose"
"Jojoba Oil"
*"Jute"
*"Jute-Like Fibres"
*"Kapok Fibre"
"Kapok Fruit"
*"Kapokseed In Shell"
*"Kapokseed Shelled"
"Karakul Skins"
"Karite Nuts (Sheanuts)"
*"Kiwi Fruit"
*"Kola nuts"
*"Lactose"
*"Lard"
"Lard And Stearine Oil"
"Leather Used And Waste"
"Leaves And Tops, Vines"
*"Leeks, other alliaceous vegetables"
*"Forage and silage, legumes"
"Lemonjuice Single-Streng"
*"Juice, lemon, concentrated"
*"Lemons And Limes"
*"Lentils"
*"Lettuce and chicory"
*"Linseed"
*"Margarine, liquid"
*"Animals, live, non-food"
"Live Animals Nes"
"Liver Preparationsa"
"Lupins"
*"Macaroni"
*"Maize"
*"Maize For Forage+Silage"
"Maize Gluten"
"Malt Extracts"
*"Malt"
"Mango Juice"
"Mango Pulp"
*"Mangoes, mangosteens, guavas"
*"Maple Sugar And Syrups"
"Marc Of Grapes"
*"Margarine, Short"
"Mate"
"Meat Extracts"
*"Meal, meat"
*"Meat, nes"
*"Meat, dried nes"
"Meat, Asses"
"Meat, Camels"
"Meat, Mules"
"Meat, Other Camelids"
"Meat, Other Rodents"
"Meat, Pigeon Oth.Birds"
"Meat Prepared Nes"
*"Melons, other (inc.cantaloupes)"
"Melonseed"
"Milled Paddy Rice"
*"Millet"
*"Grain, mixed"
*"Mixes And Doughs"
*"Molasses"
*"Mules"
*"Mushrooms and truffles"
*"Mushrooms, Canned"
"Dried Mushrooms"
"Must Of Grapes"
*"Mustard Seed"
*"Meat, sheep"
"Natural Gums"
*"Rubber, natural"
*"Nutmeg, mace and cardamoms"
*"Nuts, Nes"
"Nuts, all"
"Nuts, all, shelled"
*"Oats"
*"Oats Rolled"
*"Offals, Liver Chicken"
*"Offals, Liver Duck"
*"Offals, Liver Geese"
"Offals Liver Turkeys"
"Offals Nes"
"Offals, edible, Buffalo"
"Offals, edible, Camel"
*"Offals, edible, cattle"
*"Offals, edible, goats"
"Offals, Horse"
*"Offals, other camelids"
*"Offals, pigs, edible"
*"Offals, sheep,edible"
*"Oil, Castor Beans"
*"Oil, Citronella"
*"Oil, Coconut (copra)"
*"Oil, Cottonseed"
*"Oil, Groundnut"


"Oil, Hempseed"
*"Oil, Kapok"
*"Oil, Linseed"
*"Oil, Maize"
"Oil, Mustard Seed"
*"Oil, Olive Residues"
*"Oil, Palm Kernel"
*"Oil, Poppy"
*"Oil, Rapeseed"
*"Oil, Rice Bran"
*"Oil, Safflower"
*"Oil, Sesame"
*"Oil, Soybean"
*"Oil, Sunflower"
*"Oil, vegetable origin nes"
"Oil Palm Fruit"
*"Oil, boiled etc"
"Oils Fish And Marine Mam"
"Oils Hydrogenated"
*"Oilseeds Nes"
"Okra"
*"Oil, olive, virgin"
"Olive Residues"
*"Olives"
*"Olives Preserved"
*"Onions, Dry"
*"Onions, shallots, green"
*"Juice, orange, single strength"
*"Juice, orange, concentrated"
*"Oranges"
"Other birds for eggs"
*we added the following as in the WOSY data, it is available"
"Eggs Excl Hen"
*we added the following as in the WOSY data, it is available"
"Other Rodents"
*"Camelids, other"
"Other Concentrates, Nes"
*"Fructose and syrup, other"
*"Palm Kernels"
*"Oil, palm"
*"Papayas"
*"Pastry"
*"Peaches And Nectarines"
*"Peanut Butter"
*"Pears"
*"Peas, Dry"
*"Peas, Green"
*"Pepper (piper spp.)"
*"Peppermint"
*"Persimmons"
*"Pet Food"
"Pig Butcher Fat"
*"Meat, pig, preparations"
*"Meat, pig sausages"
"Pigeon Peas"
*"Pigeons Other Birds" - this was the original in this set - but in the WOSY data it has a comma, so we added this"
"Pigeons, Other Birds"
*"Meat, pig"
*"Pigs"
"Pigskins, Fresh"
*"Chillies and peppers, dry"
*"Pineapples"
*"Pineapples Canned"
*"Juice, pineapple"
*"Juice, pineapple, concentrated"
*"Pistachios"
*"Plantains and others"
*"Juice, plum, single strength"
*"Juice, plum, concentrated"
*"Plums and sloes"
"Plums, Dried (Prunes)"
"Pome Fruit Nes, Fresh"
*"Popcorn"
*"Poppy Seed"
*"Meat, pork"
"Pot Barley"
*"Potato Offals"
"Potato Starch"
"Potato Tapioca"
*"Potatoes"
*"Potatoes, frozen"
*"Nuts, prepared (exc. groundnuts)"
*"Cheese, processed"
*"Milk, products of natural constituents nes"
"Pulses Nes"
"Pulses, all"
*"Pumpkins, squash and gourds"
*"Pyrethrum, extraction"
"Pyrethrum Marc"
*"Pyrethrum, Dried"
*"Quinces"
"Quinoa"
*"Meat, rabbit"
"Rabbit Meat Biological"
"Rabbit Meat Indigenous"
"Rabbit Skins"
*"Rabbits and hares"
*"Raisins"
"Ramie"
*"Rapeseed"
"Raspberries"
*"Milk, reconstituted"
*"Fatty substance residues"
"Rice, Broken"
*"Beverages, fermented rice"
"Rice Flour"
"Rice Gluten"
"Rice, Husked"
"Milled/Husked Rice"
"Rice, Paddy"
"Rice, Starch"
"Roots and Tubers, most"
"Roots And Tubers Dried"
*"Roots And Tubers, Nes"
*"Rubber Natural Dry"
*"Rye"
"Safflower Seed"
"Seed Cotton"
*"Sesame Seed"
*"Sheep"
*"Milk, whole fresh sheep"
*"Skins, sheep, fresh"
*"Silk Raw"
"Silkworms"
*"Sisal"
"Skim Milk, Condensed"
*"Milk, skimmed dried"
"Skim Milk, Evaporated"
"Skim Milk Of Buffalo"
*"Milk, skimmed cow"
"Skim Milk Of Goat"
"Skim Sheep Milk"
"Skins, pig, dry salted"
*"Skins, sheep, dry salted"
"Skin Nes Pigs"
"Skin Nes Sheep"
"Skins, pig, wet salted"
*"Skins, sheep, wet salted"
*"Skins, sheep, with wool"
"Skins Dry-Salt Calves"
"Skins Dry-Salted Goats"
"Skins Fresh Of Calves"
"Skins Nes Calves"
"Skins Nes Goats"
*"Skins, calve, wet salted"
*"Skins, goat, wet salted"
"Snails Not Sea Snails"
*"Sorghum"
*"Cherries, sour"
*"Soya Curd"
*"Soya Paste"
*"Soya Sauce"
*"Soybeans"
"Spermaceti"
*"Spices, nes"
*"Spinach"
"Standardized Milk"
"Starch and Sugar crops for Alc"
"Starch Of Maize"
"Stillingia Oil"
"Stone Fruit Nes, Fresh"
*"Straw Husks"
*"Strawberries"
"String Beans"
*"Sugar, Nes"
*"Sugar Beet"
*"Sugar Cane"
*"Sugar Confectionery"
*"Sugar Crops, Nes"
*"Sugar Refined"
*"Sugar raw centrifugal"
*"Sugar non-centrifugal"
*"Sugar Flavoured"
*"Sunflower Seed"
*"Swedes For Fodder"
*"Sweet Corn Frozen"
*"Sweet corn prep or preserved"
*"Sweet Potatoes"
*"Tallow"
"Tallowtree Seeds"
"Tangerine Juice"
*"Tangerines, mandarins, clementines, satsumas"
"Taro (Coco Yam)"
*"Tea"
"Tea Nes"
*"Tobacco, unmanufactured"
*"Tobacco Products Nes"
*"Juice, tomato"
"Tomatojuice Concentrated"
*"Tomatoes, Paste"
*"Tomatoes"
*"Tomatoes, peeled"
*"Triticale"
"Tung Oil"
"Tung Nuts"
*"Meat, turkey"
*"Turkeys"
*"Turnips For Fodder"
*"Vanilla"
*"Vegetables, fresh or dried products nes"
*"Feed, vegetable products nes"
*"Vegetable Tallow"
*"Vegetables, Dehydrated"
*"Vegetables, Frozen"
*"Vegetables, canned nes"
*"Vegetables, Dried Nes"
*"Vegetables, Fresh Nes"
"Juice Of Vegetables Nes"
*"Vegetables in vinegar"
*"Vegetables, preserved nes"
*"Vegetables, preserved, frozen"
*"Vegetables, temporarily preserved"
"Vegetables, most"
*"Vegetables+Roots,Fodder"
*"Vermouths & similar"
*"Vetches"
*"Vitamins"
*"Wafers"
*"Walnuts, with shell"
*"Walnuts, shelled"
*"Watermelons"
*"Waters,Ice Etc"
*"Waxes vegetable"
*"Wheat"
"Wheat Fermented Beverage"
"Wheat Gluten"
"Wheat Starch"
"Whey Cheese"
*"Whey, Condensed"
*"Whey, dry"
"Whey, Fresh"
*"Milk, whole condensed"
*"Milk, whole dried"
*"Milk, whole evaporated"
*"Wine"
*"Wool, Hair Waste"
"Wool Shoddy"
*"Wool, Greasy"
*"Wool, degreased"
*"Yams"
"Yautia (Cocoyam)"
"Yoghurt"
*"Yoghurt, concentrated or not"
*till here it equals ReducedSetElements_FAOSTAT_WOSYItems

*added for matching with livestock activities, as they are missing in the commodities as above:
"Meat, birds nes"
"Meat, buffaloes"
"Milk, whole fresh buffalo"
"Milk, whole fresh camel"
"Milk, whole fresh goat"

*added for matching with crop activities, as they are missing in the commodities as above:
"Almonds, with shell"
"Areca nuts"
"Bastfibres, other"
"Brazil nuts, with shell"
"Castor oil seed"
"Cereals (Rice Milled Eqv)"
"Cereals, nes"
"Fibre Crops Primary"
"Fruit, citrus nes"
"Fruit, pome nes"
"Fruit, stone nes"
"Groundnuts, with shell"
"Gums, natural"
"Hazelnuts, with shell"
"Hemp tow waste"
"Jojoba seed"
"Jute & Jute-like Fibres"
"Oil, palm fruit"
"Pulses, nes"
"Tallowtree seed"
"Taro (cocoyam)"
"Vegetables, leguminous nes"

*the following are somme feed aggregates that are needed:
AggregateFeedTotal_Commodity
AggregateFeedConcentrates_Commodity
AggregateFeedForageCrops_Commodity
AggregateFeedGrass_Commodity
AggregateFeedNoForageNoGrass_Commodity
AggregateFeedResidues_Commodity
AggregateFeedConcMainProd_Commodity
AggregateFeedConcByProd_Commodity

AggregateFeedCereals_Commodity
AggregateFeedOilCropsAndCakes_Commodity
AggregateFeedPulses_Commodity
AggregateFeedRoots_Commodity
AggregateFeedSugar_Commodity
AggregateFeedOtherPlant_Commodity
AggregateFeedOtherAnimal_Commodity

*and some commodity aggregates - general, i.e. primarily food groups:
Cereals_CommodityGroup
FodderCrops_CommodityGroup
Fruits_CommodityGroup
Nuts_CommodityGroup
Oilcrops_CommodityGroup
OtherCrops_CommodityGroup
Pulses_CommodityGroup
RootsAndTubers_CommodityGroup
Sugarcrops_CommodityGroup
Vegetables_CommodityGroup
Milk_CommodityGroup
Meat_CommodityGroup
Eggs_CommodityGroup
FishSeafood_CommodityGroup

"All Residues"

"All Commodities"
"All crop based Commodities"
"All animal based Commodities"
"All commod. - prim. prod. from crop act."
"All commod. - prim. prod. from animal act."

"All Forage Commodities"
"All Cereal Commodities"

*the following are additional commodities (main and co-products) not included in FAOSTAT, needed for capturing the commodity trees, added by A. Muller on 7.8.2019
*level1 and 2 refer to the levels in the commodity trees, cf. _V6_ReadData_CommodityTrees_LinkActivitiesAndCommodities
*new co-prod: Level1
"Rice hulls"
"Groundnut shells"
"Beer of Shorgum dregs"
"Cocoa husks"
"Karite nut cake"
"Almond shells"
"Apricot kernel"
"Chestnut shells"
"Coconut shells"
"Cashew nut shells"
"Brazil nut shells"
"Tomato pulp"
"Grape pulp"
"Grapefruit pulp"
"Lemon pulp"
"Orange pulp"
"Pineapple pulp"
"Plum pulp"
"Hazelnut shells"
"Castor bean cake"
*"Palm kernels"
"Walnut shells"
"Apple pulp"
"Jojoba cake"
"Tangerine pulp"
"Tung nut cake"
"Molasse from cane"
"Molasse from beet"
*New main prod:level 1
"Oat flour"
"Cocoa paste"
*new co-prod Level2
"Beer of Barley dregs"
"Kapokseed shells"
"Pressed olive residues"
*new main prod Level2
"Palm kernel oil"
"Wheat dregs"
"Oil palm fruit pulp"

*for stone fruits, add the kernel shells (e.g. used for bioenergy potential calculations)
"Apricot kernel shells"
"Cherries - kernels"
"Cherries, sour - kernels"
"Peaches and nectarines - kernels"
"Plums and sloes - kernels"
*and also:
"Dates - kernels"
"Pistachio shells"


*and for Set1 (no single commod, thus not to be added to the single commod set):
"Dregs - beer"
"Citrus pulp"
"Fruit pulp"
"Brans, mixed grain"

*the following commodities are added for filing in FOFA2050
"FOFA2050 Sheep and Goat Meat"
"FOFA2050 All Fish"
"FOFA2050 Dried pulses"
"FOFA2050 Sweet potato and yams"
"FOFA2050 Other cereals"
"FOFA2050 Other crops"
"FOFA2050 Other fruits"
"FOFA2050 Oilcrops, nes, oil"
"FOFA2050 Other roots and tubers"
"FOFA2050 Other vegetables"
"FOFA2050 Other oilseeds"

"FOFA2050 Total commodities"

"BioBam UNISECO OtherCrops"

*the following is added for BioeSR15
Miscanthus

*additional commodities for NFP69
* not in the list but needed
"Flour, Spelt"
*also add the co-product:
"Bran, spelt"
* new for nfp69
'Salt'
'Water'
'Hard cheese'
'Semihard cheese'
'Soft cheese'
'Leafy vegetables'
'Branch vegetables'
'Fruit vegetables'
'Root vegetables'
'Cauliflower vegetables'
'Seasoning'
"CoProds Seasoning"
"Oil cakes - various"

"Spelt"

*added as an aggregate only used in some intermediate calculation for DAQ
'Milk'
/;

*we need this set twice to define the commodity-tree parameters
alias(Commodities,Commodities_2);

*commodity subset for forage crops:
Set ForageCommodities(Commodities) "Subset containing all forage commodities"
/
"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Forage Products Nes"

*other fodder crops
"Beets For Fodder"
"Swedes For Fodder"
"Turnips For Fodder"
"Vegetables+Roots,Fodder"

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
"Cabbage, for forage"
"Carrots, for forage"
"Other grasses, for forage"
"Other oilseeds, for forage"
"Rye grass, for forage"
"Sorghum, for forage"
/;

Set GrassCommodities(Commodities) "Subset containing all grass commodities"
/
'Temporary meadows and pastures'
'Permanent meadows and pastures'
/;

Set ConcentrateCommodities(Commodities) "Subset containing all concentrate commodities"
/
'Bananas'
'Cloves'
'Cottonseed'
'Dates'
'Oats'
'Palm kernels'
'Sesame seed'
'Sugar beet'
'Sugar cane'
'Sunflower seed'
'Sweet potatoes'
'Yams'
'Turnips for fodder'
'Aquatic Plants'
'Aquatic Products, Other'
'Cephalopods'
'Crustaceans'
'Demersal Fish'
'Freshwater Fish'
'Pelagic Fish'
'Beets For Fodder'
'Swedes For Fodder'
'Molasses'
"Molasses (sugar cane)"
"Molasses (sugar beet)"
'Plantains'
'Sugar non-centrifugal'
'Animal fats'
'Bovine Meat'
'Onions'
'Pulses'
'Apples and products'
'Barley and products'
'Beans'
'Brans'
'Cassava and products'
'Cereals - Excluding Beer'
'Cereals, Other'
'Cocoa Beans and products'
'Coconuts - Incl Copra'
'Copra Cake'
'Cottonseed Cake'
'Fruits - Excluding Wine'
'Fruits, Other'
'Groundnut Cake'
'Groundnuts (in Shell Eq)'
'Groundnuts (Shelled Eq)'
'Maize and products'
'Millet and products'
'Oilcrops'
'Oilcrops Oil, Other'
'Oilcrops, Other'
'Oilseed Cakes, Other'
'Olive Oil'
'Olives (including preserved)'
'Oranges, Mandarines'
'Palm Oil'
'Palmkernel Cake'
'Peas'
'Potatoes and products'
'Pulses, Other and products'
'Rape and Mustard Cake'
'Rape and Mustard Oil'
'Rape and Mustardseed'
'Rice (Milled Equivalent)'
'Rice (Paddy Equivalent)'
'Roots & Tuber Dry Equiv'
'Roots, Other'
'Rye and products'
'Sesameseed Cake'
'Sesameseed Oil'
'Sorghum and products'
'Soyabean Cake'
'Soyabean Oil'
'Soyabeans'
'Spices'
'Starchy Roots'
'Stimulants'
'Sugar & Sweeteners'
'Sugar (Raw Equivalent)'
'Sugar Crops'
'Sugar, Raw Equivalent'
'Sugar, Refined Equiv'
"Sugar, Refined Equiv (sugar cane)"
"Sugar, Refined Equiv (sugar beet)"
'Sunflowerseed Cake'
'Sweeteners, Other'
'Tomatoes and products'
'Vegetable Oils'
'Vegetables'
'Vegetables, Other'
'Wheat and products'
'Butter, Ghee'
'Cheese'
'Eggs'
'Fats, Animals, Raw'
'Fish Meal'
'Fish, Body Oil'
'Fish, Liver Oil'
'Fish, Seafood'
'Honey'
'Marine Fish, Other'
'Meat'
'Meat Meal'
'Meat, Other'
'Milk - Excluding Butter'
'Milk, Skimmed'
'Milk, Whole'
'Molluscs, Other'
'Mutton & Goat Meat'
'Offals'
'Offals, Edible'
'Whey'

"Spelt"
/;


Set Commodities_SingleCommodities(Commodities) "Subset containing single commodities only - no additional aggregates;"
*        description continued: but some commodities may be listed twice, e.g. Pork and Pigmeat, etc., some may be aggregates from the original data (e.g. vegetables) - but usually only one of them then has an entry, I think."
/
"Abaca"
"Alcohol, Non-Food"
"Alcoholic Beverages"
"Apples and products"
"Bananas"
"Barley and products"
"Beans"
"Beer"
"Beverages, Alcoholic"
"Beverages, Fermented"
"Brans"
"Cassava and products"
"Cereals - Excluding Beer"
"Cereals, Other"
"Citrus, Other"
"Cloves"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Coffee and products"
"Copra Cake"
"Cotton lint"
"Cottonseed"
"Cottonseed Cake"
"Cottonseed Oil"
"Dates"
"Fruits - Excluding Wine"
"Fruits, Other"
"Grand Total"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Groundnut Cake"
"Groundnut Oil"
"Groundnuts (in Shell Eq)"
"Groundnuts (Shelled Eq)"
"Hard Fibres, Other"
"Infant food"
"Jute"
"Jute-Like Fibres"
"Lemons, Limes and products"
"Maize and products"
"Maize Germ Oil"
"Millet and products"
"Miscellaneous"
"Molasses"
"Molasses (sugar cane)"
"Molasses (sugar beet)"
"Nuts and products"
"Oats"
"Oilcrops"
"Oilcrops Oil, Other"
"Oilcrops, Other"
"Oilseed Cakes, Other"
"Olive Oil"
"Olives (including preserved)"
"Onions"
"Oranges, Mandarines"
"Palm kernels"
"Palm Oil"
"Palmkernel Cake"
"Palmkernel Oil"
"Peas"
"Pepper"
"Pimento"
"Pineapples and products"
"Plantains"
"Potatoes and products"
"Pulses"
"Pulses, Other and products"
"Rape and Mustard Cake"
"Rape and Mustard Oil"
"Rape and Mustardseed"
"Rice (Milled Equivalent)"
"Rice (Paddy Equivalent)"
"Ricebran Oil"
"Roots & Tuber Dry Equiv"
"Roots, Other"
"Rubber"
"Rye and products"
"Sesame seed"
"Sesameseed Cake"
"Sesameseed Oil"
"Sisal"
"Soft-Fibres, Other"
"Sorghum and products"
"Soyabean Cake"
"Soyabean Oil"
"Soyabeans"
"Spices"
"Spices, Other"
"Starchy Roots"
"Stimulants"
"Sugar & Sweeteners"
"Sugar (Raw Equivalent)"
"Sugar beet"
"Sugar cane"
"Sugar Crops"
"Sugar non-centrifugal"
"Sugar, Raw Equivalent"
"Sugar, Refined Equiv"
"Sugar, Refined Equiv (sugar cane)"
"Sugar, Refined Equiv (sugar beet)"
"Sunflower seed"
"Sunflowerseed Cake"
"Sunflowerseed Oil"
"Sweet potatoes"
"Sweeteners, Other"
"Tea (including mate)"
"Tobacco"
"Tobacco & Rubber"
"Tomatoes and products"
"Treenuts"
"Vegetable Oils"
"Vegetables"
"Vegetables, Other"
"Vegetal Products"
"Wheat and products"
"Wine"
"Yams"
*till here it equals FAOSTAT_CropCommodityBalancesItems

*the following equals FAOSTAT_LivestockFishCommodityBalancesItems
"Animal fats"
"Animal Products"
"Aquatic Animals, Others"
"Aquatic Plants"
"Aquatic Products, Other"
"Bovine Meat"
"Butter, Ghee"
"Cephalopods"
"Cheese"
"Cream"
"Crustaceans"
"Demersal Fish"
"Eggs"
"Fats, Animals, Raw"
"Fish Meal"
"Fish, Body Oil"
"Fish, Liver Oil"
"Fish, Seafood"
"Freshwater Fish"
*"Grand Total"
"Hides and skins"
"Honey"
"Marine Fish, Other"
"Meat"
"Meat Meal"
"Meat, Aquatic Mammals"
"Meat, Other"
"Milk - Excluding Butter"
"Milk, Skimmed"
"Milk, Whole"
"Molluscs, Other"
"Mutton & Goat Meat"
"Offals"
"Offals, Edible"
"Pelagic Fish"
"Pigmeat"
"Poultry Meat"
"Silk"
"Whey"
"Wool (Clean Eq.)"
*till here it equals FAOSTAT_LivestockFishCommodityBalancesItems

*the following equals NON_FAOSTAT_CropProductionItems
$ontext;
In FAOSTAT, but currently not available:
635         "Straw husks"
636         "Forage and silage, maize"
637         "Forage and silage, sorghum"
638         "Forage and silage, rye grass"
639         "Forage and silage, grasses nes"
640         "Forage and silage, clover"
641         "Forage and silage, alfalfa"
642         "Forage and silage, green oilseeds"
643         "Forage and silage, legumes"
644         "Cabbage for fodder"
645         "Mixed Grasses and Legumes"
646         "Turnips for fodder"
647         "Beets for fodder"
648         "Carrots for fodder"
649         "Swedes for fodder"
651         "Forage products"
652         "Feed, vegetable products nes"
653         "Food wastes"
654         "Dregs from brewing, distillation"
655         "Vegetables and roots fodder"
$offtext;

"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Forage Products Nes"

*other fodder crops
"Beets For Fodder"
"Swedes For Fodder"
"Turnips For Fodder"
"Vegetables+Roots,Fodder"

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
"Cabbage, for forage"
"Carrots, for forage"
"Other grasses, for forage"
"Other oilseeds, for forage"
"Rye grass, for forage"
"Sorghum, for forage"

Fallows

"Temporary meadows and pastures"
"Permanent meadows and pastures"

*"Pure legume sward"
*Grassclass1
*Grassclass2
*Grassclass3
*Grassclass4
*till here it equals NON_FAOSTAT_CropProductionItems

*the following equals FAOSTAT_TradeCropsAndLivestProdItems_NODoubles
"Agricult.Products,Total"
"Alfalfa meal and pellets"
"Almonds shelled"
*"Animal fats"
"Animal Oil+Fat+Grs"
"Animal Vegetable Oil"
"Anise, badian, fennel, coriander"
"Apples"
"Apricots"
"Apricots, dry"
"Artichokes"
"Asparagus"
"Avocados"
"Bacon and ham"
"Bambara beans"
*"Bananas"
"Bananas and plantains"
"Barley"
"Barley, pearled"
"Beans, dry"
"Beans, green"
*"Beer"
"Beer of barley"
"Beer of sorghum"
"Beeswax"
"Beet pulp"
"Beverages"
"Beverages, distilled alcoholic"
"Beverages, fermented rice"
"Beverages, non alcoholic"
"Beverages+Tobacco"
"Blueberries"
*"Bovine Meat"
"Bran, buckwheat"
"Bran, fonio"
"Bran, maize"
"Bran, millet"
"Bran, sorghum"
"Bran, wheat"
"Brazil nuts, shelled"
"Bread"
"Broad beans, horse beans, dry"
"Buckwheat"
"Bulgur"
"Butter"
"Butter of karite nuts"
"Butter, cow milk"
"Buttermilk, curdled, acidified milk"
"Cabbages and other brassicas"
"Cake, copra"
"Cake, cottonseed"
"Cake, groundnuts"
"Cake, hempseed"
"Cake, kapok"
"Cake, linseed"
"Cake, maize"
"Cake, mustard"
"Cake, palm kernel"
"Cake, rapeseed"
"Cake, rice bran"
"Cake, safflower"
"Cake, sesame seed"
"Cake, soybeans"
"Cake, sunflower"
"Canary seed"
"Cane tops"
"Canned Meat nes"
"Carrots and turnips"
"Cashew nuts, shelled"
"Cashew nuts, with shell"
"Cashewapple"
"Cassava"
"Cassava dried"
"Cassava Equivalent"
"Cauliflowers and broccoli"
"Cereal preparations, nes"
"Cereals"
"Cereals and Preparations"
"Cereals, breakfast"
"Cheese and Curd"
"Cheese, processed"
"Cheese, sheep milk"
"Cheese, whole cow milk"
"Cherries"
"Cherries, sour"
"Chestnut"
"Chick peas"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Chocolate products nes"
"Cider etc"
"Cigarettes"
"Cigars, cheroots"
"Cinnamon (canella)"
*"Cloves"
"Cocoa, beans"
"Cocoa, butter"
"Cocoa, paste"
"Cocoa, powder & cake"
"Coconuts"
"Coconuts, desiccated"
"Cocoons, unreelable & waste"
"Coffee Green+Roast"
"Coffee, extracts"
"Coffee, green"
"Coffee, husks and skins"
"Coffee, roasted"
"Coffee, substitutes containing coffee"
"Coffee+Tea+Cocoa+Sp"
"Copra"
*"Cotton lint"
"Cotton linter"
"Cotton waste"
"Cotton, carded, combed"
*"Cottonseed"
"Cranberries"
"Cream fresh"
"Crude materials"
"Crude Materials -Ex2"
"Crude Materials nes"
"Cucumbers and gherkins"
"Currants"
"Dairy Products+Eggs"
*"Dates"
"Dregs from brewing, distillation"
"Eggplants (aubergines)"
"Eggs in The Shell"
"Eggs Liquid,Dried"
"Eggs, dried"
"Eggs, hen, in shell"
"Eggs, liquid"
"Eggs, other bird, in shell"
"Fat, camels"
"Fat, cattle"
"Fat, liver prepared (foie gras)"
"Fat, nes, prepared"
"Fat, pigs"
"Fatty acids"
"Fatty substance residues"
"Feed and meal, gluten"
"Feed minerals"
"Feed supplements"
"Feed, compound, nes"
"Feed, pulp of fruit"
"Feed, vegetable products nes"
"Figs"
"Figs dried"
"Fixed Vegetable Oils"
"Flax Fib+Tow+W"
"Flax fibre and tow"
"Flax fibre raw"
"Flax tow waste"
"Flour, cereals"
"Flour, fonio"
"Flour, maize"
"Flour, mixed grain"
"Flour, mustard"
"Flour, potatoes"
"Flour, pulses"
"Flour, roots and tubers nes"
"Flour, wheat"
"Fodder & Feeding stuff"
"Fonio"
"Food and Animals"
"Food Excl Fish"
"Food prep nes"
"Food preparations, flour, malt extract"
"Food wastes"
"Forage and silage, clover"
"Forage and silage, grasses nes"
"Forage and silage, legumes"
"Forage products"
"Fructose and syrup, other"
"Fruit, cooked, homogenized preparations"
"Fruit, dried nes"
"Fruit, fresh nes"
"Fruit, prepared nes"
"Fruit, tropical fresh nes"
"Garlic"
"Germ, maize"
"Ghee, of buffalo milk"
"Ginger"
"Glucose and dextrose"
"Gooseberries"
"Grain, mixed"
"Grapefruit (inc. pomelos)"
"Grapes"
"Grease incl. lanolin wool"
"Groundnuts Total Shelled"
"Groundnuts, shelled"
"Hair, fine"
"Hair, goat, coarse"
"Hay (clover, lucerne,etc)"
"Hay (unspecified)"
"Hazelnuts, shelled"
"Hides and skins nes, fresh"
"Hides, buffalo, dry salted"
"Hides, buffalo, fresh"
"Hides, buffalo, wet salted"
"Hides, camel, nes"
"Hides, camel, wet salted"
"Hides, cattle, fresh"
"Hides, cattle, wet salted"
"Hides, horse, dry salted"
"Hides, nes"
"Honey, natural"
"Hops"
"Ice cream and edible ice"
*"Infant food"
"Juice, citrus, concentrated"
"Juice, citrus, single strength"
"Juice, fruit nes"
"Juice, grape"
"Juice, grapefruit"
"Juice, grapefruit, concentrated"
"Juice, lemon, concentrated"
"Juice, orange, concentrated"
"Juice, orange, single strength"
"Juice, pineapple"
"Juice, pineapple, concentrated"
"Juice, plum, concentrated"
"Juice, plum, single strength"
"Juice, tomato"
*"Jute"
"Jute+Bast Fibres"
"Kapok fibre"
"Kapokseed in shell"
"Kapokseed shelled"
"Kiwi fruit"
"Kola nuts"
"Lactose"
"Lard"
"Leeks, other alliaceous vegetables"
"Lemons and limes"
"Lentils"
"Lettuce and chicory"
"Linseed"
"Macaroni"
"Maize"
"Maize, green"
"Malt"
"Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"
"Maple sugar and syrups"
"Margarine, liquid"
"Margarine, short"
"Maté"
"Meal, meat"
"Meat and Meat Preparations"
"Meat Bovine Fresh"
"Meat Fresh+Ch+Frozen"
"Meat of Swine"
"Meat Poultry Fresh"
"Meat Prepared Pres"
"Meat Sheep Fresh"
"Meat, ass"
"Meat, beef and veal sausages"
"Meat, beef, preparations"
"Meat, cattle"
"Meat, cattle, boneless (beef & veal)"
"Meat, chicken"
"Meat, chicken, canned"
"Meat, dried nes"
"Meat, duck"
"Meat, game"
"Meat, goat"
"Meat, goose and guinea fowl"
"Meat, horse"
"Meat, nes"
"Meat, pig"
"Meat, pig sausages"
"Meat, pig, preparations"
"Meat, pork"
"Meat, rabbit"
"Meat, sheep"
"Meat, turkey"
"Melons, other (inc.cantaloupes)"
"Milk Condensed + Evaporated"
"Milk Condensed+Dry+Fresh"
"Milk Dry"
"Milk Equivalent"
"Milk Fresh"
"Milk, products of natural constituents nes"
"Milk, reconstituted"
"Milk, skimmed cow"
"Milk, skimmed dried"
"Milk, whole condensed"
"Milk, whole dried"
"Milk, whole evaporated"
"Milk, whole fresh cow"
"Milk, whole fresh sheep"
"Millet"
"Miscellaneous Food"
"Mixes and doughs"
*"Molasses"
"Mushrooms and truffles"
"Mushrooms, canned"
"Mustard seed"
"Natural Rubber"
"Nutmeg, mace and cardamoms"
"Nuts, nes"
"Nuts, prepared (exc. groundnuts)"
*"Oats"
"Oats rolled"
"Offals Edibl Fresh"
"Offals, edible, cattle"
"Offals, edible, goats"
"Offals, liver chicken"
"Offals, liver duck"
"Offals, liver geese"
"Offals, other camelids"
"Offals, pigs, edible"
"Offals, sheep,edible"
"Oil, boiled etc"
"Oil, castor beans"
"Oil, citronella"
"Oil, coconut (copra)"
"Oil, cottonseed"
"Oil, essential nes"
"Oil, groundnut"
"Oil, kapok"
"Oil, linseed"
"Oil, maize"
"Oil, olive residues"
"Oil, olive, virgin"
"Oil, palm"
"Oil, palm kernel"
"Oil, poppy"
"Oil, rapeseed"
"Oil, rice bran"
"Oil, safflower"
"Oil, sesame"
"Oil, soybean"
"Oil, sunflower"
"Oil, vegetable origin nes"
"Oils, fats of animal nes"
"Oilseed Cake Meal"
"Oilseed Cake nes"
"Oilseeds"
"Oilseeds nes"
"Olive Oil,Total"
"Olives"
"Olives preserved"
*"Onions"
"Onions, dry"
"Onions, shallots, green"
"Oranges"
"Oranges+Tang+Clem"
"Oth Citrus Frt"
"Other Meat"
"Ovine Meat"
"Papayas"
"Pastry"
"Peaches and nectarines"
"Peanut butter"
"Pears"
"Peas, dry"
"Peas, green"
"Pepper (piper spp.)"
"Peppermint"
"Persimmons"
"Pet food"
*"Pigmeat"
"Pineapples"
"Pineapples canned"
"Pistachios"
"Plantains and others"
"Plums and sloes"
"Plums dried (prunes)"
"Popcorn"
"Poppy seed"
"Potato offals"
"Potatoes"
"Potatoes, frozen"
*"Poultry Meat"
*"Pulses"
"Pumpkins, squash and gourds"
"Pyrethrum, dried"
"Pyrethrum, extraction"
"Quinces"
"Raisins"
"Rape+Mustard Oils"
"Rape+Mustard Seed"
"Rapeseed"
"Rice"
"Rice - total  (Rice milled equivalent)"
*the next one has a different "-" - hence both are needed, to be cimplified, but the original data has this problem....
"Rice – total  (Rice milled equivalent)"


"Roots and tubers, nes"
"Rubber natural dry"
"Rubber, natural"
"Rye"
*"Sesame seed"
*"Silk"
"Silk raw"
"Silk-worm cocoons, reelable"
"Skins, calve, wet salted"
"Skins, goat, fresh"
"Skins, goat, wet salted"
"Skins, sheep, dry salted"
"Skins, sheep, fresh"
"Skins, sheep, wet salted"
"Skins, sheep, with wool"
"Sorghum"
"Soya curd"
"Soya paste"
"Soya sauce"
"Soybeans"
"Spices, nes"
"Spinach"
"Starch, cassava"
"Straw husks"
"Strawberries"
"Sugar and Honey"
*"Sugar beet"
"Sugar confectionery"
"Sugar crops, nes"
"Sugar flavoured"
*"Sugar non-centrifugal"
"Sugar Raw Centrifugal"
"Sugar refined"
"Sugar, nes"
"Sugar,Total (Raw Equiv.)"
*"Sunflower seed"
"Sweet corn frozen"
"Sweet corn prep or preserved"
*"Sweet potatoes"
"Tallow"
"Tangerines, mandarins, clementines, satsumas"
"Tea"
"Tea, mate extracts"
"Textile Fibres"
*"Tobacco"
"Tobacco products nes"
"Tobacco, unmanufactured"
"Tomatoes"
"Tomatoes, paste"
"Tomatoes, peeled"
"Total Meat"
"Total Merchandise Trade"
"Triticale"
*"Turnips for fodder"
"Vanilla"
"Vegetable tallow"
"Vegetables in vinegar"
"Vegetables, canned nes"
"Vegetables, dehydrated"
"Vegetables, dried nes"
"Vegetables, fresh nes"
"Vegetables, fresh or dried products nes"
"Vegetables, frozen"
"Vegetables, homogenized preparations"
"Vegetables, preserved nes"
"Vegetables, preserved, frozen"
"Vegetables, temporarily preserved"
"Vermouths & similar"
"Vetches"
"Vitamins"
"Wafers"
"Walnuts, shelled"
"Walnuts, with shell"
"Watermelons"
"Waters,ice etc"
"Waxes vegetable"
"Wheat"
"Wheat+Flour,Wheat Equivalent"
"Whey, condensed"
"Whey, dry"
"Whey, Pres+Concen"
*"Wine"
"Wine+Vermouth+Sim."
"Wool, degreased"
"Wool, greasy"
"Wool, hair waste"
"Yoghurt, concentrated or not"
*till here it equals FAOSTAT_TradeCropsAndLivestProdItems_NODoubles

*the following equals EighteenItemsInDetTradeItems_NotInTradeProdItems
"Animals live nes"
"Animals, live, non-food"
"Asses"
"Beehives"
"Buffaloes"
"Camelids, other"
"Camels"
"Cattle"
"Chickens"
"Ducks"
"Goats"
"Horses"
"Mules"
"Pigs"
"Rabbits and hares"
"Rodents, other"
"Sheep"
"Turkeys"
*till here it equals EighteenItemsInDetTradeItems_NotInTradeProdItems

*the following equals ReducedSetElements_FAOSTAT_WOSYItems
*"Manila fibre (abaca)"
"Agave Fibres Nes"
"Alcohol Non Food Purpose"
*"Alfalfa For Forage+Silag"
*"Alfalfa Meal And Pellets"
"Almonds"
*"Almonds Shelled"
*"Oils, fats of animal nes"
*"Anise, badian, fennel, coriander"
*"Apples"
"Applejuice Single Streng"
"Applejuice Concentrated"
*"Apricots"
*"Apricots, dry"
"Arabic Gum"
"Areca Nuts (Betel)"
*"Artichokes"
*"Asparagus"
*"Asses"
*"Avocados"
*"Bacon and ham"
"Bagasse"
*"Bambara Beans"
*"Bananas"
*"Barley"
"Barley Flour And Grits"
*"Barley, Pearled"
*"Beans, Dry"
*"Beans, Green"
*"Meat, cattle"
*"Meat, cattle, boneless (beef & veal)"
"Beef Canned"
"Beef Dried Salt Smoked"
*"Meat, beef, preparations"
*"Meat, beef and veal sausages"
*"Beehives"
*"Beer Of Barley"
"Beer Of Maize"
"Beer Of Millet"
*"Beer Of Sorghum"
*"Beeswax"
*"Beet Pulp"
"Beet Sugar"
"Beet Tops"
*"Beets For Fodder"
"Berries Nes"
*"Beverages, distilled alcoholic"
*"Beverages, non alcoholic"
"Biological Ass Meat"
"Biological Buffalo Meat"
"Biological Camel Meat"
"Biological Cattle Meat"
"Biological Chicken Meat"
"Biological Duck Meat"
"Biological Geese Meat"
"Biological Goat Meat"
"Biological Horse Meat"
"Biological Mule Meat"
"Biological Other Camel"
"Biological Other Poultry"
"Biological Pig Meat"
"Biological Rodents"
"Biological Sheep Meat"
"Biological Turkey Meat"
"Blood Meal"
*"Blueberries"
"Bran, Barley"
*"Bran, Buckwheat"
"Bran, Cereals"
*"Bran, Fonio"
*"Bran, Maize"
*"Bran, Millet"
"Bran, Mixed Grain"
"Bran, Oats"
"Bran, Pulses"
"Bran, Rice"
"Bran, Rye"
*"Bran, Sorghum"
"Bran, Triticale"
*"Bran, Wheat"
"Brazil Nuts"
*"Brazil nuts, Shelled"
*"Bread"
"Breakfast Cereals"
*"Broad beans, horse beans, dry"
"Broad Beans, Green"
*"Buckwheat"
"Buffalo Meat"
"Buffalo Milk"
*"Bulgur"
"Butter Of Buffalo Milk"
*"Butter, Cow Milk"
"Butter Of Goat Milk"
*"Butter Of Karite Nuts"
"Butter+Ghee (Sheep Milk)"
*"Buttermilk, curdled, acidified milk"
"Dry Buttermilk"
*"Cabbages and other brassicas"
*"Cake, copra"
*"Cake, Cottonseed"
*"Cake, Groundnuts"
*"Cake, Hempseed"
*"Cake, Kapok"
*"Cake, Linseed"
*"Cake, Maize"
*"Cake, Mustard"
"Cake, Palm Kernels"
"Cake Of Poppy Seed"
*"Cake, Rapeseed"
*"Cake, Rice Bran"
*"Cake, Safflower"
*"Cake, Sesame Seed"
*"Cake, Soybeans"
*"Cake, Sunflower"
"Cakes, Oilseeds Nes"
"Camel Hides, Fresh"
"Camel Milk"
*"Camels"
*"Canary Seed"
"Cane Sugar"
*"Cane Tops"
"Carobs"
*"Carrots and turnips"
"Casein"
*"Cashew Nuts, with shell"
*"Cashew Nuts, Shelled"
*"Cashewapple"
*"Cassava"
*"Cassava Dried"
"Cassava Leaves"
*"Starch, cassava"
"Cassava Tapioca"
"Castor Beans"
*"Cattle"
"Cattle Butcher Fat"
*"Hides, cattle, fresh"
*"Cauliflowers and broccoli"
"Cereals Nes"
*"Cereal preparations, nes"
"Cereals, most"
"Cheese Of Buffalo Milk"
"Cheese Of Goat Milk"
*"Cheese, Sheep Milk"
"Cheese (Skim Cow Milk)"
*"Cheese, Whole Cow Milk"
*"Cherries"
*"Chestnut"
*"Meat, chicken"
*"Meat, chicken, canned"
*"Chickens"
*"Chick Peas"
"Chicory Roots"
*"Chillies and peppers, green"
*"Chocolate Products Nes"
*"Cigarettes"
*"Cigars, Cheroots"
*"Cinnamon (Canella)"
"Citrus Fruit Nes"
*"Juice, citrus, single strength"
*"Juice, citrus, concentrated"
"Citrus, all"
*"Forage and silage, clover"
*"Cloves"
*"Hair, goat, coarse"
*"Cocoa, Beans"
*"Cocoa, Butter"
"Cocoa Husks+Shell"
*"Cocoa, Paste"
*"Cocoa, powder & cake"
*"Coconuts"
*"Coconuts, Desiccated"
*"Silk-worm cocoons, reelable"
*"Cocoons, unreelable & waste"
*"Coffee, Extracts"
*"Coffee, Green"
*"Coffee, Husks And Skins"
*"Coffee, Roasted"
*"Coffee, substitutes containing coffee"
"Coir"
"Compound Feed, Cattle"
"Compound Feed, Pigs"
"Compound Feed, Poultry"
*"Feed, compound, nes"
*"Copra"
*"Cotton, carded, combed"
*"Cotton Lint"
*"Cotton Linter"
*"Cotton Waste"
*"Cottonseed"
*"Milk, whole fresh cow"
"Cow Peas, Dry"
*"Cranberries"
*"Cream fresh"
*"Crude materials"
*"Cucumbers And Gherkins"
*"Currants"
*"Dates"
"Degras"
*"Dregs from brewing, distillation"
*"Meat, duck"
*"Ducks"
*"Eggplants (aubergines)"
*"Eggs, dried"
*"Eggs, other bird, in shell"
*"Eggs, Liquid"
"Empty fruit shells"
*"Oil, essential nes"
*"Tea, mate extracts"
*"Fat, liver prepared (foie gras)"
"Fat, Buffalo"
*"Fat, Camels"
*"Fat, Cattle"
"Fat, Goats"
"Fat, Other Camelids"
*"Fat, Pigs"
"Fat, Poultry"
"Fat, Poultry Rendered"
"Fat Of Sheep"
*"Fat, nes, prepared"
*"Fatty Acids"
"Feed Additives"
*"Feed Minerals"
*"Feed Supplements"
*"Cider etc"
"Fibre Crops Nes"
*"Figs"
*"Figs dried"
"Fine Goat Hair"
*"Fish Meal"
*"Flax Fibre And Tow"
*"Flax Fibre Raw"
*"Flax Tow Waste"
"Flour, Buckwheat"
"Flour, Cassava"
*"Flour, Cereals"
*"Flour, Fonio"
"Flour, Fruit"
*"Flour, Maize"
"Flour, Millet"
*"Flour, Mixed Grain"
*"Flour, Mustard"
*"Flour, Potatoes"
*"Flour, Pulses"
*"Flour, roots and tubers nes"
"Flour, Rye"
"Flour, Sorghum"
"Flour, Triticale"
*"Flour, Wheat"
"Flour/Meal Of Oilseeds"
*"Fonio"
*"Food prep nes"
*"Food preparations, flour, malt extract"
*"Food Wastes"
"Food Wastes Prep Feed"
*"Forage Products"
*"Fruit, cooked, homogenized preparations"
*"Fruit, Dried Nes"
*"Fruit, Fresh Nes"
*"Juice, fruit nes"
*"Fruit, Prepared Nes"
*"Feed, pulp of fruit"
*"Fruit, tropical fresh nes"
"Fruit Tropical Dried Nes"
"Fruit,Nut,Peel,Sugar Prs"
"Fruits, all"
"Fruits, most"
"Fur skin animal"
"Fur Skins"
"Game"
*"Meat, game"
*"Garlic"
"Geese"
*we added the following as in the WOSY data, it is "Geese and guinea fowls" and not "Geese" only"
"Geese and guinea fowls"
*"Germ, Maize"
"Germ, Wheat"
*"Ghee, of buffalo milk"
"Ghee, of cow milk"
*"Ginger"
*"Glucose And Dextrose"
*"Feed and meal, gluten"
*"Meat, goat"
"Goat Milk"
*"Goats"
*"Skins, goat, fresh"
*"Meat, goose and guinea fowl"
*"Gooseberries"
*"Juice, grape"
*"Grapefruit (inc. pomelos)"
*"Juice, grapefruit"
*"Juice, grapefruit, concentrated"
*"Grapes"
*"Forage and silage, grasses nes"
*"Grease incl. lanolin wool"
*"Maize, green"
"Groundnuts In Shell"
"Prepared Groundnuts"
*"Groundnuts, Shelled"
"Hair Carded Or Combed"
"Hair Coarse Nes"
*"Hair, Fine"
"Hair Of Horses"
*"Hay (clover, lucerne,etc)"
*"Hay (Unspecified)"
"Hay Non-Leguminous"
"Hazelnuts (Filberts)"
*"Hazelnuts, Shelled"
"Hemp Fibre And Tow"
"Hempseed"
*"Eggs, hen, in shell"
"Hide Dry-Salted"
*"Hides, nes"
"Hide Wet-Salted"
*"Hides, buffalo, dry salted"
"Hides, camel, dry salted"
"Hides, cattle, dry salted"
*"Hides, horse, dry salted"
"Hides Nes Cattle"
"Hides Of Asses Fresh"
"Hides Of Mules Fresh"
*"Hides, camel, nes"
"Hides Unspecified Horses"
*"Hides, buffalo, wet salted"
*"Hides, camel, wet salted"
*"Hides, cattle, wet salted"
"Hides, horse, wet salted"
*"Hides and skins nes, fresh"
"Homogenized Meat Prep."
*"Vegetables, homogenized preparations"
*"Honey, natural"
*"Hops"
"Horse Hides, Fresh"
*"Meat, horse"
*"Horses"
*"Ice Cream And Edible Ice"
"Indigenous Ass Meat"
"Indigenous Buffalo Meat"
"Indigenous Camel Meat"
"Indigenous Cattle Meat"
"Indigenous Chicken Meat"
"Indigenous Duck Meat"
"Indigenous Geese Meat"
"Indigenous Goat Meat"
"Indigenous Horse Meat"
"Indigenous Mule Meat"
"Indigenous Other Camel"
"Indigenous Other Poultry"
"Indigenous Pigmeat"
"Indigenous Rodents"
"Indigenous Sheep Meat"
"Indigenous Turkey Meat"
*"Infant Food"
"Isoglucose"
"Jojoba Oil"
*"Jute"
*"Jute-Like Fibres"
*"Kapok Fibre"
"Kapok Fruit"
*"Kapokseed In Shell"
*"Kapokseed Shelled"
"Karakul Skins"
"Karite Nuts (Sheanuts)"
*"Kiwi Fruit"
*"Kola nuts"
*"Lactose"
*"Lard"
"Lard And Stearine Oil"
"Leather Used And Waste"
"Leaves And Tops, Vines"
*"Leeks, other alliaceous vegetables"
*"Forage and silage, legumes"
"Lemonjuice Single-Streng"
*"Juice, lemon, concentrated"
*"Lemons And Limes"
*"Lentils"
*"Lettuce and chicory"
*"Linseed"
*"Margarine, liquid"
*"Animals, live, non-food"
"Live Animals Nes"
"Liver Preparationsa"
"Lupins"
*"Macaroni"
*"Maize"
*"Maize For Forage+Silage"
"Maize Gluten"
"Malt Extracts"
*"Malt"
"Mango Juice"
"Mango Pulp"
*"Mangoes, mangosteens, guavas"
*"Maple Sugar And Syrups"
"Marc Of Grapes"
*"Margarine, Short"
"Mate"
"Meat Extracts"
*"Meal, meat"
*"Meat, nes"
*"Meat, dried nes"
"Meat, Asses"
"Meat, Camels"
"Meat, Mules"
"Meat, Other Camelids"
"Meat, Other Rodents"
"Meat, Pigeon Oth.Birds"
"Meat Prepared Nes"
*"Melons, other (inc.cantaloupes)"
"Melonseed"
"Milled Paddy Rice"
*"Millet"
*"Grain, mixed"
*"Mixes And Doughs"
*"Molasses"
*"Mules"
*"Mushrooms and truffles"
*"Mushrooms, Canned"
"Dried Mushrooms"
"Must Of Grapes"
*"Mustard Seed"
*"Meat, sheep"
"Natural Gums"
*"Rubber, natural"
*"Nutmeg, mace and cardamoms"
*"Nuts, Nes"
"Nuts, all"
"Nuts, all, shelled"
*"Oats"
*"Oats Rolled"
*"Offals, Liver Chicken"
*"Offals, Liver Duck"
*"Offals, Liver Geese"
"Offals Liver Turkeys"
"Offals Nes"
"Offals, edible, Buffalo"
"Offals, edible, Camel"
*"Offals, edible, cattle"
*"Offals, edible, goats"
"Offals, Horse"
*"Offals, other camelids"
*"Offals, pigs, edible"
*"Offals, sheep,edible"
*"Oil, Castor Beans"
*"Oil, Citronella"
*"Oil, Coconut (copra)"
*"Oil, Cottonseed"
*"Oil, Groundnut"


"Oil, Hempseed"
*"Oil, Kapok"
*"Oil, Linseed"
*"Oil, Maize"
"Oil, Mustard Seed"
*"Oil, Olive Residues"
*"Oil, Palm Kernel"
*"Oil, Poppy"
*"Oil, Rapeseed"
*"Oil, Rice Bran"
*"Oil, Safflower"
*"Oil, Sesame"
*"Oil, Soybean"
*"Oil, Sunflower"
*"Oil, vegetable origin nes"
"Oil Palm Fruit"
*"Oil, boiled etc"
"Oils Fish And Marine Mam"
"Oils Hydrogenated"
*"Oilseeds Nes"
"Okra"
*"Oil, olive, virgin"
"Olive Residues"
*"Olives"
*"Olives Preserved"
*"Onions, Dry"
*"Onions, shallots, green"
*"Juice, orange, single strength"
*"Juice, orange, concentrated"
*"Oranges"
"Other birds for eggs"
*we added the following as in the WOSY data, it is available"
"Eggs Excl Hen"
*we added the following as in the WOSY data, it is available"
"Other Rodents"
*"Camelids, other"
"Other Concentrates, Nes"
*"Fructose and syrup, other"
*"Palm Kernels"
*"Oil, palm"
*"Papayas"
*"Pastry"
*"Peaches And Nectarines"
*"Peanut Butter"
*"Pears"
*"Peas, Dry"
*"Peas, Green"
*"Pepper (piper spp.)"
*"Peppermint"
*"Persimmons"
*"Pet Food"
"Pig Butcher Fat"
*"Meat, pig, preparations"
*"Meat, pig sausages"
"Pigeon Peas"
*"Pigeons Other Birds" - this was the original in this set - but in the WOSY data it has a comma, so we added this"
"Pigeons, Other Birds"
*"Meat, pig"
*"Pigs"
"Pigskins, Fresh"
*"Chillies and peppers, dry"
*"Pineapples"
*"Pineapples Canned"
*"Juice, pineapple"
*"Juice, pineapple, concentrated"
*"Pistachios"
*"Plantains and others"
*"Juice, plum, single strength"
*"Juice, plum, concentrated"
*"Plums and sloes"
"Plums, Dried (Prunes)"
"Pome Fruit Nes, Fresh"
*"Popcorn"
*"Poppy Seed"
*"Meat, pork"
"Pot Barley"
*"Potato Offals"
"Potato Starch"
"Potato Tapioca"
*"Potatoes"
*"Potatoes, frozen"
*"Nuts, prepared (exc. groundnuts)"
*"Cheese, processed"
*"Milk, products of natural constituents nes"
"Pulses Nes"
"Pulses, all"
*"Pumpkins, squash and gourds"
*"Pyrethrum, extraction"
"Pyrethrum Marc"
*"Pyrethrum, Dried"
*"Quinces"
"Quinoa"
*"Meat, rabbit"
"Rabbit Meat Biological"
"Rabbit Meat Indigenous"
"Rabbit Skins"
*"Rabbits and hares"
*"Raisins"
"Ramie"
*"Rapeseed"
"Raspberries"
*"Milk, reconstituted"
*"Fatty substance residues"
"Rice, Broken"
*"Beverages, fermented rice"
"Rice Flour"
"Rice Gluten"
"Rice, Husked"
"Milled/Husked Rice"
"Rice, Paddy"
"Rice, Starch"
"Roots and Tubers, most"
"Roots And Tubers Dried"
*"Roots And Tubers, Nes"
*"Rubber Natural Dry"
*"Rye"
"Safflower Seed"
"Seed Cotton"
*"Sesame Seed"
*"Sheep"
*"Milk, whole fresh sheep"
*"Skins, sheep, fresh"
*"Silk Raw"
"Silkworms"
*"Sisal"
"Skim Milk, Condensed"
*"Milk, skimmed dried"
"Skim Milk, Evaporated"
"Skim Milk Of Buffalo"
*"Milk, skimmed cow"
"Skim Milk Of Goat"
"Skim Sheep Milk"
"Skins, pig, dry salted"
*"Skins, sheep, dry salted"
"Skin Nes Pigs"
"Skin Nes Sheep"
"Skins, pig, wet salted"
*"Skins, sheep, wet salted"
*"Skins, sheep, with wool"
"Skins Dry-Salt Calves"
"Skins Dry-Salted Goats"
"Skins Fresh Of Calves"
"Skins Nes Calves"
"Skins Nes Goats"
*"Skins, calve, wet salted"
*"Skins, goat, wet salted"
"Snails Not Sea Snails"
*"Sorghum"
*"Cherries, sour"
*"Soya Curd"
*"Soya Paste"
*"Soya Sauce"
*"Soybeans"
"Spermaceti"
*"Spices, nes"
*"Spinach"
"Standardized Milk"
"Starch and Sugar crops for Alc"
"Starch Of Maize"
"Stillingia Oil"
"Stone Fruit Nes, Fresh"
*"Straw Husks"
*"Strawberries"
"String Beans"
*"Sugar, Nes"
*"Sugar Beet"
*"Sugar Cane"
*"Sugar Confectionery"
*"Sugar Crops, Nes"
*"Sugar Refined"
*"Sugar raw centrifugal"
*"Sugar non-centrifugal"
*"Sugar Flavoured"
*"Sunflower Seed"
*"Swedes For Fodder"
*"Sweet Corn Frozen"
*"Sweet corn prep or preserved"
*"Sweet Potatoes"
*"Tallow"
"Tallowtree Seeds"
"Tangerine Juice"
*"Tangerines, mandarins, clementines, satsumas"
"Taro (Coco Yam)"
*"Tea"
"Tea Nes"
*"Tobacco, unmanufactured"
*"Tobacco Products Nes"
*"Juice, tomato"
"Tomatojuice Concentrated"
*"Tomatoes, Paste"
*"Tomatoes"
*"Tomatoes, peeled"
*"Triticale"
"Tung Oil"
"Tung Nuts"
*"Meat, turkey"
*"Turkeys"
*"Turnips For Fodder"
*"Vanilla"
*"Vegetables, fresh or dried products nes"
*"Feed, vegetable products nes"
*"Vegetable Tallow"
*"Vegetables, Dehydrated"
*"Vegetables, Frozen"
*"Vegetables, canned nes"
*"Vegetables, Dried Nes"
*"Vegetables, Fresh Nes"
"Juice Of Vegetables Nes"
*"Vegetables in vinegar"
*"Vegetables, preserved nes"
*"Vegetables, preserved, frozen"
*"Vegetables, temporarily preserved"
"Vegetables, most"
*"Vegetables+Roots,Fodder"
*"Vermouths & similar"
*"Vetches"
*"Vitamins"
*"Wafers"
*"Walnuts, with shell"
*"Walnuts, shelled"
*"Watermelons"
*"Waters,Ice Etc"
*"Waxes vegetable"
*"Wheat"
"Wheat Fermented Beverage"
"Wheat Gluten"
"Wheat Starch"
"Whey Cheese"
*"Whey, Condensed"
*"Whey, dry"
"Whey, Fresh"
*"Milk, whole condensed"
*"Milk, whole dried"
*"Milk, whole evaporated"
*"Wine"
*"Wool, Hair Waste"
"Wool Shoddy"
*"Wool, Greasy"
*"Wool, degreased"
*"Yams"
"Yautia (Cocoyam)"
"Yoghurt"
*"Yoghurt, concentrated or not"
*till here it equals ReducedSetElements_FAOSTAT_WOSYItems

*added for matching with livestock activities, as they are missing in the commodities as above:
"Meat, birds nes"
"Meat, buffaloes"
"Milk, whole fresh buffalo"
"Milk, whole fresh camel"
"Milk, whole fresh goat"

*added for matching with crop activities, as they are missing in the commodities as above:
"Almonds, with shell"
"Areca nuts"
"Bastfibres, other"
"Brazil nuts, with shell"
"Castor oil seed"
"Cereals (Rice Milled Eqv)"
"Cereals, nes"
"Fibre Crops Primary"
"Fruit, citrus nes"
"Fruit, pome nes"
"Fruit, stone nes"
"Groundnuts, with shell"
"Gums, natural"
"Hazelnuts, with shell"
"Hemp tow waste"
"Jojoba seed"
"Jute & Jute-like Fibres"
"Oil, palm fruit"
"Pulses, nes"
"Tallowtree seed"
"Taro (cocoyam)"
"Vegetables, leguminous nes"

*the following are additional commodities (main and co-products) not included in FAOSTAT, needed for capturing the commodity trees, added by A. Muller on 7.8.2019
*level1 and 2 refer to the levels in the commodity trees, cf. _V6_ReadData_CommodityTrees_LinkActivitiesAndCommodities
*new co-prod: Level1
"Rice hulls"
"Groundnut shells"
"Beer of Shorgum dregs"
"Cocoa husks"
"Karite nut cake"
"Almond shells"
"Apricot kernel"
"Chestnut shells"
"Coconut shells"
"Cashew nut shells"
"Brazil nut shells"
"Tomato pulp"
"Grape pulp"
"Grapefruit pulp"
"Lemon pulp"
"Orange pulp"
"Pineapple pulp"
"Plum pulp"
"Hazelnut shells"
"Castor bean cake"
*"Palm kernels"
"Walnut shells"
"Apple pulp"
"Jojoba cake"
"Tangerine pulp"
"Tung nut cake"
"Molasse from cane"
"Molasse from beet"
*New main prod:level 1
"Oat flour"
"Cocoa paste"
*new co-prod Level2
"Beer of Barley dregs"
"Kapokseed shells"
"Pressed olive residues"
*new main prod Level2
"Palm kernel oil"
"Wheat dregs"
"Oil palm fruit pulp"

*the following is added for BioeSR15
Miscanthus

Spelt
/;

Set Commodities_FeedGroups(Commodities) "Subset containing the aggregate feed groups (such as grass, concentrate, forage,…)"
/
AggregateFeedTotal_Commodity
AggregateFeedConcentrates_Commodity
AggregateFeedForageCrops_Commodity
AggregateFeedGrass_Commodity
AggregateFeedResidues_Commodity
AggregateFeedConcMainProd_Commodity
AggregateFeedConcByProd_Commodity
/;

Set Commodities_FeedGroups_DetailedFeedingRations(Commodities) "Subset containing the aggregate feed groups (such as grass, concentrate, forage,…) as used for the DETAILED feeding rations calculations"
/
AggregateFeedTotal_Commodity
AggregateFeedGrass_Commodity
AggregateFeedNoForageNoGrass_Commodity
AggregateFeedForageCrops_Commodity
AggregateFeedCereals_Commodity
AggregateFeedOilCropsAndCakes_Commodity
AggregateFeedPulses_Commodity
AggregateFeedRoots_Commodity
AggregateFeedSugar_Commodity
AggregateFeedOtherPlant_Commodity
AggregateFeedOtherAnimal_Commodity
AggregateFeedResidues_Commodity
/;

Set Commodities_FeedGroups_DetailedFeedingRations_NoTot(Commodities) "Subset containing the aggregate feed groups (such as grass, concentrate, forage,…) as used for the DETAILED feeding rations calculations - without groups referring to totals over different feed groups"
/
AggregateFeedGrass_Commodity
AggregateFeedForageCrops_Commodity
AggregateFeedCereals_Commodity
AggregateFeedOilCropsAndCakes_Commodity
AggregateFeedPulses_Commodity
AggregateFeedRoots_Commodity
AggregateFeedSugar_Commodity
AggregateFeedOtherPlant_Commodity
AggregateFeedOtherAnimal_Commodity
AggregateFeedResidues_Commodity
/;

Set Commodities_Feed(Commodities) "Set of the commodities that are used as feed"
/
Bananas
Cloves
"Cotton lint"
Cottonseed
Dates
Jute
Oats
"Palm kernels"
"Sesame seed"
Sisal
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Sweet potatoes"
Yams
Molasses
Wine
*Infant food
Plantains
"Sugar non-centrifugal"
"Turnips for fodder"
*Animal fats
Beer
"Bovine Meat"
Onions
Pigmeat
"Poultry Meat"
*Pulses
Silk
Tobacco
Abaca
"Alcohol, Non-Food"
*Alcoholic Beverages
"Apples and products"
"Barley and products"
Beans
"Beverages, Alcoholic"
"Beverages, Fermented"
*Brans
"Cassava and products"
*Cereals - Excluding Beer
"Cereals, Other"
"Citrus, Other"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Coffee and products"
"Copra Cake"
"Cottonseed Cake"
"Cottonseed Oil"
*Fruits - Excluding Wine
"Fruits, Other"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Groundnut Cake"
"Groundnut Oil"
"Groundnuts (in Shell Eq)"
*Groundnuts (Shelled Eq)
"Hard Fibres, Other"
"Jute-Like Fibres"
"Lemons, Limes and products"
"Maize and products"
"Maize Germ Oil"
"Millet and products"
*Miscellaneous
"Nuts and products"
*Oilcrops
"Oilcrops Oil, Other"
"Oilcrops, Other"
"Oilseed Cakes, Other"
"Olive Oil"
"Olives (including preserved)"
"Oranges, Mandarines"
"Palm Oil"
"Palmkernel Cake"
"Palmkernel Oil"
Peas
Pepper
Pimento
"Pineapples and products"
"Potatoes and products"
"Pulses, Other and products"
"Rape and Mustard Cake"
"Rape and Mustard Oil"
"Rape and Mustardseed"
*Rice (Milled Equivalent)
"Rice (Paddy Equivalent)"
"Ricebran Oil"
*Roots & Tuber Dry Equiv
"Roots, Other"
Rubber
"Rye and products"
"Sesameseed Cake"
"Sesameseed Oil"
"Soft-Fibres, Other"
"Sorghum and products"
"Soyabean Cake"
"Soyabean Oil"
Soyabeans
Spices
"Spices, Other"
*Starchy Roots
*Stimulants
*Sugar & Sweeteners
"Sugar (Raw Equivalent)"
*Sugar Crops
*Sugar, Raw Equivalent
*Sugar, Refined Equiv
"Sunflowerseed Cake"
"Sunflowerseed Oil"
"Sweeteners, Other"
"Tea (including mate)"
"Tomatoes and products"
*Treenuts
*Vegetable Oils
*Vegetables
"Vegetables, Other"
"Wheat and products"
"Aquatic Animals, Others"
"Aquatic Plants"
*Aquatic Products, Other
"Butter, Ghee"
Cephalopods
Cheese
Cream
Crustaceans
"Demersal Fish"
Eggs
"Fats, Animals, Raw"
"Fish Meal"
"Fish, Body Oil"
"Fish, Liver Oil"
*Fish, Seafood
"Freshwater Fish"
*Hides and skins
Honey
"Marine Fish, Other"
*Meat
"Meat Meal"
"Meat, Other"
*Milk - Excluding Butter
"Milk, Skimmed"
"Milk, Whole"
"Molluscs, Other"
"Mutton & Goat Meat"
Offals
*Offals, Edible
"Pelagic Fish"
Whey
"Wool (Clean Eq.)"
"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Beets For Fodder"
"Swedes For Fodder"
"Temporary meadows and pastures"
"Permanent meadows and pastures"
"Cabbage, for forage"
"Other grasses, for forage"
"Rye grass, for forage"
"Sorghum, for forage"
Miscanthus
*till here: this set is identical to the following: Set CommoditiesDAQ_TradeFromToWorld(Commodities)
"Straw husks"
/
;

Set Commodities_Feed_NoForageNoGrass(Commodities) "Set of the commodities that are used as feed WITHOUT forage and grass"
/
Bananas
Cloves
"Cotton lint"
Cottonseed
Dates
Jute
Oats
"Palm kernels"
"Sesame seed"
Sisal
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Sweet potatoes"
Yams
Molasses
Wine
*Infant food
Plantains
"Sugar non-centrifugal"
"Turnips for fodder"
*Animal fats
Beer
"Bovine Meat"
Onions
Pigmeat
"Poultry Meat"
*Pulses
Silk
Tobacco
Abaca
"Alcohol, Non-Food"
*Alcoholic Beverages
"Apples and products"
"Barley and products"
Beans
"Beverages, Alcoholic"
"Beverages, Fermented"
*Brans
"Cassava and products"
*Cereals - Excluding Beer
"Cereals, Other"
"Citrus, Other"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Coffee and products"
"Copra Cake"
"Cottonseed Cake"
"Cottonseed Oil"
*Fruits - Excluding Wine
"Fruits, Other"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Groundnut Cake"
"Groundnut Oil"
"Groundnuts (in Shell Eq)"
*Groundnuts (Shelled Eq)
"Hard Fibres, Other"
"Jute-Like Fibres"
"Lemons, Limes and products"
"Maize and products"
"Maize Germ Oil"
"Millet and products"
*Miscellaneous
"Nuts and products"
*Oilcrops
"Oilcrops Oil, Other"
"Oilcrops, Other"
"Oilseed Cakes, Other"
"Olive Oil"
"Olives (including preserved)"
"Oranges, Mandarines"
"Palm Oil"
"Palmkernel Cake"
"Palmkernel Oil"
Peas
Pepper
Pimento
"Pineapples and products"
"Potatoes and products"
"Pulses, Other and products"
"Rape and Mustard Cake"
"Rape and Mustard Oil"
"Rape and Mustardseed"
*Rice (Milled Equivalent)
"Rice (Paddy Equivalent)"
"Ricebran Oil"
*Roots & Tuber Dry Equiv
"Roots, Other"
Rubber
"Rye and products"
"Sesameseed Cake"
"Sesameseed Oil"
"Soft-Fibres, Other"
"Sorghum and products"
"Soyabean Cake"
"Soyabean Oil"
Soyabeans
Spices
"Spices, Other"
*Starchy Roots
*Stimulants
*Sugar & Sweeteners
"Sugar (Raw Equivalent)"
*Sugar Crops
*Sugar, Raw Equivalent
*Sugar, Refined Equiv
"Sunflowerseed Cake"
"Sunflowerseed Oil"
"Sweeteners, Other"
"Tea (including mate)"
"Tomatoes and products"
*Treenuts
*Vegetable Oils
*Vegetables
"Vegetables, Other"
"Wheat and products"
"Aquatic Animals, Others"
"Aquatic Plants"
*Aquatic Products, Other
"Butter, Ghee"
Cephalopods
Cheese
Cream
Crustaceans
"Demersal Fish"
Eggs
"Fats, Animals, Raw"
"Fish Meal"
"Fish, Body Oil"
"Fish, Liver Oil"
*Fish, Seafood
"Freshwater Fish"
*Hides and skins
Honey
"Marine Fish, Other"
*Meat
"Meat Meal"
"Meat, Other"
*Milk - Excluding Butter
"Milk, Skimmed"
"Milk, Whole"
"Molluscs, Other"
"Mutton & Goat Meat"
Offals
*Offals, Edible
"Pelagic Fish"
Whey
"Wool (Clean Eq.)"
"Beets For Fodder"
"Swedes For Fodder"
Miscanthus
/;

Set Commodities_Feed_Grass(Commodities) "Set of the GRASS commodities that are used as feed"
/
"Temporary meadows and pastures"
"Permanent meadows and pastures"
/;

Set Commodities_Feed_ForageCrops(Commodities) "Set of the FORAGE CROP commodities that are used as feed"
/
"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Cabbage, for forage"
"Other grasses, for forage"
"Rye grass, for forage"
"Sorghum, for forage"
/;

Set Commodities_Feed_Cereals(Commodities) "Set of the CEREAL commodities that are used as feed"
/
Oats
"Barley and products"
"Cereals, Other"
"Maize and products"
"Millet and products"
"Rice (Paddy Equivalent)"
"Rye and products"
"Sorghum and products"
"Wheat and products"
/;

Set Commodities_Feed_OilCropsAndCakes(Commodities) "Set of the OIL CROP commodities that are used as feed"
/
Cottonseed
"Palm kernels"
"Sesame seed"
"Sunflower seed"
"Coconuts - Incl Copra"
"Copra Cake"
"Cottonseed Cake"
"Groundnut Cake"
"Groundnuts (in Shell Eq)"
"Oilcrops, Other"
"Oilseed Cakes, Other"
"Palmkernel Cake"
"Rape and Mustard Cake"
"Rape and Mustardseed"
"Sesameseed Cake"
"Soyabean Cake"
Soyabeans
"Sunflowerseed Cake"
/;

Set Commodities_Feed_Pulses(Commodities) "Set of the PULSES commodities that are used as feed"
/
Beans
Peas
"Pulses, Other and products"
/;

Set Commodities_Feed_Roots(Commodities) "Set of the ROOT commodities that are used as feed"
/
"Sweet potatoes"
Yams
"Turnips for fodder"
"Cassava and products"
"Potatoes and products"
"Roots, Other"
"Beets For Fodder"
"Swedes For Fodder"
/;

Set Commodities_Feed_Sugar(Commodities) "Set of the SUGAR commodities that are used as feed"
/
"Sugar beet"
"Sugar cane"
Molasses
"Sugar non-centrifugal"
"Sugar (Raw Equivalent)"
"Sweeteners, Other"
/;

Set Commodities_Feed_OthersPlants(Commodities) "Set of the OTHER PLANT commodities that are used as feed"
/
Bananas
Cloves
"Cotton lint"
Dates
Jute
Sisal
Wine
*Infant food
Plantains
*Animal fats
Beer
Onions
*Pulses
Tobacco
Abaca
"Alcohol, Non-Food"
*Alcoholic Beverages
"Apples and products"
"Beverages, Alcoholic"
"Beverages, Fermented"
*Brans
*Cereals - Excluding Beer
"Citrus, Other"
"Cocoa Beans and products"
"Coconut Oil"
"Coffee and products"
"Cottonseed Oil"
*Fruits - Excluding Wine
"Fruits, Other"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Groundnut Oil"
*Groundnuts (Shelled Eq)
"Hard Fibres, Other"
"Jute-Like Fibres"
"Lemons, Limes and products"
"Maize Germ Oil"
*Miscellaneous
"Nuts and products"
*Oilcrops
"Oilcrops Oil, Other"
"Olive Oil"
"Olives (including preserved)"
"Oranges, Mandarines"
"Palm Oil"
"Palmkernel Oil"
Pepper
Pimento
"Pineapples and products"
"Rape and Mustard Oil"
*Rice (Milled Equivalent)
"Ricebran Oil"
*Roots & Tuber Dry Equiv
Rubber
"Sesameseed Oil"
"Soft-Fibres, Other"
"Soyabean Oil"
Spices
"Spices, Other"
*Starchy Roots
*Stimulants
*Sugar & Sweeteners
*Sugar Crops
*Sugar, Raw Equivalent
*Sugar, Refined Equiv
"Sunflowerseed Oil"
"Tea (including mate)"
"Tomatoes and products"
*Treenuts
*Vegetable Oils
*Vegetables
"Vegetables, Other"
"Aquatic Plants"
Miscanthus
/;

Set Commodities_Feed_OthersAnimals(Commodities) "Set of the OTHER ANIMAL commodities that are used as feed"
/
"Bovine Meat"
Pigmeat
"Poultry Meat"
Silk
"Aquatic Animals, Others"
*Aquatic Products, Other
"Butter, Ghee"
Cephalopods
Cheese
Cream
Crustaceans
"Demersal Fish"
Eggs
"Fats, Animals, Raw"
"Fish Meal"
"Fish, Body Oil"
"Fish, Liver Oil"
*Fish, Seafood
"Freshwater Fish"
*Hides and skins
Honey
"Marine Fish, Other"
*Meat
"Meat Meal"
"Meat, Other"
*Milk - Excluding Butter
"Milk, Skimmed"
"Milk, Whole"
"Molluscs, Other"
"Mutton & Goat Meat"
Offals
*Offals, Edible
"Pelagic Fish"
Whey
"Wool (Clean Eq.)"
/;

Set Commodities_Feed_Residues(Commodities) "Set of the RESIDUE commodities that are used as feed"
/
"Straw husks"
/;

Set CommoditiesDAQ_TradeFromToWorld(Commodities) "Commodity set used for the basic trade calculations as it includes indentical elements for all the DAQ categories and export/import - however ex and imp are to and from WORLD only"
/
Bananas
Cloves
"Cotton lint"
Cottonseed
Dates
Jute
Oats
"Palm kernels"
"Sesame seed"
Sisal
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Sweet potatoes"
Yams
Molasses
Wine
*Infant food
Plantains
"Sugar non-centrifugal"
"Turnips for fodder"
*Animal fats
Beer
"Bovine Meat"
Onions
Pigmeat
"Poultry Meat"
*Pulses
Silk
Tobacco
Abaca
"Alcohol, Non-Food"
*Alcoholic Beverages
"Apples and products"
"Barley and products"
Beans
"Beverages, Alcoholic"
"Beverages, Fermented"
*Brans
"Cassava and products"
*Cereals - Excluding Beer
"Cereals, Other"
"Citrus, Other"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Coffee and products"
"Copra Cake"
"Cottonseed Cake"
"Cottonseed Oil"
*Fruits - Excluding Wine
"Fruits, Other"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Groundnut Cake"
"Groundnut Oil"
"Groundnuts (in Shell Eq)"
*Groundnuts (Shelled Eq)
"Hard Fibres, Other"
"Jute-Like Fibres"
"Lemons, Limes and products"
"Maize and products"
"Maize Germ Oil"
"Millet and products"
*Miscellaneous
"Nuts and products"
*Oilcrops
"Oilcrops Oil, Other"
"Oilcrops, Other"
"Oilseed Cakes, Other"
"Olive Oil"
"Olives (including preserved)"
"Oranges, Mandarines"
"Palm Oil"
"Palmkernel Cake"
"Palmkernel Oil"
Peas
Pepper
Pimento
"Pineapples and products"
"Potatoes and products"
"Pulses, Other and products"
"Rape and Mustard Cake"
"Rape and Mustard Oil"
"Rape and Mustardseed"
*Rice (Milled Equivalent)
"Rice (Paddy Equivalent)"
"Ricebran Oil"
*Roots & Tuber Dry Equiv
"Roots, Other"
Rubber
"Rye and products"
"Sesameseed Cake"
"Sesameseed Oil"
"Soft-Fibres, Other"
"Sorghum and products"
"Soyabean Cake"
"Soyabean Oil"
Soyabeans
Spices
"Spices, Other"
*Starchy Roots
*Stimulants
*Sugar & Sweeteners
"Sugar (Raw Equivalent)"
*Sugar Crops
*Sugar, Raw Equivalent
*Sugar, Refined Equiv
"Sunflowerseed Cake"
"Sunflowerseed Oil"
"Sweeteners, Other"
"Tea (including mate)"
"Tomatoes and products"
*Treenuts
*Vegetable Oils
*Vegetables
"Vegetables, Other"
"Wheat and products"
"Aquatic Animals, Others"
"Aquatic Plants"
*Aquatic Products, Other
"Butter, Ghee"
Cephalopods
Cheese
Cream
Crustaceans
"Demersal Fish"
Eggs
"Fats, Animals, Raw"
"Fish Meal"
"Fish, Body Oil"
"Fish, Liver Oil"
*Fish, Seafood
"Freshwater Fish"
*Hides and skins
Honey
"Marine Fish, Other"
*Meat
"Meat Meal"
"Meat, Other"
*Milk - Excluding Butter
"Milk, Skimmed"
"Milk, Whole"
"Molluscs, Other"
"Mutton & Goat Meat"
Offals
*Offals, Edible
"Pelagic Fish"
Whey
"Wool (Clean Eq.)"
"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Beets For Fodder"
"Swedes For Fodder"
"Temporary meadows and pastures"
"Permanent meadows and pastures"
"Cabbage, for forage"
"Other grasses, for forage"
"Rye grass, for forage"
"Sorghum, for forage"
Miscanthus
/
;

*define various commodity groups from the set of these traded commodities:
set SET_Cereals_CommodityGroup(Commodities)
/
Beer
*Cereals - Excluding Beer
Oats
"Barley and products"
*Brans
"Cereals, Other"
*Rice (Milled Equivalent)
"Rice (Paddy Equivalent)"
"Ricebran Oil"
"Maize and products"
"Maize Germ Oil"
"Millet and products"
"Rye and products"
"Sorghum and products"
"Wheat and products"
/
;
set SET_FodderCrops_CommodityGroup(Commodities)
/
"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Beets For Fodder"
"Swedes For Fodder"
"Temporary meadows and pastures"
"Permanent meadows and pastures"
"Cabbage, for forage"
"Other grasses, for forage"
"Rye grass, for forage"
"Sorghum, for forage"
"Turnips for fodder"
/
;
set SET_Fruits_CommodityGroup(Commodities)
/
"Coconuts - Incl Copra"
"Copra Cake"
Bananas
Dates
Plantains
"Apples and products"
"Citrus, Other"
"Lemons, Limes and products"
"Pineapples and products"
"Oranges, Mandarines"
*Fruits - Excluding Wine
"Fruits, Other"
"Grapefruit and products"
"Grapes and products (excl wine)"
Wine
/
;
set SET_Nuts_CommodityGroup(Commodities)
/
*Treenuts
"Nuts and products"
/
;
set SET_Oilcrops_CommodityGroup(Commodities)
/
Cottonseed
"Palm kernels"
"Sesame seed"
"Sunflower seed"
"Coconut Oil"
"Cottonseed Cake"
"Cottonseed Oil"
"Rape and Mustard Cake"
"Rape and Mustard Oil"
"Rape and Mustardseed"
"Groundnut Cake"
"Groundnut Oil"
"Groundnuts (in Shell Eq)"
*Groundnuts (Shelled Eq)
*Oilcrops
"Oilcrops Oil, Other"
"Oilcrops, Other"
"Oilseed Cakes, Other"
"Olive Oil"
"Olives (including preserved)"
"Palm Oil"
"Palmkernel Cake"
"Palmkernel Oil"
"Sunflowerseed Cake"
"Sunflowerseed Oil"
"Sesameseed Cake"
"Sesameseed Oil"
"Soyabean Cake"
"Soyabean Oil"
Soyabeans
/
;
set SET_OtherCrops_CommodityGroup(Commodities)
/
"Cocoa Beans and products"
*Stimulants
"Tea (including mate)"
"Coffee and products"
Cloves
"Cotton lint"
Jute
Sisal
Tobacco
Abaca
"Hard Fibres, Other"
"Jute-Like Fibres"
*Miscellaneous
Rubber
Spices
"Spices, Other"
Miscanthus
"Soft-Fibres, Other"

/
;
set SET_Pulses_CommodityGroup(Commodities)
/
Beans
"Pulses, Other and products"
*Pulses
/
;
set SET_RootsAndTubers_CommodityGroup(Commodities)
/
*Roots & Tuber Dry Equiv
"Sweet potatoes"
Yams
"Cassava and products"
"Potatoes and products"
"Roots, Other"
*Starchy Roots
/
;
set SET_Sugarcrops_CommodityGroup(Commodities)
/
"Sugar beet"
"Sugar cane"
Molasses
"Sugar non-centrifugal"
*Sugar & Sweeteners
"Sugar (Raw Equivalent)"
*Sugar Crops
*Sugar, Raw Equivalent
*Sugar, Refined Equiv
"Sweeteners, Other"
/
;
set SET_Vegetables_CommodityGroup(Commodities)
/
Onions
Peas
Pepper
Pimento
"Tomatoes and products"
*Vegetable Oils
*Vegetables
"Vegetables, Other"
/
;
set SET_Milk_CommodityGroup(Commodities)
/
*Milk - Excluding Butter
"Milk, Skimmed"
"Milk, Whole"
Whey
Cheese
Cream
"Butter, Ghee"
/
;
set SET_Meat_CommodityGroup(Commodities)
/
"Bovine Meat"
Pigmeat
"Poultry Meat"
*Meat
"Meat Meal"
"Meat, Other"
"Mutton & Goat Meat"
Offals
*Offals, Edible
"Fats, Animals, Raw"
/
;
set SET_Eggs_CommodityGroup(Commodities)
/
Eggs
/
;
set SET_FishSeafood_CommodityGroup(Commodities)
/
"Molluscs, Other"
"Pelagic Fish"
"Aquatic Animals, Others"
"Aquatic Plants"
*Aquatic Products, Other
Cephalopods
Crustaceans
"Demersal Fish"
"Fish Meal"
"Fish, Body Oil"
"Fish, Liver Oil"
*Fish, Seafood
"Freshwater Fish"
"Marine Fish, Other"
/
;
$ontext;
Not assigned to commodity groups, currently:
*Hides and skins
*Honey
*Infant food
*Animal fats
Silk
"Alcohol, Non-Food"
*Alcoholic Beverages
"Beverages, Alcoholic"
"Beverages, Fermented"
"Wool (Clean Eq.)"
$offtext;

Set CommoditiesDAQ_TradeFromToWorldPrimary(Commodities) "Commodity set - only PRIMARY commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
/
Bananas
Cloves
"Cotton lint"
Cottonseed
Dates
Jute
Oats
"Palm kernels"
"Sesame seed"
Sisal
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Sweet potatoes"
Yams
Plantains
"Turnips for fodder"
"Bovine Meat"
Onions
Pigmeat
"Poultry Meat"
Silk
Tobacco
Abaca
Beans
"Cereals, Other"
"Citrus, Other"
"Coconuts - Incl Copra"
"Fruits, Other"
"Groundnuts (in Shell Eq)"
"Hard Fibres, Other"
"Jute-Like Fibres"
"Oilcrops, Other"
"Olives (including preserved)"
"Oranges, Mandarines"
"Palm Oil"
Peas
Pepper
Pimento
"Rape and Mustardseed"
"Rice (Paddy Equivalent)"
"Roots, Other"
Rubber
"Soft-Fibres, Other"
Soyabeans
Spices
"Spices, Other"
"Tea (including mate)"
"Vegetables, Other"

"Aquatic Animals, Others"
"Aquatic Plants"
Cephalopods
Crustaceans
"Demersal Fish"
Eggs
"Freshwater Fish"
Honey
"Marine Fish, Other"
"Meat, Other"
"Milk, Whole"
"Molluscs, Other"
"Mutton & Goat Meat"
Offals
"Fats, Animals, Raw"
"Pelagic Fish"
"Wool (Clean Eq.)"
"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Beets For Fodder"
"Swedes For Fodder"
"Temporary meadows and pastures"
"Permanent meadows and pastures"
"Cabbage, for forage"
"Other grasses, for forage"
"Rye grass, for forage"
"Sorghum, for forage"
Miscanthus
/
;

Set CommoditiesDAQ_TradeFromToWorldPrimaryCrops(Commodities) "Commodity set - only PRIMARY CROP commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
/
Bananas
Cloves
"Cotton lint"
Cottonseed
Dates
Jute
Oats
"Palm kernels"
"Sesame seed"
Sisal
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Sweet potatoes"
Yams
Plantains
"Turnips for fodder"
Onions
Tobacco
Abaca
Beans
"Cereals, Other"
"Citrus, Other"
"Coconuts - Incl Copra"
"Fruits, Other"
"Groundnuts (in Shell Eq)"
"Hard Fibres, Other"
"Jute-Like Fibres"
"Oilcrops, Other"
"Olives (including preserved)"
"Oranges, Mandarines"
"Palm Oil"
Peas
Pepper
Pimento
"Rape and Mustardseed"
"Rice (Paddy Equivalent)"
"Roots, Other"
Rubber
"Soft-Fibres, Other"
Soyabeans
Spices
"Spices, Other"
"Tea (including mate)"
"Vegetables, Other"
"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Beets For Fodder"
"Swedes For Fodder"
"Temporary meadows and pastures"
"Permanent meadows and pastures"
"Cabbage, for forage"
"Other grasses, for forage"
"Rye grass, for forage"
"Sorghum, for forage"
Miscanthus
/
;

Set Commodities_EquivalentToNonGrassFedAnimalActivityOutput(Commodities) Commodities that are equivalent to the output of animal activities from animals WITHOUT grass in their feeding ration
/
*"Meat, ass"
"Honey, natural"
"Beeswax"
*"Meat, buffaloes"
*"Milk, whole fresh buffalo"
*"Hides, buffalo, fresh"
*"Meat, Other Camelids"

*"Meat, Camels"
*"Hides, camel, nes"
*"Meat, cattle"
*"Milk, whole fresh cow"

"Meat, chicken"
"Eggs, hen, in shell"
"Meat, duck"
"Meat, goose and guinea fowl"
*"Meat, goat"
*"Milk, whole fresh goat"
*"Skins Nes Goats"
*"Meat, horse"
*"Hides, horse, dry salted"
*"Meat, Mules"
"Meat, Pigeon Oth.Birds"
"Eggs, other bird, in shell"
"Meat, pig"

"Meat, rabbit"

*"Meat, sheep"
*"Milk, whole fresh sheep"
*"Wool, greasy"

"Meat, turkey"


*"Meat, game"

*"Meat, cattle"
*"Milk, whole fresh cow"
*"Eggs, hen, in shell"
*"Meat, chicken"
/;

Set CommoditiesDAQ_TradeFromToWorldPrimaryAnimals(Commodities) "Commodity set - only PRIMARY ANIMAL commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
/
"Bovine Meat"
Pigmeat
"Poultry Meat"
Silk
"Aquatic Animals, Others"
"Aquatic Plants"
Cephalopods
Crustaceans
"Demersal Fish"
Eggs
"Freshwater Fish"
Honey
"Marine Fish, Other"
"Meat, Other"
"Milk, Whole"
"Molluscs, Other"
"Mutton & Goat Meat"
Offals
*due to the structure of the calculations, fats fit better in this set
"Fats, Animals, Raw"
"Pelagic Fish"
"Wool (Clean Eq.)"
/
;

Set CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed(Commodities) "Commodity set - only PRIMARY grass-fed ANIMAL commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
/
"Bovine Meat"
*Pigmeat
*"Poultry Meat"
*Silk
*"Aquatic Animals, Others"
*"Aquatic Plants"
*Cephalopods
*Crustaceans
*"Demersal Fish"
*Eggs
*"Freshwater Fish"
*Honey
*"Marine Fish, Other"
*"Meat, Other"
"Milk, Whole"
*"Molluscs, Other"
"Mutton & Goat Meat"
*Offals
*due to the structure of the calculations, fats fit better in this set
*"Fats, Animals, Raw"
*"Pelagic Fish"
"Wool (Clean Eq.)"
/
;

Set CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NonGrassFed(Commodities) "Commodity set - only PRIMARY non-grass-fed ANIMAL commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
/
*"Bovine Meat"
Pigmeat
"Poultry Meat"
Silk
**"Aquatic Animals, Others"
**"Aquatic Plants"
**Cephalopods
**Crustaceans
**"Demersal Fish"
Eggs
**"Freshwater Fish"
Honey
**"Marine Fish, Other"
"Meat, Other"
*"Milk, Whole"
**"Molluscs, Other"
*"Mutton & Goat Meat"
Offals
*due to the structure of the calculations, fats fit better in this set
"Fats, Animals, Raw"
**"Pelagic Fish"
*"Wool (Clean Eq.)"
/
;

*fish and seafood needw to be treated differently, as it is captured differently than livestock:
Set CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_FishSeafood(Commodities) "Commodity set - only PRIMARY non-grass-fed FISH/SEAFOOD commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
/
"Aquatic Animals, Others"
"Aquatic Plants"
Cephalopods
Crustaceans
"Demersal Fish"
"Freshwater Fish"
"Marine Fish, Other"
"Molluscs, Other"
"Pelagic Fish"
/;



Set CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary(Commodities) Derived CROP commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
/
"Coconut Oil"
"Copra Cake"
"Cottonseed Cake"
"Cottonseed Oil"
"Groundnut Cake"
"Groundnut Oil"
"Oilcrops Oil, Other"
"Oilseed Cakes, Other"
"Olive Oil"
"Palmkernel Cake"
"Palmkernel Oil"
"Rape and Mustard Cake"
"Rape and Mustard Oil"
"Ricebran Oil"
"Sesameseed Cake"
"Sesameseed Oil"
"Soyabean Cake"
"Soyabean Oil"
"Sunflowerseed Cake"
"Sunflowerseed Oil"
Molasses
"Sugar (Raw Equivalent)"
"Sugar non-centrifugal"
/;

Set CommoditiesDAQ_TradeFTWorldDirDerivedFromPrimary_Animals(Commodities) Derived ANIMAL commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
/
"Butter, Ghee"
"Cheese"
"Meat Meal"
Cream
"Milk, Skimmed"
Whey
/;

Set CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed(Commodities) Derived grass-fed ANIMAL commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
/
"Butter, Ghee"
"Cheese"
*"Meat Meal"
Cream
"Milk, Skimmed"
Whey
/;

Set CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed(Commodities) Derived non-grass-fed ANIMAL commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
/
*"Butter, Ghee"
*"Cheese"
"Meat Meal"
*Cream
*"Milk, Skimmed"
*Whey
/;

Set CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts(Commodities) "crop commodities that are pooled from primary commodities plus derived products"
/
"Apples and products"
"Barley and products"
"Cassava and products"
"Cocoa Beans and products"
"Coffee and products"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Lemons, Limes and products"
"Maize and products"
"Millet and products"
"Nuts and products"
"Pineapples and products"
"Potatoes and products"
"Pulses, Other and products"
"Rye and products"
"Sorghum and products"
"Tomatoes and products"
"Wheat and products"
*wine has the same structure: commodity.Primary activity, where the latter is not identical to a commodity traded, etc., thus add to this set:
Wine
*similar: maize germ oil:
"Maize Germ Oil"
/;

Set CommoditiesDAQ_TradeFromToWorld_FishSeafood(Commodities) "Commodity set - fish and seafood commodities - explanation cf. excel-file NutritiveFactors_CommoditySetCorrespondences"
/
"Aquatic Animals, Others"
*Aquatic Products, Other
Cephalopods
Crustaceans
"Demersal Fish"
*Fish, Seafood
"Freshwater Fish"
"Marine Fish, Other"
"Molluscs, Other"
"Pelagic Fish"
"Fish Meal"
"Fish, Body Oil"
"Fish, Liver Oil"
/;


Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_Crops(Commodities,Activities,OutputsCropsGrass) "Matching set to match the crop commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
/
Bananas."Bananas"."MainOutput1 (t)"
Cloves."Cloves"."MainOutput1 (t)"
"Cotton lint"."Seed cotton"."MainOutput1 (t)"
Cottonseed."Seed cotton"."MainOutput1 (t)"
Dates."Dates"."MainOutput1 (t)"
Jute."Jute"."MainOutput1 (t)"
Oats."Oats"."MainOutput1 (t)"
"Palm kernels"."Oil, palm fruit"."MainOutput1 (t)"
"Sesame seed"."Sesame seed"."MainOutput1 (t)"
Sisal."Sisal"."MainOutput1 (t)"
"Sugar beet"."Sugar beet"."MainOutput1 (t)"
"Sugar cane"."Sugar cane"."MainOutput1 (t)"
"Sunflower seed"."Sunflower seed"."MainOutput1 (t)"
"Sweet potatoes"."Sweet potatoes"."MainOutput1 (t)"
Yams."Yams"."MainOutput1 (t)"
Molasses."All Sugar Crops"."MainOutput1 (t)"
Wine."Grapes"."MainOutput1 (t)"
*Infant food
Plantains."Plantains and others"."MainOutput1 (t)"
"Sugar non-centrifugal"."All sugar sources"."MainOutput1 (t)"
"Turnips For Fodder"."Turnips For Fodder"."MainOutput1 (t)"
*Animal fats
"Beer"."All Cereals"."MainOutput1 (t)"
Onions."Onions, dry"."MainOutput1 (t)"
*Pulses
Tobacco."Tobacco, unmanufactured"."MainOutput1 (t)"
Abaca."Manila fibre (abaca)"."MainOutput1 (t)"
"Alcohol, Non-Food"."All Crops"."MainOutput1 (t)"
*Alcoholic Beverages
"Apples and products"."Apples"."MainOutput1 (t)"
"Barley and products"."Barley"."MainOutput1 (t)"
Beans."Beans, dry"."MainOutput1 (t)"
"Beverages, Alcoholic"."All Crops"."MainOutput1 (t)"
"Beverages, Fermented"."All Crops"."MainOutput1 (t)"
*Brans
"Cassava and products"."Cassava"."MainOutput1 (t)"
*Cereals - Excluding Beer
"Cereals, Other"."Other Cereals"."MainOutput1 (t)"
"Citrus, Other"."All other citrus"."MainOutput1 (t)"
"Cocoa Beans and products"."Cocoa, beans"."MainOutput1 (t)"
"Coconut Oil"."Coconuts"."MainOutput1 (t)"
"Coconuts - Incl Copra"."Coconuts"."MainOutput1 (t)"
"Coffee and products"."Coffee, green"."MainOutput1 (t)"
"Copra Cake"."Coconuts"."MainOutput1 (t)"
"Cottonseed Cake"."Seed cotton"."MainOutput1 (t)"
"Cottonseed Oil"."Seed cotton"."MainOutput1 (t)"
*Fruits - Excluding Wine
"Fruits, Other"."All Fruits"."MainOutput1 (t)"
"Grapefruit and products"."Grapefruit (inc. pomelos)"."MainOutput1 (t)"
"Grapes and products (excl wine)"."Grapes"."MainOutput1 (t)"
"Groundnut Cake"."Groundnuts, with shell"."MainOutput1 (t)"
"Groundnut Oil"."Groundnuts, with shell"."MainOutput1 (t)"
"Groundnuts (in Shell Eq)"."Groundnuts, with shell"."MainOutput1 (t)"
*Groundnuts (Shelled Eq)
"Hard Fibres, Other"."All other hard fibres"."MainOutput1 (t)"
"Jute-Like Fibres"."Jute & Jute-like Fibres"."MainOutput1 (t)"
"Lemons, Limes and products"."Lemons and limes"."MainOutput1 (t)"
"Maize and products"."Maize"."MainOutput1 (t)"
"Maize Germ Oil"."Maize"."MainOutput1 (t)"
"Millet and products"."Millet"."MainOutput1 (t)"
*Miscellaneous
"Nuts and products"."All Nuts"."MainOutput1 (t)"
*Oilcrops
"Oilcrops Oil, Other"."All other oilcrops"."MainOutput1 (t)"
"Oilcrops, Other"."All other oilcrops"."MainOutput1 (t)"
"Oilseed Cakes, Other"."All other oilcrops"."MainOutput1 (t)"
"Olive Oil"."Olives"."MainOutput1 (t)"
"Olives (including preserved)"."Olives"."MainOutput1 (t)"
"Oranges, Mandarines"."Oranges"."MainOutput1 (t)"
"Palm Oil"."Oil, palm fruit"."MainOutput1 (t)"
"Palmkernel Cake"."Oil, palm fruit"."MainOutput1 (t)"
"Palmkernel Oil"."Oil, palm fruit"."MainOutput1 (t)"
Peas."Peas, dry"."MainOutput1 (t)"
Pepper."Pepper (piper spp.)"."MainOutput1 (t)"
Pimento."Chillies and peppers, dry"."MainOutput1 (t)"
"Pineapples and products"."Pineapples"."MainOutput1 (t)"
"Potatoes and products"."Potatoes"."MainOutput1 (t)"
"Pulses, Other and products"."Pulses,Total"."MainOutput1 (t)"
"Rape and Mustard Cake"."Rape and Mustard seed"."MainOutput1 (t)"
"Rape and Mustard Oil"."Rape and Mustard seed"."MainOutput1 (t)"
"Rape and Mustardseed"."Rape and Mustard seed"."MainOutput1 (t)"
*Rice (Milled Equivalent)
"Rice (Paddy Equivalent)"."Rice, paddy"."MainOutput1 (t)"
"Ricebran Oil"."Rice, paddy"."MainOutput1 (t)"
*Roots & Tuber Dry Equiv
"Roots, Other"."All other roots"."MainOutput1 (t)"
Rubber."Rubber, natural"."MainOutput1 (t)"
"Rye and products"."Rye"."MainOutput1 (t)"
"Sesameseed Cake"."Sesame seed"."MainOutput1 (t)"
"Sesameseed Oil"."Sesame seed"."MainOutput1 (t)"
"Soft-Fibres, Other"."All other soft fibres"."MainOutput1 (t)"
"Sorghum and products"."Sorghum"."MainOutput1 (t)"
"Soyabean Cake"."Soybeans"."MainOutput1 (t)"
"Soyabean Oil"."Soybeans"."MainOutput1 (t)"
Soyabeans."Soybeans"."MainOutput1 (t)"
Spices."All spices"."MainOutput1 (t)"
"Spices, Other"."All other Spices"."MainOutput1 (t)"
*Starchy Roots
*Stimulants
*Sugar & Sweeteners
"Sugar (Raw Equivalent)"."All sugar crops"."MainOutput1 (t)"
*Sugar Crops
*Sugar, Raw Equivalent
*Sugar, Refined Equiv
"Sunflowerseed Cake"."Sunflower seed"."MainOutput1 (t)"
"Sunflowerseed Oil"."Sunflower seed"."MainOutput1 (t)"
"Sweeteners, Other"."All other sugar sources"."MainOutput1 (t)"
"Tea (including mate)"."Tea"."MainOutput1 (t)"
"Tomatoes and products"."Tomatoes"."MainOutput1 (t)"
*Treenuts
*Vegetable Oils
*Vegetables
"Vegetables, Other"."All other vegetables"."MainOutput1 (t)"
"Wheat and products"."Wheat"."MainOutput1 (t)"
"Aquatic Plants"."Aquatic Plants"."MainOutput1 (t)"

"Maize For Forage+Silage"."Maize For Forage+Silage"."MainOutput1 (t)"
"Alfalfa For Forage+Silag"."Alfalfa For Forage+Silag"."MainOutput1 (t)"
"Clover For Forage+Silage"."Clover For Forage+Silage"."MainOutput1 (t)"
"Leguminous Nes,For+Sil"."Leguminous Nes,For+Sil"."MainOutput1 (t)"
"Beets For Fodder"."Beets For Fodder"."MainOutput1 (t)"
"Swedes For Fodder"."Swedes For Fodder"."MainOutput1 (t)"
"Temporary meadows and pastures"."Temporary meadows and pastures"."MainOutput1 (t)"
"Permanent meadows and pastures"."Permanent meadows and pastures"."MainOutput1 (t)"
"Cabbage, for forage"."Cabbage, for forage"."MainOutput1 (t)"
"Other grasses, for forage"."Other grasses, for forage"."MainOutput1 (t)"
"Rye grass, for forage"."Rye grass, for forage"."MainOutput1 (t)"
"Sorghum, for forage"."Sorghum, for forage"."MainOutput1 (t)"
Miscanthus."Miscanthus"."MainOutput1 (t)"
/;

Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_Animals(Commodities,Activities,OutputsAnimals) "Matching set to match the animals commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
/
"Bovine Meat"."Cattle and buffaloes"."Meat (t)"
Pigmeat."Pigs"."Meat (t)"
"Poultry Meat"."Chickens"."Meat (t)"
*"Silk"."Silkworms"."Other animal output"
"Aquatic Animals, Others"."Aquatic Animals, Others"."Meat (t)"
*Aquatic Products, Other
"Butter, Ghee"."All Ruminants"."Milk (t)"
Cephalopods."Cephalopods"."Meat (t)"
"Cheese"."All Ruminants"."Milk (t)"
Cream."Cattle"."Milk (t)"
Crustaceans."Crustaceans"."Meat (t)"
"Demersal Fish"."Demersal Fish"."Meat (t)"
Eggs."Chickens"."Eggs (t)"
"Fats, Animals, Raw"."All Animals"."Fat (t)"
"Fish Meal"."All Fish and Seafood"."Meat (t)"
"Fish, Body Oil"."All Fish and Marine Mamm"."Meat (t)"
"Fish, Liver Oil"."All Fish and Marine Mamm"."Meat (t)"
*Fish, Seafood
"Freshwater Fish"."Freshwater Fish"."Meat (t)"
*Hides and skins
Honey.Beehives."Honey (t)"
"Marine Fish, Other"."All other marine fish"."Meat (t)"
*Meat
"Meat Meal"."All Animals"."Meat (t)"
"Meat, Other"."All other Animals"."Meat (t)"
*Milk - Excluding Butter
"Milk, Skimmed"."Cattle"."Milk (t)"
"Milk, Whole"."Cattle"."Milk (t)"
"Molluscs, Other"."Molluscs"."Meat (t)"
"Mutton & Goat Meat"."Sheep and Goats"."Meat (t)"
*Offals."All Animals"."Offals (t)"
*as it id calculated with all meat producing animals, change output type to meat:
Offals."All Animals"."Meat (t)"
*Offals, Edible
*due to the structure of the calculations, fats fit better in this set
*as it id calculated with all meat producing animals, change output type to meat:
*"Fats, Animals, Raw"."All Animals"."Fat (t)"
"Fats, Animals, Raw"."All Animals"."Meat (t)"
"Pelagic Fish"."Pelagic Fish"."Meat (t)"
Whey."Cattle"."Milk (t)"
"Wool (Clean Eq.)"."Sheep"."Wool (t)"
/;

Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsPrimary(Commodities,Activities,OutputsCropsGrass) "Matching set to match the crop commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
/
Bananas."Bananas"."MainOutput1 (t)"
Cloves."Cloves"."MainOutput1 (t)"
"Cotton lint"."Seed cotton"."MainOutput1 (t)"
Cottonseed."Seed cotton"."MainOutput1 (t)"
Dates."Dates"."MainOutput1 (t)"
Jute."Jute"."MainOutput1 (t)"
Oats."Oats"."MainOutput1 (t)"
"Palm kernels"."Oil, palm fruit"."MainOutput1 (t)"
"Sesame seed"."Sesame seed"."MainOutput1 (t)"
Sisal."Sisal"."MainOutput1 (t)"
"Sugar beet"."Sugar beet"."MainOutput1 (t)"
"Sugar cane"."Sugar cane"."MainOutput1 (t)"
"Sunflower seed"."Sunflower seed"."MainOutput1 (t)"
"Sweet potatoes"."Sweet potatoes"."MainOutput1 (t)"
Yams."Yams"."MainOutput1 (t)"
Plantains."Plantains and others"."MainOutput1 (t)"
"Turnips For Fodder"."Turnips For Fodder"."MainOutput1 (t)"
Onions."Onions, dry"."MainOutput1 (t)"
*Pulses
Tobacco."Tobacco, unmanufactured"."MainOutput1 (t)"
Abaca."Manila fibre (abaca)"."MainOutput1 (t)"
Beans."Beans, dry"."MainOutput1 (t)"
"Cereals, Other"."Other Cereals"."MainOutput1 (t)"
"Citrus, Other"."All other citrus"."MainOutput1 (t)"
"Coconuts - Incl Copra"."Coconuts"."MainOutput1 (t)"
*Fruits - Excluding Wine
"Fruits, Other"."All Fruits"."MainOutput1 (t)"
"Groundnuts (in Shell Eq)"."Groundnuts, with shell"."MainOutput1 (t)"
"Hard Fibres, Other"."All other hard fibres"."MainOutput1 (t)"
"Jute-Like Fibres"."Jute & Jute-like Fibres"."MainOutput1 (t)"
"Oilcrops, Other"."All other oilcrops"."MainOutput1 (t)"
"Olives (including preserved)"."Olives"."MainOutput1 (t)"
"Oranges, Mandarines"."Oranges"."MainOutput1 (t)"
"Palm Oil"."Oil, palm fruit"."MainOutput1 (t)"
Peas."Peas, dry"."MainOutput1 (t)"
Pepper."Pepper (piper spp.)"."MainOutput1 (t)"
Pimento."Chillies and peppers, dry"."MainOutput1 (t)"
"Rape and Mustardseed"."Rape and Mustard seed"."MainOutput1 (t)"
*Rice (Milled Equivalent)
"Rice (Paddy Equivalent)"."Rice, paddy"."MainOutput1 (t)"
"Roots, Other"."All other roots"."MainOutput1 (t)"
Rubber."Rubber, natural"."MainOutput1 (t)"
"Soft-Fibres, Other"."All other soft fibres"."MainOutput1 (t)"
Soyabeans."Soybeans"."MainOutput1 (t)"
Spices."All spices"."MainOutput1 (t)"
"Spices, Other"."All other Spices"."MainOutput1 (t)"
*Starchy Roots
"Tea (including mate)"."Tea"."MainOutput1 (t)"
*Treenuts
*Vegetables
"Vegetables, Other"."All other vegetables"."MainOutput1 (t)"
"Aquatic Plants"."Aquatic Plants"."MainOutput1 (t)"
"Maize For Forage+Silage"."Maize For Forage+Silage"."MainOutput1 (t)"
"Alfalfa For Forage+Silag"."Alfalfa For Forage+Silag"."MainOutput1 (t)"
"Clover For Forage+Silage"."Clover For Forage+Silage"."MainOutput1 (t)"
"Leguminous Nes,For+Sil"."Leguminous Nes,For+Sil"."MainOutput1 (t)"
"Beets For Fodder"."Beets For Fodder"."MainOutput1 (t)"
"Swedes For Fodder"."Swedes For Fodder"."MainOutput1 (t)"
"Temporary meadows and pastures"."Temporary meadows and pastures"."MainOutput1 (t)"
"Permanent meadows and pastures"."Permanent meadows and pastures"."MainOutput1 (t)"
"Cabbage, for forage"."Cabbage, for forage"."MainOutput1 (t)"
"Other grasses, for forage"."Other grasses, for forage"."MainOutput1 (t)"
"Rye grass, for forage"."Rye grass, for forage"."MainOutput1 (t)"
"Sorghum, for forage"."Sorghum, for forage"."MainOutput1 (t)"
Miscanthus."Miscanthus"."MainOutput1 (t)"
/;

Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsDerived(Commodities,Activities,OutputsCropsGrass) "Matching set to match the crop commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
/
Molasses."All Sugar Crops"."MainOutput1 (t)"
Wine."Grapes"."MainOutput1 (t)"
*Infant food
"Sugar non-centrifugal"."All sugar sources"."MainOutput1 (t)"
*Animal fats
"Beer"."All Cereals"."MainOutput1 (t)"
"Alcohol, Non-Food"."All Crops"."MainOutput1 (t)"
*Alcoholic Beverages
"Apples and products"."Apples"."MainOutput1 (t)"
"Barley and products"."Barley"."MainOutput1 (t)"
"Beverages, Alcoholic"."All Crops"."MainOutput1 (t)"
"Beverages, Fermented"."All Crops"."MainOutput1 (t)"
*Brans
"Cassava and products"."Cassava"."MainOutput1 (t)"
*Cereals - Excluding Beer
"Cocoa Beans and products"."Cocoa, beans"."MainOutput1 (t)"
"Coconut Oil"."Coconuts"."MainOutput1 (t)"
"Coffee and products"."Coffee, green"."MainOutput1 (t)"
"Copra Cake"."Coconuts"."MainOutput1 (t)"
"Cottonseed Cake"."Seed cotton"."MainOutput1 (t)"
"Cottonseed Oil"."Seed cotton"."MainOutput1 (t)"
"Grapefruit and products"."Grapefruit (inc. pomelos)"."MainOutput1 (t)"
"Grapes and products (excl wine)"."Grapes"."MainOutput1 (t)"
"Groundnut Cake"."Groundnuts, with shell"."MainOutput1 (t)"
"Groundnut Oil"."Groundnuts, with shell"."MainOutput1 (t)"
*Groundnuts (Shelled Eq)
"Lemons, Limes and products"."Lemons and limes"."MainOutput1 (t)"
"Maize and products"."Maize"."MainOutput1 (t)"
"Maize Germ Oil"."Maize"."MainOutput1 (t)"
"Millet and products"."Millet"."MainOutput1 (t)"
*Miscellaneous
"Nuts and products"."All Nuts"."MainOutput1 (t)"
*Oilcrops
"Oilcrops Oil, Other"."All other oilcrops"."MainOutput1 (t)"
"Oilseed Cakes, Other"."All other oilcrops"."MainOutput1 (t)"
"Olive Oil"."Olives"."MainOutput1 (t)"
"Palmkernel Cake"."Oil, palm fruit"."MainOutput1 (t)"
"Palmkernel Oil"."Oil, palm fruit"."MainOutput1 (t)"
"Pineapples and products"."Pineapples"."MainOutput1 (t)"
"Potatoes and products"."Potatoes"."MainOutput1 (t)"
"Pulses, Other and products"."Pulses,Total"."MainOutput1 (t)"
"Rape and Mustard Cake"."Rape and Mustard seed"."MainOutput1 (t)"
"Rape and Mustard Oil"."Rape and Mustard seed"."MainOutput1 (t)"
"Ricebran Oil"."Rice, paddy"."MainOutput1 (t)"
*Roots & Tuber Dry Equiv
"Rye and products"."Rye"."MainOutput1 (t)"
"Sesameseed Cake"."Sesame seed"."MainOutput1 (t)"
"Sesameseed Oil"."Sesame seed"."MainOutput1 (t)"
"Sorghum and products"."Sorghum"."MainOutput1 (t)"
"Soyabean Cake"."Soybeans"."MainOutput1 (t)"
"Soyabean Oil"."Soybeans"."MainOutput1 (t)"
*Stimulants
*Sugar & Sweeteners
"Sugar (Raw Equivalent)"."All sugar crops"."MainOutput1 (t)"
*Sugar Crops
*Sugar, Raw Equivalent
*Sugar, Refined Equiv
"Sunflowerseed Cake"."Sunflower seed"."MainOutput1 (t)"
"Sunflowerseed Oil"."Sunflower seed"."MainOutput1 (t)"
"Sweeteners, Other"."All other sugar sources"."MainOutput1 (t)"
"Tomatoes and products"."Tomatoes"."MainOutput1 (t)"
*Vegetable Oils
"Wheat and products"."Wheat"."MainOutput1 (t)"
/;

Set MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_CropsDerived(Commodities,Commodities_2)  "Matching the derived CROP commodities that are derived from primary commodities as captured in the previous set - DAQ and trade calculations for them are different than for the other derived commodities)"
/
"Coconut Oil"."Coconuts - Incl Copra"
"Copra Cake"."Coconuts - Incl Copra"
"Cottonseed Cake"."Cottonseed"
"Cottonseed Oil"."Cottonseed"
"Groundnut Cake"."Groundnuts (in Shell Eq)"
"Groundnut Oil"."Groundnuts (in Shell Eq)"
"Oilcrops Oil, Other"."Oilcrops, Other"
"Oilseed Cakes, Other"."Oilcrops, Other"
"Olive Oil"."Olives (including preserved)"
"Palmkernel Cake"."Palm kernels"
"Palmkernel Oil"."Palm kernels"
"Rape and Mustard Cake"."Rape and Mustardseed"
"Rape and Mustard Oil"."Rape and Mustardseed"
"Ricebran Oil"."Rice (Paddy Equivalent)"
"Sesameseed Cake"."Sesame seed"
"Sesameseed Oil"."Sesame seed"
"Soyabean Cake"."Soyabeans"
"Soyabean Oil"."Soyabeans"
"Sunflowerseed Cake"."Sunflower seed"
"Sunflowerseed Oil"."Sunflower seed"
Molasses."Sugar Crops"
"Sugar (Raw Equivalent)"."Sugar crops"
"Sugar non-centrifugal"."Sugar cane"
/;

Set MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_AnimalsDerived(Commodities,Commodities_2)  "Matching the derived ANIMAL commodities that are derived from primary commodities as captured in the previous set - DAQ and trade calculations for them are different than for the other derived commodities)"
/
*the aggregate commodities Milk and Meat capture those from all animals - used only in an intermediate step when calculating commodity quantities, etc. - then deleted again
"Butter, Ghee"."Milk"
"Cheese"."Milk"
"Meat Meal"."Meat"
Cream."Milk, whole"
"Milk, Skimmed"."Milk, whole"
Whey."Milk, whole"
/;

Set MatchPrimDerivedCommodities_DAQ_TradeFTW_AnimalsDer_GrassFed(Commodities,Commodities_2)  "Matching the derived grass-fed ANIMAL commodities that are derived from primary commodities as captured in the previous set - DAQ and trade calculations for them are different than for the other derived commodities)"
/
*the aggregate commodities Milk and Meat capture those from all animals - used only in an intermediate step when calculating commodity quantities, etc. - then deleted again
"Butter, Ghee"."Milk"
"Cheese"."Milk"
*"Meat Meal"."Meat"
Cream."Milk, whole"
"Milk, Skimmed"."Milk, whole"
Whey."Milk, whole"
/;

Set MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(Commodities,Activities,OutputsCropsGrass) "Matching set to match the crop commodities that are pooled from primary commodities plus derived products with the underlying activity"
/
"Apples and products"."Apples"."MainOutput1 (t)"
"Barley and products"."Barley"."MainOutput1 (t)"
"Cassava and products"."Cassava"."MainOutput1 (t)"
"Cocoa Beans and products"."Cocoa, beans"."MainOutput1 (t)"
"Coffee and products"."Coffee, green"."MainOutput1 (t)"
"Grapefruit and products"."Grapefruit (inc. pomelos)"."MainOutput1 (t)"
"Grapes and products (excl wine)"."Grapes"."MainOutput1 (t)"
"Lemons, Limes and products"."Lemons and limes"."MainOutput1 (t)"
"Maize and products"."Maize"."MainOutput1 (t)"
"Millet and products"."Millet"."MainOutput1 (t)"
"Nuts and products"."All Nuts"."MainOutput1 (t)"
"Pineapples and products"."Pineapples"."MainOutput1 (t)"
"Potatoes and products"."Potatoes"."MainOutput1 (t)"
"Pulses, Other and products"."Pulses,Total"."MainOutput1 (t)"
"Rye and products"."Rye"."MainOutput1 (t)"
"Sorghum and products"."Sorghum"."MainOutput1 (t)"
"Tomatoes and products"."Tomatoes"."MainOutput1 (t)"
"Wheat and products"."Wheat"."MainOutput1 (t)"
*wine has the same structure: commodity.Primary activity, where the latter is not identical to a commodity traded, etc., thus add to this set:
Wine."Grapes"."MainOutput1 (t)"
*similar: maize germ oil:
"Maize Germ Oil"."Maize"."MainOutput1 (t)"
/;

Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsPrimary(Commodities,Activities,OutputsAnimals) "Matching set to match the animals commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
/
"Bovine Meat"."Cattle and buffaloes"."Meat (t)"
Pigmeat."Pigs"."Meat (t)"
"Poultry Meat"."Poultry birds"."Meat (t)"
*"Silk"."Silkworms"."Other animal output"
"Aquatic Animals, Others"."Aquatic Animals, Others"."Meat (t)"
*Aquatic Products, Other
Cephalopods."Cephalopods"."Meat (t)"


Crustaceans."Crustaceans"."Meat (t)"
"Demersal Fish"."Demersal Fish"."Meat (t)"
Eggs."Chickens"."Eggs (t)"
*Fish, Seafood
"Freshwater Fish"."Freshwater Fish"."Meat (t)"
*Hides and skins
Honey.Beehives."Honey (t)"
"Marine Fish, Other"."All other marine fish"."Meat (t)"
*Meat
"Meat, Other"."All other Animals"."Meat (t)"
*Milk - Excluding Butter
"Milk, Whole"."Cattle"."Milk (t)"
"Molluscs, Other"."Molluscs"."Meat (t)"
"Mutton & Goat Meat"."Sheep and Goats"."Meat (t)"
*Offals."All Animals"."Offals (t)"
*as it id calculated with all meat producing animals, change output type to meat:
Offals."All Animals"."Meat (t)"
*"Fats, Animals, Raw"."All Animals"."Fat (t)"
"Fats, Animals, Raw"."All Animals"."Meat (t)"
*Offals, Edible
"Pelagic Fish"."Pelagic Fish"."Meat (t)"
"Wool (Clean Eq.)"."Sheep"."Wool (t)"
/;

Set MatchCommAct_CommoditiesDAQ_TradeFTW_AnimalsPrimaryGrassFed(Commodities,Activities,OutputsAnimals) "Matching set to match the grass-fed animals commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
/
"Bovine Meat"."Cattle and buffaloes"."Meat (t)"
*Pigmeat."Pigs"."Meat (t)"
*"Poultry Meat"."Poultry birds"."Meat (t)"
*"Silk"."Silkworms"."Other animal output"
*"Aquatic Animals, Others"."Aquatic Animals, Others"."Meat (t)"
*Aquatic Products, Other
*Cephalopods."Cephalopods"."Meat (t)"


*Crustaceans."Crustaceans"."Meat (t)"
*"Demersal Fish"."Demersal Fish"."Meat (t)"
*Eggs."Chickens"."Eggs (t)"
*Fish, Seafood
*"Freshwater Fish"."Freshwater Fish"."Meat (t)"
*Hides and skins
*Honey.Beehives."Honey (t)"
*"Marine Fish, Other"."All other marine fish"."Meat (t)"
*Meat
*"Meat, Other"."All other Animals"."Meat (t)"
*Milk - Excluding Butter
"Milk, Whole"."Cattle"."Milk (t)"
*"Molluscs, Other"."Molluscs"."Meat (t)"
"Mutton & Goat Meat"."Sheep and Goats"."Meat (t)"
*Offals."All Animals"."Offals (t)"
*as it id calculated with all meat producing animals, change output type to meat:
*Offals."All Animals"."Meat (t)"
*"Fats, Animals, Raw"."All Animals"."Fat (t)"
*"Fats, Animals, Raw"."All Animals"."Meat (t)"
*Offals, Edible
*"Pelagic Fish"."Pelagic Fish"."Meat (t)"
"Wool (Clean Eq.)"."Sheep"."Wool (t)"
/;

Set MatchCommAct_CommoditiesDAQ_TradeFTW_AnimPrimaryNonGrassFed(Commodities,Activities,OutputsAnimals) "Matching set to match the NON-grass-fed animals commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
/
*"Bovine Meat"."Cattle and buffaloes"."Meat (t)"
Pigmeat."Pigs"."Meat (t)"
"Poultry Meat"."Poultry birds"."Meat (t)"
*"Silk"."Silkworms"."Other animal output"
"Aquatic Animals, Others"."Aquatic Animals, Others"."Meat (t)"
*Aquatic Products, Other
Cephalopods."Cephalopods"."Meat (t)"


Crustaceans."Crustaceans"."Meat (t)"
"Demersal Fish"."Demersal Fish"."Meat (t)"
Eggs."Chickens"."Eggs (t)"
*Fish, Seafood
"Freshwater Fish"."Freshwater Fish"."Meat (t)"
*Hides and skins
Honey.Beehives."Honey (t)"
"Marine Fish, Other"."All other marine fish"."Meat (t)"
*Meat
"Meat, Other"."All other Animals"."Meat (t)"
*Milk - Excluding Butter
*"Milk, Whole"."Cattle"."Milk (t)"
"Molluscs, Other"."Molluscs"."Meat (t)"
*"Mutton & Goat Meat"."Sheep and Goats"."Meat (t)"
*Offals."All Animals"."Offals (t)"
*as it id calculated with all meat producing animals, change output type to meat:
Offals."All Animals"."Meat (t)"
*"Fats, Animals, Raw"."All Animals"."Fat (t)"
"Fats, Animals, Raw"."All Animals"."Meat (t)"
*Offals, Edible
"Pelagic Fish"."Pelagic Fish"."Meat (t)"
*"Wool (Clean Eq.)"."Sheep"."Wool (t)"
/;

Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsDerived(Commodities,Activities,OutputsAnimals) "Matching set to match the animals commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
/
"Butter, Ghee"."All Ruminants"."Milk (t)"
"Cheese"."All Ruminants"."Milk (t)"
Cream."Cattle"."Milk (t)"
"Fish Meal"."All Fish and Seafood"."Meat (t)"
"Fish, Body Oil"."All Fish and Marine Mamm"."Meat (t)"
"Fish, Liver Oil"."All Fish and Marine Mamm"."Meat (t)"
"Meat Meal"."All Animals"."Meat (t)"
"Milk, Skimmed"."Cattle"."Milk (t)"
Whey."Cattle"."Milk (t)"
/;

Set MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,Commodities_2) "Matching set between the commodities where data on trade for a country from/to World is available, and where data on trade for a country from/to all other countries is available"
*more explanations can be found in the sheets MatchFTWorldTr_ToCountrSpecific and Trade_FTWorld_Commodities of the file NutritiveFactors_CommoditySetCorrespondences.xlsx
*the first entry is the country-country-level, the second entry is the country-World level
/
"Anise, badian, fennel, coriander"."Spices, Other"
"Apples"."Apples and products"
"Apricots"."Fruits, Other"
"Artichokes"."Vegetables, Other"
"Asparagus"."Vegetables, Other"
"Avocados"."Fruits, Other"
"Bambara beans"."Pulses, Other and products"
"Bananas"."Bananas"
"Barley"."Barley and products"
"Beans, dry"."Beans"
"Beans, green"."Vegetables, Other"
"Blueberries"."Fruits, Other"
"Broad beans, horse beans, dry"."Pulses, Other and products"
"Buckwheat"."Cereals, Other"
"Cabbages and other brassicas"."Vegetables, Other"
"Canary seed"."Cereals, Other"
"Carrots and turnips"."Vegetables, Other"
"Cashew nuts, with shell"."Nuts and products"
"Cauliflowers and broccoli"."Vegetables, Other"
"Cherries"."Fruits, Other"
"Cherries, sour"."Fruits, Other"
"Chestnut"."Nuts and products"
"Chick peas"."Pulses, Other and products"
"Chillies and peppers, dry"."Vegetables, Other"
"Chillies and peppers, green"."Vegetables, Other"
"Cinnamon (canella)"."Spices, Other"
"Cloves"."Cloves"
"Cocoa, beans"."Cocoa Beans and products"
"Coconuts"."Coconuts - Incl Copra"
"Coffee, green"."Coffee and products"
"Cotton lint"."Cotton lint"
"Cottonseed"."Cottonseed"
"Cranberries"."Fruits, Other"
"Cucumbers and gherkins"."Vegetables, Other"
"Currants"."Fruits, Other"
"Dates"."Dates"
"Eggplants (aubergines)"."Vegetables, Other"
"Figs"."Fruits, Other"
"Flax fibre and tow"."Soft-Fibres, Other"
"Fonio"."Cereals, Other"
"Fruit, fresh nes"."Fruits, Other"
"Fruit, tropical fresh nes"."Fruits, Other"
"Garlic"."Vegetables, Other"
"Ginger"."Spices, Other"
"Gooseberries"."Fruits, Other"
"Grain, mixed"."Cereals, Other"
"Grapefruit (inc. pomelos)"."Grapefruit and products"
"Grapes"."Grapes and products (excl wine)"
*"Hops".""
"Jute"."Jute"
"Kiwi fruit"."Fruits, Other"
"Kola nuts"."Nuts and products"
"Leeks, other alliaceous vegetables"."Vegetables, Other"
"Lemons and limes"."Lemons, Limes and products"
"Lentils"."Pulses, Other and products"
"Lettuce and chicory"."Vegetables, Other"
"Linseed"."Oilcrops, Other"
"Maize"."Maize and products"
"Maize, green"."Vegetables, Other"
"Mangoes, mangosteens, guavas"."Fruits, Other"
"Manila fibre (abaca)"."Abaca"
"Maté"."Tea (including mate)"
"Melons, other (inc.cantaloupes)"."Fruits, Other"
"Millet"."Millet and products"
"Mushrooms and truffles"."Vegetables, Other"
"Mustard seed"."Rape and Mustardseed"
"Nutmeg, mace and cardamoms"."Spices, Other"
"Nuts, nes"."Nuts and products"
"Oats"."Oats"
"Oil, palm"."Palm Oil"
"Oilseeds nes"."Oilcrops, Other"
"Olives"."Olives (including preserved)"
"Onions, dry"."Onions"
"Onions, shallots, green"."Vegetables, Other"
"Oranges"."Oranges, Mandarines"
"Palm kernels"."Palm kernels"
"Papayas"."Fruits, Other"
"Peaches and nectarines"."Fruits, Other"
"Pears"."Fruits, Other"
"Peas, dry"."Peas"
"Peas, green"."Vegetables, Other"
"Pepper (piper spp.)"."Pepper"
"Peppermint"."Spices"
"Persimmons"."Fruits, Other"
"Pineapples"."Pineapples and products"
"Pistachios"."Nuts and products"
"Plums and sloes"."Fruits, Other"
"Poppy seed"."Oilcrops, Other"
"Potatoes"."Potatoes and products"
"Pumpkins, squash and gourds"."Vegetables, Other"
"Pyrethrum, dried"."Spices"
"Quinces"."Fruits, Other"
"Rapeseed"."Rape and Mustardseed"
"Roots and tubers, nes"."Roots, Other"
"Rubber, natural"."Rubber"
"Rye"."Rye and products"
"Sesame seed"."Sesame seed"
"Sisal"."Sisal"
"Sorghum"."Sorghum and products"
"Soybeans"."Soyabeans"
"Spices, nes"."Spices, Other"
"Spinach"."Vegetables, Other"
"Strawberries"."Fruits, Other"
"Sugar beet"."Sugar Crops"
"Sugar cane"."Sugar Crops"
"Sugar crops, nes"."Sugar Crops"
"Sunflower seed"."Sunflower seed"
"Sweet potatoes"."Sweet potatoes"
"Tangerines, mandarins, clementines, satsumas"."Oranges, Mandarines"
"Tea"."Tea (including mate)"
"Tobacco, unmanufactured"."Tobacco"
"Tomatoes"."Tomatoes and products"
"Triticale"."Cereals, Other"
"Vanilla"."Spices, Other"
"Vegetables, fresh nes"."Vegetables, Other"
"Walnuts, with shell"."Nuts and products"
"Watermelons"."Fruits, Other"
"Wheat"."Wheat and products"
"Yams"."Yams"
"Beer of barley"."Beer"
"Margarine, short"."Oilcrops Oil, Other"
"Molasses"."Molasses"
"Oil, coconut (copra)"."Coconut Oil"
"Oil, cottonseed"."Cottonseed Oil"
"Oil, groundnut"."Groundnut Oil"
"Oil, linseed"."Oilcrops Oil, Other"
"Oil, maize"."Maize and products"
"Oil, olive, virgin"."Olive Oil"
"Oil, palm kernel"."Palmkernel Oil"
"Oil, rapeseed"."Rape and Mustard Oil"
"Oil, safflower"."Oilcrops Oil, Other"
"Oil, sesame"."Sesameseed Oil"
"Oil, soybean"."Soyabean Oil"
"Oil, sunflower"."Sunflowerseed Oil"
"Sugar Raw Centrifugal"."Sugar (Raw Equivalent)"
"Wine"."Wine"
*"Beeswax".""
"Eggs, hen, in shell"."Eggs"
"Eggs, other bird, in shell"."Eggs"
"Honey, natural"."Honey"
"Meat, cattle"."Bovine Meat"
"Meat, chicken"."Poultry Meat"
"Meat, duck"."Poultry Meat"
"Meat, game"."Meat, Other"
"Meat, goat"."Mutton & Goat Meat"
"Meat, goose and guinea fowl"."Poultry Meat"
"Meat, horse"."Meat, Other"
"Meat, nes"."Meat, Other"
"Meat, pig"."Pigmeat"
"Meat, rabbit"."Meat, Other"
"Meat, sheep"."Mutton & Goat Meat"
"Meat, turkey"."Poultry Meat"
"Milk, whole fresh cow"."Milk, Whole"
"Silk-worm cocoons, reelable"."Silk"
"Skins, sheep, with wool"."Hides and skins"
"Wool, greasy"."Wool (Clean Eq.)"
"Butter, cow milk"."Butter, Ghee"
"Cheese, sheep milk"."Cheese"
"Cheese, whole cow milk"."Cheese"
"Cream fresh"."Cream"
"Lard"."Animal fats"
"Milk, skimmed cow"."Milk, Skimmed"
"Milk, skimmed dried"."Milk, Skimmed"
"Milk, whole condensed"."Milk, Whole"
"Milk, whole dried"."Milk, Whole"
"Milk, whole evaporated"."Milk, Whole"
"Silk raw"."Silk"
"Tallow"."Animal fats"
"Whey, condensed"."Whey"
"Whey, dry"."Whey"
*"Alfalfa meal and pellets".""
"Almonds shelled"."Nuts and products"
"Apricots, dry"."Fruits, Other"
"Bacon and ham"."Animal fats"
"Barley, pearled"."Barley and products"
*"Beet pulp".""
"Beverages, distilled alcoholic"."Beverages, Alcoholic"
"Beverages, fermented rice"."Beverages, Fermented"
*"Beverages, non alcoholic".""
"Bran, maize"."Maize and products"
"Bran, millet"."Millet and products"
"Bran, wheat"."Wheat and products"
"Brazil nuts, shelled"."Nuts and products"
"Bread"."Wheat and products"
"Bulgur"."Wheat and products"
"Buttermilk, curdled, acidified milk"."Milk - Excluding Butter"
"Cake, copra"."Copra Cake"
"Cake, cottonseed"."Cottonseed Cake"
"Cake, groundnuts"."Groundnut Cake"
"Cake, linseed"."Oilseed Cakes, Other"
"Cake, maize"."Oilseed Cakes, Other"
"Cake, mustard"."Rape and Mustard Cake"
"Cake, palm kernel"."Palmkernel Cake"
"Cake, rapeseed"."Rape and Mustard Cake"
"Cake, rice bran"."Oilseed Cakes, Other"
"Cake, safflower"."Oilseed Cakes, Other"
"Cake, sesame seed"."Sesameseed Cake"
"Cake, soybeans"."Soyabean Cake"
"Cake, sunflower"."Sunflowerseed Cake"
"Cashew nuts, shelled"."Nuts and products"
"Cassava dried"."Cassava and products"
"Cereal preparations, nes"."Cereals, Other"
"Cereals, breakfast"."Cereals, Other"
"Cheese, processed"."Cheese"
"Chocolate products nes"."Cocoa Beans and products"
"Cider etc"."Alcoholic Beverages"
"Cigarettes"."Tobacco"
"Cigars, cheroots"."Tobacco"
"Cocoa, butter"."Oilcrops Oil, Other"
"Cocoa, paste"."Cocoa Beans and products"
"Cocoa, powder & cake"."Cocoa Beans and products"
"Coconuts, desiccated"."Coconuts - Incl Copra"
"Cocoons, unreelable & waste"."Silk"
"Coffee, extracts"."Coffee and products"
"Coffee, husks and skins"."Coffee and products"
"Coffee, roasted"."Coffee and products"
"Coffee, substitutes containing coffee"."Coffee and products"
"Copra"."Coconuts - Incl Copra"
*"Cotton linter".""
*"Cotton waste".""
*"Cotton, carded, combed".""
*"Crude materials".""
*"Dregs from brewing, distillation".""
"Eggs, dried"."Eggs"
"Eggs, liquid"."Eggs"
"Fat, cattle"."Animal fats"
"Fat, liver prepared (foie gras)"."Animal fats"
"Fat, nes, prepared"."Animal fats"
"Fat, pigs"."Animal fats"
"Fatty acids"."Animal fats"
"Fatty substance residues"."Animal fats"
*"Feed and meal, gluten".""
*"Feed supplements".""
*"Feed, compound, nes".""
*"Feed, pulp of fruit".""
*"Feed, vegetable products nes".""
"Figs dried"."Fruits, Other"
"Flax fibre raw"."Soft-Fibres, Other"
"Flax tow waste"."Soft-Fibres, Other"
"Flour, cereals"."Cereals, Other"
"Flour, maize"."Maize and products"
"Flour, mixed grain"."Cereals, Other"
"Flour, mustard"."Rape and Mustardseed"
"Flour, potatoes"."Potatoes and products"
"Flour, pulses"."Pulses, Other and products"
"Flour, roots and tubers nes"."Roots, Other"
"Flour, wheat"."Wheat and products"
*"Food prep nes".""
*"Food preparations, flour, malt extract".""
*"Food wastes".""
*"Forage products".""
"Fructose and syrup, other"."Sweeteners, Other"
"Fruit, cooked, homogenized preparations"."Fruits, Other"
"Fruit, dried nes"."Fruits, Other"
"Fruit, prepared nes"."Fruits, Other"
"Germ, maize"."Maize and products"
"Glucose and dextrose"."Sweeteners, Other"
*"Grease incl. lanolin wool".""
"Groundnuts, shelled"."Groundnuts (Shelled Eq)"
*"Hair, fine".""
*"Hair, goat, coarse".""
*"Hay (unspecified)".""
"Hazelnuts, shelled"."Nuts and products"
"Hides, cattle, wet salted"."Hides and skins"
"Hides, nes"."Hides and skins"
*"Ice cream and edible ice".""
*"Infant food".""
"Juice, citrus, concentrated"."Citrus, Other"
"Juice, citrus, single strength"."Citrus, Other"
"Juice, fruit nes"."Fruits, Other"
"Juice, grape"."Grapes and products (excl wine)"
"Juice, grapefruit"."Grapefruit and products"
"Juice, grapefruit, concentrated"."Grapefruit and products"
"Juice, lemon, concentrated"."Lemons, Limes and products"
"Juice, orange, concentrated"."Oranges, Mandarines"
"Juice, orange, single strength"."Oranges, Mandarines"
"Juice, pineapple"."Pineapples and products"
"Juice, pineapple, concentrated"."Pineapples and products"
"Juice, tomato"."Tomatoes and products"
*"Lactose".""
"Macaroni"."Wheat and products"
"Malt"."Barley and products"
"Maple sugar and syrups"."Sweeteners, Other"
"Margarine, liquid"."Oilcrops Oil, Other"
"Meal, meat"."Meat Meal"
"Meat, beef and veal sausages"."Bovine Meat"
"Meat, beef, preparations"."Bovine Meat"
"Meat, cattle, boneless (beef & veal)"."Bovine Meat"
"Meat, chicken, canned"."Poultry Meat"
"Meat, dried nes"."Meat, Other"
"Meat, pig sausages"."Pigmeat"
"Meat, pig, preparations"."Pigmeat"
"Meat, pork"."Pigmeat"
*"Milk, products of natural constituents nes".""
"Mixes and doughs"."Wheat and products"
"Mushrooms, canned"."Vegetables, Other"
"Nuts, prepared (exc. groundnuts)"."Nuts and products"
"Oats rolled"."Oats"
"Offals, edible, cattle"."Offals"
"Offals, edible, goats"."Offals"
"Offals, liver chicken"."Offals"
"Offals, liver duck"."Offals"
"Offals, liver geese"."Offals"
"Offals, pigs, edible"."Offals"
"Offals, sheep,edible"."Offals"
"Oil, boiled etc"."Oilcrops Oil, Other"
"Oil, castor beans"."Oilcrops Oil, Other"
*"Oil, citronella".""
*"Oil, essential nes".""
"Oil, olive residues"."Olive Oil"
"Oil, rice bran"."Ricebran Oil"
"Oil, vegetable origin nes"."Oilcrops Oil, Other"
"Oils, fats of animal nes"."Animal fats"
"Olives preserved"."Olives (including preserved)"
"Pastry"."Wheat and products"
"Peanut butter"."Groundnuts (Shelled Eq)"
*"Pet food".""
"Pineapples canned"."Pineapples and products"
"Plantains"."Plantains"
"Plums dried (prunes)"."Fruits, Other"
"Potatoes, frozen"."Potatoes and products"
"Raisins"."Grapes and products (excl wine)"
"Rice – total  (Rice milled equivalent)"."Rice (Milled Equivalent)"
"Rubber natural dry"."Rubber"
"Skins, calve, wet salted"."Hides and skins"
"Skins, goat, wet salted"."Hides and skins"
"Skins, sheep, dry salted"."Hides and skins"
"Skins, sheep, wet salted"."Hides and skins"
"Soya paste"."Soyabeans"
"Soya sauce"."Soyabeans"
"Starch, cassava"."Cassava and products"
*"Straw husks".""
"Sugar confectionery"."Sugar (Raw Equivalent)"
"Sugar non-centrifugal"."Sugar non-centrifugal"
"Sugar refined"."Sugar, Refined Equiv"
"Sugar, nes"."Sugar (Raw Equivalent)"
"Sweet corn frozen"."Vegetables, Other"
"Sweet corn prep or preserved"."Vegetables, Other"
"Tea, mate extracts"."Tea (including mate)"
"Tobacco products nes"."Tobacco"
"Tomatoes, paste"."Tomatoes and products"
"Tomatoes, peeled"."Tomatoes and products"
"Vegetables in vinegar"."Vegetables, Other"
"Vegetables, dehydrated"."Vegetables, Other"
"Vegetables, fresh or dried products nes"."Vegetables, Other"
"Vegetables, frozen"."Vegetables, Other"
"Vegetables, homogenized preparations"."Vegetables, Other"
"Vegetables, preserved nes"."Vegetables, Other"
"Vegetables, preserved, frozen"."Vegetables, Other"
"Vegetables, temporarily preserved"."Vegetables, Other"
"Vermouths & similar"."Alcoholic Beverages"
*"Vitamins".""
*"Wafers".""
"Walnuts, shelled"."Nuts and products"
*"Waters,ice etc".""
*"Waxes vegetable".""
"Wool, degreased"."Wool (Clean Eq.)"
"Wool, hair waste"."Wool (Clean Eq.)"
"Yoghurt, concentrated or not"."Milk - Excluding Butter"
/;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*14) Some auxiliary sets
*14.1) Years
Set Years "Set that contains all the different years used in the model"
/1950*2100, AverageBasisYear, AverageBasisYearOLD/;
*the following indicates the base years for basing the baseline on - earlier, this has been:

$if %BaselineChoice% == "2009_13" $goto Baseline2009_13
$if %BaselineChoice% == "2010_14" $goto Baseline2010_14
$if %BaselineChoice% == "2005_09" $goto Baseline2005_09

$label Baseline2009_13
Set Basisyears(Years) /2009*2013/;
*according to FAOSTAT glossary, seed are quantities set aside during a reference period for the following one - thus, seed applied in 2009 is reported as seed in 2008
Set BasisyearsSeed(Years) /2008*2012/;

$goto EndOfBaslineChoice


$label Baseline2010_14
Set Basisyears(Years) /2010*2014/;
*according to FAOSTAT glossary, seed are quantities set aside during a reference period for the following one - thus, seed applied in 2009 is reported as seed in 2008
Set BasisyearsSeed(Years) /2009*2013/;

$goto EndOfBaslineChoice


$label Baseline2005_09
Set Basisyears(Years) /2005*2009/;
*according to FAOSTAT glossary, seed are quantities set aside during a reference period for the following one - thus, seed applied in 2009 is reported as seed in 2008
Set BasisyearsSeed(Years) /2004*2008/;

$goto EndOfBaslineChoice

$label EndOfBaslineChoice


*14.2) Temperatures
Set Temperatures "Set of temperature values in degree Celsius - to be used for manure management emissions calculations, for example, etc."
/
AllAndAverageTemp
0*100
/;

Set Temperatures0to100Celsius(Temperatures) "generally used temperatures - range of 0 to 100 degree Celsius"
/
0*100
/;

*for some parameters in manure management, below 10 and above 28 is assigned the same value as 10 and 28, thus define these sets
*as it is average environmental temperatures, no need to go beyond 40 degrees
Set TemperaturesBelow10(Temperatures)
/0*9/;
Set TemperaturesAbove28(Temperatures)
/28*40/;


*14.3) Greenhouse gases
Set GreenhouseGases "relevant greenhouse gases for agriculture, used to define the GWP and GTP, etc. in a flexible way as a parameter"
/
CO2
CH4
N2O
/;


*14.4) Sets related to mineral fertilizers
Set MineralFertilizerType "Types of mineral fertilizers"
/
"mineral N fert (N)"
"mineral P fert (P2O5)"
"mineral K fert (K2O)"
/;

Set MineralFertilizerProdTech "Mineral fertilizer production technologies"
/
AllMinFertProdTech
/;

Set MinFertChar "Mineral fertilizer characteristics"
/
"t CO2e/tN production"
"t CO2e/tP2O5 production"
/;


*14.5) Sets related to population and human nutrition
Set PopulationGroups "population groups  - all, male, female, children"
/
PopulationAll
Male
Female
Children
/;

Set Humans_InputsOutputsOtherCharacteristics "inputs to, outputs from and other characteristics of humans"
/
"kcal/cap/day"
"kcal/cap/day (ADER)"
*        average daily energy requirements
"kcal/cap/day (MDER)"
*        minimal daily energy requirements
"g protein/cap/day"
"g fat/cap/day"

*for these oarameters, we file in values from several sources, thus keep the information on the data source in the set elements to be able to choose later which one to use without the need to run this file for filing in data again
*values from SOFI2012
"kcal/cap/day SOFI2012"
"kcal/cap/day (ADER) SOFI2012"
*        average daily energy requirements
"kcal/cap/day (MDER) SOFI2012"
*        minimal daily energy requirements
"g protein/cap/day SOFI2012"
"g fat/cap/day SOFI2012"

*values from Walpole2012
"kcal/cap/day Walpole2012"
"kcal/cap/day (ADER) Walpole2012 "
*        average daily energy requirements
"kcal/cap/day (MDER) Walpole2012 "
*        minimal daily energy requirements
"g protein/cap/day Walpole2012 "
"g fat/cap/day Walpole2012 "

*the following is needed for BioeSR15: requirements
"kcal/cap/day (BioeSR15 req)"

"N excretion in human faeces (tN)"
"P excretion in human faeces (tP2O5)"
"N excretion in human faeces - for croplands (tN)"
"P excretion in human faeces - for croplands (tP2O5)"
/;


*14.6) Sets related to feeding rations
set FeedingRationOtherChar "Characteristics of feeding rations that is not captured in the set contents or so - e.g. quantity share in DM for all commodities, etc."
/
"Quantity share in DM (share)"
"Percentage GE in feed converted to enteric CH4"
"GE per ton DM feeding ration (MJ/t DM)"
"GE share in feeding ration (share in MJ)"
"FeedQuant_Req (t)"
"FeedQuant_Req DM (t)"
"Quantity share in total feed req of all animals"
"GE per ton feeding ration (MJ/t)"
"FeedGE_Req (MJ)"
/;


*14.7) Some auxiliary matching sets for reading data (to be defined here, as they refer to the set Activities)
Set MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Activities)
/
"Animals live nes"."Animals live nes"
"Asses"."Asses"
"Beehives"."Beehives"
"Buffaloes"."Buffaloes"
"Camelids, other"."Camelids, other"
"Camels"."Camels"
"Cattle"."Cattle"
"Cattle and Buffaloes"."Cattle and Buffaloes"
"Chickens"."Chickens"
"Ducks"."Ducks"
"Geese and guinea fowls"."Geese and guinea fowls"
"Goats"."Goats"
"Horses"."Horses"
"Mules"."Mules"
"Pigeons, other birds"."Pigeons, other birds"
"Pigs"."Pigs"
"Poultry Birds"."Poultry Birds"
"Rabbits and hares"."Rabbits and hares"
"Rodents, other"."Rodents, other"
"Sheep"."Sheep"
"Sheep and Goats"."Sheep and Goats"
"Turkeys"."Turkeys"
/;

Set Match_ActivityOutputsToCommodities_Crops(Activities,OutputsCropsGrass,Commodities) "Set to link the main outputs from the crop activities to commodities, that can then be further worked with on commodity level"
/
*the following equals FAOSTAT_CropProductionItems
"Agave fibres nes"                       ."MainOutput1 (t)"    ."Agave fibres nes"
"Almonds, with shell"                    ."MainOutput1 (t)"    ."Almonds, with shell"
"Anise, badian, fennel, coriander"       ."MainOutput1 (t)"    ."Anise, badian, fennel, coriander"
"Apples"                                 ."MainOutput1 (t)"    ."Apples"
"Apricots"                               ."MainOutput1 (t)"    ."Apricots"
"Areca nuts"                             ."MainOutput1 (t)"    ."Areca nuts"
"Artichokes"                             ."MainOutput1 (t)"    ."Artichokes"
"Asparagus"                              ."MainOutput1 (t)"    ."Asparagus"
"Avocados"                               ."MainOutput1 (t)"    ."Avocados"
"Bambara beans"                          ."MainOutput1 (t)"    ."Bambara beans"
"Bananas"                                ."MainOutput1 (t)"    ."Bananas"
"Barley"                                 ."MainOutput1 (t)"    ."Barley"
"Bastfibres, other"                      ."MainOutput1 (t)"    ."Bastfibres, other"
"Beans, dry"                             ."MainOutput1 (t)"    ."Beans, dry"
"Beans, green"                           ."MainOutput1 (t)"    ."Beans, green"
"Berries nes"                            ."MainOutput1 (t)"    ."Berries nes"
"Blueberries"                            ."MainOutput1 (t)"    ."Blueberries"
"Brazil nuts, with shell"                ."MainOutput1 (t)"    ."Brazil nuts, with shell"
"Broad beans, horse beans, dry"          ."MainOutput1 (t)"    ."Broad beans, horse beans, dry"
"Buckwheat"                              ."MainOutput1 (t)"    ."Buckwheat"
"Cabbages and other brassicas"           ."MainOutput1 (t)"    ."Cabbages and other brassicas"
"Canary seed"                            ."MainOutput1 (t)"    ."Canary seed"
"Carobs"                                 ."MainOutput1 (t)"    ."Carobs"
"Carrots and turnips"                    ."MainOutput1 (t)"    ."Carrots and turnips"
"Cashew nuts, with shell"                ."MainOutput1 (t)"    ."Cashew nuts, with shell"
"Cashewapple"                            ."MainOutput2 (t)"    ."Cashewapple"
"Cassava"                                ."MainOutput1 (t)"    ."Cassava"
"Cassava leaves"                         ."MainOutput2 (t)"    ."Cassava leaves"
"Castor oil seed"                        ."MainOutput1 (t)"    ."Castor oil seed"
"Cauliflowers and broccoli"              ."MainOutput1 (t)"    ."Cauliflowers and broccoli"
"Cereals (Rice Milled Eqv)"              ."MainOutput1 (t)"    ."Cereals (Rice Milled Eqv)"
"Cereals, nes"                           ."MainOutput1 (t)"    ."Cereals, nes"
*"Cereals,Total"
"Cherries"                               ."MainOutput1 (t)"    ."Cherries"
"Cherries, sour"                         ."MainOutput1 (t)"    ."Cherries, sour"
"Chestnut"                               ."MainOutput1 (t)"    ."Chestnut"
"Chick peas"                             ."MainOutput1 (t)"    ."Chick peas"
"Chicory roots"                          ."MainOutput1 (t)"    ."Chicory roots"
"Chillies and peppers, dry"              ."MainOutput1 (t)"    ."Chillies and peppers, dry"
"Chillies and peppers, green"            ."MainOutput1 (t)"    ."Chillies and peppers, green"
"Cinnamon (canella)"                     ."MainOutput1 (t)"    ."Cinnamon (canella)"
*"Citrus Fruit,Total"                    ."MainOutput1 (t)"
"Cloves"                                 ."MainOutput1 (t)"    ."Cloves"
*"Coarse Grain, Total"                   ."MainOutput1 (t)"
"Cocoa, beans"                           ."MainOutput1 (t)"    ."Cocoa, beans"
"Coconuts"                               ."MainOutput1 (t)"    ."Coconuts"
"Coffee, green"                          ."MainOutput1 (t)"    ."Coffee, green"
"Coir"                                   ."MainOutput2 (t)"    ."Coir"
*the following are derived from main outputs seed cotton
*"Cotton lint"                            ."MainOutput1 (t)"
*"Cottonseed"                             ."MainOutput1 (t)"
"Cow peas, dry"                          ."MainOutput1 (t)"    ."Cow peas, dry"
"Cranberries"                            ."MainOutput1 (t)"    ."Cranberries"
"Cucumbers and gherkins"                 ."MainOutput1 (t)"    ."Cucumbers and gherkins"
"Currants"                               ."MainOutput1 (t)"    ."Currants"
"Dates"                                  ."MainOutput1 (t)"    ."Dates"
"Eggplants (aubergines)"                 ."MainOutput1 (t)"    ."Eggplants (aubergines)"
"Fibre crops nes"                        ."MainOutput1 (t)"    ."Fibre crops nes"
*"Fibre Crops Primary"                   ."MainOutput1 (t)"
"Figs"                                   ."MainOutput1 (t)"    ."Figs"
"Flax fibre and tow"                     ."MainOutput1 (t)"    ."Flax fibre and tow"
"Fonio"                                  ."MainOutput1 (t)"    ."Fonio"
*"Fruit excl Melons,Total"               ."MainOutput1 (t)"
"Fruit, citrus nes"                      ."MainOutput1 (t)"    ."Fruit, citrus nes"
"Fruit, fresh nes"                       ."MainOutput1 (t)"    ."Fruit, fresh nes"
"Fruit, pome nes"                        ."MainOutput1 (t)"    ."Fruit, pome nes"
"Fruit, stone nes"                       ."MainOutput1 (t)"    ."Fruit, stone nes"
"Fruit, tropical fresh nes"              ."MainOutput1 (t)"    ."Fruit, tropical fresh nes"
"Garlic"                                 ."MainOutput1 (t)"    ."Garlic"
"Ginger"                                 ."MainOutput1 (t)"    ."Ginger"
"Gooseberries"                           ."MainOutput1 (t)"    ."Gooseberries"
"Grain, mixed"                           ."MainOutput1 (t)"    ."Grain, mixed"
"Grapefruit (inc. pomelos)"              ."MainOutput1 (t)"    ."Grapefruit (inc. pomelos)"
"Grapes"                                 ."MainOutput1 (t)"    ."Grapes"
"Groundnuts, with shell"                 ."MainOutput1 (t)"    ."Groundnuts, with shell"
"Gums, natural"                          ."MainOutput1 (t)"    ."Gums, natural"
"Hazelnuts, with shell"                  ."MainOutput1 (t)"    ."Hazelnuts, with shell"
"Hemp tow waste"                         ."MainOutput2 (t)"    ."Hemp tow waste"
"Hempseed"                               ."MainOutput1 (t)"    ."Hempseed"
"Hops"                                   ."MainOutput1 (t)"    ."Hops"
"Jojoba seed"                            ."MainOutput1 (t)"    ."Jojoba seed"
"Jute"                                   ."MainOutput1 (t)"    ."Jute"
*"Jute & Jute-like Fibres"
"Kapok fibre"                            ."MainOutput2 (t)"    ."Kapok fibre"
"Kapok fruit"                            ."MainOutput1 (t)"    ."Kapok fruit"
"Kapokseed in shell"                     ."MainOutput1 (t)"    ."Kapokseed in shell"
"Karite nuts (sheanuts)"                 ."MainOutput1 (t)"    ."Karite nuts (sheanuts)"
"Kiwi fruit"                             ."MainOutput1 (t)"    ."Kiwi fruit"
"Kola nuts"                              ."MainOutput1 (t)"    ."Kola nuts"
"Leeks, other alliaceous vegetables"     ."MainOutput1 (t)"    ."Leeks, other alliaceous vegetables"
"Lemons and limes"                       ."MainOutput1 (t)"    ."Lemons and limes"
"Lentils"                                ."MainOutput1 (t)"    ."Lentils"
"Lettuce and chicory"                    ."MainOutput1 (t)"    ."Lettuce and chicory"
"Linseed"                                ."MainOutput1 (t)"    ."Linseed"
"Lupins"                                 ."MainOutput1 (t)"    ."Lupins"
"Maize"                                  ."MainOutput1 (t)"    ."Maize"
"Maize, green"                           ."MainOutput1 (t)"    ."Maize, green"
"Mangoes, mangosteens, guavas"           ."MainOutput1 (t)"    ."Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"                   ."MainOutput1 (t)"    ."Manila fibre (abaca)"
"Maté"                                   ."MainOutput1 (t)"    ."Maté"
*     in the data downloaded from FAOSTAT, it is written
"Melons, other (inc.cantaloupes)"        ."MainOutput1 (t)"    ."Melons, other (inc.cantaloupes)"
"Melonseed"                              ."MainOutput1 (t)"    ."Melonseed"
"Millet"                                 ."MainOutput1 (t)"    ."Millet"
"Mushrooms and truffles"                 ."MainOutput1 (t)"    ."Mushrooms and truffles"
"Mustard seed"                           ."MainOutput1 (t)"    ."Mustard seed"
"Nutmeg, mace and cardamoms"             ."MainOutput1 (t)"    ."Nutmeg, mace and cardamoms"
"Nuts, nes"                              ."MainOutput1 (t)"    ."Nuts, nes"
"Oats"                                   ."MainOutput1 (t)"    ."Oats"
*the following is derived from oil, palm fruit
*"Oil, palm"
"Oil, palm fruit"                        ."MainOutput1 (t)"    ."Oil, palm fruit"
*"Oilcakes Equivalent"
*"Oilcrops Primary"
"Oilseeds nes"                           ."MainOutput1 (t)"    ."Oilseeds nes"
"Okra"                                   ."MainOutput1 (t)"    ."Okra"
"Olives"                                 ."MainOutput1 (t)"    ."Olives"
"Onions, dry"                            ."MainOutput1 (t)"    ."Onions, dry"
"Onions, shallots, green"                ."MainOutput1 (t)"    ."Onions, shallots, green"
"Oranges"                                ."MainOutput1 (t)"    ."Oranges"
*the following is derived from oil, palm fruit
*"Palm kernels"
"Papayas"                                ."MainOutput1 (t)"    ."Papayas"
"Peaches and nectarines"                 ."MainOutput1 (t)"    ."Peaches and nectarines"
"Pears"                                  ."MainOutput1 (t)"    ."Pears"
"Peas, dry"                              ."MainOutput1 (t)"    ."Peas, dry"
"Peas, green"                            ."MainOutput1 (t)"    ."Peas, green"
"Pepper (piper spp.)"                    ."MainOutput1 (t)"    ."Pepper (piper spp.)"
"Peppermint"                             ."MainOutput1 (t)"    ."Peppermint"
"Persimmons"                             ."MainOutput1 (t)"    ."Persimmons"
"Pigeon peas"                            ."MainOutput1 (t)"    ."Pigeon peas"
"Pineapples"                             ."MainOutput1 (t)"    ."Pineapples"
"Pistachios"                             ."MainOutput1 (t)"    ."Pistachios"
"Plantains and others"                   ."MainOutput1 (t)"    ."Plantains and others"
"Plums and sloes"                        ."MainOutput1 (t)"    ."Plums and sloes"
"Poppy seed"                             ."MainOutput1 (t)"    ."Poppy seed"
"Potatoes"                               ."MainOutput1 (t)"    ."Potatoes"
"Pulses, nes"                            ."MainOutput1 (t)"    ."Pulses, nes"
*"Pulses,Total"                          ."MainOutput1 (t)"
"Pumpkins, squash and gourds"            ."MainOutput1 (t)"    ."Pumpkins, squash and gourds"
"Pyrethrum, dried"                       ."MainOutput1 (t)"    ."Pyrethrum, dried"
"Quinces"                                ."MainOutput1 (t)"    ."Quinces"
"Quinoa"                                 ."MainOutput1 (t)"    ."Quinoa"
"Ramie"                                  ."MainOutput1 (t)"    ."Ramie"
"Rapeseed"                               ."MainOutput1 (t)"    ."Rapeseed"
"Raspberries"                            ."MainOutput1 (t)"    ."Raspberries"
"Rice, paddy"                            ."MainOutput1 (t)"    ."Rice, paddy"
"Roots and tubers, nes"                  ."MainOutput1 (t)"    ."Roots and tubers, nes"
*"Roots and Tubers,Total"                ."MainOutput1 (t)"
"Rubber, natural"                        ."MainOutput1 (t)"    ."Rubber, natural"
"Rye"                                    ."MainOutput1 (t)"    ."Rye"
"Safflower seed"                         ."MainOutput1 (t)"    ."Safflower seed"
"Seed cotton"                            ."MainOutput1 (t)"    ."Seed cotton"
"Sesame seed"                            ."MainOutput1 (t)"    ."Sesame seed"
"Sisal"                                  ."MainOutput1 (t)"    ."Sisal"
"Sorghum"                                ."MainOutput1 (t)"    ."Sorghum"
"Soybeans"                               ."MainOutput1 (t)"    ."Soybeans"
"Spices, nes"                            ."MainOutput1 (t)"    ."Spices, nes"
"Spinach"                                ."MainOutput1 (t)"    ."Spinach"
"Strawberries"                           ."MainOutput1 (t)"    ."Strawberries"
"String beans"                           ."MainOutput1 (t)"    ."String beans"
"Sugar beet"                             ."MainOutput1 (t)"    ."Sugar beet"
"Sugar cane"                             ."MainOutput1 (t)"    ."Sugar cane"
"Sugar crops, nes"                       ."MainOutput1 (t)"    ."Sugar crops, nes"
"Sunflower seed"                         ."MainOutput1 (t)"    ."Sunflower seed"
"Sweet potatoes"                         ."MainOutput1 (t)"    ."Sweet potatoes"
"Tallowtree seed"                        ."MainOutput1 (t)"    ."Tallowtree seed"
"Tangerines, mandarins, clementines, satsumas"."MainOutput1 (t)"."Tangerines, mandarins, clementines, satsumas"
"Taro (cocoyam)"                         ."MainOutput1 (t)"    ."Taro (cocoyam)"
"Tea"                                    ."MainOutput1 (t)"    ."Tea"
"Tobacco, unmanufactured"                ."MainOutput1 (t)"    ."Tobacco, unmanufactured"
"Tomatoes"                               ."MainOutput1 (t)"    ."Tomatoes"
*"Treenuts,Total"                        ."MainOutput1 (t)"
"Triticale"                              ."MainOutput1 (t)"    ."Triticale"
"Tung nuts"                              ."MainOutput1 (t)"    ."Tung nuts"
"Vanilla"                                ."MainOutput1 (t)"    ."Vanilla"
*"Vegetables Primary"
*"Vegetables&Melons, Total"
"Vegetables, fresh nes"                  ."MainOutput1 (t)"    ."Vegetables, fresh nes"
"Vegetables, leguminous nes"             ."MainOutput1 (t)"    ."Vegetables, leguminous nes"
"Vetches"                                ."MainOutput1 (t)"    ."Vetches"
"Walnuts, with shell"                    ."MainOutput1 (t)"    ."Walnuts, with shell"
"Watermelons"                            ."MainOutput1 (t)"    ."Watermelons"
"Wheat"                                  ."MainOutput1 (t)"    ."Wheat"
"Yams"                                   ."MainOutput1 (t)"    ."Yams"
"Yautia (cocoyam)"                       ."MainOutput1 (t)"    ."Yautia (cocoyam)"
*till here it equals FAOSTAT_CropProductionItems

*include forage and fodder in crops:
"Maize For Forage+Silage"                ."MainOutput1 (t)"    ."Maize For Forage+Silage"
"Clover For Forage+Silage"               ."MainOutput1 (t)"    ."Clover For Forage+Silage"
"Alfalfa For Forage+Silag"               ."MainOutput1 (t)"    ."Alfalfa For Forage+Silag"
"Leguminous Nes,For+Sil"                 ."MainOutput1 (t)"    ."Leguminous Nes,For+Sil"
"Forage Products Nes"                    ."MainOutput1 (t)"    ."Forage Products Nes"
"Beets For Fodder"                       ."MainOutput1 (t)"    ."Beets For Fodder"
*'Vetches'

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
"Cabbage, for forage"                    ."MainOutput1 (t)"    ."Cabbage, for forage"
"Carrots, for forage"                    ."MainOutput1 (t)"    ."Carrots, for forage"
"Other grasses, for forage"              ."MainOutput1 (t)"    ."Other grasses, for forage"
"Other oilseeds, for forage"             ."MainOutput1 (t)"    ."Other oilseeds, for forage"
"Rye grass, for forage"                  ."MainOutput1 (t)"    ."Rye grass, for forage"
"Sorghum, for forage"                    ."MainOutput1 (t)"    ."Sorghum, for forage"

*we have the following two as forages as they are forages as in Aggregate_ForageCrops
*"Alfalfa Meal And Pellets"
*"Beets For Fodder"
"Swedes For Fodder"                      ."MainOutput1 (t)"    ."Swedes For Fodder"
"Turnips For Fodder"                     ."MainOutput1 (t)"    ."Turnips For Fodder"
"Vegetables+Roots,Fodder"                ."MainOutput1 (t)"    ."Vegetables+Roots,Fodder"

*drop, no output
*Fallows                                  ."MainOutput1 (t)"

"Temporary meadows and pastures"         ."MainOutput1 (t)"    ."Temporary meadows and pastures"
"Permanent meadows and pastures"         ."MainOutput1 (t)"    ."Permanent meadows and pastures"
Miscanthus                               ."MainOutput1 (t)"    .Miscanthus
/;



Set Match_ActivityOutputsToCommodities_Animals(Activities,OutputsAnimals,Commodities) "Set to link the main outputs from the animal activities to commodities, that can then be further worked with on commodity level"
/
*"Animals live nes"           ."Meat (t)"
"Asses"                      ."Meat (t)"              ."Meat, ass"
"Beehives"                   ."Honey (t)"             ."Honey, natural"
"Beehives"                   ."Wax (t)"               ."Beeswax"
"Buffaloes"                  ."Meat (t)"              ."Meat, buffaloes"
"Buffaloes"                  ."Milk (t)"              ."Milk, whole fresh buffalo"
"Buffaloes"                  ."HidesSkins (t)"     ."Hides, buffalo, fresh"
"Camelids, other"            ."Meat (t)"              ."Meat, Other Camelids"
*"Camelids, other"            ."HidesSkins (t)"
"Camels"                     ."Meat (t)"              ."Meat, Camels"
"Camels"                     ."HidesSkins (t)"     ."Hides, camel, nes"
"Cattle"                     ."Meat (t)"              ."Meat, cattle"
"Cattle"                     ."Milk (t)"              ."Milk, whole fresh cow"
*"Cattle and Buffaloes"
"Chickens"                   ."Meat (t)"              ."Meat, chicken"
"Chickens"                   ."Eggs (t)"              ."Eggs, hen, in shell"
"Ducks"                      ."Meat (t)"              ."Meat, duck"
"Geese and guinea fowls"     ."Meat (t)"              ."Meat, goose and guinea fowl"
"Goats"                      ."Meat (t)"              ."Meat, goat"
"Goats"                      ."Milk (t)"              ."Milk, whole fresh goat"
"Goats"                      ."HidesSkins (t)"     ."Skins Nes Goats"
"Horses"                     ."Meat (t)"              ."Meat, horse"
"Horses"                     ."HidesSkins (t)"     ."Hides, horse, dry salted"
"Mules"                      ."Meat (t)"              ."Meat, Mules"
"Pigeons, other birds"       ."Meat (t)"              ."Meat, Pigeon Oth.Birds"
"Pigeons, other birds"       ."Eggs (t)"              ."Eggs, other bird, in shell"
"Pigs"                       ."Meat (t)"              ."Meat, pig"
*"Poultry Birds"
"Rabbits and hares"          ."Meat (t)"              ."Meat, rabbit"
*"Rodents, other"             ."Meat (t)"
"Sheep"                      ."Meat (t)"              ."Meat, sheep"
"Sheep"                      ."Milk (t)"              ."Milk, whole fresh sheep"
"Sheep"                      ."Wool (t)"              ."Wool, greasy"
*"Sheep and Goats"
"Turkeys"                    ."Meat (t)"              ."Meat, turkey"
*till here it equals FAOSTAT_LiveAnimalsItems

Game                         ."Meat (t)"              ."Meat, game"

"Beef cattle"                ."Meat (t)"              ."Meat, cattle"
"Dairy cattle"               ."Milk (t)"              ."Milk, whole fresh cow"
"Chicken Layers"             ."Eggs (t)"              ."Eggs, hen, in shell"
"Chicken Broilers"           ."Meat (t)"              ."Meat, chicken"
/;

Set Match_FeedCommoditiesToFeedCommodGroups(Commodities,Commodities_2) "Matches the commodities used as feed to the four main feed groups (Conc, Forage, Grass, Residues)"
/
*the commodities excluded are aggregates/double counting - see excel-file NutrientFactors_CommoditySetCorrespondence
*the items highlighted blue in the commodity list
'Bananas'.'AggregateFeedConcentrates_Commodity'
'Cloves'.'AggregateFeedConcentrates_Commodity'
'Cottonseed'.'AggregateFeedConcentrates_Commodity'
'Dates'.'AggregateFeedConcentrates_Commodity'
'Oats'.'AggregateFeedConcentrates_Commodity'
'Palm kernels'.'AggregateFeedConcentrates_Commodity'
'Sesame seed'.'AggregateFeedConcentrates_Commodity'
'Sugar beet'.'AggregateFeedConcentrates_Commodity'
'Sugar cane'.'AggregateFeedConcentrates_Commodity'
'Sunflower seed'.'AggregateFeedConcentrates_Commodity'
'Sweet potatoes'.'AggregateFeedConcentrates_Commodity'
'Yams'.'AggregateFeedConcentrates_Commodity'
'Turnips for fodder'.'AggregateFeedConcentrates_Commodity'
'Aquatic Plants'.'AggregateFeedConcentrates_Commodity'
*'Aquatic Products, Other'.'AggregateFeedConcentrates_Commodity'
'Cephalopods'.'AggregateFeedConcentrates_Commodity'
'Crustaceans'.'AggregateFeedConcentrates_Commodity'
'Demersal Fish'.'AggregateFeedConcentrates_Commodity'
'Freshwater Fish'.'AggregateFeedConcentrates_Commodity'
'Pelagic Fish'.'AggregateFeedConcentrates_Commodity'
'Maize For Forage+Silage'.'AggregateFeedForageCrops_Commodity '
'Alfalfa For Forage+Silag'.'AggregateFeedForageCrops_Commodity '
'Clover For Forage+Silage'.'AggregateFeedForageCrops_Commodity '
'Leguminous Nes,For+Sil'.'AggregateFeedForageCrops_Commodity '
'Beets For Fodder'.'AggregateFeedConcentrates_Commodity'
'Swedes For Fodder'.'AggregateFeedConcentrates_Commodity'
'Temporary meadows and pastures'.'AggregateFeedGrass_Commodity '
'Permanent meadows and pastures'.'AggregateFeedGrass_Commodity '
'Cabbage, for forage'.'AggregateFeedForageCrops_Commodity '
'Other grasses, for forage'.'AggregateFeedForageCrops_Commodity '
'Rye grass, for forage'.'AggregateFeedForageCrops_Commodity '
'Sorghum, for forage'.'AggregateFeedForageCrops_Commodity '
'Molasses'.'AggregateFeedConcentrates_Commodity'
"Molasses (sugar cane)".'AggregateFeedConcentrates_Commodity'
"Molasses (sugar beet)".'AggregateFeedConcentrates_Commodity'
'Plantains'.'AggregateFeedConcentrates_Commodity'
'Sugar non-centrifugal'.'AggregateFeedConcentrates_Commodity'
*'Animal fats'.'AggregateFeedConcentrates_Commodity'
'Bovine Meat'.'AggregateFeedConcentrates_Commodity'
'Onions'.'AggregateFeedConcentrates_Commodity'
*'Pulses'.'AggregateFeedConcentrates_Commodity'
'Apples and products'.'AggregateFeedConcentrates_Commodity'
'Barley and products'.'AggregateFeedConcentrates_Commodity'
'Beans'.'AggregateFeedConcentrates_Commodity'
*'Brans'.'AggregateFeedConcentrates_Commodity'
'Cassava and products'.'AggregateFeedConcentrates_Commodity'
*'Cereals - Excluding Beer'.'AggregateFeedConcentrates_Commodity'
'Cereals, Other'.'AggregateFeedConcentrates_Commodity'
'Cocoa Beans and products'.'AggregateFeedConcentrates_Commodity'
'Coconuts - Incl Copra'.'AggregateFeedConcentrates_Commodity'
'Copra Cake'.'AggregateFeedConcentrates_Commodity'
'Cottonseed Cake'.'AggregateFeedConcentrates_Commodity'
*'Fruits - Excluding Wine'.'AggregateFeedConcentrates_Commodity'
'Fruits, Other'.'AggregateFeedConcentrates_Commodity'
'Groundnut Cake'.'AggregateFeedConcentrates_Commodity'
'Groundnuts (in Shell Eq)'.'AggregateFeedConcentrates_Commodity'
*'Groundnuts (Shelled Eq)'.'AggregateFeedConcentrates_Commodity'
'Maize and products'.'AggregateFeedConcentrates_Commodity'
'Millet and products'.'AggregateFeedConcentrates_Commodity'
*'Oilcrops'.'AggregateFeedConcentrates_Commodity'
'Oilcrops Oil, Other'.'AggregateFeedConcentrates_Commodity'
'Oilcrops, Other'.'AggregateFeedConcentrates_Commodity'
'Oilseed Cakes, Other'.'AggregateFeedConcentrates_Commodity'
'Olive Oil'.'AggregateFeedConcentrates_Commodity'
'Olives (including preserved)'.'AggregateFeedConcentrates_Commodity'
'Oranges, Mandarines'.'AggregateFeedConcentrates_Commodity'
'Palm Oil'.'AggregateFeedConcentrates_Commodity'
'Palmkernel Cake'.'AggregateFeedConcentrates_Commodity'
'Peas'.'AggregateFeedConcentrates_Commodity'
'Potatoes and products'.'AggregateFeedConcentrates_Commodity'
'Pulses, Other and products'.'AggregateFeedConcentrates_Commodity'
'Rape and Mustard Cake'.'AggregateFeedConcentrates_Commodity'
'Rape and Mustard Oil'.'AggregateFeedConcentrates_Commodity'
'Rape and Mustardseed'.'AggregateFeedConcentrates_Commodity'
*'Rice (Milled Equivalent)'.'AggregateFeedConcentrates_Commodity'
'Rice (Paddy Equivalent)'.'AggregateFeedConcentrates_Commodity'
*'Roots & Tuber Dry Equiv'.'AggregateFeedConcentrates_Commodity'
'Roots, Other'.'AggregateFeedConcentrates_Commodity'
'Rye and products'.'AggregateFeedConcentrates_Commodity'
'Sesameseed Cake'.'AggregateFeedConcentrates_Commodity'
'Sesameseed Oil'.'AggregateFeedConcentrates_Commodity'
'Sorghum and products'.'AggregateFeedConcentrates_Commodity'
'Soyabean Cake'.'AggregateFeedConcentrates_Commodity'
'Soyabean Oil'.'AggregateFeedConcentrates_Commodity'
'Soyabeans'.'AggregateFeedConcentrates_Commodity'
'Spices'.'AggregateFeedConcentrates_Commodity'
*'Starchy Roots'.'AggregateFeedConcentrates_Commodity'
*'Stimulants'.'AggregateFeedConcentrates_Commodity'
*'Sugar & Sweeteners'.'AggregateFeedConcentrates_Commodity'
'Sugar (Raw Equivalent)'.'AggregateFeedConcentrates_Commodity'
*'Sugar Crops'.'AggregateFeedConcentrates_Commodity'
*'Sugar, Raw Equivalent'.'AggregateFeedConcentrates_Commodity'
*'Sugar, Refined Equiv'.'AggregateFeedConcentrates_Commodity'
*"Sugar, Refined Equiv (sugar cane)".'AggregateFeedConcentrates_Commodity'
*"Sugar, Refined Equiv (sugar beet)".'AggregateFeedConcentrates_Commodity'
'Sunflowerseed Cake'.'AggregateFeedConcentrates_Commodity'
'Sweeteners, Other'.'AggregateFeedConcentrates_Commodity'
'Tomatoes and products'.'AggregateFeedConcentrates_Commodity'
*'Vegetable Oils'.'AggregateFeedConcentrates_Commodity'
*'Vegetables'.'AggregateFeedConcentrates_Commodity'
'Vegetables, Other'.'AggregateFeedConcentrates_Commodity'
'Wheat and products'.'AggregateFeedConcentrates_Commodity'
'Butter, Ghee'.'AggregateFeedConcentrates_Commodity'
'Cheese'.'AggregateFeedConcentrates_Commodity'
'Eggs'.'AggregateFeedConcentrates_Commodity'
'Fats, Animals, Raw'.'AggregateFeedConcentrates_Commodity'
'Fish Meal'.'AggregateFeedConcentrates_Commodity'
'Fish, Body Oil'.'AggregateFeedConcentrates_Commodity'
'Fish, Liver Oil'.'AggregateFeedConcentrates_Commodity'
*'Fish, Seafood'.'AggregateFeedConcentrates_Commodity'
'Honey'.'AggregateFeedConcentrates_Commodity'
'Marine Fish, Other'.'AggregateFeedConcentrates_Commodity'
*'Meat'.'AggregateFeedConcentrates_Commodity'
'Meat Meal'.'AggregateFeedConcentrates_Commodity'
'Meat, Other'.'AggregateFeedConcentrates_Commodity'
*'Milk - Excluding Butter'.'AggregateFeedConcentrates_Commodity'
'Milk, Skimmed'.'AggregateFeedConcentrates_Commodity'
'Milk, Whole'.'AggregateFeedConcentrates_Commodity'
'Molluscs, Other'.'AggregateFeedConcentrates_Commodity'
'Mutton & Goat Meat'.'AggregateFeedConcentrates_Commodity'
'Offals'.'AggregateFeedConcentrates_Commodity'
*'Offals, Edible'.'AggregateFeedConcentrates_Commodity'
'Whey'.'AggregateFeedConcentrates_Commodity'
/;

Set Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities,Commodities_2) "Matches the commodities used as feed to the main feed groups, separating main and byprod for concentrates (ConcMainProd, ConcByProd, Forage, Grass, Residues)"
/
*the commodities excluded are aggregates/double counting - see excel-file NutrientFactors_CommoditySetCorrespondence
*the items highlighted blue inthe commodity list
'Bananas'.'AggregateFeedConcMainProd_Commodity'
'Cloves'.'AggregateFeedConcMainProd_Commodity'
'Cottonseed'.'AggregateFeedConcMainProd_Commodity'
'Dates'.'AggregateFeedConcMainProd_Commodity'
'Oats'.'AggregateFeedConcMainProd_Commodity'
'Palm kernels'.'AggregateFeedConcMainProd_Commodity'
'Sesame seed'.'AggregateFeedConcMainProd_Commodity'
'Sugar beet'.'AggregateFeedConcMainProd_Commodity'
'Sugar cane'.'AggregateFeedConcMainProd_Commodity'
'Sunflower seed'.'AggregateFeedConcMainProd_Commodity'
'Sweet potatoes'.'AggregateFeedConcMainProd_Commodity'
'Yams'.'AggregateFeedConcMainProd_Commodity'
'Turnips for fodder'.'AggregateFeedConcMainProd_Commodity'
'Aquatic Plants'.'AggregateFeedConcMainProd_Commodity'
*'Aquatic Products, Other'.'AggregateFeedConcMainProd_Commodity'
'Cephalopods'.'AggregateFeedConcMainProd_Commodity'
'Crustaceans'.'AggregateFeedConcMainProd_Commodity'
'Demersal Fish'.'AggregateFeedConcMainProd_Commodity'
'Freshwater Fish'.'AggregateFeedConcMainProd_Commodity'
'Pelagic Fish'.'AggregateFeedConcMainProd_Commodity'
'Maize For Forage+Silage'.'AggregateFeedForageCrops_Commodity '
'Alfalfa For Forage+Silag'.'AggregateFeedForageCrops_Commodity '
'Clover For Forage+Silage'.'AggregateFeedForageCrops_Commodity '
'Leguminous Nes,For+Sil'.'AggregateFeedForageCrops_Commodity '
'Beets For Fodder'.'AggregateFeedConcMainProd_Commodity'
'Swedes For Fodder'.'AggregateFeedConcMainProd_Commodity'
'Temporary meadows and pastures'.'AggregateFeedGrass_Commodity '
'Permanent meadows and pastures'.'AggregateFeedGrass_Commodity '
'Cabbage, for forage'.'AggregateFeedForageCrops_Commodity '
'Other grasses, for forage'.'AggregateFeedForageCrops_Commodity '
'Rye grass, for forage'.'AggregateFeedForageCrops_Commodity '
'Sorghum, for forage'.'AggregateFeedForageCrops_Commodity '
'Molasses'.'AggregateFeedConcByProd_Commodity'
"Molasses (sugar cane)".'AggregateFeedConcByProd_Commodity'
"Molasses (sugar beet)".'AggregateFeedConcByProd_Commodity'
'Plantains'.'AggregateFeedConcMainProd_Commodity'
'Sugar non-centrifugal'.'AggregateFeedConcMainProd_Commodity'
*'Animal fats'.'AggregateFeedConcByProd_Commodity'
'Bovine Meat'.'AggregateFeedConcMainProd_Commodity'
'Onions'.'AggregateFeedConcMainProd_Commodity'
*'Pulses'.'AggregateFeedConcMainProd_Commodity'
'Apples and products'.'AggregateFeedConcMainProd_Commodity'
'Barley and products'.'AggregateFeedConcMainProd_Commodity'
'Beans'.'AggregateFeedConcMainProd_Commodity'
*'Brans'.'AggregateFeedConcByProd_Commodity'
'Cassava and products'.'AggregateFeedConcMainProd_Commodity'
*'Cereals - Excluding Beer'.'AggregateFeedConcMainProd_Commodity'
'Cereals, Other'.'AggregateFeedConcMainProd_Commodity'
'Cocoa Beans and products'.'AggregateFeedConcMainProd_Commodity'
'Coconuts - Incl Copra'.'AggregateFeedConcMainProd_Commodity'
'Copra Cake'.'AggregateFeedConcByProd_Commodity'
'Cottonseed Cake'.'AggregateFeedConcByProd_Commodity'
*'Fruits - Excluding Wine'.'AggregateFeedConcMainProd_Commodity'
'Fruits, Other'.'AggregateFeedConcMainProd_Commodity'
'Groundnut Cake'.'AggregateFeedConcByProd_Commodity'
'Groundnuts (in Shell Eq)'.'AggregateFeedConcMainProd_Commodity'
*'Groundnuts (Shelled Eq)'.'AggregateFeedConcMainProd_Commodity'
'Maize and products'.'AggregateFeedConcMainProd_Commodity'
'Millet and products'.'AggregateFeedConcMainProd_Commodity'
*'Oilcrops'.'AggregateFeedConcMainProd_Commodity'
'Oilcrops Oil, Other'.'AggregateFeedConcMainProd_Commodity'
'Oilcrops, Other'.'AggregateFeedConcMainProd_Commodity'
'Oilseed Cakes, Other'.'AggregateFeedConcByProd_Commodity'
'Olive Oil'.'AggregateFeedConcMainProd_Commodity'
'Olives (including preserved)'.'AggregateFeedConcMainProd_Commodity'
'Oranges, Mandarines'.'AggregateFeedConcMainProd_Commodity'
'Palm Oil'.'AggregateFeedConcMainProd_Commodity'
'Palmkernel Cake'.'AggregateFeedConcByProd_Commodity'
'Peas'.'AggregateFeedConcMainProd_Commodity'
'Potatoes and products'.'AggregateFeedConcMainProd_Commodity'
'Pulses, Other and products'.'AggregateFeedConcMainProd_Commodity'
'Rape and Mustard Cake'.'AggregateFeedConcByProd_Commodity'
'Rape and Mustard Oil'.'AggregateFeedConcMainProd_Commodity'
'Rape and Mustardseed'.'AggregateFeedConcMainProd_Commodity'
*'Rice (Milled Equivalent)'.'AggregateFeedConcMainProd_Commodity'
'Rice (Paddy Equivalent)'.'AggregateFeedConcMainProd_Commodity'
*'Roots & Tuber Dry Equiv'.'AggregateFeedConcMainProd_Commodity'
'Roots, Other'.'AggregateFeedConcMainProd_Commodity'
'Rye and products'.'AggregateFeedConcMainProd_Commodity'
'Sesameseed Cake'.'AggregateFeedConcByProd_Commodity'
'Sesameseed Oil'.'AggregateFeedConcMainProd_Commodity'
'Sorghum and products'.'AggregateFeedConcMainProd_Commodity'
'Soyabean Cake'.'AggregateFeedConcMainProd_Commodity'
'Soyabean Oil'.'AggregateFeedConcByProd_Commodity'
'Soyabeans'.'AggregateFeedConcMainProd_Commodity'
'Spices'.'AggregateFeedConcMainProd_Commodity'
*'Starchy Roots'.'AggregateFeedConcMainProd_Commodity'
*'Stimulants'.'AggregateFeedConcMainProd_Commodity'
*'Sugar & Sweeteners'.'AggregateFeedConcMainProd_Commodity'
'Sugar (Raw Equivalent)'.'AggregateFeedConcMainProd_Commodity'
*'Sugar Crops'.'AggregateFeedConcMainProd_Commodity'
*'Sugar, Raw Equivalent'.'AggregateFeedConcMainProd_Commodity'
*'Sugar, Refined Equiv'.'AggregateFeedConcMainProd_Commodity'
*"Sugar, Refined Equiv (sugar cane)".'AggregateFeedConcMainProd_Commodity'
*"Sugar, Refined Equiv (sugar beet)".'AggregateFeedConcMainProd_Commodity'
'Sunflowerseed Cake'.'AggregateFeedConcByProd_Commodity'
'Sweeteners, Other'.'AggregateFeedConcMainProd_Commodity'
'Tomatoes and products'.'AggregateFeedConcMainProd_Commodity'
*'Vegetable Oils'.'AggregateFeedConcMainProd_Commodity'
*'Vegetables'.'AggregateFeedConcMainProd_Commodity'
'Vegetables, Other'.'AggregateFeedConcMainProd_Commodity'
'Wheat and products'.'AggregateFeedConcMainProd_Commodity'
'Butter, Ghee'.'AggregateFeedConcMainProd_Commodity'
'Cheese'.'AggregateFeedConcMainProd_Commodity'
'Eggs'.'AggregateFeedConcMainProd_Commodity'
'Fats, Animals, Raw'.'AggregateFeedConcByProd_Commodity'
'Fish Meal'.'AggregateFeedConcByProd_Commodity'
'Fish, Body Oil'.'AggregateFeedConcByProd_Commodity'
'Fish, Liver Oil'.'AggregateFeedConcByProd_Commodity'
*'Fish, Seafood'.'AggregateFeedConcMainProd_Commodity'
'Honey'.'AggregateFeedConcMainProd_Commodity'
'Marine Fish, Other'.'AggregateFeedConcMainProd_Commodity'
*'Meat'.'AggregateFeedConcMainProd_Commodity'
'Meat Meal'.'AggregateFeedConcByProd_Commodity'
'Meat, Other'.'AggregateFeedConcMainProd_Commodity'
*'Milk - Excluding Butter'.'AggregateFeedConcMainProd_Commodity'
'Milk, Skimmed'.'AggregateFeedConcMainProd_Commodity'
'Milk, Whole'.'AggregateFeedConcMainProd_Commodity'
'Molluscs, Other'.'AggregateFeedConcMainProd_Commodity'
'Mutton & Goat Meat'.'AggregateFeedConcMainProd_Commodity'
'Offals'.'AggregateFeedConcByProd_Commodity'
*'Offals, Edible'.'AggregateFeedConcByProd_Commodity'
'Whey'.'AggregateFeedConcByProd_Commodity'
/;

Set Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities,Commodities_2) "Matches the commodities used as feed to the main feed groups, using the groups used for the detailed feeding rations calculations"
/
#Commodities_Feed                  .AggregateFeedTotal_Commodity
#Commodities_Feed_Grass            .AggregateFeedGrass_Commodity
#Commodities_Feed_NoForageNoGrass  .AggregateFeedNoForageNoGrass_Commodity
#Commodities_Feed_ForageCrops      .AggregateFeedForageCrops_Commodity
#Commodities_Feed_Cereals          .AggregateFeedCereals_Commodity
#Commodities_Feed_OilCropsAndCakes .AggregateFeedOilCropsAndCakes_Commodity
#Commodities_Feed_Pulses           .AggregateFeedPulses_Commodity
#Commodities_Feed_Roots            .AggregateFeedRoots_Commodity
#Commodities_Feed_Sugar            .AggregateFeedSugar_Commodity
#Commodities_Feed_OthersPlants     .AggregateFeedOtherPlant_Commodity
#Commodities_Feed_OthersAnimals    .AggregateFeedOtherAnimal_Commodity
#Commodities_Feed_Residues         .AggregateFeedResidues_Commodity
/;

*14.8) Sets related to energy production

Set ConversionLevel Primary or secondary energy
/
"Primary Energy"
"Secondary Energy"
/;

Set EnergyType Type of energy (electricity heat etc.)
/
AllEnTypes
Electricity
Gases
Heat
Hydrogen
Liquids
/;

Set EnergySource Energy source (biomass fossil etc.)
/
AllEnSources
Biomass
"Modern Biomass"
"Modern Biomass CCS"
"Modern Biomass noCCS"
"Traditional Biomass"
Miscanthus
"Forest and crop residues"
"Coal"
"Coal CCS"
"Coal noCCS"
"Fossil"
"Fossil CCS"
"Fossil noCCS"
"Gas"
"Gas CCS"
"Gas noCCS"
"Oil"
"Oil CCS"
"Oil noCCS"
"Geothermal"
"Hydro"
"Nuclear"
"Solar"
"Wind"
"Non-biomass renewables"
"EtOH residues"
/;

Set EnergyChar   Characteristics of the energy production (quantity or emissions etc.)
/
"Production (EJ)"
"N from Bioe residues (tN)"
"GHG emissions (t CO2e)"
"Bioe conversion Biomass input (tDM)"
/;












