PUTCLOSE con,"_V6_ReadData_VariousSources_MainOutputNutrientContentsData";

$ontext;
GENERAL DESCRIPTION
This file reads and/or assigns the nutrient contents data of the main output of the items (activities):
        Main output nutrient contents data

DETAILED TABLE OF CONTENTS
- 1) Data from various sources: crops
        1.1) Crop main output N contents
        1.2) Crop main output P2O5 contents
        1.3) Crop main output DM contents
        1.4) Crop main output GE contents
        1.5) Crop main output XP contents
- 2) Data from various sources: Animals
        2.1) Animal main output N contents
        2.2) Animal main output P2O5 contents
        2.3) Animal main output DM contents
        2.4) Animal main output GE contents
        2.5) Animal main output XP contents
- 3) IPCC 2006
- 4) USDA
- 5) Belitz et al. 2009, Food Chemistry, Springer
- 6) Assign values to core model parameters and variables
         6.1) Link some sets as needed
         6.2) Link to the core model parameters
         6.3) Assign values for NON_FAOSTAT_CropPRoductionItems
                 6.3.1) N contents
                 6.3.2) P2O5 contents
                 6.3.3) DM contents
                 6.3.4) some further data for other forage plants
- 7) Load SOLmV5 data - to be improved later
- 8) Define additional feed data
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Data from various sources: crops

*This data is read from a specific file, then several values are adjusted, completed directly in the code below.
*in this file read in in earlier SOLm-Versions, values for K and C are dummies only and we thus drop them already in the excel sheet - thus: only N and P2O5 values are read in.
*the values in the file also refer to crops only, therefore no "outputtype" dimension is needed, as we dropped the empty columns for animal products as well.

*general: P is in P2O5 and K in K2O;
*Units: N,P2O5,K2O,C contents in quantities, i.e. rations: 0.007=0.7% = 0.007 tons / ton, etc.)
*these shares are currently set globally in the excel files

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewVariousSourcesMainOutputNutrientContentsData% == "YES"
$call GDXXRW VariousSources_MainOutputNutrientContents_28_8_2016.xlsx  o=VariousSources_MainOutputNutrientContents_28_8_2016.gdx  index=index!a1:e15
$endif;

$ontext;
*the following items from FAOSTAT_CropProductionItems have no values in the excel-sheets filed in above:

Cassava leaves
Cereals (Rice Milled Eqv)
Cereals,Total
Coarse Grain, Total
Cotton lint
Cottonseed
Fibre Crops Primary
Fruit excl Melons,Total
Citrus fruit, total
Fruit, pome nes
Jojoba seed
Jute & Jute-like Fibres
Kapok fibre
Kapokseed in shell
Leeks, other alliaceous vegetables
Oil, palm
Oilcakes Equivalent
Oilcrops Primary
Palm kernels
Pulses,Total
Roots and Tubers,Total
Tallowtree seed
Treenuts,Total
Vegetables Primary
Vegetables&Melons, Total

$offtext;


Parameter VariousSources_MainOutput_NContents(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_MainOutput_PContents(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_MainOutput_DMContents(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_MainOutput_GEContents(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_MainOutput_XPContents(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);

$gdxin VariousSources_MainOutputNutrientContents_28_8_2016.gdx
$load VariousSources_MainOutput_NContents
$load VariousSources_MainOutput_PContents
$gdxin
*UNIT:  tons N, P2O5/ton


*1.1) Main output N contents

*first improve the values for some specific crops:

*from feedipedia, 0.871 DM, 11.8%XP, 0.16 conversion XP to N
VariousSources_MainOutput_NContents(FAOSTAT_Countries,"Wheat") = 0.0164;
*from feedipedia, 0.87 DM, 12.6%XP, 0.16 conversion XP to N
VariousSources_MainOutput_NContents(FAOSTAT_Countries,"Barley") = 0.0175;



*1.2) Main output P2O5 contents
* P->P2O5 is *2.29157 (2*30.97+5*16)/(2*30.97)

*first improve the values for some specific crops:

*feedipedia, 3.6gP/kgDM, thus 0.0036*2.29157tP2O5 *0.87   /t fresh matter
VariousSources_MainOutput_PContents(FAOSTAT_Countries,"Wheat") = 0.00718;
*feedipedia, 3.9gP/kgDM, thus 0.0039*2.29157tP2O5 *0.871   /t fresh matter
VariousSources_MainOutput_PContents(FAOSTAT_Countries,"Barley") = 0.00778;



*1.3) Main output DM contents
*DM contents from crop products
*this is a first gross assignment of DM contents of harvested products, based on
*        table 11.2 IPCC 2006, volume 11: grains (0.88), Beans and Pulses (0.91), Tubers (0.22).
*        and then we added what has been used in earlier versions of SOLm,
*        but better numbers are provided below, based on the tables in Belitz et al. 2009, Food Chemistry, Springer
*unit: tons per ton, i.e. 0.88 is 88%

VariousSources_MainOutput_DMContents(FAOSTAT_Countries,SOLmOld_Treenuts) = 0.91;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,SOLmOld_Grains) = 0.89;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,SOLmOld_Pulses) = 0.91;

VariousSources_MainOutput_DMContents(FAOSTAT_Countries,SOLmOld_Oil_Crops) = 0.91;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,SOLmOld_Starchy_roots) = 0.22;
*from feedipedia
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Cassava") = 0.376;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,SOLmOld_Sugars_And_Sweeteners) = 0.22;

VariousSources_MainOutput_DMContents(FAOSTAT_Countries,SOLmOld_Fruits) = 0.3;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,SOLmOld_Vegetables) = 0.3;

VariousSources_MainOutput_DMContents(FAOSTAT_Countries,SOLmOld_Stimulants_Spices) = 0.9;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,SOLmOld_Fibres_Rubber) = 0.9;



VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Buckwheat") = 0.892;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Coconuts") = 0.507;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Linseed") = 0.915;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Mustard seed")
         = VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Rapeseed");
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Safflower seed") = 0.9;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Sugar beet") = 0.188;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Sugar cane") = 0.232;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Yams") = 0.262;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Sweet potatoes") = 0.3;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Bananas") = 0.219;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Tomatoes") = 0.073;


$ontext;
Products yet missing in FAOSTAT CROP PRod:
*feedipedia:
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Maize For Forage+Silage") = 0.233;

VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Rice, Broken") = 0.87;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Sugar, Raw Equivalent") = 0.99;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Oil, linseed") = 1;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Alfalfa Meal and Pellets") = 0.9;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Dregs from brewing, distillation") = 0.9;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Wheat Gluten") = 0.9;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Maize Gluten") = 0.9;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Molasses") = 0.34;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Soyabean cake") = 0.89;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Sunflowerseed cake") = 0.89;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Rape and Mustard cake") = 0.89;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Beets for Fodder") = 0.19;
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Byprod from Vegetables: leaves, tops") = 0.14;

*then assign some values for forage crops from feedipedia: take the crops that have already FeedME etc. (not really sure, the ME values are assigned below)
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Alfalfa For Forage+Silag") = 0.25;
*alfalfa values: average from "aeral parts, fresh" and "silage"
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Vegetables+Roots,Fodder") = 0.25;
*no source - use average of general DM values for vegetables/roots
VariousSources_MainOutput_DMContents(FAOSTAT_Countries,"Hay (unspecified)") = 0.2;
*Dactylis glomerata - or the general value assumed for grass

$offtext;


*1.4) Main output GE contents
*units: MJ GE/ton: GE contents from crop products

*this is taken from INRA feed data: https://www.feedtables.com/content/table-as-fed
*on 26.9.2018
*where no 1:1-correspondence in commodities has been given, we used some average value.
*for pulses, we used the values for "Pea", for Beans, dry we used the values for "Common bean"
*GE: units: MJ/ton
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Barley") = 16000;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Beans, dry") = 16200;
*from feedipedia:
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Cassava") = 17100*0.376;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Maize") = 16100;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Millet") = 17300;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Oats") = 17100;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Pulses, nes") = 16000;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Pulses,Total") = 16000;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Rapeseed") = 26800;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Rice, paddy") = 15600;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Rye") = 15600;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Seed cotton") = 21900;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Sorghum") = 16500;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Soybeans") = 21000;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Sunflower seed") = 26600;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Triticale") = 15700;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Wheat") = 16000;

$ontext;
Products yet missing in FAOSTAT CROP PRod:
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Alfalfa meal and pellets") = 17000;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Beets For Fodder") = 2700;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Dregs from brewing, distillation") = 18400;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Rape and Mustard Cake") = 18500;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Rice, Broken") = 15800;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Soyabean Cake") = 17300;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Sunflowerseed Cake") = 18500;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Wheat Gluten") = 21400;
$offtext;


*add some further/better data as available from the AP (cf. Steering 3):
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Potatoes") = 3735;

$ontext;
Products yet missing in FAOSTAT CROP PRod:
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Cereals - Excluding Beer") = 15878;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Rice, Broken") = 15404;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Sugar, Raw Equivalent") = 15959;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Oil, linseed") = 39300;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Alfalfa Meal and Pellets") = 16209;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Wheat and products") = 16198;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Dregs from brewing, distillation") = 18646;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Wheat Gluten") = 20310;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Maize Gluten") = 20310;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Molasses") = 5928;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Soyabean cake") = 17986;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Sunflowerseed cake") = 17986;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Rape and Mustard cake") = 17986;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Beets for Fodder") = 3158;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Maize for Forage+Silage") = 5658;
*VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Byprod from Vegetables: leaves, tops") = 2311;
VariousSources_CropCommodityBalances_GEContents(FAOSTAT_CountriesAndRegions,"Alfalfa For Forage+Silag") = 18100*0.25;
*alfalfa values: average from "aeral parts, fresh" and "silage"
$offtext;

