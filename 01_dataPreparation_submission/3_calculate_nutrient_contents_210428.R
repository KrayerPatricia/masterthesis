# match the FAO items with the USDA items & calculate nutrient contents
############################################
# 05.03.2021
#############################################


# 0 - Preparations --------------------------------------------------------


# 0a) set working directory to source file location

# 0b) Import dataframes from previous module 2 (or load csv.file)
source("2_sharesPerCountry_210427.R")
#or
#share_per_group_country <- read.delim("share_per_group_country.csv", header = TRUE, sep = ",")
#matching_list2_R <- read.delim("matching_list2_R.csv", header = TRUE, sep = ";")

# use imputation? If yes, replace usda_final_sr28 with the imputed dataset
usda_final2_sr28_imp <- read.delim("usda_final2_sr28_imp.csv", header = TRUE, sep = ",")
usda_final2_sr28 <- usda_final2_sr28_imp
######################################################


# 1 - calculate correction factor & add nutrient contents for ind. items  -------------------------------------
# I do the correction to compensate for effects like different water contents etc..
#extract kcal contents for USDA items
#try to replace this with final_imp
usda_final2_sr28 %>%
  group_by(NDB_No) %>%
  summarise(kcal_USDA = Nutr_Val[NutrDesc == "Energy" & Units == "kcal"]) -> kcal_USDA

matching_list2_R %>%
  left_join(usda_final2_sr28, by = c("USDA_item_NDB_No" = "NDB_No")) %>% #join the USDA nutrients with the matching list
  left_join(kcal_USDA, by = c("USDA_item_NDB_No" = "NDB_No")) %>% #add coloumn with USDA-kcal values
  mutate(corr = ifelse(kcal_USDA == 0, 1, kcal_content_FAO/kcal_USDA)) %>% #calculate a conversion factor USDA -> FAO here
  mutate(Value_corr = ifelse(is.na(corr), Nutr_Val ,Nutr_Val*corr)) %>% #add variable for corrected nutrient values (if corrected value is available) 
  group_by(FAO_item_No, FAO_ind_items, NutrDesc, Units) %>% 
  summarise(Value_final_mean = mean(Value_corr)) %>% #calculate mean-value for all USDA-items per ind. item & nutrient 
  mutate(Units = replace(Units, Units == "µg", "ug")) -> nutrient_contents_individual_items

# 1b - addition - add here Full DB values (items which are not included in sr28) ----------------------------------

#20.05.2021: add here nutrient values of FullDB-items
#Energy, Carbohydrates, dietary fibres, proteins, fat, sugars, saturated fatty acids, LA n-6PUFA, Vitamin A (IU), B2 (riboflavin), ALA n-3 PUFA, b3 (Niacin), D, (Iodine), Potassium, Iron, B12, Calcium, Zinc, Selenium 
AA_referenceValues <- read.delim("AA_referenceValues_210428.csv", header = TRUE, sep = ";") #import data for reference values
AA_selection <- AA_referenceValues$AA
nutrient_selection <- c("Energy", #nutrient names in database FullDB
                        "Carbohydrate, by difference", 
                        "Fiber, total dietary", "Protein", 
                        "Total lipid (fat)", 
                        "Sugars, total including NLEA", 
                        "Fatty acids, total saturated", 
                        "18:2 n-6 c,c", "Vitamin A, RAE",
                        "Riboflavin", 
                        "18:3 n-3 c,c,c (ALA)", 
                        "Niacin", 
                        "Vitamin D (D2 + D3)", 
                        "Potassium, K", 
                        "Iron, Fe", 
                        "Vitamin B-12", 
                        "Calcium, Ca", 
                        "Zinc, Zn", 
                        "Selenium, Se", 
                        AA_selection,
                        #new
                        'Vitamin C, total ascorbic acid',
                        'Fatty acids, total polyunsaturated',
                        'Fatty acids, total saturated',
                        'Fatty acids, total trans',
                        'Fiber, total dietary',
                        'Sodium, Na')

nutr_sr28 <- c("Energy", #add nutrient names SR28
               "Carbohydrate, by difference", 
               "Fiber, total dietary", 
               "Protein", 
               "Total lipid (fat)", 
               "Sugars, total", 
               "Fatty acids, total saturated", 
               "18:2 n-6 c,c", 
               "Vitamin A, RAE", 
               "Riboflavin", 
               "18:3 n-3 c,c,c (ALA)", 
               "Niacin", 
               "Vitamin D (D2 + D3)", 
               "Potassium, K", 
               "Iron, Fe", 
               "Vitamin B-12", 
               "Calcium, Ca", 
               "Zinc, Zn", 
               "Selenium, Se", 
               AA_selection,
               #new
               'Vitamin C, total ascorbic acid',
               'Fatty acids, total polyunsaturated',
               'Fatty acids, total saturated',
               'Fatty acids, total tran',
               'Fiber, total dietary',
                'Sodium, Na'
)

