# regresija

Var1 <- runif(50, 0, 100)
sqrt.data <- data.frame(Var1, Sqrt=sqrt(Var1))

net.sqrt <- neuralnet(Sqrt~Var1,
                      sqrt.data,
                      hidden=10,
                      threshold=0.01)

print(net.sqrt)
plot(net.sqrt)
predict(net.sqrt, data.frame(Var1 = (1:10)^2))
gwplot(net.sqrt)
