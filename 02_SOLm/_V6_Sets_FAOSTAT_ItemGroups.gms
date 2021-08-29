PUTCLOSE con,"_V6_Sets_FAOSTAT_ItemGroups";

$ontext;
GENERAL DESCRIPTION
This file declares the sets for groups of activity and commodity items as defined in FAOSTAT

DETAILED TABLE OF CONTENTS
the following sets are declared below:
- 1) Sets for groups of activities and commodities as reported in FAOSTAT
         -1.1) Crop production
         -1.2) Animal products
         -1.3) Trade in crop and livestock products
- 2) Sets for groups of activities and commodities as used in old SOLm versions (up to V4) - and here in V5 for filing in some data

SHORT SUMMARY:
In this code file, the following sets are defined:
Set FAOSTAT_CropProductionItemGroups Crop item groups as included in FAOSTAT
Set FAOSTAT_CropProductionItemGroups_CompleteExclusive(FAOSTAT_CropProductionItemGroups) Sub-set containing mutually exclusive crop item groups as included in FAOSTAT
Set FAOSTAT_CropProductionItemsInItemGroups(FAOSTAT_CropProductionItemGroups,FAOSTAT_CropProductionItems) Two dimensional set containing all crop groups matched to single crop items
Set FAOSTAT_LivestockPrimaryItems_Meat(FAOSTAT_LivestockPrimaryItems) Sub-set containing MEAT items only in livestock primary items
Set FAOSTAT_LivestockPrimaryItems_PoultryMeat(FAOSTAT_LivestockPrimaryItems) Sub-set containing POULTRY MEAT items only in livestock primary items
Set FAOSTAT_LivestockPrimaryItems_Milk(FAOSTAT_LivestockPrimaryItems) Sub-set containing MILK items only in livestock primary items
Set FAOSTAT_LivestockPrimaryItems_Eggs(FAOSTAT_LivestockPrimaryItems) Sub-set containing EGG items only in livestock primary items
Set FAOSTAT_LivestockPrimaryItems_HidesSkinsHair(FAOSTAT_LivestockPrimaryItems) Sub-set containing Hides-Skins-Hair items only in livestock primary items

Set SOLmOld_CropProductionItemGroups OLD crop item groups as used in earlier versions of SOLm (up to V4 and for reading in some data in V5)
Set SOLmOld_Fruits(FAOSTAT_CropProductionItems) FRUIT crop items building the OLD SOLm fruit group
Set SOLmOld_Treenuts(FAOSTAT_CropProductionItems) TREENUT crop items building the OLD SOLm treenut group
Set SOLmOld_Grains(FAOSTAT_CropProductionItems) GRAINS crop items building the OLD SOLm grains group
Set SOLmOld_Pulses(FAOSTAT_CropProductionItems) PULSES crop items building the OLD SOLm pulses group
Set SOLmOld_Oil_Crops(FAOSTAT_CropProductionItems) OIL CROP crop items building the OLD SOLm oil crop group
Set SOLmOld_Starchy_Roots(FAOSTAT_CropProductionItems) STARCHY ROOTS crop items building the OLD SOLm starchy roots group
Set SOLmOld_Sugars_And_Sweeteners(FAOSTAT_CropProductionItems) SUGARS AND SWEETENERS crop items building the OLD SOLm sugars and sweeteners group
Set SOLmOld_Vegetables(FAOSTAT_CropProductionItems) VEGETABLES crop items building the OLD SOLm vegetables group
Set SOLmOld_Stimulants_Spices(FAOSTAT_CropProductionItems) STIMULANTS AND SPICES crop items building the OLD SOLm stimulants and spices group
Set SOLmOld_Fibres_Rubber(FAOSTAT_CropProductionItems) FIBRES AND RUBBER crop items building the OLD SOLm fibres and rubber group
Set SOLmOld_ForReadingDataBerries(FAOSTAT_CropProductionItems) BERRIES crop items building the OLD SOLm berries group
Set SOLmOld_ForReadingDataNonLeguminousVegetables(FAOSTAT_CropProductionItems) NON-LEGUMINOUS VEGETABLES crop items building the OLD SOLm non-leguminous vegetables group
Set SOLmOld_ForReadingDataLeguminousVegetables(FAOSTAT_CropProductionItems) LEGUMINOUS VEGETABLES crop items building the OLD SOLm leguminous vegetables group

ATTENTION:
"Mate" is sometimes read as "MatÃ©" from the csv-files, respectiely already from FAOSTAT into csv. - Check for this and correct where needed.
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Sets for groups of activities and commodities as reported in FAOSTAT
*1.1) Crop production

Set FAOSTAT_CropProductionItemGroups Crop item groups as included in FAOSTAT
*as contained in the file FAOSTAT_CropProductionItemGroupsDefinition_15_12_2017.csv
/
"Cereals,Total"
"Citrus Fruit,Total"
"Coarse Grain, Total"
"Crops Primary"
"Fibre Crops Primary"
"Fruit excl Melons,Total"
"Fruit Incl Melons"
"Fruit Primary"
"Jute & Jute-like Fibres"
"Oilcakes Equivalent"
"Oilcrops Primary"
"Pulses,Total"
"Roots and Tubers,Total"
"Treenuts,Total"
"Vegetables Primary"
"Vegetables&Melons, Total"
/;

