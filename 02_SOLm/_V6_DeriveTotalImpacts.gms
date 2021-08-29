PUTCLOSE con,"_V6_DeriveTotalImpacts";

*GENERAL DESCRIPTION
*This file contains the code to derive the TOTAL impacts from the impacts per unit, i.e. per ha, per ton and per animal head or per APU values .

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Derive some further indicators
- 2) Derive total impacts

$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Derive further indicators
*some indicators are not yet in the form we need them, e.g. irrigation per ha, where we have irrigation per ton only for many scenarios and it depends on the scenario-specific yields:

ActCropsGrass_Inputs_MR(Regions,Activities,"Irrigation water (m3)",ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_OtherChar_MR(Regions,Activities,"IrrigW per t MOutput1 (m3) - total demand",ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios);

ActCropsGrass_Inputs_MR(Regions,Activities,"Irrigation water (m3) - water stress adjusted",ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_OtherChar_MR(Regions,Activities,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.",ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios);


ActCropsGrass_Inputs_MR(Regions,Activities,"Green Water Footprint (m3)",ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_OtherChar_MR(Regions,Activities,"Green Water Footprint per t MainOutput1 (m3)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios);
ActCropsGrass_Inputs_MR(Regions,Activities,"Blue Water Footprint (m3)",ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_OtherChar_MR(Regions,Activities,"Blue Water Footprint per t MainOutput1 (m3)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios);
ActCropsGrass_Inputs_MR(Regions,Activities,"Grey Water Footprint (m3)",ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_OtherChar_MR(Regions,Activities,"Grey Water Footprint per t MainOutput1 (m3)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions,Activities,"MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios);


*derive the scenario specific animal welfare indicators that need to be recalculated:
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsHeads_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,Scenarios)
                 + FeedingRationsHeads_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,Scenarios);

*the condition is to assure that only sensible combinations of livestock and herd types are assigned
ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Liveweight (t)",ProductionSystems,ProductionConditions,Scenarios)
                          AND VActAnimalsHead_QuantityActUnits_MR.l(Regions,NonRuminants,"AllAndAverageTypes",ProductionSystems,ProductionConditions,Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions,NonRuminants,"Meat producing",ProductionSystems,ProductionConditions,Scenarios)
                 /VActAnimalsHead_QuantityActUnits_MR.l(Regions,NonRuminants,"AllAndAverageTypes",ProductionSystems,ProductionConditions,Scenarios);

*the condition is to assure that only sensible combinations of livestock and herd types are assigned
ActAnimalsHead_OtherChar_MR(Regions,Poultry,AnimalTypeInHerd,"Animal welfare: production intensity index - eggs",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions,Poultry,AnimalTypeInHerd,"Liveweight (t)",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions,Poultry,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,Scenarios);

*and, finally, somewhat adjust the antibiotics indicator for intensity levels
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios)
                         $ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants",ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants",ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants",ProductionSystems,ProductionConditions,"Baseline");

ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios)
                         $ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,ProductionConditions,"Baseline");
*here, eggs are not needed specifically for adjustment, as the antibiotic index does not differentiate between outputs which is the basis for the intensity level for non-ruminants, and usually all egg producing animals are also used for meat.



$ontext;
to be compiled for Janne Helin on NUTS2:

Country level only:
ActCropsGrass_Inputs_MR(Regions,Activities,"Irrigation water (m3)",ProductionSystems,ProductionConditions,Scenarios)
ActCropsGrass_Inputs_MR(Regions,Activities,"Irrigation water (m3) - water stress adjusted",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions,Activities,"AllAndAverageTypes","Animal welfare: transport volume index",ProductionSystems,ProductionConditions,Scenarios)
ActCropsGrass_Inputs_MR(Regions,Activities,"Labour use - total (h)",ProductionSystems,ProductionConditions,Scenarios)
         Country level only (to be adjusted via total labour use on country level)
ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,ProductionConditions,Scenarios)
         XXXXXXXXXXX TRY TO SOMEHOW DERIVE THIS ON NUTS2 as well!!!!!!!!

TO DO:
- get areas per NUTS2 region for all scenarios and crops, match with countries and then multiply with water use and labour use and sum over all areas



NUTS2 level:
ActCropsGrass_Inputs_MR(Regions,Activities,"Green Water Footprint (m3)",ProductionSystems,ProductionConditions,Scenarios)
ActCropsGrass_Inputs_MR(Regions,Activities,"Blue Water Footprint (m3)",ProductionSystems,ProductionConditions,Scenarios)
ActCropsGrass_Inputs_MR(Regions,Activities,"Grey Water Footprint (m3)",ProductionSystems,ProductionConditions,Scenarios)
params to be used:
         WF_WaterUseActivities(CommoditiesEquivalentActivities,WF_Activity,"Green",WF_Country,WF_ProvinceState)
         WF_WaterUseActivities(CommoditiesEquivalentActivities,WF_Activity,"Blue",WF_Country,WF_ProvinceState)
                  *For forage: use country level PFister data         = ActCropsGrass_OtherChar(Regions,Activities,"IrrigW per t MOutput1 (m3) - total demand","AllProdSyst","AllProdCond");
         WF_WaterUseActivities(CommoditiesEquivalentActivities,WF_Activity,"Grey",WF_Country,WF_ProvinceState)

ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2020",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2030",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2050",ProductionSystems,ProductionConditions,Scenarios)
params to be used:
         awr_components(RegionCodes_awr,"mr")
         awr_components(RegionCodes_awr,"hwd1")
         awr_components(RegionCodes_awr,"hwd2")
         awr_components(RegionCodes_awr,"hwd3")
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants",ProductionSystems,ProductionConditions,Scenarios)
params to be used:
         take from BioBam: sum of non-grass (i.e. conc and forage) in feeding rations
ActAnimalsHead_OtherChar_MR(Regions,Poultry,AnimalTypeInHerd,"Animal welfare: production intensity index - eggs",ProductionSystems,ProductionConditions,Scenarios)
params to be used:
         take from BioBam: egg yield: i.e. FCR for eggs - the more eggs per feed the more intensive


*to get the numbers to be displayed in SESSIT:
*multiply with area
         taken from BioBam
or animal heads,
         allocated from country level (SOLm) to NUTS2 by NUTS2 yield and production levels
or animal production
         taken from BioBam
then sum over all activities per NUTS2 region



*yet missing:
*price data and thus labour productivity as price per labout hour;
*labour input per head animal
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Derive total impacts

VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
VActAnimalsAPU_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
VActAnimalsHead_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
VActFishSeafood_Inputs_MR.l(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)
         = VActFishSeafood_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios);
VActForest_Inputs_MR.l(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,Scenarios)
         = VActForest_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActForest_Inputs_MR(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,Scenarios);
VActOthers_Inputs_MR.l(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,Scenarios)
         = VActOthers_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActOthers_Inputs_MR(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,Scenarios);

VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
VActAnimalsAPU_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
VActFishSeafood_Outputs_MR.l(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)
         = VActFishSeafood_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios);
