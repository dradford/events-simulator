module Events
  module Handlers
    module Integrations
      module Jira
        module Posts
          class Updated
            def call(event)
              puts "Handlers::Integrations::Jira::Posts::Updated - Sending up to Jira post with ID: #{event[:post_id]} was updated"
            end
          end
        end
      end
    end
  end
end
