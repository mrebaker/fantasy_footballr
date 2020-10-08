library(tidyverse)
library(jsonlite)

source("db.R")

player <- get_player(player_name = "Aaron Jones")
get_player_weekly_points(player$nfl_id)
