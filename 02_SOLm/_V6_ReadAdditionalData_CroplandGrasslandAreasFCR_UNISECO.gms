PUTCLOSE con,"_V6_ReadAdditionalData_CroplandGrasslandAreasFCR_UNISECO";

*GENERAL DESCRIPTION
*This file contains the code to read additional data for cropland and grassland areas and feed conversion rates (FCR), as used in the scenarios from the EU project UNISECO
*the data is an output from the BioBam model, where the optimal cropping patterns have been derived based on some assumptions on land use, food provision, etc. - see UNISECO project, in particular Deliverable 4.2, Röös et al. 2020


*DETAILED TABLE OF CONTENTS
$ontext;
*1) Cropland area data from BioBam - various scenarios
*2) Grassland area data from BioBam - Baseline 2012
*3) FCR data from BioBam - all core scenarios for UNISECO

$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Cropland area data from BioBam - various scenarios

PARAMETER CroplandArea_BioBamUNISECO(Regions,Scenarios,Activities)      "Cropland areas as used in various scenarios in the UNISECO project";
*see the excel sheet for further details; this is output data from BioBam
*UNITS: Mha - million hectares

*build a subset of scenarios that are used here:
Set ScenariosUNISECO(Scenarios)
/
"LfP_2050", "AE_exports_2050", "LfS_2050", "AE_food_2050"
/;

*Also add an aggregate element to activities which is not yet available: forage crop INCLUDING temporary grasslands:
$onmulti;
Set Activities
/
"All forage crops - BioBam"
/;
$offmulti;

*add additional elements with NUTS2-region names to the set regions:

*this is already needed to file in the animal welfare data, so do it there already.
$ontext;
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
UKN0
UKM3


/;
$offmulti;
$offtext;

*and add the subsets with the NUTS2 regions per country:

Set NUTS2_Austria(Regions)
/
"AT11 Burgenland"
"AT12 Niederoesterreich"
"AT13 Wien"
"AT21 Kaernten"
"AT22 Steiermark"
"AT31 Oberoesterreich"
"AT32 Salzburg"
"AT33 Tirol"
"AT34 Vorarlberg"
/;

Set NUTS2_Belgium(Regions)
/
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
/;

Set NUTS2_Bulgaria(Regions)
/
"BG31 Severozapaden"
"BG32 Severen tsentralen"
"BG33 Severoiztochen"
"BG34 Yugoiztochen"
"BG41 Yugozapaden"
"BG42 Yuzhen tsentralen"
/;

Set NUTS2_Switzerland(Regions)
/
"CH01 Genferseeregion"
"CH02 Espace Mittelland"
"CH03 Nordwestschweiz"
"CH04 Zuerich"
"CH05 Ostschweiz"
"CH06 Zentralschweiz"
"CH07 Tessin"
/;

Set NUTS2_Czechia(Regions)
/
"CZ01 Praha"
"CZ02 Stredni Cechy"
"CZ03 Jihozápad"
"CZ04 Severozápad"
"CZ05 Severovýchod"
"CZ06 Jihovýchod"
"CZ07 Strední Morava"
"CZ08 Moravskoslezsko"
/;

Set NUTS2_Germany(Regions)
/
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
/;

Set NUTS2_Denmark(Regions)
/
"DK Danmark"
/;

Set NUTS2_Estonia(Regions)
/
"EE Estland"
/;

Set NUTS2_Greece(Regions)
/
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
/;

Set NUTS2_Spain(Regions)
/
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
/;

Set NUTS2_Finland(Regions)
/
"FI13 Itä-Suomi"
"FI18 Etelä-Suomi"
"FI19 Laensi-Suomi"
"FI1A Pohjois-Suomi"
"FI20 Åland"
/;

Set NUTS2_France(Regions)
/
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
/;

Set NUTS2_Croatia(Regions)
/
"HR Croatia"
/;

Set NUTS2_Hungary(Regions)
/
"HU10 Koezép-Magyarország"
"HU21 Koezép-Dunántúl"
"HU22 Nyugat-Dunántúl"
"HU23 Dél-Dunántúl"
"HU31 Észak-Magyarország"
"HU32 Észak-Alfoeld"
"HU33 Dél-Alfoeld"
/;

Set NUTS2_Ireland(Regions)
/
"IE01 Border Midland and Western"
"IE02 Southern and Eastern"
/;

Set NUTS2_Italia(Regions)
/
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
/;

Set NUTS2_Lithuania(Regions)
/
"LT Lithuania"
/;

Set NUTS2_Luxembourg(Regions)
/
"LU Luxembourg"
/;

Set NUTS2_Latvia(Regions)
/
"LV Latvia"
/;

Set NUTS2_Netherlands(Regions)
/
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
/;

Set NUTS2_Poland(Regions)
/
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
/;

Set NUTS2_Portugal(Regions)
/
"PT11 Norte"
"PT15 Algarve"
"PT16 Centro (PT)"
"PT17 Área Metropolitana de Lisboa"
"PT18 Alentejo"
/;

Set NUTS2_Romania(Regions)
/
"RO11 Nord-Vest"
"RO12 Centru"
"RO21 Nord-Est"
"RO22 Sud-Est"
"RO31 Sud - Muntenia"
"RO32 Bucuresti - Ilfov"
"RO41 Sud-Vest Oltenia"
"RO42 Vest"
/;

Set NUTS2_Sweden(Regions)
/
"SE11 Stockholm"
"SE12 Oestra Mellansverige"
"SE21 Småland med oearna"
"SE22 Sydsverige"
"SE23 Vaestsverige"
"SE31 Norra Mellansverige"
"SE32 Mellersta Norrland"
"SE33 Oevre Norrland"
/;

Set NUTS2_Slovenia(Regions)
/
"SI Slovenia"
/;

Set NUTS2_Slovakia(Regions)
/
"SK01 Bratislavský kraj"
"SK02 Západné Slovensko"
"SK03 Stredné Slovensko"
"SK04 Východné Slovensko"
/;

Set NUTS2_UK(Regions)
/
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
/;

*not covered:
*Cyprus
*Malta

*and do the subsets with the short labels only as well
*and add the subsets with the NUTS2 regions per country:

Set NUTS2_SHORT_Austria(Regions)
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
/;

Set NUTS2_SHORT_Belgium(Regions)
/
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
/;

Set NUTS2_SHORT_Bulgaria(Regions)
/
BG31
BG32
BG33
BG34
BG41
BG42
/;

Set NUTS2_SHORT_Switzerland(Regions)
/
CH01
CH02
CH03
CH04
CH05
CH06
CH07
/;

Set NUTS2_SHORT_Czechia(Regions)
/
CZ01
CZ02
CZ03
CZ04
CZ05
CZ06
CZ07
CZ08
/;

Set NUTS2_SHORT_Germany(Regions)
/
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
/;

Set NUTS2_SHORT_Denmark(Regions)
/
DK00
/;

Set NUTS2_SHORT_Estonia(Regions)
/
EE00
/;

Set NUTS2_SHORT_Greece(Regions)
/
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
/;

Set NUTS2_SHORT_Spain(Regions)
/
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
/;

Set NUTS2_SHORT_Finland(Regions)
/
FI13
FI18
FI19
FI1A
FI20
/;

Set NUTS2_SHORT_France(Regions)
/
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
/;

Set NUTS2_SHORT_Croatia(Regions)
/
HR00
/;

Set NUTS2_SHORT_Hungary(Regions)
/
HU10
HU21
HU22
HU23
HU31
HU32
HU33
/;

Set NUTS2_SHORT_Ireland(Regions)
/
IE01
IE02
/;

Set NUTS2_SHORT_Italia(Regions)
/
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
/;

Set NUTS2_SHORT_Lithuania(Regions)
/
LT00
/;

Set NUTS2_SHORT_Luxembourg(Regions)
/
LU00
/;

Set NUTS2_SHORT_Latvia(Regions)
/
LV00
/;

Set NUTS2_SHORT_Netherlands(Regions)
/
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
/;

Set NUTS2_SHORT_Poland(Regions)
/
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
/;

Set NUTS2_SHORT_Portugal(Regions)
/
PT11
PT15
PT16
PT17
PT18
/;

Set NUTS2_SHORT_Romania(Regions)
/
RO11
RO12
RO21
RO22
RO31
RO32
RO41
RO42
/;

Set NUTS2_SHORT_Sweden(Regions)
/
SE11
SE12
SE21
SE22
SE23
SE31
SE32
SE33
/;

Set NUTS2_SHORT_Slovenia(Regions)
/
SI00
/;

Set NUTS2_SHORT_Slovakia(Regions)
/
SK01
SK02
SK03
SK04
/;

Set NUTS2_SHORT_UK(Regions)
/
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
/;

*Later, we also need the matching between short and long NUTS2-labels:
Set Match_NUTS2_ShortAndLongLabels(Regions,Regions_2)
/
AT11."AT11 Burgenland"
AT12."AT12 Niederoesterreich"
AT13."AT13 Wien"
AT21."AT21 Kaernten"
AT22."AT22 Steiermark"
AT31."AT31 Oberoesterreich"
AT32."AT32 Salzburg"
AT33."AT33 Tirol"
AT34."AT34 Vorarlberg"
*
BE10."BE10 Brüssel"
BE21."BE21 Prov. Antwerpen"
BE22."BE22 Prov. Limburg (BE)"
BE23."BE23 Prov. Oost-Vlaanderen"
BE24."BE24 Prov. Vlaams-Brabant"
BE25."BE25 Prov. West-Vlaanderen"
BE31."BE31 Prov. Brabant Wallon"
BE32."BE32 Prov. Hainaut"
BE33."BE33 Prov. Liège"
BE34."BE34 Prov. Luxembourg (BE)"
BE35."BE35 Prov. Namur"
*
BG31."BG31 Severozapaden"
BG32."BG32 Severen tsentralen"
BG33."BG33 Severoiztochen"
BG34."BG34 Yugoiztochen"
BG41."BG41 Yugozapaden"
BG42."BG42 Yuzhen tsentralen"
*
CH01."CH01 Genferseeregion"
CH02."CH02 Espace Mittelland"
CH03."CH03 Nordwestschweiz"
CH04."CH04 Zuerich"
CH05."CH05 Ostschweiz"
CH06."CH06 Zentralschweiz"
CH07."CH07 Tessin"
*
CZ01."CZ01 Praha"
CZ02."CZ02 Stredni Cechy"
CZ03."CZ03 Jihozápad"
CZ04."CZ04 Severozápad"
CZ05."CZ05 Severovýchod"
CZ06."CZ06 Jihovýchod"
CZ07."CZ07 Strední Morava"
CZ08."CZ08 Moravskoslezsko"
*
DE11."DE11 Stuttgart"
DE12."DE12 Karlsruhe"
DE13."DE13 Freiburg"
DE14."DE14 Tuebingen"
DE21."DE21 Oberbayern"
DE22."DE22 Niederbayern"
DE23."DE23 Oberpfalz"
DE24."DE24 Oberfranken"
DE25."DE25 Mittelfranken"
DE26."DE26 Unterfranken"
DE27."DE27 Schwaben"
DE30."DE30 Berlin"
DE40."DE40 Brandenburg"
DE50."DE50 Bremen"
DE60."DE60 Hamburg"
DE71."DE71 Darmstadt"
DE72."DE72 Giessen"
DE73."DE73 Kassel"
DE80."DE80 Mecklenburg-Vorpommern"
DE91."DE91 Braunschweig"
DE92."DE92 Hannover"
DE93."DE93 Lueneburg"
DE94."DE94 Weser-Ems"
DEA1."DEA1 Duesseldorf"
DEA2."DEA2 Koeln"
DEA3."DEA3 Muenster"
DEA4."DEA4 Detmold"
DEA5."DEA5 Arnsberg"
DEB1."DEB1 Koblenz"
DEB2."DEB2 Trier"
DEB3."DEB3 Rheinhessen-Pfalz"
DEC0."DEC0 Saarland"
DED0."DED SACHSEN"
DEE0."DEE SACHSEN-ANHALT"
DEF0."DEF0 Schleswig-Holstein"
DEG0."DEG0 Thueringen"
*
DK00."DK Danmark"
*
EE00."EE Estland"
*
EL11."EL11 Anatoliki makedonia Thraki"
EL12."EL12 Kentriki makedonia"
EL13."EL13 Dytiki makedonia"
EL14."EL14 Thessalia"
EL21."EL21 Ipeiros"
EL22."EL22 Ionia nisia"
EL23."EL23 Dytiki ellada"
EL24."EL24 Sterea ellada"
EL25."EL25 Peloponnisos"
EL30."EL30 Attiki"
EL41."EL41 Voreio aigaio"
EL42."EL42 Notio aigaio"
EL43."EL43 Kriti"
*
ES11."ES11 Galicia"
ES12."ES12 Principado de Asturias"
ES13."ES13 Cantabria"
ES21."ES21 País Vasco"
ES22."ES22 Comunidad Foral de Navarra"
ES23."ES23 La Rioja"
ES24."ES24 Aragón"
ES30."ES30 Comunidad de Madrid"
ES41."ES41 Castilla y León"
ES42."ES42 Castilla-La Mancha"
ES43."ES43 Extremadura"
ES51."ES51 Cataluña"
ES52."ES52 Comunidad Valenciana"
ES53."ES53 Illes Balears"
ES61."ES61 Andalucía"
ES62."ES62 Región de Murcia"
*
FI13."FI13 Itä-Suomi"
FI18."FI18 Etelä-Suomi"
FI19."FI19 Laensi-Suomi"
FI1A."FI1A Pohjois-Suomi"
FI20."FI20 Åland"
*
FR10."FR10 Île de France"
FR21."FR21 Champagne-Ardenne"
FR22."FR22 Picardie"
FR23."FR23 Haute-Normandie"
FR24."FR24 Centre"
FR25."FR25 Basse-Normandie"
FR26."FR26 Bourgogne"
FR30."FR30 Nord - Pas-de-Calais"
FR41."FR41 Lorraine"
FR42."FR42 Alsace"
FR43."FR43 Franche-Comté"
FR51."FR51 Pays de la Loire"
FR52."FR52 Bretagne"
FR53."FR53 Poitou-Charentes"
FR61."FR61 Aquitaine"
FR62."FR62 Midi-Pyrénées"
FR63."FR63 Limousin"
FR71."FR71 Rhône-Alpes"
FR72."FR72 Auvergne"
FR81."FR81 Languedoc-Roussillon"
FR82."FR82 Provence-Alpes-Côte d'Azur"
FR83."FR83 Corse"
*
HR00."HR Croatia"
*
HU10."HU10 Koezép-Magyarország"
HU21."HU21 Koezép-Dunántúl"
HU22."HU22 Nyugat-Dunántúl"
HU23."HU23 Dél-Dunántúl"
HU31."HU31 Észak-Magyarország"
HU32."HU32 Észak-Alfoeld"
HU33."HU33 Dél-Alfoeld"
*
IE01."IE01 Border Midland and Western"
IE02."IE02 Southern and Eastern"
*
ITC1."ITC1 Piemonte"
ITC2."ITC2 Valle d'Aosta/Vallée d'Aoste"
ITC3."ITC3 Liguria"
ITC4."ITC4 Lombardia"
ITF1."ITF1 Abruzzo"
ITF2."ITF2 Molise"
ITF3."ITF3 Campania"
ITF4."ITF4 Puglia"
ITF5."ITF5 Basilicata"
ITF6."ITF6 Calabria"
ITG1."ITG1 Sicilia"
ITG2."ITG2 Sardegna"
ITH1."ITH1 Bozen and Trento"
ITH3."ITH3 Veneto"
ITH4."ITH4 Friuli-Venezia Giulia"
ITH5."ITH5 Emilia-Romagna"
ITI1."ITI1 Toscana"
ITI2."ITI2 Umbria"
ITI3."ITI3 Marche"
ITI4."ITI4 Lazio"
*
LT00."LT Lithuania"
LU00."LU Luxembourg"
LV00."LV Latvia"
*
NL11."NL11 Groningen"
NL12."NL12 Friesland (NL)"
NL13."NL13 Drenthe"
NL21."NL21 Overijssel"
NL22."NL22 Gelderland"
NL23."NL23 Flevoland"
NL31."NL31 Utrecht"
NL32."NL32 Noord-Holland"
NL33."NL33 Zuid-Holland"
NL34."NL34 Zeeland"
NL41."NL41 Noord-Brabant"
NL42."NL42 Limburg (NL)"
*
PL11."PL11 Lodzkie"
PL12."PL12 Mazowieckie"
PL21."PL21 Malopolskie"
PL22."PL22 Slaskie"
PL31."PL31 Lubelskie"
PL32."PL32 Podkarpackie"
PL33."PL33 Swietokrzyskie"
PL34."PL34 Podlaskie"
PL41."PL41 Wielkopolskie"
PL42."PL42 Zachodniopomorskie"
PL43."PL43 Lubuskie"
PL51."PL51 Dolnoslaskie"
PL52."PL52 Opolskie"
PL61."PL61 Kujawsko-pomorskie"
PL62."PL62 Warminsko-mazurskie"
PL63."PL63 Pomorskie"
*
PT11."PT11 Norte"
PT15."PT15 Algarve"
PT16."PT16 Centro (PT)"
PT17."PT17 Área Metropolitana de Lisboa"
PT18."PT18 Alentejo"
*
RO11."RO11 Nord-Vest"
RO12."RO12 Centru"
RO21."RO21 Nord-Est"
RO22."RO22 Sud-Est"
RO31."RO31 Sud - Muntenia"
RO32."RO32 Bucuresti - Ilfov"
RO41."RO41 Sud-Vest Oltenia"
RO42."RO42 Vest"
*
SE11."SE11 Stockholm"
SE12."SE12 Oestra Mellansverige"
SE21."SE21 Småland med oearna"
SE22."SE22 Sydsverige"
SE23."SE23 Vaestsverige"
SE31."SE31 Norra Mellansverige"
SE32."SE32 Mellersta Norrland"
SE33."SE33 Oevre Norrland"
*
SI00."SI Slovenia"
*
SK01."SK01 Bratislavský kraj"
SK02."SK02 Západné Slovensko"
SK03."SK03 Stredné Slovensko"
SK04."SK04 Východné Slovensko"
*
UKC0."UKC NORTH EAST (ENGLAND)"
UKD0."UKD NORTH WEST (ENGLAND)"
UKE0."UKE YORKSHIRE AND THE HUMBER"
UKF0."UKF EAST MIDLANDS (ENGLAND)"
UKG0."UKG WEST MIDLANDS (ENGLAND)"
UKH0."UKH EAST OF ENGLAND"
UKI0."UKI London"
UKJ0."UKJ SOUTH EAST (ENGLAND)"
UKK0."UKK SOUTH WEST (ENGLAND)"
UKL0."UKL WALES"
UKM0."UKM SCOTLAND"
UKN0."UKN NORTHERN IRELAND"
/;




