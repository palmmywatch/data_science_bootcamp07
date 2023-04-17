# Palmmy Health Bot :)

palmmyHealth <- function() {
  # while loop home
  while(TRUE) {
    # Say Hi
    print("Welcome to BMI and BMR Calculator !")
    
    name = readline("What is your name: ")
    print(paste("Hi!", name))
    print("-----------------------------------------")
    
    # while loop choose cal
    while (TRUE) {
      # choose cal
      cat("What do you want to calculate:
            1. BMI
            2. BMR")
      choice = readline("Choose number: ")
      choice = as.numeric(choice)
      
      # while loop cal
      while(TRUE) {
        # process
        if (choice == 1) {
          # bmi cal
          # input
          weight = readline("Your Weight (kg): ")
          height = readline("Your Height (cm): ")
          
          weight = as.numeric(weight)
          height = (as.numeric(height)) / 100
          
          # calculate
          bmi = round(weight / (height**2), digits = 2)
          
          # result
          print("-----------------------------------------")
          print(paste("Your BMI: ", bmi))
          if (bmi < 16) {
            print("BMI Range -> Severe Thinness")
          } else if (bmi <= 17) {
            print("BMI Range -> Moderate Thinness")
          } else if (bmi <= 18.5) {
            print("BMI Range -> Mild Thinness")
          } else if (bmi <= 25){
            print("BMI Range -> Normal")
          } else if (bmi <= 30) {
            print("BMI Range -> Overweight")
          } else if (bmi <= 35) {
            print("BMI Range -> Obese Class I")
          } else if (bmi <= 40) {
            print("BMI Range -> Obese Class II")
          } else {
            print("BMI Range -> Obese Class III")
          }
          print("-----------------------------------------")
          
          break
          
        } else if (choice == 2) {
          # bmr cal
          # input 
          weight = readline("Your Weight (kg): ")
          height = readline("Your Height (cm): ")
          
          weight = as.numeric(weight)
          height = as.numeric(height)
          
          age = readline("How old are you: ")
          age = as.numeric(age)
          
          cat("What is your gender:
                1. Male
                2. Female")
          gender = readline("Choose number: ")
          gender = as.numeric(gender)
          
          # base calculate
          bmr = round((10*weight) + (6.25*height) - (5*age), digits = 2)
          
          # result
          print("-----------------------------------------")
          if (gender == 1) {
            print(paste("BMR = ", bmr + 5, "Calories/day"))
          } else{
            print(paste("BMR = ", bmr - 161, "Calories/day"))
          }
          print("-----------------------------------------")
          
          break
          
        } else {
          print("Choose again")
          print("-----------------------------------------")
          break
        }
      }
      # end process
      cat("You want choose another calculater
            1. Yes
            2. No")
      want = readline(": ")
      want = as.numeric(want)
      
      if (want == 2) {
        paste("Thank you", name)
        break
      }
    }
    # exit ?
    cat("Are you sure to quit?
         1. Yes
         2. No")
    exit = readline(": ")
    exit = as.numeric(exit)
    
    if (exit == 1) {
      print("Thank you, see you next time :)")
      break
    }
  }
}

palmmyHealth()
