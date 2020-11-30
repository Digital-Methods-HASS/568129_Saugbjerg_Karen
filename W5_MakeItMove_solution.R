
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

##Get the necessary packages

#First, start with installing the relevant packages 'tidyverse', 'gganimate', and 'gapminder'.

```{r libraries, echo = FALSE}
library(tidyverse)
install.packages("gganimate")
library(gganimate)
install.packages("gapminder")
library(gapminder)
install.packages("gifski")
library(gifski)
install.packages("av")
library(av)
```


## Look at the data

unique(gapminder$year)
head(gapminder)

# Let's plot all the countries in 1952.

theme_set(theme_bw())  # set theme to white background for better visibility

ggplot(subset(gapminder, year == 1952), aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10() 


## We see an interesting spread with an outlier to the right. Answer the following questions, please:

# Q1: Why does it make sense to have a log10 scale on x axis?

# Answer 1: In order to densify the points, making them comparable by eye.

# Q2: What country is the richest in 1952 (far right on x axis)? 

gapminder %>% 
  filter(year == 1952) %>% 
  group_by(country) %>% 
  summarise(max_gdpPercap = max(gdpPercap)) %>% 
  arrange(desc(max_gdpPercap))

# Answer 2: Kuwait


## You can generate a similar plot for 2007 and compare the differences

ggplot(subset(gapminder, year == 2007), aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10() 

# The black bubbles are a bit hard to read, the comparison would be easier with a bit more visual differentiation.

# Q3: Can you differentiate the continents by color and fix the axis labels?

a <- ggplot(subset(gapminder, year == 2007), aes(gdpPercap, lifeExp, size = pop)) +
  geom_point(aes(color = continent)) +
  scale_x_log10() 

a + labs(title = "All countries in 2007", x = "gdp per capita", y = "life experience")

# Q4: What are the five richest countries in the world in 2007?

gapminder %>% 
  filter(year == 2007) %>% 
  group_by(country) %>% 
  summarise(max_gdpPercap = max(gdpPercap)) %>% 
  arrange(desc(max_gdpPercap))

# Answer 4: Norway, Kuwait, Singapore, United States, Ireland


## Make it move!


## Option 1: Animate using transition_states()

# The first step is to create the object-to-be-animated

anim <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10()  # convert x to log scale
anim

# This plot collates all the points across time. The next step is to split it into years and animate it.

anim + transition_states(year, 
                         transition_length = 1,
                         state_length = 1)

# Notice how the animation moves jerkily, 'jumping' from one year to the next 12 times in total. This is a bit clunky, which is why it's good we have another option.


## Option 2: Animate using transition_time()

# This option smoothes the transition between different 'frames', because it interpolates and adds transitional years where there are gaps in the timeseries data.

anim2 <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10() + # convert x to log scale
  transition_time(year)
anim2

# Q5: Can you add a title to one or both of the animations above that will change in sync with the animation?

# Option 1: transition_states()

anim + labs(title = "{closest_state}") + transition_states(year, 
                                                           transition_length = 1,
                                                           state_length = 1)

# Option 2: transition_time()

anim2 + labs(title = "Year: {frame_time}")

# Q6 Can you make the axes' labels and units more readable? Consider expanding the abreviated lables as well as the scientific notation in the legend and x axis to whole numbers.[hint:search disabling scientific notation]

anim2 + labs(title = "Year: {frame_time}", x = "gdp per capita", y = "life expentancy") + scale_x_continuous(labels = scales::comma) + scale_size_continuous(labels = scales::comma)

# Q7: Come up with a question you want to answer using the gapminder data and write it down. Then, create a data visualisation that answers the question and explain how your visualization answers the question. (Example: you wish to see what was mean life expectancy across the continents in the year you were born versus your parents' birth years). [hint: if you wish to have more data than is in the filtered gapminder, you can load either the `gapminder_unfiltered` dataset and download more at https://www.gapminder.org/data/ ]

# Question: What was the mean life expectancy across the continents in 1952 and 2007?

mean_lifeExp_1952 <- gapminder %>%
  filter(year == 1952) %>% 
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp))

mean_lifeExp_2007 <- gapminder %>%
  filter(year == 2007) %>% 
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp))

mean_lifeExp_1952
mean_lifeExp_2007

# This is how far I have made it so far, and now I am running out of time :-( I cannot figure out which variables should be on which axes, neither how to compare 1952 and 2007 if it should be a moving visualization.

