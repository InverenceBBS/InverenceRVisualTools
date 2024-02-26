#############################################################################################
# FILE: InverenceRVisualTools/R/DT_tools.R
# PURPOSE: Tools for show dynamic tables based on DataTables Javascript library
#############################################################################################

require(DT)
options(DT.pageLength=10)
options(DT.digits=5)
options(DT.fontSize='85%')
options(DT.fontType='monospace')
#options(DT.fillContainer=NULL)

#############################################################################
#' Fit default DT Options
#'
#' @description Internal function used in DTSimple.
#'
#' @param df A data.frame to be shown
#'
#' @return A list of DT options.
#' @export
#'
#' @examples
#' DTFitOptions(df)
DTFitOptions = function(df,
  dom='Blfrtip',
  buttons= c('copy'),
  hideColNames=NULL,
  minPageLength=5,
  useRegExp=FALSE,
  autoWidth=TRUE,
  columnDefs=NULL,
  JS.compact=TRUE)
#############################################################################
{
  pageLength = minPageLength
  lengthMenu = sort(unique(c(pageLength, nrow(df),
                             5, 10, 15, 20, 25, 30, 40, 50, 75, 100, 150, 200, 500, 1000, 2000, 10000)))
  lengthMenu = lengthMenu[which(lengthMenu<=nrow(df))]
  dtOpt = list()
  if(JS.compact) {
    dtOpt$initComplete = JS(
      "function(){$(this).addClass('compact');}")
  }
  dtOpt$pageLength = pageLength
  dtOpt$lengthMenu = lengthMenu
  dtOpt$dom = dom
  dtOpt$buttons =  buttons
  dtOpt$autoWidth = autoWidth
  if(useRegExp) {
    dtOpt$search = list(regex = TRUE)
  }
  if(!is.null(columnDefs)) {
    dtOpt$columnDefs = columnDefs
  }
  if(!is.null(hideColNames)) {
    indexes = match(hideColNames,colnames(df))-1
    dtOpt$columnDefs = c(dtOpt$columnDefs,list(list(targets = indexes, visible = FALSE)))
  }

  return(dtOpt)
}

#############################################################################
#' Create an HTML table widget using the DataTables library in a simple way
#'
#' @description Call to DT::datatable with usefull adapted defaults
#'
#' @param df A data.frame to be shown
#'
#' @return An HTML table widget using the DataTables library.
#' @export
#'
#' @examples
#' DTSimple(df)
DTSimple = function(
  df,
  dom='Blfrtip',
  buttons= c('colvis', 'copy', 'excel'),
  extensions='Buttons',
  opt_class = "display nowrap",
  selection = 'single',
  filter="none", rownames=FALSE,
  minPageLength=5,
  hideColNames=NULL,
  width=NULL,
  height=NULL,
  useRegExp=FALSE,
  editable = FALSE,
  autoWidth = TRUE,
  columnDefs = NULL,
  escape=FALSE,
  callback = JS("return table;"),
  options = list())
#############################################################################
{
  DT::datatable(
    df,
    options=c(
      options,
      DTFitOptions(
        df,
        dom=dom,
        buttons=buttons,
        minPageLength=minPageLength,
        hideColNames=hideColNames,
        useRegExp=useRegExp,
        autoWidth=autoWidth,
        columnDefs=columnDefs)),
    extensions=extensions,
    class = opt_class,
    selection = selection,
    filter=filter,
    rownames=rownames,
    width=width,
    height=height,
    editable = editable,
    escape=escape,
    callback = callback)
}
