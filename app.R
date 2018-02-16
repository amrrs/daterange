# Using https://longbill.github.io/jquery-date-range-picker/
library(shiny)
library(shinydashboard)

header <- dashboardHeader(title="Date picker")
sidebar <- dashboardSidebar()
body <- dashboardBody(
  
  tags$head(tags$link(rel = 'stylesheet', type = 'text/css', href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css')),
  tags$head(tags$link(rel = 'stylesheet', type = 'text/css', href = 'dist/daterangepicker.min.css')),
  tags$head(tags$script(src = 'https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js', type = 'text/javascript')),
  tags$head(tags$script(src = 'https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.16.0/moment.min.js', type = 'text/javascript')),
  tags$head(tags$script(src = 'src/jquery.daterangepicker.js')),
  tags$head(tags$script(src = 'demo.js')),
  tags$head(tags$script(src = 'src/jquery.daterangepicker.js')),
  
  
  tags$head(tags$style(HTML("
                            
                            #wrapper
                            {
                            width:600px;
                            margin:0 auto;
                            color:#333;
                            font-family:Tahoma,Verdana,sans-serif;
                            line-height:1.5;
                            font-size:14px;
                            }
                            .demo { margin:30px 0;}
                            .date-picker-wrapper .month-wrapper table .day.lalala { background-color:orange; }
                            .options { display:none; border-left:6px solid #8ae; padding:10px; font-size:12px; line-height:1.4; background-color:#eee; border-radius:4px;}
                            
                            "))),
  
  # Application title
  
  fluidPage(
    
    fluidRow(column(8,
                    uiOutput('date_ui')),
             column(4,
                    h3('Table of inputs'),
                    tableOutput('show_inputs')))
  ))


ui <- dashboardPage(header, sidebar, body)

# Define server logic required to draw a histogram
server <- function(input, output,session) {
  
  date_range <- reactiveVal('Pick some dates')
  observeEvent(input$daterange12,{
    date_input <- input$daterange12
    message('Dates changed. They are: ')
    print(input$daterange12)
    message('Joe:')
    print(input$joe)
    date_range(date_input)
    output$show_inputs <- renderTable({
    AllInputs()
  })
  }, ignoreNULL = FALSE, ignoreInit = FALSE)
  
  AllInputs <- reactive({
    x <- reactiveValuesToList(input)
    data.frame(
      names = names(x),
      values = unlist(x, use.names = FALSE)
    )
  })
  
  
  
  output$date_ui <- renderUI({
    
    dr <- paste0(Sys.Date(), ' to ', Sys.Date() + 14)
    fluidPage(
      tags$div(HTML("
                    
                    <div id='daterange12container' style=\"width:456px;\">
                    <input id=\"daterange12\" name=\"joe\" type=\"text\" class=\"form-control\" value=\"",dr, "\"/>
                    
                    </div>
                    <script type=\"text/javascript\">
                    $(function() {
                    $('#daterange12').dateRangePicker(
                    {
                    inline:true,
                    container: '#daterange12container', 
                    alwaysOpen:true
                    }).bind('datepicker-change', function(evt, obj) {

                    var time = document.getElementById(\"daterange12container\").value;
    Shiny.onInputChange(\"daterange12\", time);
        val = document.getElementById(\"daterange12container\").value;
                    Shiny.onInputChange(\"daterange12\",val);
	alert('date1: ' + obj.date1 + ' / date2: ' + obj.date2);
});
                    
                    // JOE:
                    
                    $('#daterange12').on('bind', function() {
                    var time = document.getElementById(\"daterange12container\").value;
    Shiny.onInputChange(\"daterange12\", time);
        val = document.getElementById(\"daterange12container\").value;
                    Shiny.onInputChange(\"daterange12\",val);
});
          });
          </script>

                                  "))
                    )
                    })
  
  
                    }

# Run the application 
shinyApp(ui = ui, server = server)

