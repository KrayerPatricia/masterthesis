PUTCLOSE con,"_V6_ReadData_VariousSources_AnimalWelfareData";

$ontext;
GENERAL DESCRIPTION
This file reads animal welfare data compiled by C.Pfeifer, April/MAy 2020
For a description, see the SOLm documentation and the ReadMe-sheet in the excel file

DETAILED TABLE OF CONTENTS
- 1) Animal welfare data

$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) animal welfare data

$ontext;
contains the following data:

For further explanations, see SOLm-documentation, or, respectively, AnimalWelfareForSOLm_Lit_5_4_2020.docx and datacompilation_AnimalWelfareForUNISECO.html

ProdInt   Production intensity: number of animals divided by the agricultural area: to be derived anew from SOLm data (to account for different animal types)
          however - this is then not used in this form but differently, cf. below.
mr        an index for antibiotics use and extension, etc.
hwd1      an index for heat stress - projection around 2020
hwd2      an index for heat stress - projection around 2030
TrAnD     Trade in living animals - based on import numbers to the countries; country level data, equally distributed to the NUTS2-regions; aggregated over all animals, also use rather the animal specific data filed in from the second file below
$offtext;

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewVariousSourcesAnimalWelfareData% == "YES"
$call GDXXRW awr.xlsx  o=awr.gdx  index=index!a1
$call GDXXRW CometradeCommoditybyCountry.xlsx  o=TradeLivingAnimals.gdx  index=index!a1
$endif;

Set RegionCodes_awr;
Set awr_components_names;

Parameter awr_components(RegionCodes_awr,awr_components_names);

Parameter TradeInLivingAnimals(Activities,Regions);
Parameter TradeInLivingAnimals_Normalized(Activities,Regions);

$gdxin awr.gdx
$load RegionCodes_awr
$load awr_components_names
$load awr_components
$gdxin

$gdxin TradeLivingAnimals.gdx
$load TradeInLivingAnimals
$load TradeInLivingAnimals_Normalized
$gdxin

*now explain how to build animal welfare parameters that are then displayed in SOLm:
$ontext;
- ProdInt: production intensity, derived as number of animals / agricultural area: can directly be derived at the end of the scenario runs; but needs some amendment:
         - ruminants: put all ruminant numbers (in LSU) in relation to total grassland areas: this gives a rough indicator of the intensity of the systems used
                 or use the grass share in feeding rations? this would capture it better, maybe. - OR also milk yields?
DECISION: use share of non-grass in feeding rations: the higher, the lower is animal welfare
         - monogastrics: maybe yields? Works for eggs - but meat is rather captured via the duration to reach it than the yield.
                 thus, may capture via relation of animal numbers to cropland areas - as an indication of domestic or foreign feed
                 or may use the ratio of producing over living animals (for meat production) - this is a gross indication of the duration to gain the end weight: the shorter, the more intensive, i.e. the bigger is the ratio (more producing per living)
- mr: an index of antibiotic use on all animals - thus multiply with animal number to get a gross total antibiotic use index - assuming that the same regional use prevails.
         also correct for animal intensity, assuming that less intensive systems use less antibiotics; then it is a mixture of reported institutional settings and intensity
- climate: hwd1 and hwd2: an index for heat stress: multiply with animal numbers to get an index: the more animals experience heat the worse - no further correction needed
- transport: numbers of living animals imported: depends very much on market structure, etc. - thus may not include as heavy assumptions would be needed and would totally drive results?
         may relate to total number of living animals? - Thus indicating which share of the total depends on transported animals

All these indicators are not individual per animal head, but more systemic in the sense that high values indicate that the whole regional production structure bears a larger risk of animal welfare problems.

Best indicators:
- climate (most objective)
- intensity (depends on feeding rations for ruminants; difficult for monogastrics; but may also relate to domestic feed production)
- mr (depends partly on intensity and traditional produciton patterns) - does it capture something additional? Furthermore, difficult to adapt in scenarios (lots of implicit assumptions needed)
- transport: most shaky

*Easiest use as indicators: multiply each with the relevant animal heads and then assess relative differences - thus giving it an inpterpretation of adverse animal welfare impacts.
*thus retain four indicators for this.

Thus, we use the following set elements in Set AnimalOTherChar

"Animal welfare: antibiotics use index"
"Animal welfare: heat stress index 2020"
"Animal welfare: heat stress index 2030"
"Animal welfare: heat stress index 2050"
"Animal welfare: transport volume index"
"Animal welfare: production intensity index - ruminants"
"Animal welfare: production intensity index - monogastric meat"
"Animal welfare: production intensity index - eggs"

$offtext;

*add additional elements with NUTS2-region names to the set regions:

