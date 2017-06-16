class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "workshops",{
    email: message.user.email,
    body: MessagesController.render(message),
    workshop_id: message.workshop.id
    }
  end

end