*and add the set for non-EU rest of the world:
Set NonEU_RestOfTheWorld(Regions);
NonEU_RestOfTheWorld(Regions) = Countries(Regions) - FAO_EuropeanUnion(Regions);


$ifthen %IncludeExcel_AdditionalCroplandAreaData_UNISECO% == "YES"
$call GDXXRW CroplandAreas_UNISECO.xlsx  o=CroplandAreas_UNISECO.gdx  index=index!a1
$endif;

$GDXIN CroplandAreas_UNISECO.gdx
$load CroplandArea_BioBamUNISECO
$GDXIN

*sum the NUTS2 regions to get the country values:
Set Match_Countries_NUTS2(Regions,Regions_2)
/
Austria    .#NUTS2_Austria
Belgium    .#NUTS2_Belgium
Bulgaria   .#NUTS2_Bulgaria
Switzerland.#NUTS2_Switzerland
Czechia    .#NUTS2_Czechia
Germany    .#NUTS2_Germany
Denmark    .#NUTS2_Denmark
Estonia    .#NUTS2_Estonia
Greece     .#NUTS2_Greece
Spain      .#NUTS2_Spain
Finland    .#NUTS2_Finland
France     .#NUTS2_France
Croatia    .#NUTS2_Croatia
Hungary    .#NUTS2_Hungary
Ireland    .#NUTS2_Ireland
Italy      .#NUTS2_Italia
Lithuania  .#NUTS2_Lithuania
Luxembourg .#NUTS2_Luxembourg
Latvia     .#NUTS2_Latvia
Netherlands.#NUTS2_Netherlands
Poland     .#NUTS2_Poland
Portugal   .#NUTS2_Portugal
Romania    .#NUTS2_Romania
Sweden     .#NUTS2_Sweden
Slovenia   .#NUTS2_Slovenia
Slovakia   .#NUTS2_Slovakia
"United Kingdom".#NUTS2_UK
/;

Set Match_Countries_NUTS2_SHORT(Regions,Regions_2)
/
Austria    .#NUTS2_SHORT_Austria
Belgium    .#NUTS2_SHORT_Belgium
Bulgaria   .#NUTS2_SHORT_Bulgaria
Switzerland.#NUTS2_SHORT_Switzerland
Czechia    .#NUTS2_SHORT_Czechia
Germany    .#NUTS2_SHORT_Germany
Denmark    .#NUTS2_SHORT_Denmark
Estonia    .#NUTS2_SHORT_Estonia
Greece     .#NUTS2_SHORT_Greece
Spain      .#NUTS2_SHORT_Spain
Finland    .#NUTS2_SHORT_Finland
France     .#NUTS2_SHORT_France
Croatia    .#NUTS2_SHORT_Croatia
Hungary    .#NUTS2_SHORT_Hungary
Ireland    .#NUTS2_SHORT_Ireland
Italy      .#NUTS2_SHORT_Italia
Lithuania  .#NUTS2_SHORT_Lithuania
Luxembourg .#NUTS2_SHORT_Luxembourg
Latvia     .#NUTS2_SHORT_Latvia
Netherlands.#NUTS2_SHORT_Netherlands
Poland     .#NUTS2_SHORT_Poland
Portugal   .#NUTS2_SHORT_Portugal
Romania    .#NUTS2_SHORT_Romania
Sweden     .#NUTS2_SHORT_Sweden
Slovenia   .#NUTS2_SHORT_Slovenia
Slovakia   .#NUTS2_SHORT_Slovakia
"United Kingdom".#NUTS2_SHORT_UK
/;

*UNITS: Mha - million hectares
CroplandArea_BioBamUNISECO(Countries,Scenarios,Activities)
                 $(NOT CroplandArea_BioBamUNISECO(Countries,Scenarios,Activities))
         =sum(Regions_2$Match_Countries_NUTS2(Countries,Regions_2),
                 CroplandArea_BioBamUNISECO(Regions_2,Scenarios,Activities));

*THEN assign to the SOLm parameters and variables as needed

*the new data does not contain data for cyprus and Malta, thus use a subset of EU only to not loose the original data for these countries:

*factor 1000000: convert to unit: hectares

VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities,"AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities,"AllProdSyst","AllProdCond",Scenarios))
         = CroplandArea_BioBamUNISECO(Countries,Scenarios,Activities)*1000000;


*now define a set that covers all remaining crops as ther are "other crops" in the data from BioBam UNISECO:
*do this by assigning it to Crops and then deleting all entries in the other subsets
*NO _ if we do it like this, some calculations go wrong (the single crop shares in crop groups are larger than 1 in some cases)
*thus use this calculation to easily identify the elements we want to have in this set, and then assign it directly, see below - then all shares are <=1 as they should be.
$ontext;
*alias(BioBamUNISECO_OtherCrops,Crops);

Set BioBamUNISECO_OtherCrops(Activities)
/
#Crops
/;

BioBamUNISECO_OtherCrops(Activities)$Cereals(Activities)=NO;
BioBamUNISECO_OtherCrops(Activities)$Fruits(Activities)=NO;
BioBamUNISECO_OtherCrops(Activities)$Treenuts(Activities)=NO;
BioBamUNISECO_OtherCrops(Activities)$Pulses(Activities)=NO;
BioBamUNISECO_OtherCrops(Activities)$OilCrops(Activities)=NO;
BioBamUNISECO_OtherCrops(Activities)$StarchyRoots(Activities)=NO;
BioBamUNISECO_OtherCrops(Activities)$SugarCrops(Activities)=NO;
BioBamUNISECO_OtherCrops(Activities)$Vegetables(Activities)=NO;
BioBamUNISECO_OtherCrops(Activities)$ForageCrops(Activities)=NO;
BioBamUNISECO_OtherCrops(Activities)$Fallows(Activities)=NO;
$offtext;

*$ontext;
Set BioBamUNISECO_OtherCrops(Activities)
/
"Agave fibres nes"
"Anise, badian, fennel, coriander"
"Bastfibres, other"
"Cassava leaves"
"Cinnamon (canella)"
"Cloves"
"Cocoa, beans"
"Coffee, green"
"Coir"
"Cotton lint"
"Cottonseed"
"Fibre crops nes"
"Flax fibre and tow"
"Ginger"
"Grain, mixed"
"Gums, natural"
"Hemp tow waste"
"Hops"
"Jute"
"Kapok fibre"
"Kapokseed in shell"
"Manila fibre (abaca)"
"Maté"
"Nutmeg, mace and cardamoms"
"Oil, palm"
"Palm kernels"
"Pepper (piper spp.)"
"Peppermint"
"Pyrethrum, dried"
"Ramie"
"Rubber, natural"
"Seed cotton"
"Sisal"
"Spices, nes"
"Tea"
"Tobacco, unmanufactured"
"Vanilla"
"Turnips for fodder"
"Swedes For Fodder"
"Vegetables+Roots,Fodder"
"Pure legume sward"
"Miscanthus"
"Other annual crops"
"Other permanent crops"
/;
*$offtext;


*in BioBam, temporary grassland is part of "All forage crops", hence define a corresponding set:
Set ForageCrops_BioBam(Activities) "Subset containing all forage crops for the BioBam UNISECO scenarios - i.e. INCLUDING temporary grasslands"
*forage crops: those crops that are harvested and then fully fed or used for silage, thus not leading to residues (besides roots); therefore, beets for fodder, etc. are not inlcuded,
*but are listed separately under other fodder crops.
/"Maize For Forage+Silage"
"Clover For Forage+Silage"
"Alfalfa For Forage+Silag"
"Leguminous Nes,For+Sil"
"Forage Products Nes"
"Beets For Fodder"
'Vetches'

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
"Cabbage, for forage"
"Carrots, for forage"
"Other grasses, for forage"
"Other oilseeds, for forage"
"Rye grass, for forage"
"Sorghum, for forage"

"Temporary meadows and pastures"
/;



Set Match_ActAggregates_SingleAct_BioBamUNISECO(Activities,Activities_2)
/
*"All animals".#Livestock

*"All Ruminants".#Ruminants
*"All Poultry".#Poultry
*MonogastricsNonPoultry
*"All Fish and Seafood".#FishAndSeafood
*"All NonRuminants".#NonRuminants

*"All crops".#Crops

*$ontext;
"All Cereals".#Cereals
"All Fruits".#Fruits
"All Nuts".#Treenuts
"Pulses,Total".#Pulses
*"All Legumes (Nfixing)".#Legumes_NFixing
*"All Crops without Legumes (Nfixing)".#Crops_NoNFixingLegumes
"All Oilcrops".#OilCrops
"All roots and tubers".#StarchyRoots
"All Sugar Crops".#SugarCrops
"All Vegetables".#Vegetables
*.#StimulantsSpices
*.#FibresRubber
*"Other Cereals".#OtherCereals
*"Citrus Fruits".#CitrusFruits
*"All spices".#Spices
*"All other vegetables".#OtherVegetables
*"All other oilcrops".#OtherOilcrops
*"All other soft fibres".#FibresNotCotton
*.#Fallows

*"All energy crops"                     .#EnergyCrops
"All forage crops - BioBam"             .#ForageCrops_BioBam
*"All other fodder crops"               .#OtherFodderCrops

"BioBam UNISECO OtherCrops"   .#BioBamUNISECO_OtherCrops

*"Core grass activities"                .#CoreGrassActivities

*"All crops and grass - NO temp grass"  .#CoreGrassActivitiesNoTEMPGrass
*"Temporary meadows and pastures"       .#TempMeadAndPastures
*"Temp. and perm. meadows and pastures" .#TempAndPermMeadAndPastures
*"All crops and grass"                  .#CropsAndCoreGrassActivities
/;

Set ActAggregates_BioBamUNISECO(Activities)
/
"All Cereals"
"All Fruits"
"All Nuts"
"Pulses,Total"
"All Oilcrops"
"All roots and tubers"
"All Sugar Crops"
"All Vegetables"
"All forage crops - BioBam"

"BioBam UNISECO OtherCrops"
/;

Set ActAggregates_NoForage_BioBamUNISECO(Activities)
/
"All Cereals"
"All Fruits"
"All Nuts"
"Pulses,Total"
"All Oilcrops"
"All roots and tubers"
"All Sugar Crops"
"All Vegetables"
*"All forage crops - BioBam"

"BioBam UNISECO OtherCrops"
/;


*we do the sum for FOFA_BAU_2050 into the BioBam UNISECO categories; to NOT loose the already available Forage crop category (and to only replace the others, as no single forage crops are reported for these scenarios) use a set without forage:
VActCropsGrass_QuantityActUnits_MR.l(Countries,ActAggregates_NoForage_BioBamUNISECO,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         =sum(Activities_2$Match_ActAggregates_SingleAct_BioBamUNISECO(ActAggregates_NoForage_BioBamUNISECO,Activities_2),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities_2,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Countries,ActAggregates_NoForage_BioBamUNISECO,"AllProdSyst","AllProdCond","FOFA_BAU_2012")
         =sum(Activities_2$Match_ActAggregates_SingleAct_BioBamUNISECO(ActAggregates_NoForage_BioBamUNISECO,Activities_2),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities_2,"AllProdSyst","AllProdCond","FOFA_BAU_2012"));
*for the baseline with forage, as this is available
VActCropsGrass_QuantityActUnits_MR.l(Countries,ActAggregates_BioBamUNISECO,"AllProdSyst","AllProdCond","Baseline")
         =sum(Activities_2$Match_ActAggregates_SingleAct_BioBamUNISECO(ActAggregates_BioBamUNISECO,Activities_2),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities_2,"AllProdSyst","AllProdCond","Baseline"));

*now we have the data in crop groups; so we assign it to single crops by using the shares of single crops in crop groups for the scenario FOFA_BAU_2012 and 2050
ActCropsGrass_OtherChar_MR(Countries,Activities_2,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = sum(ActAggregates_BioBamUNISECO$(Match_ActAggregates_SingleAct_BioBamUNISECO(ActAggregates_BioBamUNISECO,Activities_2) AND VActCropsGrass_QuantityActUnits_MR.l(Countries,ActAggregates_BioBamUNISECO,"AllProdSyst","AllProdCond","FOFA_BAU_2050")),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities_2,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Countries,ActAggregates_BioBamUNISECO,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));
ActCropsGrass_OtherChar_MR(Countries,Activities_2,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = sum(ActAggregates_BioBamUNISECO$(Match_ActAggregates_SingleAct_BioBamUNISECO(ActAggregates_BioBamUNISECO,Activities_2) AND VActCropsGrass_QuantityActUnits_MR.l(Countries,ActAggregates_BioBamUNISECO,"AllProdSyst","AllProdCond","FOFA_BAU_2012")),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities_2,"AllProdSyst","AllProdCond","FOFA_BAU_2012")
                         /VActCropsGrass_QuantityActUnits_MR.l(Countries,ActAggregates_BioBamUNISECO,"AllProdSyst","AllProdCond","FOFA_BAU_2012"));

*and for forage - single crops are available for the baseline only, thus derive it for this and then assign the same shares to the scenarios FOFA_BAU_2012 and 2050:
ActCropsGrass_OtherChar_MR(Countries,ForageCrops_BioBam,"Share single crop in crop group","AllProdSyst","AllProdCond","Baseline")
                 $VActCropsGrass_QuantityActUnits_MR.l(Countries,"All forage crops - BioBam","AllProdSyst","AllProdCond","Baseline")
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,ForageCrops_BioBam,"AllProdSyst","AllProdCond","Baseline")
                 /VActCropsGrass_QuantityActUnits_MR.l(Countries,"All forage crops - BioBam","AllProdSyst","AllProdCond","Baseline");
