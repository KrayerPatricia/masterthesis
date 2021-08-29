PUTCLOSE con,"_V6_ReadData_IPCC_GWP_GTPData";

$ontext;
GENERAL DESCRIPTION
this files provides values for the GWP and GTP to be used

DETAILED TABLE OF CONTENTS
- 1) GWP from IPCC 2006
- 2) GWP from IPCC 2013
- 3) GWP for Biogenic CH4
- 4) Assign values to core model parameters and variables
         4.1) Link some sets as needed
         4.2) Link to the core model parameters
$offtext;



*MODEL CODE:

$if %GWP_GTP_Choice% == "IPCC2006" $goto GWP_GTP_IPCC2006
$if %GWP_GTP_Choice% == "IPCC2013" $goto GWP_GTP_IPCC2013
$if %GWP_GTP_Choice% == "IPCC2006_BiogenCH4" $goto GWP_GTP_IPCC2006_BiogenCH4
$if %GWP_GTP_Choice% == "IPCC2013_BiogenCH4" $goto GWP_GTP_IPCC2013_BiogenCH4



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) GWP from IPCC2006 (originally from the IPCC TAR 2001, WGI, Chapter 6)

$label GWP_GTP_IPCC2006

*choose the IPCC 2006 values:
GWP_GTP_SOLm("CO2") = 1;
GWP_GTP_SOLm("CH4") = 25;
GWP_GTP_SOLm("N2O") = 298;

$goto EndOf_GWP_GTP

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) GWP from IPCC 2013

$label GWP_GTP_IPCC2013

*from AR5 WG1 Chapter 8, p714
GWP_GTP_SOLm("CO2") = 1;
GWP_GTP_SOLm("CH4") = 34;
GWP_GTP_SOLm("N2O") = 298;

$goto EndOf_GWP_GTP

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) GWP for Biogenic CH4

*in our model, all CH4 sources are biogenic; we thus can use the biogenic GWP for methane,
*        which is essentially the GWP of methane, corrected for by the CO2 that has been absorbed from the atmosphere
*        before the methane has been emitted, and which has ultimately been used to produce this methane (or at least the C in it).
*        This reduces the GWP by about 1

*thus use:
*3.1) Biogenic CH4 IPCC 2006

$label GWP_GTP_IPCC2006_BiogenCH4

GWP_GTP_SOLm("CO2") = 1;
GWP_GTP_SOLm("CH4") = 24;
GWP_GTP_SOLm("N2O") = 298;

$goto EndOf_GWP_GTP

*3.2) Biogenic CH4 IPCC 2013

$label GWP_GTP_IPCC2013_BiogenCH4

GWP_GTP_SOLm("CO2") = 1;
GWP_GTP_SOLm("CH4") = 33;
GWP_GTP_SOLm("N2O") = 298;

$goto EndOf_GWP_GTP


$label EndOf_GWP_GTP

$ontext;
after this, we have:
Parameter GWP_GTP(GreenhouseGases);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Assign values to core model parameters and variables


*4.1) Link some sets as needed

*no new sets needed

*4.2) Link to the core model parameters

*no assignment needed - already coded in the final parameter

$ontext;
After this we have the following in SOLm-entities:

GWP_GTP_SOLm(GreenhouseGases)

*XXX STILL TO BE DONE:
Check and imüprove the value for biogenic CH4!!
$offtext;


