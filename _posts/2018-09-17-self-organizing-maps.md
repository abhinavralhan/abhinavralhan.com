---
layout: post
title: "Self Organizing Maps"
date: 2018-09-17 12:00:00 +0100
categories: machine-learning neural-networks
medium_url: https://medium.com/@abhinavr8/self-organizing-maps-ff5853a118d4
---

Recently, I learned about SOMs while applying for an internship. I wanted to share this technique as it is very useful for clustering analysis and exploring data.

## What is a Self-Organizing Map?

A **Self-Organizing Map (SOM)**, also known as a Kohonen Map, is a type of artificial neural network (ANN) that is trained using unsupervised learning to produce a low-dimensional (typically two-dimensional) representation of the input space of the training samples, called a map. It is therefore a method for **dimensionality reduction**.

Self-organizing maps differ from other artificial neural networks in two key ways:

1. They apply **competitive learning** as opposed to error-correction learning (such as backpropagation with gradient descent)
2. They use a **neighborhood function** to preserve the topological properties of the input space

## How Does It Work?

SOM mapping starts by initializing weight vectors. Here's the basic process:

1. **Initialize** - Set up the map with random weight vectors
2. **Select Sample** - A sample vector is selected randomly from the training data
3. **Find Best Match** - The map is searched to find the weight vector most similar to the input (called the Best Matching Unit or BMU)
4. **Update Weights** - The BMU is rewarded by becoming more like the sample, and its neighbors are also similarly rewarded
5. **Repeat** - Continue until convergence

The key insight is that neighboring nodes in the map will learn to represent similar patterns from the input space, preserving the topology of the data.

## Network Structure

Most generally, SOMs form square, rectangular, hexagonal, or L shapes in 2D feature space. The choice of topology affects how neighborhoods are defined and how the map learns to represent the input space.

## Example: Iris Dataset

Let me demonstrate SOMs using the classic Iris dataset. In the visualization:

- **Darker parts** represent clusters
- **Lighter parts** represent the division between clusters
- Different colors represent different Iris species:
  - Red Circles: Iris-setosa
  - Green: Iris-versicolor
  - Blue: Iris-virginica

The SOM successfully separates the three species, with Iris-setosa clearly distinct from the other two species, while Iris-versicolor and Iris-virginica show some overlap (as they do in the actual data).

## Python Implementation

Here's a basic implementation using the MiniSom library:

```python
from minisom import MiniSom
import numpy as np
from sklearn.datasets import load_iris
from sklearn.preprocessing import MinMaxScaler

# Load and normalize data
iris = load_iris()
X = iris.data
scaler = MinMaxScaler()
X_scaled = scaler.fit_transform(X)

# Initialize and train SOM
som = MiniSom(x=10, y=10, input_len=4, sigma=1.0, learning_rate=0.5)
som.random_weights_init(X_scaled)
som.train_random(X_scaled, num_iteration=1000)

# Get cluster assignments
winner_coordinates = np.array([som.winner(x) for x in X_scaled])
```

## Limitations

While SOMs are powerful, they have some limitations:

- **No generative model** - The model does not understand how data is created, it only learns to represent it
- **Categorical data issues** - It does not behave well with categorical data, and performs even worse with mixed data types
- **Fixed topology** - The map size and shape must be chosen beforehand
- **Computational cost** - Training can be slow for large datasets

## When to Use SOMs

SOMs are particularly useful for:

- **Exploratory data analysis** - Visualizing high-dimensional data
- **Clustering** - Finding natural groupings in data
- **Feature extraction** - Creating new representations
- **Anomaly detection** - Identifying outliers as points far from any cluster

## Conclusion

Self-Organizing Maps provide an intuitive way to visualize and cluster high-dimensional data. While they have limitations with categorical data, they remain a valuable tool for exploratory analysis and understanding the structure of your data.

