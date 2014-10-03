require 'schlepp/sink/chunker'

require 'schlepp/sinks/fs/table_object'
require 'schlepp/sinks/fs/table_object/writer'

module Schlepp
  module Sink
    module Fs
      class Chunker
        def initialize(table_object, opts = {})
          @table_object = table_object
          @parts = []
        end

        attr_accessor :parts

        def sequence
          chunker.sequence
        end

        def parts
          chunker.parts
        end

        def next
          part = chunker.next 

          table_obj = Schlepp::Sink::Fs::TableObject.new(part)

          @parts << table_obj

          writer = Schlepp::Sink::Fs::TableObject::Writer.new(table_obj)

          Schlepp::Sink::Loader.new(writer)
        end

        private

        def chunker
          @chunker ||= Schlepp::TableObject::Chunker.new(@table_object)
        end
      end
    end
  end
end
