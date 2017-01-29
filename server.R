library(ggplot2)
require(global.R)

function(input,output){
  by_year <- count(df_311subset,Year)
  by_winters <- count(df_311subset, Winters)
  by_borough <- count(df_311subset, Borough)

  output$bar_311 <- renderPlot({
    g <- ggplot(data = df_311subset)
    g <- g+geom_bar(aes_string(x = input$col_select))
    g <- g+ggtitle("NYC 311 Heating Complaints, 2010-2017")
    g <- g+xlab(as.character(input$col_select))
    g <- g+ylab("Total Complaints")
  })
  
  output$bar_311 <- renderPlot({
    p1 = ggplot_calendar_heatmap(df_311subset
  })
}
