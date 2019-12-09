sessionInfo()
system.time(m <- rnorm(10^8))
m2 <- matrix(m, nrow = 10^4)
system.time(m2 %*% m2)
