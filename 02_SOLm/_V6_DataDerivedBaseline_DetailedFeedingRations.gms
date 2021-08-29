PUTCLOSE con,"_V6_DataDerivedBaseline_DetailedFeedingRations";

*GENERAL DESCRIPTION
*This file derives the detailed feeding rations for the baseline data in case no specific detailed feeding ration data is available
*        it derives the commodity sepcific feeding ration based on the total feed supply and the share of single animals in the total feed demand.
*        This share is the proportionality factor to be used to allocate the total supply to single animals
*        and an overall supply/demand ratio is used as an overall correction factor to account for misreporting of feed supply in the baseline in relation to demand.

*DETAILED TABLE OF CONTENTS
$ontext;
- 0) PREAMBLE II: we need more ME and DM contents for feed:

- 1) Detailed baseline feeding rations
         1.1) Derive the feed supply
                 1.1.1) Concentrates
                 1.1.2) Grass
                 1.1.3) Forage
         1.2) Derive the feed ME requirements of the animals in a country
         1.3) supply/demand ratio
         1.4) Actual feed supply derived from FAOSTAT
         1.5) feed digestibility of the feeding rations
$offtext;


*MODEL CODE:

******************************************************************************************************************************************************************
******************************************************************************************************************************************************************
*-1) PREAMBLE I: we need to calc nutrient req of animals that are calculated in the scenarios similarly in the baseline:

*derive FeedME req for dairy cows based on yields and milk solid contents
*factor 1000 as the formula is for yields in kg milk, but yields are in tons currently
*SOURCE for this? And what is the factor 83?? - Ask Simon!!
ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","FeedME_Req_MilkProd (MJ/head)","AverageProdType","All","Baseline")
         = ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing","Milk Yield (t/head)","AverageProdType","All","Baseline")*1000
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Milk, Whole","Milk solid contents (t/t)","AverageProdType","All","Baseline")
                        *83;

*derive FeedMe req for dairy cow maintenance
*below, liveweight *1000 as the formulae are for kg, and the liveweight is in tons
*condition on the presence of liveweight values to avoid that the requirement is assigned via the term "14" only, also if there is no further data available.
*SOURCE for this? And what are the terms 14 and 0.09?? - Ask Simon!!
ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Maintenance (MJ/head)","AverageProdType","All","Baseline")
                 $ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","Liveweight (t/head)","AverageProdType","All","Baseline")
         = (14 + 0.09*ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","Liveweight (t/head)","AverageProdType","All","Baseline")*1000)*365;

*derive FeedMe req for dairy cow walking
*SOURCE for this? And what are the terms 2 and *1*2?? - Ask Simon!! 2: likely MJ per km; 1 and 2: km wlaked in summer/winter (but winter is quite high, then?).
ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Walking (MJ/head)","AverageProdType","All","Baseline")
                 $ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)","AverageProdType","All","Baseline")
         = ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)","AverageProdType","All","Baseline")
                 *2*ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","DailyWalkingDistance (km)","AverageProdType","All","Baseline")
         + (365 - ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","Summergrazing (days)","AverageProdType","All","Baseline"))
                 *1*2;

*derive FeedMe req for dairy cow pregnancy
*below, liveweight *1000 as the formulae are for kg, and the liveweight is in tons
*condition on the presence of liveweight values to avoid that the requirement is assigned via the term "1575" only, also if there is no further data available.
*SOURCE for this? And what are the terms 1575 and 3.5?? - Ask Simon!! 2: likely MJ per km; 1 and 2: km wlaked in summer/winter (but winter is quite high, then?).
ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Pregnancy (MJ/head)","AverageProdType","All","Baseline")
                 $ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","Liveweight (t/head)","AverageProdType","All","Baseline")
         = 1575 + 3.5*ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","Liveweight (t/head)","AverageProdType","All","Baseline")*1000;

*sum the above terms to get FeedME requirements of dairy cows:
*condition on the presence of liveweight values to avoid that the requirement is assigned also if one of the liveweight-related terms is missing (this likely being the case, whern there are no animals in a country).
ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Total (MJ/head)","AverageProdType","All","Baseline")
                 $ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","Liveweight (t/head)","AverageProdType","All","Baseline")
         = ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","FeedME_Req_MilkProd (MJ/head)","AverageProdType","All","Baseline")
                 + ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Maintenance (MJ/head)","AverageProdType","All","Baseline")
                 + ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Walking (MJ/head)","AverageProdType","All","Baseline")
                 + ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing_Dairy_Cattle","FeedME_Req_Pregnancy (MJ/head)","AverageProdType","All","Baseline");


*derive FeedXP requirements for all animals from FeedME requirements:
*division by 1000000 to get from gXP to tXP
*condition to avoid that this overwrites other existing values (for chicken and horse, for example), in particular if no convesion factor ME to XP is given.
*ATTENTION: CHECK CONDITION - or assure that XP is only around already, when it is better than the values derived here!!
ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"FeedXP_Req_Total (t/head)","AverageProdType","All","Baseline")
                 $(ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"XPperME_InFeedReq (gXP/MJ)","AverageProdType","All","Baseline")
                         AND (NOT ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"FeedXP_Req_Total (t/head)","AverageProdType","All","Baseline")))
         = ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"FeedME_Req_Total (MJ/head)","AverageProdType","All","Baseline")
                 *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"XPperME_InFeedReq (gXP/MJ)","AverageProdType","All","Baseline")
                         /1000000;


*derive FeedGE requirements from ME requirements:

ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"FeedGE_Req_Total (MJ/head)","AverageProdType","All","Baseline")
                 $((FeedingRationSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories","AggregateFeedTotal_CommoditySOLmV5","Digestibility of Feed (%)","AverageProdType","All","Baseline")/100
                         - FeedingRationSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories","AggregateFeedTotal_CommoditySOLmV5","UE_per_GE (share)","AverageProdType","All","Baseline"))
                 AND NOT ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories","FeedGE_Req_Total (MJ/head)","AverageProdType","All","Baseline")
                         )
         = ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"FeedME_Req_Total (MJ/head)","AverageProdType","All","Baseline")
                 /(FeedingRationSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories","AggregateFeedTotal_CommoditySOLmV5","Digestibility of Feed (%)","AverageProdType","All","Baseline")/100
                         - FeedingRationSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories","AggregateFeedTotal_CommoditySOLmV5","UE_per_GE (share)","AverageProdType","All","Baseline"));



******************************************************************************************************************************************************************
******************************************************************************************************************************************************************
*0) PREAMBLE II: we need more ME and DM contents for feed:
*the list below lists all that have entries in Feed (t), but we add nutrient contents only for those that are not yet available and that are relevant:
*DATA - chack again: Feedipedia

