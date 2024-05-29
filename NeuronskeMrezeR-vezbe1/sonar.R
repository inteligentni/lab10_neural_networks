# install.packages("tidyverse")
library(tidyverse)
library(neuralnet)
library(ggplot2)

# PRIMER BINARNE KLASIFIKACIJE POMOCU NEURONSKE MREZE

# load dataset from csv file
sonar.data <- read.csv("data/sonar.csv", stringsAsFactors = TRUE)

str(sonar.data)

# display column info and statistics
summary(sonar.data)

normalize_max <- function(col) {
  return (col / max( abs(col) ) ) 
}

# standardization
?scale
sonar.data.std <- apply(X = sonar.data[,1:60],
                              MARGIN=2,
                              FUN=scale)

sonar.data.std <- as.data.frame(sonar.data.std)
sonar.data.std$Class <- sonar.data$Class

# nacrtaj scatter plot matrix za izabrane kolone
plot(sonar.data[,1:10], col=c("blue","red")[sonar.data$Class])
plot(sonar.data.std[,1:10], col=c("blue","red")[sonar.data.std$Class])
str(sonar.data.std)


#############################################
# Split the data into training and test sets
#############################################

# install.packages('caret')
library(caret)

# assure the replicability of the results by setting the seed 
set.seed(123)

# generate indices of the observations to be selected for the training set
train.indices <- createDataPartition(sonar.data.std$Class, p = 0.70, list = FALSE)
# select observations at the positions defined by the train.indices vector
train.sonar <- sonar.data.std[train.indices,]
# select observations at the positions that are NOT in the train.indices vector
test.sonar <- sonar.data.std[-train.indices,]

library(neuralnet)
# train model
nn <- neuralnet(Class ~ . , 
                train.sonar,
                err.fct="ce",
                hidden=30,
                linear.output = FALSE)
plot(nn)


# evaluate trained model

library(dplyr)
library(tidyverse)

labels <- c("M", "R")
pred <- predict(nn, test.sonar)
pred

max.pred.col <- max.col(pred)
max.pred.col

max.pred.lbl <- recode(max.pred.col, '1'="M", '2'="R")
max.pred.lbl
predicted_label <- data.frame(max.col(pred)) %>%
  mutate(pred=labels[max.pred.col]) %>%
  select(2) %>%
  unlist()  


table(test.sonar$Class, predicted_label)

check = as.numeric(test.sonar$Class) == max.col(pred)
accuracy = (sum(check)/nrow(test.sonar))*100
print(accuracy)
pred

nn.cm <- table(test.sonar$Class, max.pred.lbl)
nn.cm
?table
test.sonar$Class
pred[max.pred.col]
predicted_label

# function for computing evaluation measures
compute.eval.metrics <- function(cmatrix) {
  TP <- cmatrix[1,1] # true positive
  TN <- cmatrix[2,2] # true negative
  FP <- cmatrix[2,1] # false positive
  FN <- cmatrix[1,2] # false negative
  acc <- sum(diag(cmatrix)) / sum(cmatrix)
  precision <- TP / (TP + FP)
  recall <- TP / (TP + FN)
  F1 <- 2*precision*recall / (precision + recall)
  c(accuracy = acc, precision = precision, recall = recall, F1 = F1)
}

compute.eval.metrics(nn.cm)

