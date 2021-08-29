PUTCLOSE con,"_V6_ReadData_FAOSTAT_Trade";

$ontext;
GENERAL DESCRIPTION
This file reads the trade data from FAOSTAT: detailed trade matrix, trade in living animals, and trade in crop and livestock products

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
$if %ReadNewFAOSTATTradeData% == "NO" $goto UseOldTradeFile


*$ifthen %ReadNewFAOSTATTradeData% == "YES"
$call csv2gdx FAOSTAT_TradeDetailedTradeMatrixNormalized_29_11_2017.csv id=FAOSTAT_DetailedTradeMatrix Index=(2,4,6,8,10,11) Values=(12) UseHeader=Y
$call csv2gdx FAOSTAT_TradeLiveAnimalsNormalized_29_11_2017.csv id=FAOSTAT_TradeInLivingAnimals Index=(2,4,6,8,9) Values=(10) UseHeader=Y
$call csv2gdx FAOSTAT_TradeCropsAndLivestockProductsNormalized_29_11_2017.csv id=FAOSTAT_TradeCropLivestockProducts Index=(2,4,6,8,9) Values=(10) UseHeader=Y
*$endif;

alias(FAOSTAT_CountriesAndRegions,FAOSTAT_CountriesAndRegions_2)
Parameter FAOSTAT_DetailedTradeMatrix(FAOSTAT_CountriesAndRegions,FAOSTAT_CountriesAndRegions_2,FAOSTAT_DetailedTradeMatrixItems,FAOSTAT_TradeElements,Years,FAOSTAT_TradeUnits);
*first entry is "reporter country", second entry is "partner country"; fourth entry is "Element" - i.e .import, export, etc.
*thus: "import" comes to reporter country from partner country, export goes from reporter country to partner country
Parameter FAOSTAT_TradeInLivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_TradeElements,Years,FAOSTAT_TradeUnits);
Parameter FAOSTAT_TradeCropLivestockProducts(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeCropsAndLivestockProductsItems,FAOSTAT_TradeElements,Years,FAOSTAT_TradeUnits);

$gdxin FAOSTAT_TradeDetailedTradeMatrixNormalized_29_11_2017.gdx
$load FAOSTAT_DetailedTradeMatrix
$gdxin
$gdxin FAOSTAT_TradeLiveAnimalsNormalized_29_11_2017.gdx
$load FAOSTAT_TradeInLivingAnimals
$gdxin
$gdxin FAOSTAT_TradeCropsAndLivestockProductsNormalized_29_11_2017.gdx
$load FAOSTAT_TradeCropLivestockProducts
$gdxin


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) build average over the base year period chosen to get the baseline values

PARAMETER NumberOfBasisYearsFAOSTATDetailedTradeMatrix;
PARAMETER NumberOfBasisYearsFAOSTATTradeInLivingAnimals;
PARAMETER NumberOfBasisYearsFAOSTATTradeCropLivestockProducts;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....

NumberOfBasisYearsFAOSTATDetailedTradeMatrix(FAOSTAT_CountriesAndRegions,FAOSTAT_CountriesAndRegions_2,FAOSTAT_DetailedTradeMatrixItems,FAOSTAT_TradeElements,FAOSTAT_TradeUnits)
         = SUM(BasisYears$FAOSTAT_DetailedTradeMatrix(FAOSTAT_CountriesAndRegions,FAOSTAT_CountriesAndRegions_2,FAOSTAT_DetailedTradeMatrixItems,FAOSTAT_TradeElements,BasisYears,FAOSTAT_TradeUnits),1);
FAOSTAT_DetailedTradeMatrix(FAOSTAT_CountriesAndRegions,FAOSTAT_CountriesAndRegions_2,FAOSTAT_DetailedTradeMatrixItems,FAOSTAT_TradeElements,"AverageBasisYear",FAOSTAT_TradeUnits)
                 $NumberOfBasisYearsFAOSTATDetailedTradeMatrix(FAOSTAT_CountriesAndRegions,FAOSTAT_CountriesAndRegions_2,FAOSTAT_DetailedTradeMatrixItems,FAOSTAT_TradeElements,FAOSTAT_TradeUnits)
         = SUM(BasisYears,FAOSTAT_DetailedTradeMatrix(FAOSTAT_CountriesAndRegions,FAOSTAT_CountriesAndRegions_2,FAOSTAT_DetailedTradeMatrixItems,FAOSTAT_TradeElements,BasisYears,FAOSTAT_TradeUnits))
                 /NumberOfBasisYearsFAOSTATDetailedTradeMatrix(FAOSTAT_CountriesAndRegions,FAOSTAT_CountriesAndRegions_2,FAOSTAT_DetailedTradeMatrixItems,FAOSTAT_TradeElements,FAOSTAT_TradeUnits);

NumberOfBasisYearsFAOSTATTradeInLivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_TradeElements,FAOSTAT_TradeUnits)
         = SUM(BasisYears$FAOSTAT_TradeInLivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_TradeElements,BasisYears,FAOSTAT_TradeUnits),1);
FAOSTAT_TradeInLivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_TradeElements,"AverageBasisYear",FAOSTAT_TradeUnits)
                 $NumberOfBasisYearsFAOSTATTradeInLivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_TradeElements,FAOSTAT_TradeUnits)
         = SUM(BasisYears,FAOSTAT_TradeInLivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_TradeElements,BasisYears,FAOSTAT_TradeUnits))
                 /NumberOfBasisYearsFAOSTATTradeInLivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_TradeElements,FAOSTAT_TradeUnits);

NumberOfBasisYearsFAOSTATTradeCropLivestockProducts(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeCropsAndLivestockProductsItems,FAOSTAT_TradeElements,FAOSTAT_TradeUnits)
         = SUM(BasisYears$FAOSTAT_TradeCropLivestockProducts(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeCropsAndLivestockProductsItems,FAOSTAT_TradeElements,BasisYears,FAOSTAT_TradeUnits),1);
