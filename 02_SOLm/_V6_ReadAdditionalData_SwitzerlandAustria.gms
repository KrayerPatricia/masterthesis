*manure management systems: default for AUSTRIA is different than our IPCC 2006 default data and the data above; thus replace with better data from the GHG-inventory 2019, tables 174 and 175:
Parameter ManMan_QuantityShares_Austria(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem) values related to manure management IN AUSTRIA - UNIT: units management values per t manure TS DM if not indicated otherwise;

$call GDXXRW ManureManagementData_Austria.xlsx  o=ManManData_Austria.gdx  index=index!a1

$GDXIN ManManData_Austria.gdx
$load ManMan_QuantityShares_Austria
$GDXIN ManManData_Austria.gdx

*remove data for the animals to be improved, then add new data:
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions) = 0;
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
         = ManMan_QuantityShares_Austria("Austria",Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem);

Manure_Management("Austria","Cattle",AnimalTypeInHerd,"MCF: CH4 conversion factor (%)","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
                 $Manure_Management("Austria","Cattle",AnimalTypeInHerd,"Quantity share in ManureMan system","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
         = 8.1;
Manure_Management("Austria","Cattle","Producing_Dairy_Cattle","MCF: CH4 conversion factor (%)","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
                 $Manure_Management("Austria","Cattle","Producing_Dairy_Cattle","Quantity share in ManureMan system","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
         = 8.8;
Manure_Management("Austria","Pigs",AnimalTypeInHerd,"MCF: CH4 conversion factor (%)","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
                 $Manure_Management("Austria","Pigs",AnimalTypeInHerd,"Quantity share in ManureMan system","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
         = 3.4;

*Ash contents from GHG inventory, some averaged values from cattle types:
Manure_OtherChar("Austria","Cattle",CattleTypeInHerd,"Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.115;




PUTCLOSE con,"_V6_ReadAdditionalData_SwitzerlandAustria";

*GENERAL DESCRIPTION
*This file contains the code to read more detailed data for Switzerland and Austria


*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Define, load, etc. Swiss and Austrian sub-country data
         1.1) Define sets, variables and parameters and load data
         1.2) Assign data to SOLm entities
- 2) Define further specific CH and AT sub-country values
- 3) Assign values for CH and AT to country sub-regions where no specific values are available
         3.1) Main parameters CH
                 3.1.1) Activities: input parameters
                 3.1.2) Activities: output parameters
                 3.1.3) Activities: other characteristics
                 3.1.4) Commodities: nutrient contents and other characteristics
                 3.1.5) Commodity tree parameters
                 3.1.6) Crop residues: nutrient contents, other characteristics and management
                 3.1.7) Feeding rations
                 3.1.8) Manure: nutrient contents, other characteristics and management
                 3.1.9) Fertilizer application: nutrients and other characteristics
         3.2) Main parameters AT
                 3.2.1) Activities: input parameters
                 3.2.2) Activities: output parameters
                 3.2.3) Activities: other characteristics
                 3.2.4) Commodities: nutrient contents and other characteristics
                 3.2.5) Commodity tree parameters
                 3.2.6) Crop residues: nutrient contents, other characteristics and management
                 3.2.7) Feeding rations
                 3.2.8) Manure: nutrient contents, other characteristics and management
                 3.2.9) Fertilizer application: nutrients and other characteristics

$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Define, load, etc. Swiss and Austrian sub-country data
*1.1) Define sets, variables and parameters and load data
*the following defines sets and parameters for adding the more detailed Swiss and Austrian datathe
*thi has originally been done for the so-called "Alpenprojekt" in 2014ff

$ifthen %IncludeExcel_Grundlagenbericht2014% == "YES"
$call GDXXRW Grundlagenbericht_2014.xls  o=Grundlagenbericht2014.gdx  index=index!a1
*contains the data from the Grundlagenbericht 2014, Switzerland
$endif;

$ifthen %IncludeExcel_ATData% == "YES"
$call GDXXRW hochAVG_overview_HPG-Bio_EN.xlsx  o=ATData.gdx  index=index!a1
*contains the data from Austria
$endif;

SET ProdSystems_CH_AT
                 /
                 Conventional_Tal, Conventional_Huegel, Conventional_Berg,
                 Organic_Tal, Organic_Huegel, Organic_Berg,

                 "Hochalpengebiet, alle"
                 "Hochalpengebiet, Bio"
                 "Hochalpengebiet, Konventionell"
                 "Voralpengebiet, alle"
                 "Voralpengebiet, Bio"
                 "Voralpengebiet, Konventionell"
                 "Alpenostrand, alle"
                 "Alpenostrand, Bio"
                 "Alpenostrand, Konventionell"
                 "Wald- und Mühlviertel, alle"
                 "Wald- und Mühlviertel, Bio"
                 "Wald- und Mühlviertel, Konventionell"
                 "Kärntner Becken, alle"
                 "Kärntner Becken, Bio"
                 "Kärntner Becken, Konventionell"
                 "Alpenvorland, alle"
                 "Alpenvorland, Bio"
                 "Alpenvorland, Konventionell"
                 "Südöstliches Flach- und Hügelland, alle"
                 "Südöstliches Flach- und Hügelland, Bio"
                 "Südöstliches Flach- und Hügelland, Konventionell"
                 "Nordöstliches Flach- und Hügelland, alle"
                 "Nordöstliches Flach- und Hügelland, Bio"
                 "Nordöstliches Flach- und Hügelland, Konventionell"
/;

SET Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions)
/
Conventional_Tal.Convent.Switzerland_Tal
Conventional_Huegel.Convent.Switzerland_Huegel
Conventional_Berg.Convent.Switzerland_Berg
Organic_Tal.Organic.Switzerland_Tal
Organic_Huegel.Organic.Switzerland_Huegel
Organic_Berg.Organic.Switzerland_Berg

"Hochalpengebiet, alle".AllProdSyst.Austria_Hochalpen
"Hochalpengebiet, Bio".Organic.Austria_Hochalpen
"Hochalpengebiet, Konventionell".Convent.Austria_Hochalpen
"Voralpengebiet, alle".AllProdSyst.Austria_Voralpen
"Voralpengebiet, Bio".Organic.Austria_Voralpen
"Voralpengebiet, Konventionell".Convent.Austria_Voralpen
"Alpenostrand, alle".AllProdSyst.Austria_Alpenostrand
"Alpenostrand, Bio".Organic.Austria_Alpenostrand
"Alpenostrand, Konventionell".Convent.Austria_Alpenostrand
"Wald- und Mühlviertel, alle".AllProdSyst.Austria_WaldMuehlViertel
"Wald- und Mühlviertel, Bio".Organic.Austria_WaldMuehlViertel
"Wald- und Mühlviertel, Konventionell".Convent.Austria_WaldMuehlViertel
"Kärntner Becken, alle".AllProdSyst.Austria_KaerntnerBecken
"Kärntner Becken, Bio".Organic.Austria_KaerntnerBecken
"Kärntner Becken, Konventionell".Convent.Austria_KaerntnerBecken
"Alpenvorland, alle".AllProdSyst.Austria_Alpenvorland
"Alpenvorland, Bio".Organic.Austria_Alpenvorland
"Alpenvorland, Konventionell".Convent.Austria_Alpenvorland
"Südöstliches Flach- und Hügelland, alle".AllProdSyst.Austria_SuedoestlFlachHuegelland
"Südöstliches Flach- und Hügelland, Bio".Organic.Austria_SuedoestlFlachHuegelland
"Südöstliches Flach- und Hügelland, Konventionell".Convent.Austria_SuedoestlFlachHuegelland
"Nordöstliches Flach- und Hügelland, alle".AllProdSyst.Austria_NordoestlFlachHuegelland
"Nordöstliches Flach- und Hügelland, Bio".Organic.Austria_NordoestlFlachHuegelland
"Nordöstliches Flach- und Hügelland, Konventionell".Convent.Austria_NordoestlFlachHuegelland

/;

SET Units_CH_AT
                 /
                 Anzahl,
                 GVE,
                 JAE,
                 FJAE,
                 AJAE,
                 Tage,
                 '%',
                 ha
                 'Stück'
                 'GVE/ha LN'
                 'a/RGVE'
                 'ha LN/JAE'
                 'kg/Kuh'
                 'dt/ha'
                 Quantity, DM_Quantity, GE, XP
                 QuantityShare,DM_Quantity_Share, GE_Share, XP_Share
                 DM_Contents, GE_Contents, XP_Contents, GE_DM_Contents, XP_DM_Contents
                 /;
SET NutrientContents_CH_AT(Units_CH_AT)
                 /
                 DM_Contents, GE_Contents, XP_Contents, GE_DM_Contents, XP_DM_Contents
                 /;

SET Units_FeedAlpenprojekt(Units_CH_AT) /Quantity, DM_Quantity, GE, XP/;
SET Units_FeedAlpenprojekt_ShareInTotal(Units_CH_AT) /QuantityShare,DM_Quantity_Share, GE_Share, XP_Share/;

SET CropVariables_CH_AT
                 /
                 Referenzbetriebe
                 'Vertretene Betriebe'
                 'Tierbestand total (im Eigentum)'
                 'Arbeitskräfte Betrieb'
                 'Familienarbeitskräfte'
                 Angestellte
                 'Anteil Angestellte an den JAE Betrieb'
                 'Arbeitskräfte betriebsfremd, Nebengeschäft'
                 'Normalarbeitstage Betrieb'
                 Familie
                 'Betriebsfläche (inkl. verpachtete Fläche)'
                 'Betriebsfläche im Eigentum'
                 'Davon: verpachtete Betriebsfläche'
                 'Gepachtete Betriebsfläche'
                 'Kulturfläche'
                 'Landwirtschaftliche Nutzfläche'
                 'Offene Ackerfläche'
                 Brotgetreide
                 Weizen
                 Roggen
                 Dinkel
                 'Übriges Brotgetreide'
                 Futtergetreide
                 Hafer
                 Gerste
                 Triticale
                 'Übriges Futtergetreide'
                 'Körnermais'
                 Silomais
                 Kartoffeln
                 'Zuckerrüben'
                 Raps
                 'Freiland-Konservengemüse'
                 'Verschiedenes Freilandgemüse'
                 'Futterrüben'
                 Eiweisserbsen
                 Ackerbohnen
                 Tabak
                 Sonnenblumen
                 Soja
                 'Andere Ackerkulturen'
                 Buntbrache
                 Rotationsbrache
                 'Grünland'
                 Kunstwiesen
                 'Naturwiesen, Dauerweiden'
                 Dauerkulturen
                 Reben
                 Obstanlagen
                 Beeren
                 'Verschiedene Dauerkulturen'
                 'Kulturen in ganzjährig geschütztem Anbau'
                 'Verschiedene Flächen'
                 Wald
                 'Betriebsfläche ausserhalb der Kulturfläche'
                 'Alpine pastures'
                 'Ackerfutterfläche'
                 'Hauptfutterfläche'
                 Spezialkulturen
                 'Anteil offene Ackerfläche an der LN'
                 /;

SET AnimalVariables_CH_AT
                 /
                 Referenzbetriebe
                 'Vertretene Betriebe'
                 'Landwirtschaftliche Nutzfläche'
                 'Tierbestand total (im Eigentum)'
                 'Milchkühe'
                 'Mutterkühe'
                 'Anderes Rindvieh'
                 'Aufzuchtvieh und Stiere'
                 'Grosses Mastvieh'
                 'Kälber von Mutterkühen unter 1-jährig'
                 'Aufzuchtkälber unter 4 Monate'
                 'Kälber zur Grossviehmast unter 4 Monate'
                 'Mastkälber'
                 'Tierbestand total'
                 Rindvieh
                 'Andere Kälber'
                 'Verschiedene Raufutter verzehrende Tiere'
                 Pferde
                 Schafe
                 Ziegen
                 'Übrige Raufutter verzehrende Tiere'
                 Schweine
                 Zuchtschweine
                 Mastschweine
                 'Abgesetzte Ferkel'
                 'Geflügel'
                 'Mastgeflügel'
                 Legehennen
                 'Übrige Tiere'
                 'Raufutter verzehrende Tiere'
                 'Davon: Rindvieh'
                 Tierbesatz
                 'Hauptfutterfläche je RGVE'
                 'Fläche je Arbeitskraft'
                 Milchleistung
                 'Weizen Naturalertrag'
                 /;

PARAMETER GB2014_WorkCrops(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years) labour family and crop data from the Grundlagenbericht 2014;
PARAMETER GB2014_Animals(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years) animal data from the Grundlagenbericht 2014;

PARAMETER ATData_WorkCrops(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years) labour family and crop data from Austria;
PARAMETER ATData_Animals(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years) animal data from Austria;

*the swiss regions are collected in a set that has already been defined:
*SET SET_RegionsSwitzerland /Switzerland_Tal, Switzerland_Huegel, Switzerland_Berg/;

*load parameters
*Grundlagenbericht_2014.xlsx --> Grundlagenbericht2014.gdx
$GDXIN Grundlagenbericht2014.gdx
$load GB2014_WorkCrops
$load GB2014_Animals
$GDXIN Grundlagenbericht2014.gdx

$GDXIN ATData.gdx
$load ATData_WorkCrops
$load ATData_Animals
$GDXIN ATData.gdx


*the following assigns all variables/parameters from GB2014_WorkCrops to SOLm variables/parameters:
*non assigned variables/parameters are currently not used in SOLm

SET Match_Crops_CH_AT_SOLm(CropVariables_CH_AT,Activities)
/
Triticale.Triticale
*Referenzbetriebe
*Vertretene Betriebe
*Tierbestand total (im Eigentum)
*Arbeitskräfte Betrieb
*Familienarbeitskräfte
*Angestellte
*Anteil Angestellte an den JAE Betrieb
*Arbeitskräfte betriebsfremd, Nebengeschäft
*Normalarbeitstage Betrieb
*Familie
*Betriebsfläche (inkl. verpachtete Fläche)
*Betriebsfläche im Eigentum
*Davon: verpachtete Betriebsfläche
*Gepachtete Betriebsfläche
*Kulturfläche
*Landwirtschaftliche Nutzfläche
*Offene Ackerfläche
*Brotgetreide
*        Brotgetreide is the sum of Weizen, Roggen, Dinkel and übriges Brotgetreide (which is always zero, however).                                                                                                                    \
Weizen.Wheat
Roggen.Rye
Dinkel.Spelt
*Futtergetreide
*        Futtergetreide is the sum of Hafer, Gerste, Triticale and übriges Futergetreide;                                                                                                                                               \
Hafer.Oats
Gerste.Barley
"Übriges Futtergetreide"."Cereals, nes"
*        übriges Futtergetreide is assigned to the existing activity "Cereals, nes" in SOLm                                                                                                                                             \
"Körnermais".Maize
Silomais."Maize For Forage+Silage"
Kartoffeln.Potatoes
"Zuckerrüben"."Sugar beet"
Raps."Rapeseed"
*Freiland-Konservengemüse
*Verschiedenes Freilandgemüse
*        combine those to get group vegetables konservengemüse: ask Bernadette whether this is ok


************ProdActIOEnv("ActGroup_Vegetables","Crop","&Switzerland_Subreg","AverageClimate","AverageSoilType","&ProdSyst","AreaHarvested","AverageSeason",Year)                                                                                   \
****************         = GB2014_WorkCrops("Freiland-Konservengemüse","ha","&GB2014_ProdSystReg",Year) + GB2014_WorkCrops("Verschiedenes Freilandgemüse","ha","&GB2014_ProdSystReg",Year);                                                            \


"Futterrüben"."Beets for fodder"
Eiweisserbsen.Lupins
*        assign this to lupins
Ackerbohnen."Broad beans, horse beans, dry"
*        assign this to "Broad beans, horse beans, dry"
Tabak."Tobacco, unmanufactured"
Sonnenblumen."Sunflower seed"
Soja.Soybeans
"Andere Ackerkulturen"."Other annual crops"
*Buntbrache
*Rotationsbrache

*assign the previous two in sum to "fallows"
***************ProdActIOEnv("Fallows","Crop","&Switzerland_Subreg","AverageClimate","AverageSoilType","&ProdSyst","AreaHarvested","AverageSeason",Year)
****************         = GB2014_WorkCrops("Buntbrache","ha","&GB2014_ProdSystReg",Year) + GB2014_WorkCrops("Rotationsbrache","ha","&GB2014_ProdSystReg",Year);


*Grünland is an aggregate of other issues further down                                                                                                                                                                             \
*Grünland
Kunstwiesen."Temporary meadows and pastures"
"Naturwiesen, Dauerweiden"."Permanent meadows and pastures"
*Dauerkulturen
*Dauerkulturen is an aggregate of other issues further down                                                                                                                                                                             \
Reben.Grapes


*assume Obstanlagen and Beeren to cover all fruits besides grapes
********ProdActIOEnv("ActGroup_FruitsWithoutGrapes","Crop","&Switzerland_Subreg","AverageClimate","AverageSoilType","&ProdSyst","AreaHarvested","AverageSeason",Year)
*********         = GB2014_WorkCrops("Obstanlagen","ha","&GB2014_ProdSystReg",Year) + GB2014_WorkCrops("Beeren","ha","&GB2014_ProdSystReg",Year);
*Obstanlagen
*Beeren


"Verschiedene Dauerkulturen"."Other permanent crops"
*the following is not used as in the GB, it is not counted under cropland and under grassland neither
*Verschiedene Flächen
*the follwoing are not used
*Wald
*Betriebsfläche ausserhalb der Kulturfläche
"Alpine pastures"."Alpine pastures"
*Ackerfutterfläche
*Hauptfutterfläche
*Spezialkulturen
*Anteil offene Ackerfläche an der LN
/;

*Thus we have defined the new sets for the Alpenprojekt;

*assign GB2014 data to SOLm variables:
*first, as Grundlagenbericht 2014 values are per average farm, we multiply with the number of farms the average is representative of:
*to not lose original data, define a new parameter:
PARAMETER GB2014_WorkCropsTotals(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years);
PARAMETER ATData_WorkCropsTotals(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years);

GB2014_WorkCropsTotals(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years)
         = GB2014_WorkCrops(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years)
                 *GB2014_WorkCrops("Vertretene Betriebe","Anzahl",ProdSystems_CH_AT,Years);

ATData_WorkCropsTotals(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years)
         = ATData_WorkCrops(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years)
                 *ATData_WorkCrops("Vertretene Betriebe","Anzahl",ProdSystems_CH_AT,Years);

*then, take averages over the years available (2011-2013)

Parameter NumberOfBasisYearsGB2014;
Set BasisYears_CH_AT(Years) /2011*2013/;

NumberOfBasisYearsGB2014(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT)
         = SUM(BasisYears_CH_AT$GB2014_WorkCropsTotals(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,BasisYears_CH_AT),1);

GB2014_WorkCropsTotals(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,"AverageBasisYear")
                 $NumberOfBasisYearsGB2014(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT)
         = SUM(BasisYears_CH_AT,GB2014_WorkCropsTotals(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,BasisYears_CH_AT))
                 /NumberOfBasisYearsGB2014(CropVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT);

*Assigning the average over the basis years has already been done for the ATData in excel


*1.2) Assign data to SOLm entities

VActCropsGrass_QuantityActUnits.l(Regions,Activities,ProductionSystems,"AllProdCond")
                 $(NOT VActCropsGrass_QuantityActUnits.l(Regions,Activities,ProductionSystems,"AllProdCond"))
         = sum((ProdSystems_CH_AT,CropVariables_CH_AT)
                 $(Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions) AND Match_Crops_CH_AT_SOLm(CropVariables_CH_AT,Activities)),
                 GB2014_WorkCropsTotals(CropVariables_CH_AT,"ha",ProdSystems_CH_AT,"AverageBasisYear"));

VActCropsGrass_QuantityActUnits.l(Regions,Activities,ProductionSystems,"AllProdCond")
                 $(NOT VActCropsGrass_QuantityActUnits.l(Regions,Activities,ProductionSystems,"AllProdCond"))
         = sum((ProdSystems_CH_AT,CropVariables_CH_AT)
                 $(Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions) AND Match_Crops_CH_AT_SOLm(CropVariables_CH_AT,Activities)),
                 ATData_WorkCropsTotals(CropVariables_CH_AT,"ha",ProdSystems_CH_AT,"AverageBasisYear"));