*only part of this is already needed here, the rest for filing in UNISECO data - but do all of it already here.
$onmulti;
*this adds the NUTS2-level region names
*the country names in comments are those used in BioBam on country level outside the EU
Set Regions
/
*Afghanistan
*Albania
*Algeria
*Angola
*Argentina
*Armenia
"AT11 Burgenland"
"AT12 Niederoesterreich"
"AT13 Wien"
"AT21 Kaernten"
"AT22 Steiermark"
"AT31 Oberoesterreich"
"AT32 Salzburg"
"AT33 Tirol"
"AT34 Vorarlberg"
*Australia
*Azerbaijan
*Bangladesh
"BE10 Brüssel"
"BE21 Prov. Antwerpen"
"BE22 Prov. Limburg (BE)"
"BE23 Prov. Oost-Vlaanderen"
"BE24 Prov. Vlaams-Brabant"
"BE25 Prov. West-Vlaanderen"
"BE31 Prov. Brabant Wallon"
"BE32 Prov. Hainaut"
"BE33 Prov. Liège"
"BE34 Prov. Luxembourg (BE)"
"BE35 Prov. Namur"
*Belarus
*Benin
"BG31 Severozapaden"
"BG32 Severen tsentralen"
"BG33 Severoiztochen"
"BG34 Yugoiztochen"
"BG41 Yugozapaden"
"BG42 Yuzhen tsentralen"
*Bolivia (Plurinational State of)
*Bosnia and Herzegovina
*Botswana
*Brazil
*Burkina Faso
*Cambodia
*Cameroon
*Canada
*Central African Republic
"CH01 Genferseeregion"
"CH02 Espace Mittelland"
"CH03 Nordwestschweiz"
"CH04 Zuerich"
"CH05 Ostschweiz"
"CH06 Zentralschweiz"
"CH07 Tessin"
*Chad
*Chile
*we summarize the following three in the original data to "China"
***China Hong Kong SAR
***China mainland
***China Taiwan Province of
*Colombia
*Costa Rica
*we replace the following with the SOLm and FAOSTAT name Côte d'Ivoire
***Cote d'Ivoire
*Cuba
"CZ01 Praha"
"CZ02 Stredni Cechy"
"CZ03 Jihozápad"
"CZ04 Severozápad"
"CZ05 Severovýchod"
"CZ06 Jihovýchod"
"CZ07 Strední Morava"
"CZ08 Moravskoslezsko"
"DE11 Stuttgart"
"DE12 Karlsruhe"
"DE13 Freiburg"
"DE14 Tuebingen"
"DE21 Oberbayern"
"DE22 Niederbayern"
"DE23 Oberpfalz"
"DE24 Oberfranken"
"DE25 Mittelfranken"
"DE26 Unterfranken"
"DE27 Schwaben"
"DE30 Berlin"
"DE40 Brandenburg"
"DE50 Bremen"
"DE60 Hamburg"
"DE71 Darmstadt"
"DE72 Giessen"
"DE73 Kassel"
"DE80 Mecklenburg-Vorpommern"
"DE91 Braunschweig"
"DE92 Hannover"
"DE93 Lueneburg"
"DE94 Weser-Ems"
"DEA1 Duesseldorf"
"DEA2 Koeln"
"DEA3 Muenster"
"DEA4 Detmold"
"DEA5 Arnsberg"
"DEB1 Koblenz"
"DEB2 Trier"
"DEB3 Rheinhessen-Pfalz"
"DEC0 Saarland"
"DED SACHSEN"
"DEE SACHSEN-ANHALT"
"DEF0 Schleswig-Holstein"
"DEG0 Thueringen"
*Democratic People's Republic of Korea
"DK Danmark"
*Dominican Republic
*Ecuador
"EE Estland"
*Egypt
*El Salvador
"EL11 Anatoliki makedonia Thraki"
"EL12 Kentriki makedonia"
"EL13 Dytiki makedonia"
"EL14 Thessalia"
"EL21 Ipeiros"
"EL22 Ionia nisia"
"EL23 Dytiki ellada"
"EL24 Sterea ellada"
"EL25 Peloponnisos"
"EL30 Attiki"
"EL41 Voreio aigaio"
"EL42 Notio aigaio"
"EL43 Kriti"
"ES11 Galicia"
"ES12 Principado de Asturias"
"ES13 Cantabria"
"ES21 País Vasco"
"ES22 Comunidad Foral de Navarra"
"ES23 La Rioja"
"ES24 Aragón"
"ES30 Comunidad de Madrid"
"ES41 Castilla y León"
"ES42 Castilla-La Mancha"
"ES43 Extremadura"
"ES51 Cataluña"
"ES52 Comunidad Valenciana"
"ES53 Illes Balears"
"ES61 Andalucía"
"ES62 Región de Murcia"
*Ethiopia
"FI13 Itä-Suomi"
"FI18 Etelä-Suomi"
"FI19 Laensi-Suomi"
"FI1A Pohjois-Suomi"
"FI20 Åland"
"FR10 Île de France"
"FR21 Champagne-Ardenne"
"FR22 Picardie"
"FR23 Haute-Normandie"
"FR24 Centre"
"FR25 Basse-Normandie"
"FR26 Bourgogne"
"FR30 Nord - Pas-de-Calais"
"FR41 Lorraine"
"FR42 Alsace"
"FR43 Franche-Comté"
"FR51 Pays de la Loire"
"FR52 Bretagne"
"FR53 Poitou-Charentes"
"FR61 Aquitaine"
"FR62 Midi-Pyrénées"
"FR63 Limousin"
"FR71 Rhône-Alpes"
"FR72 Auvergne"
"FR81 Languedoc-Roussillon"
"FR82 Provence-Alpes-Côte d'Azur"
"FR83 Corse"
*Gabon
*Gambia
*Georgia
*Ghana
*Guatemala
*Guinea
*Guyana
*Haiti
*Honduras
"HR Croatia"
"HU10 Koezép-Magyarország"
"HU21 Koezép-Dunántúl"
"HU22 Nyugat-Dunántúl"
"HU23 Dél-Dunántúl"
"HU31 Észak-Magyarország"
"HU32 Észak-Alfoeld"
"HU33 Dél-Alfoeld"
"IE01 Border Midland and Western"
"IE02 Southern and Eastern"
*India
*Indonesia
*Iran (Islamic Republic of)
*Iraq
*Israel
"ITC1 Piemonte"
"ITC2 Valle d'Aosta/Vallée d'Aoste"
"ITC3 Liguria"
"ITC4 Lombardia"
"ITF1 Abruzzo"
"ITF2 Molise"
"ITF3 Campania"
"ITF4 Puglia"
"ITF5 Basilicata"
"ITF6 Calabria"
"ITG1 Sicilia"
"ITG2 Sardegna"
"ITH1 Bozen and Trento"
"ITH3 Veneto"
"ITH4 Friuli-Venezia Giulia"
"ITH5 Emilia-Romagna"
"ITI1 Toscana"
"ITI2 Umbria"
"ITI3 Marche"
"ITI4 Lazio"
*Jamaica
*Japan
*Jordan
*Kazakhstan
*Kenya
*Kyrgyzstan
*Lao People's Democratic Republic
*Lebanon
*Lesotho
*Liberia
"LT Lithuania"
"LU Luxembourg"
"LV Latvia"
*Madagascar
*Malawi
*Malaysia
*Mali
*Mauritania
*Mauritius
*Mexico
*Mongolia
*Morocco
*Mozambique
*Myanmar
*Namibia
*Nepal
*New Zealand
*Nicaragua
*Niger
*Nigeria
"NL11 Groningen"
"NL12 Friesland (NL)"
"NL13 Drenthe"
"NL21 Overijssel"
"NL22 Gelderland"
"NL23 Flevoland"
"NL31 Utrecht"
"NL32 Noord-Holland"
"NL33 Zuid-Holland"
"NL34 Zeeland"
"NL41 Noord-Brabant"
"NL42 Limburg (NL)"
*Norway
*Pakistan
*Panama
*Paraguay
*Peru
*Philippines
"PL11 Lodzkie"
"PL12 Mazowieckie"
"PL21 Malopolskie"
"PL22 Slaskie"
"PL31 Lubelskie"
"PL32 Podkarpackie"
"PL33 Swietokrzyskie"
"PL34 Podlaskie"
"PL41 Wielkopolskie"
"PL42 Zachodniopomorskie"
"PL43 Lubuskie"
"PL51 Dolnoslaskie"
"PL52 Opolskie"
"PL61 Kujawsko-pomorskie"
"PL62 Warminsko-mazurskie"
"PL63 Pomorskie"
"PT11 Norte"
"PT15 Algarve"
"PT16 Centro (PT)"
"PT17 Área Metropolitana de Lisboa"
"PT18 Alentejo"
*Republic of Korea
*Republic of Moldova
*replace the following in the original data with Democratic Republic of the Congo
***Republic of the Congo
"Rest of EAP"
"Rest of ECA"
"Rest of EU"
"Rest of HIC"
"Rest of LAC"
"Rest of MNA"
"Rest of SAS"
"Rest of SSA"
"RO11 Nord-Vest"
"RO12 Centru"
"RO21 Nord-Est"
"RO22 Sud-Est"
"RO31 Sud - Muntenia"
"RO32 Bucuresti - Ilfov"
"RO41 Sud-Vest Oltenia"
"RO42 Vest"
*Russian Federation
*Rwanda
*Saudi Arabia
"SE11 Stockholm"
"SE12 Oestra Mellansverige"
"SE21 Småland med oearna"
"SE22 Sydsverige"
"SE23 Vaestsverige"
"SE31 Norra Mellansverige"
"SE32 Mellersta Norrland"
"SE33 Oevre Norrland"
*Senegal
*Serbia
"SI Slovenia"
*Sierra Leone
"SK01 Bratislavský kraj"
"SK02 Západné Slovensko"
"SK03 Stredné Slovensko"
"SK04 Východné Slovensko"
*South Africa
*Sri Lanka
*Suriname
*Swaziland
*Tajikistan
*Thailand
*Togo
*Trinidad and Tobago
*Tunisia
*Turkey
*Turkmenistan
*Uganda
"UKC NORTH EAST (ENGLAND)"
"UKD NORTH WEST (ENGLAND)"
"UKE YORKSHIRE AND THE HUMBER"
"UKF EAST MIDLANDS (ENGLAND)"
"UKG WEST MIDLANDS (ENGLAND)"
"UKH EAST OF ENGLAND"
"UKI London"
"UKJ SOUTH EAST (ENGLAND)"
"UKK SOUTH WEST (ENGLAND)"
"UKL WALES"
"UKM SCOTLAND"
"UKN NORTHERN IRELAND"
*Ukraine
*United Republic of Tanzania
*United States of America
*Uruguay
*Uzbekistan
*Venezuela (Bolivarian Republic of)
*Viet Nam
*Yemen
*Zambia
*Zimbabwe

