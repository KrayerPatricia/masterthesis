PUTCLOSE con,"_V6_DeriveGeographicAggregations";

*GENERAL DESCRIPTION
*This file contains all the core model equations for calculating geographic aggregations - e.g. from sub-regions to countries, etc. .

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Aggregation of single country values to regional totals

$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Aggregation of single country values to regional totals

*use the following matching file:
*Set Match_GeographicAggregates_SingleCountries(Regions,Regions_2)

*geographic aggregation is slow also without the matching file - thus do only very specific cases that are needed for consistency checks; add full aggregation only later when the model is fully tested and running.



VActCropsGrass_Outputs_MR.l("European Union",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VActCropsGrass_Outputs_MR.l(FAO_EuropeanUnion,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

VCommod_Quantity_MR.l("European Union",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));

VCommod_Food_MR.l("European Union",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VCommod_Food_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));

VCommod_Feed_MR.l("European Union",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VCommod_Feed_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));

*the following is needed for UNISECO calculations
**we need the trade between the EU and the Non-EU Rest of the world:
*$onmulti;
*Set Regions
*/
*"Non-EU Rest of the World"
*/
*;
*$offmulti;
*
*Set NonEU_RestOfTheWorld(Regions);
*NonEU_RestOfTheWorld(Regions) = Countries(Regions) - FAO_EuropeanUnion(Regions);


*put the following into comment mode, in case it causes errors, because some set is missing (this can happen if UNISECO SESSIT data is not used)
*SWITH ON gain if you want to do the SESSIT calculations, etc.
$ontext;
VImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum((FAO_EuropeanUnion,NonEU_RestOfTheWorld),VImportQuantity_MR.l(FAO_EuropeanUnion,NonEU_RestOfTheWorld,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));
VExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum((FAO_EuropeanUnion,NonEU_RestOfTheWorld),VExportQuantity_MR.l(FAO_EuropeanUnion,NonEU_RestOfTheWorld,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));

