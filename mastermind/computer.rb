class Computer
  attr_accessor :points, :codemaker

  def initialize
    @codemaker = false
    @points = 0
  end

  def update_points
    @points += 1
  end
end
