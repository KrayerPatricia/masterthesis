PUTCLOSE con,"_V6_ReadData_CommodityTrees_LinkActivitiesAndCommodities";

*GENERAL DESCRIPTION
*This file contains the code for linking the outputs from Activities to the elements of Commodities
*this is done by means of the commodity trees, extraction rates and shares of processing lines from one parent commodity.
*the basis for this is the FAO document "Technical Conversion Factors for Agricultural Commodities" from 1996

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Define new sets and parameters needed for the commodity tree data
         1.1) Commodity subsets for efficient matching
         1.2) Restricted Commodity-activity matching subsets for efficient matching
- 2) Define new variables capturing commodities in primary product equivalents
- 3) Additional parameters capturing the commodity tree characteristics: share of commodity tree branches and extraction rates
- 4) Transform commodities into main outputs from activities
         4.1) *set 1
              set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
         4.2) *set 2
              set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass)
         4.3) *set 3
              set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)
         4.4) *set 4
              set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass)
         4.5) *set 5
              set MatchCommAct_ComplexAnimalCommodities(Commodities,Activities,OutputsAnimals)
         4.6) *set 6
              set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
              set MatchCommAct_CommodEquivalentAct_Animals(Commodities,Activities,OutputsAnimals)
         4.7) *set 7
              set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
         4.8) Translate into activities
- 5) Define main/coproduct sets etc. used for allocation of impacts
- 6) Assign grass prod act values to grass commodity values


*the following lists all sets defined in this file:
1)
set SubsetCommod_MatchWithAct_AggregateCommodities(Commodities)
set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)

*This captures the cases where commodities correspond to an aggregate of some non primary commodities - for prim prod quantities of outputs from activities, we thus need to disaggregate and to
         translate the commodities to the outputs from activities via commodity trees
*contains crop commodities only, hence only one file needed for crops

2)
set SubsetCommod_MatchWithAct_AggregateActivities(Commodities)
set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass)

*This captures the cases where commodities correspond to prim prod outputs of aggregate activities and thus need to be allocated to outputs from single activities
*contains crop commodities only, hence only one file needed for crops

3)
set SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities)
set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)
*This captures the cases of well defined coproducts
*contains crop commodities only, hence only one file needed for crops

4)
set SubsetCommod_MatchWithAct_ComplexCases(Commodities)
set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass)
*This captures the most complex cases such as fats and alcohol
*contains crop commodities only, hence only one file needed for crops

5)
set SubsetCommod_MatchWithAct_ComplexAnimalCommodities(Commodities)
set MatchCommAct_ComplexAnimalCommodities(Commodities,Activities,OutputsAnimals)
*This covers the more complex animal commodities
*contains animal commodities only, hence only one file needed for animals

6)
set SubsetCommod_MatchWithAct_CommodEquivalentAct(Commodities)
set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
set MatchCommAct_CommodEquivalentAct_Animals(Commodities,Activities,OutputsAnimals)
*This captures all commodities that are equivalent to main outputs from activities

7)
set SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct(Commodities)
set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
*This captures all commodities that are captured together with their derived products and expressed in primary product equivalents
*         this thus captures a number of products derived from one activity in prim prod eq of that activity - thus, linkage commod - act is direct in quantities.
*         BUT: no information on commod composition and thus on nutrient contents - some assumption needed on that. resp. check with nutr reported in FAOSTAT for per cap consumption, for example.
*contains crop commodities only, hence only one file needed for crops



$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Define new sets and parameters needed for the commodity tree data
*1.1) Commodity subsets for efficient matching
*We first need subset of commodities that show different characteristics for the translation into primary products.
*        There are seven such subsets as follows:

$ontext;
1) set SubsetCommod_MatchWithAct_AggregateCommodities(Commodities)
*This captures the cases where commodities correspond to an aggregate of some non primary commodities - for prim prod quantities of outputs from activities, we thus need to disaggregate and to
         translate the commodities to the outputs from activities via commodity trees
2) set SubsetCommod_MatchWithAct_AggregateActivities(Commodities)
*This captures the cases where commodities correspond to prim prod outputs of aggregate activities and thus need to be allocated to outputs from single activities
3) set SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities)
*This captures the cases of well defined coproducts
4) set SubsetCommod_MatchWithAct_ComplexCases(Commodities)
*This captures the most complex cases such as fats and alcohol
5) set SubsetCommod_MatchWithAct_ComplexAnimalCommodities(Commodities)
*This covers the more complex animal commodities
6) set SubsetCommod_MatchWithAct_CommodEquivalentAct(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
7) set SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct(Commodities)
*This captures all commodities that are captured together with their derived products and expressed in primary product equivalents
*         this thus captures a number of products derived from one activity in prim prod eq of that activity - thus, linkage commod - act is direct in quantities.
*         BUT: no information on commod composition and thus on nutrient contents - some assumption needed on that. resp. check with nutr reported in FAOSTAT for per cap consumption, for example.

Thereby,

set 1: These commodities have first to be separated on commodity level to get to non-aggregate commodites,
         then they are further transformed as the corresponding non-aggregate commodity in set 3.
set 2: These commodities have first to be separated on commodity level to get to non-aggregate commodites, that are already equivalent to the outputs from activities
         then they are further transformed to the equivalent output from activities in set 6.
set 3: These commodities are transformed into outputs from activities by means of the detailed information from the adequate commodity trees.
         Here, we thus have to trace byproducts to avoid double-counting and to avoid loosing nutrients, etc.

set 4: no particular rule - but are not that many
set 5: no particular rule - quite a few....

set 6: ok, for this set, Primary product equivalents of main outputs from activities just equal the commodity quantities
set 7: ok, for this set, Primary product equivalents of main outputs from activities just equal the commodity quantities
         However, nutrient contents etc. cannot be derived directly from prim prod quantities, as the commodity is a composition of various products;
                 thus, for this, additional assumptions on the shares are needed, but not for the linkate comoditis to activities
$offtext;

*set 1
set SubsetCommod_MatchWithAct_AggregateCommodities(Commodities)
*This captures the cases where commodities correspond to an aggregate of some non primary commodities - for prim prod quantities of outputs from activities, we thus need to disaggregate and to
*        translate the commodities to the outputs from activities via commodity trees
/
"Beer"
"Brans"
"Bran, Cereals"
"Bran, Pulses"
"Cereals, Other"
*        "Default composition: 68 Popcorn, 89 Buckwheat, 90 Flour, buckwheat, 91 Bran, buckwheat, 92 Quinoa, 94 Fonio, 95 Flour, fonio, 96 Bran, fonio, 97 Triticale, 98 Flour, triticale, 99 Bran, triticale, 101 Canary seed, 103 Grain, mixed,
*        104 Flour, mixed grain, 105 Bran, mixed grains, 108 Cereals, nes, 111 Flour, cereals, 112 Bran, cereals nes, 113 Cereal preparations, nes"
"Citrus, Other"
*This is 2614."Citrus, Other": "Default composition: 512 Fruit, citrus nes, 513 Juice, citrus, single strength, 514 Juice, citrus, concentrated"
"Oilcrops Oil, Other"
*the specification for this is as follows:
*2586."Oilcrops Oil, Other"
*        "Default composition: 264 Butter of karite nuts, 266 Oil, castor beans, 276 Oil, tung nuts, 278 Oil, jojoba, 281 Oil, safflower, 297 Oil, poppy,
*        306 Vegetable tallow, 307 Oil, stillingia, 313 Oil, kapok, 334 Oil, linseed, 337 Oil, hempseed, 340 Oil, vegetable origin nes, 664 Cocoa, butter, 1241 Margarine, liquid, 1242 Margarine, short,
*        1273 Castor oil, hydrogenated (opal wax), 1274 Oil, boiled etc, 1275 Oil, hydrogenated"
"Oilseed Cakes, Other"
*the specification for this is as follows:
*2598."Oilseed Cakes, Other"
*        "Default composition: 37 Cake, rice bran, 61 Cake, maize, 282 Cake, safflower, 298 Cake, poppy seed, 314 Cake, kapok, 335 Cake, linseed, 338 Cake, hempseed, 341 Cake, oilseeds nes"
"Rape and Mustard Cake"
"Rape and Mustard Oil"
"Bread"
"Feed, pulp of fruit"
"Feed, vegetable products nes"
"Flour, cereals"
"Flour, pulses"
"Flour, roots and tubers nes"
"Fruit, dried nes"
"Fruit, prepared nes"
"Juice, citrus, concentrated"
"Juice, citrus, single strength"
"Juice, fruit nes"
"Nuts, prepared (exc. groundnuts)"
"Oilseed Cake Meal"
"Oilseed Cake nes"
"Rape+Mustard Oils"
"Straw husks"
"Vegetables in vinegar"
"Vegetables, canned nes"
"Vegetables, dehydrated"
"Vegetables, dried nes"
"Vegetables, fresh nes"
"Vegetables, fresh or dried products nes"
"Vegetables, frozen"
"Vegetables, homogenized preparations"
"Vegetables, preserved nes"
"Vegetables, preserved, frozen"
"Vegetables, temporarily preserved"
"Breakfast Cereals"
"Flour, Fruit"
"Flour/Meal Of Oilseeds"
"Fruit Tropical Dried Nes"
"Nuts, all, shelled"
"Roots And Tubers Dried"
"Flour, mixed grain"
/;


*set 2
set SubsetCommod_MatchWithAct_AggregateActivities(Commodities)
*This captures the cases where commodities correspond to prim prod outputs of aggregate activities and thus need to be allocated to outputs from single activities
/
"Carrots and turnips"
"Cereals - Excluding Beer"
"Fruits - Excluding Wine"
"Fruits, Other"
"Hard Fibres, Other"
*this is based on the commodity 2667."Hard Fibres, Other"; "Default composition: 800 Agave fibres nes, 813 Coir, 821 Fibre crops nes"
"Jute-Like Fibres"
"Oilcrops"
"Oilcrops, Other"
*the specification for this is as follows:
*2570."Oilcrops, Other"
*        "Default composition: 263 Karite nuts (sheanuts), 265 Castor oil seed, 275 Tung nuts, 277 Jojoba seed, 280 Safflower seed, 296 Poppy seed, 299 Melonseed, 305 Tallowtree seed,
*        310 Kapok fruit, 311 Kapokseed in shell, 312 Kapokseed shelled, 333 Linseed, 336 Hempseed, 339 Oilseeds nes, 343 Flour, oilseeds"
"Pulses"
"Pulses, Other and products"
"Rape and Mustardseed"
"Rape+Mustard Seed"
"Roots & Tuber Dry Equiv"
"Roots, Other"
"Soft-Fibres, Other"
*this is based on 2664."Soft-Fibres, Other": "Default composition: 771 Flax fibre raw, 773 Flax fibre and tow, 774 Flax tow waste, 777 Hemp tow waste, 778 Kapok fibre, 788 Ramie"
"Spices"
"Spices, Other"
*this is based on 2645."Spices, Other": "Default composition: 692 Vanilla, 693 Cinnamon (canella), 702 Nutmeg, mace and cardamoms, 711 Anise, badian, fennel, coriander, 720 Ginger, 723 Spices, nes"
"Starchy Roots"
"Sugar Crops"
"Tobacco & Rubber"
"Treenuts"
"Vegetable Oils"
"Vegetables"
"Vegetables, Other"
*this is defined as follows: 2605."Vegetables, Other"
*        "Default composition: 358 Cabbages and other brassicas, 366 Artichokes, 367 Asparagus, 372 Lettuce and chicory, 373 Spinach, 378 Cassava leaves,
*        393 Cauliflowers and broccoli, 394 Pumpkins, squash and gourds, 397 Cucumbers and gherkins, 399 Eggplants (aubergines), 401 Chillies and peppers, green,
*        402 Onions, shallots, green, 406 Garlic, 407 Leeks, other alliaceous vegetables, 414 Beans, green, 417 Peas, green, 420 Vegetables, leguminous nes, 423 String beans,
*        426 Carrots and turnips, 430 Okra, 446 Maize, green, 447 Sweet corn frozen, 448 Sweet corn prep or preserved, 449 Mushrooms and truffles, 450 Mushrooms, dried,
*        451 Mushrooms, canned, 459 Chicory roots, 461 Carobs, 463 Vegetables, fresh nes, 464 Vegetables, dried nes, 465 Vegetables, canned nes, 466 Juice, vegetables nes,
*        469 Vegetables, dehydrated, 471 Vegetables in vinegar, 472 Vegetables, preserved nes, 473 Vegetables, frozen, 474 Vegetables, temporarily preserved, 475 Vegetables, preserved, frozen,
*        476 Vegetables, homogenized preparations, 567 Watermelons, 568 Melons, other (inc.cantaloupes), 658 Coffee, substitutes containing coffee"
"Vegetal Products"
"Bananas and plantains"
"Berries Nes"
"Cereal preparations, nes"
"Cereals"
"Cereals and Preparations"
"Cereals, breakfast"
"Coffee Green+Roast"
"Forage products"
"Fruit, fresh nes"
"Fruit, tropical fresh nes"
"Hay (clover, lucerne,etc)"
"Hay (unspecified)"
"Oilseeds"
"Oilseeds nes"
"Oranges+Tang+Clem"
"Sugar crops, nes"
"Cereals Nes"
"Citrus, all"
"Fruits, all"
"Hay Non-Leguminous"
"Nuts, all"
"Pulses, all"
"Roots and Tubers, most"
"Roots and tubers, nes"
"Tea Nes"

"Fruit vegetables"
"Nuts, nes"

*new from NFP69
'Leafy vegetables'
'Branch vegetables'
'Root vegetables'
'Cauliflower vegetables'

/;

*set 3
set SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities)
*This captures the cases of well defined coproducts
/
"Coconut Oil"
"Copra Cake"
"Cotton lint"
"Cottonseed"
"Cottonseed Cake"
"Cottonseed Oil"
"Groundnut Cake"
"Groundnut Oil"
"Groundnuts (Shelled Eq)"
"Maize Germ Oil"
"Olive Oil"
"Palm kernels"
"Palm Oil"
"Palmkernel Cake"
"Palmkernel Oil"
"Rice (Milled Equivalent)"
"Ricebran Oil"
"Sesameseed Cake"
"Sesameseed Oil"
"Soyabean Cake"
"Soyabean Oil"
"Sunflowerseed Cake"
"Sunflowerseed Oil"
"Wine"

"Alfalfa meal and pellets"
"Almonds shelled"
"Apricots, dry"
"Barley, pearled"
"Beer of barley"
"Beer Of Maize"
"Beer Of Millet"
"Beer of sorghum"
"Beet pulp"
"Bran, buckwheat"
"Bran, fonio"
"Bran, maize"
"Bran, millet"
"Bran, Rice"
"Bran, sorghum"
"Bran, wheat"
"Brazil nuts, shelled"
"Bulgur"
"Butter of karite nuts"
"Cake, copra"
"Cake, cottonseed"
"Cake, groundnuts"
"Cake, hempseed"
"Cake, kapok"
"Cake, linseed"
"Cake, maize"
"Cake, mustard"
"Cake, palm kernel"
"Cake, rapeseed"
"Cake, rice bran"
"Cake, safflower"
"Cake, sesame seed"
"Cake, soybeans"
"Cake, sunflower"
"Cane tops"
"Cashew nuts, shelled"
"Cashewapple"
"Cassava dried"
"Cocoa, butter"
"Cocoa, paste"
"Cocoa, powder & cake"
"Coconuts, desiccated"
"Cocoons, unreelable & waste"
"Coffee, extracts"
"Coffee, husks and skins"
"Coffee, roasted"
"Copra"
"Cotton linter"
"Cotton waste"
"Cotton, carded, combed"
*this is the following: 846."Feed and meal, gluten"
*        "Generally, by-products of the wet milling of maize. Gluten feed consists of fibres, spent germ and steep liquor.
*        Gluten meal contains endosperm protein fractions that remain following starch recovery."
"Figs dried"
"Flax Fib+Tow+W"
"Flax fibre and tow"
"Flax fibre raw"
"Flax tow waste"

"Flour, fonio"
"Flour, maize"
"Flour, mustard"
"Flour, potatoes"
"Flour, wheat"
"Germ, maize"
"Groundnuts Total Shelled"
"Groundnuts, shelled"
"Hazelnuts, shelled"
"Juice, grape"
"Juice, grapefruit"
"Juice, grapefruit, concentrated"
"Juice, lemon, concentrated"
"Juice, orange, concentrated"
"Juice, orange, single strength"
"Juice, pineapple"
"Juice, pineapple, concentrated"
"Juice, plum, concentrated"
"Juice, plum, single strength"
"Juice, tomato"
"Kapokseed shelled"
"Kapok fibre"
"Kapokseed in shell"
"Macaroni"
"Malt"
"Maple sugar and syrups"
"Mushrooms, canned"
"Oats rolled"
*This is 1274."Oil, boiled etc": "Also includes oxidized and sulphurized oils. Animal and vegetable fats and oils whose chemical structure has been modified to improve viscosity, drying ability or other properties."
"Oil, castor beans"
"Oil, coconut (copra)"
"Oil, cottonseed"
"Oil, groundnut"
"Oil, kapok"
"Oil, linseed"
"Oil, maize"
"Oil, olive residues"
"Oil, olive, virgin"
"Oil, palm"
"Oil, palm kernel"
"Oil, poppy"
"Oil, rapeseed"
"Oil, rice bran"
"Oil, safflower"
"Oil, sesame"
"Oil, soybean"
"Oil, sunflower"
"Olive Oil,Total"
"Pastry"
"Peanut butter"
"Pineapples canned"
"Plums dried (prunes)"
"Popcorn"
"Potato offals"
"Potatoes, frozen"
"Pyrethrum, extraction"
"Raisins"
"Rubber natural dry"
"Silk raw"
"Silk-worm cocoons, reelable"
"Soya curd"
"Soya paste"
"Soya sauce"
"Starch, cassava"
"Sweet corn frozen"
"Sweet corn prep or preserved"
"Tea, mate extracts"
"Tobacco products nes"
"Tomatoes, paste"
"Tomatoes, peeled"
"Vegetable tallow"
"Walnuts, shelled"
"Wheat+Flour,Wheat Equivalent"
"Applejuice Single Streng"
"Applejuice Concentrated"
"Bagasse"
"Barley Flour And Grits"
"Beet Sugar"
"Beet Tops"
"Bran, Barley"
"Bran, Mixed Grain"
"Bran, Oats"
"Bran, Rye"
"Bran, Triticale"
"Cake, Palm Kernels"
"Cake Of Poppy Seed"
"Cane Sugar"
"Cassava Tapioca"
"Cocoa Husks+Shell"
"Coir"
"Flour, Buckwheat"
"Flour, Cassava"
"Flour, Millet"
"Flour, Rye"
"Flour, Sorghum"
"Flour, Triticale"
"Germ, Wheat"
"Prepared Groundnuts"
"Hemp Fibre And Tow"
"Hempseed"
"Jojoba Oil"
"Leaves And Tops, Vines"
"Lemonjuice Single-Streng"
"Maize Gluten"
"Malt Extracts"
"Mango Juice"
"Mango Pulp"
"Marc Of Grapes"
"Milled Paddy Rice"
"Dried Mushrooms"
"Must Of Grapes"
"Oil, Hempseed"
"Oil, Mustard Seed"
"Olive Residues"
"Plums, Dried (Prunes)"
"Pot Barley"
"Potato Starch"
"Potato Tapioca"
"Pyrethrum Marc"
"Rice, Broken"
"Rice Flour"
"Rice Gluten"
"Rice, Husked"
"Milled/Husked Rice"
"Rice, Starch"
"Starch Of Maize"
"Tangerine Juice"
"Tomatojuice Concentrated"
"Tung Oil"
"Wheat Fermented Beverage"
"Wheat Gluten"
"Wheat Starch"

*new main and co products added by Adrian Muller to better capture commpodity trees, etc.
*new co-prod: Level1
"Rice hulls"
"Groundnut shells"
"Beer of Shorgum dregs"
"Cocoa husks"
"Karite nut cake"
"Almond shells"
"Apricot kernel"
"Chestnut shells"
"Coconut shells"
"Cashew nut shells"
"Brazil nut shells"
"Tomato pulp"
"Grape pulp"
"Grapefruit pulp"
"Lemon pulp"
"Orange pulp"
"Pineapple pulp"
"Plum pulp"
"Hazelnut shells"
"Castor bean cake"
"Walnut shells"
"Apple pulp"
"Jojoba cake"
"Tangerine pulp"
"Tung nut cake"
"Molasse from cane"
"Molasse from beet"
*New main prod:level 1
"Oat flour"
"Cocoa paste"
*new co-prod Level2
"Beer of Barley dregs"
"Kapokseed shells"
"Pressed olive residues"
*new MAIN prod Level2
"Palm kernel oil"
"Wheat dregs"
"Oil palm fruit pulp"

"Chestnut"

*from NFP69
"Flour, Spelt"
"Bran, Spelt"
/;

*set 4
set SubsetCommod_MatchWithAct_ComplexCases(Commodities)
*The following captures the most complex cases such as fats and alcohol
/
"Alcohol, Non-Food"
"Alcoholic Beverages"
"Beverages, Alcoholic"
"Beverages, Fermented"
"Molasses"
"Molasses (sugar cane)"
"Molasses (sugar beet)"
"Sugar & Sweeteners"
"Sugar (Raw Equivalent)"
"Sugar non-centrifugal"
*cf: 2541."Sugar non-centrifugal" resp. 163."Sugar non-centrifugal"
"Sugar, Raw Equivalent"
*this covers more in contrast to the other sugar elements: it is defined as follows:
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes,
*        162 Sugar Raw Centrifugal, 163 Sugar non-centrifugal, 166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose"
"Sugar, Refined Equiv"
"Sugar, Refined Equiv (sugar cane)"
"Sugar, Refined Equiv (sugar beet)"
"Sweeteners, Other"
*This is 2543."Sweeteners, Other"
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes, 165 Molasses,
*        166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose, 175 Isoglucose, 633 Beverages, non alcoholic"
"Beverages"
"Beverages, distilled alcoholic"
"Beverages, fermented rice"
"Beverages, non alcoholic"
"Beverages+Tobacco"
"Chocolate products nes"
"Cider etc"
"Cigarettes"
"Cigars, cheroots"
"Coffee, substitutes containing coffee"
"Dregs from brewing, distillation"
"Feed and meal, gluten"
*this is the following: 846."Feed and meal, gluten"
*        "Generally, by-products of the wet milling of maize. Gluten feed consists of fibres, spent germ and steep liquor.
*        Gluten meal contains endosperm protein fractions that remain following starch recovery."
"Fixed Vegetable Oils"
"Fructose and syrup, other"
"Fruit, cooked, homogenized preparations"
"Glucose and dextrose"
"Margarine, liquid"
"Margarine, short"
"Oil, boiled etc"
*This is 1274."Oil, boiled etc": "Also includes oxidized and sulphurized oils. Animal and vegetable fats and oils whose chemical structure has been modified to improve viscosity, drying ability or other properties."
"Oil, essential nes"
"Sugar Raw Centrifugal"
"Sugar refined"
"Alcohol Non Food Purpose"
"Oils Hydrogenated"
*added specifically as a co-prod:
"Oil cakes - various"

*from NFP69
Seasoning
"CoProds Seasoning"
/;


*set 5
set SubsetCommod_MatchWithAct_ComplexAnimalCommodities(Commodities)
*the following covers the more complex animal commodities
/
"Animal Products"
*"Bovine Meat"
*        complex description in FAOSTAT - for simplicity, we take it identical to cattle meat and add it to the corresponding subset
"Butter, Ghee"
"Cheese"
"Cream"
*"Eggs"
*        complex description in FAOSTAT - for simplicity, we take it identical to Chicken eggs and add it to the corresponding subset
"Fish Meal"
*this is 2855."Fish Meal" and thus covers all seafood:
*        "Default composition: 1511 Freshwater Meal Fr Offal, 1524 Demersal Meal from Offal, 1537 Pelagic Meal from Offal, 1550 Marn Meal Of, 1559 Crustaceans Meal F Offal,
*        1567 Molluscs Meal from Offal, 1576 Cephalopods Meal F Offal, 1581 Aquatic Mammals Meals, 1584 Aqua Mammal Meal F Offal, 1591 Aq A Meal Of"
"Fish, Body Oil"
*this is 2781."Fish, Body Oil" and thus covers fish and marine mammals
*        "Default composition: 1509 Frwt Bdy Oil, 1522 Dmrs Bdy Oil, 1535 Pelg Bdy Oil, 1548 Marn Bdy Oil, 1582 Aq M Oils"
"Fish, Liver Oil"
*2782."Fish, Liver Oil" and thus covers fish and marine mammals
*        "Default composition: 1510 Frwt Lvr Oil, 1523 Demersal Liver Oils, 1536 Pelg Lvr Oil, 1549 Marine nes Liver Oils"
"Hides and skins"
"Meat Meal"
"Milk, Skimmed"
"Whey"
"Animal Oil+Fat+Grs"
"Animal Vegetable Oil"
"Bacon and ham"
"Butter"
"Butter, cow milk"
"Buttermilk, curdled, acidified milk"
"Canned Meat nes"
"Cheese and Curd"
"Cheese, processed"
"Cheese, sheep milk"
"Cheese, whole cow milk"
"Cream fresh"
"Eggs Liquid,Dried"
"Eggs, dried"
"Eggs, liquid"
"Fat, liver prepared (foie gras)"
*This is needed to match 1060."Fat, liver prepared (foie gras)" with activities:
*        "Fatty livers of ducks and geese when cooked, prepared or preserved(e.g. patâ€š)."
"Fat, nes, prepared"
"Fatty acids"
"Fatty substance residues"
"Ghee, of buffalo milk"
"Grease incl. lanolin wool"
"Lactose"
"Lard"
"Meal, meat"
"Meat and Meat Preparations"
"Meat Fresh+Ch+Frozen"
"Meat Prepared Pres"
"Meat, beef and veal sausages"
"Meat, beef, preparations"
"Meat, cattle, boneless (beef & veal)"
"Meat, chicken, canned"
"Meat, dried nes"
"Meat, pig sausages"
"Meat, pig, preparations"
"Meat, pork"
"Milk Condensed + Evaporated"
"Milk Condensed+Dry+Fresh"
"Milk Dry"
"Milk Equivalent"
"Milk, products of natural constituents nes"
"Milk, reconstituted"
"Milk, skimmed cow"
"Milk, skimmed dried"
"Milk, whole condensed"
"Milk, whole dried"
"Milk, whole evaporated"
"Oils, fats of animal nes"
"Whey, condensed"
"Whey, dry"
"Whey, Pres+Concen"
"Wool, hair waste"
"Yoghurt, concentrated or not"
"Animals live nes"
"Asses"
"Beehives"
"Buffaloes"
"Camelids, other"
"Camels"
"Cattle"
"Chickens"
"Ducks"
"Goats"
"Horses"
"Mules"
"Pigs"
"Rabbits and hares"
"Rodents, other"
"Sheep"
"Turkeys"
"Beef Canned"
"Beef Dried Salt Smoked"
"Blood Meal"
"Butter Of Buffalo Milk"
"Butter Of Goat Milk"
"Butter+Ghee (Sheep Milk)"
"Dry Buttermilk"
"Casein"
"Cheese Of Buffalo Milk"
"Cheese Of Goat Milk"
"Cheese (Skim Cow Milk)"
"Game"
"Geese"
"Geese and guinea fowls"
"Ghee, of cow milk"
"Whey Cheese"
"Whey, Fresh"
"Wool Shoddy"
"Yoghurt"

*the butcher fat is the co-product from meat, other fats are parts of the liveweight COMPLEMENTING meat and offals
"Cattle Butcher Fat"
"Pig Butcher Fat"

"Fat, Poultry Rendered"
"Lard And Stearine Oil"
"Live Animals Nes"
"Meat Extracts"
"Meat Prepared Nes"
"Oils Fish And Marine Mam"
"Other birds for eggs"

"Skim Milk, Condensed"
"Skim Milk, Evaporated"
"Skim Milk Of Buffalo"
"Skim Milk Of Goat"
"Skim Sheep Milk"


*from NFP69
'Hard cheese'
'Semihard cheese'
'Soft cheese'

/;



