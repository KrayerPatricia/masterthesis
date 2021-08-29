PUTCLOSE con,"_V6_ReadData_VariousSources_ResidueSharesAndNutrientContentsData";

$ontext;
GENERAL DESCRIPTION
This file reads and/or assigns the nutrient contents data of the crop residues of the items (activities) and their residue shares:

DETAILED TABLE OF CONTENTS
- 1) Data used in earlier SOLm versions: latest in SOLmV4
        1.1) Residue N contents
        1.2) Residue P2O5 contents
        1.3) Residue DM contents
        1.4) Residue Shares
- 2) IPCC 2006
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Data used in earlier SOLm versions: latest in SOLmV4

*This data is read from a specific file, then several values are adjusted, completed directly in the code below.
*in this file read in in earlier SOLm-Versions, values for K and C are dummies only and we thus drop them already in the excel sheet - thus: onyl N and P2O5 values are read in.
*the values in the file also refer to crops only, therefore no "outputtype" dimension is needed, as we dropped the empty columns for animal products as well.

*general: P is in P2O5 and K in K2O;
*Units: N,P2O5,K2O,C contents in quantities, i.e. rations: 0.007=0.7% = 0.007 tons / ton, etc.)
*these shares are currently set globally in the excel files

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewVariousSourcesResidueNutrientContentsData% == "YES"
$call GDXXRW VariousSources_ResidueNutrientContents_28_8_2016.xlsx  o=VariousSources_ResidueNutrientContents_28_8_2016.gdx  index=index!a1:e3
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

Parameter VariousSources_Residue_NContents(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_Residue_PContents(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_Residue_DMContents(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_ResidueSharesInDM(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);

Parameter VariousSources_GrassResidue_NContents(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_GrassActivities);
Parameter VariousSources_GrassResidue_PContents(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_GrassActivities);
Parameter VariousSources_GrassResidue_DMContents(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_GrassActivities);
Parameter VariousSources_GrassResidueSharesInDM(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_GrassActivities);

$gdxin VariousSources_ResidueNutrientContents_28_8_2016.gdx
$load VariousSources_Residue_NContents
$load VariousSources_Residue_PContents
$gdxin
*Units:  tons N, P2O5/ton residue


*1.1) Residue N contents

*unit: ton N,P2O5,K,C/ton  (per ton fresh matter!)

*improve residue N contents data:
*this is done with values from the IPCC 2006 guidelines, Vol 11, Table 11.2
*there, the residue N contents is in kg N/kg DM, therefore to be multiplied with the residue DM contents, see also below (also taken from the Swiss inventory, same source as N contents)
*thus, the multiplication determining the value is always: "N cont in residue DM" * "residue DM contents"
*as DM contents of residues are not directly reported there, we use the values from the GHG inventory of CH, 2019, Table A-25, where DM contents for residues are given.
VariousSources_Residue_NContents(FAOSTAT_Countries,"Wheat")     = 0.006*0.85;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Barley")    = 0.007*0.85;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Maize")     = 0.006*0.85;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Oats")      = 0.007*0.85;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Rye")       = 0.005*0.85;
*triticale. Assume same as wheat
VariousSources_Residue_NContents(FAOSTAT_Countries,"Triticale") = 0.006*0.85;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Millet")    = 0.007*0.85;

VariousSources_Residue_NContents(FAOSTAT_Countries,SOLmOld_Pulses)= 0.008*0.85;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Beans, dry")= 0.01*0.85;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Peas, dry")= 0.008*0.85;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Soybeans")  = 0.008*0.85;
*no IPCC data, use data from CH inventory 2019, table A-25
VariousSources_Residue_NContents(FAOSTAT_Countries,SOLmOld_ForReadingDataLeguminousVegetables)    = 0.0328*0.16;
*lupins CH values
VariousSources_Residue_NContents(FAOSTAT_Countries,"Lupins")    = 0.0412*0.85;

VariousSources_Residue_NContents(FAOSTAT_Countries,SOLmOld_Starchy_Roots)    = 0.019*0.15;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Potatoes")  = 0.019*0.13;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Sugar beet")= 0.019*0.15;

