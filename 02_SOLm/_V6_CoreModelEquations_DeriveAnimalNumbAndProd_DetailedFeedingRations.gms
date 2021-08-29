PUTCLOSE con,"_V6_CoreModelEquations_DeriveAnimalNumbAndProd_DetailedFeedingRations";

*GENERAL DESCRIPTION
*This file contains all the core model equations for deriving animal numbers from feed supply and feeding rations and for deriving animal production, imports/exports and domestically available quantities - this version uses DETAILED FEEDING RATIONS and not the feed group aggregates
*the calculations are done iteratively:
*First, ruminants (animals with grass in the feeding ration) are derived from grass availability; then their demand for concentrates is derived and subtracted from total concentrates supply.
*At this stage, concentrates are purely plant based - derivd from the plant production DAQ calculations
*then, the various commodities that are produced from these animals are calculated, including imports, exports, DAQ - and their utilisation.
*the remaining concentrates quantity is then augmented by the feed utilisation of these animal products, this total is then used to derive the number of non-grass-fed animals.
*then the commodity quantities from these non-grass-fed animals are derived (including import, export, DAQ) - and utilisations - part of this is again feed.
*this additional feed is then used to feed some additional non-grass-fed animals, and these result in a slightly increased number of commodities, then the iteration stops
*        (but could be continued- and coded as a genuine loop - if needed; it is not yet looped as in this first two iterations the code looks slightly different, cf. below)).

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Derive numbers of animals with grass in the feeding rations
- 2) Derive primary product production from the animals with grass in the feeding rations
- 3) Derive commodity production from the animals with grass in the feeding rations
         3.1) Production of primary products as commodities
         3.2) Production, Import, export and DAQ values for commodities that are not primary products as commodities
                 3.2.1) Commodities that directly correspond to primary products from activities but are mostly named differently
                 3.2.2) Derived grass-fed animal commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
- 4) Fish and seafood:
- 5) Utilization of DAQ and some other values for commodities from animals with grass in the feeding ration
- 6) Derive numbers of animals WITHOUT grass in the feeding rations - First iteration
         6.1) Concentrate feed supply to the animals WITHOUT grass in the feeding rations
         6.2) Derive suckled and producing animals WITHOUT grass in the feeding rations
- 7) Derive number of beehives and honey production
- 8) Derive primary product production from the animals WITHOUT grass in the feeding rations - first iteration
- 9) Derive commodity production from the animals WITHOUT grass in the feeding rations - first iteration
         9.1) Production of primary products as commodities
         9.2) Production, Import, export and DAQ values for commodities that are not primary products as commodities
                 9.2.1) Commodities that directly correspond to primary products from activities but are mostly named differently - non-grass-fed animals or all animals
                 9.2.2) Derived non-grass-fed animal commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
- 10) Utilization of DAQ and some other values for commodities from animals WITHOUT grass in the feeding ration - first iteration
- 11) Adjust numbers of animals WITHOUT grass in the feeding rations: - Second iteration
- 12) Derive primary product production from the animals WITHOUT grass in the feeding rations - second iteration
- 13) Adjust commodity production from the animals WITHOUT grass in the feeding rations - Second iteration
         13.1) Production of primary products as commodities
         13.2) Production, Import, export and DAQ values for commodities that are not primary products as commodities
                 13.2.1) Commodities that directly correspond to primary products from activities but are mostly named differently - non-grass-fed animals or all animals
                 13.2.2) Derived non-grass-fed animal commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
- 14) Adjust total exports such as to be in the same relation as in the baseline:
- 15) Utilization of DAQ and some other values for commodities from animals WITHOUT grass in the feeding ration - second iteration
- 16) Detailed Feeding Rations
- 17) Derive feed requirements per APU
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Derive numbers of animals with grass in the feeding rations


*then derive animals with grass in the feeding rations based on the total grass supply and demand, in DM
*rationale: total feed quantity supplied from total grass is allocated to animal types according to their quantity share in this grass feed (initialised as the baseline value or explicitly set in scenario specifications)
*animal numbers are then derived by transferring this grass quantity supply to demand via division by the supply/demand ration; then animal numbers are derived by dividing by per capita requirements:
*use the condition to allow for prescribed animal numnbers via scenario specifications to do fast calculation for certain animal number assumptions (without having to deal with how they are fed, etc.) - e.g. to get a first estimate of manure quantities.


VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions_MR,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 AND (NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedGrass_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                         /(Commod_OtherChar_MR(Regions_MR,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));


*derive the total amount of animals and then the producing animals:
*the condition is needed as otherwise, animal numbers of thosse without herd-structure are lost as they have been calculated just above with "AllAndAverageType"
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllAndAVerageTypes",ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(AnimalTypeInHerd_NoAggregates,
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd_NoAggregates,ProductionSystems,ProductionConditions,"%Scenario%"));

VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProducingAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProducingAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,ProducingAnimals,"Share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%");



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Derive primary product production from the animals with grass in the feeding rations
*Production of primary products from activities
VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProducingAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%");

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Derive commodity production from the animals with grass in the feeding rations

*3.1) Production of primary products as commodities

*Use the sets Match_ActivityOutputsToCommodities_Animals(Activities,OutputsAnimals,Commodities)
*to link production from activities to primary commodities PRODUCTION level (not DAQ) - equal the activity outputs to these commodities by these matching sets.
*Derive DAQ by adding imports, subtracting exports and accounting for stock changes
*these are then the quantities for the primary products, - all processed (e.g. whey from milk) can then be derived from this basis
*the condition is needed to not loose the plant based commodities already calculated
VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((Activities_MR,OutputsAnimals,ProducingAnimals)$Match_ActivityOutputsToCommodities_Animals(Activities_MR,OutputsAnimals,Commodities_MR),
                 VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"));

*3.2) Production, Import, export and DAQ values for commodities that are not primary products as commodities

$ontext;
*here, the prod, imp, exp, DAQ values are calculated for the commodities as listed in Set CommoditiesDAQ_TradeFromToWorld(Commodities)
*these commodities come in two types, captured in two sets, and some corresponding matching sets needed in the code:
         Set CommoditiesDAQ_TradeFromToWorldPrimary(Commodities) "Commodity set - only PRIMARY commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
         Set CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary(Commodities) Derived commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
matching sets:
         Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsPrimary(Commodities,Activities,OutputsAnimals) "Matching set to match the animal commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsDerived(Commodities,Activities,OutputsAnimals) "Matching set to match the animal commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_CropsDerived(Commodities,Commodities_2)  "Matching the derived commodities that are derived from primary commodities as captured in the previous set - DAQ and trade calculations for them are different than for the other derived commodities)
         Set MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(Commodities,Activities,OutputsAnimals) "Matching set to match the crop commodities that are pooled from primary commodities plus derived products with the underlying activity"
$offtext;

*the import/export values are done on the basis of to/from WORLD values - as we are interested in the DAQs in the main model code, not in the origin of the commodities. The origin is used later after the main model run when deriving impacts embodied in imported commodities

*3.2.1) Commodities that directly correspond to primary products from activities but are mostly named differently
*these are collected in the Set CommoditiesDAQ_TradeFromToWorldPrimary(Commodities) "Commodity set - only PRIMARY commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
*Do the assignment for other primary commodities that are not identically named as activites but correspond to activity outputs (maybe aggregated), by scaling the commodity production from the baseline

*we need some aggregations to do the scalings in the various calculations below for deriving the import and export values in the scenarios:
*these are needed, as some commodities relate not to single activities, but to groups (e.g. "bovine meat" to "Cattle and buffaloes", etc,)
VActAnimalsHead_Outputs_MR.l(Regions_MR,"Cattle and buffaloes",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_Outputs_MR.l(Regions_MR,"Cattle",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions_MR,"Buffaloes",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_Outputs_MR.l(Regions_MR,"Sheep and Goats",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_Outputs_MR.l(Regions_MR,"Sheep",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions_MR,"Goats",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%");

*derive an auxiliary variable to make the code faster:
*$if not %Scenario% == "Baseline" $goto EndAuxVarDef
*$if-statement results in an error - hence do not use
*we need it for aggregates as well, thus do not use activities_MR but Activities!
*for Baseline: *already done in the Baseline values for model runs module:
*AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*                 $VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");
*$label EndAuxVarDef

*then do the calculation:
*we need it for aggregates as well, thus do not use activities_MR but Activities!
*the condition is needed to not loose the plant based commodities already calculated
VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((Activities,AnimalTypeInHerd,OutputsAnimals)$MatchCommAct_CommoditiesDAQ_TradeFTW_AnimalsPrimaryGrassFed(Commodities_MR,Activities,OutputsAnimals),
                  VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));

*then do adjustments of imports of the primary commodities, based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*this is now needed for animals only, the calculation with crops already done, thus:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%"));

*the condition is needed to allow for predefined values on imports, etc. from scenario specifications,
VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline");

*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria exporting bananas without reporting production of Bananas - and this could also happen for meat, etc. in some countries) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline"));

*some further calculations needed in case there are exports but no domestic production or imports (e.g. for palm kernels in Australia):
*        in this case, scale with total world production of the underlying activity, as then, the exports are entirely based on imports, that are dependent on world production
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"Baseline");

*now we can do the DAQ = prod+imp-Exp for the primary commodities - this is then the basis for deriving the derived commodity production plus the imp/exp/DAQ calculations for those
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*sondition not needed as also predefined values must be consistennt with DAQ=Prod+Imp-Exp)
*                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*3.2.2) Derived grass-fed animal commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
*these are collected in the Set CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary(Commodities) Derived commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
*for derived commodities that are derived from primary commodities as calculated above, do the production based on baseline production scaled by DAQ of the parent product (i.e. Milk for whey, etc.) in the scenario and baseline;

