library(dplyr)
library(ggplot2)

data <- read.csv("/Users/heleyi/Downloads/Bengaluru_House_Price_Data(main).csv")
head(data)

# 1. Remove column with too many missing values
data$society <- NULL

# 2. Extract numeric bedrooms from size
data$bedrooms <- as.numeric(gsub("[^0-9]", "", data$size))

# 3. Clean total_sqft
convert_sqft <- function(x) {
  if (grepl("-", x)) {
    nums <- as.numeric(unlist(strsplit(x, "-")))
    return(mean(nums))
  } else if (grepl("^[0-9.]+$", x)) {
    return(as.numeric(x))
  } else {
    return(NA)
  }
}

data$sqft <- sapply(data$total_sqft, convert_sqft)

# 4. Transform balcony 
data$balcony <- factor(data$balcony, levels = c(0,1,2,3))

# 5. Remove rows with missing key variables
data <- data[!is.na(data$sqft), ]
data <- data[!is.na(data$bath), ]
data <- data[!is.na(data$balcony), ]
data <- data[!is.na(data$bedrooms), ]
data <- data[!is.na(data$location), ]
data <- data[data$sqft > 0, ]

# 6. Frequency-based grouping for location
location_counts <- data %>%
  group_by(location) %>%
  tally(sort = TRUE)

top_18_names <- head(location_counts$location, 18)

data <- data %>%
  mutate(location_grouped = case_when(
    location %in% top_18_names ~ as.character(location),
    location_counts$n[match(location, location_counts$location)] >= 30 ~ "Other_Established",
    TRUE ~ "Other_Sparse"
  ))

# Convert to factor
all_levels <- c(as.character(top_18_names), "Other_Established", "Other_Sparse")
data$location_grouped <- factor(data$location_grouped, levels = all_levels)

# 7. Log-transform variables
data$log_price <- log(data$price)
data$log_sqft  <- log(data$sqft)  


# 8. Keep relevant variables
clean_data <- data[, c("log_price",
                       "log_sqft",
                       "balcony",
                       "location_grouped")]

# 9. Rename columns
colnames(clean_data) <- c("log_price",
                          "log_sqft",
                          "balcony",
                          "location")

# 10. Save cleaned dataset
write.csv(clean_data, "clean_housing.csv", row.names = FALSE)

# Count location frequency
location_counts <- data %>%
  group_by(location) %>%
  summarise(n = n()) %>%
  arrange(desc(n))


top_19 <- head(location_counts$location, 19)

data_top19 <- data %>%
  mutate(location_grouped = case_when(
    location %in% top_19 ~ as.character(location),
    TRUE ~ "Other"
  ))


ggplot(data_top19, aes(x = location_grouped, y = log_price)) +
  geom_boxplot() +
  coord_flip() +
  labs(title = "Top 19 Locations + Other")



top_18 <- head(location_counts$location, 18)

data_final <- data %>%
  mutate(location_grouped = case_when(
    location %in% top_18 ~ as.character(location),
    location_counts$n[match(location, location)] >= 30 ~ "Other_Established",
    TRUE ~ "Other_Sparse"
  ))

ggplot(data, aes(x = reorder(location_grouped, log_price, FUN = median), y = log_price)) +
  geom_boxplot(aes(fill = location_grouped), outlier.alpha = 0.2) +
  coord_flip() +
  labs(title = "Log Price Distribution: Top 18 vs Refined Other Tiers",
       x = "Location Group",
       y = "Log Price") +
  theme_minimal() +
  theme(legend.position = "none")



top_17 <- head(location_counts$location, 17)

data <- data %>%
  left_join(location_counts, by = "location")

data_top17 <- data %>%
  mutate(location_grouped = case_when(
    location %in% top_17 ~ as.character(location),
    n >= 50 ~ "Other_50_plus",
    n >= 20 & n < 50 ~ "Other_20_50",
    n < 20 ~ "Other_below_20"
  ))
ggplot(data_top17, aes(x = location_grouped, y = log_price)) +
  geom_boxplot() +
  coord_flip() +
  labs(title = "Top 17 + Frequency-based Other Groups")

