## install.packages("dplyr")
## library("dplyr")
## library("tidyr")

## input file name
input_file <- "C:/Users/JV/Desktop/R - Springboard/Unit3Exercise/BasicDatamanipulation/refine_original.csv"
output_file <- "C:/Users/JV/Desktop/R - Springboard/Unit3Exercise/BasicDatamanipulation/refine_clean.csv"

##Read from csv to a data frame
data <- read.table(input_file, sep = ",", header = TRUE)

## print(data)
print(colnames(data))

## 1. Clean up brand names
tmp <- data %>% mutate(new_name = tolower(company))
tmp1 <- tmp %>% mutate(correct_name = ifelse(grepl("^ak",new_name, ignore.case = TRUE),"akzo", 
                                             ifelse(grepl("^van",new_name, ignore.case = TRUE),"van houten",
                                                    ifelse(grepl("^uni",new_name, ignore.case = TRUE),"unilever",
                                                           ifelse(grepl("^ph|^fi",new_name, ignore.case = TRUE),"phillips", "NA")))))
data$company <- tmp1$correct_name
##View(data)

## 2. Separate Product code and number
data <- separate(data, Product.code...number, c("Product code", "number"), sep = "-")
## View(data)

## 3. Add product categories
data <- data %>% mutate(`Product category` = ifelse(`Product code` %in% "p" , "Smartphone",
                                                    ifelse(`Product code` %in% "v", "TV",
                                                           ifelse(`Product code` %in% "x", "Laptop",
                                                                  ifelse(`Product code` %in% "q", "Tablet","NA")))))
##View(data)

## 4. Add full address for geocoding
data <- unite(data, "full_address",address,city,country, sep = ",")
## View(data)

## 5. Create dummy variables for company and product category
data <- data %>% mutate(company_philips = match(company, "phillips"),
                        company_akzo = match(company, "akzo"),
                        company_van_houten = match(company, "van houten"),
                        company_unilever = match(company, "unilever"),
                        product_smartphone = match(`Product category`, "Smartphone"),
                        product_tv = match(`Product category`, "TV"),
                        product_laptop = match(`Product category`, "Laptop"),
                        product_tablet = match(`Product category`, "Tablet"))
data[is.na(data)] <- 0
View(data)

## Write the tidy data to a CSV file
write.table(data,output_file, row.names = FALSE, sep = ",", quote = FALSE)
