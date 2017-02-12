#' totaldata
#'
#' Runs through the list of students names in all the years, creates the matrixes,
#' and then Rbinds the matrixes together to create an entire dataset
#'
#' @return the complete dataframe, or matrix of the complete dataset with all 8000 students
#'
#' @example To initialize the df: yearsdata <- totaldata()
#'
#' @export

totaldata <- function(){

  ##Allows access to the function readnames
  source("~/names/R/readnames.R")

  ##Creates the individual dataframes for each year
  year2003 <- readnames("~/names/inst/extdata/names2003.txt", "2003")
  year2004 <- readnames("~/names/inst/extdata/names2004.txt", "2004")
  year2005 <- readnames("~/names/inst/extdata/names2005.txt", "2005")
  year2006 <- readnames("~/names/inst/extdata/names2006.txt", "2006")
  year2007 <- readnames("~/names/inst/extdata/names2007.txt", "2007")
  year2008 <- readnames("~/names/inst/extdata/names2008.txt", "2008")
  year2009 <- readnames("~/names/inst/extdata/names2009.txt", "2009")
  year2010 <- readnames("~/names/inst/extdata/names2010.txt", "2010")
  year2011 <- readnames("~/names/inst/extdata/names2011.txt", "2011")
  year2012 <- readnames("~/names/inst/extdata/names2012.txt", "2012")
  year2013 <- readnames("~/names/inst/extdata/names2013.txt", "2013")
  year2014 <- readnames("~/names/inst/extdata/names2014.txt", "2014")
  year2015 <- readnames("~/names/inst/extdata/names2015.txt", "2015")


  ##Combines all of the matrixes together by rows
  data <- rbind(year2003, year2004)
  data <- rbind(data, year2005)
  data <- rbind(data, year2006)
  data <- rbind(data, year2007)
  data <- rbind(data, year2008)
  data <- rbind(data, year2009)
  data <- rbind(data, year2010)
  data <- rbind(data, year2011)
  data <- rbind(data, year2012)
  data <- rbind(data, year2013)
  data <- rbind(data, year2014)
  data <- rbind(data, year2015)

  ##Eliminates the rows with all NA values
  data <- data[rowSums(is.na(data)) != ncol(data),]

  ##returns the complete student dataframe
  return(data)
}
