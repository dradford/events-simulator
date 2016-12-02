require 'active_support/notifications'
require 'pry'

require_relative 'events/parsers/generic'
require_relative 'events/parsers/jira'

require_relative 'events/handlers/notifiers/integrations/enabled'
require_relative 'events/handlers/notifiers/integrations/disabled'
require_relative 'events/handlers/notifiers/posts/created'
require_relative 'events/handlers/notifiers/posts/updated'
require_relative 'events/handlers/notifiers/comments/created'

require_relative 'events/handlers/integrations/jira/posts/created'
require_relative 'events/handlers/integrations/jira/posts/updated'
require_relative 'events/handlers/integrations/jira/comments/created'

require_relative 'events/handlers/outgoing_webhooks/posts/created'
require_relative 'events/handlers/outgoing_webhooks/posts/updated'
require_relative 'events/handlers/outgoing_webhooks/comments/created'

require_relative 'events/handlers/incoming_webhooks/comments/create'
require_relative 'events/handlers/incoming_webhooks/posts/update'

require_relative 'events/event'
require_relative 'events/incoming_webhook_event'
require_relative 'events/integration_event'
require_relative 'events/system_event'

module Simulator
  include Events

  def self.run
    puts '-----------------------------------------------------------------------------'
    puts 'Integrations'
    puts

    IntegrationEvent.subscribe 'integration.enabled', Handlers::Notifiers::Integrations::Enabled.new
    IntegrationEvent.subscribe 'integration.disabled', Handlers::Notifiers::Integrations::Disabled.new

    IntegrationEvent.fire(type: 'integration.enabled', integration_id: 'bb8b4c05-b2e9-4f08-9a87-b5efae6d7b58')
    puts
    IntegrationEvent.fire(type: 'integration.disabled', integration_id: 'c5ee57f2-3d3d-40df-bcef-8001bc3c035c')

    puts
    puts '-----------------------------------------------------------------------------'
    puts 'System'
    puts

    SystemEvent.subscribe 'post.created', Handlers::OutgoingWebhooks::Posts::Created.new
    SystemEvent.subscribe 'post.created', Handlers::Notifiers::Posts::Created.new
    SystemEvent.subscribe 'post.created', Handlers::Integrations::Jira::Posts::Created.new

    SystemEvent.subscribe 'post.updated', Handlers::OutgoingWebhooks::Posts::Updated.new
    SystemEvent.subscribe 'post.updated', Handlers::Notifiers::Posts::Updated.new
    SystemEvent.subscribe 'post.updated', Handlers::Integrations::Jira::Posts::Updated.new

    SystemEvent.subscribe 'comment.created', Handlers::OutgoingWebhooks::Comments::Created.new
    SystemEvent.subscribe 'comment.created', Handlers::Notifiers::Comments::Created.new
    SystemEvent.subscribe 'comment.created', Handlers::Integrations::Jira::Comments::Created.new

    SystemEvent.fire(type: 'post.created', post_id: rand(100).to_s)
    puts
    SystemEvent.fire(type: 'post.created', post_id: rand(100).to_s)

    puts
    puts '-----------------------------------------------------------------------------'
    puts 'Incoming Webhooks'
    puts

    IncomingWebhookEvent.subscribe 'comment.create', Handlers::IncomingWebhooks::Comments::Create.new
    IncomingWebhookEvent.subscribe 'post.update', Handlers::IncomingWebhooks::Posts::Update.new

    event = Parsers::Jira.parse(type: 'jira.comment.created', issue_id: rand(100).to_s, comment: 'Hi, world!')
    IncomingWebhookEvent.fire(event)
    puts
    event = Parsers::Jira.parse(type: 'jira.issue.updated', issue_id: rand(100).to_s, changes: { priority: :p1 })
    IncomingWebhookEvent.fire(event)
  end
end

Simulator.run