*first, we need some commod aggregates
*the commodity milk, whole covers cattle only, but we have no other commodity milk information - so use the commodities directly calculated from activities here:
VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(Regions_MR,"Milk, whole",ProductionSystems,ProductionConditions,"%Scenario%")
           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh buffalo",ProductionSystems,ProductionConditions,"%Scenario%")
           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh cow",ProductionSystems,ProductionConditions,"%Scenario%")
           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh goat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh sheep",ProductionSystems,ProductionConditions,"%Scenario%");

*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_Quantity_MR.l(Regions_MR,"Milk, whole",ProductionSystems,ProductionConditions,"Baseline")
*           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh buffalo",ProductionSystems,ProductionConditions,"Baseline")
*           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh cow",ProductionSystems,ProductionConditions,"Baseline")
*           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh goat",ProductionSystems,ProductionConditions,"Baseline")
*           + VCommod_Production_MR.l(Regions_MR,"Milk, whole fresh sheep",ProductionSystems,ProductionConditions,"Baseline");
*
**use the auxiliary variable as already derived for the crops to make the code faster:
*AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"Baseline")
*                 $VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"Baseline");

*then calculate the production
VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR_2$MatchPrimDerivedCommodities_DAQ_TradeFTW_AnimalsDer_GrassFed(CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,Commodities_MR_2),
                 VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                         *VCommod_Quantity_MR.l(Regions_MR,Commodities_MR_2,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,Commodities_MR_2,ProductionSystems,ProductionConditions,"Baseline"));

*in case there is no Commod_Quant reported for the parent product, as e.g. for crops for palm kernels for Cambodia (and similar situations may arise for animal commodities), derive the production from global export values for the parent commodity, as this may be the best scaling-proxy to be used:
*note: exports for non-cattle milk are zero in the baseline data.
VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"%Scenario%")
         = VExportQuantity_MR.l(Regions_MR,"World","Milk, whole",ProductionSystems,ProductionConditions,"%Scenario%")
           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh buffalo",ProductionSystems,ProductionConditions,"%Scenario%")
           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh cow",ProductionSystems,ProductionConditions,"%Scenario%")
           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh goat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh sheep",ProductionSystems,ProductionConditions,"%Scenario%");

*for Baseline: *already done in the Baseline values for model runs module:
*VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"Baseline")
*         = VExportQuantity_MR.l(Regions_MR,"World","Milk, whole",ProductionSystems,ProductionConditions,"Baseline")
*           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh buffalo",ProductionSystems,ProductionConditions,"Baseline")
*           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh cow",ProductionSystems,ProductionConditions,"Baseline")
*           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh goat",ProductionSystems,ProductionConditions,"Baseline")
*           + VExportQuantity_MR.l(Regions_MR,"World","Milk, whole fresh sheep",ProductionSystems,ProductionConditions,"Baseline");

VExportQuantity_MR.l("World","World","Milk",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"%Scenario%"));
*for Baseline: *already done in the Baseline values for model runs module:
*VExportQuantity_MR.l("World","World","Milk",ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"Baseline"));
*
*AUX_Inverse_VExportQuantity_MR.l("World","World","Milk",ProductionSystems,ProductionConditions,"Baseline")
*                 $VExportQuantity_MR.l("World","World","Milk",ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VExportQuantity_MR.l("World","World","Milk",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR_2$MatchPrimDerivedCommodities_DAQ_TradeFTW_AnimalsDer_GrassFed(CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,Commodities_MR_2),
                 VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
*scale by the import scale factor, as the global export stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                         *VExportQuantity_MR.l("World","World",Commodities_MR_2,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VExportQuantity_MR.l("World","World",Commodities_MR_2,ProductionSystems,ProductionConditions,"Baseline"));

*then do imports and exports as above.
*again, first do adjustments of imports of the primary commodities, based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%"));

VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline");


*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria importing soyabean as a basis for soyabeancake, besides the basis from domestic soyabean production) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"Baseline"));

*delete the auxiliary aggregates again:
VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"Baseline") = 0;
VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"Baseline") = 0;

*now we can do the DAQ = prod+imp-Exp for these commodities
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*sondition not needed as also predefined values must be consistent with DAQ=Prod+Imp-Exp
*                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Fish and seafood:
*first SIMPLE version to have something
*we do it here to have it available as feed to the non-grass-fed animals - but should be derived from feed input as well. TO BE DONE!!!
*thus set it equal to the baseline - unless specified in the scenario specifications:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"Baseline");
VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"Baseline");
*Commod_OtherChar_MR(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Util food (share)",ProductionSystems,ProductionConditions,"Baseline");

*As there may be some scenarios with no fish and seafood, this specification has to be set via "eps" in the scenario specification, to avoid it being replaced by the baseline values here;
*but it thus needs to be replaced here by zero:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         = 0;
VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         = 0;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) Utilization of DAQ and some other values for commodities from animals with grass in the feeding ration

VCommod_Food_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Food_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Seed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Seed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util seed (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Processing_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Processing_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util processing (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Waste_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Waste_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util waste (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Other_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Other_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)",ProductionSystems,ProductionConditions,"%Scenario%");

*Dry matter and GE, ME and XP quantities:
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%");


*and again summed over feed groups:
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_Feed$Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_Feed,Commodities_FeedGroups_DetailedFeedingRations),
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,Contents,ProductionSystems,ProductionConditions,"%Scenario%"));


*derive Feed GE contents per DM for the feed commodities, feed groups and total feed:

*FEED COMMOD already done - may droip - and only retain for FEED GROUPS

Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

