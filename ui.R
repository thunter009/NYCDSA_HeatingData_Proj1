library(shiny)
require(global.R)
options(shiny.error = browser)

fluidPage(
  
  titlePanel("Got Heat?"),
  fluidRow(
    column(width = 3,
         helpText("Built on NYC apartment heating 311 complaint data and Heat Seek, NYC temperature sensor data"),
         selectizeInput(
           inputId = "nyc_bar_col_sel",
           label = "Select 311 Categorical Variables",
           choices = cols_311,
           selected = cols_311[1]
         ),
         selectizeInput(
           inputId = 'hs_cat_inp',
           label = "Select Heat Seek Grouping Variable",
           choices = cols_hs,
           selected = cols_hs[1]
         )),
    column(width = 8,
           tabsetPanel(
             tabPanel("Intro Video",
                      HTML("<iframe width='854' height='480' src='https://www.youtube.com/embed/15hh8EL13FM' frameborder='0' allowfullscreen></iframe>")),
             tabPanel("311 Data", 
                      plotOutput("bar_311")),
             tabPanel("Heat Seek Data",
                      plotOutput("line_hs")),
             tabPanel("Sensor Map", 
                      plotOutput("map_hs", width = "100%")),
             tabPanel("Sensor Data",
                      renderDataTable(df_hs))
           )
           )
           
        )
  )



