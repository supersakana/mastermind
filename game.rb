# When a new game is initialized
class Mastermind
  attr_reader :value, :code

  # Includes messages and default values
  def initialize
    p 'Welcome to Mastermind! What is your name?'
    @name = gets.chomp
    @values = ('1'..'6').to_a
    @code = %w[X X X X]
    @round = 1
    @randomized = false
    @is_valid = true
    @cpu_code = []
    @guess = []
    @feedback = []
  end

  # creates a cpu generated random code
  def randomize
    @cpu_code.push(@values.sample) while @cpu_code.length <= 3
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
    p "CPU | #{@cpu_code[0]}#{@cpu_code[1]}#{@cpu_code[2]}#{@cpu_code[3]} | FEEDBACK"
    # p "CPU | #{@code[0]}#{@code[1]}#{@code[2]}#{@code[3]} | FEEDBACK"
    p '---------------------'
    @guess.each_with_index do |combo, index|
      p "#{index + 1})  | #{combo} | #{@feedback[index]}"
    end
  end

  # Message before each guess
  def guess_message
    p '_____________________'
    p "ROUND #{@round} / 12"
    p "#{@name}, make your move...(must be a 4 digit number)"
  end

  # Gets and validates the user's guess
  def user_guess(guess)
    if guess.length == 4
      (@is_valid = true
       black_checker(guess)
       @guess.push(guess))
    else
      (@is_valid = false
       p 'Invalid Guess')
    end
  end

  def black_checker(guess)
    randomize
    black_white = [0, 0]
    guess.to_s.chars.uniq.each do |i|
      @cpu_code.select { |j| j == i }
      p @cpu_code
    end
    @feedback.push(black_white)
  end
end
# End of class ---------------

new_game = Mastermind.new
# new_game.play_game
new_game.black_checker(1134)
