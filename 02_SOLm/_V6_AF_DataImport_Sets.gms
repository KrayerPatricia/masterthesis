$TITLE Set initialisation for nfp69


****************************************
*** SETS FOR THE MENUCH CALCULATIONS ***
****************************************

$ifthen %IncludeExcel_MenuCH% == "YES"
$call GDXXRW ..\02_RawData\menuCH_matched_GAMS_withRecipes_imp_withparentIDandBYear.xlsx o=..\02_RawData\menuCH_matched_GAMS_withRecipes_imp_withparentIDandBYear.gdx index=Index!a1 MaxDupeErrors = 200
$endif;

SET idnum;
SET foodid;
SET namegerman;
SET id;
SET gender;
SET birthyear;
SET productcompact;
SET primaryproduct;
*SET productsolm;
SET recalldate;
SET clusters;
SET descriptors;
SET parentid;

$GDXIN  ..\SOLmV6\02_RawData\menuCH_matched_GAMS_withRecipes_imp_withparentIDandBYear.gdx
$load idnum
$load foodid
$load namegerman
$load id
$load gender
$load birthyear
$load productcompact
$load primaryproduct
*$load productsolm
$load recalldate
$load clusters
$load descriptors
$load parentid
$gdxin


$onmulti
SET descriptors /
'Fattotalg_calc'
'Carbohydratesavailableg_calc'
'Amount_PP_FW'
/;
$offmulti


SET nutrients(descriptors) /
'Proteing_calc'
'Energykcal_calc'
'Fattotalg_calc'
'Carbohydratesavailableg_calc'
/;

SET units(descriptors) /
'Amount',
'Amount_calibrated',
'sw_calibrated_w_2rec',
'RatioCarbFibres',
'Portion',
'Score',
'Percentage'
'Factor'
'Amount_PP'
'Amount_PP_FW'
'Amount_PP_calibrated'
'Amount_PP_calibrated_FW'
'Amount_Peq_calibrated_FW'
/;


SET descriptors_foruse(descriptors)
/
'Proteing_calc'
'Energykcal_calc'
'Fattotalg_calc'
'Carbohydratesavailableg_calc'
'Amount_PP_calibrated_FW'
'Amount_Peq_calibrated_FW'
/;



* SHDB:

$call GDXXRW VariousSources_SocialHotspotData_08_10_2019.xlsx o=VariousSources_SocialHotspotData_08_10_2019.gdx index=Index!a1 MaxDupeErrors = 200

SET CountryCode;
SET SectorCode;
SET SocialIndicator;
SET Sector;


$gdxin VariousSources_SocialHotspotData_08_10_2019.gdx
$load CountryCode
$load SectorCode
$load Sector
$load SocialIndicator
$gdxin



****************************
*** IMPORT SETS FOR SNDB ***
****************************

$ifthen %IncludeExcel_SwissNutrDatabase% == "YES"
$call GDXXRW ..\02_RawData\SwissFoodCompDatabase_GAMS.xlsx o=..\02_RawData\SwissFoodCompDatabase_GAMS.gdx index=Index!a1 MaxDupeErrors = 200
$endif;

SET NutrID;
SET SNDName;
SET SNDCategory;
SET SNDNutrients;

$gdxin ..\SOLmV6\02_RawData\SwissFoodCompDatabase_GAMS.gdx
$load NutrID
$load SNDName
$load SNDCategory
$load SNDNutrients
$gdxin



*************************************************************
*** ADD ADDITIONAL ELEMENTS TO Commodities and Activities ***
*************************************************************

$onmulti
SET Commodities     additional entries for CommoditySOLmV5 /
* not in the list but needed
"Flour, Spelt"

* new for nfp69
'Salt'
'Water'
'Hard cheese'
'Semihard cheese'
'Soft cheese'
'Leafy vegetables'
'Branch vegetables'
'Fruit vegetables'
'Root vegetables'
'Cauliflower vegetables'
'Seasoning'

* 16.01.19
* for the importcomm-matching
'empty'
'Feed'
'Palm oil'
/;

SET Activities      additional entries for ActivitySOLmV5 /
* not in the list but needed
'All Animals'
'All Cereals'
'All Crops'
'All Fish and Seafood'
'All Fruits'
'All Nuts'
'All Oilcrops'
'All other Animals'
'All other citrus'
'All other marine fish'
'All other oilcrops'
'All other sugar sources'
'All other vegetables'
'All Poultry'
'All Ruminants'
'All starchy roots'
'All sugar crops'
'All Vegetables'
'Freshwater Fish'
'Pelagic Fish'

* not in the list but in the matching list... (?)
"All other hard fibres"
"All crops producing oilseed cake"
"All roots and tubers"
"All other roots"
"All other soft fibres"
"All spices"
"All other Spices"
"All sugar sources"
"Aquatic Animals, Others"
"Aquatic Plants"
"Aquatic Products, Other"
"Cephalopods"
"Crustaceans"
"Demersal Fish"
"All Fish and Marine Mamm"
"Aquatic Animals"
"Molluscs"
"Silkworms"

* new for nfp69
"Water"
"Salt"
"Leafy vegetables"
/;

SET GeographicRegionSOLmV5 /
"Switzerland_Tal"
"Switzerland_Huegel"
"Switzerland_Berg"
"Austria_SuedoestlFlachHuegelland"
/;
$offmulti




***************************************
*** DEFINE THE SUBSETS FOR DIETOPTI ***
***************************************

SET CommodityDO(Commodities) /
"Bananas"
"Berries nes"
"Cabbages and other brassicas"
"Chestnut"
"Chick peas"
"Dates"
"Ginger"
"Lentils"
"Mushrooms and truffles"
"Oats"
"Pumpkins, squash and gourds"
"Quinoa"
"Sesame seed"
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Wine"
"Meat, chicken"
"Meat, duck"
"Meat, game"
"Meat, horse"
"Meat, nes"
"Meat, turkey"
"Cheese, whole cow milk"
"Yoghurt"
"Almonds shelled"
"Bulgur"
"Cashew nuts, shelled"
"Fat, nes, prepared"
"Flour, wheat"
"Groundnuts, shelled"
"Hazelnuts, shelled"
"Juice, fruit nes"
"Meat, beef and veal sausages"
"Meat, cattle, boneless (beef & veal)"
"Soya curd"
"Walnuts, shelled"
"Animal fats"
"Beer"
"Onions"
"Pigmeat"
"Pulses"
"Beans"
"Beverages, Alcoholic"
"Cereals - Excluding Beer"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Coffee and products"
"Fruits - Excluding Wine"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Lemons, Limes and products"
"Maize and products"
"Millet and products"
"Nuts and products"
"Oilcrops"
"Oilcrops Oil, Other"
"Olive Oil"
"Olives (including preserved)"
"Oranges, Mandarines"
"Peas"
"Potatoes and products"
"Rape and Mustard Oil"
"Rice (Milled Equivalent)"
"Soyabeans"
"Sugar (Raw Equivalent)"
"Sweeteners, Other"
"Tea (including mate)"
"Vegetables"
"Wheat and products"
"Butter, Ghee"
"Cheese"
"Cream"
"Eggs"
"Fish, Seafood"
"Freshwater Fish"
"Honey"
"Marine Fish, Other"
"Milk, Skimmed"
"Milk, Whole"
"Mutton & Goat Meat"
"Pelagic Fish"
"Flour, Spelt"
"Salt"
"Water"
"Hard cheese"
"Semihard cheese"
"Soft cheese"
"Leafy vegetables"
"Branch vegetables"
"Fruit vegetables"
"Root vegetables"
"Seasoning"
*$offtext

