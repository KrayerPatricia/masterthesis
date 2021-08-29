PUTCLOSE con,"_V6_DataDerived_CropResidueManagement_Benke";

*GENERAL DESCRIPTION
*This file contains alternative code to derive N available for fertilization from crop residue management and derives alternative emission/loss factors
*this is based on the values reported in Benke et al. 2017
*Benke, A. P., Rieps, A.-M., Wollmann, I., Petrova, I., Zikeli, S., & Möller, K. (2017). Fertilizer value and nitrogen transfer efficiencies with clover-grass ley biomass based fertilizers. Nutrient Cycling in Agroecosystems, 107(3), 395-411. https://doi.org/10.1007/s10705-017-9844-z

*This code calculates differently from the default code in _V6_DataDerived_CropResidueManagement.gms
*there, N available for areas is derived from N in crop residues before management and substraction of losses
*here, the factors given directly result in N available for areas and the losses are then derived as the difference to the N in the crop residue biomass before management.

*Benke also provides factors for how much N is lost in application of crop residues on the field.
*the SOLm default code uses the IPCC factors N direct, N indirect leach and N indirect volat factors, and these are then derived below as well on the basis of the factors from Benke, to have them available for further calculations.

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Crop residue management N losses according to Benke
- 2) Crop residue application N losses according to Benke
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Crop residue management N losses according to Benke

*This parameter declares the N-transfer rates (1-lossRate) through residue management (from field to field)
*Source: Benke et al. (2017)
*It thus indicates which share of N in crop residue biomass before management is available to be put on the fields after management.
Par_NAVail_Benke("Biogas") = 0.92;
Par_NAVail_Benke("Composting") = 0.5;
Par_NAVail_Benke("Silage") = 0.93;
Par_NAVail_Benke("Cut and carry") = 1;