VPrimProd_ImportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum((FAO_EuropeanUnion,NonEU_RestOfTheWorld),VPrimProd_ImportQuantity_MR.l(FAO_EuropeanUnion,NonEU_RestOfTheWorld,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_ExportQuantity_MR.l("European Union","Non-EU Rest of the World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum((FAO_EuropeanUnion,NonEU_RestOfTheWorld),VPrimProd_ExportQuantity_MR.l(FAO_EuropeanUnion,NonEU_RestOfTheWorld,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));

VCommod_Quantity_MR.l("European Union",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VCommod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));
VCommod_Quantity_MR.l("Non-EU Rest of the World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(NonEU_RestOfTheWorld,VCommod_Quantity_MR.l(NonEU_RestOfTheWorld,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));
VCommod_Production_MR.l("European Union",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VCommod_Production_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));
VCommod_Production_MR.l("Non-EU Rest of the World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(NonEU_RestOfTheWorld,VCommod_Production_MR.l(NonEU_RestOfTheWorld,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));

VPrimProd_Commod_Quantity_MR.l("European Union",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VPrimProd_Commod_Quantity_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Quantity_MR.l("Non-EU Rest of the World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(NonEU_RestOfTheWorld,VPrimProd_Commod_Quantity_MR.l(NonEU_RestOfTheWorld,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("European Union",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VPrimProd_Commod_Production_MR.l(FAO_EuropeanUnion,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));
VPrimProd_Commod_Production_MR.l("Non-EU Rest of the World",Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(NonEU_RestOfTheWorld,VPrimProd_Commod_Production_MR.l(NonEU_RestOfTheWorld,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios));
$offtext;


VActCropsGrass_QuantityActUnits_MR.l("European Union",Activities,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,Activities,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_Outputs_MR.l("European Union",Livestock,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VActAnimalsHead_Outputs_MR.l(FAO_EuropeanUnion,Livestock,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_QuantityActUnits_MR.l("European Union",Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VActAnimalsHead_QuantityActUnits_MR.l(FAO_EuropeanUnion,Livestock,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Inputs_MR.l("European Union",Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VActCropsGrass_Inputs_MR.l(FAO_EuropeanUnion,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));


VActCropsGrass_Inputs_MR.l("European Union","All crops","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VActCropsGrass_Inputs_MR.l(FAO_EuropeanUnion,"All crops","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Inputs_MR.l("European Union","Grass","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VActCropsGrass_Inputs_MR.l(FAO_EuropeanUnion,"Grass","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_QuantityActUnits_MR.l("European Union","All Legumes (Nfixing)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(FAO_EuropeanUnion,VActCropsGrass_QuantityActUnits_MR.l(FAO_EuropeanUnion,"All Legumes (Nfixing)",ProductionSystems,ProductionConditions,Scenarios));



$exit;



VActCropsGrass_QuantityActUnits_MR.l("World",Activities,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VActCropsGrass_QuantityActUnits_MR.l(Countries,Activities,ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_OtherChar_MR.l("World",Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VActAnimalsHead_OtherChar_MR.l(Countries,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l("World",Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VActCropsGrass_OtherChar_MR.l(Countries,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_QuantityActUnits_MR.l("World",Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VActAnimalsHead_QuantityActUnits_MR.l(Countries,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l("World",Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VActCropsGrass_Inputs_MR.l(Countries,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_Inputs_MR.l("World",Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VActAnimalsHead_Inputs_MR.l(Countries,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Outputs_MR.l("World",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VActCropsGrass_Outputs_MR.l(Countries,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   Geoagr aggreg 2:" timeElapsed;

VActAnimalsHead_Outputs_MR.l("World",Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries$VActAnimalsHead_Outputs_MR.l(Countries,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 ,VActAnimalsHead_Outputs_MR.l(Countries,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   Geoagr aggreg 2:" timeElapsed;


VMinFertApplication_MR.l("World",Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VMinFertApplication_MR.l(Countries,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));
VCropResAndBiomassApplication_MR.l("World",Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VCropResAndBiomassApplication_MR.l(Countries,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));
VManureApplication_MR.l("World",Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VManureApplication_MR.l(Countries,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));
VCropResidues_Contents_MR.l("World",Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VCropResidues_Contents_MR.l(Countries,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios));
VMineralFertilizerQuantity_MR.l("World",MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios)
         =sum(Countries,VMineralFertilizerQuantity_MR.l(Countries,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios));
VCropResidues_Management_MR.l("World",Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries,VCropResidues_Management_MR.l(Countries,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   Geoagr aggreg 3:" timeElapsed;

VManure_Management_MR.l("World",Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Countries$VManure_Management_MR.l(Countries,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios)
                 ,VManure_Management_MR.l(Countries,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios));


PUTCLOSE con "   Geoagr aggreg 3:" timeElapsed;



$exit;


*Using this matching file in the code below makes it terribly slow, thus assign by hand:
*        for the follwoing three regions:
*"Switzerland".#Regions_Switzerland
*"Austria".#Regions_Austria
*"World".#Countries

VActCropsGrass_QuantityActUnits_MR.l("Switzerland",Activities,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VActCropsGrass_QuantityActUnits_MR.l(Regions_Switzerland,Activities,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_QuantityActUnits_MR.l("Austria",Activities,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VActCropsGrass_QuantityActUnits_MR.l(Regions_Austria,Activities,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 1:" timeElapsed;

VActAnimalsHead_QuantityActUnits_MR.l("Switzerland",Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VActAnimalsHead_QuantityActUnits_MR.l(Regions_Switzerland,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_QuantityActUnits_MR.l("Austria",Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VActAnimalsHead_QuantityActUnits_MR.l(Regions_Austria,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 2:" timeElapsed;

VActCropsGrass_Inputs_MR.l("Switzerland",Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VActCropsGrass_Inputs_MR.l(Regions_Switzerland,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l("Austria",Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VActCropsGrass_Inputs_MR.l(Regions_Austria,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 3:" timeElapsed;

VActAnimalsHead_Inputs_MR.l("Switzerland",Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VActAnimalsHead_Inputs_MR.l(Regions_Switzerland,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_Inputs_MR.l("Austria",Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VActAnimalsHead_Inputs_MR.l(Regions_Austria,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 4:" timeElapsed;

VActCropsGrass_Outputs_MR.l("Switzerland",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VActCropsGrass_Outputs_MR.l(Regions_Switzerland,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Outputs_MR.l("Austria",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VActCropsGrass_Outputs_MR.l(Regions_Austria,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 5:" timeElapsed;

VActAnimalsHead_Outputs_MR.l("Switzerland",Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland$VActAnimalsHead_Outputs_MR.l(Regions_Switzerland,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 ,VActAnimalsHead_Outputs_MR.l(Regions_Switzerland,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_Outputs_MR.l("Austria",Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria$VActAnimalsHead_Outputs_MR.l(Regions_Austria,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 ,VActAnimalsHead_Outputs_MR.l(Regions_Austria,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 6:" timeElapsed;

VActCropsGrass_OtherChar_MR.l("Switzerland",Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VActCropsGrass_OtherChar_MR.l(Regions_Switzerland,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l("Austria",Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VActCropsGrass_OtherChar_MR.l(Regions_Austria,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 7:" timeElapsed;

VActAnimalsHead_OtherChar_MR.l("Switzerland",Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VActAnimalsHead_OtherChar_MR.l(Regions_Switzerland,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios));
VActAnimalsHead_OtherChar_MR.l("Austria",Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VActAnimalsHead_OtherChar_MR.l(Regions_Austria,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 8:" timeElapsed;

$ontext;
VManure_Management_MR.l("Switzerland",Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland$VManure_Management_MR.l(Regions_Switzerland,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios)
                 ,VManure_Management_MR.l(Regions_Switzerland,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios));
VManure_Management_MR.l("Austria",Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria$VManure_Management_MR.l(Regions_Austria,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios)
                 ,VManure_Management_MR.l(Regions_Austria,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 9:" timeElapsed;

VCropResidues_Management_MR.l("Switzerland",Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VCropResidues_Management_MR.l(Regions_Switzerland,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios));
VCropResidues_Management_MR.l("Austria",Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VCropResidues_Management_MR.l(Regions_Austria,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 10:" timeElapsed;
$offtext;

VMineralFertilizerQuantity_MR.l("Switzerland",MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios)
         =sum(Regions_Switzerland,VMineralFertilizerQuantity_MR.l(Regions_Switzerland,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios));
VMineralFertilizerQuantity_MR.l("Austria",MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios)
         =sum(Regions_Austria,VMineralFertilizerQuantity_MR.l(Regions_Austria,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 11:" timeElapsed;

VCropResidues_Contents_MR.l("Switzerland",Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VCropResidues_Contents_MR.l(Regions_Switzerland,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios));
VCropResidues_Contents_MR.l("Austria",Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VCropResidues_Contents_MR.l(Regions_Austria,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 12:" timeElapsed;

VManureApplication_MR.l("Switzerland",Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VManureApplication_MR.l(Regions_Switzerland,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));
VManureApplication_MR.l("Austria",Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VManureApplication_MR.l(Regions_Austria,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 13:" timeElapsed;

VCropResAndBiomassApplication_MR.l("Switzerland",Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VCropResAndBiomassApplication_MR.l(Regions_Switzerland,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));
VCropResAndBiomassApplication_MR.l("Austria",Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VCropResAndBiomassApplication_MR.l(Regions_Austria,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));

PUTCLOSE con "   time elapsed Geographic Aggregation 14:" timeElapsed;

VMinFertApplication_MR.l("Switzerland",Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Switzerland,VMinFertApplication_MR.l(Regions_Switzerland,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));
VMinFertApplication_MR.l("Austria",Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_Austria,VMinFertApplication_MR.l(Regions_Austria,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));


PUTCLOSE con "   time elapsed Geographic Aggregation 15:" timeElapsed;

$exit;

VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActCropsGrass_QuantityActUnits_MR.l(Regions_2,Activities,ProductionSystems,ProductionConditions,Scenarios));


*VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActAnimalsAPU_QuantityActUnits_MR.l(Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActAnimalsHead_QuantityActUnits_MR.l(Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios));

*VActFishSeafood_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActFishSeafood_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActFishSeafood_QuantityActUnits_MR.l(Regions_2,Activities,ProductionSystems,ProductionConditions,Scenarios));

*VActForest_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActForest_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActForest_QuantityActUnits_MR.l(Regions_2,Activities,ProductionSystems,ProductionConditions,Scenarios));

*VActOthers_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActOthers_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActOthers_QuantityActUnits_MR.l(Regions_2,Activities,ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActCropsGrass_Inputs_MR.l(Regions_2,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

*VActAnimalsAPU_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActAnimalsAPU_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActAnimalsAPU_Inputs_MR.l(Regions_2,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActAnimalsHead_Inputs_MR.l(Regions_2,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios));

*VActFishSeafood_Inputs_MR.l(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActFishSeafood_Inputs_MR.l(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActFishSeafood_Inputs_MR.l(Regions_2,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios));

*VActForest_Inputs_MR.l(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActForest_Inputs_MR.l(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActForest_Inputs_MR.l(Regions_2,Activities,InputsForest,ProductionSystems,ProductionConditions,Scenarios));

*VActOthers_Inputs_MR.l(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActOthers_Inputs_MR.l(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActOthers_Inputs_MR.l(Regions_2,Activities,InputsOther,ProductionSystems,ProductionConditions,Scenarios));


VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActCropsGrass_Outputs_MR.l(Regions_2,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

*VActAnimalsAPU_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActAnimalsAPU_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActAnimalsAPU_Outputs_MR.l(Regions_2,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActAnimalsHead_Outputs_MR.l(Regions_2,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios));

*VActFishSeafood_Outputs_MR.l(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActFishSeafood_Outputs_MR.l(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActFishSeafood_Outputs_MR.l(Regions_2,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions,Scenarios));

*VActForest_Outputs_MR.l(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActForest_Outputs_MR.l(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActForest_Outputs_MR.l(Regions_2,Activities,OutputsForest,ProductionSystems,ProductionConditions,Scenarios));

*VActOthers_Outputs_MR.l(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VActOthers_Outputs_MR.l(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VActOthers_Outputs_MR.l(Regions_2,Activities,OutputsOther,ProductionSystems,ProductionConditions,Scenarios));

$ontext;
VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActCropsGrass_OtherChar_MR.l(Regions_2,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsAPU_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsAPU_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActAnimalsAPU_OtherChar_MR.l(Regions_2,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActAnimalsHead_OtherChar_MR.l(Regions_2,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios));

VActFishSeafood_OtherChar_MR.l(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActFishSeafood_OtherChar_MR.l(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActFishSeafood_OtherChar_MR.l(Regions_2,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions,Scenarios));

VActForest_OtherChar_MR.l(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActForest_OtherChar_MR.l(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActForest_OtherChar_MR.l(Regions_2,Activities,OtherCharForest,ProductionSystems,ProductionConditions,Scenarios));

VActOthers_OtherChar_MR.l(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActOthers_OtherChar_MR.l(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VActOthers_OtherChar_MR.l(Regions_2,Activities,OtherCharOther,ProductionSystems,ProductionConditions,Scenarios));
$offtext;

*VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VCommod_Quantity_MR.l(Regions_2,Commodities,ProductionSystems,ProductionConditions,Scenarios));

*VCommod_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VCommod_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VCommod_Contents_MR.l(Regions_2,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios));

*VCommod_OtherChar_MR.l(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios)
*                 $(NOT VCommod_OtherChar_MR.l(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios))
*         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
*                 VCommod_OtherChar_MR.l(Regions_2,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions,Scenarios));

$ontext;
VCropResidues_Quantity_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Quantity_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VCropResidues_Quantity_MR.l(Regions_2,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VCropResidues_Contents_MR.l(Regions_2,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_OtherChar_MR.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCropResidues_OtherChar_MR.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VCropResidues_OtherChar_MR.l(Regions_2,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VCropResidues_Management_MR.l(Regions_2,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios));


VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VFeedingRations_Quantity_MR.l(Regions_2,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions,Scenarios));

VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VFeedingRations_Contents_MR.l(Regions_2,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios));

VFeedingRations_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VFeedingRations_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VFeedingRations_OtherChar_MR.l(Regions_2,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions,Scenarios));


VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VManure_Quantity_MR.l(Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios));

VManure_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VManure_Contents_MR.l(Regions_2,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions,Scenarios));

VManure_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VManure_OtherChar_MR.l(Regions_2,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions,Scenarios));

VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VManure_Management_MR.l(Regions_2,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions,Scenarios));


VManureApplication_MR.l(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VManureApplication_MR.l(Regions,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VManureApplication_MR.l(Regions_2,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));

VMineralFertilizerQuantity_MR.l(Regions,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios)
                 $(NOT VMineralFertilizerQuantity_MR.l(Regions,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VMineralFertilizerQuantity_MR.l(Regions_2,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems,Scenarios));

VMinFertApplication_MR.l(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VMinFertApplication_MR.l(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VMinFertApplication_MR.l(Regions_2,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions,Scenarios));



VPopulationNumbers_MR.l(Regions,PopulationGroups,Scenarios)
                 $(NOT VPopulationNumbers_MR.l(Regions,PopulationGroups,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VPopulationNumbers_MR.l(Regions_2,PopulationGroups,Scenarios));

VEnergyProduction_MR.l(Regions,ConversionLevel,EnergyType,EnergySource,EnergyChar,Scenarios)
                 $(NOT VEnergyProduction_MR.l(Regions,ConversionLevel,EnergyType,EnergySource,EnergyChar,Scenarios))
         =sum(Regions_2$Match_GeographicAggregates_SingleCountries(Regions,Regions_2),
                 VEnergyProduction_MR.l(Regions_2,ConversionLevel,EnergyType,EnergySource,EnergyChar,Scenarios));
$offtext;



$exit;




THEN:
derive per region per unit impacts
