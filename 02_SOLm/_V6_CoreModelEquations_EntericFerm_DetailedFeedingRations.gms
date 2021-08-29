PUTCLOSE con,"_V6_CoreModelEquations_EntericFerm_DetailedFeedingRations";

*GENERAL DESCRIPTION
*This file contains all the core model equations for calculating enteric fermentation emissions for the DETAILED feeding rations

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Enteric fermentation

$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Enteric fermentation

$ontext;
enteric fermentation as a function of GE uptake

derive emissions from enteric fermentation.
IPCC 2006, VOL4, CHAPTER 10, tier 2: eq 10.21
EF =  ( GE * Ym/100 * 365) /  55.65
with
EF = emission factor, kg CH4 head-1 yr-1
GE = gross energy intake, MJ head-1 year-1  (in the IPCC 2006 documents it is per day, but here in the code it is already per year, as GE is per year: thus, NO factor 365 is needed
         but a division by 1000 is needed, as we want tons per year, and not kg per year
Ym = methane conversion factor, per cent of gross energy in feed converted to methane
         coded as FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,"Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions,"Baseline")

The factor 55.65 (MJ/kg CH4) is the energy content of methane

Ym is taken from tables 10.12 und 10.13
the values are basically 6.5% for all cases besides >90% concentrates-fed cattle: there it is 3%. And lambs from sheep have 4.5% (< 1 year).
assume thus a linear relation with the share of concentrates, and disregard the special value for lamb for now, as we do not differentiate the different Roles In Herd here.
$offtext;


*ATTENTION!!! WE CURRENTLY USE GE requirements - change later to GE supply, to make it more variable to changes in this (albeit they need to coincide roughly)

*as auxiliary information: derive average methane conversion factor:

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed,FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedGE_Req (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions,"%Scenario%"))
         /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");



ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Enteric ferment (t CO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_Feed,FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"FeedGE_Req (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities_Feed,"Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions,"%Scenario%"))
                                 *GWP_GTP_SOLm_MR("CH4","%Scenario%")
                                         /100/55.65/1000;

