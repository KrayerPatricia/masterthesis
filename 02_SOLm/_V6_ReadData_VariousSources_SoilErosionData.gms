PUTCLOSE con,"_V6_ReadData_VariousSources_SoilErosionData";

$ontext;
GENERAL DESCRIPTION
This file reads and/or assigns the values for soil erosion and land degradation to the main output of the items (activities):
The calculations then use soil erosion rates, i.e. soil lost per ha, and land degradation indices, that differentiates crops for how much they may ather foster additional erosion.
this degradation index is used as a weight when assigning soil erosion rates to crops (see below).
the soil erosion rate is filed in from excel, the degradation index is directly assigned here in the GAMS-code (see below)

The data is based on a iterature review under taken in the course of the master thesis of Patrizia Schwegler 2013,
the references used are displayed in VariousSources_SoilErosionData_28_8_2016.

DETAILED TABLE OF CONTENTS
- 1) Soil water erosion data
- 2) Soil wind erosion data
- 3) Land degradation data
- 4) Soil erosion values weighted by land degradation
- 5) Assign values to core model parameters and variables
         5.1) Link some sets as needed
         5.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Soil water erosion data

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewVariousSourcesSoilErosionData% == "YES"
$call GDXXRW VariousSources_SoilErosionData_28_8_2016.xlsx  o=VariousSources_SoilErosionData_28_8_2016.gdx  index=index!a1:e3
*contains the soil erosion data
*ATTENTION: this file contains some additional data that is not used - may check at a later point whether to use it or not.
$endif;

*units: t soil lost /ha/year
*we use two parameters for crops and grass separately
Parameter VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_CountriesAndRegions);
Parameter VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_CountriesAndRegions);

$gdxin VariousSources_SoilErosionData_28_8_2016.gdx
$load  VariousSources_SoilWaterErosionRatesCrops
$load  VariousSources_SoilWaterErosionRatesGrass
$gdxin

*erosion rates are given for some countries only; use these values to assign the same number to all countries in the same region
*do this by taking area-weighted averages within sub-regions; for this, use FAO LandUse data on grassland and arable land

*build regional averages based on the country valueas available, weighted with the respective areas;
*This is done by summing over the countries conditional to the "countries in regions"-two-dimensional set, which then controls that the correct values are taken for each region
*        for crops, this is this is arable land, which includes temporary meadows and pastures (according to land use item definitions from FAOSTAT)
VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_Regions)
                 $(sum(FAOSTAT_Countries$FAOSTAT_CountriesInRegions(FAOSTAT_Regions,FAOSTAT_Countries),
                         FAOSTAT_LandUse(FAOSTAT_Countries,"Arable land","Area","AverageBasisYear","ha")))
         =(sum(FAOSTAT_Countries$FAOSTAT_CountriesInRegions(FAOSTAT_Regions,FAOSTAT_Countries),
                 VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_Countries)
                         *FAOSTAT_LandUse(FAOSTAT_Countries,"Arable land","Area","AverageBasisYear","ha")))
                 /(sum(FAOSTAT_Countries$FAOSTAT_CountriesInRegions(FAOSTAT_Regions,FAOSTAT_Countries),
                         FAOSTAT_LandUse(FAOSTAT_Countries,"Arable land","Area","AverageBasisYear","ha")));

*        for grassland, this is Permanent meadows and pastures only, without temporary meadows and pastures (according to land use item definitions from FAOSTAT)
VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Regions)
                 $(sum(FAOSTAT_Countries$FAOSTAT_CountriesInRegions(FAOSTAT_Regions,FAOSTAT_Countries),
                         FAOSTAT_LandUse(FAOSTAT_Countries,"Permanent meadows and pastures","Area","AverageBasisYear","ha")))
         =(sum(FAOSTAT_Countries$FAOSTAT_CountriesInRegions(FAOSTAT_Regions,FAOSTAT_Countries),
                 VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Countries)
                         *FAOSTAT_LandUse(FAOSTAT_Countries,"Permanent meadows and pastures","Area","AverageBasisYear","ha")))
                 /(sum(FAOSTAT_Countries$FAOSTAT_CountriesInRegions(FAOSTAT_Regions,FAOSTAT_Countries),
                         FAOSTAT_LandUse(FAOSTAT_Countries,"Permanent meadows and pastures","Area","AverageBasisYear","ha")));