*Bananas
*Cloves
*Cottonseed
*Dates
*Oats
*Palm kernels
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Palm kernels","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.918;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Palm kernels","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 19200*0.918;
*Sesame seed
*Sugar beet
*Sugar cane
*Sunflower seed
*Sweet potatoes
*Yams
*Turnips for fodder
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Turnips for fodder","DM contents (tDM/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Beets For Fodder","DM contents (tDM/t)","AverageProdType","All","Baseline");
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Turnips for fodder","FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Beets For Fodder","FeedME cont (MJ/t)","AverageProdType","All","Baseline");
*Aquatic Plants
*Aquatic Products, Other
*Cephalopods
*Crustaceans
*Demersal Fish
*Freshwater Fish
*Pelagic Fish
*Maize For Forage+Silage
*Alfalfa For Forage+Silag
*Clover For Forage+Silage
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Clover For Forage+Silage","DM contents (tDM/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Alfalfa For Forage+Silag","DM contents (tDM/t)","AverageProdType","All","Baseline");
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Clover For Forage+Silage","FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Alfalfa For Forage+Silag","FeedME cont (MJ/t)","AverageProdType","All","Baseline")/8.9*9.7;
*Leguminous Nes,For+Sil
*Beets For Fodder
*Swedes For Fodder
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Swedes for fodder","DM contents (tDM/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Beets For Fodder","DM contents (tDM/t)","AverageProdType","All","Baseline");
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Swedes for fodder","FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Beets For Fodder","FeedME cont (MJ/t)","AverageProdType","All","Baseline");
*Temporary meadows and pastures
*Permanent meadows and pastures
*Cabbage, for forage
*Other grasses, for forage
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Other grasses, for forage","DM contents (tDM/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Permanent meadows and pastures","DM contents (tDM/t)","AverageProdType","All","Baseline");
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Other grasses, for forage","FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Permanent meadows and pastures","FeedME cont (MJ/t)","AverageProdType","All","Baseline");
*Rye grass, for forage
*Sorghum, for forage
*Fruits - Excluding Wine
*Oilcrops Oil, Other
*Molasses
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Molasses","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.73;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Molasses","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 9600*0.73;
*Sugar non-centrifugal
*Animal fats
*Bovine Meat
*Onions
*Pulses
*Apples and products
*Barley and products
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Barley and products","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.871;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Barley and products","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 12400*0.871;
*Beans
*Brans - assume wheat brans
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Brans","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.87;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Brans","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11000*0.87;
*Cassava and products
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Cassava and products","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.876;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Cassava and products","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 12200*0.876;
*Cereals - Excluding Beer - assume barley
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Cereals - Excluding Beer","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.871;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Cereals - Excluding Beer","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 12400*0.871;
*Cereals, Other - assume barley
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Cereals, Other","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.871;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Cereals, Other","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 12400*0.871;
*Cocoa Beans and products
*Coconuts - Incl Copra
*Copra Cake - copra oilmeal
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Copra Cake","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.898;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Copra Cake","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11500*0.898;
*Cottonseed Cake - cottonseed meal, low oil, pig value
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Copra Cake","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.909;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Copra Cake","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 12700*0.909;
*Fruits, Other
*Groundnut Cake - use  meal
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Groundnut Cake","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.904;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Groundnut Cake","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 12600*0.904;
*Groundnuts (in Shell Eq)
*Groundnuts (Shelled Eq)
*Maize and products
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Maize and products","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.863;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Maize and products","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 13600*0.863;
*Millet and products
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Millet and products","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.89;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Millet and products","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11800*0.89;
*Oilcrops - same as groundut cake
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Oilcrops","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.904;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Oilcrops","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 12600*0.904;
*Oilcrops, Other - same as groundnut cake
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Oilcrops, Other","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.904;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Oilcrops, Other","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 12600*0.904;
*Oilseed Cakes, Other - same as groundnut cake
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Oilseed Cakes, Other","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.904;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Oilseed Cakes, Other","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 12600*0.904;
*Olive Oil
*Olives (including preserved)
*Oranges, Mandarines
*Palm Oil
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Palmkernel Cake","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.912;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Palmkernel Cake","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11600*0.912;
*Palmkernel Cake
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Palmkernel Cake","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.912;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Palmkernel Cake","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11600*0.912;
*Peas
*Plantains
*Potatoes and products
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Potatoes and products","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.206;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Potatoes and products","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11900*0.206;
*Pulses, Other and products
*Rape and Mustard Cake
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Rape and Mustard Cake","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.888;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Rape and Mustard Cake","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11200*0.888;
*Rape and Mustard Oil
*Rape and Mustardseed
*Rice (Milled Equivalent)
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Rice (Milled Equivalent)","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.875;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Rice (Milled Equivalent)","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 13400*0.875;
*Rice (Paddy Equivalent)
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Rice (Paddy Equivalent)","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.88;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Rice (Paddy Equivalent)","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 10100*0.88;
*Roots & Tuber Dry Equiv - use potatoes
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Roots & Tuber Dry Equiv","DM contents (tDM/t)","AverageProdType","All","Baseline") = 1;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Roots & Tuber Dry Equiv","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11900;
*Roots, Other - use potatoes
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Roots, Other","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.206;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Roots, Other","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11900*0.206;
*Rye and products
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Rye and products","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.866;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Rye and products","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 13000*0.866;
*Sesameseed Cake
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Sesameseed Cake","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.928;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Sesameseed Cake","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 12500*0.928;
*Sesameseed Oil
*Sorghum and products
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Sorghum and products","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.874;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Sorghum and products","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 13500*0.874;
*Soyabean Cake - use meal
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Soyabean Cake","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.879;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Soyabean Cake","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 13600*0.879;
*Soyabean Oil
*Soyabeans
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Soyabeans","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.887;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Soyabeans","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 15300*0.887;
*Spices
*Starchy Roots - use potatoes
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Starchy Roots","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.206;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Starchy Roots","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11900*0.206;
*Stimulants
*Sugar & Sweeteners
*Sugar (Raw Equivalent)
*Sugar Crops - use beet pulp
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Sugar Crops","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.243;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Sugar Crops","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11200*0.243;
*Sugar, Raw Equivalent
*Sugar, Refined Equiv
*Sugar, Refined Equiv (sugar cane)
*Sugar, Refined Equiv (sugar beet)
*Sunflowerseed Cake - use meal
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Sunflowerseed Cake","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.89;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Sunflowerseed Cake","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 9100*0.89;
*Sweeteners, Other
*Tomatoes and products - use tomato fruits
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Tomatoes and products","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.073;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Tomatoes and products","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 5100*0.073;
*Vegetable Oils
*Vegetables - use carrots
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Vegetables","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.107;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Vegetables","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11900*0.107;
*Vegetables, Other - use carrots
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Vegetables, Other","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.107;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Vegetables, Other","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 11900*0.107;
*Wheat and products
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Wheat and products","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.87;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Wheat and products","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 13100*0.87;
*Butter, Ghee
*Cheese
*Eggs
*Fats, Animals, Raw
*Fish Meal
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Fish Meal","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.921;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Fish Meal","FeedME cont (MJ/t)","AverageProdType","All","Baseline") = 14800*0.921;
*Fish, Body Oil
*Fish, Liver Oil
*Fish, Seafood
*Honey
*Marine Fish, Other
*Meat
*Meat Meal
*Meat, Other
*Milk - Excluding Butter
*Milk, Skimmed
*Milk, Whole
*Molluscs, Other
*Mutton & Goat Meat
*Offals
*Offals, Edible
*Whey



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Detailed baseline feeding rations

*1.1) Derive the feed supply
*determine the amount utilized as feed in total and assign nutrient contents, etc.

*1.2.1) Concentrates
*BELOW: the entries in CommoditySOLmV5 for the DomestAvailableQuantitySOLmV5 and ParameterPerTonDomestAvailQuantSOLmV5 have alsmost no overlap - therefore almost nothing is assigned here!!
*GRASSLAND data is not yet available in TOTAL production or DAQ, and neither are utilization shares given.
*        Thus assign those specifically as well.
*UtilIZATION shares come from WOSY-DATA which is more on PrimaryProduct level, DAQ is on Commodity level: thus, we do the matching below, to get some more values:
*first entry is DAQ, second is utilization
alias(CommoditySOLmV5,CommoditySOLmV5_2)
Set Match_WOSYUtilization_DAQQuantities(CommoditySOLmV5,CommoditySOLmV5_2)
/
"Bananas"."Bananas"
"Cloves"."Cloves"
"Cottonseed"."Seed cotton"
"Dates"."Dates"
"Oats"."Oats"
"Palm kernels"."Oil Palm Fruit"
"Sugar beet"."Sugar beet"
"Sugar cane"."Sugar cane"
"Sunflower seed"."Sunflower seed"
"Sweet potatoes"."Sweet potatoes"
"Yams"."Yams"
"Molasses"."Sugar cane"
"Onions"."Onions, dry"
"Apples and products"."Apples"
"Barley and products"."Barley"
"Beans"."Beans, dry"
"Cassava and products"."Cassava"
"Coconuts - Incl Copra"."Coconuts"
"Copra Cake"."Coconuts"
"Cottonseed Cake"."Seed cotton"
"Grapes and products (excl wine)"."Grapes"
"Maize and products"."Maize"
"Maize Germ Oil"."Maize"
"Millet and products"."Millet"
"Oranges, Mandarines"."Oranges"
"Palm Oil"."Oil Palm Fruit"
"Palmkernel Cake"."Oil Palm Fruit"
"Palmkernel Oil"."Oil Palm Fruit"
"Peas"."Peas, dry"
"Potatoes and products"."Potatoes"
"Rape and Mustard Cake"."Rapeseed"
"Rape and Mustardseed"."Rapeseed"
"Rice (Milled Equivalent)"."Rice, paddy"
"Rice (Paddy Equivalent)"."Rice, paddy"
"Rye and products"."Rye"
"Sorghum and products"."Sorghum"
"Soyabean Cake"."Soybeans"
"Soyabeans"."Soybeans"
"Sunflowerseed Cake"."Sunflower seed"
"Sunflowerseed Oil"."Sunflower seed"
"Tomatoes and products"."Tomatoes"
"Wheat and products"."Wheat"
/;

*derive the quantity used as feed:
$ontext;
OLD CODE XXXXX
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5_2,"Feed (t)","AverageProdType","All","Baseline")
         = sum(CommoditySOLmV5$Match_WOSYUtilization_DAQQuantities(CommoditySOLmV5,CommoditySOLmV5_2),
                 DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"AverageProdType","All","Baseline")
                         *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5_2,"Feed util share DAQ (t/t)","AverageProdType","All","Baseline"));
