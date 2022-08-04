# Covid-19 Shiny App Dashboard

# Load libraries
library(shiny)
library(tidyverse)
library(lubridate)
library(plotly)
library(flexdashboard)

# Load the data
all_covid_data <- function() {
  confirmed_cases <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv'
  deaths <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv'
  recovered <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv'
}





# UI for the application
ui <- fluidPage(
    titlePanel("Covid-19 Dashboard"),
    fluidRow(
      column(
        width=4, 
        selectizeInput(
          "country", label=h4("Country"), choices=NULL, width="100%")
      ),
      column(
        width=4, 
        selectizeInput(
          "state", label=h4("State"), choices=NULL, width="100%")
      ),
      column(
        width=4, 
        checkboxGroupInput(
          "metrics", label=h4("Selected Metrics"), 
          choices=c("Confirmed Cases", "Deaths", "Recovered"), 
          selected=c("Confirmed Cases", "Deaths", "Recovered"), 
          width="100%")
      )
    ), 


)

# Define server logic required to draw a histogram
server <- function(input, output) {


}

# Run the application 
shinyApp(ui = ui, server = server)
