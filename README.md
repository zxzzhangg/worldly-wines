# worldly-wines

### Team Members
- [Zixin Zhang](https://github.com/zxzzhangg)
- [Evan Yathon](https://github.com/EvanYathon)

### Description
`worldly-wines` contains code to clean loaded data which is then fed into a `shiny` application.  The application serves the purpose of exploring a large database of wines that have been rated and priced.  Dynamically exploring the data has the goal of helping to understand distributions and relationships of price and rating by region or variety of wine.

### The App
[Deployed Shiny App](https://evanyathon.shinyapps.io/worldly-wines/) hosted on shinyapps.io

### Directory
- [Shiny App](src/app.R)
- [Data Cleaning](src/load_data.R)
- [Initial Proposal](doc/Proposal.md) - contains data description, an example usage case and initial app design
- [Code of Conduct](CONDUCT.md) -adapted from the [Contributor Covenant](https://www.contributor-covenant.org/version/1/4/code-of-conduct.html)
- [Milestone 2 Writeup](doc/writeup.md)
- [Milestone 2 Functionality](doc/functionality.md)
- [Milestone 3 Writeup](doc/writeup_3.md)
- Milestone 3 Feedbacks
   - [Link to feedback for Shayne and Harjyot](https://github.com/UBC-MDS/Olympics_Medal_Exploration/issues/11)
   - [Link to feedback for Marcelle and Sayanti](https://github.com/UBC-MDS/Mental_Health_Issue_Tracker/issues/9)
- [Milestone 4 Writeup](doc/writeup_4.md)

### Data
Data was sourced from [Kaggle](https://www.kaggle.com/zynicide/wine-reviews/data), in which the author states:
- "Acknowledgements
The data was scraped from WineEnthusiast during the week of June 15th, 2017. The code for the scraper can be found here if you have any more specific questions about data collection that I didn't address.
- UPDATE 11/24/2017 After feedback from users of the dataset I scraped the reviews again on November 22nd, 2017. This time around I collected the title of each review, which you can parse the year out of, the tasters name, and the taster's Twitter handle. This should also fix the duplicate entry issue."
