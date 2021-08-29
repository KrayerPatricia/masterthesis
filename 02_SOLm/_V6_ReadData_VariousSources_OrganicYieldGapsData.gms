PUTCLOSE con,"_V6_ReadData_VariousSources_OrganicYieldGapsData";

$ontext;
GENERAL DESCRIPTION
This file assigns the yield gap values from the various reviews available in the literature

For the yield gap, we use the values for the reported categories from Badgley, Seufert and DePonti -
for the categories missing there (treenuts, stimulants, fibres, FeedCrops),
        we used their values for "all plant foods": Badgley: 0.914 in developed, 1.325 in developing countries; Seufert: 0.75 and 1; DePonti: 0.79 and 0.84

due to lack of data and as there is no general evidence for on aggregate significant yield gap differences: we use a yield gap of 1 for grass


DETAILED TABLE OF CONTENTS
- 1) Yield gap Badgley
- 2) Yield gap Seufert
- 3) Yield gap DePonti
- 4) Yield gap Ponisio
- 5) Assign organic area shares
- 6) Assign values to core model parameters and variables
         6.1) Link some sets as needed
         6.2) Link to the core model parameters
$offtext;


*Now already address the yield gap - mainly for the next module
Parameter YieldGapBadgleyCropGroups(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItemGroups);
Parameter YieldGapBadgleyCrops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter YieldGapSeufertCropGroups(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItemGroups);
Parameter YieldGapSeufertCrops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter YieldGapDePontiCropGroups(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItemGroups);
Parameter YieldGapDePontiCrops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter YieldGapPonisioCropGroups(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItemGroups);
Parameter YieldGapPonisioCrops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);

Parameter YieldGapBadgleyGrassForage(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_CropProductionItems);
Parameter YieldGapSeufertGrassForage(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_CropProductionItems);
Parameter YieldGapDePontiGrassForage(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_CropProductionItems);
Parameter YieldGapPonisioGrassForage(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_CropProductionItems);

Parameter YieldGapBadgleyAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems);
Parameter YieldGapSeufertAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems);
Parameter YieldGapDePontiAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems);
Parameter YieldGapPonisioAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems);

Parameter OrganicAreaShareCropGroups(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItemGroups);
Parameter OrganicAreaShareCrops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter OrganicAreaShareGrassForage(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_CropProductionItems);
Parameter OrganicShareAnimals(FAOSTAT_CountriesAndRegions,FAOSTAT_LivestockPrimaryItems);

*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Yield gap Badgley

$ontext;
has values for
"Cereals,Total"
"Fruit Primary"
"Oilcrops Primary"
"Pulses,Total"
"Roots and Tubers,Total"
"Vegetables Primary"

"Sugars and sweeteners"

the average value is assigned to the rest (treenuts, fibres) - "Crops Primary"
$offtext;

YieldGapBadgleyCropGroups("Developed Countries","Crops Primary")              = 0.914;
YieldGapBadgleyCropGroups("Developed Countries","Cereals,Total")              = 0.928;
YieldGapBadgleyCropGroups("Developed Countries","Fruit Primary")              = 0.955;
YieldGapBadgleyCropGroups("Developed Countries","Oilcrops Primary")           = 0.991;
*originally, pulses have a yield gap of 0.816 in Badgley;
*this value leads to unintuitive results when comparing high and low yield gaps, as Seufert has a LOWER yield gap for legumes in developed countries than Badgley!!! (cf. below).
*to avoid this, we just use the value from Seufert here as well,
YieldGapBadgleyCropGroups("Developed Countries","Pulses,Total")               = 0.9;
YieldGapBadgleyCropGroups("Developed Countries","Roots and Tubers,Total")     = 0.891;
YieldGapBadgleyCropGroups("Developed Countries","Vegetables Primary")         = 0.876;
*originally, sugars and sweeteners reported 1.005 - but we assign sugar cane and sugar crops, nes to the average, and sugar beets to roots and tubers - the higher values reported do not really make sense
*        to be done when assigning single crop values further down

