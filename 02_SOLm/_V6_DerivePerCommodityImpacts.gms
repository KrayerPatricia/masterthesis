PUTCLOSE con,"_V6_DerivePerCommodityImpacts";

*GENERAL DESCRIPTION
*This file contains the code to derive per commodity values for inputs, outputs, other characteristics (focusing on env. impacts) from the corresponding per primary product values

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Define some new parameters, etc.
- 2) Derive per commodity impacts values - Commod with extr. rate = 1
- 3) Derive per commodity impacts values - Commod with extr. rate NON-EQUAL 1
- 4) Derive per unit calorie and protein impacts
$offtext;


*MODEL CODE:

*part of the code should run only once as it includes set definitions, etc.
$if NOT %Allocation% == "Mass" $goto CoreAllocationCode2


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
$ontext;

THE FOLLOWING SETS and PARAMETERS ARE ALREADY DEFINED IN _V6_Sets_GeneralModelSets_ForSteeringFile2

*1) Define some new parameters, etc.

Parameter PerCropCommodImpact_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) Impacts per crop commodity unit;
Parameter PerAnimalCommodImpact_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) Impacts per animal commodity unit;
Parameter PerAnimalCommodFeedInput_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,ProductionSystems,ProductionConditions,Scenarios) Feed commodity dry matter (t DM) per animal commodity unit;

Parameter AllocationFactor_MR(Regions,Commodities,Commodities_2,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios);
Parameter AllocationFactorDenominator_MR(Regions,Commodities,Commodities_2,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios);

*for later, we also need the impacts with an allocation characteristics dimension:
Parameter PerCropCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Impacts per crop commodity unit - with allocation characteristics dimension;
Parameter PerAnimalCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Impacts per animal commodity unit - with allocation characteristics dimension;
Parameter PerAnimalCommodFeedInput_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Feed commodity dry matter (t DM) per animal commodity unit - with allocation characteristics dimension;

Parameter ActCropsGrass_PerPrimProdImpact_WithAllocChar_MR(Regions,Activities,PerCommodImpact,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Impacts per primary product unit on activity level - with allocation characteristics dimension;
Parameter ActAnimalsAPU_PerPrimProdImpact_WithAllocChar_MR(Regions,Activities,AnimalTypeInHerd,PerCommodImpact,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Impacts per primary product unit on activity level - with allocation characteristics dimension;
Parameter FeedingRationsAPU_PerPrimProdContents_WithAllocChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Feed commodity inputs per primary product unit on activity level - with allocation characteristics dimension;

Set UnitOfReference_PerCommodImpacts
/
"Reference unit: ton fresh matter"
"Reference unit: 1000 kcal"
"Reference unit: ton protein"
"Reference unit: 1000 $"
/
;
Parameter PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios) Impacts per crop commodity - with allocation characteristics dimension - per unit mass calorie or protein;
Parameter PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios) Impacts per animal commodity - with allocation characteristics dimension - per unit mass calorie or protein;
Parameter PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios) Feed commodity dry matter (t DM) per animal commodity - with allocation characteristics dimension - per unit mass calorie or protein;

*and we need the following auxiliary parameters and variables to fasten the code:
Parameter Inverse_Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios);
Parameter Inverse_Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios);

Variable Inverse_VActAnimalsHead_QuantityActUnits_MR(Regions,Activities,AnimalTypeInherd,ProductionSystems,ProductionConditions,Scenarios);


*animal products:
*we need a specific animal output for dairy herd sourdced beef - and for the average from dairy and beef herd as well:
$onmulti
Set OutputsAnimals
/
"Meat (t) (from dairy herd)"
"Meat (t) (weighted dairy/beef herd)"
/;
$offmulti


Set Match_MainProdAndCoProd(Commodities,Commodities_2)
/
*SET1
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

*SET3
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
"Coconuts, desiccated"."Coconut shells"
*co-prod added by us - not in the data
"Copra"."Coconut shells"
*no coprod, thus dropped here
*"Cassava dried"
"Almonds shelled"."Almond shells"
"Apricots, dry"."Apricot kernel"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Cake, soybeans"."Oil, soybean"
*PROPOSAL
"Oil, soybean"."Cake, soybeans"
"Bran, wheat"."Flour, wheat"

*no coprod, thus dropped here
*"Flour, mustard"
*no coprod, thus dropped here
*"Flour, potatoes"
"Flour, fonio"."Bran, fonio"
"Flour, mixed grain"."Bran, Mixed Grain"
"Flour, wheat"."Bran, wheat"
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
*$offtext;

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

*SET4
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


*SET5
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
*        "Fatty livers of ducks and geese when cooked, prepared or preserved(e.g. pat‚)."
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
*$offtext;

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


*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
*NOW DO ASSIGN THE CO-products first, then the products: this allows to derive the impacts for the co-products as well:
*do it for these where the main/Coprod pairs are given only, and also there for the important ones only
*and sometimes, a co-prod comes with several main prods, then do it only for one of those
*SET1
"Dregs - beer"."Beer"
**TOO UNSPECIFIED - drop for now "Brans"
**linked below "Bran, Cereals"
**linked below "Bran, Pulses"
**TOO UNSPECIFIED - drop for now "Cereals, Other"
*        "Default composition: 68 Popcorn, 89 Buckwheat, 90 Flour, buckwheat, 91 Bran, buckwheat, 92 Quinoa, 94 Fonio, 95 Flour, fonio, 96 Bran, fonio, 97 Triticale, 98 Flour, triticale, 99 Bran, triticale, 101 Canary seed, 103 Grain, mixed,
*        104 Flour, mixed grain, 105 Bran, mixed grains, 108 Cereals, nes, 111 Flour, cereals, 112 Bran, cereals nes, 113 Cereal preparations, nes"
**TOO UNSPECIFIED - drop for now "Citrus, Other"
*This is 2614."Citrus, Other": "Default composition: 512 Fruit, citrus nes, 513 Juice, citrus, single strength, 514 Juice, citrus, concentrated"
"Oilseed Cakes, Other"."Oilcrops Oil, Other"
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
"Rape and Mustard Cake"."Rape and Mustard Oil"
*"Bread"
*"Feed, pulp of fruit"
*"Feed, vegetable products nes"
"Bran, Cereals"."Flour, cereals"
"Bran, Pulses"."Flour, pulses"
**TOO UNSPECIFIED - drop for now "Flour, roots and tubers nes"
*"Fruit, dried nes"
*"Fruit, prepared nes"
****CoprodMainProd not assigned: "Juice, citrus, concentrated"."Citrus pulp"
"Citrus pulp"."Juice, citrus, single strength"
"Fruit pulp"."Juice, fruit nes"
*"Nuts, prepared (exc. groundnuts)"
"Oilseed Cake Meal"."Oilcrops Oil, Other"
"Oilseed Cake nes"."Oilcrops Oil, Other"
"Rape and Mustard Cake"."Rape+Mustard Oils"
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
"Brans, mixed grain"."Flour, mixed grain"