ActCropsGrass_OtherChar_MR(Countries,ForageCrops_BioBam,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = ActCropsGrass_OtherChar_MR(Countries,ForageCrops_BioBam,"Share single crop in crop group","AllProdSyst","AllProdCond","Baseline");
ActCropsGrass_OtherChar_MR(Countries,ForageCrops_BioBam,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActCropsGrass_OtherChar_MR(Countries,ForageCrops_BioBam,"Share single crop in crop group","AllProdSyst","AllProdCond","Baseline");

*now derive the single crop areas for all UNISECO scenarios by using the shares for FOFA_BAU_2050
VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities_2,"AllProdSyst","AllProdCond",ScenariosUNISECO)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities_2,"AllProdSyst","AllProdCond",ScenariosUNISECO))
         = sum(ActAggregates_BioBamUNISECO$Match_ActAggregates_SingleAct_BioBamUNISECO(ActAggregates_BioBamUNISECO,Activities_2),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,ActAggregates_BioBamUNISECO,"AllProdSyst","AllProdCond",ScenariosUNISECO)
                         *ActCropsGrass_OtherChar_MR(Countries,Activities_2,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2050"));
*and do it for FOFA_BAU_2012 and 2050 as well, where data is yet missing (forage crops):
VActCropsGrass_QuantityActUnits_MR.l(Countries,ForageCrops_BioBam,"AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"All forage crops - BioBam","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 *ActCropsGrass_OtherChar_MR(Countries,ForageCrops_BioBam,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2012");
VActCropsGrass_QuantityActUnits_MR.l(Countries,ForageCrops_BioBam,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"All forage crops - BioBam","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Countries,ForageCrops_BioBam,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2050");
*RoW does not have forage crop BioBam data in FOFA 2012 and 2050, thus use the Baseline there:
VActCropsGrass_QuantityActUnits_MR.l(Countries,ForageCrops_BioBam,"AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,ForageCrops_BioBam,"AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"All forage crops - BioBam","AllProdSyst","AllProdCond","Baseline")
                 *ActCropsGrass_OtherChar_MR(Countries,ForageCrops_BioBam,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2012");
VActCropsGrass_QuantityActUnits_MR.l(Countries,ForageCrops_BioBam,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,ForageCrops_BioBam,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"All forage crops - BioBam","AllProdSyst","AllProdCond","Baseline")
                 *ActCropsGrass_OtherChar_MR(Countries,ForageCrops_BioBam,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2050");
VActCropsGrass_QuantityActUnits_MR.l(Countries,ForageCrops_BioBam,"AllProdSyst","AllProdCond",ScenariosUNISECO)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,ForageCrops_BioBam,"AllProdSyst","AllProdCond",ScenariosUNISECO))
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"All forage crops - BioBam","AllProdSyst","AllProdCond","Baseline")
                 *ActCropsGrass_OtherChar_MR(Countries,ForageCrops_BioBam,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2050");




*BioBam scenarios for the RoW go along with large changes in areas harvested - so replace them again with the FOFA BAU 2050 values, as for the UNISECO scenarios, the RoW should not change, but only the EU;
*this changes in BioBam are owed to the internal model structure, i.e. that Biobam optimizes national crop produciton to meet demand, which cannot be swithed off for part of the regions only (RoW).
*for SOLm, we however need RoW to remain as it is - as it otherwise corrupts trade-flows linking the EU to RoW, and as only this reflects the scenarios correctly (which entail: no change outside the EU!).
VActCropsGrass_QuantityActUnits_MR.l(NonEU_RestOfTheWorld,Activities,"AllProdSyst","AllProdCond",ScenariosUNISECO)
         = VActCropsGrass_QuantityActUnits_MR.l(NonEU_RestOfTheWorld,Activities,"AllProdSyst","AllProdCond","FOFA_BAU_2050");


*finally, the Biobam areas are in area occupied, NOT area harvested - thus multiply with the cropping intensity to get the area harvested, which is the basic quantity for SOLm:
*for the BioBam-Scenarios, we use the CI-value from the BAU_2050:
*this has to be done for the EU plus Switzerland:
*Do not do it for crops where CI is missing, hence the condition
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Activities,"AllProdSyst","AllProdCond",ScenariosUNISECO)
                 $ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion,Activities,"Cropping intensity (ratio)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Activities,"AllProdSyst","AllProdCond",ScenariosUNISECO)
                 *ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion,Activities,"Cropping intensity (ratio)","AllProdSyst","AllProdCond","FOFA_BAU_2050");

*VActCropsGrass_QuantityActUnits_MR.l("Switzerland",Activities,"AllProdSyst","AllProdCond",ScenariosUNISECO)
*                 $ActCropsGrass_OtherChar_MR("Switzerland",Activities,"Cropping intensity (ratio)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
*         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland",Activities,"AllProdSyst","AllProdCond",ScenariosUNISECO)
*                 *ActCropsGrass_OtherChar_MR("Switzerland",Activities,"Cropping intensity (ratio)","AllProdSyst","AllProdCond","FOFA_BAU_2050");



*now we have the areas on single activity level for the 4 scenarios (plus anyway the FOFA BAU 2050 used as reference scenario there and also FOFA BAU 2012) in UNISECO


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Grassland area data from BioBam - Baseline 2012


PARAMETER GrasslandAreaEU_BioBamUNISECO(Activities,Regions)      "Grassland areas for the EU as used in the baseline in the UNISECO project";
*see the excel sheet read below for further details; this is input data to BioBam and is better quality and updated data with respect to the default data from Erb et al. 2007
*UNITS: Mha - million hectares
PARAMETER GrasslandAreaRoW_BioBamUNISECO(Activities,Regions)      "Grassland areas ro the Rest of the World as used in the baseline in the UNISECO project";
*see the excel sheet read below for further details; this is input data to BioBam and is better quality and updated data with respect to the default data from Erb et al. 2007
*UNITS: Mha - million hectares
PARAMETER GrasslandYieldsEU_BioBamUNISECO_AUX(Regions)      "Grassland areas for the EU as used in the baseline in the UNISECO project - auxiliary variable to file in the data without grassclass differentiation";
PARAMETER GrasslandYieldsEU_BioBamUNISECO(Activities,Regions)      "Grassland areas for the EU as used in the baseline in the UNISECO project";
PARAMETER GrasslandYieldsRoW_BioBamUNISECO(Activities,Regions)      "Grassland areas for the RoW as used in the baseline in the UNISECO project";
*see the excel sheet read below for further details; this is input data to BioBam and is better quality and updated data with respect to the default data from Erb et al. 2007
*there is NO differentiation for grass classes
*UNITS: tDM/ha

*biobam grassland areas for the various UNISECO scxenarios, unit: Mha, i.e. million hectares

Parameter BioBam_Grazingland_Mha_AeExp(Regions,*);
Parameter BioBam_Grazingland_Mha_BAU(Regions,*);
Parameter BioBam_Grazingland_Mha_LAESyst(Regions,*);
Parameter BioBam_Grazingland_Mha_LfP(Regions,*);
Parameter BioBam_Grazingland_Mha_LfS(Regions,*);

$ifthen %IncludeExcel_AdditionalGrasslandData_UNISECO% == "YES"
*the following file contains the baseline grassland area data
$call GDXXRW Input_GrazingAreasYieldsIntensity_BioBamUNISECO.xlsx  o=GrasslandData_UNISECO.gdx  index=index!a1
*the following files contain the grassland area data for the scenarios:
*it loads the files where dupliate entires have been removed.
*such were present for the region values "MALA", "MAUR", "NIGE", "REST", "REPU", "TURK" and "UNIT" - removing them is no problem, as these are not NUTS2 EU regions, which latter only are relevant as only data for them is used
$call csv2gdx Nuts_Landuse_Grazingland_Mha_Aeexp_DuplRemoved.csv id=BioBam_Grazingland_Mha_AeExp Index=(1) Values=(2,3,4) UseHeader=Y
$call csv2gdx Nuts_Landuse_Grazingland_Mha_BAU_DuplRemoved.csv id=BioBam_Grazingland_Mha_BAU Index=(1) Values=(2,3,4) UseHeader=Y
$call csv2gdx Nuts_Landuse_Grazingland_Mha_LAESyst_DuplRemoved.csv id=BioBam_Grazingland_Mha_LAESyst Index=(1) Values=(2,3,4) UseHeader=Y
$call csv2gdx Nuts_Landuse_Grazingland_Mha_LfP_DuplRemoved.csv id=BioBam_Grazingland_Mha_LfP Index=(1) Values=(2,3,4) UseHeader=Y
$call csv2gdx Nuts_Landuse_Grazingland_Mha_LfS_DuplRemoved.csv id=BioBam_Grazingland_Mha_LfS Index=(1) Values=(2,3,4) UseHeader=Y
$endif;

$GDXIN GrasslandData_UNISECO.gdx
$load GrasslandAreaEU_BioBamUNISECO
$load GrasslandAreaRoW_BioBamUNISECO
$load GrasslandYieldsEU_BioBamUNISECO_AUX
$load GrasslandYieldsRoW_BioBamUNISECO
$GDXIN

$gdxin Nuts_Landuse_Grazingland_Mha_AeExp_DuplRemoved
$load BioBam_Grazingland_Mha_AeExp
$gdxin
$gdxin Nuts_Landuse_Grazingland_Mha_BAU_DuplRemoved
$load BioBam_Grazingland_Mha_BAU
$gdxin
$gdxin Nuts_Landuse_Grazingland_Mha_LAESyst_DuplRemoved
$load BioBam_Grazingland_Mha_LAESyst
$gdxin
$gdxin Nuts_Landuse_Grazingland_Mha_LfP_DuplRemoved
$load BioBam_Grazingland_Mha_LfP
$gdxin
$gdxin Nuts_Landuse_Grazingland_Mha_LfS_DuplRemoved
$load BioBam_Grazingland_Mha_LfS
$gdxin

*UNITS: Mha - million hectares
*Sum NUTS2 levels to country values
GrasslandAreaEU_BioBamUNISECO(Activities,Countries)
                 $(NOT GrasslandAreaEU_BioBamUNISECO(Activities,Countries))
         =sum(Regions_2$Match_Countries_NUTS2(Countries,Regions_2),
                 GrasslandAreaEU_BioBamUNISECO(Activities,Regions_2));
GrasslandAreaEU_BioBamUNISECO(Activities,Countries)
                 $(NOT GrasslandAreaEU_BioBamUNISECO(Activities,Countries))
         =sum(Regions_2$Match_Countries_NUTS2(Countries,Regions_2),
                 GrasslandAreaEU_BioBamUNISECO(Activities,Regions_2));
*do weighted average for grassland yields for the EU
GrasslandYieldsEU_BioBamUNISECO(Activities,Countries)
                 $GrasslandAreaEU_BioBamUNISECO(Activities,Countries)
         =sum(Regions_2$Match_Countries_NUTS2(Countries,Regions_2),
                 GrasslandAreaEU_BioBamUNISECO(Activities,Regions_2)
                         *GrasslandYieldsEU_BioBamUNISECO_AUX(Regions_2))
                 /GrasslandAreaEU_BioBamUNISECO(Activities,Countries);
*assign regional values from RoW to single countries:
GrasslandYieldsRoW_BioBamUNISECO(Activities,Regions_2)
                 $(NOT GrasslandYieldsRoW_BioBamUNISECO(Activities,Regions_2))
         =sum(Regions$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 GrasslandYieldsRoW_BioBamUNISECO(Activities,Regions));

*Sum NUTS2 levels to country values for the alternative grassland area values for UNISECO scenarios:
*first assign new year-values to the respective dimension:
BioBam_Grazingland_Mha_AeExp(Regions,"2012")
         = BioBam_Grazingland_Mha_AeExp(Regions,"year2012");
BioBam_Grazingland_Mha_BAU(Regions,"2012")
         = BioBam_Grazingland_Mha_BAU(Regions,"year2012");
BioBam_Grazingland_Mha_LAESyst(Regions,"2012")
         = BioBam_Grazingland_Mha_LAESyst(Regions,"year2012");
BioBam_Grazingland_Mha_LfP(Regions,"2012")
         = BioBam_Grazingland_Mha_LfP(Regions,"year2012");
BioBam_Grazingland_Mha_LfS(Regions,"2012")
         = BioBam_Grazingland_Mha_LfS(Regions,"year2012");
BioBam_Grazingland_Mha_AeExp(Regions,"year2012") = 0;
BioBam_Grazingland_Mha_BAU(Regions,"year2012") = 0;
BioBam_Grazingland_Mha_LAESyst(Regions,"year2012") = 0;
BioBam_Grazingland_Mha_LfP(Regions,"year2012") = 0;
BioBam_Grazingland_Mha_LfS(Regions,"year2012") = 0;
BioBam_Grazingland_Mha_AeExp(Regions,"2030")
         = BioBam_Grazingland_Mha_AeExp(Regions,"year2030");
BioBam_Grazingland_Mha_BAU(Regions,"2030")
         = BioBam_Grazingland_Mha_BAU(Regions,"year2030");
BioBam_Grazingland_Mha_LAESyst(Regions,"2030")
         = BioBam_Grazingland_Mha_LAESyst(Regions,"year2030");
BioBam_Grazingland_Mha_LfP(Regions,"2030")
         = BioBam_Grazingland_Mha_LfP(Regions,"year2030");
BioBam_Grazingland_Mha_LfS(Regions,"2030")
         = BioBam_Grazingland_Mha_LfS(Regions,"year2030");
BioBam_Grazingland_Mha_AeExp(Regions,"year2030") = 0;
BioBam_Grazingland_Mha_BAU(Regions,"year2030") = 0;
BioBam_Grazingland_Mha_LAESyst(Regions,"year2030") = 0;
BioBam_Grazingland_Mha_LfP(Regions,"year2030") = 0;
BioBam_Grazingland_Mha_LfS(Regions,"year2030") = 0;
BioBam_Grazingland_Mha_AeExp(Regions,"2050")
         = BioBam_Grazingland_Mha_AeExp(Regions,"year2050");
BioBam_Grazingland_Mha_BAU(Regions,"2050")
         = BioBam_Grazingland_Mha_BAU(Regions,"year2050");
BioBam_Grazingland_Mha_LAESyst(Regions,"2050")
         = BioBam_Grazingland_Mha_LAESyst(Regions,"year2050");
BioBam_Grazingland_Mha_LfP(Regions,"2050")
         = BioBam_Grazingland_Mha_LfP(Regions,"year2050");
BioBam_Grazingland_Mha_LfS(Regions,"2050")
         = BioBam_Grazingland_Mha_LfS(Regions,"year2050");
BioBam_Grazingland_Mha_AeExp(Regions,"year2050") = 0;
BioBam_Grazingland_Mha_BAU(Regions,"year2050") = 0;
BioBam_Grazingland_Mha_LAESyst(Regions,"year2050") = 0;
BioBam_Grazingland_Mha_LfP(Regions,"year2050") = 0;
BioBam_Grazingland_Mha_LfS(Regions,"year2050") = 0;


BioBam_Grazingland_Mha_AeExp(Countries,Years)
         =sum(Regions$Match_Countries_NUTS2_SHORT(Countries,Regions),
                 BioBam_Grazingland_Mha_AeExp(Regions,Years));
BioBam_Grazingland_Mha_BAU(Countries,Years)
         =sum(Regions$Match_Countries_NUTS2_SHORT(Countries,Regions),
                 BioBam_Grazingland_Mha_BAU(Regions,Years));
BioBam_Grazingland_Mha_LAESyst(Countries,Years)
         =sum(Regions$Match_Countries_NUTS2_SHORT(Countries,Regions),
                 BioBam_Grazingland_Mha_LAESyst(Regions,Years));
BioBam_Grazingland_Mha_LfP(Countries,Years)
         =sum(Regions$Match_Countries_NUTS2_SHORT(Countries,Regions),
                 BioBam_Grazingland_Mha_LfP(Regions,Years));
BioBam_Grazingland_Mha_LfS(Countries,Years)
         =sum(Regions$Match_Countries_NUTS2_SHORT(Countries,Regions),
                 BioBam_Grazingland_Mha_LfS(Regions,Years));


*THEN assign to the SOLm parameters and variables as needed
*factor 1000000: convert to unit: hectares
*assign this data to the baseline FOFA_BAU_2012 to not loose the FAO-default at this point of time.

VActCropsGrass_QuantityActUnits_MR.l(Countries,GrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,GrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         = GrasslandAreaEU_BioBamUNISECO(GrassActivities,Countries)*1000000;
VActCropsGrass_QuantityActUnits_MR.l(Countries,GrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,GrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         = GrasslandAreaRoW_BioBamUNISECO(GrassActivities,Countries)*1000000;
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(NOT ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         = GrasslandYieldsEU_BioBamUNISECO(GrassActivities,Countries);
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(NOT ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         = GrasslandYieldsRoW_BioBamUNISECO(GrassActivities,Countries);



SET GrassClasses(Activities)
/
Grassclass1
Grassclass2
Grassclass3
Grassclass4
/;

*assign areas and yields to temporary and permanent grasslands:
*the grassland data is only permanent - but use class1 yields for temporary grasslands
*temporary grassland areas are already covered under "All forage crops  BioBam" above
VActCropsGrass_QuantityActUnits_MR.l(Countries,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass1","AllProdSyst","AllProdCond","FOFA_BAU_2012")
          +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass2","AllProdSyst","AllProdCond","FOFA_BAU_2012")
          +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass3","AllProdSyst","AllProdCond","FOFA_BAU_2012")
          +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass4","AllProdSyst","AllProdCond","FOFA_BAU_2012");




VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Permanent meadows and pastures","AllProdSyst","AllProdCond","LfP_2050")
         = BioBam_Grazingland_Mha_LfP(FAO_EuropeanUnion,"2050")*1000000;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Permanent meadows and pastures","AllProdSyst","AllProdCond","AE_Exports_2050")
         = BioBam_Grazingland_Mha_AeExp(FAO_EuropeanUnion,"2050")*1000000;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Permanent meadows and pastures","AllProdSyst","AllProdCond","LfS_2050")
         = BioBam_Grazingland_Mha_LfS(FAO_EuropeanUnion,"2050")*1000000;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Permanent meadows and pastures","AllProdSyst","AllProdCond","AE_Food_2050")
         = BioBam_Grazingland_Mha_LAESyst(FAO_EuropeanUnion,"2050")*1000000;

*if permanent grassland area data is still missing assign it from the baseline to 2012; this is then used as a basis for FOFA_BAU_2050 in the scenario definition, ad from this to the UNISECO scenarios, hence no need to do it here:
VActCropsGrass_QuantityActUnits_MR.l(Countries,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"Permanent meadows and pastures","AllProdSyst","AllProdCond","Baseline");



*now do grassland yields: for RoW, the yields are available; but for the EU, it is NPPact, and what is yields in SOLm is derived by the BioBam grazing intensity:
*this is given in sheet GImax from the original file Input data grazing areas, GImax, NPPact for ROW 2020-02-14.xlsx, as of 7.10.2020, it has global values only, one per grass class:
*Class1 0.7; 2: 0.55; 3: 0.4; 4: 0.2, thus:
ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Grassclass1","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Grassclass1","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.7;
ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Grassclass2","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Grassclass2","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.55;
ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Grassclass3","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Grassclass3","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.4;
ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Grassclass4","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Grassclass4","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.2;

*then assign to the SOLm grass activities:
*temporary is grassclass 1; permanent is the area-weighted mean of the 4 classes
ActCropsGrass_Outputs_MR(Countries,"Temporary meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActCropsGrass_Outputs_MR(Countries,"Grassclass1","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012");

ActCropsGrass_Outputs_MR(Countries,"Permanent meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $VActCropsGrass_QuantityActUnits_MR.l(Countries,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = (ActCropsGrass_Outputs_MR(Countries,"Grassclass1","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass1","AllProdSyst","AllProdCond","FOFA_BAU_2012")
          +ActCropsGrass_Outputs_MR(Countries,"Grassclass2","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass2","AllProdSyst","AllProdCond","FOFA_BAU_2012")
          +ActCropsGrass_Outputs_MR(Countries,"Grassclass3","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass3","AllProdSyst","AllProdCond","FOFA_BAU_2012")
          +ActCropsGrass_Outputs_MR(Countries,"Grassclass4","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass4","AllProdSyst","AllProdCond","FOFA_BAU_2012"))
          /VActCropsGrass_QuantityActUnits_MR.l(Countries,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012");

*for some countries, e.g. Switzerland, no areas are reported for the grass classes,
*there, assign Grassclass 3 to permanet meadows and pastures:
ActCropsGrass_Outputs_MR(Countries,"Permanent meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(NOT ActCropsGrass_Outputs_MR(Countries,"Permanent meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         = ActCropsGrass_Outputs_MR(Countries,"Grassclass3","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012");

*derive fresh matter grassland yields:
ActCropsGrass_Outputs_MR(Countries,"Permanent meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $Commod_Contents_MR(Countries,"Permanent meadows and pastures","DM (t)","AllProdSyst","AllProdCond","Baseline")
         = ActCropsGrass_Outputs_MR(Countries,"Permanent meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 /Commod_Contents_MR(Countries,"Permanent meadows and pastures","DM (t)","AllProdSyst","AllProdCond","Baseline");

ActCropsGrass_Outputs_MR(Countries,"Temporary meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $Commod_Contents_MR(Countries,"Temporary meadows and pastures","DM (t)","AllProdSyst","AllProdCond","Baseline")
         = ActCropsGrass_Outputs_MR(Countries,"Temporary meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 /Commod_Contents_MR(Countries,"Temporary meadows and pastures","DM (t)","AllProdSyst","AllProdCond","Baseline");



*the following is not correct anymore for the EU, as these GI-values are already used to derive the yields,
*THUS: s/d-ratio is now to be defined as 1 for the EU, for roW, the following still holds:

*NO NO NEED TO DERIVE THE s/d-ratio - as it is determined for FOFA_BAU_2012 and _2050 based on animal numbers and the grass supply - so do not execute the following here!!
$ontext;

*also use the supply/demand ratio from BioBam: this is the INVERSE of their grazing intensity:
*this is given in sheet GImax from the original file Input data grazing areas, GImax, NPPact for ROW 2020-02-14.xlsx, as of 7.10.2020, it has global values only, one per grass class:
*Class1 0.7; 2: 0.55; 3: 0.4; 4: 0.2, thus:
Commod_OtherChar_MR(Countries,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"Temporary meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.7
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass1","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.7
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass2","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.55
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass3","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.4
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass4","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.2)
*areas for temporary meadows are taken from forage crop areas - but the suply/demand ratio is the same as for grassclass1
         = (VActCropsGrass_QuantityActUnits_MR.l(Countries,"Temporary meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                         + VActCropsGrass_QuantityActUnits_MR.l(Countries,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012"))
          /(VActCropsGrass_QuantityActUnits_MR.l(Countries,"Temporary meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.7
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass1","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.7
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass2","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.55
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass3","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.4
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass4","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.2);
*for the grass activities separately:
Commod_OtherChar_MR(Countries,"Temporary meadows and pastures","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $VActCropsGrass_QuantityActUnits_MR.l(Countries,"Temporary meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         =1/0.7;
Commod_OtherChar_MR(Countries,"Permanent meadows and pastures","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass1","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.7
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass2","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.55
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass3","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.4
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass4","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.2)
         = (VActCropsGrass_QuantityActUnits_MR.l(Countries,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012"))
          /(VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass1","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.7
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass2","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.55
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass3","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.4
           +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grassclass4","AllProdSyst","AllProdCond","FOFA_BAU_2012")*0.2);

Commod_OtherChar_MR(FAO_EuropeanUnion,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                         +VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         =1;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Temporary meadows and pastures","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         =1;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Permanent meadows and pastures","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         =1;

$offtext;

*drop the data that has been used to file this in:
VActCropsGrass_QuantityActUnits_MR.l(Regions,GrassClasses,"AllProdSyst","AllProdCond","FOFA_BAU_2012") = 0;
ActCropsGrass_Outputs_MR(Regions,GrassClasses,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012") = 0;



$ontext;
*as the UNISECO BioBam yield data is so different from our Baseline, do not use it but use the baseline values, also for the s/d ratio:
ActCropsGrass_Outputs_MR(Countries,"Temporary meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActCropsGrass_Outputs_MR(Countries,"Temporary meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond","Baseline");
ActCropsGrass_Outputs_MR(Countries,"Permanent meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActCropsGrass_Outputs_MR(Countries,"Permanent meadows and pastures","MainOutput1 (t DM)","AllProdSyst","AllProdCond","Baseline");
ActCropsGrass_Outputs_MR(Countries,"Temporary meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActCropsGrass_Outputs_MR(Countries,"Temporary meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond","Baseline");
ActCropsGrass_Outputs_MR(Countries,"Permanent meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = ActCropsGrass_Outputs_MR(Countries,"Permanent meadows and pastures","MainOutput1 (t)","AllProdSyst","AllProdCond","Baseline");


Commod_OtherChar_MR(Countries,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = Commod_OtherChar_MR(Countries,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","Baseline");
Commod_OtherChar_MR(Countries,"Temporary meadows and pastures","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = Commod_OtherChar_MR(Countries,"Temporary meadows and pastures","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","Baseline");
Commod_OtherChar_MR(Countries,"Permanent meadows and pastures","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         = Commod_OtherChar_MR(Countries,"Permanent meadows and pastures","Feed DM supply/demand ratio","AllProdSyst","AllProdCond","Baseline");
$offtext;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) FCR data from BioBam - all core scenarios for UNISECO

PARAMETER FCR_Baseline2012_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions)  "FCR data for the UNISECO baseline 2012";
PARAMETER FCR_BAU_2050_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions)  "FCR data for the UNISECO scenario BAU 2050";
PARAMETER FCR_local_for_protect_2050_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions)  "FCR data for the UNISECO scenario local for protection 2050";
PARAMETER FCR_AE_for_exports_2050_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions)  "FCR data for the UNISECO scenario AE for exports 2050";
PARAMETER FCR_local_for_sustain_2050_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions)  "FCR data for the UNISECO scenario local for sustainability 2050";
PARAMETER FCR_local_AE_food_2050_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions)  "FCR data for the UNISECO scenario AE for food 2050";

*UNITS: tDM/tDM
*the data is feed conversion rates (FCR) - so the ratio of feed DM inputs to food product DM output
*in SOLm, we use this to derive feeding rations, i.e. shares of commodities in total feed uptake: this equals the relative shares of the FCR components
$ifthen %IncludeExcel_AdditionalFCRData_UNISECO% == "YES"
$call GDXXRW Input_FCR_2012_2050_BioBamUNISECO.xlsx  o=FCRData_UNISECO.gdx  index=index!a1
$endif;

$GDXIN FCRData_UNISECO.gdx
$load FCR_Baseline2012_BioBamUNISECO
$load FCR_BAU_2050_BioBamUNISECO
$load FCR_local_for_protect_2050_BioBamUNISECO
$load FCR_AE_for_exports_2050_BioBamUNISECO
$load FCR_local_for_sustain_2050_BioBamUNISECO
$load FCR_local_AE_food_2050_BioBamUNISECO
$GDXIN

*make the scenario an additional dimension:
PARAMETER FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions,Scenarios)  "FCR data for all the UNISECO scenarios";

FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions,"FOFA_BAU_2012")
         = FCR_Baseline2012_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions);

FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions,"FOFA_BAU_2050")
         = FCR_BAU_2050_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions);

FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions,"LfP_2050")
         = FCR_local_for_protect_2050_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions);

FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions,"AE_exports_2050")
         = FCR_AE_for_exports_2050_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions);

FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions,"LfS_2050")
         = FCR_local_for_sustain_2050_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions);

FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions,"AE_food_2050")
         = FCR_local_AE_food_2050_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions);

*for some regions, there is data for meat producing sheep and goats, but not for milk producing; as we do averages of those later on, as SOLm does not have a herd structure for those,
*we add these missing values here identical to the corresponding values for meat producing animals; this is governed by values for grass not being available - as any FCR for sheep and goats has an entry for grass (but this may differ regarding other commodity groups).
*this is then not correct in absolute terms, as the meat and mulk output differ in quantities - but we only need the relative shares of the feed groups and hence it is ok to assign it like this.
FCR_Scenarios_BioBamUNISECO("Sheep","Milk producing",Commodities,Regions,Scenarios)
                 $(NOT FCR_Scenarios_BioBamUNISECO("Sheep","Milk producing","AggregateFeedGrass_Commodity",Regions,Scenarios))
         = FCR_Scenarios_BioBamUNISECO("Sheep","Meat producing",Commodities,Regions,Scenarios);

*We need feeding rations on country level - but have FCR on NUTS2 level; thus sum over the NUTS2 levels per country, then you get the FCR as DM inputs per #Nuts2PerCountry*DM Output,
*        thus, this sum has then to be devided to get the FCR on country level
*after this, we have to sum the FCRs and then to devied the single commodity components in the FCR by the total - this then gives the feeding rations

*Sum NUTS2 levels to country values

*count the NUTS2 regions per country
*and put them into the inverse of this value, as we need to divide by this number in our calculations
PARAMETER PerCountryNUTS2RegionsCount(Regions) An auxiliary variable used to count the NUTS2 regions in a country;
PARAMETER Inverse_PerCountryNUTS2RegionsCount(Regions) An auxiliary variable used to count the NUTS2 regions in a country - used in the inverse form;
PerCountryNUTS2RegionsCount(Countries)
         = sum(Regions$Match_Countries_NUTS2(Countries,Regions),1);
Inverse_PerCountryNUTS2RegionsCount(Countries)
                         $PerCountryNUTS2RegionsCount(Countries)
                 =1/PerCountryNUTS2RegionsCount(Countries);

FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Countries,Scenarios)
                 $(NOT FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Countries,Scenarios))
         =sum(Regions_2$Match_Countries_NUTS2(Countries,Regions_2),
                 FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions_2,Scenarios))
                         *Inverse_PerCountryNUTS2RegionsCount(Countries);

PARAMETER FeedingRations_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions,Scenarios)  "Feeding ration data for the UNISECO scenarios";

FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,"AggregateFeedTotal_Commodity",Countries,Scenarios)
         =sum(commodities,FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Countries,Scenarios));

FeedingRations_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Countries,Scenarios)
                 $FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,"AggregateFeedTotal_Commodity",Countries,Scenarios)
         = FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Countries,Scenarios)
                 /FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,"AggregateFeedTotal_Commodity",Countries,Scenarios);

