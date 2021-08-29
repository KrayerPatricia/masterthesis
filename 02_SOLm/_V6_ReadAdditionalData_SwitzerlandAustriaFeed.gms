PUTCLOSE con,"_V6_ReadAdditionalData_SwitzerlandAustriaFeed";

*GENERAL DESCRIPTION
*This file contains the code to read more detailed feed data for Switzerland and Austria


*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Define, load, etc. Swiss and Austrian feed data
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
*1) Define, load, etc. Swiss and Austrian feed data
*1.1) Define sets, variables and parameters and load data
*the following reads and organises the feed data for the Alpenprojekt:

SET FeedUnits_Alpenprojekt
                 /
                 'Futtermittel total'
                 'Marktfähige Futtermittel'
                 'Futtermittel pflanzlichen Ursprung'
                 'Getreide (Körner)'
                 'Reis (Bruch-)'
                 'Getrocknete Hülsenfrüchte (Körner)'
                 'Kartoffeln (Knollen)'
                 Zucker
                 'Pflanzliche Fette und Öle (unverarbeitet)'
                 'Grünfutter verarbeitet'
                 'Maniok (inbegr. Tapioka)'
                 'Andere Produkte pflanzlichen Ursprungs'
                 'Nebenerzeugnisse aus Verarbeitung'
                 'Nebenerzeugnisse der Müllerei'
                 'Nebenerzeugnisse der Brauerei'
                 'Nebenerzeugnisse der Stärkeherstellung'
                 'Nebenerzeugnisse der Zuckerherstellung'
                 'Nebenerzeugnisse der Ölherstellung (Ölkuchen)'
                 'Andere Nebenerzeugnisse'
                 'Futtermittel tierischen Ursprungs'
                 'Verarbeitung von Seetieren'
                 'Verarbeitung von Landtieren'
                 'Tierische Fette und Öle'
                 'Milch und Milchprodukte'
                 'Futtermittel in der Regel nicht marktfähig'
                 'Einjähriger Futterbau'
                 'Hackfrüchte'
                 'Grünmais'
                 'Mehrjähriger Futterbau (temporär und dauerhaft)'
                 Kuppelprodukte
                 'Stroh und Spreu'
                 'Blätter und Köpfe'
                 'Andere Kuppelprodukte'
                 'An anderer Stelle nicht genannte Futtermittel'
                 'Gemüse'
                 Obst
                 'Abfälle (übrige)'
                 'Andere an anderer Stelle nicht genannte Futtermitt'
                 Category_FeedBasics
                 Category_MarketableFeed
                 Category_MarketableFeed_Plants
                 Category_MarketableFeed_CoProducts
                 Category_MarketableFeed_Animals
                 Category_NonMarketableFeed
                 Category_NonMarketableFeed_Annual
                 Category_NonMarketableFeed_CoProducts
                 Category_NonMarketableFeed_Others
                 Category_PerennialFeed
                 Category_AllFeed
                 'Barley and products',
                 Triticale
                 'Wheat and products'
                 Peas
                 'Potatoes and products'
                 'Soyabean Cake'
                 'Maize and products'
                 'Sunflower Seed'
                 Oats
                 'Rye and products'
                 Spelt
                 Beans
                 /;
SET OrganicFeedCereals_Alpenprojekt(FeedUnits_Alpenprojekt)
                 /
                 'Barley and products',
                 Triticale
                 'Wheat and products'
                 'Maize and products'
                 Oats
                 'Rye and products'
                 Spelt
                 /;



*0                 'Futtermittel total'
SET FeedBasics_Alpenprojekt(FeedUnits_Alpenprojekt)
                 /
                 'Getreide (Körner)'
                 'Reis (Bruch-)'
                 'Getrocknete Hülsenfrüchte (Körner)'
                 'Kartoffeln (Knollen)'
                 Zucker
                 'Pflanzliche Fette und Öle (unverarbeitet)'
                 'Grünfutter verarbeitet'
                 'Maniok (inbegr. Tapioka)'
                 'Andere Produkte pflanzlichen Ursprungs'
                 'Nebenerzeugnisse der Müllerei'
                 'Nebenerzeugnisse der Brauerei'
                 'Nebenerzeugnisse der Stärkeherstellung'
                 'Nebenerzeugnisse der Zuckerherstellung'
                 'Nebenerzeugnisse der Ölherstellung (Ölkuchen)'
                 'Andere Nebenerzeugnisse'
                 'Verarbeitung von Seetieren'
                 'Verarbeitung von Landtieren'
                 'Tierische Fette und Öle'
                 'Milch und Milchprodukte'
                 'Hackfrüchte'
                 'Grünmais'
                 'Mehrjähriger Futterbau (temporär und dauerhaft)'
                 'Stroh und Spreu'
                 'Blätter und Köpfe'
                 'Andere Kuppelprodukte'
                 'Gemüse'
                 Obst
                 'Abfälle (übrige)'
                 'Andere an anderer Stelle nicht genannte Futtermitt'

                 'Barley and products',
                 Triticale
                 'Wheat and products'
                 Peas
                 'Potatoes and products'
                 'Soyabean Cake'
                 'Maize and products'
                 'Sunflower Seed'
                 Oats
                 'Rye and products'
                 Spelt
                 Beans
                 /;

*11                 'Futtermittel pflanzlichen Ursprung'
SET MarketableFeed_Plants_Alpenprojekt(FeedUnits_Alpenprojekt)
                 /
                 'Getreide (Körner)'
                 'Reis (Bruch-)'
                 'Getrocknete Hülsenfrüchte (Körner)'
                 'Kartoffeln (Knollen)'
                 Zucker
                 'Pflanzliche Fette und Öle (unverarbeitet)'
                 'Grünfutter verarbeitet'
                 'Maniok (inbegr. Tapioka)'
                 'Andere Produkte pflanzlichen Ursprungs'
                 /;
*12                 'Nebenerzeugnisse aus Verarbeitung'
SET MarketableFeed_CoProducts_Alpenprojekt(FeedUnits_Alpenprojekt)
                 /
                 'Nebenerzeugnisse der Müllerei'
                 'Nebenerzeugnisse der Brauerei'
                 'Nebenerzeugnisse der Stärkeherstellung'
                 'Nebenerzeugnisse der Zuckerherstellung'
                 'Nebenerzeugnisse der Ölherstellung (Ölkuchen)'
                 'Andere Nebenerzeugnisse'
                 /;
*13                 'Futtermittel tierischen Ursprungs'
SET MarketableFeed_Animals_Alpenprojekt(FeedUnits_Alpenprojekt)
                 /
                 'Verarbeitung von Seetieren'
                 'Verarbeitung von Landtieren'
                 'Tierische Fette und Öle'
                 'Milch und Milchprodukte'
                 /;

*1                 'Marktfähige Futtermittel'
SET MarketableFeed_Alpenprojekt(FeedUnits_Alpenprojekt);
MarketableFeed_Alpenprojekt(FeedUnits_Alpenprojekt)
         = MarketableFeed_Plants_Alpenprojekt(FeedUnits_Alpenprojekt)
                 + MarketableFeed_CoProducts_Alpenprojekt(FeedUnits_Alpenprojekt)
                 + MarketableFeed_Animals_Alpenprojekt(FeedUnits_Alpenprojekt);

**22                 'Mehrjähriger Futterbau (temporär und dauerhaft)'
SET PerennialFeed_Alpenprojekt(FeedUnits_Alpenprojekt)
                 /
                 'Mehrjähriger Futterbau (temporär und dauerhaft)'
                 /;

*21                 'Einjähriger Futterbau'
SET NonMarketableFeed_Annual_Alpenprojekt(FeedUnits_Alpenprojekt)
                 /
                 'Hackfrüchte'
                 'Grünmais'
                 /;
*23                 Kuppelprodukte
SET NonMarketableFeed_CoProducts_Alpenprojekt(FeedUnits_Alpenprojekt)
                 /
                 'Stroh und Spreu'
                 'Blätter und Köpfe'
                 'Andere Kuppelprodukte'
                 /;
*24                 'An anderer Stelle nicht genannte Futtermittel'
SET NonMarketableFeed_Others_Alpenprojekt(FeedUnits_Alpenprojekt)
                 /
                 'Gemüse'
                 Obst
                 'Abfälle (übrige)'
                 'Andere an anderer Stelle nicht genannte Futtermitt'
                 /;

*2                 'Futtermittel in der Regel nicht marktfähig'
SET NonMarketableFeed_Alpenprojekt(FeedUnits_Alpenprojekt);
NonMarketableFeed_Alpenprojekt(FeedUnits_Alpenprojekt)
         = NonMarketableFeed_Annual_Alpenprojekt(FeedUnits_Alpenprojekt)
                 + NonMarketableFeed_CoProducts_Alpenprojekt(FeedUnits_Alpenprojekt)
                 +  NonMarketableFeed_Others_Alpenprojekt(FeedUnits_Alpenprojekt);


SET ConcentratesTotal_Alpenprojekt(FeedUNits_Alpenprojekt)
                 /
                 'Getreide (Körner)'
                 'Reis (Bruch-)'
                 'Getrocknete Hülsenfrüchte (Körner)'
                 'Kartoffeln (Knollen)'
                 Zucker
                 'Pflanzliche Fette und Öle (unverarbeitet)'
                 'Grünfutter verarbeitet'
                 'Maniok (inbegr. Tapioka)'
                 'Andere Produkte pflanzlichen Ursprungs'
                 'Nebenerzeugnisse der Müllerei'
                 'Nebenerzeugnisse der Brauerei'
                 'Nebenerzeugnisse der Stärkeherstellung'
                 'Nebenerzeugnisse der Zuckerherstellung'
                 'Nebenerzeugnisse der Ölherstellung (Ölkuchen)'
                 'Andere Nebenerzeugnisse'
                 'Verarbeitung von Seetieren'
                 'Verarbeitung von Landtieren'
                 'Tierische Fette und Öle'
                 'Milch und Milchprodukte'
                 'Hackfrüchte'

                 'Barley and products',
                 Triticale
                 'Wheat and products'
                 Peas
                 'Potatoes and products'
                 'Soyabean Cake'
                 'Maize and products'
                 'Sunflower Seed'
                 Oats
                 'Rye and products'
                 Spelt
                 Beans
                 /;

SET ConcentratesFromByprod_Alpenprojekt(FeedUNits_Alpenprojekt)
                 /
                 'Nebenerzeugnisse der Müllerei'
                 'Nebenerzeugnisse der Brauerei'
                 'Nebenerzeugnisse der Stärkeherstellung'
                 'Nebenerzeugnisse der Zuckerherstellung'
                 'Nebenerzeugnisse der Ölherstellung (Ölkuchen)'
                 'Andere Nebenerzeugnisse'
                 'Verarbeitung von Seetieren'
                 'Verarbeitung von Landtieren'
                 'Tierische Fette und Öle'
                 'Milch und Milchprodukte'
                 /;

SET ConcMainAndByprod_Alpenprojekt(FeedUNits_Alpenprojekt) Concentrates that potentially include some main and some byproducts (e.g. milk poweder and whey - or waste from seafood and fishmeal
                 /
                 'Verarbeitung von Seetieren'
                 'Verarbeitung von Landtieren'
                 'Tierische Fette und Öle'
                 'Milch und Milchprodukte'
                 /;

SET ForageCrops_Alpenprojekt(FeedUNits_Alpenprojekt)
                 /
                 'Grünmais'
                 /;
SET Grass_Alpenprojekt(FeedUNits_Alpenprojekt)
                 /
                 'Mehrjähriger Futterbau (temporär und dauerhaft)'
                 /;
SET Residues_Alpenprojekt(FeedUNits_Alpenprojekt)
                 /
                 'Stroh und Spreu'
                 'Blätter und Köpfe'
                 'Andere Kuppelprodukte'
                 'Gemüse'
                 Obst
                 'Abfälle (übrige)'
                 'Andere an anderer Stelle nicht genannte Futtermitt'
                 /;


*units needed are Quantity, DM_Quantity, GE, XP, these are already part of the set Units_Alpenprojekt defined earlier
SET FeedOrigin_Alpenprojekt
                 /
                 Import
                 DomesticProduction
                 CoProdFromProcessedImportedFood
                 Total
                 /;

*this is DOMESTICALLY AVAILABLE quant, GE, XP - i.e. exports are deduced;
*first: parameters for loading data, then combine with additional dimension for the year:
PARAMETER Feed_Alpenprojekt2011(FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT)
PARAMETER Feed_Alpenprojekt2012(FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT)
PARAMETER Feed_Alpenprojekt2013(FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT)
PARAMETER Feed_Alpenprojekt_Bio(FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT)
PARAMETER Feed_Alpenprojekt_Austria(FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT)
PARAMETER Feed_Alpenprojekt(Regions,FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT,ProductionSystems) feed for the Alpenproject - tons and GE and XP and some shares;

$ifthen %IncludeExcel_SwissAustriaFeedData% == "YES"
$call GDXXRW SES_2014_0401-05_Futtermittelbilanz_EN.xlsx  o=SwissAustriaFeedData.gdx  index=index!a1
*contains the data from the Grundlagenbericht 2014, Switzerland, and Feed DAQ supply from Austria
$endif;

*load parameters
*SES_2014_0401-05 Futtermittelbilanz_EN.xlsx -> SwissFeedData.gdx
$GDXIN SwissAustriaFeedData.gdx
$load Feed_Alpenprojekt2011
$load Feed_Alpenprojekt2012
$load Feed_Alpenprojekt2013
$load Feed_Alpenprojekt_Bio
$load Feed_Alpenprojekt_Austria
$GDXIN SwissAustriaFeedData.gdx

*take the mean from these 3 years:
*this time not conditional to 0 values, as these can be real zeroes, thus important to be retained in the average.
Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT,"AllProdSyst")
         = (Feed_Alpenprojekt2011(FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT)
                 + Feed_Alpenprojekt2012(FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT)
                 + Feed_Alpenprojekt2013(FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT))/3;

Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT,"Organic")
         = Feed_Alpenprojekt_Bio(FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT);

Feed_Alpenprojekt("Austria",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT,"AllProdSyst")
         = Feed_Alpenprojekt_Austria(FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT);


*assign values for DM, GE, XP contents:
*DM is in tons, GE in Terajoule, XP in tons
*thus, convert GE from TJ to MJ, i.e. multiply by 1000000
Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"GE",ProductionSystems)
         = Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"GE",ProductionSystems)*1000000;

*unit: share in total (i.e. tons per ton, i.e. percentages/100)
Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"DM_Contents",ProductionSystems)
                 $Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"Quantity",ProductionSystems)
         = Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"DM_Quantity",ProductionSystems)
                 /Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"Quantity",ProductionSystems);
*unit is MJ/ton
Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"GE_Contents",ProductionSystems)
                 $Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"Quantity",ProductionSystems)
         = Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"GE",ProductionSystems)
                 /Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"Quantity",ProductionSystems);
*unit is ton/ton
Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"XP_Contents",ProductionSystems)
                 $Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"Quantity",ProductionSystems)
         = Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"XP",ProductionSystems)
                 /Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"Quantity",ProductionSystems);
*unit is MJ/ton
Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"GE_DM_Contents",ProductionSystems)
                 $Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"DM_Quantity",ProductionSystems)
         = Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"GE",ProductionSystems)
                 /Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"DM_Quantity",ProductionSystems);
*unit is ton/ton
Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"XP_DM_Contents",ProductionSystems)
                 $Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"DM_Quantity",ProductionSystems)
         = Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"XP",ProductionSystems)
                 /Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"DM_Quantity",ProductionSystems);

