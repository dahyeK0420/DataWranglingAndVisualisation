# The Children of *Fat Land*: The Drivers of Child Obesity in the United States

## Introduction

The motivation for this project is driven by statistics published by the OECD in 2016, which stated that the most physically active children in the world, the children in the United States, are also the most obese ones amongst the OECD countries. Yet, the obesity rate of the least physically active children, South Korean, is only 1/3 of that of the United States. Japan, on the other hand, managed to maintain a child obesity rate of less than 10% for the last ten years. Such phenomena raised the question – what is the key difference in the diet of the children from the United States and those from other first world OECD countries? Could socioeconomic variables impact the diets of the children in the United States? 

To answer these questions, the upcoming visualisation compares and contrasts the food group/nutrition intake of children in the United States to that of children in South Korea, Japan, and Australia. It also compares and contrasts the food group/nutrition intake of children in the U.S based on socioeconomic variables, such as race and income level. This project seeks to understand the child obesity problem in the United States based on children’s diet, as well as raising awareness around the effect of socioeconomic variables on children’s diet and obesity. The main audience of the project are policymakers involved in youth health issues, in this case the Centre for Disease Control and Prevention (CDC), school officials, and parents.

## Design Process – Five Design Sheet 

**``Dahye_Kim_ProjectIntroAndDesign.pdf``**

The key to this visualisation project is to enable users to directly catch the difference in food group/ nutrition consumption of children from the U.S and other comparing groups, as well as to explore the relationship between the child obesity rate in the U.S and different socioeconomic variables. To do so, I divided all the possible visualisation graphics into three major visualisation categories:

* Visualise daily Nutrition/Food element consumption – 12 to 36 different continuous variables, possibly categorised based into food group/nutrition group with hierarchy
  * Bar charts, tree map, Chernoff’s faces, stack bar plot, dot plot, sunburst graph
* Juxtapose the forementioned variables based on different comparing groups (OECD countries, income level, race/ethnicity)
  * Side-by-side bar charts, align the graphs from former category together for direct comparison  
* Visualise the relationship between three continuous variables – child obesity rate, median household income, and distribution rate of different race/ethnicity in each state in the U.S 
  * Bubble plot, side-by-side bar chart, back-to-back bar chart

## Children's Nutrient and Food Group Intake - Data Collecting and Wrangling Process 

### Children's nutrient and food group intake - country, gender, ethnicity/race, and income level 

* **US_Nutrient_gender**: nutrition intake breakdown of the population in the U.S based on gender and different age groups.   
``US_Nutrient_gender_2005_06.pdf``, ``US_Nutrient_gender_2007_08.pdf``, ``US_Nutrient_gender_2009_10.pdf``, ``US_Nutrient_gender_2011_12.pdf``, ``US_Nutrient_gender_2013_14.pdf``, ``US_Nutrient_gender_2015_16.pdf``, ``US_Nutrient_gender_2017_18.pdf``
  
* **US_Nutrient_income**: nutrition intake breakdown of the population in the U.S based on income level and different age groups.  
``US_Nutrient_income_2005_06.pdf``, ``US_Nutrient_income_2007_08.pdf``, ``US_Nutrient_income_2009_10.pdf``, ``US_Nutrient_income_2011_12.pdf``, ``US_Nutrient_income_2013_14.pdf``, ``US_Nutrient_income_2015_16.pdf``, ``US_Nutrient_income_2017_18.pdf``

* **US_Nutrient_Ethnicity**: nutrition intake breakdown of the population in the U.S based on income level and different age groups.  
``US_Nutrient_raceEthnicity_2005_06.pdf``, ``US_Nutrient_raceEthnicity_2007_08.pdf``, ``US_Nutrient_raceEthnicity_2009_10.pdf``, ``US_Nutrient_raceEthnicity_2011_12.pdf``, ``US_Nutrient_raceEthnicity_2013_14.pdf``, ``US_Nutrient_raceEthnicity_2015_16.pdf``, ``US_Nutrient_raceEthnicity_2017_18.pdf``

