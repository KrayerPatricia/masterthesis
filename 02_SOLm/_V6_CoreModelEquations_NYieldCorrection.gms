*KD
PUTCLOSE con,"_V6_CoreModelEquations_NYieldCorrection";

*GENERAL DESCRIPTION
*This file contains all the code to correct the yields according to N supply deficits - cf. Barbieri et al. 2021..... etc.etc.

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Total N Input
- 2) N_max Assignment
- 3) Y-Correction according to N-Limitaiton
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Total N Input

*Total N input (scenario specific)
ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Total N input",ProductionSystems,ProductionConditions,"%Scenario%")
        = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N inputs from seeds (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
        + ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N fixation (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
        + ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N deposition (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
        + ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
        + ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from mineral fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
        + ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from manure as fert (tN)",ProductionSystems,ProductionConditions,"%Scenario%");

*total N in output: main output PLUS crop residues:

*derive N in outputs + residues per ha: this is done by summing the values for N per ton main output *(main yield) plus N per ton other outputs *(other yields) plus N in residues per ton main output *(main yield)
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N in biomass (output + residues) (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
           +ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput2 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput2 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
           +ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput3 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput3 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
           +ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in residues - per ton MainOutput1 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%");


*2) N_max Assignment
$if %UseReference2050% == "YES" $goto UseNmaxReference2050
*Assignment of N_max (Total N Inputs from BaselineDerived)
ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max - tot input",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Total N input","AllProdSyst",ProductionConditions,"BaselineDerived");
ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max - in output",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N in biomass (output + residues) (tN)","AllProdSyst",ProductionConditions,"BaselineDerived");
$goto DoNotUseNmaxReference2050
$label UseNmaxReference2050
*Assignment of N_max (Total N Inputs from FOFA 2050)
ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max - tot input",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Total N input","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max - in output",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N in biomass (output + residues) (tN)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
$label DoNotUseNmaxReference2050


*3) Y-Correction according to N-Limitaiton
*available vs. required N (Total N Inputs/N max)

$if %YieldCorrectionNmax% == "OutputBased" $goto UseOutputBasedValues
***Core Equation: Y according to N availability, N_max derived from total N input
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t) - N-corrected",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max - tot input",ProductionSystems,ProductionConditions,"%Scenario%")
        = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Total N input",ProductionSystems,ProductionConditions,"%Scenario%")
                         /ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max - tot input",ProductionSystems,ProductionConditions,"%Scenario%");
$goto EndOfYieldCorrection

$label UseOutputBasedValues
***Core Equation: Y according to N availability, N_max derived from total N in output + residues
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t) - N-corrected",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max - in output",ProductionSystems,ProductionConditions,"%Scenario%")
        = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Total N input",ProductionSystems,ProductionConditions,"%Scenario%")
                         /ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max - in output",ProductionSystems,ProductionConditions,"%Scenario%");
$label EndOfYieldCorrection

*if total N input is LARGER than N_max, do not change yields:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t) - N-corrected",ProductionSystems,ProductionConditions,"%Scenario%")
        $(ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t) - N-corrected",ProductionSystems,ProductionConditions,"%Scenario%")
            > ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
        = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%");





$ontext;
***Core Equation 2: Non-Linear
* c=0, f=1 --> linear

ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t) - N-corrected",ProductionSystems,ProductionConditions,"%Scenario%")
        $   (ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max",ProductionSystems,ProductionConditions,"%Scenario%")
        and ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
        and ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Total N input",ProductionSystems,ProductionConditions,"%Scenario%"))
        =   (0
        -   sqrt(ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Total N input",ProductionSystems,ProductionConditions,"%Scenario%")
                *   ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Total N input",ProductionSystems,ProductionConditions,"%Scenario%")
                +   0*0)
        /   (0
        -   sqrt(ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max",ProductionSystems,ProductionConditions,"%Scenario%")
            *   ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max",ProductionSystems,ProductionConditions,"%Scenario%")
            +   0*0))
        *   (ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
            -   1
            *   ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max",ProductionSystems,ProductionConditions,"%Scenario%"))
        +   (ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Total N input",ProductionSystems,ProductionConditions,"%Scenario%")
            *   1))

*Parameters used for Equation
*ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
*ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"Total N input",ProductionSystems,ProductionConditions,"%Scenario%")
*ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N_max",ProductionSystems,ProductionConditions,"%Scenario%")
;

*even if Total N input< N_max --> division by zero --> doesnt work or Y-corrected=Ymax

ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t) - N-corrected",ProductionSystems,ProductionConditions,"%Scenario%")
        $(ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t) - N-corrected",ProductionSystems,ProductionConditions,"%Scenario%")
            > ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"))
        = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%");
$offtext;



