# install.packages("tidyverse")
library(tidyverse)
library(neuralnet)
library(ggplot2)

# REGRESIAJ POMOCU NEURONSKE MREZE

# load dataset from csv fajla
boston.data <- read.csv("data/housing.csv", stringsAsFactors = FALSE)

str(boston.data)

# display column info and statistics
summary(boston.data)


normalize_max <- function(col) {
  return (col / max(abs(col))) 
}

boston.data.normalized <- apply(X = boston.data[, ],
                              MARGIN=2,
                              FUN=normalize_max)
boston.data.normalized <-as.data.frame(boston.data.normalized)

head(boston.data.normalized)
boston.data.normalized
# nacrtaj scatter plot matrix

library(ggplot2)
pairs(boston.data.normalized[, c(1:4)], main = "Scatter Plot Matrix for  Dataset")

#############################################
# Split the data into training and test sets
#############################################

# install.packages('caret')
library(caret)

# assure the replicability of the results by setting the seed 
set.seed(123)

# generate indices of the observations to be selected for the training set
train.indices <- createDataPartition(boston.data.normalized$MEDV, p = 0.70, list = FALSE)
# select observations at the positions defined by the train.indices vector
train.boston <- boston.data.normalized[train.indices,]
# select observations at the positions that are NOT in the train.indices vector
test.boston <- boston.data.normalized[-train.indices,]


library(neuralnet)
# train model
nn <- neuralnet(MEDV ~ . , 
                train.boston,
                hidden=c(8),
                linear.output = TRUE)
plot(nn)

# create predictions using trained model
predictions = predict(nn, newdata=test.boston)
predictions
# evaluate trained model

# Compute mean squared error 
err <- test.boston$MEDV - predictions
#pr.nn_ <- pr.nn$net.result * (max(data$medv) - min(data$medv)) + min(data$medv) 
# test.r <- (test_$medv) * (max(data$medv) - min(data$medv)) +  min(data$medv) 
mse <- sum((err)^2) / nrow(err) 
mse

# Plot actual vs predicted line 
plot(test.boston$MEDV, predictions, col = "red", main = 'Real vs Predicted') 
?plot
abline(0, 1, lwd = 2)
?abline
plot(err)
