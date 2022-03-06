# When a new game is initialized
class Mastermind
  attr_reader :values

  def initialize
    @values = ('1'..'6').to_a
    @code = []
  end

  def randomizer
    4.times { @code.push(@values.sample) }
    p @code
  end
end

new_game = Mastermind.new
new_game.randomizer
