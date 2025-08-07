# module with methods to check all 3 types of possible wins
# diagonal/vertical/horizontal
module GameWinChecker
  def check_win?(last_move, player_symbol, board)
    if diagonal_win?(last_move, player_symbol, board) ||
       horizontal_win?(last_move, player_symbol, board) ||
       vertical_win?(last_move, player_symbol, board)
      return true
    end

    false
  end

  private

  def diagonal_win?(last_move, player_symbol, board)
    return false unless diagonal?(last_move)
    return false if board[1][1] != player_symbol
    if  (board[0][0] == board[1][1] && board[1][1] == board[2][2]) ||
        (board[0][2] == board[1][1] && board[1][1] == board[2][0])
      return true
    end

    false
  end

  def horizontal_win?(last_move, player_symbol, board)
    line, _column = last_move
    if board[line][0] == board[line][1] && board[line][1] == board[line][2] &&
       board[line][0] == player_symbol
      return true
    end

    false
  end

  def vertical_win?(last_move, player_symbol, board)
    _line, column = last_move
    if board[0][column] == board[1][column] && board[1][column] == board[2][column] &&
       board[0][column] == player_symbol
      return true
    end

    false
  end

  def diagonal?(last_move)
    line, column = last_move
    return false if last_move.include?(1) && line != column

    true
  end
end
