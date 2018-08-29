
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel(h2("Wage Prediction")),

    # Sidebar with input contorls
    sidebarLayout(
        sidebarPanel(
            h5("This application predicts the wage for workers in 
               Mid-Atlantic region. The wage data from the ISLR 
               package are used for the training and result prediction."),
            h5("Here you can adjust some training parameters. 
               Linear regression is used for the prediction."),
            br(),
            selectInput("predictedWage", 
                        strong("Choose wage type for prediction"),
                        choices = c("Wage" = "wage", "Log(Wage)" = "logwage")),
            checkboxGroupInput("predictors", 
                               strong("Select predictors"),
                               choices = c("Year" = "year", "Age" = "age",
                                           "Marital Status" = "maritl", "Race" = "race",
                                           "Education" = "education", "Job Class" = "jobclass",
                                           "Health" = "health", "Health Insurance" = "health_ins")),
            br(),
            h5("Here you can adjust plot and axis title. 
               Upon title change no re-calculations are made."),
            textInput("plotTitle", strong("Plot Title"), "Wage Prediction"),
            textInput("xAxisLab", strong("Label of X Axis"), "Wage (original)"),
            textInput("yAxisLab", strong("Label of Y Axis"), "Wage (predicted)")
    ),

    # Show a plot of the generated distribution
    mainPanel(
        h4("Prediction plot. X axis - original wage, Y axis - predicted wage"),
        plotOutput("distPlot")
    )
  )
))
