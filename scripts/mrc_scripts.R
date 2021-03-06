devtools::install_github("jvcasillas/untidydata")
devtools::install_github("yihui/xaringan")

#library(untidydata)
#library(xaringan)
#library(plot3D)
#library(tidyverse)

ld <- language_diversity

language_diversity

str(ld)
head(ld)
unique(ld$Measurement)

nld <- ld %>%
  filter(., Continent == 'Africa') %>%
  spread(., Measurement, Value) %>%
  select(., country = Country, 
            pop = Population, 
            area = Area, 
            lang = Langs) %>%
  mutate(., logArea = log(area), 
            logPop = log(pop))
  
hist(log(nld$area))
hist(log(nld$pop))

nld %>%
  ggplot(., aes(x = logPop, y = lang, color = logArea)) +
    geom_point()

my_mod <- lm(lang ~ logPop + logArea, data = nld)
my_int <- lm(lang ~ logPop + logArea +logPop:logArea, data = nld)
summary(my_mod)
summary(my_int)
