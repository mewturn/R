## Practice 2: climate_change.csv
## Linear Regression

# Splits the dataset into two parts, training: on or before 2006, test: after 2006
training <- subset(climate_change, Year<=2006)
test <- subset(climate_change, Year>2006)

# Use everything except Year and Month to predict Temp 
# R-squared: 0.7509, Adjusted R-squared: 0.7436
# Significant variables: all except CH4 and N2O
model1 <- lm(Temp~.-Year-Month, data=training)
summary(model1)

# N2O is highly correlated with CO2, CH4 and CFC-12.
# CFC-11 is fairly positively correlated with CH4, N2O, CO2 and CFC-12.
# Hence, results seem to indicate that the gas concentration variables reflect human development and are correlated with other variables in the data set.
cor(training)

model2 <- lm(Temp~MEI+TSI+Aerosols+N2O, data=training)
summary(model2)
# Previous N2O coefficient: -1.653e-02; Current N2O Coefficient: 2.532e-02
# We see a positive relationship between N2O and temperature in the second model
# The current model's R-squared is 0.7261, which means it does not lose much explanatory power while other variables are removed. This is indicative of significant correlation between independent variables.

# Using the step() function to find the best combination of variables (similar to AIC)
model3 <- step(model1)
summary(model3)
# Gives a smaller R-squared (0.7508) than the full model, but higher adjusted R-squared of 0.7445
# CH4 was removed from the model

# Using test data to validate training data
pred <- predict(model3, newdata=test)
sse <- sum((test$Temp-pred)^2)
sst <- sum((test$Temp-mean(training$Temp))^2)
testRsq <- 1 - (sse/sst)
# testRsq = 0.6286
