module Events
  class Event
    class << self
      attr_accessor :adapter, :backend, :namespace, :event_parser

      def fire(payload)
        event = event_parser.call(payload)
        backend.instrument namespace.call(event[:type]), event if event
      end

      def listeners_for(name)
        namespaced_name = namespace.call(name)
        backend.notifier.listeners_for(namespaced_name)
      end

      def subscribe(name, callable = Proc.new)
        backend.subscribe namespace.to_regexp(name), adapter.build(callable)
      end
    end

    # Create a namespace to generate a regex for passing in to ActiveSupport::Notifications.subscribe
    #
    # http://api.rubyonrails.org/classes/ActiveSupport/Notifications.html
    # ActiveSupport::Notifications.subscribe(/render/) do |*args|
    #   ...
    # end
    #
    class Namespace < Struct.new(:value, :delimiter)
      def call(name = nil)
        "#{value}#{delimiter}#{name}"
      end

      def to_regexp(name = nil)
        %r{^#{Regexp.escape call(name)}}
      end
    end

    # NotificationAdapter
    #
    # Wraps block / callable, passing through just the
    # event payload to the callable
    #
    # See this post for Struct trickery:
    # http://blog.steveklabnik.com/posts/2012-09-01-random-ruby-tricks--struct-new
    class NotificationAdapter < Struct.new(:subscriber)
      # Pass in our block, or class that responds to .call
      # This callable is what actually processes the event
      # e.g.
      #
      #    NotificationAdapter.call(EventHandlers::CommentCreated.new)
      #
      def self.build(callable)
       new(callable)
      end

      # Tear out unneeded args
      #   - From: call(name, started, finished, unique_id, payload)
      #   - To: call(payload)
      #
      #   subscriber is set when new(callable) is called above. The
      #   instance variable comes from the inheritance from
      #   Struct.new(:subscriber)
      #
      def call(*args)
       payload = args.last
       subscriber.call(payload)
      end
    end

    # Set up the adapter, backend and callable
    self.adapter = NotificationAdapter
    self.backend = ActiveSupport::Notifications
    self.namespace = Namespace.new('jira_event', '.')
    self.event_parser = lambda { |params| Parsers::Generic.parse(params) }
  end
end