FAOSTAT_TradeCropLivestockProducts(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeCropsAndLivestockProductsItems,FAOSTAT_TradeElements,"AverageBasisYear",FAOSTAT_TradeUnits)
                 $NumberOfBasisYearsFAOSTATTradeCropLivestockProducts(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeCropsAndLivestockProductsItems,FAOSTAT_TradeElements,FAOSTAT_TradeUnits)
         = SUM(BasisYears,FAOSTAT_TradeCropLivestockProducts(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeCropsAndLivestockProductsItems,FAOSTAT_TradeElements,BasisYears,FAOSTAT_TradeUnits))
                 /NumberOfBasisYearsFAOSTATTradeCropLivestockProducts(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeCropsAndLivestockProductsItems,FAOSTAT_TradeElements,FAOSTAT_TradeUnits);


$ontext;
after this, we have
Parameter FAOSTAT_DetailedTradeMatrix(FAOSTAT_CountriesAndRegions,FAOSTAT_CountriesAndRegions_2,FAOSTAT_DetailedTradeMatrixItems,FAOSTAT_TradeElements,Years,FAOSTAT_TradeUnits);
Parameter FAOSTAT_TradeInLivingAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_TradeElements,Years,FAOSTAT_TradeUnits);
Parameter FAOSTAT_TradeCropLivestockProducts(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeCropsAndLivestockProductsItems,FAOSTAT_TradeElements,Years,FAOSTAT_TradeUnits);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

*the following matching set needs to be defined, as the definition of the set ActivitySOLmV5 regrettably does not result in FAOSTAT_TradeLiveAnimalsItems being accessible as a subset of it
*        albeit all its elements are part of it.
*        ATTENTION: the sets FAOSTAT_LiveAnimalsItems and FAOSTAT_TradeLiveAnimalsItems regrettable differ somewhat as well, thus we cannot use the same matching set as for livestock production
*                more important: the original data is defined over different sets, albeit they are in the end equal (because the additional items in the trade set are aggregates or unimportant ones, so we drop them).
*                we therefore need not to add items to ActivitySOLmV5
Set MatchFaostatTradeLiveAnimalItems_Activities(FAOSTAT_TradeLiveAnimalsItems,Activities)
/
"Animals live nes"."Animals live nes"
"Asses"."Asses"
"Beehives"."Beehives"
"Buffaloes"."Buffaloes"
"Camelids, other"."Camelids, other"
"Camels"."Camels"
"Cattle"."Cattle"
*"Cattle and Buffaloes"."Cattle and Buffaloes"
"Chickens"."Chickens"
"Ducks"."Ducks"
*not part of FAOSTAT_TradeLiveAnimalsItems
*"Geese and guinea fowls"."Geese and guinea fowls"
"Goats"."Goats"
"Horses"."Horses"
"Mules"."Mules"
"Pigeons, other birds"."Pigeons, other birds"
"Pigs"."Pigs"
*"Poultry Birds"."Poultry Birds"
"Rabbits and hares"."Rabbits and hares"
"Rodents, other"."Rodents, other"
"Sheep"."Sheep"
"Sheep and Goats"."Sheep and Goats"
"Turkeys"."Turkeys"
*additional in FAOSTAT_TradeLiveAnimalsItems
*but these rather seem to be aggregates or not relevant, so we do not include them
*"Agricult.Products,Total"
*"Animals, live, non-food"
*"Bovine, Animals"
*"Food Excl Fish"
*"Live Animals"
*"Total Merchandise Trade"
/;

