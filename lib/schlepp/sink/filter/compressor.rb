require 'schlepp/sink/filter'
require 'schlepp/sink/table_object/compressor/writer'

module Schlepp
  class Sink
    module Filter
      class Compressor
        include Schlepp::Sink::Filter::Static
        def extension
          'gz'
        end

        def writer
          Schlepp::Sink::TableObject::Compressor::Writer
        end
      end
    end
  end
end

