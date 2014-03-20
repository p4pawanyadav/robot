class Robot
  attr_reader :location
  attr_reader :orientation

 
  ORIENTATIONS  = [:north, :east, :south, :west]
  COMMANDS      = [:place, :move, :left, :right, :report]

  def initialize(x_size, y_size)
    @x_size = x_size 
    @y_size = y_size
    set_orientation :north
  end

  def place(x=0, y=0, o=:north)
    if valid_location?(x, y) && valid_orientation?(o)
      set_location x, y
      set_orientation o
    else
      nil
    end
  end
  
  def report
    return nil if not_placed?
    [location, orientation].flatten.map(&:to_s).join(',')
  end
  
  def move
    return nil if not_placed?
    if can_move?
      set_location *next_location
    end
  end
  
  def right
    return if not_placed?
    turn(:right)
  end
  
  def left
    return if not_placed?
    turn(:left)
  end
  
  def set_orientation(o)
    @orientation = o
  end
  
  def valid_orientation?(o)
    ORIENTATIONS.include?(o)
  end
  
  def set_location(x, y)
    @location = [x,y]
  end

  def valid_location?(x, y)
    return unless x.is_a?(Integer) && y.is_a?(Integer)
    x.between?(0, @x_size - 1) && y.between?(0, @y_size - 1)
  end
  
  def next_location
    options = {
      north: [location[0], location[1] + 1],
      south: [location[0], location[1] - 1],
      east: [location[0] + 1, location[1]],
      west: [location[0] - 1, location[1]]
    }
   #puts "from next "
   #puts orientation
   #puts location[0]
   #puts location[1]
   #puts options[orientation]
   options[orientation]
  end
  
  def can_move?
   # puts valid_location?(*next_location)
    if(valid_location?(*next_location)==false)
    puts "Invalid location"
    end
    valid_location?(*next_location)
  end

  def turn(dir)
    options = { right: [1, 2, 3, 0], left: [3, 0, 1, 2] }
    index = ORIENTATIONS.index(orientation)
    #puts index
    set_orientation ORIENTATIONS[options[dir][index]]
    #puts ORIENTATIONS[options[dir][index]]
  end

  def not_placed?
    location == nil
  end
end
