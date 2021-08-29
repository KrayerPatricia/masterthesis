PUTCLOSE con,"_V6_ReadData_VariousSources_BioenergySR15";

$ontext;
GENERAL DESCRIPTION
This file reads the data used in the IPCC SR1.5 to model bioenergy in the scenarios P3 and P4, where the reductions are achieved by massive use of bioenergy combined with CCS
Detailed description: see methods part of the MA of Selina Fürst

*DETAILED TABLE OF CONTENTS
- 1) reading the csv-file and loading the parameters
- 2) build average over the base year period chosen to get the baseline values
- 3) Assign values to core model parameters and variables
         3.1) Link some sets as needed
         3.2) Link to the core model parameters
                 3.2.1 data from IAMC
                 3.2.2 data from MAgPIE
                 3.2.3 data from REMIND
                 3.2.4 data from BioenergySR15_NFromConversion and BioenergySR15_EnergyConversion_DMInput_NOutput
                 3.2.5 data from BioenergySR15_NFertilizerUse
                 3.2.6) Derive country values from regional values
                 3.2.7) Derive fresh matter yields from DM yields and DM contents:
                 3.2.8) Assign Bioe-Res values to crop residue parameters and variables:
                 3.2.9) Assign useful parameters to baseline values
                 3.2.10) assign convent and organic values here, as we have no baseline values for BioeSR15, which are needed for assigning convent/organic values in assign initial values to scenarios
                 3.2.11) Some auxiliary variables used to adapt feed supply in the BioeSR15 scenarios
$offtext;


*MODEL CODE:

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*1) reading the csv-file and loading the parameters

*read csv files into gdx if something has changed - else directly load the gdx files, later on in the code
$ifthen %ReadNewBioenergySR15Data% == "YES"
*the original file from Selina Fürst has been named completedataP4.csv (on August 2, 2019); I renamed it when copying to SOLm
$call csv2gdx BioenergySR15_P4_2_8_2019.csv id=BioenergySR15_P4 Index=(1,2,3,4,5,6) Values=(7..17) UseHeader=Y

*the original file from Selina Fürst has been named "Namount from conversion.csv" (on August 7, 2019); I renamed it when copying to SOLm
$call csv2gdx BioenergySR15_NFromConversion_7_8_2019.csv id=BioenergySR15_NFromConversion Index=(1,2,3,4,5,6) Values=(7..17) UseHeader=Y

*additional information on the total DM input into and the total N output from the bioenergy production is contained in P4_Nconv from 24.8.2019;
*I renamed this into BioenergySR15_EnergysystemDMInputNOutput_24_8_2019.csv and later use these variables only from this file
$call csv2gdx BioenergySR15_EnergysystemDMInputNOutput_24_8_2019.csv id=BioenergySR15_EnergyConversion_DMInput_NOutput Index=(1,2,3,4,5,6) Values=(7..17) UseHeader=Y

*the original file from Selina Fürst has been named "Nfert.csv" (on August 7, 2019); I renamed it when copying to SOLm
$call csv2gdx BioenergySR15_NFertilizerUse_7_8_2019.csv id=BioenergySR15_NFertilizerUse Index=(1,2,3,4,5,6) Values=(7..17) UseHeader=Y


$endif;


*the data in the csv above is organised as follows:
*Header: Model,"Scenario","Source","Region","Variable","Unit","X2005","X2010","X2020","X2030","X2040","X2050","X2060","X2070","X2080","X2090","X2100"
*Index are the entries 1-6; the years are given in columns 7-17


*the following sets are needed to read this data:
*we use other names than in the original file, as some of the labels are already assigned in SOLm or in GAMS in general (e.g. Model)
Set BioeSR15_Model
/
"REMIND-MAgPIE 1.5"
"REMIND-MAGPIE"
/;
Set BioeSR15_Scenario
/
"SSP5-19"
/;
Set BioeSR15_Source
/
"IAMC"
"REMIND"
"MAgPIE"
/;
Set BioeSR15_Region(Regions)
/
R5ASIA
R5LAM
R5MAF
"R5OECD90+EU"
R5REF
World
AFR
CHN
EUR
IND
JPN
LAM
MEA
OAS
ROW
RUS
USA
CPA
FSU
NAM
PAO
PAS
SAS
/;
Set BioeSR15_Variable
*cd stands for Climate Diagnostics - we replaced this as it made variable names too long for GAMS
/
"Agricultural Demand|Crops"
"Agricultural Demand|Livestock"
"Agricultural Production|Energy|Crops"
"Agricultural Production|Non-Energy|Crops"
"Agricultural Production|Non-Energy|Livestock"
"Capacity|Electricity"
"Capacity|Electricity|Biomass"
"Capacity|Electricity|Coal"
"Capacity|Electricity|Gas"
"Capacity|Electricity|Geothermal"
"Capacity|Electricity|Hydro"
"Capacity|Electricity|Nuclear"
"Capacity|Electricity|Solar"
"Capacity|Electricity|Wind"
"Carbon Sequestration|CCS"
"Carbon Sequestration|CCS|Biomass"
"Carbon Sequestration|CCS|Fossil"
"Emissions|BC"
"Emissions|CH4"
"Emissions|CH4|AFOLU"
"Emissions|CH4|Energy"
"Emissions|CO"
"Emissions|CO2"
"Emissions|CO2|AFOLU"
"Emissions|CO2|Energy and Industrial Processes"
"Emissions|CO2|Energy|Demand"
"Emissions|CO2|Energy|Supply"
"Emissions|CO2|Energy|Supply|Electricity"
"Emissions|F-Gases"
"Emissions|Kyoto Gases"
"Emissions|N2O"
"Emissions|N2O|AFOLU"
"Emissions|NH3"
"Emissions|NOx"
"Emissions|OC"
"Emissions|Sulfur"
"Emissions|VOC"
"Final Energy"
"Final Energy|Electricity"
"Final Energy|Gases"
"Final Energy|Heat"
"Final Energy|Hydrogen"
"Final Energy|Liquids"
"Final Energy|Solids"
"Final Energy|Solids|Biomass"
"Final Energy|Solids|Biomass|Traditional"
"Final Energy|Solids|Coal"
"Final Energy|Transportation"
"Final Energy|Transportation|Electricity"
"Final Energy|Transportation|Hydrogen"
"Final Energy|Transportation|Liquids"
"Final Energy|Transportation|Liquids|Biomass"
"Food Demand"
"Food Demand|Crops"
"Food Demand|Livestock"
"GDP|PPP"
"Land Cover|Built-up Area"
"Land Cover|Cropland"
"Land Cover|Cropland|Energy Crops|Miscanthus"
"Land Cover|Forest"
"Land Cover|Other Natural Land"
"Land Cover|Pasture"
"Population"
"Price|Carbon"
"Primary Energy"
"Primary Energy|Biomass"
"Primary Energy|Biomass|Modern|w/ CCS"
"Primary Energy|Biomass|Modern|w/o CCS"
"Primary Energy|Biomass|Traditional"
"Primary Energy|Coal"
"Primary Energy|Coal|w/ CCS"
"Primary Energy|Coal|w/o CCS"
"Primary Energy|Fossil"
"Primary Energy|Fossil|w/ CCS"
"Primary Energy|Fossil|w/o CCS"
"Primary Energy|Gas"
"Primary Energy|Gas|w/ CCS"
"Primary Energy|Gas|w/o CCS"
"Primary Energy|Geothermal"
"Primary Energy|Hydro"
"Primary Energy|Non-Biomass Renewables"
"Primary Energy|Nuclear"
"Primary Energy|Oil"
"Primary Energy|Oil|w/o CCS"
"Primary Energy|Solar"
"Primary Energy|Wind"
"Secondary Energy|Electricity"
"Secondary Energy|Electricity|Biomass"
"Secondary Energy|Electricity|Biomass|w/ CCS"
"Secondary Energy|Electricity|Biomass|w/o CCS"
"Secondary Energy|Electricity|Coal"
"Secondary Energy|Electricity|Coal|w/ CCS"
"Secondary Energy|Electricity|Coal|w/o CCS"
"Secondary Energy|Electricity|Gas"
"Secondary Energy|Electricity|Gas|w/ CCS"
"Secondary Energy|Electricity|Gas|w/o CCS"
"Secondary Energy|Electricity|Geothermal"
"Secondary Energy|Electricity|Hydro"
"Secondary Energy|Electricity|Non-Biomass Renewables"
"Secondary Energy|Electricity|Nuclear"
"Secondary Energy|Electricity|Oil"
"Secondary Energy|Electricity|Solar"
"Secondary Energy|Electricity|Wind"
"Secondary Energy|Gases"
"Secondary Energy|Gases|Biomass"
"Secondary Energy|Gases|Coal"
"Secondary Energy|Gases|Natural Gas"
"Secondary Energy|Heat"
"Secondary Energy|Heat|Geothermal"
"Secondary Energy|Hydrogen"
"Secondary Energy|Hydrogen|Biomass"
"Secondary Energy|Hydrogen|Biomass|w/ CCS"
"Secondary Energy|Hydrogen|Biomass|w/o CCS"
"Secondary Energy|Hydrogen|Electricity"
"Secondary Energy|Liquids"
"Secondary Energy|Liquids|Biomass"
"Secondary Energy|Liquids|Biomass|w/ CCS"
"Secondary Energy|Liquids|Biomass|w/o CCS"
"Secondary Energy|Liquids|Coal"
"Secondary Energy|Liquids|Coal|w/ CCS"
"Secondary Energy|Liquids|Coal|w/o CCS"
"Secondary Energy|Liquids|Oil"
"Secondary Energy|Solids"
"cd|Concentration|CO2|FAIR|MED"
"cd|Concentration|CO2|MAGICC6|MED"
"cd|Forcing|Aerosol|Direct|MAGICC6|MED"
"cd|Forcing|Aerosol|MAGICC6|MED"
"cd|Forcing|Aerosol|Total|FAIR|MED"
"cd|Forcing|Aerosol|Total|MAGICC6|MED"
"cd|Forcing|CH4|FAIR|MED"
"cd|Forcing|CH4|MAGICC6|MED"
"cd|Forcing|CO2|FAIR|MED"
"cd|Forcing|CO2|MAGICC6|MED"
"cd|Forcing|F-Gases|MAGICC6|MED"
"cd|Forcing|FAIR|MED"
"cd|Forcing|Kyoto Gases|MAGICC6|MED"
"cd|Forcing|MAGICC6|MED"
"cd|Forcing|Montreal Protocol (orig.) gases|MAGICC6|MED"
"cd|Forcing|N2O|FAIR|MED"
"cd|Forcing|N2O|MAGICC6|MED"
"cd|Forcing|OtherGHGs|FAIR|MED"
"cd|Forcing|Tropospheric Ozone|FAIR|MED"
"cd|Forcing|Tropospheric Ozone|MAGICC6|MED"
"cd|Temperature|Exceedance Probability|1.0 °C|FAIR"
"cd|Temperature|Exceedance Probability|1.0 °C|MAGICC6"
"cd|Temperature|Exceedance Probability|1.5 °C|FAIR"
"cd|Temperature|Exceedance Probability|1.5 °C|MAGICC6"
"cd|Temperature|Exceedance Probability|2.0 °C|FAIR"
"cd|Temperature|Exceedance Probability|2.0 °C|MAGICC6"
"cd|Temperature|Exceedance Probability|2.5 °C|MAGICC6"
"cd|Temperature|Exceedance Probability|3.0 °C|MAGICC6"
"cd|Temperature|Exceedance Probability|3.5 °C|MAGICC6"
"cd|Temperature|Exceedance Probability|4.0 °C|MAGICC6"
"cd|Temperature|Global Mean|FAIR|Expected value"
"cd|Temperature|Global Mean|FAIR|Expected value|Non CO2"
"cd|Temperature|Global Mean|FAIR|MED"
"cd|Temperature|Global Mean|FAIR|MED|Non CO2"
"cd|Temperature|Global Mean|FAIR|P5"
"cd|Temperature|Global Mean|FAIR|P5|Non CO2"
"cd|Temperature|Global Mean|FAIR|P66"
"cd|Temperature|Global Mean|FAIR|P66|Non CO2"
"cd|Temperature|Global Mean|FAIR|P90"
"cd|Temperature|Global Mean|FAIR|P90|Non CO2"
"cd|Temperature|Global Mean|FAIR|P95"
"cd|Temperature|Global Mean|FAIR|P95|Non CO2"
"cd|Temperature|Global Mean|MAGICC6|Expected value"
"cd|Temperature|Global Mean|MAGICC6|Expected value|Non CO2"
"cd|Temperature|Global Mean|MAGICC6|MED"
"cd|Temperature|Global Mean|MAGICC6|P5"
"cd|Temperature|Global Mean|MAGICC6|P66"
"cd|Temperature|Global Mean|MAGICC6|P90"
"cd|Temperature|Global Mean|MAGICC6|P95"
"Consumption"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|BC"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|C2F6"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|C6F14"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|CH4"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|CO"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|CO2|AFOLU"
*Diagnostics|MAGICC6|Harmonized Input|Emissions|CO2|Energy and Industrial Processes
*The preceeding is too long, thus we replaced by the following:
"Diagnostics|MAGICC6|Harmonized Input|Emissions|CO2|EIProc"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|HFC|HFC125"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|HFC|HFC134a"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|HFC|HFC143a"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|HFC|HFC227ea"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|HFC|HFC23"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|HFC|HFC245ca"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|HFC|HFC32"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|HFC|HFC43-10"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|N2O"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|NH3"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|NOx"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|OC"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|PFC"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|SF6"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|Sulfur"
"Diagnostics|MAGICC6|Harmonized Input|Emissions|VOC"
"Emissions|Kyoto Gases (AR4-GWP100)"
"Emissions|Kyoto Gases (AR5-GWP100)"
"Emissions|Kyoto Gases (SAR-GWP100)"
"Primary Energy|Biomass|1st Generation"
"Primary Energy|Biomass|Energy Crops|Miscanthus"
"Primary Energy|Biomass|Residues"
"Land Cover"
"Land Cover|Forest|Forestry"
"Land Cover|Forest|Natural Forest"
"Land Cover|Cropland|Irrigated"
"Land Cover|Cropland|Cereals"
"Yield|Cereal"
"Yield|Oilcrops"
"Yield|Sugarcrops"
"Yield|Energy Crops|Miscanthus"
"Water|Withdrawal|Irrigation"
"Fertilizer Use|Nitrogen"
"Food Demand|Per Capita"
"Food Demand|Livestock|Per Capita"
"Food Demand|Crops|Per Capita"
"Agricultural Demand"
"Agricultural Demand|Food"
"Agricultural Demand|Feed"
"Agricultural Demand|Bioenergy"
"Agricultural Demand|Bioenergy|1st generation"
"Agricultural Demand|Bioenergy|2nd generation"
"Agricultural Production|Crops|Energy"
"Agricultural Production|Crops|Non-Energy"
"Agricultural Production|Crops|Non-Energy|Cereals"
"Agricultural Production"
"Agricultural Production|Livestock"
"Biomass|1st Generation"
"Biomass|Energy Crops|Miscanthus"

