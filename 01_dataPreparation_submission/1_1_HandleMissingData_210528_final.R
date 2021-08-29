# Missing Data Imputation
##########################################


# 0 - Preparations --------------------------------------------------------
source("1_load_210427.R")
library(mice)
library(missForest)
library(gridExtra)
library(ggplot2)


# 1 - Reduce dataset to nutrients of interest -----------------------------
#usda_final2_sr28 <- as_tibble(usda_final2_sr28)
#XXX maybe leave this for later...
usda_final2_sr28 %>%
  as_tibble() %>%
  mutate(Units = ifelse(Units == "µg", "ug", Units)) %>%
  mutate(Nutr_units = paste0("X", NutrDesc, " (", Units, ")")) %>%
  #mutate(NutrDesc = ifelse(NutrDesc == "Energy" & Units == "kcal", "Energy_kcal", NutrDesc)) %>% #change "Energy" to more specific names
  #mutate(NutrDesc = ifelse(NutrDesc == "Energy" & Units == "kJ", "Energy_kJ", NutrDesc)) %>%
  #select(NDB_No, Shrt_Desc, FdGrp_Desc, NutrDesc, Nutr_Val, Nutr_units) %>%
  select(NDB_No, Shrt_Desc, FdGrp_Desc, Nutr_units, Nutr_Val) %>%
  pivot_wider(names_from = Nutr_units, values_from = Nutr_Val) -> allNutrients

allNutrients %>%
  mutate(FdGrp_Desc = as.factor(FdGrp_Desc)) -> allNutrients


#XXXXXXXXXXXXXXX
usda_final2_sr28 %>%
  as_tibble() %>%
  mutate(Units = ifelse(Units == "µg", "ug", Units)) %>%
  mutate(NutrDesc = ifelse(Units == "kcal" & NutrDesc == "Energy", "Energy_kcal", NutrDesc)) %>%
  select(NDB_No, Shrt_Desc, FdGrp_Desc, NutrDesc, Nutr_Val) %>%
  pivot_wider(names_from = NutrDesc, values_from = Nutr_Val) %>%
  colnames()-> allNutrients_justNames #use this later for join

#XXXXXXXXXXXXXXXXX



#replace coloumn names (s.t. mice works later)
# colnames(selNutrients) -> names
colnames(allNutrients) -> names

names %>% 
  stringr::str_replace_all("\\s","") %>%
  stringr::str_replace_all("\\(", "") %>%
  stringr:: str_replace_all("\\)", "") %>%
  stringr:: str_replace_all("\\,", "") %>%
  stringr:: str_replace_all("\\:", "") %>%
  stringr:: str_replace_all("\\-", "") %>%
  stringr:: str_replace_all("\\+", "") -> colnames(allNutrients)
#replace last coloumn name (starts with number)
#colnames(selNutrients)[38] = "ALA"
colnames(allNutrients)




# 2 - General Analysis of Missing Values ----------------------------------

#md.pattern()
allNutrients %>%
  select(c(4:38)) %>%
  md.pattern() %>%
  view() 


#share of missing values per variable (
###################################################

#all Nutrients (all variables - too many)
allNutrients %>% 
  flux() %>%
  mutate(names = colnames(allNutrients)) %>%
  mutate(names = fct_reorder(names, desc(pobs))) %>%
  #arrange(pobs) %>%
  ggplot( aes( y = pobs, x = names)) +
  geom_point() + #prob of existing values
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 45))

#all Nutrients - 3 plots
allNutrients %>% 
  flux() %>%
  mutate(names = colnames(allNutrients)) %>%
  mutate(names = fct_reorder(names, desc(pobs))) %>% 
  filter(pobs >= 0.6) %>%
  #arrange(pobs) %>%
  ggplot( aes( y = pobs, x = names)) +
  geom_point() + #prob of existing values
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90)) +
  ylim(c(0,1)) ->pmissingValues_1


