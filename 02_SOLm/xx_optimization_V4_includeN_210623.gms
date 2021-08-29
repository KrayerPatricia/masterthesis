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
Carbohydrates,
"dietary fibres",
Protein,
Fat,
**Sugar,
"Saturated FA",
LA,
VitA,
VitB2,
ALA,
VitB3,
**VitD,
Potassium,
Iron,
**VitB12,
Calcium,
Zinc,
Selenium,
Copper,
Magnesium,
Manganese,
Phosphorous,
Thiamin,
VitB6,
VitC
maxGrains,
maxPulses,
minLegumes,
maxOil,
minSetAside
NitrogenFix

/;


*Test with only 2 constraints
SET constraint_type_V2(constraint_type_V)
/
Carbohydrates
*Protein
*Fat
*Zinc
/;



************************************************************************************
*1. calculate nutrient amount / ha
************************************************************************************


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


Parameter nut_ha_V(Contents, Crops);

*For single crops
*******************
nut_ha_V(Contents, Crops)
            =
             sum(Commodities$(MatchCommAct_CommodEquivalentAct_Crops(Commodities,Crops,"MainOutput1 (t)") AND sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Crops,"MainOutput1 (t)","AllProdSyst","AllProdCond", "BaselineDerived") AND ExtractionRate_CommodityTree(Countries,Commodities)), 1))
                , sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Crops,"MainOutput1 (t)","AllProdSyst","AllProdCond", "BaselineDerived") AND ExtractionRate_CommodityTree(Countries,Commodities))
                , Commod_Contents_MR("Afghanistan",Commodities,Contents,"AllProdSyst","AllProdCond", "BaselineDerived")
                    * ActCropsGrass_Outputs_MR(Countries,Crops,"MainOutput1 (t)","AllProdSyst","AllProdCond", "BaselineDerived")
                        * ExtractionRate_CommodityTree(Countries,Commodities)
                            )
                    /sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Crops,"MainOutput1 (t)","AllProdSyst","AllProdCond", "BaselineDerived") AND ExtractionRate_CommodityTree(Countries,Commodities)), 1)
                    );


*aggregated: nutrient amounts / ha in crop rotation category
**********************************************
Parameter nut_ha_agg_V(Contents, CropRotationCategories_V);
nut_ha_agg_V(Contents, CropRotationCategories_V)
        = sum(Crops$MatchCropsCategories_V(Crops, CropRotationCategories_V), nut_ha_V(Contents, Crops))
            / Sum(Crops$MatchCropsCategories_V(Crops, CropRotationCategories_V),1);


execute_unload 'nut_ha_V', nut_ha_V;
execute_unload 'nut_ha_agg_V', nut_ha_agg_V;



************************************************************************************
*1b.) Determine nutrient values from permCrops
************************************************************************************
Parameter permNutrients(Contents);

permNutrients(Contents) = sum(PermCrops_V,
                            sum(Commodities$MatchCommAct_CommodEquivalentAct_Crops(Commodities,PermCrops_V,"MainOutput1 (t)"),
                                sum(Countries,
                                    VActCropsGrass_QuantityActUnits_MR.l(Countries,PermCrops_V,"AllProdSyst","AllProdCond","BaselineDerived")             
                                    * ActCropsGrass_Outputs_MR(Countries,PermCrops_V,"MainOutput1 (t)","AllProdSyst","AllProdCond", "BaselineDerived")
                                    * ExtractionRate_CommodityTree(Countries,Commodities)
                                    )
                             *Commod_Contents_MR("Afghanistan",Commodities,Contents,"AllProdSyst","AllProdCond", "BaselineDerived")           
                            )       
                        );

execute_unload 'permNuts' permNutrients;









************************************************************************************
*2.) Add technical coefficients
************************************************************************************
Parameter TechCoeff_V(constraint_type_V, CropRotationCategories_V) Table with constraints ;

