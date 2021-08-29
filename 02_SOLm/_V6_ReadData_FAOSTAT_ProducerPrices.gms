PUTCLOSE con,"_V6_ReadData_FAOSTAT_ProducerPrices";

$ontext;
GENERAL DESCRIPTION
This file reads the producer price data from FAOSTAT

DETAILED TABLE OF CONTENTS
- 1) reading the csv-file and loading the parameters
- 2) build average over the base year period chosen to get the baseline values
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;

*ATTENTION:
*Currently, we have the data from 1991 onwards only in the model; we did nto look at the data for the years up to 1991 and we did not yet load those.
*This older data is available from "Producer prices archive" under "Prices" on the FAOSTAT "Data"-site.
*and the second price-indicator, i.e. the "unit values" that have been available for SOLmV2 - SOLmV4 cannot any longer be downloaded from FAOSTAT - thus we have producer prices only



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) reading the csv-file and loading the parameters

*read csv files from FAOSTAT into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewFAOSTATProducerPriceData% == "YES"
$call csv2gdx FAOSTAT_ProducerPriceNormalized_20_12_2017.csv id=FAOSTAT_ProducerPrice Index=(2,4,6,8,9) Values=(10) UseHeader=Y
*contains FAO ProducerPrice data
$endif;

Parameter FAOSTAT_ProducerPrice(FAOSTAT_CountriesAndRegions,FAOSTAT_ProducerPriceItems,FAOSTAT_ProducerPriceElements,Years,FAOSTAT_ProducerPriceUnits);

$gdxin FAOSTAT_ProducerPriceNormalized_20_12_2017.gdx
$load FAOSTAT_ProducerPrice
$gdxin


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) build average over the base year period chosen to get the baseline values


*        XXX STILL TO BE DONE:

*TO BE DONE: build production weighted averages!!!
*NOT YET DONE - as this needs again some matching from the ProducerPrice
*THUS; CURRENTLY: just an unweighted average!!!!


PARAMETER NumberOfBasisYearsFAOSTATProducerPrice;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....


NumberOfBasisYearsFAOSTATProducerPrice(FAOSTAT_CountriesAndRegions,FAOSTAT_ProducerPriceItems,FAOSTAT_ProducerPriceElements,FAOSTAT_ProducerPriceUnits)
         = SUM(BasisYears$FAOSTAT_ProducerPrice(FAOSTAT_CountriesAndRegions,FAOSTAT_ProducerPriceItems,FAOSTAT_ProducerPriceElements,BasisYears,FAOSTAT_ProducerPriceUnits),1);

FAOSTAT_ProducerPrice(FAOSTAT_CountriesAndRegions,FAOSTAT_ProducerPriceItems,FAOSTAT_ProducerPriceElements,"AverageBasisYear",FAOSTAT_ProducerPriceUnits)
                 $NumberOfBasisYearsFAOSTATProducerPrice(FAOSTAT_CountriesAndRegions,FAOSTAT_ProducerPriceItems,FAOSTAT_ProducerPriceElements,FAOSTAT_ProducerPriceUnits)
         = SUM(BasisYears,FAOSTAT_ProducerPrice(FAOSTAT_CountriesAndRegions,FAOSTAT_ProducerPriceItems,FAOSTAT_ProducerPriceElements,BasisYears,FAOSTAT_ProducerPriceUnits))
                 /NumberOfBasisYearsFAOSTATProducerPrice(FAOSTAT_CountriesAndRegions,FAOSTAT_ProducerPriceItems,FAOSTAT_ProducerPriceElements,FAOSTAT_ProducerPriceUnits);




$ontext;
after this, we have
FAOSTAT_ProducerPrice(FAOSTAT_CountriesAndRegions,FAOSTAT_ProducerPriceItems,FAOSTAT_ProducerPriceElements,Years,FAOSTAT_ProducerPriceUnits)
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables

*3.1) Link some sets as needed
*the producer price items and crop production and live animal items are not fully identical - the items missing in one or the other are starred out
* items with **NOT are not element of FAOSTAT_ProducerPriceItems - the set below is built from FAOSTAT_CropProductionItems and FAOSTAT_LivestockPrimaryItems
Set MatchProducerPriceItems_Commodities(FAOSTAT_ProducerPriceItems,Commodities)
/
"Agave fibres nes"."Agave fibres nes"
"Almonds, with shell"."Almonds, with shell"
"Anise, badian, fennel, coriander"."Anise, badian, fennel, coriander"
"Apples"."Apples"
"Apricots"."Apricots"
"Areca nuts"."Areca nuts"
"Artichokes"."Artichokes"
"Asparagus"."Asparagus"
"Avocados"."Avocados"
"Bambara beans"."Bambara beans"
"Bananas"."Bananas"
"Barley"."Barley"
"Bastfibres, other"."Bastfibres, other"
"Beans, dry"."Beans, dry"
"Beans, green"."Beans, green"
"Berries nes"."Berries nes"
"Blueberries"."Blueberries"
"Brazil nuts, with shell"."Brazil nuts, with shell"
"Broad beans, horse beans, dry"."Broad beans, horse beans, dry"
"Buckwheat"."Buckwheat"
"Cabbages and other brassicas"."Cabbages and other brassicas"
"Canary seed"."Canary seed"
"Carobs"."Carobs"
"Carrots and turnips"."Carrots and turnips"
"Cashew nuts, with shell"."Cashew nuts, with shell"
"Cashewapple"."Cashewapple"
"Cassava"."Cassava"
**NOT "Cassava leaves"."Cassava leaves"
"Castor oil seed"."Castor oil seed"
"Cauliflowers and broccoli"."Cauliflowers and broccoli"
**NOT "Cereals (Rice Milled Eqv)"."Cereals (Rice Milled Eqv)"
"Cereals, nes"."Cereals, nes"
*"Cereals,Total"."Cereals,Total"
"Cherries"."Cherries"
"Cherries, sour"."Cherries, sour"
"Chestnut"."Chestnut"
"Chick peas"."Chick peas"
"Chicory roots"."Chicory roots"
"Chillies and peppers, dry"."Chillies and peppers, dry"
"Chillies and peppers, green"."Chillies and peppers, green"
"Cinnamon (canella)"."Cinnamon (canella)"
*"Citrus Fruit,Total"."Citrus Fruit,Total"
"Cloves"."Cloves"
*"Coarse Grain, Total"."Coarse Grain, Total"
"Cocoa, beans"."Cocoa, beans"
"Coconuts"."Coconuts"
"Coffee, green"."Coffee, green"
**NOT "Coir"."Coir"
"Cotton lint"."Cotton lint"
"Cottonseed"."Cottonseed"
"Cow peas, dry"."Cow peas, dry"
"Cranberries"."Cranberries"
"Cucumbers and gherkins"."Cucumbers and gherkins"
"Currants"."Currants"
"Dates"."Dates"
"Eggplants (aubergines)"."Eggplants (aubergines)"
"Fibre crops nes"."Fibre crops nes"
**NOT "Fibre Crops Primary"."Fibre Crops Primary"
"Figs"."Figs"
"Flax fibre and tow"."Flax fibre and tow"
"Fonio"."Fonio"
*"Fruit excl Melons,Total"."Fruit excl Melons,Total"
"Fruit, citrus nes"."Fruit, citrus nes"
"Fruit, fresh nes"."Fruit, fresh nes"
"Fruit, pome nes"."Fruit, pome nes"
"Fruit, stone nes"."Fruit, stone nes"
"Fruit, tropical fresh nes"."Fruit, tropical fresh nes"
"Garlic"."Garlic"
"Ginger"."Ginger"
"Gooseberries"."Gooseberries"
"Grain, mixed"."Grain, mixed"
"Grapefruit (inc. pomelos)"."Grapefruit (inc. pomelos)"
"Grapes"."Grapes"
"Groundnuts, with shell"."Groundnuts, with shell"
"Gums, natural"."Gums, natural"
"Hazelnuts, with shell"."Hazelnuts, with shell"
"Hemp tow waste"."Hemp tow waste"
"Hempseed"."Hempseed"
"Hops"."Hops"
"Jojoba seed"."Jojoba seed"
"Jute"."Jute"
**NOT "Jute & Jute-like Fibres"."Jute & Jute-like Fibres"
**NOT "Kapok fibre"."Kapok fibre"
"Kapok fruit"."Kapok fruit"
**NOT "Kapokseed in shell"."Kapokseed in shell"
"Karite nuts (sheanuts)"."Karite nuts (sheanuts)"
"Kiwi fruit"."Kiwi fruit"
"Kola nuts"."Kola nuts"
"Leeks, other alliaceous vegetables"."Leeks, other alliaceous vegetables"
"Lemons and limes"."Lemons and limes"
"Lentils"."Lentils"
"Lettuce and chicory"."Lettuce and chicory"
"Linseed"."Linseed"
"Lupins"."Lupins"
"Maize"."Maize"
"Maize, green"."Maize, green"
"Mangoes, mangosteens, guavas"."Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"."Manila fibre (abaca)"
"Maté"."Maté"
*     in the data downloaded from FAOSTAT, it is written "MatÃ©"  *     in the data downloaded from FAOSTAT, it is written "MatÃ©"
"Melons, other (inc.cantaloupes)"."Melons, other (inc.cantaloupes)"
"Melonseed"."Melonseed"
"Millet"."Millet"
"Mushrooms and truffles"."Mushrooms and truffles"
"Mustard seed"."Mustard seed"
"Nutmeg, mace and cardamoms"."Nutmeg, mace and cardamoms"
"Nuts, nes"."Nuts, nes"
"Oats"."Oats"
"Oil, palm"."Oil, palm"
"Oil, palm fruit"."Oil, palm fruit"
*"Oilcakes Equivalent"."Oilcakes Equivalent"
*"Oilcrops Primary"."Oilcrops Primary"
"Oilseeds nes"."Oilseeds nes"
"Okra"."Okra"
"Olives"."Olives"
"Onions, dry"."Onions, dry"
"Onions, shallots, green"."Onions, shallots, green"
"Oranges"."Oranges"
"Palm kernels"."Palm kernels"
"Papayas"."Papayas"
"Peaches and nectarines"."Peaches and nectarines"
"Pears"."Pears"
"Peas, dry"."Peas, dry"
"Peas, green"."Peas, green"
"Pepper (piper spp.)"."Pepper (piper spp.)"
"Peppermint"."Peppermint"
"Persimmons"."Persimmons"
"Pigeon peas"."Pigeon peas"
"Pineapples"."Pineapples"
"Pistachios"."Pistachios"
"Plantains and others"."Plantains and others"
"Plums and sloes"."Plums and sloes"
"Poppy seed"."Poppy seed"
"Potatoes"."Potatoes"
"Pulses, nes"."Pulses, nes"
*"Pulses,Total"."Pulses,Total"
"Pumpkins, squash and gourds"."Pumpkins, squash and gourds"
"Pyrethrum, dried"."Pyrethrum, dried"
"Quinces"."Quinces"
"Quinoa"."Quinoa"
"Ramie"."Ramie"
"Rapeseed"."Rapeseed"
"Raspberries"."Raspberries"
"Rice, paddy"."Rice, paddy"
"Roots and tubers, nes"."Roots and tubers, nes"
*"Roots and Tubers,Total"."Roots and Tubers,Total"
"Rubber, natural"."Rubber, natural"
"Rye"."Rye"
"Safflower seed"."Safflower seed"
"Seed cotton"."Seed cotton"
"Sesame seed"."Sesame seed"
"Sisal"."Sisal"
"Sorghum"."Sorghum"
"Soybeans"."Soybeans"
"Spices, nes"."Spices, nes"
"Spinach"."Spinach"
"Strawberries"."Strawberries"
"String beans"."String beans"
"Sugar beet"."Sugar beet"
"Sugar cane"."Sugar cane"
"Sugar crops, nes"."Sugar crops, nes"
"Sunflower seed"."Sunflower seed"
"Sweet potatoes"."Sweet potatoes"
"Tallowtree seed"."Tallowtree seed"
"Tangerines, mandarins, clementines, satsumas"."Tangerines, mandarins, clementines, satsumas"
"Taro (cocoyam)"."Taro (cocoyam)"
"Tea"."Tea"
"Tobacco, unmanufactured"."Tobacco, unmanufactured"
"Tomatoes"."Tomatoes"
*"Treenuts,Total"."Treenuts,Total"
"Triticale"."Triticale"
"Tung nuts"."Tung nuts"
"Vanilla"."Vanilla"
*"Vegetables Primary". "Vegetables Primary"
*"Vegetables&Melons, Total"."Vegetables&Melons, Total"
"Vegetables, fresh nes"."Vegetables, fresh nes"
"Vegetables, leguminous nes"."Vegetables, leguminous nes"
"Vetches"."Vetches"
"Walnuts, with shell"."Walnuts, with shell"
"Watermelons"."Watermelons"
"Wheat"."Wheat"
"Yams"."Yams"
"Yautia (cocoyam)"."Yautia (cocoyam)"

