PUTCLOSE con,"_V6_VariablesAndParameters_ModelRun_ForSteeringFile2";

$ontext;
GENERAL DESCRIPTION
This file declares the parameters and variables for the model runs - for steering file 2.
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
         1.10) Extraction rates
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
         5.0) Read BioeSR15 and FOFA2050 data
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
                 5.1.10) Extraction rates
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
- 6) Sets and parameters for the footprint calculations
         6.1) from _V6_DerivePerPrimaryProductImpacts
         6.2) from _V6_DerivePerCommodityImpacts


$offtext;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*0) Define scenario set

$ontext;
*currently, the following sets are loaded from SteeringFile1, to be enhanced here as needed
Set Scenarios
Set FOFA2050_Scenarios(Scenarios)
Set BioeSR15_Scenarios(Scenarios)
$offtext;

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
ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)                other characteristics of the crop and grass activities undertaken on a unit of agricultural land  - UNIT: OtherChar per hectare or ton etc.
ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)                   other characteristics of the animal activities undertaken to produce animal source food           - UNIT: OtherChar per Animal Production Unit
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios) other characteristics of the animal activities undertaken to produce animal source food           - UNIT: OtherChar per Animal Head
ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios)              other characteristics of the fish and seafood activities                                          - UNIT: OtherChar per ton unprocessed fish or seafood biomass output
ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios)                        other characteristics of the forest activities undertaken on a unit of forest land                - UNIT: OtherChar per hectare or ton etc.
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
FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)                         "nutrient contents of feed/Feeding rations     - UNIT: units nutrient per ton feed"
FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios)          "other characteristics of feed/Feeding rations - UNIT: other characteristics per ton feed"
FeedingRationsHeads_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)                    "nutrient contents of feed/Feeding rations     - UNIT: units nutrient per animal head"
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios)     "other characteristics of feed/Feeding rations - UNIT: other characteristics per animal head"
FeedingRationsAPU_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)                      "nutrient contents of feed/Feeding rations     - UNIT: units nutrient per APU"

*1.8) Manure: nutrient contents, other characteristics and management
Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios)                                  nutrient contents of manure         - UNIT: units nutrient per ton manure
Manure_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios)                                other characteristics of manure     - UNIT: OtherChar per ton manure
Manure_Management_MR(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios) values related to manure management - UNIT: units management values per t manure TS DM if not indicated otherwise

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
VCommod_Quantity_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)                  total commodity quantity                   - UNIT: tons
VCommod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)         total nutrient contents of commodities     - UNIT: total units nutrient
VCommod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios) total other characteristics of commodities - UNIT: total units OtherChar

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


AUX_VCommod_Feed_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)          AUXILIARY variable - used to fasten some divisions - total nutrient contents of commodity used for feed       - UNIT: total units nutrient

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
VCropResAndBiomassApplication_MR(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)        "Total characteristics of crop residue and other crop biomass application to activities; commodities captures the source of crop residue (other biomass - UNIT: total Characteristic"
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
VExportQuantity_Feed_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)                     total commodity FEED quantity EXPORTED from Regions INTO Regions_2 - UNIT: tons

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


AUX_FeedSupplyFactor_BioeSR15_MR(Regions,Scenarios) auxiliary parameter capturing the total feed demand in the BioeSR15 scenario P4
AUX_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios) auxiliary parameter for some calculatiosn related to other characteristics of the animal activities"


ImportScaleFactor_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) "An auxiliary parameter used to scale import values in the calculations of imports to reflect changed scenario assumptions on imports with respect to the default baseline values (replicates the default if set equal to 1)"
ExportScaleFactor_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) "An auxiliary parameter used to scale export values in the calculations of exports to reflect changed scenario assumptions on exports with respect to the default baseline values (replicates the default if set equal to 1)"

;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Auxiliary variables

Variables
VMineralFertilizerQuantity_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios)   "total amount of mineral fertilizers from 'min. fert. production technology', applied on 'production systems' in 'region'  - UNIT: tons N, P2O5, K2O"
VPopulationNumbers_MR(Regions,PopulationGroups,Scenarios)   "total population numbers per region - differentiated by population groups, such as male, female, children, etc.    - UNIT: number of people"
VEnergyProduction_MR(Regions,ConversionLevel,EnergyType,EnergySource,EnergyChar,Scenarios)  "total energy related variables - total production and supply, emissions, related CCS, etc.  - UNIT: units total"

VHumanCharacteristics_MR(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities,ProductionSystems,ProductionConditions,Scenarios) "TOTAL amount of any characteristics of humans - such as nutrient requirements, nutrient excretions and others - UNITS: total characteristics/inputs/outputs"
*ProductionSystems above are needed, as some characteristics refer to N/P inputs to agriculture (from human faeces) which thus needs to be allocated to different systems...

AUX_Inverse_VActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)  an auxiliary variable - the INVERSE of the total outputs from the crop and grass activities undertaken on agricultural land - UNIT: 1 divided by total output
AUX_Inverse_VActCropsGrass_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)           an auxiliary variable - the INVERSE of the total amount of activity units - UNIT: 1 divided by Number of hectares
AUX_Inverse_VActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)  an auxiliary variable - the INVERSE of the total outputs from the animal activities undertaken  - UNIT: 1 divided by total output
AUX_VCommod_Production_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)   "An auxiliary version of total quantity of commodity production - used in the DAQ etc. calculations          - UNIT: tons"
AUX_Inverse_VCommod_Quantity_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)  an auxiliary variable - the INVERSE of DAQ  - UNIT: 1 divided by quantity

AUX_Inverse_VExportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) another auxiliary variable for the DAQ and trade calculations
AUX_Inverse_VExportQuantity_NotFromCountry_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) yet another auxiliary variable for the DAQ and trade calculations
AUX_Inverse_VImportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) another auxiliary variable for the DAQ and trade calculations
AUX_BaselineProdLargerThanExports_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) another auxiliary variable for the DAQ and trade calculations

AUX_ProdPlusImport_VCommod_Production_MR(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios) a further auxiliary variable used for the DAQ calculations - sum of imports and production of certain commodities

AUX_Inverse_VFeedingRations_Quantity_MR(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,Scenarios)          an auxiliary variable - the INVERSE of the total quantity of feed - UNIT: tons

*Some variables to fasten the code
VImportStorageAUX_VImportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) AUXILIARY variable for fastening the code: total crop commodity quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VExportStorageAUX_VExportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) AUXILIARY variable for fastening the code: total crop commodity quantity EXPORTED from Regions INTO Regions_2 - UNIT: tons

*and for animal commodities:
VImportStorageAUX2_VImportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) AUXILIARY variable for fastening the code: total animal commodity quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VExportStorageAUX2_VExportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios) AUXILIARY variable for fastening the code: total animal commodity quantity EXPORTED from Regions INTO Regions_2 - UNIT: tons

*and some further auxiliary variables are needed to avoid corrupting some calculations when calculating some intermediate values of interest:
*problems arise, as this is used to calculate world imports and exports, but in the course of this commodities get summed to world level that have been available on a dyadic single country level only before - this corrupts calculations in SOLm that largely rely on imports/exports from/to WORLD
AUX_VImportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)   AUXILIARY variable allowing to calculate some intermediate values of interest without corrupting other code
AUX_VExportQuantity_MR(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios)   AUXILIARY variable allowing to calculate some intermediate values of interest without corrupting other code

*some further auxiliary variable used in some feed calculations:
AUX_VCommod_Feed_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)   AUXILIARY variable used to store some intermediate value in some feed calculations

;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) Initialise par/var for model runs with baseline values
*5.0) Read BioeSR15 and FOFA2050 data
*this is captured in _MR par's and var's, hence done here

$GDXIN FOFA2050_BioeSR15_Etc_Data_InModelRunEntities.gdx
$load ActCropsGrass_Outputs_MR
$load ActAnimalsHead_Outputs_MR
$load ActCropsGrass_OtherChar_MR
$load VActCropsGrass_QuantityActUnits_MR
$load VActCropsGrass_Outputs_MR
$load VActCropsGrass_Inputs_MR
$load VActAnimalsHead_QuantityActUnits_MR
$load VActForest_QuantityActUnits_MR
$load VPopulationNumbers_MR
$load HumanCharacteristics_MR
$load VEnergyProduction_MR
$load VCropResidues_Quantity_MR
$load CropResidues_Management_MR
$load ActForest_OtherChar_MR
$load Commod_OtherChar_MR
$load FeedingRationsHeads_OtherChar_MR

$load AUX_FeedSupplyFactor_BioeSR15_MR
$GDXIN FOFA2050_BioeSR15_Etc_Data_InModelRunEntities.gdx


*in the following, assign Baseline values to the model run parameters
*5.1) Main parameters
ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = ActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
*the following is yet empty
ActAnimalsAPU_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsAPU_Inputs(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_Inputs(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
ActFishSeafood_Inputs_MR(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
         = ActFishSeafood_Inputs(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions);
ActForest_Inputs_MR(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,"Baseline")
         = ActForest_Inputs(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions);
*the following is yet empty
ActOthers_Inputs_MR(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,"Baseline")
         = ActOthers_Inputs(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions);

*5.1.2) Activities: output parameters
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = ActCropsGrass_Outputs(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions);
ActAnimalsAPU_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsAPU_Outputs(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_Outputs_MR(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_Outputs(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
ActFishSeafood_Outputs_MR(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
         = ActFishSeafood_Outputs(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions);
*the following is yet empty
ActForest_Outputs_MR(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,"Baseline")
         = ActForest_Outputs(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions);
*the following is yet empty
ActOthers_Outputs_MR(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,"Baseline")
         = ActOthers_Outputs(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions);

*5.1.3) Activities: other characteristics
ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = ActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
*NOT YET INITIALISED
ActAnimalsAPU_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsAPU_OtherChar(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
ActFishSeafood_OtherChar_MR(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
         = ActFishSeafood_OtherChar(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions);
*the following is yet empty
ActForest_OtherChar_MR(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,"Baseline")
         = ActForest_OtherChar(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions);
*the following is yet empty
ActOthers_OtherChar_MR(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,"Baseline")
         = ActOthers_OtherChar(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions);

*5.1.4) Commodities: nutrient contents and other characteristics
Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline")
         = Commod_Contents(Regions,Commodities,Contents,ProductionSystems,ProductionConditions);
Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = Commod_OtherChar(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions);

*5.1.5) Commodity tree parameters
*the following is yet empty
Commod_ProductionShare_MR(Regions,Commodities,Commodities_2,ProductionSystems,"Baseline")
         = Commod_ProductionShare(Regions,Commodities,Commodities_2,ProductionSystems);
*the following is yet empty
Commod_ExtractionRate_MR(Regions,Commodities,Commodities_2,ProductionSystems,"Baseline")
         = Commod_ExtractionRate(Regions,Commodities,Commodities_2,ProductionSystems);
*the following is yet empty
Commod_SingleInAggregateCommodShares_MR(Regions,Commodities,Commodities_2,ProductionSystems,"Baseline")
         = Commod_SingleInAggregateCommodShares(Regions,Commodities,Commodities_2,ProductionSystems);

*5.1.6) Crop residues: nutrient contents, other characteristics and management
CropResidues_Contents_MR(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"Baseline")
         = CropResidues_Contents(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions);
CropResidues_OtherChar_MR(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = CropResidues_OtherChar(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions);
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline")
         = CropResidues_Management(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions);

*5.1.7) Feeding rations
*the following is yet empty
FeedingRations_Contents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline")
         = FeedingRations_Contents(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions);
FeedingRations_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = FeedingRations_OtherChar(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions);
FeedingRationsHeads_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = FeedingRationsHeads_OtherChar(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions);

*5.1.8) Manure: nutrient contents, other characteristics and management
*the following is yet empty
Manure_Contents_MR(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,"Baseline")
         = Manure_Contents(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions);
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
*the following is yet empty
VActFishSeafood_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline")
         = VActFishSeafood_QuantityActUnits.l(Regions,Activities,ProductionSystems,ProductionConditions);
VActForest_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline")
         = VActForest_QuantityActUnits.l(Regions,Activities,ProductionSystems,ProductionConditions);
*the following is yet empty
VActOthers_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,"Baseline")
         = VActOthers_QuantityActUnits.l(Regions,Activities,ProductionSystems,ProductionConditions);

*5.2.2) Inputs to activities
VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_Inputs.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
*the following is yet empty
VActAnimalsAPU_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsAPU_Inputs.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
VActAnimalsHead_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsHead_Inputs.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
VActFishSeafood_Inputs_MR.l(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
         = VActFishSeafood_Inputs.l(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions);
*the following is yet empty
VActForest_Inputs_MR.l(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,"Baseline")
         = VActForest_Inputs.l(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions);
*the following is yet empty
VActOthers_Inputs_MR.l(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,"Baseline")
         = VActOthers_Inputs.l(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions);

*5.2.3) Outputs from activities
VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_Outputs.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions);
VActAnimalsAPU_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsAPU_Outputs.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsHead_Outputs.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
VActFishSeafood_Outputs_MR.l(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
         = VActFishSeafood_Outputs.l(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions);
*the following is yet empty
VActForest_Outputs_MR.l(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,"Baseline")
         = VActForest_Outputs.l(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions);
*the following is yet empty
VActOthers_Outputs_MR.l(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,"Baseline")
         = VActOthers_Outputs.l(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions);

*5.2.4) Other characteristics of activities
*the following is yet empty
VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = VActCropsGrass_OtherChar.l(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
*the following is yet empty
VActAnimalsAPU_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsAPU_OtherChar.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,"Baseline")
         = VActAnimalsHead_OtherChar.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
VActFishSeafood_OtherChar_MR.l(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,"Baseline")
         = VActFishSeafood_OtherChar.l(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions);
*the following is yet empty
VActForest_OtherChar_MR.l(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,"Baseline")
         = VActForest_OtherChar.l(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions);
*the following is yet empty
VActOthers_OtherChar_MR.l(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,"Baseline")
         = VActOthers_OtherChar.l(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions);


