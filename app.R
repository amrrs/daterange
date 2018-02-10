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
  
  tags$div(
    
    HTML(
      '<!-- Include Required Prerequisites -->
      <script type="text/javascript" src="//cdn.jsdelivr.net/jquery/1/jquery.min.js"></script>
      <script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
      <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap/3/css/bootstrap.css" />
      
      <!-- Include Date Range Picker -->
      <script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
      <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />'
    )
    ),
  
  # Application title
  titlePanel("Date range"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      tags$div(
        HTML(
          " 
          <input type=\"text\" name=\"daterange\" value=\"01/05/2015 - 01/31/2015\" />
          
          <script type=\"text/javascript\">
          $(function() {
          $('input[name=\"daterange\"]').daterangepicker();
// the below two lines were written by joe, trying to get the input list
// to get updated, but it's not working
          var vv = ('input[name=\"daterange\"]').daterangepicker();
          Shiny.onInputChange('daterange', vv);
          });
          </script>")
        )
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
    # This is working on the start of the app, but doesn't update
    as.character(input$daterange)
  })

}

# Run the application 
shinyApp(ui = ui, server = server)

