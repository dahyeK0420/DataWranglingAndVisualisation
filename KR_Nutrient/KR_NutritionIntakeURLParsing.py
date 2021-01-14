from urllib.request import urlopen
from bs4 import BeautifulSoup
import re
import pandas as pd

def nutrientIntakeDict(elementList):
    nutrientIntake = dict()
    for eachElement in elementList:
        for i in range(len(eachElement)):
            nutrientIntake[eachElement[0]] = eachElement[1:]
    return nutrientIntake

KR_nutrientIntake = list()

for i in range(1,4):
    url = 'https://www.khidi.or.kr/kps/dhraStat/result5?menuId=MENU01657&gubun=age'+str(i)
    eachGender = list()

    for yr in range(2008,2019):
        urlwithYr = url+'&year='+str(yr)
        html = urlopen(urlwithYr)
        bsobj=BeautifulSoup(html, 'lxml')

        age = [agesCol.text for agesCol in bsobj.find('thead').findAll('th')[1:10]]

        nutrientIntakeAvgMargin = [nutrient.text for nutrient in bsobj.find('tbody').findAll('td')]
        element = [nutrientIntakeAvgMargin[x:x+19] for x in range(0, len(nutrientIntakeAvgMargin), 19)]

        nutrientIntakeTB = pd.DataFrame(nutrientIntakeDict(element))
        nutrientIntakeTB.drop([i for i in range(1,18,2)], inplace = True)

        nutrientIntakeTB['Age'] = age
        nutrientIntakeTB['Year'] = yr
        eachGender.append(nutrientIntakeTB)

    nutrientIntakeGender = pd.concat(eachGender)

    if i == 1:
        nutrientIntakeGender['Gender'] = 'All'
    elif i == 2:
        nutrientIntakeGender['Gender'] = 'Male'
    elif i == 3:
        nutrientIntakeGender['Gender'] = 'Female'

    KR_nutrientIntake.append(nutrientIntakeGender)

finalTB = pd.concat(KR_nutrientIntake)

finalTB = finalTB[['Age', 'Year', 'Gender','에너지(Kcal)', '단백질(g)', '동물성단백질(g)', '지방(g)', '탄수화물(g)', '칼슘(mg)',
   '인(mg)', '철(mg)', '나트륨(mg)', '칼륨(mg)', '티아민(mg)', '리보플라빈(mg)',
   '비타민C(mg)', '동물성단백질비(%)', '지방급원에너지비(%)']]

finalTB.to_csv('kr_Nutrient.csv', index = False)
