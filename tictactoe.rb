module TicTacToe
  CHECK = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
end

class Game
  include TicTacToe
  attr_accessor :board, :current_player

  def initialize(p1 = Player.new('X'), p2 = Player.new('O'))
    @current_player = p1
    @players = [p1, p2]
    @board = ['Board', 1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def play
    puts "Let's play TicTacToe"
    show_board
    loop do
      puts "#{@current_player.char} make a move"
      position = gets.chomp.to_i
      player_move(@current_player, @board, position)
      return puts "#{current_player.char} wins!" if winner?(@current_player)
      return puts "It's a draw." if no_empty_spaces?

      switch_players!
    end
  end

  private

  def player_move(player, board, position)
    while (1..9).include? position
      puts "You've picked #{position}"
      if (1..9).include? @board[position]
        board[position] = player.char
        show_board
        position = 0
      else
        puts "This space is not empty\n#{@current_player.char} make a selection!"
        position = gets.chomp.to_i
      end
    end
  end

  def winner?(player)
    CHECK.any? do |row|
      row.all? { |number| @board[number] == player.char }
    end
  end

  def show_board
    puts "#{@board[1..3]}\n#{@board[4..6]}\n#{@board[7..9]}"
  end

  def other_player
    @players.each do |player|
      return player if player != current_player
    end
  end

  def switch_players!
    @current_player = other_player
  end

  def no_empty_spaces?
    @board.all? do |number| 
      !number.is_a? Numeric
    end
  end
end

class Player
  attr_reader :char

  def initialize(char)
    @char = char
  end
end

game = Game.new
game.play
