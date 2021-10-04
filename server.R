# Servidor
list.of.packages <-
  c("shiny", "rdbnomics", "tidyverse", "webshot", "V8")
new.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]
if (length(new.packages))
  install.packages(new.packages)
library(shiny)
library(rdbnomics)
library(tidyverse)
library(plotly)
library(webshot)
# Obtención de datos
PIBES <-
  subset(
    rdb("OECD/MEI/ESP.NAEXCP01.STSA.A"),
    select = c("original_period", "period", "value")
  )
colnames(PIBES) <- c("Año", "Fecha", "ES")
PIBEU <-
  transform(subset(
    rdb("OECD/MEI/EU28.NAEXCP01.STSA.A"),
    select = c("original_period", "period", "value")
  ), new = value / 28) # Total EU
PIBEU$value <- NULL
colnames(PIBEU) <- c("Año", "Fecha", "EU")
PIBGR <-
  subset(
    rdb("OECD/MEI/GRC.NAEXCP01.STSA.A"),
    select = c("original_period", "period", "value")
  )
colnames(PIBGR) <- c("Año", "Fecha", "GR")
PIBSZ <-
  subset(
    rdb("OECD/MEI/CHE.NAEXCP01.STSA.A"),
    select = c("original_period", "period", "value")
  )
colnames(PIBSZ) <- c("Año", "Fecha", "SZ")
PIBFR <-
  subset(
    rdb("OECD/MEI/FRA.NAEXCP01.STSA.A"),
    select = c("original_period", "period", "value")
  )
colnames(PIBFR) <- c("Año", "Fecha", "FR")
PIBAL <-
  subset(
    rdb("OECD/MEI/DEU.NAEXCP01.STSA.A"),
    select = c("original_period", "period", "value")
  )
colnames(PIBAL) <- c("Año", "Fecha", "AL")
PIB <-
  Reduce(function(x, y)
    merge(x, y, by = c("Año", "Fecha"), all = TRUE),
    list(PIBES, PIBEU, PIBGR, PIBSZ, PIBFR, PIBAL))

CrecimientoPIBES <-
  subset(
    rdb("OECD/MEI/ESP.NAEXKP01.GPSA.A"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBES) <- c("Año", "Fecha", "ES")
CrecimientoPIBEU <-
  subset(
    rdb("OECD/MEI/EU28.NAEXKP01.GPSA.A"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBEU) <- c("Año", "Fecha", "EU")
CrecimientoPIBGR <-
  subset(
    rdb("OECD/MEI/GRC.NAEXKP01.GPSA.A"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBGR) <- c("Año", "Fecha", "GR")
CrecimientoPIBSZ <-
  subset(
    rdb("OECD/MEI/CHE.NAEXKP01.GPSA.A"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBSZ) <- c("Año", "Fecha", "SZ")
CrecimientoPIBFR <-
  subset(
    rdb("OECD/MEI/FRA.NAEXKP01.GPSA.A"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBFR) <- c("Año", "Fecha", "FR")
CrecimientoPIBAL <-
  subset(
    rdb("OECD/MEI/DEU.NAEXKP01.GPSA.A"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBAL) <- c("Año", "Fecha", "AL")
CrecimientoPIB <-
  Reduce(
    function(x, y)
      merge(x, y, by = c("Año", "Fecha"), all = TRUE),
    list(
      CrecimientoPIBES,
      CrecimientoPIBEU,
      CrecimientoPIBGR,
      CrecimientoPIBSZ,
      CrecimientoPIBFR,
      CrecimientoPIBAL
    )
  )

PIBPCES <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CP_EUR_HAB.B1GQ.ES"),
    select = c("original_period", "period", "value"),

  )
#PIBPCES$value <- NULL
colnames(PIBPCES) <- c("Año", "Fecha", "ES")
PIBPCEU <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CP_EUR_HAB.B1GQ.EU28"),
    select = c("original_period", "period", "value")
  )
colnames(PIBPCEU) <- c("Año", "Fecha", "EU")
PIBPCGR <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CP_EUR_HAB.B1GQ.EL"),
    select = c("original_period", "period", "value")
  )
colnames(PIBPCGR) <- c("Año", "Fecha", "GR")
PIBPCSZ <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CP_EUR_HAB.B1GQ.CH"),
    select = c("original_period", "period", "value")
  )
colnames(PIBPCSZ) <- c("Año", "Fecha", "SZ")
PIBPCFR <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CP_EUR_HAB.B1GQ.FR"),
    select = c("original_period", "period", "value")
  )
colnames(PIBPCFR) <- c("Año", "Fecha", "FR")
PIBPCAL <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CP_EUR_HAB.B1GQ.DE"),
    select = c("original_period", "period", "value")
  )
colnames(PIBPCAL) <- c("Año", "Fecha", "AL")
PIBPC <-
  Reduce(
    function(x, y)
      merge(x, y, by = c("Año", "Fecha"), all = TRUE),
    list(PIBPCES, PIBPCEU, PIBPCGR, PIBPCSZ, PIBPCFR, PIBPCAL)
  )

CrecimientoPIBPCES <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CLV_PCH_PRE_HAB.B1GQ.ES"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBPCES) <- c("Año", "Fecha", "ES")
CrecimientoPIBPCEU <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CLV_PCH_PRE_HAB.B1GQ.EU28"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBPCEU) <- c("Año", "Fecha", "EU")
CrecimientoPIBPCGR <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CLV_PCH_PRE_HAB.B1GQ.EL"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBPCGR) <- c("Año", "Fecha", "GR")
CrecimientoPIBPCSZ <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CLV_PCH_PRE_HAB.B1GQ.CH"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBPCSZ) <- c("Año", "Fecha", "SZ")
CrecimientoPIBPCFR <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CLV_PCH_PRE_HAB.B1GQ.FR"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBPCFR) <- c("Año", "Fecha", "FR")
CrecimientoPIBPCAL <-
  subset(
    rdb("Eurostat/nama_10_pc/A.CLV_PCH_PRE_HAB.B1GQ.DE"),
    select = c("original_period", "period", "value")
  )
colnames(CrecimientoPIBPCAL) <- c("Año", "Fecha", "AL")
CrecimientoPIBPC <-
  Reduce(
    function(x, y)
      merge(x, y, by = c("Año", "Fecha"), all = TRUE),
    list(
      CrecimientoPIBPCES,
      CrecimientoPIBPCEU,
      CrecimientoPIBPCGR,
      CrecimientoPIBPCSZ,
      CrecimientoPIBPCFR,
      CrecimientoPIBPCAL
    )
  )

