# Conclusion #
----------
In this last part of our Wiki we want to summarize briefly our work and the results we obtained from the data analysis. The first thing we wanted to find out is the most important aspects in life that define happiness. For this purpose we gathered 95 different features for 138 countries. Of course there is myriad of aspects and we couldn't cover all in this project as time was a limiting factor.<br>
The first step in our analysis was to clean the data, which turned out to be harder than expected. The main challenge lied in bringing the data to a uniform format, as we used a variety of sources (cf. [Pre-Processing](dp-preprocessing) and the documentation of the scripts). After having extracted the useful data we proceeded with our main goal of **finding the most important features in life that lead to happiness**. In a sequence of iterations using the two regression methods `PCR` and `PLSR` we obtained the desired results, which were the weights of the most important features ([Main processing](dp-mainprocessing)). We also analyzed the two methods with respect to *computational performance* and *predictive ability* ([Results](results)).<br>
In the final part of our documentation we made an attempt to explain the significance of the determined remaining features, by also looking into literature supporting the importance of these variables. We have seen that mostly *Infrastructure/Social Development* and *Health* play a major role in the well-being of people. To our surprise *Environment* and *Finance* turn out to be rather insignificant sectors when it comes to pure life satisfaction.
 Moreover, We came to the conclusion that **unemployment** has the largest (negative) weight. According to this result it is very important to keep the unemployment in a country low in order to ensure life satisfaction. In other words, the more jobs are created the more a society is likely to be happy.


----------
Previous chapter: [6. Research](research) 

Go back to the [Introduction](introduction)