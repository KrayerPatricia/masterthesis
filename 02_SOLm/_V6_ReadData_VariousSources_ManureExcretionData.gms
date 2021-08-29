PUTCLOSE con,"_V6_ReadData_VariousSources_ManureExcretionData";

$ontext;
*GENERAL DESCRIPTION
*This file reads and/or assigns the values for manure excretion - in particular N excretion

*DETAILED TABLE OF CONTENTS
- 1) N excretion from IPCC 2006
- 2) Manure ash content from IPCC 2006
- 3) P excretion
- 4) Assign values to core model parameters and variables
         4.1) Link some sets as needed
         4.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) N excretion from IPCC 2006

Parameter Nex_IPCC2006(FAOSTAT_CountriesAndRegions,AnimalTypeInHerd) average N excretion of animals;
*unit:  kg N /1000kg liveweight / day
*only for mink and polecat, rabbits, fox and racoon  it is kg N per head and year!!!

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewVariousSourcesNExcretionData% == "YES"
$call GDXXRW IPCC2006_NExcretionData_31_12_2017.xlsx  o=IPCC2006_NExcretionData_31_12_2017.gdx  index=index!a1:e2
*contains data for N excretion values
$endif;

$gdxin IPCC2006_NExcretionData_31_12_2017.gdx
$load Nex_IPCC2006
$gdxin

$ontext;
*original regions(left - but already changed in the excel file according to the assignment given below), and corresponding FAOSTAT regions assigned (right):
North America            Northern America
Western Europe           Western Europe, Northern Europe
Eastern Europe           Eastern Europe, Southern Europe
Oceania                  Oceania
Latin America            South America, Central America, Caribbean
Asia                     Asia
Africa                   Africa
Middle East              Western Asia
$offtext;

*assign the missing sub-continents:
Nex_IPCC2006("Northern Europe",AnimalTypeInHerd)
         = Nex_IPCC2006("Western Europe",AnimalTypeInHerd);
Nex_IPCC2006("Southern Europe",AnimalTypeInHerd)
         = Nex_IPCC2006("Eastern Europe",AnimalTypeInHerd);

Nex_IPCC2006("Central America",AnimalTypeInHerd)
         = Nex_IPCC2006("South America",AnimalTypeInHerd);
Nex_IPCC2006("Caribbean",AnimalTypeInHerd)
         = Nex_IPCC2006("South America",AnimalTypeInHerd);


*now assign the regional average values to the countries within those regions, where no data is available on country level

*First, on the level of sub-continents
Nex_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd)
         = sum(FAOSTAT_Subcontinents$FAOSTAT_CountriesInRegions(FAOSTAT_Subcontinents,FAOSTAT_Countries),Nex_IPCC2006(FAOSTAT_Subcontinents,AnimalTypeInHerd));

*second, if no sub-continent averages are available, on the level of continents:
*conditional to whether there are now values on country levels (original, or from the sub-continents) - thus, only the truly missing are assigned
Nex_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd)
                 $(NOT Nex_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd))
         = sum(FAOSTAT_Continents$FAOSTAT_CountriesInRegions(FAOSTAT_Continents,FAOSTAT_Countries),Nex_IPCC2006(FAOSTAT_Continents,AnimalTypeInHerd));


*transform rabbit values to kg N /1000kg liveweight / day as well - not for mink and polecat, fox and racoon - for those, we anyway do not have more data in FAOSTAT, etc. - they are not for food.
*ATTENTION: to be updated later: mink and polecat, fox and racoon

*unit: kg N / 1000kg liveweight / day
Nex_IPCC2006(FAOSTAT_CountriesAndRegions,"Rabbits IPCC2006")
                 $Liveweight_IPCC2006(FAOSTAT_CountriesAndRegions,"Rabbits IPCC2006")
         = Nex_IPCC2006(FAOSTAT_CountriesAndRegions,"Rabbits IPCC2006")
                 /365 /Liveweight_IPCC2006(FAOSTAT_CountriesAndRegions,"Rabbits IPCC2006")*1000;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Manure ash content from IPCC 2006

*For manure quantities, we go for DM volatile and total solids, as calculated in eq. 10.24 IPCC 2006 guidelines, volume 4, chapter 10:
*these use a range of parameters related to feed, they are derived and assigned in the nutrient requirement module above
*Thus, implementing eq. 10.24 IPCC 2006 guidelines, volume 4, chapter 10, we get:
*VS = [GE*(1 - DE%/100) + UE*GE] * [(1 - ASH)/GE_per_DM ]

