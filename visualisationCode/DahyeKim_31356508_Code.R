##############################Importing Libraries##############################

library(shiny)
library(hrbrthemes)
library(viridis)
library(gridExtra)
library(plotly)
library(ggrepel)
library(tidyverse)
library(treemap)
library(sunburstR)
library(ggpubr)
library(reshape2)
library(ggplot2)
library(shinythemes)
library(shinyWidgets)

############Importing data sets & brief wrangling###############################

obesity.us <- read.csv('obesity_us_bubblePlot.csv')
obesity.us.bar <- read.csv('obesity_us_bar.csv')

obesity.us$Region<- as.factor(obesity.us$Region)
obesity.us$Race<- as.factor(obesity.us$Race)

obesity.country<- read.csv("obesity_workout_country.csv")
obesity.income <- read.csv('obesity_income_bar.csv')
obesity.race <- read.csv('obesity_race_bar.csv')
sorting.ref<- read.csv('sortingReference.csv')

food.country<- read.csv('country_food_balloon.csv')
food.income <- read.csv('income_food_subburt.csv')
food.race <- read.csv('race_food_sunburst.csv')

nutrient.country<- read.csv('country_nutrient_balloon.csv')
nutrient.income<- read.csv('income_nutrient_balloon.csv')
nutrient.race<- read.csv('race_nutrient.csv')


obesity.income$incomeLevel<- factor(obesity.income$incomeLevel, levels = c('income level I',
                                                                           'income level II',
                                                                           'income level III',
                                                                           'all individuals'))

obesity.us.bar$variable<- factor(obesity.us.bar$variable, levels=c("Child/Adolescent Obesity Rate",
                                                                   "Median Household Income",
                                                                   "White","Black",'Asian','Hispanic'))

socioecon.var <- c('Child/Adolescent\nObesity(%)\n','Median Household\nIncome(K)\n',
                   'White\n(%)\n','Asian\n(%)\n',
                   'Black\n(%)\n',
                   'Hispanic\n(%)\n')

names(socioecon.var)<-c("Child/Adolescent Obesity Rate",
                        "Median Household Income",
                        'White','Asian','Black','Hispanic')

variable <- c('Nutrition Consumption','Food Group Consumption')
race.prop<- levels(obesity.us$Race)
my_cols <- c('#2F043F','#795881','#808CB1','#74B4B1','#94D997','#FDF074')

sortedState<-sorting.ref%>%arrange(State)%>%select(State)%>%filter(State!='National')

obesity.us.bar$State<- factor(obesity.us.bar$State, levels = c(sortedState$State,'National'))

sorting.options<- c('Child/Adolescent Obesity Rate',
                    'Median Household Income',
                    'Race Distribution - White', 
                    'Race Distribution - Black',
                    'Race Distribution - Asian',
                    'Race Distribution - Hispanic',
                    'State - alphabetic')

mycss <- "
.irs-bar,
.irs-bar-edge,
.irs-single,
.irs-grid-pol {
  background: grey;
  border-color: white;
}
"

#######################bubble plot function####################################
bubblePlot<- function(choice){
  ggplot(obesity.us[obesity.us$Race==choice,], 
         aes(x= Median.Household.Income, 
             y= Race.Distribution, 
             size = Child.Adolescent.Obesity.Rate, 
             color = Region,
             text = paste('State: ',State,
                          '\nMedian Household Income: US$',Median.Household.Income,
                          '\nDistribution - ',Race,': ',Race.Distribution,'%',
                          '\nChild/Adolescent Obesity Rate: ',Child.Adolescent.Obesity.Rate,'%'))) +
    geom_point(alpha=0.7) +
    scale_size(range = c(1,9), name="Child Obesity Rate (%)") +
    scale_color_viridis(discrete=TRUE) +
    theme_ipsum()
}


#######################UI fluidPage############################################

