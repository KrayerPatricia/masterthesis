PUTCLOSE con,"_V6_ScenarioSpecifications";

*GENERAL DESCRIPTION
*This file contains the specific assumptions for the various scenarios

*DETAILED TABLE OF CONTENTS
$ontext;
-   0) Baseline
-   1) BaselineDerived

-   2) zhaw_NoFeedImports
-   2a) zhaw_NoFeedImports_a

-   3) ELAniVarProd_RCardinaals_1
-   4) Bioenergy_RCardinaals_1

-   5) FOFA_BAU_2012
-   6) FOFA_BAU_2050
-   7) FOFA_BAU_2050_Test
-   7a)FOFA_BAU_2050_Test_10PercLessArea
-   8) FOFA_BAU_2050_25Organic
*!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!!!*!!!!!!!!!!!!!!!*!!!!!!!!!!!!!!!!!!*!!!!!!*!!!!!!!!!!!!!
*!!!!!!*to run the following for UNISECO scenarios,                                      !!!!
*!!!!!!*SteeringFile_1 needs to be run WITH reading specific UNISECO data                !!!!
*!!!!!!*this is done by setting UseUNISECO_YesNo == "YES"                                !!!!
*!!!!!!*and then running Steering file 1 first                                           !!!!
*!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!!!*!!!!!!!!!!!!!!!*!!!!!!!!!!!!!!!!!!*!!!!!!*!!!!!!!!!!!!!
-   9) LfP_2050
-  10) AE_exports_2050
-  11) LfS_2050
-  12) AE_food_2050
-  12a) UNISECO_AF_shM_compM_yL_cM_5


-  13) BioeSR15_P4_2050
-  15) BioeSR15_P4_2050_ReferenceNoBioe
-  16) BioeSR15_P4_2100
-  17) BioeSR15_P4_2050
-  18) BioeSR15_P4_2050_Bio
-  19) BioeSR15_P4_2050_Bio_AreaIncrease
-  20) BioeSR15_P4_2050_Bio_AreaIncr_NoFCF
-  21) BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW

-  22) Baseline_100Organic
-  23) Baseline_50Organic

-  24) Baseline_NoFCF
-  25) FOFA_BAU_2050_NoFCF
-  26) FOFA_BAU_2050_vegan

$offtext;

*******!!!!!!!!!!!!!!!!!!!!!!!******************
*ATTENTION: if you define parameters for scenarios then check, whether the $NOT-condition in _V6_AssignInitialValuesToScenarios is switched on for the relevant parameter - otherwise this is then replaced with the baseline value !!!!!!
*******!!!!!!!!!!!!!!!!!!!!!!!******************

*MODEL CODE:

$if %Scenario% == "Baseline" $goto AssumptionsBaseline
$if %Scenario% == "BaselineDerived" $goto AssumptionsBaselineDerived

$if %Scenario% == "zhaw_NoFeedImports" $goto Assumptionszhaw_NoFeedImports
$if %Scenario% == "zhaw_NoFeedImports_a" $goto Assumptionszhaw_NoFeedImports_a

$if %Scenario% == "ELAniVarProd_RCardinaals_1" $goto AssumptionsELAniVarProd_RCardinaals_1
$if %Scenario% == "Bioenergy_RCardinaals_1" $goto AssumptionsBioenergy_RCardinaals_1

$if %Scenario% == "FOFA_BAU_2050" $goto AssumptionsFOFA_BAU_2050
$if %Scenario% == "FOFA_BAU_2012" $goto AssumptionsFOFA_BAU_2012
$if %Scenario% == "FOFA_BAU_2050_Test" $goto AssumptionsFOFA_BAU_2050_Test
$if %Scenario% == "FOFA_BAU_2050_Test_10PercLessArea" $goto AssumptionsFOFA_BAU_2050_Test_10PercLessArea
$if %Scenario% == "FOFA_BAU_2050_25Organic" $goto AssumptionsFOFA_BAU_2050_25Organic

$if %Scenario% == "LfP_2050" $goto AssumptionsLfP_2050
$if %Scenario% == "AE_exports_2050" $goto AssumptionsAE_exports_2050
$if %Scenario% == "LfS_2050" $goto AssumptionsLfS_2050
$if %Scenario% == "AE_food_2050" $goto AssumptionsAE_food_2050







*UNISECO Agroforestry Scenarios: 108 scenarios, built by the various combinations of the following parameter values:
$ontext;
*the UNISECO AF scenarios are differentiated by 5 parameters resulting in 108 combinations, i.e. 108 options in the option space:
         1) %WW% share AF                     -       medium/low/high coded as M/L/H
         2) %XX% compnent shares crops/trees  -       medium/low/high coded as M/L/H
         3) %YY% AF yields                    -       low/high coded as L/H
         4) %CC% C sequestration              -       medium/low/high coded as M/L/H
         5) %RR% organic share outside the EU -       5% / 25% coded as 5/25
$offtext;

*1-9
$if %Scenario% == "UNISECO_AF_shM_compM_yL_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yL_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yL_cM_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yL_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yL_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yL_cM_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yL_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yL_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yL_cM_5" $goto AssumptionsUNISECO_AF

*10-18
$if %Scenario% == "UNISECO_AF_shM_compM_yH_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yH_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yH_cM_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yH_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yH_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yH_cM_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yH_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yH_cM_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yH_cM_5" $goto AssumptionsUNISECO_AF



*19-27
$if %Scenario% == "UNISECO_AF_shM_compM_yL_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yL_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yL_cL_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yL_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yL_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yL_cL_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yL_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yL_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yL_cL_5" $goto AssumptionsUNISECO_AF

*28-36
$if %Scenario% == "UNISECO_AF_shM_compM_yH_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yH_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yH_cL_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yH_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yH_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yH_cL_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yH_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yH_cL_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yH_cL_5" $goto AssumptionsUNISECO_AF



*37-45
$if %Scenario% == "UNISECO_AF_shM_compM_yL_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yL_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yL_cH_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yL_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yL_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yL_cH_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yL_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yL_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yL_cH_5" $goto AssumptionsUNISECO_AF

*46-54
$if %Scenario% == "UNISECO_AF_shM_compM_yH_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yH_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yH_cH_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yH_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yH_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yH_cH_5" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yH_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yH_cH_5" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yH_cH_5" $goto AssumptionsUNISECO_AF





*55-63
$if %Scenario% == "UNISECO_AF_shM_compM_yL_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yL_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yL_cM_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yL_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yL_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yL_cM_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yL_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yL_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yL_cM_25" $goto AssumptionsUNISECO_AF

*64-72
$if %Scenario% == "UNISECO_AF_shM_compM_yH_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yH_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yH_cM_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yH_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yH_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yH_cM_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yH_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yH_cM_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yH_cM_25" $goto AssumptionsUNISECO_AF



*73-81
$if %Scenario% == "UNISECO_AF_shM_compM_yL_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yL_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yL_cL_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yL_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yL_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yL_cL_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yL_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yL_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yL_cL_25" $goto AssumptionsUNISECO_AF

*82-90
$if %Scenario% == "UNISECO_AF_shM_compM_yH_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yH_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yH_cL_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yH_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yH_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yH_cL_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yH_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yH_cL_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yH_cL_25" $goto AssumptionsUNISECO_AF



*91-99
$if %Scenario% == "UNISECO_AF_shM_compM_yL_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yL_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yL_cH_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yL_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yL_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yL_cH_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yL_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yL_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yL_cH_25" $goto AssumptionsUNISECO_AF

*100-108
$if %Scenario% == "UNISECO_AF_shM_compM_yH_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compM_yH_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compM_yH_cH_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compL_yH_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compL_yH_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compL_yH_cH_25" $goto AssumptionsUNISECO_AF

$if %Scenario% == "UNISECO_AF_shM_compH_yH_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shL_compH_yH_cH_25" $goto AssumptionsUNISECO_AF
$if %Scenario% == "UNISECO_AF_shH_compH_yH_cH_25" $goto AssumptionsUNISECO_AF


*END OF UNISECO Agroforestry Scenarios


$if %Scenario% == "BioeSR15_P4_2050" $goto AssumptionsBioeSR15_P4_2050
$if %Scenario% == "BioeSR15_P4_2050_RefNoBioe" $goto AssumptionsBioeSR15_P4_2050_ReferenceNoBioe
$if %Scenario% == "BioeSR15_P4_2100" $goto AssumptionsBioeSR15_P4_2100
$if %Scenario% == "BioeSR15_P3_2050" $goto AssumptionsBioeSR15_P3_2050
$if %Scenario% == "BioeSR15_P4_2050_Bio" $goto AssumptionsBioeSR15_P4_2050_Bio
$if %Scenario% == "BioeSR15_P4_2050_Bio_AreaIncrease" $goto AssumptionsBioeSR15_P4_2050_Bio_AreaIncrease
$if %Scenario% == "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF" $goto AssumptionsBioeSR15_P4_2050_Bio_AreaIncr_NoFCF
$if %Scenario% == "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW" $goto AssumptionsBioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW

$if %Scenario% == "Baseline_100Organic" $goto AssumptionsBaseline_100Organic
$if %Scenario% == "Baseline_50Organic" $goto AssumptionsBaseline_50Organic

$if %Scenario% == "Baseline_NoFCF" $goto AssumptionsBaseline_NoFCF
$if %Scenario% == "FOFA_BAU_2050_NoFCF" $goto AssumptionsFOFA_BAU_2050_NoFCF

$if %Scenario% == "FOFA_BAU_2050_vegan" $goto AssumptionsFOFA_BAU_2050_vegan


$if %Scenario% == "FOFA_2050_VeganBAU" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBAU_NoFreeAreaUse" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_a" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganSchmidt" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganOptimized" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganOptimized_conv" $goto AssumptionsFOFA_BAU_2050_vegan


*Further vegan scenarios (detailed analysis)

$if %Scenario% == "FOFA_2050_VeganBarbieri_0_0" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_0" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_0" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_0" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_0" $goto AssumptionsFOFA_BAU_2050_vegan

$if %Scenario% == "FOFA_2050_VeganBarbieri_0_20" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_20" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_20" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_20" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_20" $goto AssumptionsFOFA_BAU_2050_vegan

$if %Scenario% == "FOFA_2050_VeganBarbieri_0_40" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_40" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_40" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_40" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_40" $goto AssumptionsFOFA_BAU_2050_vegan

$if %Scenario% == "FOFA_2050_VeganBarbieri_0_60" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_60" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_60" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_60" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_60" $goto AssumptionsFOFA_BAU_2050_vegan


$if %Scenario% == "FOFA_2050_VeganBarbieri_0_80" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_80" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_80" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_80" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_80" $goto AssumptionsFOFA_BAU_2050_vegan

$if %Scenario% == "FOFA_2050_VeganBarbieri_0_100" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_100" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_100" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_100" $goto AssumptionsFOFA_BAU_2050_vegan
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_100" $goto AssumptionsFOFA_BAU_2050_vegan






****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*0) Baseline
$label AssumptionsBaseline
*NO ASSUMPTIONS

$setglobal UseProdSyst_ConvOrg "NO"

$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) BaselineDerived
$label AssumptionsBaselineDerived
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "NO"
*$setglobal UseProdSyst_ConvOrg "YES"

*TO SEE WHETHER IT WORKS:
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline");

*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Convent",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline");

*assign areas
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline");

*VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline");

VPopulationNumbers_MR.l(Regions,PopulationGroups,"%Scenario%")
         = VPopulationNumbers_MR.l(Regions,PopulationGroups,"Baseline")


*XXX optimization code test -> move later
*$include xx_includeNutrients

$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) zhaw_NoFeedImports
$label Assumptionszhaw_NoFeedImports
PUTCLOSE con,"Current scenario: %Scenario%";

*This scenario looks at the impacts of zero feed imports to Switzerland


*!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!!!*!!!!!!!!!!!!!!!*!!!!!!!!!!!!!!!!!!*!!!!!!*!!!!!!!!!!!!!
*!!!!!!*to run this, some baseline data needs to be adjusted.                            !!!!
*!!!!!!*thus, rerun SteeringFile_1 AFTER adjusting where the following label is given:   !!!!
*!!!!!!*                                                                                 !!!!
*!!!!!!*  *search label: switch on for Scenario "zhaw_NoFeedImports"                     !!!!
*!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!!!*!!!!!!!!!!!!!!!*!!!!!!!!!!!!!!!!!!*!!!!!!*!!!!!!!!!!!!!


$setglobal UseProdSyst_ConvOrg "NO"
*$setglobal UseProdSyst_ConvOrg "YES"

*assign areas
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline");



*assuming same feeding rations, and reducing the feed for ruminants by 16% due to setting their import part to zero results in reducing grassland use by 16%, thus do this:
VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Permanent meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Permanent meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.84;
VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.84;


*$ontext;
*grow more cereals and oilcrops/pulses on forage-maize areas:
*and more oil crops on temp grass areas
*leave permanent grass unutilized
VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Wheat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Wheat",ProductionSystems,ProductionConditions,"Baseline")
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100;
VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Soybeans",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Soybeans",ProductionSystems,ProductionConditions,"Baseline")
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16;
VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*8/10;
*$offtext;


