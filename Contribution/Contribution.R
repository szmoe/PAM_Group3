library(tibble)

project_contributions <- tibble::tibble(
  Topic = c("Introduction", "Method", "Result", "Discussion", "Conclusion"),
  Contributor = c("Malte", "Robin", "Moe", "Malte, Robin", "Moe")
)

kable(project_contributions) %>%
  kable_styling("striped", position = "left", font_size = 10)