*set 6
set SubsetCommod_MatchWithAct_CommodEquivalentAct(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Abaca"
"Bananas"
"Beans"
"Cashew nuts, with shell"
"Cloves"
"Dates"
"Groundnuts (in Shell Eq)"
"Hemp Fibre And Tow"
"Hempseed"
"Jute"
"Oats"
"Oil Palm Fruit"
"Olives (including preserved)"
"Onions"
"Oranges, Mandarines"
"Peas"
"Pepper"
"Pimento"
*!!XXXXX    !!CAREFUL, if "Chillies and peppers, dry" is also a ailable as commodity!! - how to deal with this??
"Plantains"
"Rice, Paddy"
"Rice (Paddy Equivalent)"
"Rubber"
"Sesame seed"
"Sisal"
"Soyabeans"
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Sweet potatoes"
"Tea (including mate)"
"Tobacco"
"Yams"
"Aquatic Animals, Others"
"Aquatic Plants"
"Aquatic Products, Other"
"Cephalopods"
"Crustaceans"
"Demersal Fish"
"Freshwater Fish"
"Honey"
"Marine Fish, Other"
"Milk, Whole"
"Molluscs, Other"
"Pelagic Fish"
"Pigmeat"
"Poultry Meat"
"Silk"
"Wool (Clean Eq.)"
"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Forage Products Nes"
"Beets For Fodder"
"Swedes For Fodder"
"Turnips For Fodder"
"Vegetables+Roots,Fodder"

Fallows

"Grass"

"Temporary meadows and pastures"
"Permanent meadows and pastures"

"temporary grasslands"
"permanent grasslands"
"alpine pastures"

"Anise, badian, fennel, coriander"
"Apples"
"Apricots"
"Artichokes"
"Asparagus"
"Avocados"
"Bambara beans"
"Barley"
"Beans, dry"
"Beans, green"
"Beeswax"
"Blueberries"
"Broad beans, horse beans, dry"
"Buckwheat"
"Cabbages and other brassicas"
"Canary seed"
"Cassava"
"Cauliflowers and broccoli"
"Cherries"
"Cherries, sour"
"Chestnut"
"Chick peas"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cinnamon (canella)"
"Cocoa, beans"
"Coconuts"
"Coffee, green"
"Cranberries"
"Cucumbers and gherkins"
"Currants"
"Eggplants (aubergines)"
"Eggs, hen, in shell"
"Fonio"
"Forage and silage, clover"
"Forage and silage, grasses nes"
"Forage and silage, legumes"
"Garlic"
"Ginger"
"Gooseberries"
"Grain, mixed"
"Grapefruit (inc. pomelos)"
"Grapes"
"Honey, natural"
"Hops"
"Jute+Bast Fibres"
"Kiwi fruit"
"Kola nuts"
"Leeks, other alliaceous vegetables"
"Lemons and limes"
"Lentils"
"Lettuce and chicory"
"Linseed"
"Maize"
"Maize, green"
"Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"
"Maté"
"Meat of Swine"
"Meat Poultry Fresh"
"Meat Sheep Fresh"
"Meat, ass"
"Meat, cattle"
"Meat, chicken"
"Meat, duck"
"Meat, game"
"Meat, goat"
"Meat, goose and guinea fowl"
"Meat, horse"
"Meat, pig"
"Meat, pork"
"Meat, rabbit"
"Meat, sheep"
"Meat, turkey"
"Melons, other (inc.cantaloupes)"
"Millet"
"Mushrooms and truffles"
"Mustard seed"
"Natural Rubber"
"Nutmeg, mace and cardamoms"
"Olives"
"Olives preserved"
"Onions, dry"
"Onions, shallots, green"
"Oranges"
"Oth Citrus Frt"
"Papayas"
"Peaches and nectarines"
"Pears"
"Peas, dry"
"Peas, green"
"Pepper (piper spp.)"
"Peppermint"
"Persimmons"
"Pineapples"
"Pistachios"
"Plantains and others"
"Plums and sloes"
"Poppy seed"
"Potatoes"
"Pumpkins, squash and gourds"
"Pyrethrum, dried"
"Quinces"
"Rapeseed"
"Rice"
"Rubber, natural"
"Rye"
"Sorghum"
"Soybeans"
"Spices, nes"
"Spinach"
"Strawberries"
*"Sunflower seed"
"Tangerines, mandarins, clementines, satsumas"
"Tea"
"Tobacco, unmanufactured"
"Tomatoes"
"Triticale"
"Vanilla"
"Vetches"
"Walnuts, with shell"
"Watermelons"
"Wheat"
"Agave Fibres Nes"
"Almonds"
"Areca Nuts (Betel)"
"Biological Ass Meat"
"Biological Buffalo Meat"
"Biological Camel Meat"
"Biological Cattle Meat"
"Biological Chicken Meat"
"Biological Duck Meat"
"Biological Geese Meat"
"Biological Goat Meat"
"Biological Horse Meat"
"Biological Mule Meat"
"Biological Other Camel"
"Biological Other Poultry"
"Biological Pig Meat"
"Biological Rodents"
"Biological Sheep Meat"
"Biological Turkey Meat"
"Brazil Nuts"
"Broad Beans, Green"
"Buffalo Meat"
"Buffalo Milk"
"Camel Milk"
"Carobs"
"Cassava Leaves"
"Castor Beans"
"Chicory Roots"
"Citrus Fruit Nes"
"Cow Peas, Dry"
"Fibre Crops Nes"
"Goat Milk"
"Groundnuts In Shell"
"Indigenous Ass Meat"
"Indigenous Buffalo Meat"
"Indigenous Camel Meat"
"Indigenous Cattle Meat"
"Indigenous Chicken Meat"
"Indigenous Duck Meat"
"Indigenous Geese Meat"
"Indigenous Goat Meat"
"Indigenous Horse Meat"
"Indigenous Mule Meat"
"Indigenous Other Camel"
"Indigenous Pigmeat"
"Indigenous Rodents"
"Indigenous Sheep Meat"
"Indigenous Turkey Meat"
"Kapok Fruit"
"Karite Nuts (Sheanuts)"
"Lupins"
"Mate"
"Meat, Asses"
"Meat, Camels"
"Meat, Mules"
"Meat, Other Camelids"
"Meat, Other Rodents"
"Meat, Pigeon Oth.Birds"
"Melonseed"
"Natural Gums"
"Okra"
"Other Rodents"
"Pigeon Peas"
"Pigeons, Other Birds"
"Pome Fruit Nes, Fresh"
"Pulses Nes"
"Quinoa"
"Ramie"
"Raspberries"
"Safflower Seed"
"Seed cotton"
"Silkworms"
"Spermaceti"
"Stone Fruit Nes, Fresh"
"String Beans"
"Tallowtree Seeds"
"Taro (Coco Yam)"
"Tung Nuts"
"Yautia (Cocoyam)"

*added from Set 5
"Fish, Seafood"
"Bovine meat"
"Eggs"
"Animal fats"
"Offals"
"Offals, Edible"
"Fats, Animals, Raw"
"Fat, camels"
"Fat, cattle"
"Fat, pigs"
"Meat"
"Meat, Aquatic Mammals"
"Meat, Other"
"Milk - Excluding Butter"
"Mutton & Goat Meat"
"Eggs in The Shell"
"Eggs, other bird, in shell"
"Hair, fine"
*this is 1218."Hair, fine": "Fine animal hair, mainly from alpaca, llama, vicuÂ¤a, camel and angora rabbit. Excludes carded or combed hair."
"Hair, goat, coarse"
"Hides, buffalo, dry salted"
"Hides, buffalo, fresh"
"Hides, buffalo, wet salted"
"Hides, camel, nes"
"Hides, camel, wet salted"
"Hides, cattle, fresh"
"Hides, cattle, wet salted"
"Hides, horse, dry salted"
"Hides, nes"
"Meat Bovine Fresh"
"Milk Fresh"
"Milk, whole fresh cow"
"Milk, whole fresh sheep"
"Offals Edibl Fresh"
"Offals, edible, cattle"
"Offals, edible, goats"
"Offals, liver chicken"
"Offals, liver duck"
"Offals, liver geese"
"Offals, other camelids"
"Offals, pigs, edible"
"Offals, sheep,edible"
"Other Meat"
"Ovine Meat"
"Skins, calve, wet salted"
"Skins, goat, fresh"
"Skins, goat, wet salted"
"Skins, sheep, dry salted"
"Skins, sheep, fresh"
"Skins, sheep, wet salted"
"Skins, sheep, with wool"
"Total Meat"
"Wool, degreased"
"Wool, greasy"
"Camel Hides, Fresh"
"Fat, Buffalo"
"Fat, Goats"
"Fat, Other Camelids"
"Fat, Poultry"
"Fat Of Sheep"
"Fine Goat Hair"
"Hair Of Horses"
"Hide Dry-Salted"
"Hide Wet-Salted"
"Hides, camel, dry salted"
"Hides, cattle, dry salted"
"Hides Nes Cattle"
"Hides Of Asses Fresh"
"Hides Of Mules Fresh"
"Hides Unspecified Horses"
"Hides, horse, wet salted"
"Homogenized Meat Prep."
"Horse Hides, Fresh"
"Offals Liver Turkeys"
"Offals Nes"
"Offals, edible, Buffalo"
"Offals, edible, Camel"
"Offals, Horse"
"Eggs Excl Hen"
"Pigskins, Fresh"
"Rabbit Meat Biological"
"Rabbit Meat Indigenous"
"Rabbit Skins"
"Skins, pig, dry salted"
"Skin Nes Pigs"
"Skin Nes Sheep"
"Skins, pig, wet salted"
"Skins Dry-Salt Calves"
"Skins Dry-Salted Goats"
"Skins Fresh Of Calves"
"Skins Nes Calves"
"Skins Nes Goats"
"Standardized Milk"


*from NFP69
'Salt'
'Water'

/;

*set 7
set SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct(Commodities)
*This captures all commodities that are captured together with their derived products and expressed in primary product equivalents
*         this thus captures a number of products derived from one activity in prim prod eq of that activity - thus, linkage commod - act is direct in quantities.
*         BUT: no information on commod composition and thus on nutrient contents - some assumption needed on that. resp. check with nutr reported in FAOSTAT for per cap consumption, for example.
/
"Apples and products"
"Barley and products"
"Cassava and products"
"Cassava Equivalent"
"Cocoa Beans and products"
"Coconuts - Incl Copra"
"Coffee and products"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Lemons, Limes and products"
"Maize and products"
"Millet and products"
"Nuts and products"
"Pineapples and products"
"Potatoes and products"
"Rice - total  (Rice milled equivalent)"
"Rye and products"
"Sorghum and products"
"Tomatoes and products"
"Wheat and products"
/;

*1.2) Restricted Commodity-activity matching subsets for efficient matching
*to easier work with those commodity subsets, we also generate corresponding subsets of the commodities matched to activities and output types:
*these are the following 7 subsets:

$ontext;
*set 1
set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
*This captures the cases where commodities correspond to an aggregate of some non primary commodities - for prim prod quantities of outputs from activities, we thus need to disaggregate and to
*         translate the commodities to the outputs from activities via commodity trees
*contains crop commodities only, hence only one file needed for crops

*set 2
set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass)
*This captures the cases where commodities correspond to prim prod outputs of aggregate activities and thus need to be allocated to outputs from single activities
*contains crop commodities only, hence only one file needed for crops

*set 3
set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)
*This captures the cases of well defined coproducts
*contains crop commodities only, hence only one file needed for crops

*set 4
set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass)
*This captures the most complex cases such as fats and alcohol
*contains crop commodities only, hence only one file needed for crops

*set 5
set MatchCommAct_ComplexAnimalCommodities(Commodities,Activities,OutputsAnimals)
*This covers the more complex animal commodities
*contains animal commodities only, hence only one file needed for animals

*set 6
*the following covers crop and animal commodities, hence the need for two matching files
set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
set MatchCommAct_CommodEquivalentAct_Animals(Commodities,Activities,OutputsAnimals)
*This captures all commodities that are equivalent to main outputs from activities

*set 7
set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
*contains crop commodities only, hence only one file needed for crops
*This captures all commodities that are captured together with their derived products and expressed in primary product equivalents
*         this thus captures a number of products derived from one activity in prim prod eq of that activity - thus, linkage commod - act is direct in quantities.
*         BUT: no information on commod composition and thus on nutrient contents - some assumption needed on that. resp. check with nutr reported in FAOSTAT for per cap consumption, for example.

$offtext;

*set 1
set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass) "Set with the cases where commodities correspond to an aggregate of some non primary commodities"
*This captures the cases where commodities correspond to an aggregate of some non primary commodities - for prim prod quantities of outputs from activities, we thus need to disaggregate and to
*         translate the commodities to the outputs from activities via commodity trees
*contains crop commodities only, hence only one file needed for crops
/
*"Beer"."All Cereals"."MainOutput1 (t)"
"Beer"."Barley"."MainOutput1 (t)"
*"Brans"."All Cereals"."MainOutput1 (t)"
"Brans"."Wheat"."MainOutput1 (t)"
*"Bran, Cereals"."All Cereals"."MainOutput1 (t)"
"Bran, Cereals"."Wheat"."MainOutput1 (t)"
"Bran, Pulses"."Pulses,Total"."MainOutput1 (t)"
"Cereals, Other"."Other Cereals"."MainOutput1 (t)"
*        "Default composition: 68 Popcorn, 89 Buckwheat, 90 Flour, buckwheat, 91 Bran, buckwheat, 92 Quinoa, 94 Fonio, 95 Flour, fonio, 96 Bran, fonio, 97 Triticale, 98 Flour, triticale, 99 Bran, triticale, 101 Canary seed, 103 Grain, mixed,
*        104 Flour, mixed grain, 105 Bran, mixed grains, 108 Cereals, nes, 111 Flour, cereals, 112 Bran, cereals nes, 113 Cereal preparations, nes"
"Citrus, Other"."All other citrus"."MainOutput1 (t)"
*This is 2614."Citrus, Other": "Default composition: 512 Fruit, citrus nes, 513 Juice, citrus, single strength, 514 Juice, citrus, concentrated"
*"Oilcrops Oil, Other"."All other oilcrops"."MainOutput1 (t)"
"Oilcrops Oil, Other"."Safflower seed"."MainOutput1 (t)"
*the specification for this is as follows:
*2586."Oilcrops Oil, Other"
*        "Default composition: 264 Butter of karite nuts, 266 Oil, castor beans, 276 Oil, tung nuts, 278 Oil, jojoba, 281 Oil, safflower, 297 Oil, poppy,
*        306 Vegetable tallow, 307 Oil, stillingia, 313 Oil, kapok, 334 Oil, linseed, 337 Oil, hempseed, 340 Oil, vegetable origin nes, 664 Cocoa, butter, 1241 Margarine, liquid, 1242 Margarine, short,
*        1273 Castor oil, hydrogenated (opal wax), 1274 Oil, boiled etc, 1275 Oil, hydrogenated"
*"Oilseed Cakes, Other"."All crops producing oilseed cake"."MainOutput1 (t)"
"Oilseed Cakes, Other"."Safflower seed"."MainOutput1 (t)"
*the specification for this is as follows:
*2598."Oilseed Cakes, Other"
*        "Default composition: 37 Cake, rice bran, 61 Cake, maize, 282 Cake, safflower, 298 Cake, poppy seed, 314 Cake, kapok, 335 Cake, linseed, 338 Cake, hempseed, 341 Cake, oilseeds nes"
*"Rape and Mustard Cake"."Rape and Mustard seed"."MainOutput1 (t)"
"Rape and Mustard Cake"."Rapeseed"."MainOutput1 (t)"
*"Rape and Mustard Oil"."Rape and Mustard seed"."MainOutput1 (t)"
"Rape and Mustard Oil"."Rapeseed"."MainOutput1 (t)"
*"Bread"."All Cereals"."MainOutput1 (t)"
"Bread"."Wheat"."MainOutput1 (t)"
"Feed, pulp of fruit"."All Fruits"."MainOutput1 (t)"
"Feed, vegetable products nes"."All Crops"."MainOutput1 (t)"
*"Flour, cereals"."All Cereals"."MainOutput1 (t)"
"Flour, cereals"."Wheat"."MainOutput1 (t)"
"Flour, pulses"."Pulses,Total"."MainOutput1 (t)"
"Flour, roots and tubers nes"."Roots and tubers, nes"."MainOutput1 (t)"
"Fruit, dried nes"."All Fruits"."MainOutput1 (t)"
"Fruit, prepared nes"."Fruit, fresh nes"."MainOutput1 (t)"
*"Juice, citrus, concentrated"."Citrus Fruits"."MainOutput1 (t)"
"Juice, citrus, concentrated"."Oranges"."MainOutput1 (t)"
*"Juice, citrus, single strength"."Citrus Fruits"."MainOutput1 (t)"
"Juice, citrus, single strength"."Oranges"."MainOutput1 (t)"
"Juice, fruit nes"."All Fruits"."MainOutput1 (t)"
"Nuts, prepared (exc. groundnuts)"."Nuts, nes"."MainOutput1 (t)"
"Oilseed Cake Meal"."All Oilcrops"."MainOutput1 (t)"
"Oilseed Cake nes"."All Oilcrops"."MainOutput1 (t)"
*"Rape+Mustard Oils"."Rape and Mustard seed"."MainOutput1 (t)"
"Rape+Mustard Oils"."Rapeseed"."MainOutput1 (t)"
*"Straw husks"."All Cereals"."MainOutput1 (t)"
"Straw husks"."Wheat"."MainOutput1 (t)"
"Vegetables in vinegar"."All Vegetables"."MainOutput1 (t)"
"Vegetables, canned nes"."All Vegetables"."MainOutput1 (t)"
"Vegetables, dehydrated"."All Vegetables"."MainOutput1 (t)"
"Vegetables, dried nes"."All Vegetables"."MainOutput1 (t)"
"Vegetables, fresh nes"."Vegetables, fresh nes"."MainOutput1 (t)"
"Vegetables, fresh or dried products nes"."All Vegetables"."MainOutput1 (t)"
"Vegetables, frozen"."All Vegetables"."MainOutput1 (t)"
"Vegetables, homogenized preparations"."All Vegetables"."MainOutput1 (t)"
"Vegetables, preserved nes"."All Vegetables"."MainOutput1 (t)"
"Vegetables, preserved, frozen"."All Vegetables"."MainOutput1 (t)"
"Vegetables, temporarily preserved"."All Vegetables"."MainOutput1 (t)"
"Breakfast Cereals"."All Cereals"."MainOutput1 (t)"
"Flour, Fruit"."All Fruits"."MainOutput1 (t)"
"Flour/Meal Of Oilseeds"."All Oilcrops"."MainOutput1 (t)"
"Fruit Tropical Dried Nes"."Fruit, tropical fresh nes"."MainOutput1 (t)"
"Nuts, all, shelled"."All Nuts"."MainOutput1 (t)"
"Roots And Tubers Dried"."Roots and tubers,Total"."MainOutput1 (t)"
"Flour, mixed grain"."Grain, mixed"."MainOutput1 (t)"
/;

*set 2
set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass) "Set with the cases where commodities correspond to prim prod outputs of aggregate activities"
*This captures the cases where commodities correspond to prim prod outputs of aggregate activities and thus need to be allocated to outputs from single activities
*contains crop commodities only, hence only one file needed for crops
/
"Carrots and turnips"."Carrots and turnips"."MainOutput1 (t)"
*"Cereals - Excluding Beer"."All Cereals"."MainOutput1 (t)"
"Cereals - Excluding Beer"."Wheat"."MainOutput1 (t)"
*assume all are just eaten without further processing (alternatives: juice, canned, etc. - but for now, leave this away)
"Fruits - Excluding Wine"."All Fruits"."MainOutput1 (t)"
"Fruits, Other"."All Fruits"."MainOutput1 (t)"
"Hard Fibres, Other"."All other hard fibres"."MainOutput1 (t)"
*this is based on the commodity 2667."Hard Fibres, Other"; "Default composition: 800 Agave fibres nes, 813 Coir, 821 Fibre crops nes"
"Jute-Like Fibres"."Jute & Jute-like Fibres"."MainOutput1 (t)"
"Oilcrops"."All Oilcrops"."MainOutput1 (t)"
"Oilcrops, Other"."All other oilcrops"."MainOutput1 (t)"
*the specification for this is as follows:
*2570."Oilcrops, Other"
*        "Default composition: 263 Karite nuts (sheanuts), 265 Castor oil seed, 275 Tung nuts, 277 Jojoba seed, 280 Safflower seed, 296 Poppy seed, 299 Melonseed, 305 Tallowtree seed,
*        310 Kapok fruit, 311 Kapokseed in shell, 312 Kapokseed shelled, 333 Linseed, 336 Hempseed, 339 Oilseeds nes, 343 Flour, oilseeds"
"Pulses"."Pulses,Total"."MainOutput1 (t)"
"Pulses, Other and products"."Pulses,Total"."MainOutput1 (t)"
"Rape and Mustardseed"."Rape and Mustard seed"."MainOutput1 (t)"
"Rape+Mustard Seed"."Rape and Mustard seed"."MainOutput1 (t)"
"Roots & Tuber Dry Equiv"."All roots and tubers"."MainOutput1 (t)"
"Roots, Other"."All other roots"."MainOutput1 (t)"
"Soft-Fibres, Other"."All other soft fibres"."MainOutput1 (t)"
*this is based on 2664."Soft-Fibres, Other": "Default composition: 771 Flax fibre raw, 773 Flax fibre and tow, 774 Flax tow waste, 777 Hemp tow waste, 778 Kapok fibre, 788 Ramie"
"Spices"."All spices"."MainOutput1 (t)"
"Spices, Other"."All other Spices"."MainOutput1 (t)"
*this is based on 2645."Spices, Other": "Default composition: 692 Vanilla, 693 Cinnamon (canella), 702 Nutmeg, mace and cardamoms, 711 Anise, badian, fennel, coriander, 720 Ginger, 723 Spices, nes"
"Starchy Roots"."All starchy roots"."MainOutput1 (t)"
"Sugar Crops"."All sugar crops"."MainOutput1 (t)"
"Tobacco & Rubber"."Rubber, natural"."MainOutput1 (t)"
"Treenuts"."Treenuts,Total"."MainOutput1 (t)"
"Vegetable Oils"."All Crops"."MainOutput1 (t)"
"Vegetables"."All Vegetables"."MainOutput1 (t)"
"Vegetables, Other"."All other vegetables"."MainOutput1 (t)"
*this is defined as follows: 2605."Vegetables, Other"
*        "Default composition: 358 Cabbages and other brassicas, 366 Artichokes, 367 Asparagus, 372 Lettuce and chicory, 373 Spinach, 378 Cassava leaves,
*        393 Cauliflowers and broccoli, 394 Pumpkins, squash and gourds, 397 Cucumbers and gherkins, 399 Eggplants (aubergines), 401 Chillies and peppers, green,
*        402 Onions, shallots, green, 406 Garlic, 407 Leeks, other alliaceous vegetables, 414 Beans, green, 417 Peas, green, 420 Vegetables, leguminous nes, 423 String beans,
*        426 Carrots and turnips, 430 Okra, 446 Maize, green, 447 Sweet corn frozen, 448 Sweet corn prep or preserved, 449 Mushrooms and truffles, 450 Mushrooms, dried,
*        451 Mushrooms, canned, 459 Chicory roots, 461 Carobs, 463 Vegetables, fresh nes, 464 Vegetables, dried nes, 465 Vegetables, canned nes, 466 Juice, vegetables nes,
*        469 Vegetables, dehydrated, 471 Vegetables in vinegar, 472 Vegetables, preserved nes, 473 Vegetables, frozen, 474 Vegetables, temporarily preserved, 475 Vegetables, preserved, frozen,
*        476 Vegetables, homogenized preparations, 567 Watermelons, 568 Melons, other (inc.cantaloupes), 658 Coffee, substitutes containing coffee"
"Vegetal Products"."All Crops"."MainOutput1 (t)"
"Bananas and plantains"."Bananas and plantains"."MainOutput1 (t)"
"Berries Nes"."Berries nes"."MainOutput1 (t)"
"Cereals"."All Cereals"."MainOutput1 (t)"
"Cereals and Preparations"."All Cereals"."MainOutput1 (t)"
"Cereals, breakfast"."All Cereals"."MainOutput1 (t)"
"Forage products"."Forage Products Nes"."MainOutput1 (t)"
"Fruit, fresh nes"."Fruit, fresh nes"."MainOutput1 (t)"
"Fruit, tropical fresh nes"."Fruit, tropical fresh nes"."MainOutput1 (t)"
"Hay (clover, lucerne,etc)"."Leguminous Nes,For+Sil"."MainOutput1 (t)"
"Hay (unspecified)".Grass."MainOutput1 (t)"
"Oilseeds"."All Oilcrops"."MainOutput1 (t)"
"Oilseeds nes"."Oilseeds nes"."MainOutput1 (t)"
"Oranges+Tang+Clem"."Oranges"."MainOutput1 (t)"
"Sugar crops, nes"."Sugar crops, nes"."MainOutput1 (t)"
"Cereals Nes"."Cereals, nes"."MainOutput1 (t)"
"Citrus, all"."Citrus Fruits"."MainOutput1 (t)"
"Fruits, all"."All Fruits"."MainOutput1 (t)"
"Hay Non-Leguminous"."Grass"."MainOutput1 (t)"
"Nuts, all"."All Nuts"."MainOutput1 (t)"
"Pulses, all"."Pulses,Total"."MainOutput1 (t)"
"Roots and tubers, nes"."Roots and tubers, nes"."MainOutput1 (t)"
"Roots and Tubers, most"."Roots and tubers,Total"."MainOutput1 (t)"

*"Fruit vegetables"."Fruit vegetables"."MainOutput1 (t)"
"Fruit vegetables"."Tomatoes"."MainOutput1 (t)"
"Nuts, nes"."Nuts, nes"."MainOutput1 (t)"

*from NFP69
*'Leafy vegetables'.'Leafy vegetables'."MainOutput1 (t)"
'Leafy vegetables'.'Spinach'."MainOutput1 (t)"
*'Branch vegetables'.'Branch vegetables'."MainOutput1 (t)"
'Branch vegetables'.'Lettuce and Chicory'."MainOutput1 (t)"
'Cauliflower vegetables'."Cauliflowers and broccoli"."MainOutput1 (t)"

/;


*set 3
set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass) "Set matching activities and commodities for the cases of well defined coproducts"
*This captures the cases of well defined coproducts
*contains crop commodities only, hence only one file needed for crops
/
"Coconut Oil"."Coconuts"."MainOutput1 (t)"
"Copra Cake"."Coconuts"."MainOutput1 (t)"
"Cotton lint"."Seed cotton"."MainOutput1 (t)"
"Cottonseed"."Seed cotton"."MainOutput1 (t)"
"Cottonseed Cake"."Seed cotton"."MainOutput1 (t)"
"Cottonseed Oil"."Seed cotton"."MainOutput1 (t)"
"Groundnut Cake"."Groundnuts, with shell"."MainOutput1 (t)"
"Groundnut Oil"."Groundnuts, with shell"."MainOutput1 (t)"
"Groundnuts (Shelled Eq)"."Groundnuts, with shell"."MainOutput1 (t)"
"Maize Germ Oil"."Maize"."MainOutput1 (t)"
"Olive Oil"."Olives"."MainOutput1 (t)"
"Palm kernels"."Oil, palm fruit"."MainOutput1 (t)"
"Palm Oil"."Oil, palm fruit"."MainOutput1 (t)"
"Palmkernel Cake"."Oil, palm fruit"."MainOutput1 (t)"
"Palmkernel Oil"."Oil, palm fruit"."MainOutput1 (t)"
"Ricebran Oil"."Rice, paddy"."MainOutput1 (t)"
"Rice (Milled Equivalent)"."Rice, paddy"."MainOutput1 (t)"
"Sesameseed Cake"."Sesame seed"."MainOutput1 (t)"
"Sesameseed Oil"."Sesame seed"."MainOutput1 (t)"
"Soyabean Cake"."Soybeans"."MainOutput1 (t)"
"Soyabean Oil"."Soybeans"."MainOutput1 (t)"
"Sunflowerseed Cake"."Sunflower seed"."MainOutput1 (t)"
"Sunflowerseed Oil"."Sunflower seed"."MainOutput1 (t)"
"Wine"."Grapes"."MainOutput1 (t)"

