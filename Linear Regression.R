library(readxl)
df1<-read_excel("C:/Users/T.M.K/Desktop/R and Python Codes/Height_Dummy.xlsx","Sheet1")
#Regression formula
lmHeight=lm(df1$Height~df1$Weight+df1$Gender+df1$Age,data = df1)
#Summary Output
summary(lmHeight)
#Plotting the Regression line
plot(df1$Height~df1$Weight,pch=3,col="Green")
plot(df1$Height~df1$Age ,pch=3,col="Red")

abline(lmHeight) #It should be plotted over other plot

#Plotting of residuals to observe pattern
plot(lmHeight$residuals,pch=2, col="Blue")
# Random is better or apply transformations

#Detect influential points
plot(cooks.distance(lmHeight),pch=5,col="Green")



