module Events
  module Parsers
    module Generic
      class << self
        def parse(event)
          case event[:type]
          when 'generic.comment.created'
            { type: 'comment.created', comment: event[:comment] }
          when 'generic.post.updated'
            { type: 'post.updated', changes: event[:changes] }
          when 'generic.post.state_changed'
            { type: 'post.transitioned', substate: event[:substate] }
          else
            event
          end
        end
      end
    end
  end
end