*and aggregate a label for the non-EU rest of the world:
"Non-EU Rest of the World"

*and to file in the scenario grassland areas, we need the shorter NUTS2 names:
AT11
AT12
AT13
AT21
AT22
AT31
AT32
AT33
AT34

BE10
BE21
BE22
BE23
BE24
BE25
BE31
BE32
BE33
BE34
BE35

BG31
BG32
BG33
BG34
BG41
BG42

CH01
CH02
CH03
CH04
CH05
CH06
CH07

CZ01
CZ02
CZ03
CZ04
CZ05
CZ06
CZ07
CZ08
DE11
DE12
DE13
DE14
DE21
DE22
DE23
DE24
DE25
DE26
DE27
DE30
DE40
DE50
DE60
DE71
DE72
DE73
DE80
DE91
DE92
DE93
DE94
DEA1
DEA2
DEA3
DEA4
DEA5
DEB1
DEB2
DEB3
DEC0
DED0
DEE0
DEF0
DEG0

DK00

EE00

EL11
EL12
EL13
EL14
EL21
EL22
EL23
EL24
EL25
EL30
EL41
EL42
EL43
ES11
ES12
ES13
ES21
ES22
ES23
ES24
ES30
ES41
ES42
ES43
ES51
ES52
ES53
ES61
ES62

FI13
FI18
FI19
FI1A
FI20
FR10
FR21
FR22
FR23
FR24
FR25
FR26
FR30
FR41
FR42
FR43
FR51
FR52
FR53
FR61
FR62
FR63
FR71
FR72
FR81
FR82
FR83

HR00
HU10
HU21
HU22
HU23
HU31
HU32
HU33
IE01
IE02

ITC1
ITC2
ITC3
ITC4
ITF1
ITF2
ITF3
ITF4
ITF5
ITF6
ITG1
ITG2
ITH1
ITH3
ITH4
ITH5
ITI1
ITI2
ITI3
ITI4

LT00
LU00
LV00

NL11
NL12
NL13
NL21
NL22
NL23
NL31
NL32
NL33
NL34
NL41
NL42

PL11
PL12
PL21
PL22
PL31
PL32
PL33
PL34
PL41
PL42
PL43
PL51
PL52
PL61
PL62
PL63
PT11
PT15
PT16
PT17
PT18

RO11
RO12
RO21
RO22
RO31
RO32
RO41
RO42

SE11
SE12
SE21
SE22
SE23
SE31
SE32
SE33

SI00

SK01
SK02
SK03
SK04

UKC0
UKD0
UKE0
UKF0
UKG0
UKH0
UKI0
UKJ0
UKK0
UKL0
UKM0
UKN0

*additional regions to be added for the animal welfare data:
CY00

DED2
DED4
DED5

DK01
DK02
DK03
DK04
DK05

ES63
ES64

FI1B
FI1C
FI1D

HR04
HR03

IS00

ITH2

LI00

ME00

MK00

MT00

NO01
NO02
NO03
NO04
NO05
NO06
NO07

SI01
SI02

TR10
TR21
TR22
TR31
TR32
TR33
TR41
TR42
TR51
TR52
TR61
TR62
TR63
TR71
TR72
TR81
TR82
TR83
TR90
TRA1
TRA2
TRB1
TRB2
TRC1
TRC2
TRC3

UKC1
UKC2
UKD1
UKD3
UKD4
UKD6
UKD7
UKE1
UKE2
UKE3
UKE4
UKF1
UKF2
UKF3
UKG1
UKG2
UKG3
UKH1
UKH2
UKH3
UKI1
UKI2
UKJ1
UKJ2
UKJ3
UKJ4
UKK1
UKK2
UKK3
UKK4
UKL1
UKL2
UKM2
UKM5
UKM6
UKM3
/;
$offmulti;

