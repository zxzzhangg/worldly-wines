# Milestone 4 Writeup

### Changes Made for Milestone 4

Usage and Introduction Tab:
* We added a usage tab as the landing page to provide users a brief introduction to the app. This could be helpful for a first time user to have an idea on the objective of this app and how to navigate a possible usage scenario.  We felt these changes were the best thing to focus on as during the *fly on the wall* session, we were able to watch the testers and their confusion while using the app.  A landing page was suggested during the feedback and seemed like one of the best things to add in order to guide a new user to the app.


 Changed the price density estimate figure to a frequency polygon plot:
* We first used a density plot for the price distribution, but it can be difficult for users to understand the concept of density if they aren't familiar with a kernel density estimate. We made the decision to change it to a frequency plot with y-axis as count instead of density as we figured that count would be more intuitive so users would get more out of the app.  This was also something we observed during the *fly on the wall* session.


Changed order of distribution plots to be stacked vertically:
* Our original design was two plots in a row horizontally, which shortens the x-axis compressed the viewing area. We decided to change order of distribution plots to being stacked vertically, which allows the plots to easily and aesthetically show more information.  This wasn't from any feedback sessions, but was something that we wanted to implement.


### What We Might do Differently Next Time
Some interesting feedback we heard was that it would have be great to compare wines from different regions easily.  This is a fantastic idea, but would require a complete app redesign.  Having two input locations with corresponding facets, colour schemes or other comparisons would allow an easy way to compare locations and their associated ratings and prices.  Another addition may have been a choropleth map to visually identify which countries in the world had the best rated wines based on some criteria.  

### Greatest Challenges

One of the greatest challenges was trying to make the input dynamic.  For example if a certain country was selected, then we wanted the corresponding regions, provinces and varieties to dynamically change.  One other issue was trying to make the plots show data as a default even if no regions or varieties of wine were selected, while still requiring that the data be filtered.  We solved this through a series of `if` `else` statements to account for different scenarios.  A final issue was trying to put a limit on the amount of data being plotted in the cross plot.  Too much data rendered the time to create the plot much too high, especially as we wanted the plot to be interactive.  We had to figure out how to balance the amount of data and responsiveness of the app while still remaining relevant and useful.  We eventually decided on making region and country mandatory, which seemed to pare down the data enough so that it was responsive enough while still allowing valid conclusions to be drawn.