*the following: Use CH inventory values - missing in IPCC default:
VariousSources_Residue_NContents(FAOSTAT_Countries,SOLmOLD_Fruits)    = 0.004*0.17;
VariousSources_Residue_NContents(FAOSTAT_Countries,SOLmOld_ForReadingDataBerries)    = 0.006*0.2;
VariousSources_Residue_NContents(FAOSTAT_Countries,SOLmOld_ForReadingDataNonLeguminousVegetables)  = 0.023*0.13;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Maize, green")    = 0.019*0.32;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Rapeseed")        = 0.0071*0.85;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Sunflower seed")  = 0.015*0.6;
*DM: same as non-leg vegetables
VariousSources_Residue_NContents(FAOSTAT_Countries,"Tobacco, unmanufactured")        = 0.0221*0.13;
VariousSources_Residue_NContents(FAOSTAT_Countries,"Grapes")          = 0.006*0.2;
*we use "Pumpkins, squash and gourds" for "oil squash"
VariousSources_Residue_NContents(FAOSTAT_Countries,"Pumpkins, squash and gourds")    = 0.023*0.13;

*the following is not important, thus do not assign new values
*we use "Flax fibre and tow" for "oil flax"
*VariousSources_Residue_NContents(FAOSTAT_Countries,"Flax fibre and tow")  = 0.0071*0.85;
*we use "Hempseed" for "oil hemp"
*N cont in residue DM missing, use the same as for "oil flax"
*VariousSources_Residue_NContents(FAOSTAT_Countries,"Hempseed")        = 0.0071*1.0;
*residue DM content missing, use the same as for "oil flax"
*VariousSources_Residue_NContents(FAOSTAT_Countries,"Hops")            = 0.0221*1.0;

*we use SOLmOld_Stimulants_Spices for "medicinal plants and herbs"
*residue DM content missing, use the same as for non-leg vegetables,
*but adjust upwards, as the plants my are rather dryer:
VariousSources_Residue_NContents(FAOSTAT_Countries,SOLmOld_Stimulants_Spices)    = 0.033*0.2;

*The following (N cont: IPCC) is inconsistent with grass main crop N contents. Thus overwrite main crop N contents later with the latter
*THUS: assign at the end in SOLm parameters: equal grass residues to grass, for which we already have values from the grass module (for N, Dm,, etc.)
*VariousSources_GrassResidue_NContents(FAOSTAT_Countries,NON_FAOSTAT_GrassActivities)    = 0.012*0.2;

*the table used above has also data for the following, but this is currently not used, as we do not have this item in FAOSTAT
*VariousSources_Residue_NContents(FAOSTAT_Countries,"Peas (Eiweisserbsen)")    = 0.0235*0.85;
*VariousSources_Residue_NContents(FAOSTAT_Countries,"Fodder beet")    = 0.022*0.15;
*VariousSources_Residue_NContents(FAOSTAT_Countries,"Renewable energy crops")    = 0.0115*0.32;
*VariousSources_Residue_NContents(FAOSTAT_Countries,"Silage corn")    = 0.007*0.32;


*1.2) Residue P2O5 contents
*P->P2O5 is *2.29157 (2*30.97+5*16)/(2*30.97)

*in the old version of SOLm (up to version V4), we do not have refined data on this.

*IMPROVE THIS DATA: just added to have something - inspired by the data used in the Alpenproject, between data for CH and AT
VariousSources_GrassResidue_PContents(FAOSTAT_Countries,NON_FAOSTAT_GrassActivities)    = 0.0015;


*1.3) Residue DM contents
*general lack of residue DM contents, thus start with DM contents from crop products, and adjust partly as described below for each number
*unit: tons per ton, i.e. 0.88 is 88%
*this is a first gross assignment of DM contents of harvested products, based on
*        table 11.2 IPCC 2006, volume 11: grains (0.88), Beans and Pulses (0.91), Tubers (0.22).

*and then add more details as used above for the N contents, from IPCC or Swiss inventory, cf. above.

