### 3.3 PLSR ###
Similarly to the `PCR` we also perform a Leave-one-out cross-validation in the `PLSR` for finding the right amount of principal components in every iteration. For comparison, we show the estimated mean squared prediction error over the number of principle components in **Figure 5**, using the same iteration indices as in the `PCR` (1,14 and 30).
<br>
<div align="center"><img src="img/plsr/msep-plsr-1.png" width="600" /><img src="img/plsr/msep-plsr-14.png" width="600" /><img src="img/plsr/msep-plsr-30.png" width="600" /> <br>
<b>Figure 5</b>:Measured Estimated Mean Squared Prediction Error for the iterations 1, 14 and 30 (PLSR). <br>
</div>
Two main differences can be observed when comparing the plots in **Figure 4** with the plots in **Figure 5**: The value of the estimated prediction error is smaller and the optimal amount of principal components stays 2 for all iterations (also the ones not shown here).In the `PCR` the optimal amount of principal components seems to change randomly with each iteration, although it remains below 5. 
<br>The `PCC` is also plotted in **Figure 6**:
<div align="center"><img src="img/plsr/pcc_dropped_vars.png" width="600" />
<br><b>Figure 6</b>: Pearson Correlation Coefficient over the amount of discarded variables. For the PLSR we obtain the best results after dropping 41 variables. However the PCC is approximately 0.91 in this case.</div>
It can be seen from the plot that this time we can only drop 41 instead of 54 variables. The reason for choosing 41 over 29 is that from the 41st dropped variable on the `PCC` seems to be almost monotonically decreasing. At 29 dropped variables it still stays at approximately the same level without decreasing too much in value. The approximation of the `PLSR` is at `PCC=0.91`. Consequently there is a trade-off between how *accurate* the response is approximated and how *efficient* it is implemented. In the [next part](results), we are going to discuss how both approximations perform in a test set to see which of the methods is better suited for our application. <br>
The discarded and remaining countries are again listed in a table, cf. **Table 2**:
 <br> <br>
<div align="center">
<table border="1" cellpadding="0" cellspacing="0">
<tbody>
<tr>
<td valign="top" ><p><b>Discared Features </b></p></td>
<td valign="top" ><p><b>Remaining Features</b></p></td>
</tr>

<tr>
<td valign="top" ><p>1. 'Suicide_rates'</p></td>
<td valign="top" ><p>1. 'Death_rate'</p></td>
</tr>

<tr>
<td valign="top" ><p>2. 'Improved_water_source'</p></td>
<td valign="top" ><p>2. 'Health_expenditure_public'</p></td>
</tr>

<tr>
<td valign="top" ><p>3. 'gender_parity'</p></td>
<td valign="top" ><p>3. 'Health_expenditure_total'</p></td>
</tr>

<tr>
<td valign="top" ><p>4. 'Immunization_measles'</p></td>
<td valign="top" ><p>4. 'Improved_sanitation_facilities'</p></td>
</tr>

<tr>
<td valign="top" ><p>5. 'youth_literacy_rate'</p></td>
<td valign="top" ><p>5. 'Life_expectancy_at_birth'</p></td>
</tr>

<tr>
<td valign="top" ><p>6. 'Immunization_DPT'</p></td>
<td valign="top" ><p>6. 'Rural_population'</p></td>
</tr>

<tr>
<td valign="top" ><p>7. 'total_roads_km'</p></td>
<td valign="top" ><p>7. 'Urban_population'</p></td>
</tr>

<tr>
<td valign="top" ><p>8. 'road_density_per_km'</p></td>
<td valign="top" ><p>8. 'Adult_mortality'</p></td>
</tr>

<tr>
<td valign="top" ><p>9. 'population_density'</p></td>
<td valign="top" ><p>9. 'access_to_electricity'</p></td>
</tr>

<tr>
<td valign="top" ><p>10. 'time_to_prepare_pay_taxes'</p></td>
<td valign="top" ><p>10. 'fixed_broadband_subs'</p></td>
</tr>

