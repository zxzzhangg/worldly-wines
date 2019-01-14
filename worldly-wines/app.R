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

#load in cleaned data
wines <- read_csv("data/winemag-data-130k-v2.csv", 
                  col_types = cols(X1 = col_skip()))

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
                                     choices = unique(wines$quality),
                                     selected = unique(wines$quality)
                  )
                  
            ),
            mainPanel(
                  plotlyOutput('crossplot')
            )
            
      )
      
)

server <- function(input, output, session) {
      
      #observe(print(input$country))
      
      # change province choices based on country
      observeEvent(input$country,{
            updateSelectizeInput(session,'province',
                                 choices = wines %>% 
                                       filter(country %in% input$country) %>% 
                                       distinct(province))
      }) 
      
      # change region choices based on province
      observeEvent(input$province,{
            updateSelectizeInput(session,'region',
                                 choices = wines %>% 
                                       filter(province %in% input$province) %>% 
                                       distinct(region_1))
      }) 
      
      # change variety choices based on region
      observeEvent({input$region},
                   {
                         updateSelectizeInput(session,'variety',
                                              choices = wines %>% 
                                                    filter(region_1 %in% input$region) %>% 
                                                    distinct(variety))
                   })
      
      wines_filtered <- reactive(
            wines %>% 
                  filter(country %in% input$country,
                         province %in% input$province,
                         region_1 %in% input$region,
                         quality %in% input$quality)
      )
      
      output$crossplot <- renderPlotly({
            
            p <- ggplot(wines_filtered(), aes(x = points, y = price)) +
                  geom_jitter(aes(text = title))
            ggplotly(p)
      })
}

# Run the application 
shinyApp(ui = ui, server = server)

