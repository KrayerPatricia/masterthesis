PUTCLOSE con,"_V6_ReadData_VariousSources_FeedingRationsData";

$ontext;
GENERAL DESCRIPTION
This file assigns the feeding rations values

DETAILED TABLE OF CONTENTS
- 1) Feeding rations data as defined in old SOLm versions (up to version SOLmV4) and based on Herrero et al. 2013
- 2) Feeding rations data as defined in XXX
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Feeding rations data as defined in old SOLm versions (up to version SOLmV4) and based on Herrero et al. 2013

$ontext;
The following defines the parameter for feeding rations: how much of feed DM demand is covered with concentrates, grass, forage, residues
usually, this refers to DM basis, not to FeedME, FeedGE, FeedXP

first, assign global values as used in earlier versions of SOLm,
$offtext;

*read excel files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewVariousSourcesFeedingRationsData% == "YES"
$call GDXXRW FeedingRationsData_31_8_2016.xlsx  o=FeedingRationsData_31_8_2016.gdx  index=index!a1:e2
*contains the pesticide use indices as described above
$endif;

Set FeedingRationsShares
/
ShareGrass
ShareForageCrops
ShareConcentrates
ShareResidues
/;

*unit: share in total, i.e. percentage/100
Parameter VariousSources_FeedingRationsData(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,FeedingRationsShares);

$gdxin FeedingRationsData_31_8_2016.gdx
$load VariousSources_FeedingRationsData
$gdxin

*assigning those values to single countries is done further down, after defining some improved values based on Herrero et al. 2013

$ontext;
then improve these values and replace the other values filed in above.
This is taken from the SI from Herrero M., Havlik P., Valin H., Notenbaert A., Rufino M.C., Thornton P.K., Blümmel M., Weiss F., Grace D., Obersteiner M. (2013)
Biomass use, production, feed efficiencies, and greenhouse gas emissions from global livestock systems. Proc. Natl Acad. Sci. USA 110:20888-20893

For now, we aggreated over beef and dairy herd, and
we neither do have residues, etc. as feed explicitely in the feed supply data on global level
BOTH - to be improved later.

Assign the values using FAO sets corresponding to Herrero sets, corrected as below and then assigning the rest:
Herrero    file in as            set equal to this          subtract from this set
EUR        Europe                   Russian Federation
SEA        South-Eastern Asia
EAS        Eastern Asia
SAS        Southern Asia
LAM        Central America          Caribbean, South America
SSA        - -                      Eastern Africa, Middle Africa, Southern Africa, Western Africa
MNA        Northern Africa          Central Asia                 -Sudan
                                    Western Asia                 -Russian Federation
OCE        Oceania
NAM        Northern America

WRD        World        assign these values to countries that do not yet have a value

and equal goat to sheep, and leave all the other types as they are (pigs: anyway 100% concentrates)
Herrero has also a region "CIS" - but it is nowhere explained what this may be, thus we drop it
Assigning Central and Western Asia to the MNA region may also be problematic - but there is no information available where else Central Asia should be assigned to
Assigning all other than northern Africa to Sub-Sahara Africa may also be problematic - but there is no information available to do this otherwise

*Here, forage crops refers to the category "Occasional", which covers legumes and forage crops, but also road-side grasses -
*those latter should not be reduced under concentrates reduction, but there is no information on how big their share may be
*thus assume something - we take just ONE THIRD, thus correspondingly reducing this category and increasing grasses -
*HOWEVER; for sheep and goats only, as there, the share of occasional can be considerably....
*thus, the values with *... are the original ones
*But we dig deeper, as like this, we still have too much non-grassland feed for sheep/goats that is converted to arable food crops with conc reduction.
*        we thus assume that only 10% of this feed type relates to specific arable land, the rest rather to grassland;
*        based on the description in Herrero et al and the reference 22 given there: this feed seems to be cut and carry legume hay, e.g. groundnuts, etc. - so it would not use up arable land.

ATTENTION!! TO BE IMPROVED!!

$offtext;