"Alfalfa meal and pellets"."Alfalfa"."MainOutput1 (t)"
"Almonds shelled"."Almonds, with shell"."MainOutput1 (t)"
"Apricots, dry"."Apricots"."MainOutput1 (t)"
"Barley, pearled"."Barley"."MainOutput1 (t)"
"Beer of barley"."Barley"."MainOutput1 (t)"
"Beer Of Maize"."Maize"."MainOutput1 (t)"
"Beer Of Millet"."Millet"."MainOutput1 (t)"
"Beer of sorghum"."Sorghum"."MainOutput1 (t)"
"Beet pulp"."Sugar beet"."MainOutput1 (t)"
"Bran, buckwheat"."Buckwheat"."MainOutput1 (t)"
"Bran, fonio"."Fonio"."MainOutput1 (t)"
"Bran, maize"."Maize"."MainOutput1 (t)"
"Bran, millet"."Millet"."MainOutput1 (t)"
"Bran, Rice"."Rice, paddy"."MainOutput1 (t)"
"Bran, sorghum"."Sorghum"."MainOutput1 (t)"
"Bran, wheat"."Wheat"."MainOutput1 (t)"
"Brazil nuts, shelled"."Brazil nuts, with shell"."MainOutput1 (t)"
"Bulgur"."Wheat"."MainOutput1 (t)"
"Butter of karite nuts"."Karite nuts (sheanuts)"."MainOutput1 (t)"
"Cake, copra"."Coconuts"."MainOutput1 (t)"
"Cake, cottonseed"."Seed cotton"."MainOutput1 (t)"
"Cake, groundnuts"."Groundnuts, with shell"."MainOutput1 (t)"
"Cake, hempseed"."Hempseed"."MainOutput1 (t)"
"Cake, kapok"."Kapokseed in shell"."MainOutput1 (t)"
"Cake, linseed"."Linseed"."MainOutput1 (t)"
"Cake, maize"."Maize"."MainOutput1 (t)"
"Cake, mustard"."Mustard seed"."MainOutput1 (t)"
"Cake, palm kernel"."Oil, palm fruit"."MainOutput1 (t)"
"Cake, rapeseed"."Rapeseed"."MainOutput1 (t)"
"Cake, rice bran"."Rice, paddy"."MainOutput1 (t)"
"Cake, safflower"."Safflower seed"."MainOutput1 (t)"
"Cake, sesame seed"."Sesame seed"."MainOutput1 (t)"
"Cake, soybeans"."Soybeans"."MainOutput1 (t)"
"Cake, sunflower"."Sunflower seed"."MainOutput1 (t)"
"Cane tops"."Sugar cane"."MainOutput1 (t)"
"Cashew nuts, shelled"."Cashew nuts, with shell"."MainOutput1 (t)"
"Cashewapple"."Cashewapple"."MainOutput1 (t)"
"Cassava dried"."Cassava"."MainOutput1 (t)"
"Cocoa, butter"."Cocoa, beans"."MainOutput1 (t)"
"Cocoa, paste"."Cocoa, beans"."MainOutput1 (t)"
"Cocoa, powder & cake"."Cocoa, beans"."MainOutput1 (t)"
"Coconuts, desiccated"."Coconuts"."MainOutput1 (t)"
*silk is currently not covered consistently, thus drop
*"Cocoons, unreelable & waste"."Silkworms"."Other animal output"
"Coffee, extracts"."Coffee, green"."MainOutput1 (t)"
"Coffee, husks and skins"."Coffee, green"."MainOutput1 (t)"
"Coffee, roasted"."Coffee, green"."MainOutput1 (t)"
"Copra"."Coconuts"."MainOutput1 (t)"
"Cotton linter"."Seed cotton"."MainOutput1 (t)"
"Cotton waste"."Seed cotton"."MainOutput1 (t)"
"Cotton, carded, combed"."Seed cotton"."MainOutput1 (t)"
*this is the following: 846."Feed and meal, gluten"
*        "Generally, by-products of the wet milling of maize. Gluten feed consists of fibres, spent germ and steep liquor.
*        Gluten meal contains endosperm protein fractions that remain following starch recovery."
"Figs dried"."Figs"."MainOutput1 (t)"
"Flax Fib+Tow+W"."Flax fibre and tow"."MainOutput1 (t)"
"Flax fibre and tow"."Flax fibre and tow"."MainOutput1 (t)"
"Flax fibre raw"."Flax fibre and tow"."MainOutput1 (t)"
"Flax tow waste"."Flax fibre and tow"."MainOutput1 (t)"

"Flour, fonio"."Fonio"."MainOutput1 (t)"
"Flour, maize"."Maize"."MainOutput1 (t)"
"Flour, mustard"."Mustard seed"."MainOutput1 (t)"
"Flour, potatoes"."Potatoes"."MainOutput1 (t)"
"Flour, wheat"."Wheat"."MainOutput1 (t)"
"Germ, maize"."Maize"."MainOutput1 (t)"
"Groundnuts Total Shelled"."Groundnuts, with shell"."MainOutput1 (t)"
"Groundnuts, shelled"."Groundnuts, with shell"."MainOutput1 (t)"
"Hazelnuts, shelled"."Hazelnuts, with shell"."MainOutput1 (t)"
"Juice, grape"."Grapes"."MainOutput1 (t)"
"Juice, grapefruit"."Grapefruit (inc. pomelos)"."MainOutput1 (t)"
"Juice, grapefruit, concentrated"."Grapefruit (inc. pomelos)"."MainOutput1 (t)"
"Juice, lemon, concentrated"."Lemons and limes"."MainOutput1 (t)"
"Juice, orange, concentrated"."Oranges"."MainOutput1 (t)"
"Juice, orange, single strength"."Oranges"."MainOutput1 (t)"
"Juice, pineapple"."Pineapples"."MainOutput1 (t)"
"Juice, pineapple, concentrated"."Pineapples"."MainOutput1 (t)"
"Juice, plum, concentrated"."Plums and sloes"."MainOutput1 (t)"
"Juice, plum, single strength"."Plums and sloes"."MainOutput1 (t)"
"Juice, tomato"."Tomatoes"."MainOutput1 (t)"
"Kapok fibre"."Kapok fibre"."MainOutput1 (t)"
"Kapokseed in shell"."Kapokseed in shell"."MainOutput1 (t)"
"Kapokseed shelled"."Kapokseed in shell"."MainOutput1 (t)"
"Macaroni"."Wheat"."MainOutput1 (t)"
"Malt"."Barley"."MainOutput1 (t)"
"Maple sugar and syrups"."Maple"."MainOutput1 (t)"
"Mushrooms, canned"."Mushrooms and truffles"."MainOutput1 (t)"
"Oats rolled"."Oats"."MainOutput1 (t)"
*This is 1274."Oil, boiled etc": "Also includes oxidized and sulphurized oils. Animal and vegetable fats and oils whose chemical structure has been modified to improve viscosity, drying ability or other properties."
"Oil, castor beans"."Castor oil seed"."MainOutput1 (t)"
"Oil, coconut (copra)"."Coconuts"."MainOutput1 (t)"
"Oil, cottonseed"."Seed cotton"."MainOutput1 (t)"
"Oil, groundnut"."Groundnuts, with shell"."MainOutput1 (t)"
"Oil, kapok"."Kapokseed in shell"."MainOutput1 (t)"
"Oil, linseed"."Linseed"."MainOutput1 (t)"
"Oil, maize"."Maize"."MainOutput1 (t)"
"Oil, olive residues"."Olives"."MainOutput1 (t)"
"Oil, olive, virgin"."Olives"."MainOutput1 (t)"
"Oil, palm"."Oil, palm fruit"."MainOutput1 (t)"
"Oil, palm kernel"."Oil, palm fruit"."MainOutput1 (t)"
"Oil, poppy"."Poppy seed"."MainOutput1 (t)"
"Oil, rapeseed"."Rapeseed"."MainOutput1 (t)"
"Oil, rice bran"."Rice, paddy"."MainOutput1 (t)"
"Oil, safflower"."Safflower seed"."MainOutput1 (t)"
"Oil, sesame"."Sesame seed"."MainOutput1 (t)"
"Oil, soybean"."Soybeans"."MainOutput1 (t)"
"Oil, sunflower"."Sunflower seed"."MainOutput1 (t)"
"Olive Oil,Total"."Olives"."MainOutput1 (t)"
"Pastry"."Wheat"."MainOutput1 (t)"
"Peanut butter"."Groundnuts, with shell"."MainOutput1 (t)"
"Pineapples canned"."Pineapples"."MainOutput1 (t)"
"Plums dried (prunes)"."Plums and sloes"."MainOutput1 (t)"
"Popcorn"."Maize"."MainOutput1 (t)"
"Potato offals"."Potatoes"."MainOutput1 (t)"
"Potatoes, frozen"."Potatoes"."MainOutput1 (t)"
"Pyrethrum, extraction"."Pyrethrum, dried"."MainOutput1 (t)"
"Raisins"."Grapes"."MainOutput1 (t)"
"Rubber natural dry"."Rubber, natural"."MainOutput1 (t)"
*silk is currently not covered consistently in the model - thus drop here
*"Silk raw"."Silkworms"."Other animal output"
*"Silk-worm cocoons, reelable"."Silkworms"."Other animal output"
"Soya curd"."Soybeans"."MainOutput1 (t)"
"Soya paste"."Soybeans"."MainOutput1 (t)"
"Soya sauce"."Soybeans"."MainOutput1 (t)"
"Starch, cassava"."Cassava"."MainOutput1 (t)"
"Sweet corn frozen"."Maize, green"."MainOutput1 (t)"
"Sweet corn prep or preserved"."Maize, green"."MainOutput1 (t)"
"Tea, mate extracts"."Maté"."MainOutput1 (t)"
"Tobacco products nes"."Tobacco, unmanufactured"."MainOutput1 (t)"
"Tomatoes, paste"."Tomatoes"."MainOutput1 (t)"
"Tomatoes, peeled"."Tomatoes"."MainOutput1 (t)"
"Vegetable tallow"."Tallowtree seed"."MainOutput1 (t)"
"Walnuts, shelled"."Walnuts, with shell"."MainOutput1 (t)"
"Wheat+Flour,Wheat Equivalent"."Wheat"."MainOutput1 (t)"
"Applejuice Single Streng"."Apples"."MainOutput1 (t)"
"Applejuice Concentrated"."Apples"."MainOutput1 (t)"
"Bagasse"."Sugar cane"."MainOutput1 (t)"
"Barley Flour And Grits"."Barley"."MainOutput1 (t)"
"Beet Sugar"."Sugar beet"."MainOutput1 (t)"
"Beet Tops"."Sugar beet"."MainOutput1 (t)"
"Bran, Barley"."Barley"."MainOutput1 (t)"
"Bran, Mixed Grain"."Grain, mixed"."MainOutput1 (t)"
"Bran, Oats"."Oats"."MainOutput1 (t)"
"Bran, Rye"."Rye"."MainOutput1 (t)"
"Bran, Triticale"."Triticale"."MainOutput1 (t)"
"Cake, Palm Kernels"."Oil, palm fruit"."MainOutput1 (t)"
"Cake Of Poppy Seed"."Poppy seed"."MainOutput1 (t)"
"Cane Sugar"."Sugar cane"."MainOutput1 (t)"
"Cassava Tapioca"."Cassava"."MainOutput1 (t)"
"Cocoa Husks+Shell"."Cocoa, beans"."MainOutput1 (t)"
"Coir"."Coir"."MainOutput1 (t)"
*"Cottonseed"."Seed cotton"."MainOutput1 (t)"
*drop: element redefined
"Flour, Buckwheat"."Buckwheat"."MainOutput1 (t)"
"Flour, Cassava"."Cassava"."MainOutput1 (t)"
"Flour, Millet"."Millet"."MainOutput1 (t)"
"Flour, Rye"."Rye"."MainOutput1 (t)"
"Flour, Sorghum"."Sorghum"."MainOutput1 (t)"
"Flour, Triticale"."Triticale"."MainOutput1 (t)"
"Germ, Wheat"."Wheat"."MainOutput1 (t)"
"Prepared Groundnuts"."Groundnuts, with shell"."MainOutput1 (t)"
"Jojoba Oil"."Jojoba seed"."MainOutput1 (t)"
"Leaves And Tops, Vines".Grapes."MainOutput1 (t)"
"Lemonjuice Single-Streng"."Lemons and limes"."MainOutput1 (t)"
"Maize Gluten"."Maize"."MainOutput1 (t)"
"Malt Extracts".Barley."MainOutput1 (t)"
"Mango Juice"."Mangoes, mangosteens, guavas"."MainOutput1 (t)"
"Mango Pulp"."Mangoes, mangosteens, guavas"."MainOutput1 (t)"
"Marc Of Grapes"."Grapes"."MainOutput1 (t)"
"Milled Paddy Rice"."Rice, paddy"."MainOutput1 (t)"
"Dried Mushrooms"."Mushrooms and truffles"."MainOutput1 (t)"
"Must Of Grapes".Grapes."MainOutput1 (t)"
"Oil, Hempseed"."Hempseed"."MainOutput1 (t)"
"Oil, Mustard Seed"."Mustard seed"."MainOutput1 (t)"
"Olive Residues"."Olives"."MainOutput1 (t)"
"Plums, Dried (Prunes)"."Plums and sloes"."MainOutput1 (t)"
"Pot Barley"."Barley"."MainOutput1 (t)"
"Potato Starch"."Potatoes"."MainOutput1 (t)"
"Potato Tapioca"."Potatoes"."MainOutput1 (t)"
"Pyrethrum Marc"."Pyrethrum, dried"."MainOutput1 (t)"
"Rice, Broken"."Rice, paddy"."MainOutput1 (t)"
"Rice Flour"."Rice, paddy"."MainOutput1 (t)"
"Rice Gluten"."Rice, paddy"."MainOutput1 (t)"
"Rice, Husked"."Rice, paddy"."MainOutput1 (t)"
"Milled/Husked Rice"."Rice, paddy"."MainOutput1 (t)"
"Rice, Starch"."Rice, paddy"."MainOutput1 (t)"
"Starch Of Maize"."Maize"."MainOutput1 (t)"
"Tangerine Juice"."Tangerines, mandarins, clementines, satsumas"."MainOutput1 (t)"
"Tomatojuice Concentrated"."Tomatoes"."MainOutput1 (t)"
"Tung Oil"."Tung nuts"."MainOutput1 (t)"
"Wheat Fermented Beverage"."Wheat"."MainOutput1 (t)"
"Wheat Gluten"."Wheat"."MainOutput1 (t)"
"Wheat Starch"."Wheat"."MainOutput1 (t)"

*new main and co products added by Adrian Muller to better capture commpodity trees, etc.
*new co-prod: Level1
"Rice hulls"."Rice, paddy"."MainOutput1 (t)"
"Groundnut shells"."Groundnuts, with shell"."MainOutput1 (t)"
"Beer of Shorgum dregs".Sorghum."MainOutput1 (t)"
"Cocoa husks"."Cocoa, beans"."MainOutput1 (t)"
"Karite nut cake"."Karite nuts (sheanuts)"."MainOutput1 (t)"
"Almond shells"."Almonds, with shell"."MainOutput1 (t)"
"Apricot kernel".Apricots."MainOutput1 (t)"
"Chestnut shells".Chestnut."MainOutput1 (t)"
"Coconut shells".Coconuts."MainOutput1 (t)"
"Cashew nut shells"."Cashew nuts, with shell"."MainOutput1 (t)"
"Brazil nut shells"."Brazil nuts, with shell"."MainOutput1 (t)"
"Tomato pulp".Tomatoes."MainOutput1 (t)"
"Grape pulp".grapes."MainOutput1 (t)"
"Grapefruit pulp"."Grapefruit (inc. pomelos)"."MainOutput1 (t)"
"Lemon pulp"."Lemons and limes"."MainOutput1 (t)"
"Orange pulp".Oranges."MainOutput1 (t)"
"Pineapple pulp".Pineapples."MainOutput1 (t)"
"Plum pulp"."Plums and sloes"."MainOutput1 (t)"
"Hazelnut shells"."Hazelnuts, with shell"."MainOutput1 (t)"
"Castor bean cake"."Castor oil seed"."MainOutput1 (t)"
"Walnut shells"."Walnuts, with shell"."MainOutput1 (t)"
"Apple pulp".Apples."MainOutput1 (t)"
"Jojoba cake"."Jojoba seed"."MainOutput1 (t)"
"Tangerine pulp"."Tangerines, mandarins, clementines, satsumas"."MainOutput1 (t)"
"Tung nut cake"."Tung nuts"."MainOutput1 (t)"
"Molasse from cane"."Sugar cane"."MainOutput1 (t)"
"Molasse from beet"."Sugar beet"."MainOutput1 (t)"
*New main prod:level 1
"Oat flour".Oats."MainOutput1 (t)"
"Cocoa paste"."Cocoa, beans"."MainOutput1 (t)"
*new co-prod Level2
"Beer of Barley dregs".Barley."MainOutput1 (t)"
"Kapokseed shells"."Kapokseed in shell"."MainOutput1 (t)"
"Pressed olive residues"."Olives"."MainOutput1 (t)"
*new main prod Level2
"Palm kernel oil"."Oil, palm fruit"."MainOutput1 (t)"
"Wheat dregs"."Wheat"."MainOutput1 (t)"
"Oil palm fruit pulp"."Oil, palm fruit"."MainOutput1 (t)"

"Chestnut"."Chestnut"."MainOutput1 (t)"

*for NFP69
"Flour, Spelt"."Spelt"."MainOutput1 (t)"
"Bran, spelt"."Spelt"."MainOutput1 (t)"
/;

*set 4
set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass) "Set matching activities and commodities for the most complex cases such as fats and alcohol"
*This captures the most complex cases such as fats and alcohol
*contains crop commodities only, hence only one file needed for crops
/
"Alcohol, Non-Food"."All Crops"."MainOutput1 (t)"
"Alcoholic Beverages"."All Crops"."MainOutput1 (t)"
"Beverages, Alcoholic"."All Crops"."MainOutput1 (t)"
"Beverages, Fermented"."All Crops"."MainOutput1 (t)"
"Molasses"."All Sugar Crops"."MainOutput1 (t)"
"Molasses (sugar cane)"."Sugar cane"."MainOutput1 (t)"
"Molasses (sugar beet)"."Sugar beet"."MainOutput1 (t)"
"Sugar & Sweeteners"."All sugar crops"."MainOutput1 (t)"
"Sugar (Raw Equivalent)"."All sugar crops"."MainOutput1 (t)"
"Sugar non-centrifugal"."All sugar sources"."MainOutput1 (t)"
*cf: 2541."Sugar non-centrifugal" resp. 163."Sugar non-centrifugal"
"Sugar, Raw Equivalent"."All sugar sources"."MainOutput1 (t)"
*this covers more in contrast to the other sugar elements: it is defined as follows:
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes,
*        162 Sugar Raw Centrifugal, 163 Sugar non-centrifugal, 166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose"
"Sugar, Refined Equiv"."All sugar crops"."MainOutput1 (t)"
"Sugar, Refined Equiv (sugar beet)"."Sugar beet"."MainOutput1 (t)"
"Sugar, Refined Equiv (sugar cane)"."Sugar cane"."MainOutput1 (t)"
"Sweeteners, Other"."All other sugar sources"."MainOutput1 (t)"
*This is 2543."Sweeteners, Other"
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes, 165 Molasses,
*        166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose, 175 Isoglucose, 633 Beverages, non alcoholic"
"Beverages"."All Crops"."MainOutput1 (t)"
*to have something for below: assume Cherries (representative of some fruit distillate - thus does not account for cereal distillates, or potatoe, etc.)
*"Beverages, distilled alcoholic"."All Crops"."MainOutput1 (t)"
"Beverages, distilled alcoholic"."Cherries"."MainOutput1 (t)"
"Beverages, fermented rice"."Rice, paddy"."MainOutput1 (t)"
"Beverages, non alcoholic"."All Crops"."MainOutput1 (t)"
"Beverages+Tobacco"."All Crops"."MainOutput1 (t)"
"Chocolate products nes"."Cocoa, beans"."MainOutput1 (t)"
"Cider etc"."Apples"."MainOutput1 (t)"
"Cigarettes"."Tobacco, unmanufactured"."MainOutput1 (t)"
"Cigars, cheroots"."Tobacco, unmanufactured"."MainOutput1 (t)"
"Coffee, substitutes containing coffee"."Coffee, green"."MainOutput1 (t)"
"Dregs from brewing, distillation"."All Crops"."MainOutput1 (t)"
"Feed and meal, gluten"."Maize"."MainOutput1 (t)"
*this is the following: 846."Feed and meal, gluten"
*        "Generally, by-products of the wet milling of maize. Gluten feed consists of fibres, spent germ and steep liquor.
*        Gluten meal contains endosperm protein fractions that remain following starch recovery."
"Fixed Vegetable Oils"."All Oilcrops"."MainOutput1 (t)"
"Fructose and syrup, other"."All Fruits"."MainOutput1 (t)"
"Fruit, cooked, homogenized preparations"."All Fruits"."MainOutput1 (t)"
"Glucose and dextrose"."All Cereals"."MainOutput1 (t)"
"Margarine, liquid"."All Oilcrops"."MainOutput1 (t)"
"Margarine, short"."All Oilcrops"."MainOutput1 (t)"
"Oil, boiled etc"."All Activities"."MainOutput1 (t)"
*This is 1274."Oil, boiled etc": "Also includes oxidized and sulphurized oils. Animal and vegetable fats and oils whose chemical structure has been modified to improve viscosity, drying ability or other properties."
"Oil, essential nes"."All Oilcrops"."MainOutput1 (t)"
"Sugar Raw Centrifugal"."All Sugar Crops"."MainOutput1 (t)"
"Sugar refined"."All Sugar Crops"."MainOutput1 (t)"
"Alcohol Non Food Purpose"."All Crops"."MainOutput1 (t)"
"Oils Hydrogenated"."All Oilcrops"."MainOutput1 (t)"
"Oil cakes - various"."All Oilcrops"."MainOutput1 (t)"

*from NFP69
*Seasoning."All vegetables"."MainOutput1 (t)"
Seasoning."Onions, shallots, green"."MainOutput1 (t)"
*"CoProds Seasoning"."All vegetables"."MainOutput1 (t)"
"CoProds Seasoning"."Onions, shallots, green"."MainOutput1 (t)"
/;


*set 5
set MatchCommAct_ComplexAnimalCommodities(Commodities,Activities,OutputsAnimals) "Set matching activities and commodities for the more complex animal commodities"
*This covers the more complex animal commodities
*contains animal commodities only, hence only one file needed for animals
/
"Animal Products"."All Animals"."Meat (t)"
*"Butter, Ghee"."All Ruminants"."Milk (t)"
"Butter, Ghee"."Cattle"."Milk (t)"
*"Cheese"."All Ruminants"."Milk (t)"
"Cheese"."Cattle"."Milk (t)"
"Cream"."Cattle"."Milk (t)"
"Meat Meal"."All Animals"."Meat (t)"
"Fish Meal"."All Fish and Seafood"."Meat (t)"
*this is 2855."Fish Meal" and thus covers all seafood:
*        "Default composition: 1511 Freshwater Meal Fr Offal, 1524 Demersal Meal from Offal, 1537 Pelagic Meal from Offal, 1550 Marn Meal Of, 1559 Crustaceans Meal F Offal,
*        1567 Molluscs Meal from Offal, 1576 Cephalopods Meal F Offal, 1581 Aquatic Mammals Meals, 1584 Aqua Mammal Meal F Offal, 1591 Aq A Meal Of"
"Fish, Body Oil"."All Fish and Marine Mamm"."Meat (t)"
*this is 2781."Fish, Body Oil" and thus covers fish and marine mammals
*        "Default composition: 1509 Frwt Bdy Oil, 1522 Dmrs Bdy Oil, 1535 Pelg Bdy Oil, 1548 Marn Bdy Oil, 1582 Aq M Oils"
"Fish, Liver Oil"."All Fish and Marine Mamm"."Meat (t)"
*2782."Fish, Liver Oil" and thus covers fish and marine mammals
*        "Default composition: 1510 Frwt Lvr Oil, 1523 Demersal Liver Oils, 1536 Pelg Lvr Oil, 1549 Marine nes Liver Oils"
"Milk, Skimmed"."Cattle"."Milk (t)"
"Whey"."Cattle"."Milk (t)"
"Animal Oil+Fat+Grs"."All Animals"."Meat (t)"
"Animal Vegetable Oil"."All Animals"."Meat (t)"
"Bacon and ham"."Pigs"."Meat (t)"
"Butter"."Cattle"."Milk (t)"
"Butter, cow milk"."Cattle"."Milk (t)"
"Buttermilk, curdled, acidified milk"."Cattle"."Milk (t)"
"Canned Meat nes"."All Animals"."Meat (t)"
*"Cheese and Curd"."All Ruminants"."Milk (t)"
"Cheese and Curd"."Cattle"."Milk (t)"
*"Cheese, processed"."All Ruminants"."Milk (t)"
"Cheese, processed"."Cattle"."Milk (t)"
"Cheese, sheep milk"."Sheep"."Milk (t)"
"Cheese, whole cow milk"."Cattle"."Milk (t)"
"Cream fresh"."Cattle"."Milk (t)"
"Eggs Liquid,Dried"."Chickens"."Eggs (t)"
"Eggs, dried"."Chickens"."Eggs (t)"
"Eggs, liquid"."Chickens"."Eggs (t)"
"Fat, liver prepared (foie gras)"."Ducks and Geese"."Meat (t)"
*This is needed to match 1060."Fat, liver prepared (foie gras)" with activities:
*        "Fatty livers of ducks and geese when cooked, prepared or preserved(e.g. patâ€š)."
"Fat, nes, prepared"."All Animals"."Meat (t)"
*the butcher fat is the co-product from meat, other fats are parts of the liveweight COMPLEMENTING meat and offals
"Cattle Butcher Fat"."Cattle"."Fat (t)"
"Pig Butcher Fat"."Pigs"."Fat (t)"
"Fatty acids"."All Animals"."Meat (t)"
"Fatty substance residues"."All Animals"."Meat (t)"
"Ghee, of buffalo milk"."Buffaloes"."Milk (t)"
"Grease incl. lanolin wool"."Sheep"."Wool (t)"
"Lactose"."Cattle"."Milk (t)"
"Lard"."Pigs"."Meat (t)"
"Meal, meat"."All Animals"."Meat (t)"
"Meat and Meat Preparations"."All Animals"."Meat (t)"
"Meat Fresh+Ch+Frozen"."All Animals"."Meat (t)"
"Meat Prepared Pres"."All Animals"."Meat (t)"
"Meat, beef and veal sausages"."Cattle"."Meat (t)"
"Meat, beef, preparations"."Cattle"."Meat (t)"
"Meat, cattle, boneless (beef & veal)"."Cattle"."Meat (t)"
"Meat, chicken, canned"."Chickens"."Meat (t)"
"Meat, dried nes"."All Animals"."Meat (t)"
"Meat, pig sausages"."Pigs"."Meat (t)"
"Meat, pig, preparations"."Pigs"."Meat (t)"
"Meat, pork"."Pigs"."Meat (t)"
"Milk Condensed + Evaporated"."Cattle"."Milk (t)"
"Milk Condensed+Dry+Fresh"."Cattle"."Milk (t)"
"Milk Dry"."Cattle"."Milk (t)"
"Milk Equivalent"."Cattle"."Milk (t)"
"Milk, products of natural constituents nes"."Cattle"."Milk (t)"
"Milk, reconstituted"."Cattle"."Milk (t)"
"Milk, skimmed cow"."Cattle"."Milk (t)"
"Milk, skimmed dried"."Cattle"."Milk (t)"
"Milk, whole condensed"."Cattle"."Milk (t)"
"Milk, whole dried"."Cattle"."Milk (t)"
"Milk, whole evaporated"."Cattle"."Milk (t)"
"Whey, condensed"."Cattle"."Milk (t)"
"Whey, dry"."Cattle"."Milk (t)"
"Whey, Pres+Concen"."Cattle"."Milk (t)"
"Wool, hair waste"."Sheep"."Wool (t)"
"Yoghurt, concentrated or not"."Cattle"."Milk (t)"
"Animals live nes"."Animals live nes"."Meat (t)"
"Asses"."Asses"."Meat (t)"
"Beehives".Beehives."Honey (t)"
"Buffaloes"."Buffaloes"."Meat (t)"
"Camelids, other"."Camelids, other"."Meat (t)"
"Camels"."Camels"."Meat (t)"
"Cattle"."Cattle"."Meat (t)"
"Chickens"."Chickens"."Meat (t)"
"Ducks"."Ducks"."Meat (t)"
"Goats"."Goats"."Meat (t)"
"Horses"."Horses"."Meat (t)"
"Mules"."Mules"."Meat (t)"
"Pigs"."Pigs"."Meat (t)"
"Rabbits and hares"."Rabbits and hares"."Meat (t)"
"Rodents, other"."Rodents, other"."Meat (t)"
"Sheep"."Sheep"."Meat (t)"
"Turkeys"."Turkeys"."Meat (t)"
"Beef Canned"."Cattle"."Meat (t)"
"Beef Dried Salt Smoked"."Cattle"."Meat (t)"
"Blood Meal"."All Animals"."Meat (t)"
"Butter Of Buffalo Milk"."Buffaloes"."Milk (t)"
"Butter Of Goat Milk"."Goats"."Milk (t)"
"Butter+Ghee (Sheep Milk)"."Sheep"."Milk (t)"
"Dry Buttermilk"."Cattle"."Milk (t)"
"Casein"."Cattle"."Milk (t)"
"Cheese Of Buffalo Milk"."Buffaloes"."Milk (t)"
"Cheese Of Goat Milk"."Goats"."Milk (t)"
"Cheese (Skim Cow Milk)"."Cattle"."Milk (t)"
"Game"."Game"."Meat (t)"
"Geese"."Geese and guinea fowls"."Meat (t)"
"Geese and guinea fowls"."Geese and guinea fowls"."Meat (t)"
"Ghee, of cow milk"."Cattle"."Milk (t)"
"Homogenized Meat Prep."."All Animals"."Meat (t)"
"Horse Hides, Fresh"."Horses"."HidesSkins (t)"
"Lard And Stearine Oil"."Pigs"."Meat (t)"
"Live Animals Nes". "Animals live nes"."Meat (t)"
"Meat Extracts"."All Animals"."Meat (t)"
"Meat Prepared Nes"."All Animals"."Meat (t)"
"Oils Fish And Marine Mam"."All Fish and Marine Mamm"."Meat (t)"
"Oils, fats of animal nes"."All Animals"."Meat (t)"
"Fat, Poultry Rendered"."Chickens"."Meat (t)"
"Other birds for eggs"."Pigeons, other birds"."Eggs (t)"
"Skim Milk, Condensed"."Cattle"."Milk (t)"
"Skim Milk, Evaporated"."Cattle"."Milk (t)"
"Skim Milk Of Buffalo"."Buffaloes"."Milk (t)"
"Skim Milk Of Goat"."Goats"."Milk (t)"
"Skim Sheep Milk"."Sheep"."Milk (t)"
"Whey Cheese"."Cattle"."Milk (t)"
"Whey, Fresh"."Cattle"."Milk (t)"
"Wool Shoddy"."Sheep"."Wool (t)"
"Yoghurt"."Cattle"."Milk (t)"