*5.2.5) Commodity quantities, nutrient contained and other characteristics
VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Quantity.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*the following is yet empty
VCommod_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_Contents.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions);
*the following is yet empty
VCommod_OtherChar_MR.l(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = VCommod_OtherChar.l(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions);

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

*5.2.7) Crop residue quantities, nutrient contained, other characteristics and management
*the following is yet empty
VCropResidues_Quantity_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,"Baseline")
         = VCropResidues_Quantity.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions);
*the following is yet empty
VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,"Baseline")
         = VCropResidues_Contents.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions);
*the following is yet empty
VCropResidues_OtherChar_MR.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = VCropResidues_OtherChar.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions);
*the following is yet empty
VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,"Baseline")
         = VCropResidues_Management.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions);

*5.2.8) Feeding rations quantities
*the following is yet empty
VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VFeedingRations_Quantity.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions);
*the following is yet empty
VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,"Baseline")
         = VFeedingRations_Contents.l(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions);
*the following is yet empty
VFeedingRations_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = VFeedingRations_OtherChar.l(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions);

*5.2.9) Manure quantities, nutrients contained, other characteristics and management
*the following is yet empty
VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,"Baseline")
         = VManure_Quantity.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions);
*the following is yet empty
VManure_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,"Baseline")
         = VManure_Contents.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions);
*the following is yet empty
VManure_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,"Baseline")
         = VManure_OtherChar.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions);
*the following is yet empty
VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,"Baseline")
         = VManure_Management.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions);

*5.2.10) Fertilizer application: nutrients and other characteristics
*the following is yet empty
VManureApplication_MR.l(Regions,Activities,Livestock,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
         = VManureApplication.l(Regions,Activities,Livestock,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions);
*the following is yet empty
VCropResAndBiomassApplication_MR.l(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
         = VCropResAndBiomassApplication.l(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions);
*the following is yet empty
VMinFertApplication_MR.l(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,"Baseline")
         = VMinFertApplication.l(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions);

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

*the following is yet empty
VPrimProd_Commod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_Commod_Production.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*the following is yet empty
VPrimProd_Commod_StockChanges_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_Commod_StockChanges.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*the following is yet empty
VPrimProd_Commod_Food_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_Commod_Food.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*the following is yet empty
VPrimProd_Commod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_Commod_Feed.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*the following is yet empty
VPrimProd_Commod_Seed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_Commod_Seed.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*the following is yet empty
VPrimProd_Commod_Processing_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_Commod_Processing.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*the following is yet empty
VPrimProd_Commod_Waste_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_Commod_Waste.l(Regions,Commodities,ProductionSystems,ProductionConditions);
*the following is yet empty
VPrimProd_Commod_Other_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_Commod_Other.l(Regions,Commodities,ProductionSystems,ProductionConditions);

*the following is yet empty
VPrimProd_ImportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_ImportQuantity.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions);
*the following is yet empty
VPrimProd_ExportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions,"Baseline")
         = VPrimProd_ExportQuantity.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions);

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


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) Sets and parameters for the footprint calculations
*Here, some new sets and parameters are defined which are needed in the footprint calculations

*6.1) from _V6_DerivePerPrimaryProductImpacts
*Originally, they have been specified in _V6_DerivePerPrimaryProductImpacts only, but later, the option was added to switch the footprint calculations on or off to safe calculation time -
*but some of these sets are also used elsewhere, hence the relocation of their definition into this file.

Set PerCommodImpact  collects the per activity inputs outputs and other char in one set on per commodity level - unit per ton commodity
/
*from SET InputsCropsGrass
"Land use (ha)"
"Cropland use (ha)"
"Grassland use (ha)"

"Seeds (t)"
"Irrigation water (m3)"
"N fixation (tN)"
"N deposition (tN)"

*biomass covers crop residues and other biomass such as food waste, etc.
"N from CropRes/biomass as fert (tN)"
"N from mineral fert (tN)"
"N from manure as fert (tN)"
"N from all fertilizers (tN)"

"P from CropRes/biomass as fert (tP2O5)"
"P from mineral fert (tP2O5)"
"P from manure as fert (tP2O5)"
"P from all fertilizers (tP2O5)"

"Total CED (MJ)"
"Total GWP from CED (tCO2e)"

*from SET OutputsCropsGrass
"CH4 flooded rice (tCH4)"
"CH4 flooded rice (tCO2e)"

"Direct N2O from mineral fert N applic (tN2O)"
"Direct N2O from CropRes/biomass as fert N applic (tN2O)"
"Direct N2O from manure as fert N applic (tN2O)"

"Direct N2O from mineral fert N applic (tCO2e)"
"Direct N2O from CropRes/biomass as fert N applic (tCO2e)"
"Direct N2O from manure as fert N applic (tCO2e)"

"Direct N loss from mineral fert N applic (tN)"
"Direct N loss from CropRes/biomass as fert N applic (tN)"
"Direct N loss from manure as fert N applic (tN)"

"N2O volat from mineral fert N applic (tN2O)"
"N2O volat from CropRes/biomass as fert N applic (tN2O)"
"N2O volat from manure as fert N applic (tN2O)"

"N2O volat from mineral fert N applic (tCO2e)"
"N2O volat from CropRes/biomass as fert N applic (tCO2e)"
"N2O volat from manure as fert N applic (tCO2e)"

"NH3 from mineral fert N applic (tNH3)"
"NH3 from CropRes/biomass as fert N applic (tNH3)"
"NH3 from manure as fert N applic (tNH3)"

"N2O leach from mineral fert N applic (tN2O)"
"N2O leach from CropRes/biomass as fert N applic (tN2O)"
"N2O leach from manure as fert N applic (tN2O)"

"N2O leach from mineral fert N applic (tCO2e)"
"N2O leach from CropRes/biomass as fert N applic (tCO2e)"
"N2O leach from manure as fert N applic (tCO2e)"

"N volat from mineral fert N applic (tN)"
"N volat from CropRes/biomass as fert N applic (tN)"
"N volat from manure as fert N applic (tN)"

"N leach from mineral fert N applic (tN)"
"N leach from CropRes/biomass as fert N applic (tN)"
"N leach from manure as fert N applic (tN)"

"NH3 from soils (tNH3)"

"NOx from fert applic (tNOx)"

*from SET OtherCharCropsGrass
*the next two are needed for N balances, not directly as impacts
"N in MainOutput1 (tN)"
"N in residues - per ton MainOutput1 (tN)"

"Deforestation (ha)"
"Deforest GHG emissions (tCO2e)"

"CultOrgSoils (ha)"
"CultOrgSoils GHG emissions (tCO2e)"
"CultOrgSoils C emissions (tCO2e)"
"CultOrgSoils N2O emissions (tCO2e)"

"LandDegradation (index)"
"Soil water erosion (t soil lost)"
"Soil wind erosion (t soil lost)"

"Aggreg. Pest. use level (index)"

*from SET InputsAnimals
*noting additional (CED and GWP from CED are already covered under InputsCrops)

*from SET OutputsAnimals
"Enteric ferment (t CH4)"
"Enteric ferment (t CO2e)"

"N in manure (tN)"
"P in manure (tP2O5)"
"VS DM in manure (tVS)"
"TS DM in manure (tTS)"

"Manure man CH4 (tCH4)"
"Manure man CH4 (tCO2e)"
"Manure man N2O dir (tN2O)"
"Manure man N2O dir (tCO2e)"
"Manure man N in N2O dir (tN)"
"Manure man N2O volat (tN2O)"
"Manure man N2O volat (tCO2e)"
"Manure man N volat (tN)"
"Manure man N2O leach (tN2O)"
"Manure man N2O leach (tCO2e)"
"Manure man N leach (tN)"
"Housing NH3 from manure (tN)"
"Manure man N2O total (tN2O)"
"Manure man N2O total (tCO2e)"
"Manure man N total loss (tN)"
"Manure man+housing N total loss (tN)"
"Manure man P total loss (tP2O5)"
"Manure man GHG total (tCO2e)"

"Manure man NH3 (tNH3)"

"Manure N for crop areas (tN)"
"Manure N for grass areas (tN)"

"Manure P for crop areas (tP2O5)"
"Manure P for grass areas (tP2O5)"

"Grazing N2O dir (tN2O)"
"Grazing N2O dir (tCO2e)"
"Grazing N in N2O dir (tN)"
"Grazing N2O volat (tN2O)"
"Grazing N2O volat (tCO2e)"
"Grazing N volat (tN)"
"Grazing NH3 (tNH3)"
"Grazing N2O leach (tN2O)"
"Grazing N2O leach (tCO2e)"
"Grazing N leach (tN)"
"Grazing-Housing NH3 from manure (tNH3)"
"Grazing-Housing NH3 from manure (tN)"
"NH3 from animals, - grazing + housing (tNH3)"
"Grazing N2O total (tCO2e)"
"Grazing N total loss (tN)"
"Grazing+Grazing-housing N total loss (tN)"

*from SET OtherCharAnimals
*NONE

*new elements for aggregations:
"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)"
"Total GHG em. - crops, no defor/orgSoils (tCO2e)"
"Total N-losses from animals, - manure management (tN)"
"Total N-losses from animals, - man man + housing (tN)"
"Total N-losses from animals, - grazing (tN)"
"Total N-losses from animals, - grazing + housing (tN)"
"Manure Man GHG emissions - animals (tCO2e)"
"Total GHG emissions - animals (tCO2e)"
"N inputs - crops (tN)"
"N outputs - crops (tN)"
"N balance - plot level based (tN)"
"NH3 from areas (tNH3)"
"NH3 from animals, - manure management (tNH3)"
/;


SET SubsetPerCommodImpact_InputsCropsGrass(PerCommodImpact) subset of per PerCommodImpact containing InputsCropsGrass
/
"Seeds (t)"
"Irrigation water (m3)"
"N fixation (tN)"
"N deposition (tN)"

*biomass covers crop residues and other
"N from CropRes/biomass as fert (tN)"
"N from mineral fert (tN)"
"N from manure as fert (tN)"
"N from all fertilizers (tN)"

"P from CropRes/biomass as fert (tP2O5)"
"P from mineral fert (tP2O5)"
"P from manure as fert (tP2O5)"
"P from all fertilizers (tP2O5)"

"Total CED (MJ)"
"Total GWP from CED (tCO2e)"

*new elements for aggregations:
"N inputs - crops (tN)"
/;

SET SubsetPerCommodImpact_OutputsCropsGrass(PerCommodImpact) subset of per PerCommodImpact containing OutputsCropsGrass
/
"CH4 flooded rice (tCH4)"
"CH4 flooded rice (tCO2e)"

"Direct N2O from mineral fert N applic (tN2O)"
"Direct N2O from CropRes/biomass as fert N applic (tN2O)"
"Direct N2O from manure as fert N applic (tN2O)"

"Direct N2O from mineral fert N applic (tCO2e)"
"Direct N2O from CropRes/biomass as fert N applic (tCO2e)"
"Direct N2O from manure as fert N applic (tCO2e)"

"Direct N loss from mineral fert N applic (tN)"
"Direct N loss from CropRes/biomass as fert N applic (tN)"
"Direct N loss from manure as fert N applic (tN)"

"N2O volat from mineral fert N applic (tN2O)"
"N2O volat from CropRes/biomass as fert N applic (tN2O)"
"N2O volat from manure as fert N applic (tN2O)"

"N2O volat from mineral fert N applic (tCO2e)"
"N2O volat from CropRes/biomass as fert N applic (tCO2e)"
"N2O volat from manure as fert N applic (tCO2e)"

"NH3 from mineral fert N applic (tNH3)"
"NH3 from CropRes/biomass as fert N applic (tNH3)"
"NH3 from manure as fert N applic (tNH3)"

"N2O leach from mineral fert N applic (tN2O)"
"N2O leach from CropRes/biomass as fert N applic (tN2O)"
"N2O leach from manure as fert N applic (tN2O)"

"N2O leach from mineral fert N applic (tCO2e)"
"N2O leach from CropRes/biomass as fert N applic (tCO2e)"
"N2O leach from manure as fert N applic (tCO2e)"

"N volat from mineral fert N applic (tN)"
"N volat from CropRes/biomass as fert N applic (tN)"
"N volat from manure as fert N applic (tN)"

"N leach from mineral fert N applic (tN)"
"N leach from CropRes/biomass as fert N applic (tN)"
"N leach from manure as fert N applic (tN)"

"NH3 from soils (tNH3)"

"NOx from fert applic (tNOx)"

*new elements for aggregations:
"N outputs - crops (tN)"
/;

SET SubsetPerCommodImpact_OtherCharCropsGrass(PerCommodImpact) subset of per PerCommodImpact containing OtherCharCropsGrass
/
"Land use (ha)"

"Deforestation (ha)"
"Deforest GHG emissions (tCO2e)"

"CultOrgSoils (ha)"
"CultOrgSoils GHG emissions (tCO2e)"
"CultOrgSoils C emissions (tCO2e)"
"CultOrgSoils N2O emissions (tCO2e)"

"LandDegradation (index)"
"Soil water erosion (t soil lost)"
"Soil wind erosion (t soil lost)"

"Aggreg. Pest. use level (index)"

*new elements for aggregations:
"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)"
"Total GHG em. - crops, no defor/orgSoils (tCO2e)"
"N balance - plot level based (tN)"
"NH3 from areas (tNH3)"
/;

SET SubsetPerCommodImpact_OutputsAnimals(PerCommodImpact) subset of per PerCommodImpact containing OutputsAnimals
/
"Enteric ferment (t CH4)"
"Enteric ferment (t CO2e)"

"N in manure (tN)"
"P in manure (tP2O5)"
"VS DM in manure (tVS)"
"TS DM in manure (tTS)"

