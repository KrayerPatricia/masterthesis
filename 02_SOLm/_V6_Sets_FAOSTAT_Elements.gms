PUTCLOSE con,"_V6_Sets_FAOSTAT_Elements";

$ontext;
GENERAL DESCRIPTION
This file declares all the sets with elements needed in the model for reading FAOSTAT production, trade food balance and land use data.
"Elements" are, grossly speaking" parameter and variables of interest, such as "yield" or "import quantity" (for further examples see below).

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
Set FAOSTAT_ElementCode All element codes that may be used in FAOSTAT
Set FAOSTAT_CropProductionElements All crop production elements (such as "area harvested" or "yield") that are used in FAOSTAT
Set FAOSTAT_LivestockProductionElements All livestock production elements (such as "Stocks" or "yield") that are used in FAOSTAT
Set FAOSTAT_TradeElements All trade elements (such as "Import Quantity") that are used in FAOSTAT
Set FAOSTAT_CommodityBalancesElements All commodity balances elements (such as "Domestic supply quantity" or "Waste") that are used in FAOSTAT
Set FAOSTAT_ProducerPriceElements All producer price elements (such as "Producer Price") that are used in FAOSTAT

$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Reading FAOASTAT data
*the following declares various sets that are needed for reaing in FAOSTAT data

Set FAOSTAT_ElementCode All element codes that may be used in FAOSTAT
/5000*6000/;

*1.1) Crop Production
Set FAOSTAT_CropProductionElements All crop production elements (such as "area harvested" or "yield") that are used in FAOSTAT
*from the files  FAOSTAT_CropProductionElementDefinition_3_12_2017.csv
*                FAOSTAT_CropsProcessedElementDefinition_3_12_2017.csv
/
"Area harvested"
*        "ha"
*        "Data refer to the area from which a crop is gathered.
*        Area harvested, therefore, excludes the area from which, although sown or planted, there was no harvest due to damage, failure, etc.
*        It is usually net for temporary crops and some times gross for permanent crops.
*        Net area differs from gross area insofar as the latter includes uncultivated patches, footpaths, ditches, headlands, shoulders, shelterbelts, etc.
*        If the crop under consideration is harvested more than once during the year as a consequence of successive cropping (i.e. the same crop is sown or planted more than once in the same field during the year),
*                the area is counted as many times as harvested.
*        On the contrary, area harvested will be recorded only once in the case of successive gathering of the crop during the year from the same standing crops.
*        With regard to mixed and associated crops, the area sown relating to each crop should be reported separately.
*        When the mixture refers to particular crops, generally grains, it is recommended to treat the mixture as if it were a single crop.
*                Therefore, area sown is recorded only for the crop reported. Source: FAO Statistics Division"
"Extraction Rate"
*        "hg/mt"
"Production"
*        "tonnes"
*        "Amount produced in the year"
"Seed"
*        "tonnes"
*        "Data include the amounts of the commodity in question set aside for sowing or planting (or generally for reproduction purposes, e.g. sugar cane planted, potatoes for seed, eggs for hatching and fish for bait, whether domestically produced or imported) during the reference period. Account is taken of double or successive sowing or planting whenever it occurs. The data of seed include also, when it is the case, the quantities necessary for sowing or planting the area relating to crops harvested green for fodder or for food.(e.g. green peas, green beans, maize for forage)  Data for seed element are stored in tonnes (t). Whenever official data were not available, seed figures have been estimated either as a percentage of supply (e.g. eggs for hatching) or by multiplying a seed rate with the area under the crop of the subsequent year. Source: FAO. 1986. The ICS users' manual. Interlinked computer strorage and processing system of food and agricultural commodity data. Rome."
"Yield"
*        "hg/ha"
*        "Harvested production per unit of harvested area for crop products. In most of the cases yield data are not recorded but obtained by dividing the production data by the data on area harvested. Data on yields of permanent crops are not as reliable as those for temporary crops either because most of the area information may correspond to planted area, as for grapes, or because of the scarcity and unreliability of the area figures reported by the countries, as for example for cocoa and coffee. Source: FAO Statistics Division"
/;

