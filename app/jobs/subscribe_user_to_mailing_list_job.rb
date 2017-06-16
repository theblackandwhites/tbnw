class SubscribeUserToMailingListJob < ApplicationJob
  queue_as :default

  	def perform(user)
  	 	gibbon = Gibbon::Request.new(api_key: "0a9ffb6db9a6a723e4f0841f18dc3636-us15")
		gibbon.timeout = 30
		gibbon.open_timeout = 30
		gibbon.lists("96883246ad").members.create(body: {email_address: user.email, status: "subscribed", merge_fields: {FNAME: user.first_name, LNAME: user.last_name}})
	end
end
