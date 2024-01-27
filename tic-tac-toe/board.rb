class Board
  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @positions = Array.new(9, '-')
    puts display_board(@positions)
  end

  def display_board(positions)
    "\n#{positions[0]} | #{positions[1]} | #{positions[2]} \n" \
    "#{positions[3]} | #{positions[4]} | #{positions[5]} \n" \
    "#{positions[6]} | #{positions[7]} | #{positions[8]} \n\n"
  end

  def update_board(player, move)
    mark = (player == @player_one ? 'X' : 'O')
    player.update_moves(move.to_i - 1)
    @positions[move.to_i - 1] = mark
    puts display_board(@positions)
    # p win?(player)
  end

  def win? (player)
  end
end
