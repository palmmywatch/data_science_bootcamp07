# Pao Ying Chup Game

pycGame <- function() {
  # welcome
  print("Welcome to Pao Ying Chup Game :)")
  
  # while loop game
  while (TRUE) {
    # input
    name = readline("What is your name: ")
    
    roundGame = readline("How many round you want to play: ")
    roundGame = as.numeric(roundGame)
    
    roundPlay = 0
    comPoint = 0
    userPoint = 0
    
    # while loop match
    while(roundPlay < roundGame) {
      cat("Option to choose:
        h: Hummer
        s: Scissors
        p: Paper
if you want to quit during the game, Please Choose 0")
      option = c("h", "s", "p")
      
      # start match
      userChoose = readline("Choose one: ")
      comChoose = sample(option, 1)
      
      if (sum(userChoose == option) > 0) {
        print(paste("You Choose: ", userChoose))
        print(paste("Computer Choose: ", comChoose))
        print("-----------------------------------------")
      }
      
      # condition
      # user win condition
      userWin1 = (userChoose == "h" &
                  comChoose  == "s")
      userWin2 = (userChoose == "s" &
                  comChoose  == "p")
      userWin3 = (userChoose == "p" &
                  comChoose  == "h")
      # computer win condition
      comWin1  = (comChoose  == "h" &
                  userChoose == "s")
      comWin2  = (comChoose  == "s" &
                  userChoose == "p")
      comWin3  = (comChoose  == "p" &
                  userChoose == "h")
      
      # game play
      if (userWin1 | userWin2 | userWin3) {
          userPoint = userPoint + 1
          print("You win")
          
          print(paste("Your Score: ", userPoint))
          print(paste("Computer Score: ", comPoint))
          print("-----------------------------------------")
          
          roundPlay = roundPlay + 1
      } else if (comWin1 | comWin2 | comWin3) {
          comPoint = comPoint + 1
          print("You lose")
          
          print(paste("Your Score: ", userPoint))
          print(paste("Computer Score: ", comPoint))
          print("-----------------------------------------")
          
          roundPlay = roundPlay + 1
      } else if (userChoose == comChoose) {
          print("Tie")
          
          print(paste("Your Score: ", userPoint))
          print(paste("Computer Score: ", comPoint))
          print("-----------------------------------------")
          
          roundPlay = roundPlay + 1
      } else if (userChoose == "0") {
          break
      } else {
          print("Your choice is incorrect, choose again")
      }
    }
    
    # finish
    print("---------------FINISH GAME---------------")
    #print("FINISH GAME")
    
    if (userPoint > comPoint) {
      print("You WIN ! Good Game Well Played :)")
    } else if (userPoint < comPoint) {
      print("You LOST  Nice Try :(")
    } else {
      print("DRAWWW  It's good game :))")
    }
    
    print(paste("Round Played: ", roundPlay))
    print(paste("Your Score: ", userPoint))
    print(paste("Computer Score", comPoint))
    
    print("-----------------------------------------")
    cat("You want to play again:
        1. Yes
        2. No")
    playAgain = readline(":")
    playAgain = as.numeric(playAgain)
    
    if (playAgain == 1) {
      print("Lesgo !!")
    } else {
      break
    }
  }
  
  # good bye
  print("Thank you for playing with us :)")
}

pycGame()
