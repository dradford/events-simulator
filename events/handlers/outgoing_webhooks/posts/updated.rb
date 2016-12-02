module Events
  module Handlers
    module OutgoingWebhooks
      module Posts
        class Updated
          def call(event)
            puts "Handlers::OutgoingWebhooks::Posts::Updated - Triggering outgoing webhook because post with ID: #{event[:post_id]} was updated"
          end
        end
      end
    end
  end
end
