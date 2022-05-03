install.packages("tidyverse")
install.packages("dplyr")
install.packages("reader")
library(tidyverse)
library(dplyr)
library(reader)



rideinfo01 <- read.csv("tripdata-2021-1.csv")
rideinfo02 <- read.csv("tripdata-2021-2.csv")
rideinfo03 <- read.csv("tripdata-2021-3.csv")
quater1_2021<- rbind(rideinfo01,rideinfo02,rideinfo03)

View(quater1_2021)

write_csv(quater1_2021, file="Q1_2021.csv")


rideinfo04 <- read.csv("tripdata-2021-4.csv")
rideinfo05 <- read.csv("tripdata-2021-5.csv")
rideinfo06 <- read.csv("tripdata-2021-6.csv")
quater2_2021<- rbind(rideinfo04,rideinfo05,rideinfo06)

View(quater2_2021)

write_csv(quater2_2021, file="Q2_2021.csv")


rideinfo07 <- read.csv("tripdata-2021-7.csv")
rideinfo08 <- read.csv("tripdata-2021-8.csv")
rideinfo09 <- read.csv("tripdata-2021-9.csv")
quater3_2021<- rbind(rideinfo07,rideinfo08,rideinfo09)

View(quater3_2021)

write_csv(quater3_2021, file="Q3_2021.csv")


rideinfo10 <- read.csv("tripdata-2021-10.csv")
rideinfo11 <- read.csv("tripdata-2021-11.csv")
rideinfo12 <- read.csv("tripdata-2021-12.csv")
quater4_2021<- rbind(rideinfo10,rideinfo11,rideinfo12)

View(quater4_2021)

write_csv(quater4_2021, file="Q4_2021.csv")


rideinfo2021 <-rbind(quater1_2021,quater2_2021,quater3_2021,quater4_2021)
View(rideinfo2021)
write_csv(rideinfo2021, file="rideinfo2021.csv")