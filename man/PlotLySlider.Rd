% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotly_tools.R
\name{PlotLySlider}
\alias{PlotLySlider}
\title{Adds a range slider and/or a range selector to a plotly chart}
\usage{
PlotLySlider(p, freq, auto_rangeslider = TRUE, auto_rangeselector = TRUE)
}
\arguments{
\item{p}{A plotly}

\item{freq}{The base frequency: 'D' for daily and 'H' for hourly}

\item{auto_rangeslider}{Include a range slider}

\item{auto_rangeselector}{Include a range selector}
}
\value{
A new plotly object.
}
\description{
Takes a previuosly created a time series plotly chart and adds to it a range slider and/or a range selector according to the specified bnase frequency
}
\examples{
PlotLySlider(p, 'D')
}