*'empty'
*'Feed'
*'Palm oil'
/;

$ontext
SET CommodityDO_Kastner(CommoditySOLmV5) /
'Ginger'
'Mushrooms and truffles'
'Sugar cane'
'Cashew nuts, shelled'
'Juice, fruit nes'
'Cocoa Beans and products'
'Coffee and products'
'Palm Oil'
/;
$offtext

SET CommodityDO_Kastner(Commodities) /
"Bananas"
"Berries nes"
"Cabbages and other brassicas"
"Chestnut"
"Chick peas"
"Dates"
"Ginger"
"Lentils"
"Mushrooms and truffles"
"Oats"
"Pumpkins, squash and gourds"
"Quinoa"
"Sesame seed"
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Wine"
"Meat, chicken"
"Meat, duck"
"Meat, game"
"Meat, horse"
"Meat, nes"
"Meat, turkey"
"Cheese, whole cow milk"
"Yoghurt"
"Almonds shelled"
"Bulgur"
"Cashew nuts, shelled"
"Fat, nes, prepared"
"Flour, wheat"
"Groundnuts, shelled"
"Hazelnuts, shelled"
"Juice, fruit nes"
"Meat, beef and veal sausages"
"Meat, cattle, boneless (beef & veal)"
"Soya curd"
"Walnuts, shelled"
"Animal fats"
"Beer"
"Onions"
"Pigmeat"
"Pulses"
"Beans"
"Beverages, Alcoholic"
"Cereals - Excluding Beer"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Coffee and products"
"Fruits - Excluding Wine"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Lemons, Limes and products"
"Maize and products"
"Millet and products"
"Nuts and products"
"Oilcrops"
"Oilcrops Oil, Other"
"Olive Oil"
"Olives (including preserved)"
"Oranges, Mandarines"
"Peas"
"Potatoes and products"
"Rape and Mustard Oil"
"Rice (Milled Equivalent)"
"Soyabeans"
"Sugar (Raw Equivalent)"
"Sweeteners, Other"
"Tea (including mate)"
"Vegetables"
"Wheat and products"
"Butter, Ghee"
"Cheese"
"Cream"
"Eggs"
"Fish, Seafood"
"Freshwater Fish"
"Honey"
"Marine Fish, Other"
"Milk, Skimmed"
"Milk, Whole"
"Mutton & Goat Meat"
"Pelagic Fish"
"Flour, Spelt"
"Salt"
"Water"
"Hard cheese"
"Semihard cheese"
"Soft cheese"
"Leafy vegetables"
"Branch vegetables"
"Fruit vegetables"
"Root vegetables"
"Seasoning"
*$offtext

'empty'
'Feed'
'Palm oil'
/;


SET TestCommDO(Commodities) /
"Bananas"
"Berries nes"
"Cabbages and other brassicas"
/;

SET CommodityNOTOpt(CommodityDO) /
"Animal fats"
"Marine Fish, Other"
"Pelagic Fish"
"Salt"
"Water"
"Seasoning"
/;


SET CommodityForMedian(CommodityDO) /
"Meat, beef and veal sausages"
"Meat, cattle, boneless (beef & veal)"
"Pigmeat"
"Meat, chicken"
"Eggs"
/;


SET PerishableCommodity /
"Berries nes"
*"Cabbages and other brassicas"
"Mushrooms and truffles"
** MEATS ?
"Yoghurt"
"Fruits - Excluding Wine"
"Grapes and products (excl wine)"
"Vegetables"
** FISH - if fresh/living -> any angaben dazu?
"Leafy vegetables"
"Branch vegetables"
"Fruit vegetables"
/;

SET ASFCommodityDO(CommodityDO) /
"Meat, chicken"
"Meat, duck"
"Meat, game"
"Meat, horse"
"Meat, nes"
"Meat, turkey"
"Cheese, whole cow milk"
"Yoghurt"

*"Fat, nes, prepared"

"Meat, beef and veal sausages"
"Meat, cattle, boneless (beef & veal)"
"Animal fats"
"Pigmeat"
"Butter, Ghee"
"Cheese"
"Cream"
"Eggs"
"Fish, Seafood"
"Freshwater Fish"
"Honey"
"Marine Fish, Other"
"Milk, Skimmed"
"Milk, Whole"
"Mutton & Goat Meat"
"Pelagic Fish"
"Hard cheese"
"Semihard cheese"
"Soft cheese"
/;

SET MeatCommodities(CommodityDO) /
"Meat, chicken"
"Meat, duck"
"Meat, game"
"Meat, horse"
"Meat, nes"
"Meat, turkey"
"Meat, beef and veal sausages"
"Meat, cattle, boneless (beef & veal)"
"Mutton & Goat Meat"
"Pigmeat"
/;

SET PulsesDO(CommodityDO) /
"Lentils"
*"Peas"
* Peas is assigned to vegetables in SDM (therefore left out here)
"Beans"
"Chick peas"
"Soyabeans"
* Soyabeans is assigned to oil-bearing crops...
"Pulses"
/;

SET PSFCommodityDO(CommodityDO) /
"Bananas"
"Cabbages and other brassicas"
"Chestnut"
"Berries nes"
"Chick peas"
"Dates"
"Ginger"
"Lentils"
"Mushrooms and truffles"
"Oats"
"Pumpkins, squash and gourds"
"Quinoa"
"Sesame seed"
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Wine"
"Almonds shelled"
"Bulgur"
"Cashew nuts, shelled"

"Fat, nes, prepared"

"Flour, wheat"
"Groundnuts, shelled"
"Hazelnuts, shelled"
"Juice, fruit nes"
"Soya curd"
"Walnuts, shelled"
"Beer"
"Onions"
"Pulses"
"Beans"
"Beverages, Alcoholic"
"Cereals - Excluding Beer"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Coffee and products"
"Fruits - Excluding Wine"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Lemons, Limes and products"
"Maize and products"
"Millet and products"
"Nuts and products"
"Oilcrops"
"Oilcrops Oil, Other"
"Olive Oil"
"Olives (including preserved)"
"Oranges, Mandarines"
"Peas"
"Potatoes and products"
"Rape and Mustard Oil"
"Rice (Milled Equivalent)"
"Soyabeans"
"Sugar (Raw Equivalent)"
"Sweeteners, Other"
"Tea (including mate)"
"Vegetables"
"Wheat and products"
"Flour, Spelt"
"Salt"
"Water"
"Leafy vegetables"
"Branch vegetables"
"Fruit vegetables"
"Root vegetables"
"Seasoning"
/;

SET AggregateComm /
'Cereals'
'Potatoes'
'Sugar, other sweeteners'
'Vegetables'
'Pulses'
'Nuts and seeds'
'Fruits'
'Meat, cattle'
'Pigmeat'
'Meat, chicken'
'Fish, seafood'
'Eggs'
'Milk, milk products'
'Oils and fats'
'Butter'
'Non-alcoholic beverages'
'Alcoholic beverages'
'Other animal products'
'Other vegetal products'
/;

SET PSFAggregateComm(AggregateComm) /
'Cereals'
'Potatoes'
'Sugar, other sweeteners'
'Vegetables'
'Pulses'
'Nuts and seeds'
'Fruits'
'Oils and fats'
*'Non-alcoholic beverages'
*'Alcoholic beverages'
*'Other vegetal products'
/;

SET ASFAggregateComm(AggregateComm) /
'Meat, cattle'
'Pigmeat'
'Meat, chicken'
'Fish, seafood'
'Eggs'
'Milk, milk products'
'Other animal products'
'Butter'
/;

