module Events
  module Parsers
    module Jira
      class << self
        def parse(event)
          post_id = rand(100).to_s
          puts "Jira::EventParser - Found post with ID: #{post_id} for Jira issue with ID: #{event[:issue_id]}"
          case event[:type]
          when 'jira.comment.created'
            { type: 'comment.create', post_id: post_id, comment: event[:comment] }
          when 'jira.issue.updated'
            { type: 'post.update', post_id: post_id, changes: event[:changes] }
          when 'jira.issue.state_changed'
            { type: 'post.transition', post_id: post_id, substate: event[:substate] }
          end
        end
      end
    end
  end
end
