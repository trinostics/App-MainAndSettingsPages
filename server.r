shinyServer(function(input, output, session) {
  
  # Place to store "global variables"
  rv <- reactiveValues()
  
  # First global variable: the default message when app opens
  rv$message <- renderText("Hey, Jude")
  
  # This is the Main Page that displays the main content
  mainPage <- renderUI({
    output$mainpagetitle <- renderText(
      "This is your main page. The message is:")
    # rv$message may get different messages based on user input
    output$mainpagecontent <- rv$message
    do.call(list,
            list(
              call("textOutput", "mainpagetitle")
              , call("textOutput", "mainpagecontent")
            ))
  })

  # The purpose of the settings page is to change
  # content/parameters from default values
  settingsPage <- renderUI({
    output$settingspagetitle <- renderText("This is your settings page")
    do.call(list,
            list(
                call("textOutput", "settingspagetitle")
                , call("textInput", "newmessage", "New Message", rv$message())
                , call("actionButton", "ok", "Ok, back to Main Page") 
                ))
  })
  
  # Start out with the Main Page in the mainPanel
  output$mainpanelUI <- mainPage 

  # What should happen when user clicks to see the settings page
  observeEvent(input$settings,{
    output$mainpanelUI <- settingsPage  
  })

  # What should happen when user clicks Ok, go back to Main Page
  observeEvent(input$ok,{
    rv$message <- renderText(input$newmessage)
    output$mainpanelUI <- mainPage
  })

})