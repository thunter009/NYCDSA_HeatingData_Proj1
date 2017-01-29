library(shiny)
require(global.R)
options(shiny.error = browser)

fluidPage(
  titlePanel("NYC Heating Data"),
  sidebarLayout(
    sidebarPanel(
      ?img(src="https://static1.squarespace.com/static/572a6eb527d4bdbe975f7a5f/t/572ce58a0442625c7b204555/1484163501593/?format=1500w")),
      selectizeInput(
        inputId = "col_select",
        label = "Select Category",
        choices = cols_311,
        selected = cols_311[1]
      )
    ),
    mainPanel(
      plotOutput("bar_311")
      plotOutput("heatmap")
    )
  )
