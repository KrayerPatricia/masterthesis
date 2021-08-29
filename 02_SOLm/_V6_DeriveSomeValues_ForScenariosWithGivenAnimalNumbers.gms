PUTCLOSE con,"_V6_DeriveSomeValues_ForScenariosWithGivenAnimalNumbers";

*GENERAL DESCRIPTION
*This file contains the derivations of certain values for scenarios where animal numbers are given.
*for scenarios where animal numbers are given, we need some further calculations to derive supply/demand ration, etc. - to be used in other scenarios that build on them.
*this is e.g. the case for scenarios that build on FOFA_BAU_2050 as a reference, which is calculated by filing in the given animal numbers thus invalidating the baseline feed supply/demand values.
*this is done by re-running _V6_BaselineValues_ForModelRuns, but for the repsective scenario


*MOST of the code is not needed, hence displayed as comments
*part of it that may be needed but are currently not are indicated with MAYBE NEEDED - so search for this when you need them
*currently run are lines 691-849, 883-940 and 1002-1163

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Do some Baseline calculations that are needed for the scenarios (e.g. to derive single crop shares in total crop groups, etc.)
         1.1) Total crop production
         1.2) Commodities
         1.3) derive some sums of activities that we need in the baseline
         1.4) some further values
- 2) Nutrient requirements
- 3) Utilization of DAQ and Some further commodity-related calculations
- 4) Feed supply
         4.1) Feed supply from DAQ
         4.2) Feed supply demand ratio
         4.3) Share of animals in requirements per feed group
         4.4) Calculations for detailed feeding rations calculations
- 5) Suckled animals
- 6) Values needed to adjust min fer quantities in the scenarios
- 7) Some simplification of fertilizer application emission values
- 8) Corrections of some errors
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
$ontext;
*1) Do some Baseline calculations that are needed for the scenarios (e.g. to derive single crop shares in total crop groups, etc.)

