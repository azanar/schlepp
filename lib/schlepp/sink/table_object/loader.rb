require 'schlepp/sink/table_object/compressor/writer'

module Schlepp
  class Sink
    class TableObject
      class Loader
        def initialize(sink, writer, opts = {})
          #@writer = Writer.new(writer)
          @sink = sink
          @writer = writer
        end

        def name
          @writer.name
        end

        def write(rows)
          Array(rows).each do |row|
            @writer.write(row)
          end
        end

        def written
          @writer.written
        end

        def finalize
          @writer.finalize
        end
      end
    end
  end
end
