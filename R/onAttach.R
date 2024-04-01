.onAttach <- function(libname, pkgname){
  library(DT)
  library(plotly)
  require(lubridate)

  options(ExtSummary.showRMSE=TRUE)
  options(ExtSummary.showQtle="ALL")
  options(ExtSummary.nQtle0=2)
  options(ExtSummary.nQtlem=3)
  options(ExtSummary.nQtle1=2)
  options(ExtSummary.showPoints=TRUE)
  options(ExtSummary.showRMSE=TRUE)
  options(ExtSummary.showRelativeStats=TRUE)
  options(ExtSummary.digits=3)
  options(ExtSummary.max_discrete_levels=20)

  options(InvenceRVisualTools.DT.dom='Blfrtip')
  options(InvenceRVisualTools.DT.minPageLength=10)
  options(InvenceRVisualTools.DT.buttons=c('colvis', 'copy', 'excel'))
  # options(DT.digits=5)
  # options(DT.fontSize='85%')
  # options(DT.fontType='monospace')
}
