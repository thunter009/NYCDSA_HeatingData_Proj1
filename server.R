library(ggplot2)
library(RColorBrewer)
require(global.R)

function(input,output){
  
  #311 outputs
  output$bar_311 <- renderPlot({
    g <- ggplot(data = df_311subset, aes_string(x = input$nyc_bar_col_sel))
    g <- g+geom_bar()
    g <- g+xlab(as.character(input$nyc_bar_col_sel))
    g <- g+ylab("Total Complaints")
    })
  
  #Heat Seek outputs
  output$line_hs <- renderPlot({
    g <- ggplot(data = df_hs, aes_string(x = df_hs$created_at, y = df_hs$temp))
    g <- g+geom_line(aes_string(group = input$cols_hs))
    g <- g+xlab("Time")
    g <- g+ylab("Temperature")
    g
    })
  
  
  output$map_hs <- renderPlot({
    qmplot(lon, lat, data = sensor_mapping, maptype = "toner-lite", color = I("red"))
  })

  outputOptions(output, 'bar_311', suspendWhenHidden = FALSE)
  outputOptions(output, 'line_hs', suspendWhenHidden = FALSE)
  
}
