PUTCLOSE con,"_V6_CoreModelEquations_FertilizerApplication";

*GENERAL DESCRIPTION
*This file contains all the core model equations for fertilizer application

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Total fertilizer supply
         1.1) Manure
         1.2) Crop residues
         1.3) Mineral fertilizers
- 2) Relative nutrient requirements for the different crops and grasses
- 3) Fertilizer allocation to crops and grassland

$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Total fertilizer supply
*1.1) Manure


*total manure N available to be put on the field (crop and grass), per geographic unit
VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for crop areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure N for grass areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"));

*total manure P available to be put on the field (crop and grass), per geographic unit
VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure P for crop areas (tP2O5)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure P for crop areas (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure P for grass areas (tP2O5)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure P for grass areas (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"));


*for comparison, also calculate the total manure N and P numbers BEFORE management, ie. the quantity being excreted:
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","P in manure (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"P in manure (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"));

*and also calculate total manure quantities in VS and TS:
VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Livestock_MR,AnimalTypeInHerd_MR),
                 ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProductionSystems,ProductionConditions,"%Scenario%"));



*assign the human faeces quantities used for fertilization:
VHumanCharacteristics_MR.l(Regions_MR,"PopulationAll","N excretion in human faeces (tN)","All commodities","AllProdSyst","AllProdCond","%Scenario%")
         = HumanCharacteristics_MR(Regions_MR,"PopulationAll","N excretion in human faeces (tN)","All commodities","%Scenario%")
                *VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","%Scenario%");
VHumanCharacteristics_MR.l(Regions_MR,"PopulationAll","N excretion in human faeces - for croplands (tN)","All commodities",ProductionSystems,ProductionConditions,"%Scenario%")
         = VHumanCharacteristics_MR.l(Regions_MR,"PopulationAll","N excretion in human faeces (tN)","All commodities","AllProdSyst","AllProdCond","%Scenario%")
                 *FertilizerUseShare_HumanFaeces(Regions_MR,ProductionSystems,ProductionConditions,"%Scenario%");
*Here: add N and P from human faeces, if available
*just add to the total N quantity in manure that is available for crop areas, and thus treat it similarly to manure after manure management,
*may change - to add it to mineral fertilizers, as it may rather be in the form of a mineral fertilizer as in the form of manure
*to fully account for it: add it as a separate nutrient stream to the model, on par with manure, mineral fertilizer, etc.

*AND also add N from waste along the value chain:
VCommod_Waste_Contents_MR.l(Regions_MR,"All commodities","N for org. fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_MR,VCommod_Waste_Contents_MR.l(Regions_MR,Commodities_MR,"N (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));
*AND also add N from food waste at consumer/retail level:
VCommod_Food_Contents_MR.l(Regions_MR,"All commodities","N for org. fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_MR,VCommod_Food_Contents_MR.l(Regions_MR,Commodities_MR,"N (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));

VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
            + VHumanCharacteristics_MR.l(Regions_MR,"PopulationAll","N excretion in human faeces - for croplands (tN)","All commodities",ProductionSystems,ProductionConditions,"%Scenario%")
                 +VCommod_Waste_Contents_MR.l(Regions_MR,"All commodities","N for org. fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 +VCommod_Food_Contents_MR.l(Regions_MR,"All commodities","N for org. fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%");

*P in human faeces:
*data yet missing, but to be done similarly
*P in waste: do similarly as well.


*1.2) Crop residues

*total crop residue N and P available to be put on the field, per geographic unit
*left on field: is also applied to other crops due to other crops standing next season, etc. - hence sum over all crop res man systems:
VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Crops_MR,CropResManSystemCropland),VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystemCropland,ProductionSystems,ProductionConditions,"%Scenario%"));

VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res P for areas (tP2O5)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Crops_MR,CropResManSystemCropland),VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res P for areas (tP2O5)",CropResManSystemCropland,ProductionSystems,ProductionConditions,"%Scenario%"));

