test_that("read_ini parse ini files", {
  actual <- read_ini("data.ini")
  expected <- list(
    job = list(company = "ExampleCorp", title = "Engineer"),
    person = list(age = "30", city = "New York", name = "John Doe", userId = "123456")
  )
  expect_equal(actual, expected)
})

test_that("read_ini parse empty ini files", {
  expect_equal(read_ini("empty.ini"), list())
})

test_that("read_ini missing file", {
  expect_error(
    read_ini("made_up"),
    "Unable to find file: made_up"
  )
})

test_that("read_ini updated cache file", {
  temp_file <- tempfile(fileext = '.ini')
  on.exit(unlink(temp_file))
  expect_1 <- list(foo = list(bar = "123", cho = "hello world"))
  write_ini(expect_1, temp_file)
  expect_equal(read_ini(temp_file), expect_1)

  expect_2 <- list(foo = list(bar = "124", cho = "hello foodmall"))
  write_ini(expect_2, temp_file)
  expect_equal(read_ini(temp_file), expect_2)
})
