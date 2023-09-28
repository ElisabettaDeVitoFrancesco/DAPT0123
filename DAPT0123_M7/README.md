# Module M7 - Final project

![Thumbnail](https://github.com/ElisabettaDeVitoFrancesco/DAPT0123_EpicodeSchool/assets/26467328/379a4914-6d53-4b40-99dd-634fd7b1a9dd)


### Note
To view and download the Power BI .pbi file please follow the link: https://1drv.ms/f/s!AohTLQtn2yC1ikJbdVGwdSZnc1Wq?e=nit2Dr.

## Scope
The project analyzes the water quality of rivers and lakes in European countries, with a particular comparison between Austria and Italy.
The online database Discodata from the European Environment Agency website was used as a data source, https://discodata.eea.europa.eu/#.

## Tools
- Python, Jupyter Notebooks
- SQL server
- Power BI

## Procedure
### Python
In order to import the needed tables or the analysis Python programming language and Jupyter Notebooks were used, in particular the packages request, pandas, json, numpy and beautifulsoup.

Two approaches to import the tables were used: either a direct import as a csv file, or a request to access the url of the table, which was provided by the online database, then transform the table to json and then as a dataframe.

Each table needed for analysis was explored and cleaned, which means understanding the type of attributes, searching and eliminating null and duplicate values, all through the pandas package and in small part of numpy.

A direct connection to SQL server was enabled, to ensure that the data used for the final visualizations would be updated as well as the data directly imported through the url or csv in python.

The pyodbc package was used to be able to establish a connection and cursor between python and SQL server, and then to create the necessary tables directly from Python but within the QL server, using the previously imported values.


### SQL Server

SQL server was then used for brief queries for exploration and confirmation of successful connection, and mainly to create views for the Power BI connection.

### Power BI

Here in fact most of the data was imported via a connection with SQLserver, and smaller tables were imported as csv files and transformed with Power Query.

A six-page report was created, presenting all the same layout: the title, a page navigator, and various slicers to filter the data.

Map and bar visuals were used in the analysis of standard European country parameters. Each button reports to a different parameter, created with bookmarks and selections, through hidden or unhidden visuals.
The same structure was created on all other pages.

The comparison between Austria and Italy was emphasized with the use of column graphs and the addition of population density and the number of measurements per country. 

For certain groups of substances, the average trend in general for each year was shown as time series plots. The average emissions for each country for certain groups of substances were displayed as well.

The last page shows general information for each country such as population, density, and urban population.
