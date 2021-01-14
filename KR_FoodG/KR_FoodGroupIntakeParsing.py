from urllib.request import urlopen
# opening URL for parsing
from bs4 import BeautifulSoup
# web scraping tool
import re
# regex for parsing attribute partitions
import pandas as pd

'''
The following chunk of code parses one of the tables we need in order to retrieve
the age groups for the 'age' attribute in the new dataset
'''
html = urlopen('https://www.khidi.or.kr/kps/dhraStat/result9?menuId=MENU01662&gubun=ageall&year=2008')
bsobj=BeautifulSoup(html, 'lxml')
# scraping the html into lxml format using BeautifulSoup

age = []
# storing age group parsed from the lxml generated by BeautifulSoup
for i in bsobj.find('ul',{'id':'subTabMenu', \
                          'class':'normal_tab'}).findAll('a'):
                          # loop through all the 'ul' tags, whose class is 'normal tab', find all the elements with anchors
    age.append(re.findall('(.*)세',i.text)[0])
    # '세' is the word comes after each age group
    # retrieve all the age groups from the tag and append it to 'age' list

'''
The following chunk of code parses the food group intake tables distributed
amongst different websites from KHIDI.
'''
KR_foodGIntake = list()
# the list to save all the dataframe scraped from the urls

for gender in ('man','all','woman'):
# loop through each gender since each gender and age group has a table for food group intake
    gubun = 'gubun=age'+gender
    # url ending for each gender

    for yr in range(2008,2019):
    # loop through each year for each gender
        year = '&year='+str(yr)
        # url ending for each year

        for a in age:
        # for each age group parsed above

            ageGroup = '&category='+a
            # url ending for each age group

            url = 'https://www.khidi.or.kr/kps/dhraStat/result9?menuId=MENU01662&'+gubun+year+ageGroup
            # the url for each table

            html = urlopen(url)
            bsobj=BeautifulSoup(html, 'lxml')
            # generate lxml from each website

            foodGIntake = [i.text for i in bsobj.find('tbody').findAll('td')]
            # use list comprehension to parse all the 'td' tags, which are the cells of the entire data frame

            df = dict()
            # convert the list of texts into dictionary in order to ease the conversion for dataframe

            for i in range(1,len(foodGIntake),12):
                df[foodGIntake[i-1]] = [foodGIntake[i]]
                # attrebute name is the key to the diciontary, and the attribute is put into an array

            df['Year'] = [yr]
            # add year attribute to the dataframe
            df['Age'] = a
            # add age attribute to the dataframe

            if gender == 'man':
                df['Gender'] = 'Male'
            elif gender == 'woman':
                df['Gender'] = 'Female'
            elif gender == 'all':
                df['Gender'] = 'All'
            # add gender attribute to the data frame

            KR_foodGIntake.append(pd.DataFrame(df))
            # add the final data frame into KR_foodGIntake list

finalTB = pd.concat(KR_foodGIntake)
# concatenate all the tables in the list and form a single data frame

'''
Following chunks of code corrects the attribute names of the dataset.
Some of the dataframes' attributes were misspelled by the publisher, and thus I
corrected the anomalies.
'''
finalTB['우유류 및 그 제품'][finalTB['우유류 및 그 제품'].isna()] = \
finalTB['유류 및 그 제품'][finalTB['우유류 및 그 제품'].isna()]

finalTB['유지류(동물성)'][finalTB['유지류(동물성)'].isna()] =\
finalTB['유지(동물성)'][finalTB['유지류(동물성)'].isna()]

finalTB['음료 및 주류'] = finalTB['음료 및 주류'].astype(float)
finalTB['음료류'] = finalTB['음료류'].astype(float)
finalTB['주류'] = finalTB['주류'].astype(float)
# change the datatype of the attributes from string to floating numbers

finalTB['음료 및 주류'][finalTB['음료 및 주류'].isna()] = \
finalTB['음료류'][finalTB['음료 및 주류'].isna()] + \
finalTB['주류'][finalTB['음료 및 주류'].isna()]

finalTB.drop(['유지(동물성)','유지(식물성)','유류 및 그 제품','음료류','주류','기타(동물성)'], axis = 1, inplace = True)
# drop all the attributes whose attribute names are misspelled

finalTB.to_csv('KR_FoodG.csv', index = False)
# export it to CSV file 
