module Events
  module Handlers
    class IncomingWebhooks
      class Comments
        class Create
          def call(event)
            comment_id = rand(100).to_s
            puts "Handlers::IncomingWebhooks::Comments::Create - Created a comment with ID: #{comment_id} on post with ID: #{event[:post_id]} Comment: #{event[:comment]}"
            SystemEvent.fire(type: 'comment.created', post_id: event[:post_id], comment_id: comment_id, comment: event[:comment])
          end
        end
      end
    end
  end
end