*and add some further data that is very wrong when infiled from the WOSY data (cf. __SOLmV5_ReadData_FAOSTAT_WOSY_DetailedFBS)
*data: feedipedia or set equal to something else; Buckwheat - take Quinoa, as BW is missing in feedipedia
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Buckwheat") = 19400*0.892;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Coconuts") = 32100*0.507;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Linseed") = 27100*0.915;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Mustard seed")
         = VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Rapeseed");
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Safflower seed") = 21000*0.9;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Sugar beet") = 16900*0.188;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Sugar cane") = 18200*0.232;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Yams") = 17100*0.262;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Sweet potatoes") = 17400*0.3;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Bananas") = 17100*0.219;
VariousSources_MainOutput_GEContents(FAOSTAT_Countries,"Tomatoes") = 5100/0.65*0.073;


*1.5) Main output XP contents
*units: ton XP/ton: XP contents from crop products

*this is taken from INRA feed data: https://www.feedtables.com/content/table-as-fed
*on 26.9.2018
*where no 1:1-correspondence in commodities has been given, we used some average value.
*for pulses, we used the values for "Pea", for Beans, dry we used the values for "Common bean"

*XP: *units: ton/ton
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Barley") = 0.098;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Beans, dry") = 0.22;
*from feedipedia
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Cassava") = 0.026*0.376;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Maize") = 0.076;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Millet") = 0.12;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Oats") = 0.094;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Pulses, nes") = 0.204;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Pulses,Total") = 0.204;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Rapeseed") = 0.187;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Rice, paddy") = 0.075;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Rye") = 0.085;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Seed cotton") = 0.202;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Sorghum") = 0.092;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Soybeans") = 0.355;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Sunflower seed") = 0.148;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Triticale") = 0.10;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Wheat") = 0.126;

$ontext;
Products yet missing in FAOSTAT CROP PRod:
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Alfalfa meal and pellets") = 0.20;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Beets For Fodder") = 0.011;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Dregs from brewing, distillation") = 0.239;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Rape and Mustard Cake") = 0.325;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Rice, Broken") = 0.079;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Soyabean Cake") = 0.46;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Sunflowerseed Cake") = 0.29;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Wheat Gluten") = 0.802;
$offtext;


*add some further/better data as available from the AP (cf. Steering 3):
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Potatoes") = 0.021;

$ontext;
Products yet missing in FAOSTAT CROP PRod:
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Cereals - Excluding Beer") = 0.109;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Rice, Broken") = 0.077;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Sugar, Raw Equivalent") = 0;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Oil, linseed") = 0;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Alfalfa Meal and Pellets") = 0.176;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Wheat and products") = 0.148;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Dregs from brewing, distillation") = 0.214;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Wheat Gluten") = 0.621;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Maize Gluten") = 0.621;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Molasses") = 0.035;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Soyabean cake") = 0.408;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Sunflowerseed cake") = 0.408;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Rape and Mustard cake") = 0.408;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Beets for Fodder") = 0.013;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Maize for Forage+Silage") = 0.024;
*VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Byprod from Vegetables: leaves, tops") = 0.02;
VariousSources_CropCommodityBalances_XPContents(FAOSTAT_CountriesAndRegions,"Alfalfa For Forage+Silag") = 0.2*0.25;
*alfalfa values: average from "aeral parts, fresh" and "silage"
$offtext;


*and add some further data that is very wrong when infiled from the WOSY data (cf. __SOLmV5_ReadData_FAOSTAT_WOSY_DetailedFBS)
*data: feedipedia or set equal to something else; Buckwheat - take Quinoa, as BW is missing in feedipedia
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Buckwheat") = 0.152*0.892;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Coconuts") = 0.086*0.507;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Linseed") = 0.237*0.915;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Mustard seed")
         = VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Rapeseed");
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Safflower seed") = 0.25*0.9;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Sugar beet") = 0.078*0.188;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Sugar cane") = 0.043*0.232;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Yams") = 0.059*0.262;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Sweet potatoes") = 0.055*0.3;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Bananas") = 0.052*0.219;
VariousSources_MainOutput_XPContents(FAOSTAT_Countries,"Tomatoes") = 0.167*0.073;



*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Pelagic Fish","FeedXP cont (t/t)","AverageProdType","All","Baseline") = 0.635;
*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,'Animal fats',"FeedXP cont (t/t)","AverageProdType","All","Baseline") = 0;
*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Milk, Whole","FeedXP cont (t/t)","AverageProdType","All","Baseline") = 0.015;
*arameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Whey","FeedXP cont (t/t)","AverageProdType","All","Baseline") = 0.015;





****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Data from various sources: animals


Parameter VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems);
Parameter VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems);
Parameter VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems);
Parameter VariousSources_AnimalProductMainOutput_GEContents(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems);
Parameter VariousSources_AnimalProductMainOutput_XPContents(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems);


*Animal product main output N, P2O5, DM, GE and XP contents
*below, ad-hoc numbers as used in SOLm up to version V4
*not from one consistent source, etc.
*units again: N and P2O5 contents in fresh matter
*        P->P2O5 is *2.29157 (2*30.97+5*16)/(2*30.97)
*the values for milk, meat, etggs are taken from the document Spiess_NutrCyclAgroecosyst2011.pdf:

*2.1) Animal main output N contents

*N content of meat: 3.6%: value suggested by Simon in Alpenprojekt, instead of 0.033 which I had before
*finally, taken from v92n4-6a11.pdf
VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_Meat)         = 0.036;
VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_PoultryMeat)  = 0.031;
VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_Milk)         = 0.005;
VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,"Milk, whole fresh sheep") = 0.0083;
VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,"Milk, whole fresh goat")  = 0.0058;

VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_Eggs)         = 0.018;
*CHECK HIDES N and P contents, get better values....
VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_HidesSkinsHair) = 0.08;
*N and P for honey is missing - thus just assume something....
VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,"Honey, natural")  = 0.005;

*offals and snails: assume similar to general meat, somehwat less for snails and offals
VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,"Offals, nes")     = 0.036;
VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,"Snails, not sea") = 0.036;
*silk: assume similar to hides, etc.
VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,"Silk-worm cocoons, reelable")  = 0.08;


*2.2) Animal main output P2O5 contents

VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_Meat)         = 0.017;
VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_PoultryMeat)  = 0.018;
VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_Milk)         = 0.0022915;
VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,"Milk, whole fresh sheep") = 0.0022;
VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,"Milk, whole fresh goat")  = 0.0022;
VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_Eggs)         = 0.0041;
*the hides value is P2O5 (suslive_data_new10), the other is unclear, they are named P (in form of phosphate PO4 = 30.97+4*16 = 94.97)....
*thus we assume that they are in PO4 and convert accordingly via /(1*30.97+4*16)*(2*30.97+5*16)=1.494577
*CHECK HIDES N and P contents, get better values....
VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_HidesSkinsHair) = 0.0023;
*the last one is in P2O5 already

*N and P for honey is missing - thus just assume something....
VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,"Honey, natural")  = 0.005;

*offals and snails: assume similar to general meat, somehwat less for snails and offals
VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,"Offals, nes")     = 0.017;
VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,"Snails, not sea") = 0.017;
*silk: assume similar to hides, etc.
VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,"Silk-worm cocoons, reelable")  = 0.0023;

*2.3) Animal main output DM contents

*Animal product DM contents:
*To derive dry mater FeedME contents for concentrates from animal products, we need dry matter shares for meat and milk of various animals.
*We set the corresponding values here, they are taken/derived from the Sheet NutContFeed_FullWOSYDetail in suslive_data_new_V2
*XXXXXXXXXXXXXXXXXX CHECK DM contents eggs in this data set: we have 0.99, this cannot be
*        - change this to 0.25 - does this have consequences for the R calculations?
*and all this data: to be improved!!

VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_Meat)         = 0.4;


VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_Milk)         = 0.09;
*that is 0.001 P

VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_Eggs)         = 0.25;
*Source for this latter: http://www.aqa.org.ar/pdf9702/9702art3.pdf

*DM share, assume alsmost 1 for skins, etc. but not based on references - thus to be improved
VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems_HidesSkinsHair) = 0.95;

*DM for honey: assume 1
VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_Countries,"Honey, natural")  = 1;
VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,"Beeswax")         = 0.005;
VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,"Beeswax")         = 0.005;
*DM for wax: assume 1
VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_Countries,"Beeswax")         = 1;

*offals and snails: assume similar to general meat, somehwat less for snails and offals
VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_Countries,"Offals, nes")     = 0.35;
VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_Countries,"Snails, not sea") = 0.3;
*silk: assume similar to hides, etc.
VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_Countries,"Silk-worm cocoons, reelable")  = 1;





*fish and seafood is not in the production, but only in commodity balances - thus drop it here.
*ParameterPerTon(FAO_Countries_NEW,SET_ActGroup_FishAndSeafood_SubGroup,"Meat","MainOutput N cont (tN/t)","All","All","Baseline")    = 0.027;
*ParameterPerTon(FAO_Countries_NEW,SET_ActGroup_FishAndSeafood_SubGroup,"Meat","MainOutput P cont (tP2O5/t)","All","All","Baseline") = 0.002;

*fish and seafood we take to be somewhat lower than meat, therefore 0.3; to be improved...
*ParameterPerTon(FAO_Countries_NEW,SET_ActGroup_FishAndSeafood_SubGroup,"Meat","MainOutput DM cont (tDM/t)","All","All","Baseline")  = 0.3;

*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Pelagic Fish","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.92;
*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,'Animal fats',"DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.99;
*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Milk, Whole","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.08;
*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Whey","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.08;




*2.4) Animal main output GE contents

