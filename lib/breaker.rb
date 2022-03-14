# frozen_string_literal: true

require_relative 'intro'

# User breaks cpu code
class Breaker < Intro
  # initial values
  def initialize
    super
    @name = gets.chomp
    @code = %w[X X X X]
    @randomized = false
    @is_valid = true
    @cpu_code = []
    @guess = []
  end

  # creates a cpu generated random code (all unique values)
  def randomize
    while @cpu_code.length <= 3
      sample = @values.sample
      @cpu_code.push(sample) unless @cpu_code.include?(sample)
    end
    @randomized = true
  end

  # game loop
  def play_game
    print_board
    while @round < 13
      @randomized == true && @is_valid == true ? print_board : randomize
      guess_message
      user_guess(gets.chomp)
      @round += 1 unless @is_valid == false
      winner?
      break if @win == true
    end
    looser? if @win == false
  end

  # prints the gameboard with the users guess and feedback
  def print_board
    # p "CPU | #{@code[0]}#{@code[1]}#{@code[2]}#{@code[3]} | FEEDBACK"
    p "CPU | #{@cpu_code[0]}#{@cpu_code[1]}#{@cpu_code[2]}#{@cpu_code[3]} | FEEDBACK"
    p '---------------------'
    @guess.each_with_index do |combo, index|
      p "#{index + 1})  | #{combo} | B:#{@feedback[index][0]} W:#{@feedback[index][1]}"
    end
    p '---------------------'
  end

  # message before each guess
  def guess_message
    p "ROUND #{@round} / 12"
    p "#{@name}, Enter a 4 digit number 1-6...(NOTE! Each cpu code value is different)"
  end

  # Gets and validates the user's guess
  def user_guess(guess)
    if guess.length == 4
      (@is_valid = true
       give_feedback(guess)
       @guess.push(guess))
    else
      (@is_valid = false
       p 'Invalid Guess')
    end
  end

  # checks if guess includes cpu code values
  def black_checker(guess)
    guess.to_s.chars.uniq.each do |i|
      @cpu_code.each do |j|
        @black_white[0] += 1 if i == j
      end
    end
  end

  # checks if guess has correct value and correct index
  def white_checker(guess)
    guess.to_s.chars.uniq.each_with_index do |i, i_index|
      @cpu_code.each_with_index do |j, j_index|
        if i == j && i_index == j_index
          @black_white[1] += 1
          @black_white[0] -= 1 unless @black_white[0].zero?
        end
      end
    end
  end

  # uses white/black_checker to give user feedback
  def give_feedback(guess)
    @black_white = [0, 0]
    black_checker(guess)
    white_checker(guess)
    @feedback.push(@black_white)
  end

  # determines if user has won
  def winner?
    return unless @feedback.include?([0, 4])

    p "#{@name} Wins!"
    @win = true
  end

  def looser?
    p 'CPU Wins!'
  end
end
