PUTCLOSE con,"_V6_ReadData_VariousSources_EntericFermentationEmissionsData";

$ontext;
GENERAL DESCRIPTION
This file reads and/or assigns the values needed to calculate enteric fermentation emissions


DETAILED TABLE OF CONTENTS
- 1) Enteric fermentation emissions parameters
- 2) Assign values to core model parameters and variables
         2.1) Link some sets as needed
         2.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Enteric fermentation emissions parameters


$ontext;
derive emissions from enteric fermentation.
IPCC 2006, VOL4, CHAPTER 10, tier 2: eq 10.21
EF =  ( GE * Ym/100 * 365) /  55.65
with
EF = emission factor, kg CH4 head-1 yr-1
GE = gross energy intake, MJ head-1 year-1  (in the IPCC 2006 documents it is per day, but here in the code it is already per year, as GE is per year: cf. factor 365 in module 07_2_AnimalFeedDemand
Ym = methane conversion factor, per cent of gross energy in feed converted to methane
         coded as FeedToEntericCH4ConversionFactor(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,TypeOfFeed,ProductionSystems,ScenarioNames)
The factor 55.65 (MJ/kg CH4) is the energy content of methane

Ym is taken from tables 10.12 und 10.13
the values are basically 6.5% for all cases besides >90% concentrates-fed cattle: there it is 3%. And lambs from sheep have 4.5% (< 1 year).
assume thus a linear relation with the share of concentrates, and disregard the special value for lamb for now, as we do not differentiate the different Roles In Herd here.
$offtext;



*no assignments here: assign it directly to SOLm parameters, see below.



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Assign values to core model parameters and variables
*2.1) Link some sets as needed


*2.2) Link to the core model parameters

FeedingRationsHeads_OtherChar(Countries,"Cattle",CattleTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 3;
FeedingRationsHeads_OtherChar(Countries,"Cattle",CattleTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 6.5;
FeedingRationsHeads_OtherChar(Countries,"Cattle",CattleTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 6.5;
FeedingRationsHeads_OtherChar(Countries,"Cattle",CattleTypeInHerd,"AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 6.5;

FeedingRationsHeads_OtherChar(Countries,Ruminants,"AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 3;
FeedingRationsHeads_OtherChar(Countries,Ruminants,"AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 6.5;
FeedingRationsHeads_OtherChar(Countries,Ruminants,"AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 6.5;
FeedingRationsHeads_OtherChar(Countries,Ruminants,"AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 6.5;

*and it is not only ruminants, other animals have small contributions to enteric fermentation as well:
*from the GHG inventories of AT and CH:

FeedingRationsHeads_OtherChar(Countries,"Pigs",PigTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6;
FeedingRationsHeads_OtherChar(Countries,"Pigs",PigTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6;
FeedingRationsHeads_OtherChar(Countries,"Pigs",PigTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6;
FeedingRationsHeads_OtherChar(Countries,"Pigs",PigTypeInHerd,"AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6;
FeedingRationsHeads_OtherChar(Countries,"Pigs","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6;
FeedingRationsHeads_OtherChar(Countries,"Pigs","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6;
FeedingRationsHeads_OtherChar(Countries,"Pigs","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6;
FeedingRationsHeads_OtherChar(Countries,"Pigs","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6;

FeedingRationsHeads_OtherChar(Countries,"Chickens","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6*0.76;
FeedingRationsHeads_OtherChar(Countries,"Chickens","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6*0.76;
FeedingRationsHeads_OtherChar(Countries,"Chickens","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6*0.76;
FeedingRationsHeads_OtherChar(Countries,"Chickens","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = 0.6*0.76;
*for chickens, it is 0.16 of ME; thus multiply with 0.76, the factor between ME and GE for chickens
*ATTENTION: (SOURCE!!!??????), to get the correct MCF for the calculations later, that relates to GE.

*Asign to single commodities for the calculations with detailed feeding rations:
FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,Commodities_Feed_Grass,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,Commodities_Feed_Cereals,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,Commodities_Feed_OilCropsAndCakes,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,Commodities_Feed_Pulses,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,Commodities_Feed_Roots,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,Commodities_Feed_Sugar,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,Commodities_Feed_OthersPlants,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");
FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,Commodities_Feed_OthersAnimals,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")
         = FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond");

$ontext;
After this we have the following in SOLm-entities:

FeedingRationsHeads_OtherChar(Countries,Livestock,AnimalTypeInHerd,Commodities,"Percentage GE in feed converted to enteric CH4","AllProdSyst","AllProdCond")

Livestock            is      Ruminants, Pigs, Chickens
Commodities          is      aggregate feed type: concentrates, grass, forage, residues
AnimalTypeInHerd     is      SOLm herd types

*XXX STILL TO BE DONE:

Derive this factor for the whole feeding ration
Then derive the per head emissions according to the formula from IPCC 2006:
         EF =  ( GE * Ym/100 * 365) /  55.65, with EF being CH4/head, GE. GE intake, Ym the factor above
$offtext;


