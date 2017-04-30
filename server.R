#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(markdown)
library(plotly)
library(forecast)
library(knitr)
library(shiny)
shinyServer(function(input, output) {
  output$plot<- renderPlotly({
    if (input$method=="Arima"){
    fit<-Arima(window(AirPassengers,end=input$date+11/12),order=c(0,1,1),
               seasonal=list(order=c(0,1,1),period=12),lambda=0)
    } else if (input$method=="Exponential"){
      fit <- ets(window(AirPassengers,end=input$date+11/12))
    }
    fore<-forecast(fit,input$window)
    zz<-accuracy(fore,(window(AirPassengers,start=input$date)))
    mean_error<-round(100*zz[2,3])/100
    error<-paste("prediction MAE: ",as.character(mean_error))
    p <- plot_ly() %>%
      add_lines(x = time(AirPassengers), y = AirPassengers,
                color = I("black"), name = "observed") %>%
      add_ribbons(x = time(fore$mean), ymin = fore$lower[, 2], ymax = fore$upper[, 2],
                  color = I("gray95"), name = "95% confidence") %>%
      add_ribbons(x = time(fore$mean), ymin = fore$lower[, 1], ymax = fore$upper[, 1],
                  color = I("gray80"), name = "80% confidence") %>%
      add_lines(x = time(fore$mean), y = fore$mean, color = I("blue"), name = "prediction")%>% 
      add_text(x=1955,y=600,text=as.character(error),name = "MAE")
  })
})