IPCES <-
  subset(rdb("WB/GEM/CPTOTSAXNZGY-ESP"),
         select = c("original_period", "period", "value"))
colnames(IPCES) <- c("Año", "Fecha", "ES")
IPCEU <-
  subset(
    rdb("IMF/CPI/A.U2.PCPIHA_PC_CP_A_PT"),
    select = c("original_period", "period", "value")
  )
colnames(IPCEU) <- c("Año", "Fecha", "EU")
IPCGR <-
  subset(rdb("WB/GEM/CPTOTSAXNZGY-GRC"),
         select = c("original_period", "period", "value"))
colnames(IPCGR) <- c("Año", "Fecha", "GR")
IPCSZ <-
  subset(rdb("WB/GEM/CPTOTSAXNZGY-CHE"),
         select = c("original_period", "period", "value"))
colnames(IPCSZ) <- c("Año", "Fecha", "SZ")
IPCFR <-
  subset(rdb("WB/GEM/CPTOTSAXNZGY-FRA"),
         select = c("original_period", "period", "value"))
colnames(IPCFR) <- c("Año", "Fecha", "FR")
IPCAL <-
  subset(rdb("WB/GEM/CPTOTSAXNZGY-DEU"),
         select = c("original_period", "period", "value"))
colnames(IPCAL) <- c("Año", "Fecha", "AL")
IPC <-
  Reduce(function(x, y)
    merge(x, y, by = c("Año", "Fecha"), all = TRUE),
    list(IPCES, IPCEU, IPCGR, IPCSZ, IPCFR, IPCAL))

PAROES <-
  subset(rdb("WB/WDI/SL.UEM.TOTL.NE.ZS-ES"),
         select = c("original_period", "period", "value"))
colnames(PAROES) <- c("Año", "Fecha", "ES")
PAROEU <-
  subset(rdb("WB/WDI/SL.UEM.TOTL.NE.ZS-EU"),
         select = c("original_period", "period", "value"))
colnames(PAROEU) <- c("Año", "Fecha", "EU")
PAROGR <-
  subset(rdb("WB/WDI/SL.UEM.TOTL.NE.ZS-GR"),
         select = c("original_period", "period", "value"))
colnames(PAROGR) <- c("Año", "Fecha", "GR")
PAROSZ <-
  subset(rdb("WB/WDI/SL.UEM.TOTL.NE.ZS-CH"),
         select = c("original_period", "period", "value"))
colnames(PAROSZ) <- c("Año", "Fecha", "SZ")
PAROFR <-
  subset(rdb("WB/WDI/SL.UEM.TOTL.NE.ZS-FR"),
         select = c("original_period", "period", "value"))
colnames(PAROFR) <- c("Año", "Fecha", "FR")
PAROAL <-
  subset(rdb("WB/WDI/SL.UEM.TOTL.NE.ZS-DE"),
         select = c("original_period", "period", "value"))
colnames(PAROAL) <- c("Año", "Fecha", "AL")
PARO <-
  Reduce(
    function(x, y)
      merge(x, y, by = c("Año", "Fecha"), all = TRUE),
    list(PAROES, PAROEU, PAROGR, PAROSZ, PAROFR, PAROAL)
  )

IntbonosES <-
  subset(rdb("OECD/MEI/ESP.IRLTLT01.ST.A"),
         select = c("original_period", "period", "value"))
colnames(IntbonosES) <- c("Año", "Fecha", "ES")
IntbonosEU <-
  subset(rdb("OECD/MEI/EA19.IRLTLT01.ST.A"),
         select = c("original_period", "period", "value"))
colnames(IntbonosEU) <- c("Año", "Fecha", "EU")
IntbonosGR <-
  subset(rdb("OECD/MEI/GRC.IRLTLT01.ST.A"),
         select = c("original_period", "period", "value"))
colnames(IntbonosGR) <- c("Año", "Fecha", "GR")
IntbonosSZ <-
  subset(rdb("OECD/MEI/CHE.IRLTLT01.ST.A"),
         select = c("original_period", "period", "value"))
colnames(IntbonosSZ) <- c("Año", "Fecha", "SZ")
IntbonosFR <-
  subset(rdb("OECD/MEI/FRA.IRLTLT01.ST.A"),
         select = c("original_period", "period", "value"))
colnames(IntbonosFR) <- c("Año", "Fecha", "FR")
IntbonosAL <-
  subset(rdb("OECD/MEI/DEU.IRLTLT01.ST.A"),
         select = c("original_period", "period", "value"))
colnames(IntbonosAL) <- c("Año", "Fecha", "AL")
Intbonos <-
  Reduce(
    function(x, y)
      merge(x, y, by = c("Año", "Fecha"), all = TRUE),
    list(
      IntbonosES,
      IntbonosEU,
      IntbonosGR,
      IntbonosSZ,
      IntbonosFR,
      IntbonosAL
    )
  ) # Interés bonos del estado

BPES <-
  subset(
    rdb(
      "UNCTAD/BOPCABA/A.us-dollars-at-current-prices-in-millions.spain"
    ),
    select = c("original_period", "period", "value")
  )
colnames(BPES) <- c("Año", "Fecha", "ES")
BPEU <-
  subset(
    rdb(
"UNCTAD/BOPCABA/A.us-dollars-at-current-prices-in-millions.eu28-european-union"
    ),
    select = c("original_period", "period", "value")
  )
colnames(BPEU) <- c("Año", "Fecha", "EU")
BPGR <-
  subset(
    rdb(
      "UNCTAD/BOPCABA/A.us-dollars-at-current-prices-in-millions.greece"
    ),
    select = c("original_period", "period", "value")
  )
colnames(BPGR) <- c("Año", "Fecha", "GR")
BPSZ <-
  subset(
    rdb(
      "UNCTAD/BOPCABA/A.us-dollars-at-current-prices-in-millions.switzerland-liechtenstein"
    ),
    select = c("original_period", "period", "value")
  )
colnames(BPSZ) <- c("Año", "Fecha", "SZ")
BPFR <-
  subset(
    rdb(
      "UNCTAD/BOPCABA/A.us-dollars-at-current-prices-in-millions.france"
    ),
    select = c("original_period", "period", "value")
  )
