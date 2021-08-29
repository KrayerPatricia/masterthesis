PUTCLOSE con,"_V6_ReadData_FAOSTAT_FOFA2050";

$ontext;
GENERAL DESCRIPTION
This file reads the data used in the FOFA2050 projections from FAO,
as available on http://www.fao.org/global-perspectives-studies/food-agriculture-projections-to-2050/en

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

*The following code uses a different baseline (2010-2014) than the general model ; thus, read in the gdx-file produced at the end in case nothing changed here. Otherwise execute the code - BUT CHANGE THE BASELINE BEFORE!!
$if %ReadNewFOFA2050Data% == "NO" $goto UseOldFOFA2050Data

*$ifthen %ReadNewFOFA2050Data% == "YES"
$call csv2gdx FOFA2050CountryData_Crop-production_20_7_2019.csv id=FOFA2050_CropProduction Index=(2,3,4,6,8,9,10) Values=(11) UseHeader=Y
*contains
$call csv2gdx FOFA2050CountryData_Fertilizer-and-emissions_20_7_2019.csv id=FOFA2050_FertilizerAndEmissions Index=(2,3,4,6,8,9,10) Values=(11) UseHeader=Y
*contains
$call csv2gdx FOFA2050CountryData_Food-security_20_7_2019.csv id=FOFA2050_FoodSecurity Index=(2,3,4,6,8,9,10) Values=(11) UseHeader=Y
*contains food security indicators:
$call csv2gdx FOFA2050CountryData_Livestock_20_7_2019.csv id=FOFA2050_Livestock Index=(2,3,4,6,8,9,10) Values=(11) UseHeader=Y
*contains livestock information: number of animals, yields
$call csv2gdx FOFA2050CountryData_Macro-indicators_20_7_2019.csv id=FOFA2050_MacroIndicators Index=(2,3,4,6,8,9,10) Values=(11) UseHeader=Y
*contains Macro indicators: GDP at market prices, total population

*ATTENTION ATTENTION:
*The following does not yet work - file empty, not possible to download correctly!!!!
*$call csv2gdx FOFA2050CountryData_Market.csv id=FOFA2050_Market Index=(2,4,6,8,9) Values=(10) UseHeader=Y
*contains

*ATTENTION ATTENTION:
*the following is not yet used - aggregates from country data, thus no need to file in
*$call csv2gdx FOFA2050RegionsData_all_20_7_2019.csv id=FOFA2050_RegionsData Index=(2,3,4,5,6,7,8) Values=(9) UseHeader=Y
*contains
*$endif;


*the data in the csv above is always organised as follows:
*Header: Domain,Indicator,Item,Element,CountryCode,CountryName,Region,Scenario,Units,Year,Value
*besides the last one, RegionsData, there it is:
*HEader: Domain,Indicator,Item,Element,Region,Scenario,Units,Year,Value

*the following sets are needed to read this data:
Set FOFA2050_Indicator_CropProduction
/
"Arable land"
"Harvested area"
"Cropping intensity"
"Climate shifter"
"Crop yield"
"Technology shifter"
/;
Set FOFA2050_Indicator_FertilizerEmissions
/
"NPK Consumption"
"GHG emissions in agriculture"
/;
Set FOFA2050_Indicator_FoodSecurity
/
"Daily energy supply by commodity"
"Daily protein supply"
"Daily energy consumption (DEC)"
"Daily energy supply (DES)"
"Number of Undernourished (NoU)"
"Percentage of Undernourished (PoU)"
/;
Set FOFA2050_Indicator_Livestock
/
Productivity
"Herd sizes"
/;
Set FOFA2050_Indicator_MacroIndicators
/
"GDP per capita"
"Population"
/;


Set FOFA2050_Item_CropProduction
/
"Growing of bananas"
"Growing of barley"
"Growing of cassava"
"Growing of coconuts"
"Growing of citrus fruits"
"Growing of coffee, green"
"Growing of raw cotton"
"Growing of groundnuts"
"Growing of grain maize"
"Growing of millet"
"Growing of oil palm fruit"
"Growing of paddy rice"
"Growing of potatoes"
"Growing of dried pulses"
"Growing of rape and mustardseed"
"Growing of natural rubber"
"Growing of sesame seed"
"Growing of sorghum"
"Growing of soybeans"
"Growing of sugar beet"
"Growing of sugar cane"
"Growing of sunflower seed"
"Growing of sweet potato and yams"
"Growing of tea"
"Growing of tobacco"
"Growing of wheat"
"Growing of other cereals"
"Growing of other crops"
"Growing of other fibre crops"
"Growing of other fruits"
"Growing of other oilseeds"
"Growing of other roots and tubers"
"Growing of other vegetables"
"Growing of cocoa beans"
"Growing of plantains"
"Growing of olives"
/;
Set FOFA2050_Item_FertilizerEmissions
/
"NPK_consumption"
"Total"
/;
Set FOFA2050_Item_FoodSecurity
/
Bananas
Barley
Cassava
Coconuts
"Coffee, green"
Millet
Olives
"Palm kernels"
Potatoes
"Sesame seed"
Sorghum
Soybeans
"Sugar beet"
"Sugar cane"
"Sunflower seed"
Tea
Wheat
"Sheep and Goat Meat"
Plantains
Pigmeat
"Poultry Meat"
"Cottonseed Oil"
"Groundnut Oil"
"Olive Oil"
"Citrus Fruits"
Total
ALL
"Beef and veal"
"Coconuts oil"
"Cocoa beans"
Fish
Groundnuts
"Grain maize"
"Milled rice"
"Palm kernel oil"
"Palm fruit oil"
"Dried pulses"
"Rapeseed oil"
"Raw milk"
"Sesame seed oil"
"Soya oil"
"Processed sugar"
"Sunflower seed oil"
"Sweet potato and yams"
"Other cereals"
"Other crops"
"Other fruits"
"Oilcrops, nes, oil"
"Other roots and tubers"
"Other vegetables"
"Other oilseeds"
"Rapeseed and mustard seed"
/;
Set FOFA2050_Item_Livestock
/
"Raising of buffaloes"
"Raising of cattle"
"Raising of goats"
"Raising of pigs"
"Raising of poultry"
"Raising of sheep"
"Livestock units"
/;
Set FOFA2050_Item_MacroIndicators
/
Total
/;

Set FOFA2050_Element_CropProduction
/
Rainfed
Irrigated
/;
Set FOFA2050_Element_FertilizerEmissions
/
Total
/;
Set FOFA2050_Element_FoodSecurity
/
"Daily energy supply"
"Daily energy consumption"
"Number of undernourished"
"Prevalence of undernourishment"
/;
Set FOFA2050_Element_Livestock
/
"Poultry Meat"
"Total"
"Raw milk"
"Beef"
"Goat and sheep meat"
"Pork"
/;
Set FOFA2050_Element_MacroIndicators
/
"GDP at market prices"
"Total population"
/;

Set FOFA2050_Countries
/
Afghanistan
Albania
Algeria
Angola
Argentina
Armenia
Australia
Austria
Azerbaijan
Bangladesh
Belarus
Belgium
Benin
"Bolivia (Plurinational State of)"
"Bosnia and Herzegovina"
Botswana
Brazil
Bulgaria
"Burkina Faso"
Cambodia
Cameroon
Canada
"Central African Republic"
Chad
Chile
*add China to later replace the subregions of it
China
"China, Hong Kong SAR"
"China, mainland"
"China, Taiwan Province of"
Colombia
"Costa Rica"
Croatia
Cuba
"Democratic People's Republic of Korea"
Denmark
"Dominican Republic"
Ecuador
Egypt
"El Salvador"
Estonia
Ethiopia
Finland
France
Gabon
Gambia
Georgia
Germany
Ghana
Greece
Guatemala
Guinea
Guyana
Haiti
Honduras
Hungary
India
Indonesia
"Iran (Islamic Republic of)"
Iraq
Ireland
Israel
Italy
Jamaica
Japan
Jordan
Kazakhstan
Kenya
Kyrgyzstan
"Lao People's Democratic Republic"
Latvia
Lebanon
Lesotho
Liberia
Lithuania
Madagascar
Malawi
Malaysia
Mali
Mauritania
Mauritius
Mexico
Mongolia
Morocco
Mozambique
Myanmar
Namibia
Nepal
Netherlands
"New Zealand"
Nicaragua
Niger
Nigeria
Norway
Pakistan
Panama
Paraguay
Peru
Philippines
Poland
Portugal
"Republic of Korea"
"Republic of Moldova"
Romania
"Russian Federation"
Rwanda
"Saudi Arabia"
Senegal
Serbia
"Sierra Leone"
Slovakia
"South Africa"
Spain
"Sri Lanka"
Suriname
Swaziland
Sweden
Tajikistan
Thailand
Togo
"Trinidad and Tobago"
Tunisia
Turkey
Turkmenistan
Uganda
Ukraine
"United Kingdom"
"United Republic of Tanzania"
"United States of America"
Uruguay
Uzbekistan
"Venezuela (Bolivarian Republic of)"
"Viet Nam"
Yemen
Zambia
Zimbabwe
"Rest of EAP"
"Rest of HIC"
"Rest of LAC"
"Rest of MNA"
"Rest of SAS"
"Rest of SSA"
"CÃ´te d'Ivoire"
"Republic of the Congo"
"Rest of EU"
"Rest of ECA"
"Czech Republic"
/;

*the following set is in the original data - but we do not need it here, as the countries are uniquely identifying the data, no need for the region here
$ontext;
Set FOFA2050_Regions
/
"China"
"EAP excluding China"
"High-income"
"Latin America/Caribbean"
"Near East/North Africa"
"South Asia"
"Sub-Saharan Africa"
"Europe/Central Asia"
/;
$offtext;

Set FOFA2050_Scenario
/
"Toward Sustainability"
"Business As Usual"
"Stratified Societies"
FOFA_BAU_2012,FOFA_BAU_2030,FOFA_BAU_2035,FOFA_BAU_2040,FOFA_BAU_2050
FOFA_TSS_2012,FOFA_TSS_2030,FOFA_TSS_2035,FOFA_TSS_2040,FOFA_TSS_2050
FOFA_SSS_2012,FOFA_SSS_2030,FOFA_SSS_2035,FOFA_SSS_2040,FOFA_SSS_2050
/;

Set FOFA2050_Units_CropProduction
/
"ha"
"1000 ha"
"-"
"tonnes/ha"
/;
Set FOFA2050_Units_FertilizerEmissions
/
"Tons of nutrients"
"t CO2 eq"
/;
Set FOFA2050_Units_FoodSecurity
/
*displayed as "<empty>" in the gdx-file, but should assumingly be "g/person/day"
""
"kcal/person/day"
"g/person/day"
"million people"
"fraction"
/;
Set FOFA2050_Units_Livestock
/
"kg/animal/year"
"1000 heads"
/;
Set FOFA2050_Units_MacroIndicators
/
"million people"
"1000 US$, 2012 prices"
/;

Parameter FOFA2050_CropProduction(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_CropProduction,Years);
Parameter FOFA2050_FertilizerAndEmissions(FOFA2050_Indicator_FertilizerEmissions,FOFA2050_Item_FertilizerEmissions,FOFA2050_Element_FertilizerEmissions,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_FertilizerEmissions,Years);
Parameter FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_FoodSecurity,Years);
Parameter FOFA2050_Livestock(FOFA2050_Indicator_Livestock,FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_Livestock,Years);
Parameter FOFA2050_MacroIndicators(FOFA2050_Indicator_MacroIndicators,FOFA2050_Item_MacroIndicators,FOFA2050_Element_MacroIndicators,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_MacroIndicators,Years);

$gdxin FOFA2050CountryData_Crop-production_20_7_2019.gdx
$load FOFA2050_CropProduction
$gdxin

$gdxin FOFA2050CountryData_Fertilizer-and-emissions_20_7_2019.gdx
$load FOFA2050_FertilizerAndEmissions
$gdxin

