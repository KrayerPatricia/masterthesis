PUTCLOSE con,"_V6_ReadData_VariousSources_HumanNutrientRequirements";

$ontext;
GENERAL DESCRIPTION
This file reads the human nutrient requirements and other characteristics of human (e.g. N excretion in faeces) from various sources


DETAILED TABLE OF CONTENTS
- 1) SOFI2012 data
         1.1) reading the excel-file and loading the parameters
         1.2) build average over the base year period chosen to get the baseline values
         1.3) Derive protein and fat requirements from calorie requirements
- 2) Walpole2012 data
         2.1) reading the excel-file and loading the parameters
         2.2) build average over the base year period chosen to get the baseline values
         2.3) Derive protein and fat requirements from calorie requirements
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
- 4) Human nutrien excretion
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) SOFI2012 data

*Source: SOFI2012 data ("State of Food Insecurity of the World - SOFI" from FAOSTAT, internal data from 2012 - this data is not publicly accessible, it seems)

*1.1) reading the excel-file and loading the parameters

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewSOFI2012HumanNutrReqData% == "YES"
$call  GDXXRW SOFI2012_HumanNutrientRequirementsData_17_12_2012.xlsx o=SOFI2012_HumanNutrientRequirementsData_17_12_2012.gdx   index = index!a1:e2
$endif;

Parameter SOFI2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,Years);

$gdxin SOFI2012_HumanNutrientRequirementsData_17_12_2012.gdx
$load SOFI2012_HumanCalorieRequirements
$gdxin


*1.2) build average over the base year period chosen to get the baseline values

Parameter NumberOfBasisYearsHumanCalorieRequirements;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....


*currently, this data is only available for the old basis year, thus use this data)
*thus we need this specific set:
Set BasisYearsOLD(Years)
/
2005*2009
/;

NumberOfBasisYearsHumanCalorieRequirements(FAOSTAT_CountriesAndRegions)
         = SUM(BasisYearsOLD$SOFI2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,BasisYearsOLD),1);
*and it is average data over m, f, children

*and we need the average population for these old years as well, for division to get the average values; thus calculate as well:
Parameter NumberOfBasisYearsOLDFAOSTATPopulation;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....

NumberOfBasisYearsOLDFAOSTATPopulation(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,FAOSTAT_PopulationUnits)
         = SUM(BasisYearsOLD$FAOSTAT_Population(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,BasisYearsOLD,FAOSTAT_PopulationUnits),1);

FAOSTAT_Population(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,"AverageBasisYearOLD",FAOSTAT_PopulationUnits)
                 $NumberOfBasisYearsOLDFAOSTATPopulation(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,FAOSTAT_PopulationUnits)
         = SUM(BasisYearsOLD,FAOSTAT_Population(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,BasisYearsOLD,FAOSTAT_PopulationUnits))
                 /NumberOfBasisYearsOLDFAOSTATPopulation(FAOSTAT_CountriesAndRegions,FAOSTAT_PopulationItems,FAOSTAT_PopulationElements,FAOSTAT_PopulationUnits);

SOFI2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,"AverageBasisYearOLD")
                 $(NumberOfBasisYearsHumanCalorieRequirements(FAOSTAT_CountriesAndRegions)
                                 *FAOSTAT_Population(FAOSTAT_CountriesAndRegions,"Population - Est. & Proj.","Total Population - Both sexes","AverageBasisYearOLD","1000 persons"))
         = SUM(BasisYearsOLD,SOFI2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,BasisYearsOLD)
                 *FAOSTAT_Population(FAOSTAT_CountriesAndRegions,"Population - Est. & Proj.","Total Population - Both sexes",BasisYearsOLD,"1000 persons"))
                         /(NumberOfBasisYearsHumanCalorieRequirements(FAOSTAT_CountriesAndRegions)
                                 *FAOSTAT_Population(FAOSTAT_CountriesAndRegions,"Population - Est. & Proj.","Total Population - Both sexes","AverageBasisYearOLD","1000 persons"));