*drop the AllPRodSyst data for AT, as it is rebult afterwords as the sum of conv + org - not dropping it leads to some slight inconsistency in the sums, likely related to the temporal average.
VActCropsGrass_QuantityActUnits.l(Regions_Switzerland,Activities,"AllProdSyst","AllProdCond")
         = 0;
VActCropsGrass_QuantityActUnits.l(Regions_Austria,Activities,"AllProdSyst","AllProdCond")
         = 0;
*derive AllProdSyst = Conv + Org to be surely consistent
VActCropsGrass_QuantityActUnits.l(Regions_Switzerland,Activities,"ALlProdSyst","AllProdCond")
         = VActCropsGrass_QuantityActUnits.l(Regions_Switzerland,Activities,"Convent","AllProdCond")
                 + VActCropsGrass_QuantityActUnits.l(Regions_Switzerland,Activities,"Organic","AllProdCond");
VActCropsGrass_QuantityActUnits.l(Regions_Austria,Activities,"ALlProdSyst","AllProdCond")
         = VActCropsGrass_QuantityActUnits.l(Regions_Austria,Activities,"Convent","AllProdCond")
                 + VActCropsGrass_QuantityActUnits.l(Regions_Austria,Activities,"Organic","AllProdCond");

ActCropsGrass_OtherChar(Regions_Switzerland,Activities,"share organic in total area (share ha)","AllProdSyst","AllProdCond")
                 $VActCropsGrass_QuantityActUnits.l(Regions_Switzerland,Activities,"AllProdSyst","AllProdCond")
         = VActCropsGrass_QuantityActUnits.l(Regions_Switzerland,Activities,"Organic","AllProdCond")
                 /VActCropsGrass_QuantityActUnits.l(Regions_Switzerland,Activities,"AllProdSyst","AllProdCond");
ActCropsGrass_OtherChar(Regions_Austria,Activities,"share organic in total area (share ha)","AllProdSyst","AllProdCond")
                 $VActCropsGrass_QuantityActUnits.l(Regions_Austria,Activities,"AllProdSyst","AllProdCond")
         = VActCropsGrass_QuantityActUnits.l(Regions_Austria,Activities,"Organic","AllProdCond")
                 /VActCropsGrass_QuantityActUnits.l(Regions_Austria,Activities,"AllProdSyst","AllProdCond");

*drop the AllProdSyst again to keep org and conv for this new AT and CH data only
VActCropsGrass_QuantityActUnits.l(Regions_Switzerland,Activities,"AllProdSyst","AllProdCond")
         = 0;
VActCropsGrass_QuantityActUnits.l(Regions_Austria,Activities,"AllProdSyst","AllProdCond")
         = 0;



*ANILMAL DATA:
*the following lists the Animal variables from GB2014 and how they are assigned to SOLm parameters/variables:
*first, as the data provide values are per average farm, we multiply with the number of farms the average is representative of:
*to not loose original data, define a new parameter:
PARAMETER GB2014_AnimalsTotals(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years);
PARAMETER ATData_AnimalsTotals(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years);

GB2014_AnimalsTotals(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years)
         = GB2014_Animals(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years)
                 *GB2014_Animals("Vertretene Betriebe","Anzahl",ProdSystems_CH_AT,Years);
ATData_AnimalsTotals(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years)
         = ATData_Animals(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,Years)
                 *ATData_Animals("Vertretene Betriebe","Anzahl",ProdSystems_CH_AT,Years);

*then, for the CH-data, where no average is yet available, take averages over the years available (2011-2013)

NumberOfBasisYearsGB2014(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT)
         = SUM(BasisYears_CH_AT$GB2014_AnimalsTotals(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,BasisYears_CH_AT),1);

GB2014_AnimalsTotals(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,"AverageBasisYear")
                 $NumberOfBasisYearsGB2014(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT)
         = SUM(BasisYears_CH_AT,GB2014_AnimalsTotals(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT,BasisYears_CH_AT))
                 /NumberOfBasisYearsGB2014(AnimalVariables_CH_AT,Units_CH_AT,ProdSystems_CH_AT);

*as the type of this variable/parameter is different (no total but per head value) do it separately for the milk yield:
GB2014_AnimalsTotals("Milchleistung","kg/Kuh",ProdSystems_CH_AT,"AverageBasisYear")
                 $Sum(BasisYears_CH_AT,GB2014_AnimalsTotals("Milchkühe","Stück",ProdSystems_CH_AT,BasisYears_CH_AT))
         = Sum(BasisYears_CH_AT,GB2014_Animals("Milchleistung","kg/Kuh",ProdSystems_CH_AT,BasisYears_CH_AT)
                 * GB2014_AnimalsTotals("Milchkühe","Stück",ProdSystems_CH_AT,BasisYears_CH_AT))
                /Sum(BasisYears_CH_AT,GB2014_AnimalsTotals("Milchkühe","Stück",ProdSystems_CH_AT,BasisYears_CH_AT));

*Assigning the average over the basis years has already been done for the ATData in excel


*Referenzbetriebe
*"Vertretene Betriebe"
*"Tierbestand total (im Eigentum)"
*"Landwirtschaftliche Nutzfläche"
*****"Milchkühe"

VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Milk producing",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Milk producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Milchkühe","Stück",ProdSystems_CH_AT,"AverageBasisYear"));
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Producing_Dairy_Cattle",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Milk producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Milchkühe","Stück",ProdSystems_CH_AT,"AverageBasisYear"));

VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Milk producing",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Milk producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Milchkühe","Stück",ProdSystems_CH_AT,"AverageBasisYear"));
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Producing_Dairy_Cattle",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Milk producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Milchkühe","Stück",ProdSystems_CH_AT,"AverageBasisYear"));

*the corresponding herd structure animal is Producing_Dairy_Cattle, thus assign this as well:
*simplify the above by assigning Producing_dairy_cattle equal to Milk producing without the conditional - wouldn't this also work and then allow to drop teh following=?

VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,"Cattle","Producing_Dairy_Cattle",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,"Cattle","Milk producing",ProductionSystems,"AllProdCond");
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","Producing_Dairy_Cattle",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","Milk producing",ProductionSystems,"AllProdCond");

*****"Mutterkühe": assume to equal BCowa
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BCows",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BCows",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Mutterkühe","Stück",ProdSystems_CH_AT,"AverageBasisYear"));
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BCows",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BCows",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Mutterkühe","Stück",ProdSystems_CH_AT,"AverageBasisYear"));

*****"Aufzuchtvieh und Stiere"
*Switzerland: assume B and D sires to cover 2.5% of Aufzuchtvieh und Stiere: thus just take 1,25% of this for each; the rest is assigned to Dcalves 2:
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BSires",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BSires",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Aufzuchtvieh und Stiere","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*0.025/2;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DSires",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DSires",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Aufzuchtvieh und Stiere","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*0.025/2;

*Austria: assinging it to D and B sires each 50% is ok:
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BSires",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BSires",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Aufzuchtvieh und Stiere","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DSires",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DSires",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Aufzuchtvieh und Stiere","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;

*****"Grosses Mastvieh"
*assume B male and female calves 2 to cover grosses Mastvieh: thus just take 50% of this for each: division by 2:
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BMaleCalves2",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BMaleCalves2",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Grosses Mastvieh","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BFemaleCalves2",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BFemaleCalves2",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Grosses Mastvieh","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;

VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BMaleCalves2",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BMaleCalves2",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Grosses Mastvieh","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BFemaleCalves2",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BFemaleCalves2",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Grosses Mastvieh","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;

*****"Kälber von Mutterkühen unter 1-jährig"
*assume B male and female calves 1 to cover calves unter 1 jährig: thus just take 50% of this for each: division by 2:                                   \
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BMaleCalves1",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BMaleCalves1",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Kälber von Mutterkühen unter 1-jährig","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BFemaleCalves1",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BFemaleCalves1",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Kälber von Mutterkühen unter 1-jährig","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;

VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BMaleCalves1",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BMaleCalves1",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Kälber von Mutterkühen unter 1-jährig","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BFemaleCalves1",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","BFemaleCalves1",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Kälber von Mutterkühen unter 1-jährig","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;

*****"Aufzuchtkälber unter 4 Monate"
*****"Kälber zur Grossviehmast unter 4 Monate"
*assume the above two categories Aufzuchtkälber below 4 months, Kälber Grossviehmast below 4 months to cover all dairy calve1 categories (Dfemale, male calves 1);
*thus sum those two GB categories and divide by 2 to assign to the SOLm categories:
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DMaleCalves1",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DMaleCalves1",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Aufzuchtkälber unter 4 Monate","Stück",ProdSystems_CH_AT,"AverageBasisYear")
                 + GB2014_AnimalsTotals("Kälber zur Grossviehmast unter 4 Monate","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves1",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves1",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Aufzuchtkälber unter 4 Monate","Stück",ProdSystems_CH_AT,"AverageBasisYear")
                 + GB2014_AnimalsTotals("Kälber zur Grossviehmast unter 4 Monate","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;
*****"Mastkälber"
*assume the above category Mastkälber plus 97.5% of "Aufzuchtvieh und Stiere" to cover all dairy calve 2 and 3 categories (Dfemale, male calves 2,3);
*thus sum those three GB categories and divide by 5 to assign to the SOLm categories:
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DMaleCalves2",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DMaleCalves2",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Aufzuchtvieh und Stiere","Stück",ProdSystems_CH_AT,"AverageBasisYear")*0.975
                 + GB2014_AnimalsTotals("Mastkälber","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/3;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves2",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves2",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Aufzuchtvieh und Stiere","Stück",ProdSystems_CH_AT,"AverageBasisYear")*0.975
                 + GB2014_AnimalsTotals("Mastkälber","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/3;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves3",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves3",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Aufzuchtvieh und Stiere","Stück",ProdSystems_CH_AT,"AverageBasisYear")*0.975
                 + GB2014_AnimalsTotals("Mastkälber","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/3;

$ontext;
*we have 3 categorisations of cattle: from the GB data, GHG-inventory, SOLm default: the above equations allocate those to each other, summarised below:
*****"Milchkühe" Producing_Dairy_Cattle
*****"Mutterkühe": assume to equal BCows

*assume B and D sires to cover a small part of Aufzuchtvieh und Stiere: thus just take 1.25% of this for each: GHG inventory: together with BCows adding to "other mature cattle"

*Remaining 97.5% of "Aufzuchtvieh und Stiere": allocate to    2nd/3rd year D calves 2/3

*assume B male and female calves 2 to cover grosses Mastvieh: thus just take 50% of this for each: division by 2:
*assume B male and female calves 1 to cover "Kälber von Mutterkühen unter 1-jährig": thus just take 50% of this for each: division by 2: INVENTORY: pre-weaned calves                                  \

*****"Aufzuchtkälber unter 4 Monate"            BC 0-4                D calves 1
*****"Kälber zur Grossviehmast unter 4 Monate"  Breeding cattle 4-12  D calves 1
*****"Mastkälber"                               2nd/3rd year          D calves 2/3

Categories from the GHG inventory:
Pre-Weaned Calves
Fattening Calves
Fattening Calves (0-4 months)
Fattening Cattle (4-12 months)

Breeding Calves
Breeding Cattle (4-12 months)
Breeding Cattle (> 1 year)
         Breeding Cattle 2nd Year
         Breeding Cattle 3rd Year
$offtext;



*for Austria, assign the Aufzuchtkälber unter 4 Monate to D...calves1
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DMaleCalves1",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DMaleCalves1",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Aufzuchtkälber unter 4 Monate","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves1",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves1",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Aufzuchtkälber unter 4 Monate","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/2;
*and anderes Rindvieh to DMaleCalves2, DFemaleCalves2 and 3:
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DMaleCalves2",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DMaleCalves2",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Anderes Rindvieh","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/3;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves2",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves2",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Anderes Rindvieh","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/3;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves3",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","DFemaleCalves3",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Anderes Rindvieh","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/3;

*comparing this data with total cattle numbers in AT (as e.g. taken from the GHG inventory for the year of 2012 or 2013 or so) does not fit - Producing_Dairy_Cattle is ok, but the others not.
*Thus scale all the other numbers to fit the totals
*current numbers for cattle besides dairy cows sum to 2512153 but should be 1450000 only, so multiply all with this proportion, i.e. 0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BFemaleCalves1",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BFemaleCalves1",ProductionSystems,"AllProdCond")*0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BFemaleCalves2",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BFemaleCalves2",ProductionSystems,"AllProdCond")*0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BMaleCalves1",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BMaleCalves1",ProductionSystems,"AllProdCond")*0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BMaleCalves2",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BMaleCalves2",ProductionSystems,"AllProdCond")*0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DFemaleCalves1",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DFemaleCalves1",ProductionSystems,"AllProdCond")*0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DFemaleCalves2",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DFemaleCalves2",ProductionSystems,"AllProdCond")*0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DFemaleCalves3",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DFemaleCalves3",ProductionSystems,"AllProdCond")*0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DMaleCalves1",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DMaleCalves1",ProductionSystems,"AllProdCond")*0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DMaleCalves2",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DMaleCalves2",ProductionSystems,"AllProdCond")*0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BSires",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BSires",ProductionSystems,"AllProdCond")*0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DSires",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","DSires",ProductionSystems,"AllProdCond")*0.5772;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BCows",ProductionSystems,"AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","BCows",ProductionSystems,"AllProdCond")*0.5772;

$ontext;
*comparing this allocation above with the AT GHG-Inventory roughly works by equalling as follows:
Inventory         SOLm
Dairy cattle      Producing_dairy_cattle
< 1 year old      all Calves1
1-2 years old     all Calves2
older + suckling  B/DSires, BCows, Calves3
$offtext;


*"Tierbestand total"
*****Rindvieh; GVE-factor chosen to match with GB data
$ontext;
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Rindvieh","GVE",ProdSystems_CH_AT,"AverageBasisYear"))*0.625;

VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Rindvieh","GVE",ProdSystems_CH_AT,"AverageBasisYear"))*0.625;
factor 0.625 should rather be a DIVISION, shouldn't it?
$offtext;
*do NOT use the calculations above, based on the reported GVE values - rather just sum the other animal categories to get the totals:
VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,"Cattle","Living",ProductionSystems,"AllProdCond")
         = sum(AnimalTypeInHerd_NoAggregates,VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,"Cattle",AnimalTypeInHerd_NoAggregates,ProductionSystems,"AllProdCond"));
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle","Living",ProductionSystems,"AllProdCond")
         = sum(AnimalTypeInHerd_NoAggregates,VActAnimalsHead_QuantityActUnits.l(Regions_Austria,"Cattle",AnimalTypeInHerd_NoAggregates,ProductionSystems,"AllProdCond"));


*derive number of producing animals for meat: take Grosses Mastvieh, Mastkälber and Kälber von Mutterkühen unter 1-jährig (as those are slughtered for veal meat below 5 months, for beef below 10 months)           \
*times 3, as they live considerably less than a year on average and are replaced - the factor 3 is derived from FAOSTAT Swiss meat producing cattle numbers for 2012 and 2013, on average 648'000, thus 3*215'000,   \
*where 215'000 is about the number of producing meat cattle as reported when summing the 3 categories below;                                          \
VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Meat producing",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Meat producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Grosses Mastvieh","Stück",ProdSystems_CH_AT,"AverageBasisYear")
                 + GB2014_AnimalsTotals("Mastkälber","Stück",ProdSystems_CH_AT,"AverageBasisYear")
                 + GB2014_AnimalsTotals("Kälber von Mutterkühen unter 1-jährig","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*3;

VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Meat producing",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Cattle","Meat producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Grosses Mastvieh","Stück",ProdSystems_CH_AT,"AverageBasisYear")
                 + ATData_AnimalsTotals("Mastkälber","Stück",ProdSystems_CH_AT,"AverageBasisYear")
                 + ATData_AnimalsTotals("Kälber von Mutterkühen unter 1-jährig","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*3;

*"Andere Kälber"
*"Verschiedene Raufutter verzehrende Tiere"
*convert from GVE to animal heads via the GVE factors from 910.91_GVE definitions.pdf
*GVE chosen such as to best meet total numbers as reported in the GHG inventories of CH and AT (years 2013) - this applies to sheep and goats in particular, but also pigs, where the suckled animals come without GVE but are counted in living animal numbers.

*****Pferde
VActAnimalsHead_QuantityActUnits.l(Regions,"Horses","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Horses","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Pferde","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/0.24;
VActAnimalsHead_QuantityActUnits.l(Regions,"Horses","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Horses","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Pferde","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/0.1455;

*Sheep and Goats are converted differently in AT and CH, it seems - this may relate to the herd structure regarding young animals (that come without GVE as they are suckled) vs mature animals
*to be checked - but for now we just convert such as to get correct animal numbers when compared to the GHG inventories.
*****Schafe
VActAnimalsHead_QuantityActUnits.l(Regions,"Sheep","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Sheep","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Schafe","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/0.06;
VActAnimalsHead_QuantityActUnits.l(Regions,"Sheep","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Sheep","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Schafe","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/0.144;

*****Ziegen
VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Ziegen","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/0.113;
VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Goats","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Ziegen","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/0.062;

*"Übrige Raufutter verzehrende Tiere"
*****Schweine
*this seems to cover the number of pigs that come with GVE only, thus not the weaners and sucklers! - Thus, do not use this number to derive manure excretion, etc., but rather sum over the herd types !!!!
*adjust GVE values to meet total numbers as reported in the GHG-inventory
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Schweine","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/0.093;
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Schweine","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/0.0861;

*****Zuchtschweine
*assume the categories Zuchtschweine covers Sows, Boars, Rep_Sows, Rep_Boars;
*thus divide this GB category by 4 to assign to the SOLm categories:
*TO BE IMPROVED LATER - by using relative shares of these categories in the calculated herd structure for Switzerland                                                                                                                             \
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Sows",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Sows",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Zuchtschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/4;
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Rep_Sows",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Rep_Sows",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Zuchtschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/4;
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Boars",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Boars",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Zuchtschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/4;
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Rep_Boars",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Rep_Boars",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Zuchtschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"))/4;

*for Austria:
*The shares below are taken from "Daten und Fakten der AgrarMarkt Austria für den Bereich Vieh und Fleisch" 240_vz_schweine_AT.pdf
*https://www.ama.at/Marktinformationen/Vieh-und-Fleisch/Produktion (access 3.4.2020)
*part of the Zuchtschweine are assigned to Weaners:
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Sows",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Sows",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Zuchtschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*0.35;
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Rep_Sows",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Rep_Sows",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Zuchtschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*0.08;
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Boars",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Boars",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Zuchtschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*0.005;
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Rep_Boars",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Rep_Boars",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Zuchtschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*0.005;
*according to the AT GHG inventory, there are less pigs of the age of the categories above (>50kg) and some more that are smaller - thus assign those to weaners and reduce above:
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Weaners",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Weaners",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Zuchtschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*0.56;


*****Mastschweine
*assume the categories Mastschweine covers Fatteners;
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Fatteners",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Fatteners",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Mastschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"));

VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Fatteners",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Fatteners",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Mastschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"));

*****"Abgesetzte Ferkel"
*assume the categories abgesetzte Ferkel covers Weaners and Sucklers; Sucklers is clearly not "abgesetzt", but it does not fit elsewhere;
*thus divide this GB category by 2 to assign to the SOLm categories:
*"abgesetze Ferkel" is in GVE only, we used a conversion factor of 0.06 for GVE per head of those and apply it to Sucklers and Weaners
*        based on 910.91_GVE definitions.pdf
*        currently we set GVE of those =0 though, to be consistent with the other GB data reported by Simon
*for really seeing how many animals there are and in particular for correct manure quantities based on those, we then again can leave away this factor 0
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Weaners",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Weaners",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Abgesetzte Ferkel","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/2/0.06;
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Sucklers",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Sucklers",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Abgesetzte Ferkel","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/2/0.06;

*the following is empty for AT:
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Weaners",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Weaners",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Abgesetzte Ferkel","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/2/0.06;
*the following is empty for AT:
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Sucklers",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Sucklers",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Abgesetzte Ferkel","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/2/0.06;

*as for producing meat cattle, we have to use a factor to derive the correct number of producing meat pigs, as there are several cycles per year; when taking the number Mastschweine only, we arrive at 511'000   \
*heads of animals, FAOSTAT reports 2721000 on average for 2012, 2013 - thus use a factor 272100/51100= 5.325;
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Meat producing",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Meat producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Mastschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*5.325;
VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Meat producing",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Pigs","Meat producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Mastschweine","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*5.325;

*****"Geflügel"
*I changed GVE units to meet animal numbers from FAOSTAT or GHG Inventory, respectively
VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Geflügel","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/0.00466;

VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Living",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Living",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Geflügel","GVE",ProdSystems_CH_AT,"AverageBasisYear"))/0.003417;

*as for cattle and pig, meat chickens are slaughtered several times a year, therefor just taking the number of Mastgeflügel underestimates the true value of producing animals,
*using this, we have 5972000 animals, FAOSTAT reports on average for 2012, 2013 60200000, thus multiply the number here with 60200000/5972000=10.08
VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Meat producing",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Meat producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Mastgeflügel","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*10.08;

VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Meat producing",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Meat producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Mastgeflügel","Stück",ProdSystems_CH_AT,"AverageBasisYear"))*10.08;

*no such factor needed for laying hens as they live the whole year
VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Egg producing",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Egg producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Legehennen","Stück",ProdSystems_CH_AT,"AverageBasisYear"));

VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Egg producing",ProductionSystems,"AllProdCond")
                 $(NOT VActAnimalsHead_QuantityActUnits.l(Regions,"Chickens","Egg producing",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 ATData_AnimalsTotals("Legehennen","Stück",ProdSystems_CH_AT,"AverageBasisYear"));

*"Raufutter verzehrende Tiere"
*"Davon: Rindvieh"
*Tierbesatz
*"Hauptfutterfläche je RGVE"
*"Fläche je Arbeitskraft"
*****Milchleistung: Assigned further down, after general parameter assignements
*File in new data on MILK YIELD
* division by 1000, as yield in GB is in kg
ActAnimalsHead_Outputs(Regions,"Cattle","Milk producing","Milk (t)",ProductionSystems,"AllProdCond")
                 $(NOT ActAnimalsHead_Outputs(Regions,"Cattle","Milk producing","Milk (t)",ProductionSystems,"AllProdCond"))
         = Sum(ProdSystems_CH_AT$Match_ProdSystemsRegions_CH_AT(ProdSystems_CH_AT,ProductionSystems,Regions),
                 GB2014_AnimalsTotals("Milchleistung","kg/Kuh",ProdSystems_CH_AT,"AverageBasisYear"))/1000;

*"Weizen Naturalertrag"

*drop the AllPRodSyst data for AT, as it is rebult afterwords as the sum of conv + org - not dropping it leads to some slight inconsistency in the sums, likely related to the temporal average.
VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
         = 0;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
         = 0;

*derive AllProdSyst = Conv + Org (to surely be consistent) and the organic/convent shares:
VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,Activities,AnimalTypeInHerd,"Convent","AllProdCond")
                 + VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,Activities,AnimalTypeInHerd,"Organic","AllProdCond");
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,Activities,AnimalTypeInHerd,"Convent","AllProdCond")
                 + VActAnimalsHead_QuantityActUnits.l(Regions_Austria,Activities,AnimalTypeInHerd,"Organic","AllProdCond");

