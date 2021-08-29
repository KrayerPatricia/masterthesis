PUTCLOSE con,"_V6_DeriveActivityGroupAggregations";

*GENERAL DESCRIPTION
*This file contains all the core model equations for calculating activity group aggregations - e.g. from aingle crops to crop groups, etc. .


*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Aggregation of single activity values to activitiy group totals

$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************

*the more encompassing code further below takes ages, thus drop and do only what you really need:
******** kray: added changes here 11.08.2021

VCommod_Food_Contents_MR.l(Regions,"All Commodities",Contents,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCommod_Food_Contents_MR.l(Regions,"All Commodities",Contents,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Commodities_SingleCommodities,
                 VCommod_Contents_MR.l(Regions,Commodities_SingleCommodities,Contents,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_OtherChar_MR(Regions,Commodities_SingleCommodities,"Util food (share)",ProductionSystems,ProductionConditions,Scenarios));
**************** end

$ontext
Set CropBasedCommodities_MR(Commodities);
CropBasedCommodities_MR(Commodities) =
         SET_Cereals_CommodityGroup(Commodities)
         + SET_FodderCrops_CommodityGroup(Commodities)
         + SET_Fruits_CommodityGroup(Commodities)
         + SET_Nuts_CommodityGroup(Commodities)
         + SET_Oilcrops_CommodityGroup(Commodities)
         + SET_OtherCrops_CommodityGroup(Commodities)
         + SET_Pulses_CommodityGroup(Commodities)
         + SET_RootsAndTubers_CommodityGroup(Commodities)
         + SET_Sugarcrops_CommodityGroup(Commodities)
         + SET_Vegetables_CommodityGroup(Commodities);
Set AnimalBasedCommodities_MR(Commodities);
AnimalBasedCommodities_MR(Commodities) =
         SET_Meat_CommodityGroup(Commodities)
         + SET_Milk_CommodityGroup(Commodities)
         + SET_Eggs_CommodityGroup(Commodities)
         + SET_FishSeafood_CommodityGroup(Commodities);
$offtext

Set CropBasedCommodities_MR(Commodities)
/
*$ontext;
"Agave fibres nes"
"Almonds, with shell"
"Anise, badian, fennel, coriander"
"Apples"
"Apricots"
"Areca nuts"
"Artichokes"
"Asparagus"
"Avocados"
"Bambara beans"
"Bananas"
"Barley"
"Bastfibres, other"
"Beans, dry"
"Beans, green"
"Berries nes"
"Blueberries"
"Brazil nuts, with shell"
"Broad beans, horse beans, dry"
"Buckwheat"
"Cabbages and other brassicas"
"Canary seed"
"Carobs"
"Carrots and turnips"
"Cashew nuts, with shell"
"Cassava"
"Castor oil seed"
"Cauliflowers and broccoli"
"Cereals (Rice Milled Eqv)"
"Cereals, nes"
"Cherries"
"Cherries, sour"
"Chestnut"
"Chick peas"
"Chicory roots"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cinnamon (canella)"
"Cloves"
"Cocoa, beans"
"Coconuts"
"Coffee, green"
"Cotton lint"
"Cottonseed"
"Cow peas, dry"
"Cranberries"
"Cucumbers and gherkins"
"Currants"
"Dates"
"Eggplants (aubergines)"
"Fibre crops nes"
"Figs"
"Flax fibre and tow"
"Fonio"
"Fruit, citrus nes"
"Fruit, fresh nes"
"Fruit, pome nes"
"Fruit, stone nes"
"Fruit, tropical fresh nes"
"Garlic"
"Ginger"
"Gooseberries"
"Grain, mixed"
"Grapefruit (inc. pomelos)"
"Grapes"
"Groundnuts, with shell"
"Hazelnuts, with shell"
"Hempseed"
"Hops"
"Jojoba seed"
"Jute"
"Kapok fruit"
"Karite nuts (sheanuts)"
"Kiwi fruit"
"Kola nuts"
"Leeks, other alliaceous vegetables"
"Lemons and limes"
"Lentils"
"Lettuce and chicory"
"Linseed"
"Lupins"
"Maize"
"Maize, green"
"Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"
*"Mat�"
"Melons, other (inc.cantaloupes)"
"Melonseed"
"Millet"
"Mushrooms and truffles"
"Mustard seed"
"Nutmeg, mace and cardamoms"
"Nuts, nes"
"Oats"
"Oil, palm fruit"
"Oilseeds nes"
"Okra"
"Olives"
"Onions, dry"
"Onions, shallots, green"
"Oranges"
"Palm kernels"
"Papayas"
"Peaches and nectarines"
"Pears"
"Peas, dry"
"Peas, green"
"Pepper (piper spp.)"
"Peppermint"
"Persimmons"
"Pigeon peas"
"Pineapples"
"Pistachios"
"Plantains and others"
"Plums and sloes"
"Poppy seed"
"Potatoes"
"Pulses, nes"
"Pumpkins, squash and gourds"
"Pyrethrum, dried"
"Quinces"
"Quinoa"
"Ramie"
"Rapeseed"
"Raspberries"
"Rice, paddy"
"Roots and tubers, nes"
"Rubber, natural"
"Rye"
"Safflower seed"
"Seed cotton"
"Sesame seed"
"Sisal"
"Sorghum"
"Soybeans"
"Spices, nes"
"Spinach"
"Strawberries"
"String beans"
"Sugar beet"
"Sugar cane"
"Sugar crops, nes"
"Sunflower seed"
"Sweet potatoes"
"Tallowtree seed"
"Tangerines, mandarins, clementines, satsumas"
"Taro (cocoyam)"
"Tea"
"Tobacco, unmanufactured"
"Tomatoes"
"Triticale"
"Tung nuts"
"Vanilla"
"Vegetables, fresh nes"
"Vegetables, leguminous nes"
"Vetches"
"Walnuts, with shell"
"Watermelons"
"Wheat"
"Yams"
"Yautia (cocoyam)"
"Turnips for fodder"
"Fruits - Excluding Wine"
"Nuts and products"
"Oilcrops Oil, Other"
$ontext;
Cephalopods
Crustaceans
Demersal Fish
Freshwater Fish
Pelagic Fish
$offtext;
"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Beets For Fodder"
"Swedes For Fodder"
"Grass"
"Temporary meadows and pastures"
"Permanent meadows and pastures"
"Cabbage, for forage"
"Other grasses, for forage"
"Rye grass, for forage"
"Sorghum, for forage"
"Miscanthus"
"Molasses"
"Wine"
$ontext;
Eggs, hen, in shell
Eggs, other bird, in shell
Hides, buffalo, fresh
Meat, ass
Meat, cattle
Meat, chicken
Meat, duck
Meat, goat
Meat, goose and guinea fowl
Meat, horse
Meat, other camelids
Meat, pig
Meat, rabbit
Meat, sheep
Meat, turkey
Milk, whole fresh buffalo
Milk, whole fresh cow
Milk, whole fresh goat
Milk, whole fresh sheep
Wool, greasy
$offtext;
"Infant food"
"Plantains"
"Sugar non-centrifugal"
*Animal fats
"Beer"
*Bovine Meat
"Onions"
*Pigmeat
*Poultry Meat
*$offtext;
"Pulses"
"Alcoholic Beverages"
"Apples and products"
"Barley and products"
"Beans"
"Beverages, Alcoholic"
"Beverages, Fermented"
"Brans"
"Cassava and products"
"Cereals - Excluding Beer"
"Cereals, Other"
"Citrus, Other"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Coffee and products"
"Copra Cake"
"Cottonseed Cake"
"Cottonseed Oil"
"Fruits, Other"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Groundnut Cake"
"Groundnut Oil"
"Groundnuts (in Shell Eq)"
"Groundnuts (Shelled Eq)"
"Lemons, Limes and products"
"Maize and products"
"Maize Germ Oil"
"Millet and products"
"Oilcrops"
"Oilcrops, Other"
"Oilseed Cakes, Other"
"Olive Oil"
"Olives (including preserved)"
"Oranges, Mandarines"
"Palm Oil"
"Palmkernel Cake"
"Palmkernel Oil"
"Peas"
"Pepper"
"Pimento"
"Pineapples and products"
"Potatoes and products"
"Pulses, Other and products"
"Rape and Mustard Cake"
"Rape and Mustard Oil"
"Rape and Mustardseed"
"Rice (Milled Equivalent)"
"Rice (Paddy Equivalent)"
"Ricebran Oil"
"Roots & Tuber Dry Equiv"
"Roots, Other"
"Rye and products"
"Sesameseed Cake"
"Sesameseed Oil"
"Sorghum and products"
"Soyabean Cake"
"Soyabeans"
"Spices"
"Spices, Other"
"Starchy Roots"
"Stimulants"
"Sugar & Sweeteners"
"Sugar (Raw Equivalent)"
"Sugar Crops"
"Sugar, Raw Equivalent"
"Sugar, Refined Equiv"
"Sunflowerseed Cake"
"Sunflowerseed Oil"
"Sweeteners, Other"
"Tea (including mate)"
"Tomatoes and products"
"Treenuts"
"Vegetable Oils"
"Vegetables"
"Vegetables, Other"
"Wheat and products"
$ontext;
Butter, Ghee
Cheese
Cream
Eggs
Fats, Animals, Raw
Fish Meal
Fish, Body Oil
Fish, Liver Oil
Fish, Seafood
Honey
Marine Fish, Other
Meat Meal
Meat, Other
Milk - Excluding Butter
Milk, Skimmed
Milk, Whole
Molluscs, Other
Mutton & Goat Meat
Offals
Offals, Edible
Whey
Meat, Camels
Meat, Mules
Meat, buffaloes
$offtext;
*All commod. - prim. prod. from crop act.
/;



Set PermCropBasedCommodities_MR(Commodities)
/
*$ontext;
"Agave fibres nes"
"Almonds, with shell"
*"Anise, badian, fennel, coriander"
"Apples"
"Apricots"
"Areca nuts"
*"Artichokes"
*"Asparagus"
"Avocados"
*"Bambara beans"
"Bananas"
*"Barley"
"Bastfibres, other"
*"Beans, dry"
*"Beans, green"
*"Berries nes"
*"Blueberries"
"Brazil nuts, with shell"
*"Broad beans, horse beans, dry"
*"Buckwheat"
*"Cabbages and other brassicas"
*"Canary seed"
"Carobs"
*"Carrots and turnips"
"Cashew nuts, with shell"
*"Cassava"
"Castor oil seed"
*"Cauliflowers and broccoli"
*"Cereals (Rice Milled Eqv)"
*"Cereals, nes"
"Cherries"
"Cherries, sour"
"Chestnut"
*"Chick peas"
*"Chicory roots"
*"Chillies and peppers, dry"
*"Chillies and peppers, green"
"Cinnamon (canella)"
"Cloves"
"Cocoa, beans"
"Coconuts"
"Coffee, green"
"Cotton lint"
"Cottonseed"
*"Cow peas, dry"
*"Cranberries"
*"Cucumbers and gherkins"
*"Currants"
"Dates"
*"Eggplants (aubergines)"
"Fibre crops nes"
"Figs"
"Flax fibre and tow"
*"Fonio"
"Fruit, citrus nes"
"Fruit, fresh nes"
"Fruit, pome nes"
"Fruit, stone nes"
"Fruit, tropical fresh nes"
*"Garlic"
*"Ginger"
*"Gooseberries"
*"Grain, mixed"
"Grapefruit (inc. pomelos)"
"Grapes"
"Groundnuts, with shell"
"Hazelnuts, with shell"
*"Hempseed"
"Hops"
"Jojoba seed"
"Jute"
"Kapok fruit"
"Karite nuts (sheanuts)"
"Kiwi fruit"
"Kola nuts"
*"Leeks, other alliaceous vegetables"
"Lemons and limes"
*"Lentils"
*"Lettuce and chicory"
*"Linseed"
*"Lupins"
*"Maize"
*"Maize, green"
"Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"
*"Mat�"
*"Melons, other (inc.cantaloupes)"
*"Melonseed"
*"Millet"
*"Mushrooms and truffles"
*"Mustard seed"
"Nutmeg, mace and cardamoms"
"Nuts, nes"
*"Oats"
"Oil, palm fruit"
*"Oilseeds nes"
*"Okra"
"Olives"
*"Onions, dry"
*"Onions, shallots, green"
"Oranges"
"Palm kernels"
"Papayas"
"Peaches and nectarines"
"Pears"
"Peas, dry"
*"Peas, green"
"Pepper (piper spp.)"
*"Peppermint"
"Persimmons"
*"Pigeon peas"
"Pineapples"
"Pistachios"
"Plantains and others"
"Plums and sloes"
*"Poppy seed"
*"Potatoes"
*"Pulses, nes"
*"Pumpkins, squash and gourds"
*"Pyrethrum, dried"
"Quinces"
*"Quinoa"
*"Ramie"
*"Rapeseed"
*"Raspberries"
*"Rice, paddy"
*"Roots and tubers, nes"
"Rubber, natural"
*"Rye"
*"Safflower seed"
"Seed cotton"
*"Sesame seed"
"Sisal"
*"Sorghum"
*"Soybeans"
*"Spices, nes"
*"Spinach"
*"Strawberries"
*"String beans"
*"Sugar beet"
*"Sugar cane"
*"Sugar crops, nes"
*"Sunflower seed"
*"Sweet potatoes"
"Tallowtree seed"
"Tangerines, mandarins, clementines, satsumas"
"Taro (cocoyam)"
*"Tea"
*"Tobacco, unmanufactured"
*"Tomatoes"
*"Triticale"
"Tung nuts"
"Vanilla"
*"Vegetables, fresh nes"
*"Vegetables, leguminous nes"
*"Vetches"
"Walnuts, with shell"
*"Watermelons"
*"Wheat"
*"Yams"
"Yautia (cocoyam)"
*"Turnips for fodder"
"Fruits - Excluding Wine"
"Nuts and products"
"Oilcrops Oil, Other"
$ontext;
Cephalopods
Crustaceans
Demersal Fish
Freshwater Fish
Pelagic Fish
$offtext;
*"Maize For Forage+Silage"
*"Alfalfa For Forage+Silag"
*"Clover For Forage+Silage"
*"Leguminous Nes,For+Sil"
*"Beets For Fodder"
*"Swedes For Fodder"
*"Grass"
*"Temporary meadows and pastures"
*"Permanent meadows and pastures"
*"Cabbage, for forage"
*"Other grasses, for forage"
*"Rye grass, for forage"
*"Sorghum, for forage"
*"Miscanthus"
*"Molasses"
"Wine"
$ontext;
Eggs, hen, in shell
Eggs, other bird, in shell
Hides, buffalo, fresh
Meat, ass
Meat, cattle
Meat, chicken
Meat, duck
Meat, goat
Meat, goose and guinea fowl
Meat, horse
Meat, other camelids
Meat, pig
Meat, rabbit
Meat, sheep
Meat, turkey
Milk, whole fresh buffalo
Milk, whole fresh cow
Milk, whole fresh goat
Milk, whole fresh sheep
Wool, greasy
$offtext;
*"Infant food"
"Plantains"
*"Sugar non-centrifugal"
*Animal fats
*"Beer"
*Bovine Meat
*"Onions"
*Pigmeat
*Poultry Meat
*$offtext;
*"Pulses"
"Alcoholic Beverages"
"Apples and products"
*"Barley and products"
*"Beans"
*"Beverages, Alcoholic"
*"Beverages, Fermented"
*"Brans"
*"Cassava and products"
*"Cereals - Excluding Beer"
*"Cereals, Other"
*"Citrus, Other"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Coffee and products"
"Copra Cake"
"Cottonseed Cake"
"Cottonseed Oil"
"Fruits, Other"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Groundnut Cake"
"Groundnut Oil"
"Groundnuts (in Shell Eq)"
"Groundnuts (Shelled Eq)"
"Lemons, Limes and products"
*"Maize and products"
*"Maize Germ Oil"
*"Millet and products"
*"Oilcrops"
*"Oilcrops, Other"
*"Oilseed Cakes, Other"
"Olive Oil"
"Olives (including preserved)"
"Oranges, Mandarines"
"Palm Oil"
"Palmkernel Cake"
"Palmkernel Oil"
*"Peas"
"Pepper"
"Pimento"
"Pineapples and products"
*"Potatoes and products"
*"Pulses, Other and products"
*"Rape and Mustard Cake"
*"Rape and Mustard Oil"
*"Rape and Mustardseed"
*"Rice (Milled Equivalent)"
*"Rice (Paddy Equivalent)"
*"Ricebran Oil"
*"Roots & Tuber Dry Equiv"
*"Roots, Other"
*"Rye and products"
*"Sesameseed Cake"
*"Sesameseed Oil"
*"Sorghum and products"
*"Soyabean Cake"
*"Soyabeans"
"Spices"
"Spices, Other"
*"Starchy Roots"
*"Stimulants"
*"Sugar & Sweeteners"
*"Sugar (Raw Equivalent)"
*"Sugar Crops"
*"Sugar, Raw Equivalent"
*"Sugar, Refined Equiv"
*"Sunflowerseed Cake"
*"Sunflowerseed Oil"
*"Sweeteners, Other"
"Tea (including mate)"
*"Tomatoes and products"
"Treenuts"
*"Vegetable Oils"
*"Vegetables"
*"Vegetables, Other"
*"Wheat and products"
$ontext;
Butter, Ghee
Cheese
Cream
Eggs
Fats, Animals, Raw
Fish Meal
Fish, Body Oil
Fish, Liver Oil
Fish, Seafood
Honey
Marine Fish, Other
Meat Meal
Meat, Other
Milk - Excluding Butter
Milk, Skimmed
Milk, Whole
Molluscs, Other
Mutton & Goat Meat
Offals
Offals, Edible
Whey
Meat, Camels
Meat, Mules
Meat, buffaloes
$offtext;
*All commod. - prim. prod. from crop act.
/;


Set AnimalBasedCommodities_MR(Commodities)
/
$ontext
Agave fibres nes
Almonds, with shell
Anise, badian, fennel, coriander
Apples
Apricots
Areca nuts
Artichokes
Asparagus
Avocados
Bambara beans
Bananas
Barley
Bastfibres, other
Beans, dry
Beans, green
Berries nes
Blueberries
Brazil nuts, with shell
Broad beans, horse beans, dry
Buckwheat
Cabbages and other brassicas
Canary seed
Carobs
Carrots and turnips
Cashew nuts, with shell
Cassava
Castor oil seed
Cauliflowers and broccoli
Cereals (Rice Milled Eqv)
Cereals, nes
Cherries
Cherries, sour
Chestnut
Chick peas
Chicory roots
Chillies and peppers, dry
Chillies and peppers, green
Cinnamon (canella)
Cloves
Cocoa, beans
Coconuts
Coffee, green
Cotton lint
Cottonseed
Cow peas, dry
Cranberries
Cucumbers and gherkins
Currants
Dates
Eggplants (aubergines)
Fibre crops nes
Figs
Flax fibre and tow
Fonio
Fruit, citrus nes
Fruit, fresh nes
Fruit, pome nes
Fruit, stone nes
Fruit, tropical fresh nes
Garlic
Ginger
Gooseberries
Grain, mixed
Grapefruit (inc. pomelos)
Grapes
Groundnuts, with shell
Hazelnuts, with shell
Hempseed
Hops
Jojoba seed
Jute
Kapok fruit
Karite nuts (sheanuts)
Kiwi fruit
Kola nuts
Leeks, other alliaceous vegetables
Lemons and limes
Lentils
Lettuce and chicory
Linseed
Lupins
Maize
Maize, green
Mangoes, mangosteens, guavas
Manila fibre (abaca)
Mat�
Melons, other (inc.cantaloupes)
Melonseed
Millet
Mushrooms and truffles
Mustard seed
Nutmeg, mace and cardamoms
Nuts, nes
Oats
Oil, palm fruit
Oilseeds nes
Okra
Olives
Onions, dry
Onions, shallots, green
Oranges
Palm kernels
Papayas
Peaches and nectarines
Pears
Peas, dry
Peas, green
Pepper (piper spp.)
Peppermint
Persimmons
Pigeon peas
Pineapples
Pistachios
Plantains and others
Plums and sloes
Poppy seed
Potatoes
Pulses, nes
Pumpkins, squash and gourds
Pyrethrum, dried
Quinces
Quinoa
Ramie
Rapeseed
Raspberries
Rice, paddy
Roots and tubers, nes
Rubber, natural
Rye
Safflower seed
Seed cotton
Sesame seed
Sisal
Sorghum
Soybeans
Spices, nes
Spinach
Strawberries
String beans
Sugar beet
Sugar cane
Sugar crops, nes
Sunflower seed
Sweet potatoes
Tallowtree seed
Tangerines, mandarins, clementines, satsumas
Taro (cocoyam)
Tea
Tobacco, unmanufactured
Tomatoes
Triticale
Tung nuts
Vanilla
Vegetables, fresh nes
Vegetables, leguminous nes
Vetches
Walnuts, with shell
Watermelons
Wheat
Yams
Yautia (cocoyam)
Turnips for fodder
Fruits - Excluding Wine
Nuts and products
Oilcrops Oil, Other
$offtext;
"Cephalopods"
"Crustaceans"
"Demersal Fish"
"Freshwater Fish"
"Pelagic Fish"
$ontext;
Maize For Forage+Silage
Alfalfa For Forage+Silag
Clover For Forage+Silage
Leguminous Nes,For+Sil
Beets For Fodder
Swedes For Fodder
Grass
Temporary meadows and pastures
Permanent meadows and pastures
Cabbage, for forage
Other grasses, for forage
Rye grass, for forage
Sorghum, for forage
Miscanthus
Molasses
Wine
$offtext;
"Eggs, hen, in shell"
"Eggs, other bird, in shell"
"Hides, buffalo, fresh"
"Meat, ass"
"Meat, cattle"
"Meat, chicken"
"Meat, duck"
"Meat, goat"
"Meat, goose and guinea fowl"
"Meat, horse"
"Meat, other camelids"
"Meat, pig"
"Meat, rabbit"
"Meat, sheep"
"Meat, turkey"
"Milk, whole fresh buffalo"
"Milk, whole fresh cow"
"Milk, whole fresh goat"
"Milk, whole fresh sheep"
"Wool, greasy"
*Infant food
*Plantains
*Sugar non-centrifugal
"Animal fats"
*Beer
"Bovine Meat"
*Onions
"Pigmeat"
"Poultry Meat"
$ontext;
Pulses
Alcoholic Beverages
Apples and products
Barley and products
Beans
Beverages, Alcoholic
Beverages, Fermented
Brans
Cassava and products
Cereals - Excluding Beer
Cereals, Other
Citrus, Other
Cocoa Beans and products
Coconut Oil
Coconuts - Incl Copra
Coffee and products
Copra Cake
Cottonseed Cake
Cottonseed Oil
Fruits, Other
Grapefruit and products
Grapes and products (excl wine)
Groundnut Cake
Groundnut Oil
Groundnuts (in Shell Eq)
Groundnuts (Shelled Eq)
Lemons, Limes and products
Maize and products
Maize Germ Oil
Millet and products
Oilcrops
Oilcrops, Other
Oilseed Cakes, Other
Olive Oil
Olives (including preserved)
Oranges, Mandarines
Palm Oil
Palmkernel Cake
Palmkernel Oil
Peas
Pepper
Pimento
Pineapples and products
Potatoes and products
Pulses, Other and products
Rape and Mustard Cake
Rape and Mustard Oil
Rape and Mustardseed
Rice (Milled Equivalent)
Rice (Paddy Equivalent)
Ricebran Oil
Roots & Tuber Dry Equiv
Roots, Other
Rye and products
Sesameseed Cake
Sesameseed Oil
Sorghum and products
Soyabean Cake
Soyabeans
Spices
Spices, Other
Starchy Roots
Stimulants
Sugar & Sweeteners
Sugar (Raw Equivalent)
Sugar Crops
Sugar, Raw Equivalent
Sugar, Refined Equiv
Sunflowerseed Cake
Sunflowerseed Oil
Sweeteners, Other
Tea (including mate)
Tomatoes and products
Treenuts
Vegetable Oils
Vegetables
Vegetables, Other
Wheat and products
$offtext;
"Butter, Ghee"
"Cheese"
"Cream"
"Eggs"
"Fats, Animals, Raw"
"Fish Meal"
"Fish, Body Oil"
"Fish, Liver Oil"
"Fish, Seafood"
"Honey"
"Marine Fish, Other"
"Meat Meal"
"Meat, Other"
"Milk - Excluding Butter"
"Milk, Skimmed"
"Milk, Whole"
"Molluscs, Other"
"Mutton & Goat Meat"
"Offals"
"Offals, Edible"
"Whey"
"Meat, Camels"
"Meat, Mules"
"Meat, buffaloes"
*All commod. - prim. prod. from crop act.
/;




*PerFreshMatterFood - cal, prot, fat only
VCommod_Food_Contents_MR.l(Regions,"All crop based Commodities",ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
         =sum(CropBasedCommodities_MR,
                 VCommod_Contents_MR.l(Regions,CropBasedCommodities_MR,ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_OtherChar_MR(Regions,CropBasedCommodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,Scenarios));
VCommod_Food_Contents_MR.l(Regions,"All animal based Commodities",ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
         =sum(AnimalBasedCommodities_MR,
                 VCommod_Contents_MR.l(Regions,AnimalBasedCommodities_MR,ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_OtherChar_MR(Regions,AnimalBasedCommodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,Scenarios));


*XXXXXXXXXXXX kray: added here 29.07.2021 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
* here calculate nutrient production per country (not DAQ)
VCommod_Food_Contents_Prod_MR.l(Regions,"All crop based Commodities",ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
         =sum(CropBasedCommodities_MR,
                 VCommod_Contents_Prod_MR.l(Regions,CropBasedCommodities_MR,ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_OtherChar_MR(Regions,CropBasedCommodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,Scenarios));
VCommod_Food_Contents_Prod_MR.l(Regions,"All animal based Commodities",ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
         =sum(AnimalBasedCommodities_MR,
                 VCommod_Contents_Prod_MR.l(Regions,AnimalBasedCommodities_MR,ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_OtherChar_MR(Regions,AnimalBasedCommodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,Scenarios));

VCommod_Food_Contents_Prod_MR.l(Regions,"All perm Crop Commodities",ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
         =sum(PermCropBasedCommodities_MR,
                 VCommod_Contents_Prod_MR.l(Regions,PermCropBasedCommodities_MR,ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_OtherChar_MR(Regions,PermCropBasedCommodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,Scenarios));


*include nutrient production (DAQ) of permanent crops
VCommod_Food_Contents_MR.l(Regions,"All perm Crop Commodities",ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
         =sum(PermCropBasedCommodities_MR,
                 VCommod_Contents_MR.l(Regions,PermCropBasedCommodities_MR,ContentsPerFreshMatterFood,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_OtherChar_MR(Regions,PermCropBasedCommodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,Scenarios));
     
                    
*test, delete later
execute_unload "testifallCropsContained" VCommod_Food_Contents_MR;

*XXXXXXXXXXXX kray: added here 29.07.2021 end XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX




*derive per capita kcal etc supply:
Commod_OtherChar_MR(Regions,"All Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,ProductionConditions,Scenarios)
                 $VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
         = VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                 /VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                         /365;
Commod_OtherChar_MR(Regions,"All Commodities","Protein per capita (g/cap/day)",ProductionSystems,ProductionConditions,Scenarios)
                 $VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
         = VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                         *1000000/365;
Commod_OtherChar_MR(Regions,"All crop based Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,ProductionConditions,Scenarios)
                 $VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
         = VCommod_Food_Contents_MR.l(Regions,"All crop based Commodities","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                 /VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                         /365;
Commod_OtherChar_MR(Regions,"All crop based Commodities","Protein per capita (g/cap/day)",ProductionSystems,ProductionConditions,Scenarios)
                 $VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
         = VCommod_Food_Contents_MR.l(Regions,"All crop based Commodities","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                         *1000000/365;
Commod_OtherChar_MR(Regions,"All animal based Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,ProductionConditions,Scenarios)
                 $VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
         = VCommod_Food_Contents_MR.l(Regions,"All animal based Commodities","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                 /VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                         /365;
Commod_OtherChar_MR(Regions,"All animal based Commodities","Protein per capita (g/cap/day)",ProductionSystems,ProductionConditions,Scenarios)
                 $VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
         = VCommod_Food_Contents_MR.l(Regions,"All animal based Commodities","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                         *1000000/365;

VActCropsGrass_QuantityActUnits_MR.l(Regions,"Crops without Agricultural Trees",ProductionSystems,ProductionConditions,Scenarios)
         =sum(CropPartActivities_Agroforestry_EUROPE_NoGrass,VActCropsGrass_QuantityActUnits_MR.l(Regions,CropPartActivities_Agroforestry_EUROPE_NoGrass,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Agricultural Trees",ProductionSystems,ProductionConditions,Scenarios)
         =sum(TreePartActivities_Agroforestry_EUROPE,VActCropsGrass_QuantityActUnits_MR.l(Regions,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_QuantityActUnits_MR.l(Regions,"Cropland: temporary (incl. temp. grassland) (ha)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(CropsUsedInRotations_NonV,VActCropsGrass_QuantityActUnits_MR.l(Regions,CropsUsedInRotations_NonV,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Cropland: temporary (without temp. grassland) (ha)",ProductionSystems,ProductionConditions,Scenarios)
         =VActCropsGrass_QuantityActUnits_MR.l(Regions,"Cropland: temporary (incl. temp. grassland) (ha)",ProductionSystems,ProductionConditions,Scenarios)
                 -VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,Scenarios);
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Cropland: permanent (ha)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(PermCrops_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,PermCrops_V,ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_QuantityActUnits_MR.l(Regions,"Grass",ProductionSystems,ProductionConditions,Scenarios)
         =sum(TempAndPermMeadAndPastures,VActCropsGrass_QuantityActUnits_MR.l(Regions,TempAndPermMeadAndPastures,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Crops",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops_MR,ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Legumes_Nfixing,VActCropsGrass_QuantityActUnits_MR.l(Regions,Legumes_Nfixing,ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Legumes (Nfixing) - incl. SetAside (no temp. grass)",ProductionSystems,ProductionConditions,Scenarios)
         =VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,Scenarios)
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions,"Clover For Forage+Silage",ProductionSystems,ProductionConditions,Scenarios)
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions,"Alfalfa For Forage+Silag",ProductionSystems,ProductionConditions,Scenarios)
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions,"Leguminous Nes,For+Sil",ProductionSystems,ProductionConditions,Scenarios)
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions,'Vetches',ProductionSystems,ProductionConditions,Scenarios);

VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops","Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VActCropsGrass_Otherchar_MR.l(Regions_MR,Crops,"Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(TempAndPermMeadAndPastures,VActCropsGrass_OtherChar_MR.l(Regions_MR,TempAndPermMeadAndPastures,"Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VActCropsGrass_Otherchar_MR.l(Regions_MR,Crops,"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(TempAndPermMeadAndPastures,VActCropsGrass_OtherChar_MR.l(Regions_MR,TempAndPermMeadAndPastures,"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));


VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","NH3 from animals, - manure management (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 VActAnimalsHead_OtherChar_MR.l(Regions,Livestock_MR,AnimalTypeInHerd_MR,"NH3 from animals, - manure management (tNH3)",ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","NH3 from animals, - grazing + housing (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 VActAnimalsHead_OtherChar_MR.l(Regions,Livestock_MR,AnimalTypeInHerd_MR,"NH3 from animals, - grazing + housing (tNH3)",ProductionSystems,ProductionConditions,Scenarios));


VActCropsGrass_OtherChar_MR.l(Regions,"All crops and grass","NH3 from areas (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(CropsAndCoreGrassActivities,VActCropsGrass_OtherChar_MR.l(Regions,CropsAndCoreGrassActivities,"NH3 from areas (tNH3)",ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","Manure Man GHG emissions - animals (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 VActAnimalsHead_OtherChar_MR.l(Regions,Livestock_MR,AnimalTypeInHerd_MR,"Manure Man GHG emissions - animals (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Enteric ferment (t CO2e)"    ,ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Enteric ferment (t CO2e)"    ,ProductionSystems,ProductionConditions,Scenarios));
*below: the sum of the above two:
VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Total GHG emissions - animals (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 VActAnimalsHead_OtherChar_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Total GHG emissions - animals (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

*needed for OECD N balance
VActAnimalsHead_Outputs_MR.l(Regions,"All Animals","AllAndAverageTypes","N in manure (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 VActAnimalsHead_Outputs_MR.l(Regions,Livestock_MR,AnimalTypeInHerd_MR,"N in manure (tN)",ProductionSystems,ProductionConditions,Scenarios));

*for the OECD-balance, there is a small part covering inputs from residues; this seems to be those residues that are returned to the field, i.e. NOT those LEFT ON THE FIELD, but only compost and biogas (currently) - thus do the sum without this.
VCropResidues_Management_MR.l(Regions,"All Crops","Average Residues (t)","Crop res N for areas (tN) - for OECD N-balance","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Crops_MR,CropResManSystemCropland_ForOECDNBalance),VCropResidues_Management_MR.l(Regions,Crops_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystemCropland_ForOECDNBalance,ProductionSystems,ProductionConditions,Scenarios))
*add the N from main output biomass
                 +sum((Activities_MR,CropResManSystem),
                         VCropResidues_Management_MR.l(Regions,Activities_MR,"Average Residues (t)","Main output N as fert. for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,Scenarios));

*Already available: VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech",ProductionSystems,Scenarios)
VActCropsGrass_Inputs_MR.l(Regions,"All crops","N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_Inputs_MR.l(Regions,Crops,"N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l(Regions,"Grass","N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(CoreGrassActivities,VActCropsGrass_Inputs_MR.l(Regions,CoreGrassActivities,"N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l(Regions,"All Crops","N inputs from seeds (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_Inputs_MR.l(Regions,Crops,"N inputs from seeds (tN)",ProductionSystems,ProductionConditions,Scenarios));

*set crop grass inputs for activity sum UNISECO agroforestry scenarios:
SET InputsCropsGrassUNISECO_AF_Aggregations(InputsCropsGrass)
/
"Irrigation water (m3)"
"Irrigation water (m3) - water stress adjusted"
"Labour use - total (h)"
"Total CED (MJ)"
"N fixation (tN)"
/;
VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass",InputsCropsGrassUNISECO_AF_Aggregations,ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops_MR,VActCropsGrass_Inputs_MR.l(Regions,Crops_MR,InputsCropsGrassUNISECO_AF_Aggregations,ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_Inputs_MR.l(Regions,CoreGrassActivities,InputsCropsGrassUNISECO_AF_Aggregations,ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Inputs_MR.l(Regions,"All crops","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops_MR,VActCropsGrass_Inputs_MR.l(Regions,Crops_MR,"N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l(Regions,"Grass","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(CoreGrassActivities,VActCropsGrass_Inputs_MR.l(Regions,CoreGrassActivities,"N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios));



VActCropsGrass_Inputs_MR.l("European Union plus CH","All crops","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion_PlusCH,VActCropsGrass_Inputs_MR.l(FAO_EuropeanUnion_PlusCH,"All crops","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Inputs_MR.l("European Union plus CH","Grass","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion_PlusCH,VActCropsGrass_Inputs_MR.l(FAO_EuropeanUnion_PlusCH,"Grass","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_QuantityActUnits_MR.l("European Union plus CH","All Legumes (Nfixing)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion_PlusCH,VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,Scenarios));

VMineralFertilizerQuantity_MR.l("European Union plus CH",MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios)
         =sum(FAO_EuropeanUnion_PlusCH,VMineralFertilizerQuantity_MR.l(FAO_EuropeanUnion_PlusCH,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios));




VActAnimalsHead_Inputs_MR.l(Regions,"All Animals","AllAndAverageTypes","Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 VActAnimalsHead_Inputs_MR.l(Regions,Livestock_MR,AnimalTypeInHerd_MR,"Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_Inputs_MR.l(Regions,"All Animals","AllAndAverageTypes","Total CED (MJ)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Livestock_MR,
                 VActAnimalsHead_Inputs_MR.l(Regions,Livestock_MR,"AllAndAverageTypes","Total CED (MJ)",ProductionSystems,ProductionConditions,Scenarios));


VActCropsGrass_OtherChar_MR.l(Regions,"All crops and grass","Soil water erosion (t soil lost)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(CropsAndCoreGrassActivities,VActCropsGrass_OtherChar_MR.l(Regions,CropsAndCoreGrassActivities,"Soil water erosion (t soil lost)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions,"All crops and grass","Aggreg. Pest. use level (index)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(CropsAndCoreGrassActivities,VActCropsGrass_OtherChar_MR.l(Regions,CropsAndCoreGrassActivities,"Aggreg. Pest. use level (index)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions,"All crops and grass","C sequestered in woody biomass (tC)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(CropsAndCoreGrassActivities,VActCropsGrass_OtherChar_MR.l(Regions,CropsAndCoreGrassActivities,"C sequestered in woody biomass (tC)",ProductionSystems,ProductionConditions,Scenarios));

*SEE BELOW
*VCommod_OtherChar_MR.l(Regions,"All crop based Commodities","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
*         =sum(CropBasedCommodities_MR,
*                 VCommod_OtherChar_MR.l(Regions,CropBasedCommodities_MR,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios));
*VCommod_OtherChar_MR.l(Regions,"All animal based Commodities","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
*         =sum(AnimalBasedCommodities_MR,
*                 VCommod_OtherChar_MR.l(Regions,AnimalBasedCommodities_MR,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios));
*SEE BELOW

VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 VActAnimalsHead_OtherChar_MR.l(Regions,Livestock_MR,AnimalTypeInHerd_MR,"Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","Animal welfare: heat stress index 2050",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 VActAnimalsHead_OtherChar_MR.l(Regions,Livestock_MR,AnimalTypeInHerd_MR,"Animal welfare: heat stress index 2050",ProductionSystems,ProductionConditions,Scenarios));

VCommod_Contents_MR.l(Regions,"All commod. - prim. prod. from crop act.","N (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Crops,OutputsCropsGrass,Commodities_MR)$Match_ActivityOutputsToCommodities_Crops(Crops,OutputsCropsGrass,Commodities_MR),
                 VActCropsGrass_Outputs_MR.l(Regions,Crops,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_Contents_MR(Regions,Commodities_MR,"N (t)",ProductionSystems,ProductionConditions,Scenarios));
VCommod_Contents_MR.l(Regions,"Grass","N (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((CoreGrassActivities,OutputsCropsGrass,Commodities_MR)$Match_ActivityOutputsToCommodities_Crops(CoreGrassActivities,OutputsCropsGrass,Commodities_MR),
                 VActCropsGrass_Outputs_MR.l(Regions,CoreGrassActivities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_Contents_MR(Regions,Commodities_MR,"N (t)",ProductionSystems,ProductionConditions,Scenarios));

$ontext;
ALREADY defined in initialise set for model runs
*for the producer prices, we need some further subsets for the commodities that correspond to primary products only:
Set SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops(Commodities)
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
*!!XXXXX    !!CAREFUL, if "Chillies and peppers, dry" is also available as commodity!! - how to deal with this??
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
"Mat�"
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
"Brazil Nuts"
"Broad Beans, Green"
"Carobs"
"Cassava Leaves"
"Castor Beans"
"Chicory Roots"
"Citrus Fruit Nes"
"Cow Peas, Dry"
"Fibre Crops Nes"
"Groundnuts In Shell"
"Kapok Fruit"
"Karite Nuts (Sheanuts)"
"Lupins"
"Mate"
"Melonseed"
"Natural Gums"
"Okra"
"Pigeon Peas"
"Pome Fruit Nes, Fresh"
"Pulses Nes"
"Quinoa"
"Ramie"
"Raspberries"
"Safflower Seed"
"Seed cotton"
"Stone Fruit Nes, Fresh"
"String Beans"
"Tallowtree Seeds"
"Taro (Coco Yam)"
"Tung Nuts"
"Yautia (Cocoyam)"
/;
$offtext;

Set SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Pigmeat"
"Poultry Meat"
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
"Buffalo Meat"
"Meat, Asses"
"Meat, Camels"
"Meat, Mules"
"Bovine meat"
"Mutton & Goat Meat"
"Meat Bovine Fresh"
/;

Set SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Milk, Whole"
"Buffalo Milk"
"Goat Milk"
"Milk - Excluding Butter"
"Milk Fresh"
"Milk, whole fresh cow"
"Milk, whole fresh sheep"
"Milk, whole fresh buffalo"
"Milk, whole fresh camel"
"Milk, whole fresh goat"
"Standardized Milk"
/;

Set SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Eggs, hen, in shell"
"Eggs"
"Eggs in The Shell"
"Eggs Excl Hen"
"Eggs, other bird, in shell"
/;

*for animals:
set MatchCommAct_CommodEquivalentAct_Animals_Short(Commodities,Activities,OutputsAnimals) "Set covering all animal commodities that are equivalent to main outputs from activities - short extract for final output calculations"
/
"Milk, Whole"."Cattle"."Milk (t)"
"Pigmeat"."Pigs"."Meat (t)"
"Poultry Meat"."Chickens"."Meat (t)"
"Eggs, hen, in shell"."Chickens"."Eggs (t)"
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
"Buffalo Meat"."Buffaloes"."Meat (t)"
"Buffalo Milk"."Buffaloes"."Milk (t)"
"Camel Milk"."Camels"."Milk (t)"
"Goat Milk"."Goats"."Milk (t)"
"Meat, Asses"."Asses"."Meat (t)"
"Meat, Camels"."Camels"."Meat (t)"
"Meat, Mules"."Mules"."Meat (t)"
"Eggs"."Chickens"."Eggs (t)"
"Eggs in The Shell"."Chickens"."Eggs (t)"
"Milk Fresh"."Cattle"."Milk (t)"
"Milk, whole fresh cow"."Cattle"."Milk (t)"
"Milk, whole fresh sheep"."Sheep"."Milk (t)"
/;


VCommod_OtherChar_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Crops$MatchCommAct_CommodEquivalentAct_Crops(SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,Crops,"MainOutput1 (t)"),
                 Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"Mainoutput1 (t)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_OtherChar_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_Short(SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,Livestock,"Meat (t)"),
                 Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Meat producing","Meat (t)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_OtherChar_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_Short(SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,Livestock,"Milk (t)"),
                 Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Milk producing","Milk (t)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_OtherChar_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_Short(SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,Livestock,"Eggs (t)"),
                 Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Egg producing","Eggs (t)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_OtherChar_MR.l(Regions_MR,"All crop based Commodities","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,
                         VCommod_OtherChar_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_OtherChar_MR.l(Regions_MR,"All animal based Commodities","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,
                         VCommod_OtherChar_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios))
                 + sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,
                         VCommod_OtherChar_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios))
                 + sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,
                         VCommod_OtherChar_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios));



*derive domestic cal/prot production and set in relation to cal/prot availability - to derive some measure of self-sufficiency:
*for calories

*we do this by calculating DOMESTIC PRODUCTION MINUS EXPORTS (conditional to being >0)

VCommod_Food_Contents_MR.l(Regions_MR,"All Commodities","Calories - domestic prod. (kcal)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Commodities_MR$(VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios) - VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios) > 0),
                 (VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios) - VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios))
                         *Commod_Contents_MR(Regions_MR,Commodities_MR,"Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                                 *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,Scenarios));
VCommod_Food_Contents_MR.l(Regions_MR,"All Commodities","Protein - domestic prod. (t)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Commodities_MR$(VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios) - VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios) > 0),
                 (VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios) - VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios))
                         *Commod_Contents_MR(Regions_MR,Commodities_MR,"Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                                 *Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,Scenarios));




$ontext;

BELOW: does not yet work as matching is not ok, such that many commodities are lost - to be checked in detail - but bacause of this, we have the simpler approach implemented abov via Commod Prod and util rate food

*derive domestic cal/prot production and set in relation to cal/prot availability - to derive some measure of self-sufficiency:
*for calories
VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Calories - domestic prod. (kcal)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Crops$MatchCommAct_CommodEquivalentAct_Crops(SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,Crops,"MainOutput1 (t)"),
                 Commod_Contents_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Calories (kcal)",ProductionSystems,"AllProdCond",Scenarios)
                         *Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Util food (share)",ProductionSystems,"AllProdCond",Scenarios)
                                 *VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"Mainoutput1 (t)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,"Calories - domestic prod. (kcal)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_Short(SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,Livestock,"Meat (t)"),
                 Commod_Contents_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,"Calories (kcal)",ProductionSystems,"AllProdCond",Scenarios)
                         *Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,"Util food (share)",ProductionSystems,"AllProdCond",Scenarios)
                                  *VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Meat producing","Meat (t)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,"Calories - domestic prod. (kcal)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_Short(SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,Livestock,"Milk (t)"),
                 Commod_Contents_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,"Calories (kcal)",ProductionSystems,"AllProdCond",Scenarios)
                         *Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,"Util food (share)",ProductionSystems,"AllProdCond",Scenarios)
                                  *VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Milk producing","Milk (t)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,"Calories - domestic prod. (kcal)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_Short(SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,Livestock,"Eggs (t)"),
                 Commod_Contents_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,"Calories (kcal)",ProductionSystems,"AllProdCond",Scenarios)
                         *Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,"Util food (share)",ProductionSystems,"AllProdCond",Scenarios)
                                  *VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Egg producing","Eggs (t)",ProductionSystems,"AllProdCond",Scenarios));


VCommod_Contents_MR.l(Regions_MR,"All crop based Commodities","Calories - domestic prod. (kcal)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,
                         VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Calories - domestic prod. (kcal)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_Contents_MR.l(Regions_MR,"All animal based Commodities","Calories - domestic prod. (kcal)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,
                         VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,"Calories - domestic prod. (kcal)",ProductionSystems,"AllProdCond",Scenarios))
                 + sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,
                         VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,"Calories - domestic prod. (kcal)",ProductionSystems,"AllProdCond",Scenarios))
                 + sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,
                         VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,"Calories - domestic prod. (kcal)",ProductionSystems,"AllProdCond",Scenarios));

*for protein
VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Proteins - domestic prod. (t)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Crops$MatchCommAct_CommodEquivalentAct_Crops(SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,Crops,"MainOutput1 (t)"),
                 Commod_Contents_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Protein (t)",ProductionSystems,"AllProdCond",Scenarios)
                         *Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Util food (share)",ProductionSystems,"AllProdCond",Scenarios)
                                 *VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"Mainoutput1 (t)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,"Proteins - domestic prod. (t)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_Short(SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,Livestock,"Meat (t)"),
                 Commod_Contents_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,"Protein (t)",ProductionSystems,"AllProdCond",Scenarios)
                         *Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,"Util food (share)",ProductionSystems,"AllProdCond",Scenarios)
                                  *VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Meat producing","Meat (t)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,"Proteins - domestic prod. (t)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_Short(SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,Livestock,"Milk (t)"),
                 Commod_Contents_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,"Protein (t)",ProductionSystems,"AllProdCond",Scenarios)
                         *Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,"Util food (share)",ProductionSystems,"AllProdCond",Scenarios)
                                  *VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Milk producing","Milk (t)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,"Proteins - domestic prod. (t)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_Short(SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,Livestock,"Eggs (t)"),
                 Commod_Contents_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,"Protein (t)",ProductionSystems,"AllProdCond",Scenarios)
                         *Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,"Util food (share)",ProductionSystems,"AllProdCond",Scenarios)
                                  *VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Egg producing","Eggs (t)",ProductionSystems,"AllProdCond",Scenarios));


VCommod_Contents_MR.l(Regions_MR,"All crop based Commodities","Proteins - domestic prod. (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,
                         VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Proteins - domestic prod. (t)",ProductionSystems,"AllProdCond",Scenarios));

VCommod_Contents_MR.l(Regions_MR,"All animal based Commodities","Proteins - domestic prod. (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,
                         VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat,"Proteins - domestic prod. (t)",ProductionSystems,"AllProdCond",Scenarios))
                 + sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,
                         VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk,"Proteins - domestic prod. (t)",ProductionSystems,"AllProdCond",Scenarios))
                 + sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,
                         VCommod_Contents_MR.l(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs,"Proteins - domestic prod. (t)",ProductionSystems,"AllProdCond",Scenarios));

o$fftext;












*OLD Code
$ontext;
Set SubsetCommod_MatchWithAct_CommodEquivalentAct_Animals(Commodities);
SubsetCommod_MatchWithAct_CommodEquivalentAct_Animals(Commodities) = SubsetCommod_MatchWithAct_CommodEquivalentAct_Meat(Commodities) + SubsetCommod_MatchWithAct_CommodEquivalentAct_Milk(Commodities) + SubsetCommod_MatchWithAct_CommodEquivalentAct_Eggs(Commodities);

*We derive the total value by multiplying VCommodProd by Commod_otherChar - producer price; the corresponding sheet in NutritiveFactors_CommoditySetCorrespondences.xlsx shows that the commodities covered in these largely match and that this should thus work.
VCommod_OtherChar_MR.l(Regions,"All crop based Commodities","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,
                         VCommod_Quantity_MR.l(Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,ProductionSystems,ProductionConditions,Scenarios)
                                 *Commod_OtherChar_MR(Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios));
VCommod_OtherChar_MR.l(Regions,"All animal based Commodities","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_Animals,
                         VCommod_Quantity_MR.l(Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_Animals,ProductionSystems,ProductionConditions,Scenarios)
                                 *Commod_OtherChar_MR(Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_Animals,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios));
$offtext;

*OLD CODE _ DROP
*VCommod_OtherChar_MR.l(Regions,"All crop based Commodities","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
*         =sum(CropBasedCommodities_MR,
*                 VCommod_OtherChar_MR.l(Regions,CropBasedCommodities_MR,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios));
*VCommod_OtherChar_MR.l(Regions,"All animal based Commodities","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
*         =sum(AnimalBasedCommodities_MR,
*                 VCommod_OtherChar_MR.l(Regions,AnimalBasedCommodities_MR,"Producer price ($)",ProductionSystems,ProductionConditions,Scenarios));






$exit;



*1) Aggregation of single activity values to activitiy group totals

*the aggregations implemented currently aim at corss-checking with the GHG inventory and OECD N-balance; thus not yet systematically covering everyhting of potential interest.


VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","Direct N2O from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"Direct N2O from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_Outputs_MR.l(Regions_MR,CoreGrassActivities,"Direct N2O from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","Direct N2O from CropRes/Biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"Direct N2O from CropRes/Biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_Outputs_MR.l(Regions_MR,CoreGrassActivities,"Direct N2O from CropRes/Biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","Direct N2O from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"Direct N2O from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_Outputs_MR.l(Regions_MR,CoreGrassActivities,"Direct N2O from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops and grass","CultOrgSoils N2O Emissions (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops,"CultOrgSoils N2O Emissions (tCO2e)",ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivities,"CultOrgSoils N2O Emissions (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops and grass","CultOrgSoils C Emissions (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops,"CultOrgSoils C Emissions (tCO2e)",ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivities,"CultOrgSoils C Emissions (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N2O volat from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"N2O volat from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_Outputs_MR.l(Regions_MR,CoreGrassActivities,"N2O volat from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N2O volat from CropRes/biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"N2O volat from CropRes/biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_Outputs_MR.l(Regions_MR,CoreGrassActivities,"N2O volat from CropRes/biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N2O volat from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"N2O volat from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_Outputs_MR.l(Regions_MR,CoreGrassActivities,"N2O volat from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N2O leach from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"N2O leach from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_Outputs_MR.l(Regions_MR,CoreGrassActivities,"N2O leach from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N2O leach from CropRes/biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"N2O leach from CropRes/biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_Outputs_MR.l(Regions_MR,CoreGrassActivities,"N2O leach from CropRes/biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N2O leach from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops,VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,"N2O leach from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios))
                 +sum(CoreGrassActivities,VActCropsGrass_Outputs_MR.l(Regions_MR,CoreGrassActivities,"N2O leach from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con,"_V6_DeriveActivityGroupAggregations: 1" timeElapsed;

VManure_Management_MR.l(Regions,"All Animals","AllAndAverageTypes",ManureManagement,"AllManManSystems",Temperatures,ProductionSystems,ProductionConditions,Scenarios)
         =sum((Livestock_MR,AnimalTypeInHerd,ManureManSystem_NoAverageNoTotal),
                 VManure_Management_MR.l(Regions,Livestock_MR,AnimalTypeInHerd,ManureManagement,ManureManSystem_NoAverageNoTotal,Temperatures,ProductionSystems,ProductionConditions,Scenarios));

VManure_Management_MR.l(Regions,"All Animals","AllAndAverageTypes",ManureManagement,"ManManSystems_OutputUsableForCroplands",Temperatures,ProductionSystems,ProductionConditions,Scenarios)
         =sum((Livestock_MR,AnimalTypeInHerd,ManureManSystemCropland),
                 VManure_Management_MR.l(Regions,Livestock_MR,AnimalTypeInHerd,ManureManagement,ManureManSystemCropland,Temperatures,ProductionSystems,ProductionConditions,Scenarios));

*$ontext;
VManure_Management_MR.l(Regions,Livestock_MR,"AllAndAverageTypes",ManureManagement,"AllManManSystems",Temperatures,ProductionSystems,ProductionConditions,Scenarios)
         =sum((AnimalTypeInHerd,ManureManSystem_NoAverageNoTotal),
                 VManure_Management_MR.l(Regions,Livestock_MR,AnimalTypeInHerd,ManureManagement,ManureManSystem_NoAverageNoTotal,Temperatures,ProductionSystems,ProductionConditions,Scenarios));

VManure_Management_MR.l(Regions,"All Animals","AllAndAverageTypes",ManureManagement,"ManManSystems_OutputUsableForCroplands",Temperatures,ProductionSystems,ProductionConditions,Scenarios)
         =sum((Livestock_MR,AnimalTypeInHerd,ManureManSystem_NoAverageNoTotal),
                 VManure_Management_MR.l(Regions,Livestock_MR,AnimalTypeInHerd,ManureManagement,ManureManSystem_NoAverageNoTotal,Temperatures,ProductionSystems,ProductionConditions,Scenarios))
         -sum((Livestock_MR,AnimalTypeInHerd,ManureManSystemGrassland),
                 VManure_Management_MR.l(Regions,Livestock_MR,AnimalTypeInHerd,ManureManagement,ManureManSystemGrassland,Temperatures,ProductionSystems,ProductionConditions,Scenarios));

VManure_Management_MR.l(Regions,"All Animals","AllAndAverageTypes",ManureManagement,"ManManSystems_OnGrasslands",Temperatures,ProductionSystems,ProductionConditions,Scenarios)
         =sum((Livestock_MR,AnimalTypeInHerd,ManureManSystemGrassland),
                 VManure_Management_MR.l(Regions,Livestock_MR,AnimalTypeInHerd,ManureManagement,ManureManSystemGrassland,Temperatures,ProductionSystems,ProductionConditions,Scenarios));

*$offtext;
PUTCLOSE con,"_V6_DeriveActivityGroupAggregations: 2" timeElapsed;


VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops_MR,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Grass",ProductionSystems,ProductionConditions,Scenarios)
         =sum(TempAndPermMeadAndPastures,VActCropsGrass_QuantityActUnits_MR.l(Regions,TempAndPermMeadAndPastures,ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Legumes_Nfixing,VActCropsGrass_QuantityActUnits_MR.l(Regions,Legumes_Nfixing,ProductionSystems,ProductionConditions,Scenarios));


VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops",OtherCharCropsGrass_ForAggregation,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VActCropsGrass_Otherchar_MR.l(Regions_MR,Crops,OtherCharCropsGrass_ForAggregation,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass",OtherCharCropsGrass_ForAggregation,ProductionSystems,ProductionConditions,Scenarios)
         =sum(TempAndPermMeadAndPastures,VActCropsGrass_OtherChar_MR.l(Regions_MR,TempAndPermMeadAndPastures,OtherCharCropsGrass_ForAggregation,ProductionSystems,ProductionConditions,Scenarios));


VActCropsGrass_Inputs_MR.l(Regions_MR,"All crops",InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VActCropsGrass_Inputs_MR.l(Regions_MR,Crops,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l(Regions_MR,"Grass",InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(TempAndPermMeadAndPastures,VActCropsGrass_Inputs_MR.l(Regions_MR,TempAndPermMeadAndPastures,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

*total crop residue N and P available to be put on the field, per geographic unit
*left on field: is also applied to other crops due to other crops standing next season, etc. - hence sum over all crop res man systems:
VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Crops_MR,CropResManSystemCropland),VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystemCropland,ProductionSystems,ProductionConditions,Scenarios));


*for the OECD-balance, there is a small part covering inputs from residues; this seems to be those residues that are returned to the field, i.e. NOT those LEFT ON THE FIELD, but only compost and biogas (currently) - thus do the sum without this.
VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res N for areas (tN) - for OECD N-balance","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Crops_MR,CropResManSystemCropland_ForOECDNBalance),VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystemCropland_ForOECDNBalance,ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res P for areas (tP2O5) - for OECD P-balance","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Crops_MR,CropResManSystemCropland_ForOECDNBalance),VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res P for areas (tP2O5)",CropResManSystemCropland_ForOECDNBalance,ProductionSystems,ProductionConditions,Scenarios));

*but also report the residues not left on the field but returned to the fields separately, as this is the quantity most relevant for the OECD balance comparison in the consistency checks:
*for this, we need an additional set element:
$onmulti
Set CropResManagement
/
"Crop res N exported and returned to areas (tN)"
/;
$offmulti


PUTCLOSE con,"_V6_DeriveActivityGroupAggregations: 3" timeElapsed;


VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res N exported and returned to areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         = VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
                 - sum(Crops_MR,VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res N for areas (tN)","Left on croplands",ProductionSystems,ProductionConditions,Scenarios));


VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res P for areas (tP2O5)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Crops_MR,CropResManSystemCropland),VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res P for areas (tP2O5)",CropResManSystemCropland,ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res man N - before management (tN)","AllCropResManSystems_WithVolatInApplication",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Crops_MR,CropResManSystem_WithVolatInApplication),
                 (VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystem_WithVolatInApplication,ProductionSystems,ProductionConditions,Scenarios)
                         +VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res man N loss (tN)",CropResManSystem_WithVolatInApplication,ProductionSystems,ProductionConditions,Scenarios)));


VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","N in manure (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"N in manure (tN)",ProductionSystems,ProductionConditions,Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock_MR,"AllAndAverageTypes","N in manure (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(AnimalTypeInHerd_MR,
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"N in manure (tN)",ProductionSystems,ProductionConditions,Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","P in manure (tP2O5)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"P in manure (tP2O5)",ProductionSystems,ProductionConditions,Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock_MR,"AllAndAverageTypes","P in manure (tP2O5)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(AnimalTypeInHerd_MR,
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"P in manure (tP2O5)",ProductionSystems,ProductionConditions,Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,Scenarios));

*and also calculate total manure quantities in VS and TS:
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","TS DM in manure (tTS)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","VS DM in manure (tVS)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"VS DM in manure (tVS)",ProductionSystems,ProductionConditions,Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,Scenarios));


PUTCLOSE con,"_V6_DeriveActivityGroupAggregations: 4" timeElapsed;


*the aggregates for GHG emissions:
VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Total GHG emissions - animals (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                  VActAnimalsHead_OtherChar_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Total GHG emissions - animals (tCO2e)",ProductionSystems,ProductionConditions,Scenarios));


VActCropsGrass_OtherChar_MR.l(Regions_MR,Activities_MR,"N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios)
                 *VActCropsGrass_Outputs_MR.l(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios);

VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops,"N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Cereals","N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Cereals,VActCropsGrass_OtherChar_MR.l(Regions_MR,Cereals,"N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Forage Crops","N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(ForageCrops,VActCropsGrass_OtherChar_MR.l(Regions_MR,ForageCrops,"N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Legumes (Nfixing)","N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Legumes_Nfixing,VActCropsGrass_OtherChar_MR.l(Regions_MR,Legumes_Nfixing,"N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(TempAndPermMeadAndPastures,VActCropsGrass_OtherChar_MR.l(Regions_MR,TempAndPermMeadAndPastures,"N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios));


PUTCLOSE con,"_V6_DeriveActivityGroupAggregations: 5" timeElapsed;


*"All Animals" is available only here, hence do this geographic aggregation here only
VManure_Management_MR.l("European Union","All animals","AllAndAverageTypes","Manure man+Housing N total loss (tN)","AllManManSystems","AllAndAverageTemp",Productionsystems,"AllProdCond",Scenarios)
         =sum(FAO_EuropeanUnion,VManure_Management_MR.l(FAO_EuropeanUnion,"All animals","AllAndAverageTypes","Manure man+Housing N total loss (tN)","AllManManSystems","AllAndAverageTemp",Productionsystems,"AllProdCond",Scenarios));

VManure_Management_MR.l("European Union","All animals","AllAndAverageTypes","Manure man CH4 (tCO2e)","AllManManSystems","AllAndAverageTemp",Productionsystems,"AllProdCond",Scenarios)
         =sum(FAO_EuropeanUnion,VManure_Management_MR.l(FAO_EuropeanUnion,"All animals","AllAndAverageTypes","Manure man CH4 (tCO2e)","AllManManSystems","AllAndAverageTemp",Productionsystems,"AllProdCond",Scenarios));

VManure_Management_MR.l("European Union","All animals","AllAndAverageTypes","Manure man N2O dir (tCO2e)","ManManSystems_OutputUsableForCroplands","AllAndAverageTemp",Productionsystems,"AllProdCond",Scenarios)
         =sum(FAO_EuropeanUnion,VManure_Management_MR.l(FAO_EuropeanUnion,"All animals","AllAndAverageTypes","Manure man N2O dir (tCO2e)","ManManSystems_OutputUsableForCroplands","AllAndAverageTemp",Productionsystems,"AllProdCond",Scenarios));

VManure_Management_MR.l("European Union","All animals","AllAndAverageTypes","Manure man N2O volat (tCO2e)","ManManSystems_OutputUsableForCroplands","AllAndAverageTemp",Productionsystems,"AllProdCond",Scenarios)
         =sum(FAO_EuropeanUnion,VManure_Management_MR.l(FAO_EuropeanUnion,"All animals","AllAndAverageTypes","Manure man N2O volat (tCO2e)","ManManSystems_OutputUsableForCroplands","AllAndAverageTemp",Productionsystems,"AllProdCond",Scenarios));

VManure_Management_MR.l("European Union","All animals","AllAndAverageTypes","Manure man N2O leach (tCO2e)","ManManSystems_OutputUsableForCroplands","AllAndAverageTemp",Productionsystems,"AllProdCond",Scenarios)
         =sum(FAO_EuropeanUnion,VManure_Management_MR.l(FAO_EuropeanUnion,"All animals","AllAndAverageTypes","Manure man N2O leach (tCO2e)","ManManSystems_OutputUsableForCroplands","AllAndAverageTemp",Productionsystems,"AllProdCond",Scenarios));


VCommod_Food_Contents_MR.l(Regions,"All Commodities",Contents,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Commodities_MR,
                 VCommod_Contents_MR.l(Regions,Commodities_MR,Contents,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_OtherChar_MR(Regions,Commodities_MR,"Util food (share)",ProductionSystems,ProductionConditions,Scenarios));



$exit;
PUTCLOSE con,"_V6_DeriveActivityGroupAggregations: 6" timeElapsed;

*already done above at the beginning

*derive per capita kcal etc supply:
Commod_OtherChar_MR(Regions,"All Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,ProductionConditions,Scenarios)
                 $VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
         = VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                 /VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                         /365;
Commod_OtherChar_MR(Regions,"All Commodities","Protein per capita (g/cap/day)",ProductionSystems,ProductionConditions,Scenarios)
                 $VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
         = VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                         *1000000/365;



$exit;
*some aggregates needed for UNISECO:

VImportQuantity_MR.l("European Union","World","Cereals_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Cereals_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_Cereals_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","FodderCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FodderCrops_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_FodderCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","Fruits_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Fruits_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_Fruits_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","Nuts_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Nuts_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_Nuts_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","Oilcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Oilcrops_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_Oilcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","OtherCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_OtherCrops_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_OtherCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","Pulses_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Pulses_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_Pulses_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","RootsAndTubers_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_RootsAndTubers_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_RootsAndTubers_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","Sugarcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Sugarcrops_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_Sugarcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","Vegetables_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Vegetables_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_Vegetables_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","Milk_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Milk_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_Milk_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","Meat_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Meat_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_Meat_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","Eggs_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Eggs_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_Eggs_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VImportQuantity_MR.l("European Union","World","FishSeafood_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FishSeafood_CommodityGroup,VImportQuantity_MR.l("European Union","World",SET_FishSeafood_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));

VExportQuantity_MR.l("European Union","World","Cereals_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Cereals_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_Cereals_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","FodderCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FodderCrops_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_FodderCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","Fruits_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Fruits_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_Fruits_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","Nuts_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Nuts_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_Nuts_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","Oilcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Oilcrops_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_Oilcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","OtherCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_OtherCrops_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_OtherCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","Pulses_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Pulses_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_Pulses_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","RootsAndTubers_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_RootsAndTubers_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_RootsAndTubers_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","Sugarcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Sugarcrops_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_Sugarcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","Vegetables_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Vegetables_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_Vegetables_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","Milk_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Milk_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_Milk_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","Meat_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Meat_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_Meat_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","Eggs_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Eggs_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_Eggs_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","World","FishSeafood_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FishSeafood_CommodityGroup,VExportQuantity_MR.l("European Union","World",SET_FishSeafood_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));




VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","Cereals_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Cereals_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Cereals_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","FodderCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Foddercrops_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_FodderCrops_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","Fruits_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Fruits_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Fruits_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","Nuts_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Nuts_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Nuts_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","OtherCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_OtherCrops_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_OtherCrops_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","OilCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_OilCrops_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_OilCrops_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","Pulses_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Pulses_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Pulses_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","RootsAndTubers_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_RootsAndTubers_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_RootsAndTubers_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","SugarCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_SugarCrops_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_SugarCrops_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","Vegetables_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Vegetables_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Vegetables_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","Milk_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Milk_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Milk_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","Meat_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Meat_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Meat_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","Eggs_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Eggs_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Eggs_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World","FishSeafood_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_FishSeafood_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_FishSeafood_CommodityGroup),
                 VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));


VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","Cereals_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Cereals_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Cereals_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","FodderCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Foddercrops_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_FodderCrops_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","Fruits_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Fruits_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Fruits_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","Nuts_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Nuts_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Nuts_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","OtherCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_OtherCrops_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_OtherCrops_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","OilCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_OilCrops_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_OilCrops_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","Pulses_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Pulses_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Pulses_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","RootsAndTubers_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_RootsAndTubers_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_RootsAndTubers_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","SugarCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_SugarCrops_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_SugarCrops_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","Vegetables_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Vegetables_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Vegetables_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","Milk_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Milk_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Milk_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","Meat_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Meat_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Meat_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","Eggs_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_Eggs_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_Eggs_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World","FishSeafood_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Commodities,SET_FishSeafood_CommodityGroup)$MatchCommodTradeFromToWorld_CommodTradeBetweenCountries(Commodities,SET_FishSeafood_CommodityGroup),
                 VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities,ProductionSystems,ProductionConditions,Scenarios));


VPrimProd_Commod_Quantity_MR.l("European Union","Cereals_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Cereals_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_Cereals_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","FodderCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FodderCrops_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_FodderCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","Fruits_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Fruits_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_Fruits_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","Nuts_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Nuts_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_Nuts_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","Oilcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Oilcrops_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_Oilcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","OtherCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_OtherCrops_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_OtherCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","Pulses_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Pulses_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_Pulses_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","RootsAndTubers_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_RootsAndTubers_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_RootsAndTubers_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","Sugarcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Sugarcrops_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_Sugarcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","Vegetables_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Vegetables_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_Vegetables_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","Milk_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Milk_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_Milk_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","Meat_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Meat_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_Meat_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","Eggs_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Eggs_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_Eggs_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("European Union","FishSeafood_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FishSeafood_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("European Union",SET_FishSeafood_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));

VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","Cereals_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Cereals_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_Cereals_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","FodderCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FodderCrops_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_FodderCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","Fruits_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Fruits_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_Fruits_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","Nuts_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Nuts_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_Nuts_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","Oilcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Oilcrops_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_Oilcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","OtherCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_OtherCrops_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_OtherCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","Pulses_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Pulses_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_Pulses_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","RootsAndTubers_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_RootsAndTubers_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_RootsAndTubers_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","Sugarcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Sugarcrops_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_Sugarcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","Vegetables_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Vegetables_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_Vegetables_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","Milk_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Milk_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_Milk_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","Meat_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Meat_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_Meat_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","Eggs_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Eggs_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_Eggs_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World","FishSeafood_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FishSeafood_CommodityGroup,VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",SET_FishSeafood_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));


VPrimProd_Commod_Production_MR.l("European Union","Cereals_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Cereals_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_Cereals_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","FodderCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FodderCrops_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_FodderCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","Fruits_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Fruits_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_Fruits_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","Nuts_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Nuts_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_Nuts_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","Oilcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Oilcrops_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_Oilcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","OtherCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_OtherCrops_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_OtherCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","Pulses_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Pulses_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_Pulses_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","RootsAndTubers_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_RootsAndTubers_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_RootsAndTubers_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","Sugarcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Sugarcrops_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_Sugarcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","Vegetables_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Vegetables_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_Vegetables_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","Milk_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Milk_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_Milk_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","Meat_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Meat_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_Meat_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","Eggs_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Eggs_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_Eggs_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union","FishSeafood_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FishSeafood_CommodityGroup,VPrimProd_Commod_Production_MR.l("European Union",SET_FishSeafood_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));

VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","Cereals_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Cereals_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_Cereals_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","FodderCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FodderCrops_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_FodderCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","Fruits_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Fruits_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_Fruits_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","Nuts_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Nuts_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_Nuts_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","Oilcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Oilcrops_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_Oilcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","OtherCrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_OtherCrops_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_OtherCrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","Pulses_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Pulses_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_Pulses_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","RootsAndTubers_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_RootsAndTubers_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_RootsAndTubers_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","Sugarcrops_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Sugarcrops_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_Sugarcrops_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","Vegetables_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Vegetables_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_Vegetables_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","Milk_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Milk_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_Milk_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","Meat_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Meat_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_Meat_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","Eggs_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_Eggs_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_Eggs_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World","FishSeafood_CommodityGroup",ProductionSystems,ProductionConditions,Scenarios)
         =sum(SET_FishSeafood_CommodityGroup,VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",SET_FishSeafood_CommodityGroup,ProductionSystems,ProductionConditions,Scenarios));



$exit;










Set Match_ActivityAggregates_SingleActivities(Activities,Activities_2)
/
"All animals".#Livestock

$ontext;
"All Ruminants".#Ruminants
"All Poultry".#Poultry
*MonogastricsNonPoultry
"All Fish and Seafood".#FishAndSeafood
"All NonRuminants".#NonRuminants
$offtext;

"All crops".#Crops

*$ontext;
"All Cereals".#Cereals
"All Fruits".#Fruits
*"All Nuts".#Treenuts
*"Pulses,Total".#Pulses
"All Legumes (Nfixing)".#Legumes_NFixing
$ontext;
"All Crops without Legumes (Nfixing)".#Crops_NoNFixingLegumes
"All Oilcrops".#OilCrops
"All starchy roots".#StarchyRoots
"All Sugar Crops".#SugarCrops
"All Vegetables".#Vegetables
*.#StimulantsSpices
*.#FibresRubber
"Other Cereals".#OtherCereals
"Citrus Fruits".#CitrusFruits
"All spices".#Spices
"All other vegetables".#OtherVegetables
"All other oilcrops".#OtherOilcrops
"All other soft fibres".#FibresNotCotton
*.#Fallows

"All energy crops"                     .#EnergyCrops
"All forage crops"                     .#ForageCrops
"All other fodder crops"               .#OtherFodderCrops
$offtext;

"Core grass activities"                .#CoreGrassActivities

$ontext;
"All crops and grass - NO temp grass"  .#CoreGrassActivitiesNoTEMPGrass
"Temporary meadows and pastures"       .#TempMeadAndPastures
"Temp. and perm. meadows and pastures" .#TempAndPermMeadAndPastures
"All crops and grass"                  .#CropsAndCoreGrassActivities
$offtext;
/;

*activity aggregation is slow also woithout the matching file - thus do only very specific cases that are needed for consistency checks; add full aggregation only later when the model is fully tested and running.

*First, we redo some of the aggregates we already had but which have been overwritten in "_V6_DeriveTotalImpacts"
*this is from the code "_V6_CoreModelEquations_FertilizerApplication.gms"

VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","N in manure (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"N in manure (tN)",ProductionSystems,ProductionConditions,Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","P in manure (tP2O5)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"P in manure (tP2O5)",ProductionSystems,ProductionConditions,Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,Scenarios));

*and also calculate total manure quantities in VS and TS:
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","TS DM in manure (tTS)",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,Scenarios));

*total crop residue N and P available to be put on the field, per geographic unit
*left on field: is also applied to other crops due to other crops standing next season, etc. - hence sum over all crop res man systems:
VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Crops_MR,CropResManSystemCropland),VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystemCropland,ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res P for areas (tP2O5)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Crops_MR,CropResManSystemCropland),VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res P for areas (tP2O5)",CropResManSystemCropland,ProductionSystems,ProductionConditions,Scenarios));

*For grass, the residues are the difference between yield and harvest/grazing, thus remain on the land, thus no sum over different grassland, etc. - or removal to cropland, thus just use the following values:
VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities,"Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         = sum(CropResManSystemGrassland,VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystemGrassland,ProductionSystems,ProductionConditions,Scenarios));
VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities,"Average Residues (t)","Crop res P for areas (tP2O5)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         = sum(CropResManSystemGrassland,VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities,"Average Residues (t)","Crop res P for areas (tP2O5)",CropResManSystemGrassland,ProductionSystems,ProductionConditions,Scenarios));


*Using this matching file in the code below makes it terribly slow, thus assign by hand:
*        for the follwoing three activity groups:
*"All animals".#Livestock
*"All crops".#Crops
*"Core grass activities".#CoreGrassActivities


VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Crops",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Core grass activities",ProductionSystems,ProductionConditions,Scenarios)
         =sum(CoreGrassActivities,VActCropsGrass_QuantityActUnits_MR.l(Regions,CoreGrassActivities,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_QuantityActUnits_MR.l(Regions,"All Animals","AllAndAverageTypes",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Livestock,AnimalTypeInHerd),VActAnimalsHead_QuantityActUnits_MR.l(Regions,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios));


VActCropsGrass_Inputs_MR.l(Regions,"All Crops",InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VActCropsGrass_Inputs_MR.l(Regions,Crops,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l(Regions,"Core grass activities",InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(CoreGrassActivities,VActCropsGrass_Inputs_MR.l(Regions,CoreGrassActivities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_Inputs_MR.l(Regions,"All Animals","AllAndAverageTypes",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum((Livestock,AnimalTypeInHerd),VActAnimalsHead_Inputs_MR.l(Regions,Livestock,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios));


VActCropsGrass_Outputs_MR.l(Regions,"All Crops",OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VActCropsGrass_Outputs_MR.l(Regions,Crops,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Outputs_MR.l(Regions,"Core grass activities",OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(CoreGrassActivities,VActCropsGrass_Outputs_MR.l(Regions,CoreGrassActivities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_Outputs_MR.l(Regions,"All Animals","AllAndAverageTypes",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum((Livestock,AnimalTypeInHerd),VActAnimalsHead_Outputs_MR.l(Regions,Livestock,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios));



VActCropsGrass_OtherChar_MR.l(Regions,"All Crops",OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VActCropsGrass_OtherChar_MR.l(Regions,Crops,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions,"Core grass activities",OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(CoreGrassActivities,VActCropsGrass_OtherChar_MR.l(Regions,CoreGrassActivities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum((Livestock,AnimalTypeInHerd),VActAnimalsHead_OtherChar_MR.l(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios));

*VManure_Management_MR.l(Regions,"All Animals","AllAndAverageTypes",ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios)
*         =sum((Livestock,AnimalTypeInHerd),VManure_Management_MR.l(Regions,Livestock,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios));

*VCropResidues_Management_MR.l(Regions,"All Crops",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios)
*         =sum(Crops,VCropResidues_Management_MR.l(Regions,Crops,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios));
*VCropResidues_Management_MR.l(Regions,"Core grass activities",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios)
*         =sum(CoreGrassActivities,VCropResidues_Management_MR.l(Regions,CoreGrassActivities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios));


VCropResidues_Contents_MR.l(Regions,"All Crops",OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VCropResidues_Contents_MR.l(Regions,Crops,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios));
VCropResidues_Contents_MR.l(Regions,"Core grass activities",OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios)
         =sum(CoreGrassActivities,VCropResidues_Contents_MR.l(Regions,CoreGrassActivities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios));

VManureApplication_MR.l(Regions,"All Crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VManureApplication_MR.l(Regions,Crops,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));
VManureApplication_MR.l(Regions,"Core grass activities",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(CoreGrassActivities,VManureApplication_MR.l(Regions,CoreGrassActivities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));


VCropResAndBiomassApplication_MR.l(Regions,"All Crops",Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VCropResAndBiomassApplication_MR.l(Regions,Crops,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));
VCropResAndBiomassApplication_MR.l(Regions,"Core grass activities",Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(CoreGrassActivities,VCropResAndBiomassApplication_MR.l(Regions,CoreGrassActivities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));

VMinFertApplication_MR.l(Regions,"All Crops",MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Crops,VMinFertApplication_MR.l(Regions,Crops,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));
VMinFertApplication_MR.l(Regions,"Core grass activities",MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(CoreGrassActivities,VMinFertApplication_MR.l(Regions,CoreGrassActivities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));






$exit;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities_2,ProductionSystems,ProductionConditions,Scenarios));


$ontext;
VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities_2,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios));
$offtext;

VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities_2,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios));

$ontext;
VActFishSeafood_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActFishSeafood_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActFishSeafood_QuantityActUnits_MR.l(Regions,Activities_2,ProductionSystems,ProductionConditions,Scenarios));

VActForest_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActForest_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActForest_QuantityActUnits_MR.l(Regions,Activities_2,ProductionSystems,ProductionConditions,Scenarios));

VActOthers_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActOthers_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActOthers_QuantityActUnits_MR.l(Regions,Activities_2,ProductionSystems,ProductionConditions,Scenarios));
$offtext;

VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActCropsGrass_Inputs_MR.l(Regions,Activities_2,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

$ontext;
VActAnimalsAPU_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsAPU_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActAnimalsAPU_Inputs_MR.l(Regions,Activities_2,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios));
$offtext;

VActAnimalsHead_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActAnimalsHead_Inputs_MR.l(Regions,Activities_2,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios));

$ontext;
VActFishSeafood_Inputs_MR.l(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActFishSeafood_Inputs_MR.l(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActFishSeafood_Inputs_MR.l(Regions,Activities_2,InputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios));

VActForest_Inputs_MR.l(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActForest_Inputs_MR.l(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActForest_Inputs_MR.l(Regions,Activities_2,InputsForest,ProductionSystems,ProductionConditions,Scenarios));

VActOthers_Inputs_MR.l(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActOthers_Inputs_MR.l(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActOthers_Inputs_MR.l(Regions,Activities_2,InputsOther,ProductionSystems,ProductionConditions,Scenarios));
$offtext;

VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActCropsGrass_Outputs_MR.l(Regions,Activities_2,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

$ontext;
VActAnimalsAPU_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsAPU_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActAnimalsAPU_Outputs_MR.l(Regions,Activities_2,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios));
$offtext;

VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActAnimalsHead_Outputs_MR.l(Regions,Activities_2,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios));

$ontext;
VActFishSeafood_Outputs_MR.l(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActFishSeafood_Outputs_MR.l(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActFishSeafood_Outputs_MR.l(Regions,Activities_2,OutputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios));

VActForest_Outputs_MR.l(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActForest_Outputs_MR.l(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActForest_Outputs_MR.l(Regions,Activities_2,OutputsForest,ProductionSystems,ProductionConditions,Scenarios));

VActOthers_Outputs_MR.l(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActOthers_Outputs_MR.l(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActOthers_Outputs_MR.l(Regions,Activities_2,OutputsOther,ProductionSystems,ProductionConditions,Scenarios));


VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActCropsGrass_OtherChar_MR.l(Regions,Activities_2,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsAPU_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsAPU_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActAnimalsAPU_OtherChar_MR.l(Regions,Activities_2,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActAnimalsHead_OtherChar_MR.l(Regions,Activities_2,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios));

VActFishSeafood_OtherChar_MR.l(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActFishSeafood_OtherChar_MR.l(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActFishSeafood_OtherChar_MR.l(Regions,Activities_2,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios));

VActForest_OtherChar_MR.l(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActForest_OtherChar_MR.l(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActForest_OtherChar_MR.l(Regions,Activities_2,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios));

VActOthers_OtherChar_MR.l(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActOthers_OtherChar_MR.l(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VActOthers_OtherChar_MR.l(Regions,Activities_2,OtherCharOther,ProductionSystems,ProductionConditions,Scenarios));

*Commodity groups - not activity groups: do later
*VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
*                 VCommod_Quantity_MR.l(Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios));

*Commodity groups - not activity groups: do later
*VCommod_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VCommod_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
*                 VCommod_Contents_MR.l(Regions_2,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios));

*Commodity groups - not activity groups: do later
*VCommod_OtherChar_MR.l(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VCommod_OtherChar_MR.l(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
*                 VCommod_OtherChar_MR.l(Regions_2,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_Quantity_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Quantity_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VCropResidues_Quantity_MR.l(Regions,Activities_2,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VCropResidues_Contents_MR.l(Regions,Activities_2,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_OtherChar_MR.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCropResidues_OtherChar_MR.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VCropResidues_OtherChar_MR.l(Regions,Activities_2,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VCropResidues_Management_MR.l(Regions,Activities_2,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios));


VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VFeedingRations_Quantity_MR.l(Regions,Activities_2,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,Scenarios));

VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VFeedingRations_Contents_MR.l(Regions,Activities_2,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios));

VFeedingRations_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VFeedingRations_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VFeedingRations_OtherChar_MR.l(Regions,Activities_2,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios));


VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VManure_Quantity_MR.l(Regions,Activities_2,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios));

VManure_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VManure_Contents_MR.l(Regions,Activities_2,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios));

VManure_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VManure_OtherChar_MR.l(Regions,Activities_2,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios));

VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VManure_Management_MR.l(Regions,Activities_2,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios));


*VManureApplication_MR.l(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VManureApplication_MR.l(Regions,Activities,Activities_3,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Activities_3$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
*                 VManureApplication_MR.l(Regions,Activities_3,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));

*no activity dimension - no sum needed here
*VMineralFertilizerQuantity_MR.l(Regions,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios)

VMinFertApplication_MR.l(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VMinFertApplication_MR.l(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Activities_2$Match_ActivityAggregates_SingleActivities(Activities,Activities_2),
                 VMinFertApplication_MR.l(Regions,Activities_2,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));


*no activity dimension - no sum needed here
*VPopulationNumbers_MR.l(Regions,PopulationGroups,Scenarios)

*no activity dimension - no sum needed here
*VEnergyProduction_MR.l(Regions,ConversionLevel,EnergyType,EnergySource,EnergyChar,Scenarios)

$offtext;




$exit;

THEN:
derive per act group per unit impacts