*below, we thus assign these improved feeding rations from Herrero et al. 2013
*assigning "eps" is needed to avoid that the code further down overwrites zero values with global non-zero values, as GAMS sees zero values as missing!

*WRD        World
VariousSources_FeedingRationsData("World","Cattle","ShareGrass")         = 0.65;
VariousSources_FeedingRationsData("World","Cattle","ShareForageCrops")   = 0.11;
VariousSources_FeedingRationsData("World","Cattle","ShareConcentrates")  = 0.08;
VariousSources_FeedingRationsData("World","Cattle","ShareResidues")      = 0.16;
*VariousSources_FeedingRationsData("World","Sheep","ShareGrass")          = 0.57;
***VariousSources_FeedingRationsData("World","Sheep","ShareGrass")          = 0.65;
VariousSources_FeedingRationsData("World","Sheep","ShareGrass")          = 0.786;
*VariousSources_FeedingRationsData("World","Sheep","ShareForageCrops")    = 0.24;
***VariousSources_FeedingRationsData("World","Sheep","ShareForageCrops")    = 0.16;
VariousSources_FeedingRationsData("World","Sheep","ShareForageCrops")    = 0.024;
VariousSources_FeedingRationsData("World","Sheep","ShareConcentrates")   = 0.12;
VariousSources_FeedingRationsData("World","Sheep","ShareResidues")       = 0.07;

*SEA         South-Eastern Asia
VariousSources_FeedingRationsData("South-Eastern Asia","Cattle","ShareGrass")         = 0.52;
VariousSources_FeedingRationsData("South-Eastern Asia","Cattle","ShareForageCrops")   = 0.06;
VariousSources_FeedingRationsData("South-Eastern Asia","Cattle","ShareConcentrates")  = 0.01;
VariousSources_FeedingRationsData("South-Eastern Asia","Cattle","ShareResidues")      = 0.41;
*VariousSources_FeedingRationsData("South-Eastern Asia","Sheep","ShareGrass")          = 0.35;
*VariousSources_FeedingRationsData("South-Eastern Asia","Sheep","ShareForageCrops")    = 0.46;
**VariousSources_FeedingRationsData("South-Eastern Asia","Sheep","ShareGrass")          = 0.51;
**VariousSources_FeedingRationsData("South-Eastern Asia","Sheep","ShareForageCrops")    = 0.30;
VariousSources_FeedingRationsData("South-Eastern Asia","Sheep","ShareGrass")          = 0.764;
VariousSources_FeedingRationsData("South-Eastern Asia","Sheep","ShareForageCrops")    = 0.046;
VariousSources_FeedingRationsData("South-Eastern Asia","Sheep","ShareConcentrates")   = 0.09;
VariousSources_FeedingRationsData("South-Eastern Asia","Sheep","ShareResidues")       = 0.1;

*EAS        Eastern Asia
VariousSources_FeedingRationsData("Eastern Asia","Cattle","ShareGrass")         = 0.74;
VariousSources_FeedingRationsData("Eastern Asia","Cattle","ShareForageCrops")   = eps;
VariousSources_FeedingRationsData("Eastern Asia","Cattle","ShareConcentrates")  = 0.08;
VariousSources_FeedingRationsData("Eastern Asia","Cattle","ShareResidues")      = 0.18;
*VariousSources_FeedingRationsData("Eastern Asia","Sheep","ShareGrass")          = 0.24;
*VariousSources_FeedingRationsData("Eastern Asia","Sheep","ShareForageCrops")    = 0.63;
**VariousSources_FeedingRationsData("Eastern Asia","Sheep","ShareGrass")          = 0.45;
**VariousSources_FeedingRationsData("Eastern Asia","Sheep","ShareForageCrops")    = 0.42;
VariousSources_FeedingRationsData("Eastern Asia","Sheep","ShareGrass")          = 0.807;
VariousSources_FeedingRationsData("Eastern Asia","Sheep","ShareForageCrops")    = 0.063;
VariousSources_FeedingRationsData("Eastern Asia","Sheep","ShareConcentrates")   = 0.12;
VariousSources_FeedingRationsData("Eastern Asia","Sheep","ShareResidues")       = 0.01;

