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
      uiOutput('date_ui')
      ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("date_range_values")
    )
      )
      )

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  date_range <- reactiveVal(c(Sys.Date() - 7,
                              Sys.Date() + 7))
  
  observeEvent(input$daterange, {
    message('input date range is ', input$daterange)
    idr <- input$daterange
    idr <- unlist(strsplit(idr, ' - '))
    idr <- as.Date(idr, format = '%m/%d/%Y')
    date_range(idr)
  })
  
  output$date_range_values <- renderText({
    as.character(date_range())
  })
  
  output$date_ui <- renderUI({
    dr <- date_range()
    dr <- as.Date(dr)
    print(dr)
    dr <- format(dr, '%m/%d/%Y')
    tags$div(
      HTML(
        paste0(
          " 
          <input type=\"text\" id = \"joe\" name=\"daterange\" value=\"", dr[1], " - ", dr[2], "\" />
          
          <script type=\"text/javascript\">
          $(function() {
          $('input[name=\"daterange\"]').daterangepicker();
// the below two lines were written by joe, trying to get the input list
// to get updated, but it's not working
          document.getElementById(\"joe\").onchange = function() {
        var time = document.getElementById(\"joe\").value;
        Shiny.onInputChange(\"daterange\", time);
    };
          });
          </script>"
        )
        )
    )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

