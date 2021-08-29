PUTCLOSE con,"__SOLmV5_ReadData_FAOSTAT_WOSY_DetailedFBS";
$setglobal ModuleLabel "SOLmV5_ReadData_FAOSTAT_WOSY_DetailedFBS"

*GENERAL DESCRIPTION
*This file reads the detailed FBS data from the working system WOSY from FAOSTAT


*ATTENTION!!!! THIS IS CURRENTLY NOT DONE FROM SCRATCH - i.e. csv, but from the already existing gdx-file only.
*FROM STRACTCH: to be done later


*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Defining and loading the parameters
- 2) Some adaptions of units, etc.
         2.1) Yield type of live Animals
         2.2) Derive DAQ
         2.3) Change WOSY units for animal production
         2.4) Derive nutrient contents
         2.5) Derive utilization shares
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Defining and loading the parameters


*if no new WOSY data has been processed in R and thus needs to be read in, just take what is already available
*this is loaded from the output of having executed the above code already earlier; therefore, in this module, no new data may be added; if so, then add it in 02_8_LoadParameters, where WOSY is filed in.
*the following are always total available quantities of the characteristics as indicated in the parameter name (WOSY_FeedGE_Byp(..."Wheat"...) is total FeedGE from wheat byproducts available in the country;
*                WOSY_FoodCal(..."Wheat"...) is total food calories from wheat available in the country - this implicitly accounts for processing and extraction rates, etc. - thus, it is calories from white flour, etc.
*                nutrient contents derived from this thus assign e.g. calories derived from one ton of primary production wheat for FAOSTAT_WOSYItem "Wheat"; but for others it is not primary production on this level
*                ALL THIS YET NEEDS TO BE IMPROVED - !!)
Parameter WOSY_WASTE(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_PRODUCTION(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FOOD(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FEED(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_SEED(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_OTHER(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FoodCal(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FoodCal_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FoodProt(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FoodProt_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FoodFat(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FoodFat_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FeedME(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FeedME_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FeedGE(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FeedGE_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FeedXP(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FeedXP_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FeedNEL(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FeedNEL_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_AreaHarvest(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_Yields(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_FeedQuantByp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_NrLiveAnimal(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
Parameter WOSY_NrProdAnimal(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);

Parameter WOSY_FEEDDM(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);

$gdxin ReorganiseWOSY_Output.gdx
$load WOSY_WASTE
$load WOSY_PRODUCTION
$load WOSY_FOOD
$load WOSY_FEED
$load WOSY_SEED
$load WOSY_OTHER
$load WOSY_FoodCal
$load WOSY_FoodCal_Byp
$load WOSY_FoodProt
$load WOSY_FoodProt_Byp
$load WOSY_FoodFat
$load WOSY_FoodFat_Byp
$load WOSY_FeedME
$load WOSY_FeedME_Byp
$load WOSY_FeedGE
$load WOSY_FeedGE_Byp
$load WOSY_FeedXP
$load WOSY_FeedXP_Byp
$load WOSY_FeedNEL
$load WOSY_FeedNEL_Byp
$load WOSY_AreaHarvest
$load WOSY_Yields
$load WOSY_FeedQuantByp
$load WOSY_NrLiveAnimal
$load WOSY_NrProdAnimal
$gdxin



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Some adaptions of units, etc.

*2.1) Yield type of live Animals
*Yield type for NrLiveAnimal is "Meat" but should be "AllOutputs", otherwise it is confusing. Thus do the following:
WOSY_NrLiveAnimal(FAOSTAT_Countries,FAOSTAT_WOSYItems,"AllOutputs")
         =WOSY_NrLiveAnimal(FAOSTAT_Countries,FAOSTAT_WOSYItems,"Meat");
*and get rid of the data with yield type meat:
WOSY_NrLiveAnimal(FAOSTAT_Countries,FAOSTAT_WOSYItems,"Meat") = na;


*2.2) Derive DAQ
*We now calculate an additional Parameter, namely the "domestically available quantity"
*        according to FAO FBS this is production + Import - Export + StockChanges
*        and equals the sum of all utilizations: Food, feed, seed, waste, other
*        "processing" does not enter as we get these numbers by accounting for all stages of the commodity trees,
*        so processed items, resp. the processed part of items are already accounted for by this
Parameter WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);

WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
        =  WOSY_FOOD(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         + WOSY_FEED(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         + WOSY_SEED(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         + WOSY_WASTE(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         + WOSY_OTHER(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);


*2.3) Change WOSY units for animal production
*WOSY Numbers are in quantities (tons) for Crops and "Snails Not Sea Snails"
*single heads for big livestock,
*1000 heads for small livestock ("chickens", "ducks", "geese and guinea fowls", "other rodents", "Pigeons, Other birds",
*        "Eggs Excl Hen", "Rabbits and hares", "Turkeys"
*Thus convert the small livestock to single heads:
WOSY_WASTE(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType) = WOSY_WASTE(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType)*1000;
WOSY_PRODUCTION(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType) = WOSY_PRODUCTION(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType)*1000;
WOSY_FOOD(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType) = WOSY_FOOD(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType)*1000;
WOSY_FEED(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType) = WOSY_FEED(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType)*1000;
WOSY_SEED(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType) = WOSY_SEED(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType)*1000;
WOSY_OTHER(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType) = WOSY_OTHER(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType)*1000;
WOSY_FeedQuantByp(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType) = WOSY_FeedQuantByp(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType)*1000;

WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType)
         = WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType)*1000;
WOSY_NrProdAnimal(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType) = WOSY_NrProdAnimal(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType)*1000;
WOSY_NrLiveAnimal(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType) = WOSY_NrLiveAnimal(FAOSTAT_Countries,FAOSTAT_WOSYItems_SmallAnimals,WOSY_OutputType)*1000;

*Now we have parameters that contain the various utilizations of
*        all animal activities in single heads and all crop activities in areas (ha) and in production quantity (tons).

*2.4) derive nutrient contents
*we file in or derive the total quantities later, but use the WOSY data to derive FeedGE-contents etc. that are then used to derive total amounts by multiplication with total quantities later in the code;
*this thus assumes the same processing patterns as in the old baseline reported in FAOSTAT, average 2005-2009: from a ton primary quantity, we assume that the reported amount of ME from byproducts is available, etc.
*thus, we basically assume that the extraction rates for white flour and brans, etc. all stay constant in all scenarios.

*derive nutrient contents per ton of DAQ utilized for food or feed, referring to primary production quantities; -
*derive total nutrients derived per ton, and nutrients derived from byproducts only, and, as difference, from main products only as well:
SET WOSY_NutrientContentsParameter
/
"Food calories total (kcal/t)", "Food protein total (t/t)", "Food fat total (t/t)"
"Feed ME total (MJ/t)", "Feed GE total (MJ/t)", "Feed XP total (t/t)"
"Feed ME from byprod (MJ/t)", "Feed GE from byprod (MJ/t)", "Feed XP from byprod (t/t)"
"Feed ME in byprod (MJ/t)", "Feed GE in byprod (MJ/t)", "Feed XP in byprod (t/t)"
*"Feed ME from main prod (MJ/t)", "Feed GE from main prod (MJ/t)", "Feed XP from main prod (t/t)"
"Feed ME from byprod in total food (MJ/t)", "Feed GE from byprod in total food (MJ/t)", "Feed XP from byprod in total food (t/t)"
"Feed quant byprod per total food (t/t)"
/;

Parameter FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,WOSY_NutrientContentsParameter);

*thus, the following are the quantities of calories and protein and fat for food that come with one ton of primary production utilized for food
*this is governed by the processing applied to this ton of primary production on average
*division by 1000000 for food protein and fat, as it is measured in g and needs to be converted to tons
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Food calories total (kcal/t)")
                 $WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FoodCal(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Food protein total (t/t)")
                 $WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FoodProt(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)/1000000;
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Food fat total (t/t)")
                 $WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FoodFat(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)/1000000;

*the same for ME, GE, XP, NEL: how much of this comes with one ton primary production allocated for feed
*division by 1000 for feed protein, as it is measured in kg and needs to be converted to tons
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Feed ME total (MJ/t)")
                 $WOSY_Feed(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FeedME(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_Feed(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Feed ME in byprod (MJ/t)")
                 $WOSY_FeedQuantByp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FeedME_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_FeedQuantByp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Feed GE total (MJ/t)")
                 $WOSY_Feed(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FeedGE(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_Feed(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Feed GE in byprod (MJ/t)")
                 $WOSY_FeedQuantByp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FeedGE_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_FeedQuantByp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Feed XP total (t/t)")
                 $WOSY_Feed(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FeedXP(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_Feed(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)/1000;
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Feed XP in byprod (t/t)")
                 $WOSY_FeedQuantByp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FeedXP_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_FeedQuantByp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)/1000;
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Feed quant byprod per total food (t/t)")
                 $WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FeedQuantByp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);

FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Feed ME from byprod in total food (MJ/t)")
                 $WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FeedME_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Feed GE from byprod in total food (MJ/t)")
                 $WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FeedGE_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);
FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Feed XP from byprod in total food (t/t)")
                 $WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FeedXP_Byp(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_Food(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)/1000;


*2.5) derive utilization shares
*derive nutrient contents per ton of DAQ utilized for food or feed, referring to primary production quantities; -
*derive total nutrients derived per ton, and nutrients derived from byproducts only, and, as difference, from main products only as well:
SET WOSY_Utilization
/
"Food Utilization"
"Feed Utilization"
"Seed Utilization"
"Waste Utilization"
"Other Utilization"
/;

*contains the utilization shares, i.e. how much of the DOMESTICALLY available quantity is used as food, feed, etc.
Parameter FAOSTAT_WOSY_UtilisationShares(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,WOSY_Utilization);

FAOSTAT_WOSY_UtilisationShares(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Food Utilization")
                 $WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FOOD(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);

FAOSTAT_WOSY_UtilisationShares(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Feed Utilization")
                 $WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_FEED(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);

FAOSTAT_WOSY_UtilisationShares(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Seed Utilization")
                 $WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_SEED(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);

FAOSTAT_WOSY_UtilisationShares(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Waste Utilization")
                 $WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_WASTE(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);

FAOSTAT_WOSY_UtilisationShares(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,"Other Utilization")
                 $WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
         = WOSY_OTHER(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType)
                 /WOSY_DomesticallyAvailableQuant(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType);



$ontext;
after this, we have:
         and we retain only what we need in the model: nutrient contents and utilization shares - not the absolute values those contents are based on

Parameter FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,WOSY_NutrientContentsParameter);
Parameter FAOSTAT_WOSY_UtilisationShares(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,WOSY_Utilization);
this is then on the level of processed and primary products as listed in FAOSTAT_WOSYItems - and on this level, multiplication of quantities from the FBS etc. with these contents delivers totals
but the translation to primary products then still needs to be done.
$offtext;










$exit;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

Set Match_WOSYNutrCont_PerTonDAQSOLmV5(WOSY_NutrientContentsParameter,PerTonDomestAvailQuantParameterSOLmV5)
/
"Food calories total (kcal/t)"."FoodCal (kcal/t)"
"Food protein total (t/t)"."FoodProt (t/t)"
"Food fat total (t/t)"."FoodFat (t/t)"

"Feed ME total (MJ/t)"."FeedME cont (MJ/t)"
"Feed GE total (MJ/t)"."FeedGE cont (MJ/t)"
"Feed XP total (t/t)"."FeedXP cont (t/t)"
*"FeedNEL cont (MJ/t)"

*"Feed quant byprod per total food (t/t)"
"Feed ME from byprod in total food (MJ/t)"."FeedME from byprod (MJ/t)"
"Feed GE from byprod in total food (MJ/t)"."FeedGE from byprod (MJ/t)"
"Feed XP from byprod in total food (t/t)"."FeedXP from byprod (t/t)"

$ontext;
the following from SET WOSY_NutrientContentsParameter are not yet matched
"Feed ME from byprod (MJ/t)", "Feed GE from byprod (MJ/t)", "Feed XP from byprod (t/t)"
"Feed ME in byprod (MJ/t)", "Feed GE in byprod (MJ/t)", "Feed XP in byprod (t/t)"
*"Feed ME from main prod (MJ/t)", "Feed GE from main prod (MJ/t)", "Feed XP from main prod (t/t)"
"Feed quant byprod per total food (t/t)"
$offtext;
/;

Set Match_WOSYUtil_PerTonDAQSOLmV5(WOSY_Utilization,PerTonDomestAvailQuantParameterSOLmV5)
/
"Food Utilization"."Food util share DAQ (t/t)"
"Feed Utilization"."Feed util share DAQ (t/t)"
"Seed Utilization"."Seed util share DAQ (t/t)"
"Waste Utilization"."Waste util share DAQ (t/t)"
"Other Utilization"."Other util share DAQ (t/t)"
/;


Set MatchWOSYItemsOutputType_CommoditySOLmV5(FAOSTAT_WOSYItems,WOSY_OutputType,CommoditySOLmV5)
*this is a 1:1-match of FAOSTAT_WOSYItems - first as the main set, then as part of CommoditySOLmV5 - plus output type in between
/
"Manila fibre (abaca)"."Crop"."Manila fibre (abaca)"
"Agave Fibres Nes"."Crop"."Agave Fibres Nes"
"Alcohol Non Food Purpose"."Crop"."Alcohol Non Food Purpose"
"Alfalfa For Forage+Silag"."Crop"."Alfalfa For Forage+Silag"
"Alfalfa Meal And Pellets"."Crop"."Alfalfa Meal And Pellets"
"Almonds"."Crop"."Almonds"
"Almonds Shelled"."Crop"."Almonds Shelled"
"Oils, fats of animal nes"."AllOutputs"."Oils, fats of animal nes"
"Anise, badian, fennel, coriander"."Crop"."Anise, badian, fennel, coriander"
"Apples"."Crop"."Apples"
"Applejuice Single Streng"."Crop"."Applejuice Single Streng"
"Applejuice Concentrated"."Crop"."Applejuice Concentrated"
"Apricots"."Crop"."Apricots"
"Apricots, dry"."Crop"."Apricots, dry"
"Arabic Gum"."Crop"."Arabic Gum"
"Areca Nuts (Betel)"."Crop"."Areca Nuts (Betel)"
"Artichokes"."Crop"."Artichokes"
"Asparagus"."Crop"."Asparagus"
"Asses"."Meat"."Asses"
"Avocados"."Crop"."Avocados"
"Bacon and ham"."Meat"."Bacon and ham"
"Bagasse"."Crop"."Bagasse"
"Bambara Beans"."Crop"."Bambara Beans"
"Bananas"."Crop"."Bananas"
"Barley"."Crop"."Barley"
"Barley Flour And Grits"."Crop"."Barley Flour And Grits"
"Barley, Pearled"."Crop"."Barley, Pearled"
"Beans, Dry"."Crop"."Beans, Dry"
"Beans, Green"."Crop"."Beans, Green"
"Meat, cattle"."Meat"."Meat, cattle"
"Meat, cattle, boneless (beef & veal)"."Meat"."Meat, cattle, boneless (beef & veal)"
"Beef Canned"."Meat"."Beef Canned"
"Beef Dried Salt Smoked"."Meat"."Beef Dried Salt Smoked"
"Meat, beef, preparations"."Meat"."Meat, beef, preparations"
"Meat, beef and veal sausages"."Meat"."Meat, beef and veal sausages"
"Beehives"."Honey"."Beehives"
"Beer Of Barley"."Crop"."Beer Of Barley"
"Beer Of Maize"."Crop"."Beer Of Maize"
"Beer Of Millet"."Crop"."Beer Of Millet"
"Beer Of Sorghum"."Crop"."Beer Of Sorghum"
"Beeswax"."AllOutputs"."Beeswax"
"Beet Pulp"."Crop"."Beet Pulp"
"Beet Sugar"."Crop"."Beet Sugar"
"Beet Tops"."Crop"."Beet Tops"
"Beets For Fodder"."Crop"."Beets For Fodder"
"Berries Nes"."Crop"."Berries Nes"
"Beverages, distilled alcoholic"."Crop"."Beverages, distilled alcoholic"
"Beverages, non alcoholic"."Crop"."Beverages, non alcoholic"
"Biological Ass Meat"."Meat"."Biological Ass Meat"
"Biological Buffalo Meat"."Meat"."Biological Buffalo Meat"
"Biological Camel Meat"."Meat"."Biological Camel Meat"
"Biological Cattle Meat"."Meat"."Biological Cattle Meat"
"Biological Chicken Meat"."Meat"."Biological Chicken Meat"
"Biological Duck Meat"."Meat"."Biological Duck Meat"
"Biological Geese Meat"."Meat"."Biological Geese Meat"
"Biological Goat Meat"."Meat"."Biological Goat Meat"
"Biological Horse Meat"."Meat"."Biological Horse Meat"
"Biological Mule Meat"."Meat"."Biological Mule Meat"
"Biological Other Camel"."Meat"."Biological Other Camel"
"Biological Other Poultry"."Meat"."Biological Other Poultry"
"Biological Pig Meat"."Meat"."Biological Pig Meat"
"Biological Rodents"."Meat"."Biological Rodents"
"Biological Sheep Meat"."Meat"."Biological Sheep Meat"
"Biological Turkey Meat"."Meat"."Biological Turkey Meat"
"Blood Meal"."AllOutputs"."Blood Meal"
"Blueberries"."Crop"."Blueberries"
"Bran, Barley"."Crop"."Bran, Barley"
"Bran, Buckwheat"."Crop"."Bran, Buckwheat"
"Bran, Cereals"."Crop"."Bran, Cereals"
"Bran, Fonio"."Crop"."Bran, Fonio"
"Bran, Maize"."Crop"."Bran, Maize"
"Bran, Millet"."Crop"."Bran, Millet"
"Bran, Mixed Grain"."Crop"."Bran, Mixed Grain"
"Bran, Oats"."Crop"."Bran, Oats"
"Bran, Pulses"."Crop"."Bran, Pulses"
"Bran, Rice"."Crop"."Bran, Rice"
"Bran, Rye"."Crop"."Bran, Rye"
"Bran, Sorghum"."Crop"."Bran, Sorghum"
"Bran, Triticale"."Crop"."Bran, Triticale"
"Bran, Wheat"."Crop"."Bran, Wheat"
"Brazil Nuts"."Crop"."Brazil Nuts"
"Brazil nuts, Shelled"."Crop"."Brazil nuts, Shelled"
"Bread"."Crop"."Bread"
"Breakfast Cereals"."Crop"."Breakfast Cereals"
"Broad beans, horse beans, dry"."Crop"."Broad beans, horse beans, dry"
"Broad Beans, Green"."Crop"."Broad Beans, Green"
"Buckwheat"."Crop"."Buckwheat"
"Buffalo Meat"."Meat"."Buffalo Meat"
"Buffalo Milk"."Milk"."Buffalo Milk"
"Bulgur"."Crop"."Bulgur"
"Butter Of Buffalo Milk"."Milk"."Butter Of Buffalo Milk"
"Butter, Cow Milk"."Milk"."Butter, Cow Milk"
"Butter Of Goat Milk"."Milk"."Butter Of Goat Milk"
"Butter Of Karite Nuts"."Crop"."Butter Of Karite Nuts"
"Butter+Ghee (Sheep Milk)"."Milk"."Butter+Ghee (Sheep Milk)"
"Buttermilk, curdled, acidified milk"."Milk"."Buttermilk, curdled, acidified milk"
"Dry Buttermilk"."Milk"."Dry Buttermilk"
"Cabbages and other brassicas"."Crop"."Cabbages and other brassicas"
"Cake, copra"."Crop"."Cake, copra"
"Cake, Cottonseed"."Crop"."Cake, Cottonseed"
"Cake, Groundnuts"."Crop"."Cake, Groundnuts"
"Cake, Hempseed"."Crop"."Cake, Hempseed"
"Cake, Kapok"."Crop"."Cake, Kapok"
"Cake, Linseed"."Crop"."Cake, Linseed"
"Cake, Maize"."Crop"."Cake, Maize"
"Cake, Mustard"."Crop"."Cake, Mustard"
"Cake, Palm Kernels"."Crop"."Cake, Palm Kernels"
"Cake Of Poppy Seed"."Crop"."Cake Of Poppy Seed"
"Cake, Rapeseed"."Crop"."Cake, Rapeseed"
"Cake, Rice Bran"."Crop"."Cake, Rice Bran"
"Cake, Safflower"."Crop"."Cake, Safflower"
"Cake, Sesame Seed"."Crop"."Cake, Sesame Seed"
"Cake, Soybeans"."Crop"."Cake, Soybeans"
"Cake, Sunflower"."Crop"."Cake, Sunflower"
"Cakes, Oilseeds Nes"."Crop"."Cakes, Oilseeds Nes"
"Camel Hides, Fresh"."Crop"."Camel Hides, Fresh"
"Camel Milk"."Milk"."Camel Milk"
"Camels"."Meat"."Camels"
"Canary Seed"."Crop"."Canary Seed"
"Cane Sugar"."Crop"."Cane Sugar"
"Cane Tops"."Crop"."Cane Tops"
"Carobs"."Crop"."Carobs"
"Carrots and turnips"."Crop"."Carrots and turnips"
"Casein"."Milk"."Casein"
"Cashew Nuts, with shell"."Crop"."Cashew Nuts, with shell"
"Cashew Nuts, Shelled"."Crop"."Cashew Nuts, Shelled"
"Cashewapple"."Crop"."Cashewapple"
"Cassava"."Crop"."Cassava"
"Cassava Dried"."Crop"."Cassava Dried"
"Cassava Leaves"."Crop"."Cassava Leaves"
"Starch, cassava"."Crop"."Starch, cassava"
"Cassava Tapioca"."Crop"."Cassava Tapioca"
"Castor Beans"."Crop"."Castor Beans"
"Cattle"."Meat"."Cattle"
"Cattle Butcher Fat"."AllOutputs"."Cattle Butcher Fat"
"Hides, cattle, fresh"."Hides"."Hides, cattle, fresh"
"Cauliflowers and broccoli"."Crop"."Cauliflowers and broccoli"
"Cereals Nes"."Crop"."Cereals Nes"
"Cereal preparations, nes"."Crop"."Cereal preparations, nes"
"Cereals, most"."Crop"."Cereals, most"
"Cheese Of Buffalo Milk"."Milk"."Cheese Of Buffalo Milk"
"Cheese Of Goat Milk"."Milk"."Cheese Of Goat Milk"
"Cheese, Sheep Milk"."Milk"."Cheese, Sheep Milk"
"Cheese (Skim Cow Milk)"."Milk"."Cheese (Skim Cow Milk)"
"Cheese, Whole Cow Milk"."Milk"."Cheese, Whole Cow Milk"
"Cherries"."Crop"."Cherries"
"Chestnut"."Crop"."Chestnut"
"Meat, chicken"."Meat"."Meat, chicken"
"Meat, chicken, canned"."Meat"."Meat, chicken, canned"
"Chickens"."Meat"."Chickens"
"Chick Peas"."Crop"."Chick Peas"
"Chicory Roots"."Crop"."Chicory Roots"
"Chillies and peppers, green"."Crop"."Chillies and peppers, green"
"Chocolate Products Nes"."Crop"."Chocolate Products Nes"
"Cigarettes"."Crop"."Cigarettes"
"Cigars, Cheroots"."Crop"."Cigars, Cheroots"
"Cinnamon (Canella)"."Crop"."Cinnamon (Canella)"
"Citrus Fruit Nes"."Crop"."Citrus Fruit Nes"
"Juice, citrus, single strength"."Crop"."Juice, citrus, single strength"
"Juice, citrus, concentrated"."Crop"."Juice, citrus, concentrated"
"Citrus, all"."Crop"."Citrus, all"
"Forage and silage, clover"."Crop"."Forage and silage, clover"
"Cloves"."Crop"."Cloves"
"Hair, goat, coarse"."Hides"."Hair, goat, coarse"
"Cocoa, Beans"."Crop"."Cocoa, Beans"
"Cocoa, Butter"."Crop"."Cocoa, Butter"
"Cocoa Husks+Shell"."Crop"."Cocoa Husks+Shell"
"Cocoa, Paste"."Crop"."Cocoa, Paste"
"Cocoa, powder & cake"."Crop"."Cocoa, powder & cake"
"Coconuts"."Crop"."Coconuts"
"Coconuts, Desiccated"."Crop"."Coconuts, Desiccated"
"Silk-worm cocoons, reelable"."AllOutputs"."Silk-worm cocoons, reelable"
"Cocoons, unreelable & waste"."AllOutputs"."Cocoons, unreelable & waste"
"Coffee, Extracts"."Crop"."Coffee, Extracts"
"Coffee, Green"."Crop"."Coffee, Green"
"Coffee, Husks And Skins"."Crop"."Coffee, Husks And Skins"
"Coffee, Roasted"."Crop"."Coffee, Roasted"
"Coffee, substitutes containing coffee"."Crop"."Coffee, substitutes containing coffee"
"Coir"."Crop"."Coir"
"Compound Feed, Cattle"."Crop"."Compound Feed, Cattle"
"Compound Feed, Pigs"."Crop"."Compound Feed, Pigs"
"Compound Feed, Poultry"."Crop"."Compound Feed, Poultry"
"Feed, compound, nes"."Crop"."Feed, compound, nes"
"Copra"."Crop"."Copra"
"Cotton, carded, combed"."Crop"."Cotton, carded, combed"
"Cotton Lint"."Crop"."Cotton Lint"
"Cotton Linter"."Crop"."Cotton Linter"
"Cotton Waste"."Crop"."Cotton Waste"
"Cottonseed"."Crop"."Cottonseed"
"Milk, whole fresh cow"."Milk"."Milk, whole fresh cow"
"Cow Peas, Dry"."Crop"."Cow Peas, Dry"
"Cranberries"."Crop"."Cranberries"
"Cream fresh"."Milk"."Cream fresh"
"Crude materials"."AllOutputs"."Crude materials"
"Cucumbers And Gherkins"."Crop"."Cucumbers And Gherkins"
"Currants"."Crop"."Currants"
"Dates"."Crop"."Dates"
"Degras"."Crop"."Degras"
"Dregs from brewing, distillation"."Crop"."Dregs from brewing, distillation"
"Meat, duck"."Meat"."Meat, duck"
"Ducks"."Meat"."Ducks"
"Eggplants (aubergines)"."Crop"."Eggplants (aubergines)"
"Eggs, dried"."Eggs"."Eggs, dried"
"Eggs, other bird, in shell"."Eggs"."Eggs, other bird, in shell"
"Eggs, Liquid"."Eggs"."Eggs, Liquid"
"Empty fruit shells"."Crop"."Empty fruit shells"
"Oil, essential nes"."Crop"."Oil, essential nes"
"Tea, mate extracts"."Crop"."Tea, mate extracts"
"Fat, liver prepared (foie gras)"."AllOutputs"."Fat, liver prepared (foie gras)"
"Fat, Buffalo"."AllOutputs"."Fat, Buffalo"
"Fat, Camels"."AllOutputs"."Fat, Camels"
"Fat, Cattle"."AllOutputs"."Fat, Cattle"
"Fat, Goats"."AllOutputs"."Fat, Goats"
"Fat, Other Camelids"."AllOutputs"."Fat, Other Camelids"
"Fat, Pigs"."AllOutputs"."Fat, Pigs"
"Fat, Poultry"."AllOutputs"."Fat, Poultry"
"Fat, Poultry Rendered"."AllOutputs"."Fat, Poultry Rendered"
"Fat Of Sheep"."AllOutputs"."Fat Of Sheep"
"Fat, nes, prepared"."AllOutputs"."Fat, nes, prepared"
"Fatty Acids"."AllOutputs"."Fatty Acids"
"Feed Additives"."AllOutputs"."Feed Additives"
"Feed Minerals"."AllOutputs"."Feed Minerals"
"Feed Supplements"."AllOutputs"."Feed Supplements"
"Cider etc"."Crop"."Cider etc"
"Fibre Crops Nes"."Crop"."Fibre Crops Nes"
"Figs"."Crop"."Figs"
"Figs dried"."Crop"."Figs dried"
"Fine Goat Hair"."Hides"."Fine Goat Hair"
"Fish Meal"."Meat"."Fish Meal"
"Flax Fibre And Tow"."Crop"."Flax Fibre And Tow"
"Flax Fibre Raw"."Crop"."Flax Fibre Raw"
"Flax Tow Waste"."Crop"."Flax Tow Waste"
"Flour, Buckwheat"."Crop"."Flour, Buckwheat"
"Flour, Cassava"."Crop"."Flour, Cassava"
"Flour, Cereals"."Crop"."Flour, Cereals"
"Flour, Fonio"."Crop"."Flour, Fonio"
"Flour, Fruit"."Crop"."Flour, Fruit"
"Flour, Maize"."Crop"."Flour, Maize"
"Flour, Millet"."Crop"."Flour, Millet"
"Flour, Mixed Grain"."Crop"."Flour, Mixed Grain"
"Flour, Mustard"."Crop"."Flour, Mustard"
"Flour, Potatoes"."Crop"."Flour, Potatoes"
"Flour, Pulses"."Crop"."Flour, Pulses"
"Flour, roots and tubers nes"."Crop"."Flour, roots and tubers nes"
"Flour, Rye"."Crop"."Flour, Rye"
"Flour, Sorghum"."Crop"."Flour, Sorghum"
"Flour, Triticale"."Crop"."Flour, Triticale"
"Flour, Wheat"."Crop"."Flour, Wheat"
"Flour/Meal Of Oilseeds"."Crop"."Flour/Meal Of Oilseeds"
"Fonio"."Crop"."Fonio"
"Food prep nes"."AllOutputs"."Food prep nes"
"Food preparations, flour, malt extract"."Crop"."Food preparations, flour, malt extract"
"Food Wastes"."AllOutputs"."Food Wastes"
"Food Wastes Prep Feed"."AllOutputs"."Food Wastes Prep Feed"
"Forage Products"."Crop"."Forage Products"
"Fruit, cooked, homogenized preparations"."Crop"."Fruit, cooked, homogenized preparations"
"Fruit, Dried Nes"."Crop"."Fruit, Dried Nes"
"Fruit, Fresh Nes"."Crop"."Fruit, Fresh Nes"
"Juice, fruit nes"."Crop"."Juice, fruit nes"
"Fruit, Prepared Nes"."Crop"."Fruit, Prepared Nes"
"Feed, pulp of fruit"."Crop"."Feed, pulp of fruit"
"Fruit, tropical fresh nes"."Crop"."Fruit, tropical fresh nes"
"Fruit Tropical Dried Nes"."Crop"."Fruit Tropical Dried Nes"
"Fruit,Nut,Peel,Sugar Prs"."Crop"."Fruit,Nut,Peel,Sugar Prs"
"Fruits, all"."Crop"."Fruits, all"
"Fruits, most"."Crop"."Fruits, most"
"Fur skin animal"."Hides"."Fur skin animal"
"Fur Skins"."Hides"."Fur Skins"
"Game"."Meat"."Game"
"Meat, game"."Meat"."Meat, game"
"Garlic"."Crop"."Garlic"
"Geese"."Meat"."Geese"
*we added the following as in the WOSY data, it is "Geese and guinea fowls" and not "Geese" only".""."*we added the following as in the WOSY data, it is "Geese and guinea fowls" and not "Geese" only"
"Geese and guinea fowls"."Meat"."Geese and guinea fowls"
"Germ, Maize"."Crop"."Germ, Maize"
"Germ, Wheat"."Crop"."Germ, Wheat"
"Ghee, of buffalo milk"."Milk"."Ghee, of buffalo milk"
"Ghee, of cow milk"."Milk"."Ghee, of cow milk"
"Ginger"."Crop"."Ginger"
"Glucose And Dextrose"."Crop"."Glucose And Dextrose"
"Feed and meal, gluten"."Crop"."Feed and meal, gluten"
"Meat, goat"."Meat"."Meat, goat"
"Goat Milk"."Milk"."Goat Milk"
"Goats"."Meat"."Goats"
"Skins, goat, fresh"."Hides"."Skins, goat, fresh"
"Meat, goose and guinea fowl"."Meat"."Meat, goose and guinea fowl"
"Gooseberries"."Crop"."Gooseberries"
"Juice, grape"."Crop"."Juice, grape"
"Grapefruit (inc. pomelos)"."Crop"."Grapefruit (inc. pomelos)"
"Juice, grapefruit"."Crop"."Juice, grapefruit"
"Juice, grapefruit, concentrated"."Crop"."Juice, grapefruit, concentrated"
"Grapes"."Crop"."Grapes"
"Forage and silage, grasses nes"."Crop"."Forage and silage, grasses nes"
"Grease incl. lanolin wool"."Hides"."Grease incl. lanolin wool"
"Maize, green"."Crop"."Maize, green"
"Groundnuts In Shell"."Crop"."Groundnuts In Shell"
"Prepared Groundnuts"."Crop"."Prepared Groundnuts"
"Groundnuts, Shelled"."Crop"."Groundnuts, Shelled"
"Hair Carded Or Combed"."Crop"."Hair Carded Or Combed"
"Hair Coarse Nes"."Hides"."Hair Coarse Nes"
"Hair, Fine"."Hides"."Hair, Fine"
"Hair Of Horses"."Hides"."Hair Of Horses"
"Hay (clover, lucerne,etc)"."Crop"."Hay (clover, lucerne,etc)"
"Hay (Unspecified)"."Crop"."Hay (Unspecified)"
"Hay Non-Leguminous"."Crop"."Hay Non-Leguminous"
"Hazelnuts (Filberts)"."Crop"."Hazelnuts (Filberts)"
"Hazelnuts, Shelled"."Crop"."Hazelnuts, Shelled"
"Hemp Fibre And Tow"."Crop"."Hemp Fibre And Tow"
"Hempseed"."Crop"."Hempseed"
"Eggs, hen, in shell"."Eggs"."Eggs, hen, in shell"
"Hide Dry-Salted"."Hides"."Hide Dry-Salted"
"Hides, nes"."Hides"."Hides, nes"
"Hide Wet-Salted"."Hides"."Hide Wet-Salted"
"Hides, buffalo, dry salted"."Hides"."Hides, buffalo, dry salted"
"Hides, camel, dry salted"."Hides"."Hides, camel, dry salted"
"Hides, cattle, dry salted"."Hides"."Hides, cattle, dry salted"
"Hides, horse, dry salted"."Hides"."Hides, horse, dry salted"
"Hides Nes Cattle"."Hides"."Hides Nes Cattle"
"Hides Of Asses Fresh"."Hides"."Hides Of Asses Fresh"
"Hides Of Mules Fresh"."Hides"."Hides Of Mules Fresh"
"Hides, camel, nes"."Hides"."Hides, camel, nes"
"Hides Unspecified Horses"."Hides"."Hides Unspecified Horses"
"Hides, buffalo, wet salted"."Hides"."Hides, buffalo, wet salted"
"Hides, camel, wet salted"."Hides"."Hides, camel, wet salted"
"Hides, cattle, wet salted"."Hides"."Hides, cattle, wet salted"
"Hides, horse, wet salted"."Hides"."Hides, horse, wet salted"
"Hides and skins nes, fresh"."Hides"."Hides and skins nes, fresh"
"Homogenized Meat Prep."."Meat"."Homogenized Meat Prep."
"Vegetables, homogenized preparations"."Crop"."Vegetables, homogenized preparations"
"Honey, natural"."Honey"."Honey, natural"
"Hops"."Crop"."Hops"
"Horse Hides, Fresh"."Hides"."Horse Hides, Fresh"
"Meat, horse"."Meat"."Meat, horse"
"Horses"."Meat"."Horses"
"Ice Cream And Edible Ice"."AllOutputs"."Ice Cream And Edible Ice"
"Indigenous Ass Meat"."Meat"."Indigenous Ass Meat"
"Indigenous Buffalo Meat"."Meat"."Indigenous Buffalo Meat"
"Indigenous Camel Meat"."Meat"."Indigenous Camel Meat"
"Indigenous Cattle Meat"."Meat"."Indigenous Cattle Meat"
"Indigenous Chicken Meat"."Meat"."Indigenous Chicken Meat"
"Indigenous Duck Meat"."Meat"."Indigenous Duck Meat"
"Indigenous Geese Meat"."Meat"."Indigenous Geese Meat"
"Indigenous Goat Meat"."Meat"."Indigenous Goat Meat"
"Indigenous Horse Meat"."Meat"."Indigenous Horse Meat"
"Indigenous Mule Meat"."Meat"."Indigenous Mule Meat"
"Indigenous Other Camel"."Meat"."Indigenous Other Camel"
"Indigenous Other Poultry"."Meat"."Indigenous Other Poultry"
"Indigenous Pigmeat"."Meat"."Indigenous Pigmeat"
"Indigenous Rodents"."Meat"."Indigenous Rodents"
"Indigenous Sheep Meat"."Meat"."Indigenous Sheep Meat"
"Indigenous Turkey Meat"."Meat"."Indigenous Turkey Meat"
"Infant Food"."AllOutputs"."Infant Food"
"Isoglucose"."Crop"."Isoglucose"
"Jojoba Oil"."Crop"."Jojoba Oil"
"Jute"."Crop"."Jute"
"Jute-Like Fibres"."Crop"."Jute-Like Fibres"
"Kapok Fibre"."Crop"."Kapok Fibre"
"Kapok Fruit"."Crop"."Kapok Fruit"
"Kapokseed In Shell"."Crop"."Kapokseed In Shell"
"Kapokseed Shelled"."Crop"."Kapokseed Shelled"
"Karakul Skins"."Hides"."Karakul Skins"
"Karite Nuts (Sheanuts)"."Crop"."Karite Nuts (Sheanuts)"
"Kiwi Fruit"."Crop"."Kiwi Fruit"
"Kola nuts"."Crop"."Kola nuts"
"Lactose"."Milk"."Lactose"
"Lard"."Meat"."Lard"
"Lard And Stearine Oil"."Meat"."Lard And Stearine Oil"
"Leather Used And Waste"."Hides"."Leather Used And Waste"
"Leaves And Tops, Vines"."Crop"."Leaves And Tops, Vines"
"Leeks, other alliaceous vegetables"."Crop"."Leeks, other alliaceous vegetables"
"Forage and silage, legumes"."Crop"."Forage and silage, legumes"
"Lemonjuice Single-Streng"."Crop"."Lemonjuice Single-Streng"
"Juice, lemon, concentrated"."Crop"."Juice, lemon, concentrated"
"Lemons And Limes"."Crop"."Lemons And Limes"
"Lentils"."Crop"."Lentils"
"Lettuce and chicory"."Crop"."Lettuce and chicory"
"Linseed"."Crop"."Linseed"
"Margarine, liquid"."Crop"."Margarine, liquid"
"Animals, live, non-food"."AllOutputs"."Animals, live, non-food"
"Live Animals Nes"."AllOutputs"."Live Animals Nes"
"Liver Preparationsa"."AllOutputs"."Liver Preparationsa"
"Lupins"."Crop"."Lupins"
"Macaroni"."Crop"."Macaroni"
"Maize"."Crop"."Maize"
"Maize For Forage+Silage"."Crop"."Maize For Forage+Silage"
"Maize Gluten"."Crop"."Maize Gluten"
"Malt Extracts"."Crop"."Malt Extracts"
"Malt"."Crop"."Malt"
"Mango Juice"."Crop"."Mango Juice"
"Mango Pulp"."Crop"."Mango Pulp"
"Mangoes, mangosteens, guavas"."Crop"."Mangoes, mangosteens, guavas"
"Maple Sugar And Syrups"."Crop"."Maple Sugar And Syrups"
"Marc Of Grapes"."Crop"."Marc Of Grapes"
"Margarine, Short"."Crop"."Margarine, Short"
"Mate"."Crop"."Mate"
"Meat Extracts"."Meat"."Meat Extracts"
"Meal, meat"."Meat"."Meal, meat"
"Meat, nes"."Meat"."Meat, nes"
"Meat, dried nes"."Meat"."Meat, dried nes"
"Meat, Asses"."Meat"."Meat, Asses"
"Meat, Camels"."Meat"."Meat, Camels"
"Meat, Mules"."Meat"."Meat, Mules"
"Meat, Other Camelids"."Meat"."Meat, Other Camelids"
"Meat, Other Rodents"."Meat"."Meat, Other Rodents"
"Meat, Pigeon Oth.Birds"."Meat"."Meat, Pigeon Oth.Birds"
"Meat Prepared Nes"."Meat"."Meat Prepared Nes"
"Melons, other (inc.cantaloupes)"."Crop"."Melons, other (inc.cantaloupes)"
"Melonseed"."Crop"."Melonseed"
"Milled Paddy Rice"."Crop"."Milled Paddy Rice"
"Millet"."Crop"."Millet"
"Grain, mixed"."Crop"."Grain, mixed"
"Mixes And Doughs"."Crop"."Mixes And Doughs"
"Molasses"."Crop"."Molasses"
"Mules"."Meat"."Mules"
"Mushrooms and truffles"."Crop"."Mushrooms and truffles"
"Mushrooms, Canned"."Crop"."Mushrooms, Canned"
"Dried Mushrooms"."Crop"."Dried Mushrooms"
"Must Of Grapes"."Crop"."Must Of Grapes"
"Mustard Seed"."Crop"."Mustard Seed"
"Meat, sheep"."Meat"."Meat, sheep"
"Natural Gums"."Crop"."Natural Gums"
"Rubber, natural"."Crop"."Rubber, natural"
"Nutmeg, mace and cardamoms"."Crop"."Nutmeg, mace and cardamoms"
"Nuts, Nes"."Crop"."Nuts, Nes"
"Nuts, all"."Crop"."Nuts, all"
"Nuts, all, shelled"."Crop"."Nuts, all, shelled"
"Oats"."Crop"."Oats"
"Oats Rolled"."Crop"."Oats Rolled"
"Offals, Liver Chicken"."AllOutputs"."Offals, Liver Chicken"
"Offals, Liver Duck"."AllOutputs"."Offals, Liver Duck"
"Offals, Liver Geese"."AllOutputs"."Offals, Liver Geese"
"Offals Liver Turkeys"."AllOutputs"."Offals Liver Turkeys"
"Offals Nes"."AllOutputs"."Offals Nes"
"Offals, edible, Buffalo"."AllOutputs"."Offals, edible, Buffalo"
"Offals, edible, Camel"."AllOutputs"."Offals, edible, Camel"
"Offals, edible, cattle"."AllOutputs"."Offals, edible, cattle"
"Offals, edible, goats"."AllOutputs"."Offals, edible, goats"
"Offals, Horse"."AllOutputs"."Offals, Horse"
"Offals, other camelids"."AllOutputs"."Offals, other camelids"
"Offals, pigs, edible"."AllOutputs"."Offals, pigs, edible"
"Offals, sheep,edible"."AllOutputs"."Offals, sheep,edible"
"Oil, Castor Beans"."Crop"."Oil, Castor Beans"
"Oil, Citronella"."Crop"."Oil, Citronella"
"Oil, Coconut (copra)"."Crop"."Oil, Coconut (copra)"
"Oil, Cottonseed"."Crop"."Oil, Cottonseed"
"Oil, Groundnut"."Crop"."Oil, Groundnut"
"Oil, Hempseed"."Crop"."Oil, Hempseed"
"Oil, Kapok"."Crop"."Oil, Kapok"
"Oil, Linseed"."Crop"."Oil, Linseed"
"Oil, Maize"."Crop"."Oil, Maize"
"Oil, Mustard Seed"."Crop"."Oil, Mustard Seed"
"Oil, Olive Residues"."Crop"."Oil, Olive Residues"
"Oil, Palm Kernel"."Crop"."Oil, Palm Kernel"
"Oil, Poppy"."Crop"."Oil, Poppy"
"Oil, Rapeseed"."Crop"."Oil, Rapeseed"
"Oil, Rice Bran"."Crop"."Oil, Rice Bran"
"Oil, Safflower"."Crop"."Oil, Safflower"
"Oil, Sesame"."Crop"."Oil, Sesame"
"Oil, Soybean"."Crop"."Oil, Soybean"
"Oil, Sunflower"."Crop"."Oil, Sunflower"
"Oil, vegetable origin nes"."Crop"."Oil, vegetable origin nes"
"Oil Palm Fruit"."Crop"."Oil Palm Fruit"
"Oil, boiled etc"."Crop"."Oil, boiled etc"
"Oils Fish And Marine Mam"."Crop"."Oils Fish And Marine Mam"
"Oils Hydrogenated"."Crop"."Oils Hydrogenated"
"Oilseeds Nes"."Crop"."Oilseeds Nes"
"Okra"."Crop"."Okra"
"Oil, olive, virgin"."Crop"."Oil, olive, virgin"
"Olive Residues"."Crop"."Olive Residues"
"Olives"."Crop"."Olives"
"Olives Preserved"."Crop"."Olives Preserved"
"Onions, Dry"."Crop"."Onions, Dry"
"Onions, shallots, green"."Crop"."Onions, shallots, green"
"Juice, orange, single strength"."Crop"."Juice, orange, single strength"
"Juice, orange, concentrated"."Crop"."Juice, orange, concentrated"
"Oranges"."Crop"."Oranges"
"Other birds for eggs"."Eggs"."Other birds for eggs"
*we added the following as in the WOSY data, it is available"."Crop"."*we added the following as in the WOSY data, it is available"
"Eggs Excl Hen"."Eggs"."Eggs Excl Hen"
*we added the following as in the WOSY data, it is available"."Crop"."*we added the following as in the WOSY data, it is available"
"Other Rodents"."Meat"."Other Rodents"
"Camelids, other"."Meat"."Camelids, other"
"Other Concentrates, Nes"."Crop"."Other Concentrates, Nes"
"Fructose and syrup, other"."Crop"."Fructose and syrup, other"
"Palm Kernels"."Crop"."Palm Kernels"
"Oil, palm"."Crop"."Oil, palm"
"Papayas"."Crop"."Papayas"
"Pastry"."Crop"."Pastry"
"Peaches And Nectarines"."Crop"."Peaches And Nectarines"
"Peanut Butter"."Crop"."Peanut Butter"
"Pears"."Crop"."Pears"
"Peas, Dry"."Crop"."Peas, Dry"
"Peas, Green"."Crop"."Peas, Green"
"Pepper (piper spp.)"."Crop"."Pepper (piper spp.)"
"Peppermint"."Crop"."Peppermint"
"Persimmons"."Crop"."Persimmons"
"Pet Food"."AllOutputs"."Pet Food"
"Pig Butcher Fat"."AllOutputs"."Pig Butcher Fat"
"Meat, pig, preparations"."Meat"."Meat, pig, preparations"
"Meat, pig sausages"."Meat"."Meat, pig sausages"
"Pigeon Peas"."Crop"."Pigeon Peas"
*"Pigeons Other Birds" - this was the original in this set - but in the WOSY data it has a comma, so we added this".""."*"Pigeons Other Birds" - this was the original in this set - but in the WOSY data it has a comma, so we added this"
"Pigeons, Other Birds"."Meat"."Pigeons, Other Birds"
"Meat, pig"."Meat"."Meat, pig"
"Pigs"."Meat"."Pigs"
"Pigskins, Fresh"."Hides"."Pigskins, Fresh"
"Chillies and peppers, dry"."Crop"."Chillies and peppers, dry"
"Pineapples"."Crop"."Pineapples"
"Pineapples Canned"."Crop"."Pineapples Canned"
"Juice, pineapple"."Crop"."Juice, pineapple"
"Juice, pineapple, concentrated"."Crop"."Juice, pineapple, concentrated"
"Pistachios"."Crop"."Pistachios"
"Plantains and others"."Crop"."Plantains and others"
"Juice, plum, single strength"."Crop"."Juice, plum, single strength"
"Juice, plum, concentrated"."Crop"."Juice, plum, concentrated"
"Plums and sloes"."Crop"."Plums and sloes"
"Plums, Dried (Prunes)"."Crop"."Plums, Dried (Prunes)"
"Pome Fruit Nes, Fresh"."Crop"."Pome Fruit Nes, Fresh"
"Popcorn"."Crop"."Popcorn"
"Poppy Seed"."Crop"."Poppy Seed"
"Meat, pork"."Meat"."Meat, pork"
"Pot Barley"."Crop"."Pot Barley"
"Potato Offals"."Crop"."Potato Offals"
"Potato Starch"."Crop"."Potato Starch"
"Potato Tapioca"."Crop"."Potato Tapioca"
"Potatoes"."Crop"."Potatoes"
"Potatoes, frozen"."Crop"."Potatoes, frozen"
"Nuts, prepared (exc. groundnuts)"."Crop"."Nuts, prepared (exc. groundnuts)"
"Cheese, processed"."Milk"."Cheese, processed"
"Milk, products of natural constituents nes"."Milk"."Milk, products of natural constituents nes"
"Pulses Nes"."Crop"."Pulses Nes"
"Pulses, all"."Crop"."Pulses, all"
"Pumpkins, squash and gourds"."Crop"."Pumpkins, squash and gourds"
"Pyrethrum, extraction"."Crop"."Pyrethrum, extraction"
"Pyrethrum Marc"."Crop"."Pyrethrum Marc"
"Pyrethrum, Dried"."Crop"."Pyrethrum, Dried"
"Quinces"."Crop"."Quinces"
"Quinoa"."Crop"."Quinoa"
"Meat, rabbit"."Meat"."Meat, rabbit"
"Rabbit Meat Biological"."Meat"."Rabbit Meat Biological"
"Rabbit Meat Indigenous"."Meat"."Rabbit Meat Indigenous"
"Rabbit Skins"."Hides"."Rabbit Skins"
"Rabbits and hares"."Meat"."Rabbits and hares"
"Raisins"."Crop"."Raisins"
"Ramie"."Crop"."Ramie"
"Rapeseed"."Crop"."Rapeseed"
"Raspberries"."Crop"."Raspberries"
"Milk, reconstituted"."Milk"."Milk, reconstituted"
"Fatty substance residues"."AllOutputs"."Fatty substance residues"
"Rice, Broken"."Crop"."Rice, Broken"
"Beverages, fermented rice"."Crop"."Beverages, fermented rice"
"Rice Flour"."Crop"."Rice Flour"
"Rice Gluten"."Crop"."Rice Gluten"
"Rice, Husked"."Crop"."Rice, Husked"
"Milled/Husked Rice"."Crop"."Milled/Husked Rice"
"Rice, Paddy"."Crop"."Rice, Paddy"
"Rice, Starch"."Crop"."Rice, Starch"
"Roots and Tubers, most"."Crop"."Roots and Tubers, most"
"Roots And Tubers Dried"."Crop"."Roots And Tubers Dried"
"Roots And Tubers, Nes"."Crop"."Roots And Tubers, Nes"
"Rubber Natural Dry"."Crop"."Rubber Natural Dry"
"Rye"."Crop"."Rye"
"Safflower Seed"."Crop"."Safflower Seed"
"Seed Cotton"."Crop"."Seed Cotton"
"Sesame Seed"."Crop"."Sesame Seed"
"Sheep"."Meat"."Sheep"
"Milk, whole fresh sheep"."Milk"."Milk, whole fresh sheep"
"Skins, sheep, fresh"."Hides"."Skins, sheep, fresh"
"Silk Raw"."AllOutputs"."Silk Raw"
"Silkworms"."AllOutputs"."Silkworms"
"Sisal"."Crop"."Sisal"
"Skim Milk, Condensed"."Milk"."Skim Milk, Condensed"
"Milk, skimmed dried"."Milk"."Milk, skimmed dried"
"Skim Milk, Evaporated"."Milk"."Skim Milk, Evaporated"
"Skim Milk Of Buffalo"."Milk"."Skim Milk Of Buffalo"
"Milk, skimmed cow"."Milk"."Milk, skimmed cow"
"Skim Milk Of Goat"."Milk"."Skim Milk Of Goat"
"Skim Sheep Milk"."Milk"."Skim Sheep Milk"
"Skins, pig, dry salted"."Hides"."Skins, pig, dry salted"
"Skins, sheep, dry salted"."Hides"."Skins, sheep, dry salted"
"Skin Nes Pigs"."Hides"."Skin Nes Pigs"
"Skin Nes Sheep"."Hides"."Skin Nes Sheep"
"Skins, pig, wet salted"."Hides"."Skins, pig, wet salted"
"Skins, sheep, wet salted"."Hides"."Skins, sheep, wet salted"
"Skins, sheep, with wool"."Hides"."Skins, sheep, with wool"
"Skins Dry-Salt Calves"."Hides"."Skins Dry-Salt Calves"
"Skins Dry-Salted Goats"."Hides"."Skins Dry-Salted Goats"
"Skins Fresh Of Calves"."Hides"."Skins Fresh Of Calves"
"Skins Nes Calves"."Hides"."Skins Nes Calves"
"Skins Nes Goats"."Hides"."Skins Nes Goats"
"Skins, calve, wet salted"."Hides"."Skins, calve, wet salted"
"Skins, goat, wet salted"."Hides"."Skins, goat, wet salted"
"Snails Not Sea Snails"."AllOutputs"."Snails Not Sea Snails"
"Sorghum"."Crop"."Sorghum"
"Cherries, sour"."Crop"."Cherries, sour"
"Soya Curd"."Crop"."Soya Curd"
"Soya Paste"."Crop"."Soya Paste"
"Soya Sauce"."Crop"."Soya Sauce"
"Soybeans"."Crop"."Soybeans"
"Spermaceti"."AllOutputs"."Spermaceti"
"Spices, nes"."Crop"."Spices, nes"
"Spinach"."Crop"."Spinach"
"Standardized Milk"."Milk"."Standardized Milk"
"Starch and Sugar crops for Alc"."Crop"."Starch and Sugar crops for Alc"
"Starch Of Maize"."Crop"."Starch Of Maize"
"Stillingia Oil"."Crop"."Stillingia Oil"
"Stone Fruit Nes, Fresh"."Crop"."Stone Fruit Nes, Fresh"
"Straw Husks"."Crop"."Straw Husks"
"Strawberries"."Crop"."Strawberries"
"String Beans"."Crop"."String Beans"
"Sugar, Nes"."Crop"."Sugar, Nes"
"Sugar Beet"."Crop"."Sugar Beet"
"Sugar Cane"."Crop"."Sugar Cane"
"Sugar Confectionery"."Crop"."Sugar Confectionery"
"Sugar Crops, Nes"."Crop"."Sugar Crops, Nes"
"Sugar Refined"."Crop"."Sugar Refined"
"Sugar raw centrifugal"."Crop"."Sugar raw centrifugal"
"Sugar non-centrifugal"."Crop"."Sugar non-centrifugal"
"Sugar Flavoured"."Crop"."Sugar Flavoured"
"Sunflower Seed"."Crop"."Sunflower Seed"
"Swedes For Fodder"."Crop"."Swedes For Fodder"
"Sweet Corn Frozen"."Crop"."Sweet Corn Frozen"
"Sweet corn prep or preserved"."Crop"."Sweet corn prep or preserved"
"Sweet Potatoes"."Crop"."Sweet Potatoes"
"Tallow"."Crop"."Tallow"
"Tallowtree Seeds"."Crop"."Tallowtree Seeds"
"Tangerine Juice"."Crop"."Tangerine Juice"
"Tangerines, mandarins, clementines, satsumas"."Crop"."Tangerines, mandarins, clementines, satsumas"
"Taro (Coco Yam)"."Crop"."Taro (Coco Yam)"
"Tea"."Crop"."Tea"
"Tea Nes"."Crop"."Tea Nes"
"Tobacco, unmanufactured"."Crop"."Tobacco, unmanufactured"
"Tobacco Products Nes"."Crop"."Tobacco Products Nes"
"Juice, tomato"."Crop"."Juice, tomato"
"Tomatojuice Concentrated"."Crop"."Tomatojuice Concentrated"
"Tomatoes, Paste"."Crop"."Tomatoes, Paste"
"Tomatoes"."Crop"."Tomatoes"
"Tomatoes, peeled"."Crop"."Tomatoes, peeled"
"Triticale"."Crop"."Triticale"
"Tung Oil"."Crop"."Tung Oil"
"Tung Nuts"."Crop"."Tung Nuts"
"Meat, turkey"."Meat"."Meat, turkey"
"Turkeys"."Meat"."Turkeys"
"Turnips For Fodder"."Crop"."Turnips For Fodder"
"Vanilla"."Crop"."Vanilla"
"Vegetables, fresh or dried products nes"."Crop"."Vegetables, fresh or dried products nes"
"Feed, vegetable products nes"."Crop"."Feed, vegetable products nes"
"Vegetable Tallow"."Crop"."Vegetable Tallow"
"Vegetables, Dehydrated"."Crop"."Vegetables, Dehydrated"
"Vegetables, Frozen"."Crop"."Vegetables, Frozen"
"Vegetables, canned nes"."Crop"."Vegetables, canned nes"
"Vegetables, Dried Nes"."Crop"."Vegetables, Dried Nes"
"Vegetables, Fresh Nes"."Crop"."Vegetables, Fresh Nes"
"Juice Of Vegetables Nes"."Crop"."Juice Of Vegetables Nes"
"Vegetables in vinegar"."Crop"."Vegetables in vinegar"
"Vegetables, preserved nes"."Crop"."Vegetables, preserved nes"
"Vegetables, preserved, frozen"."Crop"."Vegetables, preserved, frozen"
"Vegetables, temporarily preserved"."Crop"."Vegetables, temporarily preserved"
"Vegetables, most"."Crop"."Vegetables, most"
"Vegetables+Roots,Fodder"."Crop"."Vegetables+Roots,Fodder"
"Vermouths & similar"."Crop"."Vermouths & similar"
"Vetches"."Crop"."Vetches"
"Vitamins"."Crop"."Vitamins"
"Wafers"."Crop"."Wafers"
"Walnuts, with shell"."Crop"."Walnuts, with shell"
"Walnuts, shelled"."Crop"."Walnuts, shelled"
"Watermelons"."Crop"."Watermelons"
"Waters,Ice Etc"."Crop"."Waters,Ice Etc"
"Waxes vegetable"."Crop"."Waxes vegetable"
"Wheat"."Crop"."Wheat"
"Wheat Fermented Beverage"."Crop"."Wheat Fermented Beverage"
"Wheat Gluten"."Crop"."Wheat Gluten"
"Wheat Starch"."Crop"."Wheat Starch"
"Whey Cheese"."Milk"."Whey Cheese"
"Whey, Condensed"."Milk"."Whey, Condensed"
"Whey, dry"."Milk"."Whey, dry"
"Whey, Fresh"."Milk"."Whey, Fresh"
"Milk, whole condensed"."Milk"."Milk, whole condensed"
"Milk, whole dried"."Milk"."Milk, whole dried"
"Milk, whole evaporated"."Milk"."Milk, whole evaporated"
"Wine"."Crop"."Wine"
"Wool, Hair Waste"."Hides"."Wool, Hair Waste"
"Wool Shoddy"."Hides"."Wool Shoddy"
"Wool, Greasy"."Hides"."Wool, Greasy"
"Wool, degreased"."Hides"."Wool, degreased"
"Yams"."Crop"."Yams"
"Yautia (Cocoyam)"."Crop"."Yautia (Cocoyam)"
"Yoghurt"."Milk"."Yoghurt"
"Yoghurt, concentrated or not"."Milk"."Yoghurt, concentrated or not"
/;


*3.2) Link to the core model parameters

ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,PerTonDomestAvailQuantParameterSOLmV5,"AverageProdType","All","Baseline")
         = sum((WOSY_NutrientContentsParameter,FAOSTAT_WOSYItems,WOSY_OutputType,FAOSTAT_Countries)$(Match_WOSYNutrCont_PerTonDAQSOLmV5(WOSY_NutrientContentsParameter,PerTonDomestAvailQuantParameterSOLmV5)
                 AND MatchWOSYItemsOutputType_CommoditySOLmV5(FAOSTAT_WOSYItems,WOSY_OutputType,CommoditySOLmV5)
                 AND MatchFAOSTATCountries_GeographicRegionSOLmV5(FAOSTAT_Countries,GeographicRegionSOLmV5)),
           FAOSTAT_WOSY_NutrientContents(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,WOSY_NutrientContentsParameter));

$ontext;
take util shares not from WOSY but derive directly from Commodity balances in the respective module.
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,PerTonDomestAvailQuantParameterSOLmV5,"AverageProdType","All","Baseline")
*The conditional is needed to avoid overwriting the assignments just done before
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,PerTonDomestAvailQuantParameterSOLmV5,"AverageProdType","All","Baseline"))
         = sum((WOSY_Utilization,FAOSTAT_WOSYItems,WOSY_OutputType,FAOSTAT_Countries)$(Match_WOSYUtil_PerTonDAQSOLmV5(WOSY_Utilization,PerTonDomestAvailQuantParameterSOLmV5)
                 AND MatchWOSYItemsOutputType_CommoditySOLmV5(FAOSTAT_WOSYItems,WOSY_OutputType,CommoditySOLmV5)
                 AND MatchFAOSTATCountries_GeographicRegionSOLmV5(FAOSTAT_Countries,GeographicRegionSOLmV5)),
           FAOSTAT_WOSY_UtilisationShares(FAOSTAT_Countries,FAOSTAT_WOSYItems,WOSY_OutputType,WOSY_Utilization));
$offtext;

*some of this data is wrong - as it is way too high or low. We checked by analysing the following data and then replaced additional values in __SOLmV5_ReadData_VariousSources_CommodityBalancesNutrientContentsData
*        besides those that are already replaced
*we tested with the following with conditions: ME < 20000; GE < 30000; XP < 0.5 and ME > 1000; GE > 2000; XP > 0.02
$ontext;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline")
                 $(ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline") > 1000)
         = 0;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedGE cont (MJ/t)","AverageProdType","All","Baseline")
                 $(ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedGE cont (MJ/t)","AverageProdType","All","Baseline") > 2000)
         = 0;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedXP cont (t/t)","AverageProdType","All","Baseline")
                 $(ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedXP cont (t/t)","AverageProdType","All","Baseline") > 0.02)
         = 0;
$offtext;




$ontext;
After this we have the following in SOLmV5-entities:

where:
GeographicRegionSOLmV5   is      FAOSTAT_Countries
CommoditySOLmV5          is      FAOSTAT_WOSYItems
PerTonDomestAvailQuantParameterSOLmV5
                         is      WOSY_NutrientContentsParameter (kcal,prot,fat per ton; FeedME total etc. per ton food, FeedME from Byprod per ton food) and WOSY_Utilization (food,feed,seed,waste,other)

ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,PerTonDomestAvailQuantParameterSOLmV5,"AverageProdType","All","Baseline")

$offtext;



$ontext;
*        XXX STILL TO BE DONE:
Assign:
Not yet all elements from WOSY_NutrientContentsParameter transferred from WOSY data to core model parameters and variables!!
Check the comment after the definition of Set Match_WOSYNutrCont_PerTonDAQSOLmV5 to learn which ones

CHECK: OutputType allocation in the matching set between SOLmV5 commodities and WOSY items - this was done quite ad hoc
Use as a basis for checking this the allocation done in the sheet FAOSTAT_WOSYItems_OutputType in the excel file CompareTradeItemLists_3_12_2017

Are the utilization shares from WOSY consistent whith the ones that can be derived from the Commodity Balances? If not, rather use the latter (they are from FAOSTAT in general and cover all years, but may not all commodities in WOSY)
$offtext;