*SET3
*co-prod added by us - not in the data
"Rice hulls"."Rice, Husked"
"Kapok fibre"."Kapokseed in shell"
*cotton linter is not included on the level of these terms (it is for "oil, cottonseed" and "cake, cottonseed")
"Palm kernels"."Palm Oil"
"Marc of Grapes"."Wine"
"Sesameseed Cake"."Sesameseed Oil"
*this may cover olive oil virgin and from residues - then the co-product is residues and pressed resides, the latter not being covered in the system
"Olive Residues"."Olive Oil"
*co-prod added by us - not in the data
"Groundnut shells"."Groundnuts (Shelled Eq)"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Soyabean Oil"."Soyabean Cake"
"Sunflowerseed Cake"."Sunflowerseed Oil"
*co-prod added by us - not in the data
"Beer of Shorgum dregs"."Beer of sorghum"
*no co-products, thus dropped here
*"Bulgur"
*co-prod added by us - not in the data
"Cocoa husks"."Cocoa, paste"
*unimportant, leave out for now
*"Coffee, extracts"
"Coffee, husks and skins"."Coffee, roasted"
*co-prod added by us - not in the data
"Karite nut cake"."Butter of karite nuts"
*co-prod added by us - not in the data
"Brazil nut shells"."Brazil nuts, shelled"
*no coprod, thus dropped here
*"Alfalfa meal and pellets"
*co-prod added by us - not in the data
"Cashew nut shells"."Cashew nuts, shelled"
*co-prod added by us - not in the data
"Coconut shells"."Coconuts, desiccated"
*co-prod added by us - not in the data
"Coconut shells"."Copra"
*no coprod, thus dropped here
*"Cassava dried"
"Almond shells"."Almonds shelled"
"Apricot kernel"."Apricots, dry"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
*"Oil, soybean"."Cake, soybeans"
*no coprod, thus dropped here
*"Flour, mustard"
*no coprod, thus dropped here
*"Flour, potatoes"
"Bran, fonio"."Flour, fonio"
"Bran, Mixed Grain"."Flour, mixed grain"
*"Bran, wheat"."Flour, wheat"
*no coprod, thus dropped here
*"Figs dried"
*for all the juices below: co-prod added by us - not in the data

"Tomato pulp"."Juice, tomato"
"Grape pulp"."Juice, grape"
"Grapefruit pulp"."Juice, grapefruit"
****CoprodMainProd not assigned: "Juice, grapefruit, concentrated"."Grapefruit pulp"
****CoprodMainProd not assigned: "Juice, lemon, concentrated"."Lemon pulp"
****CoprodMainProd not assigned: "Juice, orange, concentrated"."Orange pulp"
"Orange pulp"."Juice, orange, single strength"
"Pineapple pulp"."Juice, pineapple"
****CoprodMainProd not assigned: "Juice, pineapple, concentrated"."Pineapple pulp"
****CoprodMainProd not assigned: "Juice, plum, concentrated"."Plum pulp"
"Plum pulp"."Juice, plum, single strength"
*co-prod added by us - not in the data
"Hazelnut shells"."Hazelnuts, shelled"
*may not use this total but the next
*"Groundnuts Total Shelled"
"Groundnut shells"."Groundnuts, shelled"
*no coprod, thus dropped here
*"Malt"
*no coprod, thus dropped here
*"Mushrooms, canned"
*co-prod added by us - not in the data
"Palm kernels"."Oil, palm"
"Cake, linseed"."Oil, linseed"
"Cake, rapeseed"."Oil, rapeseed"
"Cake, safflower"."Oil, safflower"
"Cake, sesame seed"."Oil, sesame"
"Cake Of Poppy Seed"."Oil, poppy"
"Cake, sunflower"."Oil, sunflower"
"Olive residues"."Oil, olive, virgin"
*the following is likely the sum of olive oil virgin plus oil, olive residues
*"Olive Oil,Total"
*co-prod added by us - not in the data
"Castor bean cake"."Oil, castor beans"
*coproducts oat offals and hulls not in the data - drop for now
*"Oats rolled".OAT OFFALS.HULLS
*no coprod, thus dropped here
*"Peanut butter"
*coproducts juice and pulp - but not in the data - just take "Pineapple pulp"
****CoprodMainProd not assigned: "Pineapples canned"."Pineapple pulp"
*no coprod, thus dropped here
*"Plums dried (prunes)"
****CoprodMainProd not assigned: "Potatoes, frozen"."Potato offals"
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
"Walnut shells"."Walnuts, shelled"
*co-prod added by us - not in the data
****CoprodMainProd not assigned: "Tomatoes, paste"."Tomato pulp"
*co-prod added by us - not in the data
****CoprodMainProd not assigned: "Tomatoes, peeled"."Tomato pulp"
*co-prod added by us - not in the data
"Apple pulp"."Applejuice Single Streng"
****CoprodMainProd not assigned: "Applejuice Concentrated"."Apple pulp"
*no coprod, thus dropped here
*"Cassava Tapioca"
*no coprod, thus dropped here
*"Flour, Cassava"
"Bran, sorghum"."Flour, Sorghum"
"Bran, Triticale"."Flour, Triticale"
*buckwheat also has hulls - but we leave them away as they are neither in the data
"Bran, buckwheat"."Flour, Buckwheat"
"Bran, millet"."Flour, Millet"
"Bran, Rye"."Flour, Rye"
*co-prod added by us - not in the data
"Jojoba cake"."Jojoba Oil"
*unimportant
*"Leaves And Tops, Vines"
"Lemon pulp"."Lemonjuice Single-Streng"
"Mango Pulp"."Mango Juice"
*no coprod, thus dropped here
*"Dried Mushrooms"
****CoprodMainProd not assigned: "Must Of Grapes"."Marc Of Grapes"
"Cake, hempseed"."Oil, Hempseed"
"Cake, mustard"."Oil, Mustard Seed"
*Barley also has hulls - but we leave them away as they are neither in the data
"Bran, Barley"."Pot Barley"
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
*$offtext;

*co-prod added by us - not in the data
"Tangerine pulp"."Tangerine Juice"
*co-prod added by us - not in the data
****CoprodMainProd not assigned: "Tomatojuice Concentrated"."Tomato pulp"
*co-prod added by us - not in the data
"Tung nut cake"."Tung Oil"

*MAIN-prod added by us - not in the data
"Bran, Oats"."Oat flour"
*MAIN-prod added by us - not in the data
"Cocoa Husks+Shell"."Cocoa paste"
"Palm oil"."Oil palm fruit pulp"

*THE FOLLOWING are the LEVEL2 co-products:

*the following has no coproducts
*"Rice, Broken"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
*the following has no coproducts
*"Rice Flour"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
"Rice Gluten"."Rice, Starch"
"Cake, rice bran"."Oil, rice bran"
"Cake, rice bran"."Ricebran Oil"
"Palmkernel Cake"."Palmkernel Oil"
"Cake, maize"."Maize Germ Oil"
"Copra Cake"."Coconut Oil"
"Groundnut Cake"."Groundnut Oil"
*co-prod added by us - not in the data
"Beer of Barley dregs"."Beer of barley"
*we assume powder to be main product, not cocoa butter
"Cocoa, butter"."Cocoa, powder & cake"
"Barley Flour And Grits"."Barley, pearled"
*co-prod added by us - not in the data
"Kapokseed shells"."Kapokseed shelled"
*"Macaroni"
"Cake, palm kernel"."Oil, palm kernel"
"Cake, maize"."Oil, maize"
*co-prod added by us - not in the data
"Pressed olive residues"."Oil, olive residues"
"Cake, groundnuts"."Oil, groundnut"
"Cake, copra"."Oil, coconut (copra)"
*the following has no coproducts
*"Prepared Groundnuts"
"Maize Gluten"."Starch Of Maize"
"Wheat Gluten"."Wheat Starch"
*MAIN-prod added by us - not in the data
"Cake, Palm Kernels"."Palm kernel oil"
*MAIN-prod added by us - not in the data
"Wheat Fermented Beverage"."Wheat dregs"

*$ontext;
ADD THE NEEDED CoProd-MainProd-pairs later!! besides Molasse
*SET4
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
*$offtext;

"Molasses"."Sugar, Refined Equiv"
"Molasses (sugar cane)"."Sugar, Refined Equiv (sugar cane)"
"Molasses (sugar beet)"."Sugar, Refined Equiv (sugar beet)"
$ontext;
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
*$offtext;

*SET5
*"Animal Products"
*"Bovine Meat"
*        complex description in FAOSTAT - for simplicity, we take it identical to cattle meat and add it to the corresponding subset
"Milk, Skimmed"."Butter, Ghee"
"Whey"."Cheese"
****CoprodMainProd not assigned: "Cream"."Milk, Skimmed"
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
****CoprodMainProd not assigned: "Butter"."Milk, Skimmed"
"Milk, skimmed cow"."Butter, cow milk"
*DROP FOR NOW - not so important: "Buttermilk, curdled, acidified milk"
*"Canned Meat nes"
****CoprodMainProd not assigned: "Cheese and Curd"."Whey"
****CoprodMainProd not assigned: "Cheese, processed"."Whey"
****CoprodMainProd not assigned: "Cheese, sheep milk"."Whey"
****CoprodMainProd not assigned: "Cheese, whole cow milk"."Whey"
****CoprodMainProd not assigned: "Cream fresh"."Milk, Skimmed"
*"Eggs Liquid,Dried"
*DO THIS LATER "Eggs, dried"
*DO THIS LATER "Eggs, liquid"
*"Fat, liver prepared (foie gras)"
*This is needed to match 1060."Fat, liver prepared (foie gras)" with activities:
*        "Fatty livers of ducks and geese when cooked, prepared or preserved(e.g. pat‚)."
*"Fat, nes, prepared"
*"Fatty acids"
*"Fatty substance residues"
"Skim Milk Of Buffalo"."Ghee, of buffalo milk"
*"Grease incl. lanolin wool"
*"Lactose"
*"Lard"
*"Meal, meat"
*"Meat and Meat Preparations"
*"Meat Fresh+Ch+Frozen"
*"Meat Prepared Pres"
****CoprodMainProd not assigned: "Meat, beef and veal sausages"."Cattle Butcher Fat"
*"Meat, beef, preparations"
"Cattle Butcher Fat"."Meat, cattle, boneless (beef & veal)"
*"Meat, chicken, canned"
*"Meat, dried nes"
****CoprodMainProd not assigned: "Meat, pig sausages"."Pig Butcher Fat"
****CoprodMainProd not assigned: "Meat, pig, preparations"."Pig Butcher Fat"
"Pig Butcher Fat"."Meat, pork"
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
****CoprodMainProd not assigned: "Yoghurt, concentrated or not"."Water"
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
*$offtext;
****CoprodMainProd not assigned: "Butter Of Buffalo Milk"."Skim Milk Of Buffalo"
"Skim Milk Of Goat"."Butter Of Goat Milk"
"Skim Sheep Milk"."Butter+Ghee (Sheep Milk)"
*"Dry Buttermilk"
*"Casein"
****CoprodMainProd not assigned: "Cheese Of Buffalo Milk"."Whey"
****CoprodMainProd not assigned: "Cheese Of Goat Milk"."Whey"
****CoprodMainProd not assigned: "Cheese (Skim Cow Milk)"."Whey"
*"Game"
*"Geese"
*"Geese and guinea fowls"
****CoprodMainProd not assigned: "Ghee, of cow milk"."Milk, skimmed cow"
*"Whey Cheese"
*DO NOT NOW "Whey, Fresh"
*"Wool Shoddy"
****CoprodMainProd not assigned: "Yoghurt"."Water"
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
****CoprodMainProd not assigned: 'Hard cheese'."Whey"
****CoprodMainProd not assigned: 'Semihard cheese'."Whey"
****CoprodMainProd not assigned: 'Soft cheese'."Whey"

/;

*$offtext;

Set Match_MainProdAndCoProd_MainProdOnly(Commodities,Commodities_2)
*this is the mathcing file from above, but including the main products at first place only,
*this is used for main-product-based allocation.
/
*SET1
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

*SET3
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
"Coconuts, desiccated"."Coconut shells"
*co-prod added by us - not in the data
"Copra"."Coconut shells"
*no coprod, thus dropped here
*"Cassava dried"
"Almonds shelled"."Almond shells"
"Apricots, dry"."Apricot kernel"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Cake, soybeans"."Oil, soybean"
*PROPOSAL
*"Oil, soybean"."Cake, soybeans"
*"Bran, wheat"."Flour, wheat"

*no coprod, thus dropped here
*"Flour, mustard"
*no coprod, thus dropped here
*"Flour, potatoes"
"Flour, fonio"."Bran, fonio"
"Flour, mixed grain"."Bran, Mixed Grain"
"Flour, wheat"."Bran, wheat"
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
*$offtext;

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

*SET4
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


*SET5
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
*        "Fatty livers of ducks and geese when cooked, prepared or preserved(e.g. pat‚)."
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
*$ontext;
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
*$offtext;
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
$offtext;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************

$label CoreAllocationCode2

*2) Derive per commodity impacts values - Commod with extr. rate = 1
*this applies to the sets 2,6 and 7

