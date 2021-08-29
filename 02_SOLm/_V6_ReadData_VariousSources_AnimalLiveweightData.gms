PUTCLOSE con,"_V6_ReadData_VariousSources_AnimalLiveweightData";

$ontext;
GENERAL DESCRIPTION
This file assigns the per animal head liveweight values

DETAILED TABLE OF CONTENTS
- 1) Liveweight data as used in old SOLm version (up to version SOLmV4)
- 2) Liveweight as defined in IPCC 2006
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Liveweight data as used in old SOLm version (up to version SOLmV4)

*this is basically the same data as below (IPCC 2006) - but directly assigned to the animal categories in herds used in these earlier SOLm versions, etc.
*this is thus not redone here, but rather done more correcly in the next section on the IPCC data





****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Liveweight as defined in IPCC 2006

$ontext;
From IPCC 2006 Volume 4, chapter 10, tables in the appendix
$offtext;

*unit: kg/head
Parameter Liveweight_IPCC2006(FAOSTAT_CountriesAndRegions,AnimalCategoriesInHerd_VariousSources);

*table 10A.1, for dairy cows:
$ontext;
*original regions are (left), and corresponding FAOSTAT regions assigned (right):
North America            Northern America
Western Europe           Western Europe, Northern Europe
Eastern Europe           Eastern Europe, Southern Europe
Oceania                  Oceania
Latin America            South America, Central America, Caribbean
Asia                     Asia
Africa and Middle East   Africa, Western Asia
Indian Subcontinent      India,  Bangladesch, Bhutan, Nepal, Pakistan und Sri Lanka (Wikipedia)
$offtext;

*in the following, we indicate the animal types as reported in IPCC, but we directly assign to the SOLm categories for easier processing in the code
*the linkage between the set of animal types is given by XXX displayed further down (but not used)
$ontext;
Liveweight_IPCC2006("Americas","Dairy Cow IPCC2006") = 400;
Liveweight_IPCC2006("Northern America","Dairy Cow IPCC2006") = 600;

Liveweight_IPCC2006("Western Europe","Dairy Cow IPCC2006") = 600;
Liveweight_IPCC2006("Northern Europe","Dairy Cow IPCC2006") = 600;
Liveweight_IPCC2006("Eastern Europe","Dairy Cow IPCC2006") = 550;
Liveweight_IPCC2006("Southern Europe","Dairy Cow IPCC2006") = 550;

Liveweight_IPCC2006("Oceania","Dairy Cow IPCC2006") = 500;

Liveweight_IPCC2006("Asia","Dairy Cow IPCC2006") = 350;

Liveweight_IPCC2006("Africa","Dairy Cow IPCC2006") = 275;
Liveweight_IPCC2006("Western Asia","Dairy Cow IPCC2006") = 275;
Liveweight_IPCC2006("Indian Subcontinent","Dairy Cow IPCC2006") = 275;
$offtext;

Liveweight_IPCC2006("Americas","Producing_Dairy_Cattle") = 400;
Liveweight_IPCC2006("Northern America","Producing_Dairy_Cattle") = 600;

Liveweight_IPCC2006("Western Europe","Producing_Dairy_Cattle") = 600;
Liveweight_IPCC2006("Northern Europe","Producing_Dairy_Cattle") = 600;
Liveweight_IPCC2006("Eastern Europe","Producing_Dairy_Cattle") = 550;
Liveweight_IPCC2006("Southern Europe","Producing_Dairy_Cattle") = 550;

Liveweight_IPCC2006("Oceania","Producing_Dairy_Cattle") = 500;

Liveweight_IPCC2006("Asia","Producing_Dairy_Cattle") = 350;

Liveweight_IPCC2006("Africa","Producing_Dairy_Cattle") = 275;
Liveweight_IPCC2006("Western Asia","Producing_Dairy_Cattle") = 275;
Liveweight_IPCC2006("Indian Subcontinent","Producing_Dairy_Cattle") = 275;


