library(jsonlite)
library(ggplot2)
google_location_data <- 
  fromJSON("~/googlearchive/Takeout/Standortverlauf/Standortverlauf.json", flatten = TRUE)

google_locations <- google_location_data$locations
Sys.setlocale("LC_TIME", "C")
google_locations$timekeeping <- as.POSIXct(as.numeric(google_locations$timestampMs)/1000, origin="1970-01-01")
google_locations$weekdays <- factor(format(google_locations$timekeeping, "%a"), 
                                    levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))

ggplot(google_locations, aes(x=timekeeping)) + geom_histogram()
ggplot(google_locations) +
  geom_line(aes(x=format(timekeeping, "%H"), y = (..count..)/(464.7/7),
                 group = weekdays,
                 color = weekdays), 
           stat = "count",
           size = 1) +
  geom_line(aes(x=format(timekeeping, "%H"), y = (..count..)/(464.7), 
                group = 1),
            stat = "count",
            linetype = 2,
            size = 0.7) + 
  scale_color_brewer(palette = "Set2") +
  theme_bw() + 
  labs(color = "Weekdays",
       title = "Hourly Overview of Google Location Data",
       caption =  "Based on data from Google Takeout of Sebastian Schweer. Average taken over 465 days.") +
  ylab("Number of Measurements per Day (Average)") + 
  xlab("Hour of the Day")
  

