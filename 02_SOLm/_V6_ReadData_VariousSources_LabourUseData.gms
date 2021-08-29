PUTCLOSE con,"_V6_ReadData_VariousSources_LabourUseData";

$ontext;
GENERAL DESCRIPTION
This file reads the labour use data from various sources

DETAILED TABLE OF CONTENTS
- 1) Labour Use Data from CH-DBK
- 2) Labour Use Data for vegetables: Ch SZG
- 3) Labour Use Data for livestock
- 4) Scaling to fit Eurostat data

$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Labour Use Data from CH-DBK

$ontext;
contains the following data:

This part reads the labour use data as provided by the Swiss DBK
This is Ch-specific data, but it is then used in EU countries as well by scaling the total labour used derived for the baseline with this data by the total labour use as reported by Eurostat
This proportion factor is then applied in all scenarios to adapt the Swiss labour Use data to EU countries
For other countries, such scale factors yet need to be developed
THe Swiss data neither covers all relevant crops - thus, some additional data is needed
$offtext;

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewVariousSourcesLabourUseData% == "YES"
$call GDXXRW Ackerbau201.xlsx  maxDupeErrors=200 o=Arable_DBK_CH.gdx  index=index!a1
$call GDXXRW Getreide201.xlsx  maxDupeErrors=200 o=Cereals_DBK_CH.gdx  index=index!a1
$call GDXXRW Obst201.xlsx  o=Fruits_DBK_CH.gdx  index=index!a1
$call GDXXRW Tiere20.xlsx  maxDupeErrors=200 o=Livestock_DBK_CH.gdx  index=index!a1
$endif;


SET DBKLabourAndCostTypes;
SET DBK_ArableCrops;
SET DBK_ArableCropsAuxiliaryIndex;
SET DBK_Cereals;
SET DBK_CerealsAuxiliaryIndex;
SET DBK_SpecialCrops;
SET DBK_SpecialCropsAuxiliaryIndex;

Parameter LabourUse_Arable;
Parameter LabourUse_Cereals;
Parameter LabourUse_SpecialCrops;
Parameter Miku;
Parameter Miku2;
Parameter Miku3;
Parameter Miku4;
Parameter Zuchtr;
Parameter Muku;
Parameter Muku2;
Parameter Muku3;
Parameter M1;
Parameter M2;
Parameter M3;
Parameter KM1;
Parameter Km2;
Parameter Mz;
Parameter Sf;
Parameter Pf;
Parameter Hi;
Parameter Sw1;
Parameter Sw2;
Parameter Sw3;
Parameter Zs;
Parameter Lh1;
Parameter Lh2;
Parameter Jh;
Parameter Gm;


$gdxin Arable_DBK_CH.gdx
$load LabourUse_Arable
$load DBKLabourAndCostTypes
$load DBK_ArableCrops
$load DBK_ArableCropsAuxiliaryIndex
$gdxin

$gdxin Cereals_DBK_CH.gdx
$load LabourUse_Cereals
$load DBK_Cereals
$load DBK_CerealsAuxiliaryIndex
$gdxin

$gdxin Fruits_DBK_CH.gdx
$load LabourUse_SpecialCrops
$load DBK_SpecialCrops
$load DBK_SpecialCropsAuxiliaryIndex
$gdxin

$gdxin Livestock_DBK_CH.gdx
$load Miku
$load Miku2
$load Miku3
$load Miku4
$load Zuchtr
$load Muku
$load Muku2
$load Muku3
$load M1
$load M2
$load M3
$load KM1
$load Km2
$load Mz
$load Sf
$load Pf
$load Hi
$load Sw1
$load Sw2
$load Sw3
$load Zs
$load Lh1
$load Lh2
$load Jh
$load Gm
$gdxin


SET Match_LabourType_SOLm_DBK(InputsCropsGrass,DBKLabourAndCostTypes)
/
"Labour use - total (h)".Akh_Total
"Labour use - management (h)".Akh_Pflege
"Labour use - harvest (h)".Akh_Ernte
/;


