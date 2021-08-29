PUTCLOSE con,"_V6_ReadData_VariousSources_MineralFertilizerProductionEmissionsData";

$ontext;
GENERAL DESCRIPTION
This file reads/assigns the data for mineral fertilizer production emissions

DETAILED TABLE OF CONTENTS
- 1) Mineral fertilizer production emissions and energy use
- 2) Assign values to core model parameters and variables
         2.1) Link some sets as needed
         2.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Mineral fertilizer production emissions and energy use

*emissions from mineral fertilizer production:
*reference: Wood, S. and Cowie, A., 2004, A Review of Greenhouse Gas Emission Factors for Fertiliser Production, Report for IEA Bioenergy Task 38
*http://www.ieabioenergy-task38.org/publications/GHG_Emission_Fertilizer%20Production_July2004.pdf
*N:
*        they report values between about 1.3-13 kgCo2e/kgN - thus may choose 6
*P2O5:   Table 7
*        they have 0.1-1kgCO2e/kgP2O5 - thus we may could use 0.7 from the data they report,
*        disregarding negative values that refer to energy gains that may be utilized to replace fossil fuels.

*ATTENTION - very coarse - to be improved!


Set MineralFertPerTonParameters
/
*FROM HERE: in SOLmV5
"t CO2e/tN production",
"t CO2e/tP2O5 production",
"t CO2e/tK2O production"

"MJ CED/tN production"
"MJ CED/tP2O5 production"
*TILL HERE: in SOLmV5
/;



Parameter PerTonParamForMineralFertilizers_VariousSources(FAOSTAT_CountriesAndRegions,FAOSTAT_FertilizerItems,MineralFertPerTonParameters);

*unit t CO2e / t N
PerTonParamForMineralFertilizers_VariousSources("World","Nutrient nitrogen N (total)","t CO2e/tN production")
         = 6;
*unit t CO2e / t P2O5
PerTonParamForMineralFertilizers_VariousSources("World","Nutrient phosphate P205 (total)","t CO2e/tP2O5 production")
         = 0.7;

*and add energy use:
* assign CED-values for mineral fertilizer production (N-Fertilizer and P205-Mineral); according to ecoinvent 2.0/fibl-betriebsmodell (based on ecoinvent 2.0)
PerTonParamForMineralFertilizers_VariousSources("World","Nutrient nitrogen N (total)","MJ CED/tN production")
         = 65340;

PerTonParamForMineralFertilizers_VariousSources("World","Nutrient phosphate P205 (total)","MJ CED/tP2O5 production")
         = 26200;



$ontext;
after this, we have:
Parameter PerTonParamForMineralFertilizers_VariousSources(FAOSTAT_CountriesAndRegions,FAOSTAT_FertilizerItems,MineralFertPerTonParameters);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Assign values to core model parameters and variables
*2.1) Link some sets as needed

*no new sets needed

*2.2) Link to the core model parameters

MineralFertilizerCharacteristics(Countries,"mineral N fert (N)","AllMinFertProdTech","t CO2e/tN production","AllProdSyst")
         = PerTonParamForMineralFertilizers_VariousSources("World","Nutrient nitrogen N (total)","t CO2e/tN production");

MineralFertilizerCharacteristics(Countries,"mineral P fert (P2O5)","AllMinFertProdTech","t CO2e/tP2O5 production","AllProdSyst")
         = PerTonParamForMineralFertilizers_VariousSources("World","Nutrient phosphate P205 (total)","t CO2e/tP2O5 production")



$ontext;
After this we have the following in SOLm-entities:

MineralFertilizerCharacteristics(Countries,"mineral N fert (tN)","AllMinFertProdTech","t CO2e/tN production","AllProdSyst")
MineralFertilizerCharacteristics(Countries,"mineral P fert (tP2O5)","AllMinFertProdTech","t CO2e/tP2O5 production","AllProdSyst")
$offtext;
