PUTCLOSE con,"_V6_Sets_GeneralModelSets_ForSteeringFile2";

$ontext;
GENERAL DESCRIPTION
This file declares all the sets needed in the model.

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
           the sets 14.1-14.3 are also needed to read in data
         14.4) Sets related to mineral fertilizers
         14.5) Sets related to population and human nutrition
         14.6) Sets related to feeding rations
         14.7) Some auxiliary matching sets for reading data (to be defined here and not further up, as they refer to the set Activities and Commodities)
         14.8) Sets related to energy production
- 15) Sets for the commodity trees

the following sets are declared below:


*for SteeringFile2, it is enough to declare the sets, they are then red from the output from SteeringFile1
$offtext;
Set InputsCropsGrass       "Captures the different inputs to the crop and grass activities, i.e. all mass and nutrient flows that are used by the activity; examples are seeds, fertilizer, land, etc. "
Set InputsAnimals          "Captures the different inputs to the animal activities, i.e. all mass and nutrient flows that are used by the activity; examples are feed, drinking water, etc. "
Set InputsFishSeafood      "Captures the different inputs to the fish and seafood activities, i.e. all mass and nutrient flows that are used by the activity; examples are feed, mangrove area, etc. "
Set InputsForest           "Captures the different inputs to the forest activities, i.e. all mass and nutrient flows that are used by the activity; examples are energy for logging, etc. "
Set InputsOther            "Captures the different inputs to the other activities, i.e. all mass and nutrient flows that are used by the activity;"
Set OutputsCropsGrass      "Captures the different outputs from the crop and grass activities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. MainOutput1 from Wheat (i.e. grains), Straw, Roots, etc., but also emissions, losses, etc."
         Set YieldsCropsGrass(OutputsCropsGrass)       "Captures the yields from the crop and grassactivities - unit: biomass per ha"
Set OutputsAnimals         "Captures the different outputs from the animal activities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. meat, milk, manure, etc., but also emissions, losses, etc."
         Set YieldsAnimals(OutputsAnimals)          "Captures the different yields from the animal activities - units: biomass per head or APU"
Set OutputsFishSeafood     "Captures the different outputs from the fish and seafood activities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. Meat, but also emissions, losses, etc."
Set OutputsForest          "Captures the different outputs from the forest activities, i.e. all mass and nutrient flows that result from an activity; thus, this covers e.g. wood, etc., but also emissions, losses, etc."
Set OutputsOther           "Captures the different outputs from the other activities, i.e. all mass and nutrient flows that result from an activity;"
Set OtherCharCropsGrass    "Characteristics of the crop or grass activity being undertaken that cannot be captured well by mass/nutrient flows; this can be the biodiversity loss or deforestation, but also monetary flows, etc."
         set OtherCharCropsGrass_PerHaBased(OtherCharCropsGrass)
         set OtherCharCropsGrass_PerTonYieldBased(OtherCharCropsGrass)
Set OtherCharAnimals       "Characteristics of the animal activity being undertaken that cannot be captured well by mass/nutrient flows; this can be animal welfare aspects, but also monetary flows, etc."
         Set OtherCharAnimals_PerHeadBAsed(OtherCharAnimals)
