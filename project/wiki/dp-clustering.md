# Data Processing #
## 4 Clustering ##
In this phase of the processing part, we are going to try to cluster the countries and/or features with the aid of the `k-means` clustering algorithm. Therefore, we are going to look at the loading and score plots of the `PCA/PCR` and the `PLSR`. Note that we only look at the loadings and scores of the *reduced* X matrices. We use `k=3` in the k-means clustering, because we want to separate the countries by three degrees of happiness: *low*, *medium* and *high*. As a point of reference, list the sorted countries in **Table 3**, according to the clustering of our Y-vector, which is visualized as a histogram in **Figure 8**.<br><br>
<div align="center"><img src="img/general/clustered_y.png" width="800"/><br><b>Figure 8</b>: Happiness index vs. number of occurences: The data is divided into k=3 clusters denoting <i>low</i>,<i>medium</i> and <i>high</i> happiness.<br></div><br><br>
<div align="center"><table border="1" cellpadding="0" cellspacing="0">
<tbody>
<tr>
<td valign="top" ><p><b>Low Happiness</b></p></td>
<td valign="top" ><p><b>Medium Happiness</b></p></td>
<td valign="top" ><p><b>High Happiness</b></p></td>
</tr>

<tr>
<td valign="top" ><p>'Afghanistan'</p></td>
<td valign="top" ><p>'Azerbaijan'</p></td>
<td valign="top" ><p>'Algeria'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Albania'</p></td>
<td valign="top" ><p>'Belarus'</p></td>
<td valign="top" ><p>'Argentina'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Angola'</p></td>
<td valign="top" ><p>'Belize'</p></td>
<td valign="top" ><p>'Australia'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Armenia'</p></td>
<td valign="top" ><p>'Bhutan'</p></td>
<td valign="top" ><p>'Austria'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Bangladesh'</p></td>
<td valign="top" ><p>'Bolivia'</p></td>
<td valign="top" ><p>'Bahrain'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Benin'</p></td>
<td valign="top" ><p>'Bosnia and Herzegovina'</p></td>
<td valign="top" ><p>'Belgium'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Botswana'</p></td>
<td valign="top" ><p>'China'</p></td>
<td valign="top" ><p>'Brazil'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Bulgaria'</p></td>
<td valign="top" ><p>'Croatia'</p></td>
<td valign="top" ><p>'Canada'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Burkina Faso'</p></td>
<td valign="top" ><p>'Cyprus'</p></td>
<td valign="top" ><p>'Chile'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Burundi'</p></td>
<td valign="top" ><p>'Dominican Republic'</p></td>
<td valign="top" ><p>'Colombia'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Cambodia'</p></td>
<td valign="top" ><p>'Ecuador'</p></td>
<td valign="top" ><p>'Costa Rica'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Cameroon'</p></td>
<td valign="top" ><p>'El Salvador'</p></td>
<td valign="top" ><p>'Czech Republic'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Chad'</p></td>
<td valign="top" ><p>'Estonia'</p></td>
<td valign="top" ><p>'Denmark'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Comoros'</p></td>
<td valign="top" ><p>'Greece'</p></td>
<td valign="top" ><p>'Finland'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Ethiopia'</p></td>
<td valign="top" ><p>'Honduras'</p></td>
<td valign="top" ><p>'France'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Gabon'</p></td>
<td valign="top" ><p>'Hungary'</p></td>
<td valign="top" ><p>'Germany'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Georgia'</p></td>
<td valign="top" ><p>'Indonesia'</p></td>
<td valign="top" ><p>'Guatemala'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Ghana'</p></td>
<td valign="top" ><p>'Italy'</p></td>
<td valign="top" ><p>'Iceland'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Guinea'</p></td>
<td valign="top" ><p>'Jamaica'</p></td>
<td valign="top" ><p>'Ireland'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Haiti'</p></td>
<td valign="top" ><p>'Japan'</p></td>
<td valign="top" ><p>'Israel'</p></td>
</tr>

