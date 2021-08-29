PUTCLOSE con,"_V6_ReadData_VariousSources_ManureManagementData";

$ontext;
GENERAL DESCRIPTION
This file reads and/or assigns the values for various parameters needed for manure management calculations (i.e. to derive emissions, nutrients available, etc.)


DETAILED TABLE OF CONTENTS
- 1) Manure management parameters from IPCC 2006
         1.1) MS from IPCC 2006 and other sources (shares of manure management systems)
         1.2) Assign average temperatures to countries
- 2) Parameters for CH4 emissions - IPCC 2006
         2.1) Methane Conversion Factor MCF from IPCC 2006
         2.2) Bo from IPCC 2006
- 3) Parameters for N2O emissions - IPCC 2006
         3.1) Direct N2O emissions
         3.2) Indirect N2O emissions
- 4) P emissions/losses from manure management
- 5) Additional assignments as identified above
- 6) Assign values to core model parameters and variables
         6.1) Link some sets as needed
         6.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Manure management parameters from IPCC 2006

*manure management is important due to its relevance for GHG emissions and nutrient losses;
*emissions are taken into account according to IPCC 2006:

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewVariousSourcesManureManagementData% == "YES"
$call GDXXRW IPCC2006_ManureManagementData_1_1_2018.xlsx  o=IPCC2006_ManureManagementData_1_1_2018.gdx  index=index!a1:e6
*contains various parameters for manure management calculations as described in IPCC 2006
$endif;



*the following specific subset is needed to file in some data
Set SubsetManManSyst_ForManManData(ManureManSystem)
/
"Uncovered anaerobic Lagoon"
"Liquid/Slurry with natural crust cover"
"Liquid/Slurry without natural crust cover"
"Solid Storage"
"Drylot"
"Pasture/Range/Paddock"
"Daily Spread"
"Anaerobic digester"
"Burned for Fuel"
"Pit below animal confinenemts < 1 month"
"Pit below animal confinenemts > 1 month"
"Poultry manure with litter"
"Other"
/;


*unit:  percentage
*Share of manure management systems
Parameter MS_IPCC2006(FAOSTAT_CountriesAndRegions,AnimalTypeInHerd,ManureManSystem);

*the following two are needed for CH4 emissions further down - but define and read them already here
*unit:  percentage
*Methane conversion factor: percentage of Bo (see below) that is achieved in the specific ManMan system in question (i.e. how much of the maximal Methane emission capacity is reached in a specific situation).
Parameter MCF_IPCC2006(ManureManSystem,Temperatures) methane conversion factor MCF;

*unit:  m3 CH4/kg VS
*Bo(T) = maximum methane producing capacity for manure produced by livestock category T, m3 CH4 kg-1 of VS excreted
Parameter Bo_IPCC2006(FAOSTAT_CountriesAndRegions,AnimalTypeInHerd);

*unit: percentage
*FracGasMS = percent of managed manure nitrogen for livestock category T that volatilises as NH3 and NOx
*FracGasMS is coded as Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalTypeInHerd,ManureManSystem)
Parameter Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalTypeInHerd,ManureManSystem);

*unit: percentage
*FracLeachMS = percent of managed manure nitrogen for livestock category T that leaches and runoffs as N
*FracLeachMS is coded as Leaching_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalTypeInHerd,ManureManSystem)
Parameter Leaching_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalTypeInHerd,ManureManSystem);


$gdxin IPCC2006_ManureManagementData_1_1_2018.gdx
$load MS_IPCC2006
$load MCF_IPCC2006
$load Bo_IPCC2006
$load Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006
$load Leaching_of_N_FromManMan_PercentageFromN_IPCC2006
$gdxin

*looking at this data, we see that the various parameters come with different ManManSystems:
$ontext;
MS                                               MCF                                             N Leach                         N Volat

Uncovered anaerobic Lagoon                       Uncovered anaerobic Lagoon                      Uncovered anaerobic Lagoon      Uncovered anaerobic Lagoon
Liquid/Slurry with natural crust cover           Liquid/Slurry with natural crust cover                                          Liquid/Slurry with natural crust cover
Liquid/Slurry without natural crust cover        Liquid/Slurry without natural crust cover                                       Liquid/Slurry without natural crust cover
Solid Storage                                    Solid Storage                                   Solid Storage                   Solid Storage
Drylot                                           Drylot                                          Drylot                          Drylot
Pasture/Range/Paddock                            Pasture/Range/Paddock
Daily Spread                                     Daily Spread                                    Daily Spread                    Daily Spread
Anaerobic digester                               Anaerobic digester
Burned for Fuel                                  Burned for Fuel
Pit below animal confinenemts < 1 month          Deep bedding < 1 month                          Deep bedding < 1 month          Deep bedding < 1 month
Pit below animal confinenemts > 1 month          Deep bedding > 1 month                          Deep bedding > 1 month          Deep bedding > 1 month
Poultry manure with litter                       Pit below animal confinenemts < 1 month                                         Pit below animal confinenemts < 1 month
Other                                            Pit below animal confinenemts > 1 month                                         Pit below animal confinenemts > 1 month
                                                 Manure composting - in vessel
                                                 Manure composting - static pile
                                                 Manure composting - intensive windrow
                                                 Manure composting - passive windrow
                                                 Poultry manure with litter                      Poultry manure with litter      Poultry manure with litter
                                                 Poultry manure without litter                                                   Poultry manure without litter
                                                 Other

*and for the animal herd types covered it looks as follows:
MS                            Bo                         Leach N                   Volat N

Dairy Cow IPCC2006         Dairy Cow IPCC2006         Dairy Cow IPCC2006        Dairy Cow IPCC2006
Other Cattle IPCC2006      Other Cattle IPCC2006      Other Cattle IPCC2006     Other Cattle IPCC2006
Buffaloes IPCC2006         Buffaloes IPCC2006
Pig IPCC2006               Pig IPCC2006               Pig IPCC2006              Pig IPCC2006
Sheep IPCC2006             Sheep IPCC2006             Sheep IPCC2006            Sheep IPCC2006
Goat IPCC2006              Goat IPCC2006              Goat IPCC2006             Goat IPCC2006
Camel IPCC2006             Camel IPCC2006             Camel IPCC2006            Camel IPCC2006
Horse IPCC2006             Horse IPCC2006             Horse IPCC2006            Horse IPCC2006
Mule IPCC2006              Mule IPCC2006              Mule IPCC2006             Mule IPCC2006
Ass IPCC2006               Ass IPCC2006               Ass IPCC2006"             Ass IPCC2006"
Chicken Layers  IPCC2006   Chicken Layers  IPCC2006
Chickens Broilers IPCC2006 Chickens Broilers IPCC2006
Turkey IPCC2006            Turkey IPCC2006            Turkey IPCC2006           Turkey IPCC2006
Duck IPCC2006              Duck IPCC2006              Duck IPCC2006             Duck IPCC2006
Rabbits IPCC2006           Rabbits IPCC2006
                                                      Average Chicken IPCC2006  Average Chicken IPCC2006

