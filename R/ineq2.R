#' Inequality for groupwise popn and income shares
#'
#' @param w A vector of groupwise population shares
#' @param s A corresponding vector of groupwise income shares (in increasing order)
#'
#' @returns A list with the following elements:
#'
#'\item{CV}{Coefficient of variation (scalar)}
#'\item{Gini}{Gini coefficient (scalar)}
#'\item{TH1}{Theil's first measure (scalar)}
#'\item{lzdata}{A data frame with cumulative population and income shares}
#'\item{lzcurve}{A plot of the Lorenz curve (created with ggplot2)}
#'
#' @export
#'
#' @examples
#' # vector of group-level income shares
#'s <- c(0.09, 0.15, 0.20, 0.25, 0.31)
#'# vector of group-level population shares
#'w <- rep(x=0.2, times=5)
#'myres <- ineq2(w=w,s=s)
#'
ineq2 <- function(w,s){

  # s: vector of income shares
  # w: vector of population shares

  if(base::length(s)!=base::length(w)){
    stop("Length of s an w cannot differ")
  } else if (base::is.unsorted(s)==TRUE) {
    stop("s needs to be sorted in increasing order")
  } else{

    # --- Number of observations: Will use for loops
    m <- base::length(s)

    # --- Ratio of w and s: Used in all calculations
    y <- (s/w)

    # ---- Coefficient of variation
    cv <- base::sqrt(sum(w*(y-1)^2))

    # ---- Gini coefficient
    absdiff <- function(a,b){abs(a-b)}
    M1 <- outer(y,y,FUN = absdiff)
    M2 <- outer(w,w,"*")
    G <- sum(M1*M2)/2


    # ---- Theil's first measure
    Th1 <- sum(s*log(y))


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
      #ggplot2::geom_point() +
      ggplot2::geom_abline(slope = 1, intercept = 0) +
      ggplot2::geom_hline(yintercept = 0) +
      ggplot2::geom_vline(xintercept = 1) +
      ggplot2::annotate(
        "text", x = 0.4, y = 0.5,
        label = "Line of perfect equality",
        angle = 30
        ) +
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
      TH1 = Th1,
      lzcurve = p1,
      lzdata = df
    )

    # Output
    return(res_ineq)

  }


}