*feed groups separately, as they are usually not part of Commodities_MR
Commod_Contents_MR(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

Commod_Contents_MR(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

Commod_Contents_MR(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,ProductionSystems,ProductionConditions,"%Scenario%");

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) Derive numbers of animals WITHOUT grass in the feeding rations - First iteration
*now derive those animal numbers that have not yet been derived based on grass supply and requirements,
*thus based on concentrates, assuming the share of animal categories in total concentrates demand to be the same as in the baseline - BUT referring to SINGLE COMMODITIES, not feed groups
*these animals are fed on the remaining concentrates after having fed the grass-fed animals PLUS the feed-commodities produced from these grass-fed animals
*this then also requires a new supply/demand ratio used further down: "Feed GE supply/demand ratio Conc - left after feeding ruminants"
*the condition for animal numbers assures that only the animals for which numbers have now been derived again are included.


*get rid of the AllAndAverageTypes for the animals with herd structures - as they are the sum and may cause problems when summing over all animals and herd types:
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Pigs","AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%") = 0;


*on single commodity level, we thus have the supply left after feeding ruminants.
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 -sum((Ruminants,AnimalTypeInHerd),
                         VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Ruminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRationsHeads_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                                         *Commod_OtherChar_MR(Regions_MR,Commodities_Feed,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%"));

VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedForageCrops_Commodity","FeedXP (t) - undersupply to ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
         = -sum(Commodities_Feed_ForageCrops$(VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed_ForageCrops,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%") < 0),
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed_ForageCrops,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_Contents_MR(Regions_MR,Commodities_Feed_ForageCrops,"FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedOilCropsAndCakes_Commodity","FeedXP (t) - undersupply to ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
         = -sum(Commodities_Feed_OilcropsAndCakes$(VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed_OilcropsAndCakes,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%") < 0),
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed_OilcropsAndCakes,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_Contents_MR(Regions_MR,Commodities_Feed_OilcropsAndCakes,"FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedCereals_Commodity","FeedXP (t) - undersupply to ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
         = -sum(Commodities_Feed_Cereals$(VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed_Cereals,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%") < 0),
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed_Cereals,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_Contents_MR(Regions_MR,Commodities_Feed_Cereals,"FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));



*set negative values equal to zero and take this as an indication that the feeding rations need some adjustment, to avoid that there is too few cereals, for example, to meet the feeding rations as defined with the available grasslands
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*6.1) Cereal feed supply to the animals WITHOUT grass in the feeding rations
*to derive the number of animals without grass in the feeding ration, use the most important concentrate feed component which is cereals and products:
*VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedCereals_Commodity","FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
*         = sum(Commodities_Feed_Cereals,
*                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed_Cereals,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%"));
*calculate this remaining DM for all feedgroups:
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed$Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_Feed,Commodities_FeedGroups_DetailedFeedingRations),
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,"FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%"));



$ontext;
The proportionality between different animals is then used as follows to derive unknown parameters in the equations to derive animal numbers:

                                                       CerealSupplyLeftFromRumi * ShareOfCerealDemandOfTheseAnimalsInCerealsLeft
NumberOfAnimals(From Cereals left from Ruminants) = ----------------------------------------------------------------------------
                                                  SupplyDemandRatioOfCereals * (TotalperHeadCerealRequirements)

In this, the second factor in the numerator is not known.
But the following holds for this second factor:

                                                           ShareOfCerealDemandOfTheseAnimalsInALLCereals
ShareOfCerealDemandOfTheseAnimalsInCerealsLeft =     --------------------------------------------------------
                                                  SUM_AnimalsLeft(ShareOfCerealsDemandOfTheseAnimalsInALLCereals)

And inserting this above results in the following:

                                                       CerealSupplyLeftFromRumi * ShareOfCerealDemandOfTheseAnimalsInALLCereals
NumberOfAnimals(From Cereals left from Ruminants) = -----------------------------------------------------------------------------------------------------
                                                  SupplyDemandRatioOfCereals * (TotalperHeadCerealRequirements) * SUM_AnimalsLeft(ShareOfCerealDemandOfTheseAnimalsInALLCereals)

thereby, supply/demand ration and ShareOfCerealDemandOfTheseAnimalsInALLCereals are taken from the baseline

$offtext;

*6.2) Derive numbers of animals WITHOUT grass in the feeding rations
*the condition is to assure that only animals WITHOUT grass in feeding rations are calculated anew and thus no values from above are overwritten


FeedingRations_OtherChar_MR(Regions_MR,"AnimalsWithoutGrassInFeedingRation","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd)$(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")),
                 FeedingRations_OtherChar_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"));


VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((Commod_OtherChar_MR(Regions_MR,"AggregateFeedCereals_Commodity","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
                         *FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *FeedingRations_OtherChar_MR(Regions_MR,"AnimalsWithoutGrassInFeedingRation","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"))
                                 AND (NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedCereals_Commodity","FeedQuant DM (t) - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
           /(Commod_OtherChar_MR(Regions_MR,"AggregateFeedCereals_Commodity","Feed DM supply/demand ratio - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,"AnimalsWithoutGrassInFeedingRation","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"));


$ontext;
*Finally, derive still missing animals via forage or oil crop supply - TO BE DONE LATER - ALL non-grass fed animals will have cereals, so they should be derived:
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%"))
                         AND (Commod_OtherChar_MR(Regions_MR,"AggregateFeedForageCrops_Commodity","Feed GE supply/demand ratio Forage",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedForageCrops_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
                         /(Commod_OtherChar_MR(Regions_MR,"AggregateFeedForageCrops_Commodity","Feed GE supply/demand ratio Forage",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"));
$offtext;

*and if there are still animals missing, derive also animals that SHOULD HAVE grass in the feeding ration via cereals
*this can be necessary if e.g. a country reports no grass feed but reports cattle and buffaloe numbers, or in case we have ruminants without grass in the feeding ration, etc...
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%"))
                         AND (Commod_OtherChar_MR(Regions_MR,"AggregateFeedCereals_Commodity","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedCereals_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                         /(Commod_OtherChar_MR(Regions_MR,"AggregateFeedCereals_Commodity","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));



*6.2) Derive suckled and producing animals WITHOUT grass in the feeding rations
*derive suckled animals
*derive the number of suckled animals as those do not report any feed requirements (being included in the requirements from the suckling animal)
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,SuckledAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,SuckledAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(AnimalTypeInHerd$MatchSucklingSuckledAnimals(AnimalTypeInHerd,SuckledAnimals),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,SuckledAnimals,"Share suckled to suckling",ProductionSystems,ProductionConditions,"%Scenario%"));

*derive the total amount of animals and then the producing animals:
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllAndAVerageTypes",ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(AnimalTypeInHerd_NoAggregates,
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd_NoAggregates,ProductionSystems,ProductionConditions,"%Scenario%"));

VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProducingAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProducingAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,ProducingAnimals,"Share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%");





****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*7) Derive number of beehives and honey production
*scale the number of beehives with the area of crops likely to require pollination services (fruits, vegetables, pulses, oilcrops and part of the TempMeadAndPastures - just assume 20% for those)
*thus not depending on feed supply, but pollination demand. Feed demand is anyway negligible, relatively, but can then be used to derive impacts

*for Baseline: *already done in the Baseline values for model runs module:
*VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Fruits,VActCropsGrass_QuantityActUnits_MR.l(Regions,Fruits,ProductionSystems,ProductionConditions,"Baseline"))
*                 + sum(Vegetables,VActCropsGrass_QuantityActUnits_MR.l(Regions,Vegetables,ProductionSystems,ProductionConditions,"Baseline"))
*                 + sum(Pulses,VActCropsGrass_QuantityActUnits_MR.l(Regions,Pulses,ProductionSystems,ProductionConditions,"Baseline"))
*                 + sum(Oilcrops,VActCropsGrass_QuantityActUnits_MR.l(Regions,Oilcrops,ProductionSystems,ProductionConditions,"Baseline"))
*                 + 0.2*sum(TempMeadAndPastures,VActCropsGrass_QuantityActUnits_MR.l(Regions,TempMeadAndPastures,ProductionSystems,ProductionConditions,"Baseline"));

VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Fruits,VActCropsGrass_QuantityActUnits_MR.l(Regions,Fruits,ProductionSystems,ProductionConditions,"%Scenario%"))
                 + sum(Vegetables,VActCropsGrass_QuantityActUnits_MR.l(Regions,Vegetables,ProductionSystems,ProductionConditions,"%Scenario%"))
                 + sum(Pulses,VActCropsGrass_QuantityActUnits_MR.l(Regions,Pulses,ProductionSystems,ProductionConditions,"%Scenario%"))
                 + sum(Oilcrops,VActCropsGrass_QuantityActUnits_MR.l(Regions,Oilcrops,ProductionSystems,ProductionConditions,"%Scenario%"))
                 + 0.2*sum(TempMeadAndPastures,VActCropsGrass_QuantityActUnits_MR.l(Regions,TempMeadAndPastures,ProductionSystems,ProductionConditions,"%Scenario%"));

*for Baseline: *already done in the Baseline values for model runs module:
*AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"Baseline")
*                 $VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"Baseline")
*         = 1 / VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"Baseline");

*derive number of beehives as indicated above - in case it is not given in the scenario specifications
VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"%Scenario%")
                         *AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"Baseline");

*set these aggregates and aux variables equal zero again
VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"Baseline") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"Baseline") = 0;
*AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,"PollinatedCrops",ProductionSystems,ProductionConditions,"%Scenario%") = 0;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*8) Derive primary product production from the animals WITHOUT grass in the feeding rations - first iteration
*Production of primary products from activities
VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProducingAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%");
*For Honey:
VActAnimalsAPU_Outputs_MR.l(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,ProducingAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%");

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*9) Derive commodity production from the animals WITHOUT grass in the feeding rations - first iteration

*9.1) Production of primary products as commodities

*Use the sets Match_ActivityOutputsToCommodities_Animals(Activities,OutputsAnimals,Commodities)
*to link production from activities to primary commodities PRODUCTION level (not DAQ) - equal the activity outputs to these commodities by these matching sets.
*Derive DAQ by adding imports, subtracting exports and accounting for stock changes
*these are then the quantities for the primary products, - all processed (e.g. whey from milk) can then be derived from this basis

VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((Activities_MR,OutputsAnimals,ProducingAnimals)$Match_ActivityOutputsToCommodities_Animals(Activities_MR,OutputsAnimals,Commodities_MR),
                 VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"));

VCommod_Production_MR.l(Regions_MR,"Honey",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsAPU_Outputs_MR.l(Regions_MR,"Beehives", "Honey producing","Honey (t)",ProductionSystems,ProductionConditions,"%Scenario%");

*9.2) Production, Import, export and DAQ values for commodities that are not primary products as commodities

*cf. also 3.2. above
*the import/export values are done on the basis of to/from WORLD values - as we are interested in the DAQs in the main model code, not in the origin of the commodities. The origin is used later after the main model run when deriving impacts embodied in imported commodities

*9.2.1) Commodities that directly correspond to primary products from activities but are mostly named differently - non-grass-fed animals or all animals
*these are collected in the Set CommoditiesDAQ_TradeFromToWorldPrimary(Commodities) "Commodity set - only PRIMARY commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
*Do the assignment for other primary commodities that are not identically named as activites but correspond to activity outputs (maybe aggregated), by scaling the commodity production from the baseline

