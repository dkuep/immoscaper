
dir = "~/Desktop/immoscape/immodata/"
table1_cols_selected <- c("ID", "addr", "name_link", 'kalt')

data_list <- c("flaeche","zimmer","kalt", 
               "neben","warm","heiz")
# kalt <- c("min" = data$kalt %>% na.omit() %>% min() %>% floor(),
#           "max" = data$kalt %>% na.omit() %>% max() %>% ceiling())
# flaeche <- c("min" = data$flaeche %>% na.omit() %>% min() %>% floor(),
#              "max" = data$flaeche %>% na.omit() %>% max() %>% ceiling())
# zimmer <- c("min" = data$zimmer %>% na.omit() %>% min() %>% floor(),
#             "max" = data$zimmer %>% na.omit() %>% max() %>% ceiling())
columns_selected <- c("addr", "name_link", "addr_link")
# zips <- sort(unique(data$zip))