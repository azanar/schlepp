require 'hydrogen/table_object/part'
require 'hydrogen/table_object/part/sequence'

module Schlepp
  class TableObject
    class Chunker
      def initialize(table_object, opts = {})
        @table_object = table_object
        @chunk = 0
        @parts = []
      end

      attr_reader :parts

      def sequence
        Hydrogen::TableObject::Part::Sequence.new(@table_object, parts)
      end

      def parts
        @parts
      end

      def next
        @chunk += 1
        part = Hydrogen::TableObject::Part.new(@chunk, @table_object)

        @parts << part

        part
      end
    end
  end
end
