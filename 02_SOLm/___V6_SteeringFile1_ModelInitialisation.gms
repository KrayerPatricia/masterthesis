*BEGIN OF PREAMBLE
*The following label indicates what is to be done next:
*ATTENTION - !! - XXXXXXXXXXXXXXXXX TO BE DONE NEXT!!!!
*this is:
*$include _V6_ReadData_VariousSources_CropGrassNutrientRequirementsData
*$include _V6_ReadData_VariousSources_MainOutputNutrientContentsData
*$include _V6_ReadData_VariousSources_AnimalProductionUnits
*$include _V6_ReadData_VariousSources_IrrigationWaterData
*$include _V6_ReadData_VariousSources_AnimalWelfareData

*$include _V6_ReadAdditionalData_SwitzerlandAustria
*$include _V6_ReadAdditionalData_NUTS2_EU


*and also:
*but MAYBE NOT NEEDED ANYMORE *$include __SOLmV5_DataDerivedBaseline_DetailedFeedingRations
*but MAYBE NOT NEEDED ANYMORE *$include _V6_ReadData_CommodityTrees_LinkActivitiesAndCommodities


*AND: in "3.3) Read in the data"
*There are still some things to be done
*you find this by searching  for
*        XXX STILL TO BE DONE:

*MOST IMPORTANT MAYBE: the one on line 810: on animal specific FeedGG contents and FeedDM requirements (search for "DO FIRST!!")

*END OF PREAMBLE





*Steering file 1 for model version V6: Model Initialisation

*GENERAL DESCRIPTION
*This file governs the whole model initialisation and produces gdx-sets on which the core model then runs afterwards

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) General settings
         1.1) Operating systems settings, etc.
         1.2) specify some global variables to chose for global scenario specifications (yield gap, etc.)
                 1.2.1) specify which yield coefficients to use for organic yields (Badgley, Ponisio, DePonti or Seufert)
                 1.2.2) specify which baseline years to use for the model
                 1.2.3) specify the GWP/GTP to be used
- 2) Specify whether external data needs to be loaded ("YES") (e.g. from updated data files) or not ("NO")
         2.1) General baseline data
         2.2) Some 2050 scenario data and some 2010 Bioenergy baseline data
         2.3) New regional data
- 3) Load the baseline values for all variables and parameters
         3.1) Define some general sets needed for reading in data
         3.2) Define the general model sets, parameters and variables
         3.3) Read in the data
         3.4) Read refined baseline data
- 4) Initialise the parameters and variables for the model runs
- 5) Add data from FAO and other future scenarios
- 6) Define some output files

$offtext;

*****************************************************************************************************************************************************************
$ontext;
PREAMBLE ON UNITS from FAOSTAT:
from http://fenixservices.fao.org/faostat/static/bulkdownloads/datasets_E.xml

<Dataset>
<DatasetCode>BC</DatasetCode>
<DatasetName>Food Balance: Commodity Balances - Crops Primary Equivalent</DatasetName>
<Topic>Most crop and livestock products, including processed products, under agricultural activity.</Topic>
<DatasetDescription>Commodity balances show balances of food and agricultural commodities in a standardized form.
The scope of standardization is to present these data in a less detailed form for a selected number of commodities
without causing any significant loss of the basic variables monitoring the agricultural sector.
The selected commodities include the equivalents of their derived products falling in the same commodity group,
but exclude the equivalents of by-products and derived commodities, which through processing, change their nature and become part of different commodity groups.
A number of commodity/item aggregates have been included to offer synthetic information.
Some of these are included with the aim of simplifying the extraction of all component commodities.
Data shown in the item aggregates represent the sum of the component commodities as presented in this domain (standardized form).
Commodity coverage: The commodity list in this domain has been generally confined to primary commodities - except for sugar, oils and fats and beverages.
Whenever possible trade in processed commodities is expressed in the originating primary commodity equivalent. Rice is expressed in milled equivalent.</DatasetDescription>
<Contact>Mr. Salar Tayyib</Contact><Email>faostat@fao.org</Email>
<DateUpdate>2018-01-16</DateUpdate>
<CompressionFormat>zip</CompressionFormat><FileType>csv</FileType><FileSize>46296KB</FileSize><FileRows>7695363</FileRows>
<FileLocation>http://fenixservices.fao.org/faostat/static/bulkdownloads/CommodityBalances_Crops_E_All_Data_(Normalized).zip</FileLocation>

and see also:

<Dataset><DatasetCode>FBS</DatasetCode>
<DatasetName>Food Balance: Food Balance Sheets</DatasetName>
<Topic>Most crop and livestock products, including processed products, under agricultural activity.</Topic>
<DatasetDescription>Food Balance Sheet presents a comprehensive picture of the pattern of a country's food supply during a specified reference period.
The food balance sheet shows for each food item - i.e. each primary commodity and a number of processed commodities potentially available for human consumption - the sources of supply and its utilization.
The total quantity of foodstuffs produced in a country added to the total quantity imported and adjusted to any change in stocks that may have occurred since the beginning of the reference period
gives the supply available during that period. On the utilization side a distinction is made between the quantities exported, fed to livestock,
used for seed, put to manufacture for food use and non-food uses, losses during storage and transportation, and food supplies available for human consumption.
The per caput supply of each such food item available for human consumption is then obtained by dividing the respective quantity by the related data on the population actually partaking of it.
Data on per caput food supplies are expressed in terms of quantity and - by applying appropriate food composition factors for all primary and processed products - also in terms of caloric value and protein and fat content.</DatasetDescription>
<Contact>Mr. Salar Tayyib</Contact><Email>faostat@fao.org</Email>
<DateUpdate>2017-12-12</DateUpdate>
<CompressionFormat>zip</CompressionFormat><FileType>csv</FileType><FileSize>67676KB</FileSize><FileRows>12660686</FileRows>
<FileLocation>http://fenixservices.fao.org/faostat/static/bulkdownloads/FoodBalanceSheets_E_All_Data_(Normalized).zip</FileLocation></Dataset>
$offtext;
*****************************************************************************************************************************************************************

*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) General settings
*1.1) Operating systems settings, etc.
*the following checks the operating system and choses some basics for GAMS accordingly
$setglobal osystem
$if %system.filesys% == DOS  $setglobal osystem "1"
$if %system.filesys% == MS95 $setglobal osystem "1"
$if %system.filesys% == MSNT $setglobal osystem "1"
$if %system.filesys% == UNIX $setglobal osystem "2"
$setglobal console
$if "%osystem%" == "1" $setglobal console con
$if "%osystem%" == "2" $setglobal console /dev/tty
*generates the option to display in DOS / UNIX window
FILE CON /'%console%'/;

*chose the symbol for the "slash" in directory structure correctly, according to the operating system (e.g. for gdxmerge)
$if "%osystem%" == "1" $setglobal slash '\'
$if "%osystem%" == "2" $setglobal slash '/'

*1.2) specify some global variables to chose for global scenario specifications (yield gap, etc.)

