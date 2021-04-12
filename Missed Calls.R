#library(xlsx)
library(tidyverse)
library(stringr)
df1<-as.data.frame(read.csv("C:/Users/manis/Downloads/ALL_636(32).csv"))
df1$datecolumn<-as.Date(df1$Date)
str(df1)
head(df1)
df2<-df1[df1$datecolumn>="2021-03-30",]
#df2$Mobile.Number<-as.numeric(df2$Mobile.Number)
#df3<-df2[!duplicated(df2$Mobile.Number),]
#df4<-df3[unique(df3$Mobile.Number),]
write.csv(df2,"C:/Users/manis/Downloads/All_636_31.csv")

#Today's Data
df4<-df2[df2$datecolumn=="2021-04-12",]
df4$hour<-str_sub(df4$Date,-8,-7)
head(df4)
df_notunique<-data.frame(table(df4$hour))
View(df_notunique)

#Today's Unique Data
df3<-df2[!duplicated(df2$Mobile.Number),]
head(df3)
df3$hour<-str_sub(df3$Date,-8,-7)
dftoday<-df3[df3$datecolumn=="2021-04-12",]
df_today<-data.frame(table(dftoday$hour))
View(df_today)
#unique(dftoday$hour)

#Yesterday's data
dfyest<-df3[df3$datecolumn=="2021-04-11",]
df_yest<-data.frame(table(dfyest$hour))
View(df_yest)

df_final1<-merge(x = df_yest, y = df_today, by = "Var1", all = TRUE)
df_final2<-merge(x=df_final1, y = df_notunique,by = "Var1", all = TRUE)
write.csv(df_final2,"C:/Users/manis/Downloads/final_1204_2000.csv")
