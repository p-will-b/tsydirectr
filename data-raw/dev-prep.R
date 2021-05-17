library(devtools)
library(usethis)
library(desc)

# CREDIT TO COLIN FAY FOR EASY SET UP :) https://colinfay.me/build-api-wrapper-package-r/

# Remove default DESC
unlink("DESCRIPTION")
# Create and clean desc
my_desc <- description$new("!new")

# Set your package name
my_desc$set("Package", "tsydirectr")

#Set your name
my_desc$set("Author", "person('p-will-b', role = c('cre', 'aut'))")

# Remove some author fields
my_desc$del("Maintainer")

# Set the version
my_desc$set_version("0.0.1")

# The title of your package
my_desc$set(Title = "tsydirectr")
# The description of your package
my_desc$set(Description = "An R wrapper for the Treasury Direct API.")
# The urls
my_desc$set("URL", "https://www.github.com/p-will-b/tsydirectr")
my_desc$set("BugReports", "http://www.github.com/p-will-b/tsydirectr/issues")
# Save everyting
my_desc$write(file = "DESCRIPTION")

# If you want to use the MIT licence, code of conduct, and lifecycle badge
use_mit_license(name = "p-will-b")
use_code_of_conduct()
use_lifecycle_badge("Experimental")
use_news_md()

# Get the dependencies
use_package("httr")
use_package("jsonlite")
use_package("curl")
use_package("attempt")
use_package("purrr")
use_package("dplyr")
use_package("stringr")

# Clean your description
use_tidy_description()
