PUTCLOSE con, "_V6_ScenarioSpecifications_AuxVegan";

*GENERAL DESCRIPTION
*This file contains all the code needed to specify all the different scenarios used for doing the vegan calculations
*it thus also allows for pure organic scenarios, when setting VeganShare=0
*for running it, the scenario specifications need to indicate three choices:
*         - crop rotation design
*         - organic area share
*         - share of vegan diets
*this is captured via
*        %CropRotationDesign%
*        OrganicAreaShare(Regions,Activities,ProductionConditions,Scenarios)
*        VeganDietShare(Regions,Scenarios)


*DETAILED TABLE OF CONTENTS
$ontext;
- 1) assign crop rotation shares to different countries (similar to ReadData_LuEtAl_NDepositionData.gms)
         1.1) Crop rotation design scheme: Barbieri
         1.2) Crop rotation design scheme: Schmidt
         1.3) Crop rotation design scheme: Optimization
         1.4) Crop rotation design scheme: BAU
- 2) assign areas
$offtext;


*MODEL CODE:

***************************************************************************************************************
***************************************************************************************************************
*Generalized Scenario template for vegan-organic scenarios
***************************************************************************************************************
***************************************************************************************************************
*09.06.2021, Patricia Krayer
*amended by Adrian Muller, 11.6.2021

*specify the different vegan scenarios:
*this needs specitifation of
*         - crop rotation design
*         - organic area share
*         - share of vegan diets
*this is captured via
*        %CropRotationDesign%
*        OrganicAreaShare(Regions,Activities,ProductionConditions,Scenarios)
*        VeganDietShare(Regions,Scenarios)
*
$ontext;
possible crop rotation choices:
*$if %CropRotationDesign% == "Barbieri" $goto BarbieriCropRot
*$if %CropRotationDesign% == "Schmidt" $goto SchmidtCropRot
*$if %CropRotationDesign% == "Optimized" $goto OptimizedCropRot
*$if %CropRotationDesign% == "BAU" $goto BAUCropRot
$offtext;

$ontext;
*vegan scenarios:

The following is now moved to the main scenario specification file - to be deleted here


$ifthen %Scenario% == "FOFA_2050_VeganBAU"
$setglobal CropRotationDesign "BAU"
$endif;

$ifthen %Scenario% == "FOFA_2050_VeganBarbieri"
$setglobal CropRotationDesign "Barbieri"
$endif;

$ifthen %Scenario% == "FOFA_2050_VeganBarbieri_a"
$setglobal CropRotationDesign "Barbieri"
$endif;

$ifthen %Scenario% == "FOFA_2050_VeganSchmidt"
$setglobal CropRotationDesign "Schmidt"
$endif;

$ifthen %Scenario% == "FOFA_2050_VeganOptimized"
$setglobal CropRotationDesign "Optimized"

$include XX_optimization_code_210421

$endif;
$offtext;



*************************************************************************************************************************************************
*************************************************************************************************************************************************
*1) assign crop rotation shares to different countries (similar to ReadData_LuEtAl_NDepositionData.gms)

$if %CropRotationDesign% == "Barbieri" $goto BarbieriCropRot
$if %CropRotationDesign% == "Schmidt" $goto SchmidtCropRot
$if %CropRotationDesign% == "Optimized" $goto OptimizedCropRot
$if %CropRotationDesign% == "BAU" $goto BAUCropRot

********************************************************************************************************************
*1.1) Crop rotation design scheme: Barbieri
********************************************************************************************************************
$label BarbieriCropRot

* Based on Barbieri et al.(2017), the following crop rotation shares are assigned
*
*               Cereals1 Cereals2    Pulses  Oilseed    Root crops   vegetable   fruits  SetAside
* WestEurope       22%     22%         14%     1%          9%           7%         1%      25%
* Northern America 40%     12%         22%     3%          1%           2%         4%      17%
* Others           30%     19%         9%      2%          0%           4%        2.5%     38%

*Decisions:
*-"industrials" added to fruits
*-"pulses/legumes" split between cereals2 and legumes
*For Region "Others": oilseeds and fruits with 0%: take mean of Western Europe and Northern America
*For Region "Others": keep share total of Cereals1 + Cereals2 + Root crops (= 49% -> All starchy crops). Use the country-specific share of root crops vs. cereals for the
*                     share of specific groups


*Assign regional values
*************************************************************************************************************************************************
*below, I reduced Cereals2 from 0.22 to 0.21 (WE) and Pulses from 0.22 to 0.21 (NA) to have 1 in the sum of all shares:
*Western Europe
CropRotationShare("Western Europe", "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%") =  0.22;
CropRotationShare("Western Europe", "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%") =  0.21;
CropRotationShare("Western Europe", "All_pulses_V",ProdSyst_OrgCon,"%Scenario%") =  0.14;
CropRotationShare("Western Europe", "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%") =  0.01;
CropRotationShare("Western Europe", "All starchy roots",ProdSyst_OrgCon,"%Scenario%") =  0.09;
CropRotationShare("Western Europe", "All Vegetables",ProdSyst_OrgCon,"%Scenario%") = 0.07;
CropRotationShare("Western Europe", "All_fruits_V",ProdSyst_OrgCon,"%Scenario%") =  0.01;
CropRotationShare("Western Europe", "All_setAside_V",ProdSyst_OrgCon,"%Scenario%") =  0.25;
*Northern America
CropRotationShare("Northern America", "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%") =  0.4;
CropRotationShare("Northern America", "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%") =  0.12;
CropRotationShare("Northern America", "All_pulses_V",ProdSyst_OrgCon,"%Scenario%") =  0.21;
CropRotationShare("Northern America", "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%") =  0.03;
CropRotationShare("Northern America", "All starchy roots",ProdSyst_OrgCon,"%Scenario%") =  0.01;
CropRotationShare("Northern America", "All Vegetables",ProdSyst_OrgCon,"%Scenario%") = 0.02;
CropRotationShare("Northern America", "All_fruits_V",ProdSyst_OrgCon,"%Scenario%") =  0.04;
CropRotationShare("Northern America", "All_setAside_V",ProdSyst_OrgCon,"%Scenario%") =  0.17;