"Manure man CH4 (tCH4)"
"Manure man CH4 (tCO2e)"
"Manure man N2O dir (tN2O)"
"Manure man N2O dir (tCO2e)"
"Manure man N in N2O dir (tN)"
"Manure man N2O volat (tN2O)"
"Manure man N2O volat (tCO2e)"
"Manure man N volat (tN)"
"Manure man N2O leach (tN2O)"
"Manure man N2O leach (tCO2e)"
"Manure man N leach (tN)"
"Housing NH3 from manure (tN)"
"Manure man N2O total (tN2O)"
"Manure man N2O total (tCO2e)"
"Manure man N total loss (tN)"
"Manure man+housing N total loss (tN)"
"Manure man P total loss (tP2O5)"
"Manure man GHG total (tCO2e)"

"Manure man NH3 (tNH3)"

"Manure N for crop areas (tN)"
"Manure N for grass areas (tN)"

"Manure P for crop areas (tP2O5)"
"Manure P for grass areas (tP2O5)"
/;


SET SubsetPerCommodImpact_OtherCharAnimals(PerCommodImpact) subset of per PerCommodImpact containing OtherCharAnimals
/
*new elements for aggregations:
"Total N-losses from animals, - manure management (tN)"
"Total N-losses from animals, - man man + housing (tN)"
"Total N-losses from animals, - grazing (tN)"
"Total N-losses from animals, - grazing + housing (tN)"
"Manure Man GHG emissions - animals (tCO2e)"
"Total GHG emissions - animals (tCO2e)"
"NH3 from animals, - manure management (tNH3)"
/;

SET Match_PerCommodImpact_CropsGrassCommodInputs(PerCommodImpact,InputsCropsGrass) matches the per commodity impact with per activity inputs
/
"Seeds (t)"                             ."Seeds (t)"
"Irrigation water (m3)"                 ."Irrigation water (m3)"
"N fixation (tN)"                       ."N fixation (tN)"
"N deposition (tN)"                     ."N deposition (tN)"

*biomass covers crop residues and other
"N from CropRes/biomass as fert (tN)"   ."N from CropRes/biomass as fert (tN)"
"N from mineral fert (tN)"              ."N from mineral fert (tN)"
"N from manure as fert (tN)"            ."N from manure as fert (tN)"
"N from all fertilizers (tN)"           ."N from all fertilizers (tN)"

"P from CropRes/biomass as fert (tP2O5)"."P from CropRes/biomass as fert (tP2O5)"
"P from mineral fert (tP2O5)"           ."P from mineral fert (tP2O5)"
"P from manure as fert (tP2O5)"         ."P from manure as fert (tP2O5)"
"P from all fertilizers (tP2O5)"        ."P from all fertilizers (tP2O5)"

"Total CED (MJ)"                        ."Total CED (MJ)"
"Total GWP from CED (tCO2e)"            ."Total GWP from CED (tCO2e)"

*new elements for aggregations:
"N inputs - crops (tN)"                 ."N inputs - crops (tN)"
/;

SET Match_PerCommodImpact_CropsGrassCommodOutputs(PerCommodImpact,OutputsCropsGrass) matches the per commodity impact with per activity outputs
/
"CH4 flooded rice (tCH4)"                                  ."CH4 flooded rice (tCH4)"
"CH4 flooded rice (tCO2e)"                                 ."CH4 flooded rice (tCO2e)"

"Direct N2O from mineral fert N applic (tN2O)"             ."Direct N2O from mineral fert N applic (tN2O)"
"Direct N2O from CropRes/biomass as fert N applic (tN2O)"  ."Direct N2O from CropRes/biomass as fert N applic (tN2O)"
"Direct N2O from manure as fert N applic (tN2O)"           ."Direct N2O from manure as fert N applic (tN2O)"

"Direct N2O from mineral fert N applic (tCO2e)"            ."Direct N2O from mineral fert N applic (tCO2e)"
"Direct N2O from CropRes/biomass as fert N applic (tCO2e)" ."Direct N2O from CropRes/biomass as fert N applic (tCO2e)"
"Direct N2O from manure as fert N applic (tCO2e)"          ."Direct N2O from manure as fert N applic (tCO2e)"

"Direct N loss from mineral fert N applic (tN)"            ."Direct N loss from mineral fert N applic (tN)"
"Direct N loss from CropRes/biomass as fert N applic (tN)" ."Direct N loss from CropRes/biomass as fert N applic (tN)"
"Direct N loss from manure as fert N applic (tN)"          ."Direct N loss from manure as fert N applic (tN)"

"N2O volat from mineral fert N applic (tN2O)"              ."N2O volat from mineral fert N applic (tN2O)"
"N2O volat from CropRes/biomass as fert N applic (tN2O)"   ."N2O volat from CropRes/biomass as fert N applic (tN2O)"
"N2O volat from manure as fert N applic (tN2O)"            ."N2O volat from manure as fert N applic (tN2O)"

"N2O volat from mineral fert N applic (tCO2e)"             ."N2O volat from mineral fert N applic (tCO2e)"
"N2O volat from CropRes/biomass as fert N applic (tCO2e)"  ."N2O volat from CropRes/biomass as fert N applic (tCO2e)"
"N2O volat from manure as fert N applic (tCO2e)"           ."N2O volat from manure as fert N applic (tCO2e)"

"NH3 from mineral fert N applic (tNH3)"                    ."NH3 from mineral fert N applic (tNH3)"
"NH3 from CropRes/biomass as fert N applic (tNH3)"         ."NH3 from CropRes/biomass as fert N applic (tNH3)"
"NH3 from manure as fert N applic (tNH3)"                  ."NH3 from manure as fert N applic (tNH3)"

"N2O leach from mineral fert N applic (tN2O)"              ."N2O leach from mineral fert N applic (tN2O)"
"N2O leach from CropRes/biomass as fert N applic (tN2O)"   ."N2O leach from CropRes/biomass as fert N applic (tN2O)"
"N2O leach from manure as fert N applic (tN2O)"            ."N2O leach from manure as fert N applic (tN2O)"

"N2O leach from mineral fert N applic (tCO2e)"             ."N2O leach from mineral fert N applic (tCO2e)"
"N2O leach from CropRes/biomass as fert N applic (tCO2e)"  ."N2O leach from CropRes/biomass as fert N applic (tCO2e)"
"N2O leach from manure as fert N applic (tCO2e)"           ."N2O leach from manure as fert N applic (tCO2e)"

"N volat from mineral fert N applic (tN)"                  ."N volat from mineral fert N applic (tN)"
"N volat from CropRes/biomass as fert N applic (tN)"       ."N volat from CropRes/biomass as fert N applic (tN)"
"N volat from manure as fert N applic (tN)"                ."N volat from manure as fert N applic (tN)"

"N leach from mineral fert N applic (tN)"                  ."N leach from mineral fert N applic (tN)"
"N leach from CropRes/biomass as fert N applic (tN)"       ."N leach from CropRes/biomass as fert N applic (tN)"
"N leach from manure as fert N applic (tN)"                ."N leach from manure as fert N applic (tN)"

"NH3 from soils (tNH3)"                                    ."NH3 from soils (tNH3)"

"NOx from fert applic (tNOx)"                              ."NOx from fert applic (tNOx)"

*new elements for aggregations:
"N outputs - crops (tN)"                                   ."N outputs - crops (tN)"
/;

SET Match_PerCommodImpact_CropsGrassCommodOtherChar(PerCommodImpact,OtherCharCropsGrass) matches the per commodity impact with per activity other characteristics
/
*"Land use (ha)"                      ."Land use per Mainoutput1 (ha)"
*land use here is ha per ha, thus =1 - but it is the inverse of the yield - thus do not include in these sets, but treat separately

"Deforestation (ha)"                 ."Deforestation (ha)"
"Deforest GHG emissions (tCO2e)"     ."Deforest GHG emissions (tCO2e)"

"CultOrgSoils (ha)"                  ."CultOrgSoils (ha)"
"CultOrgSoils GHG emissions (tCO2e)" ."CultOrgSoils GHG emissions (tCO2e)"
"CultOrgSoils C emissions (tCO2e)"   ."CultOrgSoils C emissions (tCO2e)"
"CultOrgSoils N2O emissions (tCO2e)" ."CultOrgSoils N2O emissions (tCO2e)"

"LandDegradation (index)"            ."LandDegradation (index)"
"Soil water erosion (t soil lost)"   ."Soil water erosion (t soil lost)"
"Soil wind erosion (t soil lost)"    ."Soil wind erosion (t soil lost)"

"Aggreg. Pest. use level (index)"    ."Aggreg. Pest. use level (index)"

*new elements for aggregations:
"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)"."Total GHG em. - crops, incl. defor/orgSoils (tCO2e)"
"Total GHG em. - crops, no defor/orgSoils (tCO2e)"   ."Total GHG em. - crops, no defor/orgSoils (tCO2e)"
"N balance - plot level based (tN)"                  ."N balance - plot level based (tN)"
"NH3 from areas (tNH3)"                              ."NH3 from areas (tNH3)"
/;

SET Match_PerCommodImpact_AnimalsCommodOutputs(PerCommodImpact,OutputsAnimals) matches the per commodity impact with per activity outputs
/
"Enteric ferment (t CH4)"         ."Enteric ferment (t CH4)"
"Enteric ferment (t CO2e)"        ."Enteric ferment (t CO2e)"

"N in manure (tN)"                ."N in manure (tN)"
"P in manure (tP2O5)"             ."P in manure (tP2O5)"
"VS DM in manure (tVS)"           ."VS DM in manure (tVS)"
"TS DM in manure (tTS)"           ."TS DM in manure (tTS)"

"Manure man CH4 (tCH4)"           ."Manure man CH4 (tCH4)"
"Manure man CH4 (tCO2e)"          ."Manure man CH4 (tCO2e)"
"Manure man N2O dir (tN2O)"       ."Manure man N2O dir (tN2O)"
"Manure man N2O dir (tCO2e)"      ."Manure man N2O dir (tCO2e)"
"Manure man N in N2O dir (tN)"    ."Manure man N in N2O dir (tN)"
"Manure man N2O volat (tN2O)"     ."Manure man N2O volat (tN2O)"
"Manure man N2O volat (tCO2e)"    ."Manure man N2O volat (tCO2e)"
"Manure man N volat (tN)"         ."Manure man N volat (tN)"
"Manure man N2O leach (tN2O)"     ."Manure man N2O leach (tN2O)"
"Manure man N2O leach (tCO2e)"    ."Manure man N2O leach (tCO2e)"
"Manure man N leach (tN)"         ."Manure man N leach (tN)"
"Housing NH3 from manure (tN)"    ."Housing NH3 from manure (tN)"
"Manure man N2O total (tN2O)"     ."Manure man N2O total (tN2O)"
"Manure man N2O total (tCO2e)"    ."Manure man N2O total (tCO2e)"
"Manure man N total loss (tN)"    ."Manure man N total loss (tN)"
"Manure man+housing N total loss (tN)"."Manure man+housing N total loss (tN)"
"Manure man P total loss (tP2O5)" ."Manure man P total loss (tP2O5)"
"Manure man GHG total (tCO2e)"    ."Manure man GHG total (tCO2e)"

"Manure man NH3 (tNH3)"           ."Manure man NH3 (tNH3)"

"Manure N for crop areas (tN)"    ."Manure N for crop areas (tN)"
"Manure N for grass areas (tN)"   ."Manure N for grass areas (tN)"

"Manure P for crop areas (tP2O5)" ."Manure P for crop areas (tP2O5)"
"Manure P for grass areas (tP2O5)"."Manure P for grass areas (tP2O5)"
/;

SET Match_PerCommodImpact_AnimalsCommodOtherChar(PerCommodImpact,OtherCharAnimals) matches the per commodity impact with per activity other characteristics for animals
/
*new elements for aggregations:
"Total N-losses from animals, - manure management (tN)" ."Total N-losses from animals, - manure management (tN)"
"Total N-losses from animals, - man man + housing (tN)" ."Total N-losses from animals, - man man + housing (tN)"
"Total N-losses from animals, - grazing (tN)"           ."Total N-losses from animals, - grazing (tN)"
"Total N-losses from animals, - grazing + housing (tN)" ."Total N-losses from animals, - grazing + housing (tN)"
"Manure Man GHG emissions - animals (tCO2e)"               ."Manure Man GHG emissions - animals (tCO2e)"
"Total GHG emissions - animals (tCO2e)"                    ."Total GHG emissions - animals (tCO2e)"
"NH3 from animals, - manure management (tNH3)"          ."NH3 from animals, - manure management (tNH3)"
/;



alias(OutputsCropsGrass,OutputsCropsGrass_2);

Set AllocationCharacteristics
/
"No allocation needed"
"Mass"
"Calories"
"Protein"
"Price"
"MainProduct"
/;

Parameter ActCropsGrass_PerPrimProdImpact_MR(Regions,Activities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) Impacts per primary product unit on activity level;
Parameter ActAnimalsAPU_PerPrimProdImpact_MR(Regions,Activities,AnimalTypeInHerd,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) Impacts per primary product unit on activity level;

Parameter FeedingRationsAPU_PerPrimProdContents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios) Feed commodity inputs per primary product unit on activity level;


*6.2) from _V6_DerivePerCommodityImpacts

*Originally, they have been specified in _V6_DerivePerCommodityImpacts only, but later, the option was added to switch the footprint calculations on or off to safe calculation time -
*but some of these sets are also used elsewhere, hence the relocation of their definition into this file.

Parameter PerCropCommodImpact_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) Impacts per crop commodity unit;
Parameter PerAnimalCommodImpact_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) Impacts per animal commodity unit;
Parameter PerAnimalCommodFeedInput_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,ProductionSystems,ProductionConditions,Scenarios) Feed commodity dry matter (t DM) per animal commodity unit;

Parameter AllocationFactor_MR(Regions,Commodities,Commodities_2,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios);
Parameter AllocationFactorDenominator_MR(Regions,Commodities,Commodities_2,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios);

*for later, we also need the impacts with an allocation characteristics dimension:
Parameter PerCropCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Impacts per crop commodity unit - with allocation characteristics dimension;
Parameter PerAnimalCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Impacts per animal commodity unit - with allocation characteristics dimension;
Parameter PerAnimalCommodFeedInput_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Feed commodity dry matter (t DM) per animal commodity unit - with allocation characteristics dimension;

