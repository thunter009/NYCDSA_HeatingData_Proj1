library(dplyr)
library(tidyr)
library(ggplot2)
library(ggmap)
library(mapproj)

setwd('~/Dropbox/learning/NYCDSA/projects/project_1/')

df_hs16 <- read.csv('Heat Seek NYC data 6-15 to 6-16.csv', stringsAsFactors = TRUE)
df_hs17 <- read.csv('Heat Seek NYC data 6-16 to 6-17.csv', stringsAsFactors = TRUE)
df_311data <- read.csv('311_Service_Requests_from_2010_to_Present.csv', stringsAsFactors = TRUE)

# Heat Seek data scrubbing
options(digits.secs = 6) #to include fractions of a second for timestamps
df_hs <- full_join(df_hs16, df_hs17)

#timestamps
df_hs$created_at <- strptime(df_hs$created_at, format = "%Y-%m-%d %H:%M:%S", tz='EST')
sort(df_hs$created_at, decreasing = FALSE)
df_hs$address <- as.factor(df_hs$address)

#Clean 311 Data
as.POSIXct(df_311data$Created.Date, format = "%m/%d/%Y %I:%M:%S %p", tz="EST")

df_311data$Created.Date <- as.POSIXct(df_311data$Created.Date, format = "%m/%d/%Y %I:%M:%S %p", tz="EST")
df_311data$Closed.Date <- as.POSIXct(df_311data$Closed.Date, format = "%m/%d/%Y %I:%M:%S %p", tz="EST")

#create subset of data we care about and 
df_311subset <- df_311data[,c('Unique.Key','Created.Date','Closed.Date','Agency','Agency.Name','Complaint.Type','Descriptor','Location.Type','Incident.Zip','Incident.Address','Street.Name','Community.Board','Borough','Status')]
# df_311subset$Year <- format(as.Date(df_311data$Created.Date,'%m/%d/%Y'),'%Y')
df_311subset$Year <- as.factor(format(df_311data$Created.Date,'%Y'))

##############HELPER CODE###################
str(df_311subset)
unique(df_311subset$Incident.Zip)
#create list of "winter" date ranges (heating seasons)
winters <- list('Winter_10'=c('10-01-2009','5-31-2010'),'Winter_11'=c('10-01-2010','5-31-2011'),'Winter_12'=c('10-01-2011','5-31-2012'),'Winter_13'=c('10-01-2012','5-31-2013'),'Winter_14'=c('10-01-2013','5-31-2014'),'Winter_15'=c('10-01-2014','5-31-2015'),'Winter_16'=c('10-01-2015','5-31-2016'),'Winter_17'=c('10-01-2016','5-31-2017'))
winters <- sapply(winters, function(x) as.POSIXct(x, format = '%m-%d-%Y', tz = 'EST')) #returns a matrix

winterize_dates <- function(x){
  for (i in (length(winters)/2)) {
    if (x >= winters[1,i] & x <= winters[2,i] ) {print(names(winters[1,i]))}
  }
}

##############HELPER CODE###################


# c2f <- c('Agency','Agency.Name','Complaint.Type','Descriptor','Location.Type','Incident.Zip','Incident.Address','Street.Name','Community.Board','Borough','Status')
# df_311subset[c2f] <- sapply(df_311subset$c2f, function(x) as.factor(x)) #not working...ask why???


#summarize count of complaints by year
comp_count_by_year <- tbl_df(df_311subset) %>%
                        # select(Borough, Created.Date) %>%
                        group_by(Complaint.Type) %>%
                        summarise()

str(df_311subset)

tbl_df(df_311subset) %>%
  group_by(Complaint.Type)




