PUTCLOSE con,"_V6_ReadData_ErbEtAl_Grasslands";

$ontext;
GENERAL DESCRIPTION
This file reads the grassland data from Erb et al. 2007, A comprehensive global 5 min resolution land-use data set for the year 2000 consistent with national census data
Journal of Land Use Science, Vol. 2, No. 3, September 2007, 191–224

DETAILED TABLE OF CONTENTS
- 1) reading the csv-file and loading the parameters
- 2) Derive average and fresh matter yields
         2.1) Average yields
         2.2) Assign the ME and XP values that are reported on continents level to each country
         2.3) Fresh matter yields
         2.4) Derive ME and XP fresh matter contents
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
         3.3) Derive total production
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) reading the csv-file and loading the parameters

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewErbEtAlGrasslandData% == "YES"
$call GDXXRW ErbEtAl_GrasslandData_17_12_2012.xlsx  o=ErbEtAlGrasslandData_17_12_2012.gdx  index=index!a1:e6
*contains set definitions and parameters for the Grassland data from Erb
$endif;


Parameter ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountriesAndRegions,ErbEtAl_GrasslandNutrientElements);
*per ton dry matter nutrient contents: kg crude protein and MJ
Parameter ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,ErbEtAl_GrasslandYieldClasses);
Parameter ErbEtAl_GrasslandCYield(ErbEtAl_GrasslandDataCountryList,ErbEtAl_GrasslandYieldClasses);

$gdxin ErbEtAlGrasslandData_17_12_2012.gdx
$load ErbEtAl_Grassland_NutrientContent
$load ErbEtAl_GrasslandArea
$load ErbEtAl_GrasslandCYield
$gdxin


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Derive average and fresh matter yields

*2.1) Average yields
*Calculate grassland yields based on the areas and yields from Erb as this is the best data available.
*For this, use the best Erb grassclasses 1 and 2 only, as Erb grassclasses and FAO grassland data do not fit - Erb covers much more
*        thus we make the assumption that grassclasses 1 and 2 correspond to the areas reported as grass in the FAO
*check again and make assumptions more robust
*for these calculations, first convert Erb grassland areas in km2 to ha:
ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,ErbEtAl_GrasslandYieldClasses) = ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,ErbEtAl_GrasslandYieldClasses)*100;

*then calculate the yields as an average from the two best classes and convert to DryMatterYields:
*for this, take yields in tC/ha and convert to t DM/ha by division by the relative C contents
*(use the relative C-content from kühbauch: 0.401 (thus C to DM conversion is 1/0.401 = *2.494); other value: wirzkalender: 0.901)
*some more detail on the factors used can be found in the old suslive_data Grassland sheet - there are some calculations given
*             (cf. also the comments in yield_iocs.gms from the first SOLm version)
*if there is no Grassclass 1 or 2 area, then use 3 and 4:

*unit: t DM/ha
*and we need a new parameter for this:
Parameter ErbEtAl_GrasslandAverageYields(ErbEtAl_GrasslandDataCountryList,ErbEtAl_AverageYieldElement);

