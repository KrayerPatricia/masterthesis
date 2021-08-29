PUTCLOSE con,"_V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc";

*GENERAL DESCRIPTION
*This file contains the code for assigning further differentiated values for different production systems such as organic/conventional, etc. if required.
*this differentiation is executed conditional to such values already being available, e.g. from the scenario specification or from specific data read in SteeringFile1
*this is governed by global variables set in the scenario specifications that thrigger such specific assignments, if required.

*DETAILED TABLE OF CONTENTS
$ontext;
- 0) Code from the module _V6_AssignInitialValuesToScenarios
- 1) assign convent/organic values to all parameters - if this differentiation is required
         1.1) Convent values
                 1.1.1) Activities: input parameters
                 1.1.2) Activities: output parameters
                 1.1.3) Activities: other characteristics
                 1.1.4) Commodities: nutrient contents and other characteristics
                 1.1.5) Commodity tree parameters
                 1.1.6) Crop residues: nutrient contents, other characteristics and management
                 1.1.7) Feeding rations
                 1.1.8) Manure: nutrient contents, other characteristics and management
                 1.1.9) Fertilizer application: nutrients and other characteristics
                 1.1.10) Further parameters
         1.2) Organic values
                 1.2.1) Activities: input parameters
                 1.2.2) Activities: output parameters
                 1.2.3) Activities: other characteristics
                 1.2.4) Commodities: nutrient contents and other characteristics
                 1.2.5) Commodity tree parameters
                 1.2.6) Crop residues: nutrient contents, other characteristics and management
                 1.2.7) Feeding rations
                 1.2.8) Manure: nutrient contents, other characteristics and management
                 1.2.9) Fertilizer application: nutrients and other characteristics
                 1.2.10) Further parameters
         1.3) Delete the ProductionSystem elements that are NOT organic or conventionsl - i.e. "AllProdSyst"
- 2) assign XXX/YYY values to all parameters - if this differentiation is required
- 3) Set eps equal zero
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*0) Code from the module _V6_AssignInitialValuesToScenarios

*the following is executed only here,
*as VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
*        is not yet available in the module _V6_AssignInitialValuesToScenarios, where it should be done,
*and as it thus can be done only AFTER the ScenarioSpecifications, thus here:
*NO!!!!!: this has already been simplified by only retainint "All crops" values (cf. module _V6_BaselineValues_ForModelRuns, section 7).
*ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%"))
*         = 0;




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) assign convent/organic values to all parameters - if this differentiation is required
*this differentiation is executed conditional to such values already being available, e.g. from the scenario specification or from specific data read in SteeringFile1

$if %UseProdSyst_ConvOrg% == "NO" $goto EndOfAssignInitialValues_OrgCon

*1.1) Convent values
*1.1.1) Activities: input parameters
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

*1.1.2) Activities: output parameters
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

*1.1.3) Activities: other characteristics
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

*1.1.4) Commodities: nutrient contents and other characteristics
Commod_Contents_MR(Regions,Commodities,Contents,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT Commod_Contents_MR(Regions,Commodities,Contents,"Convent",ProductionConditions,"%Scenario%"))
         = Commod_Contents_MR(Regions,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");
Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"Convent",ProductionConditions,"%Scenario%"))
         = Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"Baseline");

*1.1.5) Commodity tree parameters
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

*1.1.6) Crop residues: nutrient contents, other characteristics and management
CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,"Convent",ProductionConditions,"%Scenario%"))
         = CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,"AllProdSyst",ProductionConditions,"Baseline");
CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,"Convent",ProductionConditions,"%Scenario%"))
         = CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"%Scenario%"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"Baseline");
*Crop res man entries for share in crop res systems have org/con values in the baseline already: thus, the assignment above results e.g. in wrongly assingling open burning to organic, as this is in AllPRodSyst, but not in organic,
*hence reassign this correctly:
*NOT NEEDED - SHOULD BE TAKEN CARE OF BY THE CONDITIONAL!!!!
*CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,"Convent",ProductionConditions,"%Scenario%")
*         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,"Convent",ProductionConditions,"Baseline");


*1.1.7) Feeding rations
*NOT YET INITIALISED
FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"Convent",ProductionConditions,"%Scenario%")
         = FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");
FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Convent",ProductionConditions,"%Scenario%"))
         = FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
