PUTCLOSE con,"_V6_Sets_FAOSTAT_Fertilizers";

$ontext;
GENERAL DESCRIPTION
This file declares the sets that are needed to read FAOSTAT fertilizer data (items, elements and units)

DETAILED TABLE OF CONTENTS
the following sets are declared below:
- 1)  FAOSTAT fertilizer data

SHORT SUMMARY:
In this code file, the following sets are defined:
Set FAOSTAT_FertilizerItems Fertilizer items (such as "ammonium nitrate (AN)" etc.) used in FAOSTAT
Set FAOSTAT_FertilizerElements Fertilizer elements (such as "Export quantity" etc.) used in FAOSTAT
Set FAOSTAT_FertilizerUnits Fertilizer units (e.g. "tons") used in FAOSTAT

SOME COMMENTS
Currently, we have the data from 2002 onwards only in the model; the data structure is different (different items) for the years up to 2002 and we did not yet load those.
This older data is available from "Fertilizers archive" under "Inputs" on the FAOSTAT "Data"-site (comment from 12.12.2017).

ATTENTION
in FAOSTAT, P2O5 and K2O are written with "0" /zero!!) instead of "O" (capital o)!!!!

$offtext;


*MODEL CODE:
****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) FAOSTAT fertilizer data

Set FAOSTAT_FertilizerItems Fertilizer items (such as "ammonium nitrate (AN)" etc.) used in FAOSTAT
*from the file FAOSTAT_FertilizerItemDefinition_12_12_2017.csv
/
"Ammonia, anhydrous"
*        "(NH3) is a material mostly produced by the synthetic process and at standard temperature and pressure is a gas. Fertilizer grade anhydrous ammonia contains about 82% of nitrogen.
"Ammonium nitrate (AN)"
*        "(NH<sub>4</sub>NO<sub>3</sub>), is produced by neutralizing nitric acid (HNO<sub>3</sub>) with ammonia (NH<sub>3</sub>).
*        Ammonium nitrate may be in white or off-white granular or prilled form and coated with a suitable material to prevent absorption of moisture and caking in storage.
*        Pure ammonium nitrate may have a total nitrogen content of about 35%, of which one-half is present as ammoniac nitrogen and the other half as nitrate nitrogen."
"Ammonium sulphate"
*        "(NH4)2SO4, is produced by reacting ammonia with sulphuric acid (H2SO4). It is produced as fine white granules or crystals and contains not less than 20.6% nitrogen in ammoniac form.
"Calcium ammonium nitrate"
*        "NH<sub>4</sub>NO<sub>3</sub>+CaCO<sub>3</sub>, is produced from ammonium nitrate and finely pulverized calcium carbonate (CACO<sub>3</sub>).
*        It contains not less than 20.5% and up to 28% of nitrogen, half of which is in the form of ammoniac nitrogen and the other half in the form of nitrate nitrogen.
*        It is produced as white, off-white or grey granules or prills."
"Diammonium phosphate (DAP)"
*        "(NH4)2HPO4, is produced by evaporating a solution of phosphoric acid with excess of ammonia."
"Monoammonium phosphate (MAP)"
*        "NH4H2PO4, is formed when a solution of phosphoric acid is added to ammonia until the solution is distinctly acid."
"NPK blends"
*        "Consist of two or more intermediate granular fertilizer materials of matching physical characteristics blended together."
"NPK complex"
*        "Can be produced as the result of a chemical reaction of nitric acid on phosphate rock – the nitrophosphate route,
*        with or without added ammonia and/or phosphoric and/or sulfuric acid or between sulfuric acid and ammonia – the ammoniation route.
"NPK complex <=10kg"
*        "Can be produced as the result of a chemical reaction of nitric acid on phosphate rock – the nitrophosphate route,
*        with or without added ammonia and/or phosphoric and/or sulfuric acid or between sulfuric acid and ammonia – the ammoniation route.
"NPK complex >10kg"
*        "Can be produced as the result of a chemical reaction of nitric acid on phosphate rock – the nitrophosphate route,
*        with or without added ammonia and/or phosphoric and/or sulfuric acid or between sulfuric acid and ammonia – the ammoniation route.
"Nutrient nitrogen N (total)"
*        "Total nitrogen (N) from all fertilizer products"
"Nutrient phosphate P205 (total)"
*        "Total phosphate (P2O5) from all fertilizer products"
"Nutrient potash K20 (total)"
*        "Total potash (K2O) from all fertilizer products"
"Other nitrogen & phosphates compounds"
*        "Can be produced as the result of a chemical reaction of nitric acid on phosphate rock, with or without added ammonia and/or phosphoric and/or sulfuric acid or between sulfuric acid and ammonia.
*        or by simple mechanical mixing or blending. Other NP compound may also include some AN grades with small amounts of phosphates."
"Other nitrogen & phosphorus compounds"
*        "Can be produced as the result of a chemical reaction of nitric acid on phosphate rock, with or without added ammonia and/or phosphoric and/or sulfuric acid or between sulfuric acid and ammonia.
*        or by simple mechanical mixing or blending. Other NP compound may also include some AN grades with small amounts of phosphates."
"Other NP compounds"
*        "Can be produced as the result of a chemical reaction of nitric acid on phosphate rock, with or without added ammonia and/or phosphoric and/or sulfuric acid or between sulfuric acid and ammonia.
*        or by simple mechanical mixing or blending. Other NP compound may also include some AN grades with small amounts of phosphates."
"Phosphate rock"
*        "Is a natural rock containing one or more calcium phosphate minerals of sufficient purity and quantity as to permit its use directly after grinding
*        or after chemical processing in the manufacture of commercial phosphate fertilizers."
"PK compounds"
*        "These comprise mixtures of superphosphate or basic slag or ground phosphate rock with straight potash products.
*        PK compounds produced as a result of a chemical reaction are not produced for fertilizer usage."
"Potassium chloride (muriate of potash) (MOP)"
*        "Is refined from mined, low-grade naturally occurring ores as the mineral sylvite and in combination with sodium chloride as sylvinite. Potassium chloride contains from about 48 to 62 % K20."
"Potassium nitrate"
*        "KNONH3H2PO4 can be produced from naturally occurring sodium nitrate and potassium chloride and typically contains 13%N and 45% K2O."
"Potassium sulphate (sulphate of potash) (SOP)"
*        "Is a white crystalline salt and contains 48 to 52 per cent potash (K20). Potassium sulfate can be extracted from naturally occurring brines or by the decomposition of potassium chloride with sulfuric acid."
"Superphosphate"
*        "Superphosphate is a fertilizer produced by the action of concentrated sulfuric acid on powdered phosphate rock."
"Superphosphate above 35%"
*        "Is produced by the action of sulphuric and phosphoric acids on ground phosphate rock."
"Superphosphate other"
*        "Is produced by the action of concentrated sulphuric acid on ground phosphate rock."
"Urea"
*        "CO(NH2)2, is produced from synthetic ammonia and carbon dioxide (CO2) and contains 46% nitrogen in ammoniac form. Urea may be in granular, prilled or crystalline form."
"Urea and ammonium nitrate solutions (UAN)"
*        "Are produced from concentrated solutions of urea and ammonium nitrate by chemical or blending processes."

