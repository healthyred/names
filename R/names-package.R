#' A package to data mine the information of Williams Graduates
#'
#' \tabular{ll}{ Package \tab names \cr Type: \tab Package\cr
#' Version: \tab 0.1\cr Date: \tab 2017-02-12\cr }
#'
#' The names package uses the graduation data of the senior class each year published
#' in the Williams College Course Catalogs and reformats it into a data frame, so that the
#' data can be easily manipulated. This is done for thirteen years from the Class of 2003
#' to the Class of 2015. The secondary component of this package creates different line
#' graphs that display the proportions of Jewish people, and the level of merit received
#' upon graduation.
#'
#' The package contains a function \code{readnames} that takes in the text files of
#' student data, and parses the characters in the file and stores the data of each
#' individual student into a data frame. Moreso, during the construction of the data frame
#' the last name of each student is checked for matches with common Jewish last names. If the
#' student is matched, then the ethnicity of the student is considered Jewish. Using,
#' this method, the successfulness of the Jewish population at Williams Campus
#' can be measured and compared to non-Jewish students. The package also contains
#' the \code{datasummary} function to better understand the data and provide graphics
#' specifically focusing on the Jewish population on campus.
#'
#' The package contains a single data frame \code{studentdata}. This data frame contains
#' 7256 entries of students that have graduated form Williams since 2003 to 2015. Exact
#' student names are provided, so one can search through the data frame to find information
#' on specific students, or look for broader information like number of majors. Many interesting
#' things can be interpreted from this dataset, and added onto this package.
#'
#' @name names-package
#' @docType package
NULL
