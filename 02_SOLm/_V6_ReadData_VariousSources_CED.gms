PUTCLOSE con,"_V6_ReadData_VariousSources_CED";

$ontext;
*GENERAL DESCRIPTION
*This file reads the CED data from SimaPro

*DETAILED TABLE OF CONTENTS
- 1) reading the csv-file and loading the parameters
- 2) Assign GHG values to CED values
- 3) Assign regional values to countries
- 4) Assign values to core model parameters and variables
         4.1) Link some sets as needed
         4.2) Link to the core model parameters

*ATTENTION:
data for GRASSCLASS2 has originally been named GRASS only - I renamed it to the hitherto missing GRASSCLASS2 - but values are strange: LOWER than GRASSCLASS3 and 4

Animal data is referring to MEAT - NO DATA ON MILK, it seems !!??? - check with Anita
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) reading the csv-file and loading the parameters


*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewCEDData% == "YES"
$call GDXXRW CED.xlsx o=CED.gdx index=Index!a1:e5 MaxDupeErrors = 200
*contains set definitions and parameters for the CED data
$endif;

SET ProcessCED;
PARAMETER CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,ProcessCED);
PARAMETER CED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED);
PARAMETER CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED);

$gdxin CED.gdx
$load ProcessCED
$load CED_Crops
$load CED_Animals
$load CED_Grass
$gdxin

*units:
*seems to be in MJ/t product



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Assign GHG values to CED values

*The GHG emission factors from CED used below are derived from average relations between CED and GWP from econinvent processes as used in the FiBL Farm GHG model from 2012 or so (to be updated with the Farm Model 2020!)
*conversion from MJ/kg to tCO2e/t

PARAMETER GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,ProcessCED) intermediate parameter used to convert CED to GWP;
PARAMETER GWPfromCED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED) intermediate parameter used to convert CED to GWP;
PARAMETER GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED) intermediate parameter used to convert CED to GWP;


*unit: MJ CED/ton
*some plausibility check with the conversion to GWP etc:
*diesel has about 34,7 MJ/litre and about 2,65kgCO2/litre, i.e. 0,0764 kgCO2/MJ or about 13 MJ/kgCO2
*thus, dividing MJ CED/t product by 13000 gives about t CO2/t product, assuming full energy supply by diesel - thus, the below calculations fit more or less from the magnitude of numbers to get tCO2/t product values

*concrete example:
*wheat CED: 2138 MJ/t, thus, if fully supplied by diesel: = 2138/13000 t CO2e/t = 0.164 tCO2e/t; with the conversions below, we get 0.116tCO2e/t, so that's ok

*the different factors below arise because of different energy mixes used (e.f. fossil fuel and electricity) with electricity stemming from a specific mix of renewable/non-renewable sources with a corresponding EF per kWh which is lower than for fossil fuel

*thus: general conversion MJ/kg to tCO2e/t is about: /13/1000
*thus, the GWP values need to be divided by 1000 further down

*the following apply to crops and grass:
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Seeds")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Seeds") / 8.62;
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Herbizides")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Herbizides") / 20.56;
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Fungizides")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Fungizides") / 20.56;
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Insecticides")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Insecticides") / 20.56;
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"OtherPPT")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"OtherPPT") / 20.56;
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Depot")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Depot") / 20.78;
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Tillage")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Tillage") / 17.09;
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Seeding")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Seeding") / 16.03;
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Fertilisation")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Fertilisation") / 15.72;
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"PPTSpraying")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"PPTSpraying") / 16.27;
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Harvesting")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Harvesting") / 17.60;
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Care")
         = CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"Care") / 15.84;

GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Seeds")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Seeds") / 8.62;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Herbizides")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Herbizides") / 20.56;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Fungizides")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Fungizides") / 20.56;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Insecticides")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Insecticides") / 20.56;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"OtherPPT")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"OtherPPT") / 20.56;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Depot")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Depot") / 20.78;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Tillage")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Tillage") / 17.09;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Seeding")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Seeding") / 16.03;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Fertilisation")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Fertilisation") / 15.72;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"PPTSpraying")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"PPTSpraying") / 16.27;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Harvesting")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Harvesting") / 17.60;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Care")
         = CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"Care") / 15.84;


*the following apply to animals only:
GWPfromCED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,"Stable")
         = CED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,"Stable") / 16.48;
GWPfromCED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,"Installation")
         = CED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,"Installation") / 16.48;


*Assign Total CED if not yet available:
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"TotalCED")
                 $(NOT GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"TotalCED"))
         = sum(ProcessCED,GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,ProcessCED));
