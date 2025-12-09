---
layout: post
title: "Loan Repayment Analysis"
date: 2020-08-08 12:00:00 +0100
categories: data-science machine-learning python
medium_url: https://medium.com/@abhinavr8/loan-repayment-analysis-ca42d94ee840
---

This blog shows how I went about reading, understanding, visualizing a dataset, and applying machine learning algorithms to analyze loan repayment data.

## Tools & Libraries Used

This project uses a Python-based implementation with several key libraries:

- **Pandas** and **NumPy** - Heavily used throughout the project for data manipulation
- **Seaborn** - I tried Seaborn for visualization over Matplotlib for the first time and found it to be a much better experience
- **Scikit-learn** - For machine learning implementation

## The Dataset

The dataset is confidential and cannot be shared, but the Jupyter Notebook with all the analysis is available.

The Loan Dataset contains **6 different DataFrames**:
- Credits
- Cycles
- Failures
- Settlements
- Transactions
- Users

## Exploratory Data Analysis

### Settlement Distribution

Most settlements are centered around the **50,000 mark**, with quite a few outliers present on the upside of 1,00,000. This gives us insight into the typical loan sizes in the portfolio.

### Delay Analysis

One of the key metrics I analyzed was the delay in repayment:

- **Mean delay**: 5 days
- **Standard deviation**: ±9.6 days

This indicates that while most repayments are close to on-time, there's significant variance in the data.

### Merchant Analysis

Looking at the merchant data revealed interesting patterns:

- **Merchants 8 and 6** have a great range of products from cheap to expensive ranges
- The most significant competitors to Merchant 1 are **Merchants 7, 8, 11, and 9**

This kind of analysis helps understand the competitive landscape and product positioning.

### Failure Patterns

Analyzing transaction failures revealed:

- **Failure errors 3 & 2** are observed when transacting big amounts
- **Failure errors 1, 2, 3** are observed more frequently than 4, 5, 6

Understanding failure patterns is crucial for risk assessment and system improvement.

## Data Visualization with Seaborn

This was my first time using Seaborn extensively, and I found it provides:

- Cleaner default styles
- Easier statistical visualizations
- Better integration with Pandas DataFrames
- More intuitive API for common plot types

```python
import seaborn as sns
import matplotlib.pyplot as plt

# Distribution plot
sns.histplot(data=df, x='settlement_amount', kde=True)

# Box plot for outlier detection
sns.boxplot(data=df, x='merchant_id', y='amount')

# Correlation heatmap
sns.heatmap(df.corr(), annot=True, cmap='coolwarm')
```

## Machine Learning Implementation

### Problem Statement

The goal was to predict settlement values expected in the final cycle (22) from users making transactions.

### Model Selection

I used the **Scikit Machine Learning Library** with **RandomForestClassifier**:

```python
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Train model
rf_model = RandomForestClassifier(n_estimators=100, random_state=42)
rf_model.fit(X_train, y_train)

# Predict
predictions = rf_model.predict(X_test)
```

### Feature Importance

Random Forest provides built-in feature importance, helping identify which factors most influence repayment behavior:

```python
feature_importance = pd.DataFrame({
    'feature': X.columns,
    'importance': rf_model.feature_importances_
}).sort_values('importance', ascending=False)
```

## Key Insights

1. **Repayment delays cluster around 5 days** - Most users pay within a week of the due date
2. **Transaction amount affects failure rates** - Larger transactions see specific error types more frequently
3. **Merchant diversity varies significantly** - Some merchants cater to a wide price range while others are more specialized
4. **Predictive modeling is viable** - Machine learning can effectively predict settlement outcomes

## Conclusion

This project demonstrated the full data science workflow from exploration to modeling. The combination of thorough EDA with Seaborn visualizations and predictive modeling with Scikit-learn provided actionable insights into loan repayment patterns.

The Jupyter Notebook containing the complete analysis is available for reference.
