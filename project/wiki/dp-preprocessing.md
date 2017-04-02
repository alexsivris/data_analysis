# Data Processing #

## 2 Pre-Processing ##
### 2.1 Gathering the data ####
Since the data variables originate from different sources (Econstats, WorldBank, United Nations) and consequently have different structures, they need to be converted to a uniform format. The very first thing to do is to properly import the data into `MATLAB`. For this purpose, the class `Bootstrap` is used, which prepares all the variables and stores them in a single mat-file. <br>
At this point we would like to refer the reader to the Documentation of the `Bootstrap`-Class.<br>
[Documentation: Bootstrap](doc-bootstrap)

### 2.2 Constructing the X-matrix ###
In the beginning of the data processing phase the data matrix consisted of 138 rows (i.e. the countries) by 95 columns. This matrix, however, still contained a considerable amount of `NaN` (“Not A Number”) values, which had to be dealt with. The `NaN` value occurs in two occasions:<br>
1.  there is no data available for the most recent year or <br>
2.  there is no data available at all.  <br>

In the first case the issue can be solved by iteratively looking at the next most recent data point. So if, for example, there is no data for a given country/variable for 2015, we look if there is for 2014. If there isn’t for 2014 as well, we look for 2013 and so forth. Most of the variables enclose the timespan between 1960 and 2015. If there is no data found at all we replace the `NaN` value with the column mean (this is done in the main processing phase). The reason for using the column means is that it vanishes in the centering process in the `PCA`. <br>
The aforementioned steps have been implemented in the class `XMatrix`. The search for the most recent available data is performed in a loop, where a counter is set to the maximum number of columns of the variable. It decrements until a valid data point is found, or until the sixth column is reached (which describes the last year, i.e. 1960). <br>
For further details, please refer to the documentation of the `XMatrix`-class.<br>
[Documentation: XMatrix](doc-xmatrix)

----------
Previous section: [Introduction](dp-intro) 

Next section: [Main Processing](dp-mainprocessing)