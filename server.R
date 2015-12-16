library(UsingR)
library(ggplot2)
library(shiny)

# Function that converts degrees fahrenheit to celcius
f_to_c <- function(from)
{
  round((from - 32) * (5.0/9.0), digits = 2)
}

# Function that converts degrees celcius to degrees fahrenheit
c_to_f <- function(from)
{
  round((from * (9.0/5.0)) + 32, digits = 2)
}

shinyServer(
  function(input, output)
  {
    # Get the selected conversion type from radio buttons.
    output$type <- renderPrint({input$type})

    # Header dynamically display choice of conversion.
    output$header1 <- renderText({
      if (input$type == "C_to_F")
      {
        "You entered degrees celcius"
      }else
      {
        "You entered degrees fahrenheit"
      }
    })

    # Header dynamicall display choice of conversion.
    output$header2 <- renderText({
      if (input$type == "C_to_F")
      {
        "Converted to degrees fahrenheit"
      }else
      {
        "Coverted to degrees celcius"
      }
    })

    # Header dynamically display choice of conversion.
    output$inputHeader <- renderText({
      if (input$type == "C_to_F")
      {
        "Enter degrees celcius"
      }else
      {
        "Enter degrees fahrenheit"
      }
    })

    # Get value that the user wants to convert.
    output$inputValue <- renderText({input$from})

    # Only render the converted value once the user clicks the "Convert" button.
    output$toValue <- renderPrint({

        input$goButton

          isolate(
                  if (input$type == "C_to_F")
                  {
                    # calling celcius to fahrenheit conversion function
                    c_to_f(input$from)
                  }else
                  {
                    # calling fahrenheit to celcius conversion function.
                    f_to_c(input$from)
                  }
                )})

    # Render plot and user supplied conversion when user clicks the
    # "Convert" button.
    output$convertPlot <- renderPlot({

      # degrees celcius vector for plotting.
      celcius <- c(-45, 100)
      # degrees fahrenheit vector for plotting.
      fahrenheit <- c(-49, 212)
      # data frame for plotting.
      data <- data.frame(c = celcius, f = fahrenheit)

       input$goButton

       isolate(
       if (input$type == "C_to_F")
       {
         #coordinates for converted point.
          xx <<- input$from
          yy <<- c_to_f(input$from)

          print(ggplot(data , aes(c, f)) +
                  geom_line(color = "blue", size = 1) +
                  geom_point(aes(x = xx, y = yy), color = "red", size = 5) +
                  geom_hline(yintercept = yy, color = "red", size = 0.5) +
                  geom_vline(xintercept = xx, color = "red", size = 0.5) +
                  theme(axis.text.x = element_text(size = 10),
                        axis.text.y = element_text(size = 10),
                        plot.title = element_text(size = 20),
                        axis.title.x = element_text(size = 15),
                        axis.title.y = element_text(size = 15)) +
                  scale_x_continuous(breaks =
                                       c(-50,-40,-30,-20,-10,0,10,20,30,40,50,
                                         60,70,80,90,100)) +
                  scale_y_continuous(breaks = c(-50,-25,0,25,50,75,100,125,150,
                                                175,200)) +
                  labs(y = "Fahrenheit") +
                  labs(x = "Celcius") +
                  labs(title = "Conversion Chart"))
       }else
       {
         # coordinates for converted point
         xx <<- f_to_c(input$from)
         yy <<- input$from

         print(ggplot(data, aes(c, f)) +
                 geom_line(color = "blue", size = 1) +
                 geom_point(aes(x = xx, y = yy), color = "red", size = 5) +
                 geom_hline(yintercept = yy, color = "red", size = 0.5) +
                 geom_vline(xintercept = xx, color = "red", size = 0.5) +
                 theme(axis.text.x = element_text(size = 10),
                       axis.text.y = element_text(size = 10),
                       plot.title = element_text(size = 20),
                       axis.title.x = element_text(size = 15),
                       axis.title.y = element_text(size = 15)) +
                 scale_x_continuous(breaks =
                                      c(-50,-40,-30,-20,-10,0,10,20,30,40,50,60,
                                        70,80,90,100)) +
                 scale_y_continuous(breaks = c(-50,-25,0,25,50,75,100,125,150,
                                               175,200)) +
                 labs(y = "Fahrenheit") +
                 labs(x = "Celcius") +
                 labs(title = "Conversion Chart"))
       }
     )
   })
  }
)
