# Calculation of estimated extinction distance

# Load packages
library(data.table)       
library(ggplot2)
library(kableExtra)
library(knitr)
# import csv containing ambient sound and sound transmission amplitudes
detection.spaces0<-fread("./Estimated_extinction_distance/Group3_Malte_Robin_Moe.csv")
# detection.spaces0<-fread("./Estimated_extinction_distance/detection_space.csv")


#'log-transform distances
detection.spaces0[,distance_m_log:=log(distance_m)]

# calculate extinction distances based on linear fits of sound transmission
detection.spaces1=detection.spaces0[!is.na(amp_db) & type=="signal",
                                    .(intercept=coef(lm(amp_db~distance_m_log))[1],
                                      slope=coef(lm(amp_db~distance_m_log))[2]),
                                    .(direction,freq_khz)]

# extract values separately for each microphone and amplitude direction
detection.spaces2=merge(detection.spaces1,
                        detection.spaces0[!is.na(amp_db) & type=="ambient",
                                          .(ambient_db=mean(amp_db)),
                                          .(freq_khz)],
                        by="freq_khz")

# calculate extinction distance, exponentiated to back-transform the log values
detection.spaces2[,extinction_m:=exp((ambient_db-intercept)/slope)]

# Column `extinction_m` in the data frame `detection.spaces2` contains the extinction distance.
detection.spaces2
detection.spaces2 %>%
  kable(format = "html", 
        digits = 2,
        caption = "Extinction Distance Table") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"),
                full_width = FALSE,
                position = "center")

kable(detection.spaces2) %>%
  kable_styling("striped", position = "left", font_size = 10)

# graph the sound profiles for each direction
ggplot(detection.spaces0[!is.na(amp_db) & type=="signal"],
       aes(distance_m_log,amp_db,color=as.factor(freq_khz)))+
  geom_point()+
  geom_line(method="lm",fullrange=T,stat="smooth",alpha=0.3,se=F)+
  geom_line(method="lm",stat="smooth")+
  # we average the ambient amplitude over both channels
  geom_hline(data=detection.spaces2[!is.na(ambient_db),
                                    .(amp_db=mean(ambient_db)),
                                    .(freq_khz)],
             aes(yintercept=amp_db,color=as.factor(freq_khz)))+
  geom_segment(data=detection.spaces2[!is.na(extinction_m),
                                      .(extinction_m=unique(extinction_m),
                                        ambient_db=unique(ambient_db)),
                                      .(direction,freq_khz)],
               aes(x=log(extinction_m),
                   xend=log(extinction_m),
                   y=-Inf,yend=ambient_db,
                   color=as.factor(freq_khz)),lty=2)+
  scale_x_continuous(breaks=detection.spaces0[!is.na(distance_m),
                                              unique(distance_m_log)],
                     labels=detection.spaces0[!is.na(distance_m),
                                              unique(distance_m)])+
  facet_wrap(~paste(direction,sep=" - "))+
  labs(
       x = "Distance (m)",
       y = "Amplitude (dB)",
       color = "Frequency (kHz)"
       )+
  theme_classic()

