#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Airline Passenger Interactive Forecast"),
  sidebarLayout(
      sidebarPanel(
          sliderInput("date","begin forecast date:", min = 1950, max = 1964, value = 1),
          sliderInput("window","forecast window in months:", min = 24, max = 96, value = 1),
          selectInput("method", "Choose a method:",
                  choices = c("Arima", "Exponential")) 
         ),
      mainPanel(
        plotlyOutput("plot")
      )
    )
  )
)