*thus, we derive the N available for areas per ton residue:
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res N for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $Par_NAvail_Benke(CropResManSystem)
         = CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","N (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
*                 *CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                         *Par_NAvail_Benke(CropResManSystem);


*now we derive the losses from crop res management = N available before management - N available for areas
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man N loss (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $Par_NAvail_Benke(CropResManSystem)
         = CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","N (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%")
*                 *CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                         *(1 - Par_NAvail_Benke(CropResManSystem));

*and in the default code later, the N2O emissions from crop residue management are also needed - we thus derive this from the N losses from management
*assuming that all these losses reported by Benke are via N2O emissions

*XXXXXXXXXXXXX check whether this assumption is warranted!!

CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man N2O (tN2O)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $Par_NAvail_Benke(CropResManSystem)
         = CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Crop res man N loss (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 *44/28;


*now do the same for the organic fertilizers from main biomass, that is also managed as crop residues (compost, cut and carry, etc.)
*for some crops, the main output is used as organic fertiliser - this is then assumed to be managed as crop residues, thus add the respective N and P quantities to the crop residue quantities, such as to process them further alike in the code:
*nutrient quantities:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N outputs WITHOUT residues - crops (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = (ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput1 (tN)"                   ,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
          + ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput2 (tN)"                   ,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput2 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
          + ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput3 (tN)"                   ,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput3 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"P outputs WITHOUT residues - crops (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = (ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P in MainOutput1 (tP2O5)"                   ,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
          + ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P in MainOutput2 (tP2O5)"                   ,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput2 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
          + ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"P in MainOutput3 (tP2O5)"                   ,ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput3 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N in outputs - for fert. before management (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,OutputsCropsGrass)$MatchCommAct_CommodEquivalentAct_Crops(SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,Activities_MR,OutputsCropsGrass),
                 ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N outputs WITHOUT residues - crops (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Util organic fert (share)",ProductionSystems,ProductionConditions,"%Scenario%"));
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"P in outputs - for fert. before management (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,OutputsCropsGrass)$MatchCommAct_CommodEquivalentAct_Crops(SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,Activities_MR,OutputsCropsGrass),
                 ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"P outputs WITHOUT residues - crops (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Commod_OtherChar_MR(Regions_MR,SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops,"Util organic fert (share)",ProductionSystems,ProductionConditions,"%Scenario%"));

*division by yield to get from N per ha to N per ton biomass
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N in outputs - for fert. before management (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Par_NAvail_Benke(CropResManSystem);
*for "feed", no N is lost, but nothing remains for fertilization
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. for areas (tN)","Feed",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
*set negative values equal to zero:
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. for areas (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*now we derive the losses from crop res management = N available before management - N available for areas
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. loss (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(Par_NAvail_Benke(CropResManSystem)
                         AND ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N in outputs - for fert. before management (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *(1 - Par_NAvail_Benke(CropResManSystem));
CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. N2O (tN2O)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $Par_NAvail_Benke(CropResManSystem)
         = CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Main output N as fert. loss (tN)",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 *44/28;


*kray      XXXXXXXXXXXXXXXXXXXXXXXX
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXx
*CHECK: is all around what is needed for later calculations when replacing the default code by this one?
*In Scenario Speci: switch on Benke if needed (and switch off when not) : and define new cro res man syst shares.

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Crop residue application N losses according to Benke


*now we use the data from Benke et al. 2017 to also derive the N loss factors used in the default code later on: N direct, N indirect leach and N indirect volatization
*This Parameter defines the N-loss rate after application
Par_NlossApplication_Benke_V("Biogas") = 0.24;
Par_NlossApplication_Benke_V("Composting") = 0.7;
Par_NlossApplication_Benke_V("Silage") = 0.4;
Par_NlossApplication_Benke_V("Cut and carry") = 0.4;
*what to do with non-defined values?

*we now have N_Loss(Benke) and need to assign this to direct, leach and volat losses
*N_loss(Benke) =! (N_direct + N_ind_leach + N_ind_vol)
*we just assume similar shares between these three parts as in the reference scenario, thus:

*N_direct(Scenario) = 0.97*N_Loss(Benke) * N_direct(2050)/(N_direct + N_ind_leach + N_ind_vol )
*N_ind_leach(Scenario) = 0.97*N_Loss(Benke) * N_ind_leach(2050)/(N_direct + N_ind_leach + N_ind_vol )
*N_ind_vol(Scenario) = 0.97*N_Loss(Benke) * N_ind_vol(2050)/(N_direct + N_ind_leach + N_ind_vol )

*0.97 is set because it is assumed that N2 emissions make 3% of total losses..  - highly unclear and uncertain - to be improved.

*XXXXXXXXXXXXX check whether the 3% N2 are ok!!


*this then applies to the part covered by these management systems where we have new data on - the other systems are used with the default values - hence the second part in the code below summing over the systems WITHOUT Benke data

*thus, calculate this sum needed in the denominator:
CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","total N lost: dir+leach+volat (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                 + CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100;


*Now derive the factors needed by the formulae presented above:

*direct emissions
CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         $CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","total N lost: dir+leach+volat (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Sum(CropResManSystem,
                 Par_NlossApplication_Benke_V(CropResManSystem)
                         *CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","total N lost: dir+leach+volat (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         + Sum(CropResManSystem$(NOT Par_NlossApplication_Benke_V(CropResManSystem)),
                         CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
                                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","N2O-N per kg fertilizer N applied (tN/tN)",ProductionSystems,ProductionConditions,"%Scenario%");

*indirect: leaching
CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                         $CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","total N lost: dir+leach+volat (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Sum(CropResManSystem,
                 Par_NlossApplication_Benke_V(CropResManSystem)
                         *CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","total N lost: dir+leach+volat (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         + Sum(CropResManSystem$(NOT Par_NlossApplication_Benke_V(CropResManSystem)),
                         CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
                                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Leached N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%");

*indirect: volatilisation
CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                         $CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","total N lost: dir+leach+volat (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Sum(CropResManSystem,
                 Par_NlossApplication_Benke_V(CropResManSystem)
                         *CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","total N lost: dir+leach+volat (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         + Sum(CropResManSystem$(NOT Par_NlossApplication_Benke_V(CropResManSystem)),
                         CropResidues_Management_MR(Regions_MR,Activities_MR,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
                                 *CropResAndBiomassApplication_MR(Regions_MR,Activities_MR,"All Residues","Volatized N as percentage of fertilizer N applied (%)",ProductionSystems,ProductionConditions,"%Scenario%");


