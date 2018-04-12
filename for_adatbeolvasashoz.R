# Flanker kiserlet output tablazatok beolvasasa ####
flanker_files = dir("data/flanker_data_raw/")

if(exists("flanker_data")) rm(flanker_data)


for(flanker_file in flanker_files){
    
    if(!(exists("flanker_data"))){
        
        flanker_data <- read_csv( paste0("data/flanker_data_raw/", flanker_file) )
        flanker_data$ID <-  flanker_file
        
    }else{
        
        next_flanker_data <- read_csv( paste0("data/flanker_data_raw/", flanker_file) )
        next_flanker_data$ID <-  flanker_file
        flanker_data <- rbind(flanker_data, next_flanker_data)
        
    }
}
# Adam komment:
# # Enennyit meg hozzatennek, hogy az ID-kbol kipucoljuk a folosleget:
# head(flanker_data$ID)
# flanker_data$ID = gsub('.csv','',gsub('subject-','',flanker_data$ID))
# head(flanker_data$ID)

# Muhaha, egy sorban az egész beolvasás!
flanker_data <- Reduce({function (x, y) merge(x, y, all=T)},
                        Map({function (file_name) read.csv(paste0('data/flanker_raw_data/',
                                                                  file_name))},
                            dir('data/flanker_raw_data/')))
head(flanker_data)

