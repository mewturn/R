## Practice 3: Parole.csv
## Logistic Regression

str(Parole) #675 observations

table(Parole$Violator) #Non-violation: 597, Violation: 78

# Seeding and syncing
set.seed(144)
library(caTools)
split <- sample.split(Parole$Violator, SplitRatio=0.7) #70% TRUE, 30% FALSE
train <- subset(Parole, split==TRUE)
test <- subset(Parole, split==FALSE)

# Log Regression Model with all the variables used to predict 'Violator'
model1 <- glm(Violator~., data=train, family=binomial)
summary(model1)
# Significant variables: RaceWhite, StateLouisiana, StateVirginia, MaxSentence, MultipleOffenses
# B(MultipleOffenses) = 1.61 -> Odds = e^(B*MultipleOffenses)
# Odds of the given individual being a Parole Violator:
# exp(-2.03+0.38(Male)-0.88(White)-0.00017(Age)-0.12(TimeServed)+0.08(MaxSentence)+1.66(MultipleOffenses)+0.695(Larceny))

# Calculating the logodds
logodds <- model1$coefficients[1] + model1$coefficients[2] * 1 + model1$coefficients[3] * 1 + model1$coefficients[4] * 50 + model1$coefficients[8] * 3 + model1$coefficients[9] * 12 + model1$coefficients * 0 + model1$coefficients[12] * 1
odds <- exp(logodds)
# logodds = -1.257; odds = 0.2844

pred = predict(model1, newdata=test, type="response")
max(pred) # maximum predicted probability of violation = 0.907

# LEFT: PREDICTED, TOP: ACTUAL
table(as.integer(pred>0.5),test$Violator)

# Sensitivity = TPR = TP / (TP + FP)
sensitivity = 12 / (11 + 12) # 0.521

# Specificity = TNR = TN / (TN + FN)
specificity = 167 / (167 + 12) # 0.932

# Accuracy = TP + TN / Total
accuracy = (167 + 12) / (167 + 12 + 11 + 12) # 0.886

# Accuracy if we predict every parolee is a non-violator
table(as.integer(pred>1),test$Violator)
accuracy_nv = 179 / (179 + 23) # 0.886 -> same as the previous model

# Since false negatives (predicting that the parolee will not violate when he does) are a worry, thus a lower threshold than 0.5 is used
# Even though the model has the same accuracy, the baseline model produces more false negatives. With a cut-off of less than 0.5, the model will be more accurate than the baseline model.

library(ROCR)
predrocr <- prediction(pred, test$Violator)
auc <- performance(predrocr, measure="auc") @ y.values # auc = 0.894
# AUC can be interpreted as the probability that the model can differentiate between a randomly-selected parole violator and a parole non-violator (>0.5 is good, since 0.5 is random guessing)