*now assign the regional average values to the countries within those regions, where no data is available on country level

*first, on the level of sub-continents
VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_Countries)
                 $(NOT VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_Countries))
         = sum(FAOSTAT_Subcontinents$FAOSTAT_CountriesInRegions(FAOSTAT_Subcontinents,FAOSTAT_Countries),VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_Subcontinents));

VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Countries)
                 $(NOT VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Countries))
         = sum(FAOSTAT_Subcontinents$FAOSTAT_CountriesInRegions(FAOSTAT_Subcontinents,FAOSTAT_Countries),VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Subcontinents));

*second, if no sub-continent averages are available, on the level of continents:
*conditional to whether there are now values on country levels (original, or from the sub-continents) - thus, only the truly missing are assigned
VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_Countries)
                 $(NOT VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_Countries))
         = sum(FAOSTAT_Continents$FAOSTAT_CountriesInRegions(FAOSTAT_Continents,FAOSTAT_Countries),VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_Continents));

VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Countries)
                 $(NOT VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Countries))
         = sum(FAOSTAT_Continents$FAOSTAT_CountriesInRegions(FAOSTAT_Continents,FAOSTAT_Countries),VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Continents));

*third, on global level, if averages for continents are missing:
*conditional to whether there are now values on country levels (original, or from the sub-continents or continents) - thus, only the truly missing are assigned
VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_Countries)
                 $(NOT VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_Countries))
         = VariousSources_SoilWaterErosionRatesCrops("World");

VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Countries)
                 $(NOT VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Countries))
         = VariousSources_SoilWaterErosionRatesGrass("World");

*after this, soil erosion values are available for all countries in FAOSTAT_Countries



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Soil wind erosion data

*ATTENTION: there is not enoug data around to come up with useful estimates - thus left aside for now.


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Land degradation data

*GENERAL: land degradation captures how much a crop disturbs the soil and thus makes it more (or less) prone to erosion
*the values are based on expert guesses and some further literature information

*units: index
*we use the FAOSTAT and NON_FAOSTAT item sets, therefore define two parameters for defining the data
Parameter LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter LandDegradationIndexGrass(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_CropProductionItems);

*first, land degradation index is initialized with "1" as the default reference, some crops are then assigned "2" - if particularly prone to erosion (mainly vegetables, roots and some others such as maize)
*        some crops are assigned 0, if erosion is most likely absent for them; some crops are assigned some other values - all this is based on expert guesses not backed by literature
*        we cross check and slightly correct further down based on some literature.
*
*to assign this fastly, define specific subsets:
set FAOSTAT_CropProductionItems_NoErosion0(FAOSTAT_CropProductionItems)
/
"Mushrooms and truffles"
"Rice, paddy"
"Rubber, natural"
/;
set FAOSTAT_CropProductionItems_HighErosion2(FAOSTAT_CropProductionItems)
/
"Artichokes"
"Asparagus"
"Beans, green"
"Cabbages and other brassicas"
"Carrots and turnips"
"Cassava"
"Cassava leaves"
"Cauliflowers and broccoli"
"Chicory roots"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cucumbers and gherkins"
"Eggplants (aubergines)"
"Garlic"
"Hops"
"Leeks, other alliaceous vegetables"
"Lettuce and chicory"
"Maize"
"Maize, green"
"Melons, other (inc.cantaloupes)"
"Melonseed"
"Okra"
"Onions, dry"
"Onions, shallots, green"
"Peas, green"
"Potatoes"
"Pumpkins, squash and gourds"
"Roots and tubers, nes"
"Roots and Tubers,Total"
"Spinach"
"String beans"
"Sugar beet"
"Sweet potatoes"
"Taro (cocoyam)"
"Tomatoes"
"Vegetables Primary"
"Vegetables&Melons, Total"
"Vegetables, fresh nes"
"Vegetables, leguminous nes"
"Watermelons"
"Yams"
"Yautia (cocoyam)"
/;

LandDegradationIndexCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems) = 1;
LandDegradationIndexCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems_NoErosion0) = 0;
LandDegradationIndexCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems_HighErosion2) = 2;

