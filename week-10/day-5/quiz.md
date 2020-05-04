# Homework Quiz

## Question 1
> I want to predict how well 6 year-olds are going to do in their final school exams. Using the following variables am I likely under-fitting, fitting well or over-fitting? Postcode, gender, reading level, score in maths test, date of birth, family income.

Likely over-fitting. Date of birth is clearly an unnecessary variable.

Due to socio-economic factors, a fair argument can be made that postcode, gender, and family income would influence education outcomes. However, postcode and family income are very likely to both indicate the same thing -- economic status -- and family income is the better indicator of the two.

A better model would include reading level, maths scores, gender, and family income.

## Question 2
> If I have two models, one with an AIC score of 34,902 and the other with an AIC score of 33,559 which model should I use?

The second model. For AIC scores (and BIC scores), lower numbers indicate a better fit.

## Question 3
> I have two models, the first with: r-squared: 0.44, adjusted r-squared: 0.43. The second with: r-squared: 0.47, adjusted r-squared: 0.41. Which one should I use?

The first model, in the absence of any other information about either model.

The first model has a lower r-squared value, and a higher adjusted r-squared value. For both normal and adjusted r-squared values, larger values indicate a better fit. However, the adjusted r-squared value favours a smaller model and mitigates the risk of over-fitting.

By the principle of parsimony, the first model is preferred.

## Question 4
> I have a model with the following errors: RMSE error on test set: 10.3, RMSE error on training data: 10.4. Do you think this model is over-fitting?

It is likely that the model is over- or (less likely) under-fitting.

The error is higher when predicting on the training data. Instead, we would expect the error to be higher when predicting on test set, because the test set is a small subset of the data set.

## Question 5
> How does k-fold validation work?

- Split the data set into k folds (subsets);
- For each fold k_n, make a model;
- For each model, train on all of the remaining data and test on k_n;
- Calculate the average error across all folds.

*Example:*  For 10-fold validation: train 10 models, each one training on 9 folds, and testing on 1 fold.

## Question 6
> What is a validation set? When do you need one?

A set that is used to validate a model's accuracy. It is not used to either test or train data.

## Question 7
> Describe how backwards selection works.

## Question 8
> Describe how best subset selection works.

## Question 9
> It is estimated on 5% of model projects end up being deployed. What actions can you take to maximise the likelihood of your model being deployed?

## Question 10
> What metric could you use to confirm that the recent population is similar to the development population?

## Question 11
> How is the Population Stability Index defined? What does this mean in words?

## Question 12
> Above what PSI value might we need to start to consider rebuilding or recalibrating the model?

## Question 13
> What are the common errors that can crop up when implementing a model?

## Question 14
> After performance monitoring, if we find that the discrimination is still satisfactory but the accuracy has deteriorated, what is the recommended action?

## Question 15
> Why is it important to have a unique model identifier for each model?

## Question 16
> Why is it important to document the modelling rationale and approach?
