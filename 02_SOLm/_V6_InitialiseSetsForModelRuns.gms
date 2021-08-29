PUTCLOSE con,"_V6_InitialiseSetsForModelRuns";

*GENERAL DESCRIPTION
*This file contains the initialisation of the core model sets for the model runs
*it thus defines which regions to use, which set of activities and commodities, etc.

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Initialise sets for model runs:
- 2) Auxiliary sets
- 3) Additional sets and data for vegan scenarios (crop rotations, nutrients, etc.)
$offtext;


*MODEL CODE:


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Initialise sets for model runs:

alias(Activities_MR,SingleCropGrassAndLivestockActivities);
alias(Crops_MR,Crops);
alias(CoreGrassActivities_MR,CoreGrassActivities);
alias(CropsAndCoreGrassActivities_MR,CropsAndCoreGrassActivities);
alias(CropsAndTempGrassActivities_MR,CropsAndTempGrassActivities);
alias(CoreGrassActivitiesNoTEMPGrass_MR,CoreGrassActivitiesNoTEMPGrass);
alias(Regions_MR,Countries);
alias(Regions_MR_2,Regions_MR);
*alias(Commodities_MR,Commodities_SingleCommodities);
*some commoditiees for the trade calculations are aggregates - hence use all commodities
alias(Commodities_MR,Commodities);
alias(Commodities_MR_2,Commodities_MR);
alias(CommoditiesDAQ_TradeFromToWorld_MR,CommoditiesDAQ_TradeFromToWorld);

*XXX STILL TO BE DONE:
*ASSURE THAT the following feed group sets are already cleaned, ie. containing single commodities only!!! - or otherwise: CLEAN THEM HERE by defining them in detail and not via "alias"
alias(ConcentrateCommodities_MR,ConcentrateCommodities);
alias(ForageCommodities_MR,ForageCommodities);
alias(GrassCommodities_MR,GrassCommodities);

alias(Livestock_MR,Livestock);
alias(AnimalTypeInHerd_MR,AnimalTypeInHerd);


*adapt the following, if you have scenarios that do specific assumptions on imports/exports (as e.g. in UNISECO agroforestry scenarios, etc.)
*alias(Regions_WithExportScaling,Countries);
*SET Regions_NoExportScaling(Regions);
*Regions_NoExportScaling(Regions) = Countries(Regions) - Regions_WithExportScaling(Regions);

Set FAO_EuropeanUnion_PlusCH(Regions) "EU countries plus Switzerland"
/
#FAO_EuropeanUnion
Switzerland
/
;

alias(Regions_NoExportScaling,FAO_EuropeanUnion_PlusCH);
SET Regions_WithExportScaling(Regions);
Regions_WithExportScaling(Regions) = Countries(Regions) - Regions_NoExportScaling(Regions);


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Auxiliary sets
*This code also contains some auxiliary sets needed in SteeringFile2:
*the following is used for adequately assigning the values from the parameter ManureManagement to the scenarios (see code-file AssignInitialValuesToScenarios, section 1.10):
Set ManureManagement_NotContainingBo(ManureManagement)
/
"Quantity share in ManureMan system"
"Quantity share in ManureMan syst - N-based"
"MCF: CH4 conversion factor (%)"

"Manure man N volat (% of N in manure)"
"Manure man N leach (% of N in manure)"
"Manure man N2O dir (tN2O-N/tN)"
"Manure man N2O-N from N volat (tN/tN volat)"
"Manure man N2O-N from N leach (tN/tN leach)"
"Manure man P loss as % of P in manure (%)"

"Manure man NH3-N (% of N in manure)"

"Manure man N in N2O dir (tN)"
"Manure man N2O dir (tCO2e)"
"Manure man N volat (tN)"
"Manure man N2O volat (tN2O)"
"Manure man N2O volat (tCO2e)"
"Manure man N leach (tN)"
"Manure man N2O leach (tN2O)"
"Manure man N2O leach (tCO2e)"

"Housing NH3 from manure (tNH3-N/tN)"
"Housing N in NH3 from manure (tN)"

"Manure man NH3 (tNH3)"

"Manure man N2O total (tCO2e)"
"Manure man N total loss (tN)"
"Manure man+housing N total loss (tN)"
"Manure man P total loss (tP2O5)"

"Manure man N loss (tN)"
"Manure N for areas (tN)"
"Manure N for crop areas (tN)"
"Manure N for grass areas (tN)"
*"Manure man share P lost (tP2O5/tP2O5 in crop res)"
"Manure man P loss (tP2O5)"
"Manure P for areas (tP2O5)"
"Manure P for crop areas (tP2O5)"
"Manure P for grass areas (tP2O5)"

"Manure man CH4 (tCH4)"
"Manure man CH4 (tCO2e)"
/
;


Set ManureManagement_ForDerivingTotals(ManureManagement) "Contains the parameters related to manure management that are needed and possible to use for deriving totals - e.g. emissions, N losses, etc.; UNITS - per t manure TS DM"
/
*the following is not included, as where this set is used, total manure quantity is first anyway multiplied with it and then with the further parameters
*"Quantity share in ManureMan system"
*"Quantity share in ManureMan syst - N-based"

"Manure man N in N2O dir (tN)"
"Manure man N2O dir (tCO2e)"
"Manure man N volat (tN)"
"Manure man N2O volat (tN2O)"
"Manure man N2O volat (tCO2e)"
"Manure man N leach (tN)"
"Manure man N2O leach (tN2O)"
"Manure man N2O leach (tCO2e)"