GWPfromCED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,"TotalCED")
                 $(NOT GWPfromCED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,"TotalCED"))
         = sum(ProcessCED,GWPfromCED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED));
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"TotalCED")
                 $(NOT GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"TotalCED"))
         = sum(ProcessCED,GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED));

CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"TotalCED")
                 $(NOT CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"TotalCED"))
         = sum(ProcessCED,CED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,ProcessCED));
CED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,"TotalCED")
                 $(NOT CED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,"TotalCED"))
         = sum(ProcessCED,CED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED));
CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"TotalCED")
                 $(NOT CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"TotalCED"))
         = sum(ProcessCED,CED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED));

*divide GWP values by 1000 to get tCO2e/t
GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"TotalCED")
         = GWPfromCED_Crops(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,ProductionType,"TotalCED")/1000;
GWPfromCED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,"TotalCED")
         = GWPfromCED_Animals(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,ProductionType,"TotalCED")/1000;
GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"TotalCED")
         = GWPfromCED_Grass(FAOSTAT_CountriesAndRegions,ErbEtAl_GrasslandYieldClasses,ProductionType,"TotalCED")/1000;




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign regional values to countries

*assign regional values to countries:

CED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,ProductionType,ProcessCED)
                 $FAOSTAT_CountriesInRegions("Developed countries",FAOSTAT_Countries)
         = CED_Crops("Developed countries",FAOSTAT_CropProductionItems,ProductionType,ProcessCED);
CED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED)
                 $FAOSTAT_CountriesInRegions("Developed countries",FAOSTAT_Countries)
         = CED_Animals("Developed countries",FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED);
CED_Grass(FAOSTAT_Countries,ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED)
                 $FAOSTAT_CountriesInRegions("Developed countries",FAOSTAT_Countries)
         = CED_Grass("Developed countries",ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED);

CED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,ProductionType,ProcessCED)
                 $(FAOSTAT_CountriesInRegions("Developing countries",FAOSTAT_Countries)
                         AND (NOT CED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,ProductionType,ProcessCED)))
         = CED_Crops("Developing countries",FAOSTAT_CropProductionItems,ProductionType,ProcessCED);
CED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED)
                 $(FAOSTAT_CountriesInRegions("Developing countries",FAOSTAT_Countries)
                         AND (NOT CED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED)))
         = CED_Animals("Developing countries",FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED);
CED_Grass(FAOSTAT_Countries,ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED)
                 $(FAOSTAT_CountriesInRegions("Developing countries",FAOSTAT_Countries)
                         AND (NOT CED_Grass(FAOSTAT_Countries,ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED)))
         = CED_Grass("Developing countries",ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED);

GWPFromCED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,ProductionType,ProcessCED)
                 $FAOSTAT_CountriesInRegions("Developed countries",FAOSTAT_Countries)
         = GWPFromCED_Crops("Developed countries",FAOSTAT_CropProductionItems,ProductionType,ProcessCED);
GWPFromCED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED)
                 $FAOSTAT_CountriesInRegions("Developed countries",FAOSTAT_Countries)
         = GWPFromCED_Animals("Developed countries",FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED);
GWPFromCED_Grass(FAOSTAT_Countries,ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED)
                 $FAOSTAT_CountriesInRegions("Developed countries",FAOSTAT_Countries)
         = GWPFromCED_Grass("Developed countries",ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED);

GWPFromCED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,ProductionType,ProcessCED)
                 $(FAOSTAT_CountriesInRegions("Developing countries",FAOSTAT_Countries)
                         AND (NOT GWPFromCED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,ProductionType,ProcessCED)))
         = GWPFromCED_Crops("Developing countries",FAOSTAT_CropProductionItems,ProductionType,ProcessCED);
GWPFromCED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED)
                 $(FAOSTAT_CountriesInRegions("Developing countries",FAOSTAT_Countries)
                         AND (NOT GWPFromCED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED)))
         = GWPFromCED_Animals("Developing countries",FAOSTAT_LiveAnimalsItems,ProductionType,ProcessCED);
GWPFromCED_Grass(FAOSTAT_Countries,ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED)
                 $(FAOSTAT_CountriesInRegions("Developing countries",FAOSTAT_Countries)
                         AND (NOT GWPFromCED_Grass(FAOSTAT_Countries,ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED)))
         = GWPFromCED_Grass("Developing countries",ErbEtAl_GrasslandYieldClasses,ProductionType,ProcessCED);


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Assign values to core model parameters and variables
*4.1) Link some sets as needed

*no new sets needed

*4.2) Link to the core model parameters
*assign "Convent" to "AllProdSyst"