*define a specific set with the NUTS2 regions only:
Set NUTS2_Regions(Regions)
/
*Afghanistan
*Albania
*Algeria
*Angola
*Argentina
*Armenia
"AT11 Burgenland"
"AT12 Niederoesterreich"
"AT13 Wien"
"AT21 Kaernten"
"AT22 Steiermark"
"AT31 Oberoesterreich"
"AT32 Salzburg"
"AT33 Tirol"
"AT34 Vorarlberg"
*Australia
*Azerbaijan
*Bangladesh
"BE10 Brüssel"
"BE21 Prov. Antwerpen"
"BE22 Prov. Limburg (BE)"
"BE23 Prov. Oost-Vlaanderen"
"BE24 Prov. Vlaams-Brabant"
"BE25 Prov. West-Vlaanderen"
"BE31 Prov. Brabant Wallon"
"BE32 Prov. Hainaut"
"BE33 Prov. Liège"
"BE34 Prov. Luxembourg (BE)"
"BE35 Prov. Namur"
*Belarus
*Benin
"BG31 Severozapaden"
"BG32 Severen tsentralen"
"BG33 Severoiztochen"
"BG34 Yugoiztochen"
"BG41 Yugozapaden"
"BG42 Yuzhen tsentralen"
*Bolivia (Plurinational State of)
*Bosnia and Herzegovina
*Botswana
*Brazil
*Burkina Faso
*Cambodia
*Cameroon
*Canada
*Central African Republic
"CH01 Genferseeregion"
"CH02 Espace Mittelland"
"CH03 Nordwestschweiz"
"CH04 Zuerich"
"CH05 Ostschweiz"
"CH06 Zentralschweiz"
"CH07 Tessin"
*Chad
*Chile
*we summarize the following three in the original data to "China"
***China Hong Kong SAR
***China mainland
***China Taiwan Province of
*Colombia
*Costa Rica
*we replace the following with the SOLm and FAOSTAT name Côte d'Ivoire
***Cote d'Ivoire
*Cuba
"CZ01 Praha"
"CZ02 Stredni Cechy"
"CZ03 Jihozápad"
"CZ04 Severozápad"
"CZ05 Severovýchod"
"CZ06 Jihovýchod"
"CZ07 Strední Morava"
"CZ08 Moravskoslezsko"
"DE11 Stuttgart"
"DE12 Karlsruhe"
"DE13 Freiburg"
"DE14 Tuebingen"
"DE21 Oberbayern"
"DE22 Niederbayern"
"DE23 Oberpfalz"
"DE24 Oberfranken"
"DE25 Mittelfranken"
"DE26 Unterfranken"
"DE27 Schwaben"
"DE30 Berlin"
"DE40 Brandenburg"
"DE50 Bremen"
"DE60 Hamburg"
"DE71 Darmstadt"
"DE72 Giessen"
"DE73 Kassel"
"DE80 Mecklenburg-Vorpommern"
"DE91 Braunschweig"
"DE92 Hannover"
"DE93 Lueneburg"
"DE94 Weser-Ems"
"DEA1 Duesseldorf"
"DEA2 Koeln"
"DEA3 Muenster"
"DEA4 Detmold"
"DEA5 Arnsberg"
"DEB1 Koblenz"
"DEB2 Trier"
"DEB3 Rheinhessen-Pfalz"
"DEC0 Saarland"
"DED SACHSEN"
"DEE SACHSEN-ANHALT"
"DEF0 Schleswig-Holstein"
"DEG0 Thueringen"
*Democratic People's Republic of Korea
"DK Danmark"
*Dominican Republic
*Ecuador
"EE Estland"
*Egypt
*El Salvador
"EL11 Anatoliki makedonia Thraki"
"EL12 Kentriki makedonia"
"EL13 Dytiki makedonia"
"EL14 Thessalia"
"EL21 Ipeiros"
"EL22 Ionia nisia"
"EL23 Dytiki ellada"
"EL24 Sterea ellada"
"EL25 Peloponnisos"
"EL30 Attiki"
"EL41 Voreio aigaio"
"EL42 Notio aigaio"
"EL43 Kriti"
"ES11 Galicia"
"ES12 Principado de Asturias"
"ES13 Cantabria"
"ES21 País Vasco"
"ES22 Comunidad Foral de Navarra"
"ES23 La Rioja"
"ES24 Aragón"
"ES30 Comunidad de Madrid"
"ES41 Castilla y León"
"ES42 Castilla-La Mancha"
"ES43 Extremadura"
"ES51 Cataluña"
"ES52 Comunidad Valenciana"
"ES53 Illes Balears"
"ES61 Andalucía"
"ES62 Región de Murcia"
*Ethiopia
"FI13 Itä-Suomi"
"FI18 Etelä-Suomi"
"FI19 Laensi-Suomi"
"FI1A Pohjois-Suomi"
"FI20 Åland"
"FR10 Île de France"
"FR21 Champagne-Ardenne"
"FR22 Picardie"
"FR23 Haute-Normandie"
"FR24 Centre"
"FR25 Basse-Normandie"
"FR26 Bourgogne"
"FR30 Nord - Pas-de-Calais"
"FR41 Lorraine"
"FR42 Alsace"
"FR43 Franche-Comté"
"FR51 Pays de la Loire"
"FR52 Bretagne"
"FR53 Poitou-Charentes"
"FR61 Aquitaine"
"FR62 Midi-Pyrénées"
"FR63 Limousin"
"FR71 Rhône-Alpes"
"FR72 Auvergne"
"FR81 Languedoc-Roussillon"
"FR82 Provence-Alpes-Côte d'Azur"
"FR83 Corse"
*Gabon
*Gambia
*Georgia
*Ghana
*Guatemala
*Guinea
*Guyana
*Haiti
*Honduras
"HR Croatia"
"HU10 Koezép-Magyarország"
"HU21 Koezép-Dunántúl"
"HU22 Nyugat-Dunántúl"
"HU23 Dél-Dunántúl"
"HU31 Észak-Magyarország"
"HU32 Észak-Alfoeld"
"HU33 Dél-Alfoeld"
"IE01 Border Midland and Western"
"IE02 Southern and Eastern"
*India
*Indonesia
*Iran (Islamic Republic of)
*Iraq
*Israel
"ITC1 Piemonte"
"ITC2 Valle d'Aosta/Vallée d'Aoste"
"ITC3 Liguria"
"ITC4 Lombardia"
"ITF1 Abruzzo"
"ITF2 Molise"
"ITF3 Campania"
"ITF4 Puglia"
"ITF5 Basilicata"
"ITF6 Calabria"
"ITG1 Sicilia"
"ITG2 Sardegna"
"ITH1 Bozen and Trento"
"ITH3 Veneto"
"ITH4 Friuli-Venezia Giulia"
"ITH5 Emilia-Romagna"
"ITI1 Toscana"
"ITI2 Umbria"
"ITI3 Marche"
"ITI4 Lazio"
*Jamaica
*Japan
*Jordan
*Kazakhstan
*Kenya
*Kyrgyzstan
*Lao People's Democratic Republic
*Lebanon
*Lesotho
*Liberia
"LT Lithuania"
"LU Luxembourg"
"LV Latvia"
*Madagascar
*Malawi
*Malaysia
*Mali
*Mauritania
*Mauritius
*Mexico
*Mongolia
*Morocco
*Mozambique
*Myanmar
*Namibia
*Nepal
*New Zealand
*Nicaragua
*Niger
*Nigeria
"NL11 Groningen"
"NL12 Friesland (NL)"
"NL13 Drenthe"
"NL21 Overijssel"
"NL22 Gelderland"
"NL23 Flevoland"
"NL31 Utrecht"
"NL32 Noord-Holland"
"NL33 Zuid-Holland"
"NL34 Zeeland"
"NL41 Noord-Brabant"
"NL42 Limburg (NL)"
*Norway
*Pakistan
*Panama
*Paraguay
*Peru
*Philippines
"PL11 Lodzkie"
"PL12 Mazowieckie"
"PL21 Malopolskie"
"PL22 Slaskie"
"PL31 Lubelskie"
"PL32 Podkarpackie"
"PL33 Swietokrzyskie"
"PL34 Podlaskie"
"PL41 Wielkopolskie"
"PL42 Zachodniopomorskie"
"PL43 Lubuskie"
"PL51 Dolnoslaskie"
"PL52 Opolskie"
"PL61 Kujawsko-pomorskie"
"PL62 Warminsko-mazurskie"
"PL63 Pomorskie"
"PT11 Norte"
"PT15 Algarve"
"PT16 Centro (PT)"
"PT17 Área Metropolitana de Lisboa"
"PT18 Alentejo"
*Republic of Korea
*Republic of Moldova
*replace the following in the original data with Democratic Republic of the Congo
***Republic of the Congo
"Rest of EAP"
"Rest of ECA"
"Rest of EU"
"Rest of HIC"
"Rest of LAC"
"Rest of MNA"
"Rest of SAS"
"Rest of SSA"
"RO11 Nord-Vest"
"RO12 Centru"
"RO21 Nord-Est"
"RO22 Sud-Est"
"RO31 Sud - Muntenia"
"RO32 Bucuresti - Ilfov"
"RO41 Sud-Vest Oltenia"
"RO42 Vest"
*Russian Federation
*Rwanda
*Saudi Arabia
"SE11 Stockholm"
"SE12 Oestra Mellansverige"
"SE21 Småland med oearna"
"SE22 Sydsverige"
"SE23 Vaestsverige"
"SE31 Norra Mellansverige"
"SE32 Mellersta Norrland"
"SE33 Oevre Norrland"
*Senegal
*Serbia
"SI Slovenia"
*Sierra Leone
"SK01 Bratislavský kraj"
"SK02 Západné Slovensko"
"SK03 Stredné Slovensko"
"SK04 Východné Slovensko"
*South Africa
*Sri Lanka
*Suriname
*Swaziland
*Tajikistan
*Thailand
*Togo
*Trinidad and Tobago
*Tunisia
*Turkey
*Turkmenistan
*Uganda
"UKC NORTH EAST (ENGLAND)"
"UKD NORTH WEST (ENGLAND)"
"UKE YORKSHIRE AND THE HUMBER"
"UKF EAST MIDLANDS (ENGLAND)"
"UKG WEST MIDLANDS (ENGLAND)"
"UKH EAST OF ENGLAND"
"UKI London"
"UKJ SOUTH EAST (ENGLAND)"
"UKK SOUTH WEST (ENGLAND)"
"UKL WALES"
"UKM SCOTLAND"
"UKN NORTHERN IRELAND"
*Ukraine
*United Republic of Tanzania
*United States of America
*Uruguay
*Uzbekistan
*Venezuela (Bolivarian Republic of)
*Viet Nam
*Yemen
*Zambia
*Zimbabwe

