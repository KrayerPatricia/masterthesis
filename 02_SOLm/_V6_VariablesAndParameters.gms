PUTCLOSE con,"_V6_VariablesAndParameters";

$ontext;
GENERAL DESCRIPTION
This file declares the key parameters and variables needed in SOLmV6

Detailed explanation of the structure:
the first basis of the model version V6 are activity units, i.e.
         - the activities undertaken on a unit of agricultural land (hectare), with all the related inputs (e.g. seed), outputs (e.g. wheat grain) and other characteristics (e.g. risk to lead to deforestation)
         - the activities undertaken to produce animal source food, framed in relation to one animal production unit, with all the related inputs (e.g. feed), outputs (e.g. milk) and other characteristics (e.g. risk to lead to antibiotic resistances)
           - the activities undertaken to produce animal source food, framed in relation to SINGLE ANIMALS as constituents of an animal production unit, with all the related inputs, outputs and other characteristics
         - the activities undertaken to produce fish and seafood, with "ton unprocessed fish/seafood biomass output" as the basic unit, , with all the related inputs (e.g. fuel energy), outputs (e.g. fish quantity) and other characteristics (e.g. seabed destruction)
         - the activities undertaken on a unit of forest land (hectare), with all the related inputs (e.g. seedlings), outputs (e.g. wood) and other characteristics (e.g. biodiversity loss)
         - any other activities - to be specified (could be used to capture insects, algae, vertical farming, cultured meat, etc.)

thereby,
         - activities are any action that produces outputs from inputs, characterised by the above options: crops, animals, fish/seafood, forests, and other
         - inputs are all mass/nutrient flows that are used when undertaking the activity
         - outputs are all mass/nutrient flows that result from the activity
         - other characteristics are all characteristics of the activity being undertaken that cannot be captured well by mass/nutrient flows; this can be the biodiversity loss or seabed destruction mentioned above, but also monetary flows, etc.

All these inputs, outputs and characteristics are displayed as parameters per unit activity, or, for animals, also per head.
Multiplication by the variable "quantity of activity units" then results in variables of input, output and characteristics quantities.

In this, we differentiate the sets inputs, outputs and other characteristics according to these fundamentally different activities as well (crops, animals, fish/seafood, forests, other).
But we keep one set activities, as we may later want to have agroforestry activities with crops AND animals included, etc.


Part of the outputs are then commodities (e.g. MainOutput1 from wheat is "Wheat grains" (or "Wheat") as commodities
This is captured in the second basis of the model version V6, the commodity units:

These capture the specific outputs from the activities that are termed "commodities" and their nutrient contents and, where relevant, other characteristics (such as energy use for production, e.g. for Wheat flour from wheat grains), on a per ton basis
Here, the differentiation between crops, animals, etc. is not used anymore
All these contents and characteristics are displayed as parameters per ton commodity.
Multiplication by the variable "quantity of commodity" then results in variables of content and characteristics quantities.

Various commodities are related between each other via the commodity trees. This results in two further parameters: the Production shares - i.e. how much of wheat grain goes into wheat flour, how much into wheat beer, etc.; and
                                                                                                                    the extraction rate, - i.e. how much wheat flour can be produced from one ton of wheat grain
DETAILED TABLE OF CONTENTS
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
         2.6) Commodity utilizations
         2.7) Crop residue quantities, nutrient contained, other characteristics and management
         2.8) Feeding rations quantities
         2.9) Manure quantities, nutrients contained, other characteristics and management
         2.10) Fertilizer application: nutrients and other characteristics
         2.11) Import and export quantities
         2.12) Commodities expressed in primary product equivalents
- 3) Auxiliary parameters
- 4) Auxiliary variables

$offtext;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Main parameters

Parameters