"Housing N in NH3 from manure (tN)"

"Manure man NH3 (tNH3)"

"Manure man N2O total (tCO2e)"
"Manure man N total loss (tN)"
"Manure man+housing N total loss (tN)"
"Manure man P total loss (tP2O5)"

"Manure man N loss (tN)"
"Manure N for areas (tN)"
"Manure N for crop areas (tN)"
"Manure N for grass areas (tN)"
*"Manure man share P lost (tP2O5/tP2O5 in crop res)"
"Manure man P loss (tP2O5)"
"Manure P for areas (tP2O5)"
"Manure P for crop areas (tP2O5)"
"Manure P for grass areas (tP2O5)"

"Manure man CH4 (tCH4)"
"Manure man CH4 (tCO2e)"
/;


Set OtherCharCropsGrass_ForAggregation(OtherCharCropsGrass) "Characteristics of the crop or grass activity - USED FOR AGGREGATION - being undertaken that cannot be captured well by mass/nutrient flows; this can be the biodiversity loss or deforestation, but also monetary flows, etc."
/

*new elements for aggregations:
"Total GHG em. - crops, incl. defor/orgSoils (tCO2e)"
"Total GHG em. - crops, no defor/orgSoils (tCO2e)"
"N balance - plot level based (tN)"
"NH3 from areas (tNH3)"

"Area occupied physically (ha)"
/;


*already defined above, as it is needed already there
*Set FAO_EuropeanUnion_PlusCH(Regions) "EU countries plus Switzerland"
*/
*#FAO_EuropeanUnion
*Switzerland
*/
*;


*we also need a set that mathces livestock with adequate herd category types:
Set MatchLivestockAnimaltypeInHerd(Activities,AnimaltypeInHerd)
/
Buffaloes.AllAndAverageTypes
Sheep.AllAndAverageTypes
Goats.AllAndAverageTypes
Camels.AllAndAverageTypes
Horses.AllAndAverageTypes
Mules.AllAndAverageTypes
Asses.AllAndAverageTypes
Chickens.AllAndAverageTypes
Turkeys.AllAndAverageTypes
Ducks.AllAndAverageTypes
Game.AllAndAverageTypes
"Animals live nes".AllAndAverageTypes
"Camelids, other".AllAndAverageTypes
"Geese and guinea fowls".AllAndAverageTypes
"Pigeons, other birds".AllAndAverageTypes
"Rabbits and hares".AllAndAverageTypes
"Rodents, other".AllAndAverageTypes

Cattle.Producing_Dairy_Cattle
Cattle.Dsires

Cattle.DFemaleCalves1
Cattle.DFemaleCalves2
Cattle.DFemaleCalves3

Cattle.DMaleCalves1
Cattle.DMaleCalves2

Cattle.Bcows
Cattle.Bsires

Cattle.BFemaleCalves1
Cattle.BFemaleCalves2

Cattle.BMaleCalves1
Cattle.BMaleCalves2

Pigs.  Sows
Pigs.  Sucklers
Pigs.  Weaners
Pigs.  Fatteners
Pigs.  Boars
Pigs.  Rep_Sows
Pigs.  Rep_Boars
/;





****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Additional sets and data for vegan scenarios (crop rotations, nutrients, etc.)


************10.06.2021 kray: introduce new sets with subactivities here:*******************************************************************************

*Naming: "_V" stands for vegan

*Categories based on Barbieri et al. (2017)
*Cereals1, Cereals2, Pulses, Oil Crops, Root Crops, Vegetables

*activities for vegan scenarios: only FOOD activities (no fibres, etc. that cannot be eaten) - besides set-aside land: there some non-food crops are grown, see below.


Set Cereals1_V(Activities) *main cereals
/
Wheat
"Rice, paddy"
Maize

/
;

Set Cereals2_V(Activities) *Copy of "set Cereals(Activities)" without wheat maize and rice:
/Barley
Buckwheat
"Canary seed"
"Cereals, nes"
Fonio
Millet
*"Mixed grain"
Oats
Quinoa
Rye
Sorghum
*don't use Triticale since only used as feed
*Triticale
*Popcorn
*"Cereals, most"
*"Maize For Forage+Silage" is under forage crops
"Spelt"
/
;


*Set "Pulses(Activities)" already exists - use here adapted set including soy!
Set Pulses_V(Activities)
/
"Bambara beans"
"Beans, dry"
"Broad beans, horse beans, dry"
"Chick peas"
"Cow peas, dry"
Lentils
Lupins
"Peas, dry"
"Pigeon peas"
"Pulses, nes"
Soybeans
"Groundnuts, with shell"
/;

*Set "OilCrops(Activities)" already exists - use here adapted set without soy and without coconuts, olives which are permanent crops
Set OilCrops_V(Activities)
/
*not clear if annual or perennial: Castor beans - leave it here
"Castor oil seed"
Hempseed
Linseed
"Mustard seed"
"Oilseeds Nes"
"Poppy seed"
Rapeseed
"Safflower seed"
"Sesame seed"
"Sunflower seed"
Melonseed
*- move to permCrops:
*Coconuts
*"Karite Nuts (Sheanuts)"
*"Kola nuts"
*"Oil, palm fruit"
*Olives
*"Jojoba seed"
*"Tallowtree seed"
*"Kapok Fruit"
/;