*the following matching set needs to be defined, as the definition of the set CommoditySOLmV5 regrettably does not result in FAOSTAT_DetailedTradeMatrixItems being accessible as a subset of it
*        albeit all its elements are part of it.
Set MatchFaostatDetailedTradeItems_Commodities(FAOSTAT_DetailedTradeMatrixItems,Commodities)
/
"Alfalfa meal and pellets"."Alfalfa meal and pellets"
"Almonds shelled"."Almonds shelled"
"Animals live nes"."Animals live nes"
"Animals, live, non-food"."Animals, live, non-food"
"Anise, badian, fennel, coriander"."Anise, badian, fennel, coriander"
"Apples"."Apples"
"Apricots"."Apricots"
"Apricots, dry"."Apricots, dry"
"Artichokes"."Artichokes"
"Asparagus"."Asparagus"
"Asses"."Asses"
"Avocados"."Avocados"
"Bacon and ham"."Bacon and ham"
"Bambara beans"."Bambara beans"
"Bananas"."Bananas"
"Barley"."Barley"
"Barley, pearled"."Barley, pearled"
"Beans, dry"."Beans, dry"
"Beans, green"."Beans, green"
"Beehives"."Beehives"
"Beer of barley"."Beer of barley"
"Beer of sorghum"."Beer of sorghum"
"Beeswax"."Beeswax"
"Beet pulp"."Beet pulp"
"Beverages, distilled alcoholic"."Beverages, distilled alcoholic"
"Beverages, fermented rice"."Beverages, fermented rice"
"Beverages, non alcoholic"."Beverages, non alcoholic"
"Blueberries"."Blueberries"
"Bran, buckwheat"."Bran, buckwheat"
"Bran, fonio"."Bran, fonio"
"Bran, maize"."Bran, maize"
"Bran, millet"."Bran, millet"
"Bran, sorghum"."Bran, sorghum"
"Bran, wheat"."Bran, wheat"
"Brazil nuts, shelled"."Brazil nuts, shelled"
"Bread"."Bread"
"Broad beans, horse beans, dry"."Broad beans, horse beans, dry"
"Buckwheat"."Buckwheat"
"Buffaloes"."Buffaloes"
"Bulgur"."Bulgur"
"Butter of karite nuts"."Butter of karite nuts"
"Butter, cow milk"."Butter, cow milk"
"Buttermilk, curdled, acidified milk"."Buttermilk, curdled, acidified milk"
"Cabbages and other brassicas"."Cabbages and other brassicas"
"Cake, copra"."Cake, copra"
"Cake, cottonseed"."Cake, cottonseed"
"Cake, groundnuts"."Cake, groundnuts"
"Cake, hempseed"."Cake, hempseed"
"Cake, kapok"."Cake, kapok"
"Cake, linseed"."Cake, linseed"
"Cake, maize"."Cake, maize"
"Cake, mustard"."Cake, mustard"
"Cake, palm kernel"."Cake, palm kernel"
"Cake, rapeseed"."Cake, rapeseed"
"Cake, rice bran"."Cake, rice bran"
"Cake, safflower"."Cake, safflower"
"Cake, sesame seed"."Cake, sesame seed"
"Cake, soybeans"."Cake, soybeans"
"Cake, sunflower"."Cake, sunflower"
"Camelids, other"."Camelids, other"
"Camels"."Camels"
"Canary seed"."Canary seed"
"Cane tops"."Cane tops"
"Carrots and turnips"."Carrots and turnips"
"Cashew nuts, shelled"."Cashew nuts, shelled"
"Cashew nuts, with shell"."Cashew nuts, with shell"
"Cashewapple"."Cashewapple"
"Cassava"."Cassava"
"Cassava dried"."Cassava dried"
"Cattle"."Cattle"
"Cauliflowers and broccoli"."Cauliflowers and broccoli"
"Cereal preparations, nes"."Cereal preparations, nes"
"Cereals, breakfast"."Cereals, breakfast"
"Cheese, processed"."Cheese, processed"
"Cheese, sheep milk"."Cheese, sheep milk"
"Cheese, whole cow milk"."Cheese, whole cow milk"
"Cherries"."Cherries"
"Cherries, sour"."Cherries, sour"
"Chestnut"."Chestnut"
"Chick peas"."Chick peas"
"Chickens"."Chickens"
"Chillies and peppers, dry"."Chillies and peppers, dry"
"Chillies and peppers, green"."Chillies and peppers, green"
"Chocolate products nes"."Chocolate products nes"
"Cider etc"."Cider etc"
"Cigarettes"."Cigarettes"
"Cigars, cheroots"."Cigars, cheroots"
"Cinnamon (canella)"."Cinnamon (canella)"
"Cloves"."Cloves"
"Cocoa, beans"."Cocoa, beans"
"Cocoa, butter"."Cocoa, butter"
"Cocoa, paste"."Cocoa, paste"
"Cocoa, powder & cake"."Cocoa, powder & cake"
"Coconuts"."Coconuts"
"Coconuts, desiccated"."Coconuts, desiccated"
"Cocoons, unreelable & waste"."Cocoons, unreelable & waste"
"Coffee, extracts"."Coffee, extracts"
"Coffee, green"."Coffee, green"
"Coffee, husks and skins"."Coffee, husks and skins"
"Coffee, roasted"."Coffee, roasted"
"Coffee, substitutes containing coffee"."Coffee, substitutes containing coffee"
"Copra"."Copra"
"Cotton lint"."Cotton lint"
"Cotton linter"."Cotton linter"
"Cotton waste"."Cotton waste"
"Cotton, carded, combed"."Cotton, carded, combed"
"Cottonseed"."Cottonseed"
"Cranberries"."Cranberries"
"Cream fresh"."Cream fresh"
"Crude materials"."Crude materials"
"Cucumbers and gherkins"."Cucumbers and gherkins"
"Currants"."Currants"
"Dates"."Dates"
"Dregs from brewing, distillation"."Dregs from brewing, distillation"
"Ducks"."Ducks"
"Eggplants (aubergines)"."Eggplants (aubergines)"
"Eggs, dried"."Eggs, dried"
"Eggs, hen, in shell"."Eggs, hen, in shell"
"Eggs, liquid"."Eggs, liquid"
"Eggs, other bird, in shell"."Eggs, other bird, in shell"
"Fat, camels"."Fat, camels"
"Fat, cattle"."Fat, cattle"
"Fat, liver prepared (foie gras)"."Fat, liver prepared (foie gras)"
"Fat, nes, prepared"."Fat, nes, prepared"
"Fat, pigs"."Fat, pigs"
"Fatty acids"."Fatty acids"
"Fatty substance residues"."Fatty substance residues"
"Feed and meal, gluten"."Feed and meal, gluten"
"Feed minerals"."Feed minerals"
"Feed supplements"."Feed supplements"
"Feed, compound, nes"."Feed, compound, nes"
"Feed, pulp of fruit"."Feed, pulp of fruit"
"Feed, vegetable products nes"."Feed, vegetable products nes"
"Figs"."Figs"
"Figs dried"."Figs dried"
"Flax fibre and tow"."Flax fibre and tow"
"Flax fibre raw"."Flax fibre raw"
"Flax tow waste"."Flax tow waste"
"Flour, cereals"."Flour, cereals"
"Flour, fonio"."Flour, fonio"
"Flour, maize"."Flour, maize"
"Flour, mixed grain"."Flour, mixed grain"
"Flour, mustard"."Flour, mustard"
"Flour, potatoes"."Flour, potatoes"
"Flour, pulses"."Flour, pulses"
"Flour, roots and tubers nes"."Flour, roots and tubers nes"
"Flour, wheat"."Flour, wheat"
"Fonio"."Fonio"
"Food prep nes"."Food prep nes"
"Food preparations, flour, malt extract"."Food preparations, flour, malt extract"
"Food wastes"."Food wastes"
"Forage and silage, clover"."Forage and silage, clover"
"Forage and silage, grasses nes"."Forage and silage, grasses nes"
"Forage and silage, legumes"."Forage and silage, legumes"
"Forage products"."Forage products"
"Fructose and syrup, other"."Fructose and syrup, other"
"Fruit, cooked, homogenized preparations"."Fruit, cooked, homogenized preparations"
"Fruit, dried nes"."Fruit, dried nes"
"Fruit, fresh nes"."Fruit, fresh nes"
"Fruit, prepared nes"."Fruit, prepared nes"
"Fruit, tropical fresh nes"."Fruit, tropical fresh nes"
"Garlic"."Garlic"
"Germ, maize"."Germ, maize"
"Ghee, of buffalo milk"."Ghee, of buffalo milk"
"Ginger"."Ginger"
"Glucose and dextrose"."Glucose and dextrose"
"Goats"."Goats"
"Gooseberries"."Gooseberries"
"Grain, mixed"."Grain, mixed"
"Grapefruit (inc. pomelos)"."Grapefruit (inc. pomelos)"
"Grapes"."Grapes"
"Grease incl. lanolin wool"."Grease incl. lanolin wool"
"Groundnuts, shelled"."Groundnuts, shelled"
"Hair, fine"."Hair, fine"
"Hair, goat, coarse"."Hair, goat, coarse"
"Hay (clover, lucerne,etc)"."Hay (clover, lucerne,etc)"
"Hay (unspecified)"."Hay (unspecified)"
"Hazelnuts, shelled"."Hazelnuts, shelled"
"Hides and skins nes, fresh"."Hides and skins nes, fresh"
"Hides, buffalo, dry salted"."Hides, buffalo, dry salted"
"Hides, buffalo, fresh"."Hides, buffalo, fresh"
"Hides, buffalo, wet salted"."Hides, buffalo, wet salted"
"Hides, camel, nes"."Hides, camel, nes"
"Hides, camel, wet salted"."Hides, camel, wet salted"
"Hides, cattle, fresh"."Hides, cattle, fresh"
"Hides, cattle, wet salted"."Hides, cattle, wet salted"
"Hides, horse, dry salted"."Hides, horse, dry salted"
"Hides, nes"."Hides, nes"
"Honey, natural"."Honey, natural"
"Hops"."Hops"
"Horses"."Horses"
"Ice cream and edible ice"."Ice cream and edible ice"
"Infant food"."Infant food"
"Juice, citrus, concentrated"."Juice, citrus, concentrated"
"Juice, citrus, single strength"."Juice, citrus, single strength"
"Juice, fruit nes"."Juice, fruit nes"
"Juice, grape"."Juice, grape"
"Juice, grapefruit"."Juice, grapefruit"
"Juice, grapefruit, concentrated"."Juice, grapefruit, concentrated"
"Juice, lemon, concentrated"."Juice, lemon, concentrated"
"Juice, orange, concentrated"."Juice, orange, concentrated"
"Juice, orange, single strength"."Juice, orange, single strength"
"Juice, pineapple"."Juice, pineapple"
"Juice, pineapple, concentrated"."Juice, pineapple, concentrated"
"Juice, plum, concentrated"."Juice, plum, concentrated"
"Juice, plum, single strength"."Juice, plum, single strength"
"Juice, tomato"."Juice, tomato"
"Jute"."Jute"
"Kapok fibre"."Kapok fibre"
"Kapokseed in shell"."Kapokseed in shell"
"Kapokseed shelled"."Kapokseed shelled"
"Kiwi fruit"."Kiwi fruit"
"Kola nuts"."Kola nuts"
"Lactose"."Lactose"
"Lard"."Lard"
"Leeks, other alliaceous vegetables"."Leeks, other alliaceous vegetables"
"Lemons and limes"."Lemons and limes"
"Lentils"."Lentils"
"Lettuce and chicory"."Lettuce and chicory"
"Linseed"."Linseed"
"Macaroni"."Macaroni"
"Maize"."Maize"
"Maize, green"."Maize, green"
"Malt"."Malt"
"Mangoes, mangosteens, guavas"."Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"."Manila fibre (abaca)"
"Maple sugar and syrups"."Maple sugar and syrups"
"Margarine, liquid"."Margarine, liquid"
"Margarine, short"."Margarine, short"
"Maté"."Maté"
"Meal, meat"."Meal, meat"
"Meat, ass"."Meat, ass"
"Meat, beef and veal sausages"."Meat, beef and veal sausages"
"Meat, beef, preparations"."Meat, beef, preparations"
"Meat, cattle"."Meat, cattle"
"Meat, cattle, boneless (beef & veal)"."Meat, cattle, boneless (beef & veal)"
"Meat, chicken"."Meat, chicken"
"Meat, chicken, canned"."Meat, chicken, canned"
"Meat, dried nes"."Meat, dried nes"
"Meat, duck"."Meat, duck"
"Meat, game"."Meat, game"
"Meat, goat"."Meat, goat"
"Meat, goose and guinea fowl"."Meat, goose and guinea fowl"
"Meat, horse"."Meat, horse"
"Meat, nes"."Meat, nes"
"Meat, pig"."Meat, pig"
"Meat, pig sausages"."Meat, pig sausages"
"Meat, pig, preparations"."Meat, pig, preparations"
"Meat, pork"."Meat, pork"
"Meat, rabbit"."Meat, rabbit"
"Meat, sheep"."Meat, sheep"
"Meat, turkey"."Meat, turkey"
"Melons, other (inc.cantaloupes)"."Melons, other (inc.cantaloupes)"
"Milk, products of natural constituents nes"."Milk, products of natural constituents nes"
"Milk, reconstituted"."Milk, reconstituted"
"Milk, skimmed cow"."Milk, skimmed cow"
"Milk, skimmed dried"."Milk, skimmed dried"
"Milk, whole condensed"."Milk, whole condensed"
"Milk, whole dried"."Milk, whole dried"
"Milk, whole evaporated"."Milk, whole evaporated"
"Milk, whole fresh cow"."Milk, whole fresh cow"
"Milk, whole fresh sheep"."Milk, whole fresh sheep"
"Millet"."Millet"
"Mixes and doughs"."Mixes and doughs"
"Molasses"."Molasses"
"Mules"."Mules"
"Mushrooms and truffles"."Mushrooms and truffles"
"Mushrooms, canned"."Mushrooms, canned"
"Mustard seed"."Mustard seed"
"Nutmeg, mace and cardamoms"."Nutmeg, mace and cardamoms"
"Nuts, nes"."Nuts, nes"
"Nuts, prepared (exc. groundnuts)"."Nuts, prepared (exc. groundnuts)"
"Oats"."Oats"
"Oats rolled"."Oats rolled"
"Offals, edible, cattle"."Offals, edible, cattle"
"Offals, edible, goats"."Offals, edible, goats"
"Offals, liver chicken"."Offals, liver chicken"
"Offals, liver duck"."Offals, liver duck"
"Offals, liver geese"."Offals, liver geese"
"Offals, other camelids"."Offals, other camelids"
"Offals, pigs, edible"."Offals, pigs, edible"
"Offals, sheep,edible"."Offals, sheep,edible"
"Oil, boiled etc"."Oil, boiled etc"
"Oil, castor beans"."Oil, castor beans"
"Oil, citronella"."Oil, citronella"
"Oil, coconut (copra)"."Oil, coconut (copra)"
"Oil, cottonseed"."Oil, cottonseed"
"Oil, essential nes"."Oil, essential nes"
"Oil, groundnut"."Oil, groundnut"
"Oil, kapok"."Oil, kapok"
"Oil, linseed"."Oil, linseed"
"Oil, maize"."Oil, maize"
"Oil, olive residues"."Oil, olive residues"
"Oil, olive, virgin"."Oil, olive, virgin"
"Oil, palm"."Oil, palm"
"Oil, palm kernel"."Oil, palm kernel"
"Oil, poppy"."Oil, poppy"
"Oil, rapeseed"."Oil, rapeseed"
"Oil, rice bran"."Oil, rice bran"
"Oil, safflower"."Oil, safflower"
"Oil, sesame"."Oil, sesame"
"Oil, soybean"."Oil, soybean"
"Oil, sunflower"."Oil, sunflower"
"Oil, vegetable origin nes"."Oil, vegetable origin nes"
"Oils, fats of animal nes"."Oils, fats of animal nes"
"Oilseeds nes"."Oilseeds nes"
"Olives"."Olives"
"Olives preserved"."Olives preserved"
"Onions, dry"."Onions, dry"
"Onions, shallots, green"."Onions, shallots, green"
"Oranges"."Oranges"
"Papayas"."Papayas"
"Pastry"."Pastry"
"Peaches and nectarines"."Peaches and nectarines"
"Peanut butter"."Peanut butter"
"Pears"."Pears"
"Peas, dry"."Peas, dry"
"Peas, green"."Peas, green"
"Pepper (piper spp.)"."Pepper (piper spp.)"
"Peppermint"."Peppermint"
"Persimmons"."Persimmons"
"Pet food"."Pet food"
"Pigs"."Pigs"
"Pineapples"."Pineapples"
"Pineapples canned"."Pineapples canned"
"Pistachios"."Pistachios"
"Plantains and others"."Plantains and others"
"Plantains"."Plantains"

