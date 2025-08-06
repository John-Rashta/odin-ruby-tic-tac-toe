# Creates an instance with a board as variable and 3 methods
# make a move on the board/clear board/get state of board
class GameBoard
  @board = Array.new(3) { Array.new(3, "s") }

  def make_move(symbol, line, column)
    return unless board[line][column].empty?

    board[line][column] = symbol
  end

  def clear_board
    @board = board.each { |spot| spot.fill("") }
  end

  def board
    board.map(&:itself)
  end
end
