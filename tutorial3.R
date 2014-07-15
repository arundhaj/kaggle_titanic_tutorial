# install.packages('rattle')
# install.packages('rpart.plot')
# install.packages('RColorBrewer')

library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

setwd("D:/MyProjects/SCM_GITHUB/kaggle_titanic_tutorial")
train <- read.csv("train.csv")
test <- read.csv("test.csv")

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")

plot(fit)
text(fit)

fancyRpartPlot(fit)

Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfirstdtree.csv", row.names = FALSE)

#overfitting
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class", control = rpart.control(minsplit = 2, cp = 0))
fancyRpartPlot(fit)

# changed cp
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class", control = rpart.control(minsplit = 2, cp = 0.005))
fancyRpartPlot(fit)
