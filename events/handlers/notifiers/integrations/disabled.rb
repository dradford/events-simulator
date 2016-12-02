module Events
  module Handlers
    module Notifiers
      module Integrations
        class Disabled
          def call(event)
            puts "Handlers::Notifiers::Integrations - Integration with ID: #{event[:integration_id]} was disabled"
          end
        end
      end
    end
  end
end
