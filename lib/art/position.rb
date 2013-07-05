class Art
  class Position
    STARTING_X = 0
    STARTING_Y = 0

    attr_reader :x, :y
    def initialize x=STARTING_X, y=STARTING_Y
      @x = x
      @y = y
    end

    def ==( other )
      self.x == other.x &&
        self.y == other.y
    end
  end
end
