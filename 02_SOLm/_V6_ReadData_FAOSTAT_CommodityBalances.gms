PUTCLOSE con,"_V6_ReadData_FAOSTAT_CommodityBalances";

$ontext;
GENERAL DESCRIPTION
This file reads the commodity balances data

DETAILED TABLE OF CONTENTS
- 1) reading the csv-files and loading the parameters
- 2) build average over the base year period chosen to get the baseline values
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) reading the csv-files and loading the parameters

*read csv files from FAOSTAT into gdx if something has changed - else directly load the gdx files, later on in the code

$ifthen %ReadNewFAOSTATCommodityBalanceData% == "YES"
$call csv2gdx FAOSTAT_CropCommodityBalancesNormalized_4_12_2017.csv id=FAOSTAT_CropCommodityBalances Index=(2,4,6,8,9) Values=(10) UseHeader=Y
$call csv2gdx FAOSTAT_LivestockFishCommodityBalancesNormalized_4_12_2017.csv id=FAOSTAT_LivestockFishCommodityBalances Index=(2,4,6,8,9) Values=(10) UseHeader=Y
$call csv2gdx FAOSTAT_CropsFoodSupplyNormalized_4_12_2017.csv id=FAOSTAT_CropFoodSupply Index=(2,4,6,8,9) Values=(10) UseHeader=Y
$call csv2gdx FAOSTAT_LivestockFishFoodSupplyNormalized_4_12_2017.csv id=FAOSTAT_LivestockFishFoodSupply Index=(2,4,6,8,9) Values=(10) UseHeader=Y
$endif;

Parameter FAOSTAT_CropCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements,Years,FAOSTAT_CommodityBalancesUnits);
Parameter FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements,Years,FAOSTAT_CommodityBalancesUnits);
Parameter FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements,Years,FAOSTAT_CommodityBalancesUnits);
Parameter FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements,Years,FAOSTAT_CommodityBalancesUnits);

$gdxin FAOSTAT_CropCommodityBalancesNormalized_4_12_2017.gdx
$load FAOSTAT_CropCommodityBalances
$gdxin
$gdxin FAOSTAT_LivestockFishCommodityBalancesNormalized_4_12_2017.gdx
$load FAOSTAT_LivestockFishCommodityBalances
$gdxin
$gdxin FAOSTAT_CropsFoodSupplyNormalized_4_12_2017.gdx
$load FAOSTAT_CropFoodSupply
$gdxin
$gdxin FAOSTAT_LivestockFishFoodSupplyNormalized_4_12_2017.gdx
$load FAOSTAT_LivestockFishFoodSupply
$gdxin


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) build average over the base year period chosen to get the baseline values

PARAMETER NumberOfBasisYearsFAOSTATCropCommodityBalances;
PARAMETER NumberOfBasisYearsFAOSTATLivestockFishCommodityBalances;
PARAMETER NumberOfBasisYearsFAOSTATCropFoodSupply;
PARAMETER NumberOfBasisYearsFAOSTATLivestockFishFoodSupply;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....

*to efficiently code this, the following subset is needed:
Set FAOSTAT_CommodityBalancesElements_NoPerCapitaElement(FAOSTAT_CommodityBalancesElements)
/
"Domestic supply quantity"
"Export Quantity"
"Feed"
"Food supply quantity (tonnes)"
"Import Quantity"
"Waste"
"Other uses"
"Processing"
"Production"
"Seed"
"Stock Variation"
/;


NumberOfBasisYearsFAOSTATCropCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits)
         = SUM(BasisYears$FAOSTAT_CropCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,BasisYears,FAOSTAT_CommodityBalancesUnits),1);
FAOSTAT_CropCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 $NumberOfBasisYearsFAOSTATCropCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits)
         = SUM(BasisYears,FAOSTAT_CropCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,BasisYears,FAOSTAT_CommodityBalancesUnits))
                 /NumberOfBasisYearsFAOSTATCropCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits);

NumberOfBasisYearsFAOSTATLivestockFishCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits)
         = SUM(BasisYears$FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,BasisYears,FAOSTAT_CommodityBalancesUnits),1);
FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 $NumberOfBasisYearsFAOSTATLivestockFishCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits)
         = SUM(BasisYears,FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,BasisYears,FAOSTAT_CommodityBalancesUnits))
                 /NumberOfBasisYearsFAOSTATLivestockFishCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits);

NumberOfBasisYearsFAOSTATCropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits)
         = SUM(BasisYears$FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,BasisYears,FAOSTAT_CommodityBalancesUnits),1);
FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 $NumberOfBasisYearsFAOSTATCropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits)
         = SUM(BasisYears,FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,BasisYears,FAOSTAT_CommodityBalancesUnits))
                 /NumberOfBasisYearsFAOSTATCropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits);

NumberOfBasisYearsFAOSTATLivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits)
         = SUM(BasisYears$FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,BasisYears,FAOSTAT_CommodityBalancesUnits),1);
FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 $NumberOfBasisYearsFAOSTATLivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits)
         = SUM(BasisYears,FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,BasisYears,FAOSTAT_CommodityBalancesUnits))
                 /NumberOfBasisYearsFAOSTATLivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,FAOSTAT_CommodityBalancesUnits);

*here, we get rid of the China subregions aready at the beginning - could be done in the previous modules identically as well:

FAOSTAT_CropCommodityBalances("China",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 $(NOT FAOSTAT_CropCommodityBalances("China",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits))
         = FAOSTAT_CropCommodityBalances("China, Hong Kong SAR",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_CropCommodityBalances("China, Macao SAR",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_CropCommodityBalances("China, mainland",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_CropCommodityBalances("China, Taiwan Province of",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits);

FAOSTAT_LivestockFishCommodityBalances("China",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 $(NOT FAOSTAT_LivestockFishCommodityBalances("China",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits))
         = FAOSTAT_LivestockFishCommodityBalances("China, Hong Kong SAR",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_LivestockFishCommodityBalances("China, Macao SAR",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_LivestockFishCommodityBalances("China, mainland",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_LivestockFishCommodityBalances("China, Taiwan Province of",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits);

FAOSTAT_CropFoodSupply("China",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 $(NOT FAOSTAT_CropFoodSupply("China",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits))
         = FAOSTAT_CropFoodSupply("China, Hong Kong SAR",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_CropFoodSupply("China, Macao SAR",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_CropFoodSupply("China, mainland",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_CropFoodSupply("China, Taiwan Province of",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits);

FAOSTAT_LivestockFishFoodSupply("China",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 $(NOT FAOSTAT_LivestockFishFoodSupply("China",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits))
         = FAOSTAT_LivestockFishFoodSupply("China, Hong Kong SAR",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_LivestockFishFoodSupply("China, Macao SAR",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_LivestockFishFoodSupply("China, mainland",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
                 + FAOSTAT_LivestockFishFoodSupply("China, Taiwan Province of",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits);


FAOSTAT_CropCommodityBalances("China, Hong Kong SAR",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_CropCommodityBalances("China, Macao SAR",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_CropCommodityBalances("China, mainland",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_CropCommodityBalances("China, Taiwan Province of",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;

FAOSTAT_LivestockFishCommodityBalances("China, Hong Kong SAR",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_LivestockFishCommodityBalances("China, Macao SAR",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_LivestockFishCommodityBalances("China, mainland",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_LivestockFishCommodityBalances("China, Taiwan Province of",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;

FAOSTAT_CropFoodSupply("China, Hong Kong SAR",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_CropFoodSupply("China, Macao SAR",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_CropFoodSupply("China, mainland",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_CropFoodSupply("China, Taiwan Province of",FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;

FAOSTAT_LivestockFishFoodSupply("China, Hong Kong SAR",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_LivestockFishFoodSupply("China, Macao SAR",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_LivestockFishFoodSupply("China, mainland",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;
FAOSTAT_LivestockFishFoodSupply("China, Taiwan Province of",FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits) = 0;




$ontext;
after this, we have:
Parameter FAOSTAT_CropCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements,Years,FAOSTAT_CommodityBalancesUnits);
Parameter FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements,Years,FAOSTAT_CommodityBalancesUnits);
Parameter FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements,Years,FAOSTAT_CommodityBalancesUnits);
Parameter FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements,Years,FAOSTAT_CommodityBalancesUnits);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

Set MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
/
"Animal fats"."Animal fats"
*"Animal Products"."Animal Products"
"Aquatic Animals, Others"."Aquatic Animals, Others"
"Aquatic Plants"."Aquatic Plants"
"Aquatic Products, Other"."Aquatic Products, Other"
"Bovine Meat"."Bovine Meat"
"Butter, Ghee"."Butter, Ghee"
"Cephalopods"."Cephalopods"
"Cheese"."Cheese"
"Cream"."Cream"
"Crustaceans"."Crustaceans"
"Demersal Fish"."Demersal Fish"
"Eggs"."Eggs"
"Fats, Animals, Raw"."Fats, Animals, Raw"
"Fish Meal"."Fish Meal"
"Fish, Body Oil"."Fish, Body Oil"
"Fish, Liver Oil"."Fish, Liver Oil"
"Fish, Seafood"."Fish, Seafood"
"Freshwater Fish"."Freshwater Fish"
*"Grand Total"."Grand Total"
"Hides and skins"."Hides and skins"
"Honey"."Honey"
"Marine Fish, Other"."Marine Fish, Other"
"Meat"."Meat"
"Meat Meal"."Meat Meal"
"Meat, Aquatic Mammals"."Meat, Aquatic Mammals"
"Meat, Other"."Meat, Other"
"Milk - Excluding Butter"."Milk - Excluding Butter"
"Milk, Skimmed"."Milk, Skimmed"
"Milk, Whole"."Milk, Whole"
"Molluscs, Other"."Molluscs, Other"
"Mutton & Goat Meat"."Mutton & Goat Meat"
"Offals"."Offals"
"Offals, Edible"."Offals, Edible"
"Pelagic Fish"."Pelagic Fish"
"Pigmeat"."Pigmeat"
"Poultry Meat"."Poultry Meat"
"Silk"."Silk"
"Whey"."Whey"
"Wool (Clean Eq.)"."Wool (Clean Eq.)"
/;

Set MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
/
"Abaca"."Abaca"
"Alcohol, Non-Food"."Alcohol, Non-Food"
"Alcoholic Beverages"."Alcoholic Beverages"
"Apples and products"."Apples and products"
"Bananas"."Bananas"
"Barley and products"."Barley and products"
"Beans"."Beans"
"Beer"."Beer"
"Beverages, Alcoholic"."Beverages, Alcoholic"
"Beverages, Fermented"."Beverages, Fermented"
"Brans"."Brans"
"Cassava and products"."Cassava and products"
"Cereals - Excluding Beer"."Cereals - Excluding Beer"
"Cereals, Other"."Cereals, Other"
"Citrus, Other"."Citrus, Other"
"Cloves"."Cloves"
"Cocoa Beans and products"."Cocoa Beans and products"
"Coconut Oil"."Coconut Oil"
"Coconuts - Incl Copra"."Coconuts - Incl Copra"
"Coffee and products"."Coffee and products"
"Copra Cake"."Copra Cake"
"Cotton lint"."Cotton lint"
"Cottonseed"."Cottonseed"
"Cottonseed Cake"."Cottonseed Cake"
"Cottonseed Oil"."Cottonseed Oil"
"Dates"."Dates"
"Fruits - Excluding Wine"."Fruits - Excluding Wine"
"Fruits, Other"."Fruits, Other"
"Grand Total"."Grand Total"
"Grapefruit and products"."Grapefruit and products"
"Grapes and products (excl wine)"."Grapes and products (excl wine)"
"Groundnut Cake"."Groundnut Cake"
"Groundnut Oil"."Groundnut Oil"
"Groundnuts (in Shell Eq)"."Groundnuts (in Shell Eq)"
"Groundnuts (Shelled Eq)"."Groundnuts (Shelled Eq)"
"Hard Fibres, Other"."Hard Fibres, Other"
"Infant food"."Infant food"
"Jute". "Jute"
"Jute-Like Fibres"."Jute-Like Fibres"
"Lemons, Limes and products"."Lemons, Limes and products"
"Maize and products"."Maize and products"
"Maize Germ Oil". "Maize Germ Oil"
"Millet and products"."Millet and products"
"Miscellaneous"."Miscellaneous"
"Molasses"."Molasses"
"Nuts and products"."Nuts and products"
"Oats"."Oats"
"Oilcrops"."Oilcrops"
"Oilcrops Oil, Other"."Oilcrops Oil, Other"
"Oilcrops, Other"."Oilcrops, Other"
"Oilseed Cakes, Other"."Oilseed Cakes, Other"
"Olive Oil"."Olive Oil"
"Olives (including preserved)"."Olives (including preserved)"
"Onions"."Onions"
"Oranges, Mandarines"."Oranges, Mandarines"
"Palm kernels"."Palm kernels"
"Palm Oil"."Palm Oil"
"Palmkernel Cake"."Palmkernel Cake"
"Palmkernel Oil"."Palmkernel Oil"
"Peas"."Peas"
"Pepper"."Pepper"
"Pimento"."Pimento"
"Pineapples and products"."Pineapples and products"
"Plantains"."Plantains"
"Potatoes and products"."Potatoes and products"
"Pulses"."Pulses"
"Pulses, Other and products"."Pulses, Other and products"
"Rape and Mustard Cake"."Rape and Mustard Cake"
"Rape and Mustard Oil"."Rape and Mustard Oil"
"Rape and Mustardseed"."Rape and Mustardseed"
"Rice (Milled Equivalent)"."Rice (Milled Equivalent)"
"Rice (Paddy Equivalent)"."Rice (Paddy Equivalent)"
"Ricebran Oil"."Ricebran Oil"
"Roots & Tuber Dry Equiv"."Roots & Tuber Dry Equiv"
"Roots, Other"."Roots, Other"
"Rubber"."Rubber"
"Rye and products"."Rye and products"
"Sesame seed"."Sesame seed"
"Sesameseed Cake"."Sesameseed Cake"
"Sesameseed Oil"."Sesameseed Oil"
"Sisal"."Sisal"
"Soft-Fibres, Other"."Soft-Fibres, Other"
"Sorghum and products"."Sorghum and products"
"Soyabean Cake"."Soyabean Cake"
"Soyabean Oil"."Soyabean Oil"
"Soyabeans"."Soyabeans"
"Spices"."Spices"
"Spices, Other"."Spices, Other"
"Starchy Roots"."Starchy Roots"
"Stimulants"."Stimulants"
"Sugar & Sweeteners"."Sugar & Sweeteners"
"Sugar (Raw Equivalent)"."Sugar (Raw Equivalent)"
"Sugar beet"."Sugar beet"
"Sugar cane"."Sugar cane"
"Sugar Crops"."Sugar Crops"
"Sugar non-centrifugal"."Sugar non-centrifugal"
"Sugar, Raw Equivalent"."Sugar, Raw Equivalent"
"Sugar, Refined Equiv"."Sugar, Refined Equiv"
"Sunflower seed"."Sunflower seed"
"Sunflowerseed Cake"."Sunflowerseed Cake"
"Sunflowerseed Oil"."Sunflowerseed Oil"
"Sweet potatoes"."Sweet potatoes"
"Sweeteners, Other"."Sweeteners, Other"
"Tea (including mate)"."Tea (including mate)"
"Tobacco"."Tobacco"
"Tobacco & Rubber"."Tobacco & Rubber"
"Tomatoes and products"."Tomatoes and products"
"Treenuts"."Treenuts"
"Vegetable Oils"."Vegetable Oils"
"Vegetables"."Vegetables"
"Vegetables, Other"."Vegetables, Other"
"Vegetal Products"."Vegetal Products"
"Wheat and products"."Wheat and products"
"Wine"."Wine"
"Yams"."Yams"
/;


*3.2) Link to the core model parameters
*here, we only asign part of it, not all that is covered in the set FAOSTAT_CommodityBalancesElements_NoPerCapitaElement (cf. above, where it is defined)

*below, the term with the conditional sums need to be BEFORE the terms without sum, otherwise those latter are overwritten by the first and thus set to zero

*all variables below are measured in tonnes

VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                          FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Domestic supply quantity","AverageBasisYear","tonnes"));
VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond")
*the condition is necessary to avoid that this assignment overwrites the assignments from above
                 $(NOT VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                          FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Domestic supply quantity","AverageBasisYear","tonnes"));

*the import/export quantities do not overwrite tradestat data already filed in, as the latter are on countr-country basis, while the data here is on country-world basis.
VImportQuantity.l(Regions,"World",Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                          FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Import Quantity","AverageBasisYear","tonnes"));
VImportQuantity.l(Regions,"World",Commodities,"AllProdSyst","AllProdCond")
*the condition is necessary to avoid that this assignment overwrites the assignments from above
                 $(NOT VImportQuantity.l(Regions,"World",Commodities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                          FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Import Quantity","AverageBasisYear","tonnes"));

VExportQuantity.l(Regions,"World",Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                          FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Export Quantity","AverageBasisYear","tonnes"));
VExportQuantity.l(Regions,"World",Commodities,"AllProdSyst","AllProdCond")
*the condition is necessary to avoid that this assignment overwrites the assignments from above
                 $(NOT VExportQuantity.l(Regions,"World",Commodities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Export Quantity","AverageBasisYear","tonnes"));

VCommod_StockChanges.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Stock Variation","AverageBasisYear","tonnes"));
VCommod_StockChanges.l(Regions,Commodities,"AllProdSyst","AllProdCond")
*the condition is necessary to avoid that this assignment overwrites the assignments from above
                 $(NOT VCommod_StockChanges.l(Regions,Commodities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Stock Variation","AverageBasisYear","tonnes"));

VCommod_Production.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Production","AverageBasisYear","tonnes"));
VCommod_Production.l(Regions,Commodities,"AllProdSyst","AllProdCond")
*the condition is necessary to avoid that this assignment overwrites the assignments from above
                 $(NOT VCommod_Production.l(Regions,Commodities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Production","AverageBasisYear","tonnes"));

VCommod_Feed.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Feed","AverageBasisYear","tonnes"));
VCommod_Feed.l(Regions,Commodities,"AllProdSyst","AllProdCond")
*the condition is necessary to avoid that this assignment overwrites the assignments from above
                 $(NOT VCommod_Feed.l(Regions,Commodities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Feed","AverageBasisYear","tonnes"));

VCommod_Seed.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Seed","AverageBasisYear","tonnes"));

VCommod_Food.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (tonnes)","AverageBasisYear","tonnes"));
VCommod_Food.l(Regions,Commodities,"AllProdSyst","AllProdCond")
*the condition is necessary to avoid that this assignment overwrites the assignments from above
                 $(NOT VCommod_Food.l(Regions,Commodities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (tonnes)","AverageBasisYear","tonnes"));

VCommod_Waste.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Waste","AverageBasisYear","tonnes"));
VCommod_Waste.l(Regions,Commodities,"AllProdSyst","AllProdCond")
*the condition is necessary to avoid that this assignment overwrites the assignments from above
                 $(NOT VCommod_Waste.l(Regions,Commodities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Waste","AverageBasisYear","tonnes"));

VCommod_Processing.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Processing","AverageBasisYear","tonnes"));
VCommod_Processing.l(Regions,Commodities,"AllProdSyst","AllProdCond")
*the condition is necessary to avoid that this assignment overwrites the assignments from above
                 $(NOT VCommod_Processing.l(Regions,Commodities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Processing","AverageBasisYear","tonnes"));

VCommod_Other.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_LivestockFishCommodityBalances(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Other uses","AverageBasisYear","tonnes"));
VCommod_Other.l(Regions,Commodities,"AllProdSyst","AllProdCond")
*the condition is necessary to avoid that this assignment overwrites the assignments from above
                 $(NOT VCommod_Other.l(Regions,Commodities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                         FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Other uses","AverageBasisYear","tonnes"));

*the above has one problem, that DAQ total partly does not report commodities that are in the subsets, e.g. processing - when working with utilization shares, this results in problems,
*as zero is derived in the scenarios with the util share (which is missing, due to division by 0), while the baseline is not, as it is reported in FAOSTAT.
*thus we do some recalculations.
*before this, we have to clean the commodity-file, though, as this includes aggregate commopdities that lead to double counting or other problems, as in the scenarios, we do not calculate the aggregates (or onyl at the end),
*but if they are present here, then they become part of the feed supply, for example, and disrupt results because of double counting, etc.
*thus, only retain values for Set CommoditiesDAQ_TradeFromToWorld(Commodities) (for explanations, see the excel-file NutrientFactors_CommoditySetCorrespondences
SET CommoditiesToBeDropped(Commodities);
CommoditiesToBeDropped(Commodities) = Not CommoditiesDAQ_TradeFromToWorld(Commodities);

VCommod_StockChanges.l(Regions,CommoditiesToBeDropped,"AllProdSyst","AllProdCond") = 0;
VCommod_Production.l(Regions,CommoditiesToBeDropped,"AllProdSyst","AllProdCond") = 0;
VCommod_Quantity.l(Regions,CommoditiesToBeDropped,"AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,CommoditiesToBeDropped,"AllProdSyst","AllProdCond") = 0;
VCommod_Seed.l(Regions,CommoditiesToBeDropped,"AllProdSyst","AllProdCond") = 0;
VCommod_Food.l(Regions,CommoditiesToBeDropped,"AllProdSyst","AllProdCond") = 0;
VCommod_Waste.l(Regions,CommoditiesToBeDropped,"AllProdSyst","AllProdCond") = 0;
VCommod_Processing.l(Regions,CommoditiesToBeDropped,"AllProdSyst","AllProdCond") = 0;
VCommod_Other.l(Regions,CommoditiesToBeDropped,"AllProdSyst","AllProdCond") = 0;



*Thus, replace DAQ total by the sum of the parts:
VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = VCommod_Feed.l(Regions,Commodities,"AllProdSyst","AllProdCond")
                 + VCommod_Seed.l(Regions,Commodities,"AllProdSyst","AllProdCond")
                 + VCommod_Food.l(Regions,Commodities,"AllProdSyst","AllProdCond")
                 + VCommod_Waste.l(Regions,Commodities,"AllProdSyst","AllProdCond")
                 + VCommod_Processing.l(Regions,Commodities,"AllProdSyst","AllProdCond")
                 + VCommod_Other.l(Regions,Commodities,"AllProdSyst","AllProdCond");

*to be fully consistent, recalculate the utilization shares now again:

Commod_OtherChar(Regions,Commodities,"Util food (share)","AllProdSyst","AllProdCond")
                 $VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = VCommod_Food.l(Regions,Commodities,"AllProdSyst","AllProdCond")
                 /VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond");
Commod_OtherChar(Regions,Commodities,"Util feed (share)","AllProdSyst","AllProdCond")
                 $VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = VCommod_Feed.l(Regions,Commodities,"AllProdSyst","AllProdCond")
                 /VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond");
Commod_OtherChar(Regions,Commodities,"Util seed (share)","AllProdSyst","AllProdCond")
                 $VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = VCommod_Seed.l(Regions,Commodities,"AllProdSyst","AllProdCond")
                 /VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond");
Commod_OtherChar(Regions,Commodities,"Util waste (share)","AllProdSyst","AllProdCond")
                 $VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = VCommod_Waste.l(Regions,Commodities,"AllProdSyst","AllProdCond")
                 /VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond");
Commod_OtherChar(Regions,Commodities,"Util other (share)","AllProdSyst","AllProdCond")
                 $VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = VCommod_Other.l(Regions,Commodities,"AllProdSyst","AllProdCond")
                 /VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond");
Commod_OtherChar(Regions,Commodities,"Util processing (share)","AllProdSyst","AllProdCond")
                 $VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond")
         = VCommod_Processing.l(Regions,Commodities,"AllProdSyst","AllProdCond")
                 /VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond");


*now add these values for Forage Crops as well:

SET MatchForageActCommod_BasicDataAssignment(Commodities,Activities)
/
"Maize For Forage+Silage"."Maize For Forage+Silage"
"Alfalfa For Forage+Silag"."Alfalfa For Forage+Silag"
"Clover For Forage+Silage"."Clover For Forage+Silage"
"Leguminous Nes,For+Sil"."Leguminous Nes,For+Sil"
"Forage Products Nes"."Forage Products Nes"

*other fodder crops
"Beets For Fodder"."Beets For Fodder"
"Swedes For Fodder"."Swedes For Fodder"
"Turnips For Fodder"."Turnips For Fodder"
"Vegetables+Roots,Fodder"."Vegetables+Roots,Fodder"

*additionally added from FAOSTAT ForageCrop data, items that do not fit to one from the above:
"Cabbage, for forage"."Cabbage, for forage"
"Carrots, for forage"."Carrots, for forage"
"Other grasses, for forage"."Other grasses, for forage"
"Other oilseeds, for forage"."Other oilseeds, for forage"
"Rye grass, for forage"."Rye grass, for forage"
"Sorghum, for forage"."Sorghum, for forage"
/;

VCommod_Quantity.l(Regions,ForageCommodities,"AllProdSyst","AllProdCond")
         = sum(Activities$MatchForageActCommod_BasicDataAssignment(ForageCommodities,Activities),
                 VActCropsGrass_Outputs.l(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond"));

*NO DATA AVAILABLE - but also not much trade: VImportQuantity
*NO DATA AVAILABLE - but also not much trade: VExportQuantity
*NO DATA AVAILABLE VCommod_StockChanges

VCommod_Production.l(Regions,ForageCommodities,"AllProdSyst","AllProdCond")
         = VCommod_Quantity.l(Regions,ForageCommodities,"AllProdSyst","AllProdCond");
VCommod_Feed.l(Regions,ForageCommodities,"AllProdSyst","AllProdCond")
         = VCommod_Quantity.l(Regions,ForageCommodities,"AllProdSyst","AllProdCond");

*not needed - derived from per ha values VCommod_Seed
*equals zero VCommod_Food
*NO DATA AVAILABLE VCommod_Waste
*NO DATA AVAILABLE VCommod_Processing
*NO DATA AVAILABLE VCommod_Other

Commod_OtherChar(Regions,ForageCommodities,"Util feed (share)","AllProdSyst","AllProdCond")
                 $VCommod_Quantity.l(Regions,ForageCommodities,"AllProdSyst","AllProdCond")
         = 1;

$ontext;
*some further corrections on feed:

NOT NEEDED ANYMORE - ACCOUNTED FOR BY THE ABOVE CODE ON THE Set CommoditiesToBeDropped

*'Vegetables, Other' has the same feed quantity values as "Vegetables" - thus drop:
VCommod_Feed.l(Regions,"Vegetables, Other","AllProdSyst","AllProdCond") = 0;

*'Rice (Milled Equivalent)' is the same as 'Rice (Paddy Equivalent)' times the conversion factor, thus drop
VCommod_Feed.l(Regions,"Rice (Milled Equivalent)","AllProdSyst","AllProdCond") = 0;

*for feed, "Sugar Crops" is the sum of sugar cane and sugar beet - thus drop the quantities
VCommod_Feed.l(Regions,"Sugar Crops","AllProdSyst","AllProdCond") = 0;

*Offals, edible is the same as offals for feed quantities, thus drop the former:
VCommod_Feed.l(Regions,"Offals, edible","AllProdSyst","AllProdCond") = 0;

*the following are unimportant, thus set to zero:
VCommod_Feed.l(Regions,"Groundnuts (in Shell Eq)","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Groundnuts (Shelled Eq)","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Spices","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Stimulants","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Cheese","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Butter, Ghee","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Olive Oil","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Olives (including preserved)","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Soyabean Oil","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Palm Oil","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Sesameseed Oil","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Mutton & Goat Meat","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Oilcrops Oil, Other","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Sweeteners, Other","AllProdSyst","AllProdCond") = 0;

*Sugar non-centrifugal is the same as Sugar, Raw Equivalent, where there are values for the former, thus drop
VCommod_Feed.l(Regions,"Sugar non-centrifugal","AllProdSyst","AllProdCond") = 0;

*"Aquatic Plants" and "Aquatic Products, Other" are only reported for Japan and Norway and are the same, but not too unimportant. Thus set the former = 0.
VCommod_Feed.l(Regions,"Aquatic Products, Other","AllProdSyst","AllProdCond") = 0;

*Fish, Seafood is the aggregate of all fish and seafood, thus drop
VCommod_Feed.l(Regions,"Fish, Seafood","AllProdSyst","AllProdCond") = 0;
*the following four are also aggregates of others:
VCommod_Feed.l(Regions,"Roots & Tuber Dry Equiv","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Starchy roots","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Cereals - excluding beer","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Fruits - excluding wine","AllProdSyst","AllProdCond") = 0;
*in most cases, oilcrops seems to be the sum of the various oilcrops, thus drop
VCommod_Feed.l(Regions,"Oilcrops","AllProdSyst","AllProdCond") = 0;


*Onions are only somewhat not unimportant in Kazhakstan, thus drop
VCommod_Feed.l(Regions,"Onions","AllProdSyst","AllProdCond") = 0;

*only somewhat not unimportant in Spain - thus drop:
VCommod_Feed.l(Regions,"Tomatoes and products","AllProdSyst","AllProdCond") = 0;

*Milk - Excluding Butter is the sum of skimmed and whole milk, more or less, thus drop it
VCommod_Feed.l(Regions,"Milk - Excluding Butter","AllProdSyst","AllProdCond") = 0;


*the following four arre usually the same, sometimes only the first and third are available - and equal, - thus we retaiin the third only:
*Sugar & Sweeteners
*Sugar (Raw Equivalent)
*Sugar, Raw Equivalent
*Sugar, Refined Equiv
VCommod_Feed.l(Regions,"Sugar & Sweeteners","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Sugar (Raw Equivalent)","AllProdSyst","AllProdCond") = 0;
VCommod_Feed.l(Regions,"Sugar, Refined Equiv","AllProdSyst","AllProdCond") = 0;

$offtext;


$ontext;
After this we have the following in SOLm-entities:

VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VImportQuantity.l(Regions,"World",Commodities,"AllProdSyst","AllProdCond")
VExportQuantity.l(Regions,"World",Commodities,"AllProdSyst","AllProdCond")
VCommod_StockChanges.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Production.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Feed.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Seed.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Food.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Waste.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Processing.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Other.l(Regions,Commodities,"AllProdSyst","AllProdCond")

Commod_OtherChar(Regions,Commodities,"Util food (share)","AllProdSyst","AllProdCond")
Commod_OtherChar(Regions,Commodities,"Util feed (share)","AllProdSyst","AllProdCond")
Commod_OtherChar(Regions,Commodities,"Util seed (share)","AllProdSyst","AllProdCond")
Commod_OtherChar(Regions,Commodities,"Util waste (share)","AllProdSyst","AllProdCond")
Commod_OtherChar(Regions,Commodities,"Util other (share)","AllProdSyst","AllProdCond")
Commod_OtherChar(Regions,Commodities,"Util processing (share)","AllProdSyst","AllProdCond")

Commodities      is      FAOSTAT_LivestockFishCommodityBalancesItems
                         FAOSTAT_CropCommodityBalancesItems
                         ForageCommodities
Regions          is      FAOSTAT_Countries

*XXX STILL TO BE DONE:

Not assigned here as partly already taken from FAOSTAT_CropProduction data:
SeedQuantitySOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,OutputTypeSOLmV5,"AverageProdType","All","Baseline");
         = FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Seed","AverageBasisYear","tonnes")
BUT: check whether it is identical fro crops and add values for animals (and find out what they stand for - e.g. eggs: used to breed new animals?)

not yet assigned to SOLmV5 parameters are the following, containing per capita nutritional supply values
FAOSTAT_CropFoodSupply(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
FAOSTAT_LivestockFishFoodSupply(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
$offtext;










