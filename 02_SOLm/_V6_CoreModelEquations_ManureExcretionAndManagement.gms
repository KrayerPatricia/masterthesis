PUTCLOSE con,"_V6_CoreModelEquations_ManureExcretionAndManagement";

*GENERAL DESCRIPTION
*This file contains all the core model equations for manure excretion, management and emissions (IPCC 2006)

*DETAILED TABLE OF CONTENTS
$ontext;
- 1) Manure excretion
- 2) Manure management
         2.1) Some general calculations
         2.2) Methane emissions
         2.3) N2O and NH3 emissions
                 2.3.1) Direct emissions
                 2.3.2) Indirect Emissions
                   2.3.2 A) indirect emissions from volatilisation:
                   2.3.2 B) indirect emissions from leach/runoff:
                 2.3.3) NH3 emissions from housing
                 2.3.4) Total N and GHG emissions and losses from manure management
         2.4) P emissions
         2.5) N and P available for fertilization
$offtext;

*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Manure excretion

*derive VS - Volatile solids excretion rates - are determined as follows:
*unit: t VS in DM/animal/year (as GE-content is in MJ per TON!)
*VS = [GE*(1 - DE%/100) + UE*GE] * [(1 - ASH)/GE_per_DM ]
*Where:
*VS = volatile solid excretion per year on a dry-organic matter basis, kg VS year-1
*GE = gross energy intake, MJ year-1
*DE% = digestibility of the feed in percent (e.g. 60%)
*(UE*GE) = urinary energy expressed as fraction of GE times GE. Typically 0.04GE can be considered urinary
*        energy excretion by most ruminants (reduce to 0.02 for ruminants fed with 85% or more grain in the
*        diet or for swine). Use country-specific values where available.
*ASH = the ash content of manure calculated as a fraction of the dry matter feed intake (e.g., 0.08 for
*        cattle). Use country-specific values where available.
*GE_per_DM = conversion factor for dietary GE per kg of dry matter (MJ kg-1). This value is relatively constant
*        across a wide range of forage and grain-based feeds commonly consumed by livestock.
*        IPCC Default: 18.45 - we use the values derived from feed supply, which are largely ok, it seems.

ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"VS DM in manure (tVS)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $Commod_Contents_MR(Regions_MR,"AggregateFeedTotal_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedGE_Req_Total (MJ)",ProductionSystems,ProductionConditions,"%Scenario%")
                  *(1 - ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Digestibility of Feed (%)",ProductionSystems,ProductionConditions,"%Scenario%")/100
                       + ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,"AllAndAverageTypes","UE_per_GE (share)",ProductionSystems,ProductionConditions,"%Scenario%"))
                  *(1 - Manure_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Ash content in feed DM (share)",ProductionSystems,ProductionConditions,"%Scenario%"))
                          /Commod_Contents_MR(Regions_MR,"AggregateFeedTotal_Commodity","FeedGE in DM (MJ)",ProductionSystems,ProductionConditions,"%Scenario%");

*and then derive manure total solids (TS):
*and assume total solids to be volatile solids plus ash, then being equal to total dry matter:
*unit: t TS/animal/year
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"VS DM in manure (tVS)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"FeedDM_Req_Total (t DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Ash content in feed DM (share)",ProductionSystems,ProductionConditions,"%Scenario%");

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Manure management
*2.1) Some general calculations

*derive per DM manure N and P contents BEFORE MANAGEMENT:

*first, assign N and P excretion from per 1000kg liveweight to per head values:
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%"))
*                 condition above to allow for reading N excr values per head directly
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure per ton liveweight (tN/t lw/y)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Liveweight (t)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"P in manure (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $(NOT ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"P in manure (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%"))
*                 condition above to allow for reading P excr values per head directly
         = ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"P in manure per ton liveweight (tP2O5/t lw/y)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *ActAnimalsHead_OtherChar_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Liveweight (t)",ProductionSystems,ProductionConditions,"%Scenario%");


*unit: t N / t manure VS DM
Manure_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in VS DM (tN/t VS DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"VS DM in manure (tVS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"VS DM in manure (tVS)",ProductionSystems,ProductionConditions,"%Scenario%");
*unit: t N / t manure total DM
Manure_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in TS DM (tN/t TS DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%");

*unit: t P2O5 / t manure VS DM
Manure_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"P in VS DM (tP2O5/t VS DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"VS DM in manure (tVS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"P in manure (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"VS DM in manure (tVS)",ProductionSystems,ProductionConditions,"%Scenario%");
*unit: t P2O5 / t manure total DM
Manure_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"P in TS DM (tP2O5/t TS DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"P in manure (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%");

*these N and P contents in manure are BEFORE treatment; - but we also need N and P content in manure TREATED, i.e. AFTER LEAVING THE MANAGEMENT SYSTEMS!
*this is done AFTER calculating the emissions from treatement


*2.2) Methane emissions
*IPCC 2006, Tier 2 approach:
*Volume 4, chapter 10, equations 10.23 ff

*Methane emissions:
*unit: m3 CH4 / kg manure excreted

*EF(T) = (VS(T) * 365) * (Bo(T) * 0.67 kg/m3 * Sum(S,k)MCF(S,k)/100*MS(T,S,k) )

*where
*EF(T) = annual CH4 emission factor for livestock category T, kg CH4 animal-1 yr-1
*VS(T) = daily volatile solids excreted for livestock category T, kg dry matter animal-1 day-1
*365 = basis for calculating annual VS production, days yr-1
*Bo(T) = maximum methane producing capacity for manure produced by livestock category T, m3 CH4 kg-1 of VS excreted
*0.67 = conversion factor of m3 CH4 to kilograms CH4
*MCF(S,k) = methane conversion factors for each manure management system S by climate region k, %
*MS(T,S,k) = fraction of livestock category T's manure handled using manure management system S in climate region k, dimensionless

*thereby, VS - Volatile solids excretion rates - are determined as follows:

*VS = [GE*(1 - DE%/100) + UE*GE] * [(1 - ASH)/GE_per_DM ]

*Where:
*VS = volatile solids excretion per day on a dry-organic matter basis, kg VS day-1
*GE = gross energy intake, MJ day-1
*DE% = digestibility of the feed in percent (e.g. 60%): thus choose 0.6
*(UE*GE) = urinary energy expressed as fraction of GE. Typically 0.04GE can be considered urinary
*        energy excretion by most ruminants (reduce to 0.02 for ruminants fed with 85% or more grain in the
*        diet or for swine). Use country-specific values where available.
*ASH = the ash content of manure calculated as a fraction of the dry matter feed intake (e.g., 0.08 for
*        cattle). Use country-specific values where available.
*GE_per_DM = conversion factor for dietary GE per kg of dry matter (MJ kg-1). This value is relatively constant
*        across a wide range of forage and grain-based feeds commonly consumed by livestock.
*        IPCC Default: 18.45 - we use the values derived from feed supply, which are largely ok, it seems.

*Data:
*Bo(T): tables 10A-4 to 10A-9
*MCF(S,k): table 10.17

*most of these parameters are already defined in the modules for reading data on manure excretion and manure management, etc.

*now do the calculations:
*EF(T) = (VS(T)) * (Bo(T) * 0.67 kg/m3 * Sum(S,k)MCF(S,k)/100*MS(T,S,k) )
*that's IPCC - but for per animal values, we refrain from summing over climate, as one animal is usually located in one climate only
*in IPCC there is a factor 365, as it is per day value for VS - but we have annual values, thus no 365 needed (cf. module on manure excretion)
*VS is: ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"VS DM in manure (tVS)",ProductionSystems,ProductionConditions,"%Scenario%")
*unit: t CO2eq/head/year;
*division by 100 at MCF in the formula above for transforming percentages to shares/fractions
*Bo*0.67kg/m3 is kgCH4/kg VS equal tCH4/tVS

*CH4 emissions per head:
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man CH4 (tCH4)" ,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"VS DM in manure (tVS)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystem,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Bo: max. CH4 prod. cap. (m3CH4/kgVS)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *0.67
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));

ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man CH4 (tCO2e)" ,ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man CH4 (tCH4)" ,ProductionSystems,ProductionConditions,"%Scenario%")
                 *GWP_GTP_SOLm_MR("CH4","%Scenario%");


