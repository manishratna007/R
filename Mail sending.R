library(mailR)
library(rJava)

path<-setwd("F:/Drive 1/Wallpaper")

files<-list.files(path)

mails<-c("manish.ratna@indianpac.com","manishratna007@gmail.com","manishratna@hotmail.com")
mails[3]
files[2]

foo <- vector(mode="list", length=3)
names(foo) <- c("Image-7.jpg", "Image-8.jpg", "Image-6.png")
foo[[1]] <- mails[1]; 
foo[[2]] <- mails[2]; 
foo[[3]] <- mails[3];
foo[1]
#if("Image-2.jpg"==names(foo[2])){
#  print(TRUE)
#}


#for (i in files){
#   for (j in 1:3){
#      if(i==names(foo[j])){
#        print(i)  
#   }
#  }
#}

for (i in files) {
  for (j in 1:3){
      if(i==names(foo[j])){
           send.mail(from = "manish.ratna@indianpac.com",
              to = foo[j],
              subject = "Subject of the email",
              body = "Body of the email",
              smtp = list(host.name = "smtp.gmail.com", port = 587, user.name = "manish.ratna@indianpac.com", passwd = "****", ssl = TRUE),
              authenticate = TRUE,
              send = TRUE,
              attach.files = i, 
              #file.names = cat("AC Document Files",attach.files), # optional parameter
              #file.descriptions = c("Description for download log"), # optional parameter
              debug = TRUE)
      }
    }
  }
