# Naive Bayes Classifiers

## Also Known As...
Naive Bayes classifiers and models are known under a variety of names throughout statistics and computer science literature. They are most commonly referred to as naive Bayes, simple Bayes, or independence Bayes.

## A Naive Explanation of a Naive Method 
Naive Bayes is an absolute nightmare to explain, but stripped of the mathematical terminology it is arguably the simplest useful machine learning method. It is a simple (hence, naive) classification method based on Bayes rule.

Naive Bayes models consider documents in their most simple form: essentially, a collection of disconnected words, which form a set. The words can then be counted, and conditional probabilities derived.

## Uses of Naive Bayes
- Spam filters
- Sentiment analysis
- Plagiarism identification
- Text categorisation
- ...

## Advantages of Naive Bayes
- Very fast and computationally cheap;
- Highly scalable;
- Can use *any* type of feature, such as email addresses, URLs, or huge text entries;
- Robust -- irrelevant features cancel each other out, risk of "over-fitting" is not a factor;
- Free from the curse of dimensionality;
- Works when many features have equal importance;
  - Decision trees often fail at this point.

All told, naive Bayes is a reliable baseline for text classification.

## Sources Used
- [Stanford University CS124 naive bayes lecture slides](https://web.stanford.edu/class/cs124/lec/naivebayes.pdf) (image source)
- [Wikipedia's naive Bayes classifier entry](https://en.wikipedia.org/wiki/Naive_Bayes_classifier)
- [StatQuest with Josh Starmer: Livestream on Naive Bayes](https://www.youtube.com/watch?v=bTs-QA2oJSE)