*table 10A.2, for other cattle:
$ontext;
*original regions are (left), and corresponding FAOSTAT regions assigned (right):
North America            Northern America
Western Europe           Western Europe, Northern Europe
Eastern Europe           Eastern Europe, Southern Europe
Oceania                  Oceania
Latin America            South America, Central America, Caribbean
Asia                     Asia
Africa                   Africa
Indian Subcontinent      India,  Bangladesch, Bhutan, Nepal, Pakistan und Sri Lanka (Wikipedia)
$offtext;
*Liveweight_IPCC2006("Americas","Mature females IPCC2006") = 400;
*Liveweight_IPCC2006("Americas","Mature males IPCC2006") = 450;
*Liveweight_IPCC2006("Americas","Young IPCC2006") = 230;
Liveweight_IPCC2006("Americas","BCows") = 400;
Liveweight_IPCC2006("Americas","BSires") = 450;
Liveweight_IPCC2006("Americas","DSires") = 450;
Liveweight_IPCC2006("Americas","DFemaleCalves1") = 230;
Liveweight_IPCC2006("Americas","DFemaleCalves2") = 230;
Liveweight_IPCC2006("Americas","DFemaleCalves3") = 230;
Liveweight_IPCC2006("Americas","DMaleCalves1") = 230;
Liveweight_IPCC2006("Americas","DMaleCalves2") = 230;
Liveweight_IPCC2006("Americas","BFemaleCalves1") = 230;
Liveweight_IPCC2006("Americas","BFemaleCalves2") = 230;
Liveweight_IPCC2006("Americas","BMaleCalves1") = 230;
Liveweight_IPCC2006("Americas","BMaleCalves2") = 230;

$ontext;
Liveweight_IPCC2006("Northern America","Mature females IPCC2006") = 500;
Liveweight_IPCC2006("Northern America","Mature males IPCC2006") = 800;
Liveweight_IPCC2006("Northern America","Calves on milk IPCC2006") = 100;
Liveweight_IPCC2006("Northern America","Calves on forage IPCC2006") = 185;
Liveweight_IPCC2006("Northern America","Growing heifers/steers IPCC2006") = 265;
Liveweight_IPCC2006("Northern America","Replacement/growing IPCC2006") = 375;
Liveweight_IPCC2006("Northern America","Feedlot cattle IPCC2006") = 415;
$offtext;
Liveweight_IPCC2006("Northern America","BCows") = 500;
Liveweight_IPCC2006("Northern America","DSires") = 800;
Liveweight_IPCC2006("Northern America","DFemaleCalves1") = 100;
Liveweight_IPCC2006("Northern America","DMaleCalves1") = 100;
Liveweight_IPCC2006("Northern America","BFemaleCalves1") = 100;
Liveweight_IPCC2006("Northern America","BMaleCalves1") = 100;
Liveweight_IPCC2006("Northern America","DFemaleCalves2") = 185;
Liveweight_IPCC2006("Northern America","DMaleCalves2") = 185;
Liveweight_IPCC2006("Northern America","BFemaleCalves2") = 185;
Liveweight_IPCC2006("Northern America","BMaleCalves2") = 220;
*the next one is BMaleCalves2 as well, thus use some sort of average weight
*Liveweight_IPCC2006("Northern America","Growing heifers/steers IPCC2006") = 265;
Liveweight_IPCC2006("Northern America","DFemaleCalves3") = 375;
*no correspondence to SOLm animal hed types
*Liveweight_IPCC2006("Northern America","Feedlot cattle IPCC2006") = 415;

$ontext;
Liveweight_IPCC2006("Western Europe","DSires") = 600;
Liveweight_IPCC2006("Western Europe","BSires") = 600;
Liveweight_IPCC2006("Western Europe","DFemaleCalves3") = 400;
Liveweight_IPCC2006("Western Europe","Calves on milk IPCC2006") = 230;
Liveweight_IPCC2006("Western Europe","Calves on forage IPCC2006") = 230;
$offtext;
Liveweight_IPCC2006("Western Europe","BCows") = 500;
Liveweight_IPCC2006("Western Europe","DSires") = 600;
Liveweight_IPCC2006("Western Europe","BSires") = 600;
Liveweight_IPCC2006("Western Europe","DFemaleCalves3") = 400;
Liveweight_IPCC2006("Western Europe","DFemaleCalves1") = 230;
Liveweight_IPCC2006("Western Europe","DMaleCalves1") = 230;
Liveweight_IPCC2006("Western Europe","BFemaleCalves1") = 230;
Liveweight_IPCC2006("Western Europe","BMaleCalves1") = 230;
Liveweight_IPCC2006("Western Europe","DFemaleCalves2") = 230;
Liveweight_IPCC2006("Western Europe","DMaleCalves2") = 230;
Liveweight_IPCC2006("Western Europe","BFemaleCalves2") = 230;
Liveweight_IPCC2006("Western Europe","BMaleCalves2") = 230;

