require_relative 'computer'
require_relative 'player'
require_relative 'board'
require_relative 'instructions'

module Mastermind
  def self.init_game
    puts instructions
    puts 'Enter your name!'
    name = gets.chomp
    player = Player.new(name)
    computer = Computer.new

    puts "\nHow many games do you wish to play?\n"

    num_of_games = set_number_of_games
    play_games(num_of_games, player, computer)
    check_winner(player, computer)
  end

  def self.set_number_of_games
    while true
      begin
        num_of_games = Integer(gets.chomp)

        break if num_of_games.even?

        puts 'Please select an even number of games! (ex.: 4)'
      rescue ArgumentError, TypeError
        puts 'Please select an even number of games! (ex.: 4)'
      end
    end
    num_of_games
  end

  def self.play_games(num_of_games, player, computer)
    num_of_games.to_i.times do
      computer.codemaker = true
      new_game(player, computer)

      computer.codemaker = false
      new_game(player, computer)
    end
  end

  def self.check_winner(player, computer)
    puts "\n#{player.name} #{player.points} - #{computer.points} AI\n\n"
    if player.points > computer.points
      puts "CONGRATS #{player.name}!! You have WON the game!!"
    elsif player.points == computer.points
      puts 'The game has ended with a DRAW!!'
    else
      puts "YOU'VE LOST, #{player.name}!! Better luck next time!!"
    end
  end

  def self.new_game(player, computer)
    board = Board.new(player, computer)
    board.start_game
  end
end

Mastermind.init_game