$gdxin FOFA2050CountryData_Food-security_20_7_2019.gdx
$load FOFA2050_FoodSecurity
$gdxin
*as one unit is "" here, which should assumingly be "g/person/day", we replace this:
FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,FOFA2050_Countries,FOFA2050_Scenario,"g/person/day",Years)
         = FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,FOFA2050_Countries,FOFA2050_Scenario,"",Years);
*and delete the entries with missing unit:
FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,FOFA2050_Countries,FOFA2050_Scenario,"",Years) = 0;

$gdxin FOFA2050CountryData_Livestock_20_7_2019.gdx
$load FOFA2050_Livestock
$gdxin

$gdxin FOFA2050CountryData_Macro-indicators_20_7_2019.gdx
$load FOFA2050_MacroIndicators
$gdxin
;

*assign values to China, adding all the subregions and then dropping them, or for yields, etc. just taking mainland values:
Set FOFA2050China(FOFA2050_Countries)
/"China, Hong Kong SAR"
"China, mainland"
"China, Taiwan Province of"
/;
FOFA2050_CropProduction(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,"China",FOFA2050_Scenario,FOFA2050_Units_CropProduction,Years)
         = FOFA2050_CropProduction(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,"China, mainland",FOFA2050_Scenario,FOFA2050_Units_CropProduction,Years);
FOFA2050_CropProduction(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,"China",FOFA2050_Scenario,"ha",Years)
         = sum(FOFA2050China,FOFA2050_CropProduction(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,FOFA2050China,FOFA2050_Scenario,"ha",Years));
FOFA2050_CropProduction(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,"China",FOFA2050_Scenario,"1000 ha",Years)
         = sum(FOFA2050China,FOFA2050_CropProduction(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,FOFA2050China,FOFA2050_Scenario,"1000 ha",Years));

FOFA2050_FertilizerAndEmissions(FOFA2050_Indicator_FertilizerEmissions,FOFA2050_Item_FertilizerEmissions,FOFA2050_Element_FertilizerEmissions,"China",FOFA2050_Scenario,FOFA2050_Units_FertilizerEmissions,Years)
         = sum(FOFA2050China,FOFA2050_FertilizerAndEmissions(FOFA2050_Indicator_FertilizerEmissions,FOFA2050_Item_FertilizerEmissions,FOFA2050_Element_FertilizerEmissions,FOFA2050China,FOFA2050_Scenario,FOFA2050_Units_FertilizerEmissions,Years));

FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,"China",FOFA2050_Scenario,FOFA2050_Units_FoodSecurity,Years)
         = FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,"China, mainland",FOFA2050_Scenario,FOFA2050_Units_FoodSecurity,Years);
FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,"China",FOFA2050_Scenario,"million people",Years)
         = sum(FOFA2050China,FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,FOFA2050China,FOFA2050_Scenario,"million people",Years));
*FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,"China",FOFA2050_Scenario,"fraction",Years)
*         = sum(FOFA2050China,FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,FOFA2050China,FOFA2050_Scenario,"fraction",Years));

FOFA2050_Livestock(FOFA2050_Indicator_Livestock,FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,"China",FOFA2050_Scenario,FOFA2050_Units_Livestock,Years)
         = FOFA2050_Livestock(FOFA2050_Indicator_Livestock,FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,"China, mainland",FOFA2050_Scenario,FOFA2050_Units_Livestock,Years);
FOFA2050_Livestock(FOFA2050_Indicator_Livestock,FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,"China",FOFA2050_Scenario,"1000 heads",Years)
         = sum(FOFA2050China,FOFA2050_Livestock(FOFA2050_Indicator_Livestock,FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,FOFA2050China,FOFA2050_Scenario,"1000 heads",Years));

FOFA2050_MacroIndicators(FOFA2050_Indicator_MacroIndicators,FOFA2050_Item_MacroIndicators,FOFA2050_Element_MacroIndicators,"China",FOFA2050_Scenario,FOFA2050_Units_MacroIndicators,Years)
         = sum(FOFA2050China,FOFA2050_MacroIndicators(FOFA2050_Indicator_MacroIndicators,FOFA2050_Item_MacroIndicators,FOFA2050_Element_MacroIndicators,FOFA2050China,FOFA2050_Scenario,FOFA2050_Units_MacroIndicators,Years));

*Then drop the subregions:
FOFA2050_CropProduction(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,FOFA2050China,FOFA2050_Scenario,FOFA2050_Units_CropProduction,Years) = 0;
FOFA2050_FertilizerAndEmissions(FOFA2050_Indicator_FertilizerEmissions,FOFA2050_Item_FertilizerEmissions,FOFA2050_Element_FertilizerEmissions,FOFA2050China,FOFA2050_Scenario,FOFA2050_Units_FertilizerEmissions,Years) = 0;
FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,FOFA2050China,FOFA2050_Scenario,FOFA2050_Units_FoodSecurity,Years) = 0;
FOFA2050_Livestock(FOFA2050_Indicator_Livestock,FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,FOFA2050China,FOFA2050_Scenario,FOFA2050_Units_Livestock,Years) = 0;
FOFA2050_MacroIndicators(FOFA2050_Indicator_MacroIndicators,FOFA2050_Item_MacroIndicators,FOFA2050_Element_MacroIndicators,FOFA2050China,FOFA2050_Scenario,FOFA2050_Units_MacroIndicators,Years) = 0;



$ontext;
after this, we have
FOFA2050_CropProduction(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_CropProduction,Years);
FOFA2050_FertilizerAndEmissions(FOFA2050_Indicator_FertilizerEmissions,FOFA2050_Item_FertilizerEmissions,FOFA2050_Element_FertilizerEmissions,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_FertilizerEmissions,Years);
FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_FoodSecurity,Years);
FOFA2050_Livestock(FOFA2050_Indicator_Livestock,FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_Livestock,Years);
FOFA2050_MacroIndicators(FOFA2050_Indicator_MacroIndicators,FOFA2050_Item_MacroIndicators,FOFA2050_Element_MacroIndicators,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_MacroIndicators,Years);
$offtext;

*to more efficiently assign the FOFA scenarios to the names we use in SOLm, define FOFA-scenarios with identical names and assign the values accordingly; for this, we also need new parameters:
Parameter FOFA2050_CropProduction_NewScenarioNames(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,FOFA2050_Countries,Scenarios,FOFA2050_Units_CropProduction);
Parameter FOFA2050_FertilizerAndEmissions_NewScenarioNames(FOFA2050_Indicator_FertilizerEmissions,FOFA2050_Item_FertilizerEmissions,FOFA2050_Element_FertilizerEmissions,FOFA2050_Countries,Scenarios,FOFA2050_Units_FertilizerEmissions);
Parameter FOFA2050_FoodSecurity_NewScenarioNames(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,FOFA2050_Countries,Scenarios,FOFA2050_Units_FoodSecurity);
Parameter FOFA2050_Livestock_NewScenarioNames(FOFA2050_Indicator_Livestock,FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,FOFA2050_Countries,Scenarios,FOFA2050_Units_Livestock);
Parameter FOFA2050_MacroIndicators_NewScenarioNames(FOFA2050_Indicator_MacroIndicators,FOFA2050_Item_MacroIndicators,FOFA2050_Element_MacroIndicators,FOFA2050_Countries,Scenarios,FOFA2050_Units_MacroIndicators);

Set FOFA2050_Years(Years)
/2012,2030,2035,2040,2050/
;


Set MatchFOFA2050Scenarios_SOLmYears(FOFA2050_Scenario,FOFA2050_Years,FOFA2050_Scenarios)
/
"Business As Usual"    .2012.FOFA_BAU_2012
"Toward Sustainability".2012.FOFA_TSS_2012
"Stratified Societies" .2012.FOFA_SSS_2012
"Business As Usual"    .2030.FOFA_BAU_2030
"Toward Sustainability".2030.FOFA_TSS_2030
"Stratified Societies" .2030.FOFA_SSS_2030
"Business As Usual"    .2035.FOFA_BAU_2035
"Toward Sustainability".2035.FOFA_TSS_2035
"Stratified Societies" .2035.FOFA_SSS_2035
"Business As Usual"    .2040.FOFA_BAU_2040
"Toward Sustainability".2040.FOFA_TSS_2040
"Stratified Societies" .2040.FOFA_SSS_2040
"Business As Usual"    .2050.FOFA_BAU_2050
"Toward Sustainability".2050.FOFA_TSS_2050
"Stratified Societies" .2050.FOFA_SSS_2050
/;

FOFA2050_CropProduction_NewScenarioNames(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,FOFA2050_Countries,FOFA2050_Scenarios,FOFA2050_Units_CropProduction)
         =sum((FOFA2050_Scenario,FOFA2050_Years)$MatchFOFA2050Scenarios_SOLmYears(FOFA2050_Scenario,FOFA2050_Years,FOFA2050_Scenarios),
                 FOFA2050_CropProduction(FOFA2050_Indicator_CropProduction,FOFA2050_Item_CropProduction,FOFA2050_Element_CropProduction,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_CropProduction,FOFA2050_Years));

FOFA2050_FertilizerAndEmissions_NewScenarioNames(FOFA2050_Indicator_FertilizerEmissions,FOFA2050_Item_FertilizerEmissions,FOFA2050_Element_FertilizerEmissions,FOFA2050_Countries,FOFA2050_Scenarios,FOFA2050_Units_FertilizerEmissions)
         =sum((FOFA2050_Scenario,FOFA2050_Years)$MatchFOFA2050Scenarios_SOLmYears(FOFA2050_Scenario,FOFA2050_Years,FOFA2050_Scenarios),
                 FOFA2050_FertilizerAndEmissions(FOFA2050_Indicator_FertilizerEmissions,FOFA2050_Item_FertilizerEmissions,FOFA2050_Element_FertilizerEmissions,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_FertilizerEmissions,FOFA2050_Years));

FOFA2050_FoodSecurity_NewScenarioNames(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,FOFA2050_Countries,FOFA2050_Scenarios,FOFA2050_Units_FoodSecurity)
         =sum((FOFA2050_Scenario,FOFA2050_Years)$MatchFOFA2050Scenarios_SOLmYears(FOFA2050_Scenario,FOFA2050_Years,FOFA2050_Scenarios),
                 FOFA2050_FoodSecurity(FOFA2050_Indicator_FoodSecurity,FOFA2050_Item_FoodSecurity,FOFA2050_Element_FoodSecurity,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_FoodSecurity,FOFA2050_Years));

FOFA2050_Livestock_NewScenarioNames(FOFA2050_Indicator_Livestock,FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,FOFA2050_Countries,FOFA2050_Scenarios,FOFA2050_Units_Livestock)
         =sum((FOFA2050_Scenario,FOFA2050_Years)$MatchFOFA2050Scenarios_SOLmYears(FOFA2050_Scenario,FOFA2050_Years,FOFA2050_Scenarios),
                 FOFA2050_Livestock(FOFA2050_Indicator_Livestock,FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_Livestock,FOFA2050_Years));

FOFA2050_MacroIndicators_NewScenarioNames(FOFA2050_Indicator_MacroIndicators,FOFA2050_Item_MacroIndicators,FOFA2050_Element_MacroIndicators,FOFA2050_Countries,FOFA2050_Scenarios,FOFA2050_Units_MacroIndicators)
         =sum((FOFA2050_Scenario,FOFA2050_Years)$MatchFOFA2050Scenarios_SOLmYears(FOFA2050_Scenario,FOFA2050_Years,FOFA2050_Scenarios),
                 FOFA2050_MacroIndicators(FOFA2050_Indicator_MacroIndicators,FOFA2050_Item_MacroIndicators,FOFA2050_Element_MacroIndicators,FOFA2050_Countries,FOFA2050_Scenario,FOFA2050_Units_MacroIndicators,FOFA2050_Years));

PUTCLOSE con "Test1b available";

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

