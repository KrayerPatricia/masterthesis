*Steering file for model version V6: Core Model scenarios and equations

*GENERAL DESCRIPTION
*This file governs the core model equations and scenario runs
*        runs on the gdx-files generated in the model initialisation steering file
*        ___V6_SteeringFile1_ModelInitialisation

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) General settings
         1.1) Operating systems settings, etc.
         1.2) specify some global variables to choose for global scenario specifications (how to allocate mineral fertilizer, etc.)
- 2) Define sets, parameters and variabless and load gdx files from the baseline assignment
- 3) Run core model equations
- 4) Choice of scenarios
- 5) Further calculations after finishing the scenario runs
- 6) Define some output files
- 7) Do some further specific calculations needed for certain aspects

$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) General settings
*1.1) Operating systems settings, etc.
*the following checks the operating system and chooses some basics for GAMS accordingly
$setglobal osystem
$if %system.filesys% == DOS  $setglobal osystem "1"
$if %system.filesys% == MS95 $setglobal osystem "1"
$if %system.filesys% == MSNT $setglobal osystem "1"
$if %system.filesys% == UNIX $setglobal osystem "2"
$setglobal console
$if "%osystem%" == "1" $setglobal console con
$if "%osystem%" == "2" $setglobal console /dev/tty
*generates the option to display in DOS / UNIX window
FILE CON /'%console%'/;

*chose the symbol for the "slash" in directory structure correctly, according to the operating system (e.g. for gdxmerge)
$if "%osystem%" == "1" $setglobal slash '\'
$if "%osystem%" == "2" $setglobal slash '/'
********************************

*1.2) specify some global variables to choose for global scenario specifications (how to allocate mineral fertilizer, etc.)


*MAY MOVE THE FOLLOWING INTO ScenarioSpecifications????

*$setglobal RunAllChosenScenarios "NO"
$setglobal RunAllChosenScenarios "YES"

*switch on, if you are interested in getting footprints calculated - takes some time, hence not switched on as a default
$setglobal CalculateFootprints "NO"
*$setglobal CalculateFootprints "YES"

*the following determines whether some refined trade-data on single-commodity-level is derived (e.g. used for the UNISECO scenarios, when trade data for the economic model is needed)
$setglobal DeriveRefinedTradeData "NO"
*$setglobal DeriveRefinedTradeData "YES"

$setglobal AdjustMinFert "CroplandOnly"
*$setglobal AdjustMinFert "CroplandPLUSTempGrass"