*from NFP69
*'Hard cheese'."All Ruminants"."Milk (t)"
'Hard cheese'."Cattle"."Milk (t)"
*'Semihard cheese'."All Ruminants"."Milk (t)"
'Semihard cheese'."Cattle"."Milk (t)"
*'Soft cheese'."All Ruminants"."Milk (t)"
'Soft cheese'."Cattle"."Milk (t)"
/;



$ontext;
XXXXX
TO DO: for the sets above,
allocate impacts to the Aggregate Commods/Activities such as "All Ruminants" - by doing a quantity-weighted average of the constituents of this set
general formula:
ImpactPerUnitGroup = 8Sum ImpactPerGroupElement*QUantityGroupElement)/(Sum QuantityGroupElements)

For a shortcut: we leave it away for many unimportant commodities (tagged. NOT IMPORTANT) or use single crops instead of the groups, then it works (i.e. "Wheat" instead of "All cereals")

aggregates to do:

Set1
"All Cereals"
"Pulses,Total"
"Other Cereals"
"All other citrus"
"All other oilcrops"
"All crops producing oilseed cake"
"Rape and Mustard seed"
"Citrus Fruits"
"All Nuts"
"Roots and tubers,Total"
"Grain, mixed"

Set2
"Carrots and turnips"
NOT IMPORTANT"All other hard fibres"
NOT IMPORTANT"Jute & Jute-like Fibres"
"All roots and tubers"
"All other roots"
"All other soft fibres"
NOT IMPORTANT"All spices"
NOT IMPORTANT"All other Spices"
"All starchy roots"
"Treenuts,Total"
"Pulses,Total"
"All other vegetables"
"Bananas and plantains"
Grass
'Leafy vegetables'
'Branch vegetables'

Set4
"All crops"
"All sugar crops"
"All sugar sources"
"All other sugar sources"
"All Oilcrops"
"All Fruits"
"All Cereals"
"All Activities"
"All vegetables"

Set5
"All Fish and Seafood"
"Ducks and Geese"
"All Animals"
"All Fish and Marine Mamm"
"All Ruminants"

XXXXXXXXXXXXXX
$offtext;








*set 6
*the following covers crop and animal commodities, hence the need for two matching files
*set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
*set MatchCommAct_CommodEquivalentAct_Animals(Commodities,Activities,OutputsAnimals)
*This captures all commodities that are equivalent to main outputs from activities
set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass) "Set covering all crop commodities that are equivalent to main outputs from activities"
/
"Abaca"."Manila fibre (abaca)"."MainOutput1 (t)"
"Bananas"."Bananas"."MainOutput1 (t)"
"Beans"."Beans, dry"."MainOutput1 (t)"
"Cashew nuts, with shell"."Cashew nuts, with shell"."MainOutput1 (t)"
"Cloves"."Cloves"."MainOutput1 (t)"
"Dates"."Dates"."MainOutput1 (t)"
"Groundnuts (in Shell Eq)"."Groundnuts, with shell"."MainOutput1 (t)"
"Hemp Fibre And Tow"."Hempseed"."MainOutput1 (t)"
"Hempseed"."Hempseed"."MainOutput1 (t)"
"Jute"."Jute"."MainOutput1 (t)"
"Oats"."Oats"."MainOutput1 (t)"
"Oil Palm Fruit"."Oil, palm fruit"."MainOutput1 (t)"
"Olives (including preserved)"."Olives"."MainOutput1 (t)"
"Onions"."Onions, dry"."MainOutput1 (t)"
"Oranges, Mandarines"."Oranges"."MainOutput1 (t)"
"Peas"."Peas, dry"."MainOutput1 (t)"
"Pepper"."Pepper (piper spp.)"."MainOutput1 (t)"
"Pimento"."Chillies and peppers, dry"."MainOutput1 (t)"
*!!XXXXX    !!CAREFUL, if "Chillies and peppers, dry" is also available as commodity!! - how to deal with this??
"Plantains"."Plantains and others"."MainOutput1 (t)"
"Rice, Paddy"."Rice, paddy"."MainOutput1 (t)"
"Rubber"."Rubber, natural"."MainOutput1 (t)"
"Sesame seed"."Sesame seed"."MainOutput1 (t)"
"Sisal"."Sisal"."MainOutput1 (t)"
"Soyabeans"."Soybeans"."MainOutput1 (t)"
"Sugar beet"."Sugar beet"."MainOutput1 (t)"
"Sugar cane"."Sugar cane"."MainOutput1 (t)"
"Sunflower seed"."Sunflower seed"."MainOutput1 (t)"
"Sweet potatoes"."Sweet potatoes"."MainOutput1 (t)"
"Tea (including mate)"."Tea"."MainOutput1 (t)"
"Tobacco"."Tobacco, unmanufactured"."MainOutput1 (t)"
"Yams"."Yams"."MainOutput1 (t)"
"Aquatic Plants"."Aquatic Plants"."MainOutput1 (t)"
"Maize For Forage+Silage"."Maize For Forage+Silage"."MainOutput1 (t)"
"Alfalfa For Forage+Silag"."Alfalfa For Forage+Silag"."MainOutput1 (t)"
"Clover For Forage+Silage"."Clover For Forage+Silage"."MainOutput1 (t)"
"Leguminous Nes,For+Sil"."Leguminous Nes,For+Sil"."MainOutput1 (t)"
"Forage Products Nes"."Forage Products Nes"."MainOutput1 (t)"
"Beets For Fodder"."Beets For Fodder"."MainOutput1 (t)"
"Swedes For Fodder"."Swedes For Fodder"."MainOutput1 (t)"
"Turnips For Fodder"."Turnips For Fodder"."MainOutput1 (t)"
"Vegetables+Roots,Fodder"."Vegetables+Roots,Fodder"."MainOutput1 (t)"

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
"Cabbage, for forage"."Cabbage, for forage"."MainOutput1 (t)"
"Carrots, for forage"."Carrots, for forage"."MainOutput1 (t)"
"Other grasses, for forage"."Other grasses, for forage"."MainOutput1 (t)"
"Other oilseeds, for forage"."Other oilseeds, for forage"."MainOutput1 (t)"
"Rye grass, for forage"."Rye grass, for forage"."MainOutput1 (t)"
"Sorghum, for forage"."Sorghum, for forage"."MainOutput1 (t)"

Fallows.Fallows."MainOutput1 (t)"

*this is an aggregate that needs to be separated!
*"Grass"."Grass"."MainOutput1 (t)"

"Temporary meadows and pastures"."Temporary meadows and pastures"."MainOutput1 (t)"
"Permanent meadows and pastures"."Permanent meadows and pastures"."MainOutput1 (t)"

"temporary grasslands"."temporary grasslands"."MainOutput1 (t)"
"permanent grasslands"."permanent grasslands"."MainOutput1 (t)"
"alpine pastures"."alpine pastures"."MainOutput1 (t)"

"Anise, badian, fennel, coriander"."Anise, badian, fennel, coriander"."MainOutput1 (t)"
"Apples"."Apples"."MainOutput1 (t)"
"Apricots"."Apricots"."MainOutput1 (t)"
"Artichokes"."Artichokes"."MainOutput1 (t)"
"Asparagus"."Asparagus"."MainOutput1 (t)"
"Avocados"."Avocados"."MainOutput1 (t)"
"Bambara beans"."Bambara beans"."MainOutput1 (t)"
"Barley"."Barley"."MainOutput1 (t)"
"Beans, dry"."Beans, dry"."MainOutput1 (t)"
"Beans, green"."Beans, green"."MainOutput1 (t)"
"Blueberries"."Blueberries"."MainOutput1 (t)"
"Broad beans, horse beans, dry"."Broad beans, horse beans, dry"."MainOutput1 (t)"
"Buckwheat"."Buckwheat"."MainOutput1 (t)"
"Cabbages and other brassicas"."Cabbages and other brassicas"."MainOutput1 (t)"
"Canary seed"."Canary seed"."MainOutput1 (t)"
"Cassava"."Cassava"."MainOutput1 (t)"
"Cauliflowers and broccoli"."Cauliflowers and broccoli"."MainOutput1 (t)"
"Cherries"."Cherries"."MainOutput1 (t)"
"Cherries, sour"."Cherries, sour"."MainOutput1 (t)"
"Chick peas"."Chick peas"."MainOutput1 (t)"
"Chillies and peppers, dry"."Chillies and peppers, dry"."MainOutput1 (t)"
"Chillies and peppers, green"."Chillies and peppers, green"."MainOutput1 (t)"
"Cinnamon (canella)"."Cinnamon (canella)"."MainOutput1 (t)"
"Cocoa, beans"."Cocoa, beans"."MainOutput1 (t)"
"Coconuts"."Coconuts"."MainOutput1 (t)"
"Coffee, green"."Coffee, green"."MainOutput1 (t)"
"Cranberries"."Cranberries"."MainOutput1 (t)"
"Cucumbers and gherkins"."Cucumbers and gherkins"."MainOutput1 (t)"
"Currants"."Currants"."MainOutput1 (t)"
"Eggplants (aubergines)"."Eggplants (aubergines)"."MainOutput1 (t)"
"Fonio"."Fonio"."MainOutput1 (t)"
"Forage and silage, clover"."Clover For Forage+Silage"."MainOutput1 (t)"
"Forage and silage, grasses nes"."Grass"."MainOutput1 (t)"
"Forage and silage, legumes"."Leguminous Nes,For+Sil"."MainOutput1 (t)"
"Garlic"."Garlic"."MainOutput1 (t)"
"Ginger"."Ginger"."MainOutput1 (t)"
"Gooseberries"."Gooseberries"."MainOutput1 (t)"
"Grain, mixed"."Grain, mixed"."MainOutput1 (t)"
"Grapefruit (inc. pomelos)"."Grapefruit (inc. pomelos)"."MainOutput1 (t)"
"Grapes"."Grapes"."MainOutput1 (t)"
"Hops"."Hops"."MainOutput1 (t)"
"Jute+Bast Fibres"."Jute"."MainOutput1 (t)"
"Kiwi fruit"."Kiwi fruit"."MainOutput1 (t)"
"Kola nuts"."Kola nuts"."MainOutput1 (t)"
"Leeks, other alliaceous vegetables"."Leeks, other alliaceous vegetables"."MainOutput1 (t)"
"Lemons and limes"."Lemons and limes"."MainOutput1 (t)"
"Lentils"."Lentils"."MainOutput1 (t)"
"Lettuce and chicory"."Lettuce and chicory"."MainOutput1 (t)"
"Linseed"."Linseed"."MainOutput1 (t)"
"Maize"."Maize"."MainOutput1 (t)"
"Maize, green"."Maize, green"."MainOutput1 (t)"
"Mangoes, mangosteens, guavas"."Mangoes, mangosteens, guavas"."MainOutput1 (t)"
"Manila fibre (abaca)"."Manila fibre (abaca)"."MainOutput1 (t)"
"Maté"."Maté"."MainOutput1 (t)"
"Melons, other (inc.cantaloupes)"."Melons, other (inc.cantaloupes)"."MainOutput1 (t)"
"Millet"."Millet"."MainOutput1 (t)"
"Mushrooms and truffles"."Mushrooms and truffles"."MainOutput1 (t)"
"Mustard seed"."Mustard seed"."MainOutput1 (t)"
"Natural Rubber"."Rubber, natural"."MainOutput1 (t)"
"Nutmeg, mace and cardamoms"."Nutmeg, mace and cardamoms"."MainOutput1 (t)"
"Olives"."Olives"."MainOutput1 (t)"
"Olives preserved"."Olives"."MainOutput1 (t)"
"Onions, dry"."Onions, dry"."MainOutput1 (t)"
"Onions, shallots, green"."Onions, shallots, green"."MainOutput1 (t)"
"Oranges"."Oranges"."MainOutput1 (t)"
"Oth Citrus Frt"."Fruit, citrus nes"."MainOutput1 (t)"
"Papayas"."Papayas"."MainOutput1 (t)"
"Peaches and nectarines"."Peaches and nectarines"."MainOutput1 (t)"
"Pears"."Pears"."MainOutput1 (t)"
"Peas, dry"."Peas, dry"."MainOutput1 (t)"
"Peas, green"."Peas, green"."MainOutput1 (t)"
"Pepper (piper spp.)"."Pepper (piper spp.)"."MainOutput1 (t)"
"Peppermint"."Peppermint"."MainOutput1 (t)"
"Persimmons"."Persimmons"."MainOutput1 (t)"
"Pineapples"."Pineapples"."MainOutput1 (t)"
"Pistachios"."Pistachios"."MainOutput1 (t)"
"Plantains and others"."Plantains and others"."MainOutput1 (t)"
"Plums and sloes"."Plums and sloes"."MainOutput1 (t)"
"Poppy seed"."Poppy seed"."MainOutput1 (t)"
"Potatoes"."Potatoes"."MainOutput1 (t)"
"Pumpkins, squash and gourds"."Pumpkins, squash and gourds"."MainOutput1 (t)"
"Pyrethrum, dried"."Pyrethrum, dried"."MainOutput1 (t)"
"Quinces"."Quinces"."MainOutput1 (t)"
"Rapeseed"."Rapeseed"."MainOutput1 (t)"
"Rice"."Rice, paddy"."MainOutput1 (t)"
"Rice (Paddy Equivalent)"."Rice, paddy"."MainOutput1 (t)"
"Rubber, natural"."Rubber, natural"."MainOutput1 (t)"
"Rye"."Rye"."MainOutput1 (t)"
"Sorghum"."Sorghum"."MainOutput1 (t)"
"Soybeans"."Soybeans"."MainOutput1 (t)"
"Spices, nes"."Spices, nes"."MainOutput1 (t)"
"Spinach"."Spinach"."MainOutput1 (t)"
"Strawberries"."Strawberries"."MainOutput1 (t)"
*drop, element redefined
*"Sunflower seed"."Sunflower seed"."MainOutput1 (t)"
"Tangerines, mandarins, clementines, satsumas"."Tangerines, mandarins, clementines, satsumas"."MainOutput1 (t)"
"Tea"."Tea"."MainOutput1 (t)"
"Tobacco, unmanufactured"."Tobacco, unmanufactured"."MainOutput1 (t)"
"Tomatoes"."Tomatoes"."MainOutput1 (t)"
"Triticale"."Triticale"."MainOutput1 (t)"
"Vanilla"."Vanilla"."MainOutput1 (t)"
"Vetches"."Vetches"."MainOutput1 (t)"
"Walnuts, with shell"."Walnuts, with shell"."MainOutput1 (t)"
"Watermelons"."Watermelons"."MainOutput1 (t)"
"Wheat"."Wheat"."MainOutput1 (t)"
"Agave Fibres Nes"."Agave fibres nes"."MainOutput1 (t)"
"Almonds"."Almonds, with shell"."MainOutput1 (t)"
"Areca Nuts (Betel)"."Areca nuts"."MainOutput1 (t)"
"Brazil Nuts"."Brazil nuts, with shell"."MainOutput1 (t)"
"Broad Beans, Green"."Broad Beans, Green"."MainOutput1 (t)"
"Carobs"."Carobs"."MainOutput1 (t)"
"Cassava Leaves"."Cassava Leaves"."MainOutput1 (t)"
"Castor Beans"."Castor oil seed"."MainOutput1 (t)"
"Chicory Roots"."Chicory roots"."MainOutput1 (t)"
"Citrus Fruit Nes"."Fruit, citrus nes"."MainOutput1 (t)"
"Cow Peas, Dry"."Cow peas, dry"."MainOutput1 (t)"
"Fibre Crops Nes"."Fibre crops nes"."MainOutput1 (t)"
"Groundnuts In Shell"."Groundnuts, with shell"."MainOutput1 (t)"
"Kapok Fruit"."Kapok fruit"."MainOutput1 (t)"
"Karite Nuts (Sheanuts)"."Karite nuts (sheanuts)"."MainOutput1 (t)"
"Lupins"."Lupins"."MainOutput1 (t)"
"Mate"."Maté"."MainOutput1 (t)"
"Melonseed"."Melonseed"."MainOutput1 (t)"
"Natural Gums"."Gums, natural"."MainOutput1 (t)"
"Okra"."Okra"."MainOutput1 (t)"
"Pigeon Peas"."Pigeon peas"."MainOutput1 (t)"
"Pome Fruit Nes, Fresh"."Fruit, pome nes"."MainOutput1 (t)"
"Pulses Nes"."Pulses, nes"."MainOutput1 (t)"
"Quinoa"."Quinoa"."MainOutput1 (t)"
"Ramie"."Ramie"."MainOutput1 (t)"
"Raspberries"."Raspberries"."MainOutput1 (t)"
"Safflower Seed"."Safflower seed"."MainOutput1 (t)"
"Seed cotton"."Seed cotton"."MainOutput1 (t)"
"Stone Fruit Nes, Fresh"."Fruit, stone nes"."MainOutput1 (t)"
"String Beans"."String beans"."MainOutput1 (t)"
"Tallowtree Seeds"."Tallowtree seed"."MainOutput1 (t)"
"Taro (Coco Yam)"."Taro (cocoyam)"."MainOutput1 (t)"
"Tung Nuts"."Tung nuts"."MainOutput1 (t)"
"Yautia (Cocoyam)"."Yautia (cocoyam)"."MainOutput1 (t)"

*from NFP69
'Salt'.'Salt'."MainOutput1 (t)"
'Water'.'Water'."MainOutput1 (t)"
/;


set MatchCommAct_CommodEquivalentAct_Animals(Commodities,Activities,OutputsAnimals) "Set covering all animal commodities that are equivalent to main outputs from activities"
/
"Fish, Seafood"."All Fish and Seafood"."Meat (t)"
"Aquatic Animals, Others"."Aquatic Animals, Others"."Meat (t)"
"Aquatic Products, Other"."Aquatic Products, Other"."Meat (t)"
"Cephalopods"."Cephalopods"."Meat (t)"
"Crustaceans"."Crustaceans"."Meat (t)"
"Demersal Fish"."Demersal Fish"."Meat (t)"
"Freshwater Fish"."Freshwater Fish"."Meat (t)"
"Honey".Beehives."Honey (t)"
"Marine Fish, Other"."All other marine fish"."Meat (t)"
"Milk, Whole"."Cattle"."Milk (t)"
"Molluscs, Other"."Molluscs"."Meat (t)"
"Pelagic Fish"."Pelagic Fish"."Meat (t)"
"Pigmeat"."Pigs"."Meat (t)"
"Poultry Meat"."Chickens"."Meat (t)"
*Silk is currently not captured consistently - thus drop
*"Silk"."Silkworms"."Other animal output"
"Wool (Clean Eq.)"."Sheep"."Wool (t)"
"Beeswax"."Beehives"."Wax (t)"
"Eggs, hen, in shell"."Chickens"."Eggs (t)"
"Honey, natural".Beehives."Honey (t)"
"Meat of Swine"."Pigs"."Meat (t)"
"Meat Poultry Fresh"."Chickens"."Meat (t)"
"Meat Sheep Fresh"."Sheep"."Meat (t)"
"Meat, ass"."Asses"."Meat (t)"
"Meat, cattle"."Cattle"."Meat (t)"
"Meat, chicken"."Chickens"."Meat (t)"
"Meat, duck"."Ducks"."Meat (t)"
"Meat, game"."Game"."Meat (t)"
"Meat, goat"."Goats"."Meat (t)"
"Meat, goose and guinea fowl"."Geese and guinea fowls"."Meat (t)"
"Meat, horse"."Horses"."Meat (t)"
"Meat, pig"."Pigs"."Meat (t)"
"Meat, pork"."Pigs"."Meat (t)"
"Meat, rabbit"."Rabbits and hares"."Meat (t)"
"Meat, sheep"."Sheep"."Meat (t)"
"Meat, turkey"."Turkeys"."Meat (t)"
"Biological Ass Meat"."Asses"."Meat (t)"
"Biological Buffalo Meat"."Buffaloes"."Meat (t)"
"Biological Camel Meat"."Camels"."Meat (t)"
"Biological Cattle Meat"."Cattle"."Meat (t)"
"Biological Chicken Meat"."Chickens"."Meat (t)"
"Biological Duck Meat"."Ducks"."Meat (t)"
"Biological Geese Meat"."Geese and guinea fowls"."Meat (t)"
"Biological Goat Meat"."Goats"."Meat (t)"
"Biological Horse Meat"."Horses"."Meat (t)"
"Biological Mule Meat"."Mules"."Meat (t)"
"Biological Other Camel"."Camelids, other"."Meat (t)"
"Biological Other Poultry"."All Poultry"."Meat (t)"
"Biological Pig Meat"."Pigs"."Meat (t)"
"Biological Rodents"."Rodents, other"."Meat (t)"
"Biological Sheep Meat"."Sheep"."Meat (t)"
"Biological Turkey Meat"."Turkeys"."Meat (t)"
"Buffalo Meat"."Buffaloes"."Meat (t)"
"Buffalo Milk"."Buffaloes"."Milk (t)"
"Camel Milk"."Camels"."Milk (t)"
"Goat Milk"."Goats"."Milk (t)"
"Indigenous Ass Meat"."Asses"."Meat (t)"
"Indigenous Buffalo Meat"."Buffaloes"."Meat (t)"
"Indigenous Camel Meat"."Camels"."Meat (t)"
"Indigenous Cattle Meat"."Cattle"."Meat (t)"
"Indigenous Chicken Meat"."Chickens"."Meat (t)"
"Indigenous Duck Meat"."Ducks"."Meat (t)"
"Indigenous Geese Meat"."Geese and guinea fowls"."Meat (t)"
"Indigenous Goat Meat"."Goats"."Meat (t)"
"Indigenous Horse Meat"."Horses"."Meat (t)"
"Indigenous Mule Meat"."Mules"."Meat (t)"
"Indigenous Other Camel"."Camelids, other"."Meat (t)"
"Indigenous Pigmeat"."Pigs"."Meat (t)"
"Indigenous Rodents"."Rodents, other"."Meat (t)"
"Indigenous Sheep Meat"."Sheep"."Meat (t)"
"Indigenous Turkey Meat"."Turkeys"."Meat (t)"
"Meat, Asses"."Asses"."Meat (t)"
"Meat, Camels"."Camels"."Meat (t)"
"Meat, Mules"."Mules"."Meat (t)"
"Meat, Other Camelids"."Camelids, other"."Meat (t)"
"Meat, Other Rodents"."Rodents, other"."Meat (t)"
"Meat, Pigeon Oth.Birds"."Pigeons, other birds"."Meat (t)"
"Other Rodents"."Rodents, other"."Meat (t)"
"Pigeons, Other Birds"."Pigeons, other birds"."Meat (t)"
*Silk is currently not captured consistently - thus drop
*"Silkworms"."Silkworms"."Other animal output"
"Spermaceti"."Spermaceti"."Meat (t)"

*added from set5:
"Hair Of Horses"."Horses"."HidesSkins (t)"
"Animal fats"."All Animals"."Fat (t)"
"Bovine Meat"."Cattle and buffaloes"."Meat (t)"
"Eggs"."Chickens"."Eggs (t)"
"Eggs Excl Hen"."Pigeons, other birds"."Eggs (t)"
"Fats, Animals, Raw"."All Animals"."Fat (t)"
"Hides and skins"."All Animals"."HidesSkins (t)"
"Meat"."All Animals"."Meat (t)"

"Meat, Aquatic Mammals"."Aquatic Animals"."Meat (t)"
"Meat, Other"."All other Animals"."Meat (t)"
"Milk - Excluding Butter"."All Ruminants"."Milk (t)"
"Mutton & Goat Meat"."Sheep and Goats"."Meat (t)"
"Offals"."All Animals"."Offals (t)"
"Offals, Edible"."All Animals"."Offals (t)"
"Eggs in The Shell"."Chickens"."Eggs (t)"
"Eggs, other bird, in shell"."Pigeons, other birds"."Eggs (t)"
"Fat, camels"."Camels"."Fat (t)"
"Fat, cattle"."Cattle"."Fat (t)"
"Fat, pigs"."Pigs"."Fat (t)"
"Hair, fine"."Camelids, other"."HidesSkins (t)"
"Hair, goat, coarse"."Goats"."HidesSkins (t)"
"Hides, buffalo, dry salted"."Buffaloes"."HidesSkins (t)"
"Hides, buffalo, fresh"."Buffaloes"."HidesSkins (t)"
"Hides, buffalo, wet salted"."Buffaloes"."HidesSkins (t)"
"Hides, camel, nes"."Camels"."HidesSkins (t)"
"Hides, camel, wet salted"."Camels"."HidesSkins (t)"
"Hides, cattle, fresh"."Cattle"."HidesSkins (t)"
"Hides, cattle, wet salted"."Cattle"."HidesSkins (t)"
"Hides, horse, dry salted"."Horses"."HidesSkins (t)"
"Hides, nes"."All Animals"."HidesSkins (t)"
"Meat Bovine Fresh"."Cattle and buffaloes"."Meat (t)"
"Milk Fresh"."Cattle"."Milk (t)"
"Milk, whole fresh cow"."Cattle"."Milk (t)"
"Milk, whole fresh sheep"."Sheep"."Milk (t)"
"Offals Edibl Fresh"."All Animals"."Offals (t)"
"Offals, edible, cattle"."Cattle"."Offals (t)"
"Offals, edible, goats"."Goats"."Offals (t)"
"Offals, liver chicken"."Chickens"."Offals (t)"
"Offals, liver duck"."Ducks"."Offals (t)"
"Offals, liver geese"."Geese and guinea fowls"."Offals (t)"
"Offals, other camelids"."Camelids, other"."Offals (t)"
"Offals, pigs, edible"."Pigs"."Offals (t)"
"Offals, sheep,edible"."Sheep"."Offals (t)"
"Other Meat"."All Animals"."Meat (t)"
"Ovine Meat"."All Poultry"."Meat (t)"
"Skins, calve, wet salted"."Cattle"."HidesSkins (t)"
"Skins, goat, fresh"."Goats"."HidesSkins (t)"
"Skins, goat, wet salted"."Goats"."HidesSkins (t)"
"Skins, sheep, dry salted"."Sheep"."HidesSkins (t)"
"Skins, sheep, fresh"."Sheep"."HidesSkins (t)"
"Skins, sheep, wet salted"."Sheep"."HidesSkins (t)"
"Skins, sheep, with wool"."Sheep"."HidesSkins (t)"
"Total Meat"."All Animals"."Meat (t)"
"Wool, degreased"."Sheep"."Wool (t)"
"Wool, greasy"."Sheep"."Wool (t)"
"Camel Hides, Fresh"."Camels"."HidesSkins (t)"
"Fat, Buffalo"."Buffaloes"."Fat (t)"
"Fat, Goats"."Goats"."Fat (t)"
"Fat, Other Camelids"."Camelids, other"."Fat (t)"
"Fat, Poultry"."Chickens"."Fat (t)"
"Fat Of Sheep"."Sheep"."Fat (t)"
"Fine Goat Hair"."Goats"."HidesSkins (t)"
"Hide Dry-Salted"."All Animals"."HidesSkins (t)"
"Hide Wet-Salted"."All Animals"."HidesSkins (t)"
"Hides, camel, dry salted"."Camels"."HidesSkins (t)"
"Hides, cattle, dry salted"."Cattle"."HidesSkins (t)"
"Hides Nes Cattle"."Cattle"."HidesSkins (t)"
"Hides Of Asses Fresh"."Asses"."HidesSkins (t)"
"Hides Of Mules Fresh"."Mules"."HidesSkins (t)"
"Hides Unspecified Horses"."Horses"."HidesSkins (t)"
"Hides, horse, wet salted"."Horses"."HidesSkins (t)"
"Skins, pig, dry salted"."Pigs"."HidesSkins (t)"
"Skin Nes Pigs"."Pigs"."HidesSkins (t)"
"Skin Nes Sheep"."Sheep"."HidesSkins (t)"
"Skins, pig, wet salted"."Pigs"."HidesSkins (t)"
"Skins Dry-Salt Calves"."Cattle"."HidesSkins (t)"
"Skins Dry-Salted Goats"."Goats"."HidesSkins (t)"
"Skins Fresh Of Calves"."Cattle"."HidesSkins (t)"
"Skins Nes Calves"."Cattle"."HidesSkins (t)"
"Skins Nes Goats"."Goats"."HidesSkins (t)"
"Standardized Milk"."Cattle"."Milk (t)"
"Offals Liver Turkeys"."Turkeys"."Offals (t)"
"Offals Nes"."All Animals"."Offals (t)"
"Offals, edible, Buffalo"."Buffaloes"."Offals (t)"
"Offals, edible, Camel"."Camels"."Offals (t)"
"Offals, Horse"."Horses"."Offals (t)"
"Pigskins, Fresh"."Pigs"."HidesSkins (t)"
"Rabbit Meat Biological"."Rabbits and hares"."Meat (t)"
"Rabbit Meat Indigenous"."Rabbits and hares"."Meat (t)"
"Rabbit Skins"."Rabbits and hares"."HidesSkins (t)"
/;

