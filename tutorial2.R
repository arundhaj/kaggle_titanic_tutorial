setwd("/media/arun/myprojects/scm_github/kaggle_titanic/")
train <- read.csv("/media/arun/myprojects/scm_github/kaggle_titanic/train.csv")
test <- read.csv("/media/arun/myprojects/scm_github/kaggle_titanic/test.csv")
#prop.table(table(train$Sex, train$Survived), 1)
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = 'femalesurvived.csv', row.names = FALSE)
# submitted to Kaggle
train$Child <- 0
train$Child[train$Age < 18] <- 1

# total number of people survived in the subset
aggregate(Survived ~ Child + Sex, data = train, FUN=sum)

# total number of people in the subset
aggregate(Survived ~ Child + Sex, data = train, FUN=length)

# proportions of each subset
aggregate(Survived ~ Child + Sex, data = train, FUN=function(x) { sum(x) / length(x) })

# fare bucket
train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '10'

aggregate(Survived ~ Fare2 + Pclass + Sex, data=train, FUN = function(x) { sum(x) / length(x)})

test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Fare >= 20] <- 0

#only few female survive
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = 'fewfemalesurvived.csv', row.names = FALSE)
