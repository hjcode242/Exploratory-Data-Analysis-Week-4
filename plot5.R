library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

yearly_emissions5 <- NEI %>%
  filter(fips == "24510" & type == "ON-ROAD") %>%
  group_by(year) %>%
  summarize(total_emissions = sum(Emissions))


yearly_emissions5$year <- as.factor(yearly_emissions5$year)

ggplot(yearly_emissions5, aes(x = year, y = total_emissions)) +
  geom_bar(stat = "identity") +
  labs(x = "Year", y = "PM2.5 Emissions (tons)", title = "Baltimore City PM2.5 Emissions from Vehicle Related Sources") +
  theme_minimal()

ggsave("plot5.png", width = 10, height = 6, dpi = 300)