VActForest_Outputs_MR.l(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,Scenarios)
         = VActForest_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActForest_Outputs_MR(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,Scenarios);
VActOthers_Outputs_MR.l(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,Scenarios)
         = VActOthers_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActOthers_Outputs_MR(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,Scenarios);


VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass_PerHaBased,ProductionSystems,ProductionConditions,Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass_PerHaBased,ProductionSystems,ProductionConditions,Scenarios);
VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass_PerTonYieldBased,ProductionSystems,ProductionConditions,Scenarios)
         = VActCropsGrass_Outputs_MR.l(Regions,Activities,"MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass_PerTonYieldBased,ProductionSystems,ProductionConditions,Scenarios);
*the code above results in deleting some total values that have been derived in the Fertilizer Application module for allocating fertilizer quantities;
*if you want to have them, then calculate with a $-condition that the result variable is NOT YET present, or write these variables to a specific set to be stored in the Fertilizer module

VActAnimalsAPU_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios);
VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals_PerHeadBased,ProductionSystems,ProductionConditions,Scenarios)
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals_PerHeadBased,ProductionSystems,ProductionConditions,Scenarios);
VActFishSeafood_OtherChar_MR.l(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios)
         = VActFishSeafood_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios);
VActForest_OtherChar_MR.l(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios)
         = VActForest_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios);
VActOthers_OtherChar_MR.l(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,Scenarios)
         = VActOthers_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 *ActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,Scenarios);

VCommod_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)
         = VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 *Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios);
VCommod_OtherChar_MR.l(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)
         = VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 *Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios);

*part below is already calculated and includes e.g. main output N with crop residues, etc., hence the conditions:
VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios))
         = VCropResidues_Quantity_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 *CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios);