"Plums and sloes"."Plums and sloes"
"Plums dried (prunes)"."Plums dried (prunes)"
"Popcorn"."Popcorn"
"Poppy seed"."Poppy seed"
"Potato offals"."Potato offals"
"Potatoes"."Potatoes"
"Potatoes, frozen"."Potatoes, frozen"
"Pumpkins, squash and gourds"."Pumpkins, squash and gourds"
"Pyrethrum, dried"."Pyrethrum, dried"
"Pyrethrum, extraction"."Pyrethrum, extraction"
"Quinces"."Quinces"
"Rabbits and hares"."Rabbits and hares"
"Raisins"."Raisins"
"Rapeseed"."Rapeseed"
"Rice - total  (Rice milled equivalent)"."Rice - total  (Rice milled equivalent)"
"Rice – total  (Rice milled equivalent)"."Rice – total  (Rice milled equivalent)"

"Rodents, other"."Rodents, other"
"Roots and tubers, nes"."Roots and tubers, nes"
"Rubber natural dry"."Rubber natural dry"
"Rubber, natural"."Rubber, natural"
"Rye"."Rye"
"Sesame seed"."Sesame seed"
"Sheep"."Sheep"
"Silk raw"."Silk raw"
"Silk-worm cocoons, reelable"."Silk-worm cocoons, reelable"
"Skins, calve, wet salted"."Skins, calve, wet salted"
"Skins, goat, fresh"."Skins, goat, fresh"
"Skins, goat, wet salted"."Skins, goat, wet salted"
"Skins, sheep, dry salted"."Skins, sheep, dry salted"
"Skins, sheep, fresh"."Skins, sheep, fresh"
"Skins, sheep, wet salted"."Skins, sheep, wet salted"
"Skins, sheep, with wool"."Skins, sheep, with wool"
"Sorghum"."Sorghum"
"Soya curd"."Soya curd"
"Soya paste"."Soya paste"
"Soya sauce"."Soya sauce"
"Soybeans"."Soybeans"
"Spices, nes"."Spices, nes"
"Spinach"."Spinach"
"Starch, cassava"."Starch, cassava"
"Straw husks"."Straw husks"
"Strawberries"."Strawberries"
"Sugar beet"."Sugar beet"
"Sugar confectionery"."Sugar confectionery"
"Sugar crops, nes"."Sugar crops, nes"
"Sugar flavoured"."Sugar flavoured"
"Sugar non-centrifugal"."Sugar non-centrifugal"
"Sugar Raw Centrifugal"."Sugar Raw Centrifugal"
"Sugar refined"."Sugar refined"
"Sugar, nes"."Sugar, nes"
"Sunflower seed"."Sunflower seed"
"Sweet corn frozen"."Sweet corn frozen"
"Sweet corn prep or preserved"."Sweet corn prep or preserved"
"Sweet potatoes"."Sweet potatoes"
"Tallow"."Tallow"
"Tangerines, mandarins, clementines, satsumas"."Tangerines, mandarins, clementines, satsumas"
"Tea"."Tea"
"Tea, mate extracts"."Tea, mate extracts"
"Tobacco products nes"."Tobacco products nes"
"Tobacco, unmanufactured"."Tobacco, unmanufactured"
"Tomatoes"."Tomatoes"
"Tomatoes, paste"."Tomatoes, paste"
"Tomatoes, peeled"."Tomatoes, peeled"
"Triticale"."Triticale"
"Turkeys"."Turkeys"
"Turnips for fodder"."Turnips for fodder"
"Vanilla"."Vanilla"
"Vegetable tallow"."Vegetable tallow"
"Vegetables in vinegar"."Vegetables in vinegar"
"Vegetables, canned nes"."Vegetables, canned nes"
"Vegetables, dehydrated"."Vegetables, dehydrated"
"Vegetables, dried nes"."Vegetables, dried nes"
"Vegetables, fresh nes"."Vegetables, fresh nes"
"Vegetables, fresh or dried products nes"."Vegetables, fresh or dried products nes"
"Vegetables, frozen"."Vegetables, frozen"
"Vegetables, homogenized preparations"."Vegetables, homogenized preparations"
"Vegetables, preserved nes"."Vegetables, preserved nes"
"Vegetables, preserved, frozen"."Vegetables, preserved, frozen"
"Vegetables, temporarily preserved"."Vegetables, temporarily preserved"
"Vermouths & similar"."Vermouths & similar"
"Vetches"."Vetches"
"Vitamins"."Vitamins"
"Wafers"."Wafers"
"Walnuts, shelled"."Walnuts, shelled"
"Walnuts, with shell"."Walnuts, with shell"
"Watermelons"."Watermelons"
"Waters,ice etc"."Waters,ice etc"
"Waxes vegetable"."Waxes vegetable"
"Wheat"."Wheat"
"Whey, condensed"."Whey, condensed"
"Whey, dry"."Whey, dry"
"Wine"."Wine"
"Wool, degreased"."Wool, degreased"
"Wool, greasy"."Wool, greasy"
"Wool, hair waste"."Wool, hair waste"
"Yoghurt, concentrated or not"."Yoghurt, concentrated or not"
/;

