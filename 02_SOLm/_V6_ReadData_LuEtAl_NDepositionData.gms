PUTCLOSE con,"_V6_ReadData_LuEtAl_NDepositionData";

$ontext;
GENERAL DESCRIPTION
This file assigns the per ha values for atmospHeric N deposition as reported in Lu et al. 2013:
Xuehe Lu, Hong Jiang, Xiuying Zhang, Jinxun Liu, Zhen Zhang, Jiaxin Jin, Ying Wang, Jianhui Xu & Miaomiao Cheng (2013)
Estimated global nitrogen deposition using NO2 column density, International Journal of Remote Sensing, 34:24, 8893-8906
DOI: 10.1080/01431161.2013.853894, To link to this article: http://dx.doi.org/10.1080/01431161.2013.853894


DETAILED TABLE OF CONTENTS
- 1) Atmpospheric N deposition from Lu et al. 2013
- 2) OTHER XXX Data
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Atmpospheric N deposition from Lu et al. 2013

$ontext;
The values used are taken from table 2 in Lue et al. 2013:

Table 2. Annual N deposition (g N / m2) in major regions of world.

Thus, kg/ha is this value times 10.

We currently do not use the growth rate to change something, but we scale the deposition in the scenarios with manure availability

Region           Average N dep   Growth rate (%)
Canada           0.11            0.1
USA              0.47            1.2
Central America  0.26            2.5
South America    0.35            1.8
Western Europe   0.89            0.8
Eastern Europe   0.63            0.1
Eastern Africa   0.32            0.6
Western Africa   0.24            2.3
Northern Africa  0.16            2.7
Southern Africa  0.38            2.9
Middle East      0.21           -1.18
Middle Asia      0.24           -0.14
Southeast Asia   0.60            3.1
China            1.06            2.8
India            1.58            3.3
Japan            0.97            0.5
$offtext;


Parameter LuEtAl_NDeposition(FAOSTAT_CountriesAndRegions);

*first assign the regional values, after this, assign regional values to countries, and then file in specific country values as reported in the reference

*unit: kg N/ha
*Canada and USA are assigned below; Remaining remote areas in Northern America are assume to be the same as Canada, thus assign this value to Northern America
LuEtAl_NDeposition("Northern America") =1.1;
LuEtAl_NDeposition("Central America")  =2.6;
LuEtAl_NDeposition("South America")    =3.5;
LuEtAl_NDeposition("Western Europe")   =8.9;
LuEtAl_NDeposition("Eastern Europe")   =6.3;
LuEtAl_NDeposition("Eastern Africa")   =3.2;
LuEtAl_NDeposition("Western Africa")   =2.4;
LuEtAl_NDeposition("Northern Africa")  =1.6;
LuEtAl_NDeposition("Southern Africa")  =3.8;
LuEtAl_NDeposition("Western Asia")     =2.1;
*we use Western asia for Middle East
LuEtAl_NDeposition("Central Asia")     =2.4;
LuEtAl_NDeposition("South-Eastern Asia")=6.0;
*Take for Eastern Asia the value for China, besides Japan and Mongolia, which are assigned further down.
LuEtAl_NDeposition("Eastern Asia")     =10.6;
*for Southern Asia, we take the same values as for South-Eastern Asia, besides India, which is assigned further down.
LuEtAl_NDeposition("Southern Asia")    =LuEtAl_NDeposition("South-Eastern Asia");

*Assign further missing values on regional level, according the the map in Figure 3 in the paper;

*Caribbean = Central America
LuEtAl_NDeposition("Caribbean")        =LuEtAl_NDeposition("Central America");
*Oceania = Canada
*this is on the level of continents, not subcontinents or countries, as all the rest
LuEtAl_NDeposition("Oceania")          =1.1;
*Middle Africa = Western Africa
LuEtAl_NDeposition("Middle Africa")    =LuEtAl_NDeposition("Western Africa");
*Southern Europe = Western Europe
LuEtAl_NDeposition("Southern Europe")  =LuEtAl_NDeposition("Western Europe");
*Northern Europe = Eastern Europe
LuEtAl_NDeposition("Northern Europe")  =LuEtAl_NDeposition("Eastern Europe");

*now assign the regional values to the single countries:

LuEtAl_NDeposition(FAOSTAT_CountriesAndRegions)
                 $(NOT LuEtAl_NDeposition(FAOSTAT_CountriesAndRegions))
         = sum(FAOSTAT_Regions$FAOSTAT_CountriesInRegions(FAOSTAT_Regions,FAOSTAT_CountriesAndRegions),
                 LuEtAl_NDeposition(FAOSTAT_Regions));

*now assign single country values as available from Lu et al. 2013 to replace the regional value assigned to those.
LuEtAl_NDeposition("Canada")             =1.1;
LuEtAl_NDeposition("United States of America")  =4.7;
LuEtAl_NDeposition("China")              =10.6;
*Mongolia is taken to be the same as South America
LuEtAl_NDeposition("Mongolia")           =LuEtAl_NDeposition("South America");
LuEtAl_NDeposition("Japan")              =9.7;
LuEtAl_NDeposition("India")              =15.8;

*and convert to tons N per ha:
LuEtAl_NDeposition(FAOSTAT_CountriesAndRegions)
         = LuEtAl_NDeposition(FAOSTAT_CountriesAndRegions)/1000;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) OTHER XXX Data

*NOT YET DONE - new and better data, etc.


$ontext;
after this, we have:
Parameter LuEtAl_NDeposition(FAOSTAT_CountriesAndRegions);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

*no new sets needed

*3.2) Link to the core model parameters

ActCropsGrass_Inputs(Regions,Crops,"N deposition (tN)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 LuEtAl_NDeposition(FAOSTAT_Countries));

ActForest_Inputs(Regions,"Forest","N deposition (tN)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 LuEtAl_NDeposition(FAOSTAT_Countries));

ActCropsGrass_Inputs(Regions,"Temporary meadows and pastures","N deposition (tN)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 LuEtAl_NDeposition(FAOSTAT_Countries));
ActCropsGrass_Inputs(Regions,"Permanent meadows and pastures","N deposition (tN)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 LuEtAl_NDeposition(FAOSTAT_Countries));


$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_Inputs(Regions,Activities,"N deposition (tN)","AllProdSyst","AllProdCond")
ActForest_Inputs(Regions,"Forest","N deposition (tN)","AllProdSyst","AllProdCond")

Regions         is      FAOSTAT_Countries
Activities      is      Crops, "Forest", temp/perm mead. and pastures
$offtext;




