Stripe.api_key = ENV['stripe_seceret_key']
require 'gibbon'

class SucceededCharges 
	def call(event)


		charge = event.data.object
		@user = User.where(stripe_id: charge.customer).last

		@user.update_attributes(
			suspended: false, 
			credit_card_type: charge.source.brand, 
			credit_card_exp_month: charge.source.exp_month, 
			credit_card_exp_year: charge.source.exp_year, 
			credit_card_last_4: charge.source.last4
			)

		@user.save

		@charge = Charge.new
		@charge.stripe_charge_id = charge.id
		@charge.amount = charge.amount
		@charge.user_id = @user.id
		@charge.credit_card_type = charge.source.brand
		@charge.credit_card_exp_month = charge.source.exp_month
		@charge.credit_card_exp_year = charge.source.exp_year
		@charge.credit_card_last_4 = charge.source.last4
		@charge.save

		gibbon = Gibbon::Request.new(api_key: "0a9ffb6db9a6a723e4f0841f18dc3636-us15")
		gibbon.timeout = 30
		gibbon.open_timeout = 30
		gibbon.lists("4c140da556").members.create(body: {email_address: @user.email, status: "subscribed", merge_fields: {FNAME: @user.first_name, LNAME: @user.last_name}})

	end
end 

class FailedCharges 
	def call(event)
		charge = event.data.object
		
		@user = User.where(stripe_id: charge.customer).last
		@user.update_attributes(:suspended => true)
		@user.save

	end
end 

class DeletedSubscription 
	def call(event)
		charge = event.data.object
		@user = User.where(stripe_id: charge.customer).last
		@user.destroy
	end
end 

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', SucceededCharges.new
  events.subscribe 'charge.failed', FailedCharges.new
  events.subscribe 'customer.subscription.delete', DeletedSubscription.new

  
end