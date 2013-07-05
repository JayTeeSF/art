class Art
  class Segment
    attr_reader :start_point, :finish_point
    def initialize start_point, finish_point
      @start_point = start_point
      @finish_point = finish_point
    end

    def contains?( other )
      (
        (
          other.x >= start_point.x &&
          other.x <= finish_point.x
        ) ||
        (
          other.x < start_point.x &&
          other.x > finish_point.x
        )
      ) &&
      (
        (
          other.y >= start_point.y &&
          other.y <= finish_point.y
        ) ||
        (
          other.y < start_point.y &&
          other.y > finish_point.y
        )
      )
    end
  end
end
