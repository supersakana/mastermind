# When a new game is initialized
class Mastermind
  attr_reader :value, :code

  # Includes messages and default values
  def initialize
    p 'Welcome to Mastermind! What is your name?'
    @name = gets.chomp
    p "Nice to meet you #{@name}, let's get started..."
    @values = ('1'..'6').to_a
    @code = %w[X X X X]
    @cpu_code = []
    @guess = []
    @round = 1
    @randomized = false
  end

  # creates a cpu generated random code
  def randomize
    4.times { @code.push(@values.sample) }
    @randomized = true
  end

  # Game loop
  def play_game
    print_board
    while @round < 13
      @randomized == true ? print_board : randomize
      guess_message
      user_guess(gets.chomp)
      @round += 1
    end
  end

  # Prints the gameboard with the users guess
  def print_board
    p "CPU | #{@code[0]}#{@code[1]}#{@code[2]}#{@code[3]}"
    @guess.each { |combo| p "#{@guess.find_index(combo) + 1})  | #{combo}" } unless @guess.length.zero?
  end

  # Gets the user's guess (Will put conditionals eventually)
  def user_guess(guess)
    @guess.push(guess)
  end

  # Message before each guess
  def guess_message
    p '_______________'
    p "ROUND #{@round} / 12"
    p "#{@name}, make your move...(must be a 4 digit number)"
  end
end
# End of class ---------------
new_game = Mastermind.new
new_game.play_game