YieldGapBadgleyCropGroups("Developing Countries","Crops Primary")              = 1.325;
YieldGapBadgleyCropGroups("Developing Countries","Cereals,Total")              = 1.573;
YieldGapBadgleyCropGroups("Developing Countries","Fruit Primary")              = 2.08;
YieldGapBadgleyCropGroups("Developing Countries","Oilcrops Primary")           = 1.645;
*originally, pulses have a yield gap of 0.816 in Badgley;
*this value leads to unintuitive results when comparing high and low yield gaps, as Seufert has a LOWER yield gap for legumes in developed countries than Badgley!!! (cf. below).
*to avoid this, we just use the value from Seufert here as well,
YieldGapBadgleyCropGroups("Developing Countries","Pulses,Total")               = 3.995;
YieldGapBadgleyCropGroups("Developing Countries","Roots and Tubers,Total")     = 2.697;
YieldGapBadgleyCropGroups("Developing Countries","Vegetables Primary")         = 2.038;
*originally, sugars and sweeteners reported 1.005 - but we assign sugar cane and sugar crops, nes to the average, and sugar beets to roots and tubers
*        to be done when assigning single crop values further down

*for some calculations with Badgley: use yield equal conv/org in Developing countries:
$if "%BadgleyDeveloping%" == "NO" YieldGapBadgleyCropGroups("Developing Countries","Crops Primary") = 1;

*assign grass and animal values specifically:
YieldGapBadgleyGrassForage("Developed Countries",NON_FAOSTAT_CropProductionItems) = 1;
YieldGapBadgleyGrassForage("Developing Countries",NON_FAOSTAT_CropProductionItems) = 1;

YieldGapBadgleyAnimals("Developed Countries",FAOSTAT_LivestockPrimaryItems) = 0.968;
*the following value seems to be absurdely high! -
*ATTENTION - TO BE CHECKED!!
YieldGapBadgleyAnimals("Developing Countries",FAOSTAT_LivestockPrimaryItems) = 2.694;

*assign from the categories developing/developed countries to single countries
YieldGapBadgleyCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapBadgleyCropGroups(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_CropProductionItemGroups));
YieldGapBadgleyGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapBadgleyGrassForage(FAOSTAT_DevelopedDevelopingGroups,NON_FAOSTAT_CropProductionItems));
YieldGapBadgleyAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapBadgleyAnimals(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_LivestockPrimaryItems));

*assign to single crops:
YieldGapBadgleyCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems)
         =sum(FAOSTAT_CropProductionItemGroups_CompleteExclusive$FAOSTAT_CropProductionItemsInItemGroups(FAOSTAT_CropProductionItemGroups_CompleteExclusive,FAOSTAT_CropProductionItems),
                 YieldGapBadgleyCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups_CompleteExclusive));

*specifically for developing countries:
YieldGapBadgleyCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems)
                 $(NOT YieldGapBadgleyCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems))
         = YieldGapBadgleyCropGroups(FAOSTAT_Countries,"Crops Primary");

*the following: still needed?
*when assigning to single crops: assign for the subgroups
*        then assign the general crop average conditional to values for single crops already being present -
*        this assigns values to all crops not covered by the subgroups where specific values are avaiable
*In the end: assign root and tuber values to sugar beet



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Yield gap Seufert

*Comments SEUFERT: Total: Organic yields are 25% less than conventional ones; In developed countries only, org yields are 20% less, in developing countries org yields are 43% less
*This is owed to the fact that in developing countries comparisons are with conventional high yield systems, that are much better than local averages.
*If only comparisons at local yield levels in developing countries  are used (few data) then organic yields are on par with conventional yields;
*        therefore we use the factor 1 for organic yields in developing countries for Seufert.
*We emphasize, that for developing countries: only all plant averages are provided in Seufert
*Values for starchy roots, sugar, animals are missing in Seufert: for developed yountries, we used the average 0.75 for those crops, 0.9 for animals
*roots and tubers are average - thus sugar beet as well, thus no need to assign specifically

