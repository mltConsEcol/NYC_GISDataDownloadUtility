#### Define function to extract and unzip file from the internet
download_extract_zip <- function(url, datasetname, folder) {
  dir.create('temp')
  download.file(
    url, destfile = paste('temp/', datasetname, '.zip', sep =
                            ''), method = "wget", quiet=TRUE
  )
  unzip(paste('temp/', datasetname, '.zip', sep = ''), exdir =
          folder)
  unlink('temp', recursive = TRUE)
}



get_updated_date <- function(url, datasource){
  
  
}


dataurl <- readLines(datalist$Data_URL[1])
head(dataurl)


library(pdftools)
tex1 <- pdf_text("http://www1.nyc.gov/assets/planning/download/pdf/data-maps/open-data/meta_mappluto.pdf")

test <- strsplit(tex1[grep('CREATION DATE', tex1)], "\n")

str(test)

strsplit(test[[1]][grep('CREATION DATE', test)], '  ')

print(test[[1]][grep('CREATION DATE', test)])

unlist(test)[grep('    CREATION DATE 2016-03-15 00:00:00', test)]

unlist(test)[14]

strsplit(strsplit(tex1[grep('CREATION DATE', tex1)], "\n")[grep('CREATION DATE', strsplit(tex1[grep('CREATION DATE', tex1)], split = '\n'))], " ")