SET AggregateComm_NFP69 /
'Sweets and Alcoholic beverages'
'Oils and fats'
'Meat, dairy and eggs'
'Pulses, nuts and seeds'
'Cereals and Potatoes'
'Vegetables and fruits'
'Non-alcoholic beverages'
/;

* das wird eigentlich nicht gebraucht (?)
SET ActivityDO(Activities) /
"All Animals"
"All Cereals"
"All Crops"
"All Fish and Seafood"
"All Fruits"
"All Nuts"
"All Oilcrops"
"All other Animals"
"All other citrus"
"All other marine fish"
"All other oilcrops"
"All other sugar sources"
"All other vegetables"
"All Poultry"
"All Ruminants"
"All starchy roots"
"All sugar crops"
"All Vegetables"
"Almonds, with shell"
"Bananas"
"Beans, dry"
"Beehives"
"Berries nes"
"Cabbages and other brassicas"
"Cashew nuts, with shell"
"Cattle"
"Chestnut"
"Chick peas"
"Chickens"
"Cocoa, beans"
"Coconuts"
"Coffee, green"
"Dates"
"Ducks"
"Freshwater Fish"
"Game"
"Ginger"
"Grapefruit (inc. pomelos)"
"Grapes"
"Groundnuts, with shell"
"Hazelnuts, with shell"
"Horses"
"Leafy vegetables"
"Lemons and limes"
"Lentils"
"Maize"
"Millet"
"Mushrooms and truffles"
"Mustard seed"
"Oats"
"Olives"
"Onions, dry"
"Oranges"
"Peas, dry"
"Pelagic Fish"
"Pigs"
"Potatoes"
"Pulses,Total"
"Pumpkins, squash and gourds"
"Quinoa"
"Rice, paddy"
"Salt"
"Sesame seed"
"Sheep and Goats"
"Soybeans"
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Tea"
"Turkeys"
"Walnuts, with shell"
"Water"
"Wheat"
/;

$ontext
nicht mehr in v6
SET OutputTypeDO(OutputType) /
"Main crop"
"Meat"
"Milk"
"Honey"
"Other animal output"
"Wool"
"Eggs"
"All"
/;
$offtext

SET GeographicRegionDO(Regions) /
*$ontext
*the following equals the set FAOSTAT_CountriesAndRegions
"Afghanistan"
"Africa"
"Albania"
"Algeria"
"American Samoa"
"Americas"
"Angola"
"Antigua and Barbuda"
"Argentina"
"Armenia"
*start: 1992
"Aruba"
"Asia"
"Australia"
"Australia & New Zealand"
"Austria"
"Azerbaijan"
*start: 1992
"Bahamas"
"Bahrain"
"Bangladesh"
"Barbados"
"Belarus"
*start: 1992
"Belgium"
*start: 2000
"Belgium-Luxembourg"
*end: 1999
"Belize"
"Benin"
"Bermuda"
"Bhutan"
"Bolivia (Plurinational State of)"
"Bosnia and Herzegovina"
*start: 1992
"Botswana"
"Brazil"
"British Virgin Islands"
"Brunei Darussalam"
"Bulgaria"
"Burkina Faso"
"Burundi"
"Cabo Verde"
"Cambodia"
"Cameroon"
"Canada"
"Caribbean"
"Cayman Islands"
"Central African Republic"
"Central America"
"Central Asia"
"Chad"
"Chile"
"China"
"China, Hong Kong SAR"
"China, Macao SAR"
"China, mainland"
"China, Taiwan Province of"
"Colombia"
"Comoros"
"Congo"
"Cook Islands"
"Costa Rica"
"Côte d'Ivoire"
"Croatia"
*start: 1992
"Cuba"
"Cyprus"
"Czechia"
*start: 1993
"Czechoslovakia"
*start: 1992
"Democratic People's Republic of Korea"
"Democratic Republic of the Congo"
"Denmark"
"Djibouti"
"Dominica"
"Dominican Republic"
"Eastern Africa"
"Eastern Asia"
"Eastern Europe"
"Ecuador"
"Egypt"
"El Salvador"
"Equatorial Guinea"
"Eritrea"
*start: 1993
"Estonia"
*start: 1992
"Ethiopia"
*start: 1993
"Ethiopia PDR"
*end: 1992
"Europe"
"European Union"
"Falkland Islands (Malvinas)"
"Faroe Islands"
"Fiji"
*$offtext
"Finland"
"France"
"French Polynesia"
"Gabon"
"Gambia"
"Georgia"
*start 1992
"Germany"
"Ghana"
"Greece"
"Grenada"
"Guam"
"Guatemala"
"Guinea"
"Guinea-Bissau"
"Guyana"
"Haiti"
"Honduras"
"Hungary"
"Iceland"
"India"
"Indonesia"
"Iran (Islamic Republic of)"
"Iraq"
"Ireland"
"Israel"
"Italy"
"Jamaica"
"Japan"
"Jordan"
"Kazakhstan"
*start: 1992
"Kenya"
"Kiribati"
"Kuwait"
"Kyrgyzstan"
*start: 1992
"Land Locked Developing Countries"
"Lao People's Democratic Republic"
"Latvia"
*start: 1992
"Least Developed Countries"
"Lebanon"
"Lesotho"
"Liberia"
"Libya"
"Lithuania"
*start: 1992
"Low Income Food Deficit Countries"
"Luxembourg"
*start: 2000
"Madagascar"
"Malawi"
"Malaysia"
"Maldives"
"Mali"
"Malta"
*we added "Marshall Isalnds" albeit it is not in the list downloaded from FAOSTAT - but it is in the data
"Marshall Islands"
"Mauritania"
"Mauritius"
"Melanesia"
"Mexico"
"Micronesia"
"Middle Africa"
"Mongolia"
"Montenegro"
*start: 2006
"Morocco"
"Mozambique"
"Myanmar"
"Namibia"
"Nauru"
"Nepal"
"Net Food Importing Developing Countries"
"Netherlands"
"Netherlands Antilles (former)"
*start: 2010
"New Caledonia"
"New Zealand"
"Nicaragua"
"Niger"
"Nigeria"
"Niue"
"Norfolk Island"
"Northern Africa"
"Northern America"
"Northern Europe"
"Norway"
"Occupied Palestinian Territory"
"Oceania"
"Oman"
"Pacific Islands Trust Territory"
*start: 1990
"Pakistan"
"Panama"
"Papua New Guinea"
"Paraguay"
"Peru"
"Philippines"
"Poland"
"Polynesia"
"Portugal"
"Qatar"
"Republic of Korea"
"Republic of Moldova"
*start: 1992
"Romania"
"Russian Federation"
*start: 1992
"Rwanda"
"Saint Kitts and Nevis"
"Saint Lucia"
"Saint Pierre and Miquelon"
"Saint Vincent and the Grenadines"
"Samoa"
"Sao Tome and Principe"
"Saudi Arabia"
"Senegal"
"Serbia"
*start 2006
"Serbia and Montenegro"
*start: 1992; end: 2005
"Seychelles"
"Sierra Leone"
"Singapore"
"Slovakia"
*start: 1993
"Slovenia"
*start: 1992
"Small Island Developing States"
"Solomon Islands"
"Somalia"
"South Africa"
"South America"
"South Sudan"
*start: 2012
"South-Eastern Asia"
"Southern Africa"
"Southern Asia"
"Southern Europe"
"Spain"
"Sri Lanka"
"Sudan"
*start: 2012
*"Sudan (former)"
*end: 2011
"Suriname"
"Swaziland"
"Sweden"
"Switzerland"
"Syrian Arab Republic"
"Tajikistan"
*start: 1992
"Thailand"
"The former Yugoslav Republic of Macedonia"
*start: 1992
"Timor-Leste"
"Togo"
"Tonga"
"Trinidad and Tobago"
"Tunisia"
"Turkey"
"Turkmenistan"
*start: 1992
"Tuvalu"
"Uganda"
"Ukraine"
*startt: 1992
"United Arab Emirates"
"United Kingdom"
"United Republic of Tanzania"
"United States of America"
"Uruguay"
"USSR"
*end: 1991
"Uzbekistan"
*start: 1992
"Vanuatu"
"Venezuela (Bolivarian Republic of)"
"Viet Nam"
"Western Africa"
"Western Asia"
"Western Europe"
"World"
"Yemen"
"Yugoslav SFR"
*end: 1991
"Zambia"
"Zimbabwe"
*till here it equals the set FAOSTAT_CountriesAndRegions
*the following is a categorisation currently not used officially in FAOSTAT - but we need it for certain assignments and thus introduce it to this set
*"Developed Countries"
*"Developing Countries"
*"Indian Subcontinent"