<tr>
<td valign="top" ><p>'India'</p></td>
<td valign="top" ><p>'Jordan'</p></td>
<td valign="top" ><p>'Kuwait'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Iraq'</p></td>
<td valign="top" ><p>'Kazakhstan'</p></td>
<td valign="top" ><p>'Luxembourg'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Kenya'</p></td>
<td valign="top" ><p>'Latvia'</p></td>
<td valign="top" ><p>'Malta'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Liberia'</p></td>
<td valign="top" ><p>'Lebanon'</p></td>
<td valign="top" ><p>'Mexico'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Madagascar'</p></td>
<td valign="top" ><p>'Libya'</p></td>
<td valign="top" ><p>'Netherlands'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Malawi'</p></td>
<td valign="top" ><p>'Lithuania'</p></td>
<td valign="top" ><p>'New Zealand'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Mali'</p></td>
<td valign="top" ><p>'Malaysia'</p></td>
<td valign="top" ><p>'Norway'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Mauritania'</p></td>
<td valign="top" ><p>'Mauritius'</p></td>
<td valign="top" ><p>'Panama'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Myanmar'</p></td>
<td valign="top" ><p>'Moldova'</p></td>
<td valign="top" ><p>'Puerto Rico'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Namibia'</p></td>
<td valign="top" ><p>'Mongolia'</p></td>
<td valign="top" ><p>'Qatar'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Niger'</p></td>
<td valign="top" ><p>'Montenegro'</p></td>
<td valign="top" ><p>'Saudi Arabia'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Rwanda'</p></td>
<td valign="top" ><p>'Morocco'</p></td>
<td valign="top" ><p>'Singapore'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Senegal'</p></td>
<td valign="top" ><p>'Nepal'</p></td>
<td valign="top" ><p>'Spain'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Sierra Leone'</p></td>
<td valign="top" ><p>'Nicaragua'</p></td>
<td valign="top" ><p>'Suriname'</p></td>
</tr>

<tr>
<td valign="top" ><p>'South Africa'</p></td>
<td valign="top" ><p>'Nigeria'</p></td>
<td valign="top" ><p>'Sweden'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Sri Lanka'</p></td>
<td valign="top" ><p>'Pakistan'</p></td>
<td valign="top" ><p>'Switzerland'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Sudan'</p></td>
<td valign="top" ><p>'Paraguay'</p></td>
<td valign="top" ><p>'Thailand'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Tanzania'</p></td>
<td valign="top" ><p>'Peru'</p></td>
<td valign="top" ><p>'Trinidad and Tobago'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Togo'</p></td>
<td valign="top" ><p>'Philippines'</p></td>
<td valign="top" ><p>'United Arab Emirates'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Uganda'</p></td>
<td valign="top" ><p>'Poland'</p></td>
<td valign="top" ><p>'United Kingdom'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Ukraine'</p></td>
<td valign="top" ><p>'Portugal'</p></td>
<td valign="top" ><p>'United States'</p></td>
</tr>

<tr>
<td valign="top" ><p>'Zimbabwe'</p></td>
<td valign="top" ><p>'Romania'</p></td>
<td valign="top" ><p>'Uruguay'</p></td>
</tr>

<tr>
<td valign="top" > </td>
<td valign="top" ><p>'Serbia'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" > </td>
<td valign="top" ><p>'Slovenia'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" > </td>
<td valign="top" ><p>'Somalia'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" > </td>
<td valign="top" ><p>'Tajikistan'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" > </td>
<td valign="top" ><p>'Tunisia'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" > </td>
<td valign="top" ><p>'Turkey'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" > </td>
<td valign="top" ><p>'Turkmenistan'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" > </td>
<td valign="top" ><p>'Uzbekistan'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" > </td>
<td valign="top" ><p>'Vietnam'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" > </td>
<td valign="top" ><p>'Zambia'</p></td>
<td valign="top" > </td>
</tr>

</tbody>
</table>

<br>
<br><b>Table 3</b>: Countries sorted by Happiness score<br></div>
#### 4.2.1 PCA/PCR ####

We plot the first loading against the second loading in **Figure 9 (top)** and the first score against the second in **Figure 9 (bottom)**.
<div align="center"><img src="img/pcr/pca_loading1_vs_loading2_clustered.png" width="800"/><br><img src="img/pcr/pca_score_clustered.png" width="800"/><br>
<b>Figure 9</b>: Top: PCA Loading plot (clustered), Bottom: PCA Score plot (clustered).<br></div>

