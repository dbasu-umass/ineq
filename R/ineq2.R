#' Inequality for groupwise popn and income shares
#'
#' @param w A vector of groupwise population shares
#' @param s A vector of groupwise income shares
#'
#' @returns A list with four elements:
#'
#'\item{CV}{Coefficient of variation (scalar)}
#'\item{Gini}{Gini coefficient (scalar)}
#'\item{lzdata}{A data frame with cumulative population and income shares}
#'\item{lzcurve}{A plot of the Lorenz curve (created with ggplot2)}
#'
#' @export
#'
#' @examples
#'s <- c(0.09, 0.15, 0.20, 0.25, 0.31)
#'w <- rep(x=0.2, times=5)
#'myres <- ineq2(w=w,s=s)
#'
ineq2 <- function(w,s){

  # s: vector of income shares
  # w: vector of population shares

  if(base::length(s)!=base::length(w)){
    stop("Length of s an w cannot differ")
  } else{

    # Will use for loops
    m <- base::length(s)

    # ratio of w and s
    y <- (w/s)

    # coefficient of variation
    cv <- base::sqrt(w*(y-1)^2)

    # --- Gini coefficient
    # summing up absolute income differences
    G1 <- 0
    for(j in 1:m){
      for(k in 1:m){
        G1 <- G1 + w[j]*w[k]*abs(y[j]-y[k])
      }
    }
    # Computing Gini
    G <- G1/2


    # ------ Lorenz curve

    # cumulative population
    cum_popsh <- c(0,base::cumsum(w))

    # cumulative income share
    cum_incsh <- c(0,base::cumsum(s))

    # Data frame
    df <- base::data.frame(cum_popsh,cum_incsh)

    # Create plot
    p1 <- ggplot2::ggplot(data = df, ggplot2::aes(x=cum_popsh,y=cum_incsh))+
      ggplot2::geom_line(color="blue") +
      ggplot2::geom_point() +
      ggplot2::geom_abline(slope = 1, intercept = 0) +
      ggplot2::geom_hline(yintercept = 0) +
      ggplot2::geom_vline(xintercept = 1) +
      ggplot2::labs(
        title="Lorenz Curve",
        x="cumulative population share",
        y = "cumulaitve income share"
      ) +
      ggplot2::theme_minimal()


    # Results
    res_ineq <- list(
      CV = cv,
      Gini = G,
      lzcurve = p1,
      lzdata = df
    )

    # Output
    return(res_ineq)

  }


}
