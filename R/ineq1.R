#' Inequality for groupwise popn share and income levels
#'
#' @param y A vector of groupwise income levels
#' @param w A vector of groupwise population shares
#'
#' @returns A list with four elements:
#'
#'\item{CV}{Coefficient of variation (scalar)}
#'\item{Gini}{Gini coefficient (scalar)}
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

    # ----- coefficient of variation
    # mean
    mu_y <- base::sum(y*w)

    # sd
    sd_y <- base::sqrt(sum(w*(y-mu_y)^2))

    # cv
    cv <- sd_y/mu_y

    # ------- Gini coefficient
    # Length of income vector
    m <- base::length(y)

    # summing up absolute income differences
    G1 <- 0
    for(j in 1:m){
      for(k in 1:m){
        G1 <- G1 + w[j]*w[k]*abs(y[j]-y[k])
      }
    }
    # Computing Gini
    G <- G1/(2*mu_y)


    # ------ Lorenz curve

    # cumulative population
    cum_popsh <- base::cumsum(w)

    # cumulative income share
    s <- y/sum(y)
    cum_incsh <- base::cumsum(s)

    # Data frame
    df <- base::data.frame(cum_popsh,cum_incsh)

    # Create plot
    p1 <- ggplot2::ggplot(data = df, ggplot2::aes(x=cum_popsh,y=cum_incsh))+
      ggplot2::geom_line(color="blue") +
      ggplot2::geom_point() +
      ggplot2::geom_abline(slope = 1, intercept = 0) +
      ggplot2::labs(
        title="Lorenz Curve",
        x="cumulative population share",
        y = "cumulaitve income share"
      ) +
      ggplot2::theme_minimal()


    # Results
    res_ineq <- base::list(
      CV = cv,
      Gini = G,
      lzcurve = p1,
      lzdata = df
    )

    # Output
    return(res_ineq)

  }



}
