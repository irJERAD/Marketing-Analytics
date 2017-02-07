
# __________________________________________________________
# //////////////////////////////////////////////////////////
#
#    MODULE 0 - INTRODUCTION
# __________________________________________________________
# //////////////////////////////////////////////////////////


# --- EXPLORE THE DATA -------------------------------------


# Load text file into local variable called 'data'
data = read.delim(file = 'purchases.txt', header = FALSE, sep = '\t', dec = '.')

# Display what has been loaded
head(data)
# FOR EACH COLUMN prints min, quadrants, median, mean, max
summary(data)

# Add headers and interpret the last column as a date, extract year of purchase
# rename columns to human understandable representations
colnames(data) = c('customer_id', 'purchase_amount', 'date_of_purchase')
# tell R this column is a date variable
data$date_of_purchase = as.Date(data$date_of_purchase, "%Y-%m-%d")
# create a new column that contains the year of purchase
data$year_of_purchase = as.numeric(format(data$date_of_purchase, "%Y"))

# Display the data set after transformation
head(data)
summary(data)

# Explore the data using simple SQL statements
library(sqldf)

# Number of purchases per year
## SELECT sql statement which is used to fetch the data from a database
## and returns results in the form of a data table
# see how many purchases were made each year from data set 'data':
# 'SELECT each year_of_purchase and COUNT each instance of year_of_purchase
x = sqldf("SELECT year_of_purchase, COUNT(year_of_purchase) AS 'counter' FROM data GROUP BY 1 ORDER BY 1")

# now plot the counted number of purchases by year as a bar plot
barplot(x$counter, names.arg = x$year_of_purchase)

# Average purchase amount per year
x = sqldf("SELECT year_of_purchase, AVG(purchase_amount) AS 'avg_amount' FROM data GROUP BY 1 ORDER BY 1")
barplot(x$avg_amount, names.arg = x$year_of_purchase)

# Total purchase amounts per year
x = sqldf("SELECT year_of_purchase, SUM(purchase_amount) AS 'sum_amount' FROM data GROUP BY 1 ORDER BY 1")
barplot(x$sum_amount, names.arg = x$year_of_purchase)

# All in one
x = sqldf("SELECT year_of_purchase,
                  COUNT(year_of_purchase) AS 'counter',
                  AVG(purchase_amount) AS 'avg_amount',
                  SUM(purchase_amount) AS 'sum_amount'
           FROM data GROUP BY 1 ORDER BY 1")
print(x)
