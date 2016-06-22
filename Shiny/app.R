#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(RCurl)
library(foreign)
library(scales)
library(pyramid)
library(reshape2)

#dt_total <- read.csv("D:/OneDrive/VSE/II/Economic Demography I/R Tutorial/Data/dt_total.csv")
#dt_pyramid <- read.csv("D:/OneDrive/VSE/II/Economic Demography I/R Tutorial/Data/dt_pyramid.csv")
 dt_total <- "https://raw.githubusercontent.com/zubrand/R-Tutorial/master/Data/dt_total.csv" %>% getURL() %>% textConnection() %>% read.csv()
 dt_pyramid <- "https://raw.githubusercontent.com/zubrand/R-Tutorial/master/Data/dt_pyramid.csv" %>% getURL() %>% textConnection() %>% read.csv()
#load("D:/OneDrive/VSE/II/Economic Demography I/R Tutorial/Data/dt.RData")

dt_pyramid <- dt_pyramid %>% 
  mutate(Gen_bio = cut(Age, include.lowest = T, breaks = c(0, 15, 50, 100), right = F),
         Gen_eco = cut(Age, include.lowest = T, breaks = c(0, 20, 65, 100), right = F))



# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel("Demography App"),
   
   # Sidebar with a slider input for number of bins 
   sidebarPanel(
       shiny::selectInput("Country", "Select a country", dt_total$Geo %>% levels(), c("CZ","BE") ,T),
       shiny::selectInput("Type", "Select type of analysis", 
                          c("Development of population", "Comparison of countries", "Pyramid graph", "Biological generations", "Economical generations"),
                          c("Development of population", "Comparison of countries", "Pyramid graph", "Biological generations", "Economical generations"), T),
       shiny::sliderInput("YearBegin", "Enter the start year", dt_total$Year %>% min(), dt_total$Year %>% max(),
                          value = 2000, ticks = F, round = T, sep = ""),
       shiny::sliderInput("YearEnd", "Enter the end year", dt_total$Year %>% min(), dt_total$Year %>% max(),
                          value = 2010, ticks = F, round = T, sep = "")
   ),
      # Show a plot of the generated distribution
      mainPanel(
        h2("Main indeces for selected countries and years"),
        tableOutput("table1"),
        textOutput("text1", h2),
        plotOutput("plot1"),
        textOutput("text2", h2),
        plotOutput("plot2"),
        textOutput("text3", h2),
        plotOutput("plot3"),
        textOutput("text4", h2),
        plotOutput("plot4"),
        textOutput("text5", h2),
        plotOutput("plot5")
      )
   )
)

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
   output$table1 <- renderTable({
     Ratios <- dt_pyramid %>% 
       filter(Geo %in% input$Country & between(Year, input$YearBegin, input$YearEnd)) %>%
       group_by(Year, Geo) %>% summarize(Masculinity = sum(M)/sum(F))
     
     Ratios <- dt_pyramid %>% mutate(Tot = M + F) %>% group_by(Year, Geo, Gen_bio) %>% 
       summarize(Tot = sum(Tot)) %>% 
       dcast(Year + Geo ~ Gen_bio, value.var = "Tot", fun.aggregate = sum, na.rm = T) %>%
       setNames(c("Year", "Geo", "I", "II", "III")) %>% mutate(Sauvy = III/I) %>%
       select(Year, Geo, Sauvy) %>% merge(Ratios)
     
     Ratios <- dt_pyramid %>% mutate(Tot = M + F) %>% group_by(Year, Geo, Gen_eco) %>% 
       summarize(Tot = sum(Tot)) %>% 
       dcast(Year + Geo ~ Gen_eco, value.var = "Tot", fun.aggregate = sum, na.rm = T) %>%
       setNames(c("Year", "Geo", "I", "II", "III")) %>% 
       mutate(TDR = (I+III)/II, OADR = III/II, JADR = I/II, Seniority = III/I) %>% 
       select(-I,-II,-III) %>% merge(Ratios)
     
     Ratios %>% arrange(Geo, Year)
   })
  
   output$text1 <- renderText({
     i <- 1
     if (!is.na(input$Type[i])) paste("Analysis:",input$Type[i])
   })
   output$text2 <- renderText({
     i <- 2
     if (!is.na(input$Type[i])) paste("Analysis:",input$Type[i])
   })
   output$text3 <- renderText({
     i <- 3
     if (!is.na(input$Type[i])) paste("Analysis:",input$Type[i])
   })
   output$text4 <- renderText({
     i <- 4
     if (!is.na(input$Type[i])) paste("Analysis:",input$Type[i])
   })
   output$text5 <- renderText({
     i <- 5
     if (!is.na(input$Type[i])) paste("Analysis:",input$Type[i])
   })
   
   output$plot1 <- renderPlot({
     i <- 1
     single_country <- input$Country[1]
     if ("Development of population" == input$Type[i]) 
     {
       g <- ggplot(dt_total %>% filter(Geo == single_country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)), aes(x = Year, y = Population)) + 
         geom_line() + ggtitle(paste("Development of population of", single_country)) +
         scale_y_continuous(limits = c(0, dt_total %>% filter(Geo == single_country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)) %>% select(Population) %>% max()), labels = comma)
     }
     
     if ("Comparison of countries" == input$Type[i]) 
     {
       g <- ggplot(dt_total %>% filter(Geo %in% input$Country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)), aes(x = Year, y = Population, color = Geo)) + 
         geom_line() + ggtitle(paste("Development of population of", paste(input$Country, collapse = ", "))) +
         scale_y_continuous(labels = comma)
     }
     
     if ("Pyramid graph" == input$Type[i]) 
     {
       tmp_pyr <- dt_pyramid %>% filter(Geo %in% input$Country & Year %in% c(input$YearBegin,input$YearEnd)) %>%
         select(-X, -Gen_bio, -Gen_eco) %>% melt(id = c("Age", "Geo", "Year")) %>%
         mutate(Sex = variable, Population = value)
       
       g <- ggplot(data = tmp_pyr, aes(x = Age, y = Population, fill = Sex)) + 
         geom_bar(data = subset(tmp_pyr, Sex == "F"), stat = "identity") + 
         geom_bar(data = subset(tmp_pyr, Sex == "M"), aes(y=-Population), stat = "identity") + 
         scale_y_continuous(labels = function(x) comma(abs(x))) + 
         coord_flip() + ggtitle("Pyramid graphs of selected years and countries") +
         scale_fill_brewer(palette = "Set1") +
         facet_grid(Geo ~ Year)
     }
     
     if ("Biological generations" == input$Type[i])
     {
       tmp <- dt_pyramid %>% filter(Geo %in% input$Country & between(Year, input$YearBegin, input$YearEnd)) %>%
         group_by(Gen_bio, Year, Geo) %>% summarize(Population = sum(F+M))
       g <- tmp %>% group_by(Year, Geo) %>% summarize(Tot = sum(Population)) %>% merge(tmp) %>%
         mutate(Share = Population/Tot * 100) %>% arrange(Gen_bio) %>%
         ggplot(aes(x = Year, y = Share, color = Gen_bio, fill = Gen_bio)) + geom_area() +
         facet_wrap(~Geo) + ggtitle("Comparison of countries by biological generations")
     }
     
     if ("Economical generations" == input$Type[i])
     {
       tmp <- dt_pyramid %>% filter(Geo %in% input$Country & between(Year, input$YearBegin, input$YearEnd)) %>%
         group_by(Gen_eco, Year, Geo) %>% summarize(Population = sum(F+M))
       g <- tmp %>% group_by(Year, Geo) %>% summarize(Tot = sum(Population)) %>% merge(tmp) %>%
         mutate(Share = Population/Tot * 100) %>% arrange(Gen_eco) %>%
         ggplot(aes(x = Year, y = Share, color = Gen_eco, fill = Gen_eco)) + geom_area() +
         facet_wrap(~Geo) + ggtitle("Comparison of countries by economical generations")
     }
     
     plot(g)
     
   })
   output$plot2 <- renderPlot({
     i <- 2
     single_country <- input$Country[1]
     if ("Development of population" == input$Type[i]) 
     {
       g <- ggplot(dt_total %>% filter(Geo == single_country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)), aes(x = Year, y = Population)) + 
         geom_line() + ggtitle(paste("Development of population of", single_country)) +
         scale_y_continuous(limits = c(0, dt_total %>% filter(Geo == single_country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)) %>% select(Population) %>% max()), labels = comma)
     }
     
     if ("Comparison of countries" == input$Type[i]) 
     {
       g <- ggplot(dt_total %>% filter(Geo %in% input$Country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)), aes(x = Year, y = Population, color = Geo)) + 
         geom_line() + ggtitle(paste("Development of population of", paste(input$Country, collapse = ", "))) +
         scale_y_continuous(labels = comma)
     }
     
     if ("Pyramid graph" == input$Type[i]) 
     {
       tmp_pyr <- dt_pyramid %>% filter(Geo %in% input$Country & Year %in% c(input$YearBegin,input$YearEnd)) %>%
         select(-X, -Gen_bio, -Gen_eco) %>% melt(id = c("Age", "Geo", "Year")) %>%
         mutate(Sex = variable, Population = value)
       
       g <- ggplot(data = tmp_pyr, aes(x = Age, y = Population, fill = Sex)) + 
         geom_bar(data = subset(tmp_pyr, Sex == "F"), stat = "identity") + 
         geom_bar(data = subset(tmp_pyr, Sex == "M"), aes(y=-Population), stat = "identity") + 
         scale_y_continuous(labels = function(x) comma(abs(x))) + 
         coord_flip() + ggtitle("Pyramid graphs of selected years and countries") +
         scale_fill_brewer(palette = "Set1") +
         facet_grid(Geo ~ Year)
     }
     
     if ("Biological generations" == input$Type[i])
     {
       tmp <- dt_pyramid %>% filter(Geo %in% input$Country & between(Year, input$YearBegin, input$YearEnd)) %>%
         group_by(Gen_bio, Year, Geo) %>% summarize(Population = sum(F+M))
       g <- tmp %>% group_by(Year, Geo) %>% summarize(Tot = sum(Population)) %>% merge(tmp) %>%
         mutate(Share = Population/Tot * 100) %>% arrange(Gen_bio) %>%
         ggplot(aes(x = Year, y = Share, color = Gen_bio, fill = Gen_bio)) + geom_area() +
         facet_wrap(~Geo) + ggtitle("Comparison of countries by biological generations")
     }
     
     if ("Economical generations" == input$Type[i])
     {
       tmp <- dt_pyramid %>% filter(Geo %in% input$Country & between(Year, input$YearBegin, input$YearEnd)) %>%
         group_by(Gen_eco, Year, Geo) %>% summarize(Population = sum(F+M))
       g <- tmp %>% group_by(Year, Geo) %>% summarize(Tot = sum(Population)) %>% merge(tmp) %>%
         mutate(Share = Population/Tot * 100) %>% arrange(Gen_eco) %>%
         ggplot(aes(x = Year, y = Share, color = Gen_eco, fill = Gen_eco)) + geom_area() +
         facet_wrap(~Geo) + ggtitle("Comparison of countries by economical generations")
     }
     
     plot(g)
     
   })
   output$plot3 <- renderPlot({
     i <- 3
     single_country <- input$Country[1]
     if ("Development of population" == input$Type[i]) 
     {
       g <- ggplot(dt_total %>% filter(Geo == single_country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)), aes(x = Year, y = Population)) + 
         geom_line() + ggtitle(paste("Development of population of", single_country)) +
         scale_y_continuous(limits = c(0, dt_total %>% filter(Geo == single_country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)) %>% select(Population) %>% max()), labels = comma)
     }
     
     if ("Comparison of countries" == input$Type[i]) 
     {
       g <- ggplot(dt_total %>% filter(Geo %in% input$Country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)), aes(x = Year, y = Population, color = Geo)) + 
         geom_line() + ggtitle(paste("Development of population of", paste(input$Country, collapse = ", "))) +
         scale_y_continuous(labels = comma)
     }
     
     if ("Pyramid graph" == input$Type[i]) 
     {
       tmp_pyr <- dt_pyramid %>% filter(Geo %in% input$Country & Year %in% c(input$YearBegin,input$YearEnd)) %>%
         select(-X, -Gen_bio, -Gen_eco) %>% melt(id = c("Age", "Geo", "Year")) %>%
         mutate(Sex = variable, Population = value)
       
       g <- ggplot(data = tmp_pyr, aes(x = Age, y = Population, fill = Sex)) + 
         geom_bar(data = subset(tmp_pyr, Sex == "F"), stat = "identity") + 
         geom_bar(data = subset(tmp_pyr, Sex == "M"), aes(y=-Population), stat = "identity") + 
         scale_y_continuous(labels = function(x) comma(abs(x))) + 
         coord_flip() + ggtitle("Pyramid graphs of selected years and countries") +
         scale_fill_brewer(palette = "Set1") +
         facet_grid(Geo ~ Year)
     }
     
     if ("Biological generations" == input$Type[i])
     {
       tmp <- dt_pyramid %>% filter(Geo %in% input$Country & between(Year, input$YearBegin, input$YearEnd)) %>%
         group_by(Gen_bio, Year, Geo) %>% summarize(Population = sum(F+M))
       g <- tmp %>% group_by(Year, Geo) %>% summarize(Tot = sum(Population)) %>% merge(tmp) %>%
         mutate(Share = Population/Tot * 100) %>% arrange(Gen_bio) %>%
         ggplot(aes(x = Year, y = Share, color = Gen_bio, fill = Gen_bio)) + geom_area() +
         facet_wrap(~Geo) + ggtitle("Comparison of countries by biological generations")
     }
     
     if ("Economical generations" == input$Type[i])
     {
       tmp <- dt_pyramid %>% filter(Geo %in% input$Country & between(Year, input$YearBegin, input$YearEnd)) %>%
         group_by(Gen_eco, Year, Geo) %>% summarize(Population = sum(F+M))
       g <- tmp %>% group_by(Year, Geo) %>% summarize(Tot = sum(Population)) %>% merge(tmp) %>%
         mutate(Share = Population/Tot * 100) %>% arrange(Gen_eco) %>%
         ggplot(aes(x = Year, y = Share, color = Gen_eco, fill = Gen_eco)) + geom_area() +
         facet_wrap(~Geo) + ggtitle("Comparison of countries by economical generations")
     }
     
     plot(g)
     
   })
   output$plot4 <- renderPlot({
     i <- 4
     single_country <- input$Country[1]
     if ("Development of population" == input$Type[i]) 
     {
       g <- ggplot(dt_total %>% filter(Geo == single_country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)), aes(x = Year, y = Population)) + 
         geom_line() + ggtitle(paste("Development of population of", single_country)) +
         scale_y_continuous(limits = c(0, dt_total %>% filter(Geo == single_country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)) %>% select(Population) %>% max()), labels = comma)
     }
     
     if ("Comparison of countries" == input$Type[i]) 
     {
       g <- ggplot(dt_total %>% filter(Geo %in% input$Country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)), aes(x = Year, y = Population, color = Geo)) + 
         geom_line() + ggtitle(paste("Development of population of", paste(input$Country, collapse = ", "))) +
         scale_y_continuous(labels = comma)
     }
     
     if ("Pyramid graph" == input$Type[i]) 
     {
       tmp_pyr <- dt_pyramid %>% filter(Geo %in% input$Country & Year %in% c(input$YearBegin,input$YearEnd)) %>%
         select(-X, -Gen_bio, -Gen_eco) %>% melt(id = c("Age", "Geo", "Year")) %>%
         mutate(Sex = variable, Population = value)
       
       g <- ggplot(data = tmp_pyr, aes(x = Age, y = Population, fill = Sex)) + 
         geom_bar(data = subset(tmp_pyr, Sex == "F"), stat = "identity") + 
         geom_bar(data = subset(tmp_pyr, Sex == "M"), aes(y=-Population), stat = "identity") + 
         scale_y_continuous(labels = function(x) comma(abs(x))) + 
         coord_flip() + ggtitle("Pyramid graphs of selected years and countries") +
         scale_fill_brewer(palette = "Set1") +
         facet_grid(Geo ~ Year)
     }
     
     if ("Biological generations" == input$Type[i])
     {
       tmp <- dt_pyramid %>% filter(Geo %in% input$Country & between(Year, input$YearBegin, input$YearEnd)) %>%
         group_by(Gen_bio, Year, Geo) %>% summarize(Population = sum(F+M))
       g <- tmp %>% group_by(Year, Geo) %>% summarize(Tot = sum(Population)) %>% merge(tmp) %>%
         mutate(Share = Population/Tot * 100) %>% arrange(Gen_bio) %>%
         ggplot(aes(x = Year, y = Share, color = Gen_bio, fill = Gen_bio)) + geom_area() +
         facet_wrap(~Geo) + ggtitle("Comparison of countries by biological generations")
     }
     
     if ("Economical generations" == input$Type[i])
     {
       tmp <- dt_pyramid %>% filter(Geo %in% input$Country & between(Year, input$YearBegin, input$YearEnd)) %>%
         group_by(Gen_eco, Year, Geo) %>% summarize(Population = sum(F+M))
       g <- tmp %>% group_by(Year, Geo) %>% summarize(Tot = sum(Population)) %>% merge(tmp) %>%
         mutate(Share = Population/Tot * 100) %>% arrange(Gen_eco) %>%
         ggplot(aes(x = Year, y = Share, color = Gen_eco, fill = Gen_eco)) + geom_area() +
         facet_wrap(~Geo) + ggtitle("Comparison of countries by economical generations")
     }
     
     plot(g)
     
   })
   output$plot5 <- renderPlot({
     i <- 5
     single_country <- input$Country[1]
     if ("Development of population" == input$Type[i]) 
     {
       g <- ggplot(dt_total %>% filter(Geo == single_country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)), aes(x = Year, y = Population)) + 
         geom_line() + ggtitle(paste("Development of population of", single_country)) +
         scale_y_continuous(limits = c(0, dt_total %>% filter(Geo == single_country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)) %>% select(Population) %>% max()), labels = comma)
     }
     
     if ("Comparison of countries" == input$Type[i]) 
     {
       g <- ggplot(dt_total %>% filter(Geo %in% input$Country & Sex == "T" & between(Year, input$YearBegin, input$YearEnd)), aes(x = Year, y = Population, color = Geo)) + 
         geom_line() + ggtitle(paste("Development of population of", paste(input$Country, collapse = ", "))) +
         scale_y_continuous(labels = comma)
     }
     
     if ("Pyramid graph" == input$Type[i]) 
     {
       tmp_pyr <- dt_pyramid %>% filter(Geo %in% input$Country & Year %in% c(input$YearBegin,input$YearEnd)) %>%
         select(-X, -Gen_bio, -Gen_eco) %>% melt(id = c("Age", "Geo", "Year")) %>%
         mutate(Sex = variable, Population = value)
       
       g <- ggplot(data = tmp_pyr, aes(x = Age, y = Population, fill = Sex)) + 
         geom_bar(data = subset(tmp_pyr, Sex == "F"), stat = "identity") + 
         geom_bar(data = subset(tmp_pyr, Sex == "M"), aes(y=-Population), stat = "identity") + 
         scale_y_continuous(labels = function(x) comma(abs(x))) + 
         coord_flip() + ggtitle("Pyramid graphs of selected years and countries") +
         scale_fill_brewer(palette = "Set1") +
         facet_grid(Geo ~ Year)
     }
     
     if ("Biological generations" == input$Type[i])
     {
       tmp <- dt_pyramid %>% filter(Geo %in% input$Country & between(Year, input$YearBegin, input$YearEnd)) %>%
         group_by(Gen_bio, Year, Geo) %>% summarize(Population = sum(F+M))
       g <- tmp %>% group_by(Year, Geo) %>% summarize(Tot = sum(Population)) %>% merge(tmp) %>%
         mutate(Share = Population/Tot * 100) %>% arrange(Gen_bio) %>%
         ggplot(aes(x = Year, y = Share, color = Gen_bio, fill = Gen_bio)) + geom_area() +
         facet_wrap(~Geo) + ggtitle("Comparison of countries by biological generations")
     }
     
     if ("Economical generations" == input$Type[i])
     {
       tmp <- dt_pyramid %>% filter(Geo %in% input$Country & between(Year, input$YearBegin, input$YearEnd)) %>%
         group_by(Gen_eco, Year, Geo) %>% summarize(Population = sum(F+M))
       g <- tmp %>% group_by(Year, Geo) %>% summarize(Tot = sum(Population)) %>% merge(tmp) %>%
         mutate(Share = Population/Tot * 100) %>% arrange(Gen_eco) %>%
         ggplot(aes(x = Year, y = Share, color = Gen_eco, fill = Gen_eco)) + geom_area() +
         facet_wrap(~Geo) + ggtitle("Comparison of countries by economical generations")
     }
     
     plot(g)
     
   })
   
})

# Run the application 
shinyApp(ui = ui, server = server)

 