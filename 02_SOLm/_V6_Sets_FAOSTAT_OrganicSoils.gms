PUTCLOSE con,"_V6_Sets_FAOSTAT_OrganicSoils";

$ontext;
GENERAL DESCRIPTION
This file declares the sets where the FAOSTAT Organic Soils items are collected

DETAILED TABLE OF CONTENTS
the following sets are declared below:

- 1) FAO Organic Soils items, elements and units
         1.1)  FAO Organic Soils Items
         1.2)  FAO Organic Soils Elements
         1.3)  FAO Organic Soils Units

SHORT SUMMARY:
In this code file, the following sets are defined:
Set FAOSTAT_OrganicSoilsItems All organic soils item names (such as "cropland organic soils") that may be used in FAOSTAT
Set FAOSTAT_OrganicSoilsElements All organic soils elements (such as "Area") that are used in FAOSTAT
Set FAOSTAT_OrganicSoilsUnits All organic soils units (such as "ha" or "gigagrams") that may be used in FAOSTAT

$offtext;

*1) FAO Organic Soils items, elements and units
*1.1)  FAO Organic Soils Items
Set FAOSTAT_OrganicSoilsItems All organic soils item names (such as "cropland organic soils") that may be used in FAOSTAT
*from the files FAOSTAT_OrganicSoils_2_28_2018.csv (OLD - the next ones are the currently valid ones)
*FAOSTAT_OrganicSoilsN2OItemDefinition_25_12_2018
*FAOSTAT_OrganicSoilsGrasslandItemDefinition_25_12_2018
*FAOSTAT_OrganicSoilsCroplandItemDefinition_25_12_2018
/
"Cropland organic soils"
"Grassland organic soils"
"Cropland and grassland organic soils"
/;


*1.2)  FAO Organic Soils Elements
Set FAOSTAT_OrganicSoilsElements All organic soils elements (such as "Area") that are used in FAOSTAT
*from the file FAOSTAT_OrganicSoils_2_28_2018.csv  (OLD - the next ones are the currently valid ones)
*FAOSTAT_OrganicSoilsN2OElementDefinition_25_12_2018
*FAOSTAT_OrganicSoilsGrasslandElementDefinition_25_12_2018
*FAOSTAT_OrganicSoilsCroplandElementDefinition_25_12_2018
/
Area
"Emissions (CO2eq) (Cultivation of organic soils)"
"Emissions (N2O) (Cultivation of organic soils)"
"Implied emission factor for N2O (Cultivation of organic soils)"
"Implied emission factor for C (Grassland)"
"Net emissions/removal (CO2eq) (Grassland)"
"Net emissions/removals (CO2) (Grassland)"
"Net stock change (C) (Grassland)"
"Implied emission factor for C (Cropland)"
"Net emissions/removal (CO2eq) (Cropland)"
"Net emissions/removals (CO2) (Cropland)"
"Net stock change (C) (Cropland)"
/;


*1.3)  FAO Organic Soils Units
Set FAOSTAT_OrganicSoilsUnits All organic soils units (such as "ha" or "gigagrams") that may be used in FAOSTAT
*from the file FAOSTAT_OrganicSoils_2_28_2018.csv
/
"kg N2O-N/ha"
ha
gigagrams
"tonnes C/ha"
/;