*set 7
set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass) "Set matching activities and commodities for all commodities that are captured together with their derived products and expressed in primary product equivalents"
*contains crop commodities only, hence only one file needed for crops
*This captures all commodities that are captured together with their derived products and expressed in primary product equivalents
*         this thus captures a number of products derived from one activity in prim prod eq of that activity - thus, linkage commod - act is direct in quantities.
*         BUT: no information on commod composition and thus on nutrient contents - some assumption needed on that. resp. check with nutr reported in FAOSTAT for per cap consumption, for example.
/
"Apples and products"."Apples"."MainOutput1 (t)"
"Barley and products"."Barley"."MainOutput1 (t)"
"Cassava and products"."Cassava"."MainOutput1 (t)"
"Cassava Equivalent"."Cassava"."MainOutput1 (t)"
"Cocoa Beans and products"."Cocoa, beans"."MainOutput1 (t)"
"Coconuts - Incl Copra"."Coconuts"."MainOutput1 (t)"
"Coffee and products"."Coffee, green"."MainOutput1 (t)"
"Coffee Green+Roast"."Coffee, green"."MainOutput1 (t)"
"Grapefruit and products"."Grapefruit (inc. pomelos)"."MainOutput1 (t)"
"Grapes and products (excl wine)"."Grapes"."MainOutput1 (t)"
"Lemons, Limes and products"."Lemons and limes"."MainOutput1 (t)"
"Maize and products"."Maize"."MainOutput1 (t)"
"Millet and products"."Millet"."MainOutput1 (t)"
"Nuts and products"."All Nuts"."MainOutput1 (t)"
"Pineapples and products"."Pineapples"."MainOutput1 (t)"
"Potatoes and products"."Potatoes"."MainOutput1 (t)"
"Rice (Milled Equivalent)"."Rice, paddy"."MainOutput1 (t)"
"Rice - total  (Rice milled equivalent)"."Rice, paddy"."MainOutput1 (t)"
"Rye and products"."Rye"."MainOutput1 (t)"
"Sorghum and products"."Sorghum"."MainOutput1 (t)"
"Tea Nes"."Tea"."MainOutput1 (t)"
"Tomatoes and products"."Tomatoes"."MainOutput1 (t)"
"Wheat and products"."Wheat"."MainOutput1 (t)"
/;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Define new variables capturing commodities in primary product equivalents

$ontext;
The following variables are needed for this, cf. _V6_VariablesAndParameters, section 2.12 for their definition
*no need to add activity and output dimensions, these informations are captured in the relevant matching sets as defined in above

*2.12) Commodities expressed in primary product equivalents
*the following variables are expressed in prim prod equivalents, derived from the corresponding variables that are reported in commodity quantities (cf. definitions above), by means of extraction rates, etc.
VPrimProd_Commod_Quantity(Regions,Commodities,ProductionSystems,ProductionConditions)            total PRIMARY PRODUCT EQUIVALENT commodity quantity                        - UNIT: tons

VPrimProd_Commod_Production(Regions,Commodities,ProductionSystems,ProductionConditions)          total PRIMARY PRODUCT EQUIVALENT quantity of commodity production          - UNIT: tons
VPrimProd_Commod_StockChanges(Regions,Commodities,ProductionSystems,ProductionConditions)        total PRIMARY PRODUCT EQUIVALENT quantity of commodity stock changes       - UNIT: tons
VPrimProd_Commod_Food(Regions,Commodities,ProductionSystems,ProductionConditions)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for food       - UNIT: tons
VPrimProd_Commod_Feed(Regions,Commodities,ProductionSystems,ProductionConditions)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for feed       - UNIT: tons
VPrimProd_Commod_Seed(Regions,Commodities,ProductionSystems,ProductionConditions)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for seed       - UNIT: tons
VPrimProd_Commod_Processing(Regions,Commodities,ProductionSystems,ProductionConditions)          total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for processing - UNIT: tons
VPrimProd_Commod_Waste(Regions,Commodities,ProductionSystems,ProductionConditions)               total PRIMARY PRODUCT EQUIVALENT quantity of commodity lost or wasted      - UNIT: tons
VPrimProd_Commod_Other(Regions,Commodities,ProductionSystems,ProductionConditions)               total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for other uses - UNIT: tons

VPrimProd_ImportQuantity(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions)   total PRIMARY PRODUCT EQUIVALENT commodity quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VPrimProd_ExportQuantity(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions)   total PRIMARY PRODUCT EQUIVALENT commodity quantity EXPORTED from Regions INTO Regions_2 - UNIT: tons
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Additional parameters capturing the commodity tree characteristics: share of commodity tree branches and extraction rates
*the second commodity dimension is always on the higher level, i.e. further down the commodity tree, i.e. one level more than the first commodity dimension, thus, e.g. "wheat,"Wheat flour", etc.
*cf. _V6_VariablesAndParameters, section 1.5 for their definition

$ontext;
*1.5) Commodity tree parameters
Commod_ProductionShare(Regions,Commodities,Commodities_2,ProductionSystems)            production share of different commodities from the same higher level commodity in the commodity tree - UNIT: share (i.e. percentage divided by 100)
Commod_ExtractionRate(Regions,Commodities,Commodities_2,ProductionSystems)             extraction rate of a commodity from its higher level source commodity                                - UNIT: share (i.e. percentage divided by 100)

*and define a parameter that captures how aggregate commodities are disaggregated into primary activities (e.g. "Bread" comes from "All Cereals" and those have to be disaggregated to "Wheat", "Rye", etc.
*assumptions on this are often very shaky and for now, much is determined by expert quess from Adrian Muller from August 2019 -
*        or where sensible, it is allocated according to the relative shares of single commodities in the aggregate, if this information is available
Commod_SingleInAggregateCommodShares(Regions,Commodities,Commodities_2,ProductionSystems)  Share of single commodities in aggregate commodities - UNIT: share (i.e. percentage divided by 100)
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Transform commodities into main outputs from activities

$ontext;
remember the new sets we have - this helps to design the calculations that follow
thus: repeat the characteristics of the matching and the sets used to do this from above:

*set 1
*This captures the cases where commodities correspond to an aggregate of some non primary commodities - for prim prod quantities of outputs from activities, we thus need to disaggregate and to
*         translate the commodities to the outputs from activities via commodity trees
*contains crop commodities only, hence only one file needed for crops
*These commodities have first to be separated on commodity level to get to non-aggregate commodites,
*         then they are further transformed as the corresponding non-aggregate commodity in set 3.
set SubsetCommod_MatchWithAct_AggregateCommodities(Commodities)
set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
*NO! - we choose a different approach: first tranlate them inot aggregates of prim prods, THEN separate - do this by gross assumptions on the extraction rates (e.g. taking "Flour, Wheat" for Flour from cereals in general, etc.)

*set 2
*This captures the cases where commodities correspond to prim prod outputs of aggregate activities and thus need to be allocated to outputs from single activities
*contains crop commodities only, hence only one file needed for crops
*These commodities have first to be separated on commodity level to get to non-aggregate commodites, that are already equivalent to the outputs from activities
*         then they are further transformed to the equivalent output from activities in set 6.
set SubsetCommod_MatchWithAct_AggregateActivities(Commodities)
set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass)

*set 3
*This captures the cases of well defined coproducts
*contains crop commodities only, hence only one file needed for crops
*These commodities are transformed into outputs from activities by means of the detailed information from the adequate commodity trees.
*         Here, we thus have to trace byproducts to avoid double-counting and to avoid loosing nutrients, etc.
set SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities)
set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)

*set 4
*This captures the most complex cases such as fats and alcohol
*contains crop commodities only, hence only one file needed for crops
*no particular rule - but are not that many
set SubsetCommod_MatchWithAct_ComplexCases(Commodities)
set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass)

*set 5
*This covers the more complex animal commodities
*contains animal commodities only, hence only one file needed for animals
*no particular rule - quite a few....
set SubsetCommod_MatchWithAct_ComplexAnimalCommodities(Commodities)
set MatchCommAct_ComplexAnimalCommodities(Commodities,Activities,OutputsAnimals)

*set 6
*the following covers crop and animal commodities, hence the need for two matching files
*This captures all commodities that are equivalent to main outputs from activities
*ok, for this set, Primary product equivalents of main outputs from activities just equal the commodity quantities
set SubsetCommod_MatchWithAct_CommodEquivalentAct(Commodities)
set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
set MatchCommAct_CommodEquivalentAct_Animals(Commodities,Activities,OutputsAnimals)

*set 7
*contains crop commodities only, hence only one file needed for crops
*This captures all commodities that are captured together with their derived products and expressed in primary product equivalents
*         this thus captures a number of products derived from one activity in prim prod eq of that activity - thus, linkage commod - act is direct in quantities.
*         BUT: no information on commod composition and thus on nutrient contents - some assumption needed on that. resp. check with nutr reported in FAOSTAT for per cap consumption, for example.
*ok, for this set, Primary product equivalents of main outputs from activities just equal the commodity quantities
*         However, nutrient contents etc. cannot be derived directly from prim prod quantities, as the commodity is a composition of various products;
*                 thus, for this, additional assumptions on the shares are needed, but not for the linkage comodities to activities
set SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct(Commodities)
set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCrops)
$offtext;


*Parameter ExtractionRate_CommodityTree(Regions,Commodities);
*already declared in the general parameter file


*4.1) set 1: MatchCommAct_AggregateCommodities(CommoditySOLmV5,ActivitySOLmV5,OutputTypeSOLmV5)
*set 1: These commodities have first to be separated on commodity level to get to non-aggregate commodites,
*OR - as we do it now: we assign to aggregates of primary products and separate then.
*for many aggregates we use extraction rates inspired by single crop examples, and gross assumptions on the composition
*less important commodities are left out
*0.7 for beer: this is the step from barley to malt
ExtractionRate_CommodityTree(Countries,"Beer") = 6.55*0.7;
ExtractionRate_CommodityTree(Countries,"Beer of barley") = 6.55*0.7;
ExtractionRate_CommodityTree(Countries,"Brans") = 0.1;
ExtractionRate_CommodityTree(Countries,"Bran, Cereals") = 0.1;
ExtractionRate_CommodityTree(Countries,"Bran, Pulses") = 0.1;
ExtractionRate_CommodityTree(Countries,"Cereals, Other") = 0.6;
*        "Default composition: 68 Popcorn, 89 Buckwheat, 90 Flour, buckwheat, 91 Bran, buckwheat, 92 Quinoa, 94 Fonio, 95 Flour, fonio, 96 Bran, fonio, 97 Triticale, 98 Flour, triticale, 99 Bran, triticale, 101 Canary seed, 103 Grain, mixed,
*        104 Flour, mixed grain, 105 Bran, mixed grains, 108 Cereals, nes, 111 Flour, cereals, 112 Bran, cereals nes, 113 Cereal preparations, nes"
ExtractionRate_CommodityTree(Countries,"Citrus, Other") = 0.3;
*This is 2614."Citrus, Other": "Default composition: 512 Fruit, citrus nes, 513 Juice, citrus, single strength, 514 Juice, citrus, concentrated"
ExtractionRate_CommodityTree(Countries,"Oilcrops Oil, Other") = 0.3;
*the specification for this is as follows:
*2586."Oilcrops Oil, Other"
*        "Default composition: 264 Butter of karite nuts, 266 Oil, castor beans, 276 Oil, tung nuts, 278 Oil, jojoba, 281 Oil, safflower, 297 Oil, poppy,
*        306 Vegetable tallow, 307 Oil, stillingia, 313 Oil, kapok, 334 Oil, linseed, 337 Oil, hempseed, 340 Oil, vegetable origin nes, 664 Cocoa, butter, 1241 Margarine, liquid, 1242 Margarine, short,
*        1273 Castor oil, hydrogenated (opal wax), 1274 Oil, boiled etc, 1275 Oil, hydrogenated"
ExtractionRate_CommodityTree(Countries,"Oilseed Cakes, Other") = 0.7;
*the specification for this is as follows:
*2598."Oilseed Cakes, Other"
*        "Default composition: 37 Cake, rice bran, 61 Cake, maize, 282 Cake, safflower, 298 Cake, poppy seed, 314 Cake, kapok, 335 Cake, linseed, 338 Cake, hempseed, 341 Cake, oilseeds nes"
ExtractionRate_CommodityTree(Countries,"Rape and Mustard Oil") = 0.37;
ExtractionRate_CommodityTree(Countries,"Rape and mustard cake") = 0.63;
*"Bread"
*"Feed, pulp of fruit"
*"Feed, vegetable products nes"
ExtractionRate_CommodityTree(Countries,"Flour, cereals") = 0.8;
ExtractionRate_CommodityTree(Countries,"Flour, pulses") = 0.8;
ExtractionRate_CommodityTree(Countries,"Flour, roots and tubers nes") = 0.25;
*"Fruit, dried nes"
*"Fruit, prepared nes"
ExtractionRate_CommodityTree(Countries,"Juice, citrus, single strength") = 0.5;
ExtractionRate_CommodityTree(Countries,"Juice, citrus, concentrated") = 0.15;
ExtractionRate_CommodityTree(Countries,"Juice, fruit nes") = 0.5;
*"Nuts, prepared (exc. groundnuts)"
ExtractionRate_CommodityTree(Countries,"Oilseed Cake Meal") = 0.6;
ExtractionRate_CommodityTree(Countries,"Oilseed Cake nes") = 0.7;
ExtractionRate_CommodityTree(Countries,"Rape+Mustard Oils") = 0.37;
*"Straw husks"
*"Vegetables in vinegar"
*"Vegetables, canned nes"
*"Vegetables, dehydrated"
*"Vegetables, dried nes"
ExtractionRate_CommodityTree(Countries,"Vegetables, fresh nes") = 1;
*"Vegetables, fresh or dried products nes"
*"Vegetables, frozen"
*"Vegetables, homogenized preparations"
*"Vegetables, preserved nes"
*"Vegetables, preserved, frozen"
*"Vegetables, temporarily preserved"
*"Breakfast Cereals"
ExtractionRate_CommodityTree(Countries,"Flour, Fruit") = 0.15;
ExtractionRate_CommodityTree(Countries,"Flour/Meal Of Oilseeds") = 0.9;
*"Fruit Tropical Dried Nes"
*"Nuts, all, shelled"
*"Roots And Tubers Dried"
ExtractionRate_CommodityTree(Countries,"Flour, mixed grain") = 0.8;
*additional (co-)products, added to have full commodity trees, while they are not part in FAOSTAT:
*dregs: assume something - the first factor 0.7 is from barley to malt, etc.; the second is the dregs from beer making - quite some residues remain
ExtractionRate_CommodityTree(Countries,"Dregs - beer") = 0.7*0.7;
ExtractionRate_CommodityTree(Countries,"Citrus pulp") = 0.5;
ExtractionRate_CommodityTree(Countries,"Fruit pulp") = 0.5;
ExtractionRate_CommodityTree(Countries,"Brans, mixed grain") = 0.1;



*for Set1
VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_AggregateCommodities,ProductionSystems,ProductionConditions)
                 $ExtractionRate_CommodityTree(Regions,SubsetCommod_MatchWithAct_AggregateCommodities)
         = VCommod_Quantity.l(Regions,SubsetCommod_MatchWithAct_AggregateCommodities,ProductionSystems,ProductionConditions)
                 /ExtractionRate_CommodityTree(Regions,SubsetCommod_MatchWithAct_AggregateCommodities);


*4.2) set 2: MatchCommAct_AggregateActivities(CommoditySOLmV5,ActivitySOLmV5,OutputTypeSOLmV5)
*set 2: These commodities have first to be separated on commodity level to get to non-aggregate commodites, that are already equivalent to activities
*OR - as we do it now: we assign to aggregates of primary products and separate then - the extractionRate is always 1 in this case.
VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_AggregateActivities,ProductionSystems,ProductionConditions)
         = VCommod_Quantity.l(Regions,SubsetCommod_MatchWithAct_AggregateActivities,ProductionSystems,ProductionConditions);
*for completeness, we also assign extraction rates here: equaling 1:
ExtractionRate_CommodityTree(Countries,SubsetCommod_MatchWithAct_AggregateActivities)
         = 1;



*4.3) set 3: SubsetCommod_MatchWithAct_WellDefinedCoProducts(CommoditySOLmV5)
*set 3: These commodities are transformed into activities by means of the detailed information from the adequate commodity trees, i.e. shares in branches and extraction rates;
*to get primary products from commodities, only the extraction rates are needed - but then some allocation needs to be added to avoid double counting.

*the sets defined below give some structure, but are not needed for this calculation, which can be done as follows:

*information on levels, etc. are given in suitable subsets and matching sets, hence no need to add this here in the paramter name or additional dimensions
*furthermore: no need to report the parent commodities as a separate dimension in the extraction rates, as this is also captured in the matching sets
*and use here: total extraction rates, i.e. if it is from a level 2 commodity, it is the product of the extraction rate from level 1 to level 2, and from primary product to level 1
*the level specific extraction rates can then be given in additional parameters specifically named "..._Level1", "..._Level2" or so, etc.


*NOTE: extraction rates level 2: given by multiplying the level2 and level1 factors to have the extraction rates from the prim prod: first factor: level2-level1; second factor: level1-level0

*BELOW: Branch shares currently not needed - hence star them out


*Set 3:
*assume 80% go into this branch
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Copra","Coconuts","Main crop") = 0.8;
ExtractionRate_CommodityTree(Countries,"Copra") = 0.2;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Coconuts, desiccated","Coconuts","Main crop") = 0.2;
ExtractionRate_CommodityTree(Countries,"Coconuts, desiccated") = 0.2;
*branch share 1, as all branches result in this same output in shells: thus, total, it is 1
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Coconut shells","Coconuts","Main crop") = 1;
*extraction rates for shells: assume 20%, as the description of FAOSTAT reports 40-70% of the husked coconot to go into copra/flesh, to be added the liquid, thus assume that total, this is about 80%, leaving 20% for the shell
ExtractionRate_CommodityTree(Countries,"Coconut shells") = 0.2;
*MISSING!!?? Coconut milk?? - the liquid in the coconut - with shells and copra each 20%, this should be 60% in fresh weight - maybe another 10% in DM!!
*the following, currently not covered, as according to the definiton of 249."Coconuts", the mesocarp (which contains the coir) has been removed, and only the hard shell is included:
*"Coir"."Coir"."Main crop"
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Coconut Oil","Copra","Coconuts","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Copra Cake","Copra","Coconuts","Main crop") = 1;
*the following two are: level2, level1 for it is "Copra":
*seemingly 3% processing waste that is lost?
ExtractionRate_CommodityTree(Countries,"Coconut Oil") = 0.61*0.2;
ExtractionRate_CommodityTree(Countries,"Copra Cake") = 0.36*0.2;
*Same commodities, other names:
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil, coconut (copra)","Copra","Coconuts","Main crop") = 1;
ExtractionRate_CommodityTree(Countries,"Oil, coconut (copra)") = 0.61*0.2;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cake, copra","Copra","Coconuts","Main crop") = 1;
ExtractionRate_CommodityTree(Countries,"Cake, copra") = 0.36*0.2;

*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cotton lint","Seed cotton","Main crop") = 1;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cottonseed","Seed cotton","Main crop") = 1;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cotton waste","Seed cotton","Main crop") = 1;
*processing waste: less than 7%, here: 2%
ExtractionRate_CommodityTree(Countries,"Cotton lint") = 0.35;
ExtractionRate_CommodityTree(Countries,"Cottonseed") = 0.63;
ExtractionRate_CommodityTree(Countries,"Cotton waste") = 0.02;
*level2
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cottonseed Cake","Cottonseed","Seed cotton","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cottonseed Oil","Cottonseed","Seed cotton","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cotton linter","Cottonseed","Seed cotton","Main crop") = 1;
*rest - waste? seemingly less than 10% cotton linters - but then here still missing: 22% waste?!
*the following two are: level2, level1 for it is "Cottonseed":
ExtractionRate_CommodityTree(Countries,"Cottonseed Cake") = 0.51*0.63;
ExtractionRate_CommodityTree(Countries,"Cottonseed Oil") = 0.16*0.63;
ExtractionRate_CommodityTree(Countries,"Cotton linter") = 0.1*0.63;
*Same commodities, other names:
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cake, cottonseed","Cottonseed","Seed cotton","Main crop") = 1;
ExtractionRate_CommodityTree(Countries,"Cake, cottonseed") = 0.51*0.63;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil, cottonseed","Cottonseed","Seed cotton","Main crop") = 1;
ExtractionRate_CommodityTree(Countries,"Oil, cottonseed") = 0.16*0.63;
*not used - not clear where in the commodity tree
*"Cotton, carded, combed","Seed cotton","Main crop"


*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Groundnuts (Shelled Eq)","Groundnuts, with shell","Main crop") = 1;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Groundnut shells","Groundnuts, with shell","Main crop") = 1;
ExtractionRate_CommodityTree(Countries,"Groundnuts (Shelled Eq)") = 0.7;
ExtractionRate_CommodityTree(Countries,"Groundnut shells") = 0.3;
*same commodity, named differently:
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Groundnuts, shelled","Groundnuts, with shell","Main crop") = 1;
ExtractionRate_CommodityTree(Countries,"Groundnuts, shelled") = 0.7;
*NOT USED
*"Groundnuts Total Shelled","Groundnuts, with shell","Main crop"
*assume 85% go into this branch
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Groundnut Cake","Groundnuts (Shelled Eq)","Groundnuts, with shell","Main crop") = 0.85;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Groundnut Oil","Groundnuts (Shelled Eq)","Groundnuts, with shell","Main crop") = 0.85;
*the following two are: level2, level1 for it is "Groundnuts (Shelled Eq)":
ExtractionRate_CommodityTree(Countries,"Groundnut Cake") = 0.54*0.7;
ExtractionRate_CommodityTree(Countries,"Groundnut Oil") = 0.43*0.7;
*same commodity, named differently:
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cake, groundnuts","Groundnuts (Shelled Eq)","Groundnuts, with shell","Main crop") = 0.85;
ExtractionRate_CommodityTree(Countries,"Cake, groundnuts") = 0.54*0.7;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil, groundnut","Groundnuts (Shelled Eq)","Groundnuts, with shell","Main crop") = 0.85;
ExtractionRate_CommodityTree(Countries,"Oil, groundnut") = 0.43*0.7;
*assume 10% go into this branch
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Peanut butter","Groundnuts (Shelled Eq)","Groundnuts, with shell","Main crop") = 0.1;
*the remaining 15% of this extraction are not traced here - to be added later
ExtractionRate_CommodityTree(Countries,"Peanut butter") = 0.85*0.7;
*assume 5% go into this branch
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Prepared Groundnuts","Groundnuts (Shelled Eq)","Groundnuts, with shell","Main crop") = 0.05;
ExtractionRate_CommodityTree(Countries,"Prepared Groundnuts") = 1*0.7;

*assume 85% goes into this branch
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Flour, maize","Maize","Main crop") = 0.85;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Bran, maize","Maize","Main crop") = 0.85;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Germ, maize","Maize","Main crop") = 0.85;
*1% losses?
ExtractionRate_CommodityTree(Countries,"Flour, maize") = 0.82;
ExtractionRate_CommodityTree(Countries,"Bran, maize") = 0.11;
ExtractionRate_CommodityTree(Countries,"Germ, maize") = 0.06;
*Level2
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cake, maize","Germ, maize","Maize","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil, maize","Germ, maize","Maize","Main crop") = 1;
*3% losses?
*the following two are: level2, level1 for it is "Germ, maize":
ExtractionRate_CommodityTree(Countries,"Cake, maize") = 0.52*0.06;
ExtractionRate_CommodityTree(Countries,"Oil, maize") = 0.45*0.06;
*same commodity, named differently:
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Maize Germ Oil","Germ, maize","Maize","Main crop") = 1;
ExtractionRate_CommodityTree(Countries,"Maize Germ Oil") = 0.45*0.06;

*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Maize Gluten","Flour, maize","Maize","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Starch Of Maize","Flour, maize","Maize","Main crop") = 1;
*15% losses?
*the following two are: level2, level1 for it is "Flour, maize":
ExtractionRate_CommodityTree(Countries,"Maize Gluten") = 0.1*0.82;
ExtractionRate_CommodityTree(Countries,"Starch Of Maize") = 0.75*0.82;
*NOT USED
*"Popcorn","Maize","Main crop"



*assume 95% goes into this branch
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Olive Oil","Olives","Main crop") = 0.95;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Olive residues","Olives","Main crop") = 0.95;
*40% losses - kernels? Or what?
ExtractionRate_CommodityTree(Countries,"Olive Oil") = 0.2;
ExtractionRate_CommodityTree(Countries,"Olive residues") = 0.4;
*same commodity, named differently:
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil, olive, virgin","Olives","Main crop") = 0.95;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Olive Oil,Total","Olives","Main crop") = 0.95;
ExtractionRate_CommodityTree(Countries,"Oil, olive, virgin") = 0.2;
ExtractionRate_CommodityTree(Countries,"Olive Oil,Total") = 0.2;
*level2
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil, olive residues","Olive residues","Olives","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Pressed olive residues","Olive residues","Olives","Main crop") = 1;
*95% missing - assumingly this is pressed residues, thus just add those:
*the following two are: level2, level1 for it is "Olive residues":
ExtractionRate_CommodityTree(Countries,"Oil, olive residues") = 0.05*0.4;
ExtractionRate_CommodityTree(Countries,"Pressed olive residues") = 0.95*0.4;


*assume 95% goes into this branch
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Palm kernels","Oil, palm fruit","Main crop") = 1;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Palm Oil","Oil, palm fruit","Main crop") = 1;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil palm fruit pulp","Oil, palm fruit","Main crop") = 1;
*75% losses - these need to be palm fruit shell residues/Cake (name, commodity?) - so we just add this cmmodity: Oil palm fruit pulp
ExtractionRate_CommodityTree(Countries,"Palm kernels") = 0.06;
ExtractionRate_CommodityTree(Countries,"Palm Oil") = 0.19;
ExtractionRate_CommodityTree(Countries,"Oil palm fruit pulp") = 0.75;
*same commodity, named differently:
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil, palm","Oil, palm fruit","Main crop") = 1;
ExtractionRate_CommodityTree(Countries,"Oil, palm") = 0.19;
*Level2
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Palmkernel Oil","Palm kernels","Oil, palm fruit","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Palmkernel Cake","Palm kernels","Oil, palm fruit","Main crop") = 1;
*2% lost?:
ExtractionRate_CommodityTree(Countries,"Palmkernel Oil") = 0.46*0.06;
ExtractionRate_CommodityTree(Countries,"Palmkernel Cake") = 0.52*0.06;
*same commodity, named differently:
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil, palm kernel","Palm kernels","Oil, palm fruit","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Palm kernel oil","Palm kernels","Oil, palm fruit","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cake, palm kernel","Palm kernels","Oil, palm fruit","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cake, Palm Kernels","Palm kernels","Oil, palm fruit","Main crop") = 1;
ExtractionRate_CommodityTree(Countries,"Oil, palm kernel") = 0.46*0.06;
ExtractionRate_CommodityTree(Countries,"Palm kernel oil") = 0.46*0.06;
ExtractionRate_CommodityTree(Countries,"Cake, palm kernel") = 0.52*0.06;
ExtractionRate_CommodityTree(Countries,"Cake, Palm Kernels") = 0.52*0.06;


*assume 50% goes into this branch
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Milled Paddy Rice","Rice, paddy","Main crop") = 0.5;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Bran, Rice","Rice, paddy","Main crop") = 0.5;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Rice hulls","Rice, paddy","Main crop") = 0.5;
ExtractionRate_CommodityTree(Countries,"Milled Paddy Rice") = 0.67;
ExtractionRate_CommodityTree(Countries,"Bran, Rice") = 0.08;
ExtractionRate_CommodityTree(Countries,"Rice hulls") = 0.25;

ExtractionRate_CommodityTree(Countries,"Rice (Milled Equivalent)") = 0.67;