YieldGapSeufertCropGroups("Developed Countries","Crops Primary")              = 0.75;
YieldGapSeufertCropGroups("Developed Countries","Cereals,Total")              = 0.75;
YieldGapSeufertCropGroups("Developed Countries","Fruit Primary")              = 1;
YieldGapSeufertCropGroups("Developed Countries","Oilcrops Primary")           = 0.9;
YieldGapSeufertCropGroups("Developed Countries","Pulses,Total")               = 0.9;
YieldGapSeufertCropGroups("Developed Countries","Roots and Tubers,Total")     = 0.75;
YieldGapSeufertCropGroups("Developed Countries","Vegetables Primary")         = 0.7;
YieldGapSeufertCropGroups("Developed Countries","Treenuts,Total")             = 0.75;

*developing countries:
*default: equal to developed countries (as we often work with 2050 projections .- thus assuming enough techonological progress on all production that we see similar yield gaps)
YieldGapSeufertCropGroups("Developing Countries",FAOSTAT_CropProductionItemGroups)
         = YieldGapSeufertCropGroups("Developed Countries",FAOSTAT_CropProductionItemGroups);

*for some calculations: use organic yield equal to conventional yield, i.e. a yield gap = 1 in Developing countries:
$if "%SeufertDevelopingOrgEqualsConv%" == "YES" YieldGapSeufertCropGroups("Developing Countries","Crops Primary") = 1;



*when assigning to single crops: assign for the subgroups, then assign the general crop average conditional to values for single crops already being present -
*        this assigns values to all crops not covered by the subgroups where specific values are avaiable


*assign forage, grass and animal values specifically:
YieldGapSeufertGrassForage("Developed Countries",NON_FAOSTAT_CropProductionItems) = 0.9;
YieldGapSeufertGrassForage("Developing Countries",NON_FAOSTAT_CropProductionItems) = 0.9;
*the above also assigns to grass, this ahould however be without gap, in general:
YieldGapSeufertGrassForage("Developed Countries",NON_FAOSTAT_GrassActivities) = 1;
YieldGapSeufertGrassForage("Developing Countries",NON_FAOSTAT_GrassActivities) = 1;

YieldGapSeufertAnimals("Developed Countries",FAOSTAT_LivestockPrimaryItems) = 0.9;
YieldGapSeufertAnimals("Developing Countries",FAOSTAT_LivestockPrimaryItems) = 1;

*assign from the categories developing/developed countries to single countries
YieldGapSeufertCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapSeufertCropGroups(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_CropProductionItemGroups));
YieldGapSeufertGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapSeufertGrassForage(FAOSTAT_DevelopedDevelopingGroups,NON_FAOSTAT_CropProductionItems));
YieldGapSeufertAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapSeufertAnimals(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_LivestockPrimaryItems));

*assign to single crops:
YieldGapSeufertCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems)
         =sum(FAOSTAT_CropProductionItemGroups_CompleteExclusive$FAOSTAT_CropProductionItemsInItemGroups(FAOSTAT_CropProductionItemGroups_CompleteExclusive,FAOSTAT_CropProductionItems),
                 YieldGapSeufertCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups_CompleteExclusive));
*specifically for developing countries:
YieldGapSeufertCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems)
                 $(NOT YieldGapSeufertCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems))
         = YieldGapSeufertCropGroups(FAOSTAT_Countries,"Crops Primary");



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Yield gap DePonti

*Comments DePONTI
*we used tha data provided for "pulses" for legumes as well
*for developing countries, data is given only for all crops together, thus we use this value for all crop categories
*0.79 is average, assigned to the categories not covered below specifically (stimulants, fibres, feed,...)
*DePonti reports no values for animal products - therefore we assume 1

