PUTCLOSE con, "_V6_ScenarioSpecifications_AuxUNISECO_AF";

*GENERAL DESCRIPTION
*This file contains all the code needed to specify all the different scenarios used for doing the UNISECO agroforestry sensitivity analysis - for details, see the respective part in the module ScenarioSpecifications

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) UNISECO AF sensitivity analysis specifications
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) UNISECO AF sensitivity analysis specifications

$ontext;
we need specifications for the following 104 scenarios; the basis behind this is the following:

*the UNISECO AF scenarios are differentiated by 5 parameters:
         1) %WW% share AF                     -       medium/low/high coded as M/L/H
         2) %XX% compnent shares crops/trees  -       medium/low/high coded as M/L/H
         3) %YY% AF yields                    -       low/high coded as L/H
         4) %CC% C sequestration              -       medium/low/high coded as M/L/H
         5) %RR% organic share outside the EU -       5% / 25% coded as 5/25

*thus name the scenarios as follows:
UNISECO_AF_sh%WW%_comp%XX%_y%YY%_c%CC%_%RR% e.g. UNISECO_AF_shM_compM_yL_cM_5 is the default AF scenario for UNISECO
$offtext;

$ontext;
the various scenarios are the following

1-9
UNISECO_AF_shM_compM_yL_cM_5
UNISECO_AF_shL_compM_yL_cM_5
UNISECO_AF_shH_compM_yL_cM_5

UNISECO_AF_shM_compL_yL_cM_5
UNISECO_AF_shL_compL_yL_cM_5
UNISECO_AF_shH_compL_yL_cM_5

UNISECO_AF_shM_compH_yL_cM_5
UNISECO_AF_shL_compH_yL_cM_5
UNISECO_AF_shH_compH_yL_cM_5

10-18
UNISECO_AF_shM_compM_yH_cM_5
UNISECO_AF_shL_compM_yH_cM_5
UNISECO_AF_shH_compM_yH_cM_5

UNISECO_AF_shM_compL_yH_cM_5
UNISECO_AF_shL_compL_yH_cM_5
UNISECO_AF_shH_compL_yH_cM_5

UNISECO_AF_shM_compH_yH_cM_5
UNISECO_AF_shL_compH_yH_cM_5
UNISECO_AF_shH_compH_yH_cM_5



19-27
UNISECO_AF_shM_compM_yL_cL_5
UNISECO_AF_shL_compM_yL_cL_5
UNISECO_AF_shH_compM_yL_cL_5

UNISECO_AF_shM_compL_yL_cL_5
UNISECO_AF_shL_compL_yL_cL_5
UNISECO_AF_shH_compL_yL_cL_5

UNISECO_AF_shM_compH_yL_cL_5
UNISECO_AF_shL_compH_yL_cL_5
UNISECO_AF_shH_compH_yL_cL_5

28-36
UNISECO_AF_shM_compM_yH_cL_5
UNISECO_AF_shL_compM_yH_cL_5
UNISECO_AF_shH_compM_yH_cL_5

UNISECO_AF_shM_compL_yH_cL_5
UNISECO_AF_shL_compL_yH_cL_5
UNISECO_AF_shH_compL_yH_cL_5

UNISECO_AF_shM_compH_yH_cL_5
UNISECO_AF_shL_compH_yH_cL_5
UNISECO_AF_shH_compH_yH_cL_5



37-45
UNISECO_AF_shM_compM_yL_cH_5
UNISECO_AF_shL_compM_yL_cH_5
UNISECO_AF_shH_compM_yL_cH_5

UNISECO_AF_shM_compL_yL_cH_5
UNISECO_AF_shL_compL_yL_cH_5
UNISECO_AF_shH_compL_yL_cH_5

UNISECO_AF_shM_compH_yL_cH_5
UNISECO_AF_shL_compH_yL_cH_5
UNISECO_AF_shH_compH_yL_cH_5

46-54
UNISECO_AF_shM_compM_yH_cH_5
UNISECO_AF_shL_compM_yH_cH_5
UNISECO_AF_shH_compM_yH_cH_5

UNISECO_AF_shM_compL_yH_cH_5
UNISECO_AF_shL_compL_yH_cH_5
UNISECO_AF_shH_compL_yH_cH_5

UNISECO_AF_shM_compH_yH_cH_5
UNISECO_AF_shL_compH_yH_cH_5
UNISECO_AF_shH_compH_yH_cH_5





