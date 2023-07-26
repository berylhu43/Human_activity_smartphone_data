

setwd('/Users/yuxuanhu/Desktop/coursera_R/rprog_data_ProgAssignment3-data/Human_activity_smartphone_data/UCI HAR Dataset')
folder<-getwd()
xtest<-read.table(paste0(folder, '/test/X_test.txt'))
ytest<-read.table(paste0(folder, '/test/y_test.txt'))
testsub<-read.table(paste0(folder, '/test/subject_test.txt'))
xtrain<-read.table(paste0(folder, '/train/X_train.txt'))
ytrain<-read.table(paste0(folder, '/train/y_train.txt'))
trainsub<-read.table(paste0(folder, '/train/subject_train.txt'))
train<-cbind(trainsub, xtrain, ytrain)
test<-cbind(testsub, xtest, ytest)
df<-rbind(test,train)

file<-file(paste0(folder, '/features.txt'))
read<-readLines(file)
close(file)

find_key <- read[grepl("mean[(]|std[(]", read)]
find_key %<>% 
            gsub('[-()]','',.) %>%
            gsub('\\d','',.) 


library(readr)
library(dplyr)
index <- parse_number(find_key)+1
msdata <- df[, c(1, index, ncol(df))]
msdata<-rename(msdata,'Subject_id'='V1', 'Activity' = 'V1.2')
colnames(msdata)[2:67]<-find_key

file2<-file(paste0(folder, '/activity_labels.txt'))
read_activity<-readLines(file2)
close(file2)
labels <- sub("^[0-9] ", "", read_activity)

msdata$Activity <- factor(msdata$Activity, levels = c(1:6), labels = labels)

group_table <- msdata
result<- group_table[2:68] %>%
  group_by(Activity) %>%
  summarise_all(mean) %>%
  print
  

write.table(result, file = 'mytable.txt', row.names = FALSE)









