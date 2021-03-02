#1. Set working directory to folder containing all csv
setwd("C:/Users/manis/Documents/Ashish")
#2. Prepare  a list of all files to be read
filenames <- list.files(full.names=TRUE)
#3. Read all files into a large list with all tables
All <- lapply(filenames,function(i){
  read.csv(i, header=TRUE, skip=0)
})
#4. Merge all tables into one dataframe
df <- do.call(rbind.data.frame, All)
head(df)

#5. Save final csv into a final one
write.csv(df,"all_postcodes.csv", row.names=FALSE)