55-63
UNISECO_AF_shM_compM_yL_cM_25
UNISECO_AF_shL_compM_yL_cM_25
UNISECO_AF_shH_compM_yL_cM_25

UNISECO_AF_shM_compL_yL_cM_25
UNISECO_AF_shL_compL_yL_cM_25
UNISECO_AF_shH_compL_yL_cM_25

UNISECO_AF_shM_compH_yL_cM_25
UNISECO_AF_shL_compH_yL_cM_25
UNISECO_AF_shH_compH_yL_cM_25

64-72
UNISECO_AF_shM_compM_yH_cM_25
UNISECO_AF_shL_compM_yH_cM_25
UNISECO_AF_shH_compM_yH_cM_25

UNISECO_AF_shM_compL_yH_cM_25
UNISECO_AF_shL_compL_yH_cM_25
UNISECO_AF_shH_compL_yH_cM_25

UNISECO_AF_shM_compH_yH_cM_25
UNISECO_AF_shL_compH_yH_cM_25
UNISECO_AF_shH_compH_yH_cM_25



73-81
UNISECO_AF_shM_compM_yL_cL_25
UNISECO_AF_shL_compM_yL_cL_25
UNISECO_AF_shH_compM_yL_cL_25

UNISECO_AF_shM_compL_yL_cL_25
UNISECO_AF_shL_compL_yL_cL_25
UNISECO_AF_shH_compL_yL_cL_25

UNISECO_AF_shM_compH_yL_cL_25
UNISECO_AF_shL_compH_yL_cL_25
UNISECO_AF_shH_compH_yL_cL_25

82-90
UNISECO_AF_shM_compM_yH_cL_25
UNISECO_AF_shL_compM_yH_cL_25
UNISECO_AF_shH_compM_yH_cL_25

UNISECO_AF_shM_compL_yH_cL_25
UNISECO_AF_shL_compL_yH_cL_25
UNISECO_AF_shH_compL_yH_cL_25

UNISECO_AF_shM_compH_yH_cL_25
UNISECO_AF_shL_compH_yH_cL_25
UNISECO_AF_shH_compH_yH_cL_25



91-99
UNISECO_AF_shM_compM_yL_cH_25
UNISECO_AF_shL_compM_yL_cH_25
UNISECO_AF_shH_compM_yL_cH_25

UNISECO_AF_shM_compL_yL_cH_25
UNISECO_AF_shL_compL_yL_cH_25
UNISECO_AF_shH_compL_yL_cH_25

UNISECO_AF_shM_compH_yL_cH_25
UNISECO_AF_shL_compH_yL_cH_25
UNISECO_AF_shH_compH_yL_cH_25

100-108
UNISECO_AF_shM_compM_yH_cH_25
UNISECO_AF_shL_compM_yH_cH_25
UNISECO_AF_shH_compM_yH_cH_25

UNISECO_AF_shM_compL_yH_cH_25
UNISECO_AF_shL_compL_yH_cH_25
UNISECO_AF_shH_compL_yH_cH_25

UNISECO_AF_shM_compH_yH_cH_25
UNISECO_AF_shL_compH_yH_cH_25
UNISECO_AF_shH_compH_yH_cH_25

$offtext;

$ontext;
*the UNISECO AF scenarios are differentiated by 5 parameters resulting in 108 combinations, i.e. 108 options in the option space:
         1) %WW% share AF                     -       medium/low/high coded as M/L/H
         2) %XX% compnent shares crops/trees  -       medium/low/high coded as M/L/H
         3) %YY% AF yields                    -       low/high coded as L/H
         4) %CC% C sequestration              -       medium/low/high coded as M/L/H
         5) %RR% organic share outside the EU -       5% / 25% coded as 5/25
$offtext;

*1-9
$ifthen %Scenario% == "UNISECO_AF_shM_compM_yL_cM_5"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compM_yL_cM_5"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compM_yL_cM_5"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shM_compL_yL_cM_5"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compL_yL_cM_5"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compL_yL_cM_5"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shM_compH_yL_cM_5"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compH_yL_cM_5"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compH_yL_cM_5"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "L"
$setglobal OrganicAreaShareSet "5"
$endif;