*switch correction of yields for N-inputs on or not:
*to really do this correction, one has to implement it in the scenario specifications (by running , but switching this on calculates the basic yield gap based on plant protection effects only (removing the N-effect).
*$setglobal UseYieldGapCorrection "YES"
$setglobal UseYieldGapCorrection "YES"
*choose, when doing N-correction of yields, whether this is done based on total N inputs or on N in outputs + residues as a reference for N_max; for details on N_max, etc. see the respective code file.
*$setglobal YieldCorrectionNmax "InputBased"
$setglobal YieldCorrectionNmax "OutputBased"

*use Benke crop res management data for all scenarios, or not. - But it should be done in the same way (i.e. with or without Benke) for all scenarios, otherwise comparison is not possible anymore
$setglobal UseBenke "YES"

$ontext;
DELETE WHEN SURE THAT IT IS NOT NEEDED ANYMORE
*ANIMAL NUMBERS: we changed it - so ALWAYS USE "GrassBased"!!!!
*THE OTHER IS NOT NEEDED ANYMORE AND NOT FUNCTIONAL ANYMORE - will be deleted soon
*$setglobal DeriveAnimalNumbersCode "ConcentratesBased"
*$setglobal DeriveAnimalNumbersCode "GrassBased"
$offtext;


*choose the way impacts are allocated to commodities at the end of the model run:
*not needed anymore, as furtherdown, a loop calculates all - but it has to be started with "Mass" as this is used in the results file to run some definitions once only, i.e. only if allocation is "mass":
$setglobal Allocation "Mass"
*$setglobal Allocation "Calories"
*$setglobal Allocation "Protein"
*$setglobal Allocation "Price"
*$setglobal Allocation "MainProduct"


*choose with special calculations should be added at the end of the main code:
*$setglobal DoUNISECO_SESSIT_Calculations "YES"
$setglobal DoUNISECO_SESSIT_Calculations "NO"


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Define sets, parameters and variables and load gdx files from the baseline assignment

*the following contains one file less than the original general model set file, which has been used for filing in data in SteeringFile1 and is not used here anymore (in section 14.7)
*        and it contains the scenario set and some additional matching sets for the commodity trees
$include _V6_Sets_GeneralModelSets_ForSteeringFile2

$include _V6_VariablesAndParameters

$include _V6_ReadOutputFilesFromSteeringFile1
PUTCLOSE con "   End _V6_ReadOutputFilesFromSteeringFile1:" timeElapsed;
$ontext;

*this code reads the following gdx-files with the sets, par's, var's as indicated in the code:

'GeneralModelSets'
'GeneralModelParameters_Inputs'
'GeneralModelParameters_Outputs'
'GeneralModelParameters_OtherChar'
'GeneralModelParameters_Various'
'GeneralModelParameters_Auxiliary'
'GeneralModelVariables_ActivityQuantities'
'GeneralModelVariables_Inputs'
'GeneralModelVariables_Outputs'
'GeneralModelVariables_OtherChar'
'GeneralModelVariables_Various'
'GeneralModelVariables_Trade'
'GeneralModelVariables_CommodityTree'
'GeneralModelVariables_Auxiliary'

'FOFA2050_BioeSR15_Etc_Data_InModelRunEntities.gdx' is filed in later only, after having introduced the "..._MR" parameters and variables, i.e. in modeule "_V6_VariablesAndParameters_ModelRun_ForSteeringFile2", section 5.0

$offtext;




$include _V6_VariablesAndParameters_ModelRun_ForSteeringFile2NEW
PUTCLOSE con "   End _V6_VariablesAndParameters_ModelRun_ForSteeringFile2:" timeElapsed;

$include _V6_ReadOutputFilesFromSteeringFile1a
PUTCLOSE con "   End _V6_ReadOutputFilesFromSteeringFile1a:" timeElapsed;




*MAY MOVE THE FOLLOWING INTO ScenarioSpecifications????
$include _V6_InitialiseSetsForModelRuns
PUTCLOSE con "   End _V6_InitialiseSetsForModelRuns:" timeElapsed;


*we need the following for deriving some additional values for Scenario=Baseline:
*not needed here anymore, this is now in SteeringFile1a
****$include _V6_BaselineValues_ForModelRuns
****PUTCLOSE con "   End _V6_BaselineValues_ForModelRuns:" timeElapsed;



*after this, we have all sets, parameters, variables we need for the model run, and we have the Scenario=Baseline values we need
PUTCLOSE con "   All baseline values are ready for the scenario runs:" timeElapsed;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Run core model equations
PUTCLOSE con,"Run core model equations";


$setglobal Scenario "BaselineDerived"

*XXXXXXXXXXXXXX kray: here include nutrients? 27.07.2021
$include XX_includeNutrients

*XXXXXXXXXXXXXX kray: here include nutrients? 27.07.2021


$label Restart





$include _V6_AssignInitialValuesToScenarios
PUTCLOSE con "   End _V6_AssignInitialValuesToScenarios:" timeElapsed;


*the following initialises the scenario runs:
$include _V6_ScenarioSpecifications
PUTCLOSE con "   End _V6_ScenarioSpecifications:" timeElapsed;
*execute_unload 'testxy' Commod_Contents_MR;


*the following assigns more specific values to differentiated production systems (e.g. organic and conventional), etc., if needed.
$include _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc
PUTCLOSE con "   End _V6_AssignInitialValuesToScenarios_DifferentiatedProdSystemsEtc:" timeElapsed;


*The following contains the core calculations:
$if %UseReference2050% == "YES" $goto UseReference2050_Label1
$include _V6_DataDerived_CropProductionTotalsAndDAQ
$goto DoNotUseReference2050

$label UseReference2050_Label1
$include _V6_DataDerived_CropProductionTotalsAndDAQ_Ref2050
$label DoNotUseReference2050
PUTCLOSE con "   End _V6_DataDerived_CropProductionTotalsAndDAQ:" timeElapsed;


$if %UseBenke% == "YES" $goto UseBenke
$goto DoNotUseBenke
$label UseBenke
$include _V6_DataDerived_CropResidueManagement_Benke
PUTCLOSE con "   End _V6_DataDerived_CropResidueManagement_Benke:" timeElapsed;
$label DoNotUseBenke



$include _V6_DataDerived_CropResidueManagement
PUTCLOSE con "   End _V6_DataDerived_CropResidueManagement:" timeElapsed;

$include _V6_DataDerived_CropGrassNutrientRequirements
PUTCLOSE con "   End _V6_DataDerived_CropGrassNutrientRequirements:" timeElapsed;

*$include _V6_CoreModelEquations_NutrientRequirementsAndFeedSupply
*Below is the option with DETAILED FEEDING RATIONS on commodity level
$include _V6_CoreModelEquations_NutrReqAndFeedSupply_DetailedFeedingRations
PUTCLOSE con "   End _V6_CoreModelEquations_NutrReqAndFeedSupply_DetailedFeedingRations:" timeElapsed;



*$include _V6_CoreModelEquations_DeriveAnimalNumbersAndProduction
*Below is the option with DETAILED FEEDING RATIONS on commodity level
$if %UseReference2050% == "YES" $goto UseReference2050_Label2
$include _V6_CoreModelEquations_DeriveAnimalNumbAndProd_DetailedFeedingRations
$goto DoNotUseReference2050_2

$label UseReference2050_Label2
$include _V6_CoreModelEquations_DeriveAnimalNumbAndProd_DetailedFeedingRations_Ref2050
$label DoNotUseReference2050_2
PUTCLOSE con "   End _V6_CoreModelEquations_DeriveAnimalNumbAndProd_DetailedFeedingRations:" timeElapsed;
*Add alternative calculations based on detailed feeding rations - for this, do an entire new module that can be added here and executed in case this better data is available or such.
*key: do real N FLOWS - currently, N and P do not really flow: what is in the plant is not linked to what is fertilized; what is excreted and in the animal is not linked to feed!!


*for scenarios where animal numbers are given, we need some further calculations to derive supply/demand ration, etc. - to be used in other scenarios that build on them.
*this is e.g. the case for scenarios that build on FOFA_BAU_2050 as a reference, which is calculated by filing in the given animal numbers thus invalidating the baseline feed supply/demand values.
*this is done by re-running _V6_BaselineValues_ForModelRuns, but for the repsective scenario
*currently, this runs for all scenarios - which does no harm, as it just recalculates some numnbers that are alraeady available for the scenarios without animal number input, and it calculates these values anew for those with animal number assumptions
$include _V6_DeriveSomeValues_ForScenariosWithGivenAnimalNumbers
PUTCLOSE con "   End _V6_DeriveSomeValues_ForScenariosWithGivenAnimalNumbers" timeElapsed


$include _V6_CoreModelEquations_ManureExcretionAndManagement
PUTCLOSE con "   End _V6_CoreModelEquations_ManureExcretionAndManagement:" timeElapsed;

*$include _V6_CoreModelEquations_EntericFermentation
*Below is the option with DETAILED FEEDING RATIONS on commodity level
$include _V6_CoreModelEquations_EntericFerm_DetailedFeedingRations
PUTCLOSE con "   End _V6_CoreModelEquations_EntericFerm_DetailedFeedingRations:" timeElapsed;


$if %UseReference2050% == "YES" $goto UseReference2050_Label3
$include _V6_CoreModelEquations_FertilizerApplication
PUTCLOSE con "   End _V6_CoreModelEquations_FertilizerApplication:" timeElapsed;
$include _V6_CoreModelEquations_FertilizerApplicationEmissions
PUTCLOSE con "   End _V6_CoreModelEquations_FertilizerApplicationEmissions:" timeElapsed;
$goto DoNotUseReference2050_3

$label UseReference2050_Label3
$include _V6_CoreModelEquations_FertilizerApplication_Ref2050
PUTCLOSE con "   End _V6_CoreModelEquations_FertilizerApplication:" timeElapsed;
$include _V6_CoreModelEquations_FertilizerApplicationEmissions_Ref2050
PUTCLOSE con "   End _V6_CoreModelEquations_FertilizerApplicationEmissions:" timeElapsed;
$label DoNotUseReference2050_3


*INCLUDE Y-N-correction from Kevin here.
$include _V6_CoreModelEquations_NYieldCorrection
PUTCLOSE con "   End _V6_CoreModelEquations_NYieldCorrection:" timeElapsed;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Choice of scenarios

*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!*!!!!!!!!!
*!!!!!! When choosing the scenarios, assure to maybe adapt the set definition SET ScenariosResults(Scenarios) in ResultsFiles.gms as needed,  *!!!!!!
*!!!!!! as this set contains the scenarios of interest only for displaying in the results gdx-files.                                          *!!!!!!
*!!!!!! Not adapting this may result in the need to rerun the model, as the values of interest are not written to the results file.           *!!!!!!
*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!*!!!!!!!!!

$label ChoiceOfScenarios


*ATTENTION!!!!!!: IF YOU RUN NEW SCENARIOS:
*assure that you added the code lines needed at
*TO BE IMPROVED - AD HOC    in the FertilizerApplication module, if necessary.
*ATTENTION!!!!!


*$if %Scenario% == "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW" $goto EndOfScenarioRuns
*$if %Scenario% == "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF" $setglobal Scenario "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW"
*$if %Scenario% == "BioeSR15_P4_2050_Bio_AreaIncrease" $setglobal Scenario "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"
*$if %Scenario% == "BioeSR15_P4_2050_Bio" $setglobal Scenario "BioeSR15_P4_2050_Bio_AreaIncrease"
*$if %Scenario% == "BioeSR15_P4_2050" $setglobal Scenario "BioeSR15_P4_2050_Bio"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "BioeSR15_P4_2050"

*$if %Scenario% == "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW" $goto EndOfScenarioRuns
*$if %Scenario% == "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF" $setglobal Scenario "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW"
*$if %Scenario% == "BioeSR15_P4_2050_Bio_AreaIncrease" $setglobal Scenario "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"
*$if %Scenario% == "BioeSR15_P4_2050_Bio" $setglobal Scenario "BioeSR15_P4_2050_Bio_AreaIncrease"
*$if %Scenario% == "BioeSR15_P4_2050" $setglobal Scenario "BioeSR15_P4_2050_Bio"
*$if %Scenario% == "BioeSR15_P4_2050_RefNoBioe" $setglobal Scenario "BioeSR15_P4_2050"
*$if %Scenario% == "Baseline_100Organic" $setglobal Scenario "BioeSR15_P4_2050_RefNoBioe"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "Baseline_100Organic"

*$if %Scenario% == "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF" $goto EndOfScenarioRuns
*$if %Scenario% == "BioeSR15_P4_2050" $setglobal Scenario "BioeSR15_P4_2050_Bio_AreaIncr_NoFCF"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "BioeSR15_P4_2050"


*$if %Scenario% == "Baseline_NoFCF" $goto EndOfScenarioRuns
*$if %Scenario% == "Baseline_100Organic" $setglobal Scenario "Baseline_NoFCF"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "Baseline_100Organic"

*$if %Scenario% == "FOFA_BAU_2012" $goto EndOfScenarioRuns
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2012"


*$if %Scenario% == "AE_food_2050" $goto EndOfScenarioRuns
*$if %Scenario% == "LfS_2050" $setglobal Scenario "AE_food_2050"
*$if %Scenario% == "AE_exports_2050" $setglobal Scenario "LfS_2050"
**$if %Scenario% == "AE_exports_2050" $goto EndOfScenarioRuns
*$if %Scenario% == "LfP_2050" $setglobal Scenario "AE_exports_2050"
*$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "LfP_2050"
*$if %Scenario% == "FOFA_BAU_2012" $setglobal Scenario "FOFA_BAU_2050"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2012"
**$if %Scenario% == "BaselineDerived" $setglobal Scenario "LfP_2050"


*UNISECO RUNS D4.2/D4.3
*TO RUN UNISECO, swtich on ALL with ****
*$setglobal OutputFileLabel "UNISECO_5CoreScenarios_RedProdAbroad"
*$setglobal OutputFileLabel "UNISECO_5CoreScenarios"
****$setglobal OutputFileLabel "UNISECO_5CoreScenarios_ForSessit"
*$setglobal OutputFileLabel "UNISECO_5CoreScenarios_NewGLYields"
*$if %Scenario% == "AE_exports_2050" $goto EndOfScenarioRuns
****$if %Scenario% == "AE_food_2050" $goto EndOfScenarioRuns
****$if %Scenario% == "LfS_2050" $setglobal Scenario "AE_food_2050"
****$if %Scenario% == "AE_exports_2050" $setglobal Scenario "LfS_2050"
*$if %Scenario% == "LfP_2050" $goto EndOfScenarioRuns
*$if %Scenario% == "FOFA_BAU_2050_Test" $goto EndOfScenarioRuns
*$if %Scenario% == "FOFA_BAU_2050" $goto EndOfScenarioRuns
*$if %Scenario% == "LfS_2050" $setglobal Scenario "LfP_2050"
*$if %Scenario% == "FOFA_BAU_2050_Test" $setglobal Scenario "LfS_2050"
****$if %Scenario% == "LfP_2050" $setglobal Scenario "AE_exports_2050"
****$if %Scenario% == "FOFA_BAU_2050_Test" $setglobal Scenario "LfP_2050"
****$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_BAU_2050_Test"
****$if %Scenario% == "FOFA_BAU_2012" $setglobal Scenario "FOFA_BAU_2050"
*$if %Scenario% == "FOFA_BAU_2012" $goto EndOfScenarioRuns
****$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2012"
*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!*!!!!!!!!!
*!!!!!! When choosing the scenarios, assure to maybe adapt the set definition SET ScenariosResults(Scenarios) in ResultsFiles.gms as needed,  *!!!!!!
*!!!!!! as this set contains the scenarios of interest only for displaying in the results gdx-files.                                          *!!!!!!
*!!!!!! Not adapting this may result in the need to rerun the model, as the values of interest are not written to the results file.           *!!!!!!
*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!*!!!!!!!!!


*$setglobal OutputFileLabel "ReferenceFOFA2050_Organic25"
*$if %Scenario% == "FOFA_BAU_2050_25Organic" $goto EndOfScenarioRuns
*$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_BAU_2050_25Organic"
**$if %Scenario% == "FOFA_BAU_2012" $setglobal Scenario "FOFA_BAU_2050"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"

*$setglobal OutputFileLabel "UNISECO_AF_shX_compX_yL_cM_5"
**                                                                        !!!!XXXXXXXXXXXXXXXXXXXXX!!!!!!!!!!!!!!!!!!XXXXXXXXXXXXXXXXXXXXX
****ADJUST in ScenarioSpecification for which scenario some parameters and sets are defined to avoid problems in the loop!!!!!!XXXXXXXXXXXXXXXXXXXXX!!!!!!!!!!!!!!!!!!XXXXXXXXXXXXXXXXXXXXX
*
*$if %Scenario% == "UNISECO_AF_shH_compH_yL_cM_5" $goto EndOfScenarioRuns
*$if %Scenario% == "UNISECO_AF_shL_compH_yL_cM_5" $setglobal Scenario "UNISECO_AF_shH_compH_yL_cM_5"
*$if %Scenario% == "UNISECO_AF_shM_compH_yL_cM_5" $setglobal Scenario "UNISECO_AF_shL_compH_yL_cM_5"
*
*$if %Scenario% == "UNISECO_AF_shH_compL_yL_cM_5" $setglobal Scenario "UNISECO_AF_shM_compH_yL_cM_5"
*$if %Scenario% == "UNISECO_AF_shL_compL_yL_cM_5" $setglobal Scenario "UNISECO_AF_shH_compL_yL_cM_5"
*$if %Scenario% == "UNISECO_AF_shM_compL_yL_cM_5" $setglobal Scenario "UNISECO_AF_shL_compL_yL_cM_5"
*
*$if %Scenario% == "UNISECO_AF_shH_compM_yL_cM_5" $setglobal Scenario "UNISECO_AF_shM_compL_yL_cM_5"
*
*$if %Scenario% == "UNISECO_AF_shH_compM_yL_cM_5" $goto EndOfScenarioRuns
*$if %Scenario% == "UNISECO_AF_shL_compM_yL_cM_5" $setglobal Scenario "UNISECO_AF_shH_compM_yL_cM_5"
*$if %Scenario% == "UNISECO_AF_shM_compM_yL_cM_5" $setglobal Scenario "UNISECO_AF_shL_compM_yL_cM_5"
*
*$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "UNISECO_AF_shM_compM_yL_cM_5"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"
*
*$setglobal OutputFileLabel "UNISECO_AF_shX_compX_yH_cM_5"
**                                                                        !!!!XXXXXXXXXXXXXXXXXXXXX!!!!!!!!!!!!!!!!!!XXXXXXXXXXXXXXXXXXXXX
****ADJUST in ScenarioSpecification for which scenario some parameters and sets are defined to avoid problems in the loop!!!!!!XXXXXXXXXXXXXXXXXXXXX!!!!!!!!!!!!!!!!!!XXXXXXXXXXXXXXXXXXXXX
*
*$if %Scenario% == "UNISECO_AF_shH_compH_yH_cM_5" $goto EndOfScenarioRuns
*$if %Scenario% == "UNISECO_AF_shL_compH_yH_cM_5" $setglobal Scenario "UNISECO_AF_shH_compH_yH_cM_5"
*$if %Scenario% == "UNISECO_AF_shM_compH_yH_cM_5" $setglobal Scenario "UNISECO_AF_shL_compH_yH_cM_5"
*
*$if %Scenario% == "UNISECO_AF_shH_compL_yH_cM_5" $setglobal Scenario "UNISECO_AF_shM_compH_yH_cM_5"
*$if %Scenario% == "UNISECO_AF_shL_compL_yH_cM_5" $setglobal Scenario "UNISECO_AF_shH_compL_yH_cM_5"
*$if %Scenario% == "UNISECO_AF_shM_compL_yH_cM_5" $setglobal Scenario "UNISECO_AF_shL_compL_yH_cM_5"
*
*$if %Scenario% == "UNISECO_AF_shH_compM_yH_cM_5" $setglobal Scenario "UNISECO_AF_shM_compL_yH_cM_5"
*
*$if %Scenario% == "UNISECO_AF_shH_compM_yH_cM_5" $goto EndOfScenarioRuns
*$if %Scenario% == "UNISECO_AF_shL_compM_yH_cM_5" $setglobal Scenario "UNISECO_AF_shH_compM_yH_cM_5"
*$if %Scenario% == "UNISECO_AF_shM_compM_yH_cM_5" $setglobal Scenario "UNISECO_AF_shL_compM_yH_cM_5"
*
*$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "UNISECO_AF_shM_compM_yH_cM_5"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"

*$setglobal OutputFileLabel "UNISECO_AF_shX_compX_yL_cM_25"
**                                                                        !!!!XXXXXXXXXXXXXXXXXXXXX!!!!!!!!!!!!!!!!!!XXXXXXXXXXXXXXXXXXXXX
****ADJUST in ScenarioSpecification for which scenario some parameters and sets are defined to avoid problems in the loop!!!!!!XXXXXXXXXXXXXXXXXXXXX!!!!!!!!!!!!!!!!!!XXXXXXXXXXXXXXXXXXXXX
*
*$if %Scenario% == "UNISECO_AF_shH_compH_yL_cM_25" $goto EndOfScenarioRuns
*$if %Scenario% == "UNISECO_AF_shL_compH_yL_cM_25" $setglobal Scenario "UNISECO_AF_shH_compH_yL_cM_25"
*$if %Scenario% == "UNISECO_AF_shM_compH_yL_cM_25" $setglobal Scenario "UNISECO_AF_shL_compH_yL_cM_25"
*
*$if %Scenario% == "UNISECO_AF_shH_compL_yL_cM_25" $setglobal Scenario "UNISECO_AF_shM_compH_yL_cM_25"
*$if %Scenario% == "UNISECO_AF_shL_compL_yL_cM_25" $setglobal Scenario "UNISECO_AF_shH_compL_yL_cM_25"
*$if %Scenario% == "UNISECO_AF_shM_compL_yL_cM_25" $setglobal Scenario "UNISECO_AF_shL_compL_yL_cM_25"
*
*$if %Scenario% == "UNISECO_AF_shH_compM_yL_cM_25" $setglobal Scenario "UNISECO_AF_shM_compL_yL_cM_25"
*
*$if %Scenario% == "UNISECO_AF_shH_compM_yL_cM_25" $goto EndOfScenarioRuns
*$if %Scenario% == "UNISECO_AF_shL_compM_yL_cM_25" $setglobal Scenario "UNISECO_AF_shH_compM_yL_cM_25"
*$if %Scenario% == "UNISECO_AF_shM_compM_yL_cM_25" $setglobal Scenario "UNISECO_AF_shL_compM_yL_cM_25"
*
*$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "UNISECO_AF_shM_compM_yL_cM_25"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"

***$setglobal OutputFileLabel "UNISECO_AF_shX_compX_yH_cM_25"
****                                                                        !!!!XXXXXXXXXXXXXXXXXXXXX!!!!!!!!!!!!!!!!!!XXXXXXXXXXXXXXXXXXXXX
****ADJUST in ScenarioSpecification for which scenario some parameters and sets are defined to avoid problems in the loop!!!!!!XXXXXXXXXXXXXXXXXXXXX!!!!!!!!!!!!!!!!!!XXXXXXXXXXXXXXXXXXXXX
*
***$if %Scenario% == "UNISECO_AF_shH_compH_yH_cM_25" $goto EndOfScenarioRuns
***$if %Scenario% == "UNISECO_AF_shL_compH_yH_cM_25" $setglobal Scenario "UNISECO_AF_shH_compH_yH_cM_25"
***$if %Scenario% == "UNISECO_AF_shM_compH_yH_cM_25" $setglobal Scenario "UNISECO_AF_shL_compH_yH_cM_25"
***
***$if %Scenario% == "UNISECO_AF_shH_compL_yH_cM_25" $setglobal Scenario "UNISECO_AF_shM_compH_yH_cM_25"
***$if %Scenario% == "UNISECO_AF_shL_compL_yH_cM_25" $setglobal Scenario "UNISECO_AF_shH_compL_yH_cM_25"
***$if %Scenario% == "UNISECO_AF_shM_compL_yH_cM_25" $setglobal Scenario "UNISECO_AF_shL_compL_yH_cM_25"
***
***$if %Scenario% == "UNISECO_AF_shH_compM_yH_cM_25" $setglobal Scenario "UNISECO_AF_shM_compL_yH_cM_25"
***
***$if %Scenario% == "UNISECO_AF_shH_compM_yH_cM_25" $goto EndOfScenarioRuns
***$if %Scenario% == "UNISECO_AF_shL_compM_yH_cM_25" $setglobal Scenario "UNISECO_AF_shH_compM_yH_cM_25"
***$if %Scenario% == "UNISECO_AF_shM_compM_yH_cM_25" $setglobal Scenario "UNISECO_AF_shL_compM_yH_cM_25"
***
***$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "UNISECO_AF_shM_compM_yH_cM_25"
***$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"


*$setglobal OutputFileLabel "UNISECO_AF_shX_compX_yL_cM_5_Test2"
*****                                                                        !!!!XXXXXXXXXXXXXXXXXXXXX!!!!!!!!!!!!!!!!!!XXXXXXXXXXXXXXXXXXXXX
*****ADJUST in ScenarioSpecification for which scenario some parameters and sets are defined to avoid problems in the loop!!!!!!XXXXXXXXXXXXXXXXXXXXX!!!!!!!!!!!!!!!!!!XXXXXXXXXXXXXXXXXXXXX
*
*$if %Scenario% == "UNISECO_AF_shM_compM_yL_cM_5" $goto EndOfScenarioRuns
*
*$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "UNISECO_AF_shM_compM_yL_cM_5"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"

$ontext
$setglobal OutputFileLabel "VeganScenarios_210814_testDiverse"

*$if %Scenario% == "FOFA_2050_VeganOptimized" $goto EndOfScenarioRuns
**$if %Scenario% == "FOFA_2050_VeganBarbieri" $setglobal Scenario "FOFA_2050_VeganBarbieri_a"
*$if %Scenario% == "FOFA_2050_VeganSchmidt" $setglobal Scenario "FOFA_2050_VeganOptimized"
*$if %Scenario% == "FOFA_2050_VeganBarbieri" $setglobal Scenario "FOFA_2050_VeganSchmidt"
**$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBarbieri"
*$if %Scenario% == "FOFA_2050_VeganOptimized_conv" $setglobal Scenario "FOFA_2050_VeganBarbieri"

*$if %Scenario% == "FOFA_2050_VeganBarbieri" $goto EndOfScenarioRuns
*$if %Scenario% == "FOFA_2050_VeganOptimized_conv" $setglobal Scenario "FOFA_2050_VeganBarbieri"
*$if %Scenario% == "FOFA_2050_VeganBAU" $goto EndOfScenarioRuns
$if %Scenario% == "FOFA_BAU_2050" $goto EndOfScenarioRuns
$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"
$offtext


$ontext
$setglobal OutputFileLabel "VeganScenarios_210811_mainRuns_2"

*$if %Scenario% == "FOFA_2050_VeganOptimized" $goto EndOfScenarioRuns
**$if %Scenario% == "FOFA_2050_VeganBarbieri" $setglobal Scenario "FOFA_2050_VeganBarbieri_a"
*$if %Scenario% == "FOFA_2050_VeganSchmidt" $setglobal Scenario "FOFA_2050_VeganOptimized"
*$if %Scenario% == "FOFA_2050_VeganBarbieri" $setglobal Scenario "FOFA_2050_VeganSchmidt"
**$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBarbieri"
*$if %Scenario% == "FOFA_2050_VeganOptimized_conv" $setglobal Scenario "FOFA_2050_VeganBarbieri"

$if %Scenario% == "FOFA_2050_VeganOptimized" $goto EndOfScenarioRuns
$if %Scenario% == "FOFA_2050_VeganSchmidt" $setglobal Scenario "FOFA_2050_VeganOptimized"
$if %Scenario% == "FOFA_2050_VeganBarbieri" $setglobal Scenario "FOFA_2050_VeganSchmidt"

$if %Scenario% == "FOFA_2050_VeganOptimized_conv" $setglobal Scenario "FOFA_2050_VeganBarbieri"
$if %Scenario% == "FOFA_2050_VeganBAU_NoFreeAreaUse" $setglobal Scenario "FOFA_2050_VeganOptimized_conv"
$if %Scenario% == "FOFA_2050_VeganBAU" $setglobal Scenario "FOFA_2050_VeganBAU_NoFreeAreaUse"
$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBAU"
$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"

$offtext

$ontext
$setglobal OutputFileLabel "VeganScenarios_210811_mainRuns_2_YieldGapCorrected"

*$if %Scenario% == "FOFA_2050_VeganOptimized" $goto EndOfScenarioRuns
**$if %Scenario% == "FOFA_2050_VeganBarbieri" $setglobal Scenario "FOFA_2050_VeganBarbieri_a"
*$if %Scenario% == "FOFA_2050_VeganSchmidt" $setglobal Scenario "FOFA_2050_VeganOptimized"
*$if %Scenario% == "FOFA_2050_VeganBarbieri" $setglobal Scenario "FOFA_2050_VeganSchmidt"
**$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBarbieri"
*$if %Scenario% == "FOFA_2050_VeganOptimized_conv" $setglobal Scenario "FOFA_2050_VeganBarbieri"

$if %Scenario% == "FOFA_2050_VeganOptimized" $goto EndOfScenarioRuns
$if %Scenario% == "FOFA_2050_VeganSchmidt" $setglobal Scenario "FOFA_2050_VeganOptimized"
$if %Scenario% == "FOFA_2050_VeganBarbieri" $setglobal Scenario "FOFA_2050_VeganSchmidt"

$if %Scenario% == "FOFA_2050_VeganOptimized_conv" $setglobal Scenario "FOFA_2050_VeganBarbieri"
$if %Scenario% == "FOFA_2050_VeganBAU_NoFreeAreaUse" $setglobal Scenario "FOFA_2050_VeganOptimized_conv"
$if %Scenario% == "FOFA_2050_VeganBAU" $setglobal Scenario "FOFA_2050_VeganBAU_NoFreeAreaUse"
$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBAU"
$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"

$offtext

************************ov***********************
$ontext
$setglobal OutputFileLabel "VeganScenarios_210815_Barbieri_ov_Run1"


$if %Scenario% == "FOFA_2050_VeganBarbieri_100_20" $goto EndOfScenarioRuns

$if %Scenario% == "FOFA_2050_VeganBarbieri_75_20" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_20"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_20" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_20"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_20" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_20"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_20" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_20"
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_0" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_20"
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_0" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_0"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_0" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_0"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_0" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_0"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_0" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_0"
$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_0"
$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"
$offtext



$ontext

$setglobal OutputFileLabel "VeganScenarios_210815_Barbieri_ov_Run2"

$if %Scenario% == "FOFA_2050_VeganBarbieri_100_60" $goto EndOfScenarioRuns

$if %Scenario% == "FOFA_2050_VeganBarbieri_75_60" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_60"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_60" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_60"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_60" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_60"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_60" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_60"
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_40" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_60"
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_40" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_40"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_40" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_40"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_40" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_40"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_40" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_40"
$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_40"
$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"
$offtext

$ontext
$setglobal OutputFileLabel "VeganScenarios_210815_Barbieri_ov_Run3"

$if %Scenario% == "FOFA_2050_VeganBarbieri_100_100" $goto EndOfScenarioRuns

$if %Scenario% == "FOFA_2050_VeganBarbieri_75_100" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_100"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_100" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_100"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_100" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_100"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_100" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_100"
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_80" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_100"
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_80" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_80"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_80" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_80"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_80" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_80"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_80" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_80"
$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_80"
$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"
$offtext



************************ov - yield gap corrected***********************

$ontext
$setglobal OutputFileLabel "VeganScenarios_210815_Barbieri_ov_Run1_yieldGapCorrected"


$if %Scenario% == "FOFA_2050_VeganBarbieri_100_20" $goto EndOfScenarioRuns

$if %Scenario% == "FOFA_2050_VeganBarbieri_75_20" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_20"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_20" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_20"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_20" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_20"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_20" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_20"
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_0" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_20"
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_0" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_0"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_0" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_0"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_0" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_0"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_0" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_0"
$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_0"
$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"
$offtext



$ontext

$setglobal OutputFileLabel "VeganScenarios_210815_Barbieri_ov_Run2_yieldGapCorrected"

$if %Scenario% == "FOFA_2050_VeganBarbieri_100_60" $goto EndOfScenarioRuns

$if %Scenario% == "FOFA_2050_VeganBarbieri_75_60" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_60"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_60" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_60"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_60" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_60"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_60" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_60"
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_40" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_60"
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_40" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_40"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_40" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_40"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_40" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_40"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_40" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_40"
$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_40"
$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"
$offtext

*$ontext
$setglobal OutputFileLabel "VeganScenarios_210815_Barbieri_ov_Run3_yieldGapCorrected"

$if %Scenario% == "FOFA_2050_VeganBarbieri_100_100" $goto EndOfScenarioRuns

$if %Scenario% == "FOFA_2050_VeganBarbieri_75_100" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_100"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_100" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_100"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_100" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_100"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_100" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_100"
$if %Scenario% == "FOFA_2050_VeganBarbieri_100_80" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_100"
$if %Scenario% == "FOFA_2050_VeganBarbieri_75_80" $setglobal Scenario "FOFA_2050_VeganBarbieri_100_80"
$if %Scenario% == "FOFA_2050_VeganBarbieri_50_80" $setglobal Scenario "FOFA_2050_VeganBarbieri_75_80"
$if %Scenario% == "FOFA_2050_VeganBarbieri_25_80" $setglobal Scenario "FOFA_2050_VeganBarbieri_50_80"
$if %Scenario% == "FOFA_2050_VeganBarbieri_0_80" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_80"
$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBarbieri_0_80"
$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"
*$offtext

*******************************************************



$ontext
$setglobal OutputFileLabel "VeganScenarios_210815_testBAUCropRot"

$if %Scenario% == "FOFA_2050_VeganBarbieri_25_80" $goto EndOfScenarioRuns
$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_2050_VeganBarbieri_25_80"
$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"
$offtext





*$setglobal OutputFileLabel "FOFA_BAU_2050_NoFCF"
*$if %Scenario% == "FOFA_BAU_2050_NoFCF" $goto EndOfScenarioRuns
*$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_BAU_2050_NoFCF"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"

*$setglobal OutputFileLabel "ReferenceFOFA2050_10PercLessArea"
*$if %Scenario% == "FOFA_BAU_2050_Test_10PercLessArea" $goto EndOfScenarioRuns
*$if %Scenario% == "FOFA_BAU_2050_Test" $setglobal Scenario "FOFA_BAU_2050_Test_10PercLessArea"
*$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_BAU_2050_Test"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"

*$if %Scenario% == "FOFA_BAU_2050" $goto EndOfScenarioRuns
*$if %Scenario% == "FOFA_BAU_2012" $setglobal Scenario "FOFA_BAU_2050"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2012"

*$if %Scenario% == "FOFA_BAU_2012" $goto EndOfScenarioRuns
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2012"

*$setglobal OutputFileLabel "ReferenceFOFA2050"
*$if %Scenario% == "FOFA_BAU_2050_Test" $goto EndOfScenarioRuns
*$if %Scenario% == "FOFA_BAU_2050" $setglobal Scenario "FOFA_BAU_2050_Test"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"

*$if %Scenario% == "FOFA_BAU_2050" $goto EndOfScenarioRuns
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "FOFA_BAU_2050"

*$if %Scenario% == "Baseline_50Organic" $goto EndOfScenarioRuns
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "Baseline_50Organic"

*$if %Scenario% == "Baseline_100Organic" $goto EndOfScenarioRuns
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "Baseline_100Organic"

*zhaw-Scenario:
*$setglobal OutputFileLabel "zhaw_Calculations"
*$if %Scenario% == "zhaw_NoFeedImports_a" $goto EndOfScenarioRuns
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "zhaw_NoFeedImports_a"
*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!*!!!!!!!!!
*!!!!!! When choosing the scenarios, assure to maybe adapt the set definition SET ScenariosResults(Scenarios) in ResultsFiles.gms as needed,  *!!!!!!
*!!!!!! as this set contains the scenarios of interest only for displaying in the results gdx-files.                                          *!!!!!!
*!!!!!! Not adapting this may result in the need to rerun the model, as the values of interest are not written to the results file.           *!!!!!!
*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!*!!!!!!!!!


*$if %Scenario% == "Bioenergy_RCardinaals_1" $goto EndOfScenarioRuns
*$if %Scenario% == "ELAniVarProd_RCardinaals_1" $setglobal Scenario "Bioenergy_RCardinaals_1"
*$if %Scenario% == "BaselineDerived" $setglobal Scenario "ELAniVarProd_RCardinaals_1"


$setglobal OutputFileLabel "BaselineScenario"
$if %Scenario% == "BaselineDerived" $goto EndOfScenarioRuns
*this only runs for baselineDerived, then storing the data with the label just above -
*        for other scenarios, the label is reset each time the code runs through the blocks above and keeps the respective label from above, when jumping out of the loop to EndOfScenarioRuns


$if %RunAllChosenScenarios% == YES $goto Restart

$label EndOfScenarioRuns


*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!*!!!!!!!!!
*!!!!!! When choosing the scenarios, assure to maybe adapt the set definition SET ScenariosResults(Scenarios) in ResultsFiles.gms as needed,  *!!!!!!
*!!!!!! as this set contains the scenarios of interest only for displaying in the results gdx-files.                                          *!!!!!!
*!!!!!! Not adapting this may result in the need to rerun the model, as the values of interest are not written to the results file.           *!!!!!!
*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!!*!!!!!!!!!!*!!!!!!*!!!!!!!!!


execute_unload "Test6"
VCropResidues_Management_MR
CropResidues_Management_MR
VActCropsGrass_Outputs_MR
PermGrass_CropResidues_Management_MR
;

*here all crop res / man quant as needed are available.

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) Further calculations after finishing the scenario runs

