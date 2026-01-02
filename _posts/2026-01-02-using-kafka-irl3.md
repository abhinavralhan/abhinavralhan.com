---
layout: post
title: "Using Kafka in the real world (3/n) - Partition Keys"
date: 2026-01-02 12:00:00 +0100
categories: event streaming, kafka
medium_url: 
---

This post is a summary of my experience using Kafka in a production environment. I will share my insights on how Kafka can be used to build scalable and resilient systems, as well as the challenges and lessons learned along the way.

## Partition Key Selection - The Art of Data Distribution

#### Illusion of simplicity

Using random or UUID-based keys is often appealing. Kafka distributes records evenly across partitions, producers achieve high throughput, and no single partition becomes a hotspot.

Kafka only guarantees ordering within a partition. With random keys, ordering is effectively lost for any logical entity.

This becomes noticeable when:
- replaying events for a single user or order
- debugging state inconsistencies
- reconstructing timelines during incident analysis

Random keys work well for metrics, logs, or telemetry—cases where events are independent and ordering is irrelevant. They are far less suitable for domain events.

#### userId Partition key trap

A common alternative is to key records by userId.

> ProducerRecord<String, Event> record =
    new ProducerRecord<>("events", userId, event);

This provides strict ordering per user, which simplifies downstream processing. However, real-world traffic is rarely uniform. A small subset of users often generates a disproportionate amount of traffic. This often results in an imbalance between the number of messages in the partitions.

From Kafka’s perspective, the cluster may appear healthy, but consumers assigned to the hot partition fall behind. Latency increases for a subset of users while others remain unaffected.

A more reliable approach is to start by identifying which guarantees are actually required.

- No ordering required → null key / round-robin.
- Strict ordering per entity → business key
- Partial ordering with better distribution → composite or hashed keys

Kafka makes no attempt to rebalance load dynamically across partitions. Once a key maps to a partition, it stays there. This makes key choice especially important.

#### Composite keys: Balancing Order and Distribution

Composite keys are a practical compromise usually done by combining multiple attributes, and this way load can be spread more evenly without abandoning meaningful ordering.

> String key = tenantId + ":" + userId;
> ProducerRecord<String, Event> record =
    new ProducerRecord<>("events", key, event);

This approach works well in multi-tenant systems, where a small number of tenants might otherwise dominate traffic.

#### Hash-Based Key Bucketing

For higher-throughput systems, introducing controlled key bucketing can significantly improve partition balance.
A common pattern is to hash a business identifier into a fixed number of buckets:

> int bucket = Math.abs(userId.hashCode()) % 10;
> String key = bucket + ":" + userId;

This preserves the ordering within a bucketed subset of the entity and offers a significantly more predictable partition assignment.

This technique proved effective in an e-commerce system where a small number of users generated extreme write volumes. Adding bucketed hashing reduced consumer lag and stabilized processing without changing the topic’s partition count.

#### Observability

Partition key design should always be paired with targeted monitoring. Aggregate metrics often hide real problems.

Useful Kafka metrics include - records per partition, consumer lag per partition and per-partition processing time. Of course, observability is optional but I'd argue that it's essential. Without per-partition visibility, this type of imbalance can persist unnoticed.

The goal of partition key selection is to understand clearly the guarantees you are trading off and monitor partitions closely enough to detect imbalance early. The best partitioning strategies are rarely perfect, but they can be observed, adjusted and modified to the needs of the system.