*1.1) Activities: input parameters
ActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions)                inputs to the crop and grass activities undertaken on a unit of agricultural land  - UNIT: input per hectare
ActAnimalsAPU_Inputs(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions)                   inputs to the animal activities undertaken to produce animal source food           - UNIT: input per Animal Production Unit
ActAnimalsHead_Inputs(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions) inputs to the animal activities undertaken to produce animal source food           - UNIT: input per Animal Head
ActFishSeafood_Inputs(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions)              inputs to the fish and seafood activities                                          - UNIT: input per ton unprocessed fish or seafood biomass output
ActForest_Inputs(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions)                        inputs to the forest activities undertaken on a unit of forest land                - UNIT: input per hectare
ActOthers_Inputs(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions)                         inputs to any other activities undertaken                                          - UNIT: to be specified - default: input per ton unprocessed main biomass output

*1.2) Activities: output parameters
ActCropsGrass_Outputs(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions)                outputs from the crop and grass activities undertaken on a unit of agricultural land  - UNIT: output per hectare
ActAnimalsAPU_Outputs(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions)                   outputs from the animal activities undertaken to produce animal source food           - UNIT: output per Animal Production Unit
ActAnimalsHead_Outputs(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions) outputs from the animal activities undertaken to produce animal source food           - UNIT: output per Animal Head
ActFishSeafood_Outputs(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions)              outputs from the fish and seafood activities                                          - UNIT: output per ton unprocessed fish or seafood biomass output
ActForest_Outputs(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions)                        outputs from the forest activities undertaken on a unit of forest land                - UNIT: output per hectare
ActOthers_Outputs(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions)                         outputs from any other activities undertaken                                          - UNIT: to be specified - default: output per ton unprocessed main biomass output

*1.3) Activities: other characteristics
ActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions)                other characteristics of the crop and grass activities undertaken on a unit of agricultural land  - UNIT: OtherChar per hectare or ton etc.
ActAnimalsAPU_OtherChar(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions)                   other characteristics of the animal activities undertaken to produce animal source food           - UNIT: OtherChar per Animal Production Unit
ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions) other characteristics of the animal activities undertaken to produce animal source food           - UNIT: OtherChar per Animal Head
ActFishSeafood_OtherChar(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions)              other characteristics of the fish and seafood activities                                          - UNIT: OtherChar per ton unprocessed fish or seafood biomass output
ActForest_OtherChar(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions)                        other characteristics of the forest activities undertaken on a unit of forest land                - UNIT: OtherChar per hectare or ton etc.
ActOthers_OtherChar(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions)                         other characteristics of any other activities undertaken                                          - UNIT: to be specified - default: OtherChar per ton unprocessed main biomass output

*1.4) Commodities: nutrient contents and other characteristics
Commod_Contents(Regions,Commodities,Contents,ProductionSystems,ProductionConditions)         nutrient contents of commodities     - UNIT: units nutrient per ton commodity
Commod_OtherChar(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions) other characteristics of commodities - UNIT: OtherChar per ton commodity

*1.5) Commodity tree parameters
Commod_ProductionShare(Regions,Commodities,Commodities_2,ProductionSystems)                production share of different commodities from the same higher level commodity in the commodity tree - UNIT: share (i.e. percentage divided by 100)
Commod_ExtractionRate(Regions,Commodities,Commodities_2,ProductionSystems)                 extraction rate of a commodity from its higher level source commodity                                - UNIT: share (i.e. percentage divided by 100)
*and define a parameter that captures how aggregate commodities are disaggregated into primary activities (e.g. "Bread" comes from "All Cereals" and those have to be disaggregated to "Wheat", "Rye", etc.)
*assumptions on this are often very shaky and for now, much is determined by expert guess from Adrian Muller from August 2019 -
*        or where sensible, it is allocated according to the relative shares of single commodities in the aggregate, if this information is available
Commod_SingleInAggregateCommodShares(Regions,Commodities,Commodities_2,ProductionSystems)  Share of single commodities in aggregate commodities - UNIT: share (i.e. percentage divided by 100)