*2.1 nutrient constraints
************************************************************************************
*kcal
*TechCoeff_V("kcal", CropRotationCategories_V) = -kcal_ha_agg_V(CropRotationCategories_V);
TechCoeff_V("kcal", CropRotationCategories_V) = -nut_ha_agg_V("Calories (kcal)", CropRotationCategories_V);

*other nutrients
*Carbohydrates, "dietary fibres", Protein, Fat, "Saturated FA", LA, VitA, VitB2, ALA, VitB3, VitD, Potassium, Iron, VitB12, Calcium, Zinc, Selenium
TechCoeff_V("Carbohydrates", CropRotationCategories_V) = -nut_ha_agg_V("Carbohydrate, by difference (g)", CropRotationCategories_V);
TechCoeff_V("dietary fibres", CropRotationCategories_V) = -nut_ha_agg_V("Fiber, total dietary (g)", CropRotationCategories_V);
*conversion into g
TechCoeff_V("Protein", CropRotationCategories_V) = -nut_ha_agg_V("Protein (t)", CropRotationCategories_V)*1000*1000;
TechCoeff_V("Fat", CropRotationCategories_V) = -nut_ha_agg_V("Fat (t)", CropRotationCategories_V)*1000*1000;
*TechCoeff_V("Saturated FA", CropRotationCategories_V) = -nut_ha_agg_V("Fatty acids, total saturated (g)", CropRotationCategories_V);
TechCoeff_V("LA", CropRotationCategories_V) = -nut_ha_agg_V("18:2 n-6 c,c (g)", CropRotationCategories_V);
*add here conversion factor: 1 IU = 0.3ug Retinol
TechCoeff_V("VitA", CropRotationCategories_V) = -nut_ha_agg_V("Vitamin A, IU (IU)", CropRotationCategories_V)/0.3;
TechCoeff_V("VitB2", CropRotationCategories_V) = -nut_ha_agg_V("Riboflavin (mg)", CropRotationCategories_V);
TechCoeff_V("ALA", CropRotationCategories_V) = -nut_ha_agg_V("18:3 n-3 c,c,c (ALA) (g)", CropRotationCategories_V);
TechCoeff_V("VitB3", CropRotationCategories_V) = -nut_ha_agg_V("Niacin (mg)", CropRotationCategories_V);
*TechCoeff_V("VitD", CropRotationCategories_V) = -nut_ha_agg_V("Vitamin D (D2 + D3) (ug)", CropRotationCategories_V);
TechCoeff_V("Potassium", CropRotationCategories_V) = -nut_ha_agg_V("Potassium, K (mg)", CropRotationCategories_V);
TechCoeff_V("Iron", CropRotationCategories_V) = -nut_ha_agg_V("Iron, Fe (mg)", CropRotationCategories_V);
*TechCoeff_V("VitB12", CropRotationCategories_V) = -nut_ha_agg_V("Vitamin B-12 (ug)", CropRotationCategories_V);
TechCoeff_V("Calcium", CropRotationCategories_V) = -nut_ha_agg_V("Calcium, Ca (mg)", CropRotationCategories_V);
TechCoeff_V("Zinc", CropRotationCategories_V) = -nut_ha_agg_V("Zinc, Zn (mg)", CropRotationCategories_V);
TechCoeff_V("Selenium", CropRotationCategories_V) = -nut_ha_agg_V("Selenium, Se (ug)", CropRotationCategories_V);
TechCoeff_V("Copper", CropRotationCategories_V) = -nut_ha_agg_V('Copper, Cu (mg)', CropRotationCategories_V);
TechCoeff_V("Magnesium", CropRotationCategories_V) = -nut_ha_agg_V('Magnesium, Mg (mg)', CropRotationCategories_V);
TechCoeff_V("Manganese", CropRotationCategories_V) = -nut_ha_agg_V('Manganese, Mn (mg)', CropRotationCategories_V);
TechCoeff_V("Phosphorous", CropRotationCategories_V) = -nut_ha_agg_V('Phosphorus, P (mg)', CropRotationCategories_V);
TechCoeff_V("Thiamin", CropRotationCategories_V) = -nut_ha_agg_V('Thiamin (mg)', CropRotationCategories_V);
TechCoeff_V("VitB6", CropRotationCategories_V) = -nut_ha_agg_V('Vitamin B-6 (mg)', CropRotationCategories_V);
TechCoeff_V("VitC", CropRotationCategories_V) = -nut_ha_agg_V('Vitamin C, total ascorbic acid (mg)', CropRotationCategories_V);





