module Schlepp::IntegrationTest::Mock
  class Source
    def each
      1.upto(100).each do |x|
        yield [x.to_s]
      end
    end
  end
end
