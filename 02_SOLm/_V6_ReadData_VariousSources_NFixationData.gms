PUTCLOSE con,"_V6_ReadData_VariousSources_NFixationData";

$ontext;
GENERAL DESCRIPTION
This file assigns the per ton yield values for biological N fixation, mainly from Herridge et al. 2008
Herridge et al. 2008, Global inputs of biological nitrogen fixation in agricultural systems, Plant Soil 311:1-18


DETAILED TABLE OF CONTENTS
- 1) Biological N fixation
- 2) Assign values to core model parameters and variables
         2.1) Link some sets as needed
         2.2) Link to the core model parameters
$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Biological N fixation

$ontext;
The following values used are taken from
Table 4 in Herridge et al. 2008 (taking gross values, rounded):
Herridge et al. 2008, Global inputs of biological nitrogen fixation in agricultural systems, Plant Soil 311:1-18
Derived from his table 4:
                Area Mha  grain yield Mt  N fixed Mt  kg N-fixation per ha  kg N-fixation per t yield
Common bean     25,1        18,1                0,58        23                  32
Cowpea           9,2         4,6                0,23        25                  50
Chickpea        10,4         8,4                0,6         58                  71
Pea              6,6        11,3                0,57        86                  50
Lentil           4,1         4,1                0,21        51                  51
Fababean         2,7         4,3                0,29       107                  67
Other pulses    11,4         9,4                0,47        41                  50
total pulses    69,7        60,2                2,95        42                  49

Groundnut       23,4        37,6                2,06        88                  55
Soybean         93,4       214,8               16,44       176                  77
total oilseeds 116,7       252,4               18,5        159                  73

total crop legumes
               186,4       312,6               21,45       115                  69
$offtext;

$ontext;
further values from other sources:
but use mainly Herridge data in SOLm
"The nature and properties of soil", cited in http://nmsp.cals.cornell.edu/publications/factsheets/factsheet39.pdf
N fixation, data from the US, thus transform to per t yield data with average US yields
Lbs per acre per year = 1.12 kg/ha/year
Alfalfa 130-220, 34 t yield, i.e. 180/34 N/t= 5.5kgN/t (DM share is 0.25, thus 15kg/t when using the number above)
Clover 90-130
Vetch 45-130, yield 1.5t/ha, thus average 90/1.5=60kg/t
Dry beans 25-45, yield 1.9, 35/1.9kg/t = 18kg/t
Soybean 45-130, yield 2.8t/ha: thus average: 90/2.8 kg/t, = 32; DM share 0.9
Compare also: soy calc from bgd-9-C2463-2012-print.pdf: global Nfix from soy using the numbers above,
                dividing by 1.69 (as production increased by that since their reference, is roughly the same!)
GRUDAF, KP 13.1, p65: 120-250kg/ha
Data from Australia: LegumesFixNitrogen_ento_pdf Standard: 40-160kgN/ha

for the vegetable legumes: GREEN beans, peas and string beans: those have yields in FM, thus much higher than lentil, dry pea yields, etc. -
         thus use lower values for Nfix/ton yield:
         use the same values as for forage crops, i.e. about a sixth from the grain legume values, this is also in line with yields in relation to dry peas, etc.: thus: not 32kgN/t, but 5.5kgN/t
$offtext;

$ontext;
Other crops than legumes:

And also sugar cane has N-fixation: bok%3A978-1-4020-3546-3 - 100kgN/ha, data from Brazil, thus tranfer to per t fixation with Brazilian yield: 77ton, take 75, thus: 1.33kg/t yield.
*however, Herridge et al 2008 estimate 100kgN/ha to be too high - they suggest 25kg/ha (table 6), thus, with global average yield of 70t/ha from FAO data, this gives 0.36kg/t yield.

*And Herridge et al. 2008 have data for rice as well: table 6, 33kg N/ha, with global average yield from FAO of 4.2t/ha: 7.86kg/t yield
$offtext;

$ontext;
forage legumes and grasslands:

*for forage, we had first a value of 118 - but this is too high if taken as per t yield - thus we changed according to the references further down.
*for forage legumes, values are lower
*assume the same as grassland as basis (20kg/tDM), but they are pure crops, so assume 33% in Grassland, thus 3 times this value: 60kg/tDM
*this is DM, thus multiply with DM share
*XXXXXXXXXXXXXXXXX IMPROVE THESE VALUES XXXXXXXXXXXXXXXXXXXXXX
* one improvement for Alfalfa: take the values from table 3 in http://orgprints.org/22505/6/22505.pdf
*this gives about 60kg/tDm as well - no, rather use 5.5kg/t fresh matter, and then drop the multiplication with DM shares

