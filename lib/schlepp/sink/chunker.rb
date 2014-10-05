require 'schlepp/sink/table_object/loader'
require 'schlepp/sink/table_object/chunker'

module Schlepp
  class Sink
    module Adapter
      class Compressor
        def initialize(table_object, opts = {})
          @table_object = table_object
        end

        def sequence
          chunker.sequence
        end

        def parts
          chunker.parts
        end

        def next
          chunker.next 
        end

        private

        def chunker
          @chunker ||= Schlepp::TableObject::Chunker.new(@table_object)
        end
      end
    end
  end

end
