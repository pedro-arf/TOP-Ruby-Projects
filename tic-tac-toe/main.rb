require_relative 'player'
require_relative 'board'
require_relative 'instructions'

module TicTacToe
  def self.init_game
    puts instructions

    puts 'Player 1, enter your name!'
    p_one_name = gets.chomp
    player_one = Player.new(p_one_name)

    puts 'Player 2, enter your name!'
    p_two_name = gets.chomp
    player_two = Player.new(p_two_name)

    board = Board.new(player_one, player_two)

    loop do
      puts "#{p_one_name}, make a move!"
      move = gets.chomp
      board.update_board(player_one, move)
      puts "#{p_two_name}, make a move!"
      move = gets.chomp
      board.update_board(player_two, move)
    end
  end
end

TicTacToe.init_game
