# Milestone 3 Reflection

### Functionality 
The majority of our time this milestone has been spent getting back to the same functionality and layout of our milestone 2 dashboard, but this time using R with dash. The app continues to allow users to rank features that are most important to them using three sliders for Health, Freedom, and Economy. These three sliders and their values then update both the world map, and the top ten country list. The map highlights the top 5 countries listed and keeps the remaining parts of the map faded. Individual countries on the map can be clicked on and this in turn populates the line graph directly below. This line graph shows the yearly trends for selected countries and a selected feature of interest.

### Improvements
bar plot

### R vs. Python
In milestone 2, connecting our map to the line graph proved to be quite difficult. The two objects had to be placed in the same function and treated as one object. With milestone 3 however, R and ggplotly made the design far easier to implement. Every country selected is simply passed to the graph and handled separately. On top of this, plotly provides a better default map view than altair. One limitation of our previous dashboard was that a user couldn't zoom in and out of the map, but this is now taken care of through plotly.
