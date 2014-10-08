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

          builder = Schlepp::Sink::TableObject::Factory.new(@factory, @chain)

          to = builder.new

          @parts << to

          builder = Schlepp::Sink::TableObject::Writer::Factory.new(@factory, @chain, to)

          @current = builder.new
        end
      end
    end
  end
end
