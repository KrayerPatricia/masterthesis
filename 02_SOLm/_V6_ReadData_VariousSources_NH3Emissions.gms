*Code for calculations of NH3 emissions
PUTCLOSE con,"_V6_ReadData_VariousSources_NH3Emissions";

$ontext;
GENERAL DESCRIPTION
This file reads and/or assigns the values needed to calculate NH3 emissions from fertilizer application and manure management

DETAILED TABLE OF CONTENTS
- 1) NH3 emissions
        1.1) NH3 emissions from fertilizer application
        1.2) NH3 emissions from manure management
        1.3) NH3 emissions from housing
$offtext;

$ontext;
Further details:

ideally: to do as tier 3: rebuild the calculations in AGRAMMON - but this is way beyond what we can currently implement in SOLm (albeit much of it would be available or could be added: in principle, it would be possible)
reference: HAFL 2018, Ammoniakemissionen der schweizerischen Landwirtschaft 1990-2015 (Bericht_Agrammon_1990-2015_20181010.pdf)

but we do it simpler, via emission factors; NH3 is part of the volatilization as calculated for manure management and fertilizer application emissions.
the other part is NOx; generally, the biggest share of volatized N is via NH3, not so much via NOx (general ref for this statement, e.g. BouwmanEtAl_GlobalBiogeochemicalCycles2002.pdf for fertilizer application)
IPCC data are as follows (cf. _V6_ReadData_VariousSources_FertilizerApplicationData.gms):

mineral fertilizer: 10% of N applied is volatized as NH3-N and NOx-N
manure:             20% of N applied is volatized as NH3-N and NOx-N
crop residues:      20% of N applied is volatized as NH3-N and NOx-N

So we use 131021_nemecek_estimating_direct_field_and_farm_emissions.pdf, reporting from EA, 2013, Tab. 3-1 and 8-8 (no details on what EEA 2013 is given, though):
for all fertilizer application: 2.6% of N applied are volatized as NOx
This thus results in the following emission factors for NH3 (EF total volatilization via NH3+NOx MINUS EF NOx)

mineral fertilizer:  7.4% of N applied are volatized as NH3-N
manure:             17.4% of N applied are volatized as NH3-N
crop residues:      17.4% of N applied are volatized as NH3-N

or: NH3-N is a factor XX of N volatized (NH3-N + NOX-N): Factors XX are *7.4/10 for mineral fert and *17.4/20 for manure and crop res
to get NH3 from NH3-N: multiply with 17/14


For manure management: 0.01% for liquid and 1% for solid manure, thus
0.01% for man man systems: "Uncovered anaerobic Lagoon"; "Liquid/Slurry with natural crust cover"; "Liquid/Slurry without natural crust cover"
1% for all others

Thus, this gives the following emission factors:
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) NH3 emissions

*1.1) NH3 emissions from fertilizer application
MinFertApplication(Countries,Activities,"mineral N fert (N)","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = MinFertApplication(Countries,Activities,"mineral N fert (N)","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
                 *7.4/10;

ManureApplication(Countries,Activities,Livestock,"AllAndAverageTypes","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = ManureApplication(Countries,Activities,Livestock,"AllAndAverageTypes","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
                 *17.4/20;

CropResAndBiomassApplication(Countries,Activities,"All Residues","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
         = CropResAndBiomassApplication(Countries,Activities,"All Residues","Volatized N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
                 *17.4/20;

*1.2) NH3 emissions from manure management
Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man NH3-N (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 - 1;
Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man NH3-N (% of N in manure)","Uncovered anaerobic Lagoon","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)","Uncovered anaerobic Lagoon","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)","Uncovered anaerobic Lagoon","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 - 0.01;
Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man NH3-N (% of N in manure)","Liquid/Slurry with natural crust cover","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)","Liquid/Slurry with natural crust cover","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)","Liquid/Slurry with natural crust cover","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 - 0.01;
Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man NH3-N (% of N in manure)","Liquid/Slurry without natural crust cover","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)","Liquid/Slurry without natural crust cover","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man N volat (% of N in manure)","Liquid/Slurry without natural crust cover","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 - 0.01;

*1.3) NH3 emissions from housing
$ontext;
calculations are based on the NH3-N emissions factors from housing as given in the GHG inventory of Austria, 2019, tables 205/208 p 354 ff, as EF applied to manure excreted;
furthermore, use Tables 236/237, p 339/340 and also tables 245, 251 etc. and around in the "Austria's Informative Inventory Report (IIR) 2018" on emissions to derive a weighted share of EF from tied/loose cattle systems, as this makes a big difference in the emission factor.
*IMPORTANT: in particular this share tied/loos will vary GREATLY between countries!!!
$offtext;

*for cattle and pigs, use averages from table 205, AT GHG inventory 2019 - these are used globally, can then be refined if single countries are addressed (e.g. AT)
Manure_Management(Countries,"Cattle",CattleTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.08;

*the following is not really housing, but rather application to the fields - but nevertheless calculate it here, as it is reported under "housing" in Table 245 of "Austria's Informative Inventory Report (IIR) 2018":
Manure_Management(Countries,"Cattle",CattleTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)","Pasture/Range/Paddock","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Cattle",CattleTypeInHerd,"Quantity share in ManureMan system","Pasture/Range/Paddock","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.05;


Manure_Management(Countries,"Pigs",PigTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Pigs",PigTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.15;
*solid storage is higherm by 30% from remaining TAN - this maybe about 5%, so add 0.05:
Manure_Management(Countries,"Pigs",PigTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)","Solid storage","AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Pigs",PigTypeInHerd,"Quantity share in ManureMan system","Solid storage","AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.2;

Manure_Management(Countries,"Sheep","AllAndAverageTypes","Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Sheep","AllAndAverageTypes","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.22*0.5*182/365;
Manure_Management(Countries,"Goats","AllAndAverageTypes","Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Goats","AllAndAverageTypes","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.22*0.5*182/365;
Manure_Management(Countries,"Horses","AllAndAverageTypes","Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Horses","AllAndAverageTypes","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.22*0.6*292/365;
Manure_Management(Countries,"Mules","AllAndAverageTypes","Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Mules","AllAndAverageTypes","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.22*0.6*292/365;
Manure_Management(Countries,"Asses","AllAndAverageTypes","Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Asses","AllAndAverageTypes","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.22*0.6*292/365;
*use some average for Chickens
Manure_Management(Countries,"Chickens","AllAndAverageTypes","Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Chickens","AllAndAverageTypes","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.35*0.7;
Manure_Management(Countries,"Turkeys","AllAndAverageTypes","Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Turkeys","AllAndAverageTypes","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.35*0.7;
Manure_Management(Countries,"Ducks","AllAndAverageTypes","Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Ducks","AllAndAverageTypes","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.38*0.7;
Manure_Management(Countries,"Geese and guinea fowls","AllAndAverageTypes","Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
                 $Manure_Management(Countries,"Geese and guinea fowls","AllAndAverageTypes","Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")
         = 0.38*0.7;



$ontext;
After this we have the following in SOLm-entities:

MinFertApplication(Countries,Activities,"mineral N fert (N)","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
ManureApplication(Countries,Activities,Livestock,"AllAndAverageTypes","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
CropResAndBiomassApplication(Countries,Activities,"All Residues","NH3-N as percentage of fertilizer N applied (%)","AllProdSyst","AllProdCond")
Manure_Management(Countries,Livestock,AnimalTypeInHerd,"Manure man NH3-N (% of N in manure)",ManureManSystem,"AllAndAverageTemp","AllProdSyst","AllProdCond")

Activities           is              all crops and core grass activities
$offtext;
