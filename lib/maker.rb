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
    @cpu_guess = []
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
      p "#{index + 1})  | #{combo.join('')} | B:#{@feedback[index][0]} W:#{@feedback[index][1]}"
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
    first_guess
    give_feedback(@cpu_guess)
    @guess_list.push(@cpu_guess)
    # cpu_message
    p @guess_list
  end

  # generates first random answer
  def first_guess
    while @cpu_guess.length <= 3
      sample = @values.sample
      @cpu_guess.push(sample) unless @cpu_guess.include?(sample)
    end
  end

  # # -------------------------------------------------------------------------------
  # # checks if value needs to be pushed out and in with a new unique sample
  # # def inlcudes_value?
  # #   return if @guess_list.empty?

  # #   @cpu_guess.each do |i|
  # #     @cpu_guess[@cpu_guess.find_index(i)] = sampler unless @user_code.include?(i) || @black_white[0] == 4
  # #   end
  # # end

  # def inlcudes_value?
  #   return if @guess_list.empty?

  #   i = 0
  #   while i < @cpu_guess.length
  #     @cpu_guess[i] = sampler
  #     i += 1
  #   end
  # end
  # # ------------------------WORK ON THIS^^^------------------------------------------

  # def sampler
  #   sample = @values.sample
  #   return sample unless @guess_list.each { |value| value.include?(sample) }
  # end

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

  def cpu_message
    p "CPU: I think your code is #{@cpu_guess.join('')}...(Press enter to continue)"
  end
end
