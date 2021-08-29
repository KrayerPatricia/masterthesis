PUTCLOSE con,"_V6_AssignInitialValuesToScenarios";

*GENERAL DESCRIPTION
*This file contains the code for assigning baseline values to all parameters for initialising the scenario runs.
*This is then later replaced by more specific values, if needed, - as provided in the scenario specification file.
*For all parameters, where values are missing for the scenario, these are assigned here equal to the baseline.
*Variables are all derived during the code execution, or provided by the scenario definitions, hence there is no initialisation of variables with baseline values needed.

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Assign baseline values to all parameters
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Assign baseline values to all parameters


*1.1) Activities: input parameters
ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"Baseline");
ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,"Baseline");
ActForest_Inputs_MR(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT ActForest_Inputs_MR(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActForest_Inputs_MR(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActOthers_Inputs_MR(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActOthers_Inputs_MR(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,"Baseline");

*1.2) Activities: output parameters
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline");
ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActForest_Outputs_MR(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActForest_Outputs_MR(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActOthers_Outputs_MR(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActOthers_Outputs_MR(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,"Baseline");

*1.3) Activities: other characteristics
ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"Baseline");
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,"Baseline");
ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,"Baseline");

*1.4) Commodities: nutrient contents and other characteristics
Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline");
Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"%Scenario%"))
         = Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"Baseline");

*1.5) Commodity tree parameters
*NOT YET INITIALISED
Commod_ProductionShare_MR(Regions,Commodities,Commodities_2,ProductionSystems,"%Scenario%")
         = Commod_ProductionShare_MR(Regions,Commodities,Commodities_2,ProductionSystems,"Baseline");
*NOT YET INITIALISED
Commod_ExtractionRate_MR(Regions,Commodities,Commodities_2,ProductionSystems,"%Scenario%")
         = Commod_ExtractionRate_MR(Regions,Commodities,Commodities_2,ProductionSystems,"Baseline");
*and define a parameter that captures how aggregate commodities are disaggregated into primary activities (e.g. "Bread" comes from "All Cereals" and those have to be disaggregated to "Wheat", "Rye", etc.
*assumptions on this are often very shaky and for now, much is determined by expert quess from Adrian Muller from August 2019 -
*        or where sensible, it is allocated according to the relative shares of single commodities in the aggregate, if this information is available
*NOT YET INITIALISED
Commod_SingleInAggregateCommodShares_MR(Regions,Commodities,Commodities_2,ProductionSystems,"%Scenario%")
         = Commod_SingleInAggregateCommodShares_MR(Regions,Commodities,Commodities_2,ProductionSystems,"Baseline");

*1.6) Crop residues: nutrient contents, other characteristics and management
CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"Baseline");
CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"Baseline");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline");

*For CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"),
*there are already values for org and convent - thus apply missing values as eps and remove later again (after Assign initialValues.....DifferentiatedProdSyst..)
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = eps;


*1.7) Feeding rations
*NOT YET INITIALISED
FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline");
FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"%Scenario%"))
         = FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"Baseline");
*FeedingRationsHeads_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $FeedingRationsHeads_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*         = FeedingRationsHeads_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"%Scenario%"))
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"Baseline");
*FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*         = FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline");


*1.8) Manure: nutrient contents, other characteristics and management
*NOT YET INITIALISED
Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,"Baseline");
Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,"%Scenario%"))
         = Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,"Baseline");
Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,"%Scenario%"))
         = Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,"Baseline");




*1.9) Fertilizer application: nutrients and other characteristics
ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline");
CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline");
MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%"))
         = MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline");



*1.10) Further parameters
GWP_GTP_SOLm_MR(GreenhouseGases,"%Scenario%")
         = GWP_GTP_SOLm_MR(GreenhouseGases,"Baseline");

SeedContents_MR(Regions,Activities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
         = SeedContents_MR(Regions,Activities,Contents,ProductionSystems,ProductionConditions,"Baseline");

ExtractionRate_CommodityTree_MR(Regions,Commodities,"%Scenario%")
         = ExtractionRate_CommodityTree_MR(Regions,Commodities,"Baseline");

HumanCharacteristics_MR(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities,"%Scenario%")
         = HumanCharacteristics_MR(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities,"Baseline");

MineralFertilizerCharacteristics_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,ProductionSystems,"%Scenario%")
         = MineralFertilizerCharacteristics_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,ProductionSystems,"Baseline");

*AUX_FeedSupplyFactor_BioeSR15_MR(Regions,"%Scenario%")
*         = AUX_FeedSupplyFactor_BioeSR15_MR(Regions,"Baseline");

*AUX_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
*         = AUX_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"Baseline");

