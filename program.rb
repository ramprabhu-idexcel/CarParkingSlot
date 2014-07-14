require File.dirname(__FILE__) + '/lib/car.rb'

if ARGV.length == 1
   Car::Input.read(ARGV[0])
else
   car_obj = Car::Search.new
   puts "Enter the input:"
   200.times do
     user_input = STDIN.gets.chomp
     car_obj.store_find_detail(user_input)
     puts "Do you want to continue? type yes/no"
     name=gets.chomp
     break if name=="no"
   end
end