*SAS        Southern Asia
VariousSources_FeedingRationsData("Southern Asia","Cattle","ShareGrass")         = 0.43;
VariousSources_FeedingRationsData("Southern Asia","Cattle","ShareForageCrops")   = 0.11;
VariousSources_FeedingRationsData("Southern Asia","Cattle","ShareConcentrates")  = 0.11;
VariousSources_FeedingRationsData("Southern Asia","Cattle","ShareResidues")      = 0.35;
*VariousSources_FeedingRationsData("Southern Asia","Sheep","ShareGrass")          = 0.55;
*VariousSources_FeedingRationsData("Southern Asia","Sheep","ShareForageCrops")    = 0.25;
**VariousSources_FeedingRationsData("Southern Asia","Sheep","ShareGrass")          = 0.63;
**VariousSources_FeedingRationsData("Southern Asia","Sheep","ShareForageCrops")    = 0.17;
VariousSources_FeedingRationsData("Southern Asia","Sheep","ShareGrass")          = 0.775;
VariousSources_FeedingRationsData("Southern Asia","Sheep","ShareForageCrops")    = 0.025;
VariousSources_FeedingRationsData("Southern Asia","Sheep","ShareConcentrates")   = 0.11;
VariousSources_FeedingRationsData("Southern Asia","Sheep","ShareResidues")       = 0.09;

*LAM        Central America          equal: Caribbean, South America
**VariousSources_FeedingRationsData(SET_FAO_Central_America,"Cattle","ShareGrass")         = 0.68;
**VariousSources_FeedingRationsData(SET_FAO_Central_America,"Cattle","ShareForageCrops")   = 0.25;
*here, forage is that high for cattle, that we also reduce it, as it is this type of "occasional food" from Herrero
*        that likely does not use specific arable landt ha tcould be freed for other crops; assuming a fifth only to be such.
VariousSources_FeedingRationsData("Central America","Cattle","ShareGrass")         = 0.88;
VariousSources_FeedingRationsData("Central America","Cattle","ShareForageCrops")   = 0.05;
VariousSources_FeedingRationsData("Central America","Cattle","ShareConcentrates")  = 0.03;
VariousSources_FeedingRationsData("Central America","Cattle","ShareResidues")      = 0.04;
*VariousSources_FeedingRationsData("Central America","Sheep","ShareGrass")          = 0.48;
*VariousSources_FeedingRationsData("Central America","Sheep","ShareForageCrops")    = 0.34;
**VariousSources_FeedingRationsData("Central America","Sheep","ShareGrass")          = 0.59;
**VariousSources_FeedingRationsData("Central America","Sheep","ShareForageCrops")    = 0.23;
VariousSources_FeedingRationsData("Central America","Sheep","ShareGrass")          = 0.786;
VariousSources_FeedingRationsData("Central America","Sheep","ShareForageCrops")    = 0.034;
VariousSources_FeedingRationsData("Central America","Sheep","ShareConcentrates")   = 0.12;
VariousSources_FeedingRationsData("Central America","Sheep","ShareResidues")       = 0.06;

VariousSources_FeedingRationsData("Caribbean","Cattle",FeedingRationsShares)
         =VariousSources_FeedingRationsData("Central America","Cattle",FeedingRationsShares);
VariousSources_FeedingRationsData("Caribbean","Sheep",FeedingRationsShares)
         =VariousSources_FeedingRationsData("Central America","Sheep",FeedingRationsShares);

VariousSources_FeedingRationsData("South America","Cattle",FeedingRationsShares)
         =VariousSources_FeedingRationsData("Central America","Cattle",FeedingRationsShares);
VariousSources_FeedingRationsData("South America","Sheep",FeedingRationsShares)
         =VariousSources_FeedingRationsData("Central America","Sheep",FeedingRationsShares);