*define a subset of in total complete but mutually exclusive sets
Set FAOSTAT_CropProductionItemGroups_CompleteExclusive(FAOSTAT_CropProductionItemGroups) Sub-set containing mutually exclusive crop item groups as included in FAOSTAT
/
"Cereals,Total"
"Fibre Crops Primary"
"Fruit Primary"
"Jute & Jute-like Fibres"
"Oilcrops Primary"
"Pulses,Total"
"Roots and Tubers,Total"
"Treenuts,Total"
"Vegetables Primary"
/;


Set FAOSTAT_CropProductionItemsInItemGroups(FAOSTAT_CropProductionItemGroups,FAOSTAT_CropProductionItems) Two dimensional set containing all crop groups matched to single crop items
*as contained in the file FAOSTAT_CropProductionItemGroupsDefinition_15_12_2017.csv
/
*"Item Group"."Item"
"Cereals,Total"."Barley"
"Cereals,Total"."Buckwheat"
"Cereals,Total"."Canary seed"
"Cereals,Total"."Cereals, nes"
"Cereals,Total"."Fonio"
"Cereals,Total"."Grain, mixed"
"Cereals,Total"."Maize"
"Cereals,Total"."Millet"
"Cereals,Total"."Oats"
"Cereals,Total"."Quinoa"
"Cereals,Total"."Rice, paddy"
"Cereals,Total"."Rye"
"Cereals,Total"."Sorghum"
"Cereals,Total"."Triticale"
"Cereals,Total"."Wheat"
"Citrus Fruit,Total"."Fruit, citrus nes"
"Citrus Fruit,Total"."Grapefruit (inc. pomelos)"
"Citrus Fruit,Total"."Lemons and limes"
"Citrus Fruit,Total"."Oranges"
"Citrus Fruit,Total"."Tangerines, mandarins, clementines, satsumas"
"Coarse Grain, Total"."Barley"
"Coarse Grain, Total"."Buckwheat"
"Coarse Grain, Total"."Canary seed"
"Coarse Grain, Total"."Cereals, nes"
"Coarse Grain, Total"."Fonio"
"Coarse Grain, Total"."Grain, mixed"
"Coarse Grain, Total"."Maize"
"Coarse Grain, Total"."Millet"
"Coarse Grain, Total"."Oats"
"Coarse Grain, Total"."Quinoa"
"Coarse Grain, Total"."Rye"
"Coarse Grain, Total"."Sorghum"
"Coarse Grain, Total"."Triticale"
"Crops Primary"."Agave fibres nes"
"Crops Primary"."Almonds, with shell"
"Crops Primary"."Anise, badian, fennel, coriander"
"Crops Primary"."Apples"
"Crops Primary"."Apricots"
"Crops Primary"."Areca nuts"
"Crops Primary"."Artichokes"
"Crops Primary"."Asparagus"
"Crops Primary"."Avocados"
"Crops Primary"."Bambara beans"
"Crops Primary"."Bananas"
"Crops Primary"."Barley"
"Crops Primary"."Bastfibres, other"
"Crops Primary"."Beans, dry"
"Crops Primary"."Beans, green"
"Crops Primary"."Berries nes"
"Crops Primary"."Blueberries"
"Crops Primary"."Brazil nuts, with shell"
"Crops Primary"."Broad beans, horse beans, dry"
"Crops Primary"."Buckwheat"
"Crops Primary"."Cabbages and other brassicas"
"Crops Primary"."Canary seed"
"Crops Primary"."Carobs"
"Crops Primary"."Carrots and turnips"
"Crops Primary"."Cashew nuts, with shell"
"Crops Primary"."Cashewapple"
"Crops Primary"."Cassava"
"Crops Primary"."Castor oil seed"
"Crops Primary"."Cauliflowers and broccoli"
"Crops Primary"."Cereals, nes"
"Crops Primary"."Cherries"
"Crops Primary"."Cherries, sour"
"Crops Primary"."Chestnut"
"Crops Primary"."Chick peas"
"Crops Primary"."Chicory roots"
"Crops Primary"."Chillies and peppers, dry"
"Crops Primary"."Chillies and peppers, green"
"Crops Primary"."Cinnamon (canella)"
"Crops Primary"."Cloves"
"Crops Primary"."Cocoa, beans"
"Crops Primary"."Coconuts"
"Crops Primary"."Coffee, green"
"Crops Primary"."Cow peas, dry"
"Crops Primary"."Cranberries"
"Crops Primary"."Cucumbers and gherkins"
"Crops Primary"."Currants"
"Crops Primary"."Dates"
"Crops Primary"."Eggplants (aubergines)"
"Crops Primary"."Fibre crops nes"
"Crops Primary"."Figs"
"Crops Primary"."Flax fibre and tow"
"Crops Primary"."Fonio"
"Crops Primary"."Fruit, citrus nes"
"Crops Primary"."Fruit, fresh nes"
"Crops Primary"."Fruit, pome nes"
"Crops Primary"."Fruit, stone nes"
"Crops Primary"."Fruit, tropical fresh nes"
"Crops Primary"."Garlic"
"Crops Primary"."Ginger"
"Crops Primary"."Gooseberries"
"Crops Primary"."Grain, mixed"
"Crops Primary"."Grapefruit (inc. pomelos)"
"Crops Primary"."Grapes"
"Crops Primary"."Groundnuts, with shell"
"Crops Primary"."Gums, natural"
"Crops Primary"."Hazelnuts, with shell"
"Crops Primary"."Hemp tow waste"
"Crops Primary"."Hempseed"
"Crops Primary"."Hops"
"Crops Primary"."Jojoba seed"
"Crops Primary"."Jute"
"Crops Primary"."Kapok fruit"
"Crops Primary"."Karite nuts (sheanuts)"
"Crops Primary"."Kiwi fruit"
"Crops Primary"."Kola nuts"
"Crops Primary"."Leeks, other alliaceous vegetables"
"Crops Primary"."Lemons and limes"
"Crops Primary"."Lentils"
"Crops Primary"."Lettuce and chicory"
"Crops Primary"."Linseed"
"Crops Primary"."Lupins"
"Crops Primary"."Maize"
"Crops Primary"."Maize, green"
"Crops Primary"."Mangoes, mangosteens, guavas"
"Crops Primary"."Manila fibre (abaca)"
"Crops Primary"."Maté"
"Crops Primary"."Melons, other (inc.cantaloupes)"
"Crops Primary"."Melonseed"
"Crops Primary"."Millet"
"Crops Primary"."Mushrooms and truffles"
"Crops Primary"."Mustard seed"
"Crops Primary"."Nutmeg, mace and cardamoms"
"Crops Primary"."Nuts, nes"
"Crops Primary"."Oats"
"Crops Primary"."Oil, palm fruit"
"Crops Primary"."Oilseeds nes"
"Crops Primary"."Okra"
"Crops Primary"."Olives"
"Crops Primary"."Onions, dry"
"Crops Primary"."Onions, shallots, green"
"Crops Primary"."Oranges"
"Crops Primary"."Papayas"
"Crops Primary"."Peaches and nectarines"
"Crops Primary"."Pears"
"Crops Primary"."Peas, dry"
"Crops Primary"."Peas, green"
"Crops Primary"."Pepper (piper spp.)"
"Crops Primary"."Peppermint"
"Crops Primary"."Persimmons"
"Crops Primary"."Pigeon peas"
"Crops Primary"."Pineapples"
"Crops Primary"."Pistachios"
"Crops Primary"."Plantains and others"
"Crops Primary"."Plums and sloes"
"Crops Primary"."Poppy seed"
"Crops Primary"."Potatoes"
"Crops Primary"."Pulses, nes"
"Crops Primary"."Pumpkins, squash and gourds"
"Crops Primary"."Pyrethrum, dried"
"Crops Primary"."Quinces"
"Crops Primary"."Quinoa"
"Crops Primary"."Ramie"
"Crops Primary"."Rapeseed"
"Crops Primary"."Raspberries"
"Crops Primary"."Rice, paddy"
"Crops Primary"."Roots and tubers, nes"
"Crops Primary"."Rubber, natural"
"Crops Primary"."Rye"
"Crops Primary"."Safflower seed"
"Crops Primary"."Seed cotton"
"Crops Primary"."Sesame seed"
"Crops Primary"."Sisal"
"Crops Primary"."Sorghum"
"Crops Primary"."Soybeans"
"Crops Primary"."Spices, nes"
"Crops Primary"."Spinach"
"Crops Primary"."Strawberries"
"Crops Primary"."String beans"
"Crops Primary"."Sugar beet"
"Crops Primary"."Sugar cane"
"Crops Primary"."Sugar crops, nes"
"Crops Primary"."Sunflower seed"
"Crops Primary"."Sweet potatoes"
"Crops Primary"."Tallowtree seed"
"Crops Primary"."Tangerines, mandarins, clementines, satsumas"
"Crops Primary"."Taro (cocoyam)"
"Crops Primary"."Tea"
"Crops Primary"."Tobacco, unmanufactured"
"Crops Primary"."Tomatoes"
"Crops Primary"."Triticale"
"Crops Primary"."Tung nuts"
"Crops Primary"."Vanilla"
"Crops Primary"."Vegetables, fresh nes"
"Crops Primary"."Vegetables, leguminous nes"
"Crops Primary"."Vetches"
"Crops Primary"."Walnuts, with shell"
"Crops Primary"."Watermelons"
"Crops Primary"."Wheat"
"Crops Primary"."Yams"
"Crops Primary"."Yautia (cocoyam)"
"Fibre Crops Primary"."Agave fibres nes"
"Fibre Crops Primary"."Bastfibres, other"
"Fibre Crops Primary"."Cotton lint"
"Fibre Crops Primary"."Fibre crops nes"
"Fibre Crops Primary"."Flax fibre and tow"
"Fibre Crops Primary"."Hemp tow waste"
"Fibre Crops Primary"."Jute"
"Fibre Crops Primary"."Kapok fruit"
"Fibre Crops Primary"."Manila fibre (abaca)"
"Fibre Crops Primary"."Ramie"
"Fibre Crops Primary"."Seed cotton"
"Fibre Crops Primary"."Sisal"
"Fruit excl Melons,Total"."Apples"
"Fruit excl Melons,Total"."Apricots"
"Fruit excl Melons,Total"."Avocados"
"Fruit excl Melons,Total"."Bananas"
"Fruit excl Melons,Total"."Berries nes"
"Fruit excl Melons,Total"."Blueberries"
"Fruit excl Melons,Total"."Carobs"
"Fruit excl Melons,Total"."Cashewapple"
"Fruit excl Melons,Total"."Cherries"
"Fruit excl Melons,Total"."Cherries, sour"
"Fruit excl Melons,Total"."Cranberries"
"Fruit excl Melons,Total"."Currants"
"Fruit excl Melons,Total"."Dates"
"Fruit excl Melons,Total"."Figs"
"Fruit excl Melons,Total"."Fruit, citrus nes"
"Fruit excl Melons,Total"."Fruit, fresh nes"
"Fruit excl Melons,Total"."Fruit, pome nes"
"Fruit excl Melons,Total"."Fruit, stone nes"
"Fruit excl Melons,Total"."Fruit, tropical fresh nes"
"Fruit excl Melons,Total"."Gooseberries"
"Fruit excl Melons,Total"."Grapefruit (inc. pomelos)"
"Fruit excl Melons,Total"."Grapes"
"Fruit excl Melons,Total"."Kiwi fruit"
"Fruit excl Melons,Total"."Lemons and limes"
"Fruit excl Melons,Total"."Mangoes, mangosteens, guavas"
"Fruit excl Melons,Total"."Oranges"
"Fruit excl Melons,Total"."Papayas"
"Fruit excl Melons,Total"."Peaches and nectarines"
"Fruit excl Melons,Total"."Pears"
"Fruit excl Melons,Total"."Persimmons"
"Fruit excl Melons,Total"."Pineapples"
"Fruit excl Melons,Total"."Plantains and others"
"Fruit excl Melons,Total"."Plums and sloes"
"Fruit excl Melons,Total"."Quinces"
"Fruit excl Melons,Total"."Raspberries"
"Fruit excl Melons,Total"."Strawberries"
"Fruit excl Melons,Total"."Tangerines, mandarins, clementines, satsumas"
"Fruit Incl Melons"."Apples"
"Fruit Incl Melons"."Apricots"
"Fruit Incl Melons"."Avocados"
"Fruit Incl Melons"."Bananas"
"Fruit Incl Melons"."Berries nes"
"Fruit Incl Melons"."Blueberries"
"Fruit Incl Melons"."Carobs"
"Fruit Incl Melons"."Cashewapple"
"Fruit Incl Melons"."Cherries"
"Fruit Incl Melons"."Cherries, sour"
"Fruit Incl Melons"."Cranberries"
"Fruit Incl Melons"."Currants"
"Fruit Incl Melons"."Dates"
"Fruit Incl Melons"."Figs"
"Fruit Incl Melons"."Fruit, citrus nes"
"Fruit Incl Melons"."Fruit, fresh nes"
"Fruit Incl Melons"."Fruit, pome nes"
"Fruit Incl Melons"."Fruit, stone nes"
"Fruit Incl Melons"."Fruit, tropical fresh nes"
"Fruit Incl Melons"."Gooseberries"
"Fruit Incl Melons"."Grapefruit (inc. pomelos)"
"Fruit Incl Melons"."Grapes"
"Fruit Incl Melons"."Kiwi fruit"
"Fruit Incl Melons"."Lemons and limes"
"Fruit Incl Melons"."Mangoes, mangosteens, guavas"
"Fruit Incl Melons"."Melons, other (inc.cantaloupes)"
"Fruit Incl Melons"."Oranges"
"Fruit Incl Melons"."Papayas"
"Fruit Incl Melons"."Peaches and nectarines"
"Fruit Incl Melons"."Pears"
"Fruit Incl Melons"."Persimmons"
"Fruit Incl Melons"."Pineapples"
"Fruit Incl Melons"."Plantains and others"
"Fruit Incl Melons"."Plums and sloes"
"Fruit Incl Melons"."Quinces"
"Fruit Incl Melons"."Raspberries"
"Fruit Incl Melons"."Strawberries"
"Fruit Incl Melons"."Tangerines, mandarins, clementines, satsumas"
"Fruit Incl Melons"."Watermelons"
"Fruit Primary"."Apples"
"Fruit Primary"."Apricots"
"Fruit Primary"."Avocados"
"Fruit Primary"."Bananas"
"Fruit Primary"."Berries nes"
"Fruit Primary"."Blueberries"
"Fruit Primary"."Carobs"
"Fruit Primary"."Cashewapple"
"Fruit Primary"."Cherries"
"Fruit Primary"."Cherries, sour"
"Fruit Primary"."Cranberries"
"Fruit Primary"."Currants"
"Fruit Primary"."Dates"
"Fruit Primary"."Figs"
"Fruit Primary"."Fruit, citrus nes"
"Fruit Primary"."Fruit, fresh nes"
"Fruit Primary"."Fruit, pome nes"
"Fruit Primary"."Fruit, stone nes"
"Fruit Primary"."Fruit, tropical fresh nes"
"Fruit Primary"."Gooseberries"
"Fruit Primary"."Grapefruit (inc. pomelos)"
"Fruit Primary"."Grapes"
"Fruit Primary"."Kiwi fruit"
"Fruit Primary"."Lemons and limes"
"Fruit Primary"."Mangoes, mangosteens, guavas"
"Fruit Primary"."Oranges"
"Fruit Primary"."Papayas"
"Fruit Primary"."Peaches and nectarines"
"Fruit Primary"."Pears"
"Fruit Primary"."Persimmons"
"Fruit Primary"."Pineapples"
"Fruit Primary"."Plantains and others"
"Fruit Primary"."Plums and sloes"
"Fruit Primary"."Quinces"
"Fruit Primary"."Raspberries"
"Fruit Primary"."Strawberries"
"Fruit Primary"."Tangerines, mandarins, clementines, satsumas"
"Jute & Jute-like Fibres"."Bastfibres, other"
"Jute & Jute-like Fibres"."Jute"
"Oilcakes Equivalent"."Coconuts"
"Oilcakes Equivalent"."Cottonseed"
"Oilcakes Equivalent"."Groundnuts, with shell"
"Oilcakes Equivalent"."Hempseed"
"Oilcakes Equivalent"."Kapok fruit"
"Oilcakes Equivalent"."Linseed"
"Oilcakes Equivalent"."Melonseed"
"Oilcakes Equivalent"."Mustard seed"
"Oilcakes Equivalent"."Oil, palm fruit"
"Oilcakes Equivalent"."Oilseeds nes"
"Oilcakes Equivalent"."Palm kernels"
"Oilcakes Equivalent"."Poppy seed"
"Oilcakes Equivalent"."Rapeseed"
"Oilcakes Equivalent"."Safflower seed"
"Oilcakes Equivalent"."Seed cotton"
"Oilcakes Equivalent"."Sesame seed"
"Oilcakes Equivalent"."Soybeans"
"Oilcakes Equivalent"."Sunflower seed"
"Oilcrops Primary"."Castor oil seed"
"Oilcrops Primary"."Coconuts"
"Oilcrops Primary"."Cottonseed"
"Oilcrops Primary"."Groundnuts, with shell"
"Oilcrops Primary"."Hempseed"
"Oilcrops Primary"."Jojoba seed"
"Oilcrops Primary"."Kapok fruit"
"Oilcrops Primary"."Karite nuts (sheanuts)"
"Oilcrops Primary"."Linseed"
"Oilcrops Primary"."Melonseed"
"Oilcrops Primary"."Mustard seed"
"Oilcrops Primary"."Oil, palm"
"Oilcrops Primary"."Oil, palm fruit"
"Oilcrops Primary"."Oilseeds nes"
"Oilcrops Primary"."Olives"
"Oilcrops Primary"."Palm kernels"
"Oilcrops Primary"."Poppy seed"
"Oilcrops Primary"."Rapeseed"
"Oilcrops Primary"."Safflower seed"
"Oilcrops Primary"."Seed cotton"
"Oilcrops Primary"."Sesame seed"
"Oilcrops Primary"."Soybeans"
"Oilcrops Primary"."Sunflower seed"
"Oilcrops Primary"."Tallowtree seed"
"Oilcrops Primary"."Tung nuts"
"Pulses,Total"."Bambara beans"
"Pulses,Total"."Beans, dry"
"Pulses,Total"."Broad beans, horse beans, dry"
"Pulses,Total"."Chick peas"
"Pulses,Total"."Cow peas, dry"
"Pulses,Total"."Lentils"
"Pulses,Total"."Lupins"
"Pulses,Total"."Peas, dry"
"Pulses,Total"."Pigeon peas"
"Pulses,Total"."Pulses, nes"
"Pulses,Total"."Vetches"
"Roots and Tubers,Total"."Cassava"
"Roots and Tubers,Total"."Potatoes"
"Roots and Tubers,Total"."Roots and tubers, nes"
"Roots and Tubers,Total"."Sweet potatoes"
"Roots and Tubers,Total"."Taro (cocoyam)"
"Roots and Tubers,Total"."Yams"
"Roots and Tubers,Total"."Yautia (cocoyam)"
"Treenuts,Total"."Almonds, with shell"
"Treenuts,Total"."Brazil nuts, with shell"
"Treenuts,Total"."Cashew nuts, with shell"
"Treenuts,Total"."Chestnut"
"Treenuts,Total"."Hazelnuts, with shell"
"Treenuts,Total"."Nuts, nes"
"Treenuts,Total"."Pistachios"
"Treenuts,Total"."Walnuts, with shell"
"Vegetables Primary"."Artichokes"
"Vegetables Primary"."Asparagus"
"Vegetables Primary"."Beans, green"
"Vegetables Primary"."Cabbages and other brassicas"
"Vegetables Primary"."Carrots and turnips"
"Vegetables Primary"."Cassava leaves"
"Vegetables Primary"."Cauliflowers and broccoli"
"Vegetables Primary"."Chillies and peppers, green"
"Vegetables Primary"."Cucumbers and gherkins"
"Vegetables Primary"."Eggplants (aubergines)"
"Vegetables Primary"."Garlic"
"Vegetables Primary"."Leeks, other alliaceous vegetables"
"Vegetables Primary"."Lettuce and chicory"
"Vegetables Primary"."Maize, green"
"Vegetables Primary"."Melons, other (inc.cantaloupes)"
"Vegetables Primary"."Mushrooms and truffles"
"Vegetables Primary"."Okra"
"Vegetables Primary"."Onions, dry"
"Vegetables Primary"."Onions, shallots, green"
"Vegetables Primary"."Peas, green"
"Vegetables Primary"."Pumpkins, squash and gourds"
"Vegetables Primary"."Spinach"
"Vegetables Primary"."String beans"
"Vegetables Primary"."Tomatoes"
"Vegetables Primary"."Vegetables, fresh nes"
"Vegetables Primary"."Vegetables, leguminous nes"
"Vegetables Primary"."Watermelons"
"Vegetables&Melons, Total"."Artichokes"
"Vegetables&Melons, Total"."Asparagus"
"Vegetables&Melons, Total"."Beans, green"
"Vegetables&Melons, Total"."Cabbages and other brassicas"
"Vegetables&Melons, Total"."Carrots and turnips"
"Vegetables&Melons, Total"."Cassava leaves"
"Vegetables&Melons, Total"."Cauliflowers and broccoli"
"Vegetables&Melons, Total"."Chillies and peppers, green"
"Vegetables&Melons, Total"."Cucumbers and gherkins"
"Vegetables&Melons, Total"."Eggplants (aubergines)"
"Vegetables&Melons, Total"."Garlic"
"Vegetables&Melons, Total"."Leeks, other alliaceous vegetables"
"Vegetables&Melons, Total"."Lettuce and chicory"
"Vegetables&Melons, Total"."Maize, green"
"Vegetables&Melons, Total"."Melons, other (inc.cantaloupes)"
"Vegetables&Melons, Total"."Mushrooms and truffles"
"Vegetables&Melons, Total"."Okra"
"Vegetables&Melons, Total"."Onions, dry"
"Vegetables&Melons, Total"."Onions, shallots, green"
"Vegetables&Melons, Total"."Peas, green"
"Vegetables&Melons, Total"."Pumpkins, squash and gourds"
"Vegetables&Melons, Total"."Spinach"
"Vegetables&Melons, Total"."String beans"
"Vegetables&Melons, Total"."Tomatoes"
"Vegetables&Melons, Total"."Vegetables, fresh nes"
"Vegetables&Melons, Total"."Vegetables, leguminous nes"
"Vegetables&Melons, Total"."Watermelons"
/;


