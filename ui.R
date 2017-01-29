library(shiny)
require(global.R)
options(shiny.error = browser)

fluidPage(
  headerPanel("NYC Heating Data"),
  fluidRow(column(width = 12,
    img(src="https://static1.squarespace.com/static/572a6eb527d4bdbe975f7a5f/t/572ce58a0442625c7b204555/1484163501593/?format=1500w", height = 75)
  )),
  sidebarLayout(
    sidebarPanel(
      selectizeInput(
        inputId = "bar_col_sel",
        label = "Select Category",
        choices = cols_311,
        selected = cols_311[1]
      )
    ),
    mainPanel(
      plotOutput("bar_311")
    )
  )
)

# library(shiny)
# library(shinythemes)
# 
# # The following lines are moved to global.R
# # num_cols <- c("Displacement (cu.in.)" = "disp",
# #               "Gross horsepower" = "hp", 
# #               "Rear axle ratio" = "drat",
# #               "Weight (1000 lbs)" = "wt",
# #               "1/4 mile time" = "qsec")
# # cat_cols <- c("Number of cylinders" = "cyl",
# #               "V/S" = "vs",
# #               "Transmission (0 = automatic, 1 = manual)" = "am",
# #               "Number of forward gears" = "gear")
# 
# fluidPage(
#   
#   titlePanel("Shiny Homework"),
#   
#   fluidRow(column(width = 4,
#                   br(),br(),
#                   selectizeInput(inputId = "num", 
#                                  label = "Select Continuous Column", 
#                                  choices = num_cols),
#                   selectizeInput(inputId = "cat", 
#                                  label = "Select Discrete Column", 
#                                  choices = cat_cols),
#                   sliderInput(inputId = "size",
#                               label = "Point size",
#                               min = 1, max = 10, value = 5)),
#            column(width = 8,
#                   plotOutput(outputId = "plot")))
#   
# )
