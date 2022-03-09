# frozen_string_literal: true

# game intro
class Intro
  def initialize
    p 'Welcome to Mastermind! What is your name?'
    @name = gets.chomp
    @values = ('1'..'6').to_a
    @win = false
  end
end
