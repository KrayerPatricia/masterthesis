PUTCLOSE con,"_V6_ReadData_FAOSTAT_OrganicSoils";


$ontext;
GENERAL DESCRIPTION
This file reads the land use data from FAOSTAT

DETAILED TABLE OF CONTENTS
- 1) reading the csv-file and loading the parameters
- 2) build average over the base year period chosen to get the baseline values
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) reading the csv-file and loading the parameters

*read csv files from FAOSTAT into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewFAOSTATOrganicSoilsData% == "YES"
*due to some ununderstandable reason, reading in the csv-file does not work here - but transferring to excel and reading then works - thus do it from excel.
*$call csv2gdx FAOSTAT_OrganicSoils_2_28_2018.csv id=FAOSTAT_OrganicSoils Index=(2,4,6,8,9) Values=(10) UseHeader=Y
*$call GDXXRW FAOSTAT_OrganicSoils_2_28_2018.xlsx  o=FAOSTAT_OrganicSoils_2_28_2018.gdx  index=index!a1


$call csv2gdx FAOSTAT_OrganicSoilsN2ONormalized_25_12_2018.csv id=FAOSTAT_OrganicSoilsN2O Index=(2,4,6,8,11) Values=(12) UseHeader=Y
$call csv2gdx FAOSTAT_OrganicSoilsGrasslandCarbonNormalized_25_12_2018.csv id=FAOSTAT_OrganicSoilsGrassCarbon Index=(2,4,6,8,11) Values=(12) UseHeader=Y
$call csv2gdx FAOSTAT_OrganicSoilsCroplandCarbonNormalized_25_12_2018.csv id=FAOSTAT_OrganicSoilsCropCarbon Index=(2,4,6,8,11) Values=(12) UseHeader=Y


$endif;


$ontext;
READ NEW DATA: CARBON AND N2O
Instead of
FAOSTAT_OrganicSoils_2_28_2018.xlsx

FAOSTAT_OrganicSoilsN2ONormalized_25_12_2018
FAOSTAT_OrganicSoilsGrasslandCarbonNormalized_25_12_2018
FAOSTAT_OrganicSoilsCroplandCarbonNormalized_25_12_2018
$offtext;


Parameter FAOSTAT_OrganicSoilsN2O(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,Years,FAOSTAT_OrganicSoilsUnits);
Parameter FAOSTAT_OrganicSoilsGrassCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,Years,FAOSTAT_OrganicSoilsUnits);
Parameter FAOSTAT_OrganicSoilsCropCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,Years,FAOSTAT_OrganicSoilsUnits);

$gdxin  FAOSTAT_OrganicSoilsN2ONormalized_25_12_2018.gdx
$load FAOSTAT_OrganicSoilsN2O
$gdxin
$gdxin  FAOSTAT_OrganicSoilsGrasslandCarbonNormalized_25_12_2018.gdx
$load FAOSTAT_OrganicSoilsGrassCarbon
$gdxin
$gdxin  FAOSTAT_OrganicSoilsCroplandCarbonNormalized_25_12_2018.gdx
$load FAOSTAT_OrganicSoilsCropCarbon
$gdxin




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) build average over the base year period chosen to get the baseline values

PARAMETER NumberOfBasisYearsFAOSTATOrganicSoilsN2O;
PARAMETER NumberOfBasisYearsFAOSTATOrganicSoilsGrassCarbon;
PARAMETER NumberOfBasisYearsFAOSTATOrganicSoilsCropCarbon;
*this parameter is used to count the number of base years without missing values. This is used in taking averages of values over the baseyears;
*the average is built by summing over the years and then dividing by this value:
*with no missing values, this is a sum over all n years in the baseline period divided by n, with one missing value it sums over (n-1) years and divides by (n-1), etc....

NumberOfBasisYearsFAOSTATOrganicSoilsN2O(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,FAOSTAT_OrganicSoilsUnits)
         = SUM(BasisYears$FAOSTAT_OrganicSoilsN2O(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,BasisYears,FAOSTAT_OrganicSoilsUnits),1);
FAOSTAT_OrganicSoilsN2O(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,"AverageBasisYear",FAOSTAT_OrganicSoilsUnits)
                 $NumberOfBasisYearsFAOSTATOrganicSoilsN2O(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,FAOSTAT_OrganicSoilsUnits)
         = SUM(BasisYears,FAOSTAT_OrganicSoilsN2O(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,BasisYears,FAOSTAT_OrganicSoilsUnits))
                 /NumberOfBasisYearsFAOSTATOrganicSoilsN2O(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,FAOSTAT_OrganicSoilsUnits);