*and we add the following, as it is in the data downloaded, but not listed in the element set provided by FAOSTAT!!!
*part is covered above - but with a slighly different term - e.g. with a bracket including the abbreviation - but in the data, the one without defined below is used
"Nitrogen Fertilizers (N total nutrients)"
"Phosphate Fertilizers (P205 total nutrients)"
"Potash Fertilizers (K20 total nutrients)"
"Ammonium nitrate"
"Potassium chloride (Muriate of potash)"
"Potassium sulphate"
"Urea and ammonium nitrate solutions"
/;


Set FAOSTAT_FertilizerElements Fertilizer elements (such as "Export quantity" etc.) used in FAOSTAT
*from the file FAOSTAT_FertilizerElementDefinition_12_12_2017.csv
/
"Agricultural Use"
*        "tonnes","Amount used in the agricultural sector in the year"
"Agricultural Use in nutrients"
*        "tonnes of nutrients",""
"Export Quantity"
*        "tonnes","Amount exported in the year"
"Export Quantity in nutrients"
*        "tonnes of nutrients",""
"Import Quantity"
*        "tonnes","Amount imported in the year"
"Import Quantity in nutrients"
*        "tonnes of nutrients",""
"Other Uses"
*        "tonnes","Amount used outside the agricultural sector in the year"
"Other Uses in nutrients"
*        "tonnes of nutrients",""
"Production"
*        "tonnes","Amount produced in the year"
"Production Quantity in nutrients"
*        "tonnes of nutrients",""
*and we add the following, as it is in the data downloaded, but not listed in the element set provided by FAOSTAT!!!
"Consumption"
"Consumption in nutrients"
/;


Set FAOSTAT_FertilizerUnits Fertilizer units (e.g. "tons") used in FAOSTAT
*from the file FAOSTAT_FertilizerElementDefinition_12_12_2017.csv
/
tonnes
"tonnes of nutrients"
/;


















