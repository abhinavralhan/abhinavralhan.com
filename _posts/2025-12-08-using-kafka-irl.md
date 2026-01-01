---
layout: post
title: "Using Kafka in the real world (1/n) - Partitions"
date: 2025-12-08 12:00:00 +0100
categories: event streaming, kafka
medium_url: 
---

This post is a summary of my experience using Kafka in a production environment. I will share my insights on how Kafka can be used to build scalable and resilient systems, as well as the challenges and lessons learned along the way.


## Another Kafka article series? 
It's probably not necessary for the masses but I'd like to journal it for myself and if it helps others, I'm glad. Not many on the internet talk about the *real* problems of Data engineering, let alone Kafka (which is usually considered a less of a pain in the ass). In this article and few more which will come soon, I will write about the topics which have been relevant to me in the past!

### Who should read this? 
If you're a developer setting it up for your company and learning on the go.

### Real-world context setting
For us, the end goal was to provide the product + analytics team with the best quality (read as clean, non-missing, non-duplicated) data.

# Partitions

[From Cloudera](https://docs.cloudera.com/runtime/7.3.1/kafka-performance-tuning/topics/kafka-tune-sizing-partition-number.html):

> Unnecessary partitions put extra pressure on ZooKeeper (more network requests), and might introduce delay in controller and/or partition leader election if a broker goes down.
Producer and consumer clients need more memory, because they need to keep track of more partitions and also buffer data for all partitions.

## Our Context:

LLM's will probably suggest you a formula to calculate the number of partitions you need based on your existing and target throughput.


A common issue with setting up partitioning is that people always decide to start with 1 partition but it almost always needs to scale more. A lot of these decisions require a lot of context (how fast you need to process data, how much data do you have, and so on), so you should probably think twice before locking in.

Finally, I must also add that when you increase partitions, existing messages stay in old partitions but only new messages use the new ones, breaking ordering guarantees and creating uneven distribution. However, technically it is kind of easy to increase the partitions. On the other hand, decreasing partitions is impossible; you must create a new topic and migrate all data manually. (please don't do this unless necessary)

Feel free to hit me up with more info if you would like to add :)
