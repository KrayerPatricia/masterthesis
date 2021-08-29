PUTCLOSE con,"_V6_ReadData_VariousSources_AnimalNutrientRequirementsData";

$ontext;
GENERAL DESCRIPTION
This file assigns the animal nutrient requirements values

DETAILED TABLE OF CONTENTS
- 1) Animal nutrient requirements data as used in old SOLm version (up to version SOLmV4)
         1.1) ME and XP requirements, global data
         1.2) some parameters to derive more detailed nutrient requirement values
- 2) Animal nutrient requirements data as defined in XXX
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Animal nutrient requirements data as used in old SOLm version (up to version SOLmV4)
*1.1) ME and XP requirements, global data

*unit: FeedME MJ/head/day, FeedXP kg Protein/head/day, FeedGE MJ/head/day, FeedNEL MJ/head/day
Set ReadAnimalNutrientElement
/
FeedME_req
FeedGE_req
FeedXP_req
FeedNEL_req
/;

*unit: MJ ME/head/day; kg XP/head/day
Parameter AnimalNutrientRequirements_VariousSources(FAOSTAT_CountriesAndRegions,Livestock,AnimalTypeInHerd,OtherCharAnimals);

*first, global values are assigned - Source energy: fixed values according to FiBL-GHG-Farm-Model (MJ ME/day/head); protein as well (?); Source horses: Kirchgessner 1995

AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Sows","FeedME_req_Total (MJ)") = 35.5;
*sow: derived from XP req below in relation to other pig types)
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Sucklers","FeedME_req_Total (MJ)") = 0;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Weaners","FeedME_req_Total (MJ)") = 10;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Fatteners","FeedME_req_Total (MJ)") = 25.5;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Boars","FeedME_req_Total (MJ)") = 30;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Rep_Sows","FeedME_req_Total (MJ)") = 27;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Rep_Boars","FeedME_req_Total (MJ)") = 27;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Sows","FeedXP_req_Total (t)") = 0.00035;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Sucklers","FeedXP_req_Total (t)") = 0;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Weaners","FeedXP_req_Total (t)") = 0.00015;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Fatteners","FeedXP_req_Total (t)") = 0.0002;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Boars","FeedXP_req_Total (t)") = 0.00025;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Rep_Sows","FeedXP_req_Total (t)") = 0.0002;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigs","Rep_Boars","FeedXP_req_Total (t)") = 0.0002;

*the following does an improved calculation of the nutrient requirements for sows (therefore not assigned above), based on data filed in in the module "__SOLmV5_ReadData_VariousSources_HerdStructures.gms"
*unit: MJ / head / day
$ontext;
*this calculations needs to be imporved - do not use for now
AnimalNutrientRequirements_VariousSources(FAOSTAT_CountriesAndRegions,"Pigs","Sows","FeedME_req_Total (MJ)")
          =  (result_h_pigs(FAOSTAT_CountriesAndRegions,"maintainance_energy_sow")
                 +((
                  (result_h_pigs(FAOSTAT_CountriesAndRegions,"days_early_pregnancy")  *result_h_pigs(FAOSTAT_CountriesAndRegions,"early_pregnancy_energy_sow"))
                 +(result_h_pigs(FAOSTAT_CountriesAndRegions,"days_late_pregnancy")     *result_h_pigs(FAOSTAT_CountriesAndRegions,"late_pregnancy_energy_sow"))
                 +(result_h_pigs(FAOSTAT_CountriesAndRegions,"lactating_days")          *result_h_pigs(FAOSTAT_CountriesAndRegions,"lactation_energy_sow"))
                 +(result_h_pigs(FAOSTAT_CountriesAndRegions,"post_lactation_open_days")*result_h_pigs(FAOSTAT_CountriesAndRegions,"early_pregnancy_energy_sow"))
                    )/365))     ;
$offtext;

*ATTENTION: SUCKLERS missing, add values!! - NO, not needed, as covered by the suckling sow!

AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","Dsires","FeedME_req_Total (MJ)") = 100;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","DFemaleCalves1","FeedME_req_Total (MJ)") = 27.81;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","DFemaleCalves2","FeedME_req_Total (MJ)") = 51.45;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","DFemaleCalves3","FeedME_req_Total (MJ)") = 69.74;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","DMaleCalves1","FeedME_req_Total (MJ)") = 27.81;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","DMaleCalves2","FeedME_req_Total (MJ)") = 86;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","Bcows","FeedME_req_Total (MJ)") = 99.92;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","BMaleCalves1","FeedME_req_Total (MJ)") = 27.81;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","BFemaleCalves1","FeedME_req_Total (MJ)") = 27.81;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","BMaleCalves2","FeedME_req_Total (MJ)") = 86;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","BFemaleCalves2","FeedME_req_Total (MJ)") = 51.45;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","Bsires","FeedME_req_Total (MJ)") = 100;

AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","Dsires","FeedXP_req_Total (t)") = 0.0009;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","DFemaleCalves1","FeedXP_req_Total (t)") = 0.00042;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","DFemaleCalves2","FeedXP_req_Total (t)") = 0.0007;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","DFemaleCalves3","FeedXP_req_Total (t)") = 0.001;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","DMaleCalves1","FeedXP_req_Total (t)") = 0.00042;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","DMaleCalves2","FeedXP_req_Total (t)") = 0.001032;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","Bcows","FeedXP_req_Total (t)") = 0.001399;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","BMaleCalves1","FeedXP_req_Total (t)") = 0.00042;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","BFemaleCalves1","FeedXP_req_Total (t)") = 0.00042;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","BMaleCalves2","FeedXP_req_Total (t)") = 0.001032;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","BFemaleCalves2","FeedXP_req_Total (t)") = 0.0007;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","Bsires","FeedXP_req_Total (t)") = 0.0009;

*dairy cows are calculated based on yields, etc. - for this, further parameters are defined further down.

AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Chickens","AllAndAverageTypes","FeedME_req_Total (MJ)") = 1.26;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Chickens","AllAndAverageTypes","FeedXP_req_Total (t)") = 0.00001769;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Horses","AllAndAverageTypes","FeedME_req_Total (MJ)") = 60;
*An earlier value for XP has been 0.3, but this gives a relation of gXP/MJ of only 5 - all oth eranimals have 12 or higher (Pigs), thus change to a relation of 12 via 0.72 kg/day for XP
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Horses","AllAndAverageTypes","FeedXP_req_Total (t)") = 0.00072;


*the following number is based on information from Salvador Garibay: average feed for a beehive: 20l sugar syrup, i.e. 15kg Sugar; kcal cont.: 390kcal/100g: i.e. 15*3900 kcal = 251MJ; per year - thus divided by 365: 0.6876712
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Beehives","AllAndAverageTypes","FeedME_req_Total (MJ)") = 0.0006876712;

$ontext;
*now derive feeding requirements for all the other animals
*this is done with scaling the feed requirements of cattle ("Average Other Cattle IPCC2006"), pigs ("Average Market Swine IPCC2006"), horses ("Average Horse IPCC2006") and chicken ("Chickens Layer (dry) IPCC2006")
*        with the liveweight factor between these animal types and the ones to be calculated
*thus ReqB = ReqA*(LiveweightA/LiveweightB)**0.75
*power 0.75: according to IPCC 2006, Vol 4, chapter 10, around eq 10.17 somewhere
$offtext;

AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Buffaloes","AllAndAverageTypes",OtherCharAnimals)
                 $Liveweight_IPCC2006(FAOSTAT_Countries,"BFemaleCalves2")
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","BFemaleCalves2",OtherCharAnimals)
                         *(Liveweight_IPCC2006(FAOSTAT_Countries,"Average Buffaloes IPCC2006")
                                 /Liveweight_IPCC2006(FAOSTAT_Countries,"BFemaleCalves2"))**0.75;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Sheep","AllAndAverageTypes",OtherCharAnimals)
                 $Liveweight_IPCC2006(FAOSTAT_Countries,"BFemaleCalves2")
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","BFemaleCalves2",OtherCharAnimals)
                         *(Liveweight_IPCC2006(FAOSTAT_Countries,"Average Sheep IPCC2006")
                                 /Liveweight_IPCC2006(FAOSTAT_Countries,"BFemaleCalves2"))**0.75;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Goats","AllAndAverageTypes",OtherCharAnimals)
                 $Liveweight_IPCC2006(FAOSTAT_Countries,"BFemaleCalves2")
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","BFemaleCalves2",OtherCharAnimals)
                         *(Liveweight_IPCC2006(FAOSTAT_Countries,"Average Goat IPCC2006")
                                 /Liveweight_IPCC2006(FAOSTAT_Countries,"BFemaleCalves2"))**0.75;

AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Camels","AllAndAverageTypes",OtherCharAnimals)
                 $Liveweight_IPCC2006(FAOSTAT_Countries,"Average Horse IPCC2006")
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Horses","AllAndAverageTypes",OtherCharAnimals)
                         *(Liveweight_IPCC2006(FAOSTAT_Countries,"Average Camel IPCC2006")
                                 /Liveweight_IPCC2006(FAOSTAT_Countries,"Average Horse IPCC2006"))**0.75;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Mules","AllAndAverageTypes",OtherCharAnimals)
                 $Liveweight_IPCC2006(FAOSTAT_Countries,"Average Horse IPCC2006")
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Horses","AllAndAverageTypes",OtherCharAnimals)
                         *(Liveweight_IPCC2006(FAOSTAT_Countries,"Average Mule IPCC2006")
                                 /Liveweight_IPCC2006(FAOSTAT_Countries,"Average Horse IPCC2006"))**0.75;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Asses","AllAndAverageTypes",OtherCharAnimals)
                 $Liveweight_IPCC2006(FAOSTAT_Countries,"Average Horse IPCC2006")
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Horses","AllAndAverageTypes",OtherCharAnimals)
                         *(Liveweight_IPCC2006(FAOSTAT_Countries,"Average Ass IPCC2006")
                                 /Liveweight_IPCC2006(FAOSTAT_Countries,"Average Horse IPCC2006"))**0.75;

AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Turkeys","AllAndAverageTypes",OtherCharAnimals)
                 $Liveweight_IPCC2006(FAOSTAT_Countries,"Average Chicken IPCC2006")
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Chickens","AllAndAverageTypes",OtherCharAnimals)
                         *(Liveweight_IPCC2006(FAOSTAT_Countries,"Average Turkey IPCC2006")
                                 /Liveweight_IPCC2006(FAOSTAT_Countries,"Average Chicken IPCC2006"))**0.75;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Ducks","AllAndAverageTypes",OtherCharAnimals)
                 $Liveweight_IPCC2006(FAOSTAT_Countries,"Average Chicken IPCC2006")
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Chickens","AllAndAverageTypes",OtherCharAnimals)
                         *(Liveweight_IPCC2006(FAOSTAT_Countries,"Average Duck IPCC2006")
                                 /Liveweight_IPCC2006(FAOSTAT_Countries,"Average Chicken IPCC2006"))**0.75;
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Rabbits and hares","AllAndAverageTypes",OtherCharAnimals)
                 $Liveweight_IPCC2006(FAOSTAT_Countries,"Average Chicken IPCC2006")
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Chickens","AllAndAverageTypes",OtherCharAnimals)
                         *(Liveweight_IPCC2006(FAOSTAT_Countries,"Rabbits IPCC2006")
                                 /Liveweight_IPCC2006(FAOSTAT_Countries,"Average Chicken IPCC2006"))**0.75;


*and add missing animals:
*assumption by A. Müller: Llamas, etc. weight a third of a camel on average, about 70kg
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Camelids, other","AllAndAverageTypes",OtherCharAnimals)
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Camels","AllAndAverageTypes",OtherCharAnimals)*((1/3)**0.75);
*and some more
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Geese and guinea fowls","AllAndAverageTypes",OtherCharAnimals)
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Ducks","AllAndAverageTypes",OtherCharAnimals);
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Rodents, other","AllAndAverageTypes",OtherCharAnimals)
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Rabbits and hares","AllAndAverageTypes",OtherCharAnimals);
*Pigeons, other birds: 0.1* Chickens weight
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Pigeons, other birds","AllAndAverageTypes",OtherCharAnimals)
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Chickens","AllAndAverageTypes",OtherCharAnimals)*((0.1)**0.75);
*Animals live nes: Asses
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Animals live nes","AllAndAverageTypes",OtherCharAnimals)
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Asses","AllAndAverageTypes",OtherCharAnimals);
*game: 70% of horses
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Game","AllAndAverageTypes",OtherCharAnimals)
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Horses","AllAndAverageTypes",OtherCharAnimals)*0.7;


*1.2) some parameters to derive more detailed nutrient requirement values
*this section contains various parameters that are used for calculating more detailed nutrient requirement values later in the code

*A) the following parameters are used in an improved calculation of the nutrient requirements for dairy cows
*based on the tables from Simon Moakes, Alpenprojekt / New Zealand model (?)

