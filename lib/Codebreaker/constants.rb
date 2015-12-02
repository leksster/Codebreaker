module Codebreaker

  START_MESSAGE = "
  Codebreaker is a logic game in which a code-breaker tries to break a secret code created by a code-maker.

  The code-maker, which will be played by the application we’re going to write, creates a secret code of four numbers between 1 and 6. 
  
  The code-breaker then gets some number of chances to break the code. In each turn, the code-breaker makes a guess of four numbers. The code-maker then marks the guess with up to four + and - signs.

  A + indicates an exact match: one of the numbers in the guess is the same as one of the numbers in the secret code and in the same position.

  A - indicates a number match: one of the numbers in the guess is the same as one of the numbers in the secret code but in a different position."

  CHOOSE_MESSAGE = "[S]tart, [E]xit, [H]int, [R]estart, [?]help"

  GUESS_MESSAGE = "Enter your guess: "

  GENERATED_CODE_MESSAGE = "New secret code was generated."

  WRONG_MESSAGE = "Wrong input. Your attempt's not count."

  NO_HINTS = "No more hints left."

  HINTS_UNAVAILABLE = "Hints available only when playing."

  LOSE_MESSAGE = "Game over. The code was:"

  WIN_MESSAGE = "You win! The code was:"

  RESTART = "Restarted."

  UNKNOWN_COMMAND = "Unknown command."

  CANT_RESTART = "Please start the game first."

end
