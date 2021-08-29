PUTCLOSE con,"_V6_SESSIT_UNISECO_Calculations";

*GENERAL DESCRIPTION
*This file contains all the code to produce some further specific results needed for the UNISECO SESSIT tool
*this is calculated after running all the other code that still runs on country level - and it adds the needed NUTS2 data here only

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) SESSIT UNISECO calculations
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) SESSIT UNISECO calculations

Parameter AUXNUTS2_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios);
Parameter AUXNUTS2_ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
Parameter AUXNUTS2_ActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
Parameter AUXNUTS2_ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
Parameter AUXNUTS2_ActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
Parameter AUXNUTS2_ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
Variable AUXNUTS2_VActCropsGrass_QuantityActUnits_MR(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios);
Parameter AnimalProdData_BioBamUNISECO(Regions,Activities,OutputsAnimals,Scenarios);

$gdxin Store_Data_for_SESSIT.gdx
$load AUXNUTS2_ActAnimalsHead_OtherChar_MR
$load AUXNUTS2_ActAnimalsHead_Inputs_MR
$load AUXNUTS2_ActCropsGrass_OtherChar
$load AUXNUTS2_ActCropsGrass_OtherChar_MR
$load AUXNUTS2_ActCropsGrass_Inputs
$load AUXNUTS2_ActCropsGrass_Inputs_MR
$load AUXNUTS2_VActCropsGrass_QuantityActUnits_MR
$load AnimalProdData_BioBamUNISECO
$gdxin

*assign to model variables:
ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios))
         = AUXNUTS2_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios);
ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios))
         = AUXNUTS2_ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios);
ActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions))
         = AUXNUTS2_ActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         = AUXNUTS2_ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
ActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions))
         = AUXNUTS2_ActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios))
         = AUXNUTS2_ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios);
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios))
         = AUXNUTS2_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios);

*delete auxiliary variables:
AUXNUTS2_ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions,Scenarios) = 0;
AUXNUTS2_ActAnimalsHead_Inputs_MR(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions,Scenarios) = 0;
AUXNUTS2_ActCropsGrass_OtherChar(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions) = 0;
AUXNUTS2_ActCropsGrass_OtherChar_MR(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions,Scenarios) = 0;
AUXNUTS2_ActCropsGrass_Inputs(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions) = 0;
AUXNUTS2_ActCropsGrass_Inputs_MR(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions,Scenarios) = 0;
AUXNUTS2_VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions,Scenarios) = 0;

*the areas for NUTS2 are now not yet correct for org/conv, as in the scenario definition, this has been done for the EU countries only - the NUTS2 regions are done under the general Regions assessment that assigns 5% organic only.
*hence adjust this for the scenarios:
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Convent",ProductionConditions,"LfP_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Convent",ProductionConditions,"LfP_2050")*0.75/0.95;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Organic",ProductionConditions,"LfP_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Organic",ProductionConditions,"LfP_2050")*5;

VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Convent",ProductionConditions,"AE_exports_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Convent",ProductionConditions,"AE_exports_2050")*0.85/0.95;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Organic",ProductionConditions,"AE_exports_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Organic",ProductionConditions,"AE_exports_2050")*0.15/0.05;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Fruits,"Convent",ProductionConditions,"AE_exports_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Fruits,"Convent",ProductionConditions,"AE_exports_2050")*0.05/0.85;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Fruits,"Organic",ProductionConditions,"AE_exports_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Fruits,"Organic",ProductionConditions,"AE_exports_2050")*0.95/0.15;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Treenuts,"Convent",ProductionConditions,"AE_exports_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Treenuts,"Convent",ProductionConditions,"AE_exports_2050")*0.05/0.85;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Treenuts,"Organic",ProductionConditions,"AE_exports_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Treenuts,"Organic",ProductionConditions,"AE_exports_2050")*0.95/0.15;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Vegetables,"Convent",ProductionConditions,"AE_exports_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Vegetables,"Convent",ProductionConditions,"AE_exports_2050")*0.05/0.85;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Vegetables,"Organic",ProductionConditions,"AE_exports_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Vegetables,"Organic",ProductionConditions,"AE_exports_2050")*0.95/0.15;

VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Convent",ProductionConditions,"LfS_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Convent",ProductionConditions,"LfS_2050")*0.75/0.95;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Organic",ProductionConditions,"LfS_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Organic",ProductionConditions,"LfS_2050")*5;

VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Convent",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Convent",ProductionConditions,"AE_food_2050")*0.5/0.95;
VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Organic",ProductionConditions,"AE_food_2050")
         = VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,"Organic",ProductionConditions,"AE_food_2050")*10;



$ontext;
we have now:
we indicate the dimensions to be used for further calculations - for some, we have identical values for other elements in a dimension - but this is not needed.


all for: NUTS2 - long names;

"AllAndAverageTypes", "AllProdSyst", "Baseline"
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: antibiotics use index","AllProdSyst","AllProdCond","Baseline")
                 to be scaled with produciton levels and to be adjusted for organic/conventional
                 scales with production from scenarios
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: transport volume index","AllProdSyst","AllProdCond","Baseline")
                 scales with animal heads from scenarios
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2020","AllProdSyst","AllProdCond","Baseline")
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2030","AllProdSyst","AllProdCond","Baseline")
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: heat stress index 2050","AllProdSyst","AllProdCond","Baseline")
                 scales with animal heads from scenarios
                         BUT: values to be used for 2030, 2050 (but currently named differently, all with scenario = Baseline)

AnimalTypeInHerd, "AllProdSyst", UNISECOScenarios
         ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants","AllProdSyst","AllProdCond",UNISECOScenarios)
                 scales with animal heads from scenarios
         ActAnimalsHead_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Animal welfare: production intensity index - eggs","AllProdSyst","AllProdCond",UNISECOScenarios)
                 scales with animal heads from scenarios (only Chickens)

Crops/Livestock, Organic/convent, "Baseline"
         ActCropsGrass_Inputs_MR(NUTS2_Regions,Activities,"Labour use - total (h)",ProdSyst_OrgCon,"AllProdCond","Baseline")
         ActAnimalsHead_Inputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Labour use - total (h)",ProdSyst_OrgCon,"AllProdCond","Baseline")
                 scales with areas/animal heads from scenarios (ORGANIC and CONVENT!!)

Crops, no scenario dimension
         ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Blue Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
         ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Green Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
         ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Grey Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
         ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"IrrigW per t MOutput1 (m3) - total demand","AllProdSyst","AllProdCond")
         ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.","AllProdSyst","AllProdCond")
                 scales with yields and areas from scenarios
                                        The last two parameters, after scaling with yields and areas:
                                         This then is as Input per ha: "Irrigation water (m3)"
                                         This then is as Input per ha: "Irrigation water (m3) - water stress adjusted"


The following is available ONLY FOR COUNTRIES:
AND: NEEDS TO BE DERIVED ANEW after STEERING2 and THEN assign to NUTS2
         ActAnimalsHead_OtherChar_MR(Regions,Activities,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastrics","AllProdSyst","AllProdCond","Baseline")
                 scales with animal heads from scenarios


And we have the scaling variables or parts of them:
- per crop and NUTS2 areas, UNISECO Scenarios
         VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Crops,ProdSyst_OrgCon,"AllProdCond",UNISECOScenarios)
- share animal numbers - per NUTS2 in region: UNISECO Scenarios; MULTIPLY with country animal number after Steering2 to get NUTS2-level animal numbers
                 use SHEEP for GOATS as well
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"Egg Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",UNISECOScenarios)
- animal production per NUTS2, UNISECO Scenarios (Activities: Cattle, pigs, Chickens, Sheep; OUtputsAnimals: Meat, Milk, Eggs)
                 SHEEP is SHeep&Goats!!
         AnimalProdData_BioBamUNISECO(NUTS2_Regions,Activities,OutputsAnimals,UNISECOScenarios)


*and we also need the following AFTER STEERING2 to calculate the indicators:
available on COUNTRY LEVEL only
- cropyields
         ActCropsGrass_Outputs_MR(Countries,Crops,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond",UNISECOScenarios)
- animal numbers (the share animal numbers from above allows to derive NUTS2-level animal numbers from this)
         VActAnimalsHead_QuantityActUnits_MR(Countries,Activities,AnimalTypeInHerd,ProdSyst_OrgCon,"AllProdCond",UNISECOScenarios)



Yet to be added:

monetary value and then labour productivity

$offtext;




*first, assign the monogastric intensity index to NUTS2 regions, as this is yet missing:
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,ProductionConditions,Scenarios)
                 $(NOT ActAnimalsHead_OtherChar_MR(NUTS2_Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,ProductionConditions,Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActAnimalsHead_OtherChar_MR(Countries,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,ProductionConditions,Scenarios));
*then assign crop yields to NUTS2 as well:
ActCropsGrass_Outputs_MR(NUTS2_Regions,Crops,"MainOutput1 (t)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActCropsGrass_Outputs_MR(NUTS2_Regions,Crops,"MainOutput1 (t)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActCropsGrass_Outputs_MR(Countries,Crops,"MainOutput1 (t)",ProductionSystems,"AllProdCond",Scenarios));
*and assign livestock yields to NUTS2 as well:
ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,"Meat producing","Meat (t)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,"Meat producing","Meat (t)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActAnimalsHead_Outputs_MR(Countries,Livestock,"Meat producing","Meat (t)",ProductionSystems,"AllProdCond",Scenarios));
ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,"Milk producing","Milk (t)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,"Milk producing","Milk (t)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActAnimalsHead_Outputs_MR(Countries,Livestock,"Milk producing","Milk (t)",ProductionSystems,"AllProdCond",Scenarios));
ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,"Egg producing","Eggs (t)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,"Egg producing","Eggs (t)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActAnimalsHead_Outputs_MR(Countries,Livestock,"Egg producing","Eggs (t)",ProductionSystems,"AllProdCond",Scenarios));

*and we also need the prices on NUTS2 level:
*but do this later, see the comment just after these calculations:
*Commod_OtherChar_MR(NUTS2_Regions,Commodities,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
*                 $(NOT Commod_OtherChar_MR(NUTS2_Regions,Commodities,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios))
*         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
*                 Commod_OtherChar_MR(Countries,Commodities,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios));
*calculating with these prices results in mismatch to the total animal and crop production value in 2012,
*thus adjust by a factor, derived in :
Parameter SOLm_Eurostat_CropPriceCorrection(Regions);
Parameter SOLm_Eurostat_AnimalPriceCorrection(Regions);

SOLm_Eurostat_CropPriceCorrection("Austria") =        0.553;
SOLm_Eurostat_CropPriceCorrection("Belgium") =        1.058;
SOLm_Eurostat_CropPriceCorrection("Bulgaria") =       0.608;
SOLm_Eurostat_CropPriceCorrection("Croatia") =        1.065;
SOLm_Eurostat_CropPriceCorrection("Czechia") =        0.701;
SOLm_Eurostat_CropPriceCorrection("Denmark") =        1.026;
SOLm_Eurostat_CropPriceCorrection("Estonia") =        0.766;
SOLm_Eurostat_CropPriceCorrection("Finland") =        0.527;
SOLm_Eurostat_CropPriceCorrection("France") =         0.889;
SOLm_Eurostat_CropPriceCorrection("Germany") =        0.911;
SOLm_Eurostat_CropPriceCorrection("Greece") =         0.754;
SOLm_Eurostat_CropPriceCorrection("Hungary") =        0.719;
SOLm_Eurostat_CropPriceCorrection("Ireland") =        1.649;
SOLm_Eurostat_CropPriceCorrection("Italy") =          0.755;
SOLm_Eurostat_CropPriceCorrection("Latvia") =         0.518;
SOLm_Eurostat_CropPriceCorrection("Lithuania") =      0.792;
SOLm_Eurostat_CropPriceCorrection("Luxembourg") =     0.921;
SOLm_Eurostat_CropPriceCorrection("Netherlands") =    1.907;
SOLm_Eurostat_CropPriceCorrection("Poland") =         0.698;
SOLm_Eurostat_CropPriceCorrection("Portugal") =       0.614;
SOLm_Eurostat_CropPriceCorrection("Romania") =        0.945;
SOLm_Eurostat_CropPriceCorrection("Slovakia") =       0.729;
SOLm_Eurostat_CropPriceCorrection("Slovenia") =       1.526;
SOLm_Eurostat_CropPriceCorrection("Spain") =          0.661;
SOLm_Eurostat_CropPriceCorrection("Sweden") =         0.872;
SOLm_Eurostat_CropPriceCorrection("United Kingdom") = 0.573;

