
# title: Developing Data Products - Peer Assessments
# author: Marcelo Gomes Marques
# date: June 23, 2014
# output: Shiny application

library(ggplot2)
library(datasets)
library(datasets)

data(mtcars)

mtcars$am <- mtcars$am == 0
names(mtcars)[9] <- "automatic"
mtcars$vs <- mtcars$vs == 1
mtcars$cyl <- factor(mtcars$cyl)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)

model <- lm( mpg ~ automatic + hp + wt +  qsec + cyl  , data=mtcars )
all_predict <- data.frame()


shinyServer(function(input, output) {
        
        predict_mpg <- reactive(function() {
                newdataset <- data.frame(input$in_automatic, input$in_hp, input$in_wt, input$in_qsec, input$in_cyl)
                names(newdataset)<-c("automatic", "hp", "wt","qsec" ,"cyl")
                predict_mpg <- cbind(newdataset, predict(model, newdata = newdataset))
        })
        
        output$model <- renderUI(function() {
                if(!input$help) 
                        p(strong("Linear Model ( mpg ~ Transmission + Gross horsepower + Weight +  1/4 mile time + Cylinders )"))
                
        })
        
        output$plot <- renderPlot(function() {
                predict <- predict_mpg()
                all_predict <- rbind(all_predict, predict)
                
                p <- ggplot(mtcars, aes_string(x=input$x, y="mpg")) + geom_point() 
                p <- p  + geom_point(x=predict[[input$x]],y=predict[, 6], pch=15, cex=5, col='darkgreen')
                
                if (input$color != 'None')
                        p <- p + aes_string(color=input$color)
                
                facets <- paste(input$facet_row, '~', input$facet_col)
                if (facets != '. ~ .')
                        p <- p + facet_grid(facets)
                
                if (input$smooth)
                        p <- p + geom_smooth()
                
                if(!input$help) print(p) else p("predict")
                
        }, height=600)
        
        output$paghelp1 <- renderUI(function() {
                if(input$help) 
                        h5("Welcome to Think in Miles/(US) gallon shiny application!!!")
                })
        output$paghelp2 <- renderUI(function() {
                if(input$help) 
                        p("Our application allows to cross the result of a prediction with the existing data, and we can dynamically change both the graph as the input data for the prediction and see the effect on-line.")
                        
                })
                
        output$paghelp3 <- renderUI(function() {
                if(input$help) 
                        p("Now a days is too important think better about best opptions to improve motors performance, even more if we concider energy efficience.",
                              "With this in mind, It's interesting find a way to ", 
                              strong(span("predict MPG (Miles/(US) gallon)", style = "color:blue")), 
                              " ussing a single linear regressing model between MPG and othes significants terms find in the mtcars dataset from datasets libriry." 
                              )
                
        })
        output$paghelp4 <- renderUI(function() {
                if(input$help) 
                        p("Let's go with this help and see how easy as use this application!",
                          "when you finish reading this help, ", strong("clear the check box "),
                           span("''Check here to see Help and clear to back!:''", style = "color:blue")) 
                
        })
        
        output$paghelp5 <- renderUI(function() {
                if(input$help) 
                        h5("Help:")
        })
        output$paghelp6 <- renderUI(function() {
                if(input$help) 
                        h6("Check Box ''Check here to see Help and clear to back!:''")
        })
        output$paghelp7 <- renderUI(function() {
                if(input$help) 
                        p("With this check box you can control if yuo see the Help, if it is checked, or if you see grafphic of this application in case it uncheked")
        })
        output$paghelp8 <- renderUI(function() {
                if(input$help) 
                        h6("Select ''X'':")
        })
        output$paghelp9 <- renderUI(function() {
                if(input$help) 
                        p("Choose the ", 
                          span("x-axis", style = "color:blue"), 
                          " of the graph from ''Cylinders'', ''Gross horsepower'', ''Weight (lb/1000)'', ''1/4 mile time'")
        })
        output$paghelp10 <- renderUI(function() {
                if(input$help) 
                        h6("Select ''Color Group:''")
        })
        output$paghelp11 <- renderUI(function() {
                if(input$help) 
                        p("Choose the variable you desire to group and color the graphic.") 
        })
        output$paghelp12 <- renderUI(function() {
                if(input$help) 
                        h6("Slider Controls ''Gross horsepower:'','Weight (lb/1000):'' and ''1/4 mile time:''")
        })
        output$paghelp13 <- renderUI(function() {
                if(input$help) 
                        p("These are controls of the input parameters of hp, wt and qseq to our model. ", 
                          "You just need slide these controls to see online how these changes entrances affects the mpg predic.",
                          "(see the ",
                          span("darkgreen sqare", style = "color:darkgreen"), 
                         " plot at the grapich)")
        })
        
        output$paghelp14 <- renderUI(function() {
                if(input$help) 
                        h6("Check Box ''Automatic Trnasmission:''")
        })
        output$paghelp15 <- renderUI(function() {
                if(input$help) 
                        p("Check here to see see online how this change entrance affects the mpg predic.",
                          " If it isn't marked you see the results of prediction considering a manual transmission. (see the ",
                          span("darkgreen sqare", style = "color:darkgreen"), 
                          " plot at the grapich)")
        })        

        output$paghelp16 <- renderUI(function() {
                if(input$help) 
                        h6("Radio Buttons ''Number of cylinders:''")
        })
        output$paghelp17 <- renderUI(function() {
                if(input$help) 
                        p("Check here and selec only one option of to consider as input of cylinders' number to see online how this change entrance affects the mpg predic.",
                          "(see the ",
                          span("darkgreen sqare", style = "color:darkgreen"), 
                          " plot at the grapich)")
        })        

        output$paghelp18 <- renderUI(function() {
                if(input$help) 
                        h6("Check Box ''Automatic Trnasmission:''")
        })
        output$paghelp19 <- renderUI(function() {
                if(input$help) 
                        p("It it's marked produces online a smoothed color density representation of the scatterplot, ",
                          "obtained through a kernel density estimate. densCols produces a vector containing ",
                          "colors which encode the local densities at each point in a scatterplot. Unmarked to remove the smooth!")
        })
        
        output$paghelp20 <- renderUI(function() {
                if(input$help) 
                        h6("Selects ''Facet Row:'' and ''Facet Column''")
        })
        output$paghelp21 <- renderUI(function() {
                if(input$help) 
                        p("Choose the ", 
                          span("facet row", style = "color:blue"), " and/or ",
                          span("facet column", style = "color:blue"), 
                          "Breakes your graphic in frames of rows end/or columns based on the values of the chosen variable .")
        })
})