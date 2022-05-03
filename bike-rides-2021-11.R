install.packages("tidyverse")
install.packages("reader")
install.packages("tidyr")
install.packages("lubridate")
library(lubridate)
library("tidyr")
library(tidyverse)
library(dplyr)
library(reader)

tripdata11 <- read.csv("202111-divvy-tripdata.csv")

head(tripdata11)
colnames(tripdata11)
View(tripdata11)

tripdata_sub11 <- subset(tripdata11, select = c("ride_id","started_at","ended_at","start_station_name","end_station_name","member_casual","rideable_type"))


clean_tripdatasub11 <- tripdata_sub11 %>% filter(ride_id !="") %>%
  filter(started_at!="") %>%
  filter(ended_at!="") %>%
  filter(start_station_name!="") %>%
  filter(end_station_name!="") %>%
  filter(member_casual!="") %>% 
  filter(rideable_type!="")

str(clean_tripdatasub11)

clean_tripdatasub11$started_at <- as.POSIXct(clean_tripdatasub11$started_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
clean_tripdatasub11$ended_at <- as.POSIXct(clean_tripdatasub11$ended_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
View(clean_tripdatasub11)
clean_tripdatasub11 <- clean_tripdatasub11 %>% mutate(ridetime=difftime(ended_at,started_at, units = "mins"))

new_tripdata11 <- clean_tripdatasub11 %>% filter(ridetime > 0)
View(new_tripdata11)


write_csv(new_tripdata11, file="tripdata-2021-11.csv")