Thus, in the end, additional assignments needed as follows - done towards the end of this file:
Leach/Volat N for "Buffaloes IPCC2006", "Rabbits IPCC2006"

BO: chicken Layers/Broilers is identical: thus assign to  "Average Chicken IPCC2006"
MS: chicken Broilers 100% of one or the other system assumed for developing/develope dcountries only - thus just assume chicken Layer values for "Average Chicken IPCC2006" and retain the latter only

and, most important, we need values for all parameters for the ManMan systems where quantity shares are reported, thus assign the missing ones as follows:
MCF: ok, all values needed available
Volat:   Pasture/Range/Paddock EQUALS Daily spread
         Anaerobic digester and burned for fuel: assume 0
Leach:   Pasture/Range/Paddock EQUALS Daily spread
         Anaerobic digester and burned for fuel: assume 0
         Liquid/Slurry with natural crust cover  EQUALS  Uncovered anaerobic Lagoon
         Liquid/Slurry without natural crust cover  EQUALS  Uncovered anaerobic Lagoon
         Pit below animal confinenemts < 1 month  EQUALS  Uncovered anaerobic Lagoon*0.7
         Pit below animal confinenemts > 1 month  EQUALS  Uncovered anaerobic Lagoon*0.7


$offtext;
*from this, we see that we have all data needed for the ManManSystems with MS available - we thus use those only for the further SOLm calculations further down



*1.1) MS from IPCC 2006 and other sources (shares of manure management systems)

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
Indian Subcontinent      Indian Subcontinent
$offtext;

*assign the missing sub-continents:
MS_IPCC2006("Northern Europe",AnimalTypeInHerd,ManureManSystem)
         = MS_IPCC2006("Western Europe",AnimalTypeInHerd,ManureManSystem);
MS_IPCC2006("Southern Europe",AnimalTypeInHerd,ManureManSystem)
         = MS_IPCC2006("Eastern Europe",AnimalTypeInHerd,ManureManSystem);

MS_IPCC2006("Central America",AnimalTypeInHerd,ManureManSystem)
         = MS_IPCC2006("South America",AnimalTypeInHerd,ManureManSystem);
MS_IPCC2006("Caribbean",AnimalTypeInHerd,ManureManSystem)
         = MS_IPCC2006("South America",AnimalTypeInHerd,ManureManSystem);

*MS values for chicken from FAO GLEAM
*now assign values for chicken, taken from FAO GLEAM, which are missing in IPCC 2006

*for chicken, data is missing with IPCC 2006, thus we take it from the Gerber report on life-cycle emissions from pigs and chickens
*        (Greenhouse Gas Emissions from Pig and Chicken Supply Chains – A Global Life Cycle Assessment, http://www.fao.org/docrep/018/i3460e/i3460e.pdf), table B21
*unit: percentage
*we added this to the excel sheet above
*regions originally reported in the table B21 are as follows (left)
*        and regions assigned in SOLm are listed beneath (right) - already changed in excel for filing in - and assigned to all subregions and countries below
$ontext;
LAC                     "South America", "Carribean", "Central America"
E&SE Asia               "Eastern Asia", "South-Eastern Asia"
Eastern Europe          "Eastern Europe", "Southern Europe"
Northern America        "Northern America"
Oceania                 "Oceania"
Russian Federation      "Russian Federation"
Southern Asia           "Southern Asia", "Central Asia"
SSA                     "Eastern Africa", "Middle Africa", "Southern Africa", "Western Africa"
Northern Africa         "Northern Africa", "Western Asia" (taken for Middle East / Near East)
Western Europe          "Western Europe", "Northern Europe"
$offtext;

*assign the missing sub-continents:
MS_IPCC2006("Eastern Asia",AnimalTypeInHerd,ManureManSystem)
         = MS_IPCC2006("South-Eastern Asia",AnimalTypeInHerd,ManureManSystem);
MS_IPCC2006("Central Asia",AnimalTypeInHerd,ManureManSystem)
         = MS_IPCC2006("Southern Asia",AnimalTypeInHerd,ManureManSystem);
MS_IPCC2006("Middle Africa",AnimalTypeInHerd,ManureManSystem)
         = MS_IPCC2006("Eastern Africa",AnimalTypeInHerd,ManureManSystem);
MS_IPCC2006("Southern Africa",AnimalTypeInHerd,ManureManSystem)
         = MS_IPCC2006("Eastern Africa",AnimalTypeInHerd,ManureManSystem);
MS_IPCC2006("Western Africa",AnimalTypeInHerd,ManureManSystem)
         = MS_IPCC2006("Eastern Africa",AnimalTypeInHerd,ManureManSystem);
MS_IPCC2006("Western Asia",AnimalTypeInHerd,ManureManSystem)
         = MS_IPCC2006("Northern Africa",AnimalTypeInHerd,ManureManSystem);


*now assign the regional average values to the countries within those regions, where no data is available on country level

*first, on the level of the special grouping "Indian Subcontinent"
MS_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd,ManureManSystem)
                 $FAOSTAT_CountriesInRegions("Indian Subcontinent",FAOSTAT_Countries)
         = MS_IPCC2006("Indian Subcontinent",AnimalTypeInHerd,ManureManSystem);

*Second, on the level of sub-continents
MS_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd,ManureManSystem)
                 $(NOT MS_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd,ManureManSystem))
         = sum(FAOSTAT_Subcontinents$FAOSTAT_CountriesInRegions(FAOSTAT_Subcontinents,FAOSTAT_Countries),MS_IPCC2006(FAOSTAT_Subcontinents,AnimalTypeInHerd,ManureManSystem));