Set MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)
/
"Growing of bananas"                 .Bananas
"Growing of barley"                  .Barley
"Growing of cassava"                 .Cassava
"Growing of coconuts"                .Coconuts
"Growing of citrus fruits"           ."Citrus Fruits"
"Growing of coffee, green"           ."Coffee, green"
"Growing of raw cotton"              ."Seed cotton"
"Growing of groundnuts"              ."Groundnuts, with shell"
"Growing of grain maize"             ."Maize, green"
"Growing of millet"                  .Millet
"Growing of oil palm fruit"          ."Oil, palm fruit"
"Growing of paddy rice"              ."Rice, paddy"
"Growing of potatoes"                .Potatoes
"Growing of dried pulses"            ."Pulses,Total"
"Growing of rape and mustardseed"    ."Rape and Mustard seed"
"Growing of natural rubber"          ."Rubber, natural"
"Growing of sesame seed"             ."Sesame seed"
"Growing of sorghum"                 .Sorghum
"Growing of soybeans"                .Soybeans
"Growing of sugar beet"              ."sugar beet"
"Growing of sugar cane"              ."sugar cane"
"Growing of sunflower seed"          ."sunflower seed"
"Growing of sweet potato and yams"   ."FOFA2050 sweet potato and yams"
"Growing of tea"                     .Tea
"Growing of tobacco"                 ."Tobacco, unmanufactured"
"Growing of wheat"                   .Wheat
"Growing of other cereals"           ."FOFA2050 Other Cereals"
"Growing of other crops"             ."FOFA2050 other crops"
"Growing of other fibre crops"       ."FOFA2050 other fibre crops"
"Growing of other fruits"            ."FOFA2050 other fruits"
"Growing of other oilseeds"          ."FOFA2050 other oilseeds"
"Growing of other roots and tubers"  ."FOFA2050 other roots and tubers"
"Growing of other vegetables"        ."FOFA2050 other vegetables"
"Growing of cocoa beans"             ."Cocoa, beans"
"Growing of plantains"               ."Plantains and others"
"Growing of olives"                  .Olives
/;

Set MatchFOFA205_SOLm_Activities_Animals(FOFA2050_Item_Livestock,Activities)
/
"Raising of buffaloes" .Buffaloes
"Raising of cattle"    .Cattle
"Raising of goats"     .Goats
"Raising of pigs"      .Pigs
"Raising of poultry"   .Chickens
"Raising of sheep"     .Sheep
"Livestock units"      ."All Animals"
/;

Set MatchFOFA2050_SOLm_Outputs_Animals(FOFA2050_Element_Livestock,AnimalTypeInHerd,OutputsAnimals)
/
"Poultry Meat"       ."Meat Producing"."Meat (t)"
*"Total"             .
"Raw milk"           ."Milk Producing"."Milk (t)"
"Beef"               ."Meat Producing"."Meat (t)"
"Goat and sheep meat"."Meat Producing"."Meat (t)"
"Pork"               ."Meat Producing"."Meat (t)"
/;

Set MatchFOFA205_SOLm_Commodities(FOFA2050_Item_FoodSecurity,Commodities)
/
Bananas                .Bananas
Barley                 .Barley
Cassava                .Cassava
Coconuts               .Coconuts
"Coffee, green"        ."Coffee, green"
Millet                 .Millet
Olives                 .Olives
"Palm kernels"         ."Palm kernels"
Potatoes               .Potatoes
"Sesame seed"          ."Sesame seed"
Sorghum                .Sorghum
Soybeans               .Soybeans
"Sugar beet"           ."Sugar beet"
"Sugar cane"           ."Sugar cane"
"Sunflower seed"       ."Sunflower seed"
Tea                    .Tea
Wheat                  .Wheat
"Sheep and Goat Meat"  ."FOFA2050 Sheep and Goat Meat"
Plantains              ."Plantains and others"
Pigmeat                .Pigmeat
"Poultry Meat"         ."Poultry Meat"
"Cottonseed Oil"       ."Cottonseed Oil"
"Groundnut Oil"        ."Groundnut Oil"
"Olive Oil"            ."Olive Oil"
"Citrus Fruits"        ."Citrus, all"
Total                  ."FOFA2050 Total commodities"
ALL                    ."All commodities"
"Beef and veal"        ."Meat, cattle, boneless (beef & veal)"
"Coconuts oil"         ."Coconut Oil"
"Cocoa beans"          ."Cocoa, beans"
Fish                   ."FOFA2050 All Fish"
Groundnuts             ."Groundnuts, with shell"
"Grain maize"          .Maize
"Milled rice"          ."Rice (Milled Equivalent)"
"Palm kernel oil"      ."Palmkernel Oil"
"Palm fruit oil"       ."Palm Oil"
"Dried pulses"         ."FOFA2050 Dried Pulses"
"Rapeseed oil"         ."Oil, rapeseed"
"Raw milk"             ."Milk - Excluding Butter"
"Sesame seed oil"      ."Sesameseed Oil"
"Soya oil"             ."Soyabean Oil"
"Processed sugar"      ."Sugar & Sweeteners"
"Sunflower seed oil"   ."Sunflowerseed Oil"
"Sweet potato and yams"    ."FOFA2050 Sweet potato and yams"
"Other cereals"            ."FOFA2050 Other cereals"
"Other crops"              ."FOFA2050 Other crops"
"Other fruits"             ."FOFA2050 Other fruits"
"Oilcrops, nes, oil"       ."FOFA2050 Oilcrops, nes, oil"
"Other roots and tubers"   ."FOFA2050 Other roots and tubers"
"Other vegetables"         ."FOFA2050 Other vegetables"
"Other oilseeds"           ."FOFA2050 Other oilseeds"
"Rapeseed and mustard seed"."Rape and mustardseed"
/;


Set MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
/
Afghanistan                         .Afghanistan
Albania                             .Albania
Algeria                             .Algeria
Angola                              .Angola
Argentina                           .Argentina
Armenia                             .Armenia
Australia                           .Australia
Austria                             .Austria
Azerbaijan                          .Azerbaijan
Bangladesh                          .Bangladesh
Belarus                             .Belarus
Belgium                             .Belgium
Benin                               .Benin
"Bolivia (Plurinational State of)"  ."Bolivia (Plurinational State of)"
"Bosnia and Herzegovina"            ."Bosnia and Herzegovina"
Botswana                            .Botswana
Brazil                              .Brazil
Bulgaria                            .Bulgaria
"Burkina Faso"                      ."Burkina Faso"
Cambodia                            .Cambodia
Cameroon                            .Cameroon
Canada                              .Canada
"Central African Republic"          ."Central African Republic"
Chad                                .Chad
"Czech Republic"                    ."Czechia"
Chile                               .Chile
China                               .China
*"China, Hong Kong SAR"              ."China, Hong Kong SAR"
*"China, mainland"                   ."China, mainland"
*"China, Taiwan Province of"         ."China, Taiwan Province of"
Colombia                            .Colombia
"Costa Rica"                        ."Costa Rica"
"CÃ´te d'Ivoire"                    ."Côte d'Ivoire"
Croatia                             .Croatia
Cuba                                .Cuba
"Democratic People's Republic of Korea"."Democratic People's Republic of Korea"
Denmark                             .Denmark
"Dominican Republic"                ."Dominican Republic"
Ecuador                             .Ecuador
Egypt                               .Egypt
"El Salvador"                       ."El Salvador"
Estonia                             .Estonia
Ethiopia                            .Ethiopia
Finland                             .Finland
France                              .France
Gabon                               .Gabon
Gambia                              .Gambia
Georgia                             .Georgia
Germany                             .Germany
Ghana                               .Ghana
Greece                              .Greece
Guatemala                           .Guatemala
Guinea                              .Guinea
Guyana                              .Guyana
Haiti                               .Haiti
Honduras                            .Honduras
Hungary                             .Hungary
India                               .India
Indonesia                           .Indonesia
"Iran (Islamic Republic of)"        ."Iran (Islamic Republic of)"
Iraq                                .Iraq
Ireland                             .Ireland
Israel                              .Israel
Italy                               .Italy
Jamaica                             .Jamaica
Japan                               .Japan
Jordan                              .Jordan
Kazakhstan                          .Kazakhstan
Kenya                               .Kenya
Kyrgyzstan                          .Kyrgyzstan
"Lao People's Democratic Republic"  ."Lao People's Democratic Republic"
Latvia                              .Latvia
Lebanon                             .Lebanon
Lesotho                             .Lesotho
Liberia                             .Liberia
Lithuania                           .Lithuania
Madagascar                          .Madagascar
Malawi                              .Malawi
Malaysia                            .Malaysia
Mali                                .Mali
Mauritania                          .Mauritania
Mauritius                           .Mauritius
Mexico                              .Mexico
Mongolia                            .Mongolia
Morocco                             .Morocco
Mozambique                          .Mozambique
Myanmar                             .Myanmar
Namibia                             .Namibia
Nepal                               .Nepal
Netherlands                         .Netherlands
"New Zealand"                       ."New Zealand"
Nicaragua                           .Nicaragua
Niger                               .Niger
Nigeria                             .Nigeria
Norway                              .Norway
Pakistan                            .Pakistan
Panama                              .Panama
Paraguay                            .Paraguay
Peru                                .Peru
Philippines                         .Philippines
Poland                              .Poland
Portugal                            .Portugal
"Republic of Korea"                 ."Republic of Korea"
"Republic of Moldova"               ."Republic of Moldova"
"Republic of the Congo"             ."Democratic Republic of the Congo"
Romania                             .Romania
"Russian Federation"                ."Russian Federation"
Rwanda                              .Rwanda
"Saudi Arabia"                      ."Saudi Arabia"
Senegal                             .Senegal
Serbia                              .Serbia
"Sierra Leone"                      ."Sierra Leone"
Slovakia                            .Slovakia
"South Africa"                      ."South Africa"
Spain                               .Spain
"Sri Lanka"                         ."Sri Lanka"
Suriname                            .Suriname
Swaziland                           .Swaziland
Sweden                              .Sweden
Tajikistan                          .Tajikistan
Thailand                            .Thailand
Togo                                .Togo
"Trinidad and Tobago"               ."Trinidad and Tobago"
Tunisia                             .Tunisia
Turkey                              .Turkey
Turkmenistan                        .Turkmenistan
Uganda                              .Uganda
Ukraine                             .Ukraine
"United Kingdom"                    ."United Kingdom"
"United Republic of Tanzania"       ."United Republic of Tanzania"
"United States of America"          ."United States of America"
Uruguay                             .Uruguay
Uzbekistan                          .Uzbekistan
"Venezuela (Bolivarian Republic of)"."Venezuela (Bolivarian Republic of)"
"Viet Nam"                          ."Viet Nam"
Yemen                               .Yemen
Zambia                              .Zambia
Zimbabwe                            .Zimbabwe

"Rest of EAP"                       ."FOFA2050 Rest of EAP"
"Rest of HIC"                       ."FOFA2050 Rest of HIC"
"Rest of LAC"                       ."FOFA2050 Rest of LAC"
"Rest of MNA"                       ."FOFA2050 Rest of MNA"
"Rest of SAS"                       ."FOFA2050 Rest of SAS"
"Rest of SSA"                       ."FOFA2050 Rest of SSA"
"Rest of EU"                        ."FOFA2050 Rest of EU"
"Rest of ECA"                       ."FOFA2050 Rest of ECA"
/;

*3.2) Link to the core model parameters

$ontext;
Matching sets to be used:
Set MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)
Set MatchFOFA205_SOLm_Activities_Animals(FOFA2050_Item_Livestock,Activities)
Set MatchFOFA2050_SOLm_Outputs_Animals(FOFA2050_Element_Livestock,OutputsAnimals)
Set MatchFOFA205_SOLm_Commodities(FOFA2050_Item_FoodSecurity,Commodities)
Set MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
$offtext;



