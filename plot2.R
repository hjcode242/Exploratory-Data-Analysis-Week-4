library(readr)
library(dplyr)
library(ggplot2)

# Load data
NEI <- readRDS("summarySCC_PM25.rds")

# Filter data and calculate total emissions by year
yearly_emissions2 <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarize(total_emissions = sum(Emissions))

# Create bar plot using ggplot2
ggplot(yearly_emissions2, aes(x = factor(year), y = total_emissions)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(x = "Year", y = "PM2.5 Emissions (tons)", title = "Total PM2.5 Emissions from Baltimore City Sources") +
  theme_minimal()

ggsave("plot2.png", width = 8, height = 6, dpi = 300)

