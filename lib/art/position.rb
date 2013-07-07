class Art
  class Position
    STARTING_X = 0
    STARTING_Y = 0

    attr_reader :x, :y
    def initialize x=STARTING_X, y=STARTING_Y
      @x = x
      @y = y
    end

    def to_a
      [ x, y ]
    end

    def increment_y
      self.y = y + 1
    end

    def increment_x
      self.x = x + 1
    end

    def ==( other )
      self.x == other.x &&
        self.y == other.y
    end

    private
    attr_writer :x, :y
  end
end
