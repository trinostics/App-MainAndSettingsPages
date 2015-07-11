library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Change main panel to setup page, then back again"),
  sidebarPanel(
    h1("sidebar panel"),
    actionButton("settings", "Settings")),
  mainPanel(uiOutput("mainpanelUI"))
    
))