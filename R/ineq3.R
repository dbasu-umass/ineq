#' Inequality for individual income levels
#'
#' @param y A vector of individual-level incomes
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
#' # vector of individual-level income levels
#' y <- c(100, 200, 300, 400)
#' myres <- ineq3(y=y)
#'
ineq3 <- function(y){

  # y: vector of individual-level income levels

  # Sort income vector
  y_new <- sort(y)

  # --- income shares
  s <- y_new/(base::sum(y_new))

  # --- population shares
  w <- rep(x=(1/(base::length(y_new))),times=base::length(y_new))

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
