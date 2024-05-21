# binary classification
data(infert, package="datasets")
?infert

net.infert <- neuralnet(case~parity+induced+spontaneous,
                        infert, 
                        err.fct="ce",
                        hidden=5,
                        linear.output=FALSE,
                        likelihood=TRUE)

plot(net.infert)
print(net.infert)

gwplot(net.infert, selected.covariate="parity")
gwplot(net.infert, selected.covariate="induced")
gwplot(net.infert, selected.covariate="spontaneous")

confidence.interval(net.infert)