"N from Anaerobic Digestion|low 164.7CH4 3.4N"
"N from Anaerobic Digestion|high 200.6CH4 4.9N"
"N from Fermentation|Agroforest Residues"
"N from Fermentation|Miscanthus"
"N from Fermentation|Total"
"Secondary Energy|Electricity|Deficit|EtOH residues"

"Agricultural Production|Crops|Energy|Miscanthus"
"Agricultural Production for CH4|Miscanthus"
"Agricultural Production|Miscanthus|for ethanol"
"Feedstock|Biomass|Residues"
"Feedstock for CH4|Residues"
"Feedstock|Agroforest Residues|for ethanol"
"N from Anaerobic Digestion|Miscanthus|3.4N"
"N from Anaerobic Digestion|Miscanthus|4.9 N"
"N from Anaerobic Digestion|Miscanthus|4.9N"
"N from Anaerobic Digestion|Residues|3.4N"
"N from Anaerobic Digestion|Residues|4.9 N"
"N from Anaerobic Digestion|Residues|4.9N"
*"N from Fermentation|Agroforest Residues"
*"N from Fermentation|Miscanthus"
"Energy System Input P4|Miscanthus"
"Energy System Output P4|Miscanthus|Nitrogen|3.4N"
"Energy System Output P4|Miscanthus|Nitrogen|4.9N"
"Energy System Input P4|Residues"
"Energy System Output P4|Residues|Nitrogen|3.4N"
"Energy System Output P4|Residues|Nitrogen|4.9N"

"Fertilization Use|Energy Crops|Miscanthus|Low3.4"
"Fertilization Use|Energy Crops|Miscanthus|Up4.9"
"Fertilization Use|Energy Crops|Miscanthus|4.15"
/;


Set BioeSR15_Unit
/
"million t DM/yr"
"GW"
"Mt CO2/yr"
"Mt BC/yr"
"Mt CH4/yr"
"Mt CO/yr"
"Mt CO2-equiv/yr"
"kt N2O/yr"
"Mt NH3/yr"
"Mt NO2/yr"
"Mt OC/yr"
"Mt SO2/yr"
"Mt VOC/yr"
"EJ/yr"
"kcal/cap/day"
"billion US$2010/yr"
"million ha"
"million"
"US$2010/t CO2"
"ppm"
"W/m2"
"°C"
"kt C2F6/yr"
"kt C6F14/yr"
"kt HFC23/yr"
"kt CF4/yr"
"kt SF6/yr"
"t DM/ha/yr"
"Tg N/yr"
*the following is misspelled in the data, thus replace with the previous (See code further down)
"T g N/yr"
"million m3/yr"
/;