YieldGapDePontiCropGroups("Developed Countries","Crops Primary")              = 0.79;
YieldGapDePontiCropGroups("Developed Countries","Cereals,Total")              = 0.79;
YieldGapDePontiCropGroups("Developed Countries","Fruit Primary")              = 0.72;
YieldGapDePontiCropGroups("Developed Countries","Oilcrops Primary")           = 0.74;
YieldGapDePontiCropGroups("Developed Countries","Pulses,Total")               = 0.88;
YieldGapDePontiCropGroups("Developed Countries","Roots and Tubers,Total")     = 0.74;
YieldGapDePontiCropGroups("Developed Countries","Vegetables Primary")         = 0.8;
YieldGapDePontiCropGroups("Developed Countries","Treenuts,Total")             = 0.79;

YieldGapDePontiCropGroups("Developing Countries","Crops Primary")              = 0.84;

*when assigning to single crops: assign for the subgroups
*        then assign the general crop average conditional to values for single crops already being present -
*        this assigns values to all crops not covered by the subgroups where specific values are avaiable
*In the end: assign root and tuber values to sugar beet

*assign grass and animal values specifically:
YieldGapDePontiGrassForage("Developed Countries",NON_FAOSTAT_CropProductionItems) = 1;
YieldGapDePontiGrassForage("Developing Countries",NON_FAOSTAT_CropProductionItems) = 1;

YieldGapDePontiAnimals("Developed Countries",FAOSTAT_LivestockPrimaryItems) = 1;
YieldGapDePontiAnimals("Developing Countries",FAOSTAT_LivestockPrimaryItems) = 1;

*assign from the categories developing/developed countries to single countries
YieldGapDePontiCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapDePontiCropGroups(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_CropProductionItemGroups));
YieldGapDePontiGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapDePontiGrassForage(FAOSTAT_DevelopedDevelopingGroups,NON_FAOSTAT_CropProductionItems));
YieldGapDePontiAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapDePontiAnimals(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_LivestockPrimaryItems));

*assign to single crops:
YieldGapDePontiCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems)
         =sum(FAOSTAT_CropProductionItemGroups_CompleteExclusive$FAOSTAT_CropProductionItemsInItemGroups(FAOSTAT_CropProductionItemGroups_CompleteExclusive,FAOSTAT_CropProductionItems),
                 YieldGapDePontiCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups_CompleteExclusive));

*specifically for developing countries:
YieldGapDePontiCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems)
                 $(NOT YieldGapDePontiCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems))
         = YieldGapDePontiCropGroups(FAOSTAT_Countries,"Crops Primary");

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Yield gap Ponisio
*Taken from Ponisio, L.C., et al., 2015. Diversification practices reduce organic to conventional yield gap. Proc. R. Soc. Lond. B Biol. Sci. 282 (1799), 20141396.

YieldGapPonisioCropGroups("Developed Countries","Crops Primary")              = 0.81;
YieldGapPonisioCropGroups("Developed Countries","Cereals,Total")              = 0.78;
YieldGapPonisioCropGroups("Developed Countries","Fruit Primary")              = 0.93;
YieldGapPonisioCropGroups("Developed Countries","Oilcrops Primary")           = 0.87;
YieldGapPonisioCropGroups("Developed Countries","Pulses,Total")               = 0.85;
YieldGapPonisioCropGroups("Developed Countries","Roots and Tubers,Total")     = 0.72;
YieldGapPonisioCropGroups("Developed Countries","Vegetables Primary")         = 0.83;
YieldGapPonisioCropGroups("Developed Countries","Treenuts,Total")             = 0.93;

*developing countries:
*default: equal to developed countries (as we often work with 2050 projections .- thus assuming enough techonological progress on all production that we see similar yield gaps)
YieldGapPonisioCropGroups("Developing Countries",FAOSTAT_CropProductionItemGroups)
         = YieldGapPonisioCropGroups("Developed Countries",FAOSTAT_CropProductionItemGroups);

*for some calculations: use organic yield equal to conventional yield, i.e. a yield gap = 1 in Developing countries:
$if "%PonisioDevelopingOrgEqualsConv%" == "YES" YieldGapPonisioCropGroups("Developing Countries","Crops Primary") = 1;


