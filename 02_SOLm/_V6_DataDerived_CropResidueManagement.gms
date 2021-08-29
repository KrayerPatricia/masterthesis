PUTCLOSE con,"_V6_DataDerived_CropResidueManagement";

*GENERAL DESCRIPTION
*This file contains all the data derived after running the model core: for crop residue management and emissions

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Crop residue management
         1.1) Derive P2O5 available for fertilization of areas
         1.2) Derive residue quantities:
         1.3) Derive other nutrient such as N and P2O5 contents of residues:
         1.4) Derive N available for fertilization of areas
         1.5) Crop res management characteristics from total residues
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Crop residue management
*1.1) Derive P2O5 available for fertilization of areas


execute_unload "Test1"
CropResidues_Management_MR
CropResidues_Contents_MR
;


*now derive P available for fertilization:
*first write P loss as share from P in the form of P lost per ton residue:
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man P loss (tP2O5)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
         = CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man share P lost (tP2O5/tP2O5 in crop res)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","P2O5 (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%");

*now derive P available for fertilization
*this is the reminder of P in crop residues, after subtracting losses:
*derive P that is available to be put on the fields:
*condition needed to avoid that (wrong non zero) values are assigned although no biomass is in the respective system and thus no losses are reported
*no, this is no problem, it just assigns the P value for areas per ton residue - if there is no biomass in this system, it is never used.
*but we still use the condition to reduce unnecessary data
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res P for areas (tP2O5)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
         = CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","P2O5 (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
                 - CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man P loss (tP2O5)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%");
*for "feed", no P is lost, but nothing remains for fertilization
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res P for areas (tP2O5)","Feed",ProductionSystems,ProductionConditions,"%Scenario%") = 0;

*set negative values equal to zero:
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res P for areas (tP2O5)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res P for areas (tP2O5)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


*1.2) Derive residue quantities:
*Derive the residue production. This is derived based on the DM production, thus, based on residue shares tDM residue / tDM production - the latter is available on commodity level:
*        namely as VCommod_Contents_MR.l(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%"); thus, derive residue quantities again with the act/commod-matching used above:
VCropResidues_Contents_MR.l(Regions_MR,Activities_MR,"Average residues (t)","DM (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(Commodities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
                 VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_Contents_MR(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *CropResidues_OtherChar_MR(Regions_MR,Activities_MR,"Average residues (t)","Residue share t DM / t DM MainOutput1",ProductionSystems,ProductionConditions,"%Scenario%"));

*and the wet matter residue quantities
VCropResidues_Quantity_MR.l(Regions_MR,Activities_MR,"Average residues (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","DM (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCropResidues_Contents_MR.l(Regions_MR,Activities_MR,"Average residues (t)","DM (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
                 /CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","DM (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%");

*1.3) Derive other nutrient such as N and P2O5 contents of residues:
VCropResidues_Contents_MR.l(Regions_MR,Activities_MR,"Average residues (t)","N (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCropResidues_Quantity_MR.l(Regions_MR,Activities_MR,"Average residues (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","N (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%");
VCropResidues_Contents_MR.l(Regions_MR,Activities_MR,"Average residues (t)","P2O5 (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCropResidues_Quantity_MR.l(Regions_MR,Activities_MR,"Average residues (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","P2O5 (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%");


*1.4) Derive N available for fertilization of areas

*this is the reminder of N in crop residues, after subtracting losses:

*N losses corresponding to N2O emissions:
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man N loss (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
*condition needed to not loose values assigned in the previous module doing the Benke et al. values
                 $(NOT CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man N loss (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man N2O (tN2O)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 *28/44;
*for "Open burning", all N is lost:
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man N loss (tN)","Open burning",ProductionSystems,ProductionConditions,"%Scenario%")
         = CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","N (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%");


*derive N that is available to be put on the fields:
*condition needed to avoid that (wrong non zero) values are assigned although no biomass is in the respective system and thus no losses are reported
*no, this is no problem, it just assigns the N value for areas per ton residue - if there is no biomass in this system, it is never used.
*but we still use the condition to reduce unnecessary data
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
*condition needed to not loose values assigned in the previous module doing the Benke et al. values
                 $(CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                         AND (NOT CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")))
         = CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","N (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
                 - CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man N loss (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%");
*for "feed", no N is lost, but nothing remains for fertilization
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res N for areas (tN)","Feed",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
*set negative values equal to zero:
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

execute_unload "Test2"
CropResidues_Management_MR
CropResidues_Contents_MR
;


$ontext;
*now do the same for the organic fertilizers from main biomass, that is also managed as crop residues (compost, cut and carry, etc.)
*division by yield to get from N per ha to N per ton biomass
THS DOES NOT WORK WITH THE DIFFERENCE _ thus use the Benke factors and do this calculation in the Benke module
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N in outputs - for fert. before management (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         AND ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N in outputs - for fert. before management (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 - CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man N loss (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%");
*for "feed", no N is lost, but nothing remains for fertilization
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. for areas (tN)","Feed",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
*set negative values equal to zero:
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
$offtext;


execute_unload "Test4"
VCropResidues_Management_MR
CropResidues_Management_MR
;

*1.5) Crop res management characteristics from total residues
*covers losses, emissions, etc.
VCropResidues_Management_MR.l(Regions_MR,Activities_MR,"Average Residues (t)",CropResManagement_NotSystemShares_NoMainOutput,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCropResidues_Quantity_MR.l(Regions_MR,Activities_MR,"Average residues (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                         *CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)",CropResManagement_NotSystemShares_NoMainOutput,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%");

VCropResidues_Management_MR.l(Regions_MR,Activities_MR,"Average Residues (t)",CropResManagement_NotSystemShares_OnlyMainOutput,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_Outputs_MR.l(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                         *CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)",CropResManagement_NotSystemShares_OnlyMainOutput,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%");

*assign crop res man system shares to a specific parameter for permanet grassland, as otherwise huge quantities of crop res from them would be taken from the field - but this here should apply to the biomass yields on perm. grassland only, according to the share assigned for org. fert. use:
PermGrass_CropResidues_Management_MR(Regions_MR,"Permanent meadows and pastures","Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
         = CropResidues_Management_MR(Regions_MR,"Temporary meadows and pastures","Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%");

VCropResidues_Management_MR.l(Regions_MR,"Permanent meadows and pastures","Average Residues (t)",CropResManagement_NotSystemShares_OnlyMainOutput,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_Outputs_MR.l(Regions_MR,"Permanent meadows and pastures","MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util organic fert (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *PermGrass_CropResidues_Management_MR(Regions_MR,"Permanent meadows and pastures","Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                         *CropResidues_Management_MR(Regions_MR,"Permanent meadows and pastures","Average Residues (t)",CropResManagement_NotSystemShares_OnlyMainOutput,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%");
*and change the crop res for permanent grassland left on the field by the amount used as org fert and exported from the field:
VCropResidues_Management_MR.l(Regions_MR,"Permanent meadows and pastures","Average Residues (t)",CropResManagement_NotSystemShares_NoMainOutput,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCropResidues_Management_MR.l(Regions_MR,"Permanent meadows and pastures","Average Residues (t)",CropResManagement_NotSystemShares_NoMainOutput,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1-Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util organic fert (share)",ProductionSystems,ProductionConditions,"%Scenario%"));

*and for forest residues (bioenergy):
VActForest_OtherChar_MR.l(Regions_MR,"Forest","Forest res bioe N for areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VEnergyProduction_MR.l(Regions_MR,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)","%Scenario%")
                 *ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)",ProductionSystems,ProductionConditions,"%Scenario%");


execute_unload "Test5"
VCropResidues_Management_MR
CropResidues_Management_MR
VActCropsGrass_Outputs_MR
PermGrass_CropResidues_Management_MR
;

*to avoid too many data, set to zero where no quantity shares are available:
CropResidues_Management_MR(Regions_MR,Activities_MR,OutputsCropsGrass,CropResManagement_NotSystemShares,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
         = 0;




$exit;

*is this available for: "Main output N as fert. for areas (tN)"
VCropResidues_Management_MR.l(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")


needed fro set aside:
         = (ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput1 (tN)"                   ,ProductionSystems,ProductionConditions,"%Scenario%")

and also: in SET CropResManagement_NotSystemShares
"Crop res man CH4 (tCH4)"
"Crop res man N2O (tN2O)"
"Crop res man N loss (tN)"
"Crop res man P loss (tP2O5)"




ADD somewhere here - or do it fastly by taking a share only and adding it on FertApplicsation

NO: take per ha:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N outputs - crops (tN)",ProductionSystems,ProductionConditions,Scenarios)
times areas for the totals!!
and add data for the setaside crops to have it
and or P: the same

then treat as crop res BEFORE management - thus derive losses, etc. - and then N for areas - may also just add to the crop residue
THEN: do  use N in output only, as crop res already present, thus use:
define new: "N outputs WITHOUT residues - crops (tN)"
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N outputs WITHOUT residues - crops (tN)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput1 (tN)"                   ,ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios)
          + ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput2 (tN)"                   ,ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput2 (t)",ProductionSystems,ProductionConditions,Scenarios)
          + ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput3 (tN)"                   ,ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput3 (t)",ProductionSystems,ProductionConditions,Scenarios);

VCropResidues_Management_MR.l(Regions_MR,Crops_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystemCropland,ProductionSystems,ProductionConditions,"%Scenario%")





