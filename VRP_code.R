##################### VRP R Script ##################### 
library(tidyverse)
library(dplyr)

plsep<-.Platform$file.sep 
setwd("C:/Projects/Research/Vehicle_Routing_Problem") 
scenario <- c("Base Case", "Full Crowdshipping arbitrary end points", "Partial crowdshipping Return", "Public Transport PiggyBacking")
config_files <- c(paste0("Demand ",seq(8,10,0.5),"/DC.sumocfg"))
xml_files <- c(paste0("Demand ",seq(8,10,0.5),"/",c("E","D","C","B","A"),".xml"))
demand_files <- c(paste0("Demand ",seq(8,10,0.5),"/",c("E","D","C","B","A"),".csv"))
sum_tripinfo <- list()
myvars <- c("tripinfo_duration", "tripinfo_timeLoss", "tripinfo_waitingTime")
xml_csv <- "C:/Program Files (x86)/Eclipse/Sumo/tools/xml/xml2csv.py"
datasets <- c()
com <- c()

####------------------------------------------ Run Simulations for all configuration files ------------------------------------------####  
n <- 0
for (i in scenario){
  for (j in config_files){
    n <- n+1
    datasets[n] <- paste(i,j, sep = plsep)
    for (k in datasets){
      com[k] <- paste("sumo -c ", '"', paste(k),'"'," --device.emissions.probability 1.0",sep = "")
    }  
  }
}

for (z in com){
  system(paste(z))
}

## ------------------------------------------ Convert XML to CSV Files  
#system('python xml_csv input.xml -o output.csv')
datasets <- c()
com <- c()
n <- 0
for (i in scenario){
  for (j in xml_files){
    n <- n+1
    datasets[n] <- paste(i,j, sep = plsep)
  }
}

n <- 0
demandset <- c()
for (x in scenario){
  for (y in demand_files){
    n <- n+1
    demandset[n] <- paste(x,y, sep = plsep)
  }
}

datasets_new <- paste('"',paste(datasets), '"', sep = "")
demandset_new <-  paste('"',paste(demandset), '"', sep = "")
combined = paste(datasets_new, demandset_new, sep = " -o ")

com <- c()
for (i in combined){
  com[i] <- paste('python ','"',xml_csv,'" ', paste(i), sep = "")
} 

for (z in com){
  system(paste(z))
}

## ------------------------------------------ Create Sum Matrix of Network Efficiency variables 
sum_tripinfo <- list()
myvars <- c("tripinfo_duration", "tripinfo_timeLoss", "tripinfo_waitingTime")
datasets <- list()

n <- 0
for (i in scenario) {
  for (j in demand_files){
    n <- n+1
    datasets[[n]] <- read.csv(paste(i,j,sep = plsep), sep = ";")
    sum_tripinfo[[n]] <- colSums(datasets[[n]][,myvars])
  }
}

Sum_matrix1 <- data.frame(0,0,0)
names(Sum_matrix1) <- names(sum_tripinfo[[1]])
Sum_matrix1 <- Sum_matrix1[-1,]
for (i in 1:length(sum_tripinfo)) {
  Sum_matrix1 <- rbind(Sum_matrix1, sum_tripinfo[[i]])
}
colnames(Sum_matrix1)
Sum_matrix1 <- Sum_matrix1 %>% 
  rename(
    tripinfo_duration = "X544117",
    tripinfo_timeLoss  = "X345715.59",
    tripinfo_waitingTime  = "X227597",
  )
row.names(Sum_matrix1) <- c(paste0("BC ",c(seq(8,10,0.5))), 
                           paste0("CL ",c(seq(8,10,0.5))),
                           paste0("CL (R) ",c(seq(8,10,0.5))),
                           paste0("PT ",c(seq(8,10,0.5))))

view(Sum_matrix1)
network_efficiency <- Sum_matrix1 

## ------------------------------------------ Create Sum Matrix of Emisssions 
Sum_emissions <- list()
datasets <- list()
n <- 0

for (i in scenario) {
  for (j in demand_files){
    n <- n+1
    datasets[[n]] <- read.csv(paste(i,j,sep = plsep), sep = ";")
    Sum_emissions[[n]] <- colSums(datasets[[n]][,grep("emissions",names(datasets[[n]]))])
  }
}

Sum_matrix <- data.frame(0,0,0,0,0,0,0)
names(Sum_matrix) <- names(Sum_emissions[[1]])
Sum_matrix <- Sum_matrix[-1,]
for (i in 1:length(Sum_emissions)) {
  Sum_matrix <- rbind(Sum_matrix, Sum_emissions[[i]])
}
colnames(Sum_matrix)

Sum_matrix <- Sum_matrix %>% 
  rename(
    emissions_CO2_abs = "X1858044089.04325",
    emissions_CO_abs =  "X55505275.934888",
    emissions_HC_abs = "X772033.753864",
    emissions_NOx_abs = "X3017943.819628",
    emissions_PMx_abs = "X133583.326576",
    emissions_electricity_abs = "X0",
    emissions_fuel_abs = "X797623.472075"
  )
row.names(Sum_matrix) <- c(paste0("BC ",c(seq(8,10,0.5))), 
                           paste0("CL ",c(seq(8,10,0.5))),
                           paste0("CL (R) ",c(seq(8,10,0.5))),
                           paste0("PT ",c(seq(8,10,0.5))))
network_emissions <- Sum_matrix 
view(network_emissions)
network_macroscopic <- cbind(network_efficiency, network_emissions)
view(network_macroscopic)

#------------------------------------------- Save Work
write.csv(network_macroscopic, "network_macroscopic_vrp.csv")
