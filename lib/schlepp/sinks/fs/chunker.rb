require 'schlepp/sinks/fs/table_object'
require 'schlepp/sink/chunker'

module Schlepp
  module Sink
    module Fs
      class Chunker
        def initialize(table_object, opts = {})
          @table_object = table_object
        end

        def sequence
          chunker.sequence
        end

        def next
          part = chunker.next 

          ts = Schlepp::Sink::Fs::TableObject.new(part)

          Schlepp::Sink::Loader.new(ts)
        end

        private

        def chunker
          @chunker ||= Schlepp::Sink::Chunker.new(@table_object)
        end
      end
    end
  end
end
