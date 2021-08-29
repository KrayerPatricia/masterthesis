PUTCLOSE con,"_V6_ReadAdditionalData_FeedData";

*GENERAL DESCRIPTION
*This file contains the code to read additional data for feed, in particular for better/more detailed data in imports


*DETAILED TABLE OF CONTENTS
$ontext;
*1) Feed import data for Switzerland

$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Feed import data for Switzerland

PARAMETER FeedData_ImportsToCH(Regions,Commodities)      "Feed imports to Switzerland";
*see the excel sheet for further details;
*this data is from the year 2018 and it is available in much more details, but additional feedstuff is all of very minor importance only.
*furthermore, the data contains detailed information on countries of origin, but onyl direct trade partners (i.e. soy can come from the Netherlands, albeit it is produced in Brazil).

*UNITS: tons

$ifthen %IncludeExcel_AdditionalFeedData% == "YES"
*original File from Patriciy Krayer zhaw, 28.5.2020: zolltarifnummern futtermittel_uebersicht_200528_kray.xlsb
$call GDXXRW zolltarifnummern_futtermittel_uebersicht_200528_kray.xlsx  o=FeedData_CH_28_5_2020.gdx  index=Index!a1
$endif;

$GDXIN FeedData_CH_28_5_2020.gdx
$load FeedData_ImportsToCH
$GDXIN


*THEN assign to the SOLm parameters and variables as needed

*unit: tons

VImportQuantity_Feed.l("Switzerland","World",Commodities,"AllProdSyst","AllProdCond")
         = FeedData_ImportsToCH("World",Commodities);






