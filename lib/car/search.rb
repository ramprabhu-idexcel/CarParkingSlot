require 'json'

module Car
  class Search

    def	initialize(file=nil,file_present=false)
      @file = file
      @car_slots = {}
      @count = 0
      @slot_no_arr = []
      parse_file  if file_present #Parsing file data
    end

    def store_find_detail(arg)
      @arg = arg.chomp
      case
        when @arg.include?("create_parking_lot")
          create_parking_lot
        when @arg.include?("park")
          allocate_slot
        when @arg.include?("leave")
          cancel_slot
        when @arg.include?("status")
          slot_status
        when @arg.include?("registration_numbers_for_cars_with_colour")
          registration_numbers_for_cars_with_colour
        when @arg.include?("slot_numbers_for_cars_with_colour")
          slot_numbers_for_cars_with_colour
        when @arg.include?("slot_number_for_registration_number")
          slot_number_for_registration_number
        else
          puts 'Mismatching values...'
      end
    end

    private

    # Parses each row of the text file for data serialization
    def	parse_file
      File.open( @file ).each do |f|
        f.each_line do |line|
          store_find_detail(line)
        end
      end
    end

    # creating a parking lot
    def create_parking_lot
      begin
        @total_parking_lot = @arg.split(" ")[1]
        raise "Invalid parking lots" if @total_parking_lot.empty?
        puts "Created a parking lot with #{@total_parking_lot.to_i} slots"
      rescue Exception => e
         puts "#{e.message}"
      end
    end

    # allocating slot number for car
    def allocate_slot
      @count = @count + 1
      car_no = @arg.split(" ")[1]
      car_color = @arg.split(" ")[2]
      if @car_slots.count.to_i == @total_parking_lot.to_i
        puts "Sorry, parking lot is full"
      else
        store_slot_no(car_no,car_color)
      end
    end

    def store_slot_no(car_no,car_color)
      @car_slots.keys.collect {|key| @slot_no_arr << key.split("_")[1].to_i}
      @slot_no_arr.uniq!
      (1..@total_parking_lot.to_i).each do |slot|
        unless @slot_no_arr.include?(slot)
          @car_slots.merge!({"lot_#{slot}" => {"car_no" => car_no, "color" => car_color} })
          puts "Allocated slot number: #{slot}"
          break
        end
      end
    end

    #cancellation of slot
    def cancel_slot
      @car_slots = JSON.parse(@car_slots.to_s.gsub("=>", ":"))
      slot_no = @arg.split(" ")[1]
      if slot_no
        @car_slots.delete("lot_#{slot_no}")
        @slot_no_arr.delete(slot_no.to_i)
        puts "Slot number #{slot_no} is free"
      else
        puts "Invalid slot number"
      end
    end

    #Total slot status
    def slot_status
      if @car_slots
        puts "Slot No. Registration No Colour"
        @car_slots.collect {|key,value| print key.split("_")[1]+" "; print value["car_no"]+" "; print value["color"]+"\n"}
      else
        puts "Data is empty!"
      end
    end

    #Registration numbers for all cars with specified color
    def registration_numbers_for_cars_with_colour
      color = @arg.split(" ")[1]
      if color
        @car_slots.collect {|slot,detail| print detail["car_no"]+" " if detail["color"] == color }
        print "\n"
      else
        puts "Invalid color"
      end
    end

    #Car slot number with color
    def slot_numbers_for_cars_with_colour
      color = @arg.split(" ")[1]
      if color
        @car_slots.collect {|slot,detail| print slot.split("_")[1]+" " if detail["color"] == color }
        print "\n"
      else
        puts "Invalid color"
      end
    end

    #Car slot number & registration number
    def slot_number_for_registration_number
      @slot_available = false
      car_number = @arg.split(" ")[1]
      @car_slots.each do |slot,detail|
        if detail["car_no"].to_s == car_number.to_s
          @slot_available = true
          puts slot.split("_")[1]
        end
      end
      puts "Not found" unless @slot_available
    end

  end
end