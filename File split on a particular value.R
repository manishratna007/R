library(openxlsx)
library(readxl)
library(readr)
library(tidyverse)


#1. Read excel
setwd("C:/Users/manis/Documents")
df1<-read.xlsx("Branding Hotspots_fn.xlsx")

#2. Add a column based on concatenated values
df1$Dist_AC<-paste(df1$District,"_",df1$AC.Name)
df1$Dist_AC_Final<-substr(df1$Dist_AC,1,31)
#head(df1)
#3. Add a list with multiple data elements
output <- split(df1, df1$Dist_AC_Final)

#4. Add a workbook
wb <- createWorkbook()

#5. Add data from split list into workbook with names of columns as worksheet names 
for (i in 1:length(output)) 
  {
  addWorksheet(wb, sheetName=as.character(names(output[i])))
  writeData(wb, sheet=names(output[i]), x=output[[i]]) # Note [[]]
  }

#6. Saved Final Excel File
saveWorkbook(wb, "Ashish.xlsx", overwrite = TRUE)

#7. Read sheets and use for filenames
sheets <- excel_sheets("Ashish.xlsx")
filenames <- paste0(sheets, ".csv")

#8. read_excel only reads a single sheet, so lapply over each sheet name
dats <- lapply(sheets, read_excel, path = "Ashish.xlsx")

#9. Set Working directory to new Folder
setwd("C:/Users/manis/Documents/Ashish")

#10. Save each data frame with different filename using write_csv
lapply(seq_along(dats), function(i) write.csv(dats[[i]], filenames[i]))
  