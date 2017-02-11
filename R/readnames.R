#' readnames
#'
#' Takes in a datafile of names of Williams college graduates, and then
#' returns a dataset of the first name, last name, what level of honors,
#' the major.
#'
#' @param datafile
#' @param year
#' @return a matrix of the combined years with the data extracted from each person
#'
#'
#' @import tidyr

##This function will read each line of the datafile, and then produce a vector that
##shows the information in the format c(name, family name, class year, major, honors,
##Phi Beta Kappa, Sigma XI)

readnames <- function(datafile, year){

  library(tidyr)

  ##Reads in the file
  input <- readLines(datafile)

  ##Initiates the dataset
  dataset <- matrix(nrow = 1, ncol = 6)

  ##Iterates through every single line of the names file
  for (row in input){

    ##Initates all the variables of the vector
    name <- ""
    year <- year
    major <- ""
    honors <- ""
    phi <- ""
    sigma <- ""

    ##Checks for Phi Beta Kappa, else NA
    if (grepl("[*]", row) == TRUE){
      phi <- "TRUE"
    }
    else{
      phi <- NA
    }

    ##Checks for Sigma XI, else NA
    if (grepl("†", row) == TRUE){
      sigma <- "TRUE"
    }
    else{
      sigma <- NA
    }

    ##Identifies and spits out the name of the row
    ##Case for if the comma separator is in the row, since only the ones
    ##with the comma have a different major and honors
    if (grepl(",", row) == TRUE){

      ##deletes everything after the comma to pull the name by regex matching everything after the comma
      test <- row
      test <- gsub("[,](.*)", "", test)

      ##Deletes the marks at the front to be left with just the name of the person
      test <- gsub("[*]", "", test)
      test <- gsub("[†]","" , test)
      name <- test

      ##Checks for the major of the person and the type of honors, else NA for both
      if (grepl("highest", row) == TRUE){
        honors <- "highest honors"
      }
      else{
        honors <- "honors"
      }

      ##Searches for the major
      test2 <- row
      test2 <- gsub(".*honors in ", "", test2)
      major <- test2
    }


    ##Case where only the name is given and no other information is presented
    else{
      row <- gsub("[*]", "", row)
      row <- gsub("[†]","" , row)
      name <- row
      major <- NA
      honors <- NA
    }


    ##Creates the vector and puts it into matrix form
    namevector <- matrix(c(name, year, major, honors, phi, sigma), nrow = 1, ncol = 6)

    ##Rbinds all of the row vectors together into a total dataset

    dataset <- rbind(dataset, namevector)
  }

  ##Rename the columns in the dataset
  colnames(dataset) <- c("name", "year", "major", "honors", "Phi Beta Kappa", "Sigma XI")

  ##Turns the dataset into a dataframe and then separates the first name
  ##from the rest of the name
  dataset <- data.frame(dataset)
  dataset <- extract(dataset, name, c("FirstName", "LastName"),"([^ ]+) (.*)")

  ##Returns the dataset
  return(dataset)
}
