# HR Analytics - Employee Attrition Analysis and Prediction

## **Overview**
This project aims to analyze and predict employee attrition using HR analytics data. It involves data exploration, statistical testing, machine learning modeling, and visualization to uncover patterns in employee turnover and identify key factors influencing attrition.

---

## **Objectives**
1. **Exploratory Data Analysis (EDA)**:
   - Gain insights into employee attrition trends.
   - Identify relationships between employee attributes and attrition.
   - Create meaningful visualizations.

2. **Statistical Testing**:
   - Evaluate significant differences in monthly income between employees who stayed and those who left.
   - Perform regression analysis to identify predictors of monthly income.

3. **Predictive Modeling**:
   - Build machine learning models for attrition prediction:
     - Logistic Regression.
     - Logistic Regression with SMOTE for handling class imbalance.
     - Random Forest.

4. **Visualization Dashboards**:
   - **Tableau Project**: A dashboard to explore data interactively.  
     (**Link: [https://public.tableau.com/app/profile/zana.simanel/viz/EmployeeTurnoverAnalysis_17364231956300/AttritionDasboard]**).

---

## **Folder Structure**

### **Files Included**
1. **SQL Files**
   - **`1.Tables`**: Scripts for creating tables and importing HR data into a PostgreSQL database.
   - **`2.EDA`**: SQL queries for exploratory data analysis.
   - **`3.Connections`**: SQL scripts for connecting to the PostgreSQL database and fetching data.

2. **Visualization Files**
   - **`EDA_Visualizations_Final.pdf`**: Visualization report summarizing key trends and insights from EDA.
   - **`logistic_regression_visualizations.pdf`**: Logistic Regression model visualizations.
   - **`logistic_regression_visualizations_with_smote.pdf`**: Performance metrics and visualizations for the SMOTE-enhanced Logistic Regression model.
   - **`random_forest_visualizations.pdf`**: Random Forest model visualizations.

3. **Datasets**
   - **`Cleaned_HR_Analytics.xlsx`**: The cleaned HR dataset used for analysis.
   - **`CleanedData.csv`**: CSV format of the cleaned HR dataset for easier integration.

4. **Models**
   - **`logistic_regression_model.joblib`**: Logistic Regression baseline model.
   - **`logistic_regression_smote_model.pkl`**: Logistic Regression model with SMOTE applied.
   - **`random_forest_model.pkl`**: Random Forest classifier for attrition prediction.

5. **Reports**
   - **`SQL_and_Statistical_Analysis_Report`**: Documentation of SQL queries and statistical analysis, including hypothesis testing and regression results.
   - **`Employee_Attrition_Analysis_and_Prediction`**: A comprehensive project report summarizing all findings.

---

## **Key Highlights**

### **EDA Insights**
- **Attrition Trends**: Employees with lower monthly income, poor work-life balance, and low job satisfaction are more likely to leave.
- **Demographic Insights**: Younger employees and certain job roles (e.g., Sales Representatives) exhibit higher attrition rates.
- **Income Distribution**: Employees with higher monthly incomes are less likely to leave.

### **Statistical Analysis**
1. **T-Test**:
   - Significant difference in monthly income between employees who stayed and those who left.  
     **T-Statistic**: 6.20 | **P-value**: 7.15e-10.
2. **Regression Analysis**:
   - **Significant Predictor**: Job Level (p < 0.001).
   - **R-Squared**: 90.3% (strong model fit for monthly income prediction).

### **Machine Learning Models**
1. **Logistic Regression**:
   - **Accuracy**: 83.9% (Baseline).
   - Low recall for attrition (minority class).

2. **Logistic Regression with SMOTE**:
   - **Accuracy**: 64.6% (Balanced).
   - Improved recall for attrition prediction.

3. **Random Forest**:
   - **Accuracy**: 82.7%.
   - High precision for "No Attrition", but struggles with "Attrition".

---

## **Usage Instructions**

1. **Run SQL Files**:
   - Use `1.Tables` to set up the database schema.
   - Use `2.EDA` to explore the data.
   - Use `3.Connections` to fetch data for analysis.

2. **Load Data**:
   - Use `CleanedData.csv` or `Cleaned_HR_Analytics.xlsx` to feed cleaned data into models.

3. **Execute Python Scripts**:
   - Visualizations: Use `EDA_Visualizations_Final.pdf`.
   - Models: Use the `.pkl` or `.joblib` files to load and test models.

4. **Explore Tableau Dashboard**:
   - **Tableau Project**: Interactive dashboard for deeper insights.  
     (**Link: [(https://public.tableau.com/app/profile/zana.simanel/viz/EmployeeTurnoverAnalysis_17364231956300/AttritionDasboard)]**).

---

## **Future Enhancements**
1. **Hyperparameter Tuning**:
   - Optimize model performance using GridSearchCV or RandomizedSearchCV.
   
2. **Advanced Models**:
   - Explore XGBoost and Neural Networks for improved accuracy.

3. **Real-Time Predictions**:
   - Deploy models into a real-time prediction system for HR decision-making.

---