*MNA        Northern Africa         equal: Central Asia       subtract: -Sudan (is SSA, assigned further down)
*                                          Western Asia                 -Russian Federation (is EUR, assigned further down)
VariousSources_FeedingRationsData("Northern Africa","Cattle","ShareGrass")         = 0.6;
VariousSources_FeedingRationsData("Northern Africa","Cattle","ShareForageCrops")   = eps;
VariousSources_FeedingRationsData("Northern Africa","Cattle","ShareConcentrates")  = 0.3;
VariousSources_FeedingRationsData("Northern Africa","Cattle","ShareResidues")      = 0.1;
*VariousSources_FeedingRationsData("Northern Africa","Sheep","ShareGrass")          = 0.66;
*VariousSources_FeedingRationsData("Northern Africa","Sheep","ShareForageCrops")    = 0.05;
**VariousSources_FeedingRationsData("Northern Africa","Sheep","ShareGrass")          = 0.67;
**VariousSources_FeedingRationsData("Northern Africa","Sheep","ShareForageCrops")    = 0.04;
VariousSources_FeedingRationsData("Northern Africa","Sheep","ShareGrass")          = 0.705;
VariousSources_FeedingRationsData("Northern Africa","Sheep","ShareForageCrops")    = 0.005;
VariousSources_FeedingRationsData("Northern Africa","Sheep","ShareConcentrates")   = 0.16;
VariousSources_FeedingRationsData("Northern Africa","Sheep","ShareResidues")       = 0.13;


*For central asia, use the same as for Northern_Africa
VariousSources_FeedingRationsData("Central Asia","Cattle",FeedingRationsShares)
         =VariousSources_FeedingRationsData("Northern Africa","Cattle",FeedingRationsShares);
VariousSources_FeedingRationsData("Central Asia","Sheep",FeedingRationsShares)
         =VariousSources_FeedingRationsData("Northern Africa","Sheep",FeedingRationsShares);

*For western asia, use the same as for Northern_Africa
VariousSources_FeedingRationsData("Western Asia","Cattle",FeedingRationsShares)
         =VariousSources_FeedingRationsData("Northern Africa","Cattle",FeedingRationsShares);
VariousSources_FeedingRationsData("Western Asia","Sheep",FeedingRationsShares)
         =VariousSources_FeedingRationsData("Northern Africa","Sheep",FeedingRationsShares);

*SSA        - -          equal:      Eastern Africa, Middle Africa, Southern Africa, Western Africa
*                                        thus code as "Africa" and assign further down single country values only AFTER having assigned those for "Northern Africa" which is given separately, cf. above.
VariousSources_FeedingRationsData("Africa","Cattle","ShareGrass")         = 0.67;
VariousSources_FeedingRationsData("Africa","Cattle","ShareForageCrops")   = 0.1;
VariousSources_FeedingRationsData("Africa","Cattle","ShareConcentrates")  = 0.02;
VariousSources_FeedingRationsData("Africa","Cattle","ShareResidues")      = 0.21;
*VariousSources_FeedingRationsData("Africa","Sheep","ShareGrass")          = 0.7;
*VariousSources_FeedingRationsData("Africa","Sheep","ShareForageCrops")    = 0.08;
**VariousSources_FeedingRationsData("Africa","Sheep","ShareGrass")          = 0.72;
**VariousSources_FeedingRationsData("Africa","Sheep","ShareForageCrops")    = 0.06;
VariousSources_FeedingRationsData("Africa","Sheep","ShareGrass")          = 0.772;
VariousSources_FeedingRationsData("Africa","Sheep","ShareForageCrops")    = 0.008;
VariousSources_FeedingRationsData("Africa","Sheep","ShareConcentrates")   = 0.09;
VariousSources_FeedingRationsData("Africa","Sheep","ShareResidues")       = 0.13;