ActCropsGrass_Inputs(Regions,Crops,"Total CED (MJ)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Crops)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 CED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Convent","TotalCED"));
ActCropsGrass_Inputs(Regions,Crops,"Total CED (MJ)","Convent","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Crops)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 CED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Convent","TotalCED"));
ActCropsGrass_Inputs(Regions,Crops,"Total CED (MJ)","Organic","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Crops)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 CED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Organic","TotalCED"));

ActAnimalsHead_Inputs(Regions,Livestock,"AllAndAverageTypes","Total CED (MJ)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Livestock)),
                 CED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,"Convent","TotalCED"));
ActAnimalsHead_Inputs(Regions,Livestock,"AllAndAverageTypes","Total CED (MJ)","Convent","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Livestock)),
                 CED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,"Convent","TotalCED"));
ActAnimalsHead_Inputs(Regions,Livestock,"AllAndAverageTypes","Total CED (MJ)","Organic","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Livestock)),
                 CED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,"Organic","TotalCED"));

ActAnimalsHead_Inputs(Regions,"Cattle",CattleTypeInHerd,"Total CED (MJ)",ProductionSystems,"AllProdCond")
         = ActAnimalsHead_Inputs(Regions,"Cattle","AllAndAverageTypes","Total CED (MJ)",ProductionSystems,"AllProdCond");
ActAnimalsHead_Inputs(Regions,"Pigs",PigTypeInHerd,"Total CED (MJ)",ProductionSystems,"AllProdCond")
         = ActAnimalsHead_Inputs(Regions,"Pigs","AllAndAverageTypes","Total CED (MJ)",ProductionSystems,"AllProdCond");


*and for grass activities:
*grassland yields are the average from grassland calss 1 and 2 - and if those are not available, of class 3 and 4 - thus do the same for the CED values:
ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total CED (MJ)","Convent","AllProdCond")
         = sum((FAOSTAT_Countries,ErbEtAl_GrasslandDataCountryList)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Countries)
                         AND MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Countries)
                         AND (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass3") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass4") > 0)
                         AND (NOT (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2")))),
                 (CED_Grass(FAOSTAT_Countries,"GrassClass3","Convent","TotalCED") + CED_Grass(FAOSTAT_Countries,"GrassClass4","Convent","TotalCED"))/2);

ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total CED (MJ)","Convent","AllProdCond")
         = sum((FAOSTAT_Countries,ErbEtAl_GrasslandDataCountryList)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Countries)
                         AND MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Countries)
                         AND (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2") > 0)),
                 (CED_Grass(FAOSTAT_Countries,"GrassClass1","Convent","TotalCED") + CED_Grass(FAOSTAT_Countries,"GrassClass2","Convent","TotalCED"))/2);

ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total CED (MJ)","Organic","AllProdCond")
         = sum((FAOSTAT_Countries,ErbEtAl_GrasslandDataCountryList)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Countries)
                         AND MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Countries)
                         AND (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass3") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass4") > 0)
                         AND (NOT (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2")))),
                 (CED_Grass(FAOSTAT_Countries,"GrassClass3","Organic","TotalCED") + CED_Grass(FAOSTAT_Countries,"GrassClass4","Organic","TotalCED"))/2);

ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total CED (MJ)","Organic","AllProdCond")
         = sum((FAOSTAT_Countries,ErbEtAl_GrasslandDataCountryList)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Countries)
                         AND MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Countries)
                         AND (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2") > 0)),
                 (CED_Grass(FAOSTAT_Countries,"GrassClass1","Organic","TotalCED") + CED_Grass(FAOSTAT_Countries,"GrassClass2","Organic","TotalCED"))/2);

ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total CED (MJ)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total CED (MJ)","Convent","AllProdCond");

*GWP from CED:
ActCropsGrass_Inputs(Regions,Crops,"Total GWP from CED (tCO2e)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Crops)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 GWPFromCED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Convent","TotalCED"));
ActCropsGrass_Inputs(Regions,Crops,"Total GWP from CED (tCO2e)","Convent","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Crops)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 GWPFromCED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Convent","TotalCED"));
ActCropsGrass_Inputs(Regions,Crops,"Total GWP from CED (tCO2e)","Organic","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Crops)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 GWPFromCED_Crops(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Organic","TotalCED"));

ActAnimalsHead_Inputs(Regions,Livestock,"AllAndAverageTypes","Total GWP from CED (tCO2e)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Livestock)),
                 GWPFromCED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,"Convent","TotalCED"));
ActAnimalsHead_Inputs(Regions,Livestock,"AllAndAverageTypes","Total GWP from CED (tCO2e)","Convent","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Livestock)),
                 GWPFromCED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,"Convent","TotalCED"));
