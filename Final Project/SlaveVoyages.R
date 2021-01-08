
### Final Project. Transatlantic Slave Voyages

## Preparatory steps

# Reading data from csv file
voyages <- read.csv("data/slavevoyages_clean.csv")

# Reading necessary packages
library("tidyverse")
library("cowplot")

## Plotting

# Visualizing annual number of voyages during the entire period
voyages %>% 
  count(year) %>% 
  ggplot(aes(x = year, y = n))+
  geom_line()+
  labs(title = "Annual number of voyages during the entire period", x = "Year", y = "Number of voyages")

# Visualizing top 25 most frequent points of departure
voyages %>% 
  count(departure) %>% 
  top_n(25) %>% 
  mutate(departure = reorder(departure,n)) %>%
  ggplot(aes(x = n, y = departure))+
  geom_col()+
  labs(title = "25 most frequent points of departure during the entire period", x = "Number of voyages", y = "Departure points")

# Visualizing annual number of voyages for top 10 most frequent departure points in 16th century
departure10in16th <- voyages %>% 
  filter(year %in% c(1500:1600)) %>%
  count(departure) %>% 
  top_n(10)

voyages16th <- voyages %>%
  filter(year %in% c(1500:1600)) %>% 
  filter(departure %in% departure10in16th$departure) %>% 
  group_by(departure) %>% 
  count(year)

sixteenth <- ggplot(data=voyages16th, aes(x = year, y = n))+
  geom_line(aes(group=departure, color=departure))+
  labs(title = "Annual number of voyages for 10 most frequent points of departure in 16th century", x = "Year", y = "Number of voyages")

# Visualizing annual number of voyages for top 10 most frequent departure points in 17th century
departure10in17th <- voyages %>% 
  filter(year %in% c(1600:1700)) %>%
  count(departure) %>% 
  top_n(10)

voyages17th <- voyages %>%
  filter(year %in% c(1600:1700)) %>% 
  filter(departure %in% departure10in17th$departure) %>% 
  group_by(departure) %>% 
  count(year)

seventeenth <- ggplot(data=voyages17th, aes(x = year, y = n))+
  geom_line(aes(group=departure, color=departure))+
  labs(title = "Annual number of voyages for 10 most frequent points of departure in 17th century", x = "Year", y = "Number of voyages")

# Visualizing annual number of voyages for top 10 most frequent departure points in 18th century
departure10in18th <- voyages %>% 
  filter(year %in% c(1700:1800)) %>%
  count(departure) %>% 
  top_n(10)

voyages18th <- voyages %>%
  filter(year %in% c(1700:1800)) %>% 
  filter(departure %in% departure10in18th$departure) %>% 
  group_by(departure) %>% 
  count(year)

eighteenth <- ggplot(data=voyages18th, aes(x = year, y = n))+
  geom_line(aes(group=departure, color=departure))+
  labs(title = "Annual number of voyages for 10 most frequent points of departure in 18th century", x = "Year", y = "Number of voyages")

# Visualizing annual number of voyages for top 10 most frequent departure points in 19th century
departure10in19th <- voyages %>% 
  filter(year %in% c(1800:1900)) %>%
  count(departure) %>% 
  top_n(10)

voyages19th <- voyages %>% 
  filter(year %in% c(1800:1900)) %>% 
  filter(departure %in% departure10in19th$departure) %>% 
  group_by(departure) %>% 
  count(year)

nineteenth <- ggplot(data=voyages19th, aes(x = year, y = n))+
  geom_line(aes(group=departure, color=departure))+
  labs(title = "Annual number of voyages for 10 most frequent points of departure in 19th century", x = "Year", y = "Number of voyages")

# Combining 4 plots into one figure
plot_grid(sixteenth, seventeenth, eighteenth, nineteenth, labels = c('A', 'B', 'C', 'D'), ncol = 1)

# Visualizing annual number of voyages for top 5 most frequent departure points
departure5 <- voyages %>% 
  count(departure) %>% 
  top_n(5)

voyages5 <- voyages %>%
  filter(departure %in% departure5$departure) %>% 
  group_by(departure) %>% 
  count(year, sort = TRUE)

ggplot(data=voyages5, aes(x = year, y = n))+
  geom_area(aes(group=departure, fill=departure))+
  labs(title = "Annual number of voyages for 5 most frequent points of departure during the entire period", x = "Year", y = "Number of voyages")

# Visualizing slaves embarked and disembarked during the period
voyages %>% 
  ggplot(aes(x = year))+
  geom_col(aes(y = embarked, fill = "Embarked"))+
  geom_col(aes(y = disembarked, fill = "Disembarked"))+
  scale_fill_manual(values = c("darkred", "darkslategrey"))+
  guides(fill=guide_legend(title="Number of slaves"))+
  theme(legend.position = c(0.15, 0.85))+
  theme(legend.background = element_rect(fill="azure3",
                                         size=0.5, linetype="solid", 
                                         colour ="black"))+
  labs(title = "Annual number of slaves embarked and disembarked during the entire period", x = "Year", y = "Number of slaves")
