library(shiny)
library(tidyverse)
library(babynames)

ui <- fluidPage(
  sliderInput(inputId = "yearRange",
              label = "Select Range",
              min = 1880, 
              max = 2019, 
              value = c(1880,2019),
              sep = ""),
  textInput(inputId = "name",
            label = "Enter a Name:",
            value = "", 
            placeholder = "Type Here"),
  selectInput(inputId = "sex",
              label = "Choose the Sex:",
              choices = c(Female = "F", Male = "M")),
  submitButton(text = "Create my plot!"),
  plotOutput(outputId = "plot")
)

server <- function(input, output) {
  output$plot <- renderPlot({
    babynames %>%
      filter(name == input$name,
             sex == input$sex) %>%
      ggplot() +
      geom_line(aes(x = year, y = n)) +
      scale_x_continuous(limits = input$yearRange) +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)