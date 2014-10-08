
module Schlepp
  class Sink
    class TableObject
        class Factory
          def initialize(factory, components)
            @factory = factory
            @components = components
          end

          def new
            @components.each(&:rotate)

            url = @components.inject(@factory.url) do |u, f|
              u.merge("#{u.path}.#{f.extension}")
            end

            Hydrogen::TableObject.new(@factory.model, url)
          end

          def writer
            Writer::Factory.new(@factory, @components, self.new).new
          end
        end
    end
  end
end
