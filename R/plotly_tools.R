#############################################################################################
# FILE: InverenceRVisualTools/Rplotly_tools.R
# PURPOSE: Utilities to handle with package plotly
#############################################################################################

require(plotly)

###############################################################################
#' Adds a range slider and/or a range selector to a plotly chart
#'
#' @description Takes a previuosly created a time series plotly chart and adds to it a range slider and/or a range selector according to the specified bnase frequency
#'
#' @param p A plotly
#' @param freq The base frequency: 'D' for daily and 'H' for hourly
#' @param auto_rangeslider Include a range slider
#' @param auto_rangeselector Include a range selector
#'
#' @return A new plotly object.
#' @export
#'
#' @examples
#' PlotLySlider(p, 'D')
PlotLySlider = function(p, freq, auto_rangeslider=TRUE, auto_rangeselector=TRUE)
###############################################################################
{
  if(freq == "D") {
    buttons=list(
      list(count=1, label="1w", step="week", stepmode="backward"),
      list(count=1, label="1m", step="month", stepmode="backward"),
      list(count=6, label="6m", step="month", stepmode="backward"),
      list(count=1, label="1y", step="year", stepmode="backward"),
      list(count=2, label="2y", step="year", stepmode="backward"),
      list(count=5, label="5y", step="year", stepmode="backward"),
      list(step="all", active=TRUE)
    )
  }
  if(freq=="H") {
    buttons=list(
      list(count=1, label="1d", step="day", stepmode="backward"),
      list(count=1, label="1w", step="week", stepmode="backward"),
      list(count=1, label="1m", step="month", stepmode="backward"),
      list(count=6, label="6m", step="month", stepmode="backward"),
      list(count=1, label="1y", step="year", stepmode="backward"),
      list(step="all", active=TRUE)
    )
  }
  xaxis = list()
  if(auto_rangeslider) {
    xaxis$rangeslider = list(visible = T, thickness = 0.05)
  }
  if(auto_rangeselector) {
    xaxis$rangeselector=list(buttons=buttons)
  }
  ps = p %>%
    layout(showlegend = T,
           yaxis = list(fixedrange = FALSE),
           xaxis = xaxis)
  return(ps)
}

###############################################################################
#' Creates a time series plotly chart
#'
#' @description Creates a time series plotly chart from a xts object and
#'
#' @param x A xts object
#' @param with The width of the widget in accepted formats as "100%" or "400px"
#'
#' @return A plotly object.
#' @export
#'
#' @examples
#' PlotLySlider(p, 'D')
PlotLyXts <- function(x, width="100%",
                      type="scatter",   mode = "lines",
                      connectgaps = TRUE,
                      line_shape=NULL, #  ( "linear" | "spline" | "hv" | "vh" | "hvh" | "vhv" )
                      verbose=FALSE)
###############################################################################
{
  df = data.frame(date=index(x), coredata(x))
  pl = plot_ly(data = df)
  for(j in 1:ncol(x)) {
    id = colnames(x)[j]
    if(id=="") { id=paste0("V",j) }
    pl.txt = paste0(
      "add_trace(p=pl, x=~date, y = ~",id,", name = '",id,"', ",
      "connectgaps=",connectgaps,", ",
      "type='",type,"', ",
      "mode = '",mode,"'",
      ifelse(is.null(line_shape),"",paste0(
        ", line = list(shape = '",line_shape,"')")),
      ")")
    if(verbose) {
      cat("TRACE[PlotLyXts] :\n",pl.txt,"\n",sep="")
    }
    pl = eval(parse(text=pl.txt))
  }
  if(main!="") {
    pl = pl %>%
      layout(title = main)
  }

  return(pl)
}

