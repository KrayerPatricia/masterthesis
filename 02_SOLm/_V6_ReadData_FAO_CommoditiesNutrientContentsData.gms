PUTCLOSE con,"_V6_ReadData_FAO_CommoditiesNutrientContentsData";

$ontext;
GENERAL DESCRIPTION
This file reads the nutrient contents data as provided by FAO in http://www.fao.org/economic/the-statistics-division-ess/publications-studies/publications/nutritive-factors/en/
It contains calorie, protein and fat values per unit commodity

DETAILED TABLE OF CONTENTS
- 1) FAO nutrient contents data
- 2) Assign values to core model parameters and variables
- 3) Derive some additional values for complex commodities such as "Wheat and products"
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) FAO nutrient contents data

*Units: kcal per 100g; protein g per kg; fat g per kg

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewFAONutrientContentsData% == "YES"
$call GDXXRW NutritiveFactors_CommoditySetCorrespondences.xlsx  o=NutritiveFactors_CommoditySetCorrespondences.gdx  index=index!a1
$endif;

SET FAO_Nutrients
/
"Calories (kcal per 100g)"
"Protein (g per kg)"
"Fat (g per kg)"
/;

Parameter FAO_NutrientContents(Commodities,FAO_Nutrients);

$gdxin NutritiveFactors_CommoditySetCorrespondences.gdx
$load FAO_NutrientContents
$gdxin

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Assign values to core model parameters and variables

*the factors *10000 and /1000 are for converting in tho the correct units (*10000 for kcal/100g to kcal/ton; /1000 for g/kg to kg/kg=t/t)

Commod_Contents(Countries,Commodities,"Calories (kcal)","AllProdSyst","AllProdCond")
         = FAO_NutrientContents(Commodities,"Calories (kcal per 100g)")*10000;
Commod_Contents(Countries,Commodities,"Protein (t)","AllProdSyst","AllProdCond")
         = FAO_NutrientContents(Commodities,"Protein (g per kg)")/1000;
Commod_Contents(Countries,Commodities,"Fat (t)","AllProdSyst","AllProdCond")
         = FAO_NutrientContents(Commodities,"Fat (g per kg)")/1000;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Derive some additional values for complex commodities such as "Wheat and products"
*Here, the contents is not equal to the contents of wheat grains as can be seen when relating the per capita/day quantities and kcal for these commodities.
*thus derive these contents from the FAOSTAT per cap/day gram and kcal, g Protein, g Fate values:
*        kcal/t = kcal/cap/day / g/cap/day * 1000*1000; t Protein/t = g Protein/cap/day / g/cap/day; t Fat/t = g Fat/cap/day / g/cap/day.
*and then replace the values filed in above with the values derived here for these specific commodities.
*all the needed data has already been read and is available in the following parameters:

FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Protein contents (t/t)",Years,"t Protein/t")
                 $FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day")
         = FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Protein supply quantity (g/capita/day)",Years,"g/capita/day")
                 /FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day");

FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Fat contents (t/t)",Years,"t Fat/t")
                 $FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day")
         = FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Fat supply quantity (g/capita/day)",Years,"g/capita/day")
                 /FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day");

FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"kcal contents (kcal/t)",Years,"kcal/t")
                 $FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day")
         = FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply (kcal/capita/day)",Years,"kcal/capita/day")
                 /FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day")*1000000;


FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Protein contents (t/t)",Years,"t Protein/t")
                 $FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day")
         = FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Protein supply quantity (g/capita/day)",Years,"g/capita/day")
                 /FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day");

FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Fat contents (t/t)",Years,"t Fat/t")
                 $FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day")
         = FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Fat supply quantity (g/capita/day)",Years,"g/capita/day")
                 /FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day");

FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"kcal contents (kcal/t)",Years,"kcal/t")
                 $FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day")
         = FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply (kcal/capita/day)",Years,"kcal/capita/day")
                 /FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (g/capita/day)",Years,"g/capita/day")*1000000;