*EUR          Europe     equal: Russian Federation
VariousSources_FeedingRationsData("Europe","Cattle","ShareGrass")         = 0.72;
VariousSources_FeedingRationsData("Europe","Cattle","ShareForageCrops")   = 0.09;
VariousSources_FeedingRationsData("Europe","Cattle","ShareConcentrates")  = 0.19;
VariousSources_FeedingRationsData("Europe","Cattle","ShareResidues")      = eps;
*VariousSources_FeedingRationsData("Europe","Sheep","ShareGrass")          = 0.63;
*VariousSources_FeedingRationsData("Europe","Sheep","ShareForageCrops")    = 0.18;
**VariousSources_FeedingRationsData("Europe","Sheep","ShareGrass")          = 0.69;
**VariousSources_FeedingRationsData("Europe","Sheep","ShareForageCrops")    = 0.12;
VariousSources_FeedingRationsData("Europe","Sheep","ShareGrass")          = 0.792;
VariousSources_FeedingRationsData("Europe","Sheep","ShareForageCrops")    = 0.018;
VariousSources_FeedingRationsData("Europe","Sheep","ShareConcentrates")   = 0.19;
VariousSources_FeedingRationsData("Europe","Sheep","ShareResidues")       = eps;

VariousSources_FeedingRationsData("Russian Federation","Cattle",FeedingRationsShares)
         =VariousSources_FeedingRationsData("Europe","Cattle",FeedingRationsShares);
VariousSources_FeedingRationsData("Russian Federation","Sheep",FeedingRationsShares)
         =VariousSources_FeedingRationsData("Europe","Sheep",FeedingRationsShares);


*OCE        Oceania
VariousSources_FeedingRationsData("Oceania","Cattle","ShareGrass")         = 0.94;
VariousSources_FeedingRationsData("Oceania","Cattle","ShareForageCrops")   = 0.04;
VariousSources_FeedingRationsData("Oceania","Cattle","ShareConcentrates")  = 0.02;
VariousSources_FeedingRationsData("Oceania","Cattle","ShareResidues")      = eps;
VariousSources_FeedingRationsData("Oceania","Sheep","ShareGrass")          = 0.88;
VariousSources_FeedingRationsData("Oceania","Sheep","ShareForageCrops")    = 0;
VariousSources_FeedingRationsData("Oceania","Sheep","ShareConcentrates")   = 0.12;
VariousSources_FeedingRationsData("Oceania","Sheep","ShareResidues")       = eps;

*NAM        Northern America
VariousSources_FeedingRationsData("Northern America","Cattle","ShareGrass")         = 0.74;
VariousSources_FeedingRationsData("Northern America","Cattle","ShareForageCrops")   = eps;
VariousSources_FeedingRationsData("Northern America","Cattle","ShareConcentrates")  = 0.18;
VariousSources_FeedingRationsData("Northern America","Cattle","ShareResidues")      = 0.08;
VariousSources_FeedingRationsData("Northern America","Sheep","ShareGrass")          = 0.83;
VariousSources_FeedingRationsData("Northern America","Sheep","ShareForageCrops")    = 0;
VariousSources_FeedingRationsData("Northern America","Sheep","ShareConcentrates")   = 0.17;
VariousSources_FeedingRationsData("Northern America","Sheep","ShareResidues")       = eps;

*now assign the regional average values to the countries within those regions, where no data is available on country level


*second, on the level of sub-continents
VariousSources_FeedingRationsData(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,FeedingRationsShares)
                 $(NOT VariousSources_FeedingRationsData(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,FeedingRationsShares))
         = sum(FAOSTAT_Subcontinents$FAOSTAT_CountriesInRegions(FAOSTAT_Subcontinents,FAOSTAT_Countries),VariousSources_FeedingRationsData(FAOSTAT_Subcontinents,FAOSTAT_LiveAnimalsItems,FeedingRationsShares));

*third, if no sub-continent averages are available, on the level of continents:
*conditional to whether there are now values on country levels (original, or from the sub-continents) - thus, only the truly missing are assigned
VariousSources_FeedingRationsData(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,FeedingRationsShares)
                 $(NOT VariousSources_FeedingRationsData(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,FeedingRationsShares))
         = sum(FAOSTAT_Continents$FAOSTAT_CountriesInRegions(FAOSTAT_Continents,FAOSTAT_Countries),VariousSources_FeedingRationsData(FAOSTAT_Continents,FAOSTAT_LiveAnimalsItems,FeedingRationsShares));