*domestic production of wheat, maize and barley and products shall not be influenced by change in imports of wheat etc. and products feed:
VCommod_Production_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
*$ontext;
*but add the additional production from above
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR("Switzerland","Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
*$offtext;
;
VCommod_Production_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"Baseline")
*$ontext;
*but add the additional production from above
                 + (VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                         +VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                                 *ActCropsGrass_Outputs_MR("Switzerland","Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                         *ExtractionRate_CommodityTree("Switzerland","Soyabean cake")
*$offtext;
;
VCommod_Production_MR.l("Switzerland","Maize and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l("Switzerland","Maize and products",ProductionSystems,ProductionConditions,"Baseline");
VCommod_Production_MR.l("Switzerland","Barley and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l("Switzerland","Barley and products",ProductionSystems,ProductionConditions,"Baseline");


*set feed imports to zero:
*supply/demand ratio is needed to account for the mismatch in DAQ-Feed and requirements, but the import data being correct without mismatch

VCommod_Feed_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
*                         *Commod_OtherChar_MR("Switzerland",Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;

VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
*                         *Commod_OtherChar_MR("Switzerland",Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;

VImportQuantity_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
*                         *Commod_OtherChar_MR("Switzerland",Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;

VImportQuantity_Feed_MR.l("Switzerland","World",Commodities_MR,"AllProdSyst","AllProdCond","%Scenario%") = 0;

*if the resulting values that should be positive are negative, set them equal zero:
VCommod_Feed_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VCommod_Feed_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
VImportQuantity_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VImportQuantity_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*rice is all imported, thus should be zero - but due to mismatch with FAO default trade data, this may not be the case, thus set equal zero by hand:
VCommod_Feed_MR.l("Switzerland","Rice (Paddy equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
VCommod_Quantity_MR.l("Switzerland","Rice (Paddy equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;

*adjust the corresponding areas in the import-source countries by the area values not needed anymore: to get a cear signal, just take them out of production - but discuss this in the description of results in the report, as likely other uses will be done on these areas
VActCropsGrass_QuantityActUnits_MR.l("France","Wheat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("France","Wheat",ProductionSystems,ProductionConditions,"Baseline") - 18846.5/0.96;
VActCropsGrass_QuantityActUnits_MR.l("France","Maize",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("France","Maize",ProductionSystems,ProductionConditions,"Baseline") - 10140.58/0.88;
VActCropsGrass_QuantityActUnits_MR.l("France","Oats",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("France","Oats",ProductionSystems,ProductionConditions,"Baseline") - 2532.91/0.76;
VActCropsGrass_QuantityActUnits_MR.l("France","Barley",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("France","Barley",ProductionSystems,ProductionConditions,"Baseline") - 644.81/0.9;

VActCropsGrass_QuantityActUnits_MR.l("Germany","Wheat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Wheat",ProductionSystems,ProductionConditions,"Baseline") - 9921.59/0.96;
VActCropsGrass_QuantityActUnits_MR.l("Germany","Maize",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Maize",ProductionSystems,ProductionConditions,"Baseline") - 1968.27/0.88;
VActCropsGrass_QuantityActUnits_MR.l("Germany","Oats",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Oats",ProductionSystems,ProductionConditions,"Baseline") - 855.03/0.76;
VActCropsGrass_QuantityActUnits_MR.l("Germany","Barley",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Barley",ProductionSystems,ProductionConditions,"Baseline") - 1998.62/0.9;
VActCropsGrass_QuantityActUnits_MR.l("Germany","Rapeseed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Rapeseed",ProductionSystems,ProductionConditions,"Baseline") - 678.82/0.85;
VActCropsGrass_QuantityActUnits_MR.l("Germany","Sunflower seed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Sunflower seed",ProductionSystems,ProductionConditions,"Baseline") - 655.92/0.67;

VActCropsGrass_QuantityActUnits_MR.l("Brazil","Soybeans",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Brazil","Soybeans",ProductionSystems,ProductionConditions,"Baseline") - 61842.83/0.94;
VActCropsGrass_QuantityActUnits_MR.l("India","Rice, paddy",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("India","Rice, paddy",ProductionSystems,ProductionConditions,"Baseline") - 1507.59/0.09;
VActCropsGrass_QuantityActUnits_MR.l("Russian Federation","Soybeans",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Russian Federation","Soybeans",ProductionSystems,ProductionConditions,"Baseline") - 30203.37/0.62;
VActCropsGrass_QuantityActUnits_MR.l("Belgium","Rapeseed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Belgium","Rapeseed",ProductionSystems,ProductionConditions,"Baseline") - 1652.24/0.85;
VActCropsGrass_QuantityActUnits_MR.l("Kazakhstan","Rapeseed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Kazakhstan","Rapeseed",ProductionSystems,ProductionConditions,"Baseline") - 1056.47/0.85;
VActCropsGrass_QuantityActUnits_MR.l("Romania","Sunflower seed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Romania","Sunflower seed",ProductionSystems,ProductionConditions,"Baseline") - 735.21/0.67;
VActCropsGrass_QuantityActUnits_MR.l("Italy","Sunflower seed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Italy","Sunflower seed",ProductionSystems,ProductionConditions,"Baseline") - 272.84/0.67;






*$ontext;
*add the additional/reduced production of wheat, soy, forage maize and grasslands:
VCommod_Feed_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR("Switzerland","Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
*                         *Commod_OtherChar_MR("Switzerland","Wheat and products","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;
VCommod_Feed_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
                 + (VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                                  +VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                         *ActCropsGrass_Outputs_MR("Switzerland","Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                 *ExtractionRate_CommodityTree("Switzerland","Soyabean cake")
*                         *Commod_OtherChar_MR("Switzerland","Soyabean cake","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;
VCommod_Feed_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*4/5;
VCommod_Feed_MR.l("Switzerland",Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l("Switzerland",Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"Baseline")*0.84;
VCommod_Quantity_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR("Switzerland","Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
*                         *Commod_OtherChar_MR("Switzerland","Wheat and products","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;
VCommod_Quantity_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
                 + (VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                                  +VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                         *ActCropsGrass_Outputs_MR("Switzerland","Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                 *ExtractionRate_CommodityTree("Switzerland","Soyabean cake")
*                         *Commod_OtherChar_MR("Switzerland","Soyabean cake","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;
VCommod_Quantity_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*4/5;
VCommod_Quantity_MR.l("Switzerland",Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l("Switzerland",Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"Baseline")*0.84;
*$offtext;

*Then also adjust the feed utilization share:
Commod_OtherChar_MR("Switzerland",Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%");
*to not later overwrite newly assigned zero values:
Commod_OtherChar_MR("Switzerland",Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((Commod_OtherChar_MR("Switzerland",Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%") = 0)
                         AND (Commod_OtherChar_MR("Switzerland",Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"Baseline") > 0))
*eps was used in the earlier version when scenario definitons came BEFORE assigning initial values to scenarios
         =0;
*         = eps;




*adjust the share in Cereals DM according to the share of imported cereal feed: for pigs and chickens:
$ontext;
assumption the same share goes to pigs and chicken in the baseline and in the scenario.
the share of domestic production to chicken and pig in the scenario is the same as in the baseline
*for pigs and chickens: pigs, domestic feed share: 0.393, Chickens 0.165, this results then in shares of 81% of domestic feed for pig and chicken going to pigs, 19% going to chickens (cf. data from Patricia, gp_sto3_zusammenfassung_produkte_200519_kray, lines 17 and 20)
thus: from the share of feed going to pigs+chicken, 81% go to pigs in the scenario, 19% to chicken
$offtext;
*assigned to "All nonruminants" albeit only covering pigs and chickens for now:
FeedingRations_OtherChar_MR("Switzerland","Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"));

FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR("Switzerland","Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =(FeedingRations_OtherChar_MR("Switzerland","Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))*0.81
                         *FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                                 /FeedingRations_OtherChar_MR("Switzerland","Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline");
FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         =(FeedingRations_OtherChar_MR("Switzerland","Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))*0.19;


*more complex older code - is not correct:
$ontext;
AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         = (sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))*0.81
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")*0.19);

alias(PigTypeInherd_2,PigTypeInherd);

FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,Commodities_Feed_Cereals,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
         *FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,Commodities_Feed_Cereals,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")*0.393
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline");

FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes",Commodities_Feed_Cereals,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
         *FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes",Commodities_Feed_Cereals,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")*0.165
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline");

FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
         *FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")*0.393
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline");

FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
         *FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")*0.165
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline");
$offtext;



$ontext;

Assignment for calculations that use the aggregate feeding rations, not the detailed ones:

*adjust the share in Conc GE according to the share of imported conc feed: for pigs and chickens:
*$ontext;
baseline: share in GE conc x and y
share in domestic conc: a and b
new shares:

(x+y)*ax/(ax+by) and  (x+y)*by/(ax+by)
*$offtext;
*for pigs and chickens: pigs, domestic feed share: 0.393, Chickens 0.165
*assigned to "All nonruminants" albeit only covering pigs and chickens for now:
AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")
         = (sum(PigTypeInHerd,ActAnimalsHead_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline"))*0.393
                 + ActAnimalsHead_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")*0.165);

alias(PigTypeInherd_2,PigTypeInherd);

ActAnimalsHead_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd_2,ActAnimalsHead_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline"))
                 + ActAnimalsHead_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline"))
         *ActAnimalsHead_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")*0.393
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline");


ActAnimalsHead_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd_2,ActAnimalsHead_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline"))
                 + ActAnimalsHead_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline"))
         *ActAnimalsHead_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")*0.165
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline");
$offtext;


$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2a) zhaw_NoFeedImports_a
$label Assumptionszhaw_NoFeedImports_a
PUTCLOSE con,"Current scenario: %Scenario%";

*This scenario looks at the impacts of zero feed imports to Switzerland
*it does however not crop the newly freed forage maize and temp. grassland areas with soy and wheat but rather takes all feed areas that are not used anymore due to import reduciton out of production
*this can e.g. happen as reduced soy imports lead to too much domestic feed energy for balanced rations, thus requiring a reduction in domestic feed cereal, etc. - as this could anyway not been fed (as it has too much energy in relation to available protein)

*!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!!!*!!!!!!!!!!!!!!!*!!!!!!!!!!!!!!!!!!*!!!!!!*!!!!!!!!!!!!!
*!!!!!!*to run this, some baseline data needs to be adjusted.                            !!!!
*!!!!!!*thus, rerun SteeringFile_1 AFTER adjusting where the following label is given:   !!!!
*!!!!!!*                                                                                 !!!!
*!!!!!!*  *search label: switch on for Scenario "zhaw_NoFeedImports"                     !!!!
*!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!!!*!!!!!!!!!!!!!!!*!!!!!!!!!!!!!!!!!!*!!!!!!*!!!!!!!!!!!!!


$setglobal UseProdSyst_ConvOrg "NO"
*$setglobal UseProdSyst_ConvOrg "YES"

*assign areas
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline");



*assuming same feeding rations, and reducing the feed for ruminants by 16% due to setting their import part to zero results in reducing grassland use by 16%, thus do this:
VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Permanent meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Permanent meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.84;
VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.84;
*reduce forage maize areas by the amount that corresponds to 16% of the forage maize areas needed for cattle in the baseline:
*and also by the amount not neeed ynamore by pigs: these have 0.393% of domestic protein; thus reduce forage maize by 0.607 of the share that goes to pigs to account for this reduciton in protein availability:
VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VFeedingRations_Quantity_MR.l("Switzerland","All Animals","AllAndAverageTypes","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"BaselineDerived")
         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")
                 - VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")
                          *(sum(AnimalTypeInHerd,VFeedingRations_Quantity_MR.l("Switzerland","Cattle",AnimalTypeInHerd,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"BaselineDerived"))*0.16
                            +sum(AnimalTypeInHerd,VFeedingRations_Quantity_MR.l("Switzerland","Pigs",AnimalTypeInHerd,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"BaselineDerived"))*0.607)
                                 /VFeedingRations_Quantity_MR.l("Switzerland","All Animals","AllAndAverageTypes","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"BaselineDerived");
$ontext;
*grow more cereals and oilcrops/pulses on forage-maize areas:
*and more oil crops on temp grass areas
*leave permanent grass unutilized
VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Wheat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Wheat",ProductionSystems,ProductionConditions,"Baseline")
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100;
VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Soybeans",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Soybeans",ProductionSystems,ProductionConditions,"Baseline")
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16;
VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*8/10;
$offtext;


*domestic production of wheat, maize and barley and products shall not be influenced by change in imports of wheat etc. and products feed:
VCommod_Production_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
$ontext;
*but add the additional production from above
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR("Switzerland","Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
$offtext;
;
VCommod_Production_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"Baseline")
$ontext;
*but add the additional production from above
                 + (VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                         +VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                                 *ActCropsGrass_Outputs_MR("Switzerland","Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                         *ExtractionRate_CommodityTree("Switzerland","Soyabean cake")
$offtext;
;
VCommod_Production_MR.l("Switzerland","Maize and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l("Switzerland","Maize and products",ProductionSystems,ProductionConditions,"Baseline");
VCommod_Production_MR.l("Switzerland","Barley and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l("Switzerland","Barley and products",ProductionSystems,ProductionConditions,"Baseline");


*set feed imports to zero:
*supply/demand ratio is needed to account for the mismatch in DAQ-Feed and requirements, but the import data being correct without mismatch

VCommod_Feed_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
*                         *Commod_OtherChar_MR("Switzerland",Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;

VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
*                         *Commod_OtherChar_MR("Switzerland",Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;

VImportQuantity_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
*                         *Commod_OtherChar_MR("Switzerland",Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;

VImportQuantity_Feed_MR.l("Switzerland","World",Commodities_MR,"AllProdSyst","AllProdCond","%Scenario%") = 0;

*if the resulting values that should be positive are negative, set them equal zero:
VCommod_Feed_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VCommod_Feed_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
VImportQuantity_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VImportQuantity_MR.l("Switzerland","World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*rice is all imported, thus should be zero - but due to mismatch with FAO default trade data, this may not be the case, thus set equal zero by hand:
VCommod_Feed_MR.l("Switzerland","Rice (Paddy equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
VCommod_Quantity_MR.l("Switzerland","Rice (Paddy equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;

*adjust the corresponding areas in the import-source countries by the area values not needed anymore: to get a cear signal, just take them out of production - but discuss this in the description of results in the report, as likely other uses will be done on these areas
VActCropsGrass_QuantityActUnits_MR.l("France","Wheat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("France","Wheat",ProductionSystems,ProductionConditions,"Baseline") - 18846.5/0.96;
VActCropsGrass_QuantityActUnits_MR.l("France","Maize",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("France","Maize",ProductionSystems,ProductionConditions,"Baseline") - 10140.58/0.88;
VActCropsGrass_QuantityActUnits_MR.l("France","Oats",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("France","Oats",ProductionSystems,ProductionConditions,"Baseline") - 2532.91/0.76;
VActCropsGrass_QuantityActUnits_MR.l("France","Barley",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("France","Barley",ProductionSystems,ProductionConditions,"Baseline") - 644.81/0.9;

VActCropsGrass_QuantityActUnits_MR.l("Germany","Wheat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Wheat",ProductionSystems,ProductionConditions,"Baseline") - 9921.59/0.96;
VActCropsGrass_QuantityActUnits_MR.l("Germany","Maize",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Maize",ProductionSystems,ProductionConditions,"Baseline") - 1968.27/0.88;
VActCropsGrass_QuantityActUnits_MR.l("Germany","Oats",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Oats",ProductionSystems,ProductionConditions,"Baseline") - 855.03/0.76;
VActCropsGrass_QuantityActUnits_MR.l("Germany","Barley",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Barley",ProductionSystems,ProductionConditions,"Baseline") - 1998.62/0.9;
VActCropsGrass_QuantityActUnits_MR.l("Germany","Rapeseed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Rapeseed",ProductionSystems,ProductionConditions,"Baseline") - 678.82/0.85;
VActCropsGrass_QuantityActUnits_MR.l("Germany","Sunflower seed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Germany","Sunflower seed",ProductionSystems,ProductionConditions,"Baseline") - 655.92/0.67;

VActCropsGrass_QuantityActUnits_MR.l("Brazil","Soybeans",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Brazil","Soybeans",ProductionSystems,ProductionConditions,"Baseline") - 61842.83/0.94;
VActCropsGrass_QuantityActUnits_MR.l("India","Rice, paddy",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("India","Rice, paddy",ProductionSystems,ProductionConditions,"Baseline") - 1507.59/0.09;
VActCropsGrass_QuantityActUnits_MR.l("Russian Federation","Soybeans",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Russian Federation","Soybeans",ProductionSystems,ProductionConditions,"Baseline") - 30203.37/0.62;
VActCropsGrass_QuantityActUnits_MR.l("Belgium","Rapeseed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Belgium","Rapeseed",ProductionSystems,ProductionConditions,"Baseline") - 1652.24/0.85;
VActCropsGrass_QuantityActUnits_MR.l("Kazakhstan","Rapeseed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Kazakhstan","Rapeseed",ProductionSystems,ProductionConditions,"Baseline") - 1056.47/0.85;
VActCropsGrass_QuantityActUnits_MR.l("Romania","Sunflower seed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Romania","Sunflower seed",ProductionSystems,ProductionConditions,"Baseline") - 735.21/0.67;
VActCropsGrass_QuantityActUnits_MR.l("Italy","Sunflower seed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l("Italy","Sunflower seed",ProductionSystems,ProductionConditions,"Baseline") - 272.84/0.67;






$ontext;
*add the additional/reduced production of wheat, soy, forage maize and grasslands:
VCommod_Feed_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR("Switzerland","Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
*                         *Commod_OtherChar_MR("Switzerland","Wheat and products","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;
VCommod_Feed_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
                 + (VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                                  +VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                         *ActCropsGrass_Outputs_MR("Switzerland","Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                 *ExtractionRate_CommodityTree("Switzerland","Soyabean cake")
*                         *Commod_OtherChar_MR("Switzerland","Soyabean cake","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;
$offtext;
VCommod_Feed_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Feed_MR.l("Switzerland",Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l("Switzerland",Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"Baseline")*0.84;

$ontext;
VCommod_Quantity_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l("Switzerland","Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR("Switzerland","Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
*                         *Commod_OtherChar_MR("Switzerland","Wheat and products","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;
VCommod_Quantity_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l("Switzerland","Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
                 + (VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                                  +VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                         *ActCropsGrass_Outputs_MR("Switzerland","Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                 *ExtractionRate_CommodityTree("Switzerland","Soyabean cake")
*                         *Commod_OtherChar_MR("Switzerland","Soyabean cake","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline")
;
$offtext;

VCommod_Quantity_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l("Switzerland","Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline");


VCommod_Quantity_MR.l("Switzerland",Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l("Switzerland",Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"Baseline")*0.84;
*$offtext;

*Then also adjust the feed utilization share:
Commod_OtherChar_MR("Switzerland",Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 /VCommod_Quantity_MR.l("Switzerland",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%");
*to not later overwrite newly assigned zero values:
Commod_OtherChar_MR("Switzerland",Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $((Commod_OtherChar_MR("Switzerland",Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%") = 0)
                         AND (Commod_OtherChar_MR("Switzerland",Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"Baseline") > 0))
*eps was used in the earlier version when scenario definitons came BEFORE assigning initial values to scenarios
         =0;
*         = eps;


*adjust the share in Cereals DM according to the share of imported cereal feed: for pigs and chickens:
$ontext;
assumption the same share goes to pigs and chicken in the baseline and in the scenario.
the share of domestic production to chicken and pig in the scenario is the same as in the baseline
*for pigs and chickens: pigs, domestic feed share: 0.393, Chickens 0.165, this results then in shares of 81% of domestic feed for pig and chicken going to pigs, 19% going to chickens (cf. data from Patricia, gp_sto3_zusammenfassung_produkte_200519_kray, lines 17 and 20)
thus: from the share of feed going to pigs+chicken, 81% go to pigs in the scenario, 19% to chicken
$offtext;
*assigned to "All nonruminants" albeit only covering pigs and chickens for now:
FeedingRations_OtherChar_MR("Switzerland","Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"));

FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR("Switzerland","Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =(FeedingRations_OtherChar_MR("Switzerland","Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))*0.81
                         *FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                                 /FeedingRations_OtherChar_MR("Switzerland","Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline");
FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         =(FeedingRations_OtherChar_MR("Switzerland","Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))*0.19;


*more complex older code - is not correct:
$ontext;
AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         = (sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))*0.81
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")*0.19);

alias(PigTypeInherd_2,PigTypeInherd);

FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,Commodities_Feed_Cereals,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
         *FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,Commodities_Feed_Cereals,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")*0.393
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline");

FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes",Commodities_Feed_Cereals,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
         *FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes",Commodities_Feed_Cereals,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")*0.165
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline");

FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
         *FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")*0.393
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline");

FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd,FeedingRations_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
                 + FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))
         *FeedingRations_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")*0.165
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Cereals in Feed DM (share)",ProductionSystems,ProductionConditions,"Baseline");
$offtext;



$ontext;

Assignment for calculations that use the aggregate feeding rations, not the detailed ones:

*adjust the share in Conc GE according to the share of imported conc feed: for pigs and chickens:
*$ontext;
baseline: share in GE conc x and y
share in domestic conc: a and b
new shares:

(x+y)*ax/(ax+by) and  (x+y)*by/(ax+by)
*$offtext;
*for pigs and chickens: pigs, domestic feed share: 0.393, Chickens 0.165
*assigned to "All nonruminants" albeit only covering pigs and chickens for now:
AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")
         = (sum(PigTypeInHerd,ActAnimalsHead_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline"))*0.393
                 + ActAnimalsHead_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")*0.165);

alias(PigTypeInherd_2,PigTypeInherd);

ActAnimalsHead_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd_2,ActAnimalsHead_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline"))
                 + ActAnimalsHead_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline"))
         *ActAnimalsHead_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")*0.393
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline");


ActAnimalsHead_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")
         =(sum(PigTypeInHerd_2,ActAnimalsHead_OtherChar_MR("Switzerland","Pigs",PigTypeInHerd_2,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline"))
                 + ActAnimalsHead_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline"))
         *ActAnimalsHead_OtherChar_MR("Switzerland","Chickens","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline")*0.165
         /AUX_ActAnimalsHead_OtherChar_MR("Switzerland","All Nonruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"Baseline");
$offtext;




$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) ELAniVarProd_RCardinaals_1
$label AssumptionsELAniVarProd_RCardinaals_1
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "NO"
*$setglobal UseProdSyst_ConvOrg "YES"

*assign areas
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities,ProductionSystems,ProductionConditions,"Baseline");
*and set equal zero for the EU, then assign specifically for the EU:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;



*assign permanent grass:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"Baseline");

*reduce temp grass and forage maize areas:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;


*implement EAT Lancet diet by adjusting EU production such as to roughly meet this:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Apples",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Apples",ProductionSystems,ProductionConditions,"Baseline")
                 *1.34*1.18*1.25;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Bananas",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Bananas",ProductionSystems,ProductionConditions,"Baseline")
                 *3;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Barley",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Barley",ProductionSystems,ProductionConditions,"Baseline")
                 *0.35*0.35*1.1*2.54;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Beans, dry",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Beans, dry",ProductionSystems,ProductionConditions,"Baseline")
                 *75*2.87;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Groundnuts, with shell",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Groundnuts, with shell",ProductionSystems,ProductionConditions,"Baseline")
                 *5.5*1.54;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Oats",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Oats",ProductionSystems,ProductionConditions,"Baseline")
                 *1.44*0.45*2.03;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Olives",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Olives",ProductionSystems,ProductionConditions,"Baseline")
                 *0.56*0.86;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Onions, dry",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Onions, dry",ProductionSystems,ProductionConditions,"Baseline")
                 *1.65*1.3*1.29*1.037;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Oranges",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Oranges",ProductionSystems,ProductionConditions,"Baseline")
                 *0.83*1.84;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Potatoes",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Potatoes",ProductionSystems,ProductionConditions,"Baseline")
                 *0.28*1.15;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Pulses,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Pulses,ProductionSystems,ProductionConditions,"Baseline")
                 *9.78*1.5;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Rapeseed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Rapeseed",ProductionSystems,ProductionConditions,"Baseline")
                 *1.34/9*5;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Rye",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Rye",ProductionSystems,ProductionConditions,"Baseline")
                 *0.5514;

*for soyabeans, we have oil and beans - and cake - with different factors: oil 0.83, beans 2.12, cake 0: thus try 1.8 for a start.
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Soybeans",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Soybeans",ProductionSystems,ProductionConditions,"Baseline")
                 *4.4*3.689;
*                 *1.8*10;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Sugar beet",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Sugar beet",ProductionSystems,ProductionConditions,"Baseline")
                 *0.37;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Sunflower seed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Sunflower seed",ProductionSystems,ProductionConditions,"Baseline")
                 *1.04*0.956;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Vegetables,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Vegetables,ProductionSystems,ProductionConditions,"Baseline")
                 *1.26*1.25;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Tomatoes",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Tomatoes",ProductionSystems,ProductionConditions,"Baseline")
                 /1.26*0.53*1.47;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Wheat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Wheat",ProductionSystems,ProductionConditions,"Baseline")
                 *0.43*0.9*0.98;


*allow for almost no trade with the EU:
VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 *0.00001;
VExportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VExportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 *0.00001;
*some exceptions:
VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Bananas",ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Bananas",ProductionSystems,ProductionConditions,"Baseline")
                 *1.8;
VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Groundnuts (in Shell Eq)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Groundnuts (in Shell Eq)",ProductionSystems,ProductionConditions,"Baseline")
                 *5.5*1.54;
VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Palm oil",ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Palm oil",ProductionSystems,ProductionConditions,"Baseline")
                 *1.14*0.65;
VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"Baseline")
                 *0.4744*1.4926;








$ontext;
*grow more cereals and oilcrops/pulses on forage-maize areas:
*and more oil crops on temp grass areas
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Wheat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Wheat",ProductionSystems,ProductionConditions,"Baseline")
                 + VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*0.5;
$offtext;

*$ontext;
*not all countries in the EU may already grow Soybeans, thus the repsective parameters may be missing, thus assign with Austrian values to have them:
ActCropsGrass_Inputs_MR(FAO_EuropeanUnion,"Soybeans",InputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Inputs_MR(FAO_EuropeanUnion,"Soybeans",InputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Inputs_MR("Austria","Soybeans",InputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%");

ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR("Austria","Soybeans",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%");

ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion,"Soybeans",OtherCharCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion,"Soybeans",OtherCharCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_OtherChar_MR("Austria","Soybeans",OtherCharCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%");

CropResidues_Contents_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Contents_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_Contents_MR("Austria","Soybeans",OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"%Scenario%");

CropResidues_OtherChar_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_OtherChar_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_OtherChar_MR("Austria","Soybeans",OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"%Scenario%");

CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_Management_MR("Austria","Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%");

SeedContents_MR(FAO_EuropeanUnion,"Soybeans",Contents,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT SeedContents_MR(FAO_EuropeanUnion,"Soybeans",Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = SeedContents_MR("Austria","Soybeans",Contents,ProductionSystems,ProductionConditions,"%Scenario%");

CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline"))
         = CropResidues_Management_MR("Austria","Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline");

CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_Management_MR("Austria","Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%");

*$offtext;

*domestic production of wheat, maize and barley and products shall not be influenced by change in imports of wheat etc. and products feed:
*VCommod_Production_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Production_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
$ontext;
*but add the additional production from above
                 + VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
*$offtext;
;
VCommod_Production_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"Baseline")
*$ontext;
*but add the additional production from above
                 + (VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                         +VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                                 *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                         *ExtractionRate_CommodityTree(FAO_EuropeanUnion,"Soyabean cake")
$offtext;
;
*VCommod_Production_MR.l(FAO_EuropeanUnion,"Maize and products",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Production_MR.l(FAO_EuropeanUnion,"Maize and products",ProductionSystems,ProductionConditions,"Baseline");
*VCommod_Production_MR.l(FAO_EuropeanUnion,"Barley and products",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Production_MR.l(FAO_EuropeanUnion,"Barley and products",ProductionSystems,ProductionConditions,"Baseline");


*set feed imports to zero:
*supply/demand ratio is needed to account for the mismatch in DAQ-Feed and requirements, but the import data being correct without mismatch

$ontext;
VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");

VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");

VImportQuantity_Feed_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,"AllProdSyst","AllProdCond","%Scenario%") = 0;

*if the resulting values that should be positive are negative, set them equal zero:
VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*rice is all imported, thus should be zero - but due to mismatch with FAO default trade data, this may not be the case, thus set equal zero by hand:
VCommod_Feed_MR.l(FAO_EuropeanUnion,"Rice (Paddy equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Rice (Paddy equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
$offtext;

$ontext;
*add the additional/reduced production of wheat, soy, forage maize and grasslands:
VCommod_Feed_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,"Wheat and products","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");
VCommod_Feed_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
                 + (VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                                  +VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                         *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                 *ExtractionRate_CommodityTree(FAO_EuropeanUnion,"Soyabean cake")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");
VCommod_Feed_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*4/5;
VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"Baseline")*0.84;
VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,"Wheat and products","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");
VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
                 + (VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                                  +VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                         *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                 *ExtractionRate_CommodityTree(FAO_EuropeanUnion,"Soyabean cake")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");
VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*4/5;
VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"Baseline")*0.84;
$offtext;

*Then also adjust the feed utilization share:
Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_Feed_cereals,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         =Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_Feed_cereals,"Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")/3;
Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_Feed_cereals,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_Feed_cereals,"Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                 +Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_Feed_cereals,"Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*2/3;

Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline");
Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean oil","Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean oil","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.0005;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.0005;

*Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 +Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.95;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean oil","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean oil","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 +Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean oil","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.9995;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = (Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 +Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.9995)/3.689;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util processing (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = (Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 +Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.9995)*(1-1/3.689);

*Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%");
*to not later overwrite newly assigned zero values:
*Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $((Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%") = 0)
*                         AND (Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"Baseline") > 0))
*eps was used in the earlier version when scenario definitons came BEFORE assigning initial values to scenarios
*         =0;
*         = eps;


FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =sum((Ruminants,AnimalTypeInHerd),FeedingRations_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"));

FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =sum((NonRuminants,AnimalTypeInHerd),FeedingRations_OtherChar_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"));

FeedingRations_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
FeedingRations_OtherChar_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline");


FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = eps;
         = 0;
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = eps;
         = 0;
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         = sum(Commodities_Feed_Grass,FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline"));

FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         = FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline")
                 /FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline");





*adjust the share in Cereals DM according to the share of imported cereal feed: for pigs and chickens:
$ontext;
assumption the same share goes to pigs and chicken in the baseline and in the scenario.
the share of domestic production to chicken and pig in the scenario is the same as in the baseline
*for pigs and chickens: pigs, domestic feed share: 0.393, Chickens 0.165, this results then in shares of 81% of domestic feed for pig and chicken going to pigs, 19% going to chickens (cf. data from Patricia, gp_sto3_zusammenfassung_produkte_200519_kray, line 17)
thus: from the share of feed going to pigs+chicken, 81% go to pigs in the scenario, 19% to chicken
$offtext;
*assigned to "All nonruminants" albeit only covering pigs and chickens for now:

$ontext;
FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =sum(PigTypeInHerd,FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"));

FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =(FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))*0.81
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline");
FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         =(FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))*0.19;
$offtext;

*grazing assumption from Anivar, rest goes to the default systems
Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
                         AND (1-Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp",ProductionSystems,ProductionConditions,"Baseline")))
         = 0.57*Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond","Baseline")
                 /(1-Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp",ProductionSystems,ProductionConditions,"Baseline"));
Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
                         AND (1-Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp",ProductionSystems,ProductionConditions,"Baseline")))
         = 0.43;
Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
                         AND (1-Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based","Pasture/Range/Paddock","AllAndAverageTemp",ProductionSystems,ProductionConditions,"Baseline")))
         = 0.57*Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond","Baseline")
                 /(1-Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based","Pasture/Range/Paddock","AllAndAverageTemp",ProductionSystems,ProductionConditions,"Baseline"));
Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based","Pasture/Range/Paddock","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
                         AND (1-Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based","Pasture/Range/Paddock","AllAndAverageTemp",ProductionSystems,ProductionConditions,"Baseline")))
         = 0.43;



*liveweight data from Anivar (assume baseline fro Weaners, category not present in Anivar)
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Sows","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.24;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Sucklers","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.06;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Weaners","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.5;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Fatteners","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.115;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Boars","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.265;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Rep_Sows","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.24;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Rep_Boars","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.265;


ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","Producing_Dairy_Cattle","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.593;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","Dsires","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.771;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","DFemaleCalves1","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","DFemaleCalves2","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","DFemaleCalves3","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.534;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","DMaleCalves1","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","DMaleCalves2","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BCows","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.593;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BSires","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.771;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BFemaleCalves1","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BFemaleCalves2","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BMaleCalves1","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BMaleCalves2","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;


ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Chickens","AllANdAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.00188;


VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","Baseline")
                 *0.55*0.000000001;


*VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
*         = VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")/10;

$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Bioenergy_RCardinaals_1
$label AssumptionsBioenergy_RCardinaals_1
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "NO"
*$setglobal UseProdSyst_ConvOrg "YES"

*assign areas
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities,ProductionSystems,ProductionConditions,"Baseline");
*and set equal zero for the EU, then assign specifically for the EU:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;



*assign permanent grass:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"Baseline");

*reduce temp grass and forage maize areas:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;

*assign green manure:
VActCropsGrass_QuantityActUnits_MR.l("European Union","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")
         = sum(FAO_EuropeanUnion,VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline"));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Clover for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")
         = 25005864/2
                 *VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")
                         /VActCropsGrass_QuantityActUnits_MR.l("European Union","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline");

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Alfalfa for Forage+Silag",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")
         = 25005864/2
                 *VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")
                         /VActCropsGrass_QuantityActUnits_MR.l("European Union","Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline");


*implement EAT Lancet diet by adjusting EU production such as to roughly meet this:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Apples",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Apples",ProductionSystems,ProductionConditions,"Baseline")
                 *1.34*1.18*1.25;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Bananas",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Bananas",ProductionSystems,ProductionConditions,"Baseline")
                 *3;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Barley",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Barley",ProductionSystems,ProductionConditions,"Baseline")
                 *0.35*0.35*1.1*2.54;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Beans, dry",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Beans, dry",ProductionSystems,ProductionConditions,"Baseline")
                 *75*2.87;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Groundnuts, with shell",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Groundnuts, with shell",ProductionSystems,ProductionConditions,"Baseline")
                 *5.5*1.54;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Oats",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Oats",ProductionSystems,ProductionConditions,"Baseline")
                 *1.44*0.45*2.03;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Olives",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Olives",ProductionSystems,ProductionConditions,"Baseline")
                 *0.56*0.86;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Onions, dry",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Onions, dry",ProductionSystems,ProductionConditions,"Baseline")
                 *1.65*1.3*1.29*1.037;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Oranges",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Oranges",ProductionSystems,ProductionConditions,"Baseline")
                 *0.83*1.84;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Potatoes",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Potatoes",ProductionSystems,ProductionConditions,"Baseline")
                 *0.28*1.15;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Pulses,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Pulses,ProductionSystems,ProductionConditions,"Baseline")
                 *9.78*1.5;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Rapeseed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Rapeseed",ProductionSystems,ProductionConditions,"Baseline")
                 *1.34/9*5;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Rye",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Rye",ProductionSystems,ProductionConditions,"Baseline")
                 *0.5514;

*for soyabeans, we have oil and beans - and cake - with different factors: oil 0.83, beans 2.12, cake 0: thus try 1.8 for a start.
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Soybeans",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Soybeans",ProductionSystems,ProductionConditions,"Baseline")
                 *4.4*3.689;
*                 *1.8*10;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Sugar beet",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Sugar beet",ProductionSystems,ProductionConditions,"Baseline")
                 *0.37;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Sunflower seed",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Sunflower seed",ProductionSystems,ProductionConditions,"Baseline")
                 *1.04*0.956;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Vegetables,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Vegetables,ProductionSystems,ProductionConditions,"Baseline")
                 *1.26*1.25;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Tomatoes",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Tomatoes",ProductionSystems,ProductionConditions,"Baseline")
                 /1.26*0.53*1.47;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Wheat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Wheat",ProductionSystems,ProductionConditions,"Baseline")
                 *0.43*0.9*0.98;


*allow for almost no trade with the EU:
VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 *0.00001;
VExportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VExportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities,ProductionSystems,ProductionConditions,"Baseline")
                 *0.00001;
*some exceptions:
VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Bananas",ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Bananas",ProductionSystems,ProductionConditions,"Baseline")
                 *1.8;
VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Groundnuts (in Shell Eq)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Groundnuts (in Shell Eq)",ProductionSystems,ProductionConditions,"Baseline")
                 *5.5*1.54;
VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Palm oil",ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Palm oil",ProductionSystems,ProductionConditions,"Baseline")
                 *1.14*0.65;
VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World","Rice (Paddy Equivalent)",ProductionSystems,ProductionConditions,"Baseline")
                 *0.4744*1.4926;








$ontext;
*grow more cereals and oilcrops/pulses on forage-maize areas:
*and more oil crops on temp grass areas
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Wheat",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Wheat",ProductionSystems,ProductionConditions,"Baseline")
                 + VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*0.5;
$offtext;

*$ontext;
*not all countries in the EU may already grow Soybeans, thus the repsective parameters may be missing, thus assign with Austrian values to have them:
ActCropsGrass_Inputs_MR(FAO_EuropeanUnion,"Soybeans",InputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Inputs_MR(FAO_EuropeanUnion,"Soybeans",InputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Inputs_MR("Austria","Soybeans",InputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%");

ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR("Austria","Soybeans",OutputsCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%");

ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion,"Soybeans",OtherCharCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion,"Soybeans",OtherCharCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%"))
         = ActCropsGrass_OtherChar_MR("Austria","Soybeans",OtherCharCropsGrass,ProductionSystems,ProductionConditions,"%Scenario%");

CropResidues_Contents_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Contents_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_Contents_MR("Austria","Soybeans",OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"%Scenario%");

CropResidues_OtherChar_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_OtherChar_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_OtherChar_MR("Austria","Soybeans",OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"%Scenario%");

CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_Management_MR("Austria","Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%");

SeedContents_MR(FAO_EuropeanUnion,"Soybeans",Contents,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT SeedContents_MR(FAO_EuropeanUnion,"Soybeans",Contents,ProductionSystems,ProductionConditions,"%Scenario%"))
         = SeedContents_MR("Austria","Soybeans",Contents,ProductionSystems,ProductionConditions,"%Scenario%");

CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline")
                 $(NOT CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline"))
         = CropResidues_Management_MR("Austria","Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline");

CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT CropResidues_Management_MR(FAO_EuropeanUnion,"Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%"))
         = CropResidues_Management_MR("Austria","Soybeans",OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"%Scenario%");

*$offtext;

*domestic production of wheat, maize and barley and products shall not be influenced by change in imports of wheat etc. and products feed:
*VCommod_Production_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Production_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"Baseline")
$ontext;
*but add the additional production from above
                 + VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
*$offtext;
;
VCommod_Production_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"Baseline")
*$ontext;
*but add the additional production from above
                 + (VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                         +VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                                 *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                         *ExtractionRate_CommodityTree(FAO_EuropeanUnion,"Soyabean cake")
$offtext;
;
*VCommod_Production_MR.l(FAO_EuropeanUnion,"Maize and products",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Production_MR.l(FAO_EuropeanUnion,"Maize and products",ProductionSystems,ProductionConditions,"Baseline");
*VCommod_Production_MR.l(FAO_EuropeanUnion,"Barley and products",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Production_MR.l(FAO_EuropeanUnion,"Barley and products",ProductionSystems,ProductionConditions,"Baseline");


*set feed imports to zero:
*supply/demand ratio is needed to account for the mismatch in DAQ-Feed and requirements, but the import data being correct without mismatch

$ontext;
VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");

VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");

VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"BaselineDerived")
                 - VImportQuantity_Feed_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");

VImportQuantity_Feed_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,"AllProdSyst","AllProdCond","%Scenario%") = 0;

*if the resulting values that should be positive are negative, set them equal zero:
VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VImportQuantity_MR.l(FAO_EuropeanUnion,"World",Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*rice is all imported, thus should be zero - but due to mismatch with FAO default trade data, this may not be the case, thus set equal zero by hand:
VCommod_Feed_MR.l(FAO_EuropeanUnion,"Rice (Paddy equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Rice (Paddy equivalent)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
$offtext;

$ontext;
*add the additional/reduced production of wheat, soy, forage maize and grasslands:
VCommod_Feed_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,"Wheat and products","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");
VCommod_Feed_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
                 + (VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                                  +VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                         *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                 *ExtractionRate_CommodityTree(FAO_EuropeanUnion,"Soyabean cake")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");
VCommod_Feed_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*4/5;
VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"Baseline")*0.84;
VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Wheat and products",ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*6/100
                         *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Wheat","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,"Wheat and products","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");
VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Soyabean cake",ProductionSystems,ProductionConditions,"%Scenario%")
                 + (VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*14/100
                                  +VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.16)
                         *ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Soybeans","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                                 *ExtractionRate_CommodityTree(FAO_EuropeanUnion,"Soyabean cake")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"Baseline");
VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(FAO_EuropeanUnion,"Maize for Forage+Silage",ProductionSystems,ProductionConditions,"Baseline")*4/5;
VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_Feed_Grass,ProductionSystems,ProductionConditions,"Baseline")*0.84;
$offtext;

*Then also adjust the feed utilization share:
Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_Feed_cereals,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         =Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_Feed_cereals,"Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")/3;
Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_Feed_cereals,"Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_Feed_cereals,"Util food (share)",ProductionSystems,ProductionConditions,"Baseline")
                 +Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_Feed_cereals,"Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*2/3;

Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline");
Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean oil","Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean oil","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.0005;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.0005;

*Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 +Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean cake","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.95;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean oil","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean oil","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 +Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabean oil","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.9995;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = (Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 +Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.9995)/3.689;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util processing (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = (Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util food (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 +Commod_OtherChar_MR(FAO_EuropeanUnion,"Soyabeans","Util feed (share)",ProductionSystems,ProductionConditions,"Baseline")*0.9995)*(1-1/3.689);

*Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*                 /VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%");
*to not later overwrite newly assigned zero values:
*Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $((Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%") = 0)
*                         AND (Commod_OtherChar_MR(FAO_EuropeanUnion,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"Baseline") > 0))
*eps was used in the earlier version when scenario definitons came BEFORE assigning initial values to scenarios
*         =0;
*         = eps;


FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =sum((Ruminants,AnimalTypeInHerd),FeedingRations_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"));

FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =sum((NonRuminants,AnimalTypeInHerd),FeedingRations_OtherChar_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"));

FeedingRations_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
FeedingRations_OtherChar_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline");


FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = eps;
         = 0;
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = eps;
         = 0;
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         = sum(Commodities_Feed_Grass,FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline"));

FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline")
         = FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline")
                 /FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline");





*adjust the share in Cereals DM according to the share of imported cereal feed: for pigs and chickens:
$ontext;
assumption the same share goes to pigs and chicken in the baseline and in the scenario.
the share of domestic production to chicken and pig in the scenario is the same as in the baseline
*for pigs and chickens: pigs, domestic feed share: 0.393, Chickens 0.165, this results then in shares of 81% of domestic feed for pig and chicken going to pigs, 19% going to chickens (cf. data from Patricia, gp_sto3_zusammenfassung_produkte_200519_kray, line 17)
thus: from the share of feed going to pigs+chicken, 81% go to pigs in the scenario, 19% to chicken
$offtext;
*assigned to "All nonruminants" albeit only covering pigs and chickens for now:

$ontext;
FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =sum(PigTypeInHerd,FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"));

FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
         =(FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))*0.81
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs",PigTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline");
FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         =(FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline")
                 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"Baseline"))*0.19;
$offtext;

*grazing assumption from Anivar, rest goes to biogas digester (and all for non ruminants)
Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond","%Scenario%")
         = 0;
Manure_Management_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond","%Scenario%")
         = 0;
Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan system","Anaerobic digester","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
         = 0.57;
Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
         = 0.43;
Manure_Management_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"Quantity share in ManureMan system","Anaerobic digester","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
         = 1;

Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond","%Scenario%")
         = 0;
Manure_Management_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond","%Scenario%")
         = 0;
Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based","Anaerobic digester","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
         = 0.57;
Manure_Management_MR(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based","Pasture/Range/Paddock","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion,Ruminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
         = 0.43;
Manure_Management_MR(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based","Anaerobic digester","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion,NonRuminants,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
         = 1;





*crop residue managemnet: all in biogas digester:
CropResidues_Management_MR(FAO_EuropeanUnion,Crops,"Average Residues (t)","Quantity share in CropResMan system","Biogas",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Crops,ProductionSystems,ProductionConditions,"%Scenario%")
          = 1;

*100% of clover and alfalfa should be residues that go to the digester - thus mimick by residue yield ratio of 100 and dividing yields by 100
CropResidues_OtherChar_MR(FAO_EuropeanUnion,"Clover for Forage+Silage","Average residues (t)","Residue share t DM / t DM MainOutput1",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Clover for Forage+Silage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 100;
CropResidues_OtherChar_MR(FAO_EuropeanUnion,"Alfalfa for Forage+Silag","Average residues (t)","Residue share t DM / t DM MainOutput1",ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"Alfalfa for Forage+Silag",ProductionSystems,ProductionConditions,"%Scenario%")
         = 100;
ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Clover for Forage+Silage","MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Clover for Forage+Silage","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *0.01;
ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Alfalfa for Forage+Silag","MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(FAO_EuropeanUnion,"Alfalfa for Forage+Silag","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *0.01;
*as fixation scales with yields, we have to adapt this as well:
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion,"Clover for Forage+Silage","N fixation per ton MainOutput1 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion,"Clover for Forage+Silage","N fixation per ton MainOutput1 (tN)",ProductionSystems,ProductionConditions,"Baseline")
                 *100;
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion,"Alfalfa for Forage+Silag","N fixation per ton MainOutput1 (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion,"Alfalfa for Forage+Silag","N fixation per ton MainOutput1 (tN)",ProductionSystems,ProductionConditions,"Baseline")
                 *100;




Commod_OtherChar_MR(FAO_EuropeanUnion,"Clover for Forage+Silage","Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Clover for Forage+Silage","Util other (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 1;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Alfalfa for Forage+Silag","Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
Commod_OtherChar_MR(FAO_EuropeanUnion,"Alfalfa for Forage+Silag","Util other (share)",ProductionSystems,ProductionConditions,"%Scenario%")
         = 1;


*liveweight data from Anivar (assume baseline fro Weaners, category not present in Anivar)
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Sows","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.24;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Sucklers","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.06;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Weaners","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.5;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Fatteners","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.115;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Boars","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.265;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Rep_Sows","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.24;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Pigs","Rep_Boars","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.265;


ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","Producing_Dairy_Cattle","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.593;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","Dsires","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.771;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","DFemaleCalves1","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","DFemaleCalves2","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","DFemaleCalves3","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.534;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","DMaleCalves1","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","DMaleCalves2","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BCows","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.593;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BSires","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.771;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BFemaleCalves1","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BFemaleCalves2","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BMaleCalves1","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"Cattle","BMaleCalves2","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.346;


ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion,"CHickens","AllANdAverageTypes","Liveweight (t)","AllProdSyst","AllProdCond","%Scenario%")
         = 0.00188;

VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","%Scenario%")
         = VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","Baseline")
                 *0.43*0.000000001;


*VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
*         = VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")/10;

$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) FOFA_BAU_2012
$label AssumptionsFOFA_BAU_2012
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "NO"
*$setglobal UseProdSyst_ConvOrg "YES"

*TO SEE WHETHER IT WORKS:
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline");

*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Convent",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline");

*assign areas
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"FOFA_BAU_2012");

*Baseline FOFA 2012: the baseline in BioBam is only 86.74% from the baseline I have from FAOSTAT - hence this correction
VActCropsGrass_QuantityActUnits_MR.l(Regions,CoreGrassActivities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,CoreGrassActivities,ProductionSystems,ProductionConditions,"FOFA_BAU_2012");
*NO - not needed anymore - this was due to BioBam being area occupied, our areas being areas harvested - but we corrected for it with cropping intensity values, cf. where the data is read.
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,CoreGrassActivities,ProductionSystems,ProductionConditions,"Baseline")*0.8674;
*the BioBam CAPRI data has no temporary grassland values for FOFA_BAU_2012 for non-EU countries, thus assign default baseline values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline");

VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"FOFA_BAU_2012");
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"Baseline");
*the BioBam CAPRI data has no forage values for FOFA_BAU_2012 for non-EU countries, thus assign default baseline values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"Baseline");


*VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline");

*assume higher grassland utilization than in iur FAOSTAT baseline with yiuelds from Erb, to better reflect the situation of the data currently used in BioBam and the FOFA baseline 2012:
*the following is already assigned from SteeringFile 1
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2012");
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"Baseline")/1.15;


$ontext;
*FOFA 2012/2050; BioBam data: relative to the baseline, more pigs are there than chicken (increase from FOFA 2012: pigs 10%, chickens: slight reduction)
*in the baseline 2012, adjustment needed, as with GE shares derived from FAOSTAT feed supply and animal numbers, chickens are 10% too low, bigs about 5% too high.
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"))
         = sum(AnimalTypeInHerd_NoAggregates,FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"));
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = sum(AnimalTypeInHerd_NoAggregates,FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"));

FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 *1.1;
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")/1.1*0.1
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%");
$offtext;

*use the animal numbers from FOFA:
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2012");

VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%");
*get rid of the AllAndAverageTypes for the animals with herd structures - as they are the sum and may cause problems when summing over all animals and herd types:
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Pigs","AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%") = 0;


*some numbers of animals are zero in this data, such as horses and games - thus assign zero share in total GE req to them:
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2012"))
         =eps;
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2012"))
         =eps;

*shares for some commodities are zero here - and are potentially later assigned with non-zero baseline values in the initiaisation code in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms,
*thus also assign eps to these zeroes and then replace the eps with zero again later, in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")))
         =eps;

$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) FOFA_BAU_2050
$label AssumptionsFOFA_BAU_2050
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "NO"
*$setglobal UseProdSyst_ConvOrg "YES"

*TO SEE WHETHER IT WORKS:
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline");

*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Convent",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline");

*assign areas
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*Baseline 2050: from BioBam, only 95.42% of permanent grassland from the Baseline is available - hence this correction
*no specific 2050 permanent grassland data - thus use 2012 with this factor (data on temporary grassland is available for the scenario for the EU from BioBam - so assign it for non-EU specifically)
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"FOFA_BAU_2012")*0.9542;
*when NOT DOING UNISECO / SESSIT calculations, use the baseline values:
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"Baseline");

*NEXT FACTOR not needed anymore, cf. correspining line above for BAU_2012: NO - not needed anymore - this was due to BioBam being area occupied, our areas being areas harvested - but we corrected for it with cropping intensity values, cf. where the data is read.
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.8674*0.9542;
*the BioBam CAPRI data has no temporary grassland values for FOFA_BAU_2050 for non-EU countries, thus assign default baseline values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%"))
*when NOT DOING UNISECO / SESSIT calculations, use the baseline values:
*        AND THUS DO NOT do it conditional on values being available, to be sure about using baseline values .
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline");
*the above may not be needed anymore, as already assigned in reading UNISECO data, but doing it here again is no problem.

VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"Baseline");
*the BioBam CAPRI data has no forage values for FOFA_BAU_2050 for non-EU countries, thus assign default baseline values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"Baseline");
*the above may not be needed anymore, as already assigned in reading UNISECO data, but doing it here again is no problem.

*only use the values for "ALlProSyst", thus drop rainfed and irrigated:
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Rainfed",ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Irrigated",ProductionConditions,"%Scenario%") = 0;

*VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline");

*change util feed share to get the animal numbers in FOFA_2050_BAU right with the baseline supply/demand ratio, etc- this is also no surprise - default util rates are from the baseline, so changes till 2050 are likely, but we do not have data on this
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"%Scenario%")
*                 $(NOT Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline") = 1)
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.72;
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"Baseline")
*                 + Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.28;

*assume higher grassland utilization than in iur FAOSTAT baseline with yields from Erb, to better reflect the situation of the data currently used in BioBam and the FOFA baseline 2050:
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"%Scenario%")
*no data for supply/demand for grasslands for 2050, thus use 2012:
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2012");
*grassland data is available for 2012 only, so
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"Baseline")/1.09;

$ontext;
*FOFA 2012/2050; BioBam data: relative to the baseline, more pigs are there than chicken (increase from FOFA 2012: pigs 10%, chickens: slight reduction)
*in the baseline 2012, adjustment needed, as with GE shares derived from FAOSTAT feed supply and animal numbers, chickens are 10% too low, bigs about 5% too high.
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"))
         = sum(AnimalTypeInHerd_NoAggregates,FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"));
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = sum(AnimalTypeInHerd_NoAggregates,FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"));

FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 *0.976;
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")/0.976*0.024
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%");
$offtext;

*use the animal numbers from FOFA:
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Share animal type in total living animals",ProductionSystems,ProductionConditions,"%Scenario%");
*get rid of the AllAndAverageTypes for the animals with herd structures - as they are the sum and may cause problems when summing over all animals and herd types:
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Cattle","AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,"Pigs","AllAndAverageTypes",ProductionSystems,ProductionConditions,"%Scenario%") = 0;


*some numbers of animals are zero in this data, such as horses and games - thus assign zero share in total GE req to them:
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2050"))
         =eps;
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2050"))
         =eps;
*there is no need to adjust the "Quantity share in total feed req of all animals" for other animals, as these shares here are already 0 for 2050 (as derived in _V6_DeriveSomeValues_ForScenariosWithGivenAnimalNumbers, where the respective animal numbers are zero)
*THe code above is only to set the "0" to eps, to avoid that it is replaced with baseline values in the subsequent module _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc, which would happen in case they are 0.


*shares for some commodities are zero here (from FOFA_2050 data) - and are potentially later assigned with non-zero baseline values in the initiaisation code in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms,
*thus also assign eps to these zeroes and then replace the eps with zero again later, in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")))
         =eps;



*no grassland yield data for 2050, so use 2012:
*NO - use default: data from Baseline
*ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","%Scenario%")
*         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012");
*ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","%Scenario%")
*         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2012");


$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*7) FOFA_BAU_2050_Test
$label AssumptionsFOFA_BAU_2050_Test
PUTCLOSE con,"Current scenario: %Scenario%";

*recalculates FOFA_BAU_2050 with the assumptions on areas, supply/demand, etc. but WITHOUT providing animal numbers: to test, whether it replicates those

$setglobal UseProdSyst_ConvOrg "NO"
*$setglobal UseProdSyst_ConvOrg "YES"

$setglobal UseReference2050 "YES"

*assign areas
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*Baseline 2050: from BioBam, only 95.42% of permanent grassland from the Baseline is available - hence this correction
*no specific 2050 permanent grassland data - thus use 2012 with this factor (data on temporary grassland is available for the scenario for the EU from BioBam - so assign it for non-EU specifically)
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"FOFA_BAU_2012")*0.9542;
*when NOT DOING UNISECO / SESSIT calculations, use the baseline values:
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"Baseline");
*2050 is available, so use this:
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*the BioBam CAPRI data has no temporary grassland values for FOFA_BAU_2050 for non-EU countries, thus assign default baseline values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
*                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%"))
*when NOT DOING UNISECO / SESSIT calculations, use the baseline values:
*        AND THUS DO NOT do it conditional on values being available, to be sure about using baseline values .
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline");
*2050 is available, so use this:
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
*the above may not be needed anymore, as already assigned in reading UNISECO data, but doing it here again is no problem.


VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"Baseline");
*the BioBam CAPRI data has no forage values for FOFA_BAU_2050 for non-EU countries, thus assign default baseline values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%"))
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"Baseline");
*2050 is available, so use this:
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
*the above may not be needed anymore, as already assigned in reading UNISECO data, but doing it here again is no problem.

*only use the values for "ALlProSyst", thus drop rainfed and irrigated:
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Rainfed",ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Irrigated",ProductionConditions,"%Scenario%") = 0;


*change util feed share to get the animal numbers in FOFA_2050_BAU right with the baseline supply/demand ratio, etc- this is also no surprise - default util rates are from the baseline, so changes till 2050 are likely, but we do not have data on this
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"%Scenario%")
*                 $(NOT Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline") = 1)
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.72;
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"Baseline")
*                 + Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.28;

*assume higher grassland utilization than in iur FAOSTAT baseline with yields from Erb, to better reflect the situation of the data currently used in BioBam and the FOFA baseline 2050:
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"%Scenario%")
*no data for supply/demand for grasslands for 2050, thus use 2012:
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2012");
*grassland data is available for 2012 only, so
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"Baseline")/1.09;

$ontext;
*FOFA 2012/2050; BioBam data: relative to the baseline, more pigs are there than chicken (increase from FOFA 2012: pigs 10%, chickens: slight reduction)
*in the baseline 2012, adjustment needed, as with GE shares derived from FAOSTAT feed supply and animal numbers, chickens are 10% too low, bigs about 5% too high.
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"))
         = sum(AnimalTypeInHerd_NoAggregates,FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"));
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = sum(AnimalTypeInHerd_NoAggregates,FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"));

FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 *0.976;
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")/0.976*0.024
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%");
$offtext;



*some numbers of animals are zero in 2050 data, such as horses and games - thus assign zero share in total GE req to them:
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2050"))
         =eps;
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2050"))
         =eps;

*the relevant baseline for this scenario is FOFA_BAU_2050, thus assign the parameters to those, where not the values from "Baseline" are to be used:
ActCropsGrass_Outputs_MR(Countries,Activities,OutputsCropsGrass,ProductionSystems,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,Activities,OutputsCropsGrass,ProductionSystems,"AllProdCond","FOFA_BAU_2050");

ActAnimalsHead_Outputs_MR(Countries,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond","%Scenario%")
         = ActAnimalsHead_Outputs_MR(Countries,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond","FOFA_BAU_2050");


*no grassland yield data for 2050, so use 2012:
*no, after running 2050, it is available, thus use FOFA_BAU_2050, not ...2012
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","%Scenario%")
*         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012");
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2050");
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","%Scenario%")
*         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2012");
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2050");

FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*shares for some commodities are zero here (from FOFA_2050 data) - and are potentially later assigned with non-zero baseline values in the initiaisation code in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms,
*thus also assign eps to these zeroes and then replace the eps with zero again later, in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")))
         =eps;

*asign a number of parameters used to derive animal numbers to the FOFA 2050 BAU values (default is the SOLm Baseline)
*Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
ActCropsGrass_OtherChar_MR(Countries,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond","%Scenario%")
         = ActCropsGrass_OtherChar_MR(Countries,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond","FOFA_BAU_2050");

Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");




VPopulationNumbers_MR.l(Regions,PopulationGroups,"%Scenario%")
         = VPopulationNumbers_MR.l(Regions,PopulationGroups,"FOFA_BAU_2050")

$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*7a) FOFA_BAU_2050_Test_10PercLessArea
$label AssumptionsFOFA_BAU_2050_Test_10PercLessArea
PUTCLOSE con,"Current scenario: %Scenario%";

*recalculates FOFA_BAU_2050 with the assumptions on areas, supply/demand, etc. but WITHOUT providing animal numbers: to test, whether it replicates those

$setglobal UseProdSyst_ConvOrg "NO"
*$setglobal UseProdSyst_ConvOrg "YES"


*assign areas
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"FOFA_BAU_2050")*0.9;

*Baseline 2050: from BioBam, only 95.42% of permanent grassland from the Baseline is available - hence this correction
*no specific 2050 permanent grassland data - thus use 2012 with this factor (data on temporary grassland is available for the scenario for the EU from BioBam - so assign it for non-EU specifically)
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"FOFA_BAU_2012")*0.9542*0.9;
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.8674*0.9542;
*the BioBam CAPRI data has no temporary grassland values for FOFA_BAU_2050 for non-EU countries, thus assign default baseline values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.9;
*the above may not be needed anymore, as already assigned in reading UNISECO data, but doing it here again is no problem.

VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"FOFA_BAU_2050")*0.9;
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"Baseline");
*the BioBam CAPRI data has no forage values for FOFA_BAU_2050 for non-EU countries, thus assign default baseline values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,ProductionSystems,ProductionConditions,"Baseline")*0.9;
*the above may not be needed anymore, as already assigned in reading UNISECO data, but doing it here again is no problem.


*change util feed share to get the animal numbers in FOFA_2050_BAU right with the baseline supply/demand ratio, etc- this is also no surprise - default util rates are from the baseline, so changes till 2050 are likely, but we do not have data on this
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"%Scenario%")
*                 $(NOT Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline") = 1)
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.72;
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"Baseline")
*                 + Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.28;

*assume higher grassland utilization than in iur FAOSTAT baseline with yields from Erb, to better reflect the situation of the data currently used in BioBam and the FOFA baseline 2050:
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"%Scenario%")
*no data for supply/demand for grasslands for 2050, thus use 2012:
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2012");
*grassland data is available for 2012 only, so
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"Baseline")/1.09;

$ontext;
*FOFA 2012/2050; BioBam data: relative to the baseline, more pigs are there than chicken (increase from FOFA 2012: pigs 10%, chickens: slight reduction)
*in the baseline 2012, adjustment needed, as with GE shares derived from FAOSTAT feed supply and animal numbers, chickens are 10% too low, bigs about 5% too high.
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 $(NOT FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"))
         = sum(AnimalTypeInHerd_NoAggregates,FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"));
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = sum(AnimalTypeInHerd_NoAggregates,FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%"));

FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens",AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 *0.976;
FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Chickens","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")/0.976*0.024
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs",AnimalTypeInHerd_NoAggregates,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%")
                                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"Pigs","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"%Scenario%");
$offtext;



*some numbers of animals are zero in 2050 data, such as horses and games - thus assign zero share in total GE req to them:
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2050"))
         =eps;
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2050"))
         =eps;

*the relevant baseline for this scenario is FOFA_BAU_2050, thus assign the parameters to those, where not the values from "Baseline" are to be used:
ActCropsGrass_Outputs_MR(Countries,Activities,OutputsCropsGrass,ProductionSystems,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,Activities,OutputsCropsGrass,ProductionSystems,"AllProdCond","FOFA_BAU_2050");

ActAnimalsHead_Outputs_MR(Countries,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond","%Scenario%")
         = ActAnimalsHead_Outputs_MR(Countries,Livestock,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst","AllProdCond","FOFA_BAU_2050");


*no grassland yield data for 2050, so use 2012:
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2012");
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2012");

FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*shares for some commodities are zero here (from FOFA_2050 data) - and are potentially later assigned with non-zero baseline values in the initiaisation code in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms,
*thus also assign eps to these zeroes and then replace the eps with zero again later, in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"Baseline")
                         AND (NOT FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")))
         =eps;

*asign a number of parameters used to derive animal numbers to the FOFA 2050 BAU values (default is the SOLm Baseline)
*Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
ActCropsGrass_OtherChar_MR(Countries,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond","%Scenario%")
         = ActCropsGrass_OtherChar_MR(Countries,Activities,OtherCharCropsGrass,ProductionSystems,"AllProdCond","FOFA_BAU_2050");

Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");




VPopulationNumbers_MR.l(Regions,PopulationGroups,"%Scenario%")
         = VPopulationNumbers_MR.l(Regions,PopulationGroups,"FOFA_BAU_2050")

$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*8) FOFA_BAU_2050_25Organic
$label AssumptionsFOFA_BAU_2050_25Organic
PUTCLOSE con,"Current scenario: %Scenario%";

*$setglobal UseProdSyst_ConvOrg "NO"
$setglobal UseProdSyst_ConvOrg "YES"

*TO SEE WHETHER IT WORKS:
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline");

*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Convent",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline");

*assign areas
*Baseline 2050: from BiuoBam, only 95.42% of grassland from the Baseline and the baseline in BioBam is only 86.74% from the baseline I have from FAOSTAT - hence this correction
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.75;
*Baseline 2050: from BioBam, only 95.42% of permanent grassland from the Baseline is available - hence this correction
*no specific 2050 permanent grassland data - thus use 2012 with this factor (data on temporary grassland is available for the scenario)
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","ALlProdSyst",ProductionConditions,"FOFA_BAU_2012")*0.9542
                 *0.75;
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.8674*0.9542;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.75;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.25;
*Baseline 2050: from BioBam, only 95.42% of permanent grassland from the Baseline is available - hence this correction
*no specific 2050 permanent grassland data - thus use 2012 with this factor (data on temporary grassland is available for the scenario)
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2012")*0.9542
                 *0.25;
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures",ProductionSystems,ProductionConditions,"Baseline")*0.8674*0.9542;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.25;

*some numbers of animals are zero in 2050 data, such as horses and games - thus assign zero share in total GE req to them:
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2050"))
         =eps;
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living",ProductionSystems,ProductionConditions,"FOFA_BAU_2050"))
         =eps;


FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

FeedingRationsHeads_OtherChar_MR(Countries,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Countries,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");



*Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
*Commod_OtherChar_MR(Regions,"AggregateFeedTotal_Commodity","Feed GE supply/demand ratio Total",ProductionSystems,ProductionConditions,"%Scenario%")
*ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")


*change util feed share to get the animal numbers in FOFA_2050_BAU right with the baseline supply/demand ratio, etc- this is also no surprise - default util rates are from the baseline, so changes till 2050 are likely, but we do not have data on this
$ontext;
We use 2050 supp/demand ratio, etc. so try first with those
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline") = 1)
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.72;
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"Baseline")
                 + Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.28;
$offtext;


*VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline");

*yields: apply yield gap:
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*convent yields:
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Convent",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


*VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline_100Organic")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline");

*as some commodity variables scale with baseline values: assign them to 100% organic:
VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VImportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VImportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");

VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio",ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio","AllProdSyst",ProductionConditions,"Baseline");

VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"ALlProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"ALlProdSyst",ProductionConditions,"Baseline");


*adjust legume area shares in case they are less than 25% in total:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         =sum(Legumes_NFixing,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,ProductionSystems,ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         =sum(Crops_NoNFixingLegumes,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,ProductionSystems,ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"FOFA_BAU_2050"));
ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*factor *0.25: as we generally have 25% of areas under organic managemnt, this rearrangement of crop types applies to this area share only
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"Organic",ProductionConditions,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") < 0.25))
         = 0.25*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *0.25
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"Organic",ProductionConditions,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") < 0.25))
         = 0.75*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *0.25
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*assume lower organic grassland yields
ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,COreGrassActivities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline")*0.9;


VPopulationNumbers_MR.l(Regions,PopulationGroups,"%Scenario%")
         = VPopulationNumbers_MR.l(Regions,PopulationGroups,"FOFA_BAU_2050")

*assign mineral N fertilizer values:
*VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","Baseline_50Organic")
*         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","Baseline")*0.5;
*VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","Convent","Baseline_100Organic")
*         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","Baseline")*0;


*THE FOLLOWING SHOULD WORK NOW!!!
*TO SEE WHETHER IT WORKS: only organic feed available
*adjust for yield gap: factor 0.8 for non-grass commodities; 0.9 for temporary, 1 for permanent grass
*TO BE IMPROVED - AD HOC
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")*0.8;
*but this adjustment does apply to concentrate feed only; adjust the grassland feed according to changing grassland areas:
*VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")*0.9;
*VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");

*also adjust the feed commodities by the yield gap, to capture lower yields in feed production:
*DOES NOT WORK - WRONG MATCHING - WE need the matching from the commodityTree set, but this is assumingly slow, so use a general factor to capture the essence of it
*TO BE IMPROVED!!!
*and do it DIRECTLY ba a yield gap factor in the calculations above - as it does not apply to grass
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*         = sum(Activities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
*                 VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*                         *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline"));

$ontext;

The following assignments are done in the specific file AssignInitialValues!

*assign org/conv yields:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Convent",ProductionConditions,"Baseline_100Organic")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"Baseline_100Organic");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"Baseline_100Organic")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"Baseline_100Organic")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"Baseline_100Organic")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*assign the Bioe-specific values that are yet missing, as there are no baseline values reported:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"Baseline_100Organic")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"Baseline_100Organic"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"Baseline");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"Baseline_100Organic")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"Baseline_100Organic"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"Baseline");

ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"Baseline_100Organic"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"Baseline_100Organic"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");


ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"Baseline_100Organic"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"Baseline_100Organic"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
$offtext;



$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*9) "LfP_2050"
$label AssumptionsLfP_2050
*CAN ONLY BE RUN if FOFA_BAU_2050 is run first, as this is the baseline for this scenario
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "YES"

*assign areas: for the EU, we assume 25% organic, for the RoW, we assume 5% organic

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"LfP_2050")
                 *0.95;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries (only for EU; see below) - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"LfP_2050")
                 *0.95;
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"LfP_2050")
                 *0.05;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries (only for EU; see below) - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"LfP_2050")
                 *0.05;
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"LfP_2050")
                 *0.75;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"LfP_2050")
                 *0.75;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.75;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"LfP_2050")
                 *0.75;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"LfP_2050")
                 *0.25;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"LfP_2050")
                 *0.25;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.25;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"LfP_2050")
                 *0.25;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"%Scenario%")
         = 0;



*yields: apply yield gap:
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*convent yields:
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Convent",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


*no grassland yield data for 2050, so use 2012 - but we run the FOFA_BAU_2050 anyway before we can run this scenario that depends on it, so use the values from there, which are the same:
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2050");
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2050");


*assign a number of parameters used to derive animal numbers to the FOFA 2050 BAU values (default is the SOLm Baseline)
*Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"LfP_2050");
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*some numbers of animals are zero in 2050 data, such as horses and games - thus assign zero share in total GE req to them:
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         =eps;
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         =eps;

*shares for some commodities are zero here - and are potentially later assigned with non-zero baseline values in the initiaisation code in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms,
*thus also assign eps to these zeroes and then replace the eps with zero again later, in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllPRodSyst",ProductionConditions,"Baseline")
                         AND (NOT FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")))
         =eps;

*assume lower organic grassland yields
ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,COreGrassActivities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline")*0.9;

*allow higher grassland utilization (this captures the increased grazing intensity: +10%):
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")/1.1;
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,GrassCommodities,"Feed DM supply/demand ratio",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,GrassCommodities,"Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")/1.1;

$ontext;
*change util feed share to get the animal numbers in FOFA_2050_BAU right with the baseline supply/demand ratio, etc- this is also no surprise - default util rates are from the baseline, so changes till 2050 are likely, but we do not have data on this
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline") = 1)
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.72;
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"Baseline")
                 + Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.28;
$offtext;



$ontext;
VCommod_Feed_MR.l(NonEU_RestOfTheWorld,Commodities_Feed_Cereals,"Convent",ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(NonEU_RestOfTheWorld,Commodities_Feed_Cereals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050_Test")
                 *0.95;
VCommod_Feed_MR.l(NonEU_RestOfTheWorld,Commodities_Feed_Cereals,"Organic",ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(NonEU_RestOfTheWorld,Commodities_Feed_Cereals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050_Test")
                 *0.05;
VCommod_Feed_MR.l(NonEU_RestOfTheWorld,Commodities_Feed_OilCropsAndCakes,"Convent",ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(NonEU_RestOfTheWorld,Commodities_Feed_OilCropsAndCakes,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050_Test")
                 *0.95;
VCommod_Feed_MR.l(NonEU_RestOfTheWorld,Commodities_Feed_OilCropsAndCakes,"Organic",ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(NonEU_RestOfTheWorld,Commodities_Feed_OilCropsAndCakes,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050_Test")
                 *0.05;
$offtext;


ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VImportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
         = 0.3;
*         = 1;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 0.3;
*         = 1;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(FAO_EuropeanUnion_PlusCH,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 0.3;
*         = 1;
ExportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
         = 0.3;


VPopulationNumbers_MR.l(Regions,PopulationGroups,"%Scenario%")
         = VPopulationNumbers_MR.l(Regions,PopulationGroups,"FOFA_BAU_2050");


*as some commodity variables scale with baseline values: assign them to 100% organic:
VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VImportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VImportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");

VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio",ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio","AllProdSyst",ProductionConditions,"Baseline");

VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"ALlProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"ALlProdSyst",ProductionConditions,"Baseline");



$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*10) "AE_exports_2050"
$label AssumptionsAE_exports_2050
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "YES"

*assign areas: for the EU, we assume 15% organic, for the RoW, we assume 5% organic

*assign areas: for the EU, we assume 15% organic, for the RoW, we assume 5% organic
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.95;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries (only for EU, see below) - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.95;
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.05;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries (only for EU, see below) - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.05;
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.85;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.85;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.85;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.85;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.15;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.15;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.15;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.15;

*and in addition, for the EU, we have 95% organic for Fruits, vegetables, nuts, as these are high-value export products, and we keep the 15% share for the rest:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Fruits,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Fruits,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.05;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Fruits,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Fruits,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.95;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Vegetables,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Vegetables,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.05;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Vegetables,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Vegetables,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.95;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Treenuts,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Treenuts,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.05;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Treenuts,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Treenuts,"AllProdSyst",ProductionConditions,"AE_exports_2050")
                 *0.95;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"%Scenario%")
         = 0;

*yields: apply yield gap:
*and assume 10% lower yields for monogastrics
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")*0.9;

*convent yields:
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Convent",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*als make the conventional monogastrics 10% less efficient, i.e. reduce yields by 10%:
ActAnimalsHead_Outputs_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")*0.9;


*no grassland yield data for 2050, so use 2012 - but we run the FOFA_BAU_2050 anyway before we can run this scenario that depends on it, so use the values from there, which are the same:
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2050");
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2050");

FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*asign a number of parameters used to derive animal numbers to the FOFA 2050 BAU values (default is the SOLm Baseline)
*Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"AE_exports_2050");
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*some numbers of animals are zero in 2050 data, such as horses and games - thus assign zero share in total GE req to them:
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         =eps;
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         =eps;

*shares for some commodities are zero here - and are potentially later assigned with non-zero baseline values in the initiaisation code in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms,
*thus also assign eps to these zeroes and then replace the eps with zero again later, in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")))
         =eps;

*assume lower organic grassland yields
ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,COreGrassActivities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline")*0.9;



$ontext;
*feed ruminants with grass only
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"Baseline")
          = eps;
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"Baseline")
          = eps;
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"Baseline")
          = 1;

FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"Baseline")
         = eps;

FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"Baseline")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"Baseline")
                 *(1 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"Baseline")
                                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"Baseline"));
$offtext;

*for a test, whether it sums to 0 and 1 as it should:
*FeedingRations_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
*         = sum((NonRuminants,AnimalTypeInherd),FeedingRations_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"));
*FeedingRations_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
*         = sum((Ruminants,AnimalTypeInherd),FeedingRations_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"));


****BELOW: NOT NEEDED for the animal numebrs derived with detailed feeding rations!!
*ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                 $ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*         = ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                 *(1 + ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                                 /ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%"));

*change util feed share to get the animal numbers in FOFA_2050_BAU right with the baseline supply/demand ratio, etc- this is also no surprise - default util rates are from the baseline, so changes till 2050 are likely, but we do not have data on this
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                 $(NOT Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline") = 1)
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.72;
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"Baseline")
*                 + Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.28;



ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VImportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
         = 1;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 1;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(FAO_EuropeanUnion_PlusCH,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 1;
ExportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,SET_Fruits_CommodityGroup,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,SET_Fruits_CommodityGroup,"ALlProdSyst",ProductionConditions,"Baseline")
*         = 1.5;
         = 1.2;
ExportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,SET_Vegetables_CommodityGroup,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,SET_Vegetables_CommodityGroup,"ALlProdSyst",ProductionConditions,"Baseline")
*         = 1.5;
         = 1.2;
ExportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,SET_Nuts_CommodityGroup,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,SET_Nuts_CommodityGroup,"ALlProdSyst",ProductionConditions,"Baseline")
*         = 1.5;
         = 1.2;


VPopulationNumbers_MR.l(Regions,PopulationGroups,"%Scenario%")
         = VPopulationNumbers_MR.l(Regions,PopulationGroups,"FOFA_BAU_2050");


*as some commodity variables scale with baseline values: assign them to 100% organic:
VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VImportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VImportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");

VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio",ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio","AllProdSyst",ProductionConditions,"Baseline");

VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"ALlProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"ALlProdSyst",ProductionConditions,"Baseline");


$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*11) "LfS_2050"
$label AssumptionsLfS_2050
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "YES"

*assign areas: for the EU, we assume 25% organic, for the RoW, we assume 5% organic

*assign areas: for the EU, we assume 25% organic, for the RoW, we assume 5% organic
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"LfS_2050")
                 *0.95;
*there is specific data for temporary meadows in the scenarios, but not for permanent meadows (only for EU, see below) - thus use the BAU 2050 for those
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"LfS_2050")
                 *0.95;
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"LfS_2050")
                 *0.05;
*there is specific data for temporary meadows in the scenarios, but not for permanent meadows (only for EU, see below) - thus use the BAU 2050 for those
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"LfS_2050")
                 *0.05;
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"LfS_2050")
                 *0.75;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"LfS_2050")
                 *0.75;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.75;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"LfS_2050")
                 *0.75;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"LfS_2050")
                 *0.25;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"LfS_2050")
                 *0.25;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.25;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"LfS_2050")
                 *0.25;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"%Scenario%")
         = 0;

