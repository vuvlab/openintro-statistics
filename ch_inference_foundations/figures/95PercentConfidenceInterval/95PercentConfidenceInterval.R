library(openintro)
data(COL)
data(run10)
set.seed(52)

myPDF('95PercentConfidenceInterval.pdf', 6, 4,
      mar = c(2, 1, 1, 1),
      mgp = c(2.7, 0.9, 0))
m <- 94.52
s <- 16.0
n <- 100
k <- 25
SE <- s/sqrt(n)

set.seed(3)
means <- c()
SE    <- c()
for(i in 1:k){
  temp <- sample(nrow(run10), n)
  d    <- run10$time[temp]
  means[i] <- mean(d, na.rm = TRUE)
  SE[i]    <- sd(d)/sqrt(n)
}
xR <- m + 4 * c(-1, 1) * s / sqrt(n)
yR <- c(0, 41 * k / 40)
plot(xR, yR,
     type = 'n',
     xlab = 'run time (minutes)',
     ylab = '',
     axes = FALSE)
abline(v = m, lty = 2, col = COL[6])
axis(1, at = m, expression(mu*' = 94.52'),
     cex.axis = 1.15)
for(i in 1:k){
  ci <- means[i] + 2 * c(-1, 1) * SE[i]
  if(abs(means[i] - m) > 1.96 * SE[i]){
    col <- COL[4]
    points(means[i], i, cex = 1.4, col = col)
    lines(ci, rep(i, 2), col = col, lwd = 4)
  } else {
    col <- COL[1]
  }
  points(means[i], i, pch = 20, cex = 1.2, col = col)
  lines(ci, rep(i, 2), col = col)
}
dev.off()
