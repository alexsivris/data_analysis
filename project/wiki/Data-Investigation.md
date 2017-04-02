Since the data is collected and ready to make the analysis, it would be benefitial to investigate data with several types of plots before making analysisand applying methods. This is because, this investigation will give us some signs and make it easier to decide which method to use in analysis part.

As a very first step we checked `NaN` values in our data matrix <i>X</i> with a <i>spy()</i> command in `MATLAB`. In <b>Figure 1</b>, the `NaN` values are shown as spot. As it can be seen there are some even after discarding some variables because of this problem. They are 323 out of 67x138 = 9246, which means exactly 3,49% of the data is missing.
<div align="center"><br><img src="http://i.imgur.com/cTV0ARJ.jpg" width="1100" /> <br>
<b>Figure 1</b>:Peoples Life Satisfaction Score for different Countries<br></div>

First, we wanted to see the general distribution on <i>life satisfaction score (y vector)</i> among the cuntries. In <b>Figure 2</b>, we plotted the sorted version of <i>y vector</i> by all 138 countries. For easiness , we drop some countries name out of the plot but it is still clear to say that <i>the life satisfaction score </i> is almost uniformly distributed on the range of (3-8). Since this is got from a survey it should be consistent our expectations.More clearly, It is expected that countries suffer from terorism like Afganistan and some African countries should have low scores , on the other hand Scandinavian countries like Sweeden and Norway should have high scores. Since this can be easily seen in the figure, we are sure to continue with this score values.
<div align="center"><br><img src="http://i.imgur.com/X6plmSy.jpg" width="1100" /> <br>
<b>Figure 2</b>:Peoples Life Satisfaction Score for different Countries<br></div>



Next, we made some preanalysis on variables in order to see the ralation between them and with <i>the life satisfaction score</i>. Since we are motivated to use PCA like dimention reduction methods, the relation between variables must be explored. We used quite number of variables and it is a high possibility that there are some correlated one. For example, in countries with high <i>agricultural activity</i>, high <i>birth rate</i>, low <i>life expectancy</i>, high <i>fertility rate</i> and so on, is expected. In followin figures which are <b>Figure 3 - Figure 8</b>, we investigated that relation between variables and satisfaction score. Some are positively correlated like <i>health expanditure</i>, some negatively correlated like <i>life expectancy</i> as expected.
<div align="center"><br><img src="http://i.imgur.com/TAObtqA.jpg" width="600" /> <br>
<b>Figure 3</b>:Life Satisfaction Score by Agricultural activity in Countries<br></div>


<div align="center"><br><img src="http://i.imgur.com/Ftl6Iac.jpg" width="600" /> <br>
<b>Figure 4</b>:Life Satisfaction Score by Birth rate<br></div>


<div align="center"><br><img src="http://i.imgur.com/9BaltA7.jpg" width="600" /> <br>
<b>Figure 5</b>:Life Satisfaction Score by Life Expectancy<br></div>


<div align="center"><br><img src="http://i.imgur.com/WkLBzJh.jpg" width="600" /> <br>
<b>Figure 6</b>:Life Satisfaction Score by Public Health Expenditure<br></div>


<div align="center"><br><img src="http://i.imgur.com/kMirdPE.jpg" width="600" /> <br>
<b>Figure 7</b>: Life Satisfaction Score by Age dependency ratio (% of working-age population)  <br></div>


<div align="center"><br><img src="http://i.imgur.com/DrAxb5r.jpg" width="600" /> <br>
<b>Figure 8</b>:Life Satisfaction Score by Fertility rate<br></div>


After that, we studied the correlation between variables and <i>the life satisfaction score</i> by calculating correlation coefficients, which are illustrated in <b>Figure 9</b>. The one have high absolute value are plotted for easiness. The one has higher absolute value are more important than others for life satisfaction. By this assumption, we expected that regression coefficient of these variables will be similar.
<div align="center"><br><img src="http://i.imgur.com/snGa69q.jpg" width="800" /> <br>
<b>Figure 9</b>:Correlation Coefficient of variables with Life Satisfaction Score<br></div>


In the <b>Figure 10</b>, we thought that the best way of showing the corelation between variables in the data matrix **X** is to calculate the correlation matrix(67 x 67) of it and than plot absolute of it as image. Since it is well known that the i^th row and j^th column of correlation matrix is equal to the correlation coefficient between i^th variable and j_the variable. As it is the case, the diagonal values are equal to "1" , which is shown as **white**, and the one has no correlation is near to "0",which is shown as **black**. In other words, the one has near to white color are highly correlated(negatively or positively), and the one has near to black color are un correlated. As it can be seen in <b>Figure 10</b>, there are non-negligible number of  white spots, so that means the data matrix's columns are correlated and PCA like methods need to be used to get rid of this problem. 
<div align="center"><br><img src="http://i.imgur.com/L76eONz.jpg" width="800" /> <br>
<b>Figure 10</b>:Image show of the correlation matrix of the data matrix <b>X</b><br></div>


As a final step, we looked on some variables that we instictively considered as important. In <b>Figure 11</b>, we calculated the correlation of other variables with <i>life expectancy</i>, as it is expected some variables are highly correlated. For example, the improved sanitation facilities is positively correlated and <i>incidence of tuberculosis</i> is negatively correlated with it. And <i>the GDP</i> and <i>the female unemployement</i> investigated in <b>Figure 12</b> and  <b>Figure 13</b> respectively. 
<div align="center"><br><img src="http://i.imgur.com/pCTY6GN.jpg" width="800" /> <br>
<b>Figure 11</b>:Correlation Coefficient of variables with Life Expectancy<br></div>



<div align="center"><br><img src="http://i.imgur.com/pMmBk4D.jpg" width="800" /> <br>
<b>Figure 12</b>:Correlation Coefficient of variables with GDP<br></div>



<div align="center"><br><img src="http://i.imgur.com/ltDHJO5.jpg" width="800" /> <br>
<b>Figure 13</b>:Correlation Coefficient of variables with Female Unemployment<br></div>


For the scripts of pre-analysis click  *[here](../tree/master/scripts/data_exploration)*.<br>
Previous section : [Description of variables](description-of-variables) <br />
Next chapter : [Methods](met-intro) <br />