ImportScaleFactor_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
                 $VImportQuantity_MR.l(Regions,Regions_2,Commodities,Productionsystems,ProductionConditions,"Baseline")
         = 1;
ImportScaleFactor_MR(Regions,"World",Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(Regions,"World",Commodities,Productionsystems,ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(Regions,"World",Commodities,ProductionSystems,ProductionConditions,"%Scenario%")))
         = 1;
ImportScaleFactor_MR(Regions,"World",Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(Regions,"World",Commodities,ProductionSystems,ProductionConditions,"%Scenario%")))
         = 1;
ExportScaleFactor_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
                 $VExportQuantity_MR.l(Regions,Regions_2,Commodities,Productionsystems,ProductionConditions,"Baseline")
         = 1;

FertilizerUseShare_HumanFaeces(Regions,ProductionSystems,ProductionConditions,"Baseline")
                 $VPopulationNumbers_MR.l(Regions,"PopulationAll","Baseline")
         = 0;
FertilizerUseShare_HumanFaeces(Regions,ProductionSystems,ProductionConditions,"%Scenario%")
         = FertilizerUseShare_HumanFaeces(Regions,ProductionSystems,ProductionConditions,"Baseline");

FertilizerUseShare_ValueChainWaste(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 $VCommod_Waste_MR.l(Regions,Commodities,"ALlProdSyst","AllProdCond","Baseline")
         = 0;
FertilizerUseShare_ValueChainWaste(Regions,Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
         = FertilizerUseShare_ValueChainWaste(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline");

FertilizerUseShare_EndUseFoodWaste(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 $VCommod_Food_MR.l(Regions,Commodities,"ALlProdSyst","AllProdCond","Baseline")
         = 0;
FertilizerUseShare_EndUseFoodWaste(Regions,Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
         = FertilizerUseShare_EndUseFoodWaste(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline");

*1.11) To reduce the size of the parameters: set equal zero if no basic activity data is reported.
Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement_NotContainingBo,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,"Baseline"))
         = 0;
Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement_NotContainingBo,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,"%Scenario%"))
         = 0;

*Similar for crop residues management:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"Baseline"))
         = 0;
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
         = 0;


*and also for manure application:
*NO!!!!: this has already been simplified by only retainint "All crops" values (cf. module _V6_BaselineValues_ForModelRuns, section 7).
*ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
*                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline"))
*         = 0;
*as VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
*        is NOT YET ASSIGNED - only in ScenarioSpecifications, this data reduction has to be done AFTER the scenario specification, namely at the beginning of the module _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc
*ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%"))
*         = 0;




*1.12) Correct those that had to be assigned "eps" to avoid overwriting in the code above:
*NOT NEDED ANYMORE: eps was used in the earlier version when scenario definitons came BEFORE assigning initial values to scenarios
*Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%") = eps)
*         = 0;




$exit;








the folllowing is now in a specific file AFTER the scenario specifications, see _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsETC



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) assign convent/organic values to all parameters - if this differentiation is required


$if %UseProdSyst_ConvOrg% == "NO" $goto EndOfAssignInitialValues

*2.1 Convent values
*2.1.1) Activities: input parameters
ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,"Convent",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"Convent",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,"Convent",ProductionConditions,"%Scenario%")
         = ActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,"AllProdSyst",ProductionConditions,"Baseline");
ActForest_Inputs_MR(Regions,Activities,InputsForest,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT ActForest_Inputs_MR(Regions,Activities,InputsForest,"Convent",ProductionConditions,"%Scenario%"))
         = ActForest_Inputs_MR(Regions,Activities,InputsForest,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActOthers_Inputs_MR(Regions,Activities,InputsOther,"Convent",ProductionConditions,"%Scenario%")
         = ActOthers_Inputs_MR(Regions,Activities,InputsOther,"AllProdSyst",ProductionConditions,"Baseline");

*2.1.2) Activities: output parameters
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"Convent",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"Convent",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,"Convent",ProductionConditions,"%Scenario%")
         = ActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActForest_Outputs_MR(Regions,Activities,OutputsForest,"Convent",ProductionConditions,"%Scenario%")
         = ActForest_Outputs_MR(Regions,Activities,OutputsForest,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActOthers_Outputs_MR(Regions,Activities,OutputsOther,"Convent",ProductionConditions,"%Scenario%")
         = ActOthers_Outputs_MR(Regions,Activities,OutputsOther,"AllProdSyst",ProductionConditions,"Baseline");

*2.1.3) Activities: other characteristics
ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,"Convent",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Convent",ProductionConditions,"%Scenario%")
*                 $(NOT ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Convent",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Convent",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,"Convent",ProductionConditions,"%Scenario%")
         = ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,"AllProdSyst",ProductionConditions,"Baseline");
ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,"Convent",ProductionConditions,"%Scenario%"))
         = ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,"Convent",ProductionConditions,"%Scenario%")
         = ActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,"AllProdSyst",ProductionConditions,"Baseline");

