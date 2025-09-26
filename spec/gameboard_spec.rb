require_relative "../lib/gameboard"

describe GameBoard do
  subject(:gameboard) { described_class.new }

  describe "#make_move" do
    context "when user makes moves" do
      it "returns the symbol when it's a valid move" do
        return_value = gameboard.make_move("X", 0, 0)
        expect(return_value).to eql("X")
      end

      it "returns nil if it's an occupied spot" do
        gameboard.make_move("X", 0, 0)
        return_value = gameboard.make_move("X", 0, 0)
        expect(return_value).to be_nil
      end

      it "returns nil if it's an invalid spot" do
        return_value = gameboard.make_move("X", 5, 5)
        expect(return_value).to be_nil
      end
    end
  end

  describe "#board" do
    context "returns and clears board properly" do
      before do
        gameboard.make_move("X", 0, 0)
        gameboard.make_move("X", 0, 1)
        gameboard.make_move("X", 0, 2)
      end

      it "returns a board with all the moves" do
        current_board = gameboard.board
        expect(current_board).to eq([%w[X X X], ["", "", ""], ["", "", ""]])
      end
    end
  end

  describe "#clear_board" do
    context "returns and clears board properly" do
      before do
        gameboard.make_move("X", 0, 0)
        gameboard.make_move("X", 0, 1)
        gameboard.make_move("X", 0, 2)
      end

      it "clears the board" do
        gameboard.clear_board
        current_board = gameboard.board
        expect(current_board).to eq([["", "", ""], ["", "", ""], ["", "", ""]])
      end
    end
  end
end
