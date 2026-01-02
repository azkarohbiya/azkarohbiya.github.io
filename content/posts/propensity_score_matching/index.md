---
title: "Propensity Score Matching"
highlight: true
date : "2023-12-01"
result: "Think the impact"
summary: "The algorithm that helps to find artificial control group for apple-to-apple comparison, avoiding bias in measurement impacts"
weight: 3
showTableOfContents: true
---

## ❓ What does it matter?

### 📢 Understanding the scenario 

It's commonly believed that smoking increases the risk of stroke, yet it requires futher observastion to validate the assumption. One of the most trusted ways to understand this phenomenon by using AB testing experiment, splitting a group to target subgroup, who is allowed to smoke, and the control one who isn't, then comparing them afterwards. On the other hand, doing such an experiment can be hardly executed due to ethical reasons. Likewise, a similar challenge also happens to the other sector like marketing, the field where I'm working. Consequently, measuring the existing data, comparing smokers and non-smokers, is an effective option to answer the hypothesis.

### 📉 The bias comes here

Here is the twist, after learning the two groups (the smokers and those who don't), we found that the two have different physical condition such as age, weight, and other status. As a result, comparing stroke status of both groups can be bias since those difference could interfere the output

### 🎯 The solution

To resolve the issue, propensity matching score, as a part of causal approach, can be implemented to match the available data of the two in the same profile, ensuring the making the decision based on apple-to-apple comparison.

## 🧮 Into Matching Algorithm

### 🤖 A brief of algorithm

The main calculation is finding every smoker's pair. This looks easy until so many features we have to involve in the calculation. This is very similar in seeking a couple, which is getting more complex to match all the criteria. To address this, probability score of logistic regression is used, representing all features, than finding the pair using neighbor algorithm. For your information, I used sklearn neigbor finder to solve computational issues, as this is compatible for handling large amount of data.   

### ⬆️ the Improvement

When it comes to big data, calculating propensity score matching requires so much computational process, as the algorithm involves combination. That's the reason why my team designed our own algorithm, despite the availibility out there. The algorithm we made approximately can handle around ~10 millions. According to my experience, it took minutes to complete calculation using M1 apple sillicon. So, it eventually depends on the computing power.

For detail explanation about technical details, including how to use my library and to call the syntax, please refer to my github:

{{< button href="https://github.com/azkarohbiya/Propensity-Score-Matching" target="_blank" >}}
View on GitHub
{{< /button >}}

To find out more about the algorithm, you better watch this youtube video:
{{< youtube ACVyPp1Fy6Y >}}

## Insight Explaination

### The data

Explain about the feature,
Treatment,
and Outcome
Add a table here to tell a lil bit about the data

### Matching


![image](screenshot_20260102_at_200546.png)
![image](screenshot_20260102_at_200554.png)


### Evaluation

Microsoft
Big data
