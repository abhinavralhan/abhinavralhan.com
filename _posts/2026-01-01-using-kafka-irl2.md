---
layout: post
title: "Using Kafka in the real world (2/n) - Deduplication"
date: 2026-01-01 12:00:00 +0100
categories: event streaming, kafka
medium_url: 
---

This post is a summary of my experience using Kafka in a production environment. I will share my insights on how Kafka can be used to build scalable and resilient systems, as well as the challenges and lessons learned along the way.


## Deduplication and Quality of Data

#### Our (quite common) context:

We wanted to solve for duplication of data flowing in from several sources / applications into Kafka. Since, we don't work on the application side - we have very little control on it.
Our ETL consisted of Kafka - Python ETL Microservice - Database (Clickhouse).

#### What is hurting us?

We could see that over time and over several releases and newer topics, as a team we have reached a stage in our lifecycle where some Kafka topics and/or applications have started sending us duplicate messages. This naturally wasn't in an agreement with the contract we had decided on earlier with the Application engineers.
Duplicates varied by application but could vary anywhere between 1% by id to 0.001% row level duplicates.

#### Steps:

- Investigate the severity and it's downstream impact of duplicates present in tables and reports.

- Conduct RCA on what is causing it and when?

- Follow a general framework to keep duplicates at bay. Identify solutions for those specific particular problems where no duplicates can be entertained since the data is of the highest importance and also required in real-time for further decision making.

#### Framework: 

- Idempotency in ETL processing:
Usually, the Consumer spits out messages in batches and needs to be dealt with care. Deduping messsages with the help of Redis is an option and using (generated) deterministic hashes to clean up.
Moreover, ensure that you only write each batch of the data to the database with only the non duplicated data.

- Kafka level:
Setting up Consumer with enable.auto.commit=false is also another important option to enable use exactly once semantics. 

- Database level Deduplication:
Depending on your database, you should add a layer(s) of deduplication logic to your tables. Clickhouse allows for ReplacingMergeTree - which ensures automatic deduplication but a non deterministic table. You can also use Materialized Views with dedup logic.

- Alerting:
On top of this, I would *strongly* suggest you to add alerting to ensure an alerting mechanism to assess duplicated rows in the last hour per table. This would solve for any buggy deployments or new topics which you don't want to deal with immediately but is still good to know and be alert.
