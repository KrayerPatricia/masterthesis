*XXXXXXXXXXXXXXXXXXXX Calculate AHEI-2010-score XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
*04.08.2021
*based on template of Anita Frehner



Set descriptors
/
'Energykcal'
"Percentage"
PUFA
Score
Amount
Portion
/;


* initialise the AHEI parameters for all subgroups, 11 in total
PARAMETER veg_ahei_pufa(Regions, Scenarios,descriptors, ProductionSystems);
PARAMETER veg_ahei_sodium(Regions, Scenarios,descriptors, ProductionSystems);
PARAMETER veg_ahei_grains(Regions, Scenarios,descriptors, ProductionSystems);
PARAMETER veg_ahei_nutslegveg(Regions, Scenarios,descriptors, ProductionSystems);
PARAMETER veg_ahei_vegetables(Regions, Scenarios,descriptors, ProductionSystems);
PARAMETER veg_ahei_fruits(Regions, Scenarios,descriptors, ProductionSystems);
PARAMETER veg_ahei_sugarbeverages(Regions, Scenarios,descriptors, ProductionSystems);
PARAMETER veg_ahei_meat(Regions, Scenarios,descriptors, ProductionSystems);
PARAMETER veg_ahei_fish(Regions, Scenarios,descriptors, ProductionSystems);
PARAMETER veg_ahei_transfat(Regions, Scenarios,descriptors, ProductionSystems);
PARAMETER veg_ahei_alcbev(Regions, Scenarios,descriptors, ProductionSystems);

SET grains(Commodities) /
"Barley"
"Buckwheat"
"Canary seed"
"Cereals, nes"
"Fonio"
"Millet"
"Oats"
"Quinoa"
"Rice, paddy"
"Rye"
"Sorghum"
"Triticale"
"Wheat"
"Maize and products"
"Maize Germ Oil"
"Millet and products"
"Barley and products"
"Brans"
"Cereals - Excluding Beer"
"Cereals, Other"
"Rice (Paddy Equivalent)"
"Ricebran Oil"
"Rye and products"
"Sorghum and products"
"Wheat and products"



/;


SET NutsLegumesVegetableProtein(Commodities) /
"Almonds, with shell"
"Areca nuts"
"Bambara beans"
"Beans, dry"
"Beans, green"
"Brazil nuts, with shell"
"Broad beans, horse beans, dry"
"Cashew nuts, with shell"
"Chick peas"
"Cow peas, dry"
"Hazelnuts, with shell"
"Karite nuts (sheanuts)"
"Kola nuts"
"Lentils"
"Lupins"
"Nuts, nes"
"Peas, dry"
"Peas, green"
"Pigeon peas"
"Pulses, nes"
"Pistachios"
"String beans"
"Vetches"
"Walnuts, with shell"
"Nuts and products"
"Pulses"
"Beans"
"Peas"
"Pulses, Other and products"
"Treenuts"


/;

*not contained in resulting set!!
SET leafyveg(Commodities) /
"Lettuce and chicory"
"Cabbages and other brassicas"
"Spinach"

/;

SET otherveg(Commodities) /
"Artichokes"
"Asparagus"
"Avocados"
"Carrots and turnips"
"Carobs"
"Cassava"
"Cauliflowers and broccoli"
"Chestnut"
"Chicory roots"
"Chillies and peppers, green"
"Cinnamon (canella)"
"Cloves"
"Cucumbers and gherkins"
"Eggplants (aubergines)"
"Garlic"
"Ginger"
"Leeks, other alliaceous vegetables"
"Maize"
"Maize, green"
"Melons, other (inc.cantaloupes)"
"Mushrooms and truffles"
"Nutmeg, mace and cardamoms"
"Okra"
"Onions, dry"
"Onions, shallots, green"
"Pepper (piper spp.)"
"Potatoes"
"Pumpkins, squash and gourds"
"Roots and tubers, nes"
"Sweet potatoes"
"Taro (cocoyam)"
"Tomatoes"
"Vegetables, fresh nes"
"Watermelons"
"Yams"
"Yautia (cocoyam)"
"Plantains"
"Onions"
"Cassava and products"
"Pepper"
"Pimento"
"Potatoes and products"
"Roots & Tuber Dry Equiv"
"Roots, Other"
"Starchy Roots"
"Tomatoes and products"
"Vegetables"
"Vegetables, Other"


/;