*Assign DM, GE and XP contents to organic values, based on average values:
Feed_Alpenprojekt("Switzerland",OrganicFeedCereals_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"Organic")
         = Feed_Alpenprojekt("Switzerland","Getreide (Körner)",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdSyst");


*assign values for contents for conventional to organic feed:
Feed_Alpenprojekt("Switzerland","Peas",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"Organic")
         = Feed_Alpenprojekt("Switzerland","Getrocknete Hülsenfrüchte (Körner)",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdSyst");
Feed_Alpenprojekt("Switzerland","Beans",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"Organic")
         = Feed_Alpenprojekt("Switzerland","Getrocknete Hülsenfrüchte (Körner)",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdSyst");
Feed_Alpenprojekt("Switzerland","Sunflower Seed",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"Organic")
         = Feed_Alpenprojekt("Switzerland","Nebenerzeugnisse der Ölherstellung (Ölkuchen)",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdSyst");
Feed_Alpenprojekt("Switzerland","Potatoes and products",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"Organic")
         = Feed_Alpenprojekt("Switzerland","Nebenerzeugnisse der Stärkeherstellung",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdSyst");
Feed_Alpenprojekt("Switzerland","Soyabean cake",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"Organic")
         = Feed_Alpenprojekt("Switzerland","Nebenerzeugnisse der Ölherstellung (Ölkuchen)",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdSyst");

*we do not have data on organic forage - thus take the Grünmais "all" for nutrient contents, and later assign shares org/conv according to shares for "Maize For Forage+Silage" in Swiss data from the global model
Feed_Alpenprojekt("Switzerland","Grünmais",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"Organic")
         = Feed_Alpenprojekt("Switzerland","Grünmais",FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdSyst");


*assign contents from Switzerland to Austria; there, we have only ProductionSystems = "AllProdsyst", thus do it for organic and convent and "AllProdsyst" to "all"
Feed_Alpenprojekt("Austria",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdsyst")
                 $Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"Organic")
         = Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"Organic");
Feed_Alpenprojekt("Austria",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdsyst")
                 $Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdsyst")
         = Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdsyst");
Feed_Alpenprojekt("Austria",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"AllProdsyst")
                 $Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"Convent")
         = Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,"Convent");


*and derive the DM, GE and XP quantities for AT from Quantity and contents:
SET Match_TotalsContents_Feed(Units_CH_AT,NutrientContents_CH_AT)
/
DM_Quantity.DM_Contents
GE.GE_Contents
XP.XP_Contents
/
;

Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT,ProductionSystems)
                 $(NOT Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT,ProductionSystems))
         = SUM(NutrientContents_CH_AT$Match_TotalsContents_Feed(Units_CH_AT,NutrientContents_CH_AT),
                 Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,ProductionSystems)
                         *Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"Quantity",ProductionSystems));

Feed_Alpenprojekt("Austria",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT,ProductionSystems)
                 $(NOT Feed_Alpenprojekt("Austria",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_CH_AT,ProductionSystems))
         = SUM(NutrientContents_CH_AT$Match_TotalsContents_Feed(Units_CH_AT,NutrientContents_CH_AT),
                 Feed_Alpenprojekt("Austria",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,NutrientContents_CH_AT,ProductionSystems)
                         *Feed_Alpenprojekt("Austria",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,"Quantity",ProductionSystems));


*Check for the importance of the various feedstuffs:
*not used further down

Set FeedUnitLinkedToShares(Units_FeedAlpenprojekt_ShareInTotal,Units_FeedAlpenprojekt)
/
QuantityShare.Quantity
DM_Quantity_Share.DM_Quantity
GE_Share.GE
XP_Share.XP
/
;

alias(FeedBasics_Alpenprojekt,FeedBasics_Alpenprojekt2,FeedBasics_Alpenprojekt3);

Feed_Alpenprojekt("Switzerland",FeedBasics_Alpenprojekt,"Total",Units_FeedAlpenprojekt_ShareInTotal,"AllProdSyst")
                 $Sum((FeedBasics_Alpenprojekt3,Units_FeedAlpenprojekt)
                         $FeedUnitLinkedToShares(Units_FeedAlpenprojekt_ShareInTotal,Units_FeedAlpenprojekt),Feed_Alpenprojekt("Switzerland",FeedBasics_Alpenprojekt3,"Total",Units_FeedAlpenprojekt,"AllProdSyst"))
         = Sum(Units_FeedAlpenprojekt$FeedUnitLinkedToShares(Units_FeedAlpenprojekt_ShareInTotal,Units_FeedAlpenprojekt),Feed_Alpenprojekt("Switzerland",FeedBasics_Alpenprojekt,"Total",Units_FeedAlpenprojekt,"AllProdSyst")
                 /Sum(FeedBasics_Alpenprojekt2,Feed_Alpenprojekt("Switzerland",FeedBasics_Alpenprojekt2,"Total",Units_FeedAlpenprojekt,"AllProdSyst")) );


*1.2) Assign data to SOLm entities

SET LinkFeedBasics_Alpenprojekt_Commodities(FeedUnits_Alpenprojekt,Commodities)
*those omitted are anyway unimportant
/
'Getreide (Körner)'."Cereals - Excluding beer"
'Reis (Bruch-)'."Rice, Broken"
'Getrocknete Hülsenfrüchte (Körner)'.Pulses
'Kartoffeln (Knollen)'.Potatoes
Zucker."Sugar Raw Centrifugal"
'Pflanzliche Fette und Öle (unverarbeitet)'."Vegetable oils"
'Grünfutter verarbeitet'."Forage products"
'Maniok (inbegr. Tapioka)'.Cassava
*'Andere Produkte pflanzlichen Ursprungs'
'Nebenerzeugnisse der Müllerei'.Brans
'Nebenerzeugnisse der Brauerei'."Dregs from brewing, distillation"
'Nebenerzeugnisse der Stärkeherstellung'."Maize Gluten"
'Nebenerzeugnisse der Zuckerherstellung'.Molasses
'Nebenerzeugnisse der Ölherstellung (Ölkuchen)'."Cakes, Oilseeds Nes"
*'Andere Nebenerzeugnisse'
*'Verarbeitung von Seetieren'
*'Verarbeitung von Landtieren'
'Tierische Fette und Öle'."Animal fats"
'Milch und Milchprodukte'."Milk, whole fresh cow"
'Hackfrüchte'."Roots and tubers, nes"
'Grünmais'."Maize For Forage+Silage"
'Mehrjähriger Futterbau (temporär und dauerhaft)'.Grass
'Stroh und Spreu'."Straw husks"
*'Blätter und Köpfe'
*'Andere Kuppelprodukte'
'Gemüse'.Vegetables
Obst."Fruits - Excluding Wine"
*'Abfälle (übrige)'
*'Andere an anderer Stelle nicht genannte Futtermitt'

'Barley and products'.'Barley and products'
Triticale.Triticale
'Wheat and products'.'Wheat and products'
Peas.Peas
'Potatoes and products'.'Potatoes and products'
'Soyabean Cake'.'Soyabean Cake'
'Maize and products'.'Maize and products'
'Sunflower Seed'.'Sunflower Seed'
Oats.Oats
'Rye and products'.'Rye and products'
Spelt.Spelt
Beans.Beans
/;

Set Subset_Feed_CH_AT_Commodities(Commodities)
/
"Cereals - Excluding beer"
"Rice, Broken"
Pulses
Potatoes
"Sugar Raw Centrifugal"
"Vegetable oils"
"Forage products"
Cassava
Brans
"Dregs from brewing, distillation"
"Maize Gluten"
Molasses
"Cakes, Oilseeds Nes"
"Animal fats"
"Milk, whole fresh cow"
"Roots and tubers, nes"
"Maize For Forage+Silage"
Grass
"Straw husks"
Vegetables
"Fruits - Excluding Wine"

'Barley and products'
Triticale
'Wheat and products'
Peas
'Potatoes and products'
'Soyabean Cake'
'Maize and products'
'Sunflower Seed'
Oats
'Rye and products'
Spelt
Beans
/;

Set LinkFeedUnitsAlpenprojekt_SOLmContents(Contents,NutrientContents_CH_AT)
/
"FeedGE (MJ)".GE_Contents
"FeedXP (t)".XP_Contents
"DM (t)".DM_Contents
"FeedGE in DM (MJ)".GE_DM_Contents
"FeedXP in DM (t)".XP_DM_Contents
/;


*apply for Subset_Feed_CH_AT_Commodities only, otherwise it ovewrites values for other commodities with zero
Commod_Contents(Regions_Switzerland,Subset_Feed_CH_AT_Commodities,Contents,ProductionSystems,"AllProdCond")
         = Sum((NutrientContents_CH_AT,FeedUnits_Alpenprojekt)$(LinkFeedUnitsAlpenprojekt_SOLmContents(Contents,NutrientContents_CH_AT)
                         AND LinkFeedBasics_Alpenprojekt_Commodities(FeedUnits_Alpenprojekt,Subset_Feed_CH_AT_Commodities)),
                 Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,"Total",NutrientContents_CH_AT,ProductionSystems));

Commod_Contents(Regions_Austria,Subset_Feed_CH_AT_Commodities,Contents,ProductionSystems,"AllProdCond")
         = Sum((NutrientContents_CH_AT,FeedUnits_Alpenprojekt)$(LinkFeedUnitsAlpenprojekt_SOLmContents(Contents,NutrientContents_CH_AT)
                         AND LinkFeedBasics_Alpenprojekt_Commodities(FeedUnits_Alpenprojekt,Subset_Feed_CH_AT_Commodities)),
                 Feed_Alpenprojekt("Austria",FeedUnits_Alpenprojekt,"Total",NutrientContents_CH_AT,ProductionSystems));

*assign feed utilization 100% to feed commodities, where this is yet missing:
Commod_OtherChar("Switzerland",Subset_Feed_CH_AT_Commodities,"Util feed (share)","AllProdSyst","AllProdCond")
                 $(NOT Commod_OtherChar("Switzerland",Subset_Feed_CH_AT_Commodities,"Util feed (share)","AllProdSyst","AllProdCond"))
         = sum(FeedUnits_Alpenprojekt$LinkFeedBasics_Alpenprojekt_Commodities(FeedUnits_Alpenprojekt,Subset_Feed_CH_AT_Commodities),
                 1);
Commod_OtherChar(Regions_Switzerland,Subset_Feed_CH_AT_Commodities,"Util feed (share)","AllProdSyst","AllProdCond")
                 $(NOT Commod_OtherChar(Regions_Switzerland,Subset_Feed_CH_AT_Commodities,"Util feed (share)","AllProdSyst","AllProdCond"))
         = sum(FeedUnits_Alpenprojekt$LinkFeedBasics_Alpenprojekt_Commodities(FeedUnits_Alpenprojekt,Subset_Feed_CH_AT_Commodities),
                 1);

Commod_OtherChar("Austria",Subset_Feed_CH_AT_Commodities,"Util feed (share)","AllProdSyst","AllProdCond")
                 $(NOT Commod_OtherChar("Austria",Subset_Feed_CH_AT_Commodities,"Util feed (share)","AllProdSyst","AllProdCond"))
         = sum(FeedUnits_Alpenprojekt$LinkFeedBasics_Alpenprojekt_Commodities(FeedUnits_Alpenprojekt,Subset_Feed_CH_AT_Commodities),
                 1);
Commod_OtherChar(Regions_Austria,Subset_Feed_CH_AT_Commodities,"Util feed (share)","AllProdSyst","AllProdCond")
                 $(NOT Commod_OtherChar(Regions_Austria,Subset_Feed_CH_AT_Commodities,"Util feed (share)","AllProdSyst","AllProdCond"))
         = sum(FeedUnits_Alpenprojekt$LinkFeedBasics_Alpenprojekt_Commodities(FeedUnits_Alpenprojekt,Subset_Feed_CH_AT_Commodities),
                 1);

*we have better data for temp and perm meadows and pastures for org/conv - thus drop the AllProdSyst data for this that come from the general default data:
Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","FeedME (MJ)","AllProdSyst","AllProdCond") = 0;
Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","FeedXP (t)","AllProdSyst","AllProdCond") = 0;
Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","FeedME (MJ)","AllProdSyst","AllProdCond") = 0;
Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","FeedXP (t)","AllProdSyst","AllProdCond") = 0;

Commod_Contents(Regions_Austria,"Temporary meadows and pastures","FeedME (MJ)","AllProdSyst","AllProdCond") = 0;
Commod_Contents(Regions_Austria,"Temporary meadows and pastures","FeedXP (t)","AllProdSyst","AllProdCond") = 0;
Commod_Contents(Regions_Austria,"Permanent meadows and pastures","FeedME (MJ)","AllProdSyst","AllProdCond") = 0;
Commod_Contents(Regions_Austria,"Permanent meadows and pastures","FeedXP (t)","AllProdSyst","AllProdCond") = 0;