*but we do not only have WOSY information, but also from the Commodity balances, hence add the following:
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline")
                 $(NOT DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline"))
         = DAQFeedSupplyQuantitySOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"AverageProdType","All","Baseline");
$offtext;



*NEW CODE XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
*only use DAQFeed as feed quantity and derive util share from this (Commodit<y Balances data only!) - do not use WOSY data at all!
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline")
         = DAQFeedSupplyQuantitySOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"AverageProdType","All","Baseline");

ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed util share DAQ (t/t)","AverageProdType","All","Baseline")
         = 0;

ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed util share DAQ (t/t)","AverageProdType","All","Baseline")
                 $DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"AverageProdType","All","Baseline")
         = DAQFeedSupplyQuantitySOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"AverageProdType","All","Baseline")
                 /DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"AverageProdType","All","Baseline");



*to assure that scenarios calculate similar to baseline:
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Domest Avail Quant (t)","AverageProdType","All","Baseline")
         = DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"AverageProdType","All","Baseline");

DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Domest Avail Quant (t)","AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed util share DAQ (t/t)","AverageProdType","All","Baseline");

*NEW CODE XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX



*1.2.2) Grass
*assign grassland values as needed for the further calculations:
*for now, DAQ equals production:
*do not use the grass total, as otherwise, this leads to some double counting... GrassXX
*DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,"Grass","AverageProdType","All","Baseline")
*         = PrimaryProductionQuantitySOLmV5.l(GeographicRegionSOLmV5,"Grass","All","AverageProdType","All","Baseline");
DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,"Permanent meadows and pastures","AverageProdType","All","Baseline")
         = PrimaryProductionQuantitySOLmV5.l(GeographicRegionSOLmV5,"Permanent meadows and pastures","Main Crop","AverageProdType","All","Baseline");
DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,"Temporary meadows and pastures","AverageProdType","All","Baseline")
         = PrimaryProductionQuantitySOLmV5.l(GeographicRegionSOLmV5,"Temporary meadows and pastures","Main Crop","AverageProdType","All","Baseline");

*for now, utilzation share of grassland is 1
*        to assign to countries only, do this conditional to yields being available (from Erb data - for countries only)
*ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Grass","Feed util share DAQ (t/t)","AverageProdType","All","Baseline")
*                 $ParameterPerHaSOLmV5(GeographicRegionSOLmV5,"Grass","Main Crop","Main product Yield (t/ha)","AverageProdType","All","Baseline")
*         = 1;

$ontext;
The following is already assigned in the ReadData CommodityBalancesNutrientContents:
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Permanent meadows and pastures","Feed util share DAQ (t/t)","AverageProdType","All","Baseline")
                 $ParameterPerHaSOLmV5(GeographicRegionSOLmV5,"Permanent meadows and pastures","Main Crop","Main product Yield (t/ha)","AverageProdType","All","Baseline")
         = 1;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Temporary meadows and pastures","Feed util share DAQ (t/t)","AverageProdType","All","Baseline")
                 $ParameterPerHaSOLmV5(GeographicRegionSOLmV5,"Temporary meadows and pastures","Main Crop","Main product Yield (t/ha)","AverageProdType","All","Baseline")
         = 1;

*and nutrient, DM, etc. contents of DAQ equals the contents of the production:
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Grass","DM contents (tDM/t)","AverageProdType","All","Baseline")
         = ParameterPerTonPrimaryProdSOLmV5(GeographicRegionSOLmV5,"Grass","Main Crop","MainOutput DM cont (tDM/t)","AverageProdType","All","Baseline");
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Grass","FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = ParameterPerTonPrimaryProdSOLmV5(GeographicRegionSOLmV5,"Grass","Main Crop","MainOutput FeedME Cont (MJ/t)","AverageProdType","All","Baseline");
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Grass","FeedGE cont (MJ/t)","AverageProdType","All","Baseline")
         = ParameterPerTonPrimaryProdSOLmV5(GeographicRegionSOLmV5,"Grass","Main Crop","MainOutput FeedGE Cont (MJ/t)","AverageProdType","All","Baseline");
*and the same for temporary and permanent:
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Permanent meadows and pastures","DM contents (tDM/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Grass","DM contents (tDM/t)","AverageProdType","All","Baseline");
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Permanent meadows and pastures","FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Grass","FeedME cont (MJ/t)","AverageProdType","All","Baseline");
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Permanent meadows and pastures","FeedGE cont (MJ/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Grass","FeedGE cont (MJ/t)","AverageProdType","All","Baseline");
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Temporary meadows and pastures","DM contents (tDM/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Grass","DM contents (tDM/t)","AverageProdType","All","Baseline");
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Temporary meadows and pastures","FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Grass","FeedME cont (MJ/t)","AverageProdType","All","Baseline");
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Temporary meadows and pastures","FeedGE cont (MJ/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Grass","FeedGE cont (MJ/t)","AverageProdType","All","Baseline");
$offtext;

*derive the quantity used as feed:
*Do not use the grass total, as otherwise, this leads to some double counting; GrassXX
*DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"Grass","Feed (t)","AverageProdType","All","Baseline")
*         = DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,"Grass","AverageProdType","All","Baseline")
*                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Grass","Feed util share DAQ (t/t)","AverageProdType","All","Baseline");
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"Permanent meadows and pastures","Feed (t)","AverageProdType","All","Baseline")
         = DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,"Permanent meadows and pastures","AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Permanent meadows and pastures","Feed util share DAQ (t/t)","AverageProdType","All","Baseline");
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"Temporary meadows and pastures","Feed (t)","AverageProdType","All","Baseline")
         = DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,"Temporary meadows and pastures","AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Temporary meadows and pastures","Feed util share DAQ (t/t)","AverageProdType","All","Baseline");


*1.2.3) Forage
*do the same for forage crops as for grassland:
*assign Forage crop values as needed for the further calculations:
*for now, DAQ equals production:

*here, we already need the following sets, but they are then defined in the special module for additional model sets later on (steering file 3).
*BUT CURRENTLA; they are already defined before, in __SOLmV5_Sets_AdditionalAuxiliarySets.gms
*        thus no need to redefine here
*Set SubSetCropsGrass_ActivityGroup_ForageCrops(ActivitySOLmV5)
*Set SubSetCropsGrass_ActGroup_OtherFodderCrops(ActivitySOLmV5)


*and we need them as commodity subsets as well:
Set SubSetCropsGrass_CommodityGroup_ForageCrops(CommoditySOLmV5)
*forage crops: those crops that are harvested and then fully fed or used for silage, thus not leading to residues (besides roots); therefore, beets for fodder, etc. are not inlcuded,
*but are listed separately under other fodder crops.
/"Maize For Forage+Silage"
"Clover For Forage+Silage"
"Alfalfa For Forage+Silag"
"Leguminous Nes,For+Sil"
"Forage Products Nes"
"Beets For Fodder"
'Vetches'

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
"Cabbage, for forage"
"Carrots, for forage"
"Other grasses, for forage"
"Other oilseeds, for forage"
"Rye grass, for forage"
"Sorghum, for forage"
/;

Set SubSetCropsGrass_CommodityGroup_OtherFodderCrops(CommoditySOLmV5)
/
*we have the following two as forages as they are forage in Aggregate_ForageCrops
*"Alfalfa Meal And Pellets"
*"Beets For Fodder"
"Swedes For Fodder"
"Turnips For Fodder"
"Vegetables+Roots,Fodder"
/;

