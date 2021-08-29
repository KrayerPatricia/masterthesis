PUTCLOSE con,"_V6_ReadData_VariousSources_HerdStructures";
$setglobal ModuleLabel "SOLmV5_ReadData_VariousSources_HerdStructures"

*GENERAL DESCRIPTION
*This file files in herd structure data

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Herd structures from earlier SOLmVersions (SOLmV2 to SOLmV4)
- 2) Assign values to core model parameters and variables
         2.1) Link some sets as needed
         2.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Herd structures from earlier SOLmVersions (SOLmV2 to SOLmV4)

*this takes the herd structures as calculated separately based on the base year values and the FAOSTAT living and producing animals (maximum entropy model, for detail ssee Schader et al. 2015).
*the numbers for each herd type category are then set in relation to these two values (living/Producing),
*and those shares are then applied to scenario values of living/producing animals to get herd structures in the scenarios, thus assuming that the herd structure does not change.

*Parameters for herd structures:
Parameter result_h_cattle(*,*) this parameter contains the results from the separate cattle herd structure model developed for SOLmV2;
Parameter result_h_pigs(*,*) this parameter contains the results from the separate pig herd structure model developed for SOLmV2;
*as we need to use the country name "Czech republic" used in this data, we cannot use the Set FAOSTAT_CountriesAndRegions, hence the assignment with * in both dimensions
*Parameter result_h_cattle(FAOSTAT_CountriesAndRegions,*) this parameter contains the results from the separate cattle herd structure model developed for SOLmV2;
*Parameter result_h_pigs(FAOSTAT_CountriesAndRegions,*) this parameter contains the results from the separate pig herd structure model developed for SOLmV2;

$GDXIN CHECK_pigs.gdx
$load result_h_pigs
$GDXIN CHECK_pigs.gdx

$GDXIN CHECK_cattle.gdx
$load result_h_cattle
$GDXIN CHECK_cattle.gdx

*these files also contain energy use values used for some calculations in the nutrient requirement file __SOLmV4_AnimalNutrientRequirements.gms


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Assign values to core model parameters and variables
*2.1) Link some sets as needed

set Match_ReadHerdStructure_HerdStructureSOLm(AnimalCategoriesInHerd_VariousSources,AnimalTypeInHerd)
/
*Cattle: General structure used as default
Producing_Dairy_Cattle.Producing_Dairy_Cattle
Dsires.Dsires

DFemaleCalves1.DFemaleCalves1
DFemaleCalves2.DFemaleCalves2
DFemaleCalves3.DFemaleCalves3

DMaleCalves1.DMaleCalves1
DMaleCalves2.DMaleCalves2

Bcows.Bcows
Bsires.Bsires

BFemaleCalves1.BFemaleCalves1
BFemaleCalves2.BFemaleCalves2

BMaleCalves1.BMaleCalves1
BMaleCalves2.BMaleCalves2

*Pigs: General structure used as default
Sows.Sows
Sucklers.Sucklers
Weaners.Weaners
Fatteners.Fatteners
Boars.Boars
Rep_Sows.Rep_Sows
Rep_Boars.Rep_Boars
/;


*2.2) Link to the core model parameters

*first, we need to assign the values from "Czech Republic" (used in the herds trcuture data) to "Czechia" (used in SOLm):

RESULT_H_CATTLE("Czechia",AnimalCategoriesInHerd_VariousSources)
         = RESULT_H_CATTLE("Czech Republic",AnimalCategoriesInHerd_VariousSources);
RESULT_H_PIGS("Czechia",AnimalCategoriesInHerd_VariousSources)
         = RESULT_H_PIGS("Czech Republic",AnimalCategoriesInHerd_VariousSources);

*below, all the $(NOT-conditions to avoid to overwriting FAOSTAT data from the module FAOSTAT_LivestockProduction, which is the data to be used for these variables - here it is only about the
*        shares of animal types not covered in FAOSTAT
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle",AnimalTypeInHerd,"AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle",AnimalTypeInHerd,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND Match_ReadHerdStructure_HerdStructureSOLm(AnimalCategoriesInHerd_VariousSources,AnimalTypeInHerd)),
                 RESULT_H_CATTLE(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources));
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs",AnimalTypeInHerd,"AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs",AnimalTypeInHerd,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND Match_ReadHerdStructure_HerdStructureSOLm(AnimalCategoriesInHerd_VariousSources,AnimalTypeInHerd)),
                 RESULT_H_PIGS(FAOSTAT_Countries,AnimalCategoriesInHerd_VariousSources));

*all below values are already available from FAOSTAT, I THINK!!!
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living","AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 RESULT_H_CATTLE(FAOSTAT_Countries,"FAOSTAT_LivingCattle"));
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Living","AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Living","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 RESULT_H_PIGS(FAOSTAT_Countries,"FAOSTAT_LivingPigs"));

VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Producing_Dairy_Cattle","AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Producing_Dairy_Cattle","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 RESULT_H_CATTLE(FAOSTAT_Countries,"FAOSTAT_ProducingDairyCattle"));

VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Milk producing","AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Milk producing","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 RESULT_H_CATTLE(FAOSTAT_Countries,"FAOSTAT_ProducingDairyCattle"));

VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Meat producing","AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Meat producing","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 RESULT_H_CATTLE(FAOSTAT_Countries,"FAOSTAT_SlaughtheredCattle"));

VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Meat producing","AllProdSyst","AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Meat producing","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 RESULT_H_PIGS(FAOSTAT_Countries,"FAOSTAT_SlaughtheredPigs"));



$ontext;
After this we have the following in SOLm-entities:

VActAnimalsHead_QuantityActUnits(Regions,"Cattle",AnimalTypeInHerd,"AllProdSyst","AllProdCond")
VActAnimalsHead_QuantityActUnits(Regions,"Pigs",AnimalTypeInHerd,"AllProdSyst","AllProdCond")

Regions            is      FAOSTAT_Countries
AnimalTypeInHerd   is      SOLm core herd categories - those that are filed in from old herd structure model
$offtext;