*and aggregate a label for the non-EU rest of the world:
*"Non-EU Rest of the World"

*and to file in the scenario grassland areas, we need the shorter NUTS2 names:
AT11
AT12
AT13
AT21
AT22
AT31
AT32
AT33
AT34

BE10
BE21
BE22
BE23
BE24
BE25
BE31
BE32
BE33
BE34
BE35

BG31
BG32
BG33
BG34
BG41
BG42

CH01
CH02
CH03
CH04
CH05
CH06
CH07

CZ01
CZ02
CZ03
CZ04
CZ05
CZ06
CZ07
CZ08
DE11
DE12
DE13
DE14
DE21
DE22
DE23
DE24
DE25
DE26
DE27
DE30
DE40
DE50
DE60
DE71
DE72
DE73
DE80
DE91
DE92
DE93
DE94
DEA1
DEA2
DEA3
DEA4
DEA5
DEB1
DEB2
DEB3
DEC0
DED0
DEE0
DEF0
DEG0

DK00

EE00

EL11
EL12
EL13
EL14
EL21
EL22
EL23
EL24
EL25
EL30
EL41
EL42
EL43
ES11
ES12
ES13
ES21
ES22
ES23
ES24
ES30
ES41
ES42
ES43
ES51
ES52
ES53
ES61
ES62

FI13
FI18
FI19
FI1A
FI20
FR10
FR21
FR22
FR23
FR24
FR25
FR26
FR30
FR41
FR42
FR43
FR51
FR52
FR53
FR61
FR62
FR63
FR71
FR72
FR81
FR82
FR83

HR00
HU10
HU21
HU22
HU23
HU31
HU32
HU33
IE01
IE02

ITC1
ITC2
ITC3
ITC4
ITF1
ITF2
ITF3
ITF4
ITF5
ITF6
ITG1
ITG2
ITH1
ITH3
ITH4
ITH5
ITI1
ITI2
ITI3
ITI4

LT00
LU00
LV00

NL11
NL12
NL13
NL21
NL22
NL23
NL31
NL32
NL33
NL34
NL41
NL42

PL11
PL12
PL21
PL22
PL31
PL32
PL33
PL34
PL41
PL42
PL43
PL51
PL52
PL61
PL62
PL63
PT11
PT15
PT16
PT17
PT18

RO11
RO12
RO21
RO22
RO31
RO32
RO41
RO42

SE11
SE12
SE21
SE22
SE23
SE31
SE32
SE33

SI00

SK01
SK02
SK03
SK04

UKC0
UKD0
UKE0
UKF0
UKG0
UKH0
UKI0
UKJ0
UKK0
UKL0
UKM0
UKN0

*additional regions to be added for the animal welfare data:
CY00

DED2
DED4
DED5

DK01
DK02
DK03
DK04
DK05

ES63
ES64

FI1B
FI1C
FI1D

HR04
HR03

IS00

ITH2

LI00

ME00

MK00

MT00

NO01
NO02
NO03
NO04
NO05
NO06
NO07

SI01
SI02

TR10
TR21
TR22
TR31
TR32
TR33
TR41
TR42
TR51
TR52
TR61
TR62
TR63
TR71
TR72
TR81
TR82
TR83
TR90
TRA1
TRA2
TRB1
TRB2
TRC1
TRC2
TRC3

UKC1
UKC2
UKD1
UKD3
UKD4
UKD6
UKD7
UKE1
UKE2
UKE3
UKE4
UKF1
UKF2
UKF3
UKG1
UKG2
UKG3
UKH1
UKH2
UKH3
UKI1
UKI2
UKJ1
UKJ2
UKJ3
UKJ4
UKK1
UKK2
UKK3
UKK4
UKL1
UKL2
UKM2
UKM5
UKM6
UKM3
/;

SET NUTS2_Regions_ShortLabels(Regions)
/
AT11
AT12
AT13
AT21
AT22
AT31
AT32
AT33
AT34

BE10
BE21
BE22
BE23
BE24
BE25
BE31
BE32
BE33
BE34
BE35

BG31
BG32
BG33
BG34
BG41
BG42

CH01
CH02
CH03
CH04
CH05
CH06
CH07

CZ01
CZ02
CZ03
CZ04
CZ05
CZ06
CZ07
CZ08
DE11
DE12
DE13
DE14
DE21
DE22
DE23
DE24
DE25
DE26
DE27
DE30
DE40
DE50
DE60
DE71
DE72
DE73
DE80
DE91
DE92
DE93
DE94
DEA1
DEA2
DEA3
DEA4
DEA5
DEB1
DEB2
DEB3
DEC0
DED0
DEE0
DEF0
DEG0

DK00

EE00

EL11
EL12
EL13
EL14
EL21
EL22
EL23
EL24
EL25
EL30
EL41
EL42
EL43
ES11
ES12
ES13
ES21
ES22
ES23
ES24
ES30
ES41
ES42
ES43
ES51
ES52
ES53
ES61
ES62

FI13
FI18
FI19
FI1A
FI20
FR10
FR21
FR22
FR23
FR24
FR25
FR26
FR30
FR41
FR42
FR43
FR51
FR52
FR53
FR61
FR62
FR63
FR71
FR72
FR81
FR82
FR83

HR00
HU10
HU21
HU22
HU23
HU31
HU32
HU33
IE01
IE02

ITC1
ITC2
ITC3
ITC4
ITF1
ITF2
ITF3
ITF4
ITF5
ITF6
ITG1
ITG2
ITH1
ITH3
ITH4
ITH5
ITI1
ITI2
ITI3
ITI4

LT00
LU00
LV00

NL11
NL12
NL13
NL21
NL22
NL23
NL31
NL32
NL33
NL34
NL41
NL42

PL11
PL12
PL21
PL22
PL31
PL32
PL33
PL34
PL41
PL42
PL43
PL51
PL52
PL61
PL62
PL63
PT11
PT15
PT16
PT17
PT18

RO11
RO12
RO21
RO22
RO31
RO32
RO41
RO42

SE11
SE12
SE21
SE22
SE23
SE31
SE32
SE33

SI00

SK01
SK02
SK03
SK04

UKC0
UKD0
UKE0
UKF0
UKG0
UKH0
UKI0
UKJ0
UKK0
UKL0
UKM0
UKN0

*additional regions to be added for the animal welfare data:
CY00

DED2
DED4
DED5

DK01
DK02
DK03
DK04
DK05