*and replace the default GE values by values derived from ME:
*use the gross relation ME = GE*0.65, cf. _V6_ReadData_VariousSources_MainOutputNutrientContentsData
Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","FeedGE (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")/0.65;
Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","FeedGE (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")/0.65;
Commod_Contents(Regions_Switzerland,"alpine pastures","FeedGE (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Switzerland,"alpine pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")/0.65;
Commod_Contents(Regions_Austria,"Temporary meadows and pastures","FeedGE (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Austria,"Temporary meadows and pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")/0.65;
Commod_Contents(Regions_Austria,"Permanent meadows and pastures","FeedGE (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Austria,"Permanent meadows and pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")/0.65;
Commod_Contents(Regions_Austria,"alpine pastures","FeedGE (MJ)",ProductionSystems,"AllProdCond")
         = Commod_Contents(Regions_Austria,"alpine pastures","FeedME (MJ)",ProductionSystems,"AllProdCond")/0.65;

*in consequence, we now have also better FeedGE data for temp and perm meadows and pastures for org/conv - thus drop the AllProdSyst data for this that come from the general default data:
Commod_Contents(Regions_Switzerland,"Temporary meadows and pastures","FeedGE (MJ)","AllProdSyst","AllProdCond") = 0;
Commod_Contents(Regions_Switzerland,"Permanent meadows and pastures","FeedGE (MJ)","AllProdSyst","AllProdCond") = 0;
Commod_Contents(Regions_Austria,"Temporary meadows and pastures","FeedGE (MJ)","AllProdSyst","AllProdCond") = 0;
Commod_Contents(Regions_Austria,"Permanent meadows and pastures","FeedGE (MJ)","AllProdSyst","AllProdCond") = 0;



VCommod_Feed.l("Switzerland",Subset_Feed_CH_AT_Commodities,ProductionSystems,"AllProdCond")
         = sum(FeedUnits_Alpenprojekt$LinkFeedBasics_Alpenprojekt_Commodities(FeedUnits_Alpenprojekt,Subset_Feed_CH_AT_Commodities),
                 Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,"Total","Quantity",ProductionSystems));

VCommod_Feed.l("Austria",Subset_Feed_CH_AT_Commodities,ProductionSystems,"AllProdCond")
         = sum(FeedUnits_Alpenprojekt$LinkFeedBasics_Alpenprojekt_Commodities(FeedUnits_Alpenprojekt,Subset_Feed_CH_AT_Commodities),
                 Feed_Alpenprojekt("Austria",FeedUnits_Alpenprojekt,"Total","Quantity",ProductionSystems));




$exit;

Import
DomesticProduction
CoProdFromProcessedImportedFood
Total



use only this: total - import share to be added/used later only? YES!



Set LinkFeedUnitsAlpenprojekt_CommodityBalancesSOLmTotal(CommodityBalancesTotalsVariable,FeedOrigin_Alpenprojekt,Units_Alpenprojekt)
/
"Domest Avail Quant (t)".Total.Quantity
"Domest Avail Quant DM (t)".Total.DM_Quantity
"FeedGE (MJ)".Total.GE
"FeedXP (t)".Total.XP
*and, as for feed utilization is 100% feed:
"Feed (t)".Total.Quantity
"Feed DM (t)".Total.DM_Quantity

"FeedGE, domestic prod. (MJ)".DomesticProduction.GE
"FeedXP, domestic prod. (t)".DomesticProduction.XP
"Feed, domestic prod. (t)".DomesticProduction.Quantity
"FeedGE, imported (MJ)".Import.GE
"FeedXP, imported (t)".Import.XP
"Feed, imported (t)".Import.Quantity
"FeedGE, process. byprod. from imports (MJ)".CoProdFromProcessedImportedFood.GE
"FeedXP, process. byprod. from imports (t)".CoProdFromProcessedImportedFood.XP
"Feed, process. byprod. from imports (t)".CoProdFromProcessedImportedFood.Quantity
/;

Set FeedForCommodityBalancesTotalsVariable_Alpenprojekt(CommodityBalancesTotalsVariable)
/
"Domest Avail Quant (t)"
"Domest Avail Quant DM (t)"
"FeedGE (MJ)"
"FeedXP (t)"
"Feed (t)"
"Feed DM (t)"
"FeedGE, domestic prod. (MJ)"
"FeedXP, domestic prod. (t)"
"Feed, domestic prod. (t)"
"FeedGE, imported (MJ)"
"FeedXP, imported (t)"
"Feed, imported (t)"
"FeedGE, process. byprod. from imports (MJ)"
"FeedXP, process. byprod. from imports (t)"
"Feed, process. byprod. from imports (t)"
/;

*first, drop any feed information that is already available from the global data:
TotalsCommodityBalances.l("Switzerland",CommodityBalancesUnits,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,ProductionSystems,"All","Baseline")
         = 0;
TotalsCommodityBalances.l("Austria",CommodityBalancesUnits,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,ProductionSystems,"All","Baseline")
         = 0;

*allocate total swiss feed suply by division by 3 to the regions
*TotalsCommodityBalances.l(SET_RegionsSwitzerland,FeedUnits_Alpenprojekt,OutputType,CommodityBalancesTotalsVariable,ProductionSystems,"All","Baseline")
*         = Sum((FeedOrigin_Alpenprojekt,Units_Alpenprojekt)$(LinkFeedUnitsAlpenprojekt_CommodityBalancesSOLmTotal(CommodityBalancesTotalsVariable,FeedOrigin_Alpenprojekt,Units_Alpenprojekt)
*                         AND StructureOutputType_FeedAlpenprojekt(FeedUnits_Alpenprojekt,OutputType)),
*                 Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_Alpenprojekt,ProductionSystems,"Baseline"))/3;
*

*allocate feed as follows: 50% Tal, 30% Huegel, 20% Berg in CH, something similar in AT, then further dividing into the regions assigned to Tal, Huegel, Berg:

Parameter FeedAlpenprojectRegionsShare(GeographicUnits_New);
FeedAlpenprojectRegionsShare("Switzerland_Tal") = 0.5;
FeedAlpenprojectRegionsShare("Switzerland_Huegel") = 0.3;
FeedAlpenprojectRegionsShare("Switzerland_Berg") = 0.2;

FeedAlpenprojectRegionsShare(SET_Austria_Tal) = 0.6/4;
FeedAlpenprojectRegionsShare(SET_Austria_Huegel) = 0.2;
FeedAlpenprojectRegionsShare(SET_Austria_Berg) = 0.2/3;



TotalsCommodityBalances.l(SET_RegionsSwitzerland,FeedUnits_Alpenprojekt,OutputType,CommodityBalancesTotalsVariable,ProductionSystems,"All","Baseline")
         = Sum((FeedOrigin_Alpenprojekt,Units_Alpenprojekt)$(LinkFeedUnitsAlpenprojekt_CommodityBalancesSOLmTotal(CommodityBalancesTotalsVariable,FeedOrigin_Alpenprojekt,Units_Alpenprojekt)
                         AND StructureOutputType_FeedAlpenprojekt(FeedUnits_Alpenprojekt,OutputType)),
                 Feed_Alpenprojekt("Switzerland",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_Alpenprojekt,ProductionSystems,"Baseline"))*FeedAlpenprojectRegionsShare(SET_RegionsSwitzerland);

*Make the code on doing AT, CH etc. more generic, that it works with all regions/subregions, etc. - with mathing sets or so instead of copy/paste!!!
TotalsCommodityBalances.l(SET_RegionsAustria,FeedUnits_Alpenprojekt,OutputType,CommodityBalancesTotalsVariable,ProductionSystems,"All","Baseline")
         = Sum((FeedOrigin_Alpenprojekt,Units_Alpenprojekt)$(LinkFeedUnitsAlpenprojekt_CommodityBalancesSOLmTotal(CommodityBalancesTotalsVariable,FeedOrigin_Alpenprojekt,Units_Alpenprojekt)
                         AND StructureOutputType_FeedAlpenprojekt(FeedUnits_Alpenprojekt,OutputType)),
                 Feed_Alpenprojekt("Austria",FeedUnits_Alpenprojekt,FeedOrigin_Alpenprojekt,Units_Alpenprojekt,ProductionSystems,"Baseline"))*FeedAlpenprojectRegionsShare(SET_RegionsAustria);


*and drop the grass feed data, as we have better data from the grassland module, part Alpenprojekt:
TotalsCommodityBalances.l(SET_RegionsSwitzerland,Grass_Alpenprojekt,"Crop",FeedForCommodityBalancesTotalsVariable_Alpenprojekt,ProductionSystems,"All","Baseline")
         = 0;
*Not needed for AT, as no grassland feed in feed data.

*derive DAQ DM if not yet available
TotalsCommodityBalances.l(GeographicUnits_SubregionsAlpenprojekt,FeedUnits_Alpenprojekt,OutputType,"Domest Avail Quant DM (t)",ProductionSystems,"All","Baseline")
         = TotalsCommodityBalances.l(GeographicUnits_SubregionsAlpenprojekt,FeedUnits_Alpenprojekt,OutputType,"Domest Avail Quant (t)",ProductionSystems,"All","Baseline")
                 *ParameterCommodityBalancesPerTon(GeographicUnits_SubregionsAlpenprojekt,FeedUnits_Alpenprojekt,OutputType,"DM contents (t/t)",ProductionSystems,"All","Baseline");




*XXXXXXXXXXXXXXXXXX    DERIVE GE, ME, XP and DM from quant and contents, if not available!!


*we do not have data on organic forage - for a fast solution, just
*for CH, assume 10% to be organic, as this largely leads to ok animal numbers:
TotalsCommodityBalances.l(SET_RegionsSwitzerland,SET_Aggregate_ForageCrops,OutputType,CommodityBalancesTotalsVariable,"Organic","All","Baseline")
         = TotalsCommodityBalances.l(SET_RegionsSwitzerland,SET_Aggregate_ForageCrops,OutputType,CommodityBalancesTotalsVariable,"All","All","Baseline")*0.1;
*for Austria - check with Simon:
TotalsCommodityBalances.l(SET_RegionsAustria,SET_Aggregate_ForageCrops,OutputType,CommodityBalancesTotalsVariable,"Organic","All","Baseline")
         = TotalsCommodityBalances.l(SET_RegionsAustria,SET_Aggregate_ForageCrops,OutputType,CommodityBalancesTotalsVariable,"All","All","Baseline")*0.1;


*XXXXXXXXXXXXXXXXXXXXXXXXXX go on here assigining AT values .... but how?


*derive imported feed where not yet available (for the organic feed, we only have DAQ and domest prod):
TotalsCommodityBalances.l(SET_RegionsSwitzerland,FeedUnits_Alpenprojekt,OutputType,"Feed, imported (t)",ProductionSystems,"All","Baseline")
                 $(NOT TotalsCommodityBalances.l("Switzerland",FeedUnits_Alpenprojekt,OutputType,"Feed, imported (t)",ProductionSystems,"All","Baseline"))
         = TotalsCommodityBalances.l(SET_RegionsSwitzerland,FeedUnits_Alpenprojekt,OutputType,"Feed (t)",ProductionSystems,"All","Baseline")
                 - TotalsCommodityBalances.l(SET_RegionsSwitzerland,FeedUnits_Alpenprojekt,OutputType,"Feed, domestic prod. (t)",ProductionSystems,"All","Baseline");

*for CH, as we have only all and organic feed, we derive the conventional part as the difference, where possible:
TotalsCommodityBalances.l(SET_RegionsSwitzerland,FeedUnits_Alpenprojekt,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,"Convent","All","Baseline")
                 $TotalsCommodityBalances.l(SET_RegionsSwitzerland,FeedUnits_Alpenprojekt,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,"All","All","Baseline")
         = TotalsCommodityBalances.l(SET_RegionsSwitzerland,FeedUnits_Alpenprojekt,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,"All","All","Baseline")
                 - TotalsCommodityBalances.l(SET_RegionsSwitzerland,FeedUnits_Alpenprojekt,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,"Organic","All","Baseline");
*and set negative values to zero:
TotalsCommodityBalances.l(SET_RegionsSwitzerland,FeedUnits_Alpenprojekt,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,"Convent","All","Baseline")
                 $(TotalsCommodityBalances.l(SET_RegionsSwitzerland,FeedUnits_Alpenprojekt,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,"Convent","All","Baseline") < 0)
         = 0;
*for AT, as we have only "All", we assign org and conv by taking an org share of 10% - just to have some number:
TotalsCommodityBalances.l(SET_RegionsAustria,FeedUnits_Alpenprojekt,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,"Convent","All","Baseline")
         = TotalsCommodityBalances.l(SET_RegionsAustria,FeedUnits_Alpenprojekt,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,"All","All","Baseline")*0.9;
TotalsCommodityBalances.l(SET_RegionsAustria,FeedUnits_Alpenprojekt,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,"Organic","All","Baseline")
         = TotalsCommodityBalances.l(SET_RegionsAustria,FeedUnits_Alpenprojekt,OutputType,FeedForCommodityBalancesTotalsVariable_Alpenprojekt,"All","All","Baseline")*0.1;


*finally, assign grass values from production to DAQ values:
*Assign commodity balance values: only total: DAQ; and feed = 1, rest =0
*later: may use part for bioenergy?
TotalsCommodityBalances.l(GeographicUnits_New,SubSetGrass,"Crop","Domest Avail Quant (t)",ProductionSystems,"All","Baseline")
         = AreaHarvested.l(GeographicUnits_New,SubSetGrass,"Crop",ProductionSystems,"All","Baseline")
                 * ParameterPerHa(GeographicUnits_New,SubSetGrass,"Crop","Yield (t/ha)",ProductionSystems,"All","Baseline");


*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXDOES NOT SEEM TO ASSIGN GRasslandvalues...???

*currently, we have grass FM = grass DM - i.e. we have DM only:
TotalsCommodityBalances.l(GeographicUnits_New,SubSetGrass,"Crop","Domest Avail Quant DM (t)",ProductionSystems,"All","Baseline")
         = TotalsCommodityBalances.l(GeographicUnits_New,SubSetGrass,"Crop","Domest Avail Quant (t)",ProductionSystems,"All","Baseline");

TotalsCommodityBalances.l(GeographicUnits_New,SubSetGrass,"Crop","Feed (t)",ProductionSystems,"All","Baseline")
         = TotalsCommodityBalances.l(GeographicUnits_New,SubSetGrass,"Crop","Domest Avail Quant (t)",ProductionSystems,"All","Baseline");

TotalsCommodityBalances.l(GeographicUnits_New,SubSetGrass,"Crop","Feed DM (t)",ProductionSystems,"All","Baseline")
         = TotalsCommodityBalances.l(GeographicUnits_New,SubSetGrass,"Crop","Feed (t)",ProductionSystems,"All","Baseline");





*generate a specific gdx file that contains what has been calculated in this code module - this helps to keep the overview on what happens where
execute_unload 'WhatISThereFrom__Alpenprojekt_FeedData'
ParameterCommodityBalancesPerTon
TotalsCommodityBalances
Feed_Alpenprojekt
;






$ontext;
For some commodities, translation in primary products is needed - this explains the factors that occur below, here and there:
use the technical conversion factors from FAO:
         Sugar cane is in SUGAR: 12% of sugar cane is sugar, thus divide the quantities here by 0.12
         Linseed is in OIL: 35% of Linseed is oil, thus divide by 0.35
         Alfalfa: is in pellets - keep as it is.
         Byprods are byprods - that's ok, residues as well
                 but good to know how much primary prod is needed for that
         Soybeans are in cake: divide by 0.8 to get prim prod. (extr. Rate 80%)
         Pelagic fish is processed - no info, so keep as it is.
         Organic: soy (20% oil), sunflower (41% is oil) is in primary prod? For nowm we assume (cf. assumptions on nutr cont above) that soy is cake (i.e. 80% of prim prod) and sunflower is cake (i.e. 59% of prim prod)
*$offtext;

*may do new SOLm sets: SwissFeedGrains, SwissGFeedGrainLegumes SwissFeedOilCrops SwissActGroup_FishAndSeafood
*WHAT IS: Grünfutter verarbeitet: grass pellets? - thus count as grass?
*ActGroup_FishAndSeafood: how much is main/Byproduct??

*first, set the values from the global FAO-model equal 0; this is an issue for DAQ only:
DomestAvailActIOEnv(ActivityUnits,Yield_Type,"Switzerland",ProductionSystem,"DomestAvailFeedQuantity","CurrentSituation")
         =0;
DomestAvailActIOEnv(ActivityUnits,Yield_Type,"Switzerland",ProductionSystem,"FeedQuantityfROMbYPROD","CurrentSituation")
         =0;

*where occurring in somewhat relevant quantities, we added CoProdFromImportedProcessedFood to imports - if only small quantities were reported, we omitted it
*'Getreide (Körner)'
DomestAvailActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");

*assign the nutrient contets to the commodity groups, etc.
DomestAvailActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DAQ_FeedGE_Cont","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","total","GE_Contents","AverageProdSystem","CurrentSituation");
DomestAvailActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DAQ_FeedXP_Cont","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","total","XP_Contents","AverageProdSystem","CurrentSituation");
DomestAvailActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DAQ_FeedDM_Cont","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","total","DM_Contents","AverageProdSystem","CurrentSituation");

ImpActQuantPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedGE_Cont","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","Import","GE_Contents","AverageProdSystem","CurrentSituation");
ImpActQuantPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedXP_Cont","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","Import","XP_Contents","AverageProdSystem","CurrentSituation");
ImpActQuantPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","Import","DM_Contents","AverageProdSystem","CurrentSituation");

ProdActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedGE_Cont","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","DomesticProduction","GE_Contents","AverageProdSystem","CurrentSituation");
ProdActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedXP_Cont","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","DomesticProduction","XP_Contents","AverageProdSystem","CurrentSituation");
ProdActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedDM_Cont","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Getreide (Körner)","DomesticProduction","DM_Contents","AverageProdSystem","CurrentSituation");

*derive totals from quantities and contents:
DomestAvailActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity_DM","CurrentSituation")
         =DomestAvailActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
                 *DomestAvailActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DAQ_FeedDM_Cont","CurrentSituation");
DomestAvailActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","TotFeedGE","CurrentSituation")
         =DomestAvailActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
                 *DomestAvailActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DAQ_FeedGE_Cont","CurrentSituation");
DomestAvailActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","TotFeedXP","CurrentSituation")
         =DomestAvailActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
                 *DomestAvailActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DAQ_FeedXP_Cont","CurrentSituation");

ImpActQuant("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation")
         =ImpActQuant("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *ImpActQuantPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation");
ImpActQuant("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedGE","CurrentSituation")
         =ImpActQuant("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *ImpActQuantPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedGE_Cont","CurrentSituation");
ImpActQuant("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedXP","CurrentSituation")
         =ImpActQuant("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *ImpActQuantPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedXP_Cont","CurrentSituation");

ProdActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_DM","AverageSeason","CurrentSituation")
         =ProdActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedDM_Cont","AverageSeason","CurrentSituation");
ProdActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedGE","AverageSeason","CurrentSituation")
         =ProdActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedGE_Cont","AverageSeason","CurrentSituation");
ProdActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedXP","AverageSeason","CurrentSituation")
         =ProdActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedXP_Cont","AverageSeason","CurrentSituation");

*put this into a macro for the rest of the feedstuffs:
$macro AssignNutrContFeedData_Alpenprojekt(CommodityGroup_SOLm,CommodityGroup_AP,ProductType,ProductSystem)             \
DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedGE_Cont","CurrentSituation") \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"total","GE_Contents",&ProductSystem,"CurrentSituation");             \
DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedXP_Cont","CurrentSituation")   \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"total","XP_Contents",&ProductSystem,"CurrentSituation");               \
DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedDM_Cont","CurrentSituation")     \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"total","DM_Contents",&ProductSystem,"CurrentSituation");                 \
                                                                                                                                 \
ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedGE_Cont","CurrentSituation")   \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"Import","GE_Contents",&ProductSystem,"CurrentSituation");                            \
ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedXP_Cont","CurrentSituation")     \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"Import","XP_Contents",&ProductSystem,"CurrentSituation");                              \
ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedDM_Cont","CurrentSituation")       \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"Import","DM_Contents",&ProductSystem,"CurrentSituation");                                \
                                                                                                                                                 \
ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedGE_Cont","AverageSeason","CurrentSituation")   \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"DomesticProduction","GE_Contents",&ProductSystem,"CurrentSituation");                                                 \
ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedXP_Cont","AverageSeason","CurrentSituation")     \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"DomesticProduction","XP_Contents",&ProductSystem,"CurrentSituation");                                                   \
ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedDM_Cont","AverageSeason","CurrentSituation")       \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"DomesticProduction","DM_Contents",&ProductSystem,"CurrentSituation");               \
                                                                                                                                           \
*derive totals from quantities and contents:                                                                                                \
DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DomestAvailFeedQuantity_DM","CurrentSituation")              \
         =DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DomestAvailFeedQuantity","CurrentSituation")        \
                 *DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedDM_Cont","CurrentSituation");  \
DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"TotFeedGE","CurrentSituation")                                  \
         =DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DomestAvailFeedQuantity","CurrentSituation")           \
                 *DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedGE_Cont","CurrentSituation");     \
DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"TotFeedXP","CurrentSituation")                                     \
         =DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DomestAvailFeedQuantity","CurrentSituation")              \
                 *DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedXP_Cont","CurrentSituation");        \
                                                                                                                                                      \
ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation")                  \
         =ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedQuantity","CurrentSituation")            \
                 *ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedDM_Cont","CurrentSituation"); \
ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedGE","CurrentSituation")                           \
         =ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedQuantity","CurrentSituation")                        \
                 *ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedGE_Cont","CurrentSituation");    \
ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedXP","CurrentSituation")                                    \
         =ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedQuantity","CurrentSituation")                     \
                 *ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedXP_Cont","CurrentSituation");       \
                                                                                                                                                                   \
ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ProdQuantForFeed_DM","AverageSeason","CurrentSituation")\
         =ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ProdQuantForFeed","AverageSeason","CurrentSituation")                   \
                 *ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedDM_Cont","AverageSeason","CurrentSituation");  \
ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"TotFeedGE","AverageSeason","CurrentSituation")                                    \
         =ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ProdQuantForFeed","AverageSeason","CurrentSituation")                   \
                 *ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedGE_Cont","AverageSeason","CurrentSituation");  \
ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"TotFeedXP","AverageSeason","CurrentSituation")                                    \
         =ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ProdQuantForFeed","AverageSeason","CurrentSituation")                   \
                 *ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedXP_Cont","AverageSeason","CurrentSituation");
*end macro AssignNutrContFeedData_Alpenprojekt(CommodityGroup_SOLm,CommodityGroup_AP,ProductType)

*and as we work partly on byproducts, we make a specific macro for those as well:
$macro AssignNutrContFeedData_Alpenprojekt_Byp(CommodityGroup_SOLm,CommodityGroup_AP,ProductType,ProductSystem)             \
DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedGE_Byp_Cont","CurrentSituation") \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"total","GE_Contents",&ProductSystem,"CurrentSituation");             \
DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedXP_Byp_Cont","CurrentSituation")   \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"total","XP_Contents",&ProductSystem,"CurrentSituation");               \
DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedDM_Byp_Cont","CurrentSituation")     \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"total","DM_Contents",&ProductSystem,"CurrentSituation");                 \
                                                                                                                                 \
ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedGE_Byp_Cont","CurrentSituation")   \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"Import","GE_Contents",&ProductSystem,"CurrentSituation");                            \
ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedXP_Byp_Cont","CurrentSituation")     \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"Import","XP_Contents",&ProductSystem,"CurrentSituation");                              \
ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedDM_Byp_Cont","CurrentSituation")       \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"Import","DM_Contents",&ProductSystem,"CurrentSituation");                                \
                                                                                                                                                 \
ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedGE_Byp_Cont","AverageSeason","CurrentSituation")   \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"DomesticProduction","GE_Contents",&ProductSystem,"CurrentSituation");                                                 \
ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedXP_Byp_Cont","AverageSeason","CurrentSituation")     \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"DomesticProduction","XP_Contents",&ProductSystem,"CurrentSituation");                                                   \
ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedDM_Byp_Cont","AverageSeason","CurrentSituation")       \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"DomesticProduction","DM_Contents",&ProductSystem,"CurrentSituation");               \
                                                                                                                                           \
*derive totals from quantities and contents:                                                                                                \
DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"FeedQuantityFromByprod_DM","CurrentSituation")              \
         =DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"FeedQuantityFromByprod","CurrentSituation")        \
                 *DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedDM_Byp_Cont","CurrentSituation");  \
DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"FeedGE_Byp","CurrentSituation")                                  \
         =DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"FeedQuantityFromByprod","CurrentSituation")           \
                 *DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedGE_Byp_Cont","CurrentSituation");     \
DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"FeedXP_Byp","CurrentSituation")                                     \
         =DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"FeedQuantityFromByprod","CurrentSituation")              \
                 *DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedXP_Byp_Cont","CurrentSituation");        \
                                                                                                                                                      \
ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedQuantity_Byprod_DM","CurrentSituation")                  \
         =ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")            \
                 *ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedDM_Byp_Cont","CurrentSituation"); \
ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedGE_Byp","CurrentSituation")                           \
         =ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")                        \
                 *ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedGE_Byp_Cont","CurrentSituation");    \
ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedXP_Byp","CurrentSituation")                                    \
         =ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")                     \
                 *ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedXP_Byp_Cont","CurrentSituation");       \
                                                                                                                                                                   \
ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ProdQuantForFeed_DM_Byprod","AverageSeason","CurrentSituation")\
         =ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")                   \
                 *ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedDM_Byp_Cont","AverageSeason","CurrentSituation");  \
ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"TotFeedGE_Byp","AverageSeason","CurrentSituation")                                    \
         =ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")                   \
                 *ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedGE_Byp_Cont","AverageSeason","CurrentSituation");  \
ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"TotFeedXP_Byp","AverageSeason","CurrentSituation")                                    \
         =ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")                   \
                 *ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedXP_Byp_Cont","AverageSeason","CurrentSituation");
*end macro AssignNutrContFeedData_Alpenprojekt_Byp(CommodityGroup_SOLm,CommodityGroup_AP,ProductType)

