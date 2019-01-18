#
# Worldly Wines shiny app
#
# By Zixin Zhang and Evan Yathon
# January 2019
#
# This app allows the user to explore wine ratings and prices in various countries and provinces in the world.  
# Hover information allows the user to further identify specific wines 
#

library(shiny)
library(tidyverse)
library(readr)
library(shinythemes)
library(plotly)


#break into good, bad average quality
wines <- read.csv("../data/wines.csv")

wines %>% 
   filter(country == 'Canada') %>% 
   distinct(province) -> de


ui <- fluidPage(
   
      theme = shinytheme("united"),
      
      titlePanel("Worldly Wines"),
      
      sidebarLayout(
            sidebarPanel(
                  selectizeInput('country', 
                                 'Country Selection (Mandatory Input for Crossplot)',
                                 choices = unique(wines$country),
                                 multiple = TRUE,
                                 selected = 'Canada'
                  ),
                  selectizeInput('province', 
                                 'Province Selection (Mandatory Input for Crossplot)',
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
               plotlyOutput('histplot_price'),
               plotlyOutput('histplot_points'),
               plotlyOutput('crossplot')
            )
            
      )
      
)

server <- function(input, output, session) {
      
      observe(print(input$country))
      
      # change province choices based on country
      observeEvent(input$country,{
            updateSelectizeInput(session,'province',
                                 choices = wines %>% 
                                       filter(country %in% input$country) %>% 
                                       distinct(province), selected='British Columbia')
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
            
            if(is.null(input$region) & 
               is.null(input$variety)){wines %>% filter(country %in% input$country,
                                                        province %in% input$province,
                                                        quality %in% input$quality)
                  
            } else if(is.null(input$variety)){wines %>% filter(country %in% input$country,
                                                               province %in% input$province,
                                                               quality %in% input$quality,
                                                               region_1 %in% input$region)
                  
            } else if(is.null(input$region)){wines %>% filter(country %in% input$country,
                                                              province %in% input$province,
                                                              quality %in% input$quality,
                                                              variety %in% input$variety)
                     
            } else{
                  wines %>% 
                        filter(country %in% input$country,
                               province %in% input$province,
                               region_1 %in% input$region,
                               quality %in% input$quality,
                               variety %in% input$variety)
            }
            
            
            
      )
      
      output$crossplot <- renderPlotly({
            
            p <- ggplot(wines_filtered(), aes(x = points, y = price, colour = quality)) +
               geom_jitter(aes(text = title)) +
               ggtitle("Price VS Points")
                  
            ggplotly(p)
      })
      
      output$histplot_price <- renderPlotly({
         p1 <- ggplot(wines_filtered(), aes(x = price, color=quality)) +
            geom_density(aes(fill = quality), alpha = 0.3) +
            ggtitle("Price Distribution")
         ggplotly(p1)
      })
      
      
      output$histplot_points <- renderPlotly({
         p2 <- ggplot(wines_filtered(), aes(points, color = quality)) +
            geom_bar(aes(fill = quality),position="dodge", alpha = 0.5) +
            ggtitle("Points Distribution")  
         ggplotly(p2)
      })
      
      
}

# Run the application 
shinyApp(ui = ui, server = server)