*1.1) Total production
VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*                 $(NOT VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");

*we spotted some small errors in the data, such as Bhutan and Tuvalu reporting some minor Banana production without having the cropping areas reported, thus do the following consistency condition:
VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline"))
         = 0;

VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");
*the previous: Seed quantity, for example


*for animals:
VActAnimalsHead_Outputs_MR.l(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*                 $(NOT VActAnimalsHead_Outputs_MR.l(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,ProducingAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");

*delete errors: e.g. output reported in FAOSTAT while no animal numbers are reported:
VActAnimalsHead_Outputs_MR.l(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,ProducingAnimals,ProductionSystems,ProductionConditions,"Baseline"))
         = 0;

VActAnimalsHead_Outputs_MR.l(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT VActAnimalsHead_Outputs_MR.l(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,ProducingAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");

*and do it for APU: for Honey:
VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,"Honey producing",ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"Baseline");

VActAnimalsAPU_Outputs_MR.l(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*                 $(NOT VActAnimalsAPU_Outputs_MR.l(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"))
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,ProducingAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");





*1.2) Commodities

*Production of primary products as commodities
*Use the sets Match_ActivityOutputsToCommodities_Crops(Activities,OutputsCropsGrass,Commodities)
*to link production from activities to primary commodities PRODUCTION level (not DAQ) - equal the activity outputa to these commodities by these matching sets.
*Derive DAQ by adding imports, subtracting exports and accounting for stock changes
*these are then the quantities for the primary products, - all processed (e.g. wheat flour from wheat) can then be derived from this basis

*use an auxiliary variable to assure that all primary commod are calculated and no old values already present is used for them (e.g. Yams in Brazil - not proceeding like this results in some discrepacy between activity-derived Yams production and DAQ derived values drom FAOSTAT):
AUX_VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*                 $(NOT VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline"))
         = sum((Activities,OutputsCropsGrass)$Match_ActivityOutputsToCommodities_Crops(Activities,OutputsCropsGrass,Commodities),
                 VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
*similarly for commodities derived from animal activities:
VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline"))
         = sum((Activities,OutputsAnimals,ProducingAnimals)$Match_ActivityOutputsToCommodities_Animals(Activities,OutputsAnimals,Commodities),
                 VActAnimalsHead_Outputs_MR.l(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));


*we spotted some small errors in the data, such as Djibuti reporting some minor Dates production on commodity level without having the cropping areas reported, thus do the following consistency condition:
*for the following to work, we first need some aggregates though:
VActCropsGrass_Outputs_MR.l(Regions,"All other citrus",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(CitrusFruits,VActCropsGrass_Outputs_MR.l(Regions,CitrusFruits,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"))
                 - VActCropsGrass_Outputs_MR.l(Regions,"Oranges",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
                 - VActCropsGrass_Outputs_MR.l(Regions,"Lemons and limes",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");
VActCropsGrass_Outputs_MR.l(Regions,"All Fruits",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Fruits,VActCropsGrass_Outputs_MR.l(Regions,Fruits,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"Other Cereals",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(OtherCereals,VActCropsGrass_Outputs_MR.l(Regions,OtherCereals,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

VActCropsGrass_Outputs_MR.l(Regions,"All other oilcrops",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(OtherOilcrops,VActCropsGrass_Outputs_MR.l(Regions,OtherOilcrops,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All other roots",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(StarchyRoots,VActCropsGrass_Outputs_MR.l(Regions,StarchyRoots,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"Rape and Mustard seed",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs_MR.l(Regions,"Rapeseed",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
                 + VActCropsGrass_Outputs_MR.l(Regions,"Mustard seed",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");

VActCropsGrass_Outputs_MR.l(Regions,"Jute & Jute-like Fibres",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(FibresNotCotton,VActCropsGrass_Outputs_MR.l(Regions,FibresNotCotton,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All other soft fibres",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(FibresNotCotton,VActCropsGrass_Outputs_MR.l(Regions,FibresNotCotton,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All other hard fibres",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(FibresNotCotton,VActCropsGrass_Outputs_MR.l(Regions,FibresNotCotton,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

VActCropsGrass_Outputs_MR.l(Regions,"All Spices",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Spices,VActCropsGrass_Outputs_MR.l(Regions,Spices,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All other Spices",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Spices,VActCropsGrass_Outputs_MR.l(Regions,Spices,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All other vegetables",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(OtherVegetables,VActCropsGrass_Outputs_MR.l(Regions,OtherVegetables,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

VActCropsGrass_Outputs_MR.l(Regions,"Pulses,Total",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Pulses,VActCropsGrass_Outputs_MR.l(Regions,Pulses,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

VActCropsGrass_Outputs_MR.l(Regions,"All sugar crops",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(SugarCrops,VActCropsGrass_Outputs_MR.l(Regions,SugarCrops,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

*some inconsistencies can arise in case there is commod prod reported, but no ActCropsGrass_Outputs - as e.g. for oilcrops, other in Costa Rica, thus first correct as follows:
VCommod_Production_MR.l(Regions,CommoditiesDAQ_TradeFromToWorldPrimaryCrops,ProductionSystems,ProductionConditions,"Baseline")
                 $(sum((Activities,OutputsCropsGrass)$MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsPrimary(CommoditiesDAQ_TradeFromToWorldPrimaryCrops,Activities,OutputsCropsGrass),
                          VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")) = 0)
         = 0;

*now reassign the animal commodities and those that are not assigned by this code above, based on activity outputs
VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline"))
         = AUX_VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline");

*some inconsistencies can arise in case there is commod prod reported, but no ActCropsGrass_Outputs - as e.g. for oilcrops, other in Costa Rica, thus first correct as follows:
*that's the same as above - thus not needed, is it?
VCommod_Production_MR.l(Regions,CommoditiesDAQ_TradeFromToWorldPrimaryCrops,ProductionSystems,ProductionConditions,"Baseline")
         $(NOT sum((Activities,OutputsCropsGrass)$MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsPrimary(CommoditiesDAQ_TradeFromToWorldPrimaryCrops,Activities,OutputsCropsGrass),
                         VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")))
         = 0;


*and similar for animal commodities:
*first, again, we need some aggregates:
VActAnimalsHead_Outputs_MR.l(Regions,"All Animals",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Livestock_NoAggregates,VActAnimalsHead_Outputs_MR.l(Regions,Livestock_NoAggregates,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));
VActAnimalsHead_Outputs_MR.l(Regions,"Cattle and buffaloes",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsHead_Outputs_MR.l(Regions,"Cattle",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Buffaloes",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");
VActAnimalsHead_Outputs_MR.l(Regions,"Sheep and Goats",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsHead_Outputs_MR.l(Regions,"Sheep",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Goats",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");
*"All other animals"
*2735."Meat, Other"
*        "Default composition: 1089 Meat, bird nes, 1097 Meat, horse, 1108 Meat, ass, 1111 Meat, mule, 1127 Meat, camel, 1141 Meat, rabbit, 1151 Meat, other rodents,
*        1158 Meat, other camelids, 1163 Meat, game, 1164 Meat, dried nes, 1166 Meat, nes, 1172 Meat, nes, preparations, 1176 Snails, not sea"
VActAnimalsHead_Outputs_MR.l(Regions,"All other Animals",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsHead_Outputs_MR.l(Regions,"Animals live nes",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Asses",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Camelids, other",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Camels",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Horses",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Mules",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Pigeons, other birds",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Rabbits and hares",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Game",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Rodents, other",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");
*"poultry birds"
*2734."Poultry Meat"
*        "Default composition: 1058 Meat, chicken, 1060 Fat, liver prepared (foie gras), 1061 Meat, chicken, canned, 1069 Meat, duck, 1073 Meat, goose and guinea fowl, 1080 Meat, turkey"
VActAnimalsHead_Outputs_MR.l(Regions,"Poultry birds",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsHead_Outputs_MR.l(Regions,"Chickens",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Ducks",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Geese and guinea fowls",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Turkeys",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l(Regions,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals,ProductionSystems,ProductionConditions,"Baseline")
         $(NOT sum((Activities,ProducingAnimals,OutputsAnimals)$MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsPrimary(CommoditiesDAQ_TradeFromToWorldPrimaryAnimals,Activities,OutputsAnimals),
                         VActAnimalsHead_Outputs_MR.l(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")))
         = 0;

*for honey:
VCommod_Production_MR.l(Regions,"Honey",ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsAPU_Outputs_MR.l(Regions,"Beehives", "Honey producing","Honey (t)",ProductionSystems,ProductionConditions,"Baseline");


*fish and seafood: keep the production, as there is currently no animal numbers, etc. behind it:
VCommod_Production_MR.l(Regions,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"Baseline")
         = AUX_VCommod_Production_MR.l(Regions,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"Baseline");


*assuming that on average, stock changes are zero (and this fits to the philosophy of our model that captures biophysical equilibria situations regarding food production and use),
*we also recalculate the DAQ for the baseline as done for the scenarios: without stock changes:
*now we can do the DAQ = prod+imp-Exp for the primary commodities - this is then the basis for deriving the derived commodity production plus the imp/exp/DAQ calculations for those
*this results in some discrepancy with the FAOSTAT data - but it makes the baseline and baseline derived consistent, as it is difficult to derive stock changes for the baseline derived (and as there is no focus on this value - different to prod/imp and exp).
VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 + VImportQuantity_MR.l(Regions,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 - VExportQuantity_MR.l(Regions,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline");
*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 $(VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline") < 0)
         = 0;

*AUX_VImportQuantity_MR.l(Regions_MR,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Regions_MR_2,VImportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities,ProductionSystems,ProductionConditions,"Baseline"));
*AUX_VExportQuantity_MR.l(Regions_MR,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Regions_MR_2,VExportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities,ProductionSystems,ProductionConditions,"Baseline"));
AUX_VImportQuantity_MR.l("World","World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Regions_MR,VImportQuantity_MR.l(Regions_MR,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline"));
AUX_VExportQuantity_MR.l("World","World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline"));

Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"Baseline")
                 $AUX_VImportQuantity_MR.l("World","World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = AUX_VExportQuantity_MR.l("World","World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 /AUX_VImportQuantity_MR.l("World","World",Commodities,ProductionSystems,ProductionConditions,"Baseline");




*derive contents in the primary commodities:
VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,"Baseline")
*currently, no values available, hence this condition does not work and is neither needed
*                 $(NOT VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,"Baseline"))
         = VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 *Commod_Contents_MR(Regions,Commodities,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,"Baseline");
$offtext;

$ontext;
Already a comment in the original file for the baseline:
with util shares it is not yet doing well....
VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,"Baseline")
*currently, no values available, hence this condition does not work and is neither needed
*                 $(NOT VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,"Baseline"))
         = VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 *Commod_OtherChar_MR(Regions,Commodities,"Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                          *Commod_Contents_MR(Regions,Commodities,ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterFeed,ProductionSystems,ProductionConditions,"Baseline")
*currently, no values available, hence this condition does not work and is neither needed
*                 $(NOT VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterFeed,ProductionSystems,ProductionConditions,"Baseline"))
         = VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 *Commod_OtherChar_MR(Regions,Commodities,"Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")
                          *Commod_Contents_MR(Regions,Commodities,ContentsPerFreshMatterFeed,ProductionSystems,ProductionConditions,"Baseline");
$offtext;
$ontext;

*1.3) derive some sums of activities that we need in the baseline
*these sums are needed for deriving imp/exp values in the scenarios - they are used for scaling, not for aggregate quantities - hence the partly maybe not fully correct assignments (summing over all fruits for fruits fresh, nes, etc.
*part is already done above - hence the parts included as comments only
VActCropsGrass_Outputs_MR.l(Regions,"Bananas and plantains",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs_MR.l(Regions,"Bananas",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
                 + VActCropsGrass_Outputs_MR.l(Regions,"Plantains and others",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");
*VActCropsGrass_Outputs_MR.l(Regions,"Rape and Mustard seed",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         = VActCropsGrass_Outputs_MR.l(Regions,"Rapeseed",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*                 + VActCropsGrass_Outputs_MR.l(Regions,"Mustard seed",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");
VActCropsGrass_Outputs_MR.l(Regions,"Grass",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs_MR.l(Regions,"Temporary meadows and pastures",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
                 + VActCropsGrass_Outputs_MR.l(Regions,"Permanent meadows and pastures",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");
VActCropsGrass_Outputs_MR.l(Regions,"All crops",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Crops,VActCropsGrass_Outputs_MR.l(Regions,Crops,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All cereals",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Cereals,VActCropsGrass_Outputs_MR.l(Regions,Cereals,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
*VActCropsGrass_Outputs_MR.l(Regions,"Pulses,Total",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Pulses,VActCropsGrass_Outputs_MR.l(Regions,Pulses,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

VActCropsGrass_Outputs_MR.l(Regions,"All other sugar sources",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(SugarCrops,VActCropsGrass_Outputs_MR.l(Regions,SugarCrops,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All other sugar sources",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(SugarCrops,VActCropsGrass_Outputs_MR.l(Regions,SugarCrops,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
*VActCropsGrass_Outputs_MR.l(Regions,"All Fruits",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Fruits,VActCropsGrass_Outputs_MR.l(Regions,Fruits,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All Vegetables",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Vegetables,VActCropsGrass_Outputs_MR.l(Regions,Vegetables,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
*VActCropsGrass_Outputs_MR.l(Regions,"All other Spices",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Spices,VActCropsGrass_Outputs_MR.l(Regions,Spices,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
*VActCropsGrass_Outputs_MR.l(Regions,"All Spices",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Spices,VActCropsGrass_Outputs_MR.l(Regions,Spices,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

*VActCropsGrass_Outputs_MR.l(Regions,"Other Cereals",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(OtherCereals,VActCropsGrass_Outputs_MR.l(Regions,OtherCereals,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"Citrus Fruits",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(CitrusFruits,VActCropsGrass_Outputs_MR.l(Regions,CitrusFruits,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
*assume the following to be citrus without oranges and lemons
*VActCropsGrass_Outputs_MR.l(Regions,"All other citrus",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(CitrusFruits,VActCropsGrass_Outputs_MR.l(Regions,CitrusFruits,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"))
*                 - VActCropsGrass_Outputs_MR.l(Regions,"Oranges",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*                 - VActCropsGrass_Outputs_MR.l(Regions,"Lemons and limes",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");

*VActCropsGrass_Outputs_MR.l(Regions,"All other oilcrops",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(OtherOilcrops,VActCropsGrass_Outputs_MR.l(Regions,OtherOilcrops,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All Oilcrops",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Oilcrops,VActCropsGrass_Outputs_MR.l(Regions,Oilcrops,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

VActCropsGrass_Outputs_MR.l(Regions,"All spices",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Spices,VActCropsGrass_Outputs_MR.l(Regions,Spices,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All Nuts",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Treenuts,VActCropsGrass_Outputs_MR.l(Regions,Treenuts,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

VActCropsGrass_Outputs_MR.l(Regions,"Roots and tubers,Total",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(StarchyRoots,VActCropsGrass_Outputs_MR.l(Regions,StarchyRoots,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All roots and tubers",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(StarchyRoots,VActCropsGrass_Outputs_MR.l(Regions,StarchyRoots,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
*VActCropsGrass_Outputs_MR.l(Regions,"All other roots",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(StarchyRoots,VActCropsGrass_Outputs_MR.l(Regions,StarchyRoots,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_Outputs_MR.l(Regions,"All starchy roots",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(StarchyRoots,VActCropsGrass_Outputs_MR.l(Regions,StarchyRoots,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

*VActCropsGrass_Outputs_MR.l(Regions,"Jute & Jute-like Fibres",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(FibresNotCotton,VActCropsGrass_Outputs_MR.l(Regions,FibresNotCotton,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
*VActCropsGrass_Outputs_MR.l(Regions,"All other soft fibres",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(FibresNotCotton,VActCropsGrass_Outputs_MR.l(Regions,FibresNotCotton,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
*VActCropsGrass_Outputs_MR.l(Regions,"All other hard fibres",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(FibresNotCotton,VActCropsGrass_Outputs_MR.l(Regions,FibresNotCotton,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

*VActCropsGrass_Outputs_MR.l(Regions,"All other vegetables",OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(OtherVegetables,VActCropsGrass_Outputs_MR.l(Regions,OtherVegetables,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

VActAnimalsHead_Outputs_MR.l(Regions,"All Ruminants",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Ruminants,VActAnimalsHead_Outputs_MR.l(Regions,Ruminants,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));
VActAnimalsHead_Outputs_MR.l(Regions,"All Poultry",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Poultry,VActAnimalsHead_Outputs_MR.l(Regions,Poultry,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));
*VActAnimalsHead_Outputs_MR.l(Regions,"All Animals",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Livestock_NoAggregates,VActAnimalsHead_Outputs_MR.l(Regions,Livestock_NoAggregates,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));
VActAnimalsHead_Outputs_MR.l(Regions,"All Fish and Seafood",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         =sum(FishAndSeafood,VActAnimalsHead_Outputs_MR.l(Regions,FishAndSeafood,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));



*the following are not yet assigned:
*"All crops producing oilseed cake"



*We need the "Sugar crops" aggregate for deriving Molasse later in the code, as this is not yet available:
VCommod_Quantity_MR.l(Regions,"Sugar crops",ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions,"Sugar beet",ProductionSystems,ProductionConditions,"Baseline")
                 + VCommod_Quantity_MR.l(Regions,"Sugar cane",ProductionSystems,ProductionConditions,"Baseline");
VExportQuantity_MR.l(Regions,"World","Sugar crops",ProductionSystems,ProductionConditions,"Baseline")
         = VExportQuantity_MR.l(Regions,"World","Sugar beet",ProductionSystems,ProductionConditions,"Baseline")
                 + VExportQuantity_MR.l(Regions,"World","Sugar cane",ProductionSystems,ProductionConditions,"Baseline");


*1.4) some further values

AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
                 $VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = 1/VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline"));

AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                 $VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
         = 1/VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline");

VExportQuantity_MR.l("World","World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline"));

AUX_Inverse_VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                 $VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
         = 1/VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline"));

VActCropsGrass_Outputs_MR.l("World",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Regions_MR,VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

VExportQuantity_MR.l("World","World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline"));

AUX_ProdPlusImport_VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
         =sum((Activities,OutputsCropsGrass)$MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,Activities,OutputsCropsGrass),
                 VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"))
                         + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l("World","Beer",ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"Baseline"));

VCommod_Production_MR.l("World","Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline"));

VCommod_Production_MR.l("World","Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline"));

VCommod_Production_MR.l("World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline"));

VCommod_Production_MR.l("World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline"));


AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 $VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = 1/VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline"));

VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions_MR,"Milk, whole",ProductionSystems,ProductionConditions,"Baseline")
           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh buffalo",ProductionSystems,ProductionConditions,"Baseline")
           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh cow",ProductionSystems,ProductionConditions,"Baseline")
           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh goat",ProductionSystems,ProductionConditions,"Baseline")
           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh sheep",ProductionSystems,ProductionConditions,"Baseline");

AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"Baseline")
                 $VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"Baseline")
         = 1/VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"Baseline");

VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"Baseline")
         = VExportQuantity_MR.l(Regions_MR,"World","Milk, whole",ProductionSystems,ProductionConditions,"Baseline")
           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh buffalo",ProductionSystems,ProductionConditions,"Baseline")
           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh cow",ProductionSystems,ProductionConditions,"Baseline")
           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh goat",ProductionSystems,ProductionConditions,"Baseline")
           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh sheep",ProductionSystems,ProductionConditions,"Baseline");

VExportQuantity_MR.l("World","World","Milk",ProductionSystems,ProductionConditions,"Baseline")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"Baseline"));

AUX_Inverse_VExportQuantity_MR.l("World","World","Milk",ProductionSystems,ProductionConditions,"Baseline")
                 $VExportQuantity_MR.l("World","World","Milk",ProductionSystems,ProductionConditions,"Baseline")
         = 1/VExportQuantity_MR.l("World","World","Milk",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline"));

VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"Baseline")
         = sum(Fruits,VActCropsGrass_QuantityActUnits_MR.l(Regions,Fruits,ProductionSystems,ProductionConditions,"Baseline"))
                 + sum(Vegetables,VActCropsGrass_QuantityActUnits_MR.l(Regions,Vegetables,ProductionSystems,ProductionConditions,"Baseline"))
                 + sum(Pulses,VActCropsGrass_QuantityActUnits_MR.l(Regions,Pulses,ProductionSystems,ProductionConditions,"Baseline"))
                 + sum(Oilcrops,VActCropsGrass_QuantityActUnits_MR.l(Regions,Oilcrops,ProductionSystems,ProductionConditions,"Baseline"))
                 + 0.2*sum(TempMeadAndPastures,VActCropsGrass_QuantityActUnits_MR.l(Regions,TempMeadAndPastures,ProductionSystems,ProductionConditions,"Baseline"));

AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"Baseline")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"Baseline")
         = 1 / VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"Baseline");

AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 $VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = 1/VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline"));

VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions_MR,"Bovine Meat",ProductionSystems,ProductionConditions,"Baseline")
           + VCommod_Quantity_MR.l(Regions_MR,"Poultry meat",ProductionSystems,ProductionConditions,"Baseline")
           + VCommod_Quantity_MR.l(Regions_MR,"Pigmeat",ProductionSystems,ProductionConditions,"Baseline")
           + VCommod_Quantity_MR.l(Regions_MR,"Meat, Other",ProductionSystems,ProductionConditions,"Baseline");

*use the auxiliary variable as already derived for the crops to make the code faster:
AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
                 $VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
         = 1/VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline");

VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"Baseline")
         = VExportQuantity_MR.l(Regions_MR,"World","Bovine Meat",ProductionSystems,ProductionConditions,"Baseline")
           + VExportQuantity_MR.l(Regions_MR,"World","Poultry meat",ProductionSystems,ProductionConditions,"Baseline")
           + VExportQuantity_MR.l(Regions_MR,"World","Pigmeat",ProductionSystems,ProductionConditions,"Baseline")
           + VExportQuantity_MR.l(Regions_MR,"World","Meat, Other",ProductionSystems,ProductionConditions,"Baseline");

VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"Baseline"));

AUX_Inverse_VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
                 $VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
         = 1/VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline"));

AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
                 $VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = 1/VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline"));

VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions_MR,"Bovine Meat",ProductionSystems,ProductionConditions,"Baseline")
           + VCommod_Quantity_MR.l(Regions_MR,"Poultry meat",ProductionSystems,ProductionConditions,"Baseline")
           + VCommod_Quantity_MR.l(Regions_MR,"Pigmeat",ProductionSystems,ProductionConditions,"Baseline")
           + VCommod_Quantity_MR.l(Regions_MR,"Meat, Other",ProductionSystems,ProductionConditions,"Baseline");

AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
                 $VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
         = 1/VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline");

VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"Baseline")
         = VExportQuantity_MR.l(Regions_MR,"World","Bovine Meat",ProductionSystems,ProductionConditions,"Baseline")
           + VExportQuantity_MR.l(Regions_MR,"World","Poultry meat",ProductionSystems,ProductionConditions,"Baseline")
           + VExportQuantity_MR.l(Regions_MR,"World","Pigmeat",ProductionSystems,ProductionConditions,"Baseline")
           + VExportQuantity_MR.l(Regions_MR,"World","Meat, Other",ProductionSystems,ProductionConditions,"Baseline");

VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"Baseline"));

AUX_Inverse_VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
                 $VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
         = 1/VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline"));

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Nutrient requirements

*derive FeedME req for dairy cows based on yields and milk solid contents
*factor 1000 as the formula is for yields in kg milk, but yields are in tons currently
*SOURCE for this? And what is the factor 83?? - Ask Simon!!
ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","FeedME_Req_MilkProd (MJ)",ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_Outputs_MR(Regions,"Cattle","Milk producing","Milk (t)",ProductionSystems,ProductionConditions,"Baseline")*1000
                 *Commod_Contents_MR(Regions,"Milk, Whole","Milk solid contents (t)",ProductionSystems,ProductionConditions,"Baseline")
                        *83;

*derive FeedMe req for dairy cow maintenance
*below, liveweight *1000 as the formulae are for kg, and the liveweight is in tons
*condition on the presence of liveweight values to avoid that the requirement is assigned via the term "14" only, also if there is no further data available.
*SOURCE for this? And what are the terms 14 and 0.09?? - Ask Simon!!
ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Maintenance (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 $ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Liveweight (t)",ProductionSystems,ProductionConditions,"Baseline")
         = (14 + 0.09*ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Liveweight (t)",ProductionSystems,ProductionConditions,"Baseline")*1000)*365;

*derive FeedMe req for dairy cow walking
*SOURCE for this? And what are the terms 2 and *1*2?? - Ask Simon!! 2: likely MJ per km; 1 and 2: km wlaked in summer/winter (but winter is quite high, then?).
ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Walking (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 $ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProductionSystems,ProductionConditions,"Baseline")
                 *2*ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","DailyWalkingDistance (km)",ProductionSystems,ProductionConditions,"Baseline")
         + (365 - ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProductionSystems,ProductionConditions,"Baseline"))
                 *1*2;

*derive FeedMe req for dairy cow pregnancy
*below, liveweight *1000 as the formulae are for kg, and the liveweight is in tons
*condition on the presence of liveweight values to avoid that the requirement is assigned via the term "1575" only, also if there is no further data available.
*SOURCE for this? And what are the terms 1575 and 3.5?? - Ask Simon!! 2: likely MJ per km; 1 and 2: km wlaked in summer/winter (but winter is quite high, then?).
ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Pregnancy (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 $ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Liveweight (t)",ProductionSystems,ProductionConditions,"Baseline")
         = 1575 + 3.5*ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Liveweight (t)",ProductionSystems,ProductionConditions,"Baseline")*1000;

*sum the above terms to get FeedME requirements of dairy cows:
*condition on the presence of liveweight values to avoid that the requirement is assigned also if one of the liveweight-related terms is missing (this likely being the case, whern there are no animals in a country).
ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Total (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 $ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Liveweight (t)",ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","FeedME_Req_MilkProd (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 + ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Maintenance (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 + ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Walking (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 + ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Pregnancy (MJ)",ProductionSystems,ProductionConditions,"Baseline");

*derive FeedXP requirements for all animals from FeedME requirements:
*division by 1000000 to get from gXP to tXP
*condition to avoid that this overwrites other existing values (for chicken and horse, for example), in particular if no convesion factor ME to XP is given.
*ATTENTION: CHECK CONDITION - or assure that XP is only around already, when it is better than the values derived here!!
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedXP_Req_Total (t)",ProductionSystems,ProductionConditions,"Baseline")
                 $(ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"XPperME_InFeedReq (gXP/MJ)",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedXP_Req_Total (t)",ProductionSystems,ProductionConditions,"Baseline")))
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedME_Req_Total (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"XPperME_InFeedReq (gXP/MJ)",ProductionSystems,ProductionConditions,"Baseline")/1000000;

*derive FeedGE requirements from ME requirements:
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 $((ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"Digestibility of Feed (%)",ProductionSystems,ProductionConditions,"Baseline")/100
                         - ActAnimalsHead_OtherChar_MR(Regions,Activities,"AllAndAverageTypes","UE_per_GE (share)",ProductionSystems,ProductionConditions,"Baseline"))
                 AND NOT ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"Baseline"))
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedME_Req_Total (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 /(ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"Digestibility of Feed (%)",ProductionSystems,ProductionConditions,"Baseline")/100
                         - ActAnimalsHead_OtherChar_MR(Regions,Activities,"AllAndAverageTypes","UE_per_GE (share)",ProductionSystems,ProductionConditions,"Baseline"));

*derive Feed requirements per feed group:
*for this, use the DM shares to derive GE shares - will be roughly ok:
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 *FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline");
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 *FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline");
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 *FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline");
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 *FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline");


MAYBE NEEDED?
*totals per country and animal type:
*the animal numbers for animals other than cattle and pigs come with TypeInHerd "Living", thus assign this to "AllandAverageTypes", as otherwise, multiplication with the parameter where this type is used results in zero values
VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"Baseline"))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,"Living",ProductionSystems,ProductionConditions,"Baseline");

VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"Baseline")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
                         *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"Baseline");
VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"Baseline")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
                         *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"Baseline");
VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"Baseline")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
                         *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"Baseline");
VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"Baseline")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
                         *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"Baseline");

$offtext;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Utilization of DAQ and Some further commodity-related calculations
$ontext;
VCommod_Food_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*                 $(NOT VCommod_Food_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline"))
         = VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                  *Commod_OtherChar_MR(Regions,Commodities,"Util food (share)",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*                 $(NOT VCommod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline"))
         = VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                  *Commod_OtherChar_MR(Regions,Commodities,"Util feed (share)",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Seed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*                 $(NOT VCommod_Seed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline"))
         = VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                  *Commod_OtherChar_MR(Regions,Commodities,"Util seed (share)",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Processing_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*                 $(NOT VCommod_Processing_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline"))
         = VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                  *Commod_OtherChar_MR(Regions,Commodities,"Util processing (share)",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Waste_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*                 $(NOT VCommod_Waste_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline"))
         = VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                  *Commod_OtherChar_MR(Regions,Commodities,"Util waste (share)",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Other_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*                 $(NOT VCommod_Other_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline"))
         = VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                  *Commod_OtherChar_MR(Regions,Commodities,"Util other (share)",ProductionSystems,ProductionConditions,"Baseline");
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Feed supply

*4.1) Feed supply from DAQ
*derive total quantities per utilization; on the level of domestically available quantities, and based on DAQ and utilization shares;
*another path of calculations is to start from these quantities and then to derive the shares rather via division by total DAQ
*this is in fresh matter

*thus, here: derive Feed from DAQ*FeedUtil
*and DAQ is Prod+Imp-Exp in the TotalProdDAQ-module
* - both still to be done...



$ontext;
NO - NOT NEEDED - ALREADY calculated at the end of core model eq to derive animal nummbers
*XXX NEW MAY 2021
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%");
$offtext;


*Sum over commodities to get the total supply per feed group:
*First, for all concentrates together
VCommod_Feed_MR.l(Regions,Commodities_2,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions,Commodities_2,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities$Match_FeedCommoditiesToFeedCommodGroups(Commodities,Commodities_2),
                 VCommod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"%Scenario%"));
*Then, for main and byprod concentrates separately
VCommod_Feed_MR.l(Regions,Commodities_2,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions,Commodities_2,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities$Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities,Commodities_2),
                 VCommod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"%Scenario%"));

*Dry matter and GE, ME and XP quantities:
VCommod_Feed_Contents_MR.l(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions,Commodities,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions,Commodities,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions,Commodities,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions,Commodities,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions,Commodities,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions,Commodities,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%");
*and again summed over feed groups:
VCommod_Feed_Contents_MR.l(Regions,Commodities_2,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions,Commodities_2,Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities$Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities,Commodities_2),
                 VCommod_Feed_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%"));
*and add the main and byprod concentrates:
VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedConcentrates_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedConcMainProd_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedConcByProd_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%");

*and summed for the total:
VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedTotal_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedTotal_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities,
                 VCommod_Feed_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%"));


*Feed GE and XP contents per DM
*derive Feed GE and XP contents per DM for the feed commodities, feed groups and total feed:
Commod_Contents_MR(Regions,Commodities,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

Commod_Contents_MR(Regions,Commodities,"FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

*feed groups separately, as they are usually not part of Commodities_MR
Commod_Contents_MR(Regions,Commodities_FeedGroups,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions,Commodities_FeedGroups,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_FeedGroups,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions,Commodities_FeedGroups,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

Commod_Contents_MR(Regions,Commodities_FeedGroups,"FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions,Commodities_FeedGroups,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_FeedGroups,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions,Commodities_FeedGroups,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");



*4.2) Feed supply demand ratio
*derive the ration of feed supplied and demanded per country and feed group:

*derive Feed GE and XP requirements per feed group:
*we have the DM shares and the GE/XP contents of the feed groups, so we can derive the shares in total GE and XP (and DM is already given by the original feeding rations).
$ontext;
how to derive the GE shares in feeding rations if DM shares are given:
Total DM is allocated according to DM shares,

Thus: DM quantities are Total_DM*DM_share_A, etc.
The GE quantity in this is Total_DM*DM_share_A*GE_cont_A, etc.

where:
DM_share_A, DM_share_B, DM_share_C
GE_cont_A, GE_cont_B, GE_cont_C
are the DM shares and GE contents of feed group A, B and C
$offtext;
*Thus, we first need to derive total DM requirements
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_Contents_MR(Regions,"AggregateFeedTotal_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /Commod_Contents_MR(Regions,"AggregateFeedTotal_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");


*first, per country demand:
VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((Livestock,AnimalTypeInHerd),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRations_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((Livestock,AnimalTypeInHerd),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRations_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((Livestock,AnimalTypeInHerd),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRations_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((Livestock,AnimalTypeInHerd),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRations_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));

VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((Livestock,AnimalTypeInHerd),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"));


Commod_OtherChar_MR(Regions,"AggregateFeedConcentrates_Commodity","Feed GE supply/demand ratio Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedConcentrates_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,"AggregateFeedForageCrops_Commodity","Feed GE supply/demand ratio Forage",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedForageCrops_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,"AggregateFeedGrass_Commodity","Feed GE supply/demand ratio Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedGrass_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,"AggregateFeedResidues_Commodity","Feed GE supply/demand ratio Residues",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedResidues_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,"AggregateFeedTotal_Commodity","Feed GE supply/demand ratio Total",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedTotal_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");


*4.3) Share of animals in requirements per feed group
*derive the share of animals in total feed requirements per feed group:
ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_OtherChar_MR.l(Regions,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_OtherChar_MR.l(Regions,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                  $VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_OtherChar_MR.l(Regions,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                  /VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Residues",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_OtherChar_MR.l(Regions,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"Share in FeedGE_Req_Total",ProductionSystems,ProductionConditions,"%Scenario%")
                  $VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_OtherChar_MR.l(Regions,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                  /VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");


$ontext;

*we calculate non-grass-fed animal numbers based on concentrates LEFT AFTER FEEDING ruminants, hence do the supply/demand ration needed there also already in the baseline:
VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedConcentrates_Commodity","FeedGE (MJ) - left after feeding ruminants",ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedConcentrates_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 *(1-sum((Ruminants,AnimalTypeInHerd),
                         ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")))
*add the feed from grass-fed and non-grass-fed animal commodities, asthey are largely used for non-ruminants only: e.g. whey, meat meal:
         + sum(CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,VCommod_Feed_Contents_MR.l(Regions,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"Baseline"))
         + sum(CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,VCommod_Feed_Contents_MR.l(Regions,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"Baseline"))

         + sum(CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NonGrassFed,VCommod_Feed_Contents_MR.l(Regions,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NonGrassFed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"Baseline"))
         + sum(CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,VCommod_Feed_Contents_MR.l(Regions,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"Baseline"));

VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedForageCrops_Commodity","FeedGE (MJ) - left after feeding ruminants",ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedForageCrops_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                 *(1-sum((Ruminants,AnimalTypeInHerd),
                         ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"Baseline")));

VActAnimalsHead_OtherChar_MR.l(Regions,"All NonRuminants","AllAndAverageTypes","FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"Baseline")
         =sum((NoNRuminants,AnimalTypeInHerd),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions,NoNRuminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
                         *ActAnimalsHead_OtherChar_MR(Regions,NoNRuminants,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"Baseline")
                                 *FeedingRations_OtherChar_MR(Regions,NoNRuminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline"));


Commod_OtherChar_MR(Regions,"AggregateFeedConcentrates_Commodity","Feed GE supply/demand ratio Conc - left after feeding ruminants",ProductionSystems,ProductionConditions,"Baseline")
                 $VActAnimalsHead_OtherChar_MR.l(Regions,"All NonRuminants","AllAndAverageTypes","FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedConcentrates_Commodity","FeedGE (MJ) - left after feeding ruminants",ProductionSystems,ProductionConditions,"Baseline")
                 /VActAnimalsHead_OtherChar_MR.l(Regions,"All NonRuminants","AllAndAverageTypes","FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"Baseline");

$offtext;

*4.4) Calculations for detailed feeding rations calculations

*then derive the needed average values for the feed groups needed:
VCommod_Feed_MR.l(Regions,"AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Grass,VCommod_Feed_MR.l(Regions,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%"));
VCommod_Feed_MR.l(Regions,"AggregateFeedCereals_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Cereals,VCommod_Feed_MR.l(Regions,Commodities_Feed_Cereals,ProductionSystems,ProductionConditions,"%Scenario%"));

*and again summed over feed groups:
VCommod_Feed_MR.l(Regions,Commodities_FeedGroups_DetailedFeedingRations,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_MR.l(Regions,Commodities_FeedGroups_DetailedFeedingRations,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_Feed$Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_Feed,Commodities_FeedGroups_DetailedFeedingRations),
                 VCommod_Feed_MR.l(Regions,Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%"));

VCommod_Feed_Contents_MR.l(Regions,Commodities_FeedGroups_DetailedFeedingRations,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions,Commodities_FeedGroups_DetailledFeedingRations,Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_Feed$Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_Feed,Commodities_FeedGroups_DetailedFeedingRations),
                 VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed,Contents,ProductionSystems,ProductionConditions,"%Scenario%"));


*Derive default DETAILED feeding rations: take the rations on commod group level from the original version (grass, forage, concentrates, residues) and allocate according to relative commod shares in relevant commod groups (as used for the DETAILED feeding rations) in DAQ for Feed.
*And use some additional assumptions, as whey for pigs, milk for cows, more oilcrops for chickens and more cereals for pigs, etc.
*relevant feed groups are the following: Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_Feed,Commodities_FeedGroups_DetailedFeedingRations)

Commod_OtherChar_MR(Regions,Commodities_Feed_Grass,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedGrass_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed_Grass,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedGrass_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,Commodities_Feed_ForageCrops,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedForageCrops_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed_ForageCrops,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedForageCrops_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,Commodities_Feed_NoForageNoGrass,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedNoForageNoGrass_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed_NoForageNoGrass,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedNoForageNoGrass_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
*add better values in case available by not useing more refined groups:
*use the corresponding aggregates and sets as used in the following matching set:
*Set Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities,Commodities_2) "Matches the commodities used as feed to the main feed groups, using the groups used for the detailed feeding rations calculations"
*/
*#Commodities_Feed                  .AggregateFeedTotal_Commodity
*#Commodities_Feed_Grass            .AggregateFeedGrass_Commodity
*#Commodities_Feed_NoForageNoGrass  .AggregateFeedNoForageNoGrass_Commodity
*#Commodities_Feed_ForageCrops      .AggregateFeedForageCrops_Commodity
*#Commodities_Feed_Cereals          .AggregateFeedCereals_Commodity
*#Commodities_Feed_OilCropsAndCakes .AggregateFeedOilCropsAndCakes_Commodity
*#Commodities_Feed_Pulses           .AggregateFeedPulses_Commodity
*#Commodities_Feed_Roots            .AggregateFeedRoots_Commodity
*#Commodities_Feed_Sugar            .AggregateFeedSugar_Commodity
*#Commodities_Feed_OthersPlants     .AggregateFeedOtherPlant_Commodity
*#Commodities_Feed_OthersAnimals    .AggregateFeedOtherAnimal_Commodity
*/;

Commod_OtherChar_MR(Regions,Commodities_Feed_Cereals,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedCereals_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed_Cereals,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedCereals_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,Commodities_Feed_OilCropsAndCakes,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedOilCropsAndCakes_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed_OilCropsAndCakes,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedOilCropsAndCakes_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,Commodities_Feed_Pulses,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedPulses_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed_Pulses,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedPulses_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,Commodities_Feed_Roots,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedRoots_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed_Roots,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedRoots_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,Commodities_Feed_Sugar,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedSugar_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed_Sugar,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedSugar_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,Commodities_Feed_OthersPlants,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedOtherPlant_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed_OthersPlants,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedOtherPlant_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions,Commodities_Feed_OthersAnimals,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedOtherAnimal_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed_OthersAnimals,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedOtherAnimal_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");


*thus, for grass and forage, it looks as follows:
*the condition is needed to avoid overwriting more detailed values, if available
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions,Commodities_Feed_Grass,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions,Commodities_Feed_ForageCrops,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%");



*residues is currently no issue
*for concentrates, which currently captures all else, we thus base it on the sum of the rest:
*#Commodities_Feed_NoForageNoGrass  .AggregateFeedNoForageNoGrass_Commodity
*the condition is needed to avoid overwriting more detailed values, if available
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions,Commodities_Feed_NoForageNoGrass,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%");


*add better values in case available by not useing more refined groups:
*use the corresponding aggregates and sets as used in thh following matching set (cf. just above):
*Set Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities,Commodities_2) "Matches the commodities used as feed to the main feed groups, using the groups used for the detailed feeding rations calculations"
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Cereals,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions,Commodities_Feed_Cereals,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_OilCropsAndCakes,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedOilCropsAndCakes_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions,Commodities_Feed_OilCropsAndCakes,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Pulses,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedPulses_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions,Commodities_Feed_Pulses,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Roots,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedRoots_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions,Commodities_Feed_Roots,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Sugar,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedsugar_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions,Commodities_Feed_Sugar,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_OthersPlants,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedOtherPlant_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions,Commodities_Feed_OthersPlants,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_OthersAnimals,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedOtherAnimal_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions,Commodities_Feed_OthersAnimals,"DM share in relevant feed group",ProductionSystems,ProductionConditions,"%Scenario%");



$ontext;
*The following has been needed for the baseline only, no adjustment needed here, as we have explicit data for the scenarios or take it from the baseline:
*adapt feeding rations concentrates and residues!! e.g. more soy for chicken, more cereals for pigs, etc.
*first, sum over feed groups:
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_FeedGroups_DetailedFeedingRations,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed$Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_Feed,Commodities_FeedGroups_DetailedFeedingRations),
                 FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));

*for pigs, oilcrops and cakes should be 25% of the sum of cereals and oil crops, and cereals 75%;
*for chickens, oilcrops and cakes should be 40% of the sum of cereals and oil crops, and cereals 60%
*$ontext;
*thus:
*ShareCommod_i_InGroup1(New) = ShareCommod_i_InGroup1(Old)*0.25*(Sum_i[ShareCommod_i_InGroup1(Old)] + Sum_j[ShareCommod_j_InGroup2(Old)]) / Sum_i[ShareCommod_i_InGroup1(Old)]
*etc.
*$offtext;

FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,Commodities_Feed_Cereals,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,Commodities_Feed_Cereals,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *0.75*(FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 +FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,"AggregateFeedOilCropsAndCakes_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"))
                 /FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,Commodities_Feed_OilCropsAndCakes,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,"AggregateFeedOilCropsAndCakes_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,Commodities_Feed_OilCropsAndCakes,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *0.25*(FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 +FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,"AggregateFeedOilCropsAndCakes_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"))
                 /FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",AnimalTypeInHerd,"AggregateFeedOilCropsAndCakes_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,Commodities_Feed_Cereals,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,Commodities_Feed_Cereals,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *0.60*(FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 +FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,"AggregateFeedOilCropsAndCakes_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"))
                 /FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,Commodities_Feed_OilCropsAndCakes,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,"AggregateFeedOilCropsAndCakes_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,Commodities_Feed_OilCropsAndCakes,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *0.40*(FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 +FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,"AggregateFeedOilCropsAndCakes_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"))
                 /FeedingRationsHeads_OtherChar_MR(Regions,"Chickens",AnimalTypeInHerd,"AggregateFeedOilCropsAndCakes_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");

*adjust milk products:
FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",PigTypeInHerd,"Whey","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",PigTypeInHerd,"Whey","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",PigTypeInHerd,"Milk, whole","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",PigTypeInHerd,"Milk, skimmed","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",PigTypeInHerd,"Milk, whole","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
FeedingRationsHeads_OtherChar_MR(Regions,"Pigs",PigTypeInHerd,"Milk, skimmed","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%") = 0;

FeedingRationsHeads_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Soyabean cake","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Soyabean cake","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + FeedingRationsHeads_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Whey","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + FeedingRationsHeads_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Milk, whole","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + FeedingRationsHeads_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Milk, skimmed","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Whey","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
FeedingRationsHeads_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Milk, whole","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
FeedingRationsHeads_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Milk, skimmed","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%") = 0;

*again, sum over feed groups, to adjust for these changes:
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_FeedGroups_DetailedFeedingRations,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed$Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_Feed,Commodities_FeedGroups_DetailedFeedingRations),
                 FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));
$offtext;

*derive GE shares: unit: MJ GE per ton feeding ration

*the following allows to have animal specific contents (such as protein for cattle or pigs, etc.)
Commod_Contents_MR(Regions,Commodities,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_Contents_MR(Regions,Commodities_Feed,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_Contents_MR(Regions,Commodities_Feed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedTotal_Commodity","GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed,
                 FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%"));

FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"GE share in feeding ration (share in MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedTotal_Commodity","GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedTotal_Commodity","GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"GE share in feeding ration (share in MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"GE share in feeding ration (share in MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%");
VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%");


*total requirement
VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock,AnimalTypeInHerd),
                 VFeedingRations_Quantity_MR.l(Regions,Livestock,AnimalTypeInHerd,Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%"));
VFeedingRations_Quantity_MR.l(Regions,"All Ruminants","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInHerd),
                 VFeedingRations_Quantity_MR.l(Regions,Ruminants,AnimalTypeInHerd,Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%"));
VFeedingRations_Quantity_MR.l(Regions,"All NonRuminants","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInHerd),
                 VFeedingRations_Quantity_MR.l(Regions,NonRuminants,AnimalTypeInHerd,Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%"));

VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes","AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Grass,VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%"));
VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes","AggregateFeedCereals_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Cereals,VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_Feed_Cereals,ProductionSystems,ProductionConditions,"%Scenario%"));

VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,"AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Grass,VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%"));
VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,"AggregateFeedCereals_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Cereals,VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Cereals,ProductionSystems,ProductionConditions,"%Scenario%"));

*total req in DM.
VFeedingRations_Contents_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_Feed,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock,AnimalTypeInHerd),
                 VFeedingRations_Contents_MR.l(Regions,Livestock,AnimalTypeInHerd,Commodities_Feed,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
VFeedingRations_Contents_MR.l(Regions,"All Animals","AllAndAverageTypes","AggregateFeedGrass_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Grass,VFeedingRations_Contents_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_Feed_Grass,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
VFeedingRations_Contents_MR.l(Regions,"All Animals","AllAndAverageTypes","AggregateFeedCereals_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Cereals,VFeedingRations_Contents_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_Feed_Cereals,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Grass,VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Grass,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Cereals,VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Cereals,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));



VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_FeedGroups_DetailedFeedingRations,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailledFeedingRations,Contents,ProductionSystems,ProductionConditions,"%Scenario%))
         = sum(Commodities_Feed$Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_Feed,Commodities_FeedGroups_DetailedFeedingRations),
                 VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%"));

VFeedingRations_Contents_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_FeedGroups_DetailedFeedingRations,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailledFeedingRations,Contents,ProductionSystems,ProductionConditions,"%Scenario%))
         = sum(Commodities_Feed$Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_Feed,Commodities_FeedGroups_DetailedFeedingRations),
                 VFeedingRations_Contents_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_Feed,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));


FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes","AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
         = VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,"AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes","AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes","AggregateFeedCereals_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
         = VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,"AggregateFeedCereals_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes","AggregateFeedCereals_Commodity",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRations_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes",Commodities_Feed,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
         = VFeedingRations_Quantity_MR.l(Regions,"All Ruminants","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
                 /VFeedingRations_Quantity_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%");


FeedingRations_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),FeedingRations_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"));
FeedingRations_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),FeedingRations_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"));


$ontext;
currently only needed for cereal / grass groups, not for single commodities:
*Commodities_Feed,"Quantity share in total feed req of all animals" is the share of an animal type in the total feed req for this commodities or commodity groups from ALL ANIMAL TYPES
*the AUX-variable is used to fasten the code
AUX_Inverse_VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,ProductionSystems,ProductionConditions,"Baseline")
                 $VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,ProductionSystems,ProductionConditions,"Baseline")
         = 1/VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,ProductionSystems,ProductionConditions,"Baseline");

FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         = VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,ProductionSystems,ProductionConditions,"Baseline")
                 *AUX_Inverse_VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,ProductionSystems,ProductionConditions,"Baseline");
$offtext;

*DM supply/Demand ratio:
Commod_OtherChar_MR(Regions,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VFeedingRations_Contents_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VFeedingRations_Contents_MR.l(Regions,"All Animals","AllAndAverageTypes",Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
*****
*ABOVE: this new calculation results in some discrepancies for some scenarios (e.g. the UNISECO scenarios with org/con systems, etc.) - but only minor, so this is no issue;
*the values used for deriving animal numbers in these scenarios are the same as assumed in the scenario definition, i.e. the FOFA 2050 baseline, etc. in that case.
*****

FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Grass,FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Grass,"FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Cereals,FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Cereals,"FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Grass,FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Grass,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Cereals,FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed_Cereals,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));



*now derive the supply/demand ratio for the cereals left after feeding ruminants:
*VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedCereals_Commodity","FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedCereals_Commodity","DM (t)",ProductionSystems,ProductionConditions,"Baseline")
*                 *(1-sum((Ruminants,AnimalTypeInHerd),
*                         FeedingRations_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")));
*Better calculate as follows, identical to scenarios:
VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 -sum((Ruminants,AnimalTypeInHerd),
                         VActAnimalsHead_QuantityActUnits_MR.l(Regions,Ruminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRationsHeads_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                                         *Commod_OtherChar_MR(Regions,Commodities_Feed,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%"));
VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedCereals_Commodity","FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Cereals,
                 VCommod_Feed_Contents_MR.l(Regions,Commodities_Feed_Cereals,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%"));


VFeedingRations_OtherChar_MR.l(Regions,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((NoNRuminants,AnimalTypeInHerd,Commodities_Feed_Cereals),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions,NoNRuminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *FeedingRationsHeads_OtherChar_MR(Regions,NoNRuminants,AnimalTypeInHerd,Commodities_Feed_Cereals,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));


Commod_OtherChar_MR(Regions,"AggregateFeedCereals_Commodity","Feed DM supply/demand ratio - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VFeedingRations_OtherChar_MR.l(Regions,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions,"AggregateFeedCereals_Commodity","FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VFeedingRations_OtherChar_MR.l(Regions,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
$ontext;
*5) Suckled animals
*derive the ratio of suckling to suckled animals to derive the number of the latter from the former, as the latter do not report any feed requirements (being included in the requirements from the suckling animal)
ActAnimalsHead_OtherChar_MR(Regions,Livestock,SuckledAnimals,"Share suckled to suckling",ProductionSystems,ProductionConditions,"Baseline")
         = sum(AnimalTypeInHerd$(MatchSucklingSuckledAnimals(AnimalTypeInHerd,SuckledAnimals)
                         AND VActAnimalsHead_QuantityActUnits_MR.l(Regions,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions,Livestock,SuckledAnimals,ProductionSystems,ProductionConditions,"Baseline")
                         /VActAnimalsHead_QuantityActUnits_MR.l(Regions,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline"));


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) Values needed to adjust min fer quantities in the scenarios

*Total nutrient requirements for the different crops and grasses

VActCropsGrass_OtherChar_MR.l(Regions,Activities,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline")
         = ActCropsGrass_OtherChar_MR(Regions,Activities,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline")
                 *VActCropsGrass_Outputs_MR.l(Regions,Activities,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline");

VActCropsGrass_OtherChar_MR.l(Regions,Activities,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline")
         = ActCropsGrass_OtherChar_MR(Regions,Activities,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline")
                 *VActCropsGrass_Outputs_MR.l(Regions,Activities,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline");

*derive N and P requirements from all crops (sum over POSITIVE values only!!):
VActCropsGrass_OtherChar_MR.l(Regions,"All Crops","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline")
         = sum(Crops$(VActCropsGrass_OtherChar_MR.l(Regions,Crops,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline")>0),
                 VActCropsGrass_OtherChar_MR.l(Regions,Crops,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_OtherChar_MR.l(Regions,"All Crops","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline")
         = sum(Crops$(VActCropsGrass_OtherChar_MR.l(Regions,Crops,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline")>0),
                 VActCropsGrass_OtherChar_MR.l(Regions,Crops,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline"));

*and similarly for all grass activities:
VActCropsGrass_OtherChar_MR.l(Regions,"Grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline")
         = sum(CoreGrassActivities$(VActCropsGrass_OtherChar_MR.l(Regions,CoreGrassActivities,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline")>0),
                 VActCropsGrass_OtherChar_MR.l(Regions,CoreGrassActivities,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_OtherChar_MR.l(Regions,"Grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline")
         = sum(CoreGrassActivities$(VActCropsGrass_OtherChar_MR.l(Regions,CoreGrassActivities,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline")>0),
                 VActCropsGrass_OtherChar_MR.l(Regions,CoreGrassActivities,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline"));

*also calculate N requirements from crops PLUS temp grass:
VActCropsGrass_OtherChar_MR.l(Regions,"All Crops PLUS temp grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_OtherChar_MR.l(Regions,"All Crops","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline")
                 + VActCropsGrass_OtherChar_MR.l(Regions,"temporary meadows and pastures","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline");
VActCropsGrass_OtherChar_MR.l(Regions,"All Crops PLUS temp grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_OtherChar_MR.l(Regions,"All Crops","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline")
                 + VActCropsGrass_OtherChar_MR.l(Regions,"temporary meadows and pastures","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline");
*and for All grass WITHOUT temp grass
VActCropsGrass_OtherChar_MR.l(Regions,"All Grass WITHOUT temp grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_OtherChar_MR.l(Regions,"Grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline")
                 - VActCropsGrass_OtherChar_MR.l(Regions,"temporary meadows and pastures","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"Baseline");
VActCropsGrass_OtherChar_MR.l(Regions,"All Grass WITHOUT temp grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_OtherChar_MR.l(Regions,"Grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline")
                 - VActCropsGrass_OtherChar_MR.l(Regions,"temporary meadows and pastures","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"Baseline");


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*7) Some simplification of fertilizer application emission values

*the parameter ManureApplication_MR gets too big - as it is not differentiated per crops, replace the Activities by "All crops" in the following, first assigning it from one crop
*and choose another in case the first is not grown in a region

ManureApplication_MR(Regions,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
         = ManureApplication_MR(Regions,"Wheat",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline");
ManureApplication_MR(Regions,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT ManureApplication_MR(Regions,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline"))
         = ManureApplication_MR(Regions,"Rice, paddy",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline");
ManureApplication_MR(Regions,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT ManureApplication_MR(Regions,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline"))
         = ManureApplication_MR(Regions,"Maize",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline");
ManureApplication_MR(Regions,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT ManureApplication_MR(Regions,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline"))
         = ManureApplication_MR(Regions,"Cassava",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline");
ManureApplication_MR(Regions,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT ManureApplication_MR(Regions,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline"))
         = ManureApplication_MR(Regions,"Bananas",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline");

ManureApplication_MR(Regions,Crops,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")=0;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*8) Corrections of some errors

*Pakistan - as the only country - reports areas for cotton lint - although the activity should be seed cotton; the cotton lint areas are largely equal to those of seed cotton, which it also reports. Hence we drop the cotton lint values:

VActCropsGrass_QuantityActUnits_MR.l("Pakistan","Cotton lint",ProductionSystems,ProductionConditions,"Baseline") = 0;


$offtext;




$exit;







