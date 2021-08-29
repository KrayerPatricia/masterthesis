PUTCLOSE con,"_V6_Sets_FAOSTAT_Population_HumanNutrReq";

$ontext;
GENERAL DESCRIPTION
This file declares the sets where the FAOSTAT population data is collected and that are needed for human nutrient requirements

DETAILED TABLE OF CONTENTS
the following sets are declared below:
- 1) FAOSTAT population elements, items and units
- 2) Human nutrient requirements

SHORT SUMMARY:
In this code file, the following sets are defined:
Set FAOSTAT_PopulationItems Population items (such as population number)  used in FAOSTAT
Set FAOSTAT_PopulationElements Population elements (such as "urban population") used in FAOSTAT
Set FAOSTAT_PopulationUnits Population units ("1000 persons") used in FAOSTAT

$offtext;

*MODEL CODE:
****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1)  FAOSTAT population elements, items and units

Set FAOSTAT_PopulationItems Population items (such as population number)  used in FAOSTAT
*from the file FAOSTAT_PopulationItemDefinition_13_12_2017.csv
/
"Population - Est. & Proj."
/;

Set FAOSTAT_PopulationElements Population elements (such as "urban population") used in FAOSTAT
*from the file FAOSTAT_PopulationElementDefinition_13_12_2017.csv
/
"Total Population - Both sexes"
*        "1000 persons",""
"Total Population - Female"
*        "1000 persons","De facto population in a country, area or region as of 1 July of the year indicated. Source: United Nations, World Population Prospects – the 2015 Revision"
"Total Population - Male"
*        "1000 persons","De facto population in a country, area or region as of 1 July of the year indicated. Source: United Nations, World Population Prospects – the 2015 Revision"
"Rural population"
*        "1000 persons","De facto population living in areas classified as urban/rural according to the criteria used by each area or country.
*        Data refer to 1 July of the year indicated. Source: United Nations, World Urbanization Prospects – the 2014 Revision"
"Urban population"
*        "1000 persons","De facto population living in areas classified as urban/rural according to the criteria used by each area or country. Data refer to 1 July of the year indicated.
*        Source: United Nations, World Urbanization Prospects – the 2014 Revision"
/;

Set FAOSTAT_PopulationUnits Population units ("1000 persons") used in FAOSTAT
*from the file FAOSTAT_PopulationElementDefinition_13_12_2017.csv
/
"1000 persons"
/;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Human nutrient requirements

Set HumanNutrientRequirementsElements
/
"kcal/cap/day"
"kcal/cap/day (ADER)"
*        average daily energy requirements
"kcal/cap/day (MDER)"
*        minimal daily energy requirements
"g protein/cap/day"
"g fat/cap/day"
/;