*For grass, the residues are the difference between yield and harvest/grazing, thus remain on the land, thus no sum over different grassland, etc. - or removal to cropland, thus just use the following values:
VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities,"Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CropResManSystemGrassland,VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystemGrassland,ProductionSystems,ProductionConditions,"%Scenario%"));
VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities,"Average Residues (t)","Crop res P for areas (tP2O5)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CropResManSystemGrassland,VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities,"Average Residues (t)","Crop res P for areas (tP2O5)",CropResManSystemGrassland,ProductionSystems,ProductionConditions,"%Scenario%"));



*and add the nutrients in biomass from setaside land, etc. as available in vegan-organic scenarios, etc.
VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Main output N as fert. for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Activities_MR,CropResManSystem),
                 VCropResidues_Management_MR.l(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"));

VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
                 +VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Main output N as fert. for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%");


*As part of the N in crop residues - and to know these amounts, calculate here N-fixation per ha:
*multiplication with yields to get the per ha values:
ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N fixation (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N fixation per ton MainOutput1 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%");

VActCropsGrass_Inputs_MR.l(Regions_MR,Activities_MR,"N fixation (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N fixation (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%");




$ontext;
ONLY FOR CERTAIN BIOE Scenarios - to be improved when rerunning those
*TO BE IMPROVED - AD HOC
*only for organic scenarios, the specific calcs for Selina:
*for now, add off-season legume leys here - assign to "pure legume swards":
*assume 3* the fixation per ha of permanent pasture on a third of cropland without miscanthus:
VActCropsGrass_Inputs_MR.l(Regions_MR,"Pure legume Sward","N fixation (tN)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio")
         =(sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio"))
                 - VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Miscanthus",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio"))
                 *(1/3)*3*ActCropsGrass_Inputs_MR(Regions_MR,"Permanent meadows and pastures","N fixation (tN)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio");

VActCropsGrass_Inputs_MR.l(Regions_MR,"Pure legume Sward","N fixation (tN)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         =(sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease"))
                 - VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Miscanthus",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease"))
                 *(1/3)*3*ActCropsGrass_Inputs_MR(Regions_MR,"Permanent meadows and pastures","N fixation (tN)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease");

VActCropsGrass_Inputs_MR.l(Regions_MR,"Pure legume Sward","N fixation (tN)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         =(sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
                 - VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Miscanthus",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
                 *(1/3)*3*ActCropsGrass_Inputs_MR(Regions_MR,"Permanent meadows and pastures","N fixation (tN)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF");

VActCropsGrass_Inputs_MR.l(Regions_MR,"Pure legume Sward","N fixation (tN)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         =(sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW"))
                 - VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Miscanthus",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW"))
                 *(1/3)*3*ActCropsGrass_Inputs_MR(Regions_MR,"Permanent meadows and pastures","N fixation (tN)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW");

$offtext;



*1.3) Mineral fertilizers

*total min fert N available to be put on the field, per geographic unit
*EITHER already assigned in the scenario specifications:
*VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")
*OR adjusted here according to total requirements:

*Total nutrient requirements for the different crops and grasses

