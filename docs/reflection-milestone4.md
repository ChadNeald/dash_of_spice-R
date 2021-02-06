# Milestone 4 Reflection

### Functionality 
The app allows users to rank features that are most important to them using six sliders for different metrics. These six sliders and their values then update both the world map, and the top ten country list. The map will update by color depending on metrics entered by the user in the sliders. Individual countries on the map can be clicked on and this, in turn, updates the dropdown menu and populates the line graph and the bar chart directly below. This line graph shows the yearly trends for selected countries and a selected feature of interest. At the same time, the bar chart compares the 2020 happiness scores for two or more countries showing the happiness rank of each country when the user hovers over the bar. When only one country is selected on the map or in the map dropdown menu, the bar chart displays a trend in the happiness score for that country from 2015 to 2020. By default, when no country is selected the line graph and the bar chart show the global average happiness score.

### Improvements and Addressing Feedback
Based on the TA feedback for Milestones 2 and 3, we have improved the ranking algorithm, wisely connected the visual features of our dashboard, and adjusted the layout. As for the TA suggestion related to creating a stacked bar chart instead of the table, we have decided that keeping the top 10 countries table and the bar chart that changes depending on the incoming data would be a better representation of the overall picture in terms of happiness in different countries of the world.

With regards to TA feedback, for this milestone and the last, we focused on simplifying our app to only the key components. We’ve created two concise graphs and a table with limited countries rather than 150+ countries as we had originally designed. We also limited our use of the historical data to the current year with the exception of the line graph.

### R vs. Python
In milestone 2, connecting our map to the line graph proved to be quite difficult. The two objects had to be placed in the same function and treated as one object. With milestone 3 however, R and ggplotly made the design far easier to implement. Every country selected is simply passed to the graph and handled separately. On top of this, plotly provides a better default map view than altair. The current version of the map allows for zooming and scrolling which was a limitation of our previous dashboard map. One downside of using Dash with R was that there didn't appear to be as much reference documentation as compared to Dash with python. 

### Looking to the Future
Now that we have the main features of our app designed we would like to focus our attention on layout, clarity, and further refinement. We want to ensure that every user is engaged when they first see the app, knows exactly the purpose behind each piece, and easily finds the best way to gain knowledge from the app as a whole. We also plan to make all connections between the map, plots, and table work in both directions seamlessly.



Not to forget:
1) You will be receiving the M3 feedback from your TA sometime today if you didn't already receive it yesterday. To reiterate what I said during lab: you don't need to implement this feedback but your TAs nicely agreed to prioritize the milestone grading this week, so that you could see some of their tips for how you could improve your final app before Saturday. Since we are grading the final state of the app for M4, it is likely beneficial to your to try to address the most pressing concerns if you haven't already. But don't feel like you need to implement everything they said in just two days (it could be a good idea to reflect on it though).
2) In the reflection section of the Milestone 4 document, please include a few sentences on why your chose R/ggplotly or Python/Altair to illustrate that you have evaluated these two options based on sound criteria for your app. This is also useful for me to read when planning future iterations of this course.
3) In this section, your group should document on what you have implemented in your dashboard so far and explain what is not yet implemented. It is important that you include what you know is not working in your dashboard, so that your TAs can distinguish between features in development and bugs. Since this is the last milestone, you really need to motivate well why you have not chosen to include some feature that you were planning on including previously.

This week it is suitable to include thoughts on the feedback you received from your peer and/or TA, e.g.

Has it been easy to use your app?
Are there reoccurring themes in your feedback on what is good and what can be improved?
Is there any feedback (or other insight) that you have found particularly valuable during your dashboard development?
This section should be around 300-500 words and the reflection-milestone4.md document should live in your GitHub.com repo in the doc folder.