*area harvested in hectares (ha):
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Rainfed","AllProdCond",FOFA2050_Scenarios)
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction_NewScenarioNames("Harvested area",FOFA2050_Item_CropProduction,"Rainfed",FOFA2050_Countries,FOFA2050_Scenarios,"1000 ha"))*1000;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Irrigated","AllProdCond",FOFA2050_Scenarios)
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction_NewScenarioNames("Harvested area",FOFA2050_Item_CropProduction,"Irrigated",FOFA2050_Countries,FOFA2050_Scenarios,"1000 ha"))*1000;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst","AllProdCond",FOFA2050_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Rainfed","AllProdCond",FOFA2050_Scenarios)
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Irrigated","AllProdCond",FOFA2050_Scenarios);

*area occupied (i.e. arable land), in ha:
VActCropsGrass_OtherChar_MR.l(Regions,Activities,"Area occupied physically (ha)","Rainfed","AllProdCond",FOFA2050_Scenarios)
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction_NewScenarioNames("Arable land",FOFA2050_Item_CropProduction,"Rainfed",FOFA2050_Countries,FOFA2050_Scenarios,"ha"));
VActCropsGrass_OtherChar_MR.l(Regions,Activities,"Area occupied physically (ha)","Irrigated","AllProdCond",FOFA2050_Scenarios)
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction_NewScenarioNames("Arable land",FOFA2050_Item_CropProduction,"Irrigated",FOFA2050_Countries,FOFA2050_Scenarios,"ha"));
VActCropsGrass_OtherChar_MR.l(Regions,Activities,"Area occupied physically (ha)","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(Regions,Activities,"Area occupied physically (ha)","Rainfed","AllProdCond",FOFA2050_Scenarios)
                 + VActCropsGrass_OtherChar_MR.l(Regions,Activities,"Area occupied physically (ha)","Irrigated","AllProdCond",FOFA2050_Scenarios);


*yields in tons per hectare (t/ha):
ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)","Rainfed","AllProdCond",FOFA2050_Scenarios)
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction_NewScenarioNames("Crop yield",FOFA2050_Item_CropProduction,"Rainfed",FOFA2050_Countries,FOFA2050_Scenarios,"tonnes/ha"));
ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)","Irrigated","AllProdCond",FOFA2050_Scenarios)
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction_NewScenarioNames("Crop yield",FOFA2050_Item_CropProduction,"Irrigated",FOFA2050_Countries,FOFA2050_Scenarios,"tonnes/ha"));

*cropping intensity as a ratio of harvested by arable land (ratio)
$ontext;
ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","Rainfed","AllProdCond",FOFA2050_Scenarios)
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction_NewScenarioNames("Cropping intensity",FOFA2050_Item_CropProduction,"Rainfed",FOFA2050_Countries,FOFA2050_Scenarios,"-"));
ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","Irrigated","AllProdCond",FOFA2050_Scenarios)
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction_NewScenarioNames("Cropping intensity",FOFA2050_Item_CropProduction,"Irrigated",FOFA2050_Countries,FOFA2050_Scenarios,"-"));
$offtext;
*the problem is: the original data reports the SAME CI for ALL crops for all countries, which does not make sense.
*Hence we do not use the original data but DERIVE CI from area harvested/arable land
ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $VActCropsGrass_OtherChar_MR.l(Regions,Activities,"Area occupied physically (ha)",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 /VActCropsGrass_OtherChar_MR.l(Regions,Activities,"Area occupied physically (ha)",ProductionSystems,"AllProdCond",FOFA2050_Scenarios);


*number of animals in single heads (heads):
VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
         = sum((FOFA2050_Item_Livestock,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Animals(FOFA2050_Item_Livestock,Activities)),
                 FOFA2050_Livestock_NewScenarioNames("Herd sizes",FOFA2050_Item_Livestock,"Total",FOFA2050_Countries,FOFA2050_Scenarios,"1000 heads"))*1000;

*yields in tons per head (t/head):
ActAnimalsHead_Outputs_MR(Regions,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond",FOFA2050_Scenarios)
         = sum((FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Animals(FOFA2050_Item_Livestock,Livestock)
                         AND MatchFOFA2050_SOLm_Outputs_Animals(FOFA2050_Element_Livestock,AnimalTypeInHerd,OutputsAnimals)),
                 FOFA2050_Livestock_NewScenarioNames("Productivity",FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,FOFA2050_Countries,FOFA2050_Scenarios,"kg/animal/year"))/1000;


$ontext;
ALREADY DONE IN THE MORE GENERAL CODE ABOVE
*for FOFA_Baseline_2012
*area harvested in hectares (ha):
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Rainfed","AllProdCond","FOFA_Baseline_2012")
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction("Harvested area",FOFA2050_Item_CropProduction,"Rainfed",FOFA2050_Countries,"Business As Usual","1000 ha","2012"))*1000;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Irrigated","AllProdCond","FOFA_Baseline_2012")
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction("Harvested area",FOFA2050_Item_CropProduction,"Irrigated",FOFA2050_Countries,"Business As Usual","1000 ha","2012"))*1000;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst","AllProdCond","FOFA_Baseline_2012")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Rainfed","AllProdCond","FOFA_Baseline_2012")
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Irrigated","AllProdCond","FOFA_Baseline_2012");

*yields in tons per hectare (t/ha):
ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)","Rainfed","AllProdCond","FOFA_Baseline_2012")
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction("Crop yield",FOFA2050_Item_CropProduction,"Rainfed",FOFA2050_Countries,"Business As Usual","tonnes/ha","2012"));
ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)","Irrigated","AllProdCond","FOFA_Baseline_2012")
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction("Crop yield",FOFA2050_Item_CropProduction,"Irrigated",FOFA2050_Countries,"Business As Usual","tonnes/ha","2012"));

*cropping intensity as a ratio of harvested by arable land (ratio)
ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","Rainfed","AllProdCond","FOFA_Baseline_2012")
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction("Cropping intensity",FOFA2050_Item_CropProduction,"Rainfed",FOFA2050_Countries,"Business As Usual","-","2012"));
ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","Irrigated","AllProdCond","FOFA_Baseline_2012")
         = sum((FOFA2050_Item_CropProduction,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Crops(FOFA2050_Item_CropProduction,Activities)),
                 FOFA2050_CropProduction("Cropping intensity",FOFA2050_Item_CropProduction,"Irrigated",FOFA2050_Countries,"Business As Usual","-","2012"));

*number of animals in single heads (heads):
VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,"Living","AllProdSyst","AllProdCond","FOFA_Baseline_2012")
         = sum((FOFA2050_Item_Livestock,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Animals(FOFA2050_Item_Livestock,Activities)),
                 FOFA2050_Livestock("Herd sizes",FOFA2050_Item_Livestock,"Total",FOFA2050_Countries,"Business As Usual","1000 heads","2012"))*1000;

*yields in tons per head (t/head):
ActAnimalsHead_Outputs_MR(Regions,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond","FOFA_Baseline_2012")
         = sum((FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,FOFA2050_Countries)$(MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions)
                         AND MatchFOFA205_SOLm_Activities_Animals(FOFA2050_Item_Livestock,Livestock)
                         AND MatchFOFA2050_SOLm_Outputs_Animals(FOFA2050_Element_Livestock,AnimalTypeInHerd,OutputsAnimals)),
                 FOFA2050_Livestock("Productivity",FOFA2050_Item_Livestock,FOFA2050_Element_Livestock,FOFA2050_Countries,"Business As Usual","kg/animal/year","2012"))/1000;
$offtext;


*population numbers:
*factor 1000000 to convert from million people to people
VPopulationNumbers_MR.l(Regions,"PopulationAll",FOFA2050_Scenarios)
         = sum(FOFA2050_Countries$MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions),
                 FOFA2050_MacroIndicators_NewScenarioNames("Population","Total","Total population",FOFA2050_Countries,FOFA2050_Scenarios,"million people")*1000000);
*NOT NEEDED, already done in the general code above
*VPopulationNumbers_MR.l(Regions,"PopulationAll","FOFA_Baseline_2012")
*         = sum(FOFA2050_Countries$MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,Regions),
*                 FOFA2050_MacroIndicators_NewScenarioNames("Population","Total","Total population",FOFA2050_Countries,"Business As Usual","million people")*1000000);
*For Switzerland, there are no population numbers in the FOFA report, thus use offocial Swiss projections from
*Szenarien zur Bevölkerungsentwicklung der Schweiz und der Kantone 2020-2050, BfS 2020, https://www.bfs.admin.ch/bfs/de/home/statistiken/bevoelkerung/zukuenftige-entwicklung.assetdetail.14963221.html
*for Austria, the three FOFA scenarios have the same population numbers, so we use the Swiss medium projections for all scenarios as well: the "Referenzszenario"
*numbers are goiven for 2030, 2040 and 2050, 2035 is derived as the mean between 2030 and 2040:

VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_BAU_2030") =  9430000;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_BAU_2035") = (9430000 + 10020000)/2;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_BAU_2040") = 10020000;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_BAU_2050") = 10440000;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_TSS_2030") =  9430000;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_TSS_2035") = (9430000 + 10020000)/2;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_TSS_2040") = 10020000;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_TSS_2050") = 10440000;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_SSS_2030") =  9430000;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_SSS_2035") = (9430000 + 10020000)/2;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_SSS_2040") = 10020000;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_SSS_2050") = 10440000;

*for 2012, use the FAOSTAT numbers for 2012 (i.e. 8031670):
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_BAU_2012")
         = FAOSTAT_Population("Switzerland","Population - Est. & Proj.","Total Population - Both sexes","2012","1000 persons")*1000;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_TSS_2012")
         = FAOSTAT_Population("Switzerland","Population - Est. & Proj.","Total Population - Both sexes","2012","1000 persons")*1000;
VPopulationNumbers_MR.l("Switzerland","PopulationAll","FOFA_SSS_2012")
         = FAOSTAT_Population("Switzerland","Population - Est. & Proj.","Total Population - Both sexes","2012","1000 persons")*1000;


*GO ON HERE SYSTEMATICALLY:
*for crop groups do single crops per countries and per region groups
*for all single crops per region groups do per countries

*Now derive the shares of single SOLm activities and countries in the remaining FOFA2050 regions and activity groups
*this is done for the baseline 2012, i.e. average 2010-2014!! - thus do NOT RECALCULATE if the model is initialised with another baseline, but then just read in the results
$ontext;
Link FOFA2050 regions to countries:
the following indicates which regions correspond to which sets of countries
sets for the sub-regions to country matching:
                         new set               region
         Set FOFA2050_Rest_of_EAP(Regions)  "FOFA2050 Rest of EAP"
         Set FOFA2050_Rest_of_HIC(Regions)  "FOFA2050 Rest of HIC"
         Set FOFA2050_Rest_of_LAC(Regions)  "FOFA2050 Rest of LAC"
         Set FOFA2050_Rest_of_MNA(Regions)  "FOFA2050 Rest of MNA"
         Set FOFA2050_Rest_of_SAS(Regions)  "FOFA2050 Rest of SAS"
         Set FOFA2050_Rest_of_SSA(Regions)  "FOFA2050 Rest of SSA"
         Set FOFA2050_Rest_of_EU(Regions)   "FOFA2050 Rest of EU"
         Set FOFA2050_Rest_of_ECA(Regions)  "FOFA2050 Rest of ECA"
$offtext;
$ontext;
Link FOFA2050 activity groups to activities
the following indicates which activity groups correspond to which sets of activities
sets for the activity group to activity matching:
                         new set                                  activity group
         Set FOFA2050_SweetPotato_And_Yams(Activities)     "FOFA2050 sweet potato and yams"
         Set FOFA2050_Rapeseed_And_Mustardseed(Activities) "Rape and Mustard seed"
         Set FOFA2050_OtherCrops(Activities)               "FOFA2050 other crops"
         Set FOFA2050_OtherFibreCrops(Activities)          "FOFA2050 other fibre crops"
         Set FOFA2050_OtherFruits(Activities)              "FOFA2050 other fruits"
         Set FOFA2050_OtherOilseeds(Activities)            "FOFA2050 other oilseeds"
         Set FOFA2050_OtherRootsAndTubers(Activities)      "FOFA2050 other roots and tubers"
         Set FOFA2050_OtherVegetables(Activities)          "FOFA2050 other vegetables"
         Set FOFA2050_CitrusFruits(Activities)             "Citrus Fruits"
         Set FOFA2050_DriedPulses(Activities)              "Pulses,Total"
         Set FOFA2050_OtherCereals(Activities)             "FOFA2050 other cereals"
