library(shiny)
library(shinyBS)

shinyUI(
  pageWithSidebar(
    #Application title
    headerPanel("Temperature Conversion"),

    sidebarPanel(
      radioButtons("type","Conversion Type",
                         c("Celcius to Fahrenheit" = "C_to_F",
                           "Fahrenheit to Celcius" = "F_to_C")
                         ),

      numericInput("from", textOutput("inputHeader"), 0, min = -49, max = 200,
                   step = 1, width = "50%"),

      actionButton("goButton", "Convert"),

      bsTooltip(id = "from", title = "Enter the value that you want to convert here",
                placement = "right", trigger = "hover"),

      bsTooltip(id = "goButton", title = "Click button to convert",
                placement = "right", trigger = "hover"),

      bsTooltip(id = "type", title = "Select conversion type you want",
                placement = "right", trigger = "hover"),

      bsTooltip(id = "inputValue", title = "Value to convert",
                placement = "left", trigger = "hover"),

      bsTooltip(id = "toValue", title = "Converted value", placement = "left",
                trigger = "hover")
    ),
    mainPanel(
      h3("Results of conversion"),
      h4(textOutput("header1")),
      verbatimTextOutput("inputValue"),
      h4(textOutput("header2")),
      verbatimTextOutput("toValue"),
      h4("Conversion Graph"),
      plotOutput("convertPlot"),
      h5("The red dot is the requested converted point"),
      h5("The blue line represents the celcius - fahrenheit relationship")
    )
  )
)
