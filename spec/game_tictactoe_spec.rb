require_relative "../lib/game"
require_relative "../lib/player"

describe Game do
  subject(:game) { described_class.new }
  describe "#setup_game" do
    context "sets players properly" do
      before do
        allow(game).to receive(:players_name_input).and_return("John", "Alice")
        allow(game).to receive(:display_board)
        allow(game).to receive(:play_round)
      end

      it "sets player 1 as John" do
        game.setup_game
        first_player = game.instance_variable_get(:@player1)
        expect(first_player.name).to eql("John")
      end

      it "set player 2 as Alice" do
        game.setup_game
        second_player = game.instance_variable_get(:@player2)
        expect(second_player.name).to eql("Alice")
      end
    end

    context "sets players to default if no name given" do
      before do
        allow(game).to receive(:players_name_input).and_return("", "")
        allow(game).to receive(:display_board)
        allow(game).to receive(:play_round)
      end

      it "sets player 1 as 1" do
        game.setup_game
        first_player = game.instance_variable_get(:@player1)
        expect(first_player.name).to eql("1")
      end

      it "set player 2 as 2" do
        game.setup_game
        second_player = game.instance_variable_get(:@player2)
        expect(second_player.name).to eql("2")
      end
    end
  end

  describe "#game_over" do
    context "basic functionality with player continue input being yes" do
      before do
        allow(game).to receive(:puts).once
        allow(game).to receive(:display_board)
        allow(game).to receive(:new_game)
        allow(game).to receive(:players_continue_input?).and_return(true)
      end

      it "sets game_finished to true" do
        game.game_over("Odin")
        finished_value = game.instance_variable_get(:@game_finished)
        expect(finished_value).to eq(true)
      end

      it "calls display_board" do
        expect(game).to receive(:display_board).once
        game.game_over("Odin")
      end

      it "calls new_game when continue method returns true" do
        expect(game).to receive(:new_game).once
        game.game_over("Odin")
      end
    end

    context "player continue input is no" do
      before do
        allow(game).to receive(:puts).once
        allow(game).to receive(:display_board)
        allow(game).to receive(:new_game)
        allow(game).to receive(:players_continue_input?).and_return(false)
      end

      it "does not call new_game when return is false" do
        expect(game).to_not receive(:new_game)
        game.game_over("Odin")
      end
    end
  end

  describe "game_win_checker" do
    let(:player_symbol) { "X" }
    let(:fake_board) { [["", "", ""], ["", player_symbol, ""], ["", player_symbol, player_symbol]] }
    describe "#diagonal?" do
      it "returns true if move is one of the corners" do
        diagonal_move = game.diagonal?([0, 0])
        expect(diagonal_move).to eq(true)
      end

      it "returns true if move is center" do
        diagonal_move = game.diagonal?([1, 1])
        expect(diagonal_move).to eq(true)
      end

      it "returns false if move is none of the above" do
        diagonal_move = game.diagonal?([1, 0])
        expect(diagonal_move).to eq(false)
      end
    end

    describe "#vertical_win?" do
      it "returns true if the move is a vertical win" do
        fake_board[0][1] = player_symbol
        possible_win = game.vertical_win?([0, 1], player_symbol, fake_board)
        expect(possible_win).to eq(true)
      end

      it "returns false if the move isn't a vertical win" do
        fake_board[1][2] = player_symbol
        possible_win = game.vertical_win?([1, 2], player_symbol, fake_board)
        expect(possible_win).to eq(false)
      end
    end

    describe "#horizontal_win?" do
      it "returns true if the move is a horizontal win" do
        fake_board[2][0] = player_symbol
        possible_win = game.horizontal_win?([2, 0], player_symbol, fake_board)
        expect(possible_win).to eq(true)
      end

      it "returns false if the move isn't a horizontal win" do
        fake_board[1][2] = player_symbol
        possible_win = game.horizontal_win?([1, 2], player_symbol, fake_board)
        expect(possible_win).to eq(false)
      end
    end

    describe "#diagonal_win?" do
      it "returns true if the move is a diagonal win" do
        fake_board[0][0] = player_symbol
        possible_win = game.diagonal_win?([0, 0], player_symbol, fake_board)
        expect(possible_win).to eq(true)
      end

      it "returns false if the move isn't a diagonal win" do
        fake_board[2][0] = player_symbol
        possible_win = game.diagonal_win?([2, 0], player_symbol, fake_board)
        expect(possible_win).to eq(false)
      end
    end
  end

  describe "#play_round" do
    let(:player1) { instance_double(Player, { name: "John", symbol: "X" }) }
    let(:player2) { instance_double(Player, { name: "Alice", symbol: "O" }) }

    before do
      allow(game).to receive(:display_board)
      allow(game).to receive(:game_over)
      allow(game).to receive(:check_win?).and_return(true)
      allow(game).to receive(:players_play_input).and_return([2, 2], [1, 1])
      game.instance_variable_set(:@player1, player1)
      game.instance_variable_set(:@player2, player2)
      allow(game).to receive(:puts)
    end
    context "calling it when game is already finished" do
      it "returns Game Over when game is already finished" do
        game.instance_variable_set(:@game_finished, true)
        over_message = game.play_round
        expect(over_message).to eql("Game Over")
      end
    end

    context "loop works as intended" do
      it "breaks the loop with correct input" do
        expect(game).to receive(:players_play_input).once
        game.play_round
      end
    end

    context "loop continues if first guess is wrong" do
      before do
        allow(game).to receive(:players_play_input).and_return([6, 6], [2, 2])
      end

      it "loop runs twice if first guess is invalid" do
        expect(game).to receive(:players_play_input).twice
        game.play_round
      end
    end

    context "turns change with each round" do
      it "increases turns by 1" do
        expect { game.play_round }.to change { game.instance_variable_get(:@turns) }.by(1)
      end
    end

    it "returns game over when checkwin returns true" do
      expect(game).to receive(:game_over).once
      game.play_round
    end

    context "when game isn't over" do
      before do
        allow(game).to receive(:check_win?).and_return(false, true)
      end

      it "calls game over only 1 time if first iteration has no win" do
        expect(game).to receive(:game_over).once
        game.play_round
      end

      it "does not set game to finished if round isn't 10" do
        game.play_round
        game_state = game.instance_variable_get(:@game_finished)
        expect(game_state).to eq(false)
      end

      it "sets game to finished if turn is 10" do
        game.instance_variable_set(:@turns, 9)
        game.play_round
        game_state = game.instance_variable_get(:@game_finished)
        expect(game_state).to eq(true)
      end
    end
  end
end