*The following sets have extraction rates 1, impacts per commodity thus equal impacts per primary products:
*hence, no allocation needed
$ontext;
Set2
set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass)
Set6
set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
set MatchCommAct_CommodEquivalentAct_Animals(Commodities,Activities,OutputsAnimals)
Set7
set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCrops)
$offtext;


*Set2
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_AggregateActivities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_AggregateActivities_Crops(SubsetCommod_MatchWithAct_AggregateActivities,Activities_MR,OutputsCropsGrass)
         = ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios);

*Set6
*crops:
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_CommodEquivalentAct,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_CommodEquivalentAct_Crops(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities_MR,OutputsCropsGrass)
         = ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios);

*animal products:
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_CommodEquivalentAct,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_CommodEquivalentAct_Animals(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities_MR,"Meat (t)")
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios);
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_CommodEquivalentAct,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_CommodEquivalentAct_Animals(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities_MR,"Milk (t)")
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Milk producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios);
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_CommodEquivalentAct,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_CommodEquivalentAct_Animals(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities_MR,"Eggs (t)")
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Egg producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios);
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_CommodEquivalentAct,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_CommodEquivalentAct_Animals(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities_MR,"Meat (t)")
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios);
*add fat and offals from meat production:
$ontext;
TO BE DONE LATER - correctly (Fat as a co product from meat and hides as outputs from liveweight of animals, not from carcass weight which is meat as primary product.
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Fat (t)",SubsetCommod_MatchWithAct_CommodEquivalentAct,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_CommodEquivalentAct_Animals(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities_MR,"Fat (t)")
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct))
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct);
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Offals (t)",SubsetCommod_MatchWithAct_CommodEquivalentAct,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_CommodEquivalentAct_Animals(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities_MR,"Offals (t)")
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct))
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct);
*hides, skins to be added later.
$offtext;


PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_CommodEquivalentAct,Commodities_2,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_CommodEquivalentAct_Animals(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities_MR,"Meat (t)")
         = FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing",Commodities_2,"DM (t)",ProductionSystems,ProductionConditions,Scenarios);
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_CommodEquivalentAct,Commodities_2,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_CommodEquivalentAct_Animals(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities_MR,"Milk (t)")
         = FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Milk producing",Commodities_2,"DM (t)",ProductionSystems,ProductionConditions,Scenarios);
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_CommodEquivalentAct,Commodities_2,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_CommodEquivalentAct_Animals(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities_MR,"Eggs (t)")
         = FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Egg producing",Commodities_2,"DM (t)",ProductionSystems,ProductionConditions,Scenarios);
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_CommodEquivalentAct,Commodities_2,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_CommodEquivalentAct_Animals(SubsetCommod_MatchWithAct_CommodEquivalentAct,Activities_MR,"Meat (t)")
         = FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",Commodities_2,"DM (t)",ProductionSystems,ProductionConditions,Scenarios);


*Set7
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_CommodAndProductsEquivalentAct_Crops(SubsetCommod_MatchWithAct_CommodAndProductsEquivalentAct,Activities_MR,OutputsCropsGrass)
         = ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios);


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Derive per commodity impacts values - Commod with extr. rate NON-EQUAL 1
*this applies to the sets 1,3,4 and 5


$ontext;
Formulae for the allocation:

Allocation based on AllocCharacteristics of the MainProduct and the CoProducts (usually one, but in some cases 2), i,e. Prod1 and Prod2:

the share for Prod1 in Impact of 1 ton PrimProd is derived as follows (1 ton PrimaryProd = 1t*ExtrRateProd1 + 1t*ExtrRateProd2);
1ton PrimProd has AllocCharactContentsPrimProd quantity of AllocCharact = ExtrRateProd1*AllocCharactContentsProd1 + ExtrRateProd2*AllocCharactContentsProd2:

Thus, the share of impact for Prod1 based on AllocCharact allocation is: ImpactPerPrimProd * ExtrRateProd1*AllocCharactContentsProd1 / (ExtrRateProd1*AllocCharactContentsProd1 + ExtrRateProd2*AllocCharactContentsProd2)
Thus, the impact per ExtractionRate-share of one ton Commod is ImpactPerPrimProd * ExtrRateProd1*AllocCharactContentsProd1 / (ExtrRateProd1*AllocCharactContentsProd1 + ExtrRateProd2*AllocCharactContentsProd2)
We are however interested in the impact PER TON commodity, i.e. dividing this share in the impact of 1 ton primary product by the extraction rate:

ImpactperTonProd1 = ImpactShareOProd1InPerTonPrimProdImpact / ExtrRateProd1 = ImpactPerPrimProd * ExtrRateProd1*AllocCharactContentsProd1 / (ExtrRateProd1*AllocCharactContentsProd1 + ExtrRateProd2*AllocCharactContentsProd2)/ ExtrRateProd1
         = ImpactPerPrimProd * AllocCharactContentsProd1 / (ExtrRateProd1*AllocCharactContentsProd1 + ExtrRateProd2*AllocCharactContentsProd2)

For mass allocation this equals the following (as AllocCharactContents is ton/ton = 1)
ImpactperTonProd1 = ImpactPerPrimProd / (ExtrRateProd1 + ExtrRateProd2)

$offtext;

*as said above, this is needed for SET1,3,4,5, thus collect the corresponding elements in one matching set for main and co-products:
*Set Match_MainProdAndCoProd(Commodities,Commodities_2)
*this set is already defined further up


