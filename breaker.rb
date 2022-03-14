# frozen_string_literal: true

require_relative 'intro'

# User breaks cpu code
class Breaker < Intro
  def initialize
    super
    @name = gets.chomp
    # @code_veil = %w[X X X X]
    @randomized = false
    @is_valid = true
    @master_code = []
    @guess_list = []
  end

  # creates a cpu generated random code (all unique values)
  def randomize
    while @master_code.length <= 3
      sample = @values.sample
      @master_code.push(sample) unless @master_code.include?(sample)
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
    # p "CPU | #{@code_veil.join('')} | CLUES"
    p "CPU | #{@master_code.join('')} | CLUES"
    p '---------------------'
    @guess_list.each_with_index do |combo, index|
      p "#{index + 1})  | #{combo} | B:#{@clue_list[index][0]} W:#{@clue_list[index][1]}"
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
       give_clue(guess)
       @guess_list.push(guess))
    else
      (@is_valid = false
       p 'Invalid Guess')
    end
  end

  # checks if guess includes cpu code values
  def black_checker(guess)
    guess.to_s.chars.uniq.each do |i|
      @master_code.each do |j|
        @clue[0] += 1 if i == j
      end
    end
  end

  # checks if guess has correct value and correct index
  def white_checker(guess)
    guess.to_s.chars.uniq.each_with_index do |i, i_index|
      @master_code.each_with_index do |j, j_index|
        if i == j && i_index == j_index
          @clue[1] += 1
          @clue[0] -= 1 unless @clue[0].zero?
        end
      end
    end
  end

  # uses white/black_checker to give user feedback
  def give_clue(guess)
    @clue = [0, 0]
    black_checker(guess)
    white_checker(guess)
    @clue_list.push(@clue)
  end

  # determines if user has won
  def winner?
    return unless @clue_list.include?([0, 4])

    p "#{@name} Wins!"
    @win = true
  end

  def looser?
    p 'CPU Wins!'
  end
end