Set DairyFeedReqParameter
/
"Milk solid contents (t/t)"
"Daily walking distance (km)"
"Summergrazing (days)"
"ME to produce 1kg milk (MJ/kg milk)"
"ME maintenance per weight per day (MJ/kg liveweight/day)"
"ME maintenance basis per day (MJ/day)"
"ME walking per km (MJ/km)"
"ME pregnancy per weight per day (MJ/kg liveweight/day)"
"ME pregnancy basis per day (MJ/day)"
"FeedME_Req_MilkProd (MJ/head)"
"FeedME_Req_Walking (MJ/head)"
"FeedME_Req_Maintenance (MJ/head)"
"FeedME_Req_Pregnancy (MJ/head)"
"FeedME_Req_Total (MJ/head)"
/;

Parameter VariousSources_DairyCowFeedReqParameters(FAOSTAT_CountriesAndRegions,DairyFeedReqParameter);
*unit: share, i.e. percentage/100 solid contents in milk
VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"Milk solid contents (t/t)") = 0.08;
*unit: km/day/head
VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"Daily walking distance (km)") = 2;
*unit: days
*****SHOULD Be improved according to the feeding ration: this is for Western Europe, let's say, - but should be adapted to more/less grass in the ration.
VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"Summergrazing (days)") = 180;

*unit MJ ME / kg milk
VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME to produce 1kg milk (MJ/kg milk)")
         = VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"Milk solid contents (t/t)")
                 *83;
VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME maintenance per weight per day (MJ/kg liveweight/day)") = 0.09;
VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME maintenance basis per day (MJ/day)") = 14;
VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME walking per km (MJ/km)") = 2;
VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME pregnancy per weight per day (MJ/kg liveweight/day)") = 3.5/365;
VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME pregnancy basis per day (MJ/day)") = 1575/365;

*BELOW: how these values then have to be used to determine dairy cattle ME req
*division by 10 as the formula is for yields in kg milk, but yields are in hg currently
VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"FeedME_Req_MilkProd (MJ/head)")
         = FAOSTAT_LivestockPrimaryProduction(FAOSTAT_Countries,"Milk, whole fresh cow","Yield","AverageBasisYear","hg/An")/10
                 *VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME to produce 1kg milk (MJ/kg milk)");
*the SOLmV5 parameter for yield would be:
*        ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing","Milk yield (t/head)","AverageProdType","All","Baseline")
*and for the ME req for milk production per head
*        ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,"Cattle","Producing","FeedME_Req_MilkProd (MJ/head)","AverageProdType","All","Baseline")

VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"FeedME_Req_Maintenance (MJ/head)")
                 $Liveweight_IPCC2006(FAOSTAT_Countries,"Producing_Dairy_Cattle")
         =(VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME maintenance basis per day (MJ/day)")
                  + VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME maintenance per weight per day (MJ/kg liveweight/day)")
                         *Liveweight_IPCC2006(FAOSTAT_Countries,"Producing_Dairy_Cattle"))*365;
*the SOLmV5 parameter for liveweight would be
*        ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"Liveweight (t/head)","AverageProdType","All","Baseline")

VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"FeedME_Req_Walking (MJ/head)")
                 $VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"Summergrazing (days)")
         =VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"Summergrazing (days)")
                 *VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME walking per km (MJ/km)")
                         *VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"Daily walking distance (km)")
         +(365-VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"Summergrazing (days)"))
                 *VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME walking per km (MJ/km)")*1;
*assuming to walk 1km in non-grazing days - seems long

VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"FeedME_Req_Pregnancy (MJ/head)")
                 $Liveweight_IPCC2006(FAOSTAT_Countries,"Producing_Dairy_Cattle")
         =(VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME pregnancy basis per day (MJ/day)")
                  + VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"ME pregnancy per weight per day (MJ/kg liveweight/day)")
                         *Liveweight_IPCC2006(FAOSTAT_Countries,"Producing_Dairy_Cattle"))*365;
*the SOLmV5 parameter for liveweight would be
*        ParameterPerAnimalHead_HerdStructureSOLmV5(GeographicRegionSOLmV5,ActivitySOLmV5,AnimalCategoriesInHerdSOLmV5,"Liveweight (t/head)","AverageProdType","All","Baseline")

*now sum the various parts from above:
VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"FeedME_Req_Total (MJ/head)")
                 $(NOT VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"FeedME_Req_Total (MJ/head)"))
         = VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"FeedME_Req_MilkProd (MJ/head)")
                 +VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"FeedME_Req_Maintenance (MJ/head)")
                 +VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"FeedME_Req_Walking (MJ/head)")
                 +VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"FeedME_Req_Pregnancy (MJ/head)");

*and assign to the general animal nutrient parameter, unit ME/head/day
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","Producing_Dairy_Cattle","FeedME_req_Total (MJ)")
         = VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"FeedME_Req_Total (MJ/head)")/365;