$include _V6_DeriveAggregateImpacts_PerUnit
PUTCLOSE con "   End _V6_DeriveAggregateImpacts_PerUnit:" timeElapsed;

$include _V6_DeriveTotalImpacts
PUTCLOSE con "   End _V6_DeriveTotalImpacts:" timeElapsed;


*the following takes quite long, so swotch on only when really needed (e.g. for UNISECO, data for the economics calculations for SLU - so not needed for our core output and consistency checks).
$if %DeriveRefinedTradeData% == "NO" $goto EndOf_DeriveRefinedTradeData
$include _V6_DeriveRefinedTradeDataEtc
PUTCLOSE con "   End _V6_DeriveRefinedTradeDataEtc:" timeElapsed;
$label EndOf_DeriveRefinedTradeData

*the following two currently take VERY LONG if executed fully - hence only partly executed and cutoff by "$exit" within the module, or not executed at all!!
$include _V6_DeriveGeographicAggregations
PUTCLOSE con "   End _V6_DeriveGeographicAggregations:" timeElapsed;
$include _V6_DeriveActivityGroupAggregations
PUTCLOSE con "   End _V6_DeriveActivityGroupAggregations:" timeElapsed;


$include _V6_DerivePerAPUValues
PUTCLOSE con "   End _V6_DerivePerAPUValues:" timeElapsed;