SET fruitsDO(Commodities) /
"Apples"
"Apricots"
"Bananas"
"Berries nes"
"Blueberries"
"Cherries"
"Cherries, sour"
"Cranberries"
"Currants"
"Figs"
"Fruit, fresh nes"
"Fruit, tropical fresh nes"
"Gooseberries"
"Grapefruit (inc. pomelos)"
"Kiwi fruit"
"Lemons and limes"
"Mangoes, mangosteens, guavas"
"Oranges"
"Papayas"
"Peaches and nectarines"
"Pears"
"Persimmons"
"Pineapples"
"Plantains and others"
"Plums and sloes"
"Quinces"
"Raspberries"
"Strawberries"
"Tangerines, mandarins, clementines, satsumas"
"Fruits - Excluding Wine"
"Citrus, Other"
"Fruits, Other"
"Grapefruit and products"
"Grapes and products (excl wine)"
"Lemons, Limes and products"
"Apples and products"
"Oranges, Mandarines"
"Pineapples and products"


/;

*this is not contained in resulting VCOmmod_Food -> find 
SET sugarbeverages(Commodities) /

'Sugar (Raw Equivalent)'
'Sugar non-centrifugal'
'Juice, citrus, concentrated'
/;


SET processedmeat(Commodities) /
"Animal fats"
"Fats, Animals, Raw"
"Pigmeat"
"Poultry Meat"
"Offals"
"Offals, Edible"
"Bovine Meat"

/;

*Share pigmeat based on BLW (2019): Der Schweizer Schweinemarkt als Infografik / poultry meat: educated guess.. / bovine meat: take same share as for pigmeat as proxy...
Parameter ShareProcessed(processedmeat);
ShareProcessed("Animal fats") = 1;
ShareProcessed("Fats, Animals, Raw") = 1;
ShareProcessed("Pigmeat") = 0.45;
ShareProcessed("Poultry Meat") = 0.1;
ShareProcessed("Offals, Edible") = 1;
ShareProcessed("Bovine Meat") = 0.45;


SET redmeat(Commodities) /
"Meat, ass"
"Meat, cattle"
"Meat, goat"
"Meat, horse"
"Meat, other camelids"
"Meat, sheep"
"Mutton & Goat Meat"
"Meat, Camels"
"Meat, Mules"
"Meat, buffaloes"

/;

SET fish(Commodities) /
"Cephalopods"
"Crustaceans"
"Demersal Fish"
"Freshwater Fish"
"Pelagic Fish"
"Fish, Seafood"
"Marine Fish, Other"
"Molluscs, Other"


/;


SET oilcropsDO(Commodities) /
"Cocoa, beans"
"Coconuts"
"Groundnuts, with shell"
"Linseed"
"Melonseed"
"Mustard seed"
"Oilseeds nes"
"Olives"
"Palm kernels"
"Poppy seed"
"Rapeseed"
"Safflower seed"
"Sesame seed"
"Soybeans"
"Sunflower seed"
"Oilcrops Oil, Other"
"Cocoa Beans and products"
"Coconut Oil"
"Coconuts - Incl Copra"
"Cottonseed Oil"
"Groundnut Oil"
"Groundnuts (in Shell Eq)"
"Oilcrops"
"Oilcrops, Other"
"Olive Oil"
"Olives (including preserved)"
"Palm Oil"
"Palmkernel Oil"
"Rape and Mustard Oil"
"Rape and Mustardseed"
"Sesameseed Oil"
"Soyabeans"
"Vegetable Oils"
"Sunflowerseed Oil"

/;

SET beer(Commodities) /
"Beer"
"Beverages, Fermented"

/;

SET wine(Commodities) /
'Wine'
/;

SET liquors(Commodities) /
'Beverages, Alcoholic'
"Alcoholic Beverages"

/;



*** NUTRIENT-BASED SCORE CALCULATION ***


*Caldulate total nutrient amount per nutrient, region, commodity, Scenarios
*VCommod_Food_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios)$(NOT VCommod_Food_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions,Scenarios))
*            = VCommod_Food_Contents_MR.l(Regions,Commodities,Contents,"Organic",ProductionConditions,Scenarios)
*                + VCommod_Food_Contents_MR.l(Regions,Commodities,Contents,"Convent",ProductionConditions,Scenarios);


