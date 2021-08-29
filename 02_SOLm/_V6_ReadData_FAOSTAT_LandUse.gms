PUTCLOSE con,"_V6_ReadData_FAOSTAT_LandUse";

$ontext;
GENERAL DESCRIPTION
This file reads the land use data from FAOSTAT

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
$ifthen %ReadNewFAOSTATLandUseData% == "YES"
*due to some unclear reason, reading in the csv-file does not work here - but transferring to excel and reading then works - thus do it from excel.
*$call csv2gdx FAOSTAT_LandUseNormalized_6_12_2017.csv id=FAOSTAT_LandUse Index=(2,4,6,8,9) Values=(10) UseHeader=Y
$call GDXXRW FAOSTAT_LandUseNormalized_6_12_2017.xlsx  o=FAOSTAT_LandUseNormalized_6_12_2017.gdx  index=index!a1:e2

$endif;

Parameter FAOSTAT_LandUse(FAOSTAT_CountriesAndRegions,FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,Years,FAOSTAT_LandUseUnits);

$gdxin FAOSTAT_LandUseNormalized_6_12_2017.gdx
$load FAOSTAT_LandUse
$gdxin


*ATTENTION: the unit is 1000ha


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) build average over the base year period chosen to get the baseline values

PARAMETER NumberOfBasisYearsFAOSTATLandUse;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....

NumberOfBasisYearsFAOSTATLandUse(FAOSTAT_CountriesAndRegions,FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,FAOSTAT_LandUseUnits)
         = SUM(BasisYears$FAOSTAT_LandUse(FAOSTAT_CountriesAndRegions,FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,BasisYears,FAOSTAT_LandUseUnits),1);
FAOSTAT_LandUse(FAOSTAT_CountriesAndRegions,FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear",FAOSTAT_LandUseUnits)
                 $NumberOfBasisYearsFAOSTATLandUse(FAOSTAT_CountriesAndRegions,FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,FAOSTAT_LandUseUnits)
         = SUM(BasisYears,FAOSTAT_LandUse(FAOSTAT_CountriesAndRegions,FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,BasisYears,FAOSTAT_LandUseUnits))
                 /NumberOfBasisYearsFAOSTATLandUse(FAOSTAT_CountriesAndRegions,FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,FAOSTAT_LandUseUnits);

*convert to hectares:
FAOSTAT_LandUse(FAOSTAT_CountriesAndRegions,FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","ha")
         = FAOSTAT_LandUse(FAOSTAT_CountriesAndRegions,FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","1000 ha")*1000;

*to avoid double counting: drop China subregions here and retain China only:
FAOSTAT_LandUse("China",FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","ha")
                 $(NOT FAOSTAT_LandUse("China",FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","ha"))
         = FAOSTAT_LandUse("China, Hong Kong SAR",FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","ha")
                 + FAOSTAT_LandUse("China, Macao SAR",FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","ha")
                 + FAOSTAT_LandUse("China, mainland",FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","ha")
                 + FAOSTAT_LandUse("China, Taiwan Province of",FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","ha");

FAOSTAT_LandUse("China, Hong Kong SAR",FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","ha") = 0;
FAOSTAT_LandUse("China, Macao SAR",FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","ha") = 0;
FAOSTAT_LandUse("China, mainland",FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","ha") = 0;
FAOSTAT_LandUse("China, Taiwan Province of",FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,"AverageBasisYear","ha") = 0;



$ontext;
after this, we have:
Parameter FAOSTAT_LandUse(FAOSTAT_CountriesAndRegions,FAOSTAT_LandUseItems,FAOSTAT_LandUseElements,Years,FAOSTAT_LandUseUnits);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

Set MatchFAOSTATLandUse_CropGrassActivities(FAOSTAT_LandUseItems,Activities)
/
"Fallow land (temporary)"                            ."Fallow land (temporary)"
"Perm. meadows & pastures - Cultivated"              ."Perm. meadows & pastures - Cultivated"
"Perm. meadows & pastures - Nat. growing"            ."Perm. meadows & pastures - Nat. growing"
"Perm. meadows & pastures Cult. non-irrig"           ."Perm. meadows & pastures Cult. non-irrig"
"Perm. meadows and pastures - Cult. & actually irrig"."Perm. meadows and pastures - Cult. & actually irrig"
"Permanent meadows and pastures"                     ."Permanent meadows and pastures"
"Temp. meadows & pastures non-irrig."                ."Temp. meadows & pastures non-irrig."
"Temp. meadows and pastures actually irrigated"      ."Temp. meadows and pastures actually irrigated"
"Temporary meadows and pastures"                     ."Temporary meadows and pastures"
/;

Set MatchFAOSTATLandUse_ForestActivities(FAOSTAT_LandUseItems,Activities)
/
"Forest"                                             ."Forest"
"Planted forest"                                     ."Planted forest"
"Primary forest"                                     ."Primary forest"
/;

*3.2) Link to the core model parameters
*for now, we assign only the following items.
*thus, we do not yet use the large number of other land use items provided in this data by FAOSTAT (see the set FAOSTAT_LandUseItems).
$ontext;
"Fallow land (temporary)"
"Forest"
"Planted forest"
"Primary forest"
"Perm. meadows & pastures - Cultivated"
"Perm. meadows & pastures - Nat. growing"
"Perm. meadows & pastures Cult. non-irrig"
"Perm. meadows and pastures - Cult. & actually irrig"
"Permanent meadows and pastures"
"Temp. meadows & pastures non-irrig."
"Temp. meadows and pastures actually irrigated"
"Temporary meadows and pastures"

In particular:
"Permanent meadows and pastures"
"Temporary meadows and pastures"
         together provide the grassland areas we use as a basis on country level, if there is no better data available.
$offtext;

*area harvested in hectares:
VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")
                 $(NOT VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_Countries,FAOSTAT_LandUseItems)$(MatchFAOSTATLandUse_CropGrassActivities(FAOSTAT_LandUseItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 FAOSTAT_LandUse(FAOSTAT_Countries,FAOSTAT_LandUseItems,"Area","AverageBasisYear","ha"));

VActForest_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_LandUseItems)$(MatchFAOSTATLandUse_ForestActivities(FAOSTAT_LandUseItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 FAOSTAT_LandUse(FAOSTAT_Countries,FAOSTAT_LandUseItems,"Area","AverageBasisYear","ha"));

$ontext;
After this we have the following in SOLm-entities:

VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")

Activities    is      FAOASTAT_LandUseItems (a subset of this, as above)
Regions       is      FAOSTAT_Countries
$offtext;