Set OtherCharFishSeafood   "Characteristics of the fish and seafood activity being undertaken that cannot be captured well by mass/nutrient flows; this can be seabed destruction, but also monetary flows, etc."
Set OtherCharForest        "Characteristics of the forest activity being undertaken that cannot be captured well by mass/nutrient flows; this can be biodiversity loss, but also monetary flows, etc."
Set OtherCharOther         "Characteristics of the other activity being undertaken that cannot be captured well by mass/nutrient flows;"
Set AnimalTypeInHerd       "captures the different types of animals that are needed to build a full animal production unit, or a herd structure (i.e. with a dairy cow, there are several calfes of different age, sires, etc. )"
         Set AnimalTypeInHerd_NoAggregates(AnimalTypeInHerd) "Subset of AnimalTypeInherd used to sum up to get the total amount of living animals - avoiding double counting by excluding AllAndAverageTypes, etc. - thus only relevant for animals with herd structure"
         Set CattleTypeInHerd(AnimalTypeInHerd)
         Set DairyCattleTypeInHerd(AnimalTypeInHerd)
         Set BeefCattleTypeInHerd(AnimalTypeInHerd)
         Set PigTypeInHerd(AnimalTypeInHerd)
         Set ProducingAnimals(AnimalTypeInHerd) "Subset of AnimalTypeInHerd containing producing animals only"
         Set SuckledAnimals(AnimalTypeInHerd) "Subset of AnimalTypeInHerd that is suckled"
         alias(AnimalTypeInHerd,AnimalTypeInHerd_2);
         Set MatchSucklingSuckledAnimals(AnimalTypeInHerd,AnimalTypeInHerd_2) "Matching suckling and suckled AnimalTypeInHerd"

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
         Set UtilSharesNOTFeed(CommodOtherChar)     "all utilizsation shares BESIDES feed"
Set CropResContents        "Captures nutrient contents of crop residues"
Set CropResOtherChar       "Captures other characteristics of crop residues"
Set CropResManagement      "Various parameters related to crop residue management - e.g. emissions, N losses, etc."
         Set CropResManagement_NotSystemShares(CropResManagement) "Same as Set CropResManagement but without 'Quantity share in CropResMan system' "
Set CropResManSystem       "Crop residue management systems"
         Set CropResManSystemCropland(CropResManSystem) "all crop residue management systems from which crop residues can then be used on croplands (or grasslands as well) as it is centrally collected, or on croplands, as it is left there"
         Set CropResManSystemGrassland(CropResManSystem) "all crop residue management systems from which crop residues can then be used on graslands"
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

         Set FAO_Africa(Regions)
         Set FAO_Eastern_Africa(Regions)
         Set FAO_Middle_Africa(Regions)
         Set FAO_Northern_Africa(Regions)
         Set FAO_Southern_Africa(Regions)
         Set FAO_Western_Africa(Regions)
         Set FAO_Americas(Regions)
         Set FAO_Northern_America(Regions)
         Set FAO_Central_America(Regions)
         Set FAO_Caribbean(Regions)
         Set FAO_South_America(Regions)
         Set FAO_Asia(Regions)
         Set FAO_Central_Asia(Regions)
         Set FAO_Eastern_Asia(Regions)
         Set FAO_Southern_Asia(Regions)
         Set FAO_SouthEastern_Asia(Regions)
         Set FAO_Western_Asia(Regions)
         Set FAO_Europe(Regions)
         Set FAO_Eastern_Europe(Regions)
         Set FAO_Northern_Europe(Regions)
         Set FAO_Southern_Europe(Regions)
         Set FAO_Western_Europe(Regions)
         Set FAO_Oceania(Regions)
         Set FAO_Australia_NewZealand(Regions)
         Set FAO_Melanesia(Regions)
         Set FAO_Micronesia(Regions)
         Set FAO_Polynesia(Regions)
         Set FAO_EuropeanUnion(Regions)
         Set SubSaharanAfrica(Regions)
         Set Match_GeographicAggregates_SingleCountries(Regions,Regions_2)

         Set FOFA2050_Rest_of_EAP(Regions)
         Set FOFA2050_Rest_of_HIC(Regions)
         Set FOFA2050_Rest_of_LAC(Regions)
         Set FOFA2050_Rest_of_MNA(Regions)
         Set FOFA2050_Rest_of_SAS(Regions)
         Set FOFA2050_Rest_of_SSA(Regions)
         Set FOFA2050_Rest_of_EU(Regions)
         Set FOFA2050_Rest_of_ECA(Regions)

         Set Regions_Switzerland(regions)
         Set Regions_Austria(regions)
         Set Regions_Austria_Tal(regions)
         Set Regions_Austria_Huegel(regions)
         Set Regions_Austria_Berg(regions)

         Set NonEU_RestOfTheWorld(Regions)

