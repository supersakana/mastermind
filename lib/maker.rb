# frozen_string_literal: true

require_relative 'intro'

# User creates code to break
class Maker < Intro
  def initialize
    super
    @name = gets.chomp
    p 'Enter a code for the cpu to break (Must be 4 digit number)'
    @user_code = []
    @validated = false
    @cpu_guesses = []
    @round = 1
  end

  # user enters code for cpu to break
  def code_maker
    @user_code = gets.chomp
    valid?
  end

  # checks if user input is valid
  def valid?
    if @user_code.length == 4
      @validated = true
    else
      p 'Invalid Input'
      p 'Enter a code for the cpu to break (Must be 4 digit number)'
      code_maker
    end
  end

  def print_board
    # p "CPU | #{@code[0]}#{@code[1]}#{@code[2]}#{@code[3]} | FEEDBACK"
    p "#{@name} | #{@user_code[0]}#{@user_code[1]}#{@user_code[2]}#{@user_code[3]} | FEEDBACK"
    p '---------------------'
    p 'cpu guesses will go here'
    p '---------------------'
  end

  def play_game
    code_maker
    print_board if @validated == true
  end
end
