# Controls the flow of the game
class GameController
  @turns = 1
  @board = GameBoard.new

  def setup_game(player_one = "player1", player_two = "player2")
    @player1 = Player.new(player_one, "X")
    @player2 = Player.new(player_two, "O")
    p board.board
  end
end