*before these crop specific numbers, we however assign average numbers for crop groups, to have values for all crops that may be used:
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Grains)       = 0.88;
*the following is sugar cane, beet and crops, nes: beet is assigned below; thus assign here something for cane; assume green leafes residues - but rather dryer than full leafy residues with stems (such as sunflower); thus use 0.3
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Sugars_And_Sweeteners) = 0.3;
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Starchy_Roots)= 0.22;
*vegetables are assigned below as leguminous and non-leguminous vegetables in general
*VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Vegetables)
*fruits are assigned below in all generality
*VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Fruits)
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Pulses)       = 0.91;
*Table 4.1 IPCC 2006, volume 5: gives a general average value fro residues DM contents of 40% - thus, for oil crops use something higher, my assumption: 0.75
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Oil_Crops)    = 0.75;
*Table 4.1 IPCC 2006, volume 5: gives a general average value fro residues DM contents of 40% - thus, for treenuts use something higher, my assumption: 0.6
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Treenuts)     = 0.6;
*Stimulants and spices are assigned below in all generality
*VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Stimulants_Spices)
*fibre / rubber: use the value given below for hempseed
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Fibres_Rubber)= 1.0;

*More detailed, as used above for deriving N contents.
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Wheat")     = 0.85;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Barley")    = 0.85;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Maize")     = 0.85;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Oats")      = 0.85;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Rye")       = 0.85;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Triticale") = 0.85;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Millet")    = 0.85;

VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Pulses)= 0.85;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Beans, dry")= 0.85;
*"peas, dry" is not reported, but use the same as for "beans, dry"
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Peas, dry")= 0.85;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Soybeans")  = 0.85;
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_ForReadingDataLeguminousVegetables) = 0.16;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Lupins")    = 0.85;

VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Starchy_Roots)          = 0.15;
*potatoe is the same as "other" rootss and tubers as no tspecific entry is given for potatoes in this table (but there is a specific empty line for potatoes)
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Potatoes")  = 0.13;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Sugar beet")= 0.15;

*residue DM content missing, use CH inventory values
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOLD_Fruits)    = 0.17;
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_ForReadingDataBerries)    = 0.2;
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_ForReadingDataNonLeguminousVegetables)  = 0.13;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Maize, green")    = 0.32;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Rapeseed")        = 0.85;
*residue DM content missing, use the same as for "Lupins"
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Sunflower seed")  = 0.6;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Tobacco, unmanufactured")        = 0.13;
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Grapes")          = 0.2;
*we use "Pumpkins, squash and gourds" for "oil squash"
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Pumpkins, squash and gourds")    = 0.13;

*the following is not important, thus do not assign new values
$ontext;
*we use "Flax fibre and tow" for "oil flax"
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Flax fibre and tow")  = 0.85;
*we use "Hempseed" for "oil hemp"
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Hempseed")        = 1.0;
*residue DM content missing, use the same as for "oil flax"
VariousSources_Residue_DMContents(FAOSTAT_Countries,"Hops")            = 1.0;
*we use SOLmOld_Stimulants_Spices for "medicinal plants and herbs"
$offtext;

*residue DM content missing, use the same as for "tobacco, unmanufactures" (green plant matter, not driying before harvest))
VariousSources_Residue_DMContents(FAOSTAT_Countries,SOLmOld_Stimulants_Spices)    = 0.2;

*ATTENTION: assure that this is the same as grass main yield DM contents
*we also had 0.32 here from the Swiss GHG inventory, derived from DM contents of green corn and silage corn, etc. being 0.32
*but as we use the current valu of 0.2 for DM contents, we use the same for the residues here.
*THUS: assign at the end in SOLm parameters: equal grass residues to grass, for which we already have values from the grass module (for N, Dm,, etc.)
*VariousSources_GrassResidue_DMContents(FAOSTAT_Countries,NON_FAOSTAT_GrassActivities)    = 0.2;

*the table used abov ehas also data for the following, but this is currently not used, as we do not have this item in FAOSTAT
*VariousSources_Residue_DMContents(FAOSTAT_Countries,"Peas (Eiweisserbsen)")    = 0.85;
*VariousSources_Residue_DMContents(FAOSTAT_Countries,"Fodder beet")    = 0.15;
*VariousSources_Residue_DMContents(FAOSTAT_Countries,"Renewable energy crops")    = 0.32;
*VariousSources_Residue_DMContents(FAOSTAT_Countries,"Silage corn")    = 0.6;