*third, if no sub-continent averages are available, on the level of continents:
*conditional to whether there are now values on country levels (original, or from the sub-continents) - thus, only the truly missing are assigned
MS_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd,ManureManSystem)
                 $(NOT MS_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd,ManureManSystem))
         = sum(FAOSTAT_Continents$FAOSTAT_CountriesInRegions(FAOSTAT_Continents,FAOSTAT_Countries),MS_IPCC2006(FAOSTAT_Continents,AnimalTypeInHerd,ManureManSystem));

*fourth, on the level of non-geographic subsets, i.e. developing/developed countries, where also some values are given:
MS_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd,ManureManSystem)
                 $(NOT MS_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd,ManureManSystem))
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),MS_IPCC2006(FAOSTAT_DevelopedDevelopingGroups,AnimalTypeInHerd,ManureManSystem));

*fifth, on global level, if averages for continents are missing:
*conditional to whether there are now values on country levels (original, or from the sub-continents or continents) - thus, only the truly missing are assigned
MS_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd,ManureManSystem)
                 $(NOT MS_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd,ManureManSystem))
         = MS_IPCC2006("World",AnimalTypeInHerd,ManureManSystem);

*after this, MS values as given in IPCC 2006 are available for all countries in FAOSTAT_Countries


*1.2) Assign average temperatures to countries

*for identifying average temperatures also needed for ManMan emissions, we use
*GAEZ data: http://gaez.fao.org/Main.html#, Agro-climatic resources, mean annual temperatures, then access the regional / country averages
*thus assign average temperatures to countries with the following set:

Set AverageTemperaturePerCountry(FAOSTAT_CountriesAndRegions,Temperatures)
/
"Eastern Africa".23
"Middle Africa".24
"Northern Africa".22
"Southern Africa".20
*Western Africa was not reported, we took the same as Northern/Eastern, i.e. 22 or 23 deg - we chose 23 deg.
"Western Africa".23

*Northern America is reported with -0.3 deg; we just took the lowest possible from IPCC which is 10
"Northern America".10
"Central America".21
"Caribbean".25
"South America".22

*Central Asia, Eastern Asia is reported with 8 and 6 deg; we just took the lowest possible from IPCC which is 10
"Central Asia".10
"Eastern Asia".10
"Southern Asia".23
"South-Eastern Asia".25
"Western Asia".20

*Eastern Europe is reported with -3.7, Northern with 3 deg; we just took the lowest possible from IPCC which is 10
"Eastern Europe".10
"Northern Europe".10
"Southern Europe".12
"Western Europe".10

"Australia & New Zealand".21
"Melanesia".24
"Micronesia".24
"Polynesia".24

"World".15
/;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Parameters for CH4 emissions - IPCC 2006

*Manure management CH4 emissions:
*IPCC 2006, Tier 2 approach:
*Volume 4, chapter 10, equations 10.23 ff

*EF(T) = (VS(T) * 365) * (Bo(T) * 0.67 kg/m3 * Sum(S,k)MCF(S,k)/100*MS(T,S,k) )

*where
*EF(T) = annual CH4 emission factor for livestock category T, kg CH4 animal-1 yr-1
*VS(T) = daily volatile solid excreted for livestock category T, kg dry matter animal-1 day-1
*365 = basis for calculating annual VS production, days yr-1
*Bo(T) = maximum methane producing capacity for manure produced by livestock category T, m3 CH4 kg-1 of VS excreted
*0.67 = conversion factor of m3 CH4 to kilograms CH4
*MCF(S,k) = methane conversion factors for each manure management system S by climate region k, %
*MS(T,S,k) = fraction of livestock category T's manure handled using manure management system S in climate region k, dimensionless

*thereby, VS - Volatile solide excretion rates - are determined as follows:

*VS = [GE*(1 - DE%/100) + UE*GE] * [(1 - ASH)/GE_per_DM ]

*Where:
*VS = volatile solid excretion per day on a dry-organic matter basis, kg VS day-1
*GE = gross energy intake, MJ day-1
*DE% = digestibility of the feed in percent (e.g. 60%)
*(UE*GE) = urinary energy expressed as fraction of GE. Typically 0.04GE can be considered urinary
*        energy excretion by most ruminants (reduce to 0.02 for ruminants fed with 85% or more grain in the
*        diet or for swine). Use country-specific values where available.
*ASH = the ash content of manure calculated as a fraction of the dry matter feed intake (e.g., 0.08 for
*        cattle). Use country-specific values where available.
*GE_per_DM = conversion factor for dietary GE per kg of dry matter (MJ kg-1). This value is relatively constant
*        across a wide range of forage and grain-based feeds commonly consumed by livestock.
*        Default: 18.45


*2.1) Methane Conversion Factor MCF from IPCC 2006

*these are the same factors for all countries - the temperature is key. -
*assign temperatures below 10 to the value for 10 and above 28 to the value for 28

MCF_IPCC2006(ManureManSystem,TemperaturesBelow10)
         = MCF_IPCC2006(ManureManSystem,"10");
MCF_IPCC2006(ManureManSystem,TemperaturesAbove28)
         = MCF_IPCC2006(ManureManSystem,"28");

*and then assign to countries based on average country temperatures.
Parameter MCF_IPCC2006_Countries(FAOSTAT_CountriesAndRegions,ManureManSystem);

*first: assign to sub-continents, i.e. the level where temperatures are given:
MCF_IPCC2006_Countries(FAOSTAT_CountriesAndRegions,ManureManSystem)
         = sum(Temperatures$AverageTemperaturePerCountry(FAOSTAT_CountriesAndRegions,Temperatures),
                 MCF_IPCC2006(ManureManSystem,Temperatures));
*this assigns values on subcontinent plus World level
*then assign to countries:
*ATTENTION: here, sum over subcontinents - otherwise, the world value is added everywhere as well, as each country is assigned to a subcontinent and to "world" as well!!!
MCF_IPCC2006_Countries(FAOSTAT_Countries,ManureManSystem)
         = sum(FAOSTAT_Subcontinents$FAOSTAT_CountriesInRegions(FAOSTAT_Subcontinents,FAOSTAT_Countries),
                 MCF_IPCC2006_Countries(FAOSTAT_Subcontinents,ManureManSystem));


*2.2) Bo from IPCC 2006

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
Indian Subcontinent      Indian Subcontinent
$offtext;

