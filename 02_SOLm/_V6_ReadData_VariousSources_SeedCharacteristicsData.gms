PUTCLOSE con,"_V6_ReadData_VariousSources_SeedCharacteristicsData";

$ontext;
GENERAL DESCRIPTION
This file reads and/or assigns the seed characteristics (seed quantity, DM, N and P contents) data of the items (activities):

DETAILED TABLE OF CONTENTS
- 1) Data used in earlier SOLm versions: latest in SOLmV4
        1.1) Seed N contents
        1.2) Seed P2O5 contents
        1.3) Seed DM contents
        1.4) Seed ratio (kg seeds/ha)
- 2) OTHER XXX
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
$offtext;


*ATTENTION: THis data currently covers a subset of crops only - see below;
*        and the values need to be checked again!!! -
*        furthermore, the sources of the data are unclear


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) Data used in earlier SOLm versions: latest in SOLmV4

*This data is taken from a specific excel file, where it has been collected - as there are few entries only, we do not read in this file, but define the values directly below.

*general: P is in P2O5
*Units: N,P2O5 contents in quantities, i.e. rations: 0.007=0.7% = 0.007 tons / ton, etc.)

Parameter VariousSources_Seeds_NContents(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_Seeds_PContents(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_Seeds_DMContents(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);
Parameter VariousSources_SeedRate(FAOSTAT_CountriesAndRegions,FAOSTAT_CropProductionItems);

*Units: Seed quantities (kg/Ha*a) and ton N,P2O5/ton seeds (per ton fresh matter!; rations: 0.007=0.7% = 0.007 tons / ton, etc.)

*1.1) Seed N contents

VariousSources_Seeds_NContents(FAOSTAT_Countries,"Bambara beans")        = 0.04;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Barley")               = 0.0127;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Beans, dry")           = 0.0375;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Broad beans, horse beans, dry") = 0.037;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Buckwheat")            = 0.055;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Cassava")              = 0.0016;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Cereals, nes")         = 0.015;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Chick peas")           = 0.0547;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Cow peas, dry")        = 0.0786;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Fonio")                = 0.0146;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Groundnuts, with shell") = 0.04;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Hempseed")             = 0.059;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Lentils")              = 0.0525;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Lupins")               = 0.0525;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Maize")                = 0.0136;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Maize, green")         = 0.0136;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Millet")               = 0.024;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Grain, mixed")         = 0.05;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Mustard seed")         = 0.059;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Oats")                 = 0.0198;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Peas, dry")            = 0.0525;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Pigeon peas")          = 0.0786;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Potatoes")             = 0.0035;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Pulses, nes")          = 0.0525;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Quinoa")               = 0.055;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Rapeseed")             = 0.059;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Rice, paddy")          = 0.0146;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Roots and Tubers, nes") = 0.0035;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Rye")                  = 0.0147;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Seed cotton")          = 0.0624;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Sorghum")              = 0.055;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Soybeans")             = 0.0664;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Taro (cocoyam)")       = 0.0045;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Triticale")            = 0.014;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Vetches")              = 0.0525;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Wheat")                = 0.014;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Yams")                 = 0.0039;
VariousSources_Seeds_NContents(FAOSTAT_Countries,"Yautia (cocoyam)")     = 0.0045;


*1.2) Seed P2O5 contents
*P->P2O5 is *2.29157 (2*30.97+5*16)/(2*30.97)

VariousSources_Seeds_PContents(FAOSTAT_Countries,"Bambara beans")        = 0.008;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Barley")               = 0.006;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Beans, dry")           = 0.0046;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Broad beans, horse beans, dry") = 0.0075;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Buckwheat")            = 0.015;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Cassava")              = 0.0007;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Cereals, nes")         = 0.008;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Chick peas")           = 0.0095;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Cow peas, dry")        = 0.0224;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Fonio")                = 0.006;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Groundnuts, with shell") = 0.008;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Hempseed")             = 0.025;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Lentils")              = 0.0119;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Lupins")               = 0.0119;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Maize")                = 0.0075;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Maize, green")         = 0.0075;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Millet")               = 0.016;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Grain, mixed")         = 0.008;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Mustard seed")         = 0.025;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Oats")                 = 0.0064;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Peas, dry")            = 0.0119;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Pigeon peas")          = 0.0224;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Potatoes")             = 0.001;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Pulses, nes")          = 0.0119;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Quinoa")               = 0.015;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Rapeseed")             = 0.025;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Rice, paddy")          = 0.006;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Roots and Tubers, nes") = 0.001;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Rye")                  = 0.0059;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Seed cotton")          = 0.0144;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Sorghum")              = 0.015;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Soybeans")             = 0.012;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Taro (cocoyam)")       = 0.0024;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Triticale")            = 0.008;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Vetches")              = 0.0119;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Wheat")                = 0.008;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Yams")                 = 0.0011;
VariousSources_Seeds_PContents(FAOSTAT_Countries,"Yautia (cocoyam)")     = 0.0024;


