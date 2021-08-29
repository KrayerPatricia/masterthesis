PUTCLOSE con,"_V6_Sets_FAOSTAT_LandUse";

$ontext;
GENERAL DESCRIPTION
This file declares the sets where the FAOSTAT Land Use items are collected

DETAILED TABLE OF CONTENTS
the following sets are declared below:

- 1) FAO land use items, elements and units
         1.1)  FAO Land Use Items
         1.2)  FAO Land Use Elements
         1.3)  FAO Land Use Units

SHORT SUMMARY:
In this code file, the following sets are defined:
Set FAOSTAT_LandUSeItemCode All element codes that may be used in FAOSTAT
Set FAOSTAT_LandUseItems All land use item names that may be used in FAOSTAT
Set FAOSTAT_LandUseItemCodeAndItems(FAOSTAT_LandUSeItemCode,FAOSTAT_LandUseItems) Two dimensional set containing all land use item codes and names matched that may be used in FAOSTAT
Set FAOSTAT_LandUseElements All land use elements (such as "Area") that are used in FAOSTAT
Set FAOSTAT_LandUseUnits All land use units (such as "ha" or "million tonnes") that may be used in land use in FAOSTAT

$offtext;

*1) FAO land use items, elements and units
*1.1)  FAO Land Use Items

Set FAOSTAT_LandUSeItemCode All element codes that may be used in FAOSTAT
/6000*7000/;

Set FAOSTAT_LandUseItems All land use item names that may be used in FAOSTAT
*from the file FAOSTAT_LandUseItemDefinition_6_12_2017.csv
/
"Agricultural area"
"Agricultural area actually irrigated"
"Agricultural area certified organic"
"Agricultural area in conversion to organic"
"Agricultural area organic, total"
"Arable land"
"Arable land and Permanent crops"
"Arable land area certified organic"
"Arable land area in conversion to organic"
"Arable land organic, total"
"Area of arable land and permanent crops under protective cover"
"Country area"
"Fallow land (temporary)"
"Forest"
"Inland water"
"Land area"
"Other land"
"Other naturally regenerated forest"
"Perm. crops actually irrigated"
"Perm. crops non-irrigated"
"Perm. meadows & pastures - Cultivated"
"Perm. meadows & pastures - Nat. growing"
"Perm. meadows & pastures Cult. non-irrig"
"Perm. meadows and pastures - Cult. & actually irrig"
"Permanent crops"
"Permanent crops area certified organic"
"Permanent crops area in conversion to organic"
"Permanent crops organic, total"
"Permanent meadows and pastures"
"Permanent meadows and pastures area certified organic"
"Permanent meadows and pastures area in conversion to organic"
"Permanent meadows and pastures organic, total"
"Planted forest"
"Primary forest"
"Temp. crops actually irrigated"
"Temp. crops non-irrigated"
"Temp. meadows & pastures non-irrig."
"Temp. meadows and pastures actually irrigated"
"Temporary crops"
"Temporary meadows and pastures"
"Total area equipped for irrigation"
/;


