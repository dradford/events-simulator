module Events
  module Handlers
    module OutgoingWebhooks
      module Comments
        class Created
          def call(event)
            puts "Handlers::OutgoingWebhooks::Comments::Created - Triggering outgoing webhook because comment created on post with ID: #{event[:post_id]} Comment ID: #{event[:comment_id]} Comment: #{event[:comment]}"
          end
        end
      end
    end
  end
end
