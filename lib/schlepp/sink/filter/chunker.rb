require 'schlepp/sink/table_object/filter/observer'
require 'schlepp/sink/table_object/filter/writer'
module Schlepp
  class Sink
    module Filter
      class Chunker
        class Builder
          def initialize(observer)
            @observer = observer
          end

          def new(writer)
            Schlepp::Sink::TableObject::Filter::Writer.new(writer, @observer)
          end
        end
        def initialize(opts = {})
          @chunk = 0
          @chunk_size = opts[:chunk_size] || 100000
          @observer = Schlepp::Sink::TableObject::Filter::Observer.new
        end

        def extension
          @chunk.to_s
        end

        def should_rotate?
          @observer.count > @chunk_size
        end

        def rotate
          @chunk += 1
        end

        def writer
          @builder ||= Builder.new(@observer)
        end
      end
    end
  end
end