*assume 50% goes into this branch
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Rice, Husked","Rice, paddy","Main crop") = 0.5;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Rice hulls","Rice, paddy","Main crop") = 0.5;
*CHECK LATER: something is strange with rice - thus drop the strange things, keeep tthe direct only
*ExtractionRate_CommodityTree(Countries,"Rice, Husked") = 0.25;
*ExtractionRate_CommodityTree(Countries,"Rice hulls") = 0.25;
*Level2
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Milled/Husked Rice","Rice, Husked","Rice, paddy","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Bran, Rice","Rice, Husked","Rice, paddy","Main crop") = 1;
*2% lost?:
*ExtractionRate_CommodityTree(Countries,"Milled/Husked Rice") = 0.9*0.25;
*ExtractionRate_CommodityTree(Countries,"Bran, Rice") = 0.1*0.25;

*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Ricebran Oil","Bran, Rice","Rice, paddy","Main crop") = 1;
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cake, rice bran","Bran, Rice","Rice, paddy","Main crop") = 1;
*6% lost?:
ExtractionRate_CommodityTree(Countries,"Ricebran Oil") = 0.14*0.08;
ExtractionRate_CommodityTree(Countries,"Cake, rice bran") = 0.8*0.08;
*same commodity, named differently:
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil, rice bran","Bran, Rice","Rice, paddy","Main crop") = 1;
ExtractionRate_CommodityTree(Countries,"Oil, rice bran") = 0.14*0.08;

*assume that 5% of this is broken rice - the remaining 95% stay Milled Paddy Rice!
*BranchShare_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Rice, Broken","Milled Paddy Rice","Rice, paddy","Main crop") = 0.05;
*ExtractionRate_Level2_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Rice, Broken","Milled Paddy Rice","Rice, paddy","Main crop") = 1;
ExtractionRate_CommodityTree(Countries,"Rice, Broken") = 0.67*1;
*Level 3
*assume 50% in this branch
*5% losses
*BranchShare_Level3_CommodityTree_SOLmV5(GeographicRegionSOLmV5,"Rice Flour","Rice, Broken","Milled Paddy Rice","Rice, paddy","Main crop") = 0.5;
ExtractionRate_CommodityTree(Countries,"Rice Flour") = 0.67*1*0.95;
*assume 25% in this branch
*5% losses
*BranchShare_Level3_CommodityTree_SOLmV5(GeographicRegionSOLmV5,"Rice, Starch","Rice, Broken","Milled Paddy Rice","Rice, paddy","Main crop") = 0.25;
*BranchShare_Level3_CommodityTree_SOLmV5(GeographicRegionSOLmV5,"Rice Gluten","Rice, Broken","Milled Paddy Rice","Rice, paddy","Main crop") = 0.25;
*ExtractionRate_Level3_CommodityTree_SOLmV5(GeographicRegionSOLmV5,"Rice, Starch","Rice, Broken","Milled Paddy Rice","Rice, paddy","Main crop") = 0.85;
*ExtractionRate_Level3_CommodityTree_SOLmV5(GeographicRegionSOLmV5,"Rice Gluten","Rice, Broken","Milled Paddy Rice","Rice, paddy","Main crop") = 0.1;
ExtractionRate_CommodityTree(Countries,"Rice, Starch") = 0.67*1*0.85;
ExtractionRate_CommodityTree(Countries,"Rice Gluten") = 0.67*1*0.1;
*not yet covered: other branches into alcool, etc.

*assume 95% in this branch: no information on the other branch meal/flour for now
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Sesameseed Cake","Sesame seed","Main crop") = 0.95;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Sesameseed Oil","Sesame seed","Main crop") = 0.95;
*6% losses?
ExtractionRate_CommodityTree(Countries,"Sesameseed Cake") = 0.51;
ExtractionRate_CommodityTree(Countries,"Sesameseed Oil") = 0.43;
*same commodity, named differently:
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cake, sesame seed","Sesame seed","Main crop") = 0.95;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil, sesame","Sesame seed","Main crop") = 0.95;
*6% losses?
ExtractionRate_CommodityTree(Countries,"Cake, sesame seed") = 0.51;
ExtractionRate_CommodityTree(Countries,"Oil, sesame") = 0.43;


*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Sunflowerseed Cake","Sunflower seed","Main crop") = 1;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Sunflowerseed Oil","Sunflower seed","Main crop") = 1;
*12% losses?
ExtractionRate_CommodityTree(Countries,"Sunflowerseed Cake") = 0.47;
ExtractionRate_CommodityTree(Countries,"Sunflowerseed Oil") = 0.41;
*same commodity, named differently:
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Cake, sunflower","Sunflower seed","Main crop") = 1;
*BranchShare_Level1_CommodityTree_SOLmV5(GeographicRegionSOLmV5_Countries,"Oil, sunflower","Sunflower seed","Main crop") = 1;
*12% losses?
ExtractionRate_CommodityTree(Countries,"Cake, sunflower") = 0.47;
ExtractionRate_CommodityTree(Countries,"Oil, sunflower") = 0.41;



$ontext;
"Cake, hempseed"."Hempseed"."Main crop"
"Oil, Hempseed"."Hempseed"."Main crop"

"Cake, linseed"."Linseed"."Main crop"
"Oil, linseed"."Linseed"."Main crop"

"Cake, safflower"."Safflower seed"."Main crop"
"Oil, safflower"."Safflower seed"."Main crop"
$offtext

*BELOW: only extracton rates, no branch shares are done, as we did it primarily to get primary products, not the other way round (for NFP69)

ExtractionRate_CommodityTree(Countries,"Soyabean Cake") = 0.76;
ExtractionRate_CommodityTree(Countries,"Soyabean Oil") = 0.18;
ExtractionRate_CommodityTree(Countries,"Cake, soybeans") = 0.76;
ExtractionRate_CommodityTree(Countries,"Soya curd") = 2;
ExtractionRate_CommodityTree(Countries,"Soya paste") = 3.6;
ExtractionRate_CommodityTree(Countries,"Soya sauce") = 5;
ExtractionRate_CommodityTree(Countries,"Oil, soybean") = 0.18;
ExtractionRate_CommodityTree(Countries,"Soya curd") = 2;
ExtractionRate_CommodityTree(Countries,"Soya paste") = 3.6;
ExtractionRate_CommodityTree(Countries,"Soya sauce") = 5;

ExtractionRate_CommodityTree(Countries,"Wine") = 0.67;

ExtractionRate_CommodityTree(Countries,"Juice, grape") = 0.75;
$ontext
"Raisins"."Grapes"."Main crop"
"Leaves And Tops, Vines".Grapes."Main crop"
"Marc Of Grapes"."Grapes"."Main crop"
"Must Of Grapes".Grapes."Main crop"
"Grape pulp".grapes."Main crop"
$offtext;

ExtractionRate_CommodityTree(Countries,"Barley, pearled") = 0.72*0.55;
ExtractionRate_CommodityTree(Countries,"Pot Barley") = 0.72;

*"Beer of barley"."Barley"."Main crop"
*"Malt"."Barley"."Main crop"
*"Beer of Barley dregs".Barley."Main crop"
*"Bran, Barley"."Barley"."Main crop"
*"Barley Flour And Grits"."Barley"."Main crop"
*"Malt Extracts".Barley."Main crop"

ExtractionRate_CommodityTree(Countries,"Bran, wheat") = 0.20;
ExtractionRate_CommodityTree(Countries,"Flour, wheat") =  0.76;
ExtractionRate_CommodityTree(Countries,"Wheat Gluten") =  0.1;
ExtractionRate_CommodityTree(Countries,"Wheat Starch") =  0.85;
ExtractionRate_CommodityTree(Countries,"Bulgur") =  0.95;

*pastry, macarony from Wheat flour
ExtractionRate_CommodityTree(Countries,"Macaroni") =  0.76*1;
ExtractionRate_CommodityTree(Countries,"Pastry") =  0.76*1.15;
$ontext
"Wheat dregs"."Wheat"."Main crop"
"Wheat+Flour,Wheat Equivalent"."Wheat"."Main crop"
"Germ, Wheat"."Wheat"."Main crop"
"Wheat Fermented Beverage"."Wheat"."Main crop"

*missing: bread, mixed dough: both same extraction rate as bread: 1.15 from flour
$offtext

ExtractionRate_CommodityTree(Countries,"Cocoa, butter") = 0.47;
ExtractionRate_CommodityTree(Countries,"Cocoa, paste") = 0.8;
ExtractionRate_CommodityTree(Countries,"Cocoa, powder & cake") = 0.53;
ExtractionRate_CommodityTree(Countries,"Cocoa Husks+Shell") = 0.2;



$ontext
"Beer of sorghum"."Sorghum"."Main crop"
"Bran, sorghum"."Sorghum"."Main crop"
"Flour, Sorghum"."Sorghum"."Main crop"
"Beer of Shorgum dregs".Sorghum."Main crop"
$offtext

ExtractionRate_CommodityTree(Countries,"Beet pulp") = 0.25;
ExtractionRate_CommodityTree(Countries,"Beet Sugar") = 0.16;
*"Beet Tops"."Sugar beet"."Main crop"
ExtractionRate_CommodityTree(Countries,"Molasse from beet") = 0.036;

ExtractionRate_CommodityTree(Countries,"Bagasse") = 0.2;
ExtractionRate_CommodityTree(Countries,"Cane Sugar") = 0.16;
ExtractionRate_CommodityTree(Countries,"Molasse from cane") = 0.028;
*"Cane tops"."Sugar cane"."Main crop"


*"Coffee, extracts"."Coffee, green"."Main crop"
ExtractionRate_CommodityTree(Countries,"Coffee, husks and skins") = 0.2;
ExtractionRate_CommodityTree(Countries,"Coffee, roasted") = 0.65;

$ontext
"Flax Fib+Tow+W"."Flax fibre and tow"."Main crop"
"Flax fibre and tow"."Flax fibre and tow"."Main crop"
"Flax fibre raw"."Flax fibre and tow"."Main crop"
"Flax tow waste"."Flax fibre and tow"."Main crop"

"Bran, Rye"."Rye"."Main crop"
"Flour, Rye"."Rye"."Main crop"

"Bran, Triticale"."Triticale"."Main crop"
"Flour, Triticale"."Triticale"."Main crop"

"Alfalfa meal and pellets"."Alfalfa"."Main crop"
$offtext
ExtractionRate_CommodityTree(Countries,"Almonds shelled") = 0.3;
ExtractionRate_CommodityTree(Countries,"Almond shells") = 0.7;
*"Almond shells"."Almonds, with shell"."Main crop"
$ontext
"Apricots, dry"."Apricots"."Main crop"
"Apricot kernel".Apricots."Main crop"

"Bran, buckwheat"."Buckwheat"."Main crop"

"Bran, fonio"."Fonio"."Main crop"
"Flour, fonio"."Fonio"."Main crop"

"Bran, millet"."Millet"."Main crop"
$offtext;

*Add here extracton rates for stone fruit kernels:
*assume about 10%, rather somewhat less
ExtractionRate_CommodityTree(Countries,"Apricot kernel shells") = 0.09;
ExtractionRate_CommodityTree(Countries,"Cherries - kernels") = 0.1;
ExtractionRate_CommodityTree(Countries,"cherries, sour - kernels") = 0.1;
ExtractionRate_CommodityTree(Countries,"Peaches and nectarines - kernels") = 0.06;
ExtractionRate_CommodityTree(Countries,"Plums and sloes - kernels") = 0.07;
*assume something more or less reasonable:
ExtractionRate_CommodityTree(Countries,"Dates - kernels") = 0.15;
ExtractionRate_CommodityTree(Countries,"Pistachio shells") = 0.09;


*ExtractionRate_CommodityTree(Countries,"Almonds shelled") = ;
ExtractionRate_CommodityTree(Countries,"Brazil nuts, shelled") = 0.55;
ExtractionRate_CommodityTree(Countries,"Brazil nut shells") = 0.45;
$ontext;
"Brazil nut shells"."Brazil nuts, with shell"."Main crop"

"Butter of karite nuts"."Karite nuts (sheanuts)"."Main crop"
"Karite nut cake"."Karite nuts (sheanuts)"."Main crop"
$offtext;

*"Cake, mustard"."Mustard seed"."Main crop"
ExtractionRate_CommodityTree(Countries,"Flour, mustard") = 0.8;
*"Oil, Mustard Seed"."Mustard seed"."Main crop"

ExtractionRate_CommodityTree(Countries,"Cashew nuts, shelled") = 0.22;
ExtractionRate_CommodityTree(Countries,"Cashew nut shells") = 0.78;
*"Cashewapple"."Cashewapple"."Main crop"
*"Cashew nut shells"."Cashew nuts, with shell"."Main crop"

ExtractionRate_CommodityTree(Countries,"Cassava dried") = 0.35;
ExtractionRate_CommodityTree(Countries,"Starch, cassava") = 0.25;
*"Cassava Tapioca"."Cassava"."Main crop"
*"Flour, Cassava"."Cassava"."Main crop"

$ontext;
"Cocoons, unreelable & waste"."Silkworms"."Other animal output"
"Silk raw"."Silkworms"."Other animal output"
"Silk-worm cocoons, reelable"."Silkworms"."Other animal output"

"Figs dried"."Figs"."Main crop"

"Flour, mixed grain"."Grain, mixed"."Main crop"
"Bran, Mixed Grain"."Grain, mixed"."Main crop"
$offtext
ExtractionRate_CommodityTree(Countries,"Hazelnuts, shelled") = 0.4;
ExtractionRate_CommodityTree(Countries,"Hazelnut shells") = 0.6;
*"Hazelnut shells"."Hazelnuts, with shell"."Main crop"


ExtractionRate_CommodityTree(Countries,"Juice, grapefruit") = 0.47;
ExtractionRate_CommodityTree(Countries,"Juice, grapefruit, concentrated") = 0.14;
*"Juice, grapefruit, concentrated"."Grapefruit (inc. pomelos)"."Main crop"
*"Grapefruit pulp"."Grapefruit (inc. pomelos)"."Main crop"

ExtractionRate_CommodityTree(Countries,"Juice, lemon, concentrated") = 0.12;
*"Lemonjuice Single-Streng"."Lemons and limes"."Main crop"
*"Lemon pulp"."Lemons and limes"."Main crop"

ExtractionRate_CommodityTree(Countries,"Juice, orange, concentrated") = 0.1;
ExtractionRate_CommodityTree(Countries,"Juice, orange, single strength") = 0.55;
*"Orange pulp".Oranges."Main crop"

ExtractionRate_CommodityTree(Countries,"Juice, pineapple") = 0.2;
ExtractionRate_CommodityTree(Countries,"Juice, pineapple, concentrated") = 0.08;
ExtractionRate_CommodityTree(Countries,"Pineapples canned") = 0.52;
*"Pineapple pulp".Pineapples."Main crop"


$ontext;
"Juice, plum, concentrated"."Plums and sloes"."Main crop"
"Juice, plum, single strength"."Plums and sloes"."Main crop"
"Plums dried (prunes)"."Plums and sloes"."Main crop"
"Plums, Dried (Prunes)"."Plums and sloes"."Main crop"
"Plum pulp"."Plums and sloes"."Main crop"
$offtext;

ExtractionRate_CommodityTree(Countries,"Juice, tomato") = 0.8;
ExtractionRate_CommodityTree(Countries,"Tomatoes, paste") = 0.25;
ExtractionRate_CommodityTree(Countries,"Tomatoes, peeled") = 0.8;

*"Tomatojuice Concentrated"."Tomatoes"."Main crop"
*"Tomato pulp".Tomatoes."Main crop"

$ontext;
"Kapok fibre"."Kapok fibre"."Main crop"
"Kapokseed in shell"."Kapokseed in shell"."Main crop"
"Kapokseed shelled"."Kapokseed in shell"."Main crop"
"Oil, kapok"."Kapokseed in shell"."Main crop"
"Cake, kapok"."Kapokseed in shell"."Main crop"
"Kapokseed shells"."Kapokseed in shell"."Main crop"

"Maple sugar and syrups"."Maple"."Main crop"

"Mushrooms, canned"."Mushrooms and truffles"."Main crop"
"Dried Mushrooms"."Mushrooms and truffles"."Main crop"
$offtext;


ExtractionRate_CommodityTree(Countries,"Oats rolled") = 0.53;
*"Bran, Oats"."Oats"."Main crop"
*"Oat flour".Oats."Main crop"

*"Oil, castor beans"."Castor oil seed"."Main crop"
*"Castor bean cake"."Castor oil seed"."Main crop"

*"Oil, poppy"."Poppy seed"."Main crop"
*"Cake Of Poppy Seed"."Poppy seed"."Main crop"

ExtractionRate_CommodityTree(Countries,"Flour, potatoes") = 0.2;
*"Potato offals"."Potatoes"."Main crop"
ExtractionRate_CommodityTree(Countries,"Potatoes, frozen") = 0.5;
*"Potato Starch"."Potatoes"."Main crop"
*"Potato Tapioca"."Potatoes"."Main crop"

$ontext;
"Pyrethrum, extraction"."Pyrethrum, dried"."Main crop"
"Pyrethrum Marc"."Pyrethrum, dried"."Main crop"

"Rubber natural dry"."Rubber, natural"."Main crop"


"Sweet corn frozen"."Maize, green"."Main crop"
"Sweet corn prep or preserved"."Maize, green"."Main crop"
$offtext

* comment AF: very low?
ExtractionRate_CommodityTree(Countries,"Tea, mate extracts") = 0.05;

$ontext
"Tobacco products nes"."Tobacco, unmanufactured"."Main crop"

"Vegetable tallow"."Tallowtree seed"."Main crop"
$offtext
ExtractionRate_CommodityTree(Countries,"Walnuts, shelled") = 0.4;
ExtractionRate_CommodityTree(Countries,"Walnut shells") = 0.6;
*"Walnut shells"."Walnuts, with shell"."Main crop"

ExtractionRate_CommodityTree(Countries,"Applejuice Single Streng") = 0.2;
$ontext
"Applejuice Concentrated"."Apples"."Main crop"
"Apple pulp".Apples."Main crop"

"Flour, Buckwheat"."Buckwheat"."Main crop"

"Flour, Millet"."Millet"."Main crop"

"Jojoba Oil"."Jojoba seed"."Main crop"
"Jojoba cake"."Jojoba seed"."Main crop"


"Mango Juice"."Mangoes, mangosteens, guavas"."Main crop"
"Mango Pulp"."Mangoes, mangosteens, guavas"."Main crop"


"Tangerine Juice"."Tangerines, mandarins, clementines, satsumas"."Main crop"
"Tangerine pulp"."Tangerines, mandarins, clementines, satsumas"."Main crop"

"Tung Oil"."Tung nuts"."Main crop"
"Tung nut cake"."Tung nuts"."Main crop"
$offtext

ExtractionRate_CommodityTree(Countries,"Flour, Spelt") = 0.79;
*assume 90% extraction:
ExtractionRate_CommodityTree(Countries,"Chestnut") = 0.9;
ExtractionRate_CommodityTree(Countries,"Chestnut shells") = 0.1;


*for Set3:
VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_WellDefinedCoProducts,ProductionSystems,ProductionConditions)
                 $ExtractionRate_CommodityTree(Regions,SubsetCommod_MatchWithAct_WellDefinedCoProducts)
         = VCommod_Quantity.l(Regions,SubsetCommod_MatchWithAct_WellDefinedCoProducts,ProductionSystems,ProductionConditions)
                 /ExtractionRate_CommodityTree(Regions,SubsetCommod_MatchWithAct_WellDefinedCoProducts);


*4.4) set 4: MatchCommAct_ComplexCases(CommoditySOLmV5,ActivitySOLmV5,OutputTypeSOLmV5)
*set 4: no particular rule - but are not that many

*if extraction rates are not so clearly given, we chose something that fits from the tcf.pdf document - e.g. somewhat less than rye for distilled alcool for "All crops", etc.

*"Alcohol, Non-Food"."All Crops"."MainOutput1 (t)"
*much water added, similar to beer
ExtractionRate_CommodityTree(Countries,"Beverages, Fermented") = 6.5;
*some mixture of rates for wine and adding some water, etc.
ExtractionRate_CommodityTree(Countries,"Alcoholic Beverages") = 0.5;
ExtractionRate_CommodityTree(Countries,"Beverages, Alcoholic") = 0.5;
*additional to those needed by Anita:
ExtractionRate_CommodityTree(Countries,"Molasses") = 0.05;
ExtractionRate_CommodityTree(Countries,"Molasses (sugar cane)") = 0.05;
ExtractionRate_CommodityTree(Countries,"Molasses (sugar beet)") = 0.05;
*"Sugar & Sweeteners"."All sugar crops"."MainOutput1 (t)"
ExtractionRate_CommodityTree(Countries,"Sugar (Raw Equivalent)") = 0.12;
ExtractionRate_CommodityTree(Countries,"Sugar non-centrifugal") = 0.12;
*cf: 2541."Sugar non-centrifugal" resp. 163."Sugar non-centrifugal"
*assume mixture of cane and beet
ExtractionRate_CommodityTree(Countries,"Sugar, Raw Equivalent") = 0.13;
*this covers more in contrast to the other sugar elements: it is defined as follows:
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes,
*        162 Sugar Raw Centrifugal, 163 Sugar non-centrifugal, 166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose"
ExtractionRate_CommodityTree(Countries,"Sugar, Refined Equiv") = 0.10;
ExtractionRate_CommodityTree(Countries,"Sugar, Refined Equiv (sugar cane)") = 0.10;
ExtractionRate_CommodityTree(Countries,"Sugar, Refined Equiv (sugar beet)") = 0.10;
*"Sweeteners, Other"."All other sugar sources"."MainOutput1 (t)"
*This is 2543."Sweeteners, Other"
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes, 165 Molasses,
*        166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose, 175 Isoglucose, 633 Beverages, non alcoholic"
*"Beverages"."All Crops"."MainOutput1 (t)"
ExtractionRate_CommodityTree(Countries,"Beverages, distilled alcoholic") = 0.55;
*"Beverages, fermented rice"."Rice, paddy"."MainOutput1 (t)"
*just assume something:
ExtractionRate_CommodityTree(Countries,"Beverages, non alcoholic") = 0.4;
*"Beverages+Tobacco"."All Crops"."MainOutput1 (t)"
ExtractionRate_CommodityTree(Countries,"Chocolate products nes") = 0.8*0.53*4.7;
*assume to be made from apple juice
ExtractionRate_CommodityTree(Countries,"Cider etc") = 0.2;
*"Cigarettes"."Tobacco, unmanufactured"."MainOutput1 (t)"
*"Cigars, cheroots"."Tobacco, unmanufactured"."MainOutput1 (t)"
*assume 0.7 (from dehusked beans)
ExtractionRate_CommodityTree(Countries,"Coffee, substitutes containing coffee") = 0.7;
*use same as for beer, cf. set1 above
ExtractionRate_CommodityTree(Countries,"Dregs from brewing, distillation") = 0.7*0.7;
*"Feed and meal, gluten"."Maize"."MainOutput1 (t)"
*this is the following: 846."Feed and meal, gluten"
*        "Generally, by-products of the wet milling of maize. Gluten feed consists of fibres, spent germ and steep liquor.
*        Gluten meal contains endosperm protein fractions that remain following starch recovery."
ExtractionRate_CommodityTree(Countries,"Fixed Vegetable Oils") = 0.3;


*"Fructose and syrup, other"."All Fruits"."MainOutput1 (t)"
*"Fruit, cooked, homogenized preparations"."All Fruits"."MainOutput1 (t)"
*"Glucose and dextrose"."All Cereals"."MainOutput1 (t)"

ExtractionRate_CommodityTree(Countries,"Margarine, short") = 0.6;
ExtractionRate_CommodityTree(Countries,"Margarine, liquid") = 0.6;

*"Oil, boiled etc"."All Activities"."MainOutput1 (t)"
*This is 1274."Oil, boiled etc": "Also includes oxidized and sulphurized oils. Animal and vegetable fats and oils whose chemical structure has been modified to improve viscosity, drying ability or other properties."
ExtractionRate_CommodityTree(Countries,"Oil, essential nes") = 0.3;
*just assume some general share for the following: oil cakes from margarine, etc.
ExtractionRate_CommodityTree(Countries,"Oil cakes - various") = 0.5;

*assume some mixture of cane and beet:
ExtractionRate_CommodityTree(Countries,"Sugar Raw Centrifugal") = 0.12;
ExtractionRate_CommodityTree(Countries,"Sugar refined") = 0.10;
*"Alcohol Non Food Purpose"."All Crops"."MainOutput1 (t)"
*"Oils Hydrogenated"."All Oilcrops"."MainOutput1 (t)"

*from NFP69
*seasoning is assigned to "All vegetables" - assume 35% extraction (also due to drying, concentrating)
ExtractionRate_CommodityTree(Countries,"Seasoning") = 0.35;
*co prod from seasoning, thus 65%
ExtractionRate_CommodityTree(Countries,"CoProds Seasoning") = 0.65;

*for Set4:
VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_ComplexCases,ProductionSystems,ProductionConditions)
                 $ExtractionRate_CommodityTree(Regions,SubsetCommod_MatchWithAct_ComplexCases)
         = VCommod_Quantity.l(Regions,SubsetCommod_MatchWithAct_ComplexCases,ProductionSystems,ProductionConditions)
                 /ExtractionRate_CommodityTree(Regions,SubsetCommod_MatchWithAct_ComplexCases);



*4.5) set 5: MatchCommAct_ComplexAnimalCommodities(CommoditySOLmV5,ActivitySOLmV5,OutputTypeSOLmV5)
*set 5: no particular rule - quite a few....

*if not available from elsewhere: take values from similar commodities or do some best guess...

