#' @include RcppExports.R

#' @title Read and Parse INI File
#'
#' @description This function reads and parses an INI file, returning its contents as a list of profiles.
#'
#' @param file_name A character string specifying the path to the INI file.
#'
#' @return A list where each element represents a profile in the INI file. Each profile is a named list of key-value pairs.
#' If the INI file is empty, an empty list is returned.
#'
#' @examples
#' \dontrun{
#' # Example usage
#' ini_content <- read_ini("path/to/config.ini")
#' print(ini_content)
#' }
#'
#' @export
read_ini <- function(file_name) {
  content <- scan_ini_file(file_name)

  # Return empty list for empty files
  if (length(content) == 0) {
    return(list())
  }

  # Get Profile names
  found <- which(startsWith(content, "[") + endsWith(content, "]") == 2)
  profile_nms <- process_profile_name(content[found])
  profiles <- vector("list", length = length(profile_nms))
  names(profiles) <- profile_nms

  start <- (found + 1)
  end <- c(found[-1] - 1, length(content))
  split_content <- parse_in_half(content)
  nested_contents <- split_content[, 2] == ""

  sub_grps <- !startsWith(split_content[, 1], " ")
  split_content <- sub("[ \t\r\n]+$", "", split_content, perl = TRUE)
  split_content <- sub("^[ \t\r]+", "", split_content, perl = TRUE)
  for (i in which(start <= end)) {
    items <- seq.int(start[i], end[i])
    found_nested_content <- nested_contents[items]
    if (any(found_nested_content)) {
      profiles[[i]] <- nested_ini_content(
        split_content[items, , drop = FALSE], found_nested_content, which(sub_grps[items])
      )
    } else {
      profiles[[i]] <- extract_ini_parameter(split_content[items, , drop = FALSE])
    }
  }
  return(profiles)
}

nested_ini_content <- function(sub_content, found_nested_content, sub_grp) {
  profile_nms <- sub_content[sub_grp]
  profiles <- vector("list", length(profile_nms))
  names(profiles) <- profile_nms

  position <- which(found_nested_content)
  non_nest <- !(sub_grp %in% position)
  profiles[non_nest] <- sub_content[sub_grp[non_nest], 2, drop = TRUE]

  start <- (sub_grp + 1)
  end <- c(sub_grp[-1] - 1, nrow(sub_content))
  for (i in which(start <= end)) {
    items <- seq.int(start[i], end[i])
    profiles[[profile_nms[i]]] <- extract_ini_parameter(sub_content[items, , drop = FALSE])
  }
  return(profiles)
}


# Get a parameter and its value
extract_ini_parameter <- function(items) {
  parameter <- as.list.default(items[, 2])
  names(parameter) <- items[, 1]
  return(parameter)
}

# fast method to parse strings in half
# https://gist.github.com/hadley/2fd32cdc053099d62d56f5f28898ec95
parse_in_half <- function(x) {
  match_loc <- regexpr("=", x, fixed = TRUE)
  match_len <- attr(match_loc, "match.length")

  left_end <- match_loc - 1
  right_start <- match_loc + match_len
  right_end <- nchar(x)

  no_match <- match_loc == -1
  left_end[no_match] <- right_end[no_match]
  right_start[no_match] <- 0
  right_end[no_match] <- 0

  cbind(
    substr(x, 1, left_end),
    substr(x, right_start, right_end)
  )
}
