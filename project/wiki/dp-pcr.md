### 3.2 PCR ###
We discover the amount of necessary principal components by performing Leave-one-out cross-validation. We take the first local minimum in the "Estimated Mean Squared Prediction Error vs. Number of principle components" graph. Since this graph changes for every iteration &mdash; as we discard a variable in every step &mdash; the amount of principal components also changes. In **Figure 2** one can see estimated error plots for 3 randomly selected iteration. Notice that while the optimum amount of principal components varies slightly, the error fluctuation is very small. 
<div align="center"><img src="img/pcr/msep-pcr-1.png" width="600"/><img src="img/pcr/msep-pcr-14.png" width="600"/><img src="img/pcr/msep-pcr-30.png" width="600"/><br>
<b>Figure 2</b>: Measured Estimated Mean Squared Prediction Error for the iterations 1, 14 and 30 (PCR).<br></div>
In particular at the first iteration we have a prediction error of approximately 0.46, in the 14th it is 0.43 and in the 30th the prediction error is even less while using fewer principal components. <br>
The next plot we consider important for visualizing the performance of the `PCR` is the "Pearson Correlation Coeffictient" (`PCC`) over each iteration or equivalently, over the amount of discarded variables (since a variable gets dropped in every ieration). As mentioned in [section 3.1](dp-mainprocessing), the `PCC` measures how scattered the fitted response is with respect to the observed response. The `PCC` plot for the `PCR` is shown in **Figure 3**.
<div align="center" ><img src="img/pcr/pcc_dropped_vars.png" width="600"><br>
<b>Figure 3</b>: Pearson Correlation Coefficient over the amount of discarded variables. For the PCR we obtain the best results after dropping 54 variables. The PCC is approximately 0.85 in this case. </br></div><br>
We choose to drop 54 instead of 42 variables, because the `PCC` decreases rapidly after this point.
> Note: We have to modify the default `pcrsse` function of MATLAB to consider 8 instead of 10 principal components for Leave-one-out cross-validation. The reason for doing so is because we discard a variable in each iteration and if we keep the number of components at 10 we can only discard 50 variables. However, to illustrate the falling trend of the PCC that happens between the 50th and the 58th dropped variable, the number has to be reduced to 8. Otherwise the plot would only go until the 56th dropped variable.

The discarded and the remaining variables are listed in **Table 1**. 
<br><br>
<div align="center">
<table border="1" cellpadding="0" cellspacing="0">
<tbody>
<tr>
<td valign="top" ><p><b>Discared Features</b></p></td>
<td valign="top" ><p><b>Remaining Features</b></p></td>
</tr>

<tr>
<td valign="top" ><p>1. 'Suicide_rates'</p></td>
<td valign="top" ><p>1. Birth rate</p></td>
</tr>

<tr>
<td valign="top" ><p>2. 'arable_land'</p></td>
<td valign="top" ><p>2. Improved sanitation facilities (% of population with access)</p></td>
</tr>

<tr>
<td valign="top" ><p>3. 'population_total'</p></td>
<td valign="top" ><p>3. Life expectancy at birth, total (years)</p></td>
</tr>

<tr>
<td valign="top" ><p>4. 'cash_surplus_deficit'</p></td>
<td valign="top" ><p>4. Rural population (%)</p></td>
</tr>

<tr>
<td valign="top" ><p>5. 'land_area'</p></td>
<td valign="top" ><p>5. Urban population (%)</p></td>
</tr>

<tr>
<td valign="top" ><p>6. 'economically_active_popul_in_agr'</p></td>
<td valign="top" ><p>6. Adult mortality (per 1000 adults)</p></td>
</tr>

<tr>
<td valign="top" ><p>7. 'unemployment_fem'</p></td>
<td valign="top" ><p>7. Fixed broadband subscriptions (per 100 people)</p></td>
</tr>

<tr>
<td valign="top" ><p>8. 'refugee_population_by_asyl'</p></td>
<td valign="top" ><p>8. 'internet_users_per_100'</p></td>
</tr>

<tr>
<td valign="top" ><p>9. 'Death_rate'</p></td>
<td valign="top" ><p>9. 'ext_pc_per_100'</p></td>
</tr>

<tr>
<td valign="top" ><p>10. 'military_expenditure'</p></td>
<td valign="top" ><p>10. 'motor_vehicles_per_1000'</p></td>
</tr>

<tr>
<td valign="top" ><p>11. 'gender_parity'</p></td>
<td valign="top" ><p>11. 'access_to_non_solid_fuel'</p></td>
</tr>

<tr>
<td valign="top" ><p>12. 'armed_forces_total'</p></td>
<td valign="top" ><p>12. 'employment_in_agr_female'</p></td>
</tr>

<tr>
<td valign="top" ><p>13. 'net_income_bop'</p></td>
<td valign="top" ><p>13. 'employment_in_agr_male'</p></td>
</tr>

<tr>
<td valign="top" ><p>14. 'population_density'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>15. 'forest_area'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>16. 'Immunization_measles'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>17. 'gdp_growth'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>18. 'renewable_internal_freshwater'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>19. 'unemployment_male'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>20. 'time_to_prepare_pay_taxes'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>21. 'total_greenhouse_gas_emission'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>22. 'co2_emission_kt'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>23. 'youth_literacy_rate'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>24. 'Population_growth'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>25. 'Homicide'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>26. 'ext_int_tourism_number_arriv'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>27. 'refugee_population_by_origin'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>28. 'agricultural_land'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>29. 'gdp_at_market_price'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>30. 'agr_methane_emission'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>31. 'total_roads_km'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>32. 'Immunization_DPT'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>33. 'road_density_per_km'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>34. 'gov_expenditure_on_edu'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>35. 'primary_completion_rate'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>36. 'Alcohol_per_capita_consumption'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>37. 'inflation_consumer_prices'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>38. 'population_urban_agglo'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>39. 'Age_dependency_ratio'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>40. 'agr_nitr_oxide_emission'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>41. 'terr_prot_areas'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>42. 'Obesity'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>43. 'Fertility_rate'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>44. 'Incidence_of_tuberculosis'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>45. 'access_to_electricity'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>46. 'net_migration'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>47. 'Improved_water_source'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>48. 'goods_exports'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>49. 'Mortality_rate_under5'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>50. 'Health_expenditure_total'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>51. 'Health_expenditure_public'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>52. 'Mortality_caused_by_road_traffic_injury'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>53. 'improved_sanit_facil'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>54. 'agriculture_value'</p></td>
<td valign="top" > </td>
</tr>

</tbody>
</table>


<br><b>Table 1</b>: List of all the 54 discarded and 13 remaining features.</div>
<br>
The final weights that result from the `PCR` are visualized in a stem-plot, cf. **Figure 4**.
<div align="center"><img src="img/pcr/pca_weights.png" width="800"/><br>
<b>Figure 4</b>: PCR weights of for the remaining 13 features.<br></div>

----------
Previous section: [Workflow](dp-mainrocessing) 

Next section: [PLSR](dp-plsr)