*we assign all values for birds different than chicken to "Pigeons, other birds" (and not to "poultry birds").
*we drop values that seem aggregates of other to avoid double counting
*"Beef and Buffalo Meat"
"Beeswax"."Beeswax"
*"Eggs Primary"
"Eggs, hen, in shell"."Eggs, hen, in shell"
*"Eggs, hen, in shell (number)"
"Eggs, other bird, in shell"."Eggs, other bird, in shell"
*"Eggs, other bird, in shell (number)"
*"Hair, horse"
**NOT "Hides, buffalo, fresh"."Hides, buffalo, fresh"
**NOT "Hides, cattle, fresh"."Hides, cattle, fresh"
"Honey, natural"."Honey, natural"
**NOT "Meat indigenous, ass"."Meat, ass"
**NOT "Meat indigenous, bird nes"."Meat, birds nes"
**NOT "Meat indigenous, buffalo"."Meat, buffaloes"
**NOT "Meat indigenous, camel"."Meat, camels"
**NOT "Meat indigenous, cattle"."Meat, cattle"
**NOT "Meat indigenous, chicken"."Meat, chicken"
**NOT "Meat indigenous, duck"."Meat, duck"
**NOT "Meat indigenous, geese"."Meat, goose and guinea fowl"
**NOT "Meat indigenous, goat"."Meat, goat"
**NOT "Meat indigenous, horse"."Meat, horse"
**NOT "Meat indigenous, mule"."Meat, mules"
**NOT "Meat indigenous, other camelids"."Meat, other camelids"
**NOT "Meat indigenous, pig"."Meat, pig"
*"Meat indigenous, poultry"
**NOT "Meat indigenous, rabbit"."Meat, rabbit"
**NOT "Meat indigenous, rodents"."Meat, other rodents"
**NOT "Meat indigenous, sheep"."Meat, sheep"
*"Meat indigenous, total"
**NOT "Meat indigenous, turkey"."Meat, turkey"

