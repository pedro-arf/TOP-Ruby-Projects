class Player
  attr_accessor :name, :mark, :wins

  def initialize(name, mark)
    @name = name
    @mark = mark
    @wins = 0
  end

  def update_wins
    @wins += 1
  end

  def display_wins
    puts "#{@name}'s wins: #{@wins}\n"
  end
end