*and we need the China sub-regiosn for the trade-data, as some values are only available for those and not for China as a whole:

$onmulti;
set FAOSTAT_Countries
/
"China, Hong Kong SAR"
"China, Macao SAR"
"China, mainland"
"China, Taiwan Province of"
/;
$offmulti;

$onmulti;
set MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
/
"China, Hong Kong SAR"."China, Hong Kong SAR"
"China, Macao SAR"."China, Macao SAR"
"China, mainland"."China, mainland"
"China, Taiwan Province of"."China, Taiwan Province of"
/;
$offmulti;



*3.2) Link to the core model parameters
*here, do only link the detailed trade matrix and the live animals, as the trade in crop and livestock products is already covered in the commodity balance sheets.
*Thus, the following parameter is not currently used here
*Parameter FAOSTAT_TradeCropLivestockProducts(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeCropsAndLivestockProductsItems,FAOSTAT_TradeElements,Years,FAOSTAT_TradeUnits);

alias(FAOSTAT_Countries,FAOSTAT_Countries_2);


VImportQuantity.l(Regions,Regions_2,Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_DetailedTradeMatrixItems,FAOSTAT_Countries,FAOSTAT_Countries_2)$(MatchFaostatDetailedTradeItems_Commodities(FAOSTAT_DetailedTradeMatrixItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries_2,Regions_2)),
          FAOSTAT_DetailedTradeMatrix(FAOSTAT_Countries,FAOSTAT_Countries_2,FAOSTAT_DetailedTradeMatrixItems,"Import Quantity","AverageBasisYear","Tonnes"));

