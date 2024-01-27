# Registers players and records their moves
class Player
  attr_accessor :moves

  def initialize(name)
    @name = name
    @moves = []
  end

  def update_moves(move)
    @moves << move
  end
end
