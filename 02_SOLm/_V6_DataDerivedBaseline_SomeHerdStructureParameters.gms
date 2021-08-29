PUTCLOSE con,"_V6_DataDerivedBaseline_SomeHerdStructureParameters";
$setglobal ModuleLabel "_V6_DataDerivedBaseline_SOmeHerdStructureParameters"

*GENERAL DESCRIPTION
*This file derives some necessary herd structure parameters

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Derive relations of different animal types in the herd to total animal numbers

$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Derive relations of different animal types in the herd to total animal numbers

*now derive the relation of the various animal types in the herd to the total living animal number:
*this is then the basis to derive the herd structure for the total animal numbers with scenarios, etc.
*the sum in the denominator is needed, as otherwise, the FAOSTAT-numbers from above are used for the Living animals, which may not be consistent with the sum of the animal herd types.
*as we only need these shares, this is ok to do it like this.
ActAnimalsHead_OtherChar(Regions,"Cattle",CattleTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions)
                 $sum(AnimalTypeInHerd_NoAggregates,VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle",AnimalTypeInHerd_NoAggregates,ProductionSystems,ProductionConditions))
         = VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle",CattleTypeInHerd,ProductionSystems,ProductionConditions)
                 /sum(AnimalTypeInHerd_NoAggregates,VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle",AnimalTypeInHerd_NoAggregates,ProductionSystems,ProductionConditions));

ActAnimalsHead_OtherChar(Regions,"Pigs",PigTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions)
                 $sum(AnimalTypeInHerd_NoAggregates,VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs",AnimalTypeInHerd_NoAggregates,ProductionSystems,ProductionConditions))
         = VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs",PigTypeInHerd,ProductionSystems,ProductionConditions)
                 /sum(AnimalTypeInHerd_NoAggregates,VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs",AnimalTypeInHerd_NoAggregates,ProductionSystems,ProductionConditions));


*derive the kiving animals if not yet available:
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living",ProductionSystems,ProductionConditions)
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living",ProductionSystems,ProductionConditions))
         = sum(AnimalTypeInHerd_NoAggregates,VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle",AnimalTypeInHerd_NoAggregates,ProductionSystems,ProductionConditions));
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Living",ProductionSystems,ProductionConditions)
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Living",ProductionSystems,ProductionConditions))
         = sum(AnimalTypeInHerd_NoAggregates,VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs",AnimalTypeInHerd_NoAggregates,ProductionSystems,ProductionConditions));


*for the producing animals it works directly, as they are all from FAOSTAT:
ActAnimalsHead_OtherChar(Regions,"Cattle",ProducingAnimals,"Share animal type in total living animals",ProductionSystems,ProductionConditions)
                 $VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living",ProductionSystems,ProductionConditions)
         = VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle",ProducingAnimals,ProductionSystems,ProductionConditions)
                 /VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living",ProductionSystems,ProductionConditions);
ActAnimalsHead_OtherChar(Regions,"Pigs",ProducingAnimals,"Share animal type in total living animals",ProductionSystems,ProductionConditions)
                 $VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Living",ProductionSystems,ProductionConditions)
         = VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs",ProducingAnimals,ProductionSystems,ProductionConditions)
                 /VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Living",ProductionSystems,ProductionConditions);


*and derive this for the animals without herd structure as well - there it is needed to have the relation producing to living animals:
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions)
                 $(VActAnimalsHead_QuantityActUnits.l(Regions,Livestock,"Living",ProductionSystems,ProductionConditions)
                         AND (NOT ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions)))
         = VActAnimalsHead_QuantityActUnits.l(Regions,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions)
                 /VActAnimalsHead_QuantityActUnits.l(Regions,Livestock,"Living",ProductionSystems,ProductionConditions);


*and now derive the animal type in herd numbers that are consistent with the living animals from FAOSTAT:
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle",CattleTypeInHerd,ProductionSystems,ProductionConditions)
         = VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living",ProductionSystems,ProductionConditions)
                 *ActAnimalsHead_OtherChar(Regions,"Cattle",CattleTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions);

VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs",PigTypeInHerd,ProductionSystems,ProductionConditions)
         = VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Living",ProductionSystems,ProductionConditions)
                 *ActAnimalsHead_OtherChar(Regions,"Pigs",PigTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions);


*CORRECT ERRORS: 
*some countries have living cattle and pigs, but no herd structure this leads to problems later, thus assign herd structures.
*these are
*"Cabo Verde", "Cayman Islands", "Netherlands antilles (former)" "South Sudan" for cattle
*"Cabo Verde", "Netherlands antilles (former)" "South Sudan" for pigs
*thus assign some herd structure to have something, just take Portugal (all unimportant countriesm Cabo verde former Portugues Colony).
Set AUXRegionsCattle(Regions) /"Cabo Verde", "Cayman Islands", "Netherlands antilles (former)","South Sudan"/;
Set AUXRegionsPigs(Regions) /"Cabo Verde", "Netherlands antilles (former)","South Sudan"/;
VActAnimalsHead_QuantityActUnits.l(AUXRegionsCattle,"Cattle",CattleTypeInHerd,ProductionSystems,ProductionConditions)
         = VActAnimalsHead_QuantityActUnits.l(AUXRegionsCattle,"Cattle","Living",ProductionSystems,ProductionConditions)
                 *ActAnimalsHead_OtherChar("Portugal","Cattle",CattleTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions);

VActAnimalsHead_QuantityActUnits.l(AUXRegionsPigs,"Pigs",PigTypeInHerd,ProductionSystems,ProductionConditions)
         = VActAnimalsHead_QuantityActUnits.l(AUXRegionsPigs,"Pigs","Living",ProductionSystems,ProductionConditions)
                 *ActAnimalsHead_OtherChar("Portugal","Pigs",PigTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions);





$ontext;
After this we have the following in SOLm-entities:

ActAnimalsHead_OtherChar(Regions,"Cattle",AnimalTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions)
ActAnimalsHead_OtherChar(Regions,"Pigs",AnimalTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions)

Regions            is      FAOSTAT_Countries
AnimalTypeInHerd   is      SOLm core herd categories - those that are filed in from old herd structure model
$offtext;