allNutrients %>% 
  flux() %>%
  mutate(names = colnames(allNutrients)) %>%
  mutate(names = fct_reorder(names, desc(pobs))) %>% 
  filter(pobs >= 0.3 & pobs <= 0.6) %>%
  #arrange(pobs) %>%
  ggplot( aes( y = pobs, x = names)) +
  geom_point() + #prob of existing values
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90)) +
  ylim(c(0,1)) ->pmissingValues_2


allNutrients %>% 
  flux() %>%
  mutate(names = colnames(allNutrients)) %>%
  mutate(names = fct_reorder(names, desc(pobs))) %>% 
  filter(pobs < 0.3 ) %>%
  #arrange(pobs) %>%
  ggplot( aes( y = pobs, x = names)) +
  geom_point() + #prob of existing values
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90)) +
  ylim(c(0,1)) ->pmissingValues_3 


ggsave("pmissingValues_1.pdf", plot = pmissingValues_1, width = 10, height = 6, units = "in")
ggsave("pmissingValues_2.pdf", plot = pmissingValues_2, width = 10, height = 6, units = "in")
ggsave("pmissingValues_3.pdf", plot = pmissingValues_3, width = 10, height = 6, units = "in")




# 3 - Different Imputation Methods ----------------------------------------

#Mean - for all
allNutrients %>%
  mice(method = "mean", m = 1, maxit = 1) %>%
  complete() ->  allNutrients_meanMice #does not work... (XLutein nicht gefunden ?!?)


#Mean Imputation (grouped by food category)
allNutrients %>%
  group_by(FdGrp_Desc) %>%
  mutate(
    across(
      4:152, ~if_else(is.na(.), mean(., na.rm = TRUE), as.numeric(.))
    )
  ) -> allNutrients_meanGrouped

   complete() -> selNutrients_Reg

allNutrients %>%
  mice(method = "norm.predict", seed = 1, m = 1, print = FALSE) %>%
  complete() -> allNutrients_Reg
#does not work -> System ist für den Rechner singulär


allNutrients %>%
  mice(method = "norm.nob", m = 1, maxit = 1,seed = 1, print = FALSE) %>%
  complete() -> allNutrients_stReg



allNutrients %>%
  mice(method = "pmm", m = 1, maxit = 1,seed = 1, print = FALSE) %>%
  complete() -> allNutrients_pmm



# 4 - Visualizations ------------------------------------------------------



