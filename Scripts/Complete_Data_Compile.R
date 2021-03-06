library(data.table)
library(magrittr)
library(dplyr)
library(bit64)
library(gamlr)

census.data <- read.csv("data/GRADUATION_WITH_CENSUS.csv", header = TRUE) %>%
  .[,-1] %>%
  .[-which(is.na(.[,which(colnames(.) == "ALL_RATE_1112")])),] %>%
  as.data.frame()

#dims: 9785 x 579

#Only use columns chosen with our scientific research#
census.data1 <- dplyr::select(census.data, leaid11,ALL_COHORT_1112,ALL_RATE_1112,MAM_COHORT_1112,MAS_COHORT_1112,MBL_COHORT_1112,MHI_COHORT_1112,MTR_COHORT_1112,MWH_COHORT_1112,CWD_COHORT_1112,ECD_COHORT_1112,LEP_COHORT_1112,State,County,Num_BGs_in_Tract,LAND_AREA,AIAN_LAND,URBANIZED_AREA_POP_CEN_2010,URBAN_CLUSTER_POP_CEN_2010,RURAL_POP_CEN_2010,Tot_Population_CEN_2010,Tot_Population_ACS_08_12,Males_CEN_2010,Males_ACS_08_12,Females_CEN_2010,Females_ACS_08_12,Pop_under_5_CEN_2010,Pop_under_5_ACS_08_12,Pop_5_17_CEN_2010,Pop_5_17_ACS_08_12,Pop_18_24_CEN_2010,Pop_18_24_ACS_08_12,Pop_25_44_CEN_2010,Pop_25_44_ACS_08_12,Pop_45_64_CEN_2010,Pop_45_64_ACS_08_12,Pop_65plus_CEN_2010,Pop_65plus_ACS_08_12,Tot_GQ_CEN_2010,Inst_GQ_CEN_2010,Non_Inst_GQ_CEN_2010,Hispanic_CEN_2010,Hispanic_ACS_08_12,NH_White_alone_CEN_2010,NH_White_alone_ACS_08_12,NH_Blk_alone_CEN_2010,NH_Blk_alone_ACS_08_12,NH_AIAN_alone_CEN_2010,NH_AIAN_alone_ACS_08_12,NH_Asian_alone_CEN_2010,NH_Asian_alone_ACS_08_12,NH_NHOPI_alone_CEN_2010,NH_NHOPI_alone_ACS_08_12,NH_SOR_alone_CEN_2010,NH_SOR_alone_ACS_08_12,Pop_5yrs_Over_ACS_08_12,Othr_Lang_ACS_08_12,Age5p_Only_English_ACS_08_12,Age5p_Spanish_ACS_08_12,Age5p_French_ACS_08_12,Age5p_FrCreole_ACS_08_12,Age5p_Italian_ACS_08_12,Age5p_Portuguese_ACS_08_12,Age5p_German_ACS_08_12,Age5p_Yiddish_ACS_08_12,Age5p_WGerman_ACS_08_12,Age5p_Scandinavian_ACS_08_12,Age5p_Greek_ACS_08_12,Age5p_Russian_ACS_08_12,Age5p_Polish_ACS_08_12,Age5p_SRBCroatian_ACS_08_12,Age5p_OthSlavic_ACS_08_12,Age5p_Armenian_ACS_08_12,Age5p_Persian_ACS_08_12,Age5p_Gujarati_ACS_08_12,Age5p_Hindi_ACS_08_12,Age5p_Urdu_ACS_08_12,Age5p_OthIndic_ACS_08_12,Age5p_OthEuro_ACS_08_12,Age5p_Chinese_ACS_08_12,Age5p_Japanese_ACS_08_12,Age5p_Korean_ACS_08_12,Age5p_Cambodian_ACS_08_12,Age5p_Hmong_ACS_08_12,Age5p_Thai_ACS_08_12,Age5p_Laotian_ACS_08_12,Age5p_Vietnamese_ACS_08_12,Age5p_OthAsian_ACS_08_12,Age5p_Tagalog_ACS_08_12,Age5p_OthPacIsl_ACS_08_12,Age5p_Navajo_ACS_08_12,Age5p_NativeNAm_ACS_08_12,Age5p_Hungarian_ACS_08_12,Age5p_Arabic_ACS_08_12,Age5p_Hebrew_ACS_08_12,Age5p_African_ACS_08_12,Age5p_OthUnSp_ACS_08_12,Pop_25yrs_Over_ACS_08_12,Not_HS_Grad_ACS_08_12,College_ACS_08_12,Pov_Univ_ACS_08_12,Prs_Blw_Pov_Lev_ACS_08_12,Civ_labor_16plus_ACS_08_12,Civ_emp_16plus_ACS_08_12,Civ_unemp_16plus_ACS_08_12,Civ_labor_16_24_ACS_08_12,Civ_emp_16_24_ACS_08_12,Civ_unemp_16_24_ACS_08_12,Civ_labor_25_44_ACS_08_12,Civ_emp_25_44_ACS_08_12,Civ_unemp_25_44_ACS_08_12,Civ_labor_45_64_ACS_08_12,Civ_emp_45_64_ACS_08_12,Civ_unemp_45_64_ACS_08_12,Civ_labor_65plus_ACS_08_12,Civ_emp_65plus_ACS_08_12,Civ_unemp_65plus_ACS_08_12,Pop_1yr_Over_ACS_08_12,Diff_HU_1yr_Ago_ACS_08_12,Born_US_ACS_08_12,Born_foreign_ACS_08_12,US_Cit_Nat_ACS_08_12,NON_US_Cit_ACS_08_12,ENG_VW_SPAN_ACS_08_12,ENG_VW_INDO_EURO_ACS_08_12,ENG_VW_API_ACS_08_12,ENG_VW_OTHER_ACS_08_12,ENG_VW_ACS_08_12,Rel_Family_HHDS_CEN_2010,Rel_Family_HHD_ACS_08_12,MrdCple_Fmly_HHD_CEN_2010,MrdCple_Fmly_HHD_ACS_08_12,Not_MrdCple_HHD_CEN_2010,Not_MrdCple_HHD_ACS_08_12,Female_No_HB_CEN_2010,Female_No_HB_ACS_08_12,NonFamily_HHD_CEN_2010,NonFamily_HHD_ACS_08_12,Sngl_Prns_HHD_CEN_2010,Sngl_Prns_HHD_ACS_08_12,HHD_PPL_Und_18_CEN_2010,HHD_PPL_Und_18_ACS_08_12,Tot_Prns_in_HHD_CEN_2010,Tot_Prns_in_HHD_ACS_08_12,Rel_Child_Under_6_CEN_2010,Rel_Child_Under_6_ACS_08_12,HHD_Moved_in_ACS_08_12,PUB_ASST_INC_ACS_08_12,Med_HHD_Inc_ACS_08_12,Aggregate_HH_INC_ACS_08_12,Tot_Housing_Units_CEN_2010,Tot_Housing_Units_ACS_08_12,Tot_Occp_Units_CEN_2010,Tot_Occp_Units_ACS_08_12,Tot_Vacant_Units_CEN_2010,Tot_Vacant_Units_ACS_08_12,Renter_Occp_HU_CEN_2010,Renter_Occp_HU_ACS_08_12,Owner_Occp_HU_CEN_2010,Owner_Occp_HU_ACS_08_12,Single_Unit_ACS_08_12,MLT_U2_9_STRC_ACS_08_12,MLT_U10p_ACS_08_12,Mobile_Homes_ACS_08_12,Crowd_Occp_U_ACS_08_12,Occp_U_NO_PH_SRVC_ACS_08_12,No_Plumb_ACS_08_12,Med_House_value_ACS_08_12,Aggr_House_Value_ACS_08_12,MailBack_Area_Count_CEN_2010,TEA_Mail_Out_Mail_Back_CEN_2010,TEA_Update_Leave_CEN_2010,Census_Mail_Returns_CEN_2010,Vacants_CEN_2010,Deletes_CEN_2010,Census_UAA_CEN_2010,Valid_Mailback_Count_CEN_2010,FRST_FRMS_CEN_2010,RPLCMNT_FRMS_CEN_2010)
census.data2 <- dplyr::select(census.data, BILQ_Mailout_count_CEN_2010,BILQ_Frms_CEN_2010,Mail_Return_Rate_CEN_2010,Low_Response_Score,pct_URBANIZED_AREA_POP_CEN_2010,pct_URBAN_CLUSTER_POP_CEN_2010,pct_RURAL_POP_CEN_2010,pct_Males_CEN_2010,pct_Males_ACS_08_12,pct_Females_CEN_2010,pct_Females_ACS_08_12,pct_Pop_Under_5_CEN_2010,pct_Pop_Under_5_ACS_08_12,pct_Pop_5_17_CEN_2010,pct_Pop_5_17_ACS_08_12,pct_Pop_18_24_CEN_2010,pct_Pop_18_24_ACS_08_12,pct_Pop_25_44_CEN_2010,pct_Pop_25_44_ACS_08_12,pct_Pop_45_64_CEN_2010,pct_Pop_45_64_ACS_08_12,pct_Pop_65plus_CEN_2010,pct_Pop_65plus_ACS_08_12,pct_Tot_GQ_CEN_2010,pct_Inst_GQ_CEN_2010,pct_Non_Inst_GQ_CEN_2010,pct_Hispanic_CEN_2010,pct_Hispanic_ACS_08_12,pct_NH_White_alone_CEN_2010,pct_NH_White_alone_ACS_08_12,pct_NH_Blk_alone_CEN_2010,pct_NH_Blk_alone_ACS_08_12,pct_NH_AIAN_alone_CEN_2010,pct_NH_AIAN_alone_ACS_08_12,pct_NH_Asian_alone_CEN_2010,pct_NH_Asian_alone_ACS_08_12,pct_NH_NHOPI_alone_CEN_2010,pct_NH_NHOPI_alone_ACS_08_12,pct_NH_SOR_alone_CEN_2010,pct_NH_SOR_alone_ACS_08_12,pct_Pop_5yrs_Over_ACS_08_12,pct_Othr_Lang_ACS_08_12,pct_Age5p_Only_Eng_ACS_08_12,pct_Age5p_Spanish_ACS_08_12,pct_Age5p_French_ACS_08_12,pct_Age5p_FrCreole_ACS_08_12,pct_Age5p_Italian_ACS_08_12,pct_Age5p_Portugues_ACS_08_12,pct_Age5p_German_ACS_08_12,pct_Age5p_Yiddish_ACS_08_12,pct_Age5p_WGerman_ACS_08_12,pct_Age5p_Scandinav_ACS_08_12,pct_Age5p_Greek_ACS_08_12,pct_Age5p_Russian_ACS_08_12,pct_Age5p_Polish_ACS_08_12,pct_Age5p_SRBCroati_ACS_08_12,pct_Age5p_SRBCroati_ACSMOE_08_12,pct_Age5p_OthSlavic_ACS_08_12,pct_Age5p_Armenian_ACS_08_12,pct_Age5p_Persian_ACS_08_12,pct_Age5p_Gujarati_ACS_08_12,pct_Age5p_Hindi_ACS_08_12,pct_Age5p_Urdu_ACS_08_12,pct_Age5p_OthIndic_ACS_08_12,pct_Age5p_OthEuro_ACS_08_12,pct_Age5p_Chinese_ACS_08_12,pct_Age5p_Japanese_ACS_08_12,pct_Age5p_Korean_ACS_08_12,pct_Age5p_Cambodian_ACS_08_12,pct_Age5p_Hmong_ACS_08_12,pct_Age5p_Thai_ACS_08_12,pct_Age5p_Thai_ACSMOE_08_12,pct_Age5p_Laotian_ACS_08_12,pct_Age5p_Vietnames_ACS_08_12,pct_Age5p_OthAsian_ACS_08_12,pct_Age5p_Tagalog_ACS_08_12,pct_Age5p_OthPacIsl_ACS_08_12,pct_Age5p_Navajo_ACS_08_12,pct_Age5p_NativeNAm_ACS_08_12,pct_Age5p_Hungarian_ACS_08_12,pct_Age5p_Arabic_ACS_08_12,pct_Age5p_Hebrew_ACS_08_12,pct_Age5p_African_ACS_08_12,pct_Age5p_OthUnSp_ACS_08_12,pct_Pop_25yrs_Over_ACS_08_12,pct_Not_HS_Grad_ACS_08_12,pct_College_ACS_08_12,pct_Pov_Univ_ACS_08_12,pct_Prs_Blw_Pov_Lev_ACS_08_12,pct_Civ_emp_16p_ACS_08_12,pct_Civ_unemp_16p_ACS_08_12,pct_Civ_emp_16_24_ACS_08_12,pct_Civ_unemp_16_24_ACS_08_12,pct_Civ_emp_25_44_ACS_08_12,pct_Civ_unemp_25_44_ACS_08_12,pct_Civ_emp_45_64_ACS_08_12,pct_Civ_unemp_45_64_ACS_08_12,pct_Civ_emp_65p_ACS_08_12,pct_Civ_unemp_65p_ACS_08_12,pct_Pop_1yr_Over_ACS_08_12,pct_Diff_HU_1yr_Ago_ACS_08_12,pct_Born_US_ACS_08_12,pct_Born_foreign_ACS_08_12,pct_US_Cit_Nat_ACS_08_12,pct_NON_US_Cit_ACS_08_12,pct_ENG_VW_SPAN_ACS_08_12,pct_ENG_VW_INDOEURO_ACS_08_12,pct_ENG_VW_API_ACS_08_12,pct_ENG_VW_OTHER_ACS_08_12,pct_ENG_VW_ACS_08_12,pct_Rel_Family_HHDS_CEN_2010,pct_Rel_Family_HHD_ACS_08_12,pct_MrdCple_HHD_CEN_2010,pct_MrdCple_HHD_ACS_08_12,pct_Not_MrdCple_HHD_CEN_2010,pct_Not_MrdCple_HHD_ACS_08_12,pct_Female_No_HB_CEN_2010,pct_Female_No_HB_ACS_08_12,pct_NonFamily_HHD_CEN_2010,pct_NonFamily_HHD_ACS_08_12,pct_Sngl_Prns_HHD_CEN_2010,pct_Sngl_Prns_HHD_ACS_08_12,pct_HHD_PPL_Und_18_CEN_2010,pct_HHD_PPL_Und_18_ACS_08_12,avg_Tot_Prns_in_HHD_CEN_2010,avg_Tot_Prns_in_HHD_ACS_08_12,pct_Rel_Under_6_CEN_2010,pct_Rel_Under_6_ACS_08_12,pct_HHD_Moved_in_ACS_08_12,pct_PUB_ASST_INC_ACS_08_12,pct_Tot_Occp_Units_CEN_2010,pct_Tot_Occp_Units_ACS_08_12,pct_Vacant_Units_CEN_2010,pct_Vacant_Units_ACS_08_12,pct_Renter_Occp_HU_CEN_2010,pct_Renter_Occp_HU_ACS_08_12,pct_Owner_Occp_HU_CEN_2010,pct_Owner_Occp_HU_ACS_08_12,pct_Single_Unit_ACS_08_12,pct_MLT_U2_9_STRC_ACS_08_12,pct_MLT_U10p_ACS_08_12,pct_Mobile_Homes_ACS_08_12,pct_Crowd_Occp_U_ACS_08_12,pct_NO_PH_SRVC_ACS_08_12,pct_No_Plumb_ACS_08_12, pct_Recent_Built_HU_ACS_08_12)

