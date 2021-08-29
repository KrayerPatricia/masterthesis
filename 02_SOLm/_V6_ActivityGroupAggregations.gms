PUTCLOSE con,"__SOLmV5_CoreModelEquations_GeographicAggregations";
$setglobal ModuleLabel "__SOLmV5_CoreModelEquations_GeographicAggregations"

*GENERAL DESCRIPTION
*This file contains all the core model equations for calculating geographic aggregations - e.g. from sub-regions to countries, etc. .
*do it for the most important parameters first.

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Aggregation of AP subregions to CH and AT
         1.1) per ha values and total areas
         1.2) per ton DAQ values and total DAQ
         1.3) per ton PrimProd values and total PrimProd
         1.4) per animal head values and total animal numbers
         1.5) per producing animal and total producing animal numbers
         1.6) per ton manure and total manure quantity
         1.7) per ton min fert and total min fert quantity
         1.8) per ton crop residue and total crop residue quantity
         1.9) per human head and total population numbers
         1.10) per LU and total LU numbers
- 2) Additional parameters needed on CH and AT level that are maybe not yet present

$offtext;

$ontext;
*preamble, do the following assingment - to be moved elsewhere to more general code than this AP-Region aggregation:
*NOT NEEDED HERE ANYMORE - moved to fert applic module - thus delete here!
ManureQuantitySOLmV5_ModelRun.l(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,"AllManManSystems",ScenarioNamesSOLmV5)
         = NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
                         *ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"TS DM in manure (tTS/head/y)",ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);