*yields: apply yield gap:
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*convent yields:
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Convent",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


*no grassland yield data for 2050, so use 2012 - but we run the FOFA_BAU_2050 anyway before we can run this scenario that depends on it, so use the values from there, which are the same:
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2050");
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2050");

FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*asign a number of parameters used to derive animal numbers to the FOFA 2050 BAU values (default is the SOLm Baseline)
*Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"LfS_2050");
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*some numbers of animals are zero in 2050 data, such as horses and games - thus assign zero share in total GE req to them:
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         =eps;
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         =eps;

*shares for some commodities are zero here - and are potentially later assigned with non-zero baseline values in the initiaisation code in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms,
*thus also assign eps to these zeroes and then replace the eps with zero again later, in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")))
         =eps;

*assume lower organic grassland yields
ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,COreGrassActivities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline")*0.9;
*allow lower grassland utilization (this captures the reduced grazing intensity: -10%):
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")/0.9;
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,GrassCommodities,"Feed DM supply/demand ratio",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,GrassCommodities,"Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")/0.9;

*change util feed share to get the animal numbers in FOFA_2050_BAU right with the baseline supply/demand ratio, etc- this is also no surprise - default util rates are from the baseline, so changes till 2050 are likely, but we do not have data on this
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                 $(NOT Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline") = 1)
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.72;
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"Baseline")
*                 + Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.28;

ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VImportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
         = 0.45;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 0.45;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(FAO_EuropeanUnion_PlusCH,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 0.45;
ExportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,"ALlProdSyst",ProductionConditions,"Baseline")
         = 0.45;


