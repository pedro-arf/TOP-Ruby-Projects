class Player
  attr_accessor :points, :name

  def initialize(name)
    @name = name
    @points = 0
  end

  def update_points
    @points += 1
  end
end