Parameter ActCropsGrass_PerPrimProdImpact_WithAllocChar_MR(Regions,Activities,PerCommodImpact,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Impacts per primary product unit on activity level - with allocation characteristics dimension;
Parameter ActAnimalsAPU_PerPrimProdImpact_WithAllocChar_MR(Regions,Activities,AnimalTypeInHerd,PerCommodImpact,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Impacts per primary product unit on activity level - with allocation characteristics dimension;
Parameter FeedingRationsAPU_PerPrimProdContents_WithAllocChar_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,AllocationCharacteristics,ProductionSystems,ProductionConditions,Scenarios) Feed commodity inputs per primary product unit on activity level - with allocation characteristics dimension;

Set UnitOfReference_PerCommodImpacts
/
"Reference unit: ton fresh matter"
"Reference unit: 1000 kcal"
"Reference unit: ton protein"
"Reference unit: 1000 $"
/
;
Parameter PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios) Impacts per crop commodity - with allocation characteristics dimension - per unit mass calorie or protein;
Parameter PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios) Impacts per animal commodity - with allocation characteristics dimension - per unit mass calorie or protein;
Parameter PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,ProductionSystems,ProductionConditions,Scenarios) Feed commodity dry matter (t DM) per animal commodity - with allocation characteristics dimension - per unit mass calorie or protein;

*and we need the following auxiliary parameters and variables to fasten the code:
Parameter Inverse_Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios);
Parameter Inverse_Commod_OtherChar_MR(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios);

Variable Inverse_VActAnimalsHead_QuantityActUnits_MR(Regions,Activities,AnimalTypeInherd,ProductionSystems,ProductionConditions,Scenarios);


*animal products:
*we need a specific animal output for dairy herd sourdced beef - and for the average from dairy and beef herd as well:
$onmulti
Set OutputsAnimals
/
"Meat (t) (from dairy herd)"
"Meat (t) (weighted dairy/beef herd)"
/;
$offmulti


Set Match_MainProdAndCoProd(Commodities,Commodities_2)
/
*SET1
"Beer"."Dregs - beer"
**TOO UNSPECIFIED - drop for now "Brans"
**linked below "Bran, Cereals"
**linked below "Bran, Pulses"
**TOO UNSPECIFIED - drop for now "Cereals, Other"
*        "Default composition: 68 Popcorn, 89 Buckwheat, 90 Flour, buckwheat, 91 Bran, buckwheat, 92 Quinoa, 94 Fonio, 95 Flour, fonio, 96 Bran, fonio, 97 Triticale, 98 Flour, triticale, 99 Bran, triticale, 101 Canary seed, 103 Grain, mixed,
*        104 Flour, mixed grain, 105 Bran, mixed grains, 108 Cereals, nes, 111 Flour, cereals, 112 Bran, cereals nes, 113 Cereal preparations, nes"
**TOO UNSPECIFIED - drop for now "Citrus, Other"
*This is 2614."Citrus, Other": "Default composition: 512 Fruit, citrus nes, 513 Juice, citrus, single strength, 514 Juice, citrus, concentrated"
"Oilcrops Oil, Other"."Oilseed Cakes, Other"
*the specification for this is as follows:
*2586."Oilcrops Oil, Other"
*        "Default composition: 264 Butter of karite nuts, 266 Oil, castor beans, 276 Oil, tung nuts, 278 Oil, jojoba, 281 Oil, safflower, 297 Oil, poppy,
*        306 Vegetable tallow, 307 Oil, stillingia, 313 Oil, kapok, 334 Oil, linseed, 337 Oil, hempseed, 340 Oil, vegetable origin nes, 664 Cocoa, butter, 1241 Margarine, liquid, 1242 Margarine, short,
*        1273 Castor oil, hydrogenated (opal wax), 1274 Oil, boiled etc, 1275 Oil, hydrogenated"
**linked above "Oilseed Cakes, Other"
*the specification for this is as follows:
*2598."Oilseed Cakes, Other"
*        "Default composition: 37 Cake, rice bran, 61 Cake, maize, 282 Cake, safflower, 298 Cake, poppy seed, 314 Cake, kapok, 335 Cake, linseed, 338 Cake, hempseed, 341 Cake, oilseeds nes"
**linked below "Rape and Mustard Cake"
"Rape and Mustard Oil"."Rape and Mustard Cake"
*"Bread"
*"Feed, pulp of fruit"
*"Feed, vegetable products nes"
"Flour, cereals"."Bran, Cereals"
"Flour, pulses"."Bran, Pulses"
**TOO UNSPECIFIED - drop for now "Flour, roots and tubers nes"
*"Fruit, dried nes"
*"Fruit, prepared nes"
"Juice, citrus, concentrated"."Citrus pulp"
"Juice, citrus, single strength"."Citrus pulp"
"Juice, fruit nes"."Fruit pulp"
*"Nuts, prepared (exc. groundnuts)"
"Oilcrops Oil, Other"."Oilseed Cake Meal"
"Oilcrops Oil, Other"."Oilseed Cake nes"
"Rape+Mustard Oils"."Rape and Mustard Cake"
*"Straw husks"
*"Vegetables in vinegar"
*"Vegetables, canned nes"
*"Vegetables, dehydrated"
*"Vegetables, dried nes"
**TOO UNSPECIFIED - drop for now "Vegetables, fresh nes"
*"Vegetables, fresh or dried products nes"
*"Vegetables, frozen"
*"Vegetables, homogenized preparations"
*"Vegetables, preserved nes"
*"Vegetables, preserved, frozen"
*"Vegetables, temporarily preserved"
*"Breakfast Cereals"
**TOO UNSPECIFIED - drop for now "Flour, Fruit"
**TOO UNSPECIFIED - drop for now "Flour/Meal Of Oilseeds"
*"Fruit Tropical Dried Nes"
*"Nuts, all, shelled"
*"Roots And Tubers Dried"
"Flour, mixed grain"."Brans, mixed grain"

*SET3
*co-prod added by us - not in the data
"Rice, Husked"."Rice hulls"
"Kapokseed in shell"."Kapok fibre"
*cotton linter is not included on the level of these terms (it is for "oil, cottonseed" and "cake, cottonseed")
"Palm Oil"."Palm kernels"
"Wine"."Marc of Grapes"
"Sesameseed Oil"."Sesameseed Cake"
*this may cover olive oil virgin and from residues - then the co-product is residues and pressed resides, the latter not being covered in the system
"Olive Oil"."Olive Residues"
*co-prod added by us - not in the data
"Groundnuts (Shelled Eq)"."Groundnut shells"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Soyabean Cake"."Soyabean Oil"
"Sunflowerseed Oil"."Sunflowerseed Cake"
*co-prod added by us - not in the data
"Beer of sorghum"."Beer of Shorgum dregs"
*no co-products, thus dropped here
*"Bulgur"
*co-prod added by us - not in the data
"Cocoa, paste"."Cocoa husks"
*unimportant, leave out for now
*"Coffee, extracts"
"Coffee, roasted"."Coffee, husks and skins"
*co-prod added by us - not in the data
"Butter of karite nuts"."Karite nut cake"
*co-prod added by us - not in the data
"Brazil nuts, shelled"."Brazil nut shells"
*no coprod, thus dropped here
*"Alfalfa meal and pellets"
*co-prod added by us - not in the data
"Cashew nuts, shelled"."Cashew nut shells"
*co-prod added by us - not in the data
Chestnut."Chestnut shells"
*co-prod added by us - not in the data
"Coconuts, desiccated"."Coconut shells"
*co-prod added by us - not in the data
"Copra"."Coconut shells"
*no coprod, thus dropped here
*"Cassava dried"
"Almonds shelled"."Almond shells"
"Apricots, dry"."Apricot kernel"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Cake, soybeans"."Oil, soybean"
*PROPOSAL
"Oil, soybean"."Cake, soybeans"
"Bran, wheat"."Flour, wheat"

*no coprod, thus dropped here
*"Flour, mustard"
*no coprod, thus dropped here
*"Flour, potatoes"
"Flour, fonio"."Bran, fonio"
"Flour, mixed grain"."Bran, Mixed Grain"
"Flour, wheat"."Bran, wheat"
*no coprod, thus dropped here
*"Figs dried"
*for all the juices below: co-prod added by us - not in the data
"Juice, tomato"."Tomato pulp"
"Juice, grape"."Grape pulp"
"Juice, grapefruit"."Grapefruit pulp"
"Juice, grapefruit, concentrated"."Grapefruit pulp"
"Juice, lemon, concentrated"."Lemon pulp"
"Juice, orange, concentrated"."Orange pulp"
"Juice, orange, single strength"."Orange pulp"
"Juice, pineapple"."Pineapple pulp"
"Juice, pineapple, concentrated"."Pineapple pulp"
"Juice, plum, concentrated"."Plum pulp"
"Juice, plum, single strength"."Plum pulp"
*co-prod added by us - not in the data
"Hazelnuts, shelled"."Hazelnut shells"
*may not use this total but the next
*"Groundnuts Total Shelled"
"Groundnuts, shelled"."Groundnut shells"
*no coprod, thus dropped here
*"Malt"
*no coprod, thus dropped here
*"Mushrooms, canned"
*co-prod added by us - not in the data
"Oil, palm"."Palm kernels"
"Oil, linseed"."Cake, linseed"
"Oil, rapeseed"."Cake, rapeseed"
"Oil, safflower"."Cake, safflower"
"Oil, sesame"."Cake, sesame seed"
"Oil, poppy"."Cake Of Poppy Seed"
"Oil, sunflower"."Cake, sunflower"
"Oil, olive, virgin"."Olive residues"
*the following is likely the sum of olive oil virgin plus oil, olive residues
*"Olive Oil,Total"
*co-prod added by us - not in the data
"Oil, castor beans"."Castor bean cake"
*coproducts oat offals and hulls not in the data - drop for now
*"Oats rolled".OAT OFFALS.HULLS
*no coprod, thus dropped here
*"Peanut butter"
*coproducts juice and pulp - but not in the data - just take "Pineapple pulp"
"Pineapples canned"."Pineapple pulp"
*no coprod, thus dropped here
*"Plums dried (prunes)"
"Potatoes, frozen"."Potato offals"
*unimportant
*"Pyrethrum, extraction"
*no coprod, thus dropped here
*"Raisins"
*no coprod, thus dropped here
*"Soya curd"
*no coprod, thus dropped here
*"Soya paste"
*no coprod, thus dropped here
*"Soya sauce"
*no coprod, thus dropped here
*"Sweet corn frozen"
*no coprod, thus dropped here
*"Sweet corn prep or preserved"
*no coprod, thus dropped here
*"Tea, mate extracts"
*no coprod, thus dropped here
*"Starch, cassava"
*co-prod added by us - not in the data
"Walnuts, shelled"."Walnut shells"
*co-prod added by us - not in the data
"Tomatoes, paste"."Tomato pulp"
*co-prod added by us - not in the data
"Tomatoes, peeled"."Tomato pulp"
*co-prod added by us - not in the data
"Applejuice Single Streng"."Apple pulp"
"Applejuice Concentrated"."Apple pulp"
*no coprod, thus dropped here
*"Cassava Tapioca"
*no coprod, thus dropped here
*"Flour, Cassava"
"Flour, Sorghum"."Bran, sorghum"
"Flour, Triticale"."Bran, Triticale"
*buckwheat also has hulls - but we leave them away as they are neither in the data
"Flour, Buckwheat"."Bran, buckwheat"
"Flour, Millet"."Bran, millet"
"Flour, Rye"."Bran, Rye"
*co-prod added by us - not in the data
"Jojoba Oil"."Jojoba cake"
*unimportant
*"Leaves And Tops, Vines"
"Lemonjuice Single-Streng"."Lemon pulp"
"Mango Juice"."Mango Pulp"
*no coprod, thus dropped here
*"Dried Mushrooms"
"Must Of Grapes"."Marc Of Grapes"
"Oil, Hempseed"."Cake, hempseed"
"Oil, Mustard Seed"."Cake, mustard"
*Barley also has hulls - but we leave them away as they are neither in the data
"Pot Barley"."Bran, Barley"
*no coprod, thus dropped here
*"Plums, Dried (Prunes)"
*no coprod, thus dropped here
*"Potato Starch"
*no coprod, thus dropped here
*"Potato Tapioca"
*unimportant
*"Pyrethrum Marc"

$ontext;
*The commod trees of the following are dealt with only later
*this is third level
"Cake, kapok"
"Oil, kapok"

"Cane tops"
"Cashewapple"
"Cocoons, unreelable & waste"
"Maple sugar and syrups"
"Pastry"
"Popcorn"
"Rubber natural dry"
"Silk raw"
"Silk-worm cocoons, reelable"
"Vegetable tallow"
"Tobacco products nes"
"Wheat+Flour,Wheat Equivalent"
"Beet Tops"
"Malt Extracts"
*this is a by-product of coconuts, not covered in the commodity trees
"Coir"
*this is a by-product of hempseed, not covered in the commodity trees
"Hemp Fibre And Tow"

"Flax Fib+Tow+W"
"Flax fibre and tow"
"Flax fibre raw"
"Flax tow waste"
*END OF: The commod trees of the following are dealt with only later
$offtext;

*co-prod added by us - not in the data
"Tangerine Juice"."Tangerine pulp"
*co-prod added by us - not in the data
"Tomatojuice Concentrated"."Tomato pulp"
*co-prod added by us - not in the data
"Tung Oil"."Tung nut cake"

*MAIN-prod added by us - not in the data
"Oat flour"."Bran, Oats"
*MAIN-prod added by us - not in the data
"Cocoa paste"."Cocoa Husks+Shell"
"Oil palm fruit pulp"."Palm oil"

*THE FOLLOWING are the LEVEL2 co-products:

