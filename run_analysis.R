
# Column Name from features.txt
feature <- read.table(("./features.txt"))
x_col_name <- sub("t","time",feature[,2])
x_col_name <- gsub("-"," ",x_col_name)
x_col_name <- sub("f","frequency",x_col_name)


# Activity Label
actlabel_df <- read.table("./activity_labels.txt",col.names = c("Index","Activity") )


# Reading X_train.txt, y_train.txt, subject_train.txt
sub_train <- read.table("./subject_train.txt",col.names = c("Subject"))
y_train <- read.table("./y_train.txt",col.names = c("Activity"))
# 3. Applying Descriptive Activity Name
y_train <- sapply (y_train,function(x) {actlabel_df[x,2]  } )
x_train <- read.table("./X_train.txt",col.names = x_col_name)
train_data <- cbind(sub_train,y_train,x_train)


# Reading X_test.txt, y_test.txt, subject_test.txt
sub_test <- read.table("./subject_test.txt",col.names = c("Subject"))
y_test <- read.table("./y_test.txt",col.names = c("Activity"))
# 3. Applying Descriptive Activity Name
y_test <- sapply (y_test,function(x) {actlabel_df[x,2]  } )
x_test <- read.table("./X_test.txt",col.names = x_col_name)
test_data <- cbind(sub_test,y_test,x_test)


# 1.Merging train & test data
data <- rbind(train_data,test_data)
print("Number of Rows & Columns in Merged data")
print(nrow(data))
print(ncol(data))


# 2. Extracting Meand & SD Colums
meancols <- c( grep("mean",names(data),ignore.case = TRUE) )
sdcols <- c( grep("std",names(data),ignore.case = TRUE) )
tidydata <- data[,1:2]
tidydata <- cbind(tidydata,data[,meancols],data[,sdcols])


library(dplyr)

tidydatanew <- group_by(tidydata,Subject,Activity)
tidydatanew1 <- summarise(tidydatanew,mean(timeBodyAcc.mean...X),mean(timeBodyAcc.mean...Y),mean(timeBodyAcc.mean...Z))

print("Displaying Sample Tidy Data")
print("Number of Rows & Columns in Merged data")
print (nrow(tidydatanew1))
print (ncol(tidydatanew1))
print(tidydatanew1)

write.table(tidydatanew1,file = "tidydata.txt",row.names=FALSE)