$ontext;
Liveweight_IPCC2006("Northern Europe","DSires") = 600;
Liveweight_IPCC2006("Northern Europe","BSires") = 600;
Liveweight_IPCC2006("Northern Europe","DFemaleCalves3") = 400;
Liveweight_IPCC2006("Northern Europe","Calves on milk IPCC2006") = 230;
Liveweight_IPCC2006("Northern Europe","Calves on forage IPCC2006") = 230;
$offtext;
Liveweight_IPCC2006("Northern Europe","BCows") = 500;
Liveweight_IPCC2006("Northern Europe","DSires") = 600;
Liveweight_IPCC2006("Northern Europe","BSires") = 600;
Liveweight_IPCC2006("Northern Europe","DFemaleCalves3") = 400;
Liveweight_IPCC2006("Northern Europe","DFemaleCalves1") = 230;
Liveweight_IPCC2006("Northern Europe","DMaleCalves1") = 230;
Liveweight_IPCC2006("Northern Europe","BFemaleCalves1") = 230;
Liveweight_IPCC2006("Northern Europe","BMaleCalves1") = 230;
Liveweight_IPCC2006("Northern Europe","DFemaleCalves2") = 230;
Liveweight_IPCC2006("Northern Europe","DMaleCalves2") = 230;
Liveweight_IPCC2006("Northern Europe","BFemaleCalves2") = 230;
Liveweight_IPCC2006("Northern Europe","BMaleCalves2") = 230;

$ontext;
Liveweight_IPCC2006("Eastern Europe","Mature females IPCC2006") = 500;
Liveweight_IPCC2006("Eastern Europe","Mature males IPCC2006") = 600;
Liveweight_IPCC2006("Eastern Europe","Young IPCC2006") = 230;
$offtext;
Liveweight_IPCC2006("Eastern Europe","BCows") = 500;
Liveweight_IPCC2006("Eastern Europe","DSires") = 600;
Liveweight_IPCC2006("Eastern Europe","BSires") = 600;
Liveweight_IPCC2006("Eastern Europe","DFemaleCalves1") = 230;
Liveweight_IPCC2006("Eastern Europe","DFemaleCalves2") = 230;
Liveweight_IPCC2006("Eastern Europe","DFemaleCalves3") = 230;
Liveweight_IPCC2006("Eastern Europe","DMaleCalves1") = 230;
Liveweight_IPCC2006("Eastern Europe","DMaleCalves2") = 230;
Liveweight_IPCC2006("Eastern Europe","BFemaleCalves1") = 230;
Liveweight_IPCC2006("Eastern Europe","BFemaleCalves2") = 230;
Liveweight_IPCC2006("Eastern Europe","BMaleCalves1") = 230;
Liveweight_IPCC2006("Eastern Europe","BMaleCalves2") = 230;

$ontext;
Liveweight_IPCC2006("Southern Europe","Mature females IPCC2006") = 500;
Liveweight_IPCC2006("Southern Europe","Mature males IPCC2006") = 600;
Liveweight_IPCC2006("Southern Europe","Young IPCC2006") = 230;
$offtext;
Liveweight_IPCC2006("Southern Europe","BCows") = 500;
Liveweight_IPCC2006("Southern Europe","DSires") = 600;
Liveweight_IPCC2006("Southern Europe","BSires") = 600;
Liveweight_IPCC2006("Southern Europe","DFemaleCalves1") = 230;
Liveweight_IPCC2006("Southern Europe","DFemaleCalves2") = 230;
Liveweight_IPCC2006("Southern Europe","DFemaleCalves3") = 230;
Liveweight_IPCC2006("Southern Europe","DMaleCalves1") = 230;
Liveweight_IPCC2006("Southern Europe","DMaleCalves2") = 230;
Liveweight_IPCC2006("Southern Europe","BFemaleCalves1") = 230;
Liveweight_IPCC2006("Southern Europe","BFemaleCalves2") = 230;
Liveweight_IPCC2006("Southern Europe","BMaleCalves1") = 230;
Liveweight_IPCC2006("Southern Europe","BMaleCalves2") = 230;

$ontext;
Liveweight_IPCC2006("Oceania","Mature females IPCC2006") = 400;
Liveweight_IPCC2006("Oceania","Mature males IPCC2006") = 450;
Liveweight_IPCC2006("Oceania","Young IPCC2006") = 200;
$offtext;
Liveweight_IPCC2006("Oceania","BCows") = 400;
Liveweight_IPCC2006("Oceania","DSires") = 450;
Liveweight_IPCC2006("Oceania","BSires") = 450;
Liveweight_IPCC2006("Oceania","DFemaleCalves1") = 200;
Liveweight_IPCC2006("Oceania","DFemaleCalves2") = 200;
Liveweight_IPCC2006("Oceania","DFemaleCalves3") = 200;
Liveweight_IPCC2006("Oceania","DMaleCalves1") = 200;
Liveweight_IPCC2006("Oceania","DMaleCalves2") = 200;
Liveweight_IPCC2006("Oceania","BFemaleCalves1") = 200;
Liveweight_IPCC2006("Oceania","BFemaleCalves2") = 200;
Liveweight_IPCC2006("Oceania","BMaleCalves1") = 200;
Liveweight_IPCC2006("Oceania","BMaleCalves2") = 200;