*instead of the indigenous meat above which is not part in FAOSTAT_ProducerPriceItems, we use the following, which is:
"Meat, ass"                  ."Meat, ass"
"Meat, bird nes"             ."Meat, birds nes"
"Meat, buffalo"              ."Meat, buffaloes"
"Meat, camel"                ."Meat, Camels"
"Meat, cattle"               ."Meat, cattle"
"Meat, chicken"              ."Meat, chicken"
"Meat, duck"                 ."Meat, duck"
"Meat, game"                 ."Meat, game"
"Meat, goat"                 ."Meat, goat"
"Meat, goose and guinea fowl"."Meat, goose and guinea fowl"
"Meat, horse"                ."Meat, horse"
"Meat, mule"                 ."Meat, Mules"
"Meat, nes"                  ."Meat, nes"
"Meat, other camelids"       ."Meat, Other Camelids"
"Meat, other rodents"        ."Meat, Other Rodents"
"Meat, pig"                  ."Meat, pig"
"Meat, rabbit"               ."Meat, rabbit"
"Meat, sheep"                ."Meat, sheep"
"Meat, turkey"               ."Meat, turkey"
*new meat items: till here

"Milk, whole fresh buffalo"."Milk, whole fresh buffalo"
"Milk, whole fresh camel"."Milk, whole fresh camel"
"Milk, whole fresh cow"."Milk, whole fresh cow"
"Milk, whole fresh goat"."Milk, whole fresh goat"
"Milk, whole fresh sheep"."Milk, whole fresh sheep"
*"Milk,Total"
**NOT "Offals, nes"."Offals Nes"
*"Pigeons, other birds"
*"Sheep and Goat Meat"
*"Silk-worm cocoons, reelable"
*"Skins, furs"
**NOT "Skins, goat, fresh"."Skins, goat, fresh"
**NOT "Skins, sheep, fresh"."Skins, sheep, fresh"
*"Skins, sheep, with wool"
*"Snails, not sea"
"Wool, greasy"."Wool, greasy"

