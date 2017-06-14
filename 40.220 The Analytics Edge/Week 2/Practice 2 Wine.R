# Defines two new variables which captures the age in years of the wine at the time of auction
winedata$age91 <- 1991 - winedata$vintage
winedata$age92 <- 1992 - winedata$vintage

# Finding the mean price of wine of at least 15 years old at the time of the 1991 auction
# Avg Price: $96.43
mean(subset(winedata$price91,winedata$age91>=15))

# Finding the mean price of wine in the 1991 auction in years when harvest rain was below average and temperature difference was below average
# Avg Price: $72.87
mean(subset(winedata$price91,winedata$hrain<mean(winedata$hrain)&winedata$tempdiff<mean(winedata$tempdiff)))

# Split the data set
train <- subset(winedata, winedata$vintage<=1981)
test <- subset(winedata, winedata$vintage>1981)

# Lin. reg. of log(price91) with age91
model1 <- lm(log(price91)~age91, data=train)
summary(model1)
# R-squared: 0.6675

# Find the 99% confidence interval of the model
confint(model1, level=0.99)
# B0: [3.159, 3.983]
# B1: [0.0228, 0.0623]

# Use model 1 to predict test data
predtest <- predict(model1, newdata=test)
summary(predtest)
sse = sum((log(test$price91)-predtest)^2)
sst = sum((log(test$price91)-mean(log(train$price91)))^2)
Rsq = 1 - (sse/sst)
# Rsq = 0.9213

model2 <- lm(log(price91)~age91+temp+hrain+wrain+tempdiff, data=train)
summary(model2)
# Rsq = 0.7938
# Since the adjusted R-sq is 0.7145, this multiple linear regression model is still preferred over the previous simple regression model
# The result indicates that the lesser the harvest rain, the better is the price and quality of the wine, since B4 is negative and is significant at the 0.05 significance level

# Two least significant variables: wrain(p-value 0.5313) and tempdiff(p-value 0.4166). We drop these two.
model3 <- lm(log(price91)~age91+temp+hrain, data=train)
summary(model3)
# Rsq = 0.7753, A-Rsq = 0.7304
# Equation: -log(price91) = 1.801 + 0.0456(age91) + 0.0975(temp) - 0.00198(hrain)
# This model is preferred, since the adjusted r-squared is higher than the previous model (model2)

model4 <-lm(log(price92)~age92+temp+hrain, data=train)
summary(model4)
# Rsq = 0.5834
# At the 0.2 significance level, we cannot reject the null hypothesis B(hrain)=0 as its p-value is 0.32 > 0.2