*B) Now provide the needed parameters to derive GE and XP requirements from ME requirements; do this via the relation of XP per ME requirement:
*further down, we derive XP demand from ME demand via multiplication by XP per ME in feed; for this, a specific parameter is used:
*source: Kirchgässner???
*for cattle, p 392 ff - on average, there is a factor of about 12 between MJ ME and g XP, thus assign as follows (/1000 because of g->kg XP).
*then for goats and sheep, p 451-456: - not yet done

Set NutrientRelationsElement
/
"XPperME_InFeedReq"
"GEperME_InFeedReq"
/;

*unit: g XP per MJ
Parameter VariousSources_NutrientRelations_InFeedReq(FAOSTAT_CountriesAndRegions,Livestock,AnimalTypeInHerd,NutrientRelationsElement);


VariousSources_NutrientRelations_InFeedReq(FAOSTAT_Countries,"Cattle",CattleTypeInHerd,"XPperME_InFeedReq") = 12;

*values adapted for sows and non-lactating sows (boar, rep sow and rep boar) according to Simons detailed assessment of pig XP requirements
*original values retained in comment mode
VariousSources_NutrientRelations_InFeedReq(FAOSTAT_Countries,"Pigs","Sows","XPperME_InFeedReq")              = 12;
*         = 12.2;
VariousSources_NutrientRelations_InFeedReq(FAOSTAT_Countries,"Pigs","Weaners","XPperME_InFeedReq")           = 16;
VariousSources_NutrientRelations_InFeedReq(FAOSTAT_Countries,"Pigs","Boars","XPperME_InFeedReq")             = 8.5;
*         = 15;
VariousSources_NutrientRelations_InFeedReq(FAOSTAT_Countries,"Pigs","Rep_Boars","XPperME_InFeedReq")         = 8.2;
*         = 15;
VariousSources_NutrientRelations_InFeedReq(FAOSTAT_Countries,"Pigs","Rep_Sows","XPperME_InFeedReq")          = 8.2;
*         = 15;
VariousSources_NutrientRelations_InFeedReq(FAOSTAT_Countries,"Pigs","Fatteners","XPperME_InFeedReq")         = 12.5;
*ATTENTION!! CHECK SUCKLERS AGAIN!!
VariousSources_NutrientRelations_InFeedReq(FAOSTAT_Countries,"Pigs","Sucklers","XPperME_InFeedReq")          = 16;

*derive XP by means of those relation:
*division by 1000000 as the relation is in gXP/MJ and we want tXP


*DROP MOST OF IT - ONLY NEEDED FOR DAIRY CATTLE - rest assigned directly, above.

*ATTENTIONM: CURRENTLY NOT USED BESIDES FOR DAIRY CATTLE, as for those XP req is otherwise missing!!!
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","Producing_Dairy_Cattle","FeedXP_req_Total (t)")
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,"Cattle","Producing_Dairy_Cattle","FeedME_req_Total (MJ)")
                 *VariousSources_NutrientRelations_InFeedReq(FAOSTAT_Countries,"Cattle","Producing_Dairy_Cattle","XPperME_InFeedReq")/1000000;

*when applying these values, this leads to considerably different values for some of the pig categories in herd -
*ATTENTION - WHICH VALUES TO USE???
*SEE THE COMPARISON for PIGS below:                                   ME from above  XP derived    XP from above
*but there are also differences FOR CATTLE!!
*AnimalNutrientRequirements(FAOSTAT_Countries,"Pigs","Weaners","FeedME_req") = 10;      0.00016             0.00015
*AnimalNutrientRequirements(FAOSTAT_Countries,"Pigs","Fatteners","FeedME_req") = 25.5;  0.00031875          0.0002
*AnimalNutrientRequirements(FAOSTAT_Countries,"Pigs","Boars","FeedME_req") = 30;        0.000255            0.00025
*AnimalNutrientRequirements(FAOSTAT_Countries,"Pigs","Rep_Sows","FeedME_req") = 27;     0.0003014           0.0002
*AnimalNutrientRequirements(FAOSTAT_Countries,"Pigs","Rep_Boars","FeedME_req") = 27;    0.0003014           0.0002

*C) we now prepare the inputs needed for the GE requirements as well; then derive XP and GE requirements;
*this is needed in particular for the manure calculations
*For manure quantities, we go for DM volatile and total solids, as calculated in eq. 10.24 IPCC 2006 guidelines, volume 4, chapter 10:
*these use a range of parameters related to feed
*use the default values from IPCC 2006
*We also use some further specific values from Table 10A-9 in IPCC 2006, Vol. 4, chapter 10:
*And some further data according to Vol4, chapter 10, Table 10.2
*This latter table covers the animals:
*        Sheep, goats, camels, horses, mules, asses, poultry (Layers, broilers, Turkeys,ducks)

