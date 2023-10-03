# Module M7 - Final project

![Thumbnail](https://github.com/ElisabettaDeVitoFrancesco/DAPT0123_EpicodeSchool/assets/26467328/379a4914-6d53-4b40-99dd-634fd7b1a9dd)


### Note
To view and download the Power BI .pbi file please follow the link: https://1drv.ms/f/s!AohTLQtn2yC1ikJbdVGwdSZnc1Wq?e=nit2Dr.

## Scope
The project analyzes the water quality of rivers and lakes in European countries, with a comparison between Austria and Italy. The online database Discodata from the European Environment Agency website was used as a data source.

## Tools
- Python, Jupyter Notebooks
- SQL server
- Power BI

## Procedure
### Python
In order to import the needed tables, Python programming language and Jupyter Notebooks were used, in particular the packages request, pandas, json, numpy and beautifulsoup.
The tables were imported as a csv file, or it was used a request to access the url of the table, which was provided by the online database, then transform the table to json and then as a dataframe.
Each table was explored and cleaned, which means filtering attributes, searching and eliminating null and duplicate values, using pandas package.
A direct connection between Python and SQL Server was created with the pyodbc package. The tables in the SQL Server database were created and filled directly from Python.

### SQL Server
SQL server was used to create views to connect to Power BI.

### Power BI
The two tables were imported via a connection with SQL Server, and smaller tables were imported as csv files and transformed with Power Query.
A six-page report was created:
- Map and bar visuals were used in the analysis of standard water quality parameters for each European country parameters. Certain buttons were created with bookmarks and selections, through hidden or unhidden visuals.
- The comparison between Austria and Italy was emphasized with the use of column graphs and the addition of population density and the number of measurements per country, for a more contextualised analysis.
- For certain groups of substances, the average trend for each year was shown as time series plot.
- The average emissions per country for certain groups of substances were added to have a more complete analysis.
- The last page shows general information for each country such as population and density.