*1.2) Animal products
Set FAOSTAT_LivestockPrimaryItems_Meat(FAOSTAT_LivestockPrimaryItems) Sub-set containing MEAT items only in livestock primary items
/
"Beef and Buffalo Meat"
"Meat indigenous, ass"
"Meat indigenous, bird nes"
"Meat indigenous, buffalo"
"Meat indigenous, camel"
"Meat indigenous, cattle"
"Meat indigenous, chicken"
"Meat indigenous, duck"
"Meat indigenous, geese"
"Meat indigenous, goat"
"Meat indigenous, horse"
"Meat indigenous, mule"
"Meat indigenous, other camelids"
"Meat indigenous, pig"
"Meat indigenous, poultry"
"Meat indigenous, rabbit"
"Meat indigenous, rodents"
"Meat indigenous, sheep"
"Meat indigenous, total"
"Meat indigenous, turkey"
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
"Pigeons, other birds"
"Sheep and Goat Meat"
/;

Set FAOSTAT_LivestockPrimaryItems_PoultryMeat(FAOSTAT_LivestockPrimaryItems) Sub-set containing POULTRY MEAT items only in livestock primary items
/
"Meat indigenous, bird nes"
"Meat indigenous, chicken"
"Meat indigenous, duck"
"Meat indigenous, geese"
"Meat indigenous, poultry"
"Meat indigenous, turkey"
"Meat, bird nes"
"Meat, chicken"
"Meat, duck"
"Meat, goose and guinea fowl"
"Meat, Poultry"
"Meat, turkey"
"Pigeons, other birds"
/;