*Portion Sizes (check why needed???)
Parameter PortionSize(Commodities) Portion Size in g;
PortionSize(grains) = 15;
PortionSize(NutsLegumesVegetableProtein) = 28.35;
PortionSize(leafyveg) = 236.59;
PortionSize(otherveg) = 118.3;
PortionSize(fruitsDO) = 236.59;
PortionSize(sugarbeverages) = 28.35*8;
PortionSize(processedmeat) = 28.35;
PortionSize(redmeat) = 4*28.35;
PortionSize(fish) = 28.35;
PortionSize(oilcropsDO) = 28.35;
PortionSize(beer) = 12*28.35;
PortionSize(wine) = 4*28.35;
PortionSize(liquors) = 1.5*28.35;


* calculate the nutrients per amount consumed (originally per 100g)
* adaptation: nutrient per g - correct later with defined PortionSize
PARAMETER veg_nutrients_peramount(Regions, Scenarios,Commodities,Contents, ProductionSystems);

veg_nutrients_peramount(Regions, Scenarios,Commodities,Contents, ProductionSystems)$(PortionSize(Commodities))
            = VCommod_Food_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,"AllProdCond",Scenarios)
                / 1000/1000*PortionSize(Commodities) ;
                
*new: calculate average amount of commodity and content per day 
PARAMETER veg_nutrients_perday_calculated(Regions, Scenarios,Commodities,Contents, ProductionSystems);

veg_nutrients_perday_calculated(Regions, Scenarios,Commodities,Contents, ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
            = VCommod_Food_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,"AllProdCond",Scenarios)
                / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                / 365 
                ;
                


                
* calculate the sum of nutrient intake per person per nutrient (needed for e.g. PUFA calculation below)
* adaptation: calculate total nutrient amount per g
PARAMETER veg_sum(Regions, Scenarios,Contents, ProductionSystems) total nutrient intake per average consumption;

veg_sum(Regions, Scenarios,Contents, ProductionSystems) = SUM(Commodities, veg_nutrients_perday_calculated(Regions, Scenarios,Commodities,Contents, ProductionSystems));



*********************************************************************************

*** 1. PUFA ***
* step 1: from g to % of energy
* step 2: calculate AHEI score

PARAMETER veg_pufa(Regions, Scenarios,descriptors, ProductionSystems) for the calculation of pufa;

veg_pufa(Regions, Scenarios,"Percentage", ProductionSystems)$(veg_sum(Regions, Scenarios,'Calories (kcal)',ProductionSystems) ne 0)
         = (
         veg_sum(Regions,  Scenarios,"Fatty acids, total polyunsaturated (g)", ProductionSystems)
         *9)
         / veg_sum(Regions, Scenarios,"Calories (kcal)",ProductionSystems)
         * 100;

veg_ahei_pufa(Regions, Scenarios,"Score", ProductionSystems)$(veg_pufa(Regions, Scenarios,"Percentage", ProductionSystems) ge 10)
         = 10;

veg_ahei_pufa(Regions, Scenarios,"Score", ProductionSystems)$(veg_pufa(Regions, Scenarios,"Percentage", ProductionSystems)
         $(veg_pufa(Regions, Scenarios,"Percentage", ProductionSystems) le 2))
         = 0.001;

veg_ahei_pufa(Regions, Scenarios,"Score", ProductionSystems)$(veg_pufa(Regions, Scenarios,"Percentage", ProductionSystems)
         $(veg_pufa(Regions, Scenarios,"Percentage", ProductionSystems) lt 10
         AND (veg_pufa(Regions, Scenarios,"Percentage", ProductionSystems)
         AND (veg_pufa(Regions, Scenarios,"Percentage", ProductionSystems) gt 2))))
         = ((veg_pufa(Regions, Scenarios,"Percentage", ProductionSystems) - 2)/(10-2))*10;


*** 2. SODIUM ***
* step 1: calculate AHEI score

veg_ahei_sodium(Regions, Scenarios,"Score", ProductionSystems)$(veg_sum(Regions, Scenarios,'Sodium, Na (mg)', ProductionSystems)
         $(veg_sum(Regions, Scenarios,'Sodium, Na (mg)', ProductionSystems) ge 4304))
         = 0.001;

veg_ahei_sodium(Regions, Scenarios,"Score", ProductionSystems)$(veg_sum(Regions, Scenarios,'Sodium, Na (mg)', ProductionSystems)
         $(veg_sum(Regions, Scenarios,'Sodium, Na (mg)', ProductionSystems) le 1362))
         = 10;