SET Match_SpecialCropType_DBK_SOLm(DBK_SpecialCrops,Activities,ProductionSystems)
/
*"Tafel�pfel, mit Hagelschutz, �LN, Erstellung"
*"Tafel�pfel, mit Hagelschutz, �LN, 1. Jahr"
*"Tafel�pfel, mit Hagelschutz, �LN, 2. Jahr"
*"Tafel�pfel, mit Hagelschutz, �LN, 3. Jahr"
*"Tafel�pfel, mit Hagelschutz, �LN, Ertragsphase"
*"Tafel�pfel, ohne Hagelschutz, �LN, Erstellung"
*"Tafel�pfel, ohne Hagelschutz, �LN, 1. Jahr"
*"Tafel�pfel, ohne Hagelschutz, �LN, 2. Jahr"
*"Tafel�pfel, ohne Hagelschutz, �LN, 3. Jahr"
"Tafel�pfel, ohne Hagelschutz, �LN, Ertragsphase".Apples.convent
*"Tafel�pfel, ohne Hagelschutz, Bio, Erstellung"
*"Tafel�pfel, ohne Hagelschutz, Bio, 1. Jahr"
*"Tafel�pfel, ohne Hagelschutz, Bio, 2. Jahr"
*"Tafel�pfel, ohne Hagelschutz, Bio, 3. Jahr"
"Tafel�pfel, ohne Hagelschutz, Bio, Ertragsphase".Apples.organic
*"Tafelbirnen, ohne Hagelschutz, �LN, Erstellung"
*"Tafelbirnen, ohne Hagelschutz, �LN, 1. Jahr"
*"Tafelbirnen, ohne Hagelschutz, �LN, 2. Jahr"
*"Tafelbirnen, ohne Hagelschutz, �LN, 3. Jahr"
*"Tafelbirnen, ohne Hagelschutz, �LN, 4. Jahr"
*"Tafelbirnen, ohne Hagelschutz, �LN, 5. Jahr"
"Tafelbirnen, ohne Hagelschutz, �LN, Ertragsphase".Pears.convent
*"Tafelbirnen, ohne Hagelschutz, Bio, Erstellung"
*"Tafelbirnen, ohne Hagelschutz, Bio, 1. Jahr"
*"Tafelbirnen, ohne Hagelschutz, Bio, 2. Jahr"
*"Tafelbirnen, ohne Hagelschutz, Bio, 3. Jahr"
*"Tafelbirnen, ohne Hagelschutz, Bio, 4. Jahr"
*"Tafelbirnen, ohne Hagelschutz, Bio, 5. Jahr"
"Tafelbirnen, ohne Hagelschutz, Bio, Ertragsphase".Pears.organic
*"Tafelzwetschgen, Niederstamm, �LN, Erstellung"
*"Tafelzwetschgen, Niederstamm, �LN, 1. Jahr"
*"Tafelzwetschgen, Niederstamm, �LN, 2. Jahr"
*"Tafelzwetschgen, Niederstamm, �LN, 3. Jahr"
*"Tafelzwetschgen, Niederstamm, �LN, 4. Jahr"
"Tafelzwetschgen, Niederstamm, �LN, Ertragsphase"."Plums and sloes".convent
*"Tafelzwetschgen, Niederstamm, Bio, Erstellung"
*"Tafelzwetschgen, Niederstamm, Bio, 1. Jahr"
*"Tafelzwetschgen, Niederstamm, Bio, 2. Jahr"
*"Tafelzwetschgen, Niederstamm, Bio, 3. Jahr"
*"Tafelzwetschgen, Niederstamm, Bio, 4. Jahr"
"Tafelzwetschgen, Niederstamm, Bio, Ertragsphase"."Plums and sloes".organic
*"Tafelkirschen, Niederst., gedeckt, �LN, Erstellung"
*"Tafelkirschen, Niederst., gedeckt, �LN, 1. Jahr"
*"Tafelkirschen, Niederst., gedeckt, �LN, 2. Jahr"
*"Tafelkirschen, Niederst., gedeckt, �LN, 3. Jahr"
*"Tafelkirschen, Niederst., gedeckt, �LN, 4. Jahr"
"Tafelkirschen, Niederst., gedeckt, �LN, Ertragsphase".Cherries.convent
*"Tafelkirschen, Niederst., gedeckt, Bio, Erstellung"
*"Tafelkirschen, Niederst., gedeckt, Bio, 1. Jahr"
*"Tafelkirschen, Niederst., gedeckt, Bio, 2. Jahr"
*"Tafelkirschen, Niederst., gedeckt, Bio, 3. Jahr"
*"Tafelkirschen, Niederst., gedeckt, Bio, 4. Jahr"
"Tafelkirschen, Niederst., gedeckt, Bio, Ertragsphase".Cherries.organic
*"Industriekirschen, Erstellung"
*"Industriekirschen, 1. Jahr"
*"Industriekirschen, 2. Jahr"
*"Industriekirschen, 3. Jahr"
*"Industriekirschen, 4. Jahr"
*"Industriekirschen, 5. Jahr"
*"Industriekirschen, 6. Jahr"
*"Industriekirschen, Ertragsphase"
*"Enger Drahtbau, Gamay, VS, �LN, Erstellung"
*"Enger Drahtbau, Gamay, VS, �LN, 1. Jahr"
*"Enger Drahtbau, Gamay, VS, �LN, 2. Jahr"
*"Enger Drahtbau, Gamay, VS, �LN, Ertragsphase"
*"Mittlerer Drahtbau, Blauburgunder, ZH, �LN, Erstellung"
*"Mittlerer Drahtbau, Blauburgunder, ZH, �LN, 1. Jahr"
*"Mittlerer Drahtbau, Blauburgunder, ZH, �LN, 2. Jahr"
"Mittlerer Drahtbau, Blauburgunder, ZH, �LN, Ertragsphase".Grapes.convent
*"Mittlerer Drahtbau, Chasselas, VD, �LN, Erstellung"
*"Mittlerer Drahtbau, Chasselas, VD, �LN, 1. Jahr"
*"Mittlerer Drahtbau, Chasselas, VD, �LN, 2. Jahr"
*"Mittlerer Drahtbau, Chasselas, VD, �LN, Ertragsphase"
*"Enger Drahtbau, Gamay, Bio, Erstellung"
*"Enger Drahtbau, Gamay, Bio, 1. Jahr"
*"Enger Drahtbau, Gamay, Bio, 2. Jahr"
*"Enger Drahtbau, Gamay, Bio, Ertragsphase"
*"Mittlerer Drahtbau, Blauburgunder, Bio, Erstellung"
*"Mittlerer Drahtbau, Blauburgunder, Bio, 1. Jahr"
*"Mittlerer Drahtbau, Blauburgunder, Bio, 2. Jahr"
"Mittlerer Drahtbau, Blauburgunder, Bio, Ertragsphase".Grapes.organic
*"Mittlerer Drahtbau,  Chasselas, Bio, Erstellung"
*"Mittlerer Drahtbau,  Chasselas, Bio, 1. Jahr"
*"Mittlerer Drahtbau,  Chasselas, Bio, 2. Jahr"
*"Mittlerer Drahtbau,  Chasselas, Bio, Ertragsphase"
"Erdbeeren, Flachkultur, �LN".Strawberries.convent
*"Erdbeeren, Dammkultur, �LN"
"Erdbeeren, Flachkultur, Bio".Strawberries.organic
*"Erdbeeren, Flachkultur unter Vlies, �LN"
*"Erdbeeren, Dammkultur, unter Vlies, �LN"
*"Erdbeeren, Dammkultur unter Tunnel, �LN"
*"Erdbeeren, Dammkultur unter Tunnel, Bio"
*"Erdbeeren, Substratkultur, �LN"
*"Remontierende Erdbeeren, Dammkultur unter Tunnel, �LN"
*"Remontierende Erdbeeren, Dammkultur unter Tunnel, Bio"
*"Himbeeren 1-j�hrig, auf Substrat, �LN"
*"Herbsthimbeeren Substrat, �LN, 1. Jahr"
*"Herbsthimbeeren Substrat, �LN, 2. Jahr"
*"Herbsthimbeeren Substrat Sommerernte, �LN, 1. Jahr"
*"Herbsthimbeeren Substrat Sommerernte, �LN, Nursery"
*"Herbsthimbeeren Substrat Sommerernte, �LN, 2. Jahr"
*"Sommerhimbeeren, �LN, Erstellung"
*"Sommerhimbeeren, �LN, 1. Jahr"
*"Sommerhimbeeren, �LN, 2. Jahr"
"Sommerhimbeeren, �LN, Ertragsphase".Raspberries.convent
*"Herbsthimbeeren, �LN, Erstellung"
*"Herbsthimbeeren, �LN, 1. Jahr"
*"Herbsthimbeeren, �LN, 2. Jahr"
*"Herbsthimbeeren, �LN, Ertragsphase"
*"Brombeeren, �LN, Erstellung"
*"Brombeeren, �LN, 1. Jahr"
*"Brombeeren, �LN, 2. Jahr"
"Brombeeren, �LN, Ertragsphase"."Berries nes".convent
*"Johannisbeeren, �LN, Erstellung"
*"Johannisbeeren, �LN, 1. Jahr"
*"Johannisbeeren, �LN, 2. Jahr"
*"Johannisbeeren, �LN, 3. Jahr"
"Johannisbeeren, �LN, Ertragsphase"."Currants".convent
*"Stachelbeeren, �LN, Erstellung"
*"Stachelbeeren, �LN, 1. Jahr"
*"Stachelbeeren, �LN, 2. Jahr"
*"Stachelbeeren, �LN, 3. Jahr"
*"Stachelbeeren, �LN, Ertragsphase"
*"Heidelbeeren, �LN, Erstellung"
*"Heidelbeeren, �LN, 1. Jahr"
*"Heidelbeeren, �LN, 2. Jahr"
*"Heidelbeeren, �LN, 3. Jahr"
*"Heidelbeeren, �LN, 4. Jahr"
*"Heidelbeeren, �LN, 5. Jahr"
"Heidelbeeren, �LN, Ertragsphase".Blueberries.convent
*"Heidelbeeren, Bio, Erstellung"
*"Heidelbeeren, Bio, 1. Jahr"
*"Heidelbeeren, Bio, 2. Jahr"
*"Heidelbeeren, Bio, 3. Jahr"
*"Heidelbeeren, Bio, 4. Jahr"
*"Heidelbeeren, Bio, 5. Jahr"
"Heidelbeeren, Bio, Ertragsphase".Blueberries.organic
*"Heidelbeeren Trog, �LN, Erstellung"
*"*Heidelbeeren Trog, �LN, 1. Jahr"
*"Heidelbeeren Trog, �LN, 2. Jahr"
*"Heidelbeeren Trog, �LN, 3. Jahr"
*"Heidelbeeren Trog, �LN, Ertragsphase"
/;

