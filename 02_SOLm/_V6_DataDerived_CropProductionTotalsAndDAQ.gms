PUTCLOSE con,"_V6_DataDerived_CropProductionTotalsAndDAQ";

*GENERAL DESCRIPTION
*This file contains the calculations to derive total crop production (areas*yields) and DAQs (Prod + Imports - Exports)

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Total crop production
- 2) Commodities
         2.1) Production of primary products as commodities
         2.2) Productiion, Import, export and DAQ values for commodities that are not primary products as commodities
                 2.2.1) Commodities that directly correspond to primary products from activities but are mostly named differently
                 2.2.2) Derived commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
                 2.2.3) Crop commodities that are pooled from primary commodities plus derived products
                 2.2.4) Remaining complex commodities (beer, sweeteners, beverages)
- 3) Adjust total exports such as to be in the same relation as in the baseline:
- 4) Utilization of DAQ and Some further commodity-related calculations
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Total crop production
*Total animal production is derived later, based on feed availability and feed requirements, related livestock numbers and yields

*First, derive land use as input (ha per ton main output 1):
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Land use per Mainoutput1 (ha)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 1/ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%");

*total crop production:
VActCropsGrass_Outputs_MR.l(Regions_MR,Activities_MR,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%");

*the following: total area or seed quantity, for example
VActCropsGrass_Inputs_MR.l(Regions_MR,Activities_MR,InputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,InputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%");

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Commodities

*2.1) Production of primary products as commodities
*Use the sets Match_ActivityOutputsToCommodities_Crops(Activities,OutputsCropsGrass,Commodities)
*to link production from activities to primary commodities PRODUCTION level (not DAQ) - equal the activity outputs to these commodities by these matching sets.
*Derive DAQ by adding imports, subtracting exports and accounting for stock changes
*these are then the quantities for the primary products, - all processed (e.g. wheat flour from wheat) can then be derived from this basis

*Animal primary commodity production is derived later, based on the activity output that is derived later from feed availability and feed requirements, related livestock numbers and yields
*        animal commodities then use the file Match_ActivityOutputsToCommodities_Animals(Activities,OutputsAnimals,Commodities)

*Assign the single activity outputs to corresponding commodity quantities - i.e. for the commodities, that are identical to the activities
VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Activities_MR,OutputsCropsGrass)$Match_ActivityOutputsToCommodities_Crops(Activities_MR,OutputsCropsGrass,Commodities_MR),
                 VActCropsGrass_Outputs_MR.l(Regions_MR,Activities_MR,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));




*2.2) Production, Import, export and DAQ values for commodities that are not primary products as commodities

$ontext;
*here, the prod, imp, exp, DAQ values are calculated for the commodities as listed in Set CommoditiesDAQ_TradeFromToWorld(Commodities)
*these commodities come in three types, captured in three sets, and some corresponding matching sets needed in the code:
         Set CommoditiesDAQ_TradeFromToWorldPrimary(Commodities) "Commodity set - only PRIMARY commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"
         Set CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary(Commodities) Derived commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available
         Set CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts(Commodities) "crop commodities that are pooled from primary commodities plus derived products"
matching sets:
         Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsPrimary(Commodities,Activities,OutputsCropsGrass) "Matching set to match the crop commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsDerived(Commodities,Activities,OutputsCropsGrass) "Matching set to match the crop commodities used for the basic trade calculations with the corresponding activities - used to derive the change in production of these commodities, if the production of the activities changes, for example"
         Set MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_CropsDerived(Commodities,Commodities_2)  "Matching the derived commodities that are derived from primary commodities as captured in the previous set - DAQ and trade calculations for them are different than for the other derived commodities)
         Set MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(Commodities,Activities,OutputsCropsGrass) "Matching set to match the crop commodities that are pooled from primary commodities plus derived products with the underlying activity"
$offtext;

*the import/export values are done on the basis of to/from WORLD values - as we are interested in the DAQs in the main model code, not in the origin of the commodities. The origin is used later after the main model run when deriving impacts embodied in imported commodities

*animal commodities are derived later, when the animal production is available


*2.2.1) Commodities that directly correspond to primary products from activities but are mostly named differently