*and files indicating which countries belong to which region in which model:
*the original file from Selina Fürst has been named "countriesbymodelregion.csv" (on August 6, 2019); I renamed it when copying to SOLm, now it is called BioenergySR15_CountriesByModelRegion_6_8_2019
*but reading it is difficult, also separating into the different assignments, so we do it by hand below (TO BE IMPROVED LATER - check how to do this elegantly from the csv-file....):
Set BioenergySR15_CountriesByModelRegion_IAMC(Regions,BioeSR15_Region)
/
Afghanistan                              ."R5ASIA"
Albania                                  ."R5OECD90+EU"
Algeria                                  ."R5MAF"
Angola                                   ."R5MAF"
Argentina                                ."R5LAM"
Armenia                                  ."R5REF"
Aruba                                    ."R5LAM"
Australia                                ."R5OECD90+EU"
Austria                                  ."R5OECD90+EU"
Azerbaijan                               ."R5REF"
Bahamas                                  ."R5LAM"
Bahrain                                  ."R5MAF"
Bangladesh                               ."R5ASIA"
Barbados                                 ."R5LAM"
Belarus                                  ."R5REF"
Belgium                                  ."R5OECD90+EU"
Belize                                   ."R5LAM"
Benin                                    ."R5MAF"
Bhutan                                   ."R5ASIA"
"Bolivia (Plurinational State of)"       ."R5LAM"
"Bosnia and Herzegovina"                 ."R5OECD90+EU"
Botswana                                 ."R5MAF"
Brazil                                   ."R5LAM"
"Brunei Darussalam"                      ."R5ASIA"
Bulgaria                                 ."R5OECD90+EU"
"Burkina Faso"                           ."R5MAF"
Burundi                                  ."R5MAF"
Cambodia                                 ."R5ASIA"
Cameroon                                 ."R5MAF"
Canada                                   ."R5OECD90+EU"
"Cabo Verde"                             ."R5MAF"
"Central African Republic"               ."R5MAF"
Chad                                     ."R5MAF"
Chile                                    ."R5LAM"
China                                    ."R5ASIA"
Colombia                                 ."R5LAM"
Comoros                                  ."R5MAF"
Congo                                    ."R5MAF"
"Costa Rica"                             ."R5LAM"
"Côte d'Ivoire"                          ."R5MAF"
Croatia                                  ."R5OECD90+EU"
Cuba                                     ."R5LAM"
Cyprus                                   ."R5OECD90+EU"
"Czechia"                                ."R5OECD90+EU"
"Democratic People's Republic of Korea"  ."R5ASIA"
"Democratic Republic of the Congo"       ."R5MAF"
Denmark                                  ."R5OECD90+EU"
Djibouti                                 ."R5MAF"
"Dominican Republic"                     ."R5LAM"
Ecuador                                  ."R5LAM"
Egypt                                    ."R5MAF"
"El Salvador"                            ."R5LAM"
"Equatorial Guinea"                      ."R5MAF"
Eritrea                                  ."R5MAF"
Estonia                                  ."R5OECD90+EU"
Ethiopia                                 ."R5MAF"
Swaziland                                ."R5MAF"
Fiji                                     ."R5ASIA"
Finland                                  ."R5OECD90+EU"
France                                   ."R5OECD90+EU"
"French Guiana"                          ."R5LAM"
"French Polynesia"                       ."R5ASIA"
Gabon                                    ."R5MAF"
Gambia                                   ."R5MAF"
Georgia                                  ."R5REF"
Germany                                  ."R5OECD90+EU"
Ghana                                    ."R5MAF"
Greece                                   ."R5OECD90+EU"
*Greenland."R5OECD90+EU"."None"."EUR"
Grenada                                  ."R5LAM"
Guadeloupe                               ."R5LAM"
Guam                                     ."R5OECD90+EU"
Guatemala                                ."R5LAM"
Guinea                                   ."R5MAF"
"Guinea-Bissau"                          ."R5MAF"
Guyana                                   ."R5LAM"
Haiti                                    ."R5LAM"
Honduras                                 ."R5LAM"
Hungary                                  ."R5OECD90+EU"
Iceland                                  ."R5OECD90+EU"
India                                    ."R5ASIA"
Indonesia                                ."R5ASIA"
"Iran (Islamic Republic of)"             ."R5MAF"
Iraq                                     ."R5MAF"
Ireland                                  ."R5OECD90+EU"
Israel                                   ."R5MAF"
Italy                                    ."R5OECD90+EU"
Jamaica                                  ."R5LAM"
Japan                                    ."R5OECD90+EU"
Jordan                                   ."R5MAF"
Kazakhstan                               ."R5REF"
Kenya                                    ."R5MAF"
Kuwait                                   ."R5MAF"
Kyrgyzstan                               ."R5REF"
"Lao People's Democratic Republic"       ."R5ASIA"
Latvia                                   ."R5OECD90+EU"
Lebanon                                  ."R5MAF"
Lesotho                                  ."R5MAF"
Liberia                                  ."R5MAF"
Libya                                    ."R5MAF"
Lithuania                                ."R5OECD90+EU"
Luxembourg                               ."R5OECD90+EU"
Madagascar                               ."R5MAF"
Malawi                                   ."R5MAF"
Malaysia                                 ."R5ASIA"
Maldives                                 ."R5ASIA"
Mali                                     ."R5MAF"
Malta                                    ."R5OECD90+EU"
Martinique                               ."R5LAM"
Mauritania                               ."R5MAF"
Mauritius                                ."R5MAF"
Mayotte                                  ."R5MAF"
Mexico                                   ."R5LAM"
Micronesia                               ."R5ASIA"
"Republic of Moldova"                    ."R5REF"
Mongolia                                 ."R5ASIA"
Montenegro                               ."R5OECD90+EU"
Morocco                                  ."R5MAF"
Mozambique                               ."R5MAF"
Myanmar                                  ."R5ASIA"
Namibia                                  ."R5MAF"
Nepal                                    ."R5ASIA"
Netherlands                              ."R5OECD90+EU"
"New Caledonia"                          ."R5ASIA"
"New Zealand"                            ."R5OECD90+EU"
Nicaragua                                ."R5LAM"
Niger                                    ."R5MAF"
Nigeria                                  ."R5MAF"
Norway                                   ."R5OECD90+EU"
"Occupied Palestinian Territory"         ."R5MAF"
Oman                                     ."R5MAF"
Pakistan                                 ."R5ASIA"
Panama                                   ."R5LAM"
"Papua New Guinea"                       ."R5ASIA"
Paraguay                                 ."R5LAM"
Peru                                     ."R5LAM"
Philippines                              ."R5ASIA"
Poland                                   ."R5OECD90+EU"
Portugal                                 ."R5OECD90+EU"
"Puerto Rico"                            ."R5OECD90+EU"
Qatar                                    ."R5MAF"
"Republic Of Korea"                      ."R5ASIA"
*"Republic of Moldova"."R5REF"."FSU"."ROW"
Reunion                                  ."R5MAF"
Romania                                  ."R5OECD90+EU"
"Russian Federation"                     ."R5REF"
Rwanda                                   ."R5MAF"
Samoa                                    ."R5ASIA"
"Saudi Arabia"                           ."R5MAF"
Senegal                                  ."R5MAF"
Serbia                                   ."R5OECD90+EU"
"Sierra Leone"                           ."R5MAF"
Singapore                                ."R5ASIA"
Slovakia                                 ."R5OECD90+EU"
Slovenia                                 ."R5OECD90+EU"
"Solomon Islands"                        ."R5ASIA"
Somalia                                  ."R5MAF"
"South Africa"                           ."R5MAF"
"South Sudan"                            ."R5MAF"
Spain                                    ."R5OECD90+EU"
"Sri Lanka"                              ."R5ASIA"
Sudan                                    ."R5MAF"
Suriname                                 ."R5LAM"
*Swaziland."R5MAF"."AFR"."AFR"
Sweden                                   ."R5OECD90+EU"
Switzerland                              ."R5OECD90+EU"
"Syrian Arab Republic"                   ."R5MAF"
Taiwan                                   ."R5ASIA"
Tajikistan                               ."R5REF"
Thailand                                 ."R5ASIA"
"The former Yugoslav Republic of Macedonia" ."R5OECD90+EU"
"Timor-Leste"                            ."R5ASIA"
Togo                                     ."R5MAF"
"Trinidad and Tobago"                    ."R5LAM"
Tunisia                                  ."R5MAF"
Turkey                                   ."R5OECD90+EU"
Turkmenistan                             ."R5REF"
Uganda                                   ."R5MAF"
Ukraine                                  ."R5REF"
"United Arab Emirates"                   ."R5MAF"
"United Kingdom"                         ."R5OECD90+EU"
"United Republic of Tanzania"            ."R5MAF"
"United States of America"               ."R5OECD90+EU"
"United States Virgin Islands"           ."R5LAM"
Uruguay                                  ."R5LAM"
Uzbekistan                               ."R5REF"
Vanuatu                                  ."R5ASIA"
"Venezuela (Bolivarian Republic of)"     ."R5LAM"
"Viet Nam"                               ."R5ASIA"
"Western Sahara"                         ."R5MAF"
Yemen                                    ."R5MAF"
Zambia                                   ."R5MAF"
Zimbabwe                                 ."R5MAF"
/;
Set BioenergySR15_CountriesByModelRegion_MAgPIE(Regions,BioeSR15_Region)
/
Afghanistan                              ."SAS"
Albania                                  ."EUR"
Algeria                                  ."MEA"
Angola                                   ."AFR"
Argentina                                ."LAM"
Armenia                                  ."FSU"
Aruba                                    ."LAM"
Australia                                ."PAO"
Austria                                  ."EUR"
Azerbaijan                               ."FSU"
Bahamas                                  ."LAM"
Bahrain                                  ."MEA"
Bangladesh                               ."SAS"
Barbados                                 ."LAM"
Belarus                                  ."FSU"
Belgium                                  ."EUR"
Belize                                   ."LAM"
Benin                                    ."AFR"
Bhutan                                   ."SAS"
"Bolivia (Plurinational State of)"       ."LAM"
"Bosnia and Herzegovina"                 ."EUR"
Botswana                                 ."AFR"
Brazil                                   ."LAM"
"Brunei Darussalam"                      ."PAS"
Bulgaria                                 ."EUR"
"Burkina Faso"                           ."AFR"
Burundi                                  ."AFR"
Cambodia                                 ."CPA"
Cameroon                                 ."AFR"
Canada                                   ."NAM"
"Cabo Verde"                             ."AFR"
"Central African Republic"               ."AFR"
Chad                                     ."AFR"
Chile                                    ."LAM"
China                                    ."CPA"
Colombia                                 ."LAM"
Comoros                                  ."AFR"
Congo                                    ."AFR"
"Costa Rica"                             ."LAM"
"Côte d'Ivoire"                          ."AFR"
Croatia                                  ."EUR"
Cuba                                     ."LAM"
Cyprus                                   ."EUR"
"Czechia"                                ."EUR"
"Democratic People's Republic of Korea"  ."PAS"
"Democratic Republic of the Congo"       ."AFR"
Denmark                                  ."EUR"
Djibouti                                 ."AFR"
"Dominican Republic"                     ."LAM"
Ecuador                                  ."LAM"
Egypt                                    ."MEA"
"El Salvador"                            ."LAM"
"Equatorial Guinea"                      ."AFR"
Eritrea                                  ."AFR"
Estonia                                  ."EUR"
Ethiopia                                 ."AFR"
Swaziland                                ."AFR"
Fiji                                     ."PAS"
Finland                                  ."EUR"
France                                   ."EUR"
"French Guiana"                          ."LAM"
"French Polynesia"                       ."PAS"
Gabon                                    ."AFR"
Gambia                                   ."AFR"
Georgia                                  ."FSU"
Germany                                  ."EUR"
Ghana                                    ."AFR"
Greece                                   ."EUR"
*Greenland."R5OECD90+EU"."None"."EUR"
Grenada                                  ."LAM"
Guadeloupe                               ."LAM"
Guam                                     ."PAO"
Guatemala                                ."LAM"
Guinea                                   ."AFR"
"Guinea-Bissau"                          ."AFR"
Guyana                                   ."LAM"
Haiti                                    ."LAM"
Honduras                                 ."LAM"
Hungary                                  ."EUR"
Iceland                                  ."EUR"
India                                    ."SAS"
Indonesia                                ."PAS"
"Iran (Islamic Republic of)"             ."MEA"
Iraq                                     ."MEA"
Ireland                                  ."EUR"
Israel                                   ."MEA"
Italy                                    ."EUR"
Jamaica                                  ."LAM"
Japan                                    ."PAO"
Jordan                                   ."MEA"
Kazakhstan                               ."FSU"
Kenya                                    ."AFR"
Kuwait                                   ."MEA"
Kyrgyzstan                               ."FSU"
"Lao People's Democratic Republic"       ."CPA"
Latvia                                   ."EUR"
Lebanon                                  ."MEA"
Lesotho                                  ."AFR"
Liberia                                  ."AFR"
Libya                                    ."MEA"
Lithuania                                ."EUR"
Luxembourg                               ."EUR"
Madagascar                               ."AFR"
Malawi                                   ."AFR"
Malaysia                                 ."PAS"
Maldives                                 ."PAS"
Mali                                     ."AFR"
Malta                                    ."EUR"
Martinique                               ."LAM"
Mauritania                               ."AFR"
Mauritius                                ."AFR"
Mayotte                                  ."AFR"
Mexico                                   ."LAM"
Micronesia                               ."PAS"
"Republic of Moldova"                    ."FSU"
Mongolia                                 ."CPA"
Montenegro                               ."EUR"
Morocco                                  ."MEA"
Mozambique                               ."AFR"
Myanmar                                  ."SAS"
Namibia                                  ."AFR"
Nepal                                    ."SAS"
Netherlands                              ."EUR"
"New Caledonia"                          ."PAS"
"New Zealand"                            ."PAO"
Nicaragua                                ."LAM"
Niger                                    ."AFR"
Nigeria                                  ."AFR"
Norway                                   ."EUR"
"Occupied Palestinian Territory"         ."MEA"
Oman                                     ."MEA"
Pakistan                                 ."SAS"
Panama                                   ."LAM"
"Papua New Guinea"                       ."PAS"
Paraguay                                 ."LAM"
Peru                                     ."LAM"
Philippines                              ."PAS"
Poland                                   ."EUR"
Portugal                                 ."EUR"
"Puerto Rico"                            ."LAM"
Qatar                                    ."MEA"
"Republic Of Korea"                      ."PAS"
*"Republic of Moldova"."R5REF"."FSU"."ROW
Reunion                                  ."AFR"
Romania                                  ."EUR"
"Russian Federation"                     ."FSU"
Rwanda                                   ."AFR"
Samoa                                    ."PAS"
"Saudi Arabia"                           ."MEA"
Senegal                                  ."AFR"
Serbia                                   ."EUR"
"Sierra Leone"                           ."AFR"
Singapore                                ."PAS"
Slovakia                                 ."EUR"
Slovenia                                 ."EUR"
"Solomon Islands"                        ."PAS"
Somalia                                  ."AFR"
"South Africa"                           ."AFR"
"South Sudan"                            ."AFR"
Spain                                    ."EUR"
"Sri Lanka"                              ."SAS"
Sudan                                    ."AFR"
Suriname                                 ."LAM"
*Swaziland."R5MAF"."AFR"."AFR"
Sweden                                   ."EUR"
Switzerland                              ."EUR"
"Syrian Arab Republic"                   ."MEA"
Taiwan                                   ."CPA"
Tajikistan                               ."FSU"
Thailand                                 ."PAS"
"The former Yugoslav Republic of Macedonia"."EUR"
"Timor-Leste"                            ."PAS"
Togo                                     ."AFR"
"Trinidad and Tobago"                    ."LAM"
Tunisia                                  ."MEA"
Turkey                                   ."EUR"
Turkmenistan                             ."FSU"
Uganda                                   ."AFR"
Ukraine                                  ."FSU"
"United Arab Emirates"                   ."MEA"
"United Kingdom"                         ."EUR"
"United Republic of Tanzania"            ."AFR"
"United States of America"               ."NAM"
"United States Virgin Islands"           ."LAM"
Uruguay                                  ."LAM"
Uzbekistan                               ."FSU"
Vanuatu                                  ."PAS"
"Venezuela (Bolivarian Republic of)"     ."LAM"
"Viet Nam"                               ."CPA"
"Western Sahara"                         ."AFR"
Yemen                                    ."MEA"
Zambia                                   ."AFR"
Zimbabwe                                 ."AFR"
/;
Set BioenergySR15_CountriesByModelRegion_REMIND(Regions,BioeSR15_Region)
/
Afghanistan                              ."OAS"
Albania                                  ."ROW"
Algeria                                  ."MEA"
Angola                                   ."AFR"
Argentina                                ."LAM"
Armenia                                  ."MEA"
Aruba                                    ."LAM"
Australia                                ."ROW"
Austria                                  ."EUR"
Azerbaijan                               ."MEA"
Bahamas                                  ."LAM"
Bahrain                                  ."MEA"
Bangladesh                               ."OAS"
Barbados                                 ."LAM"
Belarus                                  ."ROW"
Belgium                                  ."EUR"
Belize                                   ."LAM"
Benin                                    ."AFR"
Bhutan                                   ."OAS"
"Bolivia (Plurinational State of)"       ."LAM"
"Bosnia and Herzegovina"                 ."ROW"
Botswana                                 ."AFR"
Brazil                                   ."LAM"
"Brunei Darussalam"                      ."OAS"
Bulgaria                                 ."EUR"
"Burkina Faso"                           ."AFR"
Burundi                                  ."AFR"
Cambodia                                 ."OAS"
Cameroon                                 ."AFR"
Canada                                   ."ROW"
"Cabo Verde"                             ."AFR"
"Central African Republic"               ."AFR"
Chad                                     ."AFR"
Chile                                    ."LAM"
China                                    ."CHN"
Colombia                                 ."LAM"
Comoros                                  ."AFR"
Congo                                    ."AFR"
"Costa Rica"                             ."LAM"
"Côte d'Ivoire"                          ."AFR"
Croatia                                  ."ROW"
Cuba                                     ."LAM"
Cyprus                                   ."EUR"
"Czechia"                                ."EUR"
"Democratic People's Republic of Korea"  ."OAS"
"Democratic Republic of the Congo"       ."AFR"
Denmark                                  ."EUR"
Djibouti                                 ."AFR"
"Dominican Republic"                     ."LAM"
Ecuador                                  ."LAM"
Egypt                                    ."MEA"
"El Salvador"                            ."LAM"
"Equatorial Guinea"                      ."AFR"
Eritrea                                  ."AFR"
Estonia                                  ."EUR"
Ethiopia                                 ."AFR"
Swaziland                                ."AFR"
Fiji                                     ."OAS"
Finland                                  ."EUR"
France                                   ."EUR"
"French Guiana"                          ."EUR"
"French Polynesia"                       ."OAS"
Gabon                                    ."AFR"
Gambia                                   ."AFR"
Georgia                                  ."MEA"
Germany                                  ."EUR"
Ghana                                    ."AFR"
Greece                                   ."EUR"
*Greenland."R5OECD90+EU"."None"."EUR"
Grenada                                  ."LAM"
Guadeloupe                               ."LAM"
Guam                                     ."OAS"
Guatemala                                ."LAM"
Guinea                                   ."AFR"
"Guinea-Bissau"                          ."AFR"
Guyana                                   ."LAM"
Haiti                                    ."LAM"
Honduras                                 ."LAM"
Hungary                                  ."EUR"
Iceland                                  ."ROW"
India                                    ."IND"
Indonesia                                ."OAS"
"Iran (Islamic Republic of)"             ."MEA"
Iraq                                     ."MEA"
Ireland                                  ."EUR"
Israel                                   ."MEA"
Italy                                    ."EUR"
Jamaica                                  ."LAM"
Japan                                    ."JPN"
Jordan                                   ."MEA"
Kazakhstan                               ."MEA"
Kenya                                    ."AFR"
Kuwait                                   ."MEA"
Kyrgyzstan                               ."MEA"
"Lao People's Democratic Republic"       ."OAS"
Latvia                                   ."EUR"
Lebanon                                  ."MEA"
Lesotho                                  ."AFR"
Liberia                                  ."AFR"
Libya                                    ."MEA"
Lithuania                                ."EUR"
Luxembourg                               ."EUR"
Madagascar                               ."AFR"
Malawi                                   ."AFR"
Malaysia                                 ."OAS"
Maldives                                 ."OAS"
Mali                                     ."AFR"
Malta                                    ."EUR"
Martinique                               ."LAM"
Mauritania                               ."AFR"
Mauritius                                ."AFR"
Mayotte                                  ."AFR"
Mexico                                   ."LAM"
Micronesia                               ."OAS"
"Republic of Moldova"                    ."ROW"
Mongolia                                 ."OAS"
Montenegro                               ."ROW"
Morocco                                  ."MEA"
Mozambique                               ."AFR"
Myanmar                                  ."OAS"
Namibia                                  ."AFR"
Nepal                                    ."OAS"
Netherlands                              ."EUR"
"New Caledonia"                          ."ROW"
"New Zealand"                            ."ROW"
Nicaragua                                ."LAM"
Niger                                    ."AFR"
Nigeria                                  ."AFR"
Norway                                   ."ROW"
"Occupied Palestinian Territory"         ."MEA"
Oman                                     ."MEA"
Pakistan                                 ."OAS"
Panama                                   ."LAM"
"Papua New Guinea"                       ."OAS"
Paraguay                                 ."LAM"
Peru                                     ."LAM"
Philippines                              ."OAS"
Poland                                   ."EUR"
Portugal                                 ."EUR"
"Puerto Rico"                            ."LAM"
Qatar                                    ."MEA"
"Republic Of Korea"                      ."OAS"
*"Republic of Moldova"."R5REF"."FSU"."ROW
Reunion                                  ."AFR"
Romania                                  ."EUR"
"Russian Federation"                     ."ROW"
Rwanda                                   ."AFR"
Samoa                                    ."OAS"
"Saudi Arabia"                           ."MEA"
Senegal                                  ."AFR"
Serbia                                   ."ROW"
"Sierra Leone"                           ."AFR"
Singapore                                ."OAS"
Slovakia                                 ."EUR"
Slovenia                                 ."EUR"
"Solomon Islands"                        ."OAS"
Somalia                                  ."AFR"
"South Africa"                           ."AFR"
"South Sudan"                            ."AFR"
Spain                                    ."EUR"
"Sri Lanka"                              ."OAS"
Sudan                                    ."AFR"
Suriname                                 ."LAM"
*Swaziland."R5MAF"."AFR"."AFR"
Sweden                                   ."EUR"
Switzerland                              ."ROW"
"Syrian Arab Republic"                   ."MEA"
Taiwan                                   ."OAS"
Tajikistan                               ."MEA"
Thailand                                 ."OAS"
"The former Yugoslav Republic of Macedonia"."ROW"
"Timor-Leste"                            ."ROW"
Togo                                     ."AFR"
"Trinidad and Tobago"                    ."LAM"
Tunisia                                  ."MEA"
Turkey                                   ."ROW"
Turkmenistan                             ."MEA"
Uganda                                   ."AFR"
Ukraine                                  ."ROW"
"United Arab Emirates"                   ."MEA"
"United Kingdom"                         ."EUR"
"United Republic of Tanzania"            ."AFR"
"United States of America"               ."USA"
"United States Virgin Islands"           ."LAM"
Uruguay                                  ."LAM"
Uzbekistan                               ."MEA"
Vanuatu                                  ."OAS"
"Venezuela (Bolivarian Republic of)"     ."LAM"
"Viet Nam"                               ."OAS"
"Western Sahara"                         ."AFR"
Yemen                                    ."MEA"
Zambia                                   ."AFR"
Zimbabwe                                 ."AFR"
/;

