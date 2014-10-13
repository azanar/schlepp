require 'schlepp/sink/filter/chunker'

module Schlepp::IntegrationTest::Mock
  class Factory
    def initialize(model, observer)
      @model = model
      @observer = observer
    end

    def url
      URI("http://www.example.com/")
    end
    
    def model
      @model
    end

    def writer(to)
      Writer.new(to, @observer)
    end
  end
  class Writer
    def initialize(table_object, observer)
      @table_object = table_object
      @observer = observer
    end

    def write(data)
      @observer.write(data)
    end
    def finalize
      @observer.finalize
    end
  end
  class Sink
    def initialize(model, observer)
      @model = model
      @factory = Factory.new(@model, observer)
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

