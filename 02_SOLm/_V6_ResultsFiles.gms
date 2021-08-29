PUTCLOSE con,"_V6_ResultsFiles";

*GENERAL DESCRIPTION
*This file contains all the code to produce some specifically designed results files with a selection of results of interest only, for further use, e.g. to produce graphs, etc.

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Results calculations for organic and vegan scenarios (MA Patricia Krayer, Kevin DeLuca)
- 2) Results calculations for the agroforestry scenarios in UNISECO
- 3) Some data for the bioenergy calculations for the ROSE project (Fei Wu)
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Results calculations for organic and vegan scenarios (MA Patricia Krayer, Kevin DeLuca)

SET Organic_Vegan_Results_Scenarios(Scenarios)
/
Baseline, BaselineDerived, FOFA_BAU_2050, FOFA_BAU_2050_Test,
FOFA_2050_VeganBAU_NoFreeAreaUse
FOFA_2050_VeganBAU
FOFA_2050_VeganBarbieri
FOFA_2050_VeganBarbieri_a
FOFA_2050_VeganSchmidt
FOFA_2050_VeganOptimized
FOFA_2050_VeganOptimized_conv

*Further scenarios for detailed analysis

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




/;

Set Organic_Vegan_Results_Indicators
/
"Cropland: temporary (incl. temp. grassland) (ha)"
"Cropland: temporary (without temp. grassland) (ha)"
"Cropland: permanent (ha)"
"Grassland: temporary (ha)"
"Grassland: permanent (ha)"
"Grassland: total (ha)"
"All Legumes (Nfixing) - incl. SetAside (no temp. grass)"
"Total cropland + grassland (ha)"

"Cattle (heads)"
"Pigs (heads)"
"Chickens (heads)"

"Calories per capita (kcal/cap/day): total"
"Protein per capita (g/cap/day): total"
"Calories per capita (kcal/cap/day): crop based"
"Protein per capita (g/cap/day): crop based"
"Calories per capita (kcal/cap/day): animal based"
"Protein per capita (g/cap/day): animal based"

"GHG emissions - animals, enteric ferment. (t CO2e)"
"GHG emissions - animals, manure management (t CO2e)"
"Total GHG emissions - animals (t CO2e)"
"Tot GHG em - crops/grass, no Defor/OrgSoils (t CO2e)"
"Tot GHG em - crops/grass, with Defor/OrgSoils (t CO2e)"
"Tot GHG em - all act, no Defor/OrgSoils (t CO2e)"
"Tot GHG em - all act, with Defor/OrgSoils (t CO2e)"

"NH3 emissions - areas (tNH3)"
"NH3 emissions - animals (tNH3)"
"NH3 emissions - total (tNH3)"

"Irrigation water (m3)"
"Irrigation water (m3) - water stress adjusted"
"Labour use - total, crops (h)"
"Labour use - total, animals (h)"
"Labour use - total (h)"
"Total CED (MJ)"

"Soil water erosion (t soil lost)"
"Aggreg. Pest. use level (index)"
"C sequestered in woody biomass (tC)"

"Producer value - crops ($)"
"Producer value - animals ($)"
"Producer value - total ($)"

"Labour productivity - crops ($/hour)"
"Labour productivity - animals ($/hour)"
"Labour productivity - total ($/hour)"

"Animal welfare: antibiotics use index"
"Animal welfare: heat stress index 2050"

"OECD N balance: inputs (tN)"
"OECD N balance: outputs (tN)"
"OECD N balance: Inputs - outputs (tN)"
"OECD N balance per ha (tN/ha)"

"N Fixation (tN)"
*"N in manure" here in the results file contains ONLY N in manure from livestock - N in human faeces and waste is captured separately (albeit in the model code, those two are currently treated by adding it to the manure quantities)
*fro crop res it is different: these include N harvested from permanet pasture and N in main biomass output from set aside land.
"N in manure (tN)"
"N in crop res (tN)"
"mineral N fert (tN)"
"N deposition (tN)"
"N inputs from seeds (tN)"

"N from human faeces for fert. (tN)"
"N from value chain waste for fert. (tN)"
"N from end use food waste for fert. (tN)"

"Self sufficiency calories (share)"
"Self sufficiency proteins (share)"
/;

Set Organic_Vegan_Results_Indicators_ForSums(Organic_Vegan_Results_Indicators)
/
"Cropland: temporary (incl. temp. grassland) (ha)"
"Cropland: temporary (without temp. grassland) (ha)"
"Cropland: permanent (ha)"
"Grassland: temporary (ha)"
"Grassland: permanent (ha)"
"Grassland: total (ha)"
"All Legumes (Nfixing) - incl. SetAside (no temp. grass)"
"Total cropland + grassland (ha)"

"Cattle (heads)"
"Pigs (heads)"
"Chickens (heads)"

"GHG emissions - animals, enteric ferment. (t CO2e)"
"GHG emissions - animals, manure management (t CO2e)"
"Total GHG emissions - animals (t CO2e)"
"Tot GHG em - crops/grass, no Defor/OrgSoils (t CO2e)"
"Tot GHG em - crops/grass, with Defor/OrgSoils (t CO2e)"
"Tot GHG em - all act, no Defor/OrgSoils (t CO2e)"
"Tot GHG em - all act, with Defor/OrgSoils (t CO2e)"

"NH3 emissions - areas (tNH3)"
"NH3 emissions - animals (tNH3)"
"NH3 emissions - total (tNH3)"

"Irrigation water (m3)"
"Irrigation water (m3) - water stress adjusted"
"Labour use - total, crops (h)"
"Labour use - total, animals (h)"
"Labour use - total (h)"
"Total CED (MJ)"

"Soil water erosion (t soil lost)"
"Aggreg. Pest. use level (index)"
"C sequestered in woody biomass (tC)"

"Producer value - crops ($)"
"Producer value - animals ($)"
"Producer value - total ($)"

"Animal welfare: antibiotics use index"
"Animal welfare: heat stress index 2050"

"OECD N balance: inputs (tN)"
"OECD N balance: outputs (tN)"
"OECD N balance: Inputs - outputs (tN)"

"N Fixation (tN)"
"N in manure (tN)"
"N in crop res (tN)"
"mineral N fert (tN)"
"N deposition (tN)"
"N inputs from seeds (tN)"

"N from human faeces for fert. (tN)"
"N from value chain waste for fert. (tN)"
"N from end use food waste for fert. (tN)"
/;


Set Organic_Vegan_Results_Indicators_NInputs(Organic_Vegan_Results_Indicators)
/
"N Fixation (tN)"
"N in manure (tN)"
"N in crop res (tN)"
"mineral N fert (tN)"
"N deposition (tN)"
"N inputs from seeds (tN)"
"N from human faeces for fert. (tN)"
"N from value chain waste for fert. (tN)"
"N from end use food waste for fert. (tN)"
/;

