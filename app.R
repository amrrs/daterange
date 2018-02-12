library(shiny)
library(shinydashboard)

header <- dashboardHeader(title="Date picker")
sidebar <- dashboardSidebar()
body <- dashboardBody(
  
  # tags$head(tags$script(src = 'jquery.min.js')),
  tags$head(tags$script(src = 'moment.min.js')),
  # tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")),
  tags$head(tags$script(src = 'daterangepicker.js')),
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "daterangepicker.css")),
  
  # Application title
  titlePanel("Date range"),
  
  fluidPage(
    fluidRow(column(4,uiOutput('date_ui')),
             column(8,
                    textOutput("date_range_values")))
  ))


ui <- dashboardPage(header, sidebar, body)

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
          
          <div class=\"form-group shiny-input-container\" style=\"width: 60%; \">
<label for=\"date_range\">Pick a date range for analysis</label>
          <input type=\"text\" class=\"form-control\" id = \"joe\" name=\"daterange\" value=\"", dr[1], " - ", dr[2], "\" />
       </div>   
          <script type=\"text/javascript\">
          $(function() {
          $('input[name=\"daterange\"]').daterangepicker({

          \"linkedCalendars\": false,
          \"alwaysShowCalendars\": true,
          \"autoApply\": true,
          \"opens\": \"center\",

          });
// JOE:
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