*2.2 agronomical constraints
************************************************************************************
*$ontext
*Maximum share of grains: 50% 
TechCoeff_V("maxGrains", "Cereals1_V")
        = 1;
TechCoeff_V("maxGrains", "Cereals2_V")
        = 1;
TechCoeff_V("maxGrains", "Pulses_V")
        = -1;
TechCoeff_V("maxGrains", "Oilcrops_V")
        = -1;
TechCoeff_V("maxGrains", "Vegetables")
        = -1;
TechCoeff_V("maxGrains", "StarchyRoots")
        = -1;
TechCoeff_V("maxGrains", "Fruits_V")
        = -1;    
TechCoeff_V("maxGrains", "SetAside_V")
        = -1;

*Maximum share of legumes: 35% 
TechCoeff_V("maxPulses", "Cereals1_V")
        = -0.35;
TechCoeff_V("maxPulses", "Cereals2_V")
        = -0.35;
TechCoeff_V("maxPulses", "Pulses_V")
        = 0.65;
TechCoeff_V("maxPulses", "Oilcrops_V")
        = -0.35;
TechCoeff_V("maxPulses", "Vegetables")
        = -0.35;
TechCoeff_V("maxPulses", "StarchyRoots")
        = -0.35;
TechCoeff_V("maxPulses", "Fruits_V")
        = -0.35;    
TechCoeff_V("maxPulses", "SetAside_V")
        = -0.35;
        
*Minimum share of set aside: 10% 
TechCoeff_V("minSetAside", "Cereals1_V")
        = 0.1;
TechCoeff_V("minSetAside", "Cereals2_V")
        = 0.1;
TechCoeff_V("minSetAside", "Pulses_V")
        = 0.1;
TechCoeff_V("minSetAside", "Oilcrops_V")
        = 0.1;
TechCoeff_V("minSetAside", "Vegetables")
        = 0.1;
TechCoeff_V("minSetAside", "StarchyRoots")
        = 0.1;
TechCoeff_V("minSetAside", "Fruits_V")
        = 0.1;    
TechCoeff_V("minSetAside", "SetAside_V")
        = -0.9;
        
*Minimum share of set aside and grain legumes: 20% 
TechCoeff_V("minLegumes", "Cereals1_V")
        = 0.2;
TechCoeff_V("minLegumes", "Cereals2_V")
        = 0.2;
TechCoeff_V("minLegumes", "Pulses_V")
        = -0.8;
TechCoeff_V("minLegumes", "Oilcrops_V")
        = 0.2;
TechCoeff_V("minLegumes", "Vegetables")
        = 0.2;
TechCoeff_V("minLegumes", "StarchyRoots")
        = 0.2;
TechCoeff_V("minLegumes", "Fruits_V")
        = 0.2;    
TechCoeff_V("minLegumes", "SetAside_V")
        = -0.8;

*Maximum share of oilcrops: 33% 
TechCoeff_V("maxOil", "Cereals1_V")
        = -0.33;
TechCoeff_V("maxOil", "Cereals2_V")
        = -0.33;
TechCoeff_V("maxOil", "Pulses_V")
        = -0.33;
TechCoeff_V("maxOil", "Oilcrops_V")
        = 0.67;
TechCoeff_V("maxOil", "Vegetables")
        = -0.33;
TechCoeff_V("maxOil", "StarchyRoots")
        = -0.33;
TechCoeff_V("maxOil", "Fruits_V")
        = -0.33;    
