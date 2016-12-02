module Events
  module Handlers
    module Integrations
      module Jira
        module Comments
          class Created
            def call(event)
              puts "Handlers::Integrations::Jira::Comments::Created - Sending up to Jira comment created on post with ID: #{event[:post_id]} Comment ID: #{event[:comment_id]} Comment: #{event[:comment]}"
            end
          end
        end
      end
    end
  end
end