*we need some aggregations to do the scalings in the various calculations below for deriving the import and export values in the scenarios:
*these are needed, as some commodities relate not to single activities, but to groups (e.g. "Poultry meat" to "Poultry birds", etc,)
VActAnimalsHead_Outputs_MR.l(Regions,"All Animals",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Livestock_NoAggregates,VActAnimalsHead_Outputs_MR.l(Regions,Livestock_NoAggregates,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"));
*"All other animals"
*2735."Meat, Other"
*        "Default composition: 1089 Meat, bird nes, 1097 Meat, horse, 1108 Meat, ass, 1111 Meat, mule, 1127 Meat, camel, 1141 Meat, rabbit, 1151 Meat, other rodents,
*        1158 Meat, other camelids, 1163 Meat, game, 1164 Meat, dried nes, 1166 Meat, nes, 1172 Meat, nes, preparations, 1176 Snails, not sea"
VActAnimalsHead_Outputs_MR.l(Regions,"All other Animals",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_Outputs_MR.l(Regions,"Animals live nes",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Asses",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Camelids, other",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Camels",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Horses",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Mules",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Pigeons, other birds",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Rabbits and hares",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Game",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Rodents, other",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%");
*"poultry birds"
*2734."Poultry Meat"
*        "Default composition: 1058 Meat, chicken, 1060 Fat, liver prepared (foie gras), 1061 Meat, chicken, canned, 1069 Meat, duck, 1073 Meat, goose and guinea fowl, 1080 Meat, turkey"
VActAnimalsHead_Outputs_MR.l(Regions,"Poultry birds",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_Outputs_MR.l(Regions,"Chickens",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Ducks",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Geese and guinea fowls",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Turkeys",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%");

*derive an auxiliary variable to make the code faster:
*$if not %Scenario% == "Baseline" $goto EndAuxVarDef
*$if-statement results in an error - hence do not use
*we need it for aggregates as well, thus do not use activities_MR but Activities!
*for Baseline: *already done in the Baseline values for model runs module:
*AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*                 $VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");
*$label EndAuxVarDef

*then do the calculation:
*we need it for aggregates as well, thus do not use activities_MR but Activities!
VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((Activities,AnimalTypeInHerd,OutputsAnimals)$MatchCommAct_CommoditiesDAQ_TradeFTW_AnimPrimaryNonGrassFed(Commodities_MR,Activities,OutputsAnimals),
                  VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));

*then do adjustments of imports of the primary commodities, based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*this is now needed for animals only, the calculation with crops already done, thus:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%"));

*the condition is needed to allow for predefined values on imports, etc. from scenario specifications,
*for the commodities in this section, this is not possible for the commod production, as this directly relates to the cropping areas
VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline");

*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria exporting bananas without reporting production of Bananas - and this could also happen for meat, etc. in some countries) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline"));

*some further calculations needed in case there are exports but no domestic production or imports (e.g. for palm kernels in Australia):
*        in this case, scale with total world production of the underlying activity, as then, the exports are entirely based on imports, that are dependent on world production
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline");

*now we can do the DAQ = prod+imp-Exp for the primary commodities - this is then the basis for deriving the derived commodity production plus the imp/exp/DAQ calculations for those
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*sondition not needed as also predefined values must be consistent with DAQ=Prod+Imp-Exp
*                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*9.2.2) Derived non-grass-fed animal commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
*these are collected in the Set CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary(Commodities) Derived commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
*for derived commodities that are derived from primary commodities as calculated above, do the production based on baseline production scaled by DAQ of the parent product (i.e. Meat for Meat meal, etc.) in the scenario and baseline;

*first, we need some commod aggregates
VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(Regions_MR,"Bovine Meat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VCommod_Quantity_MR.l(Regions_MR,"Poultry meat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VCommod_Quantity_MR.l(Regions_MR,"Pigmeat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VCommod_Quantity_MR.l(Regions_MR,"Meat, Other",ProductionSystems,ProductionConditions,"%Scenario%");

*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_Quantity_MR.l(Regions_MR,"Bovine Meat",ProductionSystems,ProductionConditions,"Baseline")
*           + VCommod_Quantity_MR.l(Regions_MR,"Poultry meat",ProductionSystems,ProductionConditions,"Baseline")
*           + VCommod_Quantity_MR.l(Regions_MR,"Pigmeat",ProductionSystems,ProductionConditions,"Baseline")
*           + VCommod_Quantity_MR.l(Regions_MR,"Meat, Other",ProductionSystems,ProductionConditions,"Baseline");
*
**use the auxiliary variable as already derived for the crops to make the code faster:
*AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
*                 $VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline");


VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR_2$MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_AnimalsDerived(CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,Commodities_MR_2),
                 VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
                         *VCommod_Quantity_MR.l(Regions_MR,Commodities_MR_2,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,Commodities_MR_2,ProductionSystems,ProductionConditions,"Baseline"));

*in case there is no Commod_Quant reported for the parent product, as e.g. for crops for palm kernels for Cambodia, derive the production from global export values for the parent commodity, as this may be the best scaling-proxy to be used:
VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VExportQuantity_MR.l(Regions_MR,"World","Bovine Meat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VExportQuantity_MR.l(Regions_MR,"World","Poultry meat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VExportQuantity_MR.l(Regions_MR,"World","Pigmeat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VExportQuantity_MR.l(Regions_MR,"World","Meat, Other",ProductionSystems,ProductionConditions,"%Scenario%");

*for Baseline: *already done in the Baseline values for model runs module:
*VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"Baseline")
*         = VExportQuantity_MR.l(Regions_MR,"World","Bovine Meat",ProductionSystems,ProductionConditions,"Baseline")
*           + VExportQuantity_MR.l(Regions_MR,"World","Poultry meat",ProductionSystems,ProductionConditions,"Baseline")
*           + VExportQuantity_MR.l(Regions_MR,"World","Pigmeat",ProductionSystems,ProductionConditions,"Baseline")
*           + VExportQuantity_MR.l(Regions_MR,"World","Meat, Other",ProductionSystems,ProductionConditions,"Baseline");
*
*VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"Baseline"));
VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"%Scenario%"));

*for Baseline: *already done in the Baseline values for model runs module:
*AUX_Inverse_VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
*                 $VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR_2$MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_AnimalsDerived(CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,Commodities_MR_2),
                 VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
*scale by the import scale factor, as the global export stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                         *VExportQuantity_MR.l("World","World",Commodities_MR_2,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VExportQuantity_MR.l("World","World",Commodities_MR_2,ProductionSystems,ProductionConditions,"Baseline"));

*then do imports and exports as above.

*again, first do adjustments of imports of the primary commodities, based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%"));

VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline");

*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria importing soyabean as a basis for soyabeancake, besides the basis from domestic soyabean production) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline"));

*delete the auxiliary aggregates again:
VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline") = 0;
VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"Baseline") = 0;
VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"Baseline") = 0;
VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"Baseline") = 0;

*now we can do the DAQ = prod+imp-Exp for these commodities
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*sondition not needed as also predefined values must be consistent with DAQ=Prod+Imp-Exp
*                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*10) Utilization of DAQ and some other values for commodities from animals WITHOUT grass in the feeding ration - first iteration

VCommod_Food_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Food_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Seed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Seed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util seed (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Processing_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Processing_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util processing (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Waste_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Waste_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util waste (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Other_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Other_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)",ProductionSystems,ProductionConditions,"%Scenario%");

*Dry matter and GE, ME and XP quantities:
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%");

*and again summed over feed groups:
*some entries are then lost - but these are not needed anymore (e.g. "FeedGE (MJ) - left after feeding ruminants")
*nevertheless, it is interesting to keep those (e.g. "FeedXP (t) - undersupply to ruminants"), thus use an auxiliary variable:
AUX_VCommod_Feed_Contents_MR.l(Regions_MR,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_Feed$Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_Feed,Commodities_FeedGroups),
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,Contents,ProductionSystems,ProductionConditions,"%Scenario%"));

VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = AUX_VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,Contents,ProductionSystems,ProductionConditions,"%Scenario%");
AUX_VCommod_Feed_Contents_MR.l(Regions_MR,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%") = 0;


$ontext;
*and add the main and byprod concentrates:
VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcentrates_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcMainProd_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcByProd_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%");

*and summed for the total:
VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedTotal_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedTotal_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_Feed,
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,Contents,ProductionSystems,ProductionConditions,"%Scenario%"));
$offtext;

*derive Feed GE contents per DM for the feed commodities, feed groups and total feed:
Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

*feed groups separately, as they are usually not part of Commodities_MR
Commod_Contents_MR(Regions_MR,Commodities_FeedGroups,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*11) Adjust numbers of animals WITHOUT grass in the feeding rations: - Second iteration
*now do an adjustment of non-grass-fed animal numbers by deriving how much can be produced from the energy in the commodities produced from them and used as feed:


