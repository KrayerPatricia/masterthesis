PUTCLOSE con,"_V6_ReadData_VariousSources_AnimalProductionUnits";

$ontext;
GENERAL DESCRIPTION
This file assigns the sets used to work with animal production units and files in animal production unit data

DETAILED TABLE OF CONTENTS
- 1) Animal production unit sets from various sources
         - 1.1) General SOLm Animal production unit sets
         - 1.2) SOLm Animal production unit sets from FAOSTAT
         - 1.3) SOLm Animal production unit sets from IPCC

- 2) Animal production unit data

$offtext;

*ATTENTION: these animal production unit sets and data have not yet been present in most of the old code, and we add now what is needed in V6


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Animal production unit sets from various sources

*1.1) General SOLm Animal production unit sets


*ATTENTION: the following set has already been defined in the GeneralModelSets module - as part of ProductionType and subset thereof
*Set AnimalProductionUnits


*1.2) SOLm Animal production unit sets from FAOSTAT

*still to be added


*1.3) SOLm Animal production unit sets from IPCC
*the following lists specific sets from IPCC separately

*ATTENTION: the following set has already been defined in the GeneralModelSets module - as part of ProductionType and subset thereof
*Set AnimalProductionUnit_IPCC2006



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Animal production system data




*FINALLY translate into

*AnimalProductionUnitStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);


*ATTENTION: not yet any data to be filed in.



*        XXX STILL TO BE DONE:
*link to SOLmV5 as soon as there is data in this file