Parameters
BioenergySR15_P4(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
BioenergySR15_NFromConversion(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
BioenergySR15_NFertilizerUse(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
;

$gdxin BioenergySR15_P4_2_8_2019.gdx
$load BioenergySR15_P4
$gdxin

$gdxin BioenergySR15_NFromConversion_7_8_2019.gdx
$load BioenergySR15_NFromConversion
$gdxin

$gdxin BioenergySR15_EnergysystemDMInputNOutput_24_8_2019.gdx
$load BioenergySR15_EnergyConversion_DMInput_NOutput
$gdxin

$gdxin BioenergySR15_NFertilizerUse_7_8_2019.gdx
$load BioenergySR15_NFertilizerUse
$gdxin

*replace "T g N/yr" by "Tg N/yr" and drop "T g N/yr"
BioenergySR15_NFromConversion(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,"Tg N/yr",Years)
                 $(NOT BioenergySR15_NFromConversion(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,"Tg N/yr",Years))
         = BioenergySR15_NFromConversion(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,"T g N/yr",Years);
BioenergySR15_NFromConversion(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,"T g N/yr",Years)=0;

BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,"Tg N/yr",Years)
                 $(NOT BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,"Tg N/yr",Years))
         = BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,"T g N/yr",Years);
BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,"T g N/yr",Years)=0;

*replace "N from Anaerobic Digestion|Miscanthus|4.9 N" and "N from Anaerobic Digestion|Residues|4.9 N" with the same, but with ...4.9N" and drop the former two
BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,"N from Anaerobic Digestion|Miscanthus|4.9N",BioeSR15_Unit,Years)
                 $(NOT BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,"N from Anaerobic Digestion|Miscanthus|4.9N",BioeSR15_Unit,Years))
         = BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,"N from Anaerobic Digestion|Miscanthus|4.9 N",BioeSR15_Unit,Years);
BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,"N from Anaerobic Digestion|Miscanthus|4.9 N",BioeSR15_Unit,Years)=0;
BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,"N from Anaerobic Digestion|Residues|4.9N",BioeSR15_Unit,Years)
                 $(NOT BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,"N from Anaerobic Digestion|Residues|4.9N",BioeSR15_Unit,Years))
         = BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,"N from Anaerobic Digestion|Residues|4.9 N",BioeSR15_Unit,Years);
BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,"N from Anaerobic Digestion|Residues|4.9 N",BioeSR15_Unit,Years)=0;


*assign P4 data to new parameters, according to BioeSR15_Source; the first two dimensions have one entry each only, thus drop them
Parameter BioenergySR15_P4_IAMC(BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years);
Parameter BioenergySR15_P4_MAgPIE(BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years);
Parameter BioenergySR15_P4_REMIND(BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years);

BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
         = BioenergySR15_P4("REMIND-MAgPIE 1.5","SSP5-19","IAMC",BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years);
BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
         = BioenergySR15_P4("REMIND-MAGPIE","SSP5-19","MAgPIE",BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years);
BioenergySR15_P4_REMIND("REMIND",BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
         = BioenergySR15_P4("REMIND-MAGPIE","SSP5-19","REMIND",BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years);

*drop the original parameter:
BioenergySR15_P4(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years) = 0;

*as a reminder: the country-model related region matching sets:
*BioenergySR15_CountriesByModelRegion_IAMC(Regions,BioeSR15_Region)
*BioenergySR15_CountriesByModelRegion_MAgPIE(Regions,BioeSR15_Region)
*BioenergySR15_CountriesByModelRegion_REMIND(Regions,BioeSR15_Region)

$ontext;
after this, we have
BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
BioenergySR15_P4_REMIND("REMIND",BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
BioenergySR15_NFromConversion(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
BioenergySR15_EnergyConversion_DMInput_NOutput(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
BioenergySR15_NFertilizerUse(BioeSR15_Model,BioeSR15_Scenario,BioeSR15_Source,BioeSR15_Region,BioeSR15_Variable,BioeSR15_Unit,Years)
$offtext;

****************************************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************************************
*3) Assign values to core model parameters and variables
*3.1) Link some sets as needed

Set MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
/
R5ASIA       .R5ASIA
R5LAM        .R5LAM
R5MAF        .R5MAF
"R5OECD90+EU"."R5OECD90+EU"
R5REF        .R5REF
World        .World
AFR          .AFR
CHN          .CHN
EUR          .EUR
IND          .IND
JPN          .JPN
LAM          .LAM
MEA          .MEA
OAS          .OAS
ROW          .ROW
RUS          .RUS
USA          .USA
CPA          .CPA
FSU          .FSU
NAM          .NAM
PAO          .PAO
PAS          .PAS
SAS          .SAS
/;

Set Match_BioeSR15Years_Scenarios(Years,Scenarios)
/
2010.BioeSR15_P4_2010
2050.BioeSR15_P4_2050
2100.BioeSR15_P4_2100
/;


*3.2) Link to the core model parameters

*3.2.1 data from IAMC
* times 1000000 to convert from million tons to tons
VActCropsGrass_Outputs_MR.l(Regions,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Agricultural Production|Energy|Crops","million t DM/yr",Years)*1000000);

VActCropsGrass_Outputs_MR.l(Regions,"All non-energy crops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Agricultural Production|Non-Energy|Crops","million t DM/yr",Years)*1000000);

VActAnimalsHead_Outputs_MR.l(Regions,"All Animals","Producing","All food output (t DM)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Agricultural Production|Non-Energy|Livestock","million t DM/yr",Years)*1000000);


HumanCharacteristics_MR(Regions,"PopulationAll","kcal/cap/day (BioeSR15 req)","All Commodities",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Food Demand","kcal/cap/day",Years));
HumanCharacteristics_MR(Regions,"PopulationAll","kcal/cap/day (BioeSR15 req)","All crop based Commodities",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Food Demand|Crops","kcal/cap/day",Years));
HumanCharacteristics_MR(Regions,"PopulationAll","kcal/cap/day (BioeSR15 req)","All animal based Commodities",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Food Demand|Livestock","kcal/cap/day",Years));

* times 1000000 to convert from million people to people
VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)
                 $(NOT VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios))
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Population","million",Years)*1000000);


VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","AllEnSources","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Primary Energy","EJ/yr",Years));
VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","Biomass","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Primary Energy|Biomass","EJ/yr",Years));

VEnergyProduction_MR.l(Regions,"Secondary energy","Electricity","AllEnSources","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Secondary Energy|Electricity","EJ/yr",Years));
VEnergyProduction_MR.l(Regions,"Secondary energy","Electricity","Biomass","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Secondary Energy|Electricity|Biomass","EJ/yr",Years));

VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","AllEnSources","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Secondary Energy|Gases","EJ/yr",Years));
VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","Biomass","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Secondary Energy|Gases|Biomass","EJ/yr",Years));

VEnergyProduction_MR.l(Regions,"Secondary energy","Hydrogen","AllEnSources","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Secondary Energy|Hydrogen","EJ/yr",Years));
VEnergyProduction_MR.l(Regions,"Secondary energy","Hydrogen","Biomass","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Secondary Energy|Hydrogen|Biomass","EJ/yr",Years));

VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","AllEnSources","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Secondary Energy|Liquids","EJ/yr",Years));
VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","Biomass","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_IAMC("IAMC",BioeSR15_Region,"Secondary Energy|Liquids|Biomass","EJ/yr",Years));

*3.2.2 data from MAgPIE
* times 1000000 to convert from million ha to ha
VActForest_QuantityActUnits_MR.l(Regions,"Forestry","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActForest_QuantityActUnits_MR.l(Regions,"Forestry","AllProdSyst","AllProdCond",Scenarios))
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Land Cover|Forest|Forestry","million ha",Years)*1000000);
VActForest_QuantityActUnits_MR.l(Regions,"Natural Forest","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActForest_QuantityActUnits_MR.l(Regions,"Natural Forest","AllProdSyst","AllProdCond",Scenarios))
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Land Cover|Forest|Natural Forest","million ha",Years)*1000000);

* times 1000000 to convert from million ha to ha
*the following also INCLUDES miscanthus!
*the following four areas are also available in the IAMC-regions - but MAgPIE is more refined, thus use those
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Land Cover|Cropland","million ha",Years)*1000000);

VActCropsGrass_QuantityActUnits_MR.l(Regions,"Grass","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Regions,"Grass","AllProdSyst","AllProdCond",Scenarios))
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Land Cover|Pasture","million ha",Years)*1000000);

VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Land Cover|Cropland|Energy Crops|Miscanthus","million ha",Years)*1000000);

VActForest_QuantityActUnits_MR.l(Regions,"Forest","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActForest_QuantityActUnits_MR.l(Regions,"Forest","AllProdSyst","AllProdCond",Scenarios))
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Land Cover|Forest","million ha",Years)*1000000);


VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Cereals","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Land Cover|Cropland|Cereals","million ha",Years)*1000000);

VActCropsGrass_Outputs_MR.l(Regions,"All Cereals","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Agricultural Production|Crops|Non-Energy|Cereals","million t DM/yr",Years)*1000000);

ActCropsGrass_Outputs_MR(Regions,"All Cereals","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Yield|Cereal","t DM/ha/yr",Years));
ActCropsGrass_Outputs_MR(Regions,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Yield|Energy Crops|Miscanthus","t DM/ha/yr",Years));
ActCropsGrass_Outputs_MR(Regions,"All Sugar Crops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Yield|Sugarcrops","t DM/ha/yr",Years));
ActCropsGrass_Outputs_MR(Regions,"All Oilcrops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Yield|Oilcrops","t DM/ha/yr",Years));

*times 1000000 to convert from Tg N to tons N
VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Fertilizer Use|Nitrogen","Tg N/yr",Years)*1000000);

*3.2.3 data from REMIND
*times 1000000 to convert from million ha to ha
VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","Miscanthus","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_REMIND("REMIND",BioeSR15_Region,"Primary Energy|Biomass|Energy Crops|Miscanthus","EJ/yr",Years));

VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","Forest and crop residues","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_REMIND("REMIND",BioeSR15_Region,"Primary Energy|Biomass|Residues","EJ/yr",Years));


*3.2.4 data from BioenergySR15_NFromConversion and BioenergySR15_EnergyConversion_DMInput_NOutput
*for the code lines below: factor 1000000 to convert Tg and million tons into tons
*the following is the same as the total DM production

VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Miscanthus","Bioe conversion Biomass input (tDM)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_EnergyConversion_DMInput_NOutput("REMIND-MAGPIE","SSP5-19","MAgPIE",BioeSR15_Region,"Energy System Input P4|Miscanthus","million t DM/yr",Years)*1000000);

VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_EnergyConversion_DMInput_NOutput("REMIND-MAGPIE","SSP5-19","REMIND",BioeSR15_Region,"Energy System Input P4|Residues","million t DM/yr",Years)*1000000);

$if %NInBioeResidues% == "LOW" $goto NInBioeResidues_LOW
$if %NInBioeResidues% == "HIGH" $goto NInBioeResidues_HIGH

$label NInBioeResidues_LOW
VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","Miscanthus","N from Bioe residues (tN)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_NFromConversion("REMIND-MAgPIE 1.5","SSP5-19","IAMC",BioeSR15_Region,"N from Anaerobic Digestion|low 164.7CH4 3.4N","Tg N/yr",Years)*1000000);

VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Miscanthus","N from Bioe residues (tN)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_EnergyConversion_DMInput_NOutput("REMIND-MAgPIE 1.5","SSP5-19","IAMC",BioeSR15_Region,"Energy System Output P4|Miscanthus|Nitrogen|3.4N","Tg N/yr",Years)*1000000);
VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Forest and crop residues","N from Bioe residues (tN)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_EnergyConversion_DMInput_NOutput("REMIND-MAgPIE 1.5","SSP5-19","IAMC",BioeSR15_Region,"Energy System Output P4|Residues|Nitrogen|3.4N","Tg N/yr",Years)*1000000);

$goto EndOfNInBioeResiduesLowHigh

$label NInBioeResidues_HIGH
VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","Miscanthus","N from Bioe residues (tN)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_NFromConversion("REMIND-MAgPIE 1.5","SSP5-19","IAMC",BioeSR15_Region,"N from Anaerobic Digestion|high 200.6CH4 4.9N","Tg N/yr",Years)*1000000);

VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Miscanthus","N from Bioe residues (tN)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_EnergyConversion_DMInput_NOutput("REMIND-MAgPIE 1.5","SSP5-19","IAMC",BioeSR15_Region,"Energy System Output P4|Miscanthus|Nitrogen|4.9N","Tg N/yr",Years)*1000000);
VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Forest and crop residues","N from Bioe residues (tN)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_EnergyConversion_DMInput_NOutput("REMIND-MAgPIE 1.5","SSP5-19","IAMC",BioeSR15_Region,"Energy System Output P4|Residues|Nitrogen|4.9N","Tg N/yr",Years)*1000000);

$label EndOfNInBioeResiduesLowHigh


VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","Forest and crop residues","N from Bioe residues (tN)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_NFromConversion("REMIND-MAgPIE 1.5","SSP5-19","IAMC",BioeSR15_Region,"N from Fermentation|Agroforest Residues","Tg N/yr",Years)*1000000);
VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","Miscanthus","N from Bioe residues (tN)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_NFromConversion("REMIND-MAgPIE 1.5","SSP5-19","IAMC",BioeSR15_Region,"N from Fermentation|Miscanthus","Tg N/yr",Years)*1000000);
VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","Biomass","N from Bioe residues (tN)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_NFromConversion("REMIND-MAgPIE 1.5","SSP5-19","IAMC",BioeSR15_Region,"N from Fermentation|Total","Tg N/yr",Years)*1000000);


VEnergyProduction_MR.l(Regions,"Secondary energy","Electricity","EtOH residues","Production (EJ)",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_NFromConversion("REMIND-MAgPIE 1.5","SSP5-19","IAMC",BioeSR15_Region,"Secondary Energy|Electricity|Deficit|EtOH residues","EJ/yr",Years));


*3.2.5 data from BioenergySR15_NFertilizerUse

$if %MiscanthusFertUseLevel% == "LOW" $goto MiscanthusFertUseLevel_LOW
$if %MiscanthusFertUseLevel% == "HIGH" $goto MiscanthusFertUseLevel_HIGH
$if %MiscanthusFertUseLevel% == "MEDIUM" $goto MiscanthusFertUseLevel_MEDIUM

*this relates to N contents of Miscanthus, thus adjust accordingly as well (current value: 0.00415tN/tDM)

*factor 1000000 to convert from Tg to tons

$label MiscanthusFertUseLevel_LOW
VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_NFertilizerUse("REMIND-MAGPIE","SSP5-19","MAgPIE",BioeSR15_Region,"Fertilization Use|Energy Crops|Miscanthus|Low3.4","Tg N/yr",Years)*1000000);

Commod_Contents(Countries,"Miscanthus","N (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Miscanthus","N (t)","AllProdSyst","AllProdCond")*3.4/4.15
Commod_Contents(Countries,"Miscanthus","N in DM (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Miscanthus","N in DM (t)","AllProdSyst","AllProdCond")*3.4/4.15

$goto EndOfMiscanthusFertUse

$label MiscanthusFertUseLevel_HIGH
VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_NFertilizerUse("REMIND-MAGPIE","SSP5-19","MAgPIE",BioeSR15_Region,"Fertilization Use|Energy Crops|Miscanthus|Up4.9","Tg N/yr",Years)*1000000);

Commod_Contents(Countries,"Miscanthus","N (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Miscanthus","N (t)","AllProdSyst","AllProdCond")*4.9/4.15
Commod_Contents(Countries,"Miscanthus","N in DM (t)","AllProdSyst","AllProdCond")
         = Commod_Contents(Countries,"Miscanthus","N in DM (t)","AllProdSyst","AllProdCond")*4.9/4.15

$goto EndOfMiscanthusFertUse

$label MiscanthusFertUseLevel_MEDIUM
VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                 BioenergySR15_NFertilizerUse("REMIND-MAGPIE","SSP5-19","MAgPIE",BioeSR15_Region,"Fertilization Use|Energy Crops|Miscanthus|4.15","Tg N/yr",Years)*1000000);

$label EndOfMiscanthusFertUse




*3.2.6) Derive country values from regional values
$ontext;
The code above generates the following variables and parameters on regional level.
To assign to countries, use the following rules                                                                                         use the following Scenario = Baseline values to derive country shares
                                                                                                                                        that are then used to multiply the regional values to derive country values:

IAMC regions
IAMCa) VActCropsGrass_Outputs_MR.l(Regions,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)                                          use for check: area*yield
IAMCb) VActCropsGrass_Outputs_MR.l(Regions,"All non-energy crops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)                                use for check: area*yield
IAMCc) VActAnimalsHead_Outputs_MR.l(Regions,"All Animals","Producing","All food output (t DM)","AllProdSyst","AllProdCond",Scenarios)          total animal production
IAMCd) HumanCharacteristics_MR(Regions,"PopulationAll","kcal/cap/day (BioeSR15 req)","All Commodities",Scenarios)                              countries = regions
IAMCe) HumanCharacteristics_MR(Regions,"PopulationAll","kcal/cap/day (BioeSR15 req)","All crop based Commodities",Scenarios)                   countries = regions
IAMCf) HumanCharacteristics_MR(Regions,"PopulationAll","kcal/cap/day (BioeSR15 req)","All animal based Commodities",Scenarios)                 countries = regions
IAMCk) VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)                                                                              total population numbers
IAMCl) VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","AllEnSources","Production (EJ)",Scenarios)
IAMCm) VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","Biomass","Production (EJ)",Scenarios)
IAMCn) VEnergyProduction_MR.l(Regions,"Secondary energy","Electricity","AllEnSources","Production (EJ)",Scenarios)
IAMCo) VEnergyProduction_MR.l(Regions,"Secondary energy","Electricity","Biomass","Production (EJ)",Scenarios)
IAMCp) VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","AllEnSources","Production (EJ)",Scenarios)
IAMCq) VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","Biomass","Production (EJ)",Scenarios)
IAMCr) VEnergyProduction_MR.l(Regions,"Secondary energy","Hydrogen","AllEnSources","Production (EJ)",Scenarios)
IAMCs) VEnergyProduction_MR.l(Regions,"Secondary energy","Hydrogen","Biomass","Production (EJ)",Scenarios)
IAMCt) VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","AllEnSources","Production (EJ)",Scenarios)
IAMCu) VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","Biomass","Production (EJ)",Scenarios)
IAMCv) VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","Miscanthus","N from Bioe residues (tN)",Scenarios)
IAMCw) VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","Forest and crop residues","N from Bioe residues (tN)",Scenarios)
IAMCx) VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","Miscanthus","N from Bioe residues (tN)",Scenarios)
IAMCy) VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","Biomass","N from Bioe residues (tN)",Scenarios)
IAMCz) VEnergyProduction_MR.l(Regions,"Secondary energy","Electricity","EtOH residues","Production (EJ)",Scenarios)
IAMCaa) VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Miscanthus","N from Bioe residues (tN)",Scenarios)
IAMCab) VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Forest and crop residues","N from Bioe residues (tN)",Scenarios)

