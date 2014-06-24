
# title: Developing Data Products - Peer Assessments
# author: Marcelo Gomes Marques
# date: June 23, 2014
# output: Shiny application

library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar(
        
        headerPanel("Think in Miles/(US) gallon:",
                    windowTitle = "Linear Model Prediction"),
        
        sidebarPanel(
                                
                checkboxInput('help', 'Check here to see Help and clear to back!', TRUE),

                selectInput('x', 'X', c("Cylinders" = "cyl",
                                        "Gross horsepower" = "hp",
                                        "Weight (lb/1000)" = "wt",
                                        "1/4 mile time" = "qsec"), "hp"),
                
                
                selectInput('color', 'Color Group:',  c("None" = "None",
                                                        "Cylinders" = "cyl",
                                                        "Transmission" = "automatic",
                                                        "Gross horsepower" = "hp",
                                                        "Weight (lb/1000)" = "wt",
                                                        "1/4 mile time" = "qsec",
                                                        "Gears" = "gear",
                                                        "Displacement (cu.in.)" = "disp",
                                                        "Rear axle ratio" = "drat",
                                                        "V/S" = "vs",
                                                        "Number of carburetors" = "carb"
                                                        )),
                
                
                sliderInput('in_hp', 'Gross horsepower:', min=40, max=345,
                            value=115, step=5),
                sliderInput('in_wt', 'Weight (lb/1000):', min=0.4, max=6,
                             value=2.25, step=0.05),
                sliderInput('in_qsec', '1/4 mile time:', min=10, max=25,
                            value=22, step=0.1),
                checkboxInput('in_automatic', 'Automatic Transmission', FALSE),
                radioButtons("in_cyl", "Number of cylinders:",
                             c("4" = 4,
                               "6" = 6,
                               "8" = 8)),
                checkboxInput('smooth', 'Smooth', TRUE),
                
                selectInput('facet_row', 'Facet Row', c("None" = ".",
                                                        "Gears" = "gear",
                                                        "V/S" = "vs",
                                                        "Number of carburetors" = "carb")),
                selectInput('facet_col', 'Facet Column', c("None" = ".",
                                                           "Gears" = "gear",
                                                           "V/S" = "vs",
                                                           "Number of carburetors" = "carb"))
        ),
        
        mainPanel(
                        uiOutput('model'),
                        uiOutput('paghelp1'), 
                        uiOutput('paghelp2'), 
                        uiOutput('paghelp3'), 
                        uiOutput('paghelp4'), 
                        uiOutput('paghelp5'),
                        uiOutput('paghelp6'), 
                        uiOutput('paghelp7'), 
                        uiOutput('paghelp8'), 
                        uiOutput('paghelp9'), 
                        uiOutput('paghelp10'), 
                        uiOutput('paghelp11'), 
                        uiOutput('paghelp12'), 
                        uiOutput('paghelp13'), 
                        uiOutput('paghelp14'), 
                        uiOutput('paghelp15'), 
                        uiOutput('paghelp16'), 
                        uiOutput('paghelp17'), 
                        uiOutput('paghelp18'), 
                        uiOutput('paghelp19'), 
                        uiOutput('paghelp20'), 
                        uiOutput('paghelp21'), 
                        plotOutput('plot')
                        
        )
))