*the following has no coproducts
*"Rice, Broken"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
*the following has no coproducts
*"Rice Flour"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
"Rice, Starch"."Rice Gluten"
"Oil, rice bran"."Cake, rice bran"
"Ricebran Oil"."Cake, rice bran"
"Palmkernel Oil"."Palmkernel Cake"
"Maize Germ Oil"."Cake, maize"
"Coconut Oil"."Copra Cake"
"Groundnut Oil"."Groundnut Cake"
*co-prod added by us - not in the data
"Beer of barley"."Beer of Barley dregs"
*we assume powder to be main product, not cocoa butter
"Cocoa, powder & cake"."Cocoa, butter"
"Barley, pearled"."Barley Flour And Grits"
*co-prod added by us - not in the data
"Kapokseed shelled"."Kapokseed shells"
*"Macaroni"
"Oil, palm kernel"."Cake, palm kernel"
"Oil, maize"."Cake, maize"
*co-prod added by us - not in the data
"Oil, olive residues"."Pressed olive residues"
"Oil, groundnut"."Cake, groundnuts"
"Oil, coconut (copra)"."Cake, copra"
*the following has no coproducts
*"Prepared Groundnuts"
"Starch Of Maize"."Maize Gluten"
"Wheat Starch"."Wheat Gluten"
*MAIN-prod added by us - not in the data
"Palm kernel oil"."Cake, Palm Kernels"
*MAIN-prod added by us - not in the data
"Wheat dregs"."Wheat Fermented Beverage"

*SET4
*"Alcohol, Non-Food"
"Alcoholic Beverages"."Dregs from brewing, distillation"
"Beverages, Alcoholic"."Dregs from brewing, distillation"
"Beverages, Fermented"."Dregs from brewing, distillation"
*LINKED below: sugars, etc. "Molasses"
*"Sugar & Sweeteners"
"Sugar (Raw Equivalent)"."Molasses"
"Sugar non-centrifugal"."Molasses"
*cf: 2541."Sugar non-centrifugal" resp. 163."Sugar non-centrifugal"
"Sugar, Raw Equivalent"."Molasses"
*this covers more in contrast to the other sugar elements: it is defined as follows:
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes,
*        162 Sugar Raw Centrifugal, 163 Sugar non-centrifugal, 166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose"
"Sugar, Refined Equiv"."Molasses"
"Sugar, Refined Equiv (sugar cane)"."Molasses (sugar cane)"
"Sugar, Refined Equiv (sugar beet)"."Molasses (sugar beet)"
*"Sweeteners, Other"
*This is 2543."Sweeteners, Other"
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes, 165 Molasses,
*        166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose, 175 Isoglucose, 633 Beverages, non alcoholic"
*"Beverages"
"Beverages, distilled alcoholic"."Dregs from brewing, distillation"
*"Beverages, fermented rice"
**TOO UNSPECIFIED - drop for now "Beverages, non alcoholic"
*"Beverages+Tobacco"
"Chocolate products nes"."Cocoa Husks+Shell"
**TOO UNIMPORTANT - drop for now "Cider etc"
*"Cigarettes"
*"Cigars, cheroots"
"Coffee, substitutes containing coffee"."Coffee, husks and skins"
*LINKED above "Dregs from brewing, distillation"
*"Feed and meal, gluten"
*this is the following: 846."Feed and meal, gluten"
*        "Generally, by-products of the wet milling of maize. Gluten feed consists of fibres, spent germ and steep liquor.
*        Gluten meal contains endosperm protein fractions that remain following starch recovery."
"Fixed Vegetable Oils"."Oil cakes - various"
*"Fructose and syrup, other"
*"Fruit, cooked, homogenized preparations"
*"Glucose and dextrose"
"Margarine, liquid"."Oil cakes - various"
"Margarine, short"."Oil cakes - various"
*"Oil, boiled etc"
*This is 1274."Oil, boiled etc": "Also includes oxidized and sulphurized oils. Animal and vegetable fats and oils whose chemical structure has been modified to improve viscosity, drying ability or other properties."
"Oil, essential nes"."Oil cakes - various"
"Sugar Raw Centrifugal"."Molasses"
"Sugar refined"."Molasses"
*"Alcohol Non Food Purpose"
*"Oils Hydrogenated"

*LINKED above: "Oil cakes - various"

*from NFP69
Seasoning."CoProds Seasoning"


*SET5
*"Animal Products"
*"Bovine Meat"
*        complex description in FAOSTAT - for simplicity, we take it identical to cattle meat and add it to the corresponding subset
"Butter, Ghee"."Milk, Skimmed"
"Cheese"."Whey"
"Cream"."Milk, Skimmed"
*"Eggs"
*        complex description in FAOSTAT - for simplicity, we take it identical to Chicken eggs and add it to the corresponding subset
*DO THIS LATER "Fish Meal"
*this is 2855."Fish Meal" and thus covers all seafood:
*        "Default composition: 1511 Freshwater Meal Fr Offal, 1524 Demersal Meal from Offal, 1537 Pelagic Meal from Offal, 1550 Marn Meal Of, 1559 Crustaceans Meal F Offal,
*        1567 Molluscs Meal from Offal, 1576 Cephalopods Meal F Offal, 1581 Aquatic Mammals Meals, 1584 Aqua Mammal Meal F Offal, 1591 Aq A Meal Of"
*"Fish, Body Oil"
*this is 2781."Fish, Body Oil" and thus covers fish and marine mammals
*        "Default composition: 1509 Frwt Bdy Oil, 1522 Dmrs Bdy Oil, 1535 Pelg Bdy Oil, 1548 Marn Bdy Oil, 1582 Aq M Oils"
*"Fish, Liver Oil"
*2782."Fish, Liver Oil" and thus covers fish and marine mammals
*        "Default composition: 1510 Frwt Lvr Oil, 1523 Demersal Liver Oils, 1536 Pelg Lvr Oil, 1549 Marine nes Liver Oils"
*"Hides and skins"
*"Meat Meal"
*LINKED above: "Milk, Skimmed"
*LINKED above: "Whey"
*"Animal Oil+Fat+Grs"
*"Animal Vegetable Oil"
*"Bacon and ham"
"Butter"."Milk, Skimmed"
"Butter, cow milk"."Milk, skimmed cow"
*DROP FOR NOW - not so important: "Buttermilk, curdled, acidified milk"
*"Canned Meat nes"
"Cheese and Curd"."Whey"
"Cheese, processed"."Whey"
"Cheese, sheep milk"."Whey"
"Cheese, whole cow milk"."Whey"
"Cream fresh"."Milk, Skimmed"
*"Eggs Liquid,Dried"
*DO THIS LATER "Eggs, dried"
*DO THIS LATER "Eggs, liquid"
*"Fat, liver prepared (foie gras)"
*This is needed to match 1060."Fat, liver prepared (foie gras)" with activities:
*        "Fatty livers of ducks and geese when cooked, prepared or preserved(e.g. pat‚)."
*"Fat, nes, prepared"
*"Fatty acids"
*"Fatty substance residues"
"Ghee, of buffalo milk"."Skim Milk Of Buffalo"
*"Grease incl. lanolin wool"
*"Lactose"
*"Lard"
*"Meal, meat"
*"Meat and Meat Preparations"
*"Meat Fresh+Ch+Frozen"
*"Meat Prepared Pres"
"Meat, beef and veal sausages"."Cattle Butcher Fat"
*"Meat, beef, preparations"
"Meat, cattle, boneless (beef & veal)"."Cattle Butcher Fat"
*"Meat, chicken, canned"
*"Meat, dried nes"
"Meat, pig sausages"."Pig Butcher Fat"
"Meat, pig, preparations"."Pig Butcher Fat"
"Meat, pork"."Pig Butcher Fat"
*DO THIS LATER "Milk Condensed + Evaporated"
*"Milk Condensed+Dry+Fresh"
*DO THIS LATER "Milk Dry"
*"Milk Equivalent"
*"Milk, products of natural constituents nes"
*"Milk, reconstituted"
*LINKED above "Milk, skimmed cow"
*DO THIS LATER "Milk, skimmed dried"
*DO THIS LATER "Milk, whole condensed"
*DO THIS LATER "Milk, whole dried"
*DO THIS LATER "Milk, whole evaporated"
*"Oils, fats of animal nes"
*DO THIS LATER "Whey, condensed"
*DO THIS LATER "Whey, dry"
*DO THIS LATER "Whey, Pres+Concen"
*"Wool, hair waste"
"Yoghurt, concentrated or not"."Water"
$ontext;
"Animals live nes"
"Asses"
"Beehives"
"Buffaloes"
"Camelids, other"
"Camels"
"Cattle"
"Chickens"
"Ducks"
"Goats"
"Horses"
"Mules"
"Pigs"
"Rabbits and hares"
"Rodents, other"
"Sheep"
"Turkeys"
"Beef Canned"
"Beef Dried Salt Smoked"
"Blood Meal"
$offtext;
"Butter Of Buffalo Milk"."Skim Milk Of Buffalo"
"Butter Of Goat Milk"."Skim Milk Of Goat"
"Butter+Ghee (Sheep Milk)"."Skim Sheep Milk"
*"Dry Buttermilk"
*"Casein"
"Cheese Of Buffalo Milk"."Whey"
"Cheese Of Goat Milk"."Whey"
"Cheese (Skim Cow Milk)"."Whey"
*"Game"
*"Geese"
*"Geese and guinea fowls"
"Ghee, of cow milk"."Milk, skimmed cow"
*"Whey Cheese"
*DO NOT NOW "Whey, Fresh"
*"Wool Shoddy"
"Yoghurt"."Water"
*the butcher fat is the co-product from meat, other fats are parts of the liveweight COMPLEMENTING meat and offals
*LINKED above "Cattle Butcher Fat"
*LINKED above "Pig Butcher Fat"

*"Fat, Poultry Rendered"
*"Lard And Stearine Oil"
*"Live Animals Nes"
*"Meat Extracts"
*"Meat Prepared Nes"
*"Oils Fish And Marine Mam"
*"Other birds for eggs"

*DROP FOR NOW - not important"Skim Milk, Condensed"
*"Skim Milk, Evaporated"
*LINKED above: "Skim Milk Of Buffalo"
*LINKED above: "Skim Milk Of Goat"
*LINKED above: "Skim Sheep Milk"

*from NFP69
'Hard cheese'."Whey"
'Semihard cheese'."Whey"
'Soft cheese'."Whey"


*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
*NOW DO ASSIGN THE CO-products first, then the products: this allows to derive the impacts for the co-products as well:
*do it for these where the main/Coprod pairs are given only, and also there for the important ones only
*and sometimes, a co-prod comes with several main prods, then do it only for one of those
*SET1
"Dregs - beer"."Beer"
**TOO UNSPECIFIED - drop for now "Brans"
**linked below "Bran, Cereals"
**linked below "Bran, Pulses"
**TOO UNSPECIFIED - drop for now "Cereals, Other"
*        "Default composition: 68 Popcorn, 89 Buckwheat, 90 Flour, buckwheat, 91 Bran, buckwheat, 92 Quinoa, 94 Fonio, 95 Flour, fonio, 96 Bran, fonio, 97 Triticale, 98 Flour, triticale, 99 Bran, triticale, 101 Canary seed, 103 Grain, mixed,
*        104 Flour, mixed grain, 105 Bran, mixed grains, 108 Cereals, nes, 111 Flour, cereals, 112 Bran, cereals nes, 113 Cereal preparations, nes"
**TOO UNSPECIFIED - drop for now "Citrus, Other"
*This is 2614."Citrus, Other": "Default composition: 512 Fruit, citrus nes, 513 Juice, citrus, single strength, 514 Juice, citrus, concentrated"
"Oilseed Cakes, Other"."Oilcrops Oil, Other"
*the specification for this is as follows:
*2586."Oilcrops Oil, Other"
*        "Default composition: 264 Butter of karite nuts, 266 Oil, castor beans, 276 Oil, tung nuts, 278 Oil, jojoba, 281 Oil, safflower, 297 Oil, poppy,
*        306 Vegetable tallow, 307 Oil, stillingia, 313 Oil, kapok, 334 Oil, linseed, 337 Oil, hempseed, 340 Oil, vegetable origin nes, 664 Cocoa, butter, 1241 Margarine, liquid, 1242 Margarine, short,
*        1273 Castor oil, hydrogenated (opal wax), 1274 Oil, boiled etc, 1275 Oil, hydrogenated"
**linked above "Oilseed Cakes, Other"
*the specification for this is as follows:
*2598."Oilseed Cakes, Other"
*        "Default composition: 37 Cake, rice bran, 61 Cake, maize, 282 Cake, safflower, 298 Cake, poppy seed, 314 Cake, kapok, 335 Cake, linseed, 338 Cake, hempseed, 341 Cake, oilseeds nes"
**linked below "Rape and Mustard Cake"
"Rape and Mustard Cake"."Rape and Mustard Oil"
*"Bread"
*"Feed, pulp of fruit"
*"Feed, vegetable products nes"
"Bran, Cereals"."Flour, cereals"
"Bran, Pulses"."Flour, pulses"
**TOO UNSPECIFIED - drop for now "Flour, roots and tubers nes"
*"Fruit, dried nes"
*"Fruit, prepared nes"
****CoprodMainProd not assigned: "Juice, citrus, concentrated"."Citrus pulp"
"Citrus pulp"."Juice, citrus, single strength"
"Fruit pulp"."Juice, fruit nes"
*"Nuts, prepared (exc. groundnuts)"
"Oilseed Cake Meal"."Oilcrops Oil, Other"
"Oilseed Cake nes"."Oilcrops Oil, Other"
"Rape and Mustard Cake"."Rape+Mustard Oils"
*"Straw husks"
*"Vegetables in vinegar"
*"Vegetables, canned nes"
*"Vegetables, dehydrated"
*"Vegetables, dried nes"
**TOO UNSPECIFIED - drop for now "Vegetables, fresh nes"
*"Vegetables, fresh or dried products nes"
*"Vegetables, frozen"
*"Vegetables, homogenized preparations"
*"Vegetables, preserved nes"
*"Vegetables, preserved, frozen"
*"Vegetables, temporarily preserved"
*"Breakfast Cereals"
**TOO UNSPECIFIED - drop for now "Flour, Fruit"
**TOO UNSPECIFIED - drop for now "Flour/Meal Of Oilseeds"
*"Fruit Tropical Dried Nes"
*"Nuts, all, shelled"
*"Roots And Tubers Dried"
"Brans, mixed grain"."Flour, mixed grain"

