module Events
  module Handlers
    module OutgoingWebhooks
      module Posts
        class Created
          def call(event)
            puts "Handlers::OutgoingWebhooks::Posts::Created - Triggering outgoing webhook because post with ID: #{event[:post_id]} was created"
          end
        end
      end
    end
  end
end
