Name of project:

Transatlantic Slave Voyages




Description:

The script is the main element in a data-driven historical research project, highlighting different aspects of the transatlantic slave trade in RStudio.




Author:

Karen Saugbjerg, 201605270@post.au.dk




Software:

OpenRefine 3.4.1
R (version 3.4.1)
RStudio (version 1.3.1093) (packages: tidyverse, cowplot)




Data:

The Trans-Atlantic Slave Trade database, available at https://www.slavevoyages.org/voyage/database. For conditions of use of Slave Voyages dataset, see https://www.slavevoyages.org/about/about#legal/9/en/. Columns are set to ‘Voyage ID’, ‘Place where voyage began’, ‘Principal place of purchase’, ‘Principal place of slave landing’, ‘Total embarked’, ‘Total disembarked’, and ‘Year arrived with slaves’. Itinerary is filtered to ‘Departure - Europe’. Data are downloaded as xls file (see "slavevoyages_original.xls" in Data attached), cleansed in OpenRefine (see Operation History attached), extracted as csv file (see "slavevoyages_clean.csv" in Data attached), and read into RStudio.




Metadata:

Column names in cleansed data
- voyageid: voyage ID
- departure: estimated place where voyage began
- purchase: estimated place of purchase
- arrival: estimated place of slave landing
- embarked: estimated number of slaves embarked
- disembarked: estimated number of slaves disembarked
- year: estimated year arrived with slaves




Usage:

Copy the script named “SlaveVoyages.R” into RStudio and run the entire code. Five different plots appear, visualizing 1) annual number of voyages during the entire period, 2) 25 most frequent points of departure, 3) annual number of voyages for 10 most frequent points of departure for 16th, 17th, 18th and 19th centuries, respectively, 4) annual number of voyages for 5 most frequent points of departure during the entire period, and 5) annual number of slaves embarked and disembarked during the entire period.




Acknowledgements:

Advised by Max Odsbjerg Pedersen and Adela Sobotkova.




License:

CC-BY-SA 4.0. See attached License.
