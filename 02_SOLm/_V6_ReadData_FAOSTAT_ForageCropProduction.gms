PUTCLOSE con,"_V6_ReadData_FAOSTAT_ForageCropProduction";

$ontext;
GENERAL DESCRIPTION
This file reads the forage crop production data from FAOSTAT - which has been sent to us by mail from FAOSTAT, as it is not publicly available
        cf. mail from 25.9.2018 from Kovrova, Irina (ESS) <Irina.Kovrova@fao.org>
                (mails before with Cc: Tayyib, Salar (ESS) <Salar.Tayyib@fao.org>; FAOSTAT <FAOSTAT@fao.org>)
IMPORTANT: This data has not been officially validated by FAOSTAT - they indicate that the data is not as reliable as the data made publicly available!!
the original file is "Production_Fodder crops 1990_2017_export SWS official 25.09.2018.xlsx" sent per mail on 25.9.2018


DETAILED TABLE OF CONTENTS
- 1) reading the csv-file and loading the parameters
- 2) build average over the base year period chosen to get the baseline values
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
- 3.3) Add some additional data
$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) reading the csv-file and loading the parameters

*read csv files from FAOSTAT into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewFAOSTATForageCropProductionData% == "YES"
$call csv2gdx FAOSTAT_ForageCropProduction_25_9_2018.csv id=FAOSTAT_ForageCropProduction Index=(2,4,6,8) Values=(9) UseHeader=Y FieldSep=Semicolon
*contains FAO forage crop production data: areas harvested production quantitites
*no separate column read in for the unit, as the unit is part of the name of the element
$endif;

Set FAOSTAT_ForageCropProductionItems
/
"Alfalfa for forage"
"Beet, for forage"
"Cabbage, for forage"
"Carrots, for forage"
"Clover, for forage"
"Maize for forage"
"Other grasses, for forage"
"Other legumes, for forage"
"Other oilseeds, for forage"
"Rye grass, for forage"
"Sorghum, for forage"
"Swedes, for forage"
"Turnips, for forage"
/;

Set FAOSTAT_ForageCropProductionElements
/
"Area Harvested [ha]"
"Production [t]"
"Yield [t/ha]"
/;

Parameter FAOSTAT_ForageCropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,FAOSTAT_ForageCropProductionElements,Years);

$gdxin FAOSTAT_ForageCropProduction_25_9_2018.gdx
$load FAOSTAT_ForageCropProduction
$gdxin

*in the forage data, the units are included in the elements, thus separate those in a new parameter:
Parameter FAOSTAT_ForageCropProduction2(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits);

FAOSTAT_ForageCropProduction2(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,"Area harvested",Years,"ha")
         = FAOSTAT_ForageCropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,"Area harvested [ha]",Years);
FAOSTAT_ForageCropProduction2(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,"Production",Years,"tonnes")
         = FAOSTAT_ForageCropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,"Production [t]",Years);
*yields has almost no data, so we do not file it in but derive it from dividing production by areas - after averaging over the baseline.

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) build average over the base year period chosen to get the baseline values

PARAMETER NumberOfBasisYearsFAOSTATForageCropProduction;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....
*a specific prodcedure for seeds is needed, as seeds reported in year t-1 are used in year t and not in t-1.

NumberOfBasisYearsFAOSTATForageCropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,FAOSTAT_CropProductionUnits)
         = SUM(BasisYears$FAOSTAT_ForageCropProduction2(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,BasisYears,FAOSTAT_CropProductionUnits),1);
FAOSTAT_ForageCropProduction2(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,"AverageBasisYear",FAOSTAT_CropProductionUnits)
                 $NumberOfBasisYearsFAOSTATForageCropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,FAOSTAT_CropProductionUnits)
         = SUM(BasisYears,FAOSTAT_ForageCropProduction2(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,BasisYears,FAOSTAT_CropProductionUnits))
                 /NumberOfBasisYearsFAOSTATForageCropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements_NotYieldNotSeed,FAOSTAT_CropProductionUnits);


