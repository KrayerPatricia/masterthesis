PUTCLOSE con,"_V6_DerivePerPrimaryProductImpacts";

*GENERAL DESCRIPTION
*This file contains the code to derive per primary product values for inputs, outputs, other characteristics (focusing on env. impacts) from the corresponding per activity values

*DETAILED TABLE OF CONTENTS
$ontext;
1) Derive per primary product impacts values
         1.1) Some new sets and parameters
         1.2) Derive per primary product impact on commodity level for crops
         1.3) Derive per primary product impact on commodity level for animals

$offtext;


*MODEL CODE:


*part of the code should run only once as it includes set definitions, etc.
$if NOT %Allocation% == "Mass" $goto CoreAllocationCode1

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Derive per primary product impacts values

$ontext;

THE FOLLOWING SETS and PARAMETERS ARE ALREADY DEFINED IN _V6_Sets_GeneralModelSets_ForSteeringFile2

*1.1) Some new sets and parameters

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


$offtext;

$label CoreAllocationCode1

*1.2) Derive per ton primary product impact for crops


ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,SubsetPerCommodImpact_InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         = sum(InputsCropsGrass$Match_PerCommodImpact_CropsGrassCommodInputs(SubsetPerCommodImpact_InputsCropsGrass,InputsCropsGrass),
                 ActCropsGrass_Inputs_MR(Regions_MR,Activities_MR,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                         *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Land use per Mainoutput1 (ha)",ProductionSystems,ProductionConditions,Scenarios));

ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,SubsetPerCommodImpact_OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsCropsGrass$Match_PerCommodImpact_CropsGrassCommodOutputs(SubsetPerCommodImpact_OutputsCropsGrass,OutputsCropsGrass),
                 ActCropsGrass_Outputs_MR(Regions_MR,Activities_MR,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                         *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Land use per Mainoutput1 (ha)",ProductionSystems,ProductionConditions,Scenarios));

ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,SubsetPerCommodImpact_OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharCropsGrass$Match_PerCommodImpact_CropsGrassCommodOtherChar(SubsetPerCommodImpact_OtherCharCropsGrass,OtherCharCropsGrass),
                 ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                         *ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Land use per Mainoutput1 (ha)",ProductionSystems,ProductionConditions,Scenarios));

*to be caluclated with the code above, land use would have to be measured in ha per ha, thus =1 - but it is the inverse of the yield - thus do not include in these calculatiosn above, but treat separately
ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Activities_MR,"Land use (ha)",ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"Land use per Mainoutput1 (ha)",ProductionSystems,ProductionConditions,Scenarios);
*and assign Cropland and grassland use separately:
ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Crops_MR,"Cropland use (ha)",ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,Crops_MR,"Land use (ha)",ProductionSystems,ProductionConditions,Scenarios);
ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,CoreGrassActivities_MR,"Grassland use (ha)",ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_PerPrimProdImpact_MR(Regions_MR,CoreGrassActivities_MR,"Land use (ha)",ProductionSystems,ProductionConditions,Scenarios);






*1.3) Derive per ton primary product impact for animals

*We do it first for the livestock with one output only, later for those with two outputs (e.g. meat and milk)
*for this, use the specific corresponding subsets of Activities

*for animals, we need the output and OtherChar parameters only, not the inputs
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing", "Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing", "Milk (t)",ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing", "Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing", "Eggs (t)",ProductionSystems,ProductionConditions,Scenarios));



ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing", "Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing", "Milk (t)",ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing", "Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing", "Eggs (t)",ProductionSystems,ProductionConditions,Scenarios));


*Remember: yield per head as deniminator for impacts per ton, as APU is built in relation to ONE producing animal - unless for beef from dairy, where it is in relation to one producing DAIRY animal, not one producing dairy BEEF animal

*and we need the feeding rations:
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                        /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing", "Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                        /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Milk producing", "Milk (t)",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing", "Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                        /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_NoCoupledOutputs,"Egg producing", "Eggs (t)",ProductionSystems,ProductionConditions,Scenarios);

*and for the beef cattle herd and its meat production, we do it as for animals without coupled products:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Meat producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,"Cattle","Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                        /ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios);