We start by looking at the scores of the first two principal components. We take the first two, because they describe most of the variation. Looking at the scatter-plot in **Figure 9 (bottom)** it is apparent that the countries that have a similar happiness index also are located closely in the score plot. To further emphasize the relation between the countries, we perform a `k-means` cluster analysis with `k=3` clusters. The resulting clusters are enclosed in clouds with their respective color for better visualization.<br>
In the left part of the plot there is a gathering of predominantly *less developed countries* (mostly African countries), while most of the *first world countries* are represented in the right part of the plot (mostly European countries). When comparing the clusters to the entries of **Table 3**, one can interpret these clusters as the countries that represent **low** (yellow), **medium** (red) and **high** (blue) happiness. For instance, *Burundi* has a low happiness score and is located in the corresponding left-most cluster. *Azerbaijan* is a country with medium happiness according to the World Happiness Report and is therefore located in the middle. Lastly, most of the countries with high happiness fall into the right-most cluster (e.g. *Austria*). Some countries however don't fit in this scheme, which probably happens due to the fact that we use `k-means` clustering. This approach doesn't have any knowledge about the data, but splits the clusters in an algorithmic manner (for more details, please visit [Chapter 3: Methods](methods)). <br>
Another rather important observation we can make is that the points are mostly scattered far away from the origin. This means that these points are either outliers, or denote the extremes. This however coincides with the theory, that the location of the three clusters describes the three levels of happiness &mdash; a country with extremely low happiness would be located in the left cluster and a country with high happiness in the right cluster.<br>
For the second part of the cluster analysis, we also need the *loading* plot from **Figure 9 (top)**. If a point in this plot is close to the origin it means that it doesn't contribute as much to the variation of a variable and thus has a small "weight". Moreover, if multiple variables are strongly correlated they appear close to each other. If they are negatively correlated they appear diagonally opposite to each other. For this reason it makes sense to apply `k-means` clustering in order to find the correlated variables. We choose `k=4`, as this seems like a reasonable amount (by inspection). When comparing the direction of the samples from the score plot with the direction of the points from the loading plot, we see that the countries having a large value of a certain feature also tend to be aligned in the direction of this feature from the loading plot. For example, the *yellow* cluster from the score plot is strongly aligned in the direction of the *blue* cluster in the loading plot. The reason is that a lot of people from these countries are in fact occupied in the agricultural sector. <br>
As one can see we obtain a complete description of our data set by only looking at these two plots.

#### 4.2.2 PLSR ####
We plot the first loading against the second loading in **Figure 10 (top)** and the first score against the second score in **Figure 10 (bottom)**.
<div align="center"><img src="img/plsr/plsr_loading1_vs_loading2_clustered.png" width="800"/><img src="img/plsr/plsr_score_clustered.png" width="800"/><br>
<b>Figure 10</b>: Top: PLS Loading plot (clustered), Bottom: PLS Score plot (clustered).<br></div>


Like in the `PCR`, from **Figure 10 (bottom)** one can see on the left the *less developed countries* (mostly African countries), while most of the *first world countries* are on the right part of the plots (mostly European countries). We perform `k-means` clustering and compare the results to the sorted countries in **Table 3**.
 While the extremes (left- and rightmost part of the plot) clearly contain the countries with low and high happiness respectively, the mid-range is strongly scattered.<br>
Since the `PLSR`-iteration from the [main processing](dp-mainprocessing) yields more remaining variables than in the `PCR` part, we can again look at the loading plot and look for certain dominant directions and clusters. First of all, the *unemployment rate (male and female)* appear very close to each other and are far away from the origin. We also know that unfortunately the unemployment rate in *Greece* is very high. As before, this fact can also be extracted from the plot: By mentally superimposing the loading and the score plot one sees that *Greece* lies in the same direction as the *unemployment rate (male/female)*. In addition to that, countries like *Austria*, *Germany* and *Switzerland* are aligned predominantly in the direction of a well-built infrastructure (cf. **Figure 10 (top)** *renewable internal freshwater*, *personal computers per 100 persons (ext\_pc\_per\_100)* and *access to electricity*). All of these countries have very good *access to electricity* (100% for all of these three countries), most of the population has *access to the internet* (unfortunately the text is not clearly visible but the *internet users (%)*-variable is also in the blue cluster. Austria: 81%, Germany: 86%, Switzerland: 87% ) and to *personal computers* ( Austria: 61% , Germany: 66% , Switzerland: 96%).

----------
Previous section: [Main Processing](dp-mainprocessing) 

Next chapter: [5. Results](results)