Set FAOSTAT_LivestockPrimaryItems_Milk(FAOSTAT_LivestockPrimaryItems) Sub-set containing MILK items only in livestock primary items
/
"Milk, whole fresh buffalo"
"Milk, whole fresh camel"
"Milk, whole fresh cow"
"Milk, whole fresh goat"
"Milk, whole fresh sheep"
"Milk,Total"
/;

Set FAOSTAT_LivestockPrimaryItems_Eggs(FAOSTAT_LivestockPrimaryItems) Sub-set containing EGG items only in livestock primary items
/
"Eggs Primary"
"Eggs, hen, in shell"
"Eggs, hen, in shell (number)"
"Eggs, other bird, in shell"
"Eggs, other bird, in shell (number)"
/;

Set FAOSTAT_LivestockPrimaryItems_HidesSkinsHair(FAOSTAT_LivestockPrimaryItems) Sub-set containing Hides-Skins-Hair items only in livestock primary items
/
"Skins, furs"
"Skins, goat, fresh"
"Skins, sheep, fresh"
"Skins, sheep, with wool"
"Hair, horse"
"Hides, buffalo, fresh"
"Hides, cattle, fresh"
"Wool, greasy"
/;

*the following are not in a group:
$ontext;
"Snails, not sea"
"Beeswax"
"Honey, natural"
"Offals, nes"
"Silk-worm cocoons, reelable"
$offtext;