*1.2.1) specify which yield coefficients to use for organic yields (Badgley, DePonti or Seufert)
*$setglobal YieldGapSource        "Badgley"
*$setglobal BadgleyDeveloping     "YES"
$setglobal BadgleyDeveloping     "NO"
*        this specifies whether, if Badgley is used, we use the high yields of organic in developing countries ("YES")
*        or whether we assume org/conv to be on par there ("NO").

*$setglobal YieldGapSource        "Seufert"
*$setglobal SeufertDevelopingOrgEqualsConv        "YES"
*$setglobal SeufertDevelopingOrgEqualsConv        "NO"
*        if set "YES", this assigns equal organic and conv yields for developing countries; "NO" results in developing countries' yield gap equalling developed countries' ones.

*$setglobal YieldGapSource        "DePonti"
$setglobal YieldGapSource        "Ponisio"
*$setglobal PonisioDevelopingOrgEqualsConv        "YES"
$setglobal PonisioDevelopingOrgEqualsConv        "NO"
*        if set "YES", this assigns equal organic and conv yields for developing countries; "NO" results in developing countries' yield gap equalling developed countries' ones.



*1.2.2) specify which baseline years to use for the model
*the following is the current default baseline
$setglobal BaselineChoice        "2009_13"

*the following is needed to file in the FOFA2050 data - to get the correct baseline to compare with (as FOFA2050 uses 2012 as a baseline)
*$setglobal BaselineChoice        "2010_14"

*the following is the baseline used in earlier versions, in particular in SOLmV2, and the calculations for Schader et al. 2015 and Muller et al. 2017
*$setglobal BaselineChoice        "2005_09"



*1.2.3) specify the GWP/GTP to be used

$setglobal GWP_GTP_Choice        "IPCC2006"
*$setglobal GWP_GTP_Choice        "IPCC2013"
*$setglobal GWP_GTP_Choice        "IPCC2006_BiogenCH4"
*$setglobal GWP_GTP_Choice        "IPCC2013_BiogenCH4"

*1.2.4) specify some further aspects
*use UNISECO data or not - to be switched off when the full FAO default 2050 from the FOFA report should be used and not the different data from the BioBam-based 2050 BAU as used in UNISECO
$setglobal UseUNISECO_YesNo                       "NO"
*$setglobal UseUNISECO_YesNo                       "NO"
*$setglobal DoUNISECO_SESSIT_NUTS2_Calculations    "YES"
$setglobal DoUNISECO_SESSIT_NUTS2_Calculations    "NO"

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Specify whether external data needs to be loaded ("YES") (e.g. from updated data files) or not ("NO")

*2.1) General baseline data
$setglobal ReadNewGeographicGroups                    "NO"

$setglobal ReadNewFAOSTATCropProductionData           "NO"
$setglobal ReadNewFAOSTATForageCropProductionData     "NO"
$setglobal ReadNewFAOSTATLivestockProductionData      "NO"
$setglobal ReadNewFAOSTATTradeData                    "NO"
$setglobal ReadNewFAOSTATCommodityBalanceData         "NO"
$setglobal ReadNewFAOSTATLandUseData                  "NO"
$setglobal ReadNewFAOSTATDeforestationData            "NO"
$setglobal ReadNewFAOSTATOrganicSoilsData             "NO"
$setglobal ReadNewErbEtAlGrasslandData                "NO"
$setglobal ReadNewFAOSTATFertilizerData               "NO"
*ATTENTION: reading WOSY is not yet done
$setglobal ReadNewFAOSTATPopulationData               "NO"
$setglobal ReadNewSOFI2012HumanNutrReqData            "NO"
$setglobal ReadNewWalpole2012HumanNutrReqData         "NO"
$setglobal ReadNewVariousSourcesMainOutputNutrientContentsData  "NO"
$setglobal ReadNewFAONutrientContentsData                       "NO"
$setglobal ReadNewVariousSourcesResidueNutrientContentsData     "NO"
*commodity balances contents data: currently no specific reading from external files needed - to be added when needed
$setglobal ReadNewFAOSTATProducerPriceData            "NO"
*N deposition data: currently no specific reading from external files needed - to be added when needed
*N fixation: currently no specific reading from external files needed - to be added when needed
$setglobal ReadNewVariousSourcesSoilErosionData       "NO"
$setglobal ReadNewVariousSourcesIrrigationWaterData   "NO"
$setglobal ReadNewVariousSourcesAnimalWelfareData   "NO"
$setglobal ReadNewVariousSourcesLabourUseData   "NO"
$setglobal ReadNewVariousSourcesPesticideUseIndicesData         "NO"
*RiceCroppingEmissionsData       : currently no specific reading from external files needed - to be added when needed
*HerdStructures                  : currently no specific reading from external files needed - to be added when needed
*AnimalProductionUnits           : currently no specific reading from external files needed - to be added when needed
*AnimalLiveweightData            : currently no specific reading from external files needed - to be added when needed
*AnimalDrinkingWaterRequirementData: currently no specific reading from external files needed - to be added when needed
$setglobal ReadNewVariousSourcesFeedingRationsData    "NO"
*AnimalNutrientRequirementData   : currently no specific reading from external files needed - to be added when needed
$setglobal ReadNewCropResManData                      "NO"
$setglobal ReadNewVariousSourcesNExcretionData        "NO"
$setglobal ReadNewVariousSourcesManureManagementData  "NO"
$setglobal ReadNewCEDData                             "NO"
*FertilizerApplicationData       : currently no specific reading from external files needed - to be added when needed
*MineralFertilizerProductionEmissionsData       : currently no specific reading from external files needed - to be added when needed
*OrganicYieldGapData             : currently no specific reading from external files needed - to be added when needed


*2.2) Some 2050 scenario data and some 2010 Bioenergy baseline data
*if the following is set to "YES", then choose BaselineChoide 2010_14 - and do not file in other data in the same run (unless the general baseline is this one).
*                no need to adapt later if only future scenario values are used - those are for 2050, 2100 and cen then be combined with any baseline
*                        (here it is used only to allocate e.g. crop groups to single crops according to the shares of single crops in each group in the baseline)
$setglobal ReadNewFOFA2050Data                        "NO"
*        this executes code in _V6_ReadData_FAOSTAT_FOFA2050 which is based on the baseline 2010-2014 - thus change this baseline further up in this steering file before switching it on by putting "YES" here
$setglobal ReadNewBioenergySR15Data                   "NO"
*specific choices for the BioeSR15 energy data
*different levels of N fert use on miscanthus (then also adjusts N contents of miscanthus output, as it derives from them)
*$setglobal               MiscanthusFertUseLevel          "LOW"
$setglobal               MiscanthusFertUseLevel          "MEDIUM"
*$setglobal               MiscanthusFertUseLevel          "HIGH"
*different levels of N contents in bioenergy production residues
$setglobal               NInBioeResidues                  "LOW"
*$setglobal               NInBioeResidues                  "HIGH"

