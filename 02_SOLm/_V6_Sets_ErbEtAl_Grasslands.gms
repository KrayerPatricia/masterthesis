PUTCLOSE con,"_V6_Sets_ErbEtAl_Grasslands";

$ontext;
GENERAL DESCRIPTION
This file declares the sets needed to file in Erb et al. 2007 Grassland Data
(Erb et al. 2007 is the following: Erb et al. 2007, A comprehensive global 5 min resolution land-use data set for the year 2000 consistent with national census data, Journal of Land Use Science 2(3) 191–224)

DETAILED TABLE OF CONTENTS
the following sets are declared below:

- 1) Sets used for the Erb et al. Grassland data:
         1.1) yield class data and yields
         1.2) nutrient elements
         1.3) Country list

SHORT SUMMARY:
In this code file, the following sets are defined:
Set ErbEtAl_GrasslandYieldClasses Different grass yield classes
Set ErbEtAl_AverageYieldElement Average grass yield elements such as tDM per ha
Set ErbEtAl_GrasslandNutrientElements Grass nutrient elements such as tDM per ton or MJ per tDM
Set ErbEtAl_GrasslandDataCountriesAndRegions Countries and regions as used in Erb et al. 2007 grassland data
Set ErbEtAl_GrasslandDataCountryList(ErbEtAl_GrasslandDataCountriesAndRegions) Sub-set with countries as used in Erb et al. 2007 grassland data
Set ErbEtAl_GrasslandDataRegions(ErbEtAl_GrasslandDataCountriesAndRegions) Sub-set with regions as used in Erb et al. 2007 grassland data
Set ErbEtAl_GrasslandDataCountriesInRegions(ErbEtAl_GrasslandDataRegions,ErbEtAl_GrasslandDataCountryList) Two dimensional set containing all Erb et al. 2007 grassland regions matched to countries

$offtext;

*1) Sets used for the Erb et al. Grassland data:
*1.1) yield class data and yields

Set ErbEtAl_GrasslandYieldClasses Different grass yield classes
*from the file ErbEtAl_GrasslandData_17_12_2012.xlsx
/
GrassClass1
GrassClass2
GrassClass3
GrassClass4
/;

*the following set is used after having read in the data
Set ErbEtAl_AverageYieldElement Average grass yield elements such as tDM per ha
/
"AverageDMYield (tDM/ha)"
"AverageFreshMatterYield (t/ha)"
/;

*1.2) nutrient elements
Set ErbEtAl_GrasslandNutrientElements Grass nutrient elements such as tDM per ton or MJ per tDM
*from the file ErbEtAl_GrasslandData_17_12_2012.xlsx
*and additional ones needed to further process this data
/
"FeedME (MJ/tDM)"
"FeedXP (kg/tDM)"

"AverageDMContents (tDM/t)"
"AverageFeedMEContents (MJ/t)"
"AverageFeedXPContents (t/t)"
"AverageFeedGEContents (MJ/t)"

"AverageNContents (tN/t)"
/;

*1.3) Country list
*the following is the list of countries and regions used in the Erb grassland data - it differs from the FAOSTAT list by having some dozen additional ones and some 2 dozens missing,
*these ar listed below, after the set with all ErbEtAl-countries and -regions;
*where the same countries were included but with different spelling, we changed in Erb et al. data to the spelling of FAOSTAT (Czechia, Cabo Verde, maybe some more).
*first, the set with all countries and regions is given, then countries and regions separately

