# Share of individual FAO-items in aggregated groups (per country)
####################################################################
# 12.02.2021 / P. Krayer
############################################################

# To Do: check na's and other strange values...


# 0 - Preparation ---------------------------------------------------------

# 0a - set  working directory
# 0b - load dataframe from file "1_load_21042.R"

source("1_load_210427.R")
#later, integrate imputation script here!!!
#usda_final2_sr28 <- read.delim("usda_final2_sr28.csv", header = TRUE, sep = ",")


# 0c - load libraries
library(tidyverse)


# 1 - Import datasheets from FAOSTAT -------------------------------------


FAO_SUA_crops_2018 <- read.delim("FAO_SUA_crops_2018.csv", header = TRUE, sep = ";", na.strings = "")
FAO_SUA_cropsProcessed_2018 <- read.delim("FAO_SUA_cropsProcessed_2018.csv", header = TRUE, sep = ";", na.strings = "")
FAO_SUA_livestock_2018 <- read.delim("FAO_SUA_livestock_2018.csv", header = TRUE, sep = ";", na.strings = "")
FAO_SUA_livestockProcessed_2018 <- read.delim("FAO_SUA_livestockProcessed_2018.csv", header = TRUE, sep = ";", na.strings = "")


# 2 - Calculate DAQ -------------------------------------------------------

FAO_SUA_crops_2018 %>% 
  mutate(Value = replace_na(Value, 0)) %>% #replace NAs with zeros
  group_by(Area,Item) %>%
  summarise(Prod = Value[Element == "Production"], Exp = Value[Element == "Export Quantity"], Imp = Value[Element == "Import Quantity"]) %>%
  mutate(DAQ = Prod - Exp + Imp) -> FAO_DAQ_crops #table with domestically available quantities per country and commodity

FAO_SUA_cropsProcessed_2018 %>% 
  mutate(Value = replace_na(Value, 0)) %>% #replace NAs with zeros
  group_by(Area,Item) %>%
  summarise(Prod = Value[Element == "Production"], Exp = Value[Element == "Export Quantity"], Imp = Value[Element == "Import Quantity"]) %>%
  mutate(DAQ = Prod - Exp + Imp) -> FAO_DAQ_cropsProcessed #table with domestically available quantities per country and commodity

FAO_SUA_livestock_2018 %>% 
  mutate(Value = replace_na(Value, 0)) %>% #replace NAs with zeros
  group_by(Area,Item) %>%
  summarise(Prod = Value[Element == "Production"], Exp = Value[Element == "Export Quantity"], Imp = Value[Element == "Import Quantity"]) %>%
  mutate(DAQ = Prod - Exp + Imp) -> FAO_DAQ_livestock #table with domestically available quantities per country and commodity

FAO_SUA_livestockProcessed_2018 %>% 
  mutate(Value = replace_na(Value, 0)) %>% #replace NAs with zeros
  group_by(Area,Item) %>%
  summarise(Prod = Value[Element == "Production"], Exp = Value[Element == "Export Quantity"], Imp = Value[Element == "Import Quantity"]) %>%
  mutate(DAQ = Prod - Exp + Imp) -> FAO_DAQ_livestockProcessed #table with domestically available quantities per country and commodity


# 3 - Prepare for further calculation -------------------------------------

#set negative values to zero (to calculate share, a negative consumption balance through export equals to
# no consumption)

FAO_DAQ_crops %>% 
  mutate(DAQ = ifelse(DAQ <0, 0, DAQ)) -> FAO_DAQ_crops_noNeg
  
FAO_DAQ_cropsProcessed %>% 
  mutate(DAQ = ifelse(DAQ <0, 0, DAQ)) -> FAO_DAQ_cropsProcessed_noNeg

FAO_DAQ_livestock %>% 
  mutate(DAQ = ifelse(DAQ <0, 0, DAQ)) -> FAO_DAQ_livestock_noNeg

FAO_DAQ_livestockProcessed %>% 
  mutate(DAQ = ifelse(DAQ <0, 0, DAQ)) -> FAO_DAQ_livestockProcessed_noNeg


#create one single table

FAO_DAQ_crops_noNeg %>%
  bind_rows(FAO_DAQ_cropsProcessed_noNeg) %>%
  bind_rows(FAO_DAQ_livestock_noNeg) %>%
  bind_rows(FAO_DAQ_livestockProcessed_noNeg) -> FAO_DAQ_all


# 4 - Calculate shares of individual items in aggregated groups -----------

matching_list2_R <- read.delim("matching_list2_R_210622.csv", header = TRUE, sep = ";")


#add number of observations - could be removed..

matching_list2_R %>%
  group_by(FAO_agg_items, FAO_ind_items) %>%
  summarise(group = FAO_GrpCd, ind = FAO_item_No) %>% 
  distinct() %>% #remove duplicates
  ungroup() %>%
  add_count(FAO_agg_items) -> matching_summary #add observations per group - still necessary?
  
# add share for each country - not to be removed..
matching_summary %>% 
  full_join(FAO_DAQ_all, by = c("FAO_ind_items" = "Item")) %>% #join with DAQ-values for each country
  group_by(Area, FAO_agg_items) %>% 
  mutate(sum_per_group = sum(DAQ)) %>% #calculate sum of DAQ for each country, group
  mutate(share_per_group = ifelse(sum_per_group == 0,100, DAQ/sum_per_group*100)) %>% #calculate share of DAQ for each ind. item
  select(Area, FAO_agg_items, FAO_ind_items, DAQ, sum_per_group, share_per_group) ->share_per_group_country





# 5 - Export File ---------------------------------------------------------

write.csv(share_per_group_country, "share_per_group_country.csv", row.names = FALSE)