SOLm_Eurostat_AnimalPriceCorrection("Austria") =        0.655;
SOLm_Eurostat_AnimalPriceCorrection("Belgium") =        0.686;
SOLm_Eurostat_AnimalPriceCorrection("Bulgaria") =       0.908;
SOLm_Eurostat_AnimalPriceCorrection("Croatia") =        1.199;
SOLm_Eurostat_AnimalPriceCorrection("Czechia") =        0.594;
SOLm_Eurostat_AnimalPriceCorrection("Denmark") =        0.710;
SOLm_Eurostat_AnimalPriceCorrection("Estonia") =        0.662;
SOLm_Eurostat_AnimalPriceCorrection("Finland") =        0.947;
SOLm_Eurostat_AnimalPriceCorrection("France") =         0.736;
SOLm_Eurostat_AnimalPriceCorrection("Germany") =        0.689;
SOLm_Eurostat_AnimalPriceCorrection("Greece") =         0.649;
SOLm_Eurostat_AnimalPriceCorrection("Hungary") =        0.736;
SOLm_Eurostat_AnimalPriceCorrection("Ireland") =        0.651;
SOLm_Eurostat_AnimalPriceCorrection("Italy") =          0.759;
SOLm_Eurostat_AnimalPriceCorrection("Latvia") =         0.486;
SOLm_Eurostat_AnimalPriceCorrection("Lithuania") =      0.647;
SOLm_Eurostat_AnimalPriceCorrection("Luxembourg") =     1.510;
SOLm_Eurostat_AnimalPriceCorrection("Netherlands") =    0.725;
SOLm_Eurostat_AnimalPriceCorrection("Poland") =         0.690;
SOLm_Eurostat_AnimalPriceCorrection("Portugal") =       0.872;
SOLm_Eurostat_AnimalPriceCorrection("Romania") =        0.562;
SOLm_Eurostat_AnimalPriceCorrection("Slovakia") =       0.915;
SOLm_Eurostat_AnimalPriceCorrection("Slovenia") =       1.648;
SOLm_Eurostat_AnimalPriceCorrection("Spain") =          0.930;
SOLm_Eurostat_AnimalPriceCorrection("Sweden") =         0.804;
SOLm_Eurostat_AnimalPriceCorrection("United Kingdom") = 0.859;

Set SubsetCommod_MatchWithAct_CommodEquivalentAct_CropsForSESSIT(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Abaca"
"Bananas"
"Beans"
"Cashew nuts, with shell"
"Cloves"
"Dates"
"Groundnuts (in Shell Eq)"
"Hemp Fibre And Tow"
"Hempseed"
"Jute"
"Oats"
"Oil Palm Fruit"
"Olives (including preserved)"
"Onions"
"Oranges, Mandarines"
"Peas"
"Pepper"
"Pimento"
*!!XXXXX    !!CAREFUL, if "Chillies and peppers, dry" is also available as commodity!! - how to deal with this??
"Plantains"
"Rice, Paddy"
"Rice (Paddy Equivalent)"
"Rubber"
"Sesame seed"
"Sisal"
"Soyabeans"
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Sweet potatoes"
"Tea (including mate)"
"Tobacco"
"Yams"
"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Forage Products Nes"
"Beets For Fodder"
"Swedes For Fodder"
"Turnips For Fodder"
"Vegetables+Roots,Fodder"

Fallows

"Grass"

"Temporary meadows and pastures"
"Permanent meadows and pastures"

"temporary grasslands"
"permanent grasslands"
"alpine pastures"

"Anise, badian, fennel, coriander"
"Apples"
"Apricots"
"Artichokes"
"Asparagus"
"Avocados"
"Bambara beans"
"Barley"
"Beans, dry"
"Beans, green"
"Beeswax"
"Blueberries"
"Broad beans, horse beans, dry"
"Buckwheat"
"Cabbages and other brassicas"
"Canary seed"
"Cassava"
"Cauliflowers and broccoli"
"Cherries"
"Cherries, sour"
"Chestnut"
"Chick peas"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cinnamon (canella)"
"Cocoa, beans"
"Coconuts"
"Coffee, green"
"Cranberries"
"Cucumbers and gherkins"
"Currants"
"Eggplants (aubergines)"
"Eggs, hen, in shell"
"Fonio"
"Forage and silage, clover"
"Forage and silage, grasses nes"
"Forage and silage, legumes"
"Garlic"
"Ginger"
"Gooseberries"
"Grain, mixed"
"Grapefruit (inc. pomelos)"
"Grapes"
"Honey, natural"
"Hops"
"Jute+Bast Fibres"
"Kiwi fruit"
"Kola nuts"
"Leeks, other alliaceous vegetables"
"Lemons and limes"
"Lentils"
"Lettuce and chicory"
"Linseed"
"Maize"
"Maize, green"
"Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"
"Maté"
"Melons, other (inc.cantaloupes)"
"Millet"
"Mushrooms and truffles"
"Mustard seed"
"Natural Rubber"
"Nutmeg, mace and cardamoms"
"Olives"
"Olives preserved"
"Onions, dry"
"Onions, shallots, green"
"Oranges"
"Oth Citrus Frt"
"Papayas"
"Peaches and nectarines"
"Pears"
"Peas, dry"
"Peas, green"
"Pepper (piper spp.)"
"Peppermint"
"Persimmons"
"Pineapples"
"Pistachios"
"Plantains and others"
"Plums and sloes"
"Poppy seed"
"Potatoes"
"Pumpkins, squash and gourds"
"Pyrethrum, dried"
"Quinces"
"Rapeseed"
"Rice"
"Rubber, natural"
"Rye"
"Sorghum"
"Soybeans"
"Spices, nes"
"Spinach"
"Strawberries"
*"Sunflower seed"
"Tangerines, mandarins, clementines, satsumas"
"Tea"
"Tobacco, unmanufactured"
"Tomatoes"
"Triticale"
"Vanilla"
"Vetches"
"Walnuts, with shell"
"Watermelons"
"Wheat"
"Agave Fibres Nes"
"Almonds"
"Areca Nuts (Betel)"
"Brazil Nuts"
"Broad Beans, Green"
"Carobs"
"Cassava Leaves"
"Castor Beans"
"Chicory Roots"
"Citrus Fruit Nes"
"Cow Peas, Dry"
"Fibre Crops Nes"
"Groundnuts In Shell"
"Kapok Fruit"
"Karite Nuts (Sheanuts)"
"Lupins"
"Mate"
"Melonseed"
"Natural Gums"
"Okra"
"Pigeon Peas"
"Pome Fruit Nes, Fresh"
"Pulses Nes"
"Quinoa"
"Ramie"
"Raspberries"
"Safflower Seed"
"Seed cotton"
"Stone Fruit Nes, Fresh"
"String Beans"
"Tallowtree Seeds"
"Taro (Coco Yam)"
"Tung Nuts"
"Yautia (Cocoyam)"
/;

Set SubsetCommod_MatchWithAct_CommodEquivalentAct_MeatForSESSIT(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Pigmeat"
"Poultry Meat"
"Meat of Swine"
"Meat Poultry Fresh"
"Meat Sheep Fresh"
"Meat, ass"
"Meat, cattle"
"Meat, chicken"
"Meat, duck"
"Meat, game"
"Meat, goat"
"Meat, goose and guinea fowl"
"Meat, horse"
"Meat, pig"
"Meat, pork"
"Meat, rabbit"
"Meat, sheep"
"Meat, turkey"
"Buffalo Meat"
"Meat, Asses"
"Meat, Camels"
"Meat, Mules"
"Bovine meat"
"Mutton & Goat Meat"
"Meat Bovine Fresh"
/;

Set SubsetCommod_MatchWithAct_CommodEquivalentAct_MilkForSESSIT(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Milk, Whole"
"Buffalo Milk"
"Goat Milk"
"Milk - Excluding Butter"
"Milk Fresh"
"Milk, whole fresh cow"
"Milk, whole fresh sheep"
"Milk, whole fresh buffalo"
"Milk, whole fresh camel"
"Milk, whole fresh goat"
"Standardized Milk"
/;

Set SubsetCommod_MatchWithAct_CommodEquivalentAct_EggsForSESSIT(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Eggs, hen, in shell"
"Eggs"
"Eggs in The Shell"
"Eggs Excl Hen"
"Eggs, other bird, in shell"
/;


*AFTER THIS CORRECTION: for the EU, SESSIT data, prices and values etc. are in EURO, NOT DOLLAR anymore, as the adjustment factors above ar chosen such as to result in similar total EURO values for the baseline.

Commod_OtherChar_MR(Countries,SubsetCommod_MatchWithAct_CommodEquivalentAct_CropsForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = Commod_OtherChar_MR(Countries,SubsetCommod_MatchWithAct_CommodEquivalentAct_CropsForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                 *SOLm_Eurostat_CropPriceCorrection(Countries);

Commod_OtherChar_MR(Countries,SubsetCommod_MatchWithAct_CommodEquivalentAct_MeatForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = Commod_OtherChar_MR(Countries,SubsetCommod_MatchWithAct_CommodEquivalentAct_MeatForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                 *SOLm_Eurostat_AnimalPriceCorrection(Countries);
Commod_OtherChar_MR(Countries,SubsetCommod_MatchWithAct_CommodEquivalentAct_MilkForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = Commod_OtherChar_MR(Countries,SubsetCommod_MatchWithAct_CommodEquivalentAct_MilkForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                 *SOLm_Eurostat_AnimalPriceCorrection(Countries);
Commod_OtherChar_MR(Countries,SubsetCommod_MatchWithAct_CommodEquivalentAct_EggsForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = Commod_OtherChar_MR(Countries,SubsetCommod_MatchWithAct_CommodEquivalentAct_EggsForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                 *SOLm_Eurostat_AnimalPriceCorrection(Countries);

Commod_OtherChar_MR(NUTS2_Regions,Commodities,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT Commod_OtherChar_MR(NUTS2_Regions,Commodities,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 Commod_OtherChar_MR(Countries,Commodities,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios));

*and derive the animal numbers on NUTS2 level:
*first, we need to combine the shares for different product producing animals, as these are derived from the product wuantities in UNISECO, but we do not have full such differentiation in SOLm (e.g. for Chickens or Sheep):
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Chickens","AllAndAverageTypes","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
         = (ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Chickens","Egg Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
                 + ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Chickens","Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))/2;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Cattle","AllAndAverageTypes","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
         = (ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Cattle","Milk Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
                 + ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Cattle","Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))/2;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Sheep","AllAndAverageTypes","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
         = (ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Sheep","Milk Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
                 + ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Sheep","Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios))/2;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Goats","AllAndAverageTypes","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Sheep","AllAndAverageTypes","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios);
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Pigs","AllAndAverageTypes","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios)
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Pigs","Meat Producing","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios);

VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Activities,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Activities,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                  VActAnimalsHead_QuantityActUnits_MR.l(Countries,Activities,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios)
                         *ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond",Scenarios));
VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Activities,AnimalTypeInHerd,ProductionSystems,"AllProdCond","FOFA_BAU_2012")
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Activities,AnimalTypeInHerd,ProductionSystems,"AllProdCond","FOFA_BAU_2012"))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                  VActAnimalsHead_QuantityActUnits_MR.l(Countries,Activities,AnimalTypeInHerd,ProductionSystems,"AllProdCond","BaselineDerived")
                         *ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Share animal number - per NUTS2 in region","AllProdSyst","AllProdCond","FOFA_BAU_2012"));
*if AllProdSyst is not available it is derived:
VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond",Scenarios))
         = VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Activities,AnimalTypeInHerd,"Convent","AllProdCond",Scenarios)
                 + VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Activities,AnimalTypeInHerd,"Organic","AllProdCond",Scenarios);



*and, finally, somewhat adjust the antibiotics indicator for intensity levels
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst",ProductionConditions,Scenarios)
                         $ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants","AllProdSyst",ProductionConditions,"FOFA_BAU_2012")
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Ruminants,"AllAndAverageTypes","Animal welfare: antibiotics use index","AllProdSyst",ProductionConditions,"Baseline")
                 *ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants","AllProdSyst",ProductionConditions,Scenarios)
                         /ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants","AllProdSyst",ProductionConditions,"FOFA_BAU_2012");

ActAnimalsHead_OtherChar_MR(NUTS2_Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios)
                         $ActAnimalsHead_OtherChar_MR(NUTS2_Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat","AllProdSyst",ProductionConditions,"FOFA_BAU_2012")
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,NonRuminants,"AllAndAverageTypes","Animal welfare: antibiotics use index","AllProdSyst",ProductionConditions,"Baseline")
                 *ActAnimalsHead_OtherChar_MR(NUTS2_Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,ProductionConditions,Scenarios)
                         /ActAnimalsHead_OtherChar_MR(NUTS2_Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat","AllProdSyst",ProductionConditions,"FOFA_BAU_2012");
*here, eggs are not needed specifically for adjustment, as the antibiotic index does not differentiate between outputs which is the basis for the intensity level for non-ruminants, and usually all egg producing animals are also used for meat.

*Some problems arise, in case the intensity is VERY low for 2012 but not so for the scenario (as e.g. happens for ITC2 Valle d'Aosta) - thus hedge against this by the following conditional:
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios)
                 $(ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProductionSystems,ProductionConditions,Scenarios)
                         > 5*ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst",ProductionConditions,"FOFA_BAU_2012"))
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst",ProductionConditions,"FOFA_BAU_2012");



*and differentiate org/con values, assuming antibiotics use in organics: 25-65% of conventional (https://www.sciencedirect.com/science/article/pii/S0929139317302573?via%3Dihub):

*we again need the following set:
Set ScenariosUNISECO(Scenarios)
/
"LfP_2050", "AE_exports_2050", "LfS_2050", "AE_food_2050"
/;


ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","Convent",ProductionConditions,ScenariosUNISECO)
                 $(NOT ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","Convent",ProductionConditions,ScenariosUNISECO))
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst",ProductionConditions,ScenariosUNISECO);
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","Organic",ProductionConditions,ScenariosUNISECO)
                 $ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","Organic",ProductionConditions,ScenariosUNISECO)
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","Organic",ProductionConditions,ScenariosUNISECO)*0.5;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","Organic",ProductionConditions,ScenariosUNISECO)
                 $(NOT ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","Organic",ProductionConditions,ScenariosUNISECO))
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst",ProductionConditions,ScenariosUNISECO)*0.5;

ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index","AllProdSyst",ProductionConditions,ScenariosUNISECO) = 0;

ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProdSyst_OrgCon,ProductionConditions,"Baseline") = 0;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProdSyst_OrgCon,ProductionConditions,"BaselineDerived") = 0;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2012") = 0;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050") = 0;
ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProdSyst_OrgCon,ProductionConditions,"FOFA_BAU_2050_Test") = 0;