*assign the missing sub-continents:
Bo_IPCC2006("Northern Europe",AnimalTypeInHerd)
         = Bo_IPCC2006("Western Europe",AnimalTypeInHerd);
Bo_IPCC2006("Southern Europe",AnimalTypeInHerd)
         = Bo_IPCC2006("Eastern Europe",AnimalTypeInHerd);

Bo_IPCC2006("Central America",AnimalTypeInHerd)
         = Bo_IPCC2006("South America",AnimalTypeInHerd);
Bo_IPCC2006("Caribbean",AnimalTypeInHerd)
         = Bo_IPCC2006("South America",AnimalTypeInHerd);

*now assign the regional average values to the countries within those regions, where no data is available on country level

*first, on the level of the special grouping "Indian Subcontinent"
Bo_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd)
                 $FAOSTAT_CountriesInRegions("Indian Subcontinent",FAOSTAT_Countries)
         = Bo_IPCC2006("Indian Subcontinent",AnimalTypeInHerd);

*Second, on the level of sub-continents
Bo_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd)
                 $(NOT Bo_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd))
         = sum(FAOSTAT_Subcontinents$FAOSTAT_CountriesInRegions(FAOSTAT_Subcontinents,FAOSTAT_Countries),Bo_IPCC2006(FAOSTAT_Subcontinents,AnimalTypeInHerd));

*third, if no sub-continent averages are available, on the level of continents:
*conditional to whether there are now values on country levels (original, or from the sub-continents) - thus, only the truly missing are assigned
Bo_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd)
                 $(NOT Bo_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd))
         = sum(FAOSTAT_Continents$FAOSTAT_CountriesInRegions(FAOSTAT_Continents,FAOSTAT_Countries),Bo_IPCC2006(FAOSTAT_Continents,AnimalTypeInHerd));


*fourth, on the level of non-geographic subsets, i.e. developing/developed countries, where also some values are given:
Bo_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd)
                 $(NOT Bo_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd))
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),Bo_IPCC2006(FAOSTAT_DevelopedDevelopingGroups,AnimalTypeInHerd));

*after this, Bo values are available for all countries in FAOSTAT_Countries




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Parameters for N2O emissions - IPCC 2006
*direct and indirect N2O emissions from manure management:

*3.1) Direct N2O emissions

*IPCC 2006, colume 10, chapter 4, equation 10.25:
$ontext;
N2O_direct_perHead = Nex(T) * MS(T,S) * EF3(S) * 44/28
Where:
N2O_direct_perHead = direct N2O emissions from Manure Management in the country, per head of animal, kg N2O yr-1
Nex(T) = annual average N excretion per head of species/category T in the country, kg N animal-1 yr-1
MS(T,S) = fraction of total annual nitrogen excretion for each livestock species/category T that is managed
in manure management system S in the country, dimensionless
EF3(S) = emission factor for direct N2O emissions from manure management system S in the country, kg
N2O-N/kg N in manure management system S
S = manure management system
T = species/category of livestock
44/28 = conversion of (N2O-N)(mm) emissions to N2O(mm) emissions
$offtext;
*Thus:

*EF3 is coded as N2ONdirectManMan_perN_IPCC2006(FAOSTAT_CountriesAndRegions,ManureManSystem);
Parameter N2ONdirectManMan_perN_IPCC2006(FAOSTAT_CountriesAndRegions,ManureManSystem);
*values from TABLE 10.21

*unit:
*t N / t N (i.e. share N from N in manure that is emitted as N2O)
*pasture/range/paddock is set 0 as the related emissions are covered under manure application to soils, resp. N2O emissions from soils
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Pasture/Range/Paddock") = 0;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Daily Spread") = 0;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Solid Storage") = 0.005;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Drylot") = 0.02;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Liquid/Slurry with natural crust cover") = 0.005;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Liquid/Slurry without natural crust cover") = 0;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Uncovered anaerobic Lagoon") = 0;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Pit below animal confinenemts < 1 month") = 0.002;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Pit below animal confinenemts > 1 month") = 0.002;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Anaerobic digester") = 0;
*ATTENTION!! Burned for Fuel: assumed something: to be improved with "The emissions associated with the burning of the dung are to be reported
*        under the IPCC category 'Fuel Combustion' if the dung is used as fuel and
*        under the IPCC category 'Waste Incineration' if the dung is burned without Burned for fuel energy recovery."
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Burned for Fuel") = 0.002;
*deep bedding is often cattle/swine deep bedding - but sometimes also for other animals, thus we drop cattle/swine
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Deep bedding - no mixing") = 0.01;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Deep bedding - active mixing") = 0.07;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Manure composting - in vessel") = 0.006;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Manure composting - static pile") = 0.006;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Manure composting - intensive windrow") = 0.1;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Manure composting - passive windrow") = 0.01;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Poultry manure with litter") = 0.001;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Poultry manure without litter") = 0.001;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Aerobic treatment - natural aeration") = 0.01;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Aerobic treatment - forced aeration") = 0.005;

*for ManManSyst quantity shares, we need the following only (set defined below) - and we have all of them above, besides "other", which I add below, setting it to some lower average type of value: 0.004, though:
$ontext;
Set SubsetManManSyst_ForManManData(ManureManSystem)
/
"Uncovered anaerobic Lagoon"
"Liquid/Slurry with natural crust cover"
"Liquid/Slurry without natural crust cover"
"Solid Storage"
"Drylot"
"Pasture/Range/Paddock"
"Daily Spread"
"Anaerobic digester"
"Burned for Fuel"
"Pit below animal confinenemts < 1 month"
"Pit below animal confinenemts > 1 month"
"Poultry manure with litter"
"Other"
/;
$offtext;
N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,"Other") = 0.004;

*3.2) Indirect N2O emissions
*parameters for indirect N2O emissions:
$ontext;
this is volatilisation and Leaching/runoff
*Four parameters are needed for indirect N2O emissions from ManMan, after that: related calculations: FracGasMS, EF4, FracLeachMS, EF5
*details follow, first A) volatilisation, then B) runoff

A) indirect emissions from volatilisation:
eq. 10.26 and 10.27
N2O_indirect_perHead_Volat = Nex(T) * MS(T,S) * (FracGasMS/100) * EF4(S) * 44/28
with
FracGasMS = percent of managed manure nitrogen for livestock category T that volatilises as NH3 and NOx
in the manure management system S, %
EF4 = emission factor for N2O emissions from atmospheric deposition of nitrogen on soils and water surfaces,
         kg N2O-N (kg NH3-N + NOx-N volatilised)-1 ; default value is 0.01 kg N2O-N (kg NH3-N + NOx-N volatilised)-1 , given in Chapter 11, Table 11.3
