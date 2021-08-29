**********************Master Thesis "Modeling Impacts of Vegan Agriculture": Crop Rotation Optimization ****************
*
************************************************************************************************************************
*ZHAW, Master of Life Sciences, ACLS
*Autor: Patricia Krayer
*Supervisor: Matthias Nyfeler (ZHAW), Adrian Müller (FIbL, ETHZ)
*Submission: 31.08.2021
***********************************************************************************************************************


*necessary??
*Approach 1: use groups as defined in Barbieri et al. (2017)
*SETS    CROPS  POTENTIAL INVESTMENTS /CEREAL1, CEREAL2, CEREALPULSE, PULSES, OILSEED, ROOT, GRAINMAIZE, INDUSTRIAL, VEGETABLE, FODDER/;
*        EVENTS  STATES OF NATURE -  years /1*5/
SET constraint_type_V Constraints
/
kcal,
*Carbohydrates,
*"dietary fibres",
Protein,
Fat,
**Sugar,
*"Saturated FA",
*LA,
*VitA,
*VitB2,
*ALA,
*VitB3,
**VitD,
*Potassium,
*Iron,
**VitB12,
Calcium,
*Zinc,
*Selenium,
*Copper,
*Magnesium,
*Manganese,
*Phosphorous,
*Thiamin,
*VitB6,
*VitC
maxGrains,
maxPulses,
minLegumes,
maxOil,
minSetAside
*NitrogenFix

/;

$ontext
*Test with only 2 constraints
SET constraint_type_V2(constraint_type_V)
/
*Carbohydrates
*Protein
*Fat
*Zinc
/;
$offtext


*******************************************************************************************************************************************************
*1. calculate nutrient / ha - for each country
*******************************************************************************************************************************************************


Variable weight2(Regions, Crops, Commodities);
Parameter Total_DAQ2(Regions, Crops);

Total_DAQ2(Regions, Crops) = Sum(Commodities$MatchCommAct_CommodEquivalentAct_Crops(Commodities,Crops,"MainOutput1 (t)")
                                                ,VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst","AllProdCond","Baseline"));

*share of commodity in total DAQ out of crop
weight2.l(Regions, Crops, Commodities)$(Total_DAQ2(Regions, Crops))
                                    = VCommod_Quantity_MR.l(Regions,Commodities,"AllProdSyst","AllProdCond","Baseline")
                                            / Total_DAQ2(Regions, Crops);
                                            
execute_unload 'quantities', VCommod_Quantity_MR;
execute_unload 'totalDAQ2', Total_DAQ2;
execute_unload 'weights2', weight2;
execute_unload 'contents_test2' Commod_Contents_MR;
execute_unload 'yields' ActCropsGrass_Outputs_MR;
execute_unload 'extractionRates' ExtractionRate_CommodityTree;


*Parameter nut_ha_V(Contents, Crops);
Parameter nut_ha_V(Countries, Contents, Crops);

nut_ha_V(Countries, Contents, Crops)
*$(sum((Countries, Commodities)$(ActCropsGrass_Outputs_MR(Countries,Crops,"MainOutput1 (t)","AllProdSyst","AllProdCond", "BaselineDerived") AND ExtractionRate_CommodityTree(Countries,Commodities)), 1))
*weight2.l(Countries, Crops, Commodities) ),1))
            =
             sum(Commodities$(MatchCommAct_CommodEquivalentAct_Crops(Commodities,Crops,"MainOutput1 (t)"))
                , Commod_Contents_MR(Countries,Commodities,Contents,"AllProdSyst","AllProdCond", "BaselineDerived")
                    * ActCropsGrass_Outputs_MR(Countries,Crops,"MainOutput1 (t)","AllProdSyst","AllProdCond", "BaselineDerived")
                        * ExtractionRate_CommodityTree(Countries,Commodities)
                    );


