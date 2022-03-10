# frozen_string_literal: true

require_relative 'intro'

# User creates code to break
class Maker < Intro
  def initialize
    super
    # @name = gets.chomp
    # p 'Enter a code for the cpu to break (Must be 4 digit number)'
    @user_code = []
    @is_valid = false
    @cpu_guesses = []
  end

  # user enters code for cpu to break
  def code_maker
    @user_code = gets.chomp
    valid?
  end

  # checks if user input is valid
  def valid?
    if @user_code.length == 4
      @is_valid = true
    else
      p 'Invalid Input'
      p 'Enter a code for the cpu to break (Must be 4 digit number)'
      code_maker
    end
  end

  def print_board
    p "#{@name} | #{@user_code[0]}#{@user_code[1]}#{@user_code[2]}#{@user_code[3]} | FEEDBACK"
    p '---------------------'
    p 'cpu guesses will go here'
    p '---------------------'
  end

  # game loop
  def play_game
    code_maker
    print_board if @is_valid == true
  end

  # creates random cpu guess to start with
  def choice_generator
    cpu_guess = []
    while cpu_guess.length <= 3
      sample = @values.sample
      cpu_guess.push(sample) unless cpu_guess.include?(sample)
    end
    @cpu_guesses.push(cpu_guess)
    p @cpu_guesses
  end
end
