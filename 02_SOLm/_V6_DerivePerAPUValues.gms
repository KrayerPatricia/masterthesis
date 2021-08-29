PUTCLOSE con,"_V6_DerivePerAPUValues";

*GENERAL DESCRIPTION
*This file contains the code to derive per APU (animal production unit) values for inputs, outputs, other characeristics from the corresponding per head values

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Derive APU values
         1.1) Animals without herd structure
         1.2) Animals with herd structure

$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Derive APU values
*1.1) Animals without herd structure

*ATTENTION: "ImpactPerAnimaL" stand fro Impact/head/year - thus related to the whole year, in case the animal lives less long - put differently, it relates to "places"

*this sets the impacts of all living animals in relation to producing animals, thus:
*Equals TotalNrLivingAnimals*ImpactPerAnimal/TotalNrProducingAnimals = ImpactperAnimal*(TotalNrLivingAnimals/TotalNrProducingAnimals) = ImpactperAnimal/(TotalNrProducingAnimals/TotalNrLivingAnimals)
*                = ImpactperAnimal / ShareProducingInLivingAnimals
*In the following, the impacts are fully allocated to each primary product - i.e. no allocation between meat/milk, etc.
ActAnimalsAPU_Inputs_MR(Regions_MR,Activities_MR,"Meat producing",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Inputs_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_Outputs_MR(Regions_MR,Activities_MR,"Meat producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_Inputs_MR(Regions_MR,Activities_MR,"Milk producing",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Inputs_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_Outputs_MR(Regions_MR,Activities_MR,"Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_Inputs_MR(Regions_MR,Activities_MR,"Egg producing",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Inputs_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_Outputs_MR(Regions_MR,Activities_MR,"Egg producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);

*then do feeding rations: assign the feed needed per APU based on the per head feed needed and again the relation producing/living animals (same formalism, as feed input can formally be treated as any impact indicator from above).
*currently, again, this is done without allocation.
FeedingRationsAPU_Contents_MR(Regions_MR,Activities_MR,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,Scenarios)
*the following is to be used with the code without detailed feeding rations
*         = FeedingRationsHeads_Contents_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_Contents_MR(Regions_MR,Activities_MR,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,Scenarios)
*the following is to be used with the code without detailed feeding rations
*         = FeedingRationsHeads_Contents_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_Contents_MR(Regions_MR,Activities_MR,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,Scenarios)
*the following is to be used with the code without detailed feeding rations
*         = FeedingRationsHeads_Contents_MR(Regions_MR,Activities_MR,"AllAndAverageTypes",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);


*1.2) Animals with herd structure
*assign for animals with herd structure separately:
*first pigs: APU is one producing animal and all the others that come with it: thus: sum the weighted herd types, weights: relation of herd types to producing (derived from relation of herd types to living, and producing to living)
*this is derived from the following formulae:
$ontext;
ImpactPerAPU = SUM_HerdType(NrAnimalInHerdType*ImpactPerHerdType)/NrProducingAnimals = SUM_HerdType(NrAnimalInHerdType/NrLivingAnimals*ImpactPerHerdType)*NrLivingAnimals/NrProducingAnimals
= SUM_HerdType(ShareAnimalInHerdTypeInLiving*ImpactPerHerdType)/ShareProducingAnimalsInLiving
$offtext;
ActAnimalsAPU_Inputs_MR(Regions_MR,"Pigs","Meat producing",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(PigTypeInHerd,ActAnimalsHead_Inputs_MR(Regions_MR,"Pigs",PigTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs",PigTypeInHerd,"share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios))
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_Outputs_MR(Regions_MR,"Pigs","Meat producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(PigTypeInHerd,ActAnimalsHead_Outputs_MR(Regions_MR,"Pigs",PigTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs",PigTypeInHerd,"share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios))
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_OtherChar_MR(Regions_MR,"Pigs","Meat producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(PigTypeInHerd,ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs",PigTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs",PigTypeInHerd,"share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios))
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_Contents_MR(Regions_MR,"Pigs","Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(PigTypeInHerd,FeedingRationsHeads_OtherChar_MR(Regions_MR,"Pigs",PigTypeInHerd,Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,Scenarios)
*the following is to be used with the code without detailed feeding rations
*         = sum(PigTypeInHerd,FeedingRationsHeads_Contents_MR(Regions_MR,"Pigs",PigTypeInHerd,Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs",PigTypeInHerd,"share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios))
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Pigs","Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);


*and cattle:
$ontext;
there we have two herds - dairy and beef; so put impacts in relation to those and account for meat animals from the dairy herd as well.
For the dairy herd milk production this is straightforward, derived as above for Pigs, but all in relation to the dairy herd (cf. the following), for the beef, see the more complex calculations after this.

ImpactPerAPUDairy = SUM_DairyHerdType(NrAnimalInDairyHerdType*ImpactPerHerdType)/NrProducingDairyAnimals = SUM_DairyHerdType(NrAnimalInDairyHerdType/NrLivingDairyAnimals*ImpactPerHerdType)*NrLivingDairyAnimals/NrProducingDairyAnimals
= SUM_DairyHerdType(ShareAnimalInDairyHerdTypeInLivingDairy*ImpactPerHerdType)/ShareProducingDairyAnimalsInLivingDairy
$offtext;

alias(DairyCattleTypeInHerd,DairyCattleTypeInHerd_2);

ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,"share_AnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios)
                 $sum(DairyCattleTypeInHerd_2,VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle",DairyCattleTypeInHerd_2,ProductionSystems,ProductionConditions,Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle",DairyCattleTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 /sum(DairyCattleTypeInHerd_2,VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle",DairyCattleTypeInHerd_2,ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Milk producing","share_ProducingAnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios)
                 $sum(DairyCattleTypeInHerd_2,VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle",DairyCattleTypeInHerd_2,ProductionSystems,ProductionConditions,Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","Producing_Dairy_Cattle",ProductionSystems,ProductionConditions,Scenarios)
                          /sum(DairyCattleTypeInHerd_2,VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle",DairyCattleTypeInHerd_2,ProductionSystems,ProductionConditions,Scenarios));


ActAnimalsAPU_Inputs_MR(Regions_MR,"Cattle","Milk producing",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Milk producing","share_ProducingAnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(DairyCattleTypeInHerd,ActAnimalsHead_Inputs_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,"share_AnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios)
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Milk producing","share_ProducingAnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios));
ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Milk producing","share_ProducingAnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(DairyCattleTypeInHerd,ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,"share_AnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios)
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Milk producing","share_ProducingAnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios));
ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Milk producing","share_ProducingAnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(DairyCattleTypeInHerd,ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,"share_AnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios)
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Milk producing","share_ProducingAnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios));

FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Milk producing","share_ProducingAnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(DairyCattleTypeInHerd,FeedingRationsHeads_OtherChar_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,Scenarios)
*the following is to be used with the code without detailed feeding rations
*         = sum(DairyCattleTypeInHerd,FeedingRationsHeads_Contents_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",DairyCattleTypeInHerd,"share_AnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios)
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Milk producing","share_ProducingAnimalInDairyHerdType In TotalLivingDairyAnimals",ProductionSystems,ProductionConditions,Scenarios));

$ontext;
For the beef herd and meat production from diary, it is more complex:

In SOLm, producing animals are numbers given from FAOSTAT, NOT derived from the herd structure;
The relation to the herd structure is assumingly as follows:
all male calves that are in the system are producing (i.e. B and DMaleCalves1 - not Calves2 and 3, as those grow from Calves1 and 2 and are thus already included;
BFemaleCalves1 is also producing
If summed, this does then not yet match the number of producing animals - as not all calves grow for a year  (so there are several turns), some calves become dairy cows, and as also some mature cattle goes into meat, etc.
         (so also start from DFC1 and not from DFC1-DFC3, assuming that all DFC3 go into producing dairy cattle);
thus multiply each of these animal categories by ScaleFactorMeatProducingCattle = NrMeatProducingAnimals/(BMC1+DMC1+BFC1+DFC1)

Meat producing from the dairy herd are thus: (DMC1+DFC1)*ScaleFactorMeatProducingCattle
Meat producing from the beef herd are thus: (BMC1+BFC1)*ScaleFactorMeatProducingCattle

(
for later
thus, the share of meat producing from beef herd in relation to total meat producing is:
(BMC1+BFC1)*ScaleFactorMeatProducingCattle / VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","Meat producing",ProductionSystems,ProductionConditions,Scenarios)
         = (BMC1+BFC1) / (BMC1+BFC1+DMC1+DFC1))
and for dairy:
(DMC1+DFC1)*ScaleFactorMeatProducingCattle / VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","Meat producing",ProductionSystems,ProductionConditions,Scenarios)
         = (DMC1+DFC1) / (BMC1+BFC1+DMC1+DFC1))
)

Now derive the per APU impacts:
in general, it is as for the pigs:
ImpactPerAPU = SUM_HerdType(NrAnimalInHerdType*ImpactPerHerdType)/NrProducingAnimals = SUM_HerdType(NrAnimalInHerdType/NrLivingAnimals*ImpactPerHerdType)*NrLivingAnimals/NrProducingAnimals
= SUM_HerdType(ShareAnimalInHerdTypeInLiving*ImpactPerHerdType)/ShareProducingAnimalsInLiving

More specifically, for milk from dairy:
ImpactPerAPUDairy = SUM_DairyHerdType(NrAnimalInDairyHerdType*ImpactPerDairyHerdType)/NrDairyProducingAnimals = SUM_DairyHerdType(NrAnimalInDairyHerdType/NrLivingDairyAnimals*ImpactPerDairyHerdType)*NrLivingDairyAnimals/NrProducingDairyAnimals
= SUM_DairyHerdType(ShareAnimalInDairyherdTypeInLivingDairy*ImpactPerDairyHerdType)/ShareProducingDairyAnimalsInLivingDairy

*Beef from beef herd
ImpactPerAPUBeef = SUM_BeefHerdType(NrAnimalInBeefHerdType*ImpactPerBeefHerdType)/NrBeefHerdBeefProducingAnimals
= SUM_BeefHerdType(NrAnimalInBeefHerdType/NrLivingBeefAnimals*ImpactPerBeefHerdType)*NrLivingBeefAnimals/NrBeefHerdBeefProducingAnimals
= SUM_BeefHerdType(ShareAnimalInBeefherdTypeInLivingBeef*ImpactPerBeefHerdType)/ShareBeefHerdBeefProducingAnimalsInLivingBeef

Thereby, ShareBeefHerdBeefProducingAnimalsInLivingBeef = (BMC1+BFC1)*ScaleFactorMeatProducingCattle/SUM_BeefHerdType(NrAnimalInBeefHerdType)

$offtext;
*Thus calculate these necessary parameters for the beef herd:

ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","Scale factor meat producing cattle",ProductionSystems,ProductionConditions,Scenarios)
                 $(VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","BMaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
                  +VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","DMaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
                  +VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","BFemaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
                  +VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","DFemaleCalves1",ProductionSystems,ProductionConditions,Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","Meat producing",ProductionSystems,ProductionConditions,Scenarios)
                 /(VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","BMaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
                  +VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","DMaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
                  +VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","BFemaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
                  +VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","DFemaleCalves1",ProductionSystems,ProductionConditions,Scenarios));

alias(BeefCattleTypeInHerd,BeefCattleTypeInHerd_2);

ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,"share_AnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios)
                 $sum(BeefCattleTypeInHerd_2,VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle",BeefCattleTypeInHerd_2,ProductionSystems,ProductionConditions,Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle",BeefCattleTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 /sum(BeefCattleTypeInHerd_2,VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle",BeefCattleTypeInHerd_2,ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingAnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios)
                 $sum(BeefCattleTypeInHerd_2,VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle",BeefCattleTypeInHerd_2,ProductionSystems,ProductionConditions,Scenarios))
         = (VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","BMaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
                         + VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","BFemaleCalves1",ProductionSystems,ProductionConditions,Scenarios))
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","Scale factor meat producing cattle",ProductionSystems,ProductionConditions,Scenarios)
                          /sum(BeefCattleTypeInHerd_2,VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle",BeefCattleTypeInHerd_2,ProductionSystems,ProductionConditions,Scenarios));

*Now we do the beef from beef herd, as explained above:
*= SUM_BeefHerdType(ShareAnimalInBeefherdTypeInLivingBeef*ImpactPerBeefHerdType)/ShareBeefHerdBeefProducingAnimalsInLivingBeef

ActAnimalsAPU_Inputs_MR(Regions_MR,"Cattle","Meat producing",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingAnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(BeefCattleTypeInHerd,ActAnimalsHead_Inputs_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,"share_AnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios)
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingAnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios));
ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingAnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(BeefCattleTypeInHerd,ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,"share_AnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios)
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingAnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios));
ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Meat producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingAnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(BeefCattleTypeInHerd,ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,"share_AnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios)
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingAnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios));

FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingAnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = sum(BeefCattleTypeInHerd,FeedingRationsHeads_OtherChar_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,Scenarios)
*the following is to be used with the code without detailed feeding rations
*         = sum(BeefCattleTypeInHerd,FeedingRationsHeads_Contents_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle",BeefCattleTypeInHerd,"share_AnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios)
                                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingAnimalInBeefHerdType In TotalLivingBeefAnimals",ProductionSystems,ProductionConditions,Scenarios));


*finally, we calculate beef from dairy.
$ontext;
This is captured by allocating the impact from the dairy APU (i.e. from one dairy cattle plus required herd) to the producing beef animals in the dairy herd.
This is then the same impacts as from the full dairy herd, covered also there. Thus it is a basis to do an allocation between milk and beef from the dairy herd.
The producing beef animals in the dairy herd are - per producing dairy cattle:
So we have the same APU, but understand it as the APU for beef from dairy - but this becomes only effective when calculating the per ton meat impacts, not before, thus just equate these APU values.
Thus do not specificly derive APUs for the meat from dairy, referring to per meat producing animal - this can still be added if needed, some code bits for this can be found just below.


CODE for doing APU per dairy meat producing animal, to be completed when needed:
(ShareDMC1_perProdDairy + ShareDFC1_perProdDairy)*ScaleFactorMeatProducingCattle = (DMC1 + DFC1)/NrProducingDairy *ScaleFactorMeatProducingCattle

Thus, set the impact from one Dairy APU in relation to this number of beef producing animals:
= ImpactDairyAPU/(NrProdBeefAnimalInDairyHerd in relation to 1 dairy cattle)
= ImpactDairyAPU / NrBeefProdAnimalsInDairyHerd * NrProducingDairyCattle =   ImpactDairyAPU * NrProducingDairyCattle/[(DMC1 + DFC1)*ScaleFactorMeatProducingCattle]

*thus first calculate this share of beef producing animals in diary herd in relation to producing dairy milk animals:
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios)
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","Producing_Dairy_Cattle",ProductionSystems,ProductionConditions,Scenarios)
         = (VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","DMaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
           + VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","DFemaleCalves1",ProductionSystems,ProductionConditions,Scenarios))
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","Scale factor meat producing cattle",ProductionSystems,ProductionConditions,Scenarios)
         /VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","Producing_Dairy_Cattle",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_Inputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsAPU_Inputs_MR(Regions_MR,"Cattle","Milk producing",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios);

$offtext;

$onmulti
Set AnimalTypeInHerd
*add one element in AnimalTypeInHerd needed only here for the further code on relating impacts to APU, etc.
/
"Meat producing (from dairy herd)"
/;
$offmulti

ActAnimalsAPU_Inputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsAPU_Inputs_MR(Regions_MR,"Cattle","Milk producing",InputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios);

*For specifically relating the per APU impacts to dairy herd meat, we also have to adapt the yield, as we then need the meat yield per dairy APU and not per meat animal in the dairy herd, thus:
*For this, we first need to calculate the share of beef producing animals in diary herd in relation to producing dairy milk animals:
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios)
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","Producing_Dairy_Cattle",ProductionSystems,ProductionConditions,Scenarios)
         = (VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","DMaleCalves1",ProductionSystems,ProductionConditions,Scenarios)
           + VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","DFemaleCalves1",ProductionSystems,ProductionConditions,Scenarios))
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","Scale factor meat producing cattle",ProductionSystems,ProductionConditions,Scenarios)
         /VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","Producing_Dairy_Cattle",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios);



$ontext;
After this, we have the impacts per APU, i.e. in relation to the production unit that supports ONE producing animal (i.e. for the main output, viz. meat, milk or eggs).
Dividing these impacts by the yield thus results in impacts per ton output.

For co-products, the whole impacts are currently allocated to ALL outputs:
for chicken, the whole impact is allocated to eggs and meat EACH
for dairy cattle, the whole impact is allocated to milk and meat from dairy EACH

$offtext;




$exit;



