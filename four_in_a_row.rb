#!/bin/env ruby
require 'json'

class FourInARow
  attr_reader :input_json, :parsed_json

  def initialize(input_json)
    @input_json = input_json
    @parsed_json = JSON.parse(input_json)  
  end

  def run
    initialize_board
    validate_moves
    calculate_valid_moves
    evaluate_move_scores # Initially random
    play_move
  end
  
  def initialize_board
    board = []
    7.times { board << []; board }

    parsed_json["moves"].each_with_index do |move, index|
      value = index.odd? ? 2 : 1 # Zero based index
      board[move - 1] = board[move - 1].to_a << value
    end

    board
  end
end