VPopulationNumbers_MR.l(Regions,PopulationGroups,"%Scenario%")
         = VPopulationNumbers_MR.l(Regions,PopulationGroups,"FOFA_BAU_2050");



*as some commodity variables scale with baseline values: assign them to 100% organic:
VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VImportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VImportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");

VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio",ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio","AllProdSyst",ProductionConditions,"Baseline");

VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"ALlProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"ALlProdSyst",ProductionConditions,"Baseline");


$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*12) "AE_food_2050"
$label AssumptionsAE_food_2050
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "YES"

*assign areas: for the EU, we assume 50% organic, for the RoW, we assume 5% organic

*assign areas: for the EU, we assume 50% organic, for the RoW, we assume 5% organic
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
                 *0.95;
*there is specific data for temporary meadows in the scenarios, but not for permanent meadows (only EU, see below) - thus use the BAU 2050 for those
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
                 *0.95;
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
                 *0.05;
*there is specific data for temporary meadows in the scenarios, but not for permanent meadows (only EU, see below) - thus use the BAU 2050 for those
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
                 *0.05;
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
                 *0.5;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"AE_food_2050")
                 *0.5;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.5;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
                 *0.5;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
                 *0.5;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"AE_food_2050")
                 *0.5;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.5;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
                 *0.5;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"%Scenario%")
         = 0;

*yields: apply yield gap:
*and assume 10% lower yields for monogastrics
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")*0.9;

*als make the conventional monogastrics 10% less efficient, i.e. reduce yields by 10%:
ActAnimalsHead_Outputs_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")*0.9;

*convent yields:
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Convent",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*no grassland yield data for 2050, so use 2012 - but we run the FOFA_BAU_2050 anyway before we can run this scenario that depends on it, so use the values from there, which are the same:
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2050");
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2050");

FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"AE_food_2050");
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*some numbers of animals are zero in 2050 data, such as horses and games - thus assign zero share in total GE req to them:
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         =eps;
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         =eps;

*shares for some commodities are zero here - and are potentially later assigned with non-zero baseline values in the initiaisation code in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms,
*thus also assign eps to these zeroes and then replace the eps with zero again later, in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")))
         =eps;

*asign a number of parameters used to derive animal numbers to the FOFA 2050 BAU values (default is the SOLm Baseline)
*Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");




*assume lower organic grassland yields
ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,COreGrassActivities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline")*0.9;

*allow lower grassland utilization (this captures the reduced grazing intensity: -20%):
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")/0.8;
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,GrassCommodities,"Feed DM supply/demand ratio",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,GrassCommodities,"Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")/0.8;