*fourth, on global level, if averages for continents are missing:
*conditional to whether there are now values on country levels (original, or from the sub-continents or continents) - thus, only the truly missing are assigned
VariousSources_FeedingRationsData(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,FeedingRationsShares)
                 $(NOT VariousSources_FeedingRationsData(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,FeedingRationsShares))
         = VariousSources_FeedingRationsData("World",FAOSTAT_LiveAnimalsItems,FeedingRationsShares);

*fifth, on the level of non-geographic subsets, i.e. developing/developed countries, where also some values are given:
*this is in particular needed for all live animal items not covered in the Herrero et al. 2013 data but only in the data filed in above from excel
VariousSources_FeedingRationsData(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,FeedingRationsShares)
                 $(NOT VariousSources_FeedingRationsData(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,FeedingRationsShares))
         = sum(FAOSTAT_DevelopedDevelopingGroups$FAOSTAT_CountriesInRegions(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_Countries),
                                 VariousSources_FeedingRationsData(FAOSTAT_DevelopedDevelopingGroups,FAOSTAT_LiveAnimalsItems,FeedingRationsShares));

*now assign zero to all values that have "eps" - assigning "eps" was needed to avoid that the code just above overwrites zero values with global values, as GAMS sees them as missing!
VariousSources_FeedingRationsData(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,FeedingRationsShares)
                 $(VariousSources_FeedingRationsData(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,FeedingRationsShares) = eps)
         = 0;



*after this, feeding rations values are available for all countries in FAOSTAT_Countries

*Now assign for missing animals in FAOSTAT_LiveAnimalsItems
*all poultry: 100% concentrares: - to be imèproved: share Grass in developing countries, for example?
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Chickens","ShareConcentrates")  = 1;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Geese and guinea fowls","ShareConcentrates")  = 1;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Ducks","ShareConcentrates")  = 1;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Pigeons, other birds","ShareConcentrates")  = 1;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Turkeys","ShareConcentrates")  = 1;

*Pigs: 10% Forage (inspired by Alpenprojekt) - to be improved!
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Pigs","ShareConcentrates")  = 0.9;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Pigs","ShareForageCrops")  = 0.1;
*rabbits, rodents: as pigs:
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Rabbits and hares","ShareConcentrates")  = 0.9;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Rabbits and hares","ShareForageCrops")  = 0.1;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Rodents, other","ShareConcentrates")  = 0.9;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Rodents, other","ShareForageCrops")  = 0.1;

*Goats: as sheep:
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Goats",FeedingRationsShares)
         = VariousSources_FeedingRationsData(FAOSTAT_Countries,"Sheep",FeedingRationsShares);

*Other ruminants: almost 100% Grass:
*add some small amount of forage, as 110% grass causes problems in countries not reporting grass, such as Egypt
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Buffaloes","ShareGrass")  = 0.95;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Buffaloes","ShareForageCrops")  = 0.05;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Camelids, other","ShareGrass")  = 0.95;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Camelids, other","ShareForageCrops")  = 0.05;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Camels","ShareGrass")  = 0.95;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Camels","ShareForageCrops")  = 0.05;

*horses, asses, mules, game some few concentrate:
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Horses","ShareConcentrates")  = 0.05;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Horses","ShareGrass")  = 0.95;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Asses","ShareConcentrates")  = 0.05;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Asses","ShareGrass")  = 0.95;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Mules","ShareConcentrates")  = 0.05;
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Mules","ShareGrass")  = 0.95;

*"Animals live nes" as pigs:
VariousSources_FeedingRationsData(FAOSTAT_Countries,"Animals live nes",FeedingRationsShares)
         = VariousSources_FeedingRationsData(FAOSTAT_Countries,"Pigs",FeedingRationsShares);



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) Feeding rations data as defined in XXX

*XXX


$ontext;
after this, we have:
Parameter VariousSources_FeedingRationsData(FAOSTAT_CountriesAndRegions,FAOSTAT_LiveAnimalsItems,FeedingRationsShares);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