*1.6) Crop residues: nutrient contents, other characteristics and management
CropResidues_Contents(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions)                      nutrient contents of crop residues     - UNIT: units nutrient per ton crop residues
CropResidues_OtherChar(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions)                    other characteristics of crop residues - UNIT: OtherChar per ton crop residues
CropResidues_Management(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions) values related to crop residues management  - UNIT: units management values per ton crop residues

*1.7) Feeding rations
FeedingRations_Contents(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions)                         "nutrient contents of feed/Feeding rations     - UNIT: units nutrient per ton feed"
FeedingRations_OtherChar(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions)          "other characteristics of feed/Feeding rations - UNIT: other characteristics per ton feed"
FeedingRationsHeads_Contents(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions)                    "nutrient contents of feed/Feeding rations     - UNIT: units nutrient per animal head"
FeedingRationsHeads_OtherChar(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions)     "other characteristics of feed/Feeding rations - UNIT: other characteristics per animal head"
FeedingRationsAPU_Contents(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions)                      "nutrient contents of feed/Feeding rations     - UNIT: units nutrient per APU"

*1.8) Manure: nutrient contents, other characteristics and management
Manure_Contents(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions)                                  nutrient contents of manure         - UNIT: units nutrient per ton manure
Manure_OtherChar(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions)                                other characteristics of manure     - UNIT: OtherChar per ton manure
Manure_Management(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions) values related to manure management - UNIT: units management values per t manure TS DM if not indicated otherwise

*1.9) Fertilizer application: nutrients and other characteristics
*below: Activities_2 is Livestock plus also aggregates thereof, therefore the set Livestock is not enough and it needs to be activities
ManureApplication(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions)  "Characteristics of manure application to activities; Livestock/AnimalTypeInHerd captures the source of manure - UNIT: Char per ton manure/nutrient"
CropResAndBiomassApplication(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions)      "Characteristics of crop residue and other crop biomass application to activities; commodities captures the source of crop residue (other biomass - UNIT: Characteristics per ton crop res/nutrient"
MinFertApplication(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions)      "Characteristics of min fert application to activities; MineralFertilizerType captures the source of min fert - UNIT: Char per ton min fert/nutrient"

*1.10) Extraction rates
ExtractionRate_CommodityTree(Regions,Commodities) Extraction rates of commodities from their source products (e.g. 0.75 for "wheat flour" from "wheat grains") - UNIT: ratio (i.e. percentage divided by 100)
;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Main variables

Variables
*2.1) Amount of activity units
VActCropsGrass_QuantityActUnits(Regions,Activities,ProductionSystems,ProductionConditions)                   total amount of activity units - UNIT: Number of hectares
VActAnimalsAPU_QuantityActUnits(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions)                   total amount of activity units - UNIT: Number of Animal Production Units (APUs)
VActAnimalsHead_QuantityActUnits(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions) total amount of activity units - UNIT: Number of animal heads
VActFishSeafood_QuantityActUnits(Regions,Activities,ProductionSystems,ProductionConditions)                  total amount of activity units - UNIT: Tons of unprocessed fish or seafood
VActForest_QuantityActUnits(Regions,Activities,ProductionSystems,ProductionConditions)                       total amount of activity units - UNIT: Number of hectares
VActOthers_QuantityActUnits(Regions,Activities,ProductionSystems,ProductionConditions)                       total amount of activity units - UNIT: to be specified - default: tons of unprocessed main biomass output

*2.2) Inputs to activities
VActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions)                total inputs to the crop and grass activities undertaken on agricultural land  - UNIT: total input
VActAnimalsAPU_Inputs(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions)                   total inputs to the animal activities undertaken to produce animal source food - UNIT: total input
VActAnimalsHead_Inputs(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions) total inputs to the animal activities undertaken to produce animal source food - UNIT: total input
VActFishSeafood_Inputs(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions)              total inputs to the fish and seafood activities                                - UNIT: total input
VActForest_Inputs(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions)                        total inputs to the forest activities undertaken on a unit of forest land      - UNIT: total input
VActOthers_Inputs(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions)                         total inputs to any other activities undertaken                                - UNIT: total input