*to avoid double counting: drop China subregions here and retain China only:
FAOSTAT_ForageCropProduction2("China",FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 $(NOT FAOSTAT_ForageCropProduction2("China",FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits))
         = FAOSTAT_ForageCropProduction2("China, Hong Kong SAR",FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 + FAOSTAT_ForageCropProduction2("China, Macao SAR",FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 + FAOSTAT_ForageCropProduction2("China, mainland",FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits)
                 + FAOSTAT_ForageCropProduction2("China, Taiwan Province of",FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits);

FAOSTAT_ForageCropProduction2("China, Hong Kong SAR",FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;
FAOSTAT_ForageCropProduction2("China, Macao SAR",FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;
FAOSTAT_ForageCropProduction2("China, mainland",FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;
FAOSTAT_ForageCropProduction2("China, Taiwan Province of",FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits) = 0;


*derive the average yields:
*we first need to use the FAOSTAT unit hg/ha, as only this is in the units set, thus multiply by 10000
FAOSTAT_ForageCropProduction2(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,"Yield","AverageBasisYear","hg/ha")
                 $FAOSTAT_ForageCropProduction2(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,"Area harvested","AverageBasisYear","ha")
         = FAOSTAT_ForageCropProduction2(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,"Production","AverageBasisYear","tonnes")
                 /FAOSTAT_ForageCropProduction2(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,"Area harvested","AverageBasisYear","ha")*10000;

$ontext;
after this, we have
Parameter FAOSTAT_CropProduction2(FAOSTAT_CountriesAndRegions,FAOSTAT_ForageCropProductionItems,FAOSTAT_CropProductionElements,Years,FAOSTAT_CropProductionUnits);
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

*assign the crop primary production to activities:
Set MatchFAOSTATForageCropProduction_Activities(FAOSTAT_ForageCropProductionItems,Activities)
/
"Maize for forage"."Maize For Forage+Silage"
"Alfalfa for forage"."Alfalfa For Forage+Silag"
"Clover, for forage"."Clover For Forage+Silage"
"Other legumes, for forage"."Leguminous Nes,For+Sil"
*"Forage Products Nes"

*other fodder crops
"Beet, for forage"."Beets For Fodder"
"Swedes, for forage"."Swedes For Fodder"
"Turnips, for forage"."Turnips For Fodder"
*"Vegetables+Roots,Fodder"

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
"Cabbage, for forage"."Cabbage, for forage"
"Carrots, for forage"."Carrots, for forage"
"Other grasses, for forage"."Other grasses, for forage"
"Other oilseeds, for forage"."Other oilseeds, for forage"
"Rye grass, for forage"."Rye grass, for forage"
"Sorghum, for forage"."Sorghum, for forage"
/;

*assign the forage crops to other crops for assigning seed input values:
Set MatchForageCropsOtherCropsForSeed(Activities,Activities_2)
/
"Maize"."Maize For Forage+Silage"
"Lentils"."Alfalfa For Forage+Silag"
"Lentils"."Clover For Forage+Silage"
"Lentils"."Leguminous Nes,For+Sil"
*"Forage Products Nes"

*other fodder crops
"Sugar beet"."Beets For Fodder"
"Sugar beet"."Swedes For Fodder"
"Sugar beet"."Turnips For Fodder"
*"Vegetables+Roots,Fodder"

*additionally added from FAOSTAT ForageCrop data, items that do not fit to one from the above:
"Cabbages and other brassicas"."Cabbage, for forage"
"Carrots and turnips"."Carrots, for forage"
*"Other grasses, for forage"."Other grasses, for forage"
"Rapeseed"."Other oilseeds, for forage"
*"Rye grass, for forage"."Rye grass, for forage"
"Sorghum"."Sorghum, for forage"
/;

*3.2) Link to the core model parameters

VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")
                 $(NOT VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_Countries,FAOSTAT_ForageCropProductionItems)$(MatchFAOSTATForageCropProduction_Activities(FAOSTAT_ForageCropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 FAOSTAT_ForageCropProduction2(FAOSTAT_Countries,FAOSTAT_ForageCropProductionItems,"Area harvested","AverageBasisYear","ha"));

VActCropsGrass_Outputs.l(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
                 $(NOT VActCropsGrass_Outputs.l(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_Countries,FAOSTAT_ForageCropProductionItems)$(MatchFAOSTATForageCropProduction_Activities(FAOSTAT_ForageCropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 FAOSTAT_ForageCropProduction2(FAOSTAT_Countries,FAOSTAT_ForageCropProductionItems,"Production","AverageBasisYear","tonnes"));

*division by 10000 to get from hg to tons again
ActCropsGrass_Outputs(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
                 $(NOT ActCropsGrass_Outputs(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_Countries,FAOSTAT_ForageCropProductionItems)$(MatchFAOSTATForageCropProduction_Activities(FAOSTAT_ForageCropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 FAOSTAT_ForageCropProduction2(FAOSTAT_Countries,FAOSTAT_ForageCropProductionItems,"Yield","AverageBasisYear","hg/ha"))/10000;


*3.3) Add some additional data
*seed input data is not available for forage crops, thus assign based on other crops:
ActCropsGrass_Inputs(Regions,Activities_2,"Seeds (t)","AllProdSyst","AllProdCond")
         = sum(Activities$MatchForageCropsOtherCropsForSeed(Activities,Activities_2),
                 ActCropsGrass_Inputs(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond"));
*and assign for grasses by hand, using a value from the SWISS DBK for Kusntwiesen: 33kg/ha - rounded up:
ActCropsGrass_Inputs(Regions,"Other grasses, for forage","Seeds (t)","AllProdSyst","AllProdCond")
                 $ActCropsGrass_Outputs(Regions,"Other grasses, for forage","MainOutput1 (t)","AllProdSyst","AllProdCond")
         = 0.04;
ActCropsGrass_Inputs(Regions,"Rye grass, for forage","Seeds (t)","AllProdSyst","AllProdCond")
                 $ActCropsGrass_Outputs(Regions,"Rye grass, for forage","MainOutput1 (t)","AllProdSyst","AllProdCond")
         = 0.04;


$ontext;
After this we have the following in SOLm-entities:

VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")
VActCropsGrass_Outputs.l(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
ActCropsGrass_Outputs(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
ActCropsGrass_Inputs(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")

Regions       is      FAOSTAT_Countries
Activities    is      FAOSTAT_ForageCropProductionItems
$offtext;








