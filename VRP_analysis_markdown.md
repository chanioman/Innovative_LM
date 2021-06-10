VRP\_analysis
================
Dylan Johnson
10/06/2021

## London Packages

``` r
library(ggplot2)
library(ggpubr)
library(ggthemes)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(knitr)
opts_chunk$set(dev="png")
```

## Reading Dataframe

``` r
colnames(network_macroscopic)[1]<-"Scenario"
network_macroscopic$Scenario <- gsub('[[:digit:]]+', '', network_macroscopic$Scenario)
network_macroscopic$Congestion <- c(rep(seq(.8,1,0.05)))
network_macroscopic$Scenario <- c(rep(paste0("BC"), times = 5), 
                                  rep(paste0("CL"), times = 5),
                                  rep(paste0("CL(R)"), times = 5),
                                  rep(paste0("PT"), times = 5))

network_macroscopic <- network_macroscopic[, c(1,12,2:11)]
network_macroscopic$Congestion <- as.factor(network_macroscopic$Congestion)
network_macroscopic$Scenario <- as.factor(network_macroscopic$Scenario)
network_macroscopic$Congestion <- fct_rev(network_macroscopic$Congestion)
network_macroscopic$CO2_kg <- network_macroscopic$emissions_CO2_abs/1000000
network_macroscopic$CO_kg <- network_macroscopic$emissions_CO_abs/1000000
network_macroscopic$HC_kg <- network_macroscopic$emissions_HC_abs/1000000
network_macroscopic$NOx_kg <- network_macroscopic$emissions_NOx_abs/1000000
network_macroscopic$PMx_kg <- network_macroscopic$emissions_PMx_abs/1000000
```

``` r
co2_vrp  <- ggplot(network_macroscopic, aes(x = Scenario, y = CO2_kg, colour = Congestion, group = Congestion)) + 
  geom_line(size=1, linetype=3) + 
  scale_colour_viridis(discrete = TRUE)+
  geom_point(size=3) + 
  theme_bw() +
  xlab("Scenario") +
  ylab(expression('CO'[2]*' Emissions (kg)') ) +
  theme(axis.title.x=element_text(size=12)) +
  theme(axis.text.x=element_text(size=10, face = "bold")) + 
  theme(axis.title.y=element_text(size=12, face = "bold")) +
  theme(axis.text.y=element_text(size=10, face = "bold")) +
  theme(legend.title=element_text(size=10, face= "bold"))+
  theme(legend.text=element_text(size=8, face = "bold")) +
  guides(fill=guide_legend(title= "Network \nCongestion")) +
  scale_x_discrete(limits = c("CL(R)", "BC", "CL", "PT"))
co2_vrp
```

![](README_figs_vrp/C02_vrp-1.png)<!-- -->

## Hydrocarbon

``` r
HC_vrp  <- ggplot(network_macroscopic, aes(x = Scenario, y = HC_kg, colour = Congestion, group = Congestion)) + 
  geom_line(size=1, linetype=3) + 
  scale_colour_viridis(discrete = TRUE)+
  geom_point(size=3) + 
  theme_bw() +
  xlab("Scenario") +
  ylab(expression('HC Emissions (kg)') ) +
  theme(axis.title.x=element_text(size=12)) +
  theme(axis.text.x=element_text(size=10, face = "bold")) + 
  theme(axis.title.y=element_text(size=12, face = "bold")) +
  theme(axis.text.y=element_text(size=10, face = "bold")) +
  theme(legend.title=element_text(size=10, face= "bold"))+
  theme(legend.text=element_text(size=8, face = "bold")) +
  guides(fill=guide_legend(title= "Congestion")) +
  scale_x_discrete(limits = c( "BC", "CL(R)", "CL", "PT"))
HC_vrp
```

![](README_figs_vrp/hydrocarbon_vrp-1.png)<!-- -->

## Nitrogen Oxide

``` r
NOx_vrp  <- ggplot(network_macroscopic, aes(x = Scenario, y = NOx_kg, colour = Congestion, group = Congestion)) + 
  geom_line(size=1, linetype=3) + 
  scale_colour_viridis(discrete = TRUE)+
  geom_point(size=3) + 
  theme_bw() +
  xlab("Scenario") +
  ylab(expression('NOx Emissions (kg)') ) +
  theme(axis.title.x=element_text(size=12)) +
  theme(axis.text.x=element_text(size=10, face = "bold")) + 
  theme(axis.title.y=element_text(size=12, face = "bold")) +
  theme(axis.text.y=element_text(size=10, face = "bold")) +
  theme(legend.title=element_text(size=10, face= "bold"))+
  theme(legend.text=element_text(size=8, face = "bold")) +
  guides(fill=guide_legend(title= "Congestion")) +
  scale_x_discrete(limits = c( "BC", "CL(R)", "CL", "PT"))
NOx_vrp
```