*Averaged over crop rotation group
Parameter nut_ha_agg_V(Countries, Contents, CropRotationCategories_V);
nut_ha_agg_V(Countries, Contents, CropRotationCategories_V)
        = sum(Crops$MatchCropsCategories_V(Crops, CropRotationCategories_V), nut_ha_V(Countries, Contents, Crops))
            / Sum(Crops$MatchCropsCategories_V(Crops, CropRotationCategories_V),1);

execute_unload 'nut_ha_V', nut_ha_V;
execute_unload 'nut_ha_agg_V', nut_ha_agg_V;



************************************************************************************
*1b.) Subtract nutrient values from permCrops
************************************************************************************
Parameter permNutrients(Countries, Contents);

permNutrients(Countries, Contents) = sum(PermCrops_V,
                            sum(Commodities$MatchCommAct_CommodEquivalentAct_Crops(Commodities,PermCrops_V,"MainOutput1 (t)"),
                                    VActCropsGrass_QuantityActUnits_MR.l(Countries,PermCrops_V,"AllProdSyst","AllProdCond","BaselineDerived")             
                                    * ActCropsGrass_Outputs_MR(Countries,PermCrops_V,"MainOutput1 (t)","AllProdSyst","AllProdCond", "BaselineDerived")
                                    * ExtractionRate_CommodityTree(Countries,Commodities)
                                    *Commod_Contents_MR(Countries,Commodities,Contents,"AllProdSyst","AllProdCond", "BaselineDerived")           
                            )       
                        );

execute_unload 'permNuts' permNutrients;











