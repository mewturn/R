## Practice 3: germancredit.csv
## Logistic Regression

set.seed(2016)
library(caTools)
split = sample.split(germancredit$resp, 0.75)
training = subset(germancredit, split==TRUE)
test = subset(germancredit, split==FALSE)
# Balances the dependent variables between the training and test data sets

# Simple logistic regression to predict credit risk
model1 <- glm(resp~-., data=training, family="binomial")
summary(model1)

# The fitted model: P(resp=1) = e^B(resp)/ 1 + e^B(resp) = 0.7, B=0.8473 
# This is the proportion of people who have a good credit rating in the data set

# Multiple logistic regression 
model2 <- glm(resp~., data=training, family="binomial")
summary(model2) # AIC 751.55
# Variables significant at 0.1 level: chkacct, dur, hist, amt, sav, instrate, malesingle, age, 'for'

# Residual deviance = -2LL(B) = 689.55 -> log likelihood (B) = -344.77
# Null Deviance = -2LL(intercept) = 916.30

pred2 <- predict(model2, newdata=test, type="response")
# Confusion matrix
table(as.numeric(pred2>0.5),test$resp)

# Accuracy = TP + TN / Total = 0.788
accuracy = (40 + 157) / (40 + 157 + 35 + 18)

# Remove intercept using "-1"
model3 <- glm(resp~chkacct+dur+hist+amt+sav+instrate+malesingle+age+`for`-1, data=training, family="binomial")
summary(model3) # AIC: 750.24

# Based on AIC, we pick model3, which has a lower AIC (lower better)
pred3 <- predict(model3, newdata=test, type="response")
# Confusion matrix
table(as.numeric(pred3>0.5),test$resp)
accuracy = (33 + 160) / (33 + 160 + 15 + 42) # 0.772

# Predict Good credit risk but actually bad -> False Positive
# Model 2: 35, Model 3: 42 -> Model 2 is better

# Predict Bad credit risk but actually good -> False Negative
# Model 2: 18, Model 3: 15 -> Model 3 is better

# AUC test (higher better)
library(ROCR)
predrocr2 <- prediction(pred2, test$resp)
auc2 <- performance(predrocr2, measure="auc") @ y.values
predrocr3 <- prediction(pred3, test$resp)
auc3 <- performance(predrocr3, measure="auc") @ y.values

auc2 # 0.829
auc3 # 0.782
# Since auc2 > auc3, Model 2 is preferred

totalprofit = -300 * 35 + 100 * 157 # 5,200

# Sort the predicted probability from high to low
sortpred2 <- sort(pred2, decreasing=TRUE)
(sortpred2) # Last entry based on probability of good risk = 0.0253 (189)
test[189,] # We see the duration is 36 months

sortpred2 <- sort(pred2, decreasing=TRUE, index.return=TRUE)
# sortpred2$x: sorted values, sortpred2$ix: indices of sorted values

test$resp[sortpred2$ix]
# Profit per person +100 if it is 1 and we predicted 1, -300 if it is 0 and we predicted 1
profitpred2 <- 100*(test$resp[sortpred2$ix])-300*(1-test$resp[sortpred2$ix])
# Cumulative sum of profitpred2
totalprofit <- cumsum(profitpred2)

# Find out which index gives the maximum cumulative profit
which.max(totalprofit) # Index 150
max(totalprofit) # Max Pofit: 7800

sortpred2$x[150] # Cut-off to credit goal (0.7187)