SET Match_CerealType_DBK_SOLm(DBK_Cereals,Activities,ProductionSystems)
/
*Winterweizen Top  �LN intensiv
*Winterweizen Top  Extenso, IP-SUISSE
*Winterweizen Top BIO
"Sommerweizen Top �LN intensiv".Wheat.convent
*Sommerweizen Top Extenso, IP-SUISSE
"Sommerweizen Top BIO".Wheat.organic
"Dinkel �LN intensiv".Spelt.convent
*UrDinkel Extenso, IP-SUISSE
"UrDinkel BIO".Spelt.organic
"W-Roggen pop. �LN intensiv".Rye.convent
*W-Roggen pop. Extenso, IP-SUISSE
"W-Roggen pop. BIO".Rye.organic
*W-Roggen hybrid �LN intensiv
*W-Roggen hybrid Extenso, IP-SUISSE
*Emmer BIO
*Futterweizen �LN
*Futterweizen  �LN, Extenso
*Futterweizen BIO
"Wintertriticale �LN intensiv".Triticale.convent
*Wintertriticale �LN Extenso
"Wintertriticale BIO".Triticale.organic
"Wintergerste �LN intensiv".Barley.convent
*Wintergerste �LN Extenso
"Wintergerste BIO".Barley.organic
"Sommerhafer �LN intensiv".Oats.convent
*Sommerhafer �LN Extenso
"Sommerhafer BIO".Oats.organic
/;