$ontext;
*feed ruminants with grass only
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"Baseline")
          = eps;
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"Baseline")
          = eps;
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"Baseline")
          = 1;

FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"Baseline")
         = eps;

FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"Baseline")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"Baseline")
                 *(1 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"Baseline")
                                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"Baseline"));
$offtext;

*for a test, whether it sums to 0 and 1 as it should:
FeedingRations_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),FeedingRations_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"));
FeedingRations_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),FeedingRations_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"));

*NOT NEEDED ANYMORE - the above is correct
$ontext;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc","AllProdSyst",ProductionConditions,"Baseline")
         = eps;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage","AllProdSyst",ProductionConditions,"Baseline")
         = eps;
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 *(1 + ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProdSyst_OrgCon,ProductionConditions,"%Scenario%"));
$offtext;

*change util feed share to get the animal numbers in FOFA_2050_BAU right with the baseline supply/demand ratio, etc- this is also no surprise - default util rates are from the baseline, so changes till 2050 are likely, but we do not have data on this
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                 $(NOT Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline") = 1)
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.72;
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"Baseline")
*                 + Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.28;



ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VImportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
         = 0.3;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 0.3;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(FAO_EuropeanUnion_PlusCH,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 0.3;
ExportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,"ALlProdSyst",ProductionConditions,"Baseline")
         = 0.3;


VPopulationNumbers_MR.l(Regions,PopulationGroups,"%Scenario%")
         = VPopulationNumbers_MR.l(Regions,PopulationGroups,"FOFA_BAU_2050");




*as some commodity variables scale with baseline values: assign them to 100% organic:
VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VImportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VImportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");

VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio",ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio","AllProdSyst",ProductionConditions,"Baseline");

VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"ALlProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"ALlProdSyst",ProductionConditions,"Baseline");




$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*12a) "UNISECO_AF_shM_compM_yL_cM_5" and other AF scenarios
$label AssumptionsUNISECO_AF
PUTCLOSE con,"Current scenario: %Scenario%";


$setglobal UseProdSyst_ConvOrg "YES"

$setglobal UseReference2050 "YES"

$setglobal UseBenke "YES"


*this scenario builds on the UNISECO-scenario AE_food_2050, described in detail in UNISECO-Deliverable D4.2

*there are a number of sensitivity analyes within this scenario, captured by different parameter choices (see deliverable D4.3);
*as this results in have 104 scenarios, we define a separate module to switch on the relevant parameter values for each scenario, and execute this module before going into the specific scenario specification below.
*furthermore, we need a number of parameters and sets for the sensitivity analysis, as well as for the general agroforestry part,
*        which are defined here for the default AF UNISECO scenario, then they are available for the others as well (and this would cause error messages if redefined for each again, hence this separate part at the beginning)

$ontext;
*the UNISECO AF scenarios are differentiated by 5 parameters:
         1) %WW% share AF                     -       medium/low/high coded as M/L/H
         2) %XX% compnent shares crops/trees  -       medium/low/high coded as M/L/H
         3) %YY% AF yields                    -       low/high coded as L/H
         4) %CC% C sequestration              -       medium/low/high coded as M/L/H
         5) %RR% organic share outside the EU -       5% / 25% coded as 5/25

*thus name the scenarios as follows:
UNISECO_AF_sh%WW%_comp%XX%_y%YY%_c%CC%_%RR% e.g. UNISECO_AF_shM_compM_yL_cM_5 is the default AF scenario for UNISECO

all these scenarios are already part in the genreal set Scenarios
$offtext;

*specification needed for each block of scenarios, hence the changes in these assessments:
$if NOT %Scenario% == "UNISECO_AF_shM_compM_yL_cM_5" $goto CoreUNISECO_AF_ScenarioSpecifications
*$if NOT %Scenario% == "UNISECO_AF_shM_compM_yH_cM_5" $goto CoreUNISECO_AF_ScenarioSpecifications
*$if NOT %Scenario% == "UNISECO_AF_shM_compM_yL_cM_25" $goto CoreUNISECO_AF_ScenarioSpecifications
*$if NOT %Scenario% == "UNISECO_AF_shM_compM_yH_cM_25" $goto CoreUNISECO_AF_ScenarioSpecifications

*new parameters and sets needed for the AF scenarios:
Parameter AgroF_AreaShares(Regions,Activities,Activities_2,ProductionSystems,Scenarios) Share AF areas in total areas - AF with crop-part Activities and tree-part Activities_2;
Parameter AgroF_CropComponentShares(Regions,Activities,Activities_2,ProductionSystems,Scenarios) Share of crop component of an AE system per ha (crop-part Activities and tree-part Activities_2);
Parameter AgroF_TreeComponentShares(Regions,Activities,Activities_2,ProductionSystems,Scenarios) Share of tree component of an AE system per ha (crop-part Activities and tree-part Activities_2);
Parameter AgroF_CropYieldFactor(Regions,Activities,Activities_2,ProductionSystems,Scenarios) crop component yield correction factor for AF in relation to monocultures (crop-part Activities and tree-part Activities_2);
Parameter AgroF_TreeYieldFactor(Regions,Activities,Activities_2,ProductionSystems,Scenarios) tree component yield correction factor for AF in relation to monocultures (crop-part Activities and tree-part Activities_2);

*Parameters for sensitivity analysis
Parameters
AF_UNISECO_SensitivityFactor_AreaShares(ProductionSystems,Scenarios)

AF_UNISECO_SensitivityFactor_CropComponentShares(Regions,Activities,Activities_2,Scenarios)
AF_UNISECO_SensitivityFactor_TreeComponentShares(Regions,Activities,Activities_2,Scenarios)

AF_UNISECO_SensitivityFactor_CropYieldFactor(Regions,Activities,Activities_2,Scenarios)
AF_UNISECO_SensitivityFactor_TreeYieldFactor(Regions,Activities,Activities_2,Scenarios)

AF_UNISECO_SensitivityFactor_CInWoodyBiomass(Regions,Activities,Activities_2,Scenarios)

*OrganicAreaShare(Regions,Activities,ProductionConditions,Scenarios)
;

PARAMETER NumberOfAgroforestryTreePartActivities(Regions,ProductionSystems,ProductionConditions,Scenarios);

Parameter AUX_Denominator1_ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
Parameter AUX_Denominator2_ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios);

*activities available for the tree part of agroforestry
*fruit trees and treenuts, etc.
*and specially for AF:
*"agrof. trees: feed"
*"non-food agrof. trees"
*"All agrof. trees"

*first we need a set of the activites that may be used for the tree part in agroforestry - in EUROPE (hence no coconuts and bananas): to be generalised later and also to be included in the general sets definitions in steering file 1:
*the restriction to EUROPEAN trees could be dropped, as we assign tree activities conditional to having areas present (which is also needed to avoid having oranges in Sweden).


$ontext;
Set TreePartActivities_Agroforestry_EUROPE(Activities)
/
"Fruit, citrus nes"
"Lemons and limes"
Oranges
"Tangerines, mandarins, clementines, satsumas"
"Fruit, pome nes"
Pears
Quinces
Apricots
Cherries
"Peaches and nectarines"
"Plums and sloes"
"Cherries, Sour"
"Fruit, stone nes"
Apples
Avocados
Carobs
Dates
Figs
"Grapefruit (inc. pomelos)"
"Almonds, with shell"
Chestnut
"Hazelnuts, with shell"
"Nuts, nes"
Pistachios
"Walnuts, with shell"
Olives
"agrof. trees: feed"
"non-food agrof. trees"
*"All agrof. trees"
/;

Set CropPartActivities_Agroforestry_EUROPE(Activities);
CropPartActivities_Agroforestry_EUROPE(Activities) = CropsAndCoreGrassActivities(Activities) - TreePartActivities_Agroforestry_EUROPE(Activities);
Set CropPartActivities_Agroforestry_EUROPE_NoGrass(Activities);
CropPartActivities_Agroforestry_EUROPE_NoGrass(Activities) = Crops(Activities) - TreePartActivities_Agroforestry_EUROPE(Activities);

Set EU_Continental_PlusCH(Regions)
/
Bulgaria
Hungary
Czechia
Poland
Romania
Slovakia
Estonia
Finland
Latvia
Lithuania
Sweden
Austria
Germany
Switzerland
/;
Set EU_Mediterranean(Regions)
/
Cyprus
Greece
Croatia
Italy
Malta
Portugal
Spain
Slovenia
/;
Set EU_Atlantic(Regions)
/
Denmark
France
"United Kingdom"
Netherlands
Belgium
Luxembourg
Ireland
/;
$offtext;


$label CoreUNISECO_AF_ScenarioSpecifications

$include _V6_ScenarioSpecifications_AuxUNISECO_AF



*assign areas: basic scenario: for the EU, we assume 50% agroecological areas, i.e. 25% organic plus 25% Agroforestry (i.e. both: agroecology, total 50% (and 25% AF also applies to organic areas)), for the RoW, we assume 5% organic

*5% organic outside the EU only results in lower imports of organic feed from abroad, thus organic monogastric animals are much less than a third of conventional only, due to much lower organic feed supply
*assuming 25% organic globally results in correspondingly higher numbers, and organic animal numnbers are about 25% of conventional ones: this fits with 25% organic, (i.e. a third of conventional 75%) areas, and anbout 80% lower yields, thus organic production is about a fourth of conventional prod.


*BELOW: SImplify - we improved and now only the first general assessment is needed - nothing special for grass and forage,etc. - check this!!


VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.95;
                 *(1 - OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%"));
*there is specific data for temporary meadows in the scenarios, but not for permanent meadows (only EU, see below) - thus use the BAU 2050 for those
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.95;
                 *(1 - OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.95;
                 *(1 - OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%"));
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.95;
                 *(1 - OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%"));
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.95;
                 *(1 - OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%"));

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.05;
                 *OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%");
*there is specific data for temporary meadows in the scenarios, but not for permanent meadows (only EU, see below) - thus use the BAU 2050 for those
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.05;
                 *OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%");
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.05;
                 *OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%");
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.05;
                 *OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%");
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.05;
                 *OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%");

*ABOVE: SImplify - we improved and now only the first general assessment is needed - nothing special for grass and forage,etc. - check this!!

*25% organic in the EU
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.75;
                 *(1 - OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%"));
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.75;
                 *(1 - OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%"));
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.75;
                 *(1 - OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%"));
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.75;
                 *(1 - OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%"));
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Organic",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.25;
                 *OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%");
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.25;
                 *OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%");
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.25;
                 *OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%");
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *0.25;
                 *OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%");

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"%Scenario%")
         = 0;



*adjust legume area shares on organic areas in case they are less than 25% in total:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         =sum(Legumes_NFixing,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,ProductionSystems,ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         =sum(Crops_NoNFixingLegumes,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,ProductionSystems,ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"FOFA_BAU_2050"));
ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*factor OrganicAreaShare: as we generally have a share of OrganicAreaShare of areas under organic managemnt, this rearrangement of crop types applies to this area share only
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"Organic",ProductionConditions,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") < 0.25))
*         = 0.25*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = OrganicAreaShare(Regions_MR,"All crops and grass","AllProdCond","%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *0.25
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"Organic",ProductionConditions,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") < 0.25))
*         = 0.75*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = (1 - OrganicAreaShare(Regions_MR,"All crops and grass","AllProdCond","%Scenario%"))
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *0.25
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


*yields: apply yield gap (half the organic yield gap for agroecology, hence the formulae: A*x --> A*(x + (1-x)/2) = A*(1+x)/2):
*and assume 10% lower yields for monogastrics
*NO - as done here, we have 25% organic, 25% AF - thus do organic yields and for AF, yields are derived further down.
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
*                 *(1+ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline"))/2;
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
*                 *(1+ActAnimalsHead_OtherChar_MR(Regions,Activities,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline"))/2;
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
*                 *(1+ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline"))/2;
ActAnimalsHead_Outputs_MR(Regions,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")*0.9;

*als make the conventional monogastrics 10% less efficient, i.e. reduce yields by 10%:
ActAnimalsHead_Outputs_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")*0.9;



*convent yields:
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Convent",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


*no grassland yield data for 2050, so use 2012 - but we run the FOFA_BAU_2050 anyway before we can run this scenario that depends on it, so use the values from there, which are the same:
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2050");
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2050");


*crop residues management system: there is some organic data available:
*CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                 $CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,ProdSyst_OrgCon,ProductionConditions,"Baseline")
*         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system",CropResManSystem,ProdSyst_OrgCon,ProductionConditions,"Baseline");



FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*         = FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"AE_food_2050");
         = FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*some numbers of animals are zero in 2050 data, such as horses and games - thus assign zero share in total GE req to them:
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         =eps;
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         =eps;

*shares for some commodities are zero here - and are potentially later assigned with non-zero baseline values in the initiaisation code in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms,
*thus also assign eps to these zeroes and then replace the eps with zero again later, in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")))
         =eps;
*ABOVE: FOFA_BAU_2050 and not Baseline? But it works with the latter, but would be more consistent to use the former - to be checked.


*asign a number of parameters used to derive animal numbers to the FOFA 2050 BAU values (default is the SOLm Baseline)
*Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


*assume lower organic grassland yields
ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,COreGrassActivities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline")*0.9;

*allow lower grassland utilization (this captures the reduced grazing intensity: -20%):
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")/0.8;
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,GrassCommodities,"Feed DM supply/demand ratio",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,GrassCommodities,"Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")/0.8;




*$ontext;
*feed ruminants with grass only
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
          = eps;
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
          = eps;

FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         =sum(Commodities_Feed_Grass,FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));

FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
          = FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 /FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = eps;

FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*$offtext;

*Reduction in the areas of crops that have been grown for concentrate feed by the amount not needed anymore for ruminants:
*set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateCommodities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateActivities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_WellDefinedCoProducts_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_ComplexCases_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

*forage crops and other forage crops need to be done specifically, as not included above, where the focus is on Main and byprod Concentrates, not forage:

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,ForageCrops,"MainOutput1 (t)"),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,OtherFodderCrops,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,OtherFodderCrops,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,OtherFodderCrops,"MainOutput1 (t)"),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

*adjust triticale - to be done separately, as there is no ruminat share factor, thus use the one from Wheat and products and util feed share = 1:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes","Wheat and products","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));

*if such occur: set negative values = 0:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*crop the areas that became free for alternative use due to feed production reduction with food crops with the same shares as in the reference scenario:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"All crops and grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CropsAndCoreGrassActivities,VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropsAndCoreGrassActivities,ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdSyst",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"All crops and grass","Convent",ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"All crops and grass","Organic",ProductionConditions,"%Scenario%");

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = sum(CropsAndCoreGrassActivities,VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropsAndCoreGrassActivities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Core food crops","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = sum(CoreFoodCrops,VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CoreFoodCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Core food crops - no cereals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = sum(CoreFoodCrops_NoCereals,VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CoreFoodCrops_NoCereals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Alternative use","AllProdSyst",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 - VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdSyst",ProductionConditions,"%Scenario%");
*delete negative values if such occur (which should not be the case, but to avoid artefacts from incomplete data, e.g. for small island states, etc.):
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Alternative use",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Alternative use",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Alternative use","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Alternative use","AllProdSyst",ProductionConditions,"%Scenario%")
                 *(1 - OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%"));
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Alternative use","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Alternative use","AllProdSyst",ProductionConditions,"%Scenario%")
                 *OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%");


VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CoreFoodCrops_NoCereals,ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Core food crops - no cereals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CoreFoodCrops_NoCereals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Alternative use",ProductionSystems,ProductionConditions,"%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CoreFoodCrops_NoCereals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 /VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Core food crops - no cereals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


*adjust imports accordingly: i.e. reduce imports by the same factor as produciton was reduced above, due to lower feed use for ruminants:
*feed is from DAQ, thus, reducing the feed part from DAQ translates in a corresponding reduction of products AND imports
*formally, this is done via the ImportScaleFactor:
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VImportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities_MR,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = (1 - Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*         = 1;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,"World",Commodities_MR,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = (1 - Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*         = 1;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(FAO_EuropeanUnion_PlusCH,Commodities_MR,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = (1 - Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*         = 1;
*NO CHANGE IN export scale factor, though:
*ExportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                 $VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")
*         = 1;

*if such occurr: set negative values = 0:
ImportScaleFactor_MR(Regions,Regions_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(ImportScaleFactor_MR(Regions,Regions_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*Finally, also adapt the utilization shares: if from a quantity X of a commodity, a share a is used for feed, (1-a) for all other uses, and from this share a, a share r was used for ruminants,
*then after reducing the quantity for ruminants to zero, the utilization shares look as follows:
*                                                                                                                                                                                          a(1-r)        1 - a
*the new quantity is X(1-ra); the new quantity used for feed is Xa(1-r), the new utilization share for feed is thus Xa(1-r)/[X(1-ra)] = a(1-r)/(1-ra), the share for all other uses is 1- --------- = ------------
*                                                                                                                                                                                          1 - ra       1 - ra
*thus, the utilization share for feed is a(1-r)/(1-ra) and the utilization share for any other use, with original utilization share b is b/(1-ra):
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(1 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                         *Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
                         /(1 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                         *Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*all besides feed:
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,UtilSharesNOTFeed,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(1 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,UtilSharesNOTFeed,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 /(1 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));





$ontext;
XXXX

*feed ruminants with grass only, NonRuminants with non-forage, i.e. byproducts only
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 1;

FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 1;
FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;

ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 + ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));


ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 + ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));




XXXX
$offtext ;




*change util feed share to get the animal numbers in FOFA_2050_BAU right with the baseline supply/demand ratio, etc- this is also no surprise - default util rates are from the baseline, so changes till 2050 are likely, but we do not have data on this
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                 $(NOT Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline") = 1)
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.72;
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"Baseline")
*                 + Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.28;


*$ontext;
*generally, the underlying scenario AE_food_2050 assumes considerable reductions in trade; thus, reduce trade accordingly, conditional to not yet being reduced enough due to the feed reduction done above:
*this results in further reductions of feed imports, and thus even lower monogasttric animal numbers.
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VImportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%") > 0.3))
         = 0.3;
*         = 0.5;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,"World",Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 0.3;
*         = 0.5;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(FAO_EuropeanUnion_PlusCH,Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 0.3;
*         = 0.5;
*to avoid huge DAQs and thus food for commodities that are largely exported from the EU, we keep the exports similar to the reference FOFA BAU 2050
ExportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,"ALlProdSyst",ProductionConditions,"FOFA_BAU_2050")
*         = 1;
*         = 0.3;
*         = 0.75;
         = 0.5;
*$offtext;


*further adjust utilization rates and areas:
*the adjustment above only accounts for no concentrate feed to ruminants, but the AE_food_2050 scenario which is the basis for these Agroforestry scenarios from UNISECO (cf. above, beginning of AF scenario specification) goes along with generally reduced animal source food consumption.
*thus reduce feed supply even more, for all animals;
*thus reduce feed utilization as derived above by another 30% (for all crops - that have food util share > 0.1, see next line) and add to food util share
*        this is done only for food-util >0.1, otherwise it results in huge biases (e.g. due to very low food util of Barley and Products in 2050 (less than 0.001), which when changing as below blows up food supply (via beer!!) like mad).
*finally, the areas are adjusted accodringly: less feed areas and resdistribution of these areas to produce food (all crops besides
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%") > 0.1)
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 *0.7;
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%") > 0.1)
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 + Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                         *(1 - 0.7);

*and reduce feed crop areas similarly by 30%
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
                 *0.7;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%")
                 *0.7;
*and also add to core food crops besides cereals:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CoreFoodCrops_NoCereals,ProductionSystems,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Core food crops - no cereals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CoreFoodCrops_NoCereals,ProductionSystems,ProductionConditions,"%Scenario%")
                 + (sum(ForageCrops,VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%"))
                         +VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%"))
                                 /0.7*0.3
                                         *VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CoreFoodCrops_NoCereals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                                 /VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Core food crops - no cereals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");



VPopulationNumbers_MR.l(Regions,PopulationGroups,"%Scenario%")
         = VPopulationNumbers_MR.l(Regions,PopulationGroups,"FOFA_BAU_2050");




*as some commodity variables scale with FOFA_BAU_2050 values: assign them to 100% organic:
VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
VImportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VImportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio",ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"ALlProdSyst",ProductionConditions,"FOFA_BAU_2050");

AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


*add agroforestry parts:
*values used for AF are taken from the literature review summarized in the sheet "Agroforestry" in the file Implementation of Innovations in BioBaM 18112020_Agroforestry.xlsx or in deliverable D4.3 from UNISECO, section 3.3.1
*we implement agroforestry by adjusting yields and areas of the activities already available as described in the SOLm model documentation, chapter on Agroforestry, and not by adding new activities or production conditions or production systems


*assume share of AF in ALL systems, i.e. organic (as a placeholder for agroec) AND conventional
*thereby: 25% of organic area shall be AF, and a third of conventional (which, as convent is 75% is then 2%5 of total area; see also description in UNISECO D4.3)

*to be added later: specify the tree parts and do not use a general agroforestry system only for each crop, as it is done now.
*to do this, we would replace "All agrof. trees" by TreePartActivities_Agroforestry_EUROPE and assign specific values,
*                                                        this has then also to be done below, where AgroF_AreaShares is used, currently with "All agrof. trees", but then with TreePartActivities_Agroforestry_EUROPE - and with summing over this set, if needed (and if not already done)

*when no specification of the crop or/and tree part is needed, then use "All crops" and "All agrof. Trees" as elements of activities and activities_2:
*      then, the assignment of the total shares is ok
*        /28 is division by the number of elements in TreePartActivities_Agroforestry_EUROPE, as these parameters are used in relation to single tree activities below, thus each applies to the share of this single activity only;
*        and without further specification, this share is thus just the total (0.25) divided by the numbe rof elements that build all possible tree activities in TreePartActivities_Agroforestry_EUROPE, i.e. 28
*      if different trees are addressed separately, then the total share needs to be assigned per tree type, if, e.g. all are treated similarly, this means 0.25/28 to each element of TreePartActivities_Agroforestry_EUROPE instead of to the general element only

$ontext;
OLD CODE: using all AF trees in all countries - better code below, where only the trees already present in a country are used (thus avoiding having Olives in Sweden....)
AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"All agrof. trees","Organic","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"Organic","AllProdCond","%Scenario%")
         = 0.25/28;
AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,"All Crops","All agrof. trees","Organic","%Scenario%")
         = 0.25/28;

AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"All agrof. trees","Convent","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"Convent","AllProdCond","%Scenario%")
         = 0.3333333333333/28;
AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,"All Crops","All agrof. trees","Convent","%Scenario%")
         = 0.3333333333333/28;
$offtext;


*the area shares in AF are to be assigned to all crops and trees that grow in each country, to avoid having oranges in Sweden.
*For this, we need some specific code that counts the Tree activity elements present in a country and then uses this number to divide the share by.
*Hence the code below with the Numberof... parameter, etc. - the parameter is defined further up.

NumberOfAgroforestryTreePartActivities(FAO_EuropeanUnion_PlusCH,ProductionSystems,ProductionConditions,"%Scenario%")
         = SUM(TreePartActivities_Agroforestry_EUROPE$VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,ProductionConditions,"%Scenario%"),1);

AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,"Organic","%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"Organic","AllProdCond","%Scenario%")
                         AND VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,"Organic","AllProdCond","%Scenario%")
                         AND NumberOfAgroforestryTreePartActivities(FAO_EuropeanUnion_PlusCH,"Organic","AllProdCond","%Scenario%"))
*         = 0.25/NumberOfAgroforestryTreePartActivities(FAO_EuropeanUnion_PlusCH,"Organic","AllProdCond","%Scenario%");
         = AF_UNISECO_SensitivityFactor_AreaShares("Organic","%Scenario%")/NumberOfAgroforestryTreePartActivities(FAO_EuropeanUnion_PlusCH,"Organic","AllProdCond","%Scenario%");
AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,"Convent","%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"Convent","AllProdCond","%Scenario%")
                         AND VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,"Convent","AllProdCond","%Scenario%")
                         AND NumberOfAgroforestryTreePartActivities(FAO_EuropeanUnion_PlusCH,"Convent","AllProdCond","%Scenario%"))
*         = 0.3333333333333/NumberOfAgroforestryTreePartActivities(FAO_EuropeanUnion_PlusCH,"Convent","AllProdCond","%Scenario%");
         = AF_UNISECO_SensitivityFactor_AreaShares("Convent","%Scenario%")/NumberOfAgroforestryTreePartActivities(FAO_EuropeanUnion_PlusCH,"Convent","AllProdCond","%Scenario%");



*For the water footprint, etc. below, we need the "ALL crops" and also the "All agrof. trees" data - so keep those.
*as these refer to the sum over all AF trees, we do not need the division by the number of AF tree activities

AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"All agrof. trees","Organic","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"Organic","AllProdCond","%Scenario%")
*         = 0.25;
         = AF_UNISECO_SensitivityFactor_AreaShares("Organic","%Scenario%");
AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,"All Crops","All agrof. trees","Organic","%Scenario%")
*         = 0.25;
         = AF_UNISECO_SensitivityFactor_AreaShares("Organic","%Scenario%");

AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"All agrof. trees","Convent","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"Convent","AllProdCond","%Scenario%")
*         = 0.3333333333333;
         = AF_UNISECO_SensitivityFactor_AreaShares("Convent","%Scenario%");
AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,"All Crops","All agrof. trees","Convent","%Scenario%")
*         = 0.3333333333333;
         = AF_UNISECO_SensitivityFactor_AreaShares("Convent","%Scenario%");


*values according to table 11 in UNISECO deliverable D4.3:
*mediterranean is: see below
*atlantic is: see below
*continental is: see below

AgroF_CropComponentShares(EU_Mediterranean,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(EU_Mediterranean,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 0.94;
         = AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Mediterranean,"All crops and grass","All agrof. trees","%Scenario%");
AgroF_TreeComponentShares(EU_Mediterranean,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $AgroF_CropComponentShares(EU_Mediterranean,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
*         = 0.06;
         = AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Mediterranean,"All crops and grass","All agrof. trees","%Scenario%");
AgroF_CropComponentShares(EU_Atlantic,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(EU_Atlantic,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 0.85;
         = AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Atlantic,"All crops and grass","All agrof. trees","%Scenario%");
AgroF_TreeComponentShares(EU_Atlantic,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $AgroF_CropComponentShares(EU_Atlantic,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
*         = 0.15;
         = AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Atlantic,"All crops and grass","All agrof. trees","%Scenario%");
AgroF_CropComponentShares(EU_Continental_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(EU_Continental_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 0.9;
         = AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Continental_PlusCH,"All crops","All agrof. trees","%Scenario%");
AgroF_CropComponentShares(EU_Continental_PlusCH,CoreGrassActivities,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(EU_Continental_PlusCH,CoreGrassActivities,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 0.85;
         = AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Continental_PlusCH,"Grass","All agrof. trees","%Scenario%");
AgroF_TreeComponentShares(EU_Continental_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $AgroF_CropComponentShares(EU_Continental_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
*         = 0.1;
         = AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Continental_PlusCH,"All crops","All agrof. trees","%Scenario%");
AgroF_TreeComponentShares(EU_Continental_PlusCH,CoreGrassActivities,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $AgroF_CropComponentShares(EU_Continental_PlusCH,CoreGrassActivities,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
*         = 0.15;
         = AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Continental_PlusCH,"Grass","All agrof. trees","%Scenario%");

*values according to table 10 in UNISECO deliverable D4.3:
*crop yield
AgroF_CropYieldFactor(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 0.85;
         = AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","All agrof. trees","%Scenario%");
AgroF_CropYieldFactor(FAO_EuropeanUnion_PlusCH,Cereals,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Cereals,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 0.7;
         = AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All cereals","All agrof. trees","%Scenario%");
AgroF_CropYieldFactor(FAO_EuropeanUnion_PlusCH,StarchyRoots,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,StarchyRoots,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 0.6;
         = AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All starchy roots","All agrof. trees","%Scenario%");
AgroF_CropYieldFactor(FAO_EuropeanUnion_PlusCH,ForageCrops,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 0.95;
         = AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All Forage crops","All agrof. trees","%Scenario%");
AgroF_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"Maize for Forage+Silage",TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Maize for Forage+Silage",ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 0.5;
         = AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"Maize for Forage+Silage","All agrof. trees","%Scenario%");
AgroF_CropYieldFactor(FAO_EuropeanUnion_PlusCH,Vegetables,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Vegetables,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 1;
         = AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All vegetables","All agrof. trees","%Scenario%");
*tree yield
AgroF_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 0.85;
         = AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","All agrof. trees","%Scenario%");
AgroF_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"Olives",ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 0.75;
         = AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Olives","%Scenario%");
AgroF_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"Apples",ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 1;
         = AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Apples","%Scenario%");
AgroF_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"Pears",ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 1;
         = AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Pears","%Scenario%");
AgroF_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"Quinces",ProdSyst_OrgConAll,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgConAll,"AllProdCond","%Scenario%")
*         = 1;
         = AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Quinces","%Scenario%");



*derive crop yield with agroforestry (AF)
*for the derivation of these formulae, see the Model Documentation, specific part on agroforestry
*For this, we need some auxiliary parameters, which are defined above and assigned here

AUX_Denominator1_ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = (1 + sum(TreePartActivities_Agroforestry_EUROPE,
*                                 (AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"All agrof. trees",ProductionSystems,"%Scenario%")
                                 (AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,"%Scenario%")
                                         *(AgroF_CropComponentShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,"%Scenario%") - 1))));

*then derive the yields of the crop part
ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_Denominator1_ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 + sum(TreePartActivities_Agroforestry_EUROPE,
*                                 (AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"All agrof. trees",ProductionSystems,"%Scenario%")
                                 (AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,"%Scenario%")
                                         *(AgroF_CropComponentShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,"%Scenario%")
                                                 *AgroF_CropYieldFactor(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,"%Scenario%") - 1))))
         /AUX_Denominator1_ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%");



*derive tree yield with AF
AUX_Denominator2_ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = (VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,ProductionConditions,"%Scenario%")
                 + sum(CropPartActivities_Agroforestry_EUROPE,
*                                 (AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"All agrof. trees",ProductionSystems,"%Scenario%")
                                 (AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,"%Scenario%")
                                         *VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProductionSystems,ProductionConditions,"%Scenario%")
                                         *(1 - AgroF_CropComponentShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,"%Scenario%")))));


ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $AUX_Denominator2_ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,ProductionConditions,"%Scenario%")
                         + sum(CropPartActivities_Agroforestry_EUROPE,
*                                 (AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"All agrof. trees",ProductionSystems,"%Scenario%")
                                 (AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,"%Scenario%")
                                         *VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProductionSystems,ProductionConditions,"%Scenario%")
                                         *(1 - AgroF_CropComponentShares(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,"%Scenario%"))
                                                         *AgroF_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,"%Scenario%"))))
                  /AUX_Denominator2_ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%");



*adjust areas of crops and trees:
*for the derivation of these formulae, see the Model Documentation, specific part on agroforestry
*the areas are the auxiliary parameters defined above for trees, and this auxiliary for crops, multiplied by the crop area:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,ProductionSystems,ProductionConditions,"%Scenario%")
         = AUX_Denominator2_ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,TreePartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%");

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProductionSystems,ProductionConditions,"%Scenario%")
                 *AUX_Denominator1_ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,CropPartActivities_Agroforestry_EUROPE,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%");


*adjust water footprints:
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Blue Water Footprint per t MainOutput1 (m3)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Blue Water Footprint per t MainOutput1 (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Blue Water Footprint per t MainOutput1 (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.66;
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Blue Water Footprint per t MainOutput1 (m3)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Blue Water Footprint per t MainOutput1 (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Blue Water Footprint per t MainOutput1 (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.23;
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Green Water Footprint per t MainOutput1 (m3)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Green Water Footprint per t MainOutput1 (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Green Water Footprint per t MainOutput1 (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.66;
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Green Water Footprint per t MainOutput1 (m3)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Green Water Footprint per t MainOutput1 (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Green Water Footprint per t MainOutput1 (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.23;

*per ha values are derived from the above in DeriveTotalImpacts anyway, thus do not assign here:
$ontext;
ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Blue Water Footprint (m3)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Blue Water Footprint (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Blue Water Footprint (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.66;
ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Blue Water Footprint (m3)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Blue Water Footprint (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Blue Water Footprint (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.23;
ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Green Water Footprint (m3)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Green Water Footprint (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Green Water Footprint (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.66;
ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Green Water Footprint (m3)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Green Water Footprint (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Green Water Footprint (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.23;
$offtext;


ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"IrrigW per t MOutput1 (m3) - total demand",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"IrrigW per t MOutput1 (m3) - total demand","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"IrrigW per t MOutput1 (m3) - total demand","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.66;
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"IrrigW per t MOutput1 (m3) - total demand",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"IrrigW per t MOutput1 (m3) - total demand","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"IrrigW per t MOutput1 (m3) - total demand","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.23;
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.66;
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.23;


*per ha values are derived from the above in DeriveTotalImpacts anyway, thus do not assign here:
$ontext;
ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Irrigation water (m3)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Irrigation water (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Irrigation water (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.66;
ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Irrigation water (m3)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Irrigation water (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Irrigation water (m3)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.23;
ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Irrigation water (m3) - water stress adjusted",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Irrigation water (m3) - water stress adjusted","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,Crops,"Irrigation water (m3) - water stress adjusted","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.66;
ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Irrigation water (m3) - water stress adjusted",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Irrigation water (m3) - water stress adjusted","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_Inputs_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Irrigation water (m3) - water stress adjusted","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.23;
$offtext;


*adjust N and P runoff:
MinFertApplication_MR(FAO_EuropeanUnion_PlusCH,Crops,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = MinFertApplication_MR(FAO_EuropeanUnion_PlusCH,Crops,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + MinFertApplication_MR(FAO_EuropeanUnion_PlusCH,Crops,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.44;
MinFertApplication_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = MinFertApplication_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + MinFertApplication_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"mineral N fert (N)","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.45;

CropResAndBiomassApplication_MR(FAO_EuropeanUnion_PlusCH,Crops,"All Residues","Leached N as percentage of fertilizer N applied (%)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = CropResAndBiomassApplication_MR(FAO_EuropeanUnion_PlusCH,Crops,"All Residues","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + CropResAndBiomassApplication_MR(FAO_EuropeanUnion_PlusCH,Crops,"All Residues","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.44;
CropResAndBiomassApplication_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All Residues","Leached N as percentage of fertilizer N applied (%)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = CropResAndBiomassApplication_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All Residues","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + CropResAndBiomassApplication_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All Residues","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.45;

ManureApplication_MR(FAO_EuropeanUnion_PlusCH,"All crops","All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ManureApplication_MR(FAO_EuropeanUnion_PlusCH,"All crops","All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,"All Crops","All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ManureApplication_MR(FAO_EuropeanUnion_PlusCH,"All crops","All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,"All Crops","All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.44;
ManureApplication_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ManureApplication_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ManureApplication_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All animals","AllAndAverageTypes","Leached N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.45;

*P runoff from fertilizer application, resp. via erosion: not yet covered in SOLm

*soil erosion
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Soil water erosion (t soil lost)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Soil water erosion (t soil lost)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Soil water erosion (t soil lost)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.29;
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Soil water erosion (t soil lost)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Soil water erosion (t soil lost)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Soil water erosion (t soil lost)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.25;

*pesticide use index
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Aggreg. Pest. use level (index)","Convent",ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Aggreg. Pest. use level (index)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees","Convent","%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Crops,"Aggreg. Pest. use level (index)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Crops,"All agrof. trees","Convent","%Scenario%")*0.76;
ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Aggreg. Pest. use level (index)","Convent",ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Aggreg. Pest. use level (index)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1-AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees","Convent","%Scenario%"))
         + ActCropsGrass_OtherChar_MR(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"Aggreg. Pest. use level (index)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,CoreGrassActivities,"All agrof. trees","Convent","%Scenario%")*1;
*and assigne zero pesticide use to organic:
*set pesticide use index in organic equal zero (conditional on having default values):
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Aggreg. Pest. use level (index)","Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Aggreg. Pest. use level (index)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = eps;


*NH3
*very grossly: assume that a share of X% AF leads to a reduction of total NH3 values by X/100*0.3
Manure_Management_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,AnimalTypeInHerd,"Manure man NH3-N (% of N in manure)",ManureManSystemCropland,"AllAndAverageTemp",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Manure_Management_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,AnimalTypeInHerd,"Manure man NH3-N (% of N in manure)",ManureManSystemCropland,"AllAndAverageTemp","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,"All crops","All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.3);

MinFertApplication_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"mineral N fert (N)","NH3-N as percentage of fertilizer N applied (%)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = MinFertApplication_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"mineral N fert (N)","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Activities_MR,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.3);

CropResAndBiomassApplication_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"All Residues","NH3-N as percentage of fertilizer N applied (%)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = CropResAndBiomassApplication_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"All Residues","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Activities_MR,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.3);

ManureApplication_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"All animals","AllAndAverageTypes","NH3-N as percentage of fertilizer N applied (%)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ManureApplication_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"All animals","AllAndAverageTypes","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - AgroF_AreaShares(FAO_EuropeanUnion_PlusCH,Activities_MR,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")*0.3);


*C sequestration in woody biomass and soils:
ActCropsGrass_OtherChar_MR(EU_Atlantic,CropPartActivities_Agroforestry_EUROPE,"C sequestered in woody biomass (tC)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(EU_Atlantic,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = AgroF_AreaShares(EU_Atlantic,CropPartActivities_Agroforestry_EUROPE,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")
                 *0.5 *AF_UNISECO_SensitivityFactor_CInWoodyBiomass(EU_Atlantic,"All crops","All agrof. trees","%Scenario%");
ActCropsGrass_OtherChar_MR(EU_Atlantic,CoreGrassActivities,"C sequestered in woody biomass (tC)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(EU_Atlantic,CoreGrassActivities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = AgroF_AreaShares(EU_Atlantic,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")
                 *1 *AF_UNISECO_SensitivityFactor_CInWoodyBiomass(EU_Atlantic,"Grass","All agrof. trees","%Scenario%");

ActCropsGrass_OtherChar_MR(EU_Continental_PlusCH,CropPartActivities_Agroforestry_EUROPE,"C sequestered in woody biomass (tC)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(EU_Continental_PlusCH,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = AgroF_AreaShares(EU_Continental_PlusCH,CropPartActivities_Agroforestry_EUROPE,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")
                 *0.85 *AF_UNISECO_SensitivityFactor_CInWoodyBiomass(EU_Continental_PlusCH,"All crops","All agrof. trees","%Scenario%");
ActCropsGrass_OtherChar_MR(EU_Continental_PlusCH,CoreGrassActivities,"C sequestered in woody biomass (tC)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(EU_Continental_PlusCH,CoreGrassActivities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = AgroF_AreaShares(EU_Continental_PlusCH,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")
                 *1 *AF_UNISECO_SensitivityFactor_CInWoodyBiomass(EU_Continental_PlusCH,"Grass","All agrof. trees","%Scenario%");

ActCropsGrass_OtherChar_MR(EU_Mediterranean,CropPartActivities_Agroforestry_EUROPE,"C sequestered in woody biomass (tC)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(EU_Mediterranean,CropPartActivities_Agroforestry_EUROPE,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = AgroF_AreaShares(EU_Mediterranean,CropPartActivities_Agroforestry_EUROPE,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")
                 *1.7 *AF_UNISECO_SensitivityFactor_CInWoodyBiomass(EU_Mediterranean,"All crops","All agrof. trees","%Scenario%");
ActCropsGrass_OtherChar_MR(EU_Mediterranean,CoreGrassActivities,"C sequestered in woody biomass (tC)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(EU_Mediterranean,CoreGrassActivities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = AgroF_AreaShares(EU_Mediterranean,CoreGrassActivities,"All agrof. trees",ProdSyst_OrgCon,"%Scenario%")
                 *1.7 *AF_UNISECO_SensitivityFactor_CInWoodyBiomass(EU_Mediterranean,"Grass","All agrof. trees","%Scenario%");


*yet to be added:
*"C sequestered in soils (tC)"



$goto EndOfScenarioSpecifications



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) BioeSR15_P4_2050
$label AssumptionsBioeSR15_P4_2050
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "YES"


*assign areas as already assigned:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllProdSyst",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
         = 0;


*assign mineral N fertilizer values:
VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","BioeSR15_P4_2050")
         = VActCropsGrass_Inputs_MR.l(Regions_MR,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050");
VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","Convent","BioeSR15_P4_2050")
         = VActCropsGrass_Inputs_MR.l(Regions_MR,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050");

*ATTENTION: another specific value: N fertilizer needs of miscanthus, equal to N exported in biomass: VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)


*TO SEE WHETHER IT WORKS: only convent feed available
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Convent",ProductionConditions,"%Scenario%")
                 $(AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010")
                         AND Match_FeedCommoditiesToFeedCommodGroups(Commodities_MR,"AggregateFeedConcentrates_Commodity"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")
                 *AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2050")
                         /AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010");
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Convent",ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline");
*but this adjustment does apply to concentrate feed only; adjust the grassland feed according to changing grassland areas:
VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");
VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");


*assign yield increases as available in the scenario data:
ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

*non cereals, oilcrop and sugar crop group yields are still missing and are thus are assigned the values from FOFA_2050
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 $(NOT ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"))
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*BioeSR15 data do not provide livestock yields - we thus take the yields from FOFA2050:
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
*FOFA2050 does not report any yields for eggs - thus assume the same change as for poultry meat; to be IMPROVED
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012");

*assign org/conv:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Convent",ProductionConditions,"BioeSR15_P4_2050")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"BioeSR15_P4_2050")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");


ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","Convent","AllProdCond","BioeSR15_P4_2050")
         = ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","AllProdSyst","AllProdCond","BioeSR15_P4_2050");

$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2a) BioeSR15_P4_2050_RefNoBioe
$label AssumptionsBioeSR15_P4_2050_ReferenceNoBioe
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "YES"


*assign areas as already assigned:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllProdSyst",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
         = 0;

*delete bioenergy, i.e. assign miscanthus-areas to grasslands again:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Miscanthus","AllProdSyst",ProductionConditions,"%Scenario%");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Miscanthus","AllProdSyst",ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Miscanthus","Convent",ProductionConditions,"%Scenario%");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Miscanthus","Convent",ProductionConditions,"%Scenario%") = 0;


*assign mineral N fertilizer values:
*quick assumption: 25% more than in the baseline
VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","BioeSR15_P4_2050_RefNoBioe")
         = VActCropsGrass_Inputs_MR.l(Regions_MR,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050")/2.5*1.25;
VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech","Convent","BioeSR15_P4_2050_RefNoBioe")
         = VActCropsGrass_Inputs_MR.l(Regions_MR,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050")/2.5*1.25;

*ATTENTION: another specific value: N fertilizer needs of miscanthus, equal to N exported in biomass: VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)


*TO SEE WHETHER IT WORKS: only convent feed available
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Convent",ProductionConditions,"%Scenario%")
                 $(AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010")
                         AND Match_FeedCommoditiesToFeedCommodGroups(Commodities_MR,"AggregateFeedConcentrates_Commodity"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")
                 *AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2050")
                         /AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010");
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Convent",ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline");
*but this adjustment does apply to concentrate feed only; adjust the grassland feed according to changing grassland areas:
VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");
VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");


*assign yield increases as available in the scenario data:
ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_RefNoBioe")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_RefNoBioe")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_RefNoBioe")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

*non cereals, oilcrop and sugar crop group yields are still missing and are thus are assigned the values from FOFA_2050
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_RefNoBioe")
                 $(NOT ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_RefNoBioe"))
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*BioeSR15 data do not provide livestock yields - we thus take the yields from FOFA2050:
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_RefNoBioe")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
*FOFA2050 does not report any yields for eggs - thus assume the same change as for poultry meat; to be IMPROVED
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_RefNoBioe")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012");

*assign org/conv:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Convent",ProductionConditions,"BioeSR15_P4_2050_RefNoBioe")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"BioeSR15_P4_2050_RefNoBioe")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");


*no bioenergy:
ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","Convent","AllProdCond","BioeSR15_P4_2050_RefNoBioe")
         = 0;
*         = ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","AllProdSyst","AllProdCond","BioeSR15_P4_2050");

$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) BioeSR15_P4_2100
$label AssumptionsBioeSR15_P4_2100
PUTCLOSE con,"Current scenario: %Scenario%";



$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) BioeSR15_P3_2050
$label AssumptionsBioeSR15_P3_2050
PUTCLOSE con,"Current scenario: %Scenario%";


$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) BioeSR15_P4_2050_Bio
$label AssumptionsBioeSR15_P4_2050_Bio
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "YES"

*assign areas as already assigned, but 0% convent, 100% organic:
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio")
         = 0;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");


*adjust legume area shares in case they are less than 20% in total:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Legumes_NFixing,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Crops_NoNFixingLegumes,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050");

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050") < 0.2))
         = 0.2*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050") < 0.2))
         = 0.8*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");


*assign mineral N fertilizer values:
VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","BioeSR15_P4_2050_Bio")
         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050")*0;
VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","Convent","BioeSR15_P4_2050_Bio")
         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050")*0;

*ATTENTION: another specific value: N fertilizer needs of miscanthus, equal to N exported in biomass: VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)


*TO SEE WHETHER IT WORKS: only organic feed available
*TO BE IMPROVED - AD HOC
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $(AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010")
                         AND Match_FeedCommoditiesToFeedCommodGroups(Commodities_MR,"AggregateFeedConcentrates_Commodity"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")*0.8
                 *AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2050")
                         /AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010");
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")*0.8;
*but this adjustment does apply to concentrate feed only; adjust the grassland feed according to changing grassland areas:
VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");
VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");


*also adjust the feed commodities by the yield gap, to capture lower yields in feed production:
*DOES NOT WORK - WRONG MATCHING - WE need the matching from the commodityTree set, but this is assumingly slow, so use a general factor to capture the essence of it
*TO BE IMPROVED!!!
*and do it DIRECTLY ba a yield gap factor in the calculations above - as it does not apply to grass
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*         = sum(Activities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
*                 VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*                         *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline"));




*assign yield increases as available in the scenario data:
ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

*non cereals, oilcrop and sugar crop group yields are still missing and are thus are assigned the values from FOFA_2050
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $(NOT ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio"))
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*BioeSR15 data do not provide livestock yields - we thus take the yields from FOFA2050:
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
*FOFA2050 does not report any yields for eggs - thus assume the same change as for poultry meat; to be IMPROVED
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012");

*assign org/conv yields:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Convent",ProductionConditions,"BioeSR15_P4_2050_Bio")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*assign the Bioe-specific values that are yet missing, as there is no baseline values reported:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

*assume 10% less yields for organic miscanthus
ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio")
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")*0.9;
ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio")
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
*we have no information on animal yield gaps, thus assume 20%
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")*0.8;



ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","Organic","AllProdCond","BioeSR15_P4_2050_Bio")
         = ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","AllProdSyst","AllProdCond","BioeSR15_P4_2050");

VEnergyProduction_MR.l(Regions_MR,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)","BioeSR15_P4_2050_Bio")
         = VEnergyProduction_MR.l(Regions_MR,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)","BioeSR15_P4_2050");


$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) BioeSR15_P4_2050_Bio_AreaIncrease
$label AssumptionsBioeSR15_P4_2050_Bio_AreaIncrease
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "YES"

*assign areas as already assigned, but 0% convent, 100% organic:
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = 0;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");


*adjust legume area shares in case they are less than 20% in total:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Legumes_NFixing,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Crops_NoNFixingLegumes,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050");

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050") < 0.2))
         = 0.2*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050") < 0.2))
         = 0.8*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");



*TRY TO INCREASE SYSTEM SIZE!!
*TO BE IMPROVED - AD HOC
VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*1.3;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease");

*keep miscanthus area such as to assure identifcal production - thus correct for yield gap only, and start from original value
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")/0.9;
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease");



*assign mineral N fertilizer values:
VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","BioeSR15_P4_2050_Bio_AreaIncrease")
         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050")*0;
VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","Convent","BioeSR15_P4_2050_Bio_AreaIncrease")
         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050")*0;

*ATTENTION: another specific value: N fertilizer needs of miscanthus, equal to N exported in biomass: VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)


*TO SEE WHETHER IT WORKS: only organic feed available
*TO BE IMPROVED - AD HOC
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $(AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010")
                         AND Match_FeedCommoditiesToFeedCommodGroups(Commodities_MR,"AggregateFeedConcentrates_Commodity"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")*0.8*1.3
                 *AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2050")
                         /AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010");
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")*0.8*1.3;
*but this adjustment does apply to concentrate feed only; adjust the grassland feed according to changing grassland areas:
VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");
VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");


*also adjust the feed commodities by the yield gap, to capture lower yields in feed production:
*DOES NOT WORK - WRONG MATCHING - WE need the matching from the commodityTree set, but this is assumingly slow, so use a general factor to capture the essence of it
*TO BE IMPROVED!!!
*and do it DIRECTLY ba a yield gap factor in the calculations above - as it does not apply to grass
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*         = sum(Activities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
*                 VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*                         *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline"));




*assign yield increases as available in the scenario data:
ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

*non cereals, oilcrop and sugar crop group yields are still missing and are thus are assigned the values from FOFA_2050
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $(NOT ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease"))
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*BioeSR15 data do not provide livestock yields - we thus take the yields from FOFA2050:
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
*FOFA2050 does not report any yields for eggs - thus assume the same change as for poultry meat; to be IMPROVED
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012");

*assign org/conv yields:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*assign the Bioe-specific values that are yet missing, as there is no baseline values reported:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

*assume 10% less yields for organic miscanthus
ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")*0.9;
ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
*we have no information on animal yield gaps, thus assume 20%
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")*0.8;



ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","Organic","AllProdCond","BioeSR15_P4_2050_Bio_AreaIncrease")
         = ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","AllProdSyst","AllProdCond","BioeSR15_P4_2050");

VEnergyProduction_MR.l(Regions_MR,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)","BioeSR15_P4_2050_Bio_AreaIncrease")
         = VEnergyProduction_MR.l(Regions_MR,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)","BioeSR15_P4_2050");


$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) BioeSR15_P4_2050_Bio_AreaIncr_NoFCF
$label AssumptionsBioeSR15_P4_2050_Bio_AreaIncr_NoFCF
PUTCLOSE con,"Current scenario: %Scenario%";

$setglobal UseProdSyst_ConvOrg "YES"

*assign areas as already assigned, but 0% convent, 100% organic:
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = 0;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");


*adjust legume area shares in case they are less than 20% in total:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Legumes_NFixing,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Crops_NoNFixingLegumes,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050");

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050") < 0.2))
         = 0.2*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050") < 0.2))
         = 0.8*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");



*TRY TO INCREASE SYSTEM SIZE!!
*TO BE IMPROVED - AD HOC
VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")*1.3;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF");

*keep miscanthus area such as to assure identifcal production - thus correct for yield gap only, and start from original value
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")/0.9;
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF");



*assign mineral N fertilizer values:
VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050")*0;
VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","Convent","BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050")*0;

*ATTENTION: another specific value: N fertilizer needs of miscanthus, equal to N exported in biomass: VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)


*TO SEE WHETHER IT WORKS: only organic feed available
*TO BE IMPROVED - AD HOC
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $(AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010")
                         AND Match_FeedCommoditiesToFeedCommodGroups(Commodities_MR,"AggregateFeedConcentrates_Commodity"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")*0.8*1.3
                 *AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2050")
                         /AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010");
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")*0.8*1.3;
*but this adjustment does apply to concentrate feed only; adjust the grassland feed according to changing grassland areas:
VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");
VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");
*Get rid of FCF - food-competing feed:
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
         =0;
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedForageCrops_Commodity ')
         =0;

*adjust areas accordingly:
*no forage crops and other forage crops:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OtherFodderCrops,ProductionSystems,ProductionConditions,"%Scenario%") = 0;
*no triticale
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
*reduction in the areas of crops that have been grown for concentrate feed:

*set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateCommodities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));
*set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateActivities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));
*set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_WellDefinedCoProducts_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));
*set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_ComplexCases_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));
*set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));
*set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCrops)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));

*if such occurr: set negative values = 0:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                  $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%") < 0)
         = 0;
*does not capture all that is needed, thus adjust by hand, starting from the Bio scenario with additional lands, NOT taking the above reductions - otherwise it is double counted:
*                        wheat, barley, soy areas, maize, rice to be reduced by 35% and 80%, 15% and 85%:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Wheat","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Wheat","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.65;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Barley","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Barley","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.65;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.2;
*part of maize is forage maize - thus reduce drastically
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Maize","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Maize","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.15;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Rice, paddy","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Rice, paddy","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.85;

*and then crop the freed land to 35% with soybeans
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")
                 +0.35*(
                         VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Wheat","Organic",ProductionConditions,"%Scenario%")*0.35
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Barley","Organic",ProductionConditions,"%Scenario%")*0.35
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")*0.8
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Maize","Organic",ProductionConditions,"%Scenario%")*0.85
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Rice, paddy","Organic",ProductionConditions,"%Scenario%")*0.15);




*feed ruminants with grass only, NonRuminants with non-forage, i.e. byproducts only
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 1;

FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 1;
FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;

ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 + ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));


ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 + ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));




*also adjust the feed commodities by the yield gap, to capture lower yields in feed production:
*DOES NOT WORK - WRONG MATCHING - WE need the matching from the commodityTree set, but this is assumingly slow, so use a general factor to capture the essence of it
*TO BE IMPROVED!!!
*and do it DIRECTLY ba a yield gap factor in the calculations above - as it does not apply to grass
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*         = sum(Activities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
*                 VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*                         *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline"));


*assign yield increases as available in the scenario data:
ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

*non cereals, oilcrop and sugar crop group yields are still missing and are thus are assigned the values from FOFA_2050
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*BioeSR15 data do not provide livestock yields - we thus take the yields from FOFA2050:
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
*FOFA2050 does not report any yields for eggs - thus assume the same change as for poultry meat; to be IMPROVED
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012");

*assign org/conv yields:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*assign the Bioe-specific values that are yet missing, as there is no baseline values reported:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

*assume 10% less yields for organic miscanthus
ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")*0.9;
ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
*we have no information on animal yield gaps, thus assume 20%
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")*0.8;



ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","Organic","AllProdCond","BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","AllProdSyst","AllProdCond","BioeSR15_P4_2050");

VEnergyProduction_MR.l(Regions_MR,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)","BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = VEnergyProduction_MR.l(Regions_MR,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)","BioeSR15_P4_2050");


$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*7) BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW
$label AssumptionsBioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW

$setglobal UseProdSyst_ConvOrg "YES"

*assign areas as already assigned, but 0% convent, 100% organic:
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = 0;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");


*adjust legume area shares in case they are less than 20% in total:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Legumes_NFixing,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Crops_NoNFixingLegumes,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050");

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050") < 0.2))
         = 0.2*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050") < 0.2))
         = 0.8*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");



*TRY TO INCREASE SYSTEM SIZE!!
*TO BE IMPROVED - AD HOC
VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")*1.3;
VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Crops,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW");

*keep miscanthus area such as to assure identifcal production - thus correct for yield gap only, and start from original value
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")/0.9;
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW");



*assign mineral N fertilizer values:
VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050")*0;
VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","Convent","BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","BioeSR15_P4_2050")*0;

*ATTENTION: another specific value: N fertilizer needs of miscanthus, equal to N exported in biomass: VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)


*TO SEE WHETHER IT WORKS: only organic feed available
*TO BE IMPROVED - AD HOC
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $(AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010")
                         AND Match_FeedCommoditiesToFeedCommodGroups(Commodities_MR,"AggregateFeedConcentrates_Commodity"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")*0.8*1.3
                 *AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2050")
                         /AUX_FeedSupplyFactor_BioeSR15_MR(Regions_MR,"BioeSR15_P4_2010");
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")*0.8*1.3;
*but this adjustment does apply to concentrate feed only; adjust the grassland feed according to changing grassland areas:
VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");
VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
         = VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");
*Get rid of FCF - food-competing feed:
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
         =0;
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedForageCrops_Commodity ')
         =0;

*adjust areas accordingly:
*no forage crops and other forage crops:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OtherFodderCrops,ProductionSystems,ProductionConditions,"%Scenario%") = 0;
*no triticale
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
*reduction in the areas of crops that have been grown for concentrate feed:

*set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateCommodities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));
*set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateActivities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));
*set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_WellDefinedCoProducts_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));
*set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_ComplexCases_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));
*set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));
*set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCrops)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"%Scenario%"));

