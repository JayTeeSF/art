require_relative "art/version"
require_relative "art/canvas"
require_relative "art/position"
# art = Art.new
# or
# width = height = 100
# canvas = Canvas.new( width, height )
# art = Art.new( canvas )
class Art
  START_POSITION = Position.new
  DEFAULT_CANVAS = Canvas.new
  DEFAULT_CHAR = '.'

  attr_reader :current_position
  def initialize(canvas=DEFAULT_CANVAS)
    @canvas = canvas
    reset_position
  end

  #FIXME remove this hackery
  FOO = File.new("./foo.canvas", "w+")
  def display(to=nil)
    to = STDOUT if to.nil?
    to = FOO if to == :foo

    canvas.render to
  end

  def move_to x, y
    if !within_bounds?( x, y )
      raise RuntimeError, "Out of bounds: #{x.inspect}, #{y.inspect}"
    end

    self.current_position = Position.new( x, y )
  end

  def line_to x, y, char=DEFAULT_CHAR
    if !within_bounds?( x, y )
      raise RuntimeError, "Out of bounds: #{x.inspect}, #{y.inspect}"
    end

    destination_position = Position.new(x, y)
    canvas.points_on_line( current_position, destination_position ).each do |at|
      draw( char, at )
    end
    self.current_position = destination_position
  end

  def write( message=DEFAULT_CHAR, at=current_position )
    type( message, nil, at )
  end

  def type( message=DEFAULT_CHAR, pace=0.3, at=current_position )
   message.split(//).each do |char|
     at.increment_x
     last unless within_bounds?( *at.to_a )
     draw(char, at)
     display
     sleep( pace ) if pace
   end
  end

  def draw( pixel, at=current_position )
    canvas.draw( pixel, at )
  end

  def live
    yield(self) if block_given?
  end

  def clear
    canvas.clear
    reset_position
  end

  # height = 4
  # width = 2
  # start in lower-left
  def triangle(start_x, start_y, width, height)
     move_to(start_x, start_y)
     line_to(start_x + 2 * width, start_y)
     line_to(start_x + width, start_y - height)
     line_to(start_x, start_y)
  end
  def square(start_x, start_y, width, height)
     move_to(start_x, start_y)
     line_to(start_x + width, start_y)
     line_to(start_x + width,start_y + height)
     line_to(start_x,start_y + height)
     line_to(start_x, start_y)
  end

  private
  attr_writer :current_position
  attr_accessor :canvas

  def reset_position
    self.current_position = START_POSITION
  end

  def within_bounds?( x, y )
    canvas.min_x <= x &&
    x <= canvas.max_x &&
    canvas.min_y <= y &&
    y <= canvas.max_y
  end
end
