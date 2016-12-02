module Events
  class SystemEvent < Event
    self.adapter = NotificationAdapter
    self.backend = ActiveSupport::Notifications
    self.namespace = Namespace.new('system_event', '.')
    self.event_parser = lambda { |params| Parsers::Generic.parse(params) }
  end
end