*SET3
*co-prod added by us - not in the data
"Rice hulls"."Rice, Husked"
"Kapok fibre"."Kapokseed in shell"
*cotton linter is not included on the level of these terms (it is for "oil, cottonseed" and "cake, cottonseed")
"Palm kernels"."Palm Oil"
"Marc of Grapes"."Wine"
"Sesameseed Cake"."Sesameseed Oil"
*this may cover olive oil virgin and from residues - then the co-product is residues and pressed resides, the latter not being covered in the system
"Olive Residues"."Olive Oil"
*co-prod added by us - not in the data
"Groundnut shells"."Groundnuts (Shelled Eq)"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Soyabean Oil"."Soyabean Cake"
"Sunflowerseed Cake"."Sunflowerseed Oil"
*co-prod added by us - not in the data
"Beer of Shorgum dregs"."Beer of sorghum"
*no co-products, thus dropped here
*"Bulgur"
*co-prod added by us - not in the data
"Cocoa husks"."Cocoa, paste"
*unimportant, leave out for now
*"Coffee, extracts"
"Coffee, husks and skins"."Coffee, roasted"
*co-prod added by us - not in the data
"Karite nut cake"."Butter of karite nuts"
*co-prod added by us - not in the data
"Brazil nut shells"."Brazil nuts, shelled"
*no coprod, thus dropped here
*"Alfalfa meal and pellets"
*co-prod added by us - not in the data
"Cashew nut shells"."Cashew nuts, shelled"
*co-prod added by us - not in the data
"Chestnut shells".Chestnut
*co-prod added by us - not in the data
"Coconut shells"."Coconuts, desiccated"
*co-prod added by us - not in the data
"Coconut shells"."Copra"
*no coprod, thus dropped here
*"Cassava dried"
"Almond shells"."Almonds shelled"
"Apricot kernel"."Apricots, dry"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
*"Oil, soybean"."Cake, soybeans"
*no coprod, thus dropped here
*"Flour, mustard"
*no coprod, thus dropped here
*"Flour, potatoes"
"Bran, fonio"."Flour, fonio"
"Bran, Mixed Grain"."Flour, mixed grain"
*"Bran, wheat"."Flour, wheat"
*no coprod, thus dropped here
*"Figs dried"
*for all the juices below: co-prod added by us - not in the data

"Tomato pulp"."Juice, tomato"
"Grape pulp"."Juice, grape"
"Grapefruit pulp"."Juice, grapefruit"
****CoprodMainProd not assigned: "Juice, grapefruit, concentrated"."Grapefruit pulp"
****CoprodMainProd not assigned: "Juice, lemon, concentrated"."Lemon pulp"
****CoprodMainProd not assigned: "Juice, orange, concentrated"."Orange pulp"
"Orange pulp"."Juice, orange, single strength"
"Pineapple pulp"."Juice, pineapple"
****CoprodMainProd not assigned: "Juice, pineapple, concentrated"."Pineapple pulp"
****CoprodMainProd not assigned: "Juice, plum, concentrated"."Plum pulp"
"Plum pulp"."Juice, plum, single strength"
*co-prod added by us - not in the data
"Hazelnut shells"."Hazelnuts, shelled"
*may not use this total but the next
*"Groundnuts Total Shelled"
"Groundnut shells"."Groundnuts, shelled"
*no coprod, thus dropped here
*"Malt"
*no coprod, thus dropped here
*"Mushrooms, canned"
*co-prod added by us - not in the data
"Palm kernels"."Oil, palm"
"Cake, linseed"."Oil, linseed"
"Cake, rapeseed"."Oil, rapeseed"
"Cake, safflower"."Oil, safflower"
"Cake, sesame seed"."Oil, sesame"
"Cake Of Poppy Seed"."Oil, poppy"
"Cake, sunflower"."Oil, sunflower"
"Olive residues"."Oil, olive, virgin"
*the following is likely the sum of olive oil virgin plus oil, olive residues
*"Olive Oil,Total"
*co-prod added by us - not in the data
"Castor bean cake"."Oil, castor beans"
*coproducts oat offals and hulls not in the data - drop for now
*"Oats rolled".OAT OFFALS.HULLS
*no coprod, thus dropped here
*"Peanut butter"
*coproducts juice and pulp - but not in the data - just take "Pineapple pulp"
****CoprodMainProd not assigned: "Pineapples canned"."Pineapple pulp"
*no coprod, thus dropped here
*"Plums dried (prunes)"
****CoprodMainProd not assigned: "Potatoes, frozen"."Potato offals"
*unimportant
*"Pyrethrum, extraction"
*no coprod, thus dropped here
*"Raisins"
*no coprod, thus dropped here
*"Soya curd"
*no coprod, thus dropped here
*"Soya paste"
*no coprod, thus dropped here
*"Soya sauce"
*no coprod, thus dropped here
*"Sweet corn frozen"
*no coprod, thus dropped here
*"Sweet corn prep or preserved"
*no coprod, thus dropped here
*"Tea, mate extracts"
*no coprod, thus dropped here
*"Starch, cassava"
*co-prod added by us - not in the data
"Walnut shells"."Walnuts, shelled"
*co-prod added by us - not in the data
****CoprodMainProd not assigned: "Tomatoes, paste"."Tomato pulp"
*co-prod added by us - not in the data
****CoprodMainProd not assigned: "Tomatoes, peeled"."Tomato pulp"
*co-prod added by us - not in the data
"Apple pulp"."Applejuice Single Streng"
****CoprodMainProd not assigned: "Applejuice Concentrated"."Apple pulp"
*no coprod, thus dropped here
*"Cassava Tapioca"
*no coprod, thus dropped here
*"Flour, Cassava"
"Bran, sorghum"."Flour, Sorghum"
"Bran, Triticale"."Flour, Triticale"
*buckwheat also has hulls - but we leave them away as they are neither in the data
"Bran, buckwheat"."Flour, Buckwheat"
"Bran, millet"."Flour, Millet"
"Bran, Rye"."Flour, Rye"
*co-prod added by us - not in the data
"Jojoba cake"."Jojoba Oil"
*unimportant
*"Leaves And Tops, Vines"
"Lemon pulp"."Lemonjuice Single-Streng"
"Mango Pulp"."Mango Juice"
*no coprod, thus dropped here
*"Dried Mushrooms"
****CoprodMainProd not assigned: "Must Of Grapes"."Marc Of Grapes"
"Cake, hempseed"."Oil, Hempseed"
"Cake, mustard"."Oil, Mustard Seed"
*Barley also has hulls - but we leave them away as they are neither in the data
"Bran, Barley"."Pot Barley"
*no coprod, thus dropped here
*"Plums, Dried (Prunes)"
*no coprod, thus dropped here
*"Potato Starch"
*no coprod, thus dropped here
*"Potato Tapioca"
*unimportant
*"Pyrethrum Marc"

$ontext;
*The commod trees of the following are dealt with only later
*this is third level
"Cake, kapok"
"Oil, kapok"

"Cane tops"
"Cashewapple"
"Cocoons, unreelable & waste"
"Maple sugar and syrups"
"Pastry"
"Popcorn"
"Rubber natural dry"
"Silk raw"
"Silk-worm cocoons, reelable"
"Vegetable tallow"
"Tobacco products nes"
"Wheat+Flour,Wheat Equivalent"
"Beet Tops"
"Malt Extracts"
*this is a by-product of coconuts, not covered in the commodity trees
"Coir"
*this is a by-product of hempseed, not covered in the commodity trees
"Hemp Fibre And Tow"

"Flax Fib+Tow+W"
"Flax fibre and tow"
"Flax fibre raw"
"Flax tow waste"
*END OF: The commod trees of the following are dealt with only later
$offtext;

*co-prod added by us - not in the data
"Tangerine pulp"."Tangerine Juice"
*co-prod added by us - not in the data
****CoprodMainProd not assigned: "Tomatojuice Concentrated"."Tomato pulp"
*co-prod added by us - not in the data
"Tung nut cake"."Tung Oil"

*MAIN-prod added by us - not in the data
"Bran, Oats"."Oat flour"
*MAIN-prod added by us - not in the data
"Cocoa Husks+Shell"."Cocoa paste"
"Palm oil"."Oil palm fruit pulp"

*THE FOLLOWING are the LEVEL2 co-products:

*the following has no coproducts
*"Rice, Broken"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
*the following has no coproducts
*"Rice Flour"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
"Rice Gluten"."Rice, Starch"
"Cake, rice bran"."Oil, rice bran"
"Cake, rice bran"."Ricebran Oil"
"Palmkernel Cake"."Palmkernel Oil"
"Cake, maize"."Maize Germ Oil"
"Copra Cake"."Coconut Oil"
"Groundnut Cake"."Groundnut Oil"
*co-prod added by us - not in the data
"Beer of Barley dregs"."Beer of barley"
*we assume powder to be main product, not cocoa butter
"Cocoa, butter"."Cocoa, powder & cake"
"Barley Flour And Grits"."Barley, pearled"
*co-prod added by us - not in the data
"Kapokseed shells"."Kapokseed shelled"
*"Macaroni"
"Cake, palm kernel"."Oil, palm kernel"
"Cake, maize"."Oil, maize"
*co-prod added by us - not in the data
"Pressed olive residues"."Oil, olive residues"
"Cake, groundnuts"."Oil, groundnut"
"Cake, copra"."Oil, coconut (copra)"
*the following has no coproducts
*"Prepared Groundnuts"
"Maize Gluten"."Starch Of Maize"
"Wheat Gluten"."Wheat Starch"
*MAIN-prod added by us - not in the data
"Cake, Palm Kernels"."Palm kernel oil"
*MAIN-prod added by us - not in the data
"Wheat Fermented Beverage"."Wheat dregs"

$ontext;
ADD THE NEEDED CoProd-MainProd-pairs later!! besides Molasse
*SET4
*"Alcohol, Non-Food"
"Alcoholic Beverages"."Dregs from brewing, distillation"
"Beverages, Alcoholic"."Dregs from brewing, distillation"
"Beverages, Fermented"."Dregs from brewing, distillation"
*LINKED below: sugars, etc. "Molasses"
*"Sugar & Sweeteners"
"Sugar (Raw Equivalent)"."Molasses"
"Sugar non-centrifugal"."Molasses"
*cf: 2541."Sugar non-centrifugal" resp. 163."Sugar non-centrifugal"
"Sugar, Raw Equivalent"."Molasses"
*this covers more in contrast to the other sugar elements: it is defined as follows:
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes,
*        162 Sugar Raw Centrifugal, 163 Sugar non-centrifugal, 166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose"
$offtext;
"Molasses"."Sugar, Refined Equiv"
"Molasses (sugar cane)"."Sugar, Refined Equiv (sugar cane)"
"Molasses (sugar beet)"."Sugar, Refined Equiv (sugar beet)"
$ontext;
*"Sweeteners, Other"
*This is 2543."Sweeteners, Other"
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes, 165 Molasses,
*        166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose, 175 Isoglucose, 633 Beverages, non alcoholic"
*"Beverages"
"Beverages, distilled alcoholic"."Dregs from brewing, distillation"
*"Beverages, fermented rice"
**TOO UNSPECIFIED - drop for now "Beverages, non alcoholic"
*"Beverages+Tobacco"
"Chocolate products nes"."Cocoa Husks+Shell"
**TOO UNIMPORTANT - drop for now "Cider etc"
*"Cigarettes"
*"Cigars, cheroots"
"Coffee, substitutes containing coffee"."Coffee, husks and skins"
*LINKED above "Dregs from brewing, distillation"
*"Feed and meal, gluten"
*this is the following: 846."Feed and meal, gluten"
*        "Generally, by-products of the wet milling of maize. Gluten feed consists of fibres, spent germ and steep liquor.
*        Gluten meal contains endosperm protein fractions that remain following starch recovery."
"Fixed Vegetable Oils"."Oil cakes - various"
*"Fructose and syrup, other"
*"Fruit, cooked, homogenized preparations"
*"Glucose and dextrose"
"Margarine, liquid"."Oil cakes - various"
"Margarine, short"."Oil cakes - various"
*"Oil, boiled etc"
*This is 1274."Oil, boiled etc": "Also includes oxidized and sulphurized oils. Animal and vegetable fats and oils whose chemical structure has been modified to improve viscosity, drying ability or other properties."
"Oil, essential nes"."Oil cakes - various"
"Sugar Raw Centrifugal"."Molasses"
"Sugar refined"."Molasses"
*"Alcohol Non Food Purpose"
*"Oils Hydrogenated"

*LINKED above: "Oil cakes - various"

*from NFP69
Seasoning."CoProds Seasoning"
$offtext;