*FeedingRationsHeads_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"Convent",ProductionConditions,"%Scenario%")
*                 $FeedingRationsHeads_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*         = FeedingRationsHeads_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Convent",ProductionConditions,"%Scenario%"))
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
*FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"Convent",ProductionConditions,"%Scenario%")
**                 $FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*         = FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");



*1.1.8) Manure: nutrient contents, other characteristics and management
*NOT YET INITIALISED
Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,"Convent",ProductionConditions,"%Scenario%")
         = Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,"AllProdSyst",ProductionConditions,"Baseline");
Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"Convent",ProductionConditions,"%Scenario%"))
         = Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"Convent",ProductionConditions,"%Scenario%"))
         = Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"AllProdSyst",ProductionConditions,"Baseline");

*1.1.9) Fertilizer application: nutrients and other characteristics
ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%"))
         = ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");
CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%"))
         = CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");
MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"Convent",ProductionConditions,"%Scenario%"))
         = MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");

*1.1.10) Further parameters
*only for those who have the PRoductionSystems-dimension, i.e. not for GWP, HumandCharacteristics, ExtractionRate:
SeedContents_MR(Regions,Activities,Contents,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT SeedContents_MR(Regions,Activities,Contents,"Convent",ProductionConditions,"%Scenario%"))
         = SeedContents_MR(Regions,Activities,Contents,"AllProdSyst",ProductionConditions,"Baseline");

*GWP_GTP_SOLm_MR(GreenhouseGases,"%Scenario%")
*         = GWP_GTP_SOLm_MR(GreenhouseGases,"Baseline");
*ExtractionRate_CommodityTree_MR(Regions,Commodities,"%Scenario%")
*         = ExtractionRate_CommodityTree_MR(Regions,Commodities,"Baseline");
*HumanCharacteristics_MR(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities,"%Scenario%")
*         = HumanCharacteristics_MR(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities,"Baseline");

MineralFertilizerCharacteristics_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,"Convent","%Scenario%")
         = MineralFertilizerCharacteristics_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,"AllProdSyst","Baseline");

*AUX_FeedSupplyFactor_BioeSR15_MR(Regions,"%Scenario%")
*         = AUX_FeedSupplyFactor_BioeSR15_MR(Regions,"Baseline");

*AUX_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Convent",ProductionConditions,"%Scenario%")
*         = AUX_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"Baseline");

ImportScaleFactor_MR(Regions,Regions_2,Commodities,"Convent",ProductionConditions,"%Scenario%")
                 $(VImportQuantity_MR.l(Regions,Regions_2,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(Regions,Regions_2,Commodities,"Convent",ProductionConditions,"%Scenario%")))
         = 1;
ImportScaleFactor_MR(Regions,"World",Commodities,"Convent",ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(Regions,"World",Commodities,"Convent",ProductionConditions,"%Scenario%")))
         = 1;
ImportScaleFactor_MR(Regions,"World",Commodities,"Convent",ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(Regions,"World",Commodities,"Convent",ProductionConditions,"%Scenario%")))
         = 1;
ExportScaleFactor_MR(Regions,Regions_2,Commodities,"Convent",ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(Regions,Regions_2,Commodities,"ALlProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ExportScaleFactor_MR(Regions,Regions_2,Commodities,"Convent",ProductionConditions,"%Scenario%")))
         = 1;

FertilizerUseShare_HumanFaeces(Regions,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT FertilizerUseShare_HumanFaeces(Regions,"Convent",ProductionConditions,"%Scenario%"))
         = FertilizerUseShare_HumanFaeces(Regions,"AllProdSyst",ProductionConditions,"Baseline");

FertilizerUseShare_ValueChainWaste(Regions,Commodities,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT FertilizerUseShare_ValueChainWaste(Regions,Commodities,"Convent",ProductionConditions,"%Scenario%"))
         = FertilizerUseShare_ValueChainWaste(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");

FertilizerUseShare_EndUseFoodWaste(Regions,Commodities,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT FertilizerUseShare_EndUseFoodWaste(Regions,Commodities,"Convent",ProductionConditions,"%Scenario%"))
         = FertilizerUseShare_EndUseFoodWaste(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");


*1.2) Organic values
*1.2.1) Activities: input parameters
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

*1.2.2) Activities: output parameters
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


*1.2.3) Activities: other characteristics
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