*if such occurr: set negative values = 0:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%")
                  $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Organic",ProductionConditions,"%Scenario%") < 0)
         = 0;
*does not capture all that is needed, thus adjust by hand, starting from the Bio scenario with additional lands, NOT taking the above reductions - otherwise it is double counted:
*                        wheat, barley, soy areas, maize, rice to be reduced by 35% and 80%, 15% and 85%:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Wheat","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Wheat","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.65;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Barley","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Barley","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.65;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.2;
*part of maize is forage maize - thus reduce drastically
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Maize","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Maize","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.15;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Rice, paddy","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Rice, paddy","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.85;

*and then crop the freed land to 35% with soybeans
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")
                 +0.35*(
                         VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Wheat","Organic",ProductionConditions,"%Scenario%")*0.35
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Barley","Organic",ProductionConditions,"%Scenario%")*0.35
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")*0.8
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Maize","Organic",ProductionConditions,"%Scenario%")*0.85
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Rice, paddy","Organic",ProductionConditions,"%Scenario%")*0.15);

*adjust areas by food wastage reduction assumptions:
*reduce FW by 75% - assume FW shares: Cereals 20%, roots 40%, fruits 40%, vegetables 40%:  - rest is negligible for these calculations here, thus remaining amount: cereal: 0.85 (= 1 -0.75*0.2), etc.
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals,"Organic",ProductionConditions,"%Scenario%")*0.85;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,StarchyRoots,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,StarchyRoots,"Organic",ProductionConditions,"%Scenario%")*0.7;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Fruits,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Fruits,"Organic",ProductionConditions,"%Scenario%")*0.7;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Vegetables,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Vegetables,"Organic",ProductionConditions,"%Scenario%")*0.7;





*feed ruminants with grass only, NonRuminants with non-forage, i.e. byproducts only
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 1;

FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 1;
FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;

ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 + ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));


ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 + ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));




*also adjust the feed commodities by the yield gap, to capture lower yields in feed production:
*DOES NOT WORK - WRONG MATCHING - WE need the matching from the commodityTree set, but this is assumingly slow, so use a general factor to capture the essence of it
*TO BE IMPROVED!!!
*and do it DIRECTLY ba a yield gap factor in the calculations above - as it does not apply to grass
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*         = sum(Activities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
*                 VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*                         *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline"));


*assign yield increases as available in the scenario data:
ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,Cereals,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Cereals","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,SugarCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All Sugar Crops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010")
         = ActCropsGrass_Outputs_MR(Regions_MR,OilCrops,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                         /ActCropsGrass_Outputs_MR(Regions_MR,"All OilCrops","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2010");

*non cereals, oilcrop and sugar crop group yields are still missing and are thus are assigned the values from FOFA_2050
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $(NOT ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW"))
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*BioeSR15 data do not provide livestock yields - we thus take the yields from FOFA2050:
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
*FOFA2050 does not report any yields for eggs - thus assume the same change as for poultry meat; to be IMPROVED
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,"Baseline")
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,"FOFA_Baseline_2012");

*assign org/conv yields:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*assign the Bioe-specific values that are yet missing, as there is no baseline values reported:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

*assume 10% less yields for organic miscanthus
ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")*0.9;
ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
*we have no information on animal yield gaps, thus assume 20%
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")*0.8;



ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","Organic","AllProdCond","BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","AllProdSyst","AllProdCond","BioeSR15_P4_2050");

VEnergyProduction_MR.l(Regions_MR,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)","BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW")
         = VEnergyProduction_MR.l(Regions_MR,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)","BioeSR15_P4_2050");


$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*8) Baseline_100Organic
$label AssumptionsBaseline_100Organic

$setglobal UseProdSyst_ConvOrg "YES"

*assign areas as already assigned, but 0% convent, 100% organic:
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"Baseline_100Organic")
         = 0;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"Baseline_100Organic")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline");

*VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline_100Organic")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline");

*as some commodity variables scale with baseline values: assign them to 100% organic:
VCommod_Production_MR.l(Regions,Commodities,"Organic",ProductionConditions,"Baseline")
         = VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VImportQuantity_MR.l(Regions,"World",Commodities,"Organic",ProductionConditions,"Baseline")
         = VImportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VExportQuantity_MR.l(Regions,"World",Commodities,"Organic",ProductionConditions,"Baseline")
         = VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"Organic",ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,"Organic",ProductionConditions,"Baseline")
         = AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");

VCommod_Quantity_MR.l(Regions,Commodities,"Organic",ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio","Organic",ProductionConditions,"Baseline")
         = Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio","AllProdSyst",ProductionConditions,"Baseline");

VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"Organic",ProductionConditions,"Baseline")
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"ALlProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"Organic",ProductionConditions,"Baseline")
         = AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"Organic",ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,"Organic",ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"ALlProdSyst",ProductionConditions,"Baseline");


*adjust legume area shares in case they are less than 25% in total:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"Baseline")
         =sum(Legumes_NFixing,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)",ProductionSystems,ProductionConditions,"Baseline")
         =sum(Crops_NoNFixingLegumes,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"Baseline")
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"Baseline"));
ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)",ProductionSystems,ProductionConditions,"Baseline")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"Baseline")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"Baseline");

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"Organic",ProductionConditions,"Baseline_100Organic")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"Baseline")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"Baseline") < 0.25))
         = 0.25*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"AllProdSyst",ProductionConditions,"Baseline")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"Baseline");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"Organic",ProductionConditions,"Baseline_100Organic")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"Baseline")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"Baseline") < 0.25))
         = 0.75*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"Baseline")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"AllProdSyst",ProductionConditions,"Baseline")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"Baseline");

*assume lower organic grassland yields
ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline")
                 *ActCropsGrass_OtherChar_MR(Regions,COreGrassActivities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline")*0.9;


*assign mineral N fertilizer values:
*not needed ,derived from scaled demand from Min N fert using systems: = 0 in this case
*VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","Baseline_100Organic")
*         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","Baseline")*0;
*VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","Convent","Baseline_100Organic")
*         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","Baseline")*0;


*THE FOLLOWING SHOULD WORK NOW!!!
*TO SEE WHETHER IT WORKS: only organic feed available
*adjust for yield gap: factor 0.8 for non-grass commodities; 0.9 for temporary, 1 for permanent grass
*TO BE IMPROVED - AD HOC
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")*0.8;
*but this adjustment does apply to concentrate feed only; adjust the grassland feed according to changing grassland areas:
*VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")*0.9;
*VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");

*also adjust the feed commodities by the yield gap, to capture lower yields in feed production:
*DOES NOT WORK - WRONG MATCHING - WE need the matching from the commodityTree set, but this is assumingly slow, so use a general factor to capture the essence of it
*TO BE IMPROVED!!!
*and do it DIRECTLY ba a yield gap factor in the calculations above - as it does not apply to grass
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*         = sum(Activities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
*                 VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*                         *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline"));

$ontext;

The following assignments are done in the specific file AssignInitialValues!

*assign org/conv yields:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Convent",ProductionConditions,"Baseline_100Organic")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"Baseline_100Organic");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"Baseline_100Organic")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"Baseline_100Organic")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"Baseline_100Organic")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*assign the Bioe-specific values that are yet missing, as there are no baseline values reported:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"Baseline_100Organic")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"Baseline_100Organic"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"Baseline");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"Baseline_100Organic")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"Baseline_100Organic"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"Baseline");

ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"Baseline_100Organic"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"Baseline_100Organic"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");


ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"Baseline_100Organic"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"Baseline_100Organic"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
$offtext;



$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*9) Baseline_50Organic
$label AssumptionsBaseline_50Organic

$setglobal UseProdSyst_ConvOrg "YES"

*assign areas as already assigned, but 0% convent, 100% organic:
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"Baseline_50Organic")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline")
                 *0.5;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"Baseline_50Organic")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline")
                 *0.5;

*VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline_100Organic")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline");

*as some commodity variables scale with baseline values: assign them to 100% organic:
VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VImportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VImportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");
AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline");

VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");

VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio",ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio","AllProdSyst",ProductionConditions,"Baseline");

VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"ALlProdSyst",ProductionConditions,"Baseline");

AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,"ALlProdSyst",ProductionConditions,"Baseline");
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProdSyst_OrgCon,ProductionConditions,"Baseline")
         = AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"ALlProdSyst",ProductionConditions,"Baseline");


*adjust legume area shares in case they are less than 25% in total:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"Baseline")
         =sum(Legumes_NFixing,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)",ProductionSystems,ProductionConditions,"Baseline")
         =sum(Crops_NoNFixingLegumes,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,ProductionSystems,ProductionConditions,"Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"Baseline")
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"Baseline"));
ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)",ProductionSystems,ProductionConditions,"Baseline")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"Baseline")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"Baseline");

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"Organic",ProductionConditions,"Baseline_50Organic")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"Baseline")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"Baseline") < 0.25))
         = 0.25*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"Baseline")
                         *0.5
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"AllProdSyst",ProductionConditions,"Baseline")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"Baseline");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"Organic",ProductionConditions,"Baseline_50Organic")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"Baseline")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"Baseline") < 0.25))
         = 0.75*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"Baseline")
                         *0.5
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"AllProdSyst",ProductionConditions,"Baseline")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"Baseline");

*assume lower organic grassland yields
ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline")
                 *ActCropsGrass_OtherChar_MR(Regions,COreGrassActivities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline")*0.9;


*assign mineral N fertilizer values:
*VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst","Baseline_50Organic")
*         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","Baseline")*0.5;
*VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","Convent","Baseline_100Organic")
*         = VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond","Baseline")*0;


*THE FOLLOWING SHOULD WORK NOW!!!
*TO SEE WHETHER IT WORKS: only organic feed available
*adjust for yield gap: factor 0.8 for non-grass commodities; 0.9 for temporary, 1 for permanent grass
*TO BE IMPROVED - AD HOC
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")*0.8;
*but this adjustment does apply to concentrate feed only; adjust the grassland feed according to changing grassland areas:
*VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"Baseline")*0.9;
*VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
*         = VCommod_Feed_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"Baseline");

*also adjust the feed commodities by the yield gap, to capture lower yields in feed production:
*DOES NOT WORK - WRONG MATCHING - WE need the matching from the commodityTree set, but this is assumingly slow, so use a general factor to capture the essence of it
*TO BE IMPROVED!!!
*and do it DIRECTLY ba a yield gap factor in the calculations above - as it does not apply to grass
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*         = sum(Activities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
*                 VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*                         *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline"));

$ontext;

The following assignments are done in the specific file AssignInitialValues!

*assign org/conv yields:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Convent",ProductionConditions,"Baseline_100Organic")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"Baseline_100Organic");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"Baseline_100Organic")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"Baseline_100Organic")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"Baseline_100Organic")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*assign the Bioe-specific values that are yet missing, as there are no baseline values reported:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"Baseline_100Organic")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"Baseline_100Organic"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"Baseline");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"Baseline_100Organic")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"Baseline_100Organic"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"Baseline");

ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"Baseline_100Organic"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"Baseline_100Organic"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"Baseline");


ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"Baseline_100Organic"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"Baseline_100Organic")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"Baseline_100Organic"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"Baseline");
$offtext;



$goto EndOfScenarioSpecifications

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*24) Baseline_NoFCF
$label AssumptionsBaseline_NoFCF

$setglobal UseProdSyst_ConvOrg "YES"

*assign areas
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline");

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"Baseline");


$ontext;
*adjust legume area shares in case they are less than 20% in total:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Legumes_NFixing,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Crops_NoNFixingLegumes,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"BioeSR15_P4_2050"));
ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"BioeSR15_P4_2050");

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050") < 0.2))
         = 0.2*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050") < 0.2))
         = 0.8*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
$offtext;


*TO SEE WHETHER IT WORKS:
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"Baseline");

VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline");

*But we want grass-based feed only, i.e. get rid of FCF - food-competing feed:
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
         =0;
VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedForageCrops_Commodity ')
         =0;

*adjust areas accordingly:
*no forage crops and other forage crops:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OtherFodderCrops,ProductionSystems,ProductionConditions,"%Scenario%") = 0;
*no triticale
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%") = 0;

*reduction in the areas of crops that have been grown for concentrate feed:

*set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateCommodities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
*set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateActivities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
*set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_WellDefinedCoProducts_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
*set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_ComplexCases_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
*set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
*set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCrops)
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"))
                                 /ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

*if such occurr: set negative values = 0:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;




$ontext;

XXBELOW NEEDED  NEEDED  NEEDED????!!!
BELOW NEEDED  NEEDED  NEEDED????!!!


*does not capture all that is needed, thus adjust by hand, starting from the Bio scenario with additional lands, NOT taking the above reductions - otherwise it is double counted:
*                        wheat, barley, soy areas, maize, rice to be reduced by 35% and 80%, 15% and 85%:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Wheat","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Wheat","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.65;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Barley","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Barley","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.65;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.2;
*part of maize is forage maize - thus reduce drastically
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Maize","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Maize","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.15;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Rice, paddy","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Rice, paddy","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncrease")*0.85;

*and then crop the freed land to 35% with soybeans
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")
                 +0.35*(
                         VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Wheat","Organic",ProductionConditions,"%Scenario%")*0.35
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Barley","Organic",ProductionConditions,"%Scenario%")*0.35
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Soybeans","Organic",ProductionConditions,"%Scenario%")*0.8
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Maize","Organic",ProductionConditions,"%Scenario%")*0.85
                         + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Rice, paddy","Organic",ProductionConditions,"%Scenario%")*0.15);

$offtext;



*feed ruminants with grass only, NonRuminants with non-forage, i.e. byproducts only
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 1;

FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 1;
FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;

ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 + ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));


ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 + ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));




*also adjust the feed commodities by the yield gap, to capture lower yields in feed production:
*DOES NOT WORK - WRONG MATCHING - WE need the matching from the commodityTree set, but this is assumingly slow, so use a general factor to capture the essence of it
*TO BE IMPROVED!!!
*and do it DIRECTLY ba a yield gap factor in the calculations above - as it does not apply to grass
*VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*         = sum(Activities_MR$Match_ActivityOutputsToCommodities_Crops(Activities_MR,"MainOutput1 (t)",Commodities_MR),
*                 VCommod_Feed_MR.l(Regions_MR,Commodities_MR,"Organic",ProductionConditions,"%Scenario%")
*                         *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline"));


$ontext;
*assign org/conv yields:
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF");
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)","AllProdSyst",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*assign the Bioe-specific values that are yet missing, as there is no baseline values reported:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

