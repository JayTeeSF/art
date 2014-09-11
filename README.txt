irb -r "./lib/art.rb"
art = Art.new; 0
art.clear

# draw a (rectangle-looking) square:
art.move_to(1,0)
art.line_to(3,0)
art.line_to(3,2)
art.line_to(1,2)
art.line_to(1,0)

# be sure to stretch your screen 80-chars wide x 25-chars high
art.display

# ascii chars taken from i-net:
# e.g. http://ascii.co.uk/art/stickman
