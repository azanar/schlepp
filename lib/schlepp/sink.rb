require 'schlepp/sink/table_object/carosel'

module Schlepp
  class Sink
    def initialize(model, factory, filters)
      @model = model
      @carosel = TableObject::Carosel.new(factory, filters)
    end

    def name
      @model.name
    end

    def write(data)
      @carosel.write(data)
    end

    def finalize
      @carosel.finalize
    end
  end
end

