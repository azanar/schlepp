require 'schlepp/sink/table_object/factory'
require 'schlepp/sink/table_object/writer/factory'

module Schlepp
  class Sink
    class TableObject
      class Carosel
        def initialize(factory, chain)
          @factory = factory
          @chain = chain
          @parts = []
          @current = rotate
          @finalized = false
        end

        def write(data)
          raise_if_finalized
          if rotate?(data)
            rotate
            if rotate?(data)
              raise
            end
          end
          Array(data).each do |r|
            @current.write(r)
          end
        end

        def finalize
          @current.finalize
          @finalized = true
          @parts
        end

        private

        def raise_if_finalized
          @finalized && raise
        end

        def rotate?(data)
          @chain.any?(&:should_rotate?)
        end

        def rotate
          @current.finalize if @current

          to = table_object_factory.new

          @parts << to

          builder = Schlepp::Sink::TableObject::Writer::Factory.new(@factory, @chain, to)

          @current = builder.new
        end

        private

        def table_object_factory
          @table_object_factory ||= Schlepp::Sink::TableObject::Factory.new(@factory, @chain)
        end
      end
    end
  end
end