*and calculate the total impacts per NUTS2 region:
$ontext;
"AllAndAverageTypes", "AllProdSyst", "Baseline"
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,"AllAndAverageTypes","Animal welfare: transport volume index","AllProdSyst","AllProdCond","Baseline")
                 scales with animal heads from scenarios
                         BUT: for the last one values to be used for 2030, 2050 (but currently named differently, all with scenario = Baseline)

AnimalTypeInHerd, "AllProdSyst", "Baseline"
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2020","AllProdSyst","AllProdCond","Baseline")
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2030","AllProdSyst","AllProdCond","Baseline")
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Animal welfare: heat stress index 2050","AllProdSyst","AllProdCond","Baseline")
                 scales with animal heads from scenarios

AnimalTypeInHerd, "AllProdSyst", UNISECOScenarios, FOFA_BAU_2012
         ActAnimalsHead_OtherChar_MR(Regions,Ruminants,AnimalTypeInHerd,"Animal welfare: production intensity index - ruminants","AllProdSyst","AllProdCond",UNISECOScenarios)
         ActAnimalsHead_OtherChar_MR(Regions,"Chickens","AllAndAverageTypes","Animal welfare: production intensity index - eggs","AllProdSyst","AllProdCond",UNISECOScenarios)
                 scales with animal heads from scenarios (the last one: only Chickens)

AnimalTypeInHerd, AllProdSyst/Organic/convent, UNISECOScenarios, FOFA_BAU_2012
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,NonRuminants,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProdSyst_AllOrgCon,"AllProdCond",UNISECOScenarios)
                 scales with animal heads from scenarios
         ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProdSyst_AllOrgCon,"AllProdCond",UNISECOScenarios)
                 scales with animal production from scenarios

Crops/Livestock, All/Organic/convent, "Baseline"
         ActCropsGrass_Inputs_MR(NUTS2_Regions,Activities,"Labour use - total (h)",ProdSyst_AllOrgCon,"AllProdCond","Baseline")
         ActAnimalsHead_Inputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Labour use - total (h)",ProdSyst_OrgCon,"AllProdCond","Baseline")
                 scales with areas from scenarios (ORGANIC and CONVENT!!)

Crops, no scenario dimension
         ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Blue Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
         ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Green Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
         ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"Grey Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
         ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"IrrigW per t MOutput1 (m3) - total demand","AllProdSyst","AllProdCond")
         ActCropsGrass_OtherChar(NUTS2_Regions,Activities,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.","AllProdSyst","AllProdCond")
                 scales with yields and areas from scenarios
                                        The last two parameters, after scaling with yields and areas:
                                         This then is as Input per ha: "Irrigation water (m3)"
                                         This then is as Input per ha: "Irrigation water (m3) - water stress adjusted"
$offtext;

VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: transport volume index",ProductionSystems,"AllProdCond",Scenarios)
         = sum((Livestock,AnimalTypeInherd),
                 ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,"AllAndAverageTypes","Animal welfare: transport volume index","AllProdSyst","AllProdCond","Baseline")
                         *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios));

VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: heat stress index 2020",ProductionSystems,"AllProdCond","FOFA_BAU_2012")
         = sum((Livestock,AnimalTypeInherd),
                 ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: heat stress index 2020","AllProdSyst","AllProdCond","Baseline")
                         *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,AnimalTypeInHerd,ProductionSystems,"AllProdCond","FOFA_BAU_2012"));
VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: heat stress index 2050",ProductionSystems,"AllProdCond",Scenarios)
         = sum((Livestock,AnimalTypeInherd),
                 ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: heat stress index 2050","AllProdSyst","AllProdCond","Baseline")
                         *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios));

Set AnimalWelfareIndicators_2(OtherCharAnimals)
/
"Animal welfare: production intensity index - ruminants"
"Animal welfare: production intensity index - eggs"
/;
VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes",AnimalWelfareIndicators_2,ProductionSystems,"AllProdCond",Scenarios)
         = sum((Livestock,AnimalTypeInherd),
                 ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,AnimalWelfareIndicators_2,"AllProdSyst","AllProdCond",Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios));

VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: production intensity index - monogastric meat",ProductionSystems,"AllProdCond",Scenarios)
         = sum((Livestock,AnimalTypeInherd),
                 ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,"AllProdCond",Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios));

*VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
*         = sum((Livestock,AnimalTypeInherd),
*                 ActAnimalsHead_OtherChar_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
*                         *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios));

VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Cattle","Producing_Dairy_Cattle","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
                 *(AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Cattle","Meat (t)",Scenarios)
                         + AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Cattle","Milk (t)",Scenarios))
         + ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Sheep","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
                 *(AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Sheep","Meat (t)",Scenarios)
                         + AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Sheep","Milk (t)",Scenarios))
         + ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Chickens","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
                 *(AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Chickens","Meat (t)",Scenarios)
                         + AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Chickens","Eggs (t)",Scenarios))
         + ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Pigs","Sows","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
                 *AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Pigs","Meat (t)",Scenarios);




VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"Cattle","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Cattle","Producing_Dairy_Cattle","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
                 *(AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Cattle","Meat (t)",Scenarios)
                         + AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Cattle","Milk (t)",Scenarios));

VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"Sheep","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Sheep","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
                 *(AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Sheep","Meat (t)",Scenarios)
                         + AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Sheep","Milk (t)",Scenarios));
VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"Chickens","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Chickens","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
                 *(AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Chickens","Meat (t)",Scenarios)
                         + AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Chickens","Eggs (t)",Scenarios));
VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"Pigs","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
         = ActAnimalsHead_OtherChar_MR(NUTS2_Regions,"Pigs","Sows","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios)
                 *AnimalProdData_BioBamUNISECO(NUTS2_Regions,"Pigs","Meat (t)",Scenarios);






*for the FOFA 2012 and 2050 scenarios, we have AllProdSyst only, that is ok.
*for the 4 UNISECO scenarios, we have org anc conv, each calculated with ALL production. Thus scale each according to the share of organic used:
VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Convent","AllProdCond","LfP_2050")
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Convent","AllProdCond","LfP_2050")*0.75;
VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Organic","AllProdCond","LfP_2050")
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Organic","AllProdCond","LfP_2050")*0.25;

VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Convent","AllProdCond","AE_exports_2050")
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Convent","AllProdCond","AE_exports_2050")*0.85;
VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Organic","AllProdCond","AE_exports_2050")
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Organic","AllProdCond","AE_exports_2050")*0.15;

VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Convent","AllProdCond","LfS_2050")
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Convent","AllProdCond","LfS_2050")*0.75;
VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Organic","AllProdCond","LfS_2050")
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Organic","AllProdCond","LfS_2050")*0.25;

VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Convent","AllProdCond","AE_food_2050")
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Convent","AllProdCond","AE_food_2050")*0.5;
VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Organic","AllProdCond","AE_food_2050")
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index","Organic","AllProdCond","AE_food_2050")*0.5;

VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Labour use - total (h)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Activities,
                 ActCropsGrass_Inputs_MR(NUTS2_Regions,Activities,"Labour use - total (h)",ProductionSystems,"AllProdCond","Baseline")
                         *VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,ProductionSystems,"AllProdCond",Scenarios));

VActAnimalsHead_Inputs_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Labour use - total (h)",ProductionSystems,"AllProdCond",Scenarios)
         = sum((Livestock,AnimalTypeInHerd),
                  ActAnimalsHead_Inputs_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Labour use - total (h)",ProductionSystems,"AllProdCond","Baseline")
                         *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios));

VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Blue Water Footprint (m3)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Crops,
                 ActCropsGrass_OtherChar(NUTS2_Regions,Crops,"Blue Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
                         *ActCropsGrass_Outputs_MR(NUTS2_Regions,Crops,"MainOutput1 (t)",ProductionSystems,"AllProdCond",Scenarios)
                                  *VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Crops,ProductionSystems,"AllProdCond",Scenarios));
VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Green Water Footprint (m3)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Crops,
                 ActCropsGrass_OtherChar(NUTS2_Regions,Crops,"Green Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
                         *ActCropsGrass_Outputs_MR(NUTS2_Regions,Crops,"MainOutput1 (t)",ProductionSystems,"AllProdCond",Scenarios)
                                  *VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Crops,ProductionSystems,"AllProdCond",Scenarios));
VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Grey Water Footprint (m3)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Crops,
                 ActCropsGrass_OtherChar(NUTS2_Regions,Crops,"Grey Water Footprint per t MainOutput1 (m3)","AllProdSyst","AllProdCond")
                         *ActCropsGrass_Outputs_MR(NUTS2_Regions,Crops,"MainOutput1 (t)",ProductionSystems,"AllProdCond",Scenarios)
                                  *VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Crops,ProductionSystems,"AllProdCond",Scenarios));

VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Irrigation water (m3)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Crops,
                 ActCropsGrass_OtherChar(NUTS2_Regions,Crops,"IrrigW per t MOutput1 (m3) - total demand","AllProdSyst","AllProdCond")
                         *ActCropsGrass_Outputs_MR(NUTS2_Regions,Crops,"MainOutput1 (t)",ProductionSystems,"AllProdCond",Scenarios)
                                  *VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Crops,ProductionSystems,"AllProdCond",Scenarios));
VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Irrigation water (m3) - water stress adjusted",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Crops,
                 ActCropsGrass_OtherChar(NUTS2_Regions,Crops,"RED: tot. IrrigW per t MOutput1 (m3), account. water scarc.","AllProdSyst","AllProdCond")
                         *ActCropsGrass_Outputs_MR(NUTS2_Regions,Crops,"MainOutput1 (t)",ProductionSystems,"AllProdCond",Scenarios)
                                  *VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Crops,ProductionSystems,"AllProdCond",Scenarios));


PUTCLOSE con "   SESSIT final calc 1:" timeElapsed;

*now we compile some data needed to derive a basic labour productivity measure
*first, derive the production and then the value of the production (only for crops and livestock, not available for grass):
VActCropsGrass_Outputs_MR.l(NUTS2_Regions,Crops,"Mainoutput1 (t)",ProductionSystems,"AllProdCond",Scenarios)
         = ActCropsGrass_Outputs_MR(NUTS2_Regions,Crops,"MainOutput1 (t)",ProductionSystems,"AllProdCond",Scenarios)
                 *VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Crops,ProductionSystems,"AllProdCond",Scenarios);

VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,Livestock,"Meat producing","Meat (t)",ProductionSystems,"AllProdCond",Scenarios)
         = ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,"Meat producing","Meat (t)",ProductionSystems,"AllProdCond",Scenarios)
                 *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,"Meat producing",ProductionSystems,"AllProdCond",Scenarios);
VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,Livestock,"Milk producing","Milk (t)",ProductionSystems,"AllProdCond",Scenarios)
         = ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,"Milk producing","Milk (t)",ProductionSystems,"AllProdCond",Scenarios)
                 *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,"Milk producing",ProductionSystems,"AllProdCond",Scenarios);
VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,Livestock,"Egg producing","Eggs (t)",ProductionSystems,"AllProdCond",Scenarios)
         = ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,"Egg producing","Eggs (t)",ProductionSystems,"AllProdCond",Scenarios)
                 *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,"Egg producing",ProductionSystems,"AllProdCond",Scenarios);

PUTCLOSE con "   SESSIT final calc 2:" timeElapsed;

*then derive the values by using adequate matching sets between commodities and activities and the producer prices for the repsective commodities:
*set MatchCommAct_CommodEquivalentAct_Crops(Commodities,Activities,OutputsCropsGrass) "Set covering all crop commodities that are equivalent to main outputs from activities"
*set MatchCommAct_CommodEquivalentAct_Animals(Commodities,Activities,OutputsAnimals) "Set covering all animal commodities that are equivalent to main outputs from activities"