$ontext;
Up to here, no allocation has been needed - no coupled products were involved
Do now the coupled products in the following,
this is an issue for chickens and meat/egg as well as for dairy cattle and meat/egg, and some others, as captured by the corresponding subsets of livestock activities
First, we do the formalism in general, after this comes the code to implement it

for the animals without herd structure, we need the relative share between the 2 products of the contents or characteristics relevant for allocation
and the relative size of animal production units, driven by the ratio between producing and living animals (see _V6_DerivePerAPUValues.gms).

We have:
APU_ForOutput1 produces YieldOutput1
APU_ForOutput2 produces YieldOutput2

APU_ForOutput1 corresponds to 1 ProducingAnimal_ForOutput1 AND  (NrLivingAnimals - NrProducingAnimals_ForOutput1)/NrProducingAnimals_ForOutput1 living animals
APU_ForOutput2 corresponds to 1 ProducingAnimal_ForOutput2 AND  (NrLivingAnimals - NrProducingAnimals_ForOutput2)/NrProducingAnimals_ForOutput2 living animals

THis is, with ShareProducingInLivingAnimals_ForOutput1=NrProducingAnimals_ForOutput1/NrLivingAnimals:

APU_ForOutput1 corresponds to 1 ProducingAnimal_ForOutput1 AND  ((1 / ShareProducingInLivingAnimals_ForOutput1) - 1) living animals   =  1 / ShareProducingInLivingAnimals_ForOutput1 living animals
APU_ForOutput2 corresponds to 1 ProducingAnimal_ForOutput2 AND  ((1 / ShareProducingInLivingAnimals_ForOutput2) - 1) living animals   =  1 / ShareProducingInLivingAnimals_ForOutput2 living animals

ImpactPerAPU_ForOutput1 = ImpactPerAnimal / ShareProducingInLivingAnimals_ForOutput1
ImpactPerAPU_ForOutput2 = ImpactPerAnimal / ShareProducingInLivingAnimals_ForOutput2



APU_ForOutput1 corresponds to 1 / ShareProducingInLivingAnimals_ForOutput1 living animals; thus: 1 living animal corresponds to ShareProducingInLivingAnimals_ForOutput1 APU_ForOutput1
1 / ShareProducingInLivingAnimals_ForOutput2 living animals thus correspond to 1 / ShareProducingInLivingAnimals_ForOutput2 * ShareProducingInLivingAnimals_ForOutput1 APU_ForOutput1
APU_ForOutput2 thus corresponds to 1 / ShareProducingInLivingAnimals_ForOutput2 * ShareProducingInLivingAnimals_ForOutput1 APU_ForOutput1

YieldOutput2 from one producing animal for Output2 thus comes with 1 / ShareProducingInLivingAnimals_ForOutput2 * ShareProducingInLivingAnimals_ForOutput1 * YieldOutput1
YieldOutput1 from one producing animal for Output1 thus comes with 1 / ShareProducingInLivingAnimals_ForOutput1 * ShareProducingInLivingAnimals_ForOutput2 * YieldOutput2

Looking at any allocation characteristics (mass, protein contents, economic value,...), we thus have:
YieldOutput1*AllocCharactContents_ForOuptut1 from one producing animal for Output1 thus comes with 1 / ShareProducingInLivingAnimals_ForOutput1 * ShareProducingInLivingAnimals_ForOutput2 * YieldOutput2*AllocCharactContents_ForOuput2
YieldOutput1_MeasuredInAllocCharact from one producing animal for Output1 thus comes with 1 / ShareProducingInLivingAnimals_ForOutput1 * ShareProducingInLivingAnimals_ForOutput2 * YieldOutput2_MeasuredInAllocCharact

1 APU_ForOutput1 thus comes with YieldOutput1_MeasuredInAllocCharact AND 1 / ShareProducingInLivingAnimals_ForOutput1 * ShareProducingInLivingAnimals_ForOutput2 * YieldOutput2_MeasuredInAllocCharact

Define: 1 / ShareProducingInLivingAnimals_ForOutput1 * ShareProducingInLivingAnimals_ForOutput2 =: Relation_APU2_To_APU1
Thus:
1 APU_ForOutput1 thus comes with YieldOutput1_MeasuredInAllocCharact AND Relation_APU2_To_APU1 * YieldOutput2_MeasuredInAllocCharact
1 APU_ForOutput1 thus comes with YieldOutput1*AllocCharactContents_ForOuput1 AND Relation_APU2_To_APU1 * YieldOutput2*AllocCharactContents_ForOuput2

