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
    x = x.to_i; y = y.to_i
    if !within_bounds?( x, y )
      raise RuntimeError, "Out of bounds: #{x.inspect}, #{y.inspect}"
    end

    self.current_position = Position.new( x, y )
  end

  def line_to x, y, char=DEFAULT_CHAR
    x = x.to_i; y = y.to_i
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
    pace = Float(pace) if pace
    message.split(//).each do |char|
      at.increment_x
      if within_bounds?( *at.to_a )
        draw(char, at)
        if pace
          display
          sleep( pace )
        end
      end
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

  def ride_to(destination_x, pace=0.3)
    destination_x = destination_x.to_i
    pace = Float(pace)
    
    current_y = current_position.y
    current_x = current_position.x
    distance = destination_x - current_x
    distance = -distance if distance < 0
    (0..distance).each do |peddle|
      if peddle > 1
        bike( current_x + (peddle - 1), current_y, 'blank_fast' )
        bike( current_x + peddle, current_y, 'fast' )
        pace = pace - 0.1
        pace = 0.1 if pace < 0.1
      elsif peddle > 0
        bike( current_x + (peddle - 1), current_y, 'blank' )
        bike( current_x + peddle, current_y, 'fast' )
      else
        bike( current_x + peddle, current_y )
      end
      display
      sleep(pace)
    end
  end

  #def blank_bike(x, y)
  #  move_to(x, y)
  #  write blank_bike_line_one
  #  move_to(x, y+1)
  #  write blank_bike_line_two
  #  move_to(x, y+2)
  #  write blank_bike_line_three
  #end

  def bike(x, y, type=nil)
    x = x.to_i; y = y.to_i
    move_to(x, y)
    method_name = type.nil? ? :bike_line_one : :"#{type}_bike_line_one"
    method = method(method_name)
    write method.call
    move_to(x, y+1)
    method_name = type.nil? ? :bike_line_two : :"#{type}_bike_line_two"
    method = method(method_name)
    write method.call
    move_to(x, y+2)
    #write bike_line_three
    method_name = type.nil? ? :bike_line_three : :"#{type}_bike_line_three"
    method = method(method_name)
    write method.call
  end

  def blank_bike_line_one
    '       '
  end

  def blank_bike_line_two
    '        '
  end

  def blank_bike_line_three
    '         '
  end

  def bike_line_one
    '    __o'
  end

  def bike_line_two
    ['  _ \<,_', '  -\<,' ][rand(2)]
  end

  def bike_line_three
    ['(_)/  (_)', 'O / O'][rand(2)]
  end

  def fast_bike_line_one
    ' ____   __o'
  end

  def fast_bike_line_two
    [ '____  _-\_<,', '____  _ \<,_', '____    -\<,' ][rand(3)]
  end

  def fast_bike_line_three
    # ["     (*)/'(*)", '      O / O'][rand(2)]
    "     (*)/'(*)"
  end

  def blank_fast_bike_line_one
    '           '
  end

  def blank_fast_bike_line_two
    '            '
  end

  def blank_fast_bike_line_three
    '             '
  end

  # height = 4
  # width = 2
  # start in lower-left
  def triangle(start_x, start_y, width, height, char=DEFAULT_CHAR)
    start_x = start_x.to_i; start_y = start_y.to_i
    width = width.to_i; height = height.to_i
    move_to(start_x, start_y)
    line_to(start_x + 2 * width, start_y, char)
    line_to(start_x + width, start_y - height, char)
    line_to(start_x, start_y, char)
  end
  def square(start_x, start_y, width, height, char=DEFAULT_CHAR)
    start_x = start_x.to_i; start_y = start_y.to_i
    width = width.to_i; height = height.to_i
    move_to(start_x, start_y)
    line_to(start_x + width, start_y, char)
    line_to(start_x + width,start_y + height, char)
    line_to(start_x,start_y + height, char)
    line_to(start_x, start_y, char)
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
