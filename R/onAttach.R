.onAttach <- function(libname, pkgname){
  library(DT)
  library(plotly)
  library(lubridate)

  options(InvenceRVisualTools.DT.dom='Blfrtip')
  options(InvenceRVisualTools.DT.minPageLength=10)
  options(InvenceRVisualTools.DT.buttons=c('colvis', 'copy', 'excel'))
  # options(DT.digits=5)
  # options(DT.fontSize='85%')
  # options(DT.fontType='monospace')
}
