PUTCLOSE con,"_V6_ReadData_FAOSTAT_Population";

$ontext;
GENERAL DESCRIPTION
This file reads the population data from FAOSTAT

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
$ifthen %ReadNewFAOSTATPopulationData% == "YES"
$call csv2gdx FAOSTAT_PopulationNormalized_13_12_2017.csv id=FAOSTAT_Population Index=(2,4,6,8,9) Values=(10) UseHeader=Y
$endif;

Parameter FAOSTAT_Population(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,Years,FAOSTAT_PopulationUnits);

$gdxin FAOSTAT_PopulationNormalized_13_12_2017.gdx
$load FAOSTAT_Population
$gdxin

*ATTENTION - remind: unit is in 1000 heads!


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) build average over the base year period chosen to get the baseline values

Parameter NumberOfBasisYearsFAOSTATPopulation;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....

NumberOfBasisYearsFAOSTATPopulation(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,FAOSTAT_PopulationUnits)
         = SUM(BasisYears$FAOSTAT_Population(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,BasisYears,FAOSTAT_PopulationUnits),1);
FAOSTAT_Population(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYear",FAOSTAT_PopulationUnits)
                 $NumberOfBasisYearsFAOSTATPopulation(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,FAOSTAT_PopulationUnits)
         = SUM(BasisYears,FAOSTAT_Population(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,BasisYears,FAOSTAT_PopulationUnits))
                 /NumberOfBasisYearsFAOSTATPopulation(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,FAOSTAT_PopulationUnits);

*to avoid double counting: drop China subregions here and retain China only:
FAOSTAT_Population("China",FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYear",FAOSTAT_PopulationUnits)
                 $(NOT FAOSTAT_Population("China",FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYear",FAOSTAT_PopulationUnits))
         = FAOSTAT_Population("China, Hong Kong SAR",FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYear",FAOSTAT_PopulationUnits)
                 + FAOSTAT_Population("China, Macao SAR",FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYear",FAOSTAT_PopulationUnits)
                 + FAOSTAT_Population("China, mainland",FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYear",FAOSTAT_PopulationUnits)
                 + FAOSTAT_Population("China, Taiwan Province of",FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYear",FAOSTAT_PopulationUnits);

FAOSTAT_Population("China, Hong Kong SAR",FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYear",FAOSTAT_PopulationUnits) = 0;
FAOSTAT_Population("China, Macao SAR",FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYear",FAOSTAT_PopulationUnits) = 0;
FAOSTAT_Population("China, mainland",FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYear",FAOSTAT_PopulationUnits) = 0;
FAOSTAT_Population("China, Taiwan Province of",FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYear",FAOSTAT_PopulationUnits) = 0;


$ontext;
after this, we have:
PARAMETER FAOSTAT_Population(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,Years,FAOSTAT_PopulationUnits);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed


Set Match_FAOSTAT_PopulationElementsPopulationGroupsSOLm(FAOSTAT_PopulationElements,PopulationGroups)
/
"Total Population - Both sexes".PopulationAll
"Total Population - Female".Female
"Total Population - Male".Male
/;

*3.2) Link to the core model parameters

*factor 1000 to have it in single heads
VPopulationNumbers.l(Regions,PopulationGroups)
         = sum((FAOSTAT_PopulationElements,FAOSTAT_Countries)$(Match_FAOSTAT_PopulationElementsPopulationGroupsSOLm(FAOSTAT_PopulationElements,PopulationGroups)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                  FAOSTAT_Population(FAOSTAT_Countries,"Population - Est. & Proj.",FAOSTAT_PopulationElements,"AverageBasisYear","1000 persons"))*1000;

$ontext;
After this we have the following in SOLm-entities:

VPopulationNumbers.l(Regions,PopulationGroups)

Regions            is      FAOSTAT_Countries
PopulationGroups   is      PopulationAll, Male, Female
$offtext;