*and as we work partly on residues, we make a specific macro for those as well:
$macro AssignNutrContFeedData_Alpenprojekt_Residues(CommodityGroup_SOLm,CommodityGroup_AP,ProductType,ProductSystem)             \
DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedGE_Resid_Cont","CurrentSituation") \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"total","GE_Contents",&ProductSystem,"CurrentSituation");             \
DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedXP_Resid_Cont","CurrentSituation")   \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"total","XP_Contents",&ProductSystem,"CurrentSituation");               \
DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedDM_Resid_Cont","CurrentSituation")     \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"total","DM_Contents",&ProductSystem,"CurrentSituation");                 \
                                                                                                                                 \
ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedGE_Resid_Cont","CurrentSituation")   \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"Import","GE_Contents",&ProductSystem,"CurrentSituation");                            \
ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedXP_Resid_Cont","CurrentSituation")     \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"Import","XP_Contents",&ProductSystem,"CurrentSituation");                              \
ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedDM_Resid_Cont","CurrentSituation")       \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"Import","DM_Contents",&ProductSystem,"CurrentSituation");                                \
                                                                                                                                                 \
ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedGE_Resid_Cont","AverageSeason","CurrentSituation")   \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"DomesticProduction","GE_Contents",&ProductSystem,"CurrentSituation");                                                 \
ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedXP_Resid_Cont","AverageSeason","CurrentSituation")     \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"DomesticProduction","XP_Contents",&ProductSystem,"CurrentSituation");                                                   \
ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedDM_Resid_Cont","AverageSeason","CurrentSituation")       \
         = Feed_Alpenprojekt(&CommodityGroup_AP,"DomesticProduction","DM_Contents",&ProductSystem,"CurrentSituation");               \
                                                                                                                                           \
*derive totals from quantities and contents:                                                                                                \
DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"FeedQuantityFromResidue_DM","CurrentSituation")              \
         =DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DomestAvailResidueFeedQuantity","CurrentSituation")        \
                 *DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedDM_Resid_Cont","CurrentSituation");  \
DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"FeedGE_Resid","CurrentSituation")                                  \
         =DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DomestAvailResidueFeedQuantity","CurrentSituation")           \
                 *DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedGE_Resid_Cont","CurrentSituation");     \
DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"FeedXP_Resid","CurrentSituation")                                     \
         =DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DomestAvailResidueFeedQuantity","CurrentSituation")              \
                 *DomestAvailActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"DAQ_FeedXP_Resid_Cont","CurrentSituation");        \
                                                                                                                                                      \
ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedQuantity_Residue_DM","CurrentSituation")                  \
         =ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportResidueFeedQuantity","CurrentSituation")            \
                 *ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedDM_Resid_Cont","CurrentSituation"); \
ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedGE_Resid","CurrentSituation")                           \
         =ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportResidueFeedQuantity","CurrentSituation")                        \
                 *ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedGE_Resid_Cont","CurrentSituation");    \
ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportFeedXP_Resid","CurrentSituation")                                    \
         =ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","ImportResidueFeedQuantity","CurrentSituation")                     \
                 *ImpActQuantPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland",&ProductSystem,"Region_FAO_World","Output_FeedXP_Resid_Cont","CurrentSituation");       \
                                                                                                                                                                   \
ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ProdQuantForFeed_DM_Residue","AverageSeason","CurrentSituation")\
         =ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ResidueQuantForFeed","AverageSeason","CurrentSituation")                   \
                 *ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedDM_Resid_Cont","AverageSeason","CurrentSituation");  \
ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"TotFeedGE_Resid","AverageSeason","CurrentSituation")                                    \
         =ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ResidueQuantForFeed","AverageSeason","CurrentSituation")                   \
                 *ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedGE_Resid_Cont","AverageSeason","CurrentSituation");  \
ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"TotFeedXP_Resid","AverageSeason","CurrentSituation")                                    \
         =ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"ResidueQuantForFeed","AverageSeason","CurrentSituation")                   \
                 *ProdActIOEnvPerTon(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",&ProductSystem,"Output_FeedXP_Resid_Cont","AverageSeason","CurrentSituation");
*end macro AssignNutrContFeedData_Alpenprojekt_Residues(CommodityGroup_SOLm,CommodityGroup_AP,ProductType)

*'Reis (Bruch-)'
DomestAvailActIOEnv("Rice, paddy","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Reis (Bruch-)","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Rice, paddy","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Reis (Bruch-)","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Rice, paddy","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Reis (Bruch-)","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Rice, paddy","Reis (Bruch-)","Crop","AverageProdSystem");

*'Getrocknete Hülsenfrüchte (Körner)'
DomestAvailActIOEnv("ActGroup_Legumes","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Getrocknete Hülsenfrüchte (Körner)","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("ActGroup_Legumes","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Getrocknete Hülsenfrüchte (Körner)","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("ActGroup_Legumes","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Getrocknete Hülsenfrüchte (Körner)","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("ActGroup_Legumes","Getrocknete Hülsenfrüchte (Körner)","Crop","AverageProdSystem");

*'Kartoffeln (Knollen)'
DomestAvailActIOEnv("Potatoes","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Kartoffeln (Knollen)","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Potatoes","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Kartoffeln (Knollen)","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Potatoes","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Kartoffeln (Knollen)","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Potatoes","Kartoffeln (Knollen)","Crop","AverageProdSystem");

*Zucker
*there are only imports - thus it is sugar cane only, we assume
DomestAvailActIOEnv("Sugar cane","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Zucker","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Sugar cane","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Zucker","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Sugar cane","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Zucker","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Sugar cane","Zucker","Crop","AverageProdSystem");
*after having derived the nutrient values, convert the quantities to primary products (factor cf. above).
DomestAvailActIOEnv("Sugar cane","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Sugar cane","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")/0.12;
ImpActQuant("Sugar cane","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = ImpActQuant("Sugar cane","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")/0.12;
ProdActIOEnv("Sugar cane","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = ProdActIOEnv("Sugar cane","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")/0.12;

*'Pflanzliche Fette und Öle (unverarbeitet)'
*these are all imported according to the data and according to FAOSTAT, feed from oil crops is mainly linseed (>90%), so put linseed here
DomestAvailActIOEnv("Linseed","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Pflanzliche Fette und Öle (unverarbeitet)","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Linseed","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Pflanzliche Fette und Öle (unverarbeitet)","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Linseed","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Pflanzliche Fette und Öle (unverarbeitet)","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Linseed","Pflanzliche Fette und Öle (unverarbeitet)","Crop","AverageProdSystem");
*after having derived the nutrient values, convert the quantities to primary products (factor cf. above).
DomestAvailActIOEnv("Linseed","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Linseed","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")/0.35;
ImpActQuant("Linseed","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = ImpActQuant("Linseed","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")/0.35;
ProdActIOEnv("Linseed","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = ProdActIOEnv("Linseed","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")/0.35;

*likely grass pellets, etc. - thus take "Alfalfa Meal and Pellets"
*'Grünfutter verarbeitet'
DomestAvailActIOEnv("Alfalfa Meal and Pellets","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Grünfutter verarbeitet","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Alfalfa Meal and Pellets","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Grünfutter verarbeitet","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Alfalfa Meal and Pellets","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Grünfutter verarbeitet","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Alfalfa Meal and Pellets","Grünfutter verarbeitet","Crop","AverageProdSystem");

*'Maniok (inbegr. Tapioka)'
DomestAvailActIOEnv("Cassava","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Maniok (inbegr. Tapioka)","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Cassava","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Maniok (inbegr. Tapioka)","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Cassava","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Maniok (inbegr. Tapioka)","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Cassava","Maniok (inbegr. Tapioka)","Crop","AverageProdSystem");

$ontext;
not that important, thus drop for a first version
*'Andere Produkte pflanzlichen Ursprungs'
DomestAvailActIOEnv("","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt(,,,);
$offtext;

*'Nebenerzeugnisse der Müllerei'
*'Nebenerzeugnisse der Brauerei'
*combine those - these are all by-products of ActGroup_Grains
*and according to FAOSTAT byprod for feed from grains are mainly from wheat - thus one approach woul dbe to assign to this only;
*however, XP contents of byprod from brewing are quite higher than those from milling - thus separate it and just take barley for the brewing part - to be checked, whether this is ok (or e.g. rather oats?)
*thus, do it separately, milling with wheat, brewing with barley:

$ontext;
combined code - not used anymore
DomestAvailActIOEnv("Wheat","Crop","Switzerland","AverageProdSystem","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Müllerei","total","Quantity","AverageProdSystem","CurrentSituation")
                 + Feed_Alpenprojekt("Nebenerzeugnisse der Brauerei","total","Quantity","AverageProdSystem","CurrentSituation");
*add CoProdFromProcessedImportedFood to the imports:
ImpActQuant("Wheat","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Müllerei","Import","Quantity","AverageProdSystem","CurrentSituation")
                 + Feed_Alpenprojekt("Nebenerzeugnisse der Brauerei","Import","Quantity","AverageProdSystem","CurrentSituation")
                 + Feed_Alpenprojekt("Nebenerzeugnisse der Müllerei","CoProdFromProcessedImportedFood","Quantity","AverageProdSystem","CurrentSituation")
                 + Feed_Alpenprojekt("Nebenerzeugnisse der Brauerei","CoProdFromProcessedImportedFood","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Wheat","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Müllerei","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation")
                 + Feed_Alpenprojekt("Nebenerzeugnisse der Brauerei","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
*ASSIGN AVERAGE CONTENTS based on brewing and milling - but for simplicity and as otherwise, we could not use the macro, take milling values,
*as milling is more important.
AssignNutrContFeedData_Alpenprojekt_Byp("Wheat","Nebenerzeugnisse der Müllerei","Crop","AverageProdSystem");
end of combined code
$offtext;
$ontext;
*now for milling/wheat, brewing/barley separately:
DomestAvailActIOEnv("Wheat","Crop","Switzerland","AverageProdSystem","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Müllerei","total","Quantity","AverageProdSystem","CurrentSituation");
*add CoProdFromProcessedImportedFood to the imports:
ImpActQuant("Wheat","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Müllerei","Import","Quantity","AverageProdSystem","CurrentSituation")
                 + Feed_Alpenprojekt("Nebenerzeugnisse der Müllerei","CoProdFromProcessedImportedFood","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Wheat","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Müllerei","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt_Byp("Wheat","Nebenerzeugnisse der Müllerei","Crop","AverageProdSystem");

DomestAvailActIOEnv("Barley","Crop","Switzerland","AverageProdSystem","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Brauerei","total","Quantity","AverageProdSystem","CurrentSituation");
*add CoProdFromProcessedImportedFood to the imports:
ImpActQuant("Barley","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Brauerei","Import","Quantity","AverageProdSystem","CurrentSituation")
                 + Feed_Alpenprojekt("Nebenerzeugnisse der Brauerei","CoProdFromProcessedImportedFood","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Barley","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Brauerei","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt_Byp("Barley","Nebenerzeugnisse der Brauerei","Crop","AverageProdSystem");

*'Nebenerzeugnisse der Stärkeherstellung'
*all imported, thus, for simplicity, we just assume 50% each from maize and potatoe - as byproduct it is anyway not env. impact relevant!
DomestAvailActIOEnv("Potatoes","Crop","Switzerland","AverageProdSystem","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Stärkeherstellung","total","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
ImpActQuant("Potatoes","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Stärkeherstellung","Import","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
ProdActIOEnv("Potatoes","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Stärkeherstellung","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
DomestAvailActIOEnv("Maize","Crop","Switzerland","AverageProdSystem","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Stärkeherstellung","total","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
ImpActQuant("Maize","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Stärkeherstellung","Import","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
ProdActIOEnv("Maize","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Stärkeherstellung","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
AssignNutrContFeedData_Alpenprojekt_Byp("Potatoes","Nebenerzeugnisse der Stärkeherstellung","Crop","AverageProdSystem");
AssignNutrContFeedData_Alpenprojekt_Byp("Maize","Nebenerzeugnisse der Stärkeherstellung","Crop","AverageProdSystem");

*'Nebenerzeugnisse der Zuckerherstellung'
*add CoProdFromImportedProcessedFood to imports
DomestAvailActIOEnv("Sugar beet","Crop","Switzerland","AverageProdSystem","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Zuckerherstellung","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Sugar beet","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Zuckerherstellung","Import","Quantity","AverageProdSystem","CurrentSituation")
                 + Feed_Alpenprojekt("Nebenerzeugnisse der Zuckerherstellung","CoProdFromProcessedImportedFood","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Sugar beet","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Zuckerherstellung","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt_Byp("Sugar beet","Nebenerzeugnisse der Zuckerherstellung","Crop","AverageProdSystem");

*'Nebenerzeugnisse der Ölherstellung (Ölkuchen)'
*add CoProdFromImportedProcessedFood to imports
*this is manyl soy cake - thus decide on the basis of domestic produciton: 13% and imports: 87% - count the latter as soy cake and the former as byprods
*according to FAOSTAT, this is 20% from sunflower, 80% from rape - thus assign accordingly:
DomestAvailActIOEnv("Sunflower seed","Crop","Switzerland","AverageProdSystem","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Ölherstellung (Ölkuchen)","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation")
                 *0.2;
DomestAvailActIOEnv("Rapeseed","Crop","Switzerland","AverageProdSystem","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Ölherstellung (Ölkuchen)","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation")
                 *0.8;
ImpActQuant("Sunflower seed","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = 0;
ImpActQuant("Rapeseed","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = 0;
ProdActIOEnv("Sunflower seed","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Ölherstellung (Ölkuchen)","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation")
                 *0.2;
ProdActIOEnv("Rapeseed","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Ölherstellung (Ölkuchen)","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation")
                 *0.8;

DomestAvailActIOEnv("Soybeans","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Ölherstellung (Ölkuchen)","Import","Quantity","AverageProdSystem","CurrentSituation")
                 + Feed_Alpenprojekt("Nebenerzeugnisse der Ölherstellung (Ölkuchen)","CoProdFromProcessedImportedFood","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Soybeans","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Nebenerzeugnisse der Ölherstellung (Ölkuchen)","Import","Quantity","AverageProdSystem","CurrentSituation")
                 + Feed_Alpenprojekt("Nebenerzeugnisse der Ölherstellung (Ölkuchen)","CoProdFromProcessedImportedFood","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Soybeans","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = 0;
AssignNutrContFeedData_Alpenprojekt_Byp("Sunflower seed","Nebenerzeugnisse der Ölherstellung (Ölkuchen)","Crop","AverageProdSystem");
AssignNutrContFeedData_Alpenprojekt_Byp("Rapeseed","Nebenerzeugnisse der Ölherstellung (Ölkuchen)","Crop","AverageProdSystem");
AssignNutrContFeedData_Alpenprojekt("Soybeans","Nebenerzeugnisse der Ölherstellung (Ölkuchen)","Crop","AverageProdSystem");
*after having derived the nutrient values, convert the quantities from soy to primary products (factor cf. above).
DomestAvailActIOEnv("Soybeans","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Soybeans","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")/0.8;
ImpActQuant("Soybeans","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = ImpActQuant("Soybeans","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")/0.8;
ProdActIOEnv("Soybeans","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = ProdActIOEnv("Soybeans","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")/0.8;
$offtext;
$ontext;
currently not that important, thus do not include for now
*'Andere Nebenerzeugnisse'
DomestAvailActIOEnv("","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt(,,,);
$offtext;
$ontext;
*for now, take all as main producdts, no byproducts - to be refined later, if needed
*'Verarbeitung von Seetieren'
*this is all imported and according to FAOSTAT this is only pelagic fish, thus use this only
DomestAvailActIOEnv("Pelagic fish","Fish","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Verarbeitung von Seetieren","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Pelagic fish","Fish","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Verarbeitung von Seetieren","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Pelagic fish","Fish","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Verarbeitung von Seetieren","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Pelagic fish","Verarbeitung von Seetieren","Fish","AverageProdSystem");
$offtext;
$ontext;
*currently zero, thus do not yet assign
*'Verarbeitung von Landtieren'
DomestAvailActIOEnv("","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt(,,,);
$offtext;
$ontext;
*we see this as byproducts, thus without env. impacts - but will be reduced when animal numbers are reduced!
*for now, we take half of it from pigs, half from cattle; its all imported;
*'Tierische Fette und Öle'
DomestAvailActIOEnv("Pigs","Meat","Switzerland","AverageProdSystem","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Tierische Fette und Öle","total","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
ImpActQuant("Pigs","Meat","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = Feed_Alpenprojekt("Tierische Fette und Öle","Import","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
ProdActIOEnv("Pigs","Meat","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Tierische Fette und Öle","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
DomestAvailActIOEnv("Cattle","Meat","Switzerland","AverageProdSystem","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Tierische Fette und Öle","total","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
ImpActQuant("Cattle","Meat","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = Feed_Alpenprojekt("Tierische Fette und Öle","Import","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
ProdActIOEnv("Cattle","Meat","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Tierische Fette und Öle","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation")
                 /2;
AssignNutrContFeedData_Alpenprojekt_Byp("Pigs","Tierische Fette und Öle","Meat","AverageProdSystem");
AssignNutrContFeedData_Alpenprojekt_Byp("Cattle","Tierische Fette und Öle","Meat","AverageProdSystem");

*'Milch und Milchprodukte'
*according to the FAO values for Switzerland, 25% of FeedME from milk is from byproducts; thus, assign 25% to byprod, 75% tzo main prod:
DomestAvailActIOEnv("Cattle","Milk","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Milch und Milchprodukte","total","Quantity","AverageProdSystem","CurrentSituation")
                 *0.75;
ImpActQuant("Cattle","Milk","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Milch und Milchprodukte","Import","Quantity","AverageProdSystem","CurrentSituation")
                 *0.75;
ProdActIOEnv("Cattle","Milk","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Milch und Milchprodukte","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation")
                 *0.75;
DomestAvailActIOEnv("Cattle","Milk","Switzerland","AverageProdSystem","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Milch und Milchprodukte","total","Quantity","AverageProdSystem","CurrentSituation")
                 *0.25;
ImpActQuant("Cattle","Milk","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = Feed_Alpenprojekt("Milch und Milchprodukte","Import","Quantity","AverageProdSystem","CurrentSituation")
                 *0.25;
ProdActIOEnv("Cattle","Milk","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Milch und Milchprodukte","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation")
                 *0.25;
AssignNutrContFeedData_Alpenprojekt("Cattle","Milch und Milchprodukte","Milk","AverageProdSystem");
AssignNutrContFeedData_Alpenprojekt_Byp("Cattle","Milch und Milchprodukte","Milk","AverageProdSystem");

*'Hackfrüchte'
*we assume them to be Beets for Fodder
DomestAvailActIOEnv("Beets for Fodder","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Hackfrüchte","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Beets for Fodder","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Hackfrüchte","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Hackfrüchte","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Beets for Fodder","Hackfrüchte","Crop","AverageProdSystem");

*'Grünmais'
DomestAvailActIOEnv("Maize For Forage+Silage","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Grünmais","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Maize For Forage+Silage","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Grünmais","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Grünmais","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Maize For Forage+Silage","Grünmais","Crop","AverageProdSystem");

*there is data for grass, but we use the more specific grass data filed in earlier and then compare with this one later
$offtext;
$ontext;
*'Mehrjähriger Futterbau (temporär und dauerhaft)'
DomestAvailActIOEnv("Grass","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Mehrjähriger Futterbau (temporär und dauerhaft)","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Grass","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Mehrjähriger Futterbau (temporär und dauerhaft)","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Mehrjähriger Futterbau (temporär und dauerhaft)","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Grass","Mehrjähriger Futterbau (temporär und dauerhaft)","Crop","AverageProdSystem");
$offtext;
$ontext;
*'Stroh und Spreu'
*assign this all to wheat, for simplicity.
DomestAvailActIOEnv("Wheat","Crop","Switzerland","AverageProdSystem","DomestAvailResidueFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Stroh und Spreu","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("Wheat","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportResidueFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Stroh und Spreu","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("Wheat","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ResidueQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Stroh und Spreu","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt_Residues("Wheat","Stroh und Spreu","Crop","AverageProdSystem");
$offtext
$ontext;
*'Blätter und Köpfe'
*to assign this somewhere, take it as residues from vegetables (part may be leaves from sugar beet, though)
*and add the "andere Koppelprodukte" to it, for also covering that - but in fact, thos are all that unimportant, that we leave them out.
DomestAvailActIOEnv("ActGroup_Vegetables","Crop","Switzerland","AverageProdSystem","DomestAvailResidueFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Blätter und Köpfe","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("ActGroup_Vegetables","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportResidueFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Blätter und Köpfe","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("ActGroup_Vegetables","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ResidueQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Blätter und Köpfe","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt_Residues("ActGroup_Vegetables","Blätter und Köpfe","Crop","AverageProdSystem");
$offtext

$ontext;
*the following three are unimportant - thus do not include for now:
*'Andere Kuppelprodukte'
DomestAvailActIOEnv("","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt(,,,);

*'Gemüse'
DomestAvailActIOEnv("","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt(,,,);

*Obst
DomestAvailActIOEnv("","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt(,,,);
$offtext;

$ontext;
not that important, thus drop for a first calculation
*'Abfälle (übrige)'
DomestAvailActIOEnv("","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt(,,,);
$offtext;

$ontext;
*not that important - do not include for now
*'Andere an anderer Stelle nicht genannte Futtermitt'
DomestAvailActIOEnv("","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","total","Quantity","AverageProdSystem","CurrentSituation");
ImpActQuant("","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("","Import","Quantity","AverageProdSystem","CurrentSituation");
ProdActIOEnv("","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("","DomesticProduction","Quantity","AverageProdSystem","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt(,,,);
$offtext;
$ontext;
*now assign organic values:
DomestAvailActIOEnv("Wheat","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Wheat","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Wheat","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Wheat","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Wheat","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Wheat","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 -ProdActIOEnv("Wheat","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation");
DomestAvailActIOEnv("Barley","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Barley","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Barley","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Barley","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Barley","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Barley","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 -ProdActIOEnv("Barley","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation");
DomestAvailActIOEnv("Rye","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Rye","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Rye","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Rye","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Rye","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Rye","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 -ProdActIOEnv("Rye","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation");
DomestAvailActIOEnv("Oats","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Oats","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Oats","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Oats","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Oats","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Oats","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 -ProdActIOEnv("Oats","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation");
DomestAvailActIOEnv("Triticale","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Triticale","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Triticale","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Triticale","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Triticale","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Triticale","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 -ProdActIOEnv("Triticale","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation");
DomestAvailActIOEnv("Spelt","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Spelt","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Spelt","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Spelt","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Spelt","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Spelt","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 -ProdActIOEnv("Spelt","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Wheat","Wheat","Crop","Organic");
AssignNutrContFeedData_Alpenprojekt("Barley","Barley","Crop","Organic");
AssignNutrContFeedData_Alpenprojekt("Rye","Rye","Crop","Organic");
AssignNutrContFeedData_Alpenprojekt("Oats","Oats","Crop","Organic");
AssignNutrContFeedData_Alpenprojekt("Triticale","Triticale","Crop","Organic");
AssignNutrContFeedData_Alpenprojekt("Spelt","Spelt","Crop","Organic");

DomestAvailActIOEnv("Maize","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Maize grain","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Maize","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Maize grain","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Maize","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Maize","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 -ProdActIOEnv("Maize","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Maize","Maize grain","Crop","Organic");

DomestAvailActIOEnv("Beans, dry","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Beans","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Beans, dry","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Beans","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Beans, dry","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Beans, dry","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 -ProdActIOEnv("Beans, dry","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation");
DomestAvailActIOEnv("Peas, dry","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Peas","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Peas, dry","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Peas","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Peas, dry","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Peas, dry","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 -ProdActIOEnv("Peas, dry","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation");
DomestAvailActIOEnv("Soybeans","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
         = Feed_Alpenprojekt("Soy","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Soybeans","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Soy","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Soybeans","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Soybeans","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 -ProdActIOEnv("Soybeans","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt("Beans, dry","Beans","Crop","Organic");
AssignNutrContFeedData_Alpenprojekt("Peas, dry","Peas","Crop","Organic");
AssignNutrContFeedData_Alpenprojekt("Soybeans","Soy","Crop","Organic");
*after having derived the nutrient values, convert the quantities from soy to primary products (factor cf. above).
DomestAvailActIOEnv("Soybeans","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
         = DomestAvailActIOEnv("Soybeans","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")/0.8;
ProdActIOEnv("Soybeans","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
         = ProdActIOEnv("Soybeans","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")/0.8;
ImpActQuant("Soybeans","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = ImpActQuant("Soybeans","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")/0.8;

*sunflower is cake from oil production - thus byproduct, thus no conversion to primary product, potato neither (cf. below)
DomestAvailActIOEnv("Sunflower seed","Crop","Switzerland","Organic","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Sunflower","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Sunflower seed","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Sunflower","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Sunflower seed","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = DomestAvailActIOEnv("Sunflower seed","Crop","Switzerland","Organic","FeedQuantityFromByprod","CurrentSituation")
                 -ProdActIOEnv("Sunflower seed","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt_Byp("Sunflower seed","Sunflower","Crop","Organic");

DomestAvailActIOEnv("Potatoes","Crop","Switzerland","Organic","FeedQuantityFromByprod","CurrentSituation")
         = Feed_Alpenprojekt("Potato prot","total","Quantity","Organic","CurrentSituation");
ProdActIOEnv("Potatoes","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")
         = Feed_Alpenprojekt("Potato prot","DomesticProduction","Quantity","Organic","CurrentSituation");
ImpActQuant("Potatoes","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
         = DomestAvailActIOEnv("Potatoes","Crop","Switzerland","Organic","FeedQuantityFromByprod","CurrentSituation")
                 -ProdActIOEnv("Potatoes","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation");
AssignNutrContFeedData_Alpenprojekt_Byp("Potatoes","Potato prot","Crop","Organic");

*Now assign values to single activitirs for average prod systems, according to relative feed shares in group-wise total feed:
*use the original WOSY data to avoid that part has already been overwritten by new feed data.

*ActGroup_Grains
WOSY_Feed("Switzerland","ActGroup_Grains","Crop")
         =sum(Grains,WOSY_Feed("Switzerland",Grains,"Crop"));
WOSY_FeedGE("Switzerland","ActGroup_Grains","Crop")
         =sum(Grains,WOSY_FeedGE("Switzerland",Grains,"Crop"));
WOSY_FeedXP("Switzerland","ActGroup_Grains","Crop")
         =sum(Grains,WOSY_FeedXP("Switzerland",Grains,"Crop"));

ProdActIOEnv(Grains,"Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_Grains","Crop")
         =ProdActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
                  *WOSY_Feed("Switzerland",Grains,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_Grains","Crop");
DomestAvailActIOEnv(Grains,"Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_Grains","Crop")
         =DomestAvailActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
                  *WOSY_Feed("Switzerland",Grains,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_Grains","Crop");
ImpActQuant(Grains,"Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_Grains","Crop")
         =ImpActQuant("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                  *WOSY_Feed("Switzerland",Grains,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_Grains","Crop");

ProdActIOEnv(Grains,"Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedGE","AverageSeason","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_Grains","Crop")
         =ProdActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedGE","AverageSeason","CurrentSituation")
                  *WOSY_Feed("Switzerland",Grains,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_Grains","Crop");
DomestAvailActIOEnv(Grains,"Crop","Switzerland","AverageProdSystem","TotFeedGE","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_Grains","Crop")
         =DomestAvailActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","TotFeedGE","CurrentSituation")
                  *WOSY_Feed("Switzerland",Grains,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_Grains","Crop");
ImpActQuant(Grains,"Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedGE","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_Grains","Crop")
         =ImpActQuant("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedGE","CurrentSituation")
                  *WOSY_Feed("Switzerland",Grains,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_Grains","Crop");

ProdActIOEnv(Grains,"Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedXP","AverageSeason","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_Grains","Crop")
         =ProdActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedXP","AverageSeason","CurrentSituation")
                  *WOSY_Feed("Switzerland",Grains,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_Grains","Crop");
DomestAvailActIOEnv(Grains,"Crop","Switzerland","AverageProdSystem","TotFeedXP","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_Grains","Crop")
         =DomestAvailActIOEnv("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","TotFeedXP","CurrentSituation")
                  *WOSY_Feed("Switzerland",Grains,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_Grains","Crop");
ImpActQuant(Grains,"Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedXP","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_Grains","Crop")
         =ImpActQuant("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedXP","CurrentSituation")
                  *WOSY_Feed("Switzerland",Grains,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_Grains","Crop");

ProdActIOEnv(Grains,"Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_DM","AverageSeason","CurrentSituation")
         = ProdActIOEnv(Grains,"Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedDM_Cont","AverageSeason","CurrentSituation");
DomestAvailActIOEnv(Grains,"Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity_DM","CurrentSituation")
         = DomestAvailActIOEnv(Grains,"Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
                 *DomestAvailActIOEnvPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","DAQ_FeedDM_Cont","CurrentSituation");
ImpActQuant(Grains,"Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation")
         = ImpActQuant(Grains,"Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *ImpActQuantPerTon("ActGroup_Grains","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation");

*ActGroup_Legumes
*exclude soy,Alfalfa as this is treated separately
WOSY_Feed("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =sum(LegumesNoSoyNoAlfalfa,WOSY_Feed("Switzerland",LegumesNoSoyNoAlfalfa,"Crop"));
WOSY_FeedGE("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =sum(LegumesNoSoyNoAlfalfa,WOSY_FeedGE("Switzerland",LegumesNoSoyNoAlfalfa,"Crop"));
WOSY_FeedXP("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =sum(LegumesNoSoyNoAlfalfa,WOSY_FeedXP("Switzerland",LegumesNoSoyNoAlfalfa,"Crop"));

*the following uses ActGroup_Legumes for some parameters - as no values are assigned to "ActGroup_LegumesNoSoyNoAlfalfa" at this stage!
ProdActIOEnv(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =ProdActIOEnv("ActGroup_Legumes","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
                  *WOSY_Feed("Switzerland",LegumesNoSoyNoAlfalfa,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop");
DomestAvailActIOEnv(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =DomestAvailActIOEnv("ActGroup_Legumes","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
                  *WOSY_Feed("Switzerland",LegumesNoSoyNoAlfalfa,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop");
ImpActQuant(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 $WOSY_Feed("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =ImpActQuant("ActGroup_Legumes","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                  *WOSY_Feed("Switzerland",LegumesNoSoyNoAlfalfa,"Crop")
                         /WOSY_Feed("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop");

ProdActIOEnv(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedGE","AverageSeason","CurrentSituation")
                 $WOSY_FeedGE("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =ProdActIOEnv("ActGroup_Legumes","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedGE","AverageSeason","CurrentSituation")
                  *WOSY_FeedGE("Switzerland",LegumesNoSoyNoAlfalfa,"Crop")
                         /WOSY_FeedGE("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop");
DomestAvailActIOEnv(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageProdSystem","TotFeedGE","CurrentSituation")
                 $WOSY_FeedGE("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =DomestAvailActIOEnv("ActGroup_Legumes","Crop","Switzerland","AverageProdSystem","TotFeedGE","CurrentSituation")
                  *WOSY_FeedGE("Switzerland",LegumesNoSoyNoAlfalfa,"Crop")
                         /WOSY_FeedGE("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop");
ImpActQuant(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedGE","CurrentSituation")
                 $WOSY_FeedGE("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =ImpActQuant("ActGroup_Legumes","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedGE","CurrentSituation")
                  *WOSY_FeedGE("Switzerland",LegumesNoSoyNoAlfalfa,"Crop")
                         /WOSY_FeedGE("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop");

ProdActIOEnv(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedXP","AverageSeason","CurrentSituation")
                 $WOSY_FeedXP("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =ProdActIOEnv("ActGroup_Legumes","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedXP","AverageSeason","CurrentSituation")
                  *WOSY_FeedXP("Switzerland",LegumesNoSoyNoAlfalfa,"Crop")
                         /WOSY_FeedXP("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop");
DomestAvailActIOEnv(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageProdSystem","TotFeedXP","CurrentSituation")
                 $WOSY_FeedXP("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =DomestAvailActIOEnv("ActGroup_Legumes","Crop","Switzerland","AverageProdSystem","TotFeedXP","CurrentSituation")
                  *WOSY_FeedXP("Switzerland",LegumesNoSoyNoAlfalfa,"Crop")
                         /WOSY_FeedXP("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop");
ImpActQuant(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedXP","CurrentSituation")
                 $WOSY_FeedXP("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop")
         =ImpActQuant("ActGroup_Legumes","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedXP","CurrentSituation")
                  *WOSY_FeedXP("Switzerland",LegumesNoSoyNoAlfalfa,"Crop")
                         /WOSY_FeedXP("Switzerland","ActGroup_LegumesNoSoyNoAlfalfa","Crop");

ProdActIOEnv(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_DM","AverageSeason","CurrentSituation")
         = ProdActIOEnv(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon("ActGroup_Legumes","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedDM_Cont","AverageSeason","CurrentSituation");
DomestAvailActIOEnv(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity_DM","CurrentSituation")
         = DomestAvailActIOEnv(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
                 *DomestAvailActIOEnvPerTon("ActGroup_Legumes","Crop","Switzerland","AverageProdSystem","DAQ_FeedDM_Cont","CurrentSituation");
ImpActQuant(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation")
         = ImpActQuant(LegumesNoSoyNoAlfalfa,"Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *ImpActQuantPerTon("ActGroup_Legumes","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation");

*as it is not part of organic feed supply, we add grassland separately from the grassland data:
*and as we hav grassland already filed in earlier, we also use this data and not the feed database data for conventional grass:

$offtext;
$ontext;
The following is not needed, as in the end, we anyway need subregions values - and grass is already available on this level - thus see further down, where it is allocated to ProdActIOen, import, DAW, as for other crops here.
ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"ProdQuantForFeed","AverageSeason","CurrentSituation")
         = sum((SwissGrassActivities,Switzerland_Subregions),ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProductionQuantity","AverageSeason","CurrentSituation"));
ImpActQuant("Grass","Crop","Switzerland",OrgConProdSystem,"Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = 0;
DomestAvailActIOEnv("Grass","Crop","Switzerland",OrgConProdSystem,"DomestAvailFeedQuantity","CurrentSituation")
         = ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"ProdQuantForFeed","AverageSeason","CurrentSituation");

already assigned - therefore not needed to be done here again:
*ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"ProdQuantForFeed_DM","AverageSeason","CurrentSituation")
*         = ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"ProdQuantForFeed","AverageSeason","CurrentSituation");
*ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedGE","AverageSeason","CurrentSituation")
*         = ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedGE","AverageSeason","CurrentSituation");
*ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedXP","AverageSeason","CurrentSituation")
*         = ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedXP","AverageSeason","CurrentSituation");

DomestAvailActIOEnv("Grass","Crop","Switzerland",OrgConProdSystem,"DomestAvailFeedQuantity_DM","CurrentSituation")
         = ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"ProdQuantForFeed","AverageSeason","CurrentSituation");
DomestAvailActIOEnv("Grass","Crop","Switzerland",OrgConProdSystem,"TotFeedGE","CurrentSituation")
         = ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedGE","AverageSeason","CurrentSituation");
DomestAvailActIOEnv("Grass","Crop","Switzerland",OrgConProdSystem,"TotFeedXP","CurrentSituation")
         = ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedXP","AverageSeason","CurrentSituation");

ImpActQuant("Grass","Crop","Switzerland",OrgConProdSystem,"Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation")
         = 0;
ImpActQuant("Grass","Crop","Switzerland",OrgConProdSystem,"Region_FAO_World","ImportFeedGE","CurrentSituation")
         = 0;
ImpActQuant("Grass","Crop","Switzerland",OrgConProdSystem,"Region_FAO_World","ImportFeedXP","CurrentSituation")
         = 0;
*derive average prod syst values, as the other feed is reported in those as well:
ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
         =sum(OrgConProdSystem,ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"ProdQuantForFeed","AverageSeason","CurrentSituation"));
ImpActQuant("Grass","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         =sum(OrgConProdSystem,ImpActQuant("Grass","Crop","Switzerland",OrgConProdSystem,"Region_FAO_World","ImportFeedQuantity","CurrentSituation"));
DomestAvailActIOEnv("Grass","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         =sum(OrgConProdSystem,DomestAvailActIOEnv("Grass","Crop","Switzerland",OrgConProdSystem,"DomestAvailFeedQuantity","CurrentSituation"));

ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_DM","AverageSeason","CurrentSituation")
         =sum(OrgConProdSystem,ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"ProdQuantForFeed_DM","AverageSeason","CurrentSituation"));
ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedGE","AverageSeason","CurrentSituation")
         =sum(OrgConProdSystem,ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedGE","AverageSeason","CurrentSituation"));
ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","TotFeedXP","AverageSeason","CurrentSituation")
         =sum(OrgConProdSystem,ProdActIOEnv("Grass","Crop","Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedXP","AverageSeason","CurrentSituation"));

DomestAvailActIOEnv("Grass","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity_DM","CurrentSituation")
         =sum(OrgConProdSystem,DomestAvailActIOEnv("Grass","Crop","Switzerland",OrgConProdSystem,"DomestAvailFeedQuantity_DM","CurrentSituation"));
DomestAvailActIOEnv("Grass","Crop","Switzerland","AverageProdSystem","TotFeedGE","CurrentSituation")
         =sum(OrgConProdSystem,DomestAvailActIOEnv("Grass","Crop","Switzerland",OrgConProdSystem,"TotFeedGE","CurrentSituation"));
DomestAvailActIOEnv("Grass","Crop","Switzerland","AverageProdSystem","TotFeedXP","CurrentSituation")
         =sum(OrgConProdSystem,DomestAvailActIOEnv("Grass","Crop","Switzerland",OrgConProdSystem,"TotFeedXP","CurrentSituation"));

ImpActQuant("Grass","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation")
         =sum(OrgConProdSystem,ImpActQuant("Grass","Crop","Switzerland",OrgConProdSystem,"Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation"));
ImpActQuant("Grass","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedGE","CurrentSituation")
         =sum(OrgConProdSystem,ImpActQuant("Grass","Crop","Switzerland",OrgConProdSystem,"Region_FAO_World","ImportFeedGE","CurrentSituation"));
ImpActQuant("Grass","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedXP","CurrentSituation")
         =sum(OrgConProdSystem,ImpActQuant("Grass","Crop","Switzerland",OrgConProdSystem,"Region_FAO_World","ImportFeedXP","CurrentSituation"));
$offtext;

$ontext;
for completeness, we note here the parameters available for grass after 05_1:
ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedME","AverageSeason","CurrentSituation")
         = ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProductionQuantity","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"Output_FeedME_Cont","AverageSeason","CurrentSituation");
ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedGE","AverageSeason","CurrentSituation")
         = ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProductionQuantity","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"Output_FeedGE_Cont","AverageSeason","CurrentSituation");
ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedXP","AverageSeason","CurrentSituation")
ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType","AverageProdSystem","ProductionQuantity","AverageSeason","CurrentSituation")
$offtext;

$ontext;
*and add organic values for forage as this is not reported in the feed data: maize for forage and silage and beets for fodder;
*for those, we have each AverageProdSystem values - thus derive organic based on relative organic feed demand, then derive conventional with the general code below.
*'Hackfrüchte'
*we assume them to be Beets for Fodder
DomestAvailActIOEnv("Beets for Fodder","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 $sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
         = DomestAvailActIOEnv("Beets for Fodder","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
                 *sum(Switzerland_Subregions,AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate","Organic","FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
                         /sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"));

ImpActQuant("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 $sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
         = ImpActQuant("Beets for Fodder","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *sum(Switzerland_Subregions,AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate","Organic","FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
                         /sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"));

ProdActIOEnv("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 $sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
         = ProdActIOEnv("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *sum(Switzerland_Subregions,AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate","Organic","FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
                         /sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"));
*'Grünmais'
DomestAvailActIOEnv("Maize For Forage+Silage","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 $sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
         = DomestAvailActIOEnv("Maize For Forage+Silage","Crop","Switzerland","AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
                 *sum(Switzerland_Subregions,AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate","Organic","FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
                         /sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"));

ImpActQuant("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 $sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
         = ImpActQuant("Maize For Forage+Silage","Crop","Switzerland","AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *sum(Switzerland_Subregions,AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate","Organic","FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
                         /sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"));

ProdActIOEnv("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 $sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
         = ProdActIOEnv("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *sum(Switzerland_Subregions,AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate","Organic","FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"))
                         /sum((Switzerland_Subregions,OrgConProdSystem),AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",OrgConProdSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"));

*as the structure is somewhat different - do the macro by hand:
*the macro is: *AssignNutrContFeedData_Alpenprojekt("Beets for Fodder","Hackfrüchte","Crop","AverageProdSystem");
*begin calculatiosn that are in this macro
DomestAvailActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","Organic","DAQ_FeedGE_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageProdSystem","DAQ_FeedGE_Cont","CurrentSituation");
DomestAvailActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","Organic","DAQ_FeedXP_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageProdSystem","DAQ_FeedXP_Cont","CurrentSituation");
DomestAvailActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","Organic","DAQ_FeedDM_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageProdSystem","DAQ_FeedDM_Cont","CurrentSituation");

ImpActQuantPerTon("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedGE_Cont","CurrentSituation")
         = ImpActQuantPerTon("Beets for Fodder","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedGE_Cont","CurrentSituation");
ImpActQuantPerTon("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedXP_Cont","CurrentSituation")
         = ImpActQuantPerTon("Beets for Fodder","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedXP_Cont","CurrentSituation");
ImpActQuantPerTon("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation")
         = ImpActQuantPerTon("Beets for Fodder","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation");

ProdActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedGE_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedGE_Cont","AverageSeason","CurrentSituation");
ProdActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedXP_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedXP_Cont","AverageSeason","CurrentSituation");
ProdActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedDM_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedDM_Cont","AverageSeason","CurrentSituation");

*derive totals from quantities and contents:
DomestAvailActIOEnv("Beets for Fodder","Crop","Switzerland","Organic","DomestAvailFeedQuantity_DM","CurrentSituation")
         =DomestAvailActIOEnv("Beets for Fodder","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 *DomestAvailActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","Organic","DAQ_FeedDM_Cont","CurrentSituation");
DomestAvailActIOEnv("Beets for Fodder","Crop","Switzerland","Organic","TotFeedGE","CurrentSituation")
         =DomestAvailActIOEnv("Beets for Fodder","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 *DomestAvailActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","Organic","DAQ_FeedGE_Cont","CurrentSituation");
DomestAvailActIOEnv("Beets for Fodder","Crop","Switzerland","Organic","TotFeedXP","CurrentSituation")
         =DomestAvailActIOEnv("Beets for Fodder","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 *DomestAvailActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","Organic","DAQ_FeedXP_Cont","CurrentSituation");

ImpActQuant("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation")
         =ImpActQuant("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *ImpActQuantPerTon("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation");
ImpActQuant("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedGE","CurrentSituation")
         =ImpActQuant("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *ImpActQuantPerTon("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedGE_Cont","CurrentSituation");
ImpActQuant("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedXP","CurrentSituation")
         =ImpActQuant("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *ImpActQuantPerTon("Beets for Fodder","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedXP_Cont","CurrentSituation");

ProdActIOEnv("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed_DM","AverageSeason","CurrentSituation")
         =ProdActIOEnv("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedDM_Cont","AverageSeason","CurrentSituation");
ProdActIOEnv("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","TotFeedGE","AverageSeason","CurrentSituation")
         =ProdActIOEnv("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedGE_Cont","AverageSeason","CurrentSituation");
ProdActIOEnv("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","TotFeedXP","AverageSeason","CurrentSituation")
         =ProdActIOEnv("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon("Beets for Fodder","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedXP_Cont","AverageSeason","CurrentSituation");
*end calculations that are in the macro *AssignNutrContFeedData_Alpenprojekt("Beets for Fodder","Hackfrüchte","Crop","AverageProdSystem");

*the macro is: *AssignNutrContFeedData_Alpenprojekt("Maize For Forage+Silage","Grünmais","Crop","AverageProdSystem");
*begin calculatiosn that are in this macro
DomestAvailActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","DAQ_FeedGE_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageProdSystem","DAQ_FeedGE_Cont","CurrentSituation");
DomestAvailActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","DAQ_FeedXP_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageProdSystem","DAQ_FeedXP_Cont","CurrentSituation");
DomestAvailActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","DAQ_FeedDM_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageProdSystem","DAQ_FeedDM_Cont","CurrentSituation");

ImpActQuantPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedGE_Cont","CurrentSituation")
         = ImpActQuantPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedGE_Cont","CurrentSituation");
ImpActQuantPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedXP_Cont","CurrentSituation")
         = ImpActQuantPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedXP_Cont","CurrentSituation");
ImpActQuantPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation")
         = ImpActQuantPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation");

ProdActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedGE_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedGE_Cont","AverageSeason","CurrentSituation");
ProdActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedXP_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedXP_Cont","AverageSeason","CurrentSituation");
ProdActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedDM_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedDM_Cont","AverageSeason","CurrentSituation");

*derive totals from quantities and contents:
DomestAvailActIOEnv("Maize For Forage+Silage","Crop","Switzerland","Organic","DomestAvailFeedQuantity_DM","CurrentSituation")
         =DomestAvailActIOEnv("Maize For Forage+Silage","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 *DomestAvailActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","DAQ_FeedDM_Cont","CurrentSituation");
DomestAvailActIOEnv("Maize For Forage+Silage","Crop","Switzerland","Organic","TotFeedGE","CurrentSituation")
         =DomestAvailActIOEnv("Maize For Forage+Silage","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 *DomestAvailActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","DAQ_FeedGE_Cont","CurrentSituation");
DomestAvailActIOEnv("Maize For Forage+Silage","Crop","Switzerland","Organic","TotFeedXP","CurrentSituation")
         =DomestAvailActIOEnv("Maize For Forage+Silage","Crop","Switzerland","Organic","DomestAvailFeedQuantity","CurrentSituation")
                 *DomestAvailActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","DAQ_FeedXP_Cont","CurrentSituation");

ImpActQuant("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation")
         =ImpActQuant("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *ImpActQuantPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation");
ImpActQuant("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedGE","CurrentSituation")
         =ImpActQuant("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *ImpActQuantPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedGE_Cont","CurrentSituation");
ImpActQuant("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedXP","CurrentSituation")
         =ImpActQuant("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
                 *ImpActQuantPerTon("Maize For Forage+Silage","Crop","Switzerland","Organic","Region_FAO_World","Output_FeedXP_Cont","CurrentSituation");

ProdActIOEnv("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed_DM","AverageSeason","CurrentSituation")
         =ProdActIOEnv("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedDM_Cont","AverageSeason","CurrentSituation");
ProdActIOEnv("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","TotFeedGE","AverageSeason","CurrentSituation")
         =ProdActIOEnv("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedGE_Cont","AverageSeason","CurrentSituation");
ProdActIOEnv("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","TotFeedXP","AverageSeason","CurrentSituation")
         =ProdActIOEnv("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","ProdQuantForFeed","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon("Maize For Forage+Silage","Crop","Switzerland","AverageClimate","AverageSoilType","Organic","Output_FeedXP_Cont","AverageSeason","CurrentSituation");
*end calculations that are in the macro *AssignNutrContFeedData_Alpenprojekt("Maize For Forage+Silage","Grünmais","Crop","AverageProdSystem");

$offtext;
*we have now the following feed supply variables:
$ontext;
DomestAvailActIOEnv(ActivityUnits,Yield_Type,"Switzerland",ProductionSystem,"DomestAvailFeedQuantity","CurrentSituation")
ImpActQuant(ActivityUnits,Yield_Type,"Switzerland",ProductionSystem,"Region_FAO_World","ImportFeedQuantity","CurrentSituation")
ProdActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"ProdQuantForFeed","AverageSeason","CurrentSituation")

DomestAvailActIOEnv(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"DomestAvailFeedQuantity_DM","CurrentSituation")
DomestAvailActIOEnv(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"TotFeedGE","CurrentSituation")
DomestAvailActIOEnv(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"TotFeedXP","CurrentSituation")
ImpActQuant(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation")
ImpActQuant(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"Region_FAO_World","ImportFeedGE","CurrentSituation")
ImpActQuant(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"Region_FAO_World","ImportFeedXP","CurrentSituation")
ProdActIOEnv(ActivityUnits,YieldType,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"ProdQuantForFeed_DM","AverageSeason","CurrentSituation")
ProdActIOEnv(ActivityUnits,YieldType,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"TotFeedGE","AverageSeason","CurrentSituation")
ProdActIOEnv(ActivityUnits,YieldType,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"TotFeedXP","AverageSeason","CurrentSituation")

DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",ProductionSystem,"FeedQuantityFromByprod","CurrentSituation")
ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",ProductionSystem,"Region_FAO_World","ImportFeedQuantity_Byprod","CurrentSituation")
ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"ProdQuantForFeed_Byprod","AverageSeason","CurrentSituation")

DomestAvailActIOEnv(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"FeedQuantityFromByprod_DM","CurrentSituation")
DomestAvailActIOEnv(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"FeedGE_Byp","CurrentSituation")
DomestAvailActIOEnv(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"FeedXP_Byp","CurrentSituation")
ImpActQuant(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"Region_FAO_World","ImportFeedQuantity_Byprod_DM","CurrentSituation")
ImpActQuant(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"Region_FAO_World","ImportFeedGE_Byp","CurrentSituation")
ImpActQuant(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"Region_FAO_World","ImportFeedXP_Byp","CurrentSituation")
ProdActIOEnv(ActivityUnits,YieldType,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"ProdQuantForFeed_DM_Byprod","AverageSeason","CurrentSituation")
ProdActIOEnv(ActivityUnits,YieldType,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"TotFeedGE_Byp","AverageSeason","CurrentSituation")
ProdActIOEnv(ActivityUnits,YieldType,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"TotFeedXP_Byp","AverageSeason","CurrentSituation")

DomestAvailActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland",ProductionSystem,"DomestAvailResidueFeedQuantity","CurrentSituation")
ImpActQuant(&CommodityGroup_SOLm,&ProductType,"Switzerland",ProductionSystem,"Region_FAO_World","ImportResidueFeedQuantity","CurrentSituation")
ProdActIOEnv(&CommodityGroup_SOLm,&ProductType,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"ResidueQuantForFeed","AverageSeason","CurrentSituation")

DomestAvailActIOEnv(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"FeedQuantityFromResidue_DM","CurrentSituation")
DomestAvailActIOEnv(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"FeedGE_Resid","CurrentSituation")
DomestAvailActIOEnv(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"FeedXP_Resid","CurrentSituation")
ImpActQuant(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"Region_FAO_World","ImportFeedQuantity_Residue_DM","CurrentSituation")
ImpActQuant(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"Region_FAO_World","ImportFeedGE_Resid","CurrentSituation")
ImpActQuant(ActivityUnits,YieldType,"Switzerland",ProductionSystem,"Region_FAO_World","ImportFeedXP_Resid","CurrentSituation")
ProdActIOEnv(ActivityUnits,YieldType,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"ProdQuantForFeed_DM_Residue","AverageSeason","CurrentSituation")
ProdActIOEnv(ActivityUnits,YieldType,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"TotFeedGE_Resid","AverageSeason","CurrentSituation")
ProdActIOEnv(ActivityUnits,YieldType,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"TotFeedXP_Resid","AverageSeason","CurrentSituation")
$offtext;

$ontext;
*and we cave average prod syst and organic values - thus derive conventional values:
*for this, first define some sets to simplify the code:
SET DeriveConventional_DAQ_Alpenprojekt(IOEnv_DAQ)
                 /DomestAvailFeedQuantity,DomestAvailFeedQuantity_DM,TotFeedGE,TotFeedXP,
                 FeedQuantityFromByprod,FeedQuantityFromByprod_DM,FeedGE_Byp,FeedXP_Byp,
                 DomestAvailResidueFeedQuantity,FeedQuantityFromResidue_DM,FeedGE_Resid,FeedXP_Resid/;

SET DeriveConventional_Import_Alpenprojekt(Utilization)
                 /ImportFeedQuantity,ImportFeedQuantity_DM,ImportFeedGE,ImportFeedXP,
                 ImportFeedQuantity_Byprod,ImportFeedQuantity_Byprod_DM,ImportFeedGE_Byp,ImportFeedXP_Byp,
                 ImportResidueFeedQuantity,ImportFeedQuantity_Residue_DM,ImportFeedGE_Resid,ImportFeedXP_Resid/;

SET DeriveConventional_Prod_Alpenprojekt(IOEnv)
                 /ProdQuantForFeed,ProdQuantForFeed_DM,TotFeedGE,TotFeedXP,
                 ProdQuantForFeed_Byprod,ProdQuantForFeed_DM_Byprod,TotFeedGE_Byp,TotFeedXP_Byp,
                 ResidueQuantForFeed,ProdQuantForFeed_DM_Residue,TotFeedGE_Resid,TotFeedXP_Resid/;

*then assign the various contents - conventioanl = average:
DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","DAQ_FeedGE_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","DAQ_FeedGE_Cont","CurrentSituation");
DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","DAQ_FeedXP_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","DAQ_FeedXP_Cont","CurrentSituation");
DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","DAQ_FeedDM_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","DAQ_FeedDM_Cont","CurrentSituation");

ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","Region_FAO_World","Output_FeedGE_Cont","CurrentSituation")
         = ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedGE_Cont","CurrentSituation");
ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","Region_FAO_World","Output_FeedXP_Cont","CurrentSituation")
         = ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedXP_Cont","CurrentSituation");
ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation")
         = ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedDM_Cont","CurrentSituation");

ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","Conventional","Output_FeedGE_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedGE_Cont","AverageSeason","CurrentSituation");
ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","Conventional","Output_FeedXP_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedXP_Cont","AverageSeason","CurrentSituation");
ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","Conventional","Output_FeedDM_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedDM_Cont","AverageSeason","CurrentSituation");

*and assign the byprod contents as well:
DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","DAQ_FeedGE_Byp_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","DAQ_FeedGE_Byp_Cont","CurrentSituation");
DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","DAQ_FeedXP_Byp_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","DAQ_FeedXP_Byp_Cont","CurrentSituation");
DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","DAQ_FeedDM_Byp_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","DAQ_FeedDM_Byp_Cont","CurrentSituation");

ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","Region_FAO_World","Output_FeedGE_Byp_Cont","CurrentSituation")
         = ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedGE_Byp_Cont","CurrentSituation");
ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","Region_FAO_World","Output_FeedXP_Byp_Cont","CurrentSituation")
         = ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedXP_Byp_Cont","CurrentSituation");
ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","Conventional","Region_FAO_World","Output_FeedDM_Byp_Cont","CurrentSituation")
         = ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","Region_FAO_World","Output_FeedDM_Byp_Cont","CurrentSituation");

ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","Conventional","Output_FeedGE_Byp_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedGE_Byp_Cont","AverageSeason","CurrentSituation");
ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","Conventional","Output_FeedXP_Byp_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedXP_Byp_Cont","AverageSeason","CurrentSituation");
ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","Conventional","Output_FeedDM_Byp_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","AverageProdSystem","Output_FeedDM_Byp_Cont","AverageSeason","CurrentSituation");


*if there is only organic anc no Average system, then assign organic to average
DomestAvailActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem",DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation")
                  $(NOT DomestAvailActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem",DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation"))
         = DomestAvailActIOEnv(ActivityUnits,Yield_Type,"Switzerland","Organic",DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation");
ImpActQuant(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation")
                 $(NOT ImpActQuant(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation"))
         = ImpActQuant(ActivityUnits,Yield_Type,"Switzerland","Organic","Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation");
ProdActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","AverageProdSystem",DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation")
                 $(NOT ProdActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","AverageProdSystem",DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation"))
         = ProdActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","Organic",DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation");


DomestAvailActIOEnv(ActivityUnits,Yield_Type,"Switzerland","Conventional",DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation")
                 $DomestAvailActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem",DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation")
         = DomestAvailActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem",DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation")
                 - DomestAvailActIOEnv(ActivityUnits,Yield_Type,"Switzerland","Organic",DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation");

ImpActQuant(ActivityUnits,Yield_Type,"Switzerland","Conventional","Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation")
                 $ImpActQuant(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation")
         = ImpActQuant(ActivityUnits,Yield_Type,"Switzerland","AverageProdSystem","Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation")
                 - ImpActQuant(ActivityUnits,Yield_Type,"Switzerland","Organic","Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation");

ProdActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","Conventional",DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation")
                 $ProdActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","AverageProdSystem",DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation")
         = ProdActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","AverageProdSystem",DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation")
                 - ProdActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType","Organic",DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation");

$offtext;
$ontext;
What SOLm uses:

DomestAvailActIOEnv(ActivityUnits,Yield_Type,GeographicUnits,OrgConProdSystem,"TotFeedGE","CurrentSituation")
DomestAvailActIOEnv(ActivityUnits,Yield_Type,GeographicUnits,OrgConProdSystem,"FeedGE_Byp","CurrentSituation")
DomestAvailActIOEnv(ActivityUnits,Yield_Type,GeographicUnits,OrgConProdSystem,"TotFeedXP","CurrentSituation")
DomestAvailActIOEnv(ActivityUnits,Yield_Type,GeographicUnits,OrgConProdSystem,"FeedXP_Byp","CurrentSituation")
DomestAvailActIOEnv(ActivityUnits,Yield_Type,GeographicUnits,OrgConProdSystem,"DomestAvailFeedQuantity","CurrentSituation")
DomestAvailActIOEnv(ActivityUnits,Yield_Type,GeographicUnits,OrgConProdSystem,"DomestAvailFeedQuantity_DM","CurrentSituation")

ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedGE","AverageSeason","CurrentSituation")
ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedXP","AverageSeason","CurrentSituation")
DomestAvailActIOEnv(GrassActivities,"Crop",GeographicUnits,OrgConProdSystem,"DomestAvailQuantity","CurrentSituation")
ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProductionQuantity","AverageSeason","CurrentSituation");
DomestAvailActIOEnv(GrassActivities,"Crop",GeographicUnits,OrgConProdSystem,"TotFeedGE","CurrentSituation")
DomestAvailActIOEnv(GrassActivities,"Crop",GeographicUnits,OrgConProdSystem,"TotFeedXP","CurrentSituation")

WHAT we have in AP:

DomestAvailActIOEnv(ActivityUnits,Yield_Type,"Switzerland",OrgConProdSystem,DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation")
ImpActQuant(ActivityUnits,Yield_Type,"Switzerland",OrgConProdSystem,"Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation")
ProdActIOEnv(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType",OrgConProdSystem,DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation")
For:
SET DeriveConventional_DAQ_Alpenprojekt(IOEnv_DAQ)
                 /DomestAvailFeedQuantity,DomestAvailFeedQuantity_DM,TotFeedGE,TotFeedXP,
                 FeedQuantityFromByprod,FeedQuantityFromByprod_DM,FeedGE_Byp,FeedXP_Byp,
                 DomestAvailResidueFeedQuantity,FeedQuantityFromResidue_DM,FeedGE_Resid,FeedXP_Resid/;

SET DeriveConventional_Import_Alpenprojekt(Utilization)
                 /ImportFeedQuantity,ImportFeedQuantity_DM,ImportFeedGE,ImportFeedXP,
                 ImportFeedQuantity_Byprod,ImportFeedQuantity_Byprod_DM,ImportFeedGE_Byp,ImportFeedXP_Byp,
                 ImportResidueFeedQuantity,ImportFeedQuantity_Residue_DM,ImportFeedGE_Resid,ImportFeedXP_Resid/;

SET DeriveConventional_Prod_Alpenprojekt(IOEnv)
                 /ProdQuantForFeed,ProdQuantForFeed_DM,TotFeedGE,TotFeedXP,
                 ProdQuantForFeed_Byprod,ProdQuantForFeed_DM_Byprod,TotFeedGE_Byp,TotFeedXP_Byp,
                 ResidueQuantForFeed,ProdQuantForFeed_DM_Residue,TotFeedGE_Resid,TotFeedXP_Resid/;

incl. grass and forage for org/conv prod. system
$offtext;
$ontext;
*NOW ALLOCATE these values for Switzerland to the Subregions!
*first assign the various contents - conventioanl = average:
DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"DAQ_FeedGE_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland",ProductionSystem,"DAQ_FeedGE_Cont","CurrentSituation");
DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"DAQ_FeedXP_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland",ProductionSystem,"DAQ_FeedXP_Cont","CurrentSituation");
DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"DAQ_FeedDM_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland",ProductionSystem,"DAQ_FeedDM_Cont","CurrentSituation");

ImpActQuantPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World","Output_FeedGE_Cont","CurrentSituation")
         = ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland",ProductionSystem,"Region_FAO_World","Output_FeedGE_Cont","CurrentSituation");
ImpActQuantPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World","Output_FeedXP_Cont","CurrentSituation")
         = ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland",ProductionSystem,"Region_FAO_World","Output_FeedXP_Cont","CurrentSituation");
ImpActQuantPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World","Output_FeedDM_Cont","CurrentSituation")
         = ImpActQuantPerTon(ActivityUnits,Yield_Type,"Switzerland",ProductionSystem,"Region_FAO_World","Output_FeedDM_Cont","CurrentSituation");

ProdActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedGE_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedGE_Cont","AverageSeason","CurrentSituation");
ProdActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedXP_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedXP_Cont","AverageSeason","CurrentSituation");
ProdActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedDM_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon(ActivityUnits,Yield_Type,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedDM_Cont","AverageSeason","CurrentSituation");

*and assign also GW, XP per DM contents:
DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"DAQ_FeedGE_DM_Cont","CurrentSituation")
                 $DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"DAQ_FeedDM_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"DAQ_FeedGE_Cont","CurrentSituation")
                 /DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"DAQ_FeedDM_Cont","CurrentSituation");
DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"DAQ_FeedXP_DM_Cont","CurrentSituation")
                 $DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"DAQ_FeedDM_Cont","CurrentSituation")
         = DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"DAQ_FeedXP_Cont","CurrentSituation")
                 /DomestAvailActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"DAQ_FeedDM_Cont","CurrentSituation");

ImpActQuantPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World","Output_FeedGE_DM_Cont","CurrentSituation")
                 $ImpActQuantPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World","Output_FeedDM_Cont","CurrentSituation")
         = ImpActQuantPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World","Output_FeedGE_Cont","CurrentSituation")
                 /ImpActQuantPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World","Output_FeedDM_Cont","CurrentSituation");
ImpActQuantPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World","Output_FeedXP_DM_Cont","CurrentSituation")
                 $ImpActQuantPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World","Output_FeedDM_Cont","CurrentSituation")
         = ImpActQuantPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World","Output_FeedXP_Cont","CurrentSituation")
                 /ImpActQuantPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World","Output_FeedDM_Cont","CurrentSituation");

ProdActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedGE_DM_Cont","AverageSeason","CurrentSituation")
                 $ProdActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedDM_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedGE_Cont","AverageSeason","CurrentSituation")
                 /ProdActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedDM_Cont","AverageSeason","CurrentSituation");
ProdActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedXP_DM_Cont","AverageSeason","CurrentSituation")
                 $ProdActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedDM_Cont","AverageSeason","CurrentSituation")
         = ProdActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedXP_Cont","AverageSeason","CurrentSituation")
                 /ProdActIOEnvPerTon(ActivityUnits,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"Output_FeedDM_Cont","AverageSeason","CurrentSituation");

*then and assign all quantities Switzerland to subregions in relation to total within-subregion FeedGE demand:
*for concentrates and foragecrops, not for grass, as this is already on subregion level.
AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
         = sum(Switzerland_Subregions,AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation"));
AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation")
         = sum(Switzerland_Subregions,AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",ProductionSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation"));

DomestAvailActIOEnv(Concentrates,Yield_Type,Switzerland_Subregions,ProductionSystem,DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation")
                 $AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
         = DomestAvailActIOEnv(Concentrates,Yield_Type,"Switzerland",ProductionSystem,DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation")
                 *AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
                         /AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation");
DomestAvailActIOEnv(ForageCrops,Yield_Type,Switzerland_Subregions,ProductionSystem,DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation")
                 $AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation")
         = DomestAvailActIOEnv(ForageCrops,Yield_Type,"Switzerland",ProductionSystem,DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation")
                 *AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",ProductionSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation")
                         /AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation");

ImpActQuant(Concentrates,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation")
                 $AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
         = ImpActQuant(Concentrates,Yield_Type,"Switzerland",ProductionSystem,"Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation")
                 *AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
                         /AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation");
ImpActQuant(ForageCrops,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation")
                 $AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation")
         = ImpActQuant(ForageCrops,Yield_Type,"Switzerland",ProductionSystem,"Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation")
                 *AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",ProductionSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation")
                         /AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation");

ProdActIOEnv(Concentrates,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation")
                 $AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
         = ProdActIOEnv(Concentrates,Yield_Type,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation")
                 *AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
                         /AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation");
ProdActIOEnv(ForageCrops,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation")
                 $AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation")
         = ProdActIOEnv(ForageCrops,Yield_Type,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation")
                 *AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",ProductionSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation")
                         /AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_ForageCrops_Demand","AverageSeason","CurrentSituation");

*and assign the animal source feed similar to concentrates:
DomestAvailActIOEnv(Animals,Yield_Type,Switzerland_Subregions,ProductionSystem,DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation")
                 $AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
         = DomestAvailActIOEnv(Animals,Yield_Type,"Switzerland",ProductionSystem,DeriveConventional_DAQ_Alpenprojekt,"CurrentSituation")
                 *AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
                         /AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation");
ImpActQuant(Animals,Yield_Type,Switzerland_Subregions,ProductionSystem,"Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation")
                 $AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
         = ImpActQuant(Animals,Yield_Type,"Switzerland",ProductionSystem,"Region_FAO_World",DeriveConventional_Import_Alpenprojekt,"CurrentSituation")
                 *AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
                         /AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation");
ProdActIOEnv(Animals,Yield_Type,Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation")
                 $AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
         = ProdActIOEnv(Animals,Yield_Type,"Switzerland","AverageClimate","AverageSoilType",ProductionSystem,DeriveConventional_Prod_Alpenprojekt,"AverageSeason","CurrentSituation")
                 *AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd",Switzerland_Subregions,"AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation")
                         /AnimalProdActIOEnv("ActGroup_Animals","AllTypes","AnyRoleInHerd","Switzerland","AverageClimate",ProductionSystem,"FeedGE_Concentrates_Demand","AverageSeason","CurrentSituation");

*and now do grass:
$offtext;
$ontext;
for completeness, we note here the parameters available for grass after 05_1:
ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedME","AverageSeason","CurrentSituation")
         = ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProductionQuantity","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"Output_FeedME_Cont","AverageSeason","CurrentSituation");
ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedGE","AverageSeason","CurrentSituation")
         = ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProductionQuantity","AverageSeason","CurrentSituation")
                 *ProdActIOEnvPerTon(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"Output_FeedGE_Cont","AverageSeason","CurrentSituation");
ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedXP","AverageSeason","CurrentSituation")
ProdActIOEnv(GrassActivities,"Crop",GeographicUnits,"AverageClimate","AverageSoilType","AverageProdSystem","ProductionQuantity","AverageSeason","CurrentSituation")
$offtext;
$ontext;
*ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProductionQuantity","AverageSeason","CurrentSituation")
*prod is already present thus do not assign again
ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = 0;
DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"DomestAvailFeedQuantity","CurrentSituation")
         = ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProductionQuantity","AverageSeason","CurrentSituation")
                 *DomestAvailActIOEnvShares(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Feed","CurrentSituation")
                 +ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Region_FAO_World","ImportFeedQuantity","CurrentSituation");

ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProdQuantForFeed_DM","AverageSeason","CurrentSituation")
         = ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProductionQuantity","AverageSeason","CurrentSituation")
                 *DomestAvailActIOEnvShares(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Feed","CurrentSituation");
*ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedGE","AverageSeason","CurrentSituation")
*this is already present, thus do not assign again
*ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedXP","AverageSeason","CurrentSituation")
*this is already present, thus do not assign again

DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"DomestAvailFeedQuantity_DM","CurrentSituation")
         = DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"DomestAvailFeedQuantity","CurrentSituation");

ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation")
         = 0;
ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Region_FAO_World","ImportFeedGE","CurrentSituation")
         = 0;
ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Region_FAO_World","ImportFeedXP","CurrentSituation")
         = 0;

*swiss grasslands show a massive oversupply for alpine pastures, therefore differentiate between production and produciton used as food:
*thus: production quantity and DAQ are ALL that is there, DAFeedQ and ProdQuantForFeed are only those quantities, that are utilized for feed; thus, the
*ProdQuant and DAQ correspond to TotFeedGE_FeedAndOther, and the same for XP, and TotFeedGE corresponds to DAFeedQ, etc.
DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"TotFeedGE_FeedAndOther","CurrentSituation")
         = ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedGE","AverageSeason","CurrentSituation")
                 +ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Region_FAO_World","ImportFeedGE","CurrentSituation");
DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"TotFeedXP_FeedAndOther","CurrentSituation")
         = ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedXP","AverageSeason","CurrentSituation")
                 +ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Region_FAO_World","ImportFeedXP","CurrentSituation");

DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"TotFeedGE","CurrentSituation")
         = DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"TotFeedGE_FeedAndOther","CurrentSituation")
                 *DomestAvailActIOEnvShares(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Feed","CurrentSituation");
DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"TotFeedXP","CurrentSituation")
         = DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"TotFeedXP_FeedAndOther","CurrentSituation")
                 *DomestAvailActIOEnvShares(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Feed","CurrentSituation");

*derive average prod syst values, as the other feed is reported in those as well:
ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType","AverageProdSystem","ProductionQuantity","AverageSeason","CurrentSituation")
         =sum(OrgConProdSystem,ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProductionQuantity","AverageSeason","CurrentSituation"));
ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageProdSystem","Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         =sum(OrgConProdSystem,ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Region_FAO_World","ImportFeedQuantity","CurrentSituation"));
DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageProdSystem","DomestAvailFeedQuantity","CurrentSituation")
         =sum(OrgConProdSystem,DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"DomestAvailFeedQuantity","CurrentSituation"));

ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType","AverageProdSystem","ProdQuantForFeed_DM","AverageSeason","CurrentSituation")
         =sum(OrgConProdSystem,ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"ProdQuantForFeed_DM","AverageSeason","CurrentSituation"));
ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType","AverageProdSystem","TotFeedGE","AverageSeason","CurrentSituation")
         =sum(OrgConProdSystem,ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedGE","AverageSeason","CurrentSituation"));
ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType","AverageProdSystem","TotFeedXP","AverageSeason","CurrentSituation")
         =sum(OrgConProdSystem,ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",OrgConProdSystem,"TotFeedXP","AverageSeason","CurrentSituation"));

DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageProdSystem","DomestAvailFeedQuantity_DM","CurrentSituation")
         =sum(OrgConProdSystem,DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"DomestAvailFeedQuantity_DM","CurrentSituation"));
DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageProdSystem","TotFeedGE","CurrentSituation")
         =sum(OrgConProdSystem,DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"TotFeedGE","CurrentSituation"));
DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageProdSystem","TotFeedXP","CurrentSituation")
         =sum(OrgConProdSystem,DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"TotFeedXP","CurrentSituation"));

DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageProdSystem","TotFeedGE_FeedAndOther","CurrentSituation")
         =sum(OrgConProdSystem,DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"TotFeedGE_FeedAndOther","CurrentSituation"));
DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageProdSystem","TotFeedXP_FeedAndOther","CurrentSituation")
         =sum(OrgConProdSystem,DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"TotFeedXP_FeedAndOther","CurrentSituation"));

ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageProdSystem","Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation")
         =sum(OrgConProdSystem,ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Region_FAO_World","ImportFeedQuantity_DM","CurrentSituation"));
ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageProdSystem","Region_FAO_World","ImportFeedGE","CurrentSituation")
         =sum(OrgConProdSystem,ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Region_FAO_World","ImportFeedGE","CurrentSituation"));
ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageProdSystem","Region_FAO_World","ImportFeedXP","CurrentSituation")
         =sum(OrgConProdSystem,ImpActQuant(SwissGrassActivities,"Crop",Switzerland_Subregions,OrgConProdSystem,"Region_FAO_World","ImportFeedXP","CurrentSituation"));

$offtext;


$ontext;
the following is not needed - "Graass" in combination with Swiss subregions should always be zer!! - as in subregions, we have SwissGrassActivities, and Grass is only used globally!
ProdActIOEnv("Grass","Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"ProdQuantForFeed","AverageSeason","CurrentSituation")
         = sum(SwissGrassActivities,ProdActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"ProductionQuantity","AverageSeason","CurrentSituation"));
ImpActQuant("Grass","Crop",Switzerland_Subregions,ProductionSystem,"Region_FAO_World","ImportFeedQuantity","CurrentSituation")
         = 0;
DomestAvailActIOEnv("Grass","Crop",Switzerland_Subregions,ProductionSystem,"DomestAvailFeedQuantity","CurrentSituation")
         = ProdActIOEnv("Grass","Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"ProdQuantForFeed","AverageSeason","CurrentSituation");

DomestAvailActIOEnv("Grass","Crop",Switzerland_Subregions,ProductionSystem,"TotFeedGE","CurrentSituation")
         = sum(SwissGrassActivities,DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,ProductionSystem,"TotFeedGE","CurrentSituation"));
DomestAvailActIOEnv("Grass","Crop",Switzerland_Subregions,ProductionSystem,"TotFeedXP","CurrentSituation")
         = sum(SwissGrassActivities,DomestAvailActIOEnv(SwissGrassActivities,"Crop",Switzerland_Subregions,ProductionSystem,"TotFeedXP","CurrentSituation"));

ProdActIOEnv("Grass","Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"TotFeedGE","AverageSeason","CurrentSituation")
         = DomestAvailActIOEnv("Grass","Crop",Switzerland_Subregions,ProductionSystem,"TotFeedGE","CurrentSituation");
ProdActIOEnv("Grass","Crop",Switzerland_Subregions,"AverageClimate","AverageSoilType",ProductionSystem,"TotFeedXP","AverageSeason","CurrentSituation")
         = DomestAvailActIOEnv("Grass","Crop",Switzerland_Subregions,ProductionSystem,"TotFeedXP","CurrentSituation");
$offtext;





***GO ON HERE!!!

$ontext;
FeedSupplyPerAnimal(Concentrates,"Crop",Animals,Yield_Type,RoleInHerd,GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"FeedME","AverageSeason","CurrentSituation")

FeedSupplyPerAnimal(Concentrates,"Crop",Animals,Yield_Type,RoleInHerd,GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"FeedDMQuant_MEBased","AverageSeason","CurrentSituation")



GET: feed supply in DM FM GE XP
- capture some assumptions in feeding rations
- in total (domest avail quant)
- production / imports / exports
- allocated per animal for all animal types (allocate to animal species based on GVE plus assumptions on feeding rations)
$offtext;






*END Alpenprojekt
$label EndAlpenprojekt

$ontext;
THE FOLLOWING lists what can be replaced by new data in this module:

FeedSupplyPerAnimal(Concentrates,"Crop",Animals,Yield_Type,RoleInHerd,GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"FeedME","AverageSeason","CurrentSituation")
FeedSupplyPerAnimal(Concentrates,"Crop",Animals,Yield_Type,RoleInHerd,GeographicUnits,"AverageClimate","AverageSoilType",OrgConProdSystem,"FeedDMQuant_MEBased","AverageSeason","CurrentSituation")

etc.

$offtext;
