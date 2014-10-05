module Schlepp
  class Sink
    module Sequencer
      DEFAULT_CHUNK_SIZE = 50 * 1024 * 1024 # 50 MB
      def initialize(model, opts = {})
        @model = model
        @chunker = chunker.new(model)
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