$offtext;

*do the sums of the baseline data to then derive shares fo allocating the region and activity groups to the single regions and activities
VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EAP",Activities,ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_Rest_of_EAP,VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EAP,Activities,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of HIC",Activities,ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_Rest_of_HIC,VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_HIC,Activities,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of LAC",Activities,ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_Rest_of_LAC,VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_LAC,Activities,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of MNA",Activities,ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_Rest_of_MNA,VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_MNA,Activities,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SAS",Activities,ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_Rest_of_SAS,VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SAS,Activities,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SSA",Activities,ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_Rest_of_SSA,VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SSA,Activities,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EU",Activities,ProductionSystems,"AllProdCond","Baseline")  = sum(FOFA2050_Rest_of_EU,VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EU,Activities,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of ECA",Activities,ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_Rest_of_ECA,VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_ECA,Activities,ProductionSystems,"AllProdCond","Baseline"));

VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 sweet potato and yams",ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_SweetPotato_And_Yams,VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_SweetPotato_And_Yams,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Rape and Mustard seed",ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_Rapeseed_And_Mustardseed,VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_Rapeseed_And_Mustardseed,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other crops",ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_OtherCrops,VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherCrops,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other fibre crops",ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_OtherFibreCrops,VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherFibreCrops,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other fruits",ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_OtherFruits,VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherFruits,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other oilseeds",ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_OtherOilseeds,VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherOilseeds,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other roots and tubers",ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_OtherRootsAndTubers,VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherRootsAndTubers,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other vegetables",ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_OtherVegetables,VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherVegetables,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Citrus Fruits",ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_CitrusFruits,VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_CitrusFruits,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Pulses,Total",ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_DriedPulses,VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_DriedPulses,ProductionSystems,"AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other cereals",ProductionSystems,"AllProdCond","Baseline") = sum(FOFA2050_OtherCereals,VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherCereals,ProductionSystems,"AllProdCond","Baseline"));

Parameter Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,Activities,ProductionSystems);
*the following derivations are based on FAOSTAT baseline values, i.e. only for ProductionSystem = "AllProdSyst" - although it is used more general in the code. But hence, later on, reference to "AllProdSyst" instead of ProductionSystem.

Set ActivityGroupsForFOFA2050Shares(Activities)
/
"FOFA2050 sweet potato and yams"
"Rape and Mustard seed"
"FOFA2050 other crops"
"FOFA2050 other fibre crops"
"FOFA2050 other fruits"
"FOFA2050 other oilseeds"
"FOFA2050 other roots and tubers"
"FOFA2050 other vegetables"
"Citrus Fruits"
"Pulses,Total"
"FOFA2050 other cereals"
/;

Set RegionsForFOFA2050Shares(Regions)
/
"FOFA2050 Rest of EAP"
"FOFA2050 Rest of HIC"
"FOFA2050 Rest of LAC"
"FOFA2050 Rest of MNA"
"FOFA2050 Rest of SAS"
"FOFA2050 Rest of SSA"
"FOFA2050 Rest of EU"
"FOFA2050 Rest of ECA"
/;

*for countries in "rest of" regions: single country shares per activity groups
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_EAP,ActivityGroupsForFOFA2050Shares,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EAP",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EAP,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EAP",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_HIC,ActivityGroupsForFOFA2050Shares,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of HIC",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_HIC,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of HIC",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_LAC,ActivityGroupsForFOFA2050Shares,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of LAC",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_LAC,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of LAC",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_MNA,ActivityGroupsForFOFA2050Shares,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of MNA",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_MNA,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of MNA",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_SAS,ActivityGroupsForFOFA2050Shares,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SAS",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SAS,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SAS",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_SSA,ActivityGroupsForFOFA2050Shares,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SSA",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SSA,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SSA",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_EU,ActivityGroupsForFOFA2050Shares,ProductionSystems)                                        $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EU",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EU,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline") /VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EU",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_ECA,ActivityGroupsForFOFA2050Shares,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of ECA",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_ECA,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of ECA",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond","Baseline");

*single activity shares in activity groups per "rest of regions":
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(RegionsForFOFA2050Shares,FOFA2050_SweetPotato_And_Yams,ProductionSystems    )  $VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 sweet potato and yams",ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,FOFA2050_SweetPotato_And_Yams    ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                              /VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 sweet potato and yams",ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(RegionsForFOFA2050Shares,FOFA2050_Rapeseed_And_Mustardseed,ProductionSystems)  $VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"Rape and Mustard seed"          ,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,FOFA2050_Rapeseed_And_Mustardseed,ProductionSystems,"AllProdCond","Baseline")
                                                                                                              /VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"Rape and Mustard seed"          ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(RegionsForFOFA2050Shares,FOFA2050_OtherCrops,ProductionSystems              )  $VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other crops"           ,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,FOFA2050_OtherCrops              ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                              /VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other crops"           ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(RegionsForFOFA2050Shares,FOFA2050_OtherFibreCrops,ProductionSystems         )  $VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other fibre crops"     ,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,FOFA2050_OtherFibreCrops         ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                              /VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other fibre crops"     ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(RegionsForFOFA2050Shares,FOFA2050_OtherFruits,ProductionSystems             )  $VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other fruits"          ,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,FOFA2050_OtherFruits             ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                              /VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other fruits"          ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(RegionsForFOFA2050Shares,FOFA2050_OtherOilseeds,ProductionSystems           )  $VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other oilseeds"        ,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,FOFA2050_OtherOilseeds           ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                              /VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other oilseeds"        ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(RegionsForFOFA2050Shares,FOFA2050_OtherRootsAndTubers,ProductionSystems     )  $VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other roots and tubers",ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,FOFA2050_OtherRootsAndTubers     ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                              /VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other roots and tubers",ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(RegionsForFOFA2050Shares,FOFA2050_OtherVegetables,ProductionSystems         )  $VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other vegetables"      ,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,FOFA2050_OtherVegetables         ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                              /VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other vegetables"      ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(RegionsForFOFA2050Shares,FOFA2050_CitrusFruits,ProductionSystems            )  $VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"Citrus Fruits"                  ,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,FOFA2050_CitrusFruits            ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                              /VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"Citrus Fruits"                  ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(RegionsForFOFA2050Shares,FOFA2050_DriedPulses,ProductionSystems             )  $VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"Pulses,Total"                   ,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,FOFA2050_DriedPulses             ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                              /VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"Pulses,Total"                   ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(RegionsForFOFA2050Shares,FOFA2050_OtherCereals,ProductionSystems            )  $VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other cereals"         ,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,FOFA2050_OtherCereals            ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                          /VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,"FOFA2050 other cereals"         ,ProductionSystems,"AllProdCond","Baseline");

*single activity shares in single countries in "rest of" regions
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,FOFA2050_SweetPotato_And_Yams,ProductionSystems    )                                                    $VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 sweet potato and yams",ProductionSystems,"AllProdCond","Baseline")
                                                                                                                                  = Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,"FOFA2050 sweet potato and yams",ProductionSystems)
           *VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_SweetPotato_And_Yams    ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 sweet potato and yams",ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,FOFA2050_Rapeseed_And_Mustardseed,ProductionSystems)                                                    $VActCropsGrass_QuantityActUnits_MR.l(Regions,"Rape and Mustard seed"         ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                                                  = Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,"Rape and Mustard seed",ProductionSystems         )
           *VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_Rapeseed_And_Mustardseed,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(Regions,"Rape and Mustard seed"         ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,FOFA2050_OtherCrops,ProductionSystems              )                                                    $VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other crops"          ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                                                  = Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,"FOFA2050 other crops",ProductionSystems          )
           *VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherCrops              ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other crops"          ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,FOFA2050_OtherFibreCrops,ProductionSystems         )                                                    $VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other fibre crops"    ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                                                  = Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,"FOFA2050 other fibre crops",ProductionSystems    )
           *VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherFibreCrops         ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other fibre crops"    ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,FOFA2050_OtherFruits,ProductionSystems             )                                                    $VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other fruits"         ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                                                  = Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,"FOFA2050 other fruits",ProductionSystems         )
           *VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherFruits             ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other fruits"         ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,FOFA2050_OtherOilseeds,ProductionSystems           )                                                    $VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other oilseeds"       ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                                                  = Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,"FOFA2050 other oilseeds",ProductionSystems       )
           *VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherOilseeds           ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other oilseeds"       ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,FOFA2050_OtherRootsAndTubers,ProductionSystems     )                                                    $VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other roots and tubers",ProductionSystems,"AllProdCond","Baseline")
                                                                                                                                  = Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,"FOFA2050 other roots and tubers",ProductionSystems)
           *VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherRootsAndTubers     ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other roots and tubers",ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,FOFA2050_OtherVegetables,ProductionSystems         )                                                    $VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other vegetables"     ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                                                  = Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,"FOFA2050 other vegetables",ProductionSystems     )
           *VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherVegetables         ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other vegetables"     ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,FOFA2050_CitrusFruits,ProductionSystems            )                                                    $VActCropsGrass_QuantityActUnits_MR.l(Regions,"Citrus Fruits"                 ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                                                  = Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,"Citrus Fruits",ProductionSystems                 )
           *VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_CitrusFruits            ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(Regions,"Citrus Fruits"                 ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,FOFA2050_DriedPulses,ProductionSystems             )                                                    $VActCropsGrass_QuantityActUnits_MR.l(Regions,"Pulses,Total"                  ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                                                  = Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,"Pulses,Total",ProductionSystems                  )
           *VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_DriedPulses             ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(Regions,"Pulses,Total"                  ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,FOFA2050_OtherCereals,ProductionSystems            )                                                    $VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other cereals"        ,ProductionSystems,"AllProdCond","Baseline")
                                                                                                                                  = Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Regions,"FOFA2050 other cereals",ProductionSystems        )
           *VActCropsGrass_QuantityActUnits_MR.l(Regions,FOFA2050_OtherCereals            ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(Regions,"FOFA2050 other cereals"        ,ProductionSystems,"AllProdCond","Baseline");



*and do it also for the countries which are not part of the "rest of" regions but also show activity group values:
Set FOFA2050_SingleCountries(Regions)
/
Afghanistan
Albania
Algeria
Angola
Argentina
Armenia
Australia
Austria
Azerbaijan
Bangladesh
Belarus
Belgium
Benin
"Bolivia (Plurinational State of)"
"Bosnia and Herzegovina"
Botswana
Brazil
Bulgaria
"Burkina Faso"
Cambodia
Cameroon
Canada
"Central African Republic"
Chad
"Czechia"
Chile
China
*"China, Hong Kong SAR"
*"China, mainland"
*"China, Taiwan Province of"
Colombia
"Costa Rica"
"Côte d'Ivoire"
Croatia
Cuba
"Democratic People's Republic of Korea"
Denmark
"Dominican Republic"
Ecuador
Egypt
"El Salvador"
Estonia
Ethiopia
Finland
France
Gabon
Gambia
Georgia
Germany
Ghana
Greece
Guatemala
Guinea
Guyana
Haiti
Honduras
Hungary
India
Indonesia
"Iran (Islamic Republic of)"
Iraq
Ireland
Israel
Italy
Jamaica
Japan
Jordan
Kazakhstan
Kenya
Kyrgyzstan
"Lao People's Democratic Republic"
Latvia
Lebanon
Lesotho
Liberia
Lithuania
Madagascar
Malawi
Malaysia
Mali
Mauritania
Mauritius
Mexico
Mongolia
Morocco
Mozambique
Myanmar
Namibia
Nepal
Netherlands
"New Zealand"
Nicaragua
Niger
Nigeria
Norway
Pakistan
Panama
Paraguay
Peru
Philippines
Poland
Portugal
"Republic of Korea"
"Republic of Moldova"
"Democratic Republic of the Congo"
Romania
"Russian Federation"
Rwanda
"Saudi Arabia"
Senegal
Serbia
"Sierra Leone"
Slovakia
"South Africa"
Spain
"Sri Lanka"
Suriname
Swaziland
Sweden
Tajikistan
Thailand
Togo
"Trinidad and Tobago"
Tunisia
Turkey
Turkmenistan
Uganda
Ukraine
"United Kingdom"
"United Republic of Tanzania"
"United States of America"
Uruguay
Uzbekistan
"Venezuela (Bolivarian Republic of)"
"Viet Nam"
Yemen
Zambia
Zimbabwe
/;

Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_SweetPotato_And_Yams,ProductionSystems    )                                                    $VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 sweet potato and yams",ProductionSystems,"AllProdCond","Baseline")
           = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_SweetPotato_And_Yams    ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 sweet potato and yams",ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_Rapeseed_And_Mustardseed,ProductionSystems)                                                    $VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"Rape and Mustard seed"         ,ProductionSystems,"AllProdCond","Baseline")
           = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_Rapeseed_And_Mustardseed,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"Rape and Mustard seed"         ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherCrops,ProductionSystems              )                                                    $VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other crops"          ,ProductionSystems,"AllProdCond","Baseline")
           = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherCrops              ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other crops"          ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherFibreCrops,ProductionSystems         )                                                    $VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other fibre crops"    ,ProductionSystems,"AllProdCond","Baseline")
           = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherFibreCrops         ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other fibre crops"    ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherFruits,ProductionSystems             )                                                    $VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other fruits"         ,ProductionSystems,"AllProdCond","Baseline")
           = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherFruits             ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other fruits"         ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherOilseeds,ProductionSystems           )                                                    $VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other oilseeds"       ,ProductionSystems,"AllProdCond","Baseline")
           = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherOilseeds           ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other oilseeds"       ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherRootsAndTubers,ProductionSystems     )                                                    $VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other roots and tubers",ProductionSystems,"AllProdCond","Baseline")
           = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherRootsAndTubers     ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other roots and tubers",ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherVegetables,ProductionSystems         )                                                    $VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other vegetables"     ,ProductionSystems,"AllProdCond","Baseline")
           = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherVegetables         ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other vegetables"     ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_CitrusFruits,ProductionSystems            )                                                    $VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"Citrus Fruits"                 ,ProductionSystems,"AllProdCond","Baseline")
           = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_CitrusFruits            ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"Citrus Fruits"                 ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_DriedPulses,ProductionSystems             )                                                    $VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"Pulses,Total"                  ,ProductionSystems,"AllProdCond","Baseline")
           = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_DriedPulses             ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"Pulses,Total"                  ,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherCereals,ProductionSystems            )                                                    $VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other cereals"        ,ProductionSystems,"AllProdCond","Baseline")
           = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherCereals            ,ProductionSystems,"AllProdCond","Baseline")             /VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other cereals"        ,ProductionSystems,"AllProdCond","Baseline");