*and we need the matching between commodities and activities for forage:
set Match_CommoditySOLmV5_ActivitySOLmV5_Forage(CommoditySOLmV5,ActivitySOLmV5,OutputTypeSOLmV5)
/
"Maize For Forage+Silage"."Maize For Forage+Silage"."Main crop"
"Alfalfa For Forage+Silag"."Alfalfa For Forage+Silag"."Main crop"
"Clover For Forage+Silage"."Clover For Forage+Silage"."Main crop"
"Leguminous Nes,For+Sil"."Leguminous Nes,For+Sil"."Main crop"
"Forage Products Nes"."Forage Products Nes"."Main crop"

*other fodder crops
"Beets For Fodder"."Beets For Fodder"."Main crop"
"Swedes For Fodder"."Swedes For Fodder"."Main crop"
"Turnips For Fodder"."Turnips For Fodder"."Main crop"
"Vegetables+Roots,Fodder"."Vegetables+Roots,Fodder"."Main crop"

*additionally added from FAOSTAT ForageCrop data, items that do not fot to one from the above:
"Cabbage, for forage"."Cabbage, for forage"."Main crop"
"Carrots, for forage"."Carrots, for forage"."Main crop"
"Other grasses, for forage"."Other grasses, for forage"."Main crop"
"Other oilseeds, for forage"."Other oilseeds, for forage"."Main crop"
"Rye grass, for forage"."Rye grass, for forage"."Main crop"
"Sorghum, for forage"."Sorghum, for forage"."Main crop"
/;

DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_ForageCrops,"AverageProdType","All","Baseline")
         = sum(ActivitySOLmV5$Match_CommoditySOLmV5_ActivitySOLmV5_Forage(SubSetCropsGrass_CommodityGroup_ForageCrops,ActivitySOLmV5,"Main Crop"),
                 PrimaryProductionQuantitySOLmV5.l(GeographicRegionSOLmV5,ActivitySOLmV5,"Main Crop","AverageProdType","All","Baseline"));
DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_OtherFodderCrops,"AverageProdType","All","Baseline")
         = sum(ActivitySOLmV5$Match_CommoditySOLmV5_ActivitySOLmV5_Forage(SubSetCropsGrass_CommodityGroup_OtherFodderCrops,ActivitySOLmV5,"Main Crop"),
                 PrimaryProductionQuantitySOLmV5.l(GeographicRegionSOLmV5,ActivitySOLmV5,"Main Crop","AverageProdType","All","Baseline"));


*for now, utilzation share of forage crops is 1
*        to assign to countries only, do this conditional to yields being available (from Erb data - for countries only)
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,SubSetCropsGrass_CommodityGroup_ForageCrops,"Feed util share DAQ (t/t)","AverageProdType","All","Baseline")
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,SubSetCropsGrass_CommodityGroup_ForageCrops,"Feed util share DAQ (t/t)","AverageProdType","All","Baseline"))
         = 1;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,SubSetCropsGrass_CommodityGroup_OtherFodderCrops,"Feed util share DAQ (t/t)","AverageProdType","All","Baseline")
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,SubSetCropsGrass_CommodityGroup_OtherFodderCrops,"Feed util share DAQ (t/t)","AverageProdType","All","Baseline"))
         = 1;


*and nutrient, DM, etc. contents of DAQ equals the contents of the production:
*$-condition to avoid overwriting values assigned furthe rup - e.g. for "other grasses, for forage"
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_ForageCrops,"DM contents (tDM/t)","AverageProdType","All","Baseline")
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_ForageCrops,"DM contents (tDM/t)","AverageProdType","All","Baseline"))
         = sum(ActivitySOLmV5$Match_CommoditySOLmV5_ActivitySOLmV5_Forage(SubSetCropsGrass_CommodityGroup_ForageCrops,ActivitySOLmV5,"Main Crop"),
                         ParameterPerTonPrimaryProdSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"Main Crop","MainOutput DM cont (tDM/t)","AverageProdType","All","Baseline"));
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_OtherFodderCrops,"DM contents (tDM/t)","AverageProdType","All","Baseline")
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_OtherFodderCrops,"DM contents (tDM/t)","AverageProdType","All","Baseline"))
         = sum(ActivitySOLmV5$Match_CommoditySOLmV5_ActivitySOLmV5_Forage(SubSetCropsGrass_CommodityGroup_OtherFodderCrops,ActivitySOLmV5,"Main Crop"),
                         ParameterPerTonPrimaryProdSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"Main Crop","MainOutput DM cont (tDM/t)","AverageProdType","All","Baseline"));

*NOT NEEDED, as currently, forage feed etc. nutrient contents are assigned on DAQ level not on PrimProd level
*and there, it is only done for Maize and Alfalfa for Forage - to be improved
$ontext;
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_ForageCrops,"FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = sum(ActivitySOLmV5$Match_CommoditySOLmV5_ActivitySOLmV5_Forage(SubSetCropsGrass_CommodityGroup_ForageCrops,ActivitySOLmV5,"Main Crop"),
                         ParameterPerTonPrimaryProdSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"Main Crop","MainOutput FeedME Cont (MJ/t)","AverageProdType","All","Baseline"));
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_OtherFodderCrops,"FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = sum(ActivitySOLmV5$Match_CommoditySOLmV5_ActivitySOLmV5_Forage(SubSetCropsGrass_CommodityGroup_OtherFodderCrops,ActivitySOLmV5,"Main Crop"),
                         ParameterPerTonPrimaryProdSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"Main Crop","MainOutput FeedME Cont (MJ/t)","AverageProdType","All","Baseline"));

ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_ForageCrops,"FeedGE cont (MJ/t)","AverageProdType","All","Baseline")
         = sum(ActivitySOLmV5$Match_CommoditySOLmV5_ActivitySOLmV5_Forage(SubSetCropsGrass_CommodityGroup_ForageCrops,ActivitySOLmV5,"Main Crop"),
                         ParameterPerTonPrimaryProdSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"Main Crop","MainOutput FeedGE Cont (MJ/t)","AverageProdType","All","Baseline"));
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_OtherFodderCrops,"FeedGE cont (MJ/t)","AverageProdType","All","Baseline")
         = sum(ActivitySOLmV5$Match_CommoditySOLmV5_ActivitySOLmV5_Forage(SubSetCropsGrass_CommodityGroup_OtherFodderCrops,ActivitySOLmV5,"Main Crop"),
                         ParameterPerTonPrimaryProdSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"Main Crop","MainOutput FeedGE Cont (MJ/t)","AverageProdType","All","Baseline"));
$offtext;

*derive the quantity used as feed:
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_ForageCrops,"Feed (t)","AverageProdType","All","Baseline")
         = DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_ForageCrops,"AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_ForageCrops,"Feed util share DAQ (t/t)","AverageProdType","All","Baseline");
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_OtherFodderCrops,"Feed (t)","AverageProdType","All","Baseline")
         = DomestAvailableQuantitySOLmV5.l(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_OtherFodderCrops,"AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,SubSetCropsGrass_CommodityGroup_OtherFodderCrops,"Feed util share DAQ (t/t)","AverageProdType","All","Baseline");


*so we have the feed quantities available per country for concentrates, forage and grass.
*thus derive the total available ME values for this and derive the country-wise aggregate ME-contents for these feed groups (CURRENTLY NOT DIFFERENTIATED FOR DIFFERENT ANIMALS).



DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"Feed (t)","AverageProdType","All","Baseline")
         = sum(CommoditySOLmV5$MatchFeedGroups_CommoditySOLmV5(FeedGroupsSOLmV5,CommoditySOLmV5),
                 DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline"));

DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed DM (t)","AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"DM contents (tDM/t)","AverageProdType","All","Baseline");

DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"Feed DM (t)","AverageProdType","All","Baseline")
         = sum(CommoditySOLmV5$MatchFeedGroups_CommoditySOLmV5(FeedGroupsSOLmV5,CommoditySOLmV5),
                 DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed DM (t)","AverageProdType","All","Baseline"));

DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline");

DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
         = sum(CommoditySOLmV5$MatchFeedGroups_CommoditySOLmV5(FeedGroupsSOLmV5,CommoditySOLmV5),
                 DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline"));


*XXXXXXXXXXXXXXXXXXX
*HERE above: we have much more data on Feed than on FeedME! - thus assign some more FeedME cont values but then drop Feed values, where no FeedME is available.
*FASTEST DOLUTION : Drop Feed where we do not have FeedME
$ontext;
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline")
                 $DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline");

DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed DM (t)","AverageProdType","All","Baseline")
                 $DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed DM (t)","AverageProdType","All","Baseline");


DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline")
                 $(NOT DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline"))
         = 0;

DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed DM (t)","AverageProdType","All","Baseline")
                 $(NOT DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline"))
         = 0;

DAQFeedSupplyQuantitySOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"AverageProdType","All","Baseline")
         = 0;
DAQFeedSupplyQuantitySOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline");
$offtext;
*XXXXXXXXXXXXXXXXXXX

*derive the aggregate ME-content per feed group  without differentiation for different animal types or so.
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline")
                 $DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"Feed (t)","AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
                 /DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"Feed (t)","AverageProdType","All","Baseline");

ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"DM contents (tDM/t)","AverageProdType","All","Baseline")
                 $DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"Feed (t)","AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"Feed DM (t)","AverageProdType","All","Baseline")
                 /DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"Feed (t)","AverageProdType","All","Baseline");

*do it separately for the sum of cond plus byprod, as they function as concentrates from a feeding perspective:
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"AggregateFeedConcPlusByprod_CommoditySOLmV5","DM contents (tDM/t)","AverageProdType","All","Baseline")
                 $(DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedConcentrates_CommoditySOLmV5","Feed (t)","AverageProdType","All","Baseline")
                          + DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedByproducts_CommoditySOLmV5","Feed (t)","AverageProdType","All","Baseline"))
         = (DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedConcentrates_CommoditySOLmV5","Feed DM (t)","AverageProdType","All","Baseline")
                 + DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedByproducts_CommoditySOLmV5","Feed DM (t)","AverageProdType","All","Baseline"))
                 /(DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedConcentrates_CommoditySOLmV5","Feed (t)","AverageProdType","All","Baseline")
                          + DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedByproducts_CommoditySOLmV5","Feed (t)","AverageProdType","All","Baseline"));

ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"AggregateFeedConcPlusByprod_CommoditySOLmV5","FeedME cont (MJ/t)","AverageProdType","All","Baseline")
                 $(DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedConcentrates_CommoditySOLmV5","Feed (t)","AverageProdType","All","Baseline")
                          + DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedByproducts_CommoditySOLmV5","Feed (t)","AverageProdType","All","Baseline"))
         = (DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedConcentrates_CommoditySOLmV5","FeedME (MJ)","AverageProdType","All","Baseline")
                 + DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedByproducts_CommoditySOLmV5","FeedME (MJ)","AverageProdType","All","Baseline"))
                 /(DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedConcentrates_CommoditySOLmV5","Feed (t)","AverageProdType","All","Baseline")
                          + DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedByproducts_CommoditySOLmV5","Feed (t)","AverageProdType","All","Baseline"));

ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"FeedME cont in DM (MJ/tDM)","AverageProdType","All","Baseline")
                 $ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"DM contents (tDM/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline")
                 /ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"DM contents (tDM/t)","AverageProdType","All","Baseline");


*In the following, work with concentrates but we use the conc plus byprod for this, thus assign as follows:
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"AggregateFeedConcentrates_CommoditySOLmV5","FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"AggregateFeedConcPlusByprod_CommoditySOLmV5","FeedME cont (MJ/t)","AverageProdType","All","Baseline");

ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"AggregateFeedConcentrates_CommoditySOLmV5","DM contents (tDM/t)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"AggregateFeedConcPlusByprod_CommoditySOLmV5","DM contents (tDM/t)","AverageProdType","All","Baseline");

ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"AggregateFeedConcentrates_CommoditySOLmV5","FeedME cont in DM (MJ/tDM)","AverageProdType","All","Baseline")
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"AggregateFeedConcPlusByprod_CommoditySOLmV5","FeedME cont in DM (MJ/tDM)","AverageProdType","All","Baseline");



$ontext;
execute_unload 'Test00'
DomestAvailableQuantityBasedTotalValuesSOLmV5
DAQFeedSupplyQuantitySOLmV5
ParameterPerTonDomestAvailQuantSOLmV5
DomestAvailableQuantitySOLmV5
;
$offtext;


*1.2) Derive the feed ME requirements of the animals in a country
*this is done per feed group, i.e. grass, concentrates, forage, residues

*in the following, derive the total ME demand of all animals of a certain type (per herd category), for each feed group separately
*it is derived as number of animals * per head ME demand * share of feed group in feeding ration (DM-based!!!)

*thus, we need first some additional conversion, to derive the share in feeding rations ME-based:
*this is done as follows:

*                                          % FG in DM * MEcont per DM
* %Feed group in ration, ME-based = ---------------------------------------
*                                   sum all FG (% FG in DM * MEcont per DM)

*for this, use an additional element in the set PerLivingHeadParameterSOLmV5
*$onmulti;
*set PerLivingHeadParameterSOLmV5
*/
*"Feed ration weighted feed ME cont in DM (MJ/tDM)"
*/;
*$offmulti;

alias(PerLivingHeadParameterSOLmV5,PerLivingHeadParameterSOLmV5_2);
Set Match_FeedingRationsPara_PerHeadPara_MEbased(CommoditySOLmV5,PerLivingHeadParameterSOLmV5,PerLivingHeadParameterSOLmV5_2)
/
AggregateFeedGrass_CommoditySOLmV5."Share Grass in Feed (ME based)"."Share Grass in Feed"
AggregateFeedForageCrops_CommoditySOLmV5."Share Forage crops in Feed (ME based)"."Share Forage crops in Feed"
AggregateFeedConcentrates_CommoditySOLmV5."Share Concentrates in Feed (ME based)"."Share Concentrates in Feed"
AggregateFeedResidues_CommoditySOLmV5."Share Residues in Feed (ME based)"."Share Residues in Feed"
/;


ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories","Feed ration weighted feed ME cont in DM (MJ/tDM)","AverageProdType","All","Baseline")
         = sum((PerLivingHeadParameterSOLmV5,FeedGroupsSOLmV5)$Match_FeedingRationsPara_PerHeadPara(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5),
                 ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")
                         *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"FeedME cont in DM (MJ/tDM)","AverageProdType","All","Baseline"));