/;


SET GeographicRegionNOTCH(GeographicRegionDO) /
"Afghanistan"
"Africa"
"Albania"
"Algeria"
"American Samoa"
"Americas"
"Angola"
"Antigua and Barbuda"
"Argentina"
"Armenia"
*start: 1992
"Aruba"
"Asia"
"Australia"
"Australia & New Zealand"
"Austria"
"Azerbaijan"
*start: 1992
"Bahamas"
"Bahrain"
"Bangladesh"
"Barbados"
"Belarus"
*start: 1992
"Belgium"
*start: 2000
"Belgium-Luxembourg"
*end: 1999
"Belize"
"Benin"
"Bermuda"
"Bhutan"
"Bolivia (Plurinational State of)"
"Bosnia and Herzegovina"
*start: 1992
"Botswana"
"Brazil"
"British Virgin Islands"
"Brunei Darussalam"
"Bulgaria"
"Burkina Faso"
"Burundi"
"Cabo Verde"
"Cambodia"
"Cameroon"
"Canada"
"Caribbean"
"Cayman Islands"
"Central African Republic"
"Central America"
"Central Asia"
"Chad"
"Chile"
"China"
"China, Hong Kong SAR"
"China, Macao SAR"
"China, mainland"
"China, Taiwan Province of"
"Colombia"
"Comoros"
"Congo"
"Cook Islands"
"Costa Rica"
"Côte d'Ivoire"
"Croatia"
*start: 1992
"Cuba"
"Cyprus"
"Czechia"
*start: 1993
"Czechoslovakia"
*start: 1992
"Democratic People's Republic of Korea"
"Democratic Republic of the Congo"
"Denmark"
"Djibouti"
"Dominica"
"Dominican Republic"
"Eastern Africa"
"Eastern Asia"
"Eastern Europe"
"Ecuador"
"Egypt"
"El Salvador"
"Equatorial Guinea"
"Eritrea"
*start: 1993
"Estonia"
*start: 1992
"Ethiopia"
*start: 1993
"Ethiopia PDR"
*end: 1992
"Europe"
"European Union"
"Falkland Islands (Malvinas)"
"Faroe Islands"
"Fiji"
*$offtext
"Finland"
"France"
"French Polynesia"
"Gabon"
"Gambia"
"Georgia"
*start 1992
"Germany"
"Ghana"
"Greece"
"Grenada"
"Guam"
"Guatemala"
"Guinea"
"Guinea-Bissau"
"Guyana"
"Haiti"
"Honduras"
"Hungary"
"Iceland"
"India"
"Indonesia"
"Iran (Islamic Republic of)"
"Iraq"
"Ireland"
"Israel"
"Italy"
"Jamaica"
"Japan"
"Jordan"
"Kazakhstan"
*start: 1992
"Kenya"
"Kiribati"
"Kuwait"
"Kyrgyzstan"
*start: 1992
"Land Locked Developing Countries"
"Lao People's Democratic Republic"
"Latvia"
*start: 1992
"Least Developed Countries"
"Lebanon"
"Lesotho"
"Liberia"
"Libya"
"Lithuania"
*start: 1992
"Low Income Food Deficit Countries"
"Luxembourg"
*start: 2000
"Madagascar"
"Malawi"
"Malaysia"
"Maldives"
"Mali"
"Malta"
*we added "Marshall Isalnds" albeit it is not in the list downloaded from FAOSTAT - but it is in the data
"Marshall Islands"
"Mauritania"
"Mauritius"
"Melanesia"
"Mexico"
"Micronesia"
"Middle Africa"
"Mongolia"
"Montenegro"
*start: 2006
"Morocco"
"Mozambique"
"Myanmar"
"Namibia"
"Nauru"
"Nepal"
"Net Food Importing Developing Countries"
"Netherlands"
"Netherlands Antilles (former)"
*start: 2010
"New Caledonia"
"New Zealand"
"Nicaragua"
"Niger"
"Nigeria"
"Niue"
"Norfolk Island"
"Northern Africa"
"Northern America"
"Northern Europe"
"Norway"
"Occupied Palestinian Territory"
"Oceania"
"Oman"
"Pacific Islands Trust Territory"
*start: 1990
"Pakistan"
"Panama"
"Papua New Guinea"
"Paraguay"
"Peru"
"Philippines"
"Poland"
"Polynesia"
"Portugal"
"Qatar"
"Republic of Korea"
"Republic of Moldova"
*start: 1992
"Romania"
"Russian Federation"
*start: 1992
"Rwanda"
"Saint Kitts and Nevis"
"Saint Lucia"
"Saint Pierre and Miquelon"
"Saint Vincent and the Grenadines"
"Samoa"
"Sao Tome and Principe"
"Saudi Arabia"
"Senegal"
"Serbia"
*start 2006
"Serbia and Montenegro"
*start: 1992; end: 2005
"Seychelles"
"Sierra Leone"
"Singapore"
"Slovakia"
*start: 1993
"Slovenia"
*start: 1992
"Small Island Developing States"
"Solomon Islands"
"Somalia"
"South Africa"
"South America"
"South Sudan"
*start: 2012
"South-Eastern Asia"
"Southern Africa"
"Southern Asia"
"Southern Europe"
"Spain"
"Sri Lanka"
"Sudan"
*start: 2012
*"Sudan (former)"
*end: 2011
"Suriname"
"Swaziland"
"Sweden"
*"Switzerland"
"Syrian Arab Republic"
"Tajikistan"
*start: 1992
"Thailand"
"The former Yugoslav Republic of Macedonia"
*start: 1992
"Timor-Leste"
"Togo"
"Tonga"
"Trinidad and Tobago"
"Tunisia"
"Turkey"
"Turkmenistan"
*start: 1992
"Tuvalu"
"Uganda"
"Ukraine"
*startt: 1992
"United Arab Emirates"
"United Kingdom"
"United Republic of Tanzania"
"United States of America"
"Uruguay"
"USSR"
*end: 1991
"Uzbekistan"
*start: 1992
"Vanuatu"
"Venezuela (Bolivarian Republic of)"
"Viet Nam"
"Western Africa"
"Western Asia"
"Western Europe"
"World"
"Yemen"
"Yugoslav SFR"
*end: 1991
"Zambia"
"Zimbabwe"
*till here it equals the set FAOSTAT_CountriesAndRegions
*the following is a categorisation currently not used officially in FAOSTAT - but we need it for certain assignments and thus introduce it to this set
*"Developed Countries"
*"Developing Countries"
*"Indian Subcontinent"

/;



