class Art
  class Canvas
    BLANK = " "
    DEFAULT_WIDTH = 80
    DEFAULT_HEIGHT = 25
    MIN_Y = 0
    MIN_X = 0

    attr_reader :width, :height, :pos
    attr_reader :pos, :matrix, :flipped_matrix
    def initialize width=nil, height=nil
      @width = ( width || DEFAULT_WIDTH ) - 1    # x ->
      @height = ( height || DEFAULT_HEIGHT ) - 1 # y
                                                 # |
                                                 # v
      clear
    end

    def min_x
      MIN_X
    end

    def min_y
      MIN_Y
    end

    def max_y
      height
    end

    def max_x
      width
    end

    def render(to=STDOUT)
      matrix_rows do |row|
        to.print row.join
      end
      return nil
    end

    def clear
      unless width && width > MIN_X
        raise( RuntimeError, "Bad width value: #{width.inspect}" )
      end
      @flipped_matrix = []
      (MIN_Y..height).each do |row_id|
        flipped_matrix[row_id] = Array.new( width, BLANK )
      end

      @matrix = []
      (MIN_X..width).each do |col_id|
        matrix[col_id] = Array.new( height, BLANK )
      end
    end

    def draw pixel, at
      flipped_matrix[at.y][at.x] = pixel
      matrix[at.x][at.y] = pixel
    end

    def points_on_line( start_position, destination_position )
      results = []
      walk_cells do |x, y|
        possible_point = Position.new(x, y)

        dot_product_result = dot_product( start_position, possible_point, destination_position )
        squared_length_ba_result = squared_length_ba( start_position, destination_position )
        if 0 == cross_product( start_position, possible_point, destination_position ) &&
          dot_product_result >= 0 &&
          dot_product_result <= squared_length_ba_result

          results << possible_point
        end
      end

      results
    end


    private

    def walk_cells(&block)
      (min_x..max_x).each do |x|
        (min_y..max_y).each do |y|
          block.call( x, y )
        end
      end
    end

    def matrix_rows(&block)
      unless block_given?
        raise( RuntimeError, "missing matrix walker" )
      end
      flipped_matrix.each do |row|
        block.call(row)
      end
    end

    # http://stackoverflow.com/questions/328107/how-can-you-determine-a-point-is-between-two-other-points-on-a-line-segment
    def squared_length_ba a, b
      (b.x - a.x)*(b.x - a.x) + (b.y - a.y)*(b.y - a.y)
    end

    def dot_product a, b, c
      (c.x - a.x) * (b.x - a.x) + (c.y - a.y)*(b.y - a.y)
    end

    def cross_product a, b, c
      (c.y - a.y) * (b.x - a.x) - (c.x - a.x) * (b.y - a.y)
    end
  end
end
