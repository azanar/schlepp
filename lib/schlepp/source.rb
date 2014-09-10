module Schlepp
  module Source
    module_function

    def new(source)
      Schlepp::Source::CSV.new(source)
    end
  end
end
