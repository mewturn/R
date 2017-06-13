## Practice 2: Auto.csv
## Linear Regression

## Replace "?" with NAs
## We need to do this because of some "?" in horsepower in the dataset
Auto$horsepower <- as.numeric(as.character(Auto$horsepower))

## Predict mpg using horsepower in a linear model (lm), using dataset Auto
model1 = lm(mpg~horsepower, data=Auto)
summary(model1)

## There is strong relationship between horsepower and mpg: R-squared value of 0.6059 with p-value of almost zero
## This means we can reject the null hypothesis that beta = 0
## Since beta for the mpg-horsepower relationship is -0.1578, they have a negative relationship

## Predict using model 1, with the dataframe containing horsepower=98 with a confidence interval of 99%
predict(model1, newdata=data.frame(horsepower=98), interval=c("confidence"), level=0.99)
## Predicted mpg: 24.467, 99% confidence interval: [23.817, 25.117]

## Computes the correlation while dropping observations with missing entries
cor(Auto$mpg, Auto$horsepower, use="pairwise.complete.obs")
## Returnsa correlation of -0.778, which when squared gives the R-squared value of 0.6059

## Plot the reponse (mpg) against the predictor (horsepower)
plot(Auto$horsepower, Auto$mpg)
## Least-squared regression line
abline(model1)

## Diagnostics plots
layout(matrix(1:4,2,2))
plot(model1)

## Residuals vs Fitted: residual (error) decreases and then increases as the number of fitted values increases
## Normal Q-Q plot shows that distribution of the residuals is non-normal at the extreme ends
## Therefore, there are some outliers and non-linearities in the dataset

## Remove the column name from Auto and create a subset of the dataset
auto1 <- subset(Auto, select=-c(name))

## Scatterplot matrix from the auto dataframe (less the name column)
pairs(auto1)

## Correlation matrix
cor(auto1)

## Multiple linear regression with all the remaining predictor values to predict mpg
model2 <- lm(mpg~., data=auto1)
summary(model2)

## Since the p-value is very close to 0 for the multiple regression model, we can reject the null hypothesis that all the betas are zeroes
## Statistically significant relationship with mpg (1% level): displacement, weight, year, origin
## Coefficient of year is 0.750 (positive), meaning that each year adds 0.750 to mpg with all other variables held cconstant