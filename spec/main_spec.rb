describe FourInARow do
  let(:bot) { FourInARow.new(input) }

  describe "#initialize" do
    let(:input) do
    '{ "type": "move", "moves": [1,1,3,2] }'
    end 

    it "parses the JSON" do
      expect(bot.parsed_json["type"]).to eq("move")
      expect(bot.parsed_json["moves"]).to eq([1,1,3,2])
    end
  end

  describe "#initialize_board" do
    let(:input) do
      '{ "type": "move", "moves": [1,1,3,2] }'
    end

    let(:expected_board) do
      board = [[], [], [], [], [], [], []]
      board[0][0] = 1
      board[0][1] = 2
      board[2][0] = 1
      board[1][0] = 2

      board
    end

    it "creates a board based on the input" do
      expect(bot.initialize_board).to eq(expected_board)
    end
  end
end
