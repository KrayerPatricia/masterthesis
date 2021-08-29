*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
* Include nutrients from USDA-Database (SR28 mainly)
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
* 25.05.2021
************

Set ScenariosOfInterestxy(Scenarios)
/
Baseline
BaselineDerived
*FOFA_BAU_2050
*FOFA_2050_VeganBAU_NoFreeAreaUse
*FOFA_2050_VeganBAU
*FOFA_2050_VeganOptimized_conv
*FOFA_2050_VeganBarbieri
*FOFA_2050_VeganSchmidt
*FOFA_2050_VeganOptimized

/;


*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXadded hereXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
$onmulti
Set ContentsPerFreshMatterNutrients
/
"Calories (kcal)"
"Protein (t)"
"Fat (t)"
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
*new
'18:2 n-6 c,c (g)'
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
*'18:3 n-6 c,c,c (g)'

*amino acid score (aggregated)
'AAS (dmnl)'

'Vitamin D (D2 + D3) (ug)'
'Vitamin B-12 (ug)'
/;

$offmulti
*XXXXXXXXXXXXXXXX kray: added here



*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXadded hereXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
$onmulti
Set ContentsPerFreshMatterFood
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
*'18:3 n-6 c,c,c (g)'
'18:2 n-6 c,c (g)'

*amino acid score (aggregated)
'AAS (dmnl)'

'Vitamin D (D2 + D3) (ug)'
'Vitamin B-12 (ug)'
/;

$offmulti
*XXXXXXXXXXXXXXXX kray: added here





*The following part only needs to be run once
*XXX new 11.06.2021
$setglobal LoadNutrients "No"
$if %Scenario% == "BaselineDerived" $setglobal LoadNutrients "Yes"
$if LoadNutrients == "No" goto DoNotLoadNutrients
*XXXXX

*1) Import values from .csv
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

* load aggregated items - for now without units 
*****************************
Parameter Nutrients_aggregated_V(Regions, Commodities , Contents);
*$call csv2gdx nutrient_contents_agg_items_2.csv id=Nutrients_aggregated_V Index=(1,2,3) fieldSep=Comma Values=(5) UseHeader=Y

*load aggregated items
***************************
*$call csv2gdx nutrient_contents_agg_items_210530_2.csv id=Nutrients_aggregated_V Index=(1,2,6) fieldSep=Comma Values=(5) UseHeader=Y
$call csv2gdx nutrient_contents_agg_items.csv id=Nutrients_aggregated_V Index=(1,2,5) fieldSep=Comma Values=(6) UseHeader=Y


*execute_unload 'nutrients_agg1', Nutrients_aggregated_V;
*says that unable to open gdx file?!


$gdxin nutrient_contents_agg_items.gdx
*$gdxin nutrient_contents_agg_items_210530_2.gdx
$loadM Nutrients_aggregated_V
$gdxin

*load individual items
***************************
Parameter Nutrients_individual_V(Commodities , Contents);

$call csv2gdx nutrients_AAS_individual_items.csv id=Nutrients_individual_V Index=(2,6) fieldSep=Comma Values=(5) UseHeader=Y
*execute_unload 'nutrients_agg1', Nutrients_aggregated_V;
*says that unable to open gdx file?!


$gdxin nutrients_AAS_individual_items.gdx
$loadM Nutrients_individual_V
$gdxin


execute_unload 'nutr_ind', Nutrients_individual_V;




*assign values to Commod_Contents: nutrient contents (g/ton) = nutrients contents (g/100g*10*1000kg/t)
Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions, ScenariosOfInterestxy)
        $(NOT Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions, ScenariosOfInterestxy))
            = Nutrients_aggregated_V(Regions, Commodities, Contents)
                *10*1000;

*explicit for organic scenarios
*Commod_Contents_MR(Regions,Commodities,Contents,"Organic","AllProdCond", "%Scenario%")
*        $(NOT Commod_Contents_MR(Regions,Commodities,Contents,"Organic","AllProdCond", "%Scenario%"))
*            = Nutrients_aggregated_V(Regions, Commodities, Contents)
*                *10*1000;
            

*assign values to Commod_Contents: nutrient contents (g/ton) = nutrients contents (g/100g)*10*1000kg/t
Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions, ScenariosOfInterestxy)
        $(NOT Commod_Contents_MR(Regions,Commodities,Contents,ProductionSystems,ProductionConditions, ScenariosOfInterestxy))
            = Nutrients_individual_V(Commodities , Contents)
                *10*1000;

************* new: 14.08.2021: AAS does not change if per ton -> calculate back to original value
Commod_Contents_MR(Regions,Commodities,"AAS (dmnl)",ProductionSystems,ProductionConditions, ScenariosOfInterestxy)
            = Commod_Contents_MR(Regions,Commodities,"AAS (dmnl)",ProductionSystems,ProductionConditions, ScenariosOfInterestxy)
                /1000/10;



*explicit for organic scenarios
*Commod_Contents_MR(Regions,Commodities,Contents,"Organic","AllProdCond", "%Scenario%")
*        $(NOT Commod_Contents_MR(Regions,Commodities,Contents,"Organic","AllProdCond", "%Scenario%"))
*            = Nutrients_individual_V(Commodities , Contents)
*                *10*1000;
            

$label DoNotLoadNutrients



$if LoadNutrients == "No" goto EndOfScript
execute_unload 'commodity_contentsTest' Commod_Contents_MR;
$label EndOfScript

$exit

*XXXXXXXXX Delete part below later


*Error test 1: use smaller subset - Problem was that parameter was redefined during loops -> use loadM
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
*$call csv2gdx nutrient_testSet.csv id=testXYZ Index=(1,2,3,4) fieldSep=Comma Values=(5) UseHeader=Y

*$gdxin nutrient_testSet.gdx
*Parameter testXYZ(Regions, Commodities, Contents, units_V);
*$loadM testXYZ
*$gdxin
*execute_unload 'nut_test', testXYZ;




*Scalar testscalar2;
*testscalar2 = Commod_Contents("Afghanistan","Apples and products","Calories (kcal)","AllProdSyst","AllProdCond");

*Scalar testscalar;
*testscalar = testXYZ("Afghanistan", "Apples and products", "AAS", "dmnl");













*2) Assign values for new nutrients
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

*Commod_Contents_MR(Regions,Commodities,New_nutrients_V,ProductionSystems,ProductionConditions,Scenarios) 
