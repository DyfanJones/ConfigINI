% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_ini.R
\name{read_ini}
\alias{read_ini}
\title{Read and Parse INI File}
\usage{
read_ini(file_name)
}
\arguments{
\item{file_name}{A character string specifying the path to the INI file.}
}
\value{
A list where each element represents a profile in the INI file. Each profile is a named list of key-value pairs.
If the INI file is empty, an empty list is returned.
}
\description{
This function reads and parses an INI file, returning its contents as a list of profiles.
}
\examples{
\dontrun{
# Example usage
ini_content <- read_ini("path/to/config.ini")
print(ini_content)
}

}
