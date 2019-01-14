#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(readr)
library(shinythemes)
library(plotly)

#load in data
wines <- read_csv("data/winemag-data-130k-v2.csv", 
                  col_types = cols(X1 = col_skip()))

#remove country NA data?
wines <- wines %>% 
      filter(!is.na(country))

#create three quality categories
wines <- wines %>% 
      mutate(quality = ifelse(points < 86, "Low Quality", 
                              ifelse(between(points,86,91), "Medium Quality", 
                                     ifelse(points > 91, "High Quality", NA))))


#change NA values to "Not recorded"


ui <- fluidPage(
   
      theme = shinytheme("united"),
      
      titlePanel("Worldly Wines"),
      
      sidebarLayout(
            sidebarPanel(
                  selectizeInput('country', 
                                 'Country Selection',
                                 choices = unique(wines$country),
                                 multiple = TRUE
                  ),
                  selectizeInput('province', 
                                 'Province Selection',
                                 choices = NULL,
                                 multiple = TRUE
                  ),
                  selectizeInput('region', 
                                 'Region Selection',
                                 choices = NULL,
                                 multiple = TRUE
                  ),
                  selectizeInput('variety', 
                                 'Select a Variety of Wine',
                                 choices = NULL,
                                 multiple = TRUE
                  ),
                  checkboxGroupInput('quality',
                                     "Filter by Points Quality?",
                                     choices = unique(wines$quality)
                  )
                  
            ),
            mainPanel(
                  plotlyOutput('crossplot')
            )
            
      )
      
)


server <- function(input, output, session) {
      
      # change province choices based on country
      observeEvent(input$country,{
            updateSelectizeInput(session,'province',
                                 choices = wines %>% 
                                       filter(country == input$country) %>% 
                                       distinct(province))
      }) 
      
      # change region choices based on province
      observeEvent(input$province,{
            updateSelectizeInput(session,'region',
                                 choices = wines %>% 
                                       filter(province == input$province) %>% 
                                       distinct(region_1))
      }) 
      
      # change variety choices based on region
      observeEvent({input$region},
                   {
                         updateSelectizeInput(session,'variety',
                                              choices = wines %>% 
                                                    filter(province == input$province,
                                                           country == input$country,
                                                           region_1 == input$region) %>% 
                                                    distinct(variety))
                   })
      
      
      
      output$crossplot <- renderPlotly()
}

# Run the application 
shinyApp(ui = ui, server = server)

