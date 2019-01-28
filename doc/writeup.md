### Rationale
Our rationale for creating this app was to give users a way to explore how price and rating of varieties of wines varies over different locations.  Being able to filter down to a specific region where the wine was made gives the user a better idea of how location affected price and ratings distributions.  Hover functionality enables users to identify specific wines on the cross plot if they saw a price and point location that seems favorable to them based on their filtering.  The inclusion of different quality categories allowed further flexibility to filter choice.

### Tasks
These were the main tasks that were completed for milestone 2:
- Dynamic filtering of location, province, region and variety based on previous choices.
- Create interactive cross plot that included wine names so a user could get additional information.
 - Feedback from TA and classmates will help decided what other information might be useful.
- Implementation of price and points histograms.
 - Feedback will decide whether we should use a KDE or histogram for both/either


### Next Steps
Our goal is to further add or remove filtering options based on user feedback; one such addition would be a price filter.  This would greatly help users that wanted to only look at a typical price range, such as in our usage case.

Including a usage/background/intro tab would be a nice addition to help orient/guide the user when they first arrive.  Also, implementing a separate reactive statement for the histograms would make it so that they are still able to be visualized even if there are no Countries or Provinces selected.  Currently they are linked to the cross plot data.  Not needing mandatory input would a bit more friendly for the user.

A "nice to have" feature would be speedier plots; but I'm not sure if that will be able to happen considering the size of the dataset and `plotly` limitations.  Quick, interactive plots may or may not be feasible.

### Bugs
-No image shown for price/points histogram if no selections are shown for country/province.