*-root crops can be represented through Set "StarchyRoots(Activities)"
*-industrial: use Set FibresRubber(Activities) - neglect, we do not consider "industrial" crops
*- Set "Vegetables(Activities)" already exists

*"Set Fruits(Activities)" already exists, but use here own set without permCrops (which are most fruits)
Set Fruits_V(Activities)
/
"Strawberries"
"Berries nes"
"Blueberries"
"Cranberries"
"Currants"
"Gooseberries"
"Raspberries"
/;


Set SetAside_V(Activities) *are all relevant elements included?
*in vegan scenarios: non food producing areas to regenerate soils and fix nitrogen
/
"Temporary meadows and pastures"
*"temporary grasslands"
"Clover For Forage+Silage"
"Alfalfa For Forage+Silag"
"Leguminous Nes,For+Sil"
"Forage Products Nes"
'Vetches'
"Other grasses, for forage"
"Rye grass, for forage"
/;

*for non-vegan organic scenarios, the cereals 2 and  starchy roots also covers other feed and forage crops, thus define separately:
*for non vegan organic scenarios, include Triticale:
Set Cereals2_NonV(Activities) *Copy of "set Cereals(Activities)" without wheat maize and rice:
*added wrt vegan: Triticale, forage maize, sorghum for forage
/Barley
Buckwheat
"Canary seed"
"Cereals, nes"
Fonio
Millet
*"Mixed grain"
Oats
Quinoa
Rye
Sorghum
*don't use Triticale since only used as feed
Triticale
*Popcorn
*"Cereals, most"
"Maize For Forage+Silage"
"Spelt"
"Sorghum, for forage"
/
;

Set StarchyRoots_NonV(Activities)
*added wrt vegan: turnips, beets, swedes veget+roots for fodder
/Cassava
Potatoes
"Roots and Tubers, nes"
"Sweet potatoes"
"Taro (cocoyam)"
Yams
"Yautia (cocoyam)"

"Turnips For Fodder"
"Beets For Fodder"
"Swedes For Fodder"
"Vegetables+Roots,Fodder"
/;

*the following fodder/forage crops are not used in the vegan scenarioss- too unimportant and thus we avoid having another specific NonV legumes and oil seed set:
*"Cabbage, for forage"
*"Carrots, for forage"
*"Other oilseeds, for forage"


Set StarchyCrops_V(Activities);
StarchyCrops_V(Activities) = Cereals1_V(Activities) + Cereals2_V(Activities) + StarchyRoots(Activities);

Set StarchyCrops_NonV(Activities);
StarchyCrops_NonV(Activities) = Cereals1_V(Activities) + Cereals2_NonV(Activities) + StarchyRoots_NonV(Activities);