Set Activities             "Set containing all activities used in the model - inclusive aggregates and sub-activities"
         alias(Activities,Activities_2)
         set Livestock(Activities) "Subset containing all livestock activities"
         set Livestock_NoAggregates(Activities) "Subset containing all livestock activities - and no aggregates such as 'sheep and goats'"
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
         Set Crops_NoNFixingLegumes(Activities)
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
         Set CoreFoodCrops(Activities) "subset containint core food crops (also excluding sugar crops)"
         Set CoreFoodCrops_NoCereals(Activities) "subset containing core food crops without cereals(also excluding sugar crops)"
         Set GrassActivities(Activities) "Subset containing all grass activities"
         Set CoreGrassActivities(Activities) "Subset containing the key grass activities - no auxiliary ones for filing in data, etc."
         Set CoreGrassActivitiesNoTEMPGrass(Activities) "Subset containing the key PERMANENT grass activities - no auxiliary ones for filing in data, etc."
         Set TempMeadAndPastures(Activities) "Subset containing temporary meadows and pastures"
         Set TempAndPermMeadAndPastures(Activities) "Subset containing temporary and permanent meadows and pastures - thus covering all grasslands based on two categories from FAOSTAT"
         Set CropsAndCoreGrassActivities(Activities) "Subset of all agricultural area based activities, i.e. containing all Crops and GrassActivities"
         Set CropsAndTempGrassActivities(Activities)  "Subset of all crop plus temporary grass activities";
         Set SingleCropGrassAndLivestockActivities(Activities) Subset of single activities without aggregates - both crops and livestock

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
         Set Commodities_SingleCommodities(Commodities) "Subset containing single commodities only - no additional aggregates;"
*                description continued: but some commodities may be listed twice, e.g. Pork and Pigmeat, etc., some may be aggregates from the original data (e.g. vegetables) - but usually only one of them then has an entry, I think."
         Set Commodities_FeedGroups(Commodities)
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
         Set COmmodities_EquivalentToNonGrassFedAnimalActivityOutput(Commodities) Commodities that are equivalent to the output of animal activities from animals WITHOUT grass in their feeding ration
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
         Set MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_CropsDerived(Commodities,Commodities_2)  "Matching the derived commodities that are derived from primary commodities as captured in the previous set - DAQ and trade calculations for them are different than for the other derived commodities)"
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
         Set BasisyearsOLD(Years);
         Set Basisyears(Years);
         Set BasisyearsSeed(Years);
Set Temperatures "Set of temperature values in degree Celcius - to be used for manure management emissions calculations, for example, etc."
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
*this file is not needed here and cannot be defined, due to the FAOSTAT-Set, thus drop
*Set MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Activities)
Set Match_ActivityOutputsToCommodities_Crops(Activities,OutputsCropsGrass,Commodities) "Set to link the main outputs from the crop activities to commodities, that can then be further worked with on commodity level"
Set Match_ActivityOutputsToCommodities_Animals(Activities,OutputsAnimals,Commodities) "Set to link the main outputs from the animal activities to commodities, that can then be further worked with on commodity level"
Set Match_FeedCommoditiesToFeedCommodGroups(Commodities,Commodities_2) "Matches the commodities used as feed to the four main feed groups (Conc, Forage, Grass, Residues)"
Set Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities,Commodities_2) "Matches the commodities used as feed to the main feed groups, separating main and byprod for concentrates (ConcMainProd, ConcByProd, Forage, Grass, Residues)"
Set Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities,Commodities_2) "Matches the commodities used as feed to the main feed groups, using the groups used for the detailed feeding rations calculations"

Set ConversionLevel Primary or secondary energy
Set EnergyType Type of energy (electriccity heat etc.)
Set EnergySource Energy source (biomass fossil etc.)
Set EnergyChar   Characteristics of the energy production (quantity or emissions etc.)

Set Scenarios
Set FOFA2050_Scenarios(Scenarios)
Set BioeSR15_Scenarios(Scenarios)


$ontext;
matching needed: activity.main outputs and corresponding commodities.