*the following parameters are needed for that (besides Nex that is already around from the manure management calculations):
*DigestibilityOfFeed, UE_per_GE, GE_Content

*ATTENTION: to be checked again and improved based on the original IPCC 2006 tables

Parameter DigestibilityOfFeed_IPCC2006(FAOSTAT_CountriesAndRegions,Livestock,AnimalTypeInHerd);

*First, assign refined values, then, assign general values, where values are still missing
*unit: percentage
*Source: PCC 2006, Vol. 4, chapter 10
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Sheep","AllAndAverageTypes") = 50;
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Goats","AllAndAverageTypes") = 50;
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Camels","AllAndAverageTypes") = 50;

DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Horses","AllAndAverageTypes") = 70;
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Mules","AllAndAverageTypes") = 70;
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Asses","AllAndAverageTypes") = 70;

*specific values for pigs, differentiated by pig system "Pigs confined IPCC2006" and "Pigs free-range IPCC2006": 80 and 60 respectively:
*For simplicity, also suggest some average:
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Pigs","AllAndAverageTypes") = 70;

*specific values for poultry, by poultry system type, again confined and free-range, 85 (turkey: 90) and 70, respectively:
*For simplicity, also suggest some average:
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Chickens","AllAndAverageTypes") = 77;
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Ducks","AllAndAverageTypes") = 77;
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Geese and guinea fowls","AllAndAverageTypes") = 77;
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Pigeons, other birds","AllAndAverageTypes") = 77;
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Turkeys","AllAndAverageTypes") = 85;

*for cattle, we account for the systems: high-conc 80, pasture 60, low quality forage 50
*For simplicity, also suggest some average:
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,"Cattle","AllAndAverageTypes") = 70;


*now assign general values for all animals, where values are still missing:
DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,Livestock,"AllAndAverageTypes")
                 $(NOT DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,Livestock,"AllAndAverageTypes"))
         = 60;

*unit: share (i.e. percentage/100)
*Source: IPCC 2006, Vol. 4, chapter 10
Parameter UE_per_GE_IPCC2006(FAOSTAT_CountriesAndRegions,Livestock,AnimalTypeInHerd) urinary energy expressed as fraction of GE;
UE_per_GE_IPCC2006(FAOSTAT_Countries,Livestock,"AllAndAverageTypes") = 0.04;
UE_per_GE_IPCC2006(FAOSTAT_Countries,"Pigs","AllAndAverageTypes") = 0.02;


*unit: MJ GE/kg DM
*Source: IPCC 2006, Vol. 4, chapter 10
Parameter GE_Content_IPCC2006(FAOSTAT_CountriesAndRegions,Livestock,AnimalTypeInHerd);
*may improve with the tables from the Gerber livestock GHG value chain reports
GE_Content_IPCC2006(FAOSTAT_Countries,Livestock,"AllAndAverageTypes") = 18.45;
*IS THIS NEEDED AT ALL - AND FOR WHAT?


*Now derive GE req from ME req and the parameters introduced above:
*In the following, we need the GE uptake, but we do only have ME requirements data currently.
*ME requirements is converted into GE requirements and assuming no feed waste, requirements equal uptake.
*according to http://www.fao.org/wairdocs/ilri/x5469e/x5469e0a.htm, and the definitions of Digestability DE% and UE, we have
*DE = GE - Faeces = GE*DE%/100, thus GE*(1-DE%/100) = Faeces, thus GE*(1-DE%/100) + UE*GE= Faeces + Urine
*ME = DE - urine = GE - faeces - urine = GE - GE*(1-DE%/100) - UE*GE = GE*DE%/100 - UE*GE
*Thus, ME = GE (DE%/100 - UE) and GE = ME/(DE%/100 - UE); this is used to derive GE from ME:

*parameters for this are defined at the end of this file
*unit: MJ GE/head/day
AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,Livestock,AnimalTypeInHerd,"FeedGE_req_Total (MJ)")
                 $(DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,Livestock,"AllAndAverageTypes")/100
                         - UE_per_GE_IPCC2006(FAOSTAT_Countries,Livestock,"AllAndAverageTypes"))
         = AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,Livestock,AnimalTypeInHerd,"FeedME_req_Total (MJ)")
                 /(DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,Livestock,"AllAndAverageTypes")/100
                         - UE_per_GE_IPCC2006(FAOSTAT_Countries,Livestock,"AllAndAverageTypes"));


