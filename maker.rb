# frozen_string_literal: true

require_relative 'intro'

# User creates code to break
class Maker < Intro
  def initialize
    super
    @name = gets.chomp
    p 'Enter a code for the cpu to break (Must be 4 digit number between 1 - 6, all unique values)'
    @master_code = []
    @guess_list = []
    @is_valid = false
  end

  # user enters code for cpu to break
  def code_maker
    @master_code = gets.chomp
    valid?
  end

  # checks if user input is valid
  def valid?
    if @master_code.length == 4
      @is_valid = true
    else
      p 'Invalid Input'
      p 'Enter a code for the cpu to break (Must be 4 digit number between 1 - 6, all unique values)'
      code_maker
    end
  end

  def print_board
    p "#{@name} | #{@master_code} | CLUES"
    p '---------------------'
    @guess_list.each_with_index do |combo, index|
      p "#{index + 1})  | #{combo.join('')} | B:#{@clue_list[index][0]} W:#{@clue_list[index][1]}"
    end
    p '---------------------'
  end

  # game loop
  def play_game
    code_maker
    starting_guess = random_guess
    while @is_valid == true && @round < 13
      print_board
      p "ROUND #{@round} / 12 (Click ENTER to continue)"
      gets.chomp
      choice_generator(starting_guess)
      break if @win == true

      @round += 1
    end
  end

  # creates random cpu guess to start with
  def choice_generator(guess)
    inlcudes_value?(guess) unless @clue_list.any? { |clue| clue[0] == 4 } || @guess_list.empty?
    shuffler(guess) if guess.each { |value| @master_code.include?(value) }
    give_clue(guess)
    new_guess = []
    guess.each { |value| new_guess.push(value) }
    @guess_list.push(new_guess)
    winner?(guess)
  end

  def shuffler(guess)
    guess.shuffle! until @guess_list.none? { |combo| combo == guess }
  end

  # generates first random answer
  def random_guess
    the_guess = []
    while the_guess.length <= 3
      sample = @values.sample
      the_guess.push(sample) unless the_guess.include?(sample)
    end
    the_guess
  end

  # Checks 1 number at a time and subs it with a value not used yet according to the @guess_list
  def inlcudes_value?(guess)
    avalible_values = []
    @values.each { |value| avalible_values.push(value) unless @guess_list.any? { |combo| combo.include?(value) } }

    i = 0
    while i < guess.length
      unless @master_code.include?(guess[i])
        guess[i] = avalible_values.uniq.sample
        break
      end
      i += 1
    end
  end

  # checks if guess includes cpu code values
  def black_checker(guess)
    guess.each do |i|
      @master_code.to_s.chars.uniq.each do |j|
        @clue[0] += 1 if i == j
      end
    end
  end

  # checks if guess has correct value and correct index
  def white_checker(guess)
    guess.each_with_index do |i, i_index|
      @master_code.to_s.chars.uniq.each_with_index do |j, j_index|
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
end

def winner?(guess)
  if guess.join('') == @master_code
    @win = true
    print_board
    p 'CPU Wins!'
  end

  p "#{@name} Wins!" if @round == 12 && @win == false
end
