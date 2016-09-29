setwd("~/../../media/sf_N_DRIVE/Raw_Data/NYC_TNC_NYCprogram/Version2_testing/")



##setwd("N:/Raw_Data/NYC_TNC_NYCprogram/Version2_testing/") #For Windows

#Import list of data; Copy of the table with datasets is in inst/extdata
datalist <- read.csv("DataList.csv", stringsAsFactors=FALSE)

datalist

system.time(CheckForUpdates(datalist))
