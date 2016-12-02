module Events
  module Handlers
    class IncomingWebhooks
      class Posts
        class Update
          def call(event)
            puts "Handlers::IncomingWebhooks::Posts::Update - Updated post with ID: #{event[:post_id]} Changes: #{event[:changes]}"
            SystemEvent.fire(type: 'post.updated', post_id: event[:post_id], changes: event[:changes])
          end
        end
      end
    end
  end
end
