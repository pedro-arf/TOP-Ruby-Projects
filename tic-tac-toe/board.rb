class Board
  WINNING_COMBINATIONS = [
    [0, 1, 2], [0, 4, 8], [0, 3, 6], [3, 4, 5], [6, 7, 8], [1, 4, 7], [2, 5, 8], [2, 4, 6]
  ].freeze

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @positions = Array.new(9, '-')
    display_board(@positions)
  end

  def display_board(positions)
    puts "\n#{positions[0]} | #{positions[1]} | #{positions[2]} \n" \
         "#{positions[3]} | #{positions[4]} | #{positions[5]} \n" \
         "#{positions[6]} | #{positions[7]} | #{positions[8]} \n\n"
  end

  def make_move(player)
    puts "#{player.name}, make a move!"
    win = false
    loop do
      move = gets.chomp.to_i
      if !move.between?(1, 9)
        puts 'Invalid move! Select a number between 1 and 9!'
      elsif @positions[move - 1] != '-'
        puts 'Invalid move! That spot is already taken!'
      else
        win = update_board(player, move)
        break
      end
    end
    win
  end

  private

  def update_board(player, move)
    @positions[move - 1] = player.mark
    display_board(@positions)
    if win?(player.mark)
      announce_winner(player)
      player.update_wins
      true
    else
      false
    end
  end

  def win?(mark)
    WINNING_COMBINATIONS.any? do |combination|
      combination.all? { |position| @positions[position] == mark }
    end
  end

  def announce_winner(player)
    puts "#{player.name} has won the game!!\n\n"
  end
end