*2.1.4) Commodities: nutrient contents and other characteristics
Commod_Contents_MR(Regions,Commodities,Contents,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT Commod_Contents_MR(Regions,Commodities,Contents,"Convent",ProductionConditions,"%Scenario%"))
         = Commod_Contents_MR(Regions,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");
Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"Convent",ProductionConditions,"%Scenario%"))
         = Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"Baseline");

*2.1.5) Commodity tree parameters
*NOT YET INITIALISED
Commod_ProductionShare_MR(Regions,Commodities,Commodities_2,"Convent","%Scenario%")
         = Commod_ProductionShare_MR(Regions,Commodities,Commodities_2,"AllProdSyst","Baseline");
*NOT YET INITIALISED
Commod_ExtractionRate_MR(Regions,Commodities,Commodities_2,"Convent","%Scenario%")
         = Commod_ExtractionRate_MR(Regions,Commodities,Commodities_2,"AllProdSyst","Baseline");
*and define a parameter that captures how aggregate commodities are disaggregated into primary activities (e.g. "Bread" comes from "All Cereals" and those have to be disaggregated to "Wheat", "Rye", etc.
*assumptions on this are often very shaky and for now, much is determined by expert quess from Adrian Muller from August 2019 -
*        or where sensible, it is allocated according to the relative shares of single commodities in the aggregate, if this information is available
*NOT YET INITIALISED
Commod_SingleInAggregateCommodShares_MR(Regions,Commodities,Commodities_2,"Convent","%Scenario%")
         = Commod_SingleInAggregateCommodShares_MR(Regions,Commodities,Commodities_2,"AllProdSyst","Baseline");

*2.1.6) Crop residues: nutrient contents, other characteristics and management
CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,"Convent",ProductionConditions,"%Scenario%"))
         = CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,"AllProdSyst",ProductionConditions,"Baseline");
CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,"Convent",ProductionConditions,"%Scenario%"))
         = CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"%Scenario%"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"Baseline");
*Crop res man entries for share in crop res systems have org/con values in the baseline already: thus, the assignment above results in wrongly assinglin gopen burning to organic, as this is in AllPRodSyst, but not in organic,
*hence reassign this correctly:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,"Convent",ProductionConditions,"%Scenario%")
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,"Convent",ProductionConditions,"Baseline");


*2.1.7) Feeding rations
*NOT YET INITIALISED
FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"Convent",ProductionConditions,"%Scenario%")
         = FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");
FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Convent",ProductionConditions,"%Scenario%"))
         = FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Convent",ProductionConditions,"%Scenario%"))
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"AllProdSyst",ProductionConditions,"Baseline");

*2.1.8) Manure: nutrient contents, other characteristics and management
*NOT YET INITIALISED
Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,"Convent",ProductionConditions,"%Scenario%")
         = Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,"AllProdSyst",ProductionConditions,"Baseline");
Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"Convent",ProductionConditions,"%Scenario%"))
         = Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"Convent",ProductionConditions,"%Scenario%"))
         = Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"AllProdSyst",ProductionConditions,"Baseline");

*2.1.9) Fertilizer application: nutrients and other characteristics
ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%"))
         = ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");
CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%"))
         = CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");
MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%"))
         = MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");

*2.1.10) Further parameters
SeedContents_MR(Regions,Activities,Contents,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT SeedContents_MR(Regions,Activities,Contents,"Convent",ProductionConditions,"%Scenario%"))
         = SeedContents_MR(Regions,Activities,Contents,"AllProdSyst",ProductionConditions,"Baseline");

*2.2 Organic values
*2.2.1) Activities: input parameters
ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"Organic",ProductionConditions,"%Scenario%")
         = ActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,"Organic",ProductionConditions,"%Scenario%")
         = ActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,"AllProdSyst",ProductionConditions,"Baseline");