*Define Set: Permanent crops (subset of Crops(Activities) /
**to indicate elements of crop-set which are temporary crops /
*** to indicate industrial crops
$ontext;
OLD CODE - new see after this!!
Set PermCrops_V(Activities)
/
"Agave fibres nes"
"Almonds, with shell"
**"Anise, badian, fennel, coriander"
"Apples"
"Apricots"
"Areca nuts"
**"Artichokes"
**"Asparagus"
"Avocados"
**"Bambara beans"
"Bananas"
**"Barley"
**"Bastfibres, other"
**"Beans, dry"
**"Beans, green"
*"Berries nes"
*"Blueberries"
"Brazil nuts, with shell"
**"Broad beans, horse beans, dry"
**"Buckwheat"
**"Cabbages and other brassicas"
**"Canary seed"
"Carobs"
**"Carrots and turnips"
"Cashew nuts, with shell"
"Cashewapple"
**"Cassava"
**"Cassava leaves"
***"Castor oil seed"
**"Cauliflowers and broccoli"
*"Cereals (Rice Milled Eqv)"
**"Cereals, nes"
*"Cereals,Total"
"Cherries"
"Cherries, sour"
"Chestnut"
**"Chick peas"
**"Chicory roots"
**"Chillies and peppers, dry"
**"Chillies and peppers, green"
"Cinnamon (canella)"
*"Citrus Fruit,Total"
**"Cloves"
*"Coarse Grain, Total"
"Cocoa, beans"
"Coconuts"
"Coffee, green"
***"Coir"
***"Cotton lint"
***"Cottonseed"
**"Cow peas, dry"
*"Cranberries"
**"Cucumbers and gherkins"
*"Currants"
"Dates"
**"Eggplants (aubergines)"
**"Fibre crops nes"
*"Fibre Crops Primary"
"Figs"
**"Flax fibre and tow"
**"Fonio"
*"Fruit excl Melons,Total"
"Fruit, citrus nes"
"Fruit, fresh nes"
"Fruit, pome nes"
"Fruit, stone nes"
"Fruit, tropical fresh nes"
**"Garlic"
**"Ginger"
*"Gooseberries"
**"Grain, mixed"
"Grapefruit (inc. pomelos)"
"Grapes"
"Groundnuts, with shell"
"Gums, natural"
"Hazelnuts, with shell"
**"Hemp tow waste"
**"Hempseed"
"Hops"
"Jojoba seed"
**"Jute"
*"Jute & Jute-like Fibres"
"Kapok fibre"
"Kapok fruit"
"Kapokseed in shell"
"Karite nuts (sheanuts)"
"Kiwi fruit"
"Kola nuts"
**"Leeks, other alliaceous vegetables"
"Lemons and limes"
**"Lentils"
**"Lettuce and chicory"
**"Linseed"
**"Lupins"
**"Maize"
**"Maize, green"
"Mangoes, mangosteens, guavas"
***"Manila fibre (abaca)"
"Mat�"
*     in the data downloaded from FAOSTAT, it is written "Mat�"
**"Melons, other (inc.cantaloupes)"
**"Melonseed"
**"Millet"
**"Mushrooms and truffles"
**"Mustard seed"
"Nutmeg, mace and cardamoms"
"Nuts, nes"
**"Oats"
"Oil, palm"
"Oil, palm fruit"
*"Oilcakes Equivalent"
*"Oilcrops Primary"
**"Oilseeds nes"
**"Okra"
"Olives"
**"Onions, dry"
**"Onions, shallots, green"
"Oranges"
"Palm kernels"
"Papayas"
"Peaches and nectarines"
"Pears"
**"Peas, dry"
**"Peas, green"
"Pepper (piper spp.)"
**"Peppermint"
"Persimmons"
**"Pigeon peas"
"Pineapples"
"Pistachios"
"Plantains and others"
"Plums and sloes"
**"Poppy seed"
**"Potatoes"
**"Pulses, nes"
*"Pulses,Total"
**"Pumpkins, squash and gourds"
**"Pyrethrum, dried"
"Quinces"
**"Quinoa"
**"Ramie"
**"Rapeseed"
*"Raspberries"
**"Rice, paddy"
**"Roots and tubers, nes"
*"Roots and Tubers,Total"
***"Rubber, natural"
**"Rye"
**"Safflower seed"
"Seed cotton"
**"Sesame seed"
***"Sisal"
**"Sorghum"
**"Soybeans"
**"Spices, nes"
**"Spinach"
**"Strawberries"
**"String beans"
**"Sugar beet"
**"Sugar cane"
**"Sugar crops, nes"
**"Sunflower seed"
**"Sweet potatoes"
"Tallowtree seed"
"Tangerines, mandarins, clementines, satsumas"
**"Taro (cocoyam)"
"Tea"
**"Tobacco, unmanufactured"
**"Tomatoes"
*"Treenuts,Total"
**"Triticale"
"Tung nuts"
"Vanilla"
*"Vegetables Primary"
*"Vegetables&Melons, Total"
**"Vegetables, fresh nes"
**"Vegetables, leguminous nes"
**"Vetches"
"Walnuts, with shell"
**"Watermelons"
**"Wheat"
**"Yams"
**"Yautia (cocoyam)"
*till here it equals FAOSTAT_CropProductionItems

*include forage and fodder in crops:
**"Maize For Forage+Silage"
**"Clover For Forage+Silage"
**"Alfalfa For Forage+Silag"
**"Leguminous Nes,For+Sil"
**"Forage Products Nes"
**"Beets For Fodder"
*'Vetches'

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
**"Cabbage, for forage"
**"Carrots, for forage"
**"Other grasses, for forage"
**"Other oilseeds, for forage"
**"Rye grass, for forage"
**"Sorghum, for forage"

*we have the following two as forages as they are forage in Aggregate_ForageCrops
*"Alfalfa Meal And Pellets"
*"Beets For Fodder"
**"Swedes For Fodder"
**"Turnips For Fodder"
**"Vegetables+Roots,Fodder"

**Fallows

***Miscanthus

**"Pure legume sward"

**"Other annual crops"
"Other permanent crops"
**"Spelt"
/;

*Define Subset with temporary crops
SET TempCrops_V(Activities);
TempCrops_V(Activities) = Crops(Activities) - PermCrops_V(Activities);
$offtext;

*new code: take all crops used in vegan crop rotations and define the permanet crops as the others also included in Crops - thus all activities remain included in the modelling, also Cotton, etc.
SET CropsUsedInRotations_V(Activities);
CropsUsedInRotations_V(Activities) = Cereals1_V(Activities) + Cereals2_V(Activities) + Pulses_V(Activities) + OilCrops_V(Activities)
        + Fruits_V(Activities) + Vegetables(Activities) + StarchyRoots(Activities) + SetAside_V(Activities);
*and again, for non-vegan organic:
SET CropsUsedInRotations_NonV(Activities);
CropsUsedInRotations_NonV(Activities) = Cereals1_V(Activities) + Cereals2_NonV(Activities) + Pulses_V(Activities) + OilCrops_V(Activities)
        + Fruits_V(Activities) + Vegetables(Activities) + StarchyRoots_NonV(Activities) + SetAside_V(Activities);

Set PermCrops_V(Activities);
PermCrops_V(Activities) = Crops(Activities) - CropsUsedInRotations_NonV(Activities);
*this is the same for V and NonV, as NonV covers more non-permanent crops, thus subtracting those results in permanent crops


$onmulti
Set Activities
/
All_cereals1_V
All_cereals2_V
All_pulses_V
All_fruits_V
All_oilcrops_V
All_setAside_V
*"All FibresRubber" - neglect
"All Crops PLUS temp grass_V"
CropAndTempGrassActivities_TempCrops_V
*CropAndTempGrassActivitiesMinusTreenuts_V - not used anymore
All_starchyCrops_V
"All Crops used in crop rotations_V"
"All Crops used in crop rotations_NonV"
*for non-vegan organic scenarios we need other sets for cereals 2 (including Triticale and forage maize and sorghum for forage) and startchy roots (including other fodder and forage roots):
All_cereals2_NonV
All_StarchyRoots_NonV
*and in consequence also starchy crops:
All_starchyCrops_NonV

*also needed:
All_cereals1_NonV
All_pulses_NonV
All_fruits_NonV
All_oilcrops_NonV
All_setAside_NonV
"All Vegetables_NonV"
/;
$offmulti


Set CropRotationCategories_V
/
Cereals1_V
Cereals2_V
Pulses_V
Fruits_V
Oilcrops_V
SetAside_V
*"All Crops PLUS temp grass_V"
*CropAndTempGrassActivities_TempCrops_V
*CropAndTempGrassActivitiesMinusTreenuts_V - not used anymore
StarchyRoots
Vegetables
/
;


Set MatchCropsCategories_V(Activities, CropRotationCategories_V)
/
"Wheat"."Cereals1_V"
"Rice, paddy"."Cereals1_V"
"Maize"."Cereals1_V"
"Barley"."Cereals2_V"
"Buckwheat"."Cereals2_V"
"Canary seed"."Cereals2_V"
"Cereals, nes"."Cereals2_V"
"Fonio"."Cereals2_V"
"Millet"."Cereals2_V"
"Oats"."Cereals2_V"
"Quinoa"."Cereals2_V"
"Rye"."Cereals2_V"
"Sorghum"."Cereals2_V"
"Triticale"."Cereals2_V"
"Spelt"."Cereals2_V"
"Bambara beans"."Pulses_V"
"Beans, dry"."Pulses_V"
"Broad beans, horse beans, dry"."Pulses_V"
"Chick peas"."Pulses_V"
"Cow peas, dry"."Pulses_V"
"Lentils"."Pulses_V"
"Lupins"."Pulses_V"
"Peas, dry"."Pulses_V"
"Pigeon peas"."Pulses_V"
"Pulses, nes"."Pulses_V"
"Soybeans"."Pulses_V"
"Groundnuts, with shell"."OilCrops_V"
"Castor oil seed"."OilCrops_V"
"Hempseed"."OilCrops_V"
"Linseed"."OilCrops_V"
"Mustard seed"."OilCrops_V"
"Oilseeds Nes"."OilCrops_V"
"Poppy seed"."OilCrops_V"
"Rapeseed"."OilCrops_V"
"Safflower seed"."OilCrops_V"
"Sesame seed"."OilCrops_V"
"Sunflower seed"."OilCrops_V"
"Melonseed"."OilCrops_V"
"Strawberries"."Fruits_V"
"Temporary meadows and pastures"."SetAside_V"
"Clover For Forage+Silage"."SetAside_V"
"Alfalfa For Forage+Silag"."SetAside_V"
"Cassava"."StarchyRoots"
"Potatoes"."StarchyRoots"
"Roots and Tubers, nes"."StarchyRoots"
"Sweet potatoes"."StarchyRoots"
"Taro (cocoyam)"."StarchyRoots"
"Yams"."StarchyRoots"
"Yautia (cocoyam)"."StarchyRoots"
"Artichokes"."Vegetables"
"Asparagus"."Vegetables"
"Beans, green"."Vegetables"
"Cabbages and other brassicas"."Vegetables"
"Carrots and turnips"."Vegetables"
"Cauliflowers and broccoli"."Vegetables"
"Chicory roots"."Vegetables"
"Chillies and peppers, dry"."Vegetables"
"Chillies and peppers, green"."Vegetables"
"Cucumbers and gherkins"."Vegetables"
"Eggplants (aubergines)"."Vegetables"
"Garlic"."Vegetables"
"Leeks, other alliaceous vegetables"."Vegetables"
"Vegetables, leguminous nes"."Vegetables"
"Lettuce and chicory"."Vegetables"
"Maize, green"."Vegetables"
"Mushrooms and truffles"."Vegetables"
"Okra"."Vegetables"
"Onions, shallots, green"."Vegetables"
"Onions, dry"."Vegetables"
"Peas, green"."Vegetables"
"Pumpkins, squash and gourds"."Vegetables"
"Spinach"."Vegetables"
"String beans"."Vegetables"
"Tomatoes"."Vegetables"
"Vegetables, fresh nes"."Vegetables"
"Melons, other (inc.cantaloupes)"."Vegetables"
"Watermelons"."Vegetables"
*Further fruits
"Berries nes"."Fruits_V"
"Blueberries"."Fruits_V"
"Cranberries"."Fruits_V"
"Currants"."Fruits_V"
"Gooseberries"."Fruits_V"
"Raspberries"."Fruits_V"
/;


Set SubsetCommod_MatchWithAct_CommodEquivalentAct_Crops(Commodities)
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

"Other grasses, for forage"
"Rye grass, for forage"

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
****XXXXX kray: 
*"Mat�"
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

Set Commodities_EquivSetAsideAct(Commodities)
/
"Temporary meadows and pastures"
*"temporary grasslands"
"Clover For Forage+Silage"
"Alfalfa For Forage+Silag"
"Leguminous Nes,For+Sil"
"Forage Products Nes"
'Vetches'
"Other grasses, for forage"
"Rye grass, for forage"
/;

*add additional crop residue management practices:
$onmulti
Set CropResManSystem
/
"Cut and carry"
Silage
"CropResMan - not used in vegan scenarios"
/;
$offmulti

*initialise these new crop res man systems with default values from the others - to be improved
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,"Cut and carry",ProductionSystems,ProductionConditions,Scenarios)
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,"Left on croplands",ProductionSystems,ProductionConditions,Scenarios);
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,"Silage",ProductionSystems,ProductionConditions,Scenarios)
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,"Composting",ProductionSystems,ProductionConditions,Scenarios);
*and assign zero values to quantity shares as a default:
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system","Cut and carry",ProductionSystems,ProductionConditions,Scenarios) = 0;
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,"Quantity share in CropResMan system","Silage",ProductionSystems,ProductionConditions,Scenarios) = 0;