veg_ahei_sodium(Regions, Scenarios,"Score", ProductionSystems)$(veg_sum(Regions, Scenarios,'Sodium, Na (mg)', ProductionSystems)
         $(veg_sum(Regions, Scenarios,'Sodium, Na (mg)', ProductionSystems) lt 4304
         AND (veg_sum(Regions, Scenarios,'Sodium, Na (mg)', ProductionSystems)$(veg_sum(Regions, Scenarios,'Sodium, Na (mg)', ProductionSystems) gt 1362))))
         = (10-((veg_sum(Regions, Scenarios,'Sodium, Na (mg)', ProductionSystems)-1362)/(4304-1362))*10);

*this makes no sense..
*veg_ahei_sodium(Regions, Scenarios,"Score", ProductionSystems)
*         $(NOT veg_ahei_sodium(Regions, Scenarios,"Score", ProductionSystems)
*         AND SUM(Commodities, PortionSize(Commodities)))
*         = 10;
         




*** PRODUCT-BASED SCORE CALCULATION ***

*** 3. WHOLE GRAINS ***
* step 1: select all products of category getreide, getreideproducte, k�rner
* step 2: ratio carbohydrates available to dietary fibres berechnen
* step 3: assign as whole grains if ratiocarbfibres is le 10 (to calculate the distinction between whole and refined grains, value from Giulia) and if not refined grain without dietary fibre allocated
* step 4: calculate AHEI score

*new:
* 1 - calculate amount of whole grains per day
* 2 - calculate AHEI score

PARAMETER veg_grains(Regions, Scenarios,Commodities,descriptors, ProductionSystems)              includes all grains (wheat millet maize ...);
PARAMETER veg_wholegrains(Regions, Scenarios,descriptors, ProductionSystems)         includes whole grains where assignement happens if ratio of carbohydrates to dietary fibres is le 10 - share calculated in menuch_proportions;
PARAMETER sum_wholegrains(Regions, Scenarios,descriptors, ProductionSystems)                        sum over all wholegrains;

