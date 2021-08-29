PUTCLOSE con,"_V6_ReadAdditionalData_AnimalNumbers";

*GENERAL DESCRIPTION
*This file contains the code to read additional data for animal numbers, in particular for better/more detailed herd structures


*DETAILED TABLE OF CONTENTS
$ontext;
*1) Herd structure data from BioBam (EU)
*2) Updated baseline animal number values for the zhaw-no-feed-import scenario: zhaw_NoFeedImports

$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Herd structure data from BioBam (EU)

PARAMETER AnimalNumbers_BioBam(Regions,AnimalTypeInHerd)      "Animal numbers with herd structure as used as baseline in BioBam for the UNISECO project";
*see the excel sheet for further details, currently, this is data from CAPRI - year 2012
*UNITS: heads

$ifthen %IncludeExcel_AdditionalAnimalNumbersData% == "YES"
$call GDXXRW AnimalNumbersBioBam_12_6_2020.xlsx  o=AnimalNumbersBioBam_12_6_2020.gdx  index=index!a1
$endif;

$GDXIN AnimalNumbersBioBam_12_6_2020.gdx
$load AnimalNumbers_BioBam
$GDXIN


*THEN assign to the SOLm parameters and variables as needed

*the new data does not contain data for cyprus and Malta, thus use a subset of EU only to not loose the original data for these countries:

SET FAO_EuropeanUnion_NoCyprusNoMalta(Regions);
SET CyprusMalta(Regions) /Cyprus, Malta/;


FAO_EuropeanUnion_NoCyprusNoMalta(Regions) = FAO_EuropeanUnion(Regions) - CyprusMalta(Regions);

*unit: heads

VActAnimalsHead_QuantityActUnits.l(FAO_EuropeanUnion_NoCyprusNoMalta,"Cattle",CattleTypeInHerd,"AllProdSyst","AllProdCond")
         = AnimalNumbers_BioBam(FAO_EuropeanUnion_NoCyprusNoMalta,CattleTypeInHerd);




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Updated baseline animal number values for the zhaw-no-feed-import scenarios: zhaw_NoFeedImports, zhaw_NoFeedImports_a

*search label: switch on for Scenario "zhaw_NoFeedImports" and "zhaw_NoFeedImports_a"

*data from https://www.proviande.ch/sites/proviande/files/2020-05/Der%20Fleischmarkt%20im%20%C3%9Cberblick%20-%20Aktuelle%20Ausgabe.pdf
*year: 2017

*VActAnimalsHead_QuantityActUnits.l("Switzerland","Chickens","Living","AllProdSyst","AllProdCond") = 11408804;
*VActAnimalsHead_QuantityActUnits.l("Switzerland","Chickens","Meat Producing","AllProdSyst","AllProdCond") = 67475220;