*move the code above to Steering 1 - to have these crop res man systems available for the whole model already in the default data.

Set CropResManagement_NotSystemShares_NoMainOutput(CropResManagement) "Same as Set CropResManagement but without 'Quantity share in CropResMan system' and main output related elements"
/
"Crop res man CH4 (tCH4)"
"Crop res man N2O (tN2O)"
"Crop res man N - before management (tN)"
"Crop res man P - before management (tP2O5)"
"Crop res man N loss (tN)"
"Crop res N for areas (tN)"
"Crop res N for areas (tN/t DM res)"
"Crop res man share P lost (tP2O5/tP2O5 in crop res)"
"Crop res man P loss (tP2O5)"
"Crop res P for areas (tP2O5)"
/;
Set CropResManagement_NotSystemShares_OnlyMainOutput(CropResManagement) "Same as Set CropResManagement but only main output related elements"
/
"Main output N as fert. for areas (tN)"
"Main output N as fert. loss (tN)"
"Main output N as fert. N2O (tN2O)"
/;


*add additional nutrients
*include nutrients in content-set
$onmulti
Set Contents
/

*16:00
*16:1 undifferentiated
*17:00
*17:01
*18:00
*18:1 undifferentiated
*18:2 undifferentiated
*18:3 undifferentiated
*Alanine
*Arginine
*Ash
*Aspartic acid
*Beta-sitosterol
'Calcium, Ca (mg)'
'Vitamin C, total ascorbic acid (mg)'
*Campesterol
'Carbohydrate, by difference (g)'
*'Carotene, beta'
*'Choline, total'
*'Copper, Cu'
'Cystine (g)'
*Energy
*Energy
*'Fatty acids, total monounsaturated'
'Fatty acids, total polyunsaturated (g)'
'Fatty acids, total saturated (g)'
'Fatty acids, total trans (g)'
'Fiber, total dietary (g)'
*'Folate, DFE'
*'Folate, food'
*'Folate, total'
*Glucose (dextrose)
*Glutamic acid
'Glycine (g)'
'Histidine (g)'
'Iron, Fe (mg)'
'Isoleucine (g)'
'Leucine (g)'
*Lutein + zeaxanthin
'Lysine (g)'
*'Magnesium, Mg'
*Maltose
*'Manganese, Mn'
'Methionine (g)'
'Niacin (mg)'
*Pantothenic acid
'Phenylalanine (g)'
*'Phosphorus, P'
*Phytosterols
'Potassium, K (mg)'
*Proline
*Protein
'Riboflavin (mg)'
'Selenium, Se (ug)'
*Serine
'Sodium, Na (mg)'
*Starch
*Stigmasterol
*Sucrose
'Sugars, total (g)'
*Thiamin'
'Threonine (g)'
*'Tocopherol, beta'
*'Tocopherol, delta'
*'Tocopherol, gamma'
"Total lipid (fat) (g)"
'Tryptophan (g)'
'Tyrosine (g)'
'Valine (g)'
'Vitamin A, IU (IU)'
*"Vitamin B-6"
*Vitamin E (alpha-tocopherol)
*Water
'Zinc, Zn (mg)'

