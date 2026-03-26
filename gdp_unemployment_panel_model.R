
#Libraries
library(car)
library(ggplot2)
library(tseries)
library(plm)
library (tidyverse)

#DATA LOADING & PREPARATION
datafinal <- read_excel("gdp_unemployment_data.xlsx")


colnames(datafinal) <- make.names(colnames(datafinal))
View(datafinal)
str(datafinal)


#Converting character to factor variables
datafinal$Country.Name <- as.factor(datafinal$Country.Name)
datafinal$Continent <- as.factor(datafinal$Continent)
datafinal$Year <- as.factor(datafinal$Year)


#EXPLORATORY DATA ANALYSIS (EDA)
#Summary Statistics
summary(datafinal)
# Generating histograms for all numeric variables
numeric_vars <- select_if(datafinal, is.numeric)

for (col in colnames(numeric_vars)) {
  # Create the histogram
  p <- ggplot(datafinal, aes_string(x = col)) +
    geom_histogram(bins = 30, fill = "blue", color = "black", alpha = 0.7) +
    labs(title = paste("Histogram of", col), x = col, y = "Frequency") +
    theme_minimal()
  
  # Display the histogram
  print(p)
  
  # Save the histogram as a PNG file
  ggsave(filename = paste0("histogram_", col, ".png"), plot = p, width = 6, height = 4)
}

# Scatterplot of GDP Growth vs Unemployment
ggplot(datafinal, aes(x = Unemployment, y = `GDP.Growth`)) +
  geom_point(color = "blue", alpha = 0.7) +
  labs(title = "Scatterplot of GDP Growth vs Unemployment",
       x = "Unemployment", y = "GDP Growth") +
  theme_minimal()

# Boxplot of Unemployment grouped by Continent
p <- ggplot(datafinal, aes(x = Continent, y = Unemployment)) +
  geom_boxplot(fill = "lightblue", color = "black") +
  labs(title = "Boxplot of Unemployment by Continent",
       x = "Continent", y = "Unemployment") +
  theme_minimal()

# Display the boxplot
print(p)

#PANEL DATA MODELING
#Random Effects Model 
random_effects_lagged_gdp <- plm(GDP.Growth ~ lag(GDP.Growth, 1) + FDI + lag(FDI, 1) +
                                  Inflation + lag(Inflation, 1) +
                                  Government.Expenditure + lag(Government.Expenditure, 1) + Unemployment +
                                  lag(Unemployment, 1) + lag(Population.Growth, 1) + factor (Year) + Area + Continent + Inflation:Unemployment,
                                  data = datafinal, model = "random")

summary(random_effects_lagged_gdp)

#Fixed Effects Model
fixed_effects_lagged_gdp <- plm(GDP.Growth ~ lag(GDP.Growth, 1) + FDI + lag(FDI, 1) +
                                   Inflation + lag(Inflation, 1) +
                                   Government.Expenditure + lag(Government.Expenditure, 1) + Unemployment +
                                   lag(Unemployment, 1) + lag(Population.Growth, 1) + factor (Year) + Area + Continent + Inflation:Unemployment,
                                 data = datafinal, model = "within")

summary(fixed_effects_lagged_gdp)

#MODEL SELECTION (HAUSMAN TEST)
hausman_test <- phtest(fixed_effects_lagged_gdp, random_effects_lagged_gdp)

# Display the results
print(hausman_test)


#MODEL DIAGNOSTICS
# Extract fitted values and residuals manually
fitted_values <- as.numeric(fitted(random_effects_lagged_gdp))
residual_values <- as.numeric(residuals(random_effects_lagged_gdp))

# Create the Residuals vs Fitted Values plot
plot(fitted_values, residual_values,
     main = "Residuals vs Fitted Values",
     xlab = "Fitted Values", ylab = "Residuals")
abline(h = 0, col = "red", lty = 2)


#NORMALITY CHECKS
# Histogram of residuals
hist(residuals(random_effects_lagged_gdp), breaks = 20, main = "Histogram of Residuals", xlab = "Residuals")

# Q-Q Plot
qqnorm(residuals(random_effects_lagged_gdp))
qqline(residuals(random_effects_lagged_gdp), col = "red")


#Heteroskedacity Test
library(lmtest)
bptest(random_effects_lagged_gdp)




