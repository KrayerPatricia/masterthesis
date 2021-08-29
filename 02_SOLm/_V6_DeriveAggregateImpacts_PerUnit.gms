PUTCLOSE con,"_V6_DeriveAggregateImpacts_PerUnit";

*GENERAL DESCRIPTION
*This file contains the code to derive some aggregate impacts - such as summing all parts of GHG emissions, coding the OECD-N-Balance, etc.

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Derive aggregate impacts

$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Derive aggregate impacts

*assign only for crops where there is a non-zero area and for animals where ther is a non-zero number of heads reported

ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Deforest GHG emissions (tCO2e)"    ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"CultOrgSoils C emissions (tCO2e)"  ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"CultOrgSoils N2O emissions (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"Direct N2O from mineral fert N applic (tCO2e)"           ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"Direct N2O from CropRes/biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"Direct N2O from manure as fert N applic (tCO2e)"         ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O leach from mineral fert N applic (tCO2e)"            ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O leach from CropRes/biomass as fert N applic (tCO2e)" ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O leach from manure as fert N applic (tCO2e)"          ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O volat from mineral fert N applic (tCO2e)"            ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O volat from CropRes/biomass as fert N applic (tCO2e)" ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O volat from manure as fert N applic (tCO2e)"          ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"CH4 flooded rice (tCO2e)"                                ,ProductionSystems,ProductionConditions,Scenarios);

ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"Direct N2O from mineral fert N applic (tCO2e)"           ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"Direct N2O from CropRes/biomass as fert N applic (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"Direct N2O from manure as fert N applic (tCO2e)"         ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O leach from mineral fert N applic (tCO2e)"            ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O leach from CropRes/biomass as fert N applic (tCO2e)" ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O leach from manure as fert N applic (tCO2e)"          ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O volat from mineral fert N applic (tCO2e)"            ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O volat from CropRes/biomass as fert N applic (tCO2e)" ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N2O volat from manure as fert N applic (tCO2e)"          ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"CH4 flooded rice (tCO2e)"                                ,ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - manure management (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N total loss (tN)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - man man + housing (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man+housing N total loss (tN)",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - grazing (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N total loss (tN)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - grazing + housing (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing+Grazing-housing N total loss (tN)",ProductionSystems,ProductionConditions,Scenarios);



ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure Man GHG emissions - animals (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O leach (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O volat (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tCO2e)"  ,ProductionSystems,ProductionConditions,Scenarios)
         + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man CH4 (tCO2e)"      ,ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total GHG emissions - animals (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O leach (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O volat (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
         + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tCO2e)"  ,ProductionSystems,ProductionConditions,Scenarios)
         + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man CH4 (tCO2e)"      ,ProductionSystems,ProductionConditions,Scenarios)
         + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Enteric ferment (t CO2e)"    ,ProductionSystems,ProductionConditions,Scenarios);

ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N inputs - crops (tN)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N fixation (tN)"                    ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N deposition (tN)"                  ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from CropRes/biomass as fert (tN)",ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from mineral fert (tN)"           ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N from manure as fert (tN)"         ,ProductionSystems,ProductionConditions,Scenarios);

*multiplication with yields because the parameters are in per ton main output values
*includes Outputs PLUS residues
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N outputs - crops (tN)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,Scenarios)
         = (ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput1 (tN)"                   ,ProductionSystems,ProductionConditions,Scenarios)
          + ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in residues - per ton MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios))
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios)
          + ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput2 (tN)"                   ,ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput2 (t)",ProductionSystems,ProductionConditions,Scenarios)
          + ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput3 (tN)"                   ,ProductionSystems,ProductionConditions,Scenarios)
                 *ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"MainOutput3 (t)",ProductionSystems,ProductionConditions,Scenarios);

ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N balance - plot level based (tN)",ProductionSystems,ProductionConditions,Scenarios)
*this balace captures what is really added to the soil and exported - thus does not capture losses before, such as from manure management
         = ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N inputs - crops (tN)",ProductionSystems,ProductionConditions,Scenarios)
                 - ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N outputs - crops (tN)",ProductionSystems,ProductionConditions,Scenarios);


ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"NH3 from areas (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Activities_MR,ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"NH3 from soils (tNH3)"                           ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"NH3 from mineral fert N applic (tNH3)"           ,ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"NH3 from CropRes/biomass as fert N applic (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
         + ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"NH3 from manure as fert N applic (tNH3)"         ,ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"NH3 from animals, - manure management (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man NH3 (tNH3)",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"NH3 from animals, - grazing + housing (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
                 $VActAnimalsHead_QuantityActUnits_MR.l(Regions_MR,Activities_MR,AnimalTypeInHerd,ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing NH3 (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Housing NH3 from manure (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing-Housing NH3 from manure (tNH3)",ProductionSystems,ProductionConditions,Scenarios);





$ontext;
*the code above collects the following totals:
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - manure management (tN)",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - man man + housing (tN)",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - grazing (tN)",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total N-losses from animals, - grazing + housing (tN)",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure Man GHG emissions - animals (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Total GHG emissions - animals (tCO2e)",ProductionSystems,ProductionConditions,Scenarios)
ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,"N inputs - crops (tN)",ProductionSystems,ProductionConditions,Scenarios)
ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,"N outputs - crops (tN)",ProductionSystems,ProductionConditions,Scenarios)
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N balance - plot level based (tN)",ProductionSystems,ProductionConditions,Scenarios)
ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"NH3 from areas (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"NH3 from animals, - manure management (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"NH3 from animals, - grazing + housing (tNH3)",ProductionSystems,ProductionConditions,Scenarios)
$offtext;

