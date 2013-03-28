module TL
	TL::Go = "Green"
	TL::Wait = "amber"
	TL::Stop = "red"
end
class TrafficLight
	include TL
	include Enumerable
	def each
    yield [true, false, false]
    yield [true, true, false]
    yield [false, false, true]
    yield [false, true, false]
  end
end
x = TrafficLight.new.map {|state| state }

puts x[3][0]
i = 0
while i<100
	puts x[i%4][(i%3)]
	i += 1
end



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
  j=0
  x = @traffic_light.map {|state| state }
  click do
    @top.bulb_colour(x[i%4][j%3])
    j+= 1
    @middle.bulb_colour(x[i%4][j%3])
    j +=1
    @bottom.bulb_colour(x[i%4][j%3])
    i +=1
    j +=1
    # case i%4
    #     when 1
    #   @bottom.bulb_colour(false)
    #   @top.bulb_colour(true)
    #   @middle.bulb_colour(true)
    #   when 2
    #    @bottom.bulb_colour(true)
    #   @top.bulb_colour(false)
    #   @middle.bulb_colour(false)
    # when 3
    #      @bottom.bulb_colour(false)
    #   @top.bulb_colour(false)
    #   @middle.bulb_colour(true)
    # else
    #    @bottom.bulb_colour(false)
    #   @top.bulb_colour(true)
    #   @middle.bulb_colour(false)
    # end

  end
end