MAgPIE regions
MAgPIEa) VActForest_QuantityActUnits_MR.l(Regions,"Forestry","AllProdSyst","AllProdCond",Scenarios)                                              areas: forest
MAgPIEb) VActForest_QuantityActUnits_MR.l(Regions,"Natural Forest","AllProdSyst","AllProdCond",Scenarios)                                        areas: primary forest
MAgPIEk) VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops","AllProdSyst","AllProdCond",Scenarios)                                         area: All Crops
MAgPIEl) VActCropsGrass_QuantityActUnits_MR.l(Regions,"Grass","AllProdSyst","AllProdCond",Scenarios)                                             area: grass
MAgPIEm) VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst","AllProdCond",Scenarios)                                        area: grass
MAgPIEn) VActForest_QuantityActUnits_MR.l(Regions,"Forest","AllProdSyst","AllProdCond",Scenarios)                                                area: Forest
MAgPIEc) VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Cereals","AllProdSyst","AllProdCond",Scenarios)                                       areas: all cereals
MAgPIEd) VActCropsGrass_Outputs_MR.l(Regions,"All Cereals","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)                                         use for check: area*yield
MAgPIEe) ActCropsGrass_Outputs_MR(Regions,"All Cereals","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)                              countries=regions
MAgPIEf) ActCropsGrass_Outputs_MR(Regions,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)                               countries=regions
MAgPIEg) ActCropsGrass_Outputs_MR(Regions,"All Sugar Crops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)                          countries=regions
MAgPIEh) ActCropsGrass_Outputs_MR(Regions,"All Oilcrops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)                             countries=regions
MAgPIEi) VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)           production: crops and grass
MAgPIEj) VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)                    production: miscanthus
MAgPIEk) VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Miscanthus","Bioe conversion Biomass input (tDM)",Scenarios)

REMIND regions
REMINDa) VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","Miscanthus","Production (EJ)",Scenarios)
REMINDb) VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","Forest and crop residues","Production (EJ)",Scenarios)
REMINDc) VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)",Scenarios)
$offtext;


*IAMC
*IAMCk) VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)                                                                              total population numbers
VPopulationNumbers_MR.l(BioeSR15_Region,"PopulationAll","Baseline")
         = sum(Countries$BioenergySR15_CountriesByModelRegion_IAMC(Countries,BioeSR15_Region),
                 VPopulationNumbers_MR.l(Countries,"PopulationAll","Baseline"));

VPopulationNumbers_MR.l(Countries,"PopulationAll",Scenarios)
                 $(NOT VPopulationNumbers_MR.l(Countries,"PopulationAll",Scenarios))
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_IAMC(Countries,BioeSR15_Region)
                                 AND VPopulationNumbers_MR.l(BioeSR15_Region,"PopulationAll","Baseline")),
                 VPopulationNumbers_MR.l(BioeSR15_Region,"PopulationAll",Scenarios)
                         *VPopulationNumbers_MR.l(Countries,"PopulationAll","Baseline")
                                 /VPopulationNumbers_MR.l(BioeSR15_Region,"PopulationAll","Baseline"));

*STILL TO BE DONE:
*IAMCc) VActAnimalsHead_Outputs_MR.l(Regions,"All Animals","Producing","All food output (t DM)","AllProdSyst","AllProdCond",Scenarios)          total animal production

*MAgPIE
*MAgPIEa) VActForest_QuantityActUnits_MR.l(Regions,"Forestry","AllProdSyst","AllProdCond",Scenarios)                                              areas: forest
*we need to derive the regional values again, as we now need different regions:
VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond","Baseline")
         = sum(Countries$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 VActForest_QuantityActUnits_MR.l(Countries,"Forest","AllProdSyst","AllProdCond","Baseline"));

VActForest_QuantityActUnits_MR.l(Countries,"Forestry","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActForest_QuantityActUnits_MR.l(Countries,"Forestry","AllProdSyst","AllProdCond",Scenarios))
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region)
                                 AND VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond","Baseline")),
                 VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forestry","AllProdSyst","AllProdCond",Scenarios)
                         *VActForest_QuantityActUnits_MR.l(Countries,"Forest","AllProdSyst","AllProdCond","Baseline")
                                 /VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond","Baseline"));

*MAgPIEb) VActForest_QuantityActUnits_MR.l(Regions,"Natural Forest","AllProdSyst","AllProdCond",Scenarios)                                        areas: primary forest
VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Primary Forest","AllProdSyst","AllProdCond","Baseline")
         = sum(Countries$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 VActForest_QuantityActUnits_MR.l(Countries,"Primary Forest","AllProdSyst","AllProdCond","Baseline"));

VActForest_QuantityActUnits_MR.l(Countries,"Natural Forest","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActForest_QuantityActUnits_MR.l(Countries,"Natural Forest","AllProdSyst","AllProdCond",Scenarios))
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region)
                                 AND VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Primary Forest","AllProdSyst","AllProdCond","Baseline")),
                 VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Natural Forest","AllProdSyst","AllProdCond",Scenarios)
                         *VActForest_QuantityActUnits_MR.l(Countries,"Primary Forest","AllProdSyst","AllProdCond","Baseline")
                                 /VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Primary Forest","AllProdSyst","AllProdCond","Baseline"));


*MAgPIEc) VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Cereals","AllProdSyst","AllProdCond",Scenarios)                                       areas: all cereals
*assign the following first, as this is better data than the all crop data used below to derive single crops - specific for cereals here, thus use this
VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Cereals","AllProdSyst","AllProdCond","Baseline")
         = sum((Cereals,Countries)$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,Cereals,"AllProdSyst","AllProdCond","Baseline"));

VActCropsGrass_QuantityActUnits_MR.l(Countries,Cereals,"AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,Cereals,"AllProdSyst","AllProdCond",Scenarios))
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region)
                                 AND VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Cereals","AllProdSyst","AllProdCond","Baseline")),
                 VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Cereals","AllProdSyst","AllProdCond",Scenarios)
                         *VActCropsGrass_QuantityActUnits_MR.l(Countries,Cereals,"AllProdSyst","AllProdCond","Baseline")
                                 /VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Cereals","AllProdSyst","AllProdCond","Baseline"));


*MAgPIEk) VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops","AllProdSyst","AllProdCond",Scenarios)                                         area: All Crops
VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All crops","AllProdSyst","AllProdCond","Baseline")
         = sum((Crops,Countries)$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,Crops,"AllProdSyst","AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Grass","AllProdSyst","AllProdCond","Baseline")
         = sum((TempAndPermMeadAndPastures,Countries)$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond","Baseline"));
VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grass","AllProdSyst","AllProdCond","Baseline")
         = sum(TempAndPermMeadAndPastures,
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond","Baseline"));

VActCropsGrass_QuantityActUnits_MR.l(Countries,Crops,"AllProdSyst","AllProdCond",Scenarios)
*condition needed to avoid overwriting cereal data from above
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,Crops,"AllProdSyst","AllProdCond",Scenarios))
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region)
                                 AND (VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All crops","AllProdSyst","AllProdCond","Baseline")
                                                 - VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Miscanthus","AllProdSyst","AllProdCond","BioeSR15_P4_2010") - VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Cereals","AllProdSyst","AllProdCond","Baseline"))),
                 (VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Crops","AllProdSyst","AllProdCond",Scenarios)
                                 - VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Miscanthus","AllProdSyst","AllProdCond",Scenarios) - VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Cereals","AllProdSyst","AllProdCond",Scenarios))
                         *VActCropsGrass_QuantityActUnits_MR.l(Countries,Crops,"AllProdSyst","AllProdCond","Baseline")
                                 /(VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All crops","AllProdSyst","AllProdCond","Baseline")
                                         - VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Miscanthus","AllProdSyst","AllProdCond","BioeSR15_P4_2010") - VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Cereals","AllProdSyst","AllProdCond","Baseline")));

VActCropsGrass_QuantityActUnits_MR.l(Countries,"Miscanthus","AllProdSyst","AllProdCond",Scenarios)
*                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,"Miscanthus","AllProdSyst","AllProdCond",Scenarios))
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region)
                                 AND VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Grass","AllProdSyst","AllProdCond","Baseline")),
                 VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Miscanthus","AllProdSyst","AllProdCond",Scenarios)
                         *VActCropsGrass_QuantityActUnits_MR.l(Countries,"Grass","AllProdSyst","AllProdCond","Baseline")
                                 /VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Grass","AllProdSyst","AllProdCond","Baseline"));


*MAgPIEl) VActCropsGrass_QuantityActUnits_MR.l(Regions,"Grass","AllProdSyst","AllProdCond",Scenarios)                                             area: grass
VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Grass","AllProdSyst","AllProdCond","Baseline")
         = sum((TempAndPermMeadAndPastures,Countries)$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond","Baseline"));

VActCropsGrass_QuantityActUnits_MR.l(Countries,TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(Countries,TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond",Scenarios))
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region)
                                 AND VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Grass","AllProdSyst","AllProdCond","Baseline")),
                 VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Grass","AllProdSyst","AllProdCond",Scenarios)
                         *VActCropsGrass_QuantityActUnits_MR.l(Countries,TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond","Baseline")
                                 /VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Grass","AllProdSyst","AllProdCond","Baseline"));

*MAgPIEm) VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst","AllProdCond",Scenarios)                                        area: grass
*already derived above: VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Grass","AllProdSyst","AllProdCond","Baseline")


*MAgPIEn) VActForest_QuantityActUnits_MR.l(Regions,"Forest","AllProdSyst","AllProdCond",Scenarios)                                                area: Forest
VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond","Baseline")
         = sum(Countries$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 VActForest_QuantityActUnits_MR.l(Countries,"Forest","AllProdSyst","AllProdCond","Baseline"));

VActForest_QuantityActUnits_MR.l(Countries,"Forest","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActForest_QuantityActUnits_MR.l(Countries,"Forest","AllProdSyst","AllProdCond",Scenarios))
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region)
                                 AND VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond","Baseline")),
                 VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond",Scenarios)
                         *VActForest_QuantityActUnits_MR.l(Countries,"Forest","AllProdSyst","AllProdCond","Baseline")
                                 /VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond","Baseline"));


$ontext;
Already done above!
*MAgPIEc) VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Cereals","AllProdSyst","AllProdCond",Scenarios)                                       areas: all cereals
VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Cereals","AllProdSyst","AllProdCond","Baseline")
         = sum((Cereals,Countries)$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,Cereals,"AllProdSyst","AllProdCond","Baseline"));
*assign the following in any case, as this is better data than the all crop data used above to derive single crops - specific for cereals here, thus use this, hence delete the cereal data already derived above
*VActCropsGrass_QuantityActUnits_MR.l(Countries,Cereals,"AllProdSyst","AllProdCond",BioeSR15_Scenarios) = 0;

