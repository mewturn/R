## Practice 2: climate_change.csv
## Linear Regression

# Splits the dataset into two parts, training: on or before 2006, test: after 2006
training <- subset(climate_change, Year<=2006)
test <- subset(climate_change, Year>2006)

# Use everything except Year and Month to predict Temp 
# R-squared: 0.7509, Adjusted R-squareD: 0.7436
# Significant variables: all except CH4 and N2O
model1 <- lm(Temp~.-Year-Month, data=training)
summary(model1)

# N2O is highly correlated with CO2, CH4 and CFC-12.
# CFC-11 is fairly positively correlated with CH4, N2O, CO2 and CFC-12.
# Hence, results seem to indicate that the gas concentration variables reflect human development and are correlated with other variables in the data set.
cor(training)

