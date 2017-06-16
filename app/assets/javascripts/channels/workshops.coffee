App.workshops = App.cable.subscriptions.create "WorkshopsChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    active_workshop = $("[data-behavior='messages'][data-workshop-id='#{data.workshop_id}']")
    # Insert the message
    active_workshop.prepend("<div class='media'><div class='media-body'>#{data.body}</div></div>")

  send_message: (workshop_id, message) ->
    @perform "send_message", {workshop_id: workshop_id, body: message}