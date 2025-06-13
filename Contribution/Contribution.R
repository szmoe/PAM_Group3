library(tibble)

project_contributions <- tibble::tibble(
  Topic = c("Introduction", "Method", "Result", "Discussion", "Conclusion"),
  Contributor = c("Malte Hennes", "Robin Nold", "Swe Zin Moe", 
                  "Malte Hennes, Robin Nold", "Swe Zin Moe")
)

kable(project_contributions) %>%
  kable_styling("striped", position = "left", font_size = 10)



