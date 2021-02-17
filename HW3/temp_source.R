y <- c(-2, -1, 0, 1.5, 2.5)

temp <- function(theta) {
  1/pi^5/(1+(y[1]-theta)^2)/(1+(y[2]-theta)^2)/(1+(y[3]-theta)^2)/
    (1+(y[4]-theta)^2)/(1+(y[5]-theta)^2)
}
const <- integrate(temp, -100, 100)


posterior <- function(theta) {
  prod(1/pi/(1+(y-theta)^2)) / const$value
}



grid <- seq(-4, 5, .01)
z <- c()
for (x in grid) z <- c(z, posterior(x))
plot(grid, z, type='l')



d1 <- function(x) {
  sum((y-x)/(1+(y-x)^2))
}

d2 <- function(x) {
  sum(((y-x)^2-1)/(1+(y-x)^2)^2)
}

iter <- 1e3
res <- rep(0, iter)
for (i in 1:iter) {
  res[i+1] <- res[i] - d1(res[i])/d2(res[i])
}
tail(res)
plot(res, type='l')


mu <- tail(res, 1)
sig <- sqrt(-1/d2(mu))

grid <- seq(-4, 5, .01)
z2 <- c()
for (x in grid) z2 <- c(z2, dnorm(x, mean=mu, sd=sig))
plot(grid, z2, type='l')
lines(grid, z, col='red')
