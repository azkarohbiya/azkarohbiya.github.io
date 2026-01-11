---
title: "Propensity Score Matching"
highlight: true
date : "2025-12-01"
result: "Improved Above-the-Line (ATL) campaign measurement, identifying approximately ~$300K/month at-risk-revenue."
summary: "The method is a brach of causal models, improving clarity in impact measurement for non-control experiments, by making artificial apple-to-apple comparable groups."
weight: 2
showTableOfContents: true
---

{{< alert >}}
**Note** To keep it confidential, all company-specific metrics has been replaced by public dataset. 
{{< /alert >}}

## ❓ What does it matter?

### 📢 Understanding the scenario 

It's commonly believed that smoking increases the risk of stroke, yet it requires futher observation to validate the assumption. One of the most trusted ways to understand this phenomenon by using AB testing experiment, splitting a group to target subgroup, who is allowed to smoke, and the control one who isn't, then comparing them afterward. On the other hand, doing such an experiment can be hardly executed due to ethical reasons. Likewise, a similar challenge also happens to the other sector like marketing, the field where I'm working. Consequently, measuring the existing data, comparing smokers and non-smokers, is an effective option to answer the hypothesis.

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

## 💡 Insight Explaination

### 🔢 The data

From the data, there are three terminologies that are important to remember, consisiting of feature, treatment, and outcome. The following table are the explanation of terminologies and description that are going to be discuss.

| Terminology          | Description                                                       | Fields                                                                             |
|----------------------|-------------------------------------------------------------------|------------------------------------------------------------------------------------|
| Features/Confounders | Possible causes that might influence the outcome                  | hypertension, gender, heart_disease, bmi (body mass index), avg_glucose_level, age |
| Treatment            | The variable that indicates the indvidual has been treated or not | smoking status                                                                     |
| Outcome              | The result that we want to observe                                | stroke                                                                             |


### 🖥️ Matching


![image](screenshot_20260103_at_195341.png)

Before applying the algorithm, the data shows that both smokers and non-smokers have different profile. One of the noticable one is that the total of non-smokers are far larger than the smokers. Again, the distribution of all confounders are different, heart disease status for example, that there are 18.9% of smokers out of total heart disease sufferers, meanwhile in negative group, the smokers only makes 15.1%. The imbalance might interfere the conclusion because smokers group mostly suffering heart disease.

![image](screenshot_20260103_at_195351.png)

Compared to data after matching process, the distribution of smokers and non-smokers are similar almost in every feature. For example, in hypertension, the ratio of smokers and non-smokers in the positive hypertension group is 50:50, and so the negative one is. As a result, measuring stroke status between the two groups can be much more reliable as both have already similar.

### 🔎 Evaluation

![image](screenshot_20260103_at_145324.png)

To support distribution analysis, Standard Mean Difference ([SMD](https://onlinelibrary.wiley.com/doi/10.1002/cesm.12047)) is used as the indicators whether two values of distribution are similar or not. In simple explanation, smaller SMD value means that two groups are in common. 

According to the experiment, there are four confounders (hypertension, age, bmi, and heart_disease) decreasing SMD values, meaning that those features are getting similar after calculation. Despite an increase of glucose level and gender, this is still acceptable as only 2 out of 6 features which only experienced this.

The result shows that 5.3% of smoking group suffers stroke. Before matching, non-smoker group accounted for 4.8%, making 0.5% difference of percentage point with smoking group. In fact, post calculation reveals that the difference of percentage points are larger, around 1.4 percentage points, meaning that smokers are more riskier to suffer stroke

## ⛳️ Further Development

In the theory of causal model, more common term to evaluate result is [ATT](https://causalwizard.app/inference/article/att) (average treatment on treated). This involves further model, instead of directly comparing the treated group with the synthetic one. The actual algorithm has already covered this, yet discussing the usage will be discussed later article.