ES63
ES64

FI1B
FI1C
FI1D

HR04
HR03

IS00

ITH2

LI00

ME00

MK00

MT00

NO01
NO02
NO03
NO04
NO05
NO06
NO07

SI01
SI02

TR10
TR21
TR22
TR31
TR32
TR33
TR41
TR42
TR51
TR52
TR61
TR62
TR63
TR71
TR72
TR81
TR82
TR83
TR90
TRA1
TRA2
TRB1
TRB2
TRC1
TRC2
TRC3

UKC1
UKC2
UKD1
UKD3
UKD4
UKD6
UKD7
UKE1
UKE2
UKE3
UKE4
UKF1
UKF2
UKF3
UKG1
UKG2
UKG3
UKH1
UKH2
UKH3
UKI1
UKI2
UKJ1
UKJ2
UKJ3
UKJ4
UKK1
UKK2
UKK3
UKK4
UKL1
UKL2
UKM2
UKM5
UKM6
UKM3
/;

*the following is needed for later:
$onmulti;
Set RegionCodes_awr
/
FI13
FI18
FI1A
/;
$offmulti;



SET Match_RegionCOdes_awr_SOLm(RegionCodes_awr,Regions)
/
'AT11'.'AT11'
'AT12'.'AT12'
'AT13'.'AT13'
'AT21'.'AT21'
'AT22'.'AT22'
'AT31'.'AT31'
'AT32'.'AT32'
'AT33'.'AT33'
'AT34'.'AT34'
'BE10'.'BE10'
'BE21'.'BE21'
'BE22'.'BE22'
'BE23'.'BE23'
'BE24'.'BE24'
'BE25'.'BE25'
'BE31'.'BE31'
'BE32'.'BE32'
'BE33'.'BE33'
'BE34'.'BE34'
'BE35'.'BE35'
'BG31'.'BG31'
'BG32'.'BG32'
'BG33'.'BG33'
'BG34'.'BG34'
'BG41'.'BG41'
'BG42'.'BG42'
'CH01'.'CH01'
'CH02'.'CH02'
'CH03'.'CH03'
'CH04'.'CH04'
'CH05'.'CH05'
'CH06'.'CH06'
'CH07'.'CH07'
'CY00'.'CY00'
'CZ01'.'CZ01'
'CZ02'.'CZ02'
'CZ03'.'CZ03'
'CZ04'.'CZ04'
'CZ05'.'CZ05'
'CZ06'.'CZ06'
'CZ07'.'CZ07'
'CZ08'.'CZ08'
'DE11'.'DE11'
'DE12'.'DE12'
'DE13'.'DE13'
'DE14'.'DE14'
'DE21'.'DE21'
'DE22'.'DE22'
'DE23'.'DE23'
'DE24'.'DE24'
'DE25'.'DE25'
'DE26'.'DE26'
'DE27'.'DE27'
'DE30'.'DE30'
'DE40'.'DE40'
'DE50'.'DE50'
'DE60'.'DE60'
'DE71'.'DE71'
'DE72'.'DE72'
'DE73'.'DE73'
'DE80'.'DE80'
'DE91'.'DE91'
'DE92'.'DE92'
'DE93'.'DE93'
'DE94'.'DE94'
'DEA1'.'DEA1'
'DEA2'.'DEA2'
'DEA3'.'DEA3'
'DEA4'.'DEA4'
'DEA5'.'DEA5'
'DEB1'.'DEB1'
'DEB2'.'DEB2'
'DEB3'.'DEB3'
'DEC0'.'DEC0'
*''.'DED0'
'DED2'.'DED2'
'DED4'.'DED4'
'DED5'.'DED5'
'DEE0'.'DEE0'
'DEF0'.'DEF0'
'DEG0'.'DEG0'
'DK01'.'DK01'
'DK02'.'DK02'
'DK03'.'DK03'
'DK04'.'DK04'
'DK05'.'DK05'
*''.'DK00'
'EE00'.'EE00'
'EL11'.'EL11'
'EL12'.'EL12'
'EL13'.'EL13'
'EL14'.'EL14'
'EL21'.'EL21'
'EL22'.'EL22'
'EL23'.'EL23'
'EL24'.'EL24'
'EL25'.'EL25'
'EL30'.'EL30'
'EL41'.'EL41'
'EL42'.'EL42'
'EL43'.'EL43'
'ES11'.'ES11'
'ES12'.'ES12'
'ES13'.'ES13'
'ES21'.'ES21'
'ES22'.'ES22'
'ES23'.'ES23'
'ES24'.'ES24'
'ES30'.'ES30'
'ES41'.'ES41'
'ES42'.'ES42'
'ES43'.'ES43'
'ES51'.'ES51'
'ES52'.'ES52'
'ES53'.'ES53'
'ES61'.'ES61'
'ES62'.'ES62'
'ES63'.'ES63'
'ES64'.'ES64'
'FI13'.'FI13'
'FI18'.'FI18'
'FI19'.'FI19'
'FI1A'.'FI1A'
'FI1B'.'FI1B'
'FI1C'.'FI1C'
'FI1D'.'FI1D'
'FI20'.'FI20'
'FR10'.'FR10'
'FR21'.'FR21'
'FR22'.'FR22'
'FR23'.'FR23'
'FR24'.'FR24'
'FR25'.'FR25'
'FR26'.'FR26'
'FR30'.'FR30'
'FR41'.'FR41'
'FR42'.'FR42'
'FR43'.'FR43'
'FR51'.'FR51'
'FR52'.'FR52'
'FR53'.'FR53'
'FR61'.'FR61'
'FR62'.'FR62'
'FR63'.'FR63'
'FR71'.'FR71'
'FR72'.'FR72'
'FR81'.'FR81'
'FR82'.'FR82'
'FR83'.'FR83'
'HR04'.'HR04'
'HR03'.'HR03'
*''.'HR00'
'HU10'.'HU10'
'HU21'.'HU21'
'HU22'.'HU22'
'HU23'.'HU23'
'HU31'.'HU31'
'HU32'.'HU32'
'HU33'.'HU33'
'IE01'.'IE01'
'IE02'.'IE02'
'IS00'.'IS00'
'ITC1'.'ITC1'
'ITC2'.'ITC2'
'ITC3'.'ITC3'
'ITC4'.'ITC4'
'ITF1'.'ITF1'
'ITF2'.'ITF2'
'ITF3'.'ITF3'
'ITF4'.'ITF4'
'ITF5'.'ITF5'
'ITF6'.'ITF6'
'ITG1'.'ITG1'
'ITG2'.'ITG2'
'ITH1'.'ITH1'
'ITH2'.'ITH2'
'ITH3'.'ITH3'
'ITH4'.'ITH4'
'ITH5'.'ITH5'
'ITI1'.'ITI1'
'ITI2'.'ITI2'
'ITI3'.'ITI3'
'ITI4'.'ITI4'
'LI00'.'LI00'
'LT00'.'LT00'
'LU00'.'LU00'
'LV00'.'LV00'
'ME00'.'ME00'
'MK00'.'MK00'
'MT00'.'MT00'
'NL11'.'NL11'
'NL12'.'NL12'
'NL13'.'NL13'
'NL21'.'NL21'
'NL22'.'NL22'
'NL23'.'NL23'
'NL31'.'NL31'
'NL32'.'NL32'
'NL33'.'NL33'
'NL34'.'NL34'
'NL41'.'NL41'
'NL42'.'NL42'
'NO01'.'NO01'
'NO02'.'NO02'
'NO03'.'NO03'
'NO04'.'NO04'
'NO05'.'NO05'
'NO06'.'NO06'
'NO07'.'NO07'
'PL11'.'PL11'
'PL12'.'PL12'
'PL21'.'PL21'
'PL22'.'PL22'
'PL31'.'PL31'
'PL32'.'PL32'
'PL33'.'PL33'
'PL34'.'PL34'
'PL41'.'PL41'
'PL42'.'PL42'
'PL43'.'PL43'
'PL51'.'PL51'
'PL52'.'PL52'
'PL61'.'PL61'
'PL62'.'PL62'
'PL63'.'PL63'
'PT11'.'PT11'
'PT15'.'PT15'
'PT16'.'PT16'
'PT17'.'PT17'
'PT18'.'PT18'
'RO11'.'RO11'
'RO12'.'RO12'
'RO21'.'RO21'
'RO22'.'RO22'
'RO31'.'RO31'
'RO32'.'RO32'
'RO41'.'RO41'
'RO42'.'RO42'
'SE11'.'SE11'
'SE12'.'SE12'
'SE21'.'SE21'
'SE22'.'SE22'
'SE23'.'SE23'
'SE31'.'SE31'
'SE32'.'SE32'
'SE33'.'SE33'
'SI01'.'SI01'
'SI02'.'SI02'
*''.'SI00'
'SK01'.'SK01'
'SK02'.'SK02'
'SK03'.'SK03'
'SK04'.'SK04'
'TR10'.'TR10'
'TR21'.'TR21'
'TR22'.'TR22'
'TR31'.'TR31'
'TR32'.'TR32'
'TR33'.'TR33'
'TR41'.'TR41'
'TR42'.'TR42'
'TR51'.'TR51'
'TR52'.'TR52'
'TR61'.'TR61'
'TR62'.'TR62'
'TR63'.'TR63'
'TR71'.'TR71'
'TR72'.'TR72'
'TR81'.'TR81'
'TR82'.'TR82'
'TR83'.'TR83'
'TR90'.'TR90'
'TRA1'.'TRA1'
'TRA2'.'TRA2'
'TRB1'.'TRB1'
'TRB2'.'TRB2'
'TRC1'.'TRC1'
'TRC2'.'TRC2'
'TRC3'.'TRC3'
*''.'UKC0'
*''.'UKD0'
*''.'UKE0'
*''.'UKF0'
*''.'UKG0'
*''.'UKH0'
*''.'UKI0'
*''.'UKJ0'
*''.'UKK0'
*''.'UKL0'
*''.'UKM0'
*''.'UKN0'
'UKC1'.'UKC1'
'UKC2'.'UKC2'
'UKD1'.'UKD1'
'UKD3'.'UKD3'
'UKD4'.'UKD4'
'UKD6'.'UKD6'
'UKD7'.'UKD7'
'UKE1'.'UKE1'
'UKE2'.'UKE2'
'UKE3'.'UKE3'
'UKE4'.'UKE4'
'UKF1'.'UKF1'
'UKF2'.'UKF2'
'UKF3'.'UKF3'
'UKG1'.'UKG1'
'UKG2'.'UKG2'
'UKG3'.'UKG3'
'UKH1'.'UKH1'
'UKH2'.'UKH2'
'UKH3'.'UKH3'
'UKI1'.'UKI1'
'UKI2'.'UKI2'
'UKJ1'.'UKJ1'
'UKJ2'.'UKJ2'
'UKJ3'.'UKJ3'
'UKJ4'.'UKJ4'
'UKK1'.'UKK1'
'UKK2'.'UKK2'
'UKK3'.'UKK3'
'UKK4'.'UKK4'
'UKL1'.'UKL1'
'UKL2'.'UKL2'
'UKM2'.'UKM2'
'UKM5'.'UKM5'
'UKM6'.'UKM6'
'UKN0'.'UKN0'
'UKM3'.'UKM3'
'AT'.'Austria'
'BE'.'Belgium'
'BG'.'Bulgaria'
'CH'.'Switzerland'
'CY'.'Cyprus'
'CZ'.'Czechia'
'DE'.'Germany'
'DK'.'Denmark'
'EE'.'Estonia'
'EL'.'Greece'
'ES'.'Spain'
'FI'.'Finland'
'FR'.'France'
'HR'.'Croatia'
'HU'.'Hungary'
'IE'.'Ireland'
'IS'.'Iceland'
'IT'.'Italy'
*'LI'.'Lichtenstein'
'LT'.'Lithuania'
'LU'.'Luxembourg'
'LV'.'Latvia'
'ME'.'Montenegro'
'MK'.'The Former Yugoslav Republic of Macedonia'
'MT'.'Malta'
'NL'.'Netherlands'
'NO'.'Norway'
'PL'.'Poland'
'PT'.'Portugal'
'RO'.'Romania'
'SE'.'Sweden'
'SI'.'Slovenia'
'SK'.'Slovakia'
'TR'.'Turkey'
'UK'.'United Kingdom'
/;


