setwd("D:/MyProjects/SCM_GITHUB/kaggle_titanic_tutorial")
train <- read.csv("train.csv")
test <- read.csv("test.csv")

# combine both train and test data
test$Survived <- NA
combi <- rbind(train, test)

combi$Name <- as.character(combi$Name)

# strsplit(combi$Name[1], split = '[,.]')[[1]][2]

# apply string split to all rows
combi$Title <- sapply(combi$Name, FUN = function(x) { strsplit(x, split = '[,.]')[[1]][2]})
# trim whitespaces
combi$Title <- sub(' ', '', combi$Title)

table(combi$Title)

#combine rare and similar titles
combi$Title[combi$Title %in% c('Mme', 'Mlle')] <- 'Mlle'
combi$Title[combi$Title %in% c('Capt', 'Don', 'Major', 'Sir')] <- 'Sir'
combi$Title[combi$Title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')] <- 'Lady'

# convert it back to Factor
combi$Title <- factor(combi$Title)

# new feature, family size
combi$FamilySize <- combi$SibSp + combi$Parch + 1

# extra surname
combi$Surname <- sapply(combi$Name, FUN = function(x) { strsplit(x, split = '[,.]')[[1]][1]})

table(combi$Surname)

combi$FamilyId <- paste(as.character(combi$FamilySize), combi$Surname, sep="")

table(combi$FamilyId)

combi$FamilyId[combi$FamilySize <= 2] <- 'Small'

famIDs <- data.frame(table(combi$FamilyId))
