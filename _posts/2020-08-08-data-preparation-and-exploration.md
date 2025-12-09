---
layout: post
title: "Data Preparation and Exploration"
date: 2020-08-08 10:00:00 +0100
categories: data-science python analytics
medium_url: https://medium.com/@abhinavr8/data-preparation-and-exploration-5e09b92cf00e
---

This is a blog for people new to Data Science. Understanding data preparation and exploration is fundamental before diving into any modeling or analysis.

## What is Data Preparation and Exploration?

Data preparation and exploration encompasses several key activities:

- **Exploratory analysis** - Understanding your data
- **Noise removal** - Cleaning unwanted variations
- **Missing value treatment** - Handling incomplete data
- **Identifying outliers** - Finding anomalous values
- **Correcting data inconsistencies** - Fixing errors and standardizing formats

These steps are crucial because the quality of your analysis is only as good as the quality of your data.

## Exploratory Data Analysis (EDA)

**EDA** is used to understand, summarize, and analyze the contents of a dataset. It's typically used to:

- Investigate a specific question
- Prepare for more advanced modeling
- Identify patterns and anomalies
- Test hypotheses
- Check assumptions

### Key EDA Techniques

```python
import pandas as pd
import numpy as np

# Load data
df = pd.read_csv('data.csv')

# Basic information
print(df.shape)           # Dimensions
print(df.info())          # Data types and null counts
print(df.describe())      # Statistical summary
print(df.head())          # First few rows
```

## Univariate Analysis

Univariate analysis examines each variable individually.

### For Continuous Variables

Key statistics to calculate:

- **Mean** - Average value
- **Median** - Middle value
- **Mode** - Most frequent value
- **Min/Max** - Range boundaries
- **Standard deviation** - Spread of data

```python
# Continuous variable analysis
print(df['column'].mean())
print(df['column'].median())
print(df['column'].std())
print(df['column'].min(), df['column'].max())

# Visualization
import matplotlib.pyplot as plt
df['column'].hist(bins=30)
plt.show()
```

### For Categorical Variables

**Frequency tables** are used to understand the distribution of each category:

```python
# Categorical variable analysis
print(df['category'].value_counts())
print(df['category'].value_counts(normalize=True))  # Percentages

# Visualization
df['category'].value_counts().plot(kind='bar')
plt.show()
```

## Bivariate Analysis

Bivariate analysis examines relationships between two variables.

### Two Continuous Variables

When analyzing two continuous variables:

- **Scatter plots** are used to visualize the relationship
- **Correlation** measures the strength of the relationship

Correlation values range from **-1 to +1**:
- **+1**: Perfect positive correlation
- **0**: No correlation
- **-1**: Perfect negative correlation

```python
import seaborn as sns

# Scatter plot
plt.scatter(df['var1'], df['var2'])
plt.xlabel('Variable 1')
plt.ylabel('Variable 2')
plt.show()

# Correlation
print(df['var1'].corr(df['var2']))

# Correlation matrix
print(df.corr())

# Heatmap
sns.heatmap(df.corr(), annot=True, cmap='coolwarm')
plt.show()
```

### Continuous and Categorical Variables

Use box plots or violin plots to compare distributions across categories:

```python
# Box plot
sns.boxplot(x='category', y='continuous_var', data=df)
plt.show()

# Violin plot
sns.violinplot(x='category', y='continuous_var', data=df)
plt.show()
```

## Data Smoothing

When data collected over time displays random variation, **data smoothing techniques** can be used to reduce or cancel the effect of these variations.

When properly applied, these techniques smooth out the random variation in time series data to reveal underlying trends.

### Common Smoothing Techniques

**Moving Average:**
```python
# Simple moving average
df['smoothed'] = df['value'].rolling(window=7).mean()
```

**Exponential Smoothing:**
```python
from statsmodels.tsa.holtwinters import SimpleExpSmoothing

model = SimpleExpSmoothing(df['value'])
fitted = model.fit(smoothing_level=0.2)
df['smoothed'] = fitted.fittedvalues
```

## Handling Missing Values

Missing data is common and needs to be addressed:

```python
# Identify missing values
print(df.isnull().sum())

# Percentage missing
print(df.isnull().sum() / len(df) * 100)

# Options for handling:
# 1. Drop rows
df_clean = df.dropna()

# 2. Fill with mean/median/mode
df['column'].fillna(df['column'].mean(), inplace=True)

# 3. Forward/backward fill (for time series)
df['column'].fillna(method='ffill', inplace=True)
```

## Identifying Outliers

Outliers can significantly impact analysis. Common detection methods:

### IQR Method

```python
Q1 = df['column'].quantile(0.25)
Q3 = df['column'].quantile(0.75)
IQR = Q3 - Q1

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR

outliers = df[(df['column'] < lower_bound) | (df['column'] > upper_bound)]
```

### Z-Score Method

```python
from scipy import stats

z_scores = np.abs(stats.zscore(df['column']))
outliers = df[z_scores > 3]
```

## Summary

Data preparation and exploration is not glamorous, but it's where data scientists spend most of their time. A thorough EDA helps you:

1. Understand your data deeply
2. Identify quality issues early
3. Make informed modeling decisions
4. Avoid garbage-in, garbage-out scenarios

Remember: **well-prepared data leads to better models and more reliable insights**.
