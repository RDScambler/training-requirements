### BRN - R Programming training ###

# Create tic tac toe using R.

# Welcome message.
# Note print() prints with the output number beside it. cat() does not.
cat("Let's play Tic Tac Toe!\n")

# Use Sys.sleep to include pauses between output.
#Sys.sleep(1.5)

# Define function for printing the up-to-date board.
print_updated_board <- function(brd, coord_1=NA, coord_2=NA, symbol=NA) {
  
  # Print the current board.
  cat("Current Board:\n~~~~~~~~~~~~~~~~~~\n\n")
  
  # Update board if coordinates are provided.
  if (is.na(coord_1) == FALSE & is.na(coord_2) == FALSE) {
    brd[coord_1, coord_2] <- symbol  
    
    print(brd)
    cat("\n~~~~~~~~~~~~~~~~~~\n\n")
    
    return(brd)
    
  } else {
    
    print(brd)
    cat("\n~~~~~~~~~~~~~~~~~~\n\n")
  }
}

# Define function for checking if the game has been won.
check_result <- function(brd, symbol) {
  
  n <- nrow(brd)
  
  # Check row and column-wise results.
  for (element in 1:nrow(board)) { 
    
    if (all(brd[element,] %in% symbol) == TRUE) {
      
      return(TRUE)
      
    } else if (all(brd[,element] %in% symbol) == TRUE) {
      
      return(TRUE)
      
    }
  } 
  
  # Check diagonal.
  if (all(diag(brd) %in% symbol) == TRUE) { 
    
    return(TRUE)
    
  # Check reverse diagonal.
  } else if (all(board[n^2-(1:n)*(n-1)] %in% "X") == TRUE) {
    
    return(TRUE)
    
  } else {
    
    return(FALSE)
    
  }
}


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

# Create the board.
board <- matrix(nrow=3,ncol=3)

# Repeat while loop until either symbol has won or all spaces on board are filled.
while (check_result(board, "X") != TRUE & check_result(board, "O") != TRUE & any(is.na(board) == TRUE)) { 

  symbol_list <- c("X", "O")
  
  # Make aesthetically pleasing Round title.
  cat("\n######################\n###### Round ", rnd, "######\n######################\n\n")
  
  Sys.sleep(1.5)
  
  # Print the current board.
  print_updated_board(board)
  
  
  # For each round, iterate over each symbol.
  for (sym in symbol_list) { 
    
    Sys.sleep(1.5)
    
    while (player_symbol == sym & check_result(board, "O") != TRUE & check_result(board, "X") != TRUE & any(is.na(board) == TRUE)) {
      
      # Let the player know it is their go.
      cat("Player", player_symbol, "turn.\n")
      
      # Create empty list to append Row and Column coordinates to.
      coordinates = c()
      
      # Create two element list to iterate over "Row" and "Column" choices.
      row_col_list <- c("Row", "Column")
      
      
      # Break out of repeat if a valid integer has been selected.
      # coordinates will only be appended to if selection is valid.
      # match will return the index of row_col_list's current iteration. 
      while (length(coordinates) < 2) {
      
        for (ls_item in row_col_list) {
          
          repeat {
            
            if (interactive()) {
              con <- stdin()
            } else {
              con <- "stdin"
            }
            cat("What", ls_item, "? ")
            coord <- readLines(con = con, n = 1)
            
            # Convert coord to an integer (will lead to NA value if a character).
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
              if (ls_item == "Column") {
                
                if (is.na(board[coordinates[1], coordinates[2]]) == TRUE) {
                  
                  repeat {
                    
                    # Ask user to confirm selection.
                    if (interactive()) {
                      con <- stdin()
                    } else {
                      con <- "stdin"
                    }
                    
                    # TODO: can I improve the space formatting for this string?
                    cat("Place", player_symbol, "at row", coordinates[1], ", column", coordinates[2], "[y/n]?\n")
                    answer <- readLines(con = con, n = 1)
                      
                      if (answer == "n") {
                        cat("Move not placed.\n")
                        break
                        
                      } else if (answer == "y") {
                        cat("Move placed!\n\n")
                        
                        Sys.sleep(1)
                        break
                      
                    } else {
                      cat("Invalid confirmation. Please answer y/n.\n")
                    }
                  }
      
                } else {
                  cat("This space is already taken. Please select a free space on the board.\n")
                  
                  # Reset coordinates.
                  coordinates = c()
                  
                  }
              } 
              
              # Break out of repeat if valid coordinate is chosen.
              break
              
            } else {
              cat("Invalid format. Please enter an integer between 1 and 3.\n")
              
            }
          }
        }
      }
      
      # End player turn if move is confirmed.
      if (answer == "y") {
        
        # Print updated board.
        board <- print_updated_board(board, coordinates[1], coordinates[2], player_symbol)
        board
        
        Sys.sleep(2)
        
        # Check the board.
        if (check_result(board, sym) == TRUE) {
          
          cat("Player wins, congrats!\n")
        }
        
        
        break
      }
    }
    
    
    # Computer takes go.
    if (player_symbol != sym & check_result(board, player_symbol) != TRUE & any(is.na(board)) == TRUE) { 
      
      # Let the player know it is the computer's go.
      cat("Player", sym, "turn.\n")
      
      repeat {
        # Take a random sample of size 2, with replacement, to generate coordinates for the computer.
        coordinates <- sample(c(1, 2, 3), 2, replace = TRUE)
        
        # Check the computer has chosen an empty space.
        if (is.na(board[coordinates[1], coordinates[2]]) == TRUE) {
          cat("Computer move registered.\n\n")
          Sys.sleep(1.5)
          
          # Print updated board.
          board <- print_updated_board(board, coordinates[1], coordinates[2], sym)
          board
          
          Sys.sleep(2)
          
          # Check the board.
          if (check_result(board, sym) == TRUE) {
            
            cat("Computer wins!\n")
          }
          
          break
        }
      }
    }
    
    
  
  }  
 
  
  
  # Update the round
  rnd <- rnd + 1
}


# While loop will be broken out of when all spaces are used, if no one has won by then.
if (any(is.na(board)) == FALSE) {
  
  cat("All spaces are taken without a winner - draw.\n")
  
}