colnames(BPFR) <- c("Año", "Fecha", "FR")
BPAL <-
  subset(
    rdb(
      "UNCTAD/BOPCABA/A.us-dollars-at-current-prices-in-millions.germany"
    ),
    select = c("original_period", "period", "value")
  )
colnames(BPAL) <- c("Año", "Fecha", "AL")
BP <-
  Reduce(function(x, y)
    merge(x, y, by = c("Año", "Fecha"), all = TRUE),
    list(BPES, BPEU, BPGR, BPSZ, BPFR, BPAL)) # Balanza de pagos
nuevafila <-
  data.frame(2019, as.Date("2019-01-01"),	NA, NA, NA, NA, NA, NA)
names(nuevafila) <-
  c("Año", "Fecha", "ES", "EU", "GR", "SZ", "FR", "AL")
BP <- rbind(BP, nuevafila)

GrossDebtES <-
  subset(
    rdb("IMF/FM/A.ES.G_XWDG_G01_GDP_PT"),
    select = c("original_period", "period", "value")
  )
colnames(GrossDebtES) <- c("Año", "Fecha", "ES")
GrossDebtEU <-
  subset(
    rdb("IMF/FM/A.U2.G_XWDG_G01_GDP_PT"),
    select = c("original_period", "period", "value")
  )
colnames(GrossDebtEU) <- c("Año", "Fecha", "EU")
GrossDebtGR <-
  subset(
    rdb("IMF/FM/A.GR.G_XWDG_G01_GDP_PT"),
    select = c("original_period", "period", "value")
  )
colnames(GrossDebtGR) <- c("Año", "Fecha", "GR")
GrossDebtSZ <-
  subset(
    rdb("IMF/FM/A.CH.G_XWDG_G01_GDP_PT"),
    select = c("original_period", "period", "value")
  )
colnames(GrossDebtSZ) <- c("Año", "Fecha", "SZ")
GrossDebtFR <-
  subset(
    rdb("IMF/FM/A.FR.G_XWDG_G01_GDP_PT"),
    select = c("original_period", "period", "value")
  )
colnames(GrossDebtFR) <- c("Año", "Fecha", "FR")
GrossDebtAL <-
  subset(
    rdb("IMF/FM/A.DE.G_XWDG_G01_GDP_PT"),
    select = c("original_period", "period", "value")
  )
colnames(GrossDebtAL) <- c("Año", "Fecha", "AL")
GrossDebt <-
  Reduce(
    function(x, y)
      merge(x, y, by = c("Año", "Fecha"), all = TRUE),
    list(
      GrossDebtES,
      GrossDebtEU,
      GrossDebtGR,
      GrossDebtSZ,
      GrossDebtFR,
      GrossDebtAL
    )
  ) #Gross debt (% of GDP)