*when assigning to single crops: assign for the subgroups, then assign the general crop average conditional to values for single crops already being present -
*        this assigns values to all crops not covered by the subgroups where specific values are avaiable


*assign forage, grass and animal values specifically:
YieldGapPonisioGrassForage("Developed Countries",NON_FAOSTAT_CropProductionItems) = 0.9;
YieldGapPonisioGrassForage("Developing Countries",NON_FAOSTAT_CropProductionItems) = 0.9;
*the above also assigns to grass, this ahould however be without gap, in general:
YieldGapPonisioGrassForage("Developed Countries",NON_FAOSTAT_GrassActivities) = 1;
YieldGapPonisioGrassForage("Developing Countries",NON_FAOSTAT_GrassActivities) = 1;

YieldGapPonisioAnimals("Developed Countries",FAOSTAT_LivestockPrimaryItems) = 0.9;
YieldGapPonisioAnimals("Developing Countries",FAOSTAT_LivestockPrimaryItems) = 1;

*assign from the categories developing/developed countries to single countries
YieldGapPonisioCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapPonisioCropGroups(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_CropProductionItemGroups));
YieldGapPonisioGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapPonisioGrassForage(FAOSTAT_DevelopedDevelopingGroups,NON_FAOSTAT_CropProductionItems));
YieldGapPonisioAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems)
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                 YieldGapPonisioAnimals(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_LivestockPrimaryItems));

*assign to single crops:
YieldGapPonisioCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems)
         =sum(FAOSTAT_CropProductionItemGroups_CompleteExclusive$FAOSTAT_CropProductionItemsInItemGroups(FAOSTAT_CropProductionItemGroups_CompleteExclusive,FAOSTAT_CropProductionItems),
                 YieldGapPonisioCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups_CompleteExclusive));
*specifically for developing countries:
YieldGapPonisioCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems)
                 $(NOT YieldGapPonisioCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems))
         = YieldGapPonisioCropGroups(FAOSTAT_Countries,"Crops Primary");




$ontext;
after this, we have:
Parameter YieldGapBadgleyCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups);
Parameter YieldGapSeufertCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups);
Parameter YieldGapDePontiCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups);
Parameter YieldGapPonisioCropGroups(FAOSTAT_Countries,FAOSTAT_CropProductionItemGroups);
Parameter YieldGapBadgleyCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter YieldGapSeufertCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter YieldGapDePontiCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter YieldGapPonisioCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter YieldGapBadgleyGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems);
Parameter YieldGapSeufertGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems);
Parameter YieldGapDePontiGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems);
Parameter YieldGapPonisioGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems);
Parameter YieldGapBadgleyAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems);
Parameter YieldGapSeufertAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems);
Parameter YieldGapDePontiAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems);
Parameter YieldGapPonisioAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems);
$offtext;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) Assign organic area shares
*assume the global average of 1% - to be imrpoved with data from Willer, The World of Organic": use detailed per country and crop values
*do it directly to SOLm-entities
*do it conditional to non-zero areas and animal numnbers to avoid useless combinations of dimensions

ActCropsGrass_OtherChar(Regions,Activities,"share organic in total area (share ha)","AllProdSyst","AllProdCond")
                 $VActCropsGrass_QuantityActUnits.l(Regions,Activities,"AllProdSyst","AllProdCond")
         = 0.01;
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"share organic in total animals (share heads)","AllProdSyst","AllProdCond")
                 $VActAnimalsHead_QuantityActUnits.l(Regions,Livestock,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
         = 0.01;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) Assign values to core model parameters and variables
*6.1) Link some sets as needed

