library(shiny)

source("~/Desktop/immoscape/immoprocess/process2.r")
source("~/Desktop/immoscape/immoprocess/get_longlat.r")
source("~/Desktop/immoscape/immoprocess/controll.r")

source("~/Desktop/immoscape/immoscaper/settings.r")


shinyUI(
  navbarPage('ImmoScape - nerdiger Immobilien Explorer',
             tabPanel("Setup",
                      fluidPage(
                        fluidRow(
                          column(4,
                                 selectInput('srcfile', paste0(dir,'...'), choices = list.files(dir)), # update!!
                                 radioButtons('data_qual',label = NULL,
                                              choices = c('neue Daten' = 'new', 'verarbeitete Daten' = 'update'), 
                                              selected = 'new'),
                                 actionButton('run', 'Los gehts!', icon = icon("ok", lib = "glyphicon"))
                          ), # column
                          column(4,               
                                 checkboxInput('original', 'Unverarbeitet einlesen'),
                                 checkboxInput('save', 'Ergebnis speichern?'),
                                 checkboxInput('getgeo', 'fehlende Geodaten holen?')
                          ), # column
                          column(4,
                                 checkboxInput('okdelete', 'wirklich Löschen'),
                                 actionButton('delete','Löschen', icon = icon('trash'))
                          ) # column
                        ), # fluidRow
                        hr(),
                        fluidRow(
                          column(2,
                                 checkboxGroupInput("table1_cols", "Auswahl:",  # update!!
                                                    names(data),  selected = table1_cols_selected)
                          ),
                          column(10, dataTableOutput("table1"))
                        )
                      ) # fluidPage
                      
             ), # tabPanel
             tabPanel( "Mietspiegel",
                       sidebarLayout(
                         sidebarPanel(
                           selectInput('spiegel_group', 'Gruppieren',    # update!!
                                       names(data),selected = "typ")
                         ),
                         mainPanel(
                           plotOutput('plot2'),
                           verbatimTextOutput("info")
                         )
                       )
             ), # tabPanel
             tabPanel("Plot",
                      sidebarLayout(sidebarPanel(
                        selectInput('xcol', 'X Variable', data_list, selected = "flaeche"),
                        selectInput('ycol', 'Y Variable', data_list, selected = "kalt")
                        # selectInput('color', 'Einfärben', names(data), selected = "zimmer"),
                        # sliderInput("kalt", "Kalt:",
                        #             min = kalt["min"], max = kalt["max"],
                        #             value = c(kalt["min"], kalt["max"])),
                        # sliderInput("flaeche", "Fläche:",
                        #             min = flaeche["min"], max = flaeche["max"],
                        #             value = c(flaeche["min"], flaeche["max"])),
                        # sliderInput("zimmer", "Zimmer:",
                        #             min = zimmer["min"], max = zimmer["max"],
                        #             value = c(zimmer["min"], zimmer["max"])),
                        # selectInput('typ', 'Typ auswählen',
                        #             state.name, multiple=TRUE, selectize=TRUE,
                        #             choices = unique(data$typ)),
                        # checkboxGroupInput('spider_name', 'Plattformen auswählen',
                        #                    choices = unique(t$spider_name),selected = unique(t$spider_name)),
                        # selectInput('criteria', 'Positiv-Kriterien TODO!!!!',
                        #             state.name, multiple=TRUE, selectize=TRUE,
                        #             choices = unique(gsub(' ','',unlist(strsplit(data$criteria, ","))))),
                        # selectInput('zip', 'PLZ',
                        #             state.name, multiple=TRUE, selectize=TRUE,
                        #             choices = zips)
                      ),
                      mainPanel(
                        # plotOutput('plot1', click = "plot_click", brush = "plot_brush"),
                        # verbatimTextOutput("info"),
                        # leafletOutput("mymap")
                      ))
             )
  ) # navbarPage
  
)