*2.3) Outputs from activities
VActCropsGrass_Outputs(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions)                total outputs from the crop and grass activities undertaken on agricultural land  - UNIT: total output
VActAnimalsAPU_Outputs(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions)                   total outputs from the animal activities undertaken to produce animal source food - UNIT: total output
VActAnimalsHead_Outputs(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions) total outputs from the animal activities undertaken to produce animal source food - UNIT: total output
VActFishSeafood_Outputs(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions)              total outputs from the fish and seafood activities                                - UNIT: total output
VActForest_Outputs(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions)                        total outputs from the forest activities undertaken on a unit of forest land      - UNIT: total output
VActOthers_Outputs(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions)                         total outputs from any other activities undertaken                                - UNIT: total output

*2.4) Other characteristics of activities
VActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions)                total other characteristics of the crop and grass activities undertaken on agricultural land  - UNIT: total OtherChar
VActAnimalsAPU_OtherChar(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions)                   total other characteristics of the animal activities undertaken to produce animal source food - UNIT: total OtherChar
VActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions) total other characteristics of the animal activities undertaken to produce animal source food - UNIT: total OtherChar
VActFishSeafood_OtherChar(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions)              total other characteristics of the fish and seafood activities                                - UNIT: total OtherChar
VActForest_OtherChar(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions)                        total other characteristics of the forest activities undertaken on a unit of forest land      - UNIT: total OtherChar
VActOthers_OtherChar(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions)                         total other characteristics of any other activities undertaken                                - UNIT: total OtherChar


*2.5) Commodity quantities, nutrient contained and other characteristics
VCommod_Quantity(Regions,Commodities,ProductionSystems,ProductionConditions)                  total (domestically available) commodity quantity (DAQ) - UNIT: tons
VCommod_Contents(Regions,Commodities,Contents,ProductionSystems,ProductionConditions)         total nutrient contents of commodities                  - UNIT: total units nutrient
VCommod_OtherChar(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions) total other characteristics of commodities              - UNIT: total units OtherChar

*2.6) Commodity utilizations
VCommod_Production(Regions,Commodities,ProductionSystems,ProductionConditions)   total quantity of commodity production          - UNIT: tons
VCommod_StockChanges(Regions,Commodities,ProductionSystems,ProductionConditions) total quantity of commodity stock changes       - UNIT: tons
VCommod_Food(Regions,Commodities,ProductionSystems,ProductionConditions)         total quantity of commodity used for food       - UNIT: tons
VCommod_Feed(Regions,Commodities,ProductionSystems,ProductionConditions)         total quantity of commodity used for feed       - UNIT: tons
VCommod_Seed(Regions,Commodities,ProductionSystems,ProductionConditions)         total quantity of commodity used for seed       - UNIT: tons
VCommod_Processing(Regions,Commodities,ProductionSystems,ProductionConditions)   total quantity of commodity used for processing - UNIT: tons
VCommod_Waste(Regions,Commodities,ProductionSystems,ProductionConditions)        total quantity of commodity lost or wasted      - UNIT: tons
VCommod_Other(Regions,Commodities,ProductionSystems,ProductionConditions)        total quantity of commodity used for other uses - UNIT: tons
*for some, we also are interested in contents and other characteristics of these commodity utilizations:
VCommod_Food_Contents(Regions,Commodities,Contents,ProductionSystems,ProductionConditions)          total nutrient contents of commodity used for food       - UNIT: total units nutrient
VCommod_Feed_Contents(Regions,Commodities,Contents,ProductionSystems,ProductionConditions)          total nutrient contents of commodity used for feed       - UNIT: total units nutrient
VCommod_Waste_Contents(Regions,Commodities,Contents,ProductionSystems,ProductionConditions)         total nutrient contents of commodity lost or wasted      - UNIT: total units nutrient
VCommod_Food_OtherChar(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions)  total other characteristics of commodity used for food   - UNIT: total units OtherChar
VCommod_Feed_OtherChar(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions)  total other characteristics of commodity used for feed   - UNIT: total units OtherChar
VCommod_Waste_OtherChar(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions) total other characteristics of commodity lost or wasted  - UNIT: total units OtherChar

