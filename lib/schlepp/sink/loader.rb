require 'schlepp/sink/data_object'

module Schlepp
  module Sink
    class Loader
      def initialize(table_object, opts = {})
        @table_object = table_object

        @file = DataObject.new(table_object)
      end

      def name
        @table_object.name
      end

      def path
        @table_object.path
      end

      def write(rows)
        rows.each do |row|
          @file.write(row)
        end
      end

      def written
        @file.length
      end

      def finalize
        @file.finalize
        @table_object
      end
    end
  end
end