*1.2.4) Commodities: nutrient contents and other characteristics
Commod_Contents_MR(Regions,Commodities,Contents,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT Commod_Contents_MR(Regions,Commodities,Contents,"Organic",ProductionConditions,"%Scenario%"))
         = Commod_Contents_MR(Regions,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");
Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"Organic",ProductionConditions,"%Scenario%"))
         = Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"Baseline");

*1.2.5) Commodity tree parameters
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

*1.2.6) Crop residues: nutrient contents, other characteristics and management
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
*NOT NEEDED - SHOULD BE TAKEN CARE OF BY THE CONDITIONAL!!!!
*CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,"Organic",ProductionConditions,"%Scenario%")
*         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,"Organic",ProductionConditions,"Baseline");

*1.2.7) Feeding rations
*NOT YET INITIALISED
FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"Organic",ProductionConditions,"%Scenario%")
         = FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");
FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Organic",ProductionConditions,"%Scenario%"))
         = FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
*FeedingRationsHeads_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"Organic",ProductionConditions,"%Scenario%")
*                 $FeedingRationsHeads_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
*         = FeedingRationsHeads_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"Organic",ProductionConditions,"%Scenario%"))
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"Organic",ProductionConditions,"%Scenario%")
*                 $FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"AllProdSyst",ProductionConditions,"Baseline");


*1.2.8) Manure: nutrient contents, other characteristics and management
*NOT YET INITIALISED
Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,"Organic",ProductionConditions,"%Scenario%")
         = Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,"AllProdSyst",ProductionConditions,"Baseline");
Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"Organic",ProductionConditions,"%Scenario%"))
         = Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"AllProdSyst",ProductionConditions,"Baseline");
Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"Organic",ProductionConditions,"%Scenario%"))
         = Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"AllProdSyst",ProductionConditions,"Baseline");

*1.2.9) Fertilizer application: nutrients and other characteristics
ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%"))
         = ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");
CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%"))
         = CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");
MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"Organic",ProductionConditions,"%Scenario%"))
         = MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"AllProdSyst",ProductionConditions,"Baseline");


*1.2.10) Further parameters
*only for those who have the PRoductionSystems-dimension, i.e. not for GWP, HumandCharacteristics, ExtractionRate:
SeedContents_MR(Regions,Activities,Contents,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT SeedContents_MR(Regions,Activities,Contents,"Organic",ProductionConditions,"%Scenario%"))
         = SeedContents_MR(Regions,Activities,Contents,"AllProdSyst",ProductionConditions,"Baseline");

*GWP_GTP_SOLm_MR(GreenhouseGases,"%Scenario%")
*         = GWP_GTP_SOLm_MR(GreenhouseGases,"Baseline");
*ExtractionRate_CommodityTree_MR(Regions,Commodities,"%Scenario%")
*         = ExtractionRate_CommodityTree_MR(Regions,Commodities,"Baseline");
*HumanCharacteristics_MR(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities,"%Scenario%")
*         = HumanCharacteristics_MR(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities,"Baseline");

MineralFertilizerCharacteristics_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,"Organic","%Scenario%")
         = MineralFertilizerCharacteristics_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,"AllProdSyst","Baseline");

*AUX_FeedSupplyFactor_BioeSR15_MR(Regions,"%Scenario%")
*         = AUX_FeedSupplyFactor_BioeSR15_MR(Regions,"Baseline");

*AUX_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Organic",ProductionConditions,"%Scenario%")
*         = AUX_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"Baseline");


ImportScaleFactor_MR(Regions,Regions_2,Commodities,"Organic",ProductionConditions,"%Scenario%")
                 $(VImportQuantity_MR.l(Regions,Regions_2,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(Regions,Regions_2,Commodities,"Organic",ProductionConditions,"%Scenario%")))
         = 1;
ImportScaleFactor_MR(Regions,"World",Commodities,"Organic",ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(Regions,"World",Commodities,"Organic",ProductionConditions,"%Scenario%")))
         = 1;
ImportScaleFactor_MR(Regions,"World",Commodities,"Organic",ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(Regions,"World",Commodities,"Organic",ProductionConditions,"%Scenario%")))
         = 1;