*antibiotics and heat stress indices use different coding for Finland than all other UNISECO SEssit indices, thus reassign those:
*https://publications.jrc.ec.europa.eu/repository/bitstream/JRC104030/jrc104030.pdf
*FI1C shall be FI18
*FI1D shall be FI13, FI1A

awr_components("FI18","mr") = awr_components("FI1C","mr");
awr_components("FI13","mr") = awr_components("FI1D","mr");
awr_components("FI1A","mr") = awr_components("FI1D","mr");

awr_components("FI18","hwd1") = awr_components("FI1C","hwd1");
awr_components("FI13","hwd1") = awr_components("FI1D","hwd1");
awr_components("FI1A","hwd1") = awr_components("FI1D","hwd1");
awr_components("FI18","hwd2") = awr_components("FI1C","hwd2");
awr_components("FI13","hwd2") = awr_components("FI1D","hwd2");
awr_components("FI1A","hwd2") = awr_components("FI1D","hwd2");

awr_components("FI1B","mr") = 0;
awr_components("FI1C","mr") = 0;
awr_components("FI1D","mr") = 0;
awr_components("FI1B","hwd1") = 0;
awr_components("FI1C","hwd1") = 0;
awr_components("FI1D","hwd1") = 0;
awr_components("FI1B","hwd2") = 0;
awr_components("FI1C","hwd2") = 0;
awr_components("FI1D","hwd2") = 0;


*the condition is to assure that only sensible combinations of livestock and herd types are assigned - "United States of America" is choosen as this has surely data for all animals and thus gives a positive logic condition where a combination of animal and herd type makes sense
ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst","AllProdCond")
                 $ActAnimalsHead_OtherChar("United States of America",Activities,AnimalTypeInHerd,"Liveweight (t)","AllProdSyst","AllProdCond")
         = sum(RegionCodes_awr$Match_RegionCOdes_awr_SOLm(RegionCodes_awr,Regions),
                 awr_components(RegionCodes_awr,"mr"));