*1.4) Residue shares

*unit for residue shares: shares of yield, i.e. tons residues per ton yield
*The residue shares in the excel-sheet used in the older SOLm-Versions (before V4) seem much too low as many are 20% and this does not make sense,
*        see e.g. http://home.cc.umanitoba.ca/~vsmil/pdf_pubs/originalpdfs/biosc1.pdf, Crop Residues - Agricultures largest harvest, Vaclav Smil 1999 BioScience, Table 1
*there, Harvest index is used: HI = yield DM /(yield Dm+ residue DM), thus: residue = (1/HI - 1)*yield, thus residue share = 1/HI-1
*HI data is available - for grain, e.g. 0.4, thus residue share is 1.5, not 0.2!!
*thus, from version V4 onwards, we replace the values in this old excel sheet with the following from table 1 in the reference given above (Crop Residues - Agricultures largest harvest, Vaclav Smil 1999 BioScience)
*ATTENTION: these are based on HI, which is based on DM comparison - thus multiply yields with DM contents and only then apply these values to get residue quantities - which are then in DM!

*NO - currently we do it as follows:
*this procedure described just above is complicated - we directly use the values from IPCC below: Bretscher 2013/IPCC inventories of CH, etc.:
*values: see also second table below

*REMARK: this values do not account for potentially unproportional changes of residues with yields, or for different residue shares between systems (organic vs. conventional, etc.)

*unit: t resid DM / t yield DM
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Grains)
*         = 1/0.4 -1;
         = 1.15;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Sugars_And_Sweeteners)
*         = 1/0.56 -1;
*just assume the average as provided below:
         = 0.8;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Starchy_Roots)
*         = 1/0.4 -1;
         = 0.4;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Potatoes") = 0.47;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Sugar beet") = 0.67;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Vegetables)
*         = 1/0.38 -1;
         = 0.46;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Fruits)
*         = 1/0.38 -1;
         = 0.4;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Pulses)
*         = 1/0.49 -1;
         = 1.2;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Oil_Crops)
*         = 1/0.52 -1;
         = 1.9;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Soybeans") = 1;
*treenuts: perennial crops, residues from leaves, prunings, etc. - so my assumption, after some search on hazelnut yields and residues and assuming that other may have less residues is a residue share of 1.5
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Treenuts)
         = 1.5;
$ontext;
OLD VALUES
*stimulants and spices - just assume the general residue share given for "other crops" in the table from Smil:
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Stimulants_Spices)
         = 1/0.28 -1;
*similar, assume this as well for fibres:
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Fibres_Rubber)
         = 1/0.28 -1;
*for cotton, this will be rather higher - based on some short web-search, assume a factor of 8 rather between cotton fibre and residues - thus, factor of about 4 between seed cotton (fibre PLUS seeds!) and residues:
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Seed cotton")
         = 4;
$offtext;


*Improve some data by using values from the CH GHG inventory 2019, table A-25 - there, direct values for ratio crop res/yield are given - IPCC and AT inventory give parameters for the estimation only.
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_grains)= 1.15;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Wheat")     = 1.15;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Barley")    = 1.00;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Maize")     = 1.10;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Oats")      = 1.27;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Rye")       = 1.17;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Triticale") = 1.25;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Millet")    = 1.29;

*pulses: just assume some middle value: 1.15
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Pulses)= 1.15;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Beans, dry")= 1.13;
*"peas, dry" is not reported, but use the same as for "beans, dry"
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Peas, dry")= 1.25;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Soybeans")  = 1;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_ForReadingDataLeguminousVegetables) = 3.87;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Lupins")    = 1;

*roots: same as potatoes
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Starchy_Roots)          = 0.47;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Potatoes")  = 0.47;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Sugar beet")= 0.53;

*residue DM content missing, use the same as for "Berries"
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Rapeseed")        = 2.57;
*residue DM content missing, use the same as for "Lupins"
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Sunflower seed")  = 2;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Tobacco, unmanufactured")        = 1.18;

