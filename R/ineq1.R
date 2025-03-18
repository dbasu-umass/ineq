ineq1 <- function(y,w){
  
  # y: vector of income levels
  # w: vector of population shares
  
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
  cum_pop <- base::cumsum(w)
  
  # cumulative income share
  s <- y/sum(y)
  cum_incsh <- base::cumsum(s)
  
  # Data frame
  df <- base::data.frame(cpop=cum_pop,cincsh=cum_incsh)
  
  # Create plot
  p1 <- ggplot2::ggplot(data = df, aes(x=cpop,y=cincsh))+
    ggplot2::geom_line() + 
    ggplot2::geom_point() +
    ggplot2::geom_abline(slope = 1, intercept = 0) +
    ggplot2::labs(
      title="Lorenz Curve",
      x="cumulative popn share", 
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