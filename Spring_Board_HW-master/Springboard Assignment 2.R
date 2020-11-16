library(dplyr)
library(tidyr)
titanic <- read.csv("titanic.csv", header = T, na.strings = "")
titanic <- tbl_df(titanic)
glimpse(titanic)
embarked_blank <- which(is.na(titanic$embarked))
titanic$embarked[embarked_blank] <- "S"
summary(titanic$embarked)
mean_age <- mean(titanic$age, na.rm = TRUE)
age_blank <- which(is.na(titanic$age))
titanic$age[age_blank] <- mean_age
#Other ways to populate blank values: median, max, min. I would not use these to replace the blanks because the mean age best represents the blanks.
boat_blank <- which(is.na(titanic$boat))
titanic$boat <- sapply(titanic$boat,as.character)
titanic$boat[boat_blank] <- "none"
titanic$boat <- factor(titanic$boat)
glimpse(titanic$boat)
#There might not be a cabin number because the data was not properly stored or lost with the ship. The passengers who did not survive could not report what cabin he/she was in. Some surviving passengers might have forgot which cabin he/she stayed in. 
titanic <- titanic %>% mutate(has_cabin_number = cabin)
cabin_blank <- which(is.na(titanic$cabin))
cabin_non_blank <- which(!is.na(titanic$cabin))
titanic$has_cabin_number <- sapply(titanic$has_cabin_number, as.character)
titanic$has_cabin_number[cabin_blank] <- 0
titanic$has_cabin_number[cabin_non_blank] <- 1
titanic$has_cabin_number
write.csv(titanic,"titanic_clean.csv")