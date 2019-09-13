**Data Wrangling Exercise 1: Basic Data Manipulation**
======================================================

For this exercise, we have a toy dataset showing the product purchases
from an electronic store, which is small and simple. The structure of
the dataset is

We can notice that there are few issues with this data.

-   There are four brand names : Philips, Akzo, Van Houten,
    Unilever.They all have different spellings.
-   The product number and the code are in the same variable separated
    by a hyphen
-   To geocoding purposes, we need full addresses, which can be obtained
    by combining the three variables: address, city, country
-   Product codes to be added for all the product categories
-   Dummy variables for company and product categories to be created, in
    order to use them in further analysis

1. Clean up brand names
-----------------------

    tmp <- data %>% mutate(new_name = tolower(company))
    tmp1 <- tmp %>% mutate(correct_name = ifelse(grepl("^ak",new_name, ignore.case = TRUE),"akzo", 
                                                 ifelse(grepl("^van",new_name, ignore.case = TRUE),"van houten",
                                                        ifelse(grepl("^uni",new_name, ignore.case = TRUE),"unilever",
                                                               ifelse(grepl("^ph|^fi",new_name, ignore.case = TRUE),"phillips", "NA")))))
    data$company <- tmp1$correct_name

All the company names are converted to lowercase letters and the
spellings are corrected.

    ##      company
    ## 1   phillips
    ## 2       akzo
    ## 3 van houten
    ## 4   unilever

2. Separate Product code and number
-----------------------------------

    data <- separate(data, Product.code...number, c("Product code", "number"), sep = "-")

3. Add product categories
-------------------------

    data <- data %>% mutate(`Product category` = ifelse(`Product code` %in% "p" , "Smartphone",
                                                        ifelse(`Product code` %in% "v", "TV",
                                                               ifelse(`Product code` %in% "x", "Laptop",
                                                                      ifelse(`Product code` %in% "q", "Tablet","NA")))))

The dataset now has the following values for the variables : company,
Product code, number and Product category

    ##       company Product code number Product category
    ## 1    phillips            p      5       Smartphone
    ## 2    phillips            p     43       Smartphone
    ## 3    phillips            x      3           Laptop
    ## 4    phillips            x     34           Laptop
    ## 5    phillips            x     12           Laptop
    ## 6    phillips            p     23       Smartphone
    ## 7        akzo            v     43               TV
    ## 8        akzo            v     12               TV
    ## 9        akzo            x      5           Laptop
    ## 10       akzo            p     34       Smartphone
    ## 11       akzo            q      5           Tablet
    ## 12       akzo            q      9           Tablet
    ## 13       akzo            x      8           Laptop
    ## 14   phillips            p     56       Smartphone
    ## 15   phillips            v     67               TV
    ## 16   phillips            v     21               TV
    ## 17 van houten            x     45           Laptop
    ## 18 van houten            v     56               TV
    ## 19 van houten            v     65               TV
    ## 20 van houten            x     21           Laptop
    ## 21 van houten            p     23       Smartphone
    ## 22   unilever            x      3           Laptop
    ## 23   unilever            q      4           Tablet
    ## 24   unilever            q      6           Tablet
    ## 25   unilever            q      8           Tablet

4. Add full address for geocoding
---------------------------------

    data <- unite(data, "full_address",address,city,country, sep = ",")

5. Create dummy variables for company and product category
----------------------------------------------------------

    data <- data %>% mutate(company_philips = match(company, "phillips"),
                            company_akzo = match(company, "akzo"),
                            company_van_houten = match(company, "van houten"),
                            company_unilever = match(company, "unilever"),
                            product_smartphone = match(`Product category`, "Smartphone"),
                            product_tv = match(`Product category`, "TV"),
                            product_laptop = match(`Product category`, "Laptop"),
                            product_tablet = match(`Product category`, "Tablet"))
    data[is.na(data)] <- 0

Now the data is clean and it has the following structure

    ## Observations: 25
    ## Variables: 14
    ## $ company            <chr> "phillips", "phillips", "phillips", "philli...
    ## $ `Product code`     <chr> "p", "p", "x", "x", "x", "p", "v", "v", "x"...
    ## $ number             <chr> "5", "43", "3", "34", "12", "23", "43", "12...
    ## $ full_address       <chr> "Groningensingel 147,arnhem,the netherlands...
    ## $ name               <fct> dhr p. jansen, dhr p. hansen, dhr j. Gansen...
    ## $ `Product category` <chr> "Smartphone", "Smartphone", "Laptop", "Lapt...
    ## $ company_philips    <dbl> 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1...
    ## $ company_akzo       <dbl> 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0...
    ## $ company_van_houten <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
    ## $ company_unilever   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
    ## $ product_smartphone <dbl> 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0...
    ## $ product_tv         <dbl> 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1...
    ## $ product_laptop     <dbl> 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0...
    ## $ product_tablet     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0...
