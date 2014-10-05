module Schlepp
  class Sink
    module Adapter
      class Compressor
        def initialize(table_object, opts = {})
          @table_object = table_object
        end

        def extension
          'gz'
        end

        def writer
          Schlepp::Sink::TableObject::Compressor::Writer
        end

        def chunker
          @chunker ||= Schlepp::TableObject::Chunker.new(@table_object)
        end
      end
    end
  end

end

