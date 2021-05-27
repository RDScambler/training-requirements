### BRN - R Programming training ###

# Create tic tac toe using R.

# Welcome message.
# Note print() prints with the output number beside it. cat() does not.
cat("Let's play Tic Tac Toe!\n")

# Use Sys.sleep to include pauses between output.
#Sys.sleep(1.5)

# Ensure symbol is valid.
repeat {
  
  # Ask the player for their preferred symbol.
  if (interactive()) {
    con <- stdin()
  } else {
    con <- "stdin"
  }
  cat("X or O? ")
  player_symbol <- readLines(con = con, n = 1)
  
  if (player_symbol == "X" | player_symbol == "O") {
    break
  } else {
    cat("Invalid symbol selection.\n")
  }
}

Sys.sleep(1.5)

# Set Round counter.
# Do not set variable name to round! (namespacing).
rnd <- 1

# Define which symbol's turn it is.
# The modulo checks the turn number is even, since dividing an even number by 2 will give a remainder of 0.
# For this reason it is important to start rnd on 1 so that X leads the game.
if ((rnd %% 2) == 0){
  current_turn_symbol <- "0"
} else {
  current_turn_symbol <- "X"
}

# Make aesthetically pleasing Round title.
cat("\n######################\n###### Round ", rnd, "######\n######################\n\n")

# Print the current board.
cat("Current Board:\n~~~~~~~~~~~~~~~~~~\n\n")
board <- matrix(data=NA,nrow=3,ncol=3)
board
cat("\n~~~~~~~~~~~~~~~~~~\n\n")

#Sys.sleep(1.5)

# State whose turn it currently is.
cat("Player", current_turn_symbol, "turn.\n")

while (player_symbol == current_turn_symbol) {
  
  # Create empty list to append Row and Column coordinates to.
  coordinates = c()
  
  # Create two element list to iterate over "Row" and "Column" choices.
  row_col_list <- c("Row", "Column")
  
  for (ls_item in row_col_list) {
    
    # Use repeat as syntactic sugar for while (TRUE).
    repeat {
    
      if (interactive()) {
        con <- stdin()
      } else {
        con <- "stdin"
      }
      cat("What", ls_item, "(enter an integer between 1 and 3)? ")
      coord <- readLines(con = con, n = 1)
      
      # Convert coord to an integer (will lead to NA value if character).
      # Use suppressWarnings() to omit "NAs introduced by coercion" warning message.
      # This is dealt with by "is.na(coord) == FALSE" in the following if statement.
      coord <- suppressWarnings(as.integer(coord))
          
      # Ensure coord is an integer between 1 and 3.
      if (coord >= 1 & coord <= 3 & is.na(coord) == FALSE) {
        
        # Append row, col number, to coordinates list.
        coordinates[ls_item] <- coord

        # Check the space on the board if the second coordinate is being specified.
        # At this point, the free-ness of board space can be determined.
        # Append coordinates then break if free.
        if (ls_item == "Column"){
          
          if (is.na(board[coordinates[1], coordinates[2]]) == TRUE) {
            
            repeat {
              
              # Ask user to confirm selection.
              if (interactive()) {
                con <- stdin()
              } else {
                con <- "stdin"
              }
              
              # TODO: can I improve the space formatting for this string?
              cat("Place", player_symbol, "at row", coordinates[1], ", column", coordinates[2], "?\n")
              answer <- readLines(con = con, n = 1)
                
                if (answer == "n") {
                  cat("Move not placed.\n")
                  break
                  
                } else if (answer == "y") {
                  cat("Move placed!\n\n")
                  break
                
              } else {
                cat("Invalid confirmation. Please answer y/n.\n")
              }
            }

          } else {
            cat("This space is already taken. Please select a free space on the board.\n")
            coordinates = c()
            }
        }
      } else {
        cat("Invalid format. Please enter an integer between 1 and 3.\n")
      }
      
      # Break out of repeat if a valid integer has been selected.
      # coordinates will only be appended to if selection is valid.
      # match will return the index of row_col_list's current iteration. 
      if (length(coordinates) == match(ls_item, row_col_list)) {
        break
      }
    }
  }
  
  # End player turn if move is confirmed.
  if (answer == "y") {
    break
  }
}

# Update Tic Tac Toe board with the specified coordinates.
board[coordinates[1], coordinates[2]] <- current_turn_symbol
cat("Current board: \n\n")
board
  
# Computer takes go.
repeat {
  # Take a random sample of size 2, with replacement, to generate coordinates for the computer.
  coordinates <- sample(c(1, 2, 3), 2, replace = TRUE)
  
  # Check the computer has chosen an empty space.
  if (is.na(board[coordinates[1], coordinates[2]]) == TRUE) {
    break
  }
}

# Print updated board.