---
date : '2025-12-26T17:16:04+07:00'
draft : false
title : 'Sequential Recommender System'
description : ""
highlight: true
result: "Growing the digital revenue around 150% percent"
summary: "This model was used to enhance collaborative filtering approach, offering digital subscription products. The model was able to introduce niche and seasonal products, which are more personalized"
weight : 1
showTableOfContents: true
---


## TL;DR
A sequential recommender predicts what someone is likely to buy **next** based on the **order** of their past purchases. In this article, we model product-to-product transitions as a directed graph and use it to generate practical “next best offer” suggestions.

## Why sequential recommendations matter
Most recommenders answer: *“What do similar users like?”* Sequential recommenders answer: *“What does this user likely want **next**?”*

### The revenue gap after a purchase
A purchase isn’t the finish line—it’s the moment a customer is most “convertible.” The question is: **what’s the most natural next product to offer without being spammy?**

### The invisible pattern: products come in sequences
Some purchases are lonely. Others are basically a two-part sentence.
- Phone → case / screen protector
- Printer → ink / paper
- Running shoes → socks / hydration belt

Those follow-up items are not random—they’re **sequence-driven**.

## The approach: treat purchases like a graph
We’ll represent “people buy X then Y” as a **directed graph**.
- **Node** = a product
- **Directed edge** (X → Y) = customers often buy Y after X
- **Edge weight** = how strong the transition is (count, probability, or lift)

### Why use NetworkX?
NetworkX makes it easy to:
- build and query a directed graph (DiGraph)
- compute transition strength and popular next steps
- inspect paths, hubs, and communities
- visualize the network for storytelling and debugging

## Data: what you need (and what you don’t)
You don’t need fancy embeddings to get value here.
Minimum viable dataset:
- `customer_id`
- `product`
- `timestamp` (or transaction order)

### Cleaning and preparing sequences
1. Sort transactions by `customer_id`, then time
2. Keep customers with **2+ purchases** (otherwise there’s no “next”)
3. Create product pairs: (product_t → product_{t+1})

## Build the transition graph
### Step 1 — Count transitions
Count how often each pair (A → B) occurs.

### Step 2 — Convert counts into “strength”
Choose one:
- **Count**: simplest, good baseline
- **Probability** P(B|A): more stable across product popularity
- **Lift**: highlights “surprisingly strong” transitions

### Step 3 — Generate recommendations
For a given product A:
- recommend top-K outbound neighbors (A → *)
- optionally filter by category, price range, or business rules

## Results: turning the graph into a story
### What the network reveals
Examples of insights to describe:
- “attachment” products with many inbound edges (lots of things lead to them)
- “gateway” products with many outbound edges (they lead to many next buys)
- sequences that look seasonal or event-driven

### Example: what to offer after a product purchase
Show a simple table like:
- Bought: `Printer`
- Next best offers: `Ink`, `Paper`, `USB Cable`
- Strength: probability / lift / count

### Visualization (optional but fun)
Use a graph plot to:
- show the strongest edges only (reduce noise)
- scale node size by degree / sales
- color by category

## How to evaluate it (don’t skip this)
Offline checks:
- Hit Rate@K / Recall@K on held-out next purchases
- Coverage (are we only recommending the same few products?)

Business checks:
- Conversion rate uplift vs baseline
- Revenue per exposure
- Guardrails: unsubscribe rate, complaints, churn signals

## Practical notes and gotchas
- Popular products can dominate counts → consider probability or lift
- Cold start: new products and new users need fallbacks
- Loops happen (A → A). Decide if you keep or remove them
- Time matters: consider time windows (7 days vs 30 days)

## Further improvements
Pick the upgrades that match your complexity budget:
- add edge weights for price/size/validity similarity
- personalize by user segment (separate graphs per cohort)
- incorporate time decay (recent transitions matter more)
- move from graph rules → sequence models (Markov chains, RNN/Transformer-based models)

## Closing
A graph-based sequential recommender is a surprisingly strong baseline: fast to build, easy to explain, and often good enough to drive real conversion improvements—especially when your goal is **“next best offer”** right after purchase.