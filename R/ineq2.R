ineq2 <- function(w,s){

  # s: vector of income shares
  # w: vector of population shares

  if(base::length(s)!=base::length(w)){
    stop("Length of s an w cannot differ")
  } else{

    # Will use for loops
    m <- length(s)

    # ratio of w and s
    y <- (w/s)

    # coefficient of variation
    cv <- sqrt(w*(y-1)^2)

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
    cum_popsh <- cumsum(w)

    # cumulative income share
    cum_incsh <- cumsum(s)

    # Data frame
    df <- data.frame(cum_popsh,cum_incsh)

    # Create plot
    p1 <- ggplot(data = df, aes(x=cum_popsh,y=cum_incsh))+
      geom_line(color="blue") +
      geom_point() +
      geom_abline(slope = 1, intercept = 0) +
      labs(
        title="Lorenz Curve",
        x="cumulative population share",
        y = "cumulaitve income share"
      ) +
      theme_minimal()


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