*assign goats identical to sheep (see original data: Sheep and goats):
FeedingRations_Scenarios_BioBamUNISECO("Goats",AnimalTypeInHerd,Commodities,Countries,Scenarios)
         = FeedingRations_Scenarios_BioBamUNISECO("Sheep",AnimalTypeInHerd,Commodities,Countries,Scenarios);


*THEN assign to the SOLm parameters and variables as needed
FeedingRationsHeads_OtherChar_MR(Countries,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT FeedingRationsHeads_OtherChar_MR(Countries,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios))
         = FeedingRations_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Countries,Scenarios);

FeedingRationsHeads_OtherChar_MR(Countries,"Cattle",DairyCattleTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = FeedingRationsHeads_OtherChar_MR(Countries,"Cattle","Milk Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios);
FeedingRationsHeads_OtherChar_MR(Countries,"Cattle",BeefCattleTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = FeedingRationsHeads_OtherChar_MR(Countries,"Cattle","Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios);
FeedingRationsHeads_OtherChar_MR(Countries,"Pigs",PigTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = FeedingRationsHeads_OtherChar_MR(Countries,"Pigs","Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios);
*for a first grasp, just take the average for the animals without herd structure but with feeding rations for different products:
FeedingRationsHeads_OtherChar_MR(Countries,"Chickens","AllAndAverageTypes",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = (FeedingRationsHeads_OtherChar_MR(Countries,"Chickens","Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
                 + FeedingRationsHeads_OtherChar_MR(Countries,"Chickens","Egg Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios))/2;
FeedingRationsHeads_OtherChar_MR(Countries,"Sheep","AllAndAverageTypes",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = (FeedingRationsHeads_OtherChar_MR(Countries,"Sheep","Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
                 + FeedingRationsHeads_OtherChar_MR(Countries,"Sheep","Milk Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios))/2;
FeedingRationsHeads_OtherChar_MR(Countries,"Goats","AllAndAverageTypes",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = (FeedingRationsHeads_OtherChar_MR(Countries,"Goats","Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
                 + FeedingRationsHeads_OtherChar_MR(Countries,"Goats","Milk Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios))/2;

*drop the values for meat/milk/egg producing animals as they are not used anymore:
FeedingRationsHeads_OtherChar_MR(Countries,Activities,"Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios) = 0;
FeedingRationsHeads_OtherChar_MR(Countries,Activities,"Milk Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios) = 0;
FeedingRationsHeads_OtherChar_MR(Countries,Activities,"Egg Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios) = 0;


*in this module, we read new Feeding ration data - this has consequences on the parameter FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"):
*if the share of a commodity goes down in a feeding ration, it is assumed that the "Quantity share in total feed req of all animals" for this commodity and animal also goes down and that it goes up correspondingly for the other animals:



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) NUTS2-level preparations for the data to be used in the UNISECO-SESSIT-tool

*these calculations involve a number of time-consuming matching exercises - thus execute only if needed

*the following is for line 3855, but the definitions already need to be done here, cf. following explanations.
*now assign the NUTS2 data to new parameters and variables to store them separately and read from there if not calculated anew.
*new parameters and variables are needed to not overwrite other data when reading the already calculated values
*they need to be assigned BEFORE this part, as they need to be available also in case OLD calculations are used, i.e. code AFTER $label UseOldSESSITData
*thus, they are defined already above in line 2575 before $goto UseOldSESSITData
Parameter AUXNUTS2_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios);
Parameter AUXNUTS2_ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
Parameter AUXNUTS2_ActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
Parameter AUXNUTS2_ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
Parameter AUXNUTS2_ActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
Parameter AUXNUTS2_ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
Variable AUXNUTS2_VActCropsGrass_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios);

*similar for trhe following, lines 3336 and 3352
*the following needs to be assigned BEFORE this part, as it needs to be available also in case OLD calculations are used, i.e. code AFTER $label UseOldSESSITData
*thus, it is defined already above in line 2575 before $goto UseOldSESSITData
Parameter AUX2_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios) an auxiliary parameter - AUX2 as later AUX_.... is already defined and used;
Parameter AnimalProdData_BioBamUNISECO(Regions,Activities,OutputsAnimals,Scenarios);


$if %DoUNISECO_SESSIT_NUTS2_Calculations% == "NO" $goto UseOldSESSITData


PUTCLOSE con "   NUTS2 calcs 1:" timeElapsed;


*For SESSIT:
*we need the feeding rations on NUTS2 level:
*first do the sum over commodities for NUTS2 regions, as this is only done for countries already:
FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,"AggregateFeedTotal_Commodity",NUTS2_Regions,Scenarios)
                 $(NOT FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,"AggregateFeedTotal_Commodity",NUTS2_Regions,Scenarios))
         =sum(commodities,FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,NUTS2_Regions,Scenarios));
*then derive the feeding rations:
FeedingRations_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions,Scenarios)
                 $FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,"AggregateFeedTotal_Commodity",Regions,Scenarios)
         = FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,Regions,Scenarios)
                 /FCR_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,"AggregateFeedTotal_Commodity",Regions,Scenarios);

*assign goats identical to sheep (see original data: Sheep and goats):
FeedingRations_Scenarios_BioBamUNISECO("Goats",AnimalTypeInHerd,Commodities,NUTS2_Regions,Scenarios)
         = FeedingRations_Scenarios_BioBamUNISECO("Sheep",AnimalTypeInHerd,Commodities,NUTS2_Regions,Scenarios);


*THEN assign to the SOLm parameters and variables as needed
FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios))
         = FeedingRations_Scenarios_BioBamUNISECO(Activities,AnimalTypeInHerd,Commodities,NUTS2_Regions,Scenarios);

FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Cattle",DairyCattleTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Cattle","Milk Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios);
FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Cattle",BeefCattleTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Cattle","Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios);
FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Pigs",PigTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Pigs","Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios);
*for a first grasp, just take the average for the animals without herd structure but with feeding rations for different products:
FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Chickens","AllAndAverageTypes",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = (FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Chickens","Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
                 + FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Chickens","Egg Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios))/2;
FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Sheep","AllAndAverageTypes",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = (FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Sheep","Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
                 + FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Sheep","Milk Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios))/2;
FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Goats","AllAndAverageTypes",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
         = (FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Goats","Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
                 + FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,"Goats","Milk Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios))/2;

*drop the values for meat/milk/egg producing animals as they are not used anymore:
FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,Activities,"Meat Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios) = 0;
FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,Activities,"Milk Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios) = 0;
FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,Activities,"Egg Producing",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios) = 0;

*so assign the ruminant welfare intensity indicator:
*ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants",ProductionSystems,ProductionConditions,Scenarios)
*params to be used:
*         take from BioBam: sum of non-grass (i.e. conc and forage) in feeding rations
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants","AllProdSyst","AllProdCond",Scenarios)
         = FeedingRationsHeads_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
                 + FeedingRationsHeads_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedOilCropsAndCakes_Commodity","Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
                 + FeedingRationsHeads_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedPulses_Commodity","Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios)
                 + FeedingRationsHeads_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedSugar_Commodity","Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios);
*and the chicken egg welfare intensity indicator:
*ActAnimalsHead_OtherChar_MR(Regions,Poultry,AnimalTypeInHerd,"Animal welfare: production intensity index - eggs",ProductionSystems,ProductionConditions,Scenarios)
*params to be used:
*         take from BioBam: egg yield: i.e. FCR for eggs - the more eggs per feed the more intensive
ActAnimalsHead_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Animal welfare: production intensity index - eggs","AllProdSyst","AllProdCond",Scenarios)
                 $FCR_Scenarios_BioBamUNISECO("Chickens","Egg Producing","AggregateFeedTotal_Commodity",Regions,Scenarios)
         = 1/FCR_Scenarios_BioBamUNISECO("Chickens","Egg Producing","AggregateFeedTotal_Commodity",Regions,Scenarios);



*then we have the following two on NUTS2 level:
*ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants","AllProdSyst","AllProdCond",Scenarios)
*ActAnimalsHead_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Animal welfare: production intensity index - eggs","AllProdSyst","AllProdCond",Scenarios)

*then go on:

*ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios)
*ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2020",ProductionSystems,ProductionConditions,Scenarios)
*ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2030",ProductionSystems,ProductionConditions,Scenarios)
*ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2050",ProductionSystems,ProductionConditions,Scenarios)
*params to be used:
*         awr_components(RegionCodes_awr,"mr")
*         awr_components(RegionCodes_awr,"hwd1")
*         awr_components(RegionCodes_awr,"hwd2")
*         awr_components(RegionCodes_awr,"hwd3")
*ALL THESE: are currently available on NUTS2 level (see Test_SESSIT)  - But for BASELINE only - same value for all scenarios, then scaled with animal numbers and ANTIBIOTICS also adapted by organic share



*Country level only:
*ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"IrrigW per t MOutput1 (m3) - total demand",ProductionSystems,ProductionConditions)
*ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.",ProductionSystems,ProductionConditions)
*ActAnimalsHead_OtherChar_MR(Regions,Activities,"AllAndAverageTypes","Animal welfare: transport volume index",ProductionSystems,ProductionConditions,Scenarios)
*ActCropsGrass_Inputs_MR(Regions,Activities,"Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios)
*ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,"Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios)
*         Country level only (to be adjusted via total labour use on country level)
*ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,ProductionConditions,Scenarios)
*         XXXXXXXXXXX TRY TO SOMEHOW DERIVE THIS ON NUTS2 as well!!!!!!!!
*ALL THESE: are available on country level in the correct form after all calculations!!


