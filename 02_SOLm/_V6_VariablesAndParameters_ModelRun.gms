PUTCLOSE con,"_V6_VariablesAndParameters_ModelRun";

$ontext;
GENERAL DESCRIPTION
This file declares the parameters and variables for the model runs.
In this, it is identical to _V6_VariablesAndParameters besides adding a scenario-dimension to each parameter and variable
and defining the corresponding scenario set.

The general procedure is: add _MR (for model run) to the parameter/variable names and add the scenario dimension at the end of them


DETAILED TABLE OF CONTENTS
- 0) Define scenario set
- 1) Main parameters
         1.1) Activities: input parameters
         1.2) Activities: output parameters
         1.3) Activities: other characteristics
         1.4) Commodities: nutrient contents and other characteristics
         1.5) Commodity tree parameters
         1.6) Crop residues: nutrient contents, other characteristics and management
         1.7) Feeding rations
         1.8) Manure: nutrient contents, other characteristics and management
         1.9) Fertilizer application: nutrients and other characteristics
         1.10)Extraction rates
- 2) Main variables
         2.1) Amount of activity units
         2.2) Inputs to activities
         2.3) Outputs from activities
         2.4) Other characteristics of activities
         2.5) Commodity quantities, nutrient contained and other characteristics
         2.6) Commodity untilizations
         2.7) Crop residue quantities, nutrient contained, other characteristics and management
         2.8) Feeding rations quantities
         2.9) Manure quantities, nutrients contained, other characteristics and management
         2.10) Fertilizer application: nutrients and other characteristics
         2.11) Import and export quantities
         2.12) Commodities expressed in primary product equivalents
- 3) Auxiliary parameters
- 4) Auxiliary variables
- 5) Initialise par/var for model runs with baseline values
         5.1) Main parameters
                 5.1.1) Activities: input parameters
                 5.1.2) Activities: output parameters
                 5.1.3) Activities: other characteristics
                 5.1.4) Commodities: nutrient contents and other characteristics
                 5.1.5) Commodity tree parameters
                 5.1.6) Crop residues: nutrient contents, other characteristics and management
                 5.1.7) Feeding rations
                 5.1.8) Manure: nutrient contents, other characteristics and management
                 5.1.9) Fertilizer application: nutrients and other characteristics
                 5.1.10)Extraction rates
         5.2) Main variables
                 5.2.1) Amount of activity units
                 5.2.2) Inputs to activities
                 5.2.3) Outputs from activities
                 5.2.4) Other characteristics of activities
                 5.2.5) Commodity quantities, nutrient contained and other characteristics
                 5.2.6) Commodity untilizations
                 5.2.7) Crop residue quantities, nutrient contained, other characteristics and management
                 5.2.8) Feeding rations quantities
                 5.2.9) Manure quantities, nutrients contained, other characteristics and management
                 5.2.10) Fertilizer application: nutrients and other characteristics
                 5.2.11) Import and export quantities
                 5.2.12) Commodities expressed in primary product equivalents
         5.3) Auxiliary parameters
         5.4) Auxiliary variables

$offtext;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*0) Define scenario set

Set Scenarios
/
Baseline, BaselineDerived

FOFA_BAU_2050

"LfP_2050", "AE_exports_2050", "LfS_2050", "AE_food_2050"
"LfP_2030", "AE_exports_2030", "LfS_2030", "AE_food_2030"
"LfP_2012", "AE_exports_2012", "LfS_2012", "AE_food_2012"


Baseline_100Organic
Baseline_50Organic
Baseline_NoFCF

*six main vegan scenarios
FOFA_2050_VeganBAU_NoFreeAreaUse
FOFA_2050_VeganBAU
FOFA_2050_VeganBarbieri
FOFA_2050_VeganBarbieri_a
FOFA_2050_VeganSchmidt
FOFA_2050_VeganOptimized
FOFA_2050_VeganOptimized_conv

****************************************Further vegan scenarios
********Organic vs. Vegan (Barbieri)
********first number: organicShare, second number: veganShare
***************************************************************
FOFA_2050_VeganBarbieri_0_0
FOFA_2050_VeganBarbieri_25_0
FOFA_2050_VeganBarbieri_50_0
FOFA_2050_VeganBarbieri_75_0
FOFA_2050_VeganBarbieri_100_0

FOFA_2050_VeganBarbieri_0_20
FOFA_2050_VeganBarbieri_25_20
FOFA_2050_VeganBarbieri_50_20
FOFA_2050_VeganBarbieri_75_20
FOFA_2050_VeganBarbieri_100_20

FOFA_2050_VeganBarbieri_0_40
FOFA_2050_VeganBarbieri_25_40
FOFA_2050_VeganBarbieri_50_40
FOFA_2050_VeganBarbieri_75_40
FOFA_2050_VeganBarbieri_100_40

FOFA_2050_VeganBarbieri_0_60
FOFA_2050_VeganBarbieri_25_60
FOFA_2050_VeganBarbieri_50_60
FOFA_2050_VeganBarbieri_75_60
FOFA_2050_VeganBarbieri_100_60

FOFA_2050_VeganBarbieri_0_80
FOFA_2050_VeganBarbieri_25_80
FOFA_2050_VeganBarbieri_50_80
FOFA_2050_VeganBarbieri_75_80
FOFA_2050_VeganBarbieri_100_80

FOFA_2050_VeganBarbieri_0_100
FOFA_2050_VeganBarbieri_25_100
FOFA_2050_VeganBarbieri_50_100
FOFA_2050_VeganBarbieri_75_100
FOFA_2050_VeganBarbieri_100_100



