# Similar Government Contractors

## Introduction
This is a web application that gives the results of clustering government contractors by the types of services they provide. Services are classified according to the North American Industry Classification System (NAICS) which provides a standardized way of classifying services a company offers. Click [here](https://www.census.gov/eos/www/naics/) if you'd like to read more about NAICS codes. An accompanying app was created [here](http://www.nkallfa.com/shiny/Clustering-Government-Contractors-App/app/) which can be used to explore setting different parameters for clustering on a much smaller data set (a little over 1,000 contractors and only 10 NAICS codes), but the results were not intended to be meaningful. This app gives the results of clustering all the contractors using all of the NAICS codes for fiscal year 2016. The full data set includes over 132,000 contractors and 1,204 NAICS codes. 

## How To Use This App

To see the results, click on the "Dashboard" icon on the left side menu. You can search for a company in the left sidebar. Click the update button once a company is found. After clicking update, two searchable tables will appear:

<!-- 1. All Contractors - this lists all of the contractors in the full data set by their name and DUNS number. **Use the search feature to see if a contractor is in the full data set and, if so, determine what cluster it is in. Then you can use the drop down input in the side bar menu to see the companies in the cluster.** -->
1. Contractors per Cluster - this is a fixed table that just lists the number of companies in each cluster
2. Contractor Cluster - this lists the contractors in the chosen cluster. 

## Data
The data comes from U.S. governemnt spending data found on  [USA Spending](https://www.usaspending.gov/Pages/Default.aspx). Details on how to download the data can be found [here](https://www.usaspending.gov/DownloadCenter/Pages/default.aspx) or on the [beta version](https://beta.usaspending.gov) of USA Spending that's still currently in development.

## Methodology
This application used [K-Means](https://en.wikipedia.org/wiki/K-means_clustering) to group contractors after applying [Singular Value Decomposition](https://en.wikipedia.org/wiki/Singular-value_decomposition) (SVD) to reduce the dimensionality of the data to 5 dimensions (5 dimensions were chosen arbitrarily). To determine the number of clusters, I performed K-Means using 2-15 clusters and 7 to be the optimal number of clusters using the [Elbow method](https://en.wikipedia.org/wiki/Elbow_method_(clustering)). 

As discussed earlier, there were 132,716 contractors and 1204 NAICS codes used. Some contractors were removed prior to clustering because they either had a missing DUNS number or the company name was missing. Prior to performing SVD the data was binary with each row giving a company and each column a specific NAICS code. A 1 indicated the company had Procurement Instrument Identifier under the NAICS code in FY16 and 0 indicated that they did not. 

## Code
To see the underlying code for this application, please see the [GitHub repo](https://github.com/nkk36/Similar-Government-Contractors-App).

## Limitations and Future Updates
This was my first iteration of clustering over the entire data set and it needs some refinement (in particular, domain expertise in federal contracting would be helpful). Additional features could be used, but outliers seemed to be severely distorting the data. I'm working on improving this app and will release updates accordingly as new developments are made. If you are interested in contributing or have any questions/suggestions feel free to email me at <nkallfa36@gmail.com>.

