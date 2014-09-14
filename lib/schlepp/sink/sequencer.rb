module Schlepp
  module Sink
    module Sequencer
      DEFAULT_CHUNK_SIZE = 50 * 1024 * 1024 # 50 MB
      def initialize(table_object, opts = {})
        @table_object = table_object
        @chunker = chunker.new(table_object)
        @chunk_size = opts[:chunk_size] || DEFAULT_CHUNK_SIZE
      end

      def write(rows)
        rows.each do |row|
          if loader.written + row.length > @chunk_size
            rotate
          end
          loader.write(row)
        end
      end

      def parts
        @chunker.parts
      end

      def finalize
        loader.finalize
      end

      private

      def loader
        @loader ||= rotate
      end

      def rotate
        if @loader
          @loader.finalize
        end
        @loader = @chunker.next
      end
    end
  end
end