*UNISECO agroforestry scenarios:
$ontext;
*they are differentiated by 5 parameters:
         1) %WW% share AF                     -       medium/low/high coded as M/L/H
         2) %XX% compnent shares crops/trees  -       medium/low/high coded as M/L/H
         3) %YY% AF yields                    -       low/high coded as L/H
         4) %CC% C sequestration              -       medium/low/high coded as M/L/H
         5) %RR% organic share outside the EU -       5% / 25% coded as 5/25
$offtext;

UNISECO_AF_shM_compM_yL_cM_5
UNISECO_AF_shL_compM_yL_cM_5
UNISECO_AF_shH_compM_yL_cM_5

UNISECO_AF_shM_compL_yL_cM_5
UNISECO_AF_shL_compL_yL_cM_5
UNISECO_AF_shH_compL_yL_cM_5

UNISECO_AF_shM_compH_yL_cM_5
UNISECO_AF_shL_compH_yL_cM_5
UNISECO_AF_shH_compH_yL_cM_5


UNISECO_AF_shM_compM_yH_cM_5
UNISECO_AF_shL_compM_yH_cM_5
UNISECO_AF_shH_compM_yH_cM_5

UNISECO_AF_shM_compL_yH_cM_5
UNISECO_AF_shL_compL_yH_cM_5
UNISECO_AF_shH_compL_yH_cM_5

UNISECO_AF_shM_compH_yH_cM_5
UNISECO_AF_shL_compH_yH_cM_5
UNISECO_AF_shH_compH_yH_cM_5




UNISECO_AF_shM_compM_yL_cL_5
UNISECO_AF_shL_compM_yL_cL_5
UNISECO_AF_shH_compM_yL_cL_5

UNISECO_AF_shM_compL_yL_cL_5
UNISECO_AF_shL_compL_yL_cL_5
UNISECO_AF_shH_compL_yL_cL_5

UNISECO_AF_shM_compH_yL_cL_5
UNISECO_AF_shL_compH_yL_cL_5
UNISECO_AF_shH_compH_yL_cL_5


UNISECO_AF_shM_compM_yH_cL_5
UNISECO_AF_shL_compM_yH_cL_5
UNISECO_AF_shH_compM_yH_cL_5

UNISECO_AF_shM_compL_yH_cL_5
UNISECO_AF_shL_compL_yH_cL_5
UNISECO_AF_shH_compL_yH_cL_5

UNISECO_AF_shM_compH_yH_cL_5
UNISECO_AF_shL_compH_yH_cL_5
UNISECO_AF_shH_compH_yH_cL_5




UNISECO_AF_shM_compM_yL_cH_5
UNISECO_AF_shL_compM_yL_cH_5
UNISECO_AF_shH_compM_yL_cH_5

UNISECO_AF_shM_compL_yL_cH_5
UNISECO_AF_shL_compL_yL_cH_5
UNISECO_AF_shH_compL_yL_cH_5

UNISECO_AF_shM_compH_yL_cH_5
UNISECO_AF_shL_compH_yL_cH_5
UNISECO_AF_shH_compH_yL_cH_5


UNISECO_AF_shM_compM_yH_cH_5
UNISECO_AF_shL_compM_yH_cH_5
UNISECO_AF_shH_compM_yH_cH_5

UNISECO_AF_shM_compL_yH_cH_5
UNISECO_AF_shL_compL_yH_cH_5
UNISECO_AF_shH_compL_yH_cH_5

UNISECO_AF_shM_compH_yH_cH_5
UNISECO_AF_shL_compH_yH_cH_5
UNISECO_AF_shH_compH_yH_cH_5






UNISECO_AF_shM_compM_yL_cM_25
UNISECO_AF_shL_compM_yL_cM_25
UNISECO_AF_shH_compM_yL_cM_25

UNISECO_AF_shM_compL_yL_cM_25
UNISECO_AF_shL_compL_yL_cM_25
UNISECO_AF_shH_compL_yL_cM_25

UNISECO_AF_shM_compH_yL_cM_25
UNISECO_AF_shL_compH_yL_cM_25
UNISECO_AF_shH_compH_yL_cM_25


UNISECO_AF_shM_compM_yH_cM_25
UNISECO_AF_shL_compM_yH_cM_25
UNISECO_AF_shH_compM_yH_cM_25

UNISECO_AF_shM_compL_yH_cM_25
UNISECO_AF_shL_compL_yH_cM_25
UNISECO_AF_shH_compL_yH_cM_25

UNISECO_AF_shM_compH_yH_cM_25
UNISECO_AF_shL_compH_yH_cM_25
UNISECO_AF_shH_compH_yH_cM_25




UNISECO_AF_shM_compM_yL_cL_25
UNISECO_AF_shL_compM_yL_cL_25
UNISECO_AF_shH_compM_yL_cL_25

UNISECO_AF_shM_compL_yL_cL_25
UNISECO_AF_shL_compL_yL_cL_25
UNISECO_AF_shH_compL_yL_cL_25

UNISECO_AF_shM_compH_yL_cL_25
UNISECO_AF_shL_compH_yL_cL_25
UNISECO_AF_shH_compH_yL_cL_25


UNISECO_AF_shM_compM_yH_cL_25
UNISECO_AF_shL_compM_yH_cL_25
UNISECO_AF_shH_compM_yH_cL_25

UNISECO_AF_shM_compL_yH_cL_25
UNISECO_AF_shL_compL_yH_cL_25
UNISECO_AF_shH_compL_yH_cL_25

UNISECO_AF_shM_compH_yH_cL_25
UNISECO_AF_shL_compH_yH_cL_25
UNISECO_AF_shH_compH_yH_cL_25




