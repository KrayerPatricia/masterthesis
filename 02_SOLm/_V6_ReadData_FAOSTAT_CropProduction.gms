PUTCLOSE con,"_V6_ReadData_FAOSTAT_CropProduction";

$ontext;
GENERAL DESCRIPTION
This file reads the crop production data from FAOSTAT

*DETAILED TABLE OF CONTENTS
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
$ifthen %ReadNewFAOSTATCropProductionData% == "YES"
$call csv2gdx FAOSTAT_CropProductionNormalized_28_11_2017.csv id=FAOSTAT_CropProduction Index=(2,4,6,8,9) Values=(10) UseHeader=Y
*contains FAO crop production data: areas harvested, yields, production quantitites, seed quantities
$call csv2gdx FAOSTAT_CropsProcessedNormalized_29_11_2017.csv id=FAOSTAT_CropsProcessedProduction Index=(2,4,6,8,9) Values=(10) UseHeader=Y
*contains production data on crops processed - is only production in tonnes - thus no areas or yields involved.
$endif;



Parameter FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits);
Parameter FAOSTAT_CropsProcessedProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropsPRocessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits);

$gdxin FAOSTAT_CropProductionNormalized_28_11_2017.gdx
$load FAOSTAT_CropProduction
$gdxin

$gdxin FAOSTAT_CropsProcessedNormalized_29_11_2017.gdx
$load FAOSTAT_CropsProcessedProduction
$gdxin

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) build average over the base year period chosen to get the baseline values

PARAMETER NumberOfBasisYearsFAOSTATCropProduction;
PARAMETER NumberOfBasisYearsFAOSTATCropsProcessedProduction;
PARAMETER NumberOfBasisYearsFAOSTATCropProduction_ForSeeds;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....
*a specific prodcedure for seeds is needed, as seeds reported in year t-1 are used in year t and not in t-1.

*to efficiently code this, the following subset is needed:
Set FAOSTAT_CropProductionElements_NotYieldNotSeed(FAOSTAT_CropProductionElements)
/
"Area harvested", "Production"
/;

NumberOfBasisYearsFAOSTATCropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,FAOSTAT_CropProductionUnits)
         = SUM(BasisYears$FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,BasisYears,FAOSTAT_CropProductionUnits),1);
FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,"AverageBasisYear",FAOSTAT_CropProductionUnits)
                 $NumberOfBasisYearsFAOSTATCropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,FAOSTAT_CropProductionUnits)
         = SUM(BasisYears,FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,BasisYears,FAOSTAT_CropProductionUnits))
                 /NumberOfBasisYearsFAOSTATCropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,FAOSTAT_CropProductionUnits);

NumberOfBasisYearsFAOSTATCropsProcessedProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropsProcessedItems)
         = SUM(BasisYears$FAOSTAT_CropsProcessedProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropsProcessedItems,"Production",BasisYears,"Tonnes"),1);
FAOSTAT_CropsProcessedProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropsProcessedItems,"Production","AverageBasisYear","tonnes")
                 $NumberOfBasisYearsFAOSTATCropsProcessedProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropsProcessedItems)
         = SUM(BasisYears,FAOSTAT_CropsPRocessedProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropsProcessedItems,"Production",BasisYears,"tonnes"))
                 /NumberOfBasisYearsFAOSTATCropsProcessedProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropsProcessedItems);

NumberOfBasisYearsFAOSTATCropProduction_ForSeeds(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems)
         = SUM(BasisYears$FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,"Seed",BasisYears,"tonnes"),1);
FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,"Seed","AverageBasisYear","tonnes")
                 $NumberOfBasisYearsFAOSTATCropProduction_ForSeeds(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems)
         = SUM(BasisYears,FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,"Seed",BasisYears,"tonnes"))
                 /NumberOfBasisYearsFAOSTATCropProduction_ForSeeds(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);

*derive the average yields:
*factor 10000 to transform tonnes into hg
FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,"Yield","AverageBasisYear","hg/ha")
                 $FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,"Area harvested","AverageBasisYear","ha")
         = FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,"Production","AverageBasisYear","tonnes")*10000
                 /FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,"Area harvested","AverageBasisYear","ha");