*1.3) Trade in crop and livestock products



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Sets for groups of activities and commodities as used in old SOLm versions (up to V4) - and here in V6 for filing in some data

*the following is a slightly different grouping than provided above from FAOSTAT as we used in earlier SOLm-versions (with some slight changes) and which makes more sense contents-wise,
*        as it covers the food-basket relevant groups in a better way (above, sugar crops are only in crops primary, for example) -
*        also similar to the groupings used in the food balance sheets, but not fully equivalent, it seems
*        however, from a production technical side, it makes less sense - as soybeans there should be legumes, not oil crops; sugar beet is roots rather than together with sugar cane.

Set SOLmOld_CropProductionItemGroups OLD crop item groups as used in earlier versions of SOLm (up to V4 and for reading in some data in V5)
*as taken from earlier SOLm versions, cf. remark just above
*these groups fully cover FAOSTAT_CropProductionItems and do not overlap
/
SOLmOld_Fruits
SOLmOld_Treenuts
SOLmOld_Grains
SOLmOld_Pulses
SOLmOld_Oil_Crops
SOLmOld_Starchy_Roots
SOLmOld_Sugars_And_Sweeteners
SOLmOld_Vegetables
SOLmOld_Stimulants_Spices
SOLmOld_Fibres_Rubber
/;