alias(GeographicRegionDO,GeographicRegion2DO);
$ontext
* needed for trade (13.08.19):
$onmulti
Set FAOSTAT_Subcontinents(FAOSTAT_Regions) /
World
Switzerland
/;
$offmulti
$offtext

SET ProductionTypeDO(ProductionSystems) /
AllProdSyst
Convent, Organic
/;

SET ProductionTypeOrgConv(ProductionSystems) /
Convent, Organic
/;

SET ProductionConditionsDO(ProductionConditions) /
AllProdCond
/;

SET NutrientDO(SNDNutrients) /
"Energykcal"
"Proteing"
"Carbohydratesavailableg"
"Fattotalg"
/;


*******************************
*** FURTHER SET DEFINITIONS ***
*******************************

SET Origin /
'Domestic'
'Imported'
/;




SET ProcessingCommodities/
"Processed meat"
"Processed fish"
"Fruit and vegetable products"
"Oils and fats"
"Dairy products"
"Grain mill and starch products"
"Bakery and farinaceous products"
"Sugar"
"Chocolate and confectionery"
"Other food and tobacco products"
"Prepared animal feeds"
"Beverages"
/;

SET TransportVehicle /
Lorry
AircraftLorry
Aircraft
LorryA
ShipLorry
Ship
LorryS
/;

SET IndicatorDO for the transport data /
CED
GHG
/;

SET IndicatorUnits /
MJ
"kg CO2 eq"
/;


SET PerTonDomestAvailQuantParameterSOLmV5_DO /
'SoilErosion (t)'
'Deforest (ha)'
'CultOrgSoils (ha)'
'PlantProtection (index)'
'NSurplus (tN)'
'PSurplus (tP2O5)'
'DrinkingWater (m3)'

'LandUse (ha)'
'GrasslandUse (ha)'
'CroplandUse (ha)'
'GHGTotal (tCO2e)'

'Total Feed GHG inclDeforestOrgSoils (tCO2e)'
'EntericFermentation (tCO2e)'
'GHGManureManagement (tCO2e)'

'GHGRice (tCO2e)'
'GHGFertilizedSoils (tCO2e)'
'DeforestEmissions (tCO2e)'
'CultOrgSoilsEmissions (tCO2e)'

'GHGTransport (tCO2e)'
'GHGProcessing (tCO2e)'

'AHEI_mean'
/;

SET Indicator_Plots(PerTonDomestAvailQuantParameterSOLmV5_DO) /
*'SoilErosion (t)'
*'Deforest (ha)'
*'CultOrgSoils (ha)'
*'PlantProtection (index)'
'NSurplus (tN)'
'PSurplus (tP2O5)'
*'DrinkingWater (m3)'

'LandUse (ha)'
*'GrasslandUse (ha)'
*'CroplandUse (ha)'
'GHGTotal (tCO2e)'
/;

SET GHGImpacts_PerStage(PerTonDomestAvailQuantParameterSOLmV5_DO) /
'Total Feed GHG inclDeforestOrgSoils (tCO2e)'
'EntericFermentation (tCO2e)'
'GHGManureManagement (tCO2e)'

'GHGRice (tCO2e)'
'GHGFertilizedSoils (tCO2e)'
'DeforestEmissions (tCO2e)'
'CultOrgSoilsEmissions (tCO2e)'

'GHGTransport (tCO2e)'
'GHGProcessing (tCO2e)'
/;

SET GHGImpacts_DO(PerTonDomestAvailQuantParameterSOLmV5_DO) /
'GHGTotal (tCO2e)'
/;

SET LUImpacts_DO(PerTonDomestAvailQuantParameterSOLmV5_DO) /
'LandUse (ha)'
'GrasslandUse (ha)'
'CroplandUse (ha)'
/;


* check: in which module is it defined already? then this can be deleted again
SET PerTonPrimProdParameterDO /
'PerTonProdAggregate_SoilErosion (t/t)'
'PerTonProdAggregate_PlantProtection (index/t)'
'PerTonProdAggregate_NLossManureManagement (tN/t)'
'PerTonProdAggregate_NLossFertilizedSoils (tN/t)'
'PerTonProdAggregate_GHGManureManagement (tCO2e/t)'
'PerTonProdAggregate_GHGFertilizedSoils (tCO2e/t)'
'PerTonProdAggregate_EntericFermentation (tCO2e/t)'
'PerTonProdAggregate_DrinkingWater (m3/t)'
'PerTonProdAggregate_Deforest (ha/t)'
'PerTonProdAggregate_DeforestEmissions (tCO2e/t)'
'PerTonProdAggregate_GHGRice (tCO2e/t)'
'PerTonProdAggregate_GHGTotal (tCO2e/t)'
'PerTonProdAggregate_LandUse (ha/t)'
'PerTonProdAggregate_NLossTotal (tN/t)'
'PerTonProdAggregate_GHGTotal_InclDeforestOrgsoils (tCO2e/t)'

* new, 15.12.18, AF:
'PerTonProdAggregate_CEDTotal (MJ/t)'
'PerTonProdAggregate_CEDN-Fertilizer (MJ/kg N)'
'PerTonProdAggregate_CEDP205-Mineral (MJ/kg P205)'
'PerTonProdAggregate_GHGCED (tCO2e/t)'
/;

$ontext
SET PerTonIndicatorDO(PerTonPrimProdParameterDO) /
'PerTonProdAggregate_GHGTotal (tCO2e/t)'
'PerTonProdAggregate_LandUse ( [tCO2e]/t)'
'PerTonProdAggregate_NLossTotal (tN/t)'
/;
$offtext

SET PerTonIndicatorDO(PerTonDomestAvailQuantParameterSOLmV5_DO) /
'LandUse (ha)'
'GHGTotal (tCO2e)'
*'PerTonProdAggregate_NLossTotal (tN/t)'
/;



SET Indicator /
GHG
NSurplus
LandUse
tbd
AHEI_mean
GrasslandUse
CroplandUse

* von RSO:
BiodiversityLossPotential
Eutrophication

HouseholdExpenditure
SocialHotspotIndex
CompositeHealthIndex

DALYProduction

GHGMean

/;

SET scenario /
BaseYear2008Cluster1
BaseYear2008Cluster2
BaseYear2008Cluster3
BaseYear2008Cluster4

BaseYear2008
ReferenceScenario2050
SFP2050
FeedNoFood2050
FNFNoTemp2050
FNF2050_2
FNFNoTemp2050_2

Baseline
BaselineDerived
Opti
minGWP2050
minLU2050
minNSurplus2050
minweighted2050
minpenalty2050
minpenaltySFP2050

* additional scenarios for nfp69 calculator
* reference
ref
* portrait 1
p1_m25
p1_m50
p1_m100
* portrait 2
p2_lmp
* portrait 3
p3_fw25
p3_fw50
p3_fw100
* portrait 4
p4_bio25_ref
p4_bio50_ref
p4_bio100_ref
p4_bio25_fnf
p4_bio50_fnf
p4_bio100_fnf
* portrait 5
p5_dom50
* portrait 6
p6_m25_fw25
p6_m50_fw25
p6_m100_fw25
p6_m25_fw50
p6_m50_fw50
p6_m100_fw50
p6_m25_fw100
p6_m50_fw100
p6_m100_fw100
/;

SET nfp69scenarios(scenario) /
ref
* portrait 1
p1_m25
p1_m50
p1_m100
* portrait 2
p2_lmp
* portrait 3
p3_fw25
p3_fw50
p3_fw100
* portrait 4
p4_bio25_ref
p4_bio50_ref
p4_bio100_ref
p4_bio25_fnf
p4_bio50_fnf
p4_bio100_fnf
* portrait 5
p5_dom50
* portrait 6
p6_m25_fw25
p6_m50_fw25
p6_m100_fw25
p6_m25_fw50
p6_m50_fw50
p6_m100_fw50
p6_m25_fw100
p6_m50_fw100
p6_m100_fw100
p7_fw25_all50
p7_fw50_all100
/;