*SET5
*"Animal Products"
*"Bovine Meat"
*        complex description in FAOSTAT - for simplicity, we take it identical to cattle meat and add it to the corresponding subset
"Milk, Skimmed"."Butter, Ghee"
"Whey"."Cheese"
****CoprodMainProd not assigned: "Cream"."Milk, Skimmed"
*"Eggs"
*        complex description in FAOSTAT - for simplicity, we take it identical to Chicken eggs and add it to the corresponding subset
*DO THIS LATER "Fish Meal"
*this is 2855."Fish Meal" and thus covers all seafood:
*        "Default composition: 1511 Freshwater Meal Fr Offal, 1524 Demersal Meal from Offal, 1537 Pelagic Meal from Offal, 1550 Marn Meal Of, 1559 Crustaceans Meal F Offal,
*        1567 Molluscs Meal from Offal, 1576 Cephalopods Meal F Offal, 1581 Aquatic Mammals Meals, 1584 Aqua Mammal Meal F Offal, 1591 Aq A Meal Of"
*"Fish, Body Oil"
*this is 2781."Fish, Body Oil" and thus covers fish and marine mammals
*        "Default composition: 1509 Frwt Bdy Oil, 1522 Dmrs Bdy Oil, 1535 Pelg Bdy Oil, 1548 Marn Bdy Oil, 1582 Aq M Oils"
*"Fish, Liver Oil"
*2782."Fish, Liver Oil" and thus covers fish and marine mammals
*        "Default composition: 1510 Frwt Lvr Oil, 1523 Demersal Liver Oils, 1536 Pelg Lvr Oil, 1549 Marine nes Liver Oils"
*"Hides and skins"
*"Meat Meal"
*LINKED above: "Milk, Skimmed"
*LINKED above: "Whey"
*"Animal Oil+Fat+Grs"
*"Animal Vegetable Oil"
*"Bacon and ham"
****CoprodMainProd not assigned: "Butter"."Milk, Skimmed"
"Milk, skimmed cow"."Butter, cow milk"
*DROP FOR NOW - not so important: "Buttermilk, curdled, acidified milk"
*"Canned Meat nes"
****CoprodMainProd not assigned: "Cheese and Curd"."Whey"
****CoprodMainProd not assigned: "Cheese, processed"."Whey"
****CoprodMainProd not assigned: "Cheese, sheep milk"."Whey"
****CoprodMainProd not assigned: "Cheese, whole cow milk"."Whey"
****CoprodMainProd not assigned: "Cream fresh"."Milk, Skimmed"
*"Eggs Liquid,Dried"
*DO THIS LATER "Eggs, dried"
*DO THIS LATER "Eggs, liquid"
*"Fat, liver prepared (foie gras)"
*This is needed to match 1060."Fat, liver prepared (foie gras)" with activities:
*        "Fatty livers of ducks and geese when cooked, prepared or preserved(e.g. pat‚)."
*"Fat, nes, prepared"
*"Fatty acids"
*"Fatty substance residues"
"Skim Milk Of Buffalo"."Ghee, of buffalo milk"
*"Grease incl. lanolin wool"
*"Lactose"
*"Lard"
*"Meal, meat"
*"Meat and Meat Preparations"
*"Meat Fresh+Ch+Frozen"
*"Meat Prepared Pres"
****CoprodMainProd not assigned: "Meat, beef and veal sausages"."Cattle Butcher Fat"
*"Meat, beef, preparations"
"Cattle Butcher Fat"."Meat, cattle, boneless (beef & veal)"
*"Meat, chicken, canned"
*"Meat, dried nes"
****CoprodMainProd not assigned: "Meat, pig sausages"."Pig Butcher Fat"
****CoprodMainProd not assigned: "Meat, pig, preparations"."Pig Butcher Fat"
"Pig Butcher Fat"."Meat, pork"
*DO THIS LATER "Milk Condensed + Evaporated"
*"Milk Condensed+Dry+Fresh"
*DO THIS LATER "Milk Dry"
*"Milk Equivalent"
*"Milk, products of natural constituents nes"
*"Milk, reconstituted"
*LINKED above "Milk, skimmed cow"
*DO THIS LATER "Milk, skimmed dried"
*DO THIS LATER "Milk, whole condensed"
*DO THIS LATER "Milk, whole dried"
*DO THIS LATER "Milk, whole evaporated"
*"Oils, fats of animal nes"
*DO THIS LATER "Whey, condensed"
*DO THIS LATER "Whey, dry"
*DO THIS LATER "Whey, Pres+Concen"
*"Wool, hair waste"
****CoprodMainProd not assigned: "Yoghurt, concentrated or not"."Water"
$ontext;
"Animals live nes"
"Asses"
"Beehives"
"Buffaloes"
"Camelids, other"
"Camels"
"Cattle"
"Chickens"
"Ducks"
"Goats"
"Horses"
"Mules"
"Pigs"
"Rabbits and hares"
"Rodents, other"
"Sheep"
"Turkeys"
"Beef Canned"
"Beef Dried Salt Smoked"
"Blood Meal"
$offtext;
****CoprodMainProd not assigned: "Butter Of Buffalo Milk"."Skim Milk Of Buffalo"
"Skim Milk Of Goat"."Butter Of Goat Milk"
"Skim Sheep Milk"."Butter+Ghee (Sheep Milk)"
*"Dry Buttermilk"
*"Casein"
****CoprodMainProd not assigned: "Cheese Of Buffalo Milk"."Whey"
****CoprodMainProd not assigned: "Cheese Of Goat Milk"."Whey"
****CoprodMainProd not assigned: "Cheese (Skim Cow Milk)"."Whey"
*"Game"
*"Geese"
*"Geese and guinea fowls"
****CoprodMainProd not assigned: "Ghee, of cow milk"."Milk, skimmed cow"
*"Whey Cheese"
*DO NOT NOW "Whey, Fresh"
*"Wool Shoddy"
****CoprodMainProd not assigned: "Yoghurt"."Water"
*the butcher fat is the co-product from meat, other fats are parts of the liveweight COMPLEMENTING meat and offals
*LINKED above "Cattle Butcher Fat"
*LINKED above "Pig Butcher Fat"

*"Fat, Poultry Rendered"
*"Lard And Stearine Oil"
*"Live Animals Nes"
*"Meat Extracts"
*"Meat Prepared Nes"
*"Oils Fish And Marine Mam"
*"Other birds for eggs"

*DROP FOR NOW - not important"Skim Milk, Condensed"
*"Skim Milk, Evaporated"
*LINKED above: "Skim Milk Of Buffalo"
*LINKED above: "Skim Milk Of Goat"
*LINKED above: "Skim Sheep Milk"

*from NFP69
****CoprodMainProd not assigned: 'Hard cheese'."Whey"
****CoprodMainProd not assigned: 'Semihard cheese'."Whey"
****CoprodMainProd not assigned: 'Soft cheese'."Whey"

/;


Set Match_MainProdAndCoProd_MainProdOnly(Commodities,Commodities_2)
*this is the mathcing file from above, but including the main products at first place only,
*this is used for main-product-based allocation.
/
*SET1
"Beer"."Dregs - beer"
**TOO UNSPECIFIED - drop for now "Brans"
**linked below "Bran, Cereals"
**linked below "Bran, Pulses"
**TOO UNSPECIFIED - drop for now "Cereals, Other"
*        "Default composition: 68 Popcorn, 89 Buckwheat, 90 Flour, buckwheat, 91 Bran, buckwheat, 92 Quinoa, 94 Fonio, 95 Flour, fonio, 96 Bran, fonio, 97 Triticale, 98 Flour, triticale, 99 Bran, triticale, 101 Canary seed, 103 Grain, mixed,
*        104 Flour, mixed grain, 105 Bran, mixed grains, 108 Cereals, nes, 111 Flour, cereals, 112 Bran, cereals nes, 113 Cereal preparations, nes"
**TOO UNSPECIFIED - drop for now "Citrus, Other"
*This is 2614."Citrus, Other": "Default composition: 512 Fruit, citrus nes, 513 Juice, citrus, single strength, 514 Juice, citrus, concentrated"
"Oilcrops Oil, Other"."Oilseed Cakes, Other"
*the specification for this is as follows:
*2586."Oilcrops Oil, Other"
*        "Default composition: 264 Butter of karite nuts, 266 Oil, castor beans, 276 Oil, tung nuts, 278 Oil, jojoba, 281 Oil, safflower, 297 Oil, poppy,
*        306 Vegetable tallow, 307 Oil, stillingia, 313 Oil, kapok, 334 Oil, linseed, 337 Oil, hempseed, 340 Oil, vegetable origin nes, 664 Cocoa, butter, 1241 Margarine, liquid, 1242 Margarine, short,
*        1273 Castor oil, hydrogenated (opal wax), 1274 Oil, boiled etc, 1275 Oil, hydrogenated"
**linked above "Oilseed Cakes, Other"
*the specification for this is as follows:
*2598."Oilseed Cakes, Other"
*        "Default composition: 37 Cake, rice bran, 61 Cake, maize, 282 Cake, safflower, 298 Cake, poppy seed, 314 Cake, kapok, 335 Cake, linseed, 338 Cake, hempseed, 341 Cake, oilseeds nes"
**linked below "Rape and Mustard Cake"
"Rape and Mustard Oil"."Rape and Mustard Cake"
*"Bread"
*"Feed, pulp of fruit"
*"Feed, vegetable products nes"
"Flour, cereals"."Bran, Cereals"
"Flour, pulses"."Bran, Pulses"
**TOO UNSPECIFIED - drop for now "Flour, roots and tubers nes"
*"Fruit, dried nes"
*"Fruit, prepared nes"
"Juice, citrus, concentrated"."Citrus pulp"
"Juice, citrus, single strength"."Citrus pulp"
"Juice, fruit nes"."Fruit pulp"
*"Nuts, prepared (exc. groundnuts)"
"Oilcrops Oil, Other"."Oilseed Cake Meal"
"Oilcrops Oil, Other"."Oilseed Cake nes"
"Rape+Mustard Oils"."Rape and Mustard Cake"
*"Straw husks"
*"Vegetables in vinegar"
*"Vegetables, canned nes"
*"Vegetables, dehydrated"
*"Vegetables, dried nes"
**TOO UNSPECIFIED - drop for now "Vegetables, fresh nes"
*"Vegetables, fresh or dried products nes"
*"Vegetables, frozen"
*"Vegetables, homogenized preparations"
*"Vegetables, preserved nes"
*"Vegetables, preserved, frozen"
*"Vegetables, temporarily preserved"
*"Breakfast Cereals"
**TOO UNSPECIFIED - drop for now "Flour, Fruit"
**TOO UNSPECIFIED - drop for now "Flour/Meal Of Oilseeds"
*"Fruit Tropical Dried Nes"
*"Nuts, all, shelled"
*"Roots And Tubers Dried"
"Flour, mixed grain"."Brans, mixed grain"

*SET3
*co-prod added by us - not in the data
"Rice, Husked"."Rice hulls"
"Kapokseed in shell"."Kapok fibre"
*cotton linter is not included on the level of these terms (it is for "oil, cottonseed" and "cake, cottonseed")
"Palm Oil"."Palm kernels"
"Wine"."Marc of Grapes"
"Sesameseed Oil"."Sesameseed Cake"
*this may cover olive oil virgin and from residues - then the co-product is residues and pressed resides, the latter not being covered in the system
"Olive Oil"."Olive Residues"
*co-prod added by us - not in the data
"Groundnuts (Shelled Eq)"."Groundnut shells"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Soyabean Cake"."Soyabean Oil"
"Sunflowerseed Oil"."Sunflowerseed Cake"
*co-prod added by us - not in the data
"Beer of sorghum"."Beer of Shorgum dregs"
*no co-products, thus dropped here
*"Bulgur"
*co-prod added by us - not in the data
"Cocoa, paste"."Cocoa husks"
*unimportant, leave out for now
*"Coffee, extracts"
"Coffee, roasted"."Coffee, husks and skins"
*co-prod added by us - not in the data
"Butter of karite nuts"."Karite nut cake"
*co-prod added by us - not in the data
"Brazil nuts, shelled"."Brazil nut shells"
*no coprod, thus dropped here
*"Alfalfa meal and pellets"
*co-prod added by us - not in the data
"Cashew nuts, shelled"."Cashew nut shells"
*co-prod added by us - not in the data
Chestnut."Chestnut shells"
*co-prod added by us - not in the data
"Coconuts, desiccated"."Coconut shells"
*co-prod added by us - not in the data
"Copra"."Coconut shells"
*no coprod, thus dropped here
*"Cassava dried"
"Almonds shelled"."Almond shells"
"Apricots, dry"."Apricot kernel"
*Soyabean cake is the MAIN PROD - for animal feed, Oil of soybeans is seen as the CO-product!!
"Cake, soybeans"."Oil, soybean"
*PROPOSAL
*"Oil, soybean"."Cake, soybeans"
*"Bran, wheat"."Flour, wheat"

*no coprod, thus dropped here
*"Flour, mustard"
*no coprod, thus dropped here
*"Flour, potatoes"
"Flour, fonio"."Bran, fonio"
"Flour, mixed grain"."Bran, Mixed Grain"
"Flour, wheat"."Bran, wheat"
*no coprod, thus dropped here
*"Figs dried"
*for all the juices below: co-prod added by us - not in the data
"Juice, tomato"."Tomato pulp"
"Juice, grape"."Grape pulp"
"Juice, grapefruit"."Grapefruit pulp"
"Juice, grapefruit, concentrated"."Grapefruit pulp"
"Juice, lemon, concentrated"."Lemon pulp"
"Juice, orange, concentrated"."Orange pulp"
"Juice, orange, single strength"."Orange pulp"
"Juice, pineapple"."Pineapple pulp"
"Juice, pineapple, concentrated"."Pineapple pulp"
"Juice, plum, concentrated"."Plum pulp"
"Juice, plum, single strength"."Plum pulp"
*co-prod added by us - not in the data
"Hazelnuts, shelled"."Hazelnut shells"
*may not use this total but the next
*"Groundnuts Total Shelled"
"Groundnuts, shelled"."Groundnut shells"
*no coprod, thus dropped here
*"Malt"
*no coprod, thus dropped here
*"Mushrooms, canned"
*co-prod added by us - not in the data
"Oil, palm"."Palm kernels"
"Oil, linseed"."Cake, linseed"
"Oil, rapeseed"."Cake, rapeseed"
"Oil, safflower"."Cake, safflower"
"Oil, sesame"."Cake, sesame seed"
"Oil, poppy"."Cake Of Poppy Seed"
"Oil, sunflower"."Cake, sunflower"
"Oil, olive, virgin"."Olive residues"
*the following is likely the sum of olive oil virgin plus oil, olive residues
*"Olive Oil,Total"
*co-prod added by us - not in the data
"Oil, castor beans"."Castor bean cake"
*coproducts oat offals and hulls not in the data - drop for now
*"Oats rolled".OAT OFFALS.HULLS
*no coprod, thus dropped here
*"Peanut butter"
*coproducts juice and pulp - but not in the data - just take "Pineapple pulp"
"Pineapples canned"."Pineapple pulp"
*no coprod, thus dropped here
*"Plums dried (prunes)"
"Potatoes, frozen"."Potato offals"
*unimportant
*"Pyrethrum, extraction"
*no coprod, thus dropped here
*"Raisins"
*no coprod, thus dropped here
*"Soya curd"
*no coprod, thus dropped here
*"Soya paste"
*no coprod, thus dropped here
*"Soya sauce"
*no coprod, thus dropped here
*"Sweet corn frozen"
*no coprod, thus dropped here
*"Sweet corn prep or preserved"
*no coprod, thus dropped here
*"Tea, mate extracts"
*no coprod, thus dropped here
*"Starch, cassava"
*co-prod added by us - not in the data
"Walnuts, shelled"."Walnut shells"
*co-prod added by us - not in the data
"Tomatoes, paste"."Tomato pulp"
*co-prod added by us - not in the data
"Tomatoes, peeled"."Tomato pulp"
*co-prod added by us - not in the data
"Applejuice Single Streng"."Apple pulp"
"Applejuice Concentrated"."Apple pulp"
*no coprod, thus dropped here
*"Cassava Tapioca"
*no coprod, thus dropped here
*"Flour, Cassava"
"Flour, Sorghum"."Bran, sorghum"
"Flour, Triticale"."Bran, Triticale"
*buckwheat also has hulls - but we leave them away as they are neither in the data
"Flour, Buckwheat"."Bran, buckwheat"
"Flour, Millet"."Bran, millet"
"Flour, Rye"."Bran, Rye"
*co-prod added by us - not in the data
"Jojoba Oil"."Jojoba cake"
*unimportant
*"Leaves And Tops, Vines"
"Lemonjuice Single-Streng"."Lemon pulp"
"Mango Juice"."Mango Pulp"
*no coprod, thus dropped here
*"Dried Mushrooms"
"Must Of Grapes"."Marc Of Grapes"
"Oil, Hempseed"."Cake, hempseed"
"Oil, Mustard Seed"."Cake, mustard"
*Barley also has hulls - but we leave them away as they are neither in the data
"Pot Barley"."Bran, Barley"
*no coprod, thus dropped here
*"Plums, Dried (Prunes)"
*no coprod, thus dropped here
*"Potato Starch"
*no coprod, thus dropped here
*"Potato Tapioca"
*unimportant
*"Pyrethrum Marc"

