class WorkshopsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "workshops"
  end

  def unsubscribed
    stop_all_streams
  end

  def send_message(data)
  	@workshop = Workshop.find_by_id(data["workshop_id"])
  	message = @workshop.messages.create(body: data["body"], user_id: current_user.id )
  	MessageRelayJob.perform_later(message)
  end
end