*1.2) Livestock Production
Set FAOSTAT_LivestockProductionElements All livestock production elements (such as "Stocks" or "yield") that are used in FAOSTAT
*from the files  FAOSTAT_LiveAnimalsElementDefinition_3_12_2017.csv
*                FAOSTAT_LivestockPrimaryElementDefinition_3_12_2017.csv
*                FAOSTAT_LivestockProcessedElementDefinition_3_12_2017.csv
/
"Stocks"
*        "This variable indicates the number of animals of the species present in the country at the time of enumeration.
*        It includes animals raised either for draft purposes or for meat, eggs and dairy production or kept for breeding.
*        Live animals in captivity for fur or skin such as foxes, minks etc. are not included in the system although furskin trade is reported.
*        The enumeration to be chosen, when more than one survey is taken, is the closest to the beginning of the calendar year.
*        Livestock data are reported in number of heads (units) except for poultry, rabbits and other rodents which are reported in thousand units. Source: FAO Statistics Division"
"Extraction Rate"
"Laying"
"Milk Animals"
"Prod Popultn"
"Producing Animals/Slaughtered"
"Production"
*        tonnes:
*        "Amount produced in the year"
*        Head; 1000 Head; No, etc.:
*        "Figures relate to the total domestic production whether inside or outside the agricultural sector, i.e. it includes non-commercial production and production from kitchen gardens.
*        Unless otherwise indicated, production is reported at the farm level for crop and livestock products (i.e. in the case of crops, excluding harvesting losses)
*                and in terms of live weight for fish items (i.e. the actual ex-water weight at the time of the catch).
*        All data shown relate to total meat production from both commercial and farm slaughter. Data are expressed in terms of dressed carcass weight, excluding offal and slaughter fats.
*        Production of beef and buffalo meat includes veal mutton and goat meat includes meat from lambs and kids, pig meat includes bacon and ham in fresh equivalent.
*        Poultry meat includes meat from all domestic birds and refers, wherever possible, to ready-to-cook weight. Source: FAO Statistics Division"
"Yield"
"Yield/Carcass Weight"
/;

*1.3) Trade
Set FAOSTAT_TradeElements All trade elements (such as "Import Quantity") that are used in FAOSTAT
*from the files  FAOSTAT_TradeDetailedTradeMatrixElementDefinition_3_12_2017.csv
*                FAOSTAT_TradeLiveAnimalsElementDefinition_3_12_2017.csv
*                FAOSTAT_TradeCropsAndLivestockProductsElementDefinition_3_12_2017.csv
/
"Export Quantity"
"Import Quantity"
"Export Value"
"Import Value"
/;