*and derive shares for single activities in single countries in Rest of Country groups

Set FOFA2050_SingleActivities(Activities)
/
Bananas
Barley
Cassava
Coconuts
"Coffee, green"
"Seed cotton"
"Groundnuts, with shell"
"Maize, green"
Millet
"Oil, palm fruit"
"Rice, paddy"
Potatoes
"Rubber, natural"
"Sesame seed"
Sorghum
Soybeans
"sugar beet"
"sugar cane"
"sunflower seed"
Tea
"Tobacco, unmanufactured"
Wheat
"Cocoa, beans"
"Plantains and others"
Olives
/;

Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_EAP,FOFA2050_SingleActivities,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EAP",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EAP,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EAP",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_HIC,FOFA2050_SingleActivities,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of HIC",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_HIC,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of HIC",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_LAC,FOFA2050_SingleActivities,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of LAC",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_LAC,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of LAC",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_MNA,FOFA2050_SingleActivities,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of MNA",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_MNA,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of MNA",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_SAS,FOFA2050_SingleActivities,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SAS",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SAS,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SAS",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_SSA,FOFA2050_SingleActivities,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SSA",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SSA,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SSA",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_EU,FOFA2050_SingleActivities,ProductionSystems)                                        $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EU",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EU,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline") /VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EU",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_ECA,FOFA2050_SingleActivities,ProductionSystems)                                       $VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of ECA",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")
          = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_ECA,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline")/VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of ECA",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond","Baseline");


*then derive the areas for the countries, that are not part of the "rest of" groups
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_SweetPotato_And_Yams,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_SweetPotato_And_Yams,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 sweet potato and yams",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_SweetPotato_And_Yams,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_Rapeseed_And_Mustardseed,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_Rapeseed_And_Mustardseed,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"Rape and Mustard seed",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_Rapeseed_And_Mustardseed,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherCrops,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherCrops,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other crops",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherCrops,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherFibreCrops,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherFibreCrops,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other fibre crops",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherFibreCrops,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherFruits,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherFruits,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other fruits",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherFruits,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherOilseeds,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherOilseeds,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other oilseeds",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherOilseeds,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherRootsAndTubers,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherRootsAndTubers,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other roots and tubers",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherRootsAndTubers,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherVegetables,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherVegetables,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other vegetables",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherVegetables,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_CitrusFruits,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_CitrusFruits,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"Citrus Fruits",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_CitrusFruits,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_DriedPulses,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_DriedPulses,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"Pulses,Total",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_DriedPulses,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherCereals,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,FOFA2050_OtherCereals,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_SingleCountries,"FOFA2050 other cereals",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_SingleCountries,FOFA2050_OtherCereals,"AllProdSyst");

*derive areas of countries in "rest of" in activity groups
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EAP,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EAP,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EAP",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_EAP,ActivityGroupsForFOFA2050Shares,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_HIC,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_HIC,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of HIC",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_HIC,ActivityGroupsForFOFA2050Shares,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_LAC,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_LAC,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of LAC",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_LAC,ActivityGroupsForFOFA2050Shares,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_MNA,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_MNA,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of MNA",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_MNA,ActivityGroupsForFOFA2050Shares,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SAS,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SAS,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SAS",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_SAS,ActivityGroupsForFOFA2050Shares,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SSA,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SSA,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SSA",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_SSA,ActivityGroupsForFOFA2050Shares,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EU,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EU,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EU",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_EU,ActivityGroupsForFOFA2050Shares,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_ECA,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_ECA,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of ECA",ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_ECA,ActivityGroupsForFOFA2050Shares,"AllProdSyst");

*then derive areas for single activities for the countries that are part in the "rest of" groups
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EAP,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EAP,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EAP",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_EAP,FOFA2050_SingleActivities,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_HIC,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_HIC,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of HIC",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_HIC,FOFA2050_SingleActivities,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_LAC,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_LAC,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of LAC",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_LAC,FOFA2050_SingleActivities,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_MNA,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_MNA,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of MNA",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_MNA,FOFA2050_SingleActivities,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SAS,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SAS,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SAS",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_SAS,FOFA2050_SingleActivities,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SSA,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_SSA,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of SSA",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_SSA,FOFA2050_SingleActivities,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EU,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_EU,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of EU",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_EU,FOFA2050_SingleActivities,"AllProdSyst");
VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_ECA,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FOFA2050_Rest_of_ECA,FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = VActCropsGrass_QuantityActUnits_MR.l("FOFA2050 Rest of ECA",FOFA2050_SingleActivities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(FOFA2050_Rest_of_ECA,FOFA2050_SingleActivities,"AllProdSyst");


Set MatchFOFA2050_CountryToCountryGroup(Regions,Regions_2)
/
#FOFA2050_Rest_of_EAP."FOFA2050 Rest of EAP"
#FOFA2050_Rest_of_HIC."FOFA2050 Rest of HIC"
#FOFA2050_Rest_of_LAC."FOFA2050 Rest of LAC"
#FOFA2050_Rest_of_MNA."FOFA2050 Rest of MNA"
#FOFA2050_Rest_of_SAS."FOFA2050 Rest of SAS"
#FOFA2050_Rest_of_SSA."FOFA2050 Rest of SSA"
#FOFA2050_Rest_of_EU."FOFA2050 Rest of EU"
#FOFA2050_Rest_of_ECA."FOFA2050 Rest of ECA"
/;

Set MatchFOFA2050_ActivityToActivityGroup(Activities,Activities_2)
/
#FOFA2050_SweetPotato_And_Yams     ."FOFA2050 sweet potato and yams"
#FOFA2050_Rapeseed_And_Mustardseed ."Rape and Mustard seed"
#FOFA2050_OtherCrops               ."FOFA2050 other crops"
#FOFA2050_OtherFibreCrops          ."FOFA2050 other fibre crops"
#FOFA2050_OtherFruits              ."FOFA2050 other fruits"
#FOFA2050_OtherOilseeds            ."FOFA2050 other oilseeds"
#FOFA2050_OtherRootsAndTubers      ."FOFA2050 other roots and tubers"
#FOFA2050_OtherVegetables          ."FOFA2050 other vegetables"
#FOFA2050_CitrusFruits             ."Citrus Fruits"
#FOFA2050_DriedPulses              ."Pulses,Total"
#FOFA2050_OtherCereals             ."FOFA2050 other cereals"
/;


*assign areas harvested to all countries and activities:
VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = sum((RegionsForFOFA2050Shares,ActivityGroupsForFOFA2050Shares)$(MatchFOFA2050_CountryToCountryGroup(Countries,RegionsForFOFA2050Shares)
                                 AND MatchFOFA2050_ActivityToActivityGroup(Activities,ActivityGroupsForFOFA2050Shares)),
                 VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                         *Aux_ShareActCountrInActGroupRegion_CropsFOFA2050(Countries,Activities,"AllProdSyst"));


*assign the livestock data to the countries in the "rest of" regions:
VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of EAP",Activities,"Living","AllProdSyst","AllProdCond","Baseline") = sum(FOFA2050_Rest_of_EAP,VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_EAP,Activities,"Living","AllProdSyst","AllProdCond","Baseline"));
VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of HIC",Activities,"Living","AllProdSyst","AllProdCond","Baseline") = sum(FOFA2050_Rest_of_HIC,VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_HIC,Activities,"Living","AllProdSyst","AllProdCond","Baseline"));
VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of LAC",Activities,"Living","AllProdSyst","AllProdCond","Baseline") = sum(FOFA2050_Rest_of_LAC,VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_LAC,Activities,"Living","AllProdSyst","AllProdCond","Baseline"));
VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of MNA",Activities,"Living","AllProdSyst","AllProdCond","Baseline") = sum(FOFA2050_Rest_of_MNA,VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_MNA,Activities,"Living","AllProdSyst","AllProdCond","Baseline"));
VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of SAS",Activities,"Living","AllProdSyst","AllProdCond","Baseline") = sum(FOFA2050_Rest_of_SAS,VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_SAS,Activities,"Living","AllProdSyst","AllProdCond","Baseline"));
VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of SSA",Activities,"Living","AllProdSyst","AllProdCond","Baseline") = sum(FOFA2050_Rest_of_SSA,VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_SSA,Activities,"Living","AllProdSyst","AllProdCond","Baseline"));
VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of EU",Activities,"Living","AllProdSyst","AllProdCond","Baseline")  = sum(FOFA2050_Rest_of_EU,VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_EU,Activities,"Living","AllProdSyst","AllProdCond","Baseline"));
VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of ECA",Activities,"Living","AllProdSyst","AllProdCond","Baseline") = sum(FOFA2050_Rest_of_ECA,VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_ECA,Activities,"Living","AllProdSyst","AllProdCond","Baseline"));

Parameter Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(Regions,Activities);

*for countries in "rest of" regions: single country shares per activity groups
Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_EAP,Activities)                                                $VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of EAP",Activities,"Living","AllProdSyst","AllProdCond","Baseline")
           = VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_EAP,Activities,"Living","AllProdSyst","AllProdCond","Baseline")/VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of EAP",Activities,"Living","AllProdSyst","AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_HIC,Activities)                                                $VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of HIC",Activities,"Living","AllProdSyst","AllProdCond","Baseline")
           = VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_HIC,Activities,"Living","AllProdSyst","AllProdCond","Baseline")/VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of HIC",Activities,"Living","AllProdSyst","AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_LAC,Activities)                                                $VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of LAC",Activities,"Living","AllProdSyst","AllProdCond","Baseline")
           = VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_LAC,Activities,"Living","AllProdSyst","AllProdCond","Baseline")/VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of LAC",Activities,"Living","AllProdSyst","AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_MNA,Activities)                                                $VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of MNA",Activities,"Living","AllProdSyst","AllProdCond","Baseline")
           = VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_MNA,Activities,"Living","AllProdSyst","AllProdCond","Baseline")/VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of MNA",Activities,"Living","AllProdSyst","AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_SAS,Activities)                                                $VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of SAS",Activities,"Living","AllProdSyst","AllProdCond","Baseline")
           = VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_SAS,Activities,"Living","AllProdSyst","AllProdCond","Baseline")/VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of SAS",Activities,"Living","AllProdSyst","AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_SSA,Activities)                                                $VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of SSA",Activities,"Living","AllProdSyst","AllProdCond","Baseline")
           = VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_SSA,Activities,"Living","AllProdSyst","AllProdCond","Baseline")/VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of SSA",Activities,"Living","AllProdSyst","AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_EU,Activities)                                                 $VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of EU" ,Activities,"Living","AllProdSyst","AllProdCond","Baseline")
           = VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_EU,Activities,"Living","AllProdSyst","AllProdCond","Baseline") /VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of EU" ,Activities,"Living","AllProdSyst","AllProdCond","Baseline");
Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_ECA,Activities)                                                $VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of ECA",Activities,"Living","AllProdSyst","AllProdCond","Baseline")
           = VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_ECA,Activities,"Living","AllProdSyst","AllProdCond","Baseline")/VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of ECA",Activities,"Living","AllProdSyst","AllProdCond","Baseline");

