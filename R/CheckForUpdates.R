#Might try to parallelize this, though it is difficult to update the datalist table in the same steps with foreach/doParallel
CheckForUpdates <- function(datalist){
for (i in 1:nrow(datalist)) {
  
  if ((datalist$Data_Source[i] == 'NYCOpenData' & datalist$Format[i] == 'Shapefile')|(datalist$Data_Source[i] == 'NYCOpenData' & datalist$Format[i] == 'ESRI FileGDB')) {
    #Check if the directory with appropriate data exists locally
    if ((datalist$Last_Download_Date[i])!= "")
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
        print(paste(datalist$Dataset_Name[i], "is Up To Date"))
        
      } else {
        
        #if updated date on website is more recent than local download date, calculate
        print(paste(datalist$Dataset_Name[i], "may be out of date by ", as.character(web_updated_date - local_updated_date), " days"))}
      } else {print(paste("no local copy of ", datalist$Dataset_Name[i]))}
} }
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
  
  
  
  
  ###Testing code-snippits
#Read lines from webpage
system.time(req <- readLines("https://data.cityofnewyork.us/City-Government/Parks-Properties/rjaj-zgq7"))

#Pull out the Update date and convert to POSIXct from Mon. date, YEAR [can be directly compared to other date]
t1 <- as.POSIXct(strsplit(req[grep('aboutUpdateDate', req)], c('>|<'))[[1]][11], format='%b %d, %Y')

t2 <- as.POSIXct(Sys.Date())

t2-t1

#Pull
