library(shiny)

shinyUI(pageWithSidebar(
headerPanel("Data reproducibility"),
sidebarPanel(
  fileInput('file1', 'Choose CSV File',
            accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
  tags$hr(),
  checkboxInput('header', 'Header', TRUE),
  radioButtons('sep', 'Separator',
               c(Comma=',',
                 Semicolon=';',
                 Tab='\t'),
               'Comma'),
  radioButtons('quote', 'Quote',
               c(None='',
                 'Double Quote'='"',
                 'Single Quote'="'"),
               'Double Quote')
 
    
    #numericInput('rows', "Number of observations to view:", 10)

  
  
),

mainPanel(
  #tableOutput('contents'),
  tableOutput("view"),
  plotOutput("newHist1"),
  plotOutput("newHist"),
  verbatimTextOutput("oid1"),
  verbatimTextOutput("oid2"),
  #verbatimTextOutput("oid3"),
  tabPanel("Heatmap", plotOutput("myPlot", height="600px")),
  tabPanel("hclust",plotOutput("plot2", height="600px"))
  #plotOutput("plot2", height="600px")
  
)

))