NumberOfBasisYearsFAOSTATOrganicSoilsGrassCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,FAOSTAT_OrganicSoilsUnits)
         = SUM(BasisYears$FAOSTAT_OrganicSoilsGrassCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,BasisYears,FAOSTAT_OrganicSoilsUnits),1);
FAOSTAT_OrganicSoilsGrassCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,"AverageBasisYear",FAOSTAT_OrganicSoilsUnits)
                 $NumberOfBasisYearsFAOSTATOrganicSoilsGrassCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,FAOSTAT_OrganicSoilsUnits)
         = SUM(BasisYears,FAOSTAT_OrganicSoilsGrassCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,BasisYears,FAOSTAT_OrganicSoilsUnits))
                 /NumberOfBasisYearsFAOSTATOrganicSoilsGrassCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,FAOSTAT_OrganicSoilsUnits);

NumberOfBasisYearsFAOSTATOrganicSoilsCropCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,FAOSTAT_OrganicSoilsUnits)
         = SUM(BasisYears$FAOSTAT_OrganicSoilsCropCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,BasisYears,FAOSTAT_OrganicSoilsUnits),1);
FAOSTAT_OrganicSoilsCropCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,"AverageBasisYear",FAOSTAT_OrganicSoilsUnits)
                 $NumberOfBasisYearsFAOSTATOrganicSoilsCropCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,FAOSTAT_OrganicSoilsUnits)
         = SUM(BasisYears,FAOSTAT_OrganicSoilsCropCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,BasisYears,FAOSTAT_OrganicSoilsUnits))
                 /NumberOfBasisYearsFAOSTATOrganicSoilsCropCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,FAOSTAT_OrganicSoilsUnits);


$ontext;
after this, we have:
Parameter FAOSTAT_OrganicSoilsN2O(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,Years,FAOSTAT_OrganicSoilsUnits);
Parameter FAOSTAT_OrganicSoilsGrassCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,Years,FAOSTAT_OrganicSoilsUnits);
Parameter FAOSTAT_OrganicSoilsCropCarbon(FAOSTAT_CountriesAndRegions,FAOSTAT_OrganicSoilsItems,FAOSTAT_OrganicSoilsElements,Years,FAOSTAT_OrganicSoilsUnits);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

*no further assignments needed

*3.2) Link to the core model parameters

*derive the per ha organic soil use values and related CO2e emissions from the relation between total agricultural land in a country and the reported managed organic soil values, averaged over the basis years.
*given the data description, this approach makes more sense than directly linking the organic soil use values to the CHANGES in agricultural areas; thus, this latter approach that has been implemented
*in an earlier version of SOLm (V2) is not pursued here anymore.

*unit: ha managed organic soils per ha agricultural area, positive - if no organic soils are used, this value is zero, as this is already coded like this in the FAO data
*first for croplands
ActCropsGrass_OtherChar(Regions,"All Crops","CultOrgSoils (ha)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                                 AND (FAOSTAT_LandUse(FAOSTAT_Countries,"Arable land","Area","AverageBasisYear","ha")
                                         - FAOSTAT_LandUse(FAOSTAT_Countries,"Temporary meadows and pastures","Area","AverageBasisYear","ha"))),
                 FAOSTAT_OrganicSoilsCropCarbon(FAOSTAT_Countries,"Cropland organic soils","Area","AverageBasisYear","ha")
                         /(FAOSTAT_LandUse(FAOSTAT_Countries,"Arable land","Area","AverageBasisYear","ha")
                                 - FAOSTAT_LandUse(FAOSTAT_Countries,"Temporary meadows and pastures","Area","AverageBasisYear","ha")));
*assign to all crops:
ActCropsGrass_OtherChar(Regions,Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"All Crops","CultORgSoils (ha)","AllProdSyst","AllProdCond");
*set the combined "All crops" equal zero - in case it is there at all:
ActCropsGrass_OtherChar(Regions,"All Crops","CultOrgSoils (ha)","AllProdSyst","AllProdCond")
         = 0;

