PUTCLOSE con,"_V6_ReadData_VariousSources_CropResidueManagementData";

$ontext;
GENERAL DESCRIPTION
This file assigns the values needed for crop residue management calculations and related emissions


DETAILED TABLE OF CONTENTS
- 1) Crop residue management system shares
- 2) Crop residue management emissions parameters - IPCC 2006
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;



*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************


*The following code runs quite long (in section 3.2, first assignment with 3 matching files); thus, read in the gdx-file produced at the end in case nothing changed here. Otherwise execute the code.
$if %ReadNewCropResManData% == "NO" $goto UseOldCropResManData



*1) Crop residue management system shares


*ATTENTION!! THIS DATA IS for convent and organic only, NOT FOR AverageProdType


$ontext;
the following addresses crop residues quantities and their storage and management systems, etc.
for this, use the specific parameter "CropResiduesManagement"

first, assign quantity shares in this new parameter;
unit: share, i.e. percentage/100
Assume some values for crop residue managemnt system shares:
thereof, LeftOnTheField, Feed come without management emissions (LeftOnTheField has then emissions as fertilizer application, though!)
check with experts, but for now assume for conventional 0% to be composted, 90% to be left on the field, 10% openly burned (cf. just below for a reference)
in organic it is 50% compost, 50% left on the field
How FAOSTAT calculates: faostat.fao.org/Portals/_Faostat/documents/pdf/CropResidues.pdf
        This biomass N amount is then reduced by the fraction of crop residue burnt on site
        assumed to be 10% by area, following IPCC, 2000: Ch. 4, Section 4A.2.1.1
        with specified combustion coefficients by crop, as per IPCC, 2006: Vol.4, Ch. 2, Tab. 2.6.
        Finally, all N in crop residues, net of amount burnt, is assumed to remain on the field, as per IPCC, 2006: Vol.4, Ch. 11, Eq. 11.6.
TO BE REFINED!
$offtext;


Set PerTonCropResParameter
/
"Quantity share in CropResMan system"
"Crop res man CH4 (tCH4/t crop res)"
"Crop res man N2O (tN2O/t crop res)"
"Crop res man N loss (tN/t crop res)"
"Crop res N for areas (tN/t crop res)"
"Crop res man share P lost (tP2O5/tP2O5 in crop res)"
"Crop res man P loss (tP2O5/t crop res)"
"Crop res P for areas (tP2O5/t crop res)"
/;


*unit: share, i.e. percentage/100
Parameter CropResidueManagement_VariousSources(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,PerTonCropResParameter,CropResManSystem,ProductionSystems);
Parameter GrassResidueManagement_VariousSources(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_GrassActivities,PerTonCropResParameter,CropResManSystem,ProductionSystems);
*originally, these parameters were defined with CropResidueManParameter and CropResidueManSystem, and then matched to SOLmV5 parameters - but we define them already with SOLmV5 to reduce
*        such matching code which takes much time

CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Left on croplands","Convent") = 0.88;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Open burning","Convent") = 0.1;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Composting","Convent") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Feed","Convent") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Livestock bedding","Convent") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Biogas","Convent") = 0.02;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Cooking","Convent") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Dumped","Convent") = 0;

CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Left on croplands","Organic") = 0.5;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Open burning","Organic") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Composting","Organic") = 0.48;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Feed","Organic") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Livestock bedding","Organic") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Biogas","Organic") = 0.02;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Cooking","Organic") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Dumped","Organic") = 0;

*as on this level, we also - and in particular! - need the AverageProdType values, just assign those as well:
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Left on croplands","AllProdSyst") = 0.83;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Open burning","AllProdSyst") = 0.09;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Composting","AllProdSyst") = 0.06;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Feed","AllProdSyst") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Livestock bedding","AllProdSyst") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Biogas","AllProdSyst") = 0.02;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Cooking","AllProdSyst") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Dumped","AllProdSyst") = 0;


$ontext;

DO THIS LATER, when loading better data or in scenarios, as residue data and feed data are both quite shaky in the default baseline. No need to adapt here.

*adapt for countries with residues in feeding rations: take part of crop res man as feed instead of left on field:
*to keep it simpel, just start with allocating a share of 10% of the share of residues in cattle feeding rations to the crop res man as feed, correspondingly reducing the allocation to "left on the field":
*ATTENTION: TO BE IMPROVED!
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Feed",ProdSyst_OrgConAll)
         = VariousSources_FeedingRationsData(FAOSTAT_Countries,"Cattle","ShareResidues")
                 *0.1;

CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Left on croplands",ProdSyst_OrgConAll)
                 $((CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Left on croplands",ProdSyst_OrgConAll)
                 - CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Feed",ProdSyst_OrgConAll)) >= 0)
         = CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Left on croplands",ProdSyst_OrgConAll)
                 - CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Quantity share in CropResMan system","Feed",ProdSyst_OrgConAll);
$offtext;


*And assign values for grasslands:
*by definition, the biuomass remaining on grasslands after harvesting for feed or whatever use and after grazing is the residues; thus all residues are left on the grasslands
GrassResidueManagement_VariousSources(FAOSTAT_Countries,NON_FAOSTAT_GrassActivities,"Quantity share in CropResMan system","Left on grasslands",ProdSyst_OrgConAll) = 1;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Crop residue management emissions parameters - IPCC 2006


*emissions from residues management according to IPCC 2006, vol 5, chapter 4, Table 4.1:
*emissions fro biomass burned: vol4, chapter 2, table 2.5

$ontext;
*the possible management systems are: Composting, LeftOnTheField, Biogas, OpenBurning, Cooking, Feed, Dumped, Livestock bedding

TABLE 4.1 DEFAULT EMISSION FACTORS FOR CH4 AND N2O EMISSIONS FROM BIOLOGICAL TREATMENT OF WASTE
Type of biological treatment     CH4 Emission Factors                              N2O Emission Factors
                                 (g CH4/kg waste treated)                         (g N2O/kg waste treated)

Remarks               on a dry weight basis   on a wet weight basis        on a dry weight basis    on a wet weight basis
Composting                10 (0.08 - 20)            4 (0.03 - 8)              0.6 (0.2 - 1.6)          0.24 (0.06 - 0.6)

Assumptions on the waste treated:
25-50% DOC in dry matter, 2% N in dry matter, moisture content 60%.

The emission factors for dry waste are estimated from those for wet waste assuming a moisture content of 60% in wet waste.
Anaerobic digestion at biogas facilities
                         2 (0 - 20)                0.8 (0 - 8)              Assumed negligible         Assumed negligible
*values for the other Crop res man systems are not displayed here - see original source indicated above
$offtext;

*we use the above emission factors per wet weight in tons per ton waste
*unit: t emission per t WET weight

CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man CH4 (tCH4/t crop res)","Composting","AllProdSyst") = 0.004;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man CH4 (tCH4/t crop res)","Left on croplands","AllProdSyst") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man CH4 (tCH4/t crop res)","Biogas","AllProdSyst") = 0.0008;
*burning: derived from 0.0027 * DM contents 0.4
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man CH4 (tCH4/t crop res)","Open burning","AllProdSyst") = 0.00108;
*cooking: assume same emission factors as for open burning:
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man CH4 (tCH4/t crop res)","Cooking","AllProdSyst") = 0.00108;
*the following are set equal 0, just to have values and because it does not matter which as long as quantity shares are 0 as well, what they are currently.
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man CH4 (tCH4/t crop res)","Feed","AllProdSyst") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man CH4 (tCH4/t crop res)","Dumped","AllProdSyst") = 0;
*assume no emissions from residues used as livestock bedding
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man CH4 (tCH4/t crop res)","Livestock bedding","AllProdSyst") = 0;

CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man N2O (tN2O/t crop res)","Composting","AllProdSyst") = 0.00024;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man N2O (tN2O/t crop res)","Left on croplands","AllProdSyst") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man N2O (tN2O/t crop res)","Biogas","AllProdSyst") = 0;
*burning: derived from 0.0027 * DM contents 0.4
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man N2O (tN2O/t crop res)","Open burning","AllProdSyst") = 0.000028;
*cooking: assume same emission factors as for open burning:
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man N2O (tN2O/t crop res)","Cooking","AllProdSyst") = 0.000028;
*the following are set equal 0, just to have values and because it does not matter which as ty shares are 0 as wees are 0 as well, what they are currently.
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man N2O (tN2O/t crop res)","Feed","AllProdSyst") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man N2O (tN2O/t crop res)","Dumped","AllProdSyst") = 0;
*assume no emissions from residues used as livestock bedding
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man N2O (tN2O/t crop res)","Livestock bedding","AllProdSyst") = 0;

*for grassland - all residues are left on grassland per definition, cf. above
GrassResidueManagement_VariousSources(FAOSTAT_Countries,NON_FAOSTAT_GrassActivities,"Crop res man CH4 (tCH4/t crop res)","Left on grasslands","AllProdSyst") = 0;
GrassResidueManagement_VariousSources(FAOSTAT_Countries,NON_FAOSTAT_GrassActivities,"Crop res man N2O (tN2O/t crop res)","Left on grasslands","AllProdSyst") = 0;




*and do P loss, via P lost from P in residues, assume this share to be 1%, to have something

*ATTENTION!!!  - TO BE IMPROVED!!