*we use "Pumpkins, squash and gourds" for "oil squash"
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Pumpkins, squash and gourds")    = 0.46;
*we use SOLmOld_Stimulants_Spices for "medicinal plants and herbs"
*residue DM content missing, use the same as for "tobacco, unmanufactures" (green plant matter, not driying before harvest))
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Stimulants_Spices)    = 2.5;



*Further adjustment:
*use general IPCC 2019 data: IPCC Revision 2019-V4-CH11-Table 11.1A
*as compiled by Fei Wu, Mail FiBL 7.6.2021
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Grains)  = 1.3;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Barley")  = 1.2;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Maize")     = 1.0;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Millet")     = 1.4;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Sorghum")     = 1.4;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Pulses)= 2.1;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Soybeans")  = 2.1;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,SOLmOld_Starchy_Roots) = 0.4;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Groundnuts, with shell") = 1;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Rice, paddy") = 1.4;
*Mail Fei Wu, 7.6.2021
*Fei Wu suggests 1.6 for other oilseeds and sesame seed, we keep 1.9 from above.
*she suggests 0.2 for raw cotton - we keep 1.9 as we have it.
*Fei Wu suggests some other values:
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Olives")     = 1.6;
VariousSources_ResidueSharesInDM(FAOSTAT_Countries,"Tea")     = 0.2;
*true, our value was quite high)
*all these values suggested by Fei Wu are taken from Ronzon, T., Piotrowski, S., Carus, M., & others. DataM-Biomass estimates (v3): a new database to quantify biomass availability in the European Union. Luxembourg: Institute for Prospective and Technological Studies, Joint Research Centre (2015).
*and IPCC has 1 for generic crops not further specified - we currently keep as it is




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Data from IPCC 2006 data

*use the procedure as described in IPCC 2006, chapter 11, table 11.2; resp. data from table A-30 in Swiss GHG inventory (see below)

*and also: check the data and approach of Lukas Schütz

$ontext;
*and also:
*using the data from the ART-2013a.pdf - for Switzerland, improved from 1PCC 2006, somewhat aggregated
ParameterPerTon(FAO_Countries_New,SET_ActGroup_Crops,"Crop","Residue share t DM / t DM yield","All","All","Baseline")
                        = 0.8;
ParameterPerTon(FAO_Countries_New,SET_ActGroup_Grains,"Crop","Residue share t DM / t DM yield","All","All","Baseline")
                     = 1.15;
*ParameterPerTon(FAO_Countries_New,SET_ActGroup_Sugars_And_Sweeteners,"Crop","Residue share t DM / t DM yield","All","All","Baseline")
*                   = ;
ParameterPerTon(FAO_Countries_New,SET_ActGroup_Starchy_Roots,"Crop","Residue share t DM / t DM yield","All","All","Baseline")
                    = 0.4;
ParameterPerTon(FAO_Countries_New,"Potatoes","Crop","Residue share t DM / t DM yield","All","All","Baseline")
                    = 0.47;
ParameterPerTon(FAO_Countries_New,"Sugar beet","Crop","Residue share t DM / t DM yield","All","All","Baseline")
                    = 0.67;
*vegetables and fruits as above
ParameterPerTon(FAO_Countries_New,SET_ActGroup_Vegetables,"Crop","Residue share t DM / t DM yield","All","All","Baseline")
                    =0.46;
ParameterPerTon(FAO_Countries_New,SET_ActGroup_Fruits,"Crop","Residue share t DM / t DM yield","All","All","Baseline")
                    =0.4;
ParameterPerTon(FAO_Countries_New,SET_ActGroup_Legumes,"Crop","Residue share t DM / t DM yield","All","All","Baseline")
                   = 1.2;
ParameterPerTon(FAO_Countries_New,SET_ActGroup_Oil_Crops,"Crop","Residue share t DM / t DM yield","All","All","Baseline")
                   = 1.9;
ParameterPerTon(FAO_Countries_New,"Soybeans","Crop","Residue share t DM / t DM yield","All","All","Baseline")
                   = 1;
ParameterPerTon(FAO_Countries_New,SET_ActGroup_ForageCrops,"Crop","Residue share t DM / t DM yield","All","All","Baseline")
                   = 0;
$offtext;