*we have some further information on the antibiotics use index: antibiotics are used according to the following Weights on different animal categories: 1/8 bovine, 3/8 chicken, 4/8 pigs (van Boeckel et al. 2015 https://www.pnas.org/content/112/18/5649.short)
*thus adjust accordingly:
*basis: take 1/8 of the index, then multiply with 3 for poultry, with 4 for pigs:
ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst","AllProdCond")/8;
ActAnimalsHead_OtherChar(Regions,Poultry,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,Poultry,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst","AllProdCond")*3;
ActAnimalsHead_OtherChar(Regions,"Pigs",AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Pigs",AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst","AllProdCond")*4;


ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2020","AllProdSyst","AllProdCond")
                 $ActAnimalsHead_OtherChar("United States of America",Activities,AnimalTypeInHerd,"Liveweight (t)","AllProdSyst","AllProdCond")
         = sum(RegionCodes_awr$Match_RegionCOdes_awr_SOLm(RegionCodes_awr,Regions),
                 awr_components(RegionCodes_awr,"hwd1"));
ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2030","AllProdSyst","AllProdCond")
                 $ActAnimalsHead_OtherChar("United States of America",Activities,AnimalTypeInHerd,"Liveweight (t)","AllProdSyst","AllProdCond")
         = sum(RegionCodes_awr$Match_RegionCOdes_awr_SOLm(RegionCodes_awr,Regions),
                 awr_components(RegionCodes_awr,"hwd2"));
*derive very grossly a heat stress index for 2050 by just linearly extrapolating from 2020 and 2030; for this add a third name "hwd3":
$onmulti;
Set awr_components_names
/
hwd3
/;
awr_components(RegionCodes_awr,"hwd3")
         = awr_components(RegionCodes_awr,"hwd2")
                 + 2*(awr_components(RegionCodes_awr,"hwd2")
                         -awr_components(RegionCodes_awr,"hwd1"));
ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2050","AllProdSyst","AllProdCond")
                 $ActAnimalsHead_OtherChar("United States of America",Activities,AnimalTypeInHerd,"Liveweight (t)","AllProdSyst","AllProdCond")
         = sum(RegionCodes_awr$Match_RegionCOdes_awr_SOLm(RegionCodes_awr,Regions),
                 awr_components(RegionCodes_awr,"hwd3"));


ActAnimalsHead_OtherChar(Regions,Activities,"AllAndAverageTypes","Animal welfare: transport volume index","AllProdSyst","AllProdCond")
                 $VActAnimalsHead_QuantityActUnits.l(Regions,Activities,"Living","AllProdSyst","AllProdCond")
         = TradeInLivingAnimals(Activities,Regions)
                 /VActAnimalsHead_QuantityActUnits.l(Regions,Activities,"Living","AllProdSyst","AllProdCond");
*assign the combined value of sheep and goats to each of them separately:
ActAnimalsHead_OtherChar(Regions,"Sheep","AllAndAverageTypes","Animal welfare: transport volume index","AllProdSyst","AllProdCond")
                 $(VActAnimalsHead_QuantityActUnits.l(Regions,"Sheep","Living","AllProdSyst","AllProdCond")
                         + VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living","AllProdSyst","AllProdCond"))
         = TradeInLivingAnimals("Sheep and goats",Regions)
                 /(VActAnimalsHead_QuantityActUnits.l(Regions,"Sheep","Living","AllProdSyst","AllProdCond")
                         + VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living","AllProdSyst","AllProdCond"));
ActAnimalsHead_OtherChar(Regions,"Goats","AllAndAverageTypes","Animal welfare: transport volume index","AllProdSyst","AllProdCond")
                 $(VActAnimalsHead_QuantityActUnits.l(Regions,"Sheep","Living","AllProdSyst","AllProdCond")
                         + VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living","AllProdSyst","AllProdCond"))
         = TradeInLivingAnimals("Sheep and goats",Regions)
                 /(VActAnimalsHead_QuantityActUnits.l(Regions,"Sheep","Living","AllProdSyst","AllProdCond")
                         + VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living","AllProdSyst","AllProdCond"));

*for the intensity indicator, use the arguments made above at the beginning:
$ontext;
DECISION: use share of non-grass in feeding rations: the higher, the lower is animal welfare
         - monogastrics: maybe yields? Works for eggs - but meat is rather captured via the duration to reach it than the yield.
                 thus, may capture via relation of animal numbers to cropland areas - as an indication of domestic or foreign feed
                 or may use the ratio of producing over living animals (for meat production) - this is a gross indication of the duration to gain the end weight: the shorter, the more intensive, i.e. the bigger is the ratio (more producing per living)
thus, for
- ruminants: share non-grass in feed
- monogastrics (meat): ration producing/living animals
- eggs: yield

thus, use the following indices:
"Animal welfare: production intensity index - ruminants"
"Animal welfare: production intensity index - monogastric meat"
"Animal welfare: production intensity index - eggs"

$offtext;

*these will be assigned here for the baseline, but then need to be CALCULATED ANEW for scenarios (as the per head index may change).

ActAnimalsHead_OtherChar(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants","AllProdSyst","AllProdCond")
         = FeedingRations_OtherChar(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)","AllProdSyst","AllProdCond")
                 + FeedingRations_OtherChar(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)","AllProdSyst","AllProdCond");

*the condition is to assure that only sensible combinations of livestock and herd types are assigned
ActAnimalsHead_OtherChar(Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat","AllProdSyst","AllProdCond")
                 $(ActAnimalsHead_OtherChar(Regions,NonRuminants,AnimalTypeInHerd,"Liveweight (t)","AllProdSyst","AllProdCond")
                          AND VActAnimalsHead_QuantityActUnits.l(Regions,NonRuminants,"Living","AllProdSyst","AllProdCond"))
         = VActAnimalsHead_QuantityActUnits.l(Regions,NonRuminants,"Meat producing","AllProdSyst","AllProdCond")
                 /VActAnimalsHead_QuantityActUnits.l(Regions,NonRuminants,"Living","AllProdSyst","AllProdCond");

*the condition is to assure that only sensible combinations of livestock and herd types are assigned
ActAnimalsHead_OtherChar(Regions,Poultry,AnimalTypeInHerd,"Animal welfare: production intensity index - eggs","AllProdSyst","AllProdCond")
                 $ActAnimalsHead_OtherChar(Regions,Poultry,AnimalTypeInHerd,"Liveweight (t)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_Outputs(Regions,Poultry,"Egg producing","Eggs (t)","AllProdSyst","AllProdCond");

*and, finally, somewhat adjust the antibiotics indicator (ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst","AllProdCond")) for intensity:
*the less intensive, the less antibiotics use; in particular: reduce it for organic produciton where prophylactic antibiotic use is banned
*but this is then only done in the scenarios, taking the index here as the given baseline.

*thus, the following indicators are adjusted in the end:
*and changes are reported not only in total, but also on a per animal level, to show how much it changes for the remaining animals (as otherwise, the reduction/increase in animal numnbers dominates the result and potentially hides an adverse/good per head development).

*"Animal welfare: antibiotics use index"
*"Animal welfare: production intensity index - ruminants"
*"Animal welfare: production intensity index - monogastric meat"
*"Animal welfare: production intensity index - eggs"



$exit;


PUTCLOSE con "   Test3 READY:" timeElapsed;






to do AFTER Scenario runs at the end: assign values for those that may change in the scenarios (e.g. yield dependent) -
 and do output as total AND per head (as the animal welfare scales with heads - but it is also important to see how well the remaining ones do, relatively).