*"Animal Products"."All Animals"."Meat (t)"
ExtractionRate_CommodityTree(Countries,"Butter, Ghee") = 0.047;
*cheese - from all ruminants, to be disaggregated later - extraction 0.1 for hard, 0.22 for soft cheese; something in between for general/semihard, etc.
ExtractionRate_CommodityTree(Countries,"Cheese") = 0.17;
ExtractionRate_CommodityTree(Countries,"Cream") = 0.15;
*the butcher fat is the co-product from meat, other fats are parts of the liveweight COMPLEMENTING meat and offals
ExtractionRate_CommodityTree(Countries,"Cattle butcher Fat") = 0.12;
ExtractionRate_CommodityTree(Countries,"Pig butcher Fat") = 0.15;
ExtractionRate_CommodityTree(Countries,"Fish Meal") = 0.5;
*this is 2855."Fish Meal" and thus covers all seafood:
*        "Default composition: 1511 Freshwater Meal Fr Offal, 1524 Demersal Meal from Offal, 1537 Pelagic Meal from Offal, 1550 Marn Meal Of, 1559 Crustaceans Meal F Offal,
*        1567 Molluscs Meal from Offal, 1576 Cephalopods Meal F Offal, 1581 Aquatic Mammals Meals, 1584 Aqua Mammal Meal F Offal, 1591 Aq A Meal Of"
*"Fish, Body Oil"."All Fish and Marine Mamm"."Meat (t)"
*this is 2781."Fish, Body Oil" and thus covers fish and marine mammals
*        "Default composition: 1509 Frwt Bdy Oil, 1522 Dmrs Bdy Oil, 1535 Pelg Bdy Oil, 1548 Marn Bdy Oil, 1582 Aq M Oils"
*"Fish, Liver Oil"."All Fish and Marine Mamm"."Meat (t)"
*2782."Fish, Liver Oil" and thus covers fish and marine mammals
*        "Default composition: 1510 Frwt Lvr Oil, 1523 Demersal Liver Oils, 1536 Pelg Lvr Oil, 1549 Marine nes Liver Oils"
*"Meat Meal"."All Animals"."Meat (t)"
ExtractionRate_CommodityTree(Countries,"Milk, Skimmed") = 0.93;
*no data  just assume something:
ExtractionRate_CommodityTree(Countries,"Whey") = 0.73;
*"Animal Oil+Fat+Grs"."All Animals"."Meat (t)"
*"Animal Vegetable Oil"."All Animals"."Meat (t)"
*"Bacon and ham"."Pigs"."Meat (t)"
ExtractionRate_CommodityTree(Countries,"Butter") = 0.047;
ExtractionRate_CommodityTree(Countries,"Butter, cow milk") = 0.047;
ExtractionRate_CommodityTree(Countries,"Buttermilk, curdled, acidified milk") = 0.93;
*"Canned Meat nes"."All Animals"."Meat (t)"
ExtractionRate_CommodityTree(Countries,"Cheese and Curd") = 0.17;
ExtractionRate_CommodityTree(Countries,"Cheese, processed") = 0.17;
ExtractionRate_CommodityTree(Countries,"Cheese, sheep milk") = 0.17;
ExtractionRate_CommodityTree(Countries,"Cream fresh") = 0.15;
ExtractionRate_CommodityTree(Countries,"Cheese, whole cow milk") = 0.17;
*"Eggs Liquid,Dried"."Chickens"."Eggs (t)"
*no information available on eggs, thus just assume something
ExtractionRate_CommodityTree(Countries,"Eggs, dried") = 0.12;
ExtractionRate_CommodityTree(Countries,"Eggs, liquid") = 0.9;
ExtractionRate_CommodityTree(Countries,"Eggs, other bird, in shell") = 1;
*"Fat, liver prepared (foie gras)"."Ducks and Geese"."Meat (t)"
*This is needed to match 1060."Fat, liver prepared (foie gras)" with activities:
*        "Fatty livers of ducks and geese when cooked, prepared or preserved(e.g. patâ€š)."
*"Fat, nes, prepared"."All Animals"."Meat (t)"
*"Fatty acids"."All Animals"."Meat (t)"
*"Fatty substance residues"."All Animals"."Meat (t)"
ExtractionRate_CommodityTree(Countries,"Ghee, of buffalo milk") = 0.047;
*"Grease incl. lanolin wool"."Sheep"."Wool (t)"
*"Lactose"."Cattle"."Milk (t)"
*"Lard"."Pigs"."Meat (t)"
*"Meal, meat"."All Animals"."Meat (t)"
*"Meat and Meat Preparations"."All Animals"."Meat (t)"
*"Meat Fresh+Ch+Frozen"."All Animals"."Meat (t)"
*"Meat Prepared Pres"."All Animals"."Meat (t)"
ExtractionRate_CommodityTree(Countries,"Meat, beef and veal sausages") = 0.8;
*0.71 is from the tcf-document from FAO (Technical conversion factors) - the factor between meat, carcass weight (Code 867), which is the primary product of the cattle activity and code 870: "Meat, cattle, boneless (beef & veal)"
ExtractionRate_CommodityTree(Countries,"Meat, cattle, boneless (beef & veal)") = 0.71;
*"Meat, beef, preparations"."Cattle"."Meat (t)"
*"Meat, chicken, canned"."Chickens"."Meat (t)"
*"Meat, dried nes"."All Animals"."Meat (t)"
ExtractionRate_CommodityTree(Countries,"Meat, pig sausages") = 0.85;
ExtractionRate_CommodityTree(Countries,"Meat, pig, preparations") = 0.88;
ExtractionRate_CommodityTree(Countries,"Meat, pork") = 0.73;
ExtractionRate_CommodityTree(Countries,"Milk Condensed + Evaporated") = 0.15;
*"Milk Condensed+Dry+Fresh"."Cattle"."Milk (t)"
ExtractionRate_CommodityTree(Countries,"Milk Dry") = 0.15;
*"Milk Equivalent"."Cattle"."Milk (t)"
*"Milk, products of natural constituents nes"."Cattle"."Milk (t)"
*"Milk, reconstituted"."Cattle"."Milk (t)"
ExtractionRate_CommodityTree(Countries,"Milk, skimmed cow") = 0.93;
ExtractionRate_CommodityTree(Countries,"Milk, skimmed dried") = 0.93*0.1;
ExtractionRate_CommodityTree(Countries,"Milk, whole condensed") = 0.35;
ExtractionRate_CommodityTree(Countries,"Milk, whole dried") = 0.15;
ExtractionRate_CommodityTree(Countries,"Milk, whole evaporated") = 0.4;
ExtractionRate_CommodityTree(Countries,"Whey, condensed") = 0.25*0.73;
ExtractionRate_CommodityTree(Countries,"Whey, dry") = 0.1*0.73;
ExtractionRate_CommodityTree(Countries,"Whey, Pres+Concen") = 0.25*0.73;
ExtractionRate_CommodityTree(Countries,"Yoghurt, concentrated or not") = 0.8;
*"Animals live nes"."Animals live nes"."Meat (t)"
*"Asses"."Asses"."Meat (t)"
*"Beehives".Beehives."Honey (t)"
*"Buffaloes"."Buffaloes"."Meat (t)"
*"Camelids, other"."Camelids, other"."Meat (t)"
*"Camels"."Camels"."Meat (t)"
*"Cattle"."Cattle"."Meat (t)"
*"Chickens"."Chickens"."Meat (t)"
*"Ducks"."Ducks"."Meat (t)"
*"Goats"."Goats"."Meat (t)"
*Horses"."Horses"."Meat (t)"
*"Mules"."Mules"."Meat (t)"
*"Pigs"."Pigs"."Meat (t)"
*"Rabbits and hares"."Rabbits and hares"."Meat (t)"
*"Rodents, other"."Rodents, other"."Meat (t)"
*"Sheep"."Sheep"."Meat (t)"
*"Turkeys"."Turkeys"."Meat (t)"
*"Beef Canned"."Cattle"."Meat (t)"
*"Beef Dried Salt Smoked"."Cattle"."Meat (t)"
*"Blood Meal"."All Animals"."Meat (t)"
ExtractionRate_CommodityTree(Countries,"Butter Of Buffalo Milk") = 0.047;
ExtractionRate_CommodityTree(Countries,"Butter Of Goat Milk") = 0.047;
ExtractionRate_CommodityTree(Countries,"Butter+Ghee (Sheep Milk)") = 0.047;
*"Dry Buttermilk"."Cattle"."Milk (t)"
*"Casein"."Cattle"."Milk (t)"
ExtractionRate_CommodityTree(Countries,"Cheese Of Buffalo Milk") = 0.15;
ExtractionRate_CommodityTree(Countries,"Cheese Of Goat Milk") = 0.15;
ExtractionRate_CommodityTree(Countries,"Cheese (Skim Cow Milk)") = 0.15;
*"Fat, Poultry Rendered"."Chickens"."Meat (t)"
*"Game"."Game"."Meat (t)"
*"Geese"."Geese and guinea fowls"."Meat (t)"
*"Geese and guinea fowls"."Geese and guinea fowls"."Meat (t)"
ExtractionRate_CommodityTree(Countries,"Ghee, of cow milk") = 0.047;
*"Homogenized Meat Prep."."All Animals"."Meat (t)"
*"Lard And Stearine Oil"."Pigs"."Meat (t)"
*"Live Animals Nes". "Animals live nes"."Meat (t)"
*"Meat Extracts"."All Animals"."Meat (t)"
*"Meat Prepared Nes"."All Animals"."Meat (t)"
*"Oils Fish And Marine Mam"."All Fish and Marine Mamm"."Meat (t)"
*"Other birds for eggs"."Pigeons, other birds"."Eggs (t)"
ExtractionRate_CommodityTree(Countries,"Skim Milk, Condensed") = 0.93*0.3;
*"Skim Milk, Evaporated"."Cattle"."Milk (t)"
ExtractionRate_CommodityTree(Countries,"Skim Milk Of Buffalo") = 0.93;
ExtractionRate_CommodityTree(Countries,"Skim Milk Of Goat") = 0.93;
ExtractionRate_CommodityTree(Countries,"Skim Sheep Milk") = 0.93;
*"Whey Cheese"."Cattle"."Milk (t)"
ExtractionRate_CommodityTree(Countries,"Whey, Fresh") = 0.73;
*"Wool Shoddy"."Sheep"."Wool (t)"
ExtractionRate_CommodityTree(Countries,"Yoghurt") = 0.8;

*from NFP69
ExtractionRate_CommodityTree(Countries,"Hard cheese") = 0.1;
*cheese - from all ruminants, to be disaggregated later - extraction 0.1 for hard, 0.22 for soft cheese; something in between for general/semihard, etc.
ExtractionRate_CommodityTree(Countries,"Semihard cheese") = 0.16;
*cheese - from all ruminants, to be disaggregated later - extraction 0.1 for hard, 0.22 for soft cheese; something in between for general/semihard, etc.
ExtractionRate_CommodityTree(Countries,"Soft cheese") = 0.22;

*for Set5:
VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,ProductionSystems,ProductionConditions)
                 $ExtractionRate_CommodityTree(Regions,SubsetCommod_MatchWithAct_ComplexAnimalCommodities)
         = VCommod_Quantity.l(Regions,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,ProductionSystems,ProductionConditions)
                 /ExtractionRate_CommodityTree(Regions,SubsetCommod_MatchWithAct_ComplexAnimalCommodities);



*4.6) set 6: SubsetCommod_MatchWithAct_CommodEquivalentAct(CommoditySOLmV5)
*set 6: ok, for this set, Primary product equivalents just equal the commodity quantities

VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct,ProductionSystems,ProductionConditions)
         = VCommod_Quantity.l(Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct,ProductionSystems,ProductionConditions);
*for completeness, we also assign extraction rates here: equaling 1:
ExtractionRate_CommodityTree(Countries,SubsetCommod_MatchWithAct_CommodEquivalentAct)
         = 1;



*4.7) set 7: SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct(CommoditySOLmV5)
*set 7: ok, for this set, Primary product equivalents just equal the commodity quantities

VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct,ProductionSystems,ProductionConditions)
         = VCommod_Quantity.l(Regions,SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct,ProductionSystems,ProductionConditions);
*for completeness, we also assign extraction rates here: equaling 1:
ExtractionRate_CommodityTree(Countries,SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct)
         = 1;


*4.8) Translate in activities:

*for Set1:
VPrimProd_Commod_Quantity_CropActivities.l(Regions,SubsetCommod_MatchWithAct_AggregateCommodities,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions)
                 $MatchCommAct_AggregateCommodities_Crops(SubsetCommod_MatchWithAct_AggregateCommodities,Activities,OutputsCropsGrass)
         =VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_AggregateCommodities,ProductionSystems,ProductionConditions);

*for Set2:
VPrimProd_Commod_Quantity_CropActivities.l(Regions,SubsetCommod_MatchWithAct_AggregateActivities,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions)
                 $MatchCommAct_AggregateActivities_Crops(SubsetCommod_MatchWithAct_AggregateActivities,Activities,OutputsCropsGrass)
         =VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_AggregateActivities,ProductionSystems,ProductionConditions);

*for Set3:
VPrimProd_Commod_Quantity_CropActivities.l(Regions,SubsetCommod_MatchWithAct_WellDefinedCoProducts,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions)
                 $MatchCommAct_WellDefinedCoProducts_Crops(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Activities,OutputsCropsGrass)
         =VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_WellDefinedCoProducts,ProductionSystems,ProductionConditions);

*for Set4:
VPrimProd_Commod_Quantity_CropActivities.l(Regions,SubsetCommod_MatchWithAct_ComplexCases,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions)
                 $MatchCommAct_ComplexCases_Crops(SubsetCommod_MatchWithAct_ComplexCases,Activities,OutputsCropsGrass)
         =VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_ComplexCases,ProductionSystems,ProductionConditions);

*for Set5:
VPrimProd_Commod_Quantity_AnimalActivities.l(Regions,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities,OutputsAnimals,ProductionSystems,ProductionConditions)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities,OutputsAnimals)
         =VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,ProductionSystems,ProductionConditions);

*for Set6:
VPrimProd_Commod_Quantity_CropActivities.l(Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions)
                 $MatchCommAct_CommodEquivalentAct_Crops(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities,OutputsCropsGrass)
         =VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct,ProductionSystems,ProductionConditions);

VPrimProd_Commod_Quantity_AnimalActivities.l(Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities,OutputsAnimals,ProductionSystems,ProductionConditions)
                 $MatchCommAct_CommodEquivalentAct_Animals(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities,OutputsAnimals)
         =VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct,ProductionSystems,ProductionConditions);

*for Set7:
VPrimProd_Commod_Quantity_CropActivities.l(Regions,SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions)
                 $MatchCommAct_CommodAndProductsEquivalentAct_Crops(SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct,Activities,OutputsCropsGrass)
         =VPrimProd_Commod_Quantity.l(Regions,SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct,ProductionSystems,ProductionConditions);

*Silk is not covered consistently, thus drop
VPrimProd_Commod_Quantity.l(Regions,"Silk",ProductionSystems,ProductionConditions) = 0;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) Define main/coproduct sets etc. used for allocation of impacts

$ontext;

For allocations, we need to know the main/co-product structure in the sets above.

remember the new sets we have - this helps to design the calculations that follow
thus: repeat the characteristics of the matching and the sets used to do this from above:

*set 1
*This captures the cases where commodities correspond to an aggregate of some non primary commodities
*contains crop commodities only, hence only one file needed for crops
set SubsetCommod_MatchWithAct_AggregateCommodities(Commodities)
set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
Extraction rates here are thus the average extraction rates for the aggregate commodities and the aggregate commodites also show co-products

Thus we need to main/co-product structure for the aggregate commodities, the respective extraction rates (see above), the average AllocationCharacteristicsContents of the aggregates

*set 2
*This captures the cases where commodities correspond to prim prod outputs of aggregate activities and thus need to be allocated to outputs from single activities
*contains crop commodities only, hence only one file needed for crops
set SubsetCommod_MatchWithAct_AggregateActivities(Commodities)
set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass)
Extraction rates are 1, so they directly correspond to aggregate activities or their primary products


*set 3
*This captures the cases of well defined coproducts
*contains crop commodities only, hence only one file needed for crops
*These commodities are transformed into outputs from activities by means of the detailed information from the adequate commodity trees.
*         Here, we thus have to trace byproducts to avoid double-counting and to avoid loosing nutrients, etc.
set SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities)
set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)
Extraction rates are taken from the commodity trees


*set 4
*This captures the most complex cases such as fats and alcohol
*contains crop commodities only, hence only one file needed for crops
*no particular rule - but are not that many
set SubsetCommod_MatchWithAct_ComplexCases(Commodities)
set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass)

*set 5
*This covers the more complex animal commodities
*contains animal commodities only, hence only one file needed for animals
*no particular rule - quite a few....
set SubsetCommod_MatchWithAct_ComplexAnimalCommodities(Commodities)
set MatchCommAct_ComplexAnimalCommodities(Commodities,Activities,OutputsAnimals)


*set 6
*the following covers crop and animal commodities, hence the need for two matching files
*This captures all commodities that are equivalent to main outputs from activities
*ok, for this set, Primary product equivalents of main outputs from activities just equal the commodity quantities
set SubsetCommod_MatchWithAct_CommodEquivalentAct(Commodities)
set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
set MatchCommAct_CommodEquivalentAct_Animals(Commodities,Activities,OutputsAnimals)
Extraction rates eual 1

*set 7
*contains crop commodities only, hence only one file needed for crops
*This captures all commodities that are captured together with their derived products and expressed in primary product equivalents
*         this thus captures a number of products derived from one activity in prim prod eq of that activity - thus, linkage commod - act is direct in quantities.
*         BUT: no information on commod composition and thus on nutrient contents - some assumption needed on that. resp. check with nutr reported in FAOSTAT for per cap consumption, for example.
*ok, for this set, Primary product equivalents of main outputs from activities just equal the commodity quantities
*         However, nutrient contents etc. cannot be derived directly from prim prod quantities, as the commodity is a composition of various products;
*                 thus, for this, additional assumptions on the shares are needed, but not for the linkage comodities to activities
set SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct(Commodities)
set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCrops)
Extraction rates are thus 1 - on the level of the primary product units used here
$offtext;

*Thus, sets 2,6 and 7 have extraction rates = 1 - no allocation needed
*Sets 1,3,4 and 5 have other extraction rates, allocation is needed.


*Now do the matching sets:

*Set1:
set SubsetCommod_MatchWithAct_AggregateCommodities_MainAndCoprod(Commodities,Commodities_2)
*only define those where we have defined extraction rates:
/
"Beer"."Dregs - beer"
**TOO UNSPECIFIED - drop for now "Brans"
**linked below "Bran, Cereals"
**linked below "Bran, Pulses"
**TOO UNSPECIFIED - drop for now "Cereals, Other"
*        "Default composition: 68 Popcorn, 89 Buckwheat, 90 Flour, buckwheat, 91 Bran, buckwheat, 92 Quinoa, 94 Fonio, 95 Flour, fonio, 96 Bran, fonio, 97 Triticale, 98 Flour, triticale, 99 Bran, triticale, 101 Canary seed, 103 Grain, mixed,
*        104 Flour, mixed grain, 105 Bran, mixed grains, 108 Cereals, nes, 111 Flour, cereals, 112 Bran, cereals nes, 113 Cereal preparations, nes"
**TOO UNSPECIFIED - drop for now "Citrus, Other"
*This is 2614."Citrus, Other": "Default composition: 512 Fruit, citrus nes, 513 Juice, citrus, single strength, 514 Juice, citrus, concentrated"
"Oilcrops Oil, Other"."Oilseed Cakes, Other"
*the specification for this is as follows:
*2586."Oilcrops Oil, Other"
*        "Default composition: 264 Butter of karite nuts, 266 Oil, castor beans, 276 Oil, tung nuts, 278 Oil, jojoba, 281 Oil, safflower, 297 Oil, poppy,
*        306 Vegetable tallow, 307 Oil, stillingia, 313 Oil, kapok, 334 Oil, linseed, 337 Oil, hempseed, 340 Oil, vegetable origin nes, 664 Cocoa, butter, 1241 Margarine, liquid, 1242 Margarine, short,
*        1273 Castor oil, hydrogenated (opal wax), 1274 Oil, boiled etc, 1275 Oil, hydrogenated"
**linked above "Oilseed Cakes, Other"
*the specification for this is as follows:
*2598."Oilseed Cakes, Other"
*        "Default composition: 37 Cake, rice bran, 61 Cake, maize, 282 Cake, safflower, 298 Cake, poppy seed, 314 Cake, kapok, 335 Cake, linseed, 338 Cake, hempseed, 341 Cake, oilseeds nes"
**linked below "Rape and Mustard Cake"
"Rape and Mustard Oil"."Rape and Mustard Cake"
*"Bread"
*"Feed, pulp of fruit"
*"Feed, vegetable products nes"
"Flour, cereals"."Bran, Cereals"
"Flour, pulses"."Bran, Pulses"
**TOO UNSPECIFIED - drop for now "Flour, roots and tubers nes"
*"Fruit, dried nes"
*"Fruit, prepared nes"
"Juice, citrus, concentrated"."Citrus pulp"
"Juice, citrus, single strength"."Citrus pulp"
"Juice, fruit nes"."Fruit pulp"
*"Nuts, prepared (exc. groundnuts)"
"Oilcrops Oil, Other"."Oilseed Cake Meal"
"Oilcrops Oil, Other"."Oilseed Cake nes"
"Rape+Mustard Oils"."Rape and Mustard Cake"
*"Straw husks"
*"Vegetables in vinegar"
*"Vegetables, canned nes"
*"Vegetables, dehydrated"
*"Vegetables, dried nes"
**TOO UNSPECIFIED - drop for now "Vegetables, fresh nes"
*"Vegetables, fresh or dried products nes"
*"Vegetables, frozen"
*"Vegetables, homogenized preparations"
*"Vegetables, preserved nes"
*"Vegetables, preserved, frozen"
*"Vegetables, temporarily preserved"
*"Breakfast Cereals"
**TOO UNSPECIFIED - drop for now "Flour, Fruit"
**TOO UNSPECIFIED - drop for now "Flour/Meal Of Oilseeds"
*"Fruit Tropical Dried Nes"
*"Nuts, all, shelled"
*"Roots And Tubers Dried"
"Flour, mixed grain"."Brans, mixed grain"
/;


*Set3
set SubsetCommod_MatchWithAct_WellDefinedCoproducts_MainAndCoprod(Commodities,Commodities_2)
/
*co-prod added by us - not in the data
"Rice, Husked"."Rice hulls"
"Kapokseed in shell"."Kapok fibre"
*cotton linter is not included on the level of these terms (it is for "oil, cottonseed" and "cake, cottonseed")
"Palm Oil"."Palm kernels"
"Wine"."Marc of Grapes"
"Sesameseed Oil"."Sesameseed Cake"
*this may cover olive oil virgin and from residues - then the co-product is residues and pressed resides, the latter not being covered in the system
"Olive Oil"."Olive Residues"
*co-prod added by us - not in the data
"Groundnuts (Shelled Eq)"."Groundnut shells"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Soyabean Cake"."Soyabean Oil"
"Sunflowerseed Oil"."Sunflowerseed Cake"
*co-prod added by us - not in the data
"Beer of sorghum"."Beer of Shorgum dregs"
*no co-products, thus dropped here
*"Bulgur"
*co-prod added by us - not in the data
"Cocoa, paste"."Cocoa husks"
*unimportant, leave out for now
*"Coffee, extracts"
"Coffee, roasted"."Coffee, husks and skins"
*co-prod added by us - not in the data
"Butter of karite nuts"."Karite nut cake"
*co-prod added by us - not in the data
"Brazil nuts, shelled"."Brazil nut shells"
*no coprod, thus dropped here
*"Alfalfa meal and pellets"
*co-prod added by us - not in the data
"Cashew nuts, shelled"."Cashew nut shells"
*co-prod added by us - not in the data
Chestnut."Chestnut shells"
*co-prod added by us - not in the data
"Coconuts, desiccated"."Coconut shells"
*co-prod added by us - not in the data
"Copra"."Coconut shells"
*no coprod, thus dropped here
*"Cassava dried"
"Almonds shelled"."Almond shells"
"Apricots, dry"."Apricot kernel"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Cake, soybeans"."Oil, soybean"
*no coprod, thus dropped here
*"Flour, mustard"
*no coprod, thus dropped here
*"Flour, potatoes"
"Flour, fonio"."Bran, fonio"
"Flour, mixed grain"."Bran, Mixed Grain"
*no coprod, thus dropped here
*"Figs dried"
*for all the juices below: co-prod added by us - not in the data
"Juice, tomato"."Tomato pulp"
"Juice, grape"."Grape pulp"
"Juice, grapefruit"."Grapefruit pulp"
"Juice, grapefruit, concentrated"."Grapefruit pulp"
"Juice, lemon, concentrated"."Lemon pulp"
"Juice, orange, concentrated"."Orange pulp"
"Juice, orange, single strength"."Orange pulp"
"Juice, pineapple"."Pineapple pulp"
"Juice, pineapple, concentrated"."Pineapple pulp"
"Juice, plum, concentrated"."Plum pulp"
"Juice, plum, single strength"."Plum pulp"
*co-prod added by us - not in the data
"Hazelnuts, shelled"."Hazelnut shells"
*may not use this total but the next
*"Groundnuts Total Shelled"
"Groundnuts, shelled"."Groundnut shells"
*no coprod, thus dropped here
*"Malt"
*no coprod, thus dropped here
*"Mushrooms, canned"
*co-prod added by us - not in the data
"Oil, palm"."Palm kernels"
"Oil, linseed"."Cake, linseed"
"Oil, rapeseed"."Cake, rapeseed"
"Oil, safflower"."Cake, safflower"
"Oil, sesame"."Cake, sesame seed"
"Oil, poppy"."Cake Of Poppy Seed"
"Oil, sunflower"."Cake, sunflower"
"Oil, olive, virgin"."Olive residues"
*the following is likely the sum of olive oil virgin plus oil, olive residues
*"Olive Oil,Total"
*co-prod added by us - not in the data
"Oil, castor beans"."Castor bean cake"
*coproducts oat offals and hulls not in the data - drop for now
*"Oats rolled".OAT OFFALS.HULLS
*no coprod, thus dropped here
*"Peanut butter"
*coproducts juice and pulp - but not in the data - just take "Pineapple pulp"
"Pineapples canned"."Pineapple pulp"
*no coprod, thus dropped here
*"Plums dried (prunes)"
"Potatoes, frozen"."Potato offals"
*unimportant
*"Pyrethrum, extraction"
*no coprod, thus dropped here
*"Raisins"
*no coprod, thus dropped here
*"Soya curd"
*no coprod, thus dropped here
*"Soya paste"
*no coprod, thus dropped here
*"Soya sauce"
*no coprod, thus dropped here
*"Sweet corn frozen"
*no coprod, thus dropped here
*"Sweet corn prep or preserved"
*no coprod, thus dropped here
*"Tea, mate extracts"
*no coprod, thus dropped here
*"Starch, cassava"
*co-prod added by us - not in the data
"Walnuts, shelled"."Walnut shells"
*co-prod added by us - not in the data
"Tomatoes, paste"."Tomato pulp"
*co-prod added by us - not in the data
"Tomatoes, peeled"."Tomato pulp"
*co-prod added by us - not in the data
"Applejuice Single Streng"."Apple pulp"
"Applejuice Concentrated"."Apple pulp"
*no coprod, thus dropped here
*"Cassava Tapioca"
*no coprod, thus dropped here
*"Flour, Cassava"
"Flour, Sorghum"."Bran, sorghum"
"Flour, Triticale"."Bran, Triticale"
*buckwheat also has hulls - but we leave them away as they are neither in the data
"Flour, Buckwheat"."Bran, buckwheat"
"Flour, Millet"."Bran, millet"
"Flour, Rye"."Bran, Rye"
*co-prod added by us - not in the data
"Jojoba Oil"."Jojoba cake"
*unimportant
*"Leaves And Tops, Vines"
"Lemonjuice Single-Streng"."Lemon pulp"
"Mango Juice"."Mango Pulp"
*no coprod, thus dropped here
*"Dried Mushrooms"
"Must Of Grapes"."Marc Of Grapes"
"Oil, Hempseed"."Cake, hempseed"
"Oil, Mustard Seed"."Cake, mustard"
*Barley also has hulls - but we leave them away as they are neither in the data
"Pot Barley"."Bran, Barley"
*no coprod, thus dropped here
*"Plums, Dried (Prunes)"
*no coprod, thus dropped here
*"Potato Starch"
*no coprod, thus dropped here
*"Potato Tapioca"
*unimportant
*"Pyrethrum Marc"

$ontext;
*The commod trees of the following are dealt with only later
*this is third level
"Cake, kapok"
"Oil, kapok"

"Cane tops"
"Cashewapple"
"Cocoons, unreelable & waste"
"Maple sugar and syrups"
"Pastry"
"Popcorn"
"Rubber natural dry"
"Silk raw"
"Silk-worm cocoons, reelable"
"Vegetable tallow"
"Tobacco products nes"
"Wheat+Flour,Wheat Equivalent"
"Beet Tops"
"Malt Extracts"
*this is a by-product of coconuts, not covered in the commodity trees
"Coir"
*this is a by-product of hempseed, not covered in the commodity trees
"Hemp Fibre And Tow"

"Flax Fib+Tow+W"
"Flax fibre and tow"
"Flax fibre raw"
"Flax tow waste"
*END OF: The commod trees of the following are dealt with only later
$offtext;

*co-prod added by us - not in the data
"Tangerine Juice"."Tangerine pulp"
*co-prod added by us - not in the data
"Tomatojuice Concentrated"."Tomato pulp"
*co-prod added by us - not in the data
"Tung Oil"."Tung nut cake"

*MAIN-prod added by us - not in the data
"Oat flour"."Bran, Oats"
*MAIN-prod added by us - not in the data
"Cocoa paste"."Cocoa Husks+Shell"
"Oil palm fruit pulp"."Palm oil"

*THE FOLLOWING are the LEVEL2 co-products:

*the following has no coproducts
*"Rice, Broken"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
*the following has no coproducts
*"Rice Flour"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
"Rice, Starch"."Rice Gluten"
"Oil, rice bran"."Cake, rice bran"
"Ricebran Oil"."Cake, rice bran"
"Palmkernel Oil"."Palmkernel Cake"
"Maize Germ Oil"."Cake, maize"
"Coconut Oil"."Copra Cake"
"Groundnut Oil"."Groundnut Cake"
*co-prod added by us - not in the data
"Beer of barley"."Beer of Barley dregs"
*we assume powder to be main product, not cocoa butter
"Cocoa, powder & cake"."Cocoa, butter"
"Barley, pearled"."Barley Flour And Grits"
*co-prod added by us - not in the data
"Kapokseed shelled"."Kapokseed shells"
*"Macaroni"
"Oil, palm kernel"."Cake, palm kernel"
"Oil, maize"."Cake, maize"
*co-prod added by us - not in the data
"Oil, olive residues"."Pressed olive residues"
"Oil, groundnut"."Cake, groundnuts"
"Oil, coconut (copra)"."Cake, copra"
*the following has no coproducts
*"Prepared Groundnuts"
"Starch Of Maize"."Maize Gluten"
"Wheat Starch"."Wheat Gluten"
*MAIN-prod added by us - not in the data
"Palm kernel oil"."Cake, Palm Kernels"
*MAIN-prod added by us - not in the data
"Wheat dregs"."Wheat Fermented Beverage"
/;



