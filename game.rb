# When a new game is initialized
class Mastermind
  attr_reader :value, :code

  # Includes messages and default values
  def initialize
    p 'Welcome to Mastermind! What is your name?'
    @name = gets.chomp
    @values = ('1'..'6').to_a
    @code = %w[X X X X]
    @feedback = [0, 0]
    @round = 1
    @randomized = false
    @is_valid = true
    @cpu_code = []
    @guess = []
  end

  # creates a cpu generated random code
  def randomize
    4.times { @cpu_code.push(@values.sample) }
    @randomized = true
  end

  # Game loop
  def play_game
    print_board
    while @round < 13
      @randomized == true && @is_valid == true ? print_board : randomize
      guess_message
      user_guess(gets.chomp)
      @round += 1 unless @is_valid == false
    end
  end

  # Prints the gameboard with the users guess
  def print_board
    p "CPU | #{@code[0]}#{@code[1]}#{@code[2]}#{@code[3]} | FEEDBACK"
    p '---------------------'
    @guess.each do |combo|
      p "#{@guess.find_index(combo) + 1})  | #{combo} | B:#{@feedback[0]} W:#{@feedback[0]}"
    end
  end

  # Gets and validates the user's guess
  def user_guess(guess)
    if guess.length == 4
      (@is_valid = true
       @guess.push(guess))
    else
      (@is_valid = false
       p 'Invalid Guess')
    end
  end

  # Message before each guess
  def guess_message
    p '_____________________'
    p "ROUND #{@round} / 12"
    p "#{@name}, make your move...(must be a 4 digit number)"
  end
end
# End of class ---------------

new_game = Mastermind.new
new_game.play_game