*assume 0 loss from man system: left on fields - the loss there is covered by leakage from application; and also assume 0 for the systems where N losses are 0 as well.
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man share P lost (tP2O5/tP2O5 in crop res)",CropResManSystemCropland,"AllProdSyst") = 0.01;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man share P lost (tP2O5/tP2O5 in crop res)","Left on croplands","AllProdSyst") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man share P lost (tP2O5/tP2O5 in crop res)","Biogas","AllProdSyst") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man share P lost (tP2O5/tP2O5 in crop res)","Feed","AllProdSyst") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man share P lost (tP2O5/tP2O5 in crop res)","Dumped","AllProdSyst") = 0;
CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,"Crop res man share P lost (tP2O5/tP2O5 in crop res)","Livestock bedding","AllProdSyst") = 0;

GrassResidueManagement_VariousSources(FAOSTAT_Countries,NON_FAOSTAT_GrassActivities,"Crop res man share P lost (tP2O5/tP2O5 in crop res)","Left on grasslands","AllProdSyst") = 0;


*Calculations for how much N and P remains for fertilization are done in Steering2 only, _V6_DataDerived_CropResidueManagement


$ontext;
after this, we have:
Parameter CropResidueManagement_VariousSources(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems,PerTonCropResParameter,CropResManSystem,ProductionSystems);
Parameter GrassResidueManagement_VariousSources(FAOSTAT_CountriesAndRegions,NON_FAOSTAT_GrassActivities,PerTonCropResParameter,CropResManSystem,ProductionSystems);
$offtext;


****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

Set Match_PerTonCropRes_CropResManagement(PerTonCropResParameter,CropResManagement)
/

*Some elements below are not included, because the calculations for how much N and P remains for fertilization are done in Steering2 only, _V6_DataDerived_CropResidueManagement

"Quantity share in CropResMan system"                 ."Quantity share in CropResMan system"
"Crop res man CH4 (tCH4/t crop res)"                  ."Crop res man CH4 (tCH4)"
"Crop res man N2O (tN2O/t crop res)"                  ."Crop res man N2O (tN2O)"
*"Crop res man N loss (tN/t crop res)"                 ."Crop res man N loss (tN)"
*"Crop res N for areas (tN/t crop res)"                ."Crop res N for areas (tN)"
"Crop res man share P lost (tP2O5/tP2O5 in crop res)" ."Crop res man share P lost (tP2O5/tP2O5 in crop res)"
*"Crop res man P loss (tP2O5/t crop res)"              ."Crop res man P loss (tP2O5)"
*"Crop res P for areas (tP2O5/t crop res)"             ."Crop res P for areas (tP2O5)"
/;

*3.2) Link to the core model parameters

CropResidues_Management(Regions,Activities,"Average Residues (t)",CropResManagement,CropResManSystem,ProductionSystems,"AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems,PerTonCropResParameter)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND Match_PerTonCropRes_CropResManagement(PerTonCropResParameter,CropResManagement)),
                 CropResidueManagement_VariousSources(FAOSTAT_Countries,FAOSTAT_CropProductionItems,PerTonCropResParameter,CropResManSystem,ProductionSystems));

CropResidues_Management(Regions,"Permanent meadows and pastures","Average Residues (t)",CropResManagement,CropResManSystem,ProductionSystems,"AllProdCond")
         = sum((FAOSTAT_Countries,PerTonCropResParameter)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND Match_PerTonCropRes_CropResManagement(PerTonCropResParameter,CropResManagement)),
                 GrassResidueManagement_VariousSources(FAOSTAT_Countries,"Permanent meadows and pastures",PerTonCropResParameter,CropResManSystem,ProductionSystems));

CropResidues_Management(Regions,"Temporary meadows and pastures","Average Residues (t)",CropResManagement,CropResManSystem,ProductionSystems,"AllProdCond")
         = sum((FAOSTAT_Countries,PerTonCropResParameter)$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                         AND Match_PerTonCropRes_CropResManagement(PerTonCropResParameter,CropResManagement)),
                 GrassResidueManagement_VariousSources(FAOSTAT_Countries,"Temporary meadows and pastures",PerTonCropResParameter,CropResManSystem,ProductionSystems));

*and add data for forage maize and fodder beets, not yet covered in FAOSTAT; in general, assign as for wheat/sugar beet, as it is only emission factors where this is legitimate, no residue shares, etc.
CropResidues_Management(Regions,"Maize for Forage+Silage","Average Residues (t)",CropResManagement,CropResManSystem,"AllProdSyst","AllProdCond")
         = CropResidues_Management(Regions,"Wheat","Average Residues (t)",CropResManagement,CropResManSystem,"AllProdSyst","AllProdCond");
CropResidues_Management(Regions,"Beets for Fodder","Average Residues (t)",CropResManagement,CropResManSystem,"AllProdSyst","AllProdCond")
         = CropResidues_Management(Regions,"Sugar beet","Average Residues (t)",CropResManagement,CropResManSystem,"AllProdSyst","AllProdCond");