$if %CalculateFootprints% == "NO" $goto EndOf_CalculateFootprints

*The following code is run several times in a loop to get results for the different ways to allocate impacts:
$label RestartAllocationCode

$include _V6_DerivePerPrimaryProductImpacts
PUTCLOSE con "   End _V6_DerivePerPrimaryProductImpacts:" timeElapsed;

*this should not be needed anymore - should ba done in the previous file already
*$include _V6_DeriveAggregateImpacts_PrimProd
*PUTCLOSE con "   End _V6_DeriveAggregateImpacts_PrimProd:" timeElapsed;

$include _V6_DerivePerCommodityImpacts
PUTCLOSE con "   End _V6_DerivePerCommodityImpacts:" timeElapsed;
*$offtext;

$if %Allocation% == "MainProduct" $goto EndOfAllocationCode
$if %Allocation% == "Price" $setglobal Allocation "MainProduct"
$if %Allocation% == "Protein" $setglobal Allocation "Price"
$if %Allocation% == "Calories" $setglobal Allocation "Protein"
$if %Allocation% == "Mass" $setglobal Allocation "Calories"

$goto RestartAllocationCode

$label EndOfAllocationCode
$label EndOf_CalculateFootprints


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) Define some output files
PUTCLOSE con,"Write to output files"
$include _V6_OutputFiles_SteeringFile2
PUTCLOSE con "   time elapsed till end of _V6_OutputFiles_SteeringFile2:" timeElapsed;
$ontext;