*NUTS2 level:
*ActCropsGrass_Inputs_MR(Regions,Activities,"Green Water Footprint (m3)",ProductionSystems,ProductionConditions,Scenarios)
*ActCropsGrass_Inputs_MR(Regions,Activities,"Blue Water Footprint (m3)",ProductionSystems,ProductionConditions,Scenarios)
*ActCropsGrass_Inputs_MR(Regions,Activities,"Grey Water Footprint (m3)",ProductionSystems,ProductionConditions,Scenarios)
*params to be used:
*         WF_WaterUseActivities(CommoditiesEquivalentActivities,WF_Activity,"Green",WF_Country,WF_ProvinceState)
*         WF_WaterUseActivities(CommoditiesEquivalentActivities,WF_Activity,"Blue",WF_Country,WF_ProvinceState)
*                  *For forage: use country level PFister data         = ActCropsGrass_OtherChar(Regions,Activities,"IrrigW per t MOutput1 (m3) - total demand","AllProdSyst","AllProdCond");
*         WF_WaterUseActivities(CommoditiesEquivalentActivities,WF_Activity,"Grey",WF_Country,WF_ProvinceState)



PUTCLOSE con "   NUTS2 calcs 2:" timeElapsed;


$onmulti;
Set Regions
/
#WF_ProvinceState
/
;
$offmulti;

*assign the WFPs at region level:
Parameter WF_WaterUseActivitiesForRegions(WF_Commodity,WF_Activity,WF_WaterUseType,WF_Country,*);
WF_WaterUseActivitiesForRegions(CommoditiesEquivalentActivities,WF_Activity,WF_WaterUseType,WF_Country,WF_ProvinceState)
         = WF_WaterUseActivities(CommoditiesEquivalentActivities,WF_Activity,WF_WaterUseType,WF_Country,WF_ProvinceState);

SET WFP_UNISECO_Regions(Regions)
/
'Burgenland'
'Niederosterreich'
'Wien'
'Karnten'
'Steiermark'
'Oberosterreich'
'Salzburg'
'Tirol'
'Vorarlberg'
'Brussels Hoofdstedelijk Gewest'
'Antwerpen'
'Limburg'
'Oost-Vlaanderen'
'Brabant Wallon'
'West-Vlaanderen'
*'Brabant Wallon'
'Hainaut'
'Liege'
'Luxembourg'
'Namur'
'Lovech'
'Razgrad'
'Varna'
'Burgas'
'Sofiya'
'Plovdiv'
'CNTRY-average'
'Benesov'
*'Benesov'
'Ceske Budejovice'
'Cheb'
*'Benesov'
'Brno'
'Breclav'
'Bruntal'
*'CNTRY-average'
*'CNTRY-average'
'Oulun Laani'
'Hame'
'Vaasa'
'Pohjois-Karjala'
'Uusimaa'
'Ile-de-France'
'Champagne-Ardenne'
'Picardie'
'Haute-Normandie'
'Centre'
'Basse-Normandie'
'Bourgogne'
'Nord-Pas-de-Calais'
'Lorraine'
'Alsace'
'Franche-Comte'
'Pays de la Loire'
'Bretagne'
'Poitou-Charentes'
'Aquitaine'
'Midi-Pyrenees'
'Limousin'
'Rhone-Alpes'
'Auvergne'
'Languedoc-Roussillon'
"Provence-Alpes-Cote d'Azur"
'Corse'
'Baden-Wurttemberg'
*'Baden-Wurttemberg'
*'Baden-Wurttemberg'
*'Baden-Wurttemberg'
*'CNTRY-average'
*'CNTRY-average'
*'CNTRY-average'
*'CNTRY-average'
*'CNTRY-average'
*'CNTRY-average'
*'CNTRY-average'
'Berlin'
'Brandenburg'
'Bremen'
'Hamburg'
'Hessen'
*'Hessen'
*'Hessen'
'Mecklenburg-Vorpommern'
'Niedersachsen'
*'Niedersachsen'
*'Niedersachsen'
*'Niedersachsen'
'Nordrhein-Westfalen'
*'Nordrhein-Westfalen'
*'Nordrhein-Westfalen'
*'Nordrhein-Westfalen'
*'Nordrhein-Westfalen'
'Rheinland-Pfalz'
*'Rheinland-Pfalz'
*'Rheinland-Pfalz'
'Saarland'
'Sachsen'
'Sachsen-Anhalt'
'Schleswig-Holstein'
'Thuringen'
'Xanthi'
'Thessaloniki'
'Kozani'
'Larisa'
'Thesprotia'
'Zakinthos'
'Aitolia kai Akarnania'
'Fthiotis'
'Arkadhia'
'Attiki'
'Lesvos'
'Kikladhes'
'Iraklion'
'Pest'
'Fejer'
'Vas'
'Tolna'
'Borsod-Abauj-Zemplen'
'Hajdu-Bihar'
'Csongrad'
'Mayo'
'Cork'
'Piemonte'
"Valle d'Aosta"
'Emilia-Romagna'
'Lombardia'
'Abruzzi'
'Molise'
'Campania'
'Puglia'
'Basilicata'
'Calabria'
'Sicilia'
'Sardegna'
'Trentino-Alto Adige'
'Veneto'
'Friuli-Venezia Giulia'
*'Emilia-Romagna'
'Toscana'
'Umbria'
'Marche'
'Lazio'
*'CNTRY-average'
*'CNTRY-average'
*'CNTRY-average'
'Groningen'
'Friesland'
'Drenthe'
'Overijssel'
'Gelderland'
'Flevoland'
'Utrecht'
'Noord-Holland'
'Zuid-Holland'
'Zeeland'
'Noord-Brabant'
'Limburg'
'Piotrkow'
'Ostroleka'
'Krakow'
'Bielsko'
'Lublin'
'Rzeszow'
'Kielce'
'Bialystok'
'Poznan'
'Koszalin'
'Zielona Gora'
'Jelenia Gora'
'Opole'
'Bydgoszcz'
'Olsztyn'
'Gdansk'
'Vila Real'
'Faro'
'Coimbra'
'Lisboa'
'Evora'
'Salaj'
'Sibiu'
'Iasi'
'Tulcea'
'Teleorman'
'Bucuresti'
'Dolj'
'Timis'
'Bratislava'
'Zapadoslovensky'
'Zilinsky'
*'Zilinsky'
*'CNTRY-average'
'Galicia'
'Asturias'
'Cantabria'
'Pais Vasco'
'Navarra'
'La Rioja'
'Aragon'
'Madrid'
'Castilla Y Leon'
'Castilla-La Mancha'
'Extremadura'
'Cataluna'
'Valenciana'
'Islas Baleares'
'Andalucia'
'Murcia'
'Stockholms Lan'
'Sodermanlands Lan'
'Jonkopings Lan'
'Blekinge Lan'
'Hallands Lan'
'Varmlands Lan'
'Vasternorrlands Lan'
*'Vasternorrlands Lan'
'Vaud'
'Aargau'
'Basel-Landschaft'
'Zurich'
'Graubunden'
'Nidwalden'
'Ticino'
'Northumberland'
'Lancaster'
'North Yorkshire'
'Leicester'
'West Midlands'
'Norfolk'
'Greater London'
'Surrey'
'Devon'
*'Devon'
*'Northumberland'
'Armagh'
/;