'18:3 n-3 c,c,c (ALA) (g)'
'18:2 n-6 c,c (g)'
*'18:3 n-6 c,c,c (g)'

*amino acid score (aggregated)
'AAS (dmnl)'

'Vitamin D (D2 + D3) (ug)'
'Vitamin B-12 (ug)'
/;

$offmulti

*define the new nutrients as subset
Set New_nutrients_V(Contents)
/
*16:00
*16:1 undifferentiated
*17:00
*17:01
*18:00
*18:1 undifferentiated
*18:2 undifferentiated
*18:3 undifferentiated
*Alanine
*Arginine
*Ash
*Aspartic acid
*Beta-sitosterol
'Vitamin C, total ascorbic acid (mg)'
'Calcium, Ca (mg)'
*Campesterol
'Carbohydrate, by difference (g)'
*'Carotene, beta'
*'Choline, total'
*'Copper, Cu'
'Cystine (g)'
*Energy
*Energy
*'Fatty acids, total monounsaturated'
'Fatty acids, total polyunsaturated (g)'
'Fatty acids, total saturated (g)'
'Fatty acids, total trans (g)'
'Fiber, total dietary (g)'
*'Folate, DFE'
*'Folate, food'
*'Folate, total'
*Glucose (dextrose)
*Glutamic acid
'Glycine (g)'
'Histidine (g)'
'Iron, Fe (mg)'
'Isoleucine (g)'
'Leucine (g)'
*Lutein + zeaxanthin
'Lysine (g)'
*'Magnesium, Mg'
*Maltose
*'Manganese, Mn'
'Methionine (g)'
'Niacin (mg)'
*Pantothenic acid
'Phenylalanine (g)'
*'Phosphorus, P'
*Phytosterols
'Potassium, K (mg)'
*Proline
*Protein
'Riboflavin (mg)'
'Selenium, Se (ug)'
*Serine
'Sodium, Na (mg)'
*Starch
*Stigmasterol
*Sucrose
'Sugars, total (g)'
*Thiamin'
'Threonine (g)'
*'Tocopherol, beta'
*'Tocopherol, delta'
*'Tocopherol, gamma'
"Total lipid (fat) (g)"
'Tryptophan (g)'
'Tyrosine (g)'
'Valine (g)'
'Vitamin A, IU (IU)'
*"Vitamin B-6"
*Vitamin E (alpha-tocopherol)
*Water
'Zinc, Zn (mg)'