Set MatchFAOSTATLivestockPrimary_Activities(FAOSTAT_LivestockPrimaryItems,Activities,AnimalTypeInHerd)
*TO BE CHECKED AGAIN: is the "indigenous" item really the best estimate for domestic production? I think so, but check the definitions again.
*        and do we loose something significant by dropping some of the items?
/
*"Beef and Buffalo Meat"
"Beeswax"."Beehives"."Wax Producing"
*"Eggs Primary"
"Eggs, hen, in shell"."Chickens"."Egg Producing"
*"Eggs, hen, in shell (number)"
"Eggs, other bird, in shell"."Pigeons, other birds"."Egg Producing"
*"Eggs, other bird, in shell (number)"
*"Hair, horse"
"Hides, buffalo, fresh"."Buffaloes"."HidesSkins Producing"
"Hides, cattle, fresh"."Cattle"."HidesSkins Producing"
"Honey, natural"."Beehives"."Honey Producing"
"Meat indigenous, ass"."Asses"."Meat Producing"
"Meat indigenous, bird nes"."Pigeons, other birds"."Meat Producing"
"Meat indigenous, buffalo"."Buffaloes"."Meat Producing"
"Meat indigenous, camel"."Camels"."Meat Producing"
"Meat indigenous, cattle"."Cattle"."Meat Producing"
"Meat indigenous, chicken"."Chickens"."Meat Producing"
"Meat indigenous, duck"."Ducks"."Meat Producing"
"Meat indigenous, geese"."Geese and guinea fowls"."Meat Producing"
"Meat indigenous, goat"."Goats"."Meat Producing"
"Meat indigenous, horse"."Horses"."Meat Producing"
"Meat indigenous, mule"."Mules"."Meat Producing"
"Meat indigenous, other camelids"."Camelids, other"."Meat Producing"
"Meat indigenous, pig"."Pigs"."Meat Producing"
*"Meat indigenous, poultry"
"Meat indigenous, rabbit"."Rabbits and hares"."Meat Producing"
"Meat indigenous, rodents"."Rodents, other"."Meat Producing"
"Meat indigenous, sheep"."Sheep"."Meat Producing"
*"Meat indigenous, total"
"Meat indigenous, turkey"."Turkeys"."Meat Producing"
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
"Milk, whole fresh buffalo"."Buffaloes"."Milk Producing"
"Milk, whole fresh camel"."Camels"."Milk Producing"
"Milk, whole fresh cow"."Cattle"."Milk Producing"
"Milk, whole fresh goat"."Goats"."Milk Producing"
"Milk, whole fresh sheep"."Sheep"."Milk Producing"
*"Milk,Total"
"Offals, nes"."Animals live nes"."Offals Producing"
*"Pigeons, other birds"
*"Sheep and Goat Meat"
*"Silk-worm cocoons, reelable"
*"Skins, furs"
"Skins, goat, fresh"."Goats"."HidesSkins Producing"
"Skins, sheep, fresh"."Sheep"."HidesSkins Producing"
*"Skins, sheep, with wool"
*"Snails, not sea"
"Wool, greasy"."Sheep"."Wool Producing"
/;

*6.2) Link to the core model parameters

*assign for single countries only, not for the groups developing/developed countries

$if %YieldGapSource% == "Badgley" $goto YieldGapBadgley
$if %YieldGapSource% == "Seufert" $goto YieldGapSeufert
$if %YieldGapSource% == "DePonti" $goto YieldGapDePonti
$if %YieldGapSource% == "Ponisio" $goto YieldGapPonisio