ExportScaleFactor_MR(Regions,Regions_2,Commodities,"Organic",ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(Regions,Regions_2,Commodities,"ALlProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ExportScaleFactor_MR(Regions,Regions_2,Commodities,"Organic",ProductionConditions,"%Scenario%")))
         = 1;

FertilizerUseShare_HumanFaeces(Regions,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT FertilizerUseShare_HumanFaeces(Regions,"Organic",ProductionConditions,"%Scenario%"))
         = FertilizerUseShare_HumanFaeces(Regions,"AllProdSyst",ProductionConditions,"Baseline");

FertilizerUseShare_ValueChainWaste(Regions,Commodities,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT FertilizerUseShare_ValueChainWaste(Regions,Commodities,"Organic",ProductionConditions,"%Scenario%"))
         = FertilizerUseShare_ValueChainWaste(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");

FertilizerUseShare_EndUseFoodWaste(Regions,Commodities,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT FertilizerUseShare_EndUseFoodWaste(Regions,Commodities,"Organic",ProductionConditions,"%Scenario%"))
         = FertilizerUseShare_EndUseFoodWaste(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");


*1.3) Delete the ProductionSystem elements that are NOT organic or conventionsl - i.e. "AllProdSyst"

ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActForest_Inputs_MR(Regions,Activities,InputsForest,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActOthers_Inputs_MR(Regions,Activities,InputsOther,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;

ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActForest_Outputs_MR(Regions,Activities,OutputsForest,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActOthers_Outputs_MR(Regions,Activities,OutputsOther,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;

ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
ActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;

Commod_Contents_MR(Regions,Commodities,Contents,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;

Commod_ProductionShare_MR(Regions,Commodities,Commodities_2,"AllProdSyst","%Scenario%")
         =0;
Commod_ExtractionRate_MR(Regions,Commodities,Commodities_2,"AllProdSyst","%Scenario%")
         =0;
Commod_SingleInAggregateCommodShares_MR(Regions,Commodities,Commodities_2,"AllProdSyst","%Scenario%")
         =0;

CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;

FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
FeedingRationsHeads_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;

Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;


ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;

SeedContents_MR(Regions,Activities,Contents,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;
MineralFertilizerCharacteristics_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,"AllProdSyst","%Scenario%")
         =0;
AUX_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;

FertilizerUseShare_HumanFaeces(Regions,"AllprodSyst",ProductionConditions,"%Scenario%")
         =0;

FertilizerUseShare_ValueChainWaste(Regions,Commodities,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;

FertilizerUseShare_EndUseFoodWaste(Regions,Commodities,"AllProdSyst",ProductionConditions,"%Scenario%")
         =0;

$label EndOfAssignInitialValues_OrgCon

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) assign XXX/YYY values to all parameters - if this differentiation is required
*this differentiation is executed conditional to such values already being available, e.g. from the scenario specification or from specific data read in SteeringFile1


*$label EndOfAssignInitialValues_XXXYYY


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Set eps equal zero

*in the scenario specifications, some of these values may be assumed to be zero - this is however only possible by having set them equal to "eps",
*        as otherwise, they would have been treated as being missing by GAMS and thus replaced by baseline values in the code above and the previous module.
*In the following, all eps-values are thus set to zero again, after these assignments.

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         =0;
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"GE per ton DM feeding ration (MJ/t DM)",ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         =0;
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"GE share in feeding ration (share in MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"GE share in feeding ration (share in MJ)",ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         =0;
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"FeedQuant_Req (t)",ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         =0;
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"FeedQuant_Req DM (t)",ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         =0;
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"FeedGE_Req (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"FeedGE_Req (MJ)",ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         =0;

*somewhere, we build the sum over ruminants for the following, hence Activities_MR is not sufficient
FeedingRations_OtherChar_MR(Regions_MR,Activities,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRations_OtherChar_MR(Regions_MR,Activities,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         =0;
FeedingRations_OtherChar_MR(Regions_MR,Activities,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRations_OtherChar_MR(Regions_MR,Activities,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         =0;


ActCropsGrass_OtherChar_MR(Regions,Activities,"Aggreg. Pest. use level (index)","Organic",ProductionConditions,"%Scenario%")
                 $(ActCropsGrass_OtherChar_MR(Regions,Activities,"Aggreg. Pest. use level (index)","Organic",ProductionConditions,"%Scenario%") = eps)
         =0;

Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"%Scenario%") = eps)
         =0;

CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProdSyst_OrgCon,ProductionConditions,"%Scenario%") = eps)
         = 0;


$exit;