Set Match_FeedRationShare_OtherCharAnimals(FeedingRationsShares,OtherCharAnimals)
/
ShareGrass."Grass in Feed DM (share)"
ShareForageCrops."Forage crops in Feed DM (share)"
ShareConcentrates."Concentrates in Feed DM (share)"
ShareResidues."Residues in Feed DM (share)"
/;

*3.2) Link to the core model parameters                             AnimalTypeInHerd,

ActAnimalsHead_OtherChar(Regions,Activities,"AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond")
                 $(NOT ActAnimalsHead_OtherChar(Regions,Activities,"AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond"))
         = sum((FAOSTAT_LiveAnimalsItems,FAOSTAT_Countries,FeedingRationsShares)$(MatchFaostatLiveAnimalItems_Activities(FAOSTAT_LiveAnimalsItems,Activities)
                   AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)
                   AND Match_FeedRationShare_OtherCharAnimals(FeedingRationsShares,OtherCharAnimals)),
                 VariousSources_FeedingRationsData(FAOSTAT_Countries,FAOSTAT_LiveAnimalsItems,FeedingRationsShares));

*assign values from horses to game:
ActAnimalsHead_OtherChar(Regions,"Game","AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond")
                 $(NOT ActAnimalsHead_OtherChar(Regions,"Game","AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond"))
         = ActAnimalsHead_OtherChar(Regions,"Horses","AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond");


*not needed: all info in per head param, APU only assigned later in Steering 2 towards the end
*NOT NEEDED ANYMORE - as the above is per head directly - was per APU earlier (the lines above) -
*also assign to per head parameter:
*ActAnimalsHead_OtherChar(Regions,Activities,"AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond")
*                 $(NOT ActAnimalsHead_OtherChar(Regions,Activities,"AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond"))
*         = ActAnimalsAPU_OtherChar(Regions,Activities,"AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond");


*and also assign to the parameters and variables FeedingRations:
Set Match_OtherCharAnimals_CommodityGroups(OtherCharAnimals,Commodities)
/
"Concentrates in Feed DM (share)" .AggregateFeedConcentrates_Commodity
"Forage crops in Feed DM (share)" .AggregateFeedForageCrops_Commodity
"Grass in Feed DM (share)"        .AggregateFeedGrass_Commodity
"Residues in Feed DM (share)"     .AggregateFeedResidues_Commodity
/;