*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Pelagic Fish","FeedGE cont (MJ/t)","AverageProdType","All","Baseline") = 19036;
*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,'Animal fats',"FeedGE cont (MJ/t)","AverageProdType","All","Baseline") = 39064;
*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Milk, Whole","FeedGE cont (MJ/t)","AverageProdType","All","Baseline") = 1614;
*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Whey","FeedGE cont (MJ/t)","AverageProdType","All","Baseline") = 1614;


*2.5) Animal main output XP contents







****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Data from IPCC 2006 data













****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Data from USDA
*this is from the excel-file: CropNutrientContents-YieldUnitChanges-Oct-03.xlsx
*further details on this excel-file:
$ontext;
This data is taken from the USDA Natural Resources Conservation Services
It is the crop nutrient database downloaded at: https://plants.usda.gov/npk/databases/cropnutrientcontents-yieldunitchanges-oct-03.mdb
Acessed: December 16, 2017

The first sheet in this excel-file is the conversion from the original access-database into excel.
        There, all "." have been replaced by "," due to decimal separator sign convention on the laptop used
        Furthermore, all "#DIV/0!" have been replaced by "" (empty cells)
The second sheet is a shortened version of the first sheet, containing the following columns only:
        Crop; ScientificName; AvMoisture%; AvN%(dry); AvP%(dry); AvK%(dry); AvDryMatter%; Protein%(dry)_NAS; Protein%(dry)_F&L; Protein%(dry)_F&N
        We include the source-specific protein values ("_NAS", etc.), as no average ("Av") is given for those, but the first two seem to cover a considerable amount of crops.
        The sources of the original data can be found here: https://plants.usda.gov/npk/NutrientSources

The third sheet is a further restriction of the second one, reducing the man crops to the ones used in FAOSTAT
        This is done by choosing by hand and by doing averages, where appropriate
$offtext;


*still to be filed in


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) Belitz et al. 2009, Food Chemistry, Springer
*values from various tables in this book:



*still to be filed in





$ontext;
after this, we have:
Parameter VariousSources_MainOutput_NContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter VariousSources_MainOutput_PContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter VariousSources_MainOutput_DMContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems);
Parameter VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems);
Parameter VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems);
$offtext;





****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) Assign values to core model parameters and variables
*6.1) Link some sets as needed
*nutrient contents etc. is assigned to commodities only, not to activities, as they refer to the main outputs from activities only, which are commodities, not activities, in the new undertanding of the variables in SOLm.

Set MatchFAOSTATLivestockPrimary_Commodities(FAOSTAT_LivestockPrimaryItems,Commodities)
*TO BE CHECKED AGAIN: is the "indigenous" item really the best estimate for domestic production? I think so, but check the definitions again.
*        and do we loose something significant by dropping some of the items?

*we assign all values for birds different than chicken to "Pigeons, other birds" (and not to "poultry birds").
*we drop values that seem aggregates of other to avoid double counting
/
*"Beef and Buffalo Meat"
"Beeswax"."Beeswax"
*"Eggs Primary"
"Eggs, hen, in shell"."Eggs, hen, in shell"
*"Eggs, hen, in shell (number)"
"Eggs, other bird, in shell"."Eggs, other bird, in shell"
*"Eggs, other bird, in shell (number)"
*"Hair, horse"
"Hides, buffalo, fresh"."Hides, buffalo, fresh"
"Hides, cattle, fresh"."Hides, cattle, fresh"
"Honey, natural"."Honey, natural"
"Meat indigenous, ass"."Meat, ass"
"Meat indigenous, bird nes"."Meat, birds nes"
"Meat indigenous, buffalo"."Meat, buffaloes"
"Meat indigenous, camel"."Meat, camels"
"Meat indigenous, cattle"."Meat, cattle"
"Meat indigenous, chicken"."Meat, chicken"
"Meat indigenous, duck"."Meat, duck"
"Meat indigenous, geese"."Meat, goose and guinea fowl"
"Meat indigenous, goat"."Meat, goat"
"Meat indigenous, horse"."Meat, horse"
"Meat indigenous, mule"."Meat, mules"
"Meat indigenous, other camelids"."Meat, other camelids"
"Meat indigenous, pig"."Meat, pig"
*"Meat indigenous, poultry"
"Meat indigenous, rabbit"."Meat, rabbit"
"Meat indigenous, rodents"."Meat, other rodents"
"Meat indigenous, sheep"."Meat, sheep"
*"Meat indigenous, total"
"Meat indigenous, turkey"."Meat, turkey"
*"Meat, ass"
*"Meat, bird nes"
*"Meat, buffalo"
*"Meat, camel"
*"Meat, cattle"
*"Meat, chicken"
*"Meat, duck"
*"Meat, game"
*"Meat, goat"
*"Meat, goose and guinea fowl"
*"Meat, horse"
*"Meat, mule"
*"Meat, nes"
*"Meat, other camelids"
*"Meat, other rodents"
*"Meat, pig"
*"Meat, Poultry"
*"Meat, rabbit"
*"Meat, sheep"
*"Meat, Total"
*"Meat, turkey"
"Milk, whole fresh buffalo"."Milk, whole fresh buffalo"
"Milk, whole fresh camel"."Milk, whole fresh camel"
"Milk, whole fresh cow"."Milk, whole fresh cow"
"Milk, whole fresh goat"."Milk, whole fresh goat"
"Milk, whole fresh sheep"."Milk, whole fresh sheep"
*"Milk,Total"
"Offals, nes"."Offals Nes"
*"Pigeons, other birds"
*"Sheep and Goat Meat"
*"Silk-worm cocoons, reelable"
*"Skins, furs"
"Skins, goat, fresh"."Skins, goat, fresh"
"Skins, sheep, fresh"."Skins, sheep, fresh"
*"Skins, sheep, with wool"
*"Snails, not sea"
"Wool, greasy"."Wool, greasy"
/;