Set ErbEtAl_GrasslandDataCountriesAndRegions Countries and regions as used in Erb et al. 2007 grassland data
*contains all countries and regions which separately are then subsets defined below
/
Afghanistan
Albania
Algeria
Andorra
Angola
"Antigua and Barbuda"
Argentina
Armenia
Australia
Austria
Azerbaijan
Bahamas
Bahrain
Bangladesh
Barbados
Belarus
Belgium
Luxembourg
Belize
Benin
Bhutan
"Bolivia (Plurinational State of)"
"Bosnia and Herzegovina"
Botswana
Brazil
"Brunei Darussalam"
Bulgaria
"Burkina Faso"
Burundi
Cambodia
Cameroon
Canada
"Cabo Verde"
"Cayman Islands"
"Central African Republic"
Chad
Chile
China
Colombia
Comoros
Congo
"Cook Islands"
"Costa Rica"
"Côte d'Ivoire"
Croatia
Cuba
Cyprus
Czechia
"Democratic Republic of the Congo"
Denmark
Djibouti
Dominica
"Dominican Republic"
"Timor-Leste"
Ecuador
Egypt
"El Salvador"
"Equatorial Guinea"
Eritrea
Estonia
Ethiopia
"Faroe Islands"
"Falkland Islands (Malvinas)"
Fiji
Finland
France
"French Guiana"
"French Polynesia"
Gabon
Gambia
"Occupied Palestinian Territory"
Georgia
Germany
Ghana
Greece
Greenland
Grenada
Guadeloupe
Guam
Guatemala
Guinea
"Guinea-Bissau"
Guyana
Haiti
Honduras
Hungary
Iceland
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
Kiribati
"Democratic People's Republic of Korea"
"Republic of Korea"
Kuwait
Kyrgyzstan
"Lao People's Democratic Republic"
Latvia
Lebanon
Lesotho
Liberia
Libya
Liechtenstein
Lithuania
Madagascar
Malawi
Malaysia
Mali
Malta
Martinique
Mauritania
Mauritius
Mexico
"Micronesia (Federated States of)"
Mongolia
Montserrat
Morocco
Mozambique
Myanmar
Namibia
Nepal
Netherlands
"Netherlands Antilles (former)"
"New Caledonia"
"New Zealand"
Nicaragua
Niger
Nigeria
Niue
Norway
Oman
Pakistan
Palau
Panama
"Papua New Guinea"
Paraguay
Peru
Philippines
Poland
Portugal
"Puerto Rico"
Qatar
"Republic of Moldova"
"Réunion"
Romania
"Russian Federation"
Rwanda
Samoa
"San Marino"
"Sao Tome and Principe"
"Saudi Arabia"
Senegal
"Sierra Leone"
Singapore
Slovakia
Slovenia
"Solomon Islands"
Somalia
"South Africa"
Spain
"Sri Lanka"
"Saint Helena"
"Saint Kitts and Nevis"
"Saint Lucia"
"Saint Pierre and Miquelon"
"Saint Vincent and the Grenadines"
Sudan
Suriname
Swaziland
Sweden
Switzerland
"Syrian Arab Republic"
"The former Yugoslav Republic of Macedonia"
Tajikistan
Thailand
Togo
Tonga
"Trinidad and Tobago"
Tunisia
Turkey
Turkmenistan
"Turks and Caicos Islands"
Uganda
Ukraine
"United Arab Emirates"
"United Kingdom"
"United Republic of Tanzania"
"United States of America"
"United States Virgin Islands"
Uruguay
Uzbekistan
Vanuatu
"Venezuela (Bolivarian Republic of)"
"Viet Nam"
"Wallis and Futuna Islands"
"Western Sahara"
Yemen
serbia
montenegro
"Yugoslav SFR"
Zambia
Zimbabwe

World
Africa
Americas
Asia
Europe
Oceania
/;

$ontext;
*List of countries included in Erb country list, missing in FAOSTAT:
/
Andorra
French Guiana
Greenland
Guadeloupe
Liechtenstein
Martinique
Micronesia (Federated States of)
Montserrat
Palau
Puerto Rico
Turks and Caicos Islands
United States Virgin Islands
Wallis and Futuna Islands
Western Sahara
/;

*List of countries missing in Erb country list, included in FAOSTAT:
*part of them also do not exist anymore, such as USSR, etc. s

/
American Samoa
Aruba
Belgium-Luxembourg
Bermuda
British Virgin Islands
China, Hong Kong SAR
China, Macao SAR
China, mainland
China, Taiwan Province of
Czechoslovakia
Ethiopia PDR
Maldives
Nauru
Norfolk Island
Pacific Islands Trust Territory
Republic of Moldova
Serbia and Montenegro
Seychelles
South Sudan
Sudan (former)
Tuvalu
USSR
/;

$offtext;

