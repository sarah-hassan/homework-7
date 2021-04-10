#hw 9 web scraping/api
library(tidycensus)
library(tidyverse)
library(dplyr)
library(ggplot2)
#https://api.census.gov/data/2015/acs/acs1/variables.html


#1
census_api_key("95c61c9b4cd8324855924d339aadefb48e9bee09")
install = TRUE

#2a
v1 <- load_variables(2015, "acs5", cache = TRUE)
v1

ca <- get_acs(geography = "county", 
              variables = c(medincome = "B01001A_011E"), 
              state = "CA", 
              year = 2015)

ca

#2b
ca1 <- ca%>%
  filter(estimate>=30000)%>%
  arrange(desc(estimate))
ca1

mutate(ca1, variable = recode(variable, "B01001A_011"= "medianincome"))->ca2
ca2
  

#2c
ca3<- ca2%>%
  filter(moe== 667, estimate== 51644)
ca3
#alameda county


#2d
ggplot(data = ca2) +
  geom_boxplot(mapping = aes(x=estimate), fill = "red")

#2e
ca1 %>%
  mutate(NAME = gsub(" County, California", "", NAME)) %>%
  ggplot(aes(x = estimate, y = reorder(NAME, estimate))) +
  geom_errorbarh(aes(xmin = estimate - moe, xmax = estimate + moe)) +
  geom_point(color = "blue", size = 3) +
  labs(title = "Median Income for White Males by County",
       subtitle = "2014-2018 American Community Survey",
       y = "",
       x = "ACS estimate (bars represent margin of error)")


  





