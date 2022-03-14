# frozen_string_literal: true

require_relative 'intro'

# User creates code to break
class Maker < Intro
  def initialize
    super
    @name = gets.chomp
    p 'Enter a code for the cpu to break (Must be 4 digit number between 1 - 6)'
    @user_code = []
    @guess_list = []
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
    p "#{@name} | #{@user_code} | FEEDBACK"
    p '---------------------'
    @guess_list.each_with_index do |combo, index|
      p "#{index + 1})  | #{combo.join('')} | B:#{@feedback[index][0]} W:#{@feedback[index][1]}"
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
    inlcudes_value?(guess) unless @feedback.any? { |black| black[0] == 4 } || @guess_list.empty?
    shuffler(guess) if guess.each { |value| @user_code.include?(value) }
    give_feedback(guess)
    new_guess = []
    guess.each { |i| new_guess.push(i) }
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
    @values.each { |num| avalible_values.push(num) unless @guess_list.any? { |combo| combo.include?(num) } }

    i = 0
    while i < guess.length
      unless @user_code.include?(guess[i])
        guess[i] = avalible_values.uniq.sample
        break
      end
      i += 1
    end
  end

  # checks if guess includes cpu code values
  def black_checker(guess)
    guess.each do |i|
      @user_code.to_s.chars.uniq.each do |j|
        @black_white[0] += 1 if i == j
      end
    end
  end

  # checks if guess has correct value and correct index
  def white_checker(guess)
    guess.each_with_index do |i, i_index|
      @user_code.to_s.chars.uniq.each_with_index do |j, j_index|
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
end

def winner?(guess)
  if guess.join('') == @user_code
    @win = true
    print_board
    p 'CPU Wins!'
  end

  p "#{@name} Wins!" if @round == 12 && @win == false
end