*Second, we display more detailed land degradation parameter from Stone and Hilborn, Universal Soil Loss Equation USLE, OMAFRA FactSheet 2012
*(this is for Canada, Ontario, thus may take it for North America, Europe and Central Asia or so), as well as from data given by Ronald Vargas:
*THE FOLLOWING looks like code, but is actually only a list of the values from the two references given by Ronald Vargas:
*it is used to illustrate the relative land deg potential and then to assess whether our judgement on factors 1 and 2 as based on the expert guesses is largely ok.
*we find that it is (cf. below) and thus mostly retain it, only correcting for a few crops (cf. below).
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Cereals")=0.35;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"grain corn")=0.4;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"forage maize")=0.5;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"beans, canola")=0.5;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"vegetables etc.")=0.5;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"fruit trees")=0.1;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"grass")=0.02;
*and Table13_Cfactor.docx as sent by Ronald Vargas, based on literature review, covers all;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Coconut")=0.2;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Cashew")=0.25;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Mango")=0.25;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Jackfruit")=0.25;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"oil palm")=0.2;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Coffee")=0.2;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Cacao")=0.2;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Grass")=0.2;
*grass: a range of values, highly dependent of management...
*LandDegradationIndex(FAOSTAT_CountriesAndRegions,)=;
*mixed agroforestry: 0.15
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Maize")=0.5;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Sorghum")=0.5;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Rice")=0.15;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Peanut")=0.5;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Mung bean")=0.5;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Soybeans")=0.5;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Cotton")=0.5;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Tabacco")=0.5;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Pineapple")=0.35;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Bananas")=0.2;
*LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,"Cassava")=0.4;
*diversified crops - take this as average for crops: 0.3
*Summary:
*fruit trees 0.1
*maize 0.5
*pulses 0.5
*Cereals 0.35
*diversified crops 0.3
*This data shows that our estimates are reasonably ok for the level of accuracy attainable - and also the the average 1, and relation of 2 for Maize, etc. is ok.
*here - the average is maybe 0.25 to 3 - thus all with this are average;

*Thus, changes in relation of the data filed in needed for the following only (cotton and tobacco more; all trees less):

LandDegradationIndexCrops(FAOSTAT_Countries,"Seed cotton")=2;
LandDegradationIndexCrops(FAOSTAT_Countries,"Tobacco, unmanufactured")=2;

LandDegradationIndexCrops(FAOSTAT_Countries,SOLmOld_Treenuts)=0.7;

*and all fruit trees (for this, we define a new subset)
*        this does not include Bananas, Cacao, Coffee:
SET FAOSTAT_CropProductionItems_ModerateErosion07(FAOSTAT_CropProductionItems)
/
"Lemons and limes"
Oranges
"Tangerines, mandarins, clementines, satsumas"
"Fruit, citrus nes"
"Fruit, pome nes"
"Fruit, stone nes"
Pears
Quinces
Apricots
Cherries
"Cherries, sour"
"Peaches and nectarines"
"Plums and sloes"
Apples
Carobs
Dates
Figs
"Grapefruit (inc. pomelos)"
"Citrus Fruit,Total"
Avocados
Cashewapple
"Kiwi fruit"
"Mangoes, mangosteens, guavas"
Papayas
Persimmons
/;

LandDegradationIndexCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems_ModerateErosion07)=0.7;

*third, choose a value for grass as this is missing currently:
*LandDegradationIndexCrops(FAOSTAT_Countries,NON_FAOSTAT_GrassActivities)=0.2;
*but this is not used as this is the degradation index in relation to crops, but the values for soil erosion filed in already account for this by differentiating between crops and grass
*        and there is only one grass activity used to define the erosion rates
*we thus rather use 1:
LandDegradationIndexGrass(FAOSTAT_Countries,NON_FAOSTAT_GrassActivities)=1;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Soil erosion values weighted by land degradation

*we now have information on soil erosion in each country and the degradation potential of different crops, cf. above
*this is now combined to derive crop and country specific soil erosion rates


