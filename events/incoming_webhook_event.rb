module Events
  class IncomingWebhookEvent < Event
    self.adapter = NotificationAdapter
    self.backend = ActiveSupport::Notifications
    self.namespace = Namespace.new('incoming_webhook_event', '.')
    self.event_parser = lambda { |pre_parsed_event| pre_parsed_event }
  end
end