TechCoeff_V("maxOil", "SetAside_V")
        = -0.33;
*$offtext


************************************************************************
*New 23.06.2021: Nitrogen Fixation - since the values are all 0 in input and output dataframe -> no effect...

*N_fixation / ha = N_fixation/tonMainOutput * tonMainOutput/ha
************************************************************************
*$ontext

*Calculate N Outputs and N-inputs (fixation)
*
*ActCropsGrass_Outputs_MR(Countries,Cereals1_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")
*ActCropsGrass_Inputs_MR(Countries,Pulses_V,"N fixation (tN)","AllProdSyst","AllProdCond","BaselineDerived")
*ActCropsGrass_OtherChar_MR(Regions_MR,Activities_MR,"N in MainOutput1 (tN)",ProductionSystems,ProductionConditions,Scenarios)


*Cereals 1
TechCoeff_V("NitrogenFix", "Cereals1_V")
        = 0.5*sum(
            Cereals1_V$(sum(Countries$(ActCropsGrass_OtherChar_MR(Countries,Cereals1_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_OtherChar_MR(Countries ,Cereals1_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")
                        *ActCropsGrass_Outputs_MR(Countries,Cereals1_V,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")
                )
                / sum(Countries$(ActCropsGrass_OtherChar_MR(Countries,Cereals1_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived") AND ActCropsGrass_Outputs_MR(Countries,Cereals1_V,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Cereals1_V"),1);
            
***delete later
Parameter count_test;
count_test = sum(Crops$MatchCropsCategories_V(Crops, "Cereals1_V"),1);

execute_unload 'count' count_test;
****

*Cereals 2
TechCoeff_V("NitrogenFix", "Cereals2_V")
        = 0.5*sum(
            Cereals2_V$(sum(Countries$(ActCropsGrass_OtherChar_MR(Countries,Cereals2_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_OtherChar_MR(Countries ,Cereals2_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")
                        *ActCropsGrass_Outputs_MR(Countries,Cereals2_V,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")
                )
                / sum(Countries$(ActCropsGrass_OtherChar_MR(Countries ,Cereals2_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived") AND ActCropsGrass_Outputs_MR(Countries,Cereals2_V,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Cereals2_V"),1);
    


*Pulses
TechCoeff_V("NitrogenFix", "Pulses_V")
        = - sum(
            Pulses_V$(sum(Countries$(ActCropsGrass_Inputs_MR(Countries,Pulses_V,"N fixation (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_Inputs_MR(Countries,Pulses_V,"N fixation (tN)","AllProdSyst","AllProdCond","BaselineDerived")
                        - ActCropsGrass_OtherChar_MR(Countries ,Pulses_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")
                        *ActCropsGrass_Outputs_MR(Countries,Pulses_V,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")

                )
                / sum(Countries$(ActCropsGrass_OtherChar_MR(Countries ,Pulses_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived") AND ActCropsGrass_Outputs_MR(Countries,Pulses_V,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Pulses_V"),1);
    


*Oilcrops
TechCoeff_V("NitrogenFix", "Oilcrops_V")
        = 0.5*sum(
            Oilcrops_V$(sum(Countries$(ActCropsGrass_OtherChar_MR(Countries,Oilcrops_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_OtherChar_MR(Countries ,Oilcrops_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")
                        *ActCropsGrass_Outputs_MR(Countries,Oilcrops_V,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")
                )
                / sum(Countries$(ActCropsGrass_OtherChar_MR(Countries,Oilcrops_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived") AND ActCropsGrass_Outputs_MR(Countries,Oilcrops_V,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Oilcrops_V"),1);
    




*Vegetables
TechCoeff_V("NitrogenFix", "Vegetables")
        = 0.5*sum(
            Vegetables$(sum(Countries$(ActCropsGrass_OtherChar_MR(Countries,Vegetables,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_OtherChar_MR(Countries,Vegetables,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")
                        *ActCropsGrass_Outputs_MR(Countries,Vegetables,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")
                )
                / sum(Countries$(ActCropsGrass_OtherChar_MR(Countries,Vegetables,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived") AND ActCropsGrass_Outputs_MR(Countries,Vegetables,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Vegetables"),1);
    


*Starchy Roots
TechCoeff_V("NitrogenFix", "StarchyRoots")
        = 0.5*sum(
            StarchyRoots$(sum(Countries$(ActCropsGrass_OtherChar_MR(Countries,StarchyRoots,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_OtherChar_MR(Countries,StarchyRoots,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")
                        *ActCropsGrass_Outputs_MR(Countries,StarchyRoots,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")
                )
                / sum(Countries$(ActCropsGrass_OtherChar_MR(Countries,StarchyRoots,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived") AND ActCropsGrass_Outputs_MR(Countries,StarchyRoots,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "StarchyRoots"),1);
    


*Fruits
TechCoeff_V("NitrogenFix", "Fruits_V")
        = 0.5*sum(
            Fruits_V$(sum(Countries$(ActCropsGrass_Outputs_MR(Countries,Fruits_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                        ActCropsGrass_OtherChar_MR(Countries,Fruits_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived")
                        *ActCropsGrass_Outputs_MR(Countries,Fruits_V,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")
                )
                / sum(Countries$(ActCropsGrass_OtherChar_MR(Countries,Fruits_V,"N in MainOutput1 (tN)","AllProdSyst","AllProdCond","BaselineDerived") AND ActCropsGrass_Outputs_MR(Countries,Fruits_V,"MainOutput1 (t)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "Fruits_V"),1);
    

*Set Aside
TechCoeff_V("NitrogenFix", "SetASide_V")
        = - sum(
            SetAside_V$(sum(Countries$(ActCropsGrass_Inputs_MR(Countries ,SetASide_V,"N fixation (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )),
                sum(
                Countries,
                    ActCropsGrass_Inputs_MR(Countries ,SetASide_V,"N fixation (tN)","AllProdSyst","AllProdCond","BaselineDerived")    
*                    - ActCropsGrass_Outputs_MR(Countries,SetASide_V,"N outputs - crops (tN)","AllProdSyst","AllProdCond","BaselineDerived")  - we neglect here the output to calculate the potential (full use of crop residue N)
                )
                / sum(Countries$(ActCropsGrass_Inputs_MR(Countries ,SetASide_V,"N fixation (tN)","AllProdSyst","AllProdCond","BaselineDerived")),1 )
            )
            / sum(Crops$MatchCropsCategories_V(Crops, "SetAside_V"),1);
    
*$offtext

execute_unload TechCoeff_V;
execute_unload 'outputs' ActCropsGrass_Outputs_MR;
execute_unload 'inputsSetAside'  ActCropsGrass_Inputs_MR;
execute_unload 'otherChar' ActCropsGrass_OtherChar_MR;


****************************
*Define vector b (Resources)
****************************

Scalar Total_pop;
*Total_pop = sum(Countries, VPopulationNumbers_MR.l(Countries,"PopulationAll","FOFA_BAU_2050"));
Total_pop = 9750000000;
*Total_pop = sum(Countries, VPopulationNumbers_MR.l(Countries,"PopulationAll","Baseline"));
execute_unload 'pop' Total_pop;

*delete this number later..

Parameter b(constraint_type_V) Resources available or necessary (but here some are set to zero) - ; 
b("kcal") = -365*2400*Total_pop + permNutrients("Calories (kcal)");
b("Carbohydrates") = -365*270*Total_pop + permNutrients("Carbohydrate, by difference (g)");
b("dietary fibres")= -365*25*Total_pop + permNutrients("Fiber, total dietary (g)");
b("Protein")= -365*66.4*Total_pop + permNutrients("Protein (t)");
b("Fat")= -365*53.3*Total_pop + permNutrients("Fat (t)");
*b("Saturated FA")
b("LA")= -365*10.56*Total_pop + permNutrients("18:2 n-6 c,c (g)");
b("VitA")= -365*700*Total_pop + permNutrients("Vitamin A, IU (IU)");
b("VitB2")= -365*1.3*Total_pop + permNutrients("Riboflavin (mg)");
b("ALA")= -365*2.7*Total_pop + permNutrients("18:3 n-3 c,c,c (ALA) (g)");
b("VitB3")= -365*16.5*Total_pop + permNutrients("Niacin (mg)");
*b("VitD")= -365*15*Total_pop;
b("Potassium")= -365*3500*Total_pop + permNutrients("Potassium, K (mg)");
b("Iron")= -365*11*Total_pop + permNutrients("Iron, Fe (mg)");
*b("VitB12")
b("Calcium")= -365*950*Total_pop + permNutrients("Calcium, Ca (mg)");
b("Zinc")= -365*8.45*Total_pop + permNutrients("Zinc, Zn (mg)");
b("Selenium")= -365*70*Total_pop + permNutrients("Selenium, Se (ug)");
*new
b("Copper")= -365*1.45*Total_pop + permNutrients("Copper, Cu (mg)");
b("Magnesium")= -365*325*Total_pop + permNutrients("Magnesium, Mg (mg)");
b("Manganese")= -365*3*Total_pop + permNutrients("Manganese, Mn (mg)");
b("Phosphorous")= -365*550*Total_pop + permNutrients("Phosphorus, P (mg)");
b("Thiamin")= -365*1*Total_pop + permNutrients("Thiamin (mg)");
b("VitB6")= -365*1.6*Total_pop + permNutrients("Vitamin B-6 (mg)");
b("VitC")= -365*102.5*Total_pop + permNutrients("Vitamin C, total ascorbic acid (mg)");



b("maxGrains") = 0;
b("maxPulses") = 0;
b("minSetAside") = 0;
b("minLegumes") = 0;
b("maxOil") = 0;

b("NitrogenFix") = 0;


execute_unload 'b' b;


*add here max values for nutrients
Parameter b2(constraint_type_V) Resources available or necessary (but here some are set to zero) - ; 
*b("kcal") = -365*2500*Total_pop;
b2("Carbohydrates") = 365*360*Total_pop;
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

POSITIVE VARIABLES INVEST(CropRotationCategories_V)   HA "INVESTED" IN EACH STOCK;

VARIABLE    OBJ     Minimize area;
*Variable testeq1(constraint_type_V);
*Variable eq2(constraint_type_V2);


***************EQUATIONS**********************************

EQUATIONS   OBJJ       OBJECTIVE FUNCTION
            CONSTEQ(constraint_type_V)    Technical Coefficients (Ax <= b)
*            CONSTEQ2(constraint_type_V2)    Further constraints (if range necessary)
*            testeq(constraint_type_V)
            ;
            

*objective function Z = sum over ha -> Total area
OBJJ.. OBJ =e= SUM(CropRotationCategories_V, INVEST(CropRotationCategories_V));

*first equation: min values & agronomical constraints
CONSTEQ(constraint_type_V).. Sum(CropRotationCategories_V, TechCoeff_V(constraint_type_V, CropRotationCategories_V)*Invest(CropRotationCategories_V)) =l= b(constraint_type_V);

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

Parameter whereisthebug(constraint_type_V);
*Parameter whereisthebug2(constraint_type_V);
whereisthebug(constraint_type_V) = Sum(CropRotationCategories_V, -TechCoeff_V(constraint_type_V, CropRotationCategories_V)*Invest.l(CropRotationCategories_V));
*whereisthebug2(constraint_type_V2) = Sum(CropRotationCategories_V, -TechCoeff_V(constraint_type_V2, CropRotationCategories_V)*Invest.l(CropRotationCategories_V));
execute_unload 'bug' whereisthebug;
*execute_unload 'bug2' whereisthebug2;

Scalar whereisthebugN;
whereisthebugN = whereisthebug("NitrogenFix");
execute_unload 'bugN' whereisthebugN;