#now as function
VisualizeImp_Violin_all <-function(VariableOfChoice)
{
  VariableOfChoice <- sym(VariableOfChoice)
  #find x-limit (certain percentile)
  allNutrients %>%
    mutate(treshold = !!VariableOfChoice / XEnergykcal) %>%
    select(treshold) %>%
    quantile(probs = seq(0, 1, by= 0.1), na.rm = TRUE) -> d
  x <- d[9]
  
  #find position ofselNutrients_Values_meanMiceNA NA in original df (coloumn):
  allNutrients %>%
    select(!!VariableOfChoice) %>%
    mutate(isna = ifelse(is.na(!!VariableOfChoice),"NA","existing")) %>%
    select(isna) %>%
    mutate(isna = as.factor(isna)) ->NAs
  
  #without Imputation
  allNutrients %>%
    cbind(NAs) %>% #add labels
    #cbind(selNutrients[,1:3]) %>% #add additional information
    ggplot(aes(y = !!VariableOfChoice / XEnergykcal, x = FdGrp_Desc) ) + #plot grouped histogramm
    #geom_boxplot() + 
    #geom_point(size = 0.1) +
    geom_jitter(aes(col = isna), size = 0.05, position=position_jitter(0.2)) +
    geom_violin(trim = FALSE)+
    theme_bw() +
    ylim(c(0,x)) +
    scale_colour_manual(values = c("black", "red")) +
    theme(axis.text.x = element_text(angle = 90)) +
    ggtitle("No Imputation") -> p1
  
  
  #Mean Imputation
  allNutrients_meanMice %>%
    cbind(NAs) %>% #add labels
    #cbind(selNutrients[,1:3]) %>% #add additional information
    ggplot(aes(y = !!VariableOfChoice / XEnergykcal, x = FdGrp_Desc) ) + #plot grouped histogramm
    #geom_boxplot() + 
    #geom_point(size = 0.1) +
    geom_jitter(aes(col = isna), size = 0.05, position=position_jitter(0.2)) +
    geom_violin(trim = FALSE)+
    theme_bw() +
    ylim(c(0,x)) +
    scale_colour_manual(values = c("black", "red")) +
    theme(axis.text.x = element_text(angle = 90)) +
    ggtitle("Mean Imputation (not grouped)") -> p2
  
  
  #Mean imputation (by group)
  allNutrients_meanGrouped %>%
    cbind(NAs)  %>% #add labels
    ggplot(aes(y = !!VariableOfChoice / XEnergykcal, x = FdGrp_Desc) ) + #plot grouped histogramm
    #geom_boxplot() + 
    #geom_point(size = 0.1) +
    geom_jitter(aes(col = isna), size = 0.05, position=position_jitter(0.2)) +
    geom_violin(trim = FALSE)+
    theme_bw() +
    ylim(c(0,x)) +
    scale_colour_manual(values = c("black", "red")) +
    theme(axis.text.x = element_text(angle = 90)) +
    ggtitle("Mean Imputation (by group)") -> p3
  
  # #Regression Imputation - errors
  # selNutrients_Reg %>%
  #   cbind(NAs)  %>% #add labels
  #   #cbind(selNutrients[,1:3]) %>%
  #   ggplot(aes(y = !!VariableOfChoice / XEnergykcal , x = FdGrp_Desc) ) + #plot grouped histogramm
  #   #geom_boxplot() + 
  #   #geom_point(size = 0.1) +
  #   geom_jitter(aes(col = isna), size = 0.05, position=position_jitter(0.2)) +
  #   geom_violin(trim = FALSE)+
  #   theme_bw() +
  #   ylim(c(0,x)) +
  #   scale_colour_manual(values = c("black", "red")) +
  #   theme(axis.text.x = element_text(angle = 90)) +
  #   ggtitle("Regression Imputation") -> p4
  # 
  # 
  #Regression (only based on group) Imputation
  allNutrients_regressionGroup %>%
    cbind(NAs)  %>% #add labels
    #cbind(selNutrients[,1:3]) %>%
    ggplot(aes(y = !!VariableOfChoice / XEnergykcal , x = FdGrp_Desc) ) + #plot grouped histogramm
    #geom_boxplot() + 
    #geom_point(size = 0.1) +
    geom_jitter(aes(col = isna), size = 0.05, position=position_jitter(0.2)) +
    geom_violin(trim = FALSE)+
    theme_bw() +
    ylim(c(0,x)) +
    scale_colour_manual(values = c("black", "red")) +
    theme(axis.text.x = element_text(angle = 90)) +
    ggtitle("Regression Imputation (based only on group)") -> p5
  
  allNutrients_stReg %>%
    cbind(NAs)  %>% #add labels
    #cbind(selNutrients[,1:3]) %>%
    ggplot(aes(y = !!VariableOfChoice / XEnergykcal , x = FdGrp_Desc) ) + #plot grouped histogramm
    #geom_boxplot() +
    #geom_point(size = 0.1) +
    geom_jitter(aes(col = isna), size = 0.05, position=position_jitter(0.2)) +
    geom_violin(trim = FALSE)+
    theme_bw() +
    ylim(c(0,x)) +
    scale_colour_manual(values = c("black", "red")) +
    theme(axis.text.x = element_text(angle = 90)) +
    ggtitle("Stochastic Regression") -> p6
  # 
  # 
  # allNutrients_pmm %>%
  #   cbind(NAs)  %>% #add labels
  #   #cbind(selNutrients[,1:3]) %>%
  #   ggplot(aes(y = !!VariableOfChoice / XEnergykcal , x = FdGrp_Desc) ) + #plot grouped histogramm
  #   #geom_boxplot() +
  #   #geom_point(size = 0.1) +
  #   geom_jitter(aes(col = isna), size = 0.05, position=position_jitter(0.2)) +
  #   geom_violin(trim = FALSE)+
  #   theme_bw() +
  #   ylim(c(0,x)) +
  #   scale_colour_manual(values = c("black", "red")) +
  #   theme(axis.text.x = element_text(angle = 90)) +
  #   ggtitle("PMM Regression") -> p7
  # 
  #arrange plots
  grid.arrange(p2,p3,  p6, nrow = 3) -> p
  g <- arrangeGrob(p2, p3, p6, nrow=3)
  ggsave(paste0("p", VariableOfChoice, "_Imp.pdf"),g, width = 12, height = 20, units = "in")
}


#here, three examples are printed. Further analysis can be done by typing "X-Name (without spaces and special characters)-unit"
VisualizeImp_Violin_all("XCalciumCamg") 
VisualizeImp_Violin_all("XZincZnmg") 
VisualizeImp_Violin_all("XSeleniumSeug") 






# 5 - Choice of Imputation ------------------------------------------------

# add correct names again 
colnames(allNutrients_meanGrouped) <- names

#back to long format
allNutrients_meanGrouped %>%
  pivot_longer(cols = 4:ncol(allNutrients_meanGrouped) ,names_to = "NutrDesc", values_to = "Nutr_Val") %>%
  mutate(NutrDesc = sub(".", "", NutrDesc)) -> allNutrients_final


colnames(allNutrients_meanGrouped) <- allNutrients_justNames #test here with "old" names
allNutrients_meanGrouped %>%
  pivot_longer(cols = 4:ncol(allNutrients_meanGrouped) ,names_to = "NutrDesc", values_to = "Nutr_Val") -> test
#  mutate(NutrDesc = sub(".", "", NutrDesc)) -> allNutrients_final

#change entry to avoid ambiguity
usda_final2_sr28 %>%
  mutate(NutrDesc = ifelse(NutrDesc == "Energy" & Units == "kcal", "Energy_kcal", NutrDesc)) -> usda_altered

test %>% #join with long descriptions
  left_join(usda_altered, by = c("NutrDesc" = "NutrDesc", "NDB_No" = "NDB_No")) %>%
  select(NDB_No, Shrt_Desc.x, FdGrp_Desc.x, FdGrp_Cd, NutrDesc, Nutr_Val.x, Long_desc) %>%
  rename(Shrt_Desc = Shrt_Desc.x, FdGrp_Desc = FdGrp_Desc.x, Nutr_Val = Nutr_Val.x) -> semi_final


nutr_def_sr28 %>%
  mutate(NutrDesc = ifelse(NutrDesc == "Energy" & Units == "kcal", "Energy_kcal", NutrDesc)) -> nutr

semi_final %>%
  left_join(nutr[,c(1,2,4)], by = "NutrDesc") %>%
  mutate(NutrDesc = ifelse(NutrDesc == "Energy_kcal", "Energy", NutrDesc ))  %>%
 # select(NDB_No, Shrt_Desc, Long_desc, FdGrp_Desc, FdGrp_Cd, NutrDesc, Nutr_No, Units, Nutr_Val) %>%
  left_join(food_des_sr28[,c(1,2,3)], by = "NDB_No") %>%
  select(NDB_No, Shrt_Desc, Long_desc.y, FdGrp_Cd.y, FdGrp_Desc,  Nutr_No, NutrDesc, Units, Nutr_Val) %>%
  rename(Long_desc = Long_desc.y, FdGrp_Cd = FdGrp_Cd.y) -> usda_final2_sr28_imp  #final imputed set


#export
write.csv(usda_final2_sr28_imp, "usda_final2_sr28_imp.csv", row.names = FALSE)





