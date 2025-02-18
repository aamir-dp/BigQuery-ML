# BQML Lab

## Overview
This dataset, **bqml_lab**, is designed for training and evaluating machine learning models using Google BigQuery ML. The training data is limited to records collected from **August 1, 2016, to June 30, 2017**, keeping the last month for prediction. Additionally, the dataset is restricted to **100,000 data points** to optimize processing time.

## Model Evaluation
The dataset supports evaluation for both **linear regression** and **logistic regression** models:

- **Linear Regression Metrics:**
  - `mean_absolute_error`, `mean_squared_error`, `mean_squared_log_error`
  - `median_absolute_error`, `r2_score`, `explained_variance`

- **Logistic Regression Metrics:**
  - `precision`, `recall`, `accuracy`, `f1_score`
  - `log_loss`, `roc_auc`

For further understanding of these metrics, refer to the **machine learning glossary** or perform a web search.

## Predicting Purchases
### **Predict Purchases Per Country**
This query predicts the **number of transactions per country**, sorts the results, and selects the **top 10 countries** with the highest predicted purchases.

#### **Results:**
| Country         | Total Predicted Purchases |
|---------------|-------------------------|
| United States | 154 |
| Canada       | 6   |
| Taiwan       | 6   |
| India        | 2   |
| Turkey       | 2   |
| Japan        | 2   |
| Singapore    | 1   |
| Italy        | 1   |
| Germany      | 1   |
| Guyana       | 1   |

### **Predict Purchases Per User**
This query predicts the **number of transactions per visitor**, sorts the results, and selects the **top 10 visitors** with the highest predicted transactions.

#### **Results:**
| FullVisitorId        | Total Predicted Purchases |
|----------------------|-------------------------|
| 9417857471295131045 | 3   |
| 1280993661204347450 | 2   |
| 2969418676126258798 | 2   |
| 7420300501523012460 | 2   |
| 8388931032955052746 | 2   |
| 112288330928895942  | 2   |
| 806992249032686650  | 2   |
| 057693500927581077  | 2   |
| 489038402765684003  | 2   |
| 0376394056092189113 | 2   |

## Model Evaluation Results
The model evaluation results using **logistic regression** are as follows:

| Metric        | Value  |
|--------------|--------|
| Precision    | 0.427  |
| Recall       | 0.074  |
| Accuracy     | 0.985  |
| F1 Score     | 0.125  |
| Log Loss     | 0.048  |
| ROC AUC      | 0.983  |

## SQL Files
The following SQL scripts are included in this project:

- `createModel.sql` - Creates the machine learning model.
- `evaluateModel.sql` - Evaluates model performance.
- `predictPurchasePerCountry.sql` - Predicts purchases per country.
- `predictPurchasePerUser.sql` - Predicts purchases per user.

## Usage
Run the provided SQL scripts in **BigQuery ML** to train, evaluate, and predict transactions using this dataset.

---
