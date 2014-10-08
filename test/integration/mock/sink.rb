module Schlepp::IntegrationTest::Mock
  class Sink
    def write(data)
    end

    def finalize
      parts
    end

    def parts
      []
    end
  end
end