*assign for grasslands
ActCropsGrass_OtherChar(Regions,"Grass","CultOrgSoils (ha)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                                 AND FAOSTAT_LandUse(FAOSTAT_Countries,"Permanent meadows and pastures","Area","AverageBasisYear","ha")),
                 FAOSTAT_OrganicSoilsGrassCarbon(FAOSTAT_Countries,"Grassland organic soils","Area","AverageBasisYear","ha")
                         /FAOSTAT_LandUse(FAOSTAT_Countries,"Permanent meadows and pastures","Area","AverageBasisYear","ha"));
*assign to all grass activities:
ActCropsGrass_OtherChar(Regions,GrassActivities,"CultOrgSoils (ha)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"Grass","CultORgSoils (ha)","AllProdSyst","AllProdCond");
*set the combined "Grass" equal zero - in case it is there at all:
ActCropsGrass_OtherChar(Regions,"Grass","CultOrgSoils (ha)","AllProdSyst","AllProdCond")
         = 0;

*and if by some reason some negative value has been derived, set this to zero:
ActCropsGrass_OtherChar(Regions,Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond")
         $(ActCropsGrass_OtherChar(Regions,Crops,"CultOrgSoils (ha)","AllProdSyst","AllProdCond") < 0)
                 =0;
ActCropsGrass_OtherChar(Regions,GrassActivities,"CultOrgSoils (ha)","AllProdSyst","AllProdCond")
         $(ActCropsGrass_OtherChar(Regions,GrassActivities,"CultOrgSoils (ha)","AllProdSyst","AllProdCond") < 0)
                 =0;

*unit: t CO2eq emissions from managed organic soils per ha agricultural area, positive - if no organic soils are managed, this value is zero, as this is already coded like this in the FAO data
*multiplication by 1000 as Gigagrams is kilotons
*first for croplands
ActCropsGrass_OtherChar(Regions,"All Crops","CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                                 AND (FAOSTAT_LandUse(FAOSTAT_Countries,"Arable land","Area","AverageBasisYear","ha")
                                         - FAOSTAT_LandUse(FAOSTAT_Countries,"Temporary meadows and pastures","Area","AverageBasisYear","ha"))),
                 (FAOSTAT_OrganicSoilsCropCarbon(FAOSTAT_Countries,"Cropland organic soils","Net emissions/removal (CO2eq) (Cropland)","AverageBasisYear","gigagrams")
                                 + FAOSTAT_OrganicSoilsN2O(FAOSTAT_Countries,"Cropland organic soils","Emissions (CO2eq) (Cultivation of organic soils)","AverageBasisYear","gigagrams"))*1000
                         /(FAOSTAT_LandUse(FAOSTAT_Countries,"Arable land","Area","AverageBasisYear","ha")
                                 - FAOSTAT_LandUse(FAOSTAT_Countries,"Temporary meadows and pastures","Area","AverageBasisYear","ha")));