![](README_figs_vrp/NOx_vrp-1.png)<!-- -->

\#\#Particulate Matter

``` r
PMx  <- ggplot(network_macroscopic, aes(x = Scenario, y = PMx_kg, colour = Congestion, group = Congestion)) + 
  geom_line(size=1, linetype=3) + 
  scale_colour_viridis(discrete = TRUE)+
  geom_point(size=3) + 
  theme_bw() +
  xlab("Scenario") +
  ylab(expression('PMx Emissions (kg)') ) +
  theme(axis.title.x=element_text(size=12)) +
  theme(axis.text.x=element_text(size=10, face = "bold")) + 
  theme(axis.title.y=element_text(size=12, face = "bold")) +
  theme(axis.text.y=element_text(size=10, face = "bold")) +
  theme(legend.title=element_text(size=10, face= "bold"))+
  theme(legend.text=element_text(size=8, face = "bold")) +
  guides(fill=guide_legend(title= "Congestion")) +
  scale_x_discrete(limits = c( "BC", "CL(R)", "CL", "PT"))
PMx
```

![](README_figs_vrp/Particulate%20Matter-1.png)<!-- -->

# Network Effects

##### Duration

``` r
network_macroscopic$duration_hr <- network_macroscopic$tripinfo_duration/3600
network_macroscopic$timeLoss_hr <- network_macroscopic$tripinfo_timeLoss/3600
network_macroscopic$waitingTime_hr <- network_macroscopic$tripinfo_waitingTime/3600
```

``` r
Duration  <- ggplot(network_macroscopic, aes(x = Scenario, y = duration_hr, colour = Congestion, group = Congestion)) + 
  geom_line(size=1, linetype=3) + 
  scale_colour_viridis(discrete = TRUE)+
  geom_point(size=3) + 
  theme_bw() +
  xlab("Scenario") +
  ylab(expression('Total Network Trip Time (hr)') ) +
  theme(axis.title.x=element_text(size=12)) +
  theme(axis.text.x=element_text(size=10, face = "bold")) + 
  theme(axis.title.y=element_text(size=12, face = "bold")) +
  theme(axis.text.y=element_text(size=10, face = "bold")) +
  theme(legend.title=element_text(size=10, face= "bold"))+
  theme(legend.text=element_text(size=8, face = "bold")) +
  guides(fill=guide_legend(title= "Network \n Congestion")) + 
  scale_x_discrete(limits = c("CL(R)","CL","BC","PT"))
Duration
```

![](README_figs_vrp/duration_vrp-1.png)<!-- -->

# Time Loss

``` r
Time_loss  <- ggplot(network_macroscopic, aes(x = Scenario, y = timeLoss_hr, colour = Congestion, group = Congestion)) + 
  geom_line(size=1, linetype=3) + 
  scale_colour_viridis(discrete = TRUE)+
  geom_point(size=3) + 
  theme_bw() +
  xlab("Scenario") +
  ylab(expression('Total Network Time Loss (hr)') ) +
  theme(axis.title.x=element_text(size=12)) +
  theme(axis.text.x=element_text(size=10, face = "bold")) + 
  theme(axis.title.y=element_text(size=12, face = "bold")) +
  theme(axis.text.y=element_text(size=10, face = "bold")) +
  theme(legend.title=element_text(size=10, face= "bold"))+
  theme(legend.text=element_text(size=8, face = "bold")) +
  guides(fill=guide_legend(title= "Congestion")) + 
  scale_x_discrete(limits = c("CL(R)","CL","BC","PT"))
Time_loss
```

![](README_figs_vrp/time_loss_vrp-1.png)<!-- -->

# Waiting\_Time

``` r
Waiting_time  <- ggplot(network_macroscopic, aes(x = Scenario, y = waitingTime_hr, colour = Congestion, group = Congestion)) + 
  geom_line(size=1, linetype=3) + 
  scale_colour_viridis(discrete = TRUE)+
  geom_point(size=3) + 
  theme_bw() +
  xlab("Scenario") +
  ylab(expression('Total Network Wait Time (hr)') ) +
  theme(axis.title.x=element_text(size=12)) +
  theme(axis.text.x=element_text(size=10, face = "bold")) + 
  theme(axis.title.y=element_text(size=12, face = "bold")) +
  theme(axis.text.y=element_text(size=10, face = "bold")) +
  theme(legend.title=element_text(size=10, face= "bold"))+
  theme(legend.text=element_text(size=8, face = "bold")) +
  guides(fill=guide_legend(title= "Congestion")) +
  scale_x_discrete(limits = c("CL(R)","CL","BC","PT"))
Waiting_time
```

![](README_figs_vrp/waiting_vrp_time-1.png)<!-- -->
