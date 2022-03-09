# frozen_string_literal: true

require_relative 'intro'
require_relative 'breaker'
require_relative 'maker'

start = Breaker.new
start.play_game