VCropResidues_OtherChar_MR.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCropResidues_OtherChar_MR.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios))
         = VCropResidues_Quantity_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 *CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios);
VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios))
         = VCropResidues_Quantity_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 *CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,Scenarios)
                          *CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios);


*XXXCheck: conditiosn for manure and res quant ok? Is already there what we need and is it not lost again?? XXXCHECK
*manure in results file: incl Human faec or not?
*Fert applic: check that indeed human faeces and N from main poutput of set aside and perm grass is in N input that is yield relevant.



VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)
         = VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 *FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios);
*the following results in no useful totals
*VFeedingRations_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar_ForTotal,ProductionSystems,ProductionConditions,Scenarios)
*         = VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,Scenarios)
*                 *FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar_ForTotal,ProductionSystems,ProductionConditions,Scenarios);

*part of this is already available (and includes further aspects already, such as human faeces), hence the condition to not loose this again:
VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios))
         = VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,Scenarios);
VManure_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios))
         = VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 *Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios);
VManure_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios))
         = VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 *Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios);

*the following is calculated for ManureManagement_ForDerivingTotals, as only those entries in the parameter ManureManagement are such that this multiplication does deliver anything useful
VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement_ForDerivingTotals,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement_ForDerivingTotals,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios))
         = VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 *Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios)
                          *Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement_ForDerivingTotals,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios);

$ontext;
the following is not calculated, as the parameter FertApplicCharact is such that this multiplication does not deliver anything useful
VManureApplication_MR.l(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         = VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 *ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios);
$offtext;

*the following needs an additonal matching of commod and residue outputs
*VCropResAndBiomassApplication_MR.l(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
*         = VCropResidues_Quantity_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
*                 *CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios);

VMinFertApplication_MR.l(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         = sum(MineralFertilizerProdTech,VMineralFertilizerQuantity_MR.l(Regions,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios))
                 *MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios);



*derive AllProdSyst for some values where you have org and con:
VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActAnimalsHead_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActAnimalsHead_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProdSyst_OrgCon,ProductionConditions,Scenarios));

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,ProdSyst_OrgCon,ProductionConditions,Scenarios));


VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,"AllManManSystems","AllAndAverageTemp","AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,"AllManManSystems","AllAndAverageTemp","AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,"AllManManSystems","AllAndAverageTemp",ProdSyst_OrgCon,ProductionConditions,Scenarios));

VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,"AllAndAverageCropResManSystem","AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,"AllAndAverageCropResManSystem","AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,"AllAndAverageCropResManSystem",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProdSyst_OrgCon,ProductionConditions,Scenarios));

VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterNutrients,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterNutrients,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterNutrients,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VCommod_Feed_Contents_MR.l(Regions,Commodities,Contents,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VCommod_Feed_Contents_MR.l(Regions,Commodities,Contents,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VCommod_Feed_Contents_MR.l(Regions,Commodities,Contents,ProdSyst_OrgCon,ProductionConditions,Scenarios));

*and the following is available for AllProdSyst only, thus assign to convent:
VMineralFertilizerQuantity_MR.l(Countries,"mineral N fert (N)","AllMinFertProdTech","Convent",Scenarios)
         = VMineralFertilizerQuantity_MR.l(Countries,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst",Scenarios);
VMineralFertilizerQuantity_MR.l(Countries,"mineral N fert (N)","AllMinFertProdTech","Convent","Baseline") = 0;
VMineralFertilizerQuantity_MR.l(Countries,"mineral N fert (N)","AllMinFertProdTech","Convent","BaselineDerived") = 0;
VMineralFertilizerQuantity_MR.l(Countries,"mineral N fert (N)","AllMinFertProdTech","Convent","FOFA_BAU_2050") = 0;




$exit;




All variables, where sum over org and con may be done:

Thse with * at the beginning have been used above for summing

*2.1) Amount of activity units
*VActCropsGrass_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)                   total amount of activity units - UNIT: Number of hectares
VActAnimalsAPU_QuantityActUnits_MR(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)                   total amount of activity units - UNIT: Number of Animal Production Units (APUs)
*VActAnimalsHead_QuantityActUnits_MR(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios) total amount of activity units - UNIT: Number of animal heads
VActFishSeafood_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)                  total amount of activity units - UNIT: Tons of unprocessed fish or seafood
VActForest_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)                       total amount of activity units - UNIT: Number of hectares
VActOthers_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)                       total amount of activity units - UNIT: to be specified - default: tons of unprocessed main biomass output

