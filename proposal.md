# Milestone 1 - Proposal

## Overview

When choosing a bottle of wine the region and variety can impact quality and price; liquor stores typically have wines sorted by country or region. Understanding the distributions of quality and price could help an average person or sommelier choose a country or region that fits their needs resulting in a better wine choice.  We propose building a shiny app that filters wines by country and region, which then shows related price and score distributions. In addition, a cross plot with hover capabilities will show price versus quality ratings and on hover will display more information about individual wines.

## Description of the data
We will be visualizing a dataset of approximately 130,000 wine reviews. Each wine review has 14 associated variables including variety, location, winery, price, description and review details. Based on our purpose, we will only look at these 6 variables that describe the wine’s location (country, province), the rating of the wine on a scale of 1-100 (points), the cost of a bottle of the wine (price), the type of grapes used to make the wine (variety). By using the data, we will also derive a new variable representing the level of points of a wine (points level). There are three level of the variable, points level: bad (points < 86), average (86 <= points <= 91), and good (points > 91).

## Usage scenario & tasks


## Description of the app & sketch
On the main page of the app there are two parts: on the left side is the dropdown list, and the right side are the visualizations. From the dropdown list, a user can filter out variables by location (i.e. US, California), by region (i.e. Napa Valley) and by variety (i.e. Pinot Noir). Based on different filters, users will see price and rating visualizations. This includes one price distribution graph coloured by points level, one histogram that displays the points distribution coloured by points level, and one scatter plot whose single point represents a wine with price and points in each axis. When clicking or hovering on each point, the user is able to see its title, variety and other information. Lastly, user has the option to view all the wines at a specific quality category.

![](sketch.png)
