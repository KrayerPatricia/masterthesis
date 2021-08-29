PUTCLOSE con,"_V6_ReadData_FAOSTAT_LivestockProduction";

$ontext;
GENERAL DESCRIPTION
This file reads the livestock production and living animal data from FAOSTAT

DETAILED TABLE OF CONTENTS
- 1) reading the csv-file and loading the parameters
- 2) build average over the base year period chosen to get the baseline values
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) reading the csv-file and loading the parameters

*read csv files from FAOSTAT into gdx if something has changed - else directly load the gdx files, later on in the code

*The following code runs quite long due to the long matching files; thus, read in the gdx-file produced at the end in case nothing changed here. Otherwise execute the code.
$if %ReadNewFAOSTATLivestockProductionData% == "NO" $goto UseOldLivestockFile

*$ifthen %ReadNewFAOSTATLivestockProductionData% == "YES"
$call csv2gdx FAOSTAT_LivestockPrimaryNormalized_29_11_2017.csv id=FAOSTAT_LivestockPrimaryProduction Index=(2,4,6,8,9) Values=(10) UseHeader=Y
$call csv2gdx FAOSTAT_LiveAnimalsNormalized_29_11_2017.csv id=FAOSTAT_LivingAnimals Index=(2,4,6,8,9) Values=(10) UseHeader=Y
$call csv2gdx FAOSTAT_LivestockProcessedNormalized_29_11_2017.csv id=FAOSTAT_LivestockProcessed Index=(2,4,6,8,9) Values=(10) UseHeader=Y
*contains FAO Livestock production data: first set: producing animals, yields, production quantitites; second set: living animals; third set: production of processed animal products - production quantities only
*$endif;


Parameter FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits);
Parameter FAOSTAT_LivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits);
Parameter FAOSTAT_LivestockProcessed(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits);

$gdxin FAOSTAT_LivestockPrimaryNormalized_29_11_2017.gdx
$load FAOSTAT_LivestockPrimaryProduction
$gdxin
$gdxin FAOSTAT_LiveAnimalsNormalized_29_11_2017.gdx
$load FAOSTAT_LivingAnimals
$gdxin
$gdxin FAOSTAT_LivestockProcessedNormalized_29_11_2017.gdx
$load FAOSTAT_LivestockProcessed
$gdxin


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) build average over the base year period chosen to get the baseline values

PARAMETER NumberOfBasisYearsFAOSTATLivestockPrimaryProduction;
PARAMETER NumberOfBasisYearsFAOSTATLivingAnimals;
PARAMETER NumberOfBasisYearsFAOSTATLivestockProcessed;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....

*to efficiently code this, the following subset is needed:
Set FAOSTAT_LivestockProductionElements_NotYield(FAOSTAT_LivestockProductionElements)
/
"Stocks"
"Laying"
"Milk Animals"
"Prod Popultn"
"Producing Animals/Slaughtered"
"Production"
/;

NumberOfBasisYearsFAOSTATLivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements_NotYield,FAOSTAT_LivestockProductionUnits)
         = SUM(BasisYears$FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements_NotYield,BasisYears,FAOSTAT_LivestockProductionUnits),1);
FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements_NotYield,"AverageBasisYear",FAOSTAT_LivestockProductionUnits)
                 $NumberOfBasisYearsFAOSTATLivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements_NotYield,FAOSTAT_LivestockProductionUnits)
         = SUM(BasisYears,FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements_NotYield,BasisYears,FAOSTAT_LivestockProductionUnits))
                 /NumberOfBasisYearsFAOSTATLivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements_NotYield,FAOSTAT_LivestockProductionUnits);

NumberOfBasisYearsFAOSTATLivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements_NotYield,FAOSTAT_LivestockProductionUnits)
         = SUM(BasisYears$FAOSTAT_LivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements_NotYield,BasisYears,FAOSTAT_LivestockProductionUnits),1);
FAOSTAT_LivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements_NotYield,"AverageBasisYear",FAOSTAT_LivestockProductionUnits)
                 $NumberOfBasisYearsFAOSTATLivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements_NotYield,FAOSTAT_LivestockProductionUnits)
         = SUM(BasisYears,FAOSTAT_LivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements_NotYield,BasisYears,FAOSTAT_LivestockProductionUnits))
                 /NumberOfBasisYearsFAOSTATLivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements_NotYield,FAOSTAT_LivestockProductionUnits);

