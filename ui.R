library(shiny)
require(global.R)
options(shiny.error = browser)

fluidPage(
  
  headerPanel("Got Heat?"),
  sidebarLayout(
    helpText("Built on NYC apartment heating 311 complaint data and Heat Seek, NYC temperature sensor data"
            ),
    sidebarPanel(
      conditionalPanel(
        condition = "input.conditionedPanels == 'Overview'",
          selectizeInput(
            inputId = "nyc_bar_col_sel",
            label = "Select Categorical Variables",
            choices = cols_311,
            selected = cols_311[1]
          ),
        ),
      conditionalPanel(
        condition = "input.conditionedPanels == 'Detailed View'",
        selectizeInput(
          inputId = 'hs_detail_inp',
          label = "Select Grouping Variable",
          choices = cols_hs,
          selected = cols_hs[1]
        )
      ),
    mainPanel(
      tabsetPanel(
        tabPanel("Overview", 
                 plotOutput("bar_311"),
                 plotOutput("bar_hs"),
                 plotOutput("line_311"),
                 plotOutput("line_hs")),
        tabPanel("Detail View", 
                 plotOutput("map_hs")),
        tabPanel("Combined View")
      )
    )
  )
))



