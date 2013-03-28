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
