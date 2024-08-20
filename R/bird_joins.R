

library(tidyverse)
library(palmerpenguins)
library(lubridate)
library(datapasta)
library(here)

bird_observations <- read_csv(here("data", "52_pp52_birds_1.csv"))
sites <- read_csv(here("data", "52_pp52_sites_1.csv"))
surveys <- read_csv(here("data", "52_pp52_surveys_1.csv"))
taxalist <- read_csv(here("data", "52_pp52_taxalist_1.csv"))

birds_subset <- bird_observations %>%
  filter(species_id %in% c("BHCO", "RWBL")) %>%
  filter(site_id %in% c("LI-W", "NU-C"))

birds_left <- left_join(birds_subset, sites)
birds_left <- left_join(birds_left, taxalist)

birds_full <- full_join(birds_subset, sites)

birds_full <- birds_full %>%
  rename(bird_obs_notes = notes)

birds_all <- full_join(bird_observations, sites)
birds_all <- full_join(birds_all, surveys)
birds_all <- full_join(birds_all, taxalist)

birds_all <- birds_all %>%
  select(survey_date, common_name, park_name, bird_count)


birds_all <- birds_all %>%
  mutate(survey_month = lubridate::ymd(survey_date)) %>%
  mutate(survey_month = as.factor(survey_month)) %>%
  relocate(survey_month, .after=survey_date)

birds_all <- birds_all %>%
  group_by(park_name, survey_month) %>%
  filter(park_name %in% c("Lindo", "Orme", "Palomino", "Sonrisa"))