Set SOLmOld_Fruits(FAOSTAT_CropProductionItems) FRUIT crop items building the OLD SOLm fruit group
/
Strawberries
"Berries Nes"
Blueberries
Cranberries
Currants
Gooseberries
Raspberries
"Lemons and limes"
Oranges
"Tangerines, mandarins, clementines, satsumas"
Grapes
"Fruit, citrus nes"
"Fruit, fresh nes"
"Fruit, pome nes"
"Fruit, stone nes"
Pears
Quinces
Apricots
Cherries
"Cherries, sour"
"Peaches and nectarines"
"Plums and sloes"
Apples
Avocados
Bananas
Carobs
Cashewapple
Dates
Figs
"Fruit, tropical fresh nes"
"Grapefruit (inc. pomelos)"
"Kiwi fruit"
"Mangoes, mangosteens, guavas"
Papayas
Persimmons
Pineapples
"Plantains and others"
"Citrus Fruit,Total"
"Fruit excl Melons,Total"
/;
Set SOLmOld_Treenuts(FAOSTAT_CropProductionItems) TREENUT crop items building the OLD SOLm treenut group
/
"Almonds, with shell"
"Areca nuts"
"Brazil nuts, with shell"
"Cashew nuts, with shell"
Chestnut
"Hazelnuts, with shell"
"Nuts, nes"
Pistachios
"Tung Nuts"
"Walnuts, with shell"
"Treenuts,Total"
/;
Set SOLmOld_Grains(FAOSTAT_CropProductionItems) GRAINS crop items building the OLD SOLm grains group
/
Barley
Buckwheat
"Canary seed"
"Cereals, nes"
Fonio
Maize
Millet
Oats
Quinoa
"Rice, paddy"
Rye
Sorghum
Triticale
Wheat
"Cereals,Total"
"Cereals (Rice Milled Eqv)"
"Coarse Grain, Total"
"Grain, mixed"
/;
Set SOLmOld_Pulses(FAOSTAT_CropProductionItems) PULSES crop items building the OLD SOLm pulses group
*ATTENTION:
*        soybeans, "Groundnuts, with shell"      are counted under oil crops
/
"Bambara beans"
"Beans, dry"
"Broad beans, horse beans, dry"
"Chick peas"
"Cow peas, dry"
Lentils
Lupins
"Peas, dry"
"Pigeon peas"
"Pulses, nes"
Vetches
"Pulses,Total"
/;
Set SOLmOld_Oil_Crops(FAOSTAT_CropProductionItems) OIL CROP crop items building the OLD SOLm oil crop group
/
Soybeans
"Groundnuts, with shell"
"Castor oil seed"
Hempseed
Linseed
"Mustard seed"
"Poppy seed"
Rapeseed
"Safflower seed"
"Sesame seed"
"Sunflower seed"
Melonseed
Coconuts
"Karite Nuts (Sheanuts)"
"Kola nuts"
"Oil, palm"
"Oil, palm fruit"
Olives
"Jojoba seed"
"Tallowtree seed"
"Kapok Fruit"
"Kapokseed in shell"
"Cottonseed"
"Oilcakes Equivalent"
"Oilcrops Primary"
"Oilseeds nes"
"Palm kernels"
"Seed cotton"
/;
Set SOLmOld_Starchy_Roots(FAOSTAT_CropProductionItems) STARCHY ROOTS crop items building the OLD SOLm starchy roots group
/
Cassava
Potatoes
"Roots and Tubers, nes"
"Sweet potatoes"
"Taro (cocoyam)"
Yams
"Yautia (cocoyam)"
"Roots and Tubers,Total"
/;
Set SOLmOld_Sugars_And_Sweeteners(FAOSTAT_CropProductionItems) SUGARS AND SWEETENERS crop items building the OLD SOLm sugars and sweeteners group
/
"Sugar cane"
"Sugar crops, nes"
"Sugar beet"
/;
Set SOLmOld_Vegetables(FAOSTAT_CropProductionItems) VEGETABLES crop items building the OLD SOLm vegetables group
/
Artichokes
Asparagus
"Beans, green"
"Cabbages and other brassicas"
"Carrots and turnips"
"Cassava leaves"
"Cauliflowers and broccoli"
"Chicory roots"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cucumbers and gherkins"
"Eggplants (aubergines)"
Garlic
"Leeks, other alliaceous vegetables"
"Lettuce and chicory"
"Maize, green"
"Melons, other (inc.cantaloupes)"
"Mushrooms and truffles"
Okra
"Onions, shallots, green"
"Onions, dry"
"Peas, green"
"Pumpkins, squash and gourds"
Spinach
"String beans"
Tomatoes
"Vegetables Primary"
"Vegetables&Melons, Total"
"Vegetables, leguminous nes"
Watermelons
/;
Set SOLmOld_Stimulants_Spices(FAOSTAT_CropProductionItems) STIMULANTS AND SPICES crop items building the OLD SOLm stimulants and spices group
/
"Coffee, green"
"Cocoa, beans"
Tea
"Maté"
Hops
"Pepper (Piper spp.)"
Vanilla
"Cinnamon (canella)"
Cloves
"Nutmeg, mace and cardamoms"
"Anise, badian, fennel, coriander"
Ginger
"Spices, nes"
Peppermint
"Pyrethrum, Dried"
"Tobacco, unmanufactured"
/;
Set SOLmOld_Fibres_Rubber(FAOSTAT_CropProductionItems) FIBRES AND RUBBER crop items building the OLD SOLm fibres and rubber group
/
"Cotton lint"
"Flax fibre and tow"
"Hemp Tow Waste"
Jute
"Jute & Jute-like Fibres"
"Bastfibres, other"
Ramie
Sisal
"Agave Fibres Nes"
"Manila Fibre (Abaca)"
Coir
"Fibre Crops Nes"
"Rubber, natural"
"Gums, Natural"
"Seed cotton"
"Fibre Crops Primary"
"Kapok fibre"
/;


