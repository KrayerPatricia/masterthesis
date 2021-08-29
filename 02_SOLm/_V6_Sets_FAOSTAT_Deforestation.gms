PUTCLOSE con,"_V6_Sets_FAOSTAT_Deforestation";

$ontext;
GENERAL DESCRIPTION
This file declares the sets where the FAOSTAT Deforestation items are collected

DETAILED TABLE OF CONTENTS
the following sets are declared below:

- 1) FAO deforestation items, elements and units
         1.1)  FAO Deforestation Items
         1.2)  FAO Deforestation Elements
         1.3)  FAO Deforestation Units

SHORT SUMMARY:
In this code file, the following sets are defined:
Set FAOSTAT_DeforestationItems All deforestation item names ("Forest" and "Net Forest Conversion") that may be used in FAOSTAT
Set FAOSTAT_DeforestationElements All deforestation elements (such as "Area") that are used in FAOSTAT
Set FAOSTAT_DeforestationUnits All deforestation units (such as "ha" or "gigagrams") that may be used in FAOSTAT

$offtext;

*1) FAO Deforestation items, elements and units
*1.1)  FAO Deforestation Items
Set FAOSTAT_DeforestationItems All deforestation item names ("Forest" and "Net Forest Conversion") that may be used in FAOSTAT
*from the file FAOSTAT_Deforestation_2_28_2018.csv
/
Forest
"Net Forest conversion"
/;


*1.2)  FAO Deforestation Elements
Set FAOSTAT_DeforestationElements All deforestation elements (such as "Area") that are used in FAOSTAT
*from the file FAOSTAT_Deforestation_2_28_2018.csv
/
Area
"Implied emission factor for CO2"
"Net emissions/removals (CO2) (Forest land)"
"Net emissions/removals (CO2eq) (Forest land)"
/;


*1.3) FAO Land Use Units
Set FAOSTAT_DeforestationUnits All deforestation units (such as "ha" or "gigagrams") that may be used in FAOSTAT
*from the file FAOSTAT_Deforestation_2_28_2018.csv
/
ha
"1000 ha"
gigagrams
"tonnes CO2/ha"
/;
