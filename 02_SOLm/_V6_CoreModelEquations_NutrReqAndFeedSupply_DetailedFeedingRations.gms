PUTCLOSE con,"_V6_CoreModelEquations_NutrReqAndFeedSupply_DetailedFeedingRations";

*GENERAL DESCRIPTION
*This file contains all the core model equations for nutrient requirements and feed supply - using detailed commodity level feeding rations

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Nutrient requirements
- 2) Feeding rations, feed supply and nutrient contents
         2.1) Some general assignments for feeding rations
         2.2) Feed supply from DAQ - contents and aggregates
         2.3) Feed GE and XP contents per DM
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Nutrient requirements

*derive FeedME req for dairy cows based on yields and milk solid contents
*factor 1000 as the formula is for yields in kg milk, but yields are in tons currently
*SOURCE for this? And what is the factor 83?? - Ask Simon!!
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","FeedME_Req_MilkProd (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Milk producing","Milk (t)",ProductionSystems,ProductionConditions,"%Scenario%")*1000
                 *Commod_Contents_MR(Regions_MR,"Milk, Whole","Milk solid contents (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                        *83;

*derive FeedMe req for dairy cow maintenance
*below, liveweight *1000 as the formulae are for kg, and the liveweight is in tons
*condition on the presence of liveweight values to avoid that the requirement is assigned via the term "14" only, also if there is no further data available.
*SOURCE for this? And what are the terms 14 and 0.09?? - Ask Simon!!
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Maintenance (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","Liveweight (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = (14 + 0.09*ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","Liveweight (t)",ProductionSystems,ProductionConditions,"%Scenario%")*1000)*365;

*derive FeedMe req for dairy cow walking
*SOURCE for this? And what are the terms 2 and *1*2?? - Ask Simon!! 2: likely MJ per km; 1 and 2: km wlaked in summer/winter (but winter is quite high, then?).
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Walking (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *2*ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","DailyWalkingDistance (km)",ProductionSystems,ProductionConditions,"%Scenario%")
         + (365 - ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProductionSystems,ProductionConditions,"%Scenario%"))
                 *1*2;

*derive FeedMe req for dairy cow pregnancy
*below, liveweight *1000 as the formulae are for kg, and the liveweight is in tons
*condition on the presence of liveweight values to avoid that the requirement is assigned via the term "1575" only, also if there is no further data available.
*SOURCE for this? And what are the terms 1575 and 3.5?? - Ask Simon!! 2: likely MJ per km; 1 and 2: km wlaked in summer/winter (but winter is quite high, then?).
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Pregnancy (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","Liveweight (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 1575 + 3.5*ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","Liveweight (t)",ProductionSystems,ProductionConditions,"%Scenario%")*1000;

*sum the above terms to get FeedME requirements of dairy cows:
*condition on the presence of liveweight values to avoid that the requirement is assigned also if one of the liveweight-related terms is missing (this likely being the case, whern there are no animals in a country).
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","Liveweight (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","FeedME_Req_MilkProd (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Maintenance (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Walking (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Pregnancy (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

*to be sure that the producing dairy cattle requirements are based on the above calculations: first delete any values that may be around:
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","FeedXP_Req_Total (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Producing_Dairy_Cattle","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;

*derive FeedXP requirements for all animals from FeedME requirements:
*division by 1000000 to get from gXP to tXP
*condition to avoid that this overwrites other existing values (for chicken and horse, for example), in particular if no conversion factor ME to XP is given.
*ATTENTION: CHECK CONDITION - or assure that XP is only around already, when it is better than the values derived here!!
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"XPperME_InFeedReq (gXP/MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                         AND (NOT ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total (t)",ProductionSystems,ProductionConditions,"%Scenario%")))
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedME_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"XPperME_InFeedReq (gXP/MJ)",ProductionSystems,ProductionConditions,"%Scenario%")/1000000;

*derive FeedGE requirements from ME requirements (IPCC 2006):
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Digestibility of Feed (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         - ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes","UE_per_GE (share)",ProductionSystems,ProductionConditions,"%Scenario%"))
                 AND (NOT ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")))
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedME_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /(ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Digestibility of Feed (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         - ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes","UE_per_GE (share)",ProductionSystems,ProductionConditions,"%Scenario%"));



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Feed supply and nutrient contents
*2.1) Some general assignments for feeding rations
*the following allows to have animal specific contents (such as protein for cattle or pigs, etc.)
$ontext;
IMPORTANT: The starting point to derive these values are the following two parameters, that either have to be taken from default baseline values or set in the scenario specifications:
1)        DM quantity shares for each commodity in per head commodity-specific feeding rations
2)        Total GE feed requirement per head from ALL feed

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,
         "Quantity share in DM (share)",
                 ProductionSystems,ProductionConditions,"%Scenario%")

ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,
         "FeedGE_Req_Total (MJ)",
                 ProductionSystems,ProductionConditions,"%Scenario%")
$offtext;

FeedingRations_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_Contents_MR(Regions_MR,Commodities_Feed,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedTotal_Commodity","GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed,
                 FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%"));

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"GE share in feeding ration (share in MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedTotal_Commodity","GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedTotal_Commodity","GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"GE share in feeding ration (share in MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /FeedingRations_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"GE share in feeding ration (share in MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /FeedingRations_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedGE_Req (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"GE share in feeding ration (share in MJ)",ProductionSystems,ProductionConditions,"%Scenario%");



*sum to get the values per feed groups to be consistent with the per single commod values that may have being changed in scenario specifications:
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_FeedGroups_DetailedFeedingRations,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed$Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_Feed,Commodities_FeedGroups_DetailedFeedingRations),
                 FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));
*to be consistent, assign as follows as well, as otherwise, the parameter without "head" is still reporting baseline values for the respective feed commodity groups:
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_FeedGroups_DetailedFeedingRations,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_FeedGroups_DetailedFeedingRations,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");




$ontext;
ANIMAL NUMBERS are not yet derived - thus the following is not possible
VFeedingRations_Quantity_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%");

*total requirement
VFeedingRations_Quantity_MR.l(Regions_MR,"All Animals","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 VFeedingRations_Quantity_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%"));
$offtext;

*NOT NEEDED - taken from baseline
*FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VFeedingRations_Quantity_MR.l(Regions_MR,"All Animals","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
*         = VFeedingRations_Quantity_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VFeedingRations_Quantity_MR.l(Regions_MR,"All Animals","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%");

*DM supply/Demand ratio:
*NOT NEEDED - taken from baseline
*Commod_OtherChar_MR(Regions_MR,Commodities_Feed,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VFeedingRations_Quantity_MR.l(Regions_MR,"All Animals","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VFeedingRations_Quantity_MR.l(Regions_MR,"All Animals","AllAndAverageTypes",Commodities_Feed,ProductionSystems,ProductionConditions,"%Scenario%");


*then derive the needed average values for the feed group grass:
*VCommod_Feed_MR.l(Regions_MR,"AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
*         = sum(Commodities_Feed_Grass,VCommod_Feed_MR.l(Regions_MR,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%"));

*VFeedingRations_Quantity_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
*         = sum(Commodities_Feed_Grass,VFeedingRations_Quantity_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%"));

*VFeedingRations_Quantity_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
*         = sum(Commodities_Feed_Grass,VFeedingRations_Quantity_MR.l(Regions_MR,"All Animals","AllAndAverageTypes",Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%"));

*FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VFeedingRations_Quantity_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VFeedingRations_Quantity_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VFeedingRations_Quantity_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%");

*Commod_OtherChar_MR(Regions_MR,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VFeedingRations_Quantity_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,"AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VFeedingRations_Quantity_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","AggregateFeedGrass_Commodity",ProductionSystems,ProductionConditions,"%Scenario%");

*for deriving animal numbers we need the following:
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Grass,FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed_Grass,"FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Grass,FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed_Grass,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Cereals,FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed_Cereals,"FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed_Cereals,FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed_Cereals,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));




$ontext;
do the above for "Baseline" in the BaselineValues_ForModelRuns-module; then do it for the scenarios.
add new set elements, sets, etc. where needed!!!

FeedingRations_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
FeedingRationsAPU_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
VFeedingRations_Quantity_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
VFeedingRations_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,)
VFeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
$offtext;



*2.2) Feed supply from DAQ - contents and aggregates

*Total Feed supply for each commodity is already derived in  _V6_DataDerived_CropProductionTotalsAndDAQ - derive here various aggregates and content values of this

*Sum over commodities to get the total supply per feed group:
*First, for the feed groups with concentrates such that all concentrates are put together (groups: concentrates, forage, grass (no entries for residues)
VCommod_Feed_MR.l(Regions_MR,Commodities_2,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_2,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR$Match_FeedCommoditiesToFeedCommodGroups(Commodities_MR,Commodities_2),
                 VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
*Then, with concentrates such that main and byprod concentrates are kept in separate groups  (groups: concentratesMAinProd, ConcentratesByProd, forage, grass (no entries for residues)
VCommod_Feed_MR.l(Regions_MR,Commodities_2,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_2,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR$Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,Commodities_2),
                 VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
*then do it for more detailed groups: this covers all, and various crop groups, and also all without grass/forage - but no differentiation main/byprod, as this is not available in the data (e.g. Wheat and products" contains both)
VCommod_Feed_MR.l(Regions_MR,Commodities_2,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_2,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_MR$Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_MR,Commodities_2),
                 VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));

*Dry matter and GE, ME and XP quantities:
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedME (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%");

*and again summed over feed groups:
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed$Match_FeedCommoditiesToFeedCommodGroups(Commodities_Feed,Commodities_FeedGroups),
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,Contents,ProductionSystems,ProductionConditions,"%Scenario%"));
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups,Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Commodities_Feed$Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_Feed,Commodities_FeedGroups),
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,Contents,ProductionSystems,ProductionConditions,"%Scenario%"));
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed$Match_FeedCommodToFeedCommodGroups_DetailedFeedRatio(Commodities_Feed,Commodities_FeedGroups_DetailedFeedingRations),
                 VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_Feed,Contents,ProductionSystems,ProductionConditions,"%Scenario%"));


*2.3) Feed GE and XP contents per DM
*derive Feed GE and XP contents per DM for the feed commodities, feed groups and total feed:

*in the following, the division by VCommod_Feed_Contents_MR causes some problems for some scenarios, where some underlying variable i set to eps
*this is the case for fully vegan scenarios, for example, where the fish quantity is set to eps; thus, set this to zero here, conditional to being = eps:
*similarly for VCommod_Feed_MR(....
VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         = 0;
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         = 0;

*already available for single commodities - thus drop, I think
*derive Feed GE contents per DM for the feed commodities, feed groups and total feed:
Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

Commod_Contents_MR(Regions_MR,Commodities_MR,"FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

*feed groups separately, as they are usually not part of Commodities_MR
Commod_Contents_MR(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

Commod_Contents_MR(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"FeedXP (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Feed_Contents_MR.l(Regions_MR,Commodities_FeedGroups_DetailedFeedingRations,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");







$exit;


may drop the following


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) GE, XP and DM requirements

*derive Feed GE and XP requirements per feed group:
*we have the DM shares and the GE/XP contents of the feed groups, so we can derive the shares in total GE and XP (and DM is already given by the original feeding rations).
$ontext;
how to derive the GE shares in feeding rations if DM shares are given:
Total DM is allocated according to DM shares,

Thus: DM quantities are Total_DM*DM_share_A, etc.
The GE quantity in this is Total_DM*DM_share_A*GE_cont_A, etc.

where:
DM_share_A, DM_share_B, DM_share_C
GE_cont_A, GE_cont_B, GE_cont_C
are the DM shares and GE contents of feed group A, B and C
$offtext;
*Thus, we first need to derive total DM requirements
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_Contents_MR(Regions_MR,"AggregateFeedTotal_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /Commod_Contents_MR(Regions_MR,"AggregateFeedTotal_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,"AggregateFeedConcentrates_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,"AggregateFeedForageCrops_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,"AggregateFeedGrass_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,"AggregateFeedResidues_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Conc (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,"AggregateFeedConcentrates_Commodity","FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Forage (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,"AggregateFeedForageCrops_Commodity","FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Grass (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,"AggregateFeedGrass_Commodity","FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Residues (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Commod_Contents_MR(Regions_MR,"AggregateFeedResidues_Commodity","FeedXP in DM (t)",ProductionSystems,ProductionConditions,"%Scenario%");

ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Conc (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Forage (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Grass (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Residues (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");

*totals per country and animal type:
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Conc (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Conc (t)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Forage (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Forage (t)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Grass (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Grass (t)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Residues (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedXP_Req_Total from Residues (t)",ProductionSystems,ProductionConditions,"%Scenario%");

VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Conc (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Conc (t DM)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Forage (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Forage (t DM)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Grass (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Grass (t DM)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Residues (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Residues (t DM)",ProductionSystems,ProductionConditions,"%Scenario%");


$ontext;

OLD CALCULATION - delete when sure that not needd anymore

*for this, use the DM shares to derive GE shares - will be roughly ok:
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");

*totals per country and animal type:
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
VActAnimalsHead_OtherChar_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");


*now we have all values needed to derive the per animal feed DM requirements from GE req (from the literature) and GE in DM contents (as derived from the feed supply data):
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Conc (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_Contents_MR(Regions_MR,"AggregateFeedConcentrates_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /Commod_Contents_MR(Regions_MR,"AggregateFeedConcentrates_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Forage (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_Contents_MR(Regions_MR,"AggregateFeedForageCrops_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /Commod_Contents_MR(Regions_MR,"AggregateFeedForageCrops_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Grass (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_Contents_MR(Regions_MR,"AggregateFeedGrass_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /Commod_Contents_MR(Regions_MR,"AggregateFeedGrass_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total from Residues (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_Contents_MR(Regions_MR,"AggregateFeedResidues_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /Commod_Contents_MR(Regions_MR,"AggregateFeedResidues_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
*already calculated above:
*ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $Commod_Contents_MR(Regions_MR,"AggregateFeedTotal_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 /Commod_Contents_MR(Regions_MR,"AggregateFeedTotal_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

$offtext;











$exit;








*XXXXXXXXXXXXXXXXXXXXXXX


*2.2) Feed requirements of and supply to single animals

THIS IS DONE only AFTER calculating animal numbers, thus look there.

*here: the animal get what they need - so NO NEED to derive DM quant from GE requirements, as this is all already set up consistently on the level of feeding rations
*and derive the contents of the feed aggregates, thus: "FeedME (MJ/t)", "ME in DM contents (MJ/t)" and GE, XP and DM contents per se, etc. - differentiated per animal:
*thus: FIRST, SUM OVER FEED GROUPS - on commodity Balances level - i.e. for CommoditySOLmV5;


FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,FeedGroupsSOLmV5_ModelRun,QuantPerHead_FeedingRationCharacteristicsSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
         = sum(CommoditySOLmV5_ModelRun$MatchFeedGroups_CommoditySOLmV5(FeedGroupsSOLmV5_ModelRun,CommoditySOLmV5_ModelRun),
                 FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,CommoditySOLmV5_ModelRun,QuantPerHead_FeedingRationCharacteristicsSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%"));
*and derive the total:
FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,"AggregateFeedTotal_CommoditySOLmV5",QuantPerHead_FeedingRationCharacteristicsSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
         = sum(FeedGroupsSOLmV5_ModelRun,
                 FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,FeedGroupsSOLmV5_ModelRun,QuantPerHead_FeedingRationCharacteristicsSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%"));


$ontext;
the matching set used below is the following:
Set MatchFeedQuantFeedContents_FeedingRationCharacteristics(QuantPerHead_FeedingRationCharacteristicsSOLmV5,FeedingRationCharacteristicsSOLmV5)
/
"Feed DM quant supply per head (tDM/head)"."Animal specific DM contents (tDM/t)"
"FeedME supply per head (MJ/head)"."Animal specific FeedME cont (MJ/t)"
"FeedGE supply per head (MJ/head)"."Animal specific FeedGE cont (MJ/t)"
"FeedXP supply per head (t/head)"."Animal specific FeedXP cont (t/t)"
/;
$offtext;

*then derive nutrient (ME, GE, XP, NEL) and DM contents of animal sepcific aggregate Feed types via suitable divisions:
FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,CommoditySOLmV5_FeedAggregates_ModelRun,FeedingRationContentsSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                 $(FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,CommoditySOLmV5_FeedAggregates_ModelRun,"Feed quant supply per head (t/head)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
*                         AND (NOT FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,CommoditySOLmV5_FeedAggregates_ModelRun,FeedingRationCharacteristicsSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")))
*exclude the not condition to assure that the current feeding ration is used to derive the total contents
)
         = sum(QuantPerHead_FeedingRationCharacteristicsSOLmV5$MatchFeedQuantFeedContents_FeedingRationCharacteristics(QuantPerHead_FeedingRationCharacteristicsSOLmV5,FeedingRationContentsSOLmV5),
                 FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,CommoditySOLmV5_FeedAggregates_ModelRun,QuantPerHead_FeedingRationCharacteristicsSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                         /FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,CommoditySOLmV5_FeedAggregates_ModelRun,"Feed quant supply per head (t/head)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%"));
*assure to have this for ALL FEED TYPES - also for grass (thus see, that Grass is a commodity in SOLmV5 when assigning the items to the set CommoditySOLmV5!!

execute_unload 'Test00'
FeedingRationSOLmV5_ModelRun
;


*then derive nutrient per DM contents of the animal specific feed aggregates:
$ontext;
the matching set used below is the following:
Set MatchFeedingRation_FeedContentsAndFeedDMContents(FeedingRationCharacteristicsSOLmV5,FeedingRationCharacteristicsSOLmV5_2)
/
"Animal specific FeedME cont (MJ/t)"."Animal specific FeedME cont in DM (MJ/tDM)"
"Animal specific FeedGE cont (MJ/t)"."Animal specific FeedGE cont in DM (MJ/tDM)"
"Animal specific FeedXP cont (t/t)"."Animal specific FeedXP cont in DM (t/tDM)"
"Animal specific FeedNEL cont (MJ/t)"."Animal specific FeedNEL cont in DM (MJ/tDM)"
/;
$offtext;

FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,CommoditySOLmV5_FeedAggregates_ModelRun,FeedingRationsDMContentsSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                 $(FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,CommoditySOLmV5_FeedAggregates_ModelRun,"Animal specific DM contents (tDM/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
*                         AND (NOT FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,CommoditySOLmV5_FeedAggregates_ModelRun,FeedingRationCharacteristicsSOLmV5_2,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")))
*NOT condition to avoid that it overwrites stuff already assigned
*NO!!! exclude the not condition to assure that the current feeding ration is used to derive the total contents
*        and rather work with subsets ony, then nothing is overwritten.
)
         = sum(FeedingRationCharacteristicsSOLmV5$MatchFeedingRation_FeedContentsAndFeedDMContents(FeedingRationCharacteristicsSOLmV5,FeedingRationsDMContentsSOLmV5),
                 FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,CommoditySOLmV5_FeedAggregates_ModelRun,FeedingRationCharacteristicsSOLmV5,ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                         /FeedingRationSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,ActivitySOLmV5_ModelRun,AnimalCategoriesInHerdSOLmV5_ModelRun,CommoditySOLmV5_FeedAggregates_ModelRun,"Animal specific DM contents (tDM/t)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%"));





*SUPPLY DEMAND RATIO for scenarios in V6 - not needed:
*2.2) Feed supply demand ratio
*derive the ration of feed supplied and demanded per country and feed group:

*first, per country demand:
VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((Livestock,AnimalTypeInHerd),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRations_OtherChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((Livestock,AnimalTypeInHerd),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRations_OtherChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((Livestock,AnimalTypeInHerd),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRations_OtherChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((Livestock,AnimalTypeInHerd),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *FeedingRations_OtherChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"));

VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         =sum((Livestock,AnimalTypeInHerd),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%"));


Commod_OtherChar_MR(Regions_MR,"AggregateFeedConcentrates_Commodity","Feed GE supply/demand ratio Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedConcentrates_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Conc (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions_MR,"AggregateFeedForageCrops_Commodity","Feed GE supply/demand ratio Forage",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedForageCrops_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Forage (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions_MR,"AggregateFeedGrass_Commodity","Feed GE supply/demand ratio Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedGrass_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Grass (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions_MR,"AggregateFeedResidues_Commodity","Feed GE supply/demand ratio Residues",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedResidues_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total from Residues (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions_MR,"AggregateFeedTotal_Commodity","Feed GE supply/demand ratio Total",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_Contents_MR.l(Regions_MR,"AggregateFeedTotal_Commodity","FeedGE (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");