VActCropsGrass_QuantityActUnits_MR.l(Countries,Cereals,"AllProdSyst","AllProdCond",Scenarios)
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region)
                                 AND VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Cereals","AllProdSyst","AllProdCond","Baseline")),
                 VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Cereals","AllProdSyst","AllProdCond",Scenarios)
                         *VActCropsGrass_QuantityActUnits_MR.l(Countries,Cereals,"AllProdSyst","AllProdCond","Baseline")
                                 /VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All Cereals","AllProdSyst","AllProdCond","Baseline"));
$offtext;



*Yields:
*MAgPIEe) ActCropsGrass_Outputs_MR(Regions,"All Cereals","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)                              countries=regions
ActCropsGrass_Outputs_MR(Countries,"All Cereals","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         = sum(BioeSR15_Region$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 ActCropsGrass_Outputs_MR(BioeSR15_Region,"All Cereals","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios));

*MAgPIEg) ActCropsGrass_Outputs_MR(Regions,"All Sugar Crops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)                          countries=regions
ActCropsGrass_Outputs_MR(Countries,"All Sugar Crops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         = sum(BioeSR15_Region$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 ActCropsGrass_Outputs_MR(BioeSR15_Region,"All Sugar Crops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios));

*MAgPIEh) ActCropsGrass_Outputs_MR(Regions,"All Oilcrops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)                             countries=regions
ActCropsGrass_Outputs_MR(Countries,"All Oilcrops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         = sum(BioeSR15_Region$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 ActCropsGrass_Outputs_MR(BioeSR15_Region,"All Oilcrops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios));

*MAgPIEf) ActCropsGrass_Outputs_MR(Regions,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)                               countries=regions
ActCropsGrass_Outputs_MR(Countries,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         = sum(BioeSR15_Region$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 ActCropsGrass_Outputs_MR(BioeSR15_Region,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios));

*you have yield and area, thus derive production:
VActCropsGrass_Outputs_MR.l(Countries,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         = VActCropsGrass_QuantityActUnits_MR.l(Countries,"Miscanthus","AllProdSyst","AllProdCond",Scenarios)
                 *ActCropsGrass_Outputs_MR(Countries,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios);
VActCropsGrass_Outputs_MR.l(BioeSR15_Region,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
         = sum(Countries$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                  VActCropsGrass_Outputs_MR.l(Countries,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios));


*MAgPIEi) VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)           min fert quantities

VMineralFertilizerQuantity.l(BioeSR15_Region,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst")
         = sum(Countries$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 VMineralFertilizerQuantity.l(Countries,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst"));

VActCropsGrass_Inputs_MR.l(Countries,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region)
                         AND VMineralFertilizerQuantity.l(BioeSR15_Region,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst")),
                 VActCropsGrass_Inputs_MR.l(BioeSR15_Region,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)
                         *VMineralFertilizerQuantity.l(Countries,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst")
                                 /VMineralFertilizerQuantity.l(BioeSR15_Region,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst"));

VMineralFertilizerQuantity_MR.l(Countries,"mineral N fert (N)","AllMinFertProdTech","AllProdSyst",Scenarios)
         = VActCropsGrass_Inputs_MR.l(Countries,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios);


*MAgPIEj) VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)                    production: miscanthus

VActCropsGrass_Inputs_MR.l(Countries,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region)
                                 AND VActCropsGrass_Outputs_MR.l(BioeSR15_Region,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)),
                 VActCropsGrass_Inputs_MR.l(BioeSR15_Region,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)
                         *VActCropsGrass_Outputs_MR.l(Countries,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
                                 /VActCropsGrass_Outputs_MR.l(BioeSR15_Region,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios));

*the following have been added later, and use some totals already calculated above - thus do it here:
*IAMCaa) VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Miscanthus","N from Bioe residues (tN)",Scenarios)                       production: miscanthus
VActCropsGrass_Outputs_MR.l(BioeSR15_Region,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActCropsGrass_Outputs_MR.l(BioeSR15_Region,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios))
         = sum(Countries$BioenergySR15_CountriesByModelRegion_IAMC(Countries,BioeSR15_Region),
                  VActCropsGrass_Outputs_MR.l(Countries,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios));
VEnergyProduction_MR.l(Countries,"Secondary energy","AllEnTypes","Miscanthus","N from Bioe residues (tN)",Scenarios)
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_IAMC(Countries,BioeSR15_Region)
                                 AND VActCropsGrass_Outputs_MR.l(BioeSR15_Region,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)),
                 VEnergyProduction_MR.l(BioeSR15_Region,"Secondary energy","AllEnTypes","Miscanthus","N from Bioe residues (tN)",Scenarios)
                         *VActCropsGrass_Outputs_MR.l(Countries,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
                                 /VActCropsGrass_Outputs_MR.l(BioeSR15_Region,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios));

*IAMCab) VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Forest and crop residues","N from Bioe residues (tN)",Scenarios)          area forest + all crops
VActCropsGrass_QuantityActUnits_MR.l(Countries,"All crops","AllProdSyst","AllProdCond",Scenarios)
         =sum(Crops,VActCropsGrass_QuantityActUnits_MR.l(Countries,Crops,"AllProdSyst","AllProdCond",Scenarios));

VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All crops","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All crops","AllProdSyst","AllProdCond",Scenarios))
         = sum(Countries$BioenergySR15_CountriesByModelRegion_IAMC(Countries,BioeSR15_Region),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,"All crops","AllProdSyst","AllProdCond",Scenarios));
VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond",Scenarios))
         = sum(Countries$BioenergySR15_CountriesByModelRegion_IAMC(Countries,BioeSR15_Region),
                 VActForest_QuantityActUnits_MR.l(Countries,"Forest","AllProdSyst","AllProdCond",Scenarios));

VEnergyProduction_MR.l(Countries,"Secondary energy","AllEnTypes","Forest and crop residues","N from Bioe residues (tN)",Scenarios)
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_IAMC(Countries,BioeSR15_Region)
                                 AND (VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All crops","AllProdSyst","AllProdCond",Scenarios)
                                 +VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond",Scenarios))),
                 VEnergyProduction_MR.l(BioeSR15_Region,"Secondary energy","AllEnTypes","Forest and crop residues","N from Bioe residues (tN)",Scenarios)
                         *(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All crops","AllProdSyst","AllProdCond",Scenarios)
                                 +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Forest","AllProdSyst","AllProdCond",Scenarios))
                         /(VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All crops","AllProdSyst","AllProdCond",Scenarios)
                                 +VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond",Scenarios)));

*MAgPIEk) VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Miscanthus","Bioe conversion Biomass input (tDM)",Scenarios)
*this equals DM production, thus take from above:
VEnergyProduction_MR.l(Countries,"Secondary energy","AllEnTypes","Miscanthus","Bioe conversion Biomass input (tDM)",Scenarios)
         = VActCropsGrass_Outputs_MR.l(Countries,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios);

*REMINDc) VEnergyProduction_MR.l(Regions,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)",Scenarios)
VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All crops","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All crops","AllProdSyst","AllProdCond",Scenarios))
         = sum(Countries$BioenergySR15_CountriesByModelRegion_REMIND(Countries,BioeSR15_Region),
                 VActCropsGrass_QuantityActUnits_MR.l(Countries,"All crops","AllProdSyst","AllProdCond",Scenarios));
VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond",Scenarios)
                 $(NOT VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond",Scenarios))
         = sum(Countries$BioenergySR15_CountriesByModelRegion_REMIND(Countries,BioeSR15_Region),
                 VActForest_QuantityActUnits_MR.l(Countries,"Forest","AllProdSyst","AllProdCond",Scenarios));

VEnergyProduction_MR.l(Countries,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)",Scenarios)
         = sum(BioeSR15_Region$(BioenergySR15_CountriesByModelRegion_REMIND(Countries,BioeSR15_Region)
                                 AND (VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All crops","AllProdSyst","AllProdCond",Scenarios)
                                         +VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond",Scenarios))),
                 VEnergyProduction_MR.l(BioeSR15_Region,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)",Scenarios)
                         *(VActCropsGrass_QuantityActUnits_MR.l(Countries,"All crops","AllProdSyst","AllProdCond",Scenarios)
                                 +VActCropsGrass_QuantityActUnits_MR.l(Countries,"Forest","AllProdSyst","AllProdCond",Scenarios))
                         /(VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"All crops","AllProdSyst","AllProdCond",Scenarios)
                                 +VActCropsGrass_QuantityActUnits_MR.l(BioeSR15_Region,"Forest","AllProdSyst","AllProdCond",Scenarios)));

*this leads to inconsistent country values for Forest and crop residues DM inputs and N outputs, as the shares refer to different regions and thus need not be consistent.
*the easiest solution: sum to world values and derive the relation N output per DM input on global level only:
VEnergyProduction_MR.l("World","Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)",Scenarios)
         =sum(countries,VEnergyProduction_MR.l(Countries,"Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)",Scenarios));
VEnergyProduction_MR.l("World","Secondary energy","AllEnTypes","Forest and crop residues","N from Bioe residues (tN)",Scenarios)
         =sum(countries,VEnergyProduction_MR.l(Countries,"Secondary energy","AllEnTypes","Forest and crop residues","N from Bioe residues (tN)",Scenarios));
*for the 2050 and 2100 scenraio, these values are roughly in good relation; not for 2010, though


*derive the N output per DM Biomass energy conversion input: capture this as characteristics of the crop residue managment system "Bioenergy" - and for Miscanthus, 100% main output goes to these system
CropResidues_Management_MR(Countries,"Miscanthus","Average residues (t DM)","Crop res N for areas (tN/t DM res)","All bioenergy","AllProdSyst","AllProdCond",Scenarios)
                 $VEnergyProduction_MR.l("World","Secondary energy","AllEnTypes","Miscanthus","Bioe conversion Biomass input (tDM)",Scenarios)
         = VEnergyProduction_MR.l("World","Secondary energy","AllEnTypes","Miscanthus","N from Bioe residues (tN)",Scenarios)
                 /VEnergyProduction_MR.l("World","Secondary energy","AllEnTypes","Miscanthus","Bioe conversion Biomass input (tDM)",Scenarios);

CropResidues_Management_MR(Countries,"All crops","Average residues (t DM)","Crop res N for areas (tN/t DM res)","All bioenergy","AllProdSyst","AllProdCond",Scenarios)
                 $VEnergyProduction_MR.l("World","Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)",Scenarios)
         = VEnergyProduction_MR.l("World","Secondary energy","AllEnTypes","Forest and crop residues","N from Bioe residues (tN)",Scenarios)
                 /VEnergyProduction_MR.l("World","Secondary energy","AllEnTypes","Forest and crop residues","Bioe conversion Biomass input (tDM)",Scenarios);

ActForest_OtherChar_MR(Countries,"Forest","Forest res bioe N for areas (tN/t DM res)","AllProdSyst","AllProdCond",Scenarios)
         = CropResidues_Management_MR(Countries,"All crops","Average residues (t DM)","Crop res N for areas (tN/t DM res)","All bioenergy","AllProdSyst","AllProdCond",Scenarios);




*3.2.7) Derive fresh matter yields from DM yields and DM contents:
ActCropsGrass_Outputs_MR(Countries,"Miscanthus","MainOutput1 (t)","AllProdSyst","AllProdCond",Scenarios)
                 $Commod_Contents(Countries,"Miscanthus","DM (t)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Outputs_MR(Countries,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
                 /Commod_Contents(Countries,"Miscanthus","DM (t)","AllProdSyst","AllProdCond");


*3.2.8) Assign Bioe-Res values to crop residue parameters and variables:
*as neeed to later derive crop res quantities etc.
VCropResidues_Quantity_MR.l(Regions,"Miscanthus","Average residues (t)",ProductionSystems,ProductionConditions,Scenarios)
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus","MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios)
                 *VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus",ProductionSystems,ProductionConditions,Scenarios);

CropResidues_Management_MR(Regions,"Miscanthus","Average Residues (t)","Quantity share in CropResMan system","All Bioenergy",ProductionSystems,ProductionConditions,Scenarios)
                 $ActCropsGrass_Outputs_MR(Regions,"Miscanthus","MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios)
         = 1;

CropResidues_Management_MR(Regions,"Miscanthus","Average residues (t)","Crop res N for areas (tN)","All Bioenergy",ProductionSystems,ProductionConditions,Scenarios)
         = CropResidues_Management_MR(Regions,"Miscanthus","Average residues (t DM)","Crop res N for areas (tN/t DM res)","All bioenergy",ProductionSystems,ProductionConditions,Scenarios)
                 *Commod_Contents(Regions,"Miscanthus","DM (t)",ProductionSystems,ProductionConditions);

CropResidues_OtherChar_MR(Regions,"Miscanthus","Average residues (t)","Residue share t DM / t DM MainOutput1",ProductionSystems,ProductionConditions,Scenarios)
                 $ActCropsGrass_Outputs_MR(Regions,"Miscanthus","MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios)
         = 1;

CropResidues_Contents_MR(Regions,"Miscanthus","Average residues (t)","DM (t) - before management",ProductionSystems,ProductionConditions,Scenarios)
                 $ActCropsGrass_Outputs_MR(Regions,"Miscanthus","MainOutput1 (t)",ProductionSystems,ProductionConditions,Scenarios)
         = Commod_Contents(Regions,"Miscanthus","DM (t)",ProductionSystems,ProductionConditions);

*XXXXXXXXXXXXXXx
*CropResidues_Contents_MR(Regions_MR,"Miscanthus","Average residues (t)","N (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%");
*CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","DM (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%");
*
*                 VCommod_Contents_MR.l(Regions_MR,Commodities_MR,"DM (t)",ProductionSystems,ProductionConditions,"%Scenario%")
*                         *CropResidues_OtherChar_MR(Regions_MR,Activities_MR,"Average residues (t)","Residue share t DM / t DM MainOutput1",ProductionSystems,ProductionConditions,"%Scenario%"));
*                 *CropResidues_Contents_MR(Regions_MR,Activities_MR,"Average residues (t)","N (t) - before management",ProductionSystems,ProductionConditions,"%Scenario%");

*3.2.9) Assign useful parameters and variables to baseline values
*this applies to Miscanthus only - for the rest, we already have baseline values
*and do it via the parameters and variable for initialisation, without scenario dimension, as in SteeringFile2, those are used as a basis to assign the baseline values.
ActCropsGrass_Outputs(Regions,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Outputs_MR(Regions,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond","BioeSR15_P4_2010");
ActCropsGrass_Outputs(Countries,"Miscanthus","MainOutput1 (t)","AllProdSyst","AllProdCond")
         = ActCropsGrass_Outputs_MR(Countries,"Miscanthus","MainOutput1 (t)","AllProdSyst","AllProdCond","BioeSR15_P4_2010");
VActCropsGrass_QuantityActUnits.l(Regions,"Miscanthus","AllProdSyst","AllProdCond")
         = VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst","AllProdCond","BioeSR15_P4_2010");

CropResidues_OtherChar(Regions,"Miscanthus","Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond")
         = CropResidues_OtherChar_MR(Regions,"Miscanthus","Average residues (t)","Residue share t DM / t DM MainOutput1","AllProdSyst","AllProdCond","BioeSR15_P4_2010");
CropResidues_Management(Regions,"Miscanthus","Average Residues (t)","Quantity share in CropResMan system","All Bioenergy","AllProdSyst","AllProdCond")
         = CropResidues_Management_MR(Regions,"Miscanthus","Average Residues (t)","Quantity share in CropResMan system","All Bioenergy","AllProdSyst","AllProdCond","BioeSR15_P4_2010");
CropResidues_Management(Regions,"Miscanthus","Average Residues (t)","Crop res N for areas (tN)","All Bioenergy","AllProdSyst","AllProdCond")
         = CropResidues_Management_MR(Regions,"Miscanthus","Average Residues (t)","Crop res N for areas (tN)","All Bioenergy","AllProdSyst","AllProdCond","BioeSR15_P4_2010");

CropResidues_Contents(Regions,"Miscanthus","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond")
         = CropResidues_Contents_MR(Regions,"Miscanthus","Average residues (t)","DM (t) - before management","AllProdSyst","AllProdCond","BioeSR15_P4_2010");




*3.2.10) assign convent and organic values here, as we have no baseline values for BioeSR15, which are needed for assigning convent/organic values in assign initial values to scenarios
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,Scenarios)
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Convent",ProductionConditions,Scenarios))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,Scenarios);
CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,Scenarios)
                 $(NOT CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"Organic",ProductionConditions,Scenarios))
         = CropResidues_Management_MR(Regions,Activities,OutputsCropsGrass,CropResManagement,CropResManSystem,"AllProdSyst",ProductionConditions,Scenarios);

ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,Scenarios)
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Convent",ProductionConditions,Scenarios))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,Scenarios);
ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,Scenarios)
                 $(NOT ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"Organic",ProductionConditions,Scenarios))
         = ActCropsGrass_Outputs_MR(Regions,Activities,OutputsCropsGrass,"AllProdSyst",ProductionConditions,Scenarios);

ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,Scenarios)
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Convent",ProductionConditions,Scenarios))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,Scenarios);
ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,Scenarios)
                 $(NOT ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"Organic",ProductionConditions,Scenarios))
         = ActAnimalsHead_Outputs_MR(Regions,Activities,ProducingAnimals,OutputsAnimals,"AllProdSyst",ProductionConditions,Scenarios);