*assign to all crops:
ActCropsGrass_OtherChar(Regions,Crops,"CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"All Crops","CultORgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond");
*set the combined "All crops" equal zero - in case it is there at all:
ActCropsGrass_OtherChar(Regions,"All Crops","CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 0;

*assign for grasslands:
ActCropsGrass_OtherChar(Regions,"Grass","CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                                 AND FAOSTAT_LandUse(FAOSTAT_Countries,"Permanent meadows and pastures","Area","AverageBasisYear","ha")),
                 (FAOSTAT_OrganicSoilsGrassCarbon(FAOSTAT_Countries,"Grassland organic soils","Net emissions/removal (CO2eq) (Grassland)","AverageBasisYear","gigagrams")
                                 + FAOSTAT_OrganicSoilsN2O(FAOSTAT_Countries,"Grassland organic soils","Emissions (CO2eq) (Cultivation of organic soils)","AverageBasisYear","gigagrams"))*1000
                         /FAOSTAT_LandUse(FAOSTAT_Countries,"Permanent meadows and pastures","Area","AverageBasisYear","ha"));
*assign to all grass activities:
ActCropsGrass_OtherChar(Regions,GrassActivities,"CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"Grass","CultORgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond");
*set the combined "Grass" equal zero - in case it is there at all:
ActCropsGrass_OtherChar(Regions,"Grass","CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
         = 0;
*and if by some reason some negetive value has been derived, set this to zero:
ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
         $(ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond") < 0)
                 =0;

*do C and N2O separately:
*for crops
ActCropsGrass_OtherChar(Regions,"All Crops","CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                                 AND (FAOSTAT_LandUse(FAOSTAT_Countries,"Arable land","Area","AverageBasisYear","ha")
                                         - FAOSTAT_LandUse(FAOSTAT_Countries,"Temporary meadows and pastures","Area","AverageBasisYear","ha"))),
                 FAOSTAT_OrganicSoilsCropCarbon(FAOSTAT_Countries,"Cropland organic soils","Net emissions/removal (CO2eq) (Cropland)","AverageBasisYear","gigagrams")*1000
                         /(FAOSTAT_LandUse(FAOSTAT_Countries,"Arable land","Area","AverageBasisYear","ha")
                                 - FAOSTAT_LandUse(FAOSTAT_Countries,"Temporary meadows and pastures","Area","AverageBasisYear","ha")));
ActCropsGrass_OtherChar(Regions,"All Crops","CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                                 AND (FAOSTAT_LandUse(FAOSTAT_Countries,"Arable land","Area","AverageBasisYear","ha")
                                         - FAOSTAT_LandUse(FAOSTAT_Countries,"Temporary meadows and pastures","Area","AverageBasisYear","ha"))),
                 FAOSTAT_OrganicSoilsN2O(FAOSTAT_Countries,"Cropland organic soils","Emissions (CO2eq) (Cultivation of organic soils)","AverageBasisYear","gigagrams")*1000
                         /(FAOSTAT_LandUse(FAOSTAT_Countries,"Arable land","Area","AverageBasisYear","ha")
                                 - FAOSTAT_LandUse(FAOSTAT_Countries,"Temporary meadows and pastures","Area","AverageBasisYear","ha")));
*assign to all crops:
ActCropsGrass_OtherChar(Regions,Crops,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"All Crops","CultORgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond");
ActCropsGrass_OtherChar(Regions,Crops,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"All Crops","CultORgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond");
*set the combined "All crops" and "Grass" equal zero:
ActCropsGrass_OtherChar(Regions,"All Crops","CultORgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond") =0;
ActCropsGrass_OtherChar(Regions,"All Crops","CultORgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") =0;

*for grasslands:
ActCropsGrass_OtherChar(Regions,"Grass","CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                                 AND FAOSTAT_LandUse(FAOSTAT_Countries,"Permanent meadows and pastures","Area","AverageBasisYear","ha")),
                 FAOSTAT_OrganicSoilsGrassCarbon(FAOSTAT_Countries,"Grassland organic soils","Net emissions/removal (CO2eq) (Grassland)","AverageBasisYear","gigagrams")*1000
                         /FAOSTAT_LandUse(FAOSTAT_Countries,"Permanent meadows and pastures","Area","AverageBasisYear","ha"));
ActCropsGrass_OtherChar(Regions,"Grass","CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")
         = sum(FAOSTAT_Countries$(MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                                 AND FAOSTAT_LandUse(FAOSTAT_Countries,"Permanent meadows and pastures","Area","AverageBasisYear","ha")),
                 FAOSTAT_OrganicSoilsN2O(FAOSTAT_Countries,"Grassland organic soils","Emissions (CO2eq) (Cultivation of organic soils)","AverageBasisYear","gigagrams")*1000
                         /FAOSTAT_LandUse(FAOSTAT_Countries,"Permanent meadows and pastures","Area","AverageBasisYear","ha"));
*assign to all grass activities:
ActCropsGrass_OtherChar(Regions,GrassActivities,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"Grass","CultORgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond");
ActCropsGrass_OtherChar(Regions,GrassActivities,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")
         = ActCropsGrass_OtherChar(Regions,"Grass","CultORgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond");
*set the combined "All crops" and "Grass" equal zero:
ActCropsGrass_OtherChar(Regions,"Grass","CultORgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond") =0;
ActCropsGrass_OtherChar(Regions,"Grass","CultORgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") =0;

*and if by some reason some netaige value has been derived, set this to zero:
ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond")
         $(ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond") < 0)
                 =0;
ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")
         $(ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond") < 0)
                 =0;



$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils (ha)","AllProdSyst","AllProdCond")
ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils GHG emissions (tCO2e)","AllProdSyst","AllProdCond")
ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils C emissions (tCO2e)","AllProdSyst","AllProdCond")
ActCropsGrass_OtherChar(Regions,Activities,"CultOrgSoils N2O emissions (tCO2e)","AllProdSyst","AllProdCond")

Regions        is      FAOSTAT_Countries
Activities     is      all crop and grass activities
$offtext;