UNISECO_AF_shM_compM_yL_cH_25
UNISECO_AF_shL_compM_yL_cH_25
UNISECO_AF_shH_compM_yL_cH_25

UNISECO_AF_shM_compL_yL_cH_25
UNISECO_AF_shL_compL_yL_cH_25
UNISECO_AF_shH_compL_yL_cH_25

UNISECO_AF_shM_compH_yL_cH_25
UNISECO_AF_shL_compH_yL_cH_25
UNISECO_AF_shH_compH_yL_cH_25


UNISECO_AF_shM_compM_yH_cH_25
UNISECO_AF_shL_compM_yH_cH_25
UNISECO_AF_shH_compM_yH_cH_25

UNISECO_AF_shM_compL_yH_cH_25
UNISECO_AF_shL_compL_yH_cH_25
UNISECO_AF_shH_compL_yH_cH_25

UNISECO_AF_shM_compH_yH_cH_25
UNISECO_AF_shL_compH_yH_cH_25
UNISECO_AF_shH_compH_yH_cH_25



*FOFA_BAU_2012,FOFA_BAU_2030,FOFA_BAU_2035,FOFA_BAU_2040,FOFA_BAU_2050
*FOFA_BAU_2050 already listed above to bring it to the fore when results are displayed
FOFA_BAU_2012,FOFA_BAU_2030,FOFA_BAU_2035,FOFA_BAU_2040
FOFA_TSS_2012,FOFA_TSS_2030,FOFA_TSS_2035,FOFA_TSS_2040,FOFA_TSS_2050
FOFA_SSS_2012,FOFA_SSS_2030,FOFA_SSS_2035,FOFA_SSS_2040,FOFA_SSS_2050


FOFA_BAU_2050_NoFCF

FOFA_BAU_2050_25Organic

FOFA_BAU_2050_Test
FOFA_BAU_2050_Test_10PercLessArea


BioeSR15_P4_2005,BioeSR15_P4_2010,BioeSR15_P4_2020,BioeSR15_P4_2030,BioeSR15_P4_2040,BioeSR15_P4_2050,BioeSR15_P4_2060,BioeSR15_P4_2070,BioeSR15_P4_2080,BioeSR15_P4_2090,BioeSR15_P4_2100
BioeSR15_P3_2005,BioeSR15_P3_2010,BioeSR15_P3_2020,BioeSR15_P3_2030,BioeSR15_P3_2040,BioeSR15_P3_2050,BioeSR15_P3_2060,BioeSR15_P3_2070,BioeSR15_P3_2080,BioeSR15_P3_2090,BioeSR15_P3_2100

BioeSR15_P4_2050_RefNoBioe

BioeSR15_P4_2050_Bio
BioeSR15_P4_2050_Bio_AreaIncrease
BioeSR15_P4_2050_Bio_AreaIncr_NoFCF
BioeSR15_P4_2050_Bio_AreaIncr_NoFCF_LessFW

zhaw_NoFeedImports
zhaw_NoFeedImports_a

ELAniVarProd_RCardinaals_1
Bioenergy_RCardinaals_1



/;

Set FOFA2050_Scenarios(Scenarios)
/
FOFA_BAU_2012,FOFA_BAU_2030,FOFA_BAU_2035,FOFA_BAU_2040,FOFA_BAU_2050
FOFA_TSS_2012,FOFA_TSS_2030,FOFA_TSS_2035,FOFA_TSS_2040,FOFA_TSS_2050
FOFA_SSS_2012,FOFA_SSS_2030,FOFA_SSS_2035,FOFA_SSS_2040,FOFA_SSS_2050
/;


Set BioeSR15_Scenarios(Scenarios)
/
BioeSR15_P4_2005,BioeSR15_P4_2010,BioeSR15_P4_2020,BioeSR15_P4_2030,BioeSR15_P4_2040,BioeSR15_P4_2050,BioeSR15_P4_2060,BioeSR15_P4_2070,BioeSR15_P4_2080,BioeSR15_P4_2090,BioeSR15_P4_2100
BioeSR15_P3_2005,BioeSR15_P3_2010,BioeSR15_P3_2020,BioeSR15_P3_2030,BioeSR15_P3_2040,BioeSR15_P3_2050,BioeSR15_P3_2060,BioeSR15_P3_2070,BioeSR15_P3_2080,BioeSR15_P3_2090,BioeSR15_P3_2100
/;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Main parameters

Parameters

*1.1) Activities: input parameters
ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                inputs to the crop and grass activities undertaken on a unit of agricultural land  - UNIT: input per hectare
ActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)                   inputs to the animal activities undertaken to produce animal source food           - UNIT: input per Animal Production Unit
ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios) inputs to the animal activities undertaken to produce animal source food           - UNIT: input per Animal Head
ActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)              inputs to the fish and seafood activities                                          - UNIT: input per ton unprocessed fish or seafood biomass output
ActForest_Inputs_MR(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,Scenarios)                        inputs to the forest activities undertaken on a unit of forest land                - UNIT: input per hectare
ActOthers_Inputs_MR(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,Scenarios)                         inputs to any other activities undertaken                                          - UNIT: to be specified - default: input per ton unprocessed main biomass output

*1.2) Activities: output parameters
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                outputs from the crop and grass activities undertaken on a unit of agricultural land  - UNIT: output per hectare
ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)                   outputs from the animal activities undertaken to produce animal source food           - UNIT: output per Animal Production Unit
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios) outputs from the animal activities undertaken to produce animal source food           - UNIT: output per Animal Head
ActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)              outputs from the fish and seafood activities                                          - UNIT: output per ton unprocessed fish or seafood biomass output
ActForest_Outputs_MR(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,Scenarios)                        outputs from the forest activities undertaken on a unit of forest land                - UNIT: output per hectare
ActOthers_Outputs_MR(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,Scenarios)                         outputs from any other activities undertaken                                          - UNIT: to be specified - default: output per ton unprocessed main biomass output

