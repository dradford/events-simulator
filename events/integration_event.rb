module Events
  class IntegrationEvent < Event
    self.adapter = NotificationAdapter
    self.backend = ActiveSupport::Notifications
    self.namespace = Namespace.new('integration_event', '.')
    self.event_parser = lambda { |params| Parsers::Generic.parse(params) }
  end
end
