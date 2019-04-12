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

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Saving Scenarios"),
   
   # Sidebar with a slider input for number of bins
   fluidRow(
     column(4,
            sliderInput("init",
                        "Initial Amount",
                        min = 0,
                        max = 100000,
                        value = 1000,
                        step = 50),
            sliderInput("cont",
                        "Annual Contribution",
                        min = 0,
                        max = 50000,
                        value = 2000,
                        step=500)
     ),
     column(4,
            sliderInput("ret",
                        "Return Rate (in %)",
                        min = 0,
                        max = 20,
                        value = 5,
                        step = 0.1),
            sliderInput("gro",
                        "Growth Rate (in %)",
                        min = 0,
                        max = 20,
                        value = 2,
                        step = 0.1)
     ),
     column(4,
            sliderInput("years",
                        "Years",
                        min = 0,
                        max = 50,
                        value = 20,
                        step = 1),
            selectInput("facet",
                        "Facet?",
                        c("No","Yes"))
     )
   ),
   fluidRow(
      
      
      # Show a plot of the generated distribution
      column(width = 10,offset = 1,
        h4("Timelines"),
         plotOutput("distPlot")
         
      )
   ),
   fluidRow(
     column(width = 8,offset=1,
     h4("Balances"),
     tableOutput("view")
     )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   mod <- reactive({
     # generate bins based on input$bins from ui.R
     #' @title future value
     #' @description calculates how much money after a certain number of years
     #' @param amount inital amount of money
     #' @param rate the rate of return
     #' @param years the number of years
     #' @return how much money afterwards
     future_value <- function(amount,rate,years){
       return(amount*(1 + rate/100)^years)
     }
     #' @title future value of annuity
     #' @description calculates how much money after a certain number of years of putting in money each year
     #' @param contrib how much money put in at the end of each year
     #' @param rate the rate of return
     #' @param years the number of years
     #' @return how much money afterwards
     annuity <- function(contrib, rate, years){
       return(contrib*((1+rate/100)^years - 1) / rate * 100) 
     }
     #' @title future value of growing annuity
     #' @description calculates how much money after a certain number of years of putting in an increasing amount of money each year
     #' @param contrib how much base money put in at the end of each year
     #' @param rate the rate of return
     #' @param growth the rate at which the money you put in grows
     #' @param years the number of years
     #' @return how much money afterwards
     growing_annuity <- function(contrib, rate, growth, years){
       return(contrib*((1+rate/100)^years - (1 + growth/100)^years) / (rate / 100 - growth / 100)) 
     }
     yr <- input$years
     
     no_contrib <- rep(0,yr+1)
     for(i in 0:yr){
       no_contrib[i+1] <- future_value(input$init,input$ret,i)
     }
     
     
     fixed_contrib <- rep(0,yr+1)
     for(i in 0:yr){
       fixed_contrib[i+1] <- future_value(input$init,input$ret,i) + annuity(input$cont,input$ret,i)
     }    
     
     
     growing_contrib <- rep(0,yr+1)
     for(i in 0:yr){
       growing_contrib[i+1] <- future_value(input$init,input$ret,i) + growing_annuity(input$cont,input$ret,input$gro,i)
     }    
     
     year <- 0:yr
     
     modalities <- data.frame(year,no_contrib,fixed_contrib,growing_contrib)
     
     return(modalities)
   })
   mod2 <- reactive({
     df <- mod()
     al <- c(df$no_contrib,df$fixed_contrib,df$growing_contrib)
     year <- rep(0:input$years,times=3)
     mode <- factor(rep(c("no_contrib","fixed_contrib","growing_contrib"),each=input$years+1)
                    ,levels=c("no_contrib","fixed_contrib","growing_contrib"))
     mod2 <- data.frame(year,mode,al)
     return(mod2)
   })
   output$distPlot <- renderPlot({
      
     if(input$facet == "No"){
       ggplot(data = mod(),color = "investments") +
         geom_line(aes(x = year, y = no_contrib,color="no_contrib")) +
         geom_point(aes(x = year, y = no_contrib,color="no_contrib")) + 
         geom_line(aes(x = year, y = fixed_contrib,color="fixed_contrib")) +
         geom_point(aes(x = year, y = fixed_contrib,color="fixed_contrib")) +
         geom_line(aes(x = year, y = growing_contrib,color="growing_contrib"))  +
         geom_point(aes(x = year, y = growing_contrib,color="growing_contrib"))  +
         labs(x="years",y="dollars",title="3 different investment growths",color='Investments')
     } else {
       ggplot(data = mod2()) +
         facet_grid(~ mode) +
         geom_area(aes(x = year, y = al,fill=mode,alpha=0.5))+
         geom_point(aes(x = year, y = al, color = mode)) + 
         geom_line(aes(x = year, y = al, color = mode)) + 
         guides(alpha=FALSE,color=FALSE)+
         
         labs(x="years",y="dollars",title="3 different investment growths",color='Investments')
     }
   })
   
   output$view <- renderTable({
     mod()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

