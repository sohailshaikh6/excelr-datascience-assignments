claimants = read.csv("E:/Excelr Data/Data Sets/Simple Logistic Regression/claimants.csv")

summary(claimants)
str(claimants)
summary(claimants)
attach(claimants)

summary(as.factor(claimants$ATTORNEY))

# Logistic Regression

logit=glm(ATTORNEY ~ factor(CLMSEX) + factor(CLMINSUR) + factor(SEATBELT) 
          + CLMAGE + LOSS,family= "binomial",data=claimants)
summary(logit)


# Odds Ratio


# Confusion Matrix Table

prob=predict(logit,type=c("response"),claimants)
prob

confusion<-table(prob>0.5,claimants$ATTORNEY)
confusion


# Model Accuracy

Accuracy<-sum(diag(confusion))/sum(confusion)
Accuracy
