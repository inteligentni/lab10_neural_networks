install.packages("neuralnet")
library(neuralnet)

AND <- c(rep(0,7),1)
OR <- c(0,rep(1,7))
binary.data <- data.frame(expand.grid(c(0,1), c(0,1), c(0,1)), AND, OR)
net <- neuralnet(AND+OR~Var1+Var2+Var3,
                 binary.data,
                 hidden=0,
                 rep=10,
                 err.fct="ce",
                 linear.output=FALSE)
plot(net)
prediction(net)
print(net)