*for the following, we need "FeedME cont in DM (MJ/tDM)" for the feed groups;
*data for forage is sparse, thus this is often missing for forage crops, thus assign value for forage maize where it is missing:

ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"AggregateFeedForageCrops_CommoditySOLmV5","FeedME cont in DM (MJ/tDM)","AverageProdType","All","Baseline")
                 $(NOT ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"AggregateFeedForageCrops_CommoditySOLmV5","FeedME cont in DM (MJ/tDM)","AverageProdType","All","Baseline"))
         = ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,"Maize for Forage+Silage","FeedME cont in DM (MJ/tDM)","AverageProdType","All","Baseline");

ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")
                 $(ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories","Feed ration weighted feed ME cont in DM (MJ/tDM)","AverageProdType","All","Baseline")
                         AND (NOT ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")))
         = sum((FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5_2)$Match_FeedingRationsPara_PerHeadPara_MEbased(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5,PerLivingHeadParameterSOLmV5_2),
                 ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories",PerLivingHeadParameterSOLmV5_2,"AverageProdType","All","Baseline")
                                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"FeedME cont in DM (MJ/tDM)","AverageProdType","All","Baseline"))
                         /ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories","Feed ration weighted feed ME cont in DM (MJ/tDM)","AverageProdType","All","Baseline");

*now we can derive feed ME demand:
*the code separately for cattle/pig may not be needed anymor e- to be checked later
Set Match_FeedReqPerFeedGroup_FeedingRationShares(PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5)
/
"Share Grass in Feed (ME based)"."Total Grass ME demand (MJ)"
"Share Forage crops in Feed (ME based)"."Total Forage ME demand (MJ)"
"Share Concentrates in Feed (ME based)"."Total Conc ME demand (MJ)"
"Share Residues in Feed (ME based)"."Total Residues ME demand (MJ)"
/;


LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"Cattle",AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline")
*$-condition to avoid overwriting earlier assignments - not needed, as currently, this here is the first assginemtn of this variable
*                 $(NOT LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"Cattle",AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline"))
         = sum(PerLivingHeadParameterSOLmV5$Match_FeedReqPerFeedGroup_FeedingRationShares(PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5),
                 NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,"Cattle",AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline")
                         *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle",AnimalCategoriesInHerdSOLmV5,"FeedME_Req_Total (MJ/head)","AverageProdType","All","Baseline")
                                 *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline"));

LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"Pigs",AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline")
*$-condition to avoid overwriting earlier assignments
                 $(NOT LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"Pigs",AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline"))
         = sum(PerLivingHeadParameterSOLmV5$Match_FeedReqPerFeedGroup_FeedingRationShares(PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5),
                 NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,"Pigs",AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline")
                         *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Pigs",AnimalCategoriesInHerdSOLmV5,"FeedME_Req_Total (MJ/head)","AverageProdType","All","Baseline")
                                 *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Pigs","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline"));

LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline")
*$-condition to avoid overwriting earlier assignments
                 $(NOT LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline"))
         = sum(PerLivingHeadParameterSOLmV5$Match_FeedReqPerFeedGroup_FeedingRationShares(PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5),
                 NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories","AverageProdType","All","Baseline")
                         *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories","FeedME_Req_Total (MJ/head)","AverageProdType","All","Baseline")
                                 *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline"));


*derive the share of each animal type in total feed ME requirements
Set FeedingRationMEDemand(LivingHeadsBasedTotalValueParameterSOLmV5)
/
"Total Conc ME demand (MJ)"
"Total Forage ME demand (MJ)"
"Total Residues ME demand (MJ)"
"Total Grass ME demand (MJ)"
/;

LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"All Animals","AllCategories",FeedingRationMEDemand,"AverageProdType","All","Baseline")
         =sum((LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5),
                 LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedingRationMEDemand,"AverageProdType","All","Baseline"));


Set Match_ShareInTotalFeedTypeDemand_FeedTypeDemand(PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5)
/
"Share in Total Conc ME demand"."Total Conc ME demand (MJ)"
"Share in Total Forage ME demand"."Total Forage ME demand (MJ)"
"Share in Total Residues ME demand"."Total Residues ME demand (MJ)"
"Share in Total Grass ME demand"."Total Grass ME demand (MJ)"
/;

set SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5(PerLivingHeadParameterSOLmV5)
/
"Share in Total Conc ME demand"
"Share in Total Forage ME demand"
"Share in Total Residues ME demand"
"Share in Total Grass ME demand"
/;


ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle",AnimalCategoriesInHerdSOLmV5,SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")
*$-condition to avoid overwriting earlier assignments
*                 $(NOT ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle",AnimalCategoriesInHerdSOLmV5,SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline"))
         = sum(LivingHeadsBasedTotalValueParameterSOLmV5$(Match_ShareInTotalFeedTypeDemand_FeedTypeDemand(SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5)
                         AND LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline")),
                 LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"Cattle",AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline")
                                 /LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline"));

ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Pigs",AnimalCategoriesInHerdSOLmV5,SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")
*$-condition to avoid overwriting earlier assignments
*                 $(NOT ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Pigs",AnimalCategoriesInHerdSOLmV5,SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline"))
         = sum(LivingHeadsBasedTotalValueParameterSOLmV5$(Match_ShareInTotalFeedTypeDemand_FeedTypeDemand(SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5)
                         AND LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline")),
                 LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"Pigs",AnimalCategoriesInHerdSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline")
                                 /LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline"));

*not yet specifically for chickens, as no yet new chicken categories
ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,"AllCategories",SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")
*$-condition to avoid overwriting earlier assignments
*                 $(NOT ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,"AllCategories",SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline"))
         = sum(LivingHeadsBasedTotalValueParameterSOLmV5$(Match_ShareInTotalFeedTypeDemand_FeedTypeDemand(SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5)
                         AND LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline")),
                 LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,"AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline")
                                 /LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,"AverageProdType","All","Baseline"));

*we thus have the share of each animal, herd category type in total feed ME demand per feed category in the baseline - this is purely demand based, not yet involving any supply data.
*the contents of this is thus e.g.: cattle BCows in the baseline in Australia, given all the animal numbers in the baseline and their requirements and feeding rations,
*                have a share of 7.5% in total concentrates ME demand of ALL animals in Australia, etc.



$ontext;
XXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx
ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt,"Cattle",AnimalCategoriesInHerdSOLmV5_ModelRun,SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")
*$-condition to avoid overwriting earlier assignments
*                 $(NOT ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt,"Cattle",AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline"))
         = sum(LivingHeadsBasedTotalValueParameterSOLmV5$(Match_ShareInTotalFeedTypeDemand_FeedTypeDemand(SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5)
                         AND LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")),
                 LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,"Cattle",AnimalCategoriesInHerdSOLmV5_MOdelRun,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")
                                 /LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline"));

ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt,"Pigs",AnimalCategoriesInHerdSOLmV5_ModelRun,SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")
*$-condition to avoid overwriting earlier assignments
*                 $(NOT ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt,"Pigs",AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline"))
         = sum(LivingHeadsBasedTotalValueParameterSOLmV5$(Match_ShareInTotalFeedTypeDemand_FeedTypeDemand(SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5)
                         AND LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")),
                 LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,"Pigs",AnimalCategoriesInHerdSOLmV5_MOdelRun,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")
                                 /LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline"));

ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt,"Chickens",AnimalCategoriesInHerdSOLmV5_ModelRun,SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")
*$-condition to avoid overwriting earlier assignments
*                 $(NOT ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt,"Chickens",AnimalCategoriesInHerdSOLmV5_ModelRun,PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline"))
         = sum(LivingHeadsBasedTotalValueParameterSOLmV5$(Match_ShareInTotalFeedTypeDemand_FeedTypeDemand(SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5)
                         AND LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")),
                 LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,"Chickens",AnimalCategoriesInHerdSOLmV5_MOdelRun,LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")
                                 /LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline"));

ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt,LiveAnimalsSOLmV5_ModelRun,"AllCategories",SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")
*$-condition to avoid overwriting earlier assignments
*                 $(NOT ParameterPerAnimalHead_HerdStructureSOLmV5_ModelRun(GeographicRegionsSOLmV5_NewForAlpenprojekt,LiveAnimalsSOLmV5_ModelRun,"AllCategories",PerLivingHeadParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline"))
         = sum(LivingHeadsBasedTotalValueParameterSOLmV5$(Match_ShareInTotalFeedTypeDemand_FeedTypeDemand(SubsetFeedTypeShares_PerLivingHeadParameterSOLmV5,LivingHeadsBasedTotalValueParameterSOLmV5)
                         AND LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")),
                 LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,LiveAnimalsSOLmV5_ModelRun,"AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline")
                                 /LivingHeads_HerdStructureBasedTotalValuesSOLmV5_ModelRun.l(GeographicRegionsSOLmV5_NewForAlpenprojekt,"All Animals","AllCategories",LivingHeadsBasedTotalValueParameterSOLmV5,ProductionTypeSOLmV5_ModelRun,"All","Baseline"));

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
$offtext;


Set Match_AggregateFeedGroups_FeedGroupSharesInRation(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)
/
"AggregateFeedConcentrates_CommoditySOLmV5"."Share in Total Conc ME demand"
"AggregateFeedForageCrops_CommoditySOLmV5"."Share in Total Forage ME demand"
"AggregateFeedResidues_CommoditySOLmV5"."Share in Total Residues ME demand"
"AggregateFeedGrass_CommoditySOLmV5"."Share in Total Grass ME demand"
/;



PUTCLOSE con "   time elapsed __SOLmV5_DataDerivedBaseline_DetailedFeedingRations 1:" timeElapsed;
*the following has a huge matching set, this makes ist slow, about 103 seconds!
*improve it by replacing the matching by subsets:
*old matching code:
$ontext;
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                 $NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline")
         = sum((PerLivingHeadParameterSOLmV5,FeedGroupsSOLmV5)$(Match_AggregateFeedGroups_FeedGroupSharesInRation(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)
                         AND MatchFeedGroups_CommoditySOLmV5_ByprodAsConcentrates(FeedGroupsSOLmV5,CommoditySOLmV5)),
                 DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
                         *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")
                                 /NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline"));
$offtext;
*do with the following 4 subsets:
*FeedConcentrates_CommoditySOLmV5(CommoditySOLmV5)
*FeedByproducts_CommoditySOLmV5(CommoditySOLmV5)
*FeedForageCrops_CommoditySOLmV5(CommoditySOLmV5)
*FeedGrass_CommoditySOLmV5(CommoditySOLmV5)

*then determine the proportion of this total feed amount to be used by each animal head in each animal category,
*        based on the categorie's share of ME requirements per feed category in total ME requirements per feed category and the number of living animals
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedConcentrates_CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                 $NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedConcentrates_CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
                 *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"Share in Total Conc ME demand","AverageProdType","All","Baseline")
                         /NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline");

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedByproducts_CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                 $NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedByproducts_CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
                 *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"Share in Total Conc ME demand","AverageProdType","All","Baseline")
                         /NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline");

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedForageCrops_CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                 $NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedForageCrops_CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
                 *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"Share in Total Forage ME demand","AverageProdType","All","Baseline")
                         /NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline");

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedGrass_CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                 $NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGrass_CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
                 *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"Share in Total Grass ME demand","AverageProdType","All","Baseline")
                         /NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AverageProdType","All","Baseline");

PUTCLOSE con "   time elapsed __SOLmV5_DataDerivedBaseline_DetailedFeedingRations 2:" timeElapsed;

$ontext;
*this does not work for the animals without herd structure (i.e. NOT cattle, pigs), as the AnimalCategoriesInHerdSOLmV5 is AllCategories for the number, AverageCategory for the per head parameter....thus:
*NO IT SHOULD: we changed wthis with AverageCategory - so It should work!!
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,"AllCategories",CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                 $NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,"AllCategories","AverageProdType","All","Baseline")
         = sum((PerLivingHeadParameterSOLmV5,FeedGroupsSOLmV5)$(Match_AggregateFeedGroups_FeedGroupSharesInRation(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)
                         AND MatchFeedGroups_CommoditySOLmV5(FeedGroupsSOLmV5,CommoditySOLmV5)),
                 DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
                         *ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,"AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")
                                 /NumberLivingAnimals_HerdStructureSOLmV5.l(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,"AllCategories","AverageProdType","All","Baseline"));
$offtext;

*and the corresponding per head feed quant supply:
*the division is very slow, thus replace by using multiplication with the inverse, this fastens the code:

Parameter AUX_Inverse_ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,PerTonDomestAvailQuantParameterSOLmV5,ProductionTypeSOLmV5,ProductionConditionsSOLmV5,ScenarioNamesSOLmV5);

AUX_Inverse_ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline")
                 $ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = 1/ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline");

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed quant supply per head (t/head)","AverageProdType","All","Baseline")
*                 $ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                 *AUX_Inverse_ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline");


*and the corresponding per head feed GE supply:
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedGE supply per head (MJ/head)","AverageProdType","All","Baseline")
         = FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed quant supply per head (t/head)","AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedGE cont (MJ/t)","AverageProdType","All","Baseline");

*derive DM supply per head:
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed DM quant supply per head (tDM/head)","AverageProdType","All","Baseline")
         = FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed quant supply per head (t/head)","AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"DM contents (tDM/t)","AverageProdType","All","Baseline");


*derive DM share in ration for the single commodities:
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AggregateFeedTotal_CommoditySOLmV5","Feed DM quant supply per head (tDM/head)","AverageProdType","All","Baseline")
         = sum(CommoditySOLmV5,FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed DM quant supply per head (tDM/head)","AverageProdType","All","Baseline"));

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"DM share in ration","AverageProdType","All","Baseline")
                 $FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AggregateFeedTotal_CommoditySOLmV5","Feed DM quant supply per head (tDM/head)","AverageProdType","All","Baseline")
         = FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed DM quant supply per head (tDM/head)","AverageProdType","All","Baseline")
                 /FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AggregateFeedTotal_CommoditySOLmV5","Feed DM quant supply per head (tDM/head)","AverageProdType","All","Baseline");


*1.3) supply/demand ratio
*determine the feed supply/demand ratio (in terms of ME) in the baseline: on the level of all animals and all feed:
Set Match_FeedGroups_FeedGroupSDRation(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5,FeedingRationMEDemand)
/
"AggregateFeedConcentrates_CommoditySOLmV5"."Feed supply/demand ratio (ME based, Conc)"."Total Conc ME demand (MJ)"
"AggregateFeedForageCrops_CommoditySOLmV5"."Feed supply/demand ratio (ME based, Forage)"."Total Forage ME demand (MJ)"
"AggregateFeedResidues_CommoditySOLmV5"."Feed supply/demand ratio (ME based, Residues)"."Total Residues ME demand (MJ)"
"AggregateFeedGrass_CommoditySOLmV5"."Feed supply/demand ratio (ME based, Grass)"."Total Grass ME demand (MJ)"
/;


*the following two are already there - no need to recalculate:
$ontext;
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"Feed (t)","AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline");

DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
         =sum(CommoditySOLmV5$MatchFeedGroups_CommoditySOLmV5(FeedGroupsSOLmV5,CommoditySOLmV5),
                 DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline"));
$offtext;

*for this, here, we need to add concentrates and byprod DAQ values, as we lump them together:
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedConcentrates_CommoditySOLmV5","FeedME (MJ)","AverageProdType","All","Baseline")
         = DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedConcentrates_CommoditySOLmV5","FeedME (MJ)","AverageProdType","All","Baseline")
                 +DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"AggregateFeedByproducts_CommoditySOLmV5","FeedME (MJ)","AverageProdType","All","Baseline");

ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")
                 $(NOT ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline"))
         = sum((FeedGroupsSOLmV5,FeedingRationMEDemand)$(Match_FeedGroups_FeedGroupSDRation(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5,FeedingRationMEDemand)
                         AND LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"All Animals","AllCategories",FeedingRationMEDemand,"AverageProdType","All","Baseline")),
                 DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,FeedGroupsSOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
                         /LivingHeads_HerdStructureBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,"All Animals","AllCategories",FeedingRationMEDemand,"AverageProdType","All","Baseline"));


*1.4) Actual feed supply derived from FAOSTAT
*derives the actual feed supply the animal should get to be fed: based on the feed supply per head derived above - and corrected by the supply/demand ratio.
*thus, these quantities are needed by the animal to be fed - but they are NOT observed in the data.
*these values for GE uptake are needed to derive enteric fermentation emissions, for example if attempting to base everything fully on FAO data
*but even then, likely some additional correction is needed due to missing data - to not underestimate the actual feed supply
*as we do not need them, we do not calculate them, though.

Set Match_FeedGroups_FeedGroupSDRation2(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)
/
"AggregateFeedConcentrates_CommoditySOLmV5"."Feed supply/demand ratio (ME based, Conc)"
"AggregateFeedForageCrops_CommoditySOLmV5"."Feed supply/demand ratio (ME based, Forage)"
"AggregateFeedResidues_CommoditySOLmV5"."Feed supply/demand ratio (ME based, Residues)"
"AggregateFeedGrass_CommoditySOLmV5"."Feed supply/demand ratio (ME based, Grass)"
/;


*do it for FeedME, FeedGe and DM:

PUTCLOSE con "   time elapsed __SOLmV5_DataDerivedBaseline_DetailedFeedingRations 3:" timeElapsed;
*the following is slow, to be improved:
*the following involves a huge mathing set that makes it slow (matching feed-groups with commodities)
*improve it by replacing the matching by subsets:
*but still needs about 50''
*old matching code:
$ontext;
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedME supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
         = sum((FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)$(MatchFeedGroups_CommoditySOLmV5(FeedGroupsSOLmV5,CommoditySOLmV5)
                         AND Match_FeedGroups_FeedGroupSDRation2(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)
                         AND ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")),
                 FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                         /ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline"));
$offtext;
*do with the following 4 subsets:
*FeedConcentrates_CommoditySOLmV5(CommoditySOLmV5)
*FeedByproducts_CommoditySOLmV5(CommoditySOLmV5)
*FeedForageCrops_CommoditySOLmV5(CommoditySOLmV5)
*FeedGrass_CommoditySOLmV5(CommoditySOLmV5)

*the following (till timeElapsed ..... 3a) still takes 50'  why?
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedConcentrates_CommoditySOLmV5,"FeedME supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
                         $ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories","Feed supply/demand ratio (ME based, Conc)","AverageProdType","All","Baseline")
                 = FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedConcentrates_CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                         /ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories","Feed supply/demand ratio (ME based, Conc)","AverageProdType","All","Baseline");

PUTCLOSE con "   time elapsed __SOLmV5_DataDerivedBaseline_DetailedFeedingRations 3a:" timeElapsed;

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedByproducts_CommoditySOLmV5,"FeedME supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
                         $ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories","Feed supply/demand ratio (ME based, Conc)","AverageProdType","All","Baseline")
                 = FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedByproducts_CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                         /ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories","Feed supply/demand ratio (ME based, Conc)","AverageProdType","All","Baseline");

PUTCLOSE con "   time elapsed __SOLmV5_DataDerivedBaseline_DetailedFeedingRations 3b:" timeElapsed;

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedForageCrops_CommoditySOLmV5,"FeedME supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
                         $ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories","Feed supply/demand ratio (ME based, Forage)","AverageProdType","All","Baseline")
                 = FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedForageCrops_CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                         /ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories","Feed supply/demand ratio (ME based, Forage)","AverageProdType","All","Baseline");

PUTCLOSE con "   time elapsed __SOLmV5_DataDerivedBaseline_DetailedFeedingRations 3c:" timeElapsed;

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedGrass_CommoditySOLmV5,"FeedME supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
                         $ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories","Feed supply/demand ratio (ME based, Grass)","AverageProdType","All","Baseline")
                 = FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,FeedGrass_CommoditySOLmV5,"FeedME supply per head (MJ/head)","AverageProdType","All","Baseline")
                         /ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories","Feed supply/demand ratio (ME based, Grass)","AverageProdType","All","Baseline");


PUTCLOSE con "   time elapsed __SOLmV5_DataDerivedBaseline_DetailedFeedingRations 4:" timeElapsed;
*the following is slow, to be improved:
*thus, use again the auxiliary inverse parameters already calculated above:

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedGE supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
*                 $ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedME supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedGE cont (MJ/t)","AverageProdType","All","Baseline")
                          *AUX_Inverse_ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline");

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed DM quant supply per head (tDM/head) - SDRatio corrected","AverageProdType","All","Baseline")
*                 $ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline")
         = FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedME supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
                 *ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"DM contents (tDM/t)","AverageProdType","All","Baseline")
                          *AUX_Inverse_ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME cont (MJ/t)","AverageProdType","All","Baseline");

AUX_Inverse_ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"DM contents (tDM/t)","AverageProdType","All","Baseline")
                 $ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"DM contents (tDM/t)","AverageProdType","All","Baseline")
         = 1/ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"DM contents (tDM/t)","AverageProdType","All","Baseline");

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed quant supply per head (t/head) - SDRatio corrected","AverageProdType","All","Baseline")
*                 $ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"DM contents (tDM/t)","AverageProdType","All","Baseline")
         = FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed DM quant supply per head (tDM/head) - SDRatio corrected","AverageProdType","All","Baseline")
                 *AUX_Inverse_ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5,CommoditySOLmV5,"DM contents (tDM/t)","AverageProdType","All","Baseline");