$ontext;
Liveweight_IPCC2006("Asia","Mature females - Farming IPCC2006") = 325;
Liveweight_IPCC2006("Asia","Mature females - Grazing IPCC2006") = 300;
Liveweight_IPCC2006("Asia","Mature males - Farming IPCC2006") = 450;
Liveweight_IPCC2006("Asia","Mature males - Grazing IPCC2006") = 400;
Liveweight_IPCC2006("Asia","Young IPCC2006") = 200;
$offtext;
*do an average between the grazing/non grazing mature animals
Liveweight_IPCC2006("Asia","BCows") = 312.5;
Liveweight_IPCC2006("Asia","DSires") = 425;
Liveweight_IPCC2006("Asia","BSires") = 425;
Liveweight_IPCC2006("Asia","DFemaleCalves1") = 200;
Liveweight_IPCC2006("Asia","DFemaleCalves2") = 200;
Liveweight_IPCC2006("Asia","DFemaleCalves3") = 200;
Liveweight_IPCC2006("Asia","DMaleCalves1") = 200;
Liveweight_IPCC2006("Asia","DMaleCalves2") = 200;
Liveweight_IPCC2006("Asia","BFemaleCalves1") = 200;
Liveweight_IPCC2006("Asia","BFemaleCalves2") = 200;
Liveweight_IPCC2006("Asia","BMaleCalves1") = 200;
Liveweight_IPCC2006("Asia","BMaleCalves2") = 200;

$ontext;
Liveweight_IPCC2006("Africa","Mature females IPCC2006") = 200;
Liveweight_IPCC2006("Africa","Draft bullocks IPCC2006") = 275;
Liveweight_IPCC2006("Africa","Mature females - Grazing IPCC2006") = 200;
Liveweight_IPCC2006("Africa","Bulls - Grazing IPCC2006") = 275;
Liveweight_IPCC2006("Africa","Young IPCC2006") = 75;
$offtext;
Liveweight_IPCC2006("Africa","BCows") = 200;
Liveweight_IPCC2006("Africa","DSires") = 275;
Liveweight_IPCC2006("Africa","BSires") = 275;
Liveweight_IPCC2006("Africa","DFemaleCalves1") = 75;
Liveweight_IPCC2006("Africa","DFemaleCalves2") = 75;
Liveweight_IPCC2006("Africa","DFemaleCalves3") = 75;
Liveweight_IPCC2006("Africa","DMaleCalves1") = 75;
Liveweight_IPCC2006("Africa","DMaleCalves2") = 75;
Liveweight_IPCC2006("Africa","BFemaleCalves1") = 75;
Liveweight_IPCC2006("Africa","BFemaleCalves2") = 75;
Liveweight_IPCC2006("Africa","BMaleCalves1") = 75;
Liveweight_IPCC2006("Africa","BMaleCalves2") = 75;

$ontext;
Liveweight_IPCC2006("Indian Subcontinent","Mature females IPCC2006") = 125;
Liveweight_IPCC2006("Indian Subcontinent","Mature males IPCC2006") = 200;
Liveweight_IPCC2006("Indian Subcontinent","Young IPCC2006") = 80;
$offtext;
Liveweight_IPCC2006("Indian Subcontinent","BCows") = 125;
Liveweight_IPCC2006("Indian Subcontinent","DSires") = 200;
Liveweight_IPCC2006("Indian Subcontinent","BSires") = 200;
Liveweight_IPCC2006("Indian Subcontinent","DFemaleCalves1") = 80;
Liveweight_IPCC2006("Indian Subcontinent","DFemaleCalves2") = 80;
Liveweight_IPCC2006("Indian Subcontinent","DFemaleCalves3") = 80;
Liveweight_IPCC2006("Indian Subcontinent","DMaleCalves1") = 80;
Liveweight_IPCC2006("Indian Subcontinent","DMaleCalves2") = 80;
Liveweight_IPCC2006("Indian Subcontinent","BFemaleCalves1") = 80;
Liveweight_IPCC2006("Indian Subcontinent","BFemaleCalves2") = 80;
Liveweight_IPCC2006("Indian Subcontinent","BMaleCalves1") = 80;
Liveweight_IPCC2006("Indian Subcontinent","BMaleCalves2") = 80;

*table 10A.3, for Buffaloes:
*this gives huge ranges - thus we use the average values given further down in later tables for buffaloes (table 10A.6)

*table 10A.4, for dairy cows:
*this is the same for liveweight as defined already above - thus no need to do it again using this table