*2.7) Crop residue quantities, nutrient contained, other characteristics and management
VCropResidues_Quantity(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions)                                      total crop residue quantity                   - UNIT: tons
VCropResidues_Contents(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions)                      total nutrient contents of crop residues      - UNIT: total units nutrient
VCropResidues_OtherChar(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions)                    total other characteristics of crop residues  - UNIT: total units OtherChar
VCropResidues_Management(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions) total values related to crop residues management  - UNIT: total units management values

*2.8) Feeding rations quantities
VFeedingRations_Quantity(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions)          total quantity of feed - UNIT: tons
VFeedingRations_Contents(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions) total nutrient contents of feed - UNIT: total units nutrient
VFeedingRations_OtherChar(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions)          "total other characteristics of feed/Feeding rations - UNIT: total other characteristics"

*2.9) Manure quantities, nutrients contained, other characteristics and management
VManure_Quantity(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions)                                                 total manure quantity                     - UNIT: tons
VManure_Contents(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions)                                  total nutrient contents of manure         - UNIT: total units nutrient
VManure_OtherChar(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions)                                total other characteristics of manure     - UNIT: total units OtherChar
VManure_Management(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions) total values related to manure management - UNIT: total units management values

*2.10) Fertilizer application: nutrients and other characteristics
*below: Activities_2 is Livestock plus also aggregates thereof, therefore the set Livestock is not enough and it needs to be activities
VManureApplication(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions) "Total characteristics of manure application to activities; Livestock/AnimalTypeInHerd captures the source of manure - UNIT: total Char"
VCropResAndBiomassApplication(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions)     "Total characteristics of crop residue and other crop biomass application to activities; commodities captures the source of crop residue/other biomass - UNIT: total Characteristic"
VMinFertApplication(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions)     "Total characteristics of min fert application to activities; MineralFertilizerType captures the source of min fert - UNIT: total Char"

*2.11) Import and export quantities
VImportQuantity(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions)                          total commodity quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VExportQuantity(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions)                          total commodity quantity EXPORTED from Regions INTO Regions_2 - UNIT: tons
VImportLivingAnimalsHead(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions) total number of live animals IMPORTED into Regions FROM Regions_2 - UNIT: Number of animal heads
VExportLivingAnimalsHead(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions) total number of live animals EXPORTED from Regions INTO Regions_2 - UNIT: Number of animal heads
*for trade in beehives and other animal activities measured in APUs only:
VImportLivingAnimalsAPU(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions)                   total number of live animals IMPORTED into Regions FROM Regions_2 - UNIT: Number of Animal Production Units (APUs)
VExportLivingAnimalsAPU(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions)                   total number of live animals EXPORTED from Regions INTO Regions_2 - UNIT: Number of Animal Production Units (APUs)

VImportQuantity_Feed(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions)                     total commodity FEED quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VExportQuantity_Feed(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions)                     total commodity FEED quantity EXPORTED into Regions FROM Regions_2 - UNIT: tons

*2.12) Commodities expressed in primary product equivalents
*the following variables are expressed in prim prod equivalents, derived from the corresponding variables that are reported in commodity quantities (cf. definitions above), by means of extraction rates, etc.
*no need to add activity and output dimensions, these informations are captured in the relevant matching sets as defined in _V6_ReadData_CommodityTrees_LinkActivitiesAndCommodities
VPrimProd_Commod_Quantity(Regions,Commodities,ProductionSystems,ProductionConditions)            total PRIMARY PRODUCT EQUIVALENT commodity quantity                        - UNIT: tons

