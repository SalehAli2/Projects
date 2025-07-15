# Fraud-Detection-For-Financial-Datasets

## Introduction

Fraud detection is a critical task in the financial industry, as fraudulent transactions can cause significant financial losses. This project aims to build a machine learning model to identify fraudulent transactions in a mobile money transaction dataset. By accurately detecting fraud, financial institutions can prevent losses and protect customer assets.

## Questions Asked

* **What are you trying to solve?**

  * Detect fraudulent transactions in mobile money transactions.
* **Why is this problem important?**

  * Fraudulent transactions can cause significant financial losses for financial institutions and customers.
* **What specific questions will the project answer?**

  * Which types of transactions are most likely to be fraudulent?
  * What are the key factors that differentiate fraudulent transactions from legitimate ones?

## Dataset Overview

This dataset contains 6,362,620 transaction records with 8 main features. It includes both numerical and categorical data related to each transaction.

### Dataset Columns

* **step:** Time unit (1 step = 1 hour).
* **type:** Transaction type (CASH-IN, CASH-OUT, DEBIT, PAYMENT, TRANSFER).
* **amount:** Transaction amount.
* **oldbalanceOrg:** Initial balance of the sender before the transaction.
* **newbalanceOrig:** New balance of the sender after the transaction.
* **oldbalanceDest:** Initial balance of the recipient before the transaction.
* **newbalanceDest:** New balance of the recipient after the transaction.
* **isFraud:** Whether the transaction is fraudulent (1 = Yes, 0 = No).
* **isFlaggedFraud:** Whether the transaction is flagged as potentially fraudulent (1 = Yes, 0 = No).

### Note

* The dataset was imported from [Kaggle](https://www.kaggle.com/datasets/ealaxi/paysim1).

## Exploratory Data Analysis (EDA)

### Key Insights

* Fraud occurs only in **TRANSFER** and **CASH\_OUT** transactions.
* Merchant transactions have a 0% fraud rate, making them highly predictive.
* Fraudulent transactions have significantly higher amounts.
* Amount distribution is highly skewed, and a log transformation was used to handle this.

## Modelling

### Models Used

* **LightGBM:**

  * Initial model struggled with fraud detection due to class imbalance.
  * Threshold optimized using AUC-ROC improved recall for fraud.

* **CatBoost:**

  * Achieved better recall and AUC-ROC compared to LightGBM.

## Evaluation

* Models were evaluated using **AUC-ROC** due to the imbalanced nature of the dataset.
* **AUC-ROC Scores:**

  * LightGBM (optimized): 0.968
  * CatBoost (optimized): 0.973

## Tools Used

* **Python:** Core language for data analysis and modeling.
* **Pandas, NumPy:** For data manipulation.
* **Matplotlib, Seaborn:** For data visualization.
* **Scikit-learn:** For model building and evaluation.
* **LightGBM, CatBoost:** For machine learning models.

## Conclusion

* CatBoost is a better model for detecting fraud because it has a higher recall, meaning it catches more fraud cases.

* Both models had issues with class imbalance, and future work could focus on improving precision and false positive rates.

Overall, this project shows that while fraud detection in imbalanced data is challenging, models like CatBoost can help in identifying fraudulent transactions effectively.