*set to match the WFP regions to UNISECO regions (NUTS2)
SET MatchRegions_WFP_NUTS2UNISECO(WF_Country,Regions,Regions_2)
/
'Austria'.'Burgenland'.'AT11 Burgenland'
'Austria'.'Niederosterreich'.'AT12 Niederoesterreich'
'Austria'.'Wien'.'AT13 Wien'
'Austria'.'Karnten'.'AT21 Kaernten'
'Austria'.'Steiermark'.'AT22 Steiermark'
'Austria'.'Oberosterreich'.'AT31 Oberoesterreich'
'Austria'.'Salzburg'.'AT32 Salzburg'
'Austria'.'Tirol'.'AT33 Tirol'
'Austria'.'Vorarlberg'.'AT34 Vorarlberg'
'Belgium'.'Brussels Hoofdstedelijk Gewest'.'BE10 Brüssel'
'Belgium'.'Antwerpen'.'BE21 Prov. Antwerpen'
'Belgium'.'Limburg'.'BE22 Prov. Limburg (BE)'
'Belgium'.'Oost-Vlaanderen'.'BE23 Prov. Oost-Vlaanderen'
'Belgium'.'Brabant Wallon'.'BE24 Prov. Vlaams-Brabant'
'Belgium'.'West-Vlaanderen'.'BE25 Prov. West-Vlaanderen'
'Belgium'.'Brabant Wallon'.'BE31 Prov. Brabant Wallon'
'Belgium'.'Hainaut'.'BE32 Prov. Hainaut'
'Belgium'.'Liege'.'BE33 Prov. Liège'
'Belgium'.'Luxembourg'.'BE34 Prov. Luxembourg (BE)'
'Belgium'.'Namur'.'BE35 Prov. Namur'
'Bulgaria'.'Lovech'.'BG31 Severozapaden'
'Bulgaria'.'Razgrad'.'BG32 Severen tsentralen'
'Bulgaria'.'Varna'.'BG33 Severoiztochen'
'Bulgaria'.'Burgas'.'BG34 Yugoiztochen'
'Bulgaria'.'Sofiya'.'BG41 Yugozapaden'
'Bulgaria'.'Plovdiv'.'BG42 Yuzhen tsentralen'
'Croatia'.'CNTRY-average'.'HR Croatia'
'Czech Republic'.'Benesov'.'CZ01 Praha'
'Czech Republic'.'Benesov'.'CZ02 Stredni Cechy'
'Czech Republic'.'Ceske Budejovice'.'CZ03 Jihozápad'
'Czech Republic'.'Cheb'.'CZ04 Severozápad'
'Czech Republic'.'Benesov'.'CZ05 Severovýchod'
'Czech Republic'.'Brno'.'CZ06 Jihovýchod'
'Czech Republic'.'Breclav'.'CZ07 Strední Morava'
'Czech Republic'.'Bruntal'.'CZ08 Moravskoslezsko'
'Denmark'.'CNTRY-average'.'DK Danmark'
'Estonia'.'CNTRY-average'.'EE Estland'
'Finland'.'Oulun Laani'.'FI13 Itä-Suomi'
'Finland'.'Hame'.'FI18 Etelä-Suomi'
'Finland'.'Vaasa'.'FI19 Laensi-Suomi'
'Finland'.'Pohjois-Karjala'.'FI1A Pohjois-Suomi'
'Finland'.'Uusimaa'.'FI20 Åland'
'France'.'Ile-de-France'.'FR10 Île de France'
'France'.'Champagne-Ardenne'.'FR21 Champagne-Ardenne'
'France'.'Picardie'.'FR22 Picardie'
'France'.'Haute-Normandie'.'FR23 Haute-Normandie'
'France'.'Centre'.'FR24 Centre'
'France'.'Basse-Normandie'.'FR25 Basse-Normandie'
'France'.'Bourgogne'.'FR26 Bourgogne'
'France'.'Nord-Pas-de-Calais'.'FR30 Nord - Pas-de-Calais'
'France'.'Lorraine'.'FR41 Lorraine'
'France'.'Alsace'.'FR42 Alsace'
'France'.'Franche-Comte'.'FR43 Franche-Comté'
'France'.'Pays de la Loire'.'FR51 Pays de la Loire'
'France'.'Bretagne'.'FR52 Bretagne'
'France'.'Poitou-Charentes'.'FR53 Poitou-Charentes'
'France'.'Aquitaine'.'FR61 Aquitaine'
'France'.'Midi-Pyrenees'.'FR62 Midi-Pyrénées'
'France'.'Limousin'.'FR63 Limousin'
'France'.'Rhone-Alpes'.'FR71 Rhône-Alpes'
'France'.'Auvergne'.'FR72 Auvergne'
'France'.'Languedoc-Roussillon'.'FR81 Languedoc-Roussillon'
'France'."Provence-Alpes-Cote d'Azur"."FR82 Provence-Alpes-Côte d'Azur"
'France'.'Corse'.'FR83 Corse'
'Germany'.'Baden-Wurttemberg'.'DE11 Stuttgart'
'Germany'.'Baden-Wurttemberg'.'DE12 Karlsruhe'
'Germany'.'Baden-Wurttemberg'.'DE13 Freiburg'
'Germany'.'Baden-Wurttemberg'.'DE14 Tuebingen'
'Germany'.'CNTRY-average'.'DE21 Oberbayern'
'Germany'.'CNTRY-average'.'DE22 Niederbayern'
'Germany'.'CNTRY-average'.'DE23 Oberpfalz'
'Germany'.'CNTRY-average'.'DE24 Oberfranken'
'Germany'.'CNTRY-average'.'DE25 Mittelfranken'
'Germany'.'CNTRY-average'.'DE26 Unterfranken'
'Germany'.'CNTRY-average'.'DE27 Schwaben'
'Germany'.'Berlin'.'DE30 Berlin'
'Germany'.'Brandenburg'.'DE40 Brandenburg'
'Germany'.'Bremen'.'DE50 Bremen'
'Germany'.'Hamburg'.'DE60 Hamburg'
'Germany'.'Hessen'.'DE71 Darmstadt'
'Germany'.'Hessen'.'DE72 Giessen'
'Germany'.'Hessen'.'DE73 Kassel'
'Germany'.'Mecklenburg-Vorpommern'.'DE80 Mecklenburg-Vorpommern'
'Germany'.'Niedersachsen'.'DE91 Braunschweig'
'Germany'.'Niedersachsen'.'DE92 Hannover'
'Germany'.'Niedersachsen'.'DE93 Lueneburg'
'Germany'.'Niedersachsen'.'DE94 Weser-Ems'
'Germany'.'Nordrhein-Westfalen'.'DEA1 Duesseldorf'
'Germany'.'Nordrhein-Westfalen'.'DEA2 Koeln'
'Germany'.'Nordrhein-Westfalen'.'DEA3 Muenster'
'Germany'.'Nordrhein-Westfalen'.'DEA4 Detmold'
'Germany'.'Nordrhein-Westfalen'.'DEA5 Arnsberg'
'Germany'.'Rheinland-Pfalz'.'DEB1 Koblenz'
'Germany'.'Rheinland-Pfalz'.'DEB2 Trier'
'Germany'.'Rheinland-Pfalz'.'DEB3 Rheinhessen-Pfalz'
'Germany'.'Saarland'.'DEC0 Saarland'
'Germany'.'Sachsen'.'DED SACHSEN'
'Germany'.'Sachsen-Anhalt'.'DEE SACHSEN-ANHALT'
'Germany'.'Schleswig-Holstein'.'DEF0 Schleswig-Holstein'
'Germany'.'Thuringen'.'DEG0 Thueringen'
'Greece'.'Xanthi'.'EL11 Anatoliki makedonia Thraki'
'Greece'.'Thessaloniki'.'EL12 Kentriki makedonia'
'Greece'.'Kozani'.'EL13 Dytiki makedonia'
'Greece'.'Larisa'.'EL14 Thessalia'
'Greece'.'Thesprotia'.'EL21 Ipeiros'
'Greece'.'Zakinthos'.'EL22 Ionia nisia'
'Greece'.'Aitolia kai Akarnania'.'EL23 Dytiki ellada'
'Greece'.'Fthiotis'.'EL24 Sterea ellada'
'Greece'.'Arkadhia'.'EL25 Peloponnisos'
'Greece'.'Attiki'.'EL30 Attiki'
'Greece'.'Lesvos'.'EL41 Voreio aigaio'
'Greece'.'Kikladhes'.'EL42 Notio aigaio'
'Greece'.'Iraklion'.'EL43 Kriti'
'Hungary'.'Pest'.'HU10 Koezép-Magyarország'
'Hungary'.'Fejer'.'HU21 Koezép-Dunántúl'
'Hungary'.'Vas'.'HU22 Nyugat-Dunántúl'
'Hungary'.'Tolna'.'HU23 Dél-Dunántúl'
'Hungary'.'Borsod-Abauj-Zemplen'.'HU31 Észak-Magyarország'
'Hungary'.'Hajdu-Bihar'.'HU32 Észak-Alfoeld'
'Hungary'.'Csongrad'.'HU33 Dél-Alfoeld'
'Ireland'.'Mayo'.'IE01 Border Midland and Western'
'Ireland'.'Cork'.'IE02 Southern and Eastern'
'Italy'.'Piemonte'.'ITC1 Piemonte'
'Italy'."Valle d'Aosta"."ITC2 Valle d'Aosta/Vallée d'Aoste"
'Italy'.'Emilia-Romagna'.'ITC3 Liguria'
'Italy'.'Lombardia'.'ITC4 Lombardia'
'Italy'.'Abruzzi'.'ITF1 Abruzzo'
'Italy'.'Molise'.'ITF2 Molise'
'Italy'.'Campania'.'ITF3 Campania'
'Italy'.'Puglia'.'ITF4 Puglia'
'Italy'.'Basilicata'.'ITF5 Basilicata'
'Italy'.'Calabria'.'ITF6 Calabria'
'Italy'.'Sicilia'.'ITG1 Sicilia'
'Italy'.'Sardegna'.'ITG2 Sardegna'
'Italy'.'Trentino-Alto Adige'.'ITH1 Bozen and Trento'
'Italy'.'Veneto'.'ITH3 Veneto'
'Italy'.'Friuli-Venezia Giulia'.'ITH4 Friuli-Venezia Giulia'
'Italy'.'Emilia-Romagna'.'ITH5 Emilia-Romagna'
'Italy'.'Toscana'.'ITI1 Toscana'
'Italy'.'Umbria'.'ITI2 Umbria'
'Italy'.'Marche'.'ITI3 Marche'
'Italy'.'Lazio'.'ITI4 Lazio'
'Latvia'.'CNTRY-average'.'LV Latvia'
'Lithuania'.'CNTRY-average'.'LT Lithuania'
'Luxembourg'.'CNTRY-average'.'LU Luxembourg'
'Netherlands'.'Groningen'.'NL11 Groningen'
'Netherlands'.'Friesland'.'NL12 Friesland (NL)'
'Netherlands'.'Drenthe'.'NL13 Drenthe'
'Netherlands'.'Overijssel'.'NL21 Overijssel'
'Netherlands'.'Gelderland'.'NL22 Gelderland'
'Netherlands'.'Flevoland'.'NL23 Flevoland'
'Netherlands'.'Utrecht'.'NL31 Utrecht'
'Netherlands'.'Noord-Holland'.'NL32 Noord-Holland'
'Netherlands'.'Zuid-Holland'.'NL33 Zuid-Holland'
'Netherlands'.'Zeeland'.'NL34 Zeeland'
'Netherlands'.'Noord-Brabant'.'NL41 Noord-Brabant'
'Netherlands'.'Limburg'.'NL42 Limburg (NL)'
'Poland'.'Piotrkow'.'PL11 Lodzkie'
'Poland'.'Ostroleka'.'PL12 Mazowieckie'
'Poland'.'Krakow'.'PL21 Malopolskie'
'Poland'.'Bielsko'.'PL22 Slaskie'
'Poland'.'Lublin'.'PL31 Lubelskie'
'Poland'.'Rzeszow'.'PL32 Podkarpackie'
'Poland'.'Kielce'.'PL33 Swietokrzyskie'
'Poland'.'Bialystok'.'PL34 Podlaskie'
'Poland'.'Poznan'.'PL41 Wielkopolskie'
'Poland'.'Koszalin'.'PL42 Zachodniopomorskie'
'Poland'.'Zielona Gora'.'PL43 Lubuskie'
'Poland'.'Jelenia Gora'.'PL51 Dolnoslaskie'
'Poland'.'Opole'.'PL52 Opolskie'
'Poland'.'Bydgoszcz'.'PL61 Kujawsko-pomorskie'
'Poland'.'Olsztyn'.'PL62 Warminsko-mazurskie'
'Poland'.'Gdansk'.'PL63 Pomorskie'
'Portugal'.'Vila Real'.'PT11 Norte'
'Portugal'.'Faro'.'PT15 Algarve'
'Portugal'.'Coimbra'.'PT16 Centro (PT)'
'Portugal'.'Lisboa'.'PT17 Área Metropolitana de Lisboa'
'Portugal'.'Evora'.'PT18 Alentejo'
'Romania'.'Salaj'.'RO11 Nord-Vest'
'Romania'.'Sibiu'.'RO12 Centru'
'Romania'.'Iasi'.'RO21 Nord-Est'
'Romania'.'Tulcea'.'RO22 Sud-Est'
'Romania'.'Teleorman'.'RO31 Sud - Muntenia'
'Romania'.'Bucuresti'.'RO32 Bucuresti - Ilfov'
'Romania'.'Dolj'.'RO41 Sud-Vest Oltenia'
'Romania'.'Timis'.'RO42 Vest'
'Slovakia'.'Bratislava'.'SK01 Bratislavský kraj'
'Slovakia'.'Zapadoslovensky'.'SK02 Západné Slovensko'
'Slovakia'.'Zilinsky'.'SK03 Stredné Slovensko'
'Slovakia'.'Zilinsky'.'SK04 Východné Slovensko'
'Slovenia'.'CNTRY-average'.'SI Slovenia'
'Spain'.'Galicia'.'ES11 Galicia'
'Spain'.'Asturias'.'ES12 Principado de Asturias'
'Spain'.'Cantabria'.'ES13 Cantabria'
'Spain'.'Pais Vasco'.'ES21 País Vasco'
'Spain'.'Navarra'.'ES22 Comunidad Foral de Navarra'
'Spain'.'La Rioja'.'ES23 La Rioja'
'Spain'.'Aragon'.'ES24 Aragón'
'Spain'.'Madrid'.'ES30 Comunidad de Madrid'
'Spain'.'Castilla Y Leon'.'ES41 Castilla y León'
'Spain'.'Castilla-La Mancha'.'ES42 Castilla-La Mancha'
'Spain'.'Extremadura'.'ES43 Extremadura'
'Spain'.'Cataluna'.'ES51 Cataluña'
'Spain'.'Valenciana'.'ES52 Comunidad Valenciana'
'Spain'.'Islas Baleares'.'ES53 Illes Balears'
'Spain'.'Andalucia'.'ES61 Andalucía'
'Spain'.'Murcia'.'ES62 Región de Murcia'
'Sweden'.'Stockholms Lan'.'SE11 Stockholm'
'Sweden'.'Sodermanlands Lan'.'SE12 Oestra Mellansverige'
'Sweden'.'Jonkopings Lan'.'SE21 Småland med oearna'
'Sweden'.'Blekinge Lan'.'SE22 Sydsverige'
'Sweden'.'Hallands Lan'.'SE23 Vaestsverige'
'Sweden'.'Varmlands Lan'.'SE31 Norra Mellansverige'
'Sweden'.'Vasternorrlands Lan'.'SE32 Mellersta Norrland'
'Sweden'.'Vasternorrlands Lan'.'SE33 Oevre Norrland'
'Switzerland'.'Vaud'.'CH01 Genferseeregion'
'Switzerland'.'Aargau'.'CH02 Espace Mittelland'
'Switzerland'.'Basel-Landschaft'.'CH03 Nordwestschweiz'
'Switzerland'.'Zurich'.'CH04 Zuerich'
'Switzerland'.'Graubunden'.'CH05 Ostschweiz'
'Switzerland'.'Nidwalden'.'CH06 Zentralschweiz'
'Switzerland'.'Ticino'.'CH07 Tessin'
'United Kingdom'.'Northumberland'.'UKC NORTH EAST (ENGLAND)'
'United Kingdom'.'Lancaster'.'UKD NORTH WEST (ENGLAND)'
'United Kingdom'.'North Yorkshire'.'UKE YORKSHIRE AND THE HUMBER'
'United Kingdom'.'Leicester'.'UKF EAST MIDLANDS (ENGLAND)'
'United Kingdom'.'West Midlands'.'UKG WEST MIDLANDS (ENGLAND)'
'United Kingdom'.'Norfolk'.'UKH EAST OF ENGLAND'
'United Kingdom'.'Greater London'.'UKI London'
'United Kingdom'.'Surrey'.'UKJ SOUTH EAST (ENGLAND)'
'United Kingdom'.'Devon'.'UKK SOUTH WEST (ENGLAND)'
'United Kingdom'.'Devon'.'UKL WALES'
'United Kingdom'.'Northumberland'.'UKM SCOTLAND'
'United Kingdom'.'Armagh'.'UKN NORTHERN IRELAND'
/;


*$ontext;
ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Green Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
                 $(NOT ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Green Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond"))
         = sum((WF_Country,WFP_UNISECO_Regions,WF_Activity,CommoditiesEquivalentActivities)$(MatchActivitiesWFP_SOLm(WF_Activity,Activities) AND MatchRegions_WFP_NUTS2UNISECO(WF_Country,WFP_UNISECO_Regions,NUTS2_Regions)),
                 WF_WaterUseActivitiesForRegions(CommoditiesEquivalentActivities,WF_Activity,"Green",WF_Country,WFP_UNISECO_Regions));

PUTCLOSE con "   NUTS2 calcs 2.1:" timeElapsed;

ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Blue Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
                 $(NOT ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Blue Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond"))
         = sum((WF_Country,WFP_UNISECO_Regions,WF_Activity,CommoditiesEquivalentActivities)$(MatchActivitiesWFP_SOLm(WF_Activity,Activities) AND MatchRegions_WFP_NUTS2UNISECO(WF_Country,WFP_UNISECO_Regions,NUTS2_Regions)),
                 WF_WaterUseActivitiesForRegions(CommoditiesEquivalentActivities,WF_Activity,"Blue",WF_Country,WFP_UNISECO_Regions));

PUTCLOSE con "   NUTS2 calcs 2.2:" timeElapsed;

ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Grey Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
                 $(NOT ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Grey Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond"))
         = sum((WF_Country,WFP_UNISECO_Regions,WF_Activity,CommoditiesEquivalentActivities)$(MatchActivitiesWFP_SOLm(WF_Activity,Activities) AND MatchRegions_WFP_NUTS2UNISECO(WF_Country,WFP_UNISECO_Regions,NUTS2_Regions)),
                 WF_WaterUseActivitiesForRegions(CommoditiesEquivalentActivities,WF_Activity,"Grey",WF_Country,WFP_UNISECO_Regions));
*$offtext;


PUTCLOSE con "   NUTS2 calcs 3:" timeElapsed;


$ontext;
we have now:
- 3 animal welfare intensity indicators    2 NUTS2 - long names                          1 country
                                           here: all scenarios                           after Steering 2: all scenarios
                                           scales with animal heads from scenarios       scales with animal heads from scenarios
- 1 animal welfare antibiotics indicator   1 NUTS2 - short
                                           here: Baseline
                                           scales with production from scenarios
- 1 animal welfare transport indicator                                                   1 country
                                                                                         here: Baseline
                                                                                         scales with animal heads from scenarios
- 3 animal welfare heat stress indicators  3 NUTS2 - short
                                           here: Baseline, 2030, 2050
                                           scales with animal heads from scenarios

- 3 water footprint indicators (per t)     3 NUTS2 - WFP names
                                           here: Baseline
                                           scales with yields and areas from scenarios
- 2 water use indicators (per t)                                                         2 country
                                                                                         here: Baseline
                                                                                         scales with yields and areas from scenarios

- 2 labour use indicator                                                                 2 country
                                                                                         here: Baseline
                                                                                         scales with areas and animal numbers from scenarios

and to be done as well: monetary value and then labour productivity






$offtext;
*assign the country-level indicators already available to NUTS2 level:
*  ActAnimalsHead_OtherChar_MR(Regions,Activities,"AllAndAverageTypes","Animal welfare: transport volume index",ProductionSystems,ProductionConditions,Scenarios)
*  ActCropsGrass_Inputs_MR(Regions,Activities,"Irrigation water (m3)",ProductionSystems,ProductionConditions,Scenarios)
*  ActCropsGrass_Inputs_MR(Regions,Activities,"Irrigation water (m3) - water stress adjusted",ProductionSystems,ProductionConditions,Scenarios)
*  ActCropsGrass_Inputs_MR(Regions,Activities,"Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios)
*  ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,"Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios)

ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: transport volume index",ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: transport volume index",ProductionSystems,ProductionConditions,Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActAnimalsHead_OtherChar_MR(Countries,Activities,"AllAndAverageTypes","Animal welfare: transport volume index",ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   NUTS2 calcs 4:" timeElapsed;


ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"IrrigW per t MOutput1 (m3) - total demand",ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"IrrigW per t MOutput1 (m3) - total demand",ProductionSystems,ProductionConditions))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActCropsGrass_OtherChar(Countries,Activities,"IrrigW per t MOutput1 (m3) - total demand",ProductionSystems,ProductionConditions));
ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.",ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.",ProductionSystems,ProductionConditions))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActCropsGrass_OtherChar(Countries,Activities,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.",ProductionSystems,ProductionConditions));

ActCropsGrass_Inputs_MR(NUTS2_Regions,Activities,"Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT ActCropsGrass_Inputs_MR(NUTS2_Regions,Activities,"Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActCropsGrass_Inputs_MR(Countries,Activities,"Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   NUTS2 calcs 4.1:" timeElapsed;

ActAnimalsHead_Inputs_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Labour use - total (h)",ProductionSystems,"AllProdCond","Baseline")
                 $(NOT ActAnimalsHead_Inputs_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Labour use - total (h)",ProductionSystems,"AllProdCond","Baseline"))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActAnimalsHead_Inputs_MR(Countries,Livestock,AnimalTypeInHerd,"Labour use - total (h)",ProductionSystems,"AllProdCond","Baseline"));


PUTCLOSE con "   NUTS2 calcs 5:" timeElapsed;


*assign to NUTS2 level AFTER Steering2:
*  ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,ProductionConditions,Scenarios)
*  ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios)




*Now derive single crop areas on NUTS2 level - needed for the UNISECO SESSIT-tool indicators:
*factor 1000000: convert to unit: hectares
VActCropsGrass_QuantityActUnits_MR.l(Regions_2,Activities_2,"AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions_2,Activities_2,"AllProdSyst","AllProdCond",Scenarios))
         = sum((Countries,ActAggregates_BioBamUNISECO)$(Match_ActAggregates_SingleAct_BioBamUNISECO(ActAggregates_BioBamUNISECO,Activities_2)
                         AND Match_Countries_NUTS2(Countries,Regions_2)),
                 CroplandArea_BioBamUNISECO(Regions_2,Scenarios,ActAggregates_BioBamUNISECO)*1000000
                         *ActCropsGrass_OtherChar_MR(Countries,Activities_2,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2050"));

PUTCLOSE con "   NUTS2 calcs 6:" timeElapsed;


*Derive scaling factor to calculate animal numbers on NUTS2 level:

*                             Heads(Region) * Production(NUTS2)*FCR(NUTS2)
*        heads(NUTS2) =  ------------------------------------------------------
*                         SUMME_NUTS2-in-Region (Production(NUTS2)*FCR(NUTS2) )
*
*Thus, the scaling factor is:
*
*                                                     Production(NUTS2)*FCR(NUTS2)
* ScalingHeadsRegiontoNUTS2(NUTS2)     =  ------------------------------------------------------
*                                          SUMME_NUTS2-in-Region (Production(NUTS2)*FCR(NUTS2) )

*thus, read the UNISECO BioBAm production data:

*the following needs to be assigned BEFORE this part, as it needs to be available also in case OLD calculations are used, i.e. code AFTER $label UseOldSESSITData
*thus, it is defined already above in line 2575 before $goto UseOldSESSITData
*Parameter AnimalProdData_BioBamUNISECO(Regions,Activities,OutputsAnimals,Scenarios);

$ifthen %IncludeExcel_AdditionalLivestockProductionData_UNISECO% == "YES"
$call GDXXRW Input_AnimalProd_2012_2050_BioBamUNISECO.xlsx  o=AnimalProdData_UNISECO.gdx  index=index!a1
$endif;

$GDXIN AnimalProdData_UNISECO.gdx
$load AnimalProdData_BioBamUNISECO
$GDXIN

*unit is in Megatons, hence the multiplication by 1000000 to get tons
AnimalProdData_BioBamUNISECO(Regions,Activities,OutputsAnimals,Scenarios)
         = AnimalProdData_BioBamUNISECO(Regions,Activities,OutputsAnimals,Scenarios)*1000000;

*the following needs to be assigned BEFORE this part, as it needs to be available also in case OLD calculations are used, i.e. code AFTER $label UseOldSESSITData
*thus, it is defined already above in line 2575 before $goto UseOldSESSITData
*Parameter AUX2_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios) an auxiliary parameter - AUX2 as later AUX_.... is already defined and used;

AUX2_ActAnimalsHead_OtherChar_MR(Countries,Activities,"Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
         = sum(Regions_2$Match_Countries_NUTS2(Countries,Regions_2),
                 AnimalProdData_BioBamUNISECO(Regions_2,Activities,"Meat (t)",Scenarios)
                         *FCR_Scenarios_BioBamUNISECO(Activities,"Meat Producing","AggregateFeedTotal_Commodity",Regions_2,Scenarios));
AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,Regions_2),
                 AUX2_ActAnimalsHead_OtherChar_MR(Countries,Activities,"Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios));
ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
                 $((NOT ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))
                         AND AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))
         = AnimalProdData_BioBamUNISECO(Regions_2,Activities,"Meat (t)",Scenarios)
                 *FCR_Scenarios_BioBamUNISECO(Activities,"Meat Producing","AggregateFeedTotal_Commodity",Regions_2,Scenarios)
                         /AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios);

PUTCLOSE con "   NUTS2 calcs 7:" timeElapsed;


AUX2_ActAnimalsHead_OtherChar_MR(Countries,Activities,"Milk Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
         = sum(Regions_2$Match_Countries_NUTS2(Countries,Regions_2),
                 AnimalProdData_BioBamUNISECO(Regions_2,Activities,"Milk (t)",Scenarios)
                         *FCR_Scenarios_BioBamUNISECO(Activities,"Milk Producing","AggregateFeedTotal_Commodity",Regions_2,Scenarios));
AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Milk Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Milk Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,Regions_2),
                 AUX2_ActAnimalsHead_OtherChar_MR(Countries,Activities,"Milk Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios));
ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Milk Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
                 $((NOT ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Milk Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))
                         AND AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Milk Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))
         = AnimalProdData_BioBamUNISECO(Regions_2,Activities,"Milk (t)",Scenarios)
                 *FCR_Scenarios_BioBamUNISECO(Activities,"Milk Producing","AggregateFeedTotal_Commodity",Regions_2,Scenarios)
                         /AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Milk Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios);

