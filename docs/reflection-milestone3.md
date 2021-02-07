# Milestone 4 Reflection

### Functionality 
The app continues to allow users to rank features that are most important to them using six sliders for different metrics. These six sliders and their values then update both the world map, and the top ten country list. The map will update by color depending on metrics entered by the user in the sliders. Individual countries on the map can be clicked on and this in turn populates the line graph directly below. This line graph shows the yearly trends for selected countries and a selected feature of interest.

### Improvements and Addressing Feedback
In addition to all of the features mentioned in the previous section, we have added a bar chart and an improved ranking algorithm for this iteration. The bar chart gives a nice visual of the top countries and their respective scores while the new algorithm is more refined to allow for a kind of weighted average of the slider values. Previously, the algorithm only looked at the slider with the highest value and updated the top countries accordingly. 

With regards to TA feedback, for this milestone and the last, we focused on simplifying our app to only the key components. We’ve created two concise graphs and a table with limited countries rather than 150+ countries as we had originally designed. We also limited our use of the historical data to the current year with the exception of the line graph.

### R vs. Python
In milestone 2, connecting our map to the line graph proved to be quite difficult. The two objects had to be placed in the same function and treated as one object. With milestone 3 however, R and ggplotly made the design far easier to implement. Every country selected is simply passed to the graph and handled separately. On top of this, plotly provides a better default map view than altair. The current version of the map allows for zooming and scrolling which was a limitation of our previous dashboard map. One downside of using Dash with R was that there didn't appear to be as much reference documentation as compared to Dash with python. 

### Looking to the Future
Now that we have the main features of our app designed we would like to focus our attention on layout, clarity, and further refinement. We want to ensure that every user is engaged when they first see the app, knows exactly the purpose behind each piece, and easily finds the best way to gain knowledge from the app as a whole. We also plan to make all connections between the map, plots, and table work in both directions seamlessly.