*derive emissions per ton of manure TS DM in one specific ManMan system
*do it as follows:
*E/t manure (Manman syst) = (E/head (If all manure would be managed in ONE manman syst) / (Manure/head)
*unit: t CO2eq / t manure TS DM
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man CH4 (tCH4)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"VS DM in manure (tVS)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Bo: max. CH4 prod. cap. (m3CH4/kgVS)","AllManManSystems","AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *0.67
                 *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"MCF: CH4 conversion factor (%)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%");

Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man CH4 (tCO2e)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man CH4 (tCH4)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 *GWP_GTP_SOLm_MR("CH4","%Scenario%");

*2.3) N2O and NH3 emissions

*direct and indirect N2O emissions from manure management:

*the inventories report emissions from grazing NOT under manure management, but under soil application of manure,
*thus use the cropland man man systems only for man man emissions
*and use a separating category "grazing" for the grassland man man systems on the level of per animal head parameters:

*first, some values of interest for some comparisons, etc.:
*manure excreted in grazing and non-grazing systems:
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure - non grazing systems (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemCropland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure - grazing systems (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemGrassland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));


*2.3.1) Direct emissions
*IPCC 2006, volume 10, chapter 4, equation 10.25:
$ontext;
N2O_direct_perHead = Nex(T) * MS(T,S) * EF3(S) * 44/28
Where:
N2O_direct_perHead = direct N2O emissions from Manure Management in the country, per head of animal, kg N2O yr-1
Nex(T) = annual average N excretion per head of species/category T in the country, kg N animal-1 yr-1
MS(T,S) = fraction of total annual nitrogen excretion for each livestock species/category T that is managed
in manure management system S in the country, dimensionless
EF3(S) = emission factor for direct N2O emissions from manure management system S in the country, kgN2O-N/kg N in manure management system S (values from TABLE 10.21)
S = manure management system
T = species/category of livestock
44/28 = conversion of (N2O-N) emissions to N2O emissions
$offtext;
*Thus:
*unit: tons CO2eq/Head/year: *44/28 conversion N2O-N to N2O

ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemCropland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *44/28;
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O dir (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemGrassland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *44/28;

ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *GWP_GTP_SOLm_MR("N2O","%Scenario%");
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O dir (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O dir (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *GWP_GTP_SOLm_MR("N2O","%Scenario%");
*N quantity lost:
*unit: tons N/Head/year
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N in N2O dir (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /44*28;
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N in N2O dir (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O dir (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /44*28;

*derive direct N losses via N2O-emissions per ton manure TS DM:
*as follows:
*tN Losses/t manure (Manman syst) = (Losses/head (If all manure would be managed in ONE manman syst) / (Manure/head)
*unit: t N / t manure TS DM
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N in N2O dir (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tN2O-N/tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                          /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%");

*and corresponding N2O emissions:
*unit: t CO2eq / t manure TS DM
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tCO2e)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N in N2O dir (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *44/28*GWP_GTP_SOLm_MR("N2O","%Scenario%");


*2.3.2) Indirect Emissions
$ontext;
this is volatilisation and Leaching/runoff
2.3.2 A) indirect emissions from volatilisation:
eq. 10.26 and 10.27
N2O_indirect_perHead_Volat = Nex(T) * MS(T,S) * (FracGasMS/100) * EF4(S) * 44/28
with
FracGasMS = percent of managed manure nitrogen for livestock category T that volatilises as NH3 and NOx in the manure management system S, %
*unit: percentage
*VALUES are from table 22, IPCC 2006, vol4, chapter 10.
EF4 = emission factor for N2O emissions from atmospheric deposition of nitrogen on soils and water surfaces, kg N2O-N (kg NH3-N + NOx-N volatilised)-1;
         default value is 0.01 kg N2O-N (kg NH3-N + NOx-N volatilised)-1 , given in Chapter 11, Table 11.3
*unit: share (i.e. percentage/100)
$offtext;

*now do the calculations for indirect volatilisation N2O emissions:
*unit: t N2O/head/year
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O volat (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemCropland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O-N from N volat (tN/tN volat)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *44/28;
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O volat (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemGrassland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O-N from N volat (tN/tN volat)",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *44/28;
*unit: t CO2eq/head/year
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O volat (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O volat (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *GWP_GTP_SOLm_MR("N2O","%Scenario%");
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O volat (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O volat (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *GWP_GTP_SOLm_MR("N2O","%Scenario%");
*and calculate the related N quantity:
*unit: t N /head/year
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N volat (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemCropland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N volat (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemGrassland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));

*do NH3 emissions as specific part of the volatilization:
*unit: t NH3/head/year (17/14 converts N to NH3)
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man NH3 (tNH3)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemCropland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man NH3-N (% of N in manure)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *17/14;
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing NH3 (tNH3)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemGrassland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man NH3-N (% of N in manure)",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *17/14;

*derive N2O indirect volat per ton manure TS DM:
*as follows:
*E/t manure (Manman syst) = (E/head (If all manure would be managed in ONE manman syst) / (Manure/head)
*unit t N / t manure TS DM
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N volat (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N volat (% of N in manure)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                          /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%");
*and corresponding N2O emissions:
*unit: t N2O / t manure TS DM
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O volat (tN2O)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N volat (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O-N from N volat (tN/tN volat)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *44/28;

*and corresponding GHG emissions:
*unit: t CO2eq / t manure TS DM
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O volat (tCO2e)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O volat (tN2O)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 *GWP_GTP_SOLm_MR("N2O","%Scenario%");

*do NH3 emissions as specific part of the volatilization:
*unit t NH3 / t manure TS DM
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man NH3 (tNH3)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man NH3-N (% of N in manure)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                          /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
                                 *17/14;


*2.3.2 B) indirect emissions from leach/runoff:
$ontext;
eq. 10.28 and 10.29
N2O_indirect_perHead_Leach = Nex(T) * MS(T,S) * (FracLeachMS/100) * EF5(S) * 44/28
with
FracleachMS = percent of managed manure nitrogen losses for livestock category T due to runoff and leaching during solid and liquid storage of manure (typical range 1-20%)
EF5 = emission factor (share - i.e. %/100) for N2O emissions from nitrogen leaching and runoff, kg N2O-N/kg N leached and runoff (default value 0.0075 kg N2O-N (kg N leaching/runoff)-1, given in Chapter 11, Table 11.3
$offtext;

*now do the calculations for indirect leach/runoff N2O emissions:
*unit: t N2O/head/year
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O leach (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemCropland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O-N from N leach (tN/tN leach)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *44/28;
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O leach (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemGrassland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O-N from N leach (tN/tN leach)",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *44/28;
*unit: t CO2eq/head/year
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O leach (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O leach (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *GWP_GTP_SOLm_MR("N2O","%Scenario%");
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O leach (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O leach (tN2O)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *GWP_GTP_SOLm_MR("N2O","%Scenario%");
*and calculate the related N quantity:
*unit: t N /head/year
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N leach (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemCropland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N leach (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemGrassland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));

*derive N2O indirect leach per ton manure TS DM:
*as follows:
*E/t manure (Manman syst) = (E/head (If all manure would be managed in ONE manman syst) / (Manure/head)
*unit t N / t manure TS DM
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N leach (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N leach (% of N in manure)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                          /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%");
*and corresponding N2O emissions:
*unit: t N2O / t manure TS DM
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O leach (tN2O)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N leach (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O-N from N leach (tN/tN leach)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *44/28;

*and corresponding GHG emissions:
*unit: t CO2eq / t manure TS DM
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O leach (tCO2e)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O leach (tN2O)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 *GWP_GTP_SOLm_MR("N2O","%Scenario%");


*2.3.3) NH3 emissions from housing
*part of N from manure is lost as NH3; from manure management - storage, this is accounted for in the calculations above, as it ultimately results in N2O emissions which are traced above
*there is however also part lost in NH3 from housing the animals, which effects the N available for fertilization, but does not result in N2O
*hence it is not traced via N2O emissions but has to be calculated separately. This is done in this sub-section.
*the other NH3 flows (which are already captured in the volatilization calculations) are traced separately already above for calculating the NH3 losses as a separate indicator.

*unit: tons NH3/Head/year: *17/14 conversion NH3-N to NH3
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Housing NH3 from manure (tNH3)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemCropland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *17/14;
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing-Housing NH3 from manure (tNH3)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemGrassland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan syst - N-based",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"))
                         *17/14;
*N quantity lost:
*unit: tons N/Head/year
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Housing NH3 from manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Housing NH3 from manure (tNH3)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /14*17;
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing-Housing NH3 from manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing-Housing NH3 from manure (tNH3)",ProductionSystems,ProductionConditions,"%Scenario%")
                         /14*17;

*derive direct N losses via housing NH3-emissions per ton manure TS DM:
*as follows:
*tN Losses/t manure (Manman syst) = (Losses/head (If all manure would be managed in ONE manman syst) / (Manure/head)
*unit: t N / t manure TS DM

Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Housing N in NH3 from manure (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 $ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Housing NH3 from manure (tNH3-N/tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                          /ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%");


*2.3.4) Total N and GHG emissions and losses from manure management
*now sum the N emissions and losses via direct and indirect paths to get total N losses from manure management:

ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O total (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O volat (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O leach (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O total (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O dir (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O volat (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N2O leach (tCO2e)",ProductionSystems,ProductionConditions,"%Scenario%");

ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N total loss (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N in N2O dir (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N volat (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N leach (tN)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N total loss (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N in N2O dir (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N volat (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N leach (tN)",ProductionSystems,ProductionConditions,"%Scenario%");

ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man+housing N total loss (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N total loss (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Housing NH3 from manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%");
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing+Grazing-housing N total loss (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing N total loss (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
                 + ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Grazing-Housing NH3 from manure (tN)",ProductionSystems,ProductionConditions,"%Scenario%");

Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O total (tCO2e)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O dir (tCO2e)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 + Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O volat (tCO2e)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 + Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N2O leach (tCO2e)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");

Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N total loss (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N in N2O dir (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 + Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N volat (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 + Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N leach (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");

Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man+housing N total loss (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man N total loss (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                 + Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Housing N in NH3 from manure (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");


*XXXXXXXXXXXXXXXXXXX
*ATTENTION - TO BE DONE:
*IMPORTANT: Add N2 losses from denitrification explicitly to track N2 losses from denitrification for N balance and thus to get a better grasp for the N surplus!!
*if at all important for ManMan/Housing and not only for N applications to soils!
*XXXXXXXXXXXXXXXXXXX



*2.4) P emissions
**************P LOSS FROM MANMAN: FOR LATER: DIFFERENTIATE FOR ROLE in herd structure AND YIELD TYPES - FOR THE ANIMALS WITH HERD STRUCTURE.

*unit: tP2O5 lost/t manure TS DM per year
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man P total loss (tP2O5)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"P in TS DM (tP2O5/t TS DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man P loss as % of P in manure (%)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100;

*derive per animal head values:
*unit: t P2O5 /head/year
ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man P total loss (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"P in manure (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystem,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man P loss as % of P in manure (%)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")/100
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));


*2.5) N and P available for fertilization
*this is the reminder of N and P in manure, after subtracting losses:

*******ATTENTION - TO BE CHECKED: WHAT ABOUT N2 losses from denitrification - included in volatization - as this is N, whereof part is N2O (and maybe part is N2)? OR is this additional? TO BE CHECKED!!
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure N for areas (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"N in TS DM (tN/t TS DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 - Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man+housing N total loss (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");

Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure P for areas (tP2O5)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         = Manure_Contents_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"P in TS DM (tP2O5/t TS DM)",ProductionSystems,ProductionConditions,"%Scenario%")
                 - Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure man P total loss (tP2O5)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%");

*avoid negative values:
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure N for areas (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         $(Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure N for areas (tN)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
                 =0;
Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure P for areas (tP2O5)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
         $(Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure P for areas (tP2O5)",ManureManSystem,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%") < 0)
                 =0;


*convert to per animal head values:
*ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure N for crop areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 *sum(ManureManSystemCropland,
*                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure N for areas (tN)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
*                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));

*ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure P for crop areas (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
*         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
*                 *sum(ManureManSystemCropland,
*                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure P for areas (tP2O5)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
*                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));


ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure N for crop areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemCropland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure N for areas (tN)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));

ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure N for grass areas (tN)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemGrassland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure N for areas (tN)",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));

ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure P for crop areas (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemCropland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure P for areas (tP2O5)",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystemCropland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));

ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure P for grass areas (tP2O5)",ProductionSystems,ProductionConditions,"%Scenario%")
         = ActAnimalsHead_Outputs_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"TS DM in manure (tTS)",ProductionSystems,ProductionConditions,"%Scenario%")
                 *sum(ManureManSystemGrassland,
                         Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Manure P for areas (tP2O5)",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%")
                         *Manure_Management_MR(Regions_MR,Activities_MR,AnimalTypeInHerd,"Quantity share in ManureMan system",ManureManSystemGrassland,"AllAndAverageTemp",ProductionSystems,ProductionConditions,"%Scenario%"));