*derive shares of countries in "rest of" for animals
VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_EAP,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_EAP,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of EAP",Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios) *Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_EAP,Activities);
VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_HIC,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_HIC,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of HIC",Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios) *Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_HIC,Activities);
VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_LAC,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_LAC,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of LAC",Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios) *Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_LAC,Activities);
VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_MNA,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_MNA,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of MNA",Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios) *Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_MNA,Activities);
VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_SAS,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_SAS,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of SAS",Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios) *Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_SAS,Activities);
VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_SSA,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_SSA,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of SSA",Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios) *Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_SSA,Activities);
VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_EU ,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_EU ,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of EU" ,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios) *Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_EU ,Activities);
VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_ECA,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(FOFA2050_Rest_of_ECA,Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l("FOFA2050 Rest of ECA",Activities,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios) *Aux_ShareActCountrInActGroupRegion_AnimalsFOFA2050(FOFA2050_Rest_of_ECA,Activities);


*next derive yields for the single activities and countries in activity groups and regions, where these are not yet available:
*do this via yield increases from 2012 to 2050 for the activity groups and regions reported and then apply this to the yields of corresponding single activities and countries, taken from the FAOSTAT Baseline

Parameter Aux_FOFA2050YieldIncreaseBaseline_Scenario(Regions,Activities,ProductionSystems,Scenarios);

Aux_FOFA2050YieldIncreaseBaseline_Scenario(Regions,Activities,ProductionSystems,FOFA2050_Scenarios)
                 $ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,"AllProdCond","FOFA_BAU_2012")
         = ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 /ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,"AllProdCond","FOFA_BAU_2012");

*Aux_FOFA2050YieldIncreaseBaseline_Scenario(Regions,ActivityGroupsForFOFA2050Shares,ProductionSystems,"FOFA_BAU_2050")
*                 $ActCropsGrass_Outputs_MR(Regions,ActivityGroupsForFOFA2050Shares,"MainOutput1 (t)",ProductionSystems,"AllProdCond","FOFA_Baseline_2012")
*         = ActCropsGrass_Outputs_MR(Regions,ActivityGroupsForFOFA2050Shares,"MainOutput1 (t)",ProductionSystems,"AllProdCond","FOFA_BAU_2050")
*                 /ActCropsGrass_Outputs_MR(Regions,ActivityGroupsForFOFA2050Shares,"MainOutput1 (t)",ProductionSystems,"AllProdCond","FOFA_Baseline_2012");

*for FOFA_BAU_2050:
ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = sum(ActivityGroupsForFOFA2050Shares$MatchFOFA2050_ActivityToActivityGroup(Activities,ActivityGroupsForFOFA2050Shares),
                  ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond","Baseline")
                         *Aux_FOFA2050YieldIncreaseBaseline_Scenario(Regions,ActivityGroupsForFOFA2050Shares,ProductionSystems,FOFA2050_Scenarios));

*assign yield increases to single activities:
Aux_FOFA2050YieldIncreaseBaseline_Scenario(Regions,Activities,ProductionSystems,FOFA2050_Scenarios)
                 $(NOT Aux_FOFA2050YieldIncreaseBaseline_Scenario(Regions,Activities,ProductionSystems,FOFA2050_Scenarios))
         = sum(ActivityGroupsForFOFA2050Shares$MatchFOFA2050_ActivityToActivityGroup(Activities,ActivityGroupsForFOFA2050Shares),
                 Aux_FOFA2050YieldIncreaseBaseline_Scenario(Regions,ActivityGroupsForFOFA2050Shares,ProductionSystems,FOFA2050_Scenarios));

*now, the regional group values can be assigned to the single countries as the yield increase is available on activity level
ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         = sum(RegionsForFOFA2050Shares$MatchFOFA2050_CountryToCountryGroup(Regions,RegionsForFOFA2050Shares),
                  ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond","Baseline")
                         *Aux_FOFA2050YieldIncreaseBaseline_Scenario(RegionsForFOFA2050Shares,Activities,ProductionSystems,FOFA2050_Scenarios));

*derive AllProdSyst yields as area-weighted average, where not yet present:
ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
           $(VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 AND (NOT ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond",FOFA2050_Scenarios)))
         = (VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Rainfed","AllProdCond",FOFA2050_Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)","Rainfed","AllProdCond",FOFA2050_Scenarios)
           +VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Irrigated","AllProdCond",FOFA2050_Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)","Irrigated","AllProdCond",FOFA2050_Scenarios))
           /VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst","AllProdCond",FOFA2050_Scenarios);


*livestock yields for the countries in the country groups:
*do this via yield increases from 2012 to 2050 for the regions reported and then apply this to the single countries using FAOSTAT baseline values
Parameter Aux_FOFA2050YieldIncreaseAnimalsBaseline_Scenario(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,Scenarios);

Aux_FOFA2050YieldIncreaseAnimalsBaseline_Scenario(Regions,Livestock,AnimalTypeInHerd,OutputsAnimals,FOFA2050_Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActAnimalsHead_Outputs_MR(Regions,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 /ActAnimalsHead_Outputs_MR(Regions,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond","FOFA_BAU_2012");

ActAnimalsHead_Outputs_MR(Regions,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond",FOFA2050_Scenarios))
         = sum(RegionsForFOFA2050Shares$MatchFOFA2050_CountryToCountryGroup(Regions,RegionsForFOFA2050Shares),
                 ActAnimalsHead_Outputs_MR(Regions,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond","Baseline")
                         *Aux_FOFA2050YieldIncreaseAnimalsBaseline_Scenario(RegionsForFOFA2050Shares,Livestock,AnimalTypeInHerd,OutputsAnimals,FOFA2050_Scenarios));

*there are no egg-yields reported, thus just scale them with the same factor as chicken meat yields scale with:
ActAnimalsHead_Outputs_MR(Regions,"Chickens","Egg producing","Eggs (t)","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions,"Chickens","Meat producing","Meat (t)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActAnimalsHead_Outputs_MR(Regions,"Chickens","Egg producing","Eggs (t)","AllProdSyst","AllProdCond","Baseline")
                 *ActAnimalsHead_Outputs_MR(Regions,"Chickens","Meat producing","Meat (t)","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions,"Chickens","Meat producing","Meat (t)","AllProdSyst","AllProdCond","FOFA_BAU_2012");
*values that are still missing are then derived from the FAOSTAT baseline values
ActAnimalsHead_Outputs_MR(Regions,"Chickens","Egg producing","Eggs (t)","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions,"Chickens","Meat producing","Meat (t)","AllProdSyst","AllProdCond","Baseline")
                         AND (NOT ActAnimalsHead_Outputs_MR(Regions,"Chickens","Egg producing","Eggs (t)","AllProdSyst","AllProdCond",FOFA2050_Scenarios)))
         = ActAnimalsHead_Outputs_MR(Regions,"Chickens","Egg producing","Eggs (t)","AllProdSyst","AllProdCond","Baseline")
                 *ActAnimalsHead_Outputs_MR(Regions,"Chickens","Meat producing","Meat (t)","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions,"Chickens","Meat producing","Meat (t)","AllProdSyst","AllProdCond","Baseline");

*assign regional and crop group values to countries and crops where not yet available:


ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         =sum(Regions_2$MatchFOFA2050_CountryToCountryGroup(Regions,Regions_2),
                 ActCropsGrass_OtherChar_MR(Regions_2,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond",FOFA2050_Scenarios));

ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
                 $(NOT ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond",FOFA2050_Scenarios))
         =sum(Activities_2$MatchFOFA2050_ActivityToActivityGroup(Activities,Activities_2),
                 ActCropsGrass_OtherChar_MR(Regions,Activities_2,OtherCharCropsGrass,ProductionSystems,"AllProdCond",FOFA2050_Scenarios));


*Remove FOFA region and activity group values as now everything is assigned to countries/activities, and remove all FOFA_Baseline_2012 data,
*        as we use the FAOSTAT and other baseline data filed in, and only retain the 2050 projections from FOFA:
$ontext;
NO - for cpompleteness, keep the FOFA baseline BAU 2012
ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,"AllProdCond","FOFA_BAU_2012") = 0;
ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond","FOFA_BAU_2012") = 0;
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond","FOFA_BAU_2012") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,"AllProdCond","FOFA_BAU_2012") = 0;
VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,"Living",ProductionSystems,"AllProdCond","FOFA_BAU_2012") = 0;
VPopulationNumbers_MR.l(Regions,PopulationGroups,"FOFA_BAU_2012") = 0;
$offtext;

ActCropsGrass_Outputs_MR(RegionsForFOFA2050Shares,Activities,"MainOutput1 (t)",ProductionSystems,"AllProdCond",FOFA2050_Scenarios) = 0;
ActCropsGrass_OtherChar_MR(RegionsForFOFA2050Shares,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond",FOFA2050_Scenarios) = 0;
ActAnimalsHead_Outputs_MR(RegionsForFOFA2050Shares,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond",FOFA2050_Scenarios) = 0;
VActCropsGrass_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,Activities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios) = 0;
VActAnimalsHead_QuantityActUnits_MR.l(RegionsForFOFA2050Shares,Activities,"Living",ProductionSystems,"AllProdCond",FOFA2050_Scenarios) = 0;
VPopulationNumbers_MR.l(RegionsForFOFA2050Shares,PopulationGroups,Scenarios) = 0;

ActCropsGrass_Outputs_MR(Regions,ActivityGroupsForFOFA2050Shares,"MainOutput1 (t)",ProductionSystems,"AllProdCond",FOFA2050_Scenarios) = 0;
ActCropsGrass_OtherChar_MR(Regions,ActivityGroupsForFOFA2050Shares,OtherCharCropsGrass,ProductionSystems,"AllProdCond",FOFA2050_Scenarios) = 0;
ActAnimalsHead_Outputs_MR(Regions,ActivityGroupsForFOFA2050Shares,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond",FOFA2050_Scenarios) = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ActivityGroupsForFOFA2050Shares,ProductionSystems,"AllProdCond",FOFA2050_Scenarios) = 0;
VActAnimalsHead_QuantityActUnits_MR.l(Regions,ActivityGroupsForFOFA2050Shares,"Living",ProductionSystems,"AllProdCond",FOFA2050_Scenarios) = 0;




*finally, Read data on per capita kcal and protein use for calibration of trade flows in the model runs

Commod_OtherChar_MR(FOFA2050_SingleCountries,"All Commodities","Cal pc - FOFA original (kcal/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = sum(FOFA2050_Countries$MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,FOFA2050_SingleCountries),
*                 FOFA2050_FoodSecurity("Daily energy supply by commodity","ALL","Daily energy supply",FOFA2050_Countries,"Business as usual","kcal/person/day","2050"));
                 FOFA2050_FoodSecurity_NewScenarioNames("Daily energy supply by commodity","ALL","Daily energy supply",FOFA2050_Countries,"FOFA_BAU_2050","kcal/person/day"));

Commod_OtherChar_MR(FOFA2050_SingleCountries,"All Commodities","Prot pc - FOFA original (g/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = sum(FOFA2050_Countries$MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,FOFA2050_SingleCountries),
*                 FOFA2050_FoodSecurity("Daily energy supply by commodity","ALL","Daily energy supply",FOFA2050_Countries,"Business as usual","<empty>","2050"));
                 FOFA2050_FoodSecurity_NewScenarioNames("Daily protein supply","ALL","Daily energy supply",FOFA2050_Countries,"FOFA_BAU_2050","g/person/day"));



*the following need to be done by hand:
*ALREADY DONE
*Commod_OtherChar_MR("China","All Commodities","Cal pc - FOFA original (kcal/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
*         = FOFA2050_FoodSecurity("Daily energy supply by commodity","ALL","Daily energy supply","China, mainland","Business as usual","kcal/person/day","2050");
*Commod_OtherChar_MR("China","All Commodities","Prot pc - FOFA original (g/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
*         = FOFA2050_FoodSecurity("Daily energy supply by commodity","ALL","Daily energy supply","China, mainland","Business as usual","<empty>","2050");




*storing the model parameters in a gdx and then reading later does not work, as they are already used and initialised in other files,
*thus, no $load-statement will work. Hence assign to an auxiliary storage parameter and then replace after reading:

Parameters
FOFAStorageAux_ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
FOFAStorageAux_ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
FOFAStorageAux_ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
FOFAStorageAux_Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)
;
Variables
FOFAStorageAux_VActCropsGrass_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
FOFAStorageAux_VActAnimalsHead_QuantityActUnits_MR(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
FOFAStorageAux_VPopulationNumbers_MR(Regions,PopulationGroups,Scenarios)
;

FOFAStorageAux_ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
FOFAStorageAux_ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
FOFAStorageAux_ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
         = ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
FOFAStorageAux_Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)
         = Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios);

FOFAStorageAux_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
FOFAStorageAux_VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
FOFAStorageAux_VPopulationNumbers_MR.l(Regions,PopulationGroups,FOFA2050_Scenarios)
         = VPopulationNumbers_MR.l(Regions,PopulationGroups,FOFA2050_Scenarios);

execute_unload "FOFA2050"
FOFAStorageAux_ActCropsGrass_Outputs_MR
FOFAStorageAux_ActCropsGrass_OtherChar_MR
FOFAStorageAux_ActAnimalsHead_Outputs_MR
FOFAStorageAux_VActCropsGrass_QuantityActUnits_MR
FOFAStorageAux_VActAnimalsHead_QuantityActUnits_MR
FOFAStorageAux_VPopulationNumbers_MR
FOFAStorageAux_Commod_OtherChar_MR
;

$goto EndOfReadData_FOFA2050

$label UseOldFOFA2050Data

*first, define the needed parameters and variables, as hey are not defined if the code above is not run, but the results from earlier runs are filed in:
Parameters
FOFAStorageAux_ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
FOFAStorageAux_ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
FOFAStorageAux_ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
FOFAStorageAux_Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)
;
Variables
FOFAStorageAux_VActCropsGrass_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
FOFAStorageAux_VActAnimalsHead_QuantityActUnits_MR(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
FOFAStorageAux_VPopulationNumbers_MR(Regions,PopulationGroups,Scenarios)
;

$gdxin FOFA2050.gdx
$load FOFAStorageAux_ActCropsGrass_Outputs_MR
$load FOFAStorageAux_ActCropsGrass_OtherChar_MR
$load FOFAStorageAux_ActAnimalsHead_Outputs_MR
$load FOFAStorageAux_VActCropsGrass_QuantityActUnits_MR
$load FOFAStorageAux_VActAnimalsHead_QuantityActUnits_MR
$load FOFAStorageAux_VPopulationNumbers_MR
$load FOFAStorageAux_Commod_OtherChar_MR
$gdxin

*assign to model parameters and variables:
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios))
         = FOFAStorageAux_ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,FOFA2050_Scenarios))
         = FOFAStorageAux_ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
                 $(NOT ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios))
         = FOFAStorageAux_ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios))
         = FOFAStorageAux_Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios);

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,FOFA2050_Scenarios))
         = FOFAStorageAux_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,FOFA2050_Scenarios))
         = FOFAStorageAux_VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
