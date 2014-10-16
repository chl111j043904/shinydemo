
# Define server logic required to summarize and view the 
# selected dataset
shinyServer(function(input, output) {
  
  control<-reactiveValues(autostart=F)
  
  observe({
    if(input$run==0){return()}
    isolate({
      control$autostart<-T
    })
  })
  
  ccardata<-reactive({
    data<-read.csv("ccardata.csv",stringsAsFactors=F)
    names(data)<-gsub("[.]","",names(data))  
    data$Date<-as.yearmon(data$Date)
    data$Group[data$Group==""]<-"Severely Adverse"
    data$order<-factor(data$Group)
    levels(data$order)<-c("Historical","Baseline","Adverse","Severely Adverse")
    return(data)
    })
  
  output$ccarplot1<-renderPlot({
    input$run
    isolate({
    if(control$autostart){
      data<-subset(ccardata(),Group %in% c(input$scen,"Historical"))
    xyplot(NominalGDPgrowth~Date,groups=Group,data=data,
           type="o",auto.key=list(points=F,lines=T,columns=2),
           panel=function(...){panel.xyplot(...);panel.grid()})
                        }
            })
  })
  
  output$ccarplot2<-renderPlot({
    input$run
    isolate({
    if(control$autostart){
    data<-subset(ccardata(),Group %in% c("Historical",input$scen))
    data<-data[order(data$order,data$Date),]
    xyplot(Unemploymentrate~Date,groups=Group,data=data,
           type="o",auto.key=list(points=F,lines=T,columns=2),
           panel=function(...){panel.xyplot(...);panel.grid()})
                         }
           })   
  })

})