length_nutrients <- length(nutrient_selection)



#Sweet potatoe
sweet_potatoe <- data.frame(FAO_item_No = rep(122,4*length_nutrients ), FAO_ind_items = rep("Sweet potatoe", 4*length_nutrients), FullDBNo = rep(c(1103235,1103241,1103256,1103272), each = length_nutrients) , nutrients_FullDB = nutrient_selection, nutrients_SR28 = nutr_sr28)
#join with FullDB values
sweet_potatoe %>% 
  left_join(usda_fullDB2, by = c("FullDBNo" = "fdc_id", "nutrients_FullDB" = "name")) %>% #join prepared df with FullDB values
  select(FAO_item_No, FAO_ind_items, FullDBNo, nutrients_SR28 ,description, amount, unit_name) %>%
  group_by(nutrients_SR28, FAO_ind_items, unit_name) %>%
  summarise(Mean = mean(amount, na.rm = TRUE)) %>% #calculate mean per nutrient
  mutate(FAO_ind_items = "Sweet potatoes") %>% #add name
  mutate(Energy = 95, FAO_item_No = 122, FAO_kcal = 92 ) %>% #add correction factor
  mutate(corr = FAO_kcal / Energy ) %>% 
  mutate(Value_final_mean = Mean*corr) %>% #correct value
  rename(Units = unit_name, NutrDesc = nutrients_SR28) %>%
  mutate(Units = tolower(Units)) -> sweet_potatoes_average #convert units to lower cases 
sweet_potatoes_average %>% 
  ungroup %>%
  select(FAO_item_No, FAO_ind_items, NutrDesc, Units, Value_final_mean) ->  sweet_potatoe_rtb



#cider
cider <- data.frame(FAO_item_No = rep(517,length_nutrients ), FAO_ind_items = rep("Cider etc", length_nutrients), FullDBNo = rep(c(1102746), each = length_nutrients) , nutrients_FullDB = nutrient_selection, nutrients_SR28 = nutr_sr28)
cider %>% 
  left_join(usda_fullDB2, by = c("FullDBNo" = "fdc_id", "nutrients_FullDB" = "name")) %>% #join prepared df with FullDB values
  select(FAO_item_No, FAO_ind_items, FullDBNo, nutrients_SR28 ,description, amount, unit_name) %>%
  group_by(nutrients_SR28, FAO_ind_items, unit_name) %>%
  summarise(Mean = mean(amount, na.rm = TRUE)) %>% #calculate mean per nutrient
  mutate(FAO_ind_items = "Cider etc", FAO_item_No = 517) %>% #add name
  mutate(corr = 1 ) %>% #set correction factor 1 (since NA for FAO_kcal)
  mutate(Value_final_mean = Mean*corr) %>% #correct value
  rename(Units = unit_name, NutrDesc = nutrients_SR28) %>%
  mutate(Units = tolower(Units)) %>%  #-> cider_average #convert units to lower cases 
  select(FAO_item_No, FAO_ind_items, NutrDesc, Units, Value_final_mean) ->  cider_rtb


#ghee
ghee_sheep <- data.frame(FAO_item_No = rep(983,length_nutrients ), FAO_ind_items = rep("Butter and ghee, sheep milk", length_nutrients), FullDBNo = rep(c(1103844), each = length_nutrients) , nutrients_FullDB = nutrient_selection, nutrients_SR28 = nutr_sr28)
ghee_cow <- data.frame(FAO_item_No = rep(887,length_nutrients ), FAO_ind_items = rep("Ghee, butteroil of cow milk", length_nutrients), FullDBNo = rep(c(1103844), each = length_nutrients) , nutrients_FullDB = nutrient_selection, nutrients_SR28 = nutr_sr28)
ghee_buffalo <- data.frame(FAO_item_No = rep(953,length_nutrients ), FAO_ind_items = rep("Ghee, buffalo milk", length_nutrients), FullDBNo = rep(c(1103844), each = length_nutrients) , nutrients_FullDB = nutrient_selection, nutrients_SR28 = nutr_sr28)


ghee_sheep %>% 
  left_join(usda_fullDB2, by = c("FullDBNo" = "fdc_id", "nutrients_FullDB" = "name")) %>% #join prepared df with FullDB values
  select(FAO_item_No, FAO_ind_items, FullDBNo, nutrients_SR28 ,description, amount, unit_name) %>%
  group_by(FAO_item_No, nutrients_SR28, FAO_ind_items, unit_name) %>%
  summarise(Mean = mean(amount, na.rm = TRUE)) %>% #calculate mean per nutrient
  mutate(kcal_USDA = 876, kcal_FAO = 717) %>%
  mutate(corr = kcal_FAO/kcal_USDA ) %>% #set correction factor 1 (since NA for FAO_kcal)
  mutate(Value_final_mean = Mean*corr) %>% #correct value
  rename(Units = unit_name, NutrDesc = nutrients_SR28) %>%
  mutate(Units = tolower(Units)) %>%  #-> cider_average #convert units to lower cases 
  select(FAO_item_No, FAO_ind_items, NutrDesc, Units, Value_final_mean) ->  ghee_sheep_rtb