*this code produces the following gdx-files:

'GeneralModelSets_MR'
'GeneralModelParameters_Inputs_MR'
'GeneralModelParameters_Outputs_MR'
'GeneralModelParameters_OtherChar_MR'
'GeneralModelParameters_Various_MR'
'GeneralModelParameters_Auxiliary_MR'
'GeneralModelVariables_ActivityQuantities_MR'
'GeneralModelVariables_Inputs_MR'
'GeneralModelVariables_Outputs_MR'
'GeneralModelVariables_OtherChar_MR'
'GeneralModelVariables_Various_MR'
'GeneralModelVariables_Trade_MR'
'GeneralModelVariables_CommodityTree_MR'
'GeneralModelVariables_Auxiliary_MR'
$offtext;




$include _V6_ResultsFiles
PUTCLOSE con "   End _V6_ResultsFiles:" timeElapsed;




$ontext;
execute_unload "Test_%OutputFileLabel%"
ActCropsGrass_OtherChar_MR
;
$offtext;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*7) Do some further specific calculations needed for certain aspects
PUTCLOSE con,"Additional specific calculations"

$if %DoUNISECO_SESSIT_Calculations% == "NO" $goto DoNoUNISECO_SESSIT_Calculations

*Do specific calculations for the SESSIT tool of the UNISECO-project
$include _V6_SESSIT_UNISECO_Calculations
PUTCLOSE con "   time elapsed till end of _V6_SESSIT_UNISECO_Calculations:" timeElapsed;