*2.2) Inputs to activities
*VActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                total inputs to the crop and grass activities undertaken on agricultural land  - UNIT: total input
VActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)                   total inputs to the animal activities undertaken to produce animal source food - UNIT: total input
*VActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios) total inputs to the animal activities undertaken to produce animal source food - UNIT: total input
VActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)              total inputs to the fish and seafood activities                                - UNIT: total input
VActForest_Inputs_MR(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,Scenarios)                        total inputs to the forest activities undertaken on a unit of forest land      - UNIT: total input
VActOthers_Inputs_MR(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,Scenarios)                         total inputs to any other activities undertaken                                - UNIT: total input

*2.3) Outputs from activities
*VActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                total outputs from the crop and grass activities undertaken on agricultural land  - UNIT: total output
VActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)                   total outputs from the animal activities undertaken to produce animal source food - UNIT: total output
*VActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios) total outputs from the animal activities undertaken to produce animal source food - UNIT: total output
VActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)              total outputs from the fish and seafood activities                                - UNIT: total output
VActForest_Outputs_MR(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,Scenarios)                        total outputs from the forest activities undertaken on a unit of forest land      - UNIT: total output
VActOthers_Outputs_MR(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,Scenarios)                         total outputs from any other activities undertaken                                - UNIT: total output

*2.4) Other characteristics of activities
*VActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                total other characteristics of the crop and grass activities undertaken on agricultural land  - UNIT: total OtherChar
VActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)                   total other characteristics of the animal activities undertaken to produce animal source food - UNIT: total OtherChar
*VActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios) total other characteristics of the animal activities undertaken to produce animal source food - UNIT: total OtherChar
VActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios)              total other characteristics of the fish and seafood activities                                - UNIT: total OtherChar
VActForest_OtherChar_MR(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios)                        total other characteristics of the forest activities undertaken on a unit of forest land      - UNIT: total OtherChar
VActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,Scenarios)                         total other characteristics of any other activities undertaken                                - UNIT: total OtherChar


*2.5) Commodity quantities, nutrient contained and other characteristics
VCommod_Quantity_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)                  total commodity quantity                   - UNIT: tons
*VCommod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)         total nutrient contents of commodities     - UNIT: total units nutrient
VCommod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios) total other characteristics of commodities - UNIT: total units OtherChar

*2.6) Commodity untilizationa
VCommod_Production_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)   total quantity of commodity production          - UNIT: tons
VCommod_StockChanges_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios) total quantity of commodity stock changes       - UNIT: tons
VCommod_Food_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)         total quantity of commodity used for food       - UNIT: tons
VCommod_Feed_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)         total quantity of commodity used for feed       - UNIT: tons
VCommod_Seed_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)         total quantity of commodity used for seed       - UNIT: tons
VCommod_Processing_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)   total quantity of commodity used for processing - UNIT: tons
VCommod_Waste_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)        total quantity of commodity lost or wasted      - UNIT: tons
VCommod_Other_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)        total quantity of commodity used for other uses - UNIT: tons
*for some, we also are interested in contents and other characteristics of these commodity utilizations:
VCommod_Food_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)          total nutrient contents of commodity used for food       - UNIT: total units nutrient
*VCommod_Feed_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)          total nutrient contents of commodity used for feed       - UNIT: total units nutrient
VCommod_Waste_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)         total nutrient contents of commodity lost or wasted      - UNIT: total units nutrient
VCommod_Food_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)  total other characteristics of commodity used for food   - UNIT: total units OtherChar
VCommod_Feed_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)  total other characteristics of commodity used for feed   - UNIT: total units OtherChar
VCommod_Waste_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios) total other characteristics of commodity lost or wasted  - UNIT: total units OtherChar


AUX_VCommod_Feed_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)          AUXILIARY variable - used to fasten some divisions - total nutrient contents of commodity used for feed       - UNIT: total units nutrient

*2.7) Crop residue quantities, nutrient contained, other characteristics and management
VCropResidues_Quantity_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                                      total crop residue quantity                   - UNIT: tons
*VCropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios)                      total nutrient contents of crop residues      - UNIT: total units nutrient
VCropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios)                    total other characteristics of crop residues  - UNIT: total units OtherChar
*VCropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios) total values related to crop residues management  - UNIT: total units management values

