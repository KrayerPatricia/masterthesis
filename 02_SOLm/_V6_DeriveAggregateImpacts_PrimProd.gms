PUTCLOSE con,"_V6_DeriveAggregateImpacts_PrimProd";

*GENERAL DESCRIPTION
*This file contains the code to derive some aggregate impacts - such as summing all parts of GHG emissions, coding the OECD-N-Balance, etc.

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Derive aggregate impacts
         1.1) Subsets for aggregations
         1.2) Code for aggregation

$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Derive aggregate impacts
*1.1) Subsets for aggregations

*"Total GHG emissions - crops, incl. deforest and org. soils (tCO2e)"
Set Subset_GHGEmissionsCrops_InclDeforestOrgSoils(PerCommodImpact)
/
"Deforest GHG emissions (tCO2e)"
"CultOrgSoils GHG emissions (tCO2e)"
"CultOrgSoils C emissions (tCO2e)"
"CultOrgSoils N2O emissions (tCO2e)"
"Direct N2O from mineral fert N applic (tCO2e)"
"Direct N2O from CropRes/biomass as fert N applic (tCO2e)"
"Direct N2O from manure as fert N applic (tCO2e)"
"N2O leach from mineral fert N applic (tCO2e)"
"N2O leach from CropRes/biomass as fert N applic (tCO2e)"
"N2O leach from manure as fert N applic (tCO2e)"
"N2O volat from mineral fert N applic (tCO2e)"
"N2O volat from CropRes/biomass as fert N applic (tCO2e)"
"N2O volat from manure as fert N applic (tCO2e)"
"CH4 flooded rice (tCO2e)"
/;

*"Total GHG emissions - crops, no deforest and org. soils (tCO2e)"
Set Subset_GHGEmissionsCrops_NoDeforestOrgSoils(PerCommodImpact)
/
"Direct N2O from mineral fert N applic (tCO2e)"
"Direct N2O from CropRes/biomass as fert N applic (tCO2e)"
"Direct N2O from manure as fert N applic (tCO2e)"
"N2O leach from mineral fert N applic (tCO2e)"
"N2O leach from CropRes/biomass as fert N applic (tCO2e)"
"N2O leach from manure as fert N applic (tCO2e)"
"N2O volat from mineral fert N applic (tCO2e)"
"N2O volat from CropRes/biomass as fert N applic (tCO2e)"
"N2O volat from manure as fert N applic (tCO2e)"
"CH4 flooded rice (tCO2e)"
/;

*"Total N-losses from animals, - manure management (tN)"
Set Subset_NLossesAnimals(PerCommodImpact)
/
"Manure man N in N2O dir (tN)"
"Manure man N volat (tN)"
"Manure man N leach (tN)"
*"Housing NH3 from manure (tN)"
/;

XXXXXX add the following as well  but sums already done, thus just allocate here?
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - manure management (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N total loss (tN)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - man man + housing (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man+housing N total loss (tN)",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - grazing (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N total loss (tN)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - grazing + housing (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing+Grazing-housing N total loss (tN)",ProductionSystems,ProductionConditions,Scenarios);



*"Total GHG emissions - animals (tCO2e)"
Set Subset_GHGEmissionsAnimals(PerCommodImpact)
/
"Manure man GHG total (tCO2e)"
"Manure man N2O leach (tCO2e)"
"Manure man N2O volat (tCO2e)"
"Manure man N2O dir (tCO2e)"
"Manure man CH4 (tCO2e)"
"Enteric ferment (t CO2e)"
/;

*"N inputs - crops (tN)"
Set Subset_N_InputsCrops(PerCommodImpact)
/
"N fixation (tN)"
"N deposition (tN)"
"N from CropRes/biomass as fert (tN)"
"N from mineral fert (tN)"
"N from manure as fert (tN)"
/;
*"N outputs - crops (tN)"
Set Subset_N_OutputsCrops(PerCommodImpact)
/
"N in MainOutput1 (tN)"
"N in residues - per ton MainOutput1 (tN)"
/;

*"NH3 from areas (tNH3)"
Set Subset_NH3_from_Fields(PerCommodImpact)
/
"NH3 from soils (tNH3)"
"NH3 from mineral fert N applic (tNH3)"
"NH3 from CropRes/biomass as fert N applic (tNH3)"
"NH3 from manure as fert N applic (tNH3)"
/;
*"NH3 from animals, i.e. manure management (tNH3)"
Set Subset_NH3_from_Animals(PerCommodImpact)
/
"Manure man NH3 (tNH3)"
/;

*1.2) Code for aggregation

*assign only for crops where there is a non-zero area and for animals where ther is a non-zero number of heads reported

*DO THIS AUTOMATICALLY - by adding the aggregate elements to the set in the per prim prod derive code module!!


ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Subset_GHGEmissionsCrops_InclDeforestOrgSoils,
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,Subset_GHGEmissionsCrops_InclDeforestOrgSoils,ProductionSystems,ProductionConditions,Scenarios));

ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Subset_GHGEmissionsCrops_NoDeforestOrgSoils,
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,Subset_GHGEmissionsCrops_NoDeforestOrgSoils,ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - manure management (tN)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Subset_NLossesAnimals,
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Subset_NLossesAnimals,ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total GHG emissions - animals (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Subset_GHGEmissionsAnimals,
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Subset_GHGEmissionsAnimals,ProductionSystems,ProductionConditions,Scenarios));

ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"N inputs - crops (tN)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Subset_N_InputsCrops,
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,Subset_N_InputsCrops,ProductionSystems,ProductionConditions,Scenarios));

ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"N outputs - crops (tN)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Subset_N_OutputsCrops,
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,Subset_N_OutputsCrops,ProductionSystems,ProductionConditions,Scenarios));

ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"N balance - plot level based (tN)",ProductionSystems,ProductionConditions,Scenarios)
*this balace captures what is really added to the soil and exported - thus does not capture losses before, such as from manure management
         = ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"N inputs - crops (tN)",ProductionSystems,ProductionConditions,Scenarios)
                 - ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"N outputs - crops (tN)",ProductionSystems,ProductionConditions,Scenarios);

ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"NH3 from areas (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Subset_NH3_from_Fields,
                 ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,Subset_NH3_from_Fields,ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"NH3 from animals, - manure management (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Subset_NH3_from_Animals,
                 ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,Subset_NH3_from_Animals,ProductionSystems,ProductionConditions,Scenarios));





$exit;
















