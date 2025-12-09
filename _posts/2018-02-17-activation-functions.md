---
layout: post
title: "Activation Functions: Neural Networks"
date: 2018-02-17 12:00:00 +0100
categories: machine-learning neural-networks deep-learning
medium_url: https://medium.com/@abhinavr8/activation-functions-neural-networks-66220238e1ff
---

Understanding activation functions is fundamental to working with neural networks. This post covers what they are, why we need them, and the most common types you'll encounter.

## What is an Activation Function?

In computational networks, the **activation function** of a node defines the output of that node given an input or set of inputs. It determines whether a neuron should be activated or not based on the weighted sum of inputs.

## Why Do We Need Activation Functions?

It is necessary to use an activation function because **without it, the Neural Network would be just a linear regression model**.

The activation function performs the non-linear transformation to the input, making the network capable of learning and performing more complex tasks. Without non-linearity, no matter how many layers you stack, the network would behave like a single-layer perceptron.

## Types of Activation Functions

### Sigmoid Function

The sigmoid function is one of the most well-known activation functions:

$$\sigma(x) = \frac{1}{1 + e^{-x}}$$

**Properties:**
- Output range: (0, 1)
- S-shaped (sigmoidal) curve
- Real-valued and differentiable
- Non-negative first derivative (bell-shaped)

**Pros:**
- Smooth gradient
- Output values bound between 0 and 1
- Clear predictions (values close to 0 or 1)

**Cons:**
- Vanishing gradient problem for very high or low input values
- Outputs not zero-centered
- Computationally expensive (exponential function)

```python
import numpy as np

def sigmoid(x):
    return 1 / (1 + np.exp(-x))
```

### Tanh (Hyperbolic Tangent)

The tanh function is similar to sigmoid but with a different range:

$$\tanh(x) = \frac{e^x - e^{-x}}{e^x + e^{-x}}$$

**Properties:**
- Output range: (-1, 1)
- Also sigmoidal (S-shaped)
- Zero-centered output

**Pros:**
- Zero-centered (makes optimization easier)
- Stronger gradients than sigmoid

**Cons:**
- Still suffers from vanishing gradient problem

```python
def tanh(x):
    return np.tanh(x)
```

### ReLU (Rectified Linear Unit)

The rectifier is defined as the positive part of its argument:

$$f(x) = \max(0, x)$$

ReLU was the **most popular activation function for deep neural networks** in 2018 and continues to be widely used.

**Properties:**
- Output range: [0, ∞)
- Non-saturating for positive values
- Computationally efficient

**Pros:**
- Solves vanishing gradient problem (for positive values)
- Computationally efficient
- Converges faster than sigmoid/tanh

**Cons:**
- Dying ReLU problem (neurons can become inactive)
- Not zero-centered

```python
def relu(x):
    return np.maximum(0, x)
```

### ReLU Variants

There are several variations of ReLU to address its limitations:

**Leaky ReLU:**
$$f(x) = \max(\alpha x, x)$$

Where α is a small constant (typically 0.01). This prevents the dying ReLU problem.

```python
def leaky_relu(x, alpha=0.01):
    return np.where(x > 0, x, alpha * x)
```

**Parametric ReLU (PReLU):**
Similar to Leaky ReLU, but α is learned during training.

**Exponential Linear Unit (ELU):**
$$f(x) = \begin{cases} x & \text{if } x > 0 \\ \alpha(e^x - 1) & \text{if } x \leq 0 \end{cases}$$

### Softplus

The softplus function is a smooth approximation to ReLU:

$$f(x) = \ln(1 + e^x)$$

**Properties:**
- Output range: (0, ∞)
- Smooth and differentiable everywhere

The derivative of softplus is:

$$f'(x) = \frac{e^x}{1 + e^x} = \frac{1}{1 + e^{-x}}$$

This is actually the **logistic (sigmoid) function**!

```python
def softplus(x):
    return np.log(1 + np.exp(x))
```

## Choosing an Activation Function

Here are some guidelines:

| Layer Type | Recommended Activation |
|------------|----------------------|
| Hidden layers | ReLU or variants |
| Binary classification output | Sigmoid |
| Multi-class classification output | Softmax |
| Regression output | Linear (no activation) |

## Summary

| Function | Range | Use Case |
|----------|-------|----------|
| Sigmoid | (0, 1) | Binary classification, gates |
| Tanh | (-1, 1) | Hidden layers, RNNs |
| ReLU | [0, ∞) | Hidden layers in deep networks |
| Leaky ReLU | (-∞, ∞) | Hidden layers (prevents dying ReLU) |
| Softplus | (0, ∞) | Smooth alternative to ReLU |

## Conclusion

Activation functions are essential components that introduce non-linearity into neural networks. While ReLU and its variants are currently the most popular choices for hidden layers, understanding the properties of each function helps in making informed architectural decisions for your specific use case.