**
*Amount per day and person of whole grains in g
veg_wholegrains(Regions, Scenarios,"Amount", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
            = Sum(grains$((Commod_Contents_MR(Regions,grains,"Fiber, total dietary (g)",ProductionSystems,"AllProdCond",Scenarios))
            AND (Commod_Contents_MR(Regions,grains,"Carbohydrate, by difference (g)",ProductionSystems,"AllProdCond",Scenarios)
                    / Commod_Contents_MR(Regions,grains,"Fiber, total dietary (g)",ProductionSystems,"AllProdCond",Scenarios)*100 lt 10)
                    ),
                        VCommod_Food_MR.l(Regions,grains,ProductionSystems,"AllProdCond",Scenarios))*1000*1000
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                        / 365;
            
*Amount per day (Total in g)
*sum_wholegrains(Regions, Scenarios,"Amount", ProductionSystems) = SUM(grains, veg_wholegrains(Regions, Scenarios,"Amount", ProductionSystems));



*for the average

veg_ahei_grains(Regions, Scenarios,"Score", ProductionSystems)
         $(veg_wholegrains(Regions,Scenarios,"Amount", ProductionSystems)
         AND (veg_wholegrains(Regions,Scenarios,"Amount", ProductionSystems) ge 82.5))
         = 10;

veg_ahei_grains(Regions, Scenarios,"Score", ProductionSystems)
         $(veg_wholegrains(Regions,Scenarios,"Amount", ProductionSystems)
         AND (veg_wholegrains(Regions,Scenarios,"Amount", ProductionSystems) lt 82.5))
         = veg_wholegrains(Regions,Scenarios,"Amount", ProductionSystems) / 82.5 * 10;




*** 4. NUTS AND LEGUMES ***

* step 1: convert g/day to portions/day
* step 2: calculate AHEI score


PARAMETER veg_nutslegveg(Regions, Scenarios,Commodities,descriptors, ProductionSystems) contains the portion of nutslegveg;
PARAMETER sum_nutslegveg(Regions, Scenarios,descriptors, ProductionSystems) sum over all nutslegveg;

veg_nutslegveg(Regions, Scenarios,NutsLegumesVegetableProtein,"Portion", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =   VCommod_Food_MR.l(Regions,NutsLegumesVegetableProtein ,ProductionSystems,"AllProdCond",Scenarios)
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)*1000*1000
                        / 365
                        / 118.295;



sum_nutslegveg(Regions, Scenarios,"Portion", ProductionSystems)
         = SUM((NutsLegumesVegetableProtein),
         veg_nutslegveg(Regions, Scenarios,NutsLegumesVegetableProtein,"Portion", ProductionSystems));

veg_ahei_nutslegveg(Regions, Scenarios,"Score", ProductionSystems)
         $(sum_nutslegveg(Regions, Scenarios,"Portion", ProductionSystems)
         AND (sum_nutslegveg(Regions, Scenarios,"Portion", ProductionSystems) ge 1))
         = 10;

veg_ahei_nutslegveg(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_nutslegveg(Regions,Scenarios,"Portion", ProductionSystems)
         AND (sum_nutslegveg(Regions,Scenarios,"Portion", ProductionSystems) lt 1))
         = sum_nutslegveg(Regions,Scenarios,"Portion", ProductionSystems) * 10;





*** 5. VEGETABLES ***
* step 1: convert g to portions for (1) leavy vegetables and (2) other vegetables
* step 2: calculate AHEI score


PARAMETER veg_leafyveg(Regions,Scenarios,Commodities,descriptors, ProductionSystems) contains the portion of leavyveg;
PARAMETER veg_otherveg(Regions,Scenarios,Commodities,descriptors, ProductionSystems) contains the portion of otherveg;
PARAMETER sum_vegetables(Regions,Scenarios,descriptors, ProductionSystems) sum over all vegetables;

*Amount of leavyveg per region, day and person (g -> portions)
veg_leafyveg(Regions,Scenarios,leafyveg,"Portion", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =   VCommod_Food_MR.l(Regions,leafyveg ,ProductionSystems,"AllProdCond",Scenarios)
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios) *1000*1000
                        / 365
                        / 236.59;

veg_otherveg(Regions, Scenarios,otherveg,"Portion", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =   VCommod_Food_MR.l(Regions,otherveg ,ProductionSystems,"AllProdCond",Scenarios)
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)*1000*1000
                        / 365
                        / 118.295;


sum_vegetables(Regions, Scenarios,"Portion", ProductionSystems)
         = SUM((leafyveg),
         veg_leafyveg(Regions, Scenarios,leafyveg,"Portion", ProductionSystems))
         + SUM((otherveg),
         veg_otherveg(Regions, Scenarios,otherveg,"Portion", ProductionSystems));

veg_ahei_vegetables(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_vegetables(Regions,Scenarios,"Portion", ProductionSystems)
         AND (sum_vegetables(Regions,Scenarios,"Portion", ProductionSystems) ge 5))
         = 10;

veg_ahei_vegetables(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_vegetables(Regions,Scenarios,"Portion", ProductionSystems)
         AND (sum_vegetables(Regions, Scenarios,"Portion", ProductionSystems) lt 5))
         = sum_vegetables(Regions, Scenarios,"Portion", ProductionSystems) / 5 * 10;


*** 6. FRUITS ***

* step 1: convert g to portions
* step 2: calculate AHEI score



PARAMETER veg_fruits(Regions, Scenarios,Commodities,descriptors, ProductionSystems) contains the portion of fruits;
PARAMETER sum_fruits(Regions, Scenarios,descriptors, ProductionSystems) sum over all fruits;

veg_fruits(Regions, Scenarios,fruitsDO,"Portion", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =   VCommod_Food_MR.l(Regions,fruitsDO ,ProductionSystems,"AllProdCond",Scenarios)*1000*1000
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                        / 365
                        / 118.295;


sum_fruits(Regions, Scenarios,"Portion", ProductionSystems)
         = SUM((fruitsDO),
         veg_fruits(Regions, Scenarios,fruitsDO,"Portion", ProductionSystems));

veg_ahei_fruits(Regions, Scenarios,"Score", ProductionSystems)
         $(sum_fruits(Regions, Scenarios,"Portion", ProductionSystems)
         AND (sum_fruits(Regions, Scenarios,"Portion", ProductionSystems) ge 4))
         = 10;

veg_ahei_fruits(Regions, Scenarios,"Score", ProductionSystems)
         $(sum_fruits(Regions, Scenarios,"Portion", ProductionSystems)
         AND (sum_fruits(Regions, Scenarios,"Portion", ProductionSystems) lt 4))
         = sum_fruits(Regions, Scenarios,"Portion", ProductionSystems) / 4 * 10;




*** 7. SUGAR-SWEETENED BEVERAGES ***
* step 1: convert g to portions
* step 2: calculate AHEI score



PARAMETER veg_sugarbeverages(Regions, Scenarios,Commodities,descriptors, ProductionSystems) contains the portion of sugarbeverages;
PARAMETER sum_sugarbeverages(Regions,Scenarios,descriptors, ProductionSystems) sum over all sugarbeverages;
*Alias(Scenarios, scenario_AHEI);
*Alias(Scenarios, scenario);

*conversion: sugar kcal -> servings: average intake of US population: 151 kcal / day (Kumar et al., 2014) = 46% of total sugar availability kcal per day (US, baseline derived)
*1 serving = 8*28.35g
*100ml Cola = 10,6 Gramm Zucker -> 1g Zucker = 9.434 g Cola

veg_sugarbeverages(Regions,Scenarios,sugarbeverages,"Portion", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =   VCommod_Food_MR.l(Regions,sugarbeverages ,ProductionSystems,"AllProdCond",Scenarios)*1000*1000
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                        *0.46
                        *9.434
                        /(8*28.35)
                        / 365;



sum_sugarbeverages(Regions,Scenarios,"Portion", ProductionSystems)
         = SUM((sugarbeverages),
         veg_sugarbeverages(Regions,Scenarios,sugarbeverages,"Portion", ProductionSystems));

veg_ahei_sugarbeverages(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_sugarbeverages(Regions,Scenarios,"Portion", ProductionSystems)
          AND(sum_sugarbeverages(Regions,Scenarios,"Portion", ProductionSystems) ge 1))
         = 0.001;

veg_ahei_sugarbeverages(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_sugarbeverages(Regions,Scenarios,"Portion", ProductionSystems)
         AND sum_sugarbeverages(Regions,Scenarios,"Portion", ProductionSystems) lt 1)
         = 10-(sum_sugarbeverages(Regions,Scenarios,"Portion", ProductionSystems) * 10);

veg_ahei_sugarbeverages(Regions,Scenarios,"Score", ProductionSystems)
         $(NOT veg_ahei_sugarbeverages(Regions,Scenarios,"Score", ProductionSystems)
         AND SUM(Commodities, PortionSize(Commodities)))
         = 10;

* per definition no SSB in LMP-Scenario
* menuch_ahei_sugarbeverages("SFP2050","Score") = 10;


*** 8. MEAT ***

* step 1: convert g to portions
* step 2: calculate AHEI score


PARAMETER veg_processedmeat(Regions,Scenarios,Commodities,descriptors, ProductionSystems) contains the portion of processed meat;
PARAMETER veg_redmeat(Regions,Scenarios,Commodities,descriptors, ProductionSystems) contains the portion of redmeat;
PARAMETER sum_meat(Regions,Scenarios,descriptors, ProductionSystems) sum over all meat;

veg_processedmeat(Regions,Scenarios,processedmeat,"Portion", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =   VCommod_Food_MR.l(Regions,processedmeat ,ProductionSystems,"AllProdCond",Scenarios)*1000*1000
                        *ShareProcessed(processedmeat)
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                        / 365
                        / 42.525;



veg_redmeat(Regions,Scenarios,redmeat,"Portion", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =   VCommod_Food_MR.l(Regions,redmeat ,ProductionSystems,"AllProdCond",Scenarios)*1000*1000
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                        / 365
                        / 113.4;



sum_meat(Regions,Scenarios,"Portion", ProductionSystems)
         = SUM((processedmeat),
         veg_processedmeat(Regions,Scenarios,processedmeat,"Portion", ProductionSystems))
         + SUM((redmeat),
         veg_redmeat(Regions,Scenarios,redmeat,"Portion", ProductionSystems));

veg_ahei_meat(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_meat(Regions,Scenarios,"Portion", ProductionSystems)
         AND (sum_meat(Regions,Scenarios,"Portion", ProductionSystems) ge 1.5))
         = 0.001;

veg_ahei_meat(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_meat(Regions,Scenarios,"Portion", ProductionSystems)
         AND (sum_meat(Regions,Scenarios,"Portion", ProductionSystems) lt 1.5))
         = 10 - (sum_meat(Regions,Scenarios,"Portion", ProductionSystems) / 1.5 * 10);

veg_ahei_meat(Regions,Organic_Vegan_Results_Scenarios,"Score", ProductionSystems)
         $(NOT veg_ahei_meat(Regions,Organic_Vegan_Results_Scenarios,"Score", ProductionSystems))
         = 10;



*this makes no sense..
*veg_ahei_meat(Regions,Scenarios,"Score", ProductionSystems)
*         $(NOT veg_ahei_meat(Regions,Scenarios,"Score", ProductionSystems)
*                 AND SUM(redmeat, PortionSize(redmeat)))
*         = 10;




*** 9. FISH (LONG-CHAIN FATS (W-3)) ***

* step 1: define fish amount
* step 2: calculate AHEI score


PARAMETER veg_fish(Regions,Scenarios,Commodities,descriptors, ProductionSystems) contains the amount of fish;
PARAMETER sum_fish(Regions,Scenarios,descriptors, ProductionSystems) sum over all fish;

veg_fish(Regions,Scenarios,fish,"Amount", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =   VCommod_Food_MR.l(Regions,fish ,ProductionSystems,"AllProdCond",Scenarios)*1000*1000
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                        / 365;

sum_fish(Regions,Scenarios,"Amount", ProductionSystems)
         = SUM((fish),
         veg_fish(Regions,Scenarios,fish,"Amount", ProductionSystems));

*32.4 -> 250?
veg_ahei_fish(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_fish(Regions,Scenarios,"Amount", ProductionSystems)
         AND (sum_fish(Regions,Scenarios,"Amount", ProductionSystems) ge 250))
         = 10;


veg_ahei_fish(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_fish(Regions,Scenarios,"Amount", ProductionSystems)
         AND (sum_fish(Regions,Scenarios,"Amount", ProductionSystems) lt 250))
         = sum_fish(Regions,Scenarios,"Amount", ProductionSystems) / 250 * 10;


*** 10. MARGARINE (TRANS FAT) ***
* step 1: convert g to percentage
* step 2: calculate AHEI score
* results still slightly different from GP (?)



PARAMETER sum_marg(Regions,Scenarios,descriptors, ProductionSystems);
PARAMETER sum_perc(Regions,Scenarios,descriptors, ProductionSystems);
PARAMETER veg_transfat(Regions,Scenarios,descriptors, ProductionSystems);


*adapt: I use values for trans-fatty acid contents instead.. calculate g transfatty acids *9/(Energy kcal) *100

veg_sum(Regions, Scenarios,'Calories (kcal)', ProductionSystems)$(veg_sum(Regions, Scenarios,'Calories (kcal)', ProductionSystems) = eps) = 0;

veg_transfat(Regions, Scenarios,"Percentage", ProductionSystems)$(veg_sum(Regions, Scenarios,'Calories (kcal)', ProductionSystems))
            = veg_sum(Regions, Scenarios,'Fatty acids, total trans (g)', ProductionSystems)
                *9
                /veg_sum(Regions, Scenarios,'Calories (kcal)', ProductionSystems)
                *100;
                


*            = sum(Commodities,
*            VCommod_Food_Contents_MR.l(Regions,Commodities,'Fatty acids, total trans (g)',ProductionSystems,"AllProdCond",Scenarios)*9)*100
*                        /(sum(Commodities, VCommod_Food_Contents_MR.l(Regions,Commodities,'Calories (kcal)',ProductionSystems,"AllProdCond",Scenarios)))
*                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
*                        / 365;


veg_ahei_transfat(Regions, Scenarios,"Score", ProductionSystems)
         $(veg_transfat(Regions, Scenarios,"Percentage", ProductionSystems)
         AND (veg_transfat(Regions, Scenarios,"Percentage", ProductionSystems) ge 4))
         = 0.001;

veg_ahei_transfat(Regions, Scenarios,"Score", ProductionSystems)
         $(veg_transfat(Regions, Scenarios,"Percentage", ProductionSystems)
         AND (veg_transfat(Regions, Scenarios,"Percentage", ProductionSystems) le 0.5))
         = 10;

veg_ahei_transfat(Regions, Scenarios,"Score", ProductionSystems)
         $(veg_transfat(Regions, Scenarios,"Percentage", ProductionSystems)
         AND (veg_transfat(Regions, Scenarios,"Percentage", ProductionSystems) gt 0.5)
         AND (veg_transfat(Regions, Scenarios,"Percentage", ProductionSystems) lt 4))
         = 10 - ((veg_transfat(Regions, Scenarios,"Percentage", ProductionSystems) - 0.5) / (4 - 0.5)) * 10;
*this makes no sense..delete?
*veg_ahei_transfat(Regions, Scenarios,"Score", ProductionSystems)
*         $(NOT veg_ahei_transfat(Regions, Scenarios,"Score", ProductionSystems)
*                 AND SUM(Commodities, PortionSize(Commodities)))
*         = 10;
         




*** 11. ALCOHOL ***

* step 1: convert g to portions
* step 2: calculate AHEI score, partly separately for male and female



PARAMETER veg_alcbev(Regions,Scenarios,Commodities,descriptors, ProductionSystems) contains the portions of all alcoholic beverages;
PARAMETER sum_alcbev(Regions,Scenarios,descriptors, ProductionSystems) sum over all alcoholic beverages;

veg_alcbev(Regions,Scenarios,beer,"Portion", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =   VCommod_Food_MR.l(Regions,beer ,ProductionSystems,"AllProdCond",Scenarios)*1000*1000
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                        / 365
                        / 340.2;




veg_alcbev(Regions,Scenarios,wine,"Portion", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =   VCommod_Food_MR.l(Regions,wine ,ProductionSystems,"AllProdCond",Scenarios)*1000*1000
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                        / 365
                        / 113.4;


veg_alcbev(Regions,Scenarios,liquors,"Portion", ProductionSystems)$(VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =   VCommod_Food_MR.l(Regions,liquors ,ProductionSystems,"AllProdCond",Scenarios)*1000*1000
                        / VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                        / 365
                        / 42.525;



sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems)
         = SUM((beer),
         veg_alcbev(Regions,Scenarios,beer,"Portion", ProductionSystems))
         + SUM((wine),
         veg_alcbev(Regions,Scenarios,wine,"Portion", ProductionSystems))
         + SUM((liquors),
         veg_alcbev(Regions,Scenarios,liquors,"Portion", ProductionSystems));

* average

veg_ahei_alcbev(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems)
         AND (sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems) lt 0.5))
         = ((sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems)/0.5*7.5) + 2.5);

veg_ahei_alcbev(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems)
         AND (sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems) ge 3))
         = 0.001;

veg_ahei_alcbev(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems)
         AND (sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems) le 1.75)
         AND (sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems) ge 0.5))
         = 10;