*1.3) Activities: other characteristics
ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                other characteristics of the crop and grass activities undertaken on a unit of agricultural land  - UNIT: OtherChar per hectare
ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)                   other characteristics of the animal activities undertaken to produce animal source food           - UNIT: OtherChar per Animal Production Unit
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios) other characteristics of the animal activities undertaken to produce animal source food           - UNIT: OtherChar per Animal Head
ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios)              other characteristics of the fish and seafood activities                                          - UNIT: OtherChar per ton unprocessed fish or seafood biomass output
ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios)                        other characteristics of the forest activities undertaken on a unit of forest land                - UNIT: OtherChar per hectare
ActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,Scenarios)                         other characteristics of any other activities undertaken                                          - UNIT: to be specified - default: OtherChar per ton unprocessed main biomass output

*1.4) Commodities: nutrient contents and other characteristics
Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)         nutrient contents of commodities     - UNIT: units nutrient per ton commodity
Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios) other characteristics of commodities - UNIT: OtherChar per ton commodity

*1.5) Commodity tree parameters
Commod_ProductionShare_MR(Regions,Commodities,Commodities_2,ProductionSystems,Scenarios)                production share of different commodities from the same higher level commodity in the commodity tree - UNIT: share (i.e. percentage divided by 100)
Commod_ExtractionRate_MR(Regions,Commodities,Commodities_2,ProductionSystems,Scenarios)                 extraction rate of a commodity from its higher level source commodity                                - UNIT: share (i.e. percentage divided by 100)
*and define a parameter that captures how aggregate commodities are disaggregated into primary activities (e.g. "Bread" comes from "All Cereals" and those have to be disaggregated to "Wheat", "Rye", etc.
*assumptions on this are often very shaky and for now, much is determined by expert quess from Adrian Muller from August 2019 -
*        or where sensible, it is allocated according to the relative shares of single commodities in the aggregate, if this information is available
Commod_SingleInAggregateCommodShares_MR(Regions,Commodities,Commodities_2,ProductionSystems,Scenarios)  Share of single commodities in aggregate commodities - UNIT: share (i.e. percentage divided by 100)

*1.6) Crop residues: nutrient contents, other characteristics and management
CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios)                      nutrient contents of crop residues     - UNIT: units nutrient per ton crop residues
CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios)                    other characteristics of crop residues - UNIT: OtherChar per ton crop residues
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios) values related to crop residues management  - UNIT: units management values per ton crop residues

*1.7) Feeding rations
FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)                            "nutrient contents of feed/Feeding rations     - UNIT: units nutrient per ton feed"
FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios)             "other characteristics of feed/Feeding rations - UNIT: other characteristics per ton feed"
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios)        "other characteristics of feed/Feeding rations - UNIT: other characteristics per animal head"
FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios)           "other characteristics of feed/Feeding rations - UNIT: other characteristics per APU"

*1.8) Manure: nutrient contents, other characteristics and management
Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios)                                  nutrient contents of manure         - UNIT: units nutrient per ton manure
Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios)                                other characteristics of manure     - UNIT: OtherChar per ton manure
Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios) values related to manure management - UNIT: units management values per ton manure

*1.9) Fertilizer application: nutrients and other characteristics
*below: Activities_2 is Livestock plus also aggregates thereof, thereofer the set Livestock is not enough
ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)  "Characteristics of manure application to activities; Livestock/AnimalTypeInHerd captures the source of manure - UNIT: Char per ton manure/nutrient"
CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)         "Characteristics of crop residue and other crop biomass application to activities; commodities captures the source of crop residue (other biomass - UNIT: Characteristics per ton crop res/nutrient"
MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)         "Characteristics of min fert application to activities; MineralFertilizerType captures the source of min fert - UNIT: Char per ton min fert/nutrient"

*1.10) Extraction rates
ExtractionRate_CommodityTree_MR(Regions,Commodities,Scenarios)
;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Main variables

Variables
*2.1) Amount of activity units
VActCropsGrass_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)                   total amount of activity units - UNIT: Number of hectares
VActAnimalsAPU_QuantityActUnits_MR(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)                   total amount of activity units - UNIT: Number of Animal Production Units (APUs)
VActAnimalsHead_QuantityActUnits_MR(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios) total amount of activity units - UNIT: Number of animal heads
VActFishSeafood_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)                  total amount of activity units - UNIT: Tons of unprocessed fish or seafood
VActForest_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)                       total amount of activity units - UNIT: Number of hectares
VActOthers_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)                       total amount of activity units - UNIT: to be specified - default: tons of unprocessed main biomass output

*2.2) Inputs to activities
VActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                total inputs to the crop and grass activities undertaken on agricultural land  - UNIT: total input
VActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)                   total inputs to the animal activities undertaken to produce animal source food - UNIT: total input
VActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios) total inputs to the animal activities undertaken to produce animal source food - UNIT: total input
VActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)              total inputs to the fish and seafood activities                                - UNIT: total input
VActForest_Inputs_MR(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,Scenarios)                        total inputs to the forest activities undertaken on a unit of forest land      - UNIT: total input
VActOthers_Inputs_MR(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,Scenarios)                         total inputs to any other activities undertaken                                - UNIT: total input