$label DoNoUNISECO_SESSIT_Calculations




$exit;

















*first, we need some additional set elements, sets, etc.
$include __SOLmV5_Sets_AdditionalSubsetsMatchingSets_ForModelRuns
*and some additional parameters and variables:
$include __SOLmV5_AdditionalParametersVariables_ForModelRuns



$setglobal ScenarioSOLmV5 "Baseline"

$label Restart

$if %ScenarioSOLmV5% == "Baseline" $goto ChoiceOfScenarios

$include __SOLmV5_AssignInitialValuesToScenarios



$include __SOLmV5_SpecifyScenarioAssumptions


*key: do real N FLOWS - currently, N and P do not really flow: what is in the plant is not linked to what is fertilized; what is excreted and in the animal is not linked to feed!!



$include __SOLmV5_MainCoreModelEquations

*this module "__SOLmV5_MainCoreModelEquations" just above contains the following modules:
$ontext;
*$include __SOLmV5_DataDerived_CropProductionTotalsAndDAQ

Then: link: production items - DAQ items (commodity trees!)

DONE *$include __SOLmV5_DataDerived_CropResidueManagement
DONE *$include __SOLmV5_DataDerived_CropGrassNutrientRequirements



DONE *$include __SOLmV5_CoreModelEquations_NutrientRequirementsAndFeedSupply