'18:3 n-3 c,c,c (ALA) (g)'
'18:2 n-6 c,c (g)'

*amino acid score (aggregated)
'AAS (dmnl)'

'Vitamin D (D2 + D3) (ug)'
'Vitamin B-12 (ug)'

/;


*some parameter needed for organic scenarios
Parameter OrganicAreaShare(Regions,Activities,ProductionConditions,Scenarios);

Parameter FertilizerUseShare_HumanFaeces(Regions,ProductionSystems,ProductionConditions,Scenarios);

Parameter FertilizerUseShare_ValueChainWaste(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios);

Parameter FertilizerUseShare_EndUseFoodWaste(Regions,Commodities,ProductionSystems,ProductionConditions,Scenarios);

Parameter PermanentGrassFertilizerUseShare(Regions,ProductionSystems,ProductionConditions,Scenarios);
*initialisation:
PermanentGrassFertilizerUseShare(Regions,ProductionSystems,ProductionConditions,Scenarios) = 0;


Parameter PermGrass_CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions,Scenarios);


*some parameter needed for vegan scenarios
Parameter VeganDietShare(Regions,Scenarios);

Parameter CropUSeOfNewlyFreeAreas(Regions,ProductionSystems,Scenarios);

*some new parameters needed for the vegan calculations with Benke

Parameter Par_NAVail_Benke(CropResManSystem);

*This Parameter defines the N-loss rate after application
Parameter Par_NlossApplication_Benke_V(CropResManSystem);

*some new parameters are needed for the crop rotation data used in the vegan scenarios:
Parameter CropRotationShare(Regions,Activities,ProductionSystems,Scenarios);





*some sets needed for agroforestry scenarios:
Set TreePartActivities_Agroforestry_EUROPE(Activities)
/
"Fruit, citrus nes"
"Lemons and limes"
Oranges
"Tangerines, mandarins, clementines, satsumas"
"Fruit, pome nes"
Pears
Quinces
Apricots
Cherries
"Peaches and nectarines"
"Plums and sloes"
"Cherries, Sour"
"Fruit, stone nes"
Apples
Avocados
Carobs
Dates
Figs
"Grapefruit (inc. pomelos)"
"Almonds, with shell"
Chestnut
"Hazelnuts, with shell"
"Nuts, nes"
Pistachios
"Walnuts, with shell"
Olives
"agrof. trees: feed"
"non-food agrof. trees"
*"All agrof. trees"
/;

Set CropPartActivities_Agroforestry_EUROPE(Activities);
CropPartActivities_Agroforestry_EUROPE(Activities) = CropsAndCoreGrassActivities(Activities) - TreePartActivities_Agroforestry_EUROPE(Activities);
Set CropPartActivities_Agroforestry_EUROPE_NoGrass(Activities);
CropPartActivities_Agroforestry_EUROPE_NoGrass(Activities) = Crops(Activities) - TreePartActivities_Agroforestry_EUROPE(Activities);

Set EU_Continental_PlusCH(Regions)
/
Bulgaria
Hungary
Czechia
Poland
Romania
Slovakia
Estonia
Finland
Latvia
Lithuania
Sweden
Austria
Germany
Switzerland
/;
Set EU_Mediterranean(Regions)
/
Cyprus
Greece
Croatia
Italy
Malta
Portugal
Spain
Slovenia
/;
Set EU_Atlantic(Regions)
/
Denmark
France
"United Kingdom"
Netherlands
Belgium
Luxembourg
Ireland
/;

Variable VCommod_Contents_Prod_MR(*,*,*,*,*,*);
Variable VCommod_Food_Contents_Prod_MR(*,*,*,*,*,*);




$onmulti
Set Commodities
/
"All perm Crop Commodities"
/;

$offmulti

Set PermCropCommodities(Commodities)
/
"Abaca"
"Apples and products"
"Bananas"
"Citrus, Other"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Coffee and products"
"Copra Cake"
"Dates"
"Fruits - Excluding Wine"
"Fruits, Other"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Groundnut Cake"
"Groundnut Oil"
"Groundnuts (in Shell Eq)"
"Groundnuts (Shelled Eq)"
"Lemons, Limes and products"
"Molasses (sugar cane)"
*"Molasses (sugar beet)"
"Nuts and products"
"Olive Oil"
"Olives (including preserved)"
"Oranges, Mandarines"
"Palm kernels"
"Palm Oil"
"Palmkernel Cake"
"Palmkernel Oil"
"Pepper"
"Pimento"
"Pineapples and products"
"Plantains"

"Spices"
"Spices, Other"
*"Starchy Roots"
"Tea (including mate)"
"Treenuts"
"Wine"

"Almonds shelled"
*"Animal fats"
"Apples"
"Apricots"
"Apricots, dry"
"Avocados"
"Bananas and plantains"
"Brazil nuts, shelled"

"Cake, groundnuts"