$offtext;

*FracGasMS is coded as Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalCategoriesInHerd_IPCC2006,ManureManSystem)
*Parameter Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalCategoriesInHerd_IPCC2006,ManureManSystem);
*this is already loaded above
*unit: percentage
*VALUES are from table 22, IPCC 2006, vol4, chapter 10.
*ATTENTION: NO SEPARATE ACCOUNTING FOR NOx and NH3!!!!!! - TO BE IMPROVED LATER!!


*EF4 is coded as N2OindirectManMan_perN_Volat_IPCC2006(ManureManSystem)
Parameter N2ONindirectManMan_perN_Volat_IPCC2006(ManureManSystem);
*default value is 0.01 kg N2O-N (kg NH3-N + NOx-N volatilised)-1 , given in Chapter 11, Table 11.3
*unit: share (i.e. percentage/100)

*for ManManSyst quantity shares, we need the following only:
$ontext;
this is already defined in _V6_Sets_GeneralModelSets_ForReadingData
Set SubsetManManSyst_ForManManData(ManureManSystem)
/
"Uncovered anaerobic Lagoon"
"Liquid/Slurry with natural crust cover"
"Liquid/Slurry without natural crust cover"
"Solid Storage"
"Drylot"
"Pasture/Range/Paddock"
"Daily Spread"
"Anaerobic digester"
"Burned for Fuel"
"Pit below animal confinenemts < 1 month"
"Pit below animal confinenemts > 1 month"
"Poultry manure with litter"
"Other"
/;
$offtext;

N2ONindirectManMan_perN_Volat_IPCC2006(SubsetManManSyst_ForManManData) = 0.01;



*B) indirect emissions from leaching:
*eq. 10.28 and 10.29
*N2O_indirect_perHead_Leach = Nex(T) * MS(T,S) * (FracLeachMS/100) * EF5(S) * 44/28
*with
*FracGasMS = percent of managed manure nitrogen for livestock category T that leaches and runoff from manure management
*EF5 = emission factor for N2O emissions from N leached and runoff from manure management
*        kg N2O-N/kg N leached and runoff (default value 0.0075 kg N2O-N (kg N leaching/runoff)-1, given in Chapter 11, Table 11.3

*FracLeachMS is coded as Leaching_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalCategoriesInHerd_IPCC2006,ManureManSystem)
*Parameter Leaching_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalCategoriesInHerd_IPCC2006,ManureManSystem);
*unit: percentage
*this is already loaded above
*the values loaded are the VALUES FROM TABLE 23 MINUS VAlues from tab 22; THIS IS BECAUSE there in tab 23 it is TOTAL loss, INCLUDING volatilisation -
*        therefore difference of average 40 in table 23 to average 30 in table 22 - thus 10% (which is the typical range of 0-20).
*thus, the values loaded are the DIFFERENCES of the values in tab 23 and tab 22.


*EF5 is coded as N2OindirectManMan_perN_Leach_IPCC2006(ManureManSystem)
Parameter N2ONindirectManMan_perN_Leach_IPCC2006(ManureManSystem);
*default value 0.0075 kg N2O-N (kg N leaching/runoff)-1, given in Chapter 11, Table 11.3
*unit: share (i.e. percentage/100)

*for ManManSyst quantity shares, we need the following only:
*Set SubsetManManSyst_ForManManData(ManureManSystem) - defined above

N2ONindirectManMan_perN_Leach_IPCC2006(SubsetManManSyst_ForManManData) = 0.0075;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*4) P emissions/losses from manure management

*NOW ADDRESS P loss from manure management:

*ATTENTION: very rudimentary - to be improved later!!!

*for now, assume from Sheldrick, W., Syers, J.K., Lingard, J., 2003, Contribution of livestock excreta to nutrient balances, Nutrient Cycling in Agroecosystems 666: 119-131
*        a loss of 10%:
*unit share P2O5 lost (i.e. percentage/100) per year
*no differentiation for Role in herd
*this is applied to ManMan without left on pastures - for the latter, the loss is accounted for via leakage in MANURE APPLICATION

Parameter P_LossFromManureManagement_VariousSources(ManureManSystem);

*for ManManSyst quantity shares, we need the following only:
*Set SubsetManManSyst_ForManManData(ManureManSystem) - defined above
P_LossFromManureManagement_VariousSources(SubsetManManSyst_ForManManData) = 0.1;

P_LossFromManureManagement_VariousSources("Pasture/Range/Paddock") = 0;
P_LossFromManureManagement_VariousSources("Burned for Fuel") = 0;


*for now, this should cover losses from management and application - TO BE DONE: separate those two and make application losses explicit.


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*5) Additional assignments as identified above

*first, adaptations for herd types, as identified further up:
$ontext;
Thus, in the end, additional assignments needed as follows:
Leach/Volat N for "Average Buffaloes IPCC2006", "Rabbits IPCC2006"

BO: chicken Layers/Broilers is identical: thus assign to  "Average Chicken IPCC2006"
MS: chicken Broilers 100% of one or the other system assumed for developing/develope dcountries only - thus just assume chicken LAyer values for "Average Chicken IPCC2006" and retain the latter only

$offtext;
Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006("Buffaloes IPCC2006",SubsetManManSyst_ForManManData)
         = Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006("Other Cattle IPCC2006",SubsetManManSyst_ForManManData);
Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006("Rabbits IPCC2006",SubsetManManSyst_ForManManData)
         = Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006("Turkey IPCC2006",SubsetManManSyst_ForManManData);
Leaching_of_N_FromManMan_PercentageFromN_IPCC2006("Buffaloes IPCC2006",SubsetManManSyst_ForManManData)
         = Leaching_of_N_FromManMan_PercentageFromN_IPCC2006("Other Cattle IPCC2006",SubsetManManSyst_ForManManData);
Leaching_of_N_FromManMan_PercentageFromN_IPCC2006("Rabbits IPCC2006",SubsetManManSyst_ForManManData)
         = Leaching_of_N_FromManMan_PercentageFromN_IPCC2006("Turkey IPCC2006",SubsetManManSyst_ForManManData);