*To get the average erosion rate for average degradation potential crop, adjust for this degradation potential (cf. formula below).
*In this formula (which is applied country-wise), the following applies:
*ErosionRate_Average_CropWeighted is the observed overall average per country rate filed in from data above,
*ER_AveragedegradingCrop is the crop erosion rate for an average crop, and this is what we need.
*ER_CropSpecific, the crop specific erosion rate, accounting for the crop specific land degradation potential, is then derived by multiplaying this average degrading unspecific erosion rate with the degradation rate:
*
*                                       Sum_crops (ER_CropSpecific*Areas_crops)     Sum_crops (ER_AverageDegradingCrop*LandDegPotential_Crops*Areas_crops)
*ErosionRate_Average_CropWeighted = --------------------------------------------- = ---------------------------------------------
*                                        Sum_crops (Areas_crops)                         Sum_crops (Areas_crops)
*thus:
*       ErosionRate_Average_CropWeighted*Sum_crops (Areas_crops)
*     ----------------------------------------------------------  = ER_AverageDegradingCrop
*             Sum_crops (LandDegPotential_Crops*Areas_crops)
*
*for the area, we take the area harvested, as this is relevant for the erosion, also in case it is on the same plot as another crop - each crop and its specific management lead to a spearate erosion pressure.
*
*We thus need a new parameter for the crop specific soil erosion:
Parameter VariousSources_SoilWaterErosionRatesCropSpecific(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
*and we need the parameter for the soil erosion of an average degrading crop:
Parameter VariousSources_SoilWaterErosionRatesAverageDegradingCrop(FAOSTAT_CountriesAndRegions);

VariousSources_SoilWaterErosionRatesAverageDegradingCrop(FAOSTAT_CountriesAndRegions)
                 $(sum(FAOSTAT_CropProductionItems,LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems)
                                 *FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,"Area harvested","AverageBasisYear","ha")))
         = VariousSources_SoilWaterErosionRatesCrops(FAOSTAT_CountriesAndRegions)
                 *sum(FAOSTAT_CropProductionItems,FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,"Area harvested","AverageBasisYear","ha"))
                         /(sum(FAOSTAT_CropProductionItems,LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems)
                                 *FAOSTAT_CropProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,"Area harvested","AverageBasisYear","ha")));

*And crop specific erosion potential is then given by this erosion potential from "average degrading crop" times the degradation potential of the crop:
*unit: ton soils lost / ha /year
VariousSources_SoilWaterErosionRatesCropSpecific(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems)
         = VariousSources_SoilWaterErosionRatesAverageDegradingCrop(FAOSTAT_CountriesAndRegions)
                 *LandDegradationIndexCrops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);

*there is no need to derive this for grass, as we have only one grass type regarding soil erosion, so the observed values can be used directly
*thus, use:
*        VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_CountriesAndRegions)



*a remark from SOLmV4 - which I do not understrand anymore: ????
*The relative vlaues of grass are accounted for by the specific data we have now, i.e. roughly 12% of average cropland (about 1.6 and 13 t/ha/y)


$ontext;
after this, we have:
               and we retain only what we need in the model: crop/grass specific soil erosion - not the country- and degradation-values those are based on
Parameter VariousSources_SoilWaterErosionRatesCropSpecific(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_CountriesAndRegions);
$offtext;




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) Assign values to core model parameters and variables
*5.1) Link some sets as needed


*no new files needed


*5.2) Link to the core model parameters



ActCropsGrass_OtherChar(Regions,Activities,"Soil water erosion (t soil lost)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_SoilWaterErosionRatesCropSpecific(FAOSTAT_Countries,FAOSTAT_CropProductionItems));

ActCropsGrass_OtherChar(Regions,"Permanent meadows and pastures","Soil water erosion (t soil lost)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Countries));
ActCropsGrass_OtherChar(Regions,"Temporary meadows and pastures","Soil water erosion (t soil lost)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_SoilWaterErosionRatesGrass(FAOSTAT_Countries));

*assign values from maize to forage crops and fodder crops, to have something.
ActCropsGrass_OtherChar(Regions,ForageCrops,"Soil water erosion (t soil lost)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"Maize","Soil water erosion (t soil lost)","AllProdSyst","AllProdCond");
ActCropsGrass_OtherChar(Regions,OtherFodderCrops,"Soil water erosion (t soil lost)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"Maize","Soil water erosion (t soil lost)","AllProdSyst","AllProdCond");


$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Regions,Activities,"Soil water erosion (t soil lost)","AllProdSyst","AllProdCond")

Regions          is      FAOSTAT_Countries
Activities       is      FAOSTAT_CropProductionItems, temp/perm pastures, Non Faostat forage/other fodder crops
$offtext;
