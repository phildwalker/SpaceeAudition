# Company Retetion data
# from the tidytuesday, cleaning script provided
# https://github.com/rfordatascience/tidytuesday/tree/master/data/2022/2022-05-31

library(rvest)
library(tidyverse)
library(jsonlite)
library(gt)
library(gtExtras)

tab_url <- "https://graphics.axios.com/2022-05-16-harris-poll/index.html?initialWidth=469&childId=av-2022-05-16-harris-poll-69AC2&parentTitle=The%202022%20Axios%20Harris%20Poll%20100%20reputation%20rankings&parentUrl=https%3A%2F%2Fwww.axios.com%2F2022%2F05%2F24%2F2022-axios-harris-poll-100-rankings"
tab_js <- "https://graphics.axios.com/2022-05-16-harris-poll/js/app.a8dd96951f9ea55e4346.min.js?a8dd96951f9ea55e4346"

raw_txt <- readLines(tab_js)

raw_json <- raw_txt %>%
  paste0(collapse = "") %>%
  gsub(
    x = ., 
    pattern = ".*o\\(M,n\\)\\}\\},function\\(n\\)\\{n\\.exports=JSON\\.parse\\('",
    replacement = ""
  ) %>%
  gsub(
    x = .,
    pattern = "'\\)\\},function\\(n,t,r\\)\\{n\\.exports.*",
    replacement = ""
  ) %>%
  str_remove_all("\\\\")


json_out <- jsonlite::fromJSON(raw_json, simplifyVector = FALSE)

raw_df <-json_out %>%
  tibble(data = .) %>%
  unnest_wider(data) 

glimpse(raw_df)

raw_df %>%
  write_rds(here::here("data","axios-harris-poll.rds"))

js_df <- raw_df %>%
  unnest_longer(history) %>%
  unnest_wider(history) %>%
  select(-dimensions)

js_df

js_df %>%write_csv(here::here("data","axios-harris-poll.csv"))

js_df %>%
  filter(!is.na(rank) | year == 2021)

axios_vars <- raw_df %>%
  select(-history) %>%
  unnest_wider(dimensions) %>%
  pivot_longer(names_to = "name", values_to = "vals", cols = TRUST:CULTURE) %>%
  unnest_wider(vals)

axios_vars %>%
  select(company, industry, name, score, rank) %>%  
  write_csv(here::here("data","reputation.csv"))

raw_df %>%
  select(-history, -dimensions) %>%
  rename(change_icon = change) %>%
  head(20) %>%
  gt::gt() %>%
  gtExtras::gt_fa_rank_change(change_icon, font_color = "match") %>%
  gt::cols_label(change_icon = "")





ratingsWide <-
  axios_vars %>% 
  select(-rank) %>% 
  pivot_wider(names_from = name, values_from = score)
  
save(ratingsWide, file = here::here("data", "ratingsWide.rda"))  