*XXXXXXXXXX
*ATTENTION: THE FOLLOWING MODULES READ PRE-CALCULATED OUTPUT FILES when "NO" is set - thus, if you change the code in the module, "YES" IS NEEDED!!!!
*                This is done to safe time, as running these modules fully is quite time consuming
*$setglobal ReadNewFAOSTATLivestockProductionData      "YES"
*$setglobal ReadNewFAOSTATTradeData                    "YES"
*$setglobal ReadNewFOFA2050Data                        "YES"
*$setglobal ReadNewCropResManData                      "YES"
*XXXXXXXXXX


*2.3) New data:
*file in new data - e.g. for subregions in CH and AT as used in the "Alpenprojekt" or NUTS2-level data for the EU for "UNISECO"
$setglobal IncludeExcel_ATData                   "NO"
$setglobal IncludeExcel_CHData                   "NO"
$setglobal IncludeExcel_GermanyData                   "NO"
$setglobal IncludeExcel_SpanishData                   "NO"

$setglobal IncludeExcel_AdditionalPriceData      "NO"
$setglobal IncludeExcel_AdditionalAnimalNumbersData   "NO"
$setglobal IncludeExcel_AdditionalFeedData       "NO"
$setglobal IncludeExcel_AdditionalCroplandAreaData_UNISECO  "NO"
$setglobal IncludeExcel_AdditionalGrasslandData_UNISECO     "NO"
$setglobal IncludeExcel_AdditionalFCRData_UNISECO     "NO"
$setglobal IncludeExcel_AdditionalLivestockProductionData_UNISECO "NO"


*$setglobal IncludeExcel_Grundlagenbericht2014    "NO"
*$setglobal IncludeExcel_SwissAustriaFeedData     "NO"



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Load the baseline values for all variables and parameters

*3.1) define some general sets needed for reading in data
*set containing all countries, regions, etc.
$include _V6_Sets_FAOSTAT_Regions

*sets containing production, trade and commodity balances: items, elements, and units
$include _V6_Sets_FAOSTAT_Items
$include _V6_Sets_FAOSTAT_ItemGroups
$include _V6_Sets_NonFAOSTAT_Items
$include _V6_Sets_FAOSTAT_Elements
$include _V6_Sets_FAOSTAT_Units

*sets containing items, elements, and units for the aspects named in the filename ("land use", "deforestation", etc.)
$include _V6_Sets_FAOSTAT_LandUse
$include _V6_Sets_FAOSTAT_Deforestation
$include _V6_Sets_FAOSTAT_OrganicSoils

*regions, items, elements and units for grasslands according to Erb et al. 2007
$include _V6_Sets_ErbEtAl_Grasslands

*sets containing items, elements, and units for the aspects named in the filename ("Fertilizers", "Population")
$include _V6_Sets_FAOSTAT_Fertilizers
$include _V6_Sets_FAOSTAT_Population_HumanNutrReq

*sets containing the different animal categories used in the herd structures and for certain data, such as IPCC2006 manure excretion, etc.
$include _V6_Sets_VariousSources_HerdStructures

*some further sets needed for reading data - and some of them are also used in the later code
$include _V6_Sets_GeneralModelSets_ForReadingData


*3.2) define the general core model sets, parameters and variables

*general sets, parameters and variables for the model
$include _V6_Sets_GeneralModelSets
$include _V6_VariablesAndParameters


*3.3) Read in the data

$include _V6_ReadData_FAOSTAT_CropProduction
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_CropProduction:" timeElapsed;
$ontext;
After this we have the following in SOLm entities:

VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")
VActCropsGrass_Outputs.l(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
VActCropsGrass_Inputs.l(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")
ActCropsGrass_Outputs(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
ActCropsGrass_Inputs(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")

Regions     is      FAOSTAT_Countries
Activities  is      FAOSTAT_CropProductionItems

*XXX STILL TO BE DONE:
Assign FAOSTAT_CropsProcessedProduction(FAOSTAT_CountriesAndRegions,FAOSTAT_CropsProcessedItems,"Production","AverageBasisYear","tonnes")
this contains only few data on some oils, cotton and molasses, sugar, beer.

Do consistently: activities with two outputs (e.g. Coconuts: Coconuts and coir, etc.), cf. the list above in the CropProduction code
$offtext;


$include _V6_ReadData_FAOSTAT_ForageCropProduction
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_ForageCropProduction:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")
VActCropsGrass_Outputs.l(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
ActCropsGrass_Outputs(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
ActCropsGrass_Inputs(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")

Regions       is      FAOSTAT_Countries
Activities    is      FAOSTAT_ForageCropProductionItems
$offtext;


$include _V6_ReadData_FAOSTAT_LivestockProduction
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_LivestockProduction:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

VActAnimalsHead_Outputs.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond")
VActAnimalsHead_QuantityActUnits.l(Regions,Activities,"Living","AllProdSyst","AllProdCond")
VActAnimalsAPU_Outputs.l(Regions,"Beehives",AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond")
VActAnimalsAPU_QuantityActUnits.l(Regions,"Beehives"AnimalTypeInHerd,,"AllProdSyst","AllProdCond")
ActAnimalsHead_Outputs(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond")
ActAnimalsAPU_Outputs(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Activities        is      FAOSTAT_LiveAnimalsItems
AnimalTypeInHerd  is      Living and: milk, meat, eggs, offals, hides, skins, wool, honey, wax Producing
OutputsAnimals    is      milk, meat, eggs, offals, hides, skins, wool, honey, wax yields per animal (or, for beehives: per APU); and total production of the same

*XXX STILL TO BE DONE:
*Assign:
*FAOSTAT_LivestockProcessed(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockProcessedItems,"Production","AverageBasisYear","tonnes")
         this mainly covers various milk products, some meat/fat products
$offtext;


$include _V6_ReadData_FAOSTAT_Trade
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_Trade:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

VImportQuantity(Regions,Regions_2,Commodities,"AllProdSyst","AllProdCond")
VExportQuantity(Regions,Regions_2,Commodities,"AllProdSyst","AllProdCond")
VImportLivingAnimalsHead(Regions,"World",Activities,"Living","AllProdSyst","AllProdCond")
VExportLivingAnimalsHead(Regions,"World",Activities,"Living","AllProdSyst","AllProdCond")
VImportLivingAnimalsAPU(Regions,"World",Activities,"AllProdSyst","AllProdCond")
VExportLivingAnimalsAPU(Regions,"World",Activities,"AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Regions_2         is      FAOSTAT_Countries_2
Commodities       is      FAOSTAT_DetailedTradeMatrixItems
Activities        is      FAOSTAT_TradeLiveAnimalsItems

*XXX STILL TO BE DONE:
There is no trade data on forage crops and grass: but this is neither important in the basic model

*XXX STILL TO BE DONE:
The following parameter is not currently used here
Parameter FAOSTAT_TradeCropLivestockProducts(FAOSTAT_CountriesAndRegions,FAOSTAT_TradeCropsAndLivestockProductsItems,FAOSTAT_TradeElements,Years,FAOSTAT_TradeUnits);
do CHECK: whether the trade data in crop livestock products really is identical to the ones from the Commodity Balances.
in any case: this data not yet used is less detailed, as it does not contain the whole trade matrix, but only the total import/export quantities without source and target countries - thus, using the full Trade matrix is better.
$offtext;


$include _V6_ReadData_FAOSTAT_CommodityBalances
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_CommodityBalances:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

VCommod_Quantity.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VImportQuantity.l(Regions,"World",Commodities,"AllProdSyst","AllProdCond")
VExportQuantity.l(Regions,"World",Commodities,"AllProdSyst","AllProdCond")
VCommod_StockChanges.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Production.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Feed.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Seed.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Food.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Waste.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Processing.l(Regions,Commodities,"AllProdSyst","AllProdCond")
VCommod_Other.l(Regions,Commodities,"AllProdSyst","AllProdCond")

Commod_OtherChar(Regions,Commodities,"Util food (share)","AllProdSyst","AllProdCond")
Commod_OtherChar(Regions,Commodities,"Util feed (share)","AllProdSyst","AllProdCond")
Commod_OtherChar(Regions,Commodities,"Util seed (share)","AllProdSyst","AllProdCond")
Commod_OtherChar(Regions,Commodities,"Util waste (share)","AllProdSyst","AllProdCond")
Commod_OtherChar(Regions,Commodities,"Util other (share)","AllProdSyst","AllProdCond")
Commod_OtherChar(Regions,Commodities,"Util processing (share)","AllProdSyst","AllProdCond")

Commodities      is      FAOSTAT_LivestockFishCommodityBalancesItems
                         FAOSTAT_CropCommodityBalancesItems
                         ForageCommodities
Regions          is      FAOSTAT_Countries

*XXX STILL TO BE DONE:
Not assigned here as partly already taken from FAOSTAT_CropProduction data:
SeedQuantitySOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,OutputTypeSOLmV5,"AverageProdType","All","Baseline");
         = FAOSTAT_CropCommodityBalances(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,"Seed","AverageBasisYear","tonnes")
BUT: check whether it is identical for crops and add values for animals (and find out what they stand for - e.g. eggs: used to breed new animals?)
*XXX STILL TO BE DONE:
not yet assigned to SOLmV6 parameters are the following, containing per capita nutritional supply values
FAOSTAT_CropFoodSupply(FAOSTAT_Countries,FAOSTAT_CropCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
FAOSTAT_LivestockFishFoodSupply(FAOSTAT_Countries,FAOSTAT_LivestockFishCommodityBalancesItems,FAOSTAT_CommodityBalancesElements_NoPerCapitaElement,"AverageBasisYear",FAOSTAT_CommodityBalancesUnits)
$offtext;


$include _V6_ReadData_FAOSTAT_LandUse
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_LandUse:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")

Activities    is      FAOASTAT_LandUseItems (a subset of this, as above)
Regions       is      FAOSTAT_Countries
$offtext;


$include _V6_ReadData_FAOSTAT_Deforestation
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_Deforestation:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Regions,Activities,"Deforestation (ha)","AllProdSyst","AllProdCond")
ActCropsGrass_OtherChar(Regions,Activities,"Deforest GHG emissions (tCO2e)","AllProdSyst","AllProdCond")

Regions      is      FAOSTAT_Countries
Activities   is      all crop and grass activities
$offtext;


$include _V6_ReadData_FAOSTAT_OrganicSoils
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_OrganicSoils:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils (ha)","AllProdSyst","AllProdCond")
ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond")
ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")

Regions        is      FAOSTAT_Countries
Activities     is      all crop and grass activities
$offtext;


$include _V6_ReadData_ErbEtAl_Grasslands
PUTCLOSE con "   time elapsed till end of _V6_ReadData_ErbEtAl_Grasslands:" timeElapsed;
$ontext;
$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_Outputs(Regions,Activities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond")
ActCropsGrass_Outputs(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")

Commod_Contents(Regions,Activities,"FeedME in DM (MJ)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"FeedXP in DM (t)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"DM (t)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"FeedME (MJ)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"FeedXP (t)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"N (t)","AllProdSyst","AllProdCond")
Commod_Contents(Regions,Activities,"FeedGE (MJ)","AllProdSyst","AllProdCond")
Commod_Contents(Countries,Activities,"P2O5 (t)","AllProdSyst","AllProdCond")

VActCropsGrass_Outputs.l(Regions,Activities,"MainOutput1 (t)","AllProdSyst","AllProdCond")
VCommod_Quantity.l(Regions,Activities,"AllProdSyst","AllProdCond")
VCommod_Production.l(Regions,Activities,"AllProdSyst","AllProdCond")
VCommod_Feed.l(Regions,Activities,"AllProdSyst","AllProdCond")

Regions      is      ErbEtAl_GrasslandDataCountryList
                                         which is a subset of FAOSTAT_Countries
Activities   is      "Permanent meadows and pastures" and "Temporary meadows and pastures"

*XXX STILL TO BE DONE:
Assign values to elements in FAOSTAT_Countries NOT COVERED in the original set!! -
         but these are small countries only, so doing this is not that important.
$offtext;


$include _V6_ReadData_FAOSTAT_Fertilizers
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_Fertilizers:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

VMineralFertilizerQuantity.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst")
VMineralFertilizerQuantity.l(Regions,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")
VMineralFertilizerQuantity.l(Regions,"mineral K fert (K2O)","AllMinFertProdTech","AllProdSyst")

Regions  is      FAOSTAT_Countries
$offtext;


**************************************************************************
*THE FOLLOWING IS CURRENTLY NOT USED - IS IT NEEDED AT ALL?
*IT uses non-public data - so would be better to not use it!!
*TBDL $include _V6_ReadData_FAOSTAT_WOSY_DetailedFBS
*TBDL PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_WOSY_DetailedFBS:" timeElapsed;
$ontext;
After this we have the following in SOLmV5-entities:
         where:
         GeographicRegionSOLmV5   is      FAOSTAT_Countries
         CommoditySOLmV5          is      FAOSTAT_WOSYItems
         PerTonDomestAvailQuantParameterSOLmV5
                                  is      WOSY_NutrientContentsParameter (kcal,prot,fat per ton; FeedME total etc. per ton food, FeedME from Byprod per ton food)
                                          WOSY_Utilization (food,feed,seed,waste,other)

         ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,PerTonDomestAvailQuantParameterSOLmV5,"AverageProdType","All","Baseline")

*        XXX STILL TO BE DONE:
Assign:
         Not yet all elements from WOSY_NutrientContentsParameter transferred from WOSY data to core model parameters and variables!!
                 Check the comment after the definition of Set Match_WOSYNutrCont_PerTonDAQSOLmV5 to learn which ones
Check:
         OutputType allocation in the matching set between SOLmV5 commodities and WOSY items - this was done quite ad hoc
                 Use as a basis for checking this the allocation done in the sheet FAOSTAT_WOSYItems_OutputType in the excel file CompareTradeItemLists_3_12_2017
         Are the utilization shares from WOSY consistent whith the ones that can be derived from the Commodity Balances? If not, rather use the latter (they are from FAOSTAT in general and cover all years, but may not all commodities in WOSY)
$offtext;
**************************************************************************


$include _V6_ReadData_FAOSTAT_Population
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_Population:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

VPopulationNumbers.l(Regions,PopulationGroups)

Regions            is      FAOSTAT_Countries
PopulationGroups   is      PopulationAll, Male, Female
$offtext;


$include _V6_ReadData_VariousSources_HumanNutrientRequirements
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_HumanNutrientRequirements:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

HumanCharacteristics(Regions,"PopulationAll",Humans_InputsOutputsOtherCharacteristics,Commodities)

Regions                                     is      FAOSTAT_Countries
Humans_InputsOutputsOtherCharacteristics    is      Human Nutrient Requirements
                                                                 most basic: kcal, g prot, g fat per cap and day
                                                                 from TWO SOURCES: Walpole2012 and SOFI2012
$offtext;


*ATTENTION - !! - XXXXXXXXXXXXXXXXX TO BE DONE NEXT!!!!
*ATTENTION - BELOW, DATA MISSING, TO BE DONE - only dummy data to make it run but nothing assigned to SOLmV6 entities
$include _V6_ReadData_VariousSources_CropGrassNutrientRequirementsData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_CropGrassNutrientRequirementsData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:
         where
         PerTonPrimProdParameterSOLmV5    is      ReadCropGrassNutrientElement, i..e N,P,K requirements
         ProductionTypeSOLmV5             is      ProductionType (BUT ONLY: "convent", "organic")

         ParameterPerTonPrimaryProdSOLmV5("World","Wheat","All",PerTonPrimProdParameterSOLmV5,"AverageProdType","All","Baseline")
         ParameterPerTonPrimaryProdSOLmV5("World","Grass","All",PerTonPrimProdParameterSOLmV5,"AverageProdType","All","Baseline")

*        XXX STILL TO BE DONE:
Assign:
         COMPLETE THE DATA!! Currently, only dummy values for wheat and grass to have something!!

XXXXXXXXXXXXXXXXXXX
ALL still to be done!!!!!!
XXXXXXXXXXXXXXXXXXX
*ATTENTION - ABOVE, DATA MISSING, TO BE DONE - only dummy data to make it run
$offtext;


*ATTENTION - !! - XXXXXXXXXXXXXXXXX TO BE DONE NEXT!!!!
$include _V6_ReadData_VariousSources_MainOutputNutrientContentsData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_MainOutputNutrientContentsData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

Commod_Contents(Countries,Commodities,Contents,"AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Commodities       is      FAOSTAT_CropProductionItems
                                 forage crops in NON_FAOSTAT_CropPRoductionItems
                                 livestock primary products - a selection from livestock commodities that most closely capture the main outputs from livestock activities.
                                                 BUT:    FAOSTAT_LiveAnimalsItems have "Sheep and goats" only,
                                                         while live animals in FAOSTAT_LivestockPrimaryItems used here have "Sheep" and "Goats" separately
Contents          is      N, P2O5, DM, partly ME, GE, XP contents in fresh and partly also in dry matter

*XXX STILL TO BE DONE:
Check all data in this file and improve, differentiate, where needed and useful
FILE IN USDA-data, etc.
CHECK and IMPROVE current data!!!
$offtext;

$include _V6_ReadData_FAO_CommoditiesNutrientContentsData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAO_CommoditiesNutrientContentsData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

Commod_Contents(Countries,Commodities,Contents,"AllProdSyst","AllProdCond")
Regions           is      FAOSTAT_Countries
Commodities       is      Commodities (only those used for food)

Contents          is      calorie, protein and fat contents in fresh matter
$offtext;


$include _V6_ReadData_VariousSources_ResidueSharesAndNutrientContentsData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_ResidueSharesAndNutrientContentsData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

CropResidues_Contents(Regions,Activities,"Average residues (t)",CropResContents,"AllProdSyst","AllProdCond")
CropResidues_OtherChar(Regions,Activities,"Average residues (t)",CropResOtherChar,"AllProdSyst","AllProdCond")

Activities        is      FAOSTAT_CropProductionItems
                         "Temporary meadows and pastures", "Permanent meadows and pastures"
Regions           is      FAOSTAT_Countries
CropResContents   is      N, P2O5, DM (t) - before management
CropResOtherChar  is     "Residue share t DM / t DM MainOutput1"

*XXX STILL TO BE DONE:
Add: data for forage in NON_FAOSTAT_GrassActivities
         but may assume: residues with forage crops are zero (besides roots)
ADD: FeedME, FeedGE, FeedXP for all residues
Check all data in this file and improve, differentiate, where needed and useful - e.g. add IPCC2006 data and calculations
$offtext;


$include _V6_ReadData_VariousSources_SeedCharacteristicsData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_SeedCharacteristicsData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_Inputs(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")
SeedContents(Regions,Activities,Contents,"AllProdSyst","AllProdCond")

Regions      is      FAOSTAT_Countries
Activities   is      FAOSTAT_CropProductionItems
Contents     is      N, P2O5 DM (t) per ton seed

*XXX STILL TO BE DONE:
Check all data in this file and improve, differentiate, where needed and useful - make consistent with main prod contents where necessary (e.g. for wheat!)
* ADD: data on NON_FAOSTAT_CropPRoductionItems
$offtext;


$include _V6_ReadData_FAOSTAT_ProducerPrices
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_ProducerPrices:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

Commod_OtherChar(Regions,Commodities,"Producer price ($)","AllProdSyst","AllProdCond")

Regions          is      FAOSTAT_Countries
Commodities      is      FAOSTAT_ProducerPriceItems

*XXX STILL TO BE DONE:
TO BE DONE: build production weighted averages over the baseyears!!! - currently, it is simple unweighted averages only
$offtext;



$include _V6_ReadData_IPCC_GWP_GTPData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_IPCC_GWP_GTPData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

GWP_GTP_SOLm(GreenhouseGases)

*XXX STILL TO BE DONE:
Check and imüprove the value for biogenic CH4!!
$offtext;


$include _V6_ReadData_LuEtAl_NDepositionData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_LuEtAl_NDepositionData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_Inputs(Regions,Activities,"N deposition (tN)","AllProdSyst","AllProdCond")
ActForest_Inputs(Regions,"Forest","N deposition (tN)","AllProdSyst","AllProdCond")

Regions         is      FAOSTAT_Countries
Activities      is      Crops, "Forest", temp/perm mead. and pastures
$offtext;


$include _V6_ReadData_VariousSources_NFixationData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_NFixationData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_Inputs(Regions,Activities,"N fixation (tN)","AllProdSyst","AllProdCond")

Regions          is      FAOSTAT_Countries
Activities       is      FAOSTAT_CropProductionItems
                                 NON_FAOSTAT_CropProductionItems
$offtext;


$include _V6_ReadData_VariousSources_SoilErosionData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_SoilErosionData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Regions,Activities,"Soil water erosion (t soil lost)","AllProdSyst","AllProdCond")

Regions          is      FAOSTAT_Countries
Activities       is      FAOSTAT_CropProductionItems, temp/perm pastures, Non Faostat forage/other fodder crops
$offtext;


*ATTENTION - !! - XXXXXXXXXXXXXXXXX TO BE DONE NEXT!!!!
*NOT YET OPERATIONAL!
$include _V6_ReadData_VariousSources_IrrigationWaterData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_IrrigationWaterData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

TBD

$offtext;

$include _V6_ReadData_VariousSources_AnimalLiveweightData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_AnimalLiveweightData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,"Liveweight (t)","AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Activities        is      FAOSTAT_LiveAnimalsItems
AnimalTypeInHerd  is      SOLm herd categories
$offtext;

$include _V6_ReadData_VariousSources_LabourUseData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_LabourUseData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

TBD

$offtext;

$include _V6_ReadData_VariousSources_PesticidesData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_PesticidesData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Regions,Activities,"Aggreg. Pest. use level (index)","AllProdSyst","AllProdCond")

Regions          is      FAOSTAT_Countries
Activities       is      FAOSTAT_CropProductionItems

*XXX STILL TO BE DONE:
Values for grass / forage / fodder crops!!!!
$offtext;


$include _V6_ReadData_IPCC2006_RiceCroppingEmissionsData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_IPCC2006_RiceCroppingEmissionsData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Countries,"Rice, paddy","CH4 flooded rice (t CH4)","AllProdSyst","AllProdCond")

Countries   is      FAOSTAT_Countries
$offtext;


$include _V6_ReadData_VariousSources_HerdStructures
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_HerdStructures:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

VActAnimalsHead_QuantityActUnits(Regions,"Cattle",AnimalTypeInHerd,"AllProdSyst","AllProdCond")
VActAnimalsHead_QuantityActUnits(Regions,"Pigs",AnimalTypeInHerd,"AllProdSyst","AllProdCond")

Regions            is      FAOSTAT_Countries
AnimalTypeInHerd   is      SOLm core herd categories - those that are filed in from old herd structure model
$offtext;

*ATTENTION - !! - XXXXXXXXXXXXXXXXX TO BE DONE NEXT!!!!
*ATTENTION - only sets defined, DATA MISSING, not even dummy data included - TO BE DONE!!!!!!!!!!!!!
$include _V6_ReadData_VariousSources_AnimalProductionUnits
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_AnimalProductionUnits:" timeElapsed;
*ATTENTION - only sets defined, DATA MISSING, not even dummy data included - TO BE DONE!!!!!!!!!!!!!


$include _V6_ReadData_VariousSources_AnimalDrinkingWaterRequirementData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_AnimalDrinkingWaterRequirementData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActAnimalsHead_Inputs(Regions,Activities,"AllAndAverageTypes","Drinking water (m3)","AllProdSyst","AllProdCond")
ActAnimalsHead_Inputs(Regions,"Cattle",CattleTypeInHerd,"Drinking water (m3)","AllProdSyst","AllProdCond")
ActAnimalsHead_Inputs(Regions,"Pigs",PigTypeInHerd,"Drinking water (m3)","AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Activities        is      LiveAnimalsSOLmV5 plus Game
$offtext;


$include _V6_ReadData_VariousSources_FeedingRationsData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_FeedingRationsData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActAnimalsHead_OtherChar(Regions,Activities,"AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond")
*not needed: all info in per head param, APU only assigned later in Steering 2 towards the end
ActAnimalsAPU_OtherChar(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst","AllProdCond")

FeedingRations_OtherChar(Regions,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond")
FeedingRations_OtherChar(Regions,"Cattle",CattleTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond")
FeedingRations_OtherChar(Regions,"Pigs",PigTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond")

Regions              is      FAOSTAT_Countries
Activities           is      LiveAnimalsSOLmV5 and "Game"
OtherCharAnimals     is      share in feed - on aggregate, i.e. grass, forage crops, concentrates, residues
Commodities          is      aggregate feed groups, i.e. grass, forage crops, concentrates, residues
$offtext;


*ATTENTION - !! - XXXXXXXXXXXXXXXXX TO BE DONE NEXT!!!!
*NOT YET OPERATIONAL!
$include _V6_ReadData_VariousSources_AnimalWelfareData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_AnimalWelfareData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

TBD

$offtext;


$include _V6_ReadData_VariousSources_AnimalNutrientRequirementsData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_AnimalNutrientRequirementsData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"FeedME_req_Total (MJ)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"FeedXP_req_Total (t)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"FeedGE_req_Total (MJ)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,"Cattle","Producing_Dairy_Cattle",OtherCharAnimals,"AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"XPperME_InFeedReq (gXP/MJ)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","UE_per_GE (share)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","Animal specific FeedGE cont (MJ/t)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","Digestibility of Feed (%)","AllProdSyst","AllProdCond")

*not needed: all info in per head param, APU only assigned later in Steering 2 towards the end
ActAnimalsAPU_OtherChar(Regions,Livestock,AnimalTypeInHerd,"UE_per_GE (share)","AllProdSyst","AllProdCond")
ActAnimalsAPU_OtherChar(Regions,Livestock,AnimalTypeInHerd,"Animal specific FeedGE cont (MJ/t)","AllProdSyst","AllProdCond")
ActAnimalsAPU_OtherChar(Regions,Livestock,AnimalTypeInHerd,"Digestibility of Feed (%)","AllProdSyst","AllProdCond")

Commod_Contents(Regions,"Milk, Whole","Milk solid contents (t)","AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
OtherCharAnimals  is      (for Dairy cattle) specific parameters to derive ME requirements: "FeedME_Req_MilkProd (MJ/head)", "FeedME_Req_Maintenance (MJ/head)", "FeedME_Req_Walking (MJ/head)", "FeedME_Req_Pregnancy (MJ/head)"

*XXX STILL TO BE DONE:
*Liveweight factor depends on the intensity of the system - this is not yet differentiated,
*XXX STILL TO BE DONE:
         "DO FIRST!!"
*Derive aggregate Feed GE, ME, XP, DM contents - in relation to feeding rations and animal types
*And DM requirements as well - if not yet available
$offtext;


$include _V6_ReadData_VariousSources_EntericFermentationEmissionsData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_EntericFermentationEmissionsData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,Commodities,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")

Livestock            is      Ruminants, Pigs, Chickens
Commodities          is      aggregate feed type: concentrates, grass, forage, residues
AnimalTypeInHerd     is      SOLm herd types
$offtext;


$include _V6_ReadData_VariousSources_CropResidueManagementData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_CropResidueManagementData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

CropResidues_Management(Regions,Activities,"Average Residues (t)",CropResManagement,CropResManSystem,ProductionSystems,"AllProdCond")

Regions                          is      FAOSTAT_Countries
Activities                       is      FAOSTAT_CropProductionItems
                                                 temp/perm meadows and pastures
ProductionSystems are "AllProdSyst" and for the element "Quantity share in CropResMan system" in CropResManagement also "Convent" and "Organic". The set CropResManagement has the following elements:
       - "Quantity share in CropResMan system"
       - "Crop res man CH4 (tCH4)"
       - "Crop res man N2O (tN2O)"
       - "Crop res man N loss (tN)"
       - "Crop res N for areas (tN)"
       - "Crop res man share P lost (tP2O5/tP2O5 in crop res)"
       - "Crop res man P loss (tP2O5)"
       - "Crop res P for areas (tP2O5)"

$offtext;


$include _V6_ReadData_VariousSources_ManureExcretionData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_ManureExcretionData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

where
Regions        is      FAOSTAT_Countries
Activities     is      Livestock

ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
Manure_OtherChar(Countries,Livestock,AnimalTypeInHerd,"Ash content in feed DM (share)","AllProdSyst","AllProdCond")

*XXX STILL TO BE DONE:
*the latter one (ash): code it also as a feed ration parameter (as it has been in SOLmV5)?
$offtext;


$include _V6_ReadData_VariousSources_ManureManagementData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_ManureManagementData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Quantity share in ManureMan system"          ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based"  ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"MCF: CH4 conversion factor (%)"              ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Bo: max. CH4 prod. cap. (m3CH4/kgVS)"        ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)"       ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)"       ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)"              ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N2O-N from N volat (tN/tN volat)" ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N2O-N from N leach (tN/tN leach)" ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man P loss as % of P in manure (%)"   ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries,
$offtext;


$include _V6_ReadData_VariousSources_MineralFertilizerProductionEmissionsData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_MineralFertilizerProductionEmissionsData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

MineralFertilizerCharacteristics(Countries,"mineral N fert (tN)","AllMinFertProdTech","t CO2e/tN production","AllProdSyst")
MineralFertilizerCharacteristics(Countries,"mineral P fert (tP2O5)","AllMinFertProdTech","t CO2e/tP2O5 production","AllProdSyst")
$offtext;


$include _V6_ReadData_VariousSources_FertilizerApplicationData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_FertilizerApplicationData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ManureApplication(Countries,Activities,Livestock,"AllAndAverageTypes",FertApplicCharact,"AllProdSyst","AllProdCond")
CropResAndBiomassApplication(Countries,Activities,"All Residues",FertApplicCharact,"AllProdSyst","AllProdCond")
MinFertApplication(Countries,Activities,"mineral N fert (N)",FertApplicCharact,"AllProdSyst","AllProdCond")

Livestock is a dimension as the SOURCE of manure

Activities           is              all crops and core grass activities
FertApplicCharact    is              "N2O-N per kg fertilizer N applied (tN/tN)"
                                     "Volatized N as percentage of fertilizer N applied (%)"
                                     "Leached N as percentage of fertilizer N applied (%)"
                                     "N2O-N per kg N volatized from fert applic (share)"
                                     "N2O-N per kg N leached from fert applic (share)"
$offtext;


$include _V6_ReadData_VariousSources_NH3Emissions
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_NH3Emissions:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

MinFertApplication(Countries,Activities,"mineral N fert (N)","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
ManureApplication(Countries,Activities,Livestock,"AllAndAverageTypes","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
CropResAndBiomassApplication(Countries,Activities,"All Residues","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man NH3-N (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")

Activities           is              all crop and grass activities
$offtext;


$include _V6_ReadData_VariousSources_OrganicYieldGapsData
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_OrganicYieldGapsData:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Activities        is      FAOSTAT_CropProductionItems
                          NON_FAOSTAT_CropProductionItems also covers some grass activities

*XXX STILL TO BE DONE:
add "World of Organic" detailed organic area share values per country and crop

derive the true org and con yields, given average yields and org/con area shares (cf. formulae at the end of the code file)
$offtext;


*ATTENTION - !! - XXXXXXXXXXXXXXXXX TO BE DONE NEXT!!!!
*TBDL NOT YET DONE FOR V6: DetailedFeedingRations
*$include __SOLmV5_DataDerivedBaseline_DetailedFeedingRations
*PUTCLOSE con "   time elapsed till end of __SOLmV5_DataDerivedBaseline_DetailedFeedingRations:" timeElapsed;
$ontext;
After this we have the following in SOLmV5-entities:

         where:
         LivingHeadsBasedTotalValueParameterSOLmV5        is      Total ME demand per feed group (grass, conc, forage, residue)
         PerLivingHeadParameterSOLmV5                     is      Share of ME demand per animal type in total ME demand from all animals per feed group (grass, conc, forage, residue)
                                                                 supply/demand ration per crop group (grass, conc, forage, residue)
                                                                 ME, GE, DM supply per head with and without S/D-Ratio correction
         FeedGroupsSOLmV5                                 is      feed groups (grass, conc, forage, residue)

         *better Feed GE req of dairy cows:
         ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"FeedGE_Req_Total (MJ/head)","AverageProdType","All","Baseline")
         *some additional/better FeedME, GE, XP and DM contents for various feed
         ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Palm kernels","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.918;
         *consistent calculation of FeedME,Fresh matter,DM quantities
         DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
         *consistent calculation of FeedME,Fresh matter,DM, GE supply per head quantities
         FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedGE supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
         *amd all this also aggregated to Feed Groups Conc, grass, Forage, - byproducts, if needed)

*        XXX STILL TO BE DONE:
assign:
         crop specific digestibility!!
         Digestibility/GE_contents  for Feed groups - it is available for all feed only. when assigned to commodities/groups, then derive for the whole ration again (but then, may drop the conditional in teh code)!!

CHECK:
Digestibility of feed has to be derived in the scenarios anew!! - thus also do the more general code for digestibility, not only for the baseline with the data as read in.
GE_contents of feed has to be derived in the scenarios anew!! - thus also do the more general code for digestibility, not only for the baseline with the data as read in.
$offtext;


$include _V6_ReadData_VariousSources_CED
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_CED:" timeElapsed;

$ontext;
After this we have the following in SOLm-entities:

where:
Regions              is      FAOSTAT_Countries
ProductionSytems     is      "Convent", "Organic", "AllProdSyst"

ActCropsGrass_Inputs(Regions,Crops,"Total CED (MJ)",ProductionSytems,"AllProdCond")
ActCropsGrass_Inputs(Regions,CoreGrassActivities,"Total CED (MJ)",ProductionSytems,"AllProdCond")
ActAnimalsHead_Inputs(Regions,Livestock,"AllAndAverageTypes","Total CED (MJ)",ProductionSytems,"AllProdCond")

ActCropsGrass_Inputs(Regions,Crops,"Total GWP from CED (tCO2e)",ProductionSytems,"AllProdCond")
ActCropsGrass_Inputs(Regions,CoreGrassActivities,"Total GWP from CED (tCO2e)",ProductionSytems,"AllProdCond")
ActAnimalsHead_Inputs(Regions,Livestock,"AllAndAverageTypes","Total GWP from CED (tCO2e)",ProductionSytems,"AllProdCond")
$offtext;


*3.4) Read refined baseline data

*ATTENTION - !! - XXXXXXXXXXXXXXXXX TO BE DONE NEXT!!!!
*$include _V6_ReadAdditionalData_SwitzerlandAustria
PUTCLOSE con "   time elapsed till end of _V6_ReadAdditionalData_SwitzerlandAustria:" timeElapsed;
*$include _V6_ReadAdditionalData_SwitzerlandAustriaFeed
PUTCLOSE con "   time elapsed till end of _V6_ReadAdditionalData_SwitzerlandAustriaFeed:" timeElapsed;

$include _V6_ReadAdditionalData_AnimalNumbers
PUTCLOSE con "   time elapsed till end of _V6_ReadAdditionalData_AnimalNumbers:" timeElapsed;

*currently reading data from 2011 for CH and AT - account for this when doing consistendy checks
$include _V6_ReadAdditionalData_GHGInventories
PUTCLOSE con "   time elapsed till end of _V6_ReadAdditionalData_GHGInventories:" timeElapsed;

$include _V6_ReadAdditionalData_Prices
PUTCLOSE con "   time elapsed till end of _V6_ReadAdditionalData_Prices:" timeElapsed;

$include _V6_ReadAdditionalData_FeedData
PUTCLOSE con "   time elapsed till end of _V6_ReadAdditionalData_FeedData:" timeElapsed;


$ontext;
After this we have the following

XXX

*XXX STILL TO BE DONE:

XXXXXXXXXXXXXXXXXXX
ASSIGNMENT TO SOLm-entities still to be done!!!!!!
XXXXXXXXXXXXXXXXXXX

$offtext;
*And the same for NUTS2 on EU level: add this data:

*YET TO BE CODED!!

*$include _V6_ReadAdditionalData_NUTS2_EU





$include _V6_DataDerivedBaseline_SomeHerdStructureParameters
PUTCLOSE con "   time elapsed till end of _V6_DataDerivedBaseline_SomeHerdStructureParameters:" timeElapsed;
$ontext;
After this we have the following in SOLm-entities:

ActAnimalsHead_OtherChar(Regions,"Cattle",AnimalTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions)
ActAnimalsHead_OtherChar(Regions,"Pigs",AnimalTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions)

Regions            is      FAOSTAT_Countries
AnimalTypeInHerd   is      SOLm core herd categories - those that are filed in from old herd structure model
$offtext;




*ATTENTION - !! - XXXXXXXXXXXXXXXXX TO BE DONE NEXT!!!!
$include _V6_ReadData_CommodityTrees_LinkActivitiesAndCommodities
PUTCLOSE con "   time elapsed till end of _V6_ReadData_CommodityTrees_LinkActivitiesAndCommodities:" timeElapsed;
$ontext;


GO ON IN SECTION *4, line 2214

adapt description!!
After this we have the following in SOLmV5-entities:


*here, the following matching sets between activities and commodities are defined:
set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass)
set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)
set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass)
set MatchCommAct_ComplexAnimalCommodities(Commodities,Activities,OutputsAnimals)
set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
set MatchCommAct_CommodEquivalentAct_Animals(Commodities,Activities,OutputsAnimals)
set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCrops)


$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Initialise the parameters and variables for the model runs
*this is needed to file in some values for future scenarios which need a scenario dimension
$include _V6_VariablesAndParameters_ModelRun
PUTCLOSE con "   time elapsed till end of _V6_VariablesAndParameters_ModelRun:" timeElapsed;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) Add data from FAO and other future scenarios

$include _V6_ReadData_FAOSTAT_FOFA2050
PUTCLOSE con "   time elapsed till end of _V6_ReadData_FAOSTAT_FOFA2050:" timeElapsed;
$ontext;
After this we have the following

ActCropsGrass_Outputs_MR(Countries,Activities,"MainOutput1 (t)",ProductionSystems,"AllProdCond","FOFA_BAU_2050")
ActCropsGrass_OtherChar_MR(Countries,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond","FOFA_BAU_2050")
ActAnimalsHead_Outputs_MR(Countries,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities,ProductionSystems,"AllProdCond","FOFA_BAU_2050")
VActAnimalsHead_QuantityActUnits_MR.l(Countries,Livestock,"Living","AllProdSyst","AllProdCond",Scenarios)

Activities  is      FAOSTAT_CropProductionItems
$offtext;


$include _V6_ReadData_VariousSources_BioenergySR15
PUTCLOSE con "   time elapsed till end of _V6_ReadData_VariousSources_BioenergySR15:" timeElapsed;
$ontext;
After this we have the following

XXX

*XXX STILL TO BE DONE:

XXXXXXXXXXXXXXXXXXX
ASSIGNMENT TO SOLm-entities partly still to be done!!!!!!
XXXXXXXXXXXXXXXXXXX
$offtext;

$if %UseUNISECO_YesNo% == "NO" $goto DoNotUseUNISECOData
*for default 2050 deta do not run the UNISECO code, as this reads some specific UNISECO baseline data from BioBam for 2050 which is different than the FOFA 2050 BAU from FAO
*thus for the real default, do not use this.
$include _V6_ReadAdditionalData_CroplandGrasslandAreasFCR_UNISECO
PUTCLOSE con "   time elapsed till end of _V6_ReadAdditionalData_CroplandGrasslandAreas_UNISECO:" timeElapsed;
$label DoNotUseUNISECOData

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) Define some output files

$include _V6_StreamlineInitialData
PUTCLOSE con "   time elapsed till end of _V6_StreamlineInitialData:" timeElapsed;
$ontext;
This code gets rid of useless and confusing assignemnts made further up
$offtext;


$include _V6_OutputFiles_SteeringFile1
PUTCLOSE con "   time elapsed till end of _V6_OutputFiles_SteeringFile1:" timeElapsed;
$ontext;

*this code produces the following gdx-files:

'GeneralModelSets'
'GeneralModelParameters_Inputs'
'GeneralModelParameters_Outputs'
'GeneralModelParameters_OtherChar'
'GeneralModelParameters_Various'
'GeneralModelParameters_Auxiliary'
'GeneralModelVariables_ActivityQuantities'
'GeneralModelVariables_Inputs'
'GeneralModelVariables_Outputs'
'GeneralModelVariables_OtherChar'
'GeneralModelVariables_Various'
'GeneralModelVariables_Trade'
'GeneralModelVariables_CommodityTree'
'GeneralModelVariables_Auxiliary'
'FOFA2050_BioeSR15_Etc_Data_InModelRunEntities'
$offtext;


$goto EndOfSteeringFile_ModelInitialisation


$label EndOfSteeringFile_ModelInitialisation
PUTCLOSE con,"End of _V6_SteeringFile1_ModelInitialisation.gms";