PUTCLOSE con "   NUTS2 calcs 8:" timeElapsed;

AUX2_ActAnimalsHead_OtherChar_MR(Countries,Activities,"Egg Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
         = sum(Regions_2$Match_Countries_NUTS2(Countries,Regions_2),
                 AnimalProdData_BioBamUNISECO(Regions_2,Activities,"Eggs (t)",Scenarios)
                         *FCR_Scenarios_BioBamUNISECO(Activities,"Egg Producing","AggregateFeedTotal_Commodity",Regions_2,Scenarios));
AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Egg Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Egg Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,Regions_2),
                 AUX2_ActAnimalsHead_OtherChar_MR(Countries,Activities,"Egg Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios));
ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Egg Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
                 $((NOT ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Egg Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))
                         AND AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Egg Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))
         = AnimalProdData_BioBamUNISECO(Regions_2,Activities,"Eggs (t)",Scenarios)
                 *FCR_Scenarios_BioBamUNISECO(Activities,"Egg Producing","AggregateFeedTotal_Commodity",Regions_2,Scenarios)
                         /AUX2_ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Egg Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios);


PUTCLOSE con "   NUTS2 calcs 9:" timeElapsed;

*and now assign the animal welfare heat stress and antibiotics index indicators the long NUTS2 labels and drop the short ones:

*the below is very slow, so reduce the AnimalTypeInHerd entry needed:
ActAnimalsHead_OtherChar_MR(Regions,"Cattle","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions,"Pigs","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions,"Pigs","Sows","Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions,"Cattle","AllAndAverageTypes","Animal welfare: heat stress index 2020",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Animal welfare: heat stress index 2020",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions,"Pigs","AllAndAverageTypes","Animal welfare: heat stress index 2020",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions,"Pigs","Sows","Animal welfare: heat stress index 2020",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions,"Cattle","AllAndAverageTypes","Animal welfare: heat stress index 2030",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Animal welfare: heat stress index 2030",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions,"Pigs","AllAndAverageTypes","Animal welfare: heat stress index 2030",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions,"Pigs","Sows","Animal welfare: heat stress index 2030",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions,"Cattle","AllAndAverageTypes","Animal welfare: heat stress index 2050",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions,"Cattle","Producing_Dairy_Cattle","Animal welfare: heat stress index 2050",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions,"Pigs","AllAndAverageTypes","Animal welfare: heat stress index 2050",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions,"Pigs","Sows","Animal welfare: heat stress index 2050",ProductionSystems,ProductionConditions,Scenarios);

*For this, we need yet another matching set, as the short labels in the indices are yet again different than for others:
SET Match_NUTS2_AntibiotHeat_SOLm(Regions,Regions_2)
/
'AT11'.'AT11 Burgenland'
'AT12'.'AT12 Niederoesterreich'
'AT13'.'AT13 Wien'
'AT21'.'AT21 Kaernten'
'AT22'.'AT22 Steiermark'
'AT31'.'AT31 Oberoesterreich'
'AT32'.'AT32 Salzburg'
'AT33'.'AT33 Tirol'
'AT34'.'AT34 Vorarlberg'
'BE10'.'BE10 Brüssel'
'BE21'.'BE21 Prov. Antwerpen'
'BE22'.'BE22 Prov. Limburg (BE)'
'BE23'.'BE23 Prov. Oost-Vlaanderen'
'BE24'.'BE24 Prov. Vlaams-Brabant'
'BE25'.'BE25 Prov. West-Vlaanderen'
'BE31'.'BE31 Prov. Brabant Wallon'
'BE32'.'BE32 Prov. Hainaut'
'BE33'.'BE33 Prov. Liège'
'BE34'.'BE34 Prov. Luxembourg (BE)'
'BE35'.'BE35 Prov. Namur'
'BG31'.'BG31 Severozapaden'
'BG32'.'BG32 Severen tsentralen'
'BG33'.'BG33 Severoiztochen'
'BG34'.'BG34 Yugoiztochen'
'BG41'.'BG41 Yugozapaden'
'BG42'.'BG42 Yuzhen tsentralen'
'CH01'.'CH01 Genferseeregion'
'CH02'.'CH02 Espace Mittelland'
'CH03'.'CH03 Nordwestschweiz'
'CH04'.'CH04 Zuerich'
'CH05'.'CH05 Ostschweiz'
'CH06'.'CH06 Zentralschweiz'
'CH07'.'CH07 Tessin'
*'CY00'.''
'CZ01'.'CZ01 Praha'
'CZ02'.'CZ02 Stredni Cechy'
'CZ03'.'CZ03 Jihozápad'
'CZ04'.'CZ04 Severozápad'
'CZ05'.'CZ05 Severovýchod'
'CZ06'.'CZ06 Jihovýchod'
'CZ07'.'CZ07 Strední Morava'
'CZ08'.'CZ08 Moravskoslezsko'
'DE11'.'DE11 Stuttgart'
'DE12'.'DE12 Karlsruhe'
'DE13'.'DE13 Freiburg'
'DE14'.'DE14 Tuebingen'
'DE21'.'DE21 Oberbayern'
'DE22'.'DE22 Niederbayern'
'DE23'.'DE23 Oberpfalz'
'DE24'.'DE24 Oberfranken'
'DE25'.'DE25 Mittelfranken'
'DE26'.'DE26 Unterfranken'
'DE27'.'DE27 Schwaben'
'DE30'.'DE30 Berlin'
'DE40'.'DE40 Brandenburg'
'DE50'.'DE50 Bremen'
'DE60'.'DE60 Hamburg'
'DE71'.'DE71 Darmstadt'
'DE72'.'DE72 Giessen'
'DE73'.'DE73 Kassel'
'DE80'.'DE80 Mecklenburg-Vorpommern'
'DE91'.'DE91 Braunschweig'
'DE92'.'DE92 Hannover'
'DE93'.'DE93 Lueneburg'
'DE94'.'DE94 Weser-Ems'
'DEA1'.'DEA1 Duesseldorf'
'DEA2'.'DEA2 Koeln'
'DEA3'.'DEA3 Muenster'
'DEA4'.'DEA4 Detmold'
'DEA5'.'DEA5 Arnsberg'
'DEB1'.'DEB1 Koblenz'
'DEB2'.'DEB2 Trier'
'DEB3'.'DEB3 Rheinhessen-Pfalz'
'DEC0'.'DEC0 Saarland'
*'DED2'.''
'DED4'.'DED SACHSEN'
*'DED5'.''
'DEE0'.'DEE SACHSEN-ANHALT'
'DEF0'.'DEF0 Schleswig-Holstein'
'DEG0'.'DEG0 Thueringen'
*'DK01'.''
*'DK02'.''
'DK03'.'DK Danmark'
*'DK04'.''
*'DK05'.''
'EE00'.'EE Estland'
'EL11'.'EL11 Anatoliki makedonia Thraki'
'EL12'.'EL12 Kentriki makedonia'
'EL13'.'EL13 Dytiki makedonia'
'EL14'.'EL14 Thessalia'
'EL21'.'EL21 Ipeiros'
'EL22'.'EL22 Ionia nisia'
'EL23'.'EL23 Dytiki ellada'
'EL24'.'EL24 Sterea ellada'
'EL25'.'EL25 Peloponnisos'
'EL30'.'EL30 Attiki'
'EL41'.'EL41 Voreio aigaio'
'EL42'.'EL42 Notio aigaio'
'EL43'.'EL43 Kriti'
'ES11'.'ES11 Galicia'
'ES12'.'ES12 Principado de Asturias'
'ES13'.'ES13 Cantabria'
'ES21'.'ES21 País Vasco'
'ES22'.'ES22 Comunidad Foral de Navarra'
'ES23'.'ES23 La Rioja'
'ES24'.'ES24 Aragón'
'ES30'.'ES30 Comunidad de Madrid'
'ES41'.'ES41 Castilla y León'
'ES42'.'ES42 Castilla-La Mancha'
'ES43'.'ES43 Extremadura'
'ES51'.'ES51 Cataluña'
'ES52'.'ES52 Comunidad Valenciana'
'ES53'.'ES53 Illes Balears'
'ES61'.'ES61 Andalucía'
'ES62'.'ES62 Región de Murcia'
*'ES64'.''
'FI19'.'FI19 Laensi-Suomi'
*'FI1B'.''
*'FI1C'.''
*'FI1D'.''
'FI13'."FI13 Itä-Suomi"
'FI18'."FI18 Etelä-Suomi"
'FI1A'."FI1A Pohjois-Suomi"
'FI20'.'FI20 Åland'
'FR10'.'FR10 Île de France'
'FR21'.'FR21 Champagne-Ardenne'
'FR22'.'FR22 Picardie'
'FR23'.'FR23 Haute-Normandie'
'FR24'.'FR24 Centre'
'FR25'.'FR25 Basse-Normandie'
'FR26'.'FR26 Bourgogne'
'FR30'.'FR30 Nord - Pas-de-Calais'
'FR41'.'FR41 Lorraine'
'FR42'.'FR42 Alsace'
'FR43'.'FR43 Franche-Comté'
'FR51'.'FR51 Pays de la Loire'
'FR52'.'FR52 Bretagne'
'FR53'.'FR53 Poitou-Charentes'
'FR61'.'FR61 Aquitaine'
'FR62'.'FR62 Midi-Pyrénées'
'FR63'.'FR63 Limousin'
'FR71'.'FR71 Rhône-Alpes'
'FR72'.'FR72 Auvergne'
'FR81'.'FR81 Languedoc-Roussillon'
'FR82'."FR82 Provence-Alpes-Côte d'Azur"
'FR83'.'FR83 Corse'
'HR04'.'HR Croatia'
*'HR03'.''
'HU10'.'HU10 Koezép-Magyarország'
'HU21'.'HU21 Koezép-Dunántúl'
'HU22'.'HU22 Nyugat-Dunántúl'
'HU23'.'HU23 Dél-Dunántúl'
'HU31'.'HU31 Észak-Magyarország'
'HU32'.'HU32 Észak-Alfoeld'
'HU33'.'HU33 Dél-Alfoeld'
'IE01'.'IE01 Border Midland and Western'
'IE02'.'IE02 Southern and Eastern'
*'IS00'.''
'ITC1'.'ITC1 Piemonte'
'ITC2'."ITC2 Valle d'Aosta/Vallée d'Aoste"
'ITC3'.'ITC3 Liguria'
'ITC4'.'ITC4 Lombardia'
'ITF1'.'ITF1 Abruzzo'
'ITF2'.'ITF2 Molise'
'ITF3'.'ITF3 Campania'
'ITF4'.'ITF4 Puglia'
'ITF5'.'ITF5 Basilicata'
'ITF6'.'ITF6 Calabria'
'ITG1'.'ITG1 Sicilia'
'ITG2'.'ITG2 Sardegna'
'ITH1'.'ITH1 Bozen and Trento'
*'ITH2'.''
'ITH3'.'ITH3 Veneto'
'ITH4'.'ITH4 Friuli-Venezia Giulia'
'ITH5'.'ITH5 Emilia-Romagna'
'ITI1'.'ITI1 Toscana'
'ITI2'.'ITI2 Umbria'
'ITI3'.'ITI3 Marche'
'ITI4'.'ITI4 Lazio'
'LT00'.'LT Lithuania'
'LU00'.'LU Luxembourg'
'LV00'.'LV Latvia'
*'ME00'.''
*'MK00'.''
*'MT00'.''
'NL11'.'NL11 Groningen'
'NL12'.'NL12 Friesland (NL)'
'NL13'.'NL13 Drenthe'
'NL21'.'NL21 Overijssel'
'NL22'.'NL22 Gelderland'
'NL23'.'NL23 Flevoland'
'NL31'.'NL31 Utrecht'
'NL32'.'NL32 Noord-Holland'
'NL33'.'NL33 Zuid-Holland'
'NL34'.'NL34 Zeeland'
'NL41'.'NL41 Noord-Brabant'
'NL42'.'NL42 Limburg (NL)'
*'NO01'.''
*'NO02'.''
*'NO03'.''
*'NO04'.''
*'NO05'.''
*'NO06'.''
*'NO07'.''
'PL11'.'PL11 Lodzkie'
'PL12'.'PL12 Mazowieckie'
'PL21'.'PL21 Malopolskie'
'PL22'.'PL22 Slaskie'
'PL31'.'PL31 Lubelskie'
'PL32'.'PL32 Podkarpackie'
'PL33'.'PL33 Swietokrzyskie'
'PL34'.'PL34 Podlaskie'
'PL41'.'PL41 Wielkopolskie'
'PL42'.'PL42 Zachodniopomorskie'
'PL43'.'PL43 Lubuskie'
'PL51'.'PL51 Dolnoslaskie'
'PL52'.'PL52 Opolskie'
'PL61'.'PL61 Kujawsko-pomorskie'
'PL62'.'PL62 Warminsko-mazurskie'
'PL63'.'PL63 Pomorskie'
'PT11'.'PT11 Norte'
'PT15'.'PT15 Algarve'
'PT16'.'PT16 Centro (PT)'
'PT17'.'PT17 Área Metropolitana de Lisboa'
'PT18'.'PT18 Alentejo'
'RO11'.'RO11 Nord-Vest'
'RO12'.'RO12 Centru'
'RO21'.'RO21 Nord-Est'
'RO22'.'RO22 Sud-Est'
'RO31'.'RO31 Sud - Muntenia'
'RO32'.'RO32 Bucuresti - Ilfov'
'RO41'.'RO41 Sud-Vest Oltenia'
'RO42'.'RO42 Vest'
'SE11'.'SE11 Stockholm'
'SE12'.'SE12 Oestra Mellansverige'
'SE21'.'SE21 Småland med oearna'
'SE22'.'SE22 Sydsverige'
'SE23'.'SE23 Vaestsverige'
'SE31'.'SE31 Norra Mellansverige'
'SE32'.'SE32 Mellersta Norrland'
'SE33'.'SE33 Oevre Norrland'
*'SI01'.''
'SI02'.'SI Slovenia'
'SK01'.'SK01 Bratislavský kraj'
'SK02'.'SK02 Západné Slovensko'
'SK03'.'SK03 Stredné Slovensko'
'SK04'.'SK04 Východné Slovensko'
*'TR10'.''
*'TR21'.''
*'TR22'.''
*'TR31'.''
*'TR32'.''
*'TR33'.''
*'TR41'.''
*'TR42'.''
*'TR51'.''
*'TR52'.''
*'TR61'.''
*'TR62'.''
*'TR63'.''
*'TR71'.''
*'TR72'.''
*'TR81'.''
*'TR82'.''
*'TR83'.''
*'TR90'.''
*'TRA1'.''
*'TRA2'.''
*'TRB1'.''
*'TRB2'.''
*'TRC1'.''
*'TRC2'.''
*'TRC3'.''
*'UKC1'.''
'UKC2'.'UKC NORTH EAST (ENGLAND)'
'UKD1'.'UKD NORTH WEST (ENGLAND)'
*'UKD3'.''
*'UKD4'.''
*'UKD6'.''
*'UKD7'.''
*'UKE1'.''
'UKE2'.'UKE YORKSHIRE AND THE HUMBER'
*'UKE3'.''
*'UKE4'.''
*'UKF1'.''
'UKF2'.'UKF EAST MIDLANDS (ENGLAND)'
*'UKF3'.''
*'UKG1'.''
'UKG2'.'UKG WEST MIDLANDS (ENGLAND)'
*'UKG3'.''
'UKH1'.'UKH EAST OF ENGLAND'
*'UKH2'.''
*'UKH3'.''
*'UKI1'.''
'UKI2'.'UKI London'
*'UKJ1'.''
'UKJ2'.'UKJ SOUTH EAST (ENGLAND)'
*'UKJ3'.''
*'UKJ4'.''
*'UKK1'.''
*'UKK2'.''
*'UKK3'.''
'UKK4'.'UKK SOUTH WEST (ENGLAND)'
*'UKL1'.''
'UKL2'.'UKL WALES'
'UKM2'.'UKM SCOTLAND'
*'UKM5'.''
*'UKM6'.''
'UKN0'.'UKN NORTHERN IRELAND'
*'UKM3'.''
/;




ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: antibiotics use index","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: antibiotics use index","AllProdSyst","AllProdCond",Scenarios))
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_AntibiotHeat_SOLm(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 ActAnimalsHead_OtherChar_MR(NUTS2_Regions_ShortLabels,Activities,"AllAndAverageTypes","Animal welfare: antibiotics use index","AllProdSyst","AllProdCond",Scenarios));


PUTCLOSE con "   NUTS2 calcs 10:" timeElapsed;

ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2020","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2020","AllProdSyst","AllProdCond",Scenarios))
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_AntibiotHeat_SOLm(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 ActAnimalsHead_OtherChar_MR(NUTS2_Regions_ShortLabels,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2020","AllProdSyst","AllProdCond",Scenarios));

PUTCLOSE con "   NUTS2 calcs 10.1:" timeElapsed;

ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2030","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2030","AllProdSyst","AllProdCond",Scenarios))
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_AntibiotHeat_SOLm(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 ActAnimalsHead_OtherChar_MR(NUTS2_Regions_ShortLabels,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2030","AllProdSyst","AllProdCond",Scenarios));

PUTCLOSE con "   NUTS2 calcs 10.2:" timeElapsed;

ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2050","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2050","AllProdSyst","AllProdCond",Scenarios))
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_AntibiotHeat_SOLm(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 ActAnimalsHead_OtherChar_MR(NUTS2_Regions_ShortLabels,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2050","AllProdSyst","AllProdCond",Scenarios));

PUTCLOSE con "   NUTS2 calcs 11:" timeElapsed;

ActAnimalsHead_OtherChar_MR(NUTS2_Regions_ShortLabels,Activities,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios) = 0;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions_ShortLabels,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2020",ProductionSystems,ProductionConditions,Scenarios) = 0;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions_ShortLabels,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2030",ProductionSystems,ProductionConditions,Scenarios) = 0;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions_ShortLabels,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2050",ProductionSystems,ProductionConditions,Scenarios) = 0;


*and finally, we need to assign the NUTS2 permanent grassland areas to SOLm model variables, which we did not yet assign:
*factor 1000000: convert to unit: hectares
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","AE_exports_2012")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_AeExp(NUTS2_Regions_ShortLabels,"2012"))*1000000;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","AE_exports_2030")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_AeExp(NUTS2_Regions_ShortLabels,"2030"))*1000000;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","AE_exports_2050")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_AeExp(NUTS2_Regions_ShortLabels,"2050"))*1000000;

VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2012")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_BAU(NUTS2_Regions_ShortLabels,"2012"))*1000000;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2030")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_BAU(NUTS2_Regions_ShortLabels,"2030"))*1000000;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_BAU(NUTS2_Regions_ShortLabels,"2050"))*1000000;

VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","AE_food_2012")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_LAESyst(NUTS2_Regions_ShortLabels,"2012"))*1000000;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","AE_food_2030")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_LAESyst(NUTS2_Regions_ShortLabels,"2030"))*1000000;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","AE_food_2050")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_LAESyst(NUTS2_Regions_ShortLabels,"2050"))*1000000;

VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","LfP_2012")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_LfP(NUTS2_Regions_ShortLabels,"2012"))*1000000;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","LfP_2030")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_LfP(NUTS2_Regions_ShortLabels,"2030"))*1000000;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","LfP_2050")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_LfP(NUTS2_Regions_ShortLabels,"2050"))*1000000;

VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","LfS_2012")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_LfS(NUTS2_Regions_ShortLabels,"2012"))*1000000;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","LfS_2030")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_LfS(NUTS2_Regions_ShortLabels,"2030"))*1000000;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,"Permanent meadows and pastures","AllProdSyst","AllProdCond","LfS_2050")
         =sum(NUTS2_Regions_ShortLabels$Match_NUTS2_ShortAndLongLabels(NUTS2_Regions_ShortLabels,NUTS2_Regions),
                 BioBam_Grazingland_Mha_LfS(NUTS2_Regions_ShortLabels,"2050"))*1000000;




$ontext;
XXXXX
VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities_2,"AllProdSyst","AllProdCond",ScenariosUNISECO)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities_2,"AllProdSyst","AllProdCond",ScenariosUNISECO))
         = sum(ActAggregates_BioBamUNISECO$Match_ActAggregates_SingleAct_BioBamUNISECO(ActAggregates_BioBamUNISECO,Activities_2),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,ActAggregates_BioBamUNISECO,"AllProdSyst","AllProdCond",ScenariosUNISECO)
                         *ActCropsGrass_OtherChar_MR(Countries,Activities_2,"Share single crop in crop group","AllProdSyst","AllProdCond","FOFA_BAU_2050"));

*UNITS: Mha - million hectares
CroplandArea_BioBamUNISECO(Countries,Scenarios,Activities)
                 $(NOT CroplandArea_BioBamUNISECO(Countries,Scenarios,Activities))
         =sum(Regions_2$Match_Countries_NUTS2(Countries,Regions_2),
                 CroplandArea_BioBamUNISECO(Regions_2,Scenarios,Activities));

*THEN assign to the SOLm parameters and variables as needed

*the new data does not contain data for cyprus and Malta, thus use a subset of EU only to not loose the original data for these countries:

*factor 1000000: convert to unit: hectares

VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities,"AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities,"AllProdSyst","AllProdCond",Scenarios))
         = CroplandArea_BioBamUNISECO(Countries,Scenarios,Activities)*1000000;
$offtext;


*now assign the NUTS2 data to new parameters and variables to store them separately and read from there if not calculated anew.
*new parameters and variables are needed to not overwrite other data when reading the already calculated values
*they need to be assigned BEFORE this part, as they need to be available also in case OLD calculations are used, i.e. code AFTER $label UseOldSESSITData
*thus, they are defined already above in line 2575 before $goto UseOldSESSITData
*Parameter AUXNUTS2_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios);
*Parameter AUXNUTS2_ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
*Parameter AUXNUTS2_ActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
*Parameter AUXNUTS2_ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
*Parameter AUXNUTS2_ActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
*Parameter AUXNUTS2_ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
*Variable AUXNUTS2_VActCropsGrass_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios);

AUXNUTS2_ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios);
AUXNUTS2_ActAnimalsHead_Inputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Inputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
AUXNUTS2_ActCropsGrass_OtherChar(NUTS2_Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions)
         = ActCropsGrass_OtherChar(NUTS2_Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
AUXNUTS2_ActCropsGrass_OtherChar_MR(NUTS2_Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_OtherChar_MR(NUTS2_Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
AUXNUTS2_ActCropsGrass_Inputs(NUTS2_Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions)
         = ActCropsGrass_Inputs(NUTS2_Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
AUXNUTS2_ActCropsGrass_Inputs_MR(NUTS2_Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_Inputs_MR(NUTS2_Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
AUXNUTS2_VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,ProductionSystems,ProductionConditions,Scenarios);

execute_unload "Store_Data_for_SESSIT"
AUXNUTS2_ActAnimalsHead_OtherChar_MR
AUXNUTS2_ActAnimalsHead_Inputs_MR
AUXNUTS2_ActCropsGrass_OtherChar
AUXNUTS2_ActCropsGrass_OtherChar_MR
AUXNUTS2_ActCropsGrass_Inputs
AUXNUTS2_ActCropsGrass_Inputs_MR
AUXNUTS2_VActCropsGrass_QuantityActUnits_MR
*also store the BioBam animal production to be used in sessit calculations in Steering2:
AnimalProdData_BioBamUNISECO
;

$goto EndOf_DoNUTS2Assignments

$label UseOldSESSITData

$gdxin Store_Data_for_SESSIT.gdx
$load AUXNUTS2_ActAnimalsHead_OtherChar_MR
$load AUXNUTS2_ActAnimalsHead_Inputs_MR
$load AUXNUTS2_ActCropsGrass_OtherChar
$load AUXNUTS2_ActCropsGrass_OtherChar_MR
$load AUXNUTS2_ActCropsGrass_Inputs
$load AUXNUTS2_ActCropsGrass_Inputs_MR
$load AUXNUTS2_VActCropsGrass_QuantityActUnits_MR
$gdxin

*assign to model variables:
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
         = AUXNUTS2_ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_Inputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT ActAnimalsHead_Inputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
         = AUXNUTS2_ActAnimalsHead_Inputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
ActCropsGrass_OtherChar(NUTS2_Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_OtherChar(NUTS2_Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions))
         = AUXNUTS2_ActCropsGrass_OtherChar(NUTS2_Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
ActCropsGrass_OtherChar_MR(NUTS2_Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT ActCropsGrass_OtherChar_MR(NUTS2_Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         = AUXNUTS2_ActCropsGrass_OtherChar_MR(NUTS2_Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
ActCropsGrass_Inputs(NUTS2_Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_Inputs(NUTS2_Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions))
         = AUXNUTS2_ActCropsGrass_Inputs(NUTS2_Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
ActCropsGrass_Inputs_MR(NUTS2_Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT ActCropsGrass_Inputs_MR(NUTS2_Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         = AUXNUTS2_ActCropsGrass_Inputs_MR(NUTS2_Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,ProductionSystems,ProductionConditions,Scenarios))
         = AUXNUTS2_VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,ProductionSystems,ProductionConditions,Scenarios);

*delete auxiliary variables:
AUXNUTS2_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios) = 0;
AUXNUTS2_ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios) = 0;
AUXNUTS2_ActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions) = 0;
AUXNUTS2_ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios) = 0;
AUXNUTS2_ActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions) = 0;
AUXNUTS2_ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios) = 0;
AUXNUTS2_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios) = 0;


PUTCLOSE con "   NUTS2 calcs 12:" timeElapsed;

$label EndOf_DoNUTS2Assignments

PUTCLOSE con "   NUTS2 calcs 13:" timeElapsed;

execute_unload "Data_for_SESSIT"
ActAnimalsHead_OtherChar_MR
ActAnimalsHead_Inputs_MR
ActCropsGrass_OtherChar
ActCropsGrass_OtherChar_MR
ActCropsGrass_Inputs
ActCropsGrass_Inputs_MR
VActCropsGrass_QuantityActUnits_MR
CroplandArea_BioBamUNISECO

AnimalProdData_BioBamUNISECO
AUX2_ActAnimalsHead_OtherChar_MR
FCR_Scenarios_BioBamUNISECO
;


$ontext;
we have now:

NUTS2 - long names; "AllAndAverageTypes", "Baseline"
- 1 animal welfare antibiotics indicator
         scales with production from scenarios
                     ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: antibiotics use index","AllProdSyst","AllProdCond",Scenarios)
- 1 animal welfare transport indicator
         scales with animal heads from scenarios
                     ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: transport volume index",ProductionSystems,ProductionConditions,Scenarios)
- 3 animal welfare heat stress indicators
         scales with animal heads from scenarios; BUT: values to be used for 2030, 2050 (but currently named differently, all with scenario = BAseline)
                     ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2020","AllProdSyst","AllProdCond",Scenarios)
                                                                                                                                  2030
NUTS2 - long names; AnimalTypeInHerd, UNISECOScenarios                                                                            2050
- 1 animal welfare intensity ruminants
         scales with animal heads from scenarios
                     ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants","AllProdSyst","AllProdCond",Scenarios)
- 1 animal welfare intensity eggs
         scales with animal heads from scenarios (only Chickens)
                     ActAnimalsHead_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Animal welfare: production intensity index - eggs","AllProdSyst","AllProdCond",Scenarios)

NUTS2 - long names; "Baseline"
- Blue water footprint
- Green water footprint
- Grey water footprint
         scales with yields and areas from scenarios
                     ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Green Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
                                                                       Blue
                                                                       Grey
- water use Pfister
         scales with yields and areas from scenarios
                     ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"IrrigW per t MOutput1 (m3) - total demand",ProductionSystems,ProductionConditions)
                                        This then is as Input per ha: "Irrigation water (m3)"
- water use and scarcity Pfister
         scales with yields and areas from scenarios
                     ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.",ProductionSystems,ProductionConditions)
                                        This then is as Input per ha: "Irrigation water (m3) - water stress adjusted"
- 2 labour use indicator
         scales with areas/animal heads from scenarios (ORGANIC and CONVENT!!)
                     ActCropsGrass_Inputs_MR(NUTS2_Regions,Activities,"Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios)
                     ActAnimalsHead_Inputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios)


COUNTRIES; AnimalTypeInHerd, "Baseline" - DERIVE ANEW after STEERING2 and THEN assign to NUTS2
- 1 animal welfare intensity monogastrics
         scales with animal heads from scenarios
                     ActAnimalsHead_OtherChar_MR(Regions,Activities,"AllAndAverageTypes","Animal welfare: production intensity index - monogastrics","AllProdSyst","AllProdCond",Scenarios)


And we have the scaling variables or parts of them:
- per crop and NUTS2 areas, UNISECO Scenarios
                     VActCropsGrass_QuantityActUnits_MR.l(Regions_2,Activities_2,"AllProdSyst","AllProdCond",Scenarios)
- share animal numbers - per NUTS2 in region: UNISECO Scenarios; MULTIPLY with country animal number after Steering2
                     ActAnimalsHead_OtherChar_MR(Regions_2,Activities,"Egg Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
- animal production per NUTS2, UNISECO Scenarios
                     AnimalProdData_BioBamUNISECO(Regions,Activities,OutputsAnimals,Scenarios)

*and wel also need the following AFTER STEERING2 to calculate the indicators:
- cropyields
         ActCropsGrass_Outputs_MR
- animal numbers
         VActAnimalsHead_QuantityActUnits_MR





and to be done as well: monetary value and then labour productivity

$offtext;







$exit;













*and get rid of the NUTS2-level data again, which is currently used for SESSIT only:
FeedingRationsHeads_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond",Scenarios) = 0;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants","AllProdSyst","AllProdCond",Scenarios) = 0;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Chickens","AllAndAverageTypes","Animal welfare: production intensity index - eggs","AllProdSyst","AllProdCond",Scenarios) = 0;













VActCropsGrass_QuantityActUnits_MR.l(Countries,GrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,GrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         = GrasslandAreaEU_BioBamUNISECO(GrassActivities,Countries)*1000000;
VActCropsGrass_QuantityActUnits_MR.l(Countries,GrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,GrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         = GrasslandAreaRoW_BioBamUNISECO(GrassActivities,Countries)*1000000;
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(NOT ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         = GrasslandYieldsEU_BioBamUNISECO(GrassActivities,Countries);
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012")
                 $(NOT ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012"))
         = GrasslandYieldsRoW_BioBamUNISECO(GrassActivities,Countries);

