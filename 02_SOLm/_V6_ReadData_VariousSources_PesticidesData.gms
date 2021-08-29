PUTCLOSE con,"_V6_ReadData_VariousSources_PesticidesData";

$ontext;
GENERAL DESCRIPTION
This file reads and/or assigns the values for pesticides use to the main output of the items (activities), using data from various sources, both qualitative and quantitative


DETAILED TABLE OF CONTENTS
- 1) Categorical pesticides use indices based on expert guesses
- 2) FAOSTAT pesticide use quantities
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Categorical pesticides use indices based on expert guesses

*this is based on three parameters, all based on expert guess:
*        global categorical variable on pesticide use intensity for each crop
*                these values are currently set globally, resp. for all crops at once in the excel files -
*        categorical indicator on the strictness of laws on pesticides for each nation
*        categorical indicator on the ease of access to pesticides for the farmers for each nation

*It is assumed that these indicators apply to conventional pesticides only - thus, set the values on strictness of laws and access for organic equal to conventional but for use level, intensity=0.

$ontext;
the following values apply for this model:

Rating Pesticide level per crop (PUI)
         0 No harmful pesticides used
         1 Low level of pesticide application
         2 Medium level of pesticide application
         3 High level of pesticide application / harmful pesticides used*
Rating Pesticide legislation per country (PL)
         0 All chem.-synthetic pesticides (WHO-classes 1-2) banned
         1 Rigid pesticide legislation and control excludes harmful pesticides*
         2 Average pesticide legislation and control
         3 Legislation does not preclude the use of harmful pesticides*
Rating Access to pesticides per country (AP)
         0 Farmers have no access to chem.-synthetic (WHO-classes 1-2) pesticides
         1 Only few farmers have access to chem.-synthetic pesticides (max. 10% of the cultivated land is treated with pesticides)
         2 Some farmers have access to chem.-synthetic pesticides (10-50% of the land that deserves treatment is treated)
         3 Many farmers have access to chem.-synthetic pesticides (min. 50% of the land that deserves treatment is treated)

* "harmful pesticides" according to WHO classification
$offtext;

*to arrive at aggregate pesticide use values, these three indicators are multiplied, thus resulting in a dimension-less index with values from 0 to 9


*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewVariousSourcesPesticideUseIndicesData% == "YES"
$call GDXXRW ExpertGuesses_PesticideUseIndices_26_8_2016.xlsx  o=ExpertGuesses_PesticideUseIndices_26_8_2016.gdx  index=index!a1:e4
*contains the pesticide use indices as described above
$endif;



*units: all are indices referring to countries and crops - thus can be interpreted as an index per ha - thus, on aggregation reporting higher values the more hectares are concerned, which is adequate.
*unit: index/ha
Parameter VariousSources_Pesticides_UseIntensity(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_Pesticides_Legislation(FAOSTAT_CountriesAndRegions);
Parameter VariousSources_Pesticides_Access(FAOSTAT_CountriesAndRegions);


$gdxin ExpertGuesses_PesticideUseIndices_26_8_2016.gdx
$load VariousSources_Pesticides_UseIntensity
$load VariousSources_Pesticides_Legislation
$load VariousSources_Pesticides_Access
$gdxin

*as explained above, the indicator to capture aggregate pesticide use level and danger of adversde impacts is built by multiplication of these three indicators:
Parameter VariousSources_Pesticides_AggregateUseLevel(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);

VariousSources_Pesticides_AggregateUseLevel(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems)
         = VariousSources_Pesticides_UseIntensity(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems)
                 *VariousSources_Pesticides_Legislation(FAOSTAT_CountriesAndRegions)
                         *VariousSources_Pesticides_Access(FAOSTAT_CountriesAndRegions);





****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) FAOSTAT pesticide use quantities

*STILL TO BE DOWNLOADED FROM THE FAOSTAT WEB and read int!!



$ontext;
after this, we have:
Parameter VariousSources_Pesticides_UseIntensity(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_Pesticides_Legislation(FAOSTAT_CountriesAndRegions);
Parameter VariousSources_Pesticides_Access(FAOSTAT_CountriesAndRegions);
Parameter VariousSources_Pesticides_AggregateUseLevel(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

*no new sets needed

*3.2) Link to the core model parameters

*we need the combined index only for the model, thus focus on that for allocating to all crops, etc.:
*this accounts for conventional pesticides only:
ActCropsGrass_OtherChar(Regions,Activities,"Aggreg. Pest. use level (index)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_Pesticides_AggregateUseLevel(FAOSTAT_Countries,FAOSTAT_CropProductionItems));


$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Regions,Activities,"Aggreg. Pest. use level (index)","AllProdSyst","AllProdCond")

Regions          is      FAOSTAT_Countries
Activities       is      FAOSTAT_CropProductionItems

*XXX STILL TO BE DONE:
Values for grass / forage / fodder crops!!!!
$offtext;