*BY NOW: animals are derived from grass supply and cereals (or byprod from them) supply. Thus all grass and cereals should be used up. Then allocate the other feed including the animal feed produced from ALL animals
*and use any additional feed to change feeding rations somewhat and to get some more animals.
*THUS, needed: a check that the feeding supply and the feeding ration are consistent

*the following has only few comodites in the respectife sets; currently, for many of them no GE values are available, thus it is not relevant.
*but in principle it should work

*$ontext;
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,NonRuminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                    $(Commod_OtherChar_MR(Regions_MR,"AggregateFeedConcentrates_Commodity","Feed GE supply/demand ratio Conc - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,NonRuminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                 + (sum(CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NonGrassFed,VCommod_Feed_Contents_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NonGrassFed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"))
                          +sum(CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,VCommod_Feed_Contents_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")))
                                 *ActAnimalsHead_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                    /(Commod_OtherChar_MR(Regions_MR,"AggregateFeedConcentrates_Commodity","Feed GE supply/demand ratio Conc - left after feeding ruminants",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"));
*$offtext;



*again, derive the suckled and producing etc. animals:
*derive suckled animals
*derive the number of suckled animals as those do not report any feed requirements (being included in the requirements from the suckling animal)
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,NonRuminants,SuckledAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,NonRuminants,SuckledAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(AnimalTypeInHerd$MatchSucklingSuckledAnimals(AnimalTypeInHerd,SuckledAnimals),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,NonRuminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,NonRuminants,SuckledAnimals,"Share suckled to suckling",ProductionSystems,ProductionConditions,"%Scenario%"));

*derive the total amount of animals and then the producing animals:
*here, "AllAndAverageTypes" needs to be calculated for the non-ruminant animals with herd structure only:
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_NonRuminantsWithHerdStructure,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_NonRuminantsWithHerdStructure,"AllAndAVerageTypes",ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(AnimalTypeInHerd_NoAggregates,
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_NonRuminantsWithHerdStructure,AnimalTypeInHerd_NoAggregates,ProductionSystems,ProductionConditions,"%Scenario%"));

VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,NonRuminants,ProducingAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,NonRuminants,ProducingAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,NonRuminants,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,NonRuminants,ProducingAnimals,"Share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%");


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*12) Derive primary product production from the animals WITHOUT grass in the feeding rations - second iteration
VActAnimalsHead_Outputs_MR.l(Regions_MR,NonRuminants,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
*condition not needed and not possible - as from the first iteration all values are here already!
*                 $(NOT VActAnimalsHead_Outputs_MR.l(Regions_MR,NonRuminants,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,NonRuminants,ProducingAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_Outputs_MR(Regions_MR,NonRuminants,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%");

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*13) Adjust commodity production from the animals WITHOUT grass in the feeding rations - Second iteration
*Use the sets Match_ActivityOutputsToCommodities_Animals(Activities,OutputsAnimals,Commodities)
*        NonRuminants
*        CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed
*        CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed
*to link production from activities to primary commodities PRODUCTION level (not DAQ) - equal the activity outputs to these commodities by these matching sets.
*Derive DAQ by adding imports, subtracting exports and accounting for stock changes
*these are then the quantities for the primary products, - all processed (e.g. whey from milk) can then be derived from this basis

*13.1) Production of primary products as commodities
VCommod_Production_MR.l(Regions_MR,Commodities_EquivalentToNonGrassFedAnimalActivityOutput,ProductionSystems,ProductionConditions,"%Scenario%")
*condition not needed and not possible - as from the first iteration all values are here already!
*                 $(NOT VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((NonRuminants,OutputsAnimals,ProducingAnimals)$Match_ActivityOutputsToCommodities_Animals(NonRuminants,OutputsAnimals,Commodities_EquivalentToNonGrassFedAnimalActivityOutput),
                 VActAnimalsHead_Outputs_MR.l(Regions_MR,NonRuminants,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"));

*13.2) Production, Import, export and DAQ values for commodities that are not primary products as commodities

$ontext;
*here, the prod, imp, exp, DAQ values are calculated for the commodities as listed in Set CommoditiesDAQ_TradeFromToWorld(Commodities)
*these commodities come in two types, captured in two sets, and some corresponding matching sets needed in the code:
         Set CommoditiesDAQ_TradeFromToWorldPrimary(Commodities) "Commodity set - only PRIMARY commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
         Set CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary(Commodities) Derived commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
matching sets:
         Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsPrimary(Commodities,Activities,OutputsAnimals) "Matching set to match the animal commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_AnimalsDerived(Commodities,Activities,OutputsAnimals) "Matching set to match the animal commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_CropsDerived(Commodities,Commodities_2)  "Matching the derived commodities that are derived from primary commodities as captured in the previous set - DAQ and trade calculations for them are different than for the other derived commodities)
         Set MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(Commodities,Activities,OutputsAnimals) "Matching set to match the crop commodities that are pooled from primary commodities plus derived products with the underlying activity"
$offtext;

*the import/export values are done on the basis of to/from WORLD values - as we are interested in the DAQs in the main model code, not in the origin of the commodities. The origin is used later after the main model run when deriving impacts embodied in imported commodities
*13.2.1) Commodities that directly correspond to primary products from activities but are mostly named differently - non-grass-fed animals or all animals

*these are collected in the Set CommoditiesDAQ_TradeFromToWorldPrimary(Commodities) "Commodity set - only PRIMARY commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"

*Do the assignment for other primary commodities that are not identically named as activites but correspond to activity outputs (maybe aggregated), by scaling the commodity production from the baseline

*we need some aggregations to do the scalings in the various calculations below for deriving the import and export values in the scenarios:
*these are needed, as some commodities relate not to single activities, but to groups (e.g. "Poultry meat" to "Poultry birds", etc,)
VActAnimalsHead_Outputs_MR.l(Regions,"All Animals",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Livestock_NoAggregates,VActAnimalsHead_Outputs_MR.l(Regions,Livestock_NoAggregates,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"));
*"All other animals"
*2735."Meat, Other"
*        "Default composition: 1089 Meat, bird nes, 1097 Meat, horse, 1108 Meat, ass, 1111 Meat, mule, 1127 Meat, camel, 1141 Meat, rabbit, 1151 Meat, other rodents,
*        1158 Meat, other camelids, 1163 Meat, game, 1164 Meat, dried nes, 1166 Meat, nes, 1172 Meat, nes, preparations, 1176 Snails, not sea"
VActAnimalsHead_Outputs_MR.l(Regions,"All other Animals",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_Outputs_MR.l(Regions,"Animals live nes",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Asses",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Camelids, other",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Camels",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Horses",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Mules",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Pigeons, other birds",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Rabbits and hares",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Game",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Rodents, other",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%");
*"poultry birds"
*2734."Poultry Meat"
*        "Default composition: 1058 Meat, chicken, 1060 Fat, liver prepared (foie gras), 1061 Meat, chicken, canned, 1069 Meat, duck, 1073 Meat, goose and guinea fowl, 1080 Meat, turkey"
VActAnimalsHead_Outputs_MR.l(Regions,"Poultry birds",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_Outputs_MR.l(Regions,"Chickens",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Ducks",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Geese and guinea fowls",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActAnimalsHead_Outputs_MR.l(Regions,"Turkeys",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%");

*derive an auxiliary variable to make the code faster:
*$if not %Scenario% == "Baseline" $goto EndAuxVarDef
*$if-statement results in an error - hence do not use
*we need it for aggregates as well, thus do not use activities_MR but Activities!
*for Baseline: *already done in the Baseline values for model runs module:
*AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*                 $VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");
*$label EndAuxVarDef

*then do the calculation:
*we need it for aggregates as well, thus do not use activities_MR but Activities!
VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*condition not needed and not possible - as from the first iteration all values are here already!
*                 $(NOT VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((Activities,AnimalTypeInHerd,OutputsAnimals)$MatchCommAct_CommoditiesDAQ_TradeFTW_AnimPrimaryNonGrassFed(CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,Activities,OutputsAnimals),
                  VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                         *VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));

*then do adjustments of imports of the primary commodities, based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*this is now needed for animals only, the calculation with crops already done, thus:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%"));

*the condition is needed to allow for predefined values on imports, etc. from scenario specifications,
*for the commodities in this section, this is not possible for the commod production, as this directly relates to the cropping areas
VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline"))
*condition not needed and not possible - as from the first iteration all values are here already!
*                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline");

*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria exporting bananas without reporting production of Bananas - and this could also happen for meat, etc. in some countries) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")))
*condition not needed and not possible - as from the first iteration all values are here already!
*                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline"));

*some further calculations needed in case there are exports but no domestic production or imports (e.g. for palm kernels in Australia):
*        in this case, scale with total world production of the underlying activity, as then, the exports are entirely based on imports, that are dependent on world production

*NEW
*This however overwrites the assignment above and the dollar conditioncannot be used, as it is already calculated from the first iteration, hence the need for the conditional statements:

VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*NEW
                 $(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT (VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                               + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline"))))
*condition not needed and not possible - as from the first iteration all values are here already!
*                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"Baseline");


*now we can do the DAQ = prod+imp-Exp for the primary commodities - this is then the basis for deriving the derived commodity production plus the imp/exp/DAQ calculations for those
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*sondition not needed as also predefined values must be consistent with DAQ=Prod+Imp-Exp
*                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%");


*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_NongrassFed,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*13.2.2) Derived non-grass-fed animal commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available

*these are collected in the Set CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary(Commodities) Derived commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available

*for derived commodities that are derived from primary commodities as calculated above, do the production based on baseline production scaled by DAQ of the parent product (i.e. Meat for Meat meal, etc.) in the scenario and baseline;

*first, we need some commod aggregates
VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(Regions_MR,"Bovine Meat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VCommod_Quantity_MR.l(Regions_MR,"Poultry meat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VCommod_Quantity_MR.l(Regions_MR,"Pigmeat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VCommod_Quantity_MR.l(Regions_MR,"Meat, Other",ProductionSystems,ProductionConditions,"%Scenario%");

*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_Quantity_MR.l(Regions_MR,"Bovine Meat",ProductionSystems,ProductionConditions,"Baseline")
*           + VCommod_Quantity_MR.l(Regions_MR,"Poultry meat",ProductionSystems,ProductionConditions,"Baseline")
*           + VCommod_Quantity_MR.l(Regions_MR,"Pigmeat",ProductionSystems,ProductionConditions,"Baseline")
*           + VCommod_Quantity_MR.l(Regions_MR,"Meat, Other",ProductionSystems,ProductionConditions,"Baseline");
*
**use the auxiliary variable as already derived for the crops to make the code faster:
*AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
*                 $VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline");


VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*condition not needed and not possible - as from the first iteration all values are here already!
*                 $(NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR_2$MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_AnimalsDerived(CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,Commodities_MR_2),
                 VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
                         *VCommod_Quantity_MR.l(Regions_MR,Commodities_MR_2,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,Commodities_MR_2,ProductionSystems,ProductionConditions,"Baseline"));

*in case there is no Commod_Quant reported for the parent product, as e.g. for crops for palm kernels for Cambodia, derive the production from global export values for the parent commodity, as this may be the best scaling-proxy to be used:
VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VExportQuantity_MR.l(Regions_MR,"World","Bovine Meat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VExportQuantity_MR.l(Regions_MR,"World","Poultry meat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VExportQuantity_MR.l(Regions_MR,"World","Pigmeat",ProductionSystems,ProductionConditions,"%Scenario%")
           + VExportQuantity_MR.l(Regions_MR,"World","Meat, Other",ProductionSystems,ProductionConditions,"%Scenario%");

*for Baseline: *already done in the Baseline values for model runs module:
*VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"Baseline")
*         = VExportQuantity_MR.l(Regions_MR,"World","Bovine Meat",ProductionSystems,ProductionConditions,"Baseline")
*           + VExportQuantity_MR.l(Regions_MR,"World","Poultry meat",ProductionSystems,ProductionConditions,"Baseline")
*           + VExportQuantity_MR.l(Regions_MR,"World","Pigmeat",ProductionSystems,ProductionConditions,"Baseline")
*           + VExportQuantity_MR.l(Regions_MR,"World","Meat, Other",ProductionSystems,ProductionConditions,"Baseline");
*
*VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"Baseline"));
VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"%Scenario%"));

*for Baseline: *already done in the Baseline values for model runs module:
*AUX_Inverse_VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
*                 $VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VExportQuantity_MR.l("World","World","Meat",ProductionSystems,ProductionConditions,"Baseline");


*NEW
*Thus, in case there is no Commod_Quant reported for the parent product, as begun above, we derive the production
*the $-condition works here, as the code above would result in missing values if the the commod quant is not available for the parent product

VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*condition not needed and not possible - as from the first iteration all values are here already!
*NEW: no, it is possible to use it as the code above is such that the value is missing, if there is no commodity volume of the parent product reported
                 $(NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR_2$MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_AnimalsDerived(CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,Commodities_MR_2),
                 VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
*scale by the import scale factor, as the global export stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",Commodities_MR_2,ProductionSystems,ProductionConditions,"%Scenario%")
                         *VExportQuantity_MR.l("World","World",Commodities_MR_2,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VExportQuantity_MR.l("World","World",Commodities_MR_2,ProductionSystems,ProductionConditions,"Baseline"));

*then do imports and exports as above.

*again, first do adjustments of imports of the primary commodities, based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%"));


VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline"))
*condition not needed and not possible - as from the first iteration all values are here already!
*                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline");

*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria importing soyabean as a basis for soyabeancake, besides the basis from domestic soyabean production) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")))
*condition not needed and not possible - as from the first iteration all values are here already!
*                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"Baseline"));


*delete the auxiliary aggregates again:
VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VCommod_Quantity_MR.l(Regions_MR,"Meat",ProductionSystems,ProductionConditions,"Baseline") = 0;
VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VCommod_Quantity_MR.l(Regions_MR,"Milk",ProductionSystems,ProductionConditions,"Baseline") = 0;
VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VExportQuantity_MR.l(Regions_MR,"World","Meat",ProductionSystems,ProductionConditions,"Baseline") = 0;
VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VExportQuantity_MR.l(Regions_MR,"World","Milk",ProductionSystems,ProductionConditions,"Baseline") = 0;

*now we can do the DAQ = prod+imp-Exp for these commodities
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*sondition not needed as also predefined values must be consistent with DAQ=Prod+Imp-Exp
*                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%");


*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFTWDirDerFromPrim_Anim_NonGrassFed,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*14) Adjust total exports such as to be in the same relation as in the baseline:

*This code is used to adjust total global exports such as to have the same ratio over total global imports as in the baseline.
*This is needed in case imports are specified in the scenario specifications, as this does not fully translate to accordingly changed exports. DAQ of exporting countries is then accordingly adapted as well.

*IS THE FOLLOWING RELEVANT _ DO ONLY FOR ANIMAL COMMODITIES HERE?? - CHECK.
*DO THIS FOR ANIMAL COMMODITIES only to avoid double adjusting of cropscomm, as this is done with those already at the end of the crop tot Prod DAQ module - similar for Ref2050 modiule, then!!
*check/work with Exp/Imp ration global


AUX_VImportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VImportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
AUX_VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));

Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_VImportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = AUX_VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 /AUX_VImportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%");


$ontext;

NEW CODE - to be used here? Rather not, only for other scenarios than the FOFA BAU 2050

*for adjusting exports, for some scenarios, only part of the countries should be affected - e.g. assuming that the EU imports much less but does not change exports relative to production, etc.
*thus, we differentiate two groups of countries: Countries_NoExportScaling(Regions) and Countries_WithExportScaling(Regions), where e.g. the former would be an alias to the EU plus CH, the latter would be the rest.
*when doing so, we need toe following factor: "Global Exp/Imp ratio - no exp-scaling for some countries"
*formula: see separate sheet and in the documentation D4.1
AUX_VExportQuantity_MR.l("Countries - no exp scaling","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Countries_NoExportScaling,VExportQuantity_MR.l(Countries_NoExportScaling,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
AUX_VExportQuantity_MR.l("Countries - with exp scaling","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Countries_WithExportScaling,VExportQuantity_MR.l(Countries_WithExportScaling,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));

Commod_OtherChar_MR("World",Commodities_MR,"Global Exp/Imp corr factor - no exp-scaling for some countries",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"%Scenario%")
                         AND AUX_VExportQuantity_MR.l("Countries - with exp scaling","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ((Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"Baseline")
                 /Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *AUX_VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                                 - AUX_VExportQuantity_MR.l("Countries - no exp scaling","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                                         /AUX_VExportQuantity_MR.l("Countries - with exp scaling","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%");




VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR("World",Commodities_MR,"Global Exp/Imp corr factor - no exp-scaling for some countries",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_OtherChar_MR("World",Commodities_MR,"Global Exp/Imp corr factor - no exp-scaling for some countries",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                         /Commod_OtherChar_MR("World",Commodities_MR,"Global Exp/Imp corr factor - no exp-scaling for some countries",ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%");

*set =0 if negative values arise:
VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") <0)
         = 0;
$offtext;

*$ontext;
*Old code, with equal scaling for ALL countries:



VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"%Scenario%")
         = VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"Baseline")
                         /Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"Baseline")
                 - VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%");
*this may again result in negative values in case commodity quant is already zero (as e.g. it has become negative above, e.g. for meat meal), thus reset to zero again:
VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
*$offtext;



*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

$if NOT %Scenario% == "FOFA_BAU_2050" $goto NO_ImpExp_Recalibration



****To DO: ADJUST HERE _ 2050 Imp/Exp?????
*For the FOFA_BAU_2050 scenarion, calculating as above results in way too high per capita kcal values, etc.in many countries (there are FOFA_BAU_2050 total per capita kcal values available, which we should roughly replicate
*this is due to high DAQ values; Production seems in line with FOFA_BAU_2050, but there may be a need to adjust exports (or, for some countries also imports, in case total kcal per capita values are too low).
****BUT how exactly to do this?
****And after having done this - do we need to redo the adjustment from above on the exp/imp ratio??
****IF it is adjusted - is there a need to assign other parameters/variables to 2050 values in the SScenario definition, rather than assigning it to the Baseline

*this adjustment is driven by the calorie supply in the scenarios - hence make assignments conditional to commodities being used as food (where needed, see below), otherwise it may result in additional exports or imports for forage crops and grass, etc.

VCommod_Contents_MR.l(Regions_MR,Commodities_MR,"Calories (kcal)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"Calories (kcal)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Contents_MR.l(Regions_MR,Commodities_MR,"Protein (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"Protein (t)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Food_Contents_MR.l(Regions_MR,"All Commodities","Calories (kcal)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Commodities_MR,
                 VCommod_Contents_MR.l(Regions_MR,Commodities_MR,"Calories (kcal)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%"));
VCommod_Food_Contents_MR.l(Regions_MR,"All Commodities","Protein (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Commodities_MR,
                 VCommod_Contents_MR.l(Regions_MR,Commodities_MR,"Protein (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%"));

*derive per capita kcal etc supply:
Commod_OtherChar_MR(Regions_MR,"All Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","%Scenario%")
         = VCommod_Food_Contents_MR.l(Regions_MR,"All Commodities","Calories (kcal)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","%Scenario%")
                         /365;
Commod_OtherChar_MR(Regions_MR,"All Commodities","Protein per capita (g/cap/day)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","%Scenario%")
         = VCommod_Food_Contents_MR.l(Regions_MR,"All Commodities","Protein (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","%Scenario%")
                         *1000000/365;

*not all countries have FOFA 2050 pc calorie and protein values. If these are missing (for some small countries only), then use the BaselineDerived data *1.1 (i.e. assuming a 10% incease in calorie supply)
*for this, we need the BaselineDerived values:
VCommod_Contents_MR.l(Regions_MR,Commodities_MR,"Calories (kcal)",ProductionSystems,ProductionConditions,"BaselineDerived")
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"Calories (kcal)",ProductionSystems,ProductionConditions,"BaselineDerived");
VCommod_Contents_MR.l(Regions_MR,Commodities_MR,"Protein (t)",ProductionSystems,ProductionConditions,"BaselineDerived")
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"Protein (t)",ProductionSystems,ProductionConditions,"BaselineDerived");
VCommod_Food_Contents_MR.l(Regions_MR,"All Commodities","Calories (kcal)",ProductionSystems,ProductionConditions,"BaselineDerived")
         =sum(Commodities_MR,
                 VCommod_Contents_MR.l(Regions_MR,Commodities_MR,"Calories (kcal)",ProductionSystems,ProductionConditions,"BaselineDerived")
                         *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"BaselineDerived"));
VCommod_Food_Contents_MR.l(Regions_MR,"All Commodities","Protein (t)",ProductionSystems,ProductionConditions,"BaselineDerived")
         =sum(Commodities_MR,
                 VCommod_Contents_MR.l(Regions_MR,Commodities_MR,"Protein (t)",ProductionSystems,ProductionConditions,"BaselineDerived")
                         *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"BaselineDerived"));
*derive per capita kcal etc supply:
Commod_OtherChar_MR(Regions_MR,"All Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,ProductionConditions,"BaselineDerived")
                 $VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","BaselineDerived")
         = VCommod_Food_Contents_MR.l(Regions_MR,"All Commodities","Calories (kcal)",ProductionSystems,ProductionConditions,"BaselineDerived")
                 /VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","BaselineDerived")
                         /365;
Commod_OtherChar_MR(Regions_MR,"All Commodities","Protein per capita (g/cap/day)",ProductionSystems,ProductionConditions,"BaselineDerived")
                 $VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","BaselineDerived")
         = VCommod_Food_Contents_MR.l(Regions_MR,"All Commodities","Protein (t)",ProductionSystems,ProductionConditions,"BaselineDerived")
                 /VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","BaselineDerived")
                         *1000000/365;


Commod_OtherChar_MR(Regions_MR,"All Commodities","Cal pc - FOFA original (kcal/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                 $(NOT Commod_OtherChar_MR(Regions_MR,"All Commodities","Cal pc - FOFA original (kcal/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050"))
         = Commod_OtherChar_MR(Regions_MR,"All Commodities","Calories per capita (kcal/cap/day)","AllProdSyst","AllProdCond","BaselineDerived")*1.1;
Commod_OtherChar_MR(Regions_MR,"All Commodities","Prot pc - FOFA original (g/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                 $(NOT Commod_OtherChar_MR(Regions_MR,"All Commodities","Prot pc - FOFA original (g/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050"))
         = Commod_OtherChar_MR(Regions_MR,"All Commodities","Protein per capita (g/cap/day)","AllProdSyst","AllProdCond","BaselineDerived")*1.1;


*and also assign the following for the regions where it is missing:
*Vcommod_Food condition to avoid that unused PRoductionSystems are assigned
Commod_OtherChar_MR(Regions_MR,"All Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                 $(VCommod_Food_Contents_MR.l(Regions_MR,"All Commodities","Calories (kcal)",ProductionSystems,ProductionConditions,"%Scenario%")
                         AND (NOT Commod_OtherChar_MR(Regions_MR,"All Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")))
         = Commod_OtherChar_MR(Regions_MR,"All Commodities","Cal pc - FOFA original (kcal/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050");



Commod_OtherChar_MR(Regions_MR,"All Commodities","kcal_FOFA_2050 / kcal_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_OtherChar_MR(Regions_MR,"All Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,"All Commodities","Cal pc - FOFA original (kcal/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                 /Commod_OtherChar_MR(Regions_MR,"All Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions_MR,"All Commodities","Prot_FOFA_2050 / Prot_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_OtherChar_MR(Regions_MR,"All Commodities","Protein per capita (g/cap/day)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,"All Commodities","Prot pc - FOFA original (g/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                 /Commod_OtherChar_MR(Regions_MR,"All Commodities","Protein per capita (g/cap/day)",ProductionSystems,ProductionConditions,"%Scenario%");

*not needed, is it?
VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT Commod_OtherChar_MR(Regions_MR,"All Commodities","kcal_FOFA_2050 / kcal_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%");



$ontext;

VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                         AND (Commod_OtherChar_MR(Regions_MR,"All Commodities","kcal_FOFA_2050 / kcal_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%") <= 1))
         = VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                         *(1 - Commod_OtherChar_MR(Regions_MR,"All Commodities","kcal_FOFA_2050 / kcal_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%"));

VImportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                         AND (Commod_OtherChar_MR(Regions_MR,"All Commodities","kcal_FOFA_2050 / kcal_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%") > 1))
         = VImportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                         *(Commod_OtherChar_MR(Regions_MR,"All Commodities","kcal_FOFA_2050 / kcal_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%") - 1);

*Then adjust DAQ:
VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                         AND Commod_OtherChar_MR(Regions_MR,"All Commodities","kcal_FOFA_2050 / kcal_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions_MR,"All Commodities","kcal_FOFA_2050 / kcal_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%");

$offtext;

*here above I loose forage and grass quantity!! - to be corrected
*no, I think this is ok now, nothing lost - check, but I think it is ok.

*the formulae above: derived on paper, and in specific sections in D4.1 - to be added there.



*ANOTHER APPROACH TO ADJUST kcal values: change food/other (or partly maybe feed) util shares; as feed supply/demand ratio is often low, increasing feed would make it more consistent - and helt to reduce food kcal:
*for those commodities, where no feed is reported, it could be assigned to other, maybe reflecting waste, etc.
*util shares for 2050 - in particular feed - are anyway shaky....
*this works well, so stick to that.
*this also has the advantage that export/import ratios do not change but remain the same in FOFA 2050 as in the baseline - and there, the values are generally not too bad.

*below, the additional code in between is neded to restrict the values to be within [0,1]

Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                         $Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + (1 - Commod_OtherChar_MR(Regions_MR,"All Commodities","kcal_FOFA_2050 / kcal_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%") > 1)
         = 1;

Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                         $(NOT Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + (1 - Commod_OtherChar_MR(Regions_MR,"All Commodities","kcal_FOFA_2050 / kcal_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)",ProductionSystems,ProductionConditions,"%Scenario%") > 1)
         = 1;


Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_OtherChar_MR(Regions_MR,"All Commodities","kcal_FOFA_2050 / kcal_calc_2050",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%") > 1)
         = 1;



$label NO_ImpExp_Recalibration


*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX





*and recalculate for a final check:
AUX_VImportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VImportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
AUX_VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));

Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_VImportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = AUX_VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 /AUX_VImportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%");




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*15) Utilization of DAQ and some other values for commodities from animals WITHOUT grass in the feeding ration - second iteration

*the condition is dropped as the values are already there from the first iteration - but they need to be replaced

VCommod_Food_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Food_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Seed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Seed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util seed (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Processing_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Processing_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util processing (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Waste_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Waste_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util waste (share)",ProductionSystems,ProductionConditions,"%Scenario%");

VCommod_Other_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Other_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)",ProductionSystems,ProductionConditions,"%Scenario%");

*Dry matter and GE, ME and XP quantities:
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%");

*and again summed over feed groups:
*some entries are then lost - but these are not needed anymore (e.g. "FeedGE (MJ) - left after feeding ruminants")
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_Feed$Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_Feed,Commodities_FeedGroups),
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,Contents,ProductionSystems,ProductionConditions,"%Scenario%"));

$ontext;
*and add the main and byprod concentrates:
VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcentrates_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcMainProd_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcByProd_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%");

*and summed for the total:
VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedTotal_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedTotal_Commodity",Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR,
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,Contents,ProductionSystems,ProductionConditions,"%Scenario%"));
$offtext;

*derive Feed GE contents per DM for the feed commodities, feed groups and total feed:
Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

*feed groups separately, as they are usually not part of Commodities_MR
Commod_Contents_MR(Regions_MR,Commodities_FeedGroups,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*16) Detailed Feeding Ration
*they are given by FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
*thus calculate aggregates and contents now once more, after having derived the feed quantities for all commodities, including animal sourced ones:
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_FeedGroups,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed$Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_Feed,Commodities_FeedGroups),
                 FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedTotal_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed,
                 FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_FeedGroups,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed$Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_Feed,Commodities_FeedGroups),
                 FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedTotal_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed,
                 FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));





