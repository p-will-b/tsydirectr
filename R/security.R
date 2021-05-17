#' Access the Treasury Direct Security endpoint
#'
#' @param cusip security cusip
#' @param issue_date date security was issued
#'
#' @importFrom attempt stop_if_all
#' @importFrom attempt stop_if_not
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET
#' @export
#'
#' @return the results from the search
#' @examples
#' tsy_sec_info(cusip = "912796CJ6", issue_date = "2014-02-11")

security_info <- function(cusip = NULL, issue_date = NULL) {

  # check date format & convert

  date_check <- is_date(issue_date)
  attempt::stop_if_not(date_check, ~ all(.x) & .x > as.Date("1970-01-01"), msg = "issue_date input is not a valid R date object")
  date_formatted <- format(issue_date, "%m/%d/%Y")

  # argument checks

  attempt::stop_if_not(cusip, ~ nchar(.x) != 9, msg = "CUSIP must be 9 characters")

  # check internet cxn

  check_internet()

  # create link

  q_link <- sprintf("%s/%s/%s", tsy_info_base, cusip, issue_date)

  # get the content and return it as a data.frame

  res <- GET(url = q_link)

  # check the result

  check_status(res)

  # get the content and return it as a data.frame

  fromJSON(rawToChar(res$content))$features

}
