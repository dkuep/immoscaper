library(shiny)

source("~/Desktop/immoscape/immoscaper/settings.r")

shinyServer(function(input, output, session) {
  
  observeEvent(input$delete,{
    if(input$okdelete){
      file.remove(paste0(dir,input$srcfile))
      updateSelectInput(session,'srcfile', choices = list.files(dir))
      updateCheckboxInput(session, 'okdelete', value = F)
      showNotification("Gelöscht", type = 'warning', duration = 10)
    }
    else
      showNotification("Löschen nicht freigeschaltet", type = 'warning', duration = 10)
  })
  
  get_data <- eventReactive(input$run,{
    
    progress <- shiny::Progress$new()
    progress$set(message = "Lade Daten...", value = 0)
    if(!input$getgeo) progress$set(value = 0.3)
    on.exit(progress$close())
    
    path = paste0(dir,input$srcfile)
    
    if(input$data_qual == 'update'){
      data <- load_immo_data(path, input$original)
      if(input$save)
        save_data(data, path, appendix = '_update')
    }
    else if(input$data_qual == 'new')
      data <- process_immo(src = path,
                           original = input$original,
                           get_geo = input$getgeo,
                           save_update = input$save, 
                           geo_progress = progress
      )
    if(input$save) showNotification("Update gespeichert", type = 'message', duration = 10)
    progress$set(value = 1)
    
    updateSelectInput(session,'srcfile', choices = list.files(dir))
    updateCheckboxGroupInput(session, "table1_cols",
                             choices = names(data), 
                             selected = table1_cols_selected
    )
    updateSelectInput(session, 'spiegel_group', choices = names(data), selected = 'typ')
    
    return(data)
  })
  
  output$table1 <- renderDataTable({
    get_data()[,input$table1_cols]
  }, escape = F)
  
  
  output$info <- renderPrint({
    get_data() %>% names()
  })
  
  
  output$plot2 <- renderPlot({
    dat = get_data()
    dat$spiegel <- dat$kalt / dat$flaeche
    ggplot(dat) +
      aes(y=dat$spiegel, x = as.factor(dat[,input$spiegel_group])) +
      geom_boxplot() +
      ylab("kalt / Fläche") +
      xlab(input$spiegel_group) +
      ggtitle("Mietspiegel")
  })
})
# shinyApp(ui = ui, server = server)