#Visualización
report_path <- tempfile(fileext = ".Rmd")
shinyServer(function(input, output, session) {
  #Información estática
  PIBtext <-
    HTML(
      "El producto interior bruto refleja el valor monetario de todos los bienes y servicios finales producidos por un país o
         región en un determinado periodo de tiempo, midiendo la riqueza en conjunto del país, pero no de su población. <br>
         A partir de las tasas de variación del PIB se puede conocer si la economía de un país está creciendo o menguando,
         y se puede utilizar directamente para comparar el tamaño de las economías a nivel internacional."
    )
  PIBpctext <-
    HTML(
      "Mide la relación existente entre el nivel de renta de un país y su población. Para ello, se divide el Producto Interior Bruto (PIB)
    de dicho territorio entre el número de habitantes. Se utiliza como indicador de la riqueza de un territorio ya que a
    través de su cálculo se interrelacionan la renta nacional (mediante el PIB en un periodo concreto) y los habitantes de ese lugar. <br>
    El objetivo del PIB  per cápita es obtener un dato que muestre el nivel de bienestar de un territorio en un momento determinado. Con frecuencia
    se emplea como medida de comparación entre diferentes países, para mostrar las diferencias en cuanto a condiciones económicas."
    )
  IPCtext <-
    HTML(
      "El Índice de Precios al Consumo mide la variación de los precios de una cesta de bienes y servicios en un lugar
    concreto durante un determinado periodo de tiempo. Es utilizado para evaluar las variaciones del coste de vida mediante
    la evolución de los precios de un conjunto de productos representativos del consumo medio familiar. <br>
    Además, se trata del principal índice para medir la inflación, pues, aunque no se limite al estudio de una cesta cerrada,
    suele estar fuertemente relacionado con la variación de los precios de un país."
    )
  Desempleotext <-
    HTML(
      "También conocida como tasa de paro, mide el nivel de desocupación en relación con la población activa, es decir, representa el porcentaje de la población en
    condiciones de participar en el mercado laboral pero que no consigue puesto de trabajo. Este indicador suele asociarse a la recesión o crecimiento de la economía en
    un país, pues suelen comportarse de la misma forma en el tiempo, aunque con cierto desfase."
    )
  inttext <-
    HTML(
      "Es el precio a pagar por utilizar una cantidad de dinero durante un tiempo determinado. Su valor indica el porcentaje de interés que se debe pagar como
         contraprestación por utilizar una cantidad determinada de dinero en una operación financiera, es decir, mide el coste del dinero prestado. <br>
         Además, también mide las fluctuaciones en los precios del mercado de divisas. Las variaciones de la tasa de interés dependen principalmente de la oferta y
         la demanda de dinero, aunque también se ve afectado por otros factores como primas, inflación o riesgos."
    )
  dptext <-
    HTML(
      "O deuda soberana, es la deuda total que mantiene un Estado con inversores particulares o con otro país, es decir, es la deuda de todo el conjunto de las
         administraciones públicas. En España corresponde a la suma de la deuda del Estado central, de las 17 comunidades autónomas y de las administraciones locales. <br>
         Un Estado incurre en déficit público cuando gasta más de lo que ha ingresado, situación en la que necesita encontrar una fuente de financiación ajena y
         para ello realiza emisiones de activos financieros, entre los que se encuentran los bonos del Estado, que se emitirán a un tipo de interés dado."
    )
  bptext <-
    HTML(
      "Indicador macroeconómico que proporciona información sobre los ingresos que recibe un país procedentes del resto del mundo y los pagos que realiza tal país al
         resto del mundo debido a las importaciones y exportaciones de bienes, servicios, capital o transferencias en un período de tiempo. Ofrece una visión general
         de cómo un país participa en los mercados del exterior y como el resto de los países lo hacen en el suyo."
    )
  #Creación de la tabla
  vals <- reactiveValues()
  observe({
    espa <- c(
      round(subset(PIB, Año == input$Año)$ES, digits = 2),
      round(subset(CrecimientoPIB, Año == input$Año)$ES, digits = 2),
      formatC(
        subset(PIBPC, Año == input$Año)$ES / 1000,
        format = "f",
        digits = 2
      ),
      round(subset(CrecimientoPIBPC, Año == input$Año)$ES, digits = 2),
      round(subset(IPC, Año == input$Año)$ES, digits = 2),
      round(subset(PARO, Año == input$Año)$ES, digits = 2),
      round(subset(Intbonos, Año == input$Año)$ES, digits = 2),
      round(subset(GrossDebt, Año == input$Año)$ES, digits = 2),
      round(subset(BP, Año == input$Año)$ES, digits = 2)
    )
    ue <- c(
      round(subset(PIB, Año == input$Año)$EU, digits = 2),
      round(subset(CrecimientoPIB, Año == input$Año)$EU, digits = 2),
      formatC(
        subset(PIBPC, Año == input$Año)$EU / 1000,
        format = "f",
        digits = 2
      ),
      round(subset(CrecimientoPIBPC, Año == input$Año)$EU, digits = 2),
      round(subset(IPC, Año == input$Año)$EU, digits = 2),
      round(subset(PARO, Año == input$Año)$EU, digits = 2),
      round(subset(Intbonos, Año == input$Año)$EU, digits = 2),
      round(subset(GrossDebt, Año == input$Año)$EU, digits = 2),
      round(subset(BP, Año == input$Año)$EU, digits = 2)
    )
    grecia <- c(
      round(subset(PIB, Año == input$Año)$GR, digits = 2),
      round(subset(CrecimientoPIB, Año == input$Año)$GR, digits = 2),
      formatC(
        subset(PIBPC, Año == input$Año)$GR / 1000,
        format = "f",
        digits = 2
      ),
      round(subset(CrecimientoPIBPC, Año == input$Año)$GR, digits = 2),
      round(subset(IPC, Año == input$Año)$GR, digits = 2),
      round(subset(PARO, Año == input$Año)$GR, digits = 2),
      round(subset(Intbonos, Año == input$Año)$GR, digits = 2),
      round(subset(GrossDebt, Año == input$Año)$GR, digits = 2),
      round(subset(BP, Año == input$Año)$GR, digits = 2)
    )
    suiza <- c(
      round(subset(PIB, Año == input$Año)$SZ, digits = 2),
      round(subset(CrecimientoPIB, Año == input$Año)$SZ, digits = 2),
      formatC(
        subset(PIBPC, Año == input$Año)$SZ / 1000,
        format = "f",
        digits = 2
      ),
      round(subset(CrecimientoPIBPC, Año == input$Año)$SZ, digits = 2),
      round(subset(IPC, Año == input$Año)$SZ, digits = 2),
      round(subset(PARO, Año == input$Año)$SZ, digits = 2),
      round(subset(Intbonos, Año == input$Año)$SZ, digits = 2),
      round(subset(GrossDebt, Año == input$Año)$SZ, digits = 2),
      round(subset(BP, Año == input$Año)$SZ, digits = 2)
    )
    francia <- c(
      round(subset(PIB, Año == input$Año)$FR, digits = 2),
      round(subset(CrecimientoPIB, Año == input$Año)$FR, digits = 2),
      formatC(
        subset(PIBPC, Año == input$Año)$FR / 1000,
        format = "f",
        digits = 2
      ),
      round(subset(CrecimientoPIBPC, Año == input$Año)$FR, digits = 2),
      round(subset(IPC, Año == input$Año)$FR, digits = 2),
      round(subset(PARO, Año == input$Año)$FR, digits = 2),
      round(subset(Intbonos, Año == input$Año)$FR, digits = 2),
      round(subset(GrossDebt, Año == input$Año)$FR, digits = 2),
      round(subset(BP, Año == input$Año)$FR, digits = 2)
    )
    alemania <- c(
      round(subset(PIB, Año == input$Año)$AL, digits = 2),
      round(subset(CrecimientoPIB, Año == input$Año)$AL, digits = 2),
      formatC(
        subset(PIBPC, Año == input$Año)$AL / 1000,
        format = "f",
        digits = 2
      ),
      round(subset(CrecimientoPIBPC, Año == input$Año)$AL, digits = 2),
      round(subset(IPC, Año == input$Año)$AL, digits = 2),
      round(subset(PARO, Año == input$Año)$AL, digits = 2),
      round(subset(Intbonos, Año == input$Año)$AL, digits = 2),
      round(subset(GrossDebt, Año == input$Año)$AL, digits = 2),
      round(subset(BP, Año == input$Año)$AL, digits = 2)
    )
    fuentes <- c(
      "OECD",
      "OECD",
      "EUROSTAT",
      "EUROSTAT",
      "World Bank",
      "World Bank",
      "OECD",
      "UNCTAD",
      "IMF"
    )
    vals$W <- data.frame(
      "España" = espa,
      "UE" = ue,
      "Grecia" = grecia,
      "Suiza" = suiza,
      "Francia" = francia,
      "Alemania" = alemania,
      "Fuente" = fuentes,
      row.names = c(
        "PIB (miles de millones de euros)",
        "Crecimiento del PIB (%)",
        "PIB per cápita (miles de euros)",
        "Crecimiento del PIB per cápita (%)",
        "IPC (incremento interanual)",
        "Desempleo (% sobre población activa)",
        "Tipo de interés (bonos del Estado a 10 años)",
        "Deuda pública (% del PIB)",
        "Balanza de pagos (miles de millones de $)"
      )
    )
  })
  tabladatos <- reactive({
    vector <- c()
    indices <- c()
    if ("España" %in% input$Zona2) {
      vector[length(vector) + 1] <- "España"
    }
    if ("Unión Europea" %in% input$Zona2) {
      vector[length(vector) + 1] <- "UE"
    }
    if ("Grecia (más precaria)" %in% input$Zona2) {
      vector[length(vector) + 1] <- "Grecia"
    }
    if ("Suiza (más estable)" %in% input$Zona2) {
      vector[length(vector) + 1] <- "Suiza"
    }
    if ("Francia" %in% input$Zona2) {
      vector[length(vector) + 1] <- "Francia"
    }
    if ("Alemania" %in% input$Zona2) {
      vector[length(vector) + 1] <- "Alemania"
    }
    vector[length(vector) + 1] <- "Fuente"
    if ("PIB" %in% input$selcindicadores) {
      indices[length(indices) + 1] <- "PIB (miles de millones de euros)"
    }
    if ("Crecimiento del PIB" %in% input$selcindicadores) {
      indices[length(indices) + 1] <- "Crecimiento del PIB (%)"
    }
    if ("PIB per cápita" %in% input$selcindicadores) {
      indices[length(indices) + 1] <- "PIB per cápita (miles de euros)"
    }
    if ("Crecimiento del PIB per cápita" %in% input$selcindicadores) {
      indices[length(indices) + 1] <-
        "Crecimiento del PIB per cápita (%)"
    }
    if ("IPC" %in% input$selcindicadores) {
      indices[length(indices) + 1] <- "IPC (incremento interanual)"
    }
    if ("Desempleo" %in% input$selcindicadores) {
      indices[length(indices) + 1] <-
        "Desempleo (% sobre población activa)"
    }
    if ("Tipo de interés (bonos del estado)" %in% input$selcindicadores) {
      indices[length(indices) + 1] <-
        "Tipo de interés (bonos del Estado a 10 años)"
    }
    if ("Deuda pública" %in% input$selcindicadores) {
      indices[length(indices) + 1] <- "Deuda pública (% del PIB)"
    }
    if ("Balanza de pagos" %in% input$selcindicadores) {
      indices[length(indices) + 1] <-
        "Balanza de pagos (miles de millones de $)"
    }
    subset(vals$W, rownames(vals$W) %in% indices, select = vector)
  })
  #Creación de la gráfica de evolución
  grafica <- reactive({
    seleccionado <- PIB
    Titulo <-
      "PIB nacional con respecto a la media europea en miles de millones de €"
    output$TituloBox <- renderText("PIB")
    output$TextoBox <- renderUI(PIBtext)
    if (input$Indicador == "IPC") {
      seleccionado <- IPC
      Titulo <- "Tasa de variación del índice de precios al consumo"
      output$TituloBox <- renderText("IPC")
      output$TextoBox <- renderUI(IPCtext)
    } else if (input$Indicador == "Desempleo") {
      seleccionado <- PARO
      Titulo <- "Tasa de paro sobre población activa"
      output$TituloBox <- renderText("Desempleo")
      output$TextoBox <- renderUI(Desempleotext)
    } else if (input$Indicador == "Balanza de pagos") {
      seleccionado <- BP
      Titulo <-
        "Resultado de la Balanza de pagos en miles de millones de $"
      output$TituloBox <- renderText("Balanza de pagos")
      output$TextoBox <- renderUI(bptext)
    } else if (input$Indicador == "Crecimiento del PIB") {
      seleccionado <- CrecimientoPIB
      Titulo <-
        "Tasa de crecimiento del PIB con respecto al año anterior"
      output$TituloBox <- renderText("PIB")
      output$TextoBox <- renderUI(PIBtext)
    } else if (input$Indicador == "Tipo de interés (bonos del estado)") {
      seleccionado <- Intbonos
      Titulo <-
        "Interés nacional bonos a 10 años con respecto a la media europea"
      output$TituloBox <- renderText("Interés bonos")
      output$TextoBox <- renderUI(inttext)
    } else if (input$Indicador == "PIB per cápita") {
      seleccionado <- PIBPC
      Titulo <- "PIB per cápita en €"
      output$TituloBox <- renderText("PIB per cápita")
      output$TextoBox <- renderUI(PIBpctext)
    } else if (input$Indicador == "Crecimiento del PIB per cápita") {
      seleccionado <- CrecimientoPIBPC
      Titulo <-
        "Tasa de crecimiento del PIB per cápita con respecto al año anterior"
      output$TituloBox <- renderText("PIB per cápita")
      output$TextoBox <- renderUI(PIBpctext)
    } else if (input$Indicador == "Deuda pública") {
      seleccionado <- GrossDebt
      Titulo <- "Deuda pública en % del PIB"
      output$TituloBox <- renderText("Deuda pública")
      output$TextoBox <- renderUI(dptext)
    }
    colores <- palette(rainbow(8))
    prueba <- ggplotly(
      ggplot(seleccionado) +
        {
          if ("España" %in% input$Zona)
            geom_line(aes(y = ES, x = Fecha, color = "España"))
        } +
        {
          if ("Unión Europea" %in% input$Zona)
            geom_line(aes(y = EU, x = Fecha,  color = "Unión Europea"))
        } +
        {
          if ("Grecia (más precaria)" %in% input$Zona)
            geom_line(aes(y = GR, x = Fecha, color = "Grecia"))
        } +
        {
          if ("Suiza (más estable)" %in% input$Zona)
            geom_line(aes(y = SZ, x = Fecha,  color = "Suiza"))
        } +
        {
          if ("Francia" %in% input$Zona)
            geom_line(aes(y = FR, x = Fecha,  color = "Francia"))
        } +
        {
          if ("Alemania" %in% input$Zona)
            geom_line(aes(y = AL, x = Fecha,  color = "Alemania"))
        } +
        {
          if (input$Indicador == "IPC")
            list(geom_hline(yintercept = 0), ylim(-2.5, 7))
        } +
        {
          if (input$Indicador == "Balanza de pagos")
            list(geom_hline(yintercept = 0))
        } +
        {
          if (input$Indicador == "Crecimiento del PIB")
            list(geom_hline(yintercept = 0))
        } +
        {
          if (input$Indicador == "Tipo de interés (bonos del estado)")
            list(geom_hline(yintercept = 0))
        } +
        {
          if (input$Indicador == "Crecimiento del PIB per cápita")
            list(geom_hline(yintercept = 0), ylim(-10, 15))
        } +
        scale_x_date(
          limits = as.Date(c('1995-01-01', '2020-01-01')),
          date_breaks = "2 years",
          date_labels = "%Y"
        ) +
        labs(y = as.character(input$Indicador), x = "Año")  +
        scale_color_manual(
          breaks = c(
            "España",
            "Unión Europea",
            "Grecia",
            "Suiza",
            "Francia",
            "Alemania"
          ),
          values = c(colores[1], colores[2], colores[3], colores[5], 
                     colores[8], colores[7])
        ) +
        theme_minimal() + theme(legend.title = element_blank()),
      tooltip = c("y", "x"),
    ) %>% layout(
      xaxis = list(autorange = TRUE),
      yaxis = list(autorange = TRUE),
      title = Titulo,
      margin = list(t = 30),
      legend = list(y = 0.8, yanchor = "top")
    ) %>%
      config(displayModeBar = FALSE) %>%
      add_annotations(
        text = "Región",
        xref = "paper",
        yref = "paper",
        x = 1.02,
        xanchor = "left",
        y = 0.8,
        yanchor = "bottom",
        # Same y as legend below
        legendtitle = TRUE,
        showarrow = FALSE
      )
  })
  #Mostrar tabla
  output$DatosTabla <- renderTable(tabladatos(), rownames = TRUE)
  
  #Mostrar Gráfica de evolución
  output$DatosPlot <- renderPlotly({
    grafica()
  })
  
  #EXTRAS y demás
  #Botón de apagado
  observeEvent(input$close, {
    stopApp()
  })
  inc <- function(x)
  {
    eval.parent(substitute(x <- x + 1))
  }
  rest <- function(x)
  {
    eval.parent(substitute(x <- x - 1))
  }
  #Autocolapsar paneles laterales
  contador <- 0
  contador1 <- 0
  
  observeEvent(input$iscollapsebox1, {
    if (!is.null(input$iscollapsebox1)) {
      if (input$iscollapsebox1 == TRUE) {
        rest(contador)
      } else if (input$iscollapsebox1 == FALSE) {
        inc(contador)
      }
    }
    if (!is.null(input$iscollapsebox2)) {
      if (input$iscollapsebox2 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box2"))
      }
    }
    if (!is.null(input$iscollapsebox3)) {
      if (input$iscollapsebox3 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box3"))
      }
    }
    if (!is.null(input$iscollapsebox4)) {
      if (input$iscollapsebox4 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box4"))
      }
    }
    if (!is.null(input$iscollapsebox5)) {
      if (input$iscollapsebox5 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box5"))
      }
    }
  })
  observeEvent(input$iscollapsebox2, {
    if (!is.null(input$iscollapsebox2)) {
      if (input$iscollapsebox2 == TRUE) {
        rest(contador)
      } else if (input$iscollapsebox2 == FALSE) {
        inc(contador)
      }
    }
    if (!is.null(input$iscollapsebox1)) {
      if (input$iscollapsebox1 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box1"))
      }
    }
    if (!is.null(input$iscollapsebox3)) {
      if (input$iscollapsebox3 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box3"))
      }
    }
    if (!is.null(input$iscollapsebox4)) {
      if (input$iscollapsebox4 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box4"))
      }
    }
    if (!is.null(input$iscollapsebox5)) {
      if (input$iscollapsebox5 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box5"))
      }
    }
  })
  observeEvent(input$iscollapsebox3, {
    if (!is.null(input$iscollapsebox3)) {
      if (input$iscollapsebox3 == TRUE) {
        rest(contador)
      } else if (input$iscollapsebox3 == FALSE) {
        inc(contador)
      }
    }
    if (!is.null(input$iscollapsebox2)) {
      if (input$iscollapsebox2 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box2"))
      }
    }
    if (!is.null(input$iscollapsebox1)) {
      if (input$iscollapsebox1 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box1"))
      }
    }
    if (!is.null(input$iscollapsebox4)) {
      if (input$iscollapsebox4 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box4"))
      }
    }
    if (!is.null(input$iscollapsebox5)) {
      if (input$iscollapsebox5 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box5"))
      }
    }
  })
  observeEvent(input$iscollapsebox4, {
    if (!is.null(input$iscollapsebox4)) {
      if (input$iscollapsebox4 == TRUE) {
        rest(contador)
      } else if (input$iscollapsebox4 == FALSE) {
        inc(contador)
      }
    }
    if (!is.null(input$iscollapsebox2)) {
      if (input$iscollapsebox2 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box2"))
      }
    }
    if (!is.null(input$iscollapsebox3)) {
      if (input$iscollapsebox3 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box3"))
      }
    }
    if (!is.null(input$iscollapsebox1)) {
      if (input$iscollapsebox1 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box1"))
      }
    }
    if (!is.null(input$iscollapsebox5)) {
      if (input$iscollapsebox5 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box5"))
      }
    }
  })
  observeEvent(input$iscollapsebox5, {
    if (!is.null(input$iscollapsebox5)) {
      if (input$iscollapsebox5 == TRUE) {
        rest(contador)
      } else if (input$iscollapsebox5 == FALSE) {
        inc(contador)
      }
    }
    if (!is.null(input$iscollapsebox2)) {
      if (input$iscollapsebox2 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box2"))
      }
    }
    if (!is.null(input$iscollapsebox3)) {
      if (input$iscollapsebox3 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box3"))
      }
    }
    if (!is.null(input$iscollapsebox4)) {
      if (input$iscollapsebox4 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box4"))
      }
    }
    if (!is.null(input$iscollapsebox1)) {
      if (input$iscollapsebox1 == FALSE &
          contador >= 1) {
        list(rest(contador) , js$collapse("box1"))
      }
    }
  })
  
  observeEvent(input$iscollapsebox11, {
    if (!is.null(input$iscollapsebox11)) {
      if (input$iscollapsebox11 == TRUE) {
        rest(contador1)
      } else if (input$iscollapsebox11 == FALSE) {
        inc(contador1)
      }
    }
    if (!is.null(input$iscollapsebox12)) {
      if (input$iscollapsebox12 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box12"))
      }
    }
    if (!is.null(input$iscollapsebox13)) {
      if (input$iscollapsebox13 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box13"))
      }
    }
    if (!is.null(input$iscollapsebox14)) {
      if (input$iscollapsebox14 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box14"))
      }
    }
    if (!is.null(input$iscollapsebox15)) {
      if (input$iscollapsebox15 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box15"))
      }
    }
    if (!is.null(input$iscollapsebox16)) {
      if (input$iscollapsebox16 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box16"))
      }
    }
    if (!is.null(input$iscollapsebox17)) {
      if (input$iscollapsebox17 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box17"))
      }
    }
  })
  observeEvent(input$iscollapsebox12, {
    if (!is.null(input$iscollapsebox12)) {
      if (input$iscollapsebox12 == TRUE) {
        rest(contador1)
      } else if (input$iscollapsebox12 == FALSE) {
        inc(contador1)
      }
    }
    if (!is.null(input$iscollapsebox11)) {
      if (input$iscollapsebox11 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box11"))
      }
    }
    if (!is.null(input$iscollapsebox13)) {
      if (input$iscollapsebox13 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box13"))
      }
    }
    if (!is.null(input$iscollapsebox14)) {
      if (input$iscollapsebox14 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box14"))
      }
    }
    if (!is.null(input$iscollapsebox15)) {
      if (input$iscollapsebox15 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box15"))
      }
    }
    if (!is.null(input$iscollapsebox16)) {
      if (input$iscollapsebox16 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box16"))
      }
    }
    if (!is.null(input$iscollapsebox17)) {
      if (input$iscollapsebox17 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box17"))
      }
    }
  })
  observeEvent(input$iscollapsebox13, {
    if (!is.null(input$iscollapsebox13)) {
      if (input$iscollapsebox13 == TRUE) {
        rest(contador1)
      } else if (input$iscollapsebox13 == FALSE) {
        inc(contador1)
      }
    }
    if (!is.null(input$iscollapsebox12)) {
      if (input$iscollapsebox12 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box12"))
      }
    }
    if (!is.null(input$iscollapsebox11)) {
      if (input$iscollapsebox11 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box11"))
      }
    }
    if (!is.null(input$iscollapsebox14)) {
      if (input$iscollapsebox14 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box14"))
      }
    }
    if (!is.null(input$iscollapsebox15)) {
      if (input$iscollapsebox15 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box15"))
      }
    }
    if (!is.null(input$iscollapsebox16)) {
      if (input$iscollapsebox16 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box16"))
      }
    }
    if (!is.null(input$iscollapsebox17)) {
      if (input$iscollapsebox17 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box17"))
      }
    }
  })
  observeEvent(input$iscollapsebox14, {
    if (!is.null(input$iscollapsebox14)) {
      if (input$iscollapsebox14 == TRUE) {
        rest(contador1)
      } else if (input$iscollapsebox14 == FALSE) {
        inc(contador1)
      }
    }
    if (!is.null(input$iscollapsebox12)) {
      if (input$iscollapsebox12 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box12"))
      }
    }
    if (!is.null(input$iscollapsebox11)) {
      if (input$iscollapsebox11 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box11"))
      }
    }
    if (!is.null(input$iscollapsebox13)) {
      if (input$iscollapsebox13 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box13"))
      }
    }
    if (!is.null(input$iscollapsebox15)) {
      if (input$iscollapsebox15 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box15"))
      }
    }
    if (!is.null(input$iscollapsebox16)) {
      if (input$iscollapsebox16 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box16"))
      }
    }
    if (!is.null(input$iscollapsebox17)) {
      if (input$iscollapsebox17 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box17"))
      }
    }
  })
  observeEvent(input$iscollapsebox15, {
    if (!is.null(input$iscollapsebox15)) {
      if (input$iscollapsebox15 == TRUE) {
        rest(contador1)
      } else if (input$iscollapsebox15 == FALSE) {
        inc(contador1)
      }
    }
    if (!is.null(input$iscollapsebox12)) {
      if (input$iscollapsebox12 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box12"))
      }
    }
    if (!is.null(input$iscollapsebox11)) {
      if (input$iscollapsebox11 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box11"))
      }
    }
    if (!is.null(input$iscollapsebox14)) {
      if (input$iscollapsebox14 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box14"))
      }
    }
    if (!is.null(input$iscollapsebox13)) {
      if (input$iscollapsebox13 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box13"))
      }
    }
    if (!is.null(input$iscollapsebox16)) {
      if (input$iscollapsebox16 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box16"))
      }
    }
    if (!is.null(input$iscollapsebox17)) {
      if (input$iscollapsebox17 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box17"))
      }
    }
  })
  observeEvent(input$iscollapsebox16, {
    if (!is.null(input$iscollapsebox16)) {
      if (input$iscollapsebox16 == TRUE) {
        rest(contador1)
      } else if (input$iscollapsebox16 == FALSE) {
        inc(contador1)
      }
    }
    if (!is.null(input$iscollapsebox12)) {
      if (input$iscollapsebox12 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box12"))
      }
    }
    if (!is.null(input$iscollapsebox11)) {
      if (input$iscollapsebox11 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box11"))
      }
    }
    if (!is.null(input$iscollapsebox14)) {
      if (input$iscollapsebox14 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box14"))
      }
    }
    if (!is.null(input$iscollapsebox15)) {
      if (input$iscollapsebox15 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box15"))
      }
    }
    if (!is.null(input$iscollapsebox13)) {
      if (input$iscollapsebox13 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box13"))
      }
    }
    if (!is.null(input$iscollapsebox17)) {
      if (input$iscollapsebox17 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box17"))
      }
    }
  })
  observeEvent(input$iscollapsebox17, {
    if (!is.null(input$iscollapsebox17)) {
      if (input$iscollapsebox17 == TRUE) {
        rest(contador1)
      } else if (input$iscollapsebox17 == FALSE) {
        inc(contador1)
      }
    }
    if (!is.null(input$iscollapsebox12)) {
      if (input$iscollapsebox12 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box12"))
      }
    }
    if (!is.null(input$iscollapsebox11)) {
      if (input$iscollapsebox11 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box11"))
      }
    }
    if (!is.null(input$iscollapsebox14)) {
      if (input$iscollapsebox14 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box14"))
      }
    }
    if (!is.null(input$iscollapsebox15)) {
      if (input$iscollapsebox15 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box15"))
      }
    }
    if (!is.null(input$iscollapsebox16)) {
      if (input$iscollapsebox16 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box16"))
      }
    }
    if (!is.null(input$iscollapsebox13)) {
      if (input$iscollapsebox13 == FALSE &
          contador1 >= 1) {
        list(rest(contador1) , js$collapse("box13"))
      }
    }
  })
  #imprimir información adicional
  output$TextoOECD <- renderUI({
    HTML(
      'Organisation for Economic Co-operation and Development <br> Se trata de una organización internacional que trabaja para desarrollar
    mejores políticas para elevar el nivel de vida. Su objetivo es dar forma a políticas que fomenten la prosperidad, la igualdad,
    las oportunidades y el bienestar para todos. <br>
    Con casi 60 años de experiencia, trabaja junto a otras organizaciones gubernamentales, legisladores y ciudadanos, para establecer estándares
         internacionales con el fin de encontrar soluciones a la extensa variedad de desafíos sociales, económicos y ambientales que se presentan en la actualidad.
         Desde la mejora del desempeño económico y la creación de empleos hasta el fomento de una educación sólida y la lucha contra la evasión fiscal internacional,
         ofrece un foro único donde son alojados sus datos y análisis, permitiendo el intercambio de experiencias, mejores prácticas y asesoramiento sobre políticas
         públicas y establecimiento de normas internacionales.'
    )
  })
  output$TextoIMF <- renderUI({
    HTML(
      'International Monetary Fund <br> El Fondo Monetario Internacional es una organización de 189 países que trabaja para fomentar
    la cooperación monetaria global, asegurar la estabilidad financiera, facilitar el comercio internacional, promover el empleo digno,
    el crecimiento económico sostenible y reducir la pobreza en todo el mundo. Creado en 1945, el FMI está regido y es responsable ante los
    189 países que conforman su membresía casi global. <br>
    El objetivo principal del FMI es garantizar la estabilidad del sistema monetario internacional: el sistema de tasas de cambio y pagos
    internacionales que permite a los países (y sus ciudadanos) realizar transacciones entre ellos. El mandato del Fondo se actualizó en 2012
    para incluir todas las cuestiones macroeconómicas y del sector financiero que afectan a la estabilidad mundial. <br>
    Los Archivos del Fondo presentan una rica fuente de información para el análisis de las actividades centrales del FMI a lo largo de
    su historia. Estos recursos primarios ofrecen una visión única del trabajo, las políticas, los procesos de toma de decisiones y las
    relaciones con los países miembros del FMI, que cubren temas económicos de interés: cooperación monetaria global, estabilidad financiera,
    crecimiento económico sostenible y otros.'
    )
  })
  output$TextoWB <- renderUI({
    HTML(
      'World Bank<br> El Grupo Banco Mundial es una asociación conformada por 189 países miembros de todo el mundo y dividida en cinco
    instituciones integrantes que trabajan para reducir la pobreza y generar prosperidad en los países en desarrollo. Está compuesto
    por el Banco internacional de reconstrucción y fomento, la Asociación Internacional de fomento, la Corporación Financiera Internacional,
    el Organismo multilateral de garantía de inversiones y el Centro Internacional de arreglo de diferencias relativas a inversiones.<br>
    El Grupo Banco Mundial trabaja en todas las principales esferas del desarrollo: proporciona una gran variedad de productos financieros y
    asistencia técnica, y ayuda a los países a enfrentar los desafíos mediante el intercambio de conocimiento y la aplicación de
    soluciones innovadoras, convirtiéndose así en una de las fuentes más importantes de financiación y conocimiento siendo sus datos de libre
    acceso.'
    )
  })
  output$TextoEUROSTAT <- renderUI({
    HTML(
      'Eurostat es la oficina de estadística de la Unión Europea situada en Luxemburgo. Su misión es proporcionar estadísticas de alta
    calidad para Europa. Mientras cumple su misión, Eurostat promueve los siguientes valores: respeto y confianza, fomentando la excelencia,
    promoviendo la innovación, la orientación al servicio y la independencia profesional.<br>
    Se fundamenta en la premisa de que las sociedades democráticas no funcionan correctamente sin una base sólida de estadísticas confiables y
    objetivas, considerando como tarea clave proporcionar las estadísticas que permitan realizar comparaciones entre países y regiones: Por un
    lado, los responsables de la toma de decisiones a nivel de la UE, en los Estados miembros, en los gobiernos locales y en las empresas
    necesitan estadísticas para tomar esas decisiones. Por otro lado, el público y los medios necesitan estadísticas para tener una imagen
    precisa de la sociedad contemporánea y evaluar el desempeño de los políticos y otros. <br>
    De esta forma, Eurostat se presenta como una de las más grandes instituciones a nivel europeo de procesamiento y publicación de
    información estadística.'
    )
  })
  output$TextoUNCTAD <- renderUI({
    HTML(
      'United Nations Conference on trade and development<br> La UNCTAD es un órgano intergubernamental permanente establecido por la
    Asamblea General de las Naciones Unidas en 1964 y forma parte de la Secretaría de la ONU. Reporta a la Asamblea General de las Naciones
    Unidas y al Consejo Económico-Social, pero disponen de propia membresía, liderazgo y presupuesto. También forma parte del Grupo de
    Desarrollo de las Naciones Unidas que, junto con otros departamentos y agencias de la ONU, se encarga de medir el progreso según los
    Objetivos de Desarrollo Sostenible, establecidos en la Agenda 2030. <br>
    Las estadísticas son una parte inherente de la UNCTAD, siendo el punto focal de las Naciones Unidas para el tratamiento integrado del
    comercio y el desarrollo y los temas interrelacionados en las áreas de finanzas, tecnología, inversión y desarrollo sostenible. La UNCTAD
    compila, valida y procesa una amplia gama de datos recopilados de fuentes nacionales e internacionales y está comprometida con la
    excelencia de sus estadísticas, ofreciendo estadísticas independientes de alta calidad para informar la investigación, el debate y la
    toma de decisiones.'
    )
  })
  
  output$TextoPIB <- renderUI({
    PIBtext
  })
  
  output$TextoPIBPC <- renderUI({
    PIBpctext
  })
  
  output$TextoIPC <- renderUI({
    IPCtext
  })
  
  output$TextoDesempleo <- renderUI({
    Desempleotext
  })
  
  output$TextoInt <- renderUI({
    inttext
  })
  
  output$TextoDP <- renderUI({
    dptext
  })
  
  output$TextoBP <- renderUI({
    bptext
  })
  #Generar informe/descargar gráfica
  output$informe <- downloadHandler(
    filename = "Tabla.html",
    content = function(file) {
      tempReport <- file.path(tempdir(), "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      rmarkdown::render(
        tempReport,
        output_file = file,
        params = list(
          n = tabladatos(),
          title = paste(c("Informe económico del año", input$Año), 
                        collapse = " "),
          cond = TRUE
        ),
        envir = new.env(parent = globalenv())
      )
    }
  )
  
  output$informe2 <- downloadHandler(
    filename = "Gráfica.html",
    content = function(file) {
      tempReport <- file.path(tempdir(), "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      rmarkdown::render(
        tempReport,
        output_file = file,
        params = list(
          n = grafica(),
          title = "Evolución temporal",
          cond = FALSE
        ),
        envir = new.env(parent = globalenv())
      )
    }
  )
  
})