*unit for VS: kg VS/animal/year
*GE: FeedGE_req is already in per year values
*GE = gross energy intake, MJ day-1
*DE% = digestibility of the feed in percent (e.g. 60%)
*(UE*GE) = urinary energy expressed as fraction of GE. Typically 0.04GE can be considered urinary
*        energy excretion by most ruminants (reduce to 0.02 for ruminants fed with 85% or more grain in the
*        diet or for swine). Use country-specific values where available.
*ASH is the the ash content of manure calculated as a fraction of the dry matter feed intake (e.g., 0.08 for cattle). Use country-specific values where available.
*values taken from Table 10A-9

*use a new parameter for this
*unit: share (i.e. percentage/100) of DM feed intake

*assign this directly to SOLm-entities:
Manure_OtherChar(Countries,Livestock,"AllAndAverageTypes","Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.08;
Manure_OtherChar(Countries,"Cattle",CattleTypeInHerd,"Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.08;
Manure_OtherChar(Countries,"Pigs",PigTypeInHerd,"Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.08;
Manure_OtherChar(Countries,"Horses","AllAndAverageTypes","Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.04;
Manure_OtherChar(Countries,"Mules","AllAndAverageTypes","Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.04;
Manure_OtherChar(Countries,"Asses","AllAndAverageTypes","Ash content in feed DM (share)","AllProdSyst","AllProdCond") = 0.04;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) P excretion

*Data from Sheldrick, W., Syers, J.K., Lingard, J., 2003, Contribution of livestock excreta to nutrient balances, Nutrient Cycling in Agroecosystems 666: 119-131
$ontext;
Table 2. Livestock excretion rates used in the model.
Livestock        Slaughtered weight (kg)         kg nutrient year
                                              N   P     K
Cattle                 270                   50  10     45
Pigs                    80                   12   4      4.5
Sheep                   19                   10   2      5
Goats                   12                   10   2      5
Horses                 220                   45   8     27
Poultry                1.5                  0.6  0.19  0.31
slaughtered weight is warm liveweight without certain parts, cf. e.g. https://de.wikipedia.org/wiki/Schlachtgewicht
Thus: below, use a factor between slaughter weight and liveweight to scale these numbers:
cattle: 55%
Pig: 80%
chicken 70%
Sheep 50%
other poultry 75%
horses 60%
values are in P, thus P2O5 is this times the factor P->P2O5, i.e. *2.29157 (2*30.97+5*16)/(2*30.97)

*also compare on how Lassaletta et al. used this in their paper:
*we adjusted the data according to their table S1-4
*50 year trends in nitrogen use efficiency of world cropping systems: the relationship between yield and nitrogen input to cropland
*L Lassaletta, G Billen, B Grizzetti… - Environmental Research Letter, 2014 - iopscience.iop.org:
Take Dairy cattle from them, table S2-4, and just assume same relation for P:
Dairy cattle          5100                 100  20     90

$offtext;

Parameter Pex_Sheldrick(FAOSTAT_CountriesAndRegions,AnimalTypeInHerd) average P excretion of animals;
*unit:  t P2O5/head/year

*unit: t P2O5/head/year (P is in kg, thus division by 1000. It is for a specific liveweight, derived from slaugther weight and the factor between that and liveweight.
*for a liveweight of 270kg/0.55
Pex_Sheldrick(FAOSTAT_Countries,"Other Cattle IPCC2006") = 10 *2.29157 /1000;
*for a liveweight of 80kg/0.8
Pex_Sheldrick(FAOSTAT_Countries,"Pig IPCC2006")   = 4 *2.29157 /1000;
*for a liveweight of 1.5kg/0.73
Pex_Sheldrick(FAOSTAT_Countries,"Average Chicken IPCC2006") = 0.19 *2.29157 /1000;
*for a liveweight of 19kg/0.5
Pex_Sheldrick(FAOSTAT_Countries,"Sheep IPCC2006")  = 2 *2.29157 /1000;
*for a liveweight of 12kg/0.5
Pex_Sheldrick(FAOSTAT_Countries,"Goat IPCC2006")  = 2 *2.29157 /1000;
*for a liveweight of 220kg/0.6
*the horse value seems quite low if compared to Höfdünger_AgrarforschungSchweiz.pdf - thus correct upwards by 50%
Pex_Sheldrick(FAOSTAT_Countries,"Horse IPCC2006") = 8 *2.29157 /1000*1.5;
*dairy cattle:
*for a yield of 5100kg
Pex_Sheldrick(FAOSTAT_Countries,"Dairy Cow IPCC2006") = 20 *2.29157 /1000;

*use it per 1000kg liveweight as well:
Parameter Pex_Sheldrick_per1000kgLW(FAOSTAT_CountriesAndRegions,AnimalTypeInHerd) average P excretion of animals per 1000kg LW;
*unit:  t P2O5/10000kg/year

*for a liveweight of 270kg/0.55
Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Other Cattle IPCC2006") = 10 *2.29157 /1000 *(1000/(270/0.55));
*for a liveweight of 80kg/0.8
Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Pig IPCC2006")   = 4 *2.29157 /1000*(1000/(80/0.8));
*for a liveweight of 1.5kg/0.73
Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Average Chicken IPCC2006") = 0.19 *2.29157 /1000*(1000/(1.5/0.73));
*for a liveweight of 19kg/0.5
Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Sheep IPCC2006")  = 2 *2.29157 /1000*(1000/(19/0.5));
*for a liveweight of 12kg/0.5
Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Goat IPCC2006")  = 2 *2.29157 /1000*(1000/(12/0.5));
*for a liveweight of 220kg/0.6
*the horse value seems quite low if compared to Höfdünger_AgrarforschungSchweiz.pdf - thus correct upwards by 50%
Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Horse IPCC2006") = 8 *2.29157 /1000*(1000/(220/0.6))*1.5;
*dairy cattle:
*for a yield of 5100kg - assume an average weight of 450kg for this
Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Dairy Cow IPCC2006") = 20 *2.29157 /1000*(1000/450);



$ontext;
after this, we have:
Parameter Nex_IPCC2006(FAOSTAT_CountriesAndRegions,AnimalTypeInHerd) average N excretion of animals;
Parameter Manure_OtherChar(Countries,Livestock,AnimalTypeInHerd,"Ash content in feed DM (share)","AllProdSyst","AllProdCond")
Parameter Pex_Sheldrick(FAOSTAT_CountriesAndRegions,AnimalTypeInHerd) average P excretion of animals;
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) Assign values to core model parameters and variables
*4.1) Link some sets as needed

*We have Nex-data for the following AnimalTypeInHerd elements
$ontext;
Dairy Cow IPCC2006
Average Other Cattle IPCC2006
Average Pig IPCC2006
Average Market Swine IPCC2006
Average Breeding Swine IPCC2006

Hens >= 1y old IPCC2006
Pullet - Chicken < 1y old IPCC2006
Other Chicken >= 1y old IPCC2006
Chickens Broilers IPCC2006

Average Chicken IPCC2006
Average Turkey IPCC2006
Average Duck IPCC2006
Average Sheep IPCC2006
Average Goat IPCC2006
Average Horse IPCC2006
Average Mule IPCC2006
Average Ass IPCC2006
Average Camel IPCC2006
Average Buffaloes IPCC2006
Mink and Polecat IPCC2006
Rabbits IPCC2006
Fox and Racoon IPCC2006
$offtext;


SET Match_Animals_TypeInHerdNoHerdStructure_ForNex(Livestock,AnimalTypeInHerd)
/
Chickens."Average Chicken IPCC2006"
Turkeys."Turkey IPCC2006"
Ducks."Duck IPCC2006"
Sheep."Sheep IPCC2006"
Goats."Goat IPCC2006"
Horses."Horse IPCC2006"
Mules."Mule IPCC2006"
Asses."Ass IPCC2006"
Camels."Camel IPCC2006"
Buffaloes."Buffaloes IPCC2006"
*"Mink and Polecat IPCC2006"
"Rabbits and hares"."Rabbits IPCC2006"
*"Fox and Racoon IPCC2006"
/;

Set PigTypeBreedingForNex(AnimalTypeInHerd)
/
Sows
Boars
"Rep_Sows"
"Rep_Boars"
/;
Set PigTypeMarketForNex(AnimalTypeInHerd)
/
Sucklers
Weaners
Fatteners
/;

Set ChickenTypeForNex(AnimalTypeInHerd)
/
"Hens >= 1y old IPCC2006"
"Pullet - Chicken < 1y old IPCC2006"
"Other Chicken >= 1y old IPCC2006"
"Chickens Broilers IPCC2006"
/;


*4.2) Link to the core model parameters


*factors of *365/1000 because the unit of Nex_IPCC2006 is kg N / 1000kg liveweight / day and we want t N / 1000kg liveweight / year
ActAnimalsHead_OtherChar(Regions,Livestock,"AllAndAverageTypes","N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,AnimalTypeInHerd)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND Match_Animals_TypeInHerdNoHerdStructure_ForNex(Livestock,AnimalTypeInHerd)),
                 Nex_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd))*365/1000;

ActAnimalsHead_OtherChar(Regions,"Cattle",CattleTypeInHerd,"N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Nex_IPCC2006(FAOSTAT_Countries,"Other Cattle IPCC2006"))*365/1000;
ActAnimalsHead_OtherChar(Regions,"Cattle","Producing_Dairy_Cattle","N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Nex_IPCC2006(FAOSTAT_Countries,"Dairy Cow IPCC2006"))*365/1000;

ActAnimalsHead_OtherChar(Regions,"Pigs","AllAndAverageTypes","N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Nex_IPCC2006(FAOSTAT_Countries,"Pig IPCC2006"))*365/1000;
ActAnimalsHead_OtherChar(Regions,"Pigs",PigTypeBreedingForNex,"N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Nex_IPCC2006(FAOSTAT_Countries,"Breeding Swine IPCC2006"))*365/1000;
ActAnimalsHead_OtherChar(Regions,"Pigs",PigTypeMarketForNex,"N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Nex_IPCC2006(FAOSTAT_Countries,"Market Swine IPCC2006"))*365/1000;

ActAnimalsHead_OtherChar(Regions,"Chickens",ChickenTypeForNex,"N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Nex_IPCC2006(FAOSTAT_Countries,ChickenTypeForNex))*365/1000;

*Assign missing animal types:
ActAnimalsHead_OtherChar(Regions,"Camelids, other","AllAndAverageTypes","N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Camels","AllAndAverageTypes","N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Geese and guinea fowls","AllAndAverageTypes","N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Turkeys","AllAndAverageTypes","N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Game","AllAndAverageTypes","N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Horses","AllAndAverageTypes","N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond");


ActAnimalsHead_OtherChar(Regions,"Cattle",CattleTypeInHerd,"P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Other Cattle IPCC2006"));
ActAnimalsHead_OtherChar(Regions,"Cattle","Producing_Dairy_Cattle","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Dairy Cow IPCC2006"));
ActAnimalsHead_OtherChar(Regions,"Pigs",PigTypeInherd,"P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Pig IPCC2006"));

ActAnimalsHead_OtherChar(Regions,"Chickens","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Average Chicken IPCC2006"));
ActAnimalsHead_OtherChar(Regions,"Sheep","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Sheep IPCC2006"));
ActAnimalsHead_OtherChar(Regions,"Goats","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Goat IPCC2006"));
ActAnimalsHead_OtherChar(Regions,"Horses","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Pex_Sheldrick_per1000kgLW(FAOSTAT_Countries,"Horse IPCC2006"));

*add other animals:
ActAnimalsHead_OtherChar(Regions,"Asses","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Horses","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Mules","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Horses","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Buffaloes","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Cattle","BMaleCalves2","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Camels","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Cattle","BMaleCalves2","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Camelids, other","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Cattle","BMaleCalves2","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond");

ActAnimalsHead_OtherChar(Regions,"Ducks","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Chickens","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Geese and guinea fowls","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Chickens","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Pigeons, other birds","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Chickens","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Rabbits and hares","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Chickens","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Rodents, other","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Chickens","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond");
ActAnimalsHead_OtherChar(Regions,"Turkeys","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Chickens","AllAndAverageTypes","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond");

*some values are too high, e.g. for cattle, this seems to be the case (compare e.g. values for Switzerland with the data provided by WUR: https://ec.europa.eu/eurostat/documents/2393397/8259002/LiveDate_2014_Task6.pdf/207ebcf9-5971-4b7d-bfbc-d48458e49009)
*thus correct by a factor 2/3 (from above: dairy cattle excretion 61kg P2O5/head/y - but the data in the reference just above are at about 18*2.2915=41 kg P2O5/head/y)
*and for cattle <1 y, we currently have 4.8 kg P the eference above has 3.4 kg P, thus also again a factor of about 2/3 (somewhat higher)
*similarly for the larger cattle (we have 8.3, the reference has 7.8 or somewhat less - so use there a larger factor, say 0.9:
ActAnimalsHead_OtherChar(Regions,"Cattle",CattleTypeInHerd,"P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Cattle",CattleTypeInHerd,"P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")*0.67;
ActAnimalsHead_OtherChar(Regions,"Cattle","Dsires","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Cattle","Dsires","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")*0.9;
ActAnimalsHead_OtherChar(Regions,"Cattle","Bsires","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Cattle","Bsires","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")*0.9;
ActAnimalsHead_OtherChar(Regions,"Cattle","Bcows","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Cattle","Bcows","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")*0.9;
ActAnimalsHead_OtherChar(Regions,"Cattle","DFemaleCalves3","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
         = ActAnimalsHead_OtherChar(Regions,"Cattle","DFemaleCalves3","P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")*0.9;




$ontext;
After this we have the following in SOLm-entities:

where
Regions        is      FAOSTAT_Countries
Activities     is      Livestock

ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"N in manure per ton liveweight (tN/t lw/y)","AllProdSyst","AllProdCond")
ActAnimalsHead_OtherChar(Regions,Livestock,AnimalTypeInHerd,"P in manure per ton liveweight (tP2O5/t lw/y)","AllProdSyst","AllProdCond")
Manure_OtherChar(Countries,Livestock,AnimalTypeInHerd,"Ash content in feed DM (share)","AllProdSyst","AllProdCond")

*XXX STILL TO BE DONE:
*the latter one (ash): code it also as a feed ration parameter (as it has been in SOLmV5)?
$offtext;



