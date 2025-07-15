# **Hotel Booking Analysis with SQL & Power BI**  

## 📌 **Project Overview**  
This project focuses on analyzing and visualizing hotel booking data using **SQL and Power BI**. The primary goal is to gain insights into **hotel revenue trends, hotel type comparison, and parking lot usage**.  

## ❓ **Key Business Questions**  
1. **Is the hotel revenue growing by year?** 📈  
2. **Which hotel type (City Hotel vs. Resort Hotel) generates more revenue?** 🏨  
3. **Should we increase the parking lot based on demand?** 🚗  

---

## **📂 Dataset Information**  
- The dataset contains booking records from **2018 to 2020**.  
- It includes **City Hotels** and **Resort Hotels**.  
- Key columns in the dataset:  
  - `arrival_date_year` – The year of booking  
  - `hotel` – Hotel type (City or Resort)  
  - `stays_in_week_nights` & `stays_in_weekend_nights` – Number of nights stayed  
  - `adr` – Average Daily Rate (price per night)  
  - `market_segment` – Source of booking (e.g., Online Travel Agents)  
  - `meal` – Type of meal booked  
  - `required_car_parking_spaces` – Number of parking spaces needed  

---

## **📊 SQL Queries & Data Preparation**  
### **1️⃣ Merging Multiple Years of Data**  
A `WITH` clause was used to combine **2018, 2019, and 2020** booking data into a single dataset:  

```sql
WITH Hotel AS (
    SELECT * FROM dbo.[2018$]
    UNION
    SELECT * FROM dbo.[2019$]
    UNION
    SELECT * FROM dbo.[2020$]
)
```

### **2️⃣ Revenue Analysis**  
Revenue was calculated as:  

```
Revenue = (stays_in_week_nights + stays_in_weekend_nights) * adr
```

```sql
SELECT 
    arrival_date_year,
    hotel,
    ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * adr),2) AS Revenue
FROM Hotel
GROUP BY arrival_date_year, hotel;
```

### **3️⃣ Enriching Data with Market Segment & Meal Costs**  
```sql
SELECT * FROM Hotel
LEFT JOIN dbo.market_segment$
ON Hotel.market_segment = market_segment$.market_segment
LEFT JOIN dbo.meal_cost$
ON meal_cost$.meal = Hotel.meal;
```

---

## **📈 Power BI Dashboard**  
### **Key Metrics Visualized:**  
✅ **Total Revenue** (Across years and by hotel type)  
✅ **Average Daily Rate (ADR)**  
✅ **Total Nights Stayed**  
✅ **Average Discount Rate**  
✅ **Car Parking Usage Analysis**  

### **Visuals Used:**  
📊 **Line Chart** – Revenue over time  
📌 **KPIs** – Revenue, ADR, total nights, and discounts  
📈 **Pie Chart** – Revenue share by hotel type  
📉 **Table** – Yearly revenue & parking lot usage  

---

## **🔍 Insights & Findings**  
📌 **Revenue Growth:**  
- Revenue fluctuates over the years. A detailed trend analysis can help in forecasting.  

📌 **Hotel Type Performance:**  
- **City Hotels generate higher revenue** than Resort Hotels.  

📌 **Parking Demand:**  
- A **small percentage (≈2.36%) of guests use parking**, indicating it may not be a priority investment.  

---

## **🛠 Tools & Technologies Used**  
- **SQL Server** – Data extraction & transformation  
- **Power BI** – Data visualization  
- **DAX (Power BI)** – For advanced calculations  