veg_ahei_alcbev(Regions,Scenarios,"Score", ProductionSystems)
         $(sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems)
         AND (sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems) gt 1.75)
         AND (sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems) lt 3))
         = 10 - 10/1.25*(sum_alcbev(Regions,Scenarios,"Portion", ProductionSystems)-1.75);

*         = 10 - ((sum_alcbev(Regions,Scenarios,"Portion") - 1.75) / (3 - 1.75)) * 10;



*this makes no sense..
*veg_ahei_alcbev(Regions,Scenarios,"Score", ProductionSystems)
*         $(NOT veg_ahei_alcbev(Regions,Scenarios,"Score", ProductionSystems)
*         AND SUM(Commodities, PortionSize(Commodities)))
*         = 2.5;



*** CALCULATION OF THE AHEI SCORE ***

PARAMETER sum_ahei(Regions,Scenarios,descriptors, ProductionSystems) the total ahei;

sum_ahei(Countries,Scenarios,"Score", ProductionSystems)
         = veg_ahei_grains(Countries,Scenarios,"Score", ProductionSystems)
         + veg_ahei_nutslegveg(Countries,Scenarios,"Score", ProductionSystems)
         + veg_ahei_vegetables(Countries,Scenarios,"Score", ProductionSystems)
         + veg_ahei_fruits(Countries,Scenarios,"Score", ProductionSystems)
         + veg_ahei_sugarbeverages(Countries,Scenarios,"Score", ProductionSystems)
         + veg_ahei_meat(Countries,Scenarios,"Score", ProductionSystems)
         + veg_ahei_fish(Countries,Scenarios,"Score", ProductionSystems)
         + veg_ahei_transfat(Countries,Scenarios,"Score", ProductionSystems)
         + veg_ahei_alcbev(Countries,Scenarios,"Score", ProductionSystems)
         + veg_ahei_pufa(Countries,Scenarios,"Score", ProductionSystems)
         + veg_ahei_sodium(Countries,Scenarios,"Score", ProductionSystems)
         ;

sum_ahei("World",Scenarios,"Score", ProductionSystems )
        = sum(Countries,sum_ahei(Countries,Scenarios,"Score", ProductionSystems) );




*** export ***

execute_unload 'output_AHEI_reference__%OutputFileLabel%'
sum_ahei

veg_ahei_grains
veg_ahei_nutslegveg
veg_ahei_vegetables
veg_ahei_fruits
veg_ahei_sugarbeverages
veg_ahei_meat
veg_ahei_fish
veg_ahei_transfat
veg_ahei_alcbev
veg_ahei_pufa
veg_ahei_sodium
veg_sum
sum_alcbev
sum_wholegrains
sum_fish
sum_meat
veg_transfat
sum_sugarbeverages
sum_fruits
sum_vegetables
sum_nutslegveg
veg_wholegrains

;

