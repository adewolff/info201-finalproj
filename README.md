# info201 Final Project Proposal
## Project Description
The data set that we will be working with is the College Scorecard Data collected from the U.S. Department of education. This dataset includes data from 1996 to 2016 for all undergraduate degree-granting institutions of higher education within the United States we accessed it from [the college scorecard](https://collegescorecard.ed.gov/data/). For our project we will mostly look at the recent data frame from 2015-2016 because it is the most relevant data. This data includes private and public undergraduate institutions. This data frame is used to increase transparency between choosing colleges.

Our target audience is focused on students who are _comparing_ different undergraduate colleges to consider applying and attending. They will be able to compare different colleges across the country.

3 specific questions we want to answer:
1. How does the admissions rate differ among colleges for the year 2016-2016?
2. How many undergraduate students are enrolled in the fall of 2015-2016?
3. How much is tuition in state and out of state?

## Technical Description
Data will be obtained from a collection of CSV files obtained from [the college scorecard website.](https://collegescorecard.ed.gov/data/) As our analyses require large amounts of information on all colleges nationwide it is much more efficient to use the CSV files downloaded from Collegescorecard than making huge numbers of API calls.

The data is formatted into several CSV files. One per school year. Because of this, in order to answer questions about how certain variables have changed over the years we will have to **merge** data frames. The data sets also contain a massive number of columns with abbreviated IDs. Because of this, we will have to use the Data Dictionary to rename the columns we intend to use in order to make working with them easier.

An external library we might be interested in using is the `ggforce` library.
A major challenge we expect to face is the creation of an interactive map using `plotly` , and getting the `shiny` infrastructure running.

There might me some statistical analyses in the form of linear regressions and t-tests to determine if there are relationships between variables.

We want to create an interactive map that will help visualize the geographical location of each college with the `plotly` library, and offer a graph using the `ggplot2` library, which allows people to see quantitative data related to the schools.

Challenges include dealing with null data in certain rows which may make it difficult to have a complete analysis. Other challenges include work balance since we only have 3 team members.