*table 10A.5, for other cattle - average values for all other cattle:
$ontext;
NO NEED for SOLm, as no other cattle categories are left
Liveweight_IPCC2006("Americas","Average Other Cattle IPCC2006") = 305;
Liveweight_IPCC2006("Northern America","Average Other Cattle IPCC2006") = 389;

Liveweight_IPCC2006("Western Europe","Average Other Cattle IPCC2006") = 420;
Liveweight_IPCC2006("Northern Europe","Average Other Cattle IPCC2006") = 420;
Liveweight_IPCC2006("Eastern Europe","Average Other Cattle IPCC2006") = 391;
Liveweight_IPCC2006("Southern Europe","Average Other Cattle IPCC2006") = 391;

Liveweight_IPCC2006("Oceania","Average Other Cattle IPCC2006") = 330;

Liveweight_IPCC2006("Asia","Average Other Cattle IPCC2006") = 319;

Liveweight_IPCC2006("Africa","Average Other Cattle IPCC2006") = 173;
Liveweight_IPCC2006("Western Asia","Average Other Cattle IPCC2006") = 173;
Liveweight_IPCC2006("Indian Subcontinent","Average Other Cattle IPCC2006") = 110;
$offtext;

*table 10A.6, for buffaloes - average values for all buffaloes:
*no values are reported here for North America, OCeania and Africa - but we just take the general value given for the other continents
*as in table 10A.2 above, where there is also a general range for all other countries besides Indian Subcontinent
*keep this as it is - this will then be assigned to Buffaloes.AllCategories
Liveweight_IPCC2006("World","Average Buffaloes IPCC2006") = 380;
Liveweight_IPCC2006("Indian Subcontinent","Average Buffaloes IPCC2006") = 295;

*table 10A.7, for market swine - average values:
$ontext;
Liveweight_IPCC2006("Americas","Average Market Swine IPCC2006") = 28;
Liveweight_IPCC2006("Northern America","Average Market Swine IPCC2006") = 46;

Liveweight_IPCC2006("Western Europe","Average Market Swine IPCC2006") = 50;
Liveweight_IPCC2006("Northern Europe","Average Market Swine IPCC2006") = 50;
Liveweight_IPCC2006("Eastern Europe","Average Market Swine IPCC2006") = 50;
Liveweight_IPCC2006("Southern Europe","Average Market Swine IPCC2006") = 50;

Liveweight_IPCC2006("Oceania","Average Market Swine IPCC2006") = 45;

Liveweight_IPCC2006("Asia","Average Market Swine IPCC2006") = 28;

Liveweight_IPCC2006("Africa","Average Market Swine IPCC2006") = 28;
Liveweight_IPCC2006("Western Asia","Average Market Swine IPCC2006") = 28;
Liveweight_IPCC2006("Indian Subcontinent","Average Market Swine IPCC2006") = 28;
$offtext;
Liveweight_IPCC2006("Americas","Sucklers") = 28;
Liveweight_IPCC2006("Americas","Weaners") = 28;
Liveweight_IPCC2006("Americas","Fatteners") = 28;
Liveweight_IPCC2006("Northern America","Sucklers") = 46;
Liveweight_IPCC2006("Northern America","Weaners") = 46;
Liveweight_IPCC2006("Northern America","Fatteners") = 46;

Liveweight_IPCC2006("Western Europe","Sucklers") = 50;
Liveweight_IPCC2006("Western Europe","Weaners") = 50;
Liveweight_IPCC2006("Western Europe","Fatteners") = 50;
Liveweight_IPCC2006("Northern Europe","Sucklers") = 50;
Liveweight_IPCC2006("Northern Europe","Weaners") = 50;
Liveweight_IPCC2006("Northern Europe","Fatteners") = 50;
Liveweight_IPCC2006("Eastern Europe","Sucklers") = 50;
Liveweight_IPCC2006("Eastern Europe","Weaners") = 50;
Liveweight_IPCC2006("Eastern Europe","Fatteners") = 50;
Liveweight_IPCC2006("Southern Europe","Sucklers") = 50;
Liveweight_IPCC2006("Southern Europe","Weaners") = 50;
Liveweight_IPCC2006("Southern Europe","Fatteners") = 50;

Liveweight_IPCC2006("Oceania","Sucklers") = 45;
Liveweight_IPCC2006("Oceania","Weaners") = 45;
Liveweight_IPCC2006("Oceania","Fatteners") = 45;

Liveweight_IPCC2006("Asia","Sucklers") = 28;
Liveweight_IPCC2006("Asia","Weaners") = 28;
Liveweight_IPCC2006("Asia","Fatteners") = 28;

