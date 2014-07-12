
#Car input module

module Car
  module Input
    class << self

      # Best price of car
      def read(file, items)
        @file = file
        @labels = items   #Array of Items
        file_errors_any? 
      end

      private

      # checking error for input file
      def file_errors_any?
        raise Car::Error.file_read unless File.exist? @file
        raise Car::Error.file_type unless File.extname(@file) == ".txt"
      end
     end
  end
end


