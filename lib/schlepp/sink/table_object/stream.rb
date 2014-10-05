module Schlepp
  class Sink
    class TableObject
      class Stream
        def initialize(table_object_writer)
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
end
