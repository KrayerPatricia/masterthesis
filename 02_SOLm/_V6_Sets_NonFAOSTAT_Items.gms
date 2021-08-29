PUTCLOSE con,"_V6_Sets_NonFAOSTAT Items";

$ontext;
GENERAL DESCRIPTION
This file declares additional sets for activity and commodity items that are currently not covered under FAOSTAT, but have once been (fodder crops) or are other most basic amendments to FAOSTAT items (algae, etc).
depending on the data sources used, this is then adapted

DETAILED TABLE OF CONTENTS
the following sets are declared below:
- 1) Additional activities and commodities used in the model
         -1.1) Crop production
                 1.1a) Primary crop production
                 1.1b) Crops processed
         -1.2) Animal production
                 1.2a) Livestock primary
                 1.2b) Livestock live animals
                 1.2c) Livestock Processed
         -1.3) Commodity Trade
                 1.3a) Detailed Trade Matrix
                 1.3b) Trade in live animals
                 1.3c) Trade in crop and livestock products
         -1.4) Food Balance Sheets
                 1.4a) Crop commodity balances - primary crop product equivalent
                 1.4b) Livestock/Fish commodity balances - primary product equivalent

SHORT SUMMARY:
In this code file, the following NON-FAOSTAT sets are defined:
Set NON_FAOSTAT_CropProductionItems Additional crop item names that may be used and are NOT part of FAOSTAT
Set NON_FAOSTAT_GrassActivities(NON_FAOSTAT_CropProductionItems) Sub-set containing all grass item names that may be used and are NOT part of FAOSTAT
Set NON_FAOSTAT_LivestockPrimaryItems Additional livestock primary item names that may be used and are NOT part of FAOSTAT
Set NON_FAOSTAT_LiveAnimalsItems Additional live animal item names that may be used and are NOT part of FAOSTAT
Set NON_FAOSTAT_TradeLiveAnimalsItems Additional live animal item names that may be used in the live animal trade matrix but are NOT part of FAOSTAT
Set NON_FAOSTAT_LivestockFishCommodityBalancesItems Additional commodity balances livestock and fish items that are NOT part of FAOSTAT

$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Additional activities and commodities used in the model
*1.1) Crop production
*1.1a) Primary crop production
Set NON_FAOSTAT_CropProductionItems Additional crop item names that may be used and are NOT part of FAOSTAT - also covers grass
/

$ontext;
In FAOSTAT, but currently not available:
635         "Straw husks"
636         "Forage and silage, maize"
637         "Forage and silage, sorghum"
638         "Forage and silage, rye grass"
639         "Forage and silage, grasses nes"
640         "Forage and silage, clover"
641         "Forage and silage, alfalfa"
642         "Forage and silage, green oilseeds"
643         "Forage and silage, legumes"
644         "Cabbage for fodder"
645         "Mixed Grasses and Legumes"
646         "Turnips for fodder"
647         "Beets for fodder"
648         "Carrots for fodder"
649         "Swedes for fodder"
651         "Forage products"
652         "Feed, vegetable products nes"
653         "Food wastes"
654         "Dregs from brewing, distillation"
655         "Vegetables and roots fodder"
$offtext;

"Maize For Forage+Silage"
"Alfalfa For Forage+Silag"
"Clover For Forage+Silage"
"Leguminous Nes,For+Sil"
"Forage Products Nes"

*other fodder crops
"Beets For Fodder"
"Swedes For Fodder"
"Turnips For Fodder"
"Vegetables+Roots,Fodder"

Fallows

"Grass"

"Temporary meadows and pastures"
"Permanent meadows and pastures"

"temporary grasslands"
"permanent grasslands"
"alpine pastures"

"Pure legume sward"
Grassclass1
Grassclass2
Grassclass3
Grassclass4
/;

*sometimes, a specific assignment to grass activities is needed, thus collect all of those in one set to be able to address all of those at once:
Set NON_FAOSTAT_GrassActivities(NON_FAOSTAT_CropProductionItems) Sub-set containing all grass item names that may be used and are NOT part of FAOSTAT
/
"Grass"

"Temporary meadows and pastures"
"Permanent meadows and pastures"

"temporary grasslands"
"permanent grasslands"
"alpine pastures"

Grassclass1
Grassclass2
Grassclass3
Grassclass4
/;


*1.1b) Crops processed
*Set NON_FAOSTAT_CropsProcessedItems
*/
*/;

*1.2) Animal production
*1.2a) Livestock primary
Set NON_FAOSTAT_LivestockPrimaryItems Additional livestock primary item names that may be used and are NOT part of FAOSTAT
/
"Meat indigenous, game"
"Meat, game"
Insects
/;

*1.2b) Livestock live animals
Set NON_FAOSTAT_LiveAnimalsItems Additional live animal item names that may be used and are NOT part of FAOSTAT
/
Game
Insects
Silkworms
/;

*1.2c) Livestock Processed
*Set NON_FAOSTAT_LivestockProcessedItems
*/
*/;

*1.3) Commodity Trade
*1.3a) Detailed Trade Matrix
*Set NON_FAOSTAT_DetailedTradeMatrixItems
*/
*/;

*1.3b) Trade in live animals
Set NON_FAOSTAT_TradeLiveAnimalsItems Additional live animal item names that may be used in the live animal trade matrix but are NOT part of FAOSTAT
/
Game
Insects
Silkworms
/;

*1.3c) Trade in crop and livestock products
*Set NON_FAOSTAT_TradeCropsAndLivestockProductsItems
*/
*/;

*1.4) Food Balance Sheets
*1.4a) Crop commodity balances - primary crop product equivalent
*Set NON_FAOSTAT_CropCommodityBalancesItems
*/
*/;

*1.4b) Livestock/Fish commodity balances - primary product equivalent
Set NON_FAOSTAT_LivestockFishCommodityBalancesItems Additional commodity balances livestock and fish items that are NOT part of FAOSTAT
/
Algae
*        algae is under fish, as aquatic plants, etc.
/;