*1.3) Seed DM contents
*DM contents from crop seeds
*unit: tons per ton, i.e. 0.88 is 88%
*ATTENTION - missing data: to be improved!! - we just largely use the data from primaryproduct DM values for the crops where we hacve seeding ration information, see below.
*to  be improved, as e.g. potatoes are seeded via potatoes - bit cassava, yams, etc. - not, thus "seeds" are not the primary product itself

VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Bambara beans")        = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Barley")               = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Beans, dry")           = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Broad beans, horse beans, dry") = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Buckwheat")            = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Cassava")              = 0.22;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Cereals, nes")         = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Chick peas")           = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Cow peas, dry")        = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Fonio")                = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Groundnuts, with shell") = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Hempseed")             = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Lentils")              = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Lupins")               = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Maize")                = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Maize, green")         = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Millet")               = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Grain, mixed")         = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Mustard seed")         = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Oats")                 = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Peas, dry")            = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Pigeon peas")          = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Potatoes")             = 0.22;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Pulses, nes")          = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Quinoa")               = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Rapeseed")             = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Rice, paddy")          = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Roots and Tubers, nes") = 0.22;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Rye")                  = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Seed cotton")          = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Sorghum")              = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Soybeans")             = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Taro (cocoyam)")       = 0.22;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Triticale")            = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Vetches")              = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Wheat")                = 0.89;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Yams")                 = 0.22;
VariousSources_Seeds_DMContents(FAOSTAT_Countries,"Yautia (cocoyam)")     = 0.22;


*1.4) Seed ratio (kg seeds/ha)
*To be improved, currently, values from teh excel-sheet mentioned above are improved based on http://www.saatgut-austria.at/page.asp/-/Saatstaerketabellen:
*parts also from https://www.hesa.co.at/upload/2085306_HESA_Saatst~c3~a4rkentabelle.pdf.
*to do: search for this systematically

VariousSources_SeedRate(FAOSTAT_Countries,"Bambara beans")        = 125;
VariousSources_SeedRate(FAOSTAT_Countries,"Barley")               = 150;
VariousSources_SeedRate(FAOSTAT_Countries,"Beans, dry")           = 240;
VariousSources_SeedRate(FAOSTAT_Countries,"Broad beans, horse beans, dry") = 240;
*buckwehat: take something like cereals, but somewhat less
VariousSources_SeedRate(FAOSTAT_Countries,"Buckwheat")            = 100;
VariousSources_SeedRate(FAOSTAT_Countries,"Cassava")              = 900;
VariousSources_SeedRate(FAOSTAT_Countries,"Cereals, nes")         = 150;
*as pulses, somewhat less
VariousSources_SeedRate(FAOSTAT_Countries,"Chick peas")           = 180;
VariousSources_SeedRate(FAOSTAT_Countries,"Cow peas, dry")        = 240;
*as ceereals, somewhat less
VariousSources_SeedRate(FAOSTAT_Countries,"Fonio")                = 100;
VariousSources_SeedRate(FAOSTAT_Countries,"Groundnuts, with shell") = 125;
VariousSources_SeedRate(FAOSTAT_Countries,"Hempseed")             = 160;
VariousSources_SeedRate(FAOSTAT_Countries,"Lentils")              = 50;
VariousSources_SeedRate(FAOSTAT_Countries,"Lupins")               = 150;
VariousSources_SeedRate(FAOSTAT_Countries,"Maize")                = 22;
VariousSources_SeedRate(FAOSTAT_Countries,"Maize, green")         = 22;
VariousSources_SeedRate(FAOSTAT_Countries,"Millet")               = 100;
VariousSources_SeedRate(FAOSTAT_Countries,"Grain, mixed")         = 150;
VariousSources_SeedRate(FAOSTAT_Countries,"Mustard seed")         = 160;
VariousSources_SeedRate(FAOSTAT_Countries,"Oats")                 = 145;
VariousSources_SeedRate(FAOSTAT_Countries,"Peas, dry")            = 240;
VariousSources_SeedRate(FAOSTAT_Countries,"Pigeon peas")          = 240;
VariousSources_SeedRate(FAOSTAT_Countries,"Potatoes")             = 3000;
VariousSources_SeedRate(FAOSTAT_Countries,"Pulses, nes")          = 240;
VariousSources_SeedRate(FAOSTAT_Countries,"Quinoa")               = 50;
VariousSources_SeedRate(FAOSTAT_Countries,"Rapeseed")             = 5;
*rice as cereals, somewhat less
VariousSources_SeedRate(FAOSTAT_Countries,"Rice, paddy")          = 100;
VariousSources_SeedRate(FAOSTAT_Countries,"Roots and Tubers, nes") = 3000;
VariousSources_SeedRate(FAOSTAT_Countries,"Rye")                  = 120;
VariousSources_SeedRate(FAOSTAT_Countries,"Seed cotton")          = 80;
VariousSources_SeedRate(FAOSTAT_Countries,"Sorghum")              = 40;
*soybeans as pulses, somewhat less
VariousSources_SeedRate(FAOSTAT_Countries,"Soybeans")             = 180;
VariousSources_SeedRate(FAOSTAT_Countries,"Sunflower seed")       = 5;
VariousSources_SeedRate(FAOSTAT_Countries,"Taro (cocoyam)")       = 900;
VariousSources_SeedRate(FAOSTAT_Countries,"Triticale")            = 170;
VariousSources_SeedRate(FAOSTAT_Countries,"Vetches")              = 13.75;
VariousSources_SeedRate(FAOSTAT_Countries,"Wheat")                = 170;
VariousSources_SeedRate(FAOSTAT_Countries,"Yams")                 = 900;
VariousSources_SeedRate(FAOSTAT_Countries,"Yautia (cocoyam)")     = 900;




