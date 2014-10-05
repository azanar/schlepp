require 'schlepp/sink/loader'
require 'schlepp/table_object/chunker'

module Schlepp
  class Sink
    class Compressor
      def initialize(table_object, opts = {})
        @table_object = table_object
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