Parameter Organic_Vegan_Results_OrgCon(Regions,Organic_Vegan_Results_Indicators,ProductionSystems,Scenarios);
Parameter Organic_Vegan_Results(Regions,Organic_Vegan_Results_Indicators,Scenarios);
Parameter Organic_Vegan_Results_OrgCon_NInputs(Regions,Organic_Vegan_Results_Indicators,ProductionSystems,Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"Cropland: temporary (incl. temp. grassland) (ha)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"Cropland: temporary (incl. temp. grassland) (ha)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Cropland: temporary (without temp. grassland) (ha)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"Cropland: temporary (without temp. grassland) (ha)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Cropland: permanent (ha)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"Cropland: permanent (ha)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"Grassland: temporary (ha)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"Temporary meadows and pastures",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Grassland: permanent (ha)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"Permanent meadows and pastures",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Grassland: total (ha)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grass",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"All Legumes (Nfixing) - incl. SetAside (no temp. grass)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"All Legumes (Nfixing) - incl. SetAside (no temp. grass)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"Total cropland + grassland (ha)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"All Crops",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grass",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"Cattle (heads)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActAnimalsHead_QuantityActUnits_MR.l(Countries,"Cattle","AllAndAverageTypes",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Chickens (heads)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActAnimalsHead_QuantityActUnits_MR.l(Countries,"Chickens","AllAndAverageTypes",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Pigs (heads)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActAnimalsHead_QuantityActUnits_MR.l(Countries,"Pigs","AllAndAverageTypes",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"Calories per capita (kcal/cap/day): total",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Commod_OtherChar_MR(Countries,"All Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Protein per capita (g/cap/day): total",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Commod_OtherChar_MR(Countries,"All Commodities","Protein per capita (g/cap/day)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Calories per capita (kcal/cap/day): crop based",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Commod_OtherChar_MR(Countries,"All crop based Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Protein per capita (g/cap/day): crop based",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Commod_OtherChar_MR(Countries,"All crop based Commodities","Protein per capita (g/cap/day)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Calories per capita (kcal/cap/day): animal based",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Commod_OtherChar_MR(Countries,"All animal based Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Protein per capita (g/cap/day): animal based",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Commod_OtherChar_MR(Countries,"All animal based Commodities","Protein per capita (g/cap/day)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"GHG emissions - animals, enteric ferment. (t CO2e)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActAnimalsHead_Outputs_MR.l(Countries,"All Animals","AllAndAverageTypes","Enteric ferment (t CO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"GHG emissions - animals, manure management (t CO2e)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(Countries,"All Animals","AllAndAverageTypes","Manure Man GHG emissions - animals (tCO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"Total GHG emissions - animals (t CO2e)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActAnimalsHead_Outputs_MR.l(Countries,"All Animals","AllAndAverageTypes","Enteric ferment (t CO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VActAnimalsHead_OtherChar_MR.l(Countries,"All Animals","AllAndAverageTypes","Manure Man GHG emissions - animals (tCO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
*same as: VActAnimalsHead_OtherChar_MR.l(Countries_MR,"All Animals","AllAndAverageTypes","Total GHG emissions - animals (tCO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
Organic_Vegan_Results_OrgCon(Countries,"Tot GHG em - crops/grass, no Defor/OrgSoils (t CO2e)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(Countries,"All crops","Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VActCropsGrass_OtherChar_MR.l(Countries,"Grass","Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Tot GHG em - crops/grass, with Defor/OrgSoils (t CO2e)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(Countries,"All crops","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VActCropsGrass_OtherChar_MR.l(Countries,"Grass","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Tot GHG em - all act, no Defor/OrgSoils (t CO2e)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,"Total GHG emissions - animals (t CO2e)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 + Organic_Vegan_Results_OrgCon(Countries,"Tot GHG em - crops/grass, no Defor/OrgSoils (t CO2e)",ProductionSystems,Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Tot GHG em - all act, with Defor/OrgSoils (t CO2e)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,"Total GHG emissions - animals (t CO2e)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 + Organic_Vegan_Results_OrgCon(Countries,"Tot GHG em - crops/grass, with Defor/OrgSoils (t CO2e)",ProductionSystems,Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"NH3 emissions - areas (tNH3)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(Countries,"All crops and grass","NH3 from areas (tNH3)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"NH3 emissions - animals (tNH3)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(Countries,"All Animals","AllAndAverageTypes","NH3 from animals, - manure management (tNH3)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VActAnimalsHead_OtherChar_MR.l(Countries,"All Animals","AllAndAverageTypes","NH3 from animals, - grazing + housing (tNH3)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"NH3 emissions - total (tNH3)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,"NH3 emissions - areas (tNH3)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 + Organic_Vegan_Results_OrgCon(Countries,"NH3 emissions - animals (tNH3)",ProductionSystems,Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"Irrigation water (m3)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(Countries,"All crops and grass","Irrigation water (m3)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Irrigation water (m3) - water stress adjusted",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(Countries,"All crops and grass","Irrigation water (m3) - water stress adjusted",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Labour use - total, crops (h)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(Countries,"All crops and grass","Labour use - total (h)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Labour use - total, animals (h)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActAnimalsHead_Inputs_MR.l(Countries,"All Animals","AllAndAverageTypes","Labour use - total (h)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Labour use - total (h)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,"Labour use - total, crops (h)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 + Organic_Vegan_Results_OrgCon(Countries,"Labour use - total, animals (h)",ProductionSystems,Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Total CED (MJ)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(Countries,"All crops and grass","Total CED (MJ)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VActAnimalsHead_Inputs_MR.l(Countries,"All Animals","AllAndAverageTypes","Total CED (MJ)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"Soil water erosion (t soil lost)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(Countries,"All crops and grass","Soil water erosion (t soil lost)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Aggreg. Pest. use level (index)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(Countries,"All crops and grass","Aggreg. Pest. use level (index)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"C sequestered in woody biomass (tC)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(Countries,"All crops and grass","C sequestered in woody biomass (tC)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"Producer value - crops ($)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VCommod_OtherChar_MR.l(Countries,"All crop based Commodities","Producer price ($)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Producer value - animals ($)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VCommod_OtherChar_MR.l(Countries,"All animal based Commodities","Producer price ($)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Producer value - total ($)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,"Producer value - crops ($)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 + Organic_Vegan_Results_OrgCon(Countries,"Producer value - animals ($)",ProductionSystems,Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"Animal welfare: antibiotics use index",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(Countries,"All Animals","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Animal welfare: heat stress index 2050",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(Countries,"All Animals","AllAndAverageTypes","Animal welfare: heat stress index 2050",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: inputs (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(Countries,"All crops and grass","N fixation (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VActAnimalsHead_Outputs_MR.l(Countries,"All Animals","AllAndAverageTypes","N in manure (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VHumanCharacteristics_MR.l(Countries,"PopulationAll","N excretion in human faeces - for croplands (tN)","All commodities",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VCommod_Waste_Contents_MR.l(Countries,"All commodities","N for org. fert (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VCommod_Food_Contents_MR.l(Countries,"All commodities","N for org. fert (tN)",ProductionSystems,"AllProdCond","%Scenario%")
*for the OECD-balance, there is a small part covering inputs from residues; this seems to be those residues that are returned to the field, i.e. NOT those LEFT ON THE FIELD, but only Compost and biogas (currently) - thus do the sum without this.
                 + VCropResidues_Management_MR.l(Countries,"All Crops","Average Residues (t)","Crop res N for areas (tN) - for OECD N-balance","AllAndAverageCropResManSystem",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VMineralFertilizerQuantity_MR.l(Countries,"mineral N fert (N)","AllMinFertProdTech",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 + VActCropsGrass_Inputs_MR.l(Countries,"All crops","N deposition (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VActCropsGrass_Inputs_MR.l(Countries,"Grass","N deposition (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VActCropsGrass_Inputs_MR.l(Countries,"All Crops","N inputs from seeds (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: outputs (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VCommod_Contents_MR.l(Countries,"All commod. - prim. prod. from crop act.","N (t)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VCommod_Contents_MR.l(Countries,"Grass","N (t)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: Inputs - outputs (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: inputs (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 - Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: outputs (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"N Fixation (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(Countries,"All crops and grass","N fixation (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"N in manure (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActAnimalsHead_Outputs_MR.l(Countries,"All Animals","AllAndAverageTypes","N in manure (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"N in crop res (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VCropResidues_Management_MR.l(Countries,"All Crops","Average Residues (t)","Crop res N for areas (tN) - for OECD N-balance","AllAndAverageCropResManSystem",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"mineral N fert (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VMineralFertilizerQuantity_MR.l(Countries,"mineral N fert (N)","AllMinFertProdTech",ProductionSystems,Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"N deposition (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(Countries,"All crops","N deposition (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                 + VActCropsGrass_Inputs_MR.l(Countries,"Grass","N deposition (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"N inputs from seeds (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(Countries,"All Crops","N inputs from seeds (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"N from human faeces for fert. (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VHumanCharacteristics_MR.l(Countries,"PopulationAll","N excretion in human faeces - for croplands (tN)","All commodities",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"N from value chain waste for fert. (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VCommod_Waste_Contents_MR.l(Countries,"All commodities","N for org. fert (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"N from end use food waste for fert. (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = VCommod_Food_Contents_MR.l(Countries,"All commodities","N for org. fert (tN)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);

*now do the sums over org and conv systems and over regions for the whole of the EU plus CH- for the indicators that can be summed - the others are derived below:
Organic_Vegan_Results_OrgCon(Countries,Organic_Vegan_Results_Indicators_ForSums,"AllProdSyst",Organic_Vegan_Results_Scenarios)
                 $(NOT Organic_Vegan_Results_OrgCon(Countries,Organic_Vegan_Results_Indicators_ForSums,"AllProdSyst",Organic_Vegan_Results_Scenarios))
         =sum(ProdSyst_OrgCon,Organic_Vegan_Results_OrgCon(Countries,Organic_Vegan_Results_Indicators_ForSums,ProdSyst_OrgCon,Organic_Vegan_Results_Scenarios));

*this does not work for the OECD balance, as some AllProdSyst is already available, thus do separately:
*for this, first remove the AllProdSyst where there is org/conv, then calculate again to not loose values where we haave AllProdSyst only.
Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: inputs (tN)","AllProdSyst",Organic_Vegan_Results_Scenarios)
                 $(Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: inputs (tN)","Convent",Organic_Vegan_Results_Scenarios)
                         OR Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: inputs (tN)","Organic",Organic_Vegan_Results_Scenarios))
         = 0;
Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: outputs (tN)","AllProdSyst",Organic_Vegan_Results_Scenarios)
                 $(Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: outputs (tN)","Convent",Organic_Vegan_Results_Scenarios)
                         OR Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: outputs (tN)","Organic",Organic_Vegan_Results_Scenarios))
         = 0;

Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: inputs (tN)","AllProdSyst",Organic_Vegan_Results_Scenarios)
                 $(NOT Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: inputs (tN)","AllProdSyst",Organic_Vegan_Results_Scenarios))
         =sum(ProdSyst_OrgCon,Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: inputs (tN)",ProdSyst_OrgCon,Organic_Vegan_Results_Scenarios));
Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: outputs (tN)","AllProdSyst",Organic_Vegan_Results_Scenarios)
                 $(NOT Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: outputs (tN)","AllProdSyst",Organic_Vegan_Results_Scenarios))
         =sum(ProdSyst_OrgCon,Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: outputs (tN)",ProdSyst_OrgCon,Organic_Vegan_Results_Scenarios));
Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: Inputs - outputs (tN)","AllProdSyst",Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: inputs (tN)","AllProdSyst",Organic_Vegan_Results_Scenarios)
                 - Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: outputs (tN)","AllProdSyst",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results(Countries,Organic_Vegan_Results_Indicators_ForSums,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,Organic_Vegan_Results_Indicators_ForSums,"AllProdSyst",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results("World",Organic_Vegan_Results_Indicators_ForSums,Organic_Vegan_Results_Scenarios)
         =sum(Countries,Organic_Vegan_Results(Countries,Organic_Vegan_Results_Indicators_ForSums,Organic_Vegan_Results_Scenarios));

*derive AllProdSyst and whole world values for relative indicators:

*calories and protein per capita can directly be summed over org/con:
Set OrgVegResInd_PerCapNutriValues(Organic_Vegan_Results_Indicators)
/
"Calories per capita (kcal/cap/day): total"
"Protein per capita (g/cap/day): total"
"Calories per capita (kcal/cap/day): crop based"
"Protein per capita (g/cap/day): crop based"
"Calories per capita (kcal/cap/day): animal based"
"Protein per capita (g/cap/day): animal based"
/;

Organic_Vegan_Results_OrgCon(Countries,OrgVegResInd_PerCapNutriValues,"AllProdSyst",Organic_Vegan_Results_Scenarios)
                 $(NOT Organic_Vegan_Results_OrgCon(Countries,OrgVegResInd_PerCapNutriValues,"AllProdSyst",Organic_Vegan_Results_Scenarios))
         =sum(ProdSyst_OrgCon,Organic_Vegan_Results_OrgCon(Countries,OrgVegResInd_PerCapNutriValues,ProdSyst_OrgCon,Organic_Vegan_Results_Scenarios));
Organic_Vegan_Results(Countries,OrgVegResInd_PerCapNutriValues,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,OrgVegResInd_PerCapNutriValues,"AllProdSyst",Organic_Vegan_Results_Scenarios);


*now we do the org-con sum calculations, where truly no direct sums are possible:
Organic_Vegan_Results_OrgCon(Countries,"Labour productivity - crops ($/hour)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results_OrgCon(Countries,"Labour use - total, crops (h)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,"Producer value - crops ($)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results_OrgCon(Countries,"Labour use - total, crops (h)",ProductionSystems,Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Labour productivity - animals ($/hour)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results_OrgCon(Countries,"Labour use - total, animals (h)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,"Producer value - animals ($)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results_OrgCon(Countries,"Labour use - total, animals (h)",ProductionSystems,Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results_OrgCon(Countries,"Labour productivity - total ($/hour)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results_OrgCon(Countries,"Labour use - total (h)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,"Producer value - total ($)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results_OrgCon(Countries,"Labour use - total (h)",ProductionSystems,Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results_OrgCon(Countries,"OECD N balance per ha (tN/ha)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results_OrgCon(Countries,"Total cropland + grassland (ha)",ProductionSystems,Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results_OrgCon(Countries,"OECD N balance: Inputs - outputs (tN)",ProductionSystems,Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results_OrgCon(Countries,"Total cropland + grassland (ha)",ProductionSystems,Organic_Vegan_Results_Scenarios);


Organic_Vegan_Results(Countries,"Labour productivity - crops ($/hour)",Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results(Countries,"Labour use - total, crops (h)",Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results(Countries,"Producer value - crops ($)",Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results(Countries,"Labour use - total, crops (h)",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results(Countries,"Labour productivity - animals ($/hour)",Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results(Countries,"Labour use - total, animals (h)",Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results(Countries,"Producer value - animals ($)",Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results(Countries,"Labour use - total, animals (h)",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results(Countries,"Labour productivity - total ($/hour)",Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results(Countries,"Labour use - total (h)",Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results(Countries,"Producer value - total ($)",Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results(Countries,"Labour use - total (h)",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results(Countries,"OECD N balance per ha (tN/ha)",Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results(Countries,"Total cropland + grassland (ha)",Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results(Countries,"OECD N balance: Inputs - outputs (tN)",Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results(Countries,"Total cropland + grassland (ha)",Organic_Vegan_Results_Scenarios);

*and finally, do the calculations for these indicators on global level:
*first, derive per capita kcal etc supply:
VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
         = sum(Countries,VPopulationNumbers_MR.l(Countries,"PopulationAll",Organic_Vegan_Results_Scenarios));

VCommod_Food_Contents_MR.l("World","All Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
         = sum(Countries,VCommod_Food_Contents_MR.l(Countries,"All Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All Commodities","Protein (t)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
         = sum(Countries,VCommod_Food_Contents_MR.l(Countries,"All Commodities","Protein (t)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All crop based Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
         = sum(Countries,VCommod_Food_Contents_MR.l(Countries,"All crop based Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All crop based Commodities","Protein (t)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
         = sum(Countries,VCommod_Food_Contents_MR.l(Countries,"All crop based Commodities","Protein (t)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All animal based Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
         = sum(Countries,VCommod_Food_Contents_MR.l(Countries,"All animal based Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All animal based Commodities","Protein (t)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
         = sum(Countries,VCommod_Food_Contents_MR.l(Countries,"All animal based Commodities","Protein (t)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios));

VCommod_Food_Contents_MR.l("World","All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $(NOT VCommod_Food_Contents_MR.l("World","All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios))
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("World","All Commodities","Calories (kcal)",ProdSyst_OrgCon,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $(NOT VCommod_Food_Contents_MR.l("World","All Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios))
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("World","All Commodities","Protein (t)",ProdSyst_OrgCon,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All crop based Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $(NOT VCommod_Food_Contents_MR.l("World","All crop based Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios))
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("World","All crop based Commodities","Calories (kcal)",ProdSyst_OrgCon,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All crop based Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $(NOT VCommod_Food_Contents_MR.l("World","All crop based Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios))
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("World","All crop based Commodities","Protein (t)",ProdSyst_OrgCon,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All animal based Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $(NOT VCommod_Food_Contents_MR.l("World","All animal based Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios))
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("World","All animal based Commodities","Calories (kcal)",ProdSyst_OrgCon,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All animal based Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $(NOT VCommod_Food_Contents_MR.l("World","All animal based Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios))
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("World","All animal based Commodities","Protein (t)",ProdSyst_OrgCon,"AllProdCond",Organic_Vegan_Results_Scenarios));

Organic_Vegan_Results("World","Calories per capita (kcal/cap/day): total",Organic_Vegan_Results_Scenarios)
*Commod_OtherChar_MR("World","All Commodities","Calories per capita (kcal/cap/day)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("World","All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 /VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
                         /365;
Organic_Vegan_Results("World","Protein per capita (g/cap/day): total",Organic_Vegan_Results_Scenarios)
*Commod_OtherChar_MR("World","All Commodities","Protein per capita (g/cap/day)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("World","All Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 /VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
                         *1000000/365;
Organic_Vegan_Results("World","Calories per capita (kcal/cap/day): crop based",Organic_Vegan_Results_Scenarios)
*Commod_OtherChar_MR("World","All crop based Commodities","Calories per capita (kcal/cap/day)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("World","All crop based Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 /VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
                         /365;
Organic_Vegan_Results("World","Protein per capita (g/cap/day): crop based",Organic_Vegan_Results_Scenarios)
*Commod_OtherChar_MR("World","All crop based Commodities","Protein per capita (g/cap/day)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("World","All crop based Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 /VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
                         *1000000/365;
Organic_Vegan_Results("World","Calories per capita (kcal/cap/day): animal based",Organic_Vegan_Results_Scenarios)
*Commod_OtherChar_MR("World","All animal based Commodities","Calories per capita (kcal/cap/day)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("World","All animal based Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 /VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
                         /365;
Organic_Vegan_Results("World","Protein per capita (g/cap/day): animal based",Organic_Vegan_Results_Scenarios)
*Commod_OtherChar_MR("World","All animal based Commodities","Protein per capita (g/cap/day)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("World","All animal based Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 /VPopulationNumbers_MR.l("World","PopulationAll",Organic_Vegan_Results_Scenarios)
                         *1000000/365;

Organic_Vegan_Results("World","Labour use - total, crops (h)",Organic_Vegan_Results_Scenarios)
         = sum(Countries,Organic_Vegan_Results(Countries,"Labour use - total, crops (h)",Organic_Vegan_Results_Scenarios));
Organic_Vegan_Results("World","Labour use - total, animals (h)",Organic_Vegan_Results_Scenarios)
         = sum(Countries,Organic_Vegan_Results(Countries,"Labour use - total, animals (h)",Organic_Vegan_Results_Scenarios));
Organic_Vegan_Results("World","Labour use - total (h)",Organic_Vegan_Results_Scenarios)
         = sum(Countries,Organic_Vegan_Results(Countries,"Labour use - total (h)",Organic_Vegan_Results_Scenarios));

Organic_Vegan_Results("World","Producer value - crops ($)",Organic_Vegan_Results_Scenarios)
         = sum(Countries,Organic_Vegan_Results(Countries,"Producer value - crops ($)",Organic_Vegan_Results_Scenarios));
Organic_Vegan_Results("World","Producer value - animals ($)",Organic_Vegan_Results_Scenarios)
         = sum(Countries,Organic_Vegan_Results(Countries,"Producer value - animals ($)",Organic_Vegan_Results_Scenarios));
Organic_Vegan_Results("World","Producer value - total ($)",Organic_Vegan_Results_Scenarios)
         = sum(Countries,Organic_Vegan_Results(Countries,"Producer value - total ($)",Organic_Vegan_Results_Scenarios));

Organic_Vegan_Results("World","Labour productivity - crops ($/hour)",Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results("World","Labour use - total, crops (h)",Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results("World","Producer value - crops ($)",Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results("World","Labour use - total, crops (h)",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results("World","Labour productivity - animals ($/hour)",Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results("World","Labour use - total, animals (h)",Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results("World","Producer value - animals ($)",Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results("World","Labour use - total, animals (h)",Organic_Vegan_Results_Scenarios);
Organic_Vegan_Results("World","Labour productivity - total ($/hour)",Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results("World","Labour use - total (h)",Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results("World","Producer value - total ($)",Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results("World","Labour use - total (h)",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results("World","OECD N balance per ha (tN/ha)",Organic_Vegan_Results_Scenarios)
                 $Organic_Vegan_Results("World","Total cropland + grassland (ha)",Organic_Vegan_Results_Scenarios)
         = Organic_Vegan_Results("World","OECD N balance: Inputs - outputs (tN)",Organic_Vegan_Results_Scenarios)
                 /Organic_Vegan_Results("World","Total cropland + grassland (ha)",Organic_Vegan_Results_Scenarios);





*And finally, do the calculations for self-sufficiency indicators:

VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories - domestic prod. (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $(NOT VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories - domestic prod. (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios))
         =sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories - domestic prod. (kcal)",ProdSyst_OrgCon,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein - domestic prod. (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $(NOT VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein - domestic prod. (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios))
         =sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein - domestic prod. (t)",ProdSyst_OrgCon,"AllProdCond",Organic_Vegan_Results_Scenarios));

VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $(NOT VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios))
         =sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories (kcal)",ProdSyst_OrgCon,"AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 $(NOT VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios))
         =sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein (t)",ProdSyst_OrgCon,"AllProdCond",Organic_Vegan_Results_Scenarios));

VCommod_Food_Contents_MR.l("World","All Commodities","Calories - domestic prod. (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
         =sum(Countries,
                 VCommod_Food_Contents_MR.l(Countries,"All Commodities","Calories - domestic prod. (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All Commodities","Protein - domestic prod. (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
         =sum(Countries,
                 VCommod_Food_Contents_MR.l(Countries,"All Commodities","Protein - domestic prod. (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios));

VCommod_Food_Contents_MR.l("World","All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
         =sum(Countries,
                 VCommod_Food_Contents_MR.l(Countries,"All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios));
VCommod_Food_Contents_MR.l("World","All Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
         =sum(Countries,
                 VCommod_Food_Contents_MR.l(Countries,"All Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios));


Organic_Vegan_Results(Countries,"Self sufficiency calories (share)",Organic_Vegan_Results_Scenarios)
                 $VCommod_Food_Contents_MR.l(Countries,"All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
         = VCommod_Food_Contents_MR.l(Countries,"All Commodities","Calories - domestic prod. (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 /VCommod_Food_Contents_MR.l(Countries,"All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results(Countries,"Self sufficiency proteins (share)",Organic_Vegan_Results_Scenarios)
                 $VCommod_Food_Contents_MR.l(Countries,"All Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
         = VCommod_Food_Contents_MR.l(Countries,"All Commodities","Protein - domestic prod. (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 /VCommod_Food_Contents_MR.l(Countries,"All Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results("World","Self sufficiency calories (share)",Organic_Vegan_Results_Scenarios)
                 $VCommod_Food_Contents_MR.l("World","All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("World","All Commodities","Calories - domestic prod. (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 /VCommod_Food_Contents_MR.l("World","All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios);

Organic_Vegan_Results("World","Self sufficiency proteins (share)",Organic_Vegan_Results_Scenarios)
                 $VCommod_Food_Contents_MR.l("World","All Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("World","All Commodities","Protein - domestic prod. (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios)
                 /VCommod_Food_Contents_MR.l("World","All Commodities","Protein (t)","AllProdSyst","AllProdCond",Organic_Vegan_Results_Scenarios);


*collect N inputs separately:
Organic_Vegan_Results_OrgCon_NInputs(Regions,Organic_Vegan_Results_Indicators_NInputs,ProductionSystems,Scenarios)
         = Organic_Vegan_Results_OrgCon(Regions,Organic_Vegan_Results_Indicators_NInputs,ProductionSystems,Scenarios);



$ontext
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX kray: added here summation over crop rotation groups because not yet available in results

VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals1_NonV",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) =
            sum(Cereals1_V, VActCropsGrass_QuantityActUnits_MR.l(Countries,Cereals1_V,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) );
            
VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_cereals2_NonV",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) =
            sum(Cereals2_NonV, VActCropsGrass_QuantityActUnits_MR.l(Countries,Cereals2_NonV,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) );
            
 VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_StarchyRoots_NonV",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) =
            sum(StarchyRoots_NonV, VActCropsGrass_QuantityActUnits_MR.l(Countries,StarchyRoots_NonV,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) );
            
 VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_starchyCrops_NonV",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) =
            sum(StarchyCrops_NonV, VActCropsGrass_QuantityActUnits_MR.l(Countries,StarchyCrops_NonV,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) );
            
 VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_pulses_NonV",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) =
            sum(Pulses_V, VActCropsGrass_QuantityActUnits_MR.l(Countries,Pulses_V,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) );
            
VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_fruits_NonV",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) =
            sum(Fruits_V, VActCropsGrass_QuantityActUnits_MR.l(Countries,Fruits_V,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) );
            
VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_oilcrops_NonV",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) =
            sum(Oilcrops_V, VActCropsGrass_QuantityActUnits_MR.l(Countries,Oilcrops_V,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) );
            
VActCropsGrass_QuantityActUnits_MR.l(Countries,"All_setAside_NonV",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) =
            sum(SetAside_V, VActCropsGrass_QuantityActUnits_MR.l(Countries,SetAside_V,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) );
            

VActCropsGrass_QuantityActUnits_MR.l(Countries,"All Vegetables_NonV",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) =
            sum(Vegetables, VActCropsGrass_QuantityActUnits_MR.l(Countries,Vegetables,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios) );
            

*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX kray: added here summation over crop rotation groups end
$offtext


*XXXXXXXXXXXXXXXXXXX kray: added here calculations for weighted AAS-score (not corrected by ileal digestibility factor)XXXXXXXXXXX
Parameter AAS_aggregated(Regions, ProductionSystems,ProductionConditions, Organic_Vegan_Results_Scenarios);
AAS_aggregated(Countries, ProductionSystems, "AllProdCond", Organic_Vegan_Results_Scenarios)
*$(sum(Commodities_SingleCommodities, VCommod_Food_MR.l(Countries,Commodities_SingleCommodities,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)))
                                            = sum(Commodities_SingleCommodities,
                                                    VCommod_Food_MR.l(Countries,Commodities_SingleCommodities,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
*                                                     * Commod_Contents_MR(Countries,Commodities_SingleCommodities,"AAS (dmnl)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
                                                       * Commod_Contents_MR(Countries,Commodities_SingleCommodities,"AAS (dmnl)","AllProdSyst","AllProdCond","BaselineDerived")
                                                     );
*                                                            / sum(Commodities_SingleCommodities, VCommod_Food_MR.l(Countries,Commodities_SingleCommodities,ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios));
            



Parameter AAS_aggregated_global(ProductionSystems, ProductionConditions, Organic_Vegan_Results_Scenarios);
AAS_aggregated_global(ProductionSystems, "AllProdCond", Organic_Vegan_Results_Scenarios)
*$(VCommod_Food_MR.l("World","All Commodities",ProductionSystems,ProductionConditions,Organic_Vegan_Results_Scenarios))
*$(sum((Regions_MR, Commodities_MR), VCommod_Food_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%")))
                                                    = sum((Regions),
                                                            AAS_aggregated(Regions, ProductionSystems, "AllProdCond", Organic_Vegan_Results_Scenarios)
*                                                                *VCommod_Food_MR.l(Regions,Commodities_SingleCommodities,"AllProdCond",ProductionConditions,Organic_Vegan_Results_Scenarios)
                                                                )
*                                                                /VCommod_Food_MR.l("World","All Commodities","AllProdCond",ProductionConditions,Organic_Vegan_Results_Scenarios);
*                                                                / sum((Regions_MR, Commodities_MR),
*                                                               *VCommod_Food_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,"%Scenario%"));

*XXXXXXXXXXXXXXXXXXX kray: added here calculations for weighted AAS-score end XXXXXXXXXXX

$include xx_ahei_2010.gms


execute_unload "Results_%OutputFileLabel%"
Organic_Vegan_Results
Organic_Vegan_Results_OrgCon
Organic_Vegan_Results_OrgCon_NInputs
VCommod_Food_Contents_MR
VCommod_Food_Contents_Prod_MR
VActCropsGrass_QuantityActUnits_MR
CropRotationShare
VPopulationNumbers_MR
AAS_aggregated
AAS_aggregated_global

;


$exit;



check difference results and results_orgcon - and whether AllProdSyst and org/con is available or not, etc.
the following need to be availabel for all scenarios in the correct ProdSyst!!
VActCropsGrass_QuantityActUnits_MR.l(Countries,"Cropland: temporary (incl. temp. grassland) (ha)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
VActAnimalsHead_QuantityActUnits_MR.l(Countries,"Cattle","AllAndAverageTypes",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
VActAnimalsHead_Outputs_MR.l(Countries,"All Animals","AllAndAverageTypes","Enteric ferment (t CO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
VActAnimalsHead_OtherChar_MR.l(Countries,"All Animals","AllAndAverageTypes","Manure Man GHG emissions - animals (tCO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
VActCropsGrass_OtherChar_MR.l(Countries,"Grass","Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
VActCropsGrass_Inputs_MR.l(Countries,"All crops and grass","Labour use - total (h)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
VActAnimalsHead_Inputs_MR.l(Countries,"All Animals","AllAndAverageTypes","Labour use - total (h)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
VCommod_OtherChar_MR.l(Countries,"All animal based Commodities","Producer price ($)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios);
VCropResidues_Management_MR.l(Countries,"All Crops","Average Residues (t)","Crop res N for areas (tN) - for OECD N-balance","AllAndAverageCropResManSystem",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)
VMineralFertilizerQuantity_MR.l(Countries,"mineral N fert (N)","AllMinFertProdTech",ProductionSystems,Organic_Vegan_Results_Scenarios)
VCommod_Contents_MR.l(Countries,"All commod. - prim. prod. from crop act.","N (t)",ProductionSystems,"AllProdCond",Organic_Vegan_Results_Scenarios)

if needed: go on checking what is needed in line 329 above.


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Results calculations for the agroforestry scenarios in UNISECO

alias(UNISECO_AF_Results_Regions,FAO_EuropeanUnion_PlusCH);

SET UNISECO_AF_Results_Scenarios(Scenarios)
/
Baseline, BaselineDerived, FOFA_BAU_2050, FOFA_BAU_2050_Test, FOFA_2050_VeganBarbieri

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
/;

SET UNISECO_AF_Results_Scenarios_WithOrgCon(Scenarios)
/
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
/;

Set UNISECO_AF_Results_Indicators
/
"Cropland: crops without agricultural trees (ha)"
"Cropland: agricultural trees (ha)"
"Grassland (ha)"
"Total cropland + grassland (ha)"

"Cattle (heads)"
"Pigs (heads)"
"Chickens (heads)"

"Calories per capita (kcal/cap/day): total"
"Protein per capita (g/cap/day): total"
"Calories per capita (kcal/cap/day): crop based"
"Protein per capita (g/cap/day): crop based"
"Calories per capita (kcal/cap/day): animal based"
"Protein per capita (g/cap/day): animal based"

"GHG emissions - animals, enteric ferment. (t CO2e)"
"GHG emissions - animals, manure management (t CO2e)"
"Total GHG emissions - animals (t CO2e)"
"Tot GHG em - crops/grass, no Defor/OrgSoils (t CO2e)"
"Tot GHG em - crops/grass, with Defor/OrgSoils (t CO2e)"
"Tot GHG em - all act, no Defor/OrgSoils (t CO2e)"
"Tot GHG em - all act, with Defor/OrgSoils (t CO2e)"

"NH3 emissions - areas (tNH3)"
"NH3 emissions - animals (tNH3)"
"NH3 emissions - total (tNH3)"

"Irrigation water (m3)"
"Irrigation water (m3) - water stress adjusted"
"Labour use - total, crops (h)"
"Labour use - total, animals (h)"
"Labour use - total (h)"
"Total CED (MJ)"

"Soil water erosion (t soil lost)"
"Aggreg. Pest. use level (index)"
"C sequestered in woody biomass (tC)"

"Producer value - crops ($)"
"Producer value - animals ($)"
"Producer value - total ($)"

"Labour productivity - crops ($/hour)"
"Labour productivity - animals ($/hour)"
"Labour productivity - total ($/hour)"

"Animal welfare: antibiotics use index"
"Animal welfare: heat stress index 2050"

"OECD N balance: inputs (tN)"
"OECD N balance: outputs (tN)"
"OECD N balance: Inputs - outputs (tN)"
"OECD N balance per ha (tN/ha)"

"Self sufficiency calories (share)"
"Self sufficiency proteins (share)"
/;

Set UNISECO_AF_Results_Indicators_ForSums(UNISECO_AF_Results_Indicators)
/
"Cropland: crops without agricultural trees (ha)"
"Cropland: agricultural trees (ha)"
"Grassland (ha)"
"Total cropland + grassland (ha)"

"Cattle (heads)"
"Pigs (heads)"
"Chickens (heads)"

"GHG emissions - animals, enteric ferment. (t CO2e)"
"GHG emissions - animals, manure management (t CO2e)"
"Total GHG emissions - animals (t CO2e)"
"Tot GHG em - crops/grass, no Defor/OrgSoils (t CO2e)"
"Tot GHG em - crops/grass, with Defor/OrgSoils (t CO2e)"
"Tot GHG em - all act, no Defor/OrgSoils (t CO2e)"
"Tot GHG em - all act, with Defor/OrgSoils (t CO2e)"

"NH3 emissions - areas (tNH3)"
"NH3 emissions - animals (tNH3)"
"NH3 emissions - total (tNH3)"

"Irrigation water (m3)"
"Irrigation water (m3) - water stress adjusted"
"Labour use - total, crops (h)"
"Labour use - total, animals (h)"
"Labour use - total (h)"
"Total CED (MJ)"

"Soil water erosion (t soil lost)"
"Aggreg. Pest. use level (index)"
"C sequestered in woody biomass (tC)"

"Producer value - crops ($)"
"Producer value - animals ($)"
"Producer value - total ($)"

"Animal welfare: antibiotics use index"
"Animal welfare: heat stress index 2050"

"OECD N balance: inputs (tN)"
"OECD N balance: outputs (tN)"
"OECD N balance: Inputs - outputs (tN)"
/;


Parameter UNISECO_AF_Results_OrgCon(Regions,UNISECO_AF_Results_Indicators,ProductionSystems,Scenarios);
Parameter UNISECO_AF_Results(Regions,UNISECO_AF_Results_Indicators,Scenarios);


UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Cropland: crops without agricultural trees (ha)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(UNISECO_AF_Results_Regions,"Crops without Agricultural Trees",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Cropland: agricultural trees (ha)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(UNISECO_AF_Results_Regions,"Agricultural Trees",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Grassland (ha)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(UNISECO_AF_Results_Regions,"Grass",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Total cropland + grassland (ha)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(UNISECO_AF_Results_Regions,"All Crops",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
                 + VActCropsGrass_QuantityActUnits_MR.l(UNISECO_AF_Results_Regions,"Grass",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Cattle (heads)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActAnimalsHead_QuantityActUnits_MR.l(UNISECO_AF_Results_Regions,"Cattle","AllAndAverageTypes",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Chickens (heads)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActAnimalsHead_QuantityActUnits_MR.l(UNISECO_AF_Results_Regions,"Chickens","AllAndAverageTypes",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Pigs (heads)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActAnimalsHead_QuantityActUnits_MR.l(UNISECO_AF_Results_Regions,"Pigs","AllAndAverageTypes",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Calories per capita (kcal/cap/day): total",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = Commod_OtherChar_MR(UNISECO_AF_Results_Regions,"All Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Protein per capita (g/cap/day): total",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = Commod_OtherChar_MR(UNISECO_AF_Results_Regions,"All Commodities","Protein per capita (g/cap/day)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Calories per capita (kcal/cap/day): crop based",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = Commod_OtherChar_MR(UNISECO_AF_Results_Regions,"All crop based Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Protein per capita (g/cap/day): crop based",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = Commod_OtherChar_MR(UNISECO_AF_Results_Regions,"All crop based Commodities","Protein per capita (g/cap/day)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Calories per capita (kcal/cap/day): animal based",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = Commod_OtherChar_MR(UNISECO_AF_Results_Regions,"All animal based Commodities","Calories per capita (kcal/cap/day)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Protein per capita (g/cap/day): animal based",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = Commod_OtherChar_MR(UNISECO_AF_Results_Regions,"All animal based Commodities","Protein per capita (g/cap/day)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"GHG emissions - animals, enteric ferment. (t CO2e)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActAnimalsHead_Outputs_MR.l(UNISECO_AF_Results_Regions,"All Animals","AllAndAverageTypes","Enteric ferment (t CO2e)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"GHG emissions - animals, manure management (t CO2e)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All Animals","AllAndAverageTypes","Manure Man GHG emissions - animals (tCO2e)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Total GHG emissions - animals (t CO2e)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActAnimalsHead_Outputs_MR.l(UNISECO_AF_Results_Regions,"All Animals","AllAndAverageTypes","Enteric ferment (t CO2e)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
                 + VActAnimalsHead_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All Animals","AllAndAverageTypes","Manure Man GHG emissions - animals (tCO2e)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
*same as: VActAnimalsHead_OtherChar_MR.l(UNISECO_AF_Results_Regions_MR,"All Animals","AllAndAverageTypes","Total GHG emissions - animals (tCO2e)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Tot GHG em - crops/grass, no Defor/OrgSoils (t CO2e)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All crops","Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
                 + VActCropsGrass_OtherChar_MR.l(UNISECO_AF_Results_Regions,"Grass","Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Tot GHG em - crops/grass, with Defor/OrgSoils (t CO2e)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All crops","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
                 + VActCropsGrass_OtherChar_MR.l(UNISECO_AF_Results_Regions,"Grass","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Tot GHG em - all act, no Defor/OrgSoils (t CO2e)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Total GHG emissions - animals (t CO2e)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 + UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Tot GHG em - crops/grass, no Defor/OrgSoils (t CO2e)",ProductionSystems,UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Tot GHG em - all act, with Defor/OrgSoils (t CO2e)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Total GHG emissions - animals (t CO2e)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 + UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Tot GHG em - crops/grass, with Defor/OrgSoils (t CO2e)",ProductionSystems,UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"NH3 emissions - areas (tNH3)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All crops and grass","NH3 from areas (tNH3)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"NH3 emissions - animals (tNH3)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All Animals","AllAndAverageTypes","NH3 from animals, - manure management (tNH3)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
                 + VActAnimalsHead_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All Animals","AllAndAverageTypes","NH3 from animals, - grazing + housing (tNH3)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"NH3 emissions - total (tNH3)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"NH3 emissions - areas (tNH3)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 + UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"NH3 emissions - animals (tNH3)",ProductionSystems,UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Irrigation water (m3)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(UNISECO_AF_Results_Regions,"All crops and grass","Irrigation water (m3)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Irrigation water (m3) - water stress adjusted",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(UNISECO_AF_Results_Regions,"All crops and grass","Irrigation water (m3) - water stress adjusted",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour use - total, crops (h)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(UNISECO_AF_Results_Regions,"All crops and grass","Labour use - total (h)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour use - total, animals (h)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActAnimalsHead_Inputs_MR.l(UNISECO_AF_Results_Regions,"All Animals","AllAndAverageTypes","Labour use - total (h)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour use - total (h)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour use - total, crops (h)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 + UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour use - total, animals (h)",ProductionSystems,UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Total CED (MJ)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(UNISECO_AF_Results_Regions,"All crops and grass","Total CED (MJ)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
                 + VActAnimalsHead_Inputs_MR.l(UNISECO_AF_Results_Regions,"All Animals","AllAndAverageTypes","Total CED (MJ)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Soil water erosion (t soil lost)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All crops and grass","Soil water erosion (t soil lost)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Aggreg. Pest. use level (index)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All crops and grass","Aggreg. Pest. use level (index)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"C sequestered in woody biomass (tC)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All crops and grass","C sequestered in woody biomass (tC)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Producer value - crops ($)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VCommod_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All crop based Commodities","Producer price ($)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Producer value - animals ($)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VCommod_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All animal based Commodities","Producer price ($)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Producer value - total ($)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Producer value - crops ($)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 + UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Producer value - animals ($)",ProductionSystems,UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour productivity - crops ($/hour)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour use - total, crops (h)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Producer value - crops ($)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour use - total, crops (h)",ProductionSystems,UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour productivity - animals ($/hour)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour use - total, animals (h)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Producer value - animals ($)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour use - total, animals (h)",ProductionSystems,UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour productivity - total ($/hour)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour use - total (h)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Producer value - total ($)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Labour use - total (h)",ProductionSystems,UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Animal welfare: antibiotics use index",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All Animals","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Animal welfare: heat stress index 2050",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(UNISECO_AF_Results_Regions,"All Animals","AllAndAverageTypes","Animal welfare: heat stress index 2050",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"OECD N balance: inputs (tN)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VActCropsGrass_Inputs_MR.l(UNISECO_AF_Results_Regions,"All crops and grass","N fixation (tN)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
                 + VActAnimalsHead_Outputs_MR.l(UNISECO_AF_Results_Regions,"All Animals","AllAndAverageTypes","N in manure (tN)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
*for the OECD-balance, there is a small part covering inputs from residues; this seems to be those residues that are returned to the field, i.e. NOT those LEFT ON THE FIELD, but only Compost and biogas (currently) - thus do the sum without this.
                 + VCropResidues_Management_MR.l(UNISECO_AF_Results_Regions,"All Crops","Average Residues (t)","Crop res N for areas (tN) - for OECD N-balance","AllAndAverageCropResManSystem",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
                 + VMineralFertilizerQuantity_MR.l(UNISECO_AF_Results_Regions,"mineral N fert (N)","AllMinFertProdTech",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 + VActCropsGrass_Inputs_MR.l(UNISECO_AF_Results_Regions,"All crops","N deposition (tN)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
                 + VActCropsGrass_Inputs_MR.l(UNISECO_AF_Results_Regions,"Grass","N deposition (tN)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
                 + VActCropsGrass_Inputs_MR.l(UNISECO_AF_Results_Regions,"All Crops","N inputs from seeds (tN)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"OECD N balance: outputs (tN)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = VCommod_Contents_MR.l(UNISECO_AF_Results_Regions,"All commod. - prim. prod. from crop act.","N (t)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
                 + VCommod_Contents_MR.l(UNISECO_AF_Results_Regions,"Grass","N (t)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"OECD N balance: Inputs - outputs (tN)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"OECD N balance: inputs (tN)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 - UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"OECD N balance: outputs (tN)",ProductionSystems,UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"OECD N balance per ha (tN/ha)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Total cropland + grassland (ha)",ProductionSystems,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"OECD N balance: Inputs - outputs (tN)",ProductionSystems,UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,"Total cropland + grassland (ha)",ProductionSystems,UNISECO_AF_Results_Scenarios);

*now do the sums over org and conv systems and over regions for the whole of the EU plus CH- for the indicators that can be summed - the others are derived below:
UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,UNISECO_AF_Results_Indicators_ForSums,"AllProdSyst",UNISECO_AF_Results_Scenarios_WithOrgCon)
         =sum(ProdSyst_OrgCon,UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,UNISECO_AF_Results_Indicators_ForSums,ProdSyst_OrgCon,UNISECO_AF_Results_Scenarios_WithOrgCon));
UNISECO_AF_Results(UNISECO_AF_Results_Regions,UNISECO_AF_Results_Indicators_ForSums,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,UNISECO_AF_Results_Indicators_ForSums,"AllProdSyst",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results("European Union plus CH",UNISECO_AF_Results_Indicators_ForSums,UNISECO_AF_Results_Scenarios)
         =sum(UNISECO_AF_Results_Regions,UNISECO_AF_Results(UNISECO_AF_Results_Regions,UNISECO_AF_Results_Indicators_ForSums,UNISECO_AF_Results_Scenarios));

*derive AllProdSyst and whole EU+CH  values for relative indicators:

*calories and protein per capita can directly be summed over org/con:
Set UNISECOAFResInd_PerCapNutriValues(UNISECO_AF_Results_Indicators)
/
"Calories per capita (kcal/cap/day): total"
"Protein per capita (g/cap/day): total"
"Calories per capita (kcal/cap/day): crop based"
"Protein per capita (g/cap/day): crop based"
"Calories per capita (kcal/cap/day): animal based"
"Protein per capita (g/cap/day): animal based"
/;

UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,UNISECOAFResInd_PerCapNutriValues,"AllProdSyst",UNISECO_AF_Results_Scenarios_WithOrgCon)
         =sum(ProdSyst_OrgCon,UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,UNISECOAFResInd_PerCapNutriValues,ProdSyst_OrgCon,UNISECO_AF_Results_Scenarios_WithOrgCon));
UNISECO_AF_Results(UNISECO_AF_Results_Regions,UNISECOAFResInd_PerCapNutriValues,UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results_OrgCon(UNISECO_AF_Results_Regions,UNISECOAFResInd_PerCapNutriValues,"AllProdSyst",UNISECO_AF_Results_Scenarios);

*now we do the org-con sum calculations, where truly no direct sums are possible:
UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour productivity - crops ($/hour)",UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour use - total, crops (h)",UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Producer value - crops ($)",UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour use - total, crops (h)",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour productivity - animals ($/hour)",UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour use - total, animals (h)",UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Producer value - animals ($)",UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour use - total, animals (h)",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour productivity - total ($/hour)",UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour use - total (h)",UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Producer value - total ($)",UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour use - total (h)",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results(UNISECO_AF_Results_Regions,"OECD N balance per ha (tN/ha)",UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Total cropland + grassland (ha)",UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results(UNISECO_AF_Results_Regions,"OECD N balance: Inputs - outputs (tN)",UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Total cropland + grassland (ha)",UNISECO_AF_Results_Scenarios);

*and finally, do the calculations for these indicators on EU+CH level:
*first, derive per capita kcal etc supply:
VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,VPopulationNumbers_MR.l(UNISECO_AF_Results_Regions,"PopulationAll",UNISECO_AF_Results_Scenarios));

VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios));
VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Protein (t)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Protein (t)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios));
VCommod_Food_Contents_MR.l("European Union plus CH","All crop based Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All crop based Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios));
VCommod_Food_Contents_MR.l("European Union plus CH","All crop based Commodities","Protein (t)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All crop based Commodities","Protein (t)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios));
VCommod_Food_Contents_MR.l("European Union plus CH","All animal based Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All animal based Commodities","Calories (kcal)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios));
VCommod_Food_Contents_MR.l("European Union plus CH","All animal based Commodities","Protein (t)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All animal based Commodities","Protein (t)",ProductionSystems,"AllProdCond",UNISECO_AF_Results_Scenarios));

VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon)
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Calories (kcal)",ProdSyst_OrgCon,"AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon));
VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon)
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Protein (t)",ProdSyst_OrgCon,"AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon));
VCommod_Food_Contents_MR.l("European Union plus CH","All crop based Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon)
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("European Union plus CH","All crop based Commodities","Calories (kcal)",ProdSyst_OrgCon,"AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon));
VCommod_Food_Contents_MR.l("European Union plus CH","All crop based Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon)
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("European Union plus CH","All crop based Commodities","Protein (t)",ProdSyst_OrgCon,"AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon));
VCommod_Food_Contents_MR.l("European Union plus CH","All animal based Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon)
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("European Union plus CH","All animal based Commodities","Calories (kcal)",ProdSyst_OrgCon,"AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon));
VCommod_Food_Contents_MR.l("European Union plus CH","All animal based Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon)
         = sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l("European Union plus CH","All animal based Commodities","Protein (t)",ProdSyst_OrgCon,"AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon));

UNISECO_AF_Results("European Union plus CH","Calories per capita (kcal/cap/day): total",UNISECO_AF_Results_Scenarios)
*Commod_OtherChar_MR("European Union plus CH","All Commodities","Calories per capita (kcal/cap/day)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 $VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 /VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
                         /365;
UNISECO_AF_Results("European Union plus CH","Protein per capita (g/cap/day): total",UNISECO_AF_Results_Scenarios)
*Commod_OtherChar_MR("European Union plus CH","All Commodities","Protein per capita (g/cap/day)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 $VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 /VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
                         *1000000/365;
UNISECO_AF_Results("European Union plus CH","Calories per capita (kcal/cap/day): crop based",UNISECO_AF_Results_Scenarios)
*Commod_OtherChar_MR("European Union plus CH","All crop based Commodities","Calories per capita (kcal/cap/day)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 $VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("European Union plus CH","All crop based Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 /VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
                         /365;
UNISECO_AF_Results("European Union plus CH","Protein per capita (g/cap/day): crop based",UNISECO_AF_Results_Scenarios)
*Commod_OtherChar_MR("European Union plus CH","All crop based Commodities","Protein per capita (g/cap/day)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 $VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("European Union plus CH","All crop based Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 /VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
                         *1000000/365;
UNISECO_AF_Results("European Union plus CH","Calories per capita (kcal/cap/day): animal based",UNISECO_AF_Results_Scenarios)
*Commod_OtherChar_MR("European Union plus CH","All animal based Commodities","Calories per capita (kcal/cap/day)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 $VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("European Union plus CH","All animal based Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 /VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
                         /365;
UNISECO_AF_Results("European Union plus CH","Protein per capita (g/cap/day): animal based",UNISECO_AF_Results_Scenarios)
*Commod_OtherChar_MR("European Union plus CH","All animal based Commodities","Protein per capita (g/cap/day)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 $VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("European Union plus CH","All animal based Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 /VPopulationNumbers_MR.l("European Union plus CH","PopulationAll",UNISECO_AF_Results_Scenarios)
                         *1000000/365;

UNISECO_AF_Results("European Union plus CH","Labour use - total, crops (h)",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour use - total, crops (h)",UNISECO_AF_Results_Scenarios));
UNISECO_AF_Results("European Union plus CH","Labour use - total, animals (h)",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour use - total, animals (h)",UNISECO_AF_Results_Scenarios));
UNISECO_AF_Results("European Union plus CH","Labour use - total (h)",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Labour use - total (h)",UNISECO_AF_Results_Scenarios));

UNISECO_AF_Results("European Union plus CH","Producer value - crops ($)",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Producer value - crops ($)",UNISECO_AF_Results_Scenarios));
UNISECO_AF_Results("European Union plus CH","Producer value - animals ($)",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Producer value - animals ($)",UNISECO_AF_Results_Scenarios));
UNISECO_AF_Results("European Union plus CH","Producer value - total ($)",UNISECO_AF_Results_Scenarios)
         = sum(UNISECO_AF_Results_Regions,UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Producer value - total ($)",UNISECO_AF_Results_Scenarios));

UNISECO_AF_Results("European Union plus CH","Labour productivity - crops ($/hour)",UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results("European Union plus CH","Labour use - total, crops (h)",UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results("European Union plus CH","Producer value - crops ($)",UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results("European Union plus CH","Labour use - total, crops (h)",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results("European Union plus CH","Labour productivity - animals ($/hour)",UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results("European Union plus CH","Labour use - total, animals (h)",UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results("European Union plus CH","Producer value - animals ($)",UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results("European Union plus CH","Labour use - total, animals (h)",UNISECO_AF_Results_Scenarios);
UNISECO_AF_Results("European Union plus CH","Labour productivity - total ($/hour)",UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results("European Union plus CH","Labour use - total (h)",UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results("European Union plus CH","Producer value - total ($)",UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results("European Union plus CH","Labour use - total (h)",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results("European Union plus CH","OECD N balance per ha (tN/ha)",UNISECO_AF_Results_Scenarios)
                 $UNISECO_AF_Results("European Union plus CH","Total cropland + grassland (ha)",UNISECO_AF_Results_Scenarios)
         = UNISECO_AF_Results("European Union plus CH","OECD N balance: Inputs - outputs (tN)",UNISECO_AF_Results_Scenarios)
                 /UNISECO_AF_Results("European Union plus CH","Total cropland + grassland (ha)",UNISECO_AF_Results_Scenarios);





*And finally, do the calculations for self-sufficiency indicators:

VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories - domestic prod. (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon)
         =sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories - domestic prod. (kcal)",ProdSyst_OrgCon,"AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon));
VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein - domestic prod. (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon)
         =sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein - domestic prod. (t)",ProdSyst_OrgCon,"AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon));

VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon)
         =sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l(Regions,"All Commodities","Calories (kcal)",ProdSyst_OrgCon,"AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon));
VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon)
         =sum(ProdSyst_OrgCon,VCommod_Food_Contents_MR.l(Regions,"All Commodities","Protein (t)",ProdSyst_OrgCon,"AllProdCond",UNISECO_AF_Results_Scenarios_WithOrgCon));

VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Calories - domestic prod. (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
         =sum(UNISECO_AF_Results_Regions,
                 VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Calories - domestic prod. (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios));
VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Protein - domestic prod. (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
         =sum(UNISECO_AF_Results_Regions,
                 VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Protein - domestic prod. (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios));

VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
         =sum(UNISECO_AF_Results_Regions,
                 VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios));
VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
         =sum(UNISECO_AF_Results_Regions,
                 VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios));


UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Self sufficiency calories (share)",UNISECO_AF_Results_Scenarios)
                 $VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
         = VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Calories - domestic prod. (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 /VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results(UNISECO_AF_Results_Regions,"Self sufficiency proteins (share)",UNISECO_AF_Results_Scenarios)
                 $VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
         = VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Protein - domestic prod. (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 /VCommod_Food_Contents_MR.l(UNISECO_AF_Results_Regions,"All Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results("European Union plus CH","Self sufficiency calories (share)",UNISECO_AF_Results_Scenarios)
                 $VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Calories - domestic prod. (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 /VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Calories (kcal)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios);

UNISECO_AF_Results("European Union plus CH","Self sufficiency proteins (share)",UNISECO_AF_Results_Scenarios)
                 $VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
         = VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Protein - domestic prod. (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios)
                 /VCommod_Food_Contents_MR.l("European Union plus CH","All Commodities","Protein (t)","AllProdSyst","AllProdCond",UNISECO_AF_Results_Scenarios);




execute_unload "Results_%OutputFileLabel%"
UNISECO_AF_Results
UNISECO_AF_Results_OrgCon
;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Some data for the bioenergy calculations for the ROSE project (Fei Wu)

*from a mail from June 15, 2021, to Fei Wu:
* - amount of residues that is available from the fields, in dry matter.
* - by-product quantities that are available for energy use - i.e. that are not used for food and feed;
*        this is then the biomass quantity available in the current (or 2050 BAU projection) food system, without any changes of livestock numbers. As soon as you would use part of the by-products used for feed,
*        this would result in reduced livestock numbers - and this then opens many options for how to specify scenarios with more or less biomass for energy - I would postpone those and focus on the current situation or BAU 2050 in this first paper.
* - manure quantities that come with this current/BAU 2050 livestock numbers and that are not excreted on pastures but can be collected for energy use.

Set BioenergyDataElements
/
*residue quantities as available for energy use from the field (i.e. can be collected and used for energy production); unit: tons dry matter
"Residue Quantities (tDM) - available before management"

*commodity quantities, all and main/byproducts separately, in dry matter, domestically available quantities DAQ (DAQ = Produciton + Imports - Exports); unit: tons dry matter
*for those, we separate
*        - waste quantities (quite uncertain numbers), i.e. all waste from harvest till processing, usually NOT including retailer/consumer waste (this data on municipal waste, etc. (also sewage sludge, etc.) needs to be collected separately): this quantity can be used for energy use, subject to assumptions on huw much of this can easily be collected (on which aspect I have no data)
*        - "other use" quantities, i.e. other uses, which usually is not clear what it covers, part is already bioenergy, other is industrial uses (e.g. for fibres such as cotton); all in all also quite uncertain numbers;
*                this quantity can potentially also be used for energy use, but part will not be available for this (e.g. exclude cotton, rubber and other fibres and materials).
*        using the waste numbers may serve to identify a "minimal potential" for energy use from DAQs, using waste + other use may serve to identify an upper level for the potential
*the data also indicates man and byproducts, in case this is of interest for you
*importantly, these quantities contain also the quantities available from imports, not only domestic production - thus, they assess the potential for biomass for energy use within the current trade patterns
*        it is not so easy to identify which share may relate to domestic production, but if needed, I could try to derive some numbers for this domestically produced potential (but this would need somewhat more time - but would be possible).
"Commodities - DAQ (tDM): waste"
"Commodities - DAQ (tDM): other use"

"Main Products - DAQ (tDM): waste"
"Main Products - DAQ (tDM): other use"

*when checking the data, I realise that the byproduct data is really largely missing.....
"Byproducts - DAQ (tDM): waste"
"Byproducts - DAQ (tDM): other use"

*manure quantities available for bioenergy use, i.e. not excreted on pastures; units: Total solids in manure, tons dra matter
"Manure quantity - total solids (tDM)"
/;

Set Scenario_BaselineOr2050(Scenarios)
/
BaselineDerived, FOFA_BAU_2050
/;

Parameter BioenergyData(Regions,*,BioenergyDataElements,Scenario_BaselineOr2050);

BioenergyData(Countries,Activities_MR,"Residue Quantities (tDM) - available before management",Scenario_BaselineOr2050)
         = VCropResidues_Contents_MR.l(Countries,Activities_MR,"Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond",Scenario_BaselineOr2050);

BioenergyData(Countries,Commodities_MR,"Commodities - DAQ (tDM): waste",Scenario_BaselineOr2050)
         = VCommod_Waste_MR.l(Countries,Commodities_MR,"AllProdSyst","AllProdCond",Scenario_BaselineOr2050)
                 *Commod_Contents_MR(Countries,Commodities_MR,"DM (t)","AllProdSyst","AllProdCond",Scenario_BaselineOr2050);
BioenergyData(Countries,Commodities_MR,"Commodities - DAQ (tDM): other use",Scenario_BaselineOr2050)
         = VCommod_Other_MR.l(Countries,Commodities_MR,"AllProdSyst","AllProdCond",Scenario_BaselineOr2050)
                 *Commod_Contents_MR(Countries,Commodities_MR,"DM (t)","AllProdSyst","AllProdCond",Scenario_BaselineOr2050);

BioenergyData(Countries,Commodities_MR,"Main products - DAQ (tDM): waste",Scenario_BaselineOr2050)
                 $Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,"AggregateFeedConcMainProd_Commodity")
         = VCommod_Waste_MR.l(Countries,Commodities_MR,"AllProdSyst","AllProdCond",Scenario_BaselineOr2050)
                 *Commod_Contents_MR(Countries,Commodities_MR,"DM (t)","AllProdSyst","AllProdCond",Scenario_BaselineOr2050);
BioenergyData(Countries,Commodities_MR,"Main products - DAQ (tDM): other use",Scenario_BaselineOr2050)
                 $Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,"AggregateFeedConcMainProd_Commodity")
         = VCommod_Other_MR.l(Countries,Commodities_MR,"AllProdSyst","AllProdCond",Scenario_BaselineOr2050)
                 *Commod_Contents_MR(Countries,Commodities_MR,"DM (t)","AllProdSyst","AllProdCond",Scenario_BaselineOr2050);

BioenergyData(Countries,Commodities_MR,"Byproducts - DAQ (tDM): waste",Scenario_BaselineOr2050)
                 $Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,"AggregateFeedConcByProd_Commodity")
         = VCommod_Waste_MR.l(Countries,Commodities_MR,"AllProdSyst","AllProdCond",Scenario_BaselineOr2050)
                 *Commod_Contents_MR(Countries,Commodities_MR,"DM (t)","AllProdSyst","AllProdCond",Scenario_BaselineOr2050);
BioenergyData(Countries,Commodities_MR,"Byproducts - DAQ (tDM): other use",Scenario_BaselineOr2050)
                 $Match_FeedCommoditiesToFeedCommodGroups_MainByprodConc(Commodities_MR,"AggregateFeedConcByProd_Commodity")
         = VCommod_Other_MR.l(Countries,Commodities_MR,"AllProdSyst","AllProdCond",Scenario_BaselineOr2050)
                 *Commod_Contents_MR(Countries,Commodities_MR,"DM (t)","AllProdSyst","AllProdCond",Scenario_BaselineOr2050);

*if there are commodities for which there are not yet main or by-prod values, then assign them to main products (may happen e.g. for grass or forage commodities)
BioenergyData(Countries,Commodities_MR,"Main products - DAQ (tDM): waste",Scenario_BaselineOr2050)
                 $( (NOT BioenergyData(Countries,Commodities_MR,"Main products - DAQ (tDM): waste",Scenario_BaselineOr2050))
                         AND (NOT BioenergyData(Countries,Commodities_MR,"Byproducts - DAQ (tDM): waste",Scenario_BaselineOr2050)) )
         = BioenergyData(Countries,Commodities_MR,"Commodities - DAQ (tDM): waste",Scenario_BaselineOr2050);
BioenergyData(Countries,Commodities_MR,"Main products - DAQ (tDM): other use",Scenario_BaselineOr2050)
                 $( (NOT BioenergyData(Countries,Commodities_MR,"Main products - DAQ (tDM): other use",Scenario_BaselineOr2050))
                         AND (NOT BioenergyData(Countries,Commodities_MR,"Byproducts - DAQ (tDM): other use",Scenario_BaselineOr2050)) )
         = BioenergyData(Countries,Commodities_MR,"Commodities - DAQ (tDM): other use",Scenario_BaselineOr2050);

BioenergyData(Countries,"All animals","Manure quantity - total solids (tDM)",Scenario_BaselineOr2050)
         = sum((Livestock,AnimalTypeInHerd,ManureManSystemCropland),
                 VManure_Quantity_MR.l(Countries,Livestock,AnimalTypeInHerd,"AllProdSyst","AllProdCond",Scenario_BaselineOr2050)
                          *Manure_Management_MR(Countries,Livestock,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystemCropland,"AllAndAverageTemp","AllProdSyst","AllProdCond",Scenario_BaselineOr2050));


execute_unload "BioenergyData_BaselineOr2050"
BioenergyData
;


execute 'gdxdump BioenergyData_BaselineOr2050.gdx output=BioenergyData.csv   symb=BioenergyData   format=csv cDim=y'





$exit;











****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************

*TO CORRECT FOR THE green manure yield/crop residue problem in RCardinaals scenarios:
VActCropsGrass_Outputs_MR.l(FAO_EuropeanUnion,"Clover for Forage+Silage","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Bioenergy_RCardinaals_1")
         = VActCropsGrass_Outputs_MR.l(FAO_EuropeanUnion,"Clover for Forage+Silage","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Bioenergy_RCardinaals_1")
                 *100;
VActCropsGrass_Outputs_MR.l(FAO_EuropeanUnion,"Alfalfa for Forage+Silag","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Bioenergy_RCardinaals_1")
         = VActCropsGrass_Outputs_MR.l(FAO_EuropeanUnion,"Alfalfa for Forage+Silag","MainOutput1 (t)",ProductionSystems,ProductionConditions,"Bioenergy_RCardinaals_1")
                 *100;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) General result code

*CHECK: do global sums:
VMineralFertilizerQuantity_MR.l("World","mineral N fert (N)","AllMinFertProdTech",ProductionSystems,Scenarios)
         =sum(Regions_MR,VMineralFertilizerQuantity_MR.l(Regions_MR,"mineral N fert (N)","AllMinFertProdTech",ProductionSystems,Scenarios));


VActAnimalsHead_Outputs_MR.l("World","All Animals","AllAndAverageTypes","N in manure (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","N in manure (tN)",ProductionSystems,ProductionConditions,Scenarios));

VManure_Management_MR.l("World","All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,Scenarios));
VManure_Management_MR.l("World","All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VManure_Management_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,Scenarios));


VActCropsGrass_Inputs_MR.l("World","All Crops","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Regions_MR,Crops_MR),VActCropsGrass_Inputs_MR.l(Regions_MR,Crops_MR,"N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l("World","Grass","N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Regions_MR,TempAndPermMeadAndPastures),VActCropsGrass_Inputs_MR.l(Regions_MR,TempAndPermMeadAndPastures,"N fixation (tN)",ProductionSystems,ProductionConditions,Scenarios));


VCropResidues_Management_MR.l("World","All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios));
VCropResidues_Management_MR.l("World","All Crops","Average Residues (t)","Crop res P for areas (tP2O5)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VCropResidues_Management_MR.l(Regions_MR,"All Crops","Average Residues (t)","Crop res P for areas (tP2O5)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_OtherChar_MR.l("World","All Crops",OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops",OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_Management_MR.l("World","Miscanthus","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProductionSystems,ProductionConditions,Scenarios)
         = sum((Countries,CropResManSystemCropland),VCropResidues_Management_MR.l(Countries,"Miscanthus","Average Residues (t)","Crop res N for areas (tN)",CropResManSystemCropland,ProductionSystems,ProductionConditions,Scenarios));

VActForest_OtherChar_MR.l("World","Forest","Forest res bioe N for areas (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Countries,VActForest_OtherChar_MR.l(Countries,"Forest","Forest res bioe N for areas (tN)",ProductionSystems,ProductionConditions,Scenarios));

VCropResidues_Contents_MR.l("World","All Crops","Average residues (t)","N (t) - before management",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Regions_MR,Crops_MR),VCropResidues_Contents_MR.l(Regions_MR,Crops_MR,"Average residues (t)","N (t) - before management",ProductionSystems,ProductionConditions,Scenarios));

VActAnimalsHead_Outputs_MR.l("World","All animals","AllAndAverageTypes","All food output (t DM)",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Regions_MR,Livestock),
                 (VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Meat producing","Meat (t)",ProductionSystems,ProductionConditions,Scenarios)
                          *Commod_Contents_MR(Regions_MR,"Bovine meat","DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 +VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Milk producing","Milk (t)",ProductionSystems,ProductionConditions,Scenarios)
                          *Commod_Contents_MR(Regions_MR,"Milk, whole fresh cow","DM (t)",ProductionSystems,ProductionConditions,Scenarios)
                 +VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock,"Egg producing","Eggs (t)",ProductionSystems,ProductionConditions,Scenarios)
                          *Commod_Contents_MR(Regions_MR,"Eggs, hen, in shell","DM (t)",ProductionSystems,ProductionConditions,Scenarios)));


*VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
*         = sum((Activities_MR,OutputsAnimals,ProducingAnimals)$Match_ActivityOutputsToCommodities_Animals(Activities_MR,OutputsAnimals,Commodities_MR),
*                 VActAnimalsHead_Outputs_MR.l(Regions_MR,Activities_MR,ProducingAnimals,OutputsAnimals,ProductionSystems,ProductionConditions,Scenarios));

*derive contents in the primary commodities produced in the country:
VCommod_Contents_MR.l(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VCommod_Contents_MR.l(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios))
         = VCommod_Production_MR.l(Regions_MR,Commodities_MR,ProductionSystems,ProductionConditions,Scenarios)
                 *Commod_Contents_MR(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios);



VCommod_Feed_Contents_MR.l("World",Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VCommod_Feed_Contents_MR.l(Regions_MR,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios));


VCommod_Contents_MR.l("World",Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VCommod_Contents_MR.l(Regions_MR,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios));

VCommod_Contents_MR.l("World","All Commodities",Contents,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Commodities_MR,VCommod_Contents_MR.l("World",Commodities_MR,Contents,ProductionSystems,ProductionConditions,Scenarios));

*and world areas:
VActCropsGrass_QuantityActUnits_MR.l("World","All Crops",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Regions_MR,Crops_MR),VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_QuantityActUnits_MR.l("World","All Forage Crops",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Regions_MR,ForageCrops),VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,ForageCrops,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_QuantityActUnits_MR.l("World","All Legumes (Nfixing)",ProductionSystems,ProductionConditions,Scenarios)
         =sum((Regions_MR,Legumes_NFixing),VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Legumes_NFixing,ProductionSystems,ProductionConditions,Scenarios));


*N deposition:
VActCropsGrass_Inputs_MR.l(Regions_MR,"All crops","N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Crops_MR,
                 ActCropsGrass_Inputs_MR(Regions_MR,Crops_MR,"N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios)
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops_MR,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l("World","All crops","N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Regions_MR,VActCropsGrass_Inputs_MR.l(Regions_MR,"All crops","N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Inputs_MR.l(Regions_MR,"Grass","N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(TempAndPermMeadAndPastures,
                 ActCropsGrass_Inputs_MR(Regions_MR,TempAndPermMeadAndPastures,"N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios)
                         *VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,TempAndPermMeadAndPastures,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l("World","Grass","N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios)
         = sum(Regions_MR,VActCropsGrass_Inputs_MR.l(Regions_MR,"Grass","N deposition (tN)",ProductionSystems,ProductionConditions,Scenarios));



*do N etc. contents in crop outputs:
VCommod_Contents_MR.l(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
         = sum((Crops,OutputsCropsGrass)$Match_ActivityOutputsToCommodities_Crops(Crops,OutputsCropsGrass,Commodities_MR),
                 VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_Contents_MR(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios));

VCommod_Contents_MR.l("World",Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
         = sum(Regions_MR,VCommod_Contents_MR.l(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios));

VCommod_Contents_MR.l(Regions_MR,"All crop based Commodities",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
         = sum((Crops,OutputsCropsGrass,Commodities_MR)$Match_ActivityOutputsToCommodities_Crops(Crops,OutputsCropsGrass,Commodities_MR),
                 VActCropsGrass_Outputs_MR.l(Regions_MR,Crops,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_Contents_MR(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios));
VCommod_Contents_MR.l("World","All crop based Commodities",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VCommod_Contents_MR.l(Regions_MR,"All crop based Commodities",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios));

VCommod_Contents_MR.l(Regions_MR,"All Cereal Commodities",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
         = sum((Cereals,OutputsCropsGrass,Commodities_MR)$Match_ActivityOutputsToCommodities_Crops(Cereals,OutputsCropsGrass,Commodities_MR),
                 VActCropsGrass_Outputs_MR.l(Regions_MR,Cereals,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_Contents_MR(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios));
VCommod_Contents_MR.l("World","All Cereal Commodities",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VCommod_Contents_MR.l(Regions_MR,"All Cereal Commodities",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios));

*VCommod_Contents_MR.l(Regions_MR,"Grass",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
*         = sum((TempAndPermMeadAndPastures,OutputsCropsGrass,Commodities_MR)$Match_ActivityOutputsToCommodities_Crops(TempAndPermMeadAndPastures,OutputsCropsGrass,Commodities_MR),
*                 VActCropsGrass_Outputs_MR.l(Regions_MR,TempAndPermMeadAndPastures,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
*                         *Commod_Contents_MR(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios));
*correct grass ouptut and contents by the s/d ratio to capture the part that is eaten by animals only, not the one remaining on the field (these would be residues)
*Code WITHOUT this: just above
VCommod_Contents_MR.l(Regions_MR,"Grass",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
         = sum((TempAndPermMeadAndPastures,OutputsCropsGrass,Commodities_MR)$(Match_ActivityOutputsToCommodities_Crops(TempAndPermMeadAndPastures,OutputsCropsGrass,Commodities_MR)
                                                                                 AND Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,Scenarios)),
                 VActCropsGrass_Outputs_MR.l(Regions_MR,TempAndPermMeadAndPastures,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                                 /Commod_OtherChar_MR(Regions_MR,Commodities_MR,"Feed DM supply/demand ratio",ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_Contents_MR(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios));


VCommod_Contents_MR.l("World","Grass",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VCommod_Contents_MR.l(Regions_MR,"Grass",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios));

VCommod_Contents_MR.l(Regions_MR,"All Forage Commodities",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
         = sum((ForageCrops,OutputsCropsGrass,Commodities_MR)$Match_ActivityOutputsToCommodities_Crops(ForageCrops,OutputsCropsGrass,Commodities_MR),
                 VActCropsGrass_Outputs_MR.l(Regions_MR,ForageCrops,OutputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                         *Commod_Contents_MR(Regions_MR,Commodities_MR,ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios));
VCommod_Contents_MR.l("World","All Forage Commodities",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VCommod_Contents_MR.l(Regions_MR,"All Forage Commodities",ContentsPerFreshMatterNutrients,ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_Outputs_MR.l("World","Miscanthus","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,Scenarios)
         =sum(Regions_MR,VActCropsGrass_Outputs_MR.l(Regions_MR,"Miscanthus","MainOutput1 (t DM)",ProductionSystems,ProductionConditions,Scenarios));



VActCropsGrass_QuantityActUnits_MR.l("World","All Crops",ProductionSystems,ProductionConditions,Scenarios)
         = Sum((Regions_MR,Crops),VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,Crops,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_QuantityActUnits_MR.l("World","Grass",ProductionSystems,ProductionConditions,Scenarios)
         = Sum((Regions_MR,TempAndPermMeadAndPastures),VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,TempAndPermMeadAndPastures,ProductionSystems,ProductionConditions,Scenarios));
VActCropsGrass_QuantityActUnits_MR.l("World","Miscanthus",ProductionSystems,ProductionConditions,Scenarios)
         = Sum(Regions_MR,VActCropsGrass_QuantityActUnits_MR.l(Regions_MR,"Miscanthus",ProductionSystems,ProductionConditions,Scenarios));




*derive AllProdSyst for values where you have org and con:
*in the course of the calculations, some values for AllPRodSyst are already available also for org/con syst scenarios
*but partly they are intermediate only - and the condition here would then result in those taken as the final values
*thus we need to operate with different conditions to keep AllPRodSyst for the scenarios where this is the only prod syst available, and to replace intermediate values for other syst.
*hence the other condition.
VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,Scenarios)
*                 $(NOT VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"AllProdSyst",ProductionConditions,Scenarios))
                 $(VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"Convent",ProductionConditions,Scenarios)
                         OR VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,"Organic",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,Scenarios)
*                 $(NOT VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst",ProductionConditions,Scenarios))
                 $(VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Convent",ProductionConditions,Scenarios)
                         OR VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"Organic",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProdSyst_OrgCon,ProductionConditions,Scenarios));

VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,"AllProdSyst",ProductionConditions,Scenarios)
*                 $(NOT VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,"AllProdSyst",ProductionConditions,Scenarios))
                 $(VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,"Organic",ProductionConditions,Scenarios)
                         OR VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,"Convent",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,Scenarios)
*                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"AllProdSyst",ProductionConditions,Scenarios))
                 $(VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Organic",ProductionConditions,Scenarios)
                         OR VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,"Convent",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,Scenarios)
*                 $(NOT VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,Scenarios))
                 $(VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,Scenarios)
                         OR VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,Scenarios)
*                 $(NOT VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,"AllProdSyst",ProductionConditions,Scenarios))
                 $(VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,"Organic",ProductionConditions,Scenarios)
                         OR VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,"Convent",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,ProdSyst_OrgCon,ProductionConditions,Scenarios));


*the following may work with the old condition - but to be checked!
VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,"AllManManSystems","AllAndAverageTemp","AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,"AllManManSystems","AllAndAverageTemp","AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,"AllManManSystems","AllAndAverageTemp",ProdSyst_OrgCon,ProductionConditions,Scenarios));

VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,"AllAndAverageCropResManSystem","AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,"AllAndAverageCropResManSystem","AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,"AllAndAverageCropResManSystem",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProdSyst_OrgCon,ProductionConditions,Scenarios));

VActForest_OtherChar_MR.l(Regions,Activities,OtherCharForest,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VActForest_OtherChar_MR.l(Regions,Activities,OtherCharForest,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VActForest_OtherChar_MR.l(Regions,Activities,OtherCharForest,ProdSyst_OrgCon,ProductionConditions,Scenarios));

VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterNutrients,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterNutrients,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VCommod_Contents_MR.l(Regions,Commodities,ContentsPerFreshMatterNutrients,ProdSyst_OrgCon,ProductionConditions,Scenarios));
VCommod_Feed_Contents_MR.l(Regions,Commodities,Contents,"AllProdSyst",ProductionConditions,Scenarios)
                 $(NOT VCommod_Feed_Contents_MR.l(Regions,Commodities,Contents,"AllProdSyst",ProductionConditions,Scenarios))
         =sum(ProdSyst_OrgCon,VCommod_Feed_Contents_MR.l(Regions,Commodities,Contents,ProdSyst_OrgCon,ProductionConditions,Scenarios));




$ontext;
VActCropsGrass_Outputs_MR.l("World","Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         = sum(ProdSyst_OrgCon,VActCropsGrass_Outputs_MR.l("World","Miscanthus","MainOutput1 (t DM)",ProdSyst_OrgCon,"AllProdCond",Scenarios));
VCommod_Contents_MR.l("World","All crop based Commodities",ContentsPerFreshMatterNutrients,"AllProdSyst","AllProdCond",Scenarios)
         = sum(ProdSyst_OrgCon,VCommod_Contents_MR.l("World","All crop based Commodities",ContentsPerFreshMatterNutrients,ProdSyst_OrgCon,"AllProdCond",Scenarios));
VCommod_Contents_MR.l("World","Grass",ContentsPerFreshMatterNutrients,"AllProdSyst","AllProdCond",Scenarios)
         = sum(ProdSyst_OrgCon,VCommod_Contents_MR.l("World","Grass",ContentsPerFreshMatterNutrients,ProdSyst_OrgCon,"AllProdCond",Scenarios));
VCommod_Contents_MR.l("World","All Forage Commodities",ContentsPerFreshMatterNutrients,"AllProdSyst","AllProdCond",Scenarios)
         = sum(ProdSyst_OrgCon,VCommod_Contents_MR.l("World","All Forage Commodities",ContentsPerFreshMatterNutrients,ProdSyst_OrgCon,"AllProdCond",Scenarios));
VCommod_Contents_MR.l("World","All Cereal Commodities",ContentsPerFreshMatterNutrients,"AllProdSyst","AllProdCond",Scenarios)
         = sum(ProdSyst_OrgCon,VCommod_Contents_MR.l("World","All Cereal Commodities",ContentsPerFreshMatterNutrients,ProdSyst_OrgCon,"AllProdCond",Scenarios));
VCommod_Contents_MR.l("World","Miscanthus",ContentsPerFreshMatterNutrients,"AllProdSyst","AllProdCond",Scenarios)
         = sum(ProdSyst_OrgCon,VCommod_Contents_MR.l("World","Miscanthus",ContentsPerFreshMatterNutrients,ProdSyst_OrgCon,"AllProdCond",Scenarios));
VActCropsGrass_QuantityActUnits_MR.l("World","All Crops","AllProdSyst","AllProdCond",Scenarios)
         = sum(ProdSyst_OrgCon,VActCropsGrass_QuantityActUnits_MR.l("World","All Crops",ProdSyst_OrgCon,"AllProdCond",Scenarios));
VActCropsGrass_QuantityActUnits_MR.l("World","All Legumes (Nfixing)","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VActCropsGrass_QuantityActUnits_MR.l("World","All Legumes (Nfixing)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VMineralFertilizerQuantity_MR.l("World","mineral N fert (N)","AllMinFertProdTech","AllProdSyst",Scenarios)
         = sum(ProdSyst_OrgCon,VMineralFertilizerQuantity_MR.l("World","mineral N fert (N)","AllMinFertProdTech",ProdSyst_OrgCon,Scenarios));
VActAnimalsHead_Outputs_MR.l("World","All Animals","AllAndAverageTypes","N in manure (tN)","AllProdSyst","AllProdCond",Scenarios)
         = sum(ProdSyst_OrgCon,VActAnimalsHead_Outputs_MR.l("World","All Animals","AllAndAverageTypes","N in manure (tN)",ProdSyst_OrgCon,"AllProdCond",Scenarios));
VActCropsGrass_Inputs_MR.l("World","All Crops","N fixation (tN)","AllProdSyst","AllProdCond",Scenarios)
         = sum(ProdSyst_OrgCon,VActCropsGrass_Inputs_MR.l("World","All Crops","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond",Scenarios));
VActCropsGrass_Inputs_MR.l("World","Grass","N fixation (tN)","AllProdSyst","AllProdCond",Scenarios)
         = sum(ProdSyst_OrgCon,VActCropsGrass_Inputs_MR.l("World","Grass","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond",Scenarios));
VCropResidues_Management_MR.l("World","All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem","AllProdSyst","AllProdCond",Scenarios)
         = sum(ProdSyst_OrgCon,VCropResidues_Management_MR.l("World","All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProdSyst_OrgCon,"AllProdCond",Scenarios));
VActAnimalsHead_Outputs_MR.l("World","All animals","AllAndAverageTypes","All food output (t DM)","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VActAnimalsHead_Outputs_MR.l("World","All animals","AllAndAverageTypes","All food output (t DM)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l("World","All Crops","N fixation (tN)","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VActCropsGrass_Inputs_MR.l("World","All Crops","N fixation (tN)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l("World","Grass","N fixation (tN)","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VActCropsGrass_Inputs_MR.l("World","Grass","N fixation (tN)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActAnimalsHead_Outputs_MR.l("World","All Animals","AllAndAverageTypes","N in manure (tN)","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VActAnimalsHead_Outputs_MR.l("World","All Animals","AllAndAverageTypes","N in manure (tN)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VCropResidues_Management_MR.l("World","Miscanthus","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VCropResidues_Management_MR.l("World","Miscanthus","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VManure_Management_MR.l("World","All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VManure_Management_MR.l("World","All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VManure_Management_MR.l("World","All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VManure_Management_MR.l("World","All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VCropResidues_Contents_MR.l("World","All Crops","Average residues (t)","N (t) - before management","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VCropResidues_Contents_MR.l("World","All Crops","Average residues (t)","N (t) - before management",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActForest_OtherChar_MR.l("World","Forest","Forest res bioe N for areas (tN)","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VActForest_OtherChar_MR.l("World","Forest","Forest res bioe N for areas (tN)",ProdSyst_OrgCon,ProductionConditions,Scenarios));

VActCropsGrass_Inputs_MR.l("World","All crops","N deposition (tN)","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VActCropsGrass_Inputs_MR.l("World","All crops","N deposition (tN)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_Inputs_MR.l("World","Grass","N deposition (tN)","AllProdSyst",ProductionConditions,Scenarios)
         = sum(ProdSyst_OrgCon,VActCropsGrass_Inputs_MR.l("World","Grass","N deposition (tN)",ProdSyst_OrgCon,ProductionConditions,Scenarios));


VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Crops_MR,ProdSyst_OrgCon),VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l("World","All Crops","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Regions_MR,Crops_MR,ProdSyst_OrgCon),VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProdSyst_OrgCon,ProductionConditions,Scenarios));

VActCropsGrass_OtherChar_MR.l(Regions_MR,"Grass","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((TempAndPermMeadAndPastures,ProdSyst_OrgCon),VActCropsGrass_OtherChar_MR.l(Regions_MR,TempAndPermMeadAndPastures,"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l("World","Grass","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Regions_MR,TempAndPermMeadAndPastures,ProdSyst_OrgCon),VActCropsGrass_OtherChar_MR.l(Regions_MR,TempAndPermMeadAndPastures,"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ProdSyst_OrgCon,ProductionConditions,Scenarios));

VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","Total GHG em. - crops, no defor/orgSoils (tCO2e)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Crops_MR,ProdSyst_OrgCon),VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l("World","All Crops","Total GHG em. - crops, no defor/orgSoils (tCO2e)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Regions_MR,Crops_MR,ProdSyst_OrgCon),VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"Total GHG em. - crops, no defor/orgSoils (tCO2e)",ProdSyst_OrgCon,ProductionConditions,Scenarios));

VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Manure Man GHG emissions - animals (tCO2e)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Livestock_MR,AnimalTypeInHerd_MR,ProdSyst_OrgCon),VActAnimalsHead_OtherChar_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure Man GHG emissions - animals (tCO2e)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActAnimalsHead_OtherChar_MR.l("World","All Animals","AllAndAverageTypes","Manure Man GHG emissions - animals (tCO2e)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProdSyst_OrgCon),VActAnimalsHead_OtherChar_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Manure Man GHG emissions - animals (tCO2e)",ProdSyst_OrgCon,ProductionConditions,Scenarios));

*$offtext;
VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Total GHG emissions - animals (tCO2e)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Livestock_MR,AnimalTypeInHerd_MR,ProdSyst_OrgCon),VActAnimalsHead_OtherChar_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Total GHG emissions - animals (tCO2e)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
*$ontext;

VActAnimalsHead_OtherChar_MR.l("World","All Animals","AllAndAverageTypes","Total GHG emissions - animals (tCO2e)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProdSyst_OrgCon),VActAnimalsHead_OtherChar_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Total GHG emissions - animals (tCO2e)",ProdSyst_OrgCon,ProductionConditions,Scenarios));

VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Total N-losses from animals, - manure management (tN)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Livestock_MR,AnimalTypeInHerd_MR,ProdSyst_OrgCon),VActAnimalsHead_OtherChar_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Total N-losses from animals, - manure management (tN)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActAnimalsHead_OtherChar_MR.l("World","All Animals","AllAndAverageTypes","Total N-losses from animals, - manure management (tN)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,ProdSyst_OrgCon),VActAnimalsHead_OtherChar_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Total N-losses from animals, - manure management (tN)",ProdSyst_OrgCon,ProductionConditions,Scenarios));

VActCropsGrass_OtherChar_MR.l(Regions_MR,"All Crops","NH3 from areas (tNH3)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Crops_MR,ProdSyst_OrgCon),VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"NH3 from areas (tNH3)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActAnimalsHead_OtherChar_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","NH3 from animals, - manure management (tNH3)","AllProdSyst",ProductionConditions,Scenarios)
         =sum((Livestock_MR,AnimalTypeInHerd_MR,ProdSyst_OrgCon),VActAnimalsHead_OtherChar_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"NH3 from animals, - manure management (tNH3)",ProdSyst_OrgCon,ProductionConditions,Scenarios));

VActCropsGrass_Inputs_MR.l(Regions_MR,"All crops","N inputs - crops (tN)","AllProdSyst",ProductionConditions,Scenarios)
         = sum((Crops_MR,ProdSyst_OrgCon),VActCropsGrass_Inputs_MR.l(Regions_MR,Crops_MR,"N inputs - crops (tN)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_Outputs_MR.l(Regions_MR,"All crops","N outputs - crops (tN)","AllProdSyst",ProductionConditions,Scenarios)
         = sum((Crops_MR,ProdSyst_OrgCon),VActCropsGrass_Outputs_MR.l(Regions_MR,Crops_MR,"N outputs - crops (tN)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
VActCropsGrass_OtherChar_MR.l(Regions_MR,"All crops","N balance - plot level based (tN)","AllProdSyst",ProductionConditions,Scenarios)
         = sum((Crops_MR,ProdSyst_OrgCon),VActCropsGrass_OtherChar_MR.l(Regions_MR,Crops_MR,"N balance - plot level based (tN)",ProdSyst_OrgCon,ProductionConditions,Scenarios));
$offtext;

*VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Enteric ferment (t CO2e)","AllProdSyst",ProductionConditions,Scenarios)
*                 $(NOT VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Enteric ferment (t CO2e)","AllProdSyst",ProductionConditions,Scenarios))
*         =sum((Livestock_MR,AnimalTypeInHerd_MR,ProdSyst_OrgCon),VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Enteric ferment (t CO2e)",ProdSyst_OrgCon,ProductionConditions,Scenarios));

VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Enteric ferment (t CO2e)",ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActAnimalsHead_Outputs_MR.l(Regions_MR,"All Animals","AllAndAverageTypes","Enteric ferment (t CO2e)",ProductionSystems,ProductionConditions,Scenarios))
         =sum((Livestock_MR,AnimalTypeInHerd_MR),VActAnimalsHead_Outputs_MR.l(Regions_MR,Livestock_MR,AnimalTypeInHerd_MR,"Enteric ferment (t CO2e)",ProductionSystems,ProductionConditions,Scenarios));

VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Legumes (Nfixing)","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Legumes (Nfixing)","AllProdSyst","AllProdCond",Scenarios))
         =sum(ProdSyst_OrgCon,VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Legumes (Nfixing)",ProdSyst_OrgCon,"AllProdCond",Scenarios));

*TO DO IN THE SUM org+Conv = all: DM total crop and N in forage - then it is ok.




Set ResultsIndicator
/
"Cropland (ha)"
"Grassland (ha)"
"Energy crops (ha)"
"N fixing crops (ha)"

"N fixation (tN)"
"N fixation Crops (tN)"
"N fixation Grass (tN)"

"N deposition croplands (tN)"
"N deposition grasslands (tN)"

"N in manure excreted - before management/application (tN)"
"N in manure for crop areas (tN)"
"N in manure for grass areas (tN)"
"N in manure for total areas (tN)"

"P in manure excreted - before management/application (tP2O5)"

"N in Crop Residues for areas (tN)"
"N in Bioenergy Residues (Miscanthus) for areas (tN)"
"N in Bioenergy Residues (Forest) for areas (tN)"

"N mineral fert (tN)"

"P mineral fert (tP2O5)"

"N in total crop main output production (tN)"
"N in total grass main output production (tN)"
"N in forage crop main output production (tN)"
"N in energy crops production (tN)"
"N in Crop Residues exported from fields (tN)"

"N in total cereal main output production (tN)"

"P in total crop main output production (tP2O5)"
"P in total grass main output production (tP2O5)"


"OECD N balance: inputs (tN)"
"OECD N balance: outputs (tN)"
"OECD N balance: Inputs - outputs (tN)"
"OECD N balance per ha (tN/ha)"

"OECD P balance: inputs (tP2O5)"
"OECD P balance: outputs (tP2O5)"
"OECD P balance: Inputs - outputs (tP2O5)"
"OECD P balance per ha (tP2O5/ha)"

"OECD N balance cropland: inputs (tN)"
"OECD N balance cropland: outputs (tN)"
"OECD N balance cropland: Inputs - outputs (tN)"
"OECD N balance cropland per ha (tN/ha)"

"N balance - plant nutrition focus: inputs (tN)"
"N balance - plant nutrition focus: outputs (tN)"
"N balance - plant nutrition focus: Inp - outp (tN)"
"N balance - plant nutrition focus per ha (tN/ha)"

"DM in total crop main output production (tDM)"
"DM in total grass main output production (tDM)"
"DM in forage crop main output production (tDM)"
"DM in energy crops production (tDM)"
"DM in total cereal main output production (tDM)"
"DM animal source food output (tDM)"

"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)"
"Total GHG em. - anim + areas, incl. defor/orgSoils (tCO2e)"

*further:

"Enteric ferment (t CO2e)"

"Total GHG em. - crops, no defor/orgSoils (tCO2e)"
"Total N-losses from animals, - manure management (tN)"
"Manure Man GHG emissions - animals (tCO2e)"
"Total GHG emissions - animals (tCO2e)"
"N inputs - crops (tN)"
"N outputs - crops (tN)"
"N balance - plot level based (tN)"
"NH3 from areas (tNH3)"
"NH3 from animals, - manure management (tNH3)"

/;

Set ResultsIndicator_ForAggregates(ResultsIndicator)
/
"Cropland (ha)"
"Grassland (ha)"
"Energy crops (ha)"
"N fixing crops (ha)"

"N fixation (tN)"
"N fixation Crops (tN)"
"N fixation Grass (tN)"

"N deposition croplands (tN)"
"N deposition grasslands (tN)"

"N in manure excreted - before management/application (tN)"
"N in manure for crop areas (tN)"
"N in manure for grass areas (tN)"
"N in manure for total areas (tN)"

"P in manure excreted - before management/application (tP2O5)"

"N in Crop Residues for areas (tN)"
"N in Bioenergy Residues (Miscanthus) for areas (tN)"
"N in Bioenergy Residues (Forest) for areas (tN)"

"N mineral fert (tN)"

"P mineral fert (tP2O5)"

"N in total crop main output production (tN)"
"N in total grass main output production (tN)"
"N in forage crop main output production (tN)"
"N in energy crops production (tN)"
"N in Crop Residues exported from fields (tN)"

"N in total cereal main output production (tN)"

"P in total crop main output production (tP2O5)"
"P in total grass main output production (tP2O5)"

"OECD N balance: inputs (tN)"
"OECD N balance: outputs (tN)"
"OECD N balance: Inputs - outputs (tN)"
*"OECD N balance per ha (tN/ha)"

"OECD P balance: inputs (tP2O5)"
"OECD P balance: outputs (tP2O5)"
"OECD P balance: Inputs - outputs (tP2O5)"
*"OECD P balance per ha (tP2O5/ha)"

"OECD N balance cropland: inputs (tN)"
"OECD N balance cropland: outputs (tN)"
"OECD N balance cropland: Inputs - outputs (tN)"
*"OECD N balance cropland per ha (tN/ha)"

"N balance - plant nutrition focus: inputs (tN)"
"N balance - plant nutrition focus: outputs (tN)"
"N balance - plant nutrition focus: Inp - outp (tN)"
*"N balance - plant nutrition focus per ha (tN/ha)"

"DM in total crop main output production (tDM)"
"DM in total grass main output production (tDM)"
"DM in forage crop main output production (tDM)"
"DM in energy crops production (tDM)"
"DM in total cereal main output production (tDM)"
"DM animal source food output (tDM)"

"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)"
"Total GHG em. - anim + areas, incl. defor/orgSoils (tCO2e)"

*further:

"Enteric ferment (t CO2e)"

"Total GHG em. - crops, no defor/orgSoils (tCO2e)"
"Total N-losses from animals, - manure management (tN)"
"Manure Man GHG emissions - animals (tCO2e)"
"Total GHG emissions - animals (tCO2e)"
"N inputs - crops (tN)"
"N outputs - crops (tN)"
"N balance - plot level based (tN)"
"NH3 from areas (tNH3)"
"NH3 from animals, - manure management (tNH3)"
/;



Parameter Results(Regions,ResultsIndicator,Scenarios);

Parameter Results2(Regions,ResultsIndicator,Scenarios);

*choose a subset of scenarios to display to avoid values to be displayed that are not of interest (e.g. from other scenarios that are read in the model but not used here, etc.)
SET ScenariosResults(Scenarios)
/
*Baseline, BaselineDerived, FOFA_BAU_2012, FOFA_BAU_2050, FOFA_BAU_2050_Test, LfP_2050, AE_exports_2050, LfS_2050, AE_food_2050
*Baseline, BaselineDerived, FOFA_BAU_2050, FOFA_BAU_2050_Test, FOFA_BAU_2050_Test_10PercLessArea
*Baseline, BaselineDerived, FOFA_BAU_2050, FOFA_BAU_2050_25Organic   UNISECO_AF_shM_compM_yL_cM_5
*Baseline, BaselineDerived, FOFA_BAU_2050, FOFA_BAU_2050_Test
*Baseline, BaselineDerived, zhaw_NoFeedImports, zhaw_NoFeedImports_a
*Baseline, BaselineDerived
Baseline, BaselineDerived, FOFA_BAU_2050, UNISECO_AF_shM_compM_yL_cM_5, UNISECO_AF_shL_compM_yL_cM_5, UNISECO_AF_shH_compM_yL_cM_5
*Baseline, BaselineDerived, FOFA_BAU_2050, FOFA_BAU_2050_NoFCF
/;

*do it for all regions, not only globally - cf. below
*$ontext;
Results("World","Cropland (ha)",ScenariosResults)
         = VActCropsGrass_QuantityActUnits_MR.l("World","All Crops","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","Grassland (ha)",ScenariosResults)
         = VActCropsGrass_QuantityActUnits_MR.l("World","Grass","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","Energy crops (ha)",ScenariosResults)
         = VActCropsGrass_QuantityActUnits_MR.l("World","Miscanthus","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N fixing crops (ha)",ScenariosResults)
         = VActCropsGrass_QuantityActUnits_MR.l("World","All Legumes (Nfixing)","AllProdSyst","AllProdCond",ScenariosResults);


Results("World","DM animal source food output (tDM)",ScenariosResults)
         = VActAnimalsHead_Outputs_MR.l("World","All animals","AllAndAverageTypes","All food output (t DM)","AllProdSyst","AllProdCond",ScenariosResults);


Results("World","N fixation (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l("World","All Crops","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults)
                 + VActCropsGrass_Inputs_MR.l("World","Grass","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N fixation Crops (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l("World","All Crops","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N fixation Grass (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l("World","Grass","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults);

Results("World","N in manure excreted - before management/application (tN)",ScenariosResults)
         = VActAnimalsHead_Outputs_MR.l("World","All Animals","AllAndAverageTypes","N in manure (tN)","AllProdSyst","AllProdCond",ScenariosResults);

Results("World","N in manure for crop areas (tN)",ScenariosResults)
         = VManure_Management_MR.l("World","All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N in manure for grass areas (tN)",ScenariosResults)
         = VManure_Management_MR.l("World","All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N in manure for total areas (tN)",ScenariosResults)
         = Results("World","N in manure for crop areas (tN)",ScenariosResults)
                 + Results("World","N in manure for grass areas (tN)",ScenariosResults);

Results("World","N deposition croplands (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l("World","All crops","N deposition (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N deposition grasslands (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l("World","Grass","N deposition (tN)","AllProdSyst","AllProdCond",ScenariosResults);

Results("World","N in Crop Residues for areas (tN)",ScenariosResults)
         = VCropResidues_Management_MR.l("World","All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N in Bioenergy Residues (Miscanthus) for areas (tN)",ScenariosResults)
         = VCropResidues_Management_MR.l("World","Miscanthus","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N in Bioenergy Residues (Forest) for areas (tN)",ScenariosResults)
         = VActForest_OtherChar_MR.l("World","Forest","Forest res bioe N for areas (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N mineral fert (tN)",ScenariosResults)
         = VMineralFertilizerQuantity_MR.l("World","mineral N fert (N)","AllMinFertProdTech","AllProdSyst",ScenariosResults);


Results("World","N in total crop main output production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l("World","All crop based Commodities","N (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N in total grass main output production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l("World","Grass","N (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","DM in total crop main output production (tDM)",ScenariosResults)
         = VCommod_Contents_MR.l("World","All crop based Commodities","DM (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","DM in total grass main output production (tDM)",ScenariosResults)
         = VCommod_Contents_MR.l("World","Grass","DM (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N in forage crop main output production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l("World","All Forage Commodities","N (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","DM in forage crop main output production (tDM)",ScenariosResults)
         = VCommod_Contents_MR.l("World","All Forage Commodities","DM (t)","AllProdSyst","AllProdCond",ScenariosResults);

Results("World","DM in energy crops production (tDM)",ScenariosResults)
         = VActCropsGrass_Outputs_MR.l("World","Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N in energy crops production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l("World","Miscanthus","N (t)","AllProdSyst","AllProdCond",ScenariosResults);

Results("World","N in Crop Residues exported from fields (tN)",ScenariosResults)
         = VCropResidues_Contents_MR.l("World","All Crops","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond",ScenariosResults);



Results("World","DM in total cereal main output production (tDM)",ScenariosResults)
         = VCommod_Contents_MR.l("World","All Cereal Commodities","DM (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results("World","N in total cereal main output production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l("World","All Cereal Commodities","N (t)","AllProdSyst","AllProdCond",ScenariosResults);


*OECD-balance: total manure prod + total min fert + total fixation  - total crop and grass output
Results("World","OECD N balance: inputs (tN)",ScenariosResults)
         = Results("World","N fixation (tN)",ScenariosResults)
                 + Results("World","N in manure excreted - before management/application (tN)",ScenariosResults)
                 + Results("World","N in Bioenergy Residues (Forest) for areas (tN)",ScenariosResults)
                 + Results("World","N mineral fert (tN)",ScenariosResults);

Results("World","OECD N balance: outputs (tN)",ScenariosResults)
         = Results("World","N in total crop main output production (tN)",ScenariosResults)
                 + Results("World","N in total grass main output production (tN)",ScenariosResults);

Results("World","OECD N balance: Inputs - outputs (tN)",ScenariosResults)
         = Results("World","OECD N balance: inputs (tN)",ScenariosResults)
                 - Results("World","OECD N balance: outputs (tN)",ScenariosResults);

Results("World","OECD N balance per ha (tN/ha)",ScenariosResults)
                 $(Results("World","Cropland (ha)",ScenariosResults)
                         +Results("World","Grassland (ha)",ScenariosResults))
         = Results("World","OECD N balance: inputs - outputs (tN)",ScenariosResults)
                 /(Results("World","Cropland (ha)",ScenariosResults)
                         +Results("World","Grassland (ha)",ScenariosResults));


Results("World","OECD N balance cropland: inputs (tN)",ScenariosResults)
         = Results("World","N fixation Crops (tN)",ScenariosResults)
                 + Results("World","N in manure excreted - before management/application (tN)",ScenariosResults)
                 + Results("World","N in Bioenergy Residues (Forest) for areas (tN)",ScenariosResults)
                 + Results("World","N mineral fert (tN)",ScenariosResults);

Results("World","OECD N balance cropland: outputs (tN)",ScenariosResults)
         = Results("World","N in total crop main output production (tN)",ScenariosResults);

Results("World","OECD N balance cropland: inputs - outputs (tN)",ScenariosResults)
         = Results("World","OECD N balance cropland: inputs (tN)",ScenariosResults)
                 - Results("World","OECD N balance cropland: outputs (tN)",ScenariosResults);

Results("World","OECD N balance cropland per ha (tN/ha)",ScenariosResults)
                 $Results("World","Cropland (ha)",ScenariosResults)
         = Results("World","OECD N balance cropland: inputs - outputs (tN)",ScenariosResults)
                 /Results("World","Cropland (ha)",ScenariosResults);



*N-balance - plant nutrition focus:
Results("World","N balance - plant nutrition focus: inputs (tN)",ScenariosResults)
         = Results("World","N fixation Crops (tN)",ScenariosResults)
                 + Results("World","N in manure for crop areas (tN)",ScenariosResults)
                 + Results("World","N in Bioenergy Residues (Forest) for areas (tN)",ScenariosResults)
                 + Results("World","N in Crop Residues for areas (tN)",ScenariosResults)
                 + Results("World","N mineral fert (tN)",ScenariosResults)
                 + Results("World","N deposition croplands (tN)",ScenariosResults);


Results("World","N balance - plant nutrition focus: outputs (tN)",ScenariosResults)
         = Results("World","N in total crop main output production (tN)",ScenariosResults)
                 + Results("World","N in Crop Residues exported from fields (tN)",ScenariosResults);

Results("World","N balance - plant nutrition focus: Inp - outp (tN)",ScenariosResults)
         = Results("World","N balance - plant nutrition focus: inputs (tN)",ScenariosResults)
                 - Results("World","N balance - plant nutrition focus: outputs (tN)",ScenariosResults);

Results("World","N balance - plant nutrition focus per ha (tN/ha)",ScenariosResults)
                 $Results("World","Cropland (ha)",ScenariosResults)
         = Results("World","N balance - plant nutrition focus: Inp - outp (tN)",ScenariosResults)
                 /Results("World","Cropland (ha)",ScenariosResults);



Results("World","Total GHG em. - anim + areas, incl. defor/orgSoils (tCO2e)",ScenariosResults)
         = VActCropsGrass_OtherChar_MR.l("World","All Crops","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults)
                 + VActCropsGrass_OtherChar_MR.l("World","Grass","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults)
                 + VActAnimalsHead_OtherChar_MR.l("World","All Animals","AllAndAverageTypes","Total GHG emissions - animals (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults);
*$offtext;


*$ontext;

*Do the results for ALL regions:
Results(Regions,"Cropland (ha)",ScenariosResults)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Crops","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"Grassland (ha)",ScenariosResults)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Grass","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"Energy crops (ha)",ScenariosResults)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N fixing crops (ha)",ScenariosResults)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Legumes (Nfixing)","AllProdSyst","AllProdCond",ScenariosResults);


Results(Regions,"DM animal source food output (tDM)",ScenariosResults)
         = VActAnimalsHead_Outputs_MR.l(Regions,"All animals","AllAndAverageTypes","All food output (t DM)","AllProdSyst","AllProdCond",ScenariosResults);


Results(Regions,"N fixation (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l(Regions,"All Crops","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults)
                 + VActCropsGrass_Inputs_MR.l(Regions,"Grass","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N fixation Crops (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l(Regions,"All Crops","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N fixation Grass (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l(Regions,"Grass","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults);

Results(Regions,"N in manure excreted - before management/application (tN)",ScenariosResults)
         = VActAnimalsHead_Outputs_MR.l(Regions,"All Animals","AllAndAverageTypes","N in manure (tN)","AllProdSyst","AllProdCond",ScenariosResults);

Results(Regions,"P in manure excreted - before management/application (tP2O5)",ScenariosResults)
         = VActAnimalsHead_Outputs_MR.l(Regions,"All Animals","AllAndAverageTypes","P in manure (tP2O5)","AllProdSyst","AllProdCond",ScenariosResults);

Results(Regions,"N in manure for crop areas (tN)",ScenariosResults)
         = VManure_Management_MR.l(Regions,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N in manure for grass areas (tN)",ScenariosResults)
         = VManure_Management_MR.l(Regions,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N in manure for total areas (tN)",ScenariosResults)
         = Results(Regions,"N in manure for crop areas (tN)",ScenariosResults)
                 + Results(Regions,"N in manure for grass areas (tN)",ScenariosResults);

Results(Regions,"N deposition croplands (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l(Regions,"All crops","N deposition (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N deposition grasslands (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l(Regions,"Grass","N deposition (tN)","AllProdSyst","AllProdCond",ScenariosResults);

Results(Regions,"N in Crop Residues for areas (tN)",ScenariosResults)
         = VCropResidues_Management_MR.l(Regions,"All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N in Bioenergy Residues (Miscanthus) for areas (tN)",ScenariosResults)
         = VCropResidues_Management_MR.l(Regions,"Miscanthus","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N in Bioenergy Residues (Forest) for areas (tN)",ScenariosResults)
         = VActForest_OtherChar_MR.l(Regions,"Forest","Forest res bioe N for areas (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N mineral fert (tN)",ScenariosResults)
         = VMineralFertilizerQuantity_MR.l(Regions,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst",ScenariosResults);

Results(Regions,"P mineral fert (tP2O5)",ScenariosResults)
         = VMineralFertilizerQuantity_MR.l(Regions,"mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst",ScenariosResults);

Results(Regions,"N in total crop main output production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"All crop based Commodities","N (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N in total grass main output production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"Grass","N (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"DM in total crop main output production (tDM)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"All crop based Commodities","DM (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"DM in total grass main output production (tDM)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"Grass","DM (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N in forage crop main output production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"All Forage Commodities","N (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"DM in forage crop main output production (tDM)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"All Forage Commodities","DM (t)","AllProdSyst","AllProdCond",ScenariosResults);

Results(Regions,"P in total crop main output production (tP2O5)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"All crop based Commodities","P2O5 (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"P in total grass main output production (tP2O5)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"Grass","P2O5 (t)","AllProdSyst","AllProdCond",ScenariosResults);

Results(Regions,"DM in energy crops production (tDM)",ScenariosResults)
         = VActCropsGrass_Outputs_MR.l(Regions,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N in energy crops production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"Miscanthus","N (t)","AllProdSyst","AllProdCond",ScenariosResults);

Results(Regions,"N in Crop Residues exported from fields (tN)",ScenariosResults)
         = VCropResidues_Contents_MR.l(Regions,"All Crops","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond",ScenariosResults);



Results(Regions,"DM in total cereal main output production (tDM)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"All Cereal Commodities","DM (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results(Regions,"N in total cereal main output production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"All Cereal Commodities","N (t)","AllProdSyst","AllProdCond",ScenariosResults);


*OECD-balance: total min fert + total residues (applied to fields, not total production) + total manure prod + total fixation + total deposition + total seeds
*         - total crop and grass output -  total residues produced and exported (i.e. burned/exported)
*https://stats.oecd.org/index.aspx?queryid=79764

*An option would also be to do the OECD-balance "pragmatically", i.e. omitting what is often missing in the OECD data, namely residues/seeds:
*         thus, balance = total min fert + total manure prod + total fixation + total deposition
*                          - total crop and grass output

*furthermore, to be checked: the OECD-balance has some double counting with N-deposition, as most of this stems from the losses from total manure - but those are already included in the total manure part of the balance, aren't they?

Results(Regions,"OECD N balance: inputs (tN)",ScenariosResults)
         = Results(Regions,"N fixation (tN)",ScenariosResults)
                 + Results(Regions,"N in manure excreted - before management/application (tN)",ScenariosResults)
*                 + Results(Regions,"N in Bioenergy Residues (Forest) for areas (tN)",ScenariosResults)
*                 + Results(Regions,"N in Crop Residues for areas (tN)",ScenariosResults)
*for the OECD-balance, there is a small part covering inputs from residues; this seems to be those residues that are returned to the field, i.e. NOT those LEFT ON THE FIELD, but only Compost and biogas (currently) - thus do the sum without this.
                 + VCropResidues_Management_MR.l(Regions,"All Crops","Average Residues (t)","Crop res N for areas (tN) - for OECD N-balance","AllAndAverageCropResManSystem","AllPRodSyst","AllProdCond",ScenariosResults)
                 + Results(Regions,"N mineral fert (tN)",ScenariosResults)
                 + Results(Regions,"N deposition croplands (tN)",ScenariosResults)
                 + Results(Regions,"N deposition grasslands (tN)",ScenariosResults)
                 + VActCropsGrass_Inputs_MR.l(Regions,"All Crops","N inputs from seeds (tN)","AllProdSyst","AllProdCond",ScenariosResults);

Results(Regions,"OECD N balance: outputs (tN)",ScenariosResults)
         = Results(Regions,"N in total crop main output production (tN)",ScenariosResults)
                 + Results(Regions,"N in total grass main output production (tN)",ScenariosResults);

Results(Regions,"OECD N balance: Inputs - outputs (tN)",ScenariosResults)
         = Results(Regions,"OECD N balance: inputs (tN)",ScenariosResults)
                 - Results(Regions,"OECD N balance: outputs (tN)",ScenariosResults);

*do P-balance as well:
Results(Regions,"OECD P balance: inputs (tP2O5)",ScenariosResults)
         = Results(Regions,"P in manure excreted - before management/application (tP2O5)",ScenariosResults)
*                 + Results(Regions,"P in Bioenergy Residues (Forest) for areas (tP2O5)",ScenariosResults)
*                 + Results(Regions,"P in Crop Residues for areas (tP2O5)",ScenariosResults)
*for the OECD-balance, there is a small part covering inputs from residues; this seems to be those residues that are returned to the field, i.e. NOT those LEFT ON THE FIELD, but only Compost and biogas (currently) - thus do the sum without this.
                 + VCropResidues_Management_MR.l(Regions,"All Crops","Average Residues (t)","Crop res P for areas (tP2O5) - for OECD P-balance","AllAndAverageCropResManSystem","AllPRodSyst","AllProdCond",ScenariosResults)
                 + Results(Regions,"N mineral fert (tN)",ScenariosResults)
                 + VActCropsGrass_Inputs_MR.l(Regions,"All Crops","P inputs from seeds (tP2O5)","AllProdSyst","AllProdCond",ScenariosResults);

Results(Regions,"OECD P balance: outputs (tP2O5)",ScenariosResults)
         = Results(Regions,"P in total crop main output production (tP2O5)",ScenariosResults)
                 + Results(Regions,"P in total grass main output production (tP2O5)",ScenariosResults);

Results(Regions,"OECD P balance: Inputs - outputs (tP2O5)",ScenariosResults)
         = Results(Regions,"OECD P balance: inputs (tP2O5)",ScenariosResults)
                 - Results(Regions,"OECD P balance: outputs (tP2O5)",ScenariosResults);




*do some geographic aggregation:
Results("European Union",ResultsIndicator_ForAggregates,ScenariosResults)
         =sum(FAO_EuropeanUnion,Results(FAO_EuropeanUnion,ResultsIndicator_ForAggregates,ScenariosResults));




Results(Regions,"OECD N balance per ha (tN/ha)",ScenariosResults)
                 $(Results(Regions,"Cropland (ha)",ScenariosResults)
                         +Results(Regions,"Grassland (ha)",ScenariosResults))
         = Results(Regions,"OECD N balance: inputs - outputs (tN)",ScenariosResults)
                 /(Results(Regions,"Cropland (ha)",ScenariosResults)
                         +Results(Regions,"Grassland (ha)",ScenariosResults));


Results(Regions,"OECD N balance cropland: inputs (tN)",ScenariosResults)
         = Results(Regions,"N fixation Crops (tN)",ScenariosResults)
                 + Results(Regions,"N in manure excreted - before management/application (tN)",ScenariosResults)
*                 + Results(Regions,"N in Bioenergy Residues (Forest) for areas (tN)",ScenariosResults)
*                 + Results(Regions,"N in Crop Residues for areas (tN)",ScenariosResults)
*for the OECD-balance, there is a small part covering inputs from residues; this seems to be those residues that are returned to the field, i.e. NOT those LEFT ON THE FIELD, bu tonly Compost and biogas (currently) - thus do the sum without this.
                 + VCropResidues_Management_MR.l(Regions,"All Crops","Average Residues (t)","Crop res N for areas (tN) - for OECD N-balance","AllAndAverageCropResManSystem","AllPRodSyst","AllProdCond",ScenariosResults)
                 + Results(Regions,"N mineral fert (tN)",ScenariosResults)
                 + Results(Regions,"N deposition croplands (tN)",ScenariosResults);

Results(Regions,"OECD N balance cropland: outputs (tN)",ScenariosResults)
         = Results(Regions,"N in total crop main output production (tN)",ScenariosResults);

Results(Regions,"OECD N balance cropland: inputs - outputs (tN)",ScenariosResults)
         = Results(Regions,"OECD N balance cropland: inputs (tN)",ScenariosResults)
                 - Results(Regions,"OECD N balance cropland: outputs (tN)",ScenariosResults);

Results(Regions,"OECD N balance cropland per ha (tN/ha)",ScenariosResults)
                 $Results(Regions,"Cropland (ha)",ScenariosResults)
         = Results(Regions,"OECD N balance cropland: inputs - outputs (tN)",ScenariosResults)
                 /Results(Regions,"Cropland (ha)",ScenariosResults);



*N-balance - plant nutrition focus:
Results(Regions,"N balance - plant nutrition focus: inputs (tN)",ScenariosResults)
         = Results(Regions,"N fixation Crops (tN)",ScenariosResults)
                 + Results(Regions,"N in manure for crop areas (tN)",ScenariosResults)
*                 + Results(Regions,"N in Bioenergy Residues (Forest) for areas (tN)",ScenariosResults)
                 + Results(Regions,"N in Crop Residues for areas (tN)",ScenariosResults)
                 + Results(Regions,"N mineral fert (tN)",ScenariosResults)
                 + Results(Regions,"N deposition croplands (tN)",ScenariosResults);


Results(Regions,"N balance - plant nutrition focus: outputs (tN)",ScenariosResults)
         = Results(Regions,"N in total crop main output production (tN)",ScenariosResults)
                 + Results(Regions,"N in Crop Residues exported from fields (tN)",ScenariosResults);

Results(Regions,"N balance - plant nutrition focus: Inp - outp (tN)",ScenariosResults)
         = Results(Regions,"N balance - plant nutrition focus: inputs (tN)",ScenariosResults)
                 - Results(Regions,"N balance - plant nutrition focus: outputs (tN)",ScenariosResults);

Results(Regions,"N balance - plant nutrition focus per ha (tN/ha)",ScenariosResults)
                 $Results(Regions,"Cropland (ha)",ScenariosResults)
         = Results(Regions,"N balance - plant nutrition focus: Inp - outp (tN)",ScenariosResults)
                 /Results(Regions,"Cropland (ha)",ScenariosResults);



Results(Regions,"Total GHG em. - anim + areas, incl. defor/orgSoils (tCO2e)",ScenariosResults)
         = VActCropsGrass_OtherChar_MR.l(Regions,"All Crops","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults)
                 + VActCropsGrass_OtherChar_MR.l(Regions,"Grass","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults)
                 + VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","Total GHG emissions - animals (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults);




*do another results variable, Results2:

Results2(Regions,"Enteric ferment (t CO2e)",ScenariosResults)
         = VActAnimalsHead_Outputs_MR.l(Regions,"All Animals","AllAndAverageTypes","Enteric ferment (t CO2e)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ScenariosResults)
         = VActCropsGrass_OtherChar_MR.l(Regions,"All Crops","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"Total GHG em. - crops, no defor/orgSoils (tCO2e)",ScenariosResults)
         = VActCropsGrass_OtherChar_MR.l(Regions,"All Crops","Total GHG em. - crops, no defor/orgSoils (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"Manure Man GHG emissions - animals (tCO2e)",ScenariosResults)
         = VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","Manure Man GHG emissions - animals (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"Total GHG emissions - animals (tCO2e)",ScenariosResults)
         = VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","Total GHG emissions - animals (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"Total N-losses from animals, - manure management (tN)",ScenariosResults)
         = VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","Total N-losses from animals, - manure management (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"NH3 from areas (tNH3)",ScenariosResults)
         = VActCropsGrass_OtherChar_MR.l(Regions,"All Crops","NH3 from areas (tNH3)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"NH3 from animals, - manure management (tNH3)",ScenariosResults)
         = VActAnimalsHead_OtherChar_MR.l(Regions,"All Animals","AllAndAverageTypes","NH3 from animals, - manure management (tNH3)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"N inputs - crops (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l(Regions,"All crops","N inputs - crops (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"N outputs - crops (tN)",ScenariosResults)
         = VActCropsGrass_Outputs_MR.l(Regions,"All crops","N outputs - crops (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"N balance - plot level based (tN)",ScenariosResults)
         = VActCropsGrass_OtherChar_MR.l(Regions,"All crops","N balance - plot level based (tN)","AllProdSyst","AllProdCond",ScenariosResults);


Results2(Regions,"N in manure excreted - before management/application (tN)",ScenariosResults)
         = VActAnimalsHead_Outputs_MR.l(Regions,"All Animals","AllAndAverageTypes","N in manure (tN)","AllProdSyst","AllProdCond",ScenariosResults);

Results2(Regions,"N in manure for crop areas (tN)",ScenariosResults)
         = VManure_Management_MR.l(Regions,"All Animals","AllAndAverageTypes","Manure N for crop areas (tN)","AllManManSystems","AllAndAverageTemp","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"N in manure for grass areas (tN)",ScenariosResults)
         = VManure_Management_MR.l(Regions,"All Animals","AllAndAverageTypes","Manure N for grass areas (tN)","AllManManSystems","AllAndAverageTemp","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"N in manure for total areas (tN)",ScenariosResults)
         = Results(Regions,"N in manure for crop areas (tN)",ScenariosResults)
                 + Results(Regions,"N in manure for grass areas (tN)",ScenariosResults);

Results2(Regions,"N deposition croplands (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l(Regions,"All crops","N deposition (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"N deposition grasslands (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l(Regions,"Grass","N deposition (tN)","AllProdSyst","AllProdCond",ScenariosResults);

Results2(Regions,"N in Crop Residues for areas (tN)",ScenariosResults)
         = VCropResidues_Management_MR.l(Regions,"All Crops","Average Residues (t)","Crop res N for areas (tN)","AllAndAverageCropResManSystem","AllProdSyst","AllProdCond",ScenariosResults);

Results2(Regions,"N in total crop main output production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"All crop based Commodities","N (t)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"N in total grass main output production (tN)",ScenariosResults)
         = VCommod_Contents_MR.l(Regions,"Grass","N (t)","AllProdSyst","AllProdCond",ScenariosResults);


Results2("World","Manure Man GHG emissions - animals (tCO2e)",ScenariosResults)
         = sum(Regions_MR,Results2(Regions_MR,"Manure Man GHG emissions - animals (tCO2e)",ScenariosResults));
Results2("World","Enteric ferment (t CO2e)",ScenariosResults)
         = sum(Regions_MR,Results2(Regions_MR,"Enteric ferment (t CO2e)",ScenariosResults));

Results2(Regions,"Cropland (ha)",ScenariosResults)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Crops","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"Grassland (ha)",ScenariosResults)
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Grass","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"N fixation (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l(Regions,"All Crops","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults)
                 + VActCropsGrass_Inputs_MR.l(Regions,"Grass","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"N fixation Crops (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l(Regions,"All Crops","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults);
Results2(Regions,"N fixation Grass (tN)",ScenariosResults)
         = VActCropsGrass_Inputs_MR.l(Regions,"Grass","N fixation (tN)","AllProdSyst","AllProdCond",ScenariosResults);

*$offtext;


$ontext;
Results("World","N fixation Grass (tN)",ScenariosResults)

Results("World","N in manure excreted - before management/application (tN)",ScenariosResults)

Results("World","N in manure for grass areas (tN)",ScenariosResults)



Results("World","OECD N balance: inputs (tN)",ScenariosResults)
         = Results("World","N fixation (tN)",ScenariosResults)
                 + Results("World","N in manure excreted - before management/application (tN)",ScenariosResults)
                 + Results("World","N in Crop Residues for areas (tN)",ScenariosResults)
                 + Results("World","N mineral fert (tN)",ScenariosResults);

Results("World","OECD N balance: outputs (tN)",ScenariosResults)
         = Results("World","N in total crop main output production (tN)",ScenariosResults)
                 + Results("World","N in total grass main output production (tN)",ScenariosResults)
                 + Results("World","N in Crop Residues exported from fields (tN)",ScenariosResults);

Results("World","OECD N balance: Inputs - outputs (tN)",ScenariosResults)
         = Results("World","OECD N balance: inputs (tN)",ScenariosResults)
                 - Results("World","OECD N balance: outputs (tN)",ScenariosResults);

Results("World","OECD N balance per ha (tN/ha)",ScenariosResults)
                 $(Results("World","Cropland (ha)",ScenariosResults)
                         +Results("World","Grassland (ha)",ScenariosResults))
         = Results("World","OECD N balance: inputs - outputs (tN)",ScenariosResults)
                 /(Results("World","Cropland (ha)",ScenariosResults)
                         +Results("World","Grassland (ha)",ScenariosResults));



Results("World","OECD N balance cropland: inputs (tN)",ScenariosResults)
         = Results("World","N fixation Crops (tN)",ScenariosResults)
                 + Results("World","N in manure excreted - before management/application (tN)",ScenariosResults)
                 + Results("World","N in Crop Residues for areas (tN)",ScenariosResults)
                 + Results("World","N mineral fert (tN)",ScenariosResults);

Results("World","OECD N balance cropland: outputs (tN)",ScenariosResults)
         = Results("World","N in total crop main output production (tN)",ScenariosResults)
                 + Results("World","N in Crop Residues exported from fields (tN)",ScenariosResults);

Results("World","OECD N balance cropland: inputs - outputs (tN)",ScenariosResults)
         = Results("World","OECD N balance: inputs (tN)",ScenariosResults)
                 - Results("World","OECD N balance: outputs (tN)",ScenariosResults);

Results("World","OECD N balance cropland per ha (tN/ha)",ScenariosResults)
                 $Results("World","Cropland (ha)",ScenariosResults)
         = Results("World","OECD N balance cropland: inputs - outputs (tN)",ScenariosResults)
                 /Results("World","Cropland (ha)",ScenariosResults);


*N-balance - plant nutrition focus:
Results("World","N balance - plant nutrition focus: inputs (tN)",ScenariosResults)
         = Results("World","N fixation Crops (tN)",ScenariosResults)
                 + Results("World","N in manure for crop areas (tN)",ScenariosResults)
                 + Results("World","N in Bioenergy Residues (Forest) for areas (tN)",ScenariosResults)
                 + Results("World","N in Crop Residues for areas (tN)",ScenariosResults)
                 + Results("World","N mineral fert (tN)",ScenariosResults)
                 + Results("World","N deposition croplands (tN)",ScenariosResults);


Results("World","N balance - plant nutrition focus: outputs (tN)",ScenariosResults)
         = Results("World","N in total crop main output production (tN)",ScenariosResults)
                 + Results("World","N in Crop Residues exported from fields (tN)",ScenariosResults);

Results("World","N balance - plant nutrition focus: Inp - outp (tN)",ScenariosResults)
         = Results("World","N balance - plant nutrition focus: inputs (tN)",ScenariosResults)
                 - Results("World","N balance - plant nutrition focus: outputs (tN)",ScenariosResults);

Results("World","N balance - plant nutrition focus per ha (tN/ha)",ScenariosResults)
                 $Results("World","Cropland (ha)",ScenariosResults)
         = Results("World","N balance - plant nutrition focus: Inp - outp (tN)",ScenariosResults)
                 /Results("World","Cropland (ha)",ScenariosResults);



Results("World","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)",ScenariosResults)
         = VActCropsGrass_OtherChar_MR.l("World","All Crops","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults)
                 + VActAnimalsHead_OtherChar_MR.l("World","All Animals","AllAndAverageTypes","Total GHG emissions - animals (tCO2e)","AllProdSyst","AllProdCond",ScenariosResults);

$offtext;


*and a third output for Anita, Paper 2:
*PerCropCommodImpact_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact,ProductionSystems,ProductionConditions,ScenariosResults) Impacts per crop commodity unit;
*PerAnimalCommodImpact_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact,ProductionSystems,ProductionConditions,ScenariosResults) Impacts per animal commodity unit;
*PerAnimalCommodFeedInput_MR(Regions,Activities,OutputsAnimals,Commodities,Commodities_2,ProductionSystems,ProductionConditions,ScenariosResults) Feed commodity dry matter (t DM) per animal commodity unit;

Set PerCommodImpact_SubsetForAnita(PerCommodImpact)
/
"Land use (ha)"
"Cropland use (ha)"
"Grassland use (ha)"
"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)"
"Total GHG em. - crops, no defor/orgSoils (tCO2e)"
"Total GHG emissions - animals (tCO2e)"
"N balance - plot level based (tN)"
/;

Parameter Results_PerCropCommodImpact(Regions,Activities,OutputsCropsGrass,Commodities,AllocationCharacteristics,PerCommodImpact);
Parameter Results_PerAnimalCommodImpact(Regions,Activities,OutputsAnimals,Commodities,AllocationCharacteristics,PerCommodImpact);
Parameter Results_Switzerland_PerAnimalCommodFeedInput(Activities,OutputsAnimals,Commodities,AllocationCharacteristics,Commodities_2);

Parameter Results_PerCropCommodImpact_DifferentRefUnits(Regions,Activities,OutputsCropsGrass,Commodities,AllocationCharacteristics,PerCommodImpact,UnitOfReference_PerCommodImpacts);
Parameter Results_PerAnimalCommodImpact_DifferentRefUnits(Regions,Activities,OutputsAnimals,Commodities,AllocationCharacteristics,PerCommodImpact,UnitOfReference_PerCommodImpacts);
Parameter Results_Switzerland_PerAnimalCommodFeedInput_DifferentRefUnits(Activities,OutputsAnimals,Commodities,AllocationCharacteristics,Commodities_2,UnitOfReference_PerCommodImpacts);


$if %CalculateFootprints% == "NO" $goto EndOf_FootprintResults

Results_PerCropCommodImpact(Regions,Activities,OutputsCropsGrass,Commodities,AllocationCharacteristics,PerCommodImpact_SubsetForAnita)
         = PerCropCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact_SubsetForAnita,AllocationCharacteristics,"AllProdSyst","AllProdCond","BaselineDerived");
Results_PerAnimalCommodImpact(Regions,Activities,OutputsAnimals,Commodities,AllocationCharacteristics,PerCommodImpact_SubsetForAnita)
         = PerAnimalCommodImpact_WithAllocChar_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact_SubsetForAnita,AllocationCharacteristics,"AllProdSyst","AllProdCond","BaselineDerived");
Results_Switzerland_PerAnimalCommodFeedInput(Activities,OutputsAnimals,Commodities,AllocationCharacteristics,Commodities_2)
         = PerAnimalCommodFeedInput_WithAllocChar_MR("Switzerland",Activities,OutputsAnimals,Commodities,Commodities_2,AllocationCharacteristics,"AllProdSyst","AllProdCond","BaselineDerived");

Results_PerCropCommodImpact_DifferentRefUnits(Regions,Activities,OutputsCropsGrass,Commodities,AllocationCharacteristics,PerCommodImpact_SubsetForAnita,UnitOfReference_PerCommodImpacts)
         = PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsCropsGrass,Commodities,PerCommodImpact_SubsetForAnita,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,"AllProdSyst","AllProdCond","BaselineDerived");
Results_PerAnimalCommodImpact_DifferentRefUnits(Regions,Activities,OutputsAnimals,Commodities,AllocationCharacteristics,PerCommodImpact_SubsetForAnita,UnitOfReference_PerCommodImpacts)
         = PerAnimalCommodImpact_WithAllocChar_DifferentRefUnits_MR(Regions,Activities,OutputsAnimals,Commodities,PerCommodImpact_SubsetForAnita,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,"AllProdSyst","AllProdCond","BaselineDerived");
Results_Switzerland_PerAnimalCommodFeedInput_DifferentRefUnits(Activities,OutputsAnimals,Commodities,AllocationCharacteristics,Commodities_2,UnitOfReference_PerCommodImpacts)
         = PerAnimalCommodFeedInput_WithAllocChar_DifferentRefUnits_MR("Switzerland",Activities,OutputsAnimals,Commodities,Commodities_2,AllocationCharacteristics,UnitOfReference_PerCommodImpacts,"AllProdSyst","AllProdCond","BaselineDerived");

execute_unload "Results_Anita"
Results_PerCropCommodImpact
Results_PerAnimalCommodImpact
Results_Switzerland_PerAnimalCommodFeedInput

Results_PerCropCommodImpact_DifferentRefUnits
Results_PerAnimalCommodImpact_DifferentRefUnits
Results_Switzerland_PerAnimalCommodFeedInput_DifferentRefUnits
;

$label EndOf_FootprintResults


*do some geographic aggregation:
Results("European Union",ResultsIndicator_ForAggregates,ScenariosResults)
         =sum(FAO_EuropeanUnion,Results(FAO_EuropeanUnion,ResultsIndicator_ForAggregates,ScenariosResults));
Results2("European Union",ResultsIndicator_ForAggregates,ScenariosResults)
         =sum(FAO_EuropeanUnion,Results2(FAO_EuropeanUnion,ResultsIndicator_ForAggregates,ScenariosResults));


execute_unload "Results_%OutputFileLabel%"
Results
Results2
;





*some further results for the zhaw calculations
*we need some per commod impacts for the imported feed, i.e.

set Results3_values
/
"GHG emissions from imported feed (tCO2e) - incl. defor/orgSoils"
"GHG emissions from imported feed (tCO2e) - no defor/orgSoils"
/
;

Parameter Results3(Regions,Results3_values);

*commodities needed:
$ontext;
Wheat and products
Maize and products
Rice (Paddy Equivalent)
Oats
Barley and products
Soyabean cake
Rape and mustard cake
Sunflowerseed cake
Oilcrops, other
Sunflower seed
$offtext;



$if %CalculateFootprints% == "NO" $goto EndOf_FootprintResults2
*calculate the impact of imported feed - via footprints per ton and total tons imported:
*for this, use the following import quantities, and scale by the percentage (inverse of) of the total imports of these commodities covered by this data:
$ontext;

                                                                                                                                                                                     This covers the following percentages
Origin of imported feed quantities (tons)                                                                                                                                                      of imports of these commodities - thus scale the impacts by this factor to get 100%
                            France         Germany     Brazil          India          Russia         Belgium        Kazakhstan        Romania          Italy          Hungary
Wheat and products         149999.275    81611.052        0              0               0               0               0               0               0               0                     96
Maize and products        91366.653      19111.856        0              0               0               0               0               0               0               0                     88
Rice (Paddy Equivalent)        0             0        59196.1403    8341.504478          0               0               0               0               0               0                     75
Oats                     15197.485        5361.056        0              0               0               0               0               0               0               0                     76
Barley and products        4594.94        14485.991       0              0               0               0               0               0               0               0                     90
Soyabean cake                  0             0        128786.7158        0          83361.29211          0               0               0               0               0                     62
Rape and mustard cake          0        72318.89524       0              0               0               0               0               0               0               0                     88
Sunflowerseed cake        13796.12766        0            0              0               0               0               0               0           8795.765957      5940.042553              74
Oilcrops, other                0        2043.24           0              0               0           2671.669        1115.631            0               0               0                     85
Sunflower seed                 0        1764.404          0              0               0               0               0           1492.469          834.885           0                     67
$offtext;


Results3("Switzerland","GHG emissions from imported feed (tCO2e) - incl. defor/orgSoils")
= PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Wheat","MainOutput1 (t)","Wheat and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *149999/0.96
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Wheat","MainOutput1 (t)","Wheat and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *81611/0.96
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Maize","MainOutput1 (t)","Maize and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *91366/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Maize","MainOutput1 (t)","Maize and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *19112/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Rice, paddy","MainOutput1 (t)","Rice (Paddy Equivalent)","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *59196/0.75
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Rice, paddy","MainOutput1 (t)","Rice (Paddy Equivalent)","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *8342/0.75
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Oats","MainOutput1 (t)","Oats","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *15197/0.76
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Oats","MainOutput1 (t)","Oats","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *5361/0.76
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Barley","MainOutput1 (t)","Barley and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *4595/0.9
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Barley","MainOutput1 (t)","Barley and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *14486/0.9
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Soybeans","MainOutput1 (t)","Soyabean cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *128787/0.62
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Soybeans","MainOutput1 (t)","Soyabean cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *83361/0.62
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Rapeseed","MainOutput1 (t)","Rape and mustard cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *72319/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *13796/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *8796/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *5940/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *2043/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *2672/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1116/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1764/0.67
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1492/0.67
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *835/0.67;

Results3("Switzerland","GHG emissions from imported feed (tCO2e) - no defor/orgSoils")
= PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Wheat","MainOutput1 (t)","Wheat and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *149999/0.96
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Wheat","MainOutput1 (t)","Wheat and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *81611/0.96
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Maize","MainOutput1 (t)","Maize and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *91366/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Maize","MainOutput1 (t)","Maize and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *19112/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Rice, paddy","MainOutput1 (t)","Rice (Paddy Equivalent)","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *59196/0.75
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Rice, paddy","MainOutput1 (t)","Rice (Paddy Equivalent)","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *8342/0.75
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Oats","MainOutput1 (t)","Oats","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *15197/0.76
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Oats","MainOutput1 (t)","Oats","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *5361/0.76
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Barley","MainOutput1 (t)","Barley and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *4595/0.9
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Barley","MainOutput1 (t)","Barley and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *14486/0.9
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Soybeans","MainOutput1 (t)","Soyabean cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *128787/0.62
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Soybeans","MainOutput1 (t)","Soyabean cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *83361/0.62
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Rapeseed","MainOutput1 (t)","Rape and mustard cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *72319/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *13796/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *8796/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *5940/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *2043/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *2672/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1116/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1764/0.67
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1492/0.67
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Switzerland","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *835/0.67;


Results3("World","GHG emissions from imported feed (tCO2e) - incl. defor/orgSoils")
= PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("France","Wheat","MainOutput1 (t)","Wheat and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *149999/0.96
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Wheat","MainOutput1 (t)","Wheat and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *81611/0.96
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("France","Maize","MainOutput1 (t)","Maize and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *91366/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Maize","MainOutput1 (t)","Maize and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *19112/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Brazil","Rice, paddy","MainOutput1 (t)","Rice (Paddy Equivalent)","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *59196/0.75
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("India","Rice, paddy","MainOutput1 (t)","Rice (Paddy Equivalent)","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *8342/0.75
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("France","Oats","MainOutput1 (t)","Oats","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *15197/0.76
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Oats","MainOutput1 (t)","Oats","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *5361/0.76
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("France","Barley","MainOutput1 (t)","Barley and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *4595/0.9
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Barley","MainOutput1 (t)","Barley and products","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *14486/0.9
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Brazil","Soybeans","MainOutput1 (t)","Soyabean cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *128787/0.62
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Russian Federation","Soybeans","MainOutput1 (t)","Soyabean cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *83361/0.62
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Rapeseed","MainOutput1 (t)","Rape and mustard cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *72319/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("France","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *13796/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Italy","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *8796/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Hungary","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *5940/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *2043/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Belgium","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *2672/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Kazakhstan","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1116/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1764/0.67
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Romania","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1492/0.67
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Italy","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, incl. defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *835/0.67;

Results3("World","GHG emissions from imported feed (tCO2e) - no defor/orgSoils")
= PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("France","Wheat","MainOutput1 (t)","Wheat and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *149999/0.96
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Wheat","MainOutput1 (t)","Wheat and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *81611/0.96
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("France","Maize","MainOutput1 (t)","Maize and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *91366/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Maize","MainOutput1 (t)","Maize and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *19112/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Brazil","Rice, paddy","MainOutput1 (t)","Rice (Paddy Equivalent)","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *59196/0.75
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("India","Rice, paddy","MainOutput1 (t)","Rice (Paddy Equivalent)","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *8342/0.75
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("France","Oats","MainOutput1 (t)","Oats","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *15197/0.76
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Oats","MainOutput1 (t)","Oats","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *5361/0.76
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("France","Barley","MainOutput1 (t)","Barley and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *4595/0.9
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Barley","MainOutput1 (t)","Barley and products","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *14486/0.9
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Brazil","Soybeans","MainOutput1 (t)","Soyabean cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *128787/0.62
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Russian Federation","Soybeans","MainOutput1 (t)","Soyabean cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *83361/0.62
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Rapeseed","MainOutput1 (t)","Rape and mustard cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *72319/0.88
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("France","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *13796/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Italy","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *8796/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Hungary","Sunflower seed","MainOutput1 (t)","Sunflowerseed cake","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *5940/0.74
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *2043/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Belgium","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *2672/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Kazakhstan","Linseed","MainOutput1 (t)","Linseed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1116/0.85
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Germany","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1764/0.67
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Romania","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *1492/0.67
         + PerCropCommodImpact_WithAllocChar_DifferentRefUnits_MR("Italy","Sunflower seed","MainOutput1 (t)","Sunflower seed","Total GHG em. - crops, no defor/orgSoils (tCO2e)","Protein","Reference unit: ton fresh matter","AllProdSyst","AllProdCond","zhaw_NoFeedImports")
                 *835/0.67;




execute_unload "Results_zhaw"
Results3
;

$label EndOf_FootprintResults2



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************

$exit;

