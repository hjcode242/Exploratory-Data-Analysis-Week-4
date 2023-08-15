library(dplyr)
library(ggplot2)

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter NEI data for on-road vehicle emissions in Baltimore and Los Angeles
yearly_emissions6 <- NEI %>%
  filter(fips %in% c("24510", "06037") & type == "ON-ROAD") %>%
  group_by(year, fips) %>%
  summarize(total_emissions = sum(Emissions))

# Convert year to a factor for better visualization
yearly_emissions6$year <- as.factor(yearly_emissions6$year)

# Create factor for county names
yearly_emissions6$county_name <- factor(yearly_emissions6$fips,
                                        levels = c("06037", "24510"),
                                        labels = c("Los Angeles County", "Baltimore City"))

# Create bar plot using ggplot2
ggplot(yearly_emissions6, aes(x = year, y = total_emissions, fill = county_name)) +
  geom_bar(stat = "identity", position = "dodge") +
  guides(fill = guide_legend(title = NULL)) +
  labs(x = "Year", y = "PM2.5 Emissions (tons)", title = "Vehicle PM2.5 Emissions - Baltimore City and LA County") +
  theme_minimal() +
  theme(legend.position = "bottom")

# Save the plot as a PNG file
ggsave("plot6.png", width = 10, height = 6, dpi = 300)