ErbEtAl_GrasslandAverageYields(ErbEtAl_GrasslandDataCountryList,"AverageDMYield (tDM/ha)")
         $((ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass3") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass4") > 0)
                                         AND (NOT (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2"))))
                         =(ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass3")*ErbEtAl_GrasslandCYield(ErbEtAl_GrasslandDataCountryList,"Grassclass3")
                                 +ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass4")*ErbEtAl_GrasslandCYield(ErbEtAl_GrasslandDataCountryList,"Grassclass4"))
                            /(ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass3") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass4"))
                                 *2.494;
*and when available: use 1 and 2:
ErbEtAl_GrasslandAverageYields(ErbEtAl_GrasslandDataCountryList,"AverageDMYield (tDM/ha)")
         $(ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2") > 0)
                         =(ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1")*ErbEtAl_GrasslandCYield(ErbEtAl_GrasslandDataCountryList,"Grassclass1")
                                 +ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2")*ErbEtAl_GrasslandCYield(ErbEtAl_GrasslandDataCountryList,"Grassclass2"))
                            /(ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2"))
                                 *2.494;

*this yield data refers to everything that grows there - also including residues, not as for wheat, for example, where residues is ADDITIONAL to yields, here it is part of yields.
*thus, correct already here by residue values: Swiss GHG inventory, table A-30 indicates a residue/yield ratio of 0.22 - thus, (0.22*YieldActual + YieldActual) = YieldTotal --> YieldActual = YieldTotal/1.22
*see also module __SOLmV5_ReadData_VariousSources_ResidueSharesAndNutrientContentsData, line 286
*Thus, derive this "ACTUAL" yield to calculate with - just as with crops, where we have this actual yield and residues are biomass produced IN ADDITION;
ErbEtAl_GrasslandAverageYields(ErbEtAl_GrasslandDataCountryList,"AverageDMYield (tDM/ha)")
         = ErbEtAl_GrasslandAverageYields(ErbEtAl_GrasslandDataCountryList,"AverageDMYield (tDM/ha)")
                 /1.22;

*2.2) Assign the ME and XP values that are reported on continents level to each country

ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"FeedME (MJ/tDM)")
         = sum(ErbEtAl_GrasslandDataRegions$ErbEtAl_GrasslandDataCountriesInRegions(ErbEtAl_GrasslandDataRegions,ErbEtAl_GrasslandDataCountryList),
                 ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataRegions,"FeedME (MJ/tDM)"));

ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"FeedXP (kg/tDM)")
         = sum(ErbEtAl_GrasslandDataRegions$ErbEtAl_GrasslandDataCountriesInRegions(ErbEtAl_GrasslandDataRegions,ErbEtAl_GrasslandDataCountryList),
                 ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataRegions,"FeedXP (kg/tDM)"));

*2.3) Fresh matter yields
*to derive fresh matter yields, we need  grassland DM contents:
ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageDMContents (tDM/t)") = 0.24;
*IPCC has 0.9 here; - but the real value is rather 0.2, is never used here, as grass is always in DM
*0.2 is the factor DM/FM, source: Kirchgessner, a gross average from p532
*take yields in tC/ha and convert to t DM/ha by division by the relative C contents (use the relative C-content from kühbauch: 0.401; other value: wirzkalender: 0.901)
*some more detail on the factors used can be found in the old suslive_data Grassland sheet - there are some calculations given
*             (cf. also the comments in yield_iocs.gms from the first SOLm version)
*how to resolve the inconsistency IPCC and value 0.2? - to be done later
*amended based on feedipedia: dactylos has 0.2, Brachiaria 0.27 - so take some medium value
*and feedipedia: ME content is 7000-9000MJ/tDM, GE is around 18000 ME/tDM, thus correct this where needed:

*derive fresh matter yields:
ErbEtAl_GrasslandAverageYields(ErbEtAl_GrasslandDataCountryList,"AverageFreshMatterYield (t/ha)")
                 $ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageDMContents (tDM/t)")
         = ErbEtAl_GrasslandAverageYields(ErbEtAl_GrasslandDataCountryList,"AverageDMYield (tDM/ha)")
                 /ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageDMContents (tDM/t)");

*2.4) Derive ME and XP fresh matter contents
*in the following, derive FeedME and FeedXP contents in grass fresh matter via the FeedME and FeedXP contents per ton of DM yield
*        as reported in the parameter ErbEtAl_Grassland_NutrientContent from above,
*units: MJ/t for ME and kg/t for XP

ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageFeedMEContents (MJ/t)")
         = ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"FeedME (MJ/tDM)")
                 *ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageDMContents (tDM/t)");

*division by 1000, as originally, the values are in XP kg/t
ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageFeedXPContents (t/t)")
         = ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"FeedXP (kg/tDM)")/1000
                 *ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageDMContents (tDM/t)");

