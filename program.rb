require File.dirname(__FILE__) + '/lib/car.rb'

if ARGV.length == 1
   Car::Input.read(ARGV[0])
else
   car_obj = Car::Search.new
   200.times do
     puts "Please enter the input:"
     user_input = STDIN.gets.chomp
     car_obj.store_find_detail(user_input)
     print "\n"
     print "Do you want to continue? type yes/no: "
     name=gets.chomp
     break if name=="no"
     print "\n"
   end
end



