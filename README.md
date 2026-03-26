# GDP–Unemployment Panel Analysis (R)

## 📌 Objective

Analyze the impact of unemployment and other macroeconomic variables on GDP growth across developing countries using panel data econometrics.

---

## 📊 Dataset

* Panel data of 38 developing countries
* Time period: 2013–2023
* Variables include GDP growth, unemployment, inflation, FDI, government expenditure, and population growth

The dataset is included in this repository (`gdp_unemployment_data.xlsx`).

---

## 🧹 Data Preparation

* Cleaned and standardized dataset
* Converted categorical variables (country, continent, year) to factors
* Created lagged variables to capture delayed economic effects

---

## 📈 Exploratory Data Analysis

* Histograms for distribution of numeric variables
* Scatterplot of GDP growth vs unemployment
* Boxplot of unemployment across continents

---

## 📊 Methodology

### Panel Data Models:

* Random Effects Model
* Fixed Effects Model

### Model Selection:

* Hausman test used to compare Fixed vs Random effects

### Key Features:

* Lagged macroeconomic variables
* Interaction term: Inflation × Unemployment
* Time fixed effects (Year)

---

## 🔍 Model Diagnostics

* Residual vs fitted plots
* Normality checks (Histogram & Q-Q plot)
* Breusch–Pagan test for heteroskedasticity

---

## 🔑 Key Insights

* Lagged variables significantly influence GDP growth
* Lagged unemployment shows a negative impact on growth
* Macroeconomic effects often materialize with delay
* External shocks (e.g., COVID-19) significantly affect economic outcomes

---

## 🛠️ Tools & Libraries

* R
* plm (panel data modeling)
* ggplot2 (visualization)
* dplyr / tidyverse (data manipulation)

---

## 📌 Key Takeaway

Panel data analysis highlights the importance of considering time-lagged effects when evaluating macroeconomic relationships, especially in developing economies.