ghee_cow %>% 
  left_join(usda_fullDB2, by = c("FullDBNo" = "fdc_id", "nutrients_FullDB" = "name")) %>% #join prepared df with FullDB values
  select(FAO_item_No, FAO_ind_items, FullDBNo, nutrients_SR28 ,description, amount, unit_name) %>%
  group_by(FAO_item_No, nutrients_SR28, FAO_ind_items, unit_name) %>%
  summarise(Mean = mean(amount, na.rm = TRUE)) %>% #calculate mean per nutrient
  mutate(kcal_USDA = 876, kcal_FAO = 717) %>%
  mutate(corr = kcal_FAO/kcal_USDA ) %>% #set correction factor 1 (since NA for FAO_kcal)
  mutate(Value_final_mean = Mean*corr) %>% #correct value
  rename(Units = unit_name, NutrDesc = nutrients_SR28) %>%
  mutate(Units = tolower(Units)) %>%  #-> cider_average #convert units to lower cases 
  select(FAO_item_No, FAO_ind_items, NutrDesc, Units, Value_final_mean) ->  ghee_cow_rtb

ghee_buffalo %>% 
  left_join(usda_fullDB2, by = c("FullDBNo" = "fdc_id", "nutrients_FullDB" = "name")) %>% #join prepared df with FullDB values
  select(FAO_item_No, FAO_ind_items, FullDBNo, nutrients_SR28 ,description, amount, unit_name) %>%
  group_by(FAO_item_No, nutrients_SR28, FAO_ind_items, unit_name) %>%
  summarise(Mean = mean(amount, na.rm = TRUE)) %>% #calculate mean per nutrient
  mutate(kcal_USDA = 876, kcal_FAO = 717) %>%
  mutate(corr = kcal_FAO/kcal_USDA ) %>% 
  mutate(Value_final_mean = Mean*corr) %>% #correct value
  rename(Units = unit_name, NutrDesc = nutrients_SR28) %>%
  mutate(Units = tolower(Units)) %>%  #-> cider_average #convert units to lower cases 
  select(FAO_item_No, FAO_ind_items, NutrDesc, Units, Value_final_mean) ->  ghee_buffalo_rtb


#cassava
cassava <- data.frame(FAO_item_No = rep(125,length_nutrients ), FAO_ind_items = rep("Cassava", length_nutrients), FullDBNo = rep(c(1103070), each = length_nutrients) , nutrients_FullDB = nutrient_selection, nutrients_SR28 = nutr_sr28)

cassava %>% 
  left_join(usda_fullDB2, by = c("FullDBNo" = "fdc_id", "nutrients_FullDB" = "name")) %>% #join prepared df with FullDB values
  select(FAO_item_No, FAO_ind_items, FullDBNo, nutrients_SR28 ,description, amount, unit_name) %>%
  group_by(FAO_item_No, nutrients_SR28, FAO_ind_items, unit_name) %>%
  summarise(Mean = mean(amount, na.rm = TRUE)) %>% #calculate mean per nutrient
  mutate(kcal_USDA = 191, kcal_FAO = 109) %>%
  mutate(corr = kcal_FAO/kcal_USDA ) %>% 
  mutate(Value_final_mean = Mean*corr) %>% #correct value
  rename(Units = unit_name, NutrDesc = nutrients_SR28) %>%
  mutate(Units = tolower(Units)) %>%  #-> cider_average #convert units to lower cases 
  select(FAO_item_No, FAO_ind_items, NutrDesc, Units, Value_final_mean) ->  cassava_rtb

#add to original dataframe
nutrient_contents_individual_items %>%
  bind_rows(sweet_potatoe_rtb) %>%
  bind_rows(cider_rtb) %>%
  bind_rows(ghee_sheep_rtb) %>% 
  bind_rows(ghee_cow_rtb)  %>% #add observations
  bind_rows(ghee_buffalo_rtb) %>% #add observations
  bind_rows(cassava_rtb) -> nutrient_contents_individual_items #add observations




# 2 - Calculate and add amino acid score (AAS)  -------------------------------


#AA_referenceValues <- read.delim("AA_referenceValues_210428.csv", header = TRUE, sep = ";") #import data for reference values