Liveweight_IPCC2006("Africa","Sucklers") = 28;
Liveweight_IPCC2006("Africa","Weaners") = 28;
Liveweight_IPCC2006("Africa","Fatteners") = 28;
Liveweight_IPCC2006("Western Asia","Sucklers") = 28;
Liveweight_IPCC2006("Western Asia","Weaners") = 28;
Liveweight_IPCC2006("Western Asia","Fatteners") = 28;
Liveweight_IPCC2006("Indian Subcontinent","Sucklers") = 28;
Liveweight_IPCC2006("Indian Subcontinent","Weaners") = 28;
Liveweight_IPCC2006("Indian Subcontinent","Fatteners") = 28;

*table 10A.8, for breeding swine - average values:
$ontext;
Liveweight_IPCC2006("Americas","Average Breeding Swine IPCC2006") = 28;
Liveweight_IPCC2006("Northern America","Average Breeding Swine IPCC2006") = 198;

Liveweight_IPCC2006("Western Europe","Average Breeding Swine IPCC2006") = 198;
Liveweight_IPCC2006("Northern Europe","Average Breeding Swine IPCC2006") = 198;
Liveweight_IPCC2006("Eastern Europe","Average Breeding Swine IPCC2006") = 180;
Liveweight_IPCC2006("Southern Europe","Average Breeding Swine IPCC2006") = 180;

Liveweight_IPCC2006("Oceania","Average Breeding Swine IPCC2006") = 180;

Liveweight_IPCC2006("Asia","Average Breeding Swine IPCC2006") = 28;

Liveweight_IPCC2006("Africa","Average Breeding Swine IPCC2006") = 28;
Liveweight_IPCC2006("Western Asia","Average Breeding Swine IPCC2006") = 28;
Liveweight_IPCC2006("Indian Subcontinent","Average Breeding Swine IPCC2006") = 28;
$offtext;
Liveweight_IPCC2006("Americas","Sows") = 28;
Liveweight_IPCC2006("Americas","Boars") = 28;
Liveweight_IPCC2006("Americas","Rep_Sows") = 28;
Liveweight_IPCC2006("Americas","Rep_Boars") = 28;
Liveweight_IPCC2006("Northern America","Sows") = 198;
Liveweight_IPCC2006("Northern America","Boars") = 198;
Liveweight_IPCC2006("Northern America","Rep_Sows") = 198;
Liveweight_IPCC2006("Northern America","Rep_Boars") = 198;

Liveweight_IPCC2006("Western Europe","Sows") = 198;
Liveweight_IPCC2006("Western Europe","Boars") = 198;
Liveweight_IPCC2006("Western Europe","Rep_Sows") = 198;
Liveweight_IPCC2006("Western Europe","Rep_Boars") = 198;
Liveweight_IPCC2006("Northern Europe","Sows") = 198;
Liveweight_IPCC2006("Northern Europe","Boars") = 198;
Liveweight_IPCC2006("Northern Europe","Rep_Sows") = 198;
Liveweight_IPCC2006("Northern Europe","Rep_Boars") = 198;
Liveweight_IPCC2006("Eastern Europe","Sows") = 180;
Liveweight_IPCC2006("Eastern Europe","Boars") = 180;
Liveweight_IPCC2006("Eastern Europe","Rep_Sows") = 180;
Liveweight_IPCC2006("Eastern Europe","Rep_Boars") = 180;
Liveweight_IPCC2006("Southern Europe","Sows") = 180;
Liveweight_IPCC2006("Southern Europe","Boars") = 180;
Liveweight_IPCC2006("Southern Europe","Rep_Sows") = 180;
Liveweight_IPCC2006("Southern Europe","Rep_Boars") = 180;

Liveweight_IPCC2006("Oceania","Sows") = 180;
Liveweight_IPCC2006("Oceania","Boars") = 180;
Liveweight_IPCC2006("Oceania","Rep_Sows") = 180;
Liveweight_IPCC2006("Oceania","Rep_Boars") = 180;

Liveweight_IPCC2006("Asia","Sows") = 28;
Liveweight_IPCC2006("Asia","Boars") = 28;
Liveweight_IPCC2006("Asia","Rep_Sows") = 28;
Liveweight_IPCC2006("Asia","Rep_Boars") = 28;

