#' Inequality for groupwise popn share and income levels
#'
#' @param y A vector of groupwise mean income levels
#' @param w A vector of groupwise population shares
#'
#' @returns A list with the following elements:
#'
#'\item{CV}{Coefficient of variation (scalar)}
#'\item{Gini}{Gini coefficient (scalar)}
#'\item{TH1}{Theil's first measure (scalar)}
#'\item{lzdata}{A data frame with cumulative population and income shares}
#'\item{lzcurve}{A plot of the Lorenz curve (created with ggplot2)}
#'
#'
#' @export
#'
#' @examples
#' y2011u <- c(700,909,1118,1363,1625,1888,2181,2548,3063,3893,5351,10282)
#' w2011u <- c(0.05,0.05,rep(0.1,8),0.05,0.05)
#' res_urb_11 <- ineq1(y=y2011u, w=w2011u)
#'
ineq1 <- function(y,w){

  # y: vector of income levels
  # w: vector of population shares

  if(base::length(y)!=base::length(w)){
    stop("Length of y an w cannot differ")
  } else{

    # --- income shares
    s <- y/sum(y)

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



}