/;



$ontext;
Set MatchProducerPriceItems_CropProdLiveAnimalsItemsOutputType(FAOSTAT_ProducerPriceItems,ActivitySOLmV5,OutputTypeSOLmV5)
/
"Agave fibres nes"."Agave fibres nes"."Main crop"
"Almonds, with shell"."Almonds, with shell"."Main crop"
"Anise, badian, fennel, coriander"."Anise, badian, fennel, coriander"."Main crop"
"Apples"."Apples"."Main crop"
"Apricots"."Apricots"."Main crop"
"Areca nuts"."Areca nuts"."Main crop"
"Artichokes"."Artichokes"."Main crop"
"Asparagus"."Asparagus"."Main crop"
"Avocados"."Avocados"."Main crop"
"Bambara beans"."Bambara beans"."Main crop"
"Bananas"."Bananas"."Main crop"
*"Bananas Cavendish".""."Main crop"
*"Bananas non-Cavendish".""."Main crop"
"Barley"."Barley"."Main crop"
"Bastfibres, other"."Bastfibres, other"."Main crop"
"Beans, dry"."Beans, dry"."Main crop"
"Beans, green"."Beans, green"."Main crop"
*"Beeswax".""."Main crop"
"Berries nes"."Berries nes"."Main crop"
"Blueberries"."Blueberries"."Main crop"
"Brazil nuts, with shell"."Brazil nuts, with shell"."Main crop"
"Broad beans, horse beans, dry"."Broad beans, horse beans, dry"."Main crop"
"Buckwheat"."Buckwheat"."Main crop"
"Cabbages and other brassicas"."Cabbages and other brassicas"."Main crop"
"Canary seed"."Canary seed"."Main crop"
"Carobs"."Carobs"."Main crop"
"Carrots and turnips"."Carrots and turnips"."Main crop"
"Cashew nuts, with shell"."Cashew nuts, with shell"."Main crop"
"Cashewapple"."Cashewapple"."Main crop"
"Cassava"."Cassava"."Main crop"
*""."Cassava leaves"."Main crop"
"Castor oil seed"."Castor oil seed"."Main crop"
"Cauliflowers and broccoli"."Cauliflowers and broccoli"."Main crop"
*""."Cereals (Rice Milled Eqv)"."Main crop"
"Cereals, nes"."Cereals, nes"."Main crop"
*""."Cereals,Total"."Main crop"
"Cherries"."Cherries"."Main crop"
"Cherries, sour"."Cherries, sour"."Main crop"
"Chestnut"."Chestnut"."Main crop"
"Chick peas"."Chick peas"."Main crop"
"Chicory roots"."Chicory roots"."Main crop"
"Chillies and peppers, dry"."Chillies and peppers, dry"."Main crop"
"Chillies and peppers, green"."Chillies and peppers, green"."Main crop"
"Cinnamon (canella)"."Cinnamon (canella)"."Main crop"
*""."Citrus Fruit,Total"."Main crop"
"Cloves"."Cloves"."Main crop"
*""."Coarse Grain, Total"."Main crop"
"Cocoa, beans"."Cocoa, beans"."Main crop"
"Coconuts"."Coconuts"."Main crop"
"Coffee, green"."Coffee, green"."Main crop"
*""."Coir"."Main crop"
*"Cooking bananas".""."Main crop"
"Cotton lint"."Cotton lint"."Main crop"
"Cottonseed"."Cottonseed"."Main crop"
"Cow peas, dry"."Cow peas, dry"."Main crop"
"Cranberries"."Cranberries"."Main crop"
"Cucumbers and gherkins"."Cucumbers and gherkins"."Main crop"
"Currants"."Currants"."Main crop"
"Dates"."Dates"."Main crop"
"Eggplants (aubergines)"."Eggplants (aubergines)"."Main crop"
"Fibre crops nes"."Fibre crops nes"."Main crop"
*""."Fibre Crops Primary"."Main crop"
"Figs"."Figs"."Main crop"
"Flax fibre and tow"."Flax fibre and tow"."Main crop"
"Fonio"."Fonio"."Main crop"
*""."Fruit excl Melons,Total"."Main crop"
"Fruit, citrus nes"."Fruit, citrus nes"."Main crop"
"Fruit, fresh nes"."Fruit, fresh nes"."Main crop"
"Fruit, pome nes"."Fruit, pome nes"."Main crop"
"Fruit, stone nes"."Fruit, stone nes"."Main crop"
"Fruit, tropical fresh nes"."Fruit, tropical fresh nes"."Main crop"
"Garlic"."Garlic"."Main crop"
"Ginger"."Ginger"."Main crop"
"Gooseberries"."Gooseberries"."Main crop"
"Grain, mixed"."Grain, mixed"."Main crop"
"Grapefruit (inc. pomelos)"."Grapefruit (inc. pomelos)"."Main crop"
"Grapes"."Grapes"."Main crop"
"Groundnuts, with shell"."Groundnuts, with shell"."Main crop"
"Gums, natural"."Gums, natural"."Main crop"
"Hazelnuts, with shell"."Hazelnuts, with shell"."Main crop"
"Hemp tow waste"."Hemp tow waste"."Main crop"
"Hempseed"."Hempseed"."Main crop"
"Hops"."Hops"."Main crop"
"Jojoba seed"."Jojoba seed"."Main crop"
"Jute"."Jute"."Main crop"
*""."Jute & Jute-like Fibres"."Main crop"
*""."Kapok fibre"."Main crop"
"Kapok fruit"."Kapok fruit"."Main crop"
*""."Kapokseed in shell"."Main crop"
"Karite nuts (sheanuts)"."Karite nuts (sheanuts)"."Main crop"
"Kiwi fruit"."Kiwi fruit"."Main crop"
"Kola nuts"."Kola nuts"."Main crop"
"Leeks, other alliaceous vegetables"."Leeks, other alliaceous vegetables"."Main crop"
"Lemons and limes"."Lemons and limes"."Main crop"
"Lentils"."Lentils"."Main crop"
"Lettuce and chicory"."Lettuce and chicory"."Main crop"
"Linseed"."Linseed"."Main crop"
"Lupins"."Lupins"."Main crop"
"Maize"."Maize"."Main crop"
"Maize, green"."Maize, green"."Main crop"
"Mangoes, mangosteens, guavas"."Mangoes, mangosteens, guavas"."Main crop"
"Manila fibre (abaca)"."Manila fibre (abaca)"."Main crop"
"Maté"."Maté"."Main crop"
"Melons, other (inc.cantaloupes)"."Melons, other (inc.cantaloupes)"."Main crop"
"Melonseed"."Melonseed"."Main crop"
"Millet"."Millet"."Main crop"
"Mushrooms and truffles"."Mushrooms and truffles"."Main crop"
"Mustard seed"."Mustard seed"."Main crop"
"Nutmeg, mace and cardamoms"."Nutmeg, mace and cardamoms"."Main crop"
"Nuts, nes"."Nuts, nes"."Main crop"
"Oats"."Oats"."Main crop"
"Oil, palm"."Oil, palm"."Main crop"
"Oil, palm fruit"."Oil, palm fruit"."Main crop"
*""."Oilcakes Equivalent"."Main crop"
*"Oil, stillingia".""."Main crop"
*""."Oilcrops Primary"."Main crop"
"Oilseeds nes"."Oilseeds nes"."Main crop"
"Okra"."Okra"."Main crop"
"Olives"."Olives"."Main crop"
"Onions, dry"."Onions, dry"."Main crop"
"Onions, shallots, green"."Onions, shallots, green"."Main crop"
"Oranges"."Oranges"."Main crop"
"Palm kernels"."Palm kernels"."Main crop"
"Papayas"."Papayas"."Main crop"
"Peaches and nectarines"."Peaches and nectarines"."Main crop"
"Pears"."Pears"."Main crop"
"Peas, dry"."Peas, dry"."Main crop"
"Peas, green"."Peas, green"."Main crop"
"Pepper (piper spp.)"."Pepper (piper spp.)"."Main crop"
"Peppermint"."Peppermint"."Main crop"
"Persimmons"."Persimmons"."Main crop"
"Pigeon peas"."Pigeon peas"."Main crop"
"Pineapples"."Pineapples"."Main crop"
"Pistachios"."Pistachios"."Main crop"
*"Plantains".""."Main crop"
"Plantains and others"."Plantains and others"."Main crop"
"Plums and sloes"."Plums and sloes"."Main crop"
*"Popcorn".""."Main crop"
"Poppy seed"."Poppy seed"."Main crop"
"Potatoes"."Potatoes"."Main crop"
"Pulses, nes"."Pulses, nes"."Main crop"
*""."Pulses,Total"."Main crop"
"Pumpkins, squash and gourds"."Pumpkins, squash and gourds"."Main crop"
"Pyrethrum, dried"."Pyrethrum, dried"."Main crop"
"Quinces"."Quinces"."Main crop"
"Quinoa"."Quinoa"."Main crop"
"Ramie"."Ramie"."Main crop"
"Rapeseed"."Rapeseed"."Main crop"
"Raspberries"."Raspberries"."Main crop"
"Rice, paddy"."Rice, paddy"."Main crop"
"Roots and tubers, nes"."Roots and tubers, nes"."Main crop"
"Rubber, natural"."Roots and Tubers,Total"."Main crop"
*""."Rubber, natural"."Main crop"
"Rye"."Rye"."Main crop"
"Safflower seed"."Safflower seed"."Main crop"
"Seed cotton"."Seed cotton"."Main crop"
"Sesame seed"."Sesame seed"."Main crop"
*"Silk-worm cocoons, reelable".""."Main crop"
"Sisal"."Sisal"."Main crop"
"Sorghum"."Sorghum"."Main crop"
"Soybeans"."Soybeans"."Main crop"
"Spices, nes"."Spices, nes"."Main crop"
"Spinach"."Spinach"."Main crop"
"Strawberries"."Strawberries"."Main crop"
"String beans"."String beans"."Main crop"
"Sugar beet"."Sugar beet"."Main crop"
"Sugar cane"."Sugar cane"."Main crop"
"Sugar crops, nes"."Sugar crops, nes"."Main crop"
"Sunflower seed"."Sunflower seed"."Main crop"
"Sweet potatoes"."Sweet potatoes"."Main crop"
"Tallowtree seed"."Tallowtree seed"."Main crop"
"Tangerines, mandarins, clementines, satsumas"."Tangerines, mandarins, clementines, satsumas"."Main crop"
"Taro (cocoyam)"."Taro (cocoyam)"."Main crop"
"Tea"."Tea"."Main crop"
"Tea nes"."Tobacco, unmanufactured"."Main crop"
"Tobacco, unmanufactured"."Tomatoes"."Main crop"
"Tomatoes"."Treenuts,Total"."Main crop"
"Triticale"."Triticale"."Main crop"
"Tung nuts"."Tung nuts"."Main crop"
"Vanilla"."Vanilla"."Main crop"
*"Vegetable tallow".""."Main crop"
*""."Vegetables Primary"."Main crop"
*""."Vegetables&Melons, Total"."Main crop"
"Vegetables, fresh nes"."Vegetables, fresh nes"."Main crop"
"Vegetables, leguminous nes"."Vegetables, leguminous nes"."Main crop"
"Vetches"."Vetches"."Main crop"
"Walnuts, with shell"."Walnuts, with shell"."Main crop"
"Watermelons"."Watermelons"."Main crop"
"Wheat"."Wheat"."Main crop"
*"Wool, greasy".""."Main crop"
"Yams"."Yams"."Main crop"
"Yautia (cocoyam)"."Yautia (cocoyam)"."Main crop"
"Milk, whole fresh buffalo"."Buffaloes"."Milk"
"Milk, whole fresh camel"."Camels"."Milk"
"Milk, whole fresh cow"."Cattle"."Milk"
"Milk, whole fresh goat"."Goats"."Milk"
"Milk, whole fresh sheep"."Sheep"."Milk"
"Eggs, hen, in shell"."Chickens"."Eggs"
"Eggs, other bird, in shell"."Pigeons, other birds"."Eggs"
"Meat, ass"."Asses"."Meat"
"Meat, bird nes"."Pigeons, other birds"."Meat"
"Meat, buffalo"."Buffaloes"."Meat"
"Meat, camel"."Camels"."Meat"
"Meat, cattle"."Cattle"."Meat"
"Meat, chicken"."Chickens"."Meat"
"Meat, duck"."Ducks"."Meat"
*"Meat, game".""."Meat"
"Meat, goat"."Goats"."Meat"
"Meat, goose and guinea fowl"."Geese and guinea fowls"."Meat"
"Meat, horse"."Horses"."Meat"
"Meat, mule"."Mules"."Meat"
"Meat, nes"."Animals live nes"."Meat"
"Meat, other camelids"."Camelids, other"."Meat"
"Meat, other rodents"."Rodents, other"."Meat"
"Meat, pig"."Pigs"."Meat"
"Meat, rabbit"."Rabbits and hares"."Meat"
"Meat, sheep"."Sheep"."Meat"
"Meat, turkey"."Turkeys"."Meat"
"Honey, natural"."Beehives"."Honey"
*"Snails, not sea".""."Meat"
*Meat live weight, ass
*Meat live weight, buffalo
*Meat live weight, camel
*Meat live weight, camelids, other
*Meat live weight, cattle
*Meat live weight, chicken
*Meat live weight, duck
*Meat live weight, goat
*Meat live weight, goose
*Meat live weight, horse
*Meat live weight, mule
*Meat live weight, pig
*Meat live weight, poultry, other
*Meat live weight, rabbit
*Meat live weight, rodents
*Meat live weight, sheep
*Meat live weight, turkey
/;
$offtext;


*3.2) Link to the core model parameters


Commod_OtherChar(Regions,Commodities,"Producer price ($)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_ProducerPriceItems,FAOSTAT_Countries)$(MatchProducerPriceItems_Commodities(FAOSTAT_ProducerPriceItems,Commodities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 FAOSTAT_ProducerPrice(FAOSTAT_Countries,FAOSTAT_ProducerPriceItems,"Producer Price (USD/tonne)","AverageBasisYear","USD"));

$ontext;
After this we have the following in SOLm-entities:

Commod_OtherChar(Regions,Commodities,"Producer price ($)","AllProdSyst","AllProdCond")

Regions          is      FAOSTAT_Countries
Commodities      is      FAOSTAT_ProducerPriceItems

*XXX STILL TO BE DONE:
TO BE DONE: build production weighted averages over the baseyears!!!

$offtext;