*AllocationFactorDenominator_MR for "Mass" is simpler, as the AllocCharactCont = 1:
AllocationFactorDenominator_MR(Regions_MR,Commodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios)
*as the RHS has no scenario and ProductionSystems definitions, we need an additional condition to avoid allocation to all possible entries - hence the first term in the conditional assignment:
*take protein for a product which is largely always present: wheat
                 $(Commod_Contents_MR(Regions_MR,"Wheat","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                         AND Match_MainProdAndCoProd(Commodities,Commodities_2)
                                 AND (ExtractionRate_CommodityTree(Regions_MR,Commodities)
                                         + ExtractionRate_CommodityTree(Regions_MR,Commodities_2)))
         = 1 /(ExtractionRate_CommodityTree(Regions_MR,Commodities)
                         + ExtractionRate_CommodityTree(Regions_MR,Commodities_2));


AllocationFactorDenominator_MR(Regions_MR,Commodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios)
                 $(Match_MainProdAndCoProd(Commodities,Commodities_2)
                         AND (ExtractionRate_CommodityTree(Regions_MR,Commodities)*Commod_Contents_MR(Regions_MR,Commodities,"Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                                 + ExtractionRate_CommodityTree(Regions_MR,Commodities_2)*Commod_Contents_MR(Regions_MR,Commodities_2,"Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)))
         = 1 /(ExtractionRate_CommodityTree(Regions_MR,Commodities)*Commod_Contents_MR(Regions_MR,Commodities,"Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                         + ExtractionRate_CommodityTree(Regions_MR,Commodities_2)*Commod_Contents_MR(Regions_MR,Commodities_2,"Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios));


AllocationFactorDenominator_MR(Regions_MR,Commodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios)
                 $(Match_MainProdAndCoProd(Commodities,Commodities_2)
                         AND (ExtractionRate_CommodityTree(Regions_MR,Commodities)*Commod_Contents_MR(Regions_MR,Commodities,"Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                                 + ExtractionRate_CommodityTree(Regions_MR,Commodities_2)*Commod_Contents_MR(Regions_MR,Commodities_2,"Protein (t)",ProductionSystems,ProductionConditions,Scenarios)))
         = 1 /(ExtractionRate_CommodityTree(Regions_MR,Commodities)*Commod_Contents_MR(Regions_MR,Commodities,"Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                         + ExtractionRate_CommodityTree(Regions_MR,Commodities_2)*Commod_Contents_MR(Regions_MR,Commodities_2,"Protein (t)",ProductionSystems,ProductionConditions,Scenarios));


AllocationFactorDenominator_MR(Regions_MR,Commodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios)
                 $(Match_MainProdAndCoProd(Commodities,Commodities_2)
                         AND (ExtractionRate_CommodityTree(Regions_MR,Commodities)*Commod_OtherChar_MR(Regions_MR,Commodities,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
                                 + ExtractionRate_CommodityTree(Regions_MR,Commodities_2)*Commod_OtherChar_MR(Regions_MR,Commodities_2,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)))
         = 1 /(ExtractionRate_CommodityTree(Regions_MR,Commodities)*Commod_OtherChar_MR(Regions_MR,Commodities,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
                         + ExtractionRate_CommodityTree(Regions_MR,Commodities_2)*Commod_OtherChar_MR(Regions_MR,Commodities_2,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios));

AllocationFactorDenominator_MR(Regions_MR,Commodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios)
*as the RHS has no scenario and ProductionSystems definitions, we need an additional condition to avoid allocation to all possible entries - hence the first term in the conditional assignment:
*take mass allocation denominator which is always present
                 $(AllocationFactorDenominator_MR(Regions_MR,Commodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios)
                         AND Match_MainProdAndCoProd_MainProdOnly(Commodities,Commodities_2)
                                 AND ExtractionRate_CommodityTree(Regions_MR,Commodities))
         = 1 /ExtractionRate_CommodityTree(Regions_MR,Commodities);

$ontext;
now derive the full factors:
cf. above lines 162/163:
ImpactperTonProd1 = ImpactShareOProd1InPerTonPrimProdImpact / ExtrRateProd1 = ImpactPerPrimProd * ExtrRateProd1*AllocCharactContentsProd1 / (ExtrRateProd1*AllocCharactContentsProd1 + ExtrRateProd2*AllocCharactContentsProd2)/ ExtrRateProd1
         = ImpactPerPrimProd * AllocCharactContentsProd1 / (ExtrRateProd1*AllocCharactContentsProd1 + ExtrRateProd2*AllocCharactContentsProd2)
         = ImpactPerPrimProd * AllocFactor
For mass allocation this equals the following (as AllocCharactContents is ton/ton = 1)
ImpactperTonProd1 = ImpactPerPrimProd / (ExtrRateProd1 + ExtrRateProd2)
         = ImpactPerPrimProd * AllocFactor

Thus: AllocFactor = AllocCharactContents*AllocFactorDenominator:
$offtext;

AllocationFactor_MR(Regions_MR,Commodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios)
*                 $Match_MainProdAndCoProd(Commodities,Commodities_2)
*matching not needed, as already taken into account for deriving the alloc factor denominator
         = AllocationFactorDenominator_MR(Regions_MR,Commodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios);
AllocationFactor_MR(Regions_MR,Commodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios)
*                 $Match_MainProdAndCoProd(Commodities,Commodities_2)
         = Commod_Contents_MR(Regions_MR,Commodities,"Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactorDenominator_MR(Regions_MR,Commodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios);
AllocationFactor_MR(Regions_MR,Commodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios)
*                 $Match_MainProdAndCoProd(Commodities,Commodities_2)
         = Commod_Contents_MR(Regions_MR,Commodities,"Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactorDenominator_MR(Regions_MR,Commodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios);
AllocationFactor_MR(Regions_MR,Commodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios)
*                 $Match_MainProdAndCoProd(Commodities,Commodities_2)
         = Commod_OtherChar_MR(Regions_MR,Commodities,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactorDenominator_MR(Regions_MR,Commodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios);

AllocationFactor_MR(Regions_MR,Commodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios)
*                 $Match_MainProdAndCoProd_MainProdOnly(Commodities,Commodities_2)
         = AllocationFactorDenominator_MR(Regions_MR,Commodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios);


*MatchCommAct_XXX is the sum of all matching sets such as MatchCommAct_AggregateCommodities_Crops and the others
$ontext;
there are the following sets:
Set1
set SubsetCommod_MatchWithAct_AggregateCommodities(Commodities)
set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)

Set3
set SubsetCommod_MatchWithAct_WellDefinedCoProducts(Commodities)
set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)

Set4
set SubsetCommod_MatchWithAct_ComplexCases(Commodities)
set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass)

Set5
set SubsetCommod_MatchWithAct_ComplexAnimalCommodities(Commodities)
set MatchCommAct_ComplexAnimalCommodities(Commodities,Activities,OutputsAnimals)
$offtext;


$if %Allocation% == "Mass" $goto AllocationMassBased
$if %Allocation% == "Calories" $goto AllocationCalorieBased
$if %Allocation% == "Protein" $goto AllocationProteinBased
$if %Allocation% == "Price" $goto AllocationPriceBased
$if %Allocation% == "MainProduct" $goto AllocationMainProductBased


*DO: values for aggregate conmmod that are needed in the matching!!


$label AllocationMassBased
*Set1
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_AggregateCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_AggregateCommodities_Crops(SubsetCommod_MatchWithAct_AggregateCommodities,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_AggregateCommodities,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_AggregateCommodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios));
*Set3
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_WellDefinedCoProducts,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_WellDefinedCoProducts_Crops(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_WellDefinedCoProducts,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios));
*Set4
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_ComplexCases,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexCases_Crops(SubsetCommod_MatchWithAct_ComplexCases,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexCases,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexCases,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios));
*Set5
*ONLY ANIMALS
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Milk producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Egg producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios));
*add fat and offals from meat production:
*TO BE DONE LATER - correctly (Fat as a co product from meat and hides as outputs from liveweight of animals, not from carcass weight which is meat as primary product.
*hides, skins to be added later.
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Mass",ProductionSystems,ProductionConditions,Scenarios));

$goto EndOfAllocationSpecificPerPrimProdCalculations



$label AllocationCalorieBased
*Set1
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_AggregateCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_AggregateCommodities_Crops(SubsetCommod_MatchWithAct_AggregateCommodities,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_AggregateCommodities,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_AggregateCommodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios));
*Set3
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_WellDefinedCoProducts,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_WellDefinedCoProducts_Crops(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_WellDefinedCoProducts,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios));
*Set4
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_ComplexCases,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexCases_Crops(SubsetCommod_MatchWithAct_ComplexCases,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexCases,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexCases,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios));
*Set5
*ONLY ANIMALS
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Milk producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Egg producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios));
*add fat and offals from meat production:
*TO BE DONE LATER - correctly (Fat as a co product from meat and hides as outputs from liveweight of animals, not from carcass weight which is meat as primary product.
*hides, skins to be added later.
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Calories",ProductionSystems,ProductionConditions,Scenarios));

$goto EndOfAllocationSpecificPerPrimProdCalculations




$label AllocationProteinBased
*Set1
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_AggregateCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_AggregateCommodities_Crops(SubsetCommod_MatchWithAct_AggregateCommodities,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_AggregateCommodities,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_AggregateCommodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios));
*Set3
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_WellDefinedCoProducts,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_WellDefinedCoProducts_Crops(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_WellDefinedCoProducts,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios));
*Set4
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_ComplexCases,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexCases_Crops(SubsetCommod_MatchWithAct_ComplexCases,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexCases,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexCases,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios));
*Set5
*ONLY ANIMALS
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Milk producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Egg producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios));
*add fat and offals from meat production:
*TO BE DONE LATER - correctly (Fat as a co product from meat and hides as outputs from liveweight of animals, not from carcass weight which is meat as primary product.
*hides, skins to be added later.
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Protein",ProductionSystems,ProductionConditions,Scenarios));


$goto EndOfAllocationSpecificPerPrimProdCalculations




$label AllocationPriceBased
*Set1
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_AggregateCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_AggregateCommodities_Crops(SubsetCommod_MatchWithAct_AggregateCommodities,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_AggregateCommodities,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_AggregateCommodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios));
*Set3
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_WellDefinedCoProducts,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_WellDefinedCoProducts_Crops(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_WellDefinedCoProducts,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios));
*Set4
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_ComplexCases,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexCases_Crops(SubsetCommod_MatchWithAct_ComplexCases,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexCases,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexCases,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios));
*Set5
*ONLY ANIMALS
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Milk producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Egg producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios));
*add fat and offals from meat production:
*TO BE DONE LATER - correctly (Fat as a co product from meat and hides as outputs from liveweight of animals, not from carcass weight which is meat as primary product.
*hides, skins to be added later.
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"Price",ProductionSystems,ProductionConditions,Scenarios));