*2.5 Assign N and GE contents:
*use the following to derive N from XP and GE from ME:
*gross average based on Table 3 in Waghorn 2007, What is dietary metabolisable energy? Proceedings of the New Zealand Grassland Association 69: 153–159
*to be improved; cf. also the following calculation used in the old SOLm, resulting in 0.5469 instead of 0.6
*Dry matter to gross energy MJ/ha: *18210
*Net Energy Lactation MJ/ha: *0.33  NEL=GE*0.33
*Metabolisable Energy MJ/ha: * 1.30 (other possibility: 1.64): NEL*1.64=ME
*conversion ME to GE, with these factors, is:
*GE = ME/0.5469 = ME/(1.64*0.33)
*Raw protein in kg/ha: *0.163*1000
*XXXXXXXXXXX is this correct? Kirchgessner p333 e.g. has rather a factor 23 between MJ NEL and g XP - thus: *0.023 MJ NEL = kg XP,
*XXXXXXXXXXX because of ME=1.3*NEL, this gives XP=0.023/1.3 ME (=0.01769), not times 163

*assume a general N contents of grassland plant protein at 16% in case N content is not already provided from other sources:
ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageNContents (tN/t)")
         = ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageFeedXPContents (t/t)")*0.16;

*assume a general conversion from ME to GE via division by 0.5469 in case GE content is not already provided from other sources:
*unit: MJ/ton
ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageFeedGEContents (MJ/t)")
                 $(NOT ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageFeedGEContents (MJ/t)"))
         = ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageFeedMEContents (MJ/t)")
                 /0.5469;


$ontext;
after this, we have:
Parameter ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountriesAndRegions,ErbEtAl_GrasslandNutrientElements);
Parameter ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,ErbEtAl_GrasslandYieldClasses);
Parameter ErbEtAl_GrasslandCYield(ErbEtAl_GrasslandDataCountryList,ErbEtAl_GrasslandYieldClasses);
Parameter ErbEtAl_GrasslandAverageYields(ErbEtAl_GrasslandDataCountryList,ErbEtAl_AverageYieldElement);
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed


*this is based on FAOSTAT_Countries - as Erb has country valures only, thus no regions here
Set MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Regions)
/
"Afghanistan"."Afghanistan"
"Albania"."Albania"
"Algeria"."Algeria"
"Andorra"."American Samoa"
"Angola"."Angola"
"Antigua and Barbuda"."Antigua and Barbuda"
"Argentina"."Argentina"
"Armenia"."Armenia"
*""."Aruba"
"Australia"."Australia"
"Austria"."Austria"
"Azerbaijan"."Azerbaijan"
"Bahamas"."Bahamas"
"Bahrain"."Bahrain"
"Bangladesh"."Bangladesh"
"Barbados"."Barbados"
"Belarus"."Belarus"
"Belgium"."Belgium"
*""."Belgium-Luxembourg"
"Belize"."Belize"
"Benin"."Benin"
*""."Bermuda"
"Bhutan"."Bhutan"
"Bolivia (Plurinational State of)"."Bolivia (Plurinational State of)"
"Bosnia and Herzegovina"."Bosnia and Herzegovina"
"Botswana"."Botswana"
"Brazil"."Brazil"
*""."British Virgin Islands"
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
*""."China, Hong Kong SAR"
*""."China, Macao SAR"
*""."China, mainland"
*""."China, Taiwan Province of"
"Colombia"."Colombia"
"Comoros"."Comoros"
"Congo"."Congo"
"Cook Islands"."Cook Islands"
"Costa Rica"."Costa Rica"
"Côte d'Ivoire"."Côte d'Ivoire"
"Croatia"."Croatia"
"Cuba"."Cuba"
"Cyprus"."Cyprus"
"Czechia"."Czechia"
*""."Czechoslovakia"
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
"Estonia"."Estonia"
"Ethiopia"."Ethiopia"
*""."Ethiopia PDR"
"Falkland Islands (Malvinas)"."Falkland Islands (Malvinas)"
"Faroe Islands"."Faroe Islands"
"Fiji"."Fiji"
"Finland"."Finland"
"France"."France"
*"French Guiana".""
"French Polynesia"."French Polynesia"
"Gabon"."Gabon"
"Gambia"."Gambia"
"Georgia"."Georgia"
"Germany"."Germany"
"Ghana"."Ghana"
"Greece"."Greece"
*"Greenland".""
"Grenada"."Grenada"
*"Guadeloupe".""
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
"Kenya"."Kenya"
"Kiribati"."Kiribati"
"Kuwait"."Kuwait"
"Kyrgyzstan"."Kyrgyzstan"
"Lao People's Democratic Republic"."Lao People's Democratic Republic"
"Latvia"."Latvia"
"Lebanon"."Lebanon"
"Lesotho"."Lesotho"
"Liberia"."Liberia"
"Libya"."Libya"
*"Liechtenstein".""
"Lithuania"."Lithuania"
"Luxembourg"."Luxembourg"
"Madagascar"."Madagascar"
"Malawi"."Malawi"
"Malaysia"."Malaysia"
*""."Maldives"
"Mali"."Mali"
"Malta"."Malta"
"Martinique"."Marshall Islands"
"Mauritania"."Mauritania"
"Mauritius"."Mauritius"
"Mexico"."Mexico"
*"Micronesia (Federated States of)".""
"Mongolia"."Mongolia"
"montenegro"."Montenegro"
*"Montserrat".""
"Morocco"."Morocco"
"Mozambique"."Mozambique"
"Myanmar"."Myanmar"
"Namibia"."Namibia"
*""."Nauru"
"Nepal"."Nepal"
"Netherlands"."Netherlands"
"Netherlands Antilles (former)"."Netherlands Antilles (former)"
"New Caledonia"."New Caledonia"
"New Zealand"."New Zealand"
"Nicaragua"."Nicaragua"
"Niger"."Niger"
"Nigeria"."Nigeria"
"Niue"."Niue"
*""."Norfolk Island"
"Norway"."Norway"
"Occupied Palestinian Territory"."Occupied Palestinian Territory"
"Oman"."Oman"
*""."Pacific Islands Trust Territory"
"Pakistan"."Pakistan"
*"Palau".""
"Panama"."Panama"
"Papua New Guinea"."Papua New Guinea"
"Paraguay"."Paraguay"
"Peru"."Peru"
"Philippines"."Philippines"
"Poland"."Poland"
"Portugal"."Portugal"
*"Puerto Rico".""
"Qatar"."Qatar"
"Republic of Korea"."Republic of Korea"
"Republic of Moldova"."Republic of Moldova"
*"Réunion".""
"Romania"."Romania"
"Russian Federation"."Russian Federation"
"Rwanda"."Rwanda"
*"Saint Helena".""
"Saint Kitts and Nevis"."Saint Kitts and Nevis"
"Saint Lucia"."Saint Lucia"
"Saint Pierre and Miquelon"."Saint Pierre and Miquelon"
"Saint Vincent and the Grenadines"."Saint Vincent and the Grenadines"
"Samoa"."Samoa"
*"San Marino".""
"Sao Tome and Principe"."Sao Tome and Principe"
"Saudi Arabia"."Saudi Arabia"
"Senegal"."Senegal"
"serbia"."Serbia"
*""."Serbia and Montenegro"
*""."Seychelles"
"Sierra Leone"."Sierra Leone"
"Singapore"."Singapore"
"Slovakia"."Slovakia"
"Slovenia"."Slovenia"
"Solomon Islands"."Solomon Islands"
"Somalia"."Somalia"
"South Africa"."South Africa"
*""."South Sudan"
"Spain"."Spain"
"Sri Lanka"."Sri Lanka"
"Sudan"."Sudan"
*""."Sudan (former)"
"Suriname"."Suriname"
"Swaziland"."Swaziland"
"Sweden"."Sweden"
"Switzerland"."Switzerland"
"Syrian Arab Republic"."Syrian Arab Republic"
"Tajikistan"."Tajikistan"
"Thailand"."Thailand"
"The former Yugoslav Republic of Macedonia"."The former Yugoslav Republic of Macedonia"
"Timor-Leste"."Timor-Leste"
"Togo"."Togo"
"Tonga"."Tonga"
"Trinidad and Tobago"."Trinidad and Tobago"
"Tunisia"."Tunisia"
"Turkey"."Turkey"
"Turkmenistan"."Turkmenistan"
*""."Tuvalu"
*"Turks and Caicos Islands".""
"Uganda"."Uganda"
"Ukraine"."Ukraine"
"United Arab Emirates"."United Arab Emirates"
"United Kingdom"."United Kingdom"
"United Republic of Tanzania"."United Republic of Tanzania"
"United States of America"."United States of America"
*"United States Virgin Islands".""
"Uruguay"."Uruguay"
*""."USSR"
"Uzbekistan"."Uzbekistan"
"Vanuatu"."Vanuatu"
"Venezuela (Bolivarian Republic of)"."Venezuela (Bolivarian Republic of)"
"Viet Nam"."Viet Nam"
*"Wallis and Futuna Islands".""
*"Western Sahara".""
"Yemen"."Yemen"
"Yugoslav SFR"."Yugoslav SFR"
"Zambia"."Zambia"
"Zimbabwe"."Zimbabwe"
/;


