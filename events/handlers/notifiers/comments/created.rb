module Events
  module Handlers
    module Notifiers
      module Comments
        class Created
          def call(event)
            puts "Handlers::Notifiers::Comments::Created - Sending email notification of comment creation on post with ID: #{event[:post_id]} Comment ID: #{event[:comment_id]} Comment: #{event[:comment]}"
          end
        end
      end
    end
  end
end
