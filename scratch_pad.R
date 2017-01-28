##############LIBRARIES & SETTINGS###################
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggmap)
library(mapproj)

setwd('~/Dropbox/learning/NYCDSA/projects/NYCDSA_project_1/')

df_hs16 <- read.csv('Heat Seek NYC data 6-15 to 6-16.csv', stringsAsFactors = TRUE)
df_hs17 <- read.csv('Heat Seek NYC data 6-16 to 6-17.csv', stringsAsFactors = TRUE)
df_311data <- read.csv('311_Service_Requests_from_2010_to_Present.csv', stringsAsFactors = TRUE)

options(digits.secs = 6) #to include fractions of a second for timestamps
options(max.print = 100)

##############HELPER CODE###################
winterize <- function(df, col_name) {
  #winterize (aka translate the continous timestamp to categorical winter ranges)  
  #static values
  winters <- list('Winter_10'=c('10-01-2009','5-31-2010'),'Winter_11'=c('10-01-2010','5-31-2011'),'Winter_12'=c('10-01-2011','5-31-2012'),'Winter_13'=c('10-01-2012','5-31-2013'),'Winter_14'=c('10-01-2013','5-31-2014'),'Winter_15'=c('10-01-2014','5-31-2015'),'Winter_16'=c('10-01-2015','5-31-2016'),'Winter_17'=c('10-01-2016','5-31-2017'))
  winters <- sapply(winters, function(x) as.POSIXct(x, tz = 'EST', format = '%m-%d-%Y'))
  new_col_name = 'Winters'
  
  df[new_col_name] <- NA
  
  for (i in 1:(length(winters)/2)) {
    df[(df[col_name] >= winters[1,i] & df[col_name] <= winters[2,i]), new_col_name] = as.character(names(winters[1,i]))
  }
  return(df)
}

# c2f <- c('Agency','Agency.Name','Complaint.Type','Descriptor','Location.Type','Incident.Zip','Incident.Address','Street.Name','Community.Board','Borough','Status')
# df_311subset[c2f] <- sapply(df_311subset$c2f, function(x) as.factor(x)) #not working...ask why???

##############HEAT SEEK DATA CLEANING###################
df_hs <- full_join(df_hs16, df_hs17)

df_hs$created_at <- as.POSIXct(df_hs$created_at, format = "%Y-%m-%d %H:%M:%S", tz='EST')
df_hs$address <- as.factor(df_hs$address)
df_hs <- tbl_df(df_hs) %>% arrange(desc(created_at))

df_hs <- winterize(df_hs, 'created_at')
df_hs$Year <- as.factor(format(df_hs$created_at,'%Y'))
df_hs$Month <- as.factor(format(df_hs$created_at,'%m'))

##############311 DATA CLEANING###################
head(df_311data)
str(df_311subset)
View(df_311subset)

#clean up timestamps
df_311data$Created.Date <- as.POSIXct(df_311data$Created.Date, format = "%m/%d/%Y %I:%M:%S %p", tz="EST")
df_311data$Closed.Date <- as.POSIXct(df_311data$Closed.Date, format = "%m/%d/%Y %I:%M:%S %p", tz="EST")

#create subset of data we care about and sort by creation date
df_311subset <- df_311data[,c('Unique.Key','Created.Date','Closed.Date','Agency','Agency.Name','Complaint.Type','Descriptor','Location.Type','Incident.Zip','Incident.Address','Street.Name','Community.Board','Borough','Status')]
df_311subset <- tbl_df(df_311subset) %>% arrange(desc(Created.Date))

df_311subset <- winterize(df_311subset, 'Created.Date')
df_311subset$Winters <- as.factor(df_311subset$Winters)
df_311subset$Year <- as.factor(format(df_311data$Created.Date,'%Y'))
df_311subset$Month <- as.factor(format(df_311data$Created.Date,'%M'))



##############SUMMARIES AND GRAPHS###################


#summarize count of complaints by year
comp_count_by_year <- tbl_df(df_311subset) %>%
                        group_by(Year) %>%
                        summarise(num_complaints=count(Unique.Key))


count(df_311subset,Year)
count(df_311subset, Borough)



df_311subset[1,]

df_311subset$Year

str(df_311subset)





