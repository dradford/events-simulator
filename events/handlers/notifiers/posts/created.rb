module Events
  module Handlers
    module Notifiers
      module Posts
        class Created
          def call(event)
            puts "Handlers::Notifiers::Posts::Created - Sending email notification because post with ID: #{event[:post_id]} was created"
          end
        end
      end
    end
  end
end