VExportQuantity.l(Regions,Regions_2,Commodities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_DetailedTradeMatrixItems,FAOSTAT_Countries,FAOSTAT_Countries_2)$(MatchFaostatDetailedTradeItems_Commodities(FAOSTAT_DetailedTradeMatrixItems,Commodities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries_2,Regions_2)),
          FAOSTAT_DetailedTradeMatrix(FAOSTAT_Countries,FAOSTAT_Countries_2,FAOSTAT_DetailedTradeMatrixItems,"Export Quantity","AverageBasisYear","Tonnes"));

VImportLivingAnimalsHead.l(Regions,"World",Activities,"Living","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_Countries)$(MatchFaostatTradeLiveAnimalItems_Activities(FAOSTAT_TradeLiveAnimalsItems,Activities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
            FAOSTAT_TradeInLivingAnimals(FAOSTAT_Countries,FAOSTAT_TradeLiveAnimalsItems,"Import Quantity","AverageBasisYear","Head"));

VExportLivingAnimalsHead.l(Regions,"World",Activities,"Living","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_Countries)$(MatchFaostatTradeLiveAnimalItems_Activities(FAOSTAT_TradeLiveAnimalsItems,Activities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
            FAOSTAT_TradeInLivingAnimals(FAOSTAT_Countries,FAOSTAT_TradeLiveAnimalsItems,"Export Quantity","AverageBasisYear","Head"));

