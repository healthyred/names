#' readnames
#'
#' Takes in a datafile of names of Williams college graduates, and then
#' returns a dataset of the first name, last name, what level of honors,
#' the major. As well this function tests the last name of each person
#' to check if the person is of Jewish descent or not.
#'
#' @param datafile the textfile that contains a list of the information of the
#'     the students in that year
#' @param year takes in the graduation year of the year of students
#' @return a matrix of the combined years with the data extracted from each person
#' @return a dataframe of the datafile in a formatted way
#' @examples year2014 <- readnames("~/names/inst/extdata/names2014.txt", "2014")
#'
#' @import tidyr
#'
#' @export

##This function will read each line of the datafile, and then produce a vector that
##shows the information in the format c(name, family name, class year, major, honors,
##Phi Beta Kappa, Sigma XI)

readnames <- function(datafile, year){

  library(tidyr)

  ##Reads in the file, and all the other corresponding lists to check
  input <- readLines(datafile)
  master <- readLines("~/names/inst/extdata/master.txt")
  summa <- readLines("~/names/inst/extdata/summacumlaude.txt")
  magna <- readLines("~/names/inst/extdata/magnacumlaude.txt")
  cum <- readLines("~/names/inst/extdata/cumlaude.txt")
  jewish <- readLines("~/names/inst/extdata/jewishnames.txt")

  ##Initiates the dataset
  dataset <- matrix(nrow = 1, ncol = 8)

  ##Iterates through every single line of the names file
  for (row in input){

    ##Initates all the variables of the vector
    name <- ""
    year <- year
    major <- ""
    honors <- ""
    phi <- FALSE
    sigma <- FALSE
    degree <- "bachelor of arts"
    lastname <- ""
    ethnicity <- NA

    ##Checks for the type of degree the person graduated with

    ##Checks if the person graduated with masters degree
    if (row %in% master == TRUE){
      degree <- "masters"
    }

    ##Checks if the person graduated summa cum laude
    if (row %in% summa == TRUE){
      degree <- "summa cum laude"
    }

    ##Checks if the person graduated magna cum laude
    if (row %in% magna == TRUE){
      degree <- "magna cum laude"
    }

    ##Checks if the person is cum laude
    if (row %in% cum == TRUE){
      degree <- "cum laude"
    }

    ##Special case issue since some of the later files have a different
    ##method of representing Sigma XI
    row <- gsub("[+]","†", row)

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

    ##Creates an new variable by spliting up all of the words in the name
    manipulate <- strsplit(name, ' ')

    ##Sets the last name to the last word in the name
    lastname = sapply(manipulate, function(x) x[length(x)])

    ##checks if the last name has a possibility of being Jewish
    if (tolower(lastname) %in% tolower(jewish) == TRUE){
     ethnicity <- "jewish"
    }
    }

    ##Creates the vector and puts it into matrix form
    namevector <- matrix(c(name,
                           year,
                           major,
                           honors,
                           phi,
                           sigma,
                           degree,
                           ethnicity), nrow = 1, ncol = 8)

    ##Rbinds all of the row vectors together into a total dataset

    dataset <- rbind(dataset, namevector)
  }

  ##Rename the columns in the dataset
  colnames(dataset) <- c("name",
                         "year",
                         "major",
                         "honors",
                         "Phi Beta Kappa",
                         "Sigma XI",
                         "degree",
                         "ethnicity")

  ##Turns the dataset into a dataframe and then separates the first name
  ##from the rest of the name
  dataset <- data.frame(dataset)
  #dataset <- extract(dataset, name, c("FirstName", "LastName"),"(.*) ([^ ]+)")

  ##Returns the dataset
  return(dataset)
}
