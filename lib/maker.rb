# frozen_string_literal: true

require_relative 'intro'

# User creates code to break
class Maker < Intro
  def initialize
    super
    @name = gets.chomp
    p 'Enter a code for the cpu to break (Must be 4 digit number)'
    @user_code = []
    @guess_list = []
    @cpu_guess = nil
    @is_valid = false
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
    @guess_list.each_with_index do |combo, index|
      p "#{index + 1})  | #{combo.join('')} | Feedback"
    end
    p '---------------------'
  end

  # game loop
  def play_game
    code_maker
    while @is_valid == true && @round < 13
      print_board
      p "ROUND #{@round} / 12"
      choice_generator
      gets.chomp
      @round += 1
    end
  end

  # creates random cpu guess to start with
  def choice_generator
    @cpu_guess = []
    while @cpu_guess.length <= 3
      sample = @values.sample
      @cpu_guess.push(sample) unless @cpu_guess.include?(sample)
    end
    @guess_list.push(@cpu_guess)
    cpu_message
  end

  def cpu_message
    p "CPU: I think your code is #{@cpu_guess.join('')}...(Press enter to continue)"
  end
end