*2.3) Outputs from activities
VActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                total outputs from the crop and grass activities undertaken on agricultural land  - UNIT: total output
VActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)                   total outputs from the animal activities undertaken to produce animal source food - UNIT: total output
VActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios) total outputs from the animal activities undertaken to produce animal source food - UNIT: total output
VActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)              total outputs from the fish and seafood activities                                - UNIT: total output
VActForest_Outputs_MR(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,Scenarios)                        total outputs from the forest activities undertaken on a unit of forest land      - UNIT: total output
VActOthers_Outputs_MR(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,Scenarios)                         total outputs from any other activities undertaken                                - UNIT: total output

*2.4) Other characteristics of activities
VActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                total other characteristics of the crop and grass activities undertaken on agricultural land  - UNIT: total OtherChar
VActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)                   total other characteristics of the animal activities undertaken to produce animal source food - UNIT: total OtherChar
VActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios) total other characteristics of the animal activities undertaken to produce animal source food - UNIT: total OtherChar
VActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios)              total other characteristics of the fish and seafood activities                                - UNIT: total OtherChar
VActForest_OtherChar_MR(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios)                        total other characteristics of the forest activities undertaken on a unit of forest land      - UNIT: total OtherChar
VActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,Scenarios)                         total other characteristics of any other activities undertaken                                - UNIT: total OtherChar


*2.5) Commodity quantities, nutrient contained and other characteristics
VCommod_Quantity_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)                  total (domestically available) commodity quantity (DAQ) - UNIT: tons
VCommod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)         total nutrient contents of commodities                  - UNIT: total units nutrient
VCommod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios) total other characteristics of commodities              - UNIT: total units OtherChar

*2.6) Commodity untilizationa
VCommod_Production_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)   total quantity of commodity production          - UNIT: tons
VCommod_StockChanges_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios) total quantity of commodity stock changes       - UNIT: tons
VCommod_Food_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)         total quantity of commodity used for food       - UNIT: tons
VCommod_Feed_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)         total quantity of commodity used for feed       - UNIT: tons
VCommod_Seed_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)         total quantity of commodity used for seed       - UNIT: tons
VCommod_Processing_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)   total quantity of commodity used for processing - UNIT: tons
VCommod_Waste_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)        total quantity of commodity lost or wasted      - UNIT: tons
VCommod_Other_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)        total quantity of commodity used for other uses - UNIT: tons
*for some, we also are interested in contents and other characteristics of these commodity utilizations:
VCommod_Food_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)          total nutrient contents of commodity used for food       - UNIT: total units nutrient
VCommod_Feed_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)          total nutrient contents of commodity used for feed       - UNIT: total units nutrient
VCommod_Waste_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)         total nutrient contents of commodity lost or wasted      - UNIT: total units nutrient
VCommod_Food_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)  total other characteristics of commodity used for food   - UNIT: total units OtherChar
VCommod_Feed_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)  total other characteristics of commodity used for feed   - UNIT: total units OtherChar
VCommod_Waste_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios) total other characteristics of commodity lost or wasted  - UNIT: total units OtherChar

*2.7) Crop residue quantities, nutrient contained, other characteristics and management
VCropResidues_Quantity_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                                      total crop residue quantity                   - UNIT: tons
VCropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios)                      total nutrient contents of crop residues      - UNIT: total units nutrient
VCropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios)                    total other characteristics of crop residues  - UNIT: total units OtherChar
VCropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios) total values related to crop residues management  - UNIT: total units management values

*2.8) Feeding rations quantities
VFeedingRations_Quantity_MR(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,Scenarios)          total quantity of feed - UNIT: tons
VFeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios) total nutrient contents of feed - UNIT: total units nutrient
VFeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios)          "total other characteristics of feed/Feeding rations - UNIT: total other characteristics"

*2.9) Manure quantities, nutrients contained, other characteristics and management
VManure_Quantity_MR(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)                                                 total manure quantity                     - UNIT: tons
VManure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios)                                  total nutrient contents of manure         - UNIT: total units nutrient
VManure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios)                                total other characteristics of manure     - UNIT: total units OtherChar
VManure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios) total values related to manure management - UNIT: total units management values

*2.10) Fertilizer application: nutrients and other characteristics
*below: Activities_2 is Livestock plus also aggregates thereof, thereofer the set Livestock is not enough
VManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios) "Total characteristics of manure application to activities; Livestock/AnimalTypeInHerd captures the source of manure - UNIT: total Char"
VCropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)        "Total characteristics of crop residue and other crop biomass application to activities; commodities captures the source of crop residue (other biomass - UNIT: total Chararcteristic"
VMinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)        "Total characteristics of min fert application to activities; MineralFertilizerType captures the source of min fert - UNIT: total Char"

*2.11) Import and export quantities
VImportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)                          total commodity quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VExportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)                          total commodity quantity EXPORTED from Regions INTO Regions_2 - UNIT: tons
VImportLivingAnimalsHead_MR(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios) total number of live animals IMPORTED into Regions FROM Regions_2 - UNIT: Number of animal heads
VExportLivingAnimalsHead_MR(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios) total number of live animals EXPORTED from Regions INTO Regions_2 - UNIT: Number of animal heads
*for trade in beehives and other animal activities measured in APUs only:
VImportLivingAnimalsAPU_MR(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions,Scenarios)                   total number of live animals IMPORTED into Regions FROM Regions_2 - UNIT: Number of Animal Production Units (APUs)
VExportLivingAnimalsAPU_MR(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions,Scenarios)                   total number of live animals EXPORTED from Regions INTO Regions_2 - UNIT: Number of Animal Production Units (APUs)