*needs to be done separately for animals without herd structure, as there, the AnimalCategory is "AllCategories" for the parameter, "AllCategories" for the number:
ManureQuantitySOLmV5_ModelRun.l(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories",ProductionTypeSOLmV5,ProductionConditionsSOLmV5,"AllManManSystems",ScenarioNamesSOLmV5)
         = NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories",ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
                         *ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories","TS DM in manure (tTS/head/y)",ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

ManureQuantitySOLmV5_ModelRun.l(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
                 $(NOT ManureQuantitySOLmV5_ModelRun.l(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5))
         = ManureQuantitySOLmV5_ModelRun.l(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,"AllManManSystems",ScenarioNamesSOLmV5)
                 *ParameterPerTonManureSOLmV5_ModelRun(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"Quantity share in ManMan system",ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,"AllTemperatures",ScenarioNamesSOLmV5);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Aggregation of AP subregions to CH and AT
*1.1) per ha values and total areas

*aggregation for Switzerland:
AreaHarvestedSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = AreaHarvestedSOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + AreaHarvestedSOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + AreaHarvestedSOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


ParameterPerHaSOLmV5_ModelRun("Switzerland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerHaParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $AreaHarvestedSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,
                 ParameterPerHaSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerHaParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         *AreaHarvestedSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
                 /AreaHarvestedSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerHaSOLmV5_ModelRun("Switzerland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerHaParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerHaSOLmV5_ModelRun("Switzerland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerHaParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerHaSOLmV5_ModelRun("Switzerland_Tal",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerHaParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

*aggregation for Austria:
AreaHarvestedSOLmV5_ModelRun.l("Austria",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = AreaHarvestedSOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + AreaHarvestedSOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + AreaHarvestedSOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + AreaHarvestedSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + AreaHarvestedSOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + AreaHarvestedSOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + AreaHarvestedSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + AreaHarvestedSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


ParameterPerHaSOLmV5_ModelRun("Austria",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerHaParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $AreaHarvestedSOLmV5_ModelRun.l("Austria",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,
                 ParameterPerHaSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerHaParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         *AreaHarvestedSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
                 /AreaHarvestedSOLmV5_ModelRun.l("Austria",ActivitySOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerHaSOLmV5_ModelRun("Austria",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerHaParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerHaSOLmV5_ModelRun("Austria",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerHaParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerHaSOLmV5_ModelRun("Austria_Alpenvorland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerHaParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


*1.2) per ton DAQ values and total DAQ
*aggregation for Switzerland:
DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Tal",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Huegel",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Berg",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);



ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,PerTonDomestAvailQuantParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,
                 ParameterPerTonDomestAvailQuantSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,CommoditySOLmV5_ModelRun,PerTonDomestAvailQuantParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         *DomestAvailableQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
                 /DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

*        specifically sum cropland and grassland use to total land use
ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Total land use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Cropland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 +ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Grassland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,PerTonDomestAvailQuantParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,PerTonDomestAvailQuantParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland_Tal",CommoditySOLmV5_ModelRun,PerTonDomestAvailQuantParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

*aggregation for Austria:
DomestAvailableQuantitySOLmV5_ModelRun.l("Austria",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = DomestAvailableQuantitySOLmV5_ModelRun.l("Austria_Hochalpen",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + DomestAvailableQuantitySOLmV5_ModelRun.l("Austria_Voralpen",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + DomestAvailableQuantitySOLmV5_ModelRun.l("Austria_Alpenostrand",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + DomestAvailableQuantitySOLmV5_ModelRun.l("Austria_WaldMuehlViertel",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + DomestAvailableQuantitySOLmV5_ModelRun.l("Austria_KaerntnerBecken",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + DomestAvailableQuantitySOLmV5_ModelRun.l("Austria_Alpenvorland",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + DomestAvailableQuantitySOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + DomestAvailableQuantitySOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Austria",CommoditySOLmV5_ModelRun,PerTonDomestAvailQuantParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $DomestAvailableQuantitySOLmV5_ModelRun.l("Austria",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,
                 ParameterPerTonDomestAvailQuantSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,CommoditySOLmV5_ModelRun,PerTonDomestAvailQuantParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         *DomestAvailableQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
                 /DomestAvailableQuantitySOLmV5_ModelRun.l("Austria",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


*        specifically sum cropland and grassland use to total land use
ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Austria",CommoditySOLmV5_ModelRun,"Total land use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Austria",CommoditySOLmV5_ModelRun,"Cropland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 +ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Austria",CommoditySOLmV5_ModelRun,"Grassland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Austria",CommoditySOLmV5_ModelRun,PerTonDomestAvailQuantParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Austria",CommoditySOLmV5_ModelRun,PerTonDomestAvailQuantParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Austria_Alpenvorland",CommoditySOLmV5_ModelRun,PerTonDomestAvailQuantParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


*1.3) per ton PrimProd values and total PrimProd
*aggregation for Switzerland:
PrimaryProductionQuantitySOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = PrimaryProductionQuantitySOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantitySOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantitySOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

ParameterPerTonPrimaryProdSOLmV5_ModelRun("Switzerland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $PrimaryProductionQuantitySOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,
                 ParameterPerTonPrimaryProdSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         *PrimaryProductionQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
                 /PrimaryProductionQuantitySOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerTonPrimaryProdSOLmV5_ModelRun("Switzerland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonPrimaryProdSOLmV5_ModelRun("Switzerland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerTonPrimaryProdSOLmV5_ModelRun("Switzerland_Tal",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

*aggregation for Austria:
PrimaryProductionQuantitySOLmV5_ModelRun.l("Austria",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = PrimaryProductionQuantitySOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantitySOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantitySOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantitySOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantitySOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantitySOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantitySOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantitySOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

ParameterPerTonPrimaryProdSOLmV5_ModelRun("Austria",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $PrimaryProductionQuantitySOLmV5_ModelRun.l("Austria",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,
                 ParameterPerTonPrimaryProdSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         *PrimaryProductionQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
                 /PrimaryProductionQuantitySOLmV5_ModelRun.l("Austria",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerTonPrimaryProdSOLmV5_ModelRun("Austria",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonPrimaryProdSOLmV5_ModelRun("Austria",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerTonPrimaryProdSOLmV5_ModelRun("Austria_Alpenvorland",ActivitySOLmV5_ModelRun,OutputTypeSOLmV5_ModelRun,PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


*1.4) per animal head values and total animal numbers

*aggregation for Switzerland:
NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun("Switzerland",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,
                 ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         *NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
                 /NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun("Switzerland",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun("Switzerland",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun("Switzerland_Tal",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


*aggregation for Austria:
NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         + NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun("Austria",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,
                 ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         *NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
                 /NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun("Austria",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun("Austria",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun("Austria_Alpenvorland",ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


*1.5) per producing animal and total producing animal numbers
*aggregation for Switzerland:
NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

*aggregation for Austria:
NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

*no per producing head parameter - thus no need to derive this

$ontext;
The sum with the sum-operator as below takes ages, while the sum as a list as above is fast - no idea why....
NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH$NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5),
                 NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5));
NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria",ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT$NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5),
                 NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5));
$offtext;


*1.6) per ton manure and total manure quantity
*aggregation for Switzerland:
ManureQuantitySOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         = ManureQuantitySOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantitySOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantitySOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5);


*derive also per ton manure values for CH/AT as those are needed later on as well:
ParameterPerTonManureSOLmV5_ModelRun("Switzerland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,PerTonManureParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                 $ManureQuantitySOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,
                 ParameterPerTonManureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,PerTonManureParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                         *ManureQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5))
                 /ManureQuantitySOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5);

*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerTonManureSOLmV5_ModelRun("Switzerland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,PerTonManureParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonManureSOLmV5_ModelRun("Switzerland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,PerTonManureParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5))
         = ParameterPerTonManureSOLmV5_ModelRun("Switzerland_Tal",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,PerTonManureParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5);


*aggregation for Austria:
ManureQuantitySOLmV5_ModelRun.l("Austria",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         = ManureQuantitySOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantitySOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantitySOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantitySOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantitySOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantitySOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantitySOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantitySOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5);

*derive also per ton manure values for CH/AT as those are needed later on as well:
ParameterPerTonManureSOLmV5_ModelRun("Austria",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,PerTonManureParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                 $ManureQuantitySOLmV5_ModelRun.l("Austria",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,
                 ParameterPerTonManureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,PerTonManureParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                         *ManureQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5))
                 /ManureQuantitySOLmV5_ModelRun.l("Austria",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,ScenarioNamesSOLmV5);

*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerTonManureSOLmV5_ModelRun("Austria",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,PerTonManureParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonManureSOLmV5_ModelRun("Austria",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,PerTonManureParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5))
         = ParameterPerTonManureSOLmV5_ModelRun("Austria_Alpenvorland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,PerTonManureParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5);



*1.7) per ton min fert and total min fert quantity
*aggregation for Switzerland:
MineralFertilizerQuantitySOLmV5_ModelRun.l("Switzerland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         = MineralFertilizerQuantitySOLmV5_ModelRun.l("Switzerland_Tal",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantitySOLmV5_ModelRun.l("Switzerland_Huegel",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantitySOLmV5_ModelRun.l("Switzerland_Berg",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5);

*param per ton min fert does not have a prod system dimension, thus assign the average prod syste to min fert quant to be able to do the subsequent calculations
MineralFertilizerQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,"AverageProdType",ScenarioNamesSOLmV5)
         = sum(ProductionType_OrgCon_SOLmV5_ModelRun,
                 MineralFertilizerQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionType_OrgCon_SOLmV5_ModelRun,ScenarioNamesSOLmV5));
MineralFertilizerQuantitySOLmV5_ModelRun.l("Switzerland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,"AverageProdType",ScenarioNamesSOLmV5)
         = sum(ProductionType_OrgCon_SOLmV5_ModelRun,
                 MineralFertilizerQuantitySOLmV5_ModelRun.l("Switzerland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionType_OrgCon_SOLmV5_ModelRun,ScenarioNamesSOLmV5));

ParameterPerTonMineralFertSOLmV5_ModelRun("Switzerland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,PerTonMinFertParameterSOLmV5,ScenarioNamesSOLmV5)
                 $MineralFertilizerQuantitySOLmV5_ModelRun.l("Switzerland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,"AverageProdType",ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,
                 ParameterPerTonMineralFertSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,PerTonMinFertParameterSOLmV5,ScenarioNamesSOLmV5)
                         *MineralFertilizerQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,"AverageProdType",ScenarioNamesSOLmV5))
                 /MineralFertilizerQuantitySOLmV5_ModelRun.l("Switzerland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,"AverageProdType",ScenarioNamesSOLmV5);

*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerTonMineralFertSOLmV5_ModelRun("Switzerland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,PerTonMinFertParameterSOLmV5,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonMineralFertSOLmV5_ModelRun("Switzerland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,PerTonMinFertParameterSOLmV5,ScenarioNamesSOLmV5))
         = ParameterPerTonMineralFertSOLmV5_ModelRun("Switzerland_Tal",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,PerTonMinFertParameterSOLmV5,ScenarioNamesSOLmV5);


*aggregation for Austria:
MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         = MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria_Hochalpen",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria_Voralpen",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria_Alpenostrand",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria_WaldMuehlViertel",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria_KaerntnerBecken",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria_Alpenvorland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5);

*param per ton min fert does not have a prod system dimension, thus assign the average prod syste to min fert quant to be able to do the subsequent calculations
MineralFertilizerQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,"AverageProdType",ScenarioNamesSOLmV5)
         = sum(ProductionType_OrgCon_SOLmV5_ModelRun,
                 MineralFertilizerQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionType_OrgCon_SOLmV5_ModelRun,ScenarioNamesSOLmV5));
MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,"AverageProdType",ScenarioNamesSOLmV5)
         = sum(ProductionType_OrgCon_SOLmV5_ModelRun,
                 MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,ProductionType_OrgCon_SOLmV5_ModelRun,ScenarioNamesSOLmV5));

ParameterPerTonMineralFertSOLmV5_ModelRun("Austria",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,PerTonMinFertParameterSOLmV5,ScenarioNamesSOLmV5)
                 $MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,"AverageProdType",ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,
                 ParameterPerTonMineralFertSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,PerTonMinFertParameterSOLmV5,ScenarioNamesSOLmV5)
                         *MineralFertilizerQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,"AverageProdType",ScenarioNamesSOLmV5))
                 /MineralFertilizerQuantitySOLmV5_ModelRun.l("Austria",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,"AverageProdType",ScenarioNamesSOLmV5);

*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerTonMineralFertSOLmV5_ModelRun("Austria",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,PerTonMinFertParameterSOLmV5,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonMineralFertSOLmV5_ModelRun("Austria",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,PerTonMinFertParameterSOLmV5,ScenarioNamesSOLmV5))
         = ParameterPerTonMineralFertSOLmV5_ModelRun("Austria_Alpenvorland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,PerTonMinFertParameterSOLmV5,ScenarioNamesSOLmV5);


*1.8) per ton crop residue and total crop residue quantity
*aggregation for Switzerland:
CropResidueQuantitySOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         = CropResidueQuantitySOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantitySOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantitySOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5);


ParameterPerTonCropResidueSOLmV5_ModelRun("Switzerland",ActivitySOLmV5,CropResidueTypeSOLmV5,PerTonCropResParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                 $CropResidueQuantitySOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,
                 ParameterPerTonCropResidueSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5,CropResidueTypeSOLmV5,PerTonCropResParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                         *CropResidueQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5))
                 /CropResidueQuantitySOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5);

*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerTonCropResidueSOLmV5_ModelRun("Switzerland",ActivitySOLmV5,CropResidueTypeSOLmV5,PerTonCropResParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonCropResidueSOLmV5_ModelRun("Switzerland",ActivitySOLmV5,CropResidueTypeSOLmV5,PerTonCropResParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5))
         = ParameterPerTonCropResidueSOLmV5_ModelRun("Switzerland_Tal",ActivitySOLmV5,CropResidueTypeSOLmV5,PerTonCropResParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5);

*aggregation for Austria:
CropResidueQuantitySOLmV5_ModelRun.l("Austria",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         = CropResidueQuantitySOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantitySOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantitySOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantitySOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantitySOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantitySOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantitySOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantitySOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5);


ParameterPerTonCropResidueSOLmV5_ModelRun("Austria",ActivitySOLmV5,CropResidueTypeSOLmV5,PerTonCropResParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                 $CropResidueQuantitySOLmV5_ModelRun.l("Austria",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,
                 ParameterPerTonCropResidueSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5,CropResidueTypeSOLmV5,PerTonCropResParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                         *CropResidueQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5))
                 /CropResidueQuantitySOLmV5_ModelRun.l("Austria",ActivitySOLmV5,CropResidueTypeSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,ScenarioNamesSOLmV5);

*if it is not around on country level, because no variable values for weighting are available, then just assign the values from the largest region to it:
ParameterPerTonCropResidueSOLmV5_ModelRun("Austria",ActivitySOLmV5,CropResidueTypeSOLmV5,PerTonCropResParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonCropResidueSOLmV5_ModelRun("Austria",ActivitySOLmV5,CropResidueTypeSOLmV5,PerTonCropResParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5))
         = ParameterPerTonCropResidueSOLmV5_ModelRun("Austria_Alpenvorland",ActivitySOLmV5,CropResidueTypeSOLmV5,PerTonCropResParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5);


*1.9) per human head and total population numbers
*aggregation for Switzerland:
PopulationNumbersSOLmV5_ModelRun.l("Switzerland",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5)
         = PopulationNumbersSOLmV5_ModelRun.l("Switzerland_Tal",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumbersSOLmV5_ModelRun.l("Switzerland_Huegel",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumbersSOLmV5_ModelRun.l("Switzerland_Berg",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5);

*aggregation for Switzerland:
PopulationNumbersSOLmV5_ModelRun.l("Austria",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5)
         = PopulationNumbersSOLmV5_ModelRun.l("Austria_Hochalpen",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumbersSOLmV5_ModelRun.l("Austria_Voralpen",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumbersSOLmV5_ModelRun.l("Austria_Alpenostrand",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumbersSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumbersSOLmV5_ModelRun.l("Austria_KaerntnerBecken",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumbersSOLmV5_ModelRun.l("Austria_Alpenvorland",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumbersSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumbersSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",PopulationGroupsSOLmV5,ScenarioNamesSOLmV5);


*1.10) per LU and total LU numbers
LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

$ontext;
The sum with the sum-operator as below takes ages, while the sum as a list as above is fast - no idea why....
LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,
                 LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5));
LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l("Austria",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,
                 LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_AT,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5));
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Additional parameters needed on CH and AT level that are maybe not yet present
*for some later calculations, we now need to assure that the two following parameters are assigned on CH/AT-country level:
*thus we calculate them in general, conditional on them not yet being present - thus, in case they are missing for CH and AT, they are assigned here
AUXRECParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         AND (NOT AUXRECParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)))
         = 1/ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


AUXRECNumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         AND (NOT AUXRECNumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)))
         = 1/NumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);


AnimalProductionUnitSharesSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT AnimalProductionUnitSharesSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = NumberLivingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 *AUXRECNumberProducingAnimals_HerdStructureSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,OutputTypeSOLmV5,"Producing",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);




$exit;

the following are calculated later in the totals module - as the quantities and parameters are around on CH/AT level now, the derived quantities will be as well.




*1.5) Aggregation of various further variables
*these are the following:
$ontext;
AreaBasedTotalValuesSOLmV5_ModelRun(GeographicRegionSOLmV5,ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun(GeographicRegionSOLmV5,ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
ManureQuantityBasedTotalValuesSOLmV5_ModelRun(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun(GeographicRegionSOLmV5,MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun(GeographicRegionSOLmV5,ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
SeedQuantityBasedTotalValuesSOLmV5_ModelRun(GeographicRegionSOLmV5,ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun(GeographicRegionSOLmV5,CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
PopulationNumberBasedTotalValuesSOLmV5_ModelRun(GeographicRegionSOLmV5,PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
$offtext;



AreaBasedTotalValuesSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = AreaBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + AreaBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + AreaBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

AreaBasedTotalValuesSOLmV5_ModelRun.l("Austria",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = AreaBasedTotalValuesSOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + AreaBasedTotalValuesSOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + AreaBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + AreaBasedTotalValuesSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + AreaBasedTotalValuesSOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + AreaBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + AreaBasedTotalValuesSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + AreaBasedTotalValuesSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5,OutputTypeSOLmV5,AreaBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);



PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5,OutputTypeSOLmV5,PrimProdBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);



ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         = ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5);

ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         = ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + ManureQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ManureQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ManureManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5);



$ontext;
*the following is not yet available - calculated later and directly based on CH quantities and CH per quant parameters
MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         = MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Tal",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Huegel",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Berg",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5);

MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         = MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Hochalpen",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Voralpen",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenostrand",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_KaerntnerBecken",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenvorland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5)
         + MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",MineralFertilizerTypeSOLmV5,MineralFertilizerProdSystemSOLmV5,MinFertBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ScenarioNamesSOLmV5);
$offtext;



CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         = CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5);

CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         = CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5)
         + CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5,CropResidueTypeSOLmV5,CropResQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,CropResManSystemSOLmV5,TemperaturesSOLmV5,ScenarioNamesSOLmV5);



SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + SeedQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5,OutputTypeSOLmV5,SeedQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);



LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);



ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Switzerland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Tal",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Huegel",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Berg",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_Hochalpen",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_Voralpen",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenostrand",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_KaerntnerBecken",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenvorland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProducingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);



DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Tal",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Huegel",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Berg",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         = DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Hochalpen",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Voralpen",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenostrand",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_KaerntnerBecken",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenvorland",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5)
         + DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",CommoditySOLmV5,DomestAvailQuantBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);



PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Switzerland",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
         = PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Tal",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Huegel",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Switzerland_Berg",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5);

PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Austria",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
         = PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Austria_Hochalpen",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Austria_Voralpen",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenostrand",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Austria_WaldMuehlViertel",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Austria_KaerntnerBecken",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Austria_Alpenvorland",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Austria_SuedoestlFlachHuegelland",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5)
         + PopulationNumberBasedTotalValuesSOLmV5_ModelRun.l("Austria_NordoestlFlachHuegelland",PopulationGroupsSOLmV5,PopulationNumberBasedTotalValueParameterSOLmV5,ScenarioNamesSOLmV5);









$ontext;
old code only for land use:
ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Cropland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Tal",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         + DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Huegel",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         + DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Berg",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,
                 ParameterPerTonDomestAvailQuantSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,CommoditySOLmV5_ModelRun,"Cropland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         *DomestAvailableQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
                 /(DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Tal",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         + DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Huegel",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         + DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Berg",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5));

ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Grassland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Tal",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         + DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Huegel",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         + DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Berg",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = sum(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,
                 ParameterPerTonDomestAvailQuantSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,CommoditySOLmV5_ModelRun,"Grassland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         *DomestAvailableQuantitySOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt_CH,CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
                 /(DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Tal",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         + DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Huegel",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                         + DomestAvailableQuantitySOLmV5_ModelRun.l("Switzerland_Berg",CommoditySOLmV5_ModelRun,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5));

*if missing, just take the Tal values:
ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Cropland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Cropland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland_Tal",CommoditySOLmV5_ModelRun,"Cropland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);
ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Grassland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Grassland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland_Tal",CommoditySOLmV5_ModelRun,"Grassland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);
*if STILL missing, just take the Berg values:
ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Cropland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Cropland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland_Berg",CommoditySOLmV5_ModelRun,"Cropland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);
ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Grassland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5)
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland",CommoditySOLmV5_ModelRun,"Grassland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5))
         = ParameterPerTonDomestAvailQuantSOLmV5_ModelRun("Switzerland_Berg",CommoditySOLmV5_ModelRun,"Grassland use (ha/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,ScenarioNamesSOLmV5);

$offtext;


