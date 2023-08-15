library(dplyr)
library(readr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

yearly_emissions <- NEI %>%
  group_by(year) %>%
  summarize(total_emissions = sum(Emissions))

ggplot(yearly_emissions, aes(x = factor(year), y = total_emissions)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(x = "Year", y = "PM2.5 Emissions (tons)", title = "Total PM2.5 Emissions from All Sources") +
  theme_minimal()

ggsave("plot1.png", width = 8, height = 6, dpi = 300)

