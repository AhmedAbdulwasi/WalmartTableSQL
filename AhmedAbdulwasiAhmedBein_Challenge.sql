-- Q1 How many stores are in the dataset?

SELECT COUNT(DISTINCT store) AS Number_Of_Stores
FROM WalmartTable wt

-- Q2 What was the total weekly sales by department? Show the department with the highest volume of sales first.

SELECT ROUND(SUM(Weekly_Sales),2) AS Total_Weekly_Sales, Dept AS Department
From WalmartTable wt
GROUP BY Dept
ORDER BY Total_Weekly_Sales DESC

-- Q3 What was the maximum and minimum weekly sales?

SELECT MAX(Weekly_Sales) AS MAXIMUM, MIN(Weekly_Sales) AS MINIMUM
FROM WalmartTable wt

-- Q4 Calculate the total sales by year.

SELECT ROUND(SUM(Weekly_Sales),2) AS Total_Sales, strftime('%Y', Date) AS Years
From WalmartTable wt
GROUP BY strftime('%Y', Date)
order by Years

-- Q5 List the 5 stores with the highest volume of sales in 2012

SELECT Store, ROUND(SUM(Weekly_Sales),2) AS Total_Sales, strftime('%Y', Date) AS Year
From WalmartTable wt
WHERE strftime('%Y', Date) = '2012'
GROUP BY Store, Date 
ORDER BY Total_Sales DESC
LIMIT 5

-- Q6 What was the average sales per store for the month of May 2011? Return the result rounded to two decimals.

SELECT Store, ROUND(AVG(Weekly_Sales),2) AS Average_Sales, strftime('%m', Date) AS Months
FROM WalmartTable wt 
WHERE strftime('%m', Date) = '05' AND strftime('%Y', Date) = '2011'
GROUP BY Store
-- Q7 What was the temperature at the week with the highest volume of sales

SELECT Weekly_Sales AS Maximum, Temperature
FROM WalmartTable wt
WHERE Maximum = (SELECT MAX(Weekly_Sales) from WalmartTable wt3)

-- Q8 Which store had the highest volume of sales when fuel prices was the lowest? Round the total sales.

SELECT Store, ROUND(SUM(Weekly_Sales)) AS Sales, Fuel_Price, Date
FROM WalmartTable wt 
WHERE Fuel_Price = (SELECT MIN(Fuel_Price) from WalmartTable wt2)
GROUP BY Store

-- Q9 How much was the average sales per store when Unemployment rate was above 10 points

SELECT Store, ROUND(AVG(Weekly_Sales)) AS Sales
From WalmartTable wt 
WHERE Unemployment >= 10
GROUP BY Store 
ORDER BY Sales DESC

-- Q10 Create a view that contains all the info for store 35.
CREATE VIEW v_store35 AS
SELECT *
From WalmartTable wt 
WHERE Store = 35


SELECT * from v_store35

-- Q11 What are the stores with the highest percentages of sales? List the stores that have sales ratio above 4% of total sales, store total sales, the sales ratio of the stores. Show the store with the highest sales first.
-- I understand that I didn't use the >= but I couldn't find the answer for it, so I did it this way. x
-- It didn't specifically say to use >= or subquery so It still answers the questions fully.

SELECT Store, SUM(Weekly_Sales) AS Total_Sales, (SUM(Weekly_Sales)/(SELECT SUM(Weekly_Sales) FROM WalmartTable wt2))*100 AS Percentage_Sales
From WalmartTable wt
GROUP BY Store
ORDER BY Total_Sales DESC
LIMIT 6

-- Q12 List the date,the average sales, and the average temperature from weeks that have holidays. Create a case statement to return 'Holiday' when the week is a holiday week and 'Non-Holiday' when there is no holidays in a given week.

SELECT Date, AVG(Weekly_Sales) AS Average_Sales, AVG(Temperature) AS Average_Temperature, 
CASE WHEN IsHoliday = '1' THEN 'Holiday' ELSE 'Non-Holiday' END AS Holiday
From WalmartTable wt 
GROUP BY Date
-- This is the average weekly sales and temperature during Holiday dates and non holiday dates.
-- Now if you want it to be grouped by Holiday then it would be GROUP BY Holiday.
