require_relative "game_win_checker"
require_relative "gameboard"
require_relative "player"
# Controls the flow of the game
class Game
  include GameWinChecker

  def initialize
    @current_board = GameBoard.new
    @turns = 1
    @game_finished = false
  end

  def setup_game
    first_player = players_name_input("First Player Name:")
    second_player = players_name_input("Second Player Name:")
    @player1 = Player.new(first_player.empty? ? "1" : first_player, "X")
    @player2 = Player.new(second_player.empty? ? "2" : second_player, "O")
    display_board
    play_round
  end

  private

  def new_game
    @current_board.clear_board
    @turns = 1
    @game_finished = false
    play_round
  end

  def play_round
    return "Game Over" if @game_finished

    current_player = @turns.odd? ? @player1 : @player2

    puts "Player #{current_player.name} turn:"
    current_move = [5, 5]
    loop do
      current_move = players_play_input
      break if @current_board.make_move(current_player.symbol, current_move[0], current_move[1])
    end

    @turns += 1
    return game_over(current_player.name) if check_win?(current_move, current_player.symbol, @current_board.board)

    @game_finished = true if @turns == 10
    display_board
    play_round
  end

  def game_over(winners_name)
    puts "winner is #{winners_name}"
    @game_finished = true
    display_board
    new_game if players_continue_input?
  end

  def players_name_input(message)
    puts message
    gets.chomp.strip
  end

  def display_board
    puts @current_board.board.map(&:inspect)
  end

  def players_play_input
    next_play = []
    next_play = gets.chomp.split(",") until next_play.all? { |num| %w[0 1 2].include?(num) } && next_play.size == 2
    next_play.map(&:to_i)
  end

  def players_continue_input?
    puts "Do you wish to play again?"
    player_answer = gets.chomp.strip.downcase
    return true if %w[y yes yup].include?(player_answer)

    false
  end
end