$ontext;
after this, we have:
Parameter AnimalNutrientRequirements_VariousSources(FAOSTAT_CountriesAndRegions,Livestock,AnimalTypeInHerd,OtherCharAnimals);
Parameter VariousSources_DairyCowFeedReqParameters(FAOSTAT_CountriesAndRegions,DairyFeedReqParameter);
Parameter VariousSources_NutrientRelations_InFeedReq(FAOSTAT_CountriesAndRegions,Livestock,AnimalTypeInHerd,NutrientRelationsElement);
Parameter DigestibilityOfFeed_IPCC2006(FAOSTAT_CountriesAndRegions,Livestock,AnimalTypeInHerd);
Parameter UE_per_GE_IPCC2006(FAOSTAT_CountriesAndRegions,Livestock,AnimalTypeInHerd) urinary energy expressed as fraction of GE;
Parameter GE_Content_IPCC2006(FAOSTAT_CountriesAndRegions,Livestock,AnimalTypeInHerd);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Animal nutrient requirements data as defined in XXX

*XXX






****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed


*3.2) Link to the core model parameters

*factor 365, because the original units are FeedME MJ/head/day, FeedXP t Protein/head/day, FeedGE MJ/head/day, FeedNEL MJ/head/day
*FeedME_req
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"FeedME_req_Total (MJ)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                   AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,Livestock,AnimalTypeInHerd,"FeedME_req_Total (MJ)"))*365;

*FeedXP_req:
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"FeedXP_req_Total (t)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                   AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,Livestock,AnimalTypeInHerd,"FeedXP_req_Total (t)"))*365;

*FeedGE_req
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"FeedGE_req_Total (MJ)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                   AnimalNutrientRequirements_VariousSources(FAOSTAT_Countries,Livestock,AnimalTypeInHerd,"FeedGE_req_Total (MJ)"))*365;


Set Match_DairyFeedReqPar_OtherCharAnimals(DairyFeedReqParameter,OtherCharAnimals)
/
"Daily walking distance (km)"."DailyWalkingDistance (km)"
"Summergrazing (days)"."Summergrazing (days)"
"ME to produce 1kg milk (MJ/kg milk)"."ME to produce 1kg milk (MJ/kg milk)"
"ME maintenance per weight per day (MJ/kg liveweight/day)"."ME maintenance per weight per day (MJ/kg liveweight/day)"
"ME maintenance basis per day (MJ/day)"."ME maintenance basis per day (MJ/day)"
"ME walking per km (MJ/km)"."ME walking per km (MJ/km)"
"ME pregnancy per weight per day (MJ/kg liveweight/day)"."ME pregnancy per weight per day (MJ/kg liveweight/day)"
"ME pregnancy basis per day (MJ/day)"."ME pregnancy basis per day (MJ/day)"
"FeedME_Req_MilkProd (MJ/head)"."FeedME_Req_MilkProd (MJ)"
"FeedME_Req_Walking (MJ/head)"."FeedME_Req_Walking (MJ)"
"FeedME_Req_Maintenance (MJ/head)"."FeedME_Req_Maintenance (MJ)"
"FeedME_Req_Pregnancy (MJ/head)"."FeedME_Req_Pregnancy (MJ)"
"FeedME_Req_Total (MJ/head)"."FeedME_Req_Total (MJ)"
/;

ActAnimalsHead_OtherChar(Regions,"Cattle","Producing_Dairy_Cattle",OtherCharAnimals,"AllProdSyst","AllProdCond")
                 $(NOT ActAnimalsHead_OtherChar(Regions,"Cattle","Producing_Dairy_Cattle",OtherCharAnimals,"AllProdSyst","AllProdCond"))
         = sum((DairyFeedReqParameter,FAOSTAT_Countries)$(Match_DairyFeedReqPar_OtherCharAnimals(DairyFeedReqParameter,OtherCharAnimals)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,DairyFeedReqParameter));

Commod_Contents(Regions,"Milk, Whole","Milk solid contents (t)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_DairyCowFeedReqParameters(FAOSTAT_Countries,"Milk solid contents (t/t)"));

ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"XPperME_InFeedReq (gXP/MJ)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 VariousSources_NutrientRelations_InFeedReq(FAOSTAT_Countries,Livestock,AnimalTypeInHerd,"XPperME_InFeedReq"));


*"UE_per_GE (share)" and "Animal specific FeedGE cont (MJ/t)" are defined here on the level of total feed, hence as a parameter per animal head:
ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","UE_per_GE (share)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 UE_per_GE_IPCC2006(FAOSTAT_Countries,Livestock,"AllAndAverageTypes"));