DONE *$include __SOLmV5_CoreModelEquations_DeriveAnimalNumbers
Add alternative calculations based on detailed feeding rations - for this, do an entire new module that can be added here and executed in case this batter data is available or such.
key: do real N FLOWS - currently, N and P do not really flow: what is in the plant is not linked to what is fertilized; what is excreted and in the animal is not linked to feed!!

DONE *$include __SOLmV5_CoreModelEquations_ManureExcretionAndManagement
DONE *$include __SOLmV5_CoreModelEquations_EntericFermentation




$offtext;



$label ChoiceOfScenarios

$if %ScenarioSOLmV5% == "FNF_NFP69" $goto EndOfScenarioRuns
$if %ScenarioSOLmV5% == "NoConcentratesForAnyAnimal" $setglobal ScenarioSOLmV5 "FNF_NFP69"
*$if %ScenarioSOLmV5% == "NoConcentratesForAnyAnimal" $goto EndOfScenarioRuns
*$if %ScenarioSOLmV5% == "BaselineDerived" $goto EndOfScenarioRuns
$if %ScenarioSOLmV5% == "BaselineDerived" $setglobal ScenarioSOLmV5 "NoConcentratesForAnyAnimal"
$if %ScenarioSOLmV5% == "Baseline" $setglobal ScenarioSOLmV5 "BaselineDerived"

PUTCLOSE con,'******SCENARIO: %ScenarioSOLmV5%'
$if %RunAllChosenScenarios% == YES $goto Restart


$label EndOfScenarioRuns



*****specific read out for Anita, 2.11.2018
****execute_unload 'SharesActivitiesInAggregatesNFP69'
****ShareSingleActivitiesInAggregates_SOLmV5_ModelRun
****;
****
****$exit;

*now, after having prepared everything, we can calculate totals, environmental impacts, and aggregations, and code the results and output files


GO ON HERE!!!


*first, we specifically do land use impacts, for crops and animal products in primary production level, and then also on DAQ level
$include __SOLmV5_CoreModelEquations_LandUseImpact.gms



$include __SOLmV5_CoreModelEquations_AggregateToAllCategoriesAverageProdType.gms



*Here, as it should be the case: no values for the AP total countries, i.e. Switzerland and Austria are available - only the regions.
*Any aggregates for CH and AT are built below

*the following are aggregations from sub-regions to countries, not from countries to larger reagions, this comes later
$include __SOLmV5_CoreModelEquations_GeographicAggregations.gms
*after this, we have all relevant values in CH/AT country values as well.



*GO ON HERE WITH DETAILED RESULTS TESTING!!

$include __SOLmV5_CoreModelEquations_PerUnitAggregations.gms




$ontext;
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
execute_unload 'Test3'
AreaOccupiedSOLmV5_ModelRun
AreaHarvestedSOLmV5_ModelRun
PrimaryProductionQuantitySOLmV5_ModelRun
NumberLivingAnimals_HerdStructureSOLmV5_ModelRun
ImportLivingAnimals_HerdStructureSOLmV5_ModelRun
ExportLivingAnimals_HerdStructureSOLmV5_ModelRun
StockChangeLivingAnimals_HerdStructureSOLmV5_ModelRun
NumberProducingAnimals_HerdStructureSOLmV5_ModelRun
DomestAvailableQuantitySOLmV5_ModelRun
ImportQuantitySOLmV5_ModelRun
ExportQuantitySOLmV5_ModelRun
StockChangesQuantitySOLmV5_ModelRun
DAQCommodityProductionQuantitySOLmV5_ModelRun
DAQFeedSupplyQuantitySOLmV5_ModelRun
DAQSeedSupplyQuantitySOLmV5_ModelRun
DAQFoodSupplyQuantitySOLmV5_ModelRun
DAQWasteQuantitySOLmV5_ModelRun
DAQProcessingQuantitySOLmV5_ModelRun
DAQOtherUsesQuantitySOLmV5_ModelRun
SeedQuantitySOLmV5_ModelRun
ManureQuantitySOLmV5_ModelRun
MineralFertilizerQuantitySOLmV5_ModelRun
CropResidueQuantitySOLmV5_ModelRun
PopulationNumbersSOLmV5_ModelRun
;

execute_unload 'Test15'
AreaBasedTotalValuesSOLmV5_ModelRun
PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun
ManureQuantityBasedTotalValuesSOLmV5_ModelRun
MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun
CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun
SeedQuantityBasedTotalValuesSOLmV5_ModelRun
LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun
ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun
DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun
PopulationNumberBasedTotalValuesSOLmV5_ModelRun
LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun
LivestockUnits_ImportLivingAnimals_HerdStructureSOLmV5_ModelRun
LivestockUnits_ExportLivingAnimals_HerdStructureSOLmV5_ModelRun
;


