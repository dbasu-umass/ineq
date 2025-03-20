#' Inequality for group-level mean income and population levels
#'
#' @param y A vector of group-level mean income levels
#' @param n A vector of group-level population levels
#'
#' @returns A list with the following elements:
#'
#' \item{CV}{Coefficient of variation (scalar)}
#'\item{Gini}{Gini coefficient (scalar)}
#'\item{TH1}{Theil's first measure (scalar)}
#'\item{lzdata}{A data frame with cumulative population and income shares}
#'\item{lzcurve}{A plot of the Lorenz curve (created with ggplot2)}
#'
#' @export
#'
#' @examples
#' y <- c(100, 200, 300, 400)
#' n <- c(50,25,75,25)
#' myres <- ineq4(y=y,n=n)
#'
ineq4 <- function(y,n){

  # y: vector of mean income levels
  # n: vector of populations levels

  # --- income shares
  s <- y/(base::sum(y))

  # --- population shares
  w <- n/(base::sum(n))

  # --- Compute all measures by using 'ineq2'
  myres <- ineq::ineq2(w=w,s=s)


  # Results
  res_ineq <- base::list(
    CV = myres$CV,
    Gini = myres$Gini,
    TH1 = myres$TH1,
    lzcurve = myres$lzcurve,
    lzdata = myres$lzdata
  )

  # Output
  return(res_ineq)

}