*derive the total nutrient supply, to then afterwards derive the Baseline contents:
FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Protein supply (t)",Years,"t Protein")
         = FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Protein contents (t/t)",Years,"t Protein/t")
                 *FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");
FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Fat supply (t)",Years,"t Fat")
         = FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Fat contents (t/t)",Years,"t Fat/t")
                 *FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");
FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"kcal supply (kcal)",Years,"kcal")
         = FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"kcal contents (kcal/t)",Years,"kcal/t")
                 *FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");

FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Protein supply (t)",Years,"t Protein")
         = FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Protein contents (t/t)",Years,"t Protein/t")
                 *FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");
FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Fat supply (t)",Years,"t Fat")
         = FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Fat contents (t/t)",Years,"t Fat/t")
                 *FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");
FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"kcal supply (kcal)",Years,"kcal")
         = FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"kcal contents (kcal/t)",Years,"kcal/t")
                 *FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");

*now take the averages over the basis years:
PARAMETER NumberOfBasisYearsFAOSTATFoodSupplyTotals_Crops;
PARAMETER NumberOfBasisYearsFAOSTATFoodSupplyTotals_LivestockFish;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....

Set FAOSTAT_CommodityBalancesElements_FoodSupplyTotals(FAOSTAT_CommodityBalancesElements)
/
"Protein supply (t)"
"Fat supply (t)"
"kcal supply (kcal)"
/;

Set FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals(FAOSTAT_CommodityBalancesUnits)
/
"t Protein"
"t Fat"
"kcal"
/;

NumberOfBasisYearsFAOSTATFoodSupplyTotals_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals)
         = SUM(BasisYears$FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,BasisYears,FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals),1);
NumberOfBasisYearsFAOSTATFoodSupplyTotals_LivestockFish(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals)
         = SUM(BasisYears$FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,BasisYears,FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals),1);

FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals)
                 $NumberOfBasisYearsFAOSTATFoodSupplyTotals_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals)
         = SUM(BasisYears,FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,BasisYears,FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals))
                 /NumberOfBasisYearsFAOSTATFoodSupplyTotals_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals);
FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals)
                 $NumberOfBasisYearsFAOSTATFoodSupplyTotals_LivestockFish(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals)
         = SUM(BasisYears,FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,BasisYears,FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals))
                 /NumberOfBasisYearsFAOSTATFoodSupplyTotals_LivestockFish(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_FoodSupplyTotals,FAOSTAT_CommodityBalancesUnits_FoodSupplyTotals);

FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,"AverageBasisYear",FAOSTAT_CropProductionUnits)
                 $NumberOfBasisYearsFAOSTATCropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,FAOSTAT_CropProductionUnits)
         = SUM(BasisYears,FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,BasisYears,FAOSTAT_CropProductionUnits))
                 /NumberOfBasisYearsFAOSTATCropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,FAOSTAT_CropProductionUnits);

*and derive the nutrient contents for the AverageBasisYear
FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Protein contents (t/t)",Years,"t Protein/t")
                 $FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes")
         = FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Protein supply (t)",Years,"t Protein")
                 /FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");

FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Fat contents (t/t)",Years,"t Fat/t")
                 $FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes")
         = FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Fat supply (t)",Years,"t Fat")
                 /FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");

FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"kcal contents (kcal/t)",Years,"kcal/t")
                 $FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes")
         = FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"kcal supply (kcal)",Years,"kcal")
                 /FAOSTAT_CropFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_CropCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");


FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Protein contents (t/t)",Years,"t Protein/t")
                 $FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes")
         = FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Protein supply (t)",Years,"t Protein")
                 /FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");

FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Fat contents (t/t)",Years,"t Fat/t")
                 $FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes")
         = FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Fat supply (t)",Years,"t Fat")
                 /FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");

FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"kcal contents (kcal/t)",Years,"kcal/t")
                 $FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes")
         = FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"kcal supply (kcal)",Years,"kcal")
                 /FAOSTAT_LivestockFishFoodSupply(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockFishCommodityBalancesItems,"Food supply quantity (tonnes)",Years,"tonnes");