MS_IPCC2006(FAOSTAT_Countries,"Average Chicken IPCC2006",ManureManSystem)
         = MS_IPCC2006(FAOSTAT_Countries,"Chicken Layers  IPCC2006",ManureManSystem);

Bo_IPCC2006(FAOSTAT_Countries,"Average Chicken IPCC2006")
         = Bo_IPCC2006(FAOSTAT_Countries,"Chicken Layers  IPCC2006");

*And then use a subset of herd cat animals only:
Set SubsetHerdCat_ForManManData(AnimalTypeInHerd)
/
"Dairy Cow IPCC2006"
"Other Cattle IPCC2006"
"Buffaloes IPCC2006"
"Pig IPCC2006"
"Sheep IPCC2006"
"Goat IPCC2006"
"Camel IPCC2006"
"Horse IPCC2006"
"Mule IPCC2006"
"Ass IPCC2006"
"Average Chicken IPCC2006"
"Turkey IPCC2006"
"Duck IPCC2006"
"Rabbits IPCC2006"
/;

*the following two are missing for the manman system "Other" which we use as well - thus assign a general average to it:
Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006(SubsetHerdCat_ForManManData,"Other")
         = 25;
Leaching_of_N_FromManMan_PercentageFromN_IPCC2006(SubsetHerdCat_ForManManData,"Other")
         = 10;



$ontext;
after this, we have:
Parameter MS_IPCC2006(FAOSTAT_CountriesAndRegions,AnimalTypeInHerd,SubsetManManSyst_ForManManData);
Parameter MCF_IPCC2006(SubsetManManSyst_ForManManData,Temperatures) methane conversion factor MCF;
Parameter Bo_IPCC2006(FAOSTAT_CountriesAndRegions,AnimalTypeInHerd);
Parameter Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalTypeInHerd,SubsetManManSyst_ForManManData);
Parameter Leaching_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalTypeInHerd,SubsetManManSyst_ForManManData);
Parameter MCF_IPCC2006_Countries(FAOSTAT_CountriesAndRegions,SubsetManManSyst_ForManManData);
Parameter N2ONdirectManMan_perN_IPCC2006(FAOSTAT_CountriesAndRegions,SubsetManManSyst_ForManManData);
Parameter N2ONindirectManMan_perN_Volat_IPCC2006(SubsetManManSyst_ForManManData);
Parameter N2ONindirectManMan_perN_Leach_IPCC2006(SubsetManManSyst_ForManManData);
Parameter P_LossFromManureManagement_VariousSources(SubsetManManSyst_ForManManData);
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*6) Assign values to core model parameters and variables
*6.1) Link some sets as needed

Set MatchAnTypeInHerd_Livestock_ForManMan(Livestock,AnimalTypeInHerd)
/
Cattle."Dairy Cow IPCC2006"
Cattle."Other Cattle IPCC2006"
Buffaloes."Buffaloes IPCC2006"
Pigs."Pig IPCC2006"
Sheep."Sheep IPCC2006"
Goats."Goat IPCC2006"
Camels."Camel IPCC2006"
Horses."Horse IPCC2006"
Mules."Mule IPCC2006"
Asses."Ass IPCC2006"
Chickens."Average Chicken IPCC2006"
Turkeys."Turkey IPCC2006"
Ducks."Duck IPCC2006"
"Rabbits and hares"."Rabbits IPCC2006"
/;


*6.2) Link to the core model parameters
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $MatchAnTypeInHerd_Livestock_ForManMan(Livestock,AnimalTypeInHerd)
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 MS_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd,ManureManSystem))/100;

Manure_Management("World","All Animals","AllAndAverageTypes","MCF: CH4 conversion factor (%)",ManureManSystem,Temperatures,"AllProdSyst","AllProdCond")
         = MCF_IPCC2006(ManureManSystem,Temperatures);
Manure_Management(Regions,"All Animals","AllAndAverageTypes","MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 MCF_IPCC2006_Countries(FAOSTAT_Countries,ManureManSystem));

Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Bo: max. CH4 prod. cap. (m3CH4/kgVS)","AllManManSystems","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $MatchAnTypeInHerd_Livestock_ForManMan(Livestock,AnimalTypeInHerd)
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 Bo_IPCC2006(FAOSTAT_Countries,AnimalTypeInHerd));

Manure_Management("World",Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $MatchAnTypeInHerd_Livestock_ForManMan(Livestock,AnimalTypeInHerd)
         = Volatilisation_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalTypeInHerd,ManureManSystem);

