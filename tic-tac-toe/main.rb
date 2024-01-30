require_relative 'player'
require_relative 'board'
require_relative 'instructions'

module TicTacToe
  def self.init_game
    puts instructions

    player_one_mark = 'X'
    player_two_mark = 'O'

    puts 'Player 1, enter your name!'
    player_one_name = gets.chomp
    player_one = Player.new(player_one_name, player_one_mark)

    puts 'Player 2, enter your name!'
    player_two_name = gets.chomp
    player_two = Player.new(player_two_name, player_two_mark)

    game_loop(player_one, player_two)
  end

  def self.game_loop(player_one, player_two)
    loop do
      board = Board.new(player_one, player_two)

      loop do
        player_one_win = board.make_move(player_one)
        break unless player_one_win == false

        player_two_win = board.make_move(player_two)
        break unless player_two_win == false
      end

      puts "#{player_one.name}'s wins: #{player_one.wins}\n" \
           "#{player_two.name}'s wins: #{player_two.wins}\n\n"

      while true
        puts "Rematch?\nYes: 1\nNo: 2\n"
        rematch = gets.chomp

        break if rematch == '1' || rematch == '2'

        puts "\nInvalid command! Please select '1' for a rematch or '2' to end the game!!\n\n"
      end

      if rematch == '1' then next
      elsif rematch == '2' then break
      end
    end
  end
end

TicTacToe.init_game