The allocation of an Impact from 1 APU_ForOutput1 to the two outputs 1 and 2 according to the allocation characteristics is thus as follows:

Impact per total Output 1 from 1 APU_ForOutput1: Impact_PerAPU_ForOutput1/[YieldOutput1*AllocCharactContents_ForOuput1 + Relation_APU2_To_APU1 * YieldOutput2*AllocCharactContents_ForOuput2] * YieldOutput1*AllocCharactContents_ForOuput1
Impact per total Output 2 from 1 APU_ForOutput1: Impact_PerAPU_ForOutput1/[YieldOutput1*AllocCharactContents_ForOuput1 + Relation_APU2_To_APU1 * YieldOutput2*AllocCharactContents_ForOuput2] * Relation_APU2_To_APU1 * YieldOutput2*AllocCharactContents_ForOuput2

Thus, dividing by the respective yields gives the impact per unit output when allocated according to the allocation characteristics:

Impact per unit Output 1: Impact_PerAPU_ForOutput1/[YieldOutput1*AllocCharactContents_ForOuput1 + Relation_APU2_To_APU1 * YieldOutput2*AllocCharactContents_ForOuput2] * YieldOutput1*AllocCharactContents_ForOuput1 / YieldOutput1
Impact per unit Output 2: Impact_PerAPU_ForOutput1/[YieldOutput1*AllocCharactContents_ForOuput1 + Relation_APU2_To_APU1 * YieldOutput2*AllocCharactContents_ForOuput2] * Relation_APU2_To_APU1 * YieldOutput2*AllocCharactContents_ForOuput2 / (YieldOutput2 * Relation_APU2_To_APU1)

Simplified (cancelling the yields):
Impact per unit Output 1: Impact_PerAPU_ForOutput1/[YieldOutput1*AllocCharactContents_ForOuput1 + Relation_APU2_To_APU1 * YieldOutput2*AllocCharactContents_ForOuput2] * AllocCharactContents_ForOuput1
Impact per unit Output 2: Impact_PerAPU_ForOutput1/[YieldOutput1*AllocCharactContents_ForOuput1 + Relation_APU2_To_APU1 * YieldOutput2*AllocCharactContents_ForOuput2] * AllocCharactContents_ForOuput2
where:
Relation_APU2_To_APU1 = 1 / ShareProducingInLivingAnimals_ForOutput1 * ShareProducingInLivingAnimals_ForOutput2

And also use a parameter for the allocation characteristics relative contents:
RelationAllocCharactCont_Output1_To_Output2 = AllocCharactContents_ForOuput1/AllocCharactContents_ForOuput2
Thus:
Impact per unit Output 1: Impact_PerAPU_ForOutput1/[YieldOutput1 + Relation_APU2_To_APU1 * YieldOutput2/RelationAllocCharactCont_Output1_To_Output2]
Impact per unit Output 2: Impact_PerAPU_ForOutput1/[YieldOutput1*RelationAllocCharactCont_Output1_To_Output2 + Relation_APU2_To_APU1 * YieldOutput2]

where:
Relation_APU2_To_APU1 = 1 / ShareProducingInLivingAnimals_ForOutput1 * ShareProducingInLivingAnimals_ForOutput2 = ShareProducingInLivingAnimals_ForOutput2 / ShareProducingInLivingAnimals_ForOutput1
RelationAllocCharactCont_Output1_To_Output2 = AllocCharactContents_ForOuput1/AllocCharactContents_ForOuput2


*In SOLm, we currently (9.5.2020) have the following livestock and co-producing animals:

Co-production  Meat producing          Milk producing  Egg producing

               Pigeons, other birds
               Asses
Meat/Milk      Buffaloes               Buffaloes
               Camelids, other
Meat/Milk      Camels                  Camels
Meat/Milk      Cattle                  Cattle
Meat/Eggs      Chickens                                Chickens
               Ducks
               Geese and guinea fowls