Set ErbEtAl_GrasslandDataCountryList(ErbEtAl_GrasslandDataCountriesAndRegions) Sub-set with countries as used in Erb et al. 2007 grassland data
/
Afghanistan
Albania
Algeria
Andorra
Angola
"Antigua and Barbuda"
Argentina
Armenia
Australia
Austria
Azerbaijan
Bahamas
Bahrain
Bangladesh
Barbados
Belarus
Belgium
Luxembourg
Belize
Benin
Bhutan
"Bolivia (Plurinational State of)"
"Bosnia and Herzegovina"
Botswana
Brazil
"Brunei Darussalam"
Bulgaria
"Burkina Faso"
Burundi
Cambodia
Cameroon
Canada
"Cabo Verde"
"Cayman Islands"
"Central African Republic"
Chad
Chile
China
Colombia
Comoros
Congo
"Cook Islands"
"Costa Rica"
"Côte d'Ivoire"
Croatia
Cuba
Cyprus
Czechia
"Democratic Republic of the Congo"
Denmark
Djibouti
Dominica
"Dominican Republic"
"Timor-Leste"
Ecuador
Egypt
"El Salvador"
"Equatorial Guinea"
Eritrea
Estonia
Ethiopia
"Faroe Islands"
"Falkland Islands (Malvinas)"
Fiji
Finland
France
"French Guiana"
"French Polynesia"
Gabon
Gambia
"Occupied Palestinian Territory"
Georgia
Germany
Ghana
Greece
Greenland
Grenada
Guadeloupe
Guam
Guatemala
Guinea
"Guinea-Bissau"
Guyana
Haiti
Honduras
Hungary
Iceland
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
Kiribati
"Democratic People's Republic of Korea"
"Republic of Korea"
Kuwait
Kyrgyzstan
"Lao People's Democratic Republic"
Latvia
Lebanon
Lesotho
Liberia
Libya
Liechtenstein
Lithuania
Madagascar
Malawi
Malaysia
Mali
Malta
Martinique
Mauritania
Mauritius
Mexico
"Micronesia (Federated States of)"
Mongolia
Montserrat
Morocco
Mozambique
Myanmar
Namibia
Nepal
Netherlands
"Netherlands Antilles (former)"
"New Caledonia"
"New Zealand"
Nicaragua
Niger
Nigeria
Niue
Norway
Oman
Pakistan
Palau
Panama
"Papua New Guinea"
Paraguay
Peru
Philippines
Poland
Portugal
"Puerto Rico"
Qatar
"Republic of Moldova"
"Réunion"
Romania
"Russian Federation"
Rwanda
Samoa
"San Marino"
"Sao Tome and Principe"
"Saudi Arabia"
Senegal
"Sierra Leone"
Singapore
Slovakia
Slovenia
"Solomon Islands"
Somalia
"South Africa"
Spain
"Sri Lanka"
"Saint Helena"
"Saint Kitts and Nevis"
"Saint Lucia"
"Saint Pierre and Miquelon"
"Saint Vincent and the Grenadines"
Sudan
Suriname
Swaziland
Sweden
Switzerland
"Syrian Arab Republic"
"The former Yugoslav Republic of Macedonia"
Tajikistan
Thailand
Togo
Tonga
"Trinidad and Tobago"
Tunisia
Turkey
Turkmenistan
"Turks and Caicos Islands"
Uganda
Ukraine
"United Arab Emirates"
"United Kingdom"
"United Republic of Tanzania"
"United States of America"
"United States Virgin Islands"
Uruguay
Uzbekistan
Vanuatu
"Venezuela (Bolivarian Republic of)"
"Viet Nam"
"Wallis and Futuna Islands"
"Western Sahara"
Yemen
serbia
montenegro
"Yugoslav SFR"
Zambia
Zimbabwe
/;

Set ErbEtAl_GrasslandDataRegions(ErbEtAl_GrasslandDataCountriesAndRegions) Sub-set with regions as used in Erb et al. 2007 grassland data
/
World
Africa
Americas
Asia
Europe
Oceania
/;

