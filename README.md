# Innovative_Last_Mile_Logistics

Welcome to our open-souced repository on innovative last mile solutions:

Responsible for over 24% of global Carbon Dioxide emissions and over 14% of annual GHG emissions the global transport sector must decarbonise rapidly if global climate change targets are to be met. In terms of transport modes, 72% of global emissions are derived from road vehicles with passenger road transport contributing to 3.6 GtCO2 nd freight vehicles accounting for 2.4 GtCO2. Within freight transportation, the last mile problem (LMP), the last leg of the delivery service, is consistently the most expensive and one of the highest polluting segments of the supply chain. Last-mile delivery (LMD) has increasingly received attention as the unprecedented growth in ecommerce has seen e-commerce sales triple globally between 2014-2019; placing considerable stress on city planners and businesses to deliver rapid, low-cost and sustainable last-mile services.

This code presents the implementation of varying innovative last mile delivery solutions using a transport simulator: SUMO. ”Simulation of Urban MObility” (SUMO) is an open source, microscopic and continuous traffic package that allows modelling of inter and multi modal traffic systems (Lopez et al., 2018). SUMO can be downloaded here: https://www.eclipse.org/sumo/ .To run simulations on Sumo, a network file consisting of edges (roads) and nodes (intersections), a route file including information about the trips that individual vehicles complete, and an additional information file which, among other features, details the location and size of bus and delivery stops, must be obtained. Throughout this repository we will be running simulations on the relevant network files which are provided in the repository. The network selected is a section of North Western Washington D.C and was downloaded from Open Street Maps.

This project is useful since it provides an open-sourced presentation of various (potential) last-mile delivery solutions of the future. These solutions include: 
 1. Base Case (BC)- Represents the traditional means of last mile delivery and act as the counterfactual to the remaining scenarios.
 2. Crowd Logistics (CL)- Highlights the consequences of an optimal crowdshipping model without feedback effects.
 3. Crowd Logistics Return (CL R)- Represents the worst-case scenario of crowd logistics methods where feedback effects are significant.
 4. Public Transport Piggybacking (PT)- Capture the effects of integrating freight delivery into passenger transportation services.
 5. Public Transport Piggybacking with Crowdshipping (PT + CL)- An extension to the PT scenario and present a novel logistic service opportunity where micro-depots provide the infrastructure requirements for crowd-shipping services to delivery the ”very last mile” low-capacity service.

The steps to run the simulations are as follows:
1. Download SUMO
2. Run the VRP_code.R on the files specified in the Vehicle Routing Problem folder. If you want to see how the routes were generated have a look at the VRP python notebook with for the correct scenario i.e. base case scenario would be VRP_BC.ipynb.
3. Check out the fun visuals we made with ggplot2 :). For viewing on Github check the VRP_analysis_markdown.md file or if you want to run them yourself please pull the VRP_analysis_markdown.Rmd file. 
4. Repeat steps for the Capacitated Vehicle Routing Files. 
5. For the Micro Depot analysis it is slightly different. The code and analysis can be found in one file (ucc_markdown.md for viewing ucc_markdown.Rmd for pulling). Please note the change in the CombinedStops.add.xml file compared to the previous simulations.
6. Enjoy, add, and let us know what you think!


We recommned that users develop our simulations in the following key areas: 
1. Many of our input values lacked realism: traffic data was randomly generated and simulated at differing levels of congestion, the weight of a delivery was assumed to approximate to a log-normal distribution, and bus routes and delivery locations were created on an ad-hoc basis. Therefore, we advise further studies to employ real-world data on those above mentioned inputs to more accurately simulate reality.
2. Crowd-shippers were always assumed willing to complete the necessary quantity of crowdshipped deliveries. While Gatta et al., 2019 has contributed to the behavioural aspects of crowd logistics, the literature in the field remains underdeveloped and thus with revealed or stated preference data, future studies should consider this potential market imperfection between the demand and supply of crowdshippers at different time periods and traffic conditions.
3. To represent the possibility of the crowd-detouring to complete crowdshipping trips, we created two scenarios, one representing a complete detour with a return journey and the other representing a best-case scenario where the crowdshippers trip ends at the point of delivery. Again, further developments to crowd logistics behavioural literature would enhance the simulations’ accuracy. However, in absence of this, a further scenario could be employed to represent a more realistic crowd logistics approach.
4. There is scope for advancements on the vehicle routing problem design to more realistically consider the constraints faced by courier services. Notably, future work should consider including time-windows constraints to more aptly consider demand necessities across a time period. 
5.  Loading and unloading could be integrated as part of the vehicle routing problem rather than having it exogenously input. Neglected in our work was an adequate consideration of parking availability at the point of delivery. Instead, information about parking availability and parking demand for each road within the network could be provided as a simulation input. 
6. The likely heterogeneous parking behaviours from those employed by couriers and from crowdshippers could be explored.


The authors of this project were Dylan Johnson and Manos Chianoakis and was made possible as part of the Bartlett Research Grant Scheme 2020-21. For direct questions feel free to email the authors at dylan.johnson.19@ucl.ac.uk and m.chaniotakis@ucl.ac.uk. 

We hope you enjoy ! 

