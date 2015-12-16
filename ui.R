library(shiny)
library(shinyBS)

shinyUI(
  pageWithSidebar(
    # application title
    headerPanel("Temperature Conversion"),

    sidebarPanel(

      # control where user selects the type of conversion.
      radioButtons("type","Conversion Type",
                         c("Celcius to Fahrenheit" = "C_to_F",
                           "Fahrenheit to Celcius" = "F_to_C")
                         ),
      # control where user inputs the value to be converted/
      numericInput("from", textOutput("inputHeader"), 0, min = -49, max = 200,
                   step = 1, width = "50%"),

      # button that inititiates the selected conversion.
      actionButton("goButton", "Convert"),

      # bunch of tooltips explaining funcionality of different parts of the UI.
      bsTooltip(id = "from", title = "Select the value that you want to convert here",
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
      # dynamic header - change depending on what conversion is performed.
      h4(textOutput("header1")),
      # show value that user entered.
      verbatimTextOutput("inputValue"),
      # dynamic header - change depending on what conversion is performed.
      h4(textOutput("header2")),
      # show converted value.
      verbatimTextOutput("toValue"),
      # show plot with newly converted value.
      plotOutput("convertPlot"),
      h5("The red dot is the newly converted point"),
      h5("The blue line represents the Celcius - Fahrenheit relationship")
    )
  )
)
