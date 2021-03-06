module TL
  TL::Go = "#00FF30"
  TL::Wait = "#FFFC00"
  TL::Stop = "#FF0000"
end

class TrafficLight  
  include Enumerable
  include TL
  def each
    yield [true, false, false]
    yield [true, true, false]
    yield [false, false, true]
    yield [false, true, false]
  end
end

class Bulb < Shoes::Shape
  attr_accessor :stack
  attr_accessor :left
  attr_accessor :top
  attr_accessor :switched_on
  attr_accessor :color
  include TL
  
  def initialize(stack, left, top, color, switched_on = false)    
    self.stack = stack
    self.left = left    
    self.top = top
    self.switched_on = switched_on
    self.color = color
    bulb_colour(switched_on)
  end
  
  # HINT: Shouldn't need to change this method
  def draw(left, top, colour)    
    stack.app do
      fill colour
      stack.append do
        oval left, top, 50
      end
    end
  end
  
  def bulb_colour(switched_on)
    x = unless switched_on
        "#999999"
      else
        color
    end
    draw left, top, x
  end  
end

Shoes.app :title => "My Amazing Traffic Light", :width => 150, :height => 250 do
  background "000", :curve => 10, :margin => 25  
  stroke black    
  
  @traffic_light = TrafficLight.new
  @top = Bulb.new self, 50, 40, TL::Stop, true     
  @middle = Bulb.new self, 50, 100, TL::Wait, false
  @bottom = Bulb.new self, 50, 160, TL::Go, false
  
  i=1
  x = @traffic_light.map {|state| state }
  click do
    @top.bulb_colour(x[i%4][0])
    @middle.bulb_colour(x[i%4][1])
    @bottom.bulb_colour(x[i%4][2])
    i +=1
  end
end