*Set4
set SubsetCommod_MatchWithAct_ComplexCases_Crops_MainAndCoprod(Commodities,Commodities_2)
*only define those where we have defined extraction rates
/
*"Alcohol, Non-Food"
"Alcoholic Beverages"."Dregs from brewing, distillation"
"Beverages, Alcoholic"."Dregs from brewing, distillation"
"Beverages, Fermented"."Dregs from brewing, distillation"
*LINKED below: sugars, etc. "Molasses"
*"Sugar & Sweeteners"
"Sugar (Raw Equivalent)"."Molasses"
"Sugar non-centrifugal"."Molasses"
*cf: 2541."Sugar non-centrifugal" resp. 163."Sugar non-centrifugal"
"Sugar, Raw Equivalent"."Molasses"
*this covers more in contrast to the other sugar elements: it is defined as follows:
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes,
*        162 Sugar Raw Centrifugal, 163 Sugar non-centrifugal, 166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose"
"Sugar, Refined Equiv"."Molasses"
"Sugar, Refined Equiv (sugar cane)"."Molasses (sugar cane)"
"Sugar, Refined Equiv (sugar beet)"."Molasses (sugar beet)"
*"Sweeteners, Other"
*This is 2543."Sweeteners, Other"
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes, 165 Molasses,
*        166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose, 175 Isoglucose, 633 Beverages, non alcoholic"
*"Beverages"
"Beverages, distilled alcoholic"."Dregs from brewing, distillation"
*"Beverages, fermented rice"
**TOO UNSPECIFIED - drop for now "Beverages, non alcoholic"
*"Beverages+Tobacco"
"Chocolate products nes"."Cocoa Husks+Shell"
**TOO UNIMPORTANT - drop for now "Cider etc"
*"Cigarettes"
*"Cigars, cheroots"
"Coffee, substitutes containing coffee"."Coffee, husks and skins"
*LINKED above "Dregs from brewing, distillation"
*"Feed and meal, gluten"
*this is the following: 846."Feed and meal, gluten"
*        "Generally, by-products of the wet milling of maize. Gluten feed consists of fibres, spent germ and steep liquor.
*        Gluten meal contains endosperm protein fractions that remain following starch recovery."
"Fixed Vegetable Oils"."Oil cakes - various"
*"Fructose and syrup, other"
*"Fruit, cooked, homogenized preparations"
*"Glucose and dextrose"
"Margarine, liquid"."Oil cakes - various"
"Margarine, short"."Oil cakes - various"
*"Oil, boiled etc"
*This is 1274."Oil, boiled etc": "Also includes oxidized and sulphurized oils. Animal and vegetable fats and oils whose chemical structure has been modified to improve viscosity, drying ability or other properties."
"Oil, essential nes"."Oil cakes - various"
"Sugar Raw Centrifugal"."Molasses"
"Sugar refined"."Molasses"
*"Alcohol Non Food Purpose"
*"Oils Hydrogenated"

*LINKED above: "Oil cakes - various"

*from NFP69
Seasoning."CoProds Seasoning"
/;




*Set5
set SubsetCommod_MatchWithAct_CompAnimComm_MainAndCoprod(Commodities,Commodities_2)
*should be set SubsetCommod_MatchWithAct_ComplexAnimalCommodities_MainAndCoprod(Commodities,Commodities_2) - but this is too long a name
*only define those where we have defined extraction rates
*sometimes the byprod "water" is used: this is a placeholder to allow to run the code for products that do not come with byprod (e.g. yoghurt) but still have an extraction rate not equal to 1 and hecne have been assigned to this set 5
/
*"Animal Products"
*"Bovine Meat"
*        complex description in FAOSTAT - for simplicity, we take it identical to cattle meat and add it to the corresponding subset
"Butter, Ghee"."Milk, Skimmed"
"Cheese"."Whey"
"Cream"."Milk, Skimmed"
*"Eggs"
*        complex description in FAOSTAT - for simplicity, we take it identical to Chicken eggs and add it to the corresponding subset
*DO THIS LATER "Fish Meal"
*this is 2855."Fish Meal" and thus covers all seafood:
*        "Default composition: 1511 Freshwater Meal Fr Offal, 1524 Demersal Meal from Offal, 1537 Pelagic Meal from Offal, 1550 Marn Meal Of, 1559 Crustaceans Meal F Offal,
*        1567 Molluscs Meal from Offal, 1576 Cephalopods Meal F Offal, 1581 Aquatic Mammals Meals, 1584 Aqua Mammal Meal F Offal, 1591 Aq A Meal Of"
*"Fish, Body Oil"
*this is 2781."Fish, Body Oil" and thus covers fish and marine mammals
*        "Default composition: 1509 Frwt Bdy Oil, 1522 Dmrs Bdy Oil, 1535 Pelg Bdy Oil, 1548 Marn Bdy Oil, 1582 Aq M Oils"
*"Fish, Liver Oil"
*2782."Fish, Liver Oil" and thus covers fish and marine mammals
*        "Default composition: 1510 Frwt Lvr Oil, 1523 Demersal Liver Oils, 1536 Pelg Lvr Oil, 1549 Marine nes Liver Oils"
*"Hides and skins"
*"Meat Meal"
*LINKED above: "Milk, Skimmed"
*LINKED above: "Whey"
*"Animal Oil+Fat+Grs"
*"Animal Vegetable Oil"
*"Bacon and ham"
"Butter"."Milk, Skimmed"
"Butter, cow milk"."Milk, skimmed cow"
*DROP FOR NOW - not so important: "Buttermilk, curdled, acidified milk"
*"Canned Meat nes"
"Cheese and Curd"."Whey"
"Cheese, processed"."Whey"
"Cheese, sheep milk"."Whey"
"Cheese, whole cow milk"."Whey"
"Cream fresh"."Milk, Skimmed"
*"Eggs Liquid,Dried"
*DO THIS LATER "Eggs, dried"
*DO THIS LATER "Eggs, liquid"
*"Fat, liver prepared (foie gras)"
*This is needed to match 1060."Fat, liver prepared (foie gras)" with activities:
*        "Fatty livers of ducks and geese when cooked, prepared or preserved(e.g. patâ€š)."
*"Fat, nes, prepared"
*"Fatty acids"
*"Fatty substance residues"
"Ghee, of buffalo milk"."Skim Milk Of Buffalo"
*"Grease incl. lanolin wool"
*"Lactose"
*"Lard"
*"Meal, meat"
*"Meat and Meat Preparations"
*"Meat Fresh+Ch+Frozen"
*"Meat Prepared Pres"
"Meat, beef and veal sausages"."Cattle Butcher Fat"
*"Meat, beef, preparations"
"Meat, cattle, boneless (beef & veal)"."Cattle Butcher Fat"
*"Meat, chicken, canned"
*"Meat, dried nes"
"Meat, pig sausages"."Pig Butcher Fat"
"Meat, pig, preparations"."Pig Butcher Fat"
"Meat, pork"."Pig Butcher Fat"
*DO THIS LATER "Milk Condensed + Evaporated"
*"Milk Condensed+Dry+Fresh"
*DO THIS LATER "Milk Dry"
*"Milk Equivalent"
*"Milk, products of natural constituents nes"
*"Milk, reconstituted"
*LINKED above "Milk, skimmed cow"
*DO THIS LATER "Milk, skimmed dried"
*DO THIS LATER "Milk, whole condensed"
*DO THIS LATER "Milk, whole dried"
*DO THIS LATER "Milk, whole evaporated"
*"Oils, fats of animal nes"
*DO THIS LATER "Whey, condensed"
*DO THIS LATER "Whey, dry"
*DO THIS LATER "Whey, Pres+Concen"
*"Wool, hair waste"
"Yoghurt, concentrated or not"."Water"
$ontext;
"Animals live nes"
"Asses"
"Beehives"
"Buffaloes"
"Camelids, other"
"Camels"
"Cattle"
"Chickens"
"Ducks"
"Goats"
"Horses"
"Mules"
"Pigs"
"Rabbits and hares"
"Rodents, other"
"Sheep"
"Turkeys"
"Beef Canned"
"Beef Dried Salt Smoked"
"Blood Meal"
$offtext;
"Butter Of Buffalo Milk"."Skim Milk Of Buffalo"
"Butter Of Goat Milk"."Skim Milk Of Goat"
"Butter+Ghee (Sheep Milk)"."Skim Sheep Milk"
*"Dry Buttermilk"
*"Casein"
"Cheese Of Buffalo Milk"."Whey"
"Cheese Of Goat Milk"."Whey"
"Cheese (Skim Cow Milk)"."Whey"
*"Game"
*"Geese"
*"Geese and guinea fowls"
"Ghee, of cow milk"."Milk, skimmed cow"
*"Whey Cheese"
*DO NOT NOW "Whey, Fresh"
*"Wool Shoddy"
"Yoghurt"."Water"
*the butcher fat is the co-product from meat, other fats are parts of the liveweight COMPLEMENTING meat and offals
*LINKED above "Cattle Butcher Fat"
*LINKED above "Pig Butcher Fat"

*"Fat, Poultry Rendered"
*"Lard And Stearine Oil"
*"Live Animals Nes"
*"Meat Extracts"
*"Meat Prepared Nes"
*"Oils Fish And Marine Mam"
*"Other birds for eggs"

*DROP FOR NOW - not important"Skim Milk, Condensed"
*"Skim Milk, Evaporated"
*LINKED above: "Skim Milk Of Buffalo"
*LINKED above: "Skim Milk Of Goat"
*LINKED above: "Skim Sheep Milk"

*from NFP69
'Hard cheese'."Whey"
'Semihard cheese'."Whey"
'Soft cheese'."Whey"
/;







*THE FOLLOWING is not needed anymore -
*assure this - and then drop





*Define subsets of all the commodities as follows: main products on level 1, co-products on level 1, main products on level 2, co-products on level 2
*then define an additional set that captures the main product - co-product pairings (or, in few cases: triplets)
*this results in the following sets:
*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 1 and that are MAIN Commodities there (e.g. "Starch")
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Main(Commodities)
*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 1 and that are CO-Commodities to the main ones there (e.g. "Wheat brans")
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Co(Commodities)
*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 2 and that are MAIN Commodities there (e.g. "Gluten")
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level2_Main(Commodities)
*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 2 and that are CO-Commodities to the main ones there (e.g. "Wheat brans")
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level2_Co(Commodities)
*Matching of main and co-products:
set MatchMainWithCoProd_WellDefinedCoProducts_Level1(Commodities,Commodities_2)
set MatchMainWithCoProd_WellDefinedCoProducts_Level2(Commodities,Commodities_2)
*some products have two byproducts, collect them separately:
alias(Commodities,Commodities_3);
set MatchMainWithCoPr_WellDefCoProd_Level1And2_TwoByprod(Commodities,Commodities_2,Commodities_3)



*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 1 and that are MAIN Commodities there (e.g. "Starch")
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Main(Commodities)
/
"Milled Paddy Rice"
"Rice (Milled Equivalent)"
"Rice, Husked"
"Milled/Husked Rice"
"Kapokseed in shell"
"Cotton lint"
*cotton, carded, combed is also the main product, fibre - it is derived from lint by carding/combing
"Cotton, carded, combed"
"Palm Oil"
"Wine"
"Sesameseed Oil"
"Olive Oil"
"Groundnuts (Shelled Eq)"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Soyabean Cake"
"Sunflowerseed Oil"
"Beer of sorghum"
"Bulgur"
"Cocoa, paste"
*unimportant, leave out for now
*"Coffee, extracts"
"Coffee, roasted"
"Butter of karite nuts"
"Brazil nuts, shelled"
"Alfalfa meal and pellets"
"Cashew nuts, shelled"
"Coconuts, desiccated"
"Copra"
"Cassava dried"
"Almonds shelled"
"Apricots, dry"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Cake, soybeans"
"Flour, mustard"
"Flour, potatoes"
"Flour, fonio"
"Flour, maize"
"Flour, mixed grain"
"Flour, wheat"
"Figs dried"
"Juice, tomato"
"Juice, grape"
"Juice, grapefruit"
"Juice, grapefruit, concentrated"
"Juice, lemon, concentrated"
"Juice, orange, concentrated"
"Juice, orange, single strength"
"Juice, pineapple"
"Juice, pineapple, concentrated"
"Juice, plum, concentrated"
"Juice, plum, single strength"
"Hazelnuts, shelled"
*may not use this total but the next
*"Groundnuts Total Shelled"
"Groundnuts, shelled"
"Malt"
"Mushrooms, canned"
"Oil, palm"
"Oil, linseed"
"Oil, rapeseed"
"Oil, safflower"
"Oil, sesame"
"Oil, poppy"
"Oil, sunflower"
"Oil, olive, virgin"
*the following is likely the sum of olive oil virgin plus oil, olive residues
*"Olive Oil,Total"
"Oil, castor beans"
"Oats rolled"
"Peanut butter"
"Pineapples canned"
"Plums dried (prunes)"
"Potatoes, frozen"
*unimportant
*"Pyrethrum, extraction"
"Raisins"
"Soya curd"
"Soya paste"
"Soya sauce"
"Sweet corn frozen"
"Sweet corn prep or preserved"
"Tea, mate extracts"
"Starch, cassava"
"Walnuts, shelled"
"Tomatoes, paste"
"Tomatoes, peeled"
"Applejuice Single Streng"
"Applejuice Concentrated"
"Cane Sugar"
"Beet Sugar"
"Cassava Tapioca"
"Flour, Cassava"
"Flour, Sorghum"
"Flour, Triticale"
"Flour, Buckwheat"
"Flour, Millet"
"Flour, Rye"
"Jojoba Oil"
*unimportant
*"Leaves And Tops, Vines"
"Lemonjuice Single-Streng"
"Mango Juice"
"Dried Mushrooms"
"Must Of Grapes"
"Oil, Hempseed"
"Oil, Mustard Seed"
"Pot Barley"
"Plums, Dried (Prunes)"
"Potato Starch"
"Potato Tapioca"
*unimportant
*"Pyrethrum Marc"

$ontext;
*The commod trees of the following are dealt with only later
*this is third level
"Cake, kapok"
"Oil, kapok"

"Cane tops"
"Cashewapple"
"Cocoons, unreelable & waste"
"Maple sugar and syrups"
"Pastry"
"Popcorn"
"Rubber natural dry"
"Silk raw"
"Silk-worm cocoons, reelable"
"Vegetable tallow"
"Tobacco products nes"
"Wheat+Flour,Wheat Equivalent"
"Beet Tops"
"Malt Extracts"
*this is a by-product of coconuts, not covered in the commodity trees
"Coir"
*this is a by-product of hempseed, not covered in the commodity trees
"Hemp Fibre And Tow"

"Flax Fib+Tow+W"
"Flax fibre and tow"
"Flax fibre raw"
"Flax tow waste"
*END OF: The commod trees of the following are dealt with only later
$offtext;

"Tangerine Juice"
"Tomatojuice Concentrated"
"Tung Oil"

*new level1 main products:
"Oat flour"
"Cocoa paste"
/;
*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 1 and that are CO-Commodities to the main ones there (e.g. "Wheat brans")
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Co(Commodities)
/
"Bran, Rice"
"Kapok fibre"
"Cottonseed"
"Palm kernels"
"Sesameseed Cake"
*Oil of soybeans is seen as the CO-product, the cake is the MAIN PROD - for animal feed!!
"Soyabean Oil"
"Sunflowerseed Cake"
"Coffee, husks and skins"
"Beet pulp"
"Cotton waste"
"Bran, buckwheat"
"Bran, fonio"
"Bran, maize"
"Bran, millet"
"Bran, sorghum"
"Bran, wheat"
"Cake, mustard"
"Cake, rapeseed"
"Cake, linseed"
"Cake, safflower"
"Cake, sesame seed"
"Cake, sunflower"
"Cake, hempseed"
"Germ, maize"
*Oil of soybeans is seen as the CO-product, the cake is the MAIN PROD - for animal feed!!
"Oil, soybean"
"Potato offals"
"Bagasse"
"Bran, Barley"
"Bran, Mixed Grain"
"Bran, Oats"
"Bran, Rye"
"Bran, Triticale"
"Cake Of Poppy Seed"
"Cocoa Husks+Shell"
"Germ, Wheat"
"Mango Pulp"
"Marc Of Grapes"
"Olive residues"

*new level1 co-products
"Rice hulls"
"Groundnut shells"
"Beer of Shorgum dregs"
"Cocoa husks"
"Karite nut cake"
"Almond shells"
"Apricot kernel"
"Chestnut shells"
"Coconut shells"
"Cashew nut shells"
"Brazil nut shells"
"Tomato pulp"
"Grape pulp"
"Grapefruit pulp"
"Lemon pulp"
"Orange pulp"
"Pineapple pulp"
"Plum pulp"
"Hazelnut shells"
"Castor bean cake"
"Walnut shells"
"Apple pulp"
"Jojoba cake"
"Tangerine pulp"
"Tung nut cake"
"Molasse from cane"
"Molasse from beet"
"Oil palm fruit pulp"
/;

*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 2 and that are MAIN Commodities there (e.g. "Gluten")
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level2_Main(Commodities)
/
"Rice, Broken"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
"Rice Flour"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
"Rice, Starch"
"Oil, rice bran"
"Ricebran Oil"
"Cottonseed Oil"
"Palmkernel Oil"
"Maize Germ Oil"
"Coconut Oil"
"Groundnut Oil"
"Beer of barley"
*we assume powder to be main product, not cocoa butter
"Cocoa, powder & cake"
"Barley, pearled"
"Kapokseed shelled"
"Macaroni"
"Oil, cottonseed"
"Oil, palm kernel"
"Oil, maize"
"Oil, olive residues"
"Oil, groundnut"
"Oil, coconut (copra)"
"Prepared Groundnuts"
"Starch Of Maize"
"Wheat Starch"

*new level2 MAIN products:
"Palm kernel oil"
"Wheat dregs"
/;
*subset of SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities) with the commodities that are on level 2 and that are CO-Commodities to the main ones there (e.g. "Wheat brans")
set SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level2_Co(Commodities)
/
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
"Rice Gluten"
"Cake, rice bran"
"Cottonseed Cake"
"Palmkernel Cake"
"Copra Cake"
"Groundnut Cake"
"Cocoa, butter"
"Cotton linter"
"Cake, maize"
"Cake, cottonseed"
"Cake, palm kernel"
"Cake, groundnuts"
"Cake, copra"
"Barley Flour And Grits"
"Cake, Palm Kernels"
"Maize Gluten"
"Wheat Gluten"
"Wheat Fermented Beverage"

*new level2 co-products:
"Beer of Barley dregs"
"Kapokseed shells"
"Pressed olive residues"
/;

*Matching of main and co-products:
*commodities is a subset only: SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Main - use this to make the code faster where needed
set MatchMainWithCoProd_WellDefinedCoProducts_Level1(Commodities,Commodities_2)
/
*co-prod added by us - not in the data
"Rice, Husked"."Rice hulls"
"Kapokseed in shell"."Kapok fibre"
*cotton linter is not included on the level of these terms (it is for "oil, cottonseed" and "cake, cottonseed")
"Palm Oil"."Palm kernels"
"Wine"."Marc of Grapes"
"Sesameseed Oil"."Sesameseed Cake"
*this may cover olive oil virgin and from residues - then the co-product is residues and pressed resides, the latter not being covered in the system
"Olive Oil"."Olive Residues"
*co-prod added by us - not in the data
"Groundnuts (Shelled Eq)"."Groundnut shells"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Soyabean Cake"."Soyabean Oil"
"Sunflowerseed Oil"."Sunflowerseed Cake"
*co-prod added by us - not in the data
"Beer of sorghum"."Beer of Shorgum dregs"
*no co-products, thus dropped here
*"Bulgur"
*co-prod added by us - not in the data
"Cocoa, paste"."Cocoa husks"
*unimportant, leave out for now
*"Coffee, extracts"
"Coffee, roasted"."Coffee, husks and skins"
*co-prod added by us - not in the data
"Butter of karite nuts"."Karite nut cake"
*co-prod added by us - not in the data
"Brazil nuts, shelled"."Brazil nut shells"
*no coprod, thus dropped here
*"Alfalfa meal and pellets"
*co-prod added by us - not in the data
"Cashew nuts, shelled"."Cashew nut shells"
*co-prod added by us - not in the data
Chestnut."Chestnut shells"
*co-prod added by us - not in the data
"Coconuts, desiccated"."Coconut shells"
*co-prod added by us - not in the data
"Copra"."Coconut shells"
*no coprod, thus dropped here
*"Cassava dried"
"Almonds shelled"."Almond shells"
"Apricots, dry"."Apricot kernel"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Cake, soybeans"."Oil, soybean"
*no coprod, thus dropped here
*"Flour, mustard"
*no coprod, thus dropped here
*"Flour, potatoes"
"Flour, fonio"."Bran, fonio"
"Flour, mixed grain"."Bran, Mixed Grain"
*no coprod, thus dropped here
*"Figs dried"
*for all the juices below: co-prod added by us - not in the data
"Juice, tomato"."Tomato pulp"
"Juice, grape"."Grape pulp"
"Juice, grapefruit"."Grapefruit pulp"
"Juice, grapefruit, concentrated"."Grapefruit pulp"
"Juice, lemon, concentrated"."Lemon pulp"
"Juice, orange, concentrated"."Orange pulp"
"Juice, orange, single strength"."Orange pulp"
"Juice, pineapple"."Pineapple pulp"
"Juice, pineapple, concentrated"."Pineapple pulp"
"Juice, plum, concentrated"."Plum pulp"
"Juice, plum, single strength"."Plum pulp"
*co-prod added by us - not in the data
"Hazelnuts, shelled"."Hazelnut shells"
*may not use this total but the next
*"Groundnuts Total Shelled"
"Groundnuts, shelled"."Groundnut shells"
*no coprod, thus dropped here
*"Malt"
*no coprod, thus dropped here
*"Mushrooms, canned"
*co-prod added by us - not in the data
"Oil, palm"."Palm kernels"
"Oil, linseed"."Cake, linseed"
"Oil, rapeseed"."Cake, rapeseed"
"Oil, safflower"."Cake, safflower"
"Oil, sesame"."Cake, sesame seed"
"Oil, poppy"."Cake Of Poppy Seed"
"Oil, sunflower"."Cake, sunflower"
"Oil, olive, virgin"."Olive residues"
*the following is likely the sum of olive oil virgin plus oil, olive residues
*"Olive Oil,Total"
*co-prod added by us - not in the data
"Oil, castor beans"."Castor bean cake"
*coproducts oat offals and hulls not in the data - drop for now
*"Oats rolled".OAT OFFALS.HULLS
*no coprod, thus dropped here
*"Peanut butter"
*coproducts juice and pulp - but not in the data - just take "Pineapple pulp"
"Pineapples canned"."Pineapple pulp"
*no coprod, thus dropped here
*"Plums dried (prunes)"
"Potatoes, frozen"."Potato offals"
*unimportant
*"Pyrethrum, extraction"
*no coprod, thus dropped here
*"Raisins"
*no coprod, thus dropped here
*"Soya curd"
*no coprod, thus dropped here
*"Soya paste"
*no coprod, thus dropped here
*"Soya sauce"
*no coprod, thus dropped here
*"Sweet corn frozen"
*no coprod, thus dropped here
*"Sweet corn prep or preserved"
*no coprod, thus dropped here
*"Tea, mate extracts"
*no coprod, thus dropped here
*"Starch, cassava"
*co-prod added by us - not in the data
"Walnuts, shelled"."Walnut shells"
*co-prod added by us - not in the data
"Tomatoes, paste"."Tomato pulp"
*co-prod added by us - not in the data
"Tomatoes, peeled"."Tomato pulp"
*co-prod added by us - not in the data
"Applejuice Single Streng"."Apple pulp"
"Applejuice Concentrated"."Apple pulp"
*no coprod, thus dropped here
*"Cassava Tapioca"
*no coprod, thus dropped here
*"Flour, Cassava"
"Flour, Sorghum"."Bran, sorghum"
"Flour, Triticale"."Bran, Triticale"
*buckwheat also has hulls - but we leave them away as they are neither in the data
"Flour, Buckwheat"."Bran, buckwheat"
"Flour, Millet"."Bran, millet"
"Flour, Rye"."Bran, Rye"
*co-prod added by us - not in the data
"Jojoba Oil"."Jojoba cake"
*unimportant
*"Leaves And Tops, Vines"
"Lemonjuice Single-Streng"."Lemon pulp"
"Mango Juice"."Mango Pulp"
*no coprod, thus dropped here
*"Dried Mushrooms"
"Must Of Grapes"."Marc Of Grapes"
"Oil, Hempseed"."Cake, hempseed"
"Oil, Mustard Seed"."Cake, mustard"
*Barley also has hulls - but we leave them away as they are neither in the data
"Pot Barley"."Bran, Barley"
*no coprod, thus dropped here
*"Plums, Dried (Prunes)"
*no coprod, thus dropped here
*"Potato Starch"
*no coprod, thus dropped here
*"Potato Tapioca"
*unimportant
*"Pyrethrum Marc"

$ontext;
*The commod trees of the following are dealt with only later
*this is third level
"Cake, kapok"
"Oil, kapok"

"Cane tops"
"Cashewapple"
"Cocoons, unreelable & waste"
"Maple sugar and syrups"
"Pastry"
"Popcorn"
"Rubber natural dry"
"Silk raw"
"Silk-worm cocoons, reelable"
"Vegetable tallow"
"Tobacco products nes"
"Wheat+Flour,Wheat Equivalent"
"Beet Tops"
"Malt Extracts"
*this is a by-product of coconuts, not covered in the commodity trees
"Coir"
*this is a by-product of hempseed, not covered in the commodity trees
"Hemp Fibre And Tow"

"Flax Fib+Tow+W"
"Flax fibre and tow"
"Flax fibre raw"
"Flax tow waste"
*END OF: The commod trees of the following are dealt with only later
$offtext;

*co-prod added by us - not in the data
"Tangerine Juice"."Tangerine pulp"
*co-prod added by us - not in the data
"Tomatojuice Concentrated"."Tomato pulp"
*co-prod added by us - not in the data
"Tung Oil"."Tung nut cake"

*MAIN-prod added by us - not in the data
"Oat flour"."Bran, Oats"
*MAIN-prod added by us - not in the data
"Cocoa paste"."Cocoa Husks+Shell"
"Oil palm fruit pulp"."Palm oil"
/;

set MatchMainWithCoProd_WellDefinedCoProducts_Level2(Commodities,Commodities_2)
/
*the following has no coproducts
*"Rice, Broken"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
*the following has no coproducts
*"Rice Flour"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
"Rice, Starch"."Rice Gluten"
"Oil, rice bran"."Cake, rice bran"
"Ricebran Oil"."Cake, rice bran"
"Palmkernel Oil"."Palmkernel Cake"
"Maize Germ Oil"."Cake, maize"
"Coconut Oil"."Copra Cake"
"Groundnut Oil"."Groundnut Cake"
*co-prod added by us - not in the data
"Beer of barley"."Beer of Barley dregs"
*we assume powder to be main product, not cocoa butter
"Cocoa, powder & cake"."Cocoa, butter"
"Barley, pearled"."Barley Flour And Grits"
*co-prod added by us - not in the data
"Kapokseed shelled"."Kapokseed shells"
*"Macaroni"
"Oil, palm kernel"."Cake, palm kernel"
"Oil, maize"."Cake, maize"
*co-prod added by us - not in the data
"Oil, olive residues"."Pressed olive residues"
"Oil, groundnut"."Cake, groundnuts"
"Oil, coconut (copra)"."Cake, copra"
*the following has no coproducts
*"Prepared Groundnuts"
"Starch Of Maize"."Maize Gluten"
"Wheat Starch"."Wheat Gluten"
*MAIN-prod added by us - not in the data
"Palm kernel oil"."Cake, Palm Kernels"
*MAIN-prod added by us - not in the data
"Wheat dregs"."Wheat Fermented Beverage"
/;

*some products have two byproducts, collect them separately:
alias(Commodities,Commodities_3);
set MatchMainWithCoPr_WellDefCoProd_Level1And2_TwoByprod(Commodities,Commodities_2,Commodities_3)
/
*co-prod added by us - not in the data
"Milled Paddy Rice"."Bran, Rice"."Rice hulls"
*co-prod added by us - not in the data
"Milled/Husked Rice"."Bran, Rice"."Rice hulls"
*cotton lint is the fibre, i.e. the main product!!
"Cotton lint"."Cottonseed"."Cotton waste"
*cotton, carded, combed is also the main product, fibre - it is derived from lint by carding/combing
"Cotton, carded, combed"."Cottonseed"."Cotton waste"
"Flour, maize"."Bran, maize"."Germ, maize"
"Flour, wheat"."Germ, Wheat"."Bran, wheat"
"Cottonseed Oil"."Cottonseed Cake"."Cotton linter"
"Oil, cottonseed"."Cake, cottonseed"."Cotton linter"
*middle co-prod added by us - not in the data
"Cane Sugar"."Molasse from cane"."Bagasse"
*middle co-prod added by us - not in the data
"Beet Sugar"."Molasse from beet"."Beet pulp"
/;


*and define another matching set, used e.g. to derive biomass in shells, etc. - used for bioenergy:
Set Match_ShellsEtc_Activities(Activities, Commodities)
/
"Coffee, green"."Coffee, husks and skins"
"Rice, paddy"."Rice hulls"
"Cocoa, beans"."Cocoa husks"
Olives."Pressed olive residues"
"Groundnuts, with shell"."Groundnut shells"
"Almonds, with shell"."Almond shells"
Coconuts."Coconut shells"
"Cashew nuts, with shell"."Cashew nut shells"
"Brazil nuts, with shell"."Brazil nut shells"
"Hazelnuts, with shell"."Hazelnut shells"
"Walnuts, with shell"."Walnut shells"
"Chestnut"."Chestnut shells"
"Pistachios"."Pistachio shells"
"Dates"."Dates - kernels"
*"Kapokseed shells"
*        Missing
"Apricots"."Apricot kernel shells"
"Cherries "."Cherries - kernels"
"Cherries, sour "."Cherries, sour - kernels"
"Peaches and nectarines "."Peaches and nectarines - kernels"
"Plums and sloes "."Plums and sloes - kernels"
/;



$exit;







