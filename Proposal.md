# Milestone 1 - Proposal

## Overview


## Description of the data
We will be visualizing a dataset of approximately 130k wine reviews. Each wine review has 14 associated variables including variety, location, winery, price, description and review details. Based on our purpose, we will only look at these 6 variables that describe the wine’s location (country, province), the number of points rated the wine on a scale of 1-100 (points), the cost of a bottle of the wine (price), the type of grapes used to make the wine (variety). By using the data, we will also derive a new variable representing the level of points of a wine (points level). There are three level of the variable, points level: bad (points < 86), avg (86 <= points <= 91), good (points > 91).

## Usage scenario & tasks


## Description of the app & sketch
On the main page of the app, there two parts, on the left side is the dropdown list, and the right side is all the visualization. From the dropdown list, user can filter out variables by location (i.e. US, California), by region (i.e. Napa Valley) and by variety (i.e. Pinot Noir). Based on different filters, users are allowed to see some visualization. This include one price distribution graph facetted by points level, one histogram that counts the number of wines of same points facetted by points level and one scatter plot whose single point represents a wine with price and points in each axis. When clicking on each point, user is able to see its title, variety and other information. Lastly, user has the option to view all the wines at a specific points level. 

![](sketch.png)