*for grassland, we generally assume the values as reported for Erb's Grassclasses: 1: 30kg/t DM yield, 2,3,4: 10kg/t DM yield
*but currently, we work with only one grassland type - we thus assume 20kg/t DM yield
*Grassquestion: NFixation: kg/T DM yield!!?? Oder per ha???? (ist per t in den alten suslive_data!)
*but may use the values from above - assume e.g. a third of legumes in grass, e.g. clover, thus 30-40kg/ha Nfix; grassyields in teh US are 4.8t/ha (DM! all grass is in DM), thus 7kg/t
*other source for grassland: http://www.climmani.org/CLIMMANI/Documents/Iceland_Talks/SES2_Reed_Climmani_Interface_Iceland.pdf: from the map and the table, 15kg/ha seems reasonable average
*global yield, on average, is 4.8t/ha, thus 3.5kg/t yield

*Herridge et al. also have much lower values for the grasslands areas where they see fixation and also lower rates (Table 6):
*10kgN/ha rather than 15kgN/ha: and on tropical Savannah, i.e. on 1.4 bill ha, not 3.4bill as total grasslands in FAO;
*to simulate this: take 10kgN/ha*1.4/3.4=4.12kgN/ha, with 4.8t/ha yield, this is 0.9kg/t
*but in this data, all othe rgrasslands seem to be missing, as the pastures reported in the second line cover 110Mha only and also include fodder legumes

$offtext;

Parameter VariousSources_NFixation(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);

*unit: kgN/t yield
VariousSources_NFixation(FAOSTAT_Countries,"Soybeans") = 77;
VariousSources_NFixation(FAOSTAT_Countries,"Groundnuts, with shell") = 55;

*Bambara beans is other pulses
VariousSources_NFixation(FAOSTAT_Countries,"Bambara beans") = 50;
*beans, dry covers Phaseolus vulgaris - which is "Common bean" - thus 32 instead of 50kgN/tyield
VariousSources_NFixation(FAOSTAT_Countries,"Beans, dry") = 32;
*that is faba bean, thus 67 and not 50 kgN/t yield:
VariousSources_NFixation(FAOSTAT_Countries,"Broad beans, horse beans, dry") = 67;
VariousSources_NFixation(FAOSTAT_Countries,"Chick peas") = 71;
*for the grain legues not speicified in Herridge et al. 2008, we take the value for "other pulses" of 50kgN/tYield
VariousSources_NFixation(FAOSTAT_Countries,"Cow peas, dry")= 50;
VariousSources_NFixation(FAOSTAT_Countries,"Lentils")      = 51;
VariousSources_NFixation(FAOSTAT_Countries,"Lupins")       = 50;
VariousSources_NFixation(FAOSTAT_Countries,"Peas, dry")    = 50;
VariousSources_NFixation(FAOSTAT_Countries,"Pigeon peas")  = 50;
VariousSources_NFixation(FAOSTAT_Countries,"Pulses, nes")  = 50;
VariousSources_NFixation(FAOSTAT_Countries,"Vetches")      = 50;
VariousSources_NFixation(FAOSTAT_Countries,"Pulses,Total") = 50;

VariousSources_NFixation(FAOSTAT_Countries,"Sugar cane")   = 0.36;
VariousSources_NFixation(FAOSTAT_Countries,"Rice, paddy")  = 7.86;

*based on the cosidearations above, use the following values for green leguminous vegetables:
VariousSources_NFixation(FAOSTAT_Countries,"Vegetables, leguminous nes") = 5.5;
VariousSources_NFixation(FAOSTAT_Countries,"Beans, green") = 5.5;
VariousSources_NFixation(FAOSTAT_Countries,"String beans") = 5.5;
VariousSources_NFixation(FAOSTAT_Countries,"Peas, green") = 5.5;


*Grass and forage crops are not part of FAOSTAT primary crops, thus assign separately:
Parameter VariousSources_NFixationGrassForage(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_CropProductionItems);