Set FAOSTAT_LandUseItemCodeAndItems(FAOSTAT_LandUSeItemCode,FAOSTAT_LandUseItems) Two dimensional set containing all land use item codes and names matched that may be used in FAOSTAT
*from the file FAOSTAT_LandUseItemDefinition_6_12_2017.csv
*all this is always reported in 1000ha
/
6610."Agricultural area"
*        "Agricultural area, this category is the sum of areas under  “Arable land”, “Permanent crops” and “Permanent pastures”."
6611."Agricultural area actually irrigated"
*        "The total agricultural area that is actually irrigated in a given year. It refers to physical area: if the area is cultivated and irrigated more than once a year is counted only once."
6672."Agricultural area certified organic"
*        "Land area exclusively dedicated to organic agriculture and managed by applying organic agriculture methods. It refers to the land area fully converted to organic agriculture. It is the portion of land area (including arable lands, pastures or wild areas) managed (cultivated) or wild harvested in accordance with specific organic standards or technical regulations and that has been inspected and approved by a certification body."
6673."Agricultural area in conversion to organic"
*        "Agricultural area which is going through the organic conversion process, usually two years period of conversion to organic land."
6671."Agricultural area organic, total"
*        "Sum of areas under “Agricultural area certified organic” and ""Agricultural area in conversion to organic”."
6621."Arable land"
*        "Arable land is the land under temporary agricultural crops (multiple-cropped areas are counted only once), temporary meadows for mowing or pasture, land under market and kitchen gardens and land temporarily fallow (less than five years). The abandoned land resulting from shifting cultivation is not included in this category. Data for “Arable land” are not meant to indicate the amount of land that is potentially cultivable."
6620."Arable land and Permanent crops"
*        "Arable land and Permanent crops, this category is the sum of areas under “Arable land” and ""Permanent crops”."
6675."Arable land area certified organic"
*        "Part of the area of the ""Arable land"" exclusively dedicated to organic agriculture and managed by applying organic agriculture methods. It is the portion of land area managed (cultivated) or wild harvested in accordance with specific organic standards or technical regulations and that has been inspected and approved by a certification body."
6676."Arable land area in conversion to organic"
*        "Part of the area of the ""Arable land"" which is going through the organic conversion process, usually two years period of conversion to organic land."
6674."Arable land organic, total"
*        "Sum of areas under “Arable land certified organic” and ""Arable land area in conversion to organic”."
6774."Area of arable land and permanent crops under protective cover"
*        "Area of arable land and permanent crops under protective cover is the land under permanent structures with a roof of glass, plastic or other material used for protecting crops against the weather, pests or diseases. Such structures may be used for growing temporary or permanent crops. Structures to provide protection against the weather are known as “greenhouses”. It excludes: temporary devices for short-term protection, such as plastic covering to protect against frosts
6600."Country area"
*        "Country area, area of the country including area under inland water bodies, but excluding offshore territorial waters."
6640."Fallow land (temporary)"
*        "Fallow land (temporary) is the arable land that is not seeded for one or more growing seasons. Land is not considered temporarily fallow unless it has been, or is expected to be, kept at rest for at least one agricultural year. Fallow land temporarily used for grazing should be classified as “fallow” if the land is normally used for growing temporary crops. The maximum idle period is usually five years
6661."Forest"
*        "Forest area is the land spanning more than 0.5 hectares with trees higher than 5 metres and a canopy cover of more than 10 percent, or trees able to reach these thresholds in situ. It does not include land that is predominantly under agricultural or urban land use. Forest is determined both by the presence of trees and the absence of other predominant land uses. The trees should be able to reach a minimum height of 5 metres (m) in situ. Areas under reforestation that have not yet reached but are expected to reach a canopy cover of 10 percent and a tree height of 5 m are included, as are temporarily unstocked areas, resulting from human intervention or natural causes, which are expected to regenerate. Includes: areas with bamboo and palms provided that height and canopy cover criteria are met
6680."Inland water"
*        "Inland water is the area occupied by major rivers, lakes and reservoirs."
6601."Land area"
*        "Land area is the total area of the country excluding area under inland water."
6670."Other land"
*        "Other land is the land not classified as Agricultural land and Forest area. It includes built-up and related land, barren land, other wooded land, etc."
6717."Other naturally regenerated forest"
*        "Naturally regenerated forest where there are clearly visible indications of human activities.Explanatory notes:1. Includes selectively logged-over areas, areas regenerating following agricultural land use, areas recovering from human-induced fires, etc.2. Includes forests where it is not possible to distinguish whether planted or naturally regenerated.3. Includes forests with a mix of naturally regenerated trees and planted/seeded trees, and where the naturally regenerated trees are expected to constitute more than 50 percent of the growing stock at stand maturity."."".""."".""
6651."Perm. crops actually irrigated"
*        "Permanent crops irrigated, area of the ""Permanent crops"" which is actually irrigated in a given year."
6652."Perm. crops non-irrigated"
*        "Permanent crops non - irrigated, area of the ""Permanent crops"" which production relies on rainfed irrigation in a given year."
6656."Perm. meadows & pastures - Cultivated"
*        "Permanent meadows and pastures is the land used permanently (for a period of five years or more) for herbaceous forage crops that are managed and cultivated."^
6659."Perm. meadows & pastures - Nat. growing"
*        "Permanent meadows and pastures - Naturally growing is the land used permanently (for a period of five years or more) for herbaceous forage crops that is naturally growing."
6658."Perm. meadows & pastures Cult. non-irrig"
*        "Permanent meadows and pastures - Cultivated and non- irrigated, area of the ""Cultivated Permanent meadows and pastures"" which development relies on rainfed irrigation in a given year."
6657."Perm. meadows and pastures - Cult. & actually irrig"
*        "Permanent meadows and pastures - Cultivated and irrigated, area of the ""Cultivated Permanent meadows and pastures"" which is actually irrigated in a given year."
6650."Permanent crops"
*        "Permanent crops is the land cultivated with long-term crops which do not have to be replanted for several years (such as cocoa and coffee)
6678."Permanent crops area certified organic"
*        "Part of the area of the ""Permanent crops"" exclusively dedicated to organic agriculture and managed by applying organic agriculture methods. It is the portion of land area managed (cultivated) or wild harvested in accordance with specific organic standards or technical regulations and that has been inspected and approved by a certification body."
6679."Permanent crops area in conversion to organic"
*        "Part of the area of the ""Permanent crops"" which is going through the organic conversion process, usually two years period of conversion to organic land."
6677."Permanent crops organic, total"
*        "Sum of areas under “Permanent crops area certified organic” and ""Permanent crops area in conversion to organic”."
6655."Permanent meadows and pastures"
*        "Permanent meadows and pastures is the land used permanently (for a period of five years or more) for herbaceous forage crops, either cultivated or naturally growing. A period of five years or more is used to differentiate between permanent and temporary meadows."
6682."Permanent meadows and pastures area certified organic"
*        "Part of the area of the ""Permanent meadows and pastures"" exclusively dedicated to organic agriculture and managed by applying organic agriculture methods. It is the portion of land area managed (cultivated) or wild harvested in accordance with specific organic standards or technical regulations and that has been inspected and approved by a certification body."
6683."Permanent meadows and pastures area in conversion to organic"
*        "Part of the area of the ""Permanent meadows and pastures"" which is going through the organic conversion process, usually two years period of conversion to organic land."
6681."Permanent meadows and pastures organic, total"
*        "Sum of areas under “Permanent meadows and pastures area certified organic” and ""Permanent meadows and pastures area in conversion to organic”."
6716."Planted forest"
*        "Forest predominantly composed of trees established through planting and/or deliberate seeding.Explanatory notes1. In this context, predominantly means that the planted/seeded trees are expected to constitute more than 50 percent of the growing stock at maturity.2. Includes coppice from trees that were originally planted or seeded.3. Includes rubberwood, cork oak and Christmas tree plantations.4. Excludes self-sown trees of introduced species."
6714."Primary forest"
*        "Naturally regenerated forest of native species, where there are no clearly visible indications of human activities and the ecological processes are not significantly disturbed.Explanatory note:1. Some key characteristics of primary forests are:• they show natural forest dynamics, such as natural tree species composition, occurrence of dead wood, natural age structure and natural regeneration processes
6631."Temp. crops actually irrigated"
*        "Temporary crops irrigated, area of the ""Temporary crops"" which is actually irrigated in a given year."
6632."Temp. crops non-irrigated"
*        "Temporary crops non irrigated, area of the ""Temporary crops"" which production relies on rainfed irrigation in a given year."
6635."Temp. meadows & pastures non-irrig."
*        "Temporary meadows and pastures non- irrigated, area of the ""Temporary meadows and pastures"" which development relies on rainfed irrigation in a given year."
6634."Temp. meadows and pastures actually irrigated"
*        "Temporary meadows and pastures irrigated, area of the ""Temporary meadows and pastures"" which is actually irrigated in a given year."
6630."Temporary crops"
*        "Temporary crops is all land used for crops with a less than one-year growing cycle and which must be newly sown or planted for further production after the harvest."
6633."Temporary meadows and pastures"
*        "Temporary meadows and pastures is the land temporarily cultivated with herbaceous forage crops for mowing or pasture. A period of less than five years is used to differentiate between temporary and permanent meadows."
6690."Total area equipped for irrigation"
*        "Area equipped with irrigation infrastructure to provide water to the crops. This includes areas equipped for full and partial control irrigation, spate irrigation areas, and equipped wetland or inland valley bottoms."
/;


*1.2)  FAO Land Use Elements
Set FAOSTAT_LandUseElements All land use elements (such as "Area") that are used in FAOSTAT
*from the file   FAOSTAT_LandUseElementDefinition_6_12_2017.csv
/
"Area"
*        "1000 ha","Extent of surface of land or water. Source: FAO Statistics Division"
"Carbon stock in living biomass"
*        "million tonnes","Carbon in living biomass (above ground and below ground). Data currently available for Forest (item 6661) only.Further information: FAO FRA 2015 Terms and Definitions.
*        Available at http://www.fao.org/docrep/017/ap862e/ap862e00.pdf Source: FAO Statistics Division"
/;


*1.3) FAO Land Use Units
Set FAOSTAT_LandUseUnits All land use units (such as "ha" or "million tonnes") that may be used in land use in FAOSTAT
*from the file   FAOSTAT_LandUseElementDefinition_6_12_2017.csv
/
ha
"1000 ha"
"million tonnes"
/;
