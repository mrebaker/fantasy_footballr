library(DBI)
library(RSQLite)
library(glue)

conn <- dbConnect(SQLite(), "F:/Databases/NFL/players.db")

load_game_data <- function() {
  # TODO: Finish porting this from Python.
  data_folder <- "data/weekly"
  weekly_data <- map(dir(data_folder, full.names = TRUE), read_json)
  
}


get_player <- function(nfl_id = NULL, player_name = NULL) {
  #' Fetch player details from the local database
  #' 
  #' Accepts either the NFL id or the player's name.
  #' 
  #' @param nfl_id integer, the NFL ID of the player
  #' @param player_name string, the name of the player to look up
  #' 
  #' @return A named list of the players attributes 
  
  params <- c(nfl_id, player_name)
  if (!is.null(params) != 1) {
    stop("Provide either the  nfl_id or the player_name.")
  }
  
  query_text <- case_when(!is.null(nfl_id) ~ "SELECT * FROM player WHERE nfl_id = {nfl_id}",
                          !is.null(player_name) ~ "SELECT * FROM player WHERE nfl_name = '{player_name}'")
  
  row <- dbGetQuery(conn, glue(query_text))
  as.list(row)
  
}

get_player_weekly_points <- function(nfl_id) {
  dbGetQuery(conn, glue("SELECT * FROM player_weekly_points WHERE player_nfl_id = {nfl_id}"))
  
}