SET Match_ArableCropType_DBK_SOLm(DBK_ArableCrops,Activities,ProductionSystems)
/
"Ackerbohnen �LN intensiv"."Broad beans, horse beans, dry".convent
*Ackerbohnen �LN Extenso
"Ackerbohnen BIO"."Broad beans, horse beans, dry".organic
*"Eiweisserbsen �LN intensiv"..convent
*Eiweisserbsen �LN Extenso
*"Eiweisserbsen BIO"..organic
*Eiweisserbsen Gerste
*Ackerbohnen Triticale
*Lupine Hafer
"Sonnenblumen �LN intensiv"."Sunflower seed".convent
*Sonnenblumen �LN Extenso
"Sonnenblumen BIO"."Sunflower seed".organic
"Raps �LN intensiv".Rapeseed.convent
*Raps IP-Suisse
"Raps BIO-Produktion".Rapeseed.organic
*<empty>
"Soja �LN".Soybeans.convent
"Soja BIO (Futtersoja)".Soybeans.organic
*0
"K�rnermais �LN".Maize.convent
"K�rnermais BIO".Maize.organic
*CCM �LN ab Feldrand
*CCM BIO ab Feldrand
*Feuchtk�rnermais �LN ab Feldrand
*Feuchtk�rnermais BIO ab Feldrand
*Maiskolbenschrot �LN getrocknet
*Maiskolbenschrot BIO getrocknet
"Silomais �LN stehend ab Feld"."Maize for Forage+Silage".convent
"Silomais BIO stehend ab Feld"."MAize for Forage+Silage".organic
*Silomais �LN getrocknet
*Silomais BIO getrocknet
"Zuckerr�ben �LN,  ab Feld"."Sugar beet".convent
*Zuckerr�ben �LN, Selbsttransport
"Zuckerr�ben BIO, ab Feld"."Sugar beet".organic
"Futterr�ben �LN"."Turnips for fodder".convent
"Futterr�ben BIO"."Turnips for fodder".organic
*"Tabak, Burley, �LN luftgetrocknet"..convent
*Tabak, Virginie, �LN Ofentrocknung
"Speisekartoffeln �LN, Grosshandel".Potatoes.convent
*Speisekartoffeln �LN Grosshandel
"Speisekartoffeln BIO, Grosshandel".Potatoes.organic
*Speisekartoffeln �LN, Einzelhandel
*Speisekartoffeln �LN Einzelhandel
*Speisekartoffeln BIO, Einzelhandel
*Speisekartoffeln �LN, Grosshandel, Veredelung
*Speisekartoffeln �LN Grosshandel, Veredelung
*Speisekartoffeln BIO, Grosshandel, Veredelung
*Buntbrache 4-j�hrig, �LN
*Buntbrache 4-j�hrig, BIO
*Rotationsbrache, �LN
*Rotationsbrache, BIO
*Hecke bestehend �LN
*Naturwiese �LN extensiv
*Naturwiese BIO extensiv
*Naturwiese �LN wenig intensiv
*Naturwiese BIO wenig intensiv
"Naturwiese �LN mittel-intensiv"."Permanent meadows and pastures".convent
*Naturwiese �LN leicht-intensiv
"Naturwiese BIO mittel-intensiv"."Permanent meadows and pastures".organic
*Naturwiese �LN sehr intensiv
*Naturwiese �LN intensiv
*Naturwiese BIO intensiv
*Naturwiese �LN  sehr int., Heuverkauf
*Naturwiese �LN intensiv, Heuverkauf
*Naturwiese BIO intensiv, Heuverkauf
*Kunstwiese �LN intensiv
"Kunstwiese �LN"."Temporary meadows and pastures".convent
"Kunstwiese BIO"."Temporary meadows and pastures".organic
*Kunstwiesenfutter �LN, intensiv, Verkauf
*Kunstwiesenfutter �LN Verkauf
*Kunstwiesenfutter BIO Verkauf
*Zwischenfutter �LN intensiv, Herbst/Fr�hling
*Zwischenfutter �LN Herbst/Fr�hling
*Zwischenfutter BIO Herbst/Fr�hling
*Zwischenfutter �LN intensiv, Herbst
*Zwischenfutter �LN Herbst
*Zwischenfutter BIO Herbst
"Gr�nd�ngung �LN"."Clover for Forage+Silage".convent
"Gr�nd�ngung BIO"."Clover for Forage+Silage".organic
/;


*assign the following for Europe only, as it may be stretching the use of the data froM CH too far in other world regions: FAO_Europe
ActCropsGrass_Inputs(FAO_Europe,Activities,InputsCropsGrass,ProductionSystems,"AllProdCond")
                 $((NOT ActCropsGrass_Inputs(FAO_Europe,Activities,InputsCropsGrass,ProductionSystems,"AllProdCond"))
                         AND VActCropsGrass_QuantityActUnits.l(FAO_Europe,Activities,"AllProdSyst","AllProdCond"))
         =sum((DBK_ArableCropsAuxiliaryIndex,DBK_ArableCrops,DBKLabourAndCostTypes)$(Match_ArableCropType_DBK_SOLm(DBK_ArableCrops,Activities,ProductionSystems)
                                                                 AND Match_LabourType_SOLm_DBK(InputsCropsGrass,DBKLabourAndCostTypes)),
                         LabourUse_Arable(DBKLabourAndCostTypes,DBK_ArableCropsAuxiliaryIndex,DBK_ArableCrops));

ActCropsGrass_Inputs(FAO_Europe,Activities,InputsCropsGrass,ProductionSystems,"AllProdCond")
                 $((NOT ActCropsGrass_Inputs(FAO_Europe,Activities,InputsCropsGrass,ProductionSystems,"AllProdCond"))
                         AND VActCropsGrass_QuantityActUnits.l(FAO_Europe,Activities,"AllProdSyst","AllProdCond"))
         =sum((DBK_CerealsAuxiliaryIndex,DBK_Cereals,DBKLabourAndCostTypes)$(Match_CerealType_DBK_SOLm(DBK_Cereals,Activities,ProductionSystems)
                                                                 AND Match_LabourType_SOLm_DBK(InputsCropsGrass,DBKLabourAndCostTypes)),
                         LabourUse_Cereals(DBKLabourAndCostTypes,DBK_CerealsAuxiliaryIndex,DBK_Cereals));

ActCropsGrass_Inputs(FAO_Europe,Activities,InputsCropsGrass,ProductionSystems,"AllProdCond")
                 $((NOT ActCropsGrass_Inputs(FAO_Europe,Activities,InputsCropsGrass,ProductionSystems,"AllProdCond"))
                         AND VActCropsGrass_QuantityActUnits.l(FAO_Europe,Activities,"AllProdSyst","AllProdCond"))
         =sum((DBK_SpecialCropsAuxiliaryIndex,DBK_SpecialCrops,DBKLabourAndCostTypes)$(Match_SpecialCropType_DBK_SOLm(DBK_SpecialCrops,Activities,ProductionSystems)
                                                                 AND Match_LabourType_SOLm_DBK(InputsCropsGrass,DBKLabourAndCostTypes)),
                         LabourUse_SPecialCrops(DBKLabourAndCostTypes,DBK_SpecialCropsAuxiliaryIndex,DBK_SpecialCrops));