*for poultry: unit is "1000 heads"
VImportLivingAnimalsHead.l(Regions,"World",Activities,"Living","AllProdSyst","AllProdCond")
                 $(NOT VImportLivingAnimalsHead.l(Regions,"World",Activities,"Living","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_Countries)$(MatchFaostatTradeLiveAnimalItems_Activities(FAOSTAT_TradeLiveAnimalsItems,Activities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
            FAOSTAT_TradeInLivingAnimals(FAOSTAT_Countries,FAOSTAT_TradeLiveAnimalsItems,"Import Quantity","AverageBasisYear","1000 Head"))*1000;
VExportLivingAnimalsHead.l(Regions,"World",Activities,"Living","AllProdSyst","AllProdCond")
                 $(NOT VExportLivingAnimalsHead.l(Regions,"World",Activities,"Living","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_Countries)$(MatchFaostatTradeLiveAnimalItems_Activities(FAOSTAT_TradeLiveAnimalsItems,Activities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
            FAOSTAT_TradeInLivingAnimals(FAOSTAT_Countries,FAOSTAT_TradeLiveAnimalsItems,"Export Quantity","AverageBasisYear","1000 Head"))*1000;

*for beehives: unit is "No"
VImportLivingAnimalsAPU.l(Regions,"World",Activities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_Countries)$(MatchFaostatTradeLiveAnimalItems_Activities(FAOSTAT_TradeLiveAnimalsItems,Activities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
            FAOSTAT_TradeInLivingAnimals(FAOSTAT_Countries,FAOSTAT_TradeLiveAnimalsItems,"Import Quantity","AverageBasisYear","No"));
VExportLivingAnimalsAPU.l(Regions,"World",Activities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_TradeLiveAnimalsItems,FAOSTAT_Countries)$(MatchFaostatTradeLiveAnimalItems_Activities(FAOSTAT_TradeLiveAnimalsItems,Activities)
                 AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
            FAOSTAT_TradeInLivingAnimals(FAOSTAT_Countries,FAOSTAT_TradeLiveAnimalsItems,"Export Quantity","AverageBasisYear","No"));


*to avoid double counting for China and to consistently have data for China as the sum of China, mainland, Taiwan, etc. drop the sub-region values for the trade in animals, where the China value is given,
*        and assign the China value as the sum for the import and export data, as there, "China" is missing:

VImportQuantity.l(Regions,"China",Commodities,"AllProdSyst","AllProdCond")
         $(NOT VImportQuantity.l(Regions,"China",Commodities,"AllProdSyst","AllProdCond"))
         = VImportQuantity.l(Regions,"China, Hong Kong SAR",Commodities,"AllProdSyst","AllProdCond")
                 + VImportQuantity.l(Regions,"China, Macao SAR",Commodities,"AllProdSyst","AllProdCond")
                 + VImportQuantity.l(Regions,"China, mainland",Commodities,"AllProdSyst","AllProdCond")
                 + VImportQuantity.l(Regions,"China, Taiwan Province of",Commodities,"AllProdSyst","AllProdCond");

VExportQuantity.l(Regions,"China",Commodities,"AllProdSyst","AllProdCond")
         $(NOT VExportQuantity.l(Regions,"China",Commodities,"AllProdSyst","AllProdCond"))
         = VExportQuantity.l(Regions,"China, Hong Kong SAR",Commodities,"AllProdSyst","AllProdCond")
                 + VExportQuantity.l(Regions,"China, Macao SAR",Commodities,"AllProdSyst","AllProdCond")
                 + VExportQuantity.l(Regions,"China, mainland",Commodities,"AllProdSyst","AllProdCond")
                 + VExportQuantity.l(Regions,"China, Taiwan Province of",Commodities,"AllProdSyst","AllProdCond");

VImportQuantity.l("China",Regions,Commodities,"AllProdSyst","AllProdCond")
         $(NOT VImportQuantity.l("China",Regions,Commodities,"AllProdSyst","AllProdCond"))
         = VImportQuantity.l("China, Hong Kong SAR",Regions,Commodities,"AllProdSyst","AllProdCond")
                 + VImportQuantity.l("China, Macao SAR",Regions,Commodities,"AllProdSyst","AllProdCond")
                 + VImportQuantity.l("China, mainland",Regions,Commodities,"AllProdSyst","AllProdCond")
                 + VImportQuantity.l("China, Taiwan Province of",Regions,Commodities,"AllProdSyst","AllProdCond");

VExportQuantity.l("China",Regions,Commodities,"AllProdSyst","AllProdCond")
         $(NOT VExportQuantity.l("China",Regions,Commodities,"AllProdSyst","AllProdCond"))
         = VExportQuantity.l("China, Hong Kong SAR",Regions,Commodities,"AllProdSyst","AllProdCond")
                 + VExportQuantity.l("China, Macao SAR",Regions,Commodities,"AllProdSyst","AllProdCond")
                 + VExportQuantity.l("China, mainland",Regions,Commodities,"AllProdSyst","AllProdCond")
                 + VExportQuantity.l("China, Taiwan Province of",Regions,Commodities,"AllProdSyst","AllProdCond");

VImportQuantity.l(Regions,"China, Hong Kong SAR",Commodities,"AllProdSyst","AllProdCond") = 0;
VImportQuantity.l(Regions,"China, Macao SAR",Commodities,"AllProdSyst","AllProdCond") = 0;
VImportQuantity.l(Regions,"China, mainland",Commodities,"AllProdSyst","AllProdCond") = 0;
VImportQuantity.l(Regions,"China, Taiwan Province of",Commodities,"AllProdSyst","AllProdCond") = 0;

VExportQuantity.l(Regions,"China, Hong Kong SAR",Commodities,"AllProdSyst","AllProdCond") = 0;
VExportQuantity.l(Regions,"China, Macao SAR",Commodities,"AllProdSyst","AllProdCond") = 0;
VExportQuantity.l(Regions,"China, mainland",Commodities,"AllProdSyst","AllProdCond") = 0;
VExportQuantity.l(Regions,"China, Taiwan Province of",Commodities,"AllProdSyst","AllProdCond") = 0;

VImportQuantity.l("China, Hong Kong SAR",Regions,Commodities,"AllProdSyst","AllProdCond") = 0;
VImportQuantity.l("China, Macao SAR",Regions,Commodities,"AllProdSyst","AllProdCond") = 0;
VImportQuantity.l("China, mainland",Regions,Commodities,"AllProdSyst","AllProdCond") = 0;
VImportQuantity.l("China, Taiwan Province of",Regions,Commodities,"AllProdSyst","AllProdCond") = 0;

VExportQuantity.l("China, Hong Kong SAR",Regions,Commodities,"AllProdSyst","AllProdCond") = 0;
VExportQuantity.l("China, Macao SAR",Regions,Commodities,"AllProdSyst","AllProdCond") = 0;
VExportQuantity.l("China, mainland",Regions,Commodities,"AllProdSyst","AllProdCond") = 0;
VExportQuantity.l("China, Taiwan Province of",Regions,Commodities,"AllProdSyst","AllProdCond") = 0;


VImportLivingAnimalsHead.l("China","World",Activities,"Living","AllProdSyst","AllProdCond")
                 $(NOT VImportLivingAnimalsHead.l("China","World",Activities,"Living","AllProdSyst","AllProdCond"))
         = VImportLivingAnimalsHead.l("China, Hong Kong SAR","World",Activities,"Living","AllProdSyst","AllProdCond")
                 + VImportLivingAnimalsHead.l("China, Macao SAR","World",Activities,"Living","AllProdSyst","AllProdCond")
                 + VImportLivingAnimalsHead.l("China, mainland","World",Activities,"Living","AllProdSyst","AllProdCond")
                 + VImportLivingAnimalsHead.l("China, Taiwan Province of","World",Activities,"Living","AllProdSyst","AllProdCond");

VExportLivingAnimalsHead.l("China","World",Activities,"Living","AllProdSyst","AllProdCond")
                 $(NOT VExportLivingAnimalsHead.l("China","World",Activities,"Living","AllProdSyst","AllProdCond"))
         = VExportLivingAnimalsHead.l("China, Hong Kong SAR","World",Activities,"Living","AllProdSyst","AllProdCond")
                 + VExportLivingAnimalsHead.l("China, Macao SAR","World",Activities,"Living","AllProdSyst","AllProdCond")
                 + VExportLivingAnimalsHead.l("China, mainland","World",Activities,"Living","AllProdSyst","AllProdCond")
                 + VExportLivingAnimalsHead.l("China, Taiwan Province of","World",Activities,"Living","AllProdSyst","AllProdCond");

VImportLivingAnimalsHead.l("China, Hong Kong SAR","World",Activities,"Living","AllProdSyst","AllProdCond") = 0;
VImportLivingAnimalsHead.l("China, Macao SAR","World",Activities,"Living","AllProdSyst","AllProdCond") = 0;
VImportLivingAnimalsHead.l("China, mainland","World",Activities,"Living","AllProdSyst","AllProdCond") = 0;
VImportLivingAnimalsHead.l("China, Taiwan Province of","World",Activities,"Living","AllProdSyst","AllProdCond") = 0;

VExportLivingAnimalsHead.l("China, Hong Kong SAR","World",Activities,"Living","AllProdSyst","AllProdCond") = 0;
VExportLivingAnimalsHead.l("China, Macao SAR","World",Activities,"Living","AllProdSyst","AllProdCond") = 0;
VExportLivingAnimalsHead.l("China, mainland","World",Activities,"Living","AllProdSyst","AllProdCond") = 0;
VExportLivingAnimalsHead.l("China, Taiwan Province of","World",Activities,"Living","AllProdSyst","AllProdCond") = 0;


VImportLivingAnimalsAPU.l("China","World",Activities,"AllProdSyst","AllProdCond")
                 $(NOT VImportLivingAnimalsAPU.l("China","World",Activities,"AllProdSyst","AllProdCond"))
         = VImportLivingAnimalsAPU.l("China, Hong Kong SAR","World",Activities,"AllProdSyst","AllProdCond")
                 + VImportLivingAnimalsAPU.l("China, Macao SAR","World",Activities,"AllProdSyst","AllProdCond")
                 + VImportLivingAnimalsAPU.l("China, mainland","World",Activities,"AllProdSyst","AllProdCond")
                 + VImportLivingAnimalsAPU.l("China, Taiwan Province of","World",Activities,"AllProdSyst","AllProdCond");

VExportLivingAnimalsAPU.l("China","World",Activities,"AllProdSyst","AllProdCond")
                 $(NOT VExportLivingAnimalsAPU.l("China","World",Activities,"AllProdSyst","AllProdCond"))
         = VExportLivingAnimalsAPU.l("China, Hong Kong SAR","World",Activities,"AllProdSyst","AllProdCond")
                 + VExportLivingAnimalsAPU.l("China, Macao SAR","World",Activities,"AllProdSyst","AllProdCond")
                 + VExportLivingAnimalsAPU.l("China, mainland","World",Activities,"AllProdSyst","AllProdCond")
                 + VExportLivingAnimalsAPU.l("China, Taiwan Province of","World",Activities,"AllProdSyst","AllProdCond");

VImportLivingAnimalsAPU.l("China, Hong Kong SAR","World",Activities,"AllProdSyst","AllProdCond") = 0;
VImportLivingAnimalsAPU.l("China, Macao SAR","World",Activities,"AllProdSyst","AllProdCond") = 0;
VImportLivingAnimalsAPU.l("China, mainland","World",Activities,"AllProdSyst","AllProdCond") = 0;
VImportLivingAnimalsAPU.l("China, Taiwan Province of","World",Activities,"AllProdSyst","AllProdCond") = 0;

VExportLivingAnimalsAPU.l("China, Hong Kong SAR","World",Activities,"AllProdSyst","AllProdCond") = 0;
VExportLivingAnimalsAPU.l("China, Macao SAR","World",Activities,"AllProdSyst","AllProdCond") = 0;
VExportLivingAnimalsAPU.l("China, mainland","World",Activities,"AllProdSyst","AllProdCond") = 0;
VExportLivingAnimalsAPU.l("China, Taiwan Province of","World",Activities,"AllProdSyst","AllProdCond") = 0;

*remove the summed category "Sheep and Goats" from imp/exp of living animals:
VImportLivingAnimalsHead.l(Regions,"World","Sheep and Goats","Living","AllProdSyst","AllProdCond") = 0;
VExportLivingAnimalsHead.l(Regions,"World","Sheep and Goats","Living","AllProdSyst","AllProdCond") = 0;


*Remove the elements from the sets
*but this does not work, so keep it...
$ontext;
FAOSTAT_Countries("China, Hong Kong SAR") = NO;
FAOSTAT_Countries("China, Macao SAR") = NO;
FAOSTAT_Countries("China, mainland") = NO;
FAOSTAT_Countries("China, Taiwan Province of") = NO;

FAOSTAT_Countries_2("China, Hong Kong SAR") = NO;
FAOSTAT_Countries_2("China, Macao SAR") = NO;
FAOSTAT_Countries_2("China, mainland") = NO;
FAOSTAT_Countries_2("China, Taiwan Province of") = NO;

MatchFAOSTATCountries_Regions("China, Hong Kong SAR"."China, Hong Kong SAR") = NO;
MatchFAOSTATCountries_Regions("China, Macao SAR"."China, Macao SAR") = NO;
MatchFAOSTATCountries_Regions("China, mainland"."China, mainland") = NO;
MatchFAOSTATCountries_Regions("China, Taiwan Province of"."China, Taiwan Province of") = NO;
$offtext;

execute_unload "FAOSTAT_DetailedTradeMatrix"
VImportQuantity
VExportQuantity
VImportLivingAnimalsHead
VExportLivingAnimalsHead
VImportLivingAnimalsAPU
VExportLivingAnimalsAPU
;

$goto EndOfFile_Trade

$label UseOldTradeFile

$gdxin FAOSTAT_DetailedTradeMatrix.gdx
$load VImportQuantity
$load VExportQuantity
$load VImportLivingAnimalsHead
$load VExportLivingAnimalsHead
$load VImportLivingAnimalsAPU
$load VExportLivingAnimalsAPU
$gdxin


$label EndOfFile_Trade

$ontext;
After this we have the following in SOLm-entities:

VImportQuantity(Regions,Regions_2,Commodities,"AllProdSyst","AllProdCond")
VExportQuantity(Regions,Regions_2,Commodities,"AllProdSyst","AllProdCond")
VImportLivingAnimalsHead(Regions,"World",Activities,"Living","AllProdSyst","AllProdCond")
VExportLivingAnimalsHead(Regions,"World",Activities,"Living","AllProdSyst","AllProdCond")
VImportLivingAnimalsAPU(Regions,"World",Activities,"AllProdSyst","AllProdCond")
VExportLivingAnimalsAPU(Regions,"World",Activities,"AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Regions_2         is      FAOSTAT_Countries_2
Commodities       is      FAOSTAT_DetailedTradeMatrixItems
Activities        is      FAOSTAT_TradeLiveAnimalsItems     for APUs it is "Beehives" only

*XXX STILL TO BE DONE:

There is no trade data on forage crops and grass: but this is neither important in the basic model

*As the following parameter is not currently used here
*Parameter FAOSTAT_TradeCropLivestockProducts(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeCropsAndLivestockProductsItems,FAOSTAT_TradeElements,Years,FAOSTAT_TradeUnits);
do CHECK: whether the trade data in crop livestock products really is identical to the ones from the Commodity Balances.
in any case: this data not yet used is less detailed, as it does not contain the whole trade matrix, but only the total import/export quantities without source and target countries - thus, using the full Trade matrix is better.
$offtext;


