XOR <- c(0,1,1,0)
xor.data <- data.frame(expand.grid(c(0,1), c(0,1)), XOR)

net.xor <- neuralnet(XOR~Var1+Var2,
                     xor.data,
                     hidden=2)

plot(net.xor)
prediction(net.xor)
print(net.xor)


