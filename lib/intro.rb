# frozen_string_literal: true

# game intro
class Intro
  def initialize
    @values = ('1'..'6').to_a
    @win = false
    @user_choice = nil
    @validated = false
  end

  # message when someone starts the game
  def welcome_message
    p '----------------------'
    p 'WELCOME TO MASTERMIND!'
    p '----------------------'
  end

  def prompt
    welcome_message
    while @validated == false
      p 'Would you like to be the code maker or breaker? (Type maker or breaker)'
      make_choice
    end
    maker_breaker
  end

  def make_choice
    @user_choice = gets.chomp
    if (@user_choice == 'maker') || (@user_choice == 'breaker')
      @validated = true
    else
      p 'invalid choice'
      @user_choice = nil
    end
  end

  def name?
    p 'What is your name?'
  end

  def maker_breaker
    name?
    if @user_choice == 'maker'
      Maker.new.play_game
    else
      Breaker.new.play_game
    end
  end
end
