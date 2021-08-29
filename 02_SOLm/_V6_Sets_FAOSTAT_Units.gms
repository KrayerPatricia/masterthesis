PUTCLOSE con,"_V6_Sets_FAOSTAT_Units";

$ontext;
GENERAL DESCRIPTION
This file declares all the sets with units needed in the model for reading FAOSTAT production, trade, food balance and land use data.

DETAILED TABLE OF CONTENTS
the following sets are declared below:
- 1) Reading FAOSTAT data
         -1.1) Crop Production
         -1.2) Livestock Production
         -1.3) Trade
         -1.4) Food Balance Sheets
         -1.5) Producer Price

SHORT SUMMARY:
In this code file, the following sets are defined:
Set FAOSTAT_CropProductionUnits All units (such as "ha" or "tonnes") that may be used in crop production in FAOSTAT
Set FAOSTAT_LivestockProductionUnits All units (such as "Head" or "hg") that may be used in livestock production in FAOSTAT
Set FAOSTAT_TradeUnits All units (such as "Head" or "tonnes") that may be used in trade data in FAOSTAT
Set FAOSTAT_CommodityBalancesUnits All units (such as "kg" or "tonnes") that may be used in commodity balances in FAOSTAT
Set FAOSTAT_ProducerPriceUnits All units (such as "USD") that may be used in producer price data in FAOSTAT

$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Reading FAOASTAT data
*the following declares various sets that are needed for reaing in FAOSTAT data

*1.1) Crop Production
Set FAOSTAT_CropProductionUnits All units (such as "ha" or "tonnes") that may be used in crop production in FAOSTAT
*from the files  FAOSTAT_CropProductionElementDefinition_3_12_2017.csv
*                FAOSTAT_CropsProcessedElementDefinition_3_12_2017.csv
/
"ha"
"hg/mt"
"tonnes"
"hg/ha"
/;

*1.2) Livestock Production
Set FAOSTAT_LivestockProductionUnits All units (such as "Head" or "hg") that may be used in livestock production in FAOSTAT
*from the files  FAOSTAT_LiveAnimalsElementDefinition_3_12_2017.csv
*                FAOSTAT_LivestockPrimaryElementDefinition_3_12_2017.csv
*                FAOSTAT_LivestockProcessedElementDefinition_3_12_2017.csv
/
"Head"
"1000 Head"
"No"
"hg/mt",""
"tonnes"
"1000 No"
"100mg/An"
"No/An"
"hg/An"
"hg"
"0.1g/An"
/;

*1.3) Trade
Set FAOSTAT_TradeUnits All units (such as "Head" or "tonnes") that may be used in trade data in FAOSTAT
*from the files  FAOSTAT_TradeDetailedTradeMatrixElementDefinition_3_12_2017.csv
*                FAOSTAT_TradeLiveAnimalsElementDefinition_3_12_2017.csv
*                FAOSTAT_TradeCropsAndLivestockProductsElementDefinition_3_12_2017.csv
/
"No"
"Head"
"1000 Head"
"Tonnes"
"1000 US$"
/;


*1.4) Food Balance Sheets
Set FAOSTAT_CommodityBalancesUnits All units (such as "kg" or "tonnes") that may be used in commodity balances in FAOSTAT
*from the files  FAOSTAT_CropCommodityBalancesElementDefinition_4_12_2017.csv
*                FAOSTAT_LivestockFishCommodityBalancesElementDefinition_4_12_2017.csv
*                FAOSTAT_CropFoodSupplyCommodityBalancesElementDefinition_4_12_2017.csv
*                FAOSTAT_LivestockFishFoodSupplyCommodityBalancesElementDefinition_4_12_2017.csv
*ATTENTION   the file: FAOSTAT_FoodBalanceSheetsItemDefinition_4_12_2017.csv
*ATTENTION       has the same elements, but the units used mostly are a factor of 1000 higher: 1000 tonnes, kg/capita/yr!!!!
*ATTENTION       This file has also one additional element with corresponding unit - POPULATION: 511,"Total Population - Both sexes","1000 persons","" - we do not include this here as it is a totally different variable -
*ATTENTION               but should be kept in mind in case one wants to file in this data
/
"tonnes"
"1000 tonnes"
"g/capita/day"
"kg/capita/yr"
"kcal/capita/day"
"kg"

*we add the following three, not provided in FAOSTAT, but we need them to derive these contents for the complex commodities, such as "Wheat and products",
*        where contents is not equal to the contents of commodities as displayed in nutritional tables (e.g. for wheat grain) but needs to be derived by dividing kcal supply etc. by quantities, as the contents depends on the country-/year-specific composition of these complex commodities
"t Protein/t"
"t Fat/t"
"kcal/t"
*and we need also the corresponding totals
"t Protein"
"t Fat"
"kcal"

/;

*1.5) Producer Price
Set FAOSTAT_ProducerPriceUnits All units (such as "USD") that may be used in producer price data in FAOSTAT
*from the files  FAOSTAT_ProducerPriceElementDefinition_20_12_2017.csv
/
"LCU"
*Unit of the "Producer Price (LCU/tonne)"; "Prices in local currency are nominal producer prices expressed in the local currency prevailing in the current year.
*        Thus currency changes can be observed as breaks in the series. Source: FAO Statistics Division"
"SLC"
*Unit of the "Producer Price (SLC/tonne)"; "The Standard Local Currency of a country is set as the local currency prevailing in the current year.
*        Prices in SLC are equal to producer prices in local currency multiplied by currency conversion factors.
*        Currency conversion factors (CCF) are a special kind of exchange rates that convert the new currency of a given country into the old currency of the same country.
*        These series are consistent over time and do not breaks when a currency change occurs. Source: FAO Statistics Division"
"USD"
*Unit of the "Producer Price (USD/tonne)"; "Prices in US Dollars are equal to producer prices in local currency times the exchange rate of the selected year.
*        The main exchange rates source used is the IMF. Where official and commercial exchange rates differ significantly, the commercial exchange rate may be applied. Source: FAO Statistics Division"
/;