$ontext;

the following is not needed anymore, as already available in FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")

*the division below makes the code extremely slow - so avoid it by auxiliary variables:
AUX_VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcentrates_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcentrates_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 1/VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcentrates_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,ConcentrateCommodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcentrates_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Conc (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Feed_Contents_MR.l(Regions_MR,ConcentrateCommodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
*                         /VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcentrates_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
                         *AUX_VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcentrates_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
;
*and the same for the other feed groups:
AUX_VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedForageCrops_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedForageCrops_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 1/VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedForageCrops_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,ForageCommodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Forage (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Feed_Contents_MR.l(Regions_MR,ForageCommodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *AUX_VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedForageCrops_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

AUX_VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedGrass_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedGrass_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 1/VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedGrass_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,GrassCommodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Grass (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Feed_Contents_MR.l(Regions_MR,GrassCommodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *AUX_VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedGrass_Commodity","DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
$offtext;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*17) Derive feed requirements per APU

*for animals without herd structure, this is the same as per head: in relation to producing:
FeedingRationsAPU_Contents_MR(Regions_MR,Activities_MR,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%");
FeedingRationsAPU_Contents_MR(Regions_MR,Activities_MR,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%");
FeedingRationsAPU_Contents_MR(Regions_MR,Activities_MR,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%");

*and assign for animals with herd structure separately:
*first pigs: APU is one producing animal and all the others that come with it: thus: sum the weighted herd types, weights: relation of herd types to producing (derived from relation of herd types to living, and producing to living)
FeedingRationsAPU_Contents_MR(Regions_MR,"Pigs","Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(PigTypeInHerd,FeedingRationsHeads_OtherChar_MR(Regions_MR,"Pigs",PigTypeInHerd,Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs",PigTypeInHerd,"share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%"));
*and cattle:
FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(DairyCattleTypeInHerd,FeedingRationsHeads_OtherChar_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,"share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%"));
FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(BeefCattleTypeInHerd,FeedingRationsHeads_OtherChar_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,"share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%"));






*FOR LATER: derive animal specific feed contents!!


$exit;






some parts often used for the imp/exp scaling
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimaryAnimals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")
*scale by the import scale factor, as the global export stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFTWDirDerFromPrim_Animals_GrassFed,ProductionSystems,ProductionConditions,"%Scenario%")






not used anymore

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Derive animal commodity imports and exports

*3.1) Import and export values
*we need some aggregations to do the scalings below for deriving the import and export values in the scenarios:
*these are needed, as some commodities relate not to single activities, but to groups (e.g. some cheese relates to "All Ruminants", etc,)

*animal commodities are derived here, as now the animal production is available
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Ruminants",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Ruminants,VActAnimalsHead_Outputs_MR.l(Regions_MR,Ruminants,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"));
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Poultry",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Poultry,VActAnimalsHead_Outputs_MR.l(Regions_MR,Poultry,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"));
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Livestock_NoAggregates,VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock_NoAggregates,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"));
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Fish and Seafood",ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(FishAndSeafood,VActAnimalsHead_Outputs_MR.l(Regions_MR,FishAndSeafood,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"));


