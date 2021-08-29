PUTCLOSE con,"_V6_Sets_GeneralModelSets_ForReadingData";

$ontext;
GENERAL DESCRIPTION
This file declares some further sets that are needed to read in the data..

DETAILED TABLE OF CONTENTS
the following sets are declared below:
- 1) Production types
- 2) Some auxiliary matching sets

SHORT SUMMARY:
In this code file, the following sets are defined:
Set ProductionType       "Captures the different types of production, such as organic or conventional, rain-fed or irrigated, etc. and also animal production systems - CURRENTLY only org/conv needed!"
Set MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Activities) Matches the FAOSTAT live animal items with the SOLm activities

$offtext;




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Production types

Set ProductionType       "Captures the different typs of production, such as organic or conventional, reinfed or irrigated, etc. and also animal production systems"
*this is later replaced in the model code by the set ProductionSystems
*CURRENTLY only org/conv needed for reading the data!!
*These production types come in different complete sub-sets that can also be combined: organic-rainfed, etc.
*A clear hierarchical structure is thus needed. This is established
*        - by having exhaustive sub-sets of mutually exclusive types only (the sum over all types in a sub-set equals all types; the types in a sub-set are not overlapping)
*        - by a two dimensional set as defined just after the set containing all the possible production types, but already indicated by the "Level X" assigned to the various types
/
Convent, Organic
/;



*2) Some auxiliary matching sets
*the following matching-set is needed in various files, but it is defined in _V6_ReadData_FAOSTAT_LivestockProduction which is not always run, as it takes long - hence defining it here
*as this needs the set Activities, this can be defined only AFTER having defined Activities, thus find the declaration of this set not here but in _V6_Sets_GeneralModelSets towards the end
$ontext;
Set MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Activities) Matches the FAOSTAT live animal items with the SOLm activities
/
"Animals live nes"."Animals live nes"
"Asses"."Asses"
"Beehives"."Beehives"
"Buffaloes"."Buffaloes"
"Camelids, other"."Camelids, other"
"Camels"."Camels"
"Cattle"."Cattle"
"Cattle and Buffaloes"."Cattle and Buffaloes"
"Chickens"."Chickens"
"Ducks"."Ducks"
"Geese and guinea fowls"."Geese and guinea fowls"
"Goats"."Goats"
"Horses"."Horses"
"Mules"."Mules"
"Pigeons, other birds"."Pigeons, other birds"
"Pigs"."Pigs"
"Poultry Birds"."Poultry Birds"
"Rabbits and hares"."Rabbits and hares"
"Rodents, other"."Rodents, other"
"Sheep"."Sheep"
"Sheep and Goats"."Sheep and Goats"
"Turkeys"."Turkeys"
/;
$offtext;




















