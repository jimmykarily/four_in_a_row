#!/bin/env ruby
require 'json'

class FourInARow
  attr_reader :input_json, :parsed_json, :board, :invalid_state

  def initialize(input_json)
    @input_json = input_json
    @parsed_json = JSON.parse(input_json)  

    initialize_board
  end

  def run
    validate_moves
    calculate_valid_moves
    evaluate_move_scores # Initially random
    play_move
  end
  
  def initialize_board
    @board = []
    7.times { @board << []; @board }

    # If last player played an even move, then we play the odd moves so we
    # are player 1.
    our_player = parsed_json["moves"].length.even? ? 1 : 2

    parsed_json["moves"].each_with_index do |move, index|
      current_player = index.odd? ? 2 : 1 # Zero based index

      # Detect invalid move on non-existent column
      if move < 0 || move > 7
        @invalid_state = {
          type: our_player == current_player ? "invalid_me" : "invalid_opponent",
          moves: parsed_json["moves"][0..index]
        }

        return false
      end

      @board[move - 1] = @board[move - 1].to_a << current_player

      # Detect invalid move on filled column
      if @board[move - 1].length > 6
        @invalid_state = {
          type: our_player == current_player ? "invalid_me" : "invalid_opponent",
          moves: parsed_json["moves"][0..index]
        }

        return false
      end
    end

    return true
  end
end
