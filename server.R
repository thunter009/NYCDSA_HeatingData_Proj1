library(ggplot2)
library(ggthemes)
library(rvg)                                                                                                            
library(ggiraph)
require(global.R)

function(input,output){
  output$bar_311 <- renderPlot({
    # by_year <- count(df_311subset,`input$col_select`)[1:8,]
    # by_winters <- count(df_311subset, `Winters`)[1:8,]
    # by_borough <- count(df_311subset, Borough)[1:5,]
    
    g <- ggplot(data = df_311subset, aes_string(x = input$bar_col_sel, colour = 'FB500B'))
    g <- g+geom_bar_interactive()
    g <- g+ggtitle("NYC 311 Heating Complaints2010-2017")
    g <- g+xlab(as.character(input$bar_col_sel))
    g <- g+ylab("Total Complaints")
    ggiraph(code = {print(g)})
    
  output$bar_hs
  })
}
