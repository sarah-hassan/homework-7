install.packages("rvest")
library(rvest)
library(dplyr)
library(tidyverse)
library(repurrrsive)
install.packages("listviewer")
listviewer::jsonedit(gh_users)

#1
Link <- " https://www.imdb.com/list/ls091520106/"
page = read_html(Link)
Title = page%>% html_nodes(".lister-item-header a")%>%
  html_text()
Title 

Link <- "https://www.imdb.com/list/ls091520106/"
page = read_html(Link)
Ratings = page%>% html_nodes(".ipl-rating-star.small .ipl-rating-star__rating")%>%
  html_text()
Ratings

movies = data.frame(Title, Ratings)
movies

as_tibble(movies)


#2a
#A nested list  is a list within a list. For example, a list(or sublist) can be an element contained in a larger list with more elements.

#2b
gh_repos
#this code produces an output in which the data structure is essentially a disorganized list of the repository data.



#2c
repos <- tibble(repo = gh_repos)
repos

#by running this code you are able to transform the data into a tibble. When you run it, list-columns are produced and we can only see 'list [30]' in the six rows.


#2d
listviewer::jsonedit(gh_repos)

#in list viewer we initally see an array representing 6 repos. Within each of these array there is a list containing 30 elements containing the data for each of the 6 users. Since it is a list within a list, we can consider it a nested list. 30 represents the number of elements within the array. 68 represents the number of variables (i.e.id,name,fullname etc)   

#2e

(repos <- tibble(repo = gh_repos))
repos2 <- repos %>% unnest_longer(repo)
repos2

repos3 <-repos2 %>% unnest_wider(repo)
repos3
repos2 %>% select_if(is.list)


#confused with this code--






