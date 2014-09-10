require 'schlepp/sink/data_stream'

module Schlepp
  module Sink
    class DataObject
      def initialize(table_object)
        @stream = DataStream.new
        @table_object = table_object
      end

      def write(data)
        @stream.write(data)
      end

      def length
        @stream.length
      end

      def finalize
        @stream.finalize

        @table_object.write(@stream.to_s)
      end
    end
  end
end
