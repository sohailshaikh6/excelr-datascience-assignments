getwd()
setwd("E:/Excelr Data/Data Sets/Multilinear Regression")
 Cars <- read.csv ("Cars.csv")
 View(Cars)
 
 attach(Cars)
 
qqnorm(HP)
qqline(HP)
 
 summary(Cars) # Explore the data

plot(HP,MPG) # Plot relation ships between each X with Y
plot(VOL,MPG)
## Or make a combined plot
pairs(Cars)   # Scatter plot for all pairs of variables
cor(HP,MPG)
cor(Cars) # correlation matrix

# The Linear Model of interest
model.car <- lm(MPG~VOL+HP+SP+WT) # lm(Y ~ X)
summary(model.car)

model.carV<-lm(MPG~VOL)
summary(model.carV)

model.carW <- lm(MPG~WT)
summary(model.carW)

model.carVW <- lm(MPG~VOL+WT)
summary(model.carVW)

#######                    Scatter plot matrix with Correlations inserted in graph
panel.cor <- function(x, y, digits=2, prefix="", cex.cor)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r = (cor(x, y))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if(missing(cex.cor)) cex <- 0.4/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex)
}
pairs(Cars, upper.panel=panel.cor,main="Scatter Plot Matrix with Correlation Coefficients")
###                                   Partial Correlation matrix
install.packages("corpcor")
library(corpcor)
cor(Cars)

cor2pcor(cor(Cars))


# Diagnostic Plots
install.packages(car)
library(car)
plot(model.car)# Residual Plots, QQ-Plos, Std. Residuals vs Fitted, Cook's distance
qqPlot(model.car, id.n=5) # QQ plots of studentized residuals, helps identify outliers

# Deletion Diagnostics for identifying influential variable
influence.measures(model.car)
influenceIndexPlot(model.car, id.n=3) # Index Plots of the influence measures
influencePlot(model.car, id.n=3) # A user friendly representation of the above

## Regression after deleting the 77th observation
model.car1<-lm(MPG~VOL+HP+SP+WT, data=Cars[-77,-71,])
summary(model.car1)


### Variance Inflation Factors
vif(model.car)  # VIF is > 10 => collinearity
VIFWT<-lm(WT~VOL+HP+SP)
VIFVOL<-lm(VOL~WT+HP+SP)
VIFHP<-lm(HP~VOL+WT+SP)
VIFSP<-lm(SP~VOL+HP+WT)
summary(VIFWT)
summary(VIFVOL)
summary(VIFHP)
summary(VIFSP)
#### Added Variable Plots ######
avPlots(model.car)
?avPlots

library("MASS")
stepAIC(model.car) # backward

plot(model.car)

model.final <- lm(MPG~VOL+HP+SP, data=Cars)
summary(model.final)


model.final1 <- lm(MPG~VOL+HP+SP, data=Cars[-77,])
summary(model.final1)

avPlots(model.final1, id.n=2, id.cex=0.8, col="red")

vif(model.final1)

# Lower the AIC (Akaike Information Criterion) value better is the model. AIC is used only if you build
# multiple models.