*10-18
$ifthen %Scenario% == "UNISECO_AF_shM_compM_yH_cM_5"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compM_yH_cM_5"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compM_yH_cM_5"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shM_compL_yH_cM_5"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compL_yH_cM_5"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compL_yH_cM_5"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shM_compH_yH_cM_5"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compH_yH_cM_5"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "5"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compH_yH_cM_5"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "H"
$setglobal OrganicAreaShareSet "5"
$endif;

*19-27
*....
*55-63

$ifthen %Scenario% == "UNISECO_AF_shM_compM_yL_cM_25"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compM_yL_cM_25"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compM_yL_cM_25"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shM_compL_yL_cM_25"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compL_yL_cM_25"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compL_yL_cM_25"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shM_compH_yL_cM_25"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compH_yL_cM_25"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "L"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compH_yL_cM_25"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "L"
$setglobal OrganicAreaShareSet "25"
$endif;

*64-72
$ifthen %Scenario% == "UNISECO_AF_shM_compM_yH_cM_25"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compM_yH_cM_25"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compM_yH_cM_25"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "M"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shM_compL_yH_cM_25"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compL_yH_cM_25"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compL_yH_cM_25"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "L"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shM_compH_yH_cM_25"
$setglobal AreaShareSet        "M"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shL_compH_yH_cM_25"
$setglobal AreaShareSet        "L"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "H"
$setglobal CSequestrSet       "M"
$setglobal OrganicAreaShareSet "25"
$endif;

$ifthen %Scenario% == "UNISECO_AF_shH_compH_yH_cM_25"
$setglobal AreaShareSet        "H"
$setglobal ComponentShareSet   "H"
$setglobal YieldSet            "H"
$setglobal OrganicAreaShareSet "25"
$endif;

*etc..


*the values below are taken from Deliverable D4.3
*the detailed values are collected in Implementation of Innovations in BioBaM 18112020_Agroforestry.xlsx, in teh Innovations folder in WP4 of UNISECO

***************************************************************************************************************************
*1) %WW% share AF                     -       medium/low/high coded as M/L/H

$if  %AreaShareSet% == "M" $goto AreaShareSet_M
$if  %AreaShareSet% == "L" $goto AreaShareSet_L
$if  %AreaShareSet% == "H" $goto AreaShareSet_H

$label AreaShareSet_M
AF_UNISECO_SensitivityFactor_AreaShares("Organic","%Scenario%") = 0.25;
AF_UNISECO_SensitivityFactor_AreaShares("Convent","%Scenario%") = 0.3333333333333;
$goto EndOfAreaShareSetValues

$label AreaShareSet_L
AF_UNISECO_SensitivityFactor_AreaShares("Organic","%Scenario%") = 0.15;
AF_UNISECO_SensitivityFactor_AreaShares("Convent","%Scenario%") = 0.2;
$goto EndOfAreaShareSetValues

$label AreaShareSet_H
AF_UNISECO_SensitivityFactor_AreaShares("Organic","%Scenario%") = 0.4;
AF_UNISECO_SensitivityFactor_AreaShares("Convent","%Scenario%") = 0.55;
$goto EndOfAreaShareSetValues

$label EndOfAreaShareSetValues
***************************************************************************************************************************
*2) %XX% component shares crops/trees  -       medium/low/high coded as M/L/H

$if  %ComponentShareSet% == "M" $goto ComponentShareSet_M
$if  %ComponentShareSet% == "L" $goto ComponentShareSet_L
$if  %ComponentShareSet% == "H" $goto ComponentShareSet_H

$label ComponentShareSet_M
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Mediterranean,"All crops and grass","All agrof. trees","%Scenario%") = 0.94;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Mediterranean,"All crops and grass","All agrof. trees","%Scenario%") = 0.06;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Atlantic,"All crops and grass","All agrof. trees","%Scenario%")      = 0.85;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Atlantic,"All crops and grass","All agrof. trees","%Scenario%")      = 0.15;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Continental_PlusCH,"All crops","All agrof. trees","%Scenario%")      = 0.9;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Continental_PlusCH,"All crops","All agrof. trees","%Scenario%")      = 0.1;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Continental_PlusCH,"Grass","All agrof. trees","%Scenario%")          = 0.85;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Continental_PlusCH,"Grass","All agrof. trees","%Scenario%")          = 0.15;
$goto EndOfComponentShareSetValues

