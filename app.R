#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        helpText('The below needs to be replaced with a date range input that highlights all the days between the first and second day'),
         dateRangeInput("date_range",
                     "Date range input")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         textOutput("date_range_values")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$date_range_values <- renderText({
      as.character(input$date_range)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