Liveweight_IPCC2006("Africa","Sows") = 28;
Liveweight_IPCC2006("Africa","Boars") = 28;
Liveweight_IPCC2006("Africa","Rep_Sows") = 28;
Liveweight_IPCC2006("Africa","Rep_Boars") = 28;
Liveweight_IPCC2006("Western Asia","Sows") = 28;
Liveweight_IPCC2006("Western Asia","Boars") = 28;
Liveweight_IPCC2006("Western Asia","Rep_Sows") = 28;
Liveweight_IPCC2006("Western Asia","Rep_Boars") = 28;
Liveweight_IPCC2006("Indian Subcontinent","Sows") = 28;
Liveweight_IPCC2006("Indian Subcontinent","Boars") = 28;
Liveweight_IPCC2006("Indian Subcontinent","Rep_Sows") = 28;
Liveweight_IPCC2006("Indian Subcontinent","Rep_Boars") = 28;

*table 10A.9 for other animals - mainly average values:
*keep the averages as they are, they will then be assigned to the respective animals.AllCategories
Liveweight_IPCC2006("Developing Countries","Average Sheep IPCC2006") = 28;
Liveweight_IPCC2006("Developed Countries","Average Sheep IPCC2006") = 48.5;

Liveweight_IPCC2006("Developing Countries","Average Goat IPCC2006") =30;
Liveweight_IPCC2006("Developed Countries","Average Goat IPCC2006") = 38.5;
Liveweight_IPCC2006("Developing Countries","Average Camel IPCC2006") = 217;
Liveweight_IPCC2006("Developed Countries","Average Camel IPCC2006") = 217;
Liveweight_IPCC2006("Developing Countries","Average Horse IPCC2006") = 238;
Liveweight_IPCC2006("Developed Countries","Average Horse IPCC2006") = 377;
Liveweight_IPCC2006("Developing Countries","Average Mule IPCC2006") = 130;
Liveweight_IPCC2006("Developed Countries","Average Mule IPCC2006") = 130;
Liveweight_IPCC2006("Developing Countries","Average Ass IPCC2006") = 130;
Liveweight_IPCC2006("Developed Countries","Average Ass IPCC2006") = 130;

*for the poultry, there is no differentiation between countries - as no data is given for developing countries - we just take the values from developed ones reduce by 20%
$ontext;
Liveweight_IPCC2006("Developing Countries","Chickens Layer (dry) IPCC2006") =1.44;
Liveweight_IPCC2006("Developed Countries","Chickens Layer (dry) IPCC2006") = 1.8;
Liveweight_IPCC2006("Developing Countries","Chickens Layer (wet) IPCC2006") =1.44;
Liveweight_IPCC2006("Developed Countries","Chickens Layer (wet) IPCC2006") = 1.8;
Liveweight_IPCC2006("Developing Countries","Chickens Broilers IPCC2006") =0.72;
Liveweight_IPCC2006("Developed Countries","Chickens Broilers IPCC2006") = 0.9;
$offtext;
*assign average chicken only as we do not have herd structure there:
*do average such as to reduce laying by one third - very gross
Liveweight_IPCC2006("Developing Countries","Average Chicken IPCC2006") =1.2;
Liveweight_IPCC2006("Developed Countries","Average Chicken IPCC2006") = 0.96;


Liveweight_IPCC2006("Developing Countries","Average Turkey IPCC2006") =5.44;
Liveweight_IPCC2006("Developed Countries","Average Turkey IPCC2006") = 6.8;
Liveweight_IPCC2006("Developing Countries","Average Duck IPCC2006") =2.16;
Liveweight_IPCC2006("Developed Countries","Average Duck IPCC2006") = 2.7;

Liveweight_IPCC2006("World","Rabbits IPCC2006") = 1.6;


*now assign the regional average values to the countries within those regions, where no data is available on country level

*first, on the level of the special grouping "Indian Subcontinent"
Liveweight_IPCC2006(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources)
                 $FAOSTAT_CountriesInRegions("Indian Subcontinent",FAOSTAT_Countries)
         = Liveweight_IPCC2006("Indian Subcontinent",AnimalCategoriesInHerd_VariousSources);

*second, on the level of sub-continents
Liveweight_IPCC2006(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources)
                 $(NOT Liveweight_IPCC2006(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources))
         = sum(FAOSTAT_Subcontinents$FAOSTAT_CountriesInRegions(FAOSTAT_Subcontinents,FAOSTAT_Countries),Liveweight_IPCC2006(FAOSTAT_Subcontinents,AnimalCategoriesInHerd_VariousSources));

*third, if no sub-continent averages are available, on the level of continents:
*conditional to whether there are now values on country levels (original, or from the sub-continents) - thus, only the truly missing are assigned
Liveweight_IPCC2006(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources)
                 $(NOT Liveweight_IPCC2006(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources))
         = sum(FAOSTAT_Continents$FAOSTAT_CountriesInRegions(FAOSTAT_Continents,FAOSTAT_Countries),Liveweight_IPCC2006(FAOSTAT_Continents,AnimalCategoriesInHerd_VariousSources));

