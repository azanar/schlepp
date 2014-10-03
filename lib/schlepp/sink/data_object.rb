require 'schlepp/sink/data_stream'

module Schlepp
  module Sink
    class DataObject
      def initialize(table_object_writer)
        @stream = DataStream.new
        @table_object_writer = table_object_writer
      end

      def write(data)
        @stream.write(data)
      end

      def length
        @stream.length
      end

      def finalize
        @stream.finalize

        @table_object_writer.write(@stream.to_s)
      end
    end
  end
end
