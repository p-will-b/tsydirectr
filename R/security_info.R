#' @title Access the Treasury Direct Security endpoint
#'
#' @description Returns a large collection of variables relating to
#' a specific treasury security including bid to cover ratio, rates,
#' auction data, and other reference information
#'
#' @param cusip security cusip, must be 9 characters long
#' @param issue_date date security was issued, must be in "YYYY-MM--DD" format, character input will be coerced to date
#'
#' @return the results from the searcha tibble of treasury security information
#' @export
#' @examples
#'
#' # get data for 2-year Treasury
#' security_info("91282CBX8", "2021-04-30")

security_info <- function(cusip = NULL, issue_date = NULL) {

  # check date format & convert

  date_check <- is_date(issue_date)
  attempt::stop_if_not(date_check, ~ .x & .x > as.Date("1970-01-01"), msg = "issue_date input is not a valid R date object")
  date_formatted <- format(as.Date(issue_date), "%m/%d/%Y")

  # argument checks

  attempt::stop_if_not(cusip, ~ nchar(.x) == 9, msg = "CUSIP must be 9 characters")

  # create link

  q_link <- sprintf("%s%s/%s?format=json", tsy_info_base, cusip, date_formatted)

  # check internet, make api call, check result

  check_internet()
  res <- httr::GET(url = q_link)
  check_status(res)

  # get the content and return it as a tibble

  data_dl <- jsonlite::fromJSON(rawToChar(res$content))
  data_out <- dplyr::as_tibble(data_dl)
  return(data_out)

}

