PUTCLOSE con,"_V6_DataDerived_CropGrassNutrientRequirements";

*GENERAL DESCRIPTION
*This file contains an alternative approach to determine crop and grass nutrient requirements,
*        based on the nutrient contents in the output, accounting for crop residue output and N from N fixation.
*        this is only assigned, though, in case no other, better data is available

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Crop and grass nutrient requirements derived
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Crop and grass nutrient requirements derived

*these requirements are derived as a proxy via total N in output and residues minus total N fixation with some correction factors:;
*these are only calculated if no value is available from the data
*TO BE IMPROVED, THE FACTORS FOR N-Fix, etc. are QUITE AD HOC!
*PROVIDE MOTIVATION FOR CORRECTION FACTORS AND IMPROVE IN GENERAL

*first, derive N contents in all outputs from activities, i.e. MainOutputs1,2,... plus residues:
*tN per ton main outputs from activities
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
                 Commod_Contents_MR(Regions_MR,Commodities_MR,"N (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput2 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput2 (t)",Commodities_MR),
                 Commod_Contents_MR(Regions_MR,Commodities_MR,"N (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput3 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput3 (t)",Commodities_MR),
                 Commod_Contents_MR(Regions_MR,Commodities_MR,"N (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

*then, derive N contents in residues from activities (per ton main output 1)
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"DM in MainOutput1 (tDM)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
                 Commod_Contents_MR(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in residues - per ton MainOutput1 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","DM (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"DM in MainOutput1 (tDM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResidues_OtherChar_MR(Regions_MR,Activities_MR,"Average residues (t)","Residue share t DM / t DM MainOutput1",ProductionSystems,ProductionConditions,"%Scenario%")
                          /CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","DM (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","N (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%");

*then derive requirements:
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((NOT ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%"))
                         AND ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         +ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput2 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput2 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         +ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput3 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput3 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 +0.5*ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in residues - per ton MainOutput1 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 -0.75*ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N fixation per ton MainOutput1 (tN)",ProductionSystems,ProductionConditions,"%Scenario%");

*set equal zero if negative values result:
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*and for P:
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P in MainOutput1 (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
                 Commod_Contents_MR(Regions_MR,Commodities_MR,"P2O5 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P in MainOutput2 (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput2 (t)",Commodities_MR),
                 Commod_Contents_MR(Regions_MR,Commodities_MR,"P2O5 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P in MainOutput3 (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput3 (t)",Commodities_MR),
                 Commod_Contents_MR(Regions_MR,Commodities_MR,"P2O5 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

*then, derive P contents in residues from activities (per ton main output 1)
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P in residues - per ton MainOutput1 (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","DM (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"DM in MainOutput1 (tDM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResidues_OtherChar_MR(Regions_MR,Activities_MR,"Average residues (t)","Residue share t DM / t DM MainOutput1",ProductionSystems,ProductionConditions,"%Scenario%")
                          /CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","DM (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","P2O5 (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%");

*then derive requirements:
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((NOT ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%"))
                         AND ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P in MainOutput1 (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                         +ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P in MainOutput2 (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput2 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         +ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P in MainOutput3 (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput3 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 +0.5*ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P in residues - per ton MainOutput1 (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%");


*derive total requirements:
VActCropsGrass_OtherChar_MR.l(Regions_MR,Activities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_Outputs_MR.l(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N req - per ton yield based (tN)",ProductionSystems,ProductionConditions,"%Scenario%");

VActCropsGrass_OtherChar_MR.l(Regions_MR,Activities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_Outputs_MR.l(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P req - per ton yield based (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%");
















