
# simple utilities for checking calls

check_internet <- function() {
  attempt::stop_if_not(.x = curl::has_internet(), msg = "Please check your internet connexion")
  }

check_status <- function(res) {
  attempt::stop_if_not(
    .x = httr::status_code(res),
    .p = ~ .x == 200,
    msg = sprintf("The API returned a %s error", httr::status_code(res))
    )
  }

# set base urls for all API calls

tsy_info_base <- "https://www.treasurydirect.gov/TA_WS/securities/"
debt_info_base <- "https://www.treasurydirect.gov/NP_WS/debt/"

# is date function check (source: https://stackoverflow.com/questions/48542804/r-date-format-check)

is_date = function(x, format = "%Y-%m-%d") {
  formatted = try(as.Date(x, format), silent = TRUE)
  is_date = as.character(formatted) == x & !is.na(formatted)  # valid and identical to input
  is_date[is.na(x)] = NA  # Insert NA for NA in x
  return(is_date)
}
