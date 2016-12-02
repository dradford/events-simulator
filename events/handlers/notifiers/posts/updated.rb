module Events
  module Handlers
    module Notifiers
      module Posts
        class Updated
          def call(event)
            puts "Handlers::Notifiers::Posts::Updated - Sending email notification because post with ID: #{event[:post_id]} was updated"
          end
        end
      end
    end
  end
end
