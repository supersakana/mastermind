# When a new game is initialized
class Mastermind
  attr_reader :value, :code

  def initialize
    @values = ('1'..'6').to_a
    @cpu_code = []
    @code = %w[X X X X]
    @randomized = false
  end

  def randomize
    4.times { @code.push(@values.sample) }
    @randomized = true
  end

  def play_game
    if @randomized == true
      print_board
    else
      randomize
      print_board
    end
  end

  def print_board
    p "#{@code[0]} #{@code[1]} #{@code[2]} #{@code[3]}"
  end
end

new_game = Mastermind.new
new_game.play_game
