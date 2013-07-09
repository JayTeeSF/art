class Art
  class Position
    STARTING_X = 0
    STARTING_Y = 0

    attr_reader :x, :y
    def initialize x=STARTING_X, y=STARTING_Y
      @x = x
      @y = y
    end

    def hash
      to_a.hash
    end

    def to_a
      [ x, y ]
    end

    def increment x_diff=nil, y_diff=nil
      self.x = x + x_diff if x_diff
      self.y = y + y_diff if y_diff
    end

    def ==( other )
      self.x == other.x &&
        self.y == other.y
    end

    private
    attr_writer :x, :y
  end
end
