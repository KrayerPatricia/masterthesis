PUTCLOSE con,"_V6_ReadData_IPCC2006_RiceCroppingEmissionsData";

$ontext;
GENERAL DESCRIPTION
This file assigns the per ha values for rice cropping CH4-emissions, based on IPCC 2006 calculations

DETAILED TABLE OF CONTENTS
- 1) CH4 emissions from rice cropping
- 2) OTHER XXX Data
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) CH4 emissions from rice cropping

$ontext;
From IPCC 2006 Volume 4, chapter 5:
Eq 5.1: CH4 from rice
         - Emission factor, depends on many variables, thus in detail in eq. 5.2

         Eq 5.2: CH4 emission factor for rice
                 - Basic EF without organic amendments (table 5.11): 1.30 kg CH4/ha/day, assuming 180 days of flooding, thus applying this factor not for 365 days (as unflooded rice has an EF = 0), but for 180 only.
                 - Scale factor for water regime (table 5.12/13)
                 - Scale factor for organic amendments (eq 5.3: quantity of amendment, plus table 5.14)
                 - Scale factor for soil type, variety, etc. : default = 1
However:
Tubiello et al. use an EF of about 125 kg CH4/ha/y as a global average, based on 156mio ha rice, 490miot CO2e, 25 GWP of methane
        IPCC 2006 as just described is 234 (1.3*180) - but Tubiello is more in line with other estimates
        that use differentiated approaches for different ecosystems, etc. - however, they refer the EF from IPCC 1996, Table 4.13
        THus: why IPCC 1996 and not 2006 and if 1996, why table 4.13 and not the more detailed 4.9?? - To be resolved....

but for now, we thus change to the average rate that results from Tubiellos assessment, i.e. about 125kg CH4/ha/y

TO BE IMPROVED LATER ON!!
$offtext;

Parameter IPCC2006_CH4_Rice(FAOSTAT_CountriesAndRegions);

*emission factor
*unit: t CH4/ha per year:
IPCC2006_CH4_Rice("World")
*         = 1.3*180;
         =0.125;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) OTHER XXX Data

*NOT YET DONE - new and better data, etc.



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

*no new sets needed

*3.2) Link to the core model parameters

ActCropsGrass_Outputs(Countries,"Rice, paddy","CH4 flooded rice (tCH4)","AllProdSyst","AllProdCond")
         = IPCC2006_CH4_Rice("World");



$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_Outputs(Countries,"Rice, paddy","CH4 flooded rice (t CH4)","AllProdSyst","AllProdCond")

Countries   is      FAOSTAT_Countries
$offtext;


