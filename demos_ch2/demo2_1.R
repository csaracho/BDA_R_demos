# Bayesian data analysis
# Aki Vehtari <Aki.Vehtari@aalto.fi>
# Markus Paasiniemi <Markus.Paasiniemi@aalto.fi>

# Probability of a girl birth given placenta previa (BDA3 p. 37).
# 437 girls and 543 boys have been observed. Calculate and plot the
# posterior distribution of the proportion of girls theta, using
# uniform prior on theta

# ggplot2 is used for plotting
# to install new packages, type e.g. install.packages('ggplot2')
library(ggplot2)

# posterior is Beta(348,544)
df1 <- data.frame(x = seq(0.375, 0.525, 0.001))
a <- 438
b <- 544

# dbeta computes the posterior density
df1$p <- dbeta(df1$x, a, b)

# seq creates evenly spaced values from 2.5% quantile
# to 97.5% quantile (i.e., 95% central interval)
# qbeta computes the value for a given quantile given parameters a and b
df2 <- data.frame(x = seq(qbeta(0.025, a, b), qbeta(0.975, a, b), length.out = 100))

# compute the posterior density
df2$p <- dbeta(df2$x, a, b)

# Plot posterior (Beta(438,544))
ggplot(mapping = aes(x, p)) +
  geom_line(data = df1) +
  # Add a layer of colorized 95% posterior interval
  geom_area(data = df2, aes(fill='1')) +
  # Add the proportion of girl babies in general population
  geom_vline(xintercept = 0.485, linetype='dotted') +
  # Decorate the plot a little
  labs(title='Uniform prior -> Posterior is Beta(438,544)', y = '') +
  scale_y_continuous(expand = c(0, 0.1), breaks = NULL) +
  scale_fill_manual(values = 'darkblue', labels = '95% posterior interval') +
  theme(legend.position = 'bottom', legend.title = element_blank())

