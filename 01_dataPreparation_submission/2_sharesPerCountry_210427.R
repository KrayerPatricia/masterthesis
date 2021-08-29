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

#import matching file (matched 661 USDA-items with FAO-items)
#matching_list2_R <- read.delim("matching_list2_R.csv", header = TRUE, sep = ";")
matching_list2_R <- read.delim("matching_list2_R_210622.csv", header = TRUE, sep = ";")


#add number of observations (ind. items per group) - maybe remove this later XX

matching_list2_R %>%
  group_by(FAO_agg_items, FAO_ind_items) %>%
  summarise(group = FAO_GrpCd, ind = FAO_item_No) %>% 
  distinct() %>% #remove duplicates
  ungroup() %>%
  add_count(FAO_agg_items) -> matching_summary #add observations per group - still necessary?
  
# add share for each country
matching_summary %>% 
  full_join(FAO_DAQ_all, by = c("FAO_ind_items" = "Item")) %>% #join with DAQ-values for each country
  group_by(Area, FAO_agg_items) %>% 
  mutate(sum_per_group = sum(DAQ)) %>% #calculate sum of DAQ for each country, group
  mutate(share_per_group = ifelse(sum_per_group == 0,100, DAQ/sum_per_group*100)) %>% #calculate share of DAQ for each ind. item
  select(Area, FAO_agg_items, FAO_ind_items, DAQ, sum_per_group, share_per_group) ->share_per_group_country

#evtl. andere Variablen doch drin lassen... XXX



# 5 - Export File ---------------------------------------------------------

write.csv(share_per_group_country, "share_per_group_country.csv", row.names = FALSE)








# 99 - Further (evtl. remove later) ---------------------------------------





# 
# #######################
# # VI. FIND SHARES 
# #######################
# 
# #groups <- read.delim("chaudhary-2018-supp7-aggregates-kray.csv", header = TRUE, sep = ";")
# groups <- read.delim("matching_list_R.csv", header = TRUE, sep = ";")
# groups <- groups %>% select(Aggr..Group, FAO.aggregated.items..total.94., FAO.individual.food.items..total.427., FAO_item.No)
# colnames(groups) = c("Group_cd", "group_name", "Item", "fao_ind_id")
# 
# 
# #remove duplicates########################
# items <- data.frame("Item" = unique(groups$Item))
# 
# dup <- duplicated(groups$Item)
# duplicates <- seq(1:length(groups$Item))[dup] #position of duplicates
# #remove duplicate rows in group df
# 
# groups <- groups[-duplicates,] #remove corresponding rows
# #####################################
# 
# 
# 
# 
# 
# #groups$share <- rep(0, nrow(groups))
# #colnames(groups) <- c("Group_cd", "Group_name", "Item")
# 
# #bal_merge <- merge(bal_total, groups, by.x = "Item", by.y = "Item")
# bal_total <- FAO_DAQ_all
# bal_merge <- merge(bal_total, groups, by.x = "Item", by.y = "Item")
# 
# 
# bal_merge$net[bal_merge$net < 0] <- 0
# countries <- unique(balance$Area)
# groups$nitem <- 0
# groups$Group_cd[is.na(groups$Group_cd)] <- 999
# 
# 
# #delete tripple entry 127,128 -> not necessary anymore (removed beforehand)
# groups$id <- seq(1:length(groups$Group_cd))
# #groups <- (groups[-c(127,128, 133),])
# #groups <- subset(groups, !(id %in% c(127,128, 133)))
#            
# for(i in 1:nrow(groups)){
#   count <- nrow(filter(groups, Group_cd == i))
#   groups$nitem[groups$Group_cd == i] <- count
# }
# 
# groups %>% #nyfe count hinzufuegen ausser bei Group_cd == 999
#   group_by(group_name) %>%
#   mutate(nitem2=ifelse(Group_cd==999,1,n())) -> groups
# 
# 
# ################################################################################
# # CREATE GROUPS  - it works, but we have to consider that some values have been neglected (NAs in USDA-databas)
# # -> check later pointwise if the skipped items have a large influence...
# ################################################################################
# 
# 
# #@Matthias: here I used the horrible 3-fold for-loop...
# 
# #nyfe 3-facher loop ev. so loesen, muss noch ueberprueft werden, ob es ueberall stimmt
# library(tidyverse)
# bal_merge %>% 
#   group_by(Area,group_name) %>% 
#   mutate(share=net/sum(net)*100) %>%
#   arrange(Area,Item) -> test
# View(test)
# 
# library("xlsx")
# all_groups_tidy <- data.frame()
# for(i in 1:52){ #loop over groups, create a table for each group 
#   
#   if(i %in% groups$Group_cd){ #nyfe braucht es nicht
#     print(i)
#     interim_table <- data.frame(matrix(0, nrow = groups$nitem[groups$Group_cd == i], ncol= 175))
#     #print("hello")
#     colnames(interim_table) <- countries
#     rownames(interim_table) <- groups$Item[groups$Group_cd == i]
#     interim_table
#     
#     #nyfe statt ueber index loopen
#     for (country in countries) {
#       bal_merge %>% 
#         filter(Area == country, Group_cd==i) %>% 
#         select(net) %>%
#         mutate(share=net/sum(net, na.rm=TRUE)*100) %>% 
#         select(share) %>% pull(share) -> interim_table[,country]
#     }
#     
#     for (j in 1:175){ #loop over countries, fill the table colomn with share-values
#       print(j)
#       bal_merge_sel <- filter(bal_merge, Area == countries[j], Group_cd == i)
#       #print("hi")
#       bal_merge_sel$share <- bal_merge_sel$net/sum(bal_merge_sel$net, na.rm = TRUE)*100
#       #interim_table[,j] <- bal_merge_sel$share
#       print("ho")
#       for (x in 1: nrow(interim_table)) { 
#         if (length(bal_merge_sel$share[bal_merge_sel$Item == rownames(interim_table)[x]]) == 0){ 
#           print("he")
#           interim_table[x, countries[j]] <- 0 #nyfe wieso?
#           
#         }
#         else{
#           print("hh")
#           interim_table[x,countries[j]] = bal_merge_sel$share[bal_merge_sel$Item == rownames(interim_table)[x]]
#       
#         }
#       }
#       assign(paste0("group",i), interim_table)
#     }
#     
#     interim_table$item <- as.character(rownames(interim_table))
#     ord <- c(ncol(interim_table), seq(1:(ncol(interim_table)-1))) #nyfe Fehler?? Wieso seq
#     interim_table <- interim_table[, ord]
#     #try to export tables here (not yet tested)
#     filename <- paste0("group_", i)
#     filename <- paste0(filename, "_210311.csv")
#     
#     #write_xlsx(interim_table, filename) # this function does not work on one of my computers...
#     write.csv(interim_table, filename)
#     #append dataframes in list
#     interim_group_prep <- interim_table
#     #interim_group_prep$item <- rownames(interim_group_prep)
#     interim_group_prep$group <- i
#     interim_group_tidy <-  interim_group_prep %>% 
#       pivot_longer(countries, names_to = "country", values_to = "share")
#     all_groups_tidy <- rbind(all_groups_tidy, interim_group_tidy)
#     
#   }
# }