ActForest_Inputs_MR(Regions,Activities,InputsForest,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActForest_Inputs_MR(Regions,Activities,InputsForest,"Organic",ProductionConditions,"%Scenario%"))
         = ActForest_Inputs_MR(Regions,Activities,InputsForest,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActOthers_Inputs_MR(Regions,Activities,InputsOther,"Organic",ProductionConditions,"%Scenario%")
         = ActOthers_Inputs_MR(Regions,Activities,InputsOther,"AllProdSyst",ProductionConditions,"Baseline");

*2.2.2) Activities: output parameters
*yields: apply yield gap:
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline")
                 *ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"Baseline")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"Baseline")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*other outputs:
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,"Organic",ProductionConditions,"%Scenario%")
         = ActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActForest_Outputs_MR(Regions,Activities,OutputsForest,"Organic",ProductionConditions,"%Scenario%")
         = ActForest_Outputs_MR(Regions,Activities,OutputsForest,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActOthers_Outputs_MR(Regions,Activities,OutputsOther,"Organic",ProductionConditions,"%Scenario%")
         = ActOthers_Outputs_MR(Regions,Activities,OutputsOther,"AllProdSyst",ProductionConditions,"Baseline");


*2.2.3) Activities: other characteristics
ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Organic",ProductionConditions,"%Scenario%")
*                 $(NOT ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,"Organic",ProductionConditions,"%Scenario%")
         = ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,"AllProdSyst",ProductionConditions,"Baseline");
ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,"Organic",ProductionConditions,"%Scenario%"))
         = ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,"AllProdSyst",ProductionConditions,"Baseline");
*NOT YET INITIALISED
ActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,"Organic",ProductionConditions,"%Scenario%")
         = ActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,"AllProdSyst",ProductionConditions,"Baseline");

*2.2.4) Commodities: nutrient contents and other characteristics
Commod_Contents_MR(Regions,Commodities,Contents,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT Commod_Contents_MR(Regions,Commodities,Contents,"Organic",ProductionConditions,"%Scenario%"))
         = Commod_Contents_MR(Regions,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");
Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"Organic",ProductionConditions,"%Scenario%"))
         = Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"Baseline");

*2.2.5) Commodity tree parameters
*NOT YET INITIALISED
Commod_ProductionShare_MR(Regions,Commodities,Commodities_2,"Organic","%Scenario%")
         = Commod_ProductionShare_MR(Regions,Commodities,Commodities_2,"AllProdSyst","Baseline");
*NOT YET INITIALISED
Commod_ExtractionRate_MR(Regions,Commodities,Commodities_2,"Organic","%Scenario%")
         = Commod_ExtractionRate_MR(Regions,Commodities,Commodities_2,"AllProdSyst","Baseline");
*and define a parameter that captures how aggregate commodities are disaggregated into primary activities (e.g. "Bread" comes from "All Cereals" and those have to be disaggregated to "Wheat", "Rye", etc.
*assumptions on this are often very shaky and for now, much is determined by expert quess from Adrian Muller from August 2019 -
*        or where sensible, it is allocated according to the relative shares of single commodities in the aggregate, if this information is available
*NOT YET INITIALISED
Commod_SingleInAggregateCommodShares_MR(Regions,Commodities,Commodities_2,"Organic","%Scenario%")
         = Commod_SingleInAggregateCommodShares_MR(Regions,Commodities,Commodities_2,"AllProdSyst","Baseline");

*2.2.6) Crop residues: nutrient contents, other characteristics and management
CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,"Organic",ProductionConditions,"%Scenario%"))
         = CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,"AllProdSyst",ProductionConditions,"Baseline");
CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,"Organic",ProductionConditions,"%Scenario%"))
         = CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"%Scenario%"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"Baseline");
*Crop res man entries for share in crop res systems have org/con values in the baseline already: thus, the assignment above results in wrongly assinglin gopen burning to organic, as this is in AllPRodSyst, but not in organic,
*hence reassign this correctly:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,"Organic",ProductionConditions,"%Scenario%")
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,"Organic",ProductionConditions,"Baseline");

*2.2.7) Feeding rations
*NOT YET INITIALISED
FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"Organic",ProductionConditions,"%Scenario%")
         = FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");
FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Organic",ProductionConditions,"%Scenario%"))
         = FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Organic",ProductionConditions,"%Scenario%"))
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"AllProdSyst",ProductionConditions,"Baseline");

*2.2.8) Manure: nutrient contents, other characteristics and management
*NOT YET INITIALISED
Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,"Organic",ProductionConditions,"%Scenario%")
         = Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,"AllProdSyst",ProductionConditions,"Baseline");
Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"Organic",ProductionConditions,"%Scenario%"))
         = Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"Organic",ProductionConditions,"%Scenario%"))
         = Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"AllProdSyst",ProductionConditions,"Baseline");

*2.2.9) Fertilizer application: nutrients and other characteristics
ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%"))
         = ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");
CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%"))
         = CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");
MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%"))
         = MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");


*2.2.10) Further parameters
SeedContents_MR(Regions,Activities,Contents,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT SeedContents_MR(Regions,Activities,Contents,"Organic",ProductionConditions,"%Scenario%"))
         = SeedContents_MR(Regions,Activities,Contents,"AllProdSyst",ProductionConditions,"Baseline");


$label EndOfAssignInitialValues




$exit;



