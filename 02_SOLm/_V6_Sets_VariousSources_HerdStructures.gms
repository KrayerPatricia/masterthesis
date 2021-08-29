PUTCLOSE con,"_V6_Sets_VariousSources_HerdStructures";

$ontext;
GENERAL DESCRIPTION
This file assigns the sets used to work with herd structures

DETAILED TABLE OF CONTENTS
- 1) Herd structure sets from various sources
         - 1.1) General SOLm herd structures sets
         - 1.2) SOLm herd structures sets from FAOSTAT
         - 1.3) SOLm herd structures sets from IPCC

SHORT SUMMARY:
In this code file, the following sets are defined:
SET AnimalCategoriesInHerd_VariousSources All animal categories according to age and reproductive and production status that may be used in the model - covers also some management aspects - not mutually exclusive
SET AnimalCategoriesInHerd_SOLmOLD(AnimalCategoriesInHerd_VariousSources) All animal categories as used in older versions of SOLm
SET CattleHerdCategories_SOLmOLD(AnimalCategoriesInHerd_VariousSources) Subset with cattle herd categories as used in older versions of SOLm
SET DairyCattleHerdCategories_SOLmOLD(AnimalCategoriesInHerd_VariousSources) Subset with DAIRY cattle herd categories as used in older versions of SOLm
SET BeefCattleHerdCategories_SOLmOLD(AnimalCategoriesInHerd_VariousSources) Subset with BEEF cattle herd categories as used in older versions of SOLm
SET PigHerdCategories_SOLmOLD(AnimalCategoriesInHerd_VariousSources) Subset with PIG herd categories as used in older versions of SOLm
SET AnimalCategoriesInHerd_FAOSTAT(AnimalCategoriesInHerd_VariousSources) Subset with animal categories as used in FAOSTAT
SET AnimalCategoriesInHerd_IPCC2006(AnimalCategoriesInHerd_VariousSources) Subset with animal categories as used in IPCC2006
SET AnimalCategoriesInHerd_IPCC2006_Ruminants(AnimalCategoriesInHerd_VariousSources) Subset with RUMINANT categories as used in IPCC2006
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Herd structure sets from various sources

*1.1) General SOLm herd structures sets
*General set for herd structure animals and herd structures as used in the old SOLm versions up to SOLmV4 and in FAOSTAT and IPCC - those are collected separately in the subsections to follow.
*Subsets from older versions up to SOLmV4 are collected here as well.

SET AnimalCategoriesInHerd_VariousSources All animal categories according to age and reproductive and production status that may be used in the model - covers also some management aspects - not mutually exclusive
/
*Level 0 ("All" is used when summing, e.g. over all categories; "Average" is used when taking averages, e.g. over all categories).

AllAndAverageTypes

AllCategories
AverageCategory

Producing
Living

"LivingCattle FAOSTAT"
"SlaughtheredCattle FAOSTAT"
"ProducingDairyCattle FAOSTAT"

"LivingPigs FAOSTAT"
"SlaughtheredPigs FAOSTAT"

"LivingChicken FAOSTAT"
"SlaugtheredChicken FAOSTAT"
"ProducingEggChicken FAOSTAT"

*Level 1 - IPCC 2006 herd structure, as used in Vol4, chapter 10, tables in the appendix
"Dairy Cow IPCC2006"
"Mature females IPCC2006"
"Mature males IPCC2006"
"Mature females - Grazing IPCC2006"
"Mature males - Grazing IPCC2006"
"Mature females - Farming IPCC2006"
"Mature males - Farming IPCC2006"
"Draft bullocks IPCC2006"
"Bulls - Grazing IPCC2006"
"Calves on milk IPCC2006"
"Calves on forage IPCC2006"
"Growing heifers/steers IPCC2006"
"Replacement/growing IPCC2006"
"Feedlot cattle IPCC2006"
"Young IPCC2006"

