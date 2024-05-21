Var1 <- rpois(100,0.5)
Var2 <- rbinom(100,2,0.6)
Var3 <- rbinom(100,1,0.5)
SUM <- as.integer(abs(Var1+Var2+Var3+(rnorm(100))))
sum.data <- data.frame(Var1,Var2,Var3, SUM)

net.sum <- neuralnet(SUM~Var1+Var2+Var3,
                     sum.data,
                     hidden=4)

print(net.sum)
plot(net.sum)
prediction(net.sum)
