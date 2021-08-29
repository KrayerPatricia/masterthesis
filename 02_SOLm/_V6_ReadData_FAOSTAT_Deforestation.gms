PUTCLOSE con,"_V6_ReadData_FAOSTAT_Deforestation";

$ontext;
GENERAL DESCRIPTION
This file reads the deforestation data from FAOSTAT
define and load Deforestation data from FAOSTAT
description of the data: http://faostat3.fao.org/mes/methodology_list/E, Methods & Standards - Methodology - Emissions-Land USe: Forest land

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
$ifthen %ReadNewFAOSTATDeforestationData% == "YES"
*due to some ununderstandable reason, reading in teh csv-file does not work here - but transferring to excel and reading then works - thus do it from excel.
*$call csv2gdx FAOSTAT_Deforestation_2_28_2018.csv id=FAOSTAT_Deforestation Index=(4,6,8,10,11) Values=(12) UseHeader=Y
$call GDXXRW FAOSTAT_Deforestation_2_28_2018.xlsx  o=FAOSTAT_Deforestation_2_28_2018.gdx  index=index!a1

$endif;

Parameter FAOSTAT_Deforestation(FAOSTAT_CountriesAndRegions,FAOSTAT_DeforestationElements,FAOSTAT_DeforestationItems,Years,FAOSTAT_DeforestationUnits);

$gdxin FAOSTAT_Deforestation_2_28_2018.gdx
$load FAOSTAT_Deforestation
$gdxin



*ATTENTION: the unit is 1000ha


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) build average over the base year period chosen to get the baseline values

PARAMETER NumberOfBasisYearsFAOSTATDeforestation;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....

NumberOfBasisYearsFAOSTATDeforestation(FAOSTAT_CountriesAndRegions,FAOSTAT_DeforestationElements,FAOSTAT_DeforestationItems,FAOSTAT_DeforestationUnits)
         = SUM(BasisYears$FAOSTAT_Deforestation(FAOSTAT_CountriesAndRegions,FAOSTAT_DeforestationElements,FAOSTAT_DeforestationItems,BasisYears,FAOSTAT_DeforestationUnits),1);
FAOSTAT_Deforestation(FAOSTAT_CountriesAndRegions,FAOSTAT_DeforestationElements,FAOSTAT_DeforestationItems,"AverageBasisYear",FAOSTAT_DeforestationUnits)
                 $NumberOfBasisYearsFAOSTATDeforestation(FAOSTAT_CountriesAndRegions,FAOSTAT_DeforestationElements,FAOSTAT_DeforestationItems,FAOSTAT_DeforestationUnits)
         = SUM(BasisYears,FAOSTAT_Deforestation(FAOSTAT_CountriesAndRegions,FAOSTAT_DeforestationElements,FAOSTAT_DeforestationItems,BasisYears,FAOSTAT_DeforestationUnits))
                 /NumberOfBasisYearsFAOSTATDeforestation(FAOSTAT_CountriesAndRegions,FAOSTAT_DeforestationElements,FAOSTAT_DeforestationItems,FAOSTAT_DeforestationUnits);

*convert to hectares:
FAOSTAT_Deforestation(FAOSTAT_CountriesAndRegions,FAOSTAT_DeforestationElements,FAOSTAT_DeforestationItems,"AverageBasisYear","ha")
         = FAOSTAT_Deforestation(FAOSTAT_CountriesAndRegions,FAOSTAT_DeforestationElements,FAOSTAT_DeforestationItems,"AverageBasisYear","1000 ha")*1000;

$ontext;
after this, we have:
Parameter FAOSTAT_Deforestation(FAOSTAT_CountriesAndRegions,FAOSTAT_DeforestationElements,FAOSTAT_DeforestationItems,Years,FAOSTAT_DeforestationUnits);
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

*no further assignments needed

*3.2) Link to the core model parameters

*derive the per ha deforestation values and related CO2e emissions from the relation between total agricultural land in a country and the reported deforestation values, averaged over the basis years.
*given the data description, this approach makes more sense than directly linking the deforestation values to the CHANGES in agricultural areas; thus, this latter approach that has been implemented
*in an earlier version of SOLm (V2) is not pursued here anymore.

*unit: ha deforestation per ha agricultural area, positive - if no deforestation occurs, this value is zero, as this is already coded like this in the FAO data
*THE FACTOR 0.8 accounts for the fact that agriculture is over-all responsible for about 80% of deforestation only
*                for a reference on this, see e.g. Kissinger G, Herold M, De Sy V. 2012 Drivers of deforestation and forest degradation: a synthesis report for REDDþ policymakers. Vancouver, Canada: Lexeme Consulting
ActCropsGrass_OtherChar(Regions,"All Crops","Deforestation (ha)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                                 AND FAOSTAT_LandUse(FAOSTAT_Countries,"Agricultural Area","Area","AverageBasisYear","ha")),
                 FAOSTAT_Deforestation(FAOSTAT_Countries,"Area","Net Forest conversion","AverageBasisYear","ha")*0.8
                         /FAOSTAT_LandUse(FAOSTAT_Countries,"Agricultural Area","Area","AverageBasisYear","ha"));
*unit: t CO2eq emissions from deforestation per ha agricultural area, positive - if no deforestation occurs, this value is zero, as this is already coded like this in the FAO data
*multiplication by 1000 as Gigagrams is kilotons
ActCropsGrass_OtherChar(Regions,"All Crops","Deforest GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                                 AND FAOSTAT_LandUse(FAOSTAT_Countries,"Agricultural Area","Area","AverageBasisYear","ha")),
                 FAOSTAT_Deforestation(FAOSTAT_Countries,"Net emissions/removals (CO2) (Forest land)","Net Forest conversion","AverageBasisYear","gigagrams")*0.8*1000
                         /FAOSTAT_LandUse(FAOSTAT_Countries,"Agricultural Area","Area","AverageBasisYear","ha"));

*assign to all crops:
ActCropsGrass_OtherChar(Regions,Crops,"Deforestation (ha)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"All Crops","Deforestation (ha)","AllProdSyst","AllProdCond");
ActCropsGrass_OtherChar(Regions,GrassActivities,"Deforestation (ha)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"All Crops","Deforestation (ha)","AllProdSyst","AllProdCond");

*set the combined "All crops" equal zero - in case it is there at all:
ActCropsGrass_OtherChar(Regions,"All Crops","Deforestation (ha)","AllProdSyst","AllProdCond")
         = 0;

ActCropsGrass_OtherChar(Regions,Crops,"Deforest GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"All Crops","Deforestation (ha)","AllProdSyst","AllProdCond");
ActCropsGrass_OtherChar(Regions,GrassActivities,"Deforest GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"All Crops","Deforestation (ha)","AllProdSyst","AllProdCond");

*set the combined "All crops" equal zero - in case it is there at all:
ActCropsGrass_OtherChar(Regions,"All Crops","Deforest GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 0;


*China and subregions is no issue, as there is no deforestation data for China in FAOSTAT


$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Regions,Activities,"Deforestation (ha)","AllProdSyst","AllProdCond")
ActCropsGrass_OtherChar(Regions,Activities,"Deforest GHG emissions (tCO2e)","AllProdSyst","AllProdCond")

Regions      is      FAOSTAT_Countries
Activities   is      all crop and grass activities
$offtext;