SET scenarios_p6_meat25(scenario) /
p6_m25_fw25
p6_m25_fw50
p6_m25_fw100
/;

SET scenarios_p6_meat50(scenario) /
p6_m50_fw25
p6_m50_fw50
p6_m50_fw100
/;

SET scenarios_p6_meat100(scenario) /
p6_m100_fw25
p6_m100_fw50
p6_m100_fw100
/;

SET optiscens(scenario) /
minGWP2050
minLU2050
*minNSurplus2050
*minweighted2050
minpenalty2050
minpenaltySFP2050
/;

* used for AHEI:
SET inactivescenarios(scenario) /
Baseline
BaselineDerived
Opti
*minGWP2050
*minLU2050
minNSurplus2050
minweighted2050
*minpenalty2050
*minpenaltySFP2050
/;


SET testscens(scenario) /
BaseYear2008Cluster1
BaseYear2008Cluster2
BaseYear2008Cluster3
BaseYear2008Cluster4

BaseYear2008

FNF2050_2
FNFNoTemp2050_2
/;

SET FNFscenarios(scenario) /
FeedNoFood2050
FNFNoTemp2050
FNF2050_2
FNFNoTemp2050_2
/;


SET futurescenarios(scenario) /
ReferenceScenario2050
SFP2050
FeedNoFood2050
FNFNoTemp2050
*Opti
minGWP2050
minLU2050
*minNSurplus2050
*minweighted2050
minpenalty2050
minpenaltySFP2050
/;

SET scenariosOHNEReference(scenario) /
SFP2050
FeedNoFood2050
FNFNoTemp2050
/;



SET expfutscens(scenario) /
ReferenceScenario2050
SFP2050
FeedNoFood2050
FNFNoTemp2050
/;

SET baseyearscenarios(scenario) /
BaseYear2008
BaseYear2008Cluster1
BaseYear2008Cluster2
BaseYear2008Cluster3
BaseYear2008Cluster4
/;

SET clusterscenarios(scenario) /
BaseYear2008Cluster1
BaseYear2008Cluster2
BaseYear2008Cluster3
BaseYear2008Cluster4
/;

SET productsdm
/
"Food cereals"
"Feed crops"
"Sugar crops"
"Root and tuber crops"
"Vegetables"
"Fruits"
"Grapes"
"Oil-bearing crops"
"Pulses"
"Bovine meat"
"Pork"
"Poultry"
"Eggs"
"Milk"
"Other animal products"
"Other vegetal products"
"Products not in SDM"
/;

SET Goal /
GWP
NSurplus
LandUse
/;

SET WeightChoice /
w1*w7
/;

SET FoodGroupsBeretta /
"Apples"
"Other fresh fruits"
"Exotic fruits and berries"
"Canned fruits"
"Potatoes"
"Fresh vegetables"
"Legumes"
"Storable vegetables"
"Processed vegetables"
"Bread and pastries"
"Pasta"
"Rice"
"Maize"
"Sugar"
"Vegetal oils and fats"
"Nuts, seeds, oileiferous fruits"
"Milk, other dairy products"
"Cheese, whey"
"Butter, buttermilk"
"Eggs"
"Pork"
"Poultry"
"Beef, horse, veal"
"Fish, shellfish"
"Cocoa, coffee, tea"
"Restaurant"
"Softdrink"
"Water"
"Beer"
"Beverages, alcoholic"
/;

SET eeiom /
"g01f"
"g15j"
"g15f"
"g55b"
"g15e"
"g15c"
"g41"
"g01e"
"g15g"
"g15l2"
"g15i"
"g01n"
"g15d"
"g01p"
"g15a3"
"g05"
"g01d"
"g15b"
"g15a1"
"g15h"
"g15l1"
"g01g"
"g15a2"
"g01j"
"g01i"
"Sauce, Braten Würzmittel, Gewürze, Hefen, Kräuter "
"Sauce n.s. (salzig) Würzmittel, Gewürze, Hefen, Kr"
"g01h"
"Suppe, Haferkern Suppen und Bouillons Suppen"
"Tomatensauce Würzmittel, Gewürze, Hefen, Kräuter u"
"Suppe n.s. Suppen und Bouillons Suppen"
"Suppe, Fleisch Suppen und Bouillons Suppen"
"Sauce, Rahm Würzmittel, Gewürze, Hefen, Kräuter un"
"Sauce, Gemüse Würzmittel, Gewürze, Hefen, Kräuter "
"g01a"
"Sauce, Pilz Würzmittel, Gewürze, Hefen, Kräuter un"
"Sauce, Curry Würzmittel, Gewürze, Hefen, Kräuter u"
"Sauce Bolognaise Würzmittel, Gewürze, Hefen, Kräut"
"Suppe, Bündner Gersten Suppen und Bouillons Suppen"
"Sauce, Bechamel Würzmittel, Gewürze, Hefen, Kräute"
"Sauce, weiss Würzmittel, Gewürze, Hefen, Kräuter u"
"Salsa all' arrabiata Würzmittel, Gewürze, Hefen, K"
"Sauce, Carbonara Würzmittel, Gewürze, Hefen, Kräut"
"Bouillon zubereitet n.s. Suppen und Bouillons Boui"
"Sauce, Knoblauch Würzmittel, Gewürze, Hefen, Kräut"
"Suppe, Buchstaben Suppen und Bouillons Bouillons"
"Bouillon zubereitet, Gemüse Suppen und Bouillons B"
"Sauce Hollandaise Würzmittel, Gewürze, Hefen, Kräu"
"Sauce, Pesto Würzmittel, Gewürze, Hefen, Kräuter u"
"Bouillon zubereitet, Rind Suppen und Bouillons Bou"
"Bouillon zubereitet, Geflügel Suppen und Bouillons"
"Sauce, Käse Würzmittel, Gewürze, Hefen, Kräuter un"
"Sauce, Cocktail Würzmittel, Gewürze, Hefen, Kräute"
"Sauce, Cinque Pi Würzmittel, Gewürze, Hefen, Kräut"
"Mostarda di Frutta Würzmittel, Gewürze, Hefen, Krä"
"Sauce, Meeresfrüchte Würzmittel, Gewürze, Hefen, K"
"Bouillon zubereitet, Fleisch Suppen und Bouillons "
"Suppe, Flädli Suppen und Bouillons Bouillons"
"Serviettenknödel Getreide, Getreideprodukte und Kö"
"Suppe, Gazpacho n.s. Suppen und Bouillons Suppen"
"Chutney Würzmittel, Gewürze, Hefen, Kräuter und Sa"
"Sulz Diverse Lebensmittel Nicht spezifizierte sowi"
"Suppe, Gulasch Suppen und Bouillons Suppen"
"Trauben Früchte, Nüsse und Samen Früchte"
"Suppe, Champignon Suppen und Bouillons Suppen"
"Sauce, Kräuter Würzmittel, Gewürze, Hefen, Kräuter"
"Bouillon zubereitet, Fisch Suppen und Bouillons Bo"
"Suppe, Fisch Suppen und Bouillons Suppen"
"Sauce, Pesto Rosso Würzmittel, Gewürze, Hefen, Krä"
"Suppe, klar Suppen und Bouillons Bouillons"
"Suppe, Crème n.s. Suppen und Bouillons Suppen"
"Sauce, Barbecue Würzmittel, Gewürze, Hefen, Kräute"
"g01b"
/;