FeedingRations_OtherChar(Regions,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond")
         = sum(OtherCharAnimals$Match_OtherCharAnimals_CommodityGroups(OtherCharAnimals,Commodities),
                 ActAnimalsHead_OtherChar(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst","AllProdCond"));

*and assign to AnimalTypeInHerd for Cattle and pigs as well:
FeedingRations_OtherChar(Regions,"Cattle",CattleTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond")
         = FeedingRations_OtherChar(Regions,"Cattle","AllAndAverageTypes",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond");
FeedingRations_OtherChar(Regions,"Pigs",PigTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond")
         = FeedingRations_OtherChar(Regions,"Pigs","AllAndAverageTypes",Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond");


$ontext;
After this we have the following in SOLm-entities:

ActAnimalsHead_OtherChar(Regions,Activities,"AllAndAverageTypes",OtherCharAnimals,"AllProdSyst","AllProdCond")

*not needed: all info in per head param, APU only assigned later in Steering 2 towards the end
ActAnimalsAPU_OtherChar(Regions,Activities,AnimalTypeInHerd,OtherCharAnimals,"AllProdSyst","AllProdCond")

FeedingRations_OtherChar(Regions,Activities,AnimalTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond")
FeedingRations_OtherChar(Regions,"Cattle",CattleTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond")
FeedingRations_OtherChar(Regions,"Pigs",PigTypeInHerd,Commodities,"Quantity share in DM (share)","AllProdSyst","AllProdCond")

Regions              is      FAOSTAT_Countries
Activities           is      LiveAnimalsSOLmV5 and "Game"
OtherCharAnimals     is      share in feed - on aggregate, i.e. grass, forage crops, concentrates, residues
Commodities          is      aggregate feed groups, i.e. grass, forage crops, concentrates, residues

*XXX STILL TO BE DONE:

assign crop specific feeding rations!!

assign specific values for CH and AT from the Alpenprojekt
*$ontext;
Suggestion from Simon
FeedingRationsData("Switzerland","Cattle","All","All","Grass")         = 0.79;
FeedingRationsData("Switzerland","Cattle","All","All","ForageCrops")   = 0.09;
FeedingRationsData("Switzerland","Cattle","All","All","Concentrates")  = 0.08;
FeedingRationsData("Switzerland","Cattle","All","All","Residues")      = 0.04;
FeedingRationsData("Switzerland","Sheep","All","All","Grass")         = 0.79;
FeedingRationsData("Switzerland","Sheep","All","All","ForageCrops")   = 0.09;
FeedingRationsData("Switzerland","Sheep","All","All","Concentrates")  = 0.08;
FeedingRationsData("Switzerland","Sheep","All","All","Residues")      = 0.04;
FeedingRationsData("Switzerland","Pigs","All","All","Grass")         = 0;
FeedingRationsData("Switzerland","Pigs","All","All","ForageCrops")   = 0.15;
FeedingRationsData("Switzerland","Pigs","All","All","Concentrates")  = 0.85;
FeedingRationsData("Switzerland","Pigs","All","All","Residues")      = 0;
*$offtext;

*Residues caused some problems - I therefore dropped them, as they are unimportant anyway

*adapted to better reflect supply:
FeedingRationsData("Switzerland","Cattle","All","All","Grass")         = 0.82;
*FeedingRationsData("Switzerland","Cattle","All","All","ForageCrops")   = 0.08;
FeedingRationsData("Switzerland","Cattle","All","All","ForageCrops")   = 0.09;
FeedingRationsData("Switzerland","Cattle","All","All","Concentrates")  = 0.09;
*FeedingRationsData("Switzerland","Cattle","All","All","Residues")      = 0.01;
FeedingRationsData("Switzerland","Cattle","All","All","Residues")      = 0.00;
FeedingRationsData("Switzerland","Sheep","All","All","Grass")         = 0.85;
FeedingRationsData("Switzerland","Sheep","All","All","ForageCrops")   = 0.07;
FeedingRationsData("Switzerland","Sheep","All","All","Concentrates")  = 0.08;
FeedingRationsData("Switzerland","Sheep","All","All","Residues")      = 0;
FeedingRationsData("Switzerland","Pigs","All","All","Grass")         = 0;
FeedingRationsData("Switzerland","Pigs","All","All","ForageCrops")   = 0.14;
FeedingRationsData("Switzerland","Pigs","All","All","Concentrates")  = 0.86;
FeedingRationsData("Switzerland","Pigs","All","All","Residues")      = 0;

FeedingRationsData("Austria","Cattle","All","All","Grass")         = 0.82;
*FeedingRationsData("Austria","Cattle","All","All","ForageCrops")   = 0.08;
FeedingRationsData("Austria","Cattle","All","All","ForageCrops")   = 0.09;
FeedingRationsData("Austria","Cattle","All","All","Concentrates")  = 0.09;
*FeedingRationsData("Austria","Cattle","All","All","Residues")      = 0.01;
FeedingRationsData("Austria","Cattle","All","All","Residues")      = 0.00;
FeedingRationsData("Austria","Sheep","All","All","Grass")         = 0.85;
FeedingRationsData("Austria","Sheep","All","All","ForageCrops")   = 0.07;
FeedingRationsData("Austria","Sheep","All","All","Concentrates")  = 0.08;
FeedingRationsData("Austria","Sheep","All","All","Residues")      = 0;
FeedingRationsData("Austria","Pigs","All","All","Grass")         = 0;
FeedingRationsData("Austria","Pigs","All","All","ForageCrops")   = 0.14;
FeedingRationsData("Austria","Pigs","All","All","Concentrates")  = 0.86;
FeedingRationsData("Austria","Pigs","All","All","Residues")      = 0;



$offtext;