*assign quantity shares differently:
CropResidues_Management(Countries,"Maize for Forage+Silage","Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,"AllProdCond") = 0;
CropResidues_Management(Countries,"Beets for Fodder","Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,"AllProdCond") = 0;
CropResidues_Management(Countries,"Maize for Forage+Silage","Average Residues (t)","Quantity share in CropResMan system","Left on croplands","AllProdSyst","AllProdCond") = 0.91;
CropResidues_Management(Countries,"Beets for Fodder","Average Residues (t)","Quantity share in CropResMan system","Left on croplands","AllProdSyst","AllProdCond") = 0.91;
CropResidues_Management(Countries,"Maize for Forage+Silage","Average Residues (t)","Quantity share in CropResMan system","Open burning","AllProdSyst","AllProdCond") = 0.09;
CropResidues_Management(Countries,"Beets for Fodder","Average Residues (t)","Quantity share in CropResMan system","Open burning","AllProdSyst","AllProdCond") = 0.09;
CropResidues_Management(Countries,"Maize for Forage+Silage","Average Residues (t)","Quantity share in CropResMan system","Left on croplands","Convent","AllProdCond") = 0.9;
CropResidues_Management(Countries,"Beets for Fodder","Average Residues (t)","Quantity share in CropResMan system","Left on croplands","Convent","AllProdCond") = 0.9;
CropResidues_Management(Countries,"Maize for Forage+Silage","Average Residues (t)","Quantity share in CropResMan system","Open burning","Convent","AllProdCond") = 0.1;
CropResidues_Management(Countries,"Beets for Fodder","Average Residues (t)","Quantity share in CropResMan system","Open burning","Convent","AllProdCond") = 0.1;
CropResidues_Management(Countries,"Maize for Forage+Silage","Average Residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond") = 0.9;
CropResidues_Management(Countries,"Beets for Fodder","Average Residues (t)","Quantity share in CropResMan system","Left on croplands","Organic","AllProdCond") = 0.9;
CropResidues_Management(Countries,"Maize for Forage+Silage","Average Residues (t)","Quantity share in CropResMan system","Composting","Organic","AllProdCond") = 0.1;
CropResidues_Management(Countries,"Beets for Fodder","Average Residues (t)","Quantity share in CropResMan system","Composting","Organic","AllProdCond") = 0.1;

*and assign specifically for the yet missing activities covered in the set aside activity group that is used with organic crop rotations (Barbieri), vegan scenarios, etc.
Set SetAside_V_ForCropResData(Activities)
/
"Clover For Forage+Silage"
"Alfalfa For Forage+Silag"
"Leguminous Nes,For+Sil"
"Forage Products Nes"
'Vetches'
"Other grasses, for forage"
"Rye grass, for forage"
/;

CropResidues_Management(Regions,SetAside_V_ForCropResData,"Average Residues (t)",CropResManagement,CropResManSystem,ProductionSystems,"AllProdCond")
         = CropResidues_Management(Regions,"Temporary meadows and pastures","Average Residues (t)",CropResManagement,CropResManSystem,ProductionSystems,"AllProdCond");
*for crop res man shares use data from crops, not grass:
CropResidues_Management(Regions,SetAside_V_ForCropResData,"Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,"AllProdCond")
         = CropResidues_Management(Regions,"Wheat","Average Residues (t)","Quantity share in CropResMan system",CropResManSystem,ProductionSystems,"AllProdCond");



execute_unload "VariousSources_CropResManData"
CropResidues_Management
;

$goto EndOfFile_CropResManData

$label UseOldCropResManData


$gdxin VariousSources_CropResManData.gdx
$load CropResidues_Management
$gdxin


$label EndOfFile_CropResManData


$ontext;
After this we have the following in SOLm-entities:

CropResidues_Management(Regions,Activities,"Average Residues (t)",CropResManagement,CropResManSystem,ProductionSystems,"AllProdCond")

Regions                          is      FAOSTAT_Countries
Activities                       is      FAOSTAT_CropProductionItems
                                                 temp/perm meadows and pastures

ProductionSystems are "AllProdSyst" and for the element "Quantity share in CropResMan system" in CropResManagement also "Convent" and "Organic". The set CropResManagement has the following elements:
       - "Quantity share in CropResMan system"
       - "Crop res man CH4 (tCH4)"
       - "Crop res man N2O (tN2O)"
       - "Crop res man N loss (tN)"
       - "Crop res N for areas (tN)"
       - "Crop res man share P lost (tP2O5/tP2O5 in crop res)"
       - "Crop res man P loss (tP2O5)"
       - "Crop res P for areas (tP2O5)"

$offtext;