SET unit_export /
"Amount CH (t/year)"
"Amount per person (t/year)"
"Nutrient per person per day"
/;


SET FAOSTATCommoditiesTrade /
"Meat, chicken"
"Food prep nes"
"Sugar refined"
"Cigarettes"
"Cream fresh"
"Milk, skimmed dried"
"Beverages, non alcoholic"
"Cheese, whole cow milk"
"Wheat"
"Jute"
"Cotton lint"
"Tea"
"Meat, cattle"
"Sugar confectionery"
"Milk, whole evaporated"
"Eggs, hen, in shell"
"Tobacco products nes"
"Bananas"
"Yoghurt, concentrated or not"
"Forage products"
"Meat, goat"
"Dates"
"Wine"
"Infant food"
"Animal fats"
"Beer"
"Bovine Meat"
"Poultry Meat"
"Pulses"
"Tobacco"
"Alcoholic Beverages"
"Apples and products"
"Barley and products"
"Beverages, Alcoholic"
"Cereals - Excluding Beer"
"Citrus, Other"
"Cocoa Beans and products"
"Coffee and products"
"Fruits - Excluding Wine"
"Fruits, Other"
"Maize and products"
"Miscellaneous"
"Oilcrops Oil, Other"
"Olive Oil"
"Oranges, Mandarines"
"Palm Oil"
"Pulses, Other and products"
"Rape and Mustard Oil"
"Rice (Milled Equivalent)"
"Rice (Paddy Equivalent)"
"Soyabean Oil"
"Spices"
"Spices, Other"
"Stimulants"
"Sugar & Sweeteners"
"Sugar (Raw Equivalent)"
"Sugar, Raw Equivalent"
"Sugar, Refined Equiv"
"Sunflowerseed Oil"
"Sweeteners, Other"
"Tea (including mate)"
"Vegetable Oils"
"Vegetables"
"Vegetables, Other"
"Wheat and products"
"Butter, Ghee"
"Cheese"
"Cream"
"Eggs"
"Fats, Animals, Raw"
"Fish, Seafood"
"Freshwater Fish"
"Honey"
"Meat"
"Milk - Excluding Butter"
"Milk, Skimmed"
"Milk, Whole"
"Wool (Clean Eq.)"
"Fruit, dried nes"
"Juice, fruit nes"
"Grapes"
"Lemons and limes"
"Maize"
"Oranges"
"Cake, soybeans"
"Beans, dry"
"Chick peas"
"Grapefruit (inc. pomelos)"
"Kiwi fruit"
"Linseed"
"Pears"
"Tangerines, mandarins, clementines, satsumas"
"Oil, cottonseed"
"Oil, sunflower"
"Tallow"
"Chocolate products nes"
"Crude materials"
"Groundnuts, shelled"
"Meat, cattle, boneless (beef & veal)"
"Meat, pig, preparations"
"Offals, edible, cattle"
"Pastry"
"Plums dried (prunes)"
"Vegetables, frozen"
"Wafers"
"Margarine, short"
"Meat, sheep"
"Butter, cow milk"
"Almonds shelled"
"Fat, nes, prepared"
"Anise, badian, fennel, coriander"
"Chillies and peppers, dry"
"Oilseeds nes"
"Onions, dry"
"Potatoes"
"Spices, nes"
"Beer of barley"
"Oil, rapeseed"
"Meat, pig"
"Milk, whole fresh cow"
"Buttermilk, curdled, acidified milk"
"Cereals, breakfast"
"Cheese, processed"
"Coffee, extracts"
"Coffee, roasted"
"Fat, cattle"
"Feed and meal, gluten"
"Feed, compound, nes"
"Flour, wheat"
"Food preparations, flour, malt extract"
"Food wastes"
"Fruit, prepared nes"
"Glucose and dextrose"
"Juice, citrus, single strength"
"Juice, grapefruit"
"Juice, orange, single strength"
"Juice, pineapple"
"Juice, tomato"
"Macaroni"
"Malt"
"Meat, beef, preparations"
"Meat, chicken, canned"
"Meat, pig sausages"
"Meat, pork"
"Mushrooms, canned"
"Offals, pigs, edible"
"Pet food"
"Sugar, nes"
"Tea, mate extracts"
"Vegetables in vinegar"
"Vegetables, dehydrated"
"Vegetables, homogenized preparations"
"Vegetables, preserved nes"
"Waters,ice etc"
"Beverages, distilled alcoholic"
"Oil, palm"
"Oil, groundnut"
"Oil, linseed"
"Skins, sheep, with wool"
"Milk, whole dried"
"Whey, dry"
"Bread"
"Cider etc"
"Cocoa, powder & cake"
"Feed, vegetable products nes"
"Grease incl. lanolin wool"
"Milk, products of natural constituents nes"
"Offals, liver chicken"
"Potatoes, frozen"
"Molasses"
"Milk, skimmed cow"
"Milk, whole condensed"
"Bacon and ham"
"Cake, sunflower"
"Flour, maize"
"Fruit, cooked, homogenized preparations"
"Ice cream and edible ice"
"Vermouths & similar"
"Coffee, green"
"Melons, other (inc.cantaloupes)"
"Pepper (piper spp.)"
"Watermelons"
"Sugar Raw Centrifugal"
"Meat, goose and guinea fowl"
"Meat, turkey"
"Lard"
"Coffee, substitutes containing coffee"
"Fat, pigs"
"Hides, cattle, wet salted"
"Lactose"
"Waxes vegetable"
"Cinnamon (canella)"
"Lentils"
"Oats"
"Rye"
"Tobacco, unmanufactured"
"Walnuts, with shell"
"Oil, olive, virgin"
"Cashew nuts, shelled"
"Cereal preparations, nes"
"Flour, mustard"
"Hazelnuts, shelled"
"Juice, orange, concentrated"
"Oats rolled"
"Oil, boiled etc"
"Oil, olive residues"
"Raisins"
"Straw husks"
"Sweet corn frozen"
"Tomatoes, paste"
"Walnuts, shelled"
"Sesame seed"
"Nuts, prepared (exc. groundnuts)"
"Peaches and nectarines"
"Chestnut"
"Coconuts"
"Garlic"
"Ginger"
"Pistachios"
"Vanilla"
"Beeswax"
"Honey, natural"
"Apricots, dry"
"Cotton, carded, combed"
"Flour, mixed grain"
"Rubber natural dry"
"Tomatoes, peeled"
"Vegetables, preserved, frozen"
"Mangoes, mangosteens, guavas"
"Pineapples"
"Eggplants (aubergines)"
"Oil, soybean"
"Mixes and doughs"
"Cigars, cheroots"
"Beans, green"
"Chillies and peppers, green"
"Flax fibre and tow"
"Vegetables, fresh nes"
"Beet pulp"
"Vegetables, fresh or dried products nes"
"Vegetables, temporarily preserved"
"Tomatoes"
"Juice, grapefruit, concentrated"
"Sweet corn prep or preserved"
"Hops"
"Meat, duck"
"Eggs, dried"
"Fatty acids"
"Meat, dried nes"
"Oil, essential nes"
"Apples"
"Apricots"
"Artichokes"
"Avocados"
"Barley"
"Broad beans, horse beans, dry"
"Cabbages and other brassicas"
"Carrots and turnips"
"Cashew nuts, with shell"
"Cauliflowers and broccoli"
"Cherries"
"Cherries, sour"
"Cottonseed"
"Cranberries"
"Cucumbers and gherkins"
"Fruit, fresh nes"
"Fruit, tropical fresh nes"
"Leeks, other alliaceous vegetables"
"Lettuce and chicory"
"Mushrooms and truffles"
"Nuts, nes"
"Olives"
"Persimmons"
"Plums and sloes"
"Pumpkins, squash and gourds"
"Quinces"
"Spinach"
"Strawberries"
"Oil, coconut (copra)"
"Oil, maize"
"Oil, palm kernel"
"Eggs, other bird, in shell"
"Alfalfa meal and pellets"
"Barley, pearled"
"Bran, maize"
"Bran, wheat"
"Brazil nuts, shelled"
"Cake, cottonseed"
"Cake, rapeseed"
"Coconuts, desiccated"
"Cotton waste"
"Eggs, liquid"
"Figs dried"
"Flax tow waste"
"Flour, cereals"
"Flour, potatoes"
"Germ, maize"
"Juice, citrus, concentrated"
"Juice, grape"
"Juice, pineapple, concentrated"
"Meal, meat"
"Oils, fats of animal nes"
"Olives preserved"
"Pineapples canned"
"Soya sauce"
"Canary seed"
"Millet"
"Rapeseed"
"Nutmeg, mace and cardamoms"
"Cake, copra"
"Meat, nes"
"Asparagus"
"Cloves"
"Cocoa, beans"
"Figs"
"Grain, mixed"
"Peas, dry"
"Peas, green"
"Rubber, natural"
"Oil, sesame"
"Meat, game"
"Meat, rabbit"
"Cake, palm kernel"
"Fatty substance residues"
"Juice, lemon, concentrated"
"Maple sugar and syrups"
"Offals, sheep,edible"
"Oil, vegetable origin nes"
"Sweet potatoes"
"Offals, liver duck"
"Cassava dried"
"Onions, shallots, green"
"Oil, safflower"
"Cake, linseed"
"Skins, sheep, wet salted"
"Starch, cassava"
"Sunflower seed"
"Onions"
"Pigmeat"
"Alcohol, Non-Food"
"Beans"
"Beverages, Fermented"
"Brans"
"Cassava and products"
"Cereals, Other"
"Coconut Oil"
"Coconuts - Incl Copra"
"Copra Cake"
"Cottonseed Cake"
"Cottonseed Oil"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Groundnut Oil"
"Groundnuts (in Shell Eq)"
"Groundnuts (Shelled Eq)"
"Hard Fibres, Other"
"Lemons, Limes and products"
"Maize Germ Oil"
"Millet and products"
"Nuts and products"
"Oilcrops"
"Oilcrops, Other"
"Oilseed Cakes, Other"
"Olives (including preserved)"
"Palmkernel Cake"
"Palmkernel Oil"
"Peas"
"Pepper"
"Pimento"
"Pineapples and products"
"Plantains"
"Potatoes and products"
"Rape and Mustard Cake"
"Rape and Mustardseed"
"Roots & Tuber Dry Equiv"
"Rubber"
"Rye and products"
"Sesameseed Oil"
"Soft-Fibres, Other"
"Soyabean Cake"
"Soyabeans"
"Starchy Roots"
"Sunflowerseed Cake"
"Tomatoes and products"
"Treenuts"
"Aquatic Animals, Others"
"Aquatic Plants"
"Aquatic Products, Other"
"Cephalopods"
"Crustaceans"
"Demersal Fish"
"Fish Meal"
"Fish, Body Oil"
"Fish, Liver Oil"
"Hides and skins"
"Marine Fish, Other"
"Meat Meal"
"Meat, Other"
"Molluscs, Other"
"Mutton & Goat Meat"
"Offals"
"Offals, Edible"
"Pelagic Fish"
"Whey"
"Sorghum"
"Soybeans"
"Buckwheat"
"Wool, greasy"
"Wool, degreased"
"Wool, hair waste"
"Papayas"
"Coffee, husks and skins"
"Mustard seed"
"Roots and tubers, nes"
"Copra"
"Flour, pulses"
"Fructose and syrup, other"
"Oil, castor beans"
"Cocoa, butter"
"Cocoa, paste"
"Poppy seed"
"Roots, Other"
"Sorghum and products"
"Palm kernels"
"Whey, condensed"
"Hides, nes"
"Gooseberries"
"Maté"
"Pyrethrum, dried"
"Triticale"
"Cocoons, unreelable & waste"
"Flour, roots and tubers nes"
"Sisal"
"Dregs from brewing, distillation"
"Feed supplements"
"Flax fibre raw"
"Hair, fine"
"Cotton linter"
"Silk-worm cocoons, reelable"
"Silk raw"
"Cake, maize"
"Skins, sheep, dry salted"
"Silk"
"Sugar beet"
"Cheese, sheep milk"
"Fat, liver prepared (foie gras)"
"Peanut butter"
"Sugar Crops"
"Blueberries"
"Meat, horse"
"Sugar cane"
"Yams"
"Hay (unspecified)"
"Skins, goat, wet salted"
"Maize, green"
"Bran, millet"
"Feed, pulp of fruit"
"Currants"
"Offals, liver geese"
"Bambara beans"
"Sugar crops, nes"
"Meat, beef and veal sausages"
"Skins, calve, wet salted"
"Kola nuts"
"Cake, groundnuts"
"Fonio"
"Groundnut Cake"
"Jute-Like Fibres"
"Cake, safflower"
"Manila fibre (abaca)"
"Beverages, fermented rice"
"Oil, citronella"
"Margarine, liquid"
"Abaca"
"Sugar non-centrifugal"
"Oil, rice bran"
"Ricebran Oil"
"Cake, mustard"
"Cake, sesame seed"
"Sesameseed Cake"
"Bulgur"
"Vitamins"
"Hair, goat, coarse"
"Offals, edible, goats"
"Cake, rice bran"
"Peppermint"
"Soya paste"
/;


