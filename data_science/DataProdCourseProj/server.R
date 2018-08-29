
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ISLR)
library(caret)
library(ggplot2)

# Shiny server "entry" point
shinyServer(function(input, output) {
    
    # use reactivity to avoid unnecessary calculations
    predictReact <- reactive({
        makePrediction(input$predictedWage, 
                       input$predictors)
    })
    
    # render the prediction plot
    output$distPlot <- renderPlot({
        if (length(input$predictors) > 0) {
            res_plot <- predictReact()
            res_plot <- res_plot + 
                labs(title = input$plotTitle) +
                xlab(input$xAxisLab) +
                ylab(input$yAxisLab)
            print(res_plot)
        }
        else { # draw empty plot with text in it
            par(mar = c(0,0,0,0))
            plot(c(0, 1), c(0, 1), ann = FALSE, 
                 bty = 'n', type = 'n', 
                 xaxt = 'n', yaxt = 'n')
            text(x = 0.5, y = 0.5, 
                 paste("No predictors selected!\n"), 
                 cex = 1.6, col = "black")
        }
    })
    
})

# Loads wage data, train a model and make prediction
makePrediction <- function(predicted, predictors) {
    data(Wage)
    
    # subset the Wage data - we need only specified predicted variable
    # and predictors
    wageSubsetVars <- c(predicted, predictors)
    Wage <- subset(Wage, select = wageSubsetVars)
    
    # prepare train and test data sets
    set.seed(12345)
    trainIn <- createDataPartition(y = Wage[, predicted], p = 0.7, list = FALSE)
    training <- Wage[trainIn,]
    testing <- Wage[-trainIn,]
    
    # train the model
    fmla <- as.formula(paste(predicted, "~", paste(predictors, collapse = "+")))
    mod <- train(fmla, data = training,
                 method = "lm")
    
    # make the prediction
    pred <- predict(mod, testing)
    p <- qplot(testing[, predicted], pred,
                 data = testing)
    return (p)
}
