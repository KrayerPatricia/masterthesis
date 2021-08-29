PUTCLOSE con,"_V6_ReadData_FAOSTAT_Fertilizers";

$ontext;
GENERAL DESCRIPTION
This file reads the fertilizer data from FAOSTAT

DETAILED TABLE OF CONTENTS
- 1) reading the csv-file and loading the parameters
- 2) build average over the base year period chosen to get the baseline values
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) reading the csv-file and loading the parameters

*read csv files from FAOSTAT into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewFAOSTATFertilizerData% == "YES"
$call csv2gdx FAOSTAT_FertilizersNormalized_12_12_2017.csv id=FAOSTAT_Fertilizers Index=(2,4,6,8,9) Values=(10) UseHeader=Y
$endif;

Parameter FAOSTAT_Fertilizers(FAOSTAT_CountriesAndRegions,FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,Years,FAOSTAT_FertilizerUnits);

$gdxin FAOSTAT_FertilizersNormalized_12_12_2017.gdx
$load FAOSTAT_Fertilizers
$gdxin


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) build average over the base year period chosen to get the baseline values

PARAMETER NumberOfBasisYearsFAOSTATFertilizers;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....


NumberOfBasisYearsFAOSTATFertilizers(FAOSTAT_CountriesAndRegions,FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,FAOSTAT_FertilizerUnits)
         = SUM(BasisYears$FAOSTAT_Fertilizers(FAOSTAT_CountriesAndRegions,FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,BasisYears,FAOSTAT_FertilizerUnits),1);
FAOSTAT_Fertilizers(FAOSTAT_CountriesAndRegions,FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,"AverageBasisYear",FAOSTAT_FertilizerUnits)
                 $NumberOfBasisYearsFAOSTATFertilizers(FAOSTAT_CountriesAndRegions,FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,FAOSTAT_FertilizerUnits)
         = SUM(BasisYears,FAOSTAT_Fertilizers(FAOSTAT_CountriesAndRegions,FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,BasisYears,FAOSTAT_FertilizerUnits))
                 /NumberOfBasisYearsFAOSTATFertilizers(FAOSTAT_CountriesAndRegions,FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,FAOSTAT_FertilizerUnits);

*to avoid double counting: drop China subregions here and retain China only:
FAOSTAT_Fertilizers("China",FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,"AverageBasisYear",FAOSTAT_FertilizerUnits)
                 $(NOT FAOSTAT_Fertilizers("China",FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,"AverageBasisYear",FAOSTAT_FertilizerUnits))
         = FAOSTAT_Fertilizers("China, Hong Kong SAR",FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,"AverageBasisYear",FAOSTAT_FertilizerUnits)
                 + FAOSTAT_Fertilizers("China, Macao SAR",FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,"AverageBasisYear",FAOSTAT_FertilizerUnits)
                 + FAOSTAT_Fertilizers("China, mainland",FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,"AverageBasisYear",FAOSTAT_FertilizerUnits)
                 + FAOSTAT_Fertilizers("China, Taiwan Province of",FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,"AverageBasisYear",FAOSTAT_FertilizerUnits);

FAOSTAT_Fertilizers("China, Hong Kong SAR",FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,"AverageBasisYear",FAOSTAT_FertilizerUnits) = 0;
FAOSTAT_Fertilizers("China, Macao SAR",FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,"AverageBasisYear",FAOSTAT_FertilizerUnits) = 0;
FAOSTAT_Fertilizers("China, mainland",FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,"AverageBasisYear",FAOSTAT_FertilizerUnits) = 0;
FAOSTAT_Fertilizers("China, Taiwan Province of",FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,"AverageBasisYear",FAOSTAT_FertilizerUnits) = 0;


$ontext;
after this, we have:
Parameter FAOSTAT_Fertilizers(FAOSTAT_CountriesAndRegions,FAOSTAT_FertilizerItems,FAOSTAT_FertilizerElements,Years,FAOSTAT_FertilizerUnits);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

*no further assignments needed

*3.2) Link to the core model parameters

*unit is tons N, P2O5, K2O!!
VMineralFertilizerQuantity.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 FAOSTAT_Fertilizers(FAOSTAT_Countries,"Nitrogen Fertilizers (N total nutrients)","Consumption in nutrients","AverageBasisYear","tonnes of nutrients"));

VMineralFertilizerQuantity.l(Regions,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 FAOSTAT_Fertilizers(FAOSTAT_Countries,"Phosphate Fertilizers (P205 total nutrients)","Consumption in nutrients","AverageBasisYear","tonnes of nutrients"));

VMineralFertilizerQuantity.l(Regions,"mineral K fert (K2O)","AllMinFertProdTech","AllProdSyst")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 FAOSTAT_Fertilizers(FAOSTAT_Countries,"Potash Fertilizers (K20 total nutrients)","Consumption in nutrients","AverageBasisYear","tonnes of nutrients"));



$ontext;
After this we have the following in SOLm-entities:

VMineralFertilizerQuantity.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst")
VMineralFertilizerQuantity.l(Regions,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")
VMineralFertilizerQuantity.l(Regions,"mineral K fert (K2O)","AllMinFertProdTech","AllProdSyst")

Regions   is      FAOSTAT_Countries
$offtext;





