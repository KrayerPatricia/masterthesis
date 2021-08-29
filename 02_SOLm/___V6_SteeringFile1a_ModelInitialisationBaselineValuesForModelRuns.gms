*Steering file for model version V6: a second file with preparatory code

*GENERAL DESCRIPTION
*This file calculates some additional values for the baseline needed in the model runs


*DETAILED TABLE OF CONTENTS
$ontext;
- 1) General settings
         1.1) Operating systems settings, etc.
- 2) Define sets, parameters and variabless and load gdx files from the baseline assignment
- 3) Define some output files

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


$include _V6_VariablesAndParameters_ModelRun_ForSteeringFile2
PUTCLOSE con "   End _V6_VariablesAndParameters_ModelRun_ForSteeringFile2:" timeElapsed;

*MAY MOVE THE FOLLOWING INTO ScenarioSpecifications????
$include _V6_InitialiseSetsForModelRuns
PUTCLOSE con "   End _V6_InitialiseSetsForModelRuns:" timeElapsed;


*we need the following for deriving some additional values for Scenario=Baseline:
$include _V6_BaselineValues_ForModelRuns
PUTCLOSE con "   End _V6_BaselineValues_ForModelRuns:" timeElapsed;


*after this, we have all sets, parameters, variables we need for the model run, and we have the Scenario=Baseline values we need
*we thus store this in gdx files which are then the basis for the model runs and the code above need not be rerun each time we want to do model runs
PUTCLOSE con "   All baseline values are ready for the scenario runs:" timeElapsed;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) Define some output files
PUTCLOSE con,"Write to output files"
$include _V6_OutputFiles_SteeringFile1a
PUTCLOSE con "   time elapsed till end of _V6_OutputFiles_SteeringFile2:" timeElapsed;