$goto EndOfAllocationSpecificPerPrimProdCalculations


$label AllocationMainProductBased
*Set1
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_AggregateCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_AggregateCommodities_Crops(SubsetCommod_MatchWithAct_AggregateCommodities,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd_MainProdOnly(SubsetCommod_MatchWithAct_AggregateCommodities,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_AggregateCommodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios));
*Set3
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_WellDefinedCoProducts,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_WellDefinedCoProducts_Crops(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd_MainProdOnly(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_WellDefinedCoProducts,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios));
*Set4
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_ComplexCases,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexCases_Crops(SubsetCommod_MatchWithAct_ComplexCases,Activities_MR,OutputsCropsGrass)
         = sum(Commodities_2$Match_MainProdAndCoProd_MainProdOnly(SubsetCommod_MatchWithAct_ComplexCases,Commodities_2),
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexCases,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios));
*Set5
*ONLY ANIMALS
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd_MainProdOnly(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd_MainProdOnly(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Milk producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd_MainProdOnly(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Egg producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd_MainProdOnly(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios));
*add fat and offals from meat production:
*TO BE DONE LATER - correctly (Fat as a co product from meat and hides as outputs from liveweight of animals, not from carcass weight which is meat as primary product.
*hides, skins to be added later.
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd_MainProdOnly(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd_MainProdOnly(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd_MainProdOnly(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios));
PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t) (from dairy herd)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
         = sum(Commodities_2$Match_MainProdAndCoProd_MainProdOnly(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2),
                 FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing (from dairy herd)",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *AllocationFactor_MR(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,"MainProduct",ProductionSystems,ProductionConditions,Scenarios));

$goto EndOfAllocationSpecificPerPrimProdCalculations


$label EndOfAllocationSpecificPerPrimProdCalculations


*assign the per commod impacts to a parameter with allocation characteristics dimension:

PerCropCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
         = PerCropCommodImpact_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios);

PerAnimalCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
         = PerAnimalCommodImpact_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios);

PerAnimalCommodFeedInput_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
         = PerAnimalCommodFeedInput_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,ProductionSystems,ProductionConditions,Scenarios);

*similar for the per prim prod impacts:
ActCropsGrass_PerPrimProdImpact_WithAllocChar_MR(Regions,Activities,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_PerPrimProdImpact_MR(Regions,Activities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_WithAllocChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock,AnimalTypeInHerd,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_WithAllocChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,Commodities,"DM (t)","%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock,AnimalTypeInHerd,Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios);


*$ontext;
*and reset for the next run by equalling to zero, as this causes problems otherwise, as there are some $-conditions conditional on the presence of this parameter,
*        but it should be present from within one run calculatiosn, not from another run with different allocation!
ActCropsGrass_PerPrimProdImpact_MR(Regions,Activities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) = 0;
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock,AnimalTypeInHerd,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) = 0;
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock,AnimalTypeInHerd,Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios) = 0;

PerCropCommodImpact_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) = 0;
PerAnimalCommodImpact_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) = 0;
PerAnimalCommodFeedInput_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,ProductionSystems,ProductionConditions,Scenarios) = 0;
*$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Derive per unit calorie and protein impacts
*the per commodity impacts are reported in relation to 1 ton commodity
*here, we now derive values per ton protein, per 1000 kcal and per 1000 $



Parameter PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios) Impacts per crop commodity - with allocation characteristics dimension - per unit mass calorie or protein;
Parameter PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios) Impacts per animal commodity - with allocation characteristics dimension - per unit mass calorie or protein;
Parameter PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios) Feed commodity dry matter (t DM) per animal commodity - with allocation characteristics dimension - per unit mass calorie or protein;



PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,"%Allocation%","Reference unit: ton fresh matter",ProductionSystems,ProductionConditions,Scenarios)
         = PerCropCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios);
PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,"%Allocation%","Reference unit: ton fresh matter",ProductionSystems,ProductionConditions,Scenarios)
         = PerAnimalCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios);
PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,"%Allocation%","Reference unit: ton fresh matter",ProductionSystems,ProductionConditions,Scenarios)
         = PerAnimalCommodFeedInput_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios);

*calculate the inverse of the commodity contents and characteristics used to make the code faster:
Inverse_Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)
         = 1/Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios);
Inverse_Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)
         = 1/Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios);

PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,"%Allocation%","Reference unit: 1000 kcal",ProductionSystems,ProductionConditions,Scenarios)
         = PerCropCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
                 *Inverse_Commod_Contents_MR(Regions,Commodities,"Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)*1000;
PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,"%Allocation%","Reference unit: 1000 kcal",ProductionSystems,ProductionConditions,Scenarios)
         = PerAnimalCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
                 *Inverse_Commod_Contents_MR(Regions,Commodities,"Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)*1000;
PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,"%Allocation%","Reference unit: 1000 kcal",ProductionSystems,ProductionConditions,Scenarios)
         = PerAnimalCommodFeedInput_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
                 *Inverse_Commod_Contents_MR(Regions,Commodities,"Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)*1000;

PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,"%Allocation%","Reference unit: ton protein",ProductionSystems,ProductionConditions,Scenarios)
         = PerCropCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
                 *Inverse_Commod_Contents_MR(Regions,Commodities,"Protein (t)",ProductionSystems,ProductionConditions,Scenarios);
PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,"%Allocation%","Reference unit: ton protein",ProductionSystems,ProductionConditions,Scenarios)
         = PerAnimalCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
                 *Inverse_Commod_Contents_MR(Regions,Commodities,"Protein (t)",ProductionSystems,ProductionConditions,Scenarios);
PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,"%Allocation%","Reference unit: ton protein",ProductionSystems,ProductionConditions,Scenarios)
         = PerAnimalCommodFeedInput_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
                 *Inverse_Commod_Contents_MR(Regions,Commodities,"Protein (t)",ProductionSystems,ProductionConditions,Scenarios);

PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,"%Allocation%","Reference unit: 1000 $",ProductionSystems,ProductionConditions,Scenarios)
         = PerCropCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
                 *Inverse_Commod_OtherChar_MR(Regions,Commodities,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)*1000;
PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,"%Allocation%","Reference unit: 1000 $",ProductionSystems,ProductionConditions,Scenarios)
         = PerAnimalCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
                 *Inverse_Commod_OtherChar_MR(Regions,Commodities,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)*1000;
PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,"%Allocation%","Reference unit: 1000 $",ProductionSystems,ProductionConditions,Scenarios)
         = PerAnimalCommodFeedInput_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,"%Allocation%",ProductionSystems,ProductionConditions,Scenarios)
                 *Inverse_Commod_OtherChar_MR(Regions,Commodities,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)*1000;


*finally, we allocate the weighted cattle meat impact, based on the beef and dairy-herd values:
*weighs, cf. DerivePerApuValues, line 174
Inverse_VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","Meat producing",ProductionSystems,ProductionConditions,Scenarios)
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","Meat producing",ProductionSystems,ProductionConditions,Scenarios)
         = 1/VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","Meat producing",ProductionSystems,ProductionConditions,Scenarios);

PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,"Cattle","Meat (t) (weighted dairy/beef herd)",Commodities,PerCommodImpact,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios)
         = (PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,"Cattle","Meat (t)",Commodities,PerCommodImpact,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios)
                 *(VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","BMaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
                          + VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","BFemaleCalves1",ProductionSystems,ProductionConditions,Scenarios))
           +PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,"Cattle","Meat (t) (from dairy herd)",Commodities,PerCommodImpact,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios)
                 *(VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","DMaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
                          + VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","DFemaleCalves1",ProductionSystems,ProductionConditions,Scenarios)))
                 *ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Meat producing","Scale factor meat producing cattle",ProductionSystems,ProductionConditions,Scenarios)
         *Inverse_VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","Meat producing",ProductionSystems,ProductionConditions,Scenarios);

PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR(Regions,"Cattle","Meat (t) (weighted dairy/beef herd)",Commodities,Commodities_2,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios)
         = (PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR(Regions,"Cattle","Meat (t)",Commodities,Commodities_2,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios)
                 *(VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","BMaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
                          + VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","BFemaleCalves1",ProductionSystems,ProductionConditions,Scenarios))
           +PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR(Regions,"Cattle","Meat (t) (from dairy herd)",Commodities,Commodities_2,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios)
                 *(VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","DMaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
                          + VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","DFemaleCalves1",ProductionSystems,ProductionConditions,Scenarios)))
                 *ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Meat producing","Scale factor meat producing cattle",ProductionSystems,ProductionConditions,Scenarios)
         *Inverse_VActAnimalsHead_QuantityActUnits_MR.l(Regions,"Cattle","Meat producing",ProductionSystems,ProductionConditions,Scenarios);




$ontext;
*for a specific data requirement for the UBA-project in February 2021, define some reduced size parameters:
Parameter PerCropCommodImpact_MassAlloc_PerMass_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,AllocationCharacteristics,UnitOfReference_PerCommodImpacts) Impacts per crop commodity - mass allocation - per unit mass - less dimensions;
Parameter PerAnimalCommodImpact_MassAlloc_PerMass_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,AllocationCharacteristics,UnitOfReference_PerCommodImpacts) Impacts per animal commodity - mass allocation - per unit mass - less dimensions;
Parameter PerAnimalCommodFeedInput_MassAlloc_PerMass_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,AllocationCharacteristics,UnitOfReference_PerCommodImpacts) Feed commodity dry matter (t DM) per animal commodity - mass allocation - per unit mass - less dimensions;


PerCropCommodImpact_MassAlloc_PerMass_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,"Mass","Reference unit: ton fresh matter")
         = PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,"Mass","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","BaselineDerived");

PerAnimalCommodImpact_MassAlloc_PerMass_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,"Mass","Reference unit: ton fresh matter")
         = PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,"Mass","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","BaselineDerived");

PerAnimalCommodFeedInput_MassAlloc_PerMass_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,"Mass","Reference unit: ton fresh matter")
         = PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,"Mass","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","BaselineDerived");
*this is also specifically stored in files in the OutputFiles_SteeringFile2.gms-File
$offtext;







$exit;



































TO BE DONE:
Build impacts of Aggregate activities - as needed to math the aggregate commodities in the model (e.g.: impact per "All cereals" needed to get the impact of "Beer" or such),
         so that impact per unit of beer is derived from the average impact per unit of cereals.

Above code: produces alloc for main prod only - thus also do it for coprod: for this, add the linkages whey.cheese to the set (besides cheese.whey)!!



*Set1
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_AggregateCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_AggregateCommodities_Crops(SubsetCommod_MatchWithAct_AggregateCommodities,Activities_MR,OutputsCropsGrass)
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_AggregateCommodities))
         = ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_AggregateCommodities);