*1.3) Derive protein and fat requirements from calorie requirements

*derive protein and fat requirements in grams from energy requirements in kcal by global factors (per capita and day)
*factors from the web:
*        Conversion of numeric energy requirements to protein requirement: *74/2063 = *0,03587 - corresponds about to some general value when googling - improve!!
*        Conversion of numeric energy requirements to fat requirement: *52/2063 = *0,0252 - corresponds about to some general value when googling - improve!!
*see also: http://www.livestrong.com/article/518666-how-much-protein-fat-carbohydrates-fiber-should-each-meal-have/;
*Currently, we use
*        the 15% rule (CF mails Barbara Bulingame) for protein: 15% of energy intake should be Protein and there are 4kcal per gram protein, thus: Calorie intake*0.15/4 = Protein intake: factor=0.0375
*                that is quite in line with the above factor.

Parameter SOFI2012_ParameterPerHumanHead(FAOSTAT_CountriesAndRegions,HumanNutrientRequirementsElements);

*we thus have:
SOFI2012_ParameterPerHumanHead(FAOSTAT_CountriesAndRegions,"kcal/cap/day (ADER)")
         = SOFI2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,"AverageBasisYearOLD");

SOFI2012_ParameterPerHumanHead(FAOSTAT_CountriesAndRegions,"g protein/cap/day")
         = SOFI2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,"AverageBasisYearOLD")
                 *0.0375;

SOFI2012_ParameterPerHumanHead(FAOSTAT_CountriesAndRegions,"g fat/cap/day")
         = SOFI2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,"AverageBasisYearOLD")
                 *0.0252;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Walpole2012 data

*Source: Walpole et al. 2012 (Walpole, Sarah Catherine, Prieto-Merino, David, Edwards, Phil, Cleland, John, Stevens, Gretchen and Roberts, Ian, 2012,
*The weight of nations: an estimation of adult human biomass, BMC Public Health 2012 12:439, https://doi.org/10.1186/1471-2458-12-439). Sarah Walpole sent us this data in 2012.

*2.1) reading the excel-file and loading the parameters

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewWalpole2012HumanNutrReqData% == "YES"
$call  GDXXRW Walpole2012_HumanNutrientRequirementsData_17_12_2012.xlsx o=Walpole2012_HumanNutrientRequirementsData_17_12_2012.gdx   index = index!a1:e2
$endif;

Parameter Walpole2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,Years);

$gdxin Walpole2012_HumanNutrientRequirementsData_17_12_2012.gdx
$load Walpole2012_HumanCalorieRequirements
$gdxin

*only provided for one year, therefore no averaging needed to get the baseline values - and no updating of the baseyear possible, thus always referring to AverageBasisYearOLD


*2.2) Derive protein and fat requirements from calorie requirements

*derive protein and fat requirements in grams from energy requirements in kcal by global factors (per capita and day)
*factors from the web:
*        Conversion of numeric energy requirements to protein requirement: *74/2063 = *0,03587 - corresponds about to some general value when googling - improve!!
*        Conversion of numeric energy requirements to fat requirement: *52/2063 = *0,0252 - corresponds about to some general value when googling - improve!!
*see also: http://www.livestrong.com/article/518666-how-much-protein-fat-carbohydrates-fiber-should-each-meal-have/;
*Currently, we use
*        the 15% rule (CF mails Barbara Bulingame) for protein: 15% of energy intake should be Protein and there are 4kcal per gram protein, thus: Calorie intake*0.15/4 = Protein intake: factor=0.0375
*                that is quite in line with the above factor.

Parameter Walpole2012_ParameterPerHumanHead(FAOSTAT_CountriesAndRegions,HumanNutrientRequirementsElements);

*we thus have:
Walpole2012_ParameterPerHumanHead(FAOSTAT_CountriesAndRegions,"kcal/cap/day (ADER)")
         = Walpole2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,"AverageBasisYearOLD");