*3.2) Link to the core model parameters
ActCropsGrass_Outputs(Regions,"Grass","MainOutput1 (t DM)","AllProdSyst","AllProdCond")
         = sum(ErbEtAl_GrasslandDataCountryList$MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Regions),
                 ErbEtAl_GrasslandAverageYields(ErbEtAl_GrasslandDataCountryList,"AverageDMYield (tDM/ha)"));

ActCropsGrass_Outputs(Regions,"Grass","MainOutput1 (t)","AllProdSyst","AllProdCond")
         = sum(ErbEtAl_GrasslandDataCountryList$MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Regions),
                 ErbEtAl_GrasslandAverageYields(ErbEtAl_GrasslandDataCountryList,"AverageFreshMatterYield (t/ha)"));


Commod_Contents(Regions,"Grass","FeedME in DM (MJ)","AllProdSyst","AllProdCond")
         = sum(ErbEtAl_GrasslandDataCountryList$MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Regions),
                 ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"FeedME (MJ/tDM)"));

Commod_Contents(Regions,"Grass","FeedXP in DM (t)","AllProdSyst","AllProdCond")
         = sum(ErbEtAl_GrasslandDataCountryList$MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Regions),
                 ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"FeedXP (kg/tDM)"))/1000;

Commod_Contents(Regions,"Grass","DM (t)","AllProdSyst","AllProdCond")
         = sum(ErbEtAl_GrasslandDataCountryList$MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Regions),
                 ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageDMContents (tDM/t)"));

Commod_Contents(Regions,"Grass","FeedME (MJ)","AllProdSyst","AllProdCond")
         = sum(ErbEtAl_GrasslandDataCountryList$MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Regions),
                 ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageFeedMEContents (MJ/t)"));

Commod_Contents(Regions,"Grass","FeedXP (t)","AllProdSyst","AllProdCond")
         = sum(ErbEtAl_GrasslandDataCountryList$MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Regions),
                 ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageFeedXPContents (t/t)"));

Commod_Contents(Regions,"Grass","N (t)","AllProdSyst","AllProdCond")
         = sum(ErbEtAl_GrasslandDataCountryList$MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Regions),
                 ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageNContents (tN/t)"));

Commod_Contents(Regions,"Grass","FeedGE (MJ)","AllProdSyst","AllProdCond")
         = sum(ErbEtAl_GrasslandDataCountryList$MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Regions),
                 ErbEtAl_Grassland_NutrientContent(ErbEtAl_GrasslandDataCountryList,"AverageFeedGEContents (MJ/t)"));