Meat/Milk      Goats                   Goats
               Horses
               Mules
               Pigs
               Rabbits and hares
               Rodents, other
Meat/Milk      Sheep                   Sheep
               Turkeys

this is captures in the following files defined in Steering File 1:
Livestock_NoCoupledOutputs
Livestock_CoupledMeatMilk
Livestock_CoupledMeatEggs

Cattle with its complications from the dairy and beef herd and meat output from the dairy as well is treated separately
Beef cattle has to be treated as a single-output meat activity
Dairy cattle as a coupled meat-milk activity


Thus first define the following too relations needed for allocation:

Relation_APU2_To_APU1 = ShareProducingInLivingAnimals_ForOutput2 / ShareProducingInLivingAnimals_ForOutput1
RelationAllocCharactCont_Output1_To_Output2 = AllocCharactContents_ForOuput1/AllocCharactContents_ForOuput2

Then calculate the impacts as lined out above:

Impact per unit Output 1: Impact_PerAPU_ForOutput1/[YieldOutput1 + Relation_APU2_To_APU1 * YieldOutput2/RelationAllocCharactCont_Output1_To_Output2]
Impact per unit Output 2: Impact_PerAPU_ForOutput1/[YieldOutput1*RelationAllocCharactCont_Output1_To_Output2 + Relation_APU2_To_APU1 * YieldOutput2]

*for mass-based allocation, the RelationAllocCharactCont_Output1_To_Output2 equals 1, thus:
Impact per unit Output 1: Impact_PerAPU_ForOutput1/[YieldOutput1 + Relation_APU2_To_APU1 * YieldOutput2]
Impact per unit Output 2: Impact_PerAPU_ForOutput1/[YieldOutput1 + Relation_APU2_To_APU1 * YieldOutput2]   thus, as it should be: identical for both outputs.


$offtext;

*Relation_APU2_To_APU1 = ShareProducingInLivingAnimals_ForOutput2 / ShareProducingInLivingAnimals_ForOutput1:
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share meat to milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Milk producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 $ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Meat producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios)
                 /ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"Egg producing","share animal type in total living animals",ProductionSystems,ProductionConditions,Scenarios);
*for the dairy meat animals, we have this relation of (meat producing per total dairy animals) / (milk producing per total dairy animals) already, it is
*ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios)
*thus:
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","share meat to milk producing animals (dairy herd)",ProductionSystems,ProductionConditions,Scenarios)
         = ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share_ProducingBeefAnInDairyHerdType In TotProdDairyMilkAnimals",ProductionSystems,ProductionConditions,Scenarios);

*RelationAllocCharactCont_Output1_To_Output2 = AllocCharactContents_ForOuput1/AllocCharactContents_ForOuput2:
*currently, those are needed for the following activities:
$ontext;
Set Livestock_CoupledMeatMilk(Activities)
/
Buffaloes
*camel milk is not important, thus do not address
*Camels
*cattle needs to be treated separately for allocation, cf. _V6_DerivePerPrimaryProductImpacts.gms
*Cattle
Goats
Sheep
/;
Set Livestock_CoupledMeatEggs(Activities)
/
Chickens
/;
$offtext;
*and use the following set to identify the commodities to work with: Match_ActivityOutputsToCommodities_Animals
*these are:
$ontext;
"Chickens"                   ."Meat (t)"              ."Meat, chicken"
"Chickens"                   ."Eggs (t)"              ."Eggs, hen, in shell"

"Buffaloes"                  ."Meat (t)"              ."Meat, buffaloes"
"Buffaloes"                  ."Milk (t)"              ."Milk, whole fresh buffalo"
"Goats"                      ."Meat (t)"              ."Meat, goat"
"Goats"                      ."Milk (t)"              ."Milk, whole fresh goat"
"Sheep"                      ."Meat (t)"              ."Meat, sheep"
"Sheep"                      ."Milk (t)"              ."Milk, whole fresh sheep"

*for meat/milk from dairy cattle:
"Cattle"                     ."Meat (t)"              ."Meat, cattle"
"Cattle"                     ."Milk (t)"              ."Milk, whole fresh cow"
$offtext;