$label YieldGapBadgley
ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
         =sum((FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapBadgleyCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems));
ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
*the condition is needed to avoid that the following overwrites the assignments already made above
                 $(NOT ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond"))
         =sum((NON_FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchNonFaoCropItems_Activities(NON_FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapBadgleyGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems));
ActAnimalsHead_OtherChar(Regions,Livestock,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
*the condition is needed to avoid that the following overwrites the assignments already made above
                 $(NOT ActAnimalsHead_OtherChar(Regions,Livestock,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(MatchFAOSTATLivestockPrimary_Activities(FAOSTAT_LivestockPrimaryItems,Livestock,ProducingAnimals)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapBadgleyAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems));

$goto EndOfYieldGapAssignemnt


$label YieldGapSeufert
ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
         =sum((FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapSeufertCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems));
ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
*the condition is needed to avoid that the following overwrites the assignments already made above
                 $(NOT ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond"))
         =sum((NON_FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchNonFaoCropItems_Activities(NON_FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapSeufertGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems));
ActAnimalsHead_OtherChar(Regions,Livestock,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
*the condition is needed to avoid that the following overwrites the assignments already made above
                 $(NOT ActAnimalsHead_OtherChar(Regions,Livestock,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(MatchFAOSTATLivestockPrimary_Activities(FAOSTAT_LivestockPrimaryItems,Livestock,ProducingAnimals)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapSeufertAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems));


$goto EndOfYieldGapAssignemnt


$label YieldGapDePonti
ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
         =sum((FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapDePontiCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems));
ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
*the condition is needed to avoid that the following overwrites the assignments already made above
                 $(NOT ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond"))
         =sum((NON_FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchNonFaoCropItems_Activities(NON_FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapDePontiGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems));
ActAnimalsHead_OtherChar(Regions,Livestock,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
*the condition is needed to avoid that the following overwrites the assignments already made above
                 $(NOT ActAnimalsHead_OtherChar(Regions,Livestock,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(MatchFAOSTATLivestockPrimary_Activities(FAOSTAT_LivestockPrimaryItems,Livestock,ProducingAnimals)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapDePontiAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems));

$goto EndOfYieldGapAssignemnt


$label YieldGapPonisio
ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
         =sum((FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapPonisioCrops(FAOSTAT_Countries,FAOSTAT_CropProductionItems));
ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
*the condition is needed to avoid that the following overwrites the assignments already made above
                 $(NOT ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond"))
         =sum((NON_FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchNonFaoCropItems_Activities(NON_FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapPonisioGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems));
ActAnimalsHead_OtherChar(Regions,Livestock,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
*the condition is needed to avoid that the following overwrites the assignments already made above
                 $(NOT ActAnimalsHead_OtherChar(Regions,Livestock,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LivestockPrimaryItems,FAOSTAT_Countries)$(MatchFAOSTATLivestockPrimary_Activities(FAOSTAT_LivestockPrimaryItems,Livestock,ProducingAnimals)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 YieldGapPonisioAnimals(FAOSTAT_Countries,FAOSTAT_LivestockPrimaryItems));

$goto EndOfYieldGapAssignemnt



$label EndOfYieldGapAssignemnt



$exit:





still to assign:
ActAnimalsAPU_OtherChar(Regions,Livestock,AnimalTypeInHerd,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")


$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Regions,Activities,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,ProducingAnimals,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
Activities        is      FAOSTAT_CropProductionItems
                          NON_FAOSTAT_CropProductionItems (includes some grass activities)

*XXX STILL TO BE DONE:

ASSIGN: ActAnimalsAPU_OtherChar(Regions,Livestock,AnimalTypeInHerd,"organic yield gap (ratio org/conv yield)","AllProdSyst","AllProdCond")

AND:
add "World of Organic" detailed organic area share values per country and crop

derive the true org and con yields, given average yields and org/con area shares
                 currently: you have the average yield (in most countries: conventional, due to the low share of organic) assumed to be conventional and then the yield gap applied to that to derive organic;
                         this is then an underestimation of the yields

*use the yield gap and shares to derive organic and conventional yields and work with them directly (instead of yield gap):
*$ontext;
Formulae to be used: Y: Yield, A: Area, YG: Yield Gap, P: production

Y(org) = Y(con)*YG

         P(all)     Y(org)*A(org) + Y(conv)*A(conv)   Y(conv)*YG*A(org) + Y(conv)*A(conv)      Y(conv)*YG*A(Conv)*Share(org) + Y(conv)*A(conv)     Y(conv)*A(Conv)*(YG*Share(org) + 1)
Y(All) = -----  = -------------------------------  = ------------------------------------  =  ------------------------------------------------ =  ------------------------------------
         A(all)           A(org) + A(conv)                    A(org) + A(conv)                        A(Conv)*Share(org) + A(conv)                        A(conv)*(Share(org) + 1)

Thus

          Y(conv)*(YG*Share(org) + 1)                   Y(All)*(1 + Share(org))
Y(All) = ----------------------------  =>    Y(conv) = --------------------------
               (Share(org) + 1)                          (1 + Share(org)*YG)


ParameterPerHa(GeographicUnits_New,ActivityUnits_New,"Crop","Yield (t/ha)","Convent","All","Baseline")
                 $(1 + ParameterPerHa(GeographicUnits_New,ActivityUnits_New,"Crop","Area share organic (ha/ha)","All","All","Baseline")*OrgYieldGap(GeographicUnits_New,ActivityUnits_New,"Crop"))
         = ParameterPerHa(GeographicUnits_New,ActivityUnits_New,"Crop","Yield (t/ha)","All","All","Baseline")
                 *(1 + ParameterPerHa(GeographicUnits_New,ActivityUnits_New,"Crop","Area share organic (ha/ha)","All","All","Baseline"))
             /(1 + ParameterPerHa(GeographicUnits_New,ActivityUnits_New,"Crop","Area share organic (ha/ha)","All","All","Baseline")*OrgYieldGap(GeographicUnits_New,ActivityUnits_New,"Crop"));

ParameterPerHa(GeographicUnits_New,ActivityUnits_New,"Crop","Yield (t/ha)","Organic","All","Baseline")
         = ParameterPerHa(GeographicUnits_New,ActivityUnits_New,"Crop","Yield (t/ha)","Convent","All","Baseline")
                 *OrgYieldGap(GeographicUnits_New,ActivityUnits_New,"Crop");

ParameterPerHa(GeographicUnits_New,ActivityUnits_New,"Crop","DMYield (tDM/ha)",ProductionSystems,"All","Baseline")
         = ParameterPerHa(GeographicUnits_New,ActivityUnits_New,"Crop","Yield (t/ha)",ProductionSystems,"All","Baseline")
                 *ParameterPerTon(GeographicUnits_New,ActivityUnits_New,"Crop","MainOutput DM cont (tDM/t)","All","All","Baseline");

*the same for animals:
*$ontext;
Formulae to be used: the same as for crops, just replace "Area" with "Number of animals": Y: Yield, A: AnimalNumber, YG: Yield Gap, P: production

Y(org) = Y(con)*YG

         P(all)     Y(org)*A(org) + Y(conv)*A(conv)   Y(conv)*YG*A(org) + Y(conv)*A(conv)      Y(conv)*YG*A(Conv)*Share(org) + Y(conv)*A(conv)     Y(conv)*A(Conv)*(YG*Share(org) + 1)
Y(All) = -----  = -------------------------------  = ------------------------------------  =  ------------------------------------------------ =  ------------------------------------
         A(all)           A(org) + A(conv)                    A(org) + A(conv)                        A(Conv)*Share(org) + A(conv)                        A(conv)*(Share(org) + 1)

Thus

          Y(conv)*(YG*Share(org) + 1)                   Y(All)*(1 + Share(org))
Y(All) = ----------------------------  =>    Y(conv) = --------------------------
               (Share(org) + 1)                          (1 + Share(org)*YG)


ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing","Yield (t/head)","Convent",ProductionConditions,"Baseline")
                 $(1 + ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing","Nr of animal share organic (head/head)","All",ProductionConditions,"Baseline")
                                 *OrgYieldGap(GeographicUnits_New,SET_ActGroup_Animals,OutputType))
         = ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing","Yield (t/head)","All",ProductionConditions,"Baseline")
                 *(1 + ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing","Nr of animal share organic (head/head)","All",ProductionConditions,"Baseline"))
             /(1 + ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing","Nr of animal share organic (head/head)","All",ProductionConditions,"Baseline")
                                 *OrgYieldGap(GeographicUnits_New,SET_ActGroup_Animals,OutputType));

ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing","Yield (t/head)","Organic",ProductionConditions,"Baseline")
         = ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing","Yield (t/head)","All",ProductionConditions,"Baseline")
                 *OrgYieldGap(GeographicUnits_New,SET_ActGroup_Animals,OutputType);


$offtext;










