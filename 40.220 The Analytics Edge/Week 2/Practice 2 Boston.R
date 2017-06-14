## Practice 2: Boston.csv
## Linear Regression

# Use Crime Data to predict Median Value of homes (Single Linear Reg.)
# p-value near zero: statistically significant
model1 <- lm(medv~crim, data=Boston)
summary(model1)

model2 <- lm(medv~lstat, data=Boston)

# As lower status of the population (%) decreases,  Median value of homes increases
plot(Boston$medv, Boston$lstat)
abline(model2)

# Multiple Linear Reg.
model3 <- lm(medv~., data=Boston)
summary(model3)
# Can reject B=0 for crim, zn, chas, nox, rm, dis, rad, tax, ptratio, black, lstat at the 0.05 level
# Adjusted R-squared: 0.7338, which is higher than R-squared for the single linear regression models

# Plot the coefficients from simple linear regression with the coefficients from multiple linear regressoin
x <- c(model1$coeff[2], model2$coeff[2])
y <- model3$coeff[2:3]
plot(x, y, main="Coefficient Relationship", xlab="Simple Linear Reg", ylab="Multiple Linear Reg")
# Fairly positive relationship, seems to be linear

# Linear regression with lstat + lstat^2: Adjusted R-squared = 0.6393
modelpoly2 <- lm(medv~poly(lstat,2,raw=TRUE), data=Boston)
summary(modelpoly2)

# Linear regression with lstat + lstat^2 + lstat^3: Adjusted R-squared = 0.6558 (better fit)
modelpoly3 <- lm(medv~poly(lstat,3,raw=TRUE), data=Boston)
summary(modelpoly3)

# Predict using a linear model (model2) and a non-linear model (modelpoly3)
pr1 <- predict(model2, newdata=Boston)
pr2 <- predict(modelpoly3, newdata=Boston)

# Adds points to a plot
points(Boston$lstat, pr1, col="red")
points(Boston$lstat, pr2, col="blue")
