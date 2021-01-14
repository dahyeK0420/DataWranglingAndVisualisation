# DataCleansing
This program aims to cleanse the data of diet information of children from four different countries - the US, South Korea, and Japan. The program scrapes aforementioned data from different sources, namely websites (HTML), PDF files, and excel sheets. The scraped data is then organised into CSV file with common attributes from each datasets. Non-English dataset is translated into English by the Author. 

Following are the dataset before cleansing: 

## US Children Nutrient and Food Group Intake

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

## Japanese Children Nutrient and Food Group Intake 

* **jp_Nutrient**: Nutrient intake breakdown of the population in Japan based on gender and different age groups.  
``jp_Nutrient_total_2017.xlsx``,``jp_Nutrient_total_2016.xlsx``,``jp_Nutrient_total_2015.xlsx``,``jp_Nutrient_total_2014.xlsx``,``jp_Nutrient_total_2013.xlsx``,``jp_Nutrient_total_2012.xlsx``,``jp_Nutrient_total_2011.xlsx``,``jp_Nutrient_total_2010.xlsx``

  ``jp_Nutrient_male_2017.xlsx``,``jp_Nutrient_male_2016.xlsx``,``jp_Nutrient_male_2015.xlsx``,``jp_Nutrient_male_2014.xlsx``,``jp_Nutrient_male_2013.xlsx``,``jp_Nutrient_male_2012.xlsx``,``jp_Nutrient_male_2011.xlsx``,``jp_Nutrient_male_2010.xlsx``

  ``jp_Nutrient_female_2017.xlsx``,``jp_Nutrient_female_2016.xlsx``,``jp_Nutrient_female_2015.xlsx``,``jp_Nutrient_female_2014.xlsx``,``jp_Nutrient_female_2013.xlsx``,``jp_Nutrient_female_2012.xlsx``,``jp_Nutrient_female_2011.xlsx``,``jp_Nutrient_female_2010.xlsx``

* **jp_FoodG**: Food group intake breakdown of the population in Japan based on gender and different age groups.  
``jp_FoodG_total_2017.xlsx``,``jp_FoodG_total_2016.xlsx``,``jp_FoodG_total_2015.xlsx``,``jp_FoodG_total_2014.xlsx``,``jp_FoodG_total_2013.xlsx``,``jp_FoodG_total_2012.xlsx``,``jp_FoodG_total_2011.xlsx``,``jp_FoodG_total_2010.xlsx``

  ``jp_FoodG_male_2017.xlsx``,``jp_FoodG_male_2016.xlsx``,``jp_FoodG_male_2015.xlsx``,``jp_FoodG_male_2014.xlsx``,``jp_FoodG_male_2013.xlsx``,``jp_FoodG_male_2012.xlsx``,``jp_FoodG_male_2011.xlsx``,``jp_FoodG_male_2010.xlsx``

  ``jp_FoodG_female_2017.xlsx``,``jp_FoodG_female_2016.xlsx``,``jp_FoodG_female_2015.xlsx``,``jp_FoodG_female_2014.xlsx``,``jp_FoodG_female_2013.xlsx``,``jp_FoodG_female_2012.xlsx``,``jp_FoodG_female_2011.xlsx``,``jp_FoodG_female_2010.xlsx``

## Data Retrieved after Cleansing: 
* **KR_FoodG.csv**: Food group intake breakdown of children and teenagers in different age bracket and gender from South Korea.  
* **KR_Nutrient.csv**: Nutrition intake breakdown of children and teenagers in different age bracket and gender from South Korea.  
* **jp_FoodG.csv**: Food group intake breakdown of children and teenagers in different age bracket and gender from Japan.  
* **jp_Nutrient.csv**: Nutrition intake breakdown of children and teenagers in different age bracket and gender from Japan.  
* **us_FoodG.csv**: Food group intake breakdown of children and teenagers in different age bracket and gender from the US.  
* **us_Nutrient.csv**: Nutrition intake breakdown of children and teenagers in different age bracket and gender from the US.  