ui <- fluidPage(
  theme=shinytheme("flatly"),
  br(),
  titlePanel(h1(HTML("    The Children of <em>Fat Land</em>"),
                style = "font-family: Georgia;",
                align = 'center')
             ),
  titlePanel(h1("    The Drivers of Child Obesity in the United States",
                style = "font-family: Georgia;",
                align = 'center')),
                br(),
  tags$head(
  tags$style(HTML("
          .navbar .navbar-nav {float: right}
          .navbar .navbar-titleNav {float: right}
        "))),
  
  
  navbarPage('',
             tabPanel('Motivation and Aim',
                      titlePanel(strong(em('The most physically active, yet the most obese children'))),
                      br(),
                      fluidRow(column(6,
                                      includeHTML('workout_obesity_desc.Rhtml')
                                      ),
                               column(6,
                                      plotlyOutput('obesity', height = '300px'),
                                      plotlyOutput('workout', height = '300px'))
                      ),
                      
                      titlePanel(strong('Do socioeconomic variables impact the child obesity in the U.S?')),
                      br(),
                      fluidRow(column(5,
                                      includeHTML('bubble_chart_desc.Rhtml')),
                               column(7,
                                      br(),
                                      selectInput('race.proportion.sel',choice = race.prop,
                                                  label = 'Select ethnicity for the race proportion axis:'),
                                      plotlyOutput("bubble", height = '450px')
                                      )),
                      titlePanel(strong('Big picture over each state in the U.S')),
                      br(),
                      'The side-by-side bar chart below shows the numeric value of each attribute of each state in detail. The state of Kentucky,\
                      Tennessee, and California rated the highest child/adolescent obesity rate in the country, while the state of Utah, Colorado, 
                      and Wyoming rated the lowest.',
                      br(),
                      br(),
                      'Select the state for comparison and hover over each bar for more detailed information.',
                      br(),
                      br(),
                      fluidRow(column(6,
                                      pickerInput('state.sel', label ='Select state:',
                                                  choices = levels(obesity.us.bar$State),
                                                  selected = levels(obesity.us.bar$State),
                                                  options = list(`actions-box` = TRUE),
                                                  multiple = TRUE), 
                                      align = 'center'),
                               column(6,
                                      selectInput('sortingChoice', label = 'Sort by:',
                                                  choices = sorting.options,
                                                  selected = 'Child/Adolescent Obesity Rate'),
                                      align = 'center')),
                      br(),
                      plotlyOutput('sidebysideBar', height = '850px')

             ),
             
             navbarMenu("Food and Nutrition Consumption",
                        tabPanel("Race and Ethnicity-wise Comparison",
                                 br(),
                                 br(),
                                 sidebarPanel(
                                   navbarPage('',
                                              tabPanel('Story',
                                                       h4(strong('Do socioeconomic variables impact the child obesity in the U.S?:')),
                                                       h4(strong('Race/Ethnicity and Obesity')),
                                                       includeHTML('story_race.Rhtml')),
                                              tabPanel('Nutrition Info',
                                                       includeHTML('nutrition_desc_income_race.Rhtml')),
                                              tabPanel('Food Group Info',
                                                       includeHTML('foodGroup_race_income.Rhtml')))),
                                 mainPanel(
                                   tabsetPanel(
                                     tabPanel('Daily Consumption to Obesity Rate',
                                              fluidRow(
                                                column(6,
                                                       br(),
                                                       selectInput('race.sel',
                                                                   choice = variable,
                                                                   label = 'Select Food Group or Nutrition for Comparison:'), 
                                                       align = 'center'),
                                                column(6,
                                                       br(),
                                                       sliderInput('yrRace','Year',min = 2007, max = 2015, step =2, value =2007, sep =''),
                                                       'Year Selected: ', textOutput('yrR2'), 
                                                       align = 'center')),
                                              br(),
                                              br(),
                                              plotOutput('balloon.race'),
                                              plotlyOutput('bar.obesity.race',width = "90%")),
                                     
                                     tabPanel('Daily Consumption Proportion',
                                              fluidRow(
                                                column(6, 
                                                       br(),
                                                       selectInput('race.sel.sunburst',choice = variable,
                                                                           label = 'Select Food Group or Nutrition for Comparison:'), 
                                                       align= 'center'),
                                                column(6,br(),
                                                       sliderInput('yrRaceSunburst','Year',min = 2007, max = 2015, step =2, value =2007, sep =''),
                                                       'Year Selected: ', 
                                                       textOutput('yrR3'), 
                                                       alignt = 'center')
                                              ),
                                              br(),
                                              br(),
                                              fluidRow(
                                                column(6,
                                                       textOutput('race1'),
                                                       sund2bOutput('sunburst.race1'),align = "center"),
                                                column(6,
                                                       textOutput('race2'),
                                                       sund2bOutput('sunburst.race2'),align = "center")
                                              ),
                                              fluidRow(
                                                column(6,
                                                       textOutput('race3'),align = "center",
                                                       sund2bOutput('sunburst.race3')),
                                                column(6,
                                                       textOutput('race4'),align = "center",
                                                       sund2bOutput('sunburst.race4'))
                                              )
                                     )
                                   )
                                   
                                 )
                        ),
                        tabPanel('Income-wise Comparison',
                                 br(),
                                 br(),
                                 sidebarPanel(
                                   navbarPage('',
                                              tabPanel('Story',
                                                       h4(strong('Do socioeconomic variables impact the child obesity in the U.S?:')),
                                                       h4(strong('Income and Obesity')),
                                                       includeHTML('story_income.Rhtml')),
                                              tabPanel('Nutrition Info',
                                                       includeHTML('nutrition_desc_income_race.Rhtml')),
                                              tabPanel('Food Group Info',
                                                       includeHTML('foodGroup_race_income.Rhtml')))),
                                 mainPanel(
                                   tabsetPanel(
                                     tabPanel('Daily Consumption to Obesity Rate',
                                              fluidRow(
                                                column(6,
                                                       br(),
                                                       selectInput('income.sel',
                                                                   choice = variable,
                                                                   label = 'Select Food Group or Nutrition for Comparison:'), 
                                                       align = 'center'),
                                                column(6,
                                                       br(),
                                                       sliderInput('yrIncome','Year',min = 2007, max = 2015, step =2, value =2007, sep =''),
                                                       'Year Selected: ',textOutput('yrR'))),
                                              br(),
                                              br(),
                                              plotOutput('balloon.income', height = '450px'),
                                              plotlyOutput('bar.obesity.income',width = "90%",height = '450px')),
                                     
                                     tabPanel('Daily Consumption Proportion',
                                              fluidRow(
                                                br(),
                                                column(6,
                                                       selectInput('income.sel.sunburst',
                                                                   choice = variable,
                                                                   label = 'Select Food Group or Nutrition for Comparison:'), 
                                                       align='center'),
                                                column(6,
                                                       tags$style(mycss),
                                                       sliderInput('yrIncomeSunburst','Year',min = 2007, max = 2015, step =2, value =2007, sep =''),
                                                       'Year Selected: ', textOutput('yrR4'), 
                                                       align='center')),
                                              br(),
                                              br(),
                                              
                                              fluidRow(
                                                column(6,
                                                       h4('Income Level I - $0-$24,999'),
                                                       sund2bOutput('sunburst.income1'), 
                                                       align = "center"),
                                                column(6,
                                                       h4('Income Level II - $25,000-$74,999'),
                                                       sund2bOutput('sunburst.income2'), 
                                                       align = "center")
                                              ),
                                              fluidRow(
                                                column(6,
                                                       h4('Income Level III - $75,000 or higher'),
                                                       sund2bOutput('sunburst.income3'),
                                                       align = "center"),
                                                
                                                column(6,
                                                       h4('all individuals'),
                                                       sund2bOutput('sunburst.income4'),
                                                       align = "center")))
                                   )),
                                 
                        ),
                        tabPanel('Country-wise Comparison',
                                 sidebarPanel(
                                   navbarPage('',
                                              tabPanel('Story',
                                                       h4(strong('How does the nutrition and food intake of children in the U.S differ from those from the rest of the first world countries?')),
                                                       includeHTML('comparison_desc_country.Rhtml')),
                                              tabPanel('Nutrition Info',
                                                       includeHTML('nutrition_desc_country.Rhtml')))),
                                 mainPanel(
                                   br(),
                                   br(),
                                   h4(strong("Country-wise Daily Food Group and Nutrition Consumption")),
                                   br(),
                                   selectInput('country.sel',
                                               choice = variable,
                                               label = 'Select Food Group or Nutrition for Comparison:'),
                                   
                                   plotOutput('balloon.country',height = '650px'),
                                   plotlyOutput('bar.obesity.country',width = "90%")),
                                 
                        )),
             tabPanel('Reference',
                      mainPanel(includeHTML('citation.Rhtml'))
                      
             )))
######################Server Function##########################################

server<-function(input, output, session) {
  
  #######################national obesity comparison (bubble)##################
  output$bubble <- renderPlotly({
    ggplotly(bubblePlot(input$race.proportion.sel), 
             tooltip = 'text')
  })
  
  #######################national obesity comparison (bar)#####################
  
  observe({
    input$state.sel
  })
  
  sortedState<- reactive({
    if (input$sortingChoice == 'Child/Adolescent Obesity Rate'){
      sortedState<-sorting.ref%>%arrange(Child.Adolescent.Obesity.Rate)%>%select(State)%>%filter(State!='National')
    } else if(input$sortingChoice == 'Race Distribution - White'){
      sortedState<-sorting.ref%>%arrange(White)%>%select(State)%>%filter(State!='National')
    } else if(input$sortingChoice == 'Race Distribution - Black'){
      sortedState<-sorting.ref%>%arrange(Black)%>%select(State)%>%filter(State!='National')
    } else if(input$sortingChoice == 'Race Distribution - Asian'){
      sortedState<-sorting.ref%>%arrange(Asian)%>%select(State)%>%filter(State!='National')
    } else if(input$sortingChoice == 'Race Distribution - Hispanic'){
      sortedState<-sorting.ref%>%arrange(Hispanic)%>%select(State)%>%filter(State!='National')
    } else if(input$sortingChoice == 'Median Household Income'){
      sortedState<-sorting.ref%>%arrange(Median.Household.Income)%>%select(State)%>%filter(State!='National')
    }else {
      sortedState<-sorting.ref%>%arrange(State)%>%select(State)%>%filter(State!='National')
    }
    c(sortedState$State,'National')
  })
  
  state.input<- reactive({
    obesity.us.bar$State<- factor(obesity.us.bar$State, levels = sortedState())
    obesity.us.bar[obesity.us.bar$State%in%input$state.sel,]
  })
  
  output$sidebysideBar<- renderPlotly({
    ggplotly(ggplot(state.input(),aes(x = State, y = value,
                                      text = paste0('State: ',State,
                                                    '\nValue: ',round(value,2))))+
               geom_bar(stat = 'identity', aes(fill = fac), width = 0.8)+
               coord_flip() +
               facet_grid(.~variable, labeller = labeller(variable = socioecon.var))+
               theme_minimal()+
               theme(strip.text.x = element_text(size = 10, color = "Black", face = "bold"),
                     legend.position = "none",
                     axis.title.x = element_blank())+
               scale_fill_manual(values= my_cols)+ 
               scale_y_sqrt(),tooltip = 'text')
  })
  
  
  #######################international obesity comparison (bar)################
  
  output$obesity<- renderPlotly({
    ggplotly(ggplot(obesity.country, aes(x=country, 
                                         y=obesity,
                                         text=paste0('Country: ',country,
                                                     '\nChild Obesity Rate: ',obesity,'%')))+
               geom_bar(stat = 'identity', width = 0.6, fill = '#a1dab4')+
               scale_color_viridis(discrete=TRUE)+
               scale_y_continuous(limits=c(0,60), 'Child Obesity Rate(%)')+
               theme_ipsum()+
               theme(axis.title.x=element_blank(),
                     axis.ticks.x=element_blank()),
             tooltip = 'text')
  })
  
  output$workout<- renderPlotly({
    
    ggplotly(ggplot(obesity.country, aes(x=country, 
                                         y=workout,
                                         text=paste0('Country: ',country,
                                                     '\nChildren Workout Rate: ',workout,'%')))+
               geom_bar(stat = 'identity', width = 0.6, fill = '#fc8d59')+
               scale_color_viridis(discrete=TRUE) +
               theme(axis.title.y = element_text(face="bold", size = 14))+
               theme_ipsum()+ 
               scale_y_reverse(limits =c(70,0), 
                               name = 'Children Workout 5 Times a Week'),
             tooltip = 'text')
    
  })
  #######################country nutrient consumption comparson#################
  output$balloon.country<- renderPlot({
    if(input$country.sel=='Nutrition Consumption'){
      dat <- nutrient.country
    } else{ dat<- food.country}
    dat%>%
      spread(country, value)%>% 
      column_to_rownames(., var = "variable")%>%
      drop_na()%>%
      ggballoonplot(fill = "value")+
      scale_fill_gradientn(colors = my_cols)+
      ylab(ifelse(input$country.sel=='Nutrition Consumption',
                  'Daily Consumption of Nutrition Elements by Countries\n',
                  'Daily Food Group Consumption by Countries\n'))+
      theme(axis.title.y = element_text(size =13, angle = 90),
            axis.text.x = element_text(size=13),
            axis.text.y=element_text(size = 12))
  })
  #######################country obesity bar comparison########################
  output$bar.obesity.country<-renderPlotly({
    if(input$country.sel=='Nutrition Consumption'){
      dat <- nutrient.country
    } else{ dat<- food.country}
    ggplotly(ggplot(obesity.country[obesity.country$country%in%dat$country,], 
                    aes(x=country, y=obesity))+
               geom_bar(stat = 'identity', 
                        width = 0.4, 
                        fill = '#7DD9C7',
                        size = 0.2, color = 'black')+
               scale_color_viridis(discrete=TRUE) +  theme_ipsum()+
               scale_y_reverse(limits =c(20,0))+
               ylab('Child Obesity Rate(%)')+
               theme(axis.title.x=element_blank(),
                     axis.ticks.x=element_blank(),
                     axis.title.y = element_text(size =13, angle = 90)))
  })
  #######################income balloon plot food nutrient ####################
  
  observe({
    new_yrIncome <- input$yrIncomeSunburst
    new_income.sel.sunburst <- input$income.sel.sunburst
    
    updateSliderInput(session, 'yrIncome', value = new_yrIncome)
    
    updateSelectInput(session, 
                      'income.sel', 
                      selected = new_income.sel.sunburst, 
                      choices = variable)
    
  })
  
  yrRange <- reactive(
    paste0(input$yrIncome,'-',input$yrIncome+1)
  )
  
  output$yrR<- renderText({yrRange()})
  
  output$balloon.income<- renderPlot({
    
    if(input$income.sel=='Nutrition Consumption'){
      dat <- nutrient.income
    } else{ dat<- food.income}
    
    dat%>%
      filter(year ==yrRange())%>%
      select(variable, income, value)%>%
      spread(income, value)%>% 
      column_to_rownames(., var = "variable")%>%
      drop_na()%>%
      ggballoonplot(fill = "value")+
      scale_fill_gradientn(colors = my_cols)+ 
      theme_ipsum()+
      theme(axis.text.y=element_text(size=13),
            axis.title.y=element_blank(),
            axis.title.x=element_blank(),
            axis.text.x=element_text(size = 13))
  })
  
  output$bar.obesity.income<-renderPlotly({
    ggplotly(ggplot(obesity.income, 
                    aes(x=incomeLevel, y=Data_Value,
                        text = paste('income bracket: ',incomeLevel,
                                     '\nchild obesity rate: ',round(Data_Value,2),'%')))+
               geom_bar(stat = 'identity', width = 0.4, fill = '#7DD9C7')+
               scale_color_viridis(discrete=TRUE) +xlab("Income Level") + 
               ylab("Child Obesity Rate(%)")+
               scale_y_reverse(limits =c(20,0))+
               theme_ipsum()+
               theme(axis.text.y=element_text(size=13),
                     axis.text.x=element_text(size = 13)), tooltip = 'text')
  })
  #######################income nutrient proportion (sunburst)#################
  
  yrRange1 <- reactive(
    paste0(input$yrIncomeSunburst,'-',input$yrIncomeSunburst+1)
  )
  
  output$yrR4<- renderText({yrRange1()})
  
  output$sunburst.income1<-renderSund2b({
    if(input$income.sel.sunburst=='Nutrition Consumption'){
      dat <- nutrient.income%>%
        filter(year ==yrRange1()&
                 income==unique(nutrient.income$income)[1])%>%
        select("nutrientGroup",'variable','value')%>%
        mutate(path = paste(nutrientGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)
    } else{ 
      dat<- food.income%>%
        filter(year ==yrRange1()&income==unique(food.income$income)[1])%>%
        select('foodGroup','variable','value')%>%
        mutate(path = paste(foodGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)}
    
    sund2b(dat)
  })
  
  output$sunburst.income2<-renderSund2b({
    if(input$income.sel.sunburst=='Nutrition Consumption'){
      dat <- nutrient.income%>%
        filter(year ==yrRange1()&
                 income==unique(nutrient.income$income)[2])%>%
        select("nutrientGroup",'variable','value')%>%
        mutate(path = paste(nutrientGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)
    } else{ 
      dat<- food.income%>%
        filter(year ==yrRange1()&income==unique(food.income$income)[2])%>%
        select('foodGroup','variable','value')%>%
        mutate(path = paste(foodGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)}
    
    sund2b(dat)
  })
  
  output$sunburst.income3<-renderSund2b({
    if(input$income.sel.sunburst=='Nutrition Consumption'){
      dat <- nutrient.income%>%
        filter(year ==yrRange1()&
                 income==unique(nutrient.income$income)[3])%>%
        select("nutrientGroup",'variable','value')%>%
        mutate(path = paste(nutrientGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)
    } else{ 
      dat<- food.income%>%
        filter(year ==yrRange1()&
                 income==unique(food.income$income)[3])%>%
        select('foodGroup','variable','value')%>%
        mutate(path = paste(foodGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)}
    
    sund2b(dat)
  })
  
  output$sunburst.income4<-renderSund2b({
    if(input$income.sel.sunburst=='Nutrition Consumption'){
      dat <- nutrient.income%>%
        filter(year ==yrRange1()&
                 income==unique(nutrient.income$income)[4])%>%
        select("nutrientGroup",'variable','value')%>%
        mutate(path = paste(nutrientGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)
    } else{ 
      dat<- food.income%>%
        filter(year ==yrRange1()&
                 income==unique(food.income$income)[4])%>%
        select('foodGroup','variable','value')%>%
        mutate(path = paste(foodGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)}
    
    sund2b(dat)
  })
  #######################race nutrient consumption balloon#####################
  
  
  observe({
    new_yrRace <- input$yrRaceSunburst
    new_race.sel.sunburst <- input$race.sel.sunburst
    
    updateSliderInput(session, 'yrRace', value = new_yrRace)
    
    updateSelectInput(session, 
                      'race.sel', 
                      selected = new_race.sel.sunburst, 
                      choices = variable)

  })
  
  yrRange2 <- reactive(
    paste0(input$yrRace,'-',input$yrRace+1)
  )
  output$yrR2<- renderText({yrRange2()})
  
  output$balloon.race<- renderPlot({
    
    if(input$race.sel=='Nutrition Consumption'){
      dat <- nutrient.race
    } else{ dat<- food.race}
    
    dat%>%
      filter(year ==yrRange2())%>%
      select(variable, race, value)%>%
      spread(race, value)%>% 
      column_to_rownames(., var = "variable")%>%
      drop_na()%>%
      ggballoonplot(fill = "value")+
      scale_fill_gradientn(colors = my_cols)
  })
  #######################race obesity bar comparison ##########################
  
  output$bar.obesity.race<-renderPlotly({
    barp<- obesity.race%>%filter(YearStart ==yrRange2())%>%
      ggplot(aes(x=Stratification1, y=Data_Value,
                 text = paste('race/ethnicity: ',Stratification1,
                              '\nchild obesity rate: ',round(Data_Value,2),'%')))+
      geom_bar(stat = 'identity', width = 0.4, fill = '#7DD9C7')+
      scale_color_viridis(discrete=TRUE) +
      xlab("Race/Ethnicity") + 
      ylab("Child Obesity Rate(%)")+ 
      theme_ipsum()+
      scale_y_reverse(limits =c(20,0))
    ggplotly(barp, tooltip = 'text')})
  
  
  #######################race food nutrient proportion sunburst#################
  
  yrRange3 <- reactive(
    paste0(input$yrRaceSunburst,'-',input$yrRaceSunburst+1)
  )
  output$yrR3<- renderText({yrRange3()})
  
  raceGroup <- reactive({
    if(input$race.sel.sunburst=='Nutrition Consumption'){
      dat <- unique(nutrient.race$race[nutrient.race$year==yrRange3()])
    } else{ 
      dat <- unique(food.race$race[food.race$year==yrRange3()])}
    dat
  })
  
  output$sunburst.race1<-renderSund2b({
    if(input$race.sel.sunburst=='Nutrition Consumption'){
      dat <- nutrient.race%>%
        filter(year ==yrRange3()&
                 race==raceGroup()[1])%>%
        select("nutrientGroup",'variable','value')%>%
        mutate(path = paste(nutrientGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)
    } else{ 
      dat<- food.race%>%
        filter(year ==yrRange3()&race==raceGroup()[1])%>%
        select('foodGroup','variable','value')%>%
        mutate(path = paste(foodGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)}
    
    sund2b(dat)
  })
  
  output$race1<- renderText({
    raceGroup()[1]
  })
  
  output$sunburst.race2<-renderSund2b({
    if(input$race.sel.sunburst=='Nutrition Consumption'){
      dat <- nutrient.race%>%
        filter(year ==yrRange3()&
                 race==raceGroup()[2])%>%
        select("nutrientGroup",'variable','value')%>%
        mutate(path = paste(nutrientGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)
    } else{ 
      dat<- food.race%>%
        filter(year ==yrRange3()&race==raceGroup()[2])%>%
        select('foodGroup','variable','value')%>%
        mutate(path = paste(foodGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)}
    
    sund2b(dat)
  })
  output$race2<- renderText({
    raceGroup()[2]
  })
  output$sunburst.race3<-renderSund2b({
    if(input$race.sel.sunburst=='Nutrition Consumption'){
      dat <- nutrient.race%>%
        filter(year ==yrRange3()&
                 race==raceGroup()[3])%>%
        select("nutrientGroup",'variable','value')%>%
        mutate(path = paste(nutrientGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)
    } else{ 
      dat<- food.race%>%
        filter(year ==yrRange3()&
                 race==raceGroup()[3])%>%
        select('foodGroup','variable','value')%>%
        mutate(path = paste(foodGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)}
    
    sund2b(dat)
  })
  output$race3<- renderText({
    raceGroup()[3]
  })
  output$sunburst.race4<-renderSund2b({
    if(input$race.sel.sunburst=='Nutrition Consumption'){
      dat <- nutrient.race%>%
        filter(year ==yrRange3()&
                 race==raceGroup()[4])%>%
        select("nutrientGroup",'variable','value')%>%
        mutate(path = paste(nutrientGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)
    } else{ 
      dat<- food.race%>%
        filter(year ==yrRange3()&
                 race==raceGroup()[4])%>%
        select('foodGroup','variable','value')%>%
        mutate(path = paste(foodGroup,variable,sep = '-'))%>%
        dplyr::select(path, value)}
    
    sund2b(dat)
  })
  
  output$race4<- renderText({
    raceGroup()[4]})
}

shinyApp(ui, server)

