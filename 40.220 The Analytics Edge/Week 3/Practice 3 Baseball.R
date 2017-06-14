## Practice 3: baseballlarge.csv
## Logistic Regression

table(baseballlarge$Year)
# Missing years: 1972, 1981, 1994, 1995
length(baseballlarge$Year) #1232 observations

baseballlarge <- subset(baseballlarge, Playoffs==1)
str(baseballlarge) #244 observations

table(table(baseballlarge$Year))
#Teams: 2  4  8  10
#Years: 7  23 16 1

# Create a new variable NumCompetitors and fill in the number of competitors from the table["Year"]
baseballlarge$NumCompetitors <- table(baseballlarge$Year)[as.character(baseballlarge$Year)]
table(baseballlarge$NumCompetitors)

# Create a new variable WorldSeries and put 1 if RankPlayoffs = 1 and put 0 otherwise
baseballlarge$WorldSeries <- as.integer(baseballlarge$RankPlayoffs==1)
table(baseballlarge$WorldSeries)
# 197 teams did not win the World Series

## Use simple logistic regression (one variable) to find out if a variable is significant (p-value < 0.05)
## Then, put the significant variables into a single multiple regression model (like the one below)
modelcombined <- glm(WorldSeries~Year+RA+RankSeason+NumCompetitors, data=baseballlarge, family=binomial)
summary(modelcombined)
# In the new multi-variate model, none of the variables are significant

cor(baseballlarge[,c("Year","RA","RankSeason","NumCompetitors")])
# Year and NumCompetitors have high correlation
model1 <- glm(WorldSeries~Year+RA, data=baseballlarge, family=binomial)
model2 <- glm(WorldSeries~Year+RankSeason, data=baseballlarge, family=binomial)
model3 <- glm(WorldSeries~Year+NumCompetitors, data=baseballlarge, family=binomial)
model4 <- glm(WorldSeries~RA+RankSeason, data=baseballlarge, family=binomial)
model5 <- glm(WorldSeries~RA+NumCompetitors, data=baseballlarge, family=binomial)
model6 <- glm(WorldSeries~RankSeason+NumCompetitors, data=baseballlarge, family=binomial)
summary(model1) #AIC: 233.88
summary(model2) #AIC: 233.55
summary(model3) #AIC: 232.9
summary(model4) #AIC: 238.22
summary(model5) #AIC: 232.74
summary(model6) #AIC: 232.52
# Find the smallest AIC value = best
# Overall it seems that winning the playoffs has other variables not captured in the data set (e.g. luck)
