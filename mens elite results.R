setwd("/Users/aaronwilliams/Data")

library(rvest)
library(stringr)
library(dplyr)
library(plyr)
library(dplyr)
library(countrycode)

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

# normalize the results

time1 <- "0:00:00"
time2 <- rep(result[2], 24)
time3 <- rep(result[26], 3)
time4 <- rep(result[29], 3)
time5 <- result[32]
time6 <- rep(result[33], 4)
time7 <- result[37]
time8 <- result[38]
time9 <- rep(result[39], 6)
time10 <- rep(result[45], 14)
time11 <- result[59]
time12 <- result[60]
time13 <- result[61]
time14 <- result[62]
time15 <- result[63]
time16 <- result[64]
time17 <- result[65]
time18 <- result[66]
time19 <- rep(result[67], 12)
time20 <- result[79]
time21 <- rep(result[80], 2)
time22 <- rep(result[82], 4)
time23 <- rep(result[86], 2)
time24 <- result[88]
time25 <- result[89]
time26 <- result[90]
time27 <- rep(result[91], 12)
time28 <- result[103]
time29 <- rep(result[104], 3)
time30 <- rep(result[107], 2)
time31 <- result[109]
time32 <- result[110]
time33 <- rep("DNF", 81)
time34 <- "DNS"

nums <- 1:34
nums <- paste("time", nums, sep = "")

results <- c(time1, time2, time3, time4, time5, time6, time7, time8, time9, time10, time11, time12, 
  time13, time14, time15, time16, time17, time18, time19, time20, time21, time22, time23, 
  time24, time25, time26, time27, time28, time29, time30, time31, time32, time33, time34)

times <- str_split_fixed(results, ":", 3)

seconds <- times[, 3]
seconds <- as.numeric(seconds)

minutes <- times[, 2]
minutes <- as.numeric(minutes)
minutes <- minutes*60

normalized_results2 <- minutes + seconds

normalized_results[1:110] <- normalized_results2[1:110]

rm(normalized_results2)

#create country variable

temp <- strsplit(rider, "\\(")

temp <- ldply(temp)

colnames(temp) <- c("rider", "country")

temp$country <- gsub("\\)", "", temp$country)

temp$continent <- countrycode(temp$country, "country.name", "continent")

#

total_times <- results[2:110]
total_times <- str_split_fixed(total_times, ":", 3)

total_times[, 1] <- "06"

total_times[, 2] <- as.numeric(total_times[, 2]) + 14

total_times[, 3] <- as.numeric(total_times[, 3]) + 37


if(total_times[, 3] > 60){as.numeric(total_times[, 3] - 60}

total_times[, 2] total_times[, total_times[, 3] >60]



uci_results <- data.frame(rank, temp, normalized_results, result)