PUTCLOSE con "   time elapsed __SOLmV5_DataDerivedBaseline_DetailedFeedingRations 5:" timeElapsed;

*the following is better derived by multiplying the above with the correct ME and GE/FM contents
$ontext;
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedGE supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
         = sum((FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)$(MatchFeedGroups_CommoditySOLmV5(FeedGroupsSOLmV5,CommoditySOLmV5)
                         AND Match_FeedGroups_FeedGroupSDRation2(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)
                         AND ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")),
                 FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedGE supply per head (MJ/head)","AverageProdType","All","Baseline")
                         /ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline"));

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed DM quant supply per head (tDM/head) - SDRatio corrected","AverageProdType","All","Baseline")
         = sum((FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)$(MatchFeedGroups_CommoditySOLmV5(FeedGroupsSOLmV5,CommoditySOLmV5)
                         AND Match_FeedGroups_FeedGroupSDRation2(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)
                         AND ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")),
                 FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed DM quant supply per head (tDM/head)","AverageProdType","All","Baseline")
                         /ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline"));

FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed quant supply per head (t/head) - SDRatio corrected","AverageProdType","All","Baseline")
         = sum((FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)$(MatchFeedGroups_CommoditySOLmV5(FeedGroupsSOLmV5,CommoditySOLmV5)
                         AND Match_FeedGroups_FeedGroupSDRation2(FeedGroupsSOLmV5,PerLivingHeadParameterSOLmV5)
                         AND ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline")),
                 FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed quant supply per head (t/head)","AverageProdType","All","Baseline")
                         /ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"All Animals","AllCategories",PerLivingHeadParameterSOLmV5,"AverageProdType","All","Baseline"));
$offtext;

*aggregate to get the total Feed DM, ME, GE and XP supply:
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AggregateFeedTotal_CommoditySOLmV5","FeedGE supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
         = sum(CommoditySOLmV5,FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedGE supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline"));
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AggregateFeedTotal_CommoditySOLmV5","FeedME supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
         = sum(CommoditySOLmV5,FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedME supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline"));
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,"AggregateFeedTotal_CommoditySOLmV5","Feed DM quant supply per head (tDM/head) - SDRatio corrected","AverageProdType","All","Baseline")
         = sum(CommoditySOLmV5,FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"Feed DM quant supply per head (tDM/head) - SDRatio corrected","AverageProdType","All","Baseline"));




*1.5) feed digestibility of the feeding rations
*derive digestibility of total feed per animal:

*THIS DOES NOT YET WORK: we do not have commodity-specific digestibility to derive this - thus first assign it on commodity level, then do the following (and drop the NOT condition,
*        otherwise it takes old values only)



FeedingRationSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"AggregateFeedTotal_CommoditySOLmV5","Digestibility of Feed (%)","AverageProdType","All","Baseline")
                 $(NOT FeedingRationSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"AggregateFeedTotal_CommoditySOLmV5","Digestibility of Feed (%)","AverageProdType","All","Baseline"))
         = sum(CommoditySOLmV5,FeedingRationSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"DM share in ration","AverageProdType","All","Baseline")
                 *FeedingRationSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,"AllCategories",CommoditySOLmV5,"Digestibility of Feed (%)","AverageProdType","All","Baseline"));



