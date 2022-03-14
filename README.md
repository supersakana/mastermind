# Mastermind

## A CLI game based off of Donald Knuth's Mastermind

### Live Preview

https://replit.com/@supersakana/mastermind?v=1

### About this game

When game.rb is run, the user is introduced with 2 options(intro.rb) to be the code breaker or code maker. According to the user's choice, the game will select which file to run (breaker.rb or maker.rb).

The clues given is Black (B - displays number of correct values in guess) and White (W - displays number if values with correct value AND index)

At the moment, breaker.rb displays the cpu code after the user makes a guess. This is so the user can test the game to make sure it is working when a guess is correct.

In the maker.rb file, the computer strategy first finds the correct numbers but sifting though avalible values with each number (one at a time), then once it know all of the values include the user's code, the CPU shuffles it's guesses until it hits the correct code.

I've added comments on each method to describe what is happening in the code.

The game ends once a winner is declared.

### Reflection

Overall, for my first take on this project, I'm happy with how it turned out. I've had the most fun programming this project than any other and felt the most struggle. Could my code be DRY-er, more elegant, and OOP? Absolutly. But this was quite the learning experience for me and is a mark of progress in my journey to becoming a developer.

Feel free to give me feedback on how I can improve, I'm very open and want to make progress.

### Notes to myself for refactoring...

- Beef up all validation methods!

- Make it so answer is hidden @breaker.rb

- DRY up sample methods in maker.rb (create it as it's own method)

- Focus more on OOP concepts

- Create a replay class or method
