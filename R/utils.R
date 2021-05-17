#' @importFrom attempt stop_if_not
#' @importFrom curl has_internet
check_internet <- function(){
  stop_if_not(.x = has_internet(), msg = "Please check your internet connexion")
}

#' @importFrom httr status_code
check_status <- function(res){
  stop_if_not(.x = status_code(res),
              .p = ~ .x == 200,
              msg = "The API returned an error")
}

# set base urls

tsy_info_base <- "https://www.treasurydirect.gov/TA_WS/securities/"
debt_info_base <- "https://www.treasurydirect.gov/NP_WS/debt/"

# is date function check source:

is_date = function(x, format = "%Y-%m-%d") {
  formatted = try(as.Date(x, format), silent = TRUE)
  is_date = as.character(formatted) == x & !is.na(formatted)  # valid and identical to input
  is_date[is.na(x)] = NA  # Insert NA for NA in x
  return(is_date)
}
