library(tibble)

project_contributions <- tibble::tibble(
  Task = c("Introduction", "Method", "Result", "Discussion", "Conclusion"),
  Contributor = c("Malte", "Robin", "Moe", "Malte, Robin", "Moe")
)

project_contributions

project_contributions <- data.frame(
  Task = c("Introduction", "Method", "Result", "Discussion", "Conclusion"),
  Contributor = c("Malte", "Robin", "Moe", "Malte, Robin", "Moe"),
  stringsAsFactors = FALSE
)

project_contributions
