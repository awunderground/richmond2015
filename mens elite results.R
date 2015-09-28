library(rvest)
library(stringr)
library(dplyr)
library(plyr)

uci_link <- html("http://www.cyclingnews.com/uci-road-world-championships/elite-men-road-race/results/")

rank <- uci_link %>% 
    html_nodes(".count") %>%
    html_text() 
    
result <- uci_link %>% 
    html_nodes(".result_column") %>%
    html_text()

rider <- uci_link %>% 
    html_nodes(".count+ td") %>%
    html_text()

#

temp <- strsplit(rider, "\\(")

temp <- ldply(temp)


colnames(temp) <- c("rider", "country")

uci_results <- data.frame(rank, temp, result)

uci_results$country <- gsub("\\)", "", uci_results$country)