ActAnimalsHead_OtherChar(Regions_Switzerland,Livestock,AnimalTypeInHerd,"share organic in total animals (share heads)","AllProdSyst","AllProdCond")
                 $VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,Livestock,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,Livestock,AnimalTypeInHerd,"Organic","AllProdCond")
                 /VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,Livestock,AnimalTypeInHerd,"AllProdSyst","AllProdCond");

ActAnimalsHead_OtherChar(Regions_Austria,Livestock,AnimalTypeInHerd,"share organic in total animals (share heads)","AllProdSyst","AllProdCond")
                 $VActAnimalsHead_QuantityActUnits.l(Regions_Austria,Livestock,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
         = VActAnimalsHead_QuantityActUnits.l(Regions_Austria,Livestock,AnimalTypeInHerd,"Organic","AllProdCond")
                 /VActAnimalsHead_QuantityActUnits.l(Regions_Austria,Livestock,AnimalTypeInHerd,"AllProdSyst","AllProdCond");

*drop the AllProdSyst again to only retain org/con for the new AT and CH data:
VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
         = 0;
VActAnimalsHead_QuantityActUnits.l(Regions_Austria,Activities,AnimalTypeInHerd,"AllProdSyst","AllProdCond")
         = 0;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Define further specific CH and AT sub-country values

*GE requirements:
*enteric fermentation values are too low for cattle - this is traced back to too low energy requirements, thus adjust them for Austria,
*using the values reported from the GHG inventory, 2019, table 169 (equalling animal categories as follows):
$ontext;
dairy     dairy
suckling  added to "older"
<1 year   Calves1
1-2 years Calves2 and 3
older     Bsires, Dsires, Bcows
$offtext;

*ActAnimalsHead_OtherChar("Austria","Cattle","Producing_Dairy_Cattle","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
*                 $ActAnimalsHead_OtherChar("Austria","Cattle","Producing_Dairy_Cattle","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
*         = *365;
ActAnimalsHead_OtherChar("Austria","Cattle","Dsires","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","Dsires","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 160*365;
ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 84*365;
ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 165*365;
ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves3","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves3","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 165*365;
ActAnimalsHead_OtherChar("Austria","Cattle","DMaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","DMaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 84*365;
ActAnimalsHead_OtherChar("Austria","Cattle","DMaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","DMaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 165*365;
ActAnimalsHead_OtherChar("Austria","Cattle","Bcows","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","Bcows","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 160*365;
ActAnimalsHead_OtherChar("Austria","Cattle","Bsires","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","Bsires","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 160*365;
ActAnimalsHead_OtherChar("Austria","Cattle","BFemaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","BFemaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 84*365;
ActAnimalsHead_OtherChar("Austria","Cattle","BFemaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","BFemaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 165*365;
ActAnimalsHead_OtherChar("Austria","Cattle","BMaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","BMaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 84*365;
ActAnimalsHead_OtherChar("Austria","Cattle","BMaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","BMaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 165*365;
ActAnimalsHead_OtherChar(Regions_Austria,"Cattle",AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = ActAnimalsHead_OtherChar("Austria","Cattle",AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions);

*also adjust cattle for Switzerland, Inventory 2019, table 5-6:
*equalling animal categories as follows:
$ontext;
mature dairy         Producing_dairy
Other mature         Bsires, Dsires, Bcows

Pre-Weaned Calves

Breeding Calves
Breeding Cattle (4-12 months)
Breeding Cattle (> 1 year)

Fattening Calves
Fattening Calves (0-4 months)
Fattening Cattle (4-12 months)
$offtext;

ActAnimalsHead_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Cattle","Producing_Dairy_Cattle","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 300*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","Dsires","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","Dsires","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 250*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","DFemaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","DFemaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 84*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","DFemaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","DFemaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 165*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","DFemaleCalves3","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","DFemaleCalves3","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 165*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","DMaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","DMaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 84*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","DMaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","DMaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 165*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","Bcows","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","Bcows","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 250*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","Bsires","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","Bsires","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 250*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","BFemaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","BFemaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 84*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","BFemaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","BFemaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 165*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","BMaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","BMaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 84*365;
ActAnimalsHead_OtherChar("Switzerland","Cattle","BMaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Cattle","BMaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 165*365;
ActAnimalsHead_OtherChar(Regions_Switzerland,"Cattle",AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = ActAnimalsHead_OtherChar("Switzerland","Cattle",AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions);



*also for chicken: Austria uses 1.8MJ/head/day, our default values are somewhat lower (1.72), thus adjust:
ActAnimalsHead_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 1.8*365;
ActAnimalsHead_OtherChar("Austria","Chickens","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Chickens","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 1.8*365;

*Chicken: CH uses 1.2MJ/head/day, our default values are somewhat higher (1.73), thus adjust:
ActAnimalsHead_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 1.2*365;
ActAnimalsHead_OtherChar("Switzerland","Chickens","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Chickens","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 1.2*365;


*GEreq per head for Goats/Sheep/Horses:
*adjust GE req per head according to GHG inventory: For CH as follows: Table 5-6 in the 2019 GHG inventory of CH:
ActAnimalsHead_OtherChar(Regions_Switzerland,"Sheep","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar(Regions_Switzerland,"Sheep","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 22.5*365;
ActAnimalsHead_OtherChar("Switzerland","Sheep","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Sheep","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 22.5*365;
ActAnimalsHead_OtherChar(Regions_Switzerland,"Goats","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar(Regions_Switzerland,"Goats","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 25*365;
ActAnimalsHead_OtherChar("Switzerland","Goats","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Goats","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 25*365;
ActAnimalsHead_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 108*365;
ActAnimalsHead_OtherChar("Switzerland","Horses","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Switzerland","Horses","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 108*365;
*GEreq per head for Goats/Sheep/Horses:
*for AT use same values as for CH:
*this DIFFERS from the inventory of AT, where they use Tier1 IPCC values for emission factors directly (Table 107 in the 2019 GHG inventory), which then correspond to different GE requirements (of only about 50% of the ones reported in CH)
*assuming that AT is similar to CH, we assume that this more detailed calculations are more correct
ActAnimalsHead_OtherChar(Regions_Austria,"Sheep","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar(Regions_Austria,"Sheep","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 22.5*365;
ActAnimalsHead_OtherChar("Austria","Sheep","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Sheep","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 22.5*365;
ActAnimalsHead_OtherChar(Regions_Austria,"Goats","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar(Regions_Austria,"Goats","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 25*365;
ActAnimalsHead_OtherChar("Austria","Goats","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Goats","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 25*365;
ActAnimalsHead_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 108*365;
ActAnimalsHead_OtherChar("Austria","Horses","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
                 $ActAnimalsHead_OtherChar("Austria","Horses","AllAndAverageTypes","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = 108*365;



$ontext;
ActAnimalsHead_OtherChar("Austria","Cattle","Producing_Dairy_Cattle","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = ActAnimalsHead_OtherChar("Austria","Cattle","Producing_Dairy_Cattle","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)*1.14;
ActAnimalsHead_OtherChar("Austria","Cattle","Dsires","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = ActAnimalsHead_OtherChar("Austria","Cattle","Dsires","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)*1.66;
ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)*1.66;
ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)*1.66;
ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves3","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = ActAnimalsHead_OtherChar("Austria","Cattle","DFemaleCalves3","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)*1.66;
ActAnimalsHead_OtherChar("Austria","Cattle","DMaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = ActAnimalsHead_OtherChar("Austria","Cattle","DMaleCalves1","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)*1.66;
ActAnimalsHead_OtherChar("Austria","Cattle","DMaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = ActAnimalsHead_OtherChar("Austria","Cattle","DMaleCalves2","FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)*1.66;
ActAnimalsHead_OtherChar("Austria","Cattle",BeefCattleTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)
         = ActAnimalsHead_OtherChar("Austria","Cattle",BeefCattleTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions)*1.66;
$offtext;


*nutrient contents; units: MJ/t for ME and t/t for XP, N and P2O5 PER UNIT DRY MATTER

Commod_Contents("Switzerland_Tal","Temporary meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 11000;
Commod_Contents("Switzerland_Huegel","Temporary meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 10500;
Commod_Contents("Switzerland_Berg","Temporary meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 10000;
Commod_Contents("Switzerland_Tal","Temporary meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 11000;
Commod_Contents("Switzerland_Huegel","Temporary meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 10500;
Commod_Contents("Switzerland_Berg","Temporary meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 10000;
Commod_Contents("Switzerland_Tal","Permanent meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 9500;
Commod_Contents("Switzerland_Huegel","Permanent meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 9500;
Commod_Contents("Switzerland_Berg","Permanent meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 9500;
Commod_Contents("Switzerland_Tal","Permanent meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 9500;
Commod_Contents("Switzerland_Huegel","Permanent meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 9500;
Commod_Contents("Switzerland_Berg","Permanent meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 9500;
Commod_Contents("Switzerland_Berg","alpine pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 7500;
Commod_Contents("Switzerland_Berg","alpine pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 7500;

*protein content, as provided in the files from Simon, data for SOLm
Commod_Contents("Switzerland_Tal","Temporary meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.15;
Commod_Contents("Switzerland_Huegel","Temporary meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.1475;
Commod_Contents("Switzerland_Berg","Temporary meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.14375;
Commod_Contents("Switzerland_Tal","Temporary meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.175;
Commod_Contents("Switzerland_Huegel","Temporary meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.16875;
Commod_Contents("Switzerland_Berg","Temporary meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.1625;
Commod_Contents("Switzerland_Tal","Permanent meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.14375;
Commod_Contents("Switzerland_Huegel","Permanent meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.14125;
Commod_Contents("Switzerland_Berg","Permanent meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.1375;
Commod_Contents("Switzerland_Tal","Permanent meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.1625;
Commod_Contents("Switzerland_Huegel","Permanent meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.15625;
Commod_Contents("Switzerland_Berg","Permanent meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.15;
Commod_Contents("Switzerland_Berg","alpine pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.1375;
Commod_Contents("Switzerland_Berg","alpine pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.1375;

*FOR AUSTRIA:
*nutrient contents; units: MJ/t for ME and t/t for XP
Commod_Contents(Regions_Austria_Tal,"Temporary meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 11000;
Commod_Contents(Regions_Austria_Huegel,"Temporary meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 10500;
Commod_Contents(Regions_Austria_Berg,"Temporary meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 10000;
Commod_Contents(Regions_Austria_Tal,"Temporary meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 11000;
Commod_Contents(Regions_Austria_Huegel,"Temporary meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 10500;
Commod_Contents(Regions_Austria_Berg,"Temporary meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 10000;
Commod_Contents(Regions_Austria_Tal,"Permanent meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 9500;
Commod_Contents(Regions_Austria_Huegel,"Permanent meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 9500;
Commod_Contents(Regions_Austria_Berg,"Permanent meadows and pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 9500;
Commod_Contents(Regions_Austria_Tal,"Permanent meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 9500;
Commod_Contents(Regions_Austria_Huegel,"Permanent meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 9500;
Commod_Contents(Regions_Austria_Berg,"Permanent meadows and pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 9500;
Commod_Contents(Regions_Austria_Berg,"alpine pastures","FeedME in DM (MJ)","Convent","AllProdCond") = 7500;
Commod_Contents(Regions_Austria_Berg,"alpine pastures","FeedME in DM (MJ)","Organic","AllProdCond") = 7500;

*protein content, as provided in the files from Simon, data for SOLm
Commod_Contents(Regions_Austria_Tal,"Temporary meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.15;
Commod_Contents(Regions_Austria_Huegel,"Temporary meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.1475;
Commod_Contents(Regions_Austria_Berg,"Temporary meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.14375;
Commod_Contents(Regions_Austria_Tal,"Temporary meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.175;
Commod_Contents(Regions_Austria_Huegel,"Temporary meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.16875;
Commod_Contents(Regions_Austria_Berg,"Temporary meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.1625;
Commod_Contents(Regions_Austria_Tal,"Permanent meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.14375;
Commod_Contents(Regions_Austria_Huegel,"Permanent meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.14125;
Commod_Contents(Regions_Austria_Berg,"Permanent meadows and pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.1375;
Commod_Contents(Regions_Austria_Tal,"Permanent meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.1625;
Commod_Contents(Regions_Austria_Huegel,"Permanent meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.15625;
Commod_Contents(Regions_Austria_Berg,"Permanent meadows and pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.15;
Commod_Contents(Regions_Austria_Berg,"alpine pastures","FeedXP in DM (t)","Convent","AllProdCond") = 0.1375;
Commod_Contents(Regions_Austria_Berg,"alpine pastures","FeedXP in DM (t)","Organic","AllProdCond") = 0.1375;

Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","DM (t)",ProdSyst_OrgCon,"AllProdCond")
         = Commod_Contents("Switzerland","Temporary meadows and pastures","DM (t)","AllProdSyst","AllProdCond");
Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","DM (t)",ProdSyst_OrgCon,"AllProdCond")
         = Commod_Contents("Switzerland","Permanent meadows and pastures","DM (t)","AllProdSyst","AllProdCond");
Commod_Contents(Regions_Switzerland,"alpine pastures","DM (t)",ProdSyst_OrgCon,"AllProdCond")
         = Commod_Contents("Switzerland","Permanent meadows and pastures","DM (t)","AllProdSyst","AllProdCond");

Commod_Contents(Regions_Austria,"Temporary meadows and pastures","DM (t)",ProdSyst_OrgCon,"AllProdCond")
         = Commod_Contents("Austria","Temporary meadows and pastures","DM (t)","AllProdSyst","AllProdCond");
Commod_Contents(Regions_Austria,"Permanent meadows and pastures","DM (t)",ProdSyst_OrgCon,"AllProdCond")
         = Commod_Contents("Austria","Permanent meadows and pastures","DM (t)","AllProdSyst","AllProdCond");
Commod_Contents(Regions_Austria,"alpine pastures","DM (t)",ProdSyst_OrgCon,"AllProdCond")
         = Commod_Contents("Austria","Permanent meadows and pastures","DM (t)","AllProdSyst","AllProdCond");


*commodity ME and XP contents for perm and temp past and alpine past is per ton DM, thus assign per ton FM values as well:
Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","FeedME in DM (MJ)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","DM (t)",ProductionSystems,"AllProdCond");
Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","FeedME in DM (MJ)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","DM (t)",ProductionSystems,"AllProdCond");
Commod_Contents(Regions_Switzerland,"alpine pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Switzerland,"alpine pastures","FeedME in DM (MJ)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Switzerland,"alpine pastures","DM (t)",ProductionSystems,"AllProdCond");

Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","FeedXP (t)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","FeedXP in DM (t)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","DM (t)",ProductionSystems,"AllProdCond");
Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","FeedXP (t)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","FeedXP in DM (t)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","DM (t)",ProductionSystems,"AllProdCond");
Commod_Contents(Regions_Switzerland,"alpine pastures","FeedXP (t)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Switzerland,"alpine pastures","FeedXP in DM (t)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Switzerland,"alpine pastures","DM (t)",ProductionSystems,"AllProdCond");

Commod_Contents(Regions_Austria,"Temporary meadows and pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Austria,"Temporary meadows and pastures","FeedME in DM (MJ)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Austria,"Temporary meadows and pastures","DM (t)",ProductionSystems,"AllProdCond");
Commod_Contents(Regions_Austria,"Permanent meadows and pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Austria,"Permanent meadows and pastures","FeedME in DM (MJ)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Austria,"Permanent meadows and pastures","DM (t)",ProductionSystems,"AllProdCond");
Commod_Contents(Regions_Austria,"alpine pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Austria,"alpine pastures","FeedME in DM (MJ)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Austria,"alpine pastures","DM (t)",ProductionSystems,"AllProdCond");

Commod_Contents(Regions_Austria,"Temporary meadows and pastures","FeedXP (t)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Austria,"Temporary meadows and pastures","FeedXP in DM (t)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Austria,"Temporary meadows and pastures","DM (t)",ProductionSystems,"AllProdCond");
Commod_Contents(Regions_Austria,"Permanent meadows and pastures","FeedXP (t)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Austria,"Permanent meadows and pastures","FeedXP in DM (t)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Austria,"Permanent meadows and pastures","DM (t)",ProductionSystems,"AllProdCond");
Commod_Contents(Regions_Austria,"alpine pastures","FeedXP (t)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Austria,"alpine pastures","FeedXP in DM (t)",ProductionSystems,"AllProdCond")
                 *Commod_Contents(Regions_Austria,"alpine pastures","DM (t)",ProductionSystems,"AllProdCond");




$ontext;
alterantive calculation, results in quite high numbers, in particular if translated to N contents via N/0.16 = CP
*protein content, derived from share of legumes in the sward, according to: =(LegumeShare%*220)+((100%-LegumeShare%)*145); legume shares are indicated below;
Commod_Contents("Switzerland_Tal","Temporary meadows and pastures","FeedXP (t)","Convent","AllProdCond") = 0.16;
Commod_Contents("Switzerland_Huegel","Temporary meadows and pastures","FeedXP (t)","Convent","AllProdCond") = 0.1581;
Commod_Contents("Switzerland_Berg","Temporary meadows and pastures","FeedXP (t)","Convent","AllProdCond") = 0.1563;
Commod_Contents("Switzerland_Tal","Temporary meadows and pastures","FeedXP (t)","Organic","AllProdCond") = 0.175;
Commod_Contents("Switzerland_Huegel","Temporary meadows and pastures","FeedXP (t)","Organic","AllProdCond") = 0.1713;
Commod_Contents("Switzerland_Berg","Temporary meadows and pastures","FeedXP (t)","Organic","AllProdCond") = 0.1675;
Commod_Contents("Switzerland_Tal","Permanent meadows and pastures","FeedXP (t)","Convent","AllProdCond") = 0.1563;
Commod_Contents("Switzerland_Huegel","Permanent meadows and pastures","FeedXP (t)","Convent","AllProdCond") = 0.1544;
Commod_Contents("Switzerland_Berg","Permanent meadows and pastures","FeedXP (t)","Convent","AllProdCond") = 0.1525;
Commod_Contents("Switzerland_Tal","Permanent meadows and pastures","FeedXP (t)","Organic","AllProdCond") = 0.1675;
Commod_Contents("Switzerland_Huegel","Permanent meadows and pastures","FeedXP (t)","Organic","AllProdCond") = 0.1638;
Commod_Contents("Switzerland_Berg","Permanent meadows and pastures","FeedXP (t)","Organic","AllProdCond") = 0.16;
Commod_Contents("Switzerland_Berg","alpine pastures","FeedXP (t)","Convent","AllProdCond") = 0.1525;
Commod_Contents("Switzerland_Berg","alpine pastures","FeedXP (t)","Organic","AllProdCond") = 0.1525;
$offtext;

Commod_Contents(Regions_Switzerland,"Maize For Forage+Silage","FeedME (MJ)","Convent","AllProdCond") = 11000;
Commod_Contents(Regions_Switzerland,"Maize For Forage+Silage","FeedME (MJ)","Organic","AllProdCond") = 11000;
Commod_Contents(Regions_Austria,"Maize For Forage+Silage","FeedME (MJ)","Convent","AllProdCond") = 11000;
Commod_Contents(Regions_Austria,"Maize For Forage+Silage","FeedME (MJ)","Organic","AllProdCond") = 11000;

Commod_Contents(Regions_Switzerland,"Maize For Forage+Silage","FeedXP (t)","Convent","AllProdCond") = 0.09;
Commod_Contents(Regions_Switzerland,"Maize For Forage+Silage","FeedXP (t)","Organic","AllProdCond") = 0.09;
Commod_Contents(Regions_Austria,"Maize For Forage+Silage","FeedXP (t)","Convent","AllProdCond") = 0.09;
Commod_Contents(Regions_Austria,"Maize For Forage+Silage","FeedXP (t)","Organic","AllProdCond") = 0.09;


*and for some crops assign new N and P2O5 contents, based on Agrarforschung 16(2), 2009, p age 89 ff, Table 60a

*unit: shares, i.e. percentages/100, i.e. t N P2O5 / t fresh matter quantity
Commod_Contents(Regions_Switzerland,"Wheat","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.019;
Commod_Contents(Regions_Switzerland,"Wheat","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0082;
Commod_Contents(Regions_Switzerland,"Barley","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0148;
Commod_Contents(Regions_Switzerland,"Barley","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0084;
Commod_Contents(Regions_Switzerland,"Oats","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.016;
Commod_Contents(Regions_Switzerland,"Oats","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.008;
Commod_Contents(Regions_Switzerland,"Rye","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.013;
Commod_Contents(Regions_Switzerland,"Rye","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.008;
Commod_Contents(Regions_Switzerland,"Spelt","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.016;
Commod_Contents(Regions_Switzerland,"Spelt","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.008;
Commod_Contents(Regions_Switzerland,"Triticale","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.016;
Commod_Contents(Regions_Switzerland,"Triticale","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0072;
Commod_Contents(Regions_Switzerland,"Maize","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.013;
Commod_Contents(Regions_Switzerland,"Maize","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0059;
Commod_Contents(Regions_Switzerland,"Maize For Forage+Silage","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.00383;
*forage maize: take 0.00383 based on Alpenprojekt: divide production/XP *0.16 (assuming 16% N in XP).
Commod_Contents(Regions_Switzerland,"Maize For Forage+Silage","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0048;
Commod_Contents(Regions_Switzerland,"Potatoes","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.003;
Commod_Contents(Regions_Switzerland,"Potatoes","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0013;
Commod_Contents(Regions_Switzerland,"Sugar beet","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.00213;
*sugar beet: from Alpenprojekt: XP/quantity*0.16
Commod_Contents(Regions_Switzerland,"Sugar beet","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0006;
Commod_Contents(Regions_Switzerland,"Beets for Fodder","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.011;
Commod_Contents(Regions_Switzerland,"Beets for Fodder","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.005;
Commod_Contents(Regions_Switzerland,"Rapeseed","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.034;
Commod_Contents(Regions_Switzerland,"Rapeseed","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0146;
Commod_Contents(Regions_Switzerland,"Sunflower seed","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.035;
Commod_Contents(Regions_Switzerland,"Sunflower seed","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.011;
Commod_Contents(Regions_Switzerland,"Linseed","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0545;
Commod_Contents(Regions_Switzerland,"Linseed","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.012;
Commod_Contents(Regions_Switzerland,"Lupins","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.035;
Commod_Contents(Regions_Switzerland,"Lupins","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.01;
Commod_Contents(Regions_Switzerland,"Broad beans, horse beans, dry","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.04;
Commod_Contents(Regions_Switzerland,"Broad beans, horse beans, dry","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.014;
Commod_Contents(Regions_Switzerland,"Soybeans","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.036;
Commod_Contents(Regions_Switzerland,"Soybeans","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0117;

Commod_Contents(Regions_Austria,"Wheat","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.019;
Commod_Contents(Regions_Austria,"Wheat","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0082;
Commod_Contents(Regions_Austria,"Barley","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0148;
Commod_Contents(Regions_Austria,"Barley","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0084;
Commod_Contents(Regions_Austria,"Oats","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.016;
Commod_Contents(Regions_Austria,"Oats","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.008;
Commod_Contents(Regions_Austria,"Rye","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.013;
Commod_Contents(Regions_Austria,"Rye","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.008;
Commod_Contents(Regions_Austria,"Spelt","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.016;
Commod_Contents(Regions_Austria,"Spelt","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.008;
Commod_Contents(Regions_Austria,"Triticale","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.016;
Commod_Contents(Regions_Austria,"Triticale","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0072;
Commod_Contents(Regions_Austria,"Maize","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.013;
Commod_Contents(Regions_Austria,"Maize","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0059;
Commod_Contents(Regions_Austria,"Maize For Forage+Silage","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.00383;
*forage maize: take 0.00383 based on Alpenprojekt: divide production/XP *0.16 (assuming 16% N in XP).
Commod_Contents(Regions_Austria,"Maize For Forage+Silage","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0048;
Commod_Contents(Regions_Austria,"Potatoes","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.003;
Commod_Contents(Regions_Austria,"Potatoes","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0013;
Commod_Contents(Regions_Austria,"Sugar beet","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.00213;
*sugar beet: from Alpenprojekt: XP/quantity*0.16
Commod_Contents(Regions_Austria,"Sugar beet","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0006;
Commod_Contents(Regions_Austria,"Beets for Fodder","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.011;
Commod_Contents(Regions_Austria,"Beets for Fodder","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.005;
Commod_Contents(Regions_Austria,"Rapeseed","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.034;
Commod_Contents(Regions_Austria,"Rapeseed","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0146;
Commod_Contents(Regions_Austria,"Sunflower seed","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.035;
Commod_Contents(Regions_Austria,"Sunflower seed","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.011;
Commod_Contents(Regions_Austria,"Linseed","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0545;
Commod_Contents(Regions_Austria,"Linseed","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.012;
Commod_Contents(Regions_Austria,"Lupins","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.035;
Commod_Contents(Regions_Austria,"Lupins","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.01;
Commod_Contents(Regions_Austria,"Broad beans, horse beans, dry","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.04;
Commod_Contents(Regions_Austria,"Broad beans, horse beans, dry","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.014;
Commod_Contents(Regions_Austria,"Soybeans","N (t)",ProdSyst_OrgCon,"AllProdCond") = 0.036;
Commod_Contents(Regions_Austria,"Soybeans","P2O5 (t)",ProdSyst_OrgCon,"AllProdCond") = 0.0117;



*values not used were suggested by Simon (ask him for the reference): from simon (T:15, H:20, B:25)
ActCropsGrass_Inputs("Switzerland_Tal",CropsAndCoreGrassActivities,"N deposition (tN)",ProdSyst_OrgCon,"AllProdCond")
*         = 0.015;
         = 0.03;
ActCropsGrass_Inputs("Switzerland_Huegel",CropsAndCoreGrassActivities,"N deposition (tN)",ProdSyst_OrgCon,"AllProdCond")
         = 0.02;
ActCropsGrass_Inputs("Switzerland_Berg",CropsAndCoreGrassActivities,"N deposition (tN)",ProdSyst_OrgCon,"AllProdCond")
*         = 0.025;
         = 0.012;

*for Austria:
ActCropsGrass_Inputs(Regions_Austria_Tal,CropsAndCoreGrassActivities,"N deposition (tN)",ProdSyst_OrgCon,"AllProdCond")
*         = 0.015;
         = 0.03;
ActCropsGrass_Inputs(Regions_Austria_Huegel,CropsAndCoreGrassActivities,"N deposition (tN)",ProdSyst_OrgCon,"AllProdCond")
         = 0.02;
ActCropsGrass_Inputs(Regions_Austria_Berg,CropsAndCoreGrassActivities,"N deposition (tN)",ProdSyst_OrgCon,"AllProdCond")
*         = 0.025;
         = 0.012;
*improve AT values for N deposit

*data on N deposition in CH:
*Bericht_Agrammon_20130530.pdf
*NH3_Bericht_2012.pdf
*and, in particular:
*Stickstoffhaltige+Luftschadstoffe+in+der+Schweiz.pdf
*        page 9: 60% from NH3 and NOx stem from agriculture
*Stickstoffflüsse in der Schweiz. Stoffflussanalyse für das Jahr 2005.pdf
*        Tab 17, tot. deposit 69 ktN
*currently, the model reports about 39.5 ktN for N_FromNDeposition_FromManMan, which is Nindirect_Volat_ManMan, i.e. NH3 and NOX from manure management that is later deposited
*thus, if this is 60% of all that is deposited, then this total is 39.5/0.6 = 66 ktN - which is well in line with the reported total value for CH

*with the values for per ha deposition assigned above, we get a total of 25.5 ktN deposited on agricultural land (total crop plus grassland: 1'276'799 ha)
*                for the option derived from Abb 4 in Stickstoffflüsse in der Schweiz. Stoffflussanalyse für das Jahr 2005.pdf: T: 30, H: 20, B: 12)                          ;
*        this is somewhat less than the 27ktN reported in tab 12, p 72, in Stickstoffflüsse in der Schweiz. Stoffflussanalyse für das Jahr 2005.pdf
*distributing the 70kt on 41200 km2 total Swiss area gives 16.7 kg N/ha from deposition
*distributing 25.5kt to agricultural land 1276799 ha results in about 20kgN/ha.
*check also why the values from Simon and from Abb 4 mentioned above are correlated negatively for the three zones!!!????

*another reference on deposition in Switzerland, to be checked: http://www.bafu.admin.ch/luft/luftbelastung/schadstoffkarten/stickstoff-deposition/index.html?lang=de


*assumption: pure legume sward: fixation of 250kgN/ha (Tal), 200kgN/ha (Huegel), 150kgN/ha (Berg)
ActCropsGrass_Inputs("Switzerland_Tal","Pure legume sward","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond") = 0.25;
ActCropsGrass_Inputs("Switzerland_Huegel","Pure legume sward","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond") = 0.2;
ActCropsGrass_Inputs("Switzerland_Berg","Pure legume sward","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond") = 0.15;
*pure legume sward in alpine pastures: maybe 250??? - we also tried such high numbers, I think - but too high, isn't it?

ActCropsGrass_Inputs(Regions_Austria_Tal,"Pure legume sward","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond") = 0.25;
ActCropsGrass_Inputs(Regions_Austria_Huegel,"Pure legume sward","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond") = 0.2;
ActCropsGrass_Inputs(Regions_Austria_Berg,"Pure legume sward","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond") = 0.15;


*assumption: legume shares in the different grasslands and regions:
*grassland: it is all in DM yields!!!
*For Switzerland:
ActCropsGrass_OtherChar("Switzerland_Tal","Temporary meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.2;
ActCropsGrass_OtherChar("Switzerland_Huegel","Temporary meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")  = 0.18;
ActCropsGrass_OtherChar("Switzerland_Berg","Temporary meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.15;
ActCropsGrass_OtherChar("Switzerland_Tal","Temporary meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.4;
ActCropsGrass_OtherChar("Switzerland_Huegel","Temporary meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")  = 0.35;
ActCropsGrass_OtherChar("Switzerland_Berg","Temporary meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.3;

ActCropsGrass_OtherChar("Switzerland_Tal","Permanent meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.15;
ActCropsGrass_OtherChar("Switzerland_Huegel","Permanent meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")  = 0.13;
ActCropsGrass_OtherChar("Switzerland_Berg","Permanent meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.1;
ActCropsGrass_OtherChar("Switzerland_Tal","Permanent meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.3;
ActCropsGrass_OtherChar("Switzerland_Huegel","Permanent meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")  = 0.25;
ActCropsGrass_OtherChar("Switzerland_Berg","Permanent meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.2;

ActCropsGrass_OtherChar("Switzerland_Berg","alpine pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.1;
ActCropsGrass_OtherChar("Switzerland_Berg","alpine pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.1;

*For Austria:
ActCropsGrass_OtherChar(Regions_Austria_Tal,"Temporary meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.2;
ActCropsGrass_OtherChar(Regions_Austria_Huegel,"Temporary meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")  = 0.18;
ActCropsGrass_OtherChar(Regions_Austria_Berg,"Temporary meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.15;
ActCropsGrass_OtherChar(Regions_Austria_Tal,"Temporary meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.4;
ActCropsGrass_OtherChar(Regions_Austria_Huegel,"Temporary meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")  = 0.35;
ActCropsGrass_OtherChar(Regions_Austria_Berg,"Temporary meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.3;

ActCropsGrass_OtherChar(Regions_Austria_Tal,"Permanent meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.15;
ActCropsGrass_OtherChar(Regions_Austria_Huegel,"Permanent meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")  = 0.13;
ActCropsGrass_OtherChar(Regions_Austria_Berg,"Permanent meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.1;
ActCropsGrass_OtherChar(Regions_Austria_Tal,"Permanent meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.3;
ActCropsGrass_OtherChar(Regions_Austria_Huegel,"Permanent meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")  = 0.25;
ActCropsGrass_OtherChar(Regions_Austria_Berg,"Permanent meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.2;

ActCropsGrass_OtherChar(Regions_Austria_Berg,"alpine pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.1;
ActCropsGrass_OtherChar(Regions_Austria_Berg,"alpine pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.1;



*now derive the fixation per t yield based on shares of legumes in grasslands and fixation per ha pure legume sward:
ActCropsGrass_OtherChar(Regions_Switzerland,CoreGrassActivities,"N fixation per ton MainOutput1 (tN)",ProdSyst_OrgCon,"AllProdCond")
                         $ActCropsGrass_Outputs(Regions_Switzerland,CoreGrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond")
         = (ActCropsGrass_Inputs(Regions_Switzerland,"Pure legume sward","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond")
                 *ActCropsGrass_OtherChar(Regions_Switzerland,"Permanent meadows and pastures","Legumes in grasslands (ha)",ProdSyst_OrgCon,"AllProdCond"))
                         /ActCropsGrass_Outputs(Regions_Switzerland,CoreGrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond");

ActCropsGrass_OtherChar(Regions_Austria,CoreGrassActivities,"N fixation per ton MainOutput1 (tN)",ProdSyst_OrgCon,"AllProdCond")
                         $ActCropsGrass_Outputs(Regions_Austria,CoreGrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond")
         = (ActCropsGrass_Inputs(Regions_Austria,"Pure legume sward","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond")
                 *ActCropsGrass_OtherChar(Regions_Austria,"Permanent meadows and pastures","Legumes in grasslands (ha)",ProdSyst_OrgCon,"AllProdCond"))
                         /ActCropsGrass_Outputs(Regions_Austria,CoreGrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond");

*and derive the values per ha:
*specific, as it is for grasslands only: convert to per ha via DM yields:
ActCropsGrass_Inputs(Regions_Switzerland,CoreGrassActivities,"N fixation (tN)",ProdSyst_OrgCon,"AllProdCond")
         = ActCropsGrass_OtherChar(Regions_Switzerland,CoreGrassActivities,"N fixation per ton MainOutput1 (tN)",ProdSyst_OrgCon,"AllProdCond")
                 *ActCropsGrass_Outputs(Regions_Switzerland,CoreGrassActivities,"MainOutput1 (t)",ProdSyst_OrgCon,"AllProdCond");

$ontext;
the following implements fixation values that lead to 34kt fixation for the whole of CH - but they result in too high N contents of grass, thus we reduced the legume shares agains to the old values
but retained the higher new fixation rates - this is then clalculated in the code just above
*assumption: pure legume sward: fixation of 250kgN/ha (Tal), 200kgN/ha (Huegel), 150kgN/ha (Berg)
ActCropsGrass_Inputs("Switzerland_Tal","Pure legume sward","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond") = 0.2;
ActCropsGrass_Inputs("Switzerland_Huegel","Pure legume sward","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond") = 0.15;
ActCropsGrass_Inputs("Switzerland_Berg","Pure legume sward","N fixation (tN)",ProdSyst_OrgCon,"AllProdCond") = 0.1;

*assumption: legume shares in the different grasslands and regions:
ActCropsGrass_OtherChar("Switzerland_Tal","Temporary meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.25;
ActCropsGrass_OtherChar("Switzerland_Huegel","Temporary meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")  = 0.225;
ActCropsGrass_OtherChar("Switzerland_Berg","Temporary meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.2;
ActCropsGrass_OtherChar("Switzerland_Tal","Temporary meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.5;
ActCropsGrass_OtherChar("Switzerland_Huegel","Temporary meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")  = 0.4;
ActCropsGrass_OtherChar("Switzerland_Berg","Temporary meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.35;

ActCropsGrass_OtherChar("Switzerland_Tal","Permanent meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.175;
ActCropsGrass_OtherChar("Switzerland_Huegel","Permanent meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")  = 0.15;
ActCropsGrass_OtherChar("Switzerland_Berg","Permanent meadows and pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.125;
ActCropsGrass_OtherChar("Switzerland_Tal","Permanent meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.3;
ActCropsGrass_OtherChar("Switzerland_Huegel","Permanent meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")  = 0.25;
ActCropsGrass_OtherChar("Switzerland_Berg","Permanent meadows and pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.2;

ActCropsGrass_OtherChar("Switzerland_Berg","alpine pastures","Legumes in grasslands (ha)","Convent","AllProdCond")    = 0.1;
ActCropsGrass_OtherChar("Switzerland_Berg","alpine pastures","Legumes in grasslands (ha)","Organic","AllProdCond")    = 0.1;
$offtext;


*unit: km/day/head
ActAnimalsHead_OtherChar("Switzerland_Tal","Cattle","Producing_Dairy_Cattle","DailyWalkingDistance (km)",ProdSyst_OrgCon,"AllProdCond") = 2;
ActAnimalsHead_OtherChar("Switzerland_Huegel","Cattle","Producing_Dairy_Cattle","DailyWalkingDistance (km)",ProdSyst_OrgCon,"AllProdCond") = 3;
ActAnimalsHead_OtherChar("Switzerland_Berg","Cattle","Producing_Dairy_Cattle","DailyWalkingDistance (km)",ProdSyst_OrgCon,"AllProdCond") = 6;
*unit: days
ActAnimalsHead_OtherChar("Switzerland_Tal","Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProdSyst_OrgCon,"AllProdCond") = 210;
ActAnimalsHead_OtherChar("Switzerland_Huegel","Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProdSyst_OrgCon,"AllProdCond") = 195;
ActAnimalsHead_OtherChar("Switzerland_Berg","Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProdSyst_OrgCon,"AllProdCond") = 180;

*unit: km/day/head
ActAnimalsHead_OtherChar(Regions_Austria_Tal,"Cattle","Producing_Dairy_Cattle","DailyWalkingDistance (km)",ProdSyst_OrgCon,"AllProdCond") = 2;
ActAnimalsHead_OtherChar(Regions_Austria_Huegel,"Cattle","Producing_Dairy_Cattle","DailyWalkingDistance (km)",ProdSyst_OrgCon,"AllProdCond") = 3;
ActAnimalsHead_OtherChar(Regions_Austria_Berg,"Cattle","Producing_Dairy_Cattle","DailyWalkingDistance (km)",ProdSyst_OrgCon,"AllProdCond") = 6;
*unit: days
ActAnimalsHead_OtherChar(Regions_Austria_Tal,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProdSyst_OrgCon,"AllProdCond") = 210;
ActAnimalsHead_OtherChar(Regions_Austria_Huegel,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProdSyst_OrgCon,"AllProdCond") = 195;
ActAnimalsHead_OtherChar(Regions_Austria_Berg,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)",ProdSyst_OrgCon,"AllProdCond") = 180;

*The global baseline on quantity shares for crop man systems is for "All" production systems only
*Thus assign specifiv org/con values here:

CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Composting","Convent","AllProdCond") = 0;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Left on croplands","Convent","AllProdCond") = 0.9;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Biogas","Convent","AllProdCond") = 0;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Open burning","Convent","AllProdCond") = 0.1;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Cooking","Convent","AllProdCond") = 0;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Feed","Convent","AllProdCond") = 0;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Dumped","Convent","AllProdCond") = 0;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Livestock bedding","Convent","AllProdCond") = 0;

CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Composting","Organic","AllProdCond") = 0.5;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond") = 0.5;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Biogas","Organic","AllProdCond") = 0;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Open burning","Organic","AllProdCond") = 0;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Cooking","Organic","AllProdCond") = 0;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Feed","Organic","AllProdCond") = 0;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Dumped","Organic","AllProdCond") = 0;
CropResidues_Management(Regions_Switzerland,Crops,"Average Residues (t)","Quantity share in CropResMan system","Livestock bedding","Organic","AllProdCond") = 0;

*FOR AUSTRIA:
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Composting","Convent","AllProdCond") = 0;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Left on croplands","Convent","AllProdCond") = 0.9;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Biogas","Convent","AllProdCond") = 0;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Open burning","Convent","AllProdCond") = 0.1;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Cooking","Convent","AllProdCond") = 0;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Feed","Convent","AllProdCond") = 0;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Dumped","Convent","AllProdCond") = 0;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Livestock bedding","Convent","AllProdCond") = 0;

CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Composting","Organic","AllProdCond") = 0.5;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond") = 0.5;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Biogas","Organic","AllProdCond") = 0;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Open burning","Organic","AllProdCond") = 0;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Cooking","Organic","AllProdCond") = 0;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Feed","Organic","AllProdCond") = 0;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Dumped","Organic","AllProdCond") = 0;
CropResidues_Management(Regions_Austria,Crops,"Average Residues (t)","Quantity share in CropResMan system","Livestock bedding","Organic","AllProdCond") = 0;


*assign new quantity shares more adequate for Swiss subregions (to be improved with Simon):
Manure_Management("Switzerland_Tal","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Liquid/Slurry with natural crust cover","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.2;
Manure_Management("Switzerland_Tal","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Solid Storage","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.2;
Manure_Management("Switzerland_Tal","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.6;
Manure_Management("Switzerland_Tal","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Daily Spread","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0;

Manure_Management("Switzerland_Huegel","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Liquid/Slurry with natural crust cover","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.1;
Manure_Management("Switzerland_Huegel","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Solid Storage","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.1;
Manure_Management("Switzerland_Huegel","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.8;
Manure_Management("Switzerland_Huegel","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Daily Spread","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0;

Manure_Management("Switzerland_Berg","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Liquid/Slurry with natural crust cover","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.0005;
Manure_Management("Switzerland_Berg","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Solid Storage","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.0005;
Manure_Management("Switzerland_Berg","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.999;
Manure_Management("Switzerland_Berg","Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Daily Spread","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0;

*FOR AUSTRIA:
$ontext;
Manure_Management(Regions_Austria_Tal,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Liquid/Slurry with natural crust cover","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.2;
Manure_Management(Regions_Austria_Tal,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Solid Storage","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.2;
Manure_Management(Regions_Austria_Tal,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.6;
Manure_Management(Regions_Austria_Tal,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Daily Spread","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0;

Manure_Management(Regions_Austria_Huegel,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Liquid/Slurry with natural crust cover","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.1;
Manure_Management(Regions_Austria_Huegel,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Solid Storage","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.1;
Manure_Management(Regions_Austria_Huegel,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.8;
Manure_Management(Regions_Austria_Huegel,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Daily Spread","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0;

Manure_Management(Regions_Austria_Berg,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Liquid/Slurry with natural crust cover","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.0005;
Manure_Management(Regions_Austria_Berg,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Solid Storage","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.0005;
Manure_Management(Regions_Austria_Berg,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0.999;
Manure_Management(Regions_Austria_Berg,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Daily Spread","AllAndAverageTemp",ProdSyst_OrgCon,"AllProdCond") = 0;
$offtext;

*manure management systems: default for AUSTRIA is different than our IPCC 2006 default data and the data above; thus replace with better data from the GHG-inventory 2019, tables 174 and 175:
Parameter ManMan_QuantityShares_Austria(Regions,Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem) values related to manure management IN AUSTRIA - UNIT: units management values per t manure TS DM if not indicated otherwise;

$call GDXXRW ManureManagementData_Austria.xlsx  o=ManManData_Austria.gdx  index=index!a1

$GDXIN ManManData_Austria.gdx
$load ManMan_QuantityShares_Austria
$GDXIN ManManData_Austria.gdx

*remove data for the animals to be improved, then add new data:
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions) = 0;
Manure_Management("Austria",Activities,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
         = ManMan_QuantityShares_Austria("Austria",Activities,AnimalTypeInHerd,Temperatures,ProductionSystems,ProductionConditions,ManureManSystem);

Manure_Management("Austria","Cattle",AnimalTypeInHerd,"MCF: CH4 conversion factor (%)","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
                 $Manure_Management("Austria","Cattle",AnimalTypeInHerd,"Quantity share in ManureMan system","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
         = 8.1;
Manure_Management("Austria","Cattle","Producing_Dairy_Cattle","MCF: CH4 conversion factor (%)","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
                 $Manure_Management("Austria","Cattle","Producing_Dairy_Cattle","Quantity share in ManureMan system","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
         = 8.8;
Manure_Management("Austria","Pigs",AnimalTypeInHerd,"MCF: CH4 conversion factor (%)","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
                 $Manure_Management("Austria","Pigs",AnimalTypeInHerd,"Quantity share in ManureMan system","Liquid/Slurry without natural crust cover",Temperatures,ProductionSystems,ProductionConditions)
         = 3.4;

*Ash contents from GHG inventory, some averaged values from cattle types:
Manure_OtherChar("Austria","Cattle",CattleTypeInHerd,"Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.115;


*file in some new system-specific yield data

ActCropsGrass_Outputs("Switzerland_Tal","Maize For Forage+Silage","MainOutput1 (t)","Convent","AllProdCond") = 44.7;
ActCropsGrass_Outputs("Switzerland_Huegel","Maize For Forage+Silage","MainOutput1 (t)","Convent","AllProdCond") = 42;
ActCropsGrass_Outputs("Switzerland_Berg","Maize For Forage+Silage","MainOutput1 (t)","Convent","AllProdCond") = 39.4;
ActCropsGrass_Outputs("Switzerland_Tal","Maize For Forage+Silage","MainOutput1 (t)","Organic","AllProdCond") = 30;
ActCropsGrass_Outputs("Switzerland_Huegel","Maize For Forage+Silage","MainOutput1 (t)","Organic","AllProdCond") = 28.2;
ActCropsGrass_Outputs("Switzerland_Berg","Maize For Forage+Silage","MainOutput1 (t)","Organic","AllProdCond") = 26.4;

ActCropsGrass_Outputs("Switzerland_Tal","Temporary meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 10.61;
ActCropsGrass_Outputs("Switzerland_Huegel","Temporary meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 10.09;
ActCropsGrass_Outputs("Switzerland_Berg","Temporary meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 8.19;
ActCropsGrass_Outputs("Switzerland_Tal","Temporary meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 9.02;
ActCropsGrass_Outputs("Switzerland_Huegel","Temporary meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 8.58;
ActCropsGrass_Outputs("Switzerland_Berg","Temporary meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 6.96;
ActCropsGrass_Outputs("Switzerland_Tal","Permanent meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 6.16;
ActCropsGrass_Outputs("Switzerland_Huegel","Permanent meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 5.86;
ActCropsGrass_Outputs("Switzerland_Berg","Permanent meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 4.67;
ActCropsGrass_Outputs("Switzerland_Tal","Permanent meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 5.55;
ActCropsGrass_Outputs("Switzerland_Huegel","Permanent meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 5.27;
ActCropsGrass_Outputs("Switzerland_Berg","Permanent meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 4.21;

ActCropsGrass_Outputs("Switzerland_Berg","alpine pastures","MainOutput1 (t)","Convent","AllProdCond") = 4;
ActCropsGrass_Outputs("Switzerland_Berg","alpine pastures","MainOutput1 (t)","Organic","AllProdCond") = 4;

*FOR AUSTRIA
ActCropsGrass_Outputs(Regions_Austria_Tal,"Maize For Forage+Silage","MainOutput1 (t)","Convent","AllProdCond") = 44.7;
ActCropsGrass_Outputs(Regions_Austria_Huegel,"Maize For Forage+Silage","MainOutput1 (t)","Convent","AllProdCond") = 42;
ActCropsGrass_Outputs(Regions_Austria_Berg,"Maize For Forage+Silage","MainOutput1 (t)","Convent","AllProdCond") = 39.4;
ActCropsGrass_Outputs(Regions_Austria_Tal,"Maize For Forage+Silage","MainOutput1 (t)","Organic","AllProdCond") = 30;
ActCropsGrass_Outputs(Regions_Austria_Huegel,"Maize For Forage+Silage","MainOutput1 (t)","Organic","AllProdCond") = 28.2;
ActCropsGrass_Outputs(Regions_Austria_Berg,"Maize For Forage+Silage","MainOutput1 (t)","Organic","AllProdCond") = 26.4;

ActCropsGrass_Outputs(Regions_Austria_Tal,"Temporary meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 10.61;
ActCropsGrass_Outputs(Regions_Austria_Huegel,"Temporary meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 10.09;
ActCropsGrass_Outputs(Regions_Austria_Berg,"Temporary meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 8.19;
ActCropsGrass_Outputs(Regions_Austria_Tal,"Temporary meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 9.02;
ActCropsGrass_Outputs(Regions_Austria_Huegel,"Temporary meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 8.58;
ActCropsGrass_Outputs(Regions_Austria_Berg,"Temporary meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 6.96;
ActCropsGrass_Outputs(Regions_Austria_Tal,"Permanent meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 6.16;
ActCropsGrass_Outputs(Regions_Austria_Huegel,"Permanent meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 5.86;
ActCropsGrass_Outputs(Regions_Austria_Berg,"Permanent meadows and pastures","MainOutput1 (t)","Convent","AllProdCond") = 4.67;
ActCropsGrass_Outputs(Regions_Austria_Tal,"Permanent meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 5.55;
ActCropsGrass_Outputs(Regions_Austria_Huegel,"Permanent meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 5.27;
ActCropsGrass_Outputs(Regions_Austria_Berg,"Permanent meadows and pastures","MainOutput1 (t)","Organic","AllProdCond") = 4.21;

ActCropsGrass_Outputs(Regions_Austria_Berg,"alpine pastures","MainOutput1 (t)","Convent","AllProdCond") = 4;
ActCropsGrass_Outputs(Regions_Austria_Berg,"alpine pastures","MainOutput1 (t)","Organic","AllProdCond") = 4;



*file in new Grassland data:
*ADD the alpine pastures simon added to the data to permanet grasslands in the mountain region:
*assume that they have 50% utilization only (with 100% supply is easily 100% too high)
VActCropsGrass_QuantityActUnits.l("Switzerland_Berg","alpine pastures","Organic","AllProdCond")
         = 87194;
VActCropsGrass_QuantityActUnits.l("Switzerland_Berg","alpine pastures","Convent","AllProdCond")
         = 224214;
*Alpine pastures areas for AT are read in with the excel sheets

VPopulationNumbers.l("Switzerland_Tal","PopulationAll")
         = 0.7*VPopulationNumbers.l("Switzerland","PopulationAll");
VPopulationNumbers.l("Switzerland_Huegel","PopulationAll")
         = 0.2*VPopulationNumbers.l("Switzerland","PopulationAll");
VPopulationNumbers.l("Switzerland_Berg","PopulationAll")
         = 0.1*VPopulationNumbers.l("Switzerland","PopulationAll");

*get correct data - for having it work: just base on the assumption of 0.7, 0.2 and 0.1 for Berg, Huegel and Tal as in CH - and divide equally between regions in these categories
*but as only one region is Huegel - assign 0.1 there and 0.2 to Berg.
VPopulationNumbers.l(Regions_Austria_Tal,"PopulationAll")
         = 0.7*(1/4)*VPopulationNumbers.l("Austria","PopulationAll");
VPopulationNumbers.l(Regions_Austria_Huegel,"PopulationAll")
         = 0.1*VPopulationNumbers.l("Austria","PopulationAll");
VPopulationNumbers.l(Regions_Austria_Berg,"PopulationAll")
         = 0.2*(1/3)*VPopulationNumbers.l("Austria","PopulationAll");

*min fert quantities, take from Eurostat:
VMineralFertilizerQuantity.l("Switzerland","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")
         = 55000;
*2.29157 is the conversion from P to P2O5, 4500 t from Eurostat is in P
VMineralFertilizerQuantity.l("Switzerland","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")
         = 4500*2.29157;

*min fert quantities, take from Eurostat:
VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")
         = 113361;
*2.29157 is the conversion from P to P2O5, 4500 t from Eurostat is in P
VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")
         = 13548*2.29157;

*allocate to subregions, according to economic allocation provided by Simon Moakes:
VMineralFertilizerQuantity.l("Switzerland_Tal","mineral P fert (P2O5)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Switzerland","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.63;
VMineralFertilizerQuantity.l("Switzerland_Huegel","mineral P fert (P2O5)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Switzerland","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.16;
VMineralFertilizerQuantity.l("Switzerland_Berg","mineral P fert (P2O5)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Switzerland","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.06;
VMineralFertilizerQuantity.l("Switzerland_Tal","mineral P fert (P2O5)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Switzerland","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.07;
VMineralFertilizerQuantity.l("Switzerland_Huegel","mineral P fert (P2O5)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Switzerland","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.04;
VMineralFertilizerQuantity.l("Switzerland_Berg","mineral P fert (P2O5)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Switzerland","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.04;

VMineralFertilizerQuantity.l("Switzerland_Tal","mineral N fert (N)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Switzerland","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0.74;
VMineralFertilizerQuantity.l("Switzerland_Huegel","mineral N fert (N)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Switzerland","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0.19;
VMineralFertilizerQuantity.l("Switzerland_Berg","mineral N fert (N)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Switzerland","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0.07;
VMineralFertilizerQuantity.l("Switzerland_Tal","mineral N fert (N)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Switzerland","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0;
VMineralFertilizerQuantity.l("Switzerland_Huegel","mineral N fert (N)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Switzerland","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0;
VMineralFertilizerQuantity.l("Switzerland_Berg","mineral N fert (N)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Switzerland","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0;

*Now assume same allocation for Austria as for CH - just to have something
VMineralFertilizerQuantity.l("Austria_Hochalpen","mineral P fert (P2O5)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.01;
VMineralFertilizerQuantity.l("Austria_Voralpen","mineral P fert (P2O5)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.00;
VMineralFertilizerQuantity.l("Austria_Alpenostrand","mineral P fert (P2O5)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.02;
VMineralFertilizerQuantity.l("Austria_WaldMuehlViertel","mineral P fert (P2O5)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.05;
VMineralFertilizerQuantity.l("Austria_KaerntnerBecken","mineral P fert (P2O5)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.03;
VMineralFertilizerQuantity.l("Austria_Alpenvorland","mineral P fert (P2O5)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.15;
VMineralFertilizerQuantity.l("Austria_SuedoestlFlachHuegelland","mineral P fert (P2O5)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.09;
VMineralFertilizerQuantity.l("Austria_NordoestlFlachHuegelland","mineral P fert (P2O5)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.21;

VMineralFertilizerQuantity.l("Austria_Hochalpen","mineral P fert (P2O5)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.05;
VMineralFertilizerQuantity.l("Austria_Voralpen","mineral P fert (P2O5)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.02;
VMineralFertilizerQuantity.l("Austria_Alpenostrand","mineral P fert (P2O5)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.07;
VMineralFertilizerQuantity.l("Austria_WaldMuehlViertel","mineral P fert (P2O5)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.14;
VMineralFertilizerQuantity.l("Austria_KaerntnerBecken","mineral P fert (P2O5)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.02;
VMineralFertilizerQuantity.l("Austria_Alpenvorland","mineral P fert (P2O5)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.05;
VMineralFertilizerQuantity.l("Austria_SuedoestlFlachHuegelland","mineral P fert (P2O5)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.03;
VMineralFertilizerQuantity.l("Austria_NordoestlFlachHuegelland","mineral P fert (P2O5)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral P fert (P2O5)","AllMinFertProdTech","AllProdSyst")*0.07;


VMineralFertilizerQuantity.l("Austria_Hochalpen","mineral N fert (N)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0.01;
VMineralFertilizerQuantity.l("Austria_Voralpen","mineral N fert (N)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0.01;
VMineralFertilizerQuantity.l("Austria_Alpenostrand","mineral N fert (N)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0.04;
VMineralFertilizerQuantity.l("Austria_WaldMuehlViertel","mineral N fert (N)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0.09;
VMineralFertilizerQuantity.l("Austria_KaerntnerBecken","mineral N fert (N)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0.05;
VMineralFertilizerQuantity.l("Austria_Alpenvorland","mineral N fert (N)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0.27;
VMineralFertilizerQuantity.l("Austria_SuedoestlFlachHuegelland","mineral N fert (N)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0.16;
VMineralFertilizerQuantity.l("Austria_NordoestlFlachHuegelland","mineral N fert (N)","AllMinFertProdTech","Convent")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0.37;

VMineralFertilizerQuantity.l("Austria_Hochalpen","mineral N fert (N)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0;
VMineralFertilizerQuantity.l("Austria_Voralpen","mineral N fert (N)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0;
VMineralFertilizerQuantity.l("Austria_Alpenostrand","mineral N fert (N)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0;
VMineralFertilizerQuantity.l("Austria_WaldMuehlViertel","mineral N fert (N)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0;
VMineralFertilizerQuantity.l("Austria_KaerntnerBecken","mineral N fert (N)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0;
VMineralFertilizerQuantity.l("Austria_Alpenvorland","mineral N fert (N)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0;
VMineralFertilizerQuantity.l("Austria_SuedoestlFlachHuegelland","mineral N fert (N)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0;
VMineralFertilizerQuantity.l("Austria_NordoestlFlachHuegelland","mineral N fert (N)","AllMinFertProdTech","Organic")
         = VMineralFertilizerQuantity.l("Austria","mineral N fert (N)","AllMinFertProdTech","AllProdSyst")*0;


*The CH GHG inventory uses a methane conversion rate of 6.9% for mature dairy cattle, not the IPCC 2006 values of 6.5% for roughage and 3% for concentrates
*        and it uses 6.5% for all other cattle for non-milk energy, 0 for milk energy. So we use 6.5% for all as milk is relatively unimportant compared to toal GE use.
*(CH GHG inventory 2019, section 5.2.2.2.2):
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle",AnimalTypeInHerd,"AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle",AnimalTypeInHerd,"AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle",AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle",AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle",AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle",AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle",AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle",AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle",AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle",AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;

FeedingRationsHeads_OtherChar("Switzerland","Cattle",AnimalTypeInHerd,"AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Cattle",AnimalTypeInHerd,"AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar("Switzerland","Cattle",AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Cattle",AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar("Switzerland","Cattle",AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Cattle",AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar("Switzerland","Cattle",AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Cattle",AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar("Switzerland","Cattle",AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Cattle",AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;

FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle","Producing_Dairy_Cattle","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle","Producing_Dairy_Cattle","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.9;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle","Producing_Dairy_Cattle","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle","Producing_Dairy_Cattle","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.9;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle","Producing_Dairy_Cattle","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle","Producing_Dairy_Cattle","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.9;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle","Producing_Dairy_Cattle","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle","Producing_Dairy_Cattle","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.9;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle","Producing_Dairy_Cattle","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Cattle","Producing_Dairy_Cattle","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.9;

FeedingRationsHeads_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.9;
FeedingRationsHeads_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.9;
FeedingRationsHeads_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.9;
FeedingRationsHeads_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.9;
FeedingRationsHeads_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Cattle","Producing_Dairy_Cattle","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.9;

*For Austria, the MCF is 6.5% for all cattle, according to the GHG Inventory from 2019, page 311:
FeedingRationsHeads_OtherChar(Regions_Austria,"Cattle",AnimalTypeInHerd,"AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Cattle",AnimalTypeInHerd,"AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar(Regions_Austria,"Cattle",AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Cattle",AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar(Regions_Austria,"Cattle",AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Cattle",AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar(Regions_Austria,"Cattle",AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Cattle",AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar(Regions_Austria,"Cattle",AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Cattle",AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;

FeedingRationsHeads_OtherChar("Austria","Cattle",AnimalTypeInHerd,"AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Cattle",AnimalTypeInHerd,"AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar("Austria","Cattle",AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Cattle",AnimalTypeInHerd,"AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar("Austria","Cattle",AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Cattle",AnimalTypeInHerd,"AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar("Austria","Cattle",AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Cattle",AnimalTypeInHerd,"AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;
FeedingRationsHeads_OtherChar("Austria","Cattle",AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Cattle",AnimalTypeInHerd,"AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6.5;

*For Chickens, Switzerland, the MCF is 0.16% according to the GHG Inventory from 2019, page 285:
*this is, however, from ME, not GE - but keep for now.
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Chickens","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;

FeedingRationsHeads_OtherChar("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Chickens","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;


*For Chickens, Austria, the MCF is 0.16% according to the GHG Inventory from 2019, page 316:
FeedingRationsHeads_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Chickens","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;

FeedingRationsHeads_OtherChar("Austria","Chickens","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Chickens","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar("Austria","Chickens","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Chickens","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar("Austria","Chickens","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Chickens","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar("Austria","Chickens","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Chickens","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;
FeedingRationsHeads_OtherChar("Austria","Chickens","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Chickens","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 0.16;

*for Horses, a value of 2.45% is used for the MCF for AT and CH, based on the GHG inventory of Switzerland, 2019, p283 and lack of details for AT (only per head emission factors, table 170 in the AT GHG inventory.
FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;

FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;

FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;
FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 2.45;

*for goats, a value of 6% is used for the MCF for AT and CH, based on the GHG inventory of Switzerland, 2019, p283 and lack of details for AT (only per head emission factors, table 170 in the AT GHG inventory.
FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Austria,"Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;

FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Austria","Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;

FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar(Regions_Switzerland,"Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedTotal_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedConcentrates_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedForageCrops_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedGrass_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;
FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
                  $FeedingRationsHeads_OtherChar("Switzerland","Horses","AllAndAverageTypes","AggregateFeedResidues_Commodity","Percentage GE in feed converted to enteric CH4",ProductionSystems,ProductionConditions)
         = 6;







****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values for CH and AT to country sub-regions where no specific values are available

*3.1) Main parameters CH
*3.1.1) Activities: input parameters
ActCropsGrass_Inputs(Regions_Switzerland,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_Inputs(Regions_Switzerland,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions))
         = ActCropsGrass_Inputs("Switzerland",Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActAnimalsAPU_Inputs(Regions_Switzerland,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions)
*                 $(NOT ActAnimalsAPU_Inputs(Regions_Switzerland,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions))
*         = ActAnimalsAPU_Inputs("Switzerland",Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_Inputs(Regions_Switzerland,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions)
                 $(NOT ActAnimalsHead_Inputs(Regions_Switzerland,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions))
         = ActAnimalsHead_Inputs("Switzerland",Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActFishSeafood_Inputs(Regions_Switzerland,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions)
*                 $(NOT ActFishSeafood_Inputs(Regions_Switzerland,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions))
*         = ActFishSeafood_Inputs("Switzerland",Activities,InputsFishSeafood,ProductionSystems,ProductionConditions);
ActForest_Inputs(Regions_Switzerland,Activities,InputsForest,ProductionSystems,ProductionConditions)
                 $(NOT ActForest_Inputs(Regions_Switzerland,Activities,InputsForest,ProductionSystems,ProductionConditions))
         = ActForest_Inputs("Switzerland",Activities,InputsForest,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActOthers_Inputs(Regions_Switzerland,Activities,InputsOther,ProductionSystems,ProductionConditions)
*                 $(NOT ActOthers_Inputs(Regions_Switzerland,Activities,InputsOther,ProductionSystems,ProductionConditions))
*         = ActOthers_Inputs("Switzerland",Activities,InputsOther,ProductionSystems,ProductionConditions);

*3.1.2) Activities: output parameters
ActCropsGrass_Outputs(Regions_Switzerland,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_Outputs(Regions_Switzerland,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions))
         = ActCropsGrass_Outputs("Switzerland",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions);
ActAnimalsAPU_Outputs(Regions_Switzerland,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions)
                 $(NOT ActAnimalsAPU_Outputs(Regions_Switzerland,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions))
         = ActAnimalsAPU_Outputs("Switzerland",Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_Outputs(Regions_Switzerland,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions)
                 $(NOT ActAnimalsHead_Outputs(Regions_Switzerland,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions))
         = ActAnimalsHead_Outputs("Switzerland",Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActFishSeafood_Outputs(Regions_Switzerland,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions)
*                 $(NOT ActFishSeafood_Outputs(Regions_Switzerland,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions))
*         = ActFishSeafood_Outputs("Switzerland",Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActForest_Outputs(Regions_Switzerland,Activities,OutputsForest,ProductionSystems,ProductionConditions)
*                 $(NOT ActForest_Outputs(Regions_Switzerland,Activities,OutputsForest,ProductionSystems,ProductionConditions))
*         = ActForest_Outputs("Switzerland",Activities,OutputsForest,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActOthers_Outputs(Regions_Switzerland,Activities,OutputsOther,ProductionSystems,ProductionConditions)
*                 $(NOT ActOthers_Outputs(Regions_Switzerland,Activities,OutputsOther,ProductionSystems,ProductionConditions))
*         = ActOthers_Outputs("Switzerland",Activities,OutputsOther,ProductionSystems,ProductionConditions);

*3.1.3) Activities: other characteristics
ActCropsGrass_OtherChar(Regions_Switzerland,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_OtherChar(Regions_Switzerland,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions))
         = ActCropsGrass_OtherChar("Switzerland",Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
*NOT YET INITIALISED
*ActAnimalsAPU_OtherChar(Regions_Switzerland,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions)
*                 $(NOT ActAnimalsAPU_OtherChar(Regions_Switzerland,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions))
*         = ActAnimalsAPU_OtherChar("Switzerland",Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_OtherChar(Regions_Switzerland,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions)
                 $(NOT ActAnimalsHead_OtherChar(Regions_Switzerland,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions))
         = ActAnimalsHead_OtherChar("Switzerland",Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActFishSeafood_OtherChar(Regions_Switzerland,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions)
*                 $(NOT ActFishSeafood_OtherChar(Regions_Switzerland,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions))
*         = ActFishSeafood_OtherChar("Switzerland",Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActForest_OtherChar(Regions_Switzerland,Activities,OtherCharForest,ProductionSystems,ProductionConditions)
*                 $(NOT ActForest_OtherChar(Regions_Switzerland,Activities,OtherCharForest,ProductionSystems,ProductionConditions))
*         = ActForest_OtherChar("Switzerland",Activities,OtherCharForest,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActOthers_OtherChar(Regions_Switzerland,Activities,OtherCharOther,ProductionSystems,ProductionConditions)
*                 $(NOT ActOthers_OtherChar(Regions_Switzerland,Activities,OtherCharOther,ProductionSystems,ProductionConditions))
*         = ActOthers_OtherChar("Switzerland",Activities,OtherCharOther,ProductionSystems,ProductionConditions);


*3.1.4) Commodities: nutrient contents and other characteristics
Commod_Contents(Regions_Switzerland,Commodities,Contents,ProductionSystems,ProductionConditions)
                 $(NOT Commod_Contents(Regions_Switzerland,Commodities,Contents,ProductionSystems,ProductionConditions))
         = Commod_Contents("Switzerland",Commodities,Contents,ProductionSystems,ProductionConditions);
Commod_OtherChar(Regions_Switzerland,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions)
                 $(NOT Commod_OtherChar(Regions_Switzerland,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions))
         = Commod_OtherChar("Switzerland",Commodities,CommodOtherChar,ProductionSystems,ProductionConditions);


*3.1.5) Commodity tree parameters
*the following is yet empty
*Commod_ProductionShare(Regions_Switzerland,Commodities,Commodities_2,ProductionSystems)
*                 $(NOT Commod_ProductionShare(Regions_Switzerland,Commodities,Commodities_2,ProductionSystems))
*         = Commod_ProductionShare("Switzerland",Commodities,Commodities_2,ProductionSystems);
*the following is yet empty
*Commod_ExtractionRate(Regions_Switzerland,Commodities,Commodities_2,ProductionSystems)
*                 $(NOT Commod_ExtractionRate(Regions_Switzerland,Commodities,Commodities_2,ProductionSystems))
*         = Commod_ExtractionRate("Switzerland",Commodities,Commodities_2,ProductionSystems);
*the following is yet empty
*Commod_SingleInAggregateCommodShares(Regions_Switzerland,Commodities,Commodities_2,ProductionSystems)
*                 $(NOT Commod_SingleInAggregateCommodShares(Regions_Switzerland,Commodities,Commodities_2,ProductionSystems))
*         = Commod_SingleInAggregateCommodShares("Switzerland",Commodities,Commodities_2,ProductionSystems);

*3.1.6) Crop residues: nutrient contents, other characteristics and management
CropResidues_Contents(Regions_Switzerland,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions)
                 $(NOT CropResidues_Contents(Regions_Switzerland,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions))
         = CropResidues_Contents("Switzerland",Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions);
CropResidues_OtherChar(Regions_Switzerland,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions)
                 $(NOT CropResidues_OtherChar(Regions_Switzerland,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions))
         = CropResidues_OtherChar("Switzerland",Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions);
CropResidues_Management(Regions_Switzerland,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions)
                 $(NOT CropResidues_Management(Regions_Switzerland,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions))
         = CropResidues_Management("Switzerland",Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions);

*3.1.7) Feeding rations
*the following is yet empty
*FeedingRations_Contents(Regions_Switzerland,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions)
*                 $(NOT FeedingRations_Contents(Regions_Switzerland,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions))
*         = FeedingRations_Contents("Switzerland",Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions);
FeedingRations_OtherChar(Regions_Switzerland,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions)
                 $(NOT FeedingRations_OtherChar(Regions_Switzerland,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions))
         = FeedingRations_OtherChar("Switzerland",Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions);
FeedingRationsHeads_OtherChar(Regions_Switzerland,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions)
                 $(NOT FeedingRationsHeads_OtherChar(Regions_Switzerland,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions))
         = FeedingRationsHeads_OtherChar("Switzerland",Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions);

*3.1.8) Manure: nutrient contents, other characteristics and management
*the following is yet empty
*Manure_Contents(Regions_Switzerland,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions)
*                 $(NOT Manure_Contents(Regions_Switzerland,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions))
*         = Manure_Contents("Switzerland",Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions);
Manure_OtherChar(Regions_Switzerland,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions)
                 $(NOT Manure_OtherChar(Regions_Switzerland,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions))
         = Manure_OtherChar("Switzerland",Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions);
Manure_Management(Regions_Switzerland,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
                 $(NOT Manure_Management(Regions_Switzerland,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions))
         = Manure_Management("Switzerland",Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions);

*3.1.9) Fertilizer application: nutrients and other characteristics
ManureApplication(Regions_Switzerland,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions)
                 $(NOT ManureApplication(Regions_Switzerland,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions))
         = ManureApplication("Switzerland",Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions);
CropResAndBiomassApplication(Regions_Switzerland,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions)
                 $(NOT CropResAndBiomassApplication(Regions_Switzerland,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions))
         = CropResAndBiomassApplication("Switzerland",Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions);
MinFertApplication(Regions_Switzerland,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions)
                 $(NOT MinFertApplication(Regions_Switzerland,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions))
         = MinFertApplication("Switzerland",Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions);


*3.2) Main parameters AT
*3.2.1) Activities: input parameters
ActCropsGrass_Inputs(Regions_Austria,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_Inputs(Regions_Austria,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions))
         = ActCropsGrass_Inputs("Austria",Activities,InputsCropsGrass,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActAnimalsAPU_Inputs(Regions_Austria,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions)
*                 $(NOT ActAnimalsAPU_Inputs(Regions_Austria,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions))
*         = ActAnimalsAPU_Inputs("Austria",Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_Inputs(Regions_Austria,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions)
                 $(NOT ActAnimalsHead_Inputs(Regions_Austria,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions))
         = ActAnimalsHead_Inputs("Austria",Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActFishSeafood_Inputs(Regions_Austria,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions)
*                 $(NOT ActFishSeafood_Inputs(Regions_Austria,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions))
*         = ActFishSeafood_Inputs("Austria",Activities,InputsFishSeafood,ProductionSystems,ProductionConditions);
ActForest_Inputs(Regions_Austria,Activities,InputsForest,ProductionSystems,ProductionConditions)
                 $(NOT ActForest_Inputs(Regions_Austria,Activities,InputsForest,ProductionSystems,ProductionConditions))
         = ActForest_Inputs("Austria",Activities,InputsForest,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActOthers_Inputs(Regions_Austria,Activities,InputsOther,ProductionSystems,ProductionConditions)
*                 $(NOT ActOthers_Inputs(Regions_Austria,Activities,InputsOther,ProductionSystems,ProductionConditions))
*         = ActOthers_Inputs("Austria",Activities,InputsOther,ProductionSystems,ProductionConditions);

*3.2.2) Activities: output parameters
ActCropsGrass_Outputs(Regions_Austria,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_Outputs(Regions_Austria,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions))
         = ActCropsGrass_Outputs("Austria",Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions);
ActAnimalsAPU_Outputs(Regions_Austria,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions)
                 $(NOT ActAnimalsAPU_Outputs(Regions_Austria,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions))
         = ActAnimalsAPU_Outputs("Austria",Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_Outputs(Regions_Austria,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions)
                 $(NOT ActAnimalsHead_Outputs(Regions_Austria,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions))
         = ActAnimalsHead_Outputs("Austria",Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActFishSeafood_Outputs(Regions_Austria,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions)
*                 $(NOT ActFishSeafood_Outputs(Regions_Austria,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions))
*         = ActFishSeafood_Outputs("Austria",Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActForest_Outputs(Regions_Austria,Activities,OutputsForest,ProductionSystems,ProductionConditions)
*                 $(NOT ActForest_Outputs(Regions_Austria,Activities,OutputsForest,ProductionSystems,ProductionConditions))
*         = ActForest_Outputs("Austria",Activities,OutputsForest,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActOthers_Outputs(Regions_Austria,Activities,OutputsOther,ProductionSystems,ProductionConditions)
*                 $(NOT ActOthers_Outputs(Regions_Austria,Activities,OutputsOther,ProductionSystems,ProductionConditions))
*         = ActOthers_Outputs("Austria",Activities,OutputsOther,ProductionSystems,ProductionConditions);

*3.2.3) Activities: other characteristics
ActCropsGrass_OtherChar(Regions_Austria,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions)
                 $(NOT ActCropsGrass_OtherChar(Regions_Austria,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions))
         = ActCropsGrass_OtherChar("Austria",Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions);
*NOT YET INITIALISED
*ActAnimalsAPU_OtherChar(Regions_Austria,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions)
*                 $(NOT ActAnimalsAPU_OtherChar(Regions_Austria,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions))
*         = ActAnimalsAPU_OtherChar("Austria",Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions);
ActAnimalsHead_OtherChar(Regions_Austria,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions)
                 $(NOT ActAnimalsHead_OtherChar(Regions_Austria,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions))
         = ActAnimalsHead_OtherChar("Austria",Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActFishSeafood_OtherChar(Regions_Austria,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions)
*                 $(NOT ActFishSeafood_OtherChar(Regions_Austria,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions))
*         = ActFishSeafood_OtherChar("Austria",Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActForest_OtherChar(Regions_Austria,Activities,OtherCharForest,ProductionSystems,ProductionConditions)
*                 $(NOT ActForest_OtherChar(Regions_Austria,Activities,OtherCharForest,ProductionSystems,ProductionConditions))
*         = ActForest_OtherChar("Austria",Activities,OtherCharForest,ProductionSystems,ProductionConditions);
*the following is yet empty
*ActOthers_OtherChar(Regions_Austria,Activities,OtherCharOther,ProductionSystems,ProductionConditions)
*                 $(NOT ActOthers_OtherChar(Regions_Austria,Activities,OtherCharOther,ProductionSystems,ProductionConditions))
*         = ActOthers_OtherChar("Austria",Activities,OtherCharOther,ProductionSystems,ProductionConditions);

*3.2.4) Commodities: nutrient contents and other characteristics
Commod_Contents(Regions_Austria,Commodities,Contents,ProductionSystems,ProductionConditions)
                 $(NOT Commod_Contents(Regions_Austria,Commodities,Contents,ProductionSystems,ProductionConditions))
         = Commod_Contents("Austria",Commodities,Contents,ProductionSystems,ProductionConditions);
Commod_OtherChar(Regions_Austria,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions)
                 $(NOT Commod_OtherChar(Regions_Austria,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions))
         = Commod_OtherChar("Austria",Commodities,CommodOtherChar,ProductionSystems,ProductionConditions);

*3.2.5) Commodity tree parameters
*the following is yet empty
*Commod_ProductionShare(Regions_Austria,Commodities,Commodities_2,ProductionSystems)
*                 $(NOT Commod_ProductionShare(Regions_Austria,Commodities,Commodities_2,ProductionSystems))
*         = Commod_ProductionShare("Austria",Commodities,Commodities_2,ProductionSystems);
*the following is yet empty
*Commod_ExtractionRate(Regions_Austria,Commodities,Commodities_2,ProductionSystems)
*                 $(NOT Commod_ExtractionRate(Regions_Austria,Commodities,Commodities_2,ProductionSystems))
*         = Commod_ExtractionRate("Austria",Commodities,Commodities_2,ProductionSystems);
*the following is yet empty
*Commod_SingleInAggregateCommodShares(Regions_Austria,Commodities,Commodities_2,ProductionSystems)
*                 $(NOT Commod_SingleInAggregateCommodShares(Regions_Austria,Commodities,Commodities_2,ProductionSystems))
*         = Commod_SingleInAggregateCommodShares("Austria",Commodities,Commodities_2,ProductionSystems);

*3.2.6) Crop residues: nutrient contents, other characteristics and management
CropResidues_Contents(Regions_Austria,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions)
                 $(NOT CropResidues_Contents(Regions_Austria,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions))
         = CropResidues_Contents("Austria",Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions);
CropResidues_OtherChar(Regions_Austria,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions)
                 $(NOT CropResidues_OtherChar(Regions_Austria,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions))
         = CropResidues_OtherChar("Austria",Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions);
CropResidues_Management(Regions_Austria,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions)
                 $(NOT CropResidues_Management(Regions_Austria,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions))
         = CropResidues_Management("Austria",Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions);

*3.2.7) Feeding rations
*the following is yet empty
*FeedingRations_Contents(Regions_Austria,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions)
*                 $(NOT FeedingRations_Contents(Regions_Austria,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions))
*         = FeedingRations_Contents("Austria",Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions);
FeedingRations_OtherChar(Regions_Austria,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions)
                 $(NOT FeedingRations_OtherChar(Regions_Austria,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions))
         = FeedingRations_OtherChar("Austria",Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions);
FeedingRationsHeads_OtherChar(Regions_Austria,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions)
                 $(NOT FeedingRationsHeads_OtherChar(Regions_Austria,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions))
         = FeedingRationsHeads_OtherChar("Austria",Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions);

*3.2.8) Manure: nutrient contents, other characteristics and management
*the following is yet empty
*Manure_Contents(Regions_Austria,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions)
*                 $(NOT Manure_Contents(Regions_Austria,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions))
*         = Manure_Contents("Austria",Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions);
Manure_OtherChar(Regions_Austria,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions)
                 $(NOT Manure_OtherChar(Regions_Austria,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions))
         = Manure_OtherChar("Austria",Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions);
Manure_Management(Regions_Austria,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions)
                 $(NOT Manure_Management(Regions_Austria,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions))
         = Manure_Management("Austria",Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions);

*3.2.9) Fertilizer application: nutrients and other characteristics
ManureApplication(Regions_Austria,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions)
                 $(NOT ManureApplication(Regions_Austria,Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions))
         = ManureApplication("Austria",Activities,Activities_2,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions);
CropResAndBiomassApplication(Regions_Austria,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions)
                 $(NOT CropResAndBiomassApplication(Regions_Austria,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions))
         = CropResAndBiomassApplication("Austria",Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions);
MinFertApplication(Regions_Austria,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions)
                 $(NOT MinFertApplication(Regions_Austria,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions))
         = MinFertApplication("Austria",Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions);



*replace CH and AT area numbers by the sum of the regions:
VActCropsGrass_QuantityActUnits.l("Switzerland",Activities,ProductionSystems,ProductionConditions)
         =sum(Regions_Switzerland,VActCropsGrass_QuantityActUnits.l(Regions_Switzerland,Activities,ProductionSystems,ProductionConditions));

VActCropsGrass_QuantityActUnits.l("Austria",Activities,ProductionSystems,ProductionConditions)
         =sum(Regions_Austria,VActCropsGrass_QuantityActUnits.l(Regions_Austria,Activities,ProductionSystems,ProductionConditions));

*replace CH and AT animal numbers by the sum of the regions:
VActAnimalsHead_QuantityActUnits.l("Switzerland",Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions)
         =sum(Regions_Switzerland,VActAnimalsHead_QuantityActUnits.l(Regions_Switzerland,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions));

VActAnimalsHead_QuantityActUnits.l("Austria",Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions)
         =sum(Regions_Austria,VActAnimalsHead_QuantityActUnits.l(Regions_Austria,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions));




*and for country level: assign the AllProdSyst data:
VActCropsGrass_QuantityActUnits.l("Switzerland",Activities,"AllProdSyst",ProductionConditions)
         = VActCropsGrass_QuantityActUnits.l("Switzerland",Activities,"Convent",ProductionConditions)
                 + VActCropsGrass_QuantityActUnits.l("Switzerland",Activities,"Organic",ProductionConditions);
VActCropsGrass_QuantityActUnits.l("Austria",Activities,"AllProdSyst",ProductionConditions)
         = VActCropsGrass_QuantityActUnits.l("Austria",Activities,"Convent",ProductionConditions)
                 + VActCropsGrass_QuantityActUnits.l("Austria",Activities,"Organic",ProductionConditions);
VActAnimalsHead_QuantityActUnits.l("Switzerland",Activities,AnimalTypeInHerd,"AllProdSyst",ProductionConditions)
         = VActAnimalsHead_QuantityActUnits.l("Switzerland",Activities,AnimalTypeInHerd,"Convent",ProductionConditions)
                 + VActAnimalsHead_QuantityActUnits.l("Switzerland",Activities,AnimalTypeInHerd,"Organic",ProductionConditions);
VActAnimalsHead_QuantityActUnits.l("Austria",Activities,AnimalTypeInHerd,"AllProdSyst",ProductionConditions)
         = VActAnimalsHead_QuantityActUnits.l("Austria",Activities,AnimalTypeInHerd,"Convent",ProductionConditions)
                 + VActAnimalsHead_QuantityActUnits.l("Austria",Activities,AnimalTypeInHerd,"Organic",ProductionConditions);






$exit;


GO ON HERE

add to commodities:
"Other annual crops"
"Other permanent crops"
add to commodity mathcing sets
"Spelt"

GRASSLAND yields above were termed "DRY MATTER" in the AP - is it DM or FM? Check with Simon - in the AP, there was an issue with Grassland where all was named DM somehow....


*slight corrrection du to the knowledge on GE contents in Switzerland - improve this
AshContent(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,SET_ProdSystems_OrgConAll)
                 $(GeographicStructure("Level5",GeographicUnits_New,"Switzerland")
                         AND (NOT AshContent(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,SET_ProdSystems_OrgConAll)))
         = AshContent("Switzerland",ActivityUnits_New,OutputType,AnimalHerdTypes,"All")*18.390/18.450;

AshContent(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,SET_ProdSystems_OrgConAll)
                 $(GeographicStructure("Level5",GeographicUnits_New,"Austria")
                         AND (NOT AshContent(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,SET_ProdSystems_OrgConAll)))
         = AshContent("Austria",ActivityUnits_New,OutputType,AnimalHerdTypes,"All")*18.390/18.450;








The assignments below are done in a special module later in the code of steeringFile1


*5.2) Main variables
*5.2.1) Amount of activity units
VActCropsGrass_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions))
         = VActCropsGrass_QuantityActUnits.l(Regions,Activities,ProductionSystems,ProductionConditions));
VActAnimalsAPU_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions))
         = VActAnimalsAPU_QuantityActUnits.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions));
VActAnimalsHead_QuantityActUnits_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions))
         = VActAnimalsHead_QuantityActUnits.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions));
*the following is yet empty
VActFishSeafood_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions))
         = VActFishSeafood_QuantityActUnits.l(Regions,Activities,ProductionSystems,ProductionConditions));
VActForest_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions))
         = VActForest_QuantityActUnits.l(Regions,Activities,ProductionSystems,ProductionConditions));
*the following is yet empty
VActOthers_QuantityActUnits_MR.l(Regions,Activities,ProductionSystems,ProductionConditions))
         = VActOthers_QuantityActUnits.l(Regions,Activities,ProductionSystems,ProductionConditions));

*5.2.2) Inputs to activities
VActCropsGrass_Inputs_MR.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions))
         = VActCropsGrass_Inputs.l(Regions,Activities,InputsCropsGrass,ProductionSystems,ProductionConditions));
*the following is yet empty
VActAnimalsAPU_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions))
         = VActAnimalsAPU_Inputs.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions));
*the following is yet empty
VActAnimalsHead_Inputs_MR.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions))
         = VActAnimalsHead_Inputs.l(Regions,Activities,AnimalTypeInHerd,InputsAnimals,ProductionSystems,ProductionConditions));
*the following is yet empty
VActFishSeafood_Inputs_MR.l(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions))
         = VActFishSeafood_Inputs.l(Regions,Activities,InputsFishSeafood,ProductionSystems,ProductionConditions));
*the following is yet empty
VActForest_Inputs_MR.l(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions))
         = VActForest_Inputs.l(Regions,Activities,InputsForest,ProductionSystems,ProductionConditions));
*the following is yet empty
VActOthers_Inputs_MR.l(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions))
         = VActOthers_Inputs.l(Regions,Activities,InputsOther,ProductionSystems,ProductionConditions));

*5.2.3) Outputs from activities
VActCropsGrass_Outputs_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions))
         = VActCropsGrass_Outputs.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions));
VActAnimalsAPU_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions))
         = VActAnimalsAPU_Outputs.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions));
VActAnimalsHead_Outputs_MR.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions))
         = VActAnimalsHead_Outputs.l(Regions,Activities,AnimalTypeInHerd,OutputsAnimals,ProductionSystems,ProductionConditions));
*the following is yet empty
VActFishSeafood_Outputs_MR.l(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions))
         = VActFishSeafood_Outputs.l(Regions,Activities,OutputsFishSeafood,ProductionSystems,ProductionConditions));
*the following is yet empty
VActForest_Outputs_MR.l(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions))
         = VActForest_Outputs.l(Regions,Activities,OutputsForest,ProductionSystems,ProductionConditions));
*the following is yet empty
VActOthers_Outputs_MR.l(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions))
         = VActOthers_Outputs.l(Regions,Activities,OutputsOther,ProductionSystems,ProductionConditions));

*5.2.4) Other characteristics of activities
*the following is yet empty
VActCropsGrass_OtherChar_MR.l(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions))
         = VActCropsGrass_OtherChar.l(Regions,Activities,OtherCharCropsGrass,ProductionSystems,ProductionConditions));
*the following is yet empty
VActAnimalsAPU_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions))
         = VActAnimalsAPU_OtherChar.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions));
*the following is yet empty
VActAnimalsHead_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions))
         = VActAnimalsHead_OtherChar.l(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,ProductionSystems,ProductionConditions));
*the following is yet empty
VActFishSeafood_OtherChar_MR.l(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions))
         = VActFishSeafood_OtherChar.l(Regions,Activities,OtherCharFishSeafood,ProductionSystems,ProductionConditions));
*the following is yet empty
VActForest_OtherChar_MR.l(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions))
         = VActForest_OtherChar.l(Regions,Activities,OtherCharForest,ProductionSystems,ProductionConditions));
*the following is yet empty
VActOthers_OtherChar_MR.l(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions))
         = VActOthers_OtherChar.l(Regions,Activities,OtherCharOther,ProductionSystems,ProductionConditions));


*5.2.5) Commodity quantities, nutrient contained and other characteristics
VCommod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VCommod_Quantity.l(Regions,Commodities,ProductionSystems,ProductionConditions));
*the following is yet empty
VCommod_Contents_MR.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions))
         = VCommod_Contents.l(Regions,Commodities,Contents,ProductionSystems,ProductionConditions));
*the following is yet empty
VCommod_OtherChar_MR.l(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions))
         = VCommod_OtherChar.l(Regions,Commodities,CommodOtherChar,ProductionSystems,ProductionConditions));

*5.2.6) Commodity untilizationa
VCommod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VCommod_Production.l(Regions,Commodities,ProductionSystems,ProductionConditions));
VCommod_StockChanges_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VCommod_StockChanges.l(Regions,Commodities,ProductionSystems,ProductionConditions));
VCommod_Food_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VCommod_Food.l(Regions,Commodities,ProductionSystems,ProductionConditions));
VCommod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VCommod_Feed.l(Regions,Commodities,ProductionSystems,ProductionConditions));
VCommod_Seed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VCommod_Seed.l(Regions,Commodities,ProductionSystems,ProductionConditions));
VCommod_Processing_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VCommod_Processing.l(Regions,Commodities,ProductionSystems,ProductionConditions));
VCommod_Waste_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VCommod_Waste.l(Regions,Commodities,ProductionSystems,ProductionConditions));
VCommod_Other_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VCommod_Other.l(Regions,Commodities,ProductionSystems,ProductionConditions));

*5.2.7) Crop residue quantities, nutrient contained, other characteristics and management
*the following is yet empty
VCropResidues_Quantity_MR.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions))
         = VCropResidues_Quantity.l(Regions,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions));
*the following is yet empty
VCropResidues_Contents_MR.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions))
         = VCropResidues_Contents.l(Regions,Activities,OutputsCropsGrass,CropResContents,ProductionSystems,ProductionConditions));
*the following is yet empty
VCropResidues_OtherChar_MR.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions))
         = VCropResidues_OtherChar.l(Regions,Activities,OutputsCropsGrass,CropResOtherChar,ProductionSystems,ProductionConditions));
*the following is yet empty
VCropResidues_Management_MR.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions))
         = VCropResidues_Management.l(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,ProductionSystems,ProductionConditions));

*5.2.8) Feeding rations quantities
*the following is yet empty
VFeedingRations_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions))
         = VFeedingRations_Quantity.l(Regions,Activities,AnimalTypeInHerd,Commodities,ProductionSystems,ProductionConditions));
*the following is yet empty
VFeedingRations_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions))
         = VFeedingRations_Contents.l(Regions,Activities,AnimalTypeInHerd,Commodities,Contents,ProductionSystems,ProductionConditions));
*the following is yet empty
VFeedingRations_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions))
         = VFeedingRations_OtherChar.l(Regions,Activities,AnimalTypeInHerd,Commodities,FeedingRationOtherChar,ProductionSystems,ProductionConditions));

*5.2.9) Manure quantities, nutrients contained, other characteristics and management
*the following is yet empty
VManure_Quantity_MR.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions))
         = VManure_Quantity.l(Regions,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions));
*the following is yet empty
VManure_Contents_MR.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions))
         = VManure_Contents.l(Regions,Activities,AnimalTypeInHerd,ManureContents,ProductionSystems,ProductionConditions));
*the following is yet empty
VManure_OtherChar_MR.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions))
         = VManure_OtherChar.l(Regions,Activities,AnimalTypeInHerd,ManureOtherChar,ProductionSystems,ProductionConditions));
*the following is yet empty
VManure_Management_MR.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions))
         = VManure_Management.l(Regions,Activities,AnimalTypeInHerd,ManureManagement,ManureManSystem,Temperatures,ProductionSystems,ProductionConditions));

*5.2.10) Fertilizer application: nutrients and other characteristics
*the following is yet empty
VManureApplication_MR.l(Regions,Activities,Livestock,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions))
         = VManureApplication.l(Regions,Activities,Livestock,AnimalTypeInHerd,FertApplicCharact,ProductionSystems,ProductionConditions));
*the following is yet empty
VCropResAndBiomassApplication_MR.l(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions))
         = VCropResAndBiomassApplication.l(Regions,Activities,Commodities,FertApplicCharact,ProductionSystems,ProductionConditions));
*the following is yet empty
VMinFertApplication_MR.l(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions))
         = VMinFertApplication.l(Regions,Activities,MineralFertilizerType,FertApplicCharact,ProductionSystems,ProductionConditions));

*5.2.11) Import and export quantities
VImportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions))
         = VImportQuantity.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions));
VExportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions))
         = VExportQuantity.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions));
VImportLivingAnimalsHead_MR.l(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions))
         = VImportLivingAnimalsHead.l(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions));
VExportLivingAnimalsHead_MR.l(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions))
         = VExportLivingAnimalsHead.l(Regions,Regions_2,Activities,AnimalTypeInHerd,ProductionSystems,ProductionConditions));
VImportLivingAnimalsAPU_MR.l(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions))
         = VImportLivingAnimalsAPU.l(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions));
VExportLivingAnimalsAPU_MR.l(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions))
         = VExportLivingAnimalsAPU.l(Regions,Regions_2,Activities,ProductionSystems,ProductionConditions));

*5.2.12) Commodities expressed in primary product equivalents
VPrimProd_Commod_Quantity_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VPrimProd_Commod_Quantity.l(Regions,Commodities,ProductionSystems,ProductionConditions));

*the following is yet empty
VPrimProd_Commod_Production_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VPrimProd_Commod_Production.l(Regions,Commodities,ProductionSystems,ProductionConditions));
*the following is yet empty
VPrimProd_Commod_StockChanges_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VPrimProd_Commod_StockChanges.l(Regions,Commodities,ProductionSystems,ProductionConditions));
*the following is yet empty
VPrimProd_Commod_Food_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VPrimProd_Commod_Food.l(Regions,Commodities,ProductionSystems,ProductionConditions));
*the following is yet empty
VPrimProd_Commod_Feed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VPrimProd_Commod_Feed.l(Regions,Commodities,ProductionSystems,ProductionConditions));
*the following is yet empty
VPrimProd_Commod_Seed_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VPrimProd_Commod_Seed.l(Regions,Commodities,ProductionSystems,ProductionConditions));
*the following is yet empty
VPrimProd_Commod_Processing_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VPrimProd_Commod_Processing.l(Regions,Commodities,ProductionSystems,ProductionConditions));
*the following is yet empty
VPrimProd_Commod_Waste_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VPrimProd_Commod_Waste.l(Regions,Commodities,ProductionSystems,ProductionConditions));
*the following is yet empty
VPrimProd_Commod_Other_MR.l(Regions,Commodities,ProductionSystems,ProductionConditions))
         = VPrimProd_Commod_Other.l(Regions,Commodities,ProductionSystems,ProductionConditions));

*the following is yet empty
VPrimProd_ImportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions))
         = VPrimProd_ImportQuantity.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions));
*the following is yet empty
VPrimProd_ExportQuantity_MR.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions))
         = VPrimProd_ExportQuantity.l(Regions,Regions_2,Commodities,ProductionSystems,ProductionConditions));

VPrimProd_Commod_Quantity_CropActivities_MR.l(Regions,Commodities,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions))
         = VPrimProd_Commod_Quantity_CropActivities.l(Regions,Commodities,Activities,OutputsCropsGrass,ProductionSystems,ProductionConditions));
VPrimProd_Commod_Quantity_AnimalActivities_MR.l(Regions,Commodities,Activities,OutputsAnimals,ProductionSystems,ProductionConditions))
         = VPrimProd_Commod_Quantity_AnimalActivities.l(Regions,Commodities,Activities,OutputsAnimals,ProductionSystems,ProductionConditions));


*5.3) Auxiliary parameters
HumanCharacteristics_MR(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities)
         = HumanCharacteristics(Regions,PopulationGroups,Humans_InputsOutputsOtherCharacteristics,Commodities);
SeedContents_MR(Regions,Activities,Contents,ProductionSystems,ProductionConditions))
         = SeedContents(Regions,Activities,Contents,ProductionSystems,ProductionConditions);
MineralFertilizerCharacteristics_MR(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,ProductionSystems)
         = MineralFertilizerCharacteristics(Regions,MineralFertilizerType,MineralFertilizerProdTech,MinFertChar,ProductionSystems);


*5.4) Auxiliary variables
VMineralFertilizerQuantity_MR.l(Regions,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems)
         = VMineralFertilizerQuantity.l(Regions,MineralFertilizerType,MineralFertilizerProdTech,ProductionSystems);
VPopulationNumbers_MR.l(Regions,PopulationGroups)
         = VPopulationNumbers.l(Regions,PopulationGroups);











*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


below: not needed anymore - what we need, we already took and included above:

*from $include __SOLmV4_HerdStructures.gms
$label HerdStructures

*derive the following shares, as in the main code, this is derived from parameters directly read from the global herd structure output, thus not available to the Alpenprojekt,
*thus derive it specifically for the Alpenprojekt with the correct animal numbers:
ParamPerHead_AnimalHerdTypeShareToLiving(GeographicUnits_New,SET_ActGroup_Animals,"All",AnimalHerdTypes,SET_ProdSystems_OrgConAll,"All","Baseline")
                 $(GeographicStructure("Level5",GeographicUnits_New,"Switzerland")
*                         AND HerdStructure_NrOfAnimals_New(GeographicUnits_New,SET_ActGroup_Animals,"All","Living") AND HerdTypesStructure(AnimalHerdTypes,SET_ActGroup_Animals))
                         AND NumberLivingAnimals_HerdStructure.l(GeographicUnits_New,SET_ActGroup_Animals,"All","All",SET_ProdSystems_OrgConAll,"All","Baseline") AND HerdTypesStructure(AnimalHerdTypes,SET_ActGroup_Animals))
*         = HerdStructure_NrOfAnimals_New(GeographicUnits_New,SET_ActGroup_Animals,"All",AnimalHerdTypes)
*                 /HerdStructure_NrOfAnimals_New(GeographicUnits_New,SET_ActGroup_Animals,"All","Living");
         = NumberLivingAnimals_HerdStructure.l(GeographicUnits_New,SET_ActGroup_Animals,"All",AnimalHerdTypes,SET_ProdSystems_OrgConAll,"All","Baseline")
                 /NumberLivingAnimals_HerdStructure.l(GeographicUnits_New,SET_ActGroup_Animals,"All","All",SET_ProdSystems_OrgConAll,"All","Baseline");

ParamPerHead_AnimalHerdTypeShareToProducing(GeographicUnits_New,SET_ActGroup_Animals,OutputType,AnimalHerdTypes,SET_ProdSystems_OrgConAll,"All","Baseline")
                 $(GeographicStructure("Level5",GeographicUnits_New,"Switzerland")
*                         AND HerdStructure_NrOfAnimals_New(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing") AND HerdTypesStructure(AnimalHerdTypes,SET_ActGroup_Animals))
                         AND NumberLivingAnimals_HerdStructure.l(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing",SET_ProdSystems_OrgConAll,"All","Baseline") AND HerdTypesStructure(AnimalHerdTypes,SET_ActGroup_Animals))
*         = HerdStructure_NrOfAnimals_New(GeographicUnits_New,SET_ActGroup_Animals,"All",AnimalHerdTypes)
*                 /HerdStructure_NrOfAnimals_New(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing");
         = NumberLivingAnimals_HerdStructure.l(GeographicUnits_New,SET_ActGroup_Animals,"All",AnimalHerdTypes,SET_ProdSystems_OrgConAll,"All","Baseline")
                 /NumberLivingAnimals_HerdStructure.l(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing",SET_ProdSystems_OrgConAll,"All","Baseline");

*And also derive the relation between producing and living animals:
ParamPerHead_AnimalHerdTypeShareToLiving(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing",SET_ProdSystems_OrgConAll,"All","Baseline")
                 $(GeographicStructure("Level5",GeographicUnits_New,"Switzerland")
*                         AND HerdStructure_NrOfAnimals_New(GeographicUnits_New,SET_ActGroup_Animals,"All","Living"))
                         AND NumberLivingAnimals_HerdStructure.l(GeographicUnits_New,SET_ActGroup_Animals,"All","All",SET_ProdSystems_OrgConAll,"All","Baseline"))
*         = HerdStructure_NrOfAnimals_New(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing")
*                 /HerdStructure_NrOfAnimals_New(GeographicUnits_New,SET_ActGroup_Animals,"All","Living");
         = NumberLivingAnimals_HerdStructure.l(GeographicUnits_New,SET_ActGroup_Animals,OutputType,"Producing",SET_ProdSystems_OrgConAll,"All","Baseline")
                 /NumberLivingAnimals_HerdStructure.l(GeographicUnits_New,SET_ActGroup_Animals,"All","All",SET_ProdSystems_OrgConAll,"All","Baseline");




*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
*from $include __SOLmV4_AssignOrgConParameters.gms
$label AssignOrgConParameters

PUTCLOSE con "   time elapsed since start of the run:" timeElapsed;

*the following assigns swiss general values to organic or conventional shares in case one of those is 0 for a swiss subregion - this shoul dbe avoided - try as follows:
*first assign a very small value to zero share in case th eothe rshare is 1, then do the assignments above, then replave with zero again:
ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,AnimalHerdTypes,"Nr of animal share convent (head/head)","All",ProductionConditions,"Baseline")
                 $((NOT ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,AnimalHerdTypes,"Nr of animal share convent (head/head)","All",ProductionConditions,"Baseline"))
                         and (ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,AnimalHerdTypes,"Nr of animal share organic (head/head)","All",ProductionConditions,"Baseline") = 1))
         = eps;
*such assignments as the above one can take very long, in case the condition that something is NOT there has to checked for millions of cases:
*thus, it is much faster, when doing it for SET_ActGroup_Animals than for ActivityUnits_New - in combination with OutputType and AnimalHerdTypes

ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,AnimalHerdTypes,"Nr of animal share organic (head/head)","All",ProductionConditions,"Baseline")
                 $((NOT ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,AnimalHerdTypes,"Nr of animal share organic (head/head)","All",ProductionConditions,"Baseline"))
                         and (ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,SET_ActGroup_Animals,OutputType,AnimalHerdTypes,"Nr of animal share convent (head/head)","All",ProductionConditions,"Baseline") = 1))
         = eps;

ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,"Area share convent (ha/ha)","All",ProductionConditions,"Baseline")
                 $((NOT ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,"Area share convent (ha/ha)","All",ProductionConditions,"Baseline"))
                         and (ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,"Area share organic (ha/ha)","All",ProductionConditions,"Baseline") = 1))
         = eps;

ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,"Area share organic (ha/ha)","All",ProductionConditions,"Baseline")
                 $((NOT ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,"Area share organic (ha/ha)","All",ProductionConditions,"Baseline"))
                         and (ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,"Area share convent (ha/ha)","All",ProductionConditions,"Baseline") = 1))
         = eps;

ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,"Quantity share convent (t/t)",ProductionSystems,ProductionConditions,"Baseline")
                 $((NOT ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,"Quantity share convent (t/t)",ProductionSystems,ProductionConditions,"Baseline"))
                         and (ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,"Quantity share organic (t/t)",ProductionSystems,ProductionConditions,"Baseline") = 1))
         = eps;

ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,"Quantity share organic (t/t)",ProductionSystems,ProductionConditions,"Baseline")
                 $((NOT ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,"Quantity share organic (t/t)",ProductionSystems,ProductionConditions,"Baseline"))
                         and (ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,"Quantity share convent (t/t)",ProductionSystems,ProductionConditions,"Baseline") = 1))
         = eps;

PUTCLOSE con "   time elapsed since start of the run:" timeElapsed;
PUTCLOSE con "           eps asigned to org/con shares = 0:";

ParameterPerTon(GeographicUnits_New,ActivityUnits_New,OutputType,PerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames)
                 $(GeographicStructure("Level5",GeographicUnits_New,"Switzerland")
                         AND (NOT ParameterPerTon(GeographicUnits_New,ActivityUnits_New,OutputType,PerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames)))
         = ParameterPerTon("Switzerland",ActivityUnits_New,OutputType,PerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames);

ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,PerAnimalHeadParameter,ProductionSystems,ProductionConditions,ScenarioNames)
                 $(GeographicStructure("Level5",GeographicUnits_New,"Switzerland") AND (NOT Control_NrAnimalShareProdSystMatch(PerAnimalHeadParameter,ProductionSystems))
                         AND (NOT ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,PerAnimalHeadParameter,ProductionSystems,ProductionConditions,ScenarioNames)))
         = ParameterPerAnimalHead_HerdStructure("Switzerland",ActivityUnits_New,OutputType,AnimalHerdTypes,PerAnimalHeadParameter,ProductionSystems,ProductionConditions,ScenarioNames);

ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,PerHaParameter,ProductionSystems,ProductionConditions,ScenarioNames)
                 $(GeographicStructure("Level5",GeographicUnits_New,"Switzerland") AND (NOT Control_AreaShareProdSystMatch(PerHaParameter,ProductionSystems))
                         AND (NOT ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,PerHaParameter,ProductionSystems,ProductionConditions,ScenarioNames)))
         = ParameterPerHa("Switzerland",ActivityUnits_New,OutputType,PerHaParameter,ProductionSystems,ProductionConditions,ScenarioNames);

ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,CommodityBalancesPerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames)
                 $(GeographicStructure("Level5",GeographicUnits_New,"Switzerland")
                         AND (NOT ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,CommodityBalancesPerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames)))
         = ParameterCommodityBalancesPerTon("Switzerland",CommodityBalancesUnits,OutputType,CommodityBalancesPerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames);

*FOR AUSTRIA:
ParameterPerTon(GeographicUnits_New,ActivityUnits_New,OutputType,PerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames)
                 $(GeographicStructure("Level5",GeographicUnits_New,"Austria")
                         AND (NOT ParameterPerTon(GeographicUnits_New,ActivityUnits_New,OutputType,PerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames)))
         = ParameterPerTon("Austria",ActivityUnits_New,OutputType,PerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames);

ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,PerAnimalHeadParameter,ProductionSystems,ProductionConditions,ScenarioNames)
                 $(GeographicStructure("Level5",GeographicUnits_New,"Austria") AND (NOT Control_NrAnimalShareProdSystMatch(PerAnimalHeadParameter,ProductionSystems))
                         AND (NOT ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,PerAnimalHeadParameter,ProductionSystems,ProductionConditions,ScenarioNames)))
         = ParameterPerAnimalHead_HerdStructure("Austria",ActivityUnits_New,OutputType,AnimalHerdTypes,PerAnimalHeadParameter,ProductionSystems,ProductionConditions,ScenarioNames);

ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,PerHaParameter,ProductionSystems,ProductionConditions,ScenarioNames)
                 $(GeographicStructure("Level5",GeographicUnits_New,"Austria") AND (NOT Control_AreaShareProdSystMatch(PerHaParameter,ProductionSystems))
                         AND (NOT ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,PerHaParameter,ProductionSystems,ProductionConditions,ScenarioNames)))
         = ParameterPerHa("Austria",ActivityUnits_New,OutputType,PerHaParameter,ProductionSystems,ProductionConditions,ScenarioNames);

ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,CommodityBalancesPerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames)
                 $(GeographicStructure("Level5",GeographicUnits_New,"Austria")
                         AND (NOT ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,CommodityBalancesPerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames)))
         = ParameterCommodityBalancesPerTon("Austria",CommodityBalancesUnits,OutputType,CommodityBalancesPerTonParameter,ProductionSystems,ProductionConditions,ScenarioNames);



PUTCLOSE con "   time elapsed since start of the run:" timeElapsed;


ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,"Nr of animal share convent (head/head)","All",ProductionConditions,ScenarioNames)
                 $(ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,"Nr of animal share convent (head/head)","All",ProductionConditions,ScenarioNames) = eps)
         = 0;
ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,"Nr of animal share organic (head/head)","All",ProductionConditions,ScenarioNames)
                 $(ParameterPerAnimalHead_HerdStructure(GeographicUnits_New,ActivityUnits_New,OutputType,AnimalHerdTypes,"Nr of animal share organic (head/head)","All",ProductionConditions,ScenarioNames) = eps)
         = 0;
ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,"Area share convent (ha/ha)","All",ProductionConditions,ScenarioNames)
                 $(ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,"Area share convent (ha/ha)","All",ProductionConditions,ScenarioNames) = eps)
         = 0;
ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,"Area share organic (ha/ha)","All",ProductionConditions,ScenarioNames)
                 $(ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,"Area share organic (ha/ha)","All",ProductionConditions,ScenarioNames) = eps)
         = 0;
ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,"Quantity share convent (t/t)",ProductionSystems,ProductionConditions,ScenarioNames)
                 $(ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,"Quantity share convent (t/t)",ProductionSystems,ProductionConditions,ScenarioNames) = eps)
         = 0;
ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,"Quantity share organic (t/t)",ProductionSystems,ProductionConditions,ScenarioNames)
                 $(ParameterCommodityBalancesPerTon(GeographicUnits_New,CommodityBalancesUnits,OutputType,"Quantity share organic (t/t)",ProductionSystems,ProductionConditions,ScenarioNames) = eps)
         = 0;

PUTCLOSE con "   time elapsed since start of the run:" timeElapsed;
PUTCLOSE con "           0 asigned to org/con shares = eps:";


*file in some new system-specific yield data
ParameterPerHa("Switzerland_Tal","Maize For Forage+Silage","Crop","Yield (t/ha)","Convent","All","Baseline") = 44.7;
ParameterPerHa("Switzerland_Huegel","Maize For Forage+Silage","Crop","Yield (t/ha)","Convent","All","Baseline") = 42;
ParameterPerHa("Switzerland_Berg","Maize For Forage+Silage","Crop","Yield (t/ha)","Convent","All","Baseline") = 39.4;
ParameterPerHa("Switzerland_Tal","Maize For Forage+Silage","Crop","Yield (t/ha)","Organic","All","Baseline") = 30;
ParameterPerHa("Switzerland_Huegel","Maize For Forage+Silage","Crop","Yield (t/ha)","Organic","All","Baseline") = 28.2;
ParameterPerHa("Switzerland_Berg","Maize For Forage+Silage","Crop","Yield (t/ha)","Organic","All","Baseline") = 26.4;

ParameterPerHa("Switzerland_Tal","Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 10.61;
ParameterPerHa("Switzerland_Huegel","Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 10.09;
ParameterPerHa("Switzerland_Berg","Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 8.19;
ParameterPerHa("Switzerland_Tal","Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 9.02;
ParameterPerHa("Switzerland_Huegel","Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 8.58;
ParameterPerHa("Switzerland_Berg","Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 6.96;
ParameterPerHa("Switzerland_Tal","Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 6.16;
ParameterPerHa("Switzerland_Huegel","Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 5.86;
ParameterPerHa("Switzerland_Berg","Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 4.67;
ParameterPerHa("Switzerland_Tal","Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 5.55;
ParameterPerHa("Switzerland_Huegel","Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 5.27;
ParameterPerHa("Switzerland_Berg","Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 4.21;
ParameterPerHa("Switzerland_Berg","alpine pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 4;
ParameterPerHa("Switzerland_Berg","alpine pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 4;

*FOR AUSTRIA
ParameterPerHa(SET_Austria_Tal,"Maize For Forage+Silage","Crop","Yield (t/ha)","Convent","All","Baseline") = 44.7;
ParameterPerHa(SET_Austria_Huegel,"Maize For Forage+Silage","Crop","Yield (t/ha)","Convent","All","Baseline") = 42;
ParameterPerHa(SET_Austria_Berg,"Maize For Forage+Silage","Crop","Yield (t/ha)","Convent","All","Baseline") = 39.4;
ParameterPerHa(SET_Austria_Tal,"Maize For Forage+Silage","Crop","Yield (t/ha)","Organic","All","Baseline") = 30;
ParameterPerHa(SET_Austria_Huegel,"Maize For Forage+Silage","Crop","Yield (t/ha)","Organic","All","Baseline") = 28.2;
ParameterPerHa(SET_Austria_Berg,"Maize For Forage+Silage","Crop","Yield (t/ha)","Organic","All","Baseline") = 26.4;

ParameterPerHa(SET_Austria_Tal,"Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 10.61;
ParameterPerHa(SET_Austria_Huegel,"Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 10.09;
ParameterPerHa(SET_Austria_Berg,"Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 8.19;
ParameterPerHa(SET_Austria_Tal,"Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 9.02;
ParameterPerHa(SET_Austria_Huegel,"Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 8.58;
ParameterPerHa(SET_Austria_Berg,"Temporary meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 6.96;
ParameterPerHa(SET_Austria_Tal,"Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 6.16;
ParameterPerHa(SET_Austria_Huegel,"Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 5.86;
ParameterPerHa(SET_Austria_Berg,"Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 4.67;
ParameterPerHa(SET_Austria_Tal,"Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 5.55;
ParameterPerHa(SET_Austria_Huegel,"Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 5.27;
ParameterPerHa(SET_Austria_Berg,"Permanent meadows and pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 4.21;
ParameterPerHa(SET_Austria_Berg,"alpine pastures","Crop","DMYield (tDM/ha)","Convent","All","Baseline") = 4;
ParameterPerHa(SET_Austria_Berg,"alpine pastures","Crop","DMYield (tDM/ha)","Organic","All","Baseline") = 4;






*now do some averaging for cases, where you have org / con per ha and ton parameters, but not yet "All" values:
*i.e. assign all values from org/con values:
ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,PerHaParameter,"All",ProductionConditions,"Baseline")
                 $sum(SET_ProdSystems_OrgCon,AreaHarvested.l(GeographicUnits_New,ActivityUnits_New,OutputType,SET_ProdSystems_OrgCon,ProductionConditions,"Baseline"))
         =sum(SET_ProdSystems_OrgCon,ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,PerHaParameter,SET_ProdSystems_OrgCon,ProductionConditions,"Baseline")
                         *AreaHarvested.l(GeographicUnits_New,ActivityUnits_New,OutputType,SET_ProdSystems_OrgCon,ProductionConditions,"Baseline"))
                 /sum(SET_ProdSystems_OrgCon,AreaHarvested.l(GeographicUnits_New,ActivityUnits_New,OutputType,SET_ProdSystems_OrgCon,ProductionConditions,"Baseline"));

ProductionQuantity.l(GeographicUnits_New,ActivityUnits_New,OutputType,SET_ProdSystems_OrgCon,ProductionConditions,"Baseline")
         = AreaHarvested.l(GeographicUnits_New,ActivityUnits_New,OutputType,SET_ProdSystems_OrgCon,ProductionConditions,"Baseline")
                 *ParameterPerHa(GeographicUnits_New,ActivityUnits_New,OutputType,"Yield (t/ha)","All",ProductionConditions,"Baseline");

ProductionQuantity.l(GeographicUnits_New,ActivityUnits_New,OutputType,"All",ProductionConditions,"Baseline")
         =sum(SET_ProdSystems_OrgCon,ProductionQuantity.l(GeographicUnits_New,ActivityUnits_New,OutputType,SET_ProdSystems_OrgCon,ProductionConditions,"Baseline"));

ParameterPerTon(GeographicUnits_New,ActivityUnits_New,OutputType,PerTonParameter,"All",ProductionConditions,"Baseline")
                 $sum(SET_ProdSystems_OrgCon,ProductionQuantity.l(GeographicUnits_New,ActivityUnits_New,OutputType,SET_ProdSystems_OrgCon,ProductionConditions,"Baseline"))
         =sum(SET_ProdSystems_OrgCon,ParameterPerTon(GeographicUnits_New,ActivityUnits_New,OutputType,PerTonParameter,SET_ProdSystems_OrgCon,ProductionConditions,"Baseline")
                         *ProductionQuantity.l(GeographicUnits_New,ActivityUnits_New,OutputType,SET_ProdSystems_OrgCon,ProductionConditions,"Baseline"))
                 /sum(SET_ProdSystems_OrgCon,ProductionQuantity.l(GeographicUnits_New,ActivityUnits_New,OutputType,SET_ProdSystems_OrgCon,ProductionConditions,"Baseline"));

*and finally, do averages of the perHa and perTon parameters over the grass sub-types, to get the "Grass" values correctly:
ParameterPerHa(GeographicUnits_New,"Grass","Crop",PerHaParameter,ProductionSystems,ProductionConditions,"Baseline")
                 $sum(SubSetGrass,AreaHarvested.l(GeographicUnits_New,SubSetGrass,"Crop",ProductionSystems,ProductionConditions,"Baseline"))
         =sum(SubSetGrass,ParameterPerHa(GeographicUnits_New,SubSetGrass,"Crop",PerHaParameter,ProductionSystems,ProductionConditions,"Baseline")
                         *AreaHarvested.l(GeographicUnits_New,SubSetGrass,"Crop",ProductionSystems,ProductionConditions,"Baseline"))
                 /sum(SubSetGrass,AreaHarvested.l(GeographicUnits_New,SubSetGrass,"Crop",ProductionSystems,ProductionConditions,"Baseline"));

ParameterPerTon(GeographicUnits_New,"Grass","Crop",PerTonParameter,ProductionSystems,ProductionConditions,"Baseline")
                 $sum(SubSetGrass,ProductionQuantity.l(GeographicUnits_New,SubSetGrass,"Crop",ProductionSystems,ProductionConditions,"Baseline"))
         =sum(SubSetGrass,ParameterPerTon(GeographicUnits_New,SubSetGrass,"Crop",PerTonParameter,ProductionSystems,ProductionConditions,"Baseline")
                         *ProductionQuantity.l(GeographicUnits_New,SubSetGrass,"Crop",ProductionSystems,ProductionConditions,"Baseline"))
                 /sum(SubSetGrass,ProductionQuantity.l(GeographicUnits_New,SubSetGrass,"Crop",ProductionSystems,ProductionConditions,"Baseline"));