VPopulationNumbers_MR.l(Regions,PopulationGroups,FOFA2050_Scenarios)
                 $(NOT VPopulationNumbers_MR.l(Regions,PopulationGroups,FOFA2050_Scenarios))
         = FOFAStorageAux_VPopulationNumbers_MR.l(Regions,PopulationGroups,FOFA2050_Scenarios);


*and remove the auxiliary storage parameters:
FOFAStorageAux_ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios) = 0;
FOFAStorageAux_ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios) = 0;
FOFAStorageAux_ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios) = 0;
FOFAStorageAux_Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios) = 0;
FOFAStorageAux_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios) = 0;
FOFAStorageAux_VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios) = 0;
FOFAStorageAux_VPopulationNumbers_MR.l(Regions,PopulationGroups,Scenarios) =0;


$label EndOfReadData_FOFA2050


*correct data for Maize: FOFA has "maize, green", SOLm baseline has "maize" equalling this, and hardly any "maize, green", thus assign as follows:
ActCropsGrass_Outputs_MR(Regions,"Maize",OutputsCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
         = ActCropsGrass_Outputs_MR(Regions,"Maize, green",OutputsCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
ActCropsGrass_OtherChar_MR(Regions,"Maize",OtherCharCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
         = ActCropsGrass_OtherChar_MR(Regions,"Maize, green",OtherCharCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios);
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Maize",ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Maize, green",ProductionSystems,ProductionConditions,FOFA2050_Scenarios);

ActCropsGrass_Outputs_MR(Regions,"Maize, green",OutputsCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
         = 0;
ActCropsGrass_OtherChar_MR(Regions,"Maize, green",OtherCharCropsGrass,ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
         = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Maize, green",ProductionSystems,ProductionConditions,FOFA2050_Scenarios)
         = 0;

*derive average cropping intensity for irrig and rainfed areas:
ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","AllProdSyst",ProductionConditions,FOFA2050_Scenarios)
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Irrigated",ProductionConditions,FOFA2050_Scenarios)
                         +VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Rainfed",ProductionConditions,FOFA2050_Scenarios))
         = (ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","Irrigated",ProductionConditions,FOFA2050_Scenarios)
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Irrigated",ProductionConditions,FOFA2050_Scenarios)
         + ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","Rainfed",ProductionConditions,FOFA2050_Scenarios)
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Rainfed",ProductionConditions,FOFA2050_Scenarios))
         /(VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Irrigated",ProductionConditions,FOFA2050_Scenarios)
                 +VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Rainfed",ProductionConditions,FOFA2050_Scenarios));

*assign cropping intensity values to the baseline as well - thus do it to the parameter without _MR, as the baseline values are assigned with scenario dimension in SteeringFile2 only, based on the parameters without _MR:
ActCropsGrass_OtherChar(Regions,Activities,"Cropping intensity (ratio)","AllProdSyst",ProductionConditions)
         = ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","AllProdSyst",ProductionConditions,"FOFA_BAU_2012");

*if data on CI is missing, assign a value of 1:
ActCropsGrass_OtherChar(Regions,Activities,"Cropping intensity (ratio)","AllProdSyst",ProductionConditions)
                 $(VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst",ProductionConditions)
                          AND (NOT ActCropsGrass_OtherChar(Regions,Activities,"Cropping intensity (ratio)","AllProdSyst",ProductionConditions)))
         = 1;
ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","AllProdSyst",ProductionConditions,Scenarios)
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,Scenarios)
                          AND (NOT ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","AllProdSyst",ProductionConditions,Scenarios)))
         = 1;


*assign cropping intensity as a per ha area harvested value: i.e. the inverse as the physical area occupied per harvested area (for CI > 1 this is < 1, for CI < 1 it is > 1)
ActCropsGrass_OtherChar_MR(Regions,Activities,"Area occupied physically (ha)","AllProdSyst",ProductionConditions,Scenarios)
                 $ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","AllProdSyst",ProductionConditions,Scenarios)
         = 1/ActCropsGrass_OtherChar_MR(Regions,Activities,"Cropping intensity (ratio)","AllProdSyst",ProductionConditions,Scenarios);
*similar for the baseline value:
ActCropsGrass_OtherChar(Regions,Activities,"Area occupied physically (ha)","AllProdSyst",ProductionConditions)
                 $ActCropsGrass_OtherChar(Regions,Activities,"Cropping intensity (ratio)","AllProdSyst",ProductionConditions)
         = 1/ActCropsGrass_OtherChar(Regions,Activities,"Cropping intensity (ratio)","AllProdSyst",ProductionConditions);




$exit;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Read data on per capita kcal and protein use for calibration of trade flows in the model runs

Commod_OtherChar_MR(FOFA2050_SingleCountries,"All Commodities","Cal pc - FOFA original (kcal/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = sum(FOFA2050_Countries$MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,FOFA2050_SingleCountries),
                 FOFA2050_FoodSecurity("Daily energy supply by commodity","ALL","kcal/person/day",FOFA2050_Countries,"Business as usual","Daily energy supply","2050"));

*protein is reported as follows (although units/labels refer to energy - seems to have gone wrong when compiling the data - but the values seem ok), in units g Protein/cap/day
Commod_OtherChar_MR(FOFA2050_SingleCountries,"All Commodities","Prot pc - FOFA original (g/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = sum(FOFA2050_Countries$MatchFOFA2050_SOLm_Countries(FOFA2050_Countries,FOFA2050_SingleCountries),
                 FOFA2050_FoodSecurity("Daily energy supply by commodity","ALL","<empty>",FOFA2050_Countries,"Business as usual","Daily energy supply","2050"));

*the following need to be done by hand:
Commod_OtherChar_MR("China","All Commodities","Cal pc - FOFA original (kcal/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = FOFA2050_FoodSecurity("Daily energy supply by commodity","ALL","kcal/person/day","China, mainland","Business as usual","Daily energy supply","2050");
Commod_OtherChar_MR("China","All Commodities","Prot pc - FOFA original (g/cap/day)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = FOFA2050_FoodSecurity("Daily energy supply by commodity","ALL","<empty>","China, mainland","Business as usual","Daily energy supply","2050");



$ontext;
After this we have the following in SOLm entities:

ActCropsGrass_Outputs_MR(Countries,Activities,"MainOutput1 (t)",ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
ActCropsGrass_OtherChar_MR(Countries,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
ActAnimalsHead_Outputs_MR(Countries,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond",FOFA2050_Scenarios)
VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities,ProductionSystems,"AllProdCond",FOFA2050_Scenarios)
VActAnimalsHead_QuantityActUnits_MR.l(Countries,Livestock,"Living","AllProdSyst","AllProdCond",FOFA2050_Scenarios)
VPopulationNumbers_MR.l(Regions,PopulationGroups,Scenarios)

Activities  is      FAOSTAT_CropProductionItems

$offtext;






