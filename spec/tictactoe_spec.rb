require './tictactoe'

describe Game do
  let(:player) { double('player', char: 'x') }
  subject(:game) { described_class.new(player, player) }
  describe '#initialize' do
    # init method does not need to be tested
  end

  describe '#play' do
    # play method -> mainly puts test methods inside play
    subject(:game) { described_class.new }
    context 'when there are not empty spaces' do
      before do
        allow(game).to receive(:no_empty_spaces?).and_return(false, false, false, true)
        allow(game).to receive(:puts)
      end
      it 'returns a draw' do
        draw = 'It\'s a draw.'
        expect(game).to receive(:puts).with(draw).exactly(1).time
        game.play
      end
    end

    context 'when a winner is decided' do
      context 'current player is x' do
        before do
          allow(game).to receive(:winner?).and_return(true)
          allow(game).to receive(:puts)
        end

        it 'returns X player wins' do
          message = 'X wins!'
          expect(game).to receive(:puts).with(message).at_least(:once)
          game.play
        end
      end
      context 'current player is 0' do
        before do
          allow(game).to receive(:winner?).and_return(false, true)
          allow(game).to receive(:puts)
        end

        it 'returns O player wins' do
          message = 'O wins!'
          expect(game).to receive(:puts).with(message).once
          game.play
        end
      end
    end
  end

  describe '#player_move' do

    context 'when given a valid input' do
      it 'changes the board' do
        expect(game).to receive(:puts)
        position = 1
        expect { game.player_move(player, position) }.to(change { game.board })
      end
    end

    context 'when not given a valid input' do
      it 'returns nil' do
        position = 10
        result = game.player_move(player, position)
        expect(result).to be_nil
      end
    end
  end

  describe '#winner?' do
    context 'board has a three x\'s in 2, 5 and 8' do
      before do
        game.board = ['Board', 1, 'x', 3, 4, 'x', 6, 7, 'x', 9]
      end

      it 'is a winner' do
        expect(game).to be_winner
      end
    end

    context 'board has a six x\'s in 1, 2, 4, 6, 8 and 9' do
      before do
        game.board = ['Board', 'x', 'x', 3, 'x', 5, 'x', 7, 'x', 'x']
      end

      it 'is not a winner' do
        expect(game).to_not be_winner
      end
    end
  end

  describe '#show_board' do
    # method with only puts
  end

  describe '#other_player' do
    subject(:other_game) { described_class.new('x', 'o')}

    it 'returns the other player' do
      result = other_game.other_player
      expect(result).to eq('o')
    end

    it 'does not update current player' do
      current_player = other_game.instance_variable_get(:@current_player)
      expect(current_player).to eq('x')
    end
  end

  describe '#switch_players!' do
    subject(:switch_game) { described_class.new('x', 'o')}
    it 'switches players' do
      result = switch_game.switch_players!
      expect(result).to eq('o')
    end

    it 'updates current player' do
      switch_game.switch_players!
      current_player = switch_game.instance_variable_get(:@current_player)
      expect(current_player).to eq('o')
    end
  end

  describe '#no_empty_spaces?' do
    context 'when the board is full' do
      before do
        game.board = %w[Board x x x x x x x x x]
      end
      it 'to have no empty spaces' do
        expect(game).to be_no_empty_spaces
      end
    end

    context 'when the board is not full' do
      it 'it to have no empty spaces' do
        expect(game).to_not be_no_empty_spaces
      end
    end
  end
end

describe Player do
  describe '#initalize' do
    # init method does not need to be tested
  end
end