$ontext;
*The commod trees of the following are dealt with only later
*this is third level
"Cake, kapok"
"Oil, kapok"

"Cane tops"
"Cashewapple"
"Cocoons, unreelable & waste"
"Maple sugar and syrups"
"Pastry"
"Popcorn"
"Rubber natural dry"
"Silk raw"
"Silk-worm cocoons, reelable"
"Vegetable tallow"
"Tobacco products nes"
"Wheat+Flour,Wheat Equivalent"
"Beet Tops"
"Malt Extracts"
*this is a by-product of coconuts, not covered in the commodity trees
"Coir"
*this is a by-product of hempseed, not covered in the commodity trees
"Hemp Fibre And Tow"

"Flax Fib+Tow+W"
"Flax fibre and tow"
"Flax fibre raw"
"Flax tow waste"
*END OF: The commod trees of the following are dealt with only later
$offtext;

*co-prod added by us - not in the data
"Tangerine Juice"."Tangerine pulp"
*co-prod added by us - not in the data
"Tomatojuice Concentrated"."Tomato pulp"
*co-prod added by us - not in the data
"Tung Oil"."Tung nut cake"

*MAIN-prod added by us - not in the data
"Oat flour"."Bran, Oats"
*MAIN-prod added by us - not in the data
"Cocoa paste"."Cocoa Husks+Shell"
"Oil palm fruit pulp"."Palm oil"

*THE FOLLOWING are the LEVEL2 co-products:

*the following has no coproducts
*"Rice, Broken"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
*the following has no coproducts
*"Rice Flour"
*this is third level derived from "rice, broken" - but we add it here for simplicity, we then just combine the third level extraction rates into the second level
"Rice, Starch"."Rice Gluten"
"Oil, rice bran"."Cake, rice bran"
"Ricebran Oil"."Cake, rice bran"
"Palmkernel Oil"."Palmkernel Cake"
"Maize Germ Oil"."Cake, maize"
"Coconut Oil"."Copra Cake"
"Groundnut Oil"."Groundnut Cake"
*co-prod added by us - not in the data
"Beer of barley"."Beer of Barley dregs"
*we assume powder to be main product, not cocoa butter
"Cocoa, powder & cake"."Cocoa, butter"
"Barley, pearled"."Barley Flour And Grits"
*co-prod added by us - not in the data
"Kapokseed shelled"."Kapokseed shells"
*"Macaroni"
"Oil, palm kernel"."Cake, palm kernel"
"Oil, maize"."Cake, maize"
*co-prod added by us - not in the data
"Oil, olive residues"."Pressed olive residues"
"Oil, groundnut"."Cake, groundnuts"
"Oil, coconut (copra)"."Cake, copra"
*the following has no coproducts
*"Prepared Groundnuts"
"Starch Of Maize"."Maize Gluten"
"Wheat Starch"."Wheat Gluten"
*MAIN-prod added by us - not in the data
"Palm kernel oil"."Cake, Palm Kernels"
*MAIN-prod added by us - not in the data
"Wheat dregs"."Wheat Fermented Beverage"

*SET4
*"Alcohol, Non-Food"
"Alcoholic Beverages"."Dregs from brewing, distillation"
"Beverages, Alcoholic"."Dregs from brewing, distillation"
"Beverages, Fermented"."Dregs from brewing, distillation"
*LINKED below: sugars, etc. "Molasses"
*"Sugar & Sweeteners"
"Sugar (Raw Equivalent)"."Molasses"
"Sugar non-centrifugal"."Molasses"
*cf: 2541."Sugar non-centrifugal" resp. 163."Sugar non-centrifugal"
"Sugar, Raw Equivalent"."Molasses"
*this covers more in contrast to the other sugar elements: it is defined as follows:
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes,
*        162 Sugar Raw Centrifugal, 163 Sugar non-centrifugal, 166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose"
"Sugar, Refined Equiv"."Molasses"
"Sugar, Refined Equiv (sugar cane)"."Molasses (sugar cane)"
"Sugar, Refined Equiv (sugar beet)"."Molasses (sugar beet)"
*"Sweeteners, Other"
*This is 2543."Sweeteners, Other"
*        "Default composition: 154 Fructose chemically pure, 155 Maltose chemically pure, 160 Maple sugar and syrups, 161 Sugar crops, nes, 165 Molasses,
*        166 Fructose and syrup, other, 167 Sugar, nes, 172 Glucose and dextrose, 173 Lactose, 175 Isoglucose, 633 Beverages, non alcoholic"
*"Beverages"
"Beverages, distilled alcoholic"."Dregs from brewing, distillation"
*"Beverages, fermented rice"
**TOO UNSPECIFIED - drop for now "Beverages, non alcoholic"
*"Beverages+Tobacco"
"Chocolate products nes"."Cocoa Husks+Shell"
**TOO UNIMPORTANT - drop for now "Cider etc"
*"Cigarettes"
*"Cigars, cheroots"
"Coffee, substitutes containing coffee"."Coffee, husks and skins"
*LINKED above "Dregs from brewing, distillation"
*"Feed and meal, gluten"
*this is the following: 846."Feed and meal, gluten"
*        "Generally, by-products of the wet milling of maize. Gluten feed consists of fibres, spent germ and steep liquor.
*        Gluten meal contains endosperm protein fractions that remain following starch recovery."
"Fixed Vegetable Oils"."Oil cakes - various"
*"Fructose and syrup, other"
*"Fruit, cooked, homogenized preparations"
*"Glucose and dextrose"
"Margarine, liquid"."Oil cakes - various"
"Margarine, short"."Oil cakes - various"
*"Oil, boiled etc"
*This is 1274."Oil, boiled etc": "Also includes oxidized and sulphurized oils. Animal and vegetable fats and oils whose chemical structure has been modified to improve viscosity, drying ability or other properties."
"Oil, essential nes"."Oil cakes - various"
"Sugar Raw Centrifugal"."Molasses"
"Sugar refined"."Molasses"
*"Alcohol Non Food Purpose"
*"Oils Hydrogenated"

*LINKED above: "Oil cakes - various"

*from NFP69
Seasoning."CoProds Seasoning"


*SET5
*"Animal Products"
*"Bovine Meat"
*        complex description in FAOSTAT - for simplicity, we take it identical to cattle meat and add it to the corresponding subset
"Butter, Ghee"."Milk, Skimmed"
"Cheese"."Whey"
"Cream"."Milk, Skimmed"
*"Eggs"
*        complex description in FAOSTAT - for simplicity, we take it identical to Chicken eggs and add it to the corresponding subset
*DO THIS LATER "Fish Meal"
*this is 2855."Fish Meal" and thus covers all seafood:
*        "Default composition: 1511 Freshwater Meal Fr Offal, 1524 Demersal Meal from Offal, 1537 Pelagic Meal from Offal, 1550 Marn Meal Of, 1559 Crustaceans Meal F Offal,
*        1567 Molluscs Meal from Offal, 1576 Cephalopods Meal F Offal, 1581 Aquatic Mammals Meals, 1584 Aqua Mammal Meal F Offal, 1591 Aq A Meal Of"
*"Fish, Body Oil"
*this is 2781."Fish, Body Oil" and thus covers fish and marine mammals
*        "Default composition: 1509 Frwt Bdy Oil, 1522 Dmrs Bdy Oil, 1535 Pelg Bdy Oil, 1548 Marn Bdy Oil, 1582 Aq M Oils"
*"Fish, Liver Oil"
*2782."Fish, Liver Oil" and thus covers fish and marine mammals
*        "Default composition: 1510 Frwt Lvr Oil, 1523 Demersal Liver Oils, 1536 Pelg Lvr Oil, 1549 Marine nes Liver Oils"
*"Hides and skins"
*"Meat Meal"
*LINKED above: "Milk, Skimmed"
*LINKED above: "Whey"
*"Animal Oil+Fat+Grs"
*"Animal Vegetable Oil"
*"Bacon and ham"
"Butter"."Milk, Skimmed"
"Butter, cow milk"."Milk, skimmed cow"
*DROP FOR NOW - not so important: "Buttermilk, curdled, acidified milk"
*"Canned Meat nes"
"Cheese and Curd"."Whey"
"Cheese, processed"."Whey"
"Cheese, sheep milk"."Whey"
"Cheese, whole cow milk"."Whey"
"Cream fresh"."Milk, Skimmed"
*"Eggs Liquid,Dried"
*DO THIS LATER "Eggs, dried"
*DO THIS LATER "Eggs, liquid"
*"Fat, liver prepared (foie gras)"
*This is needed to match 1060."Fat, liver prepared (foie gras)" with activities:
*        "Fatty livers of ducks and geese when cooked, prepared or preserved(e.g. pat‚)."
*"Fat, nes, prepared"
*"Fatty acids"
*"Fatty substance residues"
"Ghee, of buffalo milk"."Skim Milk Of Buffalo"
*"Grease incl. lanolin wool"
*"Lactose"
*"Lard"
*"Meal, meat"
*"Meat and Meat Preparations"
*"Meat Fresh+Ch+Frozen"
*"Meat Prepared Pres"
"Meat, beef and veal sausages"."Cattle Butcher Fat"
*"Meat, beef, preparations"
"Meat, cattle, boneless (beef & veal)"."Cattle Butcher Fat"
*"Meat, chicken, canned"
*"Meat, dried nes"
"Meat, pig sausages"."Pig Butcher Fat"
"Meat, pig, preparations"."Pig Butcher Fat"
"Meat, pork"."Pig Butcher Fat"
*DO THIS LATER "Milk Condensed + Evaporated"
*"Milk Condensed+Dry+Fresh"
*DO THIS LATER "Milk Dry"
*"Milk Equivalent"
*"Milk, products of natural constituents nes"
*"Milk, reconstituted"
*LINKED above "Milk, skimmed cow"
*DO THIS LATER "Milk, skimmed dried"
*DO THIS LATER "Milk, whole condensed"
*DO THIS LATER "Milk, whole dried"
*DO THIS LATER "Milk, whole evaporated"
*"Oils, fats of animal nes"
*DO THIS LATER "Whey, condensed"
*DO THIS LATER "Whey, dry"
*DO THIS LATER "Whey, Pres+Concen"
*"Wool, hair waste"
"Yoghurt, concentrated or not"."Water"
$ontext;
"Animals live nes"
"Asses"
"Beehives"
"Buffaloes"
"Camelids, other"
"Camels"
"Cattle"
"Chickens"
"Ducks"
"Goats"
"Horses"
"Mules"
"Pigs"
"Rabbits and hares"
"Rodents, other"
"Sheep"
"Turkeys"
"Beef Canned"
"Beef Dried Salt Smoked"
"Blood Meal"
$offtext;
"Butter Of Buffalo Milk"."Skim Milk Of Buffalo"
"Butter Of Goat Milk"."Skim Milk Of Goat"
"Butter+Ghee (Sheep Milk)"."Skim Sheep Milk"
*"Dry Buttermilk"
*"Casein"
"Cheese Of Buffalo Milk"."Whey"
"Cheese Of Goat Milk"."Whey"
"Cheese (Skim Cow Milk)"."Whey"
*"Game"
*"Geese"
*"Geese and guinea fowls"
"Ghee, of cow milk"."Milk, skimmed cow"
*"Whey Cheese"
*DO NOT NOW "Whey, Fresh"
*"Wool Shoddy"
"Yoghurt"."Water"
*the butcher fat is the co-product from meat, other fats are parts of the liveweight COMPLEMENTING meat and offals
*LINKED above "Cattle Butcher Fat"
*LINKED above "Pig Butcher Fat"

*"Fat, Poultry Rendered"
*"Lard And Stearine Oil"
*"Live Animals Nes"
*"Meat Extracts"
*"Meat Prepared Nes"
*"Oils Fish And Marine Mam"
*"Other birds for eggs"

*DROP FOR NOW - not important"Skim Milk, Condensed"
*"Skim Milk, Evaporated"
*LINKED above: "Skim Milk Of Buffalo"
*LINKED above: "Skim Milk Of Goat"
*LINKED above: "Skim Sheep Milk"

*from NFP69
'Hard cheese'."Whey"
'Semihard cheese'."Whey"
'Soft cheese'."Whey"

/;