VImportQuantity_Feed_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)                     total commodity FEED quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VExportQuantity_Feed_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)                     total commodity FEED quantity EXPORTED into Regions FROM Regions_2 - UNIT: tons

*2.12) Commodities expressed in primary product equivalents
*the following variables are expressed in prim prod equivalents, derived from the corresponding variables that are reported in commodity quantities (cf. definitions above), by means of extraction rates, etc.
*no need to add activity and output dimensions, these informations are captured in the relevant matching sets as defined in _V6_ReadData_CommodityTrees_LinkActivitiesAndCommodities
VPrimProd_Commod_Quantity_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)            total PRIMARY PRODUCT EQUIVALENT commodity quantity                        - UNIT: tons

VPrimProd_Commod_Production_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)          total PRIMARY PRODUCT EQUIVALENT quantity of commodity production          - UNIT: tons
VPrimProd_Commod_StockChanges_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)        total PRIMARY PRODUCT EQUIVALENT quantity of commodity stock changes       - UNIT: tons
VPrimProd_Commod_Food_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for food       - UNIT: tons
VPrimProd_Commod_Feed_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for feed       - UNIT: tons
VPrimProd_Commod_Seed_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for seed       - UNIT: tons
VPrimProd_Commod_Processing_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)          total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for processing - UNIT: tons
VPrimProd_Commod_Waste_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)               total PRIMARY PRODUCT EQUIVALENT quantity of commodity lost or wasted      - UNIT: tons
VPrimProd_Commod_Other_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)               total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for other uses - UNIT: tons

VPrimProd_ImportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)   total PRIMARY PRODUCT EQUIVALENT commodity quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VPrimProd_ExportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)   total PRIMARY PRODUCT EQUIVALENT commodity quantity EXPORTED from Regions INTO Regions_2 - UNIT: tons

VPrimProd_Commod_Quantity_CropActivities_MR(Regions,Commodities,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios) total PRIMARY PRODUCT EQUIVALENT commodity quantity - linked to activities - UNIT: tons
VPrimProd_Commod_Quantity_AnimalActivities_MR(Regions,Commodities,Activities,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)  total PRIMARY PRODUCT EQUIVALENT commodity quantity - linked to activities - UNIT: tons
;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Auxiliary parameters
Parameters
HumanCharacteristics_MR(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities,Scenarios) "any characteristics of humans - such as nutrient requirements, nutrient excretions and others - UNITS: characteristics/inputs/outputs per CAPITA"
*        commodities refer to the source of food, e.g. plant or animal based, but also cereals, oil crops, etc. or even finer on commodity level
SeedContents_MR(Regions,Activities,Contents,ProductionSystems,ProductionConditions,Scenarios) "any characteristics of seeds - such as nutrient and DM contents, etc. - UNITS: per ton seed"
MineralFertilizerCharacteristics_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,ProductionSystems,Scenarios) "any characteristics of mineral fertilizers - such as production emissions, etc. - UNITS: per ton min. fert. nutrient"
GWP_GTP_SOLm_MR(GreenhouseGases,Scenarios) "values for the radiative forcing of GHGs - GWP or GTP - to be set at the beginning and then to be used for all calculations"

;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Auxiliary variables

Variables
VMineralFertilizerQuantity_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios)   "total amount of mineral fertilizers from 'min. fert. production technology', applied on 'production systems' in 'region'  - UNIT: tons N, P2O5, K2O"
VPopulationNumbers_MR(Regions,PopulationGroups,Scenarios) "total population numbers per region - differentiated by population groups, such as male, female, children, etc.    - UNIT: number of people"
VEnergyProduction_MR(Regions,ConversionLevel,EnergyType,EnergySource,EnergyChar,Scenarios)  "total energy related variables - total production and supply, emissions, related CCS, etc.  - UNIT: units total"

VHumanCharacteristics_MR(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities,ProductionSystems,ProductionConditions,Scenarios) "TOTAL amount of any characteristics of humans - such as nutrient requirements, nutrient excretions and others - UNITS: total characteristics/inputs/outputs"
*ProductionSystems above are needed, as some characteristics refer to N/P inputs to agriculture (from human faeces) which thus needs to be allocated to different systems...

AUX_Inverse_VActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)  an auxiliary variable - the INVERSE of the total outputs from the crop and grass activities undertaken on agricultural land  - UNIT: 1 divided by total output
;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) Initialise par/var for model runs with baseline values