Set ErbEtAl_GrasslandDataCountriesInRegions(ErbEtAl_GrasslandDataRegions,ErbEtAl_GrasslandDataCountryList) Two dimensional set containing all Erb et al. 2007 grassland regions matched to countries
*this assigns the countries from the Erb et al. grassland data to the regions used there to assign the nutrient contets
/
"Africa"."Algeria"
"Africa"."Angola"
"Africa"."Benin"
"Africa"."Botswana"
"Africa"."Burkina Faso"
"Africa"."Burundi"
"Africa"."Cabo Verde"
"Africa"."Cameroon"
"Africa"."Central African Republic"
"Africa"."Chad"
"Africa"."Comoros"
"Africa"."Congo"
"Africa"."Côte d'Ivoire"
"Africa"."Democratic Republic of the Congo"
"Africa"."Djibouti"
"Africa"."Egypt"
"Africa"."Equatorial Guinea"
"Africa"."Eritrea"
"Africa"."Ethiopia"
"Africa"."Gabon"
"Africa"."Gambia"
"Africa"."Ghana"
"Africa"."Guinea"
"Africa"."Guinea-Bissau"
"Africa"."Kenya"
"Africa"."Lesotho"
"Africa"."Liberia"
"Africa"."Libya"
"Africa"."Madagascar"
"Africa"."Malawi"
"Africa"."Mali"
"Africa"."Mauritania"
"Africa"."Mauritius"
"Africa"."Morocco"
"Africa"."Mozambique"
"Africa"."Namibia"
"Africa"."Niger"
"Africa"."Nigeria"
"Africa"."Rwanda"
"Africa"."Sao Tome and Principe"
"Africa"."Senegal"
"Africa"."Sierra Leone"
"Africa"."Somalia"
"Africa"."South Africa"
"Africa"."Sudan"
"Africa"."Swaziland"
"Africa"."Togo"
"Africa"."Tunisia"
"Africa"."Uganda"
"Africa"."United Republic of Tanzania"
"Africa"."Zambia"
"Africa"."Zimbabwe"
"Africa"."Western Sahara"
"Americas"."Antigua and Barbuda"
"Americas"."Argentina"
"Americas"."Bahamas"
"Americas"."Barbados"
"Americas"."Belize"
"Americas"."Bolivia (Plurinational State of)"
"Americas"."Brazil"
"Americas"."Canada"
"Americas"."Cayman Islands"
"Americas"."Chile"
"Americas"."Colombia"
"Americas"."Costa Rica"
"Americas"."Cuba"
"Americas"."Dominica"
"Americas"."Dominican Republic"
"Americas"."Ecuador"
"Americas"."El Salvador"
"Americas"."Falkland Islands (Malvinas)"
"Americas"."Grenada"
"Americas"."Guatemala"
"Americas"."Guyana"
"Americas"."Haiti"
"Americas"."Honduras"
"Americas"."Jamaica"
"Americas"."Mexico"
"Americas"."Netherlands Antilles (former)"
"Americas"."Nicaragua"
"Americas"."Panama"
"Americas"."Paraguay"
"Americas"."Peru"
"Americas"."Saint Kitts and Nevis"
"Americas"."Saint Lucia"
"Americas"."Saint Pierre and Miquelon"
"Americas"."Saint Vincent and the Grenadines"
"Americas"."Suriname"
"Americas"."Trinidad and Tobago"
"Americas"."United States of America"
"Americas"."Uruguay"
"Americas"."Venezuela (Bolivarian Republic of)"
"Americas".Guadeloupe
"Americas"."Puerto Rico"
"Americas"."French Guiana"
"Americas".Martinique
"Americas".Montserrat
"Americas"."Turks and Caicos Islands"
"Americas"."United States Virgin Islands"
"Asia"."Afghanistan"
"Asia"."Armenia"
"Asia"."Azerbaijan"
"Asia"."Bahrain"
"Asia"."Bangladesh"
"Asia"."Bhutan"
"Asia"."Brunei Darussalam"
"Asia"."Cambodia"
"Asia"."China"
"Asia"."Cyprus"
"Asia"."Democratic People's Republic of Korea"
"Asia"."Georgia"
"Asia"."India"
"Asia"."Indonesia"
"Asia"."Iran (Islamic Republic of)"
"Asia"."Iraq"
"Asia"."Israel"
"Asia"."Japan"
"Asia"."Jordan"
"Asia"."Kazakhstan"
"Asia"."Kuwait"
"Asia"."Kyrgyzstan"
"Asia"."Lao People's Democratic Republic"
"Asia"."Lebanon"
"Asia"."Malaysia"
"Asia"."Mongolia"
"Asia"."Myanmar"
"Asia"."Nepal"
"Asia"."Occupied Palestinian Territory"
"Asia"."Oman"
"Asia"."Pakistan"
"Asia"."Philippines"
"Asia"."Qatar"
"Asia"."Republic of Korea"
"Asia"."Saudi Arabia"
"Asia"."Singapore"
"Asia"."Sri Lanka"
"Asia"."Syrian Arab Republic"
"Asia"."Tajikistan"
"Asia"."Thailand"
"Asia"."Timor-Leste"
"Asia"."Turkey"
"Asia"."Turkmenistan"
"Asia"."United Arab Emirates"
"Asia"."Uzbekistan"
"Asia"."Viet Nam"
"Asia"."Yemen"
"Europe"."Albania"
"Europe"."Austria"
"Europe"."Belarus"
"Europe"."Belgium"
"Europe"."Bosnia and Herzegovina"
"Europe"."Bulgaria"
"Europe"."Croatia"
"Europe"."Czechia"
"Europe"."Denmark"
"Europe"."Estonia"
"Europe"."Faroe Islands"
"Europe"."Finland"
"Europe"."France"
"Europe"."Germany"
"Europe"."Greece"
"Europe"."Hungary"
"Europe"."Iceland"
"Europe"."Ireland"
"Europe"."Italy"
"Europe"."Latvia"
"Europe"."Lithuania"
"Europe"."Luxembourg"
"Europe"."Malta"
"Europe"."Montenegro"
"Europe"."Netherlands"
"Europe"."Norway"
"Europe"."Poland"
"Europe"."Portugal"
"Europe"."Romania"
"Europe"."Russian Federation"
"Europe"."Serbia"
"Europe"."Slovakia"
"Europe"."Slovenia"
"Europe"."Spain"
"Europe"."Sweden"
"Europe"."Switzerland"
"Europe"."The former Yugoslav Republic of Macedonia"
"Europe"."Ukraine"
"Europe"."United Kingdom"
"Europe"."Yugoslav SFR"
"Europe".Andorra
"Europe".Greenland
"Europe".Liechtenstein
"Oceania"."Australia"
"Oceania"."Cook Islands"
"Oceania"."Fiji"
"Oceania"."French Polynesia"
"Oceania"."Guam"
"Oceania"."Kiribati"
"Oceania"."New Caledonia"
"Oceania"."New Zealand"
"Oceania"."Niue"
"Oceania"."Papua New Guinea"
"Oceania"."Samoa"
"Oceania"."Solomon Islands"
"Oceania"."Tonga"
"Oceania"."Vanuatu"
"Oceania"."Micronesia (Federated States of)"
"Oceania".Palau
"Oceania"."Wallis and Futuna Islands"
*the regfions are exhaustive - so no need to assign countries on word level - this then only would lead to doubly counting, as we use this set in the ERb Grassland module - thus drop here:
$ontext;
"World"."Afghanistan"
"World"."Albania"
"World"."Algeria"
"World"."Angola"
"World"."Antigua and Barbuda"
"World"."Argentina"
"World"."Armenia"
"World"."Australia"
"World"."Austria"
"World"."Azerbaijan"
"World"."Bahamas"
"World"."Bahrain"
"World"."Bangladesh"
"World"."Barbados"
"World"."Belarus"
"World"."Belgium"
"World"."Belize"
"World"."Benin"
"World"."Bhutan"
"World"."Bolivia (Plurinational State of)"
"World"."Bosnia and Herzegovina"
"World"."Botswana"
"World"."Brazil"
"World"."Brunei Darussalam"
"World"."Bulgaria"
"World"."Burkina Faso"
"World"."Burundi"
"World"."Cabo Verde"
"World"."Cambodia"
"World"."Cameroon"
"World"."Canada"
"World"."Cayman Islands"
"World"."Central African Republic"
"World"."Chad"
"World"."Chile"
"World"."China"
"World"."Colombia"
"World"."Comoros"
"World"."Congo"
"World"."Cook Islands"
"World"."Costa Rica"
"World"."Côte d'Ivoire"
"World"."Croatia"
"World"."Cuba"
"World"."Cyprus"
"World"."Czechia"
"World"."Democratic People's Republic of Korea"
"World"."Democratic Republic of the Congo"
"World"."Denmark"
"World"."Djibouti"
"World"."Dominica"
"World"."Dominican Republic"
"World"."Ecuador"
"World"."Egypt"
"World"."El Salvador"
"World"."Equatorial Guinea"
"World"."Eritrea"
"World"."Estonia"
"World"."Ethiopia"
"World"."Falkland Islands (Malvinas)"
"World"."Faroe Islands"
"World"."Fiji"
"World"."Finland"
"World"."France"
"World"."French Polynesia"
"World"."Gabon"
"World"."Gambia"
"World"."Georgia"
"World"."Germany"
"World"."Ghana"
"World"."Greece"
"World"."Grenada"
"World"."Guam"
"World"."Guatemala"
"World"."Guinea"
"World"."Guinea-Bissau"
"World"."Guyana"
"World"."Haiti"
"World"."Honduras"
"World"."Hungary"
"World"."Iceland"
"World"."India"
"World"."Indonesia"
"World"."Iran (Islamic Republic of)"
"World"."Iraq"
"World"."Ireland"
"World"."Israel"
"World"."Italy"
"World"."Jamaica"
"World"."Japan"
"World"."Jordan"
"World"."Kazakhstan"
"World"."Kenya"
"World"."Kiribati"
"World"."Kuwait"
"World"."Kyrgyzstan"
"World"."Lao People's Democratic Republic"
"World"."Latvia"
"World"."Lebanon"
"World"."Lesotho"
"World"."Liberia"
"World"."Libya"
"World"."Lithuania"
"World"."Luxembourg"
"World"."Madagascar"
"World"."Malawi"
"World"."Malaysia"
"World"."Mali"
"World"."Malta"
"World"."Mauritania"
"World"."Mauritius"
"World"."Mexico"
"World"."Mongolia"
"World"."Montenegro"
"World"."Morocco"
"World"."Mozambique"
"World"."Myanmar"
"World"."Namibia"
"World"."Nepal"
"World"."Netherlands"
"World"."Netherlands Antilles (former)"
"World"."New Caledonia"
"World"."New Zealand"
"World"."Nicaragua"
"World"."Niger"
"World"."Nigeria"
"World"."Niue"
"World"."Norway"
"World"."Occupied Palestinian Territory"
"World"."Oman"
"World"."Pakistan"
"World"."Panama"
"World"."Papua New Guinea"
"World"."Paraguay"
"World"."Peru"
"World"."Philippines"
"World"."Poland"
"World"."Portugal"
"World"."Qatar"
"World"."Republic of Korea"
"World"."Romania"
"World"."Russian Federation"
"World"."Rwanda"
"World"."Saint Kitts and Nevis"
"World"."Saint Lucia"
"World"."Saint Pierre and Miquelon"
"World"."Saint Vincent and the Grenadines"
"World"."Samoa"
"World"."Sao Tome and Principe"
"World"."Saudi Arabia"
"World"."Senegal"
"World"."Serbia"
"World"."Sierra Leone"
"World"."Singapore"
"World"."Slovakia"
"World"."Slovenia"
"World"."Solomon Islands"
"World"."Somalia"
"World"."South Africa"
"World"."Spain"
"World"."Sri Lanka"
"World"."Sudan"
"World"."Suriname"
"World"."Swaziland"
"World"."Sweden"
"World"."Switzerland"
"World"."Syrian Arab Republic"
"World"."Tajikistan"
"World"."Thailand"
"World"."The former Yugoslav Republic of Macedonia"
"World"."Timor-Leste"
"World"."Togo"
"World"."Tonga"
"World"."Trinidad and Tobago"
"World"."Tunisia"
"World"."Turkey"
"World"."Turkmenistan"
"World"."Uganda"
"World"."Ukraine"
"World"."United Arab Emirates"
"World"."United Kingdom"
"World"."United Republic of Tanzania"
"World"."United States of America"
"World"."Uruguay"
"World"."Uzbekistan"
"World"."Vanuatu"
"World"."Venezuela (Bolivarian Republic of)"
"World"."Viet Nam"
"World"."Yemen"
"World"."Yugoslav SFR"
"World"."Zambia"
"World"."Zimbabwe"
"World"."Andorra"
"World"."French Guiana"
"World"."Greenland"
"World"."Guadeloupe"
"World"."Liechtenstein"
"World"."Martinique"
"World"."Micronesia (Federated States of)"
"World"."Montserrat"
"World"."Palau"
"World"."Puerto Rico"
"World"."Turks and Caicos Islands"
"World"."United States Virgin Islands"
"World"."Wallis and Futuna Islands"
"World"."Western Sahara"
$offtext;
/;