* XXAF added 08.10.19, bcs FAOSTATRegion currently not in GeneralModelSets.gdx
Set FAOSTAT_Regions Sub-set containing all region names that may be used in FAOSTAT
*as contained in the file FAOSTAT_CountryAndRegionsDefinition_11_12_2017.csv
*the entries with code above 5000
/
"World"

"Africa"
"Americas"
"Asia"
"Europe"
"Oceania"

"Eastern Africa"
"Middle Africa"
"Northern Africa"
"Southern Africa"
"Western Africa"

"Caribbean"
"Central America"
"Northern America"
"South America"

"Central Asia"
"Eastern Asia"
"South-Eastern Asia"
"Southern Asia"
"Western Asia"

"Eastern Europe"
"Northern Europe"
"Southern Europe"
"Western Europe"

"Australia & New Zealand"
"Melanesia"
"Micronesia"
"Polynesia"


"European Union"
"Land Locked Developing Countries"
"Least Developed Countries"
"Low Income Food Deficit Countries"
"Net Food Importing Developing Countries"
"Small Island Developing States"


*the following are added to the groups used by FAOSTAT, as we need them as well already when filing in data (from IPCC, for example)
"Developed Countries"
"Developing Countries"
"Indian Subcontinent"
/;



$exit
alias(CommoditySOLmV5,CommoditySOLmV5_ModelRun);
alias(ActivitySOLmV5,ActivitySOLmV5_ModelRun);
alias(OutputTypeSOLmV5,OutputTypeSOLmV5_ModelRun);
alias(GeographicRegionSOLmV5,GeographicRegionSOLmV5_ModelRun);
alias(GeographicRegionSOLmV5_ModelRun,GeographicRegionSOLmV5_ModelRun2);
alias(GeographicRegionSOLmV5_ModelRun,GeographicRegionSOLmV5_ModelRun3);