$ontext;
After this we have the following in SOLmV5-entities:

where:
LivingHeadsBasedTotalValueParameterSOLmV5        is      Total ME demand per feed group (grass, conc, forage, residue)
PerLivingHeadParameterSOLmV5                     is      Share of ME demand per animal type in total ME demand from all animals per feed group (grass, conc, forage, residue)
                                                         supply/demand ration per crop group (grass, conc, forage, residue)
                                                         ME, GE, DM supply per head with and without S/D-Ratio correction
FeedGroupsSOLmV5                                 is      feed groups (grass, conc, forage, residue)

*better Feed GE req of dairy cows:
ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"FeedGE_Req_Total (MJ/head)","AverageProdType","All","Baseline")
*some additional/better FeedME, GE, XP and DM contents for various feed
ParameterPerTonDomestAvailQuantSOLmV5(GeographicRegionSOLmV5_Countries,"Palm kernels","DM contents (tDM/t)","AverageProdType","All","Baseline") = 0.918;
*consistent calculation of FeedME,Fresh matter,DM quantities
DomestAvailableQuantityBasedTotalValuesSOLmV5.l(GeographicRegionSOLmV5,CommoditySOLmV5,"FeedME (MJ)","AverageProdType","All","Baseline")
*consistent calculation of FeedME,Fresh matter,DM, GE supply per head quantities
FeedingRationSOLmV5(GeographicRegionSOLmV5,LiveAnimalsSOLmV5,AnimalCategoriesInHerdSOLmV5,CommoditySOLmV5,"FeedGE supply per head (MJ/head) - SDRatio corrected","AverageProdType","All","Baseline")
*amd all this also aggregated to Feed Groups Conc, grass, Forage, - byproducts, if needed)


$offtext;




$ontext;

*        XXX STILL TO BE DONE:
*Missing: crop specific digestibility!!

currently: Digest not available for Feed groups, only for all feed - thus assign for feed groups. OR commoditis, then derive for the whole ration.
but then, may drop the conditional!!

Digestibility of feed has to be derived in the scenarios anew!! - thus do more general code, not only for the baseline with the data as read in.

$offtext;

