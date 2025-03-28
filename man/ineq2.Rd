% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ineq2.R
\name{ineq2}
\alias{ineq2}
\title{Inequality for groupwise popn and income shares}
\usage{
ineq2(w, s)
}
\arguments{
\item{w}{A vector of groupwise population shares}

\item{s}{A corresponding vector of groupwise income shares (in increasing order)}
}
\value{
A list with the following elements:

\item{CV}{Coefficient of variation (scalar)}
\item{Gini}{Gini coefficient (scalar)}
\item{TH1}{Theil's first measure (scalar)}
\item{lzdata}{A data frame with cumulative population and income shares}
\item{lzcurve}{A plot of the Lorenz curve (created with ggplot2)}
}
\description{
Inequality for groupwise popn and income shares
}
\examples{
# vector of group-level income shares
s <- c(0.09, 0.15, 0.20, 0.25, 0.31)
# vector of group-level population shares
w <- rep(x=0.2, times=5)
myres <- ineq2(w=w,s=s)

}
