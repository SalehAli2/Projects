# Global Company Layoffs - Data Cleaning & Analysis

## 📌 Project Overview
This project focuses on analyzing global company layoffs using SQL. The dataset contains information about layoffs across various industries, locations, and time periods. The goal is to **clean, transform, and analyze** the data to uncover insights about layoffs trends.

## 📂 Dataset Information
The dataset includes:
- Company Name
- Location & Country
- Industry
- Total Employees Laid Off
- Percentage Laid Off
- Date of Layoff
- Company Stage
- Funds Raised (in Millions)

## 🛠️ Data Cleaning Steps
The dataset was cleaned using SQL through the following steps:
1. **Removed Duplicates:** Identified and eliminated duplicate records.
2. **Standardized Data:** Fixed inconsistencies in company names, industry names, and country formatting.
3. **Converted Date Format:** Changed date values to a proper `DATE` format.
4. **Handled Null & Missing Values:** Replaced missing values using logical replacements and removed incomplete records.
5. **Dropped Unnecessary Columns:** Removed extra columns after cleaning.


## 📊 Exploratory Data Analysis (EDA)
After cleaning, an exploratory data analysis (EDA) was conducted to extract meaningful insights:

### 🔍 Key Analysis:
- **Total Layoffs & Percentage Analysis:**
  - Identified the maximum number of employees laid off in a single event.
  - Found companies with a 100% layoff rate.
- **Industry & Country Insights:**
  - Determined the industries and countries most affected by layoffs.
- **Trends Over Time:**
  - Analyzed layoffs by year and month to observe trends.
- **Top Companies by Layoffs:**
  - Ranked companies based on total layoffs across different years.

## 📈 Insights & Findings
- The **tech industry** experienced the highest number of layoffs.
- The **United States** had the most layoffs compared to other countries.
- Layoffs peaked during certain years, reflecting economic downturns or market shifts.
- Some companies had **100% layoffs**, shutting down entirely.


## 🏆 Future Improvements
- **Data Visualization**: Create dashboards in Power BI or Python for better representation.
- **Predictive Analysis**: Use ML models to predict future layoffs based on trends.