$label ComponentShareSet_L
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Mediterranean,"All crops and grass","All agrof. trees","%Scenario%") = 0.85;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Mediterranean,"All crops and grass","All agrof. trees","%Scenario%") = 0.15;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Atlantic,"All crops and grass","All agrof. trees","%Scenario%")      = 0.75;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Atlantic,"All crops and grass","All agrof. trees","%Scenario%")      = 0.25;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Continental_PlusCH,"All crops","All agrof. trees","%Scenario%")      = 0.8;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Continental_PlusCH,"All crops","All agrof. trees","%Scenario%")      = 0.2;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Continental_PlusCH,"Grass","All agrof. trees","%Scenario%")          = 0.75;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Continental_PlusCH,"Grass","All agrof. trees","%Scenario%")          = 0.25;
$goto EndOfComponentShareSetValues

$label ComponentShareSet_H
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Mediterranean,"All crops and grass","All agrof. trees","%Scenario%") = 0.95;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Mediterranean,"All crops and grass","All agrof. trees","%Scenario%") = 0.05;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Atlantic,"All crops and grass","All agrof. trees","%Scenario%")      = 0.9;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Atlantic,"All crops and grass","All agrof. trees","%Scenario%")      = 0.1;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Continental_PlusCH,"All crops","All agrof. trees","%Scenario%")      = 0.95;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Continental_PlusCH,"All crops","All agrof. trees","%Scenario%")      = 0.05;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Continental_PlusCH,"Grass","All agrof. trees","%Scenario%")          = 0.9;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Continental_PlusCH,"Grass","All agrof. trees","%Scenario%")          = 0.1;
$goto EndOfComponentShareSetValues

$label EndOfComponentShareSetValues
***************************************************************************************************************************
*3) %YY% AF yields                    -       low/high coded as L/H

$if  %YieldSet% == "L" $goto YieldSet_L
$if  %YieldSet% == "H" $goto YieldSet_H

$label YieldSet_L
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","All agrof. trees","%Scenario%")     = 0.85;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All cereals","All agrof. trees","%Scenario%")             = 0.7;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All starchy roots","All agrof. trees","%Scenario%")       = 0.6;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All Forage crops","All agrof. trees","%Scenario%")        = 0.95;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"Maize for Forage+Silage","All agrof. trees","%Scenario%") = 0.5;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All vegetables","All agrof. trees","%Scenario%")          = 1;

AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","All agrof. trees","%Scenario%")     = 0.85;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Olives","%Scenario%")               = 0.75;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Apples","%Scenario%")               = 1;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Pears","%Scenario%")                = 1;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Quinces","%Scenario%")              = 1;
$goto EndOfYieldSetValues

$label YieldSet_H
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","All agrof. trees","%Scenario%")     = 0.9;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All cereals","All agrof. trees","%Scenario%")             = 0.85;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All starchy roots","All agrof. trees","%Scenario%")       = 0.8;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All Forage crops","All agrof. trees","%Scenario%")        = 1;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"Maize for Forage+Silage","All agrof. trees","%Scenario%") = 0.75;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All vegetables","All agrof. trees","%Scenario%")          = 1;

AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","All agrof. trees","%Scenario%")     = 0.9;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Olives","%Scenario%")               = 0.85;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Apples","%Scenario%")               = 1;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Pears","%Scenario%")                = 1;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Quinces","%Scenario%")              = 1;
$goto EndOfYieldSetValues

$label EndOfYieldSetValues
***************************************************************************************************************************
*4) %CC% C sequestration              -       medium/low/high coded as M/L/H


$if  %CSequestrSet% == "M" $goto CSequestrSet_M
$if  %CSequestrSet% == "L" $goto CSequestrSet_L
$if  %CSequestrSet% == "H" $goto CSequestrSet_H

$label CSequestrSet_M
AF_UNISECO_SensitivityFactor_CInWoodyBiomass(FAO_EuropeanUnion_PlusCH,"All crops","All agrof. trees","%Scenario%") = 1;
AF_UNISECO_SensitivityFactor_CInWoodyBiomass(FAO_EuropeanUnion_PlusCH,"Grass","All agrof. trees","%Scenario%")     = 1;
$goto EndOfCSequestrSetValues

$label CSequestrSet_L
AF_UNISECO_SensitivityFactor_CInWoodyBiomass(FAO_EuropeanUnion_PlusCH,"All crops","All agrof. trees","%Scenario%") = 0.8;
AF_UNISECO_SensitivityFactor_CInWoodyBiomass(FAO_EuropeanUnion_PlusCH,"Grass","All agrof. trees","%Scenario%")     = 0.8;
$goto EndOfCSequestrSetValues