ActCropsGrass_Inputs(FAO_Europe,Activities,"Labour use - other (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,Activities,"Labour use - total (h)",ProductionSystems,"AllProdCond")
                 - ActCropsGrass_Inputs(FAO_Europe,Activities,"Labour use - management (h)",ProductionSystems,"AllProdCond")
                 - ActCropsGrass_Inputs(FAO_Europe,Activities,"Labour use - harvest (h)",ProductionSystems,"AllProdCond");


Set LabourTypes(InputsCropsGrass)
/
"Labour use - total (h)"
"Labour use - management (h)"
"Labour use - harvest (h)"
"Labour use - other (h)"
/;

*set AllProdSyst labour use equal to conventional:
ActCropsGrass_Inputs(FAO_Europe,Activities,LabourTypes,"AllProdSyst","AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,Activities,LabourTypes,"Convent","AllProdCond");

*permanent meadows and pastures: no harvest needed - only work maybe fencing, etc. - so just divide all the labour by 10 to have something
ActCropsGrass_Inputs(FAO_Europe,"Permanent meadows and pastures",LabourTypes,ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Permanent meadows and pastures",LabourTypes,ProductionSystems,"AllProdCond")/10;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Labour Use Data for vegetables: Ch SZG
*the data above does not cover vegetables - we take them from a publication specifically referring to vegetable production in Switzerland, using data from 2008/2010:
*M�hring, A., MAck, G., Willersinn, C., 2012, Gem�seanbau � Modellierung der Heterogenit�t und Intensit�t, Agrarforschung Schweiz 3 (7�8): 382�389, 2012
*die Daten sind aus Abb. 1 (konventionell: �LN) und Abb. 4 (Bio - Begr�ndung, f�r Bio einfach die doppelten Werte anzunehmen) ersichtlich.
*we have total labour use data here only, though.

ActCropsGrass_Inputs(FAO_Europe,"Asparagus"                         ,"Labour use - total (h)","Convent","AllProdCond") = 860;
ActCropsGrass_Inputs(FAO_Europe,"Beans, green"                      ,"Labour use - total (h)","Convent","AllProdCond") = 38;
ActCropsGrass_Inputs(FAO_Europe,"Cabbages and other brassicas"      ,"Labour use - total (h)","Convent","AllProdCond") = 400;
ActCropsGrass_Inputs(FAO_Europe,"Carrots and turnips"               ,"Labour use - total (h)","Convent","AllProdCond") = 220;
ActCropsGrass_Inputs(FAO_Europe,"Cauliflowers and broccoli"         ,"Labour use - total (h)","Convent","AllProdCond") = 610;
ActCropsGrass_Inputs(FAO_Europe,"Leeks, other alliaceous vegetables","Labour use - total (h)","Convent","AllProdCond") = 1625;
ActCropsGrass_Inputs(FAO_Europe,"Lettuce and chicory"               ,"Labour use - total (h)","Convent","AllProdCond") = 600;
*above: some mixture of Kopfsalat, Chinakohl, Wirz, Chicorino
ActCropsGrass_Inputs(FAO_Europe,"Onions, shallots, green"           ,"Labour use - total (h)","Convent","AllProdCond") = 430;
ActCropsGrass_Inputs(FAO_Europe,"Onions, dry"                       ,"Labour use - total (h)","Convent","AllProdCond") = 430;
ActCropsGrass_Inputs(FAO_Europe,"Peas, green"                       ,"Labour use - total (h)","Convent","AllProdCond") = 33;
ActCropsGrass_Inputs(FAO_Europe,"Spinach"                           ,"Labour use - total (h)","Convent","AllProdCond") = 57;
ActCropsGrass_Inputs(FAO_Europe,"String beans"                      ,"Labour use - total (h)","Convent","AllProdCond") = 38;

ActCropsGrass_Inputs(FAO_Europe,"Chillies and peppers, dry"  ,"Labour use - total (h)","Convent","AllProdCond") = 750;
ActCropsGrass_Inputs(FAO_Europe,"Chillies and peppers, green","Labour use - total (h)","Convent","AllProdCond") = 750;
ActCropsGrass_Inputs(FAO_Europe,"Cucumbers and gherkins"     ,"Labour use - total (h)","Convent","AllProdCond") = 750;
ActCropsGrass_Inputs(FAO_Europe,"Eggplants (aubergines)"     ,"Labour use - total (h)","Convent","AllProdCond") = 750;
*the four above: same as Zucchetti
ActCropsGrass_Inputs(FAO_Europe,"Garlic"                     ,"Labour use - total (h)","Convent","AllProdCond") = 430;
*above: same as onions

*organic: twice conventional, cf. comment above
ActCropsGrass_Inputs(FAO_Europe,Vegetables,"Labour use - total (h)","Organic","AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,Vegetables,"Labour use - total (h)","Convent","AllProdCond")*2;
ActCropsGrass_Inputs(FAO_Europe,Vegetables,"Labour use - total (h)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,Vegetables,"Labour use - total (h)","Convent","AllProdCond");



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Labour Use Data for other yet missing crops
*we checked area data for crops and for which crops there was labour data, and identified the crops where it was yet missing.
*we then used data from crops already included, where adequate, or did some short search for new data for some other crops.
*this is collected in AdditionalLabourUseData_Crops_16_3_2021.xlsx

ActCropsGrass_Inputs(FAO_Europe,"Almonds, with shell","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Plums and sloes","Labour use - total (h)",ProductionSystems,"AllProdCond")*0.75;
ActCropsGrass_Inputs(FAO_Europe,"Apricots","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Plums and sloes","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Beans, dry","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Broad beans, horse beans, dry","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Buckwheat","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Wheat","Labour use - total (h)",ProductionSystems,"AllProdCond")*0.75;
ActCropsGrass_Inputs(FAO_Europe,"Canary seed","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Rapeseed","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Cereals, nes","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Wheat","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Cherries, sour","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Cherries","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Chestnut","Labour use - total (h)","AllProdSyst","AllProdCond") = 140;
ActCropsGrass_Inputs(FAO_Europe,"Chestnut","Labour use - total (h)","Convent","AllProdCond") = 140;
ActCropsGrass_Inputs(FAO_Europe,"Chestnut","Labour use - total (h)","Organic","AllProdCond") = 160;
ActCropsGrass_Inputs(FAO_Europe,"Chick peas","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Broad beans, horse beans, dry","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Cow peas, dry","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Broad beans, horse beans, dry","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Cranberries","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Blueberries","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Figs","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Apples","Labour use - total (h)",ProductionSystems,"AllProdCond")*0.75;
ActCropsGrass_Inputs(FAO_Europe,"Garlic","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Onions, dry","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Gooseberries","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Blueberries","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Grain, mixed","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Wheat","Labour use - total (h)",ProductionSystems,"AllProdCond");

ActCropsGrass_Inputs(FAO_Europe,"Grapefruit (inc. pomelos)","Labour use - total (h)","AllProdSyst","AllProdCond") = 660;
ActCropsGrass_Inputs(FAO_Europe,"Grapefruit (inc. pomelos)","Labour use - total (h)","Convent","AllProdCond") = 660;
*organic: assume same, as for apples and other fruit trees, more or less: labour input is the same, but yields are lower (thus, harvesting labour is lower!)
ActCropsGrass_Inputs(FAO_Europe,"Grapefruit (inc. pomelos)","Labour use - total (h)","Organic","AllProdCond") = 660;

ActCropsGrass_Inputs(FAO_Europe,"Groundnuts, with shell","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Broad beans, horse beans, dry","Labour use - total (h)",ProductionSystems,"AllProdCond");

ActCropsGrass_Inputs(FAO_Europe,"Hazelnuts, with shell","Labour use - total (h)","AllProdSyst","AllProdCond") = 100;
ActCropsGrass_Inputs(FAO_Europe,"Hazelnuts, with shell","Labour use - total (h)","Convent","AllProdCond") = 100;
*organic: assume 20% more, as with chestnuts
ActCropsGrass_Inputs(FAO_Europe,"Hazelnuts, with shell","Labour use - total (h)","Organic","AllProdCond") = 120;

ActCropsGrass_Inputs(FAO_Europe,"Kiwi fruit","Labour use - total (h)","AllProdSyst","AllProdCond") = 640;
ActCropsGrass_Inputs(FAO_Europe,"Kiwi fruit","Labour use - total (h)","Convent","AllProdCond") = 640;
*organic: assume same, as for apples and other fruit trees, more or less: labour input is the same, but yields are lower (thus, harvesting labour is lower!)
ActCropsGrass_Inputs(FAO_Europe,"Kiwi fruit","Labour use - total (h)","Organic","AllProdCond") = 640;

ActCropsGrass_Inputs(FAO_Europe,"Lemons and limes","Labour use - total (h)","AllProdSyst","AllProdCond") = 660;
ActCropsGrass_Inputs(FAO_Europe,"Lemons and limes","Labour use - total (h)","Convent","AllProdCond") = 660;
*organic: assume same, as for apples and other fruit trees, more or less: labour input is the same, but yields are lower (thus, harvesting labour is lower!)
ActCropsGrass_Inputs(FAO_Europe,"Lemons and limes","Labour use - total (h)","Organic","AllProdCond") = 660;

ActCropsGrass_Inputs(FAO_Europe,"Lentils","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Broad beans, horse beans, dry","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Linseed","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Rapeseed","Labour use - total (h)",ProductionSystems,"AllProdCond");

ActCropsGrass_Inputs(FAO_Europe,"Melons, other (inc.cantaloupes)","Labour use - total (h)","AllProdSyst","AllProdCond") = 500;
ActCropsGrass_Inputs(FAO_Europe,"Melons, other (inc.cantaloupes)","Labour use - total (h)","Convent","AllProdCond") = 500;
*organic: assume 100% more, as with vegetables
ActCropsGrass_Inputs(FAO_Europe,"Melons, other (inc.cantaloupes)","Labour use - total (h)","Organic","AllProdCond") = 1000;

ActCropsGrass_Inputs(FAO_Europe,"Millet","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Wheat","Labour use - total (h)",ProductionSystems,"AllProdCond")*0.75;
ActCropsGrass_Inputs(FAO_Europe,"Mustard seed","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Rapeseed","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Oilseeds nes","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Rapeseed","Labour use - total (h)",ProductionSystems,"AllProdCond");

ActCropsGrass_Inputs(FAO_Europe,"Olives","Labour use - total (h)","AllProdSyst","AllProdCond") = 1800;
ActCropsGrass_Inputs(FAO_Europe,"Olives","Labour use - total (h)","Convent","AllProdCond") = 1800;
*organic: assume 20% more, as with chestnuts
ActCropsGrass_Inputs(FAO_Europe,"Olives","Labour use - total (h)","Organic","AllProdCond") = 2160;
ActCropsGrass_Inputs("Spain","Olives","Labour use - total (h)","AllProdSyst","AllProdCond") = 2034;
ActCropsGrass_Inputs("Spain","Olives","Labour use - total (h)","Convent","AllProdCond") = 2034;
*organic: assume 20% more, as with chestnuts
ActCropsGrass_Inputs("Spain","Olives","Labour use - total (h)","Organic","AllProdCond") = 2484;
ActCropsGrass_Inputs("Italy","Olives","Labour use - total (h)","AllProdSyst","AllProdCond") = 1350;
ActCropsGrass_Inputs("Italy","Olives","Labour use - total (h)","Convent","AllProdCond") = 1350;
*organic: assume 20% more, as with chestnuts
ActCropsGrass_Inputs("Italy","Olives","Labour use - total (h)","Organic","AllProdCond") = 1620;

ActCropsGrass_Inputs(FAO_Europe,"Oranges","Labour use - total (h)","AllProdSyst","AllProdCond") = 780;
ActCropsGrass_Inputs(FAO_Europe,"Oranges","Labour use - total (h)","Convent","AllProdCond") = 780;
*organic: assume same, as for apples and other fruit trees, more or less: labour input is the same, but yields are lower (thus, harvesting labour is lower!)
ActCropsGrass_Inputs(FAO_Europe,"Oranges","Labour use - total (h)","Organic","AllProdCond") = 780;

ActCropsGrass_Inputs(FAO_Europe,"Peaches and nectarines","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Plums and sloes","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Peas, dry","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Broad beans, horse beans, dry","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Peas, green","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Beans, green","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Poppy seed","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Rapeseed","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Pulses, nes","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Beans, green","Labour use - total (h)",ProductionSystems,"AllProdCond");

ActCropsGrass_Inputs(FAO_Europe,"Pumpkins, squash and gourds","Labour use - total (h)","AllProdSyst","AllProdCond") = 370;
ActCropsGrass_Inputs(FAO_Europe,"Pumpkins, squash and gourds","Labour use - total (h)","Convent","AllProdCond") = 370;
*organic: assume 50% more, not 100% more as with other vegetables
ActCropsGrass_Inputs(FAO_Europe,"Pumpkins, squash and gourds","Labour use - total (h)","Organic","AllProdCond") = 555;
ActCropsGrass_Inputs(FAO_Europe,"Quinces","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Apples","Labour use - total (h)",ProductionSystems,"AllProdCond")*0.75;
ActCropsGrass_Inputs(FAO_Europe,"Roots and tubers, nes","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Potatoes","Labour use - total (h)",ProductionSystems,"AllProdCond")*0.75;

ActCropsGrass_Inputs(FAO_Europe,"Tangerines, mandarins, clementines, satsumas","Labour use - total (h)","AllProdSyst","AllProdCond") = 520;
ActCropsGrass_Inputs(FAO_Europe,"Tangerines, mandarins, clementines, satsumas","Labour use - total (h)","Convent","AllProdCond") = 520;
*organic: assume same, as for apples and other fruit trees, more or less: labour input is the same, but yields are lower (thus, harvesting labour is lower!)
ActCropsGrass_Inputs(FAO_Europe,"Tangerines, mandarins, clementines, satsumas","Labour use - total (h)","Organic","AllProdCond") = 520;

ActCropsGrass_Inputs(FAO_Europe,"Walnuts, with shell","Labour use - total (h)","AllProdSyst","AllProdCond") = 140;
ActCropsGrass_Inputs(FAO_Europe,"Walnuts, with shell","Labour use - total (h)","Convent","AllProdCond") = 140;
ActCropsGrass_Inputs(FAO_Europe,"Walnuts, with shell","Labour use - total (h)","Organic","AllProdCond") = 160;

ActCropsGrass_Inputs(FAO_Europe,"Watermelons","Labour use - total (h)","AllProdSyst","AllProdCond") = 500;
ActCropsGrass_Inputs(FAO_Europe,"Watermelons","Labour use - total (h)","Convent","AllProdCond") = 500;
*organic: assume 50% more, not 100% more as with other vegetables
ActCropsGrass_Inputs(FAO_Europe,"Watermelons","Labour use - total (h)","Organic","AllProdCond") = 750;

ActCropsGrass_Inputs(FAO_Europe,"Tomatoes","Labour use - total (h)","AllProdSyst","AllProdCond") = 2900;
ActCropsGrass_Inputs(FAO_Europe,"Tomatoes","Labour use - total (h)","Convent","AllProdCond") = 2900;
ActCropsGrass_Inputs(FAO_Europe,"Tomatoes","Labour use - total (h)","Organic","AllProdCond") = 5800;

ActCropsGrass_Inputs(FAO_Europe,"Alfalfa For Forage+Silag","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Clover For Forage+Silage","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Beets for Fodder","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Turnips for Fodder","Labour use - total (h)",ProductionSystems,"AllProdCond");

ActCropsGrass_Inputs(FAO_Europe,"Other grasses, for forage","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Temporary meadows and pastures","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Other oilseeds, for forage","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Temporary meadows and pastures","Labour use - total (h)",ProductionSystems,"AllProdCond");
ActCropsGrass_Inputs(FAO_Europe,"Rye grass, for forage","Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(FAO_Europe,"Temporary meadows and pastures","Labour use - total (h)",ProductionSystems,"AllProdCond");


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Labour Use Data for livestock

*the CH DBK has detailed labour use data - but not on an optimal level to match the animal heads as used in SOLm.
*thus, for a fast indication, we use the data from page 362 in the Farm Management Handbook; an electronic version is available free at www.fas.scot as part of the SRDP Farm Advisory Service
*this provides very generic labour use data per head and year for the different livestock categories
*for part of the livestock, it is a very gross choice of a generic average - e.g. for chickens

ActAnimalsHead_Inputs(FAO_Europe,"Cattle",CattleTypeInHerd,"Labour use - total (h)","AllProdSyst","AllProdCond") = 12;
ActAnimalsHead_Inputs(FAO_Europe,"Cattle","Producing_Dairy_Cattle","Labour use - total (h)","AllProdSyst","AllProdCond") = 35;
ActAnimalsHead_Inputs(FAO_Europe,"Cattle","BFemaleCalves1","Labour use - total (h)","AllProdSyst","AllProdCond") = 25;
ActAnimalsHead_Inputs(FAO_Europe,"Cattle","BFemaleCalves2","Labour use - total (h)","AllProdSyst","AllProdCond") = 25;
ActAnimalsHead_Inputs(FAO_Europe,"Cattle","BMaleCalves1"  ,"Labour use - total (h)","AllProdSyst","AllProdCond") = 25;
ActAnimalsHead_Inputs(FAO_Europe,"Cattle","BMaleCalves2"  ,"Labour use - total (h)","AllProdSyst","AllProdCond") = 25;
ActAnimalsHead_Inputs(FAO_Europe,"Cattle","DMaleCalves1"  ,"Labour use - total (h)","AllProdSyst","AllProdCond") = 25;
ActAnimalsHead_Inputs(FAO_Europe,"Cattle","DMaleCalves2"  ,"Labour use - total (h)","AllProdSyst","AllProdCond") = 25;
*ActAnimalsHead_Inputs(FAO_Europe,"Cattle","Dsires        ","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Cattle","DFemaleCalves1","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Cattle","DFemaleCalves2","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Cattle","DFemaleCalves3","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Cattle","Bcows"         ,"Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Cattle","Bsires"        ,"Labour use - total (h)","AllProdSyst","AllProdCond") = ;

ActAnimalsHead_Inputs(FAO_Europe,"Pigs",PigTypeInHerd,"Labour use - total (h)","AllProdSyst","AllProdCond") = 2.5;
ActAnimalsHead_Inputs(FAO_Europe,"Pigs","Sows","Labour use - total (h)","AllProdSyst","AllProdCond") = 28;
ActAnimalsHead_Inputs(FAO_Europe,"Pigs","Sucklers","Labour use - total (h)","AllProdSyst","AllProdCond") = 0.2;
ActAnimalsHead_Inputs(FAO_Europe,"Pigs","Weaners","Labour use - total (h)","AllProdSyst","AllProdCond") = 0.2;
*ActAnimalsHead_Inputs(FAO_Europe,"Pigs","Fatteners","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Pigs","Boars","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Pigs","Rep_Sows","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Pigs","Rep_Boars","Labour use - total (h)","AllProdSyst","AllProdCond") = ;

ActAnimalsHead_Inputs(FAO_Europe,"Chickens","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = 0.2;
ActAnimalsHead_Inputs(FAO_Europe,"Sheep","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = 4;
ActAnimalsHead_Inputs(FAO_Europe,"Goats","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = 12;
ActAnimalsHead_Inputs(FAO_Europe,"Horses","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = 40;
ActAnimalsHead_Inputs(FAO_Europe,"Game","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = 15;
*ActAnimalsHead_Inputs(FAO_Europe,"Asses","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Buffaloes","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Camels","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Ducks","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Geese and guinea fowls","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Mules","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = ;
*ActAnimalsHead_Inputs(FAO_Europe,"Turkeys","AllAndAverageTypes","Labour use - total (h)","AllProdSyst","AllProdCond") = ;

*a key aspect to increase/reduce labour requirements: having smaller/larger cattle herds (the numebrs above is average for 100 cows); no specifications for the other animal types

*We assume this to be average/conventional values; for differing organic values, we use relations as provided in the CH DBK - for most animal activities, organic labour inputs is roughly equal to conventional (on a per head basis).
ActAnimalsHead_Inputs(FAO_Europe,Livestock,AnimalTypeInHerd,"Labour use - total (h)","Convent","AllProdCond")
         = ActAnimalsHead_Inputs(FAO_Europe,Livestock,AnimalTypeInHerd,"Labour use - total (h)","AllProdSyst","AllProdCond");
*default for organic: equal conventional
ActAnimalsHead_Inputs(FAO_Europe,Livestock,AnimalTypeInHerd,"Labour use - total (h)","Organic","AllProdCond")
         = ActAnimalsHead_Inputs(FAO_Europe,Livestock,AnimalTypeInHerd,"Labour use - total (h)","AllProdSyst","AllProdCond");
*specific deviating values:
ActAnimalsHead_Inputs(FAO_Europe,"Pigs",AnimalTypeInHerd,"Labour use - total (h)","Organic","AllProdCond")
         = ActAnimalsHead_Inputs(FAO_Europe,"Pigs",AnimalTypeInHerd,"Labour use - total (h)","Convent","AllProdCond")*1.1;
*from the CH DBK, chicken of various types, poultry/eggs come with factors of 2-5 between organic and conventional, so choose some mid value; - given that in the EU we have yet much much larger conventional operations than in the DBK, may rather choose 3.5 than something rather lower.
ActAnimalsHead_Inputs(FAO_Europe,"Chickens","AllAndAverageTypes","Labour use - total (h)","Organic","AllProdCond")
         = ActAnimalsHead_Inputs(FAO_Europe,"Chickens","AllAndAverageTypes","Labour use - total (h)","Convent","AllProdCond")*3.5;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Scaling to fit Eurostat data

*with the data above, when aggregating to country and EU-level, the country values of total labour input do not correspond to the country values of total labour input provided in Eurostat.
*this is based on the data for 2012 from Agricultural labour input statistics: absolute figures (1 000 annual work units) [AACT_ALI01]
*we thus correct the data here by the ratio of these values - i.e. if Eurostat gives a country a value X in total agricultural labour force input, and the value is Y when using the above SOLm data,
*then we adjust the SOLm labour input values by multiplying with (X/Y).
*the values are taken from the data in TotalLabourForceInput_EU_Countries.xlsx, year 2012
*the calculations are done in AnnualWorkingUnitInput2016_EU_NUTS2.xlsx, Sheet1
*the result are the following correction factors:
Parameter SOLm_Eurostat_LabourInputCorrection(Regions);

SOLm_Eurostat_LabourInputCorrection("Austria") =        1.08;
SOLm_Eurostat_LabourInputCorrection("Belgium") =        0.61;
SOLm_Eurostat_LabourInputCorrection("Bulgaria") =       2.04;
SOLm_Eurostat_LabourInputCorrection("Croatia") =        2.29;
SOLm_Eurostat_LabourInputCorrection("Czechia") =        0.88;
SOLm_Eurostat_LabourInputCorrection("Denmark") =        0.41;
SOLm_Eurostat_LabourInputCorrection("Estonia") =        0.45;
SOLm_Eurostat_LabourInputCorrection("Finland") =        0.59;
SOLm_Eurostat_LabourInputCorrection("France") =         0.62;
SOLm_Eurostat_LabourInputCorrection("Germany") =        0.70;
SOLm_Eurostat_LabourInputCorrection("Greece") =         0.46;
SOLm_Eurostat_LabourInputCorrection("Hungary") =        2.01;
SOLm_Eurostat_LabourInputCorrection("Ireland") =        1.34;
SOLm_Eurostat_LabourInputCorrection("Italy") =          0.65;
SOLm_Eurostat_LabourInputCorrection("Latvia") =         1.50;
SOLm_Eurostat_LabourInputCorrection("Lithuania") =      1.53;
SOLm_Eurostat_LabourInputCorrection("Luxembourg") =     0.79;
SOLm_Eurostat_LabourInputCorrection("Netherlands") =    0.84;
SOLm_Eurostat_LabourInputCorrection("Poland") =         2.12;
SOLm_Eurostat_LabourInputCorrection("Portugal") =       0.42;
SOLm_Eurostat_LabourInputCorrection("Romania") =        2.80;
SOLm_Eurostat_LabourInputCorrection("Slovakia") =       1.03;
SOLm_Eurostat_LabourInputCorrection("Slovenia") =       3.01;
SOLm_Eurostat_LabourInputCorrection("Spain") =          0.20;
SOLm_Eurostat_LabourInputCorrection("Sweden") =         0.41;
SOLm_Eurostat_LabourInputCorrection("United Kingdom") = 0.57;



ActAnimalsHead_Inputs(Regions,Livestock,AnimalTypeInHerd,"Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActAnimalsHead_Inputs(Regions,Livestock,AnimalTypeInHerd,"Labour use - total (h)",ProductionSystems,"AllProdCond")
                 *SOLm_Eurostat_LabourInputCorrection(Regions);

ActCropsGrass_Inputs(Regions,Activities,"Labour use - total (h)",ProductionSystems,"AllProdCond")
         = ActCropsGrass_Inputs(Regions,Activities,"Labour use - total (h)",ProductionSystems,"AllProdCond")
                 *SOLm_Eurostat_LabourInputCorrection(Regions);



*next to do:
*assign labour for new practices besides organic: undersowing (check DBK cereals) - agroforestry (if modelled).


$exit;