*and for completeness, assign P2O5 contents here as well:
*P is given as 0.0072 t P2O5 per t DM, based on the Swiss data from Agrarforschung 16(2), 2009, p age 89 ff, Table 60a, this is about 0.00315 t P per t DM
*but we choose some value from feedipedia, bracharia, about 2.4 gP/kg, DM contents 0.2 gives 0.0011 tP2O5/t fresh matter
*this is also what the table in the appendix of P balance Austria provides for part of the pastures:
*0.27 P - assumingly in DM - then =.27*0.2*2.2915 = 0.1237, i.e. to use: 0.001237
*but more intensive pastures have 0.41 P, i.e. 0.001879
*checked again with some NZ data: https://www.grassland.org.nz/publications/nzgrassland_publication_864.pdf
*this also results in values around 0.0013-0.0014 P2O5/t FM (assuming 20% DM contents)
*feedipedia cocksfoot (Dactylis glomerata) is similar as well: https://www.feedipedia.org/node/466
*DM contents 0.2, P contents 0.0028, i.e. 0.0028*0.2*2.2915 = 0.00128 tP2O5/t FM
*we thus choose some middle value in this area:
Commod_Contents(Countries,"Grass","P2O5 (t)","AllProdSyst","AllProdCond")
         = 0.0013;


*3.3) Derive total production
*this is derived to have grassland data in the baseline to similar extent as the production: areas/number of animals, production and yields; total nutrient supply, etc. is then derived later
*it is derived from the areas from FAOSTAT land use and the yields assigned above
*it is derived AFTER assigning to SOLmV5-entities, as otherwise some sets do not match and would make the code more complex.