*1.4) Food Balance Sheets
Set FAOSTAT_CommodityBalancesElements All commodity balances elements (such as "Domestic supply quantity" or "Waste") that are used in FAOSTAT
*from the files  FAOSTAT_CropCommodityBalancesElementDefinition_4_12_2017.csv
*                FAOSTAT_LivestockFishCommodityBalancesElementDefinition_4_12_2017.csv
*                FAOSTAT_CropFoodSupplyCommodityBalancesElementDefinition_4_12_2017.csv
*                FAOSTAT_LivestockFishFoodSupplyCommodityBalancesElementDefinition_4_12_2017.csv
*ATTENTION   the file: FAOSTAT_FoodBalanceSheetsElementDefinition_4_12_2017.csv
*ATTENTION       has the same elements, but the units used mostly are a factor of 1000 higher: 1000 tonnes, kg/capita/yr!!!!
*ATTENTION       This file has also one additional element with corresponding unit - POPULATION: 511,"Total Population - Both sexes","1000 persons","" - we do not include this here as it is a totally different variable -
*ATTENTION               but should be kept in mind in case one wants to file in this data
/
"Domestic supply quantity"
*        "Production + imports - exports + changes in stocks (decrease or increase) = supply for domestic utilization.
*        There are various ways of defining supply and, in fact, various concepts are in use. The elements involved are production, imports, exports and changes in stocks (increase or decrease).
*        There is no doubt that production, imports and stock changes (either decrease or increase in stocks) are genuine supply elements. Source: FAO Statistics Division"
"Export Quantity"
*        "Amount exported in the year"
"Feed"
*        "Data refer to the quantity of the commodity in question available for feeding to the livestock and poultry during the reference period, whether domestically produced or imported.
*        Source: FAO. 1986. The ICS users' manual. Interlinked computer strorage and processing system of food and agricultural commodity data. Rome."
"Food supply quantity (tonnes)"
"Import Quantity"
*        "Amount imported in the year"
"Waste"
*this is named "losses" in the dewscription of the elements, but in the data it is reported as "waste"
"Losses"
*        "Amount of the commodity in question lost through wastage (waste) during the year at all stages between the level at which production is recorded and the household,
*        i.e. storage and transportation. Losses occurring before and during harvest are excluded. Waste from both edible and inedible parts of the commodity occurring in the household is also excluded.
*        Quantities lost during the transformation of primary commodities into processed products are taken into account in the assessment of respective extraction/conversion rates.
*        Distribution wastes tend to be considerable in countries with hot humid climate, difficult transportation and inadequate storage or processing facilities.
*        This applies to the more perishable foodstuffs, and especially to those which have to be transported or stored for a long time in a tropical climate.
*        Waste is often estimated as a fixed percentage of availability, the latter being defined as production plus imports plus stock withdrawals.
*        Source: FAO. 1986. The ICS users' manual. Interlinked computer strorage and processing system of food and agricultural commodity data. Rome."
"Other uses"
*        "Data refer to quantities of commodities used for non-food purposes, e.g. oil for soap. In order not to distort the picture of the national food pattern quantities of the commodity in question
*        consumed mainly by tourists are included here (see also ""Per capita supply""). In addition, this variable covers pet food.
*        Source: FAO. 1986. The ICS users' manual. Interlinked computer strorage and processing system of food and agricultural commodity data. Rome."
"Processing"
"Production"
*        "Amount produced in the year"
"Seed"
*        "Data include the amounts of the commodity in question set aside for sowing or planting (or generally for reproduction purposes,
*        e.g. sugar cane planted, potatoes for seed, eggs for hatching and fish for bait, whether domestically produced or imported) during the reference period.
*        Account is taken of double or successive sowing or planting whenever it occurs. The data of seed include also, when it is the case,
*        the quantities necessary for sowing or planting the area relating to crops harvested green for fodder or for food.(e.g. green peas, green beans, maize for forage)
*         Data for seed element are stored in tonnes (t). Whenever official data were not available, seed figures have been estimated either as a percentage of supply
*        (e.g. eggs for hatching) or by multiplying a seed rate with the area under the crop of the subsequent year. Source: FAO. 1986. The ICS users' manual.
*        Interlinked computer strorage and processing system of food and agricultural commodity data. Rome."
"Stock Variation"
*        "Comprises changes in stocks occurring during the reference period at all levels between the production and the retail levels, i.e. it comprises changes in government stocks,
*        in stocks with manufacturers, importers, exporters, other wholesale and retail merchants, transport and storage enterprises and in stocks on farms.
*        In actual fact, however, the information available often relates only to stocks held by governments and even these are not available for a number of countries and important commodities.
*        In the absence of information on opening and closing stocks changes in stocks are also used for shifting production from the calendar year in which it is harvested to the year in which it is consumed.
*        Net increases in stocks (add to stock) are generally indicated by the sign ""-"". No sign denotes net decreases (from stock). Source: FAO Statistics Division"
"Fat supply quantity (g/capita/day)"
"Food supply (kcal/capita/day)"
"Food supply quantity (g/capita/day)"
"Food supply quantity (kg/capita/yr)"
"Protein supply quantity (g/capita/day)"

*we add the following three, not provided in FAOSTAT, but we need them to derive these contents for the complex commodities, such as "Wheat and products",
*        where contents is not equal to the contents of commodities as displayed in nutritional tables (e.g. for wheat grain) but needs to be derived by dividing kcal supply etc. by quantities, as the contents depends on the country-/year-specific composition of these complex commodities
"Protein contents (t/t)"
"Fat contents (t/t)"
"kcal contents (kcal/t)"
*and we need also the corresponding totals
"Protein supply (t)"
"Fat supply (t)"
"kcal supply (kcal)"
/;

*1.5) Producer Price
Set FAOSTAT_ProducerPriceElements All producer price elements (such as "Producer Price") that are used in FAOSTAT
*from the files  FAOSTAT_ProducerPriceElementDefinition_20_12_2017.csv
/
"Producer Price (LCU/tonne)"
*Unit: "LCU"; "Prices in local currency are nominal producer prices expressed in the local currency prevailing in the current year.
*        Thus currency changes can be observed as breaks in the series. Source: FAO Statistics Division"
"Producer Price (SLC/tonne)"
*Unit: "SLC"; "The Standard Local Currency of a country is set as the local currency prevailing in the current year.
*        Prices in SLC are equal to producer prices in local currency multiplied by currency conversion factors.
*        Currency conversion factors (CCF) are a special kind of exchange rates that convert the new currency of a given country into the old currency of the same country.
*        These series are consistent over time and do not breaks when a currency change occurs. Source: FAO Statistics Division"
"Producer Price (USD/tonne)"
*Unit: "USD"; "Prices in US Dollars are equal to producer prices in local currency times the exchange rate of the selected year.
*        The main exchange rates source used is the IMF. Where official and commercial exchange rates differ significantly, the commercial exchange rate may be applied. Source: FAO Statistics Division"
/;