*the following are not yet assigned:

*"All other Animals"


$if %ReadNewImpExpScenarioDataAnimals% == "NO" $goto UseOldImpExpScenarioDataAnimals
*the code below runs for quite a long time, due to the many and large matching sets. Thus store the output in a separate file and load this if no new calculation is needed


PUTCLOSE con "   Begin derive animal imp/exp:" timeElapsed;

*In the following, some aggregate activities are needed, hence use Activities and NOT Activities_MR, as the latter does NOT contain these aggregates!!!!!

*adjust commodity export values to the changes in production of the corresponding prim prod /activity output:
*use the 2 matching sets referring to animal products from the CommodityTree module

*Set5 MatchCommAct_ComplexAnimalCommodities
*animal commodities are derived later, when the animal production is available
VExportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VExportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((Activities,OutputsAnimals,ProducingAnimals)$(MatchCommAct_ComplexAnimalCommodities(Commodities_MR,Activities,OutputsAnimals)
                         AND VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")),
                 VExportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                                 /VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));

*Set6 MatchCommAct_CommodEquivalentAct_Animals
*animal commodities are derived later, when the animal production is available
VExportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VExportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((Activities,OutputsAnimals,ProducingAnimals)$(MatchCommAct_CommodEquivalentAct_Animals(Commodities_MR,Activities,OutputsAnimals)
                         AND VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")),
                 VExportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                                 /VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));