VActCropsGrass_Outputs.l(Regions,"Permanent meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond")
         = VActCropsGrass_QuantityActUnits.l(Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond")
                 *ActCropsGrass_Outputs(Regions,"Grass","MainOutput1 (t)","AllProdSyst","AllProdCond");

VActCropsGrass_Outputs.l(Regions,"Temporary meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond")
         = VActCropsGrass_QuantityActUnits.l(Regions,"Temporary meadows and pastures","AllProdSyst","AllProdCond")
                 *ActCropsGrass_Outputs(Regions,"Grass","MainOutput1 (t)","AllProdSyst","AllProdCond");

*assign DAQ, etc.
VCommod_Quantity.l(Regions,"Temporary meadows and pastures","AllProdSyst","AllProdCond")
         = VActCropsGrass_Outputs.l(Regions,"Temporary meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond");
VCommod_Quantity.l(Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond")
         = VActCropsGrass_Outputs.l(Regions,"Permanent meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond");

*NO DATA AVAILABLE - but also not much trade: VImportQuantity
*NO DATA AVAILABLE - but also not much trade: VExportQuantity
*NO DATA AVAILABLE VCommod_StockChanges

VCommod_Production.l(Regions,"Temporary meadows and pastures","AllProdSyst","AllProdCond")
         = VCommod_Quantity.l(Regions,"Temporary meadows and pastures","AllProdSyst","AllProdCond");
VCommod_Feed.l(Regions,"Temporary meadows and pastures","AllProdSyst","AllProdCond")
         = VCommod_Quantity.l(Regions,"Temporary meadows and pastures","AllProdSyst","AllProdCond");
VCommod_Production.l(Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond")
         = VCommod_Quantity.l(Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond");
VCommod_Feed.l(Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond")
         = VCommod_Quantity.l(Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond");

*not needed - derived from per ha values VCommod_Seed
*equals zero VCommod_Food
*NO DATA AVAILABLE VCommod_Waste
*NO DATA AVAILABLE VCommod_Processing
*NO DATA AVAILABLE VCommod_Other


*and assign yields to the permanent/temporary pastures
ActCropsGrass_Outputs(Regions,"Temporary meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Outputs(Regions,"Grass","MainOutput1 (t)","AllProdSyst","AllProdCond");
ActCropsGrass_Outputs(Regions,"Temporary meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Outputs(Regions,"Grass","MainOutput1 (t DM)","AllProdSyst","AllProdCond");
ActCropsGrass_Outputs(Regions,"Permanent meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Outputs(Regions,"Grass","MainOutput1 (t)","AllProdSyst","AllProdCond");
ActCropsGrass_Outputs(Regions,"Permanent meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Outputs(Regions,"Grass","MainOutput1 (t DM)","AllProdSyst","AllProdCond");

*and also assign the per ton parameters to the temp/perm grass and drop grass:
Commod_Contents(Regions,"Temporary meadows and pastures",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Regions,"Temporary meadows and pastures",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Regions,"Grass",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Regions,"Permanent meadows and pastures",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Regions,"Permanent meadows and pastures",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Regions,"Grass",Contents,"AllProdSyst","AllProdCond");

*and drop the aggregate grass value:
Commod_Contents(Regions,"Grass",Contents,"AllProdSyst","AllProdCond") = 0;
Commod_Contents(Regions,"Grass",Contents,"AllProdSyst","AllProdCond") = 0;

ActCropsGrass_Outputs(Regions,"Grass","MainOutput1 (t)","AllProdSyst","AllProdCond") = 0;
ActCropsGrass_Outputs(Regions,"Grass","MainOutput1 (t DM)","AllProdSyst","AllProdCond") = 0;


*a number of FAO countries has no grassland values but reports ruminants with grass in feeding rations - this causes problems in the calculations.
*hence add grassland areas and charateristics for those countries - VERY GROSSLY! - to be refined later.
*most of them are unimportant - small island states - but one is important, namely Egypt.
$ontext;
countries without grassland data:
American Samoa
Antigua and Barbuda
Bahamas
Bahrain
Barbados
Bermuda
British Virgin Islands
Cabo Verde
Cayman Islands
Comoros
Cook Islands
Dominica
Egypt
Falkland Islands (Malvinas)
Faroe Islands
Fiji
French Polynesia
Grenada
Guam
Kiribati
Maldives
Malta
Marshall Islands
Mauritius
Nauru
Netherlands Antilles (former)
New Caledonia
Niue
Occupied Palestinian Territory
Saint Kitts and Nevis
Saint Lucia
Saint Pierre and Miquelon
Saint Vincent and the Grenadines
Samoa        Sao Tome and Principe
Seychelles
Singapore
Solomon Islands
South Sudan
Tonga
Tuvalu
Vanuatu
$offtext;

*for now, do some general assumptions (e.g. a size of the magnitude of 5% crop area) or use values from Mali for this:

VActCropsGrass_QuantityActUnits.l(Countries,TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond")
                 $(NOT VActCropsGrass_QuantityActUnits.l(Countries,TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond"))
         =0.05*sum(Crops,VActCropsGrass_QuantityActUnits.l(Countries,Crops,"AllProdSyst","AllProdCond"));
*for Egypt, the one important country without grassland area data, this results in way too small values - aiming at a supply/demand ratio of about 2, we have to multiply by 2000, thus:
*NO - this then results in way too high grassland areas (600 mio hectares - larger than the country area) - thus do not do this! - Rather have way too low feed S/R ratios than unrealistically high areas! 
*VActCropsGrass_QuantityActUnits.l("Egypt",TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond")
*         =100*sum(Crops,VActCropsGrass_QuantityActUnits.l("Egypt",Crops,"AllProdSyst","AllProdCond"));


ActCropsGrass_Outputs(Countries,TempAndPermMeadAndPastures,"MainOutput1 (t DM)","AllProdSyst","AllProdCond")
                 $(NOT ActCropsGrass_Outputs(Countries,TempAndPermMeadAndPastures,"MainOutput1 (t DM)","AllProdSyst","AllProdCond"))
         = ActCropsGrass_Outputs("Mali",TempAndPermMeadAndPastures,"MainOutput1 (t DM)","AllProdSyst","AllProdCond");
ActCropsGrass_Outputs(Countries,TempAndPermMeadAndPastures,"MainOutput1 (t)","AllProdSyst","AllProdCond")
                 $(NOT ActCropsGrass_Outputs(Countries,TempAndPermMeadAndPastures,"MainOutput1 (t)","AllProdSyst","AllProdCond"))
         = ActCropsGrass_Outputs("Mali",TempAndPermMeadAndPastures,"MainOutput1 (t)","AllProdSyst","AllProdCond");

Commod_Contents(Countries,GrassCommodities,Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,GrassCommodities,Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents("Mali",GrassCommodities,Contents,"AllProdSyst","AllProdCond");

VActCropsGrass_Outputs.l(Countries,TempAndPermMeadAndPastures,"MainOutput1 (t)","AllProdSyst","AllProdCond")
                 $(NOT VActCropsGrass_Outputs.l(Countries,TempAndPermMeadAndPastures,"MainOutput1 (t)","AllProdSyst","AllProdCond"))
         = VActCropsGrass_QuantityActUnits.l(Countries,TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond")
                 *ActCropsGrass_Outputs(Countries,TempAndPermMeadAndPastures,"MainOutput1 (t)","AllProdSyst","AllProdCond");

VCommod_Quantity.l(Countries,"Temporary meadows and pastures","AllProdSyst","AllProdCond")
                 $(NOT VCommod_Quantity.l(Countries,"Temporary meadows and pastures","AllProdSyst","AllProdCond"))
         = VActCropsGrass_Outputs.l(Countries,"Temporary meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond");
VCommod_Quantity.l(Countries,"Permanent meadows and pastures","AllProdSyst","AllProdCond")
                 $(NOT VCommod_Quantity.l(Countries,"Permanent meadows and pastures","AllProdSyst","AllProdCond"))
         = VActCropsGrass_Outputs.l(Countries,"Permanent meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond");

VCommod_Production.l(Countries,GrassCommodities,"AllProdSyst","AllProdCond")
                 $(NOT VCommod_Production.l(Countries,GrassCommodities,"AllProdSyst","AllProdCond"))
         = VCommod_Quantity.l(Countries,GrassCommodities,"AllProdSyst","AllProdCond");

VCommod_Feed.l(Countries,GrassCommodities,"AllProdSyst","AllProdCond")
                 $(NOT VCommod_Feed.l(Countries,GrassCommodities,"AllProdSyst","AllProdCond"))
         = VCommod_Quantity.l(Countries,GrassCommodities,"AllProdSyst","AllProdCond");



$ontext;
After this we have the following in SOLm-entities:
VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")

ActCropsGrass_Outputs(Regions,Activities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond")
ActCropsGrass_Outputs(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")

Commod_Contents(Regions,Activities,"FeedME in DM (MJ)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"FeedXP in DM (t)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"DM (t)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"FeedME (MJ)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"FeedXP (t)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"N (t)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"FeedGE (MJ)","AllProdSyst","AllProdCond")
Commod_Contents(Countries,Activities,"P2O5 (t)","AllProdSyst","AllProdCond")

VActCropsGrass_Outputs.l(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
VCommod_Quantity.l(Regions,Activities,"AllProdSyst","AllProdCond")
VCommod_Production.l(Regions,Activities,"AllProdSyst","AllProdCond")
VCommod_Feed.l(Regions,Activities,"AllProdSyst","AllProdCond")

Regions      is      ErbEtAl_GrasslandDataCountryList
                                         which is a subset of FAOSTAT_Countries
Activities   is      "Permanent meadows and pastures" and "Temporary meadows and pastures"

*XXX STILL TO BE DONE:

Assign values to elements in FAOSTAT_Countries NOT COVERED in the original set!! -
         but these are small countries only, so not that important.

And check the nutrient contents again (DM, GE, ME, XP, N, P), e.g. compare with the following and whether the values below and above are consistent

(CHECK: is the following still needed?)  - add N,P,DM contents data for other grass tpyes than "Grass" in NON_FAOSTAT_CropPRoductionItems

*grass
* 0.015 is N/DM!!
*I assumed this very roughly based on http://digital.library.okstate.edu/oas/oas_pdf/v14/p36_44.pdf
*averaged over the various grassland types
*feedipedia also has grass values around 0.013 etc.
*thus, we choose for a first average 0.013 N/DM; thus assuming our 0.2 DM contents, this gives 0.0026

ParameterPerTon(FAO_Countries_NEW,SET_ActGroup_Grass,"Crop","MainOutput N cont (tN/t)","All","All","Baseline")
         = 0.0026;
*  = 0.01425;
* = 0.015;
$offtext;