*fourth, on the level of non-geographic subsets, i.e. developing/developed countries, where also some values are given:
Liveweight_IPCC2006(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources)
                 $(NOT Liveweight_IPCC2006(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources))
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),Liveweight_IPCC2006(FAOSTAT_DevelopedDevelopingGroups,AnimalCategoriesInHerd_VariousSources));

*fifth, on global level, if averages for continents are missing:
*conditional to whether there are now values on country levels (original, or from the sub-continents or continents) - thus, only the truly missing are assigned
Liveweight_IPCC2006(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources)
                 $(NOT Liveweight_IPCC2006(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources))
         = Liveweight_IPCC2006("World",AnimalCategoriesInHerd_VariousSources);

*after this, liveweight values are available for all countries in FAOSTAT_Countries and for AnimalCategoriesInHerd_VariousSources as assigned above



$ontext;
after this, we have:
Parameter Liveweight_IPCC2006(FAOSTAT_CountriesAndRegions,AnimalCategoriesInHerd_IPCC2006);
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

Set Match_TypeInHerd_ActivitiesAndHerdStructure(AnimalCategoriesInHerd_VariousSources,Activities,AnimalTypeInHerd)
/
*the following captures all "non-dairy cow"-cattle, used in IPCC 2006, vol 4, ch 10, table 10.19
"Average Buffaloes IPCC2006".Buffaloes.AllAndAverageTypes
"Average Sheep IPCC2006"    .Sheep.AllAndAverageTypes
"Average Goat IPCC2006"     .Goats.AllAndAverageTypes
"Average Camel IPCC2006"    .Camels.AllAndAverageTypes
"Average Horse IPCC2006"    .Horses.AllAndAverageTypes
"Average Mule IPCC2006"     .Mules.AllAndAverageTypes
"Average Ass IPCC2006"      .Asses.AllAndAverageTypes
"Average Chicken IPCC2006"  .Chickens.AllAndAverageTypes
"Average Turkey IPCC2006"   .Turkeys.AllAndAverageTypes
"Average Duck IPCC2006"     .Ducks.AllAndAverageTypes

Producing_Dairy_Cattle      .Cattle.Producing_Dairy_Cattle
Dsires                      .Cattle.Dsires

DFemaleCalves1              .Cattle.DFemaleCalves1
DFemaleCalves2              .Cattle.DFemaleCalves2
DFemaleCalves3              .Cattle.DFemaleCalves3

DMaleCalves1                .Cattle.DMaleCalves1
DMaleCalves2                .Cattle.DMaleCalves2

Bcows                       .Cattle.Bcows
Bsires                      .Cattle.Bsires

BFemaleCalves1              .Cattle.BFemaleCalves1
BFemaleCalves2              .Cattle.BFemaleCalves2

BMaleCalves1                .Cattle.BMaleCalves1
BMaleCalves2                .Cattle.BMaleCalves2

Sows                        .Pigs.  Sows
Sucklers                    .Pigs.  Sucklers
Weaners                     .Pigs.  Weaners
Fatteners                   .Pigs.  Fatteners
Boars                       .Pigs.  Boars
Rep_Sows                    .Pigs.  Rep_Sows
Rep_Boars                   .Pigs.  Rep_Boars
/;


*3.2) Link to the core model parameters

*division by 1000 as the original is in kg/head
ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,"Liveweight (t)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND Match_TypeInHerd_ActivitiesAndHerdStructure(AnimalCategoriesInHerd_VariousSources,Activities,AnimalTypeInHerd)),
                 Liveweight_IPCC2006(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources)/1000);


*and add missing animals:
*assumption by A. Müller: Llamas, etc. weight a third of a camel on average, about 70kg
ActAnimalsHead_OtherChar(Regions,"Camelids, other","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Camels","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond")*0.3;
*and some more
ActAnimalsHead_OtherChar(Regions,"Geese and guinea fowls","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Ducks","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Rodents, other","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Rabbits and hares","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond");
*Pigeons, other birds: 0.1* Chickens
ActAnimalsHead_OtherChar(Regions,"Pigeons, other birds","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Chickens","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond")*0.1;
*Animals live nes: Asses
ActAnimalsHead_OtherChar(Regions,"Animals live nes","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Asses","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond");
*Game: 70% of horses
ActAnimalsHead_OtherChar(Regions,"Game","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Horses","AllAndAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond")*0.7;


$ontext;
After this we have the following in SOLm-entities:

ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,"Liveweight (t)","AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Activities        is      FAOSTAT_LiveAnimalsItems
AnimalTypeInHerd  is      SOLm herd categories
$offtext;
