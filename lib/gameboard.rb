# Creates an instance with a board as variable and 3 methods
# make a move on the board/clear board/get state of board
class GameBoard
  def initialize
    @my_board = Array.new(3) { Array.new(3, "") }
  end

  def make_move(symbol, line, column)
    return unless @my_board.dig(line, column) && @my_board[line][column].empty?

    @my_board[line][column] = symbol
  end

  def clear_board
    @my_board = @my_board.each { |spot| spot.fill("") }
  end

  def board
    @my_board.map(&:itself)
  end
end