<tr>
<td valign="top" ><p>11. 'gdp_growth'</p></td>
<td valign="top" ><p>11. 'internet_users_per_100'</p></td>
</tr>

<tr>
<td valign="top" ><p>12. 'total_greenhouse_gas_emission'</p></td>
<td valign="top" ><p>12. 'primary_completion_rate'</p></td>
</tr>

<tr>
<td valign="top" ><p>13. 'co2_emission_kt'</p></td>
<td valign="top" ><p>13. 'renewable_internal_freshwater'</p></td>
</tr>

<tr>
<td valign="top" ><p>14. 'ext_int_tourism_number_arriv'</p></td>
<td valign="top" ><p>14. 'unemployment_fem'</p></td>
</tr>

<tr>
<td valign="top" ><p>15. 'population_total'</p></td>
<td valign="top" ><p>15. 'unemployment_male'</p></td>
</tr>

<tr>
<td valign="top" ><p>16. 'Fertility_rate'</p></td>
<td valign="top" ><p>16. 'ext_pc_per_100'</p></td>
</tr>

<tr>
<td valign="top" ><p>17. 'net_migration'</p></td>
<td valign="top" ><p>17. 'motor_vehicles_per_1000'</p></td>
</tr>

<tr>
<td valign="top" ><p>18. 'agriculture_value'</p></td>
<td valign="top" ><p>18. 'arable_land'</p></td>
</tr>

<tr>
<td valign="top" ><p>19. 'Alcohol_per_capita_consumption'</p></td>
<td valign="top" ><p>19. 'land_area'</p></td>
</tr>

<tr>
<td valign="top" ><p>20. 'Age_dependency_ratio'</p></td>
<td valign="top" ><p>20. 'access_to_non_solid_fuel'</p></td>
</tr>

<tr>
<td valign="top" ><p>21. 'economically_active_popul_in_agr'</p></td>
<td valign="top" ><p>21. 'employment_in_agr_female'</p></td>
</tr>

<tr>
<td valign="top" ><p>22. 'forest_area'</p></td>
<td valign="top" ><p>22. 'employment_in_agr_male'</p></td>
</tr>

<tr>
<td valign="top" ><p>23. 'inflation_consumer_prices'</p></td>
<td valign="top" ><p>23. 'cash_surplus_deficit'</p></td>
</tr>

<tr>
<td valign="top" ><p>24. 'Birth_rate'</p></td>
<td valign="top" ><p>24. 'gdp_at_market_price'</p></td>
</tr>

<tr>
<td valign="top" ><p>25. 'Population_growth'</p></td>
<td valign="top" ><p>25. 'armed_forces_total'</p></td>
</tr>

<tr>
<td valign="top" ><p>26. 'population_urban_agglo'</p></td>
<td valign="top" ><p>26. 'military_expenditure'</p></td>
</tr>

<tr>
<td valign="top" ><p>27. 'agr_nitr_oxide_emission'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>28. 'refugee_population_by_origin'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>29. 'Mortality_rate_under5'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>30. 'gov_expenditure_on_edu'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>31. 'goods_exports'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>32. 'net_income_bop'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>33. 'refugee_population_by_asyl'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>34. 'Homicide'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>35. 'Obesity'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>36. 'terr_prot_areas'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>37. 'agr_methane_emission'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>38. 'agricultural_land'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>39. 'Mortality_caused_by_road_traffic_injury'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>40. 'Incidence_of_tuberculosis'</p></td>
<td valign="top" > </td>
</tr>

<tr>
<td valign="top" ><p>41. 'improved_sanit_facil'</p></td>
<td valign="top" > </td>
</tr>

</tbody>
</table>


<br><b>Table 2</b>: List of all the 41 discarded and 26 remaining features.</div>
<br>
The corresponding weights of the 26 remaining features are again plotted in **Figure 7**:
<div align="center"><img src="img/plsr/plsr_weights.png" width="800"/><br>
<b>Figure 7</b>: PLSR weights of for the remaining 26 features.<br></div>

----------
Previous section: [PCR](dp-pcr) 

Next section: [Clustering](dp-clustering)