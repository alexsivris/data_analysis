# Class: XMatrix #
## *[scripts/XMatrix.m](../tree/master/scripts/XMatrix.m)* ##
This class merges all the data into one X matrix. For this, the amount of rows of the different variables has to be considered, since it can (and it does) differ depending on the variable. Luckily all the variables have either 137 or 138 rows (countries), therefore we have to distinguish only between two cases.<br>
Another important functionality we implement in this class is the treatment of the missing values. In the following the methods and properties of `XMatrix` are presented.

## Properties (Access = private) ##
#### t_tab = [{}]; ####
Contains names of the variables, whose row length is 138 countries.

#### t\_tab\_137 = [{}]; ####
Contains names of the variables, whose row length is 137 countries.

#### all_tab;  ####
Contains names of all the variables. 
       
#### T_138; ####
Contains the data from the variables with 138 countries.

#### T_137; ####
Contains the data from the variables with 137 countries.

#### T_X; #### 
Contains the final X matrix.

## Methods ##
#### function obj = XMatrix(source_file) [Constructor, Access = public] ####
An object of the `XMatrix` class is instantiated by passing the file name of the previously created `mat`-file to the constructor. The first step is to load this `mat`-file and make all the loaded variables globally accessible within the script. Then, the program proceeds by calling the private methods for further processing.

#### function X = getX(obj) [Method, Access = public] ####
This method simply returns the final X matrix.

#### function obj = sortData(obj, source_file) [Method, Access = private] ####
The purpose of this method is to sort the variables into two tables. These tables contain just the variable names.

#### function obj = process137(obj, source_file) [Method, Access = private] ####
This is one of the core methods of the `XMatrix` class. As a first step an empty table is created with the total target dimensions. The script proceeds then with an iterative search for valid data points. The main criterion is that the data has to be as recent as possible. If there is no data for the entire time frame, a `NaN` value is inserted in the table. 

#### function obj = process138(obj, source_file) [Method, Access = private] ####
Same as `process137`-method, with the only difference that now 138 instead of 137 countries are processed and stored in a separate table.

#### function obj = addMissingCountry(obj, source_file) [Method, Access = private] ####
As the table with 137 countries cannot be simply merged with the table with 138 countries, a row has to be inserted containing the missing country. Then, both tables have the same size and can be merged.

#### function obj = clearZeros(obj) [Method, Access = private] ####
The purpose of this method is to clear the zeros that have resulted from missing data values. They are replaced by a `NaN` value.