*the following captures all "non-dairy cow"-cattle, used in IPCC 2006, vol 4, ch 10, table 10.19
"Average Other Cattle IPCC2006"
"Average Buffaloes IPCC2006"
"Average Market Swine IPCC2006"
"Average Breeding Swine IPCC2006"
"Average Sheep IPCC2006"
"Average Goat IPCC2006"
"Average Camel IPCC2006"
"Average Horse IPCC2006"
"Average Mule IPCC2006"
"Average Ass IPCC2006"

*the following captures the average pig used in IPCC 2006, vol 4, ch 10, table 10.19
"Average Pig IPCC2006"

"Chickens Layer (dry) IPCC2006"
"Chickens Layer (wet) IPCC2006"
"Average Chicken Layers  IPCC2006"
"Chickens Broilers IPCC2006"
"Average Turkey IPCC2006"
"Average Duck IPCC2006"

*the following captures the different chickens used in IPCC 2006, vol 4, ch 10, table 10.19
"Average Chicken IPCC2006"
"Hens >= 1y old IPCC2006"
"Other Chicken >= 1y old IPCC2006"
"Pullet - Chicken < 1y old IPCC2006"
*the following caputres additional animals used in IPCC 2006, vol 4, ch 10, Table 10.19
"Mink and Polecat IPCC2006"
"Rabbits IPCC2006"
"Fox and Racoon IPCC2006"

*used for digestibility of feed - check the original values for this and whether these categories are really needed
"Poultry confined IPCC2006"
"Poultry free-range IPCC2006"
"Pigs confined IPCC2006"
"Pigs free-range IPCC2006"

*Level 1 - Cattle: General structure used as default
Producing_Dairy_Cattle
Dsires

DFemaleCalves1
DFemaleCalves2
DFemaleCalves3

DMaleCalves1
DMaleCalves2

Bcows
Bsires

BFemaleCalves1
BFemaleCalves2

BMaleCalves1
BMaleCalves2

*Level 1 - Pigs: General structure used as default
Sows
Sucklers
Weaners
Fatteners
Boars
Rep_Sows
Rep_Boars

*other structures can now be added - e.g. from Ollie, then correspondingly adding new level labels in the level set below
/;


*ATTENTION: check what is REALLY NEEDED from below!!


*in the following, some specific subsets from older SOLm-versions are listed; these are also needed to file in the herd structure data used in older versions of SOLm further down
SET AnimalCategoriesInHerd_SOLmOLD(AnimalCategoriesInHerd_VariousSources) All animal categories as used in older versions of SOLm
/
AllCategories
AverageCategory

Producing_Dairy_Cattle
Dsires

DFemaleCalves1
DFemaleCalves2
DFemaleCalves3

DMaleCalves1
DMaleCalves2

Bcows
Bsires

BFemaleCalves1
BFemaleCalves2

BMaleCalves1
BMaleCalves2

*Level 1 - Pigs: General structure used as default
Sows
Sucklers
Weaners
Fatteners
Boars
Rep_Sows
Rep_Boars
/;




SET CattleHerdCategories_SOLmOLD(AnimalCategoriesInHerd_VariousSources) Subset with cattle herd categories as used in older versions of SOLm
*these are the onesa also used in earlier SOLm versions
/
Producing_Dairy_Cattle
Dsires

DFemaleCalves1
DFemaleCalves2
DFemaleCalves3

DMaleCalves1
DMaleCalves2

Bcows
Bsires

BFemaleCalves1
BFemaleCalves2

BMaleCalves1
BMaleCalves2
/;
SET DairyCattleHerdCategories_SOLmOLD(AnimalCategoriesInHerd_VariousSources) Subset with DAIRY cattle herd categories as used in older versions of SOLm
/
Producing_Dairy_Cattle
Dsires

DFemaleCalves1
DFemaleCalves2
DFemaleCalves3

DMaleCalves1
DMaleCalves2
/;
SET BeefCattleHerdCategories_SOLmOLD(AnimalCategoriesInHerd_VariousSources) Subset with BEEF cattle herd categories as used in older versions of SOLm
/
Bcows
Bsires

BFemaleCalves1
BFemaleCalves2

BMaleCalves1
BMaleCalves2
/;

