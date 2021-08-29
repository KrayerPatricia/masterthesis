PUTCLOSE con,"_V6_ReadData_VariousSources_CropGrassNutrientRequirementsData";

$ontext;
GENERAL DESCRIPTION
This file assigns the crop and grass nutrient requirements values

DETAILED TABLE OF CONTENTS
- 1) Crop nutrient requirements data as defined in XXX
- 2) Grass nutrient requirements data as defined in XXX
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Crop nutrient requirements data as defined in XXX

*unit: kg N/t yield, kg P2O5/t yield, kg K2O/t yield;
Set ReadCropGrassNutrientElement
/
N_req
P_req
K_req
/;

*unit: kg N/t yield, kg P2O5/t yield, kg K2O/t yield;
Parameter CropNutrientRequirements_VariousSources(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ReadCropGrassNutrientElement,ProductionType);

*NUMBERS FOR WHEAT, 80dt yield; for organic, somewhat lower - to fill in something, different for conv/org, to be improved

CropNutrientRequirements_VariousSources("World","Wheat","N_req","Convent") = 220/8;
CropNutrientRequirements_VariousSources("World","Wheat","P_req","Convent") = 90/8;
CropNutrientRequirements_VariousSources("World","Wheat","K_req","Convent") = 160/8;

CropNutrientRequirements_VariousSources("World","Wheat","N_req","Organic") = 220/9;
CropNutrientRequirements_VariousSources("World","Wheat","P_req","Organic") = 90/9;
CropNutrientRequirements_VariousSources("World","Wheat","K_req","Organic") = 160/9;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Grass nutrient requirements data as defined in XXX

*unit: kg N/ha, kg P2O5/ha, kg K2O/ha;
Parameter GrassNutrientRequirements_VariousSources(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_CropProductionItems,ReadCropGrassNutrientElement,ProductionType);

*NUMBERS FOR Grass from  http://futterwiesenexpertehumer.wikispaces.com/file/view/Gute+Gr%C3%BCnde+die+D%C3%BCngung+im+Gr%C3%BCnland+nicht+zu+vernachl%C3%A4ssigen%2Cwebversion.pdf
*for organic: just somewhat lower
* - to fill in something, to be improved;

GrassNutrientRequirements_VariousSources("World","Grass","N_req","Convent") = 15;
GrassNutrientRequirements_VariousSources("World","Grass","P_req","Convent") = 8;
GrassNutrientRequirements_VariousSources("World","Grass","K_req","Convent") = 12;

GrassNutrientRequirements_VariousSources("World","Grass","N_req","Organic") = 13;
GrassNutrientRequirements_VariousSources("World","Grass","P_req","Organic") = 6;
GrassNutrientRequirements_VariousSources("World","Grass","K_req","Organic") = 10;






$exit;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

Set Match_ProductionType_ProductionTypeSOLmV5(ProductioNType,ProductionTypeSOLmV5)
/
AllProdTypes.AllProdTypes
AverageProdType.AverageProdType

Convent.Convent
Organic.Organic
/;

Set Match_ReadCropGrassNutrientElement_CropGrassNutrReqSOLmV5(ReadCropGrassNutrientElement,PerTonPrimProdParameterSOLmV5)
/
N_req."N requirement per t yield (tN/t)"
P_req."P requirement per t yield (tP2O5/t)"
K_req."K requirement per t yield (tK2O/t)"
/;

*the following matching set needs to be defined, as the definition of the set ActivitySOLmV5 regrettably does not result in NON_FAOSTAT_GrassActivities being accessible as a subset of it
*        albeit all its elements are part of it.
Set MatchNON_FAOSTAT_GrassActivities_SOLmV5Activities(NON_FAOSTAT_GrassActivities,ActivitySOLmV5)
/
"Grass"."Grass"
"Temporary meadows and pastures"."Temporary meadows and pastures"
"Permanent meadows and pastures"."Permanent meadows and pastures"
"temporary grasslands"."temporary grasslands"
"permanent grasslands"."permanent grasslands"
"alpine pastures"."alpine pastures"
Grassclass1.Grassclass1
Grassclass2.Grassclass2
Grassclass3.Grassclass3
Grassclass4.Grassclass4
/;

*3.2) Link to the core model parameters

*on this level, as the data above is anyway dummy only, do not retain the differentiation between organic/conv - to be introduced later again.
*thus assign to AverageProdType only, and use the conventional reference:

*division by 1000 to convert from kg to ton
$ontext;
ParameterPerTonPrimaryProdSOLmV5("World","Wheat","All",PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5,"All","Baseline")
         = sum((ReadCropGrassNutrientElement,ProductioNType)$(Match_ReadCropGrassNutrientElement_CropGrassNutrReqSOLmV5(ReadCropGrassNutrientElement,PerTonPrimProdParameterSOLmV5)
                         AND Match_ProductionType_ProductionTypeSOLmV5(ProductioNType,ProductionTypeSOLmV5)),
                 CropNutrientRequirements_VariousSources("World","Wheat",ReadCropGrassNutrientElement,ProductionType))/1000;

ParameterPerTonPrimaryProdSOLmV5("World","Grass","All",PerTonPrimProdParameterSOLmV5,ProductionTypeSOLmV5,"All","Baseline")
         = sum((ReadCropGrassNutrientElement,ProductioNType)$(Match_ReadCropGrassNutrientElement_CropGrassNutrReqSOLmV5(ReadCropGrassNutrientElement,PerTonPrimProdParameterSOLmV5)
                         AND Match_ProductionType_ProductionTypeSOLmV5(ProductioNType,ProductionTypeSOLmV5)),
                 GrassNutrientRequirements_VariousSources("World","Grass",ReadCropGrassNutrientElement,ProductionType))/1000;
$offtext;



*no, this dummy assigment is dropped here - all is assigned in Steering2 only:
$ontext;
ParameterPerTonPrimaryProdSOLmV5("World","Wheat","All",PerTonPrimProdParameterSOLmV5,"AverageProdType","All","Baseline")
         = sum(ReadCropGrassNutrientElement$Match_ReadCropGrassNutrientElement_CropGrassNutrReqSOLmV5(ReadCropGrassNutrientElement,PerTonPrimProdParameterSOLmV5),
                 CropNutrientRequirements_VariousSources("World","Wheat",ReadCropGrassNutrientElement,"Convent"))/1000;

ParameterPerTonPrimaryProdSOLmV5("World","Grass","All",PerTonPrimProdParameterSOLmV5,"AverageProdType","All","Baseline")
         = sum(ReadCropGrassNutrientElement$Match_ReadCropGrassNutrientElement_CropGrassNutrReqSOLmV5(ReadCropGrassNutrientElement,PerTonPrimProdParameterSOLmV5),
                 GrassNutrientRequirements_VariousSources("World","Grass",ReadCropGrassNutrientElement,"Convent"))/1000;
$offtext;


$ontext;
After this we have the following in SOLm-entities:

where
PerTonPrimProdParameterSOLmV5    is      ReadCropGrassNutrientElement, i..e N,P,K requirements

ParameterPerTonPrimaryProdSOLmV5("World","Wheat","All",PerTonPrimProdParameterSOLmV5,"AverageProdType","All","Baseline")
ParameterPerTonPrimaryProdSOLmV5("World","Grass","All",PerTonPrimProdParameterSOLmV5,"AverageProdType","All","Baseline")

$offtext;