VariousSources_NFixationGrassForage(FAOSTAT_Countries,"Temporary meadows and pastures") = 0.9;
VariousSources_NFixationGrassForage(FAOSTAT_Countries,"Permanent meadows and pastures") = 0.9;
VariousSources_NFixationGrassForage(FAOSTAT_Countries,"temporary grasslands") = 0.9;
VariousSources_NFixationGrassForage(FAOSTAT_Countries,"permanent grasslands") = 0.9;
VariousSources_NFixationGrassForage(FAOSTAT_Countries,"alpine pastures")      = 0.9;
*Pure legume Sward: assume the same as for fodder legumes, i.e. 5.5
VariousSources_NFixationGrassForage(FAOSTAT_Countries,"Pure legume sward")    = 5.5;

VariousSources_NFixationGrassForage(FAOSTAT_Countries,"Clover For Forage+Silage") = 5.5;
VariousSources_NFixationGrassForage(FAOSTAT_Countries,"Alfalfa For Forage+Silag") = 5.5;
VariousSources_NFixationGrassForage(FAOSTAT_Countries,"Leguminous Nes,For+Sil")   = 5.5;


*and convert to tons N per t yield:

VariousSources_NFixation(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems)
         = VariousSources_NFixation(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems)/1000;


VariousSources_NFixationGrassForage(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_CropProductionItems)
         = VariousSources_NFixationGrassForage(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_CropProductionItems)/1000;




$ontext;
after this, we have:
Parameter VariousSources_NFixation(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_NFixationGrassForage(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_CropProductionItems);
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Assign values to core model parameters and variables
*2.1) Link some sets as needed

*the following matching set needs to be defined, as the definition of the set ActivitySOLmV5 regrettably does not result in NON_FAOSTAT_CropProductionItems being accessible as a subset of it
*        albeit all its elements are part of it.
Set MatchNonFAOCropItems_Activities(NON_FAOSTAT_CropProductionItems,Activities)
/
"Maize For Forage+Silage"."Maize For Forage+Silage"
"Alfalfa For Forage+Silag"."Alfalfa For Forage+Silag"
"Clover For Forage+Silage"."Clover For Forage+Silage"
"Leguminous Nes,For+Sil"."Leguminous Nes,For+Sil"
"Forage Products Nes"."Forage Products Nes"

"Beets For Fodder"."Beets For Fodder"
"Swedes For Fodder"."Swedes For Fodder"
"Turnips For Fodder"."Turnips For Fodder"
"Vegetables+Roots,Fodder"."Vegetables+Roots,Fodder"

Fallows.Fallows

"Grass"."Grass"

"Temporary meadows and pastures"."Temporary meadows and pastures"
"Permanent meadows and pastures"."Permanent meadows and pastures"

"temporary grasslands"."temporary grasslands"
"permanent grasslands"."permanent grasslands"
"alpine pastures"."alpine pastures"

"Pure legume sward"."Pure legume sward"
Grassclass1.Grassclass1
Grassclass2.Grassclass2
Grassclass3.Grassclass3
Grassclass4.Grassclass4
/;


*2.2) Link to the core model parameters

*ATTENTION: the assignments below result in "per ton yield N fixation" - hence the subsequent multiplication with yields to get the units we need!!!
ActCropsGrass_OtherChar(Regions,Activities,"N fixation per ton MainOutput1 (tN)","AllProdSyst","AllProdCond")
         = sum((NON_FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchNonFAOCropItems_Activities(NON_FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_NFixationGrassForage(FAOSTAT_Countries,NON_FAOSTAT_CropProductionItems));
ActCropsGrass_OtherChar(Regions,Activities,"N fixation per ton MainOutput1 (tN)","AllProdSyst","AllProdCond")
*the condition is needed to avoid overwriting the values assigned above
                 $(NOT ActCropsGrass_OtherChar(Regions,Activities,"N fixation per ton MainOutput1 (tN)","AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_CropProductionItems,FAOSTAT_Countries)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_NFixation(FAOSTAT_Countries,FAOSTAT_CropProductionItems));



$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Regions,Activities,"N fixation per ton MainOutput1 (tN)","AllProdSyst","AllProdCond")

Regions          is      FAOSTAT_Countries
Activities       is      FAOSTAT_CropProductionItems
                                 NON_FAOSTAT_CropProductionItems
$offtext;


