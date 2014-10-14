require 'schlepp/sink/filter/chunker'

module Schlepp::IntegrationTest::Mock
  class Factory
    def initialize(model, verifier)
      @model = model
      @verifier = verifier
    end

    def url
      URI("http://www.example.com/")
    end
    
    def model
      @model
    end

    def writer(to)
      Writer.new(to, @verifier)
    end
  end
  class Writer
    def initialize(table_object, verifier)
      @table_object = table_object
      @verifier = verifier
    end

    def write(data)
      @verifier.write(data)
    end
    def finalize
      @verifier.finalize
    end
  end
  class Sink
    def initialize(model, verifier)
      @model = model
      @factory = Factory.new(@model, verifier)
      @sink = Schlepp::Sink.new(@model, @factory, [Schlepp::Sink::Filter::Chunker.new])
    end

    def write(data)
      @sink.write(data)
    end

    def finalize
      @sink.finalize
    end
  end
end

