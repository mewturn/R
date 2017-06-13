## Practice 2: Multicollinearity
## Linear Regression

set.seed(1)
x1 <- runif(100) # Generates random deviates (min=0, max=1)
x2 <- 0.5*x1 + rnorm(100)/10
y <- 2 + 2*x1 + 0.3*x2 + rnorm(100)

## Form of the linear model: Y = 2 + 2(X1) + 0.3(X2) + E
## Regression coefficients: B0=2, B1=2, B2=0.3

## Correlation between x1 and x2 = 0.8308
## Strong positive relationship
cor(x1,x2)
plot(x1,x2)

## Linear regression model to predict y with x1 and x2
model1 <- lm(y~x1+x2)
summary(model1)
## Estimated coefficients: B0=2.124, B1=1.4496, B2=1.1182 -> Some discrepancies in the coefficients
## We can reject the null hypothesis B1=0 at 5% level
## We cannot reject the null hypothesis B2=0 at 5% level

## Predict y with only x1
model2 <- lm(y~x1)
summary(model2)
## Estimated coefficients B0=2.081, B1=2.093 -> Less discrepancies in the coefficients compared to the multiple regression model (model1)
## We can reject the null hypothesis B1=0 since the p-value is very small (close to zero)

model3 <- lm(y~x2)
summary(model3)
## Estimated coefficients B0=2.403, B2=2.857 -> Value is largely different from the original B values
## We can reject the null hypothesis B2=0 since the p-value is also very small (close to zero)

## Reason for discrepancies: Multicollinearity
## Since x2 is highly correlated with x1, we see that with a multiple regression model, we cannot reject H0: B2=0, but with a single regression, we can confidently reject B2=0