$label CSequestrSet_H
AF_UNISECO_SensitivityFactor_CInWoodyBiomass(FAO_EuropeanUnion_PlusCH,"All crops","All agrof. trees","%Scenario%") = 1.2;
AF_UNISECO_SensitivityFactor_CInWoodyBiomass(FAO_EuropeanUnion_PlusCH,"Grass","All agrof. trees","%Scenario%")     = 1.2;
$goto EndOfCSequestrSetValues


$label EndOfCSequestrSetValues
***************************************************************************************************************************
*5) %RR% organic share outside the EU -       5% / 25% coded as 5/25

$if  %OrganicAreaShareSet% == "5" $goto OrganicAreaShareSet_5
$if  %OrganicAreaShareSet% == "25"  $goto OrganicAreaShareSet_25

$label OrganicAreaShareSet_5
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.05;
OrganicAreaShare(Regions_MR,"All crops and grass","AllProdCond","%Scenario%") = 0.05;
OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%") = 0.25;
$goto EndOfOrganicAreaShareSetValues

$label OrganicAreaShareSet_25
OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.25;
OrganicAreaShare(Regions_MR,"All crops and grass","AllProdCond","%Scenario%") = 0.25;
OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%") = 0.25;
$goto EndOfOrganicAreaShareSetValues

$label EndOfOrganicAreaShareSetVAlues
***************************************************************************************************************************

















$exit;

Then the same with the other parametertypes



$ifthen %Scenario% == "UNISECO_AF_shM_compM_yL_cM_5"
AF_UNISECO_SensitivityFactor_AreaShares("Organic","%Scenario%") = 0.25;
AF_UNISECO_SensitivityFactor_AreaShares("Convent","%Scenario%") = 0.3333333333333;

AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Mediterranean,"All crops and grass","All agrof. trees","%Scenario%") = 0.94;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Mediterranean,"All crops and grass","All agrof. trees","%Scenario%") = 0.06;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Atlantic,"All crops and grass","All agrof. trees","%Scenario%")      = 0.85;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Atlantic,"All crops and grass","All agrof. trees","%Scenario%")      = 0.15;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Continental_PlusCH,"All crops","All agrof. trees","%Scenario%")      = 0.9;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Continental_PlusCH,"All crops","All agrof. trees","%Scenario%")      = 0.1;
AF_UNISECO_SensitivityFactor_CropComponentShares(EU_Continental_PlusCH,"Grass","All agrof. trees","%Scenario%")          = 0.85;
AF_UNISECO_SensitivityFactor_TreeComponentShares(EU_Continental_PlusCH,"Grass","All agrof. trees","%Scenario%")          = 0.15;

AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","All agrof. trees","%Scenario%")     = 0.85;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All cereals","All agrof. trees","%Scenario%")             = 0.7;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All starchy roots","All agrof. trees","%Scenario%")       = 0.6;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All Forage crops","All agrof. trees","%Scenario%")        = 0.95;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"Maize for Forage+Silage","All agrof. trees","%Scenario%") = 0.5;
AF_UNISECO_SensitivityFactor_CropYieldFactor(FAO_EuropeanUnion_PlusCH,"All vegetables","All agrof. trees","%Scenario%")          = 1;

AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","All agrof. trees","%Scenario%")     = 0.85;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Olives","%Scenario%")               = 0.75;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Apples","%Scenario%")               = 1;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Pears","%Scenario%")                = 1;
AF_UNISECO_SensitivityFactor_TreeYieldFactor(FAO_EuropeanUnion_PlusCH,"All crops and grass","Quinces","%Scenario%")              = 1;

*AF_UNISECO_SensitivityFactor_SilvoPastoral_CInWoodyBiomass(Regions,"%Scenario%")
*AF_UNISECO_SensitivityFactor_SilvoArable_CInWoodyBiomass(Regions,"%Scenario%")

OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%") = 0.05;
OrganicAreaShare(Regions_MR,"All crops and grass","AllProdCond","%Scenario%") = 0.05;
OrganicAreaShare(FAO_EuropeanUnion_PlusCH,"All crops and grass","AllProdCond","%Scenario%") = 0.25;
$endif;