$ontext;
after this, we have:
Parameter VariousSources_Residue_NContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter VariousSources_Residue_PContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter VariousSources_Residue_DMContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter VariousSources_ResidueSharesInDM(FAOSTAT_Countries,FAOSTAT_CropProductionItems);

Parameter VariousSources_GrassResidue_NContents(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_GrassActivities);
Parameter VariousSources_GrassResidue_PContents(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_GrassActivities);
Parameter VariousSources_GrassResidue_DMContents(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_GrassActivities);
Parameter VariousSources_GrassResidueSharesInDM(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_GrassActivities);
$offtext;





****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

*no new files needed


*3.2) Link to the core model parameters

CropResidues_Contents(Regions,Activities,"Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)),
                 VariousSources_Residue_NContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems));

CropResidues_Contents(Regions,Activities,"Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)),
                 VariousSources_Residue_PContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems));

CropResidues_Contents(Regions,Activities,"Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)),
                 VariousSources_Residue_DMContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems));

CropResidues_OtherChar(Regions,Activities,"Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)),
                 VariousSources_ResidueSharesInDM(FAOSTAT_Countries,FAOSTAT_CropProductionItems));

$ontext;
OLD CODE - not used anymore
CropResidues_Contents(Regions,"Temporary meadows and pastures","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")
*the condition is needed to avoid overwriting the assignments made above by the new assignments below
                 $(NOT CropResidues_Contents(Regions,"Temporary meadows and pastures","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_GrassResidue_NContents(FAOSTAT_Countries,"Temporary meadows and pastures"));
CropResidues_Contents(Regions,"Permanent meadows and pastures","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")
*the condition is needed to avoid overwriting the assignments made above by the new assignments below
                 $(NOT CropResidues_Contents(Regions,"Permanent meadows and pastures","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_GrassResidue_NContents(FAOSTAT_Countries,"Permanent meadows and pastures"));

CropResidues_Contents(Regions,"Temporary meadows and pastures","Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond")
*the condition is needed to avoid overwriting the assignments made above by the new assignments below
                 $(NOT CropResidues_Contents(Regions,"Temporary meadows and pastures","Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_GrassResidue_PContents(FAOSTAT_Countries,"Temporary meadows and pastures"));
CropResidues_Contents(Regions,"Permanent meadows and pastures","Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond")
*the condition is needed to avoid overwriting the assignments made above by the new assignments below
                 $(NOT CropResidues_Contents(Regions,"Permanent meadows and pastures","Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_GrassResidue_PContents(FAOSTAT_Countries,"Permanent meadows and pastures"));

CropResidues_Contents(Regions,"Temporary meadows and pastures","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond")
*the condition is needed to avoid overwriting the assignments made above by the new assignments below
                 $(NOT CropResidues_Contents(Regions,"Temporary meadows and pastures","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_GrassResidue_DMContents(FAOSTAT_Countries,"Temporary meadows and pastures"));
CropResidues_Contents(Regions,"Permanent meadows and pastures","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond")
*the condition is needed to avoid overwriting the assignments made above by the new assignments below
                 $(NOT CropResidues_Contents(Regions,"Permanent meadows and pastures","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond"))
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_GrassResidue_DMContents(FAOSTAT_Countries,"Permanent meadows and pastures"));

CropResidues_OtherChar(Regions,"Temporary meadows and pastures","Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_GrassResidueSharesInDM(FAOSTAT_Countries,"Temporary meadows and pastures"));
CropResidues_OtherChar(Regions,"Permanent meadows and pastures","Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_GrassResidueSharesInDM(FAOSTAT_Countries,"Permanent meadows and pastures"));

*now overwrite the main crop N and P contents for grass with these values for residues above, as residues and main crop are the same for grass, but current values are inconsistent:
Commod_Contents(Regions,"Temporary meadows and pastures","N (t)","AllProdSyst","AllProdCond")
         = CropResidues_Contents(Regions,"Temporary meadows and pastures","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond");
Commod_Contents(Regions,"Permanent meadows and pastures","N (t)","AllProdSyst","AllProdCond")
         = CropResidues_Contents(Regions,"Permanent meadows and pastures","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond");

Commod_Contents(Regions,"Temporary meadows and pastures","P2O5 (t)","AllProdSyst","AllProdCond")
         = CropResidues_Contents(Regions,"Temporary meadows and pastures","Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond");
Commod_Contents(Regions,"Permanent meadows and pastures","P2O5 (t)","AllProdSyst","AllProdCond")
         = CropResidues_Contents(Regions,"Permanent meadows and pastures","Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond");

$offtext;


*ADD GRASSLAND VALUES HERE: for grass, residue values equal main output values
CropResidues_Contents(Regions,"Temporary meadows and pastures","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")
         = Commod_Contents(Regions,"Temporary meadows and pastures","N (t)","AllProdSyst","AllProdCond");

CropResidues_Contents(Regions,"Permanent meadows and pastures","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond")
         = Commod_Contents(Regions,"Permanent meadows and pastures","N (t)","AllProdSyst","AllProdCond");

CropResidues_Contents(Regions,"Temporary meadows and pastures","Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond")
         = Commod_Contents(Regions,"Temporary meadows and pastures","P2O5 (t)","AllProdSyst","AllProdCond");

CropResidues_Contents(Regions,"Permanent meadows and pastures","Average residues (t)","P2O5 (t) - before management","AllProdSyst","AllProdCond")
         = Commod_Contents(Regions,"Permanent meadows and pastures","P2O5 (t)","AllProdSyst","AllProdCond");

CropResidues_Contents(Regions,"Temporary meadows and pastures","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond")
         = Commod_Contents(Regions,"Temporary meadows and pastures","DM (t)","AllProdSyst","AllProdCond");

CropResidues_Contents(Regions,"Permanent meadows and pastures","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond")
         = Commod_Contents(Regions,"Permanent meadows and pastures","DM (t)","AllProdSyst","AllProdCond");

*for grass, residue shares are DERIVED as the difference between yields and biomass harvested or grazed - thus, to be done later.
*but to have something, assign a value here, to be overwritten with better data after harvest/grazing are quantified
*thus use the data from the Swiss GHG inventory, issue 2019, table A-25 in the Appendix: there, 0.24 is the residue/crop ratio used for grass, thus use this as well.
*HOWEVER - we use 0.2 to better meet the OECD N balance, grassland outputs
CropResidues_OtherChar(Countries,"Temporary meadows and pastures","Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond")
         = 0.24;
CropResidues_OtherChar(Countries,"Permanent meadows and pastures","Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond")
         = 0.24;



*AND ADD SOME CROPS THAT ARE ONLY AVAILABLE IN SOLm entities (CH GHG inventory 2019, Table A-25):
CropResidues_Contents(Countries,"Maize for Forage+Silage","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond") = 0.0118*0.32;
CropResidues_Contents(Countries,"Maize for Forage+Silage","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond") = 0.32;
CropResidues_OtherChar(Countries,"Maize for Forage+Silage","Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond") = 0.05;

CropResidues_Contents(Countries,"Beets for fodder","Average residues (t)","N (t) - before management","AllProdSyst","AllProdCond") = 0.0233*0.15;
CropResidues_Contents(Countries,"Beets for fodder","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond") = 0.15;
CropResidues_OtherChar(Countries,"Beets for fodder","Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond") = 0.37;


$ontext;
After this we have the following in SOLm-entities:

CropResidues_Contents(Regions,Activities,"Average residues (t)",CropResContents,"AllProdSyst","AllProdCond")
CropResidues_OtherChar(Regions,Activities,"Average residues (t)",CropResOtherChar,"AllProdSyst","AllProdCond")

Activities        is      FAOSTAT_CropProductionItems
                         "Temporary meadows and pastures", "Permanent meadows and pastures"
Regions           is      FAOSTAT_Countries
CropResContents   is      N, P2O5, DM (t) - before management
CropResOtherChar  is     "Residue share t DM / t DM MainOutput1"

*XXX STILL TO BE DONE:
Add: data for forage in NON_FAOSTAT_GrassActivities
         but may assume: residues with forage crops are zero (besides roots)
ADD: FeedME, FeedGE, FeedXP for all residues
Check all data in this file and improve, differentiate, where needed and useful - e.g. add IPCC2006 data and calculations
$offtext;


