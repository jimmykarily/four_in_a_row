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
      expect(bot.board).to eq(expected_board)
    end

    context "when the board is invalid by us because of filled in column" do
      let(:input) do
        # 7th play on column 1 was invalid
        '{ "type": "move", "moves": [1,1,1,1,1,1,1,1] }'
      end

      it "assigns the :invalid_board" do
        expect(bot.invalid_state).to eq(
          { type: "invalid_me", moves: [1,1,1,1,1,1,1] }
        )

        expect(bot.board).to eq(
          [[1,2,1,2,1,2,1],[],[],[],[],[],[]]
        )
      end
    end

    context "when the board is invalid by us because of non-existent column" do
      let(:input) do
        # We played on non existent column 9
        '{ "type": "move", "moves": [9,1] }'
      end

      it "assigns the :invalid_board" do
        expect(bot.invalid_state).to eq(
          { type: "invalid_me", moves: [9] }
        )

        expect(bot.board).to eq(
          [[],[],[],[],[],[],[]]
        )
      end
    end

    context "when the board is invalid by the opponent" do
      let(:input) do
        # 7th play on column 1 was invalid
        '{ "type": "move", "moves": [1,1,1,1,1,1,1] }'
      end

      it "assigns the :invalid_board" do
        expect(bot.invalid_state).to eq(
          { type: "invalid_opponent", moves: [1,1,1,1,1,1,1] }
        )

        expect(bot.board).to eq(
          [[1,2,1,2,1,2,1],[],[],[],[],[],[]]
        )
      end
    end

    context "when the board is invalid by opponent because of non-existent column" do
      let(:input) do
        # Opponent played on non existent column 9
        '{ "type": "move", "moves": [9] }'
      end

      it "assigns the :invalid_board" do
        expect(bot.invalid_state).to eq(
          { type: "invalid_opponent", moves: [9] }
        )

        expect(bot.board).to eq(
          [[],[],[],[],[],[],[]]
        )
      end
    end
  end
end
