# Load USDA SR28 - nutrient profiles 
#################################

# 10.02.2021 / P. Krayer


# 0 - Preparation -------------------------------------------------------------

# 0a - set working directory (e.g. to source file location)

library(tidyverse)


# 1 - Import data ---------------------------------------------------------


# 1a - import 12 tables containing the data of the latest USDA standard reference (2018)
#######################################################################

data_src_sr28 <- read.delim("data_src.txt", sep = "^",na.strings = "", 
                            quote = "~", header = FALSE, stringsAsFactors = FALSE )

datasrcln_sr28 <- read.delim("datsrcln.txt", sep = "^",na.strings = "", 
                            quote = "~", header = FALSE, stringsAsFactors = FALSE )

deriv_cd_sr28 <- read.delim("deriv_cd.txt", sep = "^",na.strings = "", 
                             quote = "~", header = FALSE, stringsAsFactors = FALSE )


fd_group_sr28 <- read.delim("fd_group.txt", sep = "^",na.strings = "", 
                            quote = "~", header = FALSE, stringsAsFactors = FALSE )

food_des_sr28 <- read.delim("food_des.txt", sep = "^",na.strings = "", 
                            quote = "~", header = FALSE, stringsAsFactors = FALSE )

footnote_sr28 <- read.delim("footnote.txt", sep = "^",na.strings = "", 
                            quote = "~", header = FALSE, stringsAsFactors = FALSE )

langdesc_sr28 <- read.delim("langdesc.txt", sep = "^",na.strings = "", 
                       quote = "~", header = FALSE, stringsAsFactors = FALSE )

langual_sr28 <- read.delim("langual.txt", sep = "^",na.strings = "", 
                            quote = "~", header = FALSE, stringsAsFactors = FALSE )

nut_data_sr28 <- read.delim("nut_data.txt", sep = "^",na.strings = "", 
                           quote = "~", header = FALSE, stringsAsFactors = FALSE )

nutr_def_sr28 <- read.delim("nutr_def.txt", sep = "^",na.strings = "", 
                            quote = "~", header = FALSE, stringsAsFactors = FALSE )

src_cd_sr28 <- read.delim("src_cd.txt", sep = "^",na.strings = "", 
                            quote = "~", header = FALSE, stringsAsFactors = FALSE )

weight_sr28 <- read.delim("weight.txt", sep = "^",na.strings = "", 
                            quote = "~", header = FALSE, stringsAsFactors = FALSE )

# 1b - Add headers according to documentation of database sr28
#######################################################################
colnames(food_des_sr28) = c("NDB_No", "FdGrp_Cd", "Long_desc", "Shrt_Desc", "ComName", "ManufacName", "Survey", "Ref_desc", "Refuse", "SciName","N_Factor", "Pro_Factor","Fat_Factor","CHO_Factor")
colnames(fd_group_sr28) = c("FdGrp_Cd", "FdGrp_Desc")
colnames(langual_sr28) = c("NDB_No", "Factor_Code")
colnames(langdesc_sr28) = c("Factor_Code", "Description")
colnames(nut_data_sr28) = c("NDB_No", "Nutr_No", "Nutr_Val", "Num_Data_Pts", "Std_Error", "Src_Cd", "Deriv_Cd", "Ref_NDB_No", "Add_Nutr_Mark", "Num_Studies", "Min", "Max", "DF", "Low_EB", "Up_EB", "Stat_cmt", "AddMod_Date","CC")
colnames(nutr_def_sr28) = c("Nutr_No", "Units", "Tagname", "NutrDesc", "Num_Dec","SR_Order")
colnames(src_cd_sr28) = c("Src_Cd", "SrcCd_Desc")
colnames(deriv_cd_sr28) = c("Deriv_Cd", "Deriv_Desc")
colnames(weight_sr28) = c("NDB_No", "Seq", "Amount", "Msre_Desc", "Gm_Wgt", "Num_Data_Pts", "Std_Dev")
colnames(footnote_sr28) = c("NDB_No", "Footnt_No", "Footnt_Typ", "Nutr_No", "Footnt_Txt")
colnames(datasrcln_sr28) = c("NDB_No", "Nutr_No", "DataSrc_ID")
colnames(data_src_sr28) = c("DataSrc_ID", "Authors", "Title", "Year", "Journal", "Vol_City", "Issue_State", "Start_Page", "End_Page")


# 1c - Merge to table with variables of interest 
#######################################################################

nut_data_sr28 %>% 
  left_join(nutr_def_sr28, by = "Nutr_No") %>% #add table with nutrient names to table with nutrient values
  left_join(food_des_sr28, by = "NDB_No")%>% #add table with food item names to table
  left_join(fd_group_sr28, by = "FdGrp_Cd") %>% #add table with food groups to table
  select(NDB_No, Shrt_Desc, Long_desc, FdGrp_Cd, FdGrp_Desc, Nutr_No, NutrDesc, Units, Nutr_Val, Min, Max) -> usda_final2_sr28 # select relevant variables and store



# 2 - export file (in case needed elsewhere) ------------------------------

write.csv(usda_final2_sr28, "usda_final2_sr28.csv", row.names = FALSE)



# 3 - include values of Full DB  ------------------------------
#3.1. import tables
nutrient <- read.delim("nutrient.csv", header = TRUE, sep = ",")
cat_wweia <- read.delim("wweia_food_category.csv", header = TRUE, sep = ",")
food <- read.delim("food.csv", header = TRUE, sep = ",")
food_nutrient <- read.delim("food_nutrient.csv", header = TRUE, sep = ",")

#3.2. join to FullDBtable
food_nutrient %>%
  left_join(food, by = "fdc_id") %>% #join nutrient values with names of food items
  left_join(nutrient, by = c("nutrient_id" = "id"))%>% #join with nutrient names
  left_join(cat_wweia, by = c("food_category_id" = "wweia_food_category")) -> usda_fullDB2



# 99 - Further ------------------------------------------------------------

# The code below is actually not necessary -> remove later XXX
###########################################################################################################

# reduce to relevant food groups: neglect 300 (baby food), 600 (soups), 
# 800 (breakfast cereals), 1800 (baked products), 1900 (sweets), 2100 (fast food), 2200 (meals, entrees)
# 2500 (snacks), 3500 (american indian/alaskan native food), 3600 (restaurant foods)
#######################################################################
# test <- usda_final_sr28[usda_final_sr28$df3.FdGrp_Cd == 3500,]
# 
# not_sel <- c(300, 600, 800, 1800, 1900, 2100, 2200, 2500, 3600)
# 
# usda_sr28_sel <- usda_final_sr28[!(usda_final_sr28$df3.FdGrp_Cd %in% not_sel),]
# food_sr28_sel <- food_des_sr28[!(food_des_sr28$FdGrp_Cd %in% not_sel),]
# 
# 
# library("writexl")
# write_xlsx(food_sr28_sel,"food_sr28_sel.xlsx")