*3.2.11) Some auxiliary variables used to adapt feed supply in the BioeSR15 scenarios

Parameter AUX_FeedSupplyFactor_BioeSR15_MR(Regions,Scenarios) auxiliary parameter capturing the total feed demand in the BioeSR15 scenario P4;

AUX_FeedSupplyFactor_BioeSR15_MR(Regions,Scenarios)
         =sum((BioeSR15_Region,Years)$(MatchBioeSR15_SOLm_Regions(BioeSR15_Region,Regions)
                         AND Match_BioeSR15Years_Scenarios(Years,Scenarios)),
                  BioenergySR15_P4_MAgPIE("MAgPIE",BioeSR15_Region,"Agricultural Demand|Feed","million t DM/yr",Years)*1000000);
*assign to country values:
AUX_FeedSupplyFactor_BioeSR15_MR(Countries,Scenarios)
         = sum(BioeSR15_Region$BioenergySR15_CountriesByModelRegion_MAgPIE(Countries,BioeSR15_Region),
                 AUX_FeedSupplyFactor_BioeSR15_MR(BioeSR15_Region,Scenarios));



$ontext;
still to be added to SOLm variables and parameters from BioeSR15_Variables:

from IAMC
Carbon Sequestration|CCS
Carbon Sequestration|CCS|Biomass

Final Energy
Final Energy|Electricity
Final Energy|Gases
Final Energy|Heat
Final Energy|Hydrogen
Final Energy|Liquids
Final Energy|Solids
Final Energy|Solids|Biomass

Land Cover|Other Natural Land

Primary Energy|Biomass|Modern|w/ CCS
Primary Energy|Biomass|Modern|w/o CCS

Secondary Energy|Electricity|Biomass|w/ CCS
Secondary Energy|Electricity|Biomass|w/o CCS

Secondary Energy|Hydrogen|Biomass|w/ CCS
Secondary Energy|Hydrogen|Biomass|w/o CCS

Secondary Energy|Liquids|Biomass|w/ CCS
Secondary Energy|Liquids|Biomass|w/o CCS

from MAgPIE
Land Cover|Cropland|Irrigated
Water|Withdrawal|Irrigation

$offtext;














$exit;






$ontext;
After this we have the following in SOLm entities, partly on country/activity level:

HumanCharacteristics_MR(Regions,"PopulationAll","kcal/cap/day (BioeSR15 req)","All Commodities",Scenarios)
HumanCharacteristics_MR(Regions,"PopulationAll","kcal/cap/day (BioeSR15 req)","All crop based Commodities",Scenarios)
HumanCharacteristics_MR(Regions,"PopulationAll","kcal/cap/day (BioeSR15 req)","All animal based Commodities",Scenarios)

VActCropsGrass_QuantityActUnits_MR.l(Regions,"All crops","AllProdSyst","AllProdCond",Scenarios)
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Grass","AllProdSyst","AllProdCond",Scenarios)
VActCropsGrass_QuantityActUnits_MR.l(Regions,"Miscanthus","AllProdSyst","AllProdCond",Scenarios)
VActCropsGrass_QuantityActUnits_MR.l(Regions,"All Cereals","AllProdSyst","AllProdCond",Scenarios)
VActCropsGrass_QuantityActUnits_MR.l(Countries,Crops,"AllProdSyst","AllProdCond",Scenarios)
VActCropsGrass_QuantityActUnits_MR.l(Countries,TempAndPermMeadAndPastures,"AllProdSyst","AllProdCond",Scenarios)
VActCropsGrass_QuantityActUnits_MR.l(Countries,Cereals,"AllProdSyst","AllProdCond",Scenarios)

VActCropsGrass_Outputs_MR.l(Regions,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
VActCropsGrass_Outputs_MR.l(Regions,"All non-energy crops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
VActCropsGrass_Outputs_MR.l(Regions,"All Cereals","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)

VActCropsGrass_Inputs_MR.l(Regions,"All crops and grass","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)
VActCropsGrass_Inputs_MR.l(Regions,"Miscanthus","N from all fertilizers (tN)","AllProdSyst","AllProdCond",Scenarios)

ActCropsGrass_Outputs_MR(Regions,"All Cereals","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
ActCropsGrass_Outputs_MR(Regions,"Miscanthus","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
ActCropsGrass_Outputs_MR(Countries,"Miscanthus","MainOutput1 (t)","AllProdSyst","AllProdCond",Scenarios)
ActCropsGrass_Outputs_MR(Regions,"All Sugar Crops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)
ActCropsGrass_Outputs_MR(Regions,"All Oilcrops","MainOutput1 (t DM)","AllProdSyst","AllProdCond",Scenarios)

VPopulationNumbers_MR.l(Regions,"PopulationAll",Scenarios)

VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","AllEnSources","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","Biomass","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Electricity","AllEnSources","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Electricity","Biomass","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","AllEnSources","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","Biomass","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Hydrogen","AllEnSources","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Hydrogen","Biomass","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","AllEnSources","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","Biomass","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","Miscanthus","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Primary energy","AllEnTypes","Forest and crop residues","Production (EJ)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","Miscanthus","N from Bioe residues (tN)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","Miscanthus","N from Bioe residues (tN)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Gases","Forest and crop residues","N from Bioe residues (tN)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","Miscanthus","N from Bioe residues (tN)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Liquids","Biomass","N from Bioe residues (tN)",Scenarios)
VEnergyProduction_MR.l(Regions,"Secondary energy","Electricity","EtOH residues","Production (EJ)",Scenarios)

VActForest_QuantityActUnits_MR.l(Regions,"Forestry","AllProdSyst","AllProdCond",Scenarios)
VActForest_QuantityActUnits_MR.l(Regions,"Natural Forest","AllProdSyst","AllProdCond",Scenarios)
VActForest_QuantityActUnits_MR.l(Regions,"Forest","AllProdSyst","AllProdCond",Scenarios)
VActForest_QuantityActUnits_MR.l(BioeSR15_Region,"Primary Forest","AllProdSyst","AllProdCond","Baseline")

Commod_Contents(Countries,"Miscanthus","N (t)","AllProdSyst","AllProdCond")
Commod_Contents(Countries,"Miscanthus","N in DM (t)","AllProdSyst","AllProdCond")


Regions     is      FAOSTAT_Countries
Activities  is      crops, grass and forest

$offtext;


$ontext;

maybe of use elsewhere; :

execute 'gdxxrw Test.gdx output=BioenergySR15_P4_Test.xlsx par=BioenergySR15_P4 rng=A1'
$offtext;