Manure_Management("World",Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $MatchAnTypeInHerd_Livestock_ForManMan(Livestock,AnimalTypeInHerd)
         = Leaching_of_N_FromManMan_PercentageFromN_IPCC2006(AnimalTypeInHerd,ManureManSystem);

Manure_Management(Regions,"All Animals","AllAndAverageTypes","Manure man N2O dir (tN2O-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions),
                 N2ONdirectManMan_perN_IPCC2006(FAOSTAT_Countries,ManureManSystem));

Manure_Management("World","All Animals","AllAndAverageTypes","Manure man N2O-N from N volat (tN/tN volat)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = N2ONindirectManMan_perN_Volat_IPCC2006(ManureManSystem);

Manure_Management("World","All Animals","AllAndAverageTypes","Manure man N2O-N from N leach (tN/tN leach)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = N2ONindirectManMan_perN_Leach_IPCC2006(ManureManSystem);

Manure_Management("World","All Animals","AllAndAverageTypes","Manure man P loss as % of P in manure (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = P_LossFromManureManagement_VariousSources(ManureManSystem);

*assign to countries / animals
Manure_Management(Regions,Livestock,"AllAndAverageTypes","MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,"All Animals","AllAndAverageTypes","MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");

Manure_Management(Regions,Livestock,"AllAndAverageTypes","Manure man N2O dir (tN2O-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,"All Animals","AllAndAverageTypes","Manure man N2O dir (tN2O-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");

Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management("World",Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management("World",Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");

Manure_Management(Countries,Livestock,"AllAndAverageTypes","Manure man N2O-N from N volat (tN/tN volat)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management("World","All Animals","AllAndAverageTypes","Manure man N2O-N from N volat (tN/tN volat)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Countries,Livestock,"AllAndAverageTypes","Manure man N2O-N from N leach (tN/tN leach)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management("World","All Animals","AllAndAverageTypes","Manure man N2O-N from N leach (tN/tN leach)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");

Manure_Management(Countries,Livestock,"AllAndAverageTypes","Manure man P loss as % of P in manure (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management("World","All Animals","AllAndAverageTypes","Manure man P loss as % of P in manure (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");

*set the aggregates "Cattle and Buffaloes" and "Sheep and Goats" equal to zero
Manure_Management(Regions,"Cattle and Buffaloes","AllAndAverageTypes","MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management(Regions,"Cattle and Buffaloes","AllAndAverageTypes","Manure man N2O dir (tN2O-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management(Countries,"Cattle and Buffaloes","AllAndAverageTypes","Manure man N2O-N from N volat (tN/tN volat)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management(Countries,"Cattle and Buffaloes","AllAndAverageTypes","Manure man N2O-N from N leach (tN/tN leach)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management(Countries,"Cattle and Buffaloes","AllAndAverageTypes","Manure man P loss as % of P in manure (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;

Manure_Management(Regions,"Sheep and Goats","AllAndAverageTypes","MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management(Regions,"Sheep and Goats","AllAndAverageTypes","Manure man N2O dir (tN2O-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management(Countries,"Sheep and Goats","AllAndAverageTypes","Manure man N2O-N from N volat (tN/tN volat)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management(Countries,"Sheep and Goats","AllAndAverageTypes","Manure man N2O-N from N leach (tN/tN leach)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management(Countries,"Sheep and Goats","AllAndAverageTypes","Manure man P loss as % of P in manure (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;

*and drop the aggregate values:
Manure_Management(Regions,"All Animals","AllAndAverageTypes","MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management(Regions,"All Animals","AllAndAverageTypes","MCF: CH4 conversion factor (%)",ManureManSystem,Temperatures,"AllProdSyst","AllProdCond")
         = 0;
Manure_Management(Regions,"All Animals","AllAndAverageTypes","Manure man N2O dir (tN2O-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;

Manure_Management("World",Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management("World",Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;

Manure_Management("World","All Animals","AllAndAverageTypes","Manure man N2O-N from N volat (tN/tN volat)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management("World","All Animals","AllAndAverageTypes","Manure man N2O-N from N leach (tN/tN leach)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;
Manure_Management("World","All Animals","AllAndAverageTypes","Manure man P loss as % of P in manure (%)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0;


*assign to final herd types and animals:
*we need the following animals and cattle/pig herd types, and AllAndAverageTypes only for all others
*different or the different parameters Quantity Share, etc. and the others

Set MatchAnTypeInHerd_Livestock_ForManMan_NoCatNoPig(Livestock,AnimalTypeInHerd)
/
Buffaloes."Buffaloes IPCC2006"
Sheep."Sheep IPCC2006"
Goats."Goat IPCC2006"
Camels."Camel IPCC2006"
Horses."Horse IPCC2006"
Mules."Mule IPCC2006"
Asses."Ass IPCC2006"
Chickens."Average Chicken IPCC2006"
Turkeys."Turkey IPCC2006"
Ducks."Duck IPCC2006"
"Rabbits and hares"."Rabbits IPCC2006"
/;

Manure_Management(Regions,Livestock,"AllAndAverageTypes","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $(NOT Manure_Management(Regions,Livestock,"AllAndAverageTypes","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond"))
         = sum(AnimalTypeInHerd$MatchAnTypeInHerd_Livestock_ForManMan_NoCatNoPig(Livestock,AnimalTypeInHerd),
                 Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond"));
Manure_Management(Regions,Livestock,"AllAndAverageTypes","Bo: max. CH4 prod. cap. (m3CH4/kgVS)","AllManManSystems","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $(NOT Manure_Management(Regions,Livestock,"AllAndAverageTypes","Bo: max. CH4 prod. cap. (m3CH4/kgVS)","AllManManSystems","AllAndAverageTemp","AllProdSyst","AllProdCond"))
         = sum(AnimalTypeInHerd$MatchAnTypeInHerd_Livestock_ForManMan_NoCatNoPig(Livestock,AnimalTypeInHerd),
                 Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Bo: max. CH4 prod. cap. (m3CH4/kgVS)","AllManManSystems","AllAndAverageTemp","AllProdSyst","AllProdCond"));
Manure_Management(Countries,Livestock,"AllAndAverageTypes","Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $(NOT Manure_Management(Countries,Livestock,"AllAndAverageTypes","Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond"))
         = sum(AnimalTypeInHerd$MatchAnTypeInHerd_Livestock_ForManMan_NoCatNoPig(Livestock,AnimalTypeInHerd),
                 Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond"));
Manure_Management(Countries,Livestock,"AllAndAverageTypes","Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $(NOT Manure_Management(Countries,Livestock,"AllAndAverageTypes","Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond"))
         = sum(AnimalTypeInHerd$MatchAnTypeInHerd_Livestock_ForManMan_NoCatNoPig(Livestock,AnimalTypeInHerd),
                 Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond"));

*assign Cattle, pigs
Manure_Management(Regions,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,"Cattle","Other Cattle IPCC2006","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Regions,"Cattle",CattleTypeInHerd,"Bo: max. CH4 prod. cap. (m3CH4/kgVS)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,"Cattle","Other Cattle IPCC2006","Bo: max. CH4 prod. cap. (m3CH4/kgVS)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Countries,"Cattle",CattleTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Countries,"Cattle","Other Cattle IPCC2006","Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Countries,"Cattle",CattleTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Countries,"Cattle","Other Cattle IPCC2006","Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");

Manure_Management(Regions,"Cattle","Producing_dairy_Cattle","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,"Cattle","Dairy Cow IPCC2006","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Regions,"Cattle","Producing_dairy_Cattle","Bo: max. CH4 prod. cap. (m3CH4/kgVS)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,"Cattle","Dairy Cow IPCC2006","Bo: max. CH4 prod. cap. (m3CH4/kgVS)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Countries,"Cattle","Producing_dairy_Cattle","Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Countries,"Cattle","Dairy Cow IPCC2006","Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Countries,"Cattle","Producing_dairy_Cattle","Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Countries,"Cattle","Dairy Cow IPCC2006","Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");

Manure_Management(Regions,"Pigs",PigTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,"Pigs","Pig IPCC2006","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Regions,"Pigs",PigTypeInHerd,"Bo: max. CH4 prod. cap. (m3CH4/kgVS)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,"Pigs","Pig IPCC2006","Bo: max. CH4 prod. cap. (m3CH4/kgVS)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Countries,"Pigs",PigTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Countries,"Pigs","Pig IPCC2006","Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Countries,"Pigs",PigTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Countries,"Pigs","Pig IPCC2006","Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");


*then assign the following:


Manure_Management(Regions,"Pigeons, other birds","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $(NOT Manure_Management(Regions,"Pigeons, other birds","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond"))
         = Manure_Management(Regions,"Chickens","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Regions,"Animals live nes","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $(NOT Manure_Management(Regions,"Animals live nes","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond"))
         = Manure_Management(Regions,"Asses","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Regions,"Camelids, other","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $(NOT Manure_Management(Regions,"Camelids, other","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond"))
         = Manure_Management(Regions,"Camels","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Regions,"Geese and guinea fowls","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $(NOT Manure_Management(Regions,"Geese and guinea fowls","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond"))
         = Manure_Management(Regions,"Chickens","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Regions,"Rodents, other","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $(NOT Manure_Management(Regions,"Rodents, other","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond"))
         = Manure_Management(Regions,"Camels","AllAndAverageTypes",ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");


*drop the following: herd cat as given in Set MatchAnTypeInHerd_Livestock_ForManMan(Livestock,AnimalTypeInHerd)
*to be deleted for the above 4 parameters!

Manure_Management(Regions,Livestock,AnimalTypeInHerd,ManureManagement,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $MatchAnTypeInHerd_Livestock_ForManMan(Livestock,AnimalTypeInHerd)
         = 0;


*and the other parameters:
Set Subset_ManureManagement_ForCertainAssignments(ManureManagement)
/
"MCF: CH4 conversion factor (%)"
"Manure man N2O dir (tN2O-N/tN)"
"Manure man N2O-N from N volat (tN/tN volat)"
"Manure man N2O-N from N leach (tN/tN leach)"
"Manure man P loss as % of P in manure (%)"
/;

Manure_Management(Regions,"Cattle",CattleTypeInHerd,Subset_ManureManagement_ForCertainAssignments,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,"Cattle","AllAndAverageTypes",Subset_ManureManagement_ForCertainAssignments,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");

Manure_Management(Regions,"Pigs",PigTypeInHerd,Subset_ManureManagement_ForCertainAssignments,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,"Pigs","AllAndAverageTypes",Subset_ManureManagement_ForCertainAssignments,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");



$ontext;
and do the last remaining assignments:
most important, we need values for all parameters for the ManMan systems where quantity shares are reported, thus assign the missing ones as follows:
MCF      ok, all values needed available
N2O dir
Volat:   Pasture/Range/Paddock EQUALS Daily spread
         Anaerobic digester and burned for fuel: assume 0
Leach:   Pasture/Range/Paddock EQUALS Daily spread
         Anaerobic digester and burned for fuel: assume 0
         Liquid/Slurry with natural crust cover  EQUALS  Uncovered anaerobic Lagoon
         Liquid/Slurry without natural crust cover  EQUALS  Uncovered anaerobic Lagoon
         Pit below animal confinenemts < 1 month  EQUALS  Uncovered anaerobic Lagoon*0.7
         Pit below animal confinenemts > 1 month  EQUALS  Uncovered anaerobic Lagoon*0.7
$offtext;

*thereby, we also assign the Pasture/Range/Paddock system - as it is missing otherwise. It is usually calculated with ManMan in the inventories, but it is reported under fertilizer soil application emissions;
*In SOLm, we then differentiate this via emissions from "Grazing", when assigning it to animal heads (see the module on ManMan and emissions).
*Values from IPCC 2006, Table 11.1:
Manure_Management(Countries,Livestock,"AllAndAverageTypes","Manure man N2O dir (tN2O-N/tN)","Pasture/Range/Paddock","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.01;
Manure_Management(Countries,"Cattle",CattleTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Pasture/Range/Paddock","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.02;
Manure_Management(Countries,"Pigs",PigTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Pasture/Range/Paddock","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.02;
Manure_Management(Countries,Poultry,"AllAndAverageTypes","Manure man N2O dir (tN2O-N/tN)","Pasture/Range/Paddock","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.02;

Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)","Pasture/Range/Paddock","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)","Daily spread","AllAndAverageTemp","AllProdSyst","AllProdCond");

Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)","Pasture/Range/Paddock","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)","Daily spread","AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)","Liquid/Slurry with natural crust cover","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)","Uncovered anaerobic Lagoon","AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)","Liquid/Slurry without natural crust cover","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)","Uncovered anaerobic Lagoon","AllAndAverageTemp","AllProdSyst","AllProdCond");
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)","Pit below animal confinenemts < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)","Uncovered anaerobic Lagoon","AllAndAverageTemp","AllProdSyst","AllProdCond")*0.7;
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)","Pit below animal confinenemts > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)","Uncovered anaerobic Lagoon","AllAndAverageTemp","AllProdSyst","AllProdCond")*0.7;


*there may still be a problem of not-matching systems and emission coefficients - I think - (to be CHECKED!!) - but assign as follows to for sure have some losses:
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $(Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                         AND (NOT Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")))
         = 30;
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $(Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                         AND (NOT Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")))
         = 10;

*finally, assign a specific value for poultry manure, which applies to all systems with solid manure with values larger than zero (IPCC 2006, 10.21):
Manure_Management(Regions,Poultry,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Solid Storage","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Regions,Poultry,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Solid Storage","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.001;
Manure_Management(Regions,Poultry,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Regions,Poultry,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding < 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.001;
Manure_Management(Regions,Poultry,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Regions,Poultry,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)","Deep bedding > 1 month","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.001;

*finally, assign the "Quantity share in ManureMan syst - N-based" identical to "Quantity share in ManureMan system"
*to be replaced with better values later if available:
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond");

$ontext;
After this we have the following in SOLm-entities:

Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Quantity share in ManureMan system"          ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based"  ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"MCF: CH4 conversion factor (%)"              ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Bo: max. CH4 prod. cap. (m3CH4/kgVS)"        ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)"       ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N leach (% of N in manure)"       ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)"              ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N2O-N from N volat (tN/tN volat)" ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man N2O-N from N leach (tN/tN leach)" ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
Manure_Management(Regions,Livestock,AnimalTypeInHerd,"Manure man P loss as % of P in manure (%)"   ,ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")

Regions           is      FAOSTAT_Countries,
$offtext;
