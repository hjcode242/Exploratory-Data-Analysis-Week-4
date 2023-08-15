library(dplyr)
library(ggplot2)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


scc_coal <- SCC %>%
  filter(grepl("coal", EI.Sector, ignore.case = TRUE)) %>%
  select(SCC)


yearly_emissions4 <- NEI %>%
  filter(SCC %in% scc_coal$SCC) %>%
  group_by(year) %>%
  summarize(total_emissions = sum(Emissions))


yearly_emissions4$year <- as.factor(yearly_emissions4$year)


ggplot(yearly_emissions4, aes(x = year, y = total_emissions)) +
  geom_bar(stat = "identity") +
  labs(x = "Year", y = "PM2.5 Emissions (tons)", title = "US PM2.5 Emissions from Coal Related Sources") +
  theme_minimal()
