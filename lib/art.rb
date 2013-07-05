require_relative "art/version"
require_relative "art/segment"
require_relative "art/canvas"
require_relative "art/position"
# a = Art.new(20,40, File.new("./foo.canvas", "w+"))
# a = Art.new
# c = Canvas.new
# a = Art.new( c )
class Art
  START_POSITION = Position.new
  DEFAULT_CANVAS = Canvas.new
  DEFAULT_CHAR = '.'
  FOO = File.new("./foo.canvas", "w+")
  KEY_METHODS = [ :move_to, :line_to, :draw, :clear, :display ]

  attr_reader :current_position
  def initialize(canvas=DEFAULT_CANVAS)
    @canvas = canvas
    reset_position
  end

  def key_methods
    KEY_METHODS
  end

  def display(to=nil)
    to = STDOUT if to.nil?
    to = FOO if to == :foo
    canvas.render to
  end
  # alias_method :display, :unveil

  def move_to x, y
    if !within_bounds?( x, y )
      raise RuntimeError, "Out of bounds: #{x.inspect}, #{y.inspect}"
    end

    set_position Position.new( x, y )
  end

  def line_to x, y, char=DEFAULT_CHAR
    if !within_bounds?( x, y )
      raise RuntimeError, "Out of bounds: #{x.inspect}, #{y.inspect}"
    end

    destination_position = Position.new(x, y)
    canvas.points_on_line( current_position, destination_position ).each do |at|
      draw( char, at )
    end
    set_position destination_position
  end

  def draw( pixel, at=current_position )
    canvas.draw( pixel, at )
  end

  def clear
    canvas.clear
    reset_position
  end

  private
  attr_accessor :canvas

  def set_position target
    @current_position = target
  end

  def reset_position
    @current_position = START_POSITION
  end

  def max_y
    canvas.max_y
  end

  def max_x
    canvas.max_x
  end

  def min_y
    canvas.min_y
  end

  def min_x
    canvas.min_x
  end

  def within_bounds?( x, y )
    min_x <= x &&
    x <= max_x &&
    min_y <= y &&
    y <= max_y
  end

end