NumberOfBasisYearsFAOSTATLivestockProcessed(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockProcessedItems)
         = SUM(BasisYears$FAOSTAT_LivestockProcessed(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockProcessedItems,"Production",BasisYears,"tonnes"),1);
FAOSTAT_LivestockProcessed(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockProcessedItems,"Production","AverageBasisYear","tonnes")
                 $NumberOfBasisYearsFAOSTATLivestockProcessed(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockProcessedItems)
         = SUM(BasisYears,FAOSTAT_LivestockProcessed(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockProcessedItems,"Production",BasisYears,"tonnes"))
                 /NumberOfBasisYearsFAOSTATLivestockProcessed(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockProcessedItems);

*derive the average yields:
*factor 10000 to transform tonnes into hg
FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An")
                 $FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Producing Animals/Slaughtered","AverageBasisYear","Head")
         = FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","tonnes")*10000
                 /FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Producing Animals/Slaughtered","AverageBasisYear","Head");
*below, for chicken meat, measured in 1000 heads, thus division by 1000
FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An")
                 $(FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Producing Animals/Slaughtered","AverageBasisYear","1000 Head")
                         AND (NOT FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An")))
         = FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","tonnes")*10000/1000
                 /FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Producing Animals/Slaughtered","AverageBasisYear","1000 Head");

*for some other animals, other elements result in the number of producing animals, etc.
FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An")
                 $(FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","Head")
                         AND (NOT FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An")))
         = FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","tonnes")*10000
                 /FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","Head");
FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An")
                 $(FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","1000 Head")
                         AND (NOT FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An")))
         = FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","tonnes")*10000/1000
                 /FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","1000 Head");

FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An")
                 $(FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Milk Animals","AverageBasisYear","Head")
                         AND (NOT FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An")))
         = FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","tonnes")*10000
                 /FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Milk Animals","AverageBasisYear","Head");

*again: division by 1000 to transform from 1000 heads to heads
FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An")
                 $(FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Laying","AverageBasisYear","1000 Head")
                         AND (NOT FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An")))
         = FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","tonnes")*10000/1000
                 /FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,"Laying","AverageBasisYear","1000 Head");

*and for honey:
*factor 10000 to get hg from tonnes
*FIRST: correct values that are clearly wrong, as they result in yiedl values that are a factor 1000 too high:
FAOSTAT_LivingAnimals("Belarus","Beehives","Stocks","AverageBasisYear","No")
         = FAOSTAT_LivingAnimals("Belarus","Beehives","Stocks","AverageBasisYear","No")*1000;
FAOSTAT_LivingAnimals("Latvia","Beehives","Stocks","AverageBasisYear","No")
         = FAOSTAT_LivingAnimals("Latvia","Beehives","Stocks","AverageBasisYear","No")*1000;

FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,"Honey, natural","Yield","AverageBasisYear","hg/An")
                 $FAOSTAT_LivingAnimals(FAOSTAT_CountriesAndRegions,"Beehives","Stocks","AverageBasisYear","No")
         = FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,"Honey, natural","Production","AverageBasisYear","tonnes")*10000
                 /FAOSTAT_LivingAnimals(FAOSTAT_CountriesAndRegions,"Beehives","Stocks","AverageBasisYear","No");
*and for wax:
*factor 10000 to get hg from tonnes
FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,"Beeswax","Yield","AverageBasisYear","hg/An")
                 $FAOSTAT_LivingAnimals(FAOSTAT_CountriesAndRegions,"Beehives","Stocks","AverageBasisYear","No")
         = FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,"Beeswax","Production","AverageBasisYear","tonnes")*10000
                 /FAOSTAT_LivingAnimals(FAOSTAT_CountriesAndRegions,"Beehives","Stocks","AverageBasisYear","No");

*to avoid double counting: drop China subregions here and retain China only:
FAOSTAT_LivestockPrimaryProduction("China",FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 $(NOT FAOSTAT_LivestockPrimaryProduction("China",FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits))
         = FAOSTAT_LivestockPrimaryProduction("China, Hong Kong SAR",FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 + FAOSTAT_LivestockPrimaryProduction("China, Macao SAR",FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 + FAOSTAT_LivestockPrimaryProduction("China, mainland",FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 + FAOSTAT_LivestockPrimaryProduction("China, Taiwan Province of",FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits);

FAOSTAT_LivingAnimals("China",FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 $(NOT FAOSTAT_LivingAnimals("China",FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits))
         = FAOSTAT_LivingAnimals("China, Hong Kong SAR",FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 + FAOSTAT_LivingAnimals("China, Macao SAR",FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 + FAOSTAT_LivingAnimals("China, mainland",FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 + FAOSTAT_LivingAnimals("China, Taiwan Province of",FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits);

FAOSTAT_LivestockProcessed("China",FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 $(NOT FAOSTAT_LivestockProcessed("China",FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits))
         = FAOSTAT_LivestockProcessed("China, Hong Kong SAR",FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 + FAOSTAT_LivestockProcessed("China, Macao SAR",FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 + FAOSTAT_LivestockProcessed("China, mainland",FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits)
                 + FAOSTAT_LivestockProcessed("China, Taiwan Province of",FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits);

FAOSTAT_LivestockPrimaryProduction("China, Hong Kong SAR",FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;
FAOSTAT_LivestockPrimaryProduction("China, Macao SAR",FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;
FAOSTAT_LivestockPrimaryProduction("China, mainland",FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;
FAOSTAT_LivestockPrimaryProduction("China, Taiwan Province of",FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;

FAOSTAT_LivingAnimals("China, Hong Kong SAR",FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;
FAOSTAT_LivingAnimals("China, Macao SAR",FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;
FAOSTAT_LivingAnimals("China, mainland",FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;
FAOSTAT_LivingAnimals("China, Taiwan Province of",FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;

FAOSTAT_LivestockProcessed("China, Hong Kong SAR",FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;
FAOSTAT_LivestockProcessed("China, Macao SAR",FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;
FAOSTAT_LivestockProcessed("China, mainland",FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;
FAOSTAT_LivestockProcessed("China, Taiwan Province of",FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits) = 0;


$ontext;
after this, we have
Parameter FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits);
Parameter FAOSTAT_LivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits);
Parameter FAOSTAT_LivestockProcessed(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockProcessedItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

*assign the livestock primary production to activities and output type:
Set MatchFAOSTATLivestockPrimary_ActivityOutputtype(FAOSTAT_LivestockPrimaryItems,Activities,OutputsAnimals)
*TO BE CHECKED AGAIN: is the "indigenous" item really the best estimate for domestic production? I think so, but check the definitions again.
*        and do we loose something significant by dropping some of the items?

*we assign all values for birds different than chicken to "Pigeons, other birds" (and not to "poultry birds").
*we drop values that seem aggregates of other to avoid double counting
/
*"Beef and Buffalo Meat"
"Beeswax"."Beehives"."Wax (t)"
*"Eggs Primary"
"Eggs, hen, in shell"."Chickens"."Eggs (t)"
*"Eggs, hen, in shell (number)"
"Eggs, other bird, in shell"."Pigeons, other birds"."Eggs (t)"
*"Eggs, other bird, in shell (number)"
*"Hair, horse"
"Hides, buffalo, fresh"."Buffaloes"."HidesSkins (t)"
"Hides, cattle, fresh"."Cattle"."HidesSkins (t)"
"Honey, natural"."Beehives"."Honey (t)"
"Meat indigenous, ass"."Asses"."Meat (t)"
"Meat indigenous, bird nes"."Pigeons, other birds"."Meat (t)"
"Meat indigenous, buffalo"."Buffaloes"."Meat (t)"
"Meat indigenous, camel"."Camels"."Meat (t)"
"Meat indigenous, cattle"."Cattle"."Meat (t)"
"Meat indigenous, chicken"."Chickens"."Meat (t)"
"Meat indigenous, duck"."Ducks"."Meat (t)"
"Meat indigenous, geese"."Geese and guinea fowls"."Meat (t)"
"Meat indigenous, goat"."Goats"."Meat (t)"
"Meat indigenous, horse"."Horses"."Meat (t)"
"Meat indigenous, mule"."Mules"."Meat (t)"
"Meat indigenous, other camelids"."Camelids, other"."Meat (t)"
"Meat indigenous, pig"."Pigs"."Meat (t)"
*"Meat indigenous, poultry"
"Meat indigenous, rabbit"."Rabbits and hares"."Meat (t)"
"Meat indigenous, rodents"."Rodents, other"."Meat (t)"
"Meat indigenous, sheep"."Sheep"."Meat (t)"
*"Meat indigenous, total"
"Meat indigenous, turkey"."Turkeys"."Meat (t)"
*"Meat, ass"
*"Meat, bird nes"
*"Meat, buffalo"
*"Meat, camel"
*"Meat, cattle"
*"Meat, chicken"
*"Meat, duck"
*"Meat, game"
*"Meat, goat"
*"Meat, goose and guinea fowl"
*"Meat, horse"
*"Meat, mule"
*"Meat, nes"
*"Meat, other camelids"
*"Meat, other rodents"
*"Meat, pig"
*"Meat, Poultry"
*"Meat, rabbit"
*"Meat, sheep"
*"Meat, Total"
*"Meat, turkey"
"Milk, whole fresh buffalo"."Buffaloes"."Milk (t)"
"Milk, whole fresh camel"."Camels"."Milk (t)"
"Milk, whole fresh cow"."Cattle"."Milk (t)"
"Milk, whole fresh goat"."Goats"."Milk (t)"
"Milk, whole fresh sheep"."Sheep"."Milk (t)"
*"Milk,Total"
"Offals, nes"."Animals live nes"."Offals (t)"
*"Pigeons, other birds"
*"Sheep and Goat Meat"
*"Silk-worm cocoons, reelable"
*"Skins, furs"
"Skins, goat, fresh"."Goats"."HidesSkins (t)"
"Skins, sheep, fresh"."Sheep"."HidesSkins (t)"
*"Skins, sheep, with wool"
*"Snails, not sea"
"Wool, greasy"."Sheep"."Wool (t)"
/;


$ontext;
the following is not needed here anymore as it is already defined in _V6_Sets_GeneralModelSets as this file here runs for a long time and is not always executed,
while this matching set is however needed in other files as well - hence its definition in the general set file


*the following matching set needs to be defined, as the definition of the set ActivitySOLmV5 regrettably does not result in FAOSTAT_LiveAnimalsItems being accessible as a subset of it
*        albeit all its elements are part of it.
*ATTENTION: for simplification of set 1:1 matches of elements: use #FAOSTAT_LiveAnimalsItems:#FAOSTAT_LiveAnimalsItems
*        but this gives an error matching, that such 1:1-math of unordered lists can lead to unexpected results
*        Check this and work on this to be able to use this code without problems, as we have such 1:1-matches here and there in the code
Set MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Activities)
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
*an alternative for this:
*#FAOSTAT_LiveAnimalsItems:#FAOSTAT_LiveAnimalsItems
*but this gives an error matching, that such 1:1-math of unordered lists can lead to unexpected results
*therefore we keep it as above - but may work on how to use #FAOSTAT_LiveAnimalsItems:#FAOSTAT_LiveAnimalsItems without problems (cf. comment at the end of this file).

$offtext;


*assign producing animals for livestock products
set Match_LivestockPrimaryItems_ProducingAnimalsOutputs(FAOSTAT_LivestockPrimaryItems,Activities,AnimalTypeInHerd)
/
*"Beef and Buffalo Meat"
"Beeswax".Beehives."Wax Producing"
*"Eggs Primary"
"Eggs, hen, in shell".Chickens."Egg Producing"
*"Eggs, hen, in shell (number)".Chickens."Egg Producing"
"Eggs, other bird, in shell"."Pigeons, other birds"."Egg Producing"
*"Eggs, other bird, in shell (number)"."Pigeons, other birds"."Egg Producing"
"Hair, horse".Horses."HidesSkins Producing"
"Hides, buffalo, fresh".Buffaloes."HidesSkins Producing"
"Hides, cattle, fresh".Cattle."HidesSkins Producing"
"Honey, natural".Beehives."Honey Producing"
"Meat indigenous, ass".Asses."Meat Producing"
"Meat indigenous, bird nes"."Pigeons, other birds"."Meat Producing"
"Meat indigenous, buffalo".Buffaloes."Meat Producing"
"Meat indigenous, camel".Camels."Meat Producing"
"Meat indigenous, cattle".Cattle."Meat Producing"
"Meat indigenous, chicken".Chickens."Meat Producing"
"Meat indigenous, duck".Ducks."Meat Producing"
"Meat indigenous, geese"."Geese and guinea fowls"."Meat Producing"
"Meat indigenous, goat".Goats."Meat Producing"
"Meat indigenous, horse".Horses."Meat Producing"
"Meat indigenous, mule".Mules."Meat Producing"
"Meat indigenous, other camelids"."Camelids, other"."Meat Producing"
"Meat indigenous, pig".Pigs."Meat Producing"
*"Meat indigenous, poultry"."Poultry Birds"."Meat Producing"
*        assumingly the same as chicken meat, or the sum with ducks, etc. - but needs to be checked....
"Meat indigenous, rabbit"."Rabbits and hares"."Meat Producing"
"Meat indigenous, rodents"."Rodents, other"."Meat Producing"
"Meat indigenous, sheep".Sheep."Meat Producing"
*"Meat indigenous, total"
"Meat indigenous, turkey".Turkeys."Meat Producing"
$ontext;
"Meat, ass"
"Meat, bird nes"
"Meat, buffalo"
"Meat, camel"
"Meat, cattle"
"Meat, chicken"
"Meat, duck"
"Meat, game"
"Meat, goat"
"Meat, goose and guinea fowl"
"Meat, horse"
"Meat, mule"
"Meat, nes"
"Meat, other camelids"
"Meat, other rodents"
"Meat, pig"
"Meat, Poultry"
"Meat, rabbit"
"Meat, sheep"
"Meat, Total"
"Meat, turkey"
$offtext;
"Milk, whole fresh buffalo".Buffaloes."Milk Producing"
"Milk, whole fresh camel".Camels."Milk Producing"
"Milk, whole fresh cow".Cattle."Milk Producing"
"Milk, whole fresh goat".Goats."Milk Producing"
"Milk, whole fresh sheep".Sheep."Milk Producing"
*"Milk,Total"
"Offals, nes"."Animals live nes"."Offals Producing"
"Pigeons, other birds"."Pigeons, other birds"."Meat Producing"
*"Sheep and Goat Meat"
*"Silk-worm cocoons, reelable"
*"Skins, furs"
"Skins, goat, fresh".Goats."HidesSkins Producing"
"Skins, sheep, fresh".Sheep."HidesSkins Producing"
"Skins, sheep, with wool".Sheep."Wool Producing"
*"Snails, not sea"
*"Wool, greasy"
/;


*assign the livestock primary production to activities and Yield type:
Set MatchFAOSTATLivestockPrimary_ActivitiesYield(FAOSTAT_LivestockPrimaryItems,Activities,AnimalTypeInHerd,OutputsAnimals)
*TO BE CHECKED AGAIN: is the "indigenous" item really the best estimate for domestic production? I think so, but check the definitions again.
*        and do we loose something significant by dropping some of the items?
/
*"Beef and Buffalo Meat"
"Beeswax"."Beehives"."Wax Producing"."Wax (t)"
*"Eggs Primary"
"Eggs, hen, in shell"."Chickens"."Egg Producing"."Eggs (t)"
*"Eggs, hen, in shell (number)"
"Eggs, other bird, in shell"."Pigeons, other birds"."Egg Producing"."Eggs (t)"
*"Eggs, other bird, in shell (number)"
*"Hair, horse"
"Hides, buffalo, fresh"."Buffaloes"."HidesSkins Producing"."HidesSkins (t)"
"Hides, cattle, fresh"."Cattle"."HidesSkins Producing"."HidesSkins (t)"
"Honey, natural"."Beehives"."Honey Producing"."Honey (t)"
"Meat indigenous, ass"."Asses"."Meat Producing"."Meat (t)"
"Meat indigenous, bird nes"."Pigeons, other birds"."Meat Producing"."Meat (t)"
"Meat indigenous, buffalo"."Buffaloes"."Meat Producing"."Meat (t)"
"Meat indigenous, camel"."Camels"."Meat Producing"."Meat (t)"
"Meat indigenous, cattle"."Cattle"."Meat Producing"."Meat (t)"
"Meat indigenous, chicken"."Chickens"."Meat Producing"."Meat (t)"
"Meat indigenous, duck"."Ducks"."Meat Producing"."Meat (t)"
"Meat indigenous, geese"."Geese and guinea fowls"."Meat Producing"."Meat (t)"
"Meat indigenous, goat"."Goats"."Meat Producing"."Meat (t)"
"Meat indigenous, horse"."Horses"."Meat Producing"."Meat (t)"
"Meat indigenous, mule"."Mules"."Meat Producing"."Meat (t)"
"Meat indigenous, other camelids"."Camelids, other"."Meat Producing"."Meat (t)"
"Meat indigenous, pig"."Pigs"."Meat Producing"."Meat (t)"
*"Meat indigenous, poultry"
"Meat indigenous, rabbit"."Rabbits and hares"."Meat Producing"."Meat (t)"
"Meat indigenous, rodents"."Rodents, other"."Meat Producing"."Meat (t)"
"Meat indigenous, sheep"."Sheep"."Meat Producing"."Meat (t)"
*"Meat indigenous, total"
"Meat indigenous, turkey"."Turkeys"."Meat Producing"."Meat (t)"
*"Meat, ass"
*"Meat, bird nes"
*"Meat, buffalo"
*"Meat, camel"
*"Meat, cattle"
*"Meat, chicken"
*"Meat, duck"
*"Meat, game"
*"Meat, goat"
*"Meat, goose and guinea fowl"
*"Meat, horse"
*"Meat, mule"
*"Meat, nes"
*"Meat, other camelids"
*"Meat, other rodents"
*"Meat, pig"
*"Meat, Poultry"
*"Meat, rabbit"
*"Meat, sheep"
*"Meat, Total"
*"Meat, turkey"
"Milk, whole fresh buffalo"."Buffaloes"."Milk Producing"."Milk (t)"
"Milk, whole fresh camel"."Camels"."Milk Producing"."Milk (t)"
"Milk, whole fresh cow"."Cattle"."Milk Producing"."Milk (t)"
"Milk, whole fresh goat"."Goats"."Milk Producing"."Milk (t)"
"Milk, whole fresh sheep"."Sheep"."Milk Producing"."Milk (t)"
*"Milk,Total"
"Offals, nes"."Animals live nes"."Offals Producing"."Offals (t)"
*"Pigeons, other birds"
*"Sheep and Goat Meat"
*"Silk-worm cocoons, reelable"
*"Skins, furs"
"Skins, goat, fresh"."Goats"."HidesSkins Producing"."HidesSkins (t)"
"Skins, sheep, fresh"."Sheep"."HidesSkins Producing"."HidesSkins (t)"
*"Skins, sheep, with wool"
*"Snails, not sea"
"Wool, greasy"."Sheep"."Wool Producing"."Wool (t)"
/;

*the code below is slow due to the mathcing files with several dimensions. Thus use suitable subsets to make this matching faster: Set ProducingAnimals(AnimalTypeInHerd)


*CORRECT SOME ERRORS:
*for Austria, the numbers for Turkey are strange. we use "meat indigenous, turkey" which shows strange  and too high numbers from 2000 onwards, thus use meat, turkey, which looks better:
*hence replace before doing the following assignments:

FAOSTAT_LivestockPrimaryProduction("Austria","Meat indigenous, turkey","Production",years,"1000 head")
         = FAOSTAT_LivestockPrimaryProduction("Austria","Meat, turkey","Producing Animals/Slaughtered",Years,"1000 head");
FAOSTAT_LivestockPrimaryProduction("Austria","Meat indigenous, turkey","Production",years,"tonnes")
         = FAOSTAT_LivestockPrimaryProduction("Austria","Meat, turkey","Production",years,"tonnes");
FAOSTAT_LivestockPrimaryProduction("Austria","Meat indigenous, turkey","Yield/Carcass Weight",years,"0.1g/An")
         = FAOSTAT_LivestockPrimaryProduction("Austria","Meat, turkey","Yield/Carcass Weight",years,"0.1g/An");




*3.2) Link to the core model parameters
*output quantities:

VActAnimalsHead_Outputs.l(Regions,Livestock,ProducingAnimals,OutputsAnimals,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(MatchFAOSTATLivestockPrimary_ActivitiesYield(FAOSTAT_LivestockPrimaryItems,Livestock,ProducingAnimals,OutputsAnimals)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                  FAOSTAT_LivestockPrimaryProduction(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","tonnes"));

*do honey and wax separately, as it is done via APUs not via Heads:
VActAnimalsAPU_Outputs.l(Regions,"Beehives","Honey Producing","Honey (t)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                  FAOSTAT_LivestockPrimaryProduction(FAOSTAT_Countries,"Honey, natural","Production","AverageBasisYear","tonnes"));


VActAnimalsAPU_Outputs.l(Regions,"Beehives","Wax Producing","Wax (t)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                  FAOSTAT_LivestockPrimaryProduction(FAOSTAT_Countries,"Beeswax","Production","AverageBasisYear","tonnes"));


*and drop the assignments to heads as bees are with APUs only:
VActAnimalsHead_Outputs.l(Regions,"Beehives","Honey Producing","Honey (t)","AllProdSyst","AllProdCond") = 0;
VActAnimalsHead_Outputs.l(Regions,"Beehives","Wax Producing","Wax (t)","AllProdSyst","AllProdCond") = 0;


*Living animals:
VActAnimalsHead_QuantityActUnits.l(Regions,Activities,"Living","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LiveAnimalsItems,FAOSTAT_Countries)$(MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                  FAOSTAT_LivingAnimals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,"Stocks","AverageBasisYear","Head"));

*some are in the unit "1000 head" - do them separately:
*the condition is necessary to avoid that this assignment overwrites the assignments from above
*factor 1000 to have single heads
VActAnimalsHead_QuantityActUnits.l(Regions,Activities,"Living","AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,Activities,"Living","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LiveAnimalsItems,FAOSTAT_Countries)$(MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                  FAOSTAT_LivingAnimals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,"Stocks","AverageBasisYear","1000 Head"))*1000;

*separately for beehives, captured via APUs not heads:
VActAnimalsAPU_QuantityActUnits.l(Regions,"Beehives","AllAndAverageTypes","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 FAOSTAT_LivingAnimals(FAOSTAT_Countries,"Beehives","Stocks","AverageBasisYear","No"));

*producing animals:
VActAnimalsHead_QuantityActUnits.l(Regions,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(Match_LivestockPrimaryItems_ProducingAnimalsOutputs(FAOSTAT_LivestockPrimaryItems,Activities,AnimalTypeInHerd)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                  FAOSTAT_LivestockPrimaryProduction(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","Head"));

*some are in the unit "1000 head" - do them separately:
*the NOT-condition is to avoid that this overwrites the assignments from just above
*factor 1000 to have single heads
VActAnimalsHead_QuantityActUnits.l(Regions,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(Match_LivestockPrimaryItems_ProducingAnimalsOutputs(FAOSTAT_LivestockPrimaryItems,Activities,AnimalTypeInHerd)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                  FAOSTAT_LivestockPrimaryProduction(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems,"Production","AverageBasisYear","1000 Head"))*1000;

*milk is coded separately:
VActAnimalsHead_QuantityActUnits.l(Regions,Activities,"Milk Producing","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(Match_LivestockPrimaryItems_ProducingAnimalsOutputs(FAOSTAT_LivestockPrimaryItems,Activities,"Milk Producing")
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                  FAOSTAT_LivestockPrimaryProduction(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems,"Milk Animals","AverageBasisYear","Head"));

*some are in the unit "1000 head" - do them separately:
*factor 1000 to have single heads
VActAnimalsHead_QuantityActUnits.l(Regions,Activities,"Egg Producing","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(Match_LivestockPrimaryItems_ProducingAnimalsOutputs(FAOSTAT_LivestockPrimaryItems,Activities,"Egg Producing")
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                  FAOSTAT_LivestockPrimaryProduction(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems,"Laying","AverageBasisYear","1000 Head"))*1000;

*some data on producing animal numbers is captured in "Producing Animals/Slaughtered" instead of "Production" - file in as well:
VActAnimalsHead_QuantityActUnits.l(Regions,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
*the condition is necessary to avoid that this assignment overwrites the assignments from above
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(Match_LivestockPrimaryItems_ProducingAnimalsOutputs(FAOSTAT_LivestockPrimaryItems,Activities,AnimalTypeInHerd)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                  FAOSTAT_LivestockPrimaryProduction(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems,"Producing Animals/Slaughtered","AverageBasisYear","Head"));

*assign yield data to the model parameters:
*division by 10000 to transform hg/animal yields into tonnes/animal
*delivers all yield data, also for honey, as this has been derived above in section 2
ActAnimalsHead_Outputs(Regions,Livestock,ProducingAnimals,OutputsAnimals,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(MatchFAOSTATLivestockPrimary_ActivitiesYield(FAOSTAT_LivestockPrimaryItems,Livestock,ProducingAnimals,OutputsAnimals)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                  FAOSTAT_LivestockPrimaryProduction(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems,"Yield","AverageBasisYear","hg/An"))/10000;


*assign honey and wax yields to APU parameter, as all with beehives should relate to APUs, not to heads.
ActAnimalsAPU_Outputs(Regions,"Beehives","Honey Producing","Honey (t)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_Outputs(Regions,"Beehives","Honey Producing","Honey (t)","AllProdSyst","AllProdCond");
ActAnimalsAPU_Outputs(Regions,"Beehives","Wax Producing","Wax (t)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_Outputs(Regions,"Beehives","Wax Producing","Wax (t)","AllProdSyst","AllProdCond");
*and drop the values relating to heads:
ActAnimalsHead_Outputs(Regions,"Beehives","Honey Producing","Honey (t)","AllProdSyst","AllProdCond") = 0;
ActAnimalsHead_Outputs(Regions,"Beehives","Wax Producing","Wax (t)","AllProdSyst","AllProdCond") = 0;


*where possible, assign values for goats and buffaloes based on values for sheep and goats, cattle and buffaloe combined and sheep and cattle separately:
VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living","AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living","AllProdSyst","AllProdCond"))
         = VActAnimalsHead_QuantityActUnits.l(Regions,"Sheep and Goats","Living","AllProdSyst","AllProdCond")
                 - VActAnimalsHead_QuantityActUnits.l(Regions,"Sheep","Living","AllProdSyst","AllProdCond");
*and set the combined equal to zero:
VActAnimalsHead_QuantityActUnits.l(Regions,"Sheep and Goats","Living","AllProdSyst","AllProdCond") = 0;
*if this results in negative goat numbers, set those equal zero as well:
VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living","AllProdSyst","AllProdCond")
                 $(VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living","AllProdSyst","AllProdCond") < 0)
         = 0;

VActAnimalsHead_QuantityActUnits.l(Regions,"Buffaloes","Living","AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Buffaloes","Living","AllProdSyst","AllProdCond"))
         = VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle and Buffaloes","Living","AllProdSyst","AllProdCond")
                 - VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living","AllProdSyst","AllProdCond");
*and set the combined equal to zero:
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle and Buffaloes","Living","AllProdSyst","AllProdCond") = 0;
*if this results in negative goat numbers, set those equal zero as well:
VActAnimalsHead_QuantityActUnits.l(Regions,"Buffaloes","Living","AllProdSyst","AllProdCond")
                 $(VActAnimalsHead_QuantityActUnits.l(Regions,"Buffaloes","Living","AllProdSyst","AllProdCond") < 0)
         = 0;

*and drop "poultry birds" as those are a sum of chickens, ducks, etc.
VActAnimalsHead_QuantityActUnits.l(Regions,"Poultry birds","Living","AllProdSyst","AllProdCond") = 0;


execute_unload "FAOSTAT_Livestock"
VActAnimalsHead_Outputs
VActAnimalsHead_QuantityActUnits
VActAnimalsAPU_Outputs
VActAnimalsAPU_QuantityActUnits
ActAnimalsHead_Outputs
ActAnimalsAPU_Outputs

FAOSTAT_LivestockPrimaryProduction
;

$goto EndOfFile_Livestock

$label UseOldLivestockFile

*the following has to be defined here, as otherwise, it is only defined above in case the code is run - but referring to this old file, the code is not run, hence the need to define it here, as it is then read from the gdx-file.
Parameter FAOSTAT_LivestockPrimaryProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems,FAOSTAT_LivestockProductionElements,Years,FAOSTAT_LivestockProductionUnits);

$gdxin FAOSTAT_Livestock.gdx
$load VActAnimalsHead_Outputs
$load VActAnimalsHead_QuantityActUnits
$load VActAnimalsAPU_Outputs
$load VActAnimalsAPU_QuantityActUnits
$load ActAnimalsHead_Outputs
$load ActAnimalsAPU_Outputs
*the following is needed in _V6_ReadData_VariousSources_AnimalNutrientRequirementsData.gdx
$load FAOSTAT_LivestockPrimaryProduction
$gdxin


$label EndOfFile_Livestock

$ontext;
After this we have the following in SOLm-entities:

VActAnimalsHead_Outputs.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond")
VActAnimalsHead_QuantityActUnits.l(Regions,Activities,"Living","AllProdSyst","AllProdCond")
VActAnimalsAPU_Outputs.l(Regions,"Beehives",AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond")
VActAnimalsAPU_QuantityActUnits.l(Regions,"Beehives",AnimalTypeInHerd,"AllProdSyst","AllProdCond")
ActAnimalsHead_Outputs(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond")
ActAnimalsAPU_Outputs(Regions,"Beehives",AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Activities        is      FAOSTAT_LiveAnimalsItems
AnimalTypeInHerd  is      Living and: milk, meat, eggs, offals, hides, skins, wool, honey, wax Producing
OutputsAnimals    is      milk, meat, eggs, offals, hides, skins, wool, honey, wax yields per animal (or, for beehives: per APU); and total production of the same

*XXX STILL TO BE DONE:

*Assign:
*FAOSTAT_LivestockProcessed(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockProcessedItems,"Production","AverageBasisYear","tonnes")
         this mainly covers various milk products, some meat/fat products
$offtext;

