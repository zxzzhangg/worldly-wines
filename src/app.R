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
library(shinyWidgets)
library(shinythemes)


#load cleaned data that was cleaned/modified using load_data.R

wines <- read_csv("data/wines.csv")

wines$quality <- with(wines, reorder(quality, points))
wines$price_range <- with(wines, reorder(price_range, price))

#create UI
ui <- fluidPage(
   
      theme = shinytheme("flatly"),
      
      titlePanel("Worldly Wines"),
      
      sidebarLayout(
            sidebarPanel(
                  # country selection; defaulted to Canada
                  pickerInput('country', 
                              'Country Selection',
                              choices = unique(wines$country),
                              selected = "Canada"
                  ),
                  # province selection; defaulted to British Columbia in server
                  pickerInput('province', 
                              'Province Selection (Mandatory Input)',
                              choices = NULL,
                              multiple = TRUE,
                              options = list(`actions-box` = TRUE)
                  ),
                  # region selection
                  pickerInput('region', 
                                 'Region Selection',
                                 choices = NULL,
                                 multiple = TRUE,
                              options = list(`actions-box` = TRUE)
                  ),
                  # variety selection
                  pickerInput('variety', 
                              'Select a Variety of Wine',
                              choices = NULL,
                              multiple = TRUE,
                              options = list(`actions-box` = TRUE)
                  ),
                  # quality selection
                  checkboxGroupInput('quality',
                                     "Filter by Points Quality?",
                                     choices = levels(wines$quality),
                                     selected = levels(wines$quality)
                  ),
                  # price selection
                  checkboxGroupInput('price_range',
                                     "Filter by Price Range?",
                                     choices = levels(wines$price_range),
                                     selected = levels(wines$price_range)
                  )
                  
            ),
            mainPanel(
                  tabsetPanel(
                        tabPanel("Explore Distributions of Prices and Ratings",
                                 plotlyOutput('histplot_price') ,
                                 plotlyOutput('histplot_points', width = "65%")                  
                        ),
                        tabPanel("Explore the Relationship between Price and Rating",
                                 plotlyOutput('crossplot')
                        )
                  ))
      )
)


server <- function(input, output, session) {
      
      observe(print(wines %>% 
                           filter(country %in% input$country) %>%
                           distinct(province)))
      
      # change province choices based on country
      observeEvent(input$country,{
            updatePickerInput(session,'province',
                              choices = wines %>% 
                                    filter(country %in% input$country) %>%
                                    distinct(province),
                              #selected = "British Columbia")
                              selected = (wines %>% 
                                    filter(country %in% input$country) %>%
                                    distinct(province))[2,1])
      }) 
      
      # change region choices based on province
      observeEvent(input$province,{
            updatePickerInput(session,'region',
                              choices = wines %>% 
                                    filter(province %in% input$province) %>% 
                                    distinct(region_1))
      }) 
      
      # change variety choices based on region
      observeEvent(input$region,{
            updatePickerInput(session,'variety',
                              choices = wines %>% 
                                    filter(region_1 %in% input$region) %>% 
                                    distinct(variety))
      })
      #create data frame with options for no selection
      wines_filtered <- reactive(
            
            if(is.null(input$region) & 
               is.null(input$variety)){wines %>% filter(country %in% input$country,
                                                        province %in% input$province,
                                                        quality %in% input$quality,
                                                        price_range %in% input$price_range)
                  
            } else if(is.null(input$variety)){wines %>% filter(country %in% input$country,
                                                               province %in% input$province,
                                                               quality %in% input$quality,
                                                               region_1 %in% input$region,
                                                               price_range %in% input$price_range)
                  
            } else if(is.null(input$region)){wines %>% filter(country %in% input$country,
                                                              province %in% input$province,
                                                              quality %in% input$quality,
                                                              variety %in% input$variety,
                                                              price_range %in% input$price_range)
                     
            } else{
                  wines %>% 
                        filter(country %in% input$country,
                               province %in% input$province,
                               region_1 %in% input$region,
                               quality %in% input$quality,
                               variety %in% input$variety,
                               price_range %in% input$price_range)
            }
            
            
      )
      
      output$crossplot <- renderPlotly({
            
            p <- ggplot(wines_filtered(), aes(x = points, y = price, color = quality)) +
                  geom_jitter(aes(text =  title, 
                                  label = variety, 
                                  label2 = province,
                                  label3 = region_1), 
                              alpha = 0.5) + 
                  theme(legend.position="bottom") +
                  ggtitle("Price VS Points") + 
                  xlab("Rating (Points)") +
                  ylab("Price")
            
            ggplotly(p)
      })
      
      output$histplot_price <- renderPlotly({
            
            p1 <- ggplot(wines_filtered(), aes(x = price, color = quality)) + 
                  geom_freqpoly(bins = 16, alpha = 0.5, size = 1.5)  +
                  theme(legend.text = element_text(size=10)) +
                  ggtitle("Price Distribution") + xlab("Price")
            
            ggplotly(p1)
      })
      
      
      output$histplot_points <- renderPlotly({
            
            p2 <- ggplot(wines_filtered(), aes(points, color = quality)) +
                  geom_bar(aes(fill = quality), position="dodge", alpha = 0.5) + 
                  theme(legend.position="none") +
                  ggtitle("Rating Distribution")  + 
                  xlab("Rating (Points)")
            
            ggplotly(p2)
      })
      
}

# Run the application 
shinyApp(ui = ui, server = server)