May do some specific paraleters/sets such as detailed feeding ratiion - which is noly used intermediate, also micro nutr supply feed - e.g. for Ollies model...

THEN check whether it runs
Then link read data to these common par, var, sets

then start doing model code.


Still to be done in FAOSTAT_CropProduction: look for STBD!!!!!


FILE XXXXXXXXXXX Go on 15)
$offtext;

*here come the matching sets:
*Set1
set SubsetCommod_MatchWithAct_AggregateCommodities(Commodities)
set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass) "Set with the cases where commodities correspond to an aggregate of some non primary commodities"

*This captures the cases where commodities correspond to an aggregate of some non primary commodities -
*for prim prod quantities of outputs from activities, we thus need to disaggregate and to translate the commodities to the outputs from activities via commodity trees
*contains crop commodities only, hence only one file needed for crops

*Set2
set SubsetCommod_MatchWithAct_AggregateActivities(Commodities)
set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass) "Set with the cases where commodities correspond to prim prod outputs of aggregate activities"

*This captures the cases where commodities correspond to prim prod outputs of aggregate activities and thus need to be allocated to outputs from single activities
*contains crop commodities only, hence only one file needed for crops

*Set3
set SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities)
set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass) "Set matching activities and commodities for the cases of well defined coproducts"
*This captures the cases of well defined coproducts
*contains crop commodities only, hence only one file needed for crops

*Set4
set SubsetCommod_MatchWithAct_ComplexCases(Commodities)
set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass) "Set matching activities and commodities for the most complex cases such as fats and alcohol"
*This captures the most complex cases such as fats and alcohol
*contains crop commodities only, hence only one file needed for crops

*Set5
set SubsetCommod_MatchWithAct_ComplexAnimalCommodities(Commodities)
set MatchCommAct_ComplexAnimalCommodities(Commodities,Activities,OutputsAnimals) "Set matching activities and commodities for the more complex animal commodities"
*This covers the more complex animal commodities
*contains animal commodities only, hence only one file needed for animals

*Set6
set SubsetCommod_MatchWithAct_CommodEquivalentAct(Commodities)
set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass) "Set covering all crop commodities that are equivalent to main outputs from activities"
set MatchCommAct_CommodEquivalentAct_Animals(Commodities,Activities,OutputsAnimals) "Set covering all animal commodities that are equivalent to main outputs from activities"
*This captures all commodities that are equivalent to main outputs from activities

*Set7
set SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct(Commodities)
set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass) "Set matching activities and commodities for all commodities that are captured together with their derived products and expressed in primary product equivalents"

*and we also need the product/coproduct relations:
*Define subsets of all the commodities as follows: main products on level 1, co-products on level 1, main products on level 2, co-products on level 2
*then define an additional set that captures the main product - co-product pairings (or, in few cases: triplets)
*this results in the following sets:
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Main(Commodities)
*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 1 and that are MAIN Commodities there (e.g. "Starch")
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Co(Commodities)
*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 1 and that are CO-Commodities to the main ones there (e.g. "Wheat brans")
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level2_Main(Commodities)
*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 2 and that are MAIN Commodities there (e.g. "Gluten")
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level2_Co(Commodities)
*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 2 and that are CO-Commodities to the main ones there (e.g. "Wheat brans")
*Matching of main and co-products:
set MatchMainWithCoProd_WellDefinedCoProducts_Level1(Commodities,Commodities_2)
set MatchMainWithCoProd_WellDefinedCoProducts_Level2(Commodities,Commodities_2)
*some products have two byproducts, collect them separately:
alias(Commodities,Commodities_3);
set MatchMainWithCoPr_WellDefCoProd_Level1And2_TwoByprod(Commodities,Commodities_2,Commodities_3)
*another matching set, used e.g. to derive biomass in shells, etc. - used for bioenergy
Set Match_ShellsEtc_Activities(Activities, Commodities)


*some sets needed for UNISECO SESSIT tool
Set Match_Countries_NUTS2(Regions,Regions_2)
Set NUTS2_Regions(Regions)


$exit;
