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





# UI object
ui <- fluidPage(
  skin = 'midnight',
    titlePanel("Covid-19 Dashboard"),
    fluidRow(
      column(
        width=3, 
        selectizeInput(
          "country", label=h3("Country/Region"), choices=NULL, width="100%")
      ),
      column(
        width=3, 
        selectizeInput(
          "state", label=h3("State/Province"), choices=NULL, width="100%")
      ),
      column(
        width=3, 
        checkboxGroupInput(
          "metrics", label=h3("Metrics"), 
          choices=c("Confirmed Cases", "Deaths", "Recovered"), 
          selected=c("Confirmed Cases", "Deaths", "Recovered"), 
          width="100%")
      )
      ),
      dashboardPage(
        skin='blue',
        dashboardHeader(title = "Covid Dashboard"),
        dashboardSidebar(
          sidebarMenu(
            h4('Selected Country'),
            menuItem("Main Page", tabName = "dashboard", icon = icon("dashboard")),
            menuItem("Forecast",  tabName = "forecast",  icon = icon("bar-chart-o"))
            
          )
        ),
      dashboardBody(
        div(style='padding:5px;',
            tabItems(
              
              tabItem("dashboard",
                      h1('The Dashboard'),
                      column(6,
                             valueBoxOutput("infected_box",  width = 12),
                             valueBoxOutput("sick_box",      width = 12),
                             shinydashboard::box(
                               width = 12,
                               title = "Sick as a percentage of Confirmed",
                               gaugeOutput("sick_gauge",  width = "200px", height = "200px")
                             )
                      ),
                      column(6,
                             valueBoxOutput("recovered_box", width = 12),
                             valueBoxOutput("death_box",     width = 12),
                             shinydashboard::box(
                               width = 12,
                               title = "Deaths as a percentage of Confirmed",
                               gaugeOutput("death_gauge", width = "200px", height = "200px")
                             )
                      )
              ),
              
              tabItem("forecast",
                      h1('The Forecast'),
                      HTML('<h1>TBA</h1>') # we will add this later
              ) 
              
            ),
              fluidRow(
                valueBox(10 * 2, "New Infections", icon = icon("credit-card")),
                valueBoxOutput("progressBox"),
                valueBoxOutput("approvalBox")
              ),
              
        ) 
      ) 
      ) 
        ) 
      

# SERVER ()
server <- function(input, output) {
  output$progressBox <- renderValueBox({
    valueBox(
      paste0(25 + input$count, "%"), "Progress", icon = icon("list"),
      color = "purple"
    )
  })
  
  output$approvalBox <- renderValueBox({
    valueBox(
      "80%", "Approval", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow"
    )
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