*assume 10% less yields for organic miscanthus
ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")*0.9;
ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus",OutputsCropsGrass,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");

ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050");
*we have no information on animal yield gaps, thus assume 20%
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,"BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,"BioeSR15_P4_2050")*0.8;



ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","Organic","AllProdCond","BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = ActForest_OtherChar_MR(Regions_MR,"Forest","Forest res bioe N for areas (tN/t DM res)","AllProdSyst","AllProdCond","BioeSR15_P4_2050");

VEnergyProduction_MR.l(Regions_MR,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)","BioeSR15_P4_2050_Bio_AreaIncr_NoFCF")
         = VEnergyProduction_MR.l(Regions_MR,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)","BioeSR15_P4_2050");
$offtext;


$goto EndOfScenarioSpecifications




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*25) FOFA_BAU_2050_NoFCF
$label AssumptionsFOFA_BAU_2050_NoFCF
PUTCLOSE con,"Current scenario: %Scenario%";


*No conc for ruminants, other animals as in the baseline; 25% organic
*to check some results, we assume 5% organic outside the EU only - this results in lower imports of organic feed from abroad, thus organic monogastric animals are much less than a third of conventional only, due to much lower organic feed supply
*assuming 25% organic globally results in correspondingly higher numbers, and organic animal numnbers is about 25% of conventional ones: this fits with 25% organic, (i.e. a third of conventional 75%) areas, and anbout 80% lower yields, thus organic production is about a fourth of conventional prod.

$setglobal UseProdSyst_ConvOrg "YES"

$setglobal UseReference2050 "YES"


*assign areas: for the EU, we assume 525% organic plus 25% Agroforestry (i.e. both: agroecology, total 50% (and 25% AF also applies to organic areas)), for the RoW, we assume 5% organic

*assign areas: for the EU, we assume 50% organic, for the RoW, we assume 5% organic
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
*                 *0.75;
*there is specific data for temporary meadows in the scenarios, but not for permanent meadows (only EU, see below) - thus use the BAU 2050 for those
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
*                 *0.75;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
*                 *0.75;
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
*                 *0.75;
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.95;
*                 *0.75;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
*                 *0.25;
*there is specific data for temporary meadows in the scenarios, but not for permanent meadows (only EU, see below) - thus use the BAU 2050 for those
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
*                 *0.25;
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
*                 *0.25;
*the BioBam data has no forage values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
*                 *0.25;
*the BioBam data has no temporary grassland values for the UNISECO scenarios for non-EU countries, thus assign FOFA_BAU_2050 values:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Temporary meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.05;
*                 *0.25;

*25% organic in the EU
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.75;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.75;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Convent",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.75;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.75;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"Organic",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.25;
*there is specific data for temporary meadows in the scenarios, but for permanent meadows not for all countries - thus use the BAU 2050 for those where it is missing
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.25;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%")
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","Organic",ProductionConditions,"%Scenario%"))
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Permanent meadows and pastures","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.25;
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"Organic",ProductionConditions,"%Scenario%")
*         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *0.25;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"%Scenario%")
         = 0;

*adjust legume area shares on organic areas in case they are less than 25% in total:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         =sum(Legumes_NFixing,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,ProductionSystems,ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         =sum(Crops_NoNFixingLegumes,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,ProductionSystems,ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         =sum(Crops_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,"FOFA_BAU_2050"));
ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,"FOFA_BAU_2050")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");

*factor *0.25: as we generally have 25% of areas under organic managemnt, this rearrangement of crop types applies to this area share only
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"Organic",ProductionConditions,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") < 0.25))
         = 0.25*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *0.25
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"Organic",ProductionConditions,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (ActCropsGrass_OtherChar_MR(Regions_MR,"All Crops","Share legumes in cropland (share ha)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") < 0.25))
         = 0.75*VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *0.25
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_NoNFixingLegumes,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops without Legumes (Nfixing)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


*yields: apply organic yield gap :
*and assume 10% lower yields for monogastrics
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%"))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
ActAnimalsHead_Outputs_MR(Regions,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Organic",ProductionConditions,"%Scenario%")*0.9;

*als make the conventional monogastrics 10% less efficient, i.e. reduce yields by 10%:
*NO - keep as they are
*ActAnimalsHead_Outputs_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
*         = ActAnimalsHead_Outputs_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")*0.9;

*convent yields:
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Convent",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsAPU_Outputs_MR(Regions,Activities,ProducingAnimals,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"Convent",ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,YieldsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*no grassland yield data for 2050, so use 2012 - but we run the FOFA_BAU_2050 anyway before we can run this scenario that depends on it, so use the values from there, which are the same:
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2050");
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2050");

*the following: Drop, is assigned later for grass-based ruminants
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRations_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*some numbers of animals are zero in 2050 data, such as horses and games - thus assign zero share in total GE req to them:
FeedingRations_OtherChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(MatchLivestockAnimaltypeInHerd(Livestock,AnimaltypeInHerd) AND (NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")))
         =eps;
FeedingRations_OtherChar_MR(Regions_MR,Livestock,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(MatchLivestockAnimaltypeInHerd(Livestock,AnimaltypeInHerd) AND (NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Livestock,"Living","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")))
         =eps;



*shares for some commodities are zero here - and are potentially later assigned with non-zero baseline values in the initiaisation code in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms,
*thus also assign eps to these zeroes and then replace the eps with zero again later, in _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc.gms
*NOT NEEDED ANYMORE!!
*FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                 $(FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"Baseline")
*                         AND (NOT FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
*         =eps;




*asign a number of parameters used to derive animal numbers to the FOFA 2050 BAU values (default is the SOLm Baseline)
*Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(Regions_MR,Commodities,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,"FOFA_BAU_2050");
Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


*assume organic grassland yields - which equals conventional in the baseline
ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,CoreGrassActivities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

*allow lower grassland utilization (this captures the reduced grazing intensity: -20%):
*NO - keep as it is
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"AggregateFeedGrass_Commodity","Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")/0.8;
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,GrassCommodities,"Feed DM supply/demand ratio",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,GrassCommodities,"Feed DM supply/demand ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")/0.8;



*$ontext;
*feed ruminants with grass only
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_NoForageNoGrass,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
          = eps;
FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_ForageCrops,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
          = eps;

FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         =sum(Commodities_Feed_Grass,FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));

FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
          = FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,Commodities_Feed_Grass,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 /FeedingRationsHeads_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = eps;

FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 + FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 /FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*$offtext;



*Reduction in the areas of crops that have been grown for concentrate feed by the amount not needed anymore for ruminants:

*set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateCommodities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateActivities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_WellDefinedCoProducts_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_ComplexCases_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

*forage crops and other forage crops need to be done specifically, as not included above, where the focus is on Main and byprod Concentrates, not forage:

VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,ForageCrops,"MainOutput1 (t)"),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,OtherFodderCrops,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,OtherFodderCrops,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,OtherFodderCrops,"MainOutput1 (t)"),
                         Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))));

*adjust triticale - to be done separately, as there is no ruminat share factor, thus use the one from Wheat and products and util feed share = 1:
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%")
                 *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes","Wheat and products","Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*if such occurr: set negative values = 0:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*adjust imports accordingly: i.e. reduce imports by the same factor as produciton was reduced above, due to lower feed use for ruminants:
*feed is from DAQ, thus, reducing the feed part from DAQ translates in a corresponding reduction of products AND imports
*formally, this is done via the ImportScaleFactor:
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VImportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")
         = (1 - Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*         = 1;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,"World",Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = (1 - Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*         = 1;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(FAO_EuropeanUnion_PlusCH,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = (1 - Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*         = 1;
*NO CHANGE IN export scale factor, though:
*ExportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                 $VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")
*         = 1;

*if such occurr: set negative values = 0:
ImportScaleFactor_MR(Regions,Regions_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(ImportScaleFactor_MR(Regions,Regions_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;

*Finally, also adapt the utilization shares: if from a quantity X of a commodity, a share a is used for feed, (1-a) for all other uses, and from this share a, a share r was used for ruminants,
*then after reducing the quantity for ruminants to zero, the utilization shares look as follows:
*                                                                                                                                                                                          a(1-r)        1 - a
*the new quantity is X(1-ra); the new quantity used for feed is Xa(1-r), the new utilization share for feed is thus Xa(1-r)/[X(1-ra)] = a(1-r)/(1-ra), the share for all other uses is 1- --------- = ------------
*                                                                                                                                                                                          1 - ra       1 - ra
*thus, the utilization share for feed is a(1-r)/(1-ra) and the utilization share for any other use, with original utilization share b is b((1-ra):
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(1 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                         *Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
                         /(1 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                         *Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*all besides feed:
Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,UtilSharesNOTFeed,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(1 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,UtilSharesNOTFeed,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 /(1 - FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));

$ontext;
OLD CODE _ NOT NEEDED ANYMORE
*set MatchCommAct_AggregateActivities_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateActivities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(FAO_EuropeanUnion_PlusCH,Commodities_MR,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
                                 /ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
*set MatchCommAct_WellDefinedCoProducts_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_WellDefinedCoProducts_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(FAO_EuropeanUnion_PlusCH,Commodities_MR,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
                                 /ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
*set MatchCommAct_ComplexCases_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_ComplexCases_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(FAO_EuropeanUnion_PlusCH,Commodities_MR,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
                                 /ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
*set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass)
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(FAO_EuropeanUnion_PlusCH,Commodities_MR,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
                                 /ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));
*set MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities,Activities,OutputsCrops)
VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion_PlusCH,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         VCommod_Feed_MR.l(FAO_EuropeanUnion_PlusCH,Commodities_MR,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                         *FeedingRations_OtherChar_MR(FAO_EuropeanUnion_PlusCH,"All Ruminants","AllAndAverageTypes",Commodities_MR,"Quantity share in total feed req of all animals","AllProdSyst",ProductionConditions,"FOFA_BAU_2050"))
                                 /ActCropsGrass_Outputs_MR(FAO_EuropeanUnion_PlusCH,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,"%Scenario%"));

$offtext;






$ontext;
XXXX

*feed ruminants with grass only, NonRuminants with non-forage, i.e. byproducts only
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,Ruminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 1;

FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 1;
FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;
FeedingRations_OtherChar_MR(Regions_MR,NonRuminants,AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Quantity share in DM (share)",ProductionSystems,ProductionConditions,"%Scenario%")
          = 0;

ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 + ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%"));


ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Forage",ProductionSystems,ProductionConditions,"%Scenario%")
         = 0;
ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 + ActAnimalsHead_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%")
                                 /ActAnimalsHead_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","Share in FeedGE_Req_Total from Conc",ProductionSystems,ProductionConditions,"%Scenario%"));




XXXX
$offtext ;




*for a test, whether it sums to 0 and 1 as it should:
FeedingRations_OtherChar_MR(Regions,"All NonRuminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((NonRuminants,AnimalTypeInherd),FeedingRations_OtherChar_MR(Regions,NonRuminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"));
FeedingRations_OtherChar_MR(Regions,"All Ruminants","AllAndAverageTypes","AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum((Ruminants,AnimalTypeInherd),FeedingRations_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"AggregateFeedCereals_Commodity","Quantity share in total feed req of all animals",ProductionSystems,ProductionConditions,"%Scenario%"));


*change util feed share to get the animal numbers in FOFA_2050_BAU right with the baseline supply/demand ratio, etc- this is also no surprise - default util rates are from the baseline, so changes till 2050 are likely, but we do not have data on this
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*                 $(NOT Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline") = 1)
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.72;
*Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util food (share)","AllProdSyst",ProductionConditions,"Baseline")
*                 + Commod_OtherChar_MR(FAO_EuropeanUnion_PlusCH,Commodities_Feed_NoForageNoGrass,"Util feed (share)","AllProdSyst",ProductionConditions,"Baseline")*0.28;


*KEEP trade as it is:
$ontext;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VImportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
         = 0.3;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,"World",Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 0.3;
ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(FAO_EuropeanUnion_PlusCH,Commodities,"AllProdSyst",ProductionConditions,"Baseline")
                         AND (NOT ImportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = 0.3;
ExportScaleFactor_MR(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VExportQuantity_MR.l(FAO_EuropeanUnion_PlusCH,Regions_2,Commodities,"ALlProdSyst",ProductionConditions,"Baseline")
         = 0.3;
$offtext;

VPopulationNumbers_MR.l(Regions,PopulationGroups,"%Scenario%")
         = VPopulationNumbers_MR.l(Regions,PopulationGroups,"FOFA_BAU_2050");




*as some commodity variables scale with baseline values: assign them to 100% organic:

*DO: HERE_ repace with FOFA_BAU_2050 - as it uses the code part that scales with this!!!
*Original version: all with "BAseline" instead of "FOFA_BAU_2050"

VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
VImportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VImportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VExportQuantity_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_ProdPlusImport_VCommod_Production_MR.l(Regions,Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VExportQuantity_NotFromCountry_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_BaselineProdLargerThanExports_MR.l(Regions,"World",Commodities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"FOFA_BAU_2050");
Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio",ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = Commod_OtherChar_MR("World",Commodities,"Global Export/Import ratio","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,"ALlProdSyst",ProductionConditions,"FOFA_BAU_2050");

AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"ALlProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VCommod_Quantity_MR.l(Regions,Commodities,"ALlProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VExportQuantity_MR.l(Regions,"World",Commodities,"ALlProdSyst",ProductionConditions,"FOFA_BAU_2050");
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = AUX_Inverse_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"ALlProdSyst",ProductionConditions,"FOFA_BAU_2050");

VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050")
         = VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");



$goto EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*26) "FOFA_BAU_2050_vegan"
$label AssumptionsFOFA_BAU_2050_vegan
PUTCLOSE con,"Current scenario: %Scenario%";

*the following scenarios are governed by this part:
*"FOFA_2050_VeganBAU_NoFreeAreaUse"
*"FOFA_2050_VeganBAU"
*"FOFA_2050_VeganBarbieri"
*"FOFA_2050_VeganBarbieri_a"
*"FOFA_2050_VeganSchmidt"
*"FOFA_2050_VeganOptimized"
*"FOFA_2050_VeganOptimized_conv"

$setglobal UseProdSyst_ConvOrg "YES"
$setglobal UseReference2050 "YES"

*vegan scenarios:

*specify the different vegan scenarios:
*this needs specitifation of
*         - crop rotation design
*         - organic area share
*         - share of vegan diets
*         - use of the areas that became free due to feed production reduction
*this is captured via
*        %CropRotationDesign%
*        OrganicAreaShare(Regions,Activities,ProductionConditions,Scenarios)
*        VeganDietShare(Regions,Scenarios)
*        CropUSeOfNewlyFreeAreas(Regions,ProductionSystems,Scenarios)
*
$ontext;
possible crop rotation choices:
*$if %CropRotationDesign% == "Barbieri" $goto BarbieriCropRot
*$if %CropRotationDesign% == "Schmidt" $goto SchmidtCropRot
*$if %CropRotationDesign% == "Optimized" $goto OptimizedCropRot
*$if %CropRotationDesign% == "BAU" $goto BAUCropRot
$offtext;

*furthermore, choose whether human faeces are recycled back to soils or not

$ifthen %Scenario% == "FOFA_2050_VeganBAU_NoFreeAreaUse"
$setglobal CropRotationDesign "BAU"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0;
VeganDietShare("World","%Scenario%") = 1;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
$endif;

$ifthen %Scenario% == "FOFA_2050_VeganBAU"
$setglobal CropRotationDesign "BAU"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0;
VeganDietShare("World","%Scenario%") = 1;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
         

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganOptimized_conv"
$setglobal CropRotationDesign "Optimized"
$setglobal UseAgronomicConstraints "No"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0;
VeganDietShare("World","%Scenario%") = 1;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
*test to find bug - delete later
Parameter testPar_conv;
testPar_conv = VeganDietShare("World","%Scenario%");
execute_unload testPar_conv;


$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri"
$setglobal CropRotationDesign "Barbieri"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 1;
VeganDietShare("World","%Scenario%") = 1;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

$endif;

$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_a"
$setglobal CropRotationDesign "Barbieri"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 1;
VeganDietShare("World","%Scenario%") = 0.4;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0.75;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0.5;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*assume: reuse 50% of assumed overall 30% food waste
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0.3*0.5;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0.2;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganSchmidt"
$setglobal CropRotationDesign "Schmidt"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 1;
VeganDietShare("World","%Scenario%") = 1;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
$endif;

$ifthen %Scenario% == "FOFA_2050_VeganOptimized"
$setglobal CropRotationDesign "Optimized"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 1;
VeganDietShare("World","%Scenario%") = 1;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;




********************Further vegan scenarios *********************************************
*****************************************************************************************
$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_0_0"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0;
VeganDietShare("World","%Scenario%") = 0;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_25_0"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.25;
VeganDietShare("World","%Scenario%") = 0;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_50_0"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.5;
VeganDietShare("World","%Scenario%") = 0;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;

$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_75_0"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.75;
VeganDietShare("World","%Scenario%") = 0;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_100_0"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 1;
VeganDietShare("World","%Scenario%") = 0;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_0_20"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0;
VeganDietShare("World","%Scenario%") = 0.2;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;



$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_25_20"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.25;
VeganDietShare("World","%Scenario%") = 0.2;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_50_20"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.5;
VeganDietShare("World","%Scenario%") = 0.2;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_75_20"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.75;
VeganDietShare("World","%Scenario%") = 0.2;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;

$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_100_20"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 1;
VeganDietShare("World","%Scenario%") = 0.2;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_0_40"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0;
VeganDietShare("World","%Scenario%") = 0.4;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_25_40"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.25;
VeganDietShare("World","%Scenario%") = 0.4;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;

$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_50_40"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.5;
VeganDietShare("World","%Scenario%") = 0.4;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_75_40"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.75;
VeganDietShare("World","%Scenario%") = 0.4;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;

$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_100_40"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 1;
VeganDietShare("World","%Scenario%") = 0.4;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


*
$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_0_60"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0;
VeganDietShare("World","%Scenario%") = 0.6;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_25_60"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.25;
VeganDietShare("World","%Scenario%") = 0.6;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_50_60"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.5;
VeganDietShare("World","%Scenario%") = 0.6;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_75_60"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.75;
VeganDietShare("World","%Scenario%") = 0.6;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_100_60"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 1;
VeganDietShare("World","%Scenario%") = 0.6;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;

*



$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_0_80"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0;
VeganDietShare("World","%Scenario%") = 0.8;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;

$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_25_80"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.25;
VeganDietShare("World","%Scenario%") = 0.8;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_50_80"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.5;
VeganDietShare("World","%Scenario%") = 0.8;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_75_80"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.75;
VeganDietShare("World","%Scenario%") = 0.8;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;

$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_100_80"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 1;
VeganDietShare("World","%Scenario%") = 0.8;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_0_100"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0;
VeganDietShare("World","%Scenario%") = 1;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_25_100"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.25;
VeganDietShare("World","%Scenario%") = 1;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_50_100"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.5;
VeganDietShare("World","%Scenario%") = 1;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;



$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_75_100"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.75;
VeganDietShare("World","%Scenario%") = 1;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;


$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_100_100"
$setglobal CropRotationDesign "Barbieri"

*Here introduce new global variable: choose between organic or conventional optimization (use agronomic constraints? Yes (organic) /No (conventional))
$setglobal UseAgronomicConstraints "Yes"
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 1;
VeganDietShare("World","%Scenario%") = 1;
CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%") = 1;
FertilizerUseShare_HumanFaeces(Regions_MR,"Organic","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_HumanFaeces(Regions_MR,"Convent","AllProdCond","%Scenario%")$VPopulationNumbers_MR.l(Regions_MR,"PopulationAll","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_ValueChainWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Waste_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Organic","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
FertilizerUseShare_EndUseFoodWaste(Regions_MR,Commodities_MR,"Convent","AllProdCond","%Scenario%")$VCommod_Food_MR.l(Regions_MR,Commodities_MR,"ALlProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Organic","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
PermanentGrassFertilizerUseShare(Regions_MR,"Convent","AllProdCond","%Scenario%")$VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Permanent meadows and pastures","AllProdSyst","AllProdCond","FOFA_BAU_2050") = 0;
*choose crop residue management systems for vegan scenarios - leave it as in the default for conventional scenarios, adjust for the organic scenarios:
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","%Scenario%")
                 $CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system",CropResManSystem,"Organic","AllProdCond","FOFA_BAU_2050")
         = eps;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Biogas","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.05;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Composting","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Cut and carry","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;
CropResidues_Management_MR(Regions_MR,CropsAndTempGrassActivities,"Average residues (t)","Quantity share in CropResMan system","Silage","Organic",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndTempGrassActivities,"AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = 0.3;

*derive the area shares based on an optimization that yet has to be run:
*$include XX_optimization_code_210421

$endif;

*now run the code specific to organ/vegan scenarios, using the parameter choices done above
$include _V6_ScenarioSpecifications_AuxVegan

$goto EndOfScenarioSpecifications









$label EndOfScenarioSpecifications


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************












$exit;

* 10.06.2021 kray - Below, a generalized script is used for all scenarios...



*XX) Scenario 0: Vegan-conventional 1 (BAU, reduced areas)
******************************************************************************************************************************************************************************
$label FOFA_2050_VeganConv_0

OrganicShare = 0;
VeganShare = 1;
$setglobal CropRotationDesign "ReducedAreas"


*include modules
*remove optimization code later..
$include XX_optimization_code_210421
$include XX_GeneralizedScenarioVeganOrganic
$goTo EndOfScenarioSpecifications

*XX) Scenario 1: Vegan-conventional 2 (BAU, without animal system - default)
***************************************************************************************
$label FOFA_2050_VeganConv_1

OrganicShare = 0;
VeganShare = 1;
$setglobal CropRotationDesign "None"


*include module
$include XX_GeneralizedScenarioVeganOrganic
$goTo EndOfScenarioSpecifications


*XX) Scenario 2: Vegan-organic 1 (crop rotation based on Barbieri, 2017)
***************************************************************************************
$label FOFA_2050_VeganOrgBarb_2

OrganicShare = 1;
VeganShare = 1;
$setglobal CropRotationDesign "Barbieri"


*include module
$include XX_GeneralizedScenarioVeganOrganic
$goTo EndOfScenarioSpecifications


*XX) Scenario 3: Vegan-organic 2 (crop rotation based on Schmidt, 2003)
***************************************************************************************
$label FOFA_2050_VeganOrgSchmidt_3

OrganicShare = 1;
VeganShare = 1;
$setglobal CropRotationDesign "Schmidt"


*include module
$include XX_GeneralizedScenarioVeganOrganic
$goTo EndOfScenarioSpecifications


*XX) Scenario 4: Vegan-organic 3 (crop rotation based on optimization)
***************************************************************************************
$label FOFA_2050_VeganOrgOpt_4

OrganicShare = 1;
VeganShare = 1;
$setglobal CropRotationDesign "Optimized"


*include module
$include XX_GeneralizedScenarioVeganOrganic
$goTo EndOfScenarioSpecifications

















$goto EndOfScenarioSpecifications

















$ontext;

100% Bio: tiefere Ertr�ge gem�sse Seufert et al. 2012; kein MInerald�nger
20% Fl�chen Leguminosen: anteile wie in Baseline von Cropland nehmen
30% Off season legume leys

then: + No fooc-competing feed.

then: + less wastage 50%



50% Bio: tiefere Ertr�ge gem�sse Seufert et al. 2012; kein MInerald�nger
20% Fl�chen Leguminosen: anteile wie in Baseline von Cropland nehmen
30% Off season legume leys
Energy crops: 10% less yield in organic
No fooc-competing feed.

then: + less wastage 50%


Indikatoren:
Land use cropland grassland
Stickstoffbilanz OECD

$offtext;


$label EndOfScenarioSpecifications
