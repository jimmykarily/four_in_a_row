describe FourInARow do
  let(:empty_board) do
    board = []
    7.times do |col|
      board[col] = []
      6.times do
        board[col] << 0
      end
    end

    board.to_s
  end

  describe "#initialize_board" do
    let(:input) do
      { type: "move", moves: [1,1,3,2] }
    end
    let(:bot) { FourInARow.new(input) }

    let(:expected_board) do
      board = empty_board
      board[0][0] = 1
      board[0][1] = 2
      board[2][0] = 1
      board[1][0] = 2
    end

    it "creates a board based on the input" do
      expect(bot.initialize_board).to eq(expected_board)
    end
  end
end