*2.8) Feeding rations quantities
VFeedingRations_Quantity_MR(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,Scenarios)          total quantity of feed - UNIT: tons
VFeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios) total nutrient contents of feed - UNIT: total units nutrient
VFeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios)          "total other characteristics of feed/Feeding rations - UNIT: total other characteristics"

*2.9) Manure quantities, nutrients contained, other characteristics and management
VManure_Quantity_MR(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)                                                 total manure quantity                     - UNIT: tons
VManure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios)                                  total nutrient contents of manure         - UNIT: total units nutrient
VManure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios)                                total other characteristics of manure     - UNIT: total units OtherChar
*VManure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios) total values related to manure management - UNIT: total units management values

*2.10) Fertilizer application: nutrients and other characteristics
*below: Activities_2 is Livestock plus also aggregates thereof, thereofer the set Livestock is not enough
VManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios) "Total characteristics of manure application to activities; Livestock/AnimalTypeInHerd captures the source of manure - UNIT: total Char"
VCropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)        "Total characteristics of crop residue and other crop biomass application to activities; commodities captures the source of crop residue (other biomass - UNIT: total Characteristic"
VMinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)        "Total characteristics of min fert application to activities; MineralFertilizerType captures the source of min fert - UNIT: total Char"

*2.11) Import and export quantities
VImportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)                          total commodity quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VExportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)                          total commodity quantity EXPORTED from Regions INTO Regions_2 - UNIT: tons
VImportLivingAnimalsHead_MR(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios) total number of live animals IMPORTED into Regions FROM Regions_2 - UNIT: Number of animal heads
VExportLivingAnimalsHead_MR(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios) total number of live animals EXPORTED from Regions INTO Regions_2 - UNIT: Number of animal heads
*for trade in beehives and other animal activities measured in APUs only:
VImportLivingAnimalsAPU_MR(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions,Scenarios)                   total number of live animals IMPORTED into Regions FROM Regions_2 - UNIT: Number of Animal Production Units (APUs)
VExportLivingAnimalsAPU_MR(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions,Scenarios)                   total number of live animals EXPORTED from Regions INTO Regions_2 - UNIT: Number of Animal Production Units (APUs)

VImportQuantity_Feed_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)                     total commodity FEED quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VExportQuantity_Feed_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)                     total commodity FEED quantity EXPORTED from Regions INTO Regions_2 - UNIT: tons

*2.12) Commodities expressed in primary product equivalents
*the following variables are expressed in prim prod equivalents, derived from the corresponding variables that are reported in commodity quantities (cf. definitions above), by means of extraction rates, etc.
*no need to add activity and output dimensions, these informations are captured in the relevant matching sets as defined in _V6_ReadData_CommodityTrees_LinkActivitiesAndCommodities
VPrimProd_Commod_Quantity_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)            total PRIMARY PRODUCT EQUIVALENT commodity quantity                        - UNIT: tons

VPrimProd_Commod_Production_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)          total PRIMARY PRODUCT EQUIVALENT quantity of commodity production          - UNIT: tons
VPrimProd_Commod_StockChanges_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)        total PRIMARY PRODUCT EQUIVALENT quantity of commodity stock changes       - UNIT: tons
VPrimProd_Commod_Food_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for food       - UNIT: tons
VPrimProd_Commod_Feed_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for feed       - UNIT: tons
VPrimProd_Commod_Seed_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for seed       - UNIT: tons
VPrimProd_Commod_Processing_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)          total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for processing - UNIT: tons
VPrimProd_Commod_Waste_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)               total PRIMARY PRODUCT EQUIVALENT quantity of commodity lost or wasted      - UNIT: tons
VPrimProd_Commod_Other_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)               total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for other uses - UNIT: tons

VPrimProd_ImportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)   total PRIMARY PRODUCT EQUIVALENT commodity quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VPrimProd_ExportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)   total PRIMARY PRODUCT EQUIVALENT commodity quantity EXPORTED from Regions INTO Regions_2 - UNIT: tons

VPrimProd_Commod_Quantity_CropActivities_MR(Regions,Commodities,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios) total PRIMARY PRODUCT EQUIVALENT commodity quantity - linked to activities - UNIT: tons
VPrimProd_Commod_Quantity_AnimalActivities_MR(Regions,Commodities,Activities,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)  total PRIMARY PRODUCT EQUIVALENT commodity quantity - linked to activities - UNIT: tons