SET PigHerdCategories_SOLmOLD(AnimalCategoriesInHerd_VariousSources) Subset with PIG herd categories as used in older versions of SOLm
/
Sows
Sucklers
Weaners
Fatteners
Boars
Rep_Sows
Rep_Boars
/;



*1.2) SOLm herd structures sets from FAOSTAT
*the following lists specific subsets from FAOSTAT separately

SET AnimalCategoriesInHerd_FAOSTAT(AnimalCategoriesInHerd_VariousSources) Subset with animal categories as used in FAOSTAT
/
"LivingCattle FAOSTAT"
"SlaughtheredCattle FAOSTAT"
"ProducingDairyCattle FAOSTAT"

"LivingPigs FAOSTAT"
"SlaughtheredPigs FAOSTAT"

"LivingChicken FAOSTAT"
"SlaugtheredChicken FAOSTAT"
"ProducingEggChicken FAOSTAT"
/;


*1.3) SOLm herd structures sets from IPCC
*the following lists specific subsets from IPCC separately

SET AnimalCategoriesInHerd_IPCC2006(AnimalCategoriesInHerd_VariousSources) Subset with animal categories as used in IPCC2006
/
AllCategories

"Dairy Cow IPCC2006"
"Mature females IPCC2006"
"Mature males IPCC2006"
"Mature females - Grazing IPCC2006"
"Mature males - Grazing IPCC2006"
"Mature females - Farming IPCC2006"
"Mature males - Farming IPCC2006"
"Draft bullocks IPCC2006"
"Bulls - Grazing IPCC2006"
"Calves on milk IPCC2006"
"Calves on forage IPCC2006"
"Growing heifers/steers IPCC2006"
"Replacement/growing IPCC2006"
"Feedlot cattle IPCC2006"
"Young IPCC2006"

"Average Other Cattle IPCC2006"
"Average Buffaloes IPCC2006"
"Average Market Swine IPCC2006"
"Average Breeding Swine IPCC2006"
"Average Sheep IPCC2006"
"Average Goat IPCC2006"
"Average Camel IPCC2006"
"Average Horse IPCC2006"
"Average Mule IPCC2006"
"Average Ass IPCC2006"

"Average Pig IPCC2006"
"Average Chicken IPCC2006"
"Hens >= 1y old IPCC2006"
"Other Chicken >= 1y old IPCC2006"
"Pullet - Chicken < 1y old IPCC2006"
"Mink and Polecat IPCC2006"
"Rabbits IPCC2006"
"Fox and Racoon IPCC2006"


"Chickens Layer (dry) IPCC2006"
"Chickens Layer (wet) IPCC2006"
"Average Chicken Layers  IPCC2006"
"Chickens Broilers IPCC2006"
"Average Turkey IPCC2006"
"Average Duck IPCC2006"

*used for digestibility of feed - check the original values for this and whether these categories are really needed
"Poultry confined IPCC2006"
"Poultry free-range IPCC2006"
"Pigs confined IPCC2006"
"Pigs free-range IPCC2006"
/;

SET AnimalCategoriesInHerd_IPCC2006_Ruminants(AnimalCategoriesInHerd_VariousSources) Subset with RUMINANT categories as used in IPCC2006
/
"Dairy Cow IPCC2006"
"Mature females IPCC2006"
"Mature males IPCC2006"
"Mature females - Grazing IPCC2006"
"Mature males - Grazing IPCC2006"
"Mature females - Farming IPCC2006"
"Mature males - Farming IPCC2006"
"Draft bullocks IPCC2006"
"Bulls - Grazing IPCC2006"
"Calves on milk IPCC2006"
"Calves on forage IPCC2006"
"Growing heifers/steers IPCC2006"
"Replacement/growing IPCC2006"
"Feedlot cattle IPCC2006"
"Young IPCC2006"

"Average Other Cattle IPCC2006"
"Average Buffaloes IPCC2006"
"Average Sheep IPCC2006"
"Average Goat IPCC2006"
"Average Camel IPCC2006"
"Average Horse IPCC2006"
"Average Mule IPCC2006"
"Average Ass IPCC2006"
/;





