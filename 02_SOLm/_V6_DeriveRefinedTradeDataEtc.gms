PUTCLOSE con,"_V6_DeriveRefinedTradeDataEtc";

*GENERAL DESCRIPTION
*This file contains code to derive country-country trade data for the scenarios from the country-from/to-World trade data that is used in SOLmV6 scenario calculations.
*Basically, it takes thes from/to-World flows and uses them to scale the baseline country-country-trade flows for the commodities where the latter data is available
*this is governed by a specific matching set between these commodities where data on country-country-level is available and where only country-world level is available

*this file also derives some additional values needed, such as commodity production and quantities in primary product equivalents, etc.

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Derive detailed trade data
- 2) Derive commodity production and quantity in primary product equivalents
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Derive detailed trade data

*use the following matching file:
*Set MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,Commodities_2)
*and do the following calculations:
$ontext;
We have data on from/to world trade for all countries for a number of commodities for all scenarios

We have data on country-country trade for all countries for a number of MOSTLY OTHER commodities for the baseline

For some calculations (e.g. in UNISECO) we need trade between regions, such as EU and Rest of the World.
To derive this for all scenarios, we need the country-country trade, as we cannot derive it from the from/to World trade

We thus derive the country-country trade for scenarios as follows (C1,C": two countries; Commod1: commodity for which we have CC-trade data; Commod2: matching commodity for which we have CWorld data):

                                                        Trade(C1,World,Commod2,Scen)
Trade(C1,C2,Commod1,Scen) = Trade(C1,C2,Commod1,Base) * ----------------------
                                                        Trade(C1,World,Commod2,Base)

$offtext;

AUX_Inverse_VImportQuantity_MR.l(Regions,"World",Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $VImportQuantity_MR.l(Regions,"World",Commodities,ProductionSystems,ProductionConditions,Scenarios)
         = 1/VImportQuantity_MR.l(Regions,"World",Commodities,ProductionSystems,ProductionConditions,Scenarios);
AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $VExportQuantity_MR.l(Regions,"World",Commodities,ProductionSystems,ProductionConditions,Scenarios)
         = 1/VExportQuantity_MR.l(Regions,"World",Commodities,ProductionSystems,ProductionConditions,Scenarios);

VImportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)
         = VImportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                 *sum(COmmodities_2$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,Commodities_2),
                         VImportQuantity_MR.l(Regions_MR,"World",Commodities_2,ProductionSystems,ProductionConditions,Scenarios)
                                 *AUX_Inverse_VImportQuantity_MR.l(Regions_MR,"World",Commodities_2,"AllProdSyst",ProductionConditions,"Baseline"));

VExportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)
         = VExportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                 *sum(COmmodities_2$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,Commodities_2),
                         VExportQuantity_MR.l(Regions_MR,"World",Commodities_2,ProductionSystems,ProductionConditions,Scenarios)
                                 *AUX_Inverse_VExportQuantity_MR.l(Regions_MR,"World",Commodities_2,"AllProdSyst",ProductionConditions,"Baseline"));

*transform in primary product quantities
VPrimProd_ExportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $ExtractionRate_CommodityTree_MR(Regions_MR,Commodities,Scenarios)
         = VExportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree_MR(Regions_MR,Commodities,Scenarios);
VPrimProd_ImportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $ExtractionRate_CommodityTree_MR(Regions_MR,Commodities,Scenarios)
         = VImportQuantity_MR.l(Regions_MR,Regions_MR_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree_MR(Regions_MR,Commodities,Scenarios);


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Derive commodity production and quantity in primary product equivalents



*transform in primary product quantities
VPrimProd_Commod_Production_MR.l(Regions_MR,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $ExtractionRate_CommodityTree_MR(Regions_MR,Commodities,Scenarios)
         = VCommod_Production_MR.l(Regions_MR,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree_MR(Regions_MR,Commodities,Scenarios);
VPrimProd_Commod_Quantity_MR.l(Regions_MR,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $ExtractionRate_CommodityTree_MR(Regions_MR,Commodities,Scenarios)
         = VCommod_Quantity_MR.l(Regions_MR,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree_MR(Regions_MR,Commodities,Scenarios);