$ontext;
the following is already defined above
*first, do some shortened commodity subsets to fasten calculations:
Set SubsetCommod_MatchWithAct_CommodEquivalentAct_CropsForSESSIT(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Abaca"
"Bananas"
"Beans"
"Cashew nuts, with shell"
"Cloves"
"Dates"
"Groundnuts (in Shell Eq)"
"Hemp Fibre And Tow"
"Hempseed"
"Jute"
"Oats"
"Oil Palm Fruit"
"Olives (including preserved)"
"Onions"
"Oranges, Mandarines"
"Peas"
"Pepper"
"Pimento"
*!!XXXXX    !!CAREFUL, if "Chillies and peppers, dry" is also a ailable as commodity!! - how to deal with this??
"Plantains"
"Rice, Paddy"
"Rice (Paddy Equivalent)"
"Rubber"
"Sesame seed"
"Sisal"
"Soyabeans"
"Sugar beet"
"Sugar cane"
"Sunflower seed"
"Sweet potatoes"
"Tea (including mate)"
"Tobacco"
"Yams"
"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Forage Products Nes"
"Beets For Fodder"
"Swedes For Fodder"
"Turnips For Fodder"
"Vegetables+Roots,Fodder"

Fallows

"Grass"

"Temporary meadows and pastures"
"Permanent meadows and pastures"

"temporary grasslands"
"permanent grasslands"
"alpine pastures"

"Anise, badian, fennel, coriander"
"Apples"
"Apricots"
"Artichokes"
"Asparagus"
"Avocados"
"Bambara beans"
"Barley"
"Beans, dry"
"Beans, green"
"Beeswax"
"Blueberries"
"Broad beans, horse beans, dry"
"Buckwheat"
"Cabbages and other brassicas"
"Canary seed"
"Cassava"
"Cauliflowers and broccoli"
"Cherries"
"Cherries, sour"
"Chestnut"
"Chick peas"
"Chillies and peppers, dry"
"Chillies and peppers, green"
"Cinnamon (canella)"
"Cocoa, beans"
"Coconuts"
"Coffee, green"
"Cranberries"
"Cucumbers and gherkins"
"Currants"
"Eggplants (aubergines)"
"Eggs, hen, in shell"
"Fonio"
"Forage and silage, clover"
"Forage and silage, grasses nes"
"Forage and silage, legumes"
"Garlic"
"Ginger"
"Gooseberries"
"Grain, mixed"
"Grapefruit (inc. pomelos)"
"Grapes"
"Honey, natural"
"Hops"
"Jute+Bast Fibres"
"Kiwi fruit"
"Kola nuts"
"Leeks, other alliaceous vegetables"
"Lemons and limes"
"Lentils"
"Lettuce and chicory"
"Linseed"
"Maize"
"Maize, green"
"Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"
"Maté"
"Melons, other (inc.cantaloupes)"
"Millet"
"Mushrooms and truffles"
"Mustard seed"
"Natural Rubber"
"Nutmeg, mace and cardamoms"
"Olives"
"Olives preserved"
"Onions, dry"
"Onions, shallots, green"
"Oranges"
"Oth Citrus Frt"
"Papayas"
"Peaches and nectarines"
"Pears"
"Peas, dry"
"Peas, green"
"Pepper (piper spp.)"
"Peppermint"
"Persimmons"
"Pineapples"
"Pistachios"
"Plantains and others"
"Plums and sloes"
"Poppy seed"
"Potatoes"
"Pumpkins, squash and gourds"
"Pyrethrum, dried"
"Quinces"
"Rapeseed"
"Rice"
"Rubber, natural"
"Rye"
"Sorghum"
"Soybeans"
"Spices, nes"
"Spinach"
"Strawberries"
*"Sunflower seed"
"Tangerines, mandarins, clementines, satsumas"
"Tea"
"Tobacco, unmanufactured"
"Tomatoes"
"Triticale"
"Vanilla"
"Vetches"
"Walnuts, with shell"
"Watermelons"
"Wheat"
"Agave Fibres Nes"
"Almonds"
"Areca Nuts (Betel)"
"Brazil Nuts"
"Broad Beans, Green"
"Carobs"
"Cassava Leaves"
"Castor Beans"
"Chicory Roots"
"Citrus Fruit Nes"
"Cow Peas, Dry"
"Fibre Crops Nes"
"Groundnuts In Shell"
"Kapok Fruit"
"Karite Nuts (Sheanuts)"
"Lupins"
"Mate"
"Melonseed"
"Natural Gums"
"Okra"
"Pigeon Peas"
"Pome Fruit Nes, Fresh"
"Pulses Nes"
"Quinoa"
"Ramie"
"Raspberries"
"Safflower Seed"
"Seed cotton"
"Stone Fruit Nes, Fresh"
"String Beans"
"Tallowtree Seeds"
"Taro (Coco Yam)"
"Tung Nuts"
"Yautia (Cocoyam)"
/;

Set SubsetCommod_MatchWithAct_CommodEquivalentAct_MeatForSESSIT(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Pigmeat"
"Poultry Meat"
"Meat of Swine"
"Meat Poultry Fresh"
"Meat Sheep Fresh"
"Meat, ass"
"Meat, cattle"
"Meat, chicken"
"Meat, duck"
"Meat, game"
"Meat, goat"
"Meat, goose and guinea fowl"
"Meat, horse"
"Meat, pig"
"Meat, pork"
"Meat, rabbit"
"Meat, sheep"
"Meat, turkey"
"Buffalo Meat"
"Meat, Asses"
"Meat, Camels"
"Meat, Mules"
"Bovine meat"
"Mutton & Goat Meat"
"Meat Bovine Fresh"
/;

Set SubsetCommod_MatchWithAct_CommodEquivalentAct_MilkForSESSIT(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Milk, Whole"
"Buffalo Milk"
"Goat Milk"
"Milk - Excluding Butter"
"Milk Fresh"
"Milk, whole fresh cow"
"Milk, whole fresh sheep"
"Standardized Milk"
/;

Set SubsetCommod_MatchWithAct_CommodEquivalentAct_EggsForSESSIT(Commodities)
*This captures all commodities that are equivalent to main outputs from activities
/
"Eggs, hen, in shell"
"Eggs"
"Eggs in The Shell"
"Eggs Excl Hen"
/;
$offtext;

*for crops

VCommod_OtherChar_MR.l(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_CropsForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Crops$MatchCommAct_CommodEquivalentAct_Crops(SubsetCommod_MatchWithAct_CommodEquivalentAct_CropsForSESSIT,Crops,"MainOutput1 (t)"),
                 Commod_OtherChar_MR(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_CropsForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActCropsGrass_Outputs_MR.l(NUTS2_Regions,Crops,"Mainoutput1 (t)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 3:" timeElapsed;

*for animals:
set MatchCommAct_CommodEquivalentAct_Animals_ShortForSESSIT(Commodities,Activities,OutputsAnimals) "Set covering all animal commodities that are equivalent to main outputs from activities - short extract for the Sessit calculations"
/
"Milk, Whole"."Cattle"."Milk (t)"
"Pigmeat"."Pigs"."Meat (t)"
"Poultry Meat"."Chickens"."Meat (t)"
"Eggs, hen, in shell"."Chickens"."Eggs (t)"
"Meat of Swine"."Pigs"."Meat (t)"
"Meat Poultry Fresh"."Chickens"."Meat (t)"
"Meat Sheep Fresh"."Sheep"."Meat (t)"
"Meat, ass"."Asses"."Meat (t)"
"Meat, cattle"."Cattle"."Meat (t)"
"Meat, chicken"."Chickens"."Meat (t)"
"Meat, duck"."Ducks"."Meat (t)"
"Meat, game"."Game"."Meat (t)"
"Meat, goat"."Goats"."Meat (t)"
"Meat, goose and guinea fowl"."Geese and guinea fowls"."Meat (t)"
"Meat, horse"."Horses"."Meat (t)"
"Meat, pig"."Pigs"."Meat (t)"
"Meat, pork"."Pigs"."Meat (t)"
"Meat, rabbit"."Rabbits and hares"."Meat (t)"
"Meat, sheep"."Sheep"."Meat (t)"
"Meat, turkey"."Turkeys"."Meat (t)"
"Buffalo Meat"."Buffaloes"."Meat (t)"
"Buffalo Milk"."Buffaloes"."Milk (t)"
"Camel Milk"."Camels"."Milk (t)"
"Goat Milk"."Goats"."Milk (t)"
"Meat, Asses"."Asses"."Meat (t)"
"Meat, Camels"."Camels"."Meat (t)"
"Meat, Mules"."Mules"."Meat (t)"
"Eggs"."Chickens"."Eggs (t)"
"Eggs in The Shell"."Chickens"."Eggs (t)"
"Milk Fresh"."Cattle"."Milk (t)"
"Milk, whole fresh cow"."Cattle"."Milk (t)"
"Milk, whole fresh sheep"."Sheep"."Milk (t)"
/;

VCommod_OtherChar_MR.l(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_MeatForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_ShortForSESSIT(SubsetCommod_MatchWithAct_CommodEquivalentAct_MeatForSESSIT,Livestock,"Meat (t)"),
                 Commod_OtherChar_MR(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_MeatForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,Livestock,"Meat producing","Meat (t)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 3.1:" timeElapsed;

VCommod_OtherChar_MR.l(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_MilkForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_ShortForSESSIT(SubsetCommod_MatchWithAct_CommodEquivalentAct_MilkForSESSIT,Livestock,"Milk (t)"),
                 Commod_OtherChar_MR(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_MilkForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,Livestock,"Milk producing","Milk (t)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 3.2:" timeElapsed;

VCommod_OtherChar_MR.l(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_EggsForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Livestock$MatchCommAct_CommodEquivalentAct_Animals_ShortForSESSIT(SubsetCommod_MatchWithAct_CommodEquivalentAct_EggsForSESSIT,Livestock,"Eggs (t)"),
                 Commod_OtherChar_MR(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_EggsForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,Livestock,"Egg producing","Eggs (t)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 3.3:" timeElapsed;

*aggregate over commodities:
VCommod_OtherChar_MR.l(NUTS2_Regions,"All crop based Commodities","Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         =sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_CropsForSESSIT,
                 VCommod_OtherChar_MR.l(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_CropsForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios));
VCommod_OtherChar_MR.l(NUTS2_Regions,"All animal based Commodities","Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         =sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_MeatForSESSIT,
                 VCommod_OtherChar_MR.l(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_MeatForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios))
         +sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_MilkForSESSIT,
                 VCommod_OtherChar_MR.l(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_MilkForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios))
         +sum(SubsetCommod_MatchWithAct_CommodEquivalentAct_EggsForSESSIT,
                 VCommod_OtherChar_MR.l(NUTS2_Regions,SubsetCommod_MatchWithAct_CommodEquivalentAct_EggsForSESSIT,"Producer price ($)",ProductionSystems,"AllProdCond",Scenarios));
VCommod_OtherChar_MR.l(NUTS2_Regions,"All Commodities","Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
         = VCommod_OtherChar_MR.l(NUTS2_Regions,"All crop based Commodities","Producer price ($)",ProductionSystems,"AllProdCond",Scenarios)
                 + VCommod_OtherChar_MR.l(NUTS2_Regions,"All animal based Commodities","Producer price ($)",ProductionSystems,"AllProdCond",Scenarios);


PUTCLOSE con "   SESSIT final calc 4:" timeElapsed;


$exit;


XXXXXXX



*collect per ha and animal head data for soil erosion and NH3 emissions, then assign to NUTS2 level and then calculate respective total per NUTS2 level by multiplication with total areas and animal numbers:
*assign to NUTS2 regions:
ActCropsGrass_OtherChar_MR(NUTS2_Regions,Activities,"Soil water erosion (t soil lost)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActCropsGrass_OtherChar_MR(NUTS2_Regions,Activities,"Soil water erosion (t soil lost)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActCropsGrass_OtherChar_MR(Countries,Activities,"Soil water erosion (t soil lost)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 5.1:" timeElapsed;

ActCropsGrass_Outputs_MR(NUTS2_Regions,Activities,"NH3 from mineral fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActCropsGrass_Outputs_MR(NUTS2_Regions,Activities,"NH3 from mineral fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActCropsGrass_Outputs_MR(Countries,Activities,"NH3 from mineral fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 5.2:" timeElapsed;

ActCropsGrass_Outputs_MR(NUTS2_Regions,Activities,"NH3 from CropRes/biomass as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActCropsGrass_Outputs_MR(NUTS2_Regions,Activities,"NH3 from CropRes/biomass as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActCropsGrass_Outputs_MR(Countries,Activities,"NH3 from CropRes/biomass as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 5.3:" timeElapsed;

ActCropsGrass_Outputs_MR(NUTS2_Regions,Activities,"NH3 from manure as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActCropsGrass_Outputs_MR(NUTS2_Regions,Activities,"NH3 from manure as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActCropsGrass_Outputs_MR(Countries,Activities,"NH3 from manure as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 5.4:" timeElapsed;

ActAnimalsHead_Outputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Manure man NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActAnimalsHead_Outputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Manure man NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActAnimalsHead_Outputs_MR(Countries,Activities,AnimalTypeInHerd,"Manure man NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 5.5:" timeElapsed;

ActAnimalsHead_Outputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Grazing NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActAnimalsHead_Outputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Grazing NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActAnimalsHead_Outputs_MR(Countries,Activities,AnimalTypeInHerd,"Grazing NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 5.6:" timeElapsed;

ActAnimalsHead_Outputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActAnimalsHead_Outputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActAnimalsHead_Outputs_MR(Countries,Activities,AnimalTypeInHerd,"Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 5.7:" timeElapsed;

ActAnimalsHead_Outputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Grazing-Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                 $(NOT ActAnimalsHead_Outputs_MR(NUTS2_Regions,Activities,AnimalTypeInHerd,"Grazing-Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios))
         = sum(Countries$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 ActAnimalsHead_Outputs_MR(Countries,Activities,AnimalTypeInHerd,"Grazing-Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 5.8:" timeElapsed;


*sum over all activities:
VActCropsGrass_OtherChar_MR.l(NUTS2_Regions,"All crops and grass","Soil water erosion (t soil lost)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Activities,
                 ActCropsGrass_OtherChar_MR(NUTS2_Regions,Activities,"Soil water erosion (t soil lost)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,ProductionSystems,"AllProdCond",Scenarios));

VActCropsGrass_Outputs_MR.l(NUTS2_Regions,"All crops and grass","NH3 from mineral fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Activities,
                 ActCropsGrass_Outputs_MR(NUTS2_Regions,Activities,"NH3 from mineral fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,ProductionSystems,"AllProdCond",Scenarios));
VActCropsGrass_Outputs_MR.l(NUTS2_Regions,"All crops and grass","NH3 from CropRes/biomass as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Activities,
                 ActCropsGrass_Outputs_MR(NUTS2_Regions,Activities,"NH3 from CropRes/biomass as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,ProductionSystems,"AllProdCond",Scenarios));
VActCropsGrass_Outputs_MR.l(NUTS2_Regions,"All crops and grass","NH3 from manure as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         = sum(Activities,
                 ActCropsGrass_Outputs_MR(NUTS2_Regions,Activities,"NH3 from manure as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActCropsGrass_QuantityActUnits_MR.l(NUTS2_Regions,Activities,ProductionSystems,"AllProdCond",Scenarios));

VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Manure man NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         = sum((Livestock,AnimalTypeInherd),
                 ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Manure man NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios));
VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Grazing NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         = sum((Livestock,AnimalTypeInherd),
                 ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Grazing NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios));
VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         = sum((Livestock,AnimalTypeInherd),
                 ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios));
VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Grazing-Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         = sum((Livestock,AnimalTypeInherd),
                 ActAnimalsHead_Outputs_MR(NUTS2_Regions,Livestock,AnimalTypeInHerd,"Grazing-Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
                         *VActAnimalsHead_QuantityActUnits_MR.l(NUTS2_Regions,Livestock,AnimalTypeInHerd,ProductionSystems,"AllProdCond",Scenarios));

PUTCLOSE con "   SESSIT final calc 6:" timeElapsed;

*produce a tailor-made output for the Sessit tool:
Set Sessit_OutputDimensions
/
"Animal welfare: transport volume index"
"Animal welfare: heat stress index 2020"
"Animal welfare: heat stress index 2030"
"Animal welfare: heat stress index 2050"
"Animal welfare: production intensity index - ruminants"
"Animal welfare: production intensity index - eggs"
"Animal welfare: production intensity index - monogastric meat"
"Animal welfare: antibiotics use index"
"Labour use crops - total (h)"
"Labour use animals - total (h)"
"Labour use crops and animals - total (h)"
"Blue Water Footprint (m3)"
"Green Water Footprint (m3)"
"Grey Water Footprint (m3)"
"Irrigation water (m3)"
"Irrigation water (m3) - water stress adjusted"

"Animal welfare: heat stress index"
"Producer value - crops ($)"
"Producer value - animals ($)"
"Producer value - total ($)"

"Labour productivity - crops ($/hour)"
"Labour productivity - animals ($/hour)"
"Labour productivity - total ($/hour)"

"Soil water erosion index (t soil lost)"
"NH3 from land (t NH3)"
"NH3 from livestock (t NH3)"
"NH3 total (t NH3)"
/;

Parameter Sessit_OutputValues_ProdSys(Regions,Sessit_OutputDimensions,ProductionSystems,Scenarios);
Parameter Sessit_OutputValues(Regions,Sessit_OutputDimensions,Scenarios);

Sessit_OutputValues_ProdSys(NUTS2_Regions,"Animal welfare: transport volume index",ProductionSystems,Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: transport volume index",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Animal welfare: heat stress index 2020",ProductionSystems,Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: heat stress index 2020",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Animal welfare: heat stress index 2050",ProductionSystems,Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: heat stress index 2050",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Animal welfare: production intensity index - ruminants",ProductionSystems,Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: production intensity index - ruminants",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Animal welfare: production intensity index - eggs",ProductionSystems,Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: production intensity index - eggs",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Animal welfare: production intensity index - monogastric meat",ProductionSystems,Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: production intensity index - monogastric meat",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Animal welfare: antibiotics use index",ProductionSystems,Scenarios)
         = VActAnimalsHead_OtherChar_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Animal welfare: antibiotics use index",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour use crops - total (h)",ProductionSystems,Scenarios)
         = VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Labour use - total (h)",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour use animals - total (h)",ProductionSystems,Scenarios)
         = VActAnimalsHead_Inputs_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Labour use - total (h)",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour use crops and animals - total (h)",ProductionSystems,Scenarios)
         = Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour use crops - total (h)",ProductionSystems,Scenarios)
                 +Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour use animals - total (h)",ProductionSystems,Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Blue Water Footprint (m3)",ProductionSystems,Scenarios)
         = VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Blue Water Footprint (m3)",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Green Water Footprint (m3)",ProductionSystems,Scenarios)
         = VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Green Water Footprint (m3)",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Grey Water Footprint (m3)",ProductionSystems,Scenarios)
         = VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Grey Water Footprint (m3)",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Irrigation water (m3)",ProductionSystems,Scenarios)
         = VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Irrigation water (m3)",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Irrigation water (m3) - water stress adjusted",ProductionSystems,Scenarios)
         = VActCropsGrass_Inputs_MR.l(NUTS2_Regions,"All crops","Irrigation water (m3) - water stress adjusted",ProductionSystems,"AllProdCond",Scenarios);

Sessit_OutputValues_ProdSys(NUTS2_Regions,"Producer value - crops ($)",ProductionSystems,Scenarios)
         = VCommod_OtherChar_MR.l(NUTS2_Regions,"All crop based Commodities","Producer price ($)",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Producer value - animals ($)",ProductionSystems,Scenarios)
         = VCommod_OtherChar_MR.l(NUTS2_Regions,"All animal based Commodities","Producer price ($)",ProductionSystems,"AllProdCond",Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Producer value - total ($)",ProductionSystems,Scenarios)
         = VCommod_OtherChar_MR.l(NUTS2_Regions,"All Commodities","Producer price ($)",ProductionSystems,"AllProdCond",Scenarios);

Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour productivity - crops ($/hour)",ProductionSystems,Scenarios)
                 $Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour use crops - total (h)",ProductionSystems,Scenarios)
         = Sessit_OutputValues_ProdSys(NUTS2_Regions,"Producer value - crops ($)",ProductionSystems,Scenarios)
                 /Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour use crops - total (h)",ProductionSystems,Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour productivity - animals ($/hour)",ProductionSystems,Scenarios)
                 $Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour use animals - total (h)",ProductionSystems,Scenarios)
         = Sessit_OutputValues_ProdSys(NUTS2_Regions,"Producer value - animals ($)",ProductionSystems,Scenarios)
                 /Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour use animals - total (h)",ProductionSystems,Scenarios);
Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour productivity - total ($/hour)",ProductionSystems,Scenarios)
                 $Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour use crops and animals - total (h)",ProductionSystems,Scenarios)
         = Sessit_OutputValues_ProdSys(NUTS2_Regions,"Producer value - total ($)",ProductionSystems,Scenarios)
                 /Sessit_OutputValues_ProdSys(NUTS2_Regions,"Labour use crops and animals - total (h)",ProductionSystems,Scenarios);


Sessit_OutputValues_ProdSys(NUTS2_Regions,"Soil water erosion index (t soil lost)",ProductionSystems,Scenarios)
         = VActCropsGrass_OtherChar_MR.l(NUTS2_Regions,"All crops and grass","Soil water erosion (t soil lost)",ProductionSystems,"AllProdCond",Scenarios);

Sessit_OutputValues_ProdSys(NUTS2_Regions,"NH3 from land (t NH3)",ProductionSystems,Scenarios)
         = VActCropsGrass_Outputs_MR.l(NUTS2_Regions,"All crops and grass","NH3 from mineral fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         + VActCropsGrass_Outputs_MR.l(NUTS2_Regions,"All crops and grass","NH3 from CropRes/biomass as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         + VActCropsGrass_Outputs_MR.l(NUTS2_Regions,"All crops and grass","NH3 from manure as fert N applic (tNH3)",ProductionSystems,"AllProdCond",Scenarios);

Sessit_OutputValues_ProdSys(NUTS2_Regions,"NH3 from livestock (t NH3)",ProductionSystems,Scenarios)
         = VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Manure man NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         + VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Grazing NH3 (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         + VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios)
         + VActAnimalsHead_Outputs_MR.l(NUTS2_Regions,"All animals","AllAndAverageTypes","Grazing-Housing NH3 from manure (tNH3)",ProductionSystems,"AllProdCond",Scenarios);

Sessit_OutputValues_ProdSys(NUTS2_Regions,"NH3 total (t NH3)",ProductionSystems,Scenarios)
         = Sessit_OutputValues_ProdSys(NUTS2_Regions,"NH3 from land (t NH3)",ProductionSystems,Scenarios)
         + Sessit_OutputValues_ProdSys(NUTS2_Regions,"NH3 from livestock (t NH3)",ProductionSystems,Scenarios);



Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,Scenarios)
                 $(NOT Sessit_OutputValues_ProdSys(NUTS2_Regions,Sessit_OutputDimensions,"AllProdSyst",Scenarios))
         = Sessit_OutputValues_ProdSys(NUTS2_Regions,Sessit_OutputDimensions,"Organic",Scenarios)
                 + Sessit_OutputValues_ProdSys(NUTS2_Regions,Sessit_OutputDimensions,"Convent",Scenarios);
Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,Scenarios)
                 $(Sessit_OutputValues_ProdSys(NUTS2_Regions,Sessit_OutputDimensions,"AllProdSyst",Scenarios))
         = Sessit_OutputValues_ProdSys(NUTS2_Regions,Sessit_OutputDimensions,"AllProdSyst",Scenarios);

*use one heat stress parameter only:
Sessit_OutputValues(Regions,"Animal welfare: heat stress index","FOFA_BAU_2012")
          = Sessit_OutputValues(Regions,"Animal welfare: heat stress index 2020","FOFA_BAU_2012");
Sessit_OutputValues(Regions,"Animal welfare: heat stress index","FOFA_BAU_2050")
          = Sessit_OutputValues(Regions,"Animal welfare: heat stress index 2050","FOFA_BAU_2050");
Sessit_OutputValues(Regions,"Animal welfare: heat stress index",ScenariosUNISECO)
          = Sessit_OutputValues(Regions,"Animal welfare: heat stress index 2050",ScenariosUNISECO);
Sessit_OutputValues(Regions,"Animal welfare: heat stress index 2020",Scenarios) = 0;
Sessit_OutputValues(Regions,"Animal welfare: heat stress index 2030",Scenarios) = 0;
Sessit_OutputValues(Regions,"Animal welfare: heat stress index 2050",Scenarios) = 0;

*derive 2030 values:
Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2030")
         = Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2012")
                 +(Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2050")
                         - Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2012"))/38*18;
Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"LfP_2030")
         = Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2012")
                 +(Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"LfP_2050")
                         - Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2012"))/38*18;
Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"AE_exports_2030")
         = Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2012")
                 +(Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"AE_exports_2050")
                         - Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2012"))/38*18;
Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"LfS_2030")
         = Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2012")
                 +(Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"LfS_2050")
                         - Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2012"))/38*18;
Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"AE_food_2030")
         = Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2012")
                 +(Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"AE_food_2050")
                         - Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,"FOFA_BAU_2012"))/38*18;

*Do country values and sum for the whole of the EU:
Sessit_OutputValues("European Union",Sessit_OutputDimensions,Scenarios)
         = sum(NUTS2_Regions,
                 Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,Scenarios));
Sessit_OutputValues(Countries,Sessit_OutputDimensions,Scenarios)
         = sum(NUTS2_Regions$Match_Countries_NUTS2(Countries,NUTS2_Regions),
                 Sessit_OutputValues(NUTS2_Regions,Sessit_OutputDimensions,Scenarios));

*the sum does not work for labour productivity, thus derive this anew:
Sessit_OutputValues_ProdSys("European Union","Labour productivity - crops ($/hour)",ProductionSystems,Scenarios)
                 $Sessit_OutputValues_ProdSys("European Union","Labour use crops - total (h)",ProductionSystems,Scenarios)
         = Sessit_OutputValues_ProdSys("European Union","Producer value - crops ($)",ProductionSystems,Scenarios)
                 /Sessit_OutputValues_ProdSys("European Union","Labour use crops - total (h)",ProductionSystems,Scenarios);
Sessit_OutputValues_ProdSys("European Union","Labour productivity - animals ($/hour)",ProductionSystems,Scenarios)
                 $Sessit_OutputValues_ProdSys("European Union","Labour use animals - total (h)",ProductionSystems,Scenarios)
         = Sessit_OutputValues_ProdSys("European Union","Producer value - animals ($)",ProductionSystems,Scenarios)
                 /Sessit_OutputValues_ProdSys("European Union","Labour use animals - total (h)",ProductionSystems,Scenarios);
Sessit_OutputValues_ProdSys("European Union","Labour productivity - total ($/hour)",ProductionSystems,Scenarios)
                 $Sessit_OutputValues_ProdSys("European Union","Labour use crops and animals - total (h)",ProductionSystems,Scenarios)
         = Sessit_OutputValues_ProdSys("European Union","Producer value - total ($)",ProductionSystems,Scenarios)
                 /Sessit_OutputValues_ProdSys("European Union","Labour use crops and animals - total (h)",ProductionSystems,Scenarios);

Sessit_OutputValues_ProdSys(Countries,"Labour productivity - crops ($/hour)",ProductionSystems,Scenarios)
                 $Sessit_OutputValues_ProdSys(Countries,"Labour use crops - total (h)",ProductionSystems,Scenarios)
         = Sessit_OutputValues_ProdSys(Countries,"Producer value - crops ($)",ProductionSystems,Scenarios)
                 /Sessit_OutputValues_ProdSys(Countries,"Labour use crops - total (h)",ProductionSystems,Scenarios);
Sessit_OutputValues_ProdSys(Countries,"Labour productivity - animals ($/hour)",ProductionSystems,Scenarios)
                 $Sessit_OutputValues_ProdSys(Countries,"Labour use animals - total (h)",ProductionSystems,Scenarios)
         = Sessit_OutputValues_ProdSys(Countries,"Producer value - animals ($)",ProductionSystems,Scenarios)
                 /Sessit_OutputValues_ProdSys(Countries,"Labour use animals - total (h)",ProductionSystems,Scenarios);
Sessit_OutputValues_ProdSys(Countries,"Labour productivity - total ($/hour)",ProductionSystems,Scenarios)
                 $Sessit_OutputValues_ProdSys(Countries,"Labour use crops and animals - total (h)",ProductionSystems,Scenarios)
         = Sessit_OutputValues_ProdSys(Countries,"Producer value - total ($)",ProductionSystems,Scenarios)
                 /Sessit_OutputValues_ProdSys(Countries,"Labour use crops and animals - total (h)",ProductionSystems,Scenarios);


execute_unload "DataForSESSIT_%OutputFileLabel%"
*for doing the SESSIT indicators, we need the following new from AFTER running Steering2:
*animal welfare intensity monogastrics:
ActAnimalsHead_OtherChar_MR
ActAnimalsHead_Inputs_MR
*crop yields
ActCropsGrass_Outputs_MR
*animal numbers
VActAnimalsHead_QuantityActUnits_MR
*and in addition the NUTS2 level values from Steering1:
ActCropsGrass_OtherChar
ActCropsGrass_OtherChar_MR
ActCropsGrass_Inputs
ActCropsGrass_Inputs_MR
VActCropsGrass_QuantityActUnits_MR

*and aggregate results:
VActAnimalsHead_OtherChar_MR
VActAnimalsHead_Inputs_MR
VActCropsGrass_Inputs_MR

Sessit_OutputValues_ProdSys
Sessit_OutputValues

Commod_OtherChar_MR
VCommod_OtherChar_MR
VActAnimalsHead_Outputs_MR
VActCropsGrass_Outputs_MR
;

*organise output such as to be for best use for Sessit:
SET ColumnsForSessitOutput
/
year2012,year2030,year2050
/;

SET MatchScenarios_SessitColumns(Scenarios,ColumnsForSessitOutput)
/
"FOFA_BAU_2012".year2012
"LfP_2012".year2012
"AE_exports_2012".year2012
"LfS_2012".year2012
"AE_food_2012".year2012
"FOFA_BAU_2030".year2030
"LfP_2030".year2030
"AE_exports_2030".year2030
"LfS_2030".year2030
"AE_food_2030".year2030
"FOFA_BAU_2050".year2050
"LfP_2050".year2050
"AE_exports_2050".year2050
"LfS_2050".year2050
"AE_food_2050".year2050
/;

PUTCLOSE con "   SESSIT final calc 7:" timeElapsed;


Parameter LabourProductivity_Animals_EuroPerHour_Aeexp(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Animals_EuroPerHour_BAU(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Animals_EuroPerHour_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Animals_EuroPerHour_LfP(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Animals_EuroPerHour_LfS(Regions,ColumnsForSessitOutput);

Parameter LabourProductivity_Crops_EuroPerHour_Aeexp(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Crops_EuroPerHour_BAU(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Crops_EuroPerHour_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Crops_EuroPerHour_LfP(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Crops_EuroPerHour_LfS(Regions,ColumnsForSessitOutput);

Parameter LabourProductivity_Total_EuroPerHour_Aeexp(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Total_EuroPerHour_BAU(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Total_EuroPerHour_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Total_EuroPerHour_LfP(Regions,ColumnsForSessitOutput);
Parameter LabourProductivity_Total_EuroPerHour_LfS(Regions,ColumnsForSessitOutput);

Parameter ProducerValue_Animals_Euro_Aeexp(Regions,ColumnsForSessitOutput);
Parameter ProducerValue_Animals_Euro_BAU(Regions,ColumnsForSessitOutput);
Parameter ProducerValue_Animals_Euro_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter ProducerValue_Animals_Euro_LfP(Regions,ColumnsForSessitOutput);
Parameter ProducerValue_Animals_Euro_LfS(Regions,ColumnsForSessitOutput);

Parameter ProducerValue_Crops_Euro_Aeexp(Regions,ColumnsForSessitOutput);
Parameter ProducerValue_Crops_Euro_BAU(Regions,ColumnsForSessitOutput);
Parameter ProducerValue_Crops_Euro_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter ProducerValue_Crops_Euro_LfP(Regions,ColumnsForSessitOutput);
Parameter ProducerValue_Crops_Euro_LfS(Regions,ColumnsForSessitOutput);

Parameter AnimalWelfare_Transport_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_Transport_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_Transport_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_Transport_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_Transport_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter AnimalWelfare_IntensityRuminants_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityRuminants_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityRuminants_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityRuminants_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityRuminants_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter AnimalWelfare_IntensityEggs_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityEggs_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityEggs_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityEggs_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityEggs_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter AnimalWelfare_IntensityMonogastrMeat_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityMonogastrMeat_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityMonogastrMeat_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityMonogastrMeat_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_IntensityMonogastrMeat_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter AnimalWelfare_Antibiotics_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_Antibiotics_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_Antibiotics_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_Antibiotics_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_Antibiotics_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter AnimalWelfare_HeatStress_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_HeatStress_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_HeatStress_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_HeatStress_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter AnimalWelfare_HeatStress_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter CropLabourUse_h_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter CropLabourUse_h_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter CropLabourUse_h_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter CropLabourUse_h_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter CropLabourUse_h_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter AnimalLabourUse_h_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter AnimalLabourUse_h_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter AnimalLabourUse_h_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter AnimalLabourUse_h_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter AnimalLabourUse_h_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter BlueWater_m3_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter BlueWater_m3_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter BlueWater_m3_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter BlueWater_m3_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter BlueWater_m3_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter GreenWater_m3_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter GreenWater_m3_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter GreenWater_m3_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter GreenWater_m3_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter GreenWater_m3_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter GreyWater_m3_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter GreyWater_m3_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter GreyWater_m3_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter GreyWater_m3_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter GreyWater_m3_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter Irrigation_m3_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter Irrigation_m3_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter Irrigation_m3_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter Irrigation_m3_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter Irrigation_m3_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter IrrigationScarcityAdjusted_m3_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter IrrigationScarcityAdjusted_m3_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter IrrigationScarcityAdjusted_m3_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter IrrigationScarcityAdjusted_m3_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter IrrigationScarcityAdjusted_m3_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter SoilWaterErosion_t_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter SoilWaterErosion_t_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter SoilWaterErosion_t_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter SoilWaterErosion_t_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter SoilWaterErosion_t_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter NH3FromLand_t_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter NH3FromLand_t_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter NH3FromLand_t_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter NH3FromLand_t_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter NH3FromLand_t_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter NH3FromLivestock_t_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter NH3FromLivestock_t_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter NH3FromLivestock_t_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter NH3FromLivestock_t_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter NH3FromLivestock_t_Index_LfS(Regions,ColumnsForSessitOutput);

Parameter NH3Total_t_Index_Aeexp(Regions,ColumnsForSessitOutput);
Parameter NH3Total_t_Index_BAU(Regions,ColumnsForSessitOutput);
Parameter NH3Total_t_Index_LAEsyst(Regions,ColumnsForSessitOutput);
Parameter NH3Total_t_Index_LfP(Regions,ColumnsForSessitOutput);
Parameter NH3Total_t_Index_LfS(Regions,ColumnsForSessitOutput);


Set Scenarios_Aeexp(Scenarios) /FOFA_BAU_2012,AE_exports_2030,AE_exports_2050/;
Set Scenarios_BAU(Scenarios) /FOFA_BAU_2012,FOFA_BAU_2030,FOFA_BAU_2050/;
Set Scenarios_LAEsyst(Scenarios) /FOFA_BAU_2012,AE_food_2030,AE_food_2050/;
Set Scenarios_LfP(Scenarios) /FOFA_BAU_2012,LfP_2030,LfP_2050/;
Set Scenarios_LfS(Scenarios) /FOFA_BAU_2012,LfS_2030,LfS_2050/;

LabourProductivity_Animals_EuroPerHour_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - animals ($/hour)",Scenarios_Aeexp));
LabourProductivity_Animals_EuroPerHour_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - animals ($/hour)",Scenarios_BAU));
LabourProductivity_Animals_EuroPerHour_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - animals ($/hour)",Scenarios_LAEsyst));
LabourProductivity_Animals_EuroPerHour_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - animals ($/hour)",Scenarios_LfP));
LabourProductivity_Animals_EuroPerHour_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - animals ($/hour)",Scenarios_LfS));

LabourProductivity_Crops_EuroPerHour_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - crops ($/hour)",Scenarios_Aeexp));
LabourProductivity_Crops_EuroPerHour_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - crops ($/hour)",Scenarios_BAU));
LabourProductivity_Crops_EuroPerHour_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - crops ($/hour)",Scenarios_LAEsyst));
LabourProductivity_Crops_EuroPerHour_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - crops ($/hour)",Scenarios_LfP));
LabourProductivity_Crops_EuroPerHour_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - crops ($/hour)",Scenarios_LfS));

LabourProductivity_Total_EuroPerHour_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - total ($/hour)",Scenarios_Aeexp));
LabourProductivity_Total_EuroPerHour_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - total ($/hour)",Scenarios_BAU));
LabourProductivity_Total_EuroPerHour_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - total ($/hour)",Scenarios_LAEsyst));
LabourProductivity_Total_EuroPerHour_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - total ($/hour)",Scenarios_LfP));
LabourProductivity_Total_EuroPerHour_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour productivity - total ($/hour)",Scenarios_LfS));

ProducerValue_Animals_Euro_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Producer value - animals ($)",Scenarios_Aeexp));
ProducerValue_Animals_Euro_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Producer value - animals ($)",Scenarios_BAU));
ProducerValue_Animals_Euro_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Producer value - animals ($)",Scenarios_LAEsyst));
ProducerValue_Animals_Euro_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Producer value - animals ($)",Scenarios_LfP));
ProducerValue_Animals_Euro_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Producer value - animals ($)",Scenarios_LfS));

ProducerValue_Crops_Euro_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Producer value - crops ($)",Scenarios_Aeexp));
ProducerValue_Crops_Euro_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Producer value - crops ($)",Scenarios_BAU));
ProducerValue_Crops_Euro_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Producer value - crops ($)",Scenarios_LAEsyst));
ProducerValue_Crops_Euro_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Producer value - crops ($)",Scenarios_LfP));
ProducerValue_Crops_Euro_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Producer value - crops ($)",Scenarios_LfS));

AnimalWelfare_Transport_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: transport volume index",Scenarios_Aeexp));
AnimalWelfare_Transport_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: transport volume index",Scenarios_BAU));
AnimalWelfare_Transport_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: transport volume index",Scenarios_LAEsyst));
AnimalWelfare_Transport_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: transport volume index",Scenarios_LfP));
AnimalWelfare_Transport_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: transport volume index",Scenarios_LfS));

AnimalWelfare_IntensityRuminants_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - ruminants",Scenarios_Aeexp));
AnimalWelfare_IntensityRuminants_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - ruminants",Scenarios_BAU));
AnimalWelfare_IntensityRuminants_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - ruminants",Scenarios_LAEsyst));
AnimalWelfare_IntensityRuminants_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - ruminants",Scenarios_LfP));
AnimalWelfare_IntensityRuminants_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - ruminants",Scenarios_LfS));

AnimalWelfare_IntensityEggs_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - eggs",Scenarios_Aeexp));
AnimalWelfare_IntensityEggs_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - eggs",Scenarios_BAU));
AnimalWelfare_IntensityEggs_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - eggs",Scenarios_LAEsyst));
AnimalWelfare_IntensityEggs_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - eggs",Scenarios_LfP));
AnimalWelfare_IntensityEggs_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - eggs",Scenarios_LfS));

AnimalWelfare_IntensityMonogastrMeat_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - monogastric meat",Scenarios_Aeexp));
AnimalWelfare_IntensityMonogastrMeat_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - monogastric meat",Scenarios_BAU));
AnimalWelfare_IntensityMonogastrMeat_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - monogastric meat",Scenarios_LAEsyst));
AnimalWelfare_IntensityMonogastrMeat_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - monogastric meat",Scenarios_LfP));
AnimalWelfare_IntensityMonogastrMeat_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: production intensity index - monogastric meat",Scenarios_LfS));

AnimalWelfare_Antibiotics_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: antibiotics use index",Scenarios_Aeexp));
AnimalWelfare_Antibiotics_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: antibiotics use index",Scenarios_BAU));
AnimalWelfare_Antibiotics_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: antibiotics use index",Scenarios_LAEsyst));
AnimalWelfare_Antibiotics_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: antibiotics use index",Scenarios_LfP));
AnimalWelfare_Antibiotics_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: antibiotics use index",Scenarios_LfS));

AnimalWelfare_HeatStress_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: heat stress index",Scenarios_Aeexp));
AnimalWelfare_HeatStress_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: heat stress index",Scenarios_BAU));
AnimalWelfare_HeatStress_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: heat stress index",Scenarios_LAEsyst));
AnimalWelfare_HeatStress_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: heat stress index",Scenarios_LfP));
AnimalWelfare_HeatStress_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Animal welfare: heat stress index",Scenarios_LfS));

CropLabourUse_h_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour use crops - total (h)",Scenarios_Aeexp));
CropLabourUse_h_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour use crops - total (h)",Scenarios_BAU));
CropLabourUse_h_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour use crops - total (h)",Scenarios_LAEsyst));
CropLabourUse_h_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour use crops - total (h)",Scenarios_LfP));
CropLabourUse_h_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour use crops - total (h)",Scenarios_LfS));

AnimalLabourUse_h_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour use animals - total (h)",Scenarios_Aeexp));
AnimalLabourUse_h_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour use animals - total (h)",Scenarios_BAU));
AnimalLabourUse_h_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour use animals - total (h)",Scenarios_LAEsyst));
AnimalLabourUse_h_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour use animals - total (h)",Scenarios_LfP));
AnimalLabourUse_h_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Labour use animals - total (h)",Scenarios_LfS));

BlueWater_m3_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Blue Water Footprint (m3)",Scenarios_Aeexp));
BlueWater_m3_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Blue Water Footprint (m3)",Scenarios_BAU));
BlueWater_m3_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Blue Water Footprint (m3)",Scenarios_LAEsyst));
BlueWater_m3_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Blue Water Footprint (m3)",Scenarios_LfP));
BlueWater_m3_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Blue Water Footprint (m3)",Scenarios_LfS));

GreenWater_m3_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Green Water Footprint (m3)",Scenarios_Aeexp));
GreenWater_m3_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Green Water Footprint (m3)",Scenarios_BAU));
GreenWater_m3_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Green Water Footprint (m3)",Scenarios_LAEsyst));
GreenWater_m3_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Green Water Footprint (m3)",Scenarios_LfP));
GreenWater_m3_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Green Water Footprint (m3)",Scenarios_LfS));

GreyWater_m3_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Grey Water Footprint (m3)",Scenarios_Aeexp));
GreyWater_m3_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Grey Water Footprint (m3)",Scenarios_BAU));
GreyWater_m3_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Grey Water Footprint (m3)",Scenarios_LAEsyst));
GreyWater_m3_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Grey Water Footprint (m3)",Scenarios_LfP));
GreyWater_m3_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Grey Water Footprint (m3)",Scenarios_LfS));

Irrigation_m3_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Irrigation water (m3)",Scenarios_Aeexp));
Irrigation_m3_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Irrigation water (m3)",Scenarios_BAU));
Irrigation_m3_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Irrigation water (m3)",Scenarios_LAEsyst));
Irrigation_m3_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Irrigation water (m3)",Scenarios_LfP));
Irrigation_m3_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Irrigation water (m3)",Scenarios_LfS));

IrrigationScarcityAdjusted_m3_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Irrigation water (m3) - water stress adjusted",Scenarios_Aeexp));
IrrigationScarcityAdjusted_m3_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Irrigation water (m3) - water stress adjusted",Scenarios_BAU));
IrrigationScarcityAdjusted_m3_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Irrigation water (m3) - water stress adjusted",Scenarios_LAEsyst));
IrrigationScarcityAdjusted_m3_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Irrigation water (m3) - water stress adjusted",Scenarios_LfP));
IrrigationScarcityAdjusted_m3_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Irrigation water (m3) - water stress adjusted",Scenarios_LfS));

SoilWaterErosion_t_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Soil water erosion index (t soil lost)",Scenarios_Aeexp));
SoilWaterErosion_t_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Soil water erosion index (t soil lost)",Scenarios_BAU));
SoilWaterErosion_t_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Soil water erosion index (t soil lost)",Scenarios_LAEsyst));
SoilWaterErosion_t_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Soil water erosion index (t soil lost)",Scenarios_LfP));
SoilWaterErosion_t_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"Soil water erosion index (t soil lost)",Scenarios_LfS));

NH3FromLand_t_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 from land (t NH3)",Scenarios_Aeexp));
NH3FromLand_t_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 from land (t NH3)",Scenarios_BAU));
NH3FromLand_t_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 from land (t NH3)",Scenarios_LAEsyst));
NH3FromLand_t_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 from land (t NH3)",Scenarios_LfP));
NH3FromLand_t_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 from land (t NH3)",Scenarios_LfS));

NH3FromLivestock_t_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 from livestock (t NH3)",Scenarios_Aeexp));
NH3FromLivestock_t_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 from livestock (t NH3)",Scenarios_BAU));
NH3FromLivestock_t_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 from livestock (t NH3)",Scenarios_LAEsyst));
NH3FromLivestock_t_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 from livestock (t NH3)",Scenarios_LfP));
NH3FromLivestock_t_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 from livestock (t NH3)",Scenarios_LfS));

NH3Total_t_Index_Aeexp(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_Aeexp$MatchScenarios_SessitColumns(Scenarios_Aeexp,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 total (t NH3)",Scenarios_Aeexp));
NH3Total_t_Index_BAU(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_BAU$MatchScenarios_SessitColumns(Scenarios_BAU,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 total (t NH3)",Scenarios_BAU));
NH3Total_t_Index_LAEsyst(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LAEsyst$MatchScenarios_SessitColumns(Scenarios_LAEsyst,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 total (t NH3)",Scenarios_LAEsyst));
NH3Total_t_Index_LfP(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfP$MatchScenarios_SessitColumns(Scenarios_LfP,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 total (t NH3)",Scenarios_LfP));
NH3Total_t_Index_LfS(Regions,ColumnsForSessitOutput)
         = sum(Scenarios_LfS$MatchScenarios_SessitColumns(Scenarios_LfS,ColumnsForSessitOutput),
                 Sessit_OutputValues(Regions,"NH3 total (t NH3)",Scenarios_LfS));




execute_unload 'DataForSessit_Rearranged'
LabourProductivity_Animals_EuroPerHour_Aeexp
LabourProductivity_Animals_EuroPerHour_BAU
LabourProductivity_Animals_EuroPerHour_LAEsyst
LabourProductivity_Animals_EuroPerHour_LfP
LabourProductivity_Animals_EuroPerHour_LfS

LabourProductivity_Crops_EuroPerHour_Aeexp
LabourProductivity_Crops_EuroPerHour_BAU
LabourProductivity_Crops_EuroPerHour_LAEsyst
LabourProductivity_Crops_EuroPerHour_LfP
LabourProductivity_Crops_EuroPerHour_LfS

LabourProductivity_Total_EuroPerHour_Aeexp
LabourProductivity_Total_EuroPerHour_BAU
LabourProductivity_Total_EuroPerHour_LAEsyst
LabourProductivity_Total_EuroPerHour_LfP
LabourProductivity_Total_EuroPerHour_LfS

ProducerValue_Animals_Euro_Aeexp
ProducerValue_Animals_Euro_BAU
ProducerValue_Animals_Euro_LAEsyst
ProducerValue_Animals_Euro_LfP
ProducerValue_Animals_Euro_LfS

ProducerValue_Crops_Euro_Aeexp
ProducerValue_Crops_Euro_BAU
ProducerValue_Crops_Euro_LAEsyst
ProducerValue_Crops_Euro_LfP
ProducerValue_Crops_Euro_LfS

AnimalWelfare_Transport_Index_Aeexp
AnimalWelfare_Transport_Index_BAU
AnimalWelfare_Transport_Index_LAEsyst
AnimalWelfare_Transport_Index_LfP
AnimalWelfare_Transport_Index_LfS

AnimalWelfare_IntensityRuminants_Index_Aeexp
AnimalWelfare_IntensityRuminants_Index_BAU
AnimalWelfare_IntensityRuminants_Index_LAEsyst
AnimalWelfare_IntensityRuminants_Index_LfP
AnimalWelfare_IntensityRuminants_Index_LfS

AnimalWelfare_IntensityEggs_Index_Aeexp
AnimalWelfare_IntensityEggs_Index_BAU
AnimalWelfare_IntensityEggs_Index_LAEsyst
AnimalWelfare_IntensityEggs_Index_LfP
AnimalWelfare_IntensityEggs_Index_LfS

AnimalWelfare_IntensityMonogastrMeat_Index_Aeexp
AnimalWelfare_IntensityMonogastrMeat_Index_BAU
AnimalWelfare_IntensityMonogastrMeat_Index_LAEsyst
AnimalWelfare_IntensityMonogastrMeat_Index_LfP
AnimalWelfare_IntensityMonogastrMeat_Index_LfS

AnimalWelfare_Antibiotics_Index_Aeexp
AnimalWelfare_Antibiotics_Index_BAU
AnimalWelfare_Antibiotics_Index_LAEsyst
AnimalWelfare_Antibiotics_Index_LfP
AnimalWelfare_Antibiotics_Index_LfS

AnimalWelfare_HeatStress_Index_Aeexp
AnimalWelfare_HeatStress_Index_BAU
AnimalWelfare_HeatStress_Index_LAEsyst
AnimalWelfare_HeatStress_Index_LfP
AnimalWelfare_HeatStress_Index_LfS

CropLabourUse_h_Index_Aeexp
CropLabourUse_h_Index_BAU
CropLabourUse_h_Index_LAEsyst
CropLabourUse_h_Index_LfP
CropLabourUse_h_Index_LfS

AnimalLabourUse_h_Index_Aeexp
AnimalLabourUse_h_Index_BAU
AnimalLabourUse_h_Index_LAEsyst
AnimalLabourUse_h_Index_LfP
AnimalLabourUse_h_Index_LfS

BlueWater_m3_Index_Aeexp
BlueWater_m3_Index_BAU
BlueWater_m3_Index_LAEsyst
BlueWater_m3_Index_LfP
BlueWater_m3_Index_LfS

GreenWater_m3_Index_Aeexp
GreenWater_m3_Index_BAU
GreenWater_m3_Index_LAEsyst
GreenWater_m3_Index_LfP
GreenWater_m3_Index_LfS

GreyWater_m3_Index_Aeexp
GreyWater_m3_Index_BAU
GreyWater_m3_Index_LAEsyst
GreyWater_m3_Index_LfP
GreyWater_m3_Index_LfS

Irrigation_m3_Index_Aeexp
Irrigation_m3_Index_BAU
Irrigation_m3_Index_LAEsyst
Irrigation_m3_Index_LfP
Irrigation_m3_Index_LfS

IrrigationScarcityAdjusted_m3_Index_Aeexp
IrrigationScarcityAdjusted_m3_Index_BAU
IrrigationScarcityAdjusted_m3_Index_LAEsyst
IrrigationScarcityAdjusted_m3_Index_LfP
IrrigationScarcityAdjusted_m3_Index_LfS

SoilWaterErosion_t_Index_Aeexp
SoilWaterErosion_t_Index_BAU
SoilWaterErosion_t_Index_LAEsyst
SoilWaterErosion_t_Index_LfP
SoilWaterErosion_t_Index_LfS

NH3FromLand_t_Index_Aeexp
NH3FromLand_t_Index_BAU
NH3FromLand_t_Index_LAEsyst
NH3FromLand_t_Index_LfP
NH3FromLand_t_Index_LfS

NH3FromLivestock_t_Index_Aeexp
NH3FromLivestock_t_Index_BAU
NH3FromLivestock_t_Index_LAEsyst
NH3FromLivestock_t_Index_LfP
NH3FromLivestock_t_Index_LfS

NH3Total_t_Index_Aeexp
NH3Total_t_Index_BAU
NH3Total_t_Index_LAEsyst
NH3Total_t_Index_LfP
NH3Total_t_Index_LfS
;


*execute 'gdxxrw DataForSessit_Rearranged.gdx output=AnimalWelfare_Transport_Index_Aeexp.xlsx par=AnimalWelfare_Transport_Index_Aeexp'
*execute 'gdxxrw DataForSessit_Rearranged.gdx output=AnimalWelfare_Transport_Index.xlsx par=AnimalWelfare_Transport_Index_Aeexp rng=AW_Transport_Index_Aeexp!A1 par=AnimalWelfare_Transport_Index_BAU rng=AW_Transport_Index_BAU!A1'

execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Animals_EuroPerHour_Aeexp.csv   symb=LabourProductivity_Animals_EuroPerHour_Aeexp   format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Animals_EuroPerHour_BAU.csv     symb=LabourProductivity_Animals_EuroPerHour_BAU     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Animals_EuroPerHour_LAEsyst.csv symb=LabourProductivity_Animals_EuroPerHour_LAEsyst format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Animals_EuroPerHour_LfP.csv     symb=LabourProductivity_Animals_EuroPerHour_LfP     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Animals_EuroPerHour_LfS.csv     symb=LabourProductivity_Animals_EuroPerHour_LfS     format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Crops_EuroPerHour_Aeexp.csv   symb=LabourProductivity_Crops_EuroPerHour_Aeexp   format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Crops_EuroPerHour_BAU.csv     symb=LabourProductivity_Crops_EuroPerHour_BAU     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Crops_EuroPerHour_LAEsyst.csv symb=LabourProductivity_Crops_EuroPerHour_LAEsyst format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Crops_EuroPerHour_LfP.csv     symb=LabourProductivity_Crops_EuroPerHour_LfP     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Crops_EuroPerHour_LfS.csv     symb=LabourProductivity_Crops_EuroPerHour_LfS     format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Total_EuroPerHour_Aeexp.csv   symb=LabourProductivity_Total_EuroPerHour_Aeexp   format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Total_EuroPerHour_BAU.csv     symb=LabourProductivity_Total_EuroPerHour_BAU     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Total_EuroPerHour_LAEsyst.csv symb=LabourProductivity_Total_EuroPerHour_LAEsyst format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Total_EuroPerHour_LfP.csv     symb=LabourProductivity_Total_EuroPerHour_LfP     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=LabourProductivity_Total_EuroPerHour_LfS.csv     symb=LabourProductivity_Total_EuroPerHour_LfS     format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=ProducerValue_Animals_Euro_Aeexp.csv   symb=ProducerValue_Animals_Euro_Aeexp   format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=ProducerValue_Animals_Euro_BAU.csv     symb=ProducerValue_Animals_Euro_BAU     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=ProducerValue_Animals_Euro_LAEsyst.csv symb=ProducerValue_Animals_Euro_LAEsyst format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=ProducerValue_Animals_Euro_LfP.csv     symb=ProducerValue_Animals_Euro_LfP     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=ProducerValue_Animals_Euro_LfS.csv     symb=ProducerValue_Animals_Euro_LfS     format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=ProducerValue_Crops_Euro_Aeexp.csv   symb=ProducerValue_Crops_Euro_Aeexp   format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=ProducerValue_Crops_Euro_BAU.csv     symb=ProducerValue_Crops_Euro_BAU     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=ProducerValue_Crops_Euro_LAEsyst.csv symb=ProducerValue_Crops_Euro_LAEsyst format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=ProducerValue_Crops_Euro_LfP.csv     symb=ProducerValue_Crops_Euro_LfP     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=ProducerValue_Crops_Euro_LfS.csv     symb=ProducerValue_Crops_Euro_LfS     format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_Transport_Index_Aeexp.csv   symb=AnimalWelfare_Transport_Index_Aeexp   format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_Transport_Index_BAU.csv     symb=AnimalWelfare_Transport_Index_BAU     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_Transport_Index_LAEsyst.csv symb=AnimalWelfare_Transport_Index_LAEsyst format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_Transport_Index_LfP.csv     symb=AnimalWelfare_Transport_Index_LfP     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_Transport_Index_LfS.csv     symb=AnimalWelfare_Transport_Index_LfS     format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityRuminants_Index_Aeexp.csv symb=AnimalWelfare_IntensityRuminants_Index_Aeexp      format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityRuminants_Index_BAU.csv symb=AnimalWelfare_IntensityRuminants_Index_BAU        format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityRuminants_Index_LAEsyst.csv symb=AnimalWelfare_IntensityRuminants_Index_LAEsyst    format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityRuminants_Index_LfP.csv symb=AnimalWelfare_IntensityRuminants_Index_LfP        format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityRuminants_Index_LfS.csv symb=AnimalWelfare_IntensityRuminants_Index_LfS        format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityEggs_Index_Aeexp.csv symb=AnimalWelfare_IntensityEggs_Index_Aeexp      format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityEggs_Index_BAU.csv symb=AnimalWelfare_IntensityEggs_Index_BAU        format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityEggs_Index_LAEsyst.csv symb=AnimalWelfare_IntensityEggs_Index_LAEsyst    format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityEggs_Index_LfP.csv symb=AnimalWelfare_IntensityEggs_Index_LfP        format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityEggs_Index_LfS.csv symb=AnimalWelfare_IntensityEggs_Index_LfS        format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityMonogastrMeat_Index_Aeexp.csv symb=AnimalWelfare_IntensityMonogastrMeat_Index_Aeexp          format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityMonogastrMeat_Index_BAU.csv symb=AnimalWelfare_IntensityMonogastrMeat_Index_BAU            format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityMonogastrMeat_Index_LAEsyst.csv symb=AnimalWelfare_IntensityMonogastrMeat_Index_LAEsyst        format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityMonogastrMeat_Index_LfP.csv symb=AnimalWelfare_IntensityMonogastrMeat_Index_LfP            format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_IntensityMonogastrMeat_Index_LfS.csv symb=AnimalWelfare_IntensityMonogastrMeat_Index_LfS            format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_Antibiotics_Index_Aeexp.csv symb=AnimalWelfare_Antibiotics_Index_Aeexp       format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_Antibiotics_Index_BAU.csv symb=AnimalWelfare_Antibiotics_Index_BAU         format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_Antibiotics_Index_LAEsyst.csv symb=AnimalWelfare_Antibiotics_Index_LAEsyst     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_Antibiotics_Index_LfP.csv symb=AnimalWelfare_Antibiotics_Index_LfP         format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_Antibiotics_Index_LfS.csv symb=AnimalWelfare_Antibiotics_Index_LfS         format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_HeatStress_Index_Aeexp.csv symb=AnimalWelfare_HeatStress_Index_Aeexp        format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_HeatStress_Index_BAU.csv symb=AnimalWelfare_HeatStress_Index_BAU          format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_HeatStress_Index_LAEsyst.csv symb=AnimalWelfare_HeatStress_Index_LAEsyst      format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_HeatStress_Index_LfP.csv symb=AnimalWelfare_HeatStress_Index_LfP          format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalWelfare_HeatStress_Index_LfS.csv symb=AnimalWelfare_HeatStress_Index_LfS          format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=CropLabourUse_h_Index_Aeexp.csv symb=CropLabourUse_h_Index_Aeexp          format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=CropLabourUse_h_Index_BAU.csv symb=CropLabourUse_h_Index_BAU            format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=CropLabourUse_h_Index_LAEsyst.csv symb=CropLabourUse_h_Index_LAEsyst        format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=CropLabourUse_h_Index_LfP.csv symb=CropLabourUse_h_Index_LfP            format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=CropLabourUse_h_Index_LfS.csv symb=CropLabourUse_h_Index_LfS            format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalLabourUse_h_Index_Aeexp.csv symb=AnimalLabourUse_h_Index_Aeexp          format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalLabourUse_h_Index_BAU.csv symb=AnimalLabourUse_h_Index_BAU            format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalLabourUse_h_Index_LAEsyst.csv symb=AnimalLabourUse_h_Index_LAEsyst        format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalLabourUse_h_Index_LfP.csv symb=AnimalLabourUse_h_Index_LfP            format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=AnimalLabourUse_h_Index_LfS.csv symb=AnimalLabourUse_h_Index_LfS            format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=BlueWater_m3_Index_Aeexp.csv symb=BlueWater_m3_Index_Aeexp         format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=BlueWater_m3_Index_BAU.csv symb=BlueWater_m3_Index_BAU           format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=BlueWater_m3_Index_LAEsyst.csv symb=BlueWater_m3_Index_LAEsyst       format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=BlueWater_m3_Index_LfP.csv symb=BlueWater_m3_Index_LfP           format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=BlueWater_m3_Index_LfS.csv symb=BlueWater_m3_Index_LfS           format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=GreenWater_m3_Index_Aeexp.csv symb=GreenWater_m3_Index_Aeexp        format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=GreenWater_m3_Index_BAU.csv symb=GreenWater_m3_Index_BAU          format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=GreenWater_m3_Index_LAEsyst.csv symb=GreenWater_m3_Index_LAEsyst      format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=GreenWater_m3_Index_LfP.csv symb=GreenWater_m3_Index_LfP          format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=GreenWater_m3_Index_LfS.csv symb=GreenWater_m3_Index_LfS          format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=GreyWater_m3_Index_Aeexp.csv symb=GreyWater_m3_Index_Aeexp         format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=GreyWater_m3_Index_BAU.csv symb=GreyWater_m3_Index_BAU           format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=GreyWater_m3_Index_LAEsyst.csv symb=GreyWater_m3_Index_LAEsyst       format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=GreyWater_m3_Index_LfP.csv symb=GreyWater_m3_Index_LfP           format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=GreyWater_m3_Index_LfS.csv symb=GreyWater_m3_Index_LfS           format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=Irrigation_m3_Index_Aeexp.csv symb=Irrigation_m3_Index_Aeexp        format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=Irrigation_m3_Index_BAU.csv symb=Irrigation_m3_Index_BAU          format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=Irrigation_m3_Index_LAEsyst.csv symb=Irrigation_m3_Index_LAEsyst      format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=Irrigation_m3_Index_LfP.csv symb=Irrigation_m3_Index_LfP          format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=Irrigation_m3_Index_LfS.csv symb=Irrigation_m3_Index_LfS          format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=IrrigationScarcityAdjusted_m3_Index_Aeexp.csv symb=IrrigationScarcityAdjusted_m3_Index_Aeexp   format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=IrrigationScarcityAdjusted_m3_Index_BAU.csv symb=IrrigationScarcityAdjusted_m3_Index_BAU     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=IrrigationScarcityAdjusted_m3_Index_LAEsyst.csv symb=IrrigationScarcityAdjusted_m3_Index_LAEsyst format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=IrrigationScarcityAdjusted_m3_Index_LfP.csv symb=IrrigationScarcityAdjusted_m3_Index_LfP     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=IrrigationScarcityAdjusted_m3_Index_LfS.csv symb=IrrigationScarcityAdjusted_m3_Index_LfS     format=csv cDim=y'


execute 'gdxdump DataForSessit_Rearranged.gdx output=SoilWaterErosion_t_Index_Aeexp.csv   symb=SoilWaterErosion_t_Index_Aeexp   format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=SoilWaterErosion_t_Index_BAU.csv     symb=SoilWaterErosion_t_Index_BAU     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=SoilWaterErosion_t_Index_LAEsyst.csv symb=SoilWaterErosion_t_Index_LAEsyst format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=SoilWaterErosion_t_Index_LfP.csv     symb=SoilWaterErosion_t_Index_LfP     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=SoilWaterErosion_t_Index_LfS.csv     symb=SoilWaterErosion_t_Index_LfS     format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3FromLand_t_Index_Aeexp.csv   symb=NH3FromLand_t_Index_Aeexp   format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3FromLand_t_Index_BAU.csv     symb=NH3FromLand_t_Index_BAU     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3FromLand_t_Index_LAEsyst.csv symb=NH3FromLand_t_Index_LAEsyst format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3FromLand_t_Index_LfP.csv     symb=NH3FromLand_t_Index_LfP     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3FromLand_t_Index_LfS.csv     symb=NH3FromLand_t_Index_LfS     format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3FromLivestock_t_Index_Aeexp.csv   symb=NH3FromLivestock_t_Index_Aeexp   format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3FromLivestock_t_Index_BAU.csv     symb=NH3FromLivestock_t_Index_BAU     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3FromLivestock_t_Index_LAEsyst.csv symb=NH3FromLivestock_t_Index_LAEsyst format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3FromLivestock_t_Index_LfP.csv     symb=NH3FromLivestock_t_Index_LfP     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3FromLivestock_t_Index_LfS.csv     symb=NH3FromLivestock_t_Index_LfS     format=csv cDim=y'

execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3Total_t_Index_Aeexp.csv   symb=NH3Total_t_Index_Aeexp   format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3Total_t_Index_BAU.csv     symb=NH3Total_t_Index_BAU     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3Total_t_Index_LAEsyst.csv symb=NH3Total_t_Index_LAEsyst format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3Total_t_Index_LfP.csv     symb=NH3Total_t_Index_LfP     format=csv cDim=y'
execute 'gdxdump DataForSessit_Rearranged.gdx output=NH3Total_t_Index_LfS.csv     symb=NH3Total_t_Index_LfS     format=csv cDim=y'
$exit;




"LfP_2012".year2012
"AE_exports_2012".year2012
"LfS_2012".year2012
"AE_food_2012".year2012
"LfP_2030".year2030
"AE_exports_2030".year2030
"LfS_2030".year2030
"AE_food_2030".year2030
"LfP_2050".year2050
"AE_exports_2050".year2050
"LfS_2050".year2050
"AE_food_2050".year2050
