
#Car input module

module Car
  module Input
    class << self

      # Best price of car
      def read(file, items=nil)
        @file = file
        @labels = items   #Array of Items
        file_errors_any?
        Car::Search.new(@file,true)
      end

      private

      # checking error for input file
      def file_errors_any?
        raise Car::Error.file_type unless File.extname(@file) == ".txt"
        raise Car::Error.file_read unless File.exist? @file
      end
     end
  end
end