execute_unload 'Test155'
ParameterPerHaSOLmV5_ModelRun
ParameterPerTonPrimaryProdSOLmV5_ModelRun
ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun
ParameterPerTonDomestAvailQuantSOLmV5_ModelRun
ParameterPerTonManureSOLmV5_ModelRun
ParameterPerTonMineralFertSOLmV5_ModelRun
ParameterPerTonCropResidueSOLmV5_ModelRun
ParameterPerTonSeedSOLmV5_ModelRun
ParameterPerHumanCapitaSOLmV5_ModelRun
FeedingRationSOLmV5_ModelRun
FertilizationSOLmV5_ModelRun
AnimalProductionUnitStructureSOLmV5_ModelRun
;

*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
$offtext;



*GO ON HERE WITH DETAILED CODE TESTING!!

*now derive the other feed impacts than land use:
$include __SOLmV5_CoreModelEquations_FeedImpact.gms

execute_unload 'Test2_2'
DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun
;

$include __SOLmV5_CoreModelEquations_DeriveTotalValues.gms



execute_unload 'Test2_3'
DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun
;

$include __SOLmV5_CoreModelEquations_TotalAggregations.gms

execute_unload 'Test2_3a'
DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun
;






$ontext;
IMPROVE env impacts as LCA-formed code:
$include __SOLmV4_EnvironmentalImpacts_LCA.gms
$offtext;





****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Define some output files
PUTCLOSE con,"Write to output files"

execute_unload 'SOLmV5_CoreModelSets_ModelRun_Results'
GeographicRegionSOLmV5_ModelRun
ActivitySOLmV5_ModelRun
LiveAnimalsSOLmV5_ModelRun
CropsSOLmV5_ModelRun
GrassActivitiesSOLmV5_ModelRun
CommoditySOLmV5_ModelRun
FeedGroupsSOLmV5_ModelRun
OutputTypeSOLmV5_ModelRun
ProductionTypeSOLmV5_ModelRun
ProductionConditionsSOLmV5_ModelRun
AnimalCategoriesInHerdSOLmV5_ModelRun
ManureSourceAnimalSOLmV5_ModelRun
TemperaturesSOLmV5_ModelRun
ImportCountrySOLmV5_ModelRun
ExportCountrySOLmV5_ModelRun
ManureManSystemSOLmV5_ModelRun
ManureManSystemCroplandSOLmV5_ModelRun
ManureManSystemGrasslandSOLmV5_ModelRun
MineralFertilizerTypeSOLmV5_ModelRun
MineralFertilizerProdSystemSOLmV5_ModelRun
CropResidueTypeSOLmV5_ModelRun
CropResManSystemSOLmV5_ModelRun
PopulationGroupsSOLmV5_ModelRun
FeedTotal_CommoditySOLmV5_ModelRun
FeedConcentrates_CommoditySOLmV5_ModelRun
FeedForageCrops_CommoditySOLmV5_ModelRun
FeedGrass_CommoditySOLmV5_ModelRun
FeedResidues_CommoditySOLmV5_ModelRun
FeedByproducts_CommoditySOLmV5_ModelRun
FeedOther_CommoditySOLmV5_ModelRun
CommoditySOLmV5_FeedAggregates_ModelRun
;

execute_unload 'SOLmV5_CoreModelVariables_ModelRun_Results'
AreaOccupiedSOLmV5_ModelRun
AreaHarvestedSOLmV5_ModelRun
PrimaryProductionQuantitySOLmV5_ModelRun
NumberLivingAnimals_HerdStructureSOLmV5_ModelRun
ImportLivingAnimals_HerdStructureSOLmV5_ModelRun
ExportLivingAnimals_HerdStructureSOLmV5_ModelRun
StockChangeLivingAnimals_HerdStructureSOLmV5_ModelRun
NumberProducingAnimals_HerdStructureSOLmV5_ModelRun
DomestAvailableQuantitySOLmV5_ModelRun
ImportQuantitySOLmV5_ModelRun
ExportQuantitySOLmV5_ModelRun
StockChangesQuantitySOLmV5_ModelRun
DAQCommodityProductionQuantitySOLmV5_ModelRun
DAQFeedSupplyQuantitySOLmV5_ModelRun
DAQSeedSupplyQuantitySOLmV5_ModelRun
DAQFoodSupplyQuantitySOLmV5_ModelRun
DAQWasteQuantitySOLmV5_ModelRun
DAQProcessingQuantitySOLmV5_ModelRun
DAQOtherUsesQuantitySOLmV5_ModelRun
SeedQuantitySOLmV5_ModelRun
ManureQuantitySOLmV5_ModelRun
MineralFertilizerQuantitySOLmV5_ModelRun
CropResidueQuantitySOLmV5_ModelRun
PopulationNumbersSOLmV5_ModelRun
;

execute_unload 'SOLmV5_DerivedModelVariables_ModelRun_Results'
AreaBasedTotalValuesSOLmV5_ModelRun
PrimaryProductionQuantityBasedTotalValuesSOLmV5_ModelRun
ManureQuantityBasedTotalValuesSOLmV5_ModelRun
MineralFertilizerQuantityBasedTotalValuesSOLmV5_ModelRun
CropResidueQuantityBasedTotalValuesSOLmV5_ModelRun
SeedQuantityBasedTotalValuesSOLmV5_ModelRun
LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun
ProducingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun
DomestAvailableQuantityBasedTotalValuesSOLmV5_ModelRun
PopulationNumberBasedTotalValuesSOLmV5_ModelRun
LivestockUnits_NumberLivingAnimals_HerdStructureSOLmV5_ModelRun
LivestockUnits_ImportLivingAnimals_HerdStructureSOLmV5_ModelRun
LivestockUnits_ExportLivingAnimals_HerdStructureSOLmV5_ModelRun
;


execute_unload 'SOLmV5_CoreModelParameters_ModelRun_Results'
ParameterPerHaSOLmV5_ModelRun
ParameterPerTonPrimaryProdSOLmV5_ModelRun
ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun
ParameterPerTonDomestAvailQuantSOLmV5_ModelRun
ParameterPerTonManureSOLmV5_ModelRun
ParameterPerTonMineralFertSOLmV5_ModelRun
ParameterPerTonCropResidueSOLmV5_ModelRun
ParameterPerTonSeedSOLmV5_ModelRun
ParameterPerHumanCapitaSOLmV5_ModelRun
FeedingRationSOLmV5_ModelRun
FertilizationSOLmV5_ModelRun
AnimalProductionUnitStructureSOLmV5_ModelRun
;

execute_unload 'SOLmV5_AuxiliaryModelParameters_ModelRun_Results'
GWP_GTP_SOLmV5_ModelRun
ShareSingleActivitiesInAggregates_SOLmV5_ModelRun
CommodityActivityAreaCountCorrectionFactor
;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) Do some further specific calculations needed for certain aspects
PUTCLOSE con,"Additional specific calculations"

*ths following is still RATHER SLOW - thus only use when needed!!
*$include __SOLmV5_CoreModelEquations_SomeSpecialOutputForNFP69.gms



$goto EndOfSteeringFile_CoreModelScenariosAndEquations


$label EndOfSteeringFile_CoreModelScenariosAndEquations
PUTCLOSE con,"End of ___SOLmV5_SteeringFile_CoreModelScenariosAndEquations.gms";






