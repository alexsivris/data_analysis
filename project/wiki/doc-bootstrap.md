# Class: Bootstrap #
## *[scripts/Bootstrap.m](../tree/master/scripts/Bootstrap.m)* ##
This is a class to find out which countries from a given data source are also represented in the “World Happiness Report”. The script starts by loading the necessary files, i.e. the desired variables to be checked and the “World Happiness Report” (the Y-vector, which is also stored in a `csv`-file). It is then checked which of the countries in the data file are common to the countries of the Y-vector. All the matches are stored in a matrix called “`Found`”. As we also want to use the countries that are not represented in the Y-vector to predict their happiness score in a later stage, we store them in another matrix (called “`notFound`”). Both, the “`Found`” and the “`notFound`” variables are then saved in separate “`.mat`” files. <br>
In the following the methods of the Bootstrap-class will be presented.

## Methods ##

#### function obj = Bootstrap(target_filename) [Constructor, Access=public] ####
The constructor takes one parameter which is the file name of the target mat-file that will be saved (without the “`.mat`”-extension!). It then proceeds to call the method `loadVariables` , which imports all the variables from the `csv`-files for further use.

#### function obj = loadVariables(obj,target_filename) [Method, Access=private] ####
Firstly, the point of reference, namely the Y-vector has to be loaded (“World Happiness Report”). Then, all the other X-variables are loaded iteratively. In every iteration of the loop, the method `matchWHR` is called. After loading all the variables, matching them to the Y-vector and separating them accordingly, they are saved in two separate files. The one file contains all the matches and has as the file name the `target_filename` specified in the constructor. All the countries that cannot be matched to the countries of the Y-vector are stored in another file, which has the same file name as the first, only with the words “`not_found`” appended.

#### function [Found, notFound] = matchWHR(obj, whr, tab) [Method, Access=private] ####
This method checks which countries of the table `tab` match the countries from the “World Happiness Report” (`whr`). It separates the countries into two tables, namely Found and `notFound` and returns them.