*not needed: all info in per head param, APU only assigned later in Steering 2 towards the end
*ActAnimalsAPU_OtherChar(Regions,Livestock,"AllAndAverageTypes","UE_per_GE (share)","AllProdSyst","AllProdCond")
*         = ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","UE_per_GE (share)","AllProdSyst","AllProdCond");

*factor 1000 to convert from per kg to per ton
ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","Animal specific FeedGE cont (MJ/t)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 GE_Content_IPCC2006(FAOSTAT_Countries,Livestock,"AllAndAverageTypes"))*1000;

*not needed: all info in per head param, APU only assigned later in Steering 2 towards the end
*ActAnimalsAPU_OtherChar(Regions,Livestock,"AllAndAverageTypes","Animal specific FeedGE cont (MJ/t)","AllProdSyst","AllProdCond")
*         = ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","Animal specific FeedGE cont (MJ/t)","AllProdSyst","AllProdCond");


ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","Digestibility of Feed (%)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                   DigestibilityOfFeed_IPCC2006(FAOSTAT_Countries,Livestock,"AllAndAverageTypes"));

*not needed: all info in per head param, APU only assigned later in Steering 2 towards the end
*ActAnimalsAPU_OtherChar(Regions,Livestock,"AllAndAverageTypes","Digestibility of Feed (%)","AllProdSyst","AllProdCond")
*         = ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","Digestibility of Feed (%)","AllProdSyst","AllProdCond");

*assign to Cattle and pig herd types:
ActAnimalsHead_OtherChar(Regions,"Cattle",CattleTypeInHerd,"Digestibility of Feed (%)","AllProdSyst","AllProdCond")
                 $(NOT ActAnimalsHead_OtherChar(Regions,"Cattle",CattleTypeInHerd,"Digestibility of Feed (%)","AllProdSyst","AllProdCond"))
         = ActAnimalsHead_OtherChar(Regions,"Cattle","AllAndAverageTypes","Digestibility of Feed (%)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Pigs",PigTypeInHerd,"Digestibility of Feed (%)","AllProdSyst","AllProdCond")
                 $(NOT ActAnimalsHead_OtherChar(Regions,"Pigs",PigTypeInHerd,"Digestibility of Feed (%)","AllProdSyst","AllProdCond"))
         = ActAnimalsHead_OtherChar(Regions,"Pigs","AllAndAverageTypes","Digestibility of Feed (%)","AllProdSyst","AllProdCond");



$ontext;
After this we have the following in SOLm-entities:

ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"FeedME_req_Total (MJ)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"FeedXP_req_Total (t)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"FeedGE_req_Total (MJ)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,"Cattle","Producing_Dairy_Cattle",OtherCharAnimals,"AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"XPperME_InFeedReq (gXP/MJ)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","UE_per_GE (share)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","Animal specific FeedGE cont (MJ/t)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","Digestibility of Feed (%)","AllProdSyst","AllProdCond")


*not needed: all info in per head param, APU only assigned later in Steering 2 towards the end
ActAnimalsAPU_OtherChar(Regions,Livestock,AnimalTypeInHerd,"UE_per_GE (share)","AllProdSyst","AllProdCond")
ActAnimalsAPU_OtherChar(Regions,Livestock,AnimalTypeInHerd,"Animal specific FeedGE cont (MJ/t)","AllProdSyst","AllProdCond")
ActAnimalsAPU_OtherChar(Regions,Livestock,AnimalTypeInHerd,"Digestibility of Feed (%)","AllProdSyst","AllProdCond")

Commod_Contents(Regions,"Milk, Whole","Milk solid contents (t)","AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries
OtherCharAnimals  is      (for Dairy cattle) specific parameters to derive ME requirements: "FeedME_Req_MilkProd (MJ/head)", "FeedME_Req_Maintenance (MJ/head)", "FeedME_Req_Walking (MJ/head)", "FeedME_Req_Pregnancy (MJ/head)"


*XXX STILL TO BE DONE:
*Liveweight factor depends on the intensity of the system - this is not yet differentiated,

*Derive aggregate Feed GE, ME, XP, DM contents - in relation to feeding rations and animal types
*And GE, ME, XP, DM requirements as well - if not yet available
$offtext;
