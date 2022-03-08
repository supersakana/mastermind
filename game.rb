# When a new game is initialized
class Mastermind
  attr_reader :value, :code

  def initialize
    p 'Welcome to Mastermind! What is your name?'
    @name = gets.chomp
    p "Nice to meet you #{@name}, let's get started..."
    @values = ('1'..'6').to_a
    @cpu_code = []
    @guess = []
    @round = 0
    @code = %w[X X X X]
    @randomized = false
  end

  def randomize
    4.times { @code.push(@values.sample) }
    @randomized = true
  end

  def play_game
    while @round < 13
      if @randomized == true
        print_board
      else
        randomize
        print_board
      end
      guess_message
      user_guess(gets.chomp)
      @round += 1
    end
  end

  def print_board
    p "#{@code[0]} #{@code[1]} #{@code[2]} #{@code[3]}"
    @guess.each { |combo| p combo } unless @guess.length.zero?
  end

  def user_guess(guess)
    @guess.push(guess)
  end

  def guess_message
    p "#{@name}, make your move...(# # # #)"
  end
end

new_game = Mastermind.new
new_game.play_game