Set MatchFAOSTATCropProduction_Commodities(FAOSTAT_CropProductionItems,Commodities)
/
"Agave fibres nes"."Agave fibres nes"
"Almonds, with shell"."Almonds, with shell"
"Anise, badian, fennel, coriander"."Anise, badian, fennel, coriander"
"Apples"."Apples"
"Apricots"."Apricots"
"Areca nuts"."Areca nuts"
"Artichokes"."Artichokes"
"Asparagus"."Asparagus"
"Avocados"."Avocados"
"Bambara beans"."Bambara beans"
"Bananas"."Bananas"
"Barley"."Barley"
"Bastfibres, other"."Bastfibres, other"
"Beans, dry"."Beans, dry"
"Beans, green"."Beans, green"
"Berries nes"."Berries nes"
"Blueberries"."Blueberries"
"Brazil nuts, with shell"."Brazil nuts, with shell"
"Broad beans, horse beans, dry"."Broad beans, horse beans, dry"
"Buckwheat"."Buckwheat"
"Cabbages and other brassicas"."Cabbages and other brassicas"
"Canary seed"."Canary seed"
"Carobs"."Carobs"
"Carrots and turnips"."Carrots and turnips"
"Cashew nuts, with shell"."Cashew nuts, with shell"
"Cashewapple"."Cashewapple"
"Cassava"."Cassava"
"Cassava leaves"."Cassava leaves"
"Castor oil seed"."Castor oil seed"
"Cauliflowers and broccoli"."Cauliflowers and broccoli"
"Cereals (Rice Milled Eqv)"."Cereals (Rice Milled Eqv)"
"Cereals, nes"."Cereals, nes"
*"Cereals,Total"."Cereals,Total"
"Cherries"."Cherries"
"Cherries, sour"."Cherries, sour"
"Chestnut"."Chestnut"
"Chick peas"."Chick peas"
"Chicory roots"."Chicory roots"
"Chillies and peppers, dry"."Chillies and peppers, dry"
"Chillies and peppers, green"."Chillies and peppers, green"
"Cinnamon (canella)"."Cinnamon (canella)"
*"Citrus Fruit,Total"."Citrus Fruit,Total"
"Cloves"."Cloves"
*"Coarse Grain, Total"."Coarse Grain, Total"
"Cocoa, beans"."Cocoa, beans"
"Coconuts"."Coconuts"
"Coffee, green"."Coffee, green"
"Coir"."Coir"
"Cotton lint"."Cotton lint"
"Cottonseed"."Cottonseed"
"Cow peas, dry"."Cow peas, dry"
"Cranberries"."Cranberries"
"Cucumbers and gherkins"."Cucumbers and gherkins"
"Currants"."Currants"
"Dates"."Dates"
"Eggplants (aubergines)"."Eggplants (aubergines)"
"Fibre crops nes"."Fibre crops nes"
"Fibre Crops Primary"."Fibre Crops Primary"
"Figs"."Figs"
"Flax fibre and tow"."Flax fibre and tow"
"Fonio"."Fonio"
*"Fruit excl Melons,Total"."Fruit excl Melons,Total"
"Fruit, citrus nes"."Fruit, citrus nes"
"Fruit, fresh nes"."Fruit, fresh nes"
"Fruit, pome nes"."Fruit, pome nes"
"Fruit, stone nes"."Fruit, stone nes"
"Fruit, tropical fresh nes"."Fruit, tropical fresh nes"
"Garlic"."Garlic"
"Ginger"."Ginger"
"Gooseberries"."Gooseberries"
"Grain, mixed"."Grain, mixed"
"Grapefruit (inc. pomelos)"."Grapefruit (inc. pomelos)"
"Grapes"."Grapes"
"Groundnuts, with shell"."Groundnuts, with shell"
"Gums, natural"."Gums, natural"
"Hazelnuts, with shell"."Hazelnuts, with shell"
"Hemp tow waste"."Hemp tow waste"
"Hempseed"."Hempseed"
"Hops"."Hops"
"Jojoba seed"."Jojoba seed"
"Jute"."Jute"
"Jute & Jute-like Fibres"."Jute & Jute-like Fibres"
"Kapok fibre"."Kapok fibre"
"Kapok fruit"."Kapok fruit"
"Kapokseed in shell"."Kapokseed in shell"
"Karite nuts (sheanuts)"."Karite nuts (sheanuts)"
"Kiwi fruit"."Kiwi fruit"
"Kola nuts"."Kola nuts"
"Leeks, other alliaceous vegetables"."Leeks, other alliaceous vegetables"
"Lemons and limes"."Lemons and limes"
"Lentils"."Lentils"
"Lettuce and chicory"."Lettuce and chicory"
"Linseed"."Linseed"
"Lupins"."Lupins"
"Maize"."Maize"
"Maize, green"."Maize, green"
"Mangoes, mangosteens, guavas"."Mangoes, mangosteens, guavas"
"Manila fibre (abaca)"."Manila fibre (abaca)"
"Maté"."Maté"
*     in the data downloaded from FAOSTAT, it is written "MatÃ©"  *     in the data downloaded from FAOSTAT, it is written "MatÃ©"
"Melons, other (inc.cantaloupes)"."Melons, other (inc.cantaloupes)"
"Melonseed"."Melonseed"
"Millet"."Millet"
"Mushrooms and truffles"."Mushrooms and truffles"
"Mustard seed"."Mustard seed"
"Nutmeg, mace and cardamoms"."Nutmeg, mace and cardamoms"
"Nuts, nes"."Nuts, nes"
"Oats"."Oats"
"Oil, palm"."Oil, palm"
"Oil, palm fruit"."Oil, palm fruit"
*"Oilcakes Equivalent"."Oilcakes Equivalent"
*"Oilcrops Primary"."Oilcrops Primary"
"Oilseeds nes"."Oilseeds nes"
"Okra"."Okra"
"Olives"."Olives"
"Onions, dry"."Onions, dry"
"Onions, shallots, green"."Onions, shallots, green"
"Oranges"."Oranges"
"Palm kernels"."Palm kernels"
"Papayas"."Papayas"
"Peaches and nectarines"."Peaches and nectarines"
"Pears"."Pears"
"Peas, dry"."Peas, dry"
"Peas, green"."Peas, green"
"Pepper (piper spp.)"."Pepper (piper spp.)"
"Peppermint"."Peppermint"
"Persimmons"."Persimmons"
"Pigeon peas"."Pigeon peas"
"Pineapples"."Pineapples"
"Pistachios"."Pistachios"
"Plantains and others"."Plantains and others"
"Plums and sloes"."Plums and sloes"
"Poppy seed"."Poppy seed"
"Potatoes"."Potatoes"
"Pulses, nes"."Pulses, nes"
*"Pulses,Total"."Pulses,Total"
"Pumpkins, squash and gourds"."Pumpkins, squash and gourds"
"Pyrethrum, dried"."Pyrethrum, dried"
"Quinces"."Quinces"
"Quinoa"."Quinoa"
"Ramie"."Ramie"
"Rapeseed"."Rapeseed"
"Raspberries"."Raspberries"
"Rice, paddy"."Rice, paddy"
"Roots and tubers, nes"."Roots and tubers, nes"
*"Roots and Tubers,Total"."Roots and Tubers,Total"
"Rubber, natural"."Rubber, natural"
"Rye"."Rye"
"Safflower seed"."Safflower seed"
"Seed cotton"."Seed cotton"
"Sesame seed"."Sesame seed"
"Sisal"."Sisal"
"Sorghum"."Sorghum"
"Soybeans"."Soybeans"
"Spices, nes"."Spices, nes"
"Spinach"."Spinach"
"Strawberries"."Strawberries"
"String beans"."String beans"
"Sugar beet"."Sugar beet"
"Sugar cane"."Sugar cane"
"Sugar crops, nes"."Sugar crops, nes"
"Sunflower seed"."Sunflower seed"
"Sweet potatoes"."Sweet potatoes"
"Tallowtree seed"."Tallowtree seed"
"Tangerines, mandarins, clementines, satsumas"."Tangerines, mandarins, clementines, satsumas"
"Taro (cocoyam)"."Taro (cocoyam)"
"Tea"."Tea"
"Tobacco, unmanufactured"."Tobacco, unmanufactured"
"Tomatoes"."Tomatoes"
*"Treenuts,Total"."Treenuts,Total"
"Triticale"."Triticale"
"Tung nuts"."Tung nuts"
"Vanilla"."Vanilla"
*"Vegetables Primary". "Vegetables Primary"
*"Vegetables&Melons, Total"."Vegetables&Melons, Total"
"Vegetables, fresh nes"."Vegetables, fresh nes"
"Vegetables, leguminous nes"."Vegetables, leguminous nes"
"Vetches"."Vetches"
"Walnuts, with shell"."Walnuts, with shell"
"Watermelons"."Watermelons"
"Wheat"."Wheat"
"Yams"."Yams"
"Yautia (cocoyam)"."Yautia (cocoyam)"
/;



