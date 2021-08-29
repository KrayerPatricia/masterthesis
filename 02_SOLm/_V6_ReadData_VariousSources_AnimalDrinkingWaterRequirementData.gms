PUTCLOSE con,"_V6_ReadData_VariousSources_AnimalDrinkingWaterRequirementData";

$ontext;
GENERAL DESCRIPTION
This file assigns the per animal head drinking water requirements

DETAILED TABLE OF CONTENTS
- 1) Livestock per head drinking water requirements (as already used in earlier versions of SOLm)
- 2) Assign values to core model parameters and variables
         2.1) Link some sets as needed
         2.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Livestock per head drinking water requirements (as already used in earlier versions of SOLm)

*Source: Water requirements of Livestock Fact Sheet: http://www.omafra.gov.on.ca/english/engineer/facts/07-023.htm, taking some averages by hand;
*these values are for Ontario - thus correct dairy for the huge yield, etc. - therefore 50 l/day may be ok for cattle, etc.
*not implemented, but e.g. to adjust by hand for the Kênya milk waste case study:
*         Drinking water in Africa: http://pdf.usaid.gov/pdf_docs/PNAAP943.pdf:
*                 for a Zebu of 350kg: 25 l/day rather than 50 (but for NON-milking animal!!)

*ATTENTION!!!! NEEDS TO BE IMPROVED TO ACCOUNT FOR REGIONAL DIFFERENCES - e.g. due to differences in average temperatures, seasons, etc.!!!

*unit: m^3/head/day
Parameter VariousSources_AnimalWaterRequirements(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems);

VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Cattle") = 0.05;
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Pigs"  ) = 0.01;
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Horses") = 0.03;
*from the data source, one may expect 10 liter, but it is rather lower, due to assumed few water intake for sheep on pastures...
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Sheep" ) = 0.005;
*same as sheep assumed
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Goats" ) = 0.005;
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Chickens") = 0.00025;
*same as chickens
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Ducks") = 0.00025;
*same as chickens
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Geese and guinea fowls") = 0.00025;
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Turkeys") = 0.0005;
*same as chickens / 10
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Pigeons, other birds") = 0.000025;
*same as chickens
*not needed, as it is an aggregate of chickens and ducks, etc.
*VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Poultry Birds") = 0.00025;

*the following 4 factors: inspired by animal type/size and relation to horse (e.g. camel: less demand) - to be improved and checked with literature
*same as horses / 2
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Asses") = 0.015;
*same as horses / 5
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Camelids, other") = 0.006;
*same as horses / 3
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Camels") = 0.01;
*same as horses / 2
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Mules") = 0.015;

*same as cattle
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Buffaloes") = 0.05;
*same as cattle
*THIS IS NOT NEEDED as we treat cattle and buffaloes separately
*VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Cattle and Buffaloes") = 0.05;
*same as sheep
*THIS IS NOT NEEDED as we treat cattle and buffaloes separately
*VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Sheep and Goats" ) = 0.005;

VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Beehives") = 0;

*same as chickens
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Rabbits and hares") = 0.00025;
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Rodents, other") = 0.00025;

*same as cattle / 3 - i.e. about the same as asses
VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,"Animals live nes") = 0.01666666667;


$ontext;
after this, we have:
Parameter VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems);
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Assign values to core model parameters and variables
*2.1) Link some sets as needed

*no new files needed

*2.2) Link to the core model parameters

*factor 365 to transfrom from m3/head/day to m3/head/year, as the original data above is per day
ActAnimalsHead_Inputs(Regions,Activities,"AllAndAverageTypes","Drinking water (m3)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Activities)),
                 VariousSources_AnimalWaterRequirements(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems))*365;

*add game=horses*0.7
ActAnimalsHead_Inputs(Regions,"Game","AllAndAverageTypes","Drinking water (m3)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_Inputs(Regions,"Horses","AllAndAverageTypes","Drinking water (m3)","AllProdSyst","AllProdCond")*0.7;

*assign drinking water values - which are averages over all herd animal types - to the herd animal types for cattle and pig:
ActAnimalsHead_Inputs(Regions,"Cattle",CattleTypeInHerd,"Drinking water (m3)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_Inputs(Regions,"Cattle","AllAndAverageTypes","Drinking water (m3)","AllProdSyst","AllProdCond");
ActAnimalsHead_Inputs(Regions,"Pigs",PigTypeInHerd,"Drinking water (m3)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_Inputs(Regions,"Pigs","AllAndAverageTypes","Drinking water (m3)","AllProdSyst","AllProdCond");



$ontext;
After this we have the following in SOLm-entities:

ActAnimalsHead_OtherChar(Regions,Activities,"AllAndAverageTypes","Drinking water (m3)","AllProdSyst","AllProdCond")
ActAnimalsHead_Inputs(Regions,"Cattle",CattleTypeInHerd,"Drinking water (m3)","AllProdSyst","AllProdCond")
ActAnimalsHead_Inputs(Regions,"Pigs",PigTypeInHerd,"Drinking water (m3)","AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Activities        is      Livestock plus Game
$offtext;