*define a new parameter to not overwrite already existing values that you want to retain:
PARAMETER AUXCommod_Contents(Regions,Commodities,Contents,ProductionSystems,ProductionConditions);

AUXCommod_Contents(Regions,Commodities,"Protein (t)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                          FAOSTAT_CropFoodSupply(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Protein contents (t/t)","AverageBasisYear","t Protein/t"));
AUXCommod_Contents(Regions,Commodities,"Fat (t)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                          FAOSTAT_CropFoodSupply(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Fat contents (t/t)","AverageBasisYear","t Fat/t"));
AUXCommod_Contents(Regions,Commodities,"Calories (kcal)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_CropCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatCropCommodities_SOLmCommodities(FAOSTAT_CropCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                          FAOSTAT_CropFoodSupply(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"kcal contents (kcal/t)","AverageBasisYear","kcal/t"));

AUXCommod_Contents(Regions,Commodities,"Protein (t)","AllProdSyst","AllProdCond")
*the condition is needed to not overwrite the values already assigned above:
                 $(NOT AUXCommod_Contents(Regions,Commodities,"Protein (t)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                          FAOSTAT_LivestockFishFoodSupply(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Protein contents (t/t)","AverageBasisYear","t Protein/t"));
AUXCommod_Contents(Regions,Commodities,"Fat (t)","AllProdSyst","AllProdCond")
*the condition is needed to not overwrite the values already assigned above:
                 $(NOT AUXCommod_Contents(Regions,Commodities,"Fat (t)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                          FAOSTAT_LivestockFishFoodSupply(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"Fat contents (t/t)","AverageBasisYear","t Fat/t"));
AUXCommod_Contents(Regions,Commodities,"Calories (kcal)","AllProdSyst","AllProdCond")
*the condition is needed to not overwrite the values already assigned above:
                 $(NOT AUXCommod_Contents(Regions,Commodities,"Calories (kcal)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_Countries)$(MatchFaostatLivestockCommodities_SOLmLivestockCommodities(FAOSTAT_LivestockFishCommodityBalancesItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                          FAOSTAT_LivestockFishFoodSupply(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,"kcal contents (kcal/t)","AverageBasisYear","kcal/t"));

*for the following products, we replace the contents values:

Set Commodities_ReplaceFoodContentsValues(Commodities)
/
"Apples and products"
"Barley and products"
"Cassava and products"
"Cocoa Beans and products"
"Coffee and products"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Lemons, Limes and products"
"Maize and products"
"Millet and products"
"Nuts and products"
"Pineapples and products"
"Potatoes and products"
"Pulses, Other and products"
"Rye and products"
"Sorghum and products"
"Tomatoes and products"
"Wheat and products"
/;

Commod_Contents(Regions,Commodities_ReplaceFoodContentsValues,"Protein (t)","AllProdSyst","AllProdCond")
      = AUXCommod_Contents(Regions,Commodities_ReplaceFoodContentsValues,"Protein (t)","AllProdSyst","AllProdCond");
Commod_Contents(Regions,Commodities_ReplaceFoodContentsValues,"Fat (t)","AllProdSyst","AllProdCond")
      = AUXCommod_Contents(Regions,Commodities_ReplaceFoodContentsValues,"Fat (t)","AllProdSyst","AllProdCond");
Commod_Contents(Regions,Commodities_ReplaceFoodContentsValues,"Calories (kcal)","AllProdSyst","AllProdCond")
      = AUXCommod_Contents(Regions,Commodities_ReplaceFoodContentsValues,"Calories (kcal)","AllProdSyst","AllProdCond");



$ontext;
After this we have the following in SOLm-entities:

Commod_Contents(Countries,Commodities,Contents,"AllProdSyst","AllProdCond")
Regions           is      FAOSTAT_Countries
Commodities       is      Commodities (only those used for food)

Contents          is      "Calories (kcal)", "Protein (t)", "Fat (t)" contents per ton fresh matter

$offtext;

