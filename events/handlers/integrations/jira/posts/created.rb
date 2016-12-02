module Events
  module Handlers
    module Integrations
      module Jira
        module Posts
          class Created
            def call(event)
              puts "Handlers::Integrations::Jira::Posts::Created - Sending up to Jira post with ID: #{event[:post_id]} was created"
            end
          end
        end
      end
    end
  end
end
