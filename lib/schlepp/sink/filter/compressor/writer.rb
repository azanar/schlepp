require 'schlepp/sink/filter/compressor/stream'

module Schlepp
  class Sink
    class TableObject
      class Compressor
        class Writer
          def initialize(writer, opts = {})
            @stream = Stream.new
            @writer = writer
            @written = 0
          end

          def write(rows)
            Array(rows).each do |row|
              @written += row.length
              @stream.write(row)
            end
          end


          def rotate?
            false
          end

          def finalize
            bits = @stream.to_s

            @writer.write(bits)
            @writer.finalize
          end
        end
      end
    end
  end
end