*5.1) Main parameters
ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = ActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*         = ActAnimalsAPU_Inputs(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_Inputs(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
*         = ActFishSeafood_Inputs(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions);
ActForest_Inputs_MR(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,"Baseline")
         = ActForest_Inputs(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActOthers_Inputs_MR(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,"Baseline")
*         = ActOthers_Inputs(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions);

*5.1.2) Activities: output parameters
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = ActCropsGrass_Outputs(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions);
ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsAPU_Outputs(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_Outputs(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
*         = ActFishSeafood_Outputs(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActForest_Outputs_MR(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,"Baseline")
*         = ActForest_Outputs(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActOthers_Outputs_MR(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,"Baseline")
*         = ActOthers_Outputs(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions);

*5.1.3) Activities: other characteristics
ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = ActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"Baseline")
*         = ActAnimalsAPU_OtherChar(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
*         = ActFishSeafood_OtherChar(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,"Baseline")
*         = ActForest_OtherChar(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,"Baseline")
*         = ActOthers_OtherChar(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions);

*5.1.4) Commodities: nutrient contents and other characteristics
Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline")
         = Commod_Contents(Regions,Commodities,Contents,ProductionSystems,ProductionConditions);
Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = Commod_OtherChar(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions);

*5.1.5) Commodity tree parameters
*the following is yet empty
*Commod_ProductionShare_MR(Regions,Commodities,Commodities_2,ProductionSystems,"Baseline")
*         = Commod_ProductionShare(Regions,Commodities,Commodities_2,ProductionSystems);
*the following is yet empty
*Commod_ExtractionRate_MR(Regions,Commodities,Commodities_2,ProductionSystems,"Baseline")
*         = Commod_ExtractionRate(Regions,Commodities,Commodities_2,ProductionSystems);
*the following is yet empty
*Commod_SingleInAggregateCommodShares_MR(Regions,Commodities,Commodities_2,ProductionSystems,"Baseline")
*         = Commod_SingleInAggregateCommodShares(Regions,Commodities,Commodities_2,ProductionSystems);

*5.1.6) Crop residues: nutrient contents, other characteristics and management
CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"Baseline")
         = CropResidues_Contents(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions);
CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = CropResidues_OtherChar(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions);
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline")
         = CropResidues_Management(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions);

*5.1.7) Feeding rations
*the following is yet empty
*FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline")
*         = FeedingRations_Contents(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions);
FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = FeedingRations_OtherChar(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions);
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = FeedingRationsHeads_OtherChar(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions);

*5.1.8) Manure: nutrient contents, other characteristics and management
*the following is yet empty
*Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,"Baseline")
*         = Manure_Contents(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions);
Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = Manure_OtherChar(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions);
Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,"Baseline")
         = Manure_Management(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions);

*5.1.9) Fertilizer application: nutrients and other characteristics
ManureApplication_MR(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
         = ManureApplication(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions);
CropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
         = CropResAndBiomassApplication(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions);
MinFertApplication_MR(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
         = MinFertApplication(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions);

*5.1.10) Extraction rates
ExtractionRate_CommodityTree_MR(Regions,Commodities,"Baseline")
         = ExtractionRate_CommodityTree(Regions,Commodities);


*5.2) Main variables
*5.2.1) Amount of activity units
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_QuantityActUnits.l(Regions,Activities,ProductionSystems,ProductionConditions);
VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsAPU_QuantityActUnits.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions);
VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsHead_QuantityActUnits.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions);
*VActFishSeafood_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline")
*         = VActFishSeafood_QuantityActUnits.l(Regions,Activities,ProductionSystems,ProductionConditions);
VActForest_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline")
         = VActForest_QuantityActUnits.l(Regions,Activities,ProductionSystems,ProductionConditions);
*VActOthers_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline")
*         = VActOthers_QuantityActUnits.l(Regions,Activities,ProductionSystems,ProductionConditions);

*5.2.2) Inputs to activities
VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_Inputs.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
*VActAnimalsAPU_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*         = VActAnimalsAPU_Inputs.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
*VActAnimalsHead_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
*         = VActAnimalsHead_Inputs.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
*VActFishSeafood_Inputs_MR.l(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
*         = VActFishSeafood_Inputs.l(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions);
*VActForest_Inputs_MR.l(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,"Baseline")
*         = VActForest_Inputs.l(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions);
*VActOthers_Inputs_MR.l(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,"Baseline")
*         = VActOthers_Inputs.l(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions);

*5.2.3) Outputs from activities
VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions);
VActAnimalsAPU_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsAPU_Outputs.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsHead_Outputs.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
*VActFishSeafood_Outputs_MR.l(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
*         = VActFishSeafood_Outputs.l(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions);
*VActForest_Outputs_MR.l(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,"Baseline")
*         = VActForest_Outputs.l(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions);
*VActOthers_Outputs_MR.l(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,"Baseline")
*         = VActOthers_Outputs.l(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions);

*5.2.4) Other characteristics of activities
*VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         = VActCropsGrass_OtherChar.l(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
*VActAnimalsAPU_OtherChar_MR.l(Regions,Activities,OtherCharAnimals,ProductionSystems,ProductionConditions,"Baseline")
*         = VActAnimalsAPU_OtherChar.l(Regions,Activities,OtherCharAnimals,ProductionSystems,ProductionConditions);
*VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"Baseline")
*         = VActAnimalsHead_OtherChar.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions);
*VActFishSeafood_OtherChar_MR.l(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
*         = VActFishSeafood_OtherChar.l(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions);
*VActForest_OtherChar_MR.l(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,"Baseline")
*         = VActForest_OtherChar.l(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions);
*VActOthers_OtherChar_MR.l(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,"Baseline")
*         = VActOthers_OtherChar.l(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions);


*5.2.5) Commodity quantities, nutrient contained and other characteristics
VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Quantity.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*VCommod_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_Contents.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions);
*VCommod_OtherChar_MR.l(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_OtherChar.l(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions);

*5.2.6) Commodity untilizationa
VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Production.l(Regions,Commodities,ProductionSystems,ProductionConditions);
VCommod_StockChanges_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_StockChanges.l(Regions,Commodities,ProductionSystems,ProductionConditions);
VCommod_Food_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Food.l(Regions,Commodities,ProductionSystems,ProductionConditions);
VCommod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Feed.l(Regions,Commodities,ProductionSystems,ProductionConditions);
VCommod_Seed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Seed.l(Regions,Commodities,ProductionSystems,ProductionConditions);
VCommod_Processing_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Processing.l(Regions,Commodities,ProductionSystems,ProductionConditions);
VCommod_Waste_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Waste.l(Regions,Commodities,ProductionSystems,ProductionConditions);
VCommod_Other_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Other.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*for some, we also are interested in contents and other characteristics of these commodity utilizations:
*VCommod_Food_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_Food_Contents(Regions,Commodities,Contents,ProductionSystems,ProductionConditions);
*VCommod_Food_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_Food_Contents(Regions,Commodities,Contents,ProductionSystems,ProductionConditions);
*VCommod_Waste_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_Waste_Contents(Regions,Commodities,Contents,ProductionSystems,ProductionConditions);
*VCommod_Food_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_Food_OtherChar(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions);
*VCommod_Feed_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_Feed_OtherChar(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions);
*VCommod_Waste_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"Baseline")
*         = VCommod_Waste_OtherChar(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions);

