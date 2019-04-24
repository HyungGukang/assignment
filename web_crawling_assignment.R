url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'
#readin the html code

webpage <- read_html(url)

#using css selector to scrap ranking section

rank_data_html <- html_nodes(webpage,'.text-primary')
#converting rank data to text

rank_data <- html_text(rank_data_html)

##look at the data
head(rank_data)

##converting ranking to numeric

rank_data <- as.numeric(rank_data)

#look another look

head(rank_data)


#using css selector to scrap title section

title_data_html <- html_nodes(webpage,'.lister-item-header a')

title_data <- html_text(title_data_html)
##look at the title

head(title_data)

##using css selector to scrap description  section

description_data_html <- html_nodes(webpage,'.ratings-bar+ .text-muted')

description_data <- html_text(description_data_html)

head(description_data)

##removing '\n'
description_data <- gsub("\n","",description_data)

##look at the description

head(description_data)

#using css selector to scrap runtime section

runtime_data_html <- html_nodes(webpage, '.text-muted .runtime')

runtime_data <- html_text(runtime_data_html)

head(runtime_data)

## removing "min"
runtime_data <- gsub("min","",runtime_data)

runtime_data <- as.numeric(runtime_data)

##look at the run time
head(runtime_data)

#using css selector to scrap the IMDB raing section

IMDB_data_html <- html_nodes(webpage, '.ratings-imdb-rating strong')

IMDB_data <- html_text(IMDB_data_html)
##look at the IMDB raing 
head(IMDB_data)

IMDB_data <- as.numeric(IMDB_data)
##look at another the IMDB rating as numeric

head(IMDB_data)

movies_df <- data.frame(
  Rank = rank_data,
  Title = title_data,
  Description= description_data,
  Runtime = runtime_data,
  IMDB_rating = IMDB_data)

str(movies_df)

library(ggplot2)
library(tidyverse)

glimpse(movies_df)

movies_df %>% ggplot(aes(x= Runtime, y=IMDB_rating, group=Runtime)) %>%  boxplot()
