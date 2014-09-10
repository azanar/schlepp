require 'zlib'

module Schlepp
  module Sink
    class DataStream
      def initialize
        @buffer = StringIO.new("", "rb+")
        @compressor = Zlib::GzipWriter.new(@buffer)
        @dead = false
      end

      def write(data)
        if @dead
          raise "Stream has been dumped. No more writing permitted."
        end
        @compressor << data
      end

      def length
        if @dead
          raise "Stream has been dumped. No more writing permitted."
        end
        @compressor.pos
      end

      def finalize
        if !@dead
          @compressor.close
          @dead = true
        end
      end

      def to_s
        finalize
        @buffer.string
      end
    end
  end
end
