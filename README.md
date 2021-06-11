# Innovative_Last_Mile_Logistics

Welcome to our open-souced repository on innovative last mile solutions:

Responsible for over 24% of global Carbon Dioxide emissions and over 14% of annual GHG emissions the global transport sector must decarbonise rapidly if global climate change targets are to be met. In terms of transport modes, 72% of global emissions are derived from road vehicles with passenger road transport contributing to 3.6 GtCO2 nd freight vehicles accounting for 2.4 GtCO2. Within freight transportation, the last mile problem (LMP), the last leg of the delivery service, is consistently the most expensive and one of the highest polluting segments of the supply chain. Last-mile delivery (LMD) has increasingly received attention as the unprecedented growth in ecommerce has seen e-commerce sales triple globally between 2014-2019; placing considerable stress on city planners and businesses to deliver rapid, low-cost and sustainable last-mile services.

This code presents the implementation of varying innovative last mile delivery solutions using a transport simulator: SUMO. ”Simulation of Urban MObility” (SUMO) is an open source, microscopic and continuous traffic package that allows modelling of inter and multi modal traffic systems (Lopez et al., 2018). SUMO can be downloaded here: https://www.eclipse.org/sumo/ .To run simulations on Sumo, a network file consisting of edges (roads) and nodes (intersections), a route file including information about the trips that individual vehicles complete, and an additional information file which, among other features, details the location and size of bus and delivery stops, must be obtained. Throughout this repository we will be running simulations on the relevant network files which are provided in the repository. The network selected is a section of North Western Washington D.C and was downloaded from Open Street Maps.

This project is useful since it provides an open-sourced presentation of various (potential) last-mile delivery solutions of the future. These solutions include: 
 1. Base Case (BC)- Represent the traditional means of last mile delivery and act as the counterfactual to the remaining scenarios.
 2. Crowd Logistics (CL)- Highlights the consequences of an optimal crowdshipping model without feedback effects.
 3. Crowd Logistics Return (CL R)- Represents the worst-case scenario of crowd logistics methods where feedback effects are significant.
 4. Public Transport Piggybacking (PT)- Capture the effects of integrating freight delivery into passenger transportation services.
 5. Public Transport Piggybacking with Crowdshipping (PT + CL)- An extension to the PT scenario and present a novel logistic service opportunity where micro-depots provide the infrastructure requirements for crowd-shipping services to delivery the ”very last mile” low-capacity service.


Users can further develope our simulations through adding additional ...

The contributes of this project were Dylan Johnson and Manos Chianoakis. 

We hope you enjoy ! 