*6.2) Link to the core model parameters
*livestock primary:
Commod_Contents(Regions,Commodities,"N (t)","AllProdSyst","AllProdCond")
*the condition is needed to avoid this code overwriting values already assigned earlier
                 $(NOT Commod_Contents(Regions,Commodities,"N (t)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(MatchFAOSTATLivestockPrimary_Commodities(FAOSTAT_LivestockPrimaryItems,Commodities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_AnimalProductMainOutput_NContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems));
Commod_Contents(Regions,Commodities,"P2O5 (t)","AllProdSyst","AllProdCond")
*the condition is needed to avoid this code overwriting values already assigned earlier
                 $(NOT Commod_Contents(Regions,Commodities,"P2O5 (t)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(MatchFAOSTATLivestockPrimary_Commodities(FAOSTAT_LivestockPrimaryItems,Commodities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_AnimalProductMainOutput_PContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems));
Commod_Contents(Regions,Commodities,"DM (t)","AllProdSyst","AllProdCond")
*the condition is needed to avoid this code overwriting values already assigned earlier
                 $(NOT Commod_Contents(Regions,Commodities,"DM (t)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(MatchFAOSTATLivestockPrimary_Commodities(FAOSTAT_LivestockPrimaryItems,Commodities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_AnimalProductMainOutput_DMContents(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems));

*crops:
Commod_Contents(Regions,Commodities,"N (t)","AllProdSyst","AllProdCond")
*the condition is needed to avoid this code overwriting values already assigned earlier
                 $(NOT Commod_Contents(Regions,Commodities,"N (t)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFAOSTATCropProduction_Commodities(FAOSTAT_CropProductionItems,Commodities)),
                 VariousSources_MainOutput_NContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems));
Commod_Contents(Regions,Commodities,"P2O5 (t)","AllProdSyst","AllProdCond")
*the condition is needed to avoid this code overwriting values already assigned earlier
                 $(NOT Commod_Contents(Regions,Commodities,"P2O5 (t)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFAOSTATCropProduction_Commodities(FAOSTAT_CropProductionItems,Commodities)),
                 VariousSources_MainOutput_PContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems));
Commod_Contents(Regions,Commodities,"DM (t)","AllProdSyst","AllProdCond")
*the condition is needed to avoid this code overwriting values already assigned earlier
                 $(NOT Commod_Contents(Regions,Commodities,"DM (t)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFAOSTATCropProduction_Commodities(FAOSTAT_CropProductionItems,Commodities)),
                 VariousSources_MainOutput_DMContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems));


*GE, XP contents:
Commod_Contents(Regions,Commodities,"FeedGE (MJ)","AllProdSyst","AllProdCond")
*the condition is needed to avoid this code overwriting values already assigned earlier
                 $(NOT Commod_Contents(Regions,Commodities,"FeedGE (MJ)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFAOSTATCropProduction_Commodities(FAOSTAT_CropProductionItems,Commodities)),
                 VariousSources_MainOutput_GEContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems));
Commod_Contents(Regions,Commodities,"FeedXP (t)","AllProdSyst","AllProdCond")
*the condition is needed to avoid this code overwriting values already assigned earlier
                 $(NOT Commod_Contents(Regions,Commodities,"FeedXP (t)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFAOSTATCropProduction_Commodities(FAOSTAT_CropProductionItems,Commodities)),
                 VariousSources_MainOutput_XPContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems));




*6.3) Assign values for NON_FAOSTAT_CropProductionItems
*these values are assigned here and not above, as above, the sets we work with cover FAOSTAT crops only and not the grasses and forage crops

*6.3.1) N contents

*forage maize: HIGHER IN AP: there, take 0.00383 based on Alpenprojekt: divide production/XP *0.16 (assuming 16% N in XP).
*feedipedia 0.233*0.079*0.16
Commod_Contents(Countries,"Maize For Forage+Silage","N (t)","AllProdSyst","AllProdCond")
 = 0.002945;
*Alfalfa, fresh, aearial part from feedipedia: 0.199*0.206*0.16
Commod_Contents(Countries,"Alfalfa For Forage+Silag","N (t)","AllProdSyst","AllProdCond")
 = 0.00656;
*Red clover, fresh, aearial part from feedipedia: 0.190*0.197*0.16
Commod_Contents(Countries,"Clover For Forage+Silage","N (t)","AllProdSyst","AllProdCond")
 = 0.00599;
*vetches: as clover:
Commod_Contents(Countries,"Vetches","N (t)","AllProdSyst","AllProdCond")
 = 0.00599;
*for the following forage crops, just assume some average by hand:
Commod_Contents(Countries,"Leguminous Nes,For+Sil","N (t)","AllProdSyst","AllProdCond")
 = 0.0045;
Commod_Contents(Countries,"Forage Products Nes","N (t)","AllProdSyst","AllProdCond")
 = 0.0045;
*from Alpenprojekt: Hackfrüchte XP/Quant*0.16 gives 0.00213 - instead of 0.0036
Commod_Contents(Countries,"Turnips For Fodder","N (t)","AllProdSyst","AllProdCond")
 = 0.00213;
Commod_Contents(Countries,"Beets For Fodder","N (t)","AllProdSyst","AllProdCond")
 = 0.00213;
Commod_Contents(Countries,"Swedes For Fodder","N (t)","AllProdSyst","AllProdCond")
 = 0.00213;
*Alfalfa, dehydrated from feedipedia: 0.906*0.183*0.16
Commod_Contents(Countries,"Alfalfa Meal And Pellets","N (t)","AllProdSyst","AllProdCond")
 = 0.0265;
*Miscanthus, from MA Selina Fèrst
Commod_Contents(Countries,"Miscanthus","N in DM (t)","AllProdSyst","AllProdCond")
= 0.00415;
*the following, same as temp grass:
Commod_Contents(Countries,"Other grasses, for forage","N (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Temporary meadows and pastures","N (t)","AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Rye grass, for forage","N (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Temporary meadows and pastures","N (t)","AllProdSyst","AllProdCond");


*6.3.2) P2O5 contents

*Maize for forage, fresh, aearl part: feedipedia, 2.1gP/kgDM, thus 0.0021*2.29157tP2O5 *0.233   /t fresh matter
Commod_Contents(Countries,"Maize For Forage+Silage","P2O5 (t)","AllProdSyst","AllProdCond")
* = 0.001121;
*rather from AT P balance document appendix:
*= 0.0018;
*so choose some intermediate value:
= 0.0015;
*Alfalfa, fresh, aearl part: feedipedia, 2.5gP/kgDM, thus 0.0025*2.29157tP2O5 *0.199   /t fresh matter
Commod_Contents(Countries,"Alfalfa For Forage+Silag","P2O5 (t)","AllProdSyst","AllProdCond")
* = 0.00114 ;
*rather from AT P balance document appendix:
*= 0.0018;
*so choose some intermediate value:
= 0.0015;
*Red Clover, fresh, aearl part: feedipedia, 3.4gP/kgDM, thus 0.0034*2.29157tP2O5 *0.19   /t fresh matter
Commod_Contents(Countries,"Clover For Forage+Silage","P2O5 (t)","AllProdSyst","AllProdCond")
 = 0.00148;
*vetches: as clover:
Commod_Contents(Countries,"Vetches","N (t)","AllProdSyst","AllProdCond")
 = 0.00148;
*for the following forage crops, just assume some average by hand:
Commod_Contents(Countries,"Leguminous Nes,For+Sil","P2O5 (t)","AllProdSyst","AllProdCond")
 = 0.0012 ;
Commod_Contents(Countries,"Forage Products Nes","P2O5 (t)","AllProdSyst","AllProdCond")
 = 0.0012;
Commod_Contents(Countries,"Turnips For Fodder","P2O5 (t)","AllProdSyst","AllProdCond")
* = 0.0013 ;
*rather from AT P balance document appendix:
= 0.0008;
Commod_Contents(Countries,"Beets For Fodder","P2O5 (t)","AllProdSyst","AllProdCond")
* = 0.0013 ;
*rather from AT P balance document appendix:
= 0.0008;
Commod_Contents(Countries,"Swedes For Fodder","P2O5 (t)","AllProdSyst","AllProdCond")
* = 0.0013 ;
*rather from AT P balance document appendix:
= 0.0008;
*Alfalfa, dehydrated: feedipedia, 2.7gP/kgDM, thus 0.0027*2.29157tP2O5 *0.909   /t fresh matter
Commod_Contents(Countries,"Alfalfa Meal And Pellets","P2O5 (t)","AllProdSyst","AllProdCond")
 = 0.005624;
*the following, same as temp grass:
Commod_Contents(Countries,"Other grasses, for forage","P2O5 (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Temporary meadows and pastures","P2O5 (t)","AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Rye grass, for forage","P2O5 (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Temporary meadows and pastures","P2O5 (t)","AllProdSyst","AllProdCond");

*6.3.3) DM contents
*feedipedia:

*maize green forage; maize silage, average:
Commod_Contents(Countries,"Maize For Forage+Silage","DM (t)","AllProdSyst","AllProdCond")
  = 0.234;
*Alfalfa, fresh, aerial part
Commod_Contents(Countries,"Alfalfa For Forage+Silag","DM (t)","AllProdSyst","AllProdCond")
= 0.199;
*Red Clover, fresh, aerial part
Commod_Contents(Countries,"Clover For Forage+Silage","DM (t)","AllProdSyst","AllProdCond")
 = 0.19;
*vetches: as clover:
Commod_Contents(Countries,"Vetches","N (t)","AllProdSyst","AllProdCond")
 = 0.19;
*for the following forage crops, just assume some average by hand:
Commod_Contents(Countries,"Leguminous Nes,For+Sil","DM (t)","AllProdSyst","AllProdCond")
 = 0.2;
Commod_Contents(Countries,"Forage Products Nes","DM (t)","AllProdSyst","AllProdCond")
 = 0.2;
*for the beets/roots use "Beet root, fodder type, fresh"
Commod_Contents(Countries,"Turnips For Fodder","DM (t)","AllProdSyst","AllProdCond")
= 0.163;
Commod_Contents(Countries,"Beets For Fodder","DM (t)","AllProdSyst","AllProdCond")
= 0.163;
Commod_Contents(Countries,"Swedes For Fodder","DM (t)","AllProdSyst","AllProdCond")
= 0.163;
*Alfalfa, dehydrated
Commod_Contents(Countries,"Alfalfa Meal And Pellets","DM (t)","AllProdSyst","AllProdCond")
 = 0.906;
*Sorghum, for forage
Commod_Contents(Countries,"Sorghum, for forage","DM (t)","AllProdSyst","AllProdCond")
 = 0.282;
*Miscanthus, from MA Selina Fèrst
Commod_Contents(Countries,"Miscanthus","DM (t)","AllProdSyst","AllProdCond")
= 0.508;
*derive fresh matter N contents from DM-N contents above and DM contents:
Commod_Contents(Countries,"Miscanthus","N (t)","AllProdSyst","AllProdCond")
= Commod_Contents(Countries,"Miscanthus","N in DM (t)","AllProdSyst","AllProdCond")
         * Commod_Contents(Countries,"Miscanthus","DM (t)","AllProdSyst","AllProdCond");
*the following, same as temp grass:
Commod_Contents(Countries,"Other grasses, for forage","DM (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Temporary meadows and pastures","DM (t)","AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Rye grass, for forage","DM (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Temporary meadows and pastures","DM (t)","AllProdSyst","AllProdCond");


*6.3.4) some further data
*again from feedipedia or similar to others:
*rye grass: equals permanent meadows and pastures:
Commod_Contents(Countries,"Rye grass, for forage",Contents,"AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Permanent meadows and pastures",Contents,"AllProdSyst","AllProdCond");

*Sorghum, for forage
Commod_Contents(Countries,"Sorghum, for forage","FeedXP (t)","AllProdSyst","AllProdCond")
 = 0.075*0.282;
Commod_Contents(Countries,"Sorghum, for forage","FeedGE (MJ)","AllProdSyst","AllProdCond")
 = 18100*0.282;

*derive ME: could be filed in from https://www.feedtables.com/content/table-as-fed, but for now do it by using 65% of GE (to be checked)
Commod_Contents(Countries,Commodities,"FeedME (MJ)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,Commodities,"FeedGE (MJ)","AllProdSyst","AllProdCond")*0.65;

*derive contents in DM:
Commod_Contents(Countries,Commodities,"FeedGE in DM (MJ)","AllProdSyst","AllProdCond")
                 $Commod_Contents(Countries,Commodities,"DM (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,Commodities,"FeedGE (MJ)","AllProdSyst","AllProdCond")
                 /Commod_Contents(Countries,Commodities,"DM (t)","AllProdSyst","AllProdCond");

Commod_Contents(Countries,Commodities,"FeedME in DM (MJ)","AllProdSyst","AllProdCond")
                 $Commod_Contents(Countries,Commodities,"DM (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,Commodities,"FeedME (MJ)","AllProdSyst","AllProdCond")
                 /Commod_Contents(Countries,Commodities,"DM (t)","AllProdSyst","AllProdCond");

Commod_Contents(Countries,Commodities,"FeedXP in DM (t)","AllProdSyst","AllProdCond")
                 $Commod_Contents(Countries,Commodities,"DM (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,Commodities,"FeedXP (t)","AllProdSyst","AllProdCond")
                 /Commod_Contents(Countries,Commodities,"DM (t)","AllProdSyst","AllProdCond");

*for the following, we also need DM contents, otherwise some calculations do not work:

Commod_Contents(Countries,"Honey",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Honey",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Honey, natural",Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,"Apples and products",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Apples and products",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Apples",Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,"Barley and products",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Barley and products",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Barley",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Wheat and products",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Wheat and products",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Wheat",Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,"Beans",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Beans",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Beans, dry",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Peas",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Peas",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Peas, dry",Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,"Bovine Meat",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Bovine Meat",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Meat, Cattle",Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,"Cabbage, for forage",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Cabbage, for forage",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Cabbages and other brassicas",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Cassava and products",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Cassava and products",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Cassava",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Cereals - Excluding Beer",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Cereals - Excluding Beer",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Cereals, nes",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Cereals, Other",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Cereals, Other",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Cereals, nes",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Cocoa Beans and products",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Cocoa Beans and products",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Cocoa, beans",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Coconuts - Incl Copra",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Coconuts - Incl Copra",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Coconuts",Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,"Eggs",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Eggs",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Eggs, hen, in shell",Contents,"AllProdSyst","AllProdCond");

*for fruits, other - choose oranges
Commod_Contents(Countries,"Fruits, Other",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Fruits, Other",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Oranges",Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,"Meat",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Meat",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Meat, cattle",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Meat, Other",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Meat, Other",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Meat, pig",Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,"Oranges, Mandarines",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Oranges, Mandarines",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Oranges",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Other grasses, for forage",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Other grasses, for forage",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Temporary meadows and pastures",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Pulses",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Pulses",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Pulses, nes",Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,"Pulses, Other and products",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Pulses, Other and products",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Pulses, nes",Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,"Rape and Mustardseed",Contents,"AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Rape and Mustardseed",Contents,"AllProdSyst","AllProdCond"))
         = Commod_Contents(Countries,"Rapeseed",Contents,"AllProdSyst","AllProdCond");






****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*7) Load SOLmV5 data - to be improved later

*load data from SOLmV5:
Parameter ParameterPerTonDomestAvailQuantSOLmV5(*,*,*,*,*,*);

$GDXIN SOLmV5_CoreModelParameters.gdx
$load ParameterPerTonDomestAvailQuantSOLmV5
$GDXIN SOLmV5_CoreModelParameters.gdx

Commod_Contents(Countries,Commodities,"Calories (kcal)","AllProdSyst","AllProdCond")
         = ParameterPerTonDomestAvailQuantSOLmV5(Countries,Commodities,"FoodCal (kcal/t)","AverageProdType","All","Baseline");
Commod_Contents(Countries,Commodities,"Protein (t)","AllProdSyst","AllProdCond")
         = ParameterPerTonDomestAvailQuantSOLmV5(Countries,Commodities,"FoodProt (t/t)","AverageProdType","All","Baseline");

Commod_Contents(Countries,Commodities,"FeedME (MJ)","AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,Commodities,"FeedME (MJ)","AllProdSyst","AllProdCond"))
         = ParameterPerTonDomestAvailQuantSOLmV5(Countries,Commodities,"FeedME cont (MJ/t)","AverageProdType","All","Baseline");
Commod_Contents(Countries,Commodities,"FeedGE (MJ)","AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,Commodities,"FeedGE (MJ)","AllProdSyst","AllProdCond"))
         = ParameterPerTonDomestAvailQuantSOLmV5(Countries,Commodities,"FeedGE cont (MJ/t)","AverageProdType","All","Baseline");
Commod_Contents(Countries,Commodities,"FeedXP (t)","AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,Commodities,"FeedXP (t)","AllProdSyst","AllProdCond"))
         = ParameterPerTonDomestAvailQuantSOLmV5(Countries,Commodities,"FeedXP cont (t/t)","AverageProdType","All","Baseline");

*further data of potential interest:
*  FeedME cont in DM (MJ/tDM)
*  FeedGE cont in DM (MJ/tDM)
*  FeedXP cont in DM (t/tDM)
*  DM contents (tDM/t)


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*8) Define additional feed data
*identified based on FAOSTAT feed quantities for these commodities reporting significant amounts - commodities with negligible amounts are neglected
*the following values are taken from feedipedia:

Commod_Contents(Countries,"Cottonseed","DM (t)","AllProdSyst","AllProdCond") = 0.923;
Commod_Contents(Countries,"Cottonseed","FeedME (MJ)","AllProdSyst","AllProdCond") = 12000*0.923;
Commod_Contents(Countries,"Cottonseed","FeedGE (MJ)","AllProdSyst","AllProdCond") = 23800*0.923;
Commod_Contents(Countries,"Cottonseed","FeedXP (t)","AllProdSyst","AllProdCond") = 0.218*0.923;

Commod_Contents(Countries,"Sesame seed","DM (t)","AllProdSyst","AllProdCond") = 0.928;
Commod_Contents(Countries,"Sesame seed","FeedME (MJ)","AllProdSyst","AllProdCond") = 12500*0.928;
Commod_Contents(Countries,"Sesame seed","FeedGE (MJ)","AllProdSyst","AllProdCond") = 20600*0.928;
Commod_Contents(Countries,"Sesame seed","FeedXP (t)","AllProdSyst","AllProdCond") = 0.449*0.928;

Commod_Contents(Countries,"Plantains","DM (t)","AllProdSyst","AllProdCond") = 0.294;
*FeedME: only values for pigs - the FE we report usually is rather the one for cattle that tends to be somewhat lower - thus just assume some lower value
Commod_Contents(Countries,"Plantains","FeedME (MJ)","AllProdSyst","AllProdCond") = 12000*0.294;
Commod_Contents(Countries,"Plantains","FeedGE (MJ)","AllProdSyst","AllProdCond") = 17100*0.294;
Commod_Contents(Countries,"Plantains","FeedXP (t)","AllProdSyst","AllProdCond") = 0.04*0.294;

Commod_Contents(Countries,"Cottonseed Cake","DM (t)","AllProdSyst","AllProdCond") = 0.909;
Commod_Contents(Countries,"Cottonseed Cake","FeedME (MJ)","AllProdSyst","AllProdCond") = 12700*0.909;
Commod_Contents(Countries,"Cottonseed Cake","FeedGE (MJ)","AllProdSyst","AllProdCond") = 20000*0.909;
Commod_Contents(Countries,"Cottonseed Cake","FeedXP (t)","AllProdSyst","AllProdCond") = 0.473*0.909;

*just assume something: for now, it is "Citrus fruits":
Commod_Contents(Countries,"Fruits - Excluding Wine","DM (t)","AllProdSyst","AllProdCond") = 0.158;
Commod_Contents(Countries,"Fruits - Excluding Wine","FeedME (MJ)","AllProdSyst","AllProdCond") = 13900*0.158;
Commod_Contents(Countries,"Fruits - Excluding Wine","FeedGE (MJ)","AllProdSyst","AllProdCond") = 18100*0.158;
Commod_Contents(Countries,"Fruits - Excluding Wine","FeedXP (t)","AllProdSyst","AllProdCond") = 0.065*0.158;

*this is only reported for Germany, but there, it is not unimportant
*no data in feedipedia - but it has no protein, 100%DM - energy values: just take rapeseeds and increase somewhat.
Commod_Contents(Countries,"Rape and Mustard Oil","DM (t)","AllProdSyst","AllProdCond") = 1;
Commod_Contents(Countries,"Rape and Mustard Oil","FeedME (MJ)","AllProdSyst","AllProdCond") = 22000;
Commod_Contents(Countries,"Rape and Mustard Oil","FeedGE (MJ)","AllProdSyst","AllProdCond") = 35000;
Commod_Contents(Countries,"Rape and Mustard Oil","FeedXP (t)","AllProdSyst","AllProdCond") = 0;

*take rapeseed meal, mechanical extraction
Commod_Contents(Countries,"Rape and Mustard Cake","DM (t)","AllProdSyst","AllProdCond") = 0.899;
Commod_Contents(Countries,"Rape and Mustard Cake","FeedME (MJ)","AllProdSyst","AllProdCond") = 11200*0.899;
Commod_Contents(Countries,"Rape and Mustard Cake","FeedGE (MJ)","AllProdSyst","AllProdCond") = 20800*0.899;
Commod_Contents(Countries,"Rape and Mustard Cake","FeedXP (t)","AllProdSyst","AllProdCond") = 0.356*0.899;

*FeedME: only values for pigs - the FE we report usually is rather the one for cattle that tends to be somewhat lower - thus just assume some lower value
Commod_Contents(Countries,"Meat Meal","DM (t)","AllProdSyst","AllProdCond") = 0.958;
Commod_Contents(Countries,"Meat Meal","FeedME (MJ)","AllProdSyst","AllProdCond") = 12000*0.958;
Commod_Contents(Countries,"Meat Meal","FeedGE (MJ)","AllProdSyst","AllProdCond") = 17700*0.958;
Commod_Contents(Countries,"Meat Meal","FeedXP (t)","AllProdSyst","AllProdCond") = 0.549*0.958;

*not from feedipedia, but from Feedtables.com - besides DM - there, we have 9% for whole milk, thus just take 6% for skimmed milk (guess A. Muller, 18.8.2019)
Commod_Contents(Countries,"Milk, Skimmed","DM (t)","AllProdSyst","AllProdCond") = 0.06;
Commod_Contents(Countries,"Milk, Skimmed","FeedME (MJ)","AllProdSyst","AllProdCond") = 13700*0.06;
Commod_Contents(Countries,"Milk, Skimmed","FeedGE (MJ)","AllProdSyst","AllProdCond") = 18300*0.06;
Commod_Contents(Countries,"Milk, Skimmed","FeedXP (t)","AllProdSyst","AllProdCond") = 0.358*0.06;
*whole milk is assigned no DM, though, so do this here:
Commod_Contents(Countries,"Milk, Whole","DM (t)","AllProdSyst","AllProdCond") = 0.09;


*take the meat meal values for GE, ME, XP and the DM values for meat (currently 0.4 in SOLm):
Commod_Contents(Countries,"Offals","DM (t)","AllProdSyst","AllProdCond") = 0.4;
Commod_Contents(Countries,"Offals","FeedME (MJ)","AllProdSyst","AllProdCond") = 12000*0.4;
Commod_Contents(Countries,"Offals","FeedGE (MJ)","AllProdSyst","AllProdCond") = 17700*0.4;
Commod_Contents(Countries,"Offals","FeedXP (t)","AllProdSyst","AllProdCond") = 0.549*0.4;

*and add GE, XP and DM values for commodities that are important as feed and where we have ME only for now:

Commod_Contents(Countries,"Palm kernels","DM (t)","AllProdSyst","AllProdCond") = 0.918;
Commod_Contents(Countries,"Palm kernels","FeedME (MJ)","AllProdSyst","AllProdCond") = 19200*0.918;
Commod_Contents(Countries,"Palm kernels","FeedGE (MJ)","AllProdSyst","AllProdCond") = 28400*0.918;
Commod_Contents(Countries,"Palm kernels","FeedXP (t)","AllProdSyst","AllProdCond") = 0.095*0.918;

Commod_Contents(Countries,'Turnips for fodder',Contents,"AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,'Beets for fodder',Contents,"AllProdSyst","AllProdCond");

*take Red clover, fresh areal parts:
Commod_Contents(Countries,"Clover For Forage+Silage","DM (t)","AllProdSyst","AllProdCond") = 0.19;
Commod_Contents(Countries,"Clover For Forage+Silage","FeedME (MJ)","AllProdSyst","AllProdCond") = 10400*0.19;
Commod_Contents(Countries,"Clover For Forage+Silage","FeedGE (MJ)","AllProdSyst","AllProdCond") = 18400*0.19;
Commod_Contents(Countries,"Clover For Forage+Silage","FeedXP (t)","AllProdSyst","AllProdCond") = 0.197*0.19;

*replace current values with feedipedia:
Commod_Contents(Countries,"Beets for fodder","DM (t)","AllProdSyst","AllProdCond") = 0.163;
Commod_Contents(Countries,"Beets for fodder","FeedME (MJ)","AllProdSyst","AllProdCond") = 11900*0.163;
Commod_Contents(Countries,"Beets for fodder","FeedGE (MJ)","AllProdSyst","AllProdCond") = 16700*0.163;
Commod_Contents(Countries,"Beets for fodder","FeedXP (t)","AllProdSyst","AllProdCond") = 0.067*0.163;

Commod_Contents(Countries,'Swedes for fodder',Contents,"AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,'Beets for fodder',Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,'Starchy Roots',Contents,"AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,'Beets for fodder',Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,'Roots, Other',Contents,"AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,'Beets for fodder',Contents,"AllProdSyst","AllProdCond");

*use Wheat brans:
Commod_Contents(Countries,"Brans","DM (t)","AllProdSyst","AllProdCond") = 0.87;
Commod_Contents(Countries,"Brans","FeedME (MJ)","AllProdSyst","AllProdCond") = 11000*0.87;
Commod_Contents(Countries,"Brans","FeedGE (MJ)","AllProdSyst","AllProdCond") = 18900*0.87;
Commod_Contents(Countries,"Brans","FeedXP (t)","AllProdSyst","AllProdCond") = 0.173*0.87;

Commod_Contents(Countries,"Copra Cake","DM (t)","AllProdSyst","AllProdCond") = 0.915;
Commod_Contents(Countries,"Copra Cake","FeedME (MJ)","AllProdSyst","AllProdCond") = 128000.915;
Commod_Contents(Countries,"Copra Cake","FeedGE (MJ)","AllProdSyst","AllProdCond") = 201000.915;
Commod_Contents(Countries,"Copra Cake","FeedXP (t)","AllProdSyst","AllProdCond") = 0.224*0.915;

*peanut meal
Commod_Contents(Countries,"Groundnut Cake","DM (t)","AllProdSyst","AllProdCond") = 0.904;
Commod_Contents(Countries,"Groundnut Cake","FeedME (MJ)","AllProdSyst","AllProdCond") = 12600*0.904;
Commod_Contents(Countries,"Groundnut Cake","FeedGE (MJ)","AllProdSyst","AllProdCond") = 20000*0.904;
Commod_Contents(Countries,"Groundnut Cake","FeedXP (t)","AllProdSyst","AllProdCond") = 0.533*0.904;

*Maize grain
Commod_Contents(Countries,"Maize and products","DM (t)","AllProdSyst","AllProdCond") = 0.863;
Commod_Contents(Countries,"Maize and products","FeedME (MJ)","AllProdSyst","AllProdCond") = 13600*0.863;
Commod_Contents(Countries,"Maize and products","FeedGE (MJ)","AllProdSyst","AllProdCond") = 18700*0.863;
Commod_Contents(Countries,"Maize and products","FeedXP (t)","AllProdSyst","AllProdCond") = 0.094*0.863;

*Pearl millet, grain
Commod_Contents(Countries,"Millet and products","DM (t)","AllProdSyst","AllProdCond") = 0.896;
Commod_Contents(Countries,"Millet and products","FeedME (MJ)","AllProdSyst","AllProdCond") = 13500*0.896;
Commod_Contents(Countries,"Millet and products","FeedGE (MJ)","AllProdSyst","AllProdCond") = 18800*0.896;
Commod_Contents(Countries,"Millet and products","FeedXP (t)","AllProdSyst","AllProdCond") = 0.124*0.896;

Commod_Contents(Countries,"Soybeans","DM (t)","AllProdSyst","AllProdCond") = 0.887;
Commod_Contents(Countries,"Soybeans","FeedME (MJ)","AllProdSyst","AllProdCond") = 15300*0.887;
Commod_Contents(Countries,"Soybeans","FeedGE (MJ)","AllProdSyst","AllProdCond") = 23600*0.887;
Commod_Contents(Countries,"Soybeans","FeedXP (t)","AllProdSyst","AllProdCond") = 0.396*0.887;
Commod_Contents(Countries,'Soyabeans',Contents,"AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,'Soybeans',Contents,"AllProdSyst","AllProdCond");

*take some average of low and high protein soyabean meal
Commod_Contents(Countries,"Soyabean Cake","DM (t)","AllProdSyst","AllProdCond") = 0.88;
Commod_Contents(Countries,"Soyabean Cake","FeedME (MJ)","AllProdSyst","AllProdCond") = 13600*0.88;
Commod_Contents(Countries,"Soyabean Cake","FeedGE (MJ)","AllProdSyst","AllProdCond") = 19700*0.88;
Commod_Contents(Countries,"Soyabean Cake","FeedXP (t)","AllProdSyst","AllProdCond") = 0.527*0.88;

Commod_Contents(Countries,'Oilcrops',Contents,"AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,'Soybeans',Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,'Oilcrops, Other',Contents,"AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,'Soybeans',Contents,"AllProdSyst","AllProdCond");
Commod_Contents(Countries,'Oilseed Cakes, Other',Contents,"AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,'Soyabean Cake',Contents,"AllProdSyst","AllProdCond");

Commod_Contents(Countries,"Palmkernel Cake","DM (t)","AllProdSyst","AllProdCond") = 0.912;
Commod_Contents(Countries,"Palmkernel Cake","FeedME (MJ)","AllProdSyst","AllProdCond") = 11600*0.912;
Commod_Contents(Countries,"Palmkernel Cake","FeedGE (MJ)","AllProdSyst","AllProdCond") = 20100*0.912;
Commod_Contents(Countries,"Palmkernel Cake","FeedXP (t)","AllProdSyst","AllProdCond") = 0.167*0.912;

*potato tubers
Commod_Contents(Countries,"Potatoes and products","DM (t)","AllProdSyst","AllProdCond") = 0.206;
Commod_Contents(Countries,"Potatoes and products","FeedME (MJ)","AllProdSyst","AllProdCond") = 13500*0.206;
Commod_Contents(Countries,"Potatoes and products","FeedGE (MJ)","AllProdSyst","AllProdCond") = 11900*0.206;
Commod_Contents(Countries,"Potatoes and products","FeedXP (t)","AllProdSyst","AllProdCond") = 0.108*0.206;

*Rough rice (Paddy)
Commod_Contents(Countries,"Rice (Paddy Equivalent)","DM (t)","AllProdSyst","AllProdCond") = 0.88;
Commod_Contents(Countries,"Rice (Paddy Equivalent)","FeedME (MJ)","AllProdSyst","AllProdCond") = 10100*0.88;
Commod_Contents(Countries,"Rice (Paddy Equivalent)","FeedGE (MJ)","AllProdSyst","AllProdCond") = 17600*0.88;
Commod_Contents(Countries,"Rice (Paddy Equivalent)","FeedXP (t)","AllProdSyst","AllProdCond") = 0.083*0.88;

*rye grain
Commod_Contents(Countries,"Rye and products","DM (t)","AllProdSyst","AllProdCond") = 0.866;
Commod_Contents(Countries,"Rye and products","FeedME (MJ)","AllProdSyst","AllProdCond") = 13000*0.866;
Commod_Contents(Countries,"Rye and products","FeedGE (MJ)","AllProdSyst","AllProdCond") = 18000*0.866;
Commod_Contents(Countries,"Rye and products","FeedXP (t)","AllProdSyst","AllProdCond") = 0.103*0.866;

*sesame seed meal, mechanical extraction
Commod_Contents(Countries,"Sesameseed Cake","DM (t)","AllProdSyst","AllProdCond") = 0.928;
Commod_Contents(Countries,"Sesameseed Cake","FeedME (MJ)","AllProdSyst","AllProdCond") = 12500*0.928;
Commod_Contents(Countries,"Sesameseed Cake","FeedGE (MJ)","AllProdSyst","AllProdCond") = 20600*0.928;
Commod_Contents(Countries,"Sesameseed Cake","FeedXP (t)","AllProdSyst","AllProdCond") = 0.449*0.928;

*Sunflowerseed meal - some average of the different types
Commod_Contents(Countries,"Sunflowerseed Cake","DM (t)","AllProdSyst","AllProdCond") = 0.89;
Commod_Contents(Countries,"Sunflowerseed Cake","FeedME (MJ)","AllProdSyst","AllProdCond") = 9000*0.89;
Commod_Contents(Countries,"Sunflowerseed Cake","FeedGE (MJ)","AllProdSyst","AllProdCond") = 19000*0.89;
Commod_Contents(Countries,"Sunflowerseed Cake","FeedXP (t)","AllProdSyst","AllProdCond") = 0.31*0.89;

*sorghum grain
Commod_Contents(Countries,"Sorghum and products","DM (t)","AllProdSyst","AllProdCond") = 0.874;
Commod_Contents(Countries,"Sorghum and products","FeedME (MJ)","AllProdSyst","AllProdCond") = 13500*0.866;
Commod_Contents(Countries,"Sorghum and products","FeedGE (MJ)","AllProdSyst","AllProdCond") = 18800*0.866;
Commod_Contents(Countries,"Sorghum and products","FeedXP (t)","AllProdSyst","AllProdCond") = 0.108*0.874;

*Tomato fruits
Commod_Contents(Countries,"Tomatoes and products","DM (t)","AllProdSyst","AllProdCond") = 0.073;
Commod_Contents(Countries,"Tomatoes and products","FeedME (MJ)","AllProdSyst","AllProdCond") = 5100*0.073;
*no GE value - thus derive something in similar relation to ME as for other feeds
Commod_Contents(Countries,"Tomatoes and products","FeedGE (MJ)","AllProdSyst","AllProdCond") = 7500*0.073;
Commod_Contents(Countries,"Tomatoes and products","FeedXP (t)","AllProdSyst","AllProdCond") = 0.167*0.073;

*Pumpkin, squash, gourd and other Cucurbita species: DM 0.076; XP 0.145*0.076; GE 17800*0.076
*or use some leafy stuff, e.g. Tomato leaves, fresh: has DM 0.126; XP 0.088*0.126; GE 10300*0.126
*but in the end: unclear what it is - thus do some gross ad-hoc average as follows - and do ME similarly lower than GE as for other feed:
Commod_Contents(Countries,"Vegetables","DM (t)","AllProdSyst","AllProdCond") = 0.09;
Commod_Contents(Countries,"Vegetables","FeedME (MJ)","AllProdSyst","AllProdCond") = 9000*0.09;
Commod_Contents(Countries,"Vegetables","FeedGE (MJ)","AllProdSyst","AllProdCond") = 13500*0.09;
Commod_Contents(Countries,"Vegetables","FeedXP (t)","AllProdSyst","AllProdCond") = 0.12*0.09;

*DM values for Beet root, fodder type, fresh:
Commod_Contents(Countries,"Roots & Tuber Dry Equiv","DM (t)","AllProdSyst","AllProdCond") = 1;
Commod_Contents(Countries,"Roots & Tuber Dry Equiv","FeedME (MJ)","AllProdSyst","AllProdCond") = 11900*1;
Commod_Contents(Countries,"Roots & Tuber Dry Equiv","FeedGE (MJ)","AllProdSyst","AllProdCond") = 16700*1;
Commod_Contents(Countries,"Roots & Tuber Dry Equiv","FeedXP (t)","AllProdSyst","AllProdCond") = 0.067*1;

Commod_Contents(Countries,"Fish Meal","DM (t)","AllProdSyst","AllProdCond") = 0.921;
Commod_Contents(Countries,"Fish Meal","FeedME (MJ)","AllProdSyst","AllProdCond") = 14800*0.921;
Commod_Contents(Countries,"Fish Meal","FeedGE (MJ)","AllProdSyst","AllProdCond") = 21900*0.921;
Commod_Contents(Countries,"Fish Meal","FeedXP (t)","AllProdSyst","AllProdCond") = 0.754*0.921;

*Fish Oil
*ME value just an assumption by A. Muller, 19.8.2019
Commod_Contents(Countries,"Fish, Body Oil","DM (t)","AllProdSyst","AllProdCond") = 1;
Commod_Contents(Countries,"Fish, Body Oil","FeedME (MJ)","AllProdSyst","AllProdCond") = 25000;
Commod_Contents(Countries,"Fish, Body Oil","FeedGE (MJ)","AllProdSyst","AllProdCond") = 39000;
Commod_Contents(Countries,"Fish, Body Oil","FeedXP (t)","AllProdSyst","AllProdCond") = 0;
Commod_Contents(Countries,"Fish, Liver Oil",Contents,"AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Fish, Body Oil",Contents,"AllProdSyst","AllProdCond");

*cane and beet molasses are equal for DM and GE, but not for XP (beet: 14.5, cane 5.5)
Commod_Contents(Countries,"Molasses","DM (t)","AllProdSyst","AllProdCond") = 0.75;
Commod_Contents(Countries,"Molasses","FeedME (MJ)","AllProdSyst","AllProdCond") = 11000*0.75;
Commod_Contents(Countries,"Molasses","FeedGE (MJ)","AllProdSyst","AllProdCond") = 15000*0.75;
*thus: derive XP weighted by cane or beet production
Commod_Contents(Countries,"Molasses","FeedXP (t)","AllProdSyst","AllProdCond")
         $(VActCropsGrass_Outputs.l(Countries,"Sugar cane","MainOutput1 (t)","AllProdSyst","AllProdCond")
                 +VActCropsGrass_Outputs.l(Countries,"Sugar beet","MainOutput1 (t)","AllProdSyst","AllProdCond"))
         = (0.055*0.75*VActCropsGrass_Outputs.l(Countries,"Sugar cane","MainOutput1 (t)","AllProdSyst","AllProdCond")
                 +0.145*0.75*VActCropsGrass_Outputs.l(Countries,"Sugar beet","MainOutput1 (t)","AllProdSyst","AllProdCond"))
         /(VActCropsGrass_Outputs.l(Countries,"Sugar cane","MainOutput1 (t)","AllProdSyst","AllProdCond")
                 +VActCropsGrass_Outputs.l(Countries,"Sugar beet","MainOutput1 (t)","AllProdSyst","AllProdCond"));
*and if nothing is assigned, just assign the average:
Commod_Contents(Countries,"Molasses","FeedXP (t)","AllProdSyst","AllProdCond")
                 $(NOT Commod_Contents(Countries,"Molasses","FeedXP (t)","AllProdSyst","AllProdCond"))
         = 0.10*0.75;
Commod_Contents(Countries,"Molasses (sugar cane)","DM (t)","AllProdSyst","AllProdCond") = 0.75;
Commod_Contents(Countries,"Molasses (sugar cane)","FeedME (MJ)","AllProdSyst","AllProdCond") = 11000*0.75;
Commod_Contents(Countries,"Molasses (sugar cane)","FeedGE (MJ)","AllProdSyst","AllProdCond") = 15000*0.75;
Commod_Contents(Countries,"Molasses (sugar cane)","FeedXP (t)","AllProdSyst","AllProdCond") = 0.055*0.75;
Commod_Contents(Countries,"Molasses (sugar beet)","DM (t)","AllProdSyst","AllProdCond") = 0.75;
Commod_Contents(Countries,"Molasses (sugar beet)","FeedME (MJ)","AllProdSyst","AllProdCond") = 11000*0.75;
Commod_Contents(Countries,"Molasses (sugar beet)","FeedGE (MJ)","AllProdSyst","AllProdCond") = 15000*0.75;
Commod_Contents(Countries,"Molasses (sugar beet)","FeedXP (t)","AllProdSyst","AllProdCond") = 0.145*0.75;

*missing DM values:
Commod_Contents(Countries,"Sugar, Raw equivalent","DM (t)","AllProdSyst","AllProdCond") = 1;
Commod_Contents(Countries,"Animal Fats","DM (t)","AllProdSyst","AllProdCond") = 1;
*whey: assume somewhat less than skimmed milk (A. Muller, 21.8.2019)
Commod_Contents(Countries,"Whey","DM (t)","AllProdSyst","AllProdCond") = 0.03;
*Pelagic Fish, assume something similar to meat, somewhat less (A. Muller, 21.8.2019)
Commod_Contents(Countries,"Pelagic Fish","DM (t)","AllProdSyst","AllProdCond") = 0.35;


*derive per DM contents:
Commod_Contents(Regions,Commodities,"FeedGE in DM (MJ)",ProductionSystems,ProductionConditions)
                 $Commod_Contents(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions)
         = Commod_Contents(Regions,Commodities,"FeedGE (MJ)",ProductionSystems,ProductionConditions)
                 /Commod_Contents(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions);

Commod_Contents(Regions,Commodities,"FeedME in DM (MJ)",ProductionSystems,ProductionConditions)
                 $Commod_Contents(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions)
         = Commod_Contents(Regions,Commodities,"FeedME (MJ)",ProductionSystems,ProductionConditions)
                 /Commod_Contents(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions);

Commod_Contents(Regions,Commodities,"FeedXP in DM (t)",ProductionSystems,ProductionConditions)
                 $Commod_Contents(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions)
         = Commod_Contents(Regions,Commodities,"FeedXP (t)",ProductionSystems,ProductionConditions)
                 /Commod_Contents(Regions,Commodities,"DM (t)",ProductionSystems,ProductionConditions);



$ontext;
After this we have the following in SOLm-entities:

Commod_Contents(Countries,Commodities,Contents,"AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Commodities       is      FAOSTAT_CropProductionItems
                                 forage crops in NON_FAOSTAT_CropProductionItems
                                 livestock primary products - a selection from livestock commodities that most closely capture the main outputs from livestock activities.
                                                 BUT:    FAOSTAT_LiveAnimalsItems have "Sheep and goats" only,
                                                         while live animals in FAOSTAT_LivestockPrimaryItems used here have "Sheep" and "Goats" separately
Contents          is      N, P2O5, DM, partly ME, GE, XP contents in fresh and partly also in dry matter

*XXX STILL TO BE DONE:
Check all data in this file and improve, differentiate, where needed and useful
FILE IN USDA-data, etc.
$offtext;