$ontext
*2.1 nutrient constraints
************************************************************************************
*kcal
TechCoeff_V(Countries, "kcal", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Calories (kcal)", CropRotationCategories_V);

*other nutrients
*Carbohydrates, "dietary fibres", Protein, Fat, "Saturated FA", LA, VitA, VitB2, ALA, VitB3, VitD, Potassium, Iron, VitB12, Calcium, Zinc, Selenium
TechCoeff_V(Countries, "Carbohydrates", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Carbohydrate, by difference (g)", CropRotationCategories_V);
TechCoeff_V(Countries, "dietary fibres", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Fiber, total dietary (g)", CropRotationCategories_V);
*later, include proteins and fats from SOLm-data!!!!!!!!!!!!!
*conversion into g
TechCoeff_V(Countries, "Protein", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Protein (t)", CropRotationCategories_V)*1000*1000;
TechCoeff_V(Countries, "Fat", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Fat (t)", CropRotationCategories_V)*1000*1000;
*TechCoeff_V("Saturated FA", CropRotationCategories_V) = -nut_ha_agg_V("Fatty acids, total saturated (g)", CropRotationCategories_V);
TechCoeff_V(Countries, "LA", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "18:2 n-6 c,c (g)", CropRotationCategories_V);
*add here conversion factor: 1 IU = 0.3ug Retinol
TechCoeff_V(Countries, "VitA", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Vitamin A, IU (IU)", CropRotationCategories_V)/0.3;
TechCoeff_V(Countries, "VitB2", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Riboflavin (mg)", CropRotationCategories_V);
TechCoeff_V(Countries, "ALA", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "18:3 n-3 c,c,c (ALA) (g)", CropRotationCategories_V);
TechCoeff_V(Countries, "VitB3", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Niacin (mg)", CropRotationCategories_V);
*TechCoeff_V("VitD", CropRotationCategories_V) = -nut_ha_agg_V("Vitamin D (D2 + D3) (ug)", CropRotationCategories_V);
TechCoeff_V(Countries, "Potassium", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Potassium, K (mg)", CropRotationCategories_V);
TechCoeff_V(Countries, "Iron", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Iron, Fe (mg)", CropRotationCategories_V);
*TechCoeff_V("VitB12", CropRotationCategories_V) = -nut_ha_agg_V("Vitamin B-12 (ug)", CropRotationCategories_V);
TechCoeff_V(Countries, "Calcium", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Calcium, Ca (mg)", CropRotationCategories_V);
TechCoeff_V(Countries, "Zinc", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Zinc, Zn (mg)", CropRotationCategories_V);
TechCoeff_V(Countries, "Selenium", CropRotationCategories_V) = -nut_ha_agg_V(Countries, "Selenium, Se (ug)", CropRotationCategories_V);
TechCoeff_V(Countries, "Copper", CropRotationCategories_V) = -nut_ha_agg_V(Countries, 'Copper, Cu (mg)', CropRotationCategories_V);
TechCoeff_V(Countries, "Magnesium", CropRotationCategories_V) = -nut_ha_agg_V(Countries, 'Magnesium, Mg (mg)', CropRotationCategories_V);
TechCoeff_V(Countries, "Manganese", CropRotationCategories_V) = -nut_ha_agg_V(Countries, 'Manganese, Mn (mg)', CropRotationCategories_V);
TechCoeff_V(Countries, "Phosphorous", CropRotationCategories_V) = -nut_ha_agg_V(Countries, 'Phosphorus, P (mg)', CropRotationCategories_V);
TechCoeff_V(Countries, "Thiamin", CropRotationCategories_V) = -nut_ha_agg_V(Countries, 'Thiamin (mg)', CropRotationCategories_V);
TechCoeff_V(Countries, "VitB6", CropRotationCategories_V) = -nut_ha_agg_V(Countries, 'Vitamin B-6 (mg)', CropRotationCategories_V);
TechCoeff_V(Countries, "VitC", CropRotationCategories_V) = -nut_ha_agg_V(Countries, 'Vitamin C, total ascorbic acid (mg)', CropRotationCategories_V);





*2.2 agronomical constraints
************************************************************************************
*$ontext
*Maximum share of grains: 50% 
TechCoeff_V(Countries, "maxGrains", "Cereals1_V")
        = 1;
TechCoeff_V(Countries, "maxGrains", "Cereals2_V")
        = 1;
TechCoeff_V(Countries, "maxGrains", "Pulses_V")
        = -1;
TechCoeff_V(Countries, "maxGrains", "Oilcrops_V")
        = -1;
TechCoeff_V(Countries, "maxGrains", "Vegetables")
        = -1;
TechCoeff_V(Countries, "maxGrains", "StarchyRoots")
        = -1;
TechCoeff_V(Countries, "maxGrains", "Fruits_V")
        = -1;    
TechCoeff_V(Countries, "maxGrains", "SetAside_V")
        = -1;

*Maximum share of legumes: 35% 
TechCoeff_V(Countries, "maxPulses", "Cereals1_V")
        = -0.35;
TechCoeff_V(Countries, "maxPulses", "Cereals2_V")
        = -0.35;
TechCoeff_V(Countries, "maxPulses", "Pulses_V")
        = 0.65;
TechCoeff_V(Countries, "maxPulses", "Oilcrops_V")
        = -0.35;
TechCoeff_V(Countries, "maxPulses", "Vegetables")
        = -0.35;
TechCoeff_V(Countries, "maxPulses", "StarchyRoots")
        = -0.35;
TechCoeff_V(Countries, "maxPulses", "Fruits_V")
        = -0.35;    
TechCoeff_V(Countries, "maxPulses", "SetAside_V")
        = -0.35;
        
*Minimum share of set aside: 10% 
TechCoeff_V(Countries, "minSetAside", "Cereals1_V")
        = 0.1;
TechCoeff_V(Countries, "minSetAside", "Cereals2_V")
        = 0.1;
TechCoeff_V(Countries, "minSetAside", "Pulses_V")
        = 0.1;
TechCoeff_V(Countries, "minSetAside", "Oilcrops_V")
        = 0.1;
TechCoeff_V(Countries, "minSetAside", "Vegetables")
        = 0.1;
TechCoeff_V(Countries, "minSetAside", "StarchyRoots")
        = 0.1;
TechCoeff_V(Countries, "minSetAside", "Fruits_V")
        = 0.1;    
TechCoeff_V(Countries, "minSetAside", "SetAside_V")
        = -0.9;
        
*Minimum share of set aside and grain legumes: 20% 
TechCoeff_V(Countries, "minLegumes", "Cereals1_V")
        = 0.2;
TechCoeff_V(Countries, "minLegumes", "Cereals2_V")
        = 0.2;
TechCoeff_V(Countries, "minLegumes", "Pulses_V")
        = -0.8;
TechCoeff_V(Countries, "minLegumes", "Oilcrops_V")
        = 0.2;
TechCoeff_V(Countries, "minLegumes", "Vegetables")
        = 0.2;
TechCoeff_V(Countries, "minLegumes", "StarchyRoots")
        = 0.2;
TechCoeff_V(Countries, "minLegumes", "Fruits_V")
        = 0.2;    
TechCoeff_V(Countries, "minLegumes", "SetAside_V")
        = -0.8;

*Maximum share of oilcrops: 33% 
TechCoeff_V(Countries, "maxOil", "Cereals1_V")
        = -0.33;
TechCoeff_V(Countries, "maxOil", "Cereals2_V")
        = -0.33;
TechCoeff_V(Countries, "maxOil", "Pulses_V")
        = -0.33;
TechCoeff_V(Countries, "maxOil", "Oilcrops_V")
        = 0.67;
TechCoeff_V(Countries, "maxOil", "Vegetables")
        = -0.33;
TechCoeff_V(Countries, "maxOil", "StarchyRoots")
        = -0.33;
TechCoeff_V(Countries, "maxOil", "Fruits_V")
        = -0.33;    
TechCoeff_V(Countries, "maxOil", "SetAside_V")
        = -0.33;
$offtext

************************************************************************************
*2.) Add technical coefficients - import values (with imputed values)
************************************************************************************
Parameter TechCoeff_V(Countries, constraint_type_V, CropRotationCategories_V) Table with constraints ;
*load aggregated items
***************************
$call csv2gdx technicalCoefficients_imputed.csv id=TechCoeff_V Index=(1,2,3) fieldSep=Comma Values=(4) UseHeader=Y

$gdxin technicalCoefficients_imputed.gdx
$loadM TechCoeff_V
$gdxin





$ontext
******************
*New 23.06.2021: Nitrogen Fixation - since the values are all 0 in input and output dataframe -> no effect...
******************
*Cereals 1
TechCoeff_V("NitrogenFix", "Cereals1_V")
        = sum(
            Cereals1_V$(sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Cereals1_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_Outputs_MR(Countries,Cereals1_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived") 
                )
                / sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Cereals1_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Cereals1_V"),1);
            
***delete later
Parameter count_test;
count_test = sum(Crops$MatchCropsCategories_V(Crops, "Cereals1_V"),1);

execute_unload 'count' count_test;
****

*Cereals 2
TechCoeff_V("NitrogenFix", "Cereals2_V")
        = sum(
            Cereals2_V$(sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Cereals2_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_Outputs_MR(Countries,Cereals2_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived") 
                )
                / sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Cereals2_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Cereals2_V"),1);
    


*Pulses
TechCoeff_V("NitrogenFix", "Pulses_V")
        = - sum(
            Pulses_V$(sum(Countries$(ActCropsGrass_Inputs_MR(Countries,Pulses_V,"N fixation (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_Inputs_MR(Countries,Pulses_V,"N fixation (tN)","AllProdSyst","AllProdCond","BaselineDerived")
                        - ActCropsGrass_Outputs_MR(Countries,Pulses_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived") 

                )
                / sum(Countries$(ActCropsGrass_Inputs_MR(Countries,Pulses_V,"N fixation (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Pulses_V"),1);
    


*Oilcrops
TechCoeff_V("NitrogenFix", "Oilcrops_V")
        = sum(
            Oilcrops_V$(sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Oilcrops_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_Outputs_MR(Countries,Oilcrops_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived") 
                )
                / sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Oilcrops_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Oilcrops_V"),1);
    




*Vegetables
TechCoeff_V("NitrogenFix", "Vegetables")
        = sum(
            Vegetables$(sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Vegetables,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_Outputs_MR(Countries,Vegetables,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived") 
                )
                / sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Vegetables,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Vegetables"),1);
    


*Starchy Roots
TechCoeff_V("NitrogenFix", "StarchyRoots")
        = sum(
            StarchyRoots$(sum(Countries$(ActCropsGrass_Outputs_MR(Countries,StarchyRoots,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_Outputs_MR(Countries,StarchyRoots,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived") 
                )
                / sum(Countries$(ActCropsGrass_Outputs_MR(Countries,StarchyRoots,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "StarchyRoots"),1);
    


*Fruits
TechCoeff_V("NitrogenFix", "Fruits_V")
        = sum(
            Fruits_V$(sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Fruits_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_Outputs_MR(Countries,Fruits_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived") 
                )
                / sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Fruits_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Fruits_V"),1);
    

*Set Aside
TechCoeff_V("NitrogenFix", "SetASide_V")
        = - sum(
            SetASide_V$(sum(Countries$(ActCropsGrass_Outputs_MR(Countries,SetASide_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                    ActCropsGrass_Inputs_MR(Countries ,SetASide_V,"N fixation (tN)","AllProdSyst","AllProdCond","BaselineDerived")    
*                    - ActCropsGrass_Outputs_MR(Countries,SetASide_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")  - we neglect here the output to calculate the potential (full use of crop residue N)
                )
                / sum(Countries$(ActCropsGrass_Outputs_MR(Countries,SetASide_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "SetASide_V"),1);
    
$offtext

execute_unload TechCoeff_V;
execute_unload 'outputs' ActCropsGrass_Outputs_MR;
execute_unload 'inputsSetAside'  ActCropsGrass_Inputs_MR;



****************************
*Define vector b (Resources)
****************************

Parameter Total_pop(Countries);
*Total_pop = sum(Countries, VPopulationNumbers_MR.l(Countries,"PopulationAll","FOFA_BAU_2050"));
*Total_pop = 9750000000;
*Total_pop = sum(Countries, VPopulationNumbers_MR.l(Countries,"PopulationAll","Baseline"));
Total_pop(Countries) = VPopulationNumbers_MR.l(Countries,"PopulationAll","Baseline");
execute_unload 'pop' Total_pop;

*delete this number later..

Parameter b(Countries, constraint_type_V) Resources available or necessary (but here some are set to zero) - ; 
b(Countries, "kcal") = -365*2400*Total_pop(Countries)  + permNutrients(Countries, "Calories (kcal)");
*b(Countries, "Carbohydrates") = -365*270*Total_pop(Countries)  + permNutrients(Countries, "Carbohydrate, by difference (g)");
*b(Countries, "dietary fibres")= -365*25*Total_pop(Countries)  + permNutrients(Countries, "Fiber, total dietary (g)");
b(Countries, "Protein")= -365*66.4*Total_pop(Countries)  + permNutrients(Countries, "Protein (t)");
b(Countries, "Fat")= -365*53.3*Total_pop(Countries)  + permNutrients(Countries, "Fat (t)");
*b("Saturated FA")
*b(Countries, "LA")= -365*10.56*Total_pop(Countries)  + permNutrients(Countries, "18:2 n-6 c,c (g)");
*b(Countries, "VitA")= -365*700*Total_pop(Countries)  + permNutrients(Countries, "Vitamin A, IU (IU)");
*b(Countries, "VitB2")= -365*1.3*Total_pop(Countries)  + permNutrients(Countries, "Riboflavin (mg)");
*b(Countries, "ALA")= -365*2.7*Total_pop(Countries)  + permNutrients(Countries, "18:3 n-3 c,c,c (ALA) (g)");
*b(Countries, "VitB3")= -365*16.5*Total_pop(Countries)  + permNutrients(Countries, "Niacin (mg)");
*b("VitD")= -365*15*Total_pop;
*b(Countries, "Potassium")= -365*3500*Total_pop(Countries)  + permNutrients(Countries, "Potassium, K (mg)");
*b(Countries, "Iron")= -365*11*Total_pop(Countries)  + permNutrients(Countries, "Iron, Fe (mg)");
*b("VitB12")
b(Countries, "Calcium")= -365*950*Total_pop(Countries)  + permNutrients(Countries, "Calcium, Ca (mg)");
*b(Countries, "Zinc")= -365*8.45*Total_pop(Countries)  + permNutrients(Countries, "Zinc, Zn (mg)");
*b(Countries, "Selenium")= -365*70*Total_pop(Countries)  + permNutrients(Countries, "Selenium, Se (ug)");
*new
*b(Countries, "Copper")= -365*1.45*Total_pop(Countries)  + permNutrients(Countries, "Copper, Cu (mg)");
*b(Countries, "Magnesium")= -365*325*Total_pop(Countries)  + permNutrients(Countries, "Magnesium, Mg (mg)");
*b(Countries, "Manganese")= -365*3*Total_pop(Countries)  + permNutrients(Countries, "Manganese, Mn (mg)");
*b(Countries, "Phosphorous")= -365*550*Total_pop(Countries)  + permNutrients(Countries, "Phosphorus, P (mg)");
*b(Countries, "Thiamin")= -365*1*Total_pop(Countries)  + permNutrients(Countries, "Thiamin (mg)");
*b(Countries, "VitB6")= -365*1.6*Total_pop(Countries)  + permNutrients(Countries, "Vitamin B-6 (mg)");
*b(Countries, "VitC")= -365*102.5*Total_pop(Countries)  + permNutrients(Countries, "Vitamin C, total ascorbic acid (mg)");



b(Countries, "maxGrains") = 0;
b(Countries, "maxPulses") = 0;
b(Countries, "minSetAside") = 0;
b(Countries, "minLegumes") = 0;
b(Countries, "maxOil") = 0;

*b("NitrogenFix") = 0;


execute_unload 'b' b;


*add here max values for nutrients
Parameter b2(Countries, constraint_type_V) Resources available or necessary (but here some are set to zero) - ; 
*b("kcal") = -365*2500*Total_pop;
*b2(Countries, "Carbohydrates") = 365*360*Total_pop(Countries) ;
*b("dietary fibres")= -365*25*Total_pop;
*b2("Protein")= 365*132.8*Total_pop;
*b2("Fat")= 365*93.3*Total_pop;
*b("Saturated FA")
*b("LA")= -365*10.56*Total_pop;
*b("VitA")= -365*530*Total_pop;
*b("VitB2")= -365*1.3*Total_pop;
*b("ALA")= -365*2.7*Total_pop;
*b("VitB3")= -365*5.5*Total_pop;
*b("VitD")= -365*15*Total_pop;
*b("Potassium")= -365*3500*Total_pop;
*b("Iron")= -365*9*Total_pop;
*b("VitB12")
*b("Calcium")= -365*750*Total_pop;
*b2("Zinc")= 365*14.6*Total_pop;
*b("Selenium")= -365*70*Total_pop;

execute_unload 'b2' b2;



*Carbohydrates, "dietary fibres", Protein, Fat, "Saturated FA", LA, VitA, VitB2, ALA, VitB3, VitD, Potassium, Iron, VitB12, Calcium, Zinc, Selenium

 
***********************

POSITIVE VARIABLES INVEST(Countries, CropRotationCategories_V)   HA "INVESTED" IN EACH STOCK;

VARIABLE    OBJ     Minimize area;
*Variable testeq1(constraint_type_V);
*Variable eq2(constraint_type_V2);


***************EQUATIONS**********************************

EQUATIONS   OBJJ       OBJECTIVE FUNCTION
            CONSTEQ(Countries, constraint_type_V)    Technical Coefficients (Ax <= b)
*            CONSTEQ2(constraint_type_V2)    Further constraints (if range necessary)
*            testeq(constraint_type_V)
            ;
            

*objective function Z = sum over ha -> Total area
OBJJ.. OBJ =e= SUM((Countries, CropRotationCategories_V), INVEST(Countries, CropRotationCategories_V));

*first equation: min values & agronomical constraints
CONSTEQ(Countries, constraint_type_V).. Sum(CropRotationCategories_V, TechCoeff_V(Countries, constraint_type_V, CropRotationCategories_V)*Invest(Countries, CropRotationCategories_V)) =l= b(Countries, constraint_type_V);

*second equation: max values
*CONSTEQ2(constraint_type_V2).. Sum(CropRotationCategories_V, -TechCoeff_V(constraint_type_V2, CropRotationCategories_V)*Invest(CropRotationCategories_V)) =l= b2(constraint_type_V2);
*testeq(constraint_type_V).. testeq1(constraint_type_V) =e= Sum(CropRotationCategories_V, TechCoeff_V(constraint_type_V, CropRotationCategories_V)*Invest(CropRotationCategories_V));


***********SOLVE MODEL***********************************

MODEL TEST /ALL/;

SOLVE TEST USING LP MINIMIZING OBJ;

display OBJ.L;

execute_unload 'res', invest;
*execute_unload 'consteq' testeq1;

*************find bugs

Parameter whereisthebug(Countries, constraint_type_V);
Parameter whereisthebug2(constraint_type_V);
whereisthebug(Countries, constraint_type_V) = Sum(CropRotationCategories_V, -TechCoeff_V(Countries, constraint_type_V, CropRotationCategories_V)*Invest.l(Countries, CropRotationCategories_V));
*whereisthebug2(constraint_type_V2) = Sum(CropRotationCategories_V, -TechCoeff_V(constraint_type_V2, CropRotationCategories_V)*Invest.l(CropRotationCategories_V));
execute_unload 'bug' whereisthebug;
*execute_unload 'bug2' whereisthebug2;

$call gdxdump res.gdx output=resOptimization.csv symb=INVEST format=csv


***************Export for comparison: current/projected areas for each country and crop rotation category

Parameter Areas_Total(CropRotationCategories_V, Countries);

Areas_Total("Cereals1_V", Countries) = Sum(Cereals1_V, VActCropsGrass_QuantityActUnits_MR.l(Countries, Cereals1_V, "AllProdSyst", "AllProdCond", "BaselineDerived"));
Areas_Total("Cereals2_V", Countries) = Sum(Cereals2_V, VActCropsGrass_QuantityActUnits_MR.l(Countries, Cereals2_V, "AllProdSyst", "AllProdCond", "BaselineDerived"));
Areas_Total("Pulses_V", Countries) = Sum(Pulses_V, VActCropsGrass_QuantityActUnits_MR.l(Countries, Pulses_V, "AllProdSyst", "AllProdCond", "BaselineDerived"));
Areas_Total("Oilcrops_V", Countries) = Sum(Oilcrops_V, VActCropsGrass_QuantityActUnits_MR.l(Countries, Oilcrops_V, "AllProdSyst", "AllProdCond", "BaselineDerived"));
Areas_Total("Vegetables", Countries) = Sum(Vegetables, VActCropsGrass_QuantityActUnits_MR.l(Countries, Vegetables, "AllProdSyst", "AllProdCond", "BaselineDerived"));
Areas_Total("StarchyRoots", Countries) = Sum(StarchyRoots, VActCropsGrass_QuantityActUnits_MR.l(Countries, StarchyRoots, "AllProdSyst", "AllProdCond", "BaselineDerived"));
Areas_Total("Fruits_V", Countries) = Sum(Fruits_V, VActCropsGrass_QuantityActUnits_MR.l(Countries, Fruits_V, "AllProdSyst", "AllProdCond", "BaselineDerived"));
Areas_Total("SetAside_V", Countries) = Sum(SetAside_V, VActCropsGrass_QuantityActUnits_MR.l(Countries, SetAside_V, "AllProdSyst", "AllProdCond", "BaselineDerived"));


execute_unload 'Areas_total' Areas_Total;
$call gdxdump Areas_total.gdx output=Areas_total.csv symb=Areas_Total format=csv



