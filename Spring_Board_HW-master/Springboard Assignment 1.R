library(tidyr)
library(dplyr)
getwd()
read.csv("refine_original.csv")
refine_original <- read.csv("refine_original.csv")
refine_original$company <- sapply(refine_original$company, tolower)
refine_original$company <- gsub(pattern = ".*ps$",refine_original$company, replacement = "phillips")
refine_original$company <- gsub(pattern = "ak.*",refine_original$company, replacement = "akzo")
refine_original$company <- gsub(pattern = ".*en$",refine_original$company, replacement = "van houten")
refine_original$company <- gsub(pattern = ".*er$",refine_original$company, replacement = "unilever")
refine_original <- refine_original %>% separate(Product.code...number,into = c("product_code", "product_number", sep = "-"))
refine_original <- refine_original %>% mutate(product_category = product_code)
refine_original$product_category <- gsub(pattern = "p", refine_original$product_category, replacement = "smartphone")
refine_original$product_category <- gsub(pattern = "v", refine_original$product_category, replacement = "tv")
refine_original$product_category <- gsub(pattern = "x", refine_original$product_category, replacement = "laptop")
refine_original$product_category <- gsub(pattern = "q", refine_original$product_category, replacement = "tablet")
refine_original <- refine_original %>% mutate(full_address = paste(address, city, country, sep = ","))
refine_original <- refine_original %>% mutate(company_phillips = company)
refine_original$company_phillips[refine_original$company =="phillips"] <- 1
refine_original$company_phillips[refine_original$company !="phillips"] <- 0
refine_original <- refine_original %>% mutate(company_akzo = company)
refine_original$company_akzo[refine_original$company =="akzo"] <- 1
refine_original$company_akzo[refine_original$company !="akzo"] <- 0
refine_original <- refine_original %>% mutate(company_van_houten = company)
refine_original$company_van_houten[refine_original$company =="van houten"] <- 1
refine_original$company_van_houten[refine_original$company !="van houten"] <- 0
refine_original <- refine_original %>% mutate(company_unilever = company)
refine_original$company_unilever[refine_original$company =="unilever"] <- 1
refine_original$company_unilever[refine_original$company !="unilever"] <- 0
refine_original <- refine_original %>%  mutate(product_smartphone = product_code)
refine_original <- refine_original %>%  mutate(product_tv = product_code)
refine_original <- refine_original %>%  mutate(product_laptop = product_code)
refine_original <- refine_original %>%  mutate(product_tablet = product_code)
refine_original$product_smartphone[refine_original$product_code == "p"] <- 1
refine_original$product_smartphone[refine_original$product_code != "p"] <- 0
refine_original$product_tv[refine_original$product_code == "v"] <- 1
refine_original$product_tv[refine_original$product_code != "v"] <- 0
refine_original$product_laptop[refine_original$product_code == "x"] <- 1
refine_original$product_laptop[refine_original$product_code != "x"] <- 0
refine_original$product_tablet[refine_original$product_code == "q"] <- 1
refine_original$product_tablet[refine_original$product_code != "q"] <- 0
refine_original
write.csv(refine_original,"refine_clean.csv")