*these are collected in the Set CommoditiesDAQ_TradeFromToWorldPrimary(Commodities) "Commodity set - only PRIMARY commodities that are produced in a country from an activity only, not from imported commodities - used for the basic trade calculations ...cf. explanations to the other  sets above"

*Do the assignment for other primary commodities that are not identically named as activites but correspond to activity outputs (maybe aggregated), by scaling the commodity production from the baseline

*we need some aggregations to do the scalings in the various calculations below for deriving the import and export values in the scenarios:
*these are needed, as some commodities relate not to single activities, but to groups (e.g. Brans relates to "All Cereals", etc,)
VActCropsGrass_Outputs_MR.l(Regions_MR,"All other citrus",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(CitrusFruits,VActCropsGrass_Outputs_MR.l(Regions_MR,CitrusFruits,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
                 - VActCropsGrass_Outputs_MR.l(Regions_MR,"Oranges",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                 - VActCropsGrass_Outputs_MR.l(Regions_MR,"Lemons and limes",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%");
VActCropsGrass_Outputs_MR.l(Regions_MR,"All Fruits",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Fruits,VActCropsGrass_Outputs_MR.l(Regions_MR,Fruits,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_Outputs_MR.l(Regions,"Other Cereals",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(OtherCereals,VActCropsGrass_Outputs_MR.l(Regions,OtherCereals,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All other oilcrops",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(OtherOilcrops,VActCropsGrass_Outputs_MR.l(Regions_MR,OtherOilcrops,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_Outputs_MR.l(Regions_MR,"All other roots",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(StarchyRoots,VActCropsGrass_Outputs_MR.l(Regions_MR,StarchyRoots,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_Outputs_MR.l(Regions_MR,"Rape and Mustard seed",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_Outputs_MR.l(Regions_MR,"Rapeseed",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_Outputs_MR.l(Regions_MR,"Mustard seed",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%");

VActCropsGrass_Outputs_MR.l(Regions_MR,"Jute & Jute-like Fibres",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(FibresNotCotton,VActCropsGrass_Outputs_MR.l(Regions_MR,FibresNotCotton,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_Outputs_MR.l(Regions_MR,"All other soft fibres",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(FibresNotCotton,VActCropsGrass_Outputs_MR.l(Regions_MR,FibresNotCotton,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_Outputs_MR.l(Regions_MR,"All other hard fibres",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(FibresNotCotton,VActCropsGrass_Outputs_MR.l(Regions_MR,FibresNotCotton,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All Spices",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Spices,VActCropsGrass_Outputs_MR.l(Regions_MR,Spices,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_Outputs_MR.l(Regions_MR,"All other Spices",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Spices,VActCropsGrass_Outputs_MR.l(Regions_MR,Spices,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_Outputs_MR.l(Regions_MR,"All other vegetables",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(OtherVegetables,VActCropsGrass_Outputs_MR.l(Regions_MR,OtherVegetables,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));

VActCropsGrass_Outputs_MR.l(Regions_MR,"Pulses,Total",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Pulses,VActCropsGrass_Outputs_MR.l(Regions_MR,Pulses,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All nuts",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Treenuts,VActCropsGrass_Outputs_MR.l(Regions_MR,Treenuts,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All sugar crops",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(SugarCrops,VActCropsGrass_Outputs_MR.l(Regions_MR,SugarCrops,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));

*derive an auxiliary variable to make the code faster:
*$if not %Scenario% == "Baseline" $goto EndAuxVarDef
*$if-statement results in an error - hence do not use
*we need it for aggregates as well, thus do not use activities_MR but Activities!
*already done in the Baseline values for model runs module:
*AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*                 $VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");
*$label EndAuxVarDef

*then do the calculation:

*we need it for aggregates as well, thus do not use activities_MR but Activities!
VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((Activities,OutputsCropsGrass)$MatchCommAct_CommoditiesDAQ_TradeFromToWorld_CropsPrimary(Commodities_MR,Activities,OutputsCropsGrass),
                  VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

*then do adjustments of imports of the primary commodities, based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%"));

*the condition is needed to allow for predefined values on imports, etc. from scenario specifications,
*for the commodities in this section, this is not possible for the commod production, as this directly relates to the cropping areas
VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline")
                           - VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline")
                          *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                                 - VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline")
                                 - VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline"));


*above: take World production MINUS domestic production for scaling!! - as imports come from abroad only! DONE - COMMENT CAN BE DELETED


*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria exporting bananas without reporting production of Bananas) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline")
                          *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline"));

*some further calculations needed in case there are exports but no domestic production or imports (e.g. for palm kernels in Australia):
*        in this case, scale with total world production of the underlying activity, as then, the exports are entirely based on imports, that are dependent on world production
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"Baseline");


*now we can do the DAQ = prod+imp-Exp for the primary commodities - this is then the basis for deriving the derived commodity production plus the imp/exp/DAQ calculations for those
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldPrimary,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


*2.2.2) Derived commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available

*these are collected in the Set CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary(Commodities) Derived commodities that are directly derived from primary commodities for which trade and production data and thus DAQ are available

*for derived commodities that are derived from primary commodities as calculated above, do the production based on baseline production scaled by DAQ of the parent product (i.e. soyabeans for soyabean cake, etc.) in the scenario and baseline;

*first, we need the "Sugar crops" aggregate for deriving Molasse, as this is not yet available:
VCommod_Quantity_MR.l(Regions_MR,"Sugar crops",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(Regions_MR,"Sugar beet",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VCommod_Quantity_MR.l(Regions_MR,"Sugar cane",ProductionSystems,ProductionConditions,"%Scenario%");
VExportQuantity_MR.l(Regions_MR,"World","Sugar crops",ProductionSystems,ProductionConditions,"%Scenario%")
         = VExportQuantity_MR.l(Regions_MR,"World","Sugar beet",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VExportQuantity_MR.l(Regions_MR,"World","Sugar cane",ProductionSystems,ProductionConditions,"%Scenario%");


*derive an auxiliary variable to make the code faster:
*$if not %Scenario% == "Baseline" $goto EndAuxVarDef2
*$if-statement results in an error - hence do not use
*for Baseline: *already done in the Baseline values for model runs module:
*AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
*                 $VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline");
*$label EndAuxVarDef2


VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR_2$MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_CropsDerived(CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,Commodities_MR_2),
                 VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline")
                         *VCommod_Quantity_MR.l(Regions_MR,Commodities_MR_2,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VCommod_Quantity_MR.l(Regions_MR,Commodities_MR_2,ProductionSystems,ProductionConditions,"Baseline"));

*in case there is no Commod_Quant reported for the parent product, e.g. for palm kernels for Cambodia, derive the production from global export values for the parent commodity, as this may be the best scaling-proxy to be used:
VExportQuantity_MR.l("World","World",Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World",Commodities,ProductionSystems,ProductionConditions,"%Scenario%"));
*for Baseline: *already done in the Baseline values for model runs module:
*VExportQuantity_MR.l("World","World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline"));

*AUX_Inverse_VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
*                 $VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
*         = 1/VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR_2$MatchPrimDerivedCommodities_DAQ_TradeFromToWorld_CropsDerived(CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,Commodities_MR_2),
                 VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline")
*scale by the import scale factor, as the global export stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                         *(VExportQuantity_MR.l("World","World",Commodities_MR_2,ProductionSystems,ProductionConditions,"%Scenario%")
                                         - VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR_2,ProductionSystems,ProductionConditions,"%Scenario%"))
                                 *AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions_MR,"World",Commodities_MR_2,ProductionSystems,ProductionConditions,"Baseline"));


*TO BE CORRECTED
*ALSO CORRECT exports by exports FROM country TO WORLD - as those are not used as production basis?    DONE - COMMENT CAN BE DELETED


*then do imports and exports as above.

*again, first do adjustments of imports of the primary commodities, based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%"));



VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline")
                                 - VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                                 - VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l("World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline")
                                 - VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline"));

*TO BE CORRECTED
*above: take World production MINUS domestic production for scaling!! - as imports come from abroad only!  DONE - COMMENT CAN BE DELETED


*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria importing soyabean as a basis for soyabeancake, besides the basis from domestic soyabean production) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,Productionsystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"Baseline"));

*now we can do the DAQ = prod+imp-Exp for these commodities
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldDirectlyDerivedFromPrimary,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


*2.2.3) Crop commodities that are pooled from primary commodities plus derived products


*TO BE CORRECTED
$ontext;
GO ON HERE!!

WHY HERE FIRST export and not PRODUCTION???????? as above? Change!!

scale imports from world with total world production - domestic production?

redo this scaling of commod-prod, imp and exp (DAQ = prod + imp - exp - that is clear!)


First Production comod : scales with production plus import of underlying activities-commodities (
imports scales with production elsewhere
exports scale with production plus imports

MAYBE:
imports: sclae with production of underlying stuff abroad;
production scales with domestic prod of udnerlying stuff PLUS imports (OK also for cases where we have low produciton, but large imports/exports in the baseline? Check!! yes, ok, as th elarge impoirts in the baseline are already part of the scale factor)
exports: scale with production domestic (imports are already accounted for in the scaling for production jst before)
$offtext;



*these are collected in the Set CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts(Commodities) "Crop commodities that are pooled from primary commodities plus derived products"

*now do the commodities that are pooled with their products, such as "wheat and products", for this, assume the following:
*- assume that exports of these commodities are mainly in the form of unprocessed commodities, thus assume: exports to World scale with domestic production of the underlying activity (i.e. "Wheat" for "Wheat and products")
*        if this then results in zero exports due to zero production of the underlying activity, scale with total world production of the underlying activity, as then, the exports are entirely based on imports, that are dependent on world production
*- imports to a country from WORLD scale with total WORLD exports of the commodity
*- domestic production scales with the sum of production of the underlying activity PLUS imports (which is compatible as it is all measured in primary products).

VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum((Activities,OutputsCropsGrass)$MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,Activities,OutputsCropsGrass),
                  VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
                         *AUX_BaselineProdLargerThanExports_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));

*some further calculations needed in case there are exports but no domestic production:
*        in this case, scale with total world production of the underlying activity, as then, the exports are entirely based on imports, that are dependent on world production

VActCropsGrass_Outputs_MR.l("World",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"));
*for Baseline: *already done in the Baseline values for model runs module:
*VActCropsGrass_Outputs_MR.l("World",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Regions_MR,VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));


$ontext;
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
         $((NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%"))
                 AND VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline"))
         = VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum((Activities,OutputsCropsGrass)$(MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,Activities,OutputsCropsGrass)
                                 AND VActCropsGrass_Outputs_MR.l("World",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")),
                         VActCropsGrass_Outputs_MR.l("World",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                                 /VActCropsGrass_Outputs_MR.l("World",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));
$offtext;



*do a combined code that also accounts for exports being larger than domestic production WITHOUT the latter being zero (but it can well be): in this case, part of the exports come from imports,
*thus scale this part with global production (second approach above) and part with domestic production (fist approach above)
*Thus: Exp_Total = Exp_FromWorld + Exp_DomesticProd
*identify the parts as follows: Exp_FromWorld = Exp_Total - DomesticProd; Exp_DomesticProd = DomesticProd
*part with the absolute value: to only retain if exports are larger than production; otherwise it would become negative; then scale this part of exports that are larger than prod with the produciton abroad without domestic production
*thus:
VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
         $((NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%"))
*                 AND VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline"))
)
         = (    (VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
                         - sum((Activities,OutputsCropsGrass)$MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,Activities,OutputsCropsGrass),
                                 VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")))
           +abs((VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
                         - sum((Activities,OutputsCropsGrass)$MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,Activities,OutputsCropsGrass),
                                 VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"))))   )/2
                                           *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum((Activities,OutputsCropsGrass)$(MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,Activities,OutputsCropsGrass)
                                 AND (VActCropsGrass_Outputs_MR.l("World",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
                                         - VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"))),
                         (VActCropsGrass_Outputs_MR.l("World",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                                         - VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
                                 /(VActCropsGrass_Outputs_MR.l("World",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
                                         - VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")))

*VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%"))
*         =
          + sum((Activities,OutputsCropsGrass)$MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,Activities,OutputsCropsGrass),
                  VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                                 *AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"));


*for Baseline: *already done in the Baseline values for model runs module:
*VExportQuantity_MR.l("World","World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
*         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline"));
VExportQuantity_MR.l("World","World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%"));


VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l("World","World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                 *VExportQuantity_MR.l("World","World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                          /VExportQuantity_MR.l("World","World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline");


*for the following, we need some further auxiliary variable to simplify the code:
AUX_ProdPlusImport_VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((Activities,OutputsCropsGrass)$MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,Activities,OutputsCropsGrass),
                 VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
                         + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%");
*for Baseline: *already done in the Baseline values for model runs module:
*AUX_ProdPlusImport_VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
*         =sum((Activities,OutputsCropsGrass)$MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,Activities,OutputsCropsGrass),
*                 VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline"))
*                         + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(AUX_ProdPlusImport_VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")))
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline")
                 *AUX_ProdPlusImport_VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                         /AUX_ProdPlusImport_VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"Baseline");

*now we can do the DAQ = prod+imp-Exp for thesecommodities
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%");


*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;




*2.2.4) Remaining complex commodities (beer, sweeteners, beverages)

*here, some complex commodities are treated individually; these are:
$ontext;
"Beer"."All Cereals"."MainOutput1 (t)"
"Sweeteners, Other"."All other sugar sources"."MainOutput1 (t)"
"Alcohol, Non-Food"."All Crops"."MainOutput1 (t)"
"Beverages, Alcoholic"."All Crops"."MainOutput1 (t)"
"Beverages, Fermented"."All Crops"."MainOutput1 (t)"
$offtext;


*"Beer"."All Cereals"."MainOutput1 (t)"
*For the calculations, assume that beer is derived from the DAQ of Barley (as explained in FAOSTAT on the commodity Beer), thus use the following only
$ontext;
"Barley and products"
$offtext;

*scale by food util of barley only
VCommod_Production_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Barley and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline"))
                    AND (NOT VCommod_Production_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VCommod_Production_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"Baseline")
                 *VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR(Regions_MR,"Barley and products","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /(VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Barley and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline"));


*then we can go on as in 2.2.1):
*i.e. do adjustments of imports of beer based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World","Beer",ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"%Scenario%"));

*the condition is needed to allow for predefined values on imports, etc. from scenario specifications,
VImportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World","Beer",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World","Beer",ProductionSystems,ProductionConditions,"Baseline");

*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria exporting bananas without reporting production of Bananas) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"Baseline"));

*some further calculations needed in case there are exports but no domestic production or imports (e.g. for palm kernels in Australia):
*        in this case, scale with total world production of the underlying activity, as then, the exports are entirely based on imports, that are dependent on world production
VExportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World","Beer",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World","Beer",ProductionSystems,ProductionConditions,"Baseline");


*now we can do the DAQ = prod+imp-Exp for the primary commodities - this is then the basis for deriving the derived commodity production plus the imp/exp/DAQ calculations for those
VCommod_Quantity_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Quantity_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World","Beer",ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,"Beer",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


*"Sweeteners, Other"."All other sugar sources"."MainOutput1 (t)"
*For the calculations, assume that "Sweeteners, other" are derived from the DAQs of all cereals plus roots and tubers plus sugar cane and beet (as it is glucose, fructose, etc. - which largely stems from starch; plus some stuff derived from sugar crops, etc.)
*thus use the following
$ontext;
"Cereals, Other"
"Rice (Paddy Equivalent)"
"Barley and products"
"Maize and products"
"Wheat and products"
"Sweet potatoes"
"Yams"
"Roots, Other"
"Potatoes and products"
"Molasses"
"sugar cane"
"sugar beet"
$offtext;
*the structure of the calculations is then the same as for beer:

VCommod_Production_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Quantity_MR.l(Regions_MR,"Cereals, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sweet potatoes",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Yams",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Roots, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Potatoes and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Molasses",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar cane",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar beet",ProductionSystems,ProductionConditions,"Baseline"))
                    AND (NOT VCommod_Production_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VCommod_Production_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline")
                 *(VCommod_Quantity_MR.l(Regions_MR,"Cereals, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sweet potatoes",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Yams",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Roots, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Potatoes and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Molasses",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar cane",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar beet",ProductionSystems,ProductionConditions,"%Scenario%"))
                 /(VCommod_Quantity_MR.l(Regions_MR,"Cereals, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sweet potatoes",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Yams",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Roots, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Potatoes and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Molasses",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar cane",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar beet",ProductionSystems,ProductionConditions,"Baseline"));

*then we can go on as in 2.2.1):
*i.e. do adjustments of imports of "Sweeteners, Other" based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World","Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%"));

*the condition is needed to allow for predefined values on imports, etc. from scenario specifications,
VImportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World","Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World","Sweeteners, other",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World","Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline");

*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria exporting bananas without reporting production of Bananas) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World","Sweeteners, other",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline"));

*some further calculations needed in case there are exports but no domestic production or imports (e.g. for palm kernels in Australia):
*        in this case, scale with total world production of the underlying activity, as then, the exports are entirely based on imports, that are dependent on world production
VExportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World","Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World","Sweeteners, Other",ProductionSystems,ProductionConditions,"Baseline");


*now we can do the DAQ = prod+imp-Exp for the primary commodities - this is then the basis for deriving the derived commodity production plus the imp/exp/DAQ calculations for those
VCommod_Quantity_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Quantity_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World","Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,"Sweeteners, Other",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


*"Beverages, Fermented"."All Crops"."MainOutput1 (t)"
*2657."Beverages, Fermented"
*        "Default composition: 26 Beverages, fermented wheat, 39 Beverages, fermented rice, 66 Beer of maize, 82 Beer of millet, 86 Beer of sorghum, 517 Cider etc"
*For the calculations, assume that "Beverages, Fermented" are derived from the DAQ of the following crops (as explained in FAOSTAT on the commodity Beer), thus use the following only
*thus use the following
$ontext;
"Wheat and products"
"Rice (Paddy Equivalent)"
"Maize and products"
"Millet and products"
"Sorghum and products"
"Apples and products"
$offtext;
*the structure of the calculations is then the same as for beer:

*scale by food util for all commodities - currently added for maize and wheat only, where feed util can be significant
VCommod_Production_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Wheat and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Maize and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Millet and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sorghum and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Apples and products",ProductionSystems,ProductionConditions,"Baseline"))
                    AND (NOT VCommod_Production_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VCommod_Production_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline")
                 *(VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR(Regions_MR,"Wheat and products","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR(Regions_MR,"Maize and products","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Millet and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sorghum and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Apples and products",ProductionSystems,ProductionConditions,"%Scenario%"))
                 /(VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Wheat and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Maize and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Millet and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sorghum and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Apples and products",ProductionSystems,ProductionConditions,"Baseline"));

*then we can go on as in 2.2.1):
*i.e. do adjustments of imports of "Sweeteners, Other" based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World","Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%"));

*the condition is needed to allow for predefined values on imports, etc. from scenario specifications,
VImportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World","Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World","Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline");

*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria exporting bananas without reporting production of Bananas) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline"));

*some further calculations needed in case there are exports but no domestic production or imports (e.g. for palm kernels in Australia):
*        in this case, scale with total world production of the underlying activity, as then, the exports are entirely based on imports, that are dependent on world production
VExportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World","Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World","Beverages, Fermented",ProductionSystems,ProductionConditions,"Baseline");


*now we can do the DAQ = prod+imp-Exp for the primary commodities - this is then the basis for deriving the derived commodity production plus the imp/exp/DAQ calculations for those
VCommod_Quantity_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Quantity_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World","Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,"Beverages, Fermented",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


*"Beverages, Alcoholic"."All Crops"."MainOutput1 (t)"
*2658."Beverages, Alcoholic"
*        "Default composition: 634 Beverages, distilled alcoholic"
*634."Beverages, distilled alcoholic"
*        "Includes undenatured ethyl alcohol (strength by volume < 80%) spirits, liqueurs and other spirituous beverages and preparations."
*this is made from starch (cereals, roots) and fruits, thus use the following:
$ontext;
"Barley and products"
"Cereals, Other"
"Maize and products"
"Millet and products"
"Rice (Paddy Equivalent)"
"Rye and products"
"Sorghum and products"
"Wheat and products"
"Cassava and products"
"Potatoes and products"
"Roots, Other"
"Sweet potatoes"
"sugar beet"
"sugar cane"
"Apples and products"
"Fruits, Others"
"Grape and products"
$offtext;
*the structure of the calculations is then the same as for beer:

*scale by food util of most important commodities only (keeping all of the rest)
VCommod_Production_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                $((VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Barley and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cereals, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Maize and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Millet and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rye and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sorghum and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Wheat and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cassava and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Potatoes and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Roots, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sweet potatoes",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar beet",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar cane",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Apples and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Fruits, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Grapes and products (excl wine)",ProductionSystems,ProductionConditions,"Baseline"))
                    AND (NOT VCommod_Production_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VCommod_Production_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline")
                 *(VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR(Regions_MR,"Barley and products","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cereals, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR(Regions_MR,"Maize and products","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Millet and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rye and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sorghum and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR(Regions_MR,"Wheat and products","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cassava and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Potatoes and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Roots, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sweet potatoes",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar beet",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar cane",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Apples and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Fruits, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Grapes and products (excl wine)",ProductionSystems,ProductionConditions,"%Scenario%"))
                 /(VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Barley and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cereals, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Maize and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Millet and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rye and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sorghum and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(Regions_MR,"Wheat and products","Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cassava and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Potatoes and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Roots, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sweet potatoes",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar beet",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar cane",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Apples and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Fruits, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Grapes and products (excl wine)",ProductionSystems,ProductionConditions,"Baseline"));

*then we can go on as in 2.2.1):
*i.e. do adjustments of imports of "Sweeteners, Other" based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%"));

*the condition is needed to allow for predefined values on imports, etc. from scenario specifications,
VImportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline");

*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria exporting bananas without reporting production of Bananas) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline"));

*some further calculations needed in case there are exports but no domestic production or imports (e.g. for palm kernels in Australia):
*        in this case, scale with total world production of the underlying activity, as then, the exports are entirely based on imports, that are dependent on world production
VExportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"Baseline");


*now we can do the DAQ = prod+imp-Exp for the primary commodities - this is then the basis for deriving the derived commodity production plus the imp/exp/DAQ calculations for those
VCommod_Quantity_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Quantity_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World","Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,"Beverages, Alcoholic",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*"Alcohol, Non-Food"."All Crops"."MainOutput1 (t)"
*no further specification from FAOSTAT
*this is done as "Beverages, Alcoholic" as the latter are distilled as well, so similar to produce alcohol for industry.
*thus, do as follows:
*the structure of the calculations is then the same as for beer:

VCommod_Production_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                $((VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cereals, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Millet and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rye and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sorghum and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cassava and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Potatoes and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Roots, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sweet potatoes",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar beet",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar cane",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Apples and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Fruits, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Grapes and products (excl wine)",ProductionSystems,ProductionConditions,"Baseline"))
                    AND (NOT VCommod_Production_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VCommod_Production_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline")
                 *(VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cereals, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Millet and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rye and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sorghum and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cassava and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Potatoes and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Roots, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sweet potatoes",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar beet",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar cane",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Apples and products",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Fruits, Other",ProductionSystems,ProductionConditions,"%Scenario%")
                  +VCommod_Quantity_MR.l(Regions_MR,"Grapes and products (excl wine)",ProductionSystems,ProductionConditions,"%Scenario%"))
                 /(VCommod_Quantity_MR.l(Regions_MR,"Barley and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cereals, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Maize and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Millet and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Rye and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sorghum and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Cassava and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Potatoes and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Roots, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Sweet potatoes",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar beet",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"sugar cane",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Apples and products",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Fruits, Other",ProductionSystems,ProductionConditions,"Baseline")
                  +VCommod_Quantity_MR.l(Regions_MR,"Grapes and products (excl wine)",ProductionSystems,ProductionConditions,"Baseline"));

*then we can go on as in 2.2.1):
*i.e. do adjustments of imports of "Sweeteners, Other" based on the change of total world volume produced (as here we look at imports from "World" only)
*for this, we first need to derive world-production in the baseline and scenarios, and then we can derive the imports from World:
*for Baseline: *already done in the Baseline values for model runs module:
*VCommod_Production_MR.l("World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline")
*         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline"));
VCommod_Production_MR.l("World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Regions_MR,VCommod_Production_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%"));

*the condition is needed to allow for predefined values on imports, etc. from scenario specifications,
VImportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VImportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VImportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline")
                                   *ImportScaleFactor_MR(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline");

*then do the adjustment of exports for the primary commodities, i.e. those that are produced domestically direct from activity outputs only and not from imported commodities
*HOWEVER - imports play a role as re-exporting can occur (e.g. Austria exporting bananas without reporting production of Bananas) - thus scale the exports with the sum of production plus imports:
VExportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((VCommod_Production_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline"))
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VCommod_Production_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%"))
                         /(VCommod_Production_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline")
                                 + VImportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline"));

*some further calculations needed in case there are exports but no domestic production or imports (e.g. for palm kernels in Australia):
*        in this case, scale with total world production of the underlying activity, as then, the exports are entirely based on imports, that are dependent on world production
VExportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l("World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT VExportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")))
         = VExportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline")
                                   *ExportScaleFactor_MR(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
*scale in addition by the import scale factor, as the global production stands for the potential to import the source commodity for production of this: if imports are rather reduced in a scenario, this should be reflected here as well.
                                   *ImportScaleFactor_MR(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCommod_Production_MR.l("World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCommod_Production_MR.l("World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"Baseline");


*now we can do the DAQ = prod+imp-Exp for the primary commodities - this is then the basis for deriving the derived commodity production plus the imp/exp/DAQ calculations for those
VCommod_Quantity_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Quantity_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VCommod_Production_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VImportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                 - VExportQuantity_MR.l(Regions_MR,"World","Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero in case results in negative values:
VCommod_Quantity_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Quantity_MR.l(Regions_MR,"Alcohol, Non-Food",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Adjust total exports such as to be in the same relation as in the baseline:

*This code is used to adjust total global exports such as to have the same ratio over total global imports as in the baseline.
*This is needed in case imports are specified in the scenario specifications, as this does not fully translate to accordingly changed exports. DAQ of exporting countries is then accordingly adapted as well.

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

*set =0 if negative values arise:
VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") <0)
         = 0;
*$offtext;

*and recalculate for a final check:
AUX_VImportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VImportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
AUX_VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         =sum(Regions_MR,VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));

Commod_OtherChar_MR("World",Commodities_MR,"Global Export/Import ratio",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_VImportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = AUX_VExportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 /AUX_VImportQuantity_MR.l("World","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%");


*and then assign the following factor to be used in the derivations of scenarios that have FOFA_BAU_2050 as reference
AUX_BaselineProdLargerThanExports_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
         = (1 - sign(VExportQuantity_MR.l(Regions_MR,"World",CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,ProductionSystems,ProductionConditions,"%Scenario%")
                         - sum((Activities,OutputsCropsGrass)$MatchCommAct_CommodDAQ_TradeFTWorld_CropCommodAndProducts(CommoditiesDAQ_TradeFromToWorldCropCommodAndProducts,Activities,OutputsCropsGrass),
                                 VActCropsGrass_Outputs_MR.l(Regions_MR,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))))/2;

*$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Utilization of DAQ and Some further commodity-related calculations

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





*derive contents in the DAQs in the country:
VCommod_Contents_MR.l(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,"%Scenario%");

*derive contents in the waste quantities in the country:
VCommod_Waste_Contents_MR.l(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Waste_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,"%Scenario%");

*derive contents in the food quantities in the country:
VCommod_Food_Contents_MR.l(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Food_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,"%Scenario%");

*derive the biomass quantities from shells, etc. that are e.g. used for bioenergy:
VCommod_OtherChar_MR.l(Regions_MR,Commodities_MR,"shells etc. for bioenergy (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Activities_MR$Match_ShellsEtc_Activities(Activities_MR, Commodities_MR),
                 VActCropsGrass_Outputs_MR.l(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ExtractionRate_CommodityTree(Regions_MR,Commodities_MR));


*XXXXXXXXXXXXXXXX kray: added here

*the following quantity is needed to calculate nutrient production per country (not DAQ)
VCommod_Contents_Prod_MR.l(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,"%Scenario%");



execute_unload 'Test_Commod'
VCommod_Contents_MR
VCommod_Quantity_MR
Commod_Contents_MR;
*XXXXXXXXXXXXXXXX kray: added here

$exit;