ActAnimalsHead_Inputs(Regions,Livestock,"AllAndAverageTypes","Total GWP from CED (tCO2e)","Organic","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Livestock)),
                 GWPFromCED_Animals(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,"Organic","TotalCED"));

ActAnimalsHead_Inputs(Regions,"Cattle",CattleTypeInHerd,"Total GWP from CED (tCO2e)",ProductionSystems,"AllProdCond")
         = ActAnimalsHead_Inputs(Regions,"Cattle","AllAndAverageTypes","Total GWP from CED (tCO2e)",ProductionSystems,"AllProdCond");
ActAnimalsHead_Inputs(Regions,"Pigs",PigTypeInHerd,"Total GWP from CED (tCO2e)",ProductionSystems,"AllProdCond")
         = ActAnimalsHead_Inputs(Regions,"Pigs","AllAndAverageTypes","Total GWP from CED (tCO2e)",ProductionSystems,"AllProdCond");

*and for grass activities:
*grassland yields are the average from grassland calss 1 and 2 - and if those are not available, of class 3 and 4 - thus do the same for the CED values:
ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total GWP from CED (tCO2e)","Convent","AllProdCond")
         = sum((FAOSTAT_Countries,ErbEtAl_GrasslandDataCountryList)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Countries)
                         AND MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Countries)
                         AND (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass3") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass4") > 0)
                         AND (NOT (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2")))),
                 (GWPFromCED_Grass(FAOSTAT_Countries,"GrassClass3","Convent","TotalCED") + GWPFromCED_Grass(FAOSTAT_Countries,"GrassClass4","Convent","TotalCED"))/2);

ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total GWP from CED (tCO2e)","Convent","AllProdCond")
         = sum((FAOSTAT_Countries,ErbEtAl_GrasslandDataCountryList)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Countries)
                         AND MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Countries)
                         AND (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2") > 0)),
                 (GWPFromCED_Grass(FAOSTAT_Countries,"GrassClass1","Convent","TotalCED") + GWPFromCED_Grass(FAOSTAT_Countries,"GrassClass2","Convent","TotalCED"))/2);

ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total GWP from CED (tCO2e)","Organic","AllProdCond")
         = sum((FAOSTAT_Countries,ErbEtAl_GrasslandDataCountryList)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Countries)
                         AND MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Countries)
                         AND (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass3") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass4") > 0)
                         AND (NOT (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2")))),
                 (GWPFromCED_Grass(FAOSTAT_Countries,"GrassClass3","Organic","TotalCED") + GWPFromCED_Grass(FAOSTAT_Countries,"GrassClass4","Organic","TotalCED"))/2);

ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total GWP from CED (tCO2e)","Organic","AllProdCond")
         = sum((FAOSTAT_Countries,ErbEtAl_GrasslandDataCountryList)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Countries)
                         AND MatchErbEtAlCountryList_SOLmCountryList(ErbEtAl_GrasslandDataCountryList,Countries)
                         AND (ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass1") + ErbEtAl_GrasslandArea(ErbEtAl_GrasslandDataCountryList,"Grassclass2") > 0)),
                 (GWPFromCED_Grass(FAOSTAT_Countries,"GrassClass1","Organic","TotalCED") + GWPFromCED_Grass(FAOSTAT_Countries,"GrassClass2","Organic","TotalCED"))/2);

ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total GWP from CED (tCO2e)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Inputs(Countries,CoreGrassActivities,"Total GWP from CED (tCO2e)","Convent","AllProdCond");

$ontext;
After this we have the following in SOLm-entities:

where:
Regions              is      FAOSTAT_Countries
ProductionSytems     is      "Convent", "Organic", "AllProdSyst"

ActCropsGrass_Inputs(Regions,Crops,"Total CED (MJ)",ProductionSytems,"AllProdCond")
ActCropsGrass_Inputs(Regions,CoreGrassActivities,"Total CED (MJ)",ProductionSytems,"AllProdCond")
ActAnimalsHead_Inputs(Regions,Livestock,"AllAndAverageTypes","Total CED (MJ)",ProductionSytems,"AllProdCond")

ActCropsGrass_Inputs(Regions,Crops,"Total GWP from CED (tCO2e)",ProductionSytems,"AllProdCond")
ActCropsGrass_Inputs(Regions,CoreGrassActivities,"Total GWP from CED (tCO2e)",ProductionSytems,"AllProdCond")
ActAnimalsHead_Inputs(Regions,Livestock,"AllAndAverageTypes","Total GWP from CED (tCO2e)",ProductionSytems,"AllProdCond")
$offtext;


