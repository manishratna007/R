library(tidyverse)
library(gganimate)
library(gifsky)
library(readxl)

case_tidy<-read_excel("C:/Users/T.M.K/Downloads/Day wise district wise cases 13.02.2021.xlsx",sheet = "Sheet1")


anim1 <- ggplot(case_tidy, aes(rank, group = District, 
                                  fill = as.factor(District), color = as.factor(District))) +
  geom_tile(aes(y = value/2,
                height = value,
                width = 0.9), alpha = 0.8, color = NA) +
  geom_text(aes(y = 0, label = paste(District, " ")), vjust = 0.2, hjust = 1) +
  geom_text(aes(y=value,label = Value_lbl, hjust=0)) +
  coord_flip(clip = "off", expand = FALSE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  guides(color = FALSE, fill = FALSE) +
  theme_minimal()+
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x = element_line( size=.1, color="grey" ),
        panel.grid.minor.x = element_line( size=.1, color="grey" ),
        plot.title=element_text(size=25, hjust=0.5, face="bold", colour="grey", vjust=-1),
        plot.subtitle=element_text(size=18, hjust=0.5, face="italic", color="grey"),
        plot.caption =element_text(size=8, hjust=0.5, face="italic", color="grey"),
        plot.background=element_blank(),
        plot.margin = margin(2,2, 2, 4, "cm")) +
  transition_states(Month, transition_length = 4, state_length = 1, wrap = FALSE) +
  view_follow(fixed_x = TRUE)  +
  view_follow(fixed_y=TRUE)+
  labs(title = 'WB COVID-19 Cases : {closest_state}',  
       subtitle  =  "District Level",
       caption  = "Total Monthly Cases") 

# For GIF

animate(anim1, 200, fps = 10,  width = 1200, height = 1000, 
        renderer = gifski_renderer("covid_gganim.gif"), end_pause = 25, start_pause =  25) 