PUTCLOSE con "   Per commod impact 2:" timeElapsed;


PUTCLOSE con "   Per commod impact 3:" timeElapsed;

*Set3
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_WellDefinedCoProducts,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_WellDefinedCoProducts_Crops(SubsetCommod_MatchWithAct_WellDefinedCoProducts,Activities_MR,OutputsCropsGrass)
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_WellDefinedCoProducts))
         = ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_WellDefinedCoProducts);


PUTCLOSE con "   Per commod impact 4:" timeElapsed;

*Set4
PerCropCommodImpact_MR(Regions_MR,Activities_MR,OutputsCropsGrass,SubsetCommod_MatchWithAct_ComplexCases,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_ComplexCases_Crops(SubsetCommod_MatchWithAct_ComplexCases,Activities_MR,OutputsCropsGrass)
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexCases))
         = ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexCases);


PUTCLOSE con "   Per commod impact 5:" timeElapsed;

*Set5
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities))
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities);
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities))
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Milk producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities);
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities))
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Egg producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities);

*add fat and offals from meat production:
$ontext;

TO BE DONE LATER - correctly (Fat as a co product from meat and hides as outputs from liveweight of animals, not from carcass weight which is meat as primary product.

PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Fat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Fat (t)")
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities))
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities);
PerAnimalCommodImpact_MR(Regions_MR,Activities_MR,"Offals (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Offals (t)")
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities))
         = ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities);
*hides, skins to be added later.
$offtext;

PUTCLOSE con "   Per commod impact 6.1:" timeElapsed;


PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Meat (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Meat (t)")
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities))
         = FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Meat producing",Commodities_2,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities);

PUTCLOSE con "   Per commod impact 6.2:" timeElapsed;

PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Milk (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Milk (t)")
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities))
         = FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Milk producing",Commodities_2,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities);

PUTCLOSE con "   Per commod impact 6.3:" timeElapsed;

PerAnimalCommodFeedInput_MR(Regions_MR,Activities_MR,"Eggs (t)",SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Commodities_2,ProductionSystems,ProductionConditions,Scenarios)
                 $(MatchCommAct_ComplexAnimalCommodities(SubsetCommod_MatchWithAct_ComplexAnimalCommodities,Activities_MR,"Eggs (t)")
                         AND ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities))
         = FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Activities_MR,"Egg producing",Commodities_2,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /ExtractionRate_CommodityTree(Regions_MR,SubsetCommod_MatchWithAct_ComplexAnimalCommodities);



PUTCLOSE con "   Per commod impact 7:" timeElapsed;






$exit;


*allocation
$ontext;
the definition of how total resulting environmental impacts per production unit
(e.g. per kg wheat, per animal) are allocated to the commodities (e.g. wheat
flour, meat, milk).

this allocation can be done based on different allocation keys, such as
- prices (economic allocation)
- mass (physical allocation)
- protein (nutritional allocation (?))
- 1:0 main:by-product (full allocation)

to choose the allocation key, the parameter AllocationFactor has to be adjusted by choosing the relevant element from the set AllocationKey
$offtext;

Set AllocationKey
/
Mass
Prices
Protein
"All on the Main Product"
/;

Parameter AllocationWeight(Regions,Commodities,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)       Weight factor to be used for allocation;
Parameter AllocationWeightSummed(Regions,Commodities,AllocationKey,ProductionSystems,ProductionConditions,Scenarios) Sum of weight factors over all co-products that belong to one parent product;
Parameter AllocationFactor(Regions,Commodities,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)       Relative factor to be used for accolcation (i.e. share of weight in sum of weights);

AllocationWeight(Regions_MR,Commodities_MR,"Mass",ProductionSystems,ProductionConditions,Scenarios)
                 $VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         = ExtractionRate_CommodityTree(Regions_MR,Commodities_MR);

AllocationWeight(Regions_MR,Commodities_MR,"Prices",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios);

AllocationWeight(Regions_MR,Commodities_MR,"Protein",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents_MR(Regions_MR,Commodities_MR,"Protein (t)",ProductionSystems,ProductionConditions,Scenarios);

AllocationWeight(Regions_MR,Commodities_MR,"All on the Main Product",ProductionSystems,ProductionConditions,Scenarios)
                 $VCommod_Quantity_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         = 1;
AllocationWeight(Regions_MR,SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Co,"All on the Main Product",ProductionSystems,ProductionConditions,Scenarios)
         = 0;
AllocationWeight(Regions_MR,SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level2_Co,"All on the Main Product",ProductionSystems,ProductionConditions,Scenarios)
         = 0;

AllocationWeightSummed(Regions,Commodities,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)
         = sum(Commodities_2$MatchMainWithCoProd_WellDefinedCoProducts_Level1(Commodities,Commodities_2),
                         (AllocationWeight(Regions,Commodities_2,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)
                                 + AllocationWeight(Regions,Commodities,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)));

PUTCLOSE con "   Per commod impact 2.2:" timeElapsed;

*XXXXXXXXXXXXXX
*THE FOLLOWING TAKES LONG!!   230 seconds!!

AllocationWeightSummed(Regions,Commodities_2,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT AllocationWeightSummed(Regions,Commodities_2,AllocationKey,ProductionSystems,ProductionConditions,Scenarios))
         = sum(SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Main$MatchMainWithCoProd_WellDefinedCoProducts_Level1(SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Main,Commodities_2),
                         (AllocationWeight(Regions,SubsetCommod_MatchWithAct_WellDefinedCoProducts_Level1_Main,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)
                                 + AllocationWeight(Regions,Commodities_2,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)));

PUTCLOSE con "   Per commod impact 2.3:" timeElapsed;

AllocationFactor(Regions,Commodities,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)
                 $AllocationWeightSummed(Regions,Commodities,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)
         = AllocationWeight(Regions,Commodities,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)
                 /AllocationWeightSummed(Regions,Commodities,AllocationKey,ProductionSystems,ProductionConditions,Scenarios);

AllocationFactor(Regions,Commodities_2,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)
                 $(AllocationWeightSummed(Regions,Commodities_2,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)
                         AND (NOT AllocationFactor(Regions,Commodities_2,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)))
         = AllocationWeight(Regions,Commodities_2,AllocationKey,ProductionSystems,ProductionConditions,Scenarios)
                 /AllocationWeightSummed(Regions,Commodities_2,AllocationKey,ProductionSystems,ProductionConditions,Scenarios);










$exit;




                                                   Main         Co : sum over those
MatchMainWithCoProd_WellDefinedCoProducts_Level1(Commodities,Commodities_2)

Parent activity: MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)








NOT NEEDED ANYMORE, is it?


ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Milk producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Egg producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)


use the following sets, etc.
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

