*Three additional specific sets used only to file in some data
Set SOLmOld_ForReadingDataBerries(FAOSTAT_CropProductionItems) BERRIES crop items building the OLD SOLm berries group
/
Strawberries
"Berries Nes"
Blueberries
Cranberries
Currants
Gooseberries
Raspberries
/;
Set SOLmOld_ForReadingDataNonLeguminousVegetables(FAOSTAT_CropProductionItems) NON-LEGUMINOUS VEGETABLES crop items building the OLD SOLm non-leguminous vegetables group
/
Artichokes
Asparagus
"Cabbages and other brassicas"
"Carrots and turnips"
"Cassava leaves"
"Cauliflowers and broccoli"
"Chicory roots"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cucumbers and gherkins"
"Eggplants (aubergines)"
Garlic
"Leeks, other alliaceous vegetables"
"Lettuce and chicory"
"Maize, green"
"Melons, other (inc.cantaloupes)"
"Mushrooms and truffles"
Okra
"Onions, shallots, green"
"Onions, dry"
"Pumpkins, squash and gourds"
Spinach
Tomatoes
"Vegetables Primary"
"Vegetables&Melons, Total"
Watermelons
/;
Set SOLmOld_ForReadingDataLeguminousVegetables(FAOSTAT_CropProductionItems) LEGUMINOUS VEGETABLES crop items building the OLD SOLm leguminous vegetables group
/
"Beans, green"
"Peas, green"
"String beans"
"Vegetables, leguminous nes"
/

