PUTCLOSE con,"_V6_CoreModelEquations_FertilizerApplicationEmissions_Ref2050";

*GENERAL DESCRIPTION
*This file contains all the core model equations for fertilizer application emissions calculations

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Direct N2O emissions and N losses from fertilizer application
         1.1) Direct N2O emissions from fertilizer application
         1.2) Corresponding direct N losses from fertilizer application:
- 2) Indirect N2O emissions and N losses from fertilizer application
         2.1) Indirect N2O emissions from fertilizer application
         2.2) Corresponding indirect N losses from fertilizer application:
- 3) Adapt N deposition to manure quantities and fertilizer use
$offtext;

*in THIS file, this is derived with the reference "FOFA_BAU_2050", and not with "Baseline"; this is needed for all scenarios that use FOFA_BAU_2050 as reference, and this choice of reference need to be specified in the scenario specification

*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Direct N2O emissions and N losses from fertilizer application
*1.1) Direct N2O emissions from fertilizer application
*units: t CO2eq / ha


*the parameter ManureApplication_MR gets too big - as it is not differentiated per crops, replace the Activities by "All crops" and "Grass" in the following, first assigning it from one crop and grass type:
*and choose another in case the first is not grown in a region
*do this already before all scenario runs, hence not needed anymore:
$ontext;
ManureApplication_MR(Regions_MR,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
         = ManureApplication_MR(Regions_MR,"Wheat",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%");
ManureApplication_MR(Regions_MR,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ManureApplication_MR(Regions_MR,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ManureApplication_MR(Regions_MR,"Rice, paddy",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%");
ManureApplication_MR(Regions_MR,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ManureApplication_MR(Regions_MR,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ManureApplication_MR(Regions_MR,"Maize",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%");
ManureApplication_MR(Regions_MR,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ManureApplication_MR(Regions_MR,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ManureApplication_MR(Regions_MR,"Cassava",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%");
ManureApplication_MR(Regions_MR,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ManureApplication_MR(Regions_MR,"All crops",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ManureApplication_MR(Regions_MR,"Bananas",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%");

ManureApplication_MR(Regions_MR,Crops,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")=0;
$offtext;

*NO - keep grass separate, as this is partly differentiated (temp grass similar to cropland or not) and as it is few entries only (mostly 2 only)
$ontext;
ManureApplication_MR(Regions_MR,"Grass",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
         = ManureApplication_MR(Regions_MR,"Permanent meadows and pastures",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%");
ManureApplication_MR(Regions_MR,"Grass",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ManureApplication_MR(Regions_MR,"Grass",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ManureApplication_MR(Regions_MR,"Temporary meadows and pastures",Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%");
ManureApplication_MR(Regions_MR,CoreGrassActivities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")=0;
$offtext;

*in the code below, I replaced ManureApplication_MR(Regions_MR,Crops_MR by ManureApplication_MR(Regions_MR,"All Crops" and ManureApplication_MR(Regions_MR,CoreGrassActivities_MR by ManureApplication_MR(Regions_MR,"Grass"
*this has to be changed back to allow for activity specific values - and then the code above setting activity values equal zero has to be deleted as well
*currently, ManureApplication_MR(Regions_MR is only used in this file here, so no changes needed elsewhere


$ontext;
build averages over different livestocks for the following parameters, differentiated by crop/grass, see code below:
ManureApplication_MR(Regions_MR,Activities_MR,Livestock,"AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
ManureApplication_MR(Regions_MR,Activities_MR,Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
ManureApplication_MR(Regions_MR,Activities_MR,Livestock,"AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
ManureApplication_MR(Regions_MR,Activities_MR,Livestock,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
ManureApplication_MR(Regions_MR,Activities_MR,Livestock,"AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
$offtext;
*ManureApplication_MR(Regions_MR,Activities_MR,Livestock,"AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ManureApplication_MR(Regions_MR,"All crops",Livestock_MR,"AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for crop areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                 /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");
ManureApplication_MR(Regions_MR,CoreGrassActivities,"All animals","AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ManureApplication_MR(Regions_MR,CoreGrassActivities,Livestock_MR,"AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for grass areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                 /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");

*the following two currently are already on the "All Animal" level, so the following is not needed:
$ontext;
*ManureApplication_MR(Regions_MR,Activities_MR,Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ManureApplication_MR(Regions_MR,"All crops",Livestock_MR,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for crop areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                 /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");
ManureApplication_MR(Regions_MR,"Grass","All animals","AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ManureApplication_MR(Regions_MR,"Grass",Livestock_MR,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for grass areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                 /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");
$offtext;

*the following six currently are already on the "All Animal" level, so the following is not needed:
$ontext;
*ManureApplication_MR(Regions_MR,Activities_MR,Livestock,"AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ManureApplication_MR(Regions_MR,"All crops",Livestock_MR,"AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for crop areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                 /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");
ManureApplication_MR(Regions_MR,"Grass","All animals","AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ManureApplication_MR(Regions_MR,"Grass",Livestock_MR,"AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for grass areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                 /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");

*ManureApplication_MR(Regions_MR,Activities_MR,Livestock,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ManureApplication_MR(Regions_MR,"All crops",Livestock_MR,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for crop areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                 /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");
ManureApplication_MR(Regions_MR,"Grass","All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ManureApplication_MR(Regions_MR,"Grass",Livestock_MR,"AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for grass areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                 /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");

*ManureApplication_MR(Regions_MR,Activities_MR,Livestock,"AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ManureApplication_MR(Regions_MR,"All crops",Livestock_MR,"AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for crop areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                 /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");
ManureApplication_MR(Regions_MR,"Grass","All animals","AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ManureApplication_MR(Regions_MR,"Grass",Livestock_MR,"AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for grass areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                 /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");
$offtext;



PUTCLOSE con, "Fert Appl Em 2"   timeelapsed;


*BELOW, ManureApplication_MR(Regions_MR,Activities_MR is replaced by ManureApplication_MR(Regions_MR,"Grass" and ManureApplication_MR(Regions_MR,"All crops" - thus doubling this part of the code

ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"Direct N2O from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from mineral fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *MinFertApplication_MR(Regions_MR,Activities_MR,"mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"Direct N2O from CropRes/biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");
ActCropsGrass_Outputs_MR(Regions_MR,Crops_MR,"Direct N2O from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");
ActCropsGrass_Outputs_MR(Regions_MR,CoreGrassActivities_MR,"Direct N2O from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivities_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,CoreGrassActivities_MR,"All animals","AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");


*1.2) Corresponding direct N losses from fertilizer application:
*units: t N / ha
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"Direct N loss from mineral fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from mineral fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *MinFertApplication_MR(Regions_MR,Activities_MR,"mineral N fert (N)","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"Direct N loss from CropRes/biomass as fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%");
ActCropsGrass_Outputs_MR(Regions_MR,Crops_MR,"Direct N loss from manure as fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%");
ActCropsGrass_Outputs_MR(Regions_MR,CoreGrassActivities_MR,"Direct N loss from manure as fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivities_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,CoreGrassActivities_MR,"All animals","AllAndAverageTypes","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%");

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Indirect N2O emissions and N losses from fertilizer application
*2.1) Indirect N2O emissions from fertilizer application
*units: t CO2eq/ha
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O volat from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from mineral fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *MinFertApplication_MR(Regions_MR,Activities_MR,"mineral N fert (N)","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                          *MinFertApplication_MR(Regions_MR,Activities_MR,"mineral N fert (N)","N2O-N per kg N volatized from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");
*only some crop res man systems show volatilization from application (e.g. compost, biogas slurry, sewage sludge), thus apply the emission factor to this share only:
*IPCC 2006 guidelines 11.2.2
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O volat from CropRes/biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Sum(CropResManSystem_WithVolatInApplication,
                                 CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem_WithVolatInApplication,ProductionSystems,ProductionConditions,"%Scenario%"))
                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                          *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","N2O-N per kg N volatized from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");
ActCropsGrass_Outputs_MR(Regions_MR,Crops_MR,"N2O volat from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                          *ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");
ActCropsGrass_Outputs_MR(Regions_MR,CoreGrassActivities_MR,"N2O volat from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivities_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,CoreGrassActivities_MR,"All animals","AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                          *ManureApplication_MR(Regions_MR,CoreGrassActivities_MR,"All animals","AllAndAverageTypes","N2O-N per kg N volatized from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");



*do NH3 emissions as specific part of the volatilization:
*units: t NH3/ha
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"NH3 from mineral fert N applic (tNH3)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from mineral fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *MinFertApplication_MR(Regions_MR,Activities_MR,"mineral N fert (N)","NH3-N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                                  *17/14;
*only some crop res man systems show volatilization and thus NH3 emissions from application (e.g. compost, biogas slurry, sewage sludge), thus apply the emission factor to this share only:
*IPCC 2006 guidelines 11.2.2
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"NH3 from CropRes/biomass as fert N applic (tNH3)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Sum(CropResManSystem_WithVolatInApplication,
                                 CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem_WithVolatInApplication,ProductionSystems,ProductionConditions,"%Scenario%"))
                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","NH3-N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                                 *17/14;
ActCropsGrass_Outputs_MR(Regions_MR,Crops_MR,"NH3 from manure as fert N applic (tNH3)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","NH3-N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                                 *17/14;
ActCropsGrass_Outputs_MR(Regions_MR,CoreGrassActivities_MR,"NH3 from manure as fert N applic (tNH3)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivities_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,CoreGrassActivities_MR,"All animals","AllAndAverageTypes","NH3-N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                                 *17/14;



ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O leach from mineral fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from mineral fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *MinFertApplication_MR(Regions_MR,Activities_MR,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                          *MinFertApplication_MR(Regions_MR,Activities_MR,"mineral N fert (N)","N2O-N per kg N leached from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                  *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O leach from CropRes/biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                          *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","N2O-N per kg N leached from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");
ActCropsGrass_Outputs_MR(Regions_MR,Crops_MR,"N2O leach from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                          *ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");
ActCropsGrass_Outputs_MR(Regions_MR,CoreGrassActivities_MR,"N2O leach from manure as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivities_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,CoreGrassActivities_MR,"All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                          *ManureApplication_MR(Regions_MR,CoreGrassActivities_MR,"All animals","AllAndAverageTypes","N2O-N per kg N leached from fert applic (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");


*2.2) Corresponding indirect N losses from fertilizer application:
*N losses from volatilisation and leaching from fertilizer application - not only the N that is lost via N2O, but ALL N that is lost via leach/volat:
*units: t N/ha
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N volat from mineral fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from mineral fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *MinFertApplication_MR(Regions_MR,Activities_MR,"mineral N fert (N)","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100;
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N volat from CropRes/biomass as fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100;
ActCropsGrass_Outputs_MR(Regions_MR,Crops_MR,"N volat from manure as fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100;
ActCropsGrass_Outputs_MR(Regions_MR,CoreGrassActivities_MR,"N volat from manure as fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivities_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,CoreGrassActivities_MR,"All animals","AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100;

ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N leach from mineral fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from mineral fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *MinFertApplication_MR(Regions_MR,Activities_MR,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100;
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N leach from CropRes/biomass as fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100;
ActCropsGrass_Outputs_MR(Regions_MR,Crops_MR,"N leach from manure as fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,"All crops","All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100;
ActCropsGrass_Outputs_MR(Regions_MR,CoreGrassActivities_MR,"N leach from manure as fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivities_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ManureApplication_MR(Regions_MR,CoreGrassActivities_MR,"All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Adapt N deposition to manure quantities and fertilizer use

*NOW correct N-deposition by change in animal numbers, and thus in manure quantities, and thus in N volatised:
*total N volat = N volat from man man Plus fert applic = per head*AnimalNumber + perha*Area
*80% of deposition is from agriculture, therefore correct as follows:
*Ndeposit = Ndeposit*0.2 + Ndeposit*0.8*Total N volat (Scen)/total N volat (BaselneDerived)
*        thereby, we use the BaselineDerived values, as the Baseline itself does not have all values, as some are calculated only in the baseline derived run

VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from mineral fert N applic (tN)","AllProdSyst","AllProdCond","%Scenario%")
          = sum((Activities_MR,ProductionSystems,ProductionConditions),
                 ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N volat from mineral fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from CropRes/biomass as fert N applic (tN)","AllProdSyst","AllProdCond","%Scenario%")
          = sum((Activities_MR,ProductionSystems,ProductionConditions),
                 ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N volat from CropRes/biomass as fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from manure as fert N applic (tN)","AllProdSyst","AllProdCond","%Scenario%")
          = sum((Activities_MR,ProductionSystems,ProductionConditions),
                 ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N volat from manure as fert N applic (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));

VActAnimalsHead_Outputs_MR.l(Regions_MR,"All animals","AllAndAverageTypes","Manure man N volat (tN)","AllProdSyst","AllProdCond","%Scenario%")
          = sum((Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure man N volat (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"));


ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N deposition (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                              AND (VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from mineral fert N applic (tN)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                                         +VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from CropRes/biomass as fert N applic (tN)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                                         +VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from manure as fert N applic (tN)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                                         +VActAnimalsHead_Outputs_MR.l(Regions_MR,"All animals","AllAndAverageTypes","Manure man N volat (tN)","AllProdSyst","AllProdCond","FOFA_BAU_2050")))
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N deposition (tN)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                  *0.2
                 + ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N deposition (tN)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *0.8
                         *(VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from mineral fert N applic (tN)","AllProdSyst","AllProdCond","%Scenario%")
                                 +VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from CropRes/biomass as fert N applic (tN)","AllProdSyst","AllProdCond","%Scenario%")
                                 +VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from manure as fert N applic (tN)","AllProdSyst","AllProdCond","%Scenario%")
                                 +VActAnimalsHead_Outputs_MR.l(Regions_MR,"All animals","AllAndAverageTypes","Manure man N volat (tN)","AllProdSyst","AllProdCond","%Scenario%"))
                         /(VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from mineral fert N applic (tN)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                                 +VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from CropRes/biomass as fert N applic (tN)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                                 +VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops and grass","N volat from manure as fert N applic (tN)","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                                 +VActAnimalsHead_Outputs_MR.l(Regions_MR,"All animals","AllAndAverageTypes","Manure man N volat (tN)","AllProdSyst","AllProdCond","FOFA_BAU_2050"));




*TO BE IMPROVED - AD HOC:
*to be added: N2 losses from fertilizer application

