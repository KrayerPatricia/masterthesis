PUTCLOSE con,"_V6_ReadAdditionalData_Prices";

*GENERAL DESCRIPTION
*This file contains the code to read additional data for commodity prices


*DETAILED TABLE OF CONTENTS
$ontext;
*1) Additional price data

$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Additional price data

PARAMETER PriceMedian(Regions,Commodities)       Median of FAOSTAT Producer prices [$ per ton] over Countries per FAOSTATRegion;
PARAMETER ConsPrice(Commodities)       [CHF per kg];


$ifthen %IncludeExcel_AdditionalPriceData% == "YES"
*import median FAOSTAT data
$call GDXXRW AdditionalPriceData_26_05_2020.xlsx  o=AdditionalPriceData_26_05_2020.gdx  index=index!a1
* import coop consumer price data (17.10.2019)
$call GDXXRW Coop_PriceData_17_10_2019.xlsx o=Coop_PriceData_17_10_2019.gdx index=index!a1
$endif;

$GDXIN AdditionalPriceData_26_05_2020.gdx
$load PriceMedian
$GDXIN

$gdxin Coop_PriceData_17_10_2019.gdx
$load ConsPrice
$gdxin


*THEN assign to the SOLm parameters as needed, assigning regional values to countries for the commodities where values are yet missing;
*this is regional median price data, where these median values are calucalted separately outside SOLm (hence they are read above):

*unit: Producer price in $/ton

Commod_OtherChar(Regions_2,Commodities,"Producer price ($)","AllProdSyst","AllProdCond")
         $(NOT Commod_OtherChar(Regions_2,Commodities,"Producer price ($)","AllProdSyst","AllProdCond"))
         = SUM(Regions$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
         PriceMedian(Regions,Commodities));



$exit;

*DO NOT USE THIS COOP data for now - has been specifically needed for the NFP69 project

*Exchange rate CHF-$ is close to parity (since 3 years between 0.92 and 1.02), thus quite stable -> no exchange rate needed
*From kg to t conversion below
*factor 0.6 to proxy producer price (on the gross trade level used in FAOSTAT) from coop consumer prices

Commod_OtherChar(Regions_2,Commodities,"Producer price ($)","AllProdSyst","AllProdCond")
         $(NOT Commod_OtherChar(Regions_2,Commodities,"Producer price ($)","AllProdSyst","AllProdCond"))
         = (0.6 * ConsPrice(Commodities)) * 1000;