* **US_foodGroup_gender**: food group intake breakdown of the population in the U.S based on gender and different age groups.   
``US_foodGroup_gender_2005_06.pdf``, ``US_foodGroup_gender_2007_08.pdf``, ``US_foodGroup_gender_2009_10.pdf``, ``US_foodGroup_gender_2011_12.pdf``, ``US_foodGroup_gender_2013_14.pdf``, ``US_foodGroup_gender_2015_16.pdf``, ``US_foodGroup_gender_2017_18.pdf``
  
* **US_foodGroup_income**: food group intake breakdown of the population in the U.S based on income level and different age groups.  
``US_foodGroup_income_2005_06.pdf``, ``US_foodGroup_income_2007_08.pdf``, ``US_foodGroup_income_2009_10.pdf``, ``US_foodGroup_income_2011_12.pdf``, ``US_foodGroup_income_2013_14.pdf``, ``US_foodGroup_income_2015_16.pdf``, ``US_foodGroup_income_2017_18.pdf``

* **US_foodGroup_Ethnicity**: food group intake breakdown of the population in the U.S based on income level and different age groups.  
``US_foodGroup_raceEthnicity_2005_06.pdf``, ``US_foodGroup_raceEthnicity_2007_08.pdf``, ``US_foodGroup_raceEthnicity_2009_10.pdf``, ``US_foodGroup_raceEthnicity_2011_12.pdf``, ``US_foodGroup_raceEthnicity_2013_14.pdf``, ``US_foodGroup_raceEthnicity_2015_16.pdf``, ``US_foodGroup_raceEthnicity_2017_18.pdf``

### Japanese Children Nutrient and Food Group Intake 

* **jp_Nutrient**: Nutrient intake breakdown of the population in Japan based on gender and different age groups.  
``jp_Nutrient_total_2017.xlsx``,``jp_Nutrient_total_2016.xlsx``,``jp_Nutrient_total_2015.xlsx``,``jp_Nutrient_total_2014.xlsx``,``jp_Nutrient_total_2013.xlsx``,``jp_Nutrient_total_2012.xlsx``,``jp_Nutrient_total_2011.xlsx``,``jp_Nutrient_total_2010.xlsx``

  ``jp_Nutrient_male_2017.xlsx``,``jp_Nutrient_male_2016.xlsx``,``jp_Nutrient_male_2015.xlsx``,``jp_Nutrient_male_2014.xlsx``,``jp_Nutrient_male_2013.xlsx``,``jp_Nutrient_male_2012.xlsx``,``jp_Nutrient_male_2011.xlsx``,``jp_Nutrient_male_2010.xlsx``

  ``jp_Nutrient_female_2017.xlsx``,``jp_Nutrient_female_2016.xlsx``,``jp_Nutrient_female_2015.xlsx``,``jp_Nutrient_female_2014.xlsx``,``jp_Nutrient_female_2013.xlsx``,``jp_Nutrient_female_2012.xlsx``,``jp_Nutrient_female_2011.xlsx``,``jp_Nutrient_female_2010.xlsx``

* **jp_FoodG**: Food group intake breakdown of the population in Japan based on gender and different age groups.  
``jp_FoodG_total_2017.xlsx``,``jp_FoodG_total_2016.xlsx``,``jp_FoodG_total_2015.xlsx``,``jp_FoodG_total_2014.xlsx``,``jp_FoodG_total_2013.xlsx``,``jp_FoodG_total_2012.xlsx``,``jp_FoodG_total_2011.xlsx``,``jp_FoodG_total_2010.xlsx``

  ``jp_FoodG_male_2017.xlsx``,``jp_FoodG_male_2016.xlsx``,``jp_FoodG_male_2015.xlsx``,``jp_FoodG_male_2014.xlsx``,``jp_FoodG_male_2013.xlsx``,``jp_FoodG_male_2012.xlsx``,``jp_FoodG_male_2011.xlsx``,``jp_FoodG_male_2010.xlsx``

  ``jp_FoodG_female_2017.xlsx``,``jp_FoodG_female_2016.xlsx``,``jp_FoodG_female_2015.xlsx``,``jp_FoodG_female_2014.xlsx``,``jp_FoodG_female_2013.xlsx``,``jp_FoodG_female_2012.xlsx``,``jp_FoodG_female_2011.xlsx``,``jp_FoodG_female_2010.xlsx``

### Korean Children Nutrient and Food Group Intake 
The dataset is directly scraped from the KHIDI website from South Korea
