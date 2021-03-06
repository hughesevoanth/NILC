#' A Function to rank normal transform a distribution
#'
#' This function to rank normal transform a vect or of data
#' @param formula ztransformation formula
#' @param data the vector of data to be transformed
#' @param family the distribution family used in the ztransformation 
#' @param split_ties a flag asking if tied values should be split at random or left alone 
#' @keywords correlation analysis among factors
#' @export
#' @examples
#' rntransform()
rntransform = function (formula, data, family = gaussian, split_ties = TRUE) 
{
  if (is(try(formula, silent = TRUE), "try-error")) {
    if (is(data, "gwaa.data")) 
      data1 <- phdata(data)
    else if (is(data, "data.frame")) 
      data1 <- data
    else stop("'data' must have 'gwaa.data' or 'data.frame' class")
    formula <- data1[[as(match.call()[["formula"]], "character")]]
  }
  var <- ztransform(formula, data, family)
  if(split_ties == TRUE){
    out <- rank(var, ties.method = "random") - 0.5
  } else {
    out <- rank(var) - 0.5
  }
  out[is.na(var)] <- NA
  mP <- 0.5/max(out, na.rm = T)
  out <- out/(max(out, na.rm = T) + 0.5)
  out <- qnorm(out)
  out
}