census.data <- cbind(census.data1, census.data2)

#Drop columns 4-9, as we have imputed them
census.data  = census.data[, -c(4:9)] 

#Run the VIM packages to determine NA values in the dataset#
library(VIM)
miss = aggr(census.data)
#dataframe below hold each column and number of 'NA" values in each column
na_col = miss$missings
rownames(na_col) = NULL
#unique values in na_col dataframe
unique(na_col$Count)

#Determine the features which have more than 1000 missing values
na_col[which(na_col$Count > 1000),]

#I propose dropping LEP_COHORT_1112 as similar information seems to be captured by census#
census.data = census.data[, -6]

#Determine the features which have between 100-1000 missing values
na_col[which(na_col$Count < 1000 & na_col$Count > 100 ),]

#I propose setting all the remains NA's to 0
for(i in 1:dim(census.data)[2]){
  for(j in 1:dim(census.data)[1]){
    if(is.na(census.data[j,i])){
      census.data[j,i] = 0
    }
  }
}

setwd("/home/grad/srs65/521-final-project/Complete_Data_wdiver_Nov19")

var.names <- c("MAM_COHORT_1112",
               "MAS_COHORT_1112", 
               "MBL_COHORT_1112",
               "MHI_COHORT_1112", 
               "MTR_COHORT_1112",
               "MWH_COHORT_1112")

for(i in 1:50){
  temp = read.table(paste("/home/grad/srs65/521-final-project/Mice_Data_Nov18/micedata",i,sep=""))
  dataset = cbind(census.data[,1:3], temp[,1:6], census.data[, 4:ncol(census.data)])
  
  cohort.total <- apply(dataset[,var.names], 1, sum, na.rm = TRUE)
  df <- dataset[,var.names]
  df <- df/cohort.total
  df <- 1-df
  diver <- apply(df, 1, prod)
  dataset<- cbind(dataset, diver)
  
  write.table(dataset, file = paste("dataset",i,sep=""))
}
