# Interfaz
list.of.packages <-
  c("shiny", "shinydashboard", "plotly", "shinyjs", "V8")
new.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]
if (length(new.packages))
  install.packages(new.packages)
library(shiny)
library(shinydashboard)
library(plotly)
library(shinyjs)
library(V8)

jscode <-
  "shinyjs.collapse = function(boxid) {$('#' + boxid).closest('.box').find('[data-widget=collapse]').click();}"
collapseInput <- function(inputId, boxId) {
  tags$script(
    sprintf(
      "$('#%s').closest('.box').on('hidden.bs.collapse', function () {Shiny.onInputChange('%s', true);})",
      boxId,
      inputId
    ),
    sprintf(
      "$('#%s').closest('.box').on('shown.bs.collapse', function () {Shiny.onInputChange('%s', false);})",
      boxId,
      inputId
    )
  )
}
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Mi Dashboard",
                  tags$li(a(
                    actionButton("close", icon ("power-off"), style = 'padding:4px; font-size:70%'),
                  ),
                  class = "dropdown", )),
  dashboardSidebar(sidebarMenu(
    menuItem("Tabla de datos", tabName = "dashboard1", icon = icon("table")),
    menuItem(
      "Evolución temporal",
      tabName = "dashboard2",
      icon = icon("chart-line")
    )
  )),
  dashboardBody(
    useShinyjs(),
    extendShinyjs(text = jscode),
    tags$head(tags$style(
      HTML(
        "
                                #final_text {
                                  text-align: center;
                                }
                                div.box-header {
                                  text-align: center;
                                }
                                "
      )
    )),
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard1",
              fluidRow(
                column(
                  box(
                    title = "Tabla de datos",
                    selectInput(
                      "Año",
                      "Seleccione año",
                      choices = seq(1995, 2019),
                      selected = 2018,
                      width = 180
                    ),
                    tableOutput("DatosTabla"),
                    downloadButton("informe", "Generar informe"),
                    width = 12,
                    align = "center", 
                    height = 500
                  ),
                  box(
                    title = "Seleccione indicadores",
                    checkboxGroupInput(
                      "selcindicadores",
                      NULL,
                      choices = c(
                        "PIB",
                        "Crecimiento del PIB",
                        "PIB per cápita",
                        "Crecimiento del PIB per cápita",
                        "IPC",
                        "Desempleo",
                        "Tipo de interés (bonos del estado)",
                        "Deuda pública",
                        "Balanza de pagos"
                      ),
                      selected = c(
                        "PIB",
                        "Crecimiento del PIB",
                        "PIB per cápita",
                        "Crecimiento del PIB per cápita",
                        "IPC",
                        "Desempleo",
                        "Tipo de interés (bonos del estado)",
                        "Deuda pública",
                        "Balanza de pagos"
                      ),
                      inline = TRUE
                    ),
                    width = 12,
                    align = "center",
                  ),
                  box(
                    title = "Seleccione región de estudio",
                    checkboxGroupInput(
                      "Zona2",
                      NULL,
                      choices = c(
                        "España",
                        "Unión Europea",
                        "Grecia (más precaria)",
                        "Suiza (más estable)",
                        "Francia",
                        "Alemania"
                      ),
                      selected = c("España", "Unión Europea"),
                      inline = TRUE
                    ),
                    width = 12,
                    align = "center",
                  ),
                  width = 8
                ),
                column(
                  box(
                    title = "Indicadores",
                    id = "box21",
                    width = 12,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    box(
                      id = "box11",
                      title = "PIB",
                      htmlOutput("TextoPIB"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox11", boxId = "box11"),
                    box(
                      id = "box12",
                      title = "PIB per cápita",
                      htmlOutput("TextoPIBPC"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox12", boxId = "box12"),
                    box(
                      id = "box13",
                      title = "IPC",
                      htmlOutput("TextoIPC"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox13", boxId = "box13"),
                    box(
                      id = "box14",
                      title = "Desempleo",
                      htmlOutput("TextoDesempleo"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox14", boxId = "box14"),
                    box(
                      id = "box15",
                      title = "Interés bonos",
                      htmlOutput("TextoInt"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox15", boxId = "box15"),
                    box(
                      id = "box16",
                      title = "Deuda pública",
                      htmlOutput("TextoDP"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox16", boxId = "box16"),
                    box(
                      id = "box17",
                      title = "Balanza de pagos",
                      htmlOutput("TextoBP"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox17", boxId = "box17"),
                  ),
                  collapseInput(inputId = "iscollapsebox21", boxId = "box21"),
                  box(
                    title = "Fuentes",
                    id = "box22",
                    width = 12,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    box(
                      id = "box1",
                      title = "OECD",
                      htmlOutput("TextoOECD"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox1", boxId = "box1"),
                    box(
                      id = "box2",
                      title = "IMF",
                      htmlOutput("TextoIMF"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox2", boxId = "box2"),
                    box(
                      id = "box3",
                      title = "WB",
                      htmlOutput("TextoWB"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox3", boxId = "box3"),
                    box(
                      id = "box4",
                      title = "EUROSTAT",
                      htmlOutput("TextoEUROSTAT"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox4", boxId = "box4"),
                    box(
                      id = "box5",
                      title = "UNCTAD",
                      htmlOutput("TextoUNCTAD"),
                      width = 12,
                      collapsible = TRUE,
                      collapsed = TRUE
                    ),
                    collapseInput(inputId = "iscollapsebox5", boxId = "box5"),
                  ),
                  collapseInput(inputId = "iscollapsebox22", boxId = "box22"),
                  width = 4
                )
              )),
      
      # Second tab content
      tabItem(tabName = "dashboard2",
              fluidRow(
                box(
                  title = "Evolución temporal",
                  plotlyOutput("DatosPlot", height = 600),
                  width = 9,
                  downloadButton("informe2", "Descargar gráfica"),
                  align = "left"
                ),
                
                box(
                  title = "Seleccione indicador y área geográfica",
                  selectInput(
                    "Indicador",
                    "Seleccione indicador",
                    choices = c(
                      "PIB",
                      "Crecimiento del PIB",
                      "PIB per cápita",
                      "Crecimiento del PIB per cápita",
                      "IPC",
                      "Desempleo",
                      "Tipo de interés (bonos del estado)",
                      "Balanza de pagos",
                      "Deuda pública"
                    ),
                    width = 250
                  ),
                  checkboxGroupInput(
                    "Zona",
                    "Seleccione región",
                    choices = c(
                      "España",
                      "Unión Europea",
                      "Grecia (más precaria)",
                      "Suiza (más estable)",
                      "Francia",
                      "Alemania"
                    ),
                    selected = c("España", "Unión Europea")
                  ),
                  width = 3
                ),
                box(
                  title = textOutput("TituloBox"),
                  htmlOutput("TextoBox"),
                  width = 3
                )
              ))
    )
  )
  
)
