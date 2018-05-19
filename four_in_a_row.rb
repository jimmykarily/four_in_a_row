#!/bin/env ruby

class FourInARow
  def initialize
  end

  def run
    initialize_board
    validate_moves
    calculate_valid_moves
    evaluate_move_scores # Initially random
    play_move
  end
end