VActCropsGrass_OtherChar_MR.l(Regions_MR,Activities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VActCropsGrass_Outputs_MR.l(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%");

VActCropsGrass_OtherChar_MR.l(Regions_MR,Activities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VActCropsGrass_Outputs_MR.l(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%");

*derive N and P requirements from all crops (sum over POSITIVE values only!!):
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Crops_MR$(VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")>0),
                 VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Crops_MR$(VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")>0),
                 VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%"));

*and similarly for all grass activities:
VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CoreGrassActivities_MR$(VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")>0),
                 VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CoreGrassActivities_MR$(VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")>0),
                 VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%"));

*also calculate N requirements from crops PLUS temp grass:
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_OtherChar_MR.l(Regions_MR,"temporary meadows and pastures","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%");
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_OtherChar_MR.l(Regions_MR,"temporary meadows and pastures","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%");
*and for All grass WITHOUT temp grass
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Grass WITHOUT temp grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 - VActCropsGrass_OtherChar_MR.l(Regions_MR,"temporary meadows and pastures","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%");
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Grass WITHOUT temp grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 - VActCropsGrass_OtherChar_MR.l(Regions_MR,"temporary meadows and pastures","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%");

*adjust mineral fertilizer quantities:
*according to crop requirements - ALTERNATIVES ARE: according to crop PLUS temp pasture requirements - implement as a choice
*but do this only if the ScenariAssumptions do not already privide Min fert quantities.


*for this, we differentiate production systems that use mineral N ertilizer and such that do not
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)","AllProdSyst that use min N fert","AllProdCond","%Scenario%")
         =sum((ProductionSystems_UsingMinNFert,ProductionConditions),
                 VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)",ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%"));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","N req - per ton yield based (tN)","AllProdSyst that use min N fert","AllProdCond","%Scenario%")
         =sum((ProductionSystems_UsingMinNFert,ProductionConditions),
                 VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","N req - per ton yield based (tN)",ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%"));
*similarly for P:
*for this, we differentiate production systems that use mineral P ertilizer and such that do not
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","AllProdCond","%Scenario%")
         =sum((ProductionSystems_UsingMinPFert,ProductionConditions),
                 VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","P req - per ton yield based (tP2O5)",ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%"));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","AllProdCond","%Scenario%")
         =sum((ProductionSystems_UsingMinPFert,ProductionConditions),
                 VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","P req - per ton yield based (tP2O5)",ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%"));


$if %AdjustMinFert% == "CroplandOnly" $goto AdjustMinFert_CroplandOnly
$if %AdjustMinFert% == "CroplandPLUSTempGrass" $goto AdjustMinFert_CroplandPLUSTempPast


$label AdjustMinFert_CroplandOnly

**if there is no differentiation for convent and organic, etc. then replace the prod syst that use min fert with all prod syst:
*$if %UseProdSyst_ConvOrg% == "YES" $goto UseProdSystThatUseMinFert1

**in case the following is not yet assigned: do it here:
*VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)","AllProdSyst","ALlProdCond","%Scenario%")
*                 $(NOT VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)","AllProdSyst","ALlProdCond","%Scenario%"))
*         =sum(ProductionConditions,VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)","AllProdSyst",ProductionConditions,"%Scenario%"));
*
*VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)","AllProdSyst that use min N fert","ALlProdCond","%Scenario%")
*         = VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)","AllProdSyst","ALlProdCond","%Scenario%");


*$label UseProdSystThatUseMinFert1

VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")
                 $(VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)","AllProdSyst that use min N fert","ALlProdCond","BaselineDerived")
                         AND (NOT VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")))
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","Baseline")
                 *VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)","AllProdSyst that use min N fert","ALlProdCond","%Scenario%")
                         /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)","AllProdSyst that use min N fert","ALlProdCond","BaselineDerived");
VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","%Scenario%")
                 $(VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","ALlProdCond","BaselineDerived")
                         AND (NOT VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","%Scenario%")))
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","Baseline")
                 *VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","ALlProdCond","%Scenario%")
                         /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","ALlProdCond","BaselineDerived");

*$if %UseProdSyst_ConvOrg% == "NO" $goto DONOTUseProdSystThatUseMinFert1
*if there is conv/org differentiation, assign all min N fert to convent:
*VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","Convent","%Scenario%")
*         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%");
*$label DONOTUseProdSystThatUseMinFert1


$goto EndOfAdjustMinFert



$label AdjustMinFert_CroplandPLUSTempPast

*if there is no differentiation for convent and organic, etc. then replace the prod syst that use min fert with all prod syst:
*$if %UseProdSyst_ConvOrg% == "YES" $goto UseProdSystThatUseMinFert2
*VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","N req - per ton yield based (tN)","AllProdSyst that use min N fert","ALlProdCond","%Scenario%")
*         = VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","N req - per ton yield based (tN)","AllProdSyst","ALlProdCond","%Scenario%");

*$label UseProdSystThatUseMinFert2

VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")
                 $(VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","N req - per ton yield based (tN)","AllProdSyst that use min N fert","ALlProdCond","BaselineDerived")
                         AND (NOT VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")))
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","Baseline")
                 *VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","N req - per ton yield based (tN)","AllProdSyst that use min N fert","ALlProdCond","%Scenario%")
                         /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","N req - per ton yield based (tN)","AllProdSyst that use min N fert","ALlProdCond","BaselineDerived");
VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","%Scenario%")
                 $(VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","ALlProdCond","BaselineDerived")
                         AND (NOT VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","%Scenario%")))
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","Baseline")
                 *VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","ALlProdCond","%Scenario%")
                         /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","ALlProdCond","BaselineDerived");

**if there is no differentiation for convent and organic, etc. then replace the prod syst that use min fert with all prod syst:
*$if %UseProdSyst_ConvOrg% == "NO" $goto DONOTUseProdSystThatUseMinFert2
*VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","Convent","%Scenario%")
*         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%");

*$label DONOTUseProdSystThatUseMinFert2

$goto EndOfAdjustMinFert





$label EndOfAdjustMinFert

$ontext;
*thus, here we have new total supply for min fert:
VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")
VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","%Scenario%")
*and, if org/conv is differentiated:
VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","Convent","%Scenario%")
VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")
VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","%Scenario%")
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Relative nutrient requirements for the different crops and grasses

*the $-condition is needed to not loose the entries for "AllProdSyst that use min N fert", and similar for P:

VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Crops_MR,VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(Crops_MR,VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%"));

VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops and grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CropsAndCoreGrassActivities_MR,VActCropsGrass_OtherChar_MR.l(Regions_MR,CropsAndCoreGrassActivities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops and grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CropsAndCoreGrassActivities_MR,VActCropsGrass_OtherChar_MR.l(Regions_MR,CropsAndCoreGrassActivities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%"));

VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops PLUS temp grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops PLUS temp grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(CropsAndTempGrassActivities_MR,VActCropsGrass_OtherChar_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops PLUS temp grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops PLUS temp grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = sum(CropsAndTempGrassActivities_MR,VActCropsGrass_OtherChar_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%"));

VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CoreGrassActivities_MR,VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CoreGrassActivities_MR,VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%"));

VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Grass WITHOUT temp grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CoreGrassActivitiesNoTEMPGrass_MR,VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivitiesNoTEMPGrass_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Grass WITHOUT temp grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CoreGrassActivitiesNoTEMPGrass_MR,VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivitiesNoTEMPGrass_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%"));



*derive relative N requirements per crop in relation to N requirements from all crops:
ActCropsGrass_OtherChar_MR(Regions_MR,Crops,"Share N req per crop in N req of all crops",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%");
ActCropsGrass_OtherChar_MR(Regions_MR,Crops,"Share P req per crop in P req of all crops",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%");

*also for crops and all grass
*NOT NEEDED NOW
*ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndCoreGrassActivities,"Share N req per crop or grass in N req of all crops and grass",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops and grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VActCropsGrass_OtherChar_MR.l(Regions_MR,CropsAndCoreGrassActivities,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops and grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%");
*ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndCoreGrassActivities,"Share P req per crop or grass in P req of all crops and grass",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops and grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VActCropsGrass_OtherChar_MR.l(Regions_MR,CropsAndCoreGrassActivities,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops and grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%");

*also for crops and temp grass
ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndTempGrassActivities_MR,"Share N req per crop/grass in N req of all crops+TEMP grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops PLUS temp grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops PLUS temp grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%");
ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndTempGrassActivities_MR,"Share P req per crop/grass in P req of all crops+TEMP grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops PLUS temp grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops PLUS temp grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%");

*for mineral N and P fertilizer allocation, we also need the share in TOTAL requirement summed over all systems using min N and P fert (e.g. organic and conventional for the latter), to be used when org/con is differentiated:
ActCropsGrass_OtherChar_MR(Regions_MR,Crops_MR,"Share N req crop in N req of all crops - All PS w Min N",ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)","AllProdSyst that use min N fert","AllProdCond","%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"N req - per ton yield based (tN)",ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%")
                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","N req - per ton yield based (tN)","AllProdSyst that use min N fert","AllProdCond","%Scenario%");
ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndTempGrassActivities_MR,"Share N req crop/gr in N req all cr+TEMP gr - All PS w Min N",ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","N req - per ton yield based (tN)","AllProdSyst that use min N fert","AllProdCond","%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,"N req - per ton yield based (tN)",ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%")
                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","N req - per ton yield based (tN)","AllProdSyst that use min N fert","AllProdCond","%Scenario%");

ActCropsGrass_OtherChar_MR(Regions_MR,Crops_MR,"Share P req crop in P req of all crops - All PS w Min P",ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","AllProdCond","%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"P req - per ton yield based (tP2O5)",ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%")
                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","AllProdCond","%Scenario%");
ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndTempGrassActivities_MR,"Share P req crop/gr in P req all cr+TEMP gr - All PS w Min P",ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","AllProdCond","%Scenario%")
         = VActCropsGrass_OtherChar_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%")
                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops PLUS temp grass","P req - per ton yield based (tP2O5)","AllProdSyst that use min P fert","AllProdCond","%Scenario%");


*and for grass:
*NOT NEEDED NOW
*ActCropsGrass_OtherChar_MR(Regions_MR,CoreGrassActivities,"Share N req per grass type in N req of all grass",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivities,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%");
*ActCropsGrass_OtherChar_MR(Regions_MR,CoreGrassActivities,"Share P req per grass type in P req of all grass",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivities,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%");

*ActCropsGrass_OtherChar_MR(Regions_MR,CoreGrassActivitiesNoTEMPGrass,"Share N req grass in N req of all grass WITHOUT temp grass",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Grass WITHOUT temp grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivitiesNoTEMPGrass,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Grass WITHOUT temp grass","N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%");
*ActCropsGrass_OtherChar_MR(Regions_MR,CoreGrassActivitiesNoTEMPGrass,"Share P req grass in P req of all grass WITHOUT temp grass",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Grass WITHOUT temp grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VActCropsGrass_OtherChar_MR.l(Regions_MR,CoreGrassActivitiesNoTEMPGrass,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Grass WITHOUT temp grass","P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%");


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Fertilizer allocation to crops and grassland


*TO BE IMPROVED - AD HOC:
*LATER: Do various versions, allow to choose



*first, allocate N fertilizers proportional to N requirements:

*regarding fertilization with manure and crop residues: treat temporary pastures as cropland
*for mineral fertilizers: allow to choosecropland only or cropland+temp grass

*manure:
ActCropsGrass_Inputs_MR(Regions_MR,CropsAndTempGrassActivities_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndTempGrassActivities_MR,"Share N req per crop/grass in N req of all crops+TEMP grass",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,ProductionSystems,ProductionConditions,"%Scenario%");
ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivitiesNoTEMPGrass_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CoreGrassActivitiesNoTEMPGrass_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,CoreGrassActivitiesNoTEMPGrass_MR,"Share N req grass in N req of all grass WITHOUT temp grass",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CoreGrassActivitiesNoTEMPGrass_MR,ProductionSystems,ProductionConditions,"%Scenario%");

*residues
ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Crops_MR,"Share N req per crop in N req of all crops",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"%Scenario%");
ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivities_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CoreGrassActivities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities_MR,"Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CoreGrassActivities_MR,ProductionSystems,ProductionConditions,"%Scenario%");

*mineral N fert

$if %AdjustMinFert% == "CroplandOnly" $goto AdjustMinFert_CroplandOnly_2
$if %AdjustMinFert% == "CroplandPLUSTempGrass" $goto AdjustMinFert_CroplandPLUSTempPast_2

$label AdjustMinFert_CroplandOnly_2

ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"N from mineral fert (tN)",ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%")
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Crops_MR,"Share N req crop in N req of all crops - All PS w Min N",ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%");

$goto EndOfMinNFertAllocation

$label AdjustMinFert_CroplandPLUSTempPast_2

ActCropsGrass_Inputs_MR(Regions_MR,CropsAndTempGrassActivities_MR,"N from mineral fert (tN)",ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%")
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndTempGrassActivities_MR,"Share N req crop/gr in N req all cr+TEMP gr - All PS w Min N",ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,ProductionSystems_UsingMinNFert,ProductionConditions,"%Scenario%");

*$goto EndOfMinNFertAllocation

$label EndOfMinNFertAllocation



$ontext;
If the code above does not work, then use the one balow again:
ActCropsGrass_Inputs_MR(Regions_MR,CropsAndTempGrassActivities_MR,"N from mineral fert (tN)","AllProdSyst",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,"AllProdSyst",ProductionConditions,"%Scenario%")
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndTempGrassActivities_MR,"Share N req per crop/grass in N req of all crops+TEMP grass","AllProdSyst",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,"AllProdSyst",ProductionConditions,"%Scenario%");

ActCropsGrass_Inputs_MR(Regions_MR,CropsAndTempGrassActivities_MR,"N from mineral fert (tN)","Convent",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","Convent","%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndTempGrassActivities_MR,"Share N req per crop/grass in N req of all crops+TEMP grass","Convent",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,"Convent",ProductionConditions,"%Scenario%");

ActCropsGrass_Inputs_MR(Regions_MR,CropsAndTempGrassActivities_MR,"N from mineral fert (tN)","Organic",ProductionConditions,"%Scenario%")
         = 0;
$offtext;





*then allocate P supply in relation to N supply for manure and residues: a given amount of N comes unavoidably with a certain amount of P,
*        the relation being  "Manure P for crop areas (tP2O5)"/"Manure N for crop areas (tN)" for manure and similarly for residues:

ActCropsGrass_Inputs_MR(Regions_MR,CropsAndTempGrassActivities_MR,"P from manure as fert (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,CropsAndTempGrassActivities_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure P for crop areas (tP2O5)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");

ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivitiesNoTEMPGrass_MR,"P from manure as fert (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivitiesNoTEMPGrass_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure P for grass areas (tP2O5)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");

*similarly for residues:
ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"P from CropRes/biomass as fert (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res P for areas (tP2O5)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%");

ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivities_MR,"P from CropRes/biomass as fert (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities_MR,"Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,CoreGrassActivities_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities_MR,"Average Residues (t)","Crop res P for areas (tP2O5)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VCropResidues_Management_MR.l(Regions_MR,CoreGrassActivities_MR,"Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,"%Scenario%");



*and for mineral P fert:

$if %AdjustMinFert% == "CroplandOnly" $goto AdjustMinFert_CroplandOnly_3
$if %AdjustMinFert% == "CroplandPLUSTempGrass" $goto AdjustMinFert_CroplandPLUSTempPast_3

$label AdjustMinFert_CroplandOnly_3

ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"P from mineral fert (tP2O5)",ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%")
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Crops_MR,"Share P req crop in P req of all crops - All PS w Min P",ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%");

$goto EndOfMinPFertAllocation

$label AdjustMinFert_CroplandPLUSTempPast_3

ActCropsGrass_Inputs_MR(Regions_MR,CropsAndTempGrassActivities_MR,"P from mineral fert (tP2O5)",ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%")
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndTempGrassActivities_MR,"Share P req crop/gr in P req all cr+TEMP gr - All PS w Min P",ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,ProductionSystems_UsingMinPFert,ProductionConditions,"%Scenario%");

*$goto EndOfMinPFertAllocation

$label EndOfMinPFertAllocation





$ontext;
NOT NEEDED ANYMORE
$if %UseProdSyst_ConvOrg% == "NO" $goto NotUsingProdSystOrgCon3

*WITH differentiation for org/con:
ActCropsGrass_Inputs_MR(Regions_MR,CropsAndTempGrassActivities_MR,"P from mineral fert (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndTempGrassActivities_MR,"Share P req per crop/gr in P req all cr+TEMP gr - org+con",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,ProductionSystems,ProductionConditions,"%Scenario%");

$label NotUsingProdSystOrgCon3

*NO differentiation for org/con:
ActCropsGrass_Inputs_MR(Regions_MR,CropsAndTempGrassActivities_MR,"P from mineral fert (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst","%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,CropsAndTempGrassActivities_MR,"Share P req per crop/grass in P req of all crops+TEMP grass",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities_MR,ProductionSystems,ProductionConditions,"%Scenario%");
$offtext;



*as it is about nutrient inputs here, do the seed inputs here as well:
ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N inputs from seeds (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Seeds (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *SeedContents_MR(Regions_MR,Activities_MR,"N (t)",ProductionSystems,ProductionConditions,"%Scenario%");
ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"P inputs from seeds (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Seeds (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *SeedContents_MR(Regions_MR,Activities_MR,"P2O5 (t)",ProductionSystems,ProductionConditions,"%Scenario%");


$exit;








*TO BE IMPROVED - AD HOC:

*another way to allocate min P fert: in relation to the P already applied:

CURRENTLY NOT IN USE
as this results in too low min P fert quantities being applied in total; hence we use the simpler code above
 - otherwise it gets quite a biased potentially large allocation to those crops that have requirements not yet met with manure/residues alone.

*then allocate the mineral P fertilizers according to remaining requirements after accounting for manure and residue P inputs:
*the formulae is as follows
$ontext;

P_manure(Crop) = ShareInTotPReq(Crop)*P_Manure_TotalSupply
P_residu(Crop) = ShareInTotPReq(Crop)*P_Residu_TotalSupply

                   P_TotalReq(Crop) - P_manure(Crop) - P_residu(Crop)                               P_TotalReq(Crop)        P_manure(Crop)           P_residu(Crop)
P_MinFert(Crop) = -----------------------------------------------------*P_MinFert_TotalSupply  =  (  ------------------- -  -------------------- - --------------------   ) *P_MinFert_TotalSupply
                               P_TotalRequirements                                                  P_TotalRequirements    P_TotalRequirements      P_TotalRequirements



                                                     P_manure(Crop)           P_residu(Crop)
                 =   ShareInTotPReq(Crop) * (1  -  -------------------- - --------------------   ) *P_MinFert_TotalSupply
                                                     P_TotalReq(Crop)        P_TotalReq(Crop)
$offtext;
*thus, we have the following - for getting per ha values, the division per area needs to be added:

$ontext;
ParameterPerHaSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All","P from mineral fert (tP2O5/ha)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                 $(PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All","Total P requirement (tP2O5)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                         AND AreaHarvestedSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                         AND (PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All","Total P requirement (tP2O5)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                                  - (ParameterPerHaSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All","P from manure as fert (tP2O5/ha)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                                         + ParameterPerHaSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All","P from residues as fert (tP2O5/ha)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%"))
                                                 *AreaHarvestedSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                                   > 0)   )
           = ParameterPerHaSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All","Share P req per crop in P req of all crops - org+con",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                 *(PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All","Total P requirement (tP2O5)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                          - (ParameterPerHaSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All","P from manure as fert (tP2O5/ha)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                                 + ParameterPerHaSOLmV5_ModelRun(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All","P from residues as fert (tP2O5/ha)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%"))
                                         *AreaHarvestedSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%"))
                          /PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All","Total P requirement (tP2O5)",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%")
                 *MineralFertilizerQuantitySOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,"mineral P fert (tP2O5)","All","AverageProdType","%ScenarioSOLmV5%")
                          /AreaHarvestedSOLmV5_ModelRun.l(GeographicRegionSOLmV5_ModelRun,CropsSOLmV5_ModelRun,"All",ProductionTypeSOLmV5_ModelRun,ProductionConditionsSOLmV5_ModelRun,"%ScenarioSOLmV5%");
$offtext;












