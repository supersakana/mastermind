# frozen_string_literal: true

# game intro
class Intro
  def initialize
    @values = ('1'..'6').to_a
    @win = false
    @game_choice = nil
    @validated = false
    @round = 1
    @clue = nil
    @clue_list = []
  end

  # message when someone starts the game
  def welcome_message
    p '----------------------'
    p 'WELCOME TO MASTERMIND!'
    p '----------------------'
  end

  # gives user game choice
  def prompt
    welcome_message
    while @validated == false
      p 'Would you like to be the code maker or breaker? (Type maker or breaker)'
      make_choice
    end
    maker_breaker
  end

  # validiates and assigns @game_choice
  def make_choice
    @game_choice = gets.chomp
    if (@game_choice == 'maker') || (@game_choice == 'breaker')
      @validated = true
    else
      p 'invalid choice'
      @game_choice = nil
    end
  end

  # plays game according to choice
  def maker_breaker
    p 'What is your name?'

    if @game_choice == 'maker'
      Maker.new.play_game
    else
      Breaker.new.play_game
    end
  end
end
