module Events
  module Handlers
    module Notifiers
      module Integrations
        class Enabled
          def call(event)
            puts "Handlers::Notifiers::Integrations - Integration with ID: #{event[:integration_id]} was enabled"
          end
        end
      end
    end
  end
end
