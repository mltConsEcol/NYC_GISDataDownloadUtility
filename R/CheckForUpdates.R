##CheckForUpdates -

CheckForUpdates <- function(datalist) {
  data.status <- data.frame()

  for (i in 1:nrow(datalist)) {

    if ((datalist$Data_Source[i] == 'NYCOpenData' &
         datalist$Format[i] == 'Shapefile') |
        (datalist$Data_Source[i] == 'NYCOpenData' &
         datalist$Format[i] == 'ESRI FileGDB')) {

      #Make sure the date isn't blank
      if ((datalist$Last_Download_Date[i]) != "")
      {
        #Pull in date updated from opendata website
        dataurl <- readLines(datalist$Data_URL[i])
        web_updated_date <-
          as.POSIXct(strsplit(dataurl[grep('aboutUpdateDate', dataurl)], c('>|<'))[[1]][11], format =
                       '%b %d, %Y')
        #Convert date updated from local files to posixct to compare with date on website
        local_updated_date <-
          as.POSIXct(datalist$Last_Download_Date[i], format = '%d-%b-%y')
        #If  date updated on website is older than local download date, report local data are up to date
        if (web_updated_date < local_updated_date) {
          data.status[i, 1] <- datalist$Dataset_Name[i]
          data.status[i, 2] <- 0
        } else if (web_updated_date >= local_updated_date) {
          #if updated date on website is more recent than local download date, calculate
          
          data.status[i, 1] <- datalist$Dataset_Name[i]
          data.status[i, 2] <-
            paste(as.character(web_updated_date - local_updated_date))
          } else {
          data.status[i, 1] <- datalist$Dataset_Name[i]
          data.status[i, 2] <- NA
        }
      }
    }
  }
  colnames(data.status) <- c("Dataset", "DaysBehind")
  return(data.status)
}