"Cake, kapok"

"Cake, palm kernel"

"Cashew nuts, shelled"
"Cashew nuts, with shell"
"Cashewapple"

"Cherries"
"Cherries, sour"
"Chestnut"

"Chocolate products nes"
"Cider etc"

"Cinnamon (canella)"
*"Cloves"
"Cocoa, beans"
"Cocoa, butter"
"Cocoa, paste"
"Cocoa, powder & cake"
"Coconuts"
"Coconuts, desiccated"
"Cocoons, unreelable & waste"
"Coffee Green+Roast"
"Coffee, extracts"
"Coffee, green"
"Coffee, husks and skins"
"Coffee, roasted"
"Coffee, substitutes containing coffee"
"Coffee+Tea+Cocoa+Sp"
"Copra"

"Feed, pulp of fruit"
"Figs"
"Figs dried"

"Fruit, cooked, homogenized preparations"
"Fruit, dried nes"
"Fruit, fresh nes"
"Fruit, prepared nes"
"Fruit, tropical fresh nes"

"Grapefruit (inc. pomelos)"
"Grapes"

"Groundnuts Total Shelled"
"Groundnuts, shelled"

"Hazelnuts, shelled"
*"Hops"

"Juice, citrus, concentrated"
"Juice, citrus, single strength"
"Juice, fruit nes"
"Juice, grape"
"Juice, grapefruit"
"Juice, grapefruit, concentrated"
"Juice, lemon, concentrated"
"Juice, orange, concentrated"
"Juice, orange, single strength"
"Juice, pineapple"
"Juice, pineapple, concentrated"
"Juice, plum, concentrated"
"Juice, plum, single strength"

"Kapok fibre"
"Kapokseed in shell"
"Kapokseed shelled"
"Kiwi fruit"
"Kola nuts"

"Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"
"Maple sugar and syrups"

"Nutmeg, mace and cardamoms"
"Nuts, nes"
"Nuts, prepared (exc. groundnuts)"
*"Oats"

"Oil, citronella"
"Oil, coconut (copra)"

"Oil, groundnut"
"Oil, kapok"

"Oil, olive residues"
"Oil, olive, virgin"
"Oil, palm"
"Oil, palm kernel"

"Olive Oil,Total"
"Olives"
"Olives preserved"
*"Onions"

"Oranges"
"Oranges+Tang+Clem"
"Oth Citrus Frt"

"Papayas"
"Peaches and nectarines"
"Peanut butter"
"Pears"
"Pepper (piper spp.)"
"Persimmons"

"Pineapples"
"Pineapples canned"
"Pistachios"
"Plantains and others"
"Plums and sloes"
"Plums dried (prunes)"

"Quinces"
"Raisins"

"Tangerines, mandarins, clementines, satsumas"
"Tea"
"Tea, mate extracts"

"Walnuts, shelled"
"Walnuts, with shell"

"Wine+Vermouth+Sim."

"Almonds"

"Applejuice Single Streng"
"Applejuice Concentrated"

"Areca Nuts (Betel)"

"Cake, Palm Kernels"

"Castor Beans"

"Citrus Fruit Nes"

"Citrus, all"

"Cocoa Husks+Shell"

"Fruit Tropical Dried Nes"
"Fruit,Nut,Peel,Sugar Prs"
"Fruits, all"
"Fruits, most"

"Groundnuts In Shell"
"Prepared Groundnuts"

"Hazelnuts (Filberts)"

"Kapok Fruit"

"Karite Nuts (Sheanuts)"

"Lemonjuice Single-Streng"

"Mango Juice"
"Mango Pulp"

"Marc Of Grapes"

"Nuts, all"
"Nuts, all, shelled"

"Oil Palm Fruit"

"Olive Residues"

"Plums, Dried (Prunes)"
"Pome Fruit Nes, Fresh"

"Stone Fruit Nes, Fresh"

"Tallowtree Seeds"
"Tangerine Juice"

"Tung Nuts"

"Almonds, with shell"
"Areca nuts"
"Brazil nuts, with shell"
"Castor oil seed"

"Fruit, citrus nes"
"Fruit, pome nes"
"Fruit, stone nes"
"Groundnuts, with shell"

"Hazelnuts, with shell"

"Jojoba seed"

"Oil, palm fruit"

"Tallowtree seed"
"Taro (cocoyam)"


"Groundnut shells"
"Cocoa husks"
"Karite nut cake"
"Almond shells"
"Apricot kernel"
"Chestnut shells"
"Coconut shells"
"Cashew nut shells"
"Brazil nut shells"

"Grapefruit pulp"
"Lemon pulp"
"Orange pulp"
"Pineapple pulp"
"Plum pulp"
"Hazelnut shells"
"Castor bean cake"
*"Palm kernels"
"Walnut shells"
"Apple pulp"
"Tangerine pulp"
"Tung nut cake"

"Cocoa paste"

"Pressed olive residues"
*
"Palm kernel oil"

"Oil palm fruit pulp"

*for stone fruits, add the kernel shells (e.g. used for bioenergy potential calculations)
"Apricot kernel shells"
"Cherries - kernels"
"Cherries, sour - kernels"
"Peaches and nectarines - kernels"
"Plums and sloes - kernels"
*and also:
"Dates - kernels"
"Pistachio shells"

"Citrus pulp"
"Fruit pulp"


/;

$onmulti
Set CommodOtherChar
/
"Util all uses (share)"
/;
$offmulti
