require 'schlepp/sink/data_object'

module Schlepp
  module Sink
    class Loader
      def initialize(writer, opts = {})
        @writer = writer

        @file = DataObject.new(writer)
      end

      def name
        @writer.name
      end

      def path
        @writer.path
      end

      def write(rows)
        Array(rows).each do |row|
          @file.write(row)
        end
      end

      def written
        @file.length
      end

      def finalize
        @file.finalize
      end
    end
  end
end
