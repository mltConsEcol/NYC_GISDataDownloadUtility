#Download Datasets for the first time
#Import list of data; Copy of the table with datasets is in inst/extdata


initialDataDownload <- function(datalist) {
  #### Define function to extract and unzip file from the internet
  download_extract_zip <- function(url, datasetname, folder) {
    dir.create('temp')
    download.file(
      url, destfile = paste('temp/', datasetname, '.zip', sep =
                              ''), method = "wget", quiet = TRUE
    )
    unzip(paste('temp/', datasetname, '.zip', sep = ''), exdir =
            folder)
    unlink('temp', recursive = TRUE)
  }
  
  
  for (i in 1:nrow(datalist)) {
    if ((datalist$Data_Source[i] == 'NYCOpenData' &
         datalist$Format[i] == 'Shapefile') |
        (datalist$Data_Source[i] == 'NYCOpenData' &
         datalist$Format[i] == 'ESRI FileGDB')) {
      #Pull in date updated from opendata website
      dataurl <- readLines(datalist$Data_URL[i])
      web_updated_date <-
        as.POSIXct(strsplit(dataurl[grep('aboutUpdateDate', dataurl)], c('>|<'))[[1]][11], format =
                     '%b %d, %Y')

      dir.create(datalist$Folder[i], recursive = TRUE)
      download_extract_zip(
        url = datalist$Download_URL[i], datasetname = datalist$Dataset_Name[i], folder =
          datalist$Folder[i]
      )
      datalist$Last_Download_Date[i] <-
        format(Sys.Date(), format = '%d-%b-%y')
      datalist$Updated_Date[i] <-
        format(web_updated_date, format = '%d-%b-%y')
      
      #Indicate the dataset was acquired
      print(paste(datalist$Dataset_Name[i], "was acquired"))
    }
  }
}

#If desired, write out new version of data list with updated dates
#write.csv(datalist, file = "DataList.csv", row.names = FALSE)



#http://www1.nyc.gov/assets/planning/download/zip/data-maps/open-data/bx_mappluto_16v1.zip - sample link for downloading mappluto data


#General Workflow:
# Read table of existing data
# For each row, focus on folder, not specific shapefile, as shapefile names change - will keep folder name consistent though [each shapefile and associated files will go in its own folder]
# For row, look at data source - protocol will vary slightly from source to source
# Is updated dated in html Date > last download date? OR is updated date unavailable?
# Yes -> Move files in folder into archive folder;
# use download link to initate download; download into temp dir;
# unzip into appropriate folder
# If file is shapefile


#Required Columns
-# # Data Source (e.g., NYC Open Data, )
  -# # Dataset Name
  -# # Folder
  -# # Download Date
  -# # Download URL
  --# # Data URL (NYC Open Data Page)
  --# # Object Type (Polygons)
  --# # Format (shapefile, gdb, raster, csv)
  # # postgis schema
  # # postgis table name
  
  #Desired Columns
  # # Dataset Description
  # # Notes
