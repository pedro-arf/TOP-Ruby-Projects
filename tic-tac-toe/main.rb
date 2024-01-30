require_relative 'player'
require_relative 'board'
require_relative 'instructions'

module TicTacToe
  def self.init_game
    puts instructions

    puts 'Player 1, enter your name!'
    player_one = register_player('X')

    puts 'Player 2, enter your name!'
    player_two = register_player('O')

    game_loop(player_one, player_two)
  end

  def self.register_player(mark)
    player_name = gets.chomp
    Player.new(player_name, mark)
  end

  def self.game_loop(player_one, player_two)
    loop do
      board = Board.new(player_one, player_two)
      loop do
        player_one_win = board.make_move(player_one)
        break if player_one_win

        player_two_win = board.make_move(player_two)
        break if player_two_win
      end

      player_one.display_wins
      player_two.display_wins

      break unless rematch?
    end
  end

  def self.rematch?
    while true
      puts "\nRematch?\nYes: 1\nNo: 2\n"
      rematch = gets.chomp.to_i

      break if rematch == 1 || rematch == 2

      puts "\nInvalid command! Please select '1' for a rematch or '2' to end the game!!\n\n"
    end

    rematch == 1
  end
end

TicTacToe.init_game
