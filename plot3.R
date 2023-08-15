library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")


yearly_emissions3 <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarize(total_emissions = sum(Emissions))


yearly_emissions3$year <- as.factor(yearly_emissions3$year)


ggplot(yearly_emissions3, aes(x = year, y = total_emissions)) +
  geom_bar(stat = "identity") +
  facet_grid(. ~ type) +
  labs(x = "Year", y = "PM2.5 Emissions (tons)", title = "Baltimore City PM2.5 Emissions by Type") +
  theme_minimal()


ggsave("plot3.png", width = 10, height = 6, dpi = 300)
