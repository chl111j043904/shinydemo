library(shiny)
library(zoo)
library(lattice)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title.
  titlePanel("Stress Testing"),
  
  selectInput(inputId="scen", 
              label="CCAR 2014 Scenario", 
              choices=c("Baseline","Adverse","Severely Adverse"), selected = "Baseline"),
    
      actionButton("run","Load Scenario"),

    
    # Show a summary of the dataset and an HTML table with the
    # requested number of observations. Note the use of the h4
    # function to provide an additional header above each output
    # section.

    h4("Summary"),
    plotOutput("ccarplot1",width=800,height=600),
  plotOutput("ccarplot2",width=800,height=600)
    #verbatimTextOutput("summary"),
      
    #h4("Observations"),
    #tableOutput("view")

  )    )