*assign the shares for the non-vegan organic rotations as well:
CropRotationShare("Western Europe", "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.21;
CropRotationShare("Western Europe", "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.09;
CropRotationShare("Northern America", "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.12;
CropRotationShare("Northern America", "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.01;

*starchy crops is the sum of cereals1, cereals2 and starchyroots:
CropRotationShare("Western Europe", "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%") = 0.52;
CropRotationShare("Western Europe", "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.52;

CropRotationShare("Northern America", "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%") = 0.53;
CropRotationShare("Northern America", "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.53;

*although the sets are the same, we also need the potentially different shares for the Non-Vegan groups (see below):
*Western Europe
CropRotationShare("Western Europe", "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.22;
CropRotationShare("Western Europe", "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.14;
CropRotationShare("Western Europe", "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.01;
CropRotationShare("Western Europe", "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.07;
CropRotationShare("Western Europe", "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.01;
CropRotationShare("Western Europe", "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.25;
*Northern America
CropRotationShare("Northern America", "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.4;
CropRotationShare("Northern America", "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.21;
CropRotationShare("Northern America", "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.03;
CropRotationShare("Northern America", "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.02;
CropRotationShare("Northern America", "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.04;
CropRotationShare("Northern America", "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.17;


*now assign the regional values to the single countries:
*************************************************************************************************************************************************
CropRotationShare(Countries, Activities,ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, Activities,ProdSyst_OrgCon,"%Scenario%"))
         = sum(Regions$Match_GeographicAggregates_SingleCountries(Regions,Countries),
                 CropRotationShare(Regions, Activities,ProdSyst_OrgCon,"%Scenario%"));


*below, I changed fruits from 0.025 to 0.03 and veget from 0.037 to 0.04 and starch crops to 0.48 and set aside to 0.36 to have 1 in the sum of all shares
*assign values to other countries (those that have no values until now)
*************************************************************************************************************************************************
CropRotationShare(Countries, "All_pulses_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_pulses_V",ProdSyst_OrgCon,"%Scenario%")) =  0.09;
CropRotationShare(Countries, "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%")) =  0.02;
CropRotationShare(Countries, "All Vegetables",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All Vegetables",ProdSyst_OrgCon,"%Scenario%")) = 0.03;
CropRotationShare(Countries, "All_fruits_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_fruits_V",ProdSyst_OrgCon,"%Scenario%")) = 0.02;
CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")) =  0.48;
CropRotationShare(Countries, "All_setAside_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_setAside_V",ProdSyst_OrgCon,"%Scenario%")) =  0.36;

CropRotationShare(Countries, "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.09;
CropRotationShare(Countries, "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.02;
CropRotationShare(Countries, "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%")) = 0.03;
CropRotationShare(Countries, "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%")) = 0.02;
CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.48;
CropRotationShare(Countries, "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.36;


*assign shares of cereals1, cereals2 and starchy roots as parts of starchy crops to "other countries"
*************************************************************************************************************************************************

*First calculate FOFA2050 values as reference:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals1_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals1_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals1_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals2_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals2_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals2_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All starchy roots","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyRoots,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyRoots,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_starchyCrops_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyCrops_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyCrops_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*and for the non-vegan sets:
*cereals1: set is identical to _V
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals1_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals1_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals1_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals2_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals2_NonV,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals2_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_StarchyRoots_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyRoots_NonV,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyRoots_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_starchyCrops_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyCrops_NonV,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyCrops_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
;

CropRotationShare(Countries, "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals1_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals2_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All starchy roots",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All starchy roots",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All starchy roots","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");

*and for the non-vegan organic rotations:
*cereals1: same set as Cereals1_NonV - but shares in starch crops and in totals may be different, due to different sets for Cereals2_NonV and StarchRoots_NonV
CropRotationShare(Countries, "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals1_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals2_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_StarchyRoots_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");


$goto ContinueWithAssignment



********************************************************************************************************************
*Crop rotation design scheme: Schmidt
********************************************************************************************************************

$label SchmidtCropRot
* Based on Schmidt (2003), the following crop rotation shares are assigned
*
*               Cereals1   Cereals2   Pulses  Oilseed    Root crops  vegetable   fruits  SetAside
* All Coutries      26%      25%        13%     1%          11%         4%         0%       19%

*Decisions:
*-"pulses/legumes" split between cereals2 and legumes
*-add 0.5% to fruits (these are only strawberries) from vegetables

*************************************************************************************************************************************************
*0 - Assign values
*************************************************************************************************************************************************

*below, I changed vegetables from 0.035 to 0.045 to have 1 in the sum of all shares
*"Western Europe"
CropRotationShare("Western Europe", "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%") =  0.26;
CropRotationShare("Western Europe", "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%") =  0.25;
CropRotationShare("Western Europe", "All_pulses_V",ProdSyst_OrgCon,"%Scenario%") =  0.13;
CropRotationShare("Western Europe", "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%") =  0.01;
CropRotationShare("Western Europe", "All starchy roots",ProdSyst_OrgCon,"%Scenario%") =  0.11;
CropRotationShare("Western Europe", "All Vegetables",ProdSyst_OrgCon,"%Scenario%") = 0.045;
CropRotationShare("Western Europe", "All_fruits_V",ProdSyst_OrgCon,"%Scenario%") =  0.005;
CropRotationShare("Western Europe", "All_setAside_V",ProdSyst_OrgCon,"%Scenario%") =  0.19;

CropRotationShare("Western Europe", "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.25;
CropRotationShare("Western Europe", "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.11;

*although the sets are the same, we also need the potentially different shares for the Non-Vegan groups (see below):
CropRotationShare("Western Europe", "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.26;
CropRotationShare("Western Europe", "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.13;
CropRotationShare("Western Europe", "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.01;
CropRotationShare("Western Europe", "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.045;
CropRotationShare("Western Europe", "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.005;
CropRotationShare("Western Europe", "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.19;

*and we also need the following - sum of cereals1, 2 and starch roots:
CropRotationShare("Western Europe", "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%") =  0.62;
CropRotationShare("Western Europe", "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.62;

*Northern America
CropRotationShare("Northern America", "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%") =  0.26;
CropRotationShare("Northern America", "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%") =  0.25;
CropRotationShare("Northern America", "All_pulses_V",ProdSyst_OrgCon,"%Scenario%") =  0.13;
CropRotationShare("Northern America", "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%") =  0.01;
CropRotationShare("Northern America", "All starchy roots",ProdSyst_OrgCon,"%Scenario%") =  0.11;
CropRotationShare("Northern America", "All Vegetables",ProdSyst_OrgCon,"%Scenario%") = 0.045;
CropRotationShare("Northern America", "All_fruits_V",ProdSyst_OrgCon,"%Scenario%") =  0.005;
CropRotationShare("Northern America", "All_setAside_V",ProdSyst_OrgCon,"%Scenario%") =  0.19;

CropRotationShare("Northern America", "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.25;
CropRotationShare("Northern America", "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.11;

*although the sets are the same, we also need the potentially different shares for the Non-Vegan groups (see below):
CropRotationShare("Northern America", "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.26;
CropRotationShare("Northern America", "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.13;
CropRotationShare("Northern America", "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.01;
CropRotationShare("Northern America", "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.045;
CropRotationShare("Northern America", "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.005;
CropRotationShare("Northern America", "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.19;

*and we also need the following - sum of cereals1, 2 and starch roots:
CropRotationShare("Northern America", "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%") =  0.62;
CropRotationShare("Northern America", "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.62;


*now assign the regional values to the single countries:
*************************************************************************************************************************************************
CropRotationShare(Countries, Activities,ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, Activities,ProdSyst_OrgCon,"%Scenario%"))
         = sum(Regions$Match_GeographicAggregates_SingleCountries(Regions,Countries),
                 CropRotationShare(Regions, Activities,ProdSyst_OrgCon,"%Scenario%"));


*assign values to other countries (those that have no values until now)
*************************************************************************************************************************************************
CropRotationShare(Countries, "All_pulses_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_pulses_V",ProdSyst_OrgCon,"%Scenario%")) =  0.13;
CropRotationShare(Countries, "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%")) =  0.01;
CropRotationShare(Countries, "All Vegetables",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All Vegetables",ProdSyst_OrgCon,"%Scenario%")) = 0.045;
CropRotationShare(Countries, "All_fruits_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_fruits_V",ProdSyst_OrgCon,"%Scenario%")) = 0.005;
CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")) =  0.62;
CropRotationShare(Countries, "All_setAside_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_setAside_V",ProdSyst_OrgCon,"%Scenario%")) =  0.19;

CropRotationShare(Countries, "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.13;
CropRotationShare(Countries, "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.01;
CropRotationShare(Countries, "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%")) = 0.045;
CropRotationShare(Countries, "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%")) = 0.005;
CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.62;
CropRotationShare(Countries, "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.19;


*assign shares of cereals1, cereals2 and starchy roots as parts of starchy crops to "other countries"
*************************************************************************************************************************************************

*First calculate FOFA2050 values as reference:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals1_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals1_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals1_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals2_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals2_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals2_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All starchy roots","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyRoots,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyRoots,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_starchyCrops_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyCrops_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyCrops_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*and for the non-vegan sets:
*cereals1: set is identical to _V
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals1_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals1_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals1_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals2_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals2_NonV,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals2_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_StarchyRoots_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyRoots_NonV,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyRoots_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_starchyCrops_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyCrops_NonV,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyCrops_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
;

CropRotationShare(Countries, "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals1_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals2_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All starchy roots",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All starchy roots",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All starchy roots","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");

*and for the non-vegan organic rotations:
*cereals1: same set as Cereals1_NonV - but shares in starch crops and in totals may be different, due to different sets for Cereals2_NonV and StarchRoots_NonV
CropRotationShare(Countries, "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals1_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals2_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_StarchyRoots_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");


$goto ContinueWithAssignment


********************************************************************************************************************
*1.3) Crop rotation design scheme: Optimization
********************************************************************************************************************

$label OptimizedCropRot


* Based on results of optimization problem, the following crop rotation shares are assigned

* With agronomic constraints (organic) - %UseAgronomicConstraints% == "YES"
* Added 1% to root crops (sums up to 1)
*               Cereals1 Cereals2    Pulses  Oilseed    Root crops        vegetable   fruits  SetAside
* All countries     5%         0%       35%      20%        1%              16%          0%        23%  = 100%



$if %UseAgronomicConstraints% == "No" $goto OptimizedNutritional

CropRotationShare("Western Europe", "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%") =  0.05;
CropRotationShare("Western Europe", "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Western Europe", "All_pulses_V",ProdSyst_OrgCon,"%Scenario%") =  0.35;
CropRotationShare("Western Europe", "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%") =  0.2;
CropRotationShare("Western Europe", "All starchy roots",ProdSyst_OrgCon,"%Scenario%") =  0.01;
CropRotationShare("Western Europe", "All Vegetables",ProdSyst_OrgCon,"%Scenario%") = 0.16;
CropRotationShare("Western Europe", "All_fruits_V",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Western Europe", "All_setAside_V",ProdSyst_OrgCon,"%Scenario%") =  0.23;
*Northern America
CropRotationShare("Northern America", "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%") =  0.05;
CropRotationShare("Northern America", "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Northern America", "All_pulses_V",ProdSyst_OrgCon,"%Scenario%") =  0.35;
CropRotationShare("Northern America", "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%") =  0.2;
CropRotationShare("Northern America", "All starchy roots",ProdSyst_OrgCon,"%Scenario%") =  0.01;
CropRotationShare("Northern America", "All Vegetables",ProdSyst_OrgCon,"%Scenario%") = 0.16;
CropRotationShare("Northern America", "All_fruits_V",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Northern America", "All_setAside_V",ProdSyst_OrgCon,"%Scenario%") =  0.23;

*assign the shares for the non-vegan organic rotations as well:
CropRotationShare("Western Europe", "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.0;
CropRotationShare("Western Europe", "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.01;
CropRotationShare("Northern America", "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.0;
CropRotationShare("Northern America", "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.01;

*starchy crops is the sum of cereals1, cereals2 and starchyroots:
CropRotationShare("Western Europe", "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%") = 0.06;
CropRotationShare("Western Europe", "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.06;

CropRotationShare("Northern America", "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%") = 0.06;
CropRotationShare("Northern America", "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.06;

*although the sets are the same, we also need the potentially different shares for the Non-Vegan groups (see below):
*Western Europe
CropRotationShare("Western Europe", "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.05;
CropRotationShare("Western Europe", "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.35;
CropRotationShare("Western Europe", "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.2;
CropRotationShare("Western Europe", "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.16;
CropRotationShare("Western Europe", "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Western Europe", "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.23;
*Northern America
CropRotationShare("Northern America", "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.05;
CropRotationShare("Northern America", "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.35;
CropRotationShare("Northern America", "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.2;
CropRotationShare("Northern America", "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.16;
CropRotationShare("Northern America", "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Northern America", "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.23;


*now assign the regional values to the single countries:
*************************************************************************************************************************************************
CropRotationShare(Countries, Activities,ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, Activities,ProdSyst_OrgCon,"%Scenario%"))
         = sum(Regions$Match_GeographicAggregates_SingleCountries(Regions,Countries),
                 CropRotationShare(Regions, Activities,ProdSyst_OrgCon,"%Scenario%"));


*assign values to other countries (those that have no values until now)
*************************************************************************************************************************************************
CropRotationShare(Countries, "All_pulses_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_pulses_V",ProdSyst_OrgCon,"%Scenario%")) =  0.35;
CropRotationShare(Countries, "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%")) =  0.2;
CropRotationShare(Countries, "All Vegetables",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All Vegetables",ProdSyst_OrgCon,"%Scenario%")) = 0.16;
CropRotationShare(Countries, "All_fruits_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_fruits_V",ProdSyst_OrgCon,"%Scenario%")) = 0.0;
CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")) =  0.06;
CropRotationShare(Countries, "All_setAside_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_setAside_V",ProdSyst_OrgCon,"%Scenario%")) =  0.23;

CropRotationShare(Countries, "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.35;
CropRotationShare(Countries, "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.2;
CropRotationShare(Countries, "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%")) = 0.16;
CropRotationShare(Countries, "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%")) = 0.0;
CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.06;
CropRotationShare(Countries, "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.23;


$goto ContinueOptimized


*****************here, use the results of optimization without agronomic constraints******************************
$label OptimizedNutritional
* Without agronomic constraints (conventional)
*               Cereals1 Cereals2    Pulses  Oilseed    Root crops        vegetable   fruits  SetAside
* All coutnries     10%      0%        0%      35%         0%                55%          0%   0%        = 100%


CropRotationShare("Western Europe", "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%") =  0.1;
CropRotationShare("Western Europe", "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Western Europe", "All_pulses_V",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Western Europe", "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%") =  0.35;
CropRotationShare("Western Europe", "All starchy roots",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Western Europe", "All Vegetables",ProdSyst_OrgCon,"%Scenario%") = 0.55;
CropRotationShare("Western Europe", "All_fruits_V",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Western Europe", "All_setAside_V",ProdSyst_OrgCon,"%Scenario%") =  0.0;
*Northern America
CropRotationShare("Northern America", "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%") =  0.1;
CropRotationShare("Northern America", "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Northern America", "All_pulses_V",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Northern America", "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%") =  0.35;
CropRotationShare("Northern America", "All starchy roots",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Northern America", "All Vegetables",ProdSyst_OrgCon,"%Scenario%") = 0.55;
CropRotationShare("Northern America", "All_fruits_V",ProdSyst_OrgCon,"%Scenario%") =  0.00;
CropRotationShare("Northern America", "All_setAside_V",ProdSyst_OrgCon,"%Scenario%") =  0.0;

*assign the shares for the non-vegan organic rotations as well:
CropRotationShare("Western Europe", "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.0;
CropRotationShare("Western Europe", "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.0;
CropRotationShare("Northern America", "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.0;
CropRotationShare("Northern America", "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.0;

*starchy crops is the sum of cereals1, cereals2 and starchyroots:
CropRotationShare("Western Europe", "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%") = 0.1;
CropRotationShare("Western Europe", "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.1;

CropRotationShare("Northern America", "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%") = 0.1;
CropRotationShare("Northern America", "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.1;

*although the sets are the same, we also need the potentially different shares for the Non-Vegan groups (see below):
*Western Europe
CropRotationShare("Western Europe", "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.1;
CropRotationShare("Western Europe", "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Western Europe", "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.35;
CropRotationShare("Western Europe", "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.55;
CropRotationShare("Western Europe", "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Western Europe", "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.0;
*Northern America
CropRotationShare("Northern America", "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.1;
CropRotationShare("Northern America", "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Northern America", "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.35;
CropRotationShare("Northern America", "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%") = 0.55;
CropRotationShare("Northern America", "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.0;
CropRotationShare("Northern America", "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%") =  0.0;


*now assign the regional values to the single countries:
*************************************************************************************************************************************************
CropRotationShare(Countries, Activities,ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, Activities,ProdSyst_OrgCon,"%Scenario%"))
         = sum(Regions$Match_GeographicAggregates_SingleCountries(Regions,Countries),
                 CropRotationShare(Regions, Activities,ProdSyst_OrgCon,"%Scenario%"));


*assign values to other countries (those that have no values until now)
*************************************************************************************************************************************************
CropRotationShare(Countries, "All_pulses_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_pulses_V",ProdSyst_OrgCon,"%Scenario%")) =  0.0;
CropRotationShare(Countries, "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_oilCrops_V",ProdSyst_OrgCon,"%Scenario%")) =  0.35;
CropRotationShare(Countries, "All Vegetables",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All Vegetables",ProdSyst_OrgCon,"%Scenario%")) = 0.55;
CropRotationShare(Countries, "All_fruits_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_fruits_V",ProdSyst_OrgCon,"%Scenario%")) = 0.0;
CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")) =  0.1;
CropRotationShare(Countries, "All_setAside_V",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_setAside_V",ProdSyst_OrgCon,"%Scenario%")) =  0.0;

CropRotationShare(Countries, "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_pulses_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.0;
CropRotationShare(Countries, "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_oilCrops_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.35;
CropRotationShare(Countries, "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%")) = 0.55;
CropRotationShare(Countries, "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_fruits_NonV",ProdSyst_OrgCon,"%Scenario%")) = 0.0;
CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.1;
CropRotationShare(Countries, "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%")$(NOT CropRotationShare(Countries, "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%")) =  0.0;

*until here correct assignment
**********************************************************************************************************************
$label ContinueOptimized
*assign shares of cereals1, cereals2 and starchy roots as parts of starchy crops to "other countries"
*************************************************************************************************************************************************

*First calculate FOFA2050 values as reference:
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals1_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals1_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals1_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals2_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals2_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals2_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All starchy roots","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyRoots,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyRoots,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_starchyCrops_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyCrops_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyCrops_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
*and for the non-vegan sets:
*cereals1: set is identical to _V
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals1_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals1_V,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals1_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_cereals2_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(Cereals2_NonV,VActCropsGrass_QuantityActUnits_MR.l(Regions,Cereals2_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_StarchyRoots_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyRoots_NonV,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyRoots_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All_starchyCrops_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") =
                Sum(StarchyCrops_NonV,VActCropsGrass_QuantityActUnits_MR.l(Regions,StarchyCrops_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));

*********************************************************************** Assign here crop rot shares of cereals 1, 2 and starchy roots
CropRotationShare(Countries, "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals1_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals2_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All starchy roots",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All starchy roots",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_V",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All starchy roots","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");


*and for the non-vegan organic rotations:
*cereals1: same set as Cereals1_NonV - but shares in starch crops and in totals may be different, due to different sets for Cereals2_NonV and StarchRoots_NonV
CropRotationShare(Countries, "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals1_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals2_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Countries, "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                         AND (NOT CropRotationShare(Countries, "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%")))
         = CropRotationShare(Countries, "All_starchyCrops_NonV",ProdSyst_OrgCon,"%Scenario%")
                 *VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_StarchyRoots_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
                    / VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");


execute_unload 'CropRot_conv_opt' CropRotationShare;

$goto ContinueWithAssignment






********************************************************************************************************************
*1.4) Crop rotation design scheme: BAU
********************************************************************************************************************

$label BAUCropRot
*In this case, the crop rotation shares are calculated based on the BAU shares

*to derive this, we need the group sepcific areas and relate them to the total areas
*of all crops used in crop rotations
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
            = Sum(CropsUsedInRotations_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
            = Sum(CropsUsedInRotations_NonV,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));

*now derive the shares:
*CropRotShare_cereals = Area_cereals/Area_total (BAU), etc.

CropRotationShare(Regions_MR, "All_cereals1_V",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Cereals1_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals1_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All_cereals2_V",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Cereals2_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals2_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All_Pulses_V",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Pulses_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Pulses_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All_OilCrops_V",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(OilCrops_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OilCrops_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All starchy roots",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(StarchyRoots,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,StarchyRoots,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All Vegetables",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Vegetables,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Vegetables,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All_Fruits_V",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Fruits_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Fruits_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All_setAside_V",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(setAside_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,setAside_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","AllProdSyst","AllProdCond","FOFA_BAU_2050");

CropRotationShare(Regions_MR, "All_cereals2_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Cereals2_NonV,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals2_NonV,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All_StarchyRoots_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(StarchyRoots_NonV,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,StarchyRoots_NonV,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");

*and also for the nonv-shares of the sets that are equal to vegan sets (but the shares can differ):
CropRotationShare(Regions_MR, "All_cereals1_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Cereals1_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals1_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All_Pulses_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Pulses_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Pulses_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All_OilCrops_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(OilCrops_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OilCrops_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All Vegetables_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Vegetables,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Vegetables,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All_Fruits_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Fruits_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Fruits_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");
CropRotationShare(Regions_MR, "All_setAside_NonV",ProdSyst_OrgCon,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(setAside_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,setAside_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"))
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050");

$goto ContinueWithAssignment



$label ContinueWithAssignment

*************************************************************************************************************************************************
*************************************************************************************************************************************************
*2) assign areas and adjust feeding rations and feed use of areas
*first assign areas to organic and conventional systems - then adjust to reflect the chosen crop rotation assumptions specified above


VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%"));

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%");











**********XXXXXXXXXXXXXX kray: added here 11.08.2021 large part (change order)!!

*2.0) derive the shares of crops in fully vegan cropping patterns for conventional area
*Reduction in the areas of crops that have been grown for feed by the amount not needed anymore for animals:
*set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
*no extraction rate added or so, as this is based on MainProducts only (AggregateFeedConcMainProd_Commodity), thus per activity it is only one commodity, usually
*HERE we now do it for vegan share = 1 to derive the shares of crops in fully vegan cropping patterns for conventional area:
*this is done for CONVENTIONAL only - to then be able to allocate the newly free areas in vegan conventional scenarios further down.
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateCommodities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateActivities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_WellDefinedCoProducts_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_ComplexCases_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

*forage crops and other forage crops need to be done specifically, as not included above, where the focus is on Main and byprod Concentrates, not forage:

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,ForageCrops,"MainOutput1 (t)"),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OtherFodderCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OtherFodderCrops,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,OtherFodderCrops,"MainOutput1 (t)"),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

*adjust triticale - to be done separately, as there is no ruminant share factor, thus use the one from Wheat and products and util feed share = 1:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Triticale","Convent",ProductionConditions,"%Scenario%")
         = 0;
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Triticale","Convent",ProductionConditions,"%Scenario%")
*                 *(1 - VeganDietShare("World","%Scenario%"));
*adjust temporary grassland - to be done separately, as not included above:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures","Convent",ProductionConditions,"%Scenario%")
         = 0;
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")
*                 *(1 - VeganDietShare("World","%Scenario%"));

*if such occur: set negative values = 0:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                  $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%") < 0)
         = 0;

**************** kray 110.08.2021 added if-condition here (only valid for BAU crop rotation)
$ifthen %CropRotationDesign"% == "BAU"
*Then calculate the total for the vegan cropping patterns to derive the shares:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","Convent",ProductionConditions,"%Scenario%")
         = Sum(CropsUsedInRotations_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_V,"Convent",ProductionConditions,"%Scenario%"));

*use the parameter CropRotationShare to collect the cropping patterns for conventional vegan areas on activity level:
CropRotationShare(Regions_MR,CropsUsedInRotations_V,"Convent","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","Convent","AllProdCond","%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_V,"Convent","AllProdCond","%Scenario%")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","Convent","AllProdCond","%Scenario%");

$endif;


*The code above is needed to derive the cropping pattern shares to allocate the conventional areas in vegan scenarios (see below)
*after this, the conventional area values are set to zero again and then assigned anew, to have them available for various vegan shares - the code above was only needed to derive the crop rotation shares for vegan cconventional scenarios.
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%") = 0;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%"));


* XXXXXXXXXXXXXXXXXXXXXXXXXXX large part end 11.08.2021



*2.1) Adjust feeding rations and areas for feed use
*not used here, done below AFTER area allocation: DELETE!
*Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*         = Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
*                 *(1 - VeganDietShare("World","%Scenario%"));


*Reduction in the areas of crops that have been grown for feed by the amount not needed anymore for animals:
*set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
*no extraction rate added or so, as this is based on MainProducts only (AggregateFeedConcMainProd_Commodity), thus per activity it is only one commodity, usually
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateCommodities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateActivities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_WellDefinedCoProducts_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_ComplexCases_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *VeganDietShare("World","%Scenario%"))));

*forage crops and other forage crops need to be done specifically, as not included above, where the focus is on Main and byprod Concentrates, not forage:

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,ForageCrops,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,ForageCrops,"MainOutput1 (t)"),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *VeganDietShare("World","%Scenario%"))));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OtherFodderCrops,ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OtherFodderCrops,ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,OtherFodderCrops,"MainOutput1 (t)"),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *VeganDietShare("World","%Scenario%"))));

*adjust triticale - to be done separately, as not included above:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Triticale",ProductionSystems,ProductionConditions,"%Scenario%")
                 *(1 - VeganDietShare("World","%Scenario%"));

********XXXXXXX kray: new according to Adrian (Mail 05.08.2021)
*adjust temporary grassland - to be done separately, as not included above:

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")

         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Temporary meadows and pastures",ProductionSystems,ProductionConditions,"%Scenario%")

                 *(1 - VeganDietShare("World","%Scenario%"));
*XXXXXXXXXXXXXXXX new end

*if such occur: set negative values = 0:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                  $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


*below: should work when summing over all activities in crop rotations nonvegan only - and not suming over all crops and grass!
*TO BE CHECKED and replaced!
*determine the areas that became free for alternative use due to feed production reduction:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All crops and grass",ProductionSystems,ProductionConditions,"%Scenario%")
         = sum(CropsAndCoreGrassActivities,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndCoreGrassActivities,ProductionSystems,ProductionConditions,"%Scenario%"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All crops and grass","AllProdSyst",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All crops and grass","Convent",ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All crops and grass","Organic",ProductionConditions,"%Scenario%");

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All crops and grass","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = sum(CropsAndCoreGrassActivities,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsAndCoreGrassActivities,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));


VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use","AllProdSyst",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All crops and grass","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 - VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All crops and grass","AllProdSyst",ProductionConditions,"%Scenario%");
*delete negative values if such occur (which should not be the case, but to avoid artefacts from incomplete data, e.g. for small island states, etc.):
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use","AllProdSyst",ProductionConditions,"%Scenario%")
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use","AllProdSyst",ProductionConditions,"%Scenario%") < 0)
         = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use","AllProdSyst",ProductionConditions,"%Scenario%")
                 *(1 - OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use","AllProdSyst",ProductionConditions,"%Scenario%")
                 *OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%");

*now assign a share to use for cropands - the rest can be used for nature restoration, etc.
*this is the area redistributed for various cropland use below, the reminder is available for nature conservation, etc.

*XXXXXXXXXXXXXXXX kray: changed here Regions to "World" / changed ProductionSystems to "AllProdSyst"
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Cropland","AllProdSyst",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use","AllProdSyst",ProductionConditions,"%Scenario%")
                 *CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%");
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Conservation","AllProdSyst",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use","AllProdSyst",ProductionConditions,"%Scenario%")
                 *(1 - CropUSeOfNewlyFreeAreas("World","AllProdSyst","%Scenario%"));
*XXXXXXXXXXXXXXXX kray: changed here Regions to "World" end



*and sum the crops used in non-vegan crop rotations to reassign them according to the conventional cropping patterns or organic crop rotations:
*these are the areas still cropped after removing the areas needed for feed:
*the permanent crops remain as they are after reducing feed areas.
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = Sum(CropsUsedInRotations_NonV,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050"));


****************************** what's wrong???
*derive the total area in crop rotations reduced by the areas not used anymore:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","AllProdSyst",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 - VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Conservation","AllProdSyst",ProductionConditions,"%Scenario%");

*********************************




VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","AllProdSyst",ProductionConditions,"%Scenario%")
                 *(1 - OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","AllProdSyst",ProductionConditions,"%Scenario%")
                 *OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%");

************* XXXXXXXXXX kray: delete this below 11.08.2021, according to changes in Sourcetree
$ontext 
*calculating as above results in temp and perm grassland not being reduced due to having less animals
*alternatively, one could reduce temporary grass areas as any other feed crop area



*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
*XXXXXXXXXXXX kray: Is it ok to reduce AGAIN instead of taking baseline values? Doesn't this shift the relations between crops with high feed utilization and others?
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

*Reduction in the areas of crops that have been grown for feed by the amount not needed anymore for animals:
*set MatchCommAct_AggregateCommodities_Crops(Commodities,Activities,OutputsCropsGrass)
*no extraction rate added or so, as this is based on MainProducts only (AggregateFeedConcMainProd_Commodity), thus per activity it is only one commodity, usually

*HERE we now do it for vegan share = 1 to derive the shares of crops in fully vegan cropping patterns for conventional area:
*this is done for CONVENTIONAL only - so we loose the areas above for conventional, but this is no problem as they are not needed anymore (in contrast to organic, cf. below)

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateCommodities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_AggregateActivities_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_WellDefinedCoProducts_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_ComplexCases_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$(Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,'AggregateFeedConcMainProd_Commodity')
                                 AND MatchCommAct_CommodAndProductsEquivalentAct_Crops(Commodities_MR,Activities_MR,"MainOutput1 (t)")),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

*forage crops and other forage crops need to be done specifically, as not included above, where the focus is on Main and byprod Concentrates, not forage:

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,ForageCrops,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,ForageCrops,"MainOutput1 (t)"),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OtherFodderCrops,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OtherFodderCrops,"Convent",ProductionConditions,"%Scenario%")
                 *(1 - (sum(Commodities_MR$MatchCommAct_CommodEquivalentAct_Crops(Commodities_MR,OtherFodderCrops,"MainOutput1 (t)"),
                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                 *1)));
*                                 *VeganDietShare("World","%Scenario%"))));

*adjust triticale - to be done separately, as there is no ruminant share factor, thus use the one from Wheat and products and util feed share = 1:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Triticale","Convent",ProductionConditions,"%Scenario%")
         = 0;
*         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Triticale","Convent",ProductionConditions,"%Scenario%")
*                 *(1 - VeganDietShare("World","%Scenario%"));

*if such occur: set negative values = 0:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%")
                  $(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,"Convent",ProductionConditions,"%Scenario%") < 0)
         = 0;


****************Calculation of vegan-conventional "crop rotation pattern", i.e. share of crop area in total crop group area (without feed)

*Then calculate the total for the vegan cropping patterns to derive the shares:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","Convent",ProductionConditions,"%Scenario%")
         = Sum(CropsUsedInRotations_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_V,"Convent",ProductionConditions,"%Scenario%"));


****XXXXXXXXXXXX kray: added here because this overwrites the values defined above for non-BAU scenarios...
$ifthen %CropRotationDesign% == "BAUCropRot"
*ue the parameter CropRotationShare to collect the cropping patterns for conventional vegan areas on activity level:
CropRotationShare(Regions_MR,CropsUsedInRotations_V,"Convent","%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","Convent","AllProdCond","%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_V,"Convent","AllProdCond","%Scenario%")
                 /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_V","Convent","AllProdCond","%Scenario%");

*The code above is needed to derive the cropping pattern shares to allocate the conventional areas in vegan scenarios (see below)
*the following code derives the areas that become free due to reduced feed use in vegan scenarios:
$offtext





*2.2) adjust areas according to organic/vegan crop rotations:
$ontext;
Now we have:
convent/organic areas per crop, reduced by the areas not anymore needed for feed (i.e. reduced by the vegan share of the feed areas)
convent/org areas freed for alternative use by this

Now we need to assign these newly freed areas to crops and we need to adjust the crop rotations for the organic areas:
This is done as follows: for
- convent areas per crop (after reduction of feed use areas):  keep as they are
- convent areas - AlternativeUse: Assign to single crops according to "conventional vegan crop rotations": for this, take the reference scenario shares of the "food crop - no cereals"
- organic areas per crop (after reduction of feed use areas): change to organic non-vegan crop rotations - on a share corresponding to (1-veganshare) of the original TOTAL cropland area incl. feed
         (indicated by the term "NonV" in the names of sets and elements) - still contains forage maize and triticale in Cereals2, etc.
- organic areas per crop (after reduction of feed use areas): change to organic-vegan crop rotations - on a share corresponding to the remainder of the areas not freed from reduced feed production
- Organic areas - AlternativeUse: Assign to single crops according to organic-vegan crop rotations
         These previous two together are exactly the vegan share of the TOTAL original cropland area (as the rest is 1-vegan share of the total) - and the same pattern applies on them, thus, it can be done in this way.
         UNLESS not all of the alternative area is used but some is left free - then this vegan share applies to the area as above BUT reduced by this area not used.

Proceeding like this, the original feed share is applied to the (1-veganShare) area of the TOTAL area
         - in conv, this results in having the same share as before on this share of the area, on veganShare, the vegan crop rotations are applied (which are in conventional: the original shares without feed crops)
         - in org, this results in having organic shares on this area, and vegan-organic on the remainder - thus, the feed shares are also influenced by the assumptions on feed crop shares in organic non-vegan crop rotations
                         and can thus be more or less than if just applying veganShare to the original feed area.
$offtext;


*ADAPT DESCRIPTIONS ABOVE:


*****************************CONVENTIONAL: Finally assign quantities of areas to conventional crops...****************************
*comment kray: the below part works only for crop rot BAU since there crop rotation shares are defined on a single crop level (not only aggregate)
$ifthen %CropRotationDesign% == "BAU"
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_V,"Convent",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Convent",ProductionConditions,"%Scenario%")
                 *VeganDietShare("World","%Scenario%")
                          *CropRotationShare(Regions_MR,CropsUsedInRotations_V,"Convent","%Scenario%");

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_NonV,"Convent",ProductionConditions,"%Scenario%")
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_NonV,"Convent",ProductionConditions,"%Scenario%")
                  + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Convent",ProductionConditions,"%Scenario%")
                         *(1-VeganDietShare("World","%Scenario%"))
                                  *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
$goto continueWithImportScaling
$endif;
*XXXXXXXXXXXXXXXXX added here end


*********************************ORGANIC**********************************************************************************************

*- organic areas per crop (after reduction of feed use areas): change to organic non-vegan crop rotations - on a share corresponding to (1-veganshare) of the original TOTAL cropland area incl. feed
*         (indicated by the term "NonV" in the names of sets and elements) - still contains forage maize and triticale in Cereals2, etc.
*- organic areas per crop (after reduction of feed use areas): change to organic-vegan crop rotations - on a share corresponding to the remainder of the areas not freed from reduced feed production
*- Organic areas - AlternativeUse: Assign to single crops according to organic-vegan crop rotations
*         These previous two together are exactly the vegan share of the TOTAL original cropland area (as the rest is 1-vegan share of the total) - and the same pattern applies on them, thus, it can be done in this way.
*         UNLESS not all of the alternative area is used but some is left free - then this vegan share applies to the area as above BUT reduced by this area not used.

*Thus, we need the crop group areas for 2050 and the total area for the scenario:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals1_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Cereals1_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals1_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals2_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Cereals2_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals2_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_Pulses_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Pulses_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Pulses_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_OilCrops_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(OilCrops_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OilCrops_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All starchy roots","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(StarchyRoots,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,StarchyRoots,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Vegetables","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Vegetables,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Vegetables,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_Fruits_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Fruits_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Fruits_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_setAside_V","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(setAside_V,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,setAside_V,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));
*and we need the cereas2 and StarchyRoots values for the non-vegan organic scenarios as well:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals2_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(Cereals2_NonV,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals2_NonV,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_StarchyRoots_NonV","AllProdSyst","AllProdCond","FOFA_BAU_2050")
         = Sum(StarchyRoots_NonV,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,StarchyRoots_NonV,"AllProdSyst","AllProdCond","FOFA_BAU_2050"));

$ontext;
DELETE?? as already done above
*and sum the crops used in organic non-vegan crop rotations to reassign them according to the organic crop rotations:
*these are the areas still cropped after removing the areas needed for feed:
*the permanent crops remain as they are after reducing feed areas.
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","Organic",ProductionConditions,"%Scenario%")
         = Sum(CropsUsedInRotations_NonV,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_NonV,"Organic",ProductionConditions,"%Scenario%"));

*derive the total area in crop rotations reduced by the areas not used anymore:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","Organic",ProductionConditions,"%Scenario%")
                 - VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Conservation","Organic",ProductionConditions,"%Scenario%");
DELETE?
$offtext;

*and now assign directly also the areas freed for alternative use according to vegan organic crop rotations:
*cf. also further up the comment on how to allocate on the areas that are still cropped - we copy the comment here:
$ontext;
- organic areas per crop (after reduction of feed use areas): change to organic non-vegan crop rotations - on a share corresponding to (1-veganshare) of the original TOTAL cropland area incl. feed
         (indicated by the term "NonV" in the names of sets and elements) - still contains forage maize and triticale in Cereals2, etc.
- organic areas per crop (after reduction of feed use areas): change to organic-vegan crop rotations - on a share corresponding to the remainder of the areas not freed from reduced feed production
- Organic areas - AlternativeUse: Assign to single crops according to organic-vegan crop rotations
         These previous two together are exactly the vegan share of the TOTAL original cropland area (as the rest is 1-vegan share of the total) - and the same pattern applies on them, thus, it can be done in this way.
         UNLESS not all of the alternative area is used but some is left free - then this vegan share applies to the area as above BUT reduced by this area not used.
$offtext;
*- Organic areas - AlternativeUse: Assign to single crops according to organic-vegan crop rotations
*this uses the same code, but uses the AlternativeUse areas instead of the "All Crops used in crop rotations_NonV" - thus they can be summed for all crop rot groups - besides Cereals" and StarchyRoots, where there is a different set for the non-vegan and vegan crop rotations
*        for this, see the code after the other groups

*Cereals1
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals1_V,"Organic",ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals1_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals1_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals1_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(CropRotationShare(Regions_MR, "All_cereals1_NonV","Organic","%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
                                 *(1 - VeganDietShare("World","%Scenario%"))
                                 + CropRotationShare(Regions_MR, "All_cereals1_V","Organic","%Scenario%")
                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
*                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Cropland","Organic",ProductionConditions,"%Scenario%")
*                                                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","Organic",ProductionConditions,"%Scenario%")
                                                         *VeganDietShare("World","%Scenario%")));
*Cereals 2                                                     
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals2_NonV,"Organic",ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals2_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals2_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals2_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *CropRotationShare(Regions_MR, "All_cereals2_NonV","Organic","%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
                                 *(1 - VeganDietShare("World","%Scenario%"));
 
*Pulses                               
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Pulses_V,"Organic",ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_pulses_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Pulses_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_pulses_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(CropRotationShare(Regions_MR, "All_pulses_NonV","Organic","%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
                                 *(1 - VeganDietShare("World","%Scenario%"))
                                 + CropRotationShare(Regions_MR, "All_pulses_V","Organic","%Scenario%")
                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
*                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Cropland","Organic",ProductionConditions,"%Scenario%")
*                                                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","Organic",ProductionConditions,"%Scenario%")
                                                         *VeganDietShare("World","%Scenario%")));
                                                         
*oilcrops
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OilCrops_V,"Organic",ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_OilCrops_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,OilCrops_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_OilCrops_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(CropRotationShare(Regions_MR, "All_OilCrops_NonV","Organic","%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
                                 *(1 - VeganDietShare("World","%Scenario%"))
                                 + CropRotationShare(Regions_MR, "All_Oilcrops_V","Organic","%Scenario%")
                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
*                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Cropland","Organic",ProductionConditions,"%Scenario%")
*                                                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","Organic",ProductionConditions,"%Scenario%")
                                                         *VeganDietShare("World","%Scenario%")));
                                                         
*Starchy Roots
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,StarchyRoots_NonV,"Organic",ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_StarchyRoots_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,StarchyRoots_NonV,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_StarchyRoots_NonV","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *CropRotationShare(Regions_MR,"All_StarchyRoots_NonV","Organic","%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
                                 *(1 - VeganDietShare("World","%Scenario%"));
                                 
*Vegetables
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Vegetables,"Organic",ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Vegetables","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Vegetables,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Vegetables","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(CropRotationShare(Regions_MR, "All Vegetables_NonV","Organic","%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
                                 *(1 - VeganDietShare("World","%Scenario%"))
                                 + CropRotationShare(Regions_MR, "All Vegetables","Organic","%Scenario%")
                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
*                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Cropland","Organic",ProductionConditions,"%Scenario%")
*                                                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","Organic",ProductionConditions,"%Scenario%")
                                                         *VeganDietShare("World","%Scenario%")));
                                                         
*Fruits
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Fruits_V,"Organic",ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_Fruits_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Fruits_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_Fruits_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(CropRotationShare(Regions_MR, "All_Fruits_NonV","Organic","%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
                                 *(1 - VeganDietShare("World","%Scenario%"))
                                 + CropRotationShare(Regions_MR, "All_Fruits_V","Organic","%Scenario%")
                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
*                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Cropland","Organic",ProductionConditions,"%Scenario%")
*                                                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","Organic",ProductionConditions,"%Scenario%")
                                                         *VeganDietShare("World","%Scenario%")));
                                                         
*Set Aside
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,SetAside_V,"Organic",ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_SetAside_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,SetAside_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_SetAside_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(CropRotationShare(Regions_MR, "All_SetAside_NonV","Organic","%Scenario%")
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
                                 *(1 - VeganDietShare("World","%Scenario%"))
                                 + CropRotationShare(Regions_MR, "All_SetAside_V","Organic","%Scenario%")
                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
*                                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Cropland","Organic",ProductionConditions,"%Scenario%")
*                                                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","Organic",ProductionConditions,"%Scenario%")
                                                         *VeganDietShare("World","%Scenario%")));

*now cereals2, starchy roots:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals2_V,"Organic",ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals2_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals2_V,"Organic",ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Cereals2_V,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals2_V","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *CropRotationShare(Regions_MR, "All_cereals2_V","Organic","%Scenario%")
                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
*                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Cropland","Organic",ProductionConditions,"%Scenario%")
*                                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","Organic",ProductionConditions,"%Scenario%")
                                         *VeganDietShare("World","%Scenario%"));

VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,StarchyRoots,"Organic",ProductionConditions,"%Scenario%")
                         $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Starchy Roots","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,StarchyRoots,"Organic",ProductionConditions,"%Scenario%")
                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,StarchyRoots,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         /VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Starchy Roots","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *CropRotationShare(Regions_MR, "All Starchy Roots","Organic","%Scenario%")
                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rot_NonV - w/o areas not used","Organic",ProductionConditions,"%Scenario%")
*                         *(VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Alternative use - Cropland","Organic",ProductionConditions,"%Scenario%")
*                                 + VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV","Organic",ProductionConditions,"%Scenario%")
                                         *VeganDietShare("World","%Scenario%"));


$label continueWithImportScaling

*Total Area
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Sum(CropsUsedInRotations_NonV,
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,CropsUsedInRotations_NonV,ProdSyst_OrgCon,ProductionConditions,"%Scenario%"));
                 


***********************************************************************************************************************************************
***********************************************************************************************************************************************


*adjust imports accordingly: i.e. reduce imports by the same factor as produciton was reduced above, due to lower feed use for animalts:
*feed is from DAQ, thus, reducing the feed part from DAQ translates in a corresponding reduction of products AND imports
*formally, this is done via the ImportScaleFactor:
ImportScaleFactor_MR(Regions_MR,Regions_2,Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VImportQuantity_MR.l(Regions_MR,Regions_2,Commodities_MR,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
         = (1 - Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *VeganDietShare("World","%Scenario%"));
*         = 1;
ImportScaleFactor_MR(Regions_MR,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VExportQuantity_MR.l(Regions_MR,"World",Commodities_MR,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (NOT ImportScaleFactor_MR(Regions_MR,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = (1 - Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *VeganDietShare("World","%Scenario%"));
*         = 1;
ImportScaleFactor_MR(Regions_MR,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(VCommod_Production_MR.l(Regions_MR,Commodities_MR,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         AND (NOT ImportScaleFactor_MR(Regions_MR,"World",Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")))
         = (1 - Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *VeganDietShare("World","%Scenario%"));
*         = 1;
*NO CHANGE IN export scale factor, though:
*exports are adjusted to match imports globally after the code for calculating DAQs, etc.
ExportScaleFactor_MR(Regions_MR,Regions_2,Commodities_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $VExportQuantity_MR.l(Regions_MR,Regions_2,Commodities_MR,"AllProdSyst",ProductionConditions,"Baseline")
         = 1;

*if such occur: set negative values = 0:
ImportScaleFactor_MR(Regions,Regions_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")
                 $(ImportScaleFactor_MR(Regions,Regions_2,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%") < 0)
         = 0;


********************XXXXXXXXXXXX new code (Mail Adrian 05.08.2021)
*Finally, also adapt the utilization shares:

*assume that util shares for feed also scale with the VeganShares (althoug DAQ may already be reduced/changed due to changed feed production, and then util share would need to change differently;

*        but this becomes very complicated, given that DAQ not onyl changes with changed areas and production, but also imports/exports, etc.;

*        but the procedure chosen here captures the essence of vegan scenarios correctly and for shares towards 100% vegan, it coincides with any other approach: feed util share = 0 )

*commodities with feed share = 1 are treated separately, to avoid that this results in food utilization.

*they are kept as feed (actually for feedshare >= 0.95), as their supply is governed by reduced areas

*BESIDES permanet grassland: there, utilization for feed is to be reduced - but the grass is not harvested and used as fertilizer, thus assigned to other use.

 

Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

*FOR PK: feed share is reduced in any case, this condition is wrong!!

*                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") > 0.05)

         = Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")

                 *(1 - VeganDietShare("World","%Scenario%") + eps);

*FOR PK:

*keep feed share = 1 for forage commodities:

Commod_OtherChar_MR(Regions_MR,ForageCommodities,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

                 $(Commod_OtherChar_MR(Regions_MR,ForageCommodities,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") = 1)

         = Commod_OtherChar_MR(Regions_MR,ForageCommodities,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

 

*thus, a share of UtilShare(Feed)*VeganShare has to be attributed to other uses

*if food util is already rather significant, add it there: condition > 0.05

*this condition >0.05 is needed as otherwise, it results in huge biases (e.g. due to very low food util of Barley and Products in 2050 (less than 0.001), which when changing would then blow up food supply (via beer!!) like mad, going from a share of 0.001 to, say, 0.301, in case of VeganShare=0.3.

Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") > 0.05)

         = Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")

                 + Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")

                         *VeganDietShare("World","%Scenario%");

 

*FOR PK:

*where to add the reduced feed share for util food < 5%??

 

 

*for the commodities from SetAside crop groups, with feedshare=1, reduce this and assign it to organic fertilizer use:

Commod_OtherChar_MR(Regions_MR,Commodities_EquivSetAsideAct,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

         = Commod_OtherChar_MR(Regions_MR,Commodities_EquivSetAsideAct,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")

                 *(1 - VeganDietShare("World","%Scenario%") + eps);

Commod_OtherChar_MR(Regions_MR,Commodities_EquivSetAsideAct,"Util organic fert (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

         = Commod_OtherChar_MR(Regions_MR,Commodities_EquivSetAsideAct,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")

                 *VeganDietShare("World","%Scenario%");

*permanet grassland: area does not change, thus change the util share for feed - and assign to other use and org. fert. use, as it is not harvested fully for fertilizer use, but part may be harvested for this:

Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

         = Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")

                 *(1 - VeganDietShare("World","%Scenario%") + eps);

Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util organic fert (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

         = Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")

                 *VeganDietShare("World","%Scenario%")

                         *PermanentGrassFertilizerUseShare(Regions_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%");

Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util other (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

         = Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")

                 *VeganDietShare("World","%Scenario%")

                         *(1-PermanentGrassFertilizerUseShare(Regions_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%"));

 

$ontext;

older version. assign to other use:

Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util organic fert (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

                 $(NOT Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") > 0.05)

         = Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")

                 + Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")

                         *VeganDietShare("World","%Scenario%");

$offtext;

*for some cases, feed util share = 0 for FOFA_BAU_2050 while it is nonzero for the baseline, hence the following code to assure that this value is also =0 in the scenario:

Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

                 $((Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") = 0)

                         AND (NOT Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"BaselineDerived") = 0))

         = eps;

 


*in case util shares are not yet all assigned such as to sum to 1, assign "other" as a residue:

Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util all uses (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

         = sum(UtilSharesNOTFeed,

                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,UtilSharesNOTFeed,ProdSyst_OrgCon,ProductionConditions,"%Scenario%"))

                  + Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%");

 

Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

                 $(NOT Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util all uses (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%") = 1)

         = 1 - Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util all uses (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%");

 

*then recalculate the sum of all shares to have the correct value 1 for that:

Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util all uses (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")

         = sum(UtilSharesNOTFeed,

                         Commod_OtherChar_MR(Regions_MR,Commodities_MR,UtilSharesNOTFeed,ProdSyst_OrgCon,ProductionConditions,"%Scenario%"))

                  + Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%");


$ontext
*Finally, also adapt the utilization shares:
*assume that util shares for feed also scale with the VeganShares (althoug DAQ may already be reduced/changed due to changed feed production, and then util share would need to change differently;
*        but this becomes very complicated, given that DAQ not onyl changes with changed areas and production, but also imports/exports, etc.;
*        but the procedure chosen here captures the essence of vegan scenarios correctly and for shares towards 100% vegan, it coincides with any other approach: feed util share = 0 )
*commodities with feed share = 1 are treated separately, to avoid that this results in food utilization.
*they are kept as feed (actually for feedshare >= 0.95), as their supply is governed by reduced areas
*BESIDES permanet grassland: there, utilization for feed is to be reduced - but the grass is not harvested and used as fertilizer, thus assigned to other use.

Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") > 0.05)
         = Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - VeganDietShare("World","%Scenario%") + eps);
*thus, a share of UtilShare(Feed)*VeganShare has to be attributed to other uses
*if food util is already rather significant, add it there: condition > 0.05
*this condition >0.05 is needed as otherwise, it results in huge biases (e.g. due to very low food util of Barley and Products in 2050 (less than 0.001), which when changing would then blow up food supply (via beer!!) like mad, going from a share of 0.001 to, say, 0.301, in case of VeganShare=0.3.
Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") > 0.05)
         = Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 + Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *VeganDietShare("World","%Scenario%");

*for the commodities from SetAside crop groups, with feedshare=1, reduce this and assign it to organic fertilizer use:
Commod_OtherChar_MR(Regions_MR,Commodities_EquivSetAsideAct,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities_EquivSetAsideAct,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - VeganDietShare("World","%Scenario%") + eps);
Commod_OtherChar_MR(Regions_MR,Commodities_EquivSetAsideAct,"Util organic fert (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,Commodities_EquivSetAsideAct,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *VeganDietShare("World","%Scenario%");
*permanet grassland: area does not change, thus change the util share for feed - and assign to other use and org. fert. use, as it is not harvested fully for fertilizer use, but part may be harvested for this:
Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - VeganDietShare("World","%Scenario%") + eps);
Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util organic fert (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *VeganDietShare("World","%Scenario%")
                         *PermanentGrassFertilizerUseShare(Regions_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%");
Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util other (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = Commod_OtherChar_MR(Regions_MR,"Permanent meadows and pastures","Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *VeganDietShare("World","%Scenario%")
                         *(1-PermanentGrassFertilizerUseShare(Regions_MR,ProdSyst_OrgCon,ProductionConditions,"%Scenario%"));


$ontext;
older version. assign to other use:
Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util organic fert (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $(NOT Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util food (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") > 0.05)
         = Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util other (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 + Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                         *VeganDietShare("World","%Scenario%");
*$offtext;
*for some cases, feed util share = 0 for FOFA_BAU_2050 while it is nonzero for the baseline, hence the following code to assure that this value is also =0 in the scenario:
Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
                 $((Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050") = 0)
                         AND (NOT Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Util feed (share)","AllProdSyst",ProductionConditions,"BaselineDerived") = 0))
         = eps;
$offtext
******************* END new





******************************************
*yields: apply yield gap
ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");

$if %UseYieldGapCorrection% == "NO" $goto DoNotUseYieldGapCorrection
*for crops, use the corrected yield gap as described in Barbieri: only taking tha part of the yield gap caused by Pests and Diseases, not the part caused by lower N fertilization levels (further details, see MA Kevin De Luca; or SOLm Documentation)
*the N part is then taken into account in the core code, where Y is linked to N inputs
ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"%Scenario%")
                 $ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline")
         = 0.368965516
            +   0.631034484
            *   ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
*no correction for N-fixing legumes
ActCropsGrass_OtherChar_MR(Regions,Legumes_NFixing,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"%Scenario%")
        = ActCropsGrass_OtherChar_MR(Regions,Legumes_NFixing,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline");
$label DoNotUseYieldGapCorrection

*Why is there the condition in the yield code below???

*and assume 10% lower yields for monogastrics
ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%"))
         = ActCropsGrass_Outputs_MR(Regions,Activities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"%Scenario%");
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

*no grassland yield data for 2050, so use 2012 - but we run the FOFA_BAU_2050 anyway before we can run this scenario that depends on it, so use the values from there, which are the same:
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t DM)","AllProdSyst","AllProdCond","FOFA_BAU_2050");
ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond","%Scenario%")
         = ActCropsGrass_Outputs_MR(Countries,GrassActivities,"MainOutput1 (t)","AllProdSyst","AllProdCond","FOFA_BAU_2050");
*assume lower organic grassland yields
ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"Organic",ProductionConditions,"%Scenario%")
         = ActCropsGrass_Outputs_MR(Regions,CoreGrassActivities,YieldsCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *ActCropsGrass_OtherChar_MR(Regions,COreGrassActivities,"organic yield gap (ratio org/conv yield)","AllProdSyst",ProductionConditions,"Baseline")*0.9;


FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
*         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"AE_food_2050");
         = FeedingRationsHeads_OtherChar_MR(Regions_MR,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");
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
                 $(NOT Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,ProdSyst_OrgCon,ProductionConditions,"%Scenario%"))
         = Commod_OtherChar_MR(Regions_MR,Commodities,CommodOtherChar,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions,Livestock,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050");



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



*adjust fish and seafood, which is yet done simplistically:
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Convent",ProductionConditions,"%Scenario%")
         = VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *(1 - OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%"))
                         *(1 - VeganDietShare("World","%Scenario%"));
VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Organic",ProductionConditions,"%Scenario%")
         = VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                 *OrganicAreaShare("World","All crops and grass","AllProdCond","%Scenario%")
                         *(1 - VeganDietShare("World","%Scenario%"));

*to not loose these values if they are zero, set them =eps - which is replaced later in the code again (in the module to derive animal numbers, etc.)
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Convent",ProductionConditions,"%Scenario%"))
         = eps;
VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Quantity_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Organic",ProductionConditions,"%Scenario%"))
         = eps;
VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Convent",ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Convent",ProductionConditions,"%Scenario%"))
         = eps;
VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Organic",ProductionConditions,"%Scenario%")
                 $(NOT VCommod_Production_MR.l(Regions_MR,CommoditiesDAQ_TradeFromToWorld_FishSeafood,"Organic",ProductionConditions,"%Scenario%"))
         = eps;


**********************kray: comment because I need these values for checking....

$ontext
*finally, set the aggregates used in the calculations above equal zero again, as they are not needed anymore:
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Crops used in crop rotations_NonV",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All crops and grass",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals1_V",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals2_V",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_Pulses_V",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_OilCrops_V",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All starchy roots",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Vegetables",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_Fruits_V",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_setAside_V",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals2_NonV",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_StarchyRoots_NonV",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_cereals1_NonV",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_Pulses_NonV",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_OilCrops_NonV",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All Vegetables_NonV",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_Fruits_NonV",ProductionSystems,ProductionConditions,"%Scenario%") = 0;
VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"All_setAside_NonV",ProductionSystems,ProductionConditions,"%Scenario%") = 0;

$offtext

$exit;







till here: just organic workd with different crop rot and organic share options. No changes in feeding rations and animals and towards vegan yet


go on scen spec line 4215 - 4400    also:  4494-4524
adjustemnt of feed to animals and related area and trade adjustments!!!!!

and: adjustment of how areas are reused: here a specification that areas are just kept free (one scenario from above)


go on here: from kray:

*************************************************************************************************************************************************
*7 -  Utilization of crop production (reduced feed according to vegan share) & add no animal numbers? (otherwise scaling or does it not matter because 0 times 0 is 0?)
*************************************************************************************************************************************************
*set util feed = 1-veganShare at commodity level - add the amount to food or (if no food crop - such as grass) then to "others":

*Feed
Commod_OtherChar_MR(Regions_MR,Commodities,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
            = Commod_OtherChar_MR(Regions_MR,Commodities,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
                *(1 - VeganShare);

*Set to eps if equals 0;
Commod_OtherChar_MR(Regions_MR,Commodities,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")$(Commod_OtherChar_MR(Regions_MR,Commodities,"Util feed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%") = 0) = eps;
*-eps -> in assigninitialValuesToScenarios_diff.... auf 0 setzen... (set eps to zero) done





*Food (add feed share, if it can be used as food)
Commod_OtherChar_MR(Regions_MR,Commodities,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
    $(Commod_OtherChar_MR(Regions_MR,Commodities,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050"))
    = Commod_OtherChar_MR(Regions_MR,Commodities,"Util food (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
    + Commod_OtherChar_MR(Regions_MR,Commodities,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
        *(VeganShare);

*Waste (same as FOFA_2050)- necessary if equal to baseline?
Commod_OtherChar_MR(Regions_MR,Commodities,"Util waste (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
    = Commod_OtherChar_MR(Regions_MR,Commodities,"Util waste (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");


*Seed (same as FOFA_2050) - necessary?
Commod_OtherChar_MR(Regions_MR,Commodities,"Util seed (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
    = Commod_OtherChar_MR(Regions_MR,Commodities,"Util waste (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050");

*Other (same as FOFA_2050) -
Commod_OtherChar_MR(Regions_MR,Commodities,"Util other (share)",ProdSyst_OrgCon,ProductionConditions,"%Scenario%")
    $(NOT Commod_OtherChar_MR(Regions_MR,Commodities,"Util food (share)",ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050"))
    = Commod_OtherChar_MR(Regions_MR,Commodities,"Util other (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
        + Commod_OtherChar_MR(Regions_MR,Commodities,"Util feed (share)","AllProdSyst",ProductionConditions,"FOFA_BAU_2050")
            *VeganShare;