*Set5 MatchCommAct_ComplexAnimalCommodities
*animal commodities are derived later, when the animal production is available
VImportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VImportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((Activities,OutputsAnimals,ProducingAnimals)$(MatchCommAct_ComplexAnimalCommodities(Commodities_MR,Activities,OutputsAnimals)
                         AND VActAnimalsHead_Outputs_MR.l(Regions_MR_2,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")),
                 VImportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *VActAnimalsHead_Outputs_MR.l(Regions_MR_2,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                                 /VActAnimalsHead_Outputs_MR.l(Regions_MR_2,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));

*Set6 MatchCommAct_CommodEquivalentAct_Animals
*animal commodities are derived later, when the animal production is available
VImportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VImportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((Activities,OutputsAnimals,ProducingAnimals)$(MatchCommAct_CommodEquivalentAct_Animals(Commodities_MR,Activities,OutputsAnimals)
                         AND VActAnimalsHead_Outputs_MR.l(Regions_MR_2,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")),
                 VImportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *VActAnimalsHead_Outputs_MR.l(Regions_MR_2,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                                 /VActAnimalsHead_Outputs_MR.l(Regions_MR_2,Activities,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline"));



PUTCLOSE con "   End derive animal imp/exp:" timeElapsed;

*the code above runs for quite a long time, due to the many and large matching sets. Thus store the output in a separate file and load this if no new calculation is needed

VImportStorageAUX2_VImportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)
         = VImportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios);
VExportStorageAUX2_VExportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)
         = VExportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios);


execute_unload "Store_ImpExpQuantAnimals_Scenarios"
VImportStorageAUX2_VImportQuantity_MR
VExportStorageAUX2_VExportQuantity_MR
;

$goto EndOf_DeriveAnimalCommodImpExp

$label UseOldImpExpScenarioDataAnimals

*the following is needed to load it only once - otherwise it causes errors
$if NOT %Scenario% == "BaselineDerived" $goto EndOf_DeriveAnimalCommodImpExp


$gdxin Store_ImpExpQuantAnimals_Scenarios.gdx
$load VImportStorageAUX2_VImportQuantity_MR
$load VExportStorageAUX2_VExportQuantity_MR
$gdxin

*assign to model variables:
VImportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VImportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios))
         = VImportStorageAUX2_VImportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios);
VExportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VExportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios))
         = VExportStorageAUX2_VExportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios);

*delete auxiliary variables:
VImportStorageAUX2_VImportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) = 0;
VExportStorageAUX2_VExportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) = 0;

$label EndOf_DeriveAnimalCommodImpExp