*to avoid double counting: drop China subregions here and retain China only:
FAOSTAT_CropProduction("China",FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 $(NOT FAOSTAT_CropProduction("China",FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits))
         = FAOSTAT_CropProduction("China, Hong Kong SAR",FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 + FAOSTAT_CropProduction("China, Macao SAR",FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 + FAOSTAT_CropProduction("China, mainland",FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 + FAOSTAT_CropProduction("China, Taiwan Province of",FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits);

FAOSTAT_CropsProcessedProduction("China",FAOSTAT_CropsProcessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 $(NOT FAOSTAT_CropsProcessedProduction("China",FAOSTAT_CropsProcessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits))
         = FAOSTAT_CropsProcessedProduction("China, Hong Kong SAR",FAOSTAT_CropsProcessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 + FAOSTAT_CropsProcessedProduction("China, Macao SAR",FAOSTAT_CropsProcessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 + FAOSTAT_CropsProcessedProduction("China, mainland",FAOSTAT_CropsProcessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 + FAOSTAT_CropsProcessedProduction("China, Taiwan Province of",FAOSTAT_CropsProcessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits);

FAOSTAT_CropProduction("China, Hong Kong SAR",FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;
FAOSTAT_CropProduction("China, Macao SAR",FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;
FAOSTAT_CropProduction("China, mainland",FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;
FAOSTAT_CropProduction("China, Taiwan Province of",FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;

FAOSTAT_CropsProcessedProduction("China, Hong Kong SAR",FAOSTAT_CropsProcessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;
FAOSTAT_CropsProcessedProduction("China, Macao SAR",FAOSTAT_CropsProcessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;
FAOSTAT_CropsProcessedProduction("China, mainland",FAOSTAT_CropsProcessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;
FAOSTAT_CropsProcessedProduction("China, Taiwan Province of",FAOSTAT_CropsProcessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;



$ontext;
after this, we have
Parameter FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits);
Parameter FAOSTAT_CropsProcessedProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropsProcessedItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

*assign the crop primary production to activities:
*drop all that seem aggregates - to avoid double counting
Set MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
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
"Cassava leaves"."Cassava leaves"
"Castor oil seed"."Castor oil seed"
"Cauliflowers and broccoli"."Cauliflowers and broccoli"
"Cereals (Rice Milled Eqv)"."Cereals (Rice Milled Eqv)"
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
"Coir"."Coir"
"Cotton lint"."Cotton lint"
"Cottonseed"."Cottonseed"
"Cow peas, dry"."Cow peas, dry"
"Cranberries"."Cranberries"
"Cucumbers and gherkins"."Cucumbers and gherkins"
"Currants"."Currants"
"Dates"."Dates"
"Eggplants (aubergines)"."Eggplants (aubergines)"
"Fibre crops nes"."Fibre crops nes"
"Fibre Crops Primary"."Fibre Crops Primary"
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
"Jute & Jute-like Fibres"."Jute & Jute-like Fibres"
"Kapok fibre"."Kapok fibre"
"Kapok fruit"."Kapok fruit"
"Kapokseed in shell"."Kapokseed in shell"
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
/;

*assign the FAOSTAT counties to SOLmV6 geographic regions
set MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
/
"Afghanistan"."Afghanistan"
"Albania"."Albania"
"Algeria"."Algeria"
"American Samoa"."American Samoa"
"Angola"."Angola"
"Antigua and Barbuda"."Antigua and Barbuda"
"Argentina"."Argentina"
"Armenia"."Armenia"
*start: 1992
"Aruba"."Aruba"
"Australia"."Australia"
"Austria"."Austria"
"Azerbaijan"."Azerbaijan"
*start: 1992
"Bahamas"."Bahamas"
"Bahrain"."Bahrain"
"Bangladesh"."Bangladesh"
"Barbados"."Barbados"
"Belarus"."Belarus"
*start: 1992
"Belgium"."Belgium"
*start: 2000
"Belgium-Luxembourg"."Belgium-Luxembourg"
*end: 1999
"Belize"."Belize"
"Benin"."Benin"
"Bermuda"."Bermuda"
"Bhutan"."Bhutan"
"Bolivia (Plurinational State of)"."Bolivia (Plurinational State of)"
"Bosnia and Herzegovina"."Bosnia and Herzegovina"
*start: 1992
"Botswana"."Botswana"
"Brazil"."Brazil"
"British Virgin Islands"."British Virgin Islands"
"Brunei Darussalam"."Brunei Darussalam"
"Bulgaria"."Bulgaria"
"Burkina Faso"."Burkina Faso"
"Burundi"."Burundi"
"Cabo Verde"."Cabo Verde"
"Cambodia"."Cambodia"
"Cameroon"."Cameroon"
"Canada"."Canada"
"Cayman Islands"."Cayman Islands"
"Central African Republic"."Central African Republic"
"Chad"."Chad"
"Chile"."Chile"
"China"."China"
*"China, Hong Kong SAR"."China, Hong Kong SAR"
*"China, Macao SAR"."China, Macao SAR"
*"China, mainland"."China, mainland"
*"China, Taiwan Province of"."China, Taiwan Province of"
"Colombia"."Colombia"
"Comoros"."Comoros"
"Congo"."Congo"
"Cook Islands"."Cook Islands"
"Costa Rica"."Costa Rica"
"Côte d'Ivoire"."Côte d'Ivoire"
"Croatia"."Croatia"
*start: 1992
"Cuba"."Cuba"
"Cyprus"."Cyprus"
"Czechia"."Czechia"
*start: 1993
"Czechoslovakia"."Czechoslovakia"
*end: 1992
"Democratic People's Republic of Korea"."Democratic People's Republic of Korea"
"Democratic Republic of the Congo"."Democratic Republic of the Congo"
"Denmark"."Denmark"
"Djibouti"."Djibouti"
"Dominica"."Dominica"
"Dominican Republic"."Dominican Republic"
"Ecuador"."Ecuador"
"Egypt"."Egypt"
"El Salvador"."El Salvador"
"Equatorial Guinea"."Equatorial Guinea"
"Eritrea"."Eritrea"
*start: 1993
"Estonia"."Estonia"
*start: 1992
"Ethiopia"."Ethiopia"
*start: 1993
"Ethiopia PDR"."Ethiopia PDR"
*end: 1992
"Falkland Islands (Malvinas)"."Falkland Islands (Malvinas)"
"Faroe Islands"."Faroe Islands"
"Fiji"."Fiji"
"Finland"."Finland"
"France"."France"
"French Polynesia"."French Polynesia"
"Gabon"."Gabon"
"Gambia"."Gambia"
"Georgia"."Georgia"
*start 1992
"Germany"."Germany"
"Ghana"."Ghana"
"Greece"."Greece"
"Grenada"."Grenada"
"Guam"."Guam"
"Guatemala"."Guatemala"
"Guinea"."Guinea"
"Guinea-Bissau"."Guinea-Bissau"
"Guyana"."Guyana"
"Haiti"."Haiti"
"Honduras"."Honduras"
"Hungary"."Hungary"
"Iceland"."Iceland"
"India"."India"
"Indonesia"."Indonesia"
"Iran (Islamic Republic of)"."Iran (Islamic Republic of)"
"Iraq"."Iraq"
"Ireland"."Ireland"
"Israel"."Israel"
"Italy"."Italy"
"Jamaica"."Jamaica"
"Japan"."Japan"
"Jordan"."Jordan"
"Kazakhstan"."Kazakhstan"
*start: 1992
"Kenya"."Kenya"
"Kiribati"."Kiribati"
"Kuwait"."Kuwait"
"Kyrgyzstan"."Kyrgyzstan"
*start: 1992
"Lao People's Democratic Republic"."Lao People's Democratic Republic"
"Latvia"."Latvia"
*start: 1992
"Lebanon"."Lebanon"
"Lesotho"."Lesotho"
"Liberia"."Liberia"
"Libya"."Libya"
"Lithuania"."Lithuania"
*start: 1992
"Luxembourg"."Luxembourg"
*start: 2000
"Madagascar"."Madagascar"
"Malawi"."Malawi"
"Malaysia"."Malaysia"
"Maldives"."Maldives"
"Mali"."Mali"
"Malta"."Malta"
"Marshall Islands"."Marshall Islands"
"Mauritania"."Mauritania"
"Mauritius"."Mauritius"
"Mexico"."Mexico"
"Mongolia"."Mongolia"
"Montenegro"."Montenegro"
*start: 2006
"Morocco"."Morocco"
"Mozambique"."Mozambique"
"Myanmar"."Myanmar"
"Namibia"."Namibia"
"Nauru"."Nauru"
"Nepal"."Nepal"
"Netherlands"."Netherlands"
"Netherlands Antilles (former)"."Netherlands Antilles (former)"
*start: 2010
"New Caledonia"."New Caledonia"
"New Zealand"."New Zealand"
"Nicaragua"."Nicaragua"
"Niger"."Niger"
"Nigeria"."Nigeria"
"Niue"."Niue"
"Norfolk Island"."Norfolk Island"
"Norway"."Norway"
"Occupied Palestinian Territory"."Occupied Palestinian Territory"
"Oman"."Oman"
"Pacific Islands Trust Territory"."Pacific Islands Trust Territory"
*start: 1990
"Pakistan"."Pakistan"
"Panama"."Panama"
"Papua New Guinea"."Papua New Guinea"
"Paraguay"."Paraguay"
"Peru"."Peru"
"Philippines"."Philippines"
"Poland"."Poland"
"Portugal"."Portugal"
"Qatar"."Qatar"
"Republic of Korea"."Republic of Korea"
"Republic of Moldova"."Republic of Moldova"
*start: 1992
"Romania"."Romania"
"Russian Federation"."Russian Federation"
*start: 1992
"Rwanda"."Rwanda"
"Saint Kitts and Nevis"."Saint Kitts and Nevis"
"Saint Lucia"."Saint Lucia"
"Saint Pierre and Miquelon"."Saint Pierre and Miquelon"
"Saint Vincent and the Grenadines"."Saint Vincent and the Grenadines"
"Samoa"."Samoa"
"Sao Tome and Principe"."Sao Tome and Principe"
"Saudi Arabia"."Saudi Arabia"
"Senegal"."Senegal"
"Serbia"."Serbia"
*start 2006
"Serbia and Montenegro"."Serbia and Montenegro"
*start: 1992; end: 2005
"Seychelles"."Seychelles"
"Sierra Leone"."Sierra Leone"
"Singapore"."Singapore"
"Slovakia"."Slovakia"
*start: 1993
"Slovenia"."Slovenia"
*start: 1992
"Solomon Islands"."Solomon Islands"
"Somalia"."Somalia"
"South Africa"."South Africa"
"South Sudan"."South Sudan"
*start: 2012
"Spain"."Spain"
"Sri Lanka"."Sri Lanka"
"Sudan"."Sudan"
*start: 2012
*"Sudan (former)"."Sudan (former)"
*end: 2011 - drop everywhere, as we have a baseline from 2008-2012 and then we double count Sudan - as any new baseline will be more recent, this is no problem, as we then anyway would not have Sudan (former) anymore
"Suriname"."Suriname"
"Swaziland"."Swaziland"
"Sweden"."Sweden"
"Switzerland"."Switzerland"
"Syrian Arab Republic"."Syrian Arab Republic"
"Tajikistan"."Tajikistan"
*start: 1992
"Thailand"."Thailand"
"The former Yugoslav Republic of Macedonia"."The former Yugoslav Republic of Macedonia"
*start: 1992
"Timor-Leste"."Timor-Leste"
"Togo"."Togo"
"Tonga"."Tonga"
"Trinidad and Tobago"."Trinidad and Tobago"
"Tunisia"."Tunisia"
"Turkey"."Turkey"
"Turkmenistan"."Turkmenistan"
*start: 1992
"Tuvalu"."Tuvalu"
"Uganda"."Uganda"
"Ukraine"."Ukraine"
*start: 1992
"United Arab Emirates"."United Arab Emirates"
"United Kingdom"."United Kingdom"
"United Republic of Tanzania"."United Republic of Tanzania"
"United States of America"."United States of America"
"Uruguay"."Uruguay"
"USSR"."USSR"
*end: 1991
"Uzbekistan"."Uzbekistan"
*start: 1992
"Vanuatu"."Vanuatu"
"Venezuela (Bolivarian Republic of)"."Venezuela (Bolivarian Republic of)"
"Viet Nam"."Viet Nam"
"Yemen"."Yemen"
"Yugoslav SFR"."Yugoslav SFR"
*end: 1991
"Zambia"."Zambia"
"Zimbabwe"."Zimbabwe"
/;

*3.2) Link to the core model parameters

*area harvested in hectares:
VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 FAOSTAT_CropProduction(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Area harvested","AverageBasisYear","ha"));

*main production in tonnes
VActCropsGrass_Outputs.l(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 FAOSTAT_CropProduction(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Production","AverageBasisYear","tonnes"));

*total seed inputs in tonnes
VActCropsGrass_Inputs.l(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 FAOSTAT_CropProduction(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Seed","AverageBasisYear","tonnes"));

*yield in tonnes per hectare
*division by 10000 to transform yields in hg/ha to tonnes/ha
ActCropsGrass_Outputs(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 FAOSTAT_CropProduction(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Yield","AverageBasisYear","hg/ha"))/10000;

*derive seed input per ha from seed quantity and areas harvested (better would be: area cropped, instead of harvested!):
*this is a very gross measure of seed use per ha to be improved, e.g. by DBK numbers or standard seed application rates for crops, etc.
ActCropsGrass_Inputs(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")
                 $VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")
         = VActCropsGrass_Inputs.l(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")
                 /VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond");


$ontext;
The following commodities (second column) are listed as activities, thus replace with partly new activities and assign to commodities as follows:

(New) Activity    which output is meant by MainOutputX   OutputsCropsGrass

*keep as it is - as cashewapple is not important: thus keep the activity "cashew nuts, with shell"
"Cashew"         ."Cashew nuts, with shell"              .MainOutput1
*unimportant:
*"Cashew"         ."Cashewapple"                          .MainOutput2
*ok as it is:
"Cassava"        ."Cassava"                              .MainOutput1
*unimportant:
*"Cassava"        ."Cassava leaves"                       .MainOutput2
*ok as it is:
"Coconuts"       ."Coconuts"                             .MainOutput1
*unimportant:
"Coconuts"       ."Coir"                                 .MainOutput2

*also keep as it is: oil, palm fruit is named strangely, it is "oil palm fruit" - but keep as it is as activity and main output is the fruit, kernel and oil is then derived.
"Oil, palm fruit"."Palm kernel"                          .MainOutput1, or rather: commodities, main output is palm fruits
"Oil, palm fruit"."Oil, palm"                            .MainOutput2, or rather: commodities, main output is palm fruits

*unimportant:
*"Seed cotton"    ."Cotton lint"                          .MainOutput3
*unimportant on activity level:
*"Seed cotton"    ."Cottonseed"                           .MainOutput2
*ok as it is:
"Seed cotton"    ."Seed cotton"                          .MainOutput1      NO - THIS IS ALSO RATHER THE MainOutput, while the previous two are derived from it!!??
*all the following are unimportant:
*"Hemp"           ."Hemp tow waste"                       .MainOutput2
*"Hemp"           ."Hempseed"                             .MainOutput1
*"Kapok fibre"."Kapok fibre"
*"Kapok fruit"."Kapok fruit"
*"Kapokseed in shell"."Kapokseed in shell"
*"Melonseed"."Melonseed"         THIS IS A DERIVED PRODUCT from the above activity - or is it from special melons...???? to be decided!!
*ok as it is:
"Melons, other (inc.cantaloupes)"."Melons, other (inc.cantaloupes)"  .MainOutput1
$oftext;

$ontext;
After this we have the following in SOLm entities:

VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")
VActCropsGrass_Outputs.l(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
VActCropsGrass_Inputs.l(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")
ActCropsGrass_Outputs(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
ActCropsGrass_Inputs(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")

Regions     is      FAOSTAT_Countries
Activities  is      FAOSTAT_CropProductionItems

*XXX STILL TO BE DONE:

Assign FAOSTAT_CropsProcessedProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropsProcessedItems,"Production","AverageBasisYear","tonnes")
this contains only few data on some oils, cotton and molasses, sugar, beer.

Do consistently: activities with two outputs (e.g. Coconuts: Coconuts and coir, etc.), cf. the list above in the CropProduction code

$offtext;