#extract protein contents of individual items
nutrient_contents_individual_items %>%
  ungroup() %>%
  group_by(FAO_ind_items) %>%
  filter(NutrDesc == "Protein") %>%
  select(2,5) %>%
  rename(protein = Value_final_mean)-> protein_contents
#  summarise(protein = Value_final_mean[NutrDesc == "Protein"]) -> protein_contents

#calculate Amino Acid Score (AAS) for each item
nutrient_contents_individual_items %>% 
  left_join(AA_referenceValues, by = c("NutrDesc" = "AA")) %>% #add reference values to amino acids
  ungroup() %>%
  left_join(protein_contents, by = "FAO_ind_items") %>% #add coloumn with protein contents
  filter(NutrDesc %in% c("Histidine", "Leucine", "Isoleucine", "Lysine", "Threonine", "Valine", "Methionine", "Cystine", "Phenylalanine", "Tryptophan", "Tyrosine")) %>% #extract relevant rows
  mutate(AA_per_prot = ifelse(protein == 0, 0, Value_final_mean/protein*1000)) %>% #calculate mg AA per g protein 
  mutate(AA_per_prot = ifelse(AA_per_prot > 1000, 150, AA_per_prot)) %>% #limit to reasonable value of 150 (which is already very high)
  mutate(AAS_ref = AA_per_prot / Ref_value *100) %>% # divide by reference value
#  mutate(AAS_ref = ifelse(AAS_ref > 130, 0, AAS_ref)) -> test1

#%>% #delete unrealistic values 
  group_by(FAO_ind_items) %>%
  summarise(AA = NutrDesc, AAS_ref = AAS_ref, AAS_interim = ifelse(NutrDesc %in% c("Methionine", "Cystine"),sum(AAS_ref[NutrDesc %in% c("Methionine", "Cystine")]), AAS_ref))%>% #AAS interim considers agg. ref values for Methionine and Cystine
  mutate(AAS_interim = ifelse(AA %in% c("Phenylalanine", "Tryptophan", "Tyrosine"),sum(AAS_ref[AA %in% c("Phenylalanine", "Tryptophan", "Tyrosine")]), AAS_interim)) %>% #same as above
  mutate(AAS = min(AAS_interim)) %>% #AAS = min value of AAS_interim for each item
  select(FAO_ind_items, AAS) %>% #select relevant variables
  distinct() %>% #reduce to one row per item
  mutate(Units = "dmnl") %>%
  mutate(AAS = ifelse(AAS > 130, 130,AAS))-> AAS_values #add unit and save, limit to reasonable values


#now add to nutrient list
nutrient_contents_individual_items %>%
  ungroup() %>%
  select(FAO_item_No, FAO_ind_items) %>% #extract list with FAO-items names and item codes
  distinct() -> FAO_item_No

AAS_values %>%
  pivot_longer(AAS, names_to = "NutrDesc", values_to = "Value_final_mean")  %>% #correct format
  left_join(FAO_item_No, by = "FAO_ind_items") -> AAS_list_long #add item code to AAS list

nutrient_contents_individual_items %>% 
  bind_rows(AAS_list_long) -> nutrients_AAS_individual_items #append the newly generated observations (AAS list) to nutrients


#concatenate units and names (for use in SOLm)
nutrients_AAS_individual_items %>%
  mutate(Nutrients = paste0(NutrDesc, " (", Units, ")")) -> nutrients_AAS_individual_items



# 3 - calculate nutrient values of aggregated groups ------------------------------------

nutrients_AAS_individual_items %>%
  left_join(share_per_group_country, by = "FAO_ind_items") %>% #add share in group per item and country
  ungroup() %>%
  select(-c(FAO_item_No, sum_per_group,DAQ)) %>% #remove auxiliary variables 
  group_by(Area, FAO_agg_items, NutrDesc, Units, Nutrients) %>%
  summarise(Value_agg = sum(Value_final_mean*share_per_group/100)) %>% #calculate weighted value per food group
  #set some values to zero (are not reasonable)
  mutate(Value_agg = ifelse(NutrDesc == "AAS" & FAO_agg_items %in% c("Sweeteners, Other", "Lemons, Limes and products", "Citrus, Other", "Wine", "Tea (including mate)"), 0, Value_agg)) -> nutrient_contents_agg_items


#for use in SOLm, concatenate NutrDesc and Units
nutrient_contents_agg_items %>%
  mutate(Nutrients = paste0(NutrDesc, " (", Units, ")")) -> nutrient_contents_agg_items
  

# 4 - Export files --------------------------------------------------------

write.csv(nutrients_AAS_individual_items, "nutrients_AAS_individual_items.csv", row.names = FALSE)
write.csv(nutrient_contents_agg_items, "nutrient_contents_agg_items.csv", row.names = FALSE)