*5.2.7) Crop residue quantities, nutrient contained, other characteristics and management
*VCropResidues_Quantity_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
*         = VCropResidues_Quantity.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions);
*VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"Baseline")
*         = VCropResidues_Contents.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions);
*VCropResidues_OtherChar_MR.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"Baseline")
*         = VCropResidues_OtherChar.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions);
*VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline")
*         = VCropResidues_Management.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions);

*5.2.8) Feeding rations quantities
*VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VFeedingRations_Quantity.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions);
*VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline")
*         = VFeedingRations_Contents.l(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions);
*VFeedingRations_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"Baseline")
*         = VFeedingRations_OtherChar.l(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions);

*5.2.9) Manure quantities, nutrients contained, other characteristics and management
*VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
*         = VManure_Quantity.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions);
*VManure_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,"Baseline")
*         = VManure_Contents.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions);
*VManure_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,"Baseline")
*         = VManure_OtherChar.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions);
*VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,"Baseline")
*         = VManure_Management.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions);

*5.2.10) Fertilizer application: nutrients and other characteristics
*VManureApplication_MR.l(Regions,Activities,Livestock,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
*         = VManureApplication.l(Regions,Activities,Livestock,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions);
*VCropResAndBiomassApplication_MR.l(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
*         = VCropResAndBiomassApplication.l(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions);
*VMinFertApplication_MR.l(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
*         = VMinFertApplication.l(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions);

*5.2.11) Import and export quantities
VImportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VImportQuantity.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions);
VExportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VExportQuantity.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions);
VImportLivingAnimalsHead_MR.l(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
         = VImportLivingAnimalsHead.l(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions);
VExportLivingAnimalsHead_MR.l(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
         = VExportLivingAnimalsHead.l(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions);
VImportLivingAnimalsAPU_MR.l(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions,"Baseline")
         = VImportLivingAnimalsAPU.l(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions);
VExportLivingAnimalsAPU_MR.l(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions,"Baseline")
         = VExportLivingAnimalsAPU.l(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions);

VImportQuantity_Feed_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VImportQuantity_Feed.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions);
*VExportQuantity_Feed_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VExportQuantity_Feed.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions);

*5.2.12) Commodities expressed in primary product equivalents
VPrimProd_Commod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_Commod_Quantity.l(Regions,Commodities,ProductionSystems,ProductionConditions);

*VPrimProd_Commod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VPrimProd_Commod_Production.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*VPrimProd_Commod_StockChanges_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VPrimProd_Commod_StockChanges.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*VPrimProd_Commod_Food_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VPrimProd_Commod_Food.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*VPrimProd_Commod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VPrimProd_Commod_Feed.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*VPrimProd_Commod_Seed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VPrimProd_Commod_Seed.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*VPrimProd_Commod_Processing_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VPrimProd_Commod_Processing.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*VPrimProd_Commod_Waste_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VPrimProd_Commod_Waste.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*VPrimProd_Commod_Other_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VPrimProd_Commod_Other.l(Regions,Commodities,ProductionSystems,ProductionConditions);

*VPrimProd_ImportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VPrimProd_ImportQuantity.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions);
*VPrimProd_ExportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,"Baseline")
*         = VPrimProd_ExportQuantity.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions);

VPrimProd_Commod_Quantity_CropActivities_MR.l(Regions,Commodities,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_Commod_Quantity_CropActivities.l(Regions,Commodities,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions);
VPrimProd_Commod_Quantity_AnimalActivities_MR.l(Regions,Commodities,Activities,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_Commod_Quantity_AnimalActivities.l(Regions,Commodities,Activities,OutputsAnimals,ProductionSystems,ProductionConditions);

*5.3) Auxiliary parameters
HumanCharacteristics_MR(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities,"Baseline")
         = HumanCharacteristics(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities);
SeedContents_MR(Regions,Activities,Contents,ProductionSystems,ProductionConditions,"Baseline")
         = SeedContents(Regions,Activities,Contents,ProductionSystems,ProductionConditions);
MineralFertilizerCharacteristics_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,ProductionSystems,"Baseline")
         = MineralFertilizerCharacteristics(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,ProductionSystems);
GWP_GTP_SOLm_MR(GreenhouseGases,"Baseline")
         = GWP_GTP_SOLm(GreenhouseGases);


*5.4) Auxiliary variables
VMineralFertilizerQuantity_MR.l(Regions,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,"Baseline")
         = VMineralFertilizerQuantity.l(Regions,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems);
VPopulationNumbers_MR.l(Regions,PopulationGroups,"Baseline")
         = VPopulationNumbers.l(Regions,PopulationGroups);
*no assignment for the following needed, as no baseline values for this available
*VEnergyProduction_MR(Regions,ConversionLevel,EnergyType,EnergySource,EnergyChar,Scenarios)



