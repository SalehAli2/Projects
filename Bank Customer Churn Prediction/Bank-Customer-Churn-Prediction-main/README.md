

<img width="1279" height="730" alt="Screenshot 2024-10-24 051952" src="https://github.com/user-attachments/assets/fcac9c33-4e8b-4885-a609-c6efe6384a7c" />

# Bank Customer Churn Prediction

## Introduction

Customer churn is a critical issue for banks as it directly affects revenue and growth. In this project, we aim to predict which customers are likely to churn and leave the bank. By identifying high-risk customers, the bank can take proactive measures to reduce churn, improving customer retention, and ultimately, profitability.

### Questions Asked:
1. **What are you trying to solve?**
   - Predict which customers are likely to churn and leave the bank.
   
2. **Why is this problem important?**
   - Customer churn is one of the most common problems in business. Reducing churn helps improve services and save costs.

3. **What specific questions will the project answer?**
   - What makes customers churn, and which factors influence churn?
   - Among the three countries (France, Spain, Germany), which has the highest churn rate?

---

## Dataset Overview

This dataset contains 165,034 customer records with 13 features. It includes both numerical and categorical data on customer demographics, account information, and their churn status.

### Dataset Columns:

| Column           | Description                                                                 |
|------------------|-----------------------------------------------------------------------------|
| Customer ID      | A unique identifier for each customer                                        |
| Surname          | The customer's surname or last name                                          |
| Credit Score     | A numerical value representing the customer's credit score                   |
| Geography        | The country where the customer resides (France, Spain, or Germany)           |
| Gender           | The customer's gender (Male or Female)                                       |
| Age              | The customer's age                                                           |
| Tenure           | The number of years the customer has been with the bank                      |
| Balance          | The customer's account balance                                               |
| NumOfProducts    | The number of bank products the customer uses (e.g., savings, credit card)   |
| HasCrCard        | Whether the customer has a credit card (1 = Yes, 0 = No)                     |
| IsActiveMember   | Whether the customer is an active member (1 = Yes, 0 = No)                   |
| EstimatedSalary  | Estimated salary of the customer                                           |
| Exited           | Whether the customer has churned (1 = Yes, 0 = No)                           |

The dataset was imported from [Kaggle](https://www.kaggle.com/datasets/shubhammeshram579/bank-customer-churn-prediction).

---

## Exploratory Data Analysis (EDA)

### Key Insights:
1. **Age Distribution:**
   - Customers aged 50–59 have the highest churn rate (~60%).
   - The 40–49 age group is the largest contributor to overall churn.

2. **Geography Insights:**
   - **Germany** has the highest churn rate at 37%, contributing 37.5% of all churners.
   - **France** has a churn rate of 16%, but due to its large customer base, it contributes 44% of all churners.

3. **Credit Score:**
   - Credit score does not appear to be a strong predictor of churn, with the “Fair” category contributing the most to churn.

4. **Balance:**
   - Customers with high balances contribute to 43% of all churners.
   - Customers with zero balances have a lower churn rate (16%).

5. **Gender:**
   - **Females** account for 57.5% of churners, despite being fewer than males in the dataset.

6. **NumOfProducts:**
   - Customers with only one product exhibit the highest churn rate (34.7%).

7. **IsActiveMember:**
   - **Inactive members** have a significantly higher churn rate (29.7%) compared to active ones.

---

## Modelling

In this project, two machine learning models were used to predict customer churn:

1. **Random Forest:**
   - Random Forest demonstrated strong performance with high ROC-AUC, effectively handling the imbalanced dataset.

2. **LightGBM:**
   - LightGBM also performed well with a high ROC-AUC score, making it suitable for handling complex data.

---

## Evaluation

Both models were evaluated using **ROC-AUC** as the primary evaluation metric, due to the imbalanced nature of the dataset. The ROC-AUC score helps determine how well the model distinguishes between the churned and non-churned customers.

### Results:
- **Random Forest:** High ROC-AUC score, indicating strong predictive power.
- **LightGBM:** Similar excellent performance, well-suited for handling large datasets and imbalanced classes.

---

## Tools Used

- Python
- Pandas, NumPy (Data manipulation)
- Matplotlib, Seaborn (Data visualization)
- Scikit-learn (Machine learning models)