VPrimProd_Commod_Production(Regions,Commodities,ProductionSystems,ProductionConditions)          total PRIMARY PRODUCT EQUIVALENT quantity of commodity production          - UNIT: tons
VPrimProd_Commod_StockChanges(Regions,Commodities,ProductionSystems,ProductionConditions)        total PRIMARY PRODUCT EQUIVALENT quantity of commodity stock changes       - UNIT: tons
VPrimProd_Commod_Food(Regions,Commodities,ProductionSystems,ProductionConditions)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for food       - UNIT: tons
VPrimProd_Commod_Feed(Regions,Commodities,ProductionSystems,ProductionConditions)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for feed       - UNIT: tons
VPrimProd_Commod_Seed(Regions,Commodities,ProductionSystems,ProductionConditions)                total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for seed       - UNIT: tons
VPrimProd_Commod_Processing(Regions,Commodities,ProductionSystems,ProductionConditions)          total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for processing - UNIT: tons
VPrimProd_Commod_Waste(Regions,Commodities,ProductionSystems,ProductionConditions)               total PRIMARY PRODUCT EQUIVALENT quantity of commodity lost or wasted      - UNIT: tons
VPrimProd_Commod_Other(Regions,Commodities,ProductionSystems,ProductionConditions)               total PRIMARY PRODUCT EQUIVALENT quantity of commodity used for other uses - UNIT: tons

VPrimProd_ImportQuantity(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions)   total PRIMARY PRODUCT EQUIVALENT commodity quantity IMPORTED into Regions FROM Regions_2 - UNIT: tons
VPrimProd_ExportQuantity(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions)   total PRIMARY PRODUCT EQUIVALENT commodity quantity EXPORTED from Regions INTO Regions_2 - UNIT: tons

VPrimProd_Commod_Quantity_CropActivities(Regions,Commodities,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions) total PRIMARY PRODUCT EQUIVALENT commodity quantity - linked to activities - UNIT: tons
VPrimProd_Commod_Quantity_AnimalActivities(Regions,Commodities,Activities,OutputsAnimals,ProductionSystems,ProductionConditions)  total PRIMARY PRODUCT EQUIVALENT commodity quantity - linked to activities - UNIT: tons

;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Auxiliary parameters
Parameters
HumanCharacteristics(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities) "any characteristics of humans - such as nutrient requirements, nutrient excretions and others - UNITS: characteristics/inputs/outputs per CAPITA"
*        commodities refer to the source of food, e.g. plant or animal based, but also cereals, oil crops, etc. or even finer on commodity level
SeedContents(Regions,Activities,Contents,ProductionSystems,ProductionConditions) "any characteristics of seeds - such as nutrient and DM contents, etc. - UNITS: per ton seed"
MineralFertilizerCharacteristics(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,ProductionSystems) "any characteristics of mineral fertilizers - such as production emissions, etc. - UNITS: per ton min. fert. nutrient"
GWP_GTP_SOLm(GreenhouseGases) "values for the radiative forcing of GHGs - GWP or GTP - to be set at the beginning and then to be used for all calculations"
;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Auxiliary variables

Variables
VMineralFertilizerQuantity(Regions,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems)   "total amount of mineral fertilizers from 'min. fert. production technology', applied on 'production systems' in 'region'  - UNIT: tons N, P2O5, K2O"
VPopulationNumbers(Regions,PopulationGroups) "total population numbers per region - differentiated by population groups, such as male, female, children, etc.    - UNIT: number of people"
VEnergyProduction(Regions,ConversionLevel,EnergyType,EnergySource,EnergyChar)  "total energy related variables - total production and supply, emissions, related CCS, etc.  - UNIT: units total"

;


$exit;



check: off season? via main / off season product?

via: off seasin area and area

Variable VAreaHarvested_MainSeason(Regions,Activities,ProductionSystems,ProductionConditions);
Variable VAreaHarvested_OffSeason(Regions,Activities,ProductionSystems,ProductionConditions);

Variable VOutputFromArea_MainSeason(Regions,Activities,Products,ProductionSystems,ProductionConditions);
Variable VOutputFromArea_OffSeason(Regions,Activities,Products,ProductionSystems,ProductionConditions);




