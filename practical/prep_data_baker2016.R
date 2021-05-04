library(readxl)
library(tidyverse)

data_dirty <- read_excel("data/Reproducibility Survey Raw Data.xlsx")
replace_idx = which(!is.na(data_dirty[1,]))
colnames(data_dirty)[replace_idx] <- data_dirty[1,replace_idx]
data_clean <- data_dirty[-1,]

colnames(data_clean)[c(7,8,9)] <- paste0('published_manuscript-',colnames(data_clean)[c(7,8,9)])

colnames(data_clean) <- colnames(data_clean) %>% 
  str_replace_all("\\s", "_") %>% # remove spaces
  str_replace_all("\"", "") %>% # remove backslashed
  str_replace_all(",", "") %>% # remove commas
  tolower() # all lower case

data_clean = data_clean[,c(1,11,20,89,91)]

colnames(data_clean) <- c('id','familiar_reproducibility','crisis_agree','job','field')

write.csv(data_clean, file='data/baker2016-edited.csv', row.names = F)