ActAnimalsHead_OtherChar_MR(Regions_MR,"Chickens","AllAndAverageTypes","Relation protein contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_Contents_MR(Regions_MR,"Meat, chicken","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents_MR(Regions_MR,"Eggs, hen, in shell","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_Contents_MR(Regions_MR,"Meat, chicken","Protein (t)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,"Chickens","AllAndAverageTypes","Relation calorie contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_Contents_MR(Regions_MR,"Meat, chicken","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents_MR(Regions_MR,"Eggs, hen, in shell","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_Contents_MR(Regions_MR,"Meat, chicken","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,"Chickens","AllAndAverageTypes","Relation producer price - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_OtherChar_MR(Regions_MR,"Meat, chicken","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_OtherChar_MR(Regions_MR,"Eggs, hen, in shell","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_OtherChar_MR(Regions_MR,"Meat, chicken","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions_MR,"Buffaloes","AllAndAverageTypes","Relation protein contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_Contents_MR(Regions_MR,"Meat, buffaloes","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents_MR(Regions_MR,"Milk, whole fresh buffalo","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_Contents_MR(Regions_MR,"Meat, buffaloes","Protein (t)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,"Buffaloes","AllAndAverageTypes","Relation calorie contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_Contents_MR(Regions_MR,"Meat, buffaloes","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents_MR(Regions_MR,"Milk, whole fresh buffalo","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_Contents_MR(Regions_MR,"Meat, buffaloes","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,"Buffaloes","AllAndAverageTypes","Relation producer price - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_OtherChar_MR(Regions_MR,"Meat, buffaloes","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_OtherChar_MR(Regions_MR,"Milk, whole fresh buffalo","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_OtherChar_MR(Regions_MR,"Meat, buffaloes","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions_MR,"Goats","AllAndAverageTypes","Relation protein contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_Contents_MR(Regions_MR,"Meat, goat","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents_MR(Regions_MR,"Milk, whole fresh goat","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_Contents_MR(Regions_MR,"Meat, goat","Protein (t)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,"Goats","AllAndAverageTypes","Relation calorie contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_Contents_MR(Regions_MR,"Meat, goat","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents_MR(Regions_MR,"Milk, whole fresh goat","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_Contents_MR(Regions_MR,"Meat, goat","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,"Goats","AllAndAverageTypes","Relation producer price - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_OtherChar_MR(Regions_MR,"Meat, goat","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_OtherChar_MR(Regions_MR,"Milk, whole fresh goat","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_OtherChar_MR(Regions_MR,"Meat, goat","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsHead_OtherChar_MR(Regions_MR,"Sheep","AllAndAverageTypes","Relation protein contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_Contents_MR(Regions_MR,"Meat, sheep","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents_MR(Regions_MR,"Milk, whole fresh sheep","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_Contents_MR(Regions_MR,"Meat, sheep","Protein (t)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,"Sheep","AllAndAverageTypes","Relation calorie contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_Contents_MR(Regions_MR,"Meat, sheep","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents_MR(Regions_MR,"Milk, whole fresh sheep","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_Contents_MR(Regions_MR,"Meat, sheep","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,"Sheep","AllAndAverageTypes","Relation producer price - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_OtherChar_MR(Regions_MR,"Meat, sheep","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_OtherChar_MR(Regions_MR,"Milk, whole fresh sheep","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_OtherChar_MR(Regions_MR,"Meat, sheep","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios);

*and for the meat and milk production from dairy cattle:
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation protein contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_Contents_MR(Regions_MR,"Meat, cattle","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents_MR(Regions_MR,"Milk, whole fresh cow","Protein (t)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_Contents_MR(Regions_MR,"Meat, cattle","Protein (t)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation calorie contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_Contents_MR(Regions_MR,"Meat, cattle","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents_MR(Regions_MR,"Milk, whole fresh cow","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_Contents_MR(Regions_MR,"Meat, cattle","Calories (kcal)",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation producer price - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 $Commod_OtherChar_MR(Regions_MR,"Meat, cattle","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_OtherChar_MR(Regions_MR,"Milk, whole fresh cow","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios)
                 /Commod_OtherChar_MR(Regions_MR,"Meat, cattle","Producer price ($)",ProductionSystems,ProductionConditions,Scenarios);


*thus, we need to calculate the following, as lined out further up:
*Impact per unit Output 1: Impact_PerAPU_ForOutput1/[YieldOutput1 + Relation_APU2_To_APU1 * YieldOutput2/RelationAllocCharactCont_Output1_To_Output2]
*        =                 Impact_PerAPU_ForOutput1*RelationAllocCharactCont_Output1_To_Output2/[YieldOutput1*RelationAllocCharactCont_Output1_To_Output2 + Relation_APU2_To_APU1 * YieldOutput2]
*Impact per unit Output 2: Impact_PerAPU_ForOutput1                                            /[YieldOutput1*RelationAllocCharactCont_Output1_To_Output2 + Relation_APU2_To_APU1 * YieldOutput2]
*thus, the following factor is used repeatedly:
*1/[YieldOutput1*RelationAllocCharactCont_Output1_To_Output2 + Relation_APU2_To_APU1 * YieldOutput2], so asssign it specifically:
ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite mass-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
         = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
         = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

*and for beef and milk from the dairy herd:
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                $(ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","share meat to milk producing animals (dairy herd)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
          = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","share meat to milk producing animals (dairy herd)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));



ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite protein-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation protein contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
         = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation protein contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation protein contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
         = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation protein contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

*and for beef and milk from the dairy herd:
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation protein contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","share meat to milk producing animals (dairy herd)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
         = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation protein contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","share meat to milk producing animals (dairy herd)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));



ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite calorie-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation calorie contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
         = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation calorie contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation calorie contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
         = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation calorie contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

*and for beef and milk from the dairy herd:
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation calorie contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","share meat to milk producing animals (dairy herd)",ProductionSystems,ProductionConditions,Scenarios)
                          *ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
         = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation calorie contents - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","share meat to milk producing animals (dairy herd)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));



ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite price-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation producer price - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
         = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation producer price - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation producer price - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
         = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation producer price - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

*and for beef and milk from the dairy herd:
ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation producer price - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
                   + ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","share meat to milk producing animals (dairy herd)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Meat (t)",ProductionSystems,ProductionConditions,Scenarios))
         = 1/(ActAnimalsHead_Outputs_MR(Regions_MR,"Cattle","Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation producer price - Milk/Meat",ProductionSystems,ProductionConditions,Scenarios)
           + ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","share meat to milk producing animals (dairy herd)",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Meat (t)",ProductionSystems,ProductionConditions,Scenarios));


*then do the final calculations for the allocation:
*Impact per unit Output 1: Impact_PerAPU_ForOutput1*[CompositeAllocCharactRelatedFactor_Output1ToOutput2] * RelationAllocCharactCont_Output1_To_Output2
*Impact per unit Output 2: Impact_PerAPU_ForOutput1*[CompositeAllocCharactRelatedFactor_Output1ToOutput2]



$if %Allocation% == "Mass" $goto AllocationMassBased
$if %Allocation% == "Calories" $goto AllocationCalorieBased
$if %Allocation% == "Protein" $goto AllocationProteinBased
$if %Allocation% == "Price" $goto AllocationPriceBased
*the MainProduct-based allocation is not effective for governing meat/milk, meat/egg - for those, one of the others has to be chosen, it is only effective when processing further from meat, milk and eggs to derived main products and co-products.
$if %Allocation% == "MainProduct" $goto AllocationMassBased
*$if %Allocation% == "MainProduct" $goto AllocationCalorieBased
*$if %Allocation% == "MainProduct" $goto AllocationProteinBased
*$if %Allocation% == "MainProduct" $goto AllocationPriceBased



$label AllocationMassBased
*for the mass-based allocation, the Relation alloc characteristics Output 1 to Output 2 equals 1:
*Mass-based allocation meat/eggs:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation protein contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite mass-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite mass-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation protein contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite mass-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite mass-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation protein contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite mass-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite mass-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

*mass-based allocation meat/milk:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

*mass-based allocation meat/milk for the dairy herd:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Milk producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Milk producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite mass-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

$goto EndOfAllocationSpecificPerPrimProdCalculations




$label AllocationProteinBased

*protein-based allocation meat/eggs:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation protein contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite protein-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite protein-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation protein contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite protein-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite protein-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation protein contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite protein-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite protein-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

*protein-based allocation meat/milk:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

*protein-based allocation meat/milk for the dairy herd:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Milk producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Milk producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation protein contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite protein-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

$goto EndOfAllocationSpecificPerPrimProdCalculations



$label AllocationCalorieBased

*calorie-based allocation meat/eggs:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation calorie contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite calorie-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite calorie-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation calorie contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite calorie-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite calorie-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation calorie contents - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite calorie-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite calorie-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

*calorie-based allocation meat/milk:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation calorie contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation calorie contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation calorie contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

*calorie-based allocation meat/milk for dairy herd:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Milk producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation calorie contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Milk producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation calorie contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation calorie contents - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite calorie-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

$goto EndOfAllocationSpecificPerPrimProdCalculations




$label AllocationPriceBased

*price-based allocation meat/eggs:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation producer price - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite price-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite price-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation producer price - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite price-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite price-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"AllAndAverageTypes","Relation producer price - Eggs/Meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite price-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatEggs,"Egg producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","share meat to egg producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatEggs,"Meat producing","Composite price-based alloc factor - eggs/meat",ProductionSystems,ProductionConditions,Scenarios);

*price-based allocation meat/milk:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation producer price - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation producer price - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"AllAndAverageTypes","Relation producer price - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

*price-based allocation meat/milk for dairy herd:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Milk producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation producer price - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,"Cattle","Milk producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Milk producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation producer price - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,"Cattle","Milk producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","AllAndAverageTypes","Relation producer price - milk/meat",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);
FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
         = FeedingRationsAPU_Contents_MR(Regions_MR,"Cattle","Milk producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
**                         *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing","share meat to Milk producing animals",ProductionSystems,ProductionConditions,Scenarios)
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,"Cattle","Meat producing (from dairy herd)","Composite price-based alloc factor - milk/meat",ProductionSystems,ProductionConditions,Scenarios);

$goto EndOfAllocationSpecificPerPrimProdCalculations




$label EndOfAllocationSpecificPerPrimProdCalculations


*for some countries, the couple-producing milk/meat animals only produce meat, e.g. goats in Argentina, thus treat them as single-output animals, conditional on the per prim prod impacts not being calculated:
*and for the beef cattle herd and its meat production, we do it as for animals without coupled products:
ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
                         AND (NOT ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)))
         = sum(OutputsAnimals$Match_PerCommodImpact_AnimalsCommodOutputs(SubsetPerCommodImpact_OutputsAnimals,OutputsAnimals),
                 ActAnimalsAPU_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
                         AND (NOT ActAnimalsAPU_PerPrimProdImpact_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",SubsetPerCommodImpact_OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)))
         = sum(OtherCharAnimals$Match_PerCommodImpact_AnimalsCommodOtherChar(SubsetPerCommodImpact_OtherCharAnimals,OtherCharAnimals),
                 ActAnimalsAPU_OtherChar_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios));

FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
                         AND (NOT FeedingRationsAPU_PerPrimProdContents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)))
         = FeedingRationsAPU_Contents_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing",Commodities,"DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                        /ActAnimalsHead_Outputs_MR(Regions_MR,Livestock_CoupledMeatMilk,"Meat producing", "Meat (t)",ProductionSystems,ProductionConditions,Scenarios);



$ontext;
after this, we have all impacts etc. per ton primary product for all crop and animal activities, for animals with some allocation between coupled products, where necessary:
these are captured in the following three parameters:

ActCropsGrass_PerPrimProdImpact_MR(Regions,Activities,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) Impacts per primary product unit on activity level;
ActAnimalsAPU_PerPrimProdImpact_MR(Regions,Activities,AnimalTypeInHerd,PerCommodImpact,ProductionSystems,ProductionConditions,Scenarios) Impacts per primary product unit on activity level;

FeedingRationsAPU_PerPrimProdContents_MR(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios) Feed commodity inputs per primary product unit on activity level;
$offtext;









$exit;



