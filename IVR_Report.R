#Step 1
setwd("C:/Users/T.M.K/Downloads/IVR/2802/WB-IVR-REPORT-28-02-2021/WB-IVR-REPORT-28-02-2021/WB-IVR-REPORT-28-02-2021")

filenames <- list.files(full.names=TRUE)

All <- lapply(filenames,function(i){
  read.csv(i, header=TRUE, skip=0)
})

df <- do.call(rbind.data.frame, All)
length(unique(df$MobileNo))

write.csv(df,"Merged.csv", row.names=TRUE)

#Step 2
df$Upper_CampaignName<-toupper(substr(df$CampaignName,1,8))
unique(df$Upper_CampaignName)

#Step 3
library(tidyverse)
library(dplyr)

dialled<-as.data.frame(table(df$Upper_CampaignName))
View(dialled)

answered_V1<-as.data.frame(table(df$Upper_CampaignName,df$Callstatus==" Answer"))
answered_V2<-answered_V1[answered_V1$Var2=="TRUE",]
answered_V3<-answered_V2[,c("Var1","Freq")]
View(answered_V3)

#Step 4 - Calculations
library(tibble)
library(readr)
#Upper_CampaignName==" WB-1145" ~ " "
#Upper_CampaignName==" WB-1146" ~ "47"
#Upper_CampaignName==" WB-1147" ~ "38"
#Upper_CampaignName==" WB-1148" ~ "32"
#Upper_CampaignName==" WB-1149" ~ "32"
#Upper_CampaignName==" WB-1150" ~ "32"
#Upper_CampaignName==" WB-1134" ~ " "
#Upper_CampaignName==" WB-1135" ~ " "
#Upper_CampaignName==" WB-1136" ~ " "
#Upper_CampaignName==" WB-1137" ~ " "
#Upper_CampaignName==" WB-1138" ~ " "
#Upper_CampaignName==" WB-1139" ~ " "
#Upper_CampaignName==" WB-1140" ~ " "
#Upper_CampaignName==" WB-1141" ~ " "
#Upper_CampaignName==" WB-1142" ~ " "
#Upper_CampaignName==" WB-1124" ~ "Variable"

table$size1<-ifelse(table$population<500,1,
                    ifelse(table$population>=500 & table$population<1000,2,
                           ifelse(table$population>=1000 & table$population<2000,3,
                                  ifelse(table$population>=2000 & table$population<3000,4,5
                                  ))))
df$totalduration<-ifelse(df$Upper_CampaignName==" WB-1146",47,
                         ifelse(df$Upper_CampaignName==" WB-1147",38,
                                ifelse(df$Upper_CampaignName==" WB-1149",32,
                                       ifelse(df$Upper_CampaignName==" WB-1150",32,0))))

df$heard50<-ifelse(df$Duration>=0.5*df$totalduration,"Yes","No")
df$heard75<-ifelse(df$Duration>=0.75*df$totalduration,"Yes","No")

heard50_V1<-as.data.frame(table(df$Upper_CampaignName,df$Callstatus==" Answer",df$heard50=="Yes"))
heard50_V2<-heard50_V1[(heard50_V1$Var2==TRUE),]
heard50_V3<-heard50_V2[heard50_V2$Var3==TRUE,]
heard50_V4<-heard50_V3[,c("Var1","Freq")]
View(heard50_V4)

heard75_V1<-as.data.frame(table(df$Upper_CampaignName,df$Callstatus==" Answer",df$heard75=="Yes"))
heard75_V2<-heard75_V1[(heard75_V1$Var2==TRUE),]
heard75_V3<-heard75_V2[heard75_V2$Var3==TRUE,]
heard75_V4<-heard75_V3[,c("Var1","Freq")]
View(heard75_V4)

finaldf_V1<-merge(x=dialled,y=answered_V3,by="Var1")
#View(finaldf_V1)
colnames(finaldf_V1)[2]<-"dialled"
colnames(finaldf_V1)[3]<-"answered"
#View(finaldf_V1)

finaldf_V2<-merge(x=finaldf_V1,y=heard50_V4,by="Var1")
#View(finaldf_V2)
finaldf_V3<-merge(x=finaldf_V2,y=heard75_V4,by="Var1")
#View(finaldf_V3)
colnames(finaldf_V3)[4]<-"heard_50"
colnames(finaldf_V3)[5]<-"heard_75"
View(finaldf_V3)

#library(scales)
finaldf_V3$Pickup<- format(((finaldf_V3$answered/finaldf_V3$dialled)*100),digits = 4)
finaldf_V3$percent_heard_50<-format(((finaldf_V3$heard_50/finaldf_V3$answered)*100),digits = 4)
finaldf_V3$percent_heard_75<-format(((finaldf_V3$heard_75/finaldf_V3$answered)*100),digits = 4)

#Step 5 - Put output in word format 