****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*2) OTHER XXX Data





$ontext;
after this, we have:
Parameter VariousSources_Seeds_NContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter VariousSources_Seeds_PContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter VariousSources_Seeds_DMContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
Parameter VariousSources_SeedRate(FAOSTAT_Countries,FAOSTAT_CropProductionItems);
$offtext;



****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed


*no new files needed


*3.2) Link to the core model parameters

*division by 1000, as the original unit is kg seed/ha
*this overwrites the seed input data derived in the FAOSTAT CropProduction module based on total seed quantities and areas
ActCropsGrass_Inputs(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_SeedRate(FAOSTAT_Countries,FAOSTAT_CropProductionItems)/1000);

*units: per ton seed
SeedContents(Regions,Activities,"N (t)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_Seeds_NContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems));
SeedContents(Regions,Activities,"P2O5 (t)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_Seeds_PContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems));
SeedContents(Regions,Activities,"DM (t)","AllProdSyst","AllProdCond")
         = sum((FAOSTAT_Countries,FAOSTAT_CropProductionItems)$(MatchFAOSTATCropProduction_Activities(FAOSTAT_CropProductionItems,Activities)
                         AND MatchFAOSTATCountries_Regions(FAOSTAT_Countries,Regions)),
                 VariousSources_Seeds_DMContents(FAOSTAT_Countries,FAOSTAT_CropProductionItems));


*source for seed/ha, see above
*assign values for forage maize and, sugar beets and beets for fodder:
ActCropsGrass_Inputs(Regions,"Maize for Forage+Silage","Seeds (t)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Inputs(Regions,"Maize","Seeds (t)","AllProdSyst","AllProdCond");
SeedContents(Regions,"Maize for Forage+Silage",Contents,"AllProdSyst","AllProdCond")
         = SeedContents(Regions,"Maize",Contents,"AllProdSyst","AllProdCond");

*to be improved - for now, choose some gross average values for seeds to have something:
ActCropsGrass_Inputs(Countries,"Sugar beet","Seeds (t)","AllProdSyst","AllProdCond") = 18/1000;
SeedContents(Countries,"Sugar beet","N (t)","AllProdSyst","AllProdCond") = 0.02;
SeedContents(Countries,"Sugar beet","P2O5 (t)","AllProdSyst","AllProdCond") = 0.01;
SeedContents(Countries,"Sugar beet","DM (t)","AllProdSyst","AllProdCond") = 0.89;
*Assume fodder beet identical to sugar beet:
ActCropsGrass_Inputs(Regions,"Beets for fodder","Seeds (t)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Inputs(Regions,"Sugar beet","Seeds (t)","AllProdSyst","AllProdCond");
SeedContents(Regions,"Beets for fodder",Contents,"AllProdSyst","AllProdCond")
         = SeedContents(Regions,"Sugar beet",Contents,"AllProdSyst","AllProdCond");




$ontext;
After this we have the following in SOLm-entities:

ActCropsGrass_Inputs(Regions,Activities,"Seeds (t)","AllProdSyst","AllProdCond")
SeedContents(Regions,Activities,Contents,"AllProdSyst","AllProdCond")

Regions      is      FAOSTAT_Countries
Activities   is      FAOSTAT_CropProductionItems
Contents     is      N, P2O5 DM (t) per ton seed

*XXX STILL TO BE DONE:
Check all data in this file and improve, differentiate, where needed and useful - make consistent with main prod contents where necessary (e.g. for wheat!)
* ADD: data on NON_FAOSTAT_CropPRoductionItems
$offtext;