Walpole2012_ParameterPerHumanHead(FAOSTAT_CountriesAndRegions,"g protein/cap/day")
         = Walpole2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,"AverageBasisYearOLD")
                 *0.0375;

Walpole2012_ParameterPerHumanHead(FAOSTAT_CountriesAndRegions,"g fat/cap/day")
         = Walpole2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,"AverageBasisYearOLD")
                 *0.0252;



$ontext;
after this, we have:
Parameter SOFI2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,Years);
Parameter SOFI2012_ParameterPerHumanHead(FAOSTAT_CountriesAndRegions,HumanNutrientRequirementsElements);
Parameter Walpole2012_HumanCalorieRequirements(FAOSTAT_CountriesAndRegions,Years);
Parameter Walpole2012_ParameterPerHumanHead(FAOSTAT_CountriesAndRegions,HumanNutrientRequirementsElements);
$offtext;




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

Set Match_PerHeadReqSOFI_PerHeadReqSOLm(HumanNutrientRequirementsElements,Humans_InputsOutputsOtherCharacteristics)
/
"kcal/cap/day (ADER)"."kcal/cap/day (ADER) SOFI2012"
"kcal/cap/day (MDER)"."kcal/cap/day (MDER) SOFI2012"
"g protein/cap/day"."g protein/cap/day SOFI2012"
"g fat/cap/day"."g fat/cap/day SOFI2012"
/;

Set Match_PerHeadReqWalpole_PerHeadReqSOLm(HumanNutrientRequirementsElements,Humans_InputsOutputsOtherCharacteristics)
/
"kcal/cap/day (ADER)"."kcal/cap/day (ADER) Walpole2012"
"kcal/cap/day (MDER)"."kcal/cap/day (MDER) Walpole2012"
"g protein/cap/day"."g protein/cap/day Walpole2012"
"g fat/cap/day"."g fat/cap/day Walpole2012"
/;

*3.2) Link to the core model parameters
*here, we have two data sources, which we retain to be able to choose later

HumanCharacteristics(Regions,"PopulationAll",Humans_InputsOutputsOtherCharacteristics,"All commodities")
         =sum((HumanNutrientRequirementsElements,FAOSTAT_Countries)$(Match_PerHeadReqSOFI_PerHeadReqSOLm(HumanNutrientRequirementsElements,Humans_InputsOutputsOtherCharacteristics)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 SOFI2012_ParameterPerHumanHead(FAOSTAT_Countries,HumanNutrientRequirementsElements));

HumanCharacteristics(Regions,"PopulationAll",Humans_InputsOutputsOtherCharacteristics,"All commodities")
                 $(NOT HumanCharacteristics(Regions,"PopulationAll",Humans_InputsOutputsOtherCharacteristics,"All commodities"))
         =sum((HumanNutrientRequirementsElements,FAOSTAT_Countries)$(Match_PerHeadReqWalpole_PerHeadReqSOLm(HumanNutrientRequirementsElements,Humans_InputsOutputsOtherCharacteristics)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 Walpole2012_ParameterPerHumanHead(FAOSTAT_Countries,HumanNutrientRequirementsElements));



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Human nutrien excretion
*N in human facese per capita and year; source: see MA from Kevin DeLuca (and add references here), and also SOLm Documentation
HumanCharacteristics(Regions,"PopulationAll","N excretion in human faeces (tN)","All commodities")
                 $VPopulationNumbers.l(Regions,"PopulationAll")
        = 0.0045;

$ontext;
After this we have the following in SOLm-entities:

HumanCharacteristics(Regions,"PopulationAll",Humans_InputsOutputsOtherCharacteristics,"All commodities")

Regions                                     is      FAOSTAT_Countries
Humans_InputsOutputsOtherCharacteristics    is      Human Nutrient Requirements
                                                                 most basic: kcal, g prot, g fat per cap and day
                                                                 from TWO SOURCES: Walpole2012 and SOFI2012
$offtext;


