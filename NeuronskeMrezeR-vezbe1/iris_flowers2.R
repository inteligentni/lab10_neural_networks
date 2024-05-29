# install.packages("tidyverse")
library(tidyverse)
library(neuralnet)
library(ggplot2)


# PRIMER VISEKLASNE KLASIFIKACIJE POMOCU NEURONSKE MREZE

# load dataset from csv file
iris.data <- read.csv("data/iris.data.csv", stringsAsFactors = FALSE)

# display dataset structure
str(iris.data)

# convert character column  class to factor
iris.data$class = as.factor(iris.data$class)

# display column info and statistics
summary(iris.data)

normalize_max <- function(col) {
  return (col / max( abs(col) ) ) 
}

# abs

normalize_max_min <- function(col) {
  return (col-min(col) / (max(col)-min(col)))
}


iris.data.normalized <- apply(X = iris.data[, 1:4],
                              MARGIN=2,
                              FUN=normalize_max)

iris.data.normalized <- as.data.frame(iris.data.normalized)
iris.data.normalized$class <- iris.data$class

head(iris.data.normalized)

# standardization
?scale
iris.data.std <- apply(X = iris.data[, 1:4],
                           MARGIN=2,
                           FUN=scale)

# nacrtaj scatter plot matrix za iris data set

plot(iris.data[,1:4], col=c("red","blue","green")[iris.data$class])
plot(iris.data.normalized[,1:4], col=c("red","blue","green")[iris.data$class])
plot(iris.data.std[,1:4], col=c("red","blue","green")[iris.data$class])

?plot
library(ggplot2)
pairs(iris.data[, c(1:4)],
      col=c("red","blue","green")[iris.data$class],
      main = "Scatter Plot Matrix for mtcars Dataset")


#create scatterplot matrix using ggally

library(ggplot2)
install.packages("GGally")
install.packages("ggstats")
library(GGally)

ggpairs(iris.data)

#############################################
# Split the data into training and test sets
#############################################

# install.packages('caret')
library(caret)

# assure the replicability of the results by setting the seed 
#set.seed(123)

# generate indices of the observations to be selected for the training set
train.indices <- createDataPartition(iris.data.normalized$class,
                                     p = 0.70,
                                     list = FALSE)
# select observations at the positions defined by the train.indices vector
train.iris <- iris.data.normalized[train.indices,]
# select observations at the positions that are NOT in the train.indices vector
test.iris <- iris.data.normalized[-train.indices,]

library(neuralnet)
# train model
nn <- neuralnet(class ~ sepal_length + sepal_width + petal_length + petal_width, 
                train.iris,
                err.fct = "ce",
                hidden=c(8),
                linear.output = FALSE)
plot(nn)
print(nn)

# evaluate trained model
library(tidyverse)

pred <- predict(nn, test.iris)
pred
labels <- c("setosa", "versicolor", "virginca")
max.pred.col <- max.col(pred)
max.pred.col

prediction_label <- data.frame(max.col(pred)) %>%     
  mutate(pred=labels[max.pred.col]) %>%
  select(2) %>%
  unlist()  

prediction_label

table(test.iris$class, prediction_label)

check = as.numeric(test.iris$class) == max.col(pred)
accuracy = (sum(check)/nrow(test.iris))*100
print(accuracy)

test.iris$predicted <- max.pred.col

plot(test.iris[,1:4], col=c("red","blue","green")[test.iris$class])
plot(test.iris[,1:4], col=c("red","blue","green")